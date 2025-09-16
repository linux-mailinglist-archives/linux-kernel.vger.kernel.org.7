Return-Path: <linux-kernel+bounces-817977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8100EB58AE7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 03:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 274DD3AD148
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 01:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF971E00B4;
	Tue, 16 Sep 2025 01:11:57 +0000 (UTC)
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2093.outbound.protection.outlook.com [40.107.121.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5611DE89A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 01:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757985117; cv=fail; b=SGQeKmZF5QrGgydVx+Jm8+fC7zm0R6BVlYt1zhmRqXiJxuOG97wpeKg89FH1sTGRLptN0qa5mjoJLdTBgmKGZJw627aiMPT6yC2ny/ooNmkRB8fSHyLsGJW+VL/r+jFPGXr++KuPBJo5uHu9dz5btDki/sHB07x4ZDNphkjFFYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757985117; c=relaxed/simple;
	bh=1O3d+q+T8VMV9Hnh6/6pYW+lm99j3aotjZlT1B1B2SI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ihdi7RIubZvsI15wJNQIvay0DAflD6yNZen2BcasJlSw5+5+K/Z/AjQxUkPtMqqBSwePeyMFJvKg9etG2pcdUyQFkXyFzJ8KdtdC0wMRHGPSVJqCROZMwEKXCn81cb3R0MdEQtban98jlwc3CUpb9X9Ohr2jtA0hArdnOY0ywbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=40.107.121.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JuaScLs36tCo94gKO3so3PR9BHWASaD0hiXcOojGAW+40ibYYgJl9JYxMtbFKgH+hXwOBOpx8kPW9CmZKx07dqZsCHvEi60aaLywsh319owH1qcjQTAWFT0eN68VM0sCSTogIhaZbpWMWe04BeplPAdppvjdLl7YIOns/bX5wAQYyiluCQhwGg9nksHxgIqSlJio00QbqqRQUdGB46oiVoOIlI/HTQaamMglPYoAKduqEvLnpWY6oqcPWzzkm4JpXXsRSSP7/Ipbb2fP79Y6JjqW6JFF8tjxf6jOkS1uYsOEpUWrswKQ9UbWgrIfQ84jIiX1oM1++T2z97X/UBDUHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiPutnH1OYl9tap8TR4gBe0i/BZrbdFW+5w+vp+bByM=;
 b=LtlhONKziW0SSwXUECURHFLwc72s5UuT6ftHWvV08Al6uRw1g4Rf/tchAbNF//g4PqT0Nh5z3+PxE260BlrOFu3jRDsAHQgknd/KFAJWgUWt12yfFvxAtBnB6fTvvoCZevhs1g+7H1GFf3PV1UmzP+0Lf5RAvjKNiOHG/yyr/5ixb8P8gubj1f1Lg3v2g1QrNTbRVw5xoPbg5g71+PImchdwgXIAe/V39rDXf3qh5Xg/Ph+bpHIMr9uOzf9Slt1IkNxXT+MQx6Ha6S/Cp1E8Mvy0ox9ujH36iBBB0Nl62FoQeYrWcuLkXkP1Va+hH6iuykAAJ/qPZJ7/xmFUF/G/1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO6P123MB6721.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2d9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 01:11:52 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 01:11:50 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	shashank.mahadasyam@sony.com,
	longman@redhat.com,
	mkoutny@suse.com,
	tj@kernel.org,
	atomlin@atomlin.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched/core: Report failed rt migrations to non-root cgroup without rt bandwidth under RT_GROUP_SCHED
Date: Mon, 15 Sep 2025 21:11:46 -0400
Message-ID: <20250916011146.4129696-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:208:329::24) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO6P123MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: a4ecbca8-eb18-462e-7d7b-08ddf4be03dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eUr3JLgq9j1h9+3Nue+v0qhlVsbqKn9L5tjHXPeeLpGz8LcU86Q+X3coL+2J?=
 =?us-ascii?Q?BdYy+eewLxFEAzdJDXuvwAYiYs1TLfVDaev0PRY89wRFgNgL1n8eCEh89P8S?=
 =?us-ascii?Q?uF78yjIZF9pkHZgeZfDiUDcoJSCMHyo4dCXjJXBsXW/SZlSGuVGxRc9JyEeu?=
 =?us-ascii?Q?Ka5lncj0xALyZBq9VjqFsHkSC+Z3Z/ZPLsSgEmpMluU1gNJ4ttlVo6/xDPOS?=
 =?us-ascii?Q?zTu8sbQTNJ5N8Cz4p4sB2apLNhrNQc+6bTwehh5tt1+h/C1MaFJx4qytIaZ/?=
 =?us-ascii?Q?PcoWIRPeGYtdLrR1YkefBQ2zsAwyk2XpjBPxJCeDzPko8ctChX1j3i7GDoIo?=
 =?us-ascii?Q?kC3NHKiTl8PFq85kmaBlMo5+tzniysSD0Cyw2bdhDUkRuMAHW3f+pOuJHsUM?=
 =?us-ascii?Q?Xli5P7VsvLEF/6qcFIKm4ZjkWTTn7lbMPMR+ja9xrc9o0ei7ZIot1uLOU4os?=
 =?us-ascii?Q?bRM1qXeK+zsHVbzHdoZVbv1+Zz85L2P8KN8Z+Je9u0lHsFn15v9awe4JDQIu?=
 =?us-ascii?Q?NoaaOoOE5FWthNQ2rweFAOYq0YLm3zIhp10JKdE+a5vEdwNGn/3oJ1Xtbe7E?=
 =?us-ascii?Q?rUin/lsxN9HKvm9/cIeXFpq1DAuGjlPMjg2mpKiDrNp2ntvhqLkbaD9RPoew?=
 =?us-ascii?Q?iXNRoIQMQ42E8dXRU0Xk8WCg0iyP06w3qFQoyeLIAc9eYROHwMCgws3ZLg5x?=
 =?us-ascii?Q?LYoc0wTFvETnw1eoOWOBD95S2LUZZQw2jzA3uKz407yCHjWSPc0ICqftEmbW?=
 =?us-ascii?Q?mjlxWsk6ADlX+L/LvIO99jdWGhCzSLhfRoLgtJZngep1TaxUCBC3RHD5MdDg?=
 =?us-ascii?Q?s1a2Dq+E1qOKrqAgCMpCh41q6FXxaQXK4WcDy3vKnld3pz6CmevnfkpLKE/Y?=
 =?us-ascii?Q?3K8BH07u2N+WhC1l7gh992IBTi5vFQqDZ70IfBdss/xZh7ot/ZVM/YUrsHBh?=
 =?us-ascii?Q?jKQ2mVlRJMdAYNsMEdsAAVqY+Aul29zkaFIqtS4V4Df0+cYDnZwLnFQL7h+J?=
 =?us-ascii?Q?UkUIMx1fVGfXExW9pMFnfO1ix1wml5uz/UYnG+waH4YGEQvIY10+wgb5PaW4?=
 =?us-ascii?Q?QM9CClGfck22f0U3VL8+jllDnn7R9y02T+pZVXuju7zqZAC1v5qyYtNzwizS?=
 =?us-ascii?Q?tP1oH1JT3ig3kNTKGeuDOWfhC9Rbqw2eSh8v0Nh9AJH6q950PxzjMiCxD8Fw?=
 =?us-ascii?Q?c7exYtFW2y9MIpJ17fay/vSyYcEhPA74jqqWJB5AVzaVT8WLSKFggOAMkOAr?=
 =?us-ascii?Q?vwzgu/0oC+hSVnk/Uwhe+YaXYt573l1fGuJRjkukT3J099NYRYZPRpRDAzfI?=
 =?us-ascii?Q?FwSBaGzLDEq6WlBodXhyD+7GIZYla7GCk7DFv7k4xxseSOGK8vxIwcLNnMg/?=
 =?us-ascii?Q?Yq8fefHEE3mUfAjDTA0zc3+QuqHqsEYqOZ9YFEPXdlUBRKZUCb7hxzDd2zl7?=
 =?us-ascii?Q?AFg3+AouR+Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aPdh0RYkmouZlvCeBZc04m2e5dEPlMghYXsp+JNuEVNC8t2NLDep3LuYGwTc?=
 =?us-ascii?Q?BHSBCX21oWNRI04zoA9Ki6A/eOHcYfSJ3AVk3TDPmlCfK4uNQnO+M1mHuRXK?=
 =?us-ascii?Q?PrJmiHgsz5NE8fCGKXVkvZ2/UUbSCUF2aw1KoYN/+h/v+1VfIYUL1rZ6ThIt?=
 =?us-ascii?Q?eTwGd0gZWsL1Amba32xYC+EBX8L949DK5Dqdo82A92H6GGBJ674JrS6+7qRT?=
 =?us-ascii?Q?EWHBwwmhLZeFttgDv7OcXCNHiuRqonlkPu67h2x2qVWGtqVeFLd69yJIj8rM?=
 =?us-ascii?Q?niaWExHl+RGNtgs9gXLBIjK9qVosYeVH7MKrV+W1IiqRQiu2t72i/ShEA6QH?=
 =?us-ascii?Q?O0+vwxI27U48gTYb2yXwoFgJfZz6D54l+MGTCGFuO7jCrinU+Cj8BDe4MzNe?=
 =?us-ascii?Q?K1a4xDXmNLCtEz60/otySxeHrBO61e5ReAPLaQlNnPW6w3DcwgGQQ24V/kLg?=
 =?us-ascii?Q?BKK2Zct0vHEVRQIAIW7YHKpVcu3vEc4Om4/5ysMKhKHTjjCJIWe8fBhB4qbt?=
 =?us-ascii?Q?9LaZD6qjUQ97xWTrJTlYywD5x0Ljl9Zq9IhaN53NeCDPBI96uDpMOw09W8cT?=
 =?us-ascii?Q?ctBS7aJhO/ErMSbCDw/DkRv1SGAIuDmwhzWJy9t4tcmD3fyT7YB40tdjNgCo?=
 =?us-ascii?Q?0Sh7dP/JHxnGzBfmHef/GIeOVwVr/IH4cMSErQZKfOAMX2MfXJUadfPXzq2+?=
 =?us-ascii?Q?JyDDWnC5gN05HkyYcPreS2/va64P2Cd0va0gEnCZaCaQVTHBcFZ0iIJoZM9c?=
 =?us-ascii?Q?CKwMA0tzjOQgT4rwbu0Q6Wjh68Nzfh+FyzmWs5YgXhgtZ+wtOGttGddwyGi/?=
 =?us-ascii?Q?0oIKir2MQ5gPFzccJFOneSYRSQ49y+WXgcE0tpsG7gc2DQkROfvckuyuYAsS?=
 =?us-ascii?Q?CRSKeGjXf9OyW/HO26kVIv3keovd6PxMfgHQ95OIUaAGadZnsNo7nXPG/ify?=
 =?us-ascii?Q?Lp5Kuocm7frx3+9zW2rySZdVYNlZC9XkDLeVvxNeOGKug2JBNvEHhLpYC3pu?=
 =?us-ascii?Q?3bOK3OJ4udiJjaIzyujoc/dlCR31925BjmRBnia/WUQqQutRBq15Zk2FSlFE?=
 =?us-ascii?Q?Jr2IwJ79HZfqyLRuE8e8hOugNog4z+Z5+6pMN12F7PP9Et7Fr574MbWm+sEC?=
 =?us-ascii?Q?8NU5ejz1pm6Y2zeGpaSjBrYl7RtXIR/N6eeaOUEV7nhLenymGMx+vIzYDOgE?=
 =?us-ascii?Q?xOW3JpuIyKz4vStQlMJcoArKBMu/3Px58JwdDp6j7Sb3Cv0QVQWJkamIC2bx?=
 =?us-ascii?Q?xcnNt6uYpXPNv01l0xvGCPReE+aIqIoXMRfrz08zbNY4ZHxMr4mpHEBSJHDk?=
 =?us-ascii?Q?9v0e/vlvY4Ae33XiSoSkEUJsvLWepfv33IqQsAjskY5jq8jqZQPSuAetXLS1?=
 =?us-ascii?Q?gb+L3Cgqtp56s15dO1QqPng+yqeyrWHlt3ZVB4Tagj4yjNB8rT308JX3UNZr?=
 =?us-ascii?Q?ip0j1T9c444ILtm3ANU6APrel8YBQVlSYs3JTHnVvTmvCXPYqCSMSnGsVnjT?=
 =?us-ascii?Q?/bZx0szBGdeVnxPb5KCfdNRM8oSiq4pkeH/tb4FIUjgJBLXZQIpvYIHVlXXl?=
 =?us-ascii?Q?IbLUUT+nYmXiy25mlEleoFm5oIpB9K0c+Mj8My44?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ecbca8-eb18-462e-7d7b-08ddf4be03dc
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 01:11:50.5264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tpvSWJxg5wRuNIm8Tk9P8iI6AxxbsmP7WVRcYxoufU7p9Zgh3oNwYs27FC6U5FIaESRAd/mwYSPv13Xe8pgKpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P123MB6721

Following on from commit c7461cca91 ("cgroup, docs: Be explicit about
independence of RT_GROUP_SCHED and non-cpu controllers"), this patch
introduces an explicit error message that informs the user why the
task migration failed. Now user-mode has a clear and actionable reason
for the failure, greatly assisting with debugging.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 kernel/sched/core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 62b3416f5e43..b9d7689d21e4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9185,8 +9185,18 @@ static int cpu_cgroup_can_attach(struct cgroup_taskset *tset)
 		goto scx_check;
 
 	cgroup_taskset_for_each(task, css, tset) {
-		if (!sched_rt_can_attach(css_tg(css), task))
+		struct task_group *tg = css_tg(css);
+
+		if (!sched_rt_can_attach(tg, task)) {
+			if (tg != &root_task_group) {
+				pr_err_ratelimited("cgroup: cannot attach "
+						"cpu controller. Task "
+						"%s:%d is not in the root "
+						"cgroup.", task->comm,
+						task_pid_nr(task));
+			}
 			return -EINVAL;
+		}
 	}
 scx_check:
 #endif /* CONFIG_RT_GROUP_SCHED */
-- 
2.49.0


