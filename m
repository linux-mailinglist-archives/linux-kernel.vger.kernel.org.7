Return-Path: <linux-kernel+bounces-808060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F731B4ACB2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3FF74E63A8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0DF306D23;
	Tue,  9 Sep 2025 11:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PsEVmc0b"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69282F0C6C;
	Tue,  9 Sep 2025 11:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418331; cv=fail; b=TRH7dF0KzMHWuxqa9FFsqNYNXYQpDdFztd3IV3rrfpIVbBZdKyXR1ALcdNbM/OPQ77GfU75hso5LhWAsADaFUHoAh+g9qbPS6M3y/7ImdrZE6pw0lxb1KEUURZmfKcpunvjwH33vK24t59aYglkxLCPCFEcYUfJ/uv9f+lYFXPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418331; c=relaxed/simple;
	bh=HYF4UFxESg33b1afh/Gihu+ATGZShcKxy+t4Axu1y+g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=udXLFZ+qoWfLarryqZRKLJx0KGV450yFSSBjWLuutVdnFzVZBXtFQZPDATlFufFEW+ZALXTVQ0oondJvP9CrhC1hQrNWay/IuqwTHjwwBzha33CBZbTfvy6ye3BSE5gqQRbPvMveHe8lmZB02OV8eYrhQKyeK2ls5svNaHkyf+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PsEVmc0b; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUU9XYwOvCi3fDFhpnaqZqv9KbSiLZTEVSON/hM9LYA/+4IPYgS8cG6P01070x2LoWRk41IxJ5wb5mrk/rK5FrQ/Tl0qm7ktxl1lehmiUU0rdObjOuR2IdkpCo8M5FVudwpGenK70l9+cLOT/XGTXUWiYCppnbSbSL/y4RZ1qU9AogtNnxrUrPJKoQM3w47oUZvju98Gx/GDY39S1jcIFhdrqwjUhg6stL1bVds00ydkXIFcOUVMRnQtgMjK5QnEDjN2LIXfzWxvonHjGHSaVskBzRlW/mw1jQ30jCIFM5lxD4WnZwSbhQ5rwyLN/xRRlVbD35qjNlEN9iAsw6xfEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jy7NZWoSiI602om3/RMWR8mjMt9Jif6dQiOMj7d2y/4=;
 b=sFsiZ9d7PmskPROcECRgvHrJr8oczJi7qVA3c+IzkzFGzdybu9UpMD2D97eTJSeC49yH0+ipEFyEpdet7XEu252NEIjubLsMFu5yleIJXS+l43kLztEtpwH1u0VaMmyCi5/jmvdTVgKBsMsX6Z2gBOik7K1tR7O1jw8U6JF/gQbdg663rhTeeNFeUcm3+d5OijurkpB90Rpk/4hyOCJrCOgZz5MWbiCzcZjtwJC2zmQbVGLg7wSdIBKjWVpKX7VbD9kLlvG/r3uvOwI08z1j9FuNacUAGTWimuUB9PDr1HRntUjyGsH9ydNWjgfYIXl4yg2i/e0XrVjk78KGqtwPzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jy7NZWoSiI602om3/RMWR8mjMt9Jif6dQiOMj7d2y/4=;
 b=PsEVmc0bGvU152n1ViGTaLWEeTP21Mal5AdhE2JSjqr/c4GyIsKxDZzXGuuG5zV6+LCdd3QnLOQrHC5B3iwOBnS8EDXYC8GYULlIrSei08E3mBBMCiPe+Hcm2ZCi7Y0qgDdzoh6Ds5TAVPY7G4EBkpP1iat6G8CT1q52FEX6iio=
Received: from MN0PR04CA0029.namprd04.prod.outlook.com (2603:10b6:208:52d::34)
 by CY5PR12MB6202.namprd12.prod.outlook.com (2603:10b6:930:25::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 11:45:21 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:208:52d:cafe::3d) by MN0PR04CA0029.outlook.office365.com
 (2603:10b6:208:52d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Tue,
 9 Sep 2025 11:45:20 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 11:45:18 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 04:45:03 -0700
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>, <james.clark@arm.com>
CC: <ravi.bangoria@amd.com>, <swapnil.sapkal@amd.com>, <yu.c.chen@intel.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <void@manifault.com>, <tj@kernel.org>,
	<sshegde@linux.ibm.com>, <ctshao@google.com>, <quic_zhonhan@quicinc.com>,
	<thomas.falcon@intel.com>, <blakejones@google.com>, <ashelat@redhat.com>,
	<leo.yan@arm.com>, <dvyukov@google.com>, <ak@linux.intel.com>,
	<yujie.liu@intel.com>, <graham.woodward@arm.com>, <ben.gainey@arm.com>,
	<vineethr@linux.ibm.com>, <tim.c.chen@linux.intel.com>, <linux@treblig.org>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<santosh.shukla@amd.com>, <sandipan.das@amd.com>, James Clark
	<james.clark@linaro.org>
Subject: [PATCH RESEND v4 04/11] perf sched stats: Add record and rawdump support
Date: Tue, 9 Sep 2025 11:42:20 +0000
Message-ID: <20250909114227.58802-5-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909114227.58802-1-swapnil.sapkal@amd.com>
References: <20250909114227.58802-1-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|CY5PR12MB6202:EE_
X-MS-Office365-Filtering-Correlation-Id: 967e8cd9-1ab8-42f1-5923-08ddef9659da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KrFBlkiLP1Nvzq14UGi+VOZZZokftIxcuguW442olays9pMexbmJn2MoZUa3?=
 =?us-ascii?Q?tYdmusYHVvR1oL+oCZnC3T+fDdcm2yD0vj+pMLe0eBophAvGiErq5v8rI9Xs?=
 =?us-ascii?Q?AlJPTQIHtxw6r4dVpUHLSajOpYMrRKKFyc81sqAF2OeKH8SyKxTzpjYwYxPO?=
 =?us-ascii?Q?hcAXeaHCdUXm+QEDMxtbU6c+6pCVoyfzxp1YP3g6TV8zO2FobMNCrJN/iyR/?=
 =?us-ascii?Q?Q+aEqCHMh/uaV/Vl7uCuyvMTtIiA2ayIJj62KH9CDTRfK+1GzEf59ncaJqbr?=
 =?us-ascii?Q?2ScToMz5r/+CdfqljhnlCUlLtB3UjfZXoJg1HAVCNV1XEJKHZq2cyycovmfY?=
 =?us-ascii?Q?XyHF3NK8adt2EovbVsnDl35fy8gNxTm8mhDkeqy/WXDV2+kM1ZIfRgb4TISz?=
 =?us-ascii?Q?CyU2kovxmZk2BwPtJom3At9TDTcS+6tBinKaqseCbEet/31l/aPbjUvRxcfr?=
 =?us-ascii?Q?qTYpDgsNqubW3H6Qdpr/uIWzBYZ6ZiKUrGlriaDw/fIP0ZMZpk3gJ5S4Qzu/?=
 =?us-ascii?Q?u0BAhw1DpWMgrFgnKZviI0AJtkTfDiBdCOQ8fZ78O2B7L+if9GVb7sHK8aEz?=
 =?us-ascii?Q?dtkTeP5LFflq8ZcssfEScCfzVizgZQskE4dBR+EAvgO6s41bgr0FI7Hs0NQT?=
 =?us-ascii?Q?WJUuLeoUlk8E6iEWh4vhBvRQRxvvnbfuzJMez/+mymTmlnRCC6BKARBMiC9a?=
 =?us-ascii?Q?SPz3qoana1dx3yT3QqFpYk6DjGxkwhIKG0agBeq934+OPww7Q+431a2rd6me?=
 =?us-ascii?Q?vsZO/vZF9/TNHGR6OLG6kTzLhar4vByF8x0Wz4ekbE08pZJQqX2Mdn4+uLCM?=
 =?us-ascii?Q?o96leBHYOJOl9BZmCs3NIqqDYUoV7R4CEPReU9jNOhFcF48cvJ36gG72+kiR?=
 =?us-ascii?Q?mygb0I1cQocPm3O7Tyj10jRfDQw8BQZ+Mn0Ok4/fyL58pD94L8xttVl9qhkI?=
 =?us-ascii?Q?KX0T6qAO7DxXz3AITQiRGxQ5ug7/ttMwV+1fCLXtAEqSoNK5H8j17D3/c26V?=
 =?us-ascii?Q?usix7zwtJQgMZd+VstiswvApKAs55OcnMEac2TUTEWLsiTsF9hXce0gkKhGL?=
 =?us-ascii?Q?WAeBO7wW9DIJa5O0a737F1U6BfcHoZTZJB4NkssWPcJ5HBdJf7p29yMKt8f0?=
 =?us-ascii?Q?0+PzkRMpcohngih4Kdvuw8nZIALIduwMW9+CzDqOzCIhTQ6S1LIxVRzdv86U?=
 =?us-ascii?Q?L9qXKAamdemfg3KoE247uIFX+2YyA04Nq5v/HmHzzZwVVeEa3zSeAyj+3REM?=
 =?us-ascii?Q?86mh+jg7m/55pFePaQCvxF8IJhUT0CXKrqmF5r5WhlifP8+bjmt2klCNdFHY?=
 =?us-ascii?Q?cJjl8dTv83MXdjo9qRjk4Itkm02htUEWkQ0c40OMSf8iUFAO869i9Gug6z2z?=
 =?us-ascii?Q?avFClW5cgfB6GKJDvfd6/08K6g2zagqS+hYML6pWqumb5EOXLOsnixP+CiPP?=
 =?us-ascii?Q?ILAhMlx+wvkl8JX84S9e35mPLm+kZRcR8R0fZxKuHlqD5wM19q+MbyP+Z04e?=
 =?us-ascii?Q?hntjuYvw9dbkHVb3n7jR2I9f1VuVNrr+EQeY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 11:45:18.7681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 967e8cd9-1ab8-42f1-5923-08ddef9659da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6202

Define new, perf tool only, sample types and their layouts. Add logic
to parse /proc/schedstat, convert it to perf sample format and save
samples to perf.data file with `perf sched stats record` command. Also
add logic to read perf.data file, interpret schedstat samples and
print rawdump of samples with `perf script -D`.

Note that, /proc/schedstat file output is standardized with version
number. The patch supports v15 but older or newer version can be added
easily.

Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/lib/perf/Documentation/libperf.txt    |   2 +
 tools/lib/perf/Makefile                     |   1 +
 tools/lib/perf/include/perf/event.h         |  41 ++++
 tools/lib/perf/include/perf/schedstat-v15.h | 146 +++++++++++++
 tools/perf/builtin-inject.c                 |   2 +
 tools/perf/builtin-sched.c                  | 222 +++++++++++++++++++-
 tools/perf/util/event.c                     |  40 ++++
 tools/perf/util/event.h                     |   2 +
 tools/perf/util/session.c                   |  22 ++
 tools/perf/util/synthetic-events.c          | 179 ++++++++++++++++
 tools/perf/util/synthetic-events.h          |   3 +
 tools/perf/util/tool.c                      |  18 ++
 tools/perf/util/tool.h                      |   4 +-
 13 files changed, 680 insertions(+), 2 deletions(-)
 create mode 100644 tools/lib/perf/include/perf/schedstat-v15.h

diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
index 4072bc9b7670..576ecc5fc312 100644
--- a/tools/lib/perf/Documentation/libperf.txt
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -211,6 +211,8 @@ SYNOPSIS
   struct perf_record_header_feature;
   struct perf_record_compressed;
   struct perf_record_compressed2;
+  struct perf_record_schedstat_cpu;
+  struct perf_record_schedstat_domain;
 --
 
 DESCRIPTION
diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index 7fbb50b74c00..9fa28e512ca8 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -179,6 +179,7 @@ install_lib: libs
 		cp -fpR $(LIBPERF_ALL) $(DESTDIR)$(libdir_SQ)
 
 HDRS := bpf_perf.h core.h cpumap.h threadmap.h evlist.h evsel.h event.h mmap.h
+HDRS += schedstat-v15.h
 INTERNAL_HDRS := cpumap.h evlist.h evsel.h lib.h mmap.h rc_check.h threadmap.h xyarray.h
 
 INSTALL_HDRS_PFX := $(DESTDIR)$(prefix)/include/perf
diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index 6608f1e3701b..7ed7bae73b55 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -483,6 +483,43 @@ struct perf_record_bpf_metadata {
 	struct perf_record_bpf_metadata_entry entries[];
 };
 
+struct perf_record_schedstat_cpu_v15 {
+#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)		_type _name
+#include "schedstat-v15.h"
+#undef CPU_FIELD
+};
+
+struct perf_record_schedstat_cpu {
+	struct perf_event_header header;
+	__u64			 timestamp;
+	__u32			 cpu;
+	__u16			 version;
+	/* Padding */
+	char			 __pad[2];
+	union {
+		struct perf_record_schedstat_cpu_v15 v15;
+	};
+};
+
+struct perf_record_schedstat_domain_v15 {
+#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)		_type _name
+#include "schedstat-v15.h"
+#undef DOMAIN_FIELD
+};
+
+#define DOMAIN_NAME_LEN		16
+
+struct perf_record_schedstat_domain {
+	struct perf_event_header header;
+	__u64			 timestamp;
+	__u32			 cpu;
+	__u16			 version;
+	__u16			 domain;
+	union {
+		struct perf_record_schedstat_domain_v15 v15;
+	};
+};
+
 enum perf_user_event_type { /* above any possible kernel type */
 	PERF_RECORD_USER_TYPE_START		= 64,
 	PERF_RECORD_HEADER_ATTR			= 64,
@@ -506,6 +543,8 @@ enum perf_user_event_type { /* above any possible kernel type */
 	PERF_RECORD_FINISHED_INIT		= 82,
 	PERF_RECORD_COMPRESSED2			= 83,
 	PERF_RECORD_BPF_METADATA		= 84,
+	PERF_RECORD_SCHEDSTAT_CPU		= 85,
+	PERF_RECORD_SCHEDSTAT_DOMAIN		= 86,
 	PERF_RECORD_HEADER_MAX
 };
 
@@ -548,6 +587,8 @@ union perf_event {
 	struct perf_record_compressed		pack;
 	struct perf_record_compressed2		pack2;
 	struct perf_record_bpf_metadata		bpf_metadata;
+	struct perf_record_schedstat_cpu	schedstat_cpu;
+	struct perf_record_schedstat_domain	schedstat_domain;
 };
 
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/lib/perf/include/perf/schedstat-v15.h b/tools/lib/perf/include/perf/schedstat-v15.h
new file mode 100644
index 000000000000..639458df05f8
--- /dev/null
+++ b/tools/lib/perf/include/perf/schedstat-v15.h
@@ -0,0 +1,146 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifdef CPU_FIELD
+CPU_FIELD(__u32, yld_count, "sched_yield() count",
+	  "%11u", false, yld_count, v15);
+CPU_FIELD(__u32, array_exp, "Legacy counter can be ignored",
+	  "%11u", false, array_exp, v15);
+CPU_FIELD(__u32, sched_count, "schedule() called",
+	  "%11u", false, sched_count, v15);
+CPU_FIELD(__u32, sched_goidle, "schedule() left the processor idle",
+	  "%11u", true, sched_count, v15);
+CPU_FIELD(__u32, ttwu_count, "try_to_wake_up() was called",
+	  "%11u", false, ttwu_count, v15);
+CPU_FIELD(__u32, ttwu_local, "try_to_wake_up() was called to wake up the local cpu",
+	  "%11u", true, ttwu_count, v15);
+CPU_FIELD(__u64, rq_cpu_time, "total runtime by tasks on this processor (in jiffies)",
+	  "%11llu", false, rq_cpu_time, v15);
+CPU_FIELD(__u64, run_delay, "total waittime by tasks on this processor (in jiffies)",
+	  "%11llu", true, rq_cpu_time, v15);
+CPU_FIELD(__u64, pcount, "total timeslices run on this cpu",
+	  "%11llu", false, pcount, v15);
+#endif
+
+#ifdef DOMAIN_FIELD
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category idle> ");
+#endif
+DOMAIN_FIELD(__u32, idle_lb_count,
+	     "load_balance() count on cpu idle", "%11u", true, v15);
+DOMAIN_FIELD(__u32, idle_lb_balanced,
+	     "load_balance() found balanced on cpu idle", "%11u", true, v15);
+DOMAIN_FIELD(__u32, idle_lb_failed,
+	     "load_balance() move task failed on cpu idle", "%11u", true, v15);
+DOMAIN_FIELD(__u32, idle_lb_imbalance,
+	     "imbalance sum on cpu idle", "%11u", false, v15);
+DOMAIN_FIELD(__u32, idle_lb_gained,
+	     "pull_task() count on cpu idle", "%11u", false, v15);
+DOMAIN_FIELD(__u32, idle_lb_hot_gained,
+	     "pull_task() when target task was cache-hot on cpu idle", "%11u", false, v15);
+DOMAIN_FIELD(__u32, idle_lb_nobusyq,
+	     "load_balance() failed to find busier queue on cpu idle", "%11u", true, v15);
+DOMAIN_FIELD(__u32, idle_lb_nobusyg,
+	     "load_balance() failed to find busier group on cpu idle", "%11u", true, v15);
+#ifdef DERIVED_CNT_FIELD
+DERIVED_CNT_FIELD(idle_lb_success_count, "load_balance() success count on cpu idle", "%11u",
+		  idle_lb_count, idle_lb_balanced, idle_lb_failed, v15);
+#endif
+#ifdef DERIVED_AVG_FIELD
+DERIVED_AVG_FIELD(idle_lb_avg_pulled,
+		  "avg task pulled per successful lb attempt (cpu idle)", "%11.2Lf",
+		  idle_lb_count, idle_lb_balanced, idle_lb_failed, idle_lb_gained, v15);
+#endif
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category busy> ");
+#endif
+DOMAIN_FIELD(__u32, busy_lb_count,
+	     "load_balance() count on cpu busy", "%11u", true, v15);
+DOMAIN_FIELD(__u32, busy_lb_balanced,
+	     "load_balance() found balanced on cpu busy", "%11u", true, v15);
+DOMAIN_FIELD(__u32, busy_lb_failed,
+	     "load_balance() move task failed on cpu busy", "%11u", true, v15);
+DOMAIN_FIELD(__u32, busy_lb_imbalance,
+	     "imbalance sum on cpu busy", "%11u", false, v15);
+DOMAIN_FIELD(__u32, busy_lb_gained,
+	     "pull_task() count on cpu busy", "%11u", false, v15);
+DOMAIN_FIELD(__u32, busy_lb_hot_gained,
+	     "pull_task() when target task was cache-hot on cpu busy", "%11u", false, v15);
+DOMAIN_FIELD(__u32, busy_lb_nobusyq,
+	     "load_balance() failed to find busier queue on cpu busy", "%11u", true, v15);
+DOMAIN_FIELD(__u32, busy_lb_nobusyg,
+	     "load_balance() failed to find busier group on cpu busy", "%11u", true, v15);
+#ifdef DERIVED_CNT_FIELD
+DERIVED_CNT_FIELD(busy_lb_success_count, "load_balance() success count on cpu busy", "%11u",
+		  busy_lb_count, busy_lb_balanced, busy_lb_failed, v15);
+#endif
+#ifdef DERIVED_AVG_FIELD
+DERIVED_AVG_FIELD(busy_lb_avg_pulled,
+		  "avg task pulled per successful lb attempt (cpu busy)", "%11.2Lf",
+		  busy_lb_count, busy_lb_balanced, busy_lb_failed, busy_lb_gained, v15);
+#endif
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category newidle> ");
+#endif
+DOMAIN_FIELD(__u32, newidle_lb_count,
+	     "load_balance() count on cpu newly idle", "%11u", true, v15);
+DOMAIN_FIELD(__u32, newidle_lb_balanced,
+	     "load_balance() found balanced on cpu newly idle", "%11u", true, v15);
+DOMAIN_FIELD(__u32, newidle_lb_failed,
+	     "load_balance() move task failed on cpu newly idle", "%11u", true, v15);
+DOMAIN_FIELD(__u32, newidle_lb_imbalance,
+	     "imbalance sum on cpu newly idle", "%11u", false, v15);
+DOMAIN_FIELD(__u32, newidle_lb_gained,
+	     "pull_task() count on cpu newly idle", "%11u", false, v15);
+DOMAIN_FIELD(__u32, newidle_lb_hot_gained,
+	     "pull_task() when target task was cache-hot on cpu newly idle", "%11u", false, v15);
+DOMAIN_FIELD(__u32, newidle_lb_nobusyq,
+	     "load_balance() failed to find busier queue on cpu newly idle", "%11u", true, v15);
+DOMAIN_FIELD(__u32, newidle_lb_nobusyg,
+	     "load_balance() failed to find busier group on cpu newly idle", "%11u", true, v15);
+#ifdef DERIVED_CNT_FIELD
+DERIVED_CNT_FIELD(newidle_lb_success_count,
+		  "load_balance() success count on cpu newly idle", "%11u",
+		  newidle_lb_count, newidle_lb_balanced, newidle_lb_failed, v15);
+#endif
+#ifdef DERIVED_AVG_FIELD
+DERIVED_AVG_FIELD(newidle_lb_avg_pulled,
+		  "avg task pulled per successful lb attempt (cpu newly idle)", "%11.2Lf",
+		  newidle_lb_count, newidle_lb_balanced, newidle_lb_failed, newidle_lb_gained, v15);
+#endif
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category active_load_balance()> ");
+#endif
+DOMAIN_FIELD(__u32, alb_count,
+	     "active_load_balance() count", "%11u", false, v15);
+DOMAIN_FIELD(__u32, alb_failed,
+	     "active_load_balance() move task failed", "%11u", false, v15);
+DOMAIN_FIELD(__u32, alb_pushed,
+	     "active_load_balance() successfully moved a task", "%11u", false, v15);
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category sched_balance_exec()> ");
+#endif
+DOMAIN_FIELD(__u32, sbe_count,
+	     "sbe_count is not used", "%11u", false, v15);
+DOMAIN_FIELD(__u32, sbe_balanced,
+	     "sbe_balanced is not used", "%11u", false, v15);
+DOMAIN_FIELD(__u32, sbe_pushed,
+	     "sbe_pushed is not used", "%11u", false, v15);
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category sched_balance_fork()> ");
+#endif
+DOMAIN_FIELD(__u32, sbf_count,
+	     "sbf_count is not used", "%11u", false, v15);
+DOMAIN_FIELD(__u32, sbf_balanced,
+	     "sbf_balanced is not used", "%11u", false, v15);
+DOMAIN_FIELD(__u32, sbf_pushed,
+	     "sbf_pushed is not used", "%11u", false, v15);
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Wakeup Info> ");
+#endif
+DOMAIN_FIELD(__u32, ttwu_wake_remote,
+	     "try_to_wake_up() awoke a task that last ran on a diff cpu", "%11u", false, v15);
+DOMAIN_FIELD(__u32, ttwu_move_affine,
+	     "try_to_wake_up() moved task because cache-cold on own cpu", "%11u", false, v15);
+DOMAIN_FIELD(__u32, ttwu_move_balance,
+	     "try_to_wake_up() started passive balancing", "%11u", false, v15);
+#endif /* DOMAIN_FIELD */
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index f43a7ec44b5f..eadf5ecaa8b2 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2538,6 +2538,8 @@ int cmd_inject(int argc, const char **argv)
 	inject.tool.compressed		= perf_event__repipe_op4_synth;
 	inject.tool.auxtrace		= perf_event__repipe_auxtrace;
 	inject.tool.bpf_metadata	= perf_event__repipe_op2_synth;
+	inject.tool.schedstat_cpu	= perf_event__repipe_op2_synth;
+	inject.tool.schedstat_domain	= perf_event__repipe_op2_synth;
 	inject.tool.dont_split_sample_group = true;
 	inject.session = __perf_session__new(&data, &inject.tool,
 					     /*trace_event_repipe=*/inject.output.is_pipe,
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index f166d6cbc083..2573491fa5f8 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -28,6 +28,8 @@
 #include "util/debug.h"
 #include "util/event.h"
 #include "util/util.h"
+#include "util/synthetic-events.h"
+#include "util/target.h"
 
 #include <linux/kernel.h>
 #include <linux/log2.h>
@@ -55,6 +57,7 @@
 #define MAX_PRIO		140
 
 static const char *cpu_list;
+static struct perf_cpu_map *user_requested_cpus;
 static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
 
 struct sched_atom;
@@ -236,6 +239,9 @@ struct perf_sched {
 	volatile bool   thread_funcs_exit;
 	const char	*prio_str;
 	DECLARE_BITMAP(prio_bitmap, MAX_PRIO);
+
+	struct perf_session *session;
+	struct perf_data *data;
 };
 
 /* per thread run time data */
@@ -3745,6 +3751,195 @@ static void setup_sorting(struct perf_sched *sched, const struct option *options
 	sort_dimension__add("pid", &sched->cmp_pid);
 }
 
+static int process_synthesized_schedstat_event(const struct perf_tool *tool,
+					       union perf_event *event,
+					       struct perf_sample *sample __maybe_unused,
+					       struct machine *machine __maybe_unused)
+{
+	struct perf_sched *sched = container_of(tool, struct perf_sched, tool);
+
+	if (perf_data__write(sched->data, event, event->header.size) <= 0) {
+		pr_err("failed to write perf data, error: %m\n");
+		return -1;
+	}
+
+	sched->session->header.data_size += event->header.size;
+	return 0;
+}
+
+static void sighandler(int sig __maybe_unused)
+{
+}
+
+static int enable_sched_schedstats(int *reset)
+{
+	char path[PATH_MAX];
+	FILE *fp;
+	char ch;
+
+	snprintf(path, PATH_MAX, "%s/sys/kernel/sched_schedstats", procfs__mountpoint());
+	fp = fopen(path, "w+");
+	if (!fp) {
+		pr_err("Failed to open %s\n", path);
+		return -1;
+	}
+
+	ch = getc(fp);
+	if (ch == '0') {
+		*reset = 1;
+		rewind(fp);
+		putc('1', fp);
+		fclose(fp);
+	}
+	return 0;
+}
+
+static int disable_sched_schedstat(void)
+{
+	char path[PATH_MAX];
+	FILE *fp;
+
+	snprintf(path, PATH_MAX, "%s/sys/kernel/sched_schedstats", procfs__mountpoint());
+	fp = fopen(path, "w");
+	if (!fp) {
+		pr_err("Failed to open %s\n", path);
+		return -1;
+	}
+
+	putc('0', fp);
+	fclose(fp);
+	return 0;
+}
+
+/* perf.data or any other output file name used by stats subcommand (only). */
+const char *output_name;
+
+static int perf_sched__schedstat_record(struct perf_sched *sched,
+					int argc, const char **argv)
+{
+	struct perf_session *session;
+	struct target target = {};
+	struct evlist *evlist;
+	int reset = 0;
+	int err = 0;
+	int fd;
+	struct perf_data data = {
+		.path  = output_name,
+		.mode  = PERF_DATA_MODE_WRITE,
+	};
+
+	signal(SIGINT, sighandler);
+	signal(SIGCHLD, sighandler);
+	signal(SIGTERM, sighandler);
+
+	evlist = evlist__new();
+	if (!evlist)
+		return -ENOMEM;
+
+	session = perf_session__new(&data, &sched->tool);
+	if (IS_ERR(session)) {
+		pr_err("Perf session creation failed.\n");
+		evlist__delete(evlist);
+		return PTR_ERR(session);
+	}
+
+	session->evlist = evlist;
+
+	sched->session = session;
+	sched->data = &data;
+
+	fd = perf_data__fd(&data);
+
+	/*
+	 * Capture all important metadata about the system. Although they are
+	 * not used by `perf sched stats` tool directly, they provide useful
+	 * information about profiled environment.
+	 */
+	perf_header__set_feat(&session->header, HEADER_HOSTNAME);
+	perf_header__set_feat(&session->header, HEADER_OSRELEASE);
+	perf_header__set_feat(&session->header, HEADER_VERSION);
+	perf_header__set_feat(&session->header, HEADER_ARCH);
+	perf_header__set_feat(&session->header, HEADER_NRCPUS);
+	perf_header__set_feat(&session->header, HEADER_CPUDESC);
+	perf_header__set_feat(&session->header, HEADER_CPUID);
+	perf_header__set_feat(&session->header, HEADER_TOTAL_MEM);
+	perf_header__set_feat(&session->header, HEADER_CMDLINE);
+	perf_header__set_feat(&session->header, HEADER_CPU_TOPOLOGY);
+	perf_header__set_feat(&session->header, HEADER_NUMA_TOPOLOGY);
+	perf_header__set_feat(&session->header, HEADER_CACHE);
+	perf_header__set_feat(&session->header, HEADER_MEM_TOPOLOGY);
+	perf_header__set_feat(&session->header, HEADER_HYBRID_TOPOLOGY);
+	perf_header__set_feat(&session->header, HEADER_CPU_DOMAIN_INFO);
+
+	err = perf_session__write_header(session, evlist, fd, false);
+	if (err < 0)
+		goto out;
+
+	/*
+	 * `perf sched stats` does not support workload profiling (-p pid)
+	 * since /proc/schedstat file contains cpu specific data only. Hence, a
+	 * profile target is either set of cpus or systemwide, never a process.
+	 * Note that, although `-- <workload>` is supported, profile data are
+	 * still cpu/systemwide.
+	 */
+	if (cpu_list)
+		target.cpu_list = cpu_list;
+	else
+		target.system_wide = true;
+
+	if (argc) {
+		err = evlist__prepare_workload(evlist, &target, argv, false, NULL);
+		if (err)
+			goto out;
+	}
+
+	err = evlist__create_maps(evlist, &target);
+	if (err < 0)
+		goto out;
+
+	user_requested_cpus = evlist->core.user_requested_cpus;
+
+	err = perf_event__synthesize_schedstat(&(sched->tool),
+					       process_synthesized_schedstat_event,
+					       user_requested_cpus);
+	if (err < 0)
+		goto out;
+
+	err = enable_sched_schedstats(&reset);
+	if (err < 0)
+		goto out;
+
+	if (argc)
+		evlist__start_workload(evlist);
+
+	/* wait for signal */
+	pause();
+
+	if (reset) {
+		err = disable_sched_schedstat();
+		if (err < 0)
+			goto out;
+	}
+
+	err = perf_event__synthesize_schedstat(&(sched->tool),
+					       process_synthesized_schedstat_event,
+					       user_requested_cpus);
+	if (err < 0)
+		goto out;
+
+	err = perf_session__write_header(session, evlist, fd, true);
+
+out:
+	if (!err)
+		fprintf(stderr, "[ perf sched stats: Wrote samples to %s ]\n", data.path);
+	else
+		fprintf(stderr, "[ perf sched stats: Failed !! ]\n");
+
+	evlist__delete(evlist);
+	close(fd);
+	return err;
+}
+
 static bool schedstat_events_exposed(void)
 {
 	/*
@@ -3921,6 +4116,12 @@ int cmd_sched(int argc, const char **argv)
 	OPT_BOOLEAN('P', "pre-migrations", &sched.pre_migrations, "Show pre-migration wait time"),
 	OPT_PARENT(sched_options)
 	};
+	const struct option stats_options[] = {
+	OPT_STRING('o', "output", &output_name, "file",
+		   "`stats record` with output filename"),
+	OPT_STRING('C', "cpu", &cpu_list, "cpu", "list of cpus to profile"),
+	OPT_END()
+	};
 
 	const char * const latency_usage[] = {
 		"perf sched latency [<options>]",
@@ -3938,9 +4139,13 @@ int cmd_sched(int argc, const char **argv)
 		"perf sched timehist [<options>]",
 		NULL
 	};
+	const char *stats_usage[] = {
+		"perf sched stats {record} [<options>]",
+		NULL
+	};
 	const char *const sched_subcommands[] = { "record", "latency", "map",
 						  "replay", "script",
-						  "timehist", NULL };
+						  "timehist", "stats", NULL };
 	const char *sched_usage[] = {
 		NULL,
 		NULL
@@ -4038,6 +4243,21 @@ int cmd_sched(int argc, const char **argv)
 		ret = symbol__validate_sym_arguments();
 		if (!ret)
 			ret = perf_sched__timehist(&sched);
+	} else if (!strcmp(argv[0], "stats")) {
+		const char *const stats_subcommands[] = {"record", NULL};
+
+		argc = parse_options_subcommand(argc, argv, stats_options,
+						stats_subcommands,
+						stats_usage,
+						PARSE_OPT_STOP_AT_NON_OPTION);
+
+		if (argv[0] && !strcmp(argv[0], "record")) {
+			if (argc)
+				argc = parse_options(argc, argv, stats_options,
+						     stats_usage, 0);
+			return perf_sched__schedstat_record(&sched, argc, argv);
+		}
+		usage_with_options(stats_usage, stats_options);
 	} else {
 		usage_with_options(sched_usage, sched_options);
 	}
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index fcf44149feb2..41fb942ef701 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -82,6 +82,8 @@ static const char *perf_event__names[] = {
 	[PERF_RECORD_FINISHED_INIT]		= "FINISHED_INIT",
 	[PERF_RECORD_COMPRESSED2]		= "COMPRESSED2",
 	[PERF_RECORD_BPF_METADATA]		= "BPF_METADATA",
+	[PERF_RECORD_SCHEDSTAT_CPU]		= "SCHEDSTAT_CPU",
+	[PERF_RECORD_SCHEDSTAT_DOMAIN]		= "SCHEDSTAT_DOMAIN",
 };
 
 const char *perf_event__name(unsigned int id)
@@ -570,6 +572,44 @@ size_t perf_event__fprintf_text_poke(union perf_event *event, struct machine *ma
 	return ret;
 }
 
+size_t perf_event__fprintf_schedstat_cpu(union perf_event *event, FILE *fp)
+{
+	struct perf_record_schedstat_cpu *cs = &event->schedstat_cpu;
+	size_t size = fprintf(fp, "\ncpu%u ", cs->cpu);
+	__u16 version = cs->version;
+
+#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)		\
+	size += fprintf(fp, "%" PRIu64 " ", (unsigned long)cs->_ver._name)
+
+	if (version == 15) {
+#include <perf/schedstat-v15.h>
+		return size;
+	}
+#undef CPU_FIELD
+
+	return fprintf(fp, "Unsupported /proc/schedstat version %d.\n",
+		       event->schedstat_cpu.version);
+}
+
+size_t perf_event__fprintf_schedstat_domain(union perf_event *event, FILE *fp)
+{
+	struct perf_record_schedstat_domain *ds = &event->schedstat_domain;
+	__u16 version = ds->version;
+	size_t size = fprintf(fp, "\ndomain%u ", ds->domain);
+
+#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)		\
+	size += fprintf(fp, "%" PRIu64 " ", (unsigned long)ds->_ver._name)
+
+	if (version == 15) {
+#include <perf/schedstat-v15.h>
+		return size;
+	}
+#undef DOMAIN_FIELD
+
+	return fprintf(fp, "Unsupported /proc/schedstat version %d.\n",
+		       event->schedstat_domain.version);
+}
+
 size_t perf_event__fprintf(union perf_event *event, struct machine *machine, FILE *fp)
 {
 	size_t ret = fprintf(fp, "PERF_RECORD_%s",
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index e40d16d3246c..5ab8ecc3e1ba 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -372,6 +372,8 @@ size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_bpf(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_bpf_metadata(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_text_poke(union perf_event *event, struct machine *machine,FILE *fp);
+size_t perf_event__fprintf_schedstat_cpu(union perf_event *event, FILE *fp);
+size_t perf_event__fprintf_schedstat_domain(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf(union perf_event *event, struct machine *machine, FILE *fp);
 
 int kallsyms__get_function_start(const char *kallsyms_filename,
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 26ae078278cd..0d5aa6345223 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -697,6 +697,20 @@ static void perf_event__time_conv_swap(union perf_event *event,
 	}
 }
 
+static void
+perf_event__schedstat_cpu_swap(union perf_event *event __maybe_unused,
+			       bool sample_id_all __maybe_unused)
+{
+	/* FIXME */
+}
+
+static void
+perf_event__schedstat_domain_swap(union perf_event *event __maybe_unused,
+				  bool sample_id_all __maybe_unused)
+{
+	/* FIXME */
+}
+
 typedef void (*perf_event__swap_op)(union perf_event *event,
 				    bool sample_id_all);
 
@@ -735,6 +749,8 @@ static perf_event__swap_op perf_event__swap_ops[] = {
 	[PERF_RECORD_STAT_ROUND]	  = perf_event__stat_round_swap,
 	[PERF_RECORD_EVENT_UPDATE]	  = perf_event__event_update_swap,
 	[PERF_RECORD_TIME_CONV]		  = perf_event__time_conv_swap,
+	[PERF_RECORD_SCHEDSTAT_CPU]	  = perf_event__schedstat_cpu_swap,
+	[PERF_RECORD_SCHEDSTAT_DOMAIN]	  = perf_event__schedstat_domain_swap,
 	[PERF_RECORD_HEADER_MAX]	  = NULL,
 };
 
@@ -1499,6 +1515,12 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 	case PERF_RECORD_BPF_METADATA:
 		err = tool->bpf_metadata(session, event);
 		break;
+	case PERF_RECORD_SCHEDSTAT_CPU:
+		err = tool->schedstat_cpu(session, event);
+		break;
+	case PERF_RECORD_SCHEDSTAT_DOMAIN:
+		err = tool->schedstat_domain(session, event);
+		break;
 	default:
 		err = -EINVAL;
 		break;
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index fcd1fd13c30e..01135d80fde5 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2529,3 +2529,182 @@ int parse_synth_opt(char *synth)
 
 	return ret;
 }
+
+static union perf_event *__synthesize_schedstat_cpu(struct io *io, __u16 version,
+						    __u64 *cpu, __u64 timestamp)
+{
+	struct perf_record_schedstat_cpu *cs;
+	union perf_event *event;
+	size_t size;
+	char ch;
+
+	size = sizeof(*cs);
+	size = PERF_ALIGN(size, sizeof(u64));
+	event = zalloc(size);
+
+	if (!event)
+		return NULL;
+
+	cs = &event->schedstat_cpu;
+	cs->header.type = PERF_RECORD_SCHEDSTAT_CPU;
+	cs->header.size = size;
+	cs->timestamp = timestamp;
+
+	if (io__get_char(io) != 'p' || io__get_char(io) != 'u')
+		goto out_cpu;
+
+	if (io__get_dec(io, (__u64 *)cpu) != ' ')
+		goto out_cpu;
+
+#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)	\
+	do {								\
+		__u64 _tmp;						\
+		ch = io__get_dec(io, &_tmp);				\
+		if (ch != ' ' && ch != '\n')				\
+			goto out_cpu;					\
+		cs->_ver._name = _tmp;					\
+	} while (0)
+
+	if (version == 15) {
+#include <perf/schedstat-v15.h>
+	}
+#undef CPU_FIELD
+
+	cs->cpu = *cpu;
+	cs->version = version;
+
+	return event;
+out_cpu:
+	free(event);
+	return NULL;
+}
+
+static union perf_event *__synthesize_schedstat_domain(struct io *io, __u16 version,
+						       __u64 cpu, __u64 timestamp)
+{
+	struct perf_record_schedstat_domain *ds;
+	union perf_event *event = NULL;
+	__u64 d_num;
+	size_t size;
+	char ch;
+
+	if (io__get_char(io) != 'o' || io__get_char(io) != 'm' || io__get_char(io) != 'a' ||
+	    io__get_char(io) != 'i' || io__get_char(io) != 'n')
+		return NULL;
+
+	ch = io__get_dec(io, &d_num);
+
+	/* Skip cpumask as it can be extracted from perf header */
+	while (io__get_char(io) != ' ')
+		continue;
+
+	size = sizeof(*ds);
+	size = PERF_ALIGN(size, sizeof(u64));
+	event = zalloc(size);
+
+	ds = &event->schedstat_domain;
+	ds->header.type = PERF_RECORD_SCHEDSTAT_DOMAIN;
+	ds->header.size = size;
+	ds->version = version;
+	ds->timestamp = timestamp;
+	ds->domain = d_num;
+
+#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)	\
+	do {								\
+		__u64 _tmp;						\
+		ch = io__get_dec(io, &_tmp);				\
+		if (ch != ' ' && ch != '\n')				\
+			goto out_domain;				\
+		ds->_ver._name = _tmp;					\
+	} while (0)
+
+	if (version == 15) {
+#include <perf/schedstat-v15.h>
+	}
+#undef DOMAIN_FIELD
+
+	ds->cpu = cpu;
+	goto out;
+
+out_domain:
+	free(event);
+	event = NULL;
+out:
+	return event;
+}
+
+int perf_event__synthesize_schedstat(const struct perf_tool *tool,
+				     perf_event__handler_t process,
+				     struct perf_cpu_map *user_requested_cpus)
+{
+	char *line = NULL, path[PATH_MAX];
+	union perf_event *event = NULL;
+	size_t line_len = 0;
+	char bf[BUFSIZ];
+	__u64 timestamp;
+	__u64 cpu = -1;
+	__u16 version;
+	struct io io;
+	int ret = -1;
+	char ch;
+
+	snprintf(path, PATH_MAX, "%s/schedstat", procfs__mountpoint());
+	io.fd = open(path, O_RDONLY, 0);
+	if (io.fd < 0) {
+		pr_err("Failed to open %s. Possibly CONFIG_SCHEDSTAT is disabled.\n", path);
+		return -1;
+	}
+	io__init(&io, io.fd, bf, sizeof(bf));
+
+	if (io__getline(&io, &line, &line_len) < 0 || !line_len)
+		goto out;
+
+	if (!strcmp(line, "version 15\n")) {
+		version = 15;
+	} else {
+		pr_err("Unsupported %s version: %s", path, line + 8);
+		goto out_free_line;
+	}
+
+	if (io__getline(&io, &line, &line_len) < 0 || !line_len)
+		goto out_free_line;
+	timestamp = atol(line + 10);
+
+	/*
+	 * FIXME: Can be optimized a bit by not synthesizing domain samples
+	 * for filtered out cpus.
+	 */
+	for (ch = io__get_char(&io); !io.eof; ch = io__get_char(&io)) {
+		struct perf_cpu this_cpu;
+
+		if (ch == 'c') {
+			event = __synthesize_schedstat_cpu(&io, version,
+							   &cpu, timestamp);
+		} else if (ch == 'd') {
+			event = __synthesize_schedstat_domain(&io, version,
+							      cpu, timestamp);
+		}
+		if (!event)
+			goto out_free_line;
+
+		this_cpu.cpu = cpu;
+
+		if (user_requested_cpus && !perf_cpu_map__has(user_requested_cpus, this_cpu))
+			continue;
+
+		if (process(tool, event, NULL, NULL) < 0) {
+			free(event);
+			goto out_free_line;
+		}
+
+		free(event);
+	}
+
+	ret = 0;
+
+out_free_line:
+	free(line);
+out:
+	close(io.fd);
+	return ret;
+}
diff --git a/tools/perf/util/synthetic-events.h b/tools/perf/util/synthetic-events.h
index ee29615d68e5..b20ffe7d840d 100644
--- a/tools/perf/util/synthetic-events.h
+++ b/tools/perf/util/synthetic-events.h
@@ -143,4 +143,7 @@ int perf_event__synthesize_for_pipe(const struct perf_tool *tool,
 				    struct perf_data *data,
 				    perf_event__handler_t process);
 
+int perf_event__synthesize_schedstat(const struct perf_tool *tool,
+				     perf_event__handler_t process,
+				     struct perf_cpu_map *user_requested_cpu);
 #endif // __PERF_SYNTHETIC_EVENTS_H
diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
index e83c7ababc2a..d17e5d356b3c 100644
--- a/tools/perf/util/tool.c
+++ b/tools/perf/util/tool.c
@@ -245,7 +245,23 @@ static int perf_event__process_bpf_metadata_stub(struct perf_session *perf_sessi
 {
 	if (dump_trace)
 		perf_event__fprintf_bpf_metadata(event, stdout);
+	dump_printf(": unhandled!\n");
+	return 0;
+}
+static int process_schedstat_cpu_stub(struct perf_session *perf_session __maybe_unused,
+				      union perf_event *event)
+{
+	if (dump_trace)
+		perf_event__fprintf_schedstat_cpu(event, stdout);
+	dump_printf(": unhandled!\n");
+	return 0;
+}
 
+static int process_schedstat_domain_stub(struct perf_session *perf_session __maybe_unused,
+					 union perf_event *event)
+{
+	if (dump_trace)
+		perf_event__fprintf_schedstat_domain(event, stdout);
 	dump_printf(": unhandled!\n");
 	return 0;
 }
@@ -307,6 +323,8 @@ void perf_tool__init(struct perf_tool *tool, bool ordered_events)
 #endif
 	tool->finished_init = process_event_op2_stub;
 	tool->bpf_metadata = perf_event__process_bpf_metadata_stub;
+	tool->schedstat_cpu = process_schedstat_cpu_stub;
+	tool->schedstat_domain = process_schedstat_domain_stub;
 }
 
 bool perf_tool__compressed_is_stub(const struct perf_tool *tool)
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 18b76ff0f26a..d0ea049b5f6f 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -78,7 +78,9 @@ struct perf_tool {
 			stat_round,
 			feature,
 			finished_init,
-			bpf_metadata;
+			bpf_metadata,
+			schedstat_cpu,
+			schedstat_domain;
 	event_op4	compressed;
 	event_op3	auxtrace;
 	bool		ordered_events;
-- 
2.43.0


