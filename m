Return-Path: <linux-kernel+bounces-761219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C62B1F5DF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 20:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CDFF189B03F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 18:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DDA2BFC7B;
	Sat,  9 Aug 2025 18:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nR+tDcOu"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0202BD033
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 18:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754765305; cv=fail; b=Vx44BjCUHCmEwzkXEK3IAeK6qGqXJnE2vOfmxrLfjZMjcKJfKAX3UCX50q76ECO7v6fsi30Q3Y9bJUBCMN9BYuIU5JA3G392LZ6z5txAKR82RiIGptZppUpRn7HpORZwRZvjumlYatHGf/FxFnYCZYiFDVn8GguB6FqnkoMOvWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754765305; c=relaxed/simple;
	bh=cFjGbieWWmmyxYsLTVnBGzA5Gl0M5RRK1zXSVYGJg/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QZ3CzE7Xo/M54ft8EvFSBrkiAY+0B2iLvvPaB+tiNbt2c/mJtjZNOeVFkCr7Adg9cIB8SEGddzYamt8InUSG2LhWDTh12Hulp4Matkatu+SKZMULFscRbDwEE3wh9hpC/bF2vN9waXLz1XP9EwTN81uuBMrc4ulyaaJAHzBZ+Fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nR+tDcOu; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFikGr94ovlGrgmrbTmlj7O9TD0/GhYP5vH8j9OmZopIrmz8mQbpr0uZqp7D455oabLOUQ+9I8671w1P431h3QEk8vk3QZzB7isXH8atYFCzP9lj7conFf0zB4SM5TKFHQt3KOT9Bx7lGp79NINSsLqQUNxAbIi/8jVYgHtvT4XGCaun1pWoj2+c5tiaup3X/CHoq+AjRh6z8eDtxSGit+q2VgxIUewsGoQZF54TPP45HqTQ1csdQxtq8+gpB3rpoKxizcFEki/+F5tXyER5bHZMAKUvEejerORBzr7g7bGGg1fLm3E4aQ/DFQTJOg8USlTazzhgvJ9InUatjyynnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qNO7+uO4ojpahb2yoxzWkqr6iDF/1aKx0A+EcTEHfvg=;
 b=L3/e49IOdELl02fE3nPOkAY2ETu0BaCovgdGE81ZDJZbW4DlMf5Wm2zbQp5t/bBrCPXzbdHCbkEApTo7LgeNEAVq7GEyREM5x/5aj+c/CsppSUFQ0owxQblJ6jIpMYheR0BAcDPvYKv44hajmoSjEKvc9bH6uZ8953a3T7uY1+NFapAwjjuNq2AAcf8Zvm0mWn2m/c3iX9qmTJWeAQQm4tX9NcHpOfZxfvnngLgIoMDUq2G7ZTE5UcN54e+xi62B/OBU+obAPfykdqKu6iPERdnZdNSuBYpHFN6kwG1FaowOSEAbEBNdvXoIxQxNerrCPEgytj75f2yRsKzkDHFtkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNO7+uO4ojpahb2yoxzWkqr6iDF/1aKx0A+EcTEHfvg=;
 b=nR+tDcOuzIh49hNSBWmqHIG67A+THoYaqE5RyFTEOv2IO47clET7DcDiDaWaCm2BPnyRcz0hABkseag/EpAqLL3QF872oYy4UC1+QtxeviX1DBAbR/juF+8SvPkx6Jt0dx0Wgh48NJ3rfuT8weLORkZ1qd/A9hUBf/t7UGeVp7D6CTLuH1PjWpZSvQ6IcXLp/jADrhhAeOVNYnZkYPi8vEAWLe0JBhe6lidmhob2lHfc6ZI2f0bO4kVsg2+YrKDSEEqXv+6bkGQwSHgZresY5IrHOtFzh44OI4JWa86HzFdJVhv1OGBU15y8eKT/y+NPRNbDHoG+MxH5tzxznky0zQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MW4PR12MB7310.namprd12.prod.outlook.com (2603:10b6:303:22c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Sat, 9 Aug
 2025 18:48:21 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.9009.017; Sat, 9 Aug 2025
 18:48:20 +0000
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
Subject: [PATCH -rebased 02/15] sched/debug: Stop and start server based on if it was active
Date: Sat,  9 Aug 2025 14:47:47 -0400
Message-Id: <20250809184800.129831-3-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250809184800.129831-1-joelagnelf@nvidia.com>
References: <20250809184800.129831-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0304.namprd03.prod.outlook.com
 (2603:10b6:408:112::9) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MW4PR12MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: 06129fec-57af-48cb-ec80-08ddd7754feb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xIA6oCMvrWXsds71GKIfs4GKe65ftznCy8K7I8C8YIcOkmrR4oI/zpPEvicD?=
 =?us-ascii?Q?Vn5d7eUZf15hh4IJSHFqiagPI6aa3YggCgK+x1utW6AOfMQq2MtPcBSmUpXC?=
 =?us-ascii?Q?ipEfHZXrckZUSH+rOu+FgUFytQ1bPaWVHWg4RZF/ys1Dd1BxDYPqtb7OtLy/?=
 =?us-ascii?Q?Ye8z6JpCKMPcpY6aYdbh50HLO3im/Quet4MA9wd6ILmRy2OQ7lhvdLaZX2zt?=
 =?us-ascii?Q?Y71xqfDpID+/+6jBC4IYVdB0dAlO4HprxHV19JWxNdi/3/INAr1CUrU4yy74?=
 =?us-ascii?Q?Sz9yrwvZ69sRheiQpEAtpCAY3cFsXLMaVrLxVIm6al5gNHSntSvEW/ylGKyv?=
 =?us-ascii?Q?u+fTlFlu81PPylTnve4WGDVXBL4t7QI7BNXudK1XdFifHiEB4WgUq7YEAFsW?=
 =?us-ascii?Q?3IK/xGCFquYLH3Mueov/6WEyYxoR8kyfVHlmhUdxu2TXDWhnT7GbsYgiSAVZ?=
 =?us-ascii?Q?EBAEevmmRscFgLBcSHDUT1igZOjbe4d5cvYD+5/WS/75OCFCk+O3dtz0dAMN?=
 =?us-ascii?Q?HqJ9SQeSGwzhuJNhEq61yqTuTlEz2rJHEflY4aF95n2TIONP6u2kdd9h61nN?=
 =?us-ascii?Q?EfHgsjBcsF8GEoDxaiLuiQ68sXO/iHbUwj/e1Vp3wrzFupx8jBCepN25dqL9?=
 =?us-ascii?Q?njIUNmd0sxPLaL3sMn4Ji2OLZFrEuUL9mV3AAwfHH2v+A+rim6NjYkQEQEEO?=
 =?us-ascii?Q?HqUi/qqexeJBr/ST4v5S8KxrNEZzBHkqtMjheWIi62BL5MFYzcdr6k5T+as5?=
 =?us-ascii?Q?HaBc9V05nrSR5JObXoYZ603gpdY1M59f30Oj+VGPup7hL0SSa3E8rExS2e2l?=
 =?us-ascii?Q?HRMZi09lqNEMj5cvJ/XoPatXS3o0V22EQWVZL/lQ4rWG1wApmdrinejBTFOe?=
 =?us-ascii?Q?bmn9d6MGavgy49UVYUOz11oBx6vY2XY/hOn+rWAyg5Dk5ZBZSspvFSu/7FMs?=
 =?us-ascii?Q?Jk56rbRYfj7sQ6AJacEk1eSpZpqQVDZ6o7T8m72YMoqn/JpvmSwAlCELGFu6?=
 =?us-ascii?Q?Qlz2esdwsB0R2UbkNWVuJYf0a2TrGPiGWEK8yWk2jkhzRQ5VhyDbwiisjojM?=
 =?us-ascii?Q?5VROtZh1uIIrGBenTMDn/By09iY7Ki+qEI/DKFiwT7xBiBlReDesCDctk2Ic?=
 =?us-ascii?Q?JwmMOUQAZeR0zvNgKd27VmlHriQC72oAZtTV0k218liQbUmolzS4hogZlcDH?=
 =?us-ascii?Q?aTsilEwsGTXZpxblnvUfbA8QXx3PJS+lAn+Wg809uTpEYSXtnvf5bWv3JbY4?=
 =?us-ascii?Q?toyod92iY1QC4BvK7qkWHSQrDhOjZil4mG9ymrfRDIW3yJ2dRNNrmrlEAk7A?=
 =?us-ascii?Q?dm7gVkxanwJJQMQYZydnowmILzR//LOyDFRmuTwYqaqkZ/7e1kgM/oqiOnZ8?=
 =?us-ascii?Q?KonQaSQKvR6j4lcicdLZMOP/cxaDrMx/V5Ek0ScBUiXc3NIVomEVmYtAiyfD?=
 =?us-ascii?Q?LaQDFOb0d6sbS8OTBPHIrcnGY+IhCoCeiaMEnC1FTSVNTaPWpGMmTw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VjO3oa/cf0RUiSWTvnq1bKAPXBlHYLR3DuXfd0Sq/CqltV83pF6iKZEYtbkS?=
 =?us-ascii?Q?aPCjTMAOOQ/5o9UB7ptspdKzrx/hq2wB2iWLzYKsTR3qcl//mwqaii2hOkrt?=
 =?us-ascii?Q?EsKDPVHcP1o8jx5wwnDBJqW6aMn2pQCpc3SD7g5hzeDoE1R0QTJDW/2tUqWA?=
 =?us-ascii?Q?CDVeqxqUElmlGdhn0Ff6nPLDhsSmbVUNZm/DxmuvcoOXp08CUlTUeZ9nwLN3?=
 =?us-ascii?Q?9Tt66bKB7S09VWByxPqm7mnbVAzFmfL5fYGgYmivrK/TTHLlTRP6/YCAjc8e?=
 =?us-ascii?Q?Z4d/6/VKSUk+oxiCxv3TJ9WXqa/xjoQZjIbEqTDnyaaB7T9Nwm81T+Sp2Gjz?=
 =?us-ascii?Q?f6NkWqiqloJi2uo8UQ5mPD6ErH74t7UDqMUS97f15bGQ+l6oR0clh9y/EqAe?=
 =?us-ascii?Q?CAel4pVWQJCZc3T/YGeaDUMSIol6LXV0T+3RAbNNH84FZ+PRIPLGgvBrc5pg?=
 =?us-ascii?Q?80U7c/aEN4pBBrrIbWO8ZOv8MCKojlJFgjxbVbbo9W3DlrYnFXKyhIM+xt4d?=
 =?us-ascii?Q?1L34BFzTe76sEWPamhjgTeU6OOGTllHU6Zwiz9ztOHphwAzqUcjBJyktHsXa?=
 =?us-ascii?Q?aJxn9Bb0Rtv4lFZGAoHbmYkmmPz1pWy8wl9QjlGyfTqO8N8r69zKM8YVKRja?=
 =?us-ascii?Q?LVzlUptcqtZc6y9yPg367EzQM/XWjoV/fZSSvMgxwbv05EDEkl+BLF1kFd8K?=
 =?us-ascii?Q?pDjUgELut4+FXCqxe4acfVvAX/gjpTIrZY876bH6esGMBAcMSyi66FY/PXVU?=
 =?us-ascii?Q?ijon8sWKxJvgt8pN4Ilz8/1EFKOc/QZ4d7i9YDOSqVMp297GFHANmYcGypzh?=
 =?us-ascii?Q?Zji5nHlVQhGaduW6UGsxCb9W8IISEluZLzm8/JKq5QZqHY+BNcEgQ6JFO4x2?=
 =?us-ascii?Q?KS5lSBW9mgHaNPNFUN9eCy39MFlWyxNpa6k0c9CBK67uiZeLhBq95vjxLa97?=
 =?us-ascii?Q?Io7sNTSfVGPJQJwHUFkQemPaVxVJtXMhXb6ZvH1kbbL3brP51GINOQMQ81FJ?=
 =?us-ascii?Q?uzlEiHQGCR3xa9W9fJdd2mkJc/4H++sl0d8m9HqyCKxp+lmgVIQP8wSe3zz9?=
 =?us-ascii?Q?/fhbWvroRkngHrI2TSLrUijf6Yewl2k8VmNbZl0kObp/BEX1R2vl0OVk3yKO?=
 =?us-ascii?Q?eo7LmNb+jbVhPXZMlHTlwwjYyPHJDvx1gE8Z70Inka+J0TR+C0Nzd1mO++iC?=
 =?us-ascii?Q?AiiDGJCdxAbboyPzhPbpfqM9PfpG/qGo5+QccA5zqI0pWVl4rozgNY+IbAD0?=
 =?us-ascii?Q?JYGsV9z/5KcrKRQTNYLE+jGRu4eTi4SNy1a1qBD3pSQ8hITyXVykphR7Ofig?=
 =?us-ascii?Q?L0lxBoOKBmzM/9byltgaY2sAa0GrlrjIESTspx3X7VBJDLVcaW7xnRKS4vn8?=
 =?us-ascii?Q?pgMSEHzEulZ0lNu4SPsNcQAREmDzybOCcR7aEQ9fHm5aDWlabMIS+etSf3jG?=
 =?us-ascii?Q?DGKddvVCqKntY+hyINZAuAiVW0OMp6eAPt9BtdE65+2gJGh3v+K+3Pti5P24?=
 =?us-ascii?Q?ZQlsU1L6iyQefFZ0z0+aUb6V46lP1bRi439i4Uf5EmpUZLoCczJipaAPDbHD?=
 =?us-ascii?Q?c7jIh6kdo7au65snX5TMOMRHkeRJOWaYEmtqQTad?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06129fec-57af-48cb-ec80-08ddd7754feb
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 18:48:20.9168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xu07vM9fzkB34DNSz9WVt2hFhdk9QqONemflfvOvTrwbyhtHhPb+Z1oRL9UkPwQMxyruXDT0QivdO5UUm+XStw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7310

Currently the DL server interface for applying parameters checks
CFS-internals to identify if the server is active. This is error-prone
and makes it difficult when adding new servers in the future.

Fix it, by using dl_server_active() which is also used by the DL server
code to determine if the DL server was started.

Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/debug.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index dbe2aee8628c..e71f6618c1a6 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -354,6 +354,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 		return err;
 
 	scoped_guard (rq_lock_irqsave, rq) {
+		bool is_active;
+
 		runtime  = rq->fair_server.dl_runtime;
 		period = rq->fair_server.dl_period;
 
@@ -376,7 +378,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 			return  -EINVAL;
 		}
 
-		if (rq->cfs.h_nr_queued) {
+		is_active = dl_server_active(&rq->fair_server);
+		if (is_active) {
 			update_rq_clock(rq);
 			dl_server_stop(&rq->fair_server);
 		}
@@ -387,7 +390,7 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
 					cpu_of(rq));
 
-		if (rq->cfs.h_nr_queued)
+		if (is_active)
 			dl_server_start(&rq->fair_server);
 
 		if (retval < 0)
-- 
2.34.1


