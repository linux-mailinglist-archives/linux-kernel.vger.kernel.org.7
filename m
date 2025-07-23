Return-Path: <linux-kernel+bounces-742849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E29B0F750
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A962166951
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA74B201017;
	Wed, 23 Jul 2025 15:43:28 +0000 (UTC)
Received: from newagemicro-plesk-3-1.smartt.com (newagemicro-plesk-3-1.smartt.com [69.31.177.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5980B1EB5DD;
	Wed, 23 Jul 2025 15:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.31.177.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753285408; cv=none; b=EBT4E15LAYBiYnnrQqVbX9uBmo2HOTEGH9y0vbIFYv8r8rnDH3ARDNiyUFgxEw3JY/sYbDNbMegtyq64eqgIPfBGJtf92lXgAxXtvb0DXBMC8+QOcppILHrDaAixf9Ri5nGBhuegt2aQkRn/AHYvUf5t2fDZayWDsKnPtNs4ng4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753285408; c=relaxed/simple;
	bh=HLBhb0LCd8+Yi56PywxWCtCAYIqK7E4jdeG5yM0dzLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Me3mfHsfkiaNM043QAk20ntZ3B6IKI+n4qJI+38qgxy4ByUH52rmX9ukiXySTUFoDOTTbkQ2zyAsBsGGPasSCWBVcQgnGdFC1sbpI5wy+3Hv34ghip5yoDbum3Z/Q13bErRR31ajDsljNrN6Rpm/hvJW1m900d9ERiE+9lTN+k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=newagemicro.com; spf=pass smtp.mailfrom=newagemicro.com; arc=none smtp.client-ip=69.31.177.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=newagemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=newagemicro.com
Received: from newagemicro-plesk-3-1.smartt.com (localhost.localdomain [127.0.0.1])
	by newagemicro-plesk-3-1.smartt.com (Postfix) with ESMTP id 65B2CE36CC;
	Wed, 23 Jul 2025 08:36:01 -0700 (PDT)
Authentication-Results: newagemicro-plesk-3-1.smartt.com;
        spf=pass (sender IP is 127.0.0.1) smtp.mailfrom=msobchuk@newagemicro.com smtp.helo=newagemicro-plesk-3-1.smartt.com
Received-SPF: pass (newagemicro-plesk-3-1.smartt.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=msobchuk@newagemicro.com; helo=newagemicro-plesk-3-1.smartt.com;
X-Virus-Scanned: amavis at example.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
Received: from newagemicro-plesk-3-1.smartt.com ([127.0.0.1])
 by newagemicro-plesk-3-1.smartt.com (newagemicro-plesk-3-1.smartt.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 0CToRNmg3XX1; Wed, 23 Jul 2025 08:36:00 -0700 (PDT)
Received: from MIKE1 (unknown [50.205.63.162])
	by newagemicro-plesk-3-1.smartt.com (Postfix) with ESMTPSA id 400DBB6262;
	Wed, 23 Jul 2025 08:35:59 -0700 (PDT)
Received-SPF: pass (newagemicro-plesk-3-1.smartt.com: connection is authenticated)
From: <msobchuk@newagemicro.com>
To: <linux-kernel@vger.kernel.org>,
	<linux-usb@vger.kernel.org>
Cc: "Dave Tyree" <dtyree@cybercogs.com>,
	"Mike Sobchuk" <msobchuk@cybercogs.com>
Subject: [Patch v1] driver/eth/usb/asix.ko: Support for 88772C in Rev-RMII
Date: Wed, 23 Jul 2025 11:35:57 -0400
Message-ID: <000201dbfbe7$7d4ac1b0$77e04510$@newagemicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0003_01DBFBC5.F65694C0"
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Adv753S3jDDtaeIqQveCkX4C2/uJfg==
Content-Language: en-us
X-PPP-Message-ID: 
 <175328496025.3523951.4198707262386615334@newagemicro-plesk-3-1.smartt.com>
X-PPP-Vhost: newagemicro.com

This is a multipart message in MIME format.

------=_NextPart_000_0003_01DBFBC5.F65694C0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_0004_01DBFBC5.F65694C0"


------=_NextPart_001_0004_01DBFBC5.F65694C0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

This Patch adds support to the asix.ko driver for the AX88772C in
Reverse-RMII mode.

 

The 'asix.ko' driver is designed to support 88772A, B and C.

The AX88772C supports running in Reverse-RMII mode to enable MAC to MAC
communication.

The base 'asix.ko' driver does NOT currently support the AX88772C in
Reverse-RMII mode.

 

This is due to several reasons:

1.	The AX88772C PHY register "LINK STATUS" Link value never is set to
1. 

a.	This prevents the drivers from setting the interface 'UP'

2.	The AX88772C PHY-ID is hard coded to 0x10, this configures the chip
to use the internal PHY not an external PHY.

a.	To use the AX88772C in Reverse-RMII mode, the chip must be
configured to use the external 'PHY'.

 

Asix provides a dedicated AX88772C driver which supports Reverse-RMII. This
'C' driver was references to add Reverse-RMII support to the base asix.ko
driver.

To resolve the issue, the following changes were made:

1.	MDIO_READ prior to configuring chip to determine what operational
mode it is in (Internal, RMII, or Reverse-RMII)
2.	If in Reverse-RMII mode, force chip to be configured as if it had an
external PHY.
3.	If in Reverse-RMII mode, set the interface status to UP regardless
of the value of the 'LINK STATUS' bit.


------=_NextPart_001_0004_01DBFBC5.F65694C0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta =
http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 15 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	font-size:12.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1817454948;
	mso-list-type:hybrid;
	mso-list-template-ids:386157864 67698703 67698713 67698715 67698703 =
67698713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1
	{mso-list-id:2007515992;
	mso-list-type:hybrid;
	mso-list-template-ids:1587734628 67698703 67698713 67698715 67698703 =
67698713 67698715 67698703 67698713 67698715;}
@list l1:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US =
link=3D"#0563C1" vlink=3D"#954F72" style=3D'word-wrap:break-word'><div =
class=3DWordSection1><p class=3DMsoNormal><span =
style=3D'font-size:11.0pt'>This Patch adds support to the asix.ko driver =
for the AX88772C in Reverse-RMII mode.<o:p></o:p></span></p><p =
class=3DMsoNormal><span =
style=3D'font-size:11.0pt'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span style=3D'font-size:11.0pt'>The =
&#8216;asix.ko&#8217; driver is designed to support 88772A, B and =
C.<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:11.0pt'>The AX88772C supports running in Reverse-RMII =
mode to enable MAC to MAC communication.<o:p></o:p></span></p><p =
class=3DMsoNormal><span style=3D'font-size:11.0pt'>The base =
&#8216;asix.ko&#8217; driver does NOT currently support the AX88772C in =
Reverse-RMII mode.<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:11.0pt'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span style=3D'font-size:11.0pt'>This is due to =
several reasons:<o:p></o:p></span></p><ol style=3D'margin-top:0in' =
start=3D1 type=3D1><li class=3DMsoListParagraph =
style=3D'margin-left:0in;mso-list:l0 level1 lfo1'><span =
style=3D'font-size:11.0pt'>The AX88772C PHY register &#8220;LINK =
STATUS&#8221; Link value never is set to 1. <o:p></o:p></span></li><ol =
style=3D'margin-top:0in' start=3D1 type=3Da><li class=3DMsoListParagraph =
style=3D'margin-left:0in;mso-list:l0 level2 lfo1'><span =
style=3D'font-size:11.0pt'>This prevents the drivers from setting the =
interface &#8216;UP&#8217;<o:p></o:p></span></li></ol><li =
class=3DMsoListParagraph style=3D'margin-left:0in;mso-list:l0 level1 =
lfo1'><span style=3D'font-size:11.0pt'>The AX88772C PHY-ID is hard coded =
to 0x10, this configures the chip to use the internal PHY not an =
external PHY.<o:p></o:p></span></li><ol style=3D'margin-top:0in' =
start=3D1 type=3Da><li class=3DMsoListParagraph =
style=3D'margin-left:0in;mso-list:l0 level2 lfo1'><span =
style=3D'font-size:11.0pt'>To use the AX88772C in Reverse-RMII mode, the =
chip must be configured to use the external =
&#8216;PHY&#8217;.<o:p></o:p></span></li></ol></ol><p =
class=3DMsoNormal><span =
style=3D'font-size:11.0pt'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span style=3D'font-size:11.0pt'>Asix provides a =
dedicated AX88772C driver which supports Reverse-RMII. This =
&#8216;C&#8217; driver was references to add Reverse-RMII support to the =
base asix.ko driver.<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:11.0pt'>To resolve the issue, the following changes =
were made:<o:p></o:p></span></p><ol style=3D'margin-top:0in' start=3D1 =
type=3D1><li class=3DMsoListParagraph =
style=3D'margin-left:0in;mso-list:l1 level1 lfo2'><span =
style=3D'font-size:11.0pt'>MDIO_READ prior to configuring chip to =
determine what operational mode it is in (Internal, RMII, or =
Reverse-RMII)<o:p></o:p></span></li><li class=3DMsoListParagraph =
style=3D'margin-left:0in;mso-list:l1 level1 lfo2'><span =
style=3D'font-size:11.0pt'>If in Reverse-RMII mode, force chip to be =
configured as if it had an external PHY.<o:p></o:p></span></li><li =
class=3DMsoListParagraph style=3D'margin-left:0in;mso-list:l1 level1 =
lfo2'><span style=3D'font-size:11.0pt'>If in Reverse-RMII mode, set the =
interface status to UP regardless of the value of the &#8216;LINK =
STATUS&#8217; bit.<o:p></o:p></span></li></ol></div></body></html>
------=_NextPart_001_0004_01DBFBC5.F65694C0--

------=_NextPart_000_0003_01DBFBC5.F65694C0
Content-Type: application/octet-stream;
	name="0001-Subject-Patch-v1-driver-eth-usb-asix.ko-Support-for-.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Subject-Patch-v1-driver-eth-usb-asix.ko-Support-for-.patch"

From fe97ec1812e6befc8bddc319fdf9cc913f45617f Mon Sep 17 00:00:00 2001=0A=
From: Mike <msobchuk@newagemicro.com>=0A=
Date: Tue, 22 Jul 2025 16:16:44 -0400=0A=
Subject: [PATCH] Subject: [Patch v1] driver/eth/usb/asix.ko: Support for=0A=
 88772C in Rev-RMII=0A=
=0A=
From: Mike Sobchuk <msobchuk@newagemicro.com>=0A=
AX88772C in Reverse-RMII mode does not set LINK status to 1.=0A=
Results in driver being unable to set interface up.=0A=
PHY-ID forces driver to configure chip to use internal PHY not external.=0A=
Patch provides support for AX88772C in Reverse-RMII with the following=0A=
changes:=0A=
mdio_read to determine operational mode (Internal, RMII, or REV-RMII).=0A=
if in REV-RMII, configure mac to use external PHY (Same as RMII mode).=0A=
if in REV-RMII, force LINK status to UP regardless of PHY 'LINK status'=0A=
register value.=0A=
=0A=
Signed-off-by: Mike Sobchuk <msobchuk@newagemicro.com>=0A=
---=0A=
 drivers/net/usb/asix.h         | 12 +++++++++++-=0A=
 drivers/net/usb/asix_devices.c | 19 +++++++++++++++++++=0A=
 2 files changed, 30 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/net/usb/asix.h b/drivers/net/usb/asix.h=0A=
index 74162190bccc..70e63e278720 100644=0A=
--- a/drivers/net/usb/asix.h=0A=
+++ b/drivers/net/usb/asix.h=0A=
@@ -32,6 +32,7 @@=0A=
 #define DRIVER_VERSION "22-Dec-2011"=0A=
 #define DRIVER_NAME "asix"=0A=
 =0A=
+=0A=
 /* ASIX AX8817X based USB 2.0 Ethernet Devices */=0A=
 =0A=
 #define AX_CMD_SET_SW_MII		0x06=0A=
@@ -72,7 +73,12 @@=0A=
 #define AX_HOST_EN			0x01=0A=
 =0A=
 #define AX_PHYSEL_PSEL			0x01=0A=
-#define AX_PHYSEL_SSMII			0=0A=
+#define AX_PHYSEL_SSMII			0x00=0A=
+#define AX_PHYSEL_ASEL			0x02=0A=
+#define AX_PHYSEL_MASK			0x0C=0A=
+#define AX_PHYSEL_SSMII			0x00=0A=
+#define AX_PHYSEL_SSRMII		0x04=0A=
+#define AX_PHYSEL_SSRRMII		0x0C=0A=
 #define AX_PHYSEL_SSEN			0x10=0A=
 =0A=
 #define AX_PHY_SELECT_MASK		(BIT(3) | BIT(2))=0A=
@@ -160,6 +166,9 @@=0A=
 =0A=
 #define AX_EMBD_PHY_ADDR	0x10=0A=
 =0A=
+#define OPERATION_MAC_MODE	0=0A=
+#define OPERATION_PHY_MODE 	1=0A=
+=0A=
 /* This structure cannot exceed sizeof(unsigned long [5]) AKA 20 bytes =
*/=0A=
 struct asix_data {=0A=
 	u8 multi_filter[AX_MCAST_FILTER_SIZE];=0A=
@@ -191,6 +200,7 @@ struct asix_common_private {=0A=
 	u16 phy_addr;=0A=
 	bool embd_phy;=0A=
 	u8 chipcode;=0A=
+	u8 OperationMode;=0A=
 };=0A=
 =0A=
 extern const struct driver_info ax88172a_info;=0A=
diff --git a/drivers/net/usb/asix_devices.c =
b/drivers/net/usb/asix_devices.c=0A=
index f7cff58fe044..28223d13ef1e 100644=0A=
--- a/drivers/net/usb/asix_devices.c=0A=
+++ b/drivers/net/usb/asix_devices.c=0A=
@@ -42,11 +42,17 @@ struct ax88172_int_data {=0A=
 =0A=
 static void asix_status(struct usbnet *dev, struct urb *urb)=0A=
 {=0A=
+	struct asix_common_private *priv =3D dev->driver_priv;=0A=
 	struct ax88172_int_data *event;=0A=
 	int link;=0A=
 =0A=
 	if (urb->actual_length < 8)=0A=
 		return;=0A=
+        if (priv->OperationMode =3D=3D OPERATION_PHY_MODE){=0A=
+                usbnet_link_change(dev, 1, 0);=0A=
+                return;=0A=
+        }=0A=
+=0A=
 =0A=
 	event =3D urb->transfer_buffer;=0A=
 	link =3D event->link & 0x01;=0A=
@@ -836,6 +842,15 @@ static int ax88772_bind(struct usbnet *dev, struct =
usb_interface *intf)=0A=
 =0A=
 	usbnet_get_endpoints(dev, intf);=0A=
 =0A=
+        ret =3D asix_read_cmd(dev, AX_CMD_SW_PHY_STATUS, 0, 0, 1, buf, =
0);=0A=
+        *buf &=3D AX_PHYSEL_MASK;=0A=
+=0A=
+        if(*buf =3D=3D AX_PHYSEL_SSRRMII){=0A=
+               priv->OperationMode =3D OPERATION_PHY_MODE;=0A=
+               netdev_dbg(dev->net, "PHY MODE\n");=0A=
+        }=0A=
+=0A=
+=0A=
 	/* Maybe the boot loader passed the MAC address via device tree */=0A=
 	if (!eth_platform_get_mac_address(&dev->udev->dev, buf)) {=0A=
 		netif_dbg(dev, ifup, dev->net,=0A=
@@ -876,6 +891,10 @@ static int ax88772_bind(struct usbnet *dev, struct =
usb_interface *intf)=0A=
 	priv->phy_addr =3D ret;=0A=
 	priv->embd_phy =3D ((priv->phy_addr & 0x1f) =3D=3D AX_EMBD_PHY_ADDR);=0A=
 =0A=
+	if(priv->OperationMode =3D=3D OPERATION_PHY_MODE) {=0A=
+		priv->embd_phy =3D 0;=0A=
+	}=0A=
+=0A=
 	ret =3D asix_read_cmd(dev, AX_CMD_STATMNGSTS_REG, 0, 0, 1,=0A=
 			    &priv->chipcode, 0);=0A=
 	if (ret < 0) {=0A=
-- =0A=
2.43.0=0A=
=0A=

------=_NextPart_000_0003_01DBFBC5.F65694C0--


