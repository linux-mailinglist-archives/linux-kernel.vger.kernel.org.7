Return-Path: <linux-kernel+bounces-740652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4180CB0D749
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62720167C60
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE3A2E093B;
	Tue, 22 Jul 2025 10:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="SFgwQb7u"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2124.outbound.protection.outlook.com [40.107.220.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1BE28C2A2
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 10:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753180016; cv=fail; b=TISW1l+dIB9EYisZSwpIuC6prwXwmQD3Iqrug4gN2gTBc7NxU8PybkDwv51cbexsUnBkNmUY6wn8pcCCF/ZIsQdRO4/Bn2WE7OP9pSt/FjywQSeIZew0Riq7cf4WJpTQnFrsYeXqlg1IzSPBKnApEchZNNwQaE4N9IUz7McsR/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753180016; c=relaxed/simple;
	bh=ZH0neJQ7hH7PemSWaRbXJpRuCVORblADAq1Bkn0uSf0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=k6dfk1L7AWM7FxpSo30+08BAjHGeyLeg0dkTNDUbTJrUBNYKkXpT7XOUkf3Rls3LU9TOkL0X+cCMlFch2Gd03W5xTyfbBFTIcxPMGOSZ2n9pp4TSWQDwePGQgBKnPL4kDjJfrrYvIDo1ko9mjnY7xn6fFsJh8R6Xv2lDpC7s10c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=SFgwQb7u; arc=fail smtp.client-ip=40.107.220.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9oLFNNZatG3tv1nXR7L1RwzO8CuEeuZMkwp9TA77CkzDpyv5kgMjFBqVrdGZydXOAETJQ+pLc8tJA7Vuc91OUhpY+iGUHLwDp9gCZyz+Mkw7jpinIH0tTumsd9WYyyqLKoXqkA9zWY9zSaI4x8LHGbK1taRnXQJgHfN0nQ31yodjbjyGtsuSF06CtIlkzmyNq0wsb2UwdSKEiqwXDYNnEzgoWEv4JLy+UthTldbwkxrhdqCThY+thGspFxL1a6a7dUpJfdifjHV8lDK/eB4avSLDzTmdbVLN7ZusHjYcWsgI1gdHzGqvknFrZA8LLU3nIsC1DpvlCVnTIYWuUZUGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKmLPJSseNSjMuWWR9+u7LURghlz0GgHobxxTblc5TY=;
 b=iYFJqKP6PWuMQRNmKt8cHmr7BH4Eza0N2pn6I5yLNKM1U5uOF9a2Q89KpSBLGk4Yw6OiTC8PmEcFZJ88otsIDsTvXUQ+VE7jzzNaDnoCRIlpwFKv6LIYhH8roLE0gcNatoB+uFg65FFde7Yc4eK/iqsFDrCI9JGyWl6c5i7pb88fGRgssL5fzzQ6wCSq0blVXnJzylOD9TiJviIVvgX70PteR+8s00ZqHLket2u/fzIKK00l5RR7PgnwIN1r+NrguHtuHBvecxMbO5mCc0OdXQ5P0rS4B+0t6wISvO2yKBsNu3iU9aIIUvdIUlnw1AyTJYLWsBVMkbAMkYsyIxVHYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKmLPJSseNSjMuWWR9+u7LURghlz0GgHobxxTblc5TY=;
 b=SFgwQb7uJcqVjPWGhzAxnaN3/OvVZ//XqHLHPpXfG5d/Yrgi8GJb9mEI8WlHrc09rSs/KklYAx/hxQhW7Gc5x89P4ROQvlUpr7Jz82w8jCTOJPaLwPzNnp9ea2nk9wHxa3kkEwQEtX01U5rPV5+Tc6sRusJHYKe3N0hqpWKAcwM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 BL3PR01MB6945.prod.exchangelabs.com (2603:10b6:208:358::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.30; Tue, 22 Jul 2025 10:26:51 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%4]) with mapi id 15.20.8943.028; Tue, 22 Jul 2025
 10:26:51 +0000
From: Huang Shijie <shijie@os.amperecomputing.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	vschneid@redhat.com
Cc: patches@amperecomputing.com,
	cl@linux.com,
	Shubhang@os.amperecomputing.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	linux-kernel@vger.kernel.org,
	Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH v5] sched/fair: do not scan twice in detach_tasks()
Date: Tue, 22 Jul 2025 18:26:00 +0800
Message-Id: <20250722102600.25976-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:195::11) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|BL3PR01MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: 09643b19-32de-4e17-bf81-08ddc90a4555
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k9Z8xndZfI4VbxZSEQBSSS8B20Fncy14VMttIHqWG84AP9c8PyrZBZKM3uP/?=
 =?us-ascii?Q?/ha7ClnRHqmWg6DypCuOfQz6+7XBlBjDRjofY4iYVqp+oeXN+Ki69OlAiLOy?=
 =?us-ascii?Q?yXSHsEoQD/Usjxg0ZNkBzwurbdNZnJSJ3Gk+lTpCOo2i8hC0PgIjQdt+xl3V?=
 =?us-ascii?Q?41O3Q9gCHiR0B3FCtYFbYHOoiQ9etDFk/FFZGOX+7WZ7TNHAhbgnNtuDPeNd?=
 =?us-ascii?Q?kTtOy7Xt+pbUeyHmS5ZLyqLNznItxhDE305RtscL+8NyKlTJApXNX89cbgfL?=
 =?us-ascii?Q?Xg9mqLzZDmcIcvUBEq5D3L+OR1xn3cHqF4plo5Cvi7z/+JmjlgIHE3aJD9LB?=
 =?us-ascii?Q?8FTJQfcXGTFj8IEmGpKQi8VG9ijETcbCukNWZrQo4Aj4fjcYGLjvnXzPAxHT?=
 =?us-ascii?Q?Tk8zaBNxo2yZCIpwogaE3CdAecFxUab55CTp9oz4udomrcOyhJ4QojqS5hu5?=
 =?us-ascii?Q?O5K/614aycO2USb8DbHhWl7roCKnOsgsmCcySnbteCpP8X+Jsz1WvcJxL/Ca?=
 =?us-ascii?Q?2HvJF6sFsQ4kmjbARPvk00SK0TvPzG9jC5rZq6wikMVRWdYRHts8PX2+rXTn?=
 =?us-ascii?Q?aRi1ZroNsqBG4IouqegDNIlemp3qNMhb2ieuf653yMXdQeD78IDNJ86ZQBUW?=
 =?us-ascii?Q?vN9KFpkq3FP42W3UpJqPV8J9GDnJmaJJaGzJnQHnJP8lyk5ThfsJJzxWN85O?=
 =?us-ascii?Q?XFgxBi/TyNSfK+4zTwAdqAW66rhs/TdMYSUYOrP0jH1+zJSaDMPaB65rnPfv?=
 =?us-ascii?Q?t/fYo1xDHxTNBTn7uenc2AvaeCXOGafOtAg2ALFhGv99GXuxbCureRG3N7MH?=
 =?us-ascii?Q?RmkT30bTED0B0UW2o8Ul66e4vRBKIo8Xpf16MsbzmfjnimAmb70o1t5KvTeq?=
 =?us-ascii?Q?1Bs1YgVaGpLfOnFp96pyb3hpT22cdVhWG/QxxmNb2vbcnc87RVMNuxshHcpc?=
 =?us-ascii?Q?ypXzhYirzR9XsBG7IFkE0MSTTYAJurwlZ634GLcix/wr65OzJnh11iz7R4ra?=
 =?us-ascii?Q?jeORR3VuBg2cIIBf3E5QeBb0Ijfql/tuSuFJ0dwrE9ohJAcEsujr6ql+upF/?=
 =?us-ascii?Q?/YsgoJ4w82H2/wKxbRPop8WcXuyGuW+gh8XHiH+dvc3X/RV3ag4CfP3d+SM0?=
 =?us-ascii?Q?048k//8tPRCZJy24Tmq+KJ4XaOujyLCcADizYzV7DVQlhZ7OHH/BlmhpINEZ?=
 =?us-ascii?Q?M43TBY1BWTYj1P+TX//v0h3TFoPfo3ik3/E2Iq7ixLbKxfy3whCiw+ZMz04d?=
 =?us-ascii?Q?CFT/wCYdDbjHOlSyuXemnQ+ODXCd4mj38ZqnecW714/lKBHePO8xWsxoaFgK?=
 =?us-ascii?Q?83BFnzvTLk0v972sUPv0a5YkxEs0fuecRn92jqg6jm3ybjUL75E5Otu7GrzH?=
 =?us-ascii?Q?euECVKJ4su/J2aVTFcWDwgIov7gpQlNEf3EBp6IARUlZ8O8psAjPDDtkYdSc?=
 =?us-ascii?Q?eXjhPclaymz0RJXcCR0oVA7o0CRxG9FlLll2Jl2ISl1HwusidBVH6HEoVF29?=
 =?us-ascii?Q?Ci44u22Rd6rL1Qo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N9Frnej7OOcdSkJ95WS97fb3SukuTrvjR/kFneRLzGrfkEC0Zax8qJldeSts?=
 =?us-ascii?Q?SbeAZFtl2y30kpqijSTsLg/jbIqjrZJNjTXEHYAau1khK76X7b8YLjpXH4Ic?=
 =?us-ascii?Q?dalAwkKDaelCSJ2C7nFK5H4l1PtTRMQylxcDZpmAuES+3bmRL0Y1P2O3z7EW?=
 =?us-ascii?Q?VON5D2oea/Q1tSBk9Vvd78t9BjfWnRZW0IgQW++uzWKe8+KqA9Rq94d2I5Zs?=
 =?us-ascii?Q?Kup42xqsG+03bbkMDeJj8Fk0vu3h8aWy7kEpawHzoxuARE/Xu1y5rx2Z2+q6?=
 =?us-ascii?Q?Ka6SMsTfYFZwMtT4QcfTxwmlTOBhPtS/2+Aw8SXIZB9T9b6T5aT2q0uRvCYx?=
 =?us-ascii?Q?K7v/8vkDO+xysQhDo53E1ARc71MOz99U5IaQ1ERw/fTV4MxsfY+CiO645DmP?=
 =?us-ascii?Q?w1oPIpxVVRK1Uu/gOQWXGu1Jh6GkKVx0qqUoVxZ56utI0sDhQO6V3xNE/XHL?=
 =?us-ascii?Q?VeBnu715y89VHIYS+us7/H4yeTluWI1QVYwjfZ8v4d2MpsiL9rT6kXvsMhDX?=
 =?us-ascii?Q?fDMTChmBneHTx/EnN8vNnyNnvt3iC2AQ+4ds5a/jZ1MPD51CGxwElzftwFq0?=
 =?us-ascii?Q?nXZqkkH9yJywNpC88C3xDSlVNAMIv8VHHguTYqfwLk0rzO2nq4CyzsqYan88?=
 =?us-ascii?Q?gBfIKweuJWCYZRaQYkqQNpnMkW763x2gw8ui3/OrOUlayCvC//jtvP7WyC0l?=
 =?us-ascii?Q?QbdgYID38aukOvMycZf/0FbSErQLTioxPINnW+wmnKgUpfiQATnAoF9+SBAe?=
 =?us-ascii?Q?DjLQIBL1HARJh9Q5/z+MFIjsGiUTXY8DzMlFSjLw9MC2utKgnvObbiDRqbw/?=
 =?us-ascii?Q?gqZhoHJe2EgZePOs15rT/4CTBsxyx8W9BFM+z8aLsXzqBrvQufpUtLzD6ch2?=
 =?us-ascii?Q?QkeL8wwLL5pEAdMX0LSndBlc2ekBiBr8FgfPXAewpNYi4w9AxDqfulh5ZU4u?=
 =?us-ascii?Q?X0jixEHd5xCGBOLyNeXi/5BTozyPpz6r4F5fgPO50SZqiADtaPqRY+xAx+bR?=
 =?us-ascii?Q?XOqQ5mQfY/VxAe161IumV9MHnYICU7x4p1b5L3uEHCgoJs0b/AY4NbmYyD/w?=
 =?us-ascii?Q?960vdRu7MfZhWVo0erCLmzVJt/CRELOrKEudZNSij0YXvQVfyfT1hDUJB6EJ?=
 =?us-ascii?Q?1K/IEsMh4rA+9YUMPi51usV+7VVXS08oc4fbL78TyuYLW17lujueR4bPb6Uz?=
 =?us-ascii?Q?3FRbbkse7+r/oDzUvRrijfZ4U5hq2WqRGtBtHau6HqKfi0ic4mvzlmGTkD+y?=
 =?us-ascii?Q?9RzBb/ZZlWf1P815y1pwcXWvhH6YwyxgtitAPk9fmOxyXzLDcEuohLHFep/k?=
 =?us-ascii?Q?u+bF5VarBpwaqXd9VYdYsDZt9fVUs25iwl4XvZWgAQMAt6VOhY3+hLTSDLvC?=
 =?us-ascii?Q?+Fbfkr+jY84h9BDpHGcBAayjF4AyjcF2hozwCEDd3BCkrqDDo5UmGITAPKZj?=
 =?us-ascii?Q?jwSas8pTexd3KhpIvc9LjSZZtErnTGRG1yM1X+4SSLjqPXR2Qu07fO2IXTXA?=
 =?us-ascii?Q?qcZwsUO4PDW92btIoVhWojS3FQVVGZdCA2XTmivKeKWpXvd7UvvQc3Zzd2Gm?=
 =?us-ascii?Q?xTbUXZgniraN3iOYzhY/TSn9vHxoPqZ81Lr2haT4iOC65x5gEtGmZqme1s/m?=
 =?us-ascii?Q?aK6ivaDlg3+HRu1cMKTzTuY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09643b19-32de-4e17-bf81-08ddc90a4555
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 10:26:50.9534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ICimwRODH/p6GZiErLLczJaVLkd8NhK2P+TefGOzSr7KnghlIM2YMd66mH2UEZ1Z1V3LkpwrOpfn79b1MJUNMSPeLnoXEQwFMSHyuYxY4jyxPs3QYj1+h4USt9ET+8VM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB6945

detach_tasks() uses struct lb_env.loop_max as an env.src_rq->cfs_tasks
iteration count limit. It is however set without the source RQ lock held.

This means that env.loop_max and the actual length of env.src_rq->cfs_tasks
as observed within detach_tasks() can differ. This can cause some tasks to
be unnecessarily iterated over more than once, for instance:

  env.loop_max := 4
  detach_tasks()
    // Here env.src->cfs_tasks only contains two tasks which can't be
    // migrated anywhere, so they're put back in the list each time.
    env.src->cfs_tasks := [p1, p0]
    // The iteration goes:
    p0; cfs_tasks := [p0, p1]
    p1; cfs_tasks := [p1, p0]
    p0; cfs_tasks := [p0, p1]
    p1; cfs_tasks := [p1, p0]

    // IOW we iterate over each task twice

In the Specjbb test, the similar issues can be caught many times.
(Over 330,000 times in a 30-minites Specjbb test)

This patch sets env.loop_max only once RQ lock is taken,
and uses busiest->cfs.h_nr_queued for setting the env.loop_max.

After this patch, I cannot catch any above issue in the Specjbb test.

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
v4 --> v5:
    Set the env.loop_max once the rq lock is taken.
    v4:https://lore.kernel.org/all/20250721023939.19703-1-shijie@os.amperecomputing.com/

v3 --> v4:
    Changed the commit message suggested by Valentin Schneider.
    v3: https://lore.kernel.org/all/20250718063523.9232-1-shijie@os.amperecomputing.com/

v2 --> v3:
    Fix a typo in the commit message.
    v2: https://lore.kernel.org/all/20250718054709.8781-1-shijie@os.amperecomputing.com/

v1 --> v2:
    Add more comment from Valentin Schneider
    v1: https://lore.kernel.org/all/20250707083636.38380-1-shijie@os.amperecomputing.com/
---
 kernel/sched/fair.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7cc9d50e3e11..9c1f21d59b5c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11708,12 +11708,15 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 		 * still unbalanced. ld_moved simply stays zero, so it is
 		 * correctly treated as an imbalance.
 		 */
-		env.loop_max  = min(sysctl_sched_nr_migrate, busiest->nr_running);
-
 more_balance:
 		rq_lock_irqsave(busiest, &rf);
 		update_rq_clock(busiest);
 
+		if (!env.loop_max)
+			env.loop_max  = min(sysctl_sched_nr_migrate, busiest->cfs.h_nr_queued);
+		else
+			env.loop_max  = min(env.loop_max, busiest->cfs.h_nr_queued);
+
 		/*
 		 * cur_ld_moved - load moved in current iteration
 		 * ld_moved     - cumulative load moved across iterations
-- 
2.40.1


