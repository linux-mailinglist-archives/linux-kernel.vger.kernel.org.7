Return-Path: <linux-kernel+bounces-746184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22889B123FD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C12ADAA7262
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71AE2566D9;
	Fri, 25 Jul 2025 18:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kDMaj9kN"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4824248F63;
	Fri, 25 Jul 2025 18:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468436; cv=fail; b=D2yf7FrQrdVq4CXSMcrT6Q4Yh9LBPYipkDdbfJ2mtPSpMYpzpSgPU9lJ6y2ODHUKkozIxkdQSeYURMggQMw13CTFXAMXclzJqAoDf9xFQz7k0FecSxUtYcf+nYoaCAWLuqC79SOogGy1rF28Aw2wTjLMTKMTufJd/eRUn7Frsg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468436; c=relaxed/simple;
	bh=0risnTerhGp/LD/5z3gERoCt4qcWL46ROwYZLa2TFkQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PZFhJqXeAkNUTodhJe4o6/s7/fin5DFugg+xdPBGglXg3NOCPQ7HNk+qTB3jaAcH/LCrZVctSVy2e8n8YWwsX0A+x1U+06ofindCEzsd+fl6zb4K4NTOnZR7iEJXcnK5Jcv8XyNPO+BsgeHx4GGQ5kQ7uHGbC1ksR+RBRpLZHXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kDMaj9kN; arc=fail smtp.client-ip=40.107.237.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4eXzG2LlVLtAdEPRxI2tRSflDJc7871vT21BMuK+cMdKo7CSBxH4aqPIr6CpP6YtsMBDFZFiaSbsIMfuFCfmlr/ELuEqVvsPoaAupOFRVHQlDCPQYrasHEtEdL4fNI1GBh5hmc8TvwCISw09BTgxDABxJH9zwmaELAKkcoo2Cu0mT/Ag4+1amT3x0QkdUEBkIEYR7JcwQnqmznIkGYku/ZG8QVvfC7BPqsaPt+1wFmQx9bOmAxwC+fA1Q+D9Y21iHLRXFjBrEhLErvOWl0ppa4Njo++YzdCGTtPlDML6Bkr6sh3fvvcn0DbTxg6EY77OsuVMPuRR5Up2kb5X1AGlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9gKkJjofAWqikVtSWW3pRfyB/deZmVkEAqjr1jpIZI=;
 b=C5ToDECbZmbXQHw+kSffTM28JdQSblqooo+hYQFuWukiUMnhoyXE69/khzN62flib2lnWiaWb2pvPV4W3ZEJASdnUMvwv9oiMjM52gd3O0ArPhQ5aX4wCaBIqFxW8p59Xdqfz4gu7bf9Rs00AM8raCwoCYrWZNmb252X3Fw14HGrVxq7otTAN1P6J3WDzQ0xaN/He4pm117TuQqXYE6FNjFQAbOmdr/i5Ul9qQyFc924zfmHc/8VJ8ZHleep2XnwBEmqPB4Ya2MX8mK9EoNfP0hOyQoq26Ew+/tS+gZeQ9MIfyA/VyQ/xEp7SaksThyvlOtEm/mK8fAkL8mKpxfYsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9gKkJjofAWqikVtSWW3pRfyB/deZmVkEAqjr1jpIZI=;
 b=kDMaj9kNVeOVg+EqxgOhGtw71Be4pLvhRq/UDUVmnbE2QgeL5bufAhNL6MEWULNHIUF1mHwKFX1DKCl/nV85Z08cIj2OHEwZb/qL9z9o0tbVs4EHI58syJqzNflr5tfvrOjbU3S1swCTt1lTBZrmi6kj703JVw9qXWIpj6MC+7I=
Received: from SJ0PR03CA0077.namprd03.prod.outlook.com (2603:10b6:a03:331::22)
 by LV8PR12MB9619.namprd12.prod.outlook.com (2603:10b6:408:2a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Fri, 25 Jul
 2025 18:33:50 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::8b) by SJ0PR03CA0077.outlook.office365.com
 (2603:10b6:a03:331::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.22 via Frontend Transport; Fri,
 25 Jul 2025 18:33:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 18:33:49 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 13:33:47 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<james.morse@arm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<akpm@linux-foundation.org>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<Neeraj.Upadhyay@amd.com>, <david@redhat.com>, <arnd@arndb.de>,
	<fvdl@google.com>, <seanjc@google.com>, <jpoimboe@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <xin@zytor.com>,
	<manali.shukla@amd.com>, <babu.moger@amd.com>, <tao1.su@linux.intel.com>,
	<sohil.mehta@intel.com>, <kai.huang@intel.com>, <xiaoyao.li@intel.com>,
	<peterz@infradead.org>, <xin3.li@intel.com>, <kan.liang@linux.intel.com>,
	<mario.limonciello@amd.com>, <thomas.lendacky@amd.com>, <perry.yuan@amd.com>,
	<gautham.shenoy@amd.com>, <chang.seok.bae@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>
Subject: [PATCH v16 21/34] x86/resctrl: Refactor resctrl_arch_rmid_read()
Date: Fri, 25 Jul 2025 13:29:40 -0500
Message-ID: <451c774e1865d53664f5eac612570f753679024d.1753467772.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1753467772.git.babu.moger@amd.com>
References: <cover.1753467772.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|LV8PR12MB9619:EE_
X-MS-Office365-Filtering-Correlation-Id: 512b6abb-034e-41c1-23ab-08ddcba9ccab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?70YEfJFD2g/DXjbVADV9w6OUtMj1xSFULgVzw+Xq0fvBvihNT4G0d42XyYK8?=
 =?us-ascii?Q?tQEYIhamCM5CUIMUtgpBXDxK0glxc/bQXQSJScYIID9Bewk8MvhcFDLxzEAr?=
 =?us-ascii?Q?HJLWznut9q22jqvk9T1pY80YTHLztdn32h4YRjoF1/vColtFH90HMRWHzaZX?=
 =?us-ascii?Q?yzz5TtU7MJGg5BfW24BgwoGOjmEn9wCpwv8iNPEJ22DlP7jr/TzgA0reiRi0?=
 =?us-ascii?Q?EZ7jkPgckDpYvmLHrw1MGCh502oO75hbQklqNhtlLuPBceeRkxqKv3dGv3tN?=
 =?us-ascii?Q?aeZ9SelV6koZnv1iGqKQoFui1ri01sBWu7lXgVXcVrhlXZHKu99T7s07RHXy?=
 =?us-ascii?Q?fmadCyx4PfSqdfQuuwgvEgLPiD8i7jG4+dvZpf4PGepk/QXNYBsH/w1kxAqp?=
 =?us-ascii?Q?rbJCYLH68+SubdMnYHk9OVXWNhCOv47Vjag4nFem2U8hx5hVnSzG3JdY+g80?=
 =?us-ascii?Q?mtPurEYe0b/H0VnT84fXCUllhqQuzHyxMUxIFdQCrr4+riXj2FphGMp6imvF?=
 =?us-ascii?Q?vfXUmftwzkHxlzZbna384avNUhXC1+rSMobUYlMVtOvWjLYD7ghx/yOI2yW5?=
 =?us-ascii?Q?wq16pDa0DJimleRoB/sMUOaIb/NdMaMcJKyjZ+PhHSG68uGdV7yGVkIbjgPg?=
 =?us-ascii?Q?/XgxCpvO8VPkq2wUecoxm3Vp6wwk2jgwHg6SKBR0cnSM6wXIvRKHqt1ITUqR?=
 =?us-ascii?Q?iovAPRGFmBAXXqqxOJZrSIMhUnYNphlKBhEqqxyRnm6l+wxMgyuy7LTyU7Ad?=
 =?us-ascii?Q?+WuNb4NQVCm2jumKgAWjxQJeNeOWNPiAFR6s754zOVAzdltunYXRNs2XqO4Q?=
 =?us-ascii?Q?IZAIed9a1NrqRXzTrO96iaBT6sRfqw7125Qo6PiQ8hwTBIkwfGeURjNxu+pU?=
 =?us-ascii?Q?hBbdZ6F8/3fIijVWpF5fJh2mkZmaE6DP0M3x6Qvw3g731U/GDYY5cqGX1aNj?=
 =?us-ascii?Q?YH2X/59rdEZ+TT1nla5L6hP/KveIOm+oXFbAF5st9eUxxe8zOhuFx5USx0yA?=
 =?us-ascii?Q?m+Js2trx/FbHJRTeNCrtxokylVI8+4jEvBssq5Yaqs/tOrXN8ZQdq+g7XimQ?=
 =?us-ascii?Q?2vu/ofl/Lgvqpryc65BaWx/UTHEJE4UnyM6yLEZhFwc7vfFN6q3x5XvKOa4Q?=
 =?us-ascii?Q?pljtGhguemLpfOEjLrllBWy82NKBeO4tSm3GdZWmYjqUgSNiwQ97ZjVFL021?=
 =?us-ascii?Q?OHNXfI6n7g/aSFSBl5m4RT6YbkS2KJRYtQE7hpVxHckqPTRW9wYZQnhuPcdq?=
 =?us-ascii?Q?zsFhU5WyvLkFpqvAoa+Isi5c/oo92U+cjdcoeOyVscWoYSEN6OVU149KJlh8?=
 =?us-ascii?Q?lakEWmTHxrgmUSXOGBV4sKXO+GzC/DLjdhzGxEEmB8JMd4paYKHF43BwV8AE?=
 =?us-ascii?Q?dQq3RXZesaOCecoYi0IRDQCyk4WEwzY13/y+3te0bkB8eVYlstS3DbPC32Hu?=
 =?us-ascii?Q?V7WTUcvaYpPJ0G22rikoegCKWycQjJ5rsZBi8yPiJXpLa08Fcc+lmV6/5mw6?=
 =?us-ascii?Q?lpXuE3zrEAvuN5YDvmjj3Pez8kWH/XnRo6nzLvGtvDeHEZNkWKFTjjhv/g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 18:33:49.9268
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 512b6abb-034e-41c1-23ab-08ddcba9ccab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9619

resctrl_arch_rmid_read() adjusts the value obtained from MSR_IA32_QM_CTR to
account for the overflow for MBM events and apply counter scaling for all
the events. This logic is common to both reading an RMID and reading a
hardware counter directly.

Refactor the hardware value adjustment logic into get_corrected_val() to
prepare for support of reading a hardware counter.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v16: Rephrased the changelog.
     Fixed allignment.
     Renamed mbm_corrected_val() -> get_corrected_val().

v15: New patch to add arch calls resctrl_arch_cntr_read() and resctrl_arch_reset_cntr()
     with mbm_event mode.
     https://lore.kernel.org/lkml/b4b14670-9cb0-4f65-abd5-39db996e8da9@intel.com/
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 38 ++++++++++++++++-----------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index ed295a6c5e66..1f77fd58e707 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -217,24 +217,13 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
 	return chunks >> shift;
 }
 
-int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
-			   u32 unused, u32 rmid, enum resctrl_event_id eventid,
-			   u64 *val, void *ignored)
+static u64 get_corrected_val(struct rdt_resource *r, struct rdt_mon_domain *d,
+			     u32 rmid, enum resctrl_event_id eventid, u64 msr_val)
 {
 	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
-	int cpu = cpumask_any(&d->hdr.cpu_mask);
 	struct arch_mbm_state *am;
-	u64 msr_val, chunks;
-	u32 prmid;
-	int ret;
-
-	resctrl_arch_rmid_read_context_check();
-
-	prmid = logical_rmid_to_physical_rmid(cpu, rmid);
-	ret = __rmid_read_phys(prmid, eventid, &msr_val);
-	if (ret)
-		return ret;
+	u64 chunks;
 
 	am = get_arch_mbm_state(hw_dom, rmid, eventid);
 	if (am) {
@@ -246,7 +235,26 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
 		chunks = msr_val;
 	}
 
-	*val = chunks * hw_res->mon_scale;
+	return chunks * hw_res->mon_scale;
+}
+
+int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
+			   u32 unused, u32 rmid, enum resctrl_event_id eventid,
+			   u64 *val, void *ignored)
+{
+	int cpu = cpumask_any(&d->hdr.cpu_mask);
+	u64 msr_val;
+	u32 prmid;
+	int ret;
+
+	resctrl_arch_rmid_read_context_check();
+
+	prmid = logical_rmid_to_physical_rmid(cpu, rmid);
+	ret = __rmid_read_phys(prmid, eventid, &msr_val);
+	if (ret)
+		return ret;
+
+	*val = get_corrected_val(r, d, rmid, eventid, msr_val);
 
 	return 0;
 }
-- 
2.34.1


