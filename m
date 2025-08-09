Return-Path: <linux-kernel+bounces-761223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F170B1F5E3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 20:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02EF3BF5A3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 18:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF7F2BEC37;
	Sat,  9 Aug 2025 18:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ohPfdRtG"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFE22C158F
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 18:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754765315; cv=fail; b=pCgk/33cOE7DPQL+p4UtAuly1Gls3KCwE3w7uqA/ce5m/Vl5m/AeV37rKtfMY1LxGrVeT9wzg+WHAvBTg/OMc183TJ6/Pr+ZUmNcOiHrqY4b3TumjeN3Qi8FJmGIwVQSEOjzuEAPq0qHKcFsz4H0+A9vQt+vpnHtDVliI5UP90I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754765315; c=relaxed/simple;
	bh=+NNb6ayIkHAahjMSAauDQ80p1O8ZyMQsU0Cn/7VSyrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=csJBviPz7J2oqggi/PMYBBJVVE1xEwC4NAZ8uuR9AXRTzGXiggrDU64roW+czOLOtTDtagL/FNUxNt+esScf/twqCH8aUf1v7DkownMAFsDjyalLelUZfeTSMEVhMzxywA428ICICqXaELalHldqRAYDrSzw1i4jBOO0Hn3dZvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ohPfdRtG; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MozphUFJA6i9dI8x39vOojWRAsFQcqgOAsgjUZKU9dQJdyVe9syU8xGH4ayJietTqIdav8utMkf2ltlfADNZocj5Adjau1FCmOdnO8BcotNL0LoiuVk9NzoSPo+13MN9q+jYg2tM/eUtWNbiI2QN0jVqAsqaiH/AWPX37mFuf+uaTBmkk15yfPkWZ59+xBfu9CcFxCG/TJzYChlyAstv9ZCxzkQ7v+RoT8SUl9rfysjkf2+kQqJWBA+xI5wJTEUMDKZ0P7tLkyi7Ho+xx53/vwtoV3NtgL7YdvC+IwmzkRXTEl3XCP/1ZUphGWTqDZo8ryVtrs2UEccJbu5v5Bbbqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vzbwz9EilSCqRcRkFluDC/wvh56LIO244ci3VBnqwTU=;
 b=tarLPiSqBi7FP7e+9H5SV7k4BUZtoZQ9ujSqWyEHMulYxXq7BCfRMYSjtAvp8kFAYFK4oobCUy7gxH2Ci2akEJYsRWo2xX45NHCbxKa2r0ojDYhd1Lba/42TTR7RYZrpnmwNsmeL14UBbaAZmCeDu8b5K6rByYLvB47HR6wCr7+s9HLSfu+LmKN/AbxoIgpcISq5Qo08x3V4eAp6AbZb0xt0C+OZPgVPzaLOvkKyDeBO9DxCSKR+IItv4ajJclTe6Ut7HrL8c/LD/UvMB67YypwHzwWXm1Z3V4A2OnBl4cL1tUylXHu6Xyg5Q9mKPCdl/toA2m5gvvDWZ1b57KWS7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vzbwz9EilSCqRcRkFluDC/wvh56LIO244ci3VBnqwTU=;
 b=ohPfdRtGk1sHuyJy4ucanlhVy/P6qwNDwS/lSb8ii/dKSj3gFRX2eajAYNwTmHUjiDEEiUBew64NDZd0Afo0T/XwrEIllYCXn6GsDZpgfXOQfysqnJuRtTcqJ6zl6JKfmtdb76FBJURki/x5DBCt5VneUAlCGC2nWuV6rr9QuY3fHX6OmMfbk3qLlgm1s9olYK3GaQEbfspV8SA7kjS/l+QtvFdeQ3yeBNzf6zsEQ0z+AKZB9EJLk57s767pvdZgdWnJNCJTYSheMLSxkhUFis6MGlH39EVDTQEMXKTYA6WD4Mb1m4KBtRN1mgvfTMfazCYfn3WEFHDJmIZ2IcMe0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MW4PR12MB7310.namprd12.prod.outlook.com (2603:10b6:303:22c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Sat, 9 Aug
 2025 18:48:31 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.9009.017; Sat, 9 Aug 2025
 18:48:31 +0000
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
Subject: [PATCH -rebased 06/15] sched: Add a server arg to dl_server_update_idle_time()
Date: Sat,  9 Aug 2025 14:47:51 -0400
Message-Id: <20250809184800.129831-7-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250809184800.129831-1-joelagnelf@nvidia.com>
References: <20250809184800.129831-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0438.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::23) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MW4PR12MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: 327c214c-ea2a-48bf-6ab7-08ddd7755661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7bYZWClnrvMLCHKDfiaE8mmq7as2vT9Ej+Sz7DUqWS6BkfJdJZkSNUFyHfbj?=
 =?us-ascii?Q?yHZY028Y2sDYqZw6wY6UOWN7b1hBa+CQAF1OI2+LrNsiPVV34oQYtYTQFDeb?=
 =?us-ascii?Q?TfmjFDK+rqsalMQdFdo/kbJYfWchEueMXP463f7k37dRogjv/xGSqoAPb0/8?=
 =?us-ascii?Q?vfawoU1gD5e5IEt1uSSTPxzt+B8SXFvCUsdU2TzdWMhNhH6EZFg9Buzg3bFQ?=
 =?us-ascii?Q?xn1ahS+n9zg2aiZYPgdcN/xC9J2kPwj0Vx4fTgfXxG212wyLOhl6zrBDANkq?=
 =?us-ascii?Q?KSKoUhUv4DvooE2waIWwoRgazBTT9PA14GpY9PiKsnYVYPz9NyyncPDwlukv?=
 =?us-ascii?Q?sB8QBp2Ho2wOmQPlPRws7XqEjQlrac25iI3sNnQ+nvewpyHvfp2WBVyXV5Tb?=
 =?us-ascii?Q?11/Zfv6rdL4KxcNhYIJuTAkde8CuZ/apQxRte0ms4XHtnY8iR4MdymbrPcjI?=
 =?us-ascii?Q?TfsMbwRbJ98GsE60K3Dw3wpE3kjFcYfYkLeyvDd4UGOfvL4WhGqc2amPHDZg?=
 =?us-ascii?Q?fm0mZeTxTxaPIfillCzv3k00weyxn5k8xe+w2GP3n7aZEExohbFY2cqKtED3?=
 =?us-ascii?Q?k1qZXr4V+TiJBjYFwDVzg7A5xrMet536IYc4Qhr3u3EmwgXx5CvR1V4AQzDN?=
 =?us-ascii?Q?251gvWNRSjEHeY7wCzn2JsnNtdPdTl2IKHlWUgvcPzxPt5QEvBFDT1qR5mdT?=
 =?us-ascii?Q?2M+XPK7b93KHrlPjLq8PGwn835NFcB/CsmCJ7kNOyYzIay0tO4oevqlfrnQT?=
 =?us-ascii?Q?uS/NfgnKPvrr/XTKn58PexGdLYkVnm8SrdKPW/OTcNoZ/JaW8P+5dVJ+MVzU?=
 =?us-ascii?Q?IOPUA/4QiCC1n/5gTT4/p2wXHVjmARdEUUiKNi1/tbnC2hO1lGYzVfK+TMxm?=
 =?us-ascii?Q?QP+L3CCls4m6KUpECkvRF/fO4ZQ83QlLKFv0/pbX2FV8vu4wVdObHgy5D34x?=
 =?us-ascii?Q?UUPOkUTiUGlYPF5MLPY2wLMDKPus9OzCLxD/OweRcv+qgRCgXLsK3XAplqKh?=
 =?us-ascii?Q?0V+0bUcfA2XIDKU+m1m1rq0NGJRpCOlooXYU3yzD8ONXgHK2Tv0Md7rJVzms?=
 =?us-ascii?Q?mEco12nX3mG4kBkf8FqK8MxDktI4omDoF0pq1w19pG7qpbtF2K2ivLhu7cdj?=
 =?us-ascii?Q?dYX/mJ5tCsbrs9Vi/PsdNBq6MtwCaCBxBIdSlqGXdt9DJCujsSBAfY2tvLFC?=
 =?us-ascii?Q?dzYxhZTkopihUYP3hWxCQW36CWstFW7cQVr6oxRHAQMdLUaLrRvIUH0HwSJm?=
 =?us-ascii?Q?6+SGUnI14x7MU37mQhKD2K1nayxyFa+zeWqyqsrW1KuMNnYfnVv4t/TQ7b0n?=
 =?us-ascii?Q?qh7ixGecwhToq239CIjuvMxrb6RT8aYq1qgscGl4HayiXsiKAHHiU9QhEflw?=
 =?us-ascii?Q?TYfSAivYuiGPgu0984ca4TSUpf137riQYaaUxpvPRMLzxtCeMw1jH0WTNQxx?=
 =?us-ascii?Q?CSOQgLzt9f+sM8HljvE8dAYrdNeVbIhrw3RtUT3y5yqbjlUrj9Z/AQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bx6InseR/oh0s85V7F2/MSm313QQhgQuLKyREOevi4L/NdejkQIe1A4sHP7z?=
 =?us-ascii?Q?eItRMlhvJ/UnbSxSWoUvkDU9EodedH9NRNWu7GPnQ0JjXF+4erb1DOMIvEsw?=
 =?us-ascii?Q?cf3w+Olj1d0XCcotP1+yLV+idt8IFBKQ+T3V2bgAF6CV1hP3MI19m90uevVU?=
 =?us-ascii?Q?CiHzyxNXbmkhHW3vfdseCVh6jb16X1ExrTObt3xBpe0tZI36gzgTZ3wR/g0g?=
 =?us-ascii?Q?6dvqE94gx8mNt+t5o5az5bsqF3PxxtpbyVvCVz11OLoibGaJ+fIYU1O140mA?=
 =?us-ascii?Q?VGga59EFP2fBd3hbHgJAQC8zKOt/vj8S3b0VzCxl9eeAs8Fxpt4w7SgMH+J3?=
 =?us-ascii?Q?R4wvZKQ8uG1qUzUezXG1iYpUYrDK1og5kpR9IGHFpv9pYsi7u3zswynncVCo?=
 =?us-ascii?Q?bQ1jtoxwBlx3O0I/hngkpY2eGtpC5/d0tA3DZF1tGeQ92NubtJ8LHVdkzVtM?=
 =?us-ascii?Q?J+C4fp2UosYGV1ICRR5Vlasi85ni6HBwXHOap38feM0OiGlM345AAukpvZek?=
 =?us-ascii?Q?AZIRRsH3n3L997x4ReX789Xq68OBCT7xwrgbd+icwo0YDqo9jsQGDzJStRNF?=
 =?us-ascii?Q?NtLIJ06m/a9U1OwAHFJSxiVy5ROUze6g5NtYs9YcPHUPbPpZPGETicEZ+F6r?=
 =?us-ascii?Q?9GYWCTCz01K5kHw8T4ATOwOZlWObnWOiK/u5w9R5cZvdPAjFulbpVeK7odvR?=
 =?us-ascii?Q?8rHjuGxlVxKxM9XLDdASx+Re4kixK3zJClKiYIB0YGoibCfmKv5dYo7aE2tA?=
 =?us-ascii?Q?lIVeVvkyEYAR/28boZeoandqJviGnrjSPWRJoMI5b67c4nxKdu0d9EyHvtqD?=
 =?us-ascii?Q?81jsbGemAhx/ocZAOoaCukX0WGiTn+t7yz4a/z4AknfiFXaXfgWfhSHjtRCg?=
 =?us-ascii?Q?90n6jRHfcsEjz/gChzDnt5y1r7Cj6EZTr8VQtDBx3iFLeBiQaJfmVri1F4nl?=
 =?us-ascii?Q?HTgXZNXmr/1YNDDZ9irt0oxDz+iB68w/afnEu0jqseHWGNoiMk0ixiVRhw4N?=
 =?us-ascii?Q?KA/1M4kBHeQEAujIetNlC5vQTUre6ZrBrQGVGiXP1Vhgz+rAkTKYy/InQrLL?=
 =?us-ascii?Q?Rs16o1XYLWpuIVAVO/bT+wNHuobep36JL74LSd+yUztu8hjzFL9oENr6jeV/?=
 =?us-ascii?Q?2d1iLYmjBOltF7insbeeUe1kYXnlfzqmeZpZkJyvonumJzeUPUcZT90vCI8P?=
 =?us-ascii?Q?cNBfMkGXzyVCBYpZ+zkSdYsnp2CKJ3wjfZSPZiXRy5ui7Ma/K2QJeXODPhtL?=
 =?us-ascii?Q?nkW6fnlNxfmlSqpOkWGXKeGZ3nKgMffTTFs3pqpIbOAgZwSZsucL8TCUX3gS?=
 =?us-ascii?Q?GZAdmFbCgh3HoXWbm8WtD7im99fNTTxgHXRCeeSkXX06Lw+oVt2+5oK3hm9N?=
 =?us-ascii?Q?5QwF9XI+7DwbQWPkpHFIINflWUbBusBloZifeG3DHgq/7LsyNlYFVX8+7lSl?=
 =?us-ascii?Q?A6Rk9a3V8hJo9QRzz68EAj5HIYVg2jBs8qwCG5zR93qM7cvvHH9i9+q8ldSo?=
 =?us-ascii?Q?B2iHqMFpge9yzCE4RSjNwPAsGphBNyCSBY7KZdRNkBma0YWb2VNuDj1zBYke?=
 =?us-ascii?Q?3pv6+apVAYWNrNjX1Y9kk4QHsiRfhQ7dtjLLr09F?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 327c214c-ea2a-48bf-6ab7-08ddd7755661
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 18:48:31.7673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N3sFKgS+2UDSt6zxRIHUHqrPI5zLSYblHWuP7wxum1vGuk75IbBQGRg7hXUOciSVZQrUXaO6m3nlaejDWAcU5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7310

Since we are adding more servers, make dl_server_update_idle_time()
accept a server argument than a specific server.

Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/deadline.c | 16 ++++++++--------
 kernel/sched/fair.c     |  2 +-
 kernel/sched/idle.c     |  2 +-
 kernel/sched/sched.h    |  3 ++-
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 7baf2ff11587..8b3535b8fca9 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1549,26 +1549,26 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
  * as time available for the fair server, avoiding a penalty for the
  * rt scheduler that did not consumed that time.
  */
-void dl_server_update_idle_time(struct rq *rq, struct task_struct *p)
+void dl_server_update_idle_time(struct rq *rq, struct task_struct *p,
+			       struct sched_dl_entity *rq_dl_server)
 {
 	s64 delta_exec;
 
-	if (!rq->fair_server.dl_defer)
+	if (!rq_dl_server->dl_defer)
 		return;
 
 	/* no need to discount more */
-	if (rq->fair_server.runtime < 0)
+	if (rq_dl_server->runtime < 0)
 		return;
 
 	delta_exec = rq_clock_task(rq) - p->se.exec_start;
 	if (delta_exec < 0)
 		return;
 
-	rq->fair_server.runtime -= delta_exec;
-
-	if (rq->fair_server.runtime < 0) {
-		rq->fair_server.dl_defer_running = 0;
-		rq->fair_server.runtime = 0;
+	rq_dl_server->runtime -= delta_exec;
+	if (rq_dl_server->runtime < 0) {
+		rq_dl_server->dl_defer_running = 0;
+		rq_dl_server->runtime = 0;
 	}
 
 	p->se.exec_start = rq_clock_task(rq);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2c44354b0ed0..92856513024e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6917,7 +6917,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!rq_h_nr_queued && rq->cfs.h_nr_queued) {
 		/* Account for idle runtime */
 		if (!rq->nr_running)
-			dl_server_update_idle_time(rq, rq->curr);
+			dl_server_update_idle_time(rq, rq->curr, &rq->fair_server);
 		dl_server_start(&rq->fair_server);
 	}
 
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 6c6cc82ac2c4..fc3c056158b8 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -454,7 +454,7 @@ static void wakeup_preempt_idle(struct rq *rq, struct task_struct *p, int flags)
 
 static void put_prev_task_idle(struct rq *rq, struct task_struct *prev, struct task_struct *next)
 {
-	dl_server_update_idle_time(rq, prev);
+	dl_server_update_idle_time(rq, prev, &rq->fair_server);
 	scx_update_idle(rq, false, true);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0175946568a2..2c73d538f34e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -388,7 +388,8 @@ extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 extern void sched_init_dl_servers(void);
 
 extern void dl_server_update_idle_time(struct rq *rq,
-		    struct task_struct *p);
+		    struct task_struct *p,
+		    struct sched_dl_entity *rq_dl_server);
 extern void fair_server_init(struct rq *rq);
 extern void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq);
 extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
-- 
2.34.1


