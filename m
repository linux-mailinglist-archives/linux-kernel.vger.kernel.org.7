Return-Path: <linux-kernel+bounces-736318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DFAB09B78
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A736C585257
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 06:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905DE1F1537;
	Fri, 18 Jul 2025 06:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Pada6+KI"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2131.outbound.protection.outlook.com [40.107.93.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307A519E97C
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 06:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752820563; cv=fail; b=rBLPHatWL9lNJKiAjQg1g6EFYibbDjp+idFlVlyNa6lhQQ/XJiAxVINrn/9ht8CYAdbUw+wZkK86fi3qn0L2Vm2i3bR9lv9NiUJL75eSBug+HIvbeK+X0VFqbanQ5ugNVFX8FJvIyPTdxa5l4RECHxl1Ofb6jiO7H++K20mbApk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752820563; c=relaxed/simple;
	bh=1Egqm0YCDF/P1/yXIxEGp9D65j6IqwGHP+OkiM8AOn8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LhebKIYt47YN3wkASJeDwvmDyMFpG/pkye8qe2gf+S3zphHvGPwVHHjV6XRVwt3CLpGL7k/h4nuwrlVl+T7m2gMh/nvi1kejPvY6Wq8a+//1PAqwNdeG8Stf7VAvUpgcuyG4mJ/wjXdFpKmRUOgSLFwtoEXEbwxJMKKCTj/o6MU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Pada6+KI; arc=fail smtp.client-ip=40.107.93.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJfnYmu7BLVmPiRmMqOuMVpuqiwJzmAa+1RlDIBUTwfR/ZPpyHFwfFNPHx2T3mt5eQwOqfNzpoBPZc86no+QlKEvuLj2/oybOfb0v6+lqCVtdsrJkUIAg/Qan6IniTnFUhbKLYKDjCecKrzijMmsrquAlAOX3QtX36hq/BkLZiHxZPfGVkpwOCWpzWSni+3jQmLR56VJ//6hzlj8I+0G2Av0l4IWfLgO96TD6HI1SS6XpzvQba4+jULrv3kNPqkiK3Aj+CmEXtGiL3XH/N8iJqAYZg2rFziY6op38xe4btwGVQ+h/J5ElJUwQ+uaCTL+HQVr3iEQ+n2ugIoesy24Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BtYv/riHX9hBNzyVzXXbKPWSOWlQY5JIdOeb+rY9sk=;
 b=hEfpULCfpTrYQFfH9xU15pEyPzARdCeGQvfBRnNrj3gi2MpsylnsB8kZWq7RY93SdijxgZUX8KnTWamnDfSXJRwl+NlzvCfTw9+ozS/0hdPaKkW1TE6rs2QGn9tCUqwDB7hPoSCgWSf73jQuW1z9EbInctsDIY5wIQIMJBC+DlDCKTJwt+veX0o6Puilh3IcDFuZDE6Ow+COOVRc8o8ArZdyXJnlBSkGTSih+Dj6iDJc27Jd6UOkJQgSPLbF15t1pnZgj6hKjLYBxhhdQbpBH5qpGS4DlNvx+BqWZ1p8qzDWV0YRL0O3O3mEAn0Yvw+2OerW8P18XqRZjNAw7CD5rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BtYv/riHX9hBNzyVzXXbKPWSOWlQY5JIdOeb+rY9sk=;
 b=Pada6+KIBjW7JJnjRg0ZRaE9qhjBbWXrvjGLL5qBKOEgkCBSMWwfeSIXhcJ2QISn25lrBqTilx7fPWHEdA/L9mPY9F2fRCHF5ltNjyjT8dtzXzeRSSrNiXpgX7WjOSFUhhjCmPrd8XwS3Z3i3MCmPIoKFhFwiFH+W5PfR7yZvCE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 CO1PR01MB8987.prod.exchangelabs.com (2603:10b6:303:272::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.39; Fri, 18 Jul 2025 06:35:59 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%7]) with mapi id 15.20.8922.028; Fri, 18 Jul 2025
 06:35:59 +0000
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
Subject: [PATCH v3] sched/fair: do not scan twice in detach_tasks()
Date: Fri, 18 Jul 2025 14:35:23 +0800
Message-Id: <20250718063523.9232-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|CO1PR01MB8987:EE_
X-MS-Office365-Filtering-Correlation-Id: 07df4806-1ad4-444f-f6c4-08ddc5c55b53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NKwiKTbVo56IN0ea7v2HLvuELaL9/A+aAAdyZplObbaCK29Myuyekh21Z0Dt?=
 =?us-ascii?Q?6DWi/m3AxWs9bun23iMDPFrfXClx+Qr0q4nzDKD8BoWF5Ht9rlD5rGPCbbaf?=
 =?us-ascii?Q?N/NSW9LtdqMTvjZatR4iO5jMEbVrsA3foDh7Dbq5eZb7tja53lCCvo9khtee?=
 =?us-ascii?Q?2UYiY1hsU87S3eJAXwSbtFbz8znxMwFdEw3F2SA3SyuyKPJjToHWE+RQhfbE?=
 =?us-ascii?Q?6nzwp35H/TDejS8X39elzTpahwTyOYZaw8uvIcUbmoeRjN4J8djpPObiZf7C?=
 =?us-ascii?Q?HEuQQV5deeWOjtqzLkIu2N+3WqQrp/QZrKP8LEEw160bjtrHdydQkVj0B8SI?=
 =?us-ascii?Q?3eU0sDoFm5V9DNVHQz9u2yLznT8/6fbeEvLWnuFJrhe4enwcxs+PGNSG7pSe?=
 =?us-ascii?Q?yw2b2yziuq3bG0kkb0sfmXcmuilzfM5+CUqfB8LjdZELD3AIAAuQ4tGbG3dS?=
 =?us-ascii?Q?kGJwoNnLh5iTkAFBdyM817Ou4Xf8QPrmgP6fKd8rRs1VsDY+aslTYF/QzgFt?=
 =?us-ascii?Q?5v0cLn8V0E4LuncBNv7/KDj2qMcTMN9zr4Fxc0p9Uj8N82QE6H67XLNwewWO?=
 =?us-ascii?Q?HT/401WlCDi+v9dP5g5FSYEkFvWfVBTKsXOLf+TD4TSaNQIcbW7pu2fdzQPy?=
 =?us-ascii?Q?LAuS+Ujhy0sK7BqecOOYEBvw1/2Xvy5rgdkCBw7E1F81LN7M/PGtN2Sm/IUS?=
 =?us-ascii?Q?lGaOfmER/EnyzPYJMOLKi06Uno70Gsw2/1AA7EhmRfzuF8+HbIu4/vxFaV4I?=
 =?us-ascii?Q?eUdneUlBy8AOHo3qlDLTVVQRAtZZ3ZyEdrZapTetXbnQ+aUmjTrO05OHtBf0?=
 =?us-ascii?Q?3p8oifCSa9mvN4bDX1hvnvL51k0CeZ0y+7vmpYPQBGqIJnavkAn4JccaZBOM?=
 =?us-ascii?Q?mAEryqYGIW5YxQxB8kED9TcIJ2nCPWP3WK4ZzjJS+upOVl99I1jJDNDj+E+T?=
 =?us-ascii?Q?iFSkUcnnnw27Hx2iC/JW6S1PBE0oWQPltMKsQx8JLjbmVsyAVldVyALaixhu?=
 =?us-ascii?Q?fbd3XJD7k1dAJBBMUGABxqwkZdRkHu8f59T8vNA1euT9/t3eigFst5Dni4Xo?=
 =?us-ascii?Q?bbyPHljgeO6B9fSHGOJmpkJHAiyFJcD69aNXfM0SaCTMJ2zq9VkHG9lBlQIa?=
 =?us-ascii?Q?TnRG+aoRoCeV+K8GH9hW1evDM1Jaq1bJ+nSoKxoXifyPD3Py2N4amT4n4y+w?=
 =?us-ascii?Q?6sATyZQpeIo5EavRijneqK8DrST8YsVuo/EsuHpAKeGaEbrSUChvtot0+yB+?=
 =?us-ascii?Q?6vvqcjST7j+hTWQ2z/pkypcJkNGXDeaZU3JOTPJkRn/5+twxf2Dr7DbRx0E2?=
 =?us-ascii?Q?at/mv+HXpBXI4yHIAc2bCWStrr0DcDO/q3hv66P7GuTsWGn43LeTW+mQx2iS?=
 =?us-ascii?Q?0+zdhJ1F+Vhw5rdAC4HjCGohHs+ykRhCOaqggWSWZV4emL/wMBBGRsidUNIx?=
 =?us-ascii?Q?Tp+2tPAoG+zeRVlyV3MhOU9ZngWXa4d3aUWrHItMhfdge9yxUXH51er0sQlu?=
 =?us-ascii?Q?xENAWRZfdpmGs0w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ciUecp260jwcDJNfmIzL3cJArb6Bc9B4Ss8wzLdtxyX6baw5/ZxfC+zS5FjM?=
 =?us-ascii?Q?gKWtebkLTth4fvC82EzOC9+q7AJn5kOAG5Jr0HJocpkMiuuWugyHbh+UYkTS?=
 =?us-ascii?Q?xdXF6SuJka5VQppFZ2yVv1yya93Gkn5+rORUnvDh0OY30nOsaOYvRq6y8FqA?=
 =?us-ascii?Q?pakSiMmremqynDnIll+subTr8CHeuAW5L7sNEkRyuP0NymYfjhlFJTm+02UX?=
 =?us-ascii?Q?c8/2S4LsD81xROymvWUoyj3YSoIJlrYjH18klU1uk92V8f8GxXqV+Smc+V5L?=
 =?us-ascii?Q?wAGC7zvFp0i04GLWo18zkUOx74+cY5iBkFBagacMXqXaUuPb1+MxHIGfO61R?=
 =?us-ascii?Q?JAGFpeqn65jY/d3zhg83/UW8gLxFTGteaChF9xFajnQqTI2nh5VvAEhBukug?=
 =?us-ascii?Q?UBpOgSO/omIBVQPz3ummIKnoPNE3zjwqQK0Yl+8adDtRf+VR8g77sZLEf6ue?=
 =?us-ascii?Q?ZVCgmI2qcLUyONLI/sFeCrMnsVO5clmN6yZ0y0yBkYaxlGWNMc9mezrPVVId?=
 =?us-ascii?Q?Le5trNcrFnHOVImIIN+QHg2BGF+JspmXLkNc8r66xDeq11mZUFw3Aalsi7Uy?=
 =?us-ascii?Q?/QOF5aP+8KvA8Gpl6+6v6Cmh9AZqN1Ink6GtS9cpq4k8vUXrsixcJQ2DGwH1?=
 =?us-ascii?Q?IMhrRI5SxXFaasRpp9MsaTapuNeB0i2Ag4hPm/g1xqzDJfQYbv5NlSf53YTr?=
 =?us-ascii?Q?aIDOZGBAiAlmC7TkZFkYxfIBMKoI6ioqGMUDQMwpW23GPNknyEzQ69zLqaFc?=
 =?us-ascii?Q?EaAWXgi4gzyYpu4dnuxBRBgmQ47jOAyc/NU56zIwPSfO0ZmOgwGjooHUQ/uy?=
 =?us-ascii?Q?MC62jUq2T3Ft5C3Aix/XlST523HwiqMtm9gfy7eNRAzPFvZl7YUlfAK+YeRS?=
 =?us-ascii?Q?PewMxg62c80oZo/hgUxuvbWsUBwxHxP47RIWEiazRKJJ+c3+/xh36gf8R8f8?=
 =?us-ascii?Q?009ysGyfDpiu8EwyJ2LVLtolc4ugf2+F+80iz+VNBNP5CBouXeZ0ypMMr9VM?=
 =?us-ascii?Q?zUV1TJ8S8HRFL1oVt2gligJqUlxQx5w5ba3Z6OHZVyI9ni+gOKNh3BMXPcBG?=
 =?us-ascii?Q?P+C1rEQ50bC9+UgNHzkTQZb00b/SggJrsLzAQJbzj2I8bFI3M2iyd25kwGJY?=
 =?us-ascii?Q?jhdZB0n2C6wGN6iVD0cztjmjRqhEg3qqv7A8dV0sD7wP/afvgrkBouJYcnZv?=
 =?us-ascii?Q?TKUMHbkfnndmdMFXj95p1XYnjgWs7L22/ZeXNqDmIOEsaQLPGZERRrwiXigQ?=
 =?us-ascii?Q?HG35JHzwWXJmrtgSY0N81qgbh+8TedxIHEX2IKwhUtFkLns3Zf3n3wgQoZMB?=
 =?us-ascii?Q?CXBjMS7K7UcUIoiA84HTRnt4ws34bbwy/Z/wBWoNDfNH/ESItRZr2/JXVFbv?=
 =?us-ascii?Q?LYbEHqa6dBMIjXIbtqj9/xEvR9nCkbzHZgsFjqkBQvNSvIPa2yhngmaFLwbg?=
 =?us-ascii?Q?n0CURlmvmZXUJ7A7B1hMuMH2YeuQMuWoq2PPc4gzuZtKzBXghvU5pjy9u8WH?=
 =?us-ascii?Q?mFoH0MrqZlU8lpB+8JKfnLEr08f1nlclcUAmsDUd1+KDoUqusGcCHxxg+Pef?=
 =?us-ascii?Q?Gp0SvP0YZtNK7Z0sfDIuMiifSk/LxUFMxViRN6qKqFL33tPuXQMYMHZ+X3C8?=
 =?us-ascii?Q?KjAFQvqhOZSTqftwh5qvDjQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07df4806-1ad4-444f-f6c4-08ddc5c55b53
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 06:35:59.1619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jILUL+qEh8m4B9YGd6KPQyu0Akk+wVC6RMYAISdLHsTsTqetEDu2/F9zklRIyVeDVp20ECXIaV+b58hNGOvsxp605M0wly2eZ03iNdYlBoVY4eEnSRT1HLk9e5r0YgJ7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB8987

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
(Over 330,000 times in a 30-min Specjbb test)

The patch introduces "first_back" to record the first task which
is put back to the task list. If we get a task which is equal to
first_back, we break the loop, and avoid to scan twice for it.

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
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


