Return-Path: <linux-kernel+bounces-778922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E81DCB2ECCC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 293617BB6F3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 04:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5E7299A9E;
	Thu, 21 Aug 2025 04:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="lE3HVFM2"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2124.outbound.protection.outlook.com [40.107.94.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CB32505AF
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 04:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755750502; cv=fail; b=Dx/IAiFjwQtJ7VG42refBi1XDqQ/mQOddobZkZx2GTFgHD54VitKZNTmxnh3Q2F/uupgedK5xqANEnm198Y9fU+csYgbv3Yxl4lYsLBK8NoS6ukEXXwLic3s7aWI7qfBeyzx0iJjtBbVtBRX3F0LNVt/Fn8FimnAG8ZkNP3lXWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755750502; c=relaxed/simple;
	bh=12r47nHopHGHbbr8xRGiN3TedMTSSuNY8Z7u9KK4qVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U/A3cPpCvWL1e2SYMX5uLyltAGMdOoF4dhH7AEmpU5xyaZvM6hrJQhOdzWPjNFaU31jxPSh+CG2gAC6GHBXF4oqbWC/4q2rAfNefk2iU/bTFmCHjNJdt0ju78nnzg5blnaV1TSarEmlCf3Vf7VloTtY3jjxcfdWZrpDveWUgMTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=lE3HVFM2; arc=fail smtp.client-ip=40.107.94.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYSH5XVqs5LCfplvSBySm0ZHmxhqWjlmpY6jhTuU6UNkKDknFbY5LyH5F2ZmsD/E/ODL5hEMw6Ud6O804004gxsDBUWGJpoTdKUeQHu7zilipX3LiHLjr97MlnwusBrUhD/OuZ7ngBDT3u27a97o5zCWZGeA4tRvVXTzlrtF4sN2eQZ91bSIICtMNR1hu5jnVy40Jnci3iQDkfE+9HixLUnmKBLA41Bg7d9h4YVyCEbNGF+50eEpk3xnLTvqg8a20AvzSETv7cdoJppxL6x7QRYI+e1ZFVyS8w0fccN5Yiyv/XgKixibzU8WoMrs54KIGeUipU1SGIRn48JvkCkHdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CKVqqUJQyAEM53ljMgb255zDalrevfUMEIDh/at2ao=;
 b=FQ2bAOvOpPCMzhcUjeIIV7ZFBlvGggHnBqfpJDaTuQOjGVvSnHY1rUBnZuAma2XRa/lXhmeM8elicCiW220+9TLsVJQIWEdcdgiHQG5TzcwlfbMjiaoDP77vsg3gGTPthydnjLFnvakxxMMjMh1ypG1d44hSlRtLfWqI934yOrR3h0kZloxpqW+GnMojslszqyAj93jcrroKVWB5Tok+PbakmDk7QyBPTAcEY906Kx/vOe1sT3uQU2CodG7kinH8KYh5RUCKdFjJl+n3dnmYRnXUHQe0swGYFdAJ4dgXQ05LaiikRXPj6//DMLXlSVELX5h7xWWG2YtpZwiEiOrelQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CKVqqUJQyAEM53ljMgb255zDalrevfUMEIDh/at2ao=;
 b=lE3HVFM24wK57AD6kECPO1/E2k25gngN0ZOv7IKCYVcwu70NcWGA8dydxkNgfjv5k/msxEh6pjEvMJ5x3EscrKXZuNTDWjlvfXGmaAdAUZJDC9s7YuItIRoKmdNome9B8GRsq56Mp7J1Qy6R42WoSu16QLH/y0qBMV55bkdZ3T8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB6761.prod.exchangelabs.com (2603:10b6:510:76::23) by
 SA6PR01MB8829.prod.exchangelabs.com (2603:10b6:806:42f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Thu, 21 Aug 2025 04:28:18 +0000
Received: from PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2]) by PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 04:28:18 +0000
From: Adam Li <adamli@os.amperecomputing.com>
To: anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	vschneid@redhat.com
Cc: dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	cl@linux.com,
	linux-kernel@vger.kernel.org,
	patches@amperecomputing.com,
	Adam Li <adamli@os.amperecomputing.com>
Subject: [PATCH RESEND 2/2] tick/nohz: Trigger warning when CPU in wrong NOHZ idle state
Date: Thu, 21 Aug 2025 04:27:07 +0000
Message-Id: <20250821042707.62993-3-adamli@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821042707.62993-1-adamli@os.amperecomputing.com>
References: <20250821042707.62993-1-adamli@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR03CA0029.apcprd03.prod.outlook.com
 (2603:1096:990:74::9) To PH0PR01MB6761.prod.exchangelabs.com
 (2603:10b6:510:76::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB6761:EE_|SA6PR01MB8829:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c52272f-a5c1-4fb4-8854-08dde06b2778
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?snYbbVgNO4YMT5KY+hsil33c7BoYxnfCO9dvUTkDZr4y2QzJpR5SUMe6p88+?=
 =?us-ascii?Q?42p1xpyUuuWFEPe27wnNHsthYUw7syQ5fK5dhIOxIE7j991zGwawJ20F7FjR?=
 =?us-ascii?Q?c8ZaSaEklQKjr8/z9BjZHURxuqceic7IOkJtqmfARtWXaZOiB0/U/Jo0OT95?=
 =?us-ascii?Q?72F0IgSqhknHp2uFDmzHPETSM1SUX8LCmyDT0rI7n8CUyyTnhwABt37b5JN+?=
 =?us-ascii?Q?BDqTmN66LfnS4U7dx89uQlbhcqYD9Uac5+M+QF0rrl+4qfIgpSpeJycI9m3N?=
 =?us-ascii?Q?SASL6yNTram90kscx/FOIryVkgVlSzC4FRfjQfXNGaZ08/9ZN5R6WIO/A5Fb?=
 =?us-ascii?Q?qnidRAyfNhefWTRmHBsyyGeWZ9STGhBryta08FS2JYy3op2DtvFXLvLV7Svr?=
 =?us-ascii?Q?JV+nRuU8F53w4wEu5MCoDUOfIWnAiILh1PhaO795XVLKmy9ZRTSaR/v4pSKM?=
 =?us-ascii?Q?pDkX+1IVxXVv2trNeuv8V4CN16s6wsLXbPnl06+fs89nIsVsBBcQliPY/vlB?=
 =?us-ascii?Q?XVD5lyYndFR9DJMSfVRcLSAPzOrcgawxCYt4uxJMzHBbvtHSqzP5DL7KeZhS?=
 =?us-ascii?Q?bh/Nv33SMP4BxC/ZpZkg3TsCkpTwaK+HE9LFO22nsBICPcH6+3NDH1cbhdCv?=
 =?us-ascii?Q?kxfrcXvNFZj6RKdO0UrH2c3d64R67fIuwJ8yukgv+sYbwSXweSP7vX0rvJRK?=
 =?us-ascii?Q?n/eI2941/Kwv4PxGT0/AAJHlGeAVBIc6juDH3G+OheBn4YIRxRs6I00iag5P?=
 =?us-ascii?Q?tBKaOKdMU1tanoWB3t+PaJQkE4ccpVaAdCmUxbWW6gAMj63C/n7iKiEC3bam?=
 =?us-ascii?Q?eAJpIqnLr6g/7pB52S5YFQDkQe9Xp4SdYVinSMfY8PWqJNOEVTQkSXVhgEoU?=
 =?us-ascii?Q?sh3LM0rIV/L6ggxE6tH8uwIHge/x9mWycQ2Cte2sA5sOdEveb+xQYemHT1/4?=
 =?us-ascii?Q?jB2D7pyD7rnh5wAb/3YInbmUluL3WIjhf8peuh/lRuBxNi05pXXsiW0bnuWN?=
 =?us-ascii?Q?WF6jOKXn1oC/gR5KUDrsJ7sk1V0iGYS29n+uEBmcPAoBpWlaDIbBHNfXnXh4?=
 =?us-ascii?Q?GmUuvR2JTUTIzarv7MXKdVl1kvLZBVvMHCjkmjwgtR2SgBbby6TReMQo4S+5?=
 =?us-ascii?Q?uOaD+ubK3g5ZOSGwcis913GgiaJzY6qA66ZPQz5oaE7B9btbCxtvuJt2fJZk?=
 =?us-ascii?Q?5j9q5J+DOclI1OnRQ2vcoSM1IYPFQvYBu4Sa/1i8TUx+bgHaMz5l0Q8tcJJv?=
 =?us-ascii?Q?W2XeKhLvL5+0C/m9wvoLpbCxJXllDzZaaoCm+VGapfiyz89wXpv2YgVyDLwc?=
 =?us-ascii?Q?CnpDsl7RuMV95AU6IP1vHxE2D//O76ci9SL6XGhzByv28bI01Zhs+avy99Ax?=
 =?us-ascii?Q?h0I3tLOUDsnqcBix6m9ol2IPAM/aNP8SBTQiZ3duS9b/XD86WOfaknyjETDI?=
 =?us-ascii?Q?EBzPOqBs3lCXlcm8Pm01ESMd17jcqCg05AwzSar/WFIGZrWQorFyIg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6761.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V3IarDguh9zbbGxTBLtSFeLcz6TjwVa3yOc6gIduYH8Bb3jiofcQKSnnESXC?=
 =?us-ascii?Q?gqfsmVLSaohZ5a4EXUEhyRQue6Vq3yqK4eI2egZo6W1xvqvCQnrZuIqyRsf+?=
 =?us-ascii?Q?zWar7pu5aX4frJhRJqTxWzfeRBqoLZ4AOvuwQXiY7Dp1Mx8MSbWnyl1a/foa?=
 =?us-ascii?Q?GjbNCItoPbkfSJ8sL0O7RjbaErRan2RWZDLse5uTZxGnOI3GfVfAAwfeeyy/?=
 =?us-ascii?Q?q8wP2yXe3jr8s7zY4mTIFt3DEqB3yX3empRFz8HFcvxHEX/pNc8PqnOtn/un?=
 =?us-ascii?Q?4x5CCCc3hoqcZiO5p63RLIRuRTvPjg/8YfFT59S0tfN8ybtkDGdXqDKGvhsm?=
 =?us-ascii?Q?at8WYGZxmvZQ+6PdaE4su+lLRmmdTjESccdPsa6g2q7q1HIhYXwaoTV4ALOn?=
 =?us-ascii?Q?bmkJdZ4zGZNgyEsoVxYdwEdl59Is4WwYMvRrQAOhXfGniK21TqHYQCK0Xw2v?=
 =?us-ascii?Q?oKhxvLGxAdnMOp4kSVeOoBu+aC9R+ILdP+Awx9BhSOK9kX5COeKCRMAyKFAE?=
 =?us-ascii?Q?9AxWqXxZ6RsZ+HboScNqWzNsAauBH19qpkDq4NLWrNY/rHDBPASHHmBjMO+7?=
 =?us-ascii?Q?e7VI8uzdYdRqxwgvjKoLMJy+vriD1FMFgD6c+nebKbJdCDriGdLTxSLh3l0h?=
 =?us-ascii?Q?4lmSJ8vJci5S4+W1HkM3sKb+Oz7/KDjXJpy4XeVD0lrB3ruKxELH8Y5C6fuy?=
 =?us-ascii?Q?TTYxdIanVoiV8BiwSyQuhoWJzxHVvQVKowRMGcelynPWyQfI5vKOUw5eGiGL?=
 =?us-ascii?Q?uJtDLxwvXMWGqCXfAqgC3gkp5ArFrCarnCVRG1jjH+q+ges1FlQSYwko8mmv?=
 =?us-ascii?Q?SfmghwjsqBykvJbClISu404+jlWxZGYYd5db9QkH/pYQQJCYoxQFCRPR6teA?=
 =?us-ascii?Q?0ZSP1HJZAFGJVKmw56RgOt1WOPCEhKLxvSDpnCbcv9rCml70hDjvPmzvlzeB?=
 =?us-ascii?Q?+szAraUNPcL3IsuzNoUXtjb9WhENLCAkLW+bvdp3rHDtLfvLMv4SWQtO7PbR?=
 =?us-ascii?Q?aKCakRLjgUg1eKBMv01+oZrsAYQEb56jLesK/2vPjkusDn0mtF21ShtP+nPd?=
 =?us-ascii?Q?jtXklyWg/4us411y8zeNqGNKcKqUWCq/1EMaZqltW3kljhsZqLW80WSt0CYc?=
 =?us-ascii?Q?ORZN7YliPWlf7APUw47Lt2+oL9kxW4Vn3ifZA54U7PHP6fRramB9lowhQA/O?=
 =?us-ascii?Q?al1Xj8OJVP937tsQYnas/FsEVNRVgUqQpywgQoUeYHU40zGnS7W6up5Vc0r7?=
 =?us-ascii?Q?e2nSzAd+5Ui9rh8Q6+KsVZ+gbkPAbw0IRiA5oGJNqAdnNk93UkZ9W0oT0Vz7?=
 =?us-ascii?Q?aXvrUtNXFeoJsdYc6LWrKe56vZtelkmtR/ytxfmhzMCkwx0UhLo53vViXOKI?=
 =?us-ascii?Q?kwt6miDisgaMmm3ecwEl/PSTtxUucmvEIs5BpCDca2CazwagRqScM89eU0Z8?=
 =?us-ascii?Q?ZBuiHLe0V0020QV5J89jlHDl0imS7wH2Dt39JHq6ttjmrunhNEkYxLIJMUDY?=
 =?us-ascii?Q?esrGMGv0u2yoA5brVEf2aax5XZHtDs2/7RFARjp1wJLzUsyMJc+6qCs004mH?=
 =?us-ascii?Q?o445+qzwBPsaP59OEGs/5K2h6E/Vg6ssm/pkA/QWbGUdRSNb432lNFEn9N1V?=
 =?us-ascii?Q?TtKa7RW7R+xZ7HbpoD+x67k=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c52272f-a5c1-4fb4-8854-08dde06b2778
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6761.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 04:28:18.8395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bozDZzIn9DK2Z3LFcrm8PpVr5SxRF2xj3gEy++wssduSKfScazLwlCXj00emf0RA28tygHg57hcnsNLomWG+xb7uJw3CQogKpS5if1sbt4PvVOX258NdAOwGAc7iO3Dg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR01MB8829

This patch is for debug only.

Warning is triggerred when CPU is in this state:
1) tick was already stopped before tick_nohz_idle_stop_tick()
   stops the tick
2) and CPU is not in nohz.idle_cpus_mask
3) and CPU is idle
4) and tick is stopped

CPU will stay idle in this state, since neither the periodic nor
the NOHZ idle load balancing can move task to this CPU.

Signed-off-by: Adam Li <adamli@os.amperecomputing.com>
---
 include/linux/sched/nohz.h | 2 ++
 kernel/sched/fair.c        | 5 +++++
 kernel/time/tick-sched.c   | 3 ++-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/nohz.h b/include/linux/sched/nohz.h
index 0db7f67935fe..ea6e07777395 100644
--- a/include/linux/sched/nohz.h
+++ b/include/linux/sched/nohz.h
@@ -9,8 +9,10 @@
 #ifdef CONFIG_NO_HZ_COMMON
 extern void nohz_balance_enter_idle(int cpu);
 extern int get_nohz_timer_target(void);
+extern bool nohz_balance_idle_cpu(int cpu);
 #else
 static inline void nohz_balance_enter_idle(int cpu) { }
+static inline bool nohz_balance_idle_cpu(int cpu) { return false; }
 #endif
 
 #ifdef CONFIG_NO_HZ_COMMON
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b173a059315c..cd1c17368e05 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7109,6 +7109,11 @@ static struct {
 	unsigned long next_blocked;	/* Next update of blocked load in jiffies */
 } nohz ____cacheline_aligned;
 
+inline bool nohz_balance_idle_cpu(int cpu)
+{
+	return cpumask_test_cpu(cpu, nohz.idle_cpus_mask);
+}
+
 #endif /* CONFIG_NO_HZ_COMMON */
 
 static unsigned long cpu_load(struct rq *rq)
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index b900a120ab54..8241b14842f3 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1228,7 +1228,8 @@ void tick_nohz_idle_stop_tick(void)
 
 		ts->idle_sleeps++;
 		ts->idle_expires = expires;
-
+		WARN_ON_ONCE(was_stopped && !nohz_balance_idle_cpu(cpu) &&
+			idle_cpu(cpu) && tick_nohz_tick_stopped_cpu(cpu));
 		if (tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
 			if (!was_stopped)
 				ts->idle_jiffies = ts->last_jiffies;
-- 
2.34.1


