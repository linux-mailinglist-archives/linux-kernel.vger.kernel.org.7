Return-Path: <linux-kernel+bounces-894705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD88C4BA85
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 780623A19D8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 06:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEAC2D73BD;
	Tue, 11 Nov 2025 06:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="TykWPF4e"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011000.outbound.protection.outlook.com [52.101.62.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D961A2D3EC1;
	Tue, 11 Nov 2025 06:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762842075; cv=fail; b=iB6rFDEloC9Vx4DFYUV+aeubfOSNJiFz1Wikd9BfSadynSTpn3D2V66ty5Rv9VK2qXA+lI99Sg0BuGcNQ4DE202trZlpKNB8tcRYpoQfoeDpH4dQVczgows/V3RA0/nrzy4bF0Kjgb5vo4G1bR2jO3DcDEBlgyHwpkjB/a/FGuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762842075; c=relaxed/simple;
	bh=DFtxAR1qmjQ1LWmeSq4tL6CwynljS63f3muY4j5cNHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NQZpD8dx17Q1KTtsPaKXTgp7vyLQDpH4q7WxNnQGzeRv2VYgsAs5T+veoouWavy5CnlgpsA4oIvRMp9R2BZz+40FiJh4kYaQ2K7LxnysK55ELVRKBgQ0ny95q0LkdWn+0mve+XtYspR7QRBCOL+ip+oCbjKzLKQ5TOehSmOXRrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=TykWPF4e; arc=fail smtp.client-ip=52.101.62.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VxeMTbp/8U9T0S9A+ggP7jRPEy2w0mSEHnpmlKBzG65PNmkMVng1gYWK4t2LE3NDOpCdHlrKw3BkWLh1JrZ74gtnBbdIE3TBLkks7xg8rsqO3h158NGWdoHqYgzoFys3dkhOaqDaZMZij8WNAwgJigOnJtSzc9AxL/XmILf3EJc8QSrnGY5ZGRfpysya4w7IQzHLS+Ku7ir1/HQbes2/diD4XgBNHo5Sq+i0UOl+p5t78mlP9CxvvN7JP8VVu7w92UQYG/qwIpGEgM/16ED2UreRxaexshHxU0Uk6WiS9XSWN9id6tWH7OCVealRpkkBX3ulqnXY6FaBQy1U3Qbz3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CU+Wr7xsdOQDUCuEzG6ILUKts86/Dd5ug1Hv+Ota0Dc=;
 b=O2a+YjbYsKMLLwEJAEz0/5aDCuLDEqcYqzqhwkQgsi8P+SbI8Jlbc/oyTj5mmVPO3X0OeyV+BaSYf75dNbfyDFypkGBbEijhoBK8daL6Qq5WRhAuH145mMMDoYMAfo5x3+ZNXRKLwtr1Ln0JGIAxBKfO7QTh7USCA2ae16i9RiJY0Fq8jCAkYzwupizCYvbUzwLCkInWpL96Bpddu3kzOsvvmSDWuuoKte9CSknzJYr1/TUfJvbdbD83azKupz0RXTHtv8HvjxTarjHCTAdyYEAOULuI5bws//k+5G16IY6Q6gYiJoXFPmEe3mesaQitkiOJLFRK2DO6nperXZTnVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CU+Wr7xsdOQDUCuEzG6ILUKts86/Dd5ug1Hv+Ota0Dc=;
 b=TykWPF4eeXANnblbkWA+xFfsJyeePYpcPGAJW0vDj3Km44elKFsvp4w/AkRDApt1IlF3QsaHk7Ch+F+mDJL6MpmIKSj1nfwFB+KXAIewtINhvi1sCzs3kL8rEyZHgadtRQdpz82cjuh7i8QNFC7wZRRQC8Gz2g5YWdrNx2sVXpX95x/Rn7YKR7EMMc8xqIm3zG0nQbWAL0SiM8+1ufAM/fMaD1yGuP1a28GfC4ZTPB4BmX3Yd1zD7MKm6bsNFRQ9d5/Rtcnu6kzZgwyRa9AAk3nJUDGswkliTYglMtCffs85iq6n1fOE1mUebvq7SxIYpOMbfAoJwI2MMRxknO6XvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 DM6PR03MB5049.namprd03.prod.outlook.com (2603:10b6:5:1ee::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.16; Tue, 11 Nov 2025 06:21:11 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542%3]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 06:21:11 +0000
From: adrianhoyin.ng@altera.com
To: gregkh@linuxfoundation.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	Thinh.Nguyen@synopsys.com,
	devicetree@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: adrianhoyin.ng@altera.com
Subject: [PATCH 2/4] arm64: dts: intel: agilex5: Add USB3.1 support for Agilex5 SoCDK
Date: Tue, 11 Nov 2025 14:18:46 +0800
Message-ID: <7ec6e1787a677f6614f7f991a31a9ac58b539780.1762839776.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1762839776.git.adrianhoyin.ng@altera.com>
References: <cover.1762839776.git.adrianhoyin.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KUZPR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:26::14) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|DM6PR03MB5049:EE_
X-MS-Office365-Filtering-Correlation-Id: de58be51-a393-4212-b94e-08de20ea8211
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MkEwSioVpoC3eRsQAloKGS8SonqVh72aVOVGIltCpGb4PStrPQgzUS+WvFnY?=
 =?us-ascii?Q?gkGbKH7YU2KXHU4dMzBtEU4GrxcFWxyWSQwO4sT03xpF+6RJrw9znpNZje69?=
 =?us-ascii?Q?RZvKEPHnliGPmxQUNs0vG64/AKKivWpo5uLrV4pqlI/+wDKB4WbIaeV8YuSo?=
 =?us-ascii?Q?cUvuUYaLEhXCh+K+WO2WN+H1AMHBe3JIuLcU25DPcAXBltq0/9H60iC+fm7m?=
 =?us-ascii?Q?nqHpm1+9jaQRTjnyGjnkKYmi9EGRkTD66CUYZsUuhveKvKwK6q4wgmG17bmt?=
 =?us-ascii?Q?J7uB9rt0p3su0pQKC4Nbr9S7Fh+vxGhaJz0t/CB4hbGN5qzZYEQoRz+HwL6S?=
 =?us-ascii?Q?wHeuovwDOAwGjhi8bfgCw9ceihMgC6Yu+jRMio38BkdF+UtVS8POS5L1Hl0c?=
 =?us-ascii?Q?iwm7t6GscR7bHbTCIsZmmj73COXroilHyyS/S9EprnfRZC1XSuG60YRiCOI3?=
 =?us-ascii?Q?6PFIYsq7MecKKKUYVjiMSvabdlUlqH8LfXDGgy2lnh8xthFskazUoOup3YEo?=
 =?us-ascii?Q?bAEDj09LkKkxkg2LIH4Yg5S+RMrOJzZ6ZNAsFGaPJS/2sBlwJ7olrZyt3OU8?=
 =?us-ascii?Q?k7o7LfJspwSAGfo/MwstkPStyT8NpRrLS5NvSHMicwiZTF2Ml9YHi33ofoAg?=
 =?us-ascii?Q?cDA55TvazEyiqJAYzj7lwHOUBubXBqT/C+NeonDL1SxLuSsxCahxyUzJJyFl?=
 =?us-ascii?Q?tYQCCGMevOLpCVt2qzg5U4Zp4Lstd1Z3g/sO1ytNOAruQrpQiqHZY+Voqv1V?=
 =?us-ascii?Q?vorcIOfX1kaBm9t1A49bws7+srqlIkx+kOb5sEujbLiuSmGLTTLllLaT5tk8?=
 =?us-ascii?Q?S9MGJtUY051WzcUIpfI+abgV2+f/3PykE9Z4qFCLaEYXsyJdgGxxZcNvOFOZ?=
 =?us-ascii?Q?eBtCympqm28rvkEKKS7GC2uLSkjgb60GP6pSYvfaPkSW2KopoXbRTFG5H5Dr?=
 =?us-ascii?Q?mqNM9YljwgLHUBU+4iK1Ys3r2e9mnfwzjK99qjOvkQYdC76+T8vks7YnijNJ?=
 =?us-ascii?Q?GXWJi0RPLmeOaVSrd1ovGM6Fzu3S6ivQjbyUYYte4eDm6gQPgqkLIFW+fVii?=
 =?us-ascii?Q?kIZnqaBlCl7Q9ck9XQynLy/OLSnYUDtLd7vmkOGFJbZatyNxOtIDXknOZ9zn?=
 =?us-ascii?Q?Fzfa3DhUlxx74BFKT8EZ/ntqOiTAuXGRIWAZK6tCEgABaCE14+LrLaTpGnUI?=
 =?us-ascii?Q?KvkwCqL2Bm0mKkW5A8RlmPMYDtrArsLkasSmX2l8dHqBGukKbdc7Y7ofSEjV?=
 =?us-ascii?Q?2utZysKJMosjirIZq5H5z0nYkMAjbxyLz+evTMFGKczHpxJQz5lTdkVXVpdS?=
 =?us-ascii?Q?OxMgZXuwq8AeV5TaRxZDHJp7gkYtBvjCwpi2XTOphSs+f/SjrAiXtye79aKU?=
 =?us-ascii?Q?lAor2K61111brDdzseHNmRx4KWESEVtujLUxtHivhW8jecynLFC0yMy907Q3?=
 =?us-ascii?Q?1nq5068syisviw1/p8BeCw6bU7Cp0LDf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xygQJuceMmewrFbARw43ndSnNYAiEjzm6yzCvzQvCkBgSmVP0G44CUH+ALZB?=
 =?us-ascii?Q?4eMHOdOP0tYcpZDVLgCGo+SFxm9IfD1RabfzSB6tcJB0+kRYwa0EZvpn8Ckk?=
 =?us-ascii?Q?h6w1jTuXRm3UVLxcXm3GqaDWNNQ0shzZ/eNE8RbfHLt5woEuLvG0t2dBpf3M?=
 =?us-ascii?Q?kv0UFVo6tdJ20v3HUaye+NDDLqZ9TewkIe8jCUmmBCwXErVPejUDsA9oEvtU?=
 =?us-ascii?Q?eR+75Bq2nEA7bl9hlX18q4qQIjlkfzyy5vYU1Xe7GFFOndOFBsCFdwp4CMYY?=
 =?us-ascii?Q?SU3Z181TDRyDwtW3qovzhMxKsL3SclftI1uOvFNRGmgm1DYWQgPhjBVKZF9q?=
 =?us-ascii?Q?0rHehcl1HYJom7EMVk22PiYVY4IdLxFDu5w7+N8nDtrPIhYyXVPPo1+cIYJx?=
 =?us-ascii?Q?91vc4Txm/xPbSMhO7xByYrODxjP6jDZMc/zCjmzDgk3NiHCGRPtGydEKonky?=
 =?us-ascii?Q?ckUX+sJ+nG7M0VVJhwjpSW3O38nB45yU4fWQ/eZIUpNL0GywRK2vdWY0CZpS?=
 =?us-ascii?Q?OkehU0v6BU5dqAYb1aIO0SRE1W1f1U54aCIr0YBcp5utfRdydHqUh0XArgC9?=
 =?us-ascii?Q?Pt6+Ipy79tkGER4WQWoRcmeitClOUwDJ0+dYE17tfCVSNHnHlb+gBm44+0MX?=
 =?us-ascii?Q?vrte1jq2c2mI5ohctjIYXGPLJufFTUqP53mu4OFYk3BA5rC7BEOgDGP0EAvm?=
 =?us-ascii?Q?lSoWxZ4SI+0oPBFwVTix1334dAuBlK3+4n5LEYBdyraSnQlmL1KWWe0S3oF8?=
 =?us-ascii?Q?MhUMmr224MF2V8/Zj/j4xGz2gnLLk1RQXrNcHFwwI6kKu2JjtFzsID+4UbJC?=
 =?us-ascii?Q?0qibB1eJn9y5Xe3felhRWUbMHks2jXL0s9PXocLTeYxKcazZhU+rjkU5B8x5?=
 =?us-ascii?Q?Hb8fwb8/6pyYwobAjqXI/62ecnZDNGSTAsfUx3enkGGHzzjjD3E00a9OyzGw?=
 =?us-ascii?Q?K1zHFx/iU7Mv6bFGPSfcdQJY2pMbL1Qfi9BOhCUwiC9ag63gnv+qdMOnukIj?=
 =?us-ascii?Q?5nY86o3mcgzn0B641ZCnQ/7FjHA6xKZ7M7UuM9rgJ14vKXBw+ILixX9UVmQq?=
 =?us-ascii?Q?d2lIyoD7YpEi/NDjbdIAL/u8JU0Gc/5+A+57Or4UqO7c4Rt+WCLMxXqOFgfU?=
 =?us-ascii?Q?otod64AUSAepEwehOX0bPw6EqyV1GRl/8thavUBxs3oFxfK4ifk17JXVRE10?=
 =?us-ascii?Q?ok4yUXLjLAPoOJQjVTFptuRcYQHog+1vMGyJsEcyrQmBTfWcvgjgIB/eedR4?=
 =?us-ascii?Q?Oj1RcgyQvtYy7ti78fc7IrEHjeriQFWTVSOC9rxX3ry6dHnpRE1gGnr2rexJ?=
 =?us-ascii?Q?k+ts0P6bV9RJg1BWwa0J7BdhIyTkcKsumvSBr4xig+ADpStv8ojXOm9TtdN0?=
 =?us-ascii?Q?0mktQlVAQt+AQbWqumnMQjVLP08SimKKN/9+nMDKQUavHcq8lnifTg8LNq3x?=
 =?us-ascii?Q?BqeVuAAZgzzLfxEaNQqL2wzFsIhCrlyFA4pVvuk3wWnyk6MU3Ch9Dc2pGtYL?=
 =?us-ascii?Q?A9crzOYV353zCN/s2B99GTC4B/EpMa/l47viNgQbCmoj4zWSH9zEKsEJ3+zq?=
 =?us-ascii?Q?neVQsiHei8ZHvwCHAQyF+14jSjjAOP3m+8J6AWp76GyiZ36DzgyjosnQrKzY?=
 =?us-ascii?Q?Dg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de58be51-a393-4212-b94e-08de20ea8211
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 06:21:11.0611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HLC5zXiCrRmJwAETslGoc+sbJ3KKUBkgRx89aF/P7DNvMUp0ck56egZS6JBl+U+8Qx8iK8Ty3qYE99Ah4U8oRkXvr4eQxo9vpxsnek+I+Tw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5049

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

Add device tree nodes for the USB3.1 controller on the Agilex5 SoC
and enable it on the SoCDK board. The USB3.1 block consists of a
SoC-specific wrapper around the Synopsys DWC3 core that handles clock,
reset, and address translation configuration.

The DWC3 core is described as a child of the wrapper to reflect the
hardware hierarchy and comply with the DWC3 binding requirements.

This commit also disables the DWC2 USB controller node, as the daughter
card does not support simultaneous operation of both USB controllers.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
---
 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 24 +++++++++++++++++++
 .../boot/dts/intel/socfpga_agilex5_socdk.dts  |  9 ++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index a22cf6a211e2..6253bda0e819 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -444,6 +444,30 @@ usb0: usb@10b00000 {
 			status = "disabled";
 		};
 
+		usb31: usb1@11000000 {
+			compatible = "altr,agilex5-dwc3";
+			reg = <0x11000000 0x100000>;
+			ranges = <0x0 0x11000000 0x100000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&clkmgr AGILEX5_USB31_SUSPEND_CLK>,
+				<&clkmgr AGILEX5_USB31_BUS_CLK_EARLY>;
+			resets = <&rst USB1_RESET>, <&rst USB1_OCP_RESET>;
+
+			dwc3: usb@0 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0x10000>;
+				interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+				iommus = <&smmu 7>;
+				dr_mode = "host";
+				maximum-speed = "super-speed";
+				phys = <&usbphy0>, <&usbphy0>;
+				phy-names = "usb2-phy", "usb3-phy";
+				snps,dis_u2_susphy_quirk;
+				snps,dis_u3_susphy_quirk;
+			};
+		};
+
 		watchdog0: watchdog@10d00200 {
 			compatible = "snps,dw-wdt";
 			reg = <0x10d00200 0x100>;
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
index 262bb3e8e5c7..af301191b262 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
@@ -103,10 +103,17 @@ &uart0 {
 };
 
 &usb0 {
-	status = "okay";
 	disable-over-current;
 };
 
+&usb31 {
+	status = "okay";
+};
+
+&dwc3 {
+	dr_mode = "host";
+};
+
 &watchdog0 {
 	status = "okay";
 };
-- 
2.49.GIT


