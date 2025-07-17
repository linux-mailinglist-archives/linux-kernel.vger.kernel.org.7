Return-Path: <linux-kernel+bounces-734688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D73B084CD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ECDD1A684C6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25828215F5C;
	Thu, 17 Jul 2025 06:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="uuLQCU11"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2097.outbound.protection.outlook.com [40.107.102.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866031E2312
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752733366; cv=fail; b=NR4nNrCOKwwKYfC9iFBcoWXumfYAOlkM1KNmBMdKZI/7OZP2ZbCGkZ7wEKglA5KW4ywr7RIloD1AK5yjVClYAr9703MmzCLbI1cpRpl/cl2YNVv3fku18qIemfD9qHEksOrbwjFEthuf0YirrLXwM46SQnnPEYsDnWxmGpAWLW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752733366; c=relaxed/simple;
	bh=sfNrXg8+4VhfIg4fV1tfffXaV7L8SIVtt9B3fzZ0CJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OQAVz4fr5d+kB0Z1PPTqrdrdw6wPgB6FsnHoPvkedpfwGYBashU5xUNG8yNlyMq7ki7POKZR7buaBb11i+pOqruBA9Mesv82PtosHimSDf/5MhzfkgJDxDmpnBuBnbQ+QKd69O25Ax8cyOGpk4JVwxwMm+UwslV+xxiisOY1JU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=uuLQCU11; arc=fail smtp.client-ip=40.107.102.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URKEksfq3H2qzopeRUTsbyd4/jDNyqwoeYs4xb9aVCz54gc1IEysXJK5yw3lSiRO08gehjIRDvuKL+ahRBuyrV/U0FCZWEeVLBWSs664fnj6a4SjOQODecAI24OxivIP6YX4rBHAGkfygjq8DK/2RPm7ZEpDtM7XxtiytPHJ/qGEWVXvDowxHHFHKVa58xzebhDCNeUExBBPjf7vOWSkCzbUVzGr6XQ540rpbtRpJVZvFFTPJBIqd3FMXBq3EWCgHvZ1ggixmqcbrJBJT0JwwhTQFNt4nvdv3dwkVJ91B+uTS2Jt1ANfKw9FwEw21Zf6u6MFYn34sdTtpyAuD4vyjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i24rGve1LJxxfa6Hg67tgwiwPx2M6fpX+Eg7U7FhSPo=;
 b=FgVL7fpAFy7CfNh1i3Pm6yY53YbMRJ96ZcTa+xN3h9R6maRY8E6Jfsg+Qnksh75q2seACQ0N4kvIM1/DU84QjuGeWoYJ3SVcJmDZ3m2qIxr4lHc7zCZ12B+p+5FilBuOmpylOGErCpkKRg68aWRhlHvn7ZLPD1elQx6zyhBpFKe1WJ3Xy3O9d2YXmMtTIVTuk0R6nNg5r4kHYHWFW10YgPad/piPFxj7L19U/mg808wcDWmfpWcaVGzlUmyQkN2gU2UMIER5/HDWD7Gs6XIW7Zsy8/n7/70jKUzUpqbFCnzEMeQ978mLGxqPlQz8VE6jNVsbaHgqCY5aQQCtyoUbng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i24rGve1LJxxfa6Hg67tgwiwPx2M6fpX+Eg7U7FhSPo=;
 b=uuLQCU11eVlE/TUsoCWblyMokI9ZtSe+aBSCSpMcyOSZj02O/EM3vOiHz/razyCjO053KfaWe6whA8d0M/ki5V+DQXfSYc0gMSSs3kpPZXanJmkS3C5TTe2AQ6kghZuaJhXFaQb5m+13AquF9vfvFlb+OqoXTrtICAkO491mobI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB6761.prod.exchangelabs.com (2603:10b6:510:76::23) by
 PH0PR01MB7287.prod.exchangelabs.com (2603:10b6:510:10a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.39; Thu, 17 Jul 2025 06:22:42 +0000
Received: from PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2]) by PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2%7]) with mapi id 15.20.8922.035; Thu, 17 Jul 2025
 06:22:42 +0000
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
Subject: [RFC PATCH v2 6/6] sched/fair: Unify update_sg_lb_stats() and update_sg_wakeup_stats()
Date: Thu, 17 Jul 2025 06:20:36 +0000
Message-Id: <20250717062036.432243-7-adamli@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717062036.432243-1-adamli@os.amperecomputing.com>
References: <20250717062036.432243-1-adamli@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR01CA0150.apcprd01.prod.exchangelabs.com
 (2603:1096:990:5b::6) To PH0PR01MB6761.prod.exchangelabs.com
 (2603:10b6:510:76::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB6761:EE_|PH0PR01MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: 574c421e-6240-4e7c-5cb3-08ddc4fa55ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sfNrGNUj2GKungN+0hqdqrrkfDRZoDFXtEd6P2JU7H9CgK9cvKM+AZy49Kjn?=
 =?us-ascii?Q?f4jH63PtRX53s3mL51XI+5Y7e43pCw1ckgJevIRvdgzGo9UxFKf1c+GtWpkt?=
 =?us-ascii?Q?pw6yU+TWaIq4qCN+JQr0XI4y9l9QRflvYnRGoe7tyK4a89yBGp/E3wP2nnih?=
 =?us-ascii?Q?0W5PAb0hkZ7lQ7VYdfAkKc6BmwgvdIIXNl3BAsxi0b+JbxiyH/snxkz5pEtw?=
 =?us-ascii?Q?HOz9w9JxGWRl9tAjYkjUsA45JY7KlDlo7B749wtt94w3evmOg2EHVYEJOIpB?=
 =?us-ascii?Q?GKIdv3id1J20IQ0yZ0h+DFaR59DZs4t37kIJnVfrpIfeaox3eEtixRsGr5OT?=
 =?us-ascii?Q?qMdAYB0H0X6d0vINJ0lyXUU159O7lorK/1iUTE4wX3SpuaQeKPyrDIj2ld4M?=
 =?us-ascii?Q?+bD+xwIsye2oVLOsqWATbQwwqpPp0X4vheYnwj3R7/HbqmOx1rNNqE3W56wa?=
 =?us-ascii?Q?99/hbKx6c4wdovlPWgYy02GWcWS1heGbsnRYrjAGJsLOGjzEqjZym3588sMO?=
 =?us-ascii?Q?7QbzsOXkIxR2NtG9Iu7yvfcL36ncZ4JYjzNJP7cFLkZdALR+3lnjgJwaG0Nx?=
 =?us-ascii?Q?7tB2L/+ij/6FnaBKmD5uHkJZbTGVT0a/JOVv5crGDm3cAweq5pD8MGpGva2t?=
 =?us-ascii?Q?yeEwknmeQzQnDem3ZNLwNxBxKavYBVM+sbxdTEVOoFzuXs+SbqnR54fNiDvy?=
 =?us-ascii?Q?MSXps8BbwE3FP9LfdYd87kIW1y+NY0jkJ6+hPfNPSIzw5AWymnbexoqFFPWc?=
 =?us-ascii?Q?EqHfBT8X6iUcaFI4r8h5xVeHgG/Uv7guOMdb0nrxZKnq0xONMbgEpYfL5OYL?=
 =?us-ascii?Q?/o5KnskGIBgb8rCO+jL6mwW0T43qq6p5slgp1u9ibW60/6GEjnejSz+FTlEw?=
 =?us-ascii?Q?JVsGDlnGlFuqCWVYluR6peZ9htT2OlGltgECDnOmOoNkRNJxO1mSQJUBMJoL?=
 =?us-ascii?Q?jtZu2DhonKMI52ihUPzv77VagrPH5zaXA2GYprCBI6D7Z6lFtIu1YuwNNPxz?=
 =?us-ascii?Q?AYXxrkKAQ2lxbgYeCQb4kK4EM/8uOnEYl8iXF7KcMhLQjPJ4auc/IbZCain8?=
 =?us-ascii?Q?6zZnC90MiciFcWFDnDSTeA6CEfIrRKrPWBj42Czx+yWKH8xw6aqXeItYqGHI?=
 =?us-ascii?Q?z9jyBmuTfPfMH2qOZDWHd3IMUSdbis5KUw9RtHeECOINK/2jFybibLeCT2y7?=
 =?us-ascii?Q?BkHeqid8AGvxnk8cpQ+ZhMKKj/RluAVsCs7XBwg6owyDKSINXQRrRGgsyAv+?=
 =?us-ascii?Q?REn0LaVideSnSYihFb8k6C3tOvPkb8iIxpvv//i+LgIZvrkSjxsURH51rXng?=
 =?us-ascii?Q?whuLfCyFNxdEPhBQdpd7IXJN+zouN9y4gYlsD1Fo6I6laYN577BtdCENOPHe?=
 =?us-ascii?Q?yJSiRzkSEzS9RbZdsacMOr74RT2bgukl4tP/HkedMUP5slfqdbn7lA9rP9PM?=
 =?us-ascii?Q?zgS/wDF5UIcmJ5XwNBfPXINlrfGTfpp+cjxMBAWNRCaVeCq6qS0Zfg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6761.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HkhrewypscOglvX7ftiOVeCmL1suRQvJHK89F5+ha/nadLFgvJAkp5PACj9I?=
 =?us-ascii?Q?GrtQ0mRufb9WcZPPqzRhOuoxkgINxDyRH+Ws9Ce5iTd7il0bh963mVwXU2Sc?=
 =?us-ascii?Q?6lS0f0iOduQ7vzWayyMLtlvGS1/l8fVtQTn4XaS/2YBMdPNvxvlJAcf2nH9d?=
 =?us-ascii?Q?7OE8GnWqh6bTyqTD8nUEL0m0aa/KHA/J2TPAAaeJTPtbexR6i2sSFVrIOA/L?=
 =?us-ascii?Q?eaU5pEfA0/Jd/TRnZawixf4CcAjMBAnrdAbsfkrjlKfb3XrvGLKWgI2xxoKt?=
 =?us-ascii?Q?Gc1xckYMQZOqKtihYhYgNM+/WnEaGZJ5kVBYzkzgH48bXbqAVrbZ9mBwejEM?=
 =?us-ascii?Q?XYH63bLNNWpgLM/twGg4XZtu4gvbmpdcmrh84A5+RtEPYQg47gY7R7BH1UA/?=
 =?us-ascii?Q?KBPNmOuO2wYy9AsPhgt804P3dvzMgrNzmQrng+IF8yaRyCfo5vCo6MtVegh1?=
 =?us-ascii?Q?WWa1FNXJN+rmVgNcr5evEZtzPQXt8l8UT6Z8Fta74Bn4nertSPzh5c0zblP5?=
 =?us-ascii?Q?re6H5fMZsHiva1tQQdJUKYcWX3/L9m329SXmB5boTjFst0ZnFM96HYegEucZ?=
 =?us-ascii?Q?1b2RNKlQih+gdWmEySA29KZYj19ceKI5N2tj09GgNOUemUzikuLz9Q5ac/TU?=
 =?us-ascii?Q?YSNNi7t2l/ypu9ElISmhqZhVClgVuy2IoLL6xO2xREfHYZOs/Ex7gfqyA7eq?=
 =?us-ascii?Q?R9tIXWHk2ObATPcJXfemL0JPEFPycgaFW/EX+/uWygzNpX7UFuCB3aidbEcN?=
 =?us-ascii?Q?720ZMNsHxEnHgfhc67TWtaP31fMLJh8dryGw/RpieLzNsJzZZMIpHOp4netK?=
 =?us-ascii?Q?9W3brzRPcInqDvRBTrgIqV6/ksP3ykftLFuixQ2NKJXZ0XH370Yp5aIrqy5b?=
 =?us-ascii?Q?RW9920RaCYGsp82KxeyN7Ms+f+I4O0kVIRcq+GBY4jtRqB932RGfMJfpO4kV?=
 =?us-ascii?Q?qH3CwE45NIjZ0jlYa42toFjkr0rOKn5MSxtc21VeorfeF6jMHDdOaEM6ImMp?=
 =?us-ascii?Q?Zaix2R9ZpFYSY61okuARJPEnpcWOtnj9WbEmU2QVUG0595z9YLxxMcuytj6E?=
 =?us-ascii?Q?abzJt8+EOslLwxizCoZ/MnjXAH26FSqLlzi4GYfRVyTrPDtgAx/LuVkd/O6f?=
 =?us-ascii?Q?GfKpDMgtZwdjHy2+r0Ya6LATdb6D/PilXmjmZK2H7nObK1DsP08QtTeRtTfT?=
 =?us-ascii?Q?bwzavTGbvHlAEIt1u7+ol8HVPZHgCqQuU2NrLlpYSarIneLTiozj0EhjYDHL?=
 =?us-ascii?Q?pVoXN517XMjyE/Nwga4H+6rkIyktNHAXwu1plE1NVM5IkF+XGzW9l2eWiuIf?=
 =?us-ascii?Q?JOC2vWaF0cxFwaEz80FrBP38IIMAEkCgfG0XRNEY/ql21OjQBkIolTzz+McW?=
 =?us-ascii?Q?RjLLSVdKQVyqdbi2+4vstxBT6kbKdQdiAjeNPUNzHgfzMQjPQRlbyh41/N66?=
 =?us-ascii?Q?+EIukNtfJc2LEhgfsvTom81urczN3Uq6a/7sAnVkUqdvwl8/ACIh8Fwn0FLE?=
 =?us-ascii?Q?vYFtnMUDpi3yoTBT5jkVdp8v58KRnhA8pkgvE4nYtKLldlh0GiUhQmWEsOxX?=
 =?us-ascii?Q?7idA+G4tKKJD8g6qTRGV0dDD9j7BJljXf2r+0ZDDaiTZfMln0zckbQMhUN8/?=
 =?us-ascii?Q?WV7zJ2907ehVXnoIrnGr/Xk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 574c421e-6240-4e7c-5cb3-08ddc4fa55ea
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6761.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 06:22:42.2070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B72sw4yYMOCki3rsNSMsjBVFlmbVUDhdUTG/dy+JNmvb0fIXKvRi0O5ZY2haOEiwRMfxcamW6I82POaBPFq9WA8U1Fv5GblZefP6bTsio5HQdLPtCBDATC0LpFwHFkTp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7287

The two functions call common function update_sg_stats(), with
different context.

Signed-off-by: Adam Li <adamli@os.amperecomputing.com>
---
 kernel/sched/fair.c | 136 ++++++--------------------------------------
 1 file changed, 18 insertions(+), 118 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f4ab520951a8..96a2ca4fa880 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10529,83 +10529,20 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 				      bool *sg_overloaded,
 				      bool *sg_overutilized)
 {
-	int i, nr_running, local_group, sd_flags = env->sd->flags;
-	bool balancing_at_rd = !env->sd->parent;
+	struct sg_lb_stat_env stat_env = {
+		.find_src_sg		= true,
+		.cpus			= env->cpus,
+		.sd			= env->sd,
+		.p			= NULL,
+		.sg_overutilized	= sg_overutilized,
+		.sg_overloaded		= sg_overloaded,
+		.local_group		= group == sds->local,
+		.lb_env			= env,
+	};
 
 	memset(sgs, 0, sizeof(*sgs));
 
-	local_group = group == sds->local;
-
-	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
-		struct rq *rq = cpu_rq(i);
-		unsigned long load = cpu_load(rq);
-
-		sgs->group_load += load;
-		sgs->group_util += cpu_util_cfs(i);
-		sgs->group_runnable += cpu_runnable(rq);
-		sgs->sum_h_nr_running += rq->cfs.h_nr_runnable;
-
-		nr_running = rq->nr_running;
-		sgs->sum_nr_running += nr_running;
-
-		if (cpu_overutilized(i))
-			*sg_overutilized = 1;
-
-		/*
-		 * No need to call idle_cpu() if nr_running is not 0
-		 */
-		if (!nr_running && idle_cpu(i)) {
-			sgs->idle_cpus++;
-			/* Idle cpu can't have misfit task */
-			continue;
-		}
-
-		/* Overload indicator is only updated at root domain */
-		if (balancing_at_rd && nr_running > 1)
-			*sg_overloaded = 1;
-
-#ifdef CONFIG_NUMA_BALANCING
-		/* Only fbq_classify_group() uses this to classify NUMA groups */
-		if (sd_flags & SD_NUMA) {
-			sgs->nr_numa_running += rq->nr_numa_running;
-			sgs->nr_preferred_running += rq->nr_preferred_running;
-		}
-#endif
-		if (local_group)
-			continue;
-
-		if (sd_flags & SD_ASYM_CPUCAPACITY) {
-			/* Check for a misfit task on the cpu */
-			if (sgs->group_misfit_task_load < rq->misfit_task_load) {
-				sgs->group_misfit_task_load = rq->misfit_task_load;
-				*sg_overloaded = 1;
-			}
-		} else if (env->idle && sched_reduced_capacity(rq, env->sd)) {
-			/* Check for a task running on a CPU with reduced capacity */
-			if (sgs->group_misfit_task_load < load)
-				sgs->group_misfit_task_load = load;
-		}
-	}
-
-	sgs->group_capacity = group->sgc->capacity;
-
-	sgs->group_weight = cpumask_weight_and(sched_group_span(group), env->cpus);
-
-	/* Check if dst CPU is idle and preferred to this group */
-	if (!local_group && env->idle && sgs->sum_h_nr_running &&
-	    sched_group_asym(env, sgs, group))
-		sgs->group_asym_packing = 1;
-
-	/* Check for loaded SMT group to be balanced to dst CPU */
-	if (!local_group && smt_balance(env, sgs, group))
-		sgs->group_smt_balance = 1;
-
-	sgs->group_type = group_classify(env->sd->imbalance_pct, group, sgs);
-
-	/* Computing avg_load makes sense only when group is overloaded */
-	if (sgs->group_type == group_overloaded)
-		sgs->avg_load = (sgs->group_load * SCHED_CAPACITY_SCALE) /
-				sgs->group_capacity;
+	update_sg_stats(sgs, group, &stat_env);
 }
 
 /**
@@ -10805,7 +10742,12 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
 					  struct sg_lb_stats *sgs,
 					  struct task_struct *p)
 {
-	int i, nr_running;
+	struct sg_lb_stat_env stat_env = {
+		.find_src_sg	= false,
+		.cpus		= (struct cpumask *)p->cpus_ptr,
+		.sd		= sd,
+		.p		= p,
+	};
 
 	memset(sgs, 0, sizeof(*sgs));
 
@@ -10813,49 +10755,7 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
 	if (sd->flags & SD_ASYM_CPUCAPACITY)
 		sgs->group_misfit_task_load = 1;
 
-	for_each_cpu_and(i, sched_group_span(group), p->cpus_ptr) {
-		struct rq *rq = cpu_rq(i);
-		unsigned int local;
-
-		sgs->group_load += cpu_load_without(rq, p);
-		sgs->group_util += cpu_util_without(i, p);
-		sgs->group_runnable += cpu_runnable_without(rq, p);
-		local = task_running_on_cpu(i, p);
-		sgs->sum_h_nr_running += rq->cfs.h_nr_runnable - local;
-
-		nr_running = rq->nr_running - local;
-		sgs->sum_nr_running += nr_running;
-
-		/*
-		 * No need to call idle_cpu_without() if nr_running is not 0
-		 */
-		if (!nr_running && idle_cpu_without(i, p))
-			sgs->idle_cpus++;
-
-		/* Check if task fits in the CPU */
-		if (sd->flags & SD_ASYM_CPUCAPACITY &&
-		    sgs->group_misfit_task_load &&
-		    task_fits_cpu(p, i))
-			sgs->group_misfit_task_load = 0;
-
-	}
-
-	sgs->group_capacity = group->sgc->capacity;
-
-	/* Only count group_weight if p can run on these cpus */
-	sgs->group_weight = cpumask_weight_and(sched_group_span(group),
-				p->cpus_ptr);
-
-	sgs->group_type = group_classify(sd->imbalance_pct, group, sgs);
-
-	/*
-	 * Computing avg_load makes sense only when group is fully busy or
-	 * overloaded
-	 */
-	if (sgs->group_type == group_fully_busy ||
-		sgs->group_type == group_overloaded)
-		sgs->avg_load = (sgs->group_load * SCHED_CAPACITY_SCALE) /
-				sgs->group_capacity;
+	update_sg_stats(sgs, group, &stat_env);
 }
 
 static bool update_pick_idlest(struct sched_group *idlest,
-- 
2.34.1


