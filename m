Return-Path: <linux-kernel+bounces-733227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54976B071CC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EFBB582358
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629C82EAB8D;
	Wed, 16 Jul 2025 09:35:42 +0000 (UTC)
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11020125.outbound.protection.outlook.com [52.101.225.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3FF2EF646
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.225.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752658541; cv=fail; b=nDSPa/kWvb0mkaxVSxJn98g7g2/w/7sc0b/bmjNITfavwQcF7194bye1mAJ3D0dOHC6YYX0VQqexZ5J7IqU0ZqeOJvxEncn2g1/DFNBWMY8QWcYBGHRrGXB/NBTaEtDMbAVcjGRWHcVoKbWN03tMyABtxBR9yM98Wu2rBxFflg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752658541; c=relaxed/simple;
	bh=1RMiD5cNhp4m7WbhSQ5MDceZcJYJsoAbQMhJvXOwSh0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=b2enoZEMvtGvUY7BsYm5XHYldyNWWc7kO1x0iw42qK6xqPA28TKqt6qCDMjPa1gl4H0E8KxbfgGAJ7vXr8+JoL55oz0gqNqc+b+WmCuZwRoRYpCUbamEsEVcUcbbicRl+7GeoxabNZW/x25uLlvqb14jwfM5AsaVGLnBhOT2S74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siqol.com; spf=fail smtp.mailfrom=siqol.com; arc=fail smtp.client-ip=52.101.225.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siqol.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=siqol.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V99xUYmN+NuGd47knXWbjCWqXGb2MjuyJyUfuhGHvOChRAZHvz2I+XfQbPm/7vDBUG77TDkaH8duGo8wC7Z3ZTry//M/xuiCElotp4TxSyJq7lhkyZhBy4L4x7h5FUt7FG0aBgpbKqrGsXGqX96RkYytG00w35hM06QUhsLuUhTWd2IMGGQ51h2XcJcvPStAmb5exd1Y752HT5t/10Sd3ETF0CGOjBr3Oygpg3pbfpRpunNKcALF4BWUpuCmhEbYNKptJ8eiVtsYIs3DgaZvXhRTQqm0v5jU9u38hvjvkaOimDr+IYtjxujRBqTVtdqM4dZ/JeMBeWMC7MwAMQhNeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOqiawBAo3S5g78tdP7yAMSoWMe5kcgwOnOT79TO3rQ=;
 b=sReg/hD2V80+ebwURmoPO9MGPPormx3BDPstbgt++5CrcRkmrZZxEfyY66ShuaIQ883WG+sm8YDRA14ZwuC4OskuefHFa6B54tr8aOSiF6Apj19t9w0YLduOkrh9DKVHQ0OnuyV39b5K+UQ9g4r/qdx8jFG3g5esZ5HxeJ9bz1wwc/qs3ojKmn54L0NE6KLJlNAKImaoLmFLTYxmqMvN2GwP2K7AD8CXE+Z9sRyLlQ33zwgVqF+GrbHv8vKRy2A4bVR6Q8a1sH7JzkDLizqM6bvXNbzUkwmPhtqgXVLNXLJexfbaygzV8b6wRBjKo4OmEZsq7jqgjEERlcm0kZ3XNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siqol.com; dmarc=pass action=none header.from=siqol.com;
 dkim=pass header.d=siqol.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siqol.com;
Received: from PN3PPF6710BA041.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::ac)
 by PN2P287MB1440.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:127::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 09:35:36 +0000
Received: from PN3PPF6710BA041.INDP287.PROD.OUTLOOK.COM
 ([fe80::dbab:5ea2:1e63:5fe9]) by PN3PPF6710BA041.INDP287.PROD.OUTLOOK.COM
 ([fe80::dbab:5ea2:1e63:5fe9%7]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 09:35:36 +0000
From: Dishank Jogi <dishank.jogi@siqol.com>
To: Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Dishank Jogi <dishank.jogi@siqol.com>
Subject: [PATCH] "fork: reorder function qualifiers for copy_clone_args_from_user"
Date: Wed, 16 Jul 2025 15:05:25 +0530
Message-Id: <20250716093525.449994-1-dishank.jogi@siqol.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0182.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::6) To PN3PPF6710BA041.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c04:1::ac)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PPF6710BA041:EE_|PN2P287MB1440:EE_
X-MS-Office365-Filtering-Correlation-Id: 5302caba-b09d-4307-cb9c-08ddc44c1e05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|10070799003|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tgt1bmJbNY7qz3WR5hZQjwOUNLz/BbZWQZbgwTaiiDkn7EoqWJwbvpM2sLcZ?=
 =?us-ascii?Q?p4CKf4cuWrkBe9/F6wJNx4hDI3N+jbBDrgb8RWuAK4L9mAnbcTJ4BdbIl/R4?=
 =?us-ascii?Q?+RytSWDSxPfXoGrT7K/kKh6jJCrOd+v6AtSPVY5igcwe3hoqgrDykCGtIA4k?=
 =?us-ascii?Q?8NEQmxWzDZa6sbqvQv4qOOmMZdSL9XMR30mcKGhihtFsEs1XgPf0C342klbP?=
 =?us-ascii?Q?h63paaw30IOIyyXSt/EN5uYZEHG3WTsZ92VeYfTKggqgtgFKGR7wmnPq9E2g?=
 =?us-ascii?Q?k6g6AIMMhp/MXZLOl0HwCscg99dCf77p/9WU052PRcjaoMS9KGjRGKSNBFAT?=
 =?us-ascii?Q?ljCMULzUPgpllaQ9r5pS03QUR+MxDG6E77d2RrrMoURaGOOwWcYIQadRVzMh?=
 =?us-ascii?Q?AtvzkJdEsvkqXbVAEHUz9rsalAPruyUnoRTIXdwVwjoS7qFcUDfrsWSxWqXL?=
 =?us-ascii?Q?gGPxOj7DHipKvybqGF/ONCvVW0yZ8nEWz2Z0WMKh/1q4DzJNG2lHaI3Yyv6Q?=
 =?us-ascii?Q?gbBB3d19hJIlRyQ0hl2uhtZRT6ZfJ6/EIjjaAGdGjLxPc5j+fWrHHFzNoaaR?=
 =?us-ascii?Q?36R2vD3Q3GQVlgHgqhhNM2fXglZ8O9eXMHozRSO/+Uy27hg3rwLM6sHfbWNK?=
 =?us-ascii?Q?dWgt35GyzMs0S6Zxvz6dlVINWIgVuWg7N3Vv73gMYNCz3TGUjKaV9Mhz/b6N?=
 =?us-ascii?Q?PiwSr3MqNiROnPiW3CWJkaxk7/fSNo+TXZqr2b5JWtSZPkwcVvFJR92E1dRd?=
 =?us-ascii?Q?fyxcq/AdG8xw3H+qtftC5R0nxOvSi/7kCYSO50AyAzSjkb+dcGcWVvvEC62z?=
 =?us-ascii?Q?LreyuOVUohYhKWGfirLH47Pws56bwXsJPLSy0oPSLQLuVWpb3Zw6MnSg7LYu?=
 =?us-ascii?Q?Hyx9p07mI/DAJQ/eDflIl4OJzp3CSG34o4Bo2sObqBadJxDKNehrVqNMOCRS?=
 =?us-ascii?Q?U48cgVU7xepMVMl5meplbtbtYadH6s3Z21hK4OKQuSuzUTfPwc4bFwxuWi2O?=
 =?us-ascii?Q?aAk0/csftqwkjksyPANtA1xPMB2Fv4GssWkM1vz981xwiRZ5R0vX/FT5vwga?=
 =?us-ascii?Q?epXGMvTsZYFFT9PpMLiaLscZIW6imxknOf3mTYzn3CGevkCr7GRCsWBRxW1k?=
 =?us-ascii?Q?AtHcnemW5CbdUJqZQGRiaWHJznHl3XIVKYHFVcyW+H/szSwq1nTFsPdWiJ13?=
 =?us-ascii?Q?LWhSBP5KR2cQnOTP1aGIGGSzhDhRlsyU7PcCJsOKsJG0AbojNk+nDk7FE/i5?=
 =?us-ascii?Q?nZUARpSyfgX8WtE4f1aWQ05vQh6T0StaGA6k/7yTK4XFKjnZTcsAaeRKyrMu?=
 =?us-ascii?Q?QLTUb1cy9g4msuSHdsohaSPt4PAHgvKD/qae4XKltQeFPhTU4k3V/KirNgdT?=
 =?us-ascii?Q?mnAqxPbD3TbHpVS73o/XKTgfxTQ643+8t6X4Rub5Y8KPoUwUUuuvXr6gNqGf?=
 =?us-ascii?Q?lAnvqop+QnF6XqxNqBUENjEkQbR//Yue9/aclP7Vsum+Wide07NzyQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3PPF6710BA041.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(10070799003)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ku3pozxvyTrQjUPy1xgBKXqQp2YPLhKc3c317K+3/jMHl5jHrNt6JI0HFw58?=
 =?us-ascii?Q?BtVknzPpG/lm27GoS+kzulGABR3WFa3cREKh3mnqeb4fgvz9+JoOPdFCHXyp?=
 =?us-ascii?Q?dWFBwXqIJnoxCqEDVOZnhh2xvSJaRzn+SprpAnM+bBCFo18+OVm9m3PxoFBP?=
 =?us-ascii?Q?Z9hYYjXjmMxTT+1/5Z6qy/XT5xt1GkWjumZbH0q3H8u4B92gFhGtYPrQvFQH?=
 =?us-ascii?Q?H61PdTGmiIiZhHyaAo7xP8+T7uflHOaFFQ1cknIcn9KFDsDmknfgWHQUA2Qa?=
 =?us-ascii?Q?cEzXp3Suk5R+uZMOKZ+ar33FdxYYmcBvqgR7Pd6OC8WnBA0y4EoZkPHiuypI?=
 =?us-ascii?Q?kRmsqGODNrYpyFJx/9h0GJnMkMmBLUJ8YkopB3jX7GJJ6wBrP2T9XaB4rmQn?=
 =?us-ascii?Q?pExi5YKPhPTRHRygLjWFIKTX5YBFOLkEiEe8uL6S9mpUicRSsUQ41sha1uXt?=
 =?us-ascii?Q?bedgjSLmv+EZ+b4sE8LvLzFJQcznn/t15HpbLzLLAd9v9Bv1VSib2UMBKm1/?=
 =?us-ascii?Q?4IzDvfWq2ee4mUNgA+5uuz5UKgedOdxwr7rHZCaOUubSWCd6DdYocEfr9ohV?=
 =?us-ascii?Q?HbU7eYq4id/xuvznzlkDFe8Etjq9LakOWuneyXffxVyNcXXt2TAAnZA6vVzT?=
 =?us-ascii?Q?eb1sPoPQ6s2RJ47FfUAhLaiahK2Zko33LOs8dgKt/jZ/L1OlIjD8cwm9D1us?=
 =?us-ascii?Q?MoD33gmP9+6c7VF/Ks3fHnA3EiYJ1+ghY25wJgeyVa9ybLw9/PY4Yzw5aJVV?=
 =?us-ascii?Q?oEQji7G62ZoAs3Or/EQ1bwG7dqI7yB2N/ZAODhng5fbWa5vmea8an9t4PmA+?=
 =?us-ascii?Q?uXSzxFpR0GG14gnHoF+W/rnsXUMX2qIdsXQobrlVym+hwAJdDKLmm0AckbYi?=
 =?us-ascii?Q?azhyuXzLoCjXiA5Fcd0dYw/+WBz0RhwH4DeYB210tDgbhwiTDJJ0rjbszWAX?=
 =?us-ascii?Q?kehp8hnX1VuSqgSuXfvSpSkL7F6cD7RhS724dMNsDU354s9m1l5Q+190MWtU?=
 =?us-ascii?Q?qawDOpaT9SHf9s3GVjvNatPi6ISFzw0Sb2VVrMllfh64JIpc0MxEN6oUyUMD?=
 =?us-ascii?Q?Wnw0R7ToqtxslUwaJ0E/YRAzdH3yMFhy4pIph+XsFUEqAK/UZxtROmRboJza?=
 =?us-ascii?Q?xZVC4W5x5SQa9MK2WQ/hLn6lCIk8WR9wX4sSnhnN4aWT+7ozNfGW9t79fcRu?=
 =?us-ascii?Q?nI2CBV+qSi02UhJyu1HV1vFSlEX5PawN2ScxmHmGLcw+6Oikkns9e8Bu//g9?=
 =?us-ascii?Q?pJSNtGlMdusnu94clFg+DJNcNzCwFpi8qzdbFCYo1xr2wFJrMTwIA9+m5b2b?=
 =?us-ascii?Q?MVKAKYRYGe6hWdunQnrL3RLRGs/RzmjYMnBhM8lTL8rOWdIRZCEYDrrMnRMy?=
 =?us-ascii?Q?Ppj8piipMgGpZ4iioR3239yW2jOxaSwDuMKhd5VtSobjTZXkhayXwln2cp/5?=
 =?us-ascii?Q?7RvJ1LHN7/rfO0SAOx+gtpJ6M2itqNzojgHrWwnLJm2f9hwFvXnlJtGOJ7pP?=
 =?us-ascii?Q?uxNmiZUaSG2CgMD0wU0owjW+Q+QKWXqnKSXStyNah4dmLCsB/jjaCh/hugSs?=
 =?us-ascii?Q?2cuH4O2yLwDZpUbtewipY+iCIHfphR2dUeN5k6YE49Ut9tSDJMclQFfom5Aq?=
 =?us-ascii?Q?bz27n9KgEkAmAB5WR5h9P8LE9MoRu4epfMLRGhwrgrX7?=
X-OriginatorOrg: siqol.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5302caba-b09d-4307-cb9c-08ddc44c1e05
X-MS-Exchange-CrossTenant-AuthSource: PN3PPF6710BA041.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:35:35.9035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e93cdbe6-5a59-4d5d-8570-7b6ea0400c3e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +2ZMYLNda6QNqAsaG2kaisTWdLV1JXJofz5ZE74hMjyVFGKP8W7tbgJaIZx+Z0l5gPdRMhwnUEX0PU3cW3TS3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB1440

Change the order of function qualifiers from 'noinline static' to 'static noinline'
in copy_clone_args_from_user for consistency with kernel coding style.

This is a non-functional change intended to improve readability and maintain
consistent ordering of qualifiers across the codebase.

Signed-off-by: Dishank Jogi <dishank.jogi@siqol.com>
---
 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 1ee8eb11f38b..574ff0d983db 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2743,7 +2743,7 @@ SYSCALL_DEFINE5(clone, unsigned long, clone_flags, unsigned long, newsp,
 }
 #endif
 
-noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
+static noinline int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 					      struct clone_args __user *uargs,
 					      size_t usize)
 {
-- 
2.25.1


