Return-Path: <linux-kernel+bounces-761228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E351BB1F5E8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 20:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2AE7624FCF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 18:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF502C326D;
	Sat,  9 Aug 2025 18:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TSXNlWjJ"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62A52C3247
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 18:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754765327; cv=fail; b=SmCK9XFGfg/MF+XEBsk71HNgLfSSRLAJ7JZmljD/2S2MJT8zDwwK6VERy9zlfcDJXnwalRqbOfrPPpYNlXhZgfggjGwqU1IgHXFRBZemBmxoyAckFB8Jf/YDWyvgBztHWIVR1tzSerqgCTFuMQASYCgJeWj+oPvts0w1UzTWbYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754765327; c=relaxed/simple;
	bh=YmEuh+TL7VPsEBRHU8X2+IWCOsPhUnTRfPd1uiaW6nI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZuvqOZ5KEJR2Uxs77cUCF7QaTiIebD2EWwlBd0xdQpEc6OFjGmElnlf4Bhas9gzR/hfi0x6XMs2nUhhu5kUI90qpQFrDvgXtgd4r3LX98eaY487BF2KMANC4EN8J7AEIO6bGJtntWpus6S/SBqF0fDZ7jnWbuNFdSSNfGaS68B4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TSXNlWjJ; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwTXIhdkgbb57JAFuRwlvZfT9WH5z2V+cECP+IM8alw06xvpcJkLHg8quXBb7jMo1bf7+GHUrWRNaU5AxwA9x2FEWPVQDc3wBl5hDMNCTUk+ed31bJKxobLrEk7MZdV9/CpUrhGfhUphBs8MbO6KpKlmdMKRnwqo6qUiUJ6x8/8FAZwOrgDzEAoGFgCLeUlzdpogC/eEm8pCdZsfRnBSQQbuIzqoxaC2ENsXXqMqQuLk6oh1T9hTPpgGsSLsqara+tB/UwN4bGtlcN5snBPtxDWwZ8+6Iirjd05TxWucNHLEGIBk3/oe7YoKKPG6B1b2phcVNMjEhH0OdKyHcq+cNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsBc5J7XU91s1pFVMNob5FGV9VZz5CrG4SdmCgKUZO0=;
 b=CUvI6NH0uhGsGB3XRj+x30R4t7WhKujDhX3oEuuaS33ZI8SwxLjYp0N4l6ZMizyMtfCapGubAgtCh9GDgBuLNhGB/zwI7Uv2ztIcbh6zxE+AZN6p6zsB5+HZhNx9WrSdqetLaVbyUbn4pVv1janpO+t5nEKtRFRnogHTE6yDEcE7VuUMhaOC/ft+lQ3g0NeCkwvV960J8exRXQ2bjzt0RBkLax5//6TE+aEa8YYw3dnw33buqaYLIsYmKAo9ITjT555m/iG0TwielXyxIq/+BoAArkpaM1Y1vpXYrITt9CXo5OdpreQzf+AT7d8dmAtI1LaGQv5cXgcwOGqfbK79GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsBc5J7XU91s1pFVMNob5FGV9VZz5CrG4SdmCgKUZO0=;
 b=TSXNlWjJuiY0dM5MrRfqZtwE9Ch9Afa3vm9NQXUAO3Aq19kthlqpy2N42a8vp6ciS7Hfd6kM1N2YtxSQJaKkAgbLHAAza9Ty2AGIhCkwdYjVkXeunhUjFfbzE0VgAglZORTqdn8ZWyHjKEeG/fDCHcFgQuNQ34MYVFLWjuB9KqgolWHIwGXQUc7O7Bb5k8wYUaGBchXsyIkU3PjdMDgYkdqBjnA/CVQcLl16bNNfhatOjXTB9n9+avOJW9T5iyQZzdW1dtlc8nd0CCLJ4eKuetIFDhqrqX53gdwu1+90X6Uhi/yarFUUF7tiKpEFnVLu4XGowRMm1W3lZbED06Dr/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MW4PR12MB7310.namprd12.prod.outlook.com (2603:10b6:303:22c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Sat, 9 Aug
 2025 18:48:44 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.9009.017; Sat, 9 Aug 2025
 18:48:44 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Subject: [PATCH -rebased 11/15] sched/deadline: Allow to initialize DL server when needed
Date: Sat,  9 Aug 2025 14:47:56 -0400
Message-Id: <20250809184800.129831-12-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250809184800.129831-1-joelagnelf@nvidia.com>
References: <20250809184800.129831-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:208:236::28) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MW4PR12MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f2fad7b-09a1-4c3a-6279-08ddd7755da9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R+E7Yz4wNpPiBHB+IVswM0k6YRzgW4j1nxsB2wSRQ7yM32O3/raIhxHQnWtn?=
 =?us-ascii?Q?eHWam7JJv+qmKH2kzAq85HI7vrFeUEKrNQYBEIVj14vjQQB5KgpH3wAYerqv?=
 =?us-ascii?Q?J+67QTPg+kd+GALuHa9Y30/i4OIkpyZoCviOQo2xq9+vMX7l8fZiFgxrzLoi?=
 =?us-ascii?Q?DkfT2pzFe6lUeWJOiNTKOK3Thos0LCpRoMYvUjyIs3a4WcwKFBVLQ1VVTaoA?=
 =?us-ascii?Q?C1P7P7cXONYB6ikpB/81mAtyA6ZDDOCn8a2EUHWjxa124NuD0+xhP45MWg2e?=
 =?us-ascii?Q?ZUU0uqZy1AhmWQFhsP2P+NatYBx4rnqFxC1a+tE6YcVhrxIeNYAjj3qkptok?=
 =?us-ascii?Q?DDSeb+t8aEH2l9Jl/swWNlGy+Quv+TehlETBrhKPUySM0/1WkqC3HsR/zbId?=
 =?us-ascii?Q?cvvRtf9aawsC3A1fMCqzY1jKI3c/scSGNuVzNKsAbntpXAU2AwwD77sUFl8W?=
 =?us-ascii?Q?9l34w3fLrQHK6ZlmjgFSN1fFJ77tisk7gRECw5cpUF1NiPqdbQM99dwuGTl2?=
 =?us-ascii?Q?x9vkh/66fzbRe72CQUyD/E1XYIrgWuTmM8Hutw3mZxRbzn/MlqVhD2mUd2n2?=
 =?us-ascii?Q?pc0pb9Pu590AOMEPNAKnCXqgzw8hggStsQp4JQ6UQAGH26y8836DUJFot/bv?=
 =?us-ascii?Q?y8cjfW70jc6BkvsWa/uzitm31iSaUiyGenDfKhpxRBCk296+Ik4EqY3W+3AS?=
 =?us-ascii?Q?GVfOVargxQOo7fqb6f575gA4bQLN3uyr9pTz0Jujtnq+ODzIeX0jaSxT5VqD?=
 =?us-ascii?Q?Tu//MWY/UFTyBcgC/056x4kwGc1fLi6ygRp0dXl3e+zbqMA8bOVPUr6at3Cw?=
 =?us-ascii?Q?35YituNhZJa/p4PhxieL+TOiQQjapw+6gOqrPCexjbuc0xFZbyoWxhpum8kF?=
 =?us-ascii?Q?utsx1E+6DXjMsJOqrzEKcscWG74VVrJycLe1jZ9Pgyrb6WepP6RqSHCM1aGE?=
 =?us-ascii?Q?Dz9tZgW4h9t4c3Bwdayzb6VTt1EOR26LgX/qZQ7KqYLTPSrzBUvHB9EiyaAR?=
 =?us-ascii?Q?c0bgzjgCSbMOHkPtoX0YoqMTmiwOQDvi1PNWSX11QtPuJGm8fdQ1iknEsnW4?=
 =?us-ascii?Q?8yJtozKxPIrTuf6j0zOOjJKqkrjbE1aLd0XmJFkU4RPNp0TwdbxnwYvuNkih?=
 =?us-ascii?Q?yu+q5roVoa0dya14xHDIYbu82+YhA857pOGldxn09pcPU0L6RDSyDht6VoYb?=
 =?us-ascii?Q?GHynggzo9aDhfEXpNQnlP5OqYa49UMrXI9c1poM7gH5vkZg5D+RwZ9F9TRal?=
 =?us-ascii?Q?5o/6tNY72zm1HzEzcRvjFE9WgfE7X1wlqspittm2uk2/m0vguX8Miq6mbGX5?=
 =?us-ascii?Q?K0z3O+rxAd3L9sQusjDQizwbg3AENkeJFBKBwQ4L31q2caW00Rw0d+W0kmQe?=
 =?us-ascii?Q?5qBc0cuHjAtsJdACGK4y5vQba/JRl198FcTq+r31oTJRTgBOG1clt2TXgso4?=
 =?us-ascii?Q?cKSGXkH9kCNseAJ1Ukc3hkOyv6FKLyhRstvDmN6iFJSQ4xwH63fnfg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?moCL5MhIDzs6vf2XVb9xHcIGLMNLsTBo7MriZ374mPFporI7AEmyJC3vzL2+?=
 =?us-ascii?Q?4mpLEVVv6ZagyhDlrEd+FKbiJmBc/eltxnqyr3YJrmsswreZZVZsXyoovkPR?=
 =?us-ascii?Q?+nLWyNeyvG3ulv6Ob1wZaBbHHCnwDaBDXx+uNt6QNHd3x0YPhTXsgzGpMVKx?=
 =?us-ascii?Q?jftAn69GKMJTUXI8CqC5e7QelCjjDFlPlXwz9H6MlGBWGcPV1uMj2W7QyQgT?=
 =?us-ascii?Q?eHbvkJmwth3V6qpbXmcCpS240Tu4ND1m6WzV4j0MHPff6oyoF9l+kMVwr19L?=
 =?us-ascii?Q?P0SbuEef3Iwrgjnb+j0QHqDCTCMOkx8wBp9zzNsQjtiMZ6qPpUcz9ETsHOKs?=
 =?us-ascii?Q?P9dUdScruo+hjsvz76L6MrgpKyx3HizkAjpJ2Jq0k2XJ0hiiXCI/x97LO/hX?=
 =?us-ascii?Q?Hp2f53cgFiQ8rzr/YnS+z+t7B6OQvzWv0CBas+tIzR3T37YRlmTD1jjZANhC?=
 =?us-ascii?Q?fYCWbsBJjzlZgTadVD2jZ3l7fhpA9lJb/O88t8u1OlChpXYhU1pJiEEweRK9?=
 =?us-ascii?Q?Ec/fik0Whv0XaLqXBy2A4timjDVYjktm4f9PxKvptSw//y6qjkzmi7zd7zQi?=
 =?us-ascii?Q?eBHX+y3k4r4H1DnSDvJJFDldYIjcjp+/nkoB/MUD4eqwO2w/A/GL8sxePTRL?=
 =?us-ascii?Q?aFzpLu/OW/VdMMn9CMbLz96hs4OyefZyfto+hJgI7ilycBcGkUjYckMBlpRw?=
 =?us-ascii?Q?z6qPNsVwbqzxfvHDYmLibGYg6nhUasIPWRVimoHCG9y5+QAZOy4woT8Yomio?=
 =?us-ascii?Q?gYRnlLNo+4GGEb1Y7alo65CBxbTk0Y/1tDPB47uHiOuG6WfD1aDNLQKoGDHe?=
 =?us-ascii?Q?LZ9NL3AQAhZ3HQ0znW0OySBMRZb9unIo2wGZETlYfdMOG6+VVy+lCAzJuP8d?=
 =?us-ascii?Q?iYJrPbLOJYQPP3j3oqBm0nCXoiYNBbKCOaqlKcrdvp65nFjkFOFeXGsX2rKG?=
 =?us-ascii?Q?qqlpXtaQrx/MXy8SZyDRQR5oO4q/zgrhshg9dpunVxNHxJ+6OTCH88sn3uZl?=
 =?us-ascii?Q?6opa6A8fpCuhWooVWEokFhpS2OSoPEzcwTqB4+uHRP2GodEi6IMJyYH/Av9E?=
 =?us-ascii?Q?u1GXzS6qHvYAlUxUtg9mKdhoPOWcbuCluKkUgZdVKX4WzPkVryBzkLmmiqJo?=
 =?us-ascii?Q?CkMRwZsrRYs1M4XYv0JjqaGBmfkCnH7iqfluW4kts6UwOauDt/HKp1eBLMi6?=
 =?us-ascii?Q?UYEmM2cQfA6sFxMtQ9l3Evcba9m/QV5BsHaG6cEjiCqAgc6TpL8m3T6vz7uN?=
 =?us-ascii?Q?e2ngAUaTMo6wYbyH0+UaDFQrSOEvWKOBpzSbGmth0j7HpNvD69SDAdrBo63O?=
 =?us-ascii?Q?7KuHHBKTO9KJp/g5xo6f99Z5wK0I14tch5u+/fKywGarEpkFhuyW1zGp6JCW?=
 =?us-ascii?Q?HWadHd19kEWNk5tXKsa/1aUHsDsgiCP60opirZ70XK7CEuIHIp6kFZ+kT0tX?=
 =?us-ascii?Q?7HvMku0zbdfVtS246nYH3fc+YwMsa5Naz2C6CMX4/bO+llIKmQilA8OyWxwS?=
 =?us-ascii?Q?Jl26tkZkUfxjOsAF5TuDlb8f/tKH9HerDmagio9ve9tsXfFo8KTr6mSEfSrn?=
 =?us-ascii?Q?edFlz68HTSvo811L0x4l+zN8qfjOxaQbZBtsoQq5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2fad7b-09a1-4c3a-6279-08ddd7755da9
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 18:48:43.9746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ZKM58Wya+Z9bROiaKu2/uY2u7o41sJCW1csPbf19K6dzX6rONxtbSQ1kJJ6jU9Vc8sM5tCGXC42Y0y2awXAJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7310

From: Andrea Righi <arighi@nvidia.com>

When switching between fair and sched_ext, we need to initialize the
bandwidth contribution of the DL server independently for each class.

Add support for on-demand initialization to handle such transitions.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/deadline.c | 36 +++++++++++++++++++++++++++++-------
 kernel/sched/sched.h    |  1 +
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 92ca2f5b7cb9..7891a7bf43d6 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1583,6 +1583,32 @@ void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
 	}
 }
 
+/**
+ * dl_server_init_params - Initialize bandwidth reservation for a DL server
+ * @dl_se: The DL server entity to remove bandwidth for
+ *
+ * This function initializes the bandwidth reservation for a DL server
+ * entity, its bandwidth accounting and server state.
+ *
+ * Returns: 0 on success, negative error code on failure
+ */
+int dl_server_init_params(struct sched_dl_entity *dl_se)
+{
+	u64 runtime =  50 * NSEC_PER_MSEC;
+	u64 period = 1000 * NSEC_PER_MSEC;
+	int err;
+
+	err = dl_server_apply_params(dl_se, runtime, period, 1);
+	if (err)
+		return err;
+
+	dl_se->dl_server = 1;
+	dl_se->dl_defer = 1;
+	setup_new_dl_entity(dl_se);
+
+	return err;
+}
+
 void dl_server_start(struct sched_dl_entity *dl_se)
 {
 	struct rq *rq = dl_se->rq;
@@ -1638,8 +1664,7 @@ void sched_init_dl_servers(void)
 	struct sched_dl_entity *dl_se;
 
 	for_each_online_cpu(cpu) {
-		u64 runtime =  50 * NSEC_PER_MSEC;
-		u64 period = 1000 * NSEC_PER_MSEC;
+		int err;
 
 		rq = cpu_rq(cpu);
 
@@ -1649,11 +1674,8 @@ void sched_init_dl_servers(void)
 
 		WARN_ON(dl_server(dl_se));
 
-		dl_server_apply_params(dl_se, runtime, period, 1);
-
-		dl_se->dl_server = 1;
-		dl_se->dl_defer = 1;
-		setup_new_dl_entity(dl_se);
+		err = dl_server_init_params(dl_se);
+		WARN_ON_ONCE(err);
 	}
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 719f9424b417..fe587b3bb88a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -395,6 +395,7 @@ extern void ext_server_init(struct rq *rq);
 extern void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq);
 extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
 		    u64 runtime, u64 period, bool init);
+extern int dl_server_init_params(struct sched_dl_entity *dl_se);
 extern int dl_server_remove_params(struct sched_dl_entity *dl_se);
 
 static inline bool dl_server_active(struct sched_dl_entity *dl_se)
-- 
2.34.1


