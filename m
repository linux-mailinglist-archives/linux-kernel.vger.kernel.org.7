Return-Path: <linux-kernel+bounces-736285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D40B09B00
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 231924A2CE2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 05:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B731CBEB9;
	Fri, 18 Jul 2025 05:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Ih84zWw7"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022138.outbound.protection.outlook.com [52.101.43.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF9072623
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 05:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752817677; cv=fail; b=kTEytsDf+ln7Ab9Zt7DwmiomDJmSNgyk/Y9tNkXKnl0tN5eBCHwEQJr9qkGJs+VYWf6lrQggW96uMMClwt32/7JUuYTtXYvFla07VkJzW2kh/NV8gvFAykU89XwheDTQO5ulc888PWPXljS8xa3zX9Cq7d44L1IUoyCP+lcqtRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752817677; c=relaxed/simple;
	bh=wmNwDDscePTE+wWt4CSj9wr3Wb5tsUHZirJORhT7lnk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CmHckkjIAndHtmAAnxKGoVjDhwJF34Dvsq76W2aTB9SBjh3ZfBryZ1WDZmFNhd3xcl9Yu3+VjGxsoQfb8jEVSEFO0OawDbJEZFCGXnqmsbGGg0rBfz3VZEsTyaz9376CXtEtAQXOO/9QMBH05n3BqEuXlDEqOAaq/aZovMjJ7J0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Ih84zWw7; arc=fail smtp.client-ip=52.101.43.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZwW2fC0eF1exX/DmsJAoukFnhrr3rxlWe/kYGa/w2dgXrTr2JxjEx5Qdc09a6I1ELcrCHteQIryW4yxhPJNl+AFKX8flGvfslrkjHs5Pc7sUhDIiFVNdtDNTBdSXDh0HgVbi0ECP0p9BbAqf1+4/Z5eTeXGRCv6/h48KJZCPHiDHgTNj6788fnyl16RLqbTtzPuagu+LDblzwyuH9A25ZCmkJkFynylQGTZ8XPDTBRpHNX6HKfJAn6iXz5bnG7UBTJvuyweH8O6FZadnuG67Wr4ZtBdNxydEYqpUhI9XKQYOXPFzcJnrooevWS98JWa3g7ucTpM53ZD6DU4XU1r/Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwDSUoc5Dv9AZtz5wo9QPO676QHbvV3B7T+ZDkigRhE=;
 b=WR25H6uw0ULdA42sHUBTf1TI/F4X+CYox4lWy19Rfeihr3pdcT/zd4sDXQ10xSY7yTsdCln7lyGPOgMcspSWCL6T+QRGbbWGmRXu5fBxIdfCuzQNV5em9Tq0uA38QpZcA1U5GAJe1JJICA0vcUQD7o/XmvvUHA6SojDFn3bEHiNN6+M2vVz+wAQT63UK7r7TcUyp9IBjTIFZ/p1H70t8VoMVtc0aLPUrNiTAZc/EX08io0225W/EopXBKh1tX657YcE9/7HMNZYhgj7aSFZnZuAkCC+8cUViNppR1fjb7+A2MzxYqRcsfIK97ESfwVlEgz5ljhZGJFeuPJKgV1xQQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwDSUoc5Dv9AZtz5wo9QPO676QHbvV3B7T+ZDkigRhE=;
 b=Ih84zWw7E47gZflNZu9PvA75dgVqkZEp/5diDbbc0EbhrDlGT4B69Rw2fduUXmwilIwWlTP+TaVyeUyMboCJsXSVOp8rXQRNvdaQMX9Y+A4LAgqG/+ipH566mains+SizZKqcCrwwYoIEL01P6X+kO5n+B9J5MAsTs67fOwbUZM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 CH0PR01MB6953.prod.exchangelabs.com (2603:10b6:610:106::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.39; Fri, 18 Jul 2025 05:47:50 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%7]) with mapi id 15.20.8922.028; Fri, 18 Jul 2025
 05:47:50 +0000
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
Subject: [PATCH v2] sched/fair: do not scan twice in detach_tasks()
Date: Fri, 18 Jul 2025 13:47:09 +0800
Message-Id: <20250718054709.8781-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|CH0PR01MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: f27b1eaa-a3b4-47a0-be67-08ddc5bea167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KqeFrynkVYD+qucT5u2+1K9XyAFfWO/sVFjWVuHuNLN8rDXN4HdiyGzIPGsb?=
 =?us-ascii?Q?mNik6g9Oba2mtxceBlnzlKe/zbA5xWTaTxmGrV8lYI50JpjhUVUMVIWvwq8e?=
 =?us-ascii?Q?cX7bCXzUaZw6nrEEG4YYow+icgyi2rZj28kIvjfYSCQLtvVEBFhhyTQDn+Os?=
 =?us-ascii?Q?G7IImgtS/ev5KfUIFFGYXwBz9gHvRnLZ0ruuU3Ejo0zh1Y3oBT2bv1gbEJ9+?=
 =?us-ascii?Q?PvS7jWPNWINboG+87l3dKePj7PSW9XCnUcj1MGM5B+xWQ0pOQj9g31eRgBoq?=
 =?us-ascii?Q?7g8/egdJVeehbDfmjXKaYb+q93OJaJ0PPL8O6fk8RkoOQdc/xpSqxn/vn6n3?=
 =?us-ascii?Q?ienGb8oN0YtPJOl0WT9Z+ZrflG00TH7shC9KNCYeaMsmMFIw0iTJz+cI9tab?=
 =?us-ascii?Q?uCi3ZvznnijkZbiyWCtjcYnWbs9rASvGykU5aJbfc+JlQP5+lNZlTGcF2kxo?=
 =?us-ascii?Q?EfhjKrGRsCi0PAaB/YyUxb/CgFtNgJlCoWK5B+ChIP46PrEpa5nIjj1IM2gf?=
 =?us-ascii?Q?+aDKAj86Ni4QnNxwPxBQLwdplo8rCvf/rEBLpInDWYguLJB8+o4xf0q8R1dV?=
 =?us-ascii?Q?nWiifFc7LQBdMPRrIn9DcTFUsYrWTXWidJafNTn3xssgpWYEtSjuE6MwlPjV?=
 =?us-ascii?Q?VgDOSuX4NvRuyWCqwVbQrB/SSm+xD2cRJBVueEjyj7pl+12uBXw5i0V9mNNj?=
 =?us-ascii?Q?Ma4Z8l6AgIkrR1ZseQUUfdxASMeckhumMDEk+SfdzBRuAnKqNBpQhghFrBhH?=
 =?us-ascii?Q?bcXNqBExiwCIkknJ+QeJ3T6+74KIPe2n6kYj94J/vhizYtq/BNtZ2pvGYbni?=
 =?us-ascii?Q?XkMRsemzQywIzbnJ2wNA7qmTtNaqBKW0IRUZWewd+N5qdlsv9FALeJPqJGu1?=
 =?us-ascii?Q?m5PGmMwT6oiJOaKyQLXlCa+qyytVnPaeL4jDKlKcEFFW9rpOmQHM8sSXQMTI?=
 =?us-ascii?Q?ClxQTDAGvL1AY8RmtKmSp4DLOfgDUfcL0aAChsmZ1YRpI30JKI/08FX70grS?=
 =?us-ascii?Q?nIGd8MhPeZViBQ2JB1I0HQHNCS4NmEiIY0NODrMstmKHrFWwFmomoHytANDX?=
 =?us-ascii?Q?J0euMPulugW7kLCQIyUpkwQiOpDscVslBGd1YGhVxP6YF0UHnMxWJzpwpCpw?=
 =?us-ascii?Q?FMYZdcV0zxpDX/mmpv99pmHGe1RiTA4Wz4KzFE+F8mMm6njEQaLt0UqUAV0N?=
 =?us-ascii?Q?SBZMigDEB3/P48x0H6zem4wpkPXcMDVCk3ZL9LpwESns16txxYgnl7qZeYzc?=
 =?us-ascii?Q?lIk4uTC1Wfvferq7hkvbsH6CdNXXYruCQU1xTi15ctCRuo8fDlKH3yv+cS15?=
 =?us-ascii?Q?0UAgTcDnW1rqyWjM2GlmgxtqQ5X07gWs0uaiECVijJSe5r528c6nHphCUOb/?=
 =?us-ascii?Q?vaJH6m+ug12Usth+nKOokpEveF86OxtBaFXgA8D6ycNdFHc0L39C0f6VuSrc?=
 =?us-ascii?Q?d6IgMKFKcA8sMi5ha+S00GX2QQRBUubtPgDJ0bTg7h8Cmq4aNe8V9vDD4pWU?=
 =?us-ascii?Q?p9YaQNaLsgCJDdw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xcUJmK2K6209LtlN/+7Ne/nYVsDXx25tN4JvE63mqH9Z3lrtxGqZ+Z3u5PTx?=
 =?us-ascii?Q?0Vnx6UuXq+4JGj+MS8utJRnwyMRRpc/RILeJgpFq57Lz5LH/YXzIG4gOJObh?=
 =?us-ascii?Q?t/Lt7itiL/D0PF/ceuUkltHEV5L/aII1cJ53hMef/ty0Q7pQoANNOG4cSH0X?=
 =?us-ascii?Q?7po0svkCisrhDPpDQgy6KMS/N5N2JuKD4lv0EFLBg0xERQs5Un9gZtC37eAl?=
 =?us-ascii?Q?lDW9UvKejLn5ywh2B01jHmUkHenuSPMV2X29R3LDBCkO1CYe+WRzzMccoUw2?=
 =?us-ascii?Q?y32lpqTPrHlWwEZ5bHpmX5ptBkF+E2wWvfrDuQ4PjucrKLb3nNUOf0A6wHFd?=
 =?us-ascii?Q?6v/qG4zFxEfyYKAgONpD8d3nB03Z/fpCVkus/Op92WQ1H7ZlZ67srzIKUg5F?=
 =?us-ascii?Q?jXxM1Oz7dAxRM4Xx5ptcOf2IN37o6d2OWz+JoJQE7a5gECoNq7mro+3GG5da?=
 =?us-ascii?Q?S1EwFiAA1PmGGCnf3xlIYFxM5xq+7dyQK+mhq/JjFIv4/Eo/BUfTlrJB2CPC?=
 =?us-ascii?Q?TsfFsaJojyZqrIs50ZSTDT5kgK6QA4u0UidZzkijRINZrE75WhW3bnglPoYS?=
 =?us-ascii?Q?E8Ps5w+8xnYGR+6lnt3qCRZSD3zdGNCghhcpGSIK0KqyeFfurV6pPD/Du0dZ?=
 =?us-ascii?Q?P+VVQyaR6dn2rax5u0VaRaGnrRv7mBaar7IoS9ji/GJfGWm5ZXpxPfC0D0H7?=
 =?us-ascii?Q?k6sFoG+n1MNYl86dmUOtmQWqDrhGbiLlXED1xXvGa+2IMOpMdoje7eGbB2ZA?=
 =?us-ascii?Q?G7d0NbmTOxu+GQJkI8WkeCc37y9I4P8h9ycIdyjYepdEcghJicq5GjZ2LXHs?=
 =?us-ascii?Q?EgtuXNzCCrjfJZnGTM/V1OSCO32SFFHidF6G3S/dRiUs5W/CRo3mxqBQnzlg?=
 =?us-ascii?Q?rqJ1GvEacEbaMJpJK4Xjicg87BCSH0nonm8f0Ubla3JmBhnW/p4PtMoCtv/b?=
 =?us-ascii?Q?4SGyTTeTXXopgFs67sRDwMmFRMnd/mngeYntf9GTnHZx4+u8Z9wTwi+VVBjO?=
 =?us-ascii?Q?NiaYeL7173sugLtt/QAfmVuNxsz+CmiRfvYX4cEpxzx8lr35f1dv2ZzGz5l2?=
 =?us-ascii?Q?9d/9fb5l+hZxprgVKGjgAFUw87++q8e5YeuxF1DNFYcFJL4uUHIFu04tkjc0?=
 =?us-ascii?Q?Raykd4Znug3D993uEbFeLatvC8dN6LeuadFNkccUOvFpEehXHGdtXnopItOM?=
 =?us-ascii?Q?tF0+/S5joKIsAqPaF2Q2+EQGX+MRPhTSNYoMYsYVab+B4xPKmlVhZ6Ge5rZ4?=
 =?us-ascii?Q?AtG1WG7YJGajilKnCZvprZc8l5sBgmcIrMNzQbSCnYgiLOG48Aej90EXObWF?=
 =?us-ascii?Q?j110RHpMG6TVClTn5lDyrJjUCQ8PNqKqvXbCRd1m25vPp8oBBlIdeshps6Ip?=
 =?us-ascii?Q?mt8i8RNKgmeegmhZFN1EuBrYsr7wkS1jKQN5P9Nh3C2ciaqHe6NcYC3kc7n7?=
 =?us-ascii?Q?JWJ1mtem7FbsvEEC1h0zX69rvmns/8V5cemHPwMpRuHU3/hB42qeMVvr954l?=
 =?us-ascii?Q?WL8zwu59YUawFMKWmeSgZqQ/9oOqWmDQw/bLIKMlxJ9+H4jQgECijGoGO0/J?=
 =?us-ascii?Q?p1RXUOFyGIdzCXGp0Xa0of4DnRB17uWKuUeb/4McOQIa80oH5RhL8c44XtY+?=
 =?us-ascii?Q?8Mro31ie9rlDeC336t7vbDE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f27b1eaa-a3b4-47a0-be67-08ddc5bea167
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 05:47:50.3171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3GTLVsyXwm4PdAeSdikU2M0v8LWMb4og2jHXUR2qj+sIcu682kCPzo0CMiAmI/dYswLBLMpuvczfpq5YqvPgcy/INru39hVSucLcjW2/jA1tfwvWUKU5xEteZ9oz9k2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6953

When detach_tasks() scans the src_cpu's task list, the task list
may shrink during the scanning. For example, the task list
may have four tasks at the beginning, it may becomes to two
during the scanning in detach_tasks():
    Task list at beginning : "ABCD"
    Task list in scanning  : "CD"

    (ABCD stands for differnt tasks.)

In this scenario, the env->loop_max is still four, so
detach_tasks() may scan twice for some tasks:
    the scanning order maybe : "DCDC"

In the Specjbb test, this issue can be catched many times.
(Over 3,300,000 times in a 30-min Specjbb test)

The patch introduces "first_back" to record the first task which
is put back to the task list. If we get a task which is equal to
first_back, we break the loop, and avoid to scan twice for it.

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
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


