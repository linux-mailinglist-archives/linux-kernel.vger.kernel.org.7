Return-Path: <linux-kernel+bounces-885784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EDEC33E0F
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 04:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309D546419A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 03:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D9E25CC63;
	Wed,  5 Nov 2025 03:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com.cn header.i=@leica-geosystems.com.cn header.b="bYf1MwE/"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013015.outbound.protection.outlook.com [40.107.159.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D2C22F76F;
	Wed,  5 Nov 2025 03:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762314526; cv=fail; b=GsNvEgWWWbYPhiQNM13SxBKvk0Ztf/gTdAhVMz44eEBF+sHBk3AT+Ia3fVZgw3TD2dw1rxHMfnUKiuPdJOnE3gGYhW2b+aWdADpUl/fwHyK2ZKtuUkBrleXzPhVwRkk9h0xlWWKh+FYtO4jmHc7826fPbh/NvDbeKt7X3LE4Dgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762314526; c=relaxed/simple;
	bh=+zJhMz9olEoRHXNcCfkGOoE2ULbmyxjuoRANzVGjE0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LmdAZ71YnWJajkCG6ef78BtFWSE/k6Lhgxtr8V3wifbX6u5o+6Ujrxsl1qIQJkNu2wP++OVpDntkxFdpndlHi2rIFQe1R83FFJOLtSJRjwJDE+UppOLpls4MhOraNoeme3/e86OQCgKeM/sM5uXCA9hRLitrXycd67Wb2Gld7SY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com.cn; spf=fail smtp.mailfrom=leica-geosystems.com.cn; dkim=pass (1024-bit key) header.d=leica-geosystems.com.cn header.i=@leica-geosystems.com.cn header.b=bYf1MwE/; arc=fail smtp.client-ip=40.107.159.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com.cn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WjVyLucIP69De79qOy2b+jAfvnJ12zNtihwdYpUIltY7j14trj6W7ju4qsDF4ag0JETAoyf6zOBGvYJqskX2E3EZgFBVa/KtpIRx+q1UiizHWD3LA4pvBz6ZDnYIiGwTiThGCp2dm/zP3JdvXInHzMku04By8eKedyrSt5GFC7q0mtjoN+UHMMScUfzAm6ODxZ2xnt93R+WfZ84bRSzNS6VAEFQJVDn6iFYHaX2u+dvKZYxZcaXKuIlIXXW6lrIZN3C0faVdXi5W3eVf2GVtfl8tiJ5j5JFuePEZ0ne26r0TnACPeWVTBApVPuPKeEBx7K4wjVZoxJChhLNZLNPw5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ullzAbOheDjbehkQQx9oA3zNCh4/36vEMtvRlvls1Q8=;
 b=NN8umJj6j/89K9M3ZEOxdoiWQZ8IqIIq2+2xUaga3A1x8kslp7qwqhjHaXcnALhcYwA18FD0MazV5krdQyg0J8szlhIMFU8LHPXpsg9AjesU76zgBX4110ddHgZjhJNREI9nwMpP6A58L/Z5jy2AwLWhNxKsKWoMcR+FNwwLJUhg+4bEtwSLAAsGl6Ow54DHwuf3tcaer74HbNDLcrEjmeWbD4dBdUe9d74pt+uXyDuiev4110DmavvwkZ70zXeumq7+o8QwwVCDUNdY3tnA83kTuJSDYfjDtckeu0D22s3eI4i3WVcAPdftw9nNdRdlYhe//xu91sJvoZp4qvLRvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.99) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=reject sp=reject
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ullzAbOheDjbehkQQx9oA3zNCh4/36vEMtvRlvls1Q8=;
 b=bYf1MwE/z7HOi4KgQnbxNslnZeXJv5N8YWHNiQVaZk7i38urJnYlvnbQxmuNK22hgii1XShh8y9QYkjF1fOHiJlf/c0kyErWOs7zhtad2SmzSYFVftLJPY+Z7DfWe0UhLkIOY39dTCu/AUhQIBV5tt5hViWmr4PtaK2P4Qf7r6Q=
Received: from DB9PR01CA0006.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::11) by VI1PR06MB8640.eurprd06.prod.outlook.com
 (2603:10a6:800:1d9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 03:48:38 +0000
Received: from DU2PEPF00028D0F.eurprd03.prod.outlook.com
 (2603:10a6:10:1d8:cafe::a3) by DB9PR01CA0006.outlook.office365.com
 (2603:10a6:10:1d8::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Wed, 5
 Nov 2025 03:48:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.99)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.99; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.99) by
 DU2PEPF00028D0F.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 5 Nov 2025 03:48:38 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.61.228.61]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Wed, 5 Nov 2025 04:48:37 +0100
From: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To: johan@kernel.org,
	Qing-wu.Li@leica-geosystems.com.cn
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] USB: serial: option: add Telit FN920C04 RNDIS compositions
Date: Wed,  5 Nov 2025 03:48:33 +0000
Message-ID: <20251105034833.4152008-1-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 05 Nov 2025 03:48:37.0826 (UTC) FILETIME=[116B6220:01DC4E07]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0F:EE_|VI1PR06MB8640:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: eb4d3055-bf28-4e7c-33bf-08de1c1e342b
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|34020700016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zTW/JCmSU7+y0LDnE+3mvkmIT8lGnWvRYzXnb61EqElshPz60+WQvzOZD7+L?=
 =?us-ascii?Q?B8jktDKF+a04msm8JzdP8c50qj1jNPHZRy4zBfU2BupJfH8FlBRfqdThs+70?=
 =?us-ascii?Q?s8yRxtpVFf2cEOHI3IwZsil2npR+2AAamu1jXDhi08c+aVF7qnoBUX4K8L8z?=
 =?us-ascii?Q?dF84DdDJmJrSoEvKtVJnZftnFNbO/O5B7dAe3QL7FceC1q3k4WCZr1f2SiKb?=
 =?us-ascii?Q?aib1p3gKrC93iet7A05VErqib1QmxVzXxY1GjqFQP5N5tn0hOTNz9LK8QBC3?=
 =?us-ascii?Q?H0tKYze8rFXpYRGsGqILgqZSnHIm5ChdBnCUsu9iGUMqdzStmc/eCfnQ4XOY?=
 =?us-ascii?Q?DQ4bjHTy15Yk5izzoIb/T5abIBSsm8xDmSBlMf67iheVTyEPrt8elr1BwZ/A?=
 =?us-ascii?Q?QxNT5m4JnhZ5jfzP2FqDZc+/E6IMKDfa16C49C2lTHZg002WwRERNz2NMxHK?=
 =?us-ascii?Q?gT2Wjo6MP9OjWGYo1WB4GPh2UgCO3AyL6slimsEB4xXyunwkElbF5mOp2fkl?=
 =?us-ascii?Q?3POpvF84mxIDkP87pENKqLJNWBA/bUjHUIVszkLfOK39pNA0/mXceI1U86aC?=
 =?us-ascii?Q?hG2Uf+bJavE7k3NuyJRqi4og4twRSlQLKl54icOh2pFVNH8X+EZz2yTvv10S?=
 =?us-ascii?Q?GlB+Z7C3opaoW0TRu7Jyr652Ll/A5NX14arTg94SPCSlRpn96db5QZDLc0G+?=
 =?us-ascii?Q?SamxWAY69T9QtRsry06ct2+TC7vOjC88rQmJCff1d44SCcGtMnp+JZba+G/e?=
 =?us-ascii?Q?Nu5oqsHg56hzWV7N+ApNiJnCWfar6CgvtATFITSu9tMvmoQEqKm8xG/bVULG?=
 =?us-ascii?Q?I8ho6SKAFmEcV9hVl0ivndmm9KNU3YKxn5Ppic1woTOpSVTe50Sl+6R3KTbI?=
 =?us-ascii?Q?EqO5i+77wtjvyJ1wzHxb1EzrEgd0/+0zmp3610xyM8g0L366Z/0qghbTzkAc?=
 =?us-ascii?Q?8VpC+lNctKuhbknOSgaq7hEGLnJmQXrIj25SN3hg7HgAh7xB2t8iXRZ+gARw?=
 =?us-ascii?Q?tssStg+8l0fdyqOqXTKD33Dq3vsV0wib4feQ7WN4Fzs5MRq17i8lDPV+iBOE?=
 =?us-ascii?Q?DKwt+BQoIQih+7b4ym/thkWr+iGcGkPlLf9XU1bb5C4qzhK963tASzDoyUtS?=
 =?us-ascii?Q?Kye6gC7QF+uY1l83peiM/6k+CiwrdBqqnAAorj27iT0ciWIGNWYY+E+psDGC?=
 =?us-ascii?Q?wfLPkijeMozAlsiTQmo2SUDgbUps/5ErybgTjJ3lWrDXukTA2Izya51iF2UY?=
 =?us-ascii?Q?66hfV5Y0tLzPapncfkvL8TWC0fQkAxx9b8A4/eIaBl5bRUrg9WoWylNn05nj?=
 =?us-ascii?Q?mWe7ca841MSMZC1rnRgoUoPBNnvRYVVN5MMzGhqcKoXACGB/46+OOLi0czqe?=
 =?us-ascii?Q?PPAQIU0x3CBfb5XS7AuppY4ok8EAKmOlCdsSnUO8dZs2k0nOD/d5sy+0pzDM?=
 =?us-ascii?Q?h09RZQ0wdC9kLcp6AK5YAf/mBxJ4SiybtF3bJe8pcgCA0hzMGbuWHNOQWVfB?=
 =?us-ascii?Q?hD0qD6YJQuFi/jENVvtKpKyrsDgjMzUgTWB2?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.99;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom51.leica-geosystems.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(34020700016);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 03:48:38.1640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4d3055-bf28-4e7c-33bf-08de1c1e342b
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.99];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0F.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB8640

T:  Bus=01 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  4 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=10a1 Rev= 5.15
S:  Manufacturer=Telit Cinterion
S:  Product=FN920
S:  SerialNumber=76e7cb38
C:* #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
A:  FirstIf#= 0 IfCount= 2 Cls=ef(misc ) Sub=04 Prot=01
I:* If#= 0 Alt= 0 #EPs= 1 Cls=ef(misc ) Sub=04 Prot=01 Driver=option
E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=option
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

T:  Bus=01 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  5 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=10a6 Rev= 5.15
S:  Manufacturer=Telit Cinterion
S:  Product=FN920
S:  SerialNumber=76e7cb38
C:* #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
A:  FirstIf#= 0 IfCount= 2 Cls=ef(misc ) Sub=04 Prot=01
I:* If#= 0 Alt= 0 #EPs= 1 Cls=ef(misc ) Sub=04 Prot=01 Driver=(none)
E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=(none)
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=(none)
E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=(none)
E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=(none)
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Upstream-Status: Submitted [https://lkml.org/lkml/2025/10/23/130]
Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/usb/serial/option.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 5de856f65f0d..f8bb94f20143 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1401,12 +1401,16 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(0) | RSVD(1) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a0, 0xff),	/* Telit FN20C04 (rmnet) */
 	  .driver_info = RSVD(0) | NCTRL(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a1, 0xff),	/* Telit FN20C04 (RNDIS) */
+	  .driver_info = RSVD(0) | NCTRL(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a2, 0xff),	/* Telit FN920C04 (MBIM) */
 	  .driver_info = NCTRL(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a3, 0xff),	/* Telit FN920C04 (ECM) */
 	  .driver_info = NCTRL(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a4, 0xff),	/* Telit FN20C04 (rmnet) */
 	  .driver_info = RSVD(0) | NCTRL(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a6, 0xff),	/* Telit FN20C04 (RNDIS) */
+	  .driver_info = RSVD(0) | NCTRL(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a7, 0xff),	/* Telit FN920C04 (MBIM) */
 	  .driver_info = NCTRL(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a8, 0xff),	/* Telit FN920C04 (ECM) */
-- 
2.43.0


