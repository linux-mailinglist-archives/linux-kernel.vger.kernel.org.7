Return-Path: <linux-kernel+bounces-734683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E926CB084C4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F01581F74
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AEC214A8B;
	Thu, 17 Jul 2025 06:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="C9KMQFLp"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2110.outbound.protection.outlook.com [40.107.102.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405E82153C6
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752733310; cv=fail; b=bVzfz75j3bAGws+ICxlKMURXg4em+EB42oPcYUHwxhFxNzBFtswe1oRtRJbkUTlslCC+bhVJ7f+Rj45xJzqZMmZEWF2LCQYZECPWxRZZjK30WOKVdrD/B5h8Vkym1d6j5r69XSxSNi2bWHzfj8l9zf15Izda+frxQE9n01uQHVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752733310; c=relaxed/simple;
	bh=lx7YuZIZcIXtD4B2I2vxBDQ49mQlnJQGJpepvUB3f5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WtZm+ZJhYx/tftYmdrdvKHIUt2npKLDTY/SbukYbiWjxdt3hNbh42t7oXm+5WM6gn8tsnWCApclnt3n9C3ot/koPBf0Ejl+ERBoJobhw4Nx0DIbl9ItWRmKOjt3UBnyVneQpH1BcYRy78Vo66PPP9JV6e1vW5hVDaQn5mAv6ZEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=C9KMQFLp; arc=fail smtp.client-ip=40.107.102.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KmfNumvC3fEWJ5P4jluw4Z2OR6EppJoDqlry1mMCdSMPEcc3evYsiJFWJkSUNqFuZ9oWcX8njdRSo4bNCFSAgQ6ndK4CcGkg9PHaY/XfhqzlGDZj+Se4dqyFFaXr4flL0hZHNixQ2nMqlWAt/Hm2jCzPS7mxQL42pKFBtELnr4CLvEEzfn6n+wfaxkmWqq0Ejgm8XK5KIrdTJGlHn/sFC/AxKhh7DlgbLdFaajPtBnnG34FlvUJFR2135ajm3NvfIkxqTIS5Z8HNI2ndDuSFQ5rImNg+A2xF2GJTtI6NXXPMjpTyXXq7b5zh6k1iXLcEgnHKFT1/VfTw3ueN5rPNog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wro6z7XbxzEdogAPnsU49lZpZV8MbXx/iggmpo1ZrBU=;
 b=nyq7acuA4pZsohI0bbQj4WXMLZe/oMkANsDLWXOIX/O3kZO0HEAiez7f6BZR0RgqaOVKbJEIfh5r4/2WXlvNWbfzi/V5Or0gHTUtoZMnr4U7NoQTdMAvMrH72ZilgB5S1mypfq20VXfY12ZqXEIilr2aJuocHDsGA9j6RLuAQTv0cHGYfxkcSUUmob+2uoogCcwoDMJQuTZPGAq/DROeDruRgXVFkHJkLFHgXbWTarGbf1u0vlGeLsBM3UoLcwjVuK+4jZDxwmDOK8PZn27Vy0oVol1f5xWGpr5v7dMPXZVIYJlMViVLuGhgJZEdp87m90t/ONvZ14sFBkrpI2Puog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wro6z7XbxzEdogAPnsU49lZpZV8MbXx/iggmpo1ZrBU=;
 b=C9KMQFLp0IKynquPDQC4XOt0REh738Br2hh7BPoDhMk3BHPlXy9PdFY2MafoPulBMLkj2ijoUPOpRarJaZ8D+FHAdM2HOdfxWLTlSXFECul4kZIfQ9V615ck34lyyT3vLnHANuEZoZseNX8SKh58n5LdRrZgl7ntrZ0pShYqRQ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB6761.prod.exchangelabs.com (2603:10b6:510:76::23) by
 PH0PR01MB7287.prod.exchangelabs.com (2603:10b6:510:10a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.39; Thu, 17 Jul 2025 06:21:46 +0000
Received: from PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2]) by PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2%7]) with mapi id 15.20.8922.035; Thu, 17 Jul 2025
 06:21:46 +0000
From: Adam Li <adamli@os.amperecomputing.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	cl@linux.com,
	linux-kernel@vger.kernel.org,
	patches@amperecomputing.com,
	shkaushik@amperecomputing.com,
	Adam Li <adamli@os.amperecomputing.com>
Subject: [PATCH v2 2/6] sched/fair: Only count group weight for allowed CPUs when looking for dst group
Date: Thu, 17 Jul 2025 06:20:32 +0000
Message-Id: <20250717062036.432243-3-adamli@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717062036.432243-1-adamli@os.amperecomputing.com>
References: <20250717062036.432243-1-adamli@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:990:5::9) To PH0PR01MB6761.prod.exchangelabs.com
 (2603:10b6:510:76::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB6761:EE_|PH0PR01MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: ab7e70d5-b690-4dac-f1bd-08ddc4fa34a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zf4hV1Pvf+kbamXlQSG4G7GMH2yT6SzoRZm7RCuR4PBR5R8isK5DJJDdbsQ4?=
 =?us-ascii?Q?VwS6TddzzJhJrVY1DR4qne1W7MM8Uu+ktXJwPvWbnNOCF1lpJ53fA387gMWh?=
 =?us-ascii?Q?TfPivhYzb99GuAKTcS/tCp2gF6T1C3yExPQj6V+lW6am7JpMLSccCJwaAtBP?=
 =?us-ascii?Q?0mPg377jB6YCHYyXnR82omoZxcSh6poVQdMBIHZ8S+AI4++ZswxJow3t+WGE?=
 =?us-ascii?Q?0UM5LympJTppXQ0An5gnhs/poPyBlwqtVkGKmizQCTCKLeTJ708pADRJGT0H?=
 =?us-ascii?Q?MP8hE0ISXAQWuWIrWc7jS3UR2sI4xemUUOvLDri97cfg512b2GVH3ASJxCcU?=
 =?us-ascii?Q?6KCknxtR3uCNyV7vC1pXX5hgU7KmYRajMvI+LvO8JEBpUVK6mkxNW1vlN8Em?=
 =?us-ascii?Q?td/ilyVJUdgmklvVj8yHSnZwOSVgeAR/XYJ4oqIYahrSLeBY8d65g9gdxW3K?=
 =?us-ascii?Q?g/XF1swGV8iXxpKJG9Pr5XBp7m5+sP2POmf51IAS4Fwy84TtJ25UNgPm+ZNV?=
 =?us-ascii?Q?5DYizdX6VwC0IwnYQuwGHQunGj3uGt7Mp+znqCarSL/MVfkhAflC4eVyS6pj?=
 =?us-ascii?Q?oZd+UKQJUAUcgoVYMHnssckeMgoe2t5GNqxyQdfiucFj9xz1zqqviaLYDSTb?=
 =?us-ascii?Q?djQwhG2CF0hiDprzPheQ15K0trbteDeZ7JXuVJiRty7BWAMx7gT7RtzvoePN?=
 =?us-ascii?Q?tQCV5mzU0lrdJJHc3odO50dk7zjtmoUJqCF+J8gocasR6fOeWhDGcTTx1Zmi?=
 =?us-ascii?Q?QuYESt/FhXNGA6bJC4wpVLz58u3nBrwRheLsbXbWqchKTDNRBQpWnt20wIeh?=
 =?us-ascii?Q?Ty7jYJPRyGrx0O4evF4AI0YjKA3Kqt7LM86mZBeX3nVRA/tFrFucWf8mRNAA?=
 =?us-ascii?Q?0o0PO+fKqUP6K8PEdXCJMb3FhgeKtv+0FVEOR/X/aid79OzTsUThsYOjFrJs?=
 =?us-ascii?Q?8AFtgs5fGpxbwZoTH7d4ZzcjK5nsQ/8yaZplXHzxMt9r22mVD0+V/S3nMwOp?=
 =?us-ascii?Q?eUNurXgpUzKYk8jz2eW7uBGacsb/thTlxCLpTonudepDW0hVvL9AnFbXopIJ?=
 =?us-ascii?Q?PZNxwhEfqTcV6sdU3Sgxci/i0uukDdTxSvX9ADlaDjpwOUNGxonW1ZBPFcrV?=
 =?us-ascii?Q?XKe7EChhr8Na1bWCMQc8+sKgE2uS/upjXq4Z5vok03f76Y3AtEXiMBJF26BO?=
 =?us-ascii?Q?80dAaz87shuyYidHAco8YWB8l38Oueir/y/WnoR1WSCwU3PdqaeuqCh4ak/P?=
 =?us-ascii?Q?z1T5vn39VXAhc1cucnbzfxs+q6Kujp1QmP7Cwzd+NwqDaO5I0iNFfg2lJ1em?=
 =?us-ascii?Q?oznLdSMhC9f2kOsVAK2fv50zJCxNxMeCIQCvcnZJ17iJgG39wFkmayzJYDc+?=
 =?us-ascii?Q?1kw5/4ewnncSBUxTKfyv4YXV9YOgsjsiJZ8WRkpZkhCgTRgNM+sWEF4lYUpN?=
 =?us-ascii?Q?ZiQSyYqk2VR85hW8Ha++I3QITN7qAvGZ1heKhLl88Ru9Yhf/uae1Hw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6761.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tUbwrjO4cHc3rU1wy3Zi5S9Pc2lvWPJTFM/+oVln/qPPOxy6NFNJcc1/qWBt?=
 =?us-ascii?Q?vdw7hdrlo2Jnk6pKSrCfgc28ERFG9bKzGfDc1WoS2P6NJkL/YDIuPN8LCDVA?=
 =?us-ascii?Q?0X/qpcJAqm956dWiZ1Nbtpl2Xd3Wxdp0Ezm+VtSW4j9N1pV/t22/56htfS6q?=
 =?us-ascii?Q?/GeIgKy80tl4+5GsarguKnGG1xQ1US6eUwETX/9ME/9qkuZZx0gj7EVSjrjR?=
 =?us-ascii?Q?nal54ZEnxgOieCcBPN5cuudtn4DBW4z1AM7PDGN+sP+SQxSn1fC9TX4eSqZB?=
 =?us-ascii?Q?h8+O7BOiXEctILpCSo0cb3S24LhuEtp+VyfP+gKOnxs2WoPLyn15Ea/c+gop?=
 =?us-ascii?Q?0dYYxwb5B/dqgKpML6fdRk3Qt3XI7vwHnDL0TQEImOrvoDCKORXYZu/WzmyM?=
 =?us-ascii?Q?br0rj7dHgTYFODCBsszGRGhGYY62CEVIJ30DJcm65E6dDG7D9XUPZeNL1Zp/?=
 =?us-ascii?Q?uTFsB0ibldxSN/RT8QlH14pob6VyPVVS4t5eH0VGiasf57yx6E9qE0NZmeYc?=
 =?us-ascii?Q?0neYmPN6y+J4CuSnNDnBf8BHYE0KOFj10k1kZM+lxtIHbm6s04lveQbNJ+VF?=
 =?us-ascii?Q?f5ViE2wlW0wkKfDxsDkyY46xYMSNggQPiD8R645lPGJTVhT8O7xnhTZ4kc/x?=
 =?us-ascii?Q?n+MjnMuAmbNSFiJ3OKQOp4PKSnmrBWh329e7oZqcU4D9e5eBKqTdCpfLiAyS?=
 =?us-ascii?Q?0f0LJJZIWsBEqSDas1xul2nwb4ZRvMDBRAOfrDtiNMD52pAnkkr6Rv1kGq+H?=
 =?us-ascii?Q?Q9x6ACMTJCWn3G+LABZedLi8pdQ2apqS6b12xZFRRoupGuiOl6bog5GYR7sp?=
 =?us-ascii?Q?fh6xuPZn6GsPg+ns4E2fbyPb3WsgphwHEF56ikVNV5x7H6eM2BdMQTQJWe3x?=
 =?us-ascii?Q?nwSA2yTRFVN1KrMcZmyFEyoWpH3QG7/rT/nlvnyP8v8ZKYirFgDySg3rn2Ru?=
 =?us-ascii?Q?cMkgOKr5IA/23qOfmUwyi6mMfXbNECjV8bEe2V2MoGElZ2DHAZer+Hz4YOLu?=
 =?us-ascii?Q?+Oh9CGqHNAdrkgtMjMJrauKpZUB/Vo78Pb6+rScI/z+2uMiD7uhUTtx7bXP4?=
 =?us-ascii?Q?D9agcWhH3QqsN9jSdmjjuSxRtOmJevfxyH9EDuJvQ+MZ0sS5eudJx2jk5RNi?=
 =?us-ascii?Q?v1Q/gHb1EhHL8p5xTx7y3XZ7S0CmmbT/gsbreZx+Ice2szdT3VreMOMhl/OJ?=
 =?us-ascii?Q?m9uX3zKhzOqLzwhG98lGxxc0CvsUIYisjTwJt0mfmyKed+PAbxCHkLrqz4A0?=
 =?us-ascii?Q?Az+4bpwxYZWjivy9hlO/E+pWhmdjeSjPbcTDy2BmpYIe0l3p7ufen5OLd/h7?=
 =?us-ascii?Q?UQnGNV7e3rACxIlXkY5p9KzAC/3t3FF2ugkqzon8EjBAfSIx9nthBpqCOyj4?=
 =?us-ascii?Q?dpQFtx5FpLq3x1Igl3TIwdiMTocCS6F4tk/wEfqsF+V9sZQRUofNdp65QEfl?=
 =?us-ascii?Q?CzvbBLOGzDZtXDVlQbo9ou1DQTMJtfUsQIU/oPmpDMySTaZh8IG0Gw/d87If?=
 =?us-ascii?Q?loUiSCJej1BfMF9eKPk7r1UIz17tCQyatL22PJ8gmhwzu0T16Q+YkjZzZJ48?=
 =?us-ascii?Q?NXcGULrp100Y0VwLL9iCHIjUJaWwhFHQaEnpItE8Z3oIxKOJjk4fUQGu9O8v?=
 =?us-ascii?Q?4A08n8Fe/xBjArgZcJv2HHM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab7e70d5-b690-4dac-f1bd-08ddc4fa34a9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6761.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 06:21:46.4305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZllvBofa2miOs+KXx2Af5snJEVitY5Z1+VSNOzS5gnj+mCTrTklbzPqpj10BmGuLBuL3qfDz3nhb5ObH9yPAttOrdSCBWH5CzlNgCcq3RnPHXGSmHXraea+glV29G8Y0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7287

A task may not use all the CPUs in a schedule group due to CPU affinity.
If group weight includes CPUs not allowed to run, group classification
may be incorrect.

Signed-off-by: Adam Li <adamli@os.amperecomputing.com>
---
 kernel/sched/fair.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 78a3d9b78e07..452e2df961b9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10722,7 +10722,9 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
 
 	sgs->group_capacity = group->sgc->capacity;
 
-	sgs->group_weight = group->group_weight;
+	/* Only count group_weight if p can run on these cpus */
+	sgs->group_weight = cpumask_weight_and(sched_group_span(group),
+				p->cpus_ptr);
 
 	sgs->group_type = group_classify(sd->imbalance_pct, group, sgs);
 
-- 
2.34.1


