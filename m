Return-Path: <linux-kernel+bounces-770295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5417B27973
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8690E174844
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 06:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DEB2BE7AC;
	Fri, 15 Aug 2025 06:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="uzbYWbBR"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2113.outbound.protection.outlook.com [40.107.102.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7B321765E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 06:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755240701; cv=fail; b=A0QlU61AzPjtdjIR1Ae1J6kAEpr7PUydd6KN3C5JjmP6WEyBFRtsxcAxAihz44Nd9HF737KJKQxN/fJo1p6qIR2hEBK2uvxTRwX9RvHj8AQbyexsckUfZ4140yOSrp+MLXQVev7SB8/AXudBcNuGJNhzYg9zQOTr8T0tTnKD+BY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755240701; c=relaxed/simple;
	bh=5F2ALG5JY6RBPwnZjvbT6cjIIzsu5kt6fQZU2q35WFo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=q5vOXoocFJTpHlpqMwiA/480a9WIh6ePak0SV24wZmwy2qkJ/5WLpI1OCvtEQ7Qll82QOoTbPXpk+bDt60Snyr1qeaUiqP0dvMJNcgZAsU6CoyDjmCz5judjO0qRXB2sP046RKRoPpuBRIZ4c8k3loHjbaYkWed7E1GQ5EGRfpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=uzbYWbBR; arc=fail smtp.client-ip=40.107.102.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rn45uQiWioBmSZeAU/BNC3wSAxtMxbNgoCVHEX6UHW6UigXoIQ+b+b7FjTNb4dgVj/HLPeKyVxQBNIyF0x4SL95R/YcjI0sVAwvEUa2q40c+ndF2HYdcclurron7KmvRFY6AnP23HES0i6KQkQnv61y2NqMnopmqF6IuMcylYxxDfdX2ASehX2CXVAhoRGYA8R444pXRqWDXYICOp3kS1kAqv7ri+23kjFiav8B1RaXFmMoZOxOe/LeLuwA3Yq7jUIQtPpCec8EONeYTDjeX04UzBcKtdLLhUFbl2SqFleo4zXokQvjKgiF5FxPkAuDZQtZwuv11uW0UyNuaAvr81g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ki8AlVcvVxsQ8RLmh9DXJ+37XyY3WKxZmkCd7HA5nJk=;
 b=vXXr6V5U2di0YdzftNY9fGp/k+FBanO7sFb7yBDOJ4D0gAAe5TkFJ7/1L/wC2yq+hvmTQTyUQ7XYmDWghOP1uiYrM2+fksdwOKeiBshJ9LwD36/6drpczChrAiiy9R9OsCSkalVq1ZcZKMxU4p7XQ1NVROvXRLYhTTimig/ZRrD3sj5++oFRvg2Nwl+97kEK4c32hNKGLlw7dO8/xEj88MrMx1uDGdg+tJ03Xu/EM8qsUiHSwaO4od+iLiHw3CY/qqE8etBqFAsLcb/x4Lt7rDxsQlQUOGs97yQN9dq6KMfpgFp7HkuQaBbOPQiRxInRiL6q1xk1587UebvgwaLO6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ki8AlVcvVxsQ8RLmh9DXJ+37XyY3WKxZmkCd7HA5nJk=;
 b=uzbYWbBRoRF8y13yxZVUH8AFB6LlhwA188x9SOGijOXh5rWqeKXKe5KDbLA7zGU21qGqv04sbksvblM+ht9q+iUdc5MehH8K/Ptexre+JkhZ9+pReudYmzZbAcPdTnVbR4y7GvpvRlON1gLPRIZ+xRR9m+2dXJPr2IyC61MLNnw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB6761.prod.exchangelabs.com (2603:10b6:510:76::23) by
 SA1PR01MB7358.prod.exchangelabs.com (2603:10b6:806:1f9::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.19; Fri, 15 Aug 2025 06:51:36 +0000
Received: from PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2]) by PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2%7]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 06:51:36 +0000
From: Adam Li <adamli@os.amperecomputing.com>
To: anna-maria@linutronix.de,
	frederic@kernel.org,
	mingo@kernel.org,
	tglx@linutronix.de,
	cl@gentwo.org
Cc: cl@linux.com,
	linux-kernel@vger.kernel.org,
	patches@amperecomputing.com,
	Adam Li <adamli@os.amperecomputing.com>
Subject: [PATCH 0/2] tick/nohz: CPU cannot enter NOHZ idle balance state
Date: Fri, 15 Aug 2025 06:51:13 +0000
Message-Id: <20250815065115.289337-1-adamli@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0004.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::9) To PH0PR01MB6761.prod.exchangelabs.com
 (2603:10b6:510:76::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB6761:EE_|SA1PR01MB7358:EE_
X-MS-Office365-Filtering-Correlation-Id: 49489387-8faf-464b-e43a-08dddbc82d80
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QvYdW+I7P6fbtV9J4c6y6zQN4MAOVuc9IZ0eUB32PKvHQ4BrYVe+cR7075/y?=
 =?us-ascii?Q?CF2Pw77nWdzQkgxM/3DuCZJJDACt8Ry8bjL2GuhtyMUQXV8KccItGyvtE5cn?=
 =?us-ascii?Q?Q1HDFH8b6iuxh1NYBrmnibvGVUJ1rUOfouMJpQl0bw5QkclV2Qs9Sa8/S7Vl?=
 =?us-ascii?Q?SyF1QNxtSCwRBzIueQ8JOj4s/BJH7JO2y6Iq2gNVtlkGFR1jwfXC/KqtvVmv?=
 =?us-ascii?Q?cg2nplI6uTEB7yi1aIVxsof7FZfD3arPB5CaxXZqLUUPUrD7WM3EjIIXOHb2?=
 =?us-ascii?Q?EdG8E0p9F8s1U4uzPyfVkkgQ77cm5lJTro7Zw7/uwoB1j3oAnFagMq0gKcnF?=
 =?us-ascii?Q?/sG7cr/DRIjRQhkBjt8b+7jtcx3zFbukq6EWNM3Xdf4wbRWzfOtN33bRpWv5?=
 =?us-ascii?Q?2SLQC8suilSSDIN32Qv37qWdYvNfbCT3vnkhKBSInYDsb50wOqW2fkguDER0?=
 =?us-ascii?Q?4uflnyyBENHUaJdtxf5GAcd6e45zce+P+jdTM3q9MUuo3267eteSPLQF9sxU?=
 =?us-ascii?Q?nQUrLMsSAz1Kmy8pm+lSDYyxuPoAWiTa1uWavZV8a1zMjGhZ0CEzQ2dlfyey?=
 =?us-ascii?Q?Xx4zNeqLLe0pVnpeUmgiWQBb/hmrW6XxjYSpD7Rn9mog1LCnP9VKXnKDANzi?=
 =?us-ascii?Q?h2vkZ2Z7xtnhUYCFzM+CPpJx8ZW+QnIt8TNTeh5vL1QhgZK1LxcjZmzcVIyx?=
 =?us-ascii?Q?PUAftPcWTNM+T6GvoJBwwUZYQ2IUBv2fVM6916sxaGABpGN4JNdh7uIssP9i?=
 =?us-ascii?Q?UjenAiY9a2A3A6VC34G3VdbUaOHp06pByv+2E/p4JKnB+aOB53O3+o6xtAOh?=
 =?us-ascii?Q?4bq8uTw3g1V6EKwH7BC1qyUNNCOS51Bu7UfNqR1RIY8gpQT7g4qrcV/fTPRw?=
 =?us-ascii?Q?U5Lop8ZVBHeaHxFEqil3xyv5x+x15CW4DuwL/OfXekO8DJmnNN+L91ykhwdX?=
 =?us-ascii?Q?CbWykiOL9kOX+JTeDSnHWthjxBflIm/QbU0ubmcyUYSuTrhLsaCOi6hmJJTE?=
 =?us-ascii?Q?WfZJXlRp+cZXevU1v3uUJ+rvi8yREC+JeEVusvD+BZzt0rhLzjICJN8sp5nV?=
 =?us-ascii?Q?4lXN1uRAD412Fgch8eiRhyrapzqCqDrLSbSz7KlrKrEiYwLV8REDiTf+YTHN?=
 =?us-ascii?Q?LA9GptrX5JqMEKa/meHA+dTOowLRCcYrT31xFaaLKYiFKvlxVvgkeL57TB9k?=
 =?us-ascii?Q?yfFqMeqiMwT+PaNMFQPhkXz6WhLepHFlb0m34206SMrixyjJL2kf72c8hYct?=
 =?us-ascii?Q?IOyGRWZb15GpPdTnrfaJJQLuPTvCGoNARkxT2OAkbSsheACJmdstbpPQiirU?=
 =?us-ascii?Q?v5937lXnIRmoKvxykSpXP+kplUw2gAv7NG5QELEOrsuAcs0PS/XfO1bmlSS/?=
 =?us-ascii?Q?92C43Hs8tXf2MrHPDPS3wf8jpHHO63glZ3R58S33XNQo1DXoxWaXLe78/DT8?=
 =?us-ascii?Q?r+6YkDAJBNgng0xE3+viWavFWwIrIxaQO4qwiEQQe97P0VqCP6m86w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6761.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rKzJojKuxL+VtQP6LwBdu6dQllcZ/PezIMO8GozwsPV9xqaxYQnzh5jM2h4N?=
 =?us-ascii?Q?44tL3yHtdP4m2ccBAxMFW5SK+JJCOASmPBwtniyHixLPauSs2fABVsTh0BQ2?=
 =?us-ascii?Q?n1i3jEOKjz9PS28gzOVvxkiL91lQZ0PnzWTFdJX/7SpYT/J1f4k4UqsXhbwG?=
 =?us-ascii?Q?ibgBkk3rWlkbi+0MMUncTtaUqsNdty5//ybM1EaZlW3ldXsAbbVD128td5sB?=
 =?us-ascii?Q?j1bejt+GdzgFxttabeHUHw1m/MdHaUxmvv8ewMqDPMYbkFvSkiG/Wls4S/L0?=
 =?us-ascii?Q?g71+rnXQDJYHlfB/8KLVHq5SNoH2n/JZopMqDTva4mbRcg332ATdh5jcKVXj?=
 =?us-ascii?Q?cC22cMpFzKhiCc28R9D/fIniV6ixXuThJemuzloo2bWcUico7UJQYG8JJK5F?=
 =?us-ascii?Q?n26Hci8ranmgeEVm86IU/ypU94YrUTTg4c+U5zFKsiYiB38TO7DMxYNyT+Ik?=
 =?us-ascii?Q?dUFf08Zw0BKDJqVXGg5DsTCMz6dJPtF0GRbgLPcyxPEeMODvmYoWZ8+lqKJm?=
 =?us-ascii?Q?xTNsHVygVyL1ZcWX4C5ordpHA5joyE5CqNjdULvthfxoPHcE2TV45ODSChcn?=
 =?us-ascii?Q?zJPGHc3XFeOaz5MPHBUycgVeMBDupi1cyLNP0N6ssGaJdxMNiz9zeEDlswr7?=
 =?us-ascii?Q?oasPKF+Gkk4a+VnVRzFwIe208qhB0dqJl2vwK0q8MMKzo6TS4Cu3hayN2pYc?=
 =?us-ascii?Q?gPUhEqao7pPrQX+WqVZ+tDFmMW/paQNA/oob1VDn/Pk+xJFAarb4eN3p9wQc?=
 =?us-ascii?Q?51QJyu0MpXwYCF36M5v4mqCvtpSx8ET4x59dCAXWq/o5pl5FKOLlCXrQd3bJ?=
 =?us-ascii?Q?Fgxge+zTpScFagTzFEiIOrNEbT3pJJHlE+XW7yFL1C8Oj8Hodu4nhpNAt2HT?=
 =?us-ascii?Q?DUkJvpdkSTM/tQe5scPKBjkRMWY+LOj4Um4RI3sx8FQtewIMOTEIpiAQDJYF?=
 =?us-ascii?Q?inHN4UNgvUV69QyhrMcAxb3mS8cieD3XMmJH9a/guwvO1ZZLuuL2Oz0tO70+?=
 =?us-ascii?Q?n0uzUVh69REqgpdWopZGk0VIFs8dzyuRLXisddWvUU7gA9g8czd+WChZtC2i?=
 =?us-ascii?Q?BLvWb0EPn17Yuf09q4ntvWQzw9G5lFN05fZCOoQ/tepgg3Uczs1TwgmuJxTg?=
 =?us-ascii?Q?JlY6n2Bx5jupdDbaVx6thkZm9swYwFBd3SLAyse1q89uTy2uS4mhvk0sYg8R?=
 =?us-ascii?Q?1xUeiq+bOvOHK58uEs/Fy4eJk0xeLUTdGH50VLSn68UN034MW82bbwBYlvkk?=
 =?us-ascii?Q?L7EIuknqiaqbq6BBad+XsrAwyLxX4/1XhM7WQrnjZHE6Hl3GFBOWAVrdBpts?=
 =?us-ascii?Q?97Rgu2vD0q3IR36bRJigO2cRcZH+Vf3A991qNFv8KpMrVfOHWWtfjLdTBAIO?=
 =?us-ascii?Q?SwDHCH+IoaG47k037rTOvGwZatBB4GplS591RkW5EKzudCjqKLX/lUOlKB/q?=
 =?us-ascii?Q?FWlFgPjTxHKP1RD5JM7GQ8yxaFcEYMuuqDNhhZcLJLmpWIrlAIhRR4uBZbnE?=
 =?us-ascii?Q?9bCoLFeElCPZSbnZNqPVA91mMIIRh1ZbepE32HU9d/dLOcQChRzM+i33ZMps?=
 =?us-ascii?Q?1dqj30vFuGg9lKoIYaigsx+CaOGvzgR6uRwKUyPabsckQQn92EkhsOASsD5M?=
 =?us-ascii?Q?qx/8OMBFinhoNqq3NL92Yc0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49489387-8faf-464b-e43a-08dddbc82d80
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6761.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 06:51:36.2535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tjstYH8R3bLb13ilKYXzW403diN5vV4pZKdFvDemPIQAoNgBKCFVpW/eDE2iPpk5vzVzrt7f2JpLtgzZ0beX+7MZnAj8ZJpOyluGmW8kVihh3rpoha+JoZLWwVQcyB3X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB7358

A few CPUs stay in idle while others are 100% busy when running llama
on an arm64 server. CONFIG_NO_HZ_FULL is set and all CPUs are in
the nohz_full list.

We can see that the idle CPUs are not in nohz.idle_cpus_mask. The NOHZ
idle load balancing only considers CPUs in nohz.idle_cpus_mask. The ticks
on the idle CPUs are stopped and therefore period load balancing
is not triggered. Therefore the CPUs are not used and the
imbalance persists.

A CPU is added to nohz.idle_cpus_mask in:
do_idle()
   -> tick_nohz_idle_stop_tick()
      -> nohz_balance_enter_idle()

nohz_balance_enter_idle() depends on '!was_stopped' condition.
It looks 'was_stopped' is used to avoid duplicated calling
nohz_balance_enter_idle() and duplicated setting 'ts->idle_jiffies'.

When the CPU is in nohz_full mode, 'was_stopped' may alwasy be true.
The call path might be:

tick_nohz_full_stop_tick() /* stop tick and set TS_FLAG_STOPPED */
... ...
do_idle()
    -> tick_nohz_idle_stop_tick() /* was_stoppped == 1 */

The first patch "Fix wrong NOHZ idle CPU state" makes
nohz_balance_enter_idle() independent of '!was_stopped'. It is safe
since in nohz_balance_enter_idle(), there exists a condition check
'rq->nohz_tick_stopped' to avoid duplicated nohz.idle_cpus_mask setting.

The second patch "Trigger warning when CPU in wrong NOHZ idle state"
is for debug only. It is not intended to be merged. The patch can help
to reproduce the bug.

Warning is triggerred when CPU is in this 'wrong' state:
1) tick was already stopped before tick_nohz_idle_stop_tick()
   stops the tick
2) and CPU is not in nohz.idle_cpus_mask
3) and CPU is idle
4) and tick is stopped

When kernel booting on my system there is warning:
[   15.536604] WARNING: CPU: 1 PID: 0 at kernel/time/tick-sched.c:1230 tick_nohz_idle_stop_tick+0x148/0x160
[   15.550687] Modules linked in:
[   15.553731] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.17.0-rc1-cls-00002-g39cde4c0206e-dirty #109 VOLUNTARY
[   15.580390] pstate: 614000c9 (nZCv daIF +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
<snip>
[   15.703028] Call trace:
[   15.705462]  tick_nohz_idle_stop_tick+0x148/0x160 (P)
[   15.710502]  cpuidle_idle_call+0x118/0x1d0
[   15.714588]  do_idle+0xf4/0x100
[   15.717717]  cpu_startup_entry+0x40/0x50
[   15.721627]  secondary_start_kernel+0xe4/0x128
[   15.732745]  __secondary_switched+0xc0/0xc8

After the first patch, CPU is added to nohz.idle_cpus_mask.
NOHZ idle balancing can move task to this CPU.

Adam Li (2):
  tick/nohz: Fix wrong NOHZ idle CPU state
  tick/nohz: Trigger warning when CPU in wrong NOHZ idle state

 include/linux/sched/nohz.h | 2 ++
 kernel/sched/fair.c        | 5 +++++
 kernel/time/tick-sched.c   | 8 +++++---
 3 files changed, 12 insertions(+), 3 deletions(-)

-- 
2.34.1


