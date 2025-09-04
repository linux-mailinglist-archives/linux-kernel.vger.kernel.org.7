Return-Path: <linux-kernel+bounces-799873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C241B43111
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C92FF16BAAF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826041F1313;
	Thu,  4 Sep 2025 04:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E/A2TRjW"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D971B5EB5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756959688; cv=fail; b=jHbT9PLS7zMzhg2XtYEZaJHVg8wDDpJKAvEbpLSbPM8zJvldZ+f6N5Y9DLekPse+C2rlS8RK/hOd0LMdcV+Mfed2bTsXSROyVnBrmb0w1PkxYfWYR/awPE/KxtvsBUFktfuTB0oFJwmNdYzY1rAeV2SWdj7MxVtjaNL4pGHXNYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756959688; c=relaxed/simple;
	bh=Bewtx85+0zjdl6Egzr/A2j83dx2EPEC6rSvrfNgC+4k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tObUloobTReh0DHtYQd9ofyMUq35hxAClvUxl2aNtUFojdHY8aPJ7YuljiGMA9gtoNlhMQfEy21xL/4viMXS48KZqz9Ce0t+D1inIVaOQBeSbidwzylHKPgWZo+Bak0Xzc4GcCF/bbwG0wPpPzdeM38hsgG1eSeesth+E1RRobk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E/A2TRjW; arc=fail smtp.client-ip=40.107.237.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1uRHUHEGwHag0eGh6O1kUewFcScY1VZwV2WjFCvGJKr0GOUxmPp07N+sAq4j2nicOt4jL/lBaSBCeZuMqgSQJ2D0toYyHm4XJlcSDO0cHQLZEwJheHgzd9+pT4t9k+WI+pAcCuyeHifKePb2ctRVm28HBcS8LBOOk0UyEzO5J+59djB1SZUAU/2X9igP0z0nZ/DC6FaGBH/QFj5AuxjdxvPJxc6Psl35qsddbyZ1q6nSXiuLfdn7sx2uuYSogzQ7qEQNjTJvOwva6iXCYMMpGWvkxq3N5im77xqw7OwecKjJms9ydjI0yeD5WY8hs2HBbFKYaWfb3GUK0T/CnXb9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zt/hmsChhZytJbqIcMuGUymGW7RVj96CW6rPAK1mA4w=;
 b=NAkTIyrtOjLnByltu5S64oix7g7EeXmM13gA8QnfBbKP5xX5y2MXceSsOgkmJi3hxHwnKAbuqxqP6/i/EJU7HSz4p30/QxNxlBphUF6DdTckW7WeIVV5QGDU4P4Zoa2NwgcxQM8QjD9JaOy1uOGqcDegBTFAGl/YIWpGeobnYh6oimBuhRR4Y+dgcc/QOfsdJXXNEIS5Dlj/ztDp+DvzeEI74UA5Jxg84w7YmPIi2tzCg5NzRqOI/OVGyxn3F+CO16QdD3yx9YclwYRnAn8u/KfMIAhgMyRvZ/QrjnKm5rtIyidAEScvMdoOBXWV6GmbDLqAcSDGMcUiOnNol+875Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zt/hmsChhZytJbqIcMuGUymGW7RVj96CW6rPAK1mA4w=;
 b=E/A2TRjWLHgv4xj1wh4uclivkULD18D45eO/XbnBFsTG55ppFzpdZxRByxvVu973c8Cp/pLfXrvEcPiuOWSFOzmaIX55+lB27f0WW4J9HziDk9EAM0Uw7vwl4PSkpeH0DhhnzqbFTSHTg7kfVs0m8t9OhVvF9adjOlCcId4z5vI=
Received: from SJ0PR13CA0051.namprd13.prod.outlook.com (2603:10b6:a03:2c2::26)
 by MW6PR12MB8952.namprd12.prod.outlook.com (2603:10b6:303:246::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Thu, 4 Sep
 2025 04:21:22 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::aa) by SJ0PR13CA0051.outlook.office365.com
 (2603:10b6:a03:2c2::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Thu,
 4 Sep 2025 04:21:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 04:21:21 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 23:21:21 -0500
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 3 Sep
 2025 21:21:16 -0700
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: [RFC PATCH 19/19] sched/topology: Add basic debug information for "nohz_shared_list"
Date: Thu, 4 Sep 2025 04:15:15 +0000
Message-ID: <20250904041516.3046-20-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250904041516.3046-1-kprateek.nayak@amd.com>
References: <20250904041516.3046-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|MW6PR12MB8952:EE_
X-MS-Office365-Filtering-Correlation-Id: 4219fe04-eb74-40ac-0e69-08ddeb6a80d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?deQX2YvzHrGm/jswrAGEl9pTAkTBEQow87XnL/4W9/2pL85ld620GsQHyC4g?=
 =?us-ascii?Q?t4BRvRjtY9LrNjnHk6cCQWOvzPRzYZrW3QWGHt8pkC4xqBisMMJ3cdQ4szyt?=
 =?us-ascii?Q?iozTF5QZoSAyTnBlo+zYDaNrF2OOGkcz/9X9xtZzfpWKcH6royHd2aL/FekZ?=
 =?us-ascii?Q?Ow8wzlhedSyXZW2X+vxoRPeektDzfF6pWsnZe6rB4f3SpUIl9Bn0cFLcyg84?=
 =?us-ascii?Q?petaNu6iI0DzuzDyYgT+u3GTXAeW22rpmXUc9bKMkDtKC+uxZIknX9TX+cU9?=
 =?us-ascii?Q?XMHOV/BDiS0L+NX7csEI7PhmWAmsZGPiW4W140YP+/h5zkMoxlgaJlozwvMU?=
 =?us-ascii?Q?Bjxh/j76UOai6fjclXLgo1VoZmd64cFRPRQJBvJjCXJ22gtaSfp+ZQhR2G4R?=
 =?us-ascii?Q?DcIN3JWJL0bYyFQn5P8e3etsmVeRuE0l/FvOg+yHr/e29Hc5AdIqTftuBvmk?=
 =?us-ascii?Q?3LwMSdzCgvdJwHMCeRFK9YOPlh6x41vmzCNtWJad01iS5vHckftZrDKiyVBt?=
 =?us-ascii?Q?Fe4hCOJLwSqriw6gD/nSosO/wJzl91CrYWIBuOK1KqigHIfHaq33X+8X3Put?=
 =?us-ascii?Q?Vlf08ZVrDK95ZTSi2N9V4B60E1biU9xRwMKMDVtXPW2tkz3QLoQPvqg71O+D?=
 =?us-ascii?Q?pGQ622hQ299nNqadjHT2fF07RgP90D41Gk1y8Livu8xOIoMbNkDIuZSuN1hl?=
 =?us-ascii?Q?7Epjo6Yewun/hhPeHL4Y/wqYuaHvHm7/dVMlg8JmSZs7nzD3bUnprtxXn7/q?=
 =?us-ascii?Q?i+QUWdzkEq5s/+dHbnXw62cWHP2zmYuJGOAmpZEIKVWlN29DvTG5lIYNPJb7?=
 =?us-ascii?Q?g+9O4Ekt5Z5CchotFbv5QozBzulSZ+jk7Puafhqq95UfpVyYt497bi30LmP1?=
 =?us-ascii?Q?ElECoZUeoasNgsZpD/SHkS8Rht4lc7Yu5LyK/y5Uze06KhibsWIoAMsQ0L+V?=
 =?us-ascii?Q?6g49X/ygEB8d80bVbJiKdI552m0CDXGE4PL6+Ww8wRFi0tOCyc6TqSSSe5Hn?=
 =?us-ascii?Q?LOv2/zTMfw/2YqvfYhQFUxukqU5RI7Yo2ln4ZNdTS+Oh/ra67qe3IMIDVVqs?=
 =?us-ascii?Q?MXZIKjQ1RR34goqfl58XWoamqDbByXMBvRXiXFdQMNyPnLnY+fuC8m4+f43v?=
 =?us-ascii?Q?eGc+2NcN/oLrLa1/SdTu0fPPe6XU+fQwwVZK2BT0CpHRX6JDkCbnR8q+9kUX?=
 =?us-ascii?Q?Es21Z/qJYp3XZOeVAsU46ObWDQTt1/eV0tNnGl5JQVzVfGsp6qLyl/kY/ld2?=
 =?us-ascii?Q?q6uh8NNsueNZZEQx7t+Ci1XzILbFlObrdfIe511TFFOzR7kw28MoXNdKigql?=
 =?us-ascii?Q?pdEg7B01n6o8Q4j5m04ZRXp0Wa5XtwUGRefXo4jj/EkgCphHPhTH5NnCmYnJ?=
 =?us-ascii?Q?O1uemCmhpBCLTX2vqJO8hqYo+Jqx4uVqieOrZBA5r2ZjBB3TVkkXpe+WTlsr?=
 =?us-ascii?Q?QB4cUIiCuyWtVR336TRLXgvtr6TQNOgTDq0wSsYJhzAnpaB6KAyn3ih2C/Nv?=
 =?us-ascii?Q?2Lx9W1eis78TQcZa1jZICd3PhJ6fJ7Vkwpn4?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 04:21:21.6499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4219fe04-eb74-40ac-0e69-08ddeb6a80d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8952

Introduce debug_nohz_shared_list_update() to count the number of entries
in "nohz_shared_list" after each list modification.

XXX: There isn't a great way to jump from a sched_domain_shared object
to the sched_domain struct that references it which prevents printing
more information about the sched domain that was linked with the
shared object.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Note: Something in this patch upsets the LOCKDEP + sched_verbose cmdline
combo and hangs my system soon into boot. LOCKDEP alone or sched_verbose
cmdline alone doesn't have this effect and until Patch 18 even the
offending combo runs fine.

DEBUG_LIST didn't point to anything and I'm still scrathing my head on
why this may be the case (maybe I need some glasses).
---
 kernel/sched/topology.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index ee9eed8470ba..85b46ba594a3 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -471,6 +471,20 @@ DEFINE_PER_CPU(struct sched_domain __rcu *, sd_nohz);
 static DEFINE_RAW_SPINLOCK(nohz_shared_list_lock);
 LIST_HEAD(nohz_shared_list);
 
+static void debug_nohz_shared_list_update(void)
+{
+	struct sched_domain_shared *sds;
+	int count = 0;
+
+	if (!sched_debug())
+		return;
+
+	list_for_each_entry(sds, &nohz_shared_list, nohz_list_node)
+		count++;
+
+	pr_info("%s: %d nohz_shared_list entries found.\n", __func__, count);
+}
+
 static int __sds_nohz_idle_alloc_init(struct sched_domain_shared *sds, int node)
 {
 	sds->nohz_list_node = (struct list_head)LIST_HEAD_INIT(sds->nohz_list_node);
@@ -588,6 +602,7 @@ static void update_nohz_domain(int cpu)
 
 		guard(raw_spinlock)(&nohz_shared_list_lock);
 		list_add_rcu(&sds->nohz_list_node, &nohz_shared_list);
+		debug_nohz_shared_list_update();
 	}
 
 	WARN_ON_ONCE(sd && !sds);
@@ -612,8 +627,10 @@ static int sds_delayed_free(struct sched_domain_shared *sds)
 	if (list_empty(&sds->nohz_list_node))
 		return 0;
 
-	scoped_guard(raw_spinlock_irqsave, &nohz_shared_list_lock)
+	scoped_guard(raw_spinlock_irqsave, &nohz_shared_list_lock) {
 		list_del_rcu(&sds->nohz_list_node);
+		debug_nohz_shared_list_update();
+	}
 
 	__nohz_exit_idle_tracking(sds);
 	call_rcu(&sds->rcu, destroy_sched_domain_shared_rcu);
-- 
2.34.1


