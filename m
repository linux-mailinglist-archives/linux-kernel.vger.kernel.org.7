Return-Path: <linux-kernel+bounces-860922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F171BF154F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F7723ADCC5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB83F3128AC;
	Mon, 20 Oct 2025 12:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="DnDU3q9L"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020087.outbound.protection.outlook.com [52.101.84.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667BE30DD2F;
	Mon, 20 Oct 2025 12:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964578; cv=fail; b=MDDOv7wYqjjvsHlCk/y5Op4FqkFnosTjV50K73yF9+Dj/FddgsBKVr5UgsbMD3RxaH1FO0OumC7IGvLUWSJMR2OyiZB7J+ygBnYTxXIG4Ct4NE498hwiJIc/vzAaothd1AIGy89YUpUuxvpt/VwZKlkJjfXM70kMsVWyRWtAbP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964578; c=relaxed/simple;
	bh=s+dZtL2A+xn9AGKtFGYAU0NZkkF8HsFSkZQvak0FI10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fPORpUNjQ1QamR/ofEXVbNR9Z949PRmxzmu4ZmMs77SVr7PjiU7MA9RR/OX/jYjiPuvDppk7wb5gyiXZTlow/P2CXsvYaz5JO7awy+YM3rCvosso+BTRMnQ2YwISVV8P6cUi6mMuYHJlWTip8HWm/I1xSeXXyYhwBBkbLVREPGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=DnDU3q9L; arc=fail smtp.client-ip=52.101.84.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5Sg/GCnSED+xuq7PM+Av6JwJl0PQVZ/5yucSaGPqcvo7Ghw2aGgx4zHuHoG3RutnixV1raH6KAbjoWTX7HLqwl34USLnI6QDwf43RL/Rxq+C4he6vaWp4rcAyagt2D0i6ec/B1C3fev6UzsvK5YZabq+azEAGgZKuZMgqj8VqDhz7MGtN8fKF+jY0/n/zllkyVy8eCEXvCk9C6veLRkx96PMHpzlcEFg8jbYeJCea6VJYBm/ibi3WQKF04U4yDvkR5yr0nfvBvEpt00VUbtYWNmswaKxpsGH6J6D0idMfWKvIFgKt8VPyQCFMEww3CPPaAJMqYv2pf7uh4qvyqFzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4E5Xy+RbGASl7w1xl3zDqvs6lBgfPL6F8TAFcUfTlfo=;
 b=u2Er1sIf7mlubPNwnsYq9eBmsZEc3EzbDgaH5wunSlO/j5sSx7pBtlxmTK1WkhhOb/ree4G1BTvXiEVFvGOSCcV97xScO9pCYT1HMKqy0TMYv5+hurribENkB+oKyiRYi4+TE9L9UClRLMysDxd6nXTL2DaimwFz+Zt5Yz2wVxh4k8hSJqujLW6dAca+r35pyQM9fOxyaluQURib+HG341YT8C4ICioXHcny5t+mF+2TFqWNdjiV8uu/pWChIK1DANQ1bCWWREXlnGh0kvFtJ77g//XxCbz2/lgD7T8sfdfQnoxeyfbBRZ7CQLJS+ZvX9CII12lzsBPq/kMuBfDxNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4E5Xy+RbGASl7w1xl3zDqvs6lBgfPL6F8TAFcUfTlfo=;
 b=DnDU3q9LO7Zzd6BT4kdktwWhb6OkOmWjTPHjUODKe3FLaLDlUudvbzw/tMzTRbM0vBlY2u/JnzZsWYxp7HKNCMccZdwE0hebS0hCCDXse4BJDCL5AkKWZ+OE93kEN0mMKxruLM6519nVcfhEI4Cxn2WxyW+9xBWYjAE1Ovx8NM/eCAC0IWn6WAqtB9UmYyBRYLxkZrrSmuaaCtD2NYQ9sjTfg0N/uT64DCzRv7wV1gqL9jrNzSRvAvtVINUklq7kQaj9sfV786nd0YlvyrbJxdvtJtuDAA1OamjdqtuEzz3C4Tisvsluw3eqAu9ayLmnpOL4GJvJHbe73YcL9YpUKw==
Received: from AM6P195CA0011.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:81::24)
 by PR3P195MB0975.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 12:49:31 +0000
Received: from AM1PEPF000252DA.eurprd07.prod.outlook.com
 (2603:10a6:209:81:cafe::15) by AM6P195CA0011.outlook.office365.com
 (2603:10a6:209:81::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Mon,
 20 Oct 2025 12:49:31 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AM1PEPF000252DA.mail.protection.outlook.com (10.167.16.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 12:49:31 +0000
Received: from [127.0.1.1] (172.25.39.168) by Postix.phytec.de (172.25.0.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 20 Oct
 2025 14:49:29 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Mon, 20 Oct 2025 14:49:27 +0200
Subject: [PATCH v6 4/4] arm64: dts: imx8mp pollux: add displays for
 expansion board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251020-imx8mp-pollux-display-overlays-v6-4-c65ceac56c53@phytec.de>
References: <20251020-imx8mp-pollux-display-overlays-v6-0-c65ceac56c53@phytec.de>
In-Reply-To: <20251020-imx8mp-pollux-display-overlays-v6-0-c65ceac56c53@phytec.de>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<upstream@lists.phytec.de>, Peng Fan <peng.fan@nxp.com>, Yannic Moog
	<y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DA:EE_|PR3P195MB0975:EE_
X-MS-Office365-Filtering-Correlation-Id: a172fc8f-fff0-45e1-126c-08de0fd71d26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OU1Gelpmc0VkSFZwYWZ3bHdXQ0YwUThqN1kzdEVIb0hQaExyM0x1d1JIQWxu?=
 =?utf-8?B?UEpPU21ORWVWVFU5WDc3b0wyMll5VzNHdTB1TWxmRFBBUC9LZnEzbzFTRlMx?=
 =?utf-8?B?ZU9uekY1UmRNVzM3K0RZSlUzS3ppTEtPbFdqVHljMUNjWjhaOGVsSkZVa3ha?=
 =?utf-8?B?TXdhZ2FpSnh6Ukg0VjRLWHNRN0xOQ1RzdWhTYnpNUUNaY1BxeUpYVDJnMnRN?=
 =?utf-8?B?SGcwakphT0FFK3lnbmlSNGNaVTZ4d2dvb0w3VWJMSURzTFFxRlROVVBMUEJ1?=
 =?utf-8?B?aUhDU296VWhVVEtzWFdXSzBZQmoxUXhMbEtPckRhL3dlZENuY2kwb05jSFk3?=
 =?utf-8?B?VC9tZ3RRbHJuZGJYTnIwci9hOEllWkoxQWNvWTNubzhhbDRKakptaXM4alVr?=
 =?utf-8?B?NlZiMk9DVHlIS1N1MDNDaUxUVDdvMERCUkNJUGRnbXNOYXdiNVJRVXNnVHBT?=
 =?utf-8?B?eU12Y0hidEs1N2gvWHR1MzZ1blI2YVlzcXBDT3VqK1ZzanJBVzBLdUdsUmQ1?=
 =?utf-8?B?YTFxNjIrS1I5c2tHOG1Pd28rOSt0ditMVFRKczZVVVRwcXVKbXJVMGFsdEFa?=
 =?utf-8?B?ZUFYNGVuUWhZeXI3STZQTWpEUU4zYm5ibmJYQ2UzelYyNm9nUWJ2NGQvVlg4?=
 =?utf-8?B?VkVneFM0ZndTSGhyY3AyS0FTN2F1NTcvdGU4RE5BcU5wYi9FMGtZdGJIOGQ1?=
 =?utf-8?B?WXZrT1JlbWhtZGFsY1ZJODZFUXlnZDV1clBpWERWN2FaZjVnNG5UUDJlYmNw?=
 =?utf-8?B?SDhxMG9OY0tYUmZaTHRZeEJKRS9qamxJK0c0VjhjdSthaGo1a2tPZ1RIalhk?=
 =?utf-8?B?QVoycGRNWlRpZHMybDdjc1g0a3o0WEFNOGRhRmo5ZTI0Wi9HLzd4OS9BNFNC?=
 =?utf-8?B?WUdkL1pFVWhObTg3UnpQS2RzQlg0L252ZzVYUFNKb0JCTFVXS1kzY3VRVDVV?=
 =?utf-8?B?cUovWFRNN1ZMditrb1o3SUVHUGJrM0o0SHQ2amJZYWZJZ1BJdXJKRVRQTkxr?=
 =?utf-8?B?TzhpdFd5cjFuZjM3NkMzTVhTdTBERlBpRlJ1eGpncFI5RTA1UWFuYTlCUXBV?=
 =?utf-8?B?WEpUM01ONlRwd0pnc0dVeUxvQTZZZFB3NDhabUYvd3daN0JXbm8xWk1oUzlt?=
 =?utf-8?B?RTBUL00xM2hVd0RKaUNBSzB4M2R5ckgrMWkzMlhkOTdodTVPWmRxdWxpNlR2?=
 =?utf-8?B?cHEzall5dDcwdml2aVN3eVYrWGlSZ2lRUzFsMmxhNThWeDVmZDFCQ3VrakV3?=
 =?utf-8?B?d0hHVklMVDE0WlZpdTViY0RBUEM0K1IrUFJtdVI1RjNic1VVczdEdkVmRXRP?=
 =?utf-8?B?K0c4Wjk3cWUrUXExdFFuSGZYUkhpRmtEVmNjK2ZrMzh3NlJXTnVmd29FQ0JK?=
 =?utf-8?B?eUtWUnIxTC9lVU1HRDdueWVVYkdRQ3AyMytWbUtPR0gzZHZPaldrMW1hdTNL?=
 =?utf-8?B?SUcvZlp6L0JFMUxxclZFTUcxUFkxbytJL0Y3WTdhRVZRN0owTU0zTVd1SUhF?=
 =?utf-8?B?TG9CVzJyTWdUWmhmUmdNUTdxR1didFk0dGJvQ2Q0V3FaRXEyUXhQaStSK2lB?=
 =?utf-8?B?VFpIeFpmK2M2ODRmV2VDRFFHWnJ3c0xRUDJNd0wxZnlETWp3T1FTaHdoU1Zj?=
 =?utf-8?B?dnFYMXdwWHVvNVVkZnJqSFB2Qy8wMklwOWxkcXdvQS9NN3JLVTNJR3RYTkcz?=
 =?utf-8?B?M1I0NmFJSFZPU3dHd3NyeDFOVDRHTkVSTXhKYzQ3Q1BPMS9ieWFzSWhPd0tV?=
 =?utf-8?B?Q3hRKzJjRnJPQzgxNU15aGRsM2UzeWZBMFdscjRFS0x0REd1alBLSTZ0MDV2?=
 =?utf-8?B?bWZDZTVyRUJjeEQzVVE1QS9VL21reTBhWUNEUG55R3hZeEhoL0hDNGgwUzlT?=
 =?utf-8?B?dXhCS1hVLzBQall6MitpVk8zVWIza0YySWt1c1JIbXJIT3luUUFXNXJualMz?=
 =?utf-8?B?VGVCS3VTaXFodXhiVkhmVFA5MHlKbEhuaDI2LzZaaUpnZFhDTHFjOHlqb2VX?=
 =?utf-8?B?Q0lyMytRY2tTME9neGJJMnp2WXp6QUNYblViV011U3FsTUl3MmNsd29RRW5k?=
 =?utf-8?B?eFdrYzkxeU1ST1ZCKy94N0tWcmZjQkZ1RVl3Vy8yZW10c2s1MHhDMWJxczhs?=
 =?utf-8?Q?GyyY=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Postix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 12:49:31.4156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a172fc8f-fff0-45e1-126c-08de0fd71d26
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DA.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0975

The same displays that can be connected directly to the
imx8mp-phyboard-pollux can also be connected to the expansion board
PEB-AV-10. For displays connected to the expansion board, a second LVDS
channel of the i.MX 8M Plus SoC is used and only a single display
connected to the SoC LVDS display bridge at a given time is supported.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 arch/arm64/boot/dts/freescale/Makefile             |  6 +++
 ...mp-phyboard-pollux-peb-av-10-etml1010g3dra.dtso | 45 ++++++++++++++++++++++
 ...8mp-phyboard-pollux-peb-av-10-ph128800t006.dtso | 45 ++++++++++++++++++++++
 3 files changed, 96 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 9c121041128972d2239e2cc74df98b0bf7de1ac2..e4b097446440f41785dd1a0e5d354796e800ee76 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -222,11 +222,17 @@ imx8mp-phyboard-pollux-etml1010g3dra-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
 	imx8mp-phyboard-pollux-etml1010g3dra.dtbo
 imx8mp-phyboard-pollux-peb-av-10-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
 	imx8mp-phyboard-pollux-peb-av-10.dtbo
+imx8mp-phyboard-pollux-peb-av-10-etml1010g3dra-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
+	imx8mp-phyboard-pollux-peb-av-10-etml1010g3dra.dtbo
+imx8mp-phyboard-pollux-peb-av-10-ph128800t006-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
+	imx8mp-phyboard-pollux-peb-av-10-ph128800t006.dtbo
 imx8mp-phyboard-pollux-ph128800t006-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
 	imx8mp-phyboard-pollux-ph128800t006.dtbo
 imx8mp-phyboard-pollux-rdk-no-eth-dtbs += imx8mp-phyboard-pollux-rdk.dtb imx8mp-phycore-no-eth.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-etml1010g3dra.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-peb-av-10.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-peb-av-10-etml1010g3dra.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-peb-av-10-ph128800t006.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-ph128800t006.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk-no-eth.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-basic.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10-etml1010g3dra.dtso b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10-etml1010g3dra.dtso
new file mode 100644
index 0000000000000000000000000000000000000000..aceb5b6056ef1298ad9e105e673c7ab403411ab0
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10-etml1010g3dra.dtso
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clock/imx8mp-clock.h>
+#include "imx8mp-phyboard-pollux-peb-av-10.dtsi"
+
+&backlight_lvds0 {
+	brightness-levels = <0 8 16 32 64 128 255>;
+	default-brightness-level = <8>;
+	enable-gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
+	num-interpolated-steps = <2>;
+	pwms = <&pwm4 0 50000 0>;
+	status = "okay";
+};
+
+&lcdif2 {
+	status = "okay";
+};
+
+&lvds_bridge {
+	assigned-clocks = <&clk IMX8MP_CLK_MEDIA_LDB>, <&clk IMX8MP_VIDEO_PLL1>;
+	assigned-clock-parents = <&clk IMX8MP_VIDEO_PLL1_OUT>;
+	/*
+	 * The LVDS panel uses 72.4 MHz pixel clock, set IMX8MP_VIDEO_PLL1 to
+	 * 72.4 * 7 = 506.8 MHz so the LDB serializer and LCDIFv3 scanout
+	 * engine can reach accurate pixel clock of exactly 72.4 MHz.
+	 */
+	assigned-clock-rates = <0>, <506800000>;
+	status = "okay";
+};
+
+&panel_lvds0 {
+	compatible = "edt,etml1010g3dra";
+	status = "okay";
+};
+
+&pwm4 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10-ph128800t006.dtso b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10-ph128800t006.dtso
new file mode 100644
index 0000000000000000000000000000000000000000..559286f384be452f1c953689e03249fbea24fac5
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10-ph128800t006.dtso
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clock/imx8mp-clock.h>
+#include "imx8mp-phyboard-pollux-peb-av-10.dtsi"
+
+&backlight_lvds0 {
+	brightness-levels = <0 8 16 32 64 128 255>;
+	default-brightness-level = <8>;
+	enable-gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
+	num-interpolated-steps = <2>;
+	pwms = <&pwm4 0 66667 0>;
+	status = "okay";
+};
+
+&lcdif2 {
+	status = "okay";
+};
+
+&lvds_bridge {
+	assigned-clocks = <&clk IMX8MP_CLK_MEDIA_LDB>, <&clk IMX8MP_VIDEO_PLL1>;
+	assigned-clock-parents = <&clk IMX8MP_VIDEO_PLL1_OUT>;
+	/*
+	 * The LVDS panel uses 66.5 MHz pixel clock, set IMX8MP_VIDEO_PLL1 to
+	 * 66.5 * 7 = 465.5 MHz so the LDB serializer and LCDIFv3 scanout
+	 * engine can reach accurate pixel clock of exactly 66.5 MHz.
+	 */
+	assigned-clock-rates = <0>, <465500000>;
+	status = "okay";
+};
+
+&panel_lvds0 {
+	compatible = "powertip,ph128800t006-zhc01";
+	status = "okay";
+};
+
+&pwm4 {
+	status = "okay";
+};

-- 
2.51.0


