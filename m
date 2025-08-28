Return-Path: <linux-kernel+bounces-789856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF3AB39B96
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 632A61C8032D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F8230EF8E;
	Thu, 28 Aug 2025 11:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C9cwxVvE"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C5C208994;
	Thu, 28 Aug 2025 11:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756380634; cv=fail; b=ZMnCQRsLgYjB0dg4DPtG0XNw9Vm+fi5C5T7hFYNS7OPzwSxZmmllkcjsSJE7hAE+M+4SBz1jMblx7mT3NQnI2fVJEptdJKEpWAsyxtLU6/ZMkV90pQcdw2a67oXMCGA8rt2wIRh5nycvVDaO/791xzpRKTu+orA8VVP4vUxY074=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756380634; c=relaxed/simple;
	bh=ZW5oQQwQOl91dEY2a4IRXYtsE9EUX42HwrIRLt1SGnE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=phiuOKAJ6HFbgsvecXaFQX4FgTsFq/30l3/ojPVNKLzTCvyBA2IgThXUG3Y3jkFz+3MkLhHRh7JOY/SLuWiI3ZQjkbsFMIVlp2pqsIxrIoTOj5b3sC8iA+SECD/lJF7r/JF0p+DV2vGQmwK/cGfo0MI4tISQjoiBpNIWdJUbZaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C9cwxVvE; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgOxM2rMOqYO9jgzy1yIGCw0DJR7lQRPqJX2xRtOKacD/g7BH7xVpXT6/Dy3ho4EIN6qSYvYdH1PAgvhSIr0lGLgqhGQNt48UjUMPGGb7BLlJVw01jpSyGWyqTUGUOa6VNt0C34frVd+PT9SRfdelpy7VFr+3Tr56icBJmqSEj5M+uoLtGuYgdsJTTlXj4N/X78NFHr/JxprEe60uHUIz2p+FNKd4y+G1Y2nF8SunjQrCpcBLCKVsL/qqctuE8Tebok167nPfWOAHsF4a+ky8faZaLoiMcgy24MD73NhkCIW0KEQRWrG+qDw5uO9RLxk+l4NJNDkQglKMi9BTXKOzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaVe6+EdNumKhu+obM1hpLejQVVP5C2HuCP1OQVYX1g=;
 b=DUV+WDsscinHC6E5wd9MQ49w2ZrELuh7WuSs0cOdg7w01moRZ8YAt6FCe/ApJCXmBKWWC2dwi5WPRKpBe3Zmcb0n0nRqfAcLhl8AAa3wNtfSGZ6+YwKunyj5tFitfQGv1qsh7vZ4GbC08HYHuxnGhYbvYQNt3jbOoTo1tEz5I2tuvQwWeLOvHI3+B2sc+y21VnKVcrTQL4opvi4JiZbrITuBghVXU5HhXBZW+VZZBHqoEmfBUH1p2y6XJ3W269HFQnfOsqQsLb7dy+YGuPS77uwLl0eKkJnbHz+/7cVvUi4zaFeUzM7lRH3KVj4xCBaBomPGm4YAIxQQM+xrzPOcug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaVe6+EdNumKhu+obM1hpLejQVVP5C2HuCP1OQVYX1g=;
 b=C9cwxVvEyom3CYuFLAjrTSkzpvbgG6UibD5RZa80LJfPVC0etrp4PmzeOioYNVCYbe7FWL4lPIe5WSeGwUE5NWQ08ZxDmNw5CSxSmnEKI/+CeeaF7d4RtQ1k2Q7z4go35qqkbEJrdqGYGlSOnWC3H6AlM3vsHWy8wJHqedYlvsc=
Received: from BYAPR01CA0026.prod.exchangelabs.com (2603:10b6:a02:80::39) by
 MN2PR12MB4318.namprd12.prod.outlook.com (2603:10b6:208:1d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Thu, 28 Aug
 2025 11:30:25 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a02:80:cafe::15) by BYAPR01CA0026.outlook.office365.com
 (2603:10b6:a02:80::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.17 via Frontend Transport; Thu,
 28 Aug 2025 11:30:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Thu, 28 Aug 2025 11:30:24 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 06:30:08 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 06:30:08 -0500
Received: from xhdctallapa40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 28 Aug 2025 06:30:06 -0500
From: Srikanth Chary Chennoju <srikanth.chary-chennoju@amd.com>
To: <gregkh@linuxfoundation.org>, <Thinh.Nguyen@synopsys.com>,
	<m.grzeschik@pengutronix.de>, <Chris.Wulff@biamp.com>, <tiwai@suse.de>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<punnaiah.choudary.kalluri@amd.com>, Srikanth Chary Chennoju
	<srikanth.chary-chennoju@amd.com>
Subject: [PATCH v2 3/3] usb: gadget: f_sourcesink: Addition of SSP endpoint for ISOC transfers
Date: Thu, 28 Aug 2025 16:59:44 +0530
Message-ID: <20250828112944.2042343-4-srikanth.chary-chennoju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250828112944.2042343-1-srikanth.chary-chennoju@amd.com>
References: <20250828112944.2042343-1-srikanth.chary-chennoju@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|MN2PR12MB4318:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c4acb40-2f53-4798-4677-08dde62647c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f93PyFZJDUtxzyDNii7gqn4FW3TgYO04TFv/Yhyw9DVc7UvP6Rd0rshtm0oA?=
 =?us-ascii?Q?MTg05+y3+GD035BrFspi6+55Iw7eteIfCvpylDfWsZgCaZhfQz23x8BMSu9y?=
 =?us-ascii?Q?M0iTKjWQd+xjMHwk+8lg2kzPBz4Vxhyu/HazsfwLKWYAdPoVVAQqxkJ64h9m?=
 =?us-ascii?Q?fJiLkBzac/FB6C/Hr7SEupaUXLdjDlW4LQO/ANIKWh9OrOQamaKLQNbpw6YC?=
 =?us-ascii?Q?K0hiG9LmUk4INQJgjI0WBNAAw6GvMxhSFTdpxgedB8WzaatA1NQoJzXLc+je?=
 =?us-ascii?Q?8nQT7IMpFBRTu5XcApYQcuCq2TWKU8/NgMNw7Si6jfgj7y2HQ/bq53ujeapN?=
 =?us-ascii?Q?2a8nBG3C319Q5tvD58do+Jjo+ql2VHm7oObHfG8cvnOt/jRCwvURBuT9WWJe?=
 =?us-ascii?Q?5b3D1xQcSvzvmyVspaNmHjdMAF+PmARpmW1U2q7gxz/yvCUocoXm5orYST3t?=
 =?us-ascii?Q?niKdSpGl8Q3ftg0A7tSDx41oISeLQ4zHpVbLDrFCnKCykDNfO/qlFIo528cr?=
 =?us-ascii?Q?At0Ug2xVax+LsANU0GkQNnSGo6PbveSgoc56FT8gIDdN4JYzqMiQvHE/qSAs?=
 =?us-ascii?Q?T+bFacqq1/y21FqUXK00PvgFPdtPqB6DREOMlnUdzArbZFkLHXWE7jK53AUu?=
 =?us-ascii?Q?/nq3912eXyyeb++HKeU/Q4bYN2t23H65y+4CyEJ8Tpr78g55bOy8ifFWF9ct?=
 =?us-ascii?Q?JtqbvcL9a7+xZmfJN673yG4D/qjVrKegVAEUoVlXKUhqlSiUZ8OYvhElgNXZ?=
 =?us-ascii?Q?ivop39/bvyS23GPanrg50wN1bdqgATMlI3Z6AMR5+D72sbCpB4rs8fwkB+w4?=
 =?us-ascii?Q?EvCvBnEWDp1hFvtpLVvHQ1eof5KNgdsKpJ9g48jmRu1MSqt6aykQKqf27RTY?=
 =?us-ascii?Q?M5cHKe3C6Oi2Uc2d3oAXkJzvNIAK9e8YkUc0Fr8MpcC477s04WMP+Bq7YZqz?=
 =?us-ascii?Q?bJsF54mK63zh593T9slQBMP+knT6Ne+0WI6vxO7v4SuanhrWCIEDsKK9Zvg0?=
 =?us-ascii?Q?xANdvDeSWMepEMuQcj33ztv+W/kM6qFeIMiNDxcyvJJvACA7USL5Js0HNwiy?=
 =?us-ascii?Q?in9x2KLXq6plBYRfIhxBplLAZK/LaJA/AWIWfOBGmXMMNffxRanQj+tGLd5n?=
 =?us-ascii?Q?FMNUCDDzD+ZreGwdg7Ay0OjMPRaHL0xvpsM0hEL8ggwUiS/aQefBuXK74dut?=
 =?us-ascii?Q?UH8+lb5kkeG5+uyNff03aBT3rWDkB4QSHrRVfxJOJK5aPt3oDoTWXexGmLuf?=
 =?us-ascii?Q?y4S//8x9wTQ/lxh3qJ+ZI1QvjCEm1x475cqnoPDg6ITTUzI6XuEjR+BqdlrM?=
 =?us-ascii?Q?49jzKoghc9GmR6K0DkGvXMJCLKxVA7Yz3Z2iLwksMnTzR3VWzBOXGxa1gpHz?=
 =?us-ascii?Q?GbJo0+PbcOFHsPz09baCPIDoADZERuQpe2m+wtKsjCfUrCtqhA0MsfJUZXCM?=
 =?us-ascii?Q?zUKjnWqbR8slZsveRQUV3coRBM6OshXfHePmCPkPVmFBZgOF3GS14VUoweSi?=
 =?us-ascii?Q?2HxLt1ucLUj452QcoE5yjmyk3v/fP+02FTxv?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 11:30:24.2210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4acb40-2f53-4798-4677-08dde62647c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4318

This patch is created to support super speed plus endpoint for Isoc
transfers. Now super speed endpoint companion is accompanied by super
speed plus endpoint companion. With this change we could see the Isoc IN
and OUT performance reaching to ~749MB/sec which is 96K per uframe.
The performance numbers are confirmed through Lecroy trace.

Signed-off-by: Srikanth Chary Chennoju <srikanth.chary-chennoju@amd.com>
---
 drivers/usb/gadget/function/f_sourcesink.c | 23 ++++++++++++++++++++--
 include/uapi/linux/usb/ch9.h               |  2 ++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_sourcesink.c b/drivers/usb/gadget/function/f_sourcesink.c
index a3a69166c343..79efb6295725 100644
--- a/drivers/usb/gadget/function/f_sourcesink.c
+++ b/drivers/usb/gadget/function/f_sourcesink.c
@@ -232,6 +232,12 @@ static struct usb_ss_ep_comp_descriptor ss_iso_source_comp_desc = {
 	.wBytesPerInterval =	cpu_to_le16(1024),
 };
 
+static struct usb_ssp_isoc_ep_comp_descriptor ssp_iso_source_comp_desc = {
+	.bLength =		USB_DT_SSP_ISOC_EP_COMP_SIZE,
+	.bDescriptorType =	USB_DT_SSP_ISOC_ENDPOINT_COMP,
+	.dwBytesPerInterval =	cpu_to_le32(1024),
+};
+
 static struct usb_endpoint_descriptor ss_iso_sink_desc = {
 	.bLength =		USB_DT_ENDPOINT_SIZE,
 	.bDescriptorType =	USB_DT_ENDPOINT,
@@ -250,6 +256,12 @@ static struct usb_ss_ep_comp_descriptor ss_iso_sink_comp_desc = {
 	.wBytesPerInterval =	cpu_to_le16(1024),
 };
 
+static struct usb_ssp_isoc_ep_comp_descriptor ssp_iso_sink_comp_desc = {
+	.bLength =		USB_DT_SSP_ISOC_EP_COMP_SIZE,
+	.bDescriptorType =	USB_DT_SSP_ISOC_ENDPOINT_COMP,
+	.dwBytesPerInterval =	cpu_to_le32(1024),
+};
+
 static struct usb_descriptor_header *ss_source_sink_descs[] = {
 	(struct usb_descriptor_header *) &source_sink_intf_alt0,
 	(struct usb_descriptor_header *) &ss_source_desc,
@@ -264,8 +276,10 @@ static struct usb_descriptor_header *ss_source_sink_descs[] = {
 	(struct usb_descriptor_header *) &ss_sink_comp_desc,
 	(struct usb_descriptor_header *) &ss_iso_source_desc,
 	(struct usb_descriptor_header *) &ss_iso_source_comp_desc,
+	(struct usb_descriptor_header *) &ssp_iso_source_comp_desc,
 	(struct usb_descriptor_header *) &ss_iso_sink_desc,
 	(struct usb_descriptor_header *) &ss_iso_sink_comp_desc,
+	(struct usb_descriptor_header *) &ssp_iso_sink_comp_desc,
 	NULL,
 };
 
@@ -423,7 +437,7 @@ sourcesink_bind(struct usb_configuration *c, struct usb_function *f)
 	 */
 	ss_iso_source_desc.wMaxPacketSize = ss->isoc_maxpacket;
 	ss_iso_source_desc.bInterval = ss->isoc_interval;
-	ss_iso_source_comp_desc.bmAttributes = ss->isoc_mult;
+	ss_iso_source_comp_desc.bmAttributes = USB_DT_SSP_ISOC_COMP | ss->isoc_mult;
 	ss_iso_source_comp_desc.bMaxBurst = ss->isoc_maxburst;
 	ss_iso_source_comp_desc.wBytesPerInterval = ss->isoc_maxpacket *
 		(ss->isoc_mult + 1) * (ss->isoc_maxburst + 1);
@@ -432,12 +446,17 @@ sourcesink_bind(struct usb_configuration *c, struct usb_function *f)
 
 	ss_iso_sink_desc.wMaxPacketSize = ss->isoc_maxpacket;
 	ss_iso_sink_desc.bInterval = ss->isoc_interval;
-	ss_iso_sink_comp_desc.bmAttributes = ss->isoc_mult;
+	ss_iso_sink_comp_desc.bmAttributes = USB_DT_SSP_ISOC_COMP | ss->isoc_mult;
 	ss_iso_sink_comp_desc.bMaxBurst = ss->isoc_maxburst;
 	ss_iso_sink_comp_desc.wBytesPerInterval = ss->isoc_maxpacket *
 		(ss->isoc_mult + 1) * (ss->isoc_maxburst + 1);
 	ss_iso_sink_desc.bEndpointAddress = fs_iso_sink_desc.bEndpointAddress;
 
+	ssp_iso_source_comp_desc.dwBytesPerInterval = ss->isoc_maxpacket *
+	  (ss->isoc_mult + 1) * (ss->isoc_maxburst + 1) * USB_LANE_SPEED_MANTISSA_GEN2_BY_GEN1;
+	ssp_iso_sink_comp_desc.dwBytesPerInterval = ss->isoc_maxpacket *
+	  (ss->isoc_mult + 1) * (ss->isoc_maxburst + 1) * USB_LANE_SPEED_MANTISSA_GEN2_BY_GEN1;
+
 	ret = usb_assign_descriptors(f, fs_source_sink_descs,
 			hs_source_sink_descs, ss_source_sink_descs,
 			ss_source_sink_descs);
diff --git a/include/uapi/linux/usb/ch9.h b/include/uapi/linux/usb/ch9.h
index 8003243a4937..22782c5cb2f3 100644
--- a/include/uapi/linux/usb/ch9.h
+++ b/include/uapi/linux/usb/ch9.h
@@ -702,6 +702,8 @@ struct usb_ssp_isoc_ep_comp_descriptor {
 } __attribute__ ((packed));
 
 #define USB_DT_SSP_ISOC_EP_COMP_SIZE		8
+#define USB_DT_SSP_ISOC_COMP			(1 << 7) /*support for SSP ISOC EP COMP*/
+#define USB_LANE_SPEED_MANTISSA_GEN2_BY_GEN1    2
 
 /*-------------------------------------------------------------------------*/
 
-- 
2.25.1


