Return-Path: <linux-kernel+bounces-770297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00717B27976
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2D11176BF9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 06:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DCB207A26;
	Fri, 15 Aug 2025 06:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="AgYQeaQf"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2105.outbound.protection.outlook.com [40.107.102.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23EF4315F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 06:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755240748; cv=fail; b=c622u6vRpzz4Ibo+HwIhuXA8qmZKQAYRVQKtQJupvh/Lb7ZEXr1ibRQ1rkJzMqQjoLkANA3nDp+A1KfjPxxz1tiITlhSLraSC8NYKMKaTXvgcrp5rejGkmRrU3Oev47bDPyAwC20JQqFSXJwAYPjO6pIsPTYwiT7X0TBlzPppEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755240748; c=relaxed/simple;
	bh=+FEEHa1Uhz9P2jW/y8toxxyZ+dJWgHnxk1UbeNTM6ho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ki2svDh+UpMIgW3g2qZXoCov2ZpCoPBVgYegRH9K2y5BFFs15ijIUECIlmHZP58P2Tl6thW9eDDKX/p7fWYlh8B4APrhYMa+O0tOlLIlF2HJ2R6/G+GN9g3u7jWsPep6+jBSmFf+q43WXfh6e9rFv92+o/zVAOV1Mf4yGhxbb6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=AgYQeaQf; arc=fail smtp.client-ip=40.107.102.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWQ+ptpVQsI52LK56xaXQVC6F+DokIZzaemGhTzJZ9FzrVwf0o4pATIU/fUvBylhR3agQviKfKVC5qvIYREAKTjX7vtKcKc8hAeDCBpn4/G2rl58oMG+6zrNYfSRKVjwKZ78ZBFggFHr0C7v3RQbpdRhVIQD4Xad/8bI35h2C7C90CiyY0WFC7YRtPy4a5tDb+3kmVyEStKkDIiraZemBx+ja/MPAwebR5N8EY8k7Bipj7IC5BYYUrf+Zwfjx+uN0bFJfw1TqwnXXl/IUnFD1yquG5qIjCQLJ+ito5MBmMaTYmYE/qRuMopwMNN5uXItM13kQ1JDLILwFRuJz+AFUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvItEv/6X84XuwxJhznN8kW4mrOxJNzbxryF9jSKiZs=;
 b=VtRZw/FIE6xESaNPrp4wjrMSITZz5EUAagM1io//WopV4yvByKVWEFRkz3JRme272sfLBZO8MqY4C+nDmLRbZtV5v8rM2DYzCpyp9hnAvjW3Hco5ARD174rm0x6rxzU1aGUVuYNSEeTlk3TsvjlhzPxz365A3hK0nR5asnDNojuEFhi1B50MMmQ41NSlpENAm5B6dW5QOVwZMzE7QEkgNfl34D+7RXBpNrS287oI/yqCQJu+bvszS3CiSRcZLFLU6N1uZ5mpACTIga+O0fjSx6evSh8yqleviW00lpdNukGobL8NELgM+KXrsz/mZQmEXlpbJ+EEDp58s06dppvLJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvItEv/6X84XuwxJhznN8kW4mrOxJNzbxryF9jSKiZs=;
 b=AgYQeaQf1ZzwlvLz/nKGR3TM3M9rY5Z0VApc448UEp5EpnEYbdbdO0awtIV/ARhPtiMIMbzlk+r9ZxY+PkwUt5vyJI44PeRhpC+DoME/L7w2DwaVCqfmJKiqpgH2LytdC544o6MJre1+Y9ixOv9yeHoqHvXQ/XMxgM1G7ZRNJYM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB6761.prod.exchangelabs.com (2603:10b6:510:76::23) by
 SA1PR01MB7358.prod.exchangelabs.com (2603:10b6:806:1f9::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.19; Fri, 15 Aug 2025 06:52:24 +0000
Received: from PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2]) by PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2%7]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 06:52:18 +0000
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
Subject: [PATCH 1/2] tick/nohz: Fix wrong NOHZ idle CPU state
Date: Fri, 15 Aug 2025 06:51:14 +0000
Message-Id: <20250815065115.289337-2-adamli@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250815065115.289337-1-adamli@os.amperecomputing.com>
References: <20250815065115.289337-1-adamli@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0064.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::11) To PH0PR01MB6761.prod.exchangelabs.com
 (2603:10b6:510:76::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB6761:EE_|SA1PR01MB7358:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ddf8d2-9f65-4532-b748-08dddbc8467d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FjVpBaoCr46n26lWjm9FyX6Sn3stnUKJzJMramXGXqlQ3k7J9m3j49BDFY/z?=
 =?us-ascii?Q?vIpbGmiMqdvpHa5YYQAkx9UxKy/6CZO8JUGovTJbpvVBZJfgrBuswyTBw+ZT?=
 =?us-ascii?Q?bpqQsx9D7z7velr0SuVv5uECrbGVlGTOuvoTeF/b2x/KHJC1Eq76l2XdzQAc?=
 =?us-ascii?Q?azQaETgI5AaX6B9/9Qr+IMrsWLa9Vo+y6dUE/EaB+Yhw5G9nPtrcwSA6LEuY?=
 =?us-ascii?Q?+wP1dGPj+xa3+zoQvKaMExjCCXuE6wt5svb29y+OhNcPifuZxbcdg8NVj+u5?=
 =?us-ascii?Q?gdYdDTsHUeXt85+h3mqrHUJsNtVSrjkLtXdL/+1wuOuLEXm54UqLU3rl03jK?=
 =?us-ascii?Q?Sm8Gq7gy7NuX/ERbgG9RxYqKVfCmLX0KZh6ymZ3BjKKuHiEZcbmm8e7cdd07?=
 =?us-ascii?Q?nMG0TDhqloP5qCKB5gfIHJA7IGwkbxuzL9HhB7EK+oBfpdPD8zIqTwrMpVFa?=
 =?us-ascii?Q?A3sxICvqIDlm0+u8E2ObGry8SaeZXrv01I53R02iAaIkAVo/3pjb7Q0WhgJN?=
 =?us-ascii?Q?kuyd7M7JEXIaLlX3VFHiBCsjZw4/tE84JNaFuVtxMAdrIrW1m7wOk96dxpgX?=
 =?us-ascii?Q?Z2vRmaGN4oXMAdtsSEGOlAKtiaJsBGwOP6b2nnnLdTzpoAC3qOPHLmLkCzTT?=
 =?us-ascii?Q?Z1BCBP3FOR3E3Zi6ijLs0mNhvyow2+XfdQNGkUiGX6mQICe/VyRhtWTUCfPR?=
 =?us-ascii?Q?iW053nvora7T+0InYDXNU9AKhSoBMetHzJ7mqTdFgYoA0oPhXk3rrGsb6NH3?=
 =?us-ascii?Q?YwL/Zo2N6AywuXkq2QCSKCmjqfg4s8y+EjYfW11/TeQIdjwKS1zH309nY3y0?=
 =?us-ascii?Q?74VKr7P76Bi8DNSRTMokRKNfO2rHsNGp+NDkcjN9REjur4FEn9ndK8N7gq6M?=
 =?us-ascii?Q?bNhHlQB93rnNHcdQOxstgrEIpEBhskDm1tsxg2tWXv8flQrWHk8g5m6MOEsi?=
 =?us-ascii?Q?k1vOKCVBn2Cm/Nqhwrv9S6xOlvNZfId/tQZ223koEw/tw7iQNj8p9OHZNdMe?=
 =?us-ascii?Q?y1XSSEXPYiLrng3X18X+6cccbaTTA5AXeuwE2zXis04DJG3KPDZ3shgIP9MQ?=
 =?us-ascii?Q?g14f6/ogSykRWBho94lFhpHCvkXcAvP+YNaoO/Wmr49jqjQJDMhxXk3KvYjh?=
 =?us-ascii?Q?S44rpFIlSWKI6eO1GPW70HyFTzzZZ6+Syi7Ixc88RtA7OnxKu4jlX4NgRf13?=
 =?us-ascii?Q?SvuFsqjwteNId3jawJCVQGtxX//Zfcub51VJXyR1ios13P+UM/d8qFIxSJll?=
 =?us-ascii?Q?+LHgzBRe9I7P7Op/JqTvbIjfRYwYQN3c6VHdz/RIeTX1syzN3qhT32BWDn/Y?=
 =?us-ascii?Q?Mj1AwE4pmTQY6VuPy0UJXPseX1qJXXlv7CdeLa5rTXpq5cguF1LBV5ugXRtM?=
 =?us-ascii?Q?mwxBg+JpBc3EMe4L8wCTvjH4MOcEF9zIUocWgMJWuz0TaU7ZLRyH4+ov69E6?=
 =?us-ascii?Q?CIQom9fbZo9FiKOi3GviwqXGuaVnIlGFt5OhR/Trjw41uRiOxlZXtg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6761.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3BPONcNwLYuY8C4wV8ESIBFSpBIfc6x8/n5TqxBJTUVgTQfahHUpM3qzdFJj?=
 =?us-ascii?Q?JAiblJv3A/OSOtYc67vZIovOLfQwayEXhYVjt/pw/cz4z6erbUonD14Ryhse?=
 =?us-ascii?Q?2zbgl/RZs6AEqLhuezRWtGKRRIZah91lx7LOueTmHnpoxQhmSYLRnLREQczo?=
 =?us-ascii?Q?FSNXnY8RKJVasMdOCf59YOZs7hZWp0JMDHIT7YI9jBTP5ZgCz51fJ09HBvt+?=
 =?us-ascii?Q?w6u72/sm6JgrjLbEXYN4EahYGDzg9sYkT2C+ge88bolMYBE7gk6w3aOBsuUI?=
 =?us-ascii?Q?2UwtFMWyn0+OFUIRhegVMI6K58ofVB9y12xNhMhVA2SB3ReHW6ENecmenTo3?=
 =?us-ascii?Q?vAFcaYyMJFEqCXtUw3L1G3E46r36g4JCt0HG8nN04L6a2FByVb7guaSi4m66?=
 =?us-ascii?Q?a6CAa09s2WKhi/ptmXDXEyG5DjuRNCnmxuJLcs+oMnPyn35Rl8fKzydKUfRc?=
 =?us-ascii?Q?kAoYY7cEpPR6kZMxT5F3FUWhjBUfNzgNvL12t3Ndy65PhWMRlv0AkCCoYUZ0?=
 =?us-ascii?Q?ckAUMBftYvks/SLJzhs+2jVcHFYDqRdZbx1tbRRGG8irF/w8pYcx8XExH67W?=
 =?us-ascii?Q?R3FWG+R9Zaxqezu4EFAusrtkYry5iYBZ/2uOB2ju+aPv+yIHoGEyfIGzH9yC?=
 =?us-ascii?Q?AfRdLLw/KKk+1Hd7Q2ESxWJv9fPsYiUmEiL9NJX3eM7rR9wrytYHTs85NbgV?=
 =?us-ascii?Q?ZWIk0PKzE7G3UgPWUyyBXL5JOaIqKiiFuChr1NkbpV6L8vXYLii8RLyR6J4/?=
 =?us-ascii?Q?lk/90lpIu0FtR3bkGHoS7BGQYPGowuw4tDVuoO+HFEnKKcweaKeOpIkXylH1?=
 =?us-ascii?Q?QZvvMxKtqRg3Tbq4K8n4/Q6jAeAhCdY2lTegDyh+0LQ0DMcibiOb4wuVzyFd?=
 =?us-ascii?Q?nYJiHbHEdLHN5iPo6XylrTgU9u6D8IEOFIcUhSdX5JgiNwmq1WRpTMnX8y1g?=
 =?us-ascii?Q?CBq8m7Llaf//Bq2KYUUU0ALd29I9PobC66wvcKTeIKkNhmUreyV5PQZXabEu?=
 =?us-ascii?Q?4I0UlYxeK2ydRA3DOWzvcxXQopIxu2asJlQy+Qb1o/6DwParFhw6SkT8yem3?=
 =?us-ascii?Q?ymGbTz6fNoPecMk71VQJA6B+RMeGBxJFnkWA24J7Dwq+9tsUmMJUaAIcx7RL?=
 =?us-ascii?Q?+cOYIDE48NGwfX7pfE4Br+fWbtkQXG05HN8w8wQkh5dCa62jG3/vU2cNTILl?=
 =?us-ascii?Q?h5korCFcVQXsWXAy2YCbm6R3IIGCb9Jtz12i3BgEH013yx9bTnTypzomufgY?=
 =?us-ascii?Q?5T4wkjbsYQYdZcdOp7e5WxE4Y3E2/la288lwWuFkGjpnY6DOoAvrkR+plKb7?=
 =?us-ascii?Q?aREVuqjtzCYmhFo8bNQv1MXKee9fwlWDyzMgZnklKBL0Qas5LacpllPFm9EB?=
 =?us-ascii?Q?Q6DCLVT7gSn2o9UgyISPZMfwU7zcderK+6/OcoxrGF0ozt1GukAu2Jw3M3BN?=
 =?us-ascii?Q?uCwJru+AUuabhvW2KwQjMbLrwFLp3I4penfYBiUxMbOYvrzLwds0l6DzpuhY?=
 =?us-ascii?Q?9mOOXAb7TSGnczYR0nsRFpEGg/fUuSJ7vY8gUuJhl3onQn4DY1KBfAuwIxeh?=
 =?us-ascii?Q?fbFAcN/9wJAD6AKj8LHBMoNomWH3hrTc6kCg1/fLH4fUB0LKjkotPIN0W0wH?=
 =?us-ascii?Q?/B/St/psweyGLKd9oBqnJ2Q=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ddf8d2-9f65-4532-b748-08dddbc8467d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6761.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 06:52:18.2789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TRTv7lJwYc8Y6o65Fb8SlVlqRvhM81rV/+xpDXbGhrKoELGOa6ewSSnEmEnUiYbPuLUqIH/LCi4pKjIvDwc984k3RQHSVzjlrCXS/XJIMCpWYsvm7ziR4cQtH8fOGpa8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB7358

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


