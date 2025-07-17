Return-Path: <linux-kernel+bounces-734687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5B9B084CC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7EC1A68481
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C90217F56;
	Thu, 17 Jul 2025 06:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="OfDC4u+2"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2123.outbound.protection.outlook.com [40.107.237.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B0A21507F
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752733351; cv=fail; b=rAA6ouoX59vLui0NvZpP9VmT/P4D+8OLjMZsQXmmoE2xEkzynZGMlMod8AjntOVosHCpdPJmxDMjZoFzWoxmJFRr05UleEmvC33wbAlo1E6pf6XNaHX/0Gzq/ChmPlywhwdZu7GV4K7ALRvMiVXOikX3viDJMsWijOGGpNsY4lM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752733351; c=relaxed/simple;
	bh=R2B8X01RI1Tf1Iw5BFBXAfg3oYqqaB3Z9l7erEMOYrc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FYF5UYmFhfGTmHSkGzzY/iLIsCSQynExNkajaYANsAuHq9Yxofe6sYIvGJiS42bkVnEntjp15UkfzNqScpSd8HrCZdDTwMF/HMpgLITrodSaQ/wKvf7xZzWoeNU7DXHgPMy+ANg+Eddu9ppXptFmhhrQI5QLWNch21buJumFVVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=OfDC4u+2; arc=fail smtp.client-ip=40.107.237.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpmMzMuwCo6Se0iCy/gSJR4Fyk0atd/5C3v7thAEEz60d+C4A4TFg+l/GlfZHifEgYp8zuCckhrNsv+F5cMLzvsMd2TzbLMl4VDCTkI6Uvus4Hl5OEQQ+7XHLdKpK5+YfIs1Nx+3RvcSGerdMNDAI+c8W6rn2IWfsemF6Gmfnc1SCJakiyq8dlzSqDF3mAIC2UVgbIxyc3cNxp348MTowjEIHJfhcw3SxYraUwzYnFxYBElozVoCTCPVQUeqkU3o6u9bnS/h0HgTv1M5MrNJz2p2XYjFrXlu5ouawRfVgFc6toUQf/rCRAjeTkjj7gUr4sf3AZkfcomrSLKK9oHGbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMJuQ7QELqO+AGi/rjaxAew2xbp3rzck7iIBAE25gS4=;
 b=zCPfQfrwsbB5KB6GtXw+6MS+0hE/PkEaABRB+V4dz3KkHPinw8CHXukoPY5MU2mas57mIMk1vMwM6+FawK3B+XRwpoWMBPLuXHZlmL2zkw8Mxds5Q1wRyjB6grn346JJSTCn5sxzzUd+vOYDILVmvfpH8cG5UOxVJYTL6rVYve9i3yZNCLx7Wo9INUZpn7dIMm8iG/eDKBcfGxOWNzwRrrQg67KZ2CDbI/+wkdA4ur5E7yQWgrKa2tUZ/v2ljOMF8rEvuaCbZVIMFPodOYXtdM1857P9BdYV32CLhf4OVTrA6eGGBwLgi7oPUItzaAT1o1tKVMGHvpqEMoVWjZdA+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMJuQ7QELqO+AGi/rjaxAew2xbp3rzck7iIBAE25gS4=;
 b=OfDC4u+2wOPH7Eg9b/EdHlPVoOncSVOBHC7JdnngpyNvnx3i/la/rvy34ePyISFAErtvjEFsKzHiQojHSof4YJHi7+YkcouMskSxSVlqxm7Zn6Cn8uulogLdL+10vyn4RzvhmERLDALxDWja6N1yQMbNxnMZRih9Py5R2JjLM1E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB6761.prod.exchangelabs.com (2603:10b6:510:76::23) by
 PH0PR01MB7287.prod.exchangelabs.com (2603:10b6:510:10a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.39; Thu, 17 Jul 2025 06:22:27 +0000
Received: from PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2]) by PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2%7]) with mapi id 15.20.8922.035; Thu, 17 Jul 2025
 06:22:27 +0000
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
Subject: [RFC PATCH v2 5/6] sched/fair: Introduce update_sg_stats()
Date: Thu, 17 Jul 2025 06:20:35 +0000
Message-Id: <20250717062036.432243-6-adamli@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717062036.432243-1-adamli@os.amperecomputing.com>
References: <20250717062036.432243-1-adamli@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR01CA0078.apcprd01.prod.exchangelabs.com
 (2603:1096:990:55::15) To PH0PR01MB6761.prod.exchangelabs.com
 (2603:10b6:510:76::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB6761:EE_|PH0PR01MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: cc0a5674-c653-4283-ca98-08ddc4fa4d04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WlU/djKmRCDa2n6eKNOV5avL0BmLq5zC97knGzDdUJD1OuULx3XQpFzOZt5n?=
 =?us-ascii?Q?GKaDvw9MKnkhqt3HJDJRumkYzKTRfWxbR7JZz6idk43RRFPlrYgwo4rbPfGj?=
 =?us-ascii?Q?Udi33KZYopp4jOEcKDHSotAPNUOA0jNjU4GOpbH8FnxOt0CZcTDIf0sTm7Pm?=
 =?us-ascii?Q?SyvChri7dCM39OT0NfYuQOBPpNWO1qaNwP2ET4E1uRIBCaX2rnLQGaFSC4ip?=
 =?us-ascii?Q?cEQsJvRpDibD/km3XWYt2SijYpYvnX18849X55BBriVmUpdzYjs/8Pvhy9Kl?=
 =?us-ascii?Q?96tzrGVh9OjBLtqTFolFIux5cg1EgtIKHeJqL8uDuI1fYR0W2wQH46wn/R3L?=
 =?us-ascii?Q?le9ulnZuP78zQlc2ouI1DHKBPxFpwQgSlo96MsMsEjzXdmCyWQtvxCqQ2fi3?=
 =?us-ascii?Q?DgL8QBr3NmIC97rtkIOyJPAZ7RjONBniC4zz7SnU6A0VCO+kRqqTYsGJ7mr4?=
 =?us-ascii?Q?66zADRDrGkuUhIvp/V66MfhkdYAuFNb4zPg3rpJOfsVBPhxtG1iP7GvCc1a7?=
 =?us-ascii?Q?OFFOiOrUbsjkahfXo4mOteBRKDNcz9XA15eN8K1WhhSq/ZpX/zwryb8A7hDx?=
 =?us-ascii?Q?7R+4LmMiV7k9Stw+YePDjC768CJ+F4/M81k+AqpG1PrBP/M1RjnXDrBShY/q?=
 =?us-ascii?Q?Jx/fj18uT+WDqBYqGvDeejosxmGni5d2kpotwFm2eT9nOQFtLeh9gXf0uU2G?=
 =?us-ascii?Q?C4g8UOOCxNAOKg5sb9+skJnpkNVM7HwQ7L971LsMnq7UevrWfcSXfS/X8a0Z?=
 =?us-ascii?Q?fVFMqdUoKudl5tpQkEtDPS+OprV3hQej5uRhLRe2QnpILCyOLXgKcZE3l2WG?=
 =?us-ascii?Q?ltzeLCE0wTpHorEx5lj4RaBzJGuSHpUSuL4JEyWt8p/xTRjai4cUnBQ5wKLV?=
 =?us-ascii?Q?Z8Cl/KC9tC/N8iIac60jtbDHTIuftdKbkRkRNeLdXU2sdLvrxJdBJV/nKYyf?=
 =?us-ascii?Q?v3Q2RvszM/IlNgO1I1ystYS7fLIQ9CEyHGLygJ71RJWzKTfKV45QklGd83Ka?=
 =?us-ascii?Q?eGqu+pK55mhyfcSH2d1oJdaAjSNZcUSOgX57bkVUh7LuVuEjGFle+UnctcJQ?=
 =?us-ascii?Q?yNtIyPudewR2ljHyN+JuHroy3jAGsrF9yY6Y4m9TfFH+mtoKxAMMy4sEsirw?=
 =?us-ascii?Q?QZ56IK0sGM7PpZcwsen+ivKGNIXuNNrDFPUk9i4cnIY5OPLzcNsPVGZ1ACUY?=
 =?us-ascii?Q?G8Gt8t4qaO0Si2sd1ytl9nWEPfyqD0rjV8If4LBM0UldAocpSsWo21IOKdly?=
 =?us-ascii?Q?OpQwSeZsGj6v1sIH81jO0g5mfns99LV/ENNg3wOUqIkIe+COnzRiKNGg9STS?=
 =?us-ascii?Q?DfKEETCz/kTEpfxROyQgq82gXHpn7f6CDprTZAtzK2tO6nCdwCkzqIkbhyYd?=
 =?us-ascii?Q?jLB98WqFVu8AK7rzLC8fWBs3Rneij5KFEestfrirMZwV+3RB2+kFEHIN28d0?=
 =?us-ascii?Q?B/2S5o8k6xZyOmbKw3X8c8KQGC6nvtAQ0IA1nFw5eaMhSQh3aMr2qw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6761.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lg+xsmeVyzXRo4+EsMUF8di03Os974KXrnOABswVXEG3VwbB9Fc5Gg1EE59J?=
 =?us-ascii?Q?A4+vMIoccVKXekqCNFnwMQtdp2PKJBx24VBFYQShFHghRZ1hrbJYLMgYl9hG?=
 =?us-ascii?Q?hLcFSXbfYmInK6XASoUbU902v5o5OPQH+kT3+XUoyK8mZRlEDXDjYbgZOw1T?=
 =?us-ascii?Q?VahFuCb4xdJUBY6wa8MCeSCHML+eQbQok3mRFxqPrXe3P394JmmJMRPIWH/3?=
 =?us-ascii?Q?tFncSAdAnrFSmZBpyX4jYlPmvj5J+3p39QX1MDbI9FtO6e54Zb1IZRl0l9HH?=
 =?us-ascii?Q?hrtoKZ3K9p61xHOh+49iLhbhTSxflntnf/zMJU2Bx1x684E03f5LSV2sgiCR?=
 =?us-ascii?Q?UAU5fB/Am+rcjCEpoxynGRTP+ku4JMiziM3MvybAFPwpzf5v7jCMJxb0vKGY?=
 =?us-ascii?Q?VVNvD+AZK4uwiaamIyZnHQ8D0DM9HDvchhxW/1jZUDdyrkAYQ+SMwfb0U85q?=
 =?us-ascii?Q?rC8Hfe8zM+3MPu1rz7WzC519X+foMY3Hbwr+jmZ0GJs1ZSfx6IJfgyBHJKiT?=
 =?us-ascii?Q?LEnCvT+3r7eym4GDdNdMhpAUbpENwRYqLvGm7G+U7ekjWNFY2HudGSuoBo1o?=
 =?us-ascii?Q?X4LbZlNCPX1Cx7ToHmCIVsztml3TBNNFju0AiHpZiExc2WY6uHCO4iVbZt4a?=
 =?us-ascii?Q?J1umAMwCeVY3WzUt9/isg5DTLtVsDojX/D3LfxgJx15HMri4wcfXeqHQ+Fi+?=
 =?us-ascii?Q?BIdXufIL7j5noNpoIdfhpo4VVuF8N93QUa0Yh7O097aTWbwdlLSd7dRBTdnQ?=
 =?us-ascii?Q?ldOH5dL2L+NBAYOKUGLSSNC//YDUP7dao9KP1WKmuFf2IXVrSc0yOuXVpuYe?=
 =?us-ascii?Q?AGjxKTDd4mHV+xYphVVmzwIhVrVBetPkwPHtPx6tc9DnULNgAPi1R6ttbfhP?=
 =?us-ascii?Q?9Dnhj2yf96zbkhFJOwS6QMPHHblsgZPQu9Dl9iCGQC2bewsblXovZ3puVIsA?=
 =?us-ascii?Q?UssNUPHZbdL6Ypvw8fAb22g6AsbJxiQSlLIQT/vzUKs+6PPNk9crSV61vUUC?=
 =?us-ascii?Q?9US9n5d5SmdIEaNUzMPtqBqYEE2EnWRvuJKBxrXDh6oNJCLveluSu4ZqyhRK?=
 =?us-ascii?Q?4AruaYTOZIRSbPylebJg7q5rz1rkB9zlMBNT3ya+lhpUNcP/t2GMGglxpFWS?=
 =?us-ascii?Q?zKqEHkoPOMrEc/Pip7kfI1mo9oX7W95yaTSQv//2XJJRPbH4MB36OilH7K6i?=
 =?us-ascii?Q?1FPlCnSdwQ/JTkN5AN9rpXC8MSg5uZxri8n0yy5EUDmcXx/p+r1x5v2AgYOp?=
 =?us-ascii?Q?ApP6C6u43yLxKG1PCIql6B/UajPQW6PJTto8hyhLU1rvKbLhsKSjrXsANKgu?=
 =?us-ascii?Q?ZuqNS6zeTl1OgxHv62PIeybFL84Rwhon6jr0RIypv4TkoOpFY8py6L5box6D?=
 =?us-ascii?Q?0CGpDLAIYxoVCyArXheGiQysEm2tOJJz/JgzShMzyQCA19kAOmf72kGJkEHS?=
 =?us-ascii?Q?61TVaqL0KGhiYizAXClK5eH155fG8vxXQumdIhpdZJM1i+dMdv7rXtcKFzSD?=
 =?us-ascii?Q?qzxObnef7L53gJOLPVZPoGMaGiNXq8hDplgLDN0gKqDsv0vA6MVZo/2IqQ7o?=
 =?us-ascii?Q?Rp3j5aZbCR/rmsliUvjOtIxznSC6hLspe7zz44M133njNJNOXhtwINaWPw/s?=
 =?us-ascii?Q?P6LpoG8sXxTh43KV02/2yQw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc0a5674-c653-4283-ca98-08ddc4fa4d04
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6761.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 06:22:27.1179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sAF6qFRNDTGWUOwRawoedLa3VW7t+3bkW6xPoeXXRv1+tJMNdY1JwDvnPsWpQbZKf0gvUJtOTiDleJr6dXm6n4blInL0Bx0slvDMoBFhVKqH6Ye91WG0b129H+9qkwqi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7287

Unify common logic in update_sg_lb_stats() and update_sg_wakeup_stats()
into function update_sg_stats().

Signed-off-by: Adam Li <adamli@os.amperecomputing.com>
---
 kernel/sched/fair.c | 115 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 69dac5b337d8..f4ab520951a8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10398,6 +10398,121 @@ sched_reduced_capacity(struct rq *rq, struct sched_domain *sd)
 	return check_cpu_capacity(rq, sd);
 }
 
+struct sg_lb_stat_env {
+	/* true: find src group, false: find dst group */
+	bool			find_src_sg;
+	struct cpumask		*cpus;
+	struct sched_domain	*sd;
+	struct task_struct	*p;
+	bool			*sg_overloaded;
+	bool			*sg_overutilized;
+	int			local_group;
+	struct lb_env		*lb_env;
+};
+
+static inline void update_sg_stats(struct sg_lb_stats *sgs,
+				   struct sched_group *group,
+				   struct sg_lb_stat_env *env)
+{
+	bool find_src_sg = env->find_src_sg;
+	int i, sd_flags = env->sd->flags;
+	bool balancing_at_rd = !env->sd->parent;
+	struct task_struct *p = env->p;
+	enum cpu_idle_type idle;
+
+	if (env->lb_env)
+		idle = env->lb_env->idle;
+
+	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
+		struct rq *rq = cpu_rq(i);
+		unsigned int local, load = cpu_load_without(rq, p);
+		int nr_running;
+
+		sgs->group_load += load;
+		sgs->group_util += cpu_util_without(i, p);
+		sgs->group_runnable += cpu_runnable_without(rq, p);
+		local = task_running_on_cpu(i, p);
+		sgs->sum_h_nr_running += rq->cfs.h_nr_runnable - local;
+
+		nr_running = rq->nr_running - local;
+		sgs->sum_nr_running += nr_running;
+
+		if (find_src_sg && cpu_overutilized(i))
+			*env->sg_overutilized = 1;
+
+		/*
+		 * No need to call idle_cpu_without() if nr_running is not 0
+		 */
+		if (!nr_running && idle_cpu_without(i, p)) {
+			sgs->idle_cpus++;
+			/* Idle cpu can't have mistfit task */
+			continue;
+		}
+
+		if (!find_src_sg) {
+			/* Check if task fits in the CPU */
+			if (sd_flags & SD_ASYM_CPUCAPACITY &&
+			    sgs->group_misfit_task_load &&
+			    task_fits_cpu(p, i))
+				sgs->group_misfit_task_load = 0;
+
+			/* We are done if to find dst(idlest) group */
+			continue;
+		}
+
+		/* Overload indicator is only updated at root domain */
+		if (balancing_at_rd && nr_running > 1)
+			*env->sg_overloaded = 1;
+
+#ifdef CONFIG_NUMA_BALANCING
+		/* Only fbq_classify_group() uses this to classify NUMA groups */
+		if (sd_flags & SD_NUMA) {
+			sgs->nr_numa_running += rq->nr_numa_running;
+			sgs->nr_preferred_running += rq->nr_preferred_running;
+		}
+#endif
+		if (env->local_group)
+			continue;
+
+		if (sd_flags & SD_ASYM_CPUCAPACITY) {
+			/* Check for a misfit task on the cpu */
+			if (sgs->group_misfit_task_load < rq->misfit_task_load) {
+				sgs->group_misfit_task_load = rq->misfit_task_load;
+				*env->sg_overloaded = 1;
+			}
+		} else if (idle && sched_reduced_capacity(rq, env->sd)) {
+			/* Check for a task running on a CPU with reduced capacity */
+			if (sgs->group_misfit_task_load < load)
+				sgs->group_misfit_task_load = load;
+		}
+	}
+
+	sgs->group_capacity = group->sgc->capacity;
+
+	/* Only count group_weight for allowed cpus */
+	sgs->group_weight = cpumask_weight_and(sched_group_span(group), env->cpus);
+
+	/* Check if dst CPU is idle and preferred to this group */
+	if (find_src_sg && !env->local_group && idle && sgs->sum_h_nr_running &&
+	    sched_group_asym(env->lb_env, sgs, group))
+		sgs->group_asym_packing = 1;
+
+	/* Check for loaded SMT group to be balanced to dst CPU */
+	if (find_src_sg && !env->local_group && smt_balance(env->lb_env, sgs, group))
+		sgs->group_smt_balance = 1;
+
+	sgs->group_type = group_classify(env->sd->imbalance_pct, group, sgs);
+
+	/*
+	 * Computing avg_load makes sense only when group is fully busy or
+	 * overloaded
+	 */
+	if (sgs->group_type == group_fully_busy ||
+		sgs->group_type == group_overloaded)
+		sgs->avg_load = (sgs->group_load * SCHED_CAPACITY_SCALE) /
+				sgs->group_capacity;
+}
+
 /**
  * update_sg_lb_stats - Update sched_group's statistics for load balancing.
  * @env: The load balancing environment.
-- 
2.34.1


