Return-Path: <linux-kernel+bounces-882844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B2687C2BAB3
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 13:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C09754F750D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 12:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CDE30DECA;
	Mon,  3 Nov 2025 12:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="eToJrGhX";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="BV3IlNV0"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E065F30DEBC;
	Mon,  3 Nov 2025 12:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762172468; cv=fail; b=JNCzNyYNNe0LJSmPNPoyVZYWGUpZYBuwPNvxm61P1dm5b1WzfDbXYce4w42VrHkJipE2zjSpwSON8JFZTxGSfKExZCmjUYZgHdCSEqMTgTgtWNcecebnmFno7mamlzkkNrJ6R/RKNDwtmAo5FUCaM0r8saRiq6MhyPy4+3SUQLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762172468; c=relaxed/simple;
	bh=OX1OgxNMQ2uZ9RpfeQ2qEiKxbzcaBKFhWxQbxVAdoF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sj38skWU6ucNHHWvCMZVp2AeA9LlEKUzdnwDPg9xfBoX7DInX6xPcb2xyxkbmn8A8wLRq7pHz84SY26trNF5eFjrj4lppjFJkhksyDuyE45Nfx96Xi+4aCz4psVQKUY9y3F0ygFl7VpOCzhbitoCHh7jTYSIrjTqI68DBcx/Gnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=eToJrGhX; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=BV3IlNV0; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A35JBtq874130;
	Mon, 3 Nov 2025 05:58:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=yIwhgNyUUsC7Vobo
	S5hrzZvl+1BDW50acKc3Qhr6Dbs=; b=eToJrGhXV/aCmA0SpLQ7Qq/n2Fy1GHls
	FUEb3ilPxpXZSY1tHrsjUpF80QCE+2QFIiopSahL9lomCeHlwqzcD96LtH0o2itl
	dxRuvqLaPrnHLIyOlgxTwj+YneatNWkdYBBx+deFl6rJwVpdivap+yDuwRw7vDDV
	OpRBaX2U1hVD0FWwtL1SWsK3EkANhEm9BNiocV3tr/wgFcYT5MXxklJs2BGsxDTt
	pggFuoyqqJj1n47jo8pDRic2ejisl8hRv/bNT14bO1Egl+E6gIqDndTDgtKkbGOn
	7AnzPIDsAgmql9DpZKv0bYcoG5bXs3wICSKMKK4i6K9K+7Yi3v8sDQ==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11023132.outbound.protection.outlook.com [40.93.196.132])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4a5emg1x23-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 05:58:13 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZV9ZWwcWTaSN0+pruLlUAQIzeBSLNmlTjWSY7jZIHaCscCskAv52NPbDjFVN+sLTp1496Pv9wvjhA1WHejuCa7Rz6TVL6xhC389ASNl2l9OK5Y1IqYm845yS5z6FV9+CKPSKLATeREC68BmuUM7Rt8R9e6HI9AD/kKvBHbbwKq8qYIH2tgbIN/p2fz9lemM5OVEM+HWH24jHMvpRrF4qd3vrfWaZWJxblHF9Jy0UVIChdOo2KrERWOrFOFSr3JQLyIJ7OldArY2EBWByYgoNxpnlcCcbUhhDSea/bDmPVgqPOHmr7wjgdlJID1jL59jRO8s7mCesUAVRdxYIwGF9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIwhgNyUUsC7VoboS5hrzZvl+1BDW50acKc3Qhr6Dbs=;
 b=Ho53tB2Cp9B2J2KNdHcGsgsnyCX/KnW3TlXtFqO2gi/bTd04ZkcCpJSWy2uM9yEBpa1I8/IgJG4F8+ctWYRVWJn0pjZbrFhMy21bBukDvRtTpH3vfcwUfR2rixUcSo6h7oRL0EIM5ZVfVlIdQIdj5KBhARKIQyBlqO7JBScfNa7srJfSCHdJmMJSEwEX64cID02+9czYFuxt0GyEzEDpgn7xmDhD9kMBO8vd6hiMjvpHyj87UWCLL9wDNqGEuVtRUFBjP5bwy4bvyJEAhcYKYBZuRTpHEvpgPSaLmBTLCoBxse09j+yK2p0+0Tbs7XUCssSrPjxk7kNmnKA7ailZRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIwhgNyUUsC7VoboS5hrzZvl+1BDW50acKc3Qhr6Dbs=;
 b=BV3IlNV0byvk9AyuUmZ3aJ/7rSfqGgXQ9r0VoD7M0GsUHUhPwBgc5gC+fPKryuqkdD5TM3GFMGkzGs+w7QqTwM6MvHqC5bzaYFRspNpXyQImBybRFQ0jAWC3S7WnN9W48zEwcQ6rQVNU3BuRUxyOKRrKfsMNSmZLqiaa8TPFf6g=
Received: from SN6PR2101CA0028.namprd21.prod.outlook.com
 (2603:10b6:805:106::38) by DS2PR19MB9460.namprd19.prod.outlook.com
 (2603:10b6:8:2d2::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 11:58:10 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:805:106:cafe::16) by SN6PR2101CA0028.outlook.office365.com
 (2603:10b6:805:106::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.2 via Frontend Transport; Mon, 3
 Nov 2025 11:58:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.6
 via Frontend Transport; Mon, 3 Nov 2025 11:58:09 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 6C04A406542;
	Mon,  3 Nov 2025 11:58:07 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id DDC1A820257;
	Mon,  3 Nov 2025 11:58:03 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH] ASoC: doc: cs35l56: Update firmware filename description for B0 silicon
Date: Mon,  3 Nov 2025 11:58:09 +0000
Message-ID: <20251103115809.33953-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|DS2PR19MB9460:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 35982f9c-3e80-42f8-a978-08de1ad0423d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ePjqWRk+gzWGBk+kngVeDjx7T9oMawpxnEIdJMBOW2yNzqm/lDnAV08FeACG?=
 =?us-ascii?Q?CMUT2nur9wgye2Ny1McHimnFxo+g7USYtzFAc54cRAWvlyDo5PWd9g5DP0lj?=
 =?us-ascii?Q?C736SexWFtnoeIXLgT0gDPHnSX78VxftvZBnD2qgi6fxZXvQg6pd402cy2bQ?=
 =?us-ascii?Q?yDoMolb4Edo71c4IDtQv4vNbBx3QXTwi1ciEfWbJKyTG50mT+ER0Xzx0K6lZ?=
 =?us-ascii?Q?Zhtn4SNckuADrc/FxptQ1mK1gYgdJvjNLsSTbbcmJmhGyP9O+E1U2omOgORV?=
 =?us-ascii?Q?w5Wpjtkb7WW2JHPkwoSdYCfoacsMqh7IFTvutFyiFV/Cm2vP29UmErDxfIxo?=
 =?us-ascii?Q?spQuArjrdDBwRWGuaQNnWWLso988mS0SG4nvvBLHCwOUQz1nOtz8BWNzs7Ch?=
 =?us-ascii?Q?dG9ttfSiv06k9TaJMGLLQDv9ME9TUSEFyiRRw5eyNQwYlQ6odtjuvboSk9gl?=
 =?us-ascii?Q?w+IEQ/MO+ed2UH+bBWZySTh3dmsWKH9X/viqVuXEiWczgo9tXEXyOAu8ADGi?=
 =?us-ascii?Q?iru0yPM/HDEh37xk/UseZwvS9XlcKDGo6fLcCSf8ku+2SdCAKvfBIeGHbAkW?=
 =?us-ascii?Q?+81wlskd+ZBdLT0qQMlb5Z96pY6Pq2RYwQsLANrnjhJyHRMvnL2ZUVfKBr0t?=
 =?us-ascii?Q?55nqaMqv/doXBELFNZOYS5yGFiJYNW+LKaxOZCDlyGQrwsugYQCXPemk6MKU?=
 =?us-ascii?Q?dexBRLD7aYCt8mBIrUPDZyq+07VdlMpouS+K8tkKk4SgqMgoVfrUUsB2diGe?=
 =?us-ascii?Q?aZ+A6Vlzzt8ymK5wBYSje65zE5zQWgGjab9waIc7KPZ37MnCvUQ9zoT8dAQW?=
 =?us-ascii?Q?29VlSVCjpRCv48EkWqkl82zc3gNJmGw55DauCfK2ci5bjq7zcmNuYeANgntK?=
 =?us-ascii?Q?CUWE47p+i9osJ97zzKwK/IThxNCOHjZz3NkAmYCMIst1fajf/IoNuxv002Om?=
 =?us-ascii?Q?7DsQZxcgg7/oBLiZ+eH42LsNDxEz+603IobiSXWX9/bBoTR0jsAwkH0OU9pt?=
 =?us-ascii?Q?qiiDuiZbh8WpkcDtWVIuxWi+0zOnf44Mqw0JeIR3ibB7dQRni2GAq8LDHHr8?=
 =?us-ascii?Q?oSdgnZr4wNOz5G5YSshAYrEI4awwO5sRhDxWndkTpqZ5ibyQ21PKbYqhtKC4?=
 =?us-ascii?Q?bjf0X9fRh2muzvyln9UyYj8jZpc0TFlKqulFtSoP0IEuZ2YiJVjoKbf6bBRP?=
 =?us-ascii?Q?mBdk3MPpB+eaFmBGa7x0fmfMW2uvujKXWz2W2xhHFQolgH6R2DMayqLELEWD?=
 =?us-ascii?Q?6XMOjC6ivm40SQ7flRuLypWjHGfbuffHRlThrQu0NSMoVSVdz8skc9KyO2Lz?=
 =?us-ascii?Q?cfejadvk8/HXA8QX5s7jJAM/0BDX3DnvlHDdEV4eZtQdTP4z4jMCy1lI2bA9?=
 =?us-ascii?Q?XvF1YcDbUKKXIux7T0hIf+4+mC8hVSIYLcahdO4mLaxU7hY0m1CE2/5UtQw+?=
 =?us-ascii?Q?RXO/iK5szhyNPgTyF4yP4LV132HyPwawDVHTgzIbtA6G961Vcn0XdXmkp0uN?=
 =?us-ascii?Q?YIM8RYA2L6M+dO+5DUILNxemRGBEIMRhZmVIvV/cEJgxfrqte7pTUvbBDg0f?=
 =?us-ascii?Q?3Q6pE/Qp+bjZj+m4bnA=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 11:58:09.7244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35982f9c-3e80-42f8-a978-08de1ad0423d
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR19MB9460
X-Proofpoint-GUID: b8EsEKyLgxFSlkt7Lp3UZ8F6Od-jm-B9
X-Authority-Analysis: v=2.4 cv=Mu5fKmae c=1 sm=1 tr=0 ts=690898d5 cx=c_pps
 a=LH/tFbq2k+kQ3xVriB62Mw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=o0tB4AjFV136TSChQ_0A:9
X-Proofpoint-ORIG-GUID: b8EsEKyLgxFSlkt7Lp3UZ8F6Od-jm-B9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDEwOSBTYWx0ZWRfX5zE9Wtz0h60I
 RRE9I0theKvBeF5XB/7QEUl4t01t7LXVFXhxcB2znBifkQrshTkjwkckAO+38RjdEnxt0326qAE
 xfBCEIVwgsQr2YD5jFIeVD9xHYoVKPaaq+9iafVgFTtwF197uPPRaqMu3PTrU+e8S+qkRkIP/Fi
 FGQ/e538Sf+x0He6ZXrdQ4zoOM49Z8tHn3udcUYqzU6v4xomNYLVgFsLpDc6f+sZjeIRl4+APvd
 LD6Q7VEr88wZYV7sBJCJSlBE0snRCjOogrDD2FCOENafQo3g6eiWm34ZdBBkQHt84ioDUedh7f0
 cvjJlz4v+a4oArJIWSnTfdTVN/H7G1XH1X5GkQp9qba9p4hUutueJyx4EK4bq6mZZgV53dBZlPU
 0PBqh52NdWyW4bEY5Lnm6C+uSL5j1Q==
X-Proofpoint-Spam-Reason: safe

Update the text for firmware file naming to show that the l?u? suffix is
supported on CS35L56 B0 silicon and ampN was only used on early firmware.

The previous version of this text only said that B0 silicon used the ampN
suffix. Since kernel 6.16 the driver supports both the old ampN and
new l?u? suffix for B0 silicon. New firmwares will use the l?u? suffix.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 Documentation/sound/codecs/cs35l56.rst | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/sound/codecs/cs35l56.rst b/Documentation/sound/codecs/cs35l56.rst
index 57d1964453e1..d5363b08f515 100644
--- a/Documentation/sound/codecs/cs35l56.rst
+++ b/Documentation/sound/codecs/cs35l56.rst
@@ -105,10 +105,10 @@ In this example the SSID is 10280c63.
 
 The format of the firmware file names is:
 
-SoundWire (except CS35L56 Rev B0):
+SoundWire:
     cs35lxx-b0-dsp1-misc-SSID[-spkidX]-l?u?
 
-SoundWire CS35L56 Rev B0:
+SoundWire CS35L56 Rev B0 firmware released before kernel version 6.16:
     cs35lxx-b0-dsp1-misc-SSID[-spkidX]-ampN
 
 Non-SoundWire (HDA and I2S):
@@ -127,9 +127,8 @@ Where:
   * spkidX is an optional part, used for laptops that have firmware
     configurations for different makes and models of internal speakers.
 
-The CS35L56 Rev B0 continues to use the old filename scheme because a
-large number of firmware files have already been published with these
-names.
+Early firmware for CS35L56 Rev B0 used the ALSA prefix (ampN) as the
+filename qualifier. Support for the l?u? qualifier was added in kernel 6.16.
 
 Sound Open Firmware and ALSA topology files
 -------------------------------------------
-- 
2.47.3


