Return-Path: <linux-kernel+bounces-789855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEA7B39B93
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 680C65E2234
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFD730E0F7;
	Thu, 28 Aug 2025 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l5VNLWN/"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB243208994;
	Thu, 28 Aug 2025 11:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756380625; cv=fail; b=KFY7TZVJgb3BZnqqjDnz7RBMAYMxiduUK8se3UWo1Z/+iBCZqs7ipJiIgdErURUObffHY+V5s24/64Nof6ugN32H6stbkYCQVGZzrCeradoas9F9zzaHeMkr+brDARR4K4W1oF8freiTTEsSAQgexL6sj6fUvMkVOVFu8F0V8OA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756380625; c=relaxed/simple;
	bh=EECE3ZxZwskYBcNCf8ipIVKEAq1jc9+CGJo+sA2ZZqs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mPyQ7gwIIFhsod33WEHB7smwFjRGuBTWrfnuNw4KU06x1xl8iV1UjZzkFOr/0pyJnEiKmLD5XQqmS6/eDYfC0iQd4r8OIC0OROOIzKwtOJHIlaOi+B8i9QDlQIakjcGDypM62uWWQzUpRzxFRiB3MxvQQStSWVznFXUOcr5RPYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l5VNLWN/; arc=fail smtp.client-ip=40.107.243.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGWzNfBpZ0Ocx33K9wr9mVDfAeQ3EJe2gWXjRUAKMWdvK06QfBEuZ3SsMghPfR62fAPNib/KVwN4xOEfBifZdMMYHQN/3LZF3hEA/LoxAqJeIdiFp1h1aImnK2NP3Rd8wYYHKN+jTO8S8pbyP8HQhCi+bGf0j/VqO1/sf3BqlEP1ClGAuPctJdHbHqQTiUhPrLZMf/4gP0/7JxFs2STUh/jLLYr83P/sWqwuXijlBV69CchCcrVXe14ybvFKQ8StbMgf+OToKUZtph9iccJr1ZNVsidXEIYvKYS5rvprdUsMYbCbkYBMJYXsdVd8VFHMBGGFb2azDP99rkwRHr4QMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWB+gfYff3N3mqt66pqlMXMTKlgjZTj2FDleFdCsUEo=;
 b=c5SC2jG3KYBoXoJe3OaXwTml4yVoz1qHXQfsMIE7xqc/wQNIcpq9P1yxXg/BPd8lfEcr3vGbPLZnUMxrmRCJK51AW2pPkjGxzzSwHbQClp08OuTIllgYNNlesuByc2PKlUqa1BXjsAFE7PhsoG6zUZdBa5O5nshzwdrlS1mIvSrGutxrNKrggkev1kpxMBcyjElhOimWKqlMZUbSMljCVN+7gl+c6HTJ2scDVMBf0GAk8fncex7aPdfzUQpE9ymy90+d0cauN19ngvqBRLDXQqUp9JdWF03T8kBvHRO0zx8sMsknLeF9bt3zpdDA+8PV4r6rXv2bOg6ZkK/raQCxyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWB+gfYff3N3mqt66pqlMXMTKlgjZTj2FDleFdCsUEo=;
 b=l5VNLWN/fXPL/Ba1lic8iW+2+gr31t0W526jGriAWrVtr+MWnyazk18qWgkL1q922gPPsxvaaouLybqVcrqFi/qt5gxqb8QdWgb6YgzXq3tylRTJ9jMPlHllOnUcl3LvhE+yC6l9R8HX3DADxgDoRC6CLve/qKnl7lo1TZ/jkhQ=
Received: from BY3PR10CA0003.namprd10.prod.outlook.com (2603:10b6:a03:255::8)
 by IA1PR12MB8538.namprd12.prod.outlook.com (2603:10b6:208:455::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 11:30:15 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::43) by BY3PR10CA0003.outlook.office365.com
 (2603:10b6:a03:255::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.17 via Frontend Transport; Thu,
 28 Aug 2025 11:30:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Thu, 28 Aug 2025 11:30:15 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 06:30:04 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 28 Aug
 2025 04:30:04 -0700
Received: from xhdctallapa40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 28 Aug 2025 06:30:01 -0500
From: Srikanth Chary Chennoju <srikanth.chary-chennoju@amd.com>
To: <gregkh@linuxfoundation.org>, <Thinh.Nguyen@synopsys.com>,
	<m.grzeschik@pengutronix.de>, <Chris.Wulff@biamp.com>, <tiwai@suse.de>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<punnaiah.choudary.kalluri@amd.com>, Srikanth Chary Chennoju
	<srikanth.chary-chennoju@amd.com>
Subject: [PATCH v2 2/3] usb: gadget: f_sourcesink support for maxburst for bulk
Date: Thu, 28 Aug 2025 16:59:43 +0530
Message-ID: <20250828112944.2042343-3-srikanth.chary-chennoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|IA1PR12MB8538:EE_
X-MS-Office365-Filtering-Correlation-Id: 5219c469-c956-4674-336e-08dde6264243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JFKfaaIF6DSpVXAXw59YB/caTXGzQYD7GJWv431/+BrSgE9n86TCfLnlH8S8?=
 =?us-ascii?Q?RTJkN7qiFa/MsLPCZBLD9TkMMdJoUomsbIct4rGBzSs/KEY8FtCAbzpabQfo?=
 =?us-ascii?Q?2MwiCcidosFWVJotqH3dvyWB8/kaVRmp0P+Aam2aUaK9LysoffYtLjX9v/Ps?=
 =?us-ascii?Q?sbsQMWptTJFXfVjRsfm0HpLci91h4DE6mPnrnIz4d+am1HUqRpsBARRFv/wh?=
 =?us-ascii?Q?WDQuCoaHeshfx5Efundbu/EZr8QrIru4WHNkgnx4kmUw2P4Q6DLg/Z+ouJSc?=
 =?us-ascii?Q?6KtSwfrKtqD6QKAoJ4RUADFlX7/jO169RKLeqBYHtg2hgdw3e5uhiVLUU7yJ?=
 =?us-ascii?Q?Msh33Rtz1cYOQqVBnaBFbb6eAJN/imjD+nH3wJMzmXipfQjIlFK2SBMHbpAH?=
 =?us-ascii?Q?34qX91ML8tz5pg+SUfGIcUFmDo8/DjDhqfCrBVgoT5xp0fe1O4/EShYMmIGD?=
 =?us-ascii?Q?IuRtfZwK6X1YuvrjHGiMRfNdjvjv0vVqr7Qlvlguhv5E5dUnrYnFEd64xIi8?=
 =?us-ascii?Q?7s/F6iKzw3wBnxU0PuLBo6/a6CzF5dj9xKxZx5VWM5v+gD9iq6jmVYOYa5c2?=
 =?us-ascii?Q?IFZFn4GBm0dFdlGKMYiGBzTUYvyLlQ1O4h+dduHz9PoytWgqLngFn4fk3+82?=
 =?us-ascii?Q?lHhQkEdl+nKG/GkLoZrCEJot4+2K2P/jOzdWPxM0IM2RsHmYP3xAPsRkh2Zu?=
 =?us-ascii?Q?HsbKAiHM/bHM5Atk5PgX4aXlxN5TjBdkaTFJq9KPBx5VMSF11mMDzX5oaifs?=
 =?us-ascii?Q?PruLm+DDnw2LmSOMu9dCP5hoxv1RAnWI0NRZekcgm6cgjc6bsslfdsjJQVP8?=
 =?us-ascii?Q?rqsnbad0XdKnQEZu2gNFi89DFeuQsQ582OdlIbtwC4nnk5BhX7EAwcWn6Rwy?=
 =?us-ascii?Q?Ejxwc44kHOSanZtUn0EDuGskCkqd7JZ1uIZTPMEbZRTCO30dYBpj8/WHm1G1?=
 =?us-ascii?Q?WhVWH5klDeadtTPx0ehaVwriVO4YOt78oc8C29307EgnAy8YdZAhIqF7opY5?=
 =?us-ascii?Q?YBQwNPKmQTyDVPnZRtJrwPO2i3PLKJ7kKdkDDbaxHL0jBraVkInj+drL0Xiu?=
 =?us-ascii?Q?MeBksW+b5vpgovobqg07/jg40x3WgtnRZfKGvaSFosWIgkpeT4u2mQmoS7aC?=
 =?us-ascii?Q?UueK7yO3iQH4J2vWEvzrgrpu/Nlw5BXvjIBWrhXPY1BywzY+S5DfRAxfgf5d?=
 =?us-ascii?Q?zjI9eCvtvUClGteKhvW1Izb5/XkrX7jN3y+Nb/qaUAN+WwhrtjJG9BSzGmBc?=
 =?us-ascii?Q?OBl9gBN1OPQuRlyFKYaQNdwvdi4sTWnoSIDIyl2A5x0Fvs3zEbCuDs4ANSmS?=
 =?us-ascii?Q?cAulM6DQ2a+HRJ/E22mYkKUvIcW34IlJ4ZizuvKo4+1dBaz+738K0xd499f/?=
 =?us-ascii?Q?IgjJCHm40BzuNA43PkG37eUzNkY6+BsEH6IxbQi+Ri5EHntJjeGrY8n8qg/H?=
 =?us-ascii?Q?vVPd3ImGB4DJmAg+QYFQ47PL7SphNnAfkXBRjLh5TYMhNznuE6ybJyIlJsK0?=
 =?us-ascii?Q?72FLDmP4TTHbhij/L/3KDZK+dWc/rqCHAwKS?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 11:30:15.0310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5219c469-c956-4674-336e-08dde6264243
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8538

This patch supports bulk_maxburst. Without this change we are not able
to achieve performance for super speed plus device.Without this fix,
we confirmed through lecroy that it is sendingpackets with NumP always
equal to 1.

Signed-off-by: Srikanth Chary Chennoju <srikanth.chary-chennoju@amd.com>
---
 drivers/usb/gadget/function/f_sourcesink.c | 9 +++++++++
 drivers/usb/gadget/function/g_zero.h       | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/usb/gadget/function/f_sourcesink.c b/drivers/usb/gadget/function/f_sourcesink.c
index ec5fd25020fd..a3a69166c343 100644
--- a/drivers/usb/gadget/function/f_sourcesink.c
+++ b/drivers/usb/gadget/function/f_sourcesink.c
@@ -45,6 +45,7 @@ struct f_sourcesink {
 	unsigned isoc_maxpacket;
 	unsigned isoc_mult;
 	unsigned isoc_maxburst;
+	unsigned bulk_maxburst;
 	unsigned buflen;
 	unsigned bulk_qlen;
 	unsigned iso_qlen;
@@ -328,6 +329,10 @@ sourcesink_bind(struct usb_configuration *c, struct usb_function *f)
 	source_sink_intf_alt0.bInterfaceNumber = id;
 	source_sink_intf_alt1.bInterfaceNumber = id;
 
+	/* sanity check the bulk module parameters */
+	if (ss->bulk_maxburst > 15)
+		ss->bulk_maxburst = 15;
+
 	/* allocate bulk endpoints */
 	ss->in_ep = usb_ep_autoconfig(cdev->gadget, &fs_source_desc);
 	if (!ss->in_ep) {
@@ -341,6 +346,9 @@ sourcesink_bind(struct usb_configuration *c, struct usb_function *f)
 	if (!ss->out_ep)
 		goto autoconf_fail;
 
+	ss_source_comp_desc.bMaxBurst = ss->bulk_maxburst;
+	ss_sink_comp_desc.bMaxBurst = ss->bulk_maxburst;
+
 	/* sanity check the isoc module parameters */
 	if (ss->isoc_interval < 1)
 		ss->isoc_interval = 1;
@@ -852,6 +860,7 @@ static struct usb_function *source_sink_alloc_func(
 	ss->isoc_maxpacket = ss_opts->isoc_maxpacket;
 	ss->isoc_mult = ss_opts->isoc_mult;
 	ss->isoc_maxburst = ss_opts->isoc_maxburst;
+	ss->bulk_maxburst = ss_opts->bulk_maxburst;
 	ss->buflen = ss_opts->bulk_buflen;
 	ss->bulk_qlen = ss_opts->bulk_qlen;
 	ss->iso_qlen = ss_opts->iso_qlen;
diff --git a/drivers/usb/gadget/function/g_zero.h b/drivers/usb/gadget/function/g_zero.h
index 98b8462ad538..3f327e37f398 100644
--- a/drivers/usb/gadget/function/g_zero.h
+++ b/drivers/usb/gadget/function/g_zero.h
@@ -20,6 +20,7 @@ struct usb_zero_options {
 	unsigned isoc_maxpacket;
 	unsigned isoc_mult;
 	unsigned isoc_maxburst;
+	unsigned bulk_maxburst;
 	unsigned bulk_buflen;
 	unsigned qlen;
 	unsigned ss_bulk_qlen;
@@ -33,6 +34,7 @@ struct f_ss_opts {
 	unsigned isoc_maxpacket;
 	unsigned isoc_mult;
 	unsigned isoc_maxburst;
+	unsigned bulk_maxburst;
 	unsigned bulk_buflen;
 	unsigned bulk_qlen;
 	unsigned iso_qlen;
-- 
2.25.1


