Return-Path: <linux-kernel+bounces-896672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E31C50F0E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BA66134C442
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E182D978A;
	Wed, 12 Nov 2025 07:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zr6SoiQN"
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012042.outbound.protection.outlook.com [52.101.53.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0E52C21F3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762932609; cv=fail; b=csGDXf6NkfxhIWUqOQLsypEh9WB7KSucPTq5kEi54huuKWgHPk/1jh8EJ6DwmtMyLpRhAlQ+fK8H4wVjKCgaYd9d0maeQAwlPey8K0eg1Rb873piiVCKFn4SCjIfgbz2vp01GCLjz0Mo/IUe8nf+gCHlgnEZuiUoImijM9+Lm4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762932609; c=relaxed/simple;
	bh=bn1GvCUhn/c5ElBWmqd/Yb0AEtaGr0zjEHarDykGvIk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JSW4B39vNQjBcSlyb7qnCSQrezLdqzG/2UBqp6UV+XTUM4voKWbuj790srQZk1OW80/NzmxHehwEEClXc9q7Tk72Fo/qCQp7iFlg4YGdzDBcJ8unaCZTvrgijkb7WYXnGsTp6hIEfVVEcaCJupctShQ/SpDuw7l4LZZdAGvqLng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zr6SoiQN; arc=fail smtp.client-ip=52.101.53.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7RhXUSACg7AouJqNhfvBgHekNRSIadraF1PzKG6gMe4relQLXPo9usBLlrc8VMBJ/u2l+gWwmuNsyz3a7ds3qau9ShtHwlgVJYnLI7ESSGKpmwfcr2kVJhYHjTJsnMzRPGQ46CJwFRII1E1fxLJW2EWFvEa4sXH+DiUIPfbhpU2o5xps7ZISve84XcSgRmKhvHEKw7a2lsNlKuXwWGsOGkXotPTIlU//VWck8FOKA1QkvP3Mlt4ZcPzpUvU14wVFxc+XSQn0FQZt6CDyphVeeIvC5Bx1a1l4Tnuw6I/i5uIA/fku1xbI5w99UnaUt0PuVKSTwKvjSZFFbeYnetrdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NO9nHqpa4n1BllvLemZcCmcwFCUr6R8l5qDSl5DARTQ=;
 b=A6/8Qj9ySEZgTZ55GGvDHGS5k6pid7YnhfKu6l/Qr/iZhmDQyqd/HvAw6+tRstD2qmnfc6UWrBjpsXp/NRZQzkxn73pHQT/s7pJG1KjxLmhyCiHE/GNzAjuUH3rpcehwoNtuLl8+jHz+npJGeNY9T00kfqgOeroDe/UxvNBEfwMBi5WRjeJmGlVqz5J+xyprb0ikmBZ05OOhtqFHedyQuZRNPGYU2LLpuQ9mFEvPdvQdWk8pJA8BWT5RS9EWGnfHOfpw4/69mybauv/q1wdLct3rmSkk3ML/3U675kQOHWvnAWn3nQAia1/YIWl+KBd8IRxH01cEmx9pK3oqGWoH2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=collabora.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NO9nHqpa4n1BllvLemZcCmcwFCUr6R8l5qDSl5DARTQ=;
 b=zr6SoiQNydfD1o3qyt2DzHcGaebshDIPdZmqRJYTDjc12dwHaepc+LOZvBJhxiKj93XA5X1gMPJIyI5/XigXD3oMaqQ/wvP8ya8SXFTClZfH8YrwMJ+RhPK7IMQZpXR4mw0Be0s6TzBPh8jRJlb3OLHEtNrxpp5ktBqT4UmmRYQ=
Received: from CH2PR07CA0060.namprd07.prod.outlook.com (2603:10b6:610:5b::34)
 by IA1PR12MB6577.namprd12.prod.outlook.com (2603:10b6:208:3a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 07:30:01 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::2b) by CH2PR07CA0060.outlook.office365.com
 (2603:10b6:610:5b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Wed,
 12 Nov 2025 07:30:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 07:30:01 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 11 Nov
 2025 23:29:57 -0800
From: Honglei Huang <honglei1.huang@amd.com>
To: <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>,
	<christian.koenig@amd.com>, <Ray.Huang@amd.com>
CC: <dmitry.osipenko@collabora.com>, <Xinhui.Pan@amd.com>,
	<airlied@gmail.com>, <daniel@ffwll.ch>, <amd-gfx@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <akpm@linux-foundation.org>, <honghuang@amd.com>,
	Honglei Huang <Honglei1.Huang@amd.com>
Subject: [PATCH 2/5] drm/amdkfd: Add SVM ranges data structures
Date: Wed, 12 Nov 2025 15:29:07 +0800
Message-ID: <20251112072910.3716944-3-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251112072910.3716944-1-honglei1.huang@amd.com>
References: <20251112072910.3716944-1-honglei1.huang@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|IA1PR12MB6577:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b0a4c85-f299-4e3b-6c97-08de21bd4a73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UifOFBa21tCLSvRaOtIa8XMqIl+PBS42stJKUlTTHHrg87RB1rY1e/iYhCQd?=
 =?us-ascii?Q?KE+q8Zo3y/+ApWySoS7eUoYQkquXm4Yg4tNL4l+8dQ/D9KdA399UFSs4CH0b?=
 =?us-ascii?Q?ANFy/ndTYK+nkPzLqvXSz4BMkJbaZeTM3EDLDcyn40E9hQmyXgaaAxOm6K0m?=
 =?us-ascii?Q?dO57dj3MW2QnuvHRm/XFyVADk0LJo6ebOJU7zvU70jBPS5vSBRWCo2KaEjcy?=
 =?us-ascii?Q?O/4MHIOtjby8/YnqlxQahRWfNPslmwB0Mg5Uvr+L71fvytKvtEGIVfu/nsWG?=
 =?us-ascii?Q?jz/PAFsPL+aw7Pi9WAPjpbsVmDU6WlXJCAZs/DGU8kV9NQ+SODFMEGgmw3+J?=
 =?us-ascii?Q?CiaZgK1WZ/MSv2P0kGUbRA38FeH44a0VxBunpcs56Ix3l4PPwOlwN3rXZveC?=
 =?us-ascii?Q?9R/vbHUtb/bHCbcr/0IKKzB/CecRahZtM1eeZSmqrA2f6YA1pl6D6au7emwo?=
 =?us-ascii?Q?f3Tl1GmT1R+97aJYRnmUegzZyin+xD+esSXtRs4p6NPnfk2mfCCSsDK3FjdT?=
 =?us-ascii?Q?SzY12loozJtfd4jDpdfFkVCtilUmjJl3dXVjYgXFjyuKtNB2nOTpCmPfvc+Y?=
 =?us-ascii?Q?v8smXVnmSEOioURLqMcgrww8RvCH0W9LDo1yz0PXWljV0DbQ3V20OMMxhVX2?=
 =?us-ascii?Q?RyRoN6M0ySMwQoIYZ508EnJa9czReYJ9xMTJsAeBPQN5utuAnHvFLB4Jo2rm?=
 =?us-ascii?Q?2RnnIFp5kUaX2jUTb1fnMm50qawYeheInKArPec3KIuvGYSIxA93IhrSMpvm?=
 =?us-ascii?Q?Pvysa9OJTaFmwG3qVGBMHh3Wu2T8QFijSjVKW67btxaPbqu8I1M2Q8Ia8rpF?=
 =?us-ascii?Q?/uLyUoHY/iOYX8r74OJ71l8dEOxBW0bNv1V+zA+B9MYD/tFVYJeK5F+gWUeO?=
 =?us-ascii?Q?yrct4TrPckOk45vK6VXar0ynAxhQKjjEkjTc15l4oPUetESl2yr28Mebiwkq?=
 =?us-ascii?Q?fiueXBE78JZ++vIZnJlR6YqLOI0MjhpHnxpShX/0MZDFrkH1Z6m9GuvGBnIW?=
 =?us-ascii?Q?AtRi4wdOuhAj5ycBAqF1V9aiAvofiLa2ZH7N7Oz60dOOYqEV09jtUt7AWAn/?=
 =?us-ascii?Q?kBAUZa8wJKoowQYynOIXjuqIL7vxROCt+cWPsqqyt7oVkksZPRX8bD/u/efJ?=
 =?us-ascii?Q?ZehCiweWhARk9Jp6rtVLPRLCUbBtvFcktLnDl3qHdXh7ktoFEu74eRMQxy0z?=
 =?us-ascii?Q?xEe7vZD5bak8gaMkH+pUm6EkLHa55Bn3oFA++rw7fR7z0mF9rxOWJcK6DCCD?=
 =?us-ascii?Q?Pmh4JMTI29LLrz98l+6ler93HGm3UHCXnxzzPV51XVxVz8c4QStRr7lM0T93?=
 =?us-ascii?Q?PkExCAUlzIlGcS1LIGDjg0yilZcvAN3IuJK4wcPejHJBbFOh6Y0B2WTVBHR5?=
 =?us-ascii?Q?wKiTLN4wtYooGrALZATwIJLM+WA0jQyu0C4qfxJVnDprKovr4585NrickhYh?=
 =?us-ascii?Q?QAk+fBMmFQJKn2y7NAOCb0+bu6UDbDLpBSh1MAxWXsXuBXcv4QU6mk2YwMSw?=
 =?us-ascii?Q?R/RRotL+1xSzd7bKvHO2iNVokT/iRlyIWfUUzDllKMEjR8f7+bsy0crkyqGS?=
 =?us-ascii?Q?3J9XF4n0S5hnOxJt47M=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 07:30:01.4266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b0a4c85-f299-4e3b-6c97-08de21bd4a73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6577

From: Honglei Huang <Honglei1.Huang@amd.com>

Add new UAPI data structures to support batch SVM range registration:

- struct kfd_ioctl_svm_range: Describes a single SVM range with its
  virtual address and size.

- struct kfd_ioctl_svm_ranges_args: Arguments for batch registration
  of multiple non-contiguous SVM ranges. This structure allows
  registering multiple ranges with the same set of attributes in a
  single ioctl call, improving efficiency over multiple individual
  ioctl calls.

The new structures enable userspace to efficiently register scattered
memory buffers (e.g., multiple malloc allocations) to GPU address
space without requiring them to be physically or virtually contiguous.

Signed-off-by: Honglei Huang <Honglei1.Huang@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 42 ++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 320a4a0e10bc..d782bda1d2ca 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -777,6 +777,48 @@ struct kfd_ioctl_svm_args {
 	struct kfd_ioctl_svm_attribute attrs[];
 };
 
+/**
+ * kfd_ioctl_svm_range - SVM range descriptor
+ *
+ * @addr: starting virtual address of the SVM range
+ * @size: size of the SVM range in bytes
+ * @pad: padding for alignment
+ *
+ */
+struct kfd_ioctl_svm_range {
+	__u64 addr;
+	__u64 size;
+};
+
+/**
+ * kfd_ioctl_svm_ranges_args - Arguments for SVM register ranges ioctl
+ *
+ * @nranges: number of ranges in the @ranges array
+ * @op: operation to perform (see enum @kfd_ioctl_svm_op)
+ * @nattr: number of attributes in the @attrs array
+ * @ranges: variable length array of ranges
+ * @attrs: variable length array of attributes
+ *
+ * This ioctl allows registering multiple SVM ranges with the same
+ * set of attributes. This is more efficient than calling the SVM
+ * ioctl multiple times for each range.
+ *
+ * The semantics of the operations and attributes are the same as
+ * for kfd_ioctl_svm_args.
+ */
+struct kfd_ioctl_svm_ranges_args {
+	__u64 start_addr;
+	__u64 size;
+	__u32 op;
+	__u32 nattr;
+	/* Variable length array of attributes */
+	__u64 attrs_ptr;
+	__u32 nranges;
+	__u32 pad;
+	/* Variable length array of ranges */
+	__u64 ranges_ptr;
+};
+
 /**
  * kfd_ioctl_set_xnack_mode_args - Arguments for set_xnack_mode
  *
-- 
2.34.1


