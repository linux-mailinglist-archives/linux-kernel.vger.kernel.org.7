Return-Path: <linux-kernel+bounces-785968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5CBB35304
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BF311B25110
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 05:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A08B2E7BDD;
	Tue, 26 Aug 2025 05:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="giscdg+I"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32901215077;
	Tue, 26 Aug 2025 05:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756185109; cv=fail; b=p0r/FjUYG5z30AY0OxqVVT9O92bkT5QrFMmgfdZERGRCPg5p1oRghhH8AIvYeP8z9plR+k+JAnfEs2l2bThSNz/q1b2EF7hj3vLhHWItyYAwuUeqrZnLSfA7Djd9NCmzE28nYlil25gd08iqd3fw/rB82bBbXDhD4MTAiTBsBz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756185109; c=relaxed/simple;
	bh=NtkI70RtTfF5+4aXa4bFk0/lUXAX+lAbo3kZqBgK6uc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cBaafFUw/VZAKpCOjpSV5QqlqHykm+HWBExk6c761IDhcFzYqswfrHNkWfOIuDYNpO7ltb4dmb82K0d0ObhhXIq0D+MtYs+wij1H4Ck9VxF5u1tSKlpD1MPllx0dWF4LarvdpKIZnOJPtVurMhGxaOa8vx5GG/P1knMEQbkHuaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=giscdg+I; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktvNeVPiEKae7m1kvIG6ps+hmbOQY8nxsWITCAXaZDdif18uRLiyeg67c4l4qwiDnm9tZSFE6HVqtEDDFRdoagoiO5nFqwSz3G0LeqpKfw+UjneZQA/fYgwFwXS+q8TN+3CnRgy0D1YU/AZpaq7KVFMWf69c7QuOqEgpttvNrjq7b/dygP+I1vr8XK4/omBXNgbNO020CZswCiDRYswM6LVjd5TVhpIGs7au3y88STUQRjtiMcN0fn42LS5KfX1WSK3biFonB6Rzzo3c7Qfv99ZZMKIj8u5ltkuAcitqt/IMS/Vs7pmPek62ka/6PZXqEMn6YBRhDN6/yGWiCUHsQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNxD/4yr6Vsad4zlpYjJNNqpz9+8mTY9oOt5lDVHg5U=;
 b=q/MXepINgjHittp+fMFJ6zRXGtieVSgu5pBm8Nuz1HuT7AcJybLIbiSb1K09IdNIZBC6n2+lfZDTjlj5S1nu1rRAPHikVY+M1gI9VhkZZN3OUe11OakdfY656N45K6Chnulc+2j7a0TlE4CsqXcvLdFe8rvl4MjDdywokdZOE2+n0Gzkw9vnE7O+K6oaYv34EZP3D03/PO0D37L7x7UPnRaBNkHsnbZnY+4qiKbV+A4oDyOUXXT2a7vr5uXeEVuS9XvnHi07re+pyERnayXsM2s+Ci5C7SF8nmiImI6lm3fd4tdb+bSe1p4Mtjzdw6AoxQR77nzsV3AE3uSH/j5dXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNxD/4yr6Vsad4zlpYjJNNqpz9+8mTY9oOt5lDVHg5U=;
 b=giscdg+IlnqqbZ4xtnv7o/yhJl65oxaoCZLJImgEypioWdVrOeGCmB2RoE/XarmIeJXQ6r0GWbDgIKNZWnsHst2RALGxKj1CJEIQmn81lEXqyjruJdkpUFuotbz0sN4Dl+3OFJj0YsnCu3sTyHnR5w4sULvrDV2eXWfmjG1E1nY=
Received: from SJ0PR05CA0087.namprd05.prod.outlook.com (2603:10b6:a03:332::32)
 by CY5PR12MB6347.namprd12.prod.outlook.com (2603:10b6:930:20::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Tue, 26 Aug
 2025 05:11:42 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::78) by SJ0PR05CA0087.outlook.office365.com
 (2603:10b6:a03:332::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.10 via Frontend Transport; Tue,
 26 Aug 2025 05:11:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 05:11:41 +0000
Received: from tapi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 00:11:34 -0500
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <corbet@lwn.net>
CC: <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <iamjoonsoo.kim@lge.com>,
	<qyousef@layalina.io>, <sshegde@linux.ibm.com>, <alexs@kernel.org>,
	<lukasz.luba@arm.com>, <cpru@amazon.com>, <gautham.shenoy@amd.com>,
	<kprateek.nayak@amd.com>, <ravi.bangoria@amd.com>, <swapnil.sapkal@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v4 01/11] perf: Add print_separator to util
Date: Tue, 26 Aug 2025 05:10:29 +0000
Message-ID: <20250826051039.2626894-2-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|CY5PR12MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: 18ebef93-c6d3-4e71-0bfb-08dde45f0aea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tvJquPeTqwaAxi0xa7d7gjD7BJmWnAa030NDCpOK37/2SUiqpGxqYN24e5Rz?=
 =?us-ascii?Q?O8a88ae70+2pXxEpG2FUifdYmYfy4W7CNPrsuYYGDsUfBZ4B3mmaSO19ggv5?=
 =?us-ascii?Q?ZGZyWPwIKrhFQHOS2uGnO8Dz5A7gyVijvvYipQSQ+JHhOWQB+PqecK3rtLcA?=
 =?us-ascii?Q?0hLRoly2+oY3E5p8PbY+vuW4o8wURGGVvTiwosovdzXaEwWfbP/8KkBn4DrE?=
 =?us-ascii?Q?gv+mCDsAEklQE9NjHHUwOyq23HUKSW4eJVknT4IEIZvyjqMO7vpvQzEtrtwI?=
 =?us-ascii?Q?20M8tdwod2VGl8dWtgh+XH25tqBxJa6Y+RDjp/qIjb7/ZnCyACdGzmhmZzIy?=
 =?us-ascii?Q?ezWT6bk+cJAsG9MQofUzmkKyFto/xMyYlaJZpljrhoI6lbx4s/d/BO91M03F?=
 =?us-ascii?Q?g1BENQc15lDad7W+jx5wCRdOOI6a7DOJGp5Ik41MtQlxOnVC6Ef7jtJv8uBZ?=
 =?us-ascii?Q?s+83lxGKZgQsGeX14Dig5EYP6wjXaB8yBae9gOQiAtaKUl1BoXbLzS8vIzBW?=
 =?us-ascii?Q?zr5Or6QjOOL4W4F6lNqYSzxsZkVNhhWtodJHd6q+iY8EleQrC2YoD0eqgcIb?=
 =?us-ascii?Q?mR+Cql7jQvyKGs1fCYsMKDNKx09tlzowDSkdNDbZGYnhzTwsyeQ/MLazyafw?=
 =?us-ascii?Q?1+SjuBX+3dA0zhqZjlaHBHGbm4r1INtrbed+E6MaUSqhu0e//UBEd6iB90xa?=
 =?us-ascii?Q?k/QeBouwvVcqsUkMfYhawsglpq1HItnvNHNeShmcQ0BB129haO86c6wwnEFw?=
 =?us-ascii?Q?aAUjuGyA9YCI256WvpH9Nc3yQkvb6vbeNn0uHZMwWQGkkcS/yeJvg5TgnPLF?=
 =?us-ascii?Q?g3eFKqJ6dkgm+PWAzhNeHkmVJYoUTUL53o/nf88zIzvVFfkdSSHjBig9OlsA?=
 =?us-ascii?Q?FklUrLIHsZExygfIZPGRrPEDU29dKobz8wH6qDRmHMn6pAMiHb5USCiOMw3X?=
 =?us-ascii?Q?szdzgeq+E5V1fxd1zYGwBsY5k4ntfY9PcA2iZkMFadObusyi1p+xAvhFtPV/?=
 =?us-ascii?Q?NioUp+buQBWtw1I3PBtY9gyGcB+BArrRM0FP9f2xCbpc/X0XGZAZrLntLWJC?=
 =?us-ascii?Q?maBycFXH26V9UxbQ4BGPosJ2IxnDHQVkQ99iBk+Hm/cDEobg5aiecuT28tST?=
 =?us-ascii?Q?tkZUhVn5XrqG7256vTxG9OGoAfsVP5XvItc0QVxrpNav70dnMEBFdB5OkS+8?=
 =?us-ascii?Q?Dy3gB/FPRViGqgwAL82S6uGdBtExMTB+6DiiVPWmp4M3PcPKeYZZ9wD946Lj?=
 =?us-ascii?Q?MNOkSCkLnr1ofrxl09dUppQTkAirvZPEOVjyKxRc2kSOh6WjKKjTI0hhFld3?=
 =?us-ascii?Q?VzSyOU56e+we9VOLJrpjTNZzeQYBhOqiaC+NkfdKDdMDUxeR0jSkrH/T9pzU?=
 =?us-ascii?Q?Uf+RZae1sOOrSfzPY9rGB4o83PWoKgBEMaEbQLT0GW5rjERPKYuOBWUBTP1r?=
 =?us-ascii?Q?Z9vF3sBpYzC88fRvnwqCCkKhzrjCuIM1ZwHazuZPkYy/PaoqWNYpxaia/wnW?=
 =?us-ascii?Q?aBPJ8/7k4jVGH4DAINjcYBX5ip3S2zBTeNWA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 05:11:41.1268
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ebef93-c6d3-4e71-0bfb-08dde45f0aea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6347

Add print_separator to util.c and use it wherever necessary.

Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/perf/builtin-kwork.c | 13 ++++---------
 tools/perf/util/util.c     |  6 ++++++
 tools/perf/util/util.h     |  2 ++
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index d2e08de5976d..842f59ff85ac 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -1340,11 +1340,6 @@ static struct kwork_class *kwork_class_supported_list[KWORK_CLASS_MAX] = {
 	[KWORK_CLASS_SCHED]     = &kwork_sched,
 };
 
-static void print_separator(int len)
-{
-	printf(" %.*s\n", len, graph_dotted_line);
-}
-
 static int report_print_work(struct perf_kwork *kwork, struct kwork_work *work)
 {
 	int ret = 0;
@@ -1458,7 +1453,7 @@ static int report_print_header(struct perf_kwork *kwork)
 	}
 
 	printf("\n");
-	print_separator(ret);
+	print_separator(ret, "", 0);
 	return ret;
 }
 
@@ -1633,7 +1628,7 @@ static void top_print_header(struct perf_kwork *kwork __maybe_unused)
 		     PRINT_RUNTIME_HEADER_WIDTH + RPINT_DECIMAL_WIDTH, "RUNTIME",
 		     PRINT_TASK_NAME_WIDTH, "COMMAND");
 	printf("\n ");
-	print_separator(ret);
+	print_separator(ret, "", 0);
 }
 
 static int top_print_work(struct perf_kwork *kwork __maybe_unused, struct kwork_work *work)
@@ -1933,11 +1928,11 @@ static int perf_kwork__report(struct perf_kwork *kwork)
 		}
 		next = rb_next(next);
 	}
-	print_separator(ret);
+	print_separator(ret, "", 0);
 
 	if (kwork->summary) {
 		print_summary(kwork);
-		print_separator(ret);
+		print_separator(ret, "", 0);
 	}
 
 	print_bad_events(kwork);
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 0f031eb80b4c..1b91834e11de 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -257,6 +257,12 @@ static int rm_rf_kcore_dir(const char *path)
 	return 0;
 }
 
+void print_separator(int pre_dash_cnt, const char *s, int post_dash_cnt)
+{
+	printf("%.*s%s%.*s\n", pre_dash_cnt, graph_dotted_line, s, post_dash_cnt,
+	       graph_dotted_line);
+}
+
 int rm_rf_perf_data(const char *path)
 {
 	const char *pat[] = {
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 3423778e39a5..de69384380c2 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -48,6 +48,8 @@ bool sysctl__nmi_watchdog_enabled(void);
 
 int perf_tip(char **strp, const char *dirpath);
 
+void print_separator(int pre_dash_cnt, const char *s, int post_dash_cnt);
+
 #ifndef HAVE_SCHED_GETCPU_SUPPORT
 int sched_getcpu(void);
 #endif
-- 
2.43.0


