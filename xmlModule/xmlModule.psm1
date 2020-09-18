Function New-XmlDocument
{
    [CmdletBinding()]
    Param
    (
    [string]$Root,
    [string[]]$Elements
    )
    Begin
    {
        [System.Xml.XmlDocument]$xDoc = New-Object System.Xml.XmlDocument
        [System.Xml.XmlElement]$xRoot = $xDoc.CreateElement($Root)
        $Result = $xDoc.AppendChild($xRoot)
        Write-Verbose $Result.OuterXml
        $xDocElement = $xDoc.DocumentElement
        }
    Process
    {
        foreach ($Element in $Elements)
        {
            [System.Xml.XmlElement]$xElement = $xDoc.CreateElement($Element)
            $Result = $xDocElement.AppendChild($xElement)
            Write-Verbose $Result.OuterXml
            }
        }
    End
    {
        return $xDoc
        }
    }
Function Add-XmlElement
{
    [CmdletBinding()]
    Param
    (
    [System.Xml.XmlDocument]$xDoc,
    [string]$Node,
    [System.Xml.XmlElement[]]$Element
    )
    Begin
    {
        $xNode = $xDoc.GetElementsByTagName($Node)
        foreach ($xn in $xNode)
        {
            #
            # More than one element returned, add to the empty one
            #
            if ($xn.IsEmpty)
            {
                $xNode = $xn
                }
            }
        Write-Verbose $Node
        }
    Process
    {
        foreach ($E in $Element)
        {
            $Result = $xNode.AppendChild($E)
            foreach ($r in $Result)
            {
                Write-Verbose $r.outerxml
                }
            }
        }
    End
    {
        return $xDoc
        }
    }
Function New-XmlElement
{
    [CmdletBinding()]
    Param
    (
    [System.Xml.XmlDocument]$xDoc,
    [string]$Name,
    [string[]]$ChildNodes,
    [string]$Property,
    [string]$Value
    )
    Begin
    {
        }
    Process
    {
        [System.Xml.XmlElement]$xElement = $xDoc.CreateElement($Name)
        foreach ($ChildNode in $ChildNodes)
        {
            $Result = $xElement.AppendChild($xDoc.CreateElement($ChildNode))
            Write-Verbose $Result.OuterXml
            }
        if ($Property -and $Value)
        {
            [System.Xml.XmlAttribute]$xAttribute = $xDoc.CreateAttribute($Property)
            $xAttribute.Value = $Value
            $Result = $xElement.SetAttributeNode($xAttribute)
            Write-Verbose $Result.OuterXml
            }
        }
    End
    {
        return $xElement
        }
    }
Function Set-XmlAttribute
{
    [CmdletBinding()]
    Param
    (
    [System.Xml.XmlDocument]$xDoc,
    [string]$Node,
    [string]$Attribute,
    [string]$Value
    )
    Begin
    {
        }
    Process
    {
        ($xDoc.GetElementsByTagName($Node)).SetAttribute($Attribute,$Value)
        }
    End
    {
        }    
    }