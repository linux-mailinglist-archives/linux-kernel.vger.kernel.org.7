Return-Path: <linux-kernel+bounces-755025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 167EEB1A02B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80DA53A9CF1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B9B22D7B6;
	Mon,  4 Aug 2025 11:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UfDdusvz"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E930252904
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 11:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754305509; cv=fail; b=e/2aEEWp3SjY3V25X+OyBaNF+OgExd0n1XTzNq8of4qzNWw77Y5tTA1uNoGjVT8o21YmB1Ye+gY+h+GPRegmjCCZKIoSYgRwXaji3qcr8NzMzy/yXHVzoSL53hxFCR0X+Fb14+LbA8m0dzGcJ84gN2+0VM22PW4SWi4KP+f6m1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754305509; c=relaxed/simple;
	bh=+Dnnsf7V5Jr6HR7prGfEEg5/XepbdklOpZ6KQ0VjXHM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hSbutbtGbh8JU8wL5qCWj3VXNNLCfPjAYuaxsqYk4GKsMLqBTWZP+qMe9luseYoGi5m5o8b+8cmzYA8hK+l7chpHSZhlDDEtUfQr9Lr4RwnGFC3VUsZrpx8UIAUmto9agQG/X0P2gDTeg5djdSzaVELvorTFPvltO79hxwyNQmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UfDdusvz; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FHOC+imH2BSq8o4su2OI8HxmJg11f7qizPaPp2PjYooC0HxMgjOacN2k9Cr5CsCbXrMnT7goA/UrhF8oPga3crza/tK8Nr+0/ILpTOswGXepYckKE/MANfJfbqyFYHVm3HDMbIKLb1MNj2CDxqAXHsKYsRuS8+UjtCvdjcSIYEw8YOlFiVOf3/jhOvlR4QRzddnpHjHuHTJ04/GOZ7SGsvwpP3LdmgDN1EwyniBPdV8YiZT5IcsJKq/4bOzPyR0JrcmaMS0EPbw4xT4af4sPEQKlhhGiYX/K0qUZaX8SU2v+SuP7R+miYXIV1IYBwaaThwxfmOVo8ghQKhzhczIeIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvKhtpUc16i2m0vNVg0829QViGqbGkdcY1u43YNhCY0=;
 b=JgaDQi2KJBxiUvQ4Ciw3ps6xVEBecWikM7ntcUGP57I/ehDFBMOr0ux2lfA8r38Jj4nO6ZpIYr+ACWc/RjTHW2u4FqgCgq94HZRc+I7UO7+Vaui57hagQSgth+987VatQ5bhyfs2GX8s/Ce0m+rN4n1xp6Kgk/Wuep5ykEtLr3a1rWlB+StQwYzXFjAV7DrEXYOQIm0n+8DUEXIvxXbyI+TqLUeae7/1F7FA0XShpEv7f5sZJTqJ+jleBrH0h5tIFopRKdj1GTkvEYtWSworFp0FPQ/jYNdQjsWmFMwWFAgMWKKQCAla3jwsD7i9RHRZJQHz96zBy7hm/9vOW+TY5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvKhtpUc16i2m0vNVg0829QViGqbGkdcY1u43YNhCY0=;
 b=UfDdusvz8ENNk9o+6IinELY32ZDxeZnRlbTRFbWNuK3VJF25Kj7W7j49cIe1dBBxv75UCUSMQYheljsblBaZtXwyXofMQKkt2uZx1gkQEX3lbxr/wqT7vughiGDaZ/lZmesNbI1LcogJMELin+8/ldX7GN8WhUG9lpo7Zgy5ekSGSGyLezJALTxE/pT0bPwvzA3JLPLuZXhKmHo473rg6rfvqE1PsQO/c8jU2AJwKdOxgczJfaVE7qs0PZYidw5UKDKWAcpmc9WdUcjZklrr8iCQd/+Rm5PtmlXuQKvGtJgIXQ6xVMZCsVn7VQiB+huIXOUYf7IW4pTfr1QThrWiuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 11:04:57 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 11:04:57 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH] tools/sched_ext: Receive updates from SCX repo
Date: Mon,  4 Aug 2025 13:04:49 +0200
Message-ID: <20250804110449.696135-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZRAP278CA0015.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::25) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: 78eb29db-9abc-498c-532b-08ddd346bf5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ej8Et5WIQfgwpnmujn0AvV2WKwlnXxIrTblgYjUB0CJdu315slRLRvDSzab6?=
 =?us-ascii?Q?PrqMvqbf+s5Pwmvmugwv8t5zcv2N2l2Fh89Aid0krL2kVuuSnaUkU+rU17Zz?=
 =?us-ascii?Q?z0SI28EHuY3am4yW+ikAUtIoJL+BlgNmUQtOu1w/ofC2sChUTdfw5f803pJV?=
 =?us-ascii?Q?+Oy6G3OlBIfXCn6bhstOLkv+pmP3WYX+7adn7RU2ABkQ7E8N9ql8tZ/x4x6n?=
 =?us-ascii?Q?td9aPQOZjd7GP4lvcbFGIc80iMBg/lEqfdwF7er3HTownzYHS0QK2XHsf4Vn?=
 =?us-ascii?Q?A5KiMJYS+CN5GXsVjxUdxMNbko8TyMnYM3JRlkokQ8wlEPexSqGZ3pdDTl1q?=
 =?us-ascii?Q?hIAtN+GAmOD+dG/5YJP091Th2LgwgJNdi0mtdPgjpfSdIFdYhQV/878RkCwY?=
 =?us-ascii?Q?AcpWo3mdbWXTOErEmJoAHUpk96tfLcHVpC8I8Q/AZ069xN/fxWKNmNTShOkc?=
 =?us-ascii?Q?aQbdwDLUA/GBFb/fyc3pAGhaO/1ZDDbtV5Uoy5nKTIWRpyodRB99KkusdPQ4?=
 =?us-ascii?Q?BkcV81T23vNI0SxbbPj+1pUF1EMeP1X35Kk7acSALqf2MNDrHeMpZWNexXPr?=
 =?us-ascii?Q?w9Jqyo4HcmET6uQguDFFwCFQKTvQr1E4FS+Lgg0UXieAvO2H2jGWg2Yr9gMb?=
 =?us-ascii?Q?HiDoAaMdMiREcJ6d0c5bnNLDO+wKeOJW978DE+Em8FTVU3PSxjEVxrIpU57z?=
 =?us-ascii?Q?S8KHQNTvSWKxla+XJhilMa7dQOaBJyp24b4xegLe+1MCZMsm8slU8d9REcl3?=
 =?us-ascii?Q?VAO/AngQYcxjsAAOpMADbOT8hoED+Z0Q2HvyLmMsAoYZ2E+gzWxW1eWVBpsd?=
 =?us-ascii?Q?5lgDPgg+fsv9gFf0eVacchAXKX1TWn4PUVu7qfohs5WQJX7NwTudA/D1rVug?=
 =?us-ascii?Q?O0Zdkn25KA9IRJAkGikv8QXEDR2+/FFv/jqi6wuXpGRRMB9V2vqzR7VnmcCD?=
 =?us-ascii?Q?+ALoxcxkjmYiwBAOnB6ystFBNU0FaxQm6IZdyeyi2VTEsKZ4N7dut7CksBrI?=
 =?us-ascii?Q?KLL/ee/69UWC4Qucm0sXsFkzmoJzVEy1foq+EhtJqvZNeBH6s2WP3+qqUbZz?=
 =?us-ascii?Q?sFDxzePGi/hamiRio+P7VDxRfO+q2lt9l2cbogDNWZlG16H3HKcxFns7Ol+7?=
 =?us-ascii?Q?LoVXScBx81eDMxkN7J8kH6OXpV2ymyNZ21KTpPlWeCpFICyVTZhvMW/wuMvr?=
 =?us-ascii?Q?MtUCtBum7S4qgA0lcOYrhtqOOe+DlBkq0aWohrGq0W8nQoPiIoBlTNsWJL2k?=
 =?us-ascii?Q?nM+ER6pyV7LBv/1UxPv3en2P9PxWwuzjAN6R4Df6UXuUGpjOlNvw7LOavlCW?=
 =?us-ascii?Q?HMEK//D621tlYf/SGFL9uR227iG0eX+eYZB24SYTrSUFzYTBJyFICh4SI+AK?=
 =?us-ascii?Q?M4NEFZZVHZSM6wP9S6gaTJy8ypKxBLBpig9OFbLeJ0RAQO2SRWH03f1Met4b?=
 =?us-ascii?Q?0WFVVfBmhEc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nd8K65i56sgpwa5r4YaNSqIgfKGY3Ny9YBXET8o40wttNmURyQSDDPMME+CX?=
 =?us-ascii?Q?vwJ6ooarzc68oVAQf2U01fzW+a/e3pLZgP+LJH4NR4W17CAEohNoul6nGvyg?=
 =?us-ascii?Q?lZ7o4JoQARQdJBlJ+IHWrSIdqCbuBiVfpdWWYTStgXf60Hyvs5mK5TkhLv84?=
 =?us-ascii?Q?hjm1NKij3od5Lk/I+7hx8oYMCJRYYmBlvAldMhGadL/DRQ4jvZC8qYUIFkIX?=
 =?us-ascii?Q?OsIwf0SBCi3UFd5xSyFN4BVcqX1haPtDpfRfWHb8HTMyYHcXYYAY+m0L1L9D?=
 =?us-ascii?Q?dV//92w4DSGmVii1YszFr7exIcR+LUZS1ngpdKELbyxF1ISDuoya23TGhgtb?=
 =?us-ascii?Q?bDVLUAV2qhHNOcWiLzaM2069DQtuc9VBMjIuW856coMgXjtsQmjPKlFDqqc8?=
 =?us-ascii?Q?E7fvi4mfkaSau+u+jctqbAva10Gr4duy6AAb8lhX7eCbATcofb0jny/BQx1h?=
 =?us-ascii?Q?k79CCvqvcriRFcd5BRERQWVohwbAdJjiZ6Lc0z4kN7Jh+1Tuns3V2HymfRi8?=
 =?us-ascii?Q?VzvL2ek8SztEQEEoqlvnOJxTDxXROcMIEAiq08ovDlPjCeDy0Or7imLVwArx?=
 =?us-ascii?Q?XnY7/Ey+U5ujQCYtUxcJieqkGQEv6w+CGtSEBSoqOafTlcPyFoQNDaQfscfF?=
 =?us-ascii?Q?d+2rdmre2s68dCORCT3hw19Gp/7/e15mV7Kfr2ShvhM2q2EetEwE3xHUrpmg?=
 =?us-ascii?Q?JyfAUgkBFGLaIAl9GtgHffHO+MLY+wb84NE9jdPpeNUnTqNll7qi1MnjIsfz?=
 =?us-ascii?Q?RXJuPwH1C+0gg3RXQxOCiyoOmEP8S510RL4tsVUNaRU8l4vaBtbqGoKmKLc2?=
 =?us-ascii?Q?U/8+PgZucqOdHsKYM5J+Sg5C6J4wbCet8jybLttNCaTiuRlGL6Md0RB8AF5c?=
 =?us-ascii?Q?GdGIkLmjSezcBCpvaNet+hSnftIKtJtMLzJDY9+bdJzqak3mQDxRjf+pq0KS?=
 =?us-ascii?Q?eJ1GyFVj5Z9poU8c/RNfISHrxi/Tw+qeetFmFhUDhIQvcfaRO/8zolyCUfGB?=
 =?us-ascii?Q?HyOXw4CVdJlLfdbN3glhmE2sH4km8HewUBM+ZNAQ0pRruCIQUEZ4h1KFzEnq?=
 =?us-ascii?Q?agoSFLJ7yjTP+JPStTdOGgXr5fXnnPYOu/E38HnJCGinLEBBT3yazKaWh+mG?=
 =?us-ascii?Q?6GAqnFK1jA+t2O0Wlia47loUKZKxEwiPYyAjnks7OU6A05mQrJcUJ0WkLNpN?=
 =?us-ascii?Q?gDCRrn5NM97nZ+Gc9LbIgnu0ex0FMoJbV3wLpTr6A8DXoosWTSnDRBWHzVab?=
 =?us-ascii?Q?4f7ERa8uLcFVQHwXiGje0B2EZCHNoBF4AZ1TS9RUOVzlZnh8qhq3Rnwrq8T8?=
 =?us-ascii?Q?SrY0HfYZT08x+VUdqUDiXp7sNGZjK/KgEzur7Dp9HYhZddsP6l52g8gDNvue?=
 =?us-ascii?Q?QF9/LSMSnawPTjwH2VAM00rR8P1yNIyXUFQdih2Jojh9YExbs+UFcy8p8pLO?=
 =?us-ascii?Q?QZ0UfDlaZGDAvrbKMk5NfeczbVcKa8u182iVKE3HDjnhUvdrxqnhfKWvllrb?=
 =?us-ascii?Q?Ol02H3JSoaYLcpMCc5PZ885+yUO+hTGrpd3VwHcfduxLbCDkFc5EvEJOnaPY?=
 =?us-ascii?Q?oodaJyAHR6MniwoJ+Ge/gC/WvJDDvm6nL0JeKqU7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78eb29db-9abc-498c-532b-08ddd346bf5b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 11:04:57.0957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YauiNkRw1aiZiN4FZEKhP3e5Ldv/P5K/ZtHpKt2OprEu8QLITkYq1FI0J/V+6fFOz9YOeNjFD+XuqiwcfotWpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5757

Receive tools/sched_ext updates form https://github.com/sched-ext/scx to
sync userspace bits:

 - basic BPF arena allocator abstractions,

 - additional process flags definitions,

 - fixed is_migration_disabled() helper,

 - separate out user_exit_info BPF and user space code.

This also fixes the following warning when building the selftests:

 tools/sched_ext/include/scx/common.bpf.h:550:9: warning: 'likely' macro redefined [-Wmacro-redefined]
  550 | #define likely(x) __builtin_expect(!!(x), 1)
      |         ^

Co-developed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 .../include/scx/bpf_arena_common.bpf.h        | 175 ++++++++++++++++++
 .../sched_ext/include/scx/bpf_arena_common.h  |  33 ++++
 tools/sched_ext/include/scx/common.bpf.h      | 102 +++++++++-
 tools/sched_ext/include/scx/common.h          |   5 +-
 tools/sched_ext/include/scx/compat.bpf.h      |   5 +
 .../include/scx/user_exit_info.bpf.h          |  40 ++++
 tools/sched_ext/include/scx/user_exit_info.h  |  49 +----
 .../include/scx/user_exit_info_common.h       |  30 +++
 tools/sched_ext/scx_central.bpf.c             |   2 +-
 tools/sched_ext/scx_central.c                 |   1 +
 tools/sched_ext/scx_flatcg.bpf.c              |   2 +-
 tools/sched_ext/scx_flatcg.c                  |   2 +
 tools/sched_ext/scx_simple.c                  |   2 +
 13 files changed, 388 insertions(+), 60 deletions(-)
 create mode 100644 tools/sched_ext/include/scx/bpf_arena_common.bpf.h
 create mode 100644 tools/sched_ext/include/scx/bpf_arena_common.h
 create mode 100644 tools/sched_ext/include/scx/user_exit_info.bpf.h
 create mode 100644 tools/sched_ext/include/scx/user_exit_info_common.h

ChangeLog:
 - Import only the bare minimum changes required by the scheduler examples
   and the selftests
 - Link to the previous patch:
   https://lore.kernel.org/all/20250723120746.52847-1-yphbchou0911@gmail.com/

diff --git a/tools/sched_ext/include/scx/bpf_arena_common.bpf.h b/tools/sched_ext/include/scx/bpf_arena_common.bpf.h
new file mode 100644
index 0000000000000..4366fb3c91ce8
--- /dev/null
+++ b/tools/sched_ext/include/scx/bpf_arena_common.bpf.h
@@ -0,0 +1,175 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#pragma once
+
+#ifndef PAGE_SIZE
+#define PAGE_SIZE __PAGE_SIZE
+/*
+ * for older kernels try sizeof(struct genradix_node)
+ * or flexible:
+ * static inline long __bpf_page_size(void) {
+ *   return bpf_core_enum_value(enum page_size_enum___l, __PAGE_SIZE___l) ?: sizeof(struct genradix_node);
+ * }
+ * but generated code is not great.
+ */
+#endif
+
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST) && !defined(BPF_ARENA_FORCE_ASM)
+#define __arena __attribute__((address_space(1)))
+#define __arena_global __attribute__((address_space(1)))
+#define cast_kern(ptr) /* nop for bpf prog. emitted by LLVM */
+#define cast_user(ptr) /* nop for bpf prog. emitted by LLVM */
+#else
+
+/* emit instruction:
+ * rX = rX .off = BPF_ADDR_SPACE_CAST .imm32 = (dst_as << 16) | src_as
+ *
+ * This is a workaround for LLVM compiler versions without
+ * __BPF_FEATURE_ADDR_SPACE_CAST that do not automatically cast between arena
+ * pointers and native kernel/userspace ones. In this case we explicitly do so
+ * with cast_kern() and cast_user(). E.g., in the Linux kernel tree,
+ * tools/testing/selftests/bpf includes tests that use these macros to implement
+ * linked lists and hashtables backed by arena memory. In sched_ext, we use
+ * cast_kern() and cast_user() for compatibility with older LLVM toolchains.
+ */
+#ifndef bpf_addr_space_cast
+#define bpf_addr_space_cast(var, dst_as, src_as)\
+	asm volatile(".byte 0xBF;		\
+		     .ifc %[reg], r0;		\
+		     .byte 0x00;		\
+		     .endif;			\
+		     .ifc %[reg], r1;		\
+		     .byte 0x11;		\
+		     .endif;			\
+		     .ifc %[reg], r2;		\
+		     .byte 0x22;		\
+		     .endif;			\
+		     .ifc %[reg], r3;		\
+		     .byte 0x33;		\
+		     .endif;			\
+		     .ifc %[reg], r4;		\
+		     .byte 0x44;		\
+		     .endif;			\
+		     .ifc %[reg], r5;		\
+		     .byte 0x55;		\
+		     .endif;			\
+		     .ifc %[reg], r6;		\
+		     .byte 0x66;		\
+		     .endif;			\
+		     .ifc %[reg], r7;		\
+		     .byte 0x77;		\
+		     .endif;			\
+		     .ifc %[reg], r8;		\
+		     .byte 0x88;		\
+		     .endif;			\
+		     .ifc %[reg], r9;		\
+		     .byte 0x99;		\
+		     .endif;			\
+		     .short %[off];		\
+		     .long %[as]"		\
+		     : [reg]"+r"(var)		\
+		     : [off]"i"(BPF_ADDR_SPACE_CAST) \
+		     , [as]"i"((dst_as << 16) | src_as));
+#endif
+
+#define __arena
+#define __arena_global SEC(".addr_space.1")
+#define cast_kern(ptr) bpf_addr_space_cast(ptr, 0, 1)
+#define cast_user(ptr) bpf_addr_space_cast(ptr, 1, 0)
+#endif
+
+void __arena* bpf_arena_alloc_pages(void *map, void __arena *addr, __u32 page_cnt,
+				    int node_id, __u64 flags) __ksym __weak;
+void bpf_arena_free_pages(void *map, void __arena *ptr, __u32 page_cnt) __ksym __weak;
+
+/*
+ * Note that cond_break can only be portably used in the body of a breakable
+ * construct, whereas can_loop can be used anywhere.
+ */
+#ifdef TEST
+#define can_loop true
+#define __cond_break(expr) expr
+#else
+#ifdef __BPF_FEATURE_MAY_GOTO
+#define can_loop					\
+	({ __label__ l_break, l_continue;		\
+	bool ret = true;				\
+	asm volatile goto("may_goto %l[l_break]"	\
+		      :::: l_break);			\
+	goto l_continue;				\
+	l_break: ret = false;				\
+	l_continue:;					\
+	ret;						\
+	})
+
+#define __cond_break(expr)				\
+	({ __label__ l_break, l_continue;		\
+	asm volatile goto("may_goto %l[l_break]"	\
+		      :::: l_break);			\
+	goto l_continue;				\
+	l_break: expr;					\
+	l_continue:;					\
+	})
+#else
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+#define can_loop					\
+	({ __label__ l_break, l_continue;		\
+	bool ret = true;				\
+	asm volatile goto("1:.byte 0xe5;		\
+		      .byte 0;				\
+		      .long ((%l[l_break] - 1b - 8) / 8) & 0xffff;	\
+		      .short 0"				\
+		      :::: l_break);			\
+	goto l_continue;				\
+	l_break: ret = false;				\
+	l_continue:;					\
+	ret;						\
+	})
+
+#define __cond_break(expr)				\
+	({ __label__ l_break, l_continue;		\
+	asm volatile goto("1:.byte 0xe5;		\
+		      .byte 0;				\
+		      .long ((%l[l_break] - 1b - 8) / 8) & 0xffff;	\
+		      .short 0"				\
+		      :::: l_break);			\
+	goto l_continue;				\
+	l_break: expr;					\
+	l_continue:;					\
+	})
+#else
+#define can_loop					\
+	({ __label__ l_break, l_continue;		\
+	bool ret = true;				\
+	asm volatile goto("1:.byte 0xe5;		\
+		      .byte 0;				\
+		      .long (((%l[l_break] - 1b - 8) / 8) & 0xffff) << 16;	\
+		      .short 0"				\
+		      :::: l_break);			\
+	goto l_continue;				\
+	l_break: ret = false;				\
+	l_continue:;					\
+	ret;						\
+	})
+
+#define __cond_break(expr)				\
+	({ __label__ l_break, l_continue;		\
+	asm volatile goto("1:.byte 0xe5;		\
+		      .byte 0;				\
+		      .long (((%l[l_break] - 1b - 8) / 8) & 0xffff) << 16;	\
+		      .short 0"				\
+		      :::: l_break);			\
+	goto l_continue;				\
+	l_break: expr;					\
+	l_continue:;					\
+	})
+#endif /* __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__ */
+#endif /* __BPF_FEATURE_MAY_GOTO */
+#endif /* TEST */
+
+#define cond_break __cond_break(break)
+#define cond_break_label(label) __cond_break(goto label)
+
+
+void bpf_preempt_disable(void) __weak __ksym;
+void bpf_preempt_enable(void) __weak __ksym;
diff --git a/tools/sched_ext/include/scx/bpf_arena_common.h b/tools/sched_ext/include/scx/bpf_arena_common.h
new file mode 100644
index 0000000000000..10141db0b59d0
--- /dev/null
+++ b/tools/sched_ext/include/scx/bpf_arena_common.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#pragma once
+
+#ifndef arena_container_of
+#define arena_container_of(ptr, type, member)			\
+	({							\
+		void __arena *__mptr = (void __arena *)(ptr);	\
+		((type *)(__mptr - offsetof(type, member)));	\
+	})
+#endif
+
+/* Provide the definition of PAGE_SIZE. */
+#include <sys/user.h>
+
+#define __arena
+#define __arg_arena
+#define cast_kern(ptr) /* nop for user space */
+#define cast_user(ptr) /* nop for user space */
+char __attribute__((weak)) arena[1];
+
+#ifndef offsetof
+#define offsetof(type, member)  ((unsigned long)&((type *)0)->member)
+#endif
+
+static inline void __arena* bpf_arena_alloc_pages(void *map, void *addr, __u32 page_cnt,
+						  int node_id, __u64 flags)
+{
+	return NULL;
+}
+static inline void bpf_arena_free_pages(void *map, void __arena *ptr, __u32 page_cnt)
+{
+}
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index d4e21558e9826..86abdb3c3142a 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -24,14 +24,26 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <asm-generic/errno.h>
-#include "user_exit_info.h"
+#include "user_exit_info.bpf.h"
 #include "enum_defs.autogen.h"
 
+#define PF_IDLE				0x00000002	/* I am an IDLE thread */
+#define PF_IO_WORKER			0x00000010	/* Task is an IO worker */
 #define PF_WQ_WORKER			0x00000020	/* I'm a workqueue worker */
+#define PF_KCOMPACTD			0x00010000      /* I am kcompactd */
+#define PF_KSWAPD			0x00020000      /* I am kswapd */
 #define PF_KTHREAD			0x00200000	/* I am a kernel thread */
 #define PF_EXITING			0x00000004
 #define CLOCK_MONOTONIC			1
 
+#ifndef NR_CPUS
+#define NR_CPUS 1024
+#endif
+
+#ifndef NUMA_NO_NODE
+#define	NUMA_NO_NODE	(-1)
+#endif
+
 extern int LINUX_KERNEL_VERSION __kconfig;
 extern const char CONFIG_CC_VERSION_TEXT[64] __kconfig __weak;
 extern const char CONFIG_LOCALVERSION[64] __kconfig __weak;
@@ -107,6 +119,9 @@ void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __ksym __
 static inline __attribute__((format(printf, 1, 2)))
 void ___scx_bpf_bstr_format_checker(const char *fmt, ...) {}
 
+#define SCX_STRINGIFY(x) #x
+#define SCX_TOSTRING(x) SCX_STRINGIFY(x)
+
 /*
  * Helper macro for initializing the fmt and variadic argument inputs to both
  * bstr exit kfuncs. Callers to this function should use ___fmt and ___param to
@@ -141,13 +156,15 @@ void ___scx_bpf_bstr_format_checker(const char *fmt, ...) {}
  * scx_bpf_error() wraps the scx_bpf_error_bstr() kfunc with variadic arguments
  * instead of an array of u64. Invoking this macro will cause the scheduler to
  * exit in an erroneous state, with diagnostic information being passed to the
- * user.
+ * user. It appends the file and line number to aid debugging.
  */
 #define scx_bpf_error(fmt, args...)						\
 ({										\
-	scx_bpf_bstr_preamble(fmt, args)					\
+	scx_bpf_bstr_preamble(							\
+		__FILE__ ":" SCX_TOSTRING(__LINE__) ": " fmt, ##args)		\
 	scx_bpf_error_bstr(___fmt, ___param, sizeof(___param));			\
-	___scx_bpf_bstr_format_checker(fmt, ##args);				\
+	___scx_bpf_bstr_format_checker(						\
+		__FILE__ ":" SCX_TOSTRING(__LINE__) ": " fmt, ##args);		\
 })
 
 /*
@@ -229,6 +246,7 @@ BPF_PROG(name, ##args)
  * be a pointer to the area. Use `MEMBER_VPTR(*ptr, .member)` instead of
  * `MEMBER_VPTR(ptr, ->member)`.
  */
+#ifndef MEMBER_VPTR
 #define MEMBER_VPTR(base, member) (typeof((base) member) *)			\
 ({										\
 	u64 __base = (u64)&(base);						\
@@ -245,6 +263,7 @@ BPF_PROG(name, ##args)
 		  [max]"i"(sizeof(base) - sizeof((base) member)));		\
 	__addr;									\
 })
+#endif /* MEMBER_VPTR */
 
 /**
  * ARRAY_ELEM_PTR - Obtain the verified pointer to an array element
@@ -260,6 +279,7 @@ BPF_PROG(name, ##args)
  * size of the array to compute the max, which will result in rejection by
  * the verifier.
  */
+#ifndef ARRAY_ELEM_PTR
 #define ARRAY_ELEM_PTR(arr, i, n) (typeof(arr[i]) *)				\
 ({										\
 	u64 __base = (u64)arr;							\
@@ -274,7 +294,7 @@ BPF_PROG(name, ##args)
 		  [max]"r"(sizeof(arr[0]) * ((n) - 1)));			\
 	__addr;									\
 })
-
+#endif /* ARRAY_ELEM_PTR */
 
 /*
  * BPF declarations and helpers
@@ -438,8 +458,27 @@ static __always_inline const struct cpumask *cast_mask(struct bpf_cpumask *mask)
  */
 static inline bool is_migration_disabled(const struct task_struct *p)
 {
-	if (bpf_core_field_exists(p->migration_disabled))
-		return p->migration_disabled;
+	/*
+	 * Testing p->migration_disabled in a BPF code is tricky because the
+	 * migration is _always_ disabled while running the BPF code.
+	 * The prolog (__bpf_prog_enter) and epilog (__bpf_prog_exit) for BPF
+	 * code execution disable and re-enable the migration of the current
+	 * task, respectively. So, the _current_ task of the sched_ext ops is
+	 * always migration-disabled. Moreover, p->migration_disabled could be
+	 * two or greater when a sched_ext ops BPF code (e.g., ops.tick) is
+	 * executed in the middle of the other BPF code execution.
+	 *
+	 * Therefore, we should decide that the _current_ task is
+	 * migration-disabled only when its migration_disabled count is greater
+	 * than one. In other words, when  p->migration_disabled == 1, there is
+	 * an ambiguity, so we should check if @p is the current task or not.
+	 */
+	if (bpf_core_field_exists(p->migration_disabled)) {
+		if (p->migration_disabled == 1)
+			return bpf_get_current_task_btf() != p;
+		else
+			return p->migration_disabled;
+	}
 	return false;
 }
 
@@ -476,7 +515,7 @@ static inline s64 time_delta(u64 after, u64 before)
  */
 static inline bool time_after(u64 a, u64 b)
 {
-	 return (s64)(b - a) < 0;
+	return (s64)(b - a) < 0;
 }
 
 /**
@@ -500,7 +539,7 @@ static inline bool time_before(u64 a, u64 b)
  */
 static inline bool time_after_eq(u64 a, u64 b)
 {
-	 return (s64)(a - b) >= 0;
+	return (s64)(a - b) >= 0;
 }
 
 /**
@@ -547,9 +586,15 @@ static inline bool time_in_range_open(u64 a, u64 b, u64 c)
  */
 
 /* useful compiler attributes */
+#ifndef likely
 #define likely(x) __builtin_expect(!!(x), 1)
+#endif
+#ifndef unlikely
 #define unlikely(x) __builtin_expect(!!(x), 0)
+#endif
+#ifndef __maybe_unused
 #define __maybe_unused __attribute__((__unused__))
+#endif
 
 /*
  * READ/WRITE_ONCE() are from kernel (include/asm-generic/rwonce.h). They
@@ -632,6 +677,26 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
 	__u.__val;								\
 })
 
+/*
+ * __calc_avg - Calculate exponential weighted moving average (EWMA) with
+ * @old and @new values. @decay represents how large the @old value remains.
+ * With a larger @decay value, the moving average changes slowly, exhibiting
+ * fewer fluctuations.
+ */
+#define __calc_avg(old, new, decay) ({						\
+	typeof(decay) thr = 1 << (decay);					\
+	typeof(old) ret;							\
+	if (((old) < thr) || ((new) < thr)) {					\
+		if (((old) == 1) && ((new) == 0))				\
+			ret = 0;						\
+		else								\
+			ret = ((old) - ((old) >> 1)) + ((new) >> 1);		\
+	} else {								\
+		ret = ((old) - ((old) >> (decay))) + ((new) >> (decay));	\
+	}									\
+	ret;									\
+})
+
 /*
  * log2_u32 - Compute the base 2 logarithm of a 32-bit exponential value.
  * @v: The value for which we're computing the base 2 logarithm.
@@ -662,6 +727,25 @@ static inline u32 log2_u64(u64 v)
                 return log2_u32(v) + 1;
 }
 
+/*
+ * sqrt_u64 - Calculate the square root of value @x using Newton's method.
+ */
+static inline u64 __sqrt_u64(u64 x)
+{
+	if (x == 0 || x == 1)
+		return x;
+
+	u64 r = ((1ULL << 32) > x) ? x : (1ULL << 32);
+
+	for (int i = 0; i < 8; ++i) {
+		u64 q = x / r;
+		if (r <= q)
+			break;
+		r = (r + q) >> 1;
+	}
+	return r;
+}
+
 /*
  * Return a value proportionally scaled to the task's weight.
  */
diff --git a/tools/sched_ext/include/scx/common.h b/tools/sched_ext/include/scx/common.h
index 1dc76bd842966..b3c6372bcf810 100644
--- a/tools/sched_ext/include/scx/common.h
+++ b/tools/sched_ext/include/scx/common.h
@@ -75,8 +75,9 @@ typedef int64_t s64;
 #include "enums.h"
 
 /* not available when building kernel tools/sched_ext */
-#if __has_include(<lib/sdt_task.h>)
-#include <lib/sdt_task.h>
+#if __has_include(<lib/sdt_task_defs.h>)
+#include "bpf_arena_common.h"
+#include <lib/sdt_task_defs.h>
 #endif
 
 #endif	/* __SCHED_EXT_COMMON_H */
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 9252e1a00556f..36e0cd2fd4eda 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -38,6 +38,7 @@ void scx_bpf_dispatch_from_dsq_set_slice___compat(struct bpf_iter_scx_dsq *it__i
 void scx_bpf_dispatch_from_dsq_set_vtime___compat(struct bpf_iter_scx_dsq *it__iter, u64 vtime) __ksym __weak;
 bool scx_bpf_dispatch_from_dsq___compat(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
 bool scx_bpf_dispatch_vtime_from_dsq___compat(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
+int bpf_cpumask_populate(struct cpumask *dst, void *src, size_t src__sz) __ksym __weak;
 
 #define scx_bpf_dsq_insert(p, dsq_id, slice, enq_flags)				\
 	(bpf_ksym_exists(scx_bpf_dsq_insert) ?					\
@@ -82,6 +83,10 @@ bool scx_bpf_dispatch_vtime_from_dsq___compat(struct bpf_iter_scx_dsq *it__iter,
 	  scx_bpf_dispatch_vtime_from_dsq___compat((it__iter), (p), (dsq_id), (enq_flags)) : \
 	  false))
 
+#define __COMPAT_bpf_cpumask_populate(cpumask, src, size__sz)		\
+	(bpf_ksym_exists(bpf_cpumask_populate) ?			\
+	 (bpf_cpumask_populate(cpumask, src, size__sz)) : -EOPNOTSUPP)
+
 #define scx_bpf_dispatch(p, dsq_id, slice, enq_flags)				\
 	_Static_assert(false, "scx_bpf_dispatch() renamed to scx_bpf_dsq_insert()")
 
diff --git a/tools/sched_ext/include/scx/user_exit_info.bpf.h b/tools/sched_ext/include/scx/user_exit_info.bpf.h
new file mode 100644
index 0000000000000..e7ac6611a9901
--- /dev/null
+++ b/tools/sched_ext/include/scx/user_exit_info.bpf.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Define struct user_exit_info which is shared between BPF and userspace parts
+ * to communicate exit status and other information.
+ *
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
+
+#ifndef __USER_EXIT_INFO_BPF_H
+#define __USER_EXIT_INFO_BPF_H
+
+#ifndef LSP
+#include "vmlinux.h"
+#endif
+#include <bpf/bpf_core_read.h>
+
+#include "user_exit_info_common.h"
+
+#define UEI_DEFINE(__name)							\
+	char RESIZABLE_ARRAY(data, __name##_dump);				\
+	const volatile u32 __name##_dump_len;					\
+	struct user_exit_info __name SEC(".data")
+
+#define UEI_RECORD(__uei_name, __ei) ({						\
+	bpf_probe_read_kernel_str(__uei_name.reason,				\
+				  sizeof(__uei_name.reason), (__ei)->reason);	\
+	bpf_probe_read_kernel_str(__uei_name.msg,				\
+				  sizeof(__uei_name.msg), (__ei)->msg);		\
+	bpf_probe_read_kernel_str(__uei_name##_dump,				\
+				  __uei_name##_dump_len, (__ei)->dump);		\
+	if (bpf_core_field_exists((__ei)->exit_code))				\
+		__uei_name.exit_code = (__ei)->exit_code;			\
+	/* use __sync to force memory barrier */				\
+	__sync_val_compare_and_swap(&__uei_name.kind, __uei_name.kind,		\
+				    (__ei)->kind);				\
+})
+
+#endif /* __USER_EXIT_INFO_BPF_H */
diff --git a/tools/sched_ext/include/scx/user_exit_info.h b/tools/sched_ext/include/scx/user_exit_info.h
index 66f856640ee7e..399697fa372fb 100644
--- a/tools/sched_ext/include/scx/user_exit_info.h
+++ b/tools/sched_ext/include/scx/user_exit_info.h
@@ -10,55 +10,11 @@
 #ifndef __USER_EXIT_INFO_H
 #define __USER_EXIT_INFO_H
 
-#ifdef LSP
-#define __bpf__
-#include "../vmlinux.h"
-#endif
-
-enum uei_sizes {
-	UEI_REASON_LEN		= 128,
-	UEI_MSG_LEN		= 1024,
-	UEI_DUMP_DFL_LEN	= 32768,
-};
-
-struct user_exit_info {
-	int		kind;
-	s64		exit_code;
-	char		reason[UEI_REASON_LEN];
-	char		msg[UEI_MSG_LEN];
-};
-
-#ifdef __bpf__
-
-#ifndef LSP
-#include "vmlinux.h"
-#endif
-#include <bpf/bpf_core_read.h>
-
-#define UEI_DEFINE(__name)							\
-	char RESIZABLE_ARRAY(data, __name##_dump);				\
-	const volatile u32 __name##_dump_len;					\
-	struct user_exit_info __name SEC(".data")
-
-#define UEI_RECORD(__uei_name, __ei) ({						\
-	bpf_probe_read_kernel_str(__uei_name.reason,				\
-				  sizeof(__uei_name.reason), (__ei)->reason);	\
-	bpf_probe_read_kernel_str(__uei_name.msg,				\
-				  sizeof(__uei_name.msg), (__ei)->msg);		\
-	bpf_probe_read_kernel_str(__uei_name##_dump,				\
-				  __uei_name##_dump_len, (__ei)->dump);		\
-	if (bpf_core_field_exists((__ei)->exit_code))				\
-		__uei_name.exit_code = (__ei)->exit_code;			\
-	/* use __sync to force memory barrier */				\
-	__sync_val_compare_and_swap(&__uei_name.kind, __uei_name.kind,		\
-				    (__ei)->kind);				\
-})
-
-#else	/* !__bpf__ */
-
 #include <stdio.h>
 #include <stdbool.h>
 
+#include "user_exit_info_common.h"
+
 /* no need to call the following explicitly if SCX_OPS_LOAD() is used */
 #define UEI_SET_SIZE(__skel, __ops_name, __uei_name) ({					\
 	u32 __len = (__skel)->struct_ops.__ops_name->exit_dump_len ?: UEI_DUMP_DFL_LEN;	\
@@ -114,5 +70,4 @@ enum uei_ecode_mask {
 
 #define UEI_ECODE_RESTART(__ecode)	(UEI_ECODE_SYS_ACT((__ecode)) == SCX_ECODE_ACT_RESTART)
 
-#endif	/* __bpf__ */
 #endif	/* __USER_EXIT_INFO_H */
diff --git a/tools/sched_ext/include/scx/user_exit_info_common.h b/tools/sched_ext/include/scx/user_exit_info_common.h
new file mode 100644
index 0000000000000..2d0981aedd898
--- /dev/null
+++ b/tools/sched_ext/include/scx/user_exit_info_common.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Define struct user_exit_info which is shared between BPF and userspace parts
+ * to communicate exit status and other information.
+ *
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
+#ifndef __USER_EXIT_INFO_COMMON_H
+#define __USER_EXIT_INFO_COMMON_H
+
+#ifdef LSP
+#include "../vmlinux.h"
+#endif
+
+enum uei_sizes {
+	UEI_REASON_LEN		= 128,
+	UEI_MSG_LEN		= 1024,
+	UEI_DUMP_DFL_LEN	= 32768,
+};
+
+struct user_exit_info {
+	int		kind;
+	s64		exit_code;
+	char		reason[UEI_REASON_LEN];
+	char		msg[UEI_MSG_LEN];
+};
+
+#endif /* __USER_EXIT_INFO_COMMON_H */
diff --git a/tools/sched_ext/scx_central.bpf.c b/tools/sched_ext/scx_central.bpf.c
index 50bc1737c167a..55df8b7988657 100644
--- a/tools/sched_ext/scx_central.bpf.c
+++ b/tools/sched_ext/scx_central.bpf.c
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * A central FIFO sched_ext scheduler which demonstrates the followings:
+ * A central FIFO sched_ext scheduler which demonstrates the following:
  *
  * a. Making all scheduling decisions from one CPU:
  *
diff --git a/tools/sched_ext/scx_central.c b/tools/sched_ext/scx_central.c
index 6ba6e610eeaa0..55931a4cd71c7 100644
--- a/tools/sched_ext/scx_central.c
+++ b/tools/sched_ext/scx_central.c
@@ -61,6 +61,7 @@ int main(int argc, char **argv)
 	skel->rodata->nr_cpu_ids = libbpf_num_possible_cpus();
 	skel->rodata->slice_ns = __COMPAT_ENUM_OR_ZERO("scx_public_consts", "SCX_SLICE_DFL");
 
+	assert(skel->rodata->nr_cpu_ids > 0);
 	assert(skel->rodata->nr_cpu_ids <= INT32_MAX);
 
 	while ((opt = getopt(argc, argv, "s:c:pvh")) != -1) {
diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index fdc7170639e60..2c720e3ecad59 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -950,5 +950,5 @@ SCX_OPS_DEFINE(flatcg_ops,
 	       .cgroup_move		= (void *)fcg_cgroup_move,
 	       .init			= (void *)fcg_init,
 	       .exit			= (void *)fcg_exit,
-	       .flags			= SCX_OPS_ENQ_EXITING,
+	       .flags			= SCX_OPS_HAS_CGROUP_WEIGHT | SCX_OPS_ENQ_EXITING,
 	       .name			= "flatcg");
diff --git a/tools/sched_ext/scx_flatcg.c b/tools/sched_ext/scx_flatcg.c
index 6dd423eeb4ff9..cd85eb4011793 100644
--- a/tools/sched_ext/scx_flatcg.c
+++ b/tools/sched_ext/scx_flatcg.c
@@ -6,6 +6,7 @@
  */
 #include <stdio.h>
 #include <signal.h>
+#include <assert.h>
 #include <unistd.h>
 #include <libgen.h>
 #include <limits.h>
@@ -137,6 +138,7 @@ int main(int argc, char **argv)
 	skel = SCX_OPS_OPEN(flatcg_ops, scx_flatcg);
 
 	skel->rodata->nr_cpus = libbpf_num_possible_cpus();
+	assert(skel->rodata->nr_cpus > 0);
 	skel->rodata->cgrp_slice_ns = __COMPAT_ENUM_OR_ZERO("scx_public_consts", "SCX_SLICE_DFL");
 
 	while ((opt = getopt(argc, argv, "s:i:dfvh")) != -1) {
diff --git a/tools/sched_ext/scx_simple.c b/tools/sched_ext/scx_simple.c
index 76d83199545cb..06d4b13bf76bc 100644
--- a/tools/sched_ext/scx_simple.c
+++ b/tools/sched_ext/scx_simple.c
@@ -7,6 +7,7 @@
 #include <stdio.h>
 #include <unistd.h>
 #include <signal.h>
+#include <assert.h>
 #include <libgen.h>
 #include <bpf/bpf.h>
 #include <scx/common.h>
@@ -41,6 +42,7 @@ static void sigint_handler(int simple)
 static void read_stats(struct scx_simple *skel, __u64 *stats)
 {
 	int nr_cpus = libbpf_num_possible_cpus();
+	assert(nr_cpus > 0);
 	__u64 cnts[2][nr_cpus];
 	__u32 idx;
 
-- 
2.50.1


