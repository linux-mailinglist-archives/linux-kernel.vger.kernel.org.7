Return-Path: <linux-kernel+bounces-774776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A78B2B75D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 04:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5B834E0D3F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 02:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468642BD001;
	Tue, 19 Aug 2025 02:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="tsNC7cQt"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2137.outbound.protection.outlook.com [40.107.92.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAEC13FEE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755572268; cv=fail; b=f5RcMoJaDbAl9j3pjfnyHLOd2OLnIqeuWBHqrAVADsVdZtmF3TJ0tdOPcQlBtn6ndcDPwhrmQAg8M4PH2wIxV20+xl/ja2/Haq5UJAbuGAdg+cOafCK2liNVI+Fzp9oAn9L7Uerz/RIGEmkoJj9RYxbhUOQdqYCoYluq9bvLM0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755572268; c=relaxed/simple;
	bh=XPK9NxFHHzpaU2mRtb4b4sXT54NEhPRK4yKq4EMVIYk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pydyADaZZIzyrHggdNa8xSFShGXC2bfYL90ghV7ATyBUWwarOJKTPlwmKu261/kfEtz5A9jC1FQX0vPA43CA0M+tEbcEfgFu9u97YFnmUw7+udKafub7xm+/uxxxoeENBK5cb2z27/wVHtFlb83Qsgk17erCw1oJV6UiJ72+TJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=tsNC7cQt; arc=fail smtp.client-ip=40.107.92.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJ82ne6NRtBF8qVTig/GYqYHUTTpEtDBEcWleIf8al6suNwJDHq0oMrfe5awNu+pgHFNZ4wZ3WDKaN0vMHXoosriL66U7rWndsUFlJ09DlAkmIobs4N1RQ+Jzeq22pbfFbKJ0mYQHZogiMH7iRJ6GyJdjwfeFYRTAP01SlT53rXZBry1NpopXBt5yHNN+Ven20YGBIZLLyRXXdSpNuwAFgMzgJGT6BWWAeJnGnf2Pe6nWyUsR3yNfJoRQ3kp/VKhavTYLWQ+H79hlmStdgwEdBdddYKKfUljpWKpXKREElVBp46WcGv4jD+MMeVHS7E//UOeKvE64mckQMg1wkDa4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/1TSDid9jr3vvBfgY7+3J7VezHfU4YXmjB6+sEV8Zg=;
 b=i6nCiEmVicQk5rhrPhEcZSKNJbKb5xbdMk1ISjynBUOUzBkJqo8ByggCImBapsQVnxB5Wcx9Ln0P5apk9YPX6VRhYW+1sQfoh/OxN1MgHSBdYMflj+iAdhxPpmuEs+gv8iV7jOZlfepp2bEctMhUbMI0FKW8W7dBPwEmsGfx/da2MJgWOs7K3zw1wqrpl4d4iPXG+pbMB/Y4v9RJLoZ2+joZuZGmir0oYFIVQAIVMb1OduVOlHLJsV2JTG24Z0y2yh1KQQnH3omfa+w+0ID/lhDLWfyRAE3JKtw2MUlc1enELiF0AHu02gHtYnf40EnBCQq4v2xP/3JzWN2rxbn+vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/1TSDid9jr3vvBfgY7+3J7VezHfU4YXmjB6+sEV8Zg=;
 b=tsNC7cQtHOY9ibp6mUKN34cSOG7Oty0gaeLSRvkCMp1V3IcgkbBtqPSJY4CGAL1zItIPwtnufYGfLoBmBVGl9nfmLF0Ww/u7ZsjFT00hPZkceA9afCTNV3mFsDLrlyDL1CSdmCNpKz5zTZ3vnmhttG8sYItxrfLhgbvYhs7fCXw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB6761.prod.exchangelabs.com (2603:10b6:510:76::23) by
 SA6PR01MB8732.prod.exchangelabs.com (2603:10b6:806:40a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Tue, 19 Aug 2025 02:57:42 +0000
Received: from PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2]) by PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2%7]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 02:57:42 +0000
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
	frederic@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@amperecomputing.com,
	Adam Li <adamli@os.amperecomputing.com>
Subject: [PATCH] sched/nohz: Fix NOHZ imbalance by adding options for ILB CPU
Date: Tue, 19 Aug 2025 02:57:20 +0000
Message-Id: <20250819025720.14794-1-adamli@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0178.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::9) To PH0PR01MB6761.prod.exchangelabs.com
 (2603:10b6:510:76::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB6761:EE_|SA6PR01MB8732:EE_
X-MS-Office365-Filtering-Correlation-Id: d02d4fe2-e12b-4f66-9fb5-08dddecc2a3b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0eQ+uBHVKM1jyyvjY+qQizijvCO4YS9pwsCXbYLhSRGyzMIPByrvXyFy4Avi?=
 =?us-ascii?Q?6UUnLykXczQofC5l652+c66zp8s67L1EqK+L7Lpgt7+HiKjwY+FD2XKd5yXO?=
 =?us-ascii?Q?G39mnMxxzQMV9nOZO//S/rAtmc2YjlFtMzBwWKELLq/v2K43YbXQW01gGVuQ?=
 =?us-ascii?Q?CC0yf/Zu0hvtViRpowlqh7CUfzexWU8bSt6dkeMWxPmzLvLjUQUt9RKHh00Q?=
 =?us-ascii?Q?zoTfCXvyEOC50JEPa3aGX19iIQwTe1f7fzuTV5VeFHgUIsdlyuOv+rnpLfSw?=
 =?us-ascii?Q?IJL+/2A3IWybKngwdddHDVUS1Fh62loYYqjaCgqyPO0HAhUopwHHFViQF6sj?=
 =?us-ascii?Q?7sAQ0TkiR+kbPxXE87C0jl31GwgAit4FSIuCApKD6I9tJin/3TLqzi3rOF4l?=
 =?us-ascii?Q?1azaF7GSNRowdO3heM/hMhk+iaInrEc584T6fKkNkw2k2DLcL1S2D9MnfRIq?=
 =?us-ascii?Q?iVvZV3lcdwUiOBGMW7g4WQQ+DGI2BctcTwI/AChlaXh7KUEc1NAaG/iojjSw?=
 =?us-ascii?Q?v0iXYF31Mu4cnvmq/V/HeYDhzmwETL56CMn+nmIpQAE9I+2XpH/wEFmiLvFw?=
 =?us-ascii?Q?7OCKa0n/Ijyn6Zmde98TluoqK0C/U6plIwbk6TzQxz6cZQrRE9r34LTvxpho?=
 =?us-ascii?Q?sqQmrBYHz+qJjBjQ5AlpGY7icNMSX52eMQBAz6aOcwqurUhnLBOhdWkG/05G?=
 =?us-ascii?Q?+nHyf+NhBXtaiC+YRixZLUaMn3fIBgHCWUPRRH8ASLyaKs8QI6Zih9+qXgXZ?=
 =?us-ascii?Q?PTe1O09hYdy47Ahjt/Wb9kwcT8+dFkk74QpPRdI1wRiYizHnr8KFVgqgCzDI?=
 =?us-ascii?Q?Yt4kgm+SGrt9YpiYxowCyNx6MZgsnNzD4sZ5UpJHp0dB3PvztoVcNxXn76zQ?=
 =?us-ascii?Q?UYO32k2OTlPK7LXjqBFNUn47DYy59+XXL4C3SOuVvXBtZ9XBD1QvhdOqsxp/?=
 =?us-ascii?Q?6DQKlYEg/TxO0IrSMcJignalIT3pAammLzp2H88vEDWdLBjxlVaK3VIk/qhn?=
 =?us-ascii?Q?U5hQdP+IipAXXdM2NzYSEhECj5CjMgpAYVEoLiyIRFZ/VxFAedBtSlanEOH7?=
 =?us-ascii?Q?FM2gqGZFRT5D0lSbmxcslrEQNKPguA/9+t9byxGESFoj7GKtDd6E18yZYLIK?=
 =?us-ascii?Q?mbGZwa2P5D8F6DkvpbsoyHPm41MkNd0flBZPOB6hsN1T7XDb6sfwDvamSSUF?=
 =?us-ascii?Q?7FWoGi7Zw+TRcDrmz1ifRiK3tmK29HRUQWqDS8QGKKdY/5/bV7IpLO3vZuv4?=
 =?us-ascii?Q?Hs8Ls+ejgx6lKG5PO679A9dMx0cwtkeePh1KAvqlqdhJHzsAaZmC6QtSPm+j?=
 =?us-ascii?Q?sHnqOzYTMJqODT3cyb7piLPdihhw8fdYTLmyIwYqbdfuA+L3fRDZV4q0bQl/?=
 =?us-ascii?Q?jFR3s21z1SHhMJUxhgAI/17kw8WFbtXVtYiwSLJxNKqd4Wn1HqmbBgZxzNCa?=
 =?us-ascii?Q?LbSEaXrPN9xc5qx5QZJitmtS3+7xKolphdKvLP7wDwGYFNBApumGAg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6761.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(7416014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5FLV5BVWNV2xoyuX69QszCPVDuNkvkOfXl/YGLb2wjbGBJC5Z4T6kxR4YO5r?=
 =?us-ascii?Q?99KKYAoI+ohrbHRbxTEsd7Xi9sVE6AnMxYkxTgz4Y1AEx4qLE0csxE/maI8x?=
 =?us-ascii?Q?oDUdLcW2HFyncOtRixqDxGdsQWqs227PZYWPhbCkjQBDbIowIg8xjgNg+Udk?=
 =?us-ascii?Q?Wocm+ndCqCaNjDgO+BTtTiIxoGagYPHdK1/8+iBTFoO6TN8IyEVKxqngGyTV?=
 =?us-ascii?Q?gdw7uGPwEU5xARGzkYJ2Y3kf4FMqcm2dw8ZWNB5B/MShVwv7TiGYMvgnPHk4?=
 =?us-ascii?Q?XJjX1xGimrb2ccIVs6Gus5zrOOPitP+tlKI8M93OZAzjk5MggBF3WKzD6anj?=
 =?us-ascii?Q?Ymdn4LXm0hXkfRZRaz7dZkJlAghFctnxemmjyDu69vBH5YGDjoQyLrFvK3PR?=
 =?us-ascii?Q?00n1cBrx3iVtiIeDV3l+zL1o7yotxe7nsLbqSWPmF6VpBO8fgluirt5j3D8W?=
 =?us-ascii?Q?7EverH+rWZXTv3BZH0xjsy/Bzf30YgV5d9uAy5HLAT9IB6ExI2mKy5bvaYAs?=
 =?us-ascii?Q?oR8VTrXXsc4lqTbrtdHKEDTgmvq0oSvx+SLrEjGBU3ObhMW6JwDl79UWgzvz?=
 =?us-ascii?Q?DvjXf/fxe5gedIUFCJlcHyefHycJUIAelnw9dtaMSNoMl05lPiX0PyRUzYmY?=
 =?us-ascii?Q?QpCdkov08/VfQWQH9QlEFw8kQz1AGJ7mUQXtT/aXCO48aukhp1pSbSY24rJD?=
 =?us-ascii?Q?uI6Q+cvusug8qkDq0l7mL9apYahM0Q7lfTEl5kjgW9Y/SGl6+tVBlkbV9giT?=
 =?us-ascii?Q?/it1fdUlfsC06CHQ7pinKSiKiTKFiDFMbb+FrSs7aBdcPj3kA/PD+vvumuAG?=
 =?us-ascii?Q?ERNQ6/e5Mm6Wb/DjkqePD7qANFq62SS3ni4PU2NY1452m0ncLbTSpwliimus?=
 =?us-ascii?Q?c4wKGflqb5ARTb5ZmuXQVCROf/smnv9V8OmHPVlaHNpi4QEb1Hwd/vV1O9Ii?=
 =?us-ascii?Q?1tnj7fEQX4IUfnEuVUzWcOvJwnS5VVa5GkKRmgK/CXTKxt0lE76NvusMQ5rf?=
 =?us-ascii?Q?l3PIyqoMUJiSFHopqsekAJ8uL7GjugGcAtJq7T9yu7k8kJJWQTO1JBTJwiIV?=
 =?us-ascii?Q?KU//2VrOPpsw6xEaHjYb5Ajl8/iUmRP35qcGgs+19lAVQ2+T9fUhCg1Q6FNM?=
 =?us-ascii?Q?JirPobZzMrqP8IHOt5rY0P7AvlKA6oNCadwBJ6z2b6wNenn1ijzt1VdE854K?=
 =?us-ascii?Q?rd5FWsl3hQej96diqFYBjGVjhtKom62HdDgRNPLgx+BG99i61DH1u1j1/tfv?=
 =?us-ascii?Q?YTTYjlVllW+QgRXR7lt+Y8JDqFws0mohpSS0gJrSovrUCvvsA45IzZFAvD/l?=
 =?us-ascii?Q?2vAbYYFqlinZI8j+1wMh8bEJsVyjQctynCLnpP4WavocP9ll+tV6hQTpaF+g?=
 =?us-ascii?Q?VqKtS/94WlCOQb4vDuyfOAF7QclulXErCjXCWa9FtmIsL0HUM6unleRlxNdA?=
 =?us-ascii?Q?Hp1gCnUbpaxcCKErOcnObY7HihW0+X7Y8i2PBxPtPfNv/91QWMR0zEIarBwh?=
 =?us-ascii?Q?y7LrtExA1/0+pWkDdFh5lv6oCvUMOBmCyPQyUnAayJ3hzlxg8Pm2wrf11H1X?=
 =?us-ascii?Q?lKUzFjF0b6GCTX+CJIYqHiB3OJg1LczU90ZijxdhM/fvTuS/9y1zDXrx8DRv?=
 =?us-ascii?Q?u6Tnr2yPMu24pSd+WwdixPo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d02d4fe2-e12b-4f66-9fb5-08dddecc2a3b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6761.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 02:57:42.2417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L1iJtD9PFnjLMQbS1pt9CetetICdm6SWufUegSiyqTwe84j/59gXxdBSI41UmSdigeDGFcRgVUI9VT934EaAZx0ytkeQJ8haH1zVxoLCMxF4XrXqlCY66bV9tzB6hH1I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR01MB8732

A qualified CPU to run NOHZ idle load balancing (ILB) has to be:
1) housekeeping CPU in housekeeping_cpumask(HK_TYPE_KERNEL_NOISE)
2) and in nohz.idle_cpus_mask
3) and idle
4) and not current CPU

If most CPUs are in nohz_full CPU list there is few housekeeping CPU left.
In the worst case if all CPUs are in nohz_full only the boot CPU is used
for housekeeping. And the housekeeping CPU is usually busier so it will
be unlikely added to nohz.idle_cpus_mask.

Therefore if there is few housekeeping CPUs, find_new_ilb() may likely
failed to find any CPU to do NOHZ idle load balancing. Some NOHZ CPUs may
stay idle while other CPUs are busy.

This patch adds fallback options when looking for ILB CPU if there is
no CPU meeting above requirements. Then it searches in bellow order:
1) Try looking for the first idle housekeeping CPU
2) Try looking for the first idle CPU in nohz.idle_cpus_mask if no SMT.
3) Select the first housekeeping CPU even if it is busy.

With this patch the NOHZ idle balancing happens more frequently.

Signed-off-by: Adam Li <adamli@os.amperecomputing.com>
---
 kernel/sched/fair.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b173a059315c..12bcc3f81f9b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12194,19 +12194,45 @@ static inline int on_null_domain(struct rq *rq)
 static inline int find_new_ilb(void)
 {
 	const struct cpumask *hk_mask;
-	int ilb_cpu;
+	struct cpumask ilb_mask;
+	int ilb_cpu, this_cpu = smp_processor_id();
 
 	hk_mask = housekeeping_cpumask(HK_TYPE_KERNEL_NOISE);
 
-	for_each_cpu_and(ilb_cpu, nohz.idle_cpus_mask, hk_mask) {
+	/*
+	 * Look for an idle cpu who is both NOHZ_idle and housekeeping.
+	 * If no such cpu, look for an idle housekeeping cpu.
+	 */
+	if (!cpumask_and(&ilb_mask, nohz.idle_cpus_mask, hk_mask))
+		cpumask_copy(&ilb_mask, hk_mask);
 
-		if (ilb_cpu == smp_processor_id())
+	for_each_cpu(ilb_cpu, &ilb_mask) {
+		if (ilb_cpu == this_cpu)
 			continue;
 
 		if (idle_cpu(ilb_cpu))
 			return ilb_cpu;
 	}
 
+	/*
+	 * If CPU has no SMT, look for an idle NOHZ_idle cpu.
+	 * Run NOHZ ILB may cause jitter on SMT sibling CPU.
+	 */
+	if (!sched_smt_active()) {
+		for_each_cpu(ilb_cpu, nohz.idle_cpus_mask) {
+			if (ilb_cpu == this_cpu)
+				continue;
+
+			if (idle_cpu(ilb_cpu))
+				return ilb_cpu;
+		}
+	}
+
+	/* Select the first housekeeping cpu anyway. */
+	ilb_cpu = cpumask_first(hk_mask);
+	if (ilb_cpu < nr_cpu_ids)
+		return ilb_cpu;
+
 	return -1;
 }
 
-- 
2.34.1


