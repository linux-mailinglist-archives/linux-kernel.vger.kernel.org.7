Return-Path: <linux-kernel+bounces-780179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EE8B2FE95
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14BBC1CC2512
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F592FB601;
	Thu, 21 Aug 2025 15:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="arZNgstq"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B746E275B16
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789898; cv=fail; b=oqSW7ngwoc55vZPw/Xfug7tWj2JIb+IovJO22VJmxACr4k6AzgxL2HPaaQRwVeXB2TB+vXiG/zWEs19hnIECYwe+OPxuWN0nhFS8oJLzv2wJ3UX1WAoMTHdrTJEA+/mMKpjufZ9tbEBdn+H71Z40OnDfBDAci5FQVxDzmGMo7vQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789898; c=relaxed/simple;
	bh=mLUmE+ZwUOrvDBrrsSoWn5410toAqLHmgx2Q4urraSM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M+OFkaOB/DzhKhkIEHWT1ft0N7ecbesFUq+9oDiG4lRMXQvEQsQ7qCsb30qvp0iTNQEmXGlm/u+x1WMnhD8/agTAE2A5xNvEeT8zK2g2Ss48zHZWQw0c1sB5ACDi3NskTR+19Rita48q3Ycqt2lEVqVu81PZXmU10qWnZAR1q3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=arZNgstq; arc=fail smtp.client-ip=40.107.102.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXjRr1zQKxMEhhYQO+qT5TUJaVsTT72u0t/f5n/e3JNp/EFa1thf4iaqsHwlkNgo8mcoHpUI+WB4M5dTUTUzczKplR3wOkzU6M6mlTfbs4bRde5Fadev3EB3+4F2CQSd/Mv7Gp3mxDC6orN+jk+1mykksIAMBhF/EoMNqN/lut6QKzdO0OFBUJwcjOu7EqWPB1rjaNLr53eNF75ZBZ8aTzMFUSYGZ/7VI3vvsnvRGWJknmgEYRi8WjyBU0xAb96U9UdEDG5rEmDE9HR2B3chh6SkDJywO7qYiNO2Iy5ivHfSB+R+obCMOCEcSWOUUAeFyG7O98/5nqKlA8Rg+KuvmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRQyD8s572zAl9nNsQBha/CgSlFdHU1P1iWMmgEsTNk=;
 b=SxR5N1STX+qjyWUaDG9zMQpRA5RHUH2x7uEEqLMDGaqQLwA7+PjNc2lEJZC12ed1ZkgHSccjb2IRNQMMr0RtOi8yGUvaS5t5hdTQzS9fktLIjbTIau7WdvDrx+JxeHX2FlkxGcTVI/TzMijKnC1d7jq1jGSHZcmiT6uwigyXc7FF6eull98DTFbPuKdCEZbrxYZvySAWFKuyoBcxbATD5Z1XOrWHi1zvk6GOqqHZDrcyuLcMb/e0yhJSIcMycvsOfzJGgrsOVcYVn/OuoKGO10ui2+G5q71qvMWulLLQhgCk3h6piEbVAUweww/gVOdCeOkcnKjNXQ2j2QPuS2AmZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRQyD8s572zAl9nNsQBha/CgSlFdHU1P1iWMmgEsTNk=;
 b=arZNgstq4Xjz5eyRwMTqMc2aLvchkOpmaElhmrL4ThAyNXh6h6A5d5mAl8/BAspn3wWWSW9GGQssYnCOf/QjL1fISzJrMx+UrMEkiuceCuXhK5r8bo8mhXsJh7M/WLBSuGSX2H6jxTEVl03q5Xt5vF/g7sMacvm0Bzc0kfnSQV8=
Received: from SJ0PR03CA0088.namprd03.prod.outlook.com (2603:10b6:a03:331::33)
 by MW4PR12MB6732.namprd12.prod.outlook.com (2603:10b6:303:1ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Thu, 21 Aug
 2025 15:24:50 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::f6) by SJ0PR03CA0088.outlook.office365.com
 (2603:10b6:a03:331::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Thu,
 21 Aug 2025 15:24:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 15:24:50 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 10:24:38 -0500
From: Raghavendra K T <raghavendra.kt@amd.com>
To: <raghavendra.kt@amd.com>
CC: <AneeshKumar.KizhakeVeetil@arm.com>, <Jonathan.Cameron@huawei.com>,
	<Michael.Day@amd.com>, <akpm@linux-foundation.org>, <bharata@amd.com>,
	<dave.hansen@intel.com>, <dave@stgolabs.net>, <david@redhat.com>,
	<dongjoo.linux.dev@gmail.com>, <feng.tang@intel.com>, <gourry@gourry.net>,
	<hannes@cmpxchg.org>, <harry.yoo@oracle.com>, <hdanton@sina.com>,
	<honggyu.kim@sk.com>, <hughd@google.com>, <jhubbard@nvidia.com>,
	<jon.grimm@amd.com>, <k.shutemov@gmail.com>, <kbusch@meta.com>,
	<kinseyho@google.com>, <kmanaouil.dev@gmail.com>, <leesuyeon0506@gmail.com>,
	<leillc@google.com>, <liam.howlett@oracle.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<mgorman@techsingularity.net>, <mingo@redhat.com>, <nadav.amit@gmail.com>,
	<nphamcs@gmail.com>, <peterz@infradead.org>, <riel@surriel.com>,
	<rientjes@google.com>, <rppt@kernel.org>, <santosh.shukla@amd.com>,
	<shivankg@amd.com>, <shy828301@gmail.com>, <sj@kernel.org>, <vbabka@suse.cz>,
	<weixugc@google.com>, <willy@infradead.org>, <ying.huang@linux.alibaba.com>,
	<yuanchu@google.com>, <ziy@nvidia.com>
Subject: [RFC PATCH V3 00/17] mm: slowtier page promotion based on PTE A bit
Date: Thu, 21 Aug 2025 15:24:25 +0000
Message-ID: <20250821152425.1600861-1-raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250814153307.1553061-1-raghavendra.kt@amd.com>
References: <20250814153307.1553061-1-raghavendra.kt@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|MW4PR12MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: 04e0f62d-08ca-404a-cd47-08dde0c6df0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PBLJY8Xf31x7OGTrFMmmhdxX+uIeC/Ho6IRU+cy8hi2OUshY6NdDA4daNwhK?=
 =?us-ascii?Q?v4m+eZSHutV3VnKC2FDwk/HtrJVuoPQohKbSGQIquZ26pqvpTI/n9BRYVFUK?=
 =?us-ascii?Q?H2Mpp10/JmIB/ywlffhkzanu7DhgAaoaImypicUatbHRcHCRbkV6ZfjAulPa?=
 =?us-ascii?Q?W0sc+u3j8++3Oz1m0XrjM0Nf2koiLgj0scvRMoruBQwU89XQr9EytxJfyjSn?=
 =?us-ascii?Q?3xi07X6+8ImUoORMeK41RvnR7v1uKRbLkCr/bd/8TRIExTYh5sy32XT0Awvi?=
 =?us-ascii?Q?T75lAxCcMS6u2WX/Ys6ZKKXAZ2PPNyIsNJz9R4PZNsm/1BEY5bOgo5KS5L6m?=
 =?us-ascii?Q?BCAweIlaggpsYKI/ssUKg4ySjgGW93xEGMT5kfxgqyCFN1pyQFBKUz1QFDjQ?=
 =?us-ascii?Q?5RWRHsysV3QzbdtGP8B3azE4X3e/bSf0I977NiGqiabzzoylljHwpNm4hC9w?=
 =?us-ascii?Q?dGiRToz0nhUFzilRDsf8370cdhIUvOdio/rvAvDBzdIgoBo2LutfyO79CEd4?=
 =?us-ascii?Q?6OnW7TydLUf0L8w6GaYOG9HIRWQ2UqNaiANf5tfOQW+K82UZP+ThHyCfjYgO?=
 =?us-ascii?Q?12AKwIArhXcMPs0cAM/gjvaciARQ/SL8YVqTRvzaLRuCAvQcddMwKD7zPQ6J?=
 =?us-ascii?Q?BuTcjcPjuxyOEm07t6bzAGli5NaObBEKe6vbmWu+aJgEPvrtUsRECBaPkdyt?=
 =?us-ascii?Q?CmoyFBiCP2PhMefX+q6OJ2h6TQ6wCPXJTcok9tVKaL3cB1rr36qRisxdKuHR?=
 =?us-ascii?Q?f4HgNb+pljWUabR3HJn3k6fyN/Mb7aqSRHHM9FP1Fd++ba/mzjf6347UC1TT?=
 =?us-ascii?Q?hmql1KqCLbMD22/6MXMQXIM0mJn9yIsKMAL9oucvLadNKjukAAlfe1imOXOE?=
 =?us-ascii?Q?WV6MqSFOa+yU6snahzd2bXWyzCjWuw/IXnHHqMQqShLvLk9KeKD022Gh7xNR?=
 =?us-ascii?Q?AvyQoUpeJBULAOQsdPJqtSuOWtk1E/QQ+7HaZXfb6xivZjwnqOBILK2UR8an?=
 =?us-ascii?Q?vWyCRMRLfviTXgC0oN45vMOiroyEI6NgwuuHZjZzhIYvUEpvqL5z3BQiMDXP?=
 =?us-ascii?Q?9V/txfl8jZ8AgbjgPpAtizWhm4p+hkE7O8gGnhTLiSZR0fKY+RUq7Jk5o1yE?=
 =?us-ascii?Q?2i+6GNhcx+lSsw2Vi3d4EgzW+zc55uYunhmgSMhAQbvGeWUyFCoTzJKcfvyN?=
 =?us-ascii?Q?96XCw7FRL6y/8IpO4X7C9lxiIyRZh/5TUlfT/6lz7qn8BazZdBPPyyiNx1RC?=
 =?us-ascii?Q?ZYPFI+CoCFyLVBlqPSu/XBuj7As81VOOXMa9weu7IOE9b4Zn0o/ayuW78U0m?=
 =?us-ascii?Q?RC5ukJZ47+mimE88TODykL/FBwYamcZYVPiNMMF5heJYXVeFOcoFb7Imx16B?=
 =?us-ascii?Q?dhyIhUK64zhRBPyv2/jGgv3xrLBoEhwsFppKVlfZ0O1fxRx7UCxdzmALopqe?=
 =?us-ascii?Q?haB9HSJbUN/HBU5rN1whHa0SWRT4gzpnsBQs/hWfhbfMhUf3BYWOJLXjU5HV?=
 =?us-ascii?Q?uadAc9JZsXjCD4SfVeW7IVOpvz9C3DMGe6o4b7VVUsijvisR4ZYIoEjC5A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 15:24:50.5365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e0f62d-08ca-404a-cd47-08dde0c6df0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6732

On 8/14/2025 9:02 PM, Raghavendra K T wrote:
> The current series has additional enhancements and comments' incorporation on top of
> RFC V2.
> 
> This is an additional source of hot page generator to NUMAB, IBS [4], KMGLRUD [5].
> 
> Introduction:
> =============
> In the current hot page promotion, all the activities including the
> process address space scanning, NUMA hint fault handling and page
> migration is performed in the process context. i.e., scanning overhead is
> borne by applications.
> 
> This RFC V2 patch series does slow-tier page promotion by using PTE Accessed
> bit scanning. Scanning is done by a global kernel thread which routinely
> scans all the processes' address spaces and checks for accesses by reading
> the PTE A bit.
> 
> A separate migration thread migrates/promotes the pages to the top-tier
> node based on a simple heuristic that uses top-tier scan/access information
> of the mm.
> 
> Additionally based on the feedback, a prctl knob with a scalar value is
> provided to control per task scanning.

Patches are also available in the branch:

https://github.com/AMDESE/linux-mm/tree/rkt/kscand_rfc_v3

[...]

> 
> 
> base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f

