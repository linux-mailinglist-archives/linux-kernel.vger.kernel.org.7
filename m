Return-Path: <linux-kernel+bounces-738598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00308B0BAD9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 04:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 907A01896667
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 02:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFAE142E67;
	Mon, 21 Jul 2025 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="toy6J5TI"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2130.outbound.protection.outlook.com [40.107.237.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7911DBA36
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 02:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753065627; cv=fail; b=nNyqPf0pOMH9SNMu4s9VNvWsjktWgdLq1FxhJCUzJRy1hFr9Ld5weJyAOGeBghycrAqqRHh93lR9g0bGm/rp9KdtqrbNcfsj67pewT8FrmvkKka86Q9oVAdn7rdNKCH4/bDqQcN5uTNyeV4LsMC3UPpSVVele5D8rijZ19dzS3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753065627; c=relaxed/simple;
	bh=ad0nwzmbMAr+WNOFoAE3P3EX4E6kUx7K3CM/KPzfOPY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=a21m4dxYy4V/hfua3qDSOtPi7x2fRupDJkrC+xkHKuSQPIy9rz0O/sajAItRxTobpVJ7m3RFhDRLbbQ2hU3+Wk0qGNiFKCLH/I8Sz198UwOft6Esy5spnV35qkBskGAcn2tWRXQ2cgPCA/VJiCnrfP5CpnMi9LymQUFr2YLGbvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=toy6J5TI; arc=fail smtp.client-ip=40.107.237.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UrD7Pf2xx/zJzLjYNqUMvHOm3fDECAsNok0Dn0NFFDcKwBdRy/AxYugE+5+HoEjGD22kY1cLlpGfOsiX16XStBkSnmkbTdMDgNg2Xkj/a2CH4d1rgKbt4GTRpwhcq3t8ceUhFj/MQ7lcuvoI1KgHYK2XOX86IKY5awE7Cv+eQZJr8ciVG62EoqhcotKEphVQIZlC0zva3pCy9XDo2FDgFtXjsoPs23oTU6laKQVFKe7Lbds0E2ShC/4SKMip6R5g6TAxJul0lm7In+DjKr9VDWihe05NDd+DgYLtIvDGKFh8E+2GyLsSH/RIc2BPQVM87HSXJl6mXZPAqCnePdPdIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBWX5+yjc36KazCH/DMVgmRqkyUbFYkArOHih3EVB3w=;
 b=ZcBQPn1w0FjT/kW3JJEfIxqFcAAAQ7D4yEDYUb3BDPgrOoM1QF6Plchwn4QJssndeZa0owC4BsbB2P1t/7zzt3HMIKBlQy2nvj0+BiT1kRiqcgjkQgVK5WutVf0kwXPv+uAHWk6u1UiQ0WToD/ol7rwyiKvjTct1c07kz4RHtMEc/T0O/8yYHcwD5233FpN/PxJ5mOtoIXlgmEsj+JATn6KBs2nFt2MJwVdzlaI5w2BeBpGfP+fyYCA0bGHYLOcSZ55fw+O+S1fO7GsHy0l/yxY46HwH3bWeXhGXPtX3fo59bjCsRtRG7deh/Gcww3MudrjeAgbwjJD6EtcLU9F7+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBWX5+yjc36KazCH/DMVgmRqkyUbFYkArOHih3EVB3w=;
 b=toy6J5TIHE58cll1vR8YtUjWMpIiiLA2gSO6fJF8asuGg44LY6vDwBo2Uy2EbyHBFJE5a0gx1HRPwkR+rvTCc4dHv6hjrKIY+8h3uS+Go5pRASXgOg7K+TJNQoFpmpVylnvUPJjrSF6xWwuUYkuDIa0G0qTe/Yy9ZuG/gBDOPY8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 SJ0PR01MB7299.prod.exchangelabs.com (2603:10b6:a03:3f3::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.28; Mon, 21 Jul 2025 02:40:20 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%4]) with mapi id 15.20.8943.028; Mon, 21 Jul 2025
 02:40:20 +0000
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
Subject: [PATCH v4] sched/fair: do not scan twice in detach_tasks()
Date: Mon, 21 Jul 2025 10:39:39 +0800
Message-Id: <20250721023939.19703-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|SJ0PR01MB7299:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f577108-abec-479a-d91f-08ddc7ffef4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WSjK4dftYLhQRYIBxsvMUQjFM81UshvjQJBl8mZQl6jEsItveUZTxxf3b4nC?=
 =?us-ascii?Q?fkWJkwDypmJnuHJMs43/W+baUHsnX3aQZuSXWEplDWxPeGaFBOH013wTja1V?=
 =?us-ascii?Q?ALT3sA5cdBzUj3aaGLeQm3R5Mf8Y4PFANNHxcVGNmTnlbHlg97JCWoeVFHjZ?=
 =?us-ascii?Q?9eJ6SlofXrHqREzCV+8WvlkVbYsZIc0U0yoZQ0tCVW8/kykUNtnE+6R0xmSs?=
 =?us-ascii?Q?jA7h7h4rtsyvd3Go9D2D/yIpBE4aSAIME8T0JqvU0Urj/PcHWkUXW/giIVgb?=
 =?us-ascii?Q?jGZmN1JtS2+2TKx7QxADKH5lyx0F44C75ZcIKesgiICLwpVGdzqYOtAESe8u?=
 =?us-ascii?Q?p7e1KpTiPXqFVLiGgyElyCSzsRYRam3IXi6hp+0eQ13RDdgPUimqXRJu0sV6?=
 =?us-ascii?Q?WB8SoOjnTekRBu3Uz5euEw4yHHcgPkb2MPmaX82A8uwp0Zb/CzPokALSbO/E?=
 =?us-ascii?Q?4Sajbj7zsMImjuqrsB3uRD1qrLF++qBHyEbgnsXXFjVwRhv/Vj4e51xkYe7u?=
 =?us-ascii?Q?fSjrqp114LynrCuoVsyBgmmu27oaw6gb6X6hwxfI2jRG6S/Y7djLsWwZIlDk?=
 =?us-ascii?Q?mRmbkvPywgqrG2GIgfGiMV2J22KB9MD4eELHROsaOF/0ZxtRcvrRFIX9DSZF?=
 =?us-ascii?Q?9hrU0Tdf/D+XXzH/wXJweWBEAn8F5bxDSlVyRSNl/fnxJgjXbqmkn1hX2LeE?=
 =?us-ascii?Q?Kf46/6zD89WaXKU2zh6rIT640HfdEO+OyXONNPOnINMIfc/8ykGANnRjDOlQ?=
 =?us-ascii?Q?8R3P76q9lKzQ2EtyV8tYqQQNDjZ7hXmCK2H19fuSf+r6BqWD/oVc/Agasyc+?=
 =?us-ascii?Q?tSBSV7QDWKIKNZzJxhs2x6E2grvdSjTP+WZ3AEeZalqn4HnOEA90ij3uLBtI?=
 =?us-ascii?Q?4OcWjZaKzPPMmwLJuiaSqCalZxjNLzO0IGnsYGz/akbvKYBU4fk+ipNFRZoC?=
 =?us-ascii?Q?AX+t1EDSUmXI7fJJ6XNhblSU88SSLwnmISSPC6kJNLHiPHyxNhjzVYOGs1Yq?=
 =?us-ascii?Q?GawV+o7BfhtGnljESH9wJGNytWxhwVSL6h0HHeVvMHZZG1sFJwxs46FAFNBp?=
 =?us-ascii?Q?jMnxIquTntfmqzXNAgdZsVuUFVF6gu7zkCL6llr25WvEzVXFS6RGdn6NQk5Z?=
 =?us-ascii?Q?6nFqv+5Wkrc78pSuzc/VVvgumnrr182dcTAASgOgBLW21+P1QXiL3RxWy6HZ?=
 =?us-ascii?Q?Xi8Yr21m/dZN7g6DO44MvJCHnbe09uEl1zgQFJSrBFcDv2V27Kr3mWFLGjX6?=
 =?us-ascii?Q?1FQf/pRl1wfimWgBTM7ZD85f1+SWv/HpVdAqOGmxN/6GZRyRATf/0V+vlpkg?=
 =?us-ascii?Q?ugg/M3jIg1oYtf/yRQhiZ+DXebNzYaa/eqfV8yvevf57ht+K8Y6CQUaEbvOa?=
 =?us-ascii?Q?RS0H/pQCGNZC+Uc68IAvGyH5HbdH6EqYcpqAkWZU1F1C1dIsAyRi/7hfbtfS?=
 =?us-ascii?Q?Iplg+54tagpLm2fjC03O4hNkuzf9HmHRp1Z6hqThBIK9fW0HZuKA89qmaJRm?=
 =?us-ascii?Q?mG09nus7AnZszDU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4f4y8389HaG9o61iv7vCJtgkHMINSQ+X8NZDIzUus2N687dMtPNKKLGtelqT?=
 =?us-ascii?Q?aI+IdWK/HQpEKC3Ra6zyiPubXiY0NNymyP0TkMaZVlsRXZCxHfn/VyRaG3xW?=
 =?us-ascii?Q?qjA7aKchgLwmvNsYVdXKl+8fGv8d0ySy4G4OlCf1sk+uBSBot02Kr7N68lNn?=
 =?us-ascii?Q?JgiJMcz9JknM0+yq3wKIopStlupBQe0l8+RzqBQSPG9hLFIOyLM7+7wh70MY?=
 =?us-ascii?Q?6hk/W5ehis5BrS9cYt9OFez7innn/BzRYTtAJHQ6/f01tvekLK1BkEPDz2gP?=
 =?us-ascii?Q?Iu15ammvlWO7Y3nKNRZDaj99oU82Ou6HZxQYAZC9YaSFN5P7dtPjUdL5WhH8?=
 =?us-ascii?Q?I8LEBFUYSR5NYGAse3oIWnxmiIXu5jY2ZXyjeN2Yev3LPS5zPSzg+KBxnwpl?=
 =?us-ascii?Q?86uwwEvo5b8fkWgjlv+S0DSams68zfYQsIMkbGOo1Je0JaRUAW0k5Kh/PV2I?=
 =?us-ascii?Q?l+OzYTiV9NQHTNvOANDZ0afvFiXdyTFHNu+HJniyJG33sYfRBYesLI8SP+Pz?=
 =?us-ascii?Q?1XaXeyevwDFvjSJDBVC49ijes59J2Y4ziBXGhVCyh7RNvUiDIQNMNb7PWfKk?=
 =?us-ascii?Q?ngCvyXVIehv+pgXg0/UoYtHqq0sOG2greYsmKZ3NRTz7YAHQbOZbTjyb6KFq?=
 =?us-ascii?Q?8qxyE9bt9Og8SC36YNhrO1s1zC55meDTVTxEF0UGd7YsBD5rvWdfqfFxMyxF?=
 =?us-ascii?Q?q49QrdgpI235AWDHN2gwFKBTY5w13zgzy0Np3RnDVMoPgHRj4jYFVSZ6+re6?=
 =?us-ascii?Q?q4ESSZ1uHMetHOSKhDkgXILT3wG8fmR9szpf1xkTR2ipiIL0zAg7sgcby1bp?=
 =?us-ascii?Q?HJUN5rNznEayRI+f6R8zxTPGuc18mGbriCYlDr293kA0oFU4BySqbfLhk/Hg?=
 =?us-ascii?Q?88oM7TpjWdlifGFdhRtTMqHC26jIYmGl8/pZA+YVzOsvC2a/jP2T9tI7o2I7?=
 =?us-ascii?Q?l5GO4WwMogbavJHfHDShHEly3ZzNtGu1wKu3cYcVT/jko0vdd0QjKQyEZzk6?=
 =?us-ascii?Q?rRRNL0VPNh8y0ej83RxzHmUIB1UnPdEi2tQ2K8mNCUuj4RCdzjhYPUqPR8Zi?=
 =?us-ascii?Q?PaQMIUwIH2fqRId9NEgLfnr4PdcO97zoNpn86qwCe6IFtLrf2wnPhQiG3j7u?=
 =?us-ascii?Q?zrPViAEyR32ullnm/jRpBx3atHA/Wme3wOuT+iJxT+iYGeqHaBALoqhyaYXw?=
 =?us-ascii?Q?zowg4Y8LKrDcmcs6xWdjHmyShH0jTRR0+VLzr/XQhuQt+YNOf9lBSHbPqGMc?=
 =?us-ascii?Q?wW9YMTh1FtiN4Hxu/6ZTNNPd6xi7FIf6lAXpiSf02r0zZHDsrpW/nsIaINFd?=
 =?us-ascii?Q?uRU+bIAN/PGFmm+qa28zE3LsiqcVDK75Kl3LkgNSMgEqOkxieMb7Ihn9BQdd?=
 =?us-ascii?Q?uZ9PtKivezz/NnnspQfFKwpvULE++CM8sdu/EH1t2l+TFbCu/xAMrpPvXzUT?=
 =?us-ascii?Q?aHT1UAqDZzAjBgmjRAw6MYa0gpHQFx7rnWiv3Cc3Ibyr/+2ZABGI6hglS3ET?=
 =?us-ascii?Q?WDj5vqcM86u0c2PCYyItma1pTe9FdcsG1709ptXMd7jqxj+wpDRBMmjiOIBt?=
 =?us-ascii?Q?BUNPUfsyhksoBEobAXMeI+NbQ5z5omOAkqcmSC9QJrzTdTcSdze0Fi2CWIkF?=
 =?us-ascii?Q?YYo/qLHqQD9SZ9jzD/wcHJM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f577108-abec-479a-d91f-08ddc7ffef4e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 02:40:20.6882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fevLy1ICR1E5eDJHqv3/cIWfu+6LbiCDAO0+D2ENcUAdV5uV7QYE0RG2ByVDcKs2egg+bFt25YtDFIXXNz+nACIsuYKZ8emPvHgEbd/kr3PEN0eH3bctVT+iwQIAPpHl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB7299

detach_tasks() uses struct lb_env.loop_max as an env.src_rq->cfs_tasks
iteration count limit. It is however set without the source RQ lock held,
and besides detach_tasks() can be re-invoked after releasing and
re-acquiring the RQ lock per LBF_NEED_BREAK.

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

The patch introduces "first_back" to record the first task which
is put back to the task list. If we get a task which is equal to
first_back, we break the loop, and avoid to scan twice for it.

Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
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
 kernel/sched/fair.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7e2963efe800..7cc9d50e3e11 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9443,6 +9443,7 @@ static int detach_tasks(struct lb_env *env)
 {
 	struct list_head *tasks = &env->src_rq->cfs_tasks;
 	unsigned long util, load;
+	struct task_struct *first_back = NULL;
 	struct task_struct *p;
 	int detached = 0;
 
@@ -9481,6 +9482,12 @@ static int detach_tasks(struct lb_env *env)
 		}
 
 		p = list_last_entry(tasks, struct task_struct, se.group_node);
+		/*
+		 * We're back to an already visited task that couldn't be
+		 * detached, we've seen all there is to see.
+		 */
+		if (p == first_back)
+			break;
 
 		if (!can_migrate_task(p, env))
 			goto next;
@@ -9562,6 +9569,8 @@ static int detach_tasks(struct lb_env *env)
 			schedstat_inc(p->stats.nr_failed_migrations_hot);
 
 		list_move(&p->se.group_node, tasks);
+		if (!first_back)
+			first_back = p;
 	}
 
 	/*
-- 
2.40.1


