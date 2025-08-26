Return-Path: <linux-kernel+bounces-785971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EF2B35309
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBC55684F90
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 05:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5E42E62C0;
	Tue, 26 Aug 2025 05:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WeEbZJCe"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFF02E1753;
	Tue, 26 Aug 2025 05:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756185154; cv=fail; b=mr7BcNPf7koAJULt9kA826KKbc125EQ2n5tBTZtdOAqKOd6D3anN2ApHg54CGAArTGWyenJ9bDPKvmY+rB7PnntVw5Oli0d9BgLiSUvc9T4+Amy+wRHmsf5PVvTCbTFHvpMARWTXsUwzhznoimeGOvsfIqLXQ0uG8LRBTkVGL80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756185154; c=relaxed/simple;
	bh=zRaehD3QMrNxywFuzfKcbsNYqH7FZNmbSDyyj94FwjU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fAgx9eBX9ZJSUjEBOe+wTdbWm7okUbIHgLGWRCtC+ft6Pw3EwuI/ns920wisNCvFPm93dzg+i+oPMGDvoKjGL/Phe1KfwYM3/3dKkIHrUcoPdr6zfJngAt8LDNDeyWl547jGe6YMWqw9dCiycTlGI/OY0oKKw3APe4brIFSSmCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WeEbZJCe; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTGTIssKekeVP9ZN5xyuRm30lXg/t3uB7bHLF2EyrkCabFujzcMzW/yRL7GyfOzC/cfBa004TlsuNwy4Iq79qMMOSPEobPghc9UwHDFhJKGz7/YIJ0KVZxITz3d5xjhrOQpK1UWyIfhD790VNrFysblJRtE1bEPSNUBEzu/HNdsHxaCRHjHNysHhtTmMJxw8mZeNCif8pVsDmfcoPyW1YV7bXKONXqFnfD+rylWXR61T10Gsd24BRZQ0Cj3K8JUB0A59OqjBi96L00xw7nKFARRQcHy5wHoSHpU40wazYWWevNP4i08o16+OkHjgj5BEy3vY4WvWfbxYHPyG0AVxnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tpab/3PqyFqnxDxsK+xARCTRAgivmIEBwNhY1rJq+t0=;
 b=OR+WvBcHJp0VSkzIwVKVo/RH+arxvaw8KMKETstZhzwD49BABjnCC9se0q/nJfKsCICsmIvAH24YzmP5G4wdk3e7PI005WAuybODDd16BiVoornk8hzE0Ze5k6CBicM6sJhdtyEFCw4B1/t/nCdtnpbq35r1T+DHBAs+Ao1S0HTwriNsgGI5oJH96OOFdC3IrqalETxOO54ABLEIdXf8IzP+87SGn1yEq0gfYQUJX4cS7ByyYU7TybMbGqEjb5WxHi/Ka4b2lrJQPBvUqQtxQVpYNMWFiXswpyi68LdWiLrqme3mGTJnVuLf4X//xczCJ+nQUOJ74FbVmObvkQLPUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tpab/3PqyFqnxDxsK+xARCTRAgivmIEBwNhY1rJq+t0=;
 b=WeEbZJCegM0ToaRLOktzS2Lg3LjgB+G6Ww7G0mL+lSeTIku86/pbjKV2ltTWfo9P79HOeLZxeDeYSguPjdzpz+6ZK80Nw1GMrRxI+XdTA/xElNaCCsjgEiL/4ZshVZNiIUH3puE0zsMhw1LmWytB3buygsJ4yys1aSEKIVkIpdk=
Received: from SJ0PR03CA0234.namprd03.prod.outlook.com (2603:10b6:a03:39f::29)
 by BN5PR12MB9463.namprd12.prod.outlook.com (2603:10b6:408:2a9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 05:12:29 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::99) by SJ0PR03CA0234.outlook.office365.com
 (2603:10b6:a03:39f::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.22 via Frontend Transport; Tue,
 26 Aug 2025 05:12:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 05:12:28 +0000
Received: from tapi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 00:12:21 -0500
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <corbet@lwn.net>
CC: <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <iamjoonsoo.kim@lge.com>,
	<qyousef@layalina.io>, <sshegde@linux.ibm.com>, <alexs@kernel.org>,
	<lukasz.luba@arm.com>, <cpru@amazon.com>, <gautham.shenoy@amd.com>,
	<kprateek.nayak@amd.com>, <ravi.bangoria@amd.com>, <swapnil.sapkal@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v4 03/11] perf header: Support CPU DOMAIN relation info
Date: Tue, 26 Aug 2025 05:10:31 +0000
Message-ID: <20250826051039.2626894-4-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250826051039.2626894-1-swapnil.sapkal@amd.com>
References: <20250826051039.2626894-1-swapnil.sapkal@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|BN5PR12MB9463:EE_
X-MS-Office365-Filtering-Correlation-Id: 83da7b12-882b-496f-d0f4-08dde45f26f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CFO9vdO9FItp1HnqUzaZPWrvomn8JXQGJeRaQUpA0ZKeFVhH5z0xsOBT+EDr?=
 =?us-ascii?Q?6k7WGBuje+NQlvI2ktXsnlCZRYLBjzmQ/4LQZ81MKtsoCuY6C93h/CZnbqjQ?=
 =?us-ascii?Q?jG4UHFytJ/Qg8ZGAbuNbZfY9FGPs+C5gKhh6MSwT8927HfUqao3ZSg9CAGNK?=
 =?us-ascii?Q?wZosxy+Gh7dQkCUatzoDxtrDlILFs2nLOz2IkxAA7zGaRTJRYvfw4uD2If/5?=
 =?us-ascii?Q?FYP4l9Am4k98DBFWylHeMSR99Gjmf1SGCvqhny795eGjd98OVGvVI4FeN5jr?=
 =?us-ascii?Q?eTNqrpuGubxJD+0INepq4sBk9Q8HjCSslhjaos1wjfmgyKwaKTHlPP2ff3mo?=
 =?us-ascii?Q?YGX8CcDNXEUMvIcV+YRv4B740KRrk+0Jrh3e+ywNIu3B7tIfB47hOqYudRZK?=
 =?us-ascii?Q?MC0bpP6b0vOKSxlOWLIhXaz7AZ5zEAb+XfFBJa05K3YklNUlPnrQ3gJvbdRb?=
 =?us-ascii?Q?mgElkibFEx6z5DdFq0aWw66paOlBySapQX8RewuJVnQyaw+Dp7+tpb8DBidF?=
 =?us-ascii?Q?h/R1mZxswf/4L8b32hnQXTNLXEXrqHc/hXeSryW0tiRs8u6tIA4c9H34rNQw?=
 =?us-ascii?Q?kssAI5POvdyAgkHdcdZKlJFUYyWbtaUsIWn5PYPLLCbFA7NTuXxIqO4Q0KgN?=
 =?us-ascii?Q?8Nxu25vNLzW8zgyPtmULrn/VvQYTA6qMZbTQbeQsTtDNxXIV0ChWje+iLqif?=
 =?us-ascii?Q?rsFMJTRdoSiz4dgrxlIXmgFYs1eKU4Qvt11JpbHJ01fDiqWULD3Qpvw6ZARg?=
 =?us-ascii?Q?x6hH2n0GVX5+R7Od7lbLYf02GvIu21B1ievMamUN3ugcUg+8zFxnOrcvfnSh?=
 =?us-ascii?Q?4GQDXJEDuoJVxzn/5BQppDTfutn880rZKQPNQsXwXTuJ1NSbuKFGfnjLogqV?=
 =?us-ascii?Q?lbbdQzQZTubyH7cB9qUJtFc6+zh7i3dwDuWsCZuddZvWqlq6Hyqkzfr8BQH0?=
 =?us-ascii?Q?QPLyKWb6NNpJSvq+ZJG61lJewBctwb3uEocDYaUSCnuORF0BKZaKO0relojD?=
 =?us-ascii?Q?BfLlC6hKpJspJH9cwPB3Cuv+C9gaIN9PJvU9OlN1TEXWwEe1QLAkunDGnV/y?=
 =?us-ascii?Q?T2flV0zJumpbFIrd4goeBkEMc+kM4hN21eaL5J0vxW+YPHuZ7szeL0Z75cs/?=
 =?us-ascii?Q?3aaW5tGSLovRaN+gn9nTrdIhMtMQA4enxIYrAuvpv8/sjYf9W+XFzhZNlS5f?=
 =?us-ascii?Q?AvkB6DMQzVZsrtc6732XID9EAlQh6K1pWw0CccKIZEfRnhhPSMOD+eyCNwsL?=
 =?us-ascii?Q?QgBTfa4kfExvZJMxmcsQs00jv6L0m+FWN+vWgXm8mukU/3QYPe0JgVArq3G6?=
 =?us-ascii?Q?F2mwqsKmvWcmSn5iAysh8872hwxt80ixHxbcpfUEabRhnR07LppeZtnoaheq?=
 =?us-ascii?Q?Eo4HfgWwnFlurzUkvjNVd50EVG/esP9P96f2RuPhmSQYC6qqLdeGjqr9RCKZ?=
 =?us-ascii?Q?FvQX1HJkYY6IMB1EdoH88lHgTLJcakcSFcMawtHW8yYOa8NtBUg27h/1Af6E?=
 =?us-ascii?Q?xmgyt9L9JxQq7XqjWsN1HOtjAgfJALt6gPt8?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 05:12:28.1588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83da7b12-882b-496f-d0f4-08dde45f26f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9463

'/proc/schedstat' gives the info about load balancing statistics within
a given domain. It also contains the cpu_mask giving information about
the sibling cpus and domain names after schedstat version 17. Storing
this information in perf header will help tools like `perf sched stats`
for better analysis.

Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 .../Documentation/perf.data-file-format.txt   |  17 +
 tools/perf/builtin-inject.c                   |   1 +
 tools/perf/util/env.h                         |  16 +
 tools/perf/util/header.c                      | 304 ++++++++++++++++++
 tools/perf/util/header.h                      |   1 +
 tools/perf/util/util.c                        |  42 +++
 tools/perf/util/util.h                        |   3 +
 7 files changed, 384 insertions(+)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index cd95ba09f727..92dbba1003cf 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -437,6 +437,23 @@ struct {
 	} [nr_pmu];
 };
 
+	HEADER_CPU_DOMAIN_INFO = 32,
+
+List of cpu-domain relation info. The format of the data is as below.
+
+struct domain_info {
+	int domain;
+	char dname[];
+	char cpumask[];
+	char cpulist[];
+};
+
+struct cpu_domain_info {
+	int cpu;
+	int nr_domains;
+	struct domain_info domains[];
+};
+
 	other bits are reserved and should ignored for now
 	HEADER_FEAT_BITS	= 256,
 
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 40ba6a94f719..fce21fecfec5 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2058,6 +2058,7 @@ static bool keep_feat(int feat)
 	case HEADER_CLOCK_DATA:
 	case HEADER_HYBRID_TOPOLOGY:
 	case HEADER_PMU_CAPS:
+	case HEADER_CPU_DOMAIN_INFO:
 		return true;
 	/* Information that can be updated */
 	case HEADER_BUILD_ID:
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index e00179787a34..71034c4b4488 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -54,6 +54,19 @@ struct pmu_caps {
 	char            *pmu_name;
 };
 
+struct domain_info {
+	u32	domain;
+	char	*dname;
+	char	*cpumask;
+	char	*cpulist;
+};
+
+struct cpu_domain_map {
+	u32			cpu;
+	u32			nr_domains;
+	struct domain_info	**domains;
+};
+
 typedef const char *(arch_syscalls__strerrno_t)(int err);
 
 struct perf_env {
@@ -70,6 +83,8 @@ struct perf_env {
 	unsigned int		max_branches;
 	unsigned int		br_cntr_nr;
 	unsigned int		br_cntr_width;
+	unsigned int		schedstat_version;
+	unsigned int		max_sched_domains;
 	int			kernel_is_64_bit;
 
 	int			nr_cmdline;
@@ -92,6 +107,7 @@ struct perf_env {
 	char			**cpu_pmu_caps;
 	struct cpu_topology_map	*cpu;
 	struct cpu_cache_level	*caches;
+	struct cpu_domain_map	**cpu_domain;
 	int			 caches_cnt;
 	u32			comp_ratio;
 	u32			comp_ver;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 4f2a6e10ed5c..7ff7434bac2c 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1621,6 +1621,184 @@ static int write_pmu_caps(struct feat_fd *ff,
 	return 0;
 }
 
+static void free_cpu_domain_info(struct cpu_domain_map **cd_map, u32 schedstat_version, u32 nr)
+{
+	for (u32 i = 0; i < nr; i++) {
+		if (cd_map[i]->domains) {
+			for (u32 j = 0; j < cd_map[i]->nr_domains; j++) {
+				struct domain_info *d_info = cd_map[i]->domains[j];
+
+				if (schedstat_version >= 17)
+					free(d_info->dname);
+
+				free(d_info->cpumask);
+				free(d_info->cpulist);
+			}
+			free(cd_map[i]->domains);
+		}
+	}
+
+	free(cd_map);
+}
+
+static struct cpu_domain_map  **build_cpu_domain_map(u32 *schedstat_version, u32 *max_sched_domains,
+						     u32 nr)
+{
+	struct domain_info *domain_info;
+	struct cpu_domain_map **cd_map;
+	char dname[16], cpumask[256];
+	char cpulist[1024];
+	char *line = NULL;
+	u32 cpu, domain;
+	u32 dcount = 0;
+	size_t len;
+	FILE *fp;
+
+	fp = fopen("/proc/schedstat", "r");
+	if (!fp) {
+		pr_err("Failed to open /proc/schedstat\n");
+		return NULL;
+	}
+
+	cd_map = calloc(nr, sizeof(*cd_map));
+	if (!cd_map)
+		goto out;
+
+	while (getline(&line, &len, fp) > 0) {
+		int retval;
+
+		if (strncmp(line, "version", 7) == 0) {
+			retval = sscanf(line, "version %d\n", schedstat_version);
+			if (retval != 1)
+				continue;
+
+		} else if (strncmp(line, "cpu", 3) == 0) {
+			retval = sscanf(line, "cpu%u %*s", &cpu);
+			if (retval == 1) {
+				cd_map[cpu] = calloc(1, sizeof(*cd_map[cpu]));
+				if (!cd_map[cpu])
+					goto out_free_line;
+				cd_map[cpu]->cpu = cpu;
+			} else
+				continue;
+
+			dcount = 0;
+		} else if (strncmp(line, "domain", 6) == 0) {
+			dcount++;
+
+			cd_map[cpu]->domains = realloc(cd_map[cpu]->domains,
+						       dcount * sizeof(domain_info));
+			if (!cd_map[cpu]->domains)
+				goto out_free_line;
+
+			domain_info = calloc(1, sizeof(*domain_info));
+			if (!domain_info)
+				goto out_free_line;
+
+			cd_map[cpu]->domains[dcount - 1] = domain_info;
+
+			if (*schedstat_version >= 17) {
+				retval = sscanf(line, "domain%u %s %s %*s", &domain, dname,
+						cpumask);
+				if (retval != 3)
+					continue;
+
+				domain_info->dname = calloc(strlen(dname) + 1, sizeof(char));
+				if (!domain_info->dname)
+					goto out_free_line;
+
+				strcpy(domain_info->dname, dname);
+			} else {
+				retval = sscanf(line, "domain%u %s %*s", &domain, cpumask);
+				if (retval != 2)
+					continue;
+			}
+
+			domain_info->domain = domain;
+			if (domain > *max_sched_domains)
+				*max_sched_domains = domain;
+
+			domain_info->cpumask = calloc(strlen(cpumask) + 1, sizeof(char));
+			if (!domain_info->cpumask)
+				goto out_free_line;
+
+			strcpy(domain_info->cpumask, cpumask);
+
+			cpumask_to_cpulist(cpumask, cpulist);
+			domain_info->cpulist = calloc(strlen(cpulist) + 1, sizeof(char));
+			if (!domain_info->cpulist)
+				goto out_free_line;
+
+			strcpy(domain_info->cpulist, cpulist);
+			cd_map[cpu]->nr_domains = dcount;
+		}
+	}
+
+out_free_line:
+	free(line);
+out:
+	fclose(fp);
+	return cd_map;
+}
+
+static int write_cpu_domain_info(struct feat_fd *ff,
+				 struct evlist *evlist __maybe_unused)
+{
+	u32 max_sched_domains = 0, schedstat_version = 0;
+	struct cpu_domain_map **cd_map;
+	u32 i, j, nr, ret;
+
+	nr = cpu__max_present_cpu().cpu;
+
+	cd_map = build_cpu_domain_map(&schedstat_version, &max_sched_domains, nr);
+	if (!cd_map)
+		return -1;
+
+	ret = do_write(ff, &schedstat_version, sizeof(u32));
+	if (ret < 0)
+		goto out;
+
+	max_sched_domains += 1;
+	ret = do_write(ff, &max_sched_domains, sizeof(u32));
+	if (ret < 0)
+		goto out;
+
+	for (i = 0; i < nr; i++) {
+		if (cd_map[i]->domains) {
+			ret = do_write(ff, &cd_map[i]->cpu, sizeof(u32));
+			if (ret < 0)
+				goto out;
+
+			ret = do_write(ff, &cd_map[i]->nr_domains, sizeof(u32));
+			if (ret < 0)
+				goto out;
+
+			for (j = 0; j < cd_map[i]->nr_domains; j++) {
+				ret = do_write(ff, &cd_map[i]->domains[j]->domain, sizeof(u32));
+				if (ret < 0)
+					goto out;
+				if (schedstat_version >= 17) {
+					ret = do_write_string(ff, cd_map[i]->domains[j]->dname);
+					if (ret < 0)
+						goto out;
+				}
+
+				ret = do_write_string(ff, cd_map[i]->domains[j]->cpumask);
+				if (ret < 0)
+					goto out;
+
+				ret = do_write_string(ff, cd_map[i]->domains[j]->cpulist);
+				if (ret < 0)
+					goto out;
+			}
+		}
+	}
+
+out:
+	free_cpu_domain_info(cd_map, schedstat_version, nr);
+	return ret;
+}
+
 static void print_hostname(struct feat_fd *ff, FILE *fp)
 {
 	fprintf(fp, "# hostname : %s\n", ff->ph->env.hostname);
@@ -2254,6 +2432,35 @@ static void print_mem_topology(struct feat_fd *ff, FILE *fp)
 	}
 }
 
+static void print_cpu_domain_info(struct feat_fd *ff, FILE *fp)
+{
+	struct cpu_domain_map **cd_map = ff->ph->env.cpu_domain;
+	u32 nr = ff->ph->env.nr_cpus_avail;
+	struct domain_info *d_info;
+	u32 i, j;
+
+	fprintf(fp, "# schedstat version	: %u\n", ff->ph->env.schedstat_version);
+	fprintf(fp, "# Maximum sched domains	: %u\n", ff->ph->env.max_sched_domains);
+
+	for (i = 0; i < nr; i++) {
+		if (cd_map[i]->domains) {
+			fprintf(fp, "# cpu		: %u\n", cd_map[i]->cpu);
+			fprintf(fp, "# nr_domains	: %u\n", cd_map[i]->nr_domains);
+
+			for (j = 0; j < cd_map[i]->nr_domains; j++) {
+				d_info = cd_map[i]->domains[j];
+				fprintf(fp, "# Domain		: %u\n", d_info->domain);
+
+				if (ff->ph->env.schedstat_version >= 17)
+					fprintf(fp, "# Domain name      : %s\n", d_info->dname);
+
+				fprintf(fp, "# Domain cpu map   : %s\n", d_info->cpumask);
+				fprintf(fp, "# Domain cpu list  : %s\n", d_info->cpulist);
+			}
+		}
+	}
+}
+
 static int __event_process_build_id(struct perf_record_header_build_id *bev,
 				    char *filename,
 				    struct perf_session *session)
@@ -3395,6 +3602,102 @@ static int process_pmu_caps(struct feat_fd *ff, void *data __maybe_unused)
 	return ret;
 }
 
+static int process_cpu_domain_info(struct feat_fd *ff, void *data __maybe_unused)
+{
+	u32 schedstat_version, max_sched_domains, cpu, domain, nr_domains;
+	struct perf_env *env = &ff->ph->env;
+	char *dname, *cpumask, *cpulist;
+	struct cpu_domain_map **cd_map;
+	struct domain_info *d_info;
+	u32 nra, nr, i, j;
+	int ret;
+
+	nra = env->nr_cpus_avail;
+	nr = env->nr_cpus_online;
+
+	cd_map = calloc(nra, sizeof(*cd_map));
+	if (!cd_map)
+		return -1;
+
+	env->cpu_domain = cd_map;
+
+	ret = do_read_u32(ff, &schedstat_version);
+	if (ret)
+		return ret;
+
+	env->schedstat_version = schedstat_version;
+
+	ret = do_read_u32(ff, &max_sched_domains);
+	if (ret)
+		return ret;
+
+	env->max_sched_domains = max_sched_domains;
+
+	for (i = 0; i < nr; i++) {
+		if (do_read_u32(ff, &cpu))
+			return -1;
+
+		cd_map[cpu] = calloc(1, sizeof(*cd_map[cpu]));
+		if (!cd_map[cpu])
+			return -1;
+
+		cd_map[cpu]->cpu = cpu;
+
+		if (do_read_u32(ff, &nr_domains))
+			return -1;
+
+		cd_map[cpu]->nr_domains = nr_domains;
+
+		cd_map[cpu]->domains = calloc(max_sched_domains, sizeof(*d_info));
+		if (!cd_map[cpu]->domains)
+			return -1;
+
+		for (j = 0; j < nr_domains; j++) {
+			if (do_read_u32(ff, &domain))
+				return -1;
+
+			d_info = calloc(1, sizeof(*d_info));
+			if (!d_info)
+				return -1;
+
+			cd_map[cpu]->domains[domain] = d_info;
+			d_info->domain = domain;
+
+			if (schedstat_version >= 17) {
+				dname = do_read_string(ff);
+				if (!dname)
+					return -1;
+
+				d_info->dname = calloc(strlen(dname) + 1, sizeof(char));
+				if (!d_info->dname)
+					return -1;
+
+				strcpy(d_info->dname, dname);
+			}
+
+			cpumask = do_read_string(ff);
+			if (!cpumask)
+				return -1;
+
+			d_info->cpumask = calloc(strlen(cpumask) + 1, sizeof(char));
+			if (!d_info->cpumask)
+				return -1;
+			strcpy(d_info->cpumask, cpumask);
+
+			cpulist = do_read_string(ff);
+			if (!cpulist)
+				return -1;
+
+			d_info->cpulist = calloc(strlen(cpulist) + 1, sizeof(char));
+			if (!d_info->cpulist)
+				return -1;
+			strcpy(d_info->cpulist, cpulist);
+		}
+	}
+
+	return ret;
+}
+
 #define FEAT_OPR(n, func, __full_only) \
 	[HEADER_##n] = {					\
 		.name	    = __stringify(n),			\
@@ -3460,6 +3763,7 @@ const struct perf_header_feature_ops feat_ops[HEADER_LAST_FEATURE] = {
 	FEAT_OPR(CLOCK_DATA,	clock_data,	false),
 	FEAT_OPN(HYBRID_TOPOLOGY,	hybrid_topology,	true),
 	FEAT_OPR(PMU_CAPS,	pmu_caps,	false),
+	FEAT_OPR(CPU_DOMAIN_INFO,	cpu_domain_info,	true),
 };
 
 struct header_print_data {
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index d16dfceccd74..edcb95e0dc49 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -53,6 +53,7 @@ enum {
 	HEADER_CLOCK_DATA,
 	HEADER_HYBRID_TOPOLOGY,
 	HEADER_PMU_CAPS,
+	HEADER_CPU_DOMAIN_INFO,
 	HEADER_LAST_FEATURE,
 	HEADER_FEAT_BITS	= 256,
 };
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 1b91834e11de..47bfc0259b0e 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -263,6 +263,48 @@ void print_separator(int pre_dash_cnt, const char *s, int post_dash_cnt)
 	       graph_dotted_line);
 }
 
+void cpumask_to_cpulist(char *cpumask, char *cpulist)
+{
+	int i, j, bm_size, nbits;
+	int len = strlen(cpumask);
+	unsigned long *bm;
+	char cpus[1024];
+
+	for (i = 0; i < len; i++) {
+		if (cpumask[i] == ',') {
+			for (j = i; j < len; j++)
+				cpumask[j] = cpumask[j + 1];
+		}
+	}
+
+	len = strlen(cpumask);
+	bm_size = (len + 15) / 16;
+	nbits = bm_size * 64;
+	if (nbits <= 0)
+		return;
+
+	bm = calloc(bm_size, sizeof(unsigned long));
+	if (!cpumask)
+		goto free_bm;
+
+	for (i = 0; i < bm_size; i++) {
+		char blk[17];
+		int blklen = len > 16 ? 16 : len;
+
+		strncpy(blk, cpumask + len - blklen, blklen);
+		blk[len] = '\0';
+		bm[i] = strtoul(blk, NULL, 16);
+		cpumask[len - blklen] = '\0';
+		len = strlen(cpumask);
+	}
+
+	bitmap_scnprintf(bm, nbits, cpus, sizeof(cpus));
+	strcpy(cpulist, cpus);
+
+free_bm:
+	free(bm);
+}
+
 int rm_rf_perf_data(const char *path)
 {
 	const char *pat[] = {
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index de69384380c2..90a8b4d2e59c 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -11,6 +11,7 @@
 #include <stdbool.h>
 #include <stddef.h>
 #include <linux/compiler.h>
+#include <linux/bitmap.h>
 #include <sys/types.h>
 #ifndef __cplusplus
 #include <internal/cpumap.h>
@@ -50,6 +51,8 @@ int perf_tip(char **strp, const char *dirpath);
 
 void print_separator(int pre_dash_cnt, const char *s, int post_dash_cnt);
 
+void cpumask_to_cpulist(char *cpumask, char *cpulist);
+
 #ifndef HAVE_SCHED_GETCPU_SUPPORT
 int sched_getcpu(void);
 #endif
-- 
2.43.0


