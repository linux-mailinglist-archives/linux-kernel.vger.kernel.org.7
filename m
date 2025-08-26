Return-Path: <linux-kernel+bounces-785978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FCAB3531A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 960F51B26336
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 05:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7CC2E8DFE;
	Tue, 26 Aug 2025 05:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CNMKt8kv"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7372FF9C0;
	Tue, 26 Aug 2025 05:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756185301; cv=fail; b=FY0lgjR9lP+uCVNQoG1OAFp7cay+tglUVV2684+s6YgsABLNYRq01y9JJqVAcNUGUYFgnBS3cF0Q+Zn+uMdei+vMI4owUkJLlZxDU19jQDMO+AV1E2oGkdo1UA0abBnflZAHNA0Ew/CNgjJV5CT2I7jXvupHNUnKOiwBmw+ZlPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756185301; c=relaxed/simple;
	bh=EfcLY3NDp1lMvkV1Jfb+289V3teDCdYSigVXRWpSN7g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fgVj89SZOfoGZafSAgk/G8eIm69AWlD3FoNQZfZeaORq1ir3uqwY5fwQRqeAbUQLh3D9UtwyRtijLb68SYR/XtaUcbVLxukWltpVnNbQlj+a9XnDtcptgYmqsEYW87Hb7FGdZc2n/GaurpC7bREcncRw/nduakGsR//ep/L8RMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CNMKt8kv; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uPKlZoAcKCCXbuwoILzJMmwJy7aS9XoqFNd0Dt3V82FVj6XxM24lDTLJ+09la2SKahvwGhJCO+5L3KK5vMsyJ7J+BMsqMK4OHrXu7WHVCPwKy1SIeSXLTI66UkeDfyfNikhHtf03e6/XfimyCNRi5gjIjAZZ8XSbY9aKY0AViyenh8suKhdvsZX9jFxrhxNyrcFuf6jYoslGv6DriIcd6wRtrbo8WYYg6c7DK24zltDYVo8QkdwvkDc/HOKR/2YEeKXjUHY8XGWGwr6jehiTRZW+onNSZbSBpWF9dgAzSApIPAmjATKGhiJpzHdC02BfaJBRBPGlCITbp6+Dt2Z0Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSWJRxFUSRR/75Ge00v7x+d4eXsR1bungyJ55lp1BIU=;
 b=dUBwGSIWFr51YGzKcLI6IQVYx0jL5xpWKSIowo9SxT7gheFPXTPi0fzVJRf2VmKTfTQIw7bzbjsBpwiuyFMcPAR1b1zMoEPTY5JEbdgS26g1tN2ZBAlIsPNE7+k9ZEVdCoAvosCX5cFJE+MmxEgiwlRlt7GA1ceWG44md7Dr+dtz3+0hnR2TIe0OxLWFtOlGuRRgDM837bLa/3r+22H8o4GbYGg23tQfN5AqobYadu14eWlIpzAefyjOmH4wvMbBdUERt77Yqg9Xff8HshjZc4RhpIZoEqVCvO6qKONrELi7cc5P1e2dChvMyPvP7l9P59Rhz1Nr36iesvV+RF6qoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSWJRxFUSRR/75Ge00v7x+d4eXsR1bungyJ55lp1BIU=;
 b=CNMKt8kvo16nMm/tXR/hRUuXAGjC6zkt0cOfwbT27koGCeHe0dUnJCn4fqmkIxWjz2WU+aPL5Zvh1Uo8khu+izOWjDg4BuBuC03mU6D36NxtXFDYiHP4yLbKF+OT3VDh6tWdDez1qI6lANArLhY9lGESpmZ+Hz2w5oiY1/nhDeo=
Received: from MW4PR04CA0144.namprd04.prod.outlook.com (2603:10b6:303:84::29)
 by PH7PR12MB9221.namprd12.prod.outlook.com (2603:10b6:510:2e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 05:14:56 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:303:84:cafe::83) by MW4PR04CA0144.outlook.office365.com
 (2603:10b6:303:84::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Tue,
 26 Aug 2025 05:14:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 05:14:55 +0000
Received: from tapi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 00:14:49 -0500
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <corbet@lwn.net>
CC: <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <iamjoonsoo.kim@lge.com>,
	<qyousef@layalina.io>, <sshegde@linux.ibm.com>, <alexs@kernel.org>,
	<lukasz.luba@arm.com>, <cpru@amazon.com>, <gautham.shenoy@amd.com>,
	<kprateek.nayak@amd.com>, <ravi.bangoria@amd.com>, <swapnil.sapkal@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v4 10/11] perf sched stats: Add basic perf sched stats test
Date: Tue, 26 Aug 2025 05:10:38 +0000
Message-ID: <20250826051039.2626894-11-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|PH7PR12MB9221:EE_
X-MS-Office365-Filtering-Correlation-Id: d8409b85-0a1f-48d9-eb74-08dde45f7ed6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QxXIHX8iMOyK0605C5R9wz1mV5tA7CyLm2ePEKuxkRqHn9pAvQwOUIJ8leZP?=
 =?us-ascii?Q?N78rxf9KtsV3zTEVVYUOWWSvd5CeuvaTN4911ezZkiA4vHetIf5Mw4VuD1d8?=
 =?us-ascii?Q?sMq1oYAyYo82+NtZcVXD8fF2WYiZXFKY2tpVR4TzLkVKjaph7gIAxAOnSHlU?=
 =?us-ascii?Q?XRp8Qs0RgPqIVwFd+FmOOoWlTdiwZl3jrn+KiiNGkcWYYUmwrEtWhRFDLFvJ?=
 =?us-ascii?Q?DtSCVlUIKsQl+xiYfeD0qR5G1VR4YoJ8k9tjEx41Ltp8UFXwZbGhLxiwBE6d?=
 =?us-ascii?Q?EpvBerlRKT1jKLwyvTZNCoy3Dve4JE7KrYSQ/MhSXGi85CDc9+y2JbWfBCRM?=
 =?us-ascii?Q?hhOyNVVUPrHcwXv7+vfGdkQ3FaaYvLNUkaK0KwjH7G3nf1WH+jk5I40x0lQy?=
 =?us-ascii?Q?WeaS3yZwX1szhcAky4oLrAgSyWdrGDPdpwcSDVYzB+BywdvV8MtelwAEC9o0?=
 =?us-ascii?Q?bb7B577k/IwWtD90DdWlpFXqjTYrqpYAxxz1Y0R32x5P05wlJ4AHOtgmcDEh?=
 =?us-ascii?Q?MHjPwrtgAcoI22uXmsWAGW9Ad8TlY/qLC08Biu1jFHuNK4xgBGv8cFcsDtZH?=
 =?us-ascii?Q?gRnLIhDbkBznxhDa0p5Q6IxLTaECXTkRBwNLU812bEYI1HAAyBhMnQE/QM4G?=
 =?us-ascii?Q?iFdMIR4h5XVZ/F1R4yYIS77bz38BqsK1ehfCEolqZMZD6BYRQzenTo591HWZ?=
 =?us-ascii?Q?spWHtW8wEkXi57dL0F+fjxV6BXaRmjYvFFDP3+c/7iseUaAFC8lA8xrQq3OK?=
 =?us-ascii?Q?IsCU1YdQE7xfitGh3k96/Dxf1QSgm1hrq6QIssgke12KWod7ZoGU6oe6UcGB?=
 =?us-ascii?Q?6aXauBaVVMmcjxp9tz5xpaNKDg94d5r0R/4ReNNUBfmLiszUSN648G2/gpUN?=
 =?us-ascii?Q?YvHkwen4Gs1WhnwzunA9DE1XQXR5G+zDfDkzbShhBUoKb9Ro0P5janw1MiYn?=
 =?us-ascii?Q?r012eGYX7wyhU45z+uZdXHUpfTIO5vSdyT6EnH6WxFJuNjiSnvZmVi1vYA7C?=
 =?us-ascii?Q?qI3xjRYEFJ6Vb1X7MG9q/F9liXkgNpxY/LEcF8EFeCI/xldFGBZlOzTRxCQf?=
 =?us-ascii?Q?He+4wRdmKJg4FmLREHfDSCqhpbeWudJy0AZqU5Ztqi8CwZ9eV+4q3UgzeD4s?=
 =?us-ascii?Q?MBWE7bNlDHuZgitl49Zfno2GzwS9UlV6V0kp78jCp/R9ZGVlSINvMxrcc6vB?=
 =?us-ascii?Q?zhxJfzK1he6o6y/6yhwBqR2RHRf+DydjrRXnUZnxFlwEa0nHVHYqQCGiaqyt?=
 =?us-ascii?Q?IkTdKzt9TncvWRVlG6Qc3Y7zSAJKngLN4lg6lDAhX41YbbZjL6HHssJUHFD8?=
 =?us-ascii?Q?dUVCqIhuvreluSYpIPMV+bvwW+qrRbbEagXsEVx5hnOUSK5a8QvtwVFQyFJs?=
 =?us-ascii?Q?19IA0az2/fcAsHwBp8q9xadQPqKgcxYimdRTNudRsNsMHUHI7VrwDD9x/7HR?=
 =?us-ascii?Q?ApMxDOql4dJd5Y9v+jDeoF5Ir7yAQyfjkX8k8uy/v+Par2UCTkkmPHibYL9O?=
 =?us-ascii?Q?pRkVOacz9cIg2cC+jroXkr3yqj0rtge1LqIz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 05:14:55.6247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8409b85-0a1f-48d9-eb74-08dde45f7ed6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9221

Add basic test for perf sched stats {record|report|diff} subcommand.

Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/perf/tests/shell/perf_sched_stats.sh | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100755 tools/perf/tests/shell/perf_sched_stats.sh

diff --git a/tools/perf/tests/shell/perf_sched_stats.sh b/tools/perf/tests/shell/perf_sched_stats.sh
new file mode 100755
index 000000000000..2b1410b050d0
--- /dev/null
+++ b/tools/perf/tests/shell/perf_sched_stats.sh
@@ -0,0 +1,64 @@
+#!/bin/sh
+# perf sched stats tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+err=0
+test_perf_sched_stats_record() {
+  echo "Basic perf sched stats record test"
+  if ! perf sched stats record true 2>&1 | \
+    grep -E -q "[ perf sched stats: Wrote samples to perf.data ]"
+  then
+    echo "Basic perf sched stats record test [Failed]"
+    err=1
+    return
+  fi
+  echo "Basic perf sched stats record test [Success]"
+}
+
+test_perf_sched_stats_report() {
+  echo "Basic perf sched stats report test"
+  perf sched stats record true > /dev/null
+  if ! perf sched stats report 2>&1 | grep -E -q "Description"
+  then
+    echo "Basic perf sched stats report test [Failed]"
+    err=1
+    rm perf.data
+    return
+  fi
+  rm perf.data
+  echo "Basic perf sched stats report test [Success]"
+}
+
+test_perf_sched_stats_live() {
+  echo "Basic perf sched stats live mode test"
+  if ! perf sched stats true 2>&1 | grep -E -q "Description"
+  then
+    echo "Basic perf sched stats live mode test [Failed]"
+    err=1
+    return
+  fi
+  echo "Basic perf sched stats live mode test [Success]"
+}
+
+test_perf_sched_stats_diff() {
+  echo "Basic perf sched stats diff test"
+  perf sched stats record true > /dev/null
+  perf sched stats record true > /dev/null
+  if ! perf sched stats diff > /dev/null
+  then
+    echo "Basic perf sched stats diff test [Failed]"
+    err=1
+    rm perf.data.old perf.data
+    return
+  fi
+  rm perf.data.old perf.data
+  echo "Basic perf sched stats diff test [Success]"
+}
+
+test_perf_sched_stats_record
+test_perf_sched_stats_report
+test_perf_sched_stats_live
+test_perf_sched_stats_diff
+exit $err
-- 
2.43.0


