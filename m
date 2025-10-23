Return-Path: <linux-kernel+bounces-866157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6223CBFF074
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 05:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D8788352B41
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 03:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB822BF016;
	Thu, 23 Oct 2025 03:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com.cn header.i=@leica-geosystems.com.cn header.b="PcgwKKmO"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013019.outbound.protection.outlook.com [40.107.162.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CBE292B2E;
	Thu, 23 Oct 2025 03:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761191074; cv=fail; b=gIJQ0dQHAKcRyXec/Ry4q9wvj5Xn6VZKNQVGsmwHIhRA0A101pbxCCHy1OCw4KfXIAeE5+bzpPBPOMGIbEPHU9tWejEZnfaxztYbkUyalfmigmdN0HCpJXKMb264lkJ70ebqFCurLi6DdWWnjEZZOZ9pnqfoO8ElBifN8+HEgpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761191074; c=relaxed/simple;
	bh=sctV2PiOPA+Onl6fN+jOQGH7cFHRZIVCT+1dAZXvGnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZZlXO6jBpn7BW1tRmaWtqcCtNREAwqf4EhVdnoYKT3wh2n/v0KB8G3qpSWCyG8qi2P+cna7XmscxtsAH8/v5gHyJkjcFwjaz57wUSQ/WRatfohP7H/UR/B1DpFV6aBMEXnskBgTicAh2RG5Jl/RqfqMZ5jvtuPfLkU2YzeBNPSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com.cn; spf=fail smtp.mailfrom=leica-geosystems.com.cn; dkim=pass (1024-bit key) header.d=leica-geosystems.com.cn header.i=@leica-geosystems.com.cn header.b=PcgwKKmO; arc=fail smtp.client-ip=40.107.162.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com.cn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6m0xDTilg0tNZ1ammOAhwWnLDKc8lgEPbpWDj0CCWZx/zqEi5xrVt/tg5WBr07J9SkTuuW8ljIPT7COjsCthFzzsRcR1nhbIK17NVP0wOAlGpqLsLvNiTcygTdXLB/EMlL1qxamV/TSrsFX/WA4XhiLrTAwNJevJNTlM1X+bmB92t6Y2YFR1OvIydYc6wQiN/L1KM+XYvttSx5tO+0HU4OLBGPmcfS5HVqlEbKi936P0Hy1sUKX7UcYvfU6Z7/cxmBIlfhAYK4j74+qscrkNHqcL7Z5ZlUO4xtw365iRvPcAFyglatFRCt3HqNBUOZLB1g9i+ZWiHleI1gqjlC/Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ObdV4PyC0q2cQBPMFOQvIJxYSvjatg32c9StvJjinw=;
 b=wM7+i/mRI5vUmah6WZKhOU0viP5S2rlnQqVTriGALLgP5dPBXvruwlBxMY9vNT+uMiBWeKQBqOxw8KU1WECsW+wzKvxs2SHiEozUYc6HwkkpkN36uuni/8WALFYOybaU0SoRooGgNf2+9rcY+sqRxpxi78+Av98zMbmoIJ4YUjhEJ336LHfyZUM92pinApXUO0P3fUXGSt/MkbbXI/+rDZrey0DBrtOHGqh1K5HjswsJVIBWji8AVd2FFPC+AF9alC3Pm7UMsIWS4/aNsxe8RQdDT88dCU3s3I+G0nWRn92bHbZK3oHTcsssrfGts1ob45ZXWypu49YygUd+vDFa2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.99) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=reject sp=reject
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ObdV4PyC0q2cQBPMFOQvIJxYSvjatg32c9StvJjinw=;
 b=PcgwKKmO4s29B25dU21CEZV3Sj4IruVWd7yw5Efym+92xwJrPLD2VtXSv0czlxmAUGcYz5wKNvboNWj9j/NT2qFQcHSIKxVe8y7a8CkWfRPBK9VvQF/YUhOTQT+Q7Nhg3o736XUoci37HtwabKUgOE45w1Szvr5U6Mn8EVBsKp4=
Received: from AM6P193CA0114.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:85::19)
 by AM0PR06MB6353.eurprd06.prod.outlook.com (2603:10a6:208:19d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 03:44:26 +0000
Received: from AM3PEPF0000A790.eurprd04.prod.outlook.com
 (2603:10a6:209:85:cafe::9b) by AM6P193CA0114.outlook.office365.com
 (2603:10a6:209:85::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Thu,
 23 Oct 2025 03:44:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.99)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.99; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.99) by
 AM3PEPF0000A790.mail.protection.outlook.com (10.167.16.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Thu, 23 Oct 2025 03:44:25 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.61.228.61]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Thu, 23 Oct 2025 05:44:25 +0200
From: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To: johan@kernel.org,
	Qing-wu.Li@leica-geosystems.com.cn
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] USB: serial: option: add Telit FN920C04 ECM compositions
Date: Thu, 23 Oct 2025 03:44:22 +0000
Message-ID: <20251023034423.3421068-1-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 23 Oct 2025 03:44:25.0240 (UTC) FILETIME=[537F1180:01DC43CF]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A790:EE_|AM0PR06MB6353:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 46fe48aa-6992-43fe-5043-08de11e67620
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?evzfrb9KFj6GFYHd7AEY38F4Y+AWOiFHjCcnoYP8W3xYJE2jG1a9b8IX5fHi?=
 =?us-ascii?Q?8KcgWiZ/4LLSZCEei0Yl1ttyBeuBVIvWJoNTZIbMcO5EYzshmWfPzOsdwhSy?=
 =?us-ascii?Q?Ja8etyyQ4hrz7F5DZ+01NxMw5GOoEZ3nQzDbJff8Jlbef0fF9fEPdN+nIGeN?=
 =?us-ascii?Q?ceFkQfLgY7LSbdJN63D8Qe6uJ0d2dyVJA0PS72T+oLmVOZyC1XTUDA9dCGV9?=
 =?us-ascii?Q?0RpYPi4Q3sRnauikI2nufGWUomNe8kvLpcBLmRpWqUufRFHlSlAvyMPTljRA?=
 =?us-ascii?Q?Flh0tHLPJhFdHSbp2THI81I8U9heFILesdDCiSCCXubBetjmdEMEpvZjsyii?=
 =?us-ascii?Q?nDy1kOL1W2hEV/zgcRzkPkz/pIyR0D2bbuECacle+yyaL+1T7f9NRv7ypnxf?=
 =?us-ascii?Q?HyVRDMqzws/Y3+w2KRp71c5wOlpXLUGekkG1EHJ8KGx7CTxroFp+7ZERz/9Z?=
 =?us-ascii?Q?gXlIrWlqNnhD4ANPmnhVIlcbqnwXOjfew+lnX3xvQH587UoQf3MfSKik1iwg?=
 =?us-ascii?Q?2FHi2Uqg5l+DicYhFQK0axlLnz6gxoMBXBr3mvNRYRYAztDY49MFQ5ltJxew?=
 =?us-ascii?Q?CDpO994pJp9MEx6F0RcNdS5gtLRF9erVa6zM6tZkYuWD4n2IMskkRQnP4QGh?=
 =?us-ascii?Q?jGRjtzWASdT9hxOA1Jtlstgdd/9cKz/F/5wP+IugDViOf2tjevh6W265+p7G?=
 =?us-ascii?Q?j8tmHKWSZxA5TFOWpqWquOJ7bCDppAMxEQ7a+O/rPv/218K+UrZTU4hkt/Go?=
 =?us-ascii?Q?qBYh0brU2uVid+HW/e6bNSozIJpHvnfhkDF2hwiVhUFOQAVMpqEwPIN2b33i?=
 =?us-ascii?Q?wEaaepgBYVw1otFKFzCBBIpona2XaoiqpoHUG64rV/2WEd+EnX8X/AEnPDJC?=
 =?us-ascii?Q?hfPwknRQcbxJE907p7o/WIe4cZ5tbUnOH6LLnn2rKOGlKBmxhJgVAhOBVuQq?=
 =?us-ascii?Q?PuOTHF/FKXA5tksGDAGJbMW8oOqKc3r+1LI84qEyJaS1qpx3jhSU5j6DqHn0?=
 =?us-ascii?Q?bEVPUM2ES2qIcWwvu2VpkW5sEAYwP45aeua9PgUgkIK8XQrSP3fPVK/LMeFR?=
 =?us-ascii?Q?SSVp8kJZDou+FKU65mKn2pfiZkVTJn7r3ZNJGM4VIx3PVg/psHlaelwqBmRD?=
 =?us-ascii?Q?4GLsCCjW/Chi23UcGvOmJTdZaZ86YqRWFKtwvk/ixgV/qaYaVshFEcrIoUvQ?=
 =?us-ascii?Q?rnqXXbuOi11KvW1Njne8l4dPp+SWdMsArko8BAM3aLT6V1N+uaZK6WnQLdUq?=
 =?us-ascii?Q?Wj/4YCRGEe+IV69jNNDQvLiWttE575cOBHwB1M/7rWCY4wGvgINzbrgtuFmg?=
 =?us-ascii?Q?Wiv2cRPzeMYHB0IgGP5YwKtGdpESrwbBW4qF1NGhUwbN/V/QECjX7ptaJ1he?=
 =?us-ascii?Q?7eSeE/CSdV4t1pIyPvGmMxlzJzAg4VcgQnNHTO9EZTyZyV2qdLKwjdC4Yaoz?=
 =?us-ascii?Q?1eQQoWbT9wr1h4qwEIh9HdwoHMkxq+9AoszDh6A2rsX9qRMwtGAQEtcaZOPw?=
 =?us-ascii?Q?tNVydDQvjVbEb1rLAh1TjPmQUEGyMgRBc9uqwypGt/1TFHHHj2TtiaJqD6lK?=
 =?us-ascii?Q?mr+jNm8XFqapazwEtXU=3D?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.99;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom51.leica-geosystems.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 03:44:25.4228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46fe48aa-6992-43fe-5043-08de11e67620
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.99];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR06MB6353

Add support for the Telit Cinterion FN920C04 module when operating in
ECM (Ethernet Control Model) mode. The following USB product IDs are
used by the module when AT#USBCFG is set to 3 or 7.

0x10A3: ECM + tty (NMEA) + tty (DUN) [+ tty (DIAG)]
T:  Bus=01 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  3 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=10a3 Rev= 5.15
S:  Manufacturer=Telit Cinterion
S:  Product=FN920
S:  SerialNumber=76e7cb38
C:* #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=06 Prot=00 Driver=cdc_ether
E:  Ad=82(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
I:  If#= 1 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
I:* If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

0x10A8: ECM + tty (DUN) + tty (AUX) [+ tty (DIAG)]
T:  Bus=03 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  3 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=10a8 Rev= 5.15
S:  Manufacturer=Telit Cinterion
S:  Product=FN920
S:  SerialNumber=76e7cb38
C:* #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=06 Prot=00 Driver=cdc_ether
E:  Ad=82(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
I:  If#= 1 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
I:* If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Adding these IDs allows the option driver to automatically create the
corresponding /dev/ttyUSB* ports under ECM mode.

Tested with FN920C04 under ECM configuration (USBCFG=3 and 7).

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/usb/serial/option.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 27879cc57536..293e3e25e65d 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1381,10 +1381,14 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(0) | NCTRL(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a2, 0xff),	/* Telit FN920C04 (MBIM) */
 	  .driver_info = NCTRL(4) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a3, 0xff),	/* Telit FN920C04 (ECM) */
+	  .driver_info = NCTRL(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a4, 0xff),	/* Telit FN20C04 (rmnet) */
 	  .driver_info = RSVD(0) | NCTRL(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a7, 0xff),	/* Telit FN920C04 (MBIM) */
 	  .driver_info = NCTRL(4) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a8, 0xff),	/* Telit FN920C04 (ECM) */
+	  .driver_info = NCTRL(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a9, 0xff),	/* Telit FN20C04 (rmnet) */
 	  .driver_info = RSVD(0) | NCTRL(2) | RSVD(3) | RSVD(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10aa, 0xff),	/* Telit FN920C04 (MBIM) */
-- 
2.43.0


