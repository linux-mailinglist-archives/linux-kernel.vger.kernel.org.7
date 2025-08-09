Return-Path: <linux-kernel+bounces-761230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB49EB1F5EA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 20:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03770561681
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 18:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9B42D028F;
	Sat,  9 Aug 2025 18:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WAxWnscq"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1435C2C032C
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754765332; cv=fail; b=Xht8yl5W6IQcMzfGbauUFRe7rhD+BPOun2XXG+p4uLGM+16dSVXMG83xHc5G4H1sac+AxQ+KQ9BqFFgdwWRriBvv+1W4laXWsqtpnHf82YO67Q+uvwIZe3xao+0duIjbm90v9GU+ZwbWQ8JQd10Dd0nj3P9ixja6aIO4uyww/Gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754765332; c=relaxed/simple;
	bh=e8HxjyFgK7DJQ7GceirIVly0bhlri80ZkZYf9vxLl3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IKk623lNE8tRYO7k1ra5PC1YahIGHkhvgSylLZw0kSqyRMIm0Kjozh7F5O0nPIFZ595luz5PY615nwXkCtbFISF/I+uijeuemfB/N41AIFo/GnAACcTBBskpU9LAn2ENBp1jNSkFhTQlJVNutrzxtE/Ki9MrvgTSjXSvDz2IgVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WAxWnscq; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OCUIdhDB8YQg/O45iydPeui+1so9vAlGSqpzxshDWCRpB95ejgfu4JYx8Cbu8ttgWtbkB1OKyiDyqQuI5pmD57AGIOSPWdcpe+QSSL/f5TfXQMwKuLuZhyE7c/8RJjzQOWANi5AUMv4Q0U8nUBa2y4zoNd93NxEonabBXVhIkHXjVO2GHfYy/tiQwubo46TttqCbR3ozdP4AtUAayuwnxxPG1EGxy1n2w561N6seMoWp/7lIlQY0mJzIwKrCdSlz9vIWpj7itIwp6DPilKH/2b5FwIgo3HZyS9v+fdbxccz0RbHg2Urx6QCQlNhK1tMOM7tEwZu2ctvC6IdMpKuNEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/3mNCJbtr6vYORhdhpdg10dQbRKUq1MUPmgUP3ROXI=;
 b=kvuvBIGnMq2KC1omk5XKMSOL51//ARpycvQW91989ZR00YpGn8Ui6+ZrgdEP266NBsFF9/f29ZkxHZuCPcCbCeUxr3aB++nzvAAUGL0YHgP4p0eBjPCtEUT7R4DsqI+smHg4uvOp4fAHvBKQafmhUgQEF7cmACHtYoSaidzyx/Dv8k5KpsGqnRVH8AzwQ2X182TETtWDMtdnaUN7Pe9VxF5qpcecdTGbDU3qpqa7yXnvTxtpIL8s2GhjHZAAufQpPwZMH0nnDrPL+9UfNpuT4WYTDcwPlo0RRMcCXfH6GimN5bDJb9K4ZtY2f27GjbggxfkxnkEoR5cByChfg9sPWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/3mNCJbtr6vYORhdhpdg10dQbRKUq1MUPmgUP3ROXI=;
 b=WAxWnscq6NSgsYgl2rK/JlH1j75ePMTaL/Ms1wrQJ9aM7M90NMW8qOdVzmO9ldtub97PPDz7ulnVHs0d7oMBQzH0zS/qv4NGACh/cGkmeYjTQGgmDT3hF8ZBB/D3HyDoA3XvSgHqEXz4fCYdpn7VwnOsP7itvi7D6Tn84Kd82GvbeqGcJ2NSBDSdbdPr+TX8sAAwLtFTihIbQ1nA+NiNeC/Edz32hhrox6nAguAy1Yai3gKiRPW/VkLZAujW/2/BrXT8BPElOP3Hx+6SGkL1FTZwm1dCGRZ72nrRtL0tPqFJN9pi/f3QKWi6sRCyQ5GI7VvUUWyLdoQSsuamtvSVQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MW4PR12MB7310.namprd12.prod.outlook.com (2603:10b6:303:22c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Sat, 9 Aug
 2025 18:48:48 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.9009.017; Sat, 9 Aug 2025
 18:48:48 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Subject: [PATCH -rebased 13/15] sched/deadline: Fix DL server crash in inactive_timer callback
Date: Sat,  9 Aug 2025 14:47:58 -0400
Message-Id: <20250809184800.129831-14-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250809184800.129831-1-joelagnelf@nvidia.com>
References: <20250809184800.129831-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0619.namprd03.prod.outlook.com
 (2603:10b6:408:106::24) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MW4PR12MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bfc064a-a97f-4529-df79-08ddd775608b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?44QuBjWLQgNhIqVtOtiLcYVXSLds+9NECQTOXCWdjnbKBlBJCXoq+Z9o34Tn?=
 =?us-ascii?Q?YWb0wUAAdlmk8CxTi0glYctrL2DPgI78oZf07eAgAleN/KED02vsodErrEeb?=
 =?us-ascii?Q?sh5JFFEiCjqDF8GT9oEIBRE/BZfc9IUPar5iX+N0GNxwdHY2Aebq2oIJKc1a?=
 =?us-ascii?Q?g+rMFfgWPYm8nebNEJkBDLeI8tiG8EKJZxtDGT345eI+Zu90xlGmbRR9JBfp?=
 =?us-ascii?Q?TtE+urBdgWQoNix0+XuvlJ+KL5Q+Gjlqfsf5oRvug1LU483PHRL6+Lo9eet2?=
 =?us-ascii?Q?Xckv7eCcVwt5/t5d2QKJsOBk24l8DwRcNAe6gWcYhCjI+3L0Inf1J0/8h/1y?=
 =?us-ascii?Q?HncVfbFfwWkzfCgaLplzIqEAwENjWLA5OeMFRWflTkco3ZOvN8dKr8MYsprA?=
 =?us-ascii?Q?3hXw6JuWIlV6IiY66DZy93OQWaEsbaDUuvEjXFqv3v+Ji8ohcziT/dwpJji5?=
 =?us-ascii?Q?hbm9y3wAxdOhGjcq+ANEj+gabrncaQ3WtZy5rTV1RRMj7H1NYoefbvpgAWZW?=
 =?us-ascii?Q?C8aAQ07Hhqg5SRSITYAmgd45T+fAWQAseBwIElMkpFUUi9v7yXR+VAuEpiRe?=
 =?us-ascii?Q?TyLfQ2jqgWYNPUJNbaSXBGZPOi2tx0OeckxQkcdsLYDWwkHLYQqDM48DUZSh?=
 =?us-ascii?Q?eLbba8heJIA3ocGOSXawDU+MU6VajGU5FpHqs1BPSUftrrH0M4oFbZwaGQ/I?=
 =?us-ascii?Q?HAjhJ5c7xEqvQQFgbYhVr+jicvHDXazB1KXCK0Fi99lAw0g38tq2BLXw8Wa2?=
 =?us-ascii?Q?3bfxHZmq1xQvUDGAq3Ai2b2kCXEvzN8W7RuLZXbNSvhQlk0eBEQSW2HuWeag?=
 =?us-ascii?Q?+f5TPyRcDZdhLyuGpheQjD6/V5weqiWAZFwZMqUzdDAbm1RyPMyMAIKyTxPv?=
 =?us-ascii?Q?iPqaMSKb9noGmnKi6K1PnZ+qOop/jYKV3iGfcjBPKQ+GAl/JOn3ThKspbztY?=
 =?us-ascii?Q?LBlzkvHiuGPie+L1CQPB4PiMhSIU8dnMi8iijkUzpBedcTM1nbEYdcCZ+0dm?=
 =?us-ascii?Q?8cxPCaPDnKKqb5UV2d/BthKAClOC5VTPqXxSW3xiczNA1J2dag1r0CLtTUx7?=
 =?us-ascii?Q?QI4O0bbEfY07HYO/v0qOTgweVRG88q8HQhCjOjFQ/3ohpMJr2V4TQ3u+Vvb3?=
 =?us-ascii?Q?ioHDr4ZEbh4WkKie373uiRk8l0rIGr9QWUX+A6PSKEBtU0McJJojLmIYkAwD?=
 =?us-ascii?Q?n81IYaiAl/7l2hZnZHC+cBTKvNouaGPUIDh4VVLtl85DiZ2CqPe7imLoMpka?=
 =?us-ascii?Q?dHKF2DdfL2Ljla2TdqfoNWY6NYcfs5+M9eMEJLPLu+wwcCIUyaoUcp3v4wF+?=
 =?us-ascii?Q?8RL/q/4H04NCweWfV6drPzGStIHqb/fPmPYC6gtF5iMci/GP1ZKgaF2EX8RG?=
 =?us-ascii?Q?/T4D7F76EdFA8wwWAiQI1SPR3PUAw1g4DEEM/BWXSPc95xaW1nPeLodSiyIg?=
 =?us-ascii?Q?0otbOEfZyCvpnIDpkG1ec4MsaRhRqQFZZRh1WCe72ySH9VFGI+R4gA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S7tZbqa1fJ1qoGeahpn9LTAHxwctlXf/mtjcLGjJ2HEvoBjc5UPcN4R2Rt8t?=
 =?us-ascii?Q?XC8T8n4qmiN4w8OC2cmFbaGchIJ5Iz/lepcEUxMqpIS0PTXxHG1WGVOJZ6sl?=
 =?us-ascii?Q?oToDjYgCh45DqYACQ/NMX/Tssmxf1z8XwurD2++UpjwrBzNcijBaYsAD5Avm?=
 =?us-ascii?Q?DWhcHxBbgzPAkZwp7dUsO2U8UYbv7crTUChP3k2P+8cRUzWttmsEQ7UwjBs+?=
 =?us-ascii?Q?yuK//lw6fRj7rnNGp3u61YBNQmEod3url1y2lvMYlb7kWPV66YEA6PMrVa81?=
 =?us-ascii?Q?Ujy/97KTPuaH5GuuQqJ1RFw9CQAdBAymRPKWlSn4Ki0wzYsRZ44kRcDDvPSU?=
 =?us-ascii?Q?ZK+lansMHGjh+GvvDJfoZxpNl3E/4IG/dPR5SKHwK4UMWXgtz4oL8v7OIOVy?=
 =?us-ascii?Q?DjB0t6GKPjHATltg1wlt66a7EHJfX3IT5bsxirXgrKfWJuvhtomJAi8hmRQp?=
 =?us-ascii?Q?FHGM0+3fcjG8ziPADI8Jy9260t39gyMUNkipaamzoaC94lkJeM6ZVnAEN7IU?=
 =?us-ascii?Q?7ICTV36dPowYnwXp0eeh3MmVrwz5vS9lJIabBZ9ECH+BCCGGxSNe0Uyy58HN?=
 =?us-ascii?Q?4FEgyy6dD//FcUxGcBfXF4T+jpbKqFMxSJ6WfEXPdPw9v57Ep6cad7YdT9Z0?=
 =?us-ascii?Q?o0uhl3+8amsjWih4/bSsjY2w1rFAgIPaHo9C69I3lrSeUmD2dQJSc7p+2qrU?=
 =?us-ascii?Q?53Z6oaR8Uvr29luQvweOgLy+5F4qcSM6qFozy5sdVqax60UD8Ysi/NMjMt69?=
 =?us-ascii?Q?hq8nbSXFFltqHgrgHwDM2KZsXG//uc9xdpc1ApBziZ2Hf8dMaLJKk494A9Q0?=
 =?us-ascii?Q?wtsufECmGn88i2xMcPAArGWwc8mq+CNdusFa58utjFkD8jfL4fMydHJihorD?=
 =?us-ascii?Q?cyCjggj+9i7g2H2Y+4GlyFmw6B3h6Fvqm1uDQCwN7yORbaV2ExWbBj4B12ME?=
 =?us-ascii?Q?sGyVt6H8AWjkmvIv4GY08QzHJV3zojD+p1i+vCGpWqEe3AkYzaGYfD+FRUSF?=
 =?us-ascii?Q?ID6MUNQbI2LJGIkmOuF4aWGgmGDs4DDDOScPnoH+yeVlrwTD6OwkKZ6MjXsw?=
 =?us-ascii?Q?WSkFXzA4+k1q5+r85uqQUKpJa8gC622qW//yevloJTeoa6I2rJYqXqELHwrI?=
 =?us-ascii?Q?40p7yzkvpNRSZ3Kn0GvHKYTL+HsltuDalTBV3sHTjCdo3sGqkMaVhQYh5irY?=
 =?us-ascii?Q?3NDXjMtLki0uxPB/h1DeigKeDTmxWFEG3VYsBDntVNc7pxTI8Tv84JPLRFch?=
 =?us-ascii?Q?gKiEc4ZePcS2Qe+A7DU5Zsw1BGB5N5mWSuOnCrVmy72B5xLUOhgh+vsp/pFb?=
 =?us-ascii?Q?+0X1DXi/z6AY3ZWSw6HD4rsa3D1du2wTnN5UCh2AKbzYCl7tvZbHrrDQ/kiT?=
 =?us-ascii?Q?2MsR0AsSrgeprmnUYm5bw5ek65pMBhL3Pi9nMHyDGB3q7j7PriEw/yJVd0o0?=
 =?us-ascii?Q?CAaOLIUSM4vnKX3ULnD3T974Jb0ygB4chabhl5DtCQ6362zBU9Q6Q5cLvzjZ?=
 =?us-ascii?Q?hYcxSAaEfMV5YHB0v3sz8EI+xSYH0LDRl0kIveLbpJnaDL6IAdm5815CIec9?=
 =?us-ascii?Q?EBJNDB+79WFojOZRETptSSWs7PewAPqXOkre+r11?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bfc064a-a97f-4529-df79-08ddd775608b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 18:48:48.8154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gpBpldQX4b3VCTnla6YLrWKYDKVHs00WLiwf2Gdsg+P+VKhTPujNPpUc4EM0h9nYfYov4Gd2ejDTcJQyPPGjnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7310

When sched_ext is rapidly disabled/enabled (the reload_loop selftest),
the following crash is observed. This happens because the timer handler
could not be cancelled and still fires even though the dl_server
bandwidth may have been removed.
hrtimer_try_to_cancel() does not guarantee timer cancellation. This
results in a NULL pointer dereference as 'p' is bogus for a dl_se.

I think this happens because the timer may be about to run, but its
softirq has not executed yet. Because of that hrtimer_try_to_cancel()
cannot prevent the timer from being canceled, however dl_server is still
set to 0 by dl_server_apply_params(). When the timer handler eventually
runs, it crashes.

[   24.771835] BUG: kernel NULL pointer dereference, address: 000000000000006c
[   24.772097] #PF: supervisor read access in kernel mode
[   24.772248] #PF: error_code(0x0000) - not-present page
[   24.772404] PGD 0 P4D 0
[   24.772499] Oops: Oops: 0000 [#1] SMP PTI
[   24.772614] CPU: 9 UID: 0 PID: 0 Comm: swapper/9 [..] #74 PREEMPT(voluntary)
[   24.772932] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), [...]
[   24.773149] Sched_ext: maximal (disabling)
[   24.773944] RSP: 0018:ffffb162c0348ee0 EFLAGS: 00010046
[   24.774100] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff88d4412f1800
[   24.774302] RDX: 0000000000000001 RSI: 0000000000000010 RDI: ffffffffac939240
[   24.774498] RBP: ffff88d47e65b940 R08: 0000000000000010 R09: 00000008bad3370a
[   24.774742] R10: 0000000000000000 R11: ffffffffa9f159d0 R12: ffff88d47e65b900
[   24.774962] R13: ffff88d47e65b960 R14: ffff88d47e66a340 R15: ffff88d47e66aed0
[   24.775182] FS:  0000000000000000(0000) GS:ffff88d4d1d56000(0000) knlGS:[...]
[   24.775392] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   24.775579] CR2: 000000000000006c CR3: 0000000002bb0003 CR4: 0000000000770ef0
[   24.775810] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   24.776023] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   24.776225] PKRU: 55555554
[   24.776292] Call Trace:
[   24.776373]  <IRQ>
[   24.776453]  ? __pfx_inactive_task_timer+0x10/0x10
[   24.776591]  __hrtimer_run_queues+0xf1/0x270
[   24.776744]  hrtimer_interrupt+0xfa/0x220
[   24.776847]  __sysvec_apic_timer_interrupt+0x4d/0x190
[   24.776988]  sysvec_apic_timer_interrupt+0x69/0x80
[   24.777132]  </IRQ>
[   24.777194]  <TASK>
[   24.777256]  asm_sysvec_apic_timer_interrupt+0x1a/0x20

Fix, by also checking the DL server's has_task pointer which only exists
for server tasks. This fixes the crash.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/deadline.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 7891a7bf43d6..836adfb0201c 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1807,7 +1807,13 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 	struct rq_flags rf;
 	struct rq *rq;
 
-	if (!dl_server(dl_se)) {
+	/*
+	 * It is possible that after dl_server_apply_params(), the dl_se->dl_server == 0,
+	 * but the inactive timer is still queued and could not get canceled. Double check
+	 * by looking at ->server_has_tasks to make sure we're dealing with a non-server
+	 * here. Otherwise p may be bogus and we'll crash.
+	 */
+	if (!dl_server(dl_se) && !dl_se->server_has_tasks) {
 		p = dl_task_of(dl_se);
 		rq = task_rq_lock(p, &rf);
 	} else {
@@ -1818,7 +1824,7 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 	sched_clock_tick();
 	update_rq_clock(rq);
 
-	if (dl_server(dl_se))
+	if (dl_server(dl_se) || dl_se->server_has_tasks)
 		goto no_task;
 
 	if (!dl_task(p) || READ_ONCE(p->__state) == TASK_DEAD) {
@@ -1846,7 +1852,7 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 	dl_se->dl_non_contending = 0;
 unlock:
 
-	if (!dl_server(dl_se)) {
+	if (!dl_server(dl_se) && !dl_se->server_has_tasks) {
 		task_rq_unlock(rq, p, &rf);
 		put_task_struct(p);
 	} else {
-- 
2.34.1


