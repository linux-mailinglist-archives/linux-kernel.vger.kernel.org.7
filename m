Return-Path: <linux-kernel+bounces-829450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C39B971E6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A40D04C06E5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341702D5427;
	Tue, 23 Sep 2025 17:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mlSWpLYC"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012066.outbound.protection.outlook.com [40.107.209.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9532C08CE
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 17:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758649791; cv=fail; b=YGTn7OJGtslfFFIp44ogqZZO7ARvB6Irs1NqiDR9Heke2yRzBBmavt8JkzlTMQAxsin5zzZY0D7+0rzyHNuWhlmvRNOazbeZPRBESY8w7g3BUYuF99j5JvF08mEYtxbfpoUnAdXhXtsEWuSkYjh9ye3CoSx5pyIQZiH8nhXG7s8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758649791; c=relaxed/simple;
	bh=ifQrazwVHftfJwkklH2JQgt+5Z4lrGJBu1mqQii0xIM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g5kmF2Z/0R57m9Zxal+FcWWOX6nc32M8wUK0wQKQUrtdKvWk+7OgBW1zOtK99QzcvqciuJvn74YltpdGXPdRll9hgN0AsGoE88NyCb3YrIvo0t0Bga87GPxcp5/9p7RbyA47LI51yz0SRTO0NsSCIK6/7LO/aFGKfTmUTD0gnuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mlSWpLYC; arc=fail smtp.client-ip=40.107.209.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UuTuv+O0dCY9+hQ1qWkAG6Elze9adBWSDRNIbVaJqIFvJogBIvMmXAwpOShWO/IDUz9VkdTETriBLovD3kvaB2kj7+0XcMpFne/DyQ6CRdAXYUWIEXOJBQxQR1xQ7pWJ9BitnvSBo+QrTt1CKfyWDZ4Xd2ThKi7rlO6e8eJmgDZA3NYnhJ8MPTcqCuBvxoDFqkUm7vYDwsIIwO5iyh4k60whmSsdwbFqArwLtld6iCXR+nzzNlaQFaM7uC32rChGahV6xoq6H/vHQmqfkPWZ0P+Dl/NnffHD8Gj5oXavxKTGy0aPnoAQUKL33LT+IIUgoGbeXCW/eUEWSLnBBREW9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zro2hd4Ble5cJHXwetB3OFEMfa0I21dYEBYdyGm1024=;
 b=p6qPaRJriL4Or6GIXTAERJeox2aMC/V6lNsBkCDU2B+mcb+xlmCrK0S6+8yaiGmw2TziCwTrUr5bGbNfK54YW8nOOQj/MKRP2B6dVUamk+b1lHVWIAsMjpVzK5ck0jyQIg4EtbzJW6MfLBW816Gw9p+x+FhQIjLoJc5HnVN8TUDcSCfNpXK1MFF5KX5U3oenvhemIc+xvGi4vnAbO0bgwEaAk/rrPFA3vaY79ITeBH119F2P0fiJfDMVKPbbIq/SiFkx6TO/WyhnTHKYhKUL8TXAMPh5hnHX/ixN7O+78kvtNyL27udpxk5i2TIp/gSfkW6e5c6BuSMDxFYsoVrFaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zro2hd4Ble5cJHXwetB3OFEMfa0I21dYEBYdyGm1024=;
 b=mlSWpLYCdutoKhwJK50QHmMdUIKl+xwBsGJOl+73GIbU34b10+kogIGn5wokiMGWJs0zlMb1A8x5dVajVrFOEcQrlo4IPkhhh8JHv0DlNaoGMiz55GnJ0ZzsXr63evZ7Ol//GuXukZGHIwnUYK9K9EnC4Ah+YTGhb/u471Q9SXQ=
Received: from BL1PR13CA0246.namprd13.prod.outlook.com (2603:10b6:208:2ba::11)
 by SA5PPF5D41D38AD.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8cb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.18; Tue, 23 Sep
 2025 17:49:46 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:2ba:cafe::a3) by BL1PR13CA0246.outlook.office365.com
 (2603:10b6:208:2ba::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 17:49:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 17:49:46 +0000
Received: from kaveri.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 23 Sep
 2025 10:49:31 -0700
From: Shivank Garg <shivankg@amd.com>
To: <akpm@linux-foundation.org>, <david@redhat.com>
CC: <ziy@nvidia.com>, <willy@infradead.org>, <matthew.brost@intel.com>,
	<joshua.hahnjy@gmail.com>, <rakie.kim@sk.com>, <byungchul@sk.com>,
	<gourry@gourry.net>, <ying.huang@linux.alibaba.com>, <apopple@nvidia.com>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>,
	<vkoul@kernel.org>, <lucas.demarchi@intel.com>, <rdunlap@infradead.org>,
	<jgg@ziepe.ca>, <kuba@kernel.org>, <justonli@chromium.org>,
	<ivecera@redhat.com>, <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
	<dan.j.williams@intel.com>, <rientjes@google.com>,
	<Raghavendra.KodsaraThimmappa@amd.com>, <bharata@amd.com>,
	<shivankg@amd.com>, <alirad.malek@zptcorp.com>, <yiannis@zptcorp.com>,
	<weixugc@google.com>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [RFC V3 8/9] adjust NR_MAX_BATCHED_MIGRATION for testing
Date: Tue, 23 Sep 2025 17:47:43 +0000
Message-ID: <20250923174752.35701-9-shivankg@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923174752.35701-1-shivankg@amd.com>
References: <20250923174752.35701-1-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|SA5PPF5D41D38AD:EE_
X-MS-Office365-Filtering-Correlation-Id: cdba7694-7d0c-4780-18ac-08ddfac995e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QsYamSeARRtEJf8M93bgYAEskzEFS/5tCh3TQu6I11uQB4hKJfzm6FaecIHd?=
 =?us-ascii?Q?DQtPX90U4zhrvV9r31QHgaz3n/flYiRU0LsNgnvB4RgCN4VNM+x6OgyqMfnP?=
 =?us-ascii?Q?bKo9zgWdFoqwTCmZ9gg/+8rJzawL5iMk/cZ4/2iIHWhrb9Fa/pGMqvFX2/xu?=
 =?us-ascii?Q?f5VDPo1G3l0dhExa1aFHfPpvWuDPBTlCpg3Tca4m/m1YC8cyU6gz7NqGECEz?=
 =?us-ascii?Q?sJXfY3hAKO+0jZ6Q3BQEaOMi25C244VJ8NJWJ+DxKZfndTJHvwBuKbt5WMkv?=
 =?us-ascii?Q?ETWve7QlAW/Vdxqv8KaQdz6RyrOnS7hRdEwzHcz1j9E7/a+98qSNXS+RcEnL?=
 =?us-ascii?Q?jPtDtDE73X/dPB+ha8/ZjDzEQo71+SNyey1tt04xJHKe3OWInPWAB5o12wHG?=
 =?us-ascii?Q?UTVkqf1ZlyEYQPDR2oCcMIQj7A11v45DmEdJWzgl9T0Vg0ECl+DqRqKIudVi?=
 =?us-ascii?Q?GnfxWXR78SnEjvQG+67wgB7ykqQi4YAxufAa7AZ4WHowtFuy15hohJPBS3/S?=
 =?us-ascii?Q?lmzOQNJsa41bwKHzV7BdG9CrPmZGWzGBcC3Fce1yoUYqf5W5nzMpLs6GFYnf?=
 =?us-ascii?Q?4lqWAn7HHVynpFRzCYJCWeDK3YfgYg/kwnDQusUGYhAMaJDoj/59atMfe6Lx?=
 =?us-ascii?Q?JdnMUgW1GOz4NFofRteLlYLXgdQn03Cia7I3XKGa1hOhzeL5l14rvXSz+OTA?=
 =?us-ascii?Q?FSHOPuo1/Ut3iLgfOBYoNN++f4+LFn5mv/CppK8nB9jhpJduBqFBFhEx5Pup?=
 =?us-ascii?Q?axC2mL6a+jbMQQKHlP77Vhj69lxTuBPuL4uF2VBOBq/Zcs+6ATuUDczezKsk?=
 =?us-ascii?Q?y1TpDWMIcyj0Dk5OrKiv/9SHvXoyw/Jj625pZw9GxzUhQn4cAi6HEYgnv5ck?=
 =?us-ascii?Q?Bq+Q4XG63TFNdTz9jpneFYwGVAOmWH1Of1ypoaXc+rqpHolAgMkA1QesRHvf?=
 =?us-ascii?Q?cj70MdJ+EWN7LhNgtNRwZKwb4s9kGhxZEKq+fKXUvlvXzdETvIcYbSeJwJrY?=
 =?us-ascii?Q?JuYboA51o92mICal9RFyKXWunXOWUfmAhQDXr1z+i1LLANHsodztsYGdPv4X?=
 =?us-ascii?Q?27pJM+a35mj5Z/vlNR17JJeLaIht4RE5eIstthFmmFI+LiPTzwu8qKpWv2f8?=
 =?us-ascii?Q?4cq0hOdmi8jjwRSVKcREkakOrcfPxuS/gUcS5//vXU9aRHNKGS8eMAfEn+gT?=
 =?us-ascii?Q?NNAKkVtuO1MQNBhPynanSKHVbmctKhsopzImuwTitKg6J/oH+DR6IjEjHQpf?=
 =?us-ascii?Q?Bd6YXzMYYVf3nZp3gS6xqM/OyFVUjuIG61L4WBwNrjX0bEVYBtOnvX7qrxxq?=
 =?us-ascii?Q?MMIWvBITkswD6wBZBGkysTkQ0hqdtfmhERg1Wl2/vsj1E/oVa/RxCx9UHuTL?=
 =?us-ascii?Q?VwrN9wPYHs0R9VUU4dp4H6hp8mCjcetbe8vjaDRm8PYZbHsR+vfyh9i38bOU?=
 =?us-ascii?Q?5RzZPbArKjw/PtEcxXVeGKdPT2JGXbGoV7gZJcXEbyZlDp1PAhOdvskd5h8K?=
 =?us-ascii?Q?cMSwIHLzgxSWA2weQQ4qZVSeRPIF9Rpii6ob?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 17:49:46.5981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdba7694-7d0c-4780-18ac-08ddfac995e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF5D41D38AD

From: Zi Yan <ziy@nvidia.com>

change NR_MAX_BATCHED_MIGRATION to HPAGE_PUD_NR to allow batching THP
copies.

These are for testing purpose only.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 41bea48d823c..7f50813d87e4 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1668,7 +1668,7 @@ static inline int try_split_folio(struct folio *folio, struct list_head *split_f
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-#define NR_MAX_BATCHED_MIGRATION	HPAGE_PMD_NR
+#define NR_MAX_BATCHED_MIGRATION	HPAGE_PUD_NR
 #else
 #define NR_MAX_BATCHED_MIGRATION	512
 #endif
-- 
2.43.0


