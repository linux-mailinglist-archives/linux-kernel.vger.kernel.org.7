Return-Path: <linux-kernel+bounces-734685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D315B084C6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 669F93BC75B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434D92153FB;
	Thu, 17 Jul 2025 06:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="lRqFC9gz"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2131.outbound.protection.outlook.com [40.107.244.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E0E2147E6
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752733339; cv=fail; b=huZtveFBrp8iHC9Rum/iMrzWezkc9KHWQSkD21ZpfMzZfH/q2Zho6bncKXIuX6PTDHtnaoWGLb7xKoKBHtoJs/dtDBkMjUFNrGqKkxd4dRMvOTGM5IzGMm/K5I5lrpxk2ZOxFc994zJ1KzBEkqGlT1e7wKW/2WuP2hz/AADKU5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752733339; c=relaxed/simple;
	bh=Igmprgi40j/ac6TxQQ11+hvEQBOwv7K6+DWP1o71TzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UVLt1GJPiSgSDFZwQtXUWS0LZygB3nihqR6V0MfsQOJ+WYAW/R+aR90Pd4Jpue1mFRjtg4VqUkM7BAwxBYeqoBwuGnMdDq31vkZ4C7Z4fDXNi+XjTg4WjotmZOFyp1zFVrwSd55QgFoNhwjTfnv7ZBCksPKFUhwV7cScLBT9K+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=lRqFC9gz; arc=fail smtp.client-ip=40.107.244.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yt6qJmcw9fy79xtn86iXixfElYNKifcA5nmWyS0mYKFMtov8y+j20Qt+ad4AspswRCvQ9AqUvpXCe/wj2C6RIsfP2356vwp+2wkdaU1gZdzW4WFvzudLqZ/isx+iD3gx0Li/Y/OoK4veh4lNN+0THVCyp5eicRWljjm7qSKuTlmEEdMJwnqMyngowVVthGHynb5LBRJ9yCkWwa4cvG1uufB1BcKGQU+gSnDlfpHu5A/vFEz+f1j+V7xPsjhsIJvRbA7waWPA5RocMCZlsQpTZSam4Y0zxDsJ9j8ZxYZJJm211tRe1EFE/ED3C4Ej7UTW32gKafopELgN15A+Jj84rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6iSvUyFEpW9gKmODm4qeOMDD1w5EESSbQCc5Yx6gcg=;
 b=KwIHjxxmd6CvynVlGV6sJ/5XbwYfdGivNudZIITt/lYN7fq2nNcemXUUIIkGYfA38xlOZHtU+NxGY1oEHay/W16d0PAxs8hbOXoyGyi/+hzo/3Q5ncvswf4mpjUaBGHH0Sfasne96rdlrwm1lEAgi4mOQWGSBMYU7RUG5wOa1t35p8G+bUOeMUJWK72gsfJXJaHYnpV4My+bRGOwcjOAHU+FQr13LtNbvvDhudzgfpHo6WRyTwVGaRYkq+HzH4ZIIQFcQf/SshOIl//Ic/ytl/5Nnyi9KDxOvdcqLiePxWiI0JR4YrkI9WNVBIYLTceKnRoapIgMDLS56J3Vy4WeWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6iSvUyFEpW9gKmODm4qeOMDD1w5EESSbQCc5Yx6gcg=;
 b=lRqFC9gzPRPXaqZ5pi8jR4cW0q2E0y5NAahUlt2QQEknViNG6Y26R/X2lAkLZmpx8ACFBHQKKLF1K32FWJ+bples+V+lnx6zv5F7VdfhtgWPMufS7JhpdBQTNK345TR77ehDzxXBCHdSyFP87VddknCrvc7XyfiSZ9vnbvDFGxA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB6761.prod.exchangelabs.com (2603:10b6:510:76::23) by
 PH0PR01MB7287.prod.exchangelabs.com (2603:10b6:510:10a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.39; Thu, 17 Jul 2025 06:22:14 +0000
Received: from PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2]) by PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2%7]) with mapi id 15.20.8922.035; Thu, 17 Jul 2025
 06:22:13 +0000
From: Adam Li <adamli@os.amperecomputing.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	cl@linux.com,
	linux-kernel@vger.kernel.org,
	patches@amperecomputing.com,
	shkaushik@amperecomputing.com,
	Adam Li <adamli@os.amperecomputing.com>
Subject: [RFC PATCH v2 4/6] sched/fair: Make update_sg_wakeup_stats() helper functions handle NULL pointers
Date: Thu, 17 Jul 2025 06:20:34 +0000
Message-Id: <20250717062036.432243-5-adamli@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717062036.432243-1-adamli@os.amperecomputing.com>
References: <20250717062036.432243-1-adamli@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:196::18) To PH0PR01MB6761.prod.exchangelabs.com
 (2603:10b6:510:76::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB6761:EE_|PH0PR01MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: 830fa674-0e0f-456b-e989-08ddc4fa4519
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eU0nzCVUeF58prkEkjnU81LlWxErthtnjUOxTcFCEWa3qB82rt6jnJyOVuFl?=
 =?us-ascii?Q?P/7FitX+bi448hamAY1SWY/iaB7UMmRrOKcOXVLXp74Jkm09h4QRo6g7ozdg?=
 =?us-ascii?Q?45UuR6WettGrLVjcly5U7w98/+/LhjEN7IsseqvhX51WO+75uWboRDABAgwz?=
 =?us-ascii?Q?hFWL6ayxW0kp/QE93r/A8yb3iv/KGVewN6gK8TWY8lWXFUszVuHMXR3j1UlF?=
 =?us-ascii?Q?75ffz/JA18+TgCNWDtEFXGA/IAgSaJcYRCLmNcdQlFrKMkEhGZbPVatlCx85?=
 =?us-ascii?Q?IVOp/q27uasqfumaQiSzWa/vx5H4HwIyYTuZNeFWlQyiPGCtTUenM+LW+KwT?=
 =?us-ascii?Q?w2Md9ZngCbFxlDoL8K8UZAUq2pboqmxLdhBBdVOqu+7+1WazGybluiYVR16p?=
 =?us-ascii?Q?8LSk+EutbU9HLgysYmezR200UY8HCQjA7HeTCvmcyPZSIywUeWI8r58feeER?=
 =?us-ascii?Q?iTn10iCuZXjcQD+sVRt0V0iC8hOpc3U2vjhis5GxVqSJ93nHZG+wBWftxDz1?=
 =?us-ascii?Q?z5D5S0mLJ9lq/1Q2wG23/uW+v2HGXL7GRdSoS6H4yXEWe+dxziGfe2z8N6gg?=
 =?us-ascii?Q?YD9dvXR4ylH0WK/YHhe7zkeP8ajSBvY1hOum/KNcvt65GFN1OHonadgoqEpH?=
 =?us-ascii?Q?Zj7g3ksAKkvXeGFzc8DbWzKy9QgMBfZh+J+eSu5TwWWO1R5tAmkNTVMTg241?=
 =?us-ascii?Q?YV0xCIP1LxofsaNTJORaFzb6W16RYJC0JGXW5x96uKa3F3j7ES/tyItOqV+w?=
 =?us-ascii?Q?jTXTlU30pusznLB4J9zzfBBfHU+oJE6lcTc4j4YNVw0rRZQDHhCIVkUvbfNb?=
 =?us-ascii?Q?mkOvLsQDdi2QYDmUR0mLbh+pT+3jIU1BhnPLzDfVjqVtHP4J1coF1hGXaGkv?=
 =?us-ascii?Q?W2rXN+R5BgiwlqX1241qjD/B5muO7gdwZYY0TqPbs7SuQGJFJKgo6tQnNj2Q?=
 =?us-ascii?Q?PjWWCcxWrf7bkrcbO02EpWSnP4NXk6mDf+4vbCmiyfkqR6fgfu6ahuC6RZnp?=
 =?us-ascii?Q?XmNoz4yuyik3YXlZ5tjFNcDuqQQOS1HcMobuolFwANzUgPlbsgZ9eYXaZ9H6?=
 =?us-ascii?Q?J8WB6e6cZYe615SzU+5fIXDjUcFuQa+coBtjRlPt2kKmTAwXe4NB3ikp0B48?=
 =?us-ascii?Q?Mhmyauv8pA1VMzm+aZ98MNDZZjLBQEfFmrsBiMNVOX/Ocxd73sqsDkxTn8uO?=
 =?us-ascii?Q?jmvHSHeJsXe4hlqZypmGZB5WpykWeb9kbwpyLhtRrf4FRFt8aGZFo9CG8HvH?=
 =?us-ascii?Q?iuI86xjAfrDXMnhaY+TjQMXeuSLQAODil89z7rajXhc8uwMTOmTMWlbPiIj7?=
 =?us-ascii?Q?0XTlwL/Qv5RmYTdlBsVl0y4j71g7fn3PLgHmRjOkvQ/hI40YqMqyzDn/VT6L?=
 =?us-ascii?Q?foDnd7tRWQ8vVNaerOLrN5h8LOZ88mYipn6hWFN/OF/pX1Rnhe554XklE8Zj?=
 =?us-ascii?Q?6Mfb+DMsLgJyC/jj5b6jP/GVSv3FcYyYFpuVrDtpo+2gF6P3zWDWKg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6761.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qeIhzGU3PLpuURS/nKNx71nswF2Wv1M+dLtKnefMRLu5a8Vej6nWovhZDnBd?=
 =?us-ascii?Q?5c8+J4hZNiVcx3RHCyI7maajN1m/ueMsaSHFapFrMT0jZ/qYg34omUwewPUE?=
 =?us-ascii?Q?vSJ4d92pDRlVlgu0jn0E9ajrxeIiP1Hn8ZXn9usuz4b46FGEj1djLpIK9fBp?=
 =?us-ascii?Q?4oiLQtJNlR74YsHnvxe8C1/mfY+kQoxOyEoVM9MoI/1DdEmTUnNTswnhdfxx?=
 =?us-ascii?Q?+R6uCA6ufx7SrJ4d+dmfn1KU4hk4Jx/Z81GWzgZNRNI3MqtXbzxiWlaZtQwp?=
 =?us-ascii?Q?Ahz0M0Rj+PXTb7p1vThsd9QPnmlCCS0MU3eJ6Iy6Gdw1m+NUddsg8II7QS7+?=
 =?us-ascii?Q?mrRAXSfHivYsAVtEsnDNlag/FFPtMuKJ9iLocFnu5OruRQueamVsUzWEZJv3?=
 =?us-ascii?Q?okMxea8Zd9qdyu+8fL48+AtQQ0AdbcmhHbe/+sQsCDbb8up/ceVAs+gSTgPJ?=
 =?us-ascii?Q?dyi5RGPzB8VfEBdp3He8u2LywVQfTG8R2fcXqs1WJIzhySX5UyT+cROWqeoJ?=
 =?us-ascii?Q?BTAebK7TebDhPhbWe6T3hQf2BAbKZjepEw8FmFCubu4NrsZLflQn1jdgr88d?=
 =?us-ascii?Q?9jKf+E3k6lxf0KkV7k/8kXheBWhL7nqxiVNfPFxj26pdKc5IVGILNGC+6oDT?=
 =?us-ascii?Q?A3qLoqrpZpgQHHGwu5JSEpRMudOcZsO/JJ6PHdlaWP1vMVIANMXUIWjnL1W0?=
 =?us-ascii?Q?fyVhnblazV+M3npxSWuYqLnaws93vF9kGqIuwweoJYcHRu1OTUDubuXr+wgJ?=
 =?us-ascii?Q?P12H8pUqvUxkatBITRP9nOKqmMi4KFz2N9MBGfr+NC+0+iq21255/EfQaL5K?=
 =?us-ascii?Q?+59A57FE+lccxNTWqf0vsH1y2jW3HAKbighmbP8GQfmKmKApJgrR036kSv7N?=
 =?us-ascii?Q?h8g8PCTbud1yN9PbBjX/OHtJ/SjOzqcfo80dcxPWTJEvcNJ/ljhDyXQA3ZRK?=
 =?us-ascii?Q?XzGi4w9IQCs2xkhmkflTpsk2yabl3C0/IgRxxzHzEnufh61dHTWH7Fiq2Dxd?=
 =?us-ascii?Q?TJ8JKZxoQcUBHa1c31BCtDdRApEBkbUSS/tBo0leon5ArP4uT+/3j6Il1WxC?=
 =?us-ascii?Q?5/lOqpaH7kXs8sMBw1rSXkzzFcMwYVlkmomD4yzUZt7Sa6jGXoCMheyUQvKP?=
 =?us-ascii?Q?G6LpXuUc7zbzmFEQhNx3Sai5ZijT1KTcHmKMLxP4H6YUeSyWmZugJ6ETpRYx?=
 =?us-ascii?Q?ps+UfVle7sLy+0q0jiN1V5QP7uhefnQadXESRlS8vcCzdupj6l4+Yb7o1B9L?=
 =?us-ascii?Q?DjiyQx3TuGXQVsbDm1GMZNuQZKboQcbk0AsCau9AkszavSAm0jEi3vCEK4EE?=
 =?us-ascii?Q?y8z0I4m8M8azut7WagDd7h4kgtCbKU9tEn4CspgT6o8JDGe7Do3trcmeGkvf?=
 =?us-ascii?Q?+gInCUunxbPps6DWuWKqIKhZyOS52W3xiyKBJQn4EHBvo4xoC70tE/ujszmD?=
 =?us-ascii?Q?4fV9MdAjKtUlqpVwNPzoq82JhpVlH6EWchhEg7o7SjDHbN9ALfE3TY3t+1Ey?=
 =?us-ascii?Q?0NMtSHjHJMbzgWU6r4+KeFF9GaPi596a8KY0uquqSSz8P2G37CgBbCn4SWTp?=
 =?us-ascii?Q?wp8/ywppVn3MH3WN8m+FdeEi3Xz0V772Iq4pJDfCIbQxPk+lSvKxNv8vCLZP?=
 =?us-ascii?Q?uj+oIKcx/jZb/1w83v0iuhs=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 830fa674-0e0f-456b-e989-08ddc4fa4519
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6761.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 06:22:13.8640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xfp+q9Y3N3+Ihtv5sWQb0q4LSRNExWqKmNud8qejEICyLbXvB+lsLn9BujqU6jeEezUHV2htscrqr0mEk8CLteuOhzd/yS7az4df8rMwg/0Y3ta4cJemIa6JEqfnGdrI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7287

update_sg_wakeup_stats() uses a set of helper functions:
  cpu_load_without(struct task_struct *p),
  cpu_runnable_without(struct task_struct *p),
  cpu_util_without(struct task_struct *p),
  task_running_on_cpu(struct task_struct *p),
  idle_cpu_without(struct task_struct *p).

update_sg_lb_stats() uses similar helper functions, without the 'p'
argument: cpu_load(), cpu_runnable(), cpu_util_cfs(), idle_cpu().

Make update_sg_wakeup_stats() helper functions handle the case when
'p==NULL'. So update_sg_lb_stats() can use the same helper functions.

This is the first step to unify update_sg_wakeup_stats() and
update_sg_lb_stats().

Signed-off-by: Adam Li <adamli@os.amperecomputing.com>
---
 kernel/sched/fair.c | 95 ++++++++++++++++++++++++---------------------
 1 file changed, 50 insertions(+), 45 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index db9ec6a6acdf..69dac5b337d8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7250,7 +7250,8 @@ static unsigned long cpu_load_without(struct rq *rq, struct task_struct *p)
 	unsigned int load;
 
 	/* Task has no contribution or is new */
-	if (cpu_of(rq) != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
+	if (!p || cpu_of(rq) != task_cpu(p) ||
+	    !READ_ONCE(p->se.avg.last_update_time))
 		return cpu_load(rq);
 
 	cfs_rq = &rq->cfs;
@@ -7273,7 +7274,8 @@ static unsigned long cpu_runnable_without(struct rq *rq, struct task_struct *p)
 	unsigned int runnable;
 
 	/* Task has no contribution or is new */
-	if (cpu_of(rq) != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
+	if (!p || cpu_of(rq) != task_cpu(p) ||
+	    !READ_ONCE(p->se.avg.last_update_time))
 		return cpu_runnable(rq);
 
 	cfs_rq = &rq->cfs;
@@ -7285,6 +7287,51 @@ static unsigned long cpu_runnable_without(struct rq *rq, struct task_struct *p)
 	return runnable;
 }
 
+/*
+ * task_running_on_cpu - return 1 if @p is running on @cpu.
+ */
+
+static unsigned int task_running_on_cpu(int cpu, struct task_struct *p)
+{
+	/* Task has no contribution or is new */
+	if (!p || cpu != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
+		return 0;
+
+	if (task_on_rq_queued(p))
+		return 1;
+
+	return 0;
+}
+
+/**
+ * idle_cpu_without - would a given CPU be idle without p ?
+ * @cpu: the processor on which idleness is tested.
+ * @p: task which should be ignored.
+ *
+ * Return: 1 if the CPU would be idle. 0 otherwise.
+ */
+static int idle_cpu_without(int cpu, struct task_struct *p)
+{
+	struct rq *rq = cpu_rq(cpu);
+
+	if (!p)
+		return idle_cpu(cpu);
+
+	if (rq->curr != rq->idle && rq->curr != p)
+		return 0;
+
+	/*
+	 * rq->nr_running can't be used but an updated version without the
+	 * impact of p on cpu must be used instead. The updated nr_running
+	 * be computed and tested before calling idle_cpu_without().
+	 */
+
+	if (rq->ttwu_pending)
+		return 0;
+
+	return 1;
+}
+
 static unsigned long capacity_of(int cpu)
 {
 	return cpu_rq(cpu)->cpu_capacity;
@@ -8099,7 +8146,7 @@ unsigned long cpu_util_cfs_boost(int cpu)
 static unsigned long cpu_util_without(int cpu, struct task_struct *p)
 {
 	/* Task has no contribution or is new */
-	if (cpu != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
+	if (!p || cpu != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
 		p = NULL;
 
 	return cpu_util(cpu, p, -1, 0);
@@ -10631,48 +10678,6 @@ static inline enum fbq_type fbq_classify_rq(struct rq *rq)
 
 struct sg_lb_stats;
 
-/*
- * task_running_on_cpu - return 1 if @p is running on @cpu.
- */
-
-static unsigned int task_running_on_cpu(int cpu, struct task_struct *p)
-{
-	/* Task has no contribution or is new */
-	if (cpu != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
-		return 0;
-
-	if (task_on_rq_queued(p))
-		return 1;
-
-	return 0;
-}
-
-/**
- * idle_cpu_without - would a given CPU be idle without p ?
- * @cpu: the processor on which idleness is tested.
- * @p: task which should be ignored.
- *
- * Return: 1 if the CPU would be idle. 0 otherwise.
- */
-static int idle_cpu_without(int cpu, struct task_struct *p)
-{
-	struct rq *rq = cpu_rq(cpu);
-
-	if (rq->curr != rq->idle && rq->curr != p)
-		return 0;
-
-	/*
-	 * rq->nr_running can't be used but an updated version without the
-	 * impact of p on cpu must be used instead. The updated nr_running
-	 * be computed and tested before calling idle_cpu_without().
-	 */
-
-	if (rq->ttwu_pending)
-		return 0;
-
-	return 1;
-}
-
 /*
  * update_sg_wakeup_stats - Update sched_group's statistics for wakeup.
  * @sd: The sched_domain level to look for idlest group.
-- 
2.34.1


