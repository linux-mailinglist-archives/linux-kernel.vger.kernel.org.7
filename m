Return-Path: <linux-kernel+bounces-778921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B22EAB2ECC6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E883BA4E6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 04:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D5A27CCF0;
	Thu, 21 Aug 2025 04:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="JF/6Vn7L"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2134.outbound.protection.outlook.com [40.107.93.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045B036CDE0
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 04:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755750480; cv=fail; b=IDhut6psHsqs3hcHGT/nnczyz/7rnOTozAwUMsazQwhlP/59zVN2G2FE/wxpQmlxCYHp37V0DAtzUYd1kdM3pmnmFeV3eAfG8iW9L71NRmjgKNj6+u+gyPuXfFJQS8rKwZepGp5vv1vycQIMPlSPjO5ygESMU+geApkaQgbiRaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755750480; c=relaxed/simple;
	bh=+FEEHa1Uhz9P2jW/y8toxxyZ+dJWgHnxk1UbeNTM6ho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mw2w5b8xMo8O89fFTXMIyafGDywRwS6Ezxslj7c0Rpy+cYEQdh4DAAN2jGWAAZBdfP52xDqUXuo/EUj6O2Uf1TG9CM1Ob64yWK7sGli1Plj4wOnIv2izE+r8G4Zm0KY4L2UYARlIjsrg0J6AsRcY+cJCjVxKn72RaTOg4sfbdo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=JF/6Vn7L; arc=fail smtp.client-ip=40.107.93.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qRhJEe+ZOi/8AP7kpYuAiYzQMtPnCkNXvaBUNODFylxeBYiHRqGDlEqM7ISICgdj15jH/TEbush5HTt41BJQzuflsxXEf41pNwE6V+pTkp7RWCbAuLwIyqjFcqppAbF3ljoBU2uSm6FEJeIDvHMRC3FLKP1i8aZuS8YRr5aPPhH5p/RkS4Rz9vxNiPd4lO8TiCKP6TeZeuG2wK6o+qyfkCEo9EQm6UoqDW8q4WCd9MLKwRTKjV/GwZ3P0kJxKEIAdJoa3tuQUQKYPy0Sv2TlpApMpePKGqS2j2p3K07Hswsq+H7xLRTIoztK6D1SEXtcWCOFqqkT9UeDyzf2Jv0MdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvItEv/6X84XuwxJhznN8kW4mrOxJNzbxryF9jSKiZs=;
 b=hipiJR9QyXeRZz6So/3+GRGOTQVmqyNp1ccmh6irAKEYcyY3xPQD4UJ5maj82VuOTtRiqhZ8I7P2zR6sbBK+ijyFTHBsgHiI/m4iqlM9Ar8fZ789LdrYpURoLRSYMiz+1qzp5qRP1SLRbOhTk63uTSUVudqnPm/hmP0LgVmCwWteLBzPxKN42AH+skKODs2z09YQyRAqPLLoq3HyUGcWxQinbZVrM6k6pPlvO4vXDxElo/KKfam/dIYAjOmv6qtIhj+0zRLiIs43GThWMcXRw1kEK3bTZHO918ushe9e4GotBWkBOC2R25ePtbimXuURgaSwJyeByXpkh9svymhQaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvItEv/6X84XuwxJhznN8kW4mrOxJNzbxryF9jSKiZs=;
 b=JF/6Vn7LoYHmGrsp2sJclx121FgkF399FNc+QvbrzreJdMxphuuceLkgfnHobmTvAYLMO7KPRKYvz0zXVnMWBQE6fhen7im14yGZciDITAXtBiDGzCrqWxQ7WQTKPss1WFceG2n5jtE7GBKy24wE7920Q9zYIW5Igd+JggBpdt0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB6761.prod.exchangelabs.com (2603:10b6:510:76::23) by
 SA6PR01MB8829.prod.exchangelabs.com (2603:10b6:806:42f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Thu, 21 Aug 2025 04:27:56 +0000
Received: from PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2]) by PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 04:27:56 +0000
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
	Adam Li <adamli@os.amperecomputing.com>,
	Christoph Lameter <cl@gentwo.org>
Subject: [PATCH RESEND 1/2] tick/nohz: Fix wrong NOHZ idle CPU state
Date: Thu, 21 Aug 2025 04:27:06 +0000
Message-Id: <20250821042707.62993-2-adamli@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821042707.62993-1-adamli@os.amperecomputing.com>
References: <20250821042707.62993-1-adamli@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:194::13) To PH0PR01MB6761.prod.exchangelabs.com
 (2603:10b6:510:76::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB6761:EE_|SA6PR01MB8829:EE_
X-MS-Office365-Filtering-Correlation-Id: 81e051b1-cf3f-4796-1357-08dde06b1a0a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p+x/ubPtTurCysyn/oIhLwJ9QEI1W5JZqHky92IoAP8EFoBYMhmEhRb8W/qG?=
 =?us-ascii?Q?TIAdxRCnkMY6STw+kg9OM+iowIM5q6AMKTXP71xLhFMljNIaKccddQ0bJJ9/?=
 =?us-ascii?Q?U4E47LsySP3JtUNHvaMc8KFcEAVaULPg9vExQpTHlpYwut67LY92e5sy1kE3?=
 =?us-ascii?Q?5neE3zHoz1GGKqhRdA9S+NgMOEq5Eyywb8Dv7h7rKrMWfH717bwfDhEMJiyK?=
 =?us-ascii?Q?HB2lrP+Pp7qJLVUQWddBUT1iYoKPQNmnn8vQP43dIQ1QNtXqyzUe9gYHnGnm?=
 =?us-ascii?Q?wnSuu6Xw02pFeQaTQG1Or+00Q+LXVl9dcd8Nq9/IgRuBHZhLjR5KjmJ2vOx1?=
 =?us-ascii?Q?kwAgDiivMrr/NPYkHOkWLL2EawZ9JXd/3nybrZD3CXk3WpIVVffUrtjq2H8R?=
 =?us-ascii?Q?wIn6dYVI7kU7HS7LGyNU6Mj1qd9st+NknJdTt3LOs9FdpK1QQSMSlm04iA53?=
 =?us-ascii?Q?hk4kuHneV/z7eHxLbkubIcWsmgRIE/+TIY4FvtFfos9vhbBXBipIs5+VKsMD?=
 =?us-ascii?Q?nteh7EtbvABbaCProUGvIECilmG+YgosSyZI2QrgRo8HI8T50qyvQJZgSPCA?=
 =?us-ascii?Q?nHq/DU03fEBCUEf1xpeopvk2cc1WFlf3YLxSkRnn4M2IOd8BhKLlT7Zv7woQ?=
 =?us-ascii?Q?DzDrXMe08XFa18yeR/76K9Y2IWzObErqj4XgbDhX4QZLmiCtW4mc9DVEfyyA?=
 =?us-ascii?Q?WJDZwrvZrL2ZJMLQbSPIRSH7m59lGvyvl3JOdW5AarU02xjPaiOLVKEGHU7M?=
 =?us-ascii?Q?Xj6k6TFWz/s/MtjBJmmUSLogmLluy6cHNwscoEDbVtPoH7MCJbWm/1HD7jbV?=
 =?us-ascii?Q?uyz7Gh5ChiwMUlOLV1WT+gpt1InjjyXdLiCsrWzIa++tMTSWfwCWaA6P/jGQ?=
 =?us-ascii?Q?OGlma8YJkNavoiDAautByGKO+goIdgOrhnqnLgqi03dKJLyQS46Oe9uLEdbN?=
 =?us-ascii?Q?bTGm5VtIYHpFqzSlbs8nl7FS/FIHGdewmFH0P34SdIuRYCNJgoPy3/PiCiXj?=
 =?us-ascii?Q?xFa8RxJo6A8+5l6hSpHXMUVtaBMVxefNfFMbg5BCFmnrgtWKP91w1X+ctTPv?=
 =?us-ascii?Q?JMZ7PYS2dc5irvk/JXumvOf3dizWM+qGAmEvAvvnMveTtsltQABLtdV+OJvO?=
 =?us-ascii?Q?Rd1YQ3nPBOiSEWz/7t1UBL65xVYYrEIu29MFZgeSvhfQFO4LKEal6n/cZG3W?=
 =?us-ascii?Q?cxpdLXT5BY+6dcdfOohzH7oyoBdt3Cqo3rHasqVwBoYyrlQ/7hkYagNKgrwM?=
 =?us-ascii?Q?1rmaYmD0Koc1pDJPaCuBaNWkSqWGtJ3BnUpQA88Jc51YVeCOwKs0nzOtkoXg?=
 =?us-ascii?Q?rX3hUJRrs9z0S8EVVokARodkmRWpGDru1PqEeMDmv1d3c6Nep44Lzj1Vqueb?=
 =?us-ascii?Q?IieF1hwHOn0xE4e/w9iJI0NOhHcye7zVjsLSL77ilBtYrKUXYmccgtS9pLV0?=
 =?us-ascii?Q?LwlE/KD5e6Ce6jyt2imkJGop+BArrtGNFiGmoyEI9k/MlXldqXhBUA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6761.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+2CTsiDHEjjxFMGHygSibKRYRz7WCD334nvbN1aNn1d+3J7cweV9A0zPP2ti?=
 =?us-ascii?Q?MKJdJ4dREJuFLASCndXDUP5IHnSm1Ax8mgRL3va9MSoQHwMV1lf6hJpQ5l4N?=
 =?us-ascii?Q?LrgDBNzTVfXNh25PRWvZYM+Ej+Pmry6ggLAH3EzGB0GnqU/at3BlBU6iggyt?=
 =?us-ascii?Q?t1x/6d56shnAf8aDRpEKjbIZjT92nv8cSzlGOI1yst2fZKfXzKtnwKwQpajY?=
 =?us-ascii?Q?gLZSp5z645Ddurt83hwxV521Hx+wQ6BOmOPYnRrj2c6pNRg5DjU0vbpZ3eKq?=
 =?us-ascii?Q?haTT2RuTMBGfAyCiQGltpUB8Y6fa8HeLtz+fcwVGrTAY3BioJ6QYJ28lKpDW?=
 =?us-ascii?Q?2AE0XTgrvJF/3hS6AjEy94Q/N5ajgEKg2xrwN7CChcL0d4VbPQ0bILfFGx/R?=
 =?us-ascii?Q?NkjTBadGdz/Re07wyqQaperBkdSZa9RE1yRUAwSYxet76zxjEA5/7tWVVKLm?=
 =?us-ascii?Q?t4HgHs6RJQ6pwmFRNfKGihRK6JWiUAJ0A9kC6a1KUeOBc12jka9Tmy38QLwg?=
 =?us-ascii?Q?ECaH3ErwXVxc/Zu+a3Ht935wvDNAeinVcgl06G3/hQb4+ay69YHPpYu2Jo74?=
 =?us-ascii?Q?+smPKawPSDLdP+mFb5nbdHjIHzoL9frioLRYj7oM2ScpUnDZLBCWYjTZbKsh?=
 =?us-ascii?Q?n+glBp1D37T8wCkAqY5Rp9yrhcxWcuvPcLHOkScVRWGAGUWvqx9LGjxz5nkt?=
 =?us-ascii?Q?38nV1tefoi5Wm+7KiA/5Vt+j3exi0b+bF+H/GZtbRYyxqAEt2WVTPLlew/JG?=
 =?us-ascii?Q?ShLoHthKIgktDBbdjg5+aLtd4WlnyWg7vrkhud7HFPdKkPf9mAo3dJMkGmeo?=
 =?us-ascii?Q?sXirEqVY5hkTGoieyjX5WANwzbhxCaAyhtUzBHtc7eV9rOYO9EODwBkN9mOa?=
 =?us-ascii?Q?L+BmAbyCrLyORI5V1tYXzTlrpuXoB1g1MttvJNdd7+rd14TLTMdBrYwDuMQ8?=
 =?us-ascii?Q?ctKYpQsx1pouCzBq3CEnMw/jEwAhP/5tbqbfmW8Z3b7bSbb3x5rtAffB3Xq4?=
 =?us-ascii?Q?YmiXUys9HZmaotponTRcnWeUcY/RXSiJ+iX21YETT4jh4vsHNPVmZivUpFyx?=
 =?us-ascii?Q?obLF+7SSqXGd6Cq7d8o9CqtlNSQNzqSROCD/zOT+8UnCyF90NB+pMRskG6Y1?=
 =?us-ascii?Q?xyUJIYawSTgvWwQ1ObGu2uca5IZqxnIsmVFZh7kMWvoMpNhvdyWXnc7zGUX5?=
 =?us-ascii?Q?TXd6uJUX8T2Cu+p6qWpYctfe72FHgPYpJMdI8bm0DNGlNoPhoEEI6s2Z1hUd?=
 =?us-ascii?Q?PCM1Csw5m93xFRWkHj+P4pcJTK1ayaSchYaCbM8V570fAUxevVPayofm9Yk7?=
 =?us-ascii?Q?8ix2lWB7rgmsgGcOdtp2Tnf3SG1NaixyV2TcwGiEzCZm2cEeywyxEPsS1B19?=
 =?us-ascii?Q?wPMP2k80tHkALaZzeWW+3xufGIWQXrk5aQ1elX5TcWg/uVqCepSpRP/RRkoX?=
 =?us-ascii?Q?v50etTXooolMJ/NXd0HKyfFbFGkpfKqRBvv9v987+0e6NFsA8jtH85WzsQjY?=
 =?us-ascii?Q?X/RgUQ33LRSYiJdCTESUCtAA2m3mLBoTgTuFa5TfQsHslg7SFQj4muEJRscC?=
 =?us-ascii?Q?FjFBwodGnZ13ZVRfzYQTcj3iES9zmb+PXxEiuanH65InEkk04PZ5SWHOdO47?=
 =?us-ascii?Q?FpM7NOI20pJrVdPUGQokYVg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e051b1-cf3f-4796-1357-08dde06b1a0a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6761.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 04:27:56.1174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wCj23+B0byr6m+CJVMY+jEWeKDcthXy78fl0ZqUJ1iMzHciFg/nw7xn0PNEcJMKAgNTEPsnAkAY/pQwKFSn5+I7Y1J6xXldkuuuBL1PguDnTpxY4NjfL0tTfT29Bl2mP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR01MB8829

NOHZ idle load balance is done among CPUs in nohz.idle_cpus_mask.
A CPU is added to nohz.idle_cpus_mask in:
do_idle()
  -> tick_nohz_idle_stop_tick()
     -> nohz_balance_enter_idle()

nohz_balance_enter_idle() is called if:
1) tick is stopped (TS_FLAG_STOPPED is set)
2) and tick was not already stopped before tick_nohz_idle_stop_tick()
   stops the tick (!was_stopped)

When CONFIG_NO_HZ_FULL is set and the CPU is in the nohz_full list
then 'was_stopped' may always be true.
The flag 'TS_FLAG_STOPPED' may be already set in
tick_nohz_full_stop_tick(). So nohz_balance_enter_idle() has no chance
to be called.

As a result, CPU will stay in a 'wrong' state:
1) tick is stopped (TS_FLAG_STOPPED is set)
2) and CPU is not in nohz.idle_cpus_mask
3) and CPU stays idle

Neither the periodic nor the NOHZ idle load balancing can move task
to this CPU. Some CPUs keep idle while others busy.

In nohz_balance_enter_idle(), 'rq->nohz_tick_stopped' is checked to avoid
duplicated nohz.idle_cpus_mask setting. So for nohz_balance_enter_idle()
there is no need to check the '!was_stopped' condition.

This patch will add the CPU to nohz.idle_cpus_mask as expected.

Signed-off-by: Adam Li <adamli@os.amperecomputing.com>
Reviewed-by: Christoph Lameter (Ampere) <cl@gentwo.org>
---
 kernel/time/tick-sched.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index c527b421c865..b900a120ab54 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1229,8 +1229,9 @@ void tick_nohz_idle_stop_tick(void)
 		ts->idle_sleeps++;
 		ts->idle_expires = expires;
 
-		if (!was_stopped && tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
-			ts->idle_jiffies = ts->last_jiffies;
+		if (tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
+			if (!was_stopped)
+				ts->idle_jiffies = ts->last_jiffies;
 			nohz_balance_enter_idle(cpu);
 		}
 	} else {
-- 
2.34.1


