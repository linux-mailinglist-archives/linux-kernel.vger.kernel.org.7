Return-Path: <linux-kernel+bounces-734682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A282B084C3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C0B5820C1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384962153C6;
	Thu, 17 Jul 2025 06:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="DfV1vU7d"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2104.outbound.protection.outlook.com [40.107.102.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A2F214A8B
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752733300; cv=fail; b=fvvjBFsD9zdb3V7BwOT+86+50dPluyXxy19XR9ovxWI6f9xm3TsO2p3ykT+fH2XYEbTAksENWbt5QtSPeNQQ0Wl/DZIfRkDqsImGLwK6ph4aCMM/25x2s1kPdDiKr0pXE+CP4JWmQWHaafWKVogmXCjJGRxYCf81Ju6czXNiGak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752733300; c=relaxed/simple;
	bh=/Q2stqyjCUUFjqBwhcD2UbzsqbjWS1EfrJcF94GwPQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pIe/D8RQzaaJ6PDfc4446XMyfHUd+7RlfSVAfICHJn3XTLbyfqRJfiKyvNOFj+SYbR6eZjYz+13yveY3gWistHAAGYJPct1tsKJMZl7aguv8OhC10N/KJYeSP2SPkV4AFKmkJmjasnCzppdIMfdz9eOs/ONqrqy9o3BAhRFRIes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=DfV1vU7d; arc=fail smtp.client-ip=40.107.102.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ex/N+TjCd2Id0EX6dKWf1LXM8JiSTc0XfDZe+qe7PYICeu8vUSzit7BV8CmXERs0tQkhPlI1+urKIrHCtloiSDFqAZps3RfIHUbmRKnC6ncorpZvwS3yzwJecwECj3R5DISPNJwAJf+nsC7EPa0e9peYXXfX9lC+GAg+UJjTrEvPRp6YZVUFu1VyeEwQtrT+9JZ34Lg7toSx1Yp5qZEi3Hq+EnN+bhi/uh96+66CV9A8ePkeXvAONkwO6q/M8Q5UW2VouTGCBggoTZsObYR+izcSmbUaLL+1HD1M3DskO/X1t9I4R2u7ICHVXaSbJMnGgzpB2TW4g+APGLpPQtjCtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kI7QL4McscNYNbiEtk9MH+eIEFYEvUdI+HqMZGVAiYo=;
 b=OupNS4HFLrUA/4xEFKkdvycdLq5q3xcixVUVb5o86gRYI9Mzw3QDeIOj3l9t2cLAHRub57CTCIieY/6kfKouqbtMss+llr53+/vaBBFIJ+A7Zkz5v7yJPlH5awRQenS1aN3eNK2ARbBGOpRPhM60x0QgusHQDcGZseaR3aWIoKJniBErTRzbLIBfoZqJtyRb6kWUk4TbDvFNzTZqV91v/Yj7jMp6+yZ+P+2kffSdY5LehUm6hdia20TDkV4xyafCCC/4i+Qn9yVpQuEO+RSfSo9P9K3J/kXQf/rcbOkm842fnaGk852c88rnZJ504L9kJjNg7ghM/niZbt7AImP92A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kI7QL4McscNYNbiEtk9MH+eIEFYEvUdI+HqMZGVAiYo=;
 b=DfV1vU7dM9GfONDX/1dBcQL2mWfD1NHm87g+lPkcTqy0CSgUvzFKmBCVGNsg0WZQmFQMVgsNFDzUWH0bMj49dn2xieIGP0GbMSV3//ofCUf/gpRXT8KwQ6e/Am0awK567jbnKZfFImuNojq220xTvt/Wl5D/K+iazU8RgHbG63s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB6761.prod.exchangelabs.com (2603:10b6:510:76::23) by
 PH0PR01MB7287.prod.exchangelabs.com (2603:10b6:510:10a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.39; Thu, 17 Jul 2025 06:21:34 +0000
Received: from PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2]) by PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2%7]) with mapi id 15.20.8922.035; Thu, 17 Jul 2025
 06:21:34 +0000
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
Subject: [PATCH v2 1/6] sched/fair: Only update stats for allowed CPUs when looking for dst group
Date: Thu, 17 Jul 2025 06:20:31 +0000
Message-Id: <20250717062036.432243-2-adamli@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717062036.432243-1-adamli@os.amperecomputing.com>
References: <20250717062036.432243-1-adamli@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:990:4::12) To PH0PR01MB6761.prod.exchangelabs.com
 (2603:10b6:510:76::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB6761:EE_|PH0PR01MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: 88717ca3-b987-4f21-182f-08ddc4fa2d64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rf+cxrmk98K50ePGN40bHKpx9CDC3IbVJJZqLeP7lHKVfjX2KF2TKe1S8MF/?=
 =?us-ascii?Q?aSvHZ3dMxUJskBupRwyra9sgAdoJxw0r2+JRydxNejJJdCovJFuEmIREMbbR?=
 =?us-ascii?Q?OcihrgPzMcqCg5FjAcgM19Nwc19r4M2EK7ioQv1N+MtHgJCLWi7gWKN9s2pm?=
 =?us-ascii?Q?e9wEmUoC5h5gM7N4MM1rvTJhPgzdbSBYHbXJBMDp5cp1uXTfx77ZVrW7UuQB?=
 =?us-ascii?Q?NFjvnOlMhbPDr4kOL90TTyWq2N4LG90bO3dtvGie7GYbahjwc1DR9q5q5hzW?=
 =?us-ascii?Q?5KWNSpzBREw0cmmf2QxHWBo3kmzujfmvJRb5ca7OyrF8kSSyciPmgTcUCYm4?=
 =?us-ascii?Q?rx7Na8bb1xz38RVNplXIAYRiJO1vBw+JTGm3bAA2+sBEPzQ8p7rt36fbkMBM?=
 =?us-ascii?Q?2QBqrJFtTKZ1yTErJ/XKk1WZoFndhdd29i4yMqY9sxxugm1U7zdQa3B+5diz?=
 =?us-ascii?Q?+Uc/IRl9ez64c4z32Q2yLRpcjUrL6Ul+uETMKJgbtBMuWffB0E9ouv4EGPI/?=
 =?us-ascii?Q?q147o1A95DY/2+7olfARCx3EplXO9kwpu2q96BfNKIWanCTXNVr0QEMODuhG?=
 =?us-ascii?Q?NEkre333I0ZVGxn7IqvLAoW1b6DAnClhFxesR8eR8aI4ufVc/oaU8tfIKGfg?=
 =?us-ascii?Q?brudSj/jUw+gaSeq99ILNFETci3pBWzEjycXKUtYzn0BplOZs00RIX4pVTkS?=
 =?us-ascii?Q?wzNC+0T7eXMBXx8jHYP1HAFC1sq8MpeG0ZgUkIs7afzZ4Ga5sxmAZ3yNT5e3?=
 =?us-ascii?Q?R/3jxh/vF+RLbTxX/6zW8ZiRZBkTzHyayYOZzJb+PYZwPpsZMltl0cBbgrB/?=
 =?us-ascii?Q?cRsBtdl/bCJRqG/14XhePJhHUw9UIUYB+99h5Lsre3iEy4nu90qGBAytraHa?=
 =?us-ascii?Q?dQze4K1sAg3SB971nr+FuAL5TB3mBvdIcV3BQH8howcwZJ9rLvwbElu2F0Rj?=
 =?us-ascii?Q?Ex+T4kb9hMBoDckB23+LQ1jpO6o3nFJ+btmiW7cDHIYLlUtuEdFS/xb7bO+Q?=
 =?us-ascii?Q?rzAaXrdybA8HguF1u2bt2e4NCzCouKey0nDu+/b8Nw21dIUsDggAo8Km77uf?=
 =?us-ascii?Q?9Si6mwxeNdlP+DcBExCrJIVWtxRY1nQVS3XXX9X+nvbXugneIOhHq/DnMiAo?=
 =?us-ascii?Q?1TFSXVJ8Ztx1ARUIQSz+fGAEpQqjOQi4wiFF1FlkEUWms7Sy75nIjrHlrecC?=
 =?us-ascii?Q?H2T/lUWeYSN2dPq3AlMyO7f/AwlXfjHqVZfNVGFX0bf0HlaCLYJ1V8VRJ9/w?=
 =?us-ascii?Q?TEjRGc6Q4cgHKBau3C8cm9HgcIXEUHjaO8WhEe4Y7Z5xq+iQmF8xz6cTYaUy?=
 =?us-ascii?Q?UldClJREB1le47FQHP6tvH60VDrxGcql5QJ4nVC/GAw9FzJyX0z9VZIozoKx?=
 =?us-ascii?Q?HEgWMTQiJNeg5RQYHAFAeOsdJv7tF0dIKWLlq6cfi45C02xpGG+71m0B9IJJ?=
 =?us-ascii?Q?+7M3eKC5s+6TopEgynyKBSLCxHYUOukt/ji0thInLnW8WB6Z+TsU3w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6761.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Y4XyJwzgU+FkCqQ/vadzhupMkluWWyZPLn7xcPy5i3MJO7c3CvP4oYz37dK?=
 =?us-ascii?Q?eKPpvXt8YCZjtCcFuEBkf9E0Khhb8YTaFNqCB7OTVZawoiylvUOLdljA76fz?=
 =?us-ascii?Q?Yy7rMfMqqiBK0PaOMtpqjHJ8jWd7xFDZ//xYmJCdXlPH9pcsYzRbK0uXbpgi?=
 =?us-ascii?Q?UDSXHMq0BaJYDBqobYpzOXno0FsVdEzbhk/vq90k0RUNcc84cUjpU6r9gEg6?=
 =?us-ascii?Q?vCmPvInfGVAX4drtVjhq02nrSJXbGwBu2VuFY/TXi8gH6ELmLfvJD22+9FYX?=
 =?us-ascii?Q?o2ZcXt0rjHEUf81xLiGeCP2LIAMOeP7yyDFVzVvgWHW/c+wxRfPq75b1QzM3?=
 =?us-ascii?Q?45BsivxBR/6FRpphuwIOisW99919TDHmV9sEQ6fbHP+oIvyhgEzlL/OYD7uN?=
 =?us-ascii?Q?ybex+taZJUTKjnhFYwBT6xJdLXdgRq9VywZUnnMMG0mQmeGvr0kswo0y87OH?=
 =?us-ascii?Q?WwnLGJ++Hm4etk4tiKpo6wDGuTqGP+8xssVrHPVftoCG5FIMW3HSruEWGumY?=
 =?us-ascii?Q?EqSF5F8J/Zy+5LFe2J6TOB1ABKPh8lrq27nptswgU7s+X6MhSOF0mso4JvIa?=
 =?us-ascii?Q?qyEIv40tblB7BeUoLzdT4EyVFYGARRlObPSGvB/CtI0oI/IJD4zSScCahLQ7?=
 =?us-ascii?Q?5Za6gUzMPjDs/t2NJdfmHGUZPKw3KPaHdeQ/9d370w03USEAj9P4rh2Nb+P6?=
 =?us-ascii?Q?cIpXw4ZPi4QtuoM5CqK/zNZ75ZoxA/hsXswdMs/ax1HgDQEEH5bCSgAJbLj9?=
 =?us-ascii?Q?Kp/tAhYe7Ud0IrSkNm8A6eF6eD8BOPwclJK9NJO2Q8kTf1gtDlb8mRJ8cG3t?=
 =?us-ascii?Q?W+JBdMiflr+TjtQvTWVRiBocY6UlewA2k0mBL62lrfcL6jilrhrEoFdpAR7N?=
 =?us-ascii?Q?lp6S5BHT6xzeq8A38uQUY3F9Ek+KrGKv/AQoV1iL0ifInBHVXQiXzvIgdpD9?=
 =?us-ascii?Q?/54NLO9U3xN2+N0ziziGIJZ7++YGsv2H6TgJSq4QbDWHmJFYpO7kGxL4DafV?=
 =?us-ascii?Q?mKgyrawabORp5QnLyTIxBGso0E1EdlgKHZEFIirP7YLoJko/R9l3XAPEFG88?=
 =?us-ascii?Q?Az/TGWtCJAsunmu1MwbNTJpZs2HzLADC5dqmOkAS8Tq8sIvRCEF6hG/3JwLA?=
 =?us-ascii?Q?9vXWqlX3ZhWCOWqKKO6OEaC9q0rZUYVjXvbMQBdEzi83/zuNdrTZh6UZllha?=
 =?us-ascii?Q?uOZfjRZU0WznTdW/nrxujAEcSlcVLTTDqBQBLIzu9HhlYRmH3DpwACmdXvkH?=
 =?us-ascii?Q?dUW6I0rmlRq60hFQ0egjoveV3ccZWP7jGLMFcBAYQTxhjd0jz9izSHKX7IyU?=
 =?us-ascii?Q?sKAFvn7GF86AkI6in3kUXKiJhtoVMBfeibZQQVxFDKt9VWF2118drLIwvORO?=
 =?us-ascii?Q?6AmL7ygF6xebUx2+0jHFmJ02zhVphNx/XZh/bARMepdiamnap9FZxgf22u7f?=
 =?us-ascii?Q?W0Q1eBEuB7yKywd4GKEW0sLlKVgXdCRH/Uru2nCebEFOUlg2YSu9DsLlZaHM?=
 =?us-ascii?Q?fhsBDwB/+mvXC+2hcFESbDW4F9G2GEd/+WJXV0HyGsnaER6hvVsXi9wsXcdE?=
 =?us-ascii?Q?f4xch0jXidU5Oqmuxn6R3cNuyXIcllsYg6uFsH0rYFoflkEml1AEl6Z/XSNH?=
 =?us-ascii?Q?Ya7Ot84vchCDHOiYwuXgmgI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88717ca3-b987-4f21-182f-08ddc4fa2d64
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6761.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 06:21:34.2428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6iOy4qUv/stjl6JsvjAHvIajA5Hm5U7b0vGqKc22lSkEJrWFa3Zw8JSiLoc2xAXzL0GAtdBKtEt7BQKtLKf1g5biI/3Bn1u2eVXt4xchLAyoh7YgUbu8EnLUUX0iiaZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7287

A task may not use all the CPUs in a schedule group due to CPU affinity.
Only update schedule group statistics for allowed CPUs.

Signed-off-by: Adam Li <adamli@os.amperecomputing.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7a14da5396fb..78a3d9b78e07 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10693,7 +10693,7 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
 	if (sd->flags & SD_ASYM_CPUCAPACITY)
 		sgs->group_misfit_task_load = 1;
 
-	for_each_cpu(i, sched_group_span(group)) {
+	for_each_cpu_and(i, sched_group_span(group), p->cpus_ptr) {
 		struct rq *rq = cpu_rq(i);
 		unsigned int local;
 
-- 
2.34.1


