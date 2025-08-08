Return-Path: <linux-kernel+bounces-759656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0517BB1E0BD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 04:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B215B18A12F9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 02:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE93F18A6AB;
	Fri,  8 Aug 2025 02:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="hKEc+HA6"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2117.outbound.protection.outlook.com [40.107.244.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD9CAD5A
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 02:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754621773; cv=fail; b=ptO8ZQgscsZM2F1rI2YOzxRn0wvRUl86jHhxwnb6xUpY3T2EiySBZDRnQhkA7+BNjj93aLPbkzFoZPkuIxeF+tJRI+fSJ7yPU/CtFVzZlgjx3eg+IQLxcmqllB5B/y1vLYGq8EMQf00yAvgK0LXEvSTEOicwl8v5s96zTS9IKJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754621773; c=relaxed/simple;
	bh=3R6AqCgF8E15Kzs/WEPq0pWiDbVr/E5kSXeBHjnMWmA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=WtfUphpkp7JZX5xyeUC41TJv8GNEKpLURhKlJDZ/EbTNCiZKk+GSgFNhm0O/FT2AoC2Zf/qLaoG5BeU0hQzUdC4vtBzLH1CCqadSnUnjmKOnLyCfZD+1uUjXoOnTr+Py7f84GVyQORkBrWn6b/6SC69RxPdc7FLlRfENjpDk1ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=hKEc+HA6; arc=fail smtp.client-ip=40.107.244.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wT/DlEB45VoeUbtDfeu/u8/0WzihIHVP5PdHfCzLy43FyIDcqaInLVPxsNt8BpfTJMsdMTpUOC9Dx/+y+4LWY4rPGw1HqlykduxbZ0q7p0QXkNjp+qSTEZk3MlCEYq7DJ6CdCo3gCtgYs7WjWnP1Hli/DOzp4d3sd3mUhjI1wezbmaFAO3XMteZac8fmIjVJ+MUV0bXQTcvW+qQA4VNMLBVq3/22LVBCEVaMbSiumIVXNfvuffI5RGN3p1RdPblugB+Notul/Uh/NjXHK85Fc+fLyCwnJnrKsRnCOkHyBsDdYzUGhKrnrA4aHIUi+7zkw8MFmiZ99XmgNKLt3jHGoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QNuSFl/uQkG10shxUXUqUW5T8UMEE8PVNt9F187254=;
 b=AlAX/JS2vCvpPZAPVq9KZgO4X1chDA88trQGZ/gyWhaXxtS2z8t18dxkTdrU1z6XF7Ek3+lwCQ6aaN6uVs+JcNX8e+s20wBxmyXIHT1Rb3SHiDf2ykLCtDYX12Y/U4U1GRNBL6GxXNET9gsUkX3gH1xYFfObMziew2tmNstHYZxLCX2fbpaCoidfXuQhG+ITJxbTpY38HepiBkeVSZogKFogKCh1WdHcW0YCTQjJUv4FmaGAt9eeb7lbWvXNztRJubcgR2tOACo9n67CdHNsHMJCMD2XSs/Y23ZHmFJGMWJLiAblBdlRa4ghwcDB/msJkDFeOPRrlsX1Mr/dlnDvxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QNuSFl/uQkG10shxUXUqUW5T8UMEE8PVNt9F187254=;
 b=hKEc+HA61HGyelE6pOHtlvjHsMOHb8dCTPf62KvmcT8pzWN7jw64NVdCaBy7pjl4qQ7t77w9+Fl+GcWL4TBkTiUGNV0OWmI+PM6LWcQEItkCUbCW/vrnpzYflvP8EbF9kNhFJNqzkTSUyyMHhuUhUuRdKmjZxhzIOq952VJeP1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 CH0PR01MB7203.prod.exchangelabs.com (2603:10b6:610:fb::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.14; Fri, 8 Aug 2025 02:56:08 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%4]) with mapi id 15.20.8989.015; Fri, 8 Aug 2025
 02:56:08 +0000
From: Huang Shijie <shijie@os.amperecomputing.com>
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: patches@amperecomputing.com,
	cl@linux.com,
	Shubhang@os.amperecomputing.com,
	krzysztof.kozlowski@linaro.org,
	bjorn.andersson@oss.qualcomm.com,
	geert+renesas@glider.be,
	arnd@arndb.de,
	nm@ti.com,
	ebiggers@kernel.org,
	nfraprado@collabora.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Huang Shijie <shijie@os.amperecomputing.com>,
	Christoph Lameter <cl@gentwo.org>
Subject: [PATCH] arm64: defconfig: enable CONFIG_SCHED_CLUSTER
Date: Fri,  8 Aug 2025 10:55:33 +0800
Message-Id: <20250808025533.6422-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0166.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::6) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|CH0PR01MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: f4913ad0-c869-4ed1-d264-08ddd6271ff4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lnrA55ykxchXRaFSVCrzdzJ1HJMPPsfmzB6BN5RflnDflhwaHpz95HVNz2e9?=
 =?us-ascii?Q?dsWdTZ1XRlb5vpvh+PqTsUJGts8RM0KmFld/nN3UaJsp9JZ5PELr6ZO+1Ltx?=
 =?us-ascii?Q?5b4S7+oaiq5XcJFIalgn2upXcvGk+5S5UEyisfX/jGk148UKaK5MyIZMCUua?=
 =?us-ascii?Q?CKmhzueUyIvh1I1Xh6+YTcevWdyXID0pils2VA900jlkD8Y9+Cs5gIGugIxk?=
 =?us-ascii?Q?rmFusZx+/bdfXxO46QG8WK7AxFxNfK5RmNxnRqCU2ntJ3imWzkEiCaADvo7h?=
 =?us-ascii?Q?RNnP0ilrovpymGd905+9G3fpWIpSvYDWpH+Pegv5Itc3beO3BuOhS+VxNjAV?=
 =?us-ascii?Q?W0Z9P79VAzX3kvZvkMQsq8F+0U7QXYZ379/oqD1WACz6/M9EvcY43+3Kzhrs?=
 =?us-ascii?Q?pJePs0Wfxkwn9DSjUqhPDMQkbY7kiVG5PMU+C56NoN4saytR5N5qL+N8Nk/t?=
 =?us-ascii?Q?WEVZ0v68fJk+i9UIZTHLOsbH6IDNUl6CZr89aOtoQkDrm7YGhguzdU6FLFUt?=
 =?us-ascii?Q?rrcR9sDnO2gmV37q72DOp/iVDsNmfzrS3/elspea/QwNOgMSaIrh8tRuIuDl?=
 =?us-ascii?Q?JjHHACPn348pAhK/qEzB0cfu9IKJ8B0fhxteQRuEAWjL/8VY3rvK2uw1Ia2B?=
 =?us-ascii?Q?1aqldGFBWqO978rcgipJalxluPIbK7MC5jepnxi2QldL4/BT+iE0/H/FFzGC?=
 =?us-ascii?Q?NujCC2J+GgVuNJUeCBrOzmEnVqzj8vO8Wis5MG/VsXF6RsLLjLoXfY+MNhbm?=
 =?us-ascii?Q?xyn3AhV9pOdXcyUO8gwkm8C+Z8/bQ31y96aCl5KaIBA2189LGeLDJqKSJquf?=
 =?us-ascii?Q?8ozSxuyGasCtEduq7asTfqkNoFRRZiaMdaM+xo8klfmh59Hg5AZYbkdIkHbc?=
 =?us-ascii?Q?3/XhWyU3l6vId88RLhrws8eoKVo3ILyJRELer1ksNe2qwyKEw3/pyiFEjQWc?=
 =?us-ascii?Q?rspIWpIR+d7IhIMHHgkPmVCYexCCzwJ3XwFcPwJMRNjTgcq6siwLhP2mysnk?=
 =?us-ascii?Q?G/X6mr0ElvaR38UA7SGDxu1+AwMEZzl99/i66j/m8eb5vlWgqrp0wyxJG87p?=
 =?us-ascii?Q?djHRFaMEsixVDi9mAdOMyUBfWtTbpLQ8FnjjKQVzlUMkf1F3X00lNID/eK2Y?=
 =?us-ascii?Q?2WVocHXHm65tGyf5BJp2ALdi8EPp/HIyXupIYmPbGBLABk57KQFNm9eljBq0?=
 =?us-ascii?Q?67af6qudD8ugleAndmM4CIO4qCATu1JNBVdMKaKHM2HlVzBAglkkZNfcsCHy?=
 =?us-ascii?Q?Id7v00vlPYklvwksCLzA5KfvYNEvVrItenEYFWtKwrgvhW8Vbo0w1F3nFlXJ?=
 =?us-ascii?Q?b4n+pFJRSUKdghsAKTeapFC6PRrhvFhCrqdQRyfcpkMYv9Ax72HjX4ahaap/?=
 =?us-ascii?Q?0Qhj3st1g0aqM9JoYHzy7Q4xAKdxS1QY4XRgK5biM3GFUVKGA974GfRnwBed?=
 =?us-ascii?Q?34Zd5suqPk7Aotkh+1Rz9O33ZBEZlpoL0Nufo6PpZAoihX5Wf3eAyA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f5bNuBCaWmSLPQZTfkag1NOUtmDlXOmY5jw7JcAWBwTWFaYsFgnDVIspVx4y?=
 =?us-ascii?Q?64Xaig1ep2KzItYeULOPUf2DanEyaYoxMkEyKJJmtonNIg3OPRkLct5aQk9K?=
 =?us-ascii?Q?CxwTJGEqouLjka+S9UwLyNAMs5QFeG73wfTNB2RlsFP2sB17+93gtwybO96B?=
 =?us-ascii?Q?tnRGfE3MHBuYMGs9biGpIyHw7QeL5v8XtXPFd7gUrQcw+DWxisBx6BZ1/jMc?=
 =?us-ascii?Q?5ZCLqQSHSjuQhjrGm9mMogaJGVZLgAK6IjQYVkamNmQdt+oHNQaMYAb759YV?=
 =?us-ascii?Q?ZcXsMfRpcMQ1HHFeMFRV0NbxnsJoN/2vmgjPST90Kk7me15R9JClWQCJg3em?=
 =?us-ascii?Q?t7yFwpUvkx10F3f6lfblp1TL8ILUsEfFOebaSPzeNeHQq60kf/VLsMHTyRrZ?=
 =?us-ascii?Q?CSoBEWV/IJSxFXqm5vRS76L/54pcTbWv+ueLyl1gNzBHR+gFL5O25NO0vrFU?=
 =?us-ascii?Q?7xgpdl3JTn2zJ92oESkMlKsixAr+pUMagcT47aoZcdy6CPYKZbo0CgswY4yX?=
 =?us-ascii?Q?Ofed4NKoQh04eD2zanT486cuJKuNMLOZV3PM4jzXM1IpEVVO2r1TTck3fwcP?=
 =?us-ascii?Q?XeZdXCIJZxMCIzt0OsL99fy8yUo+xFV+cpN0s0Od1IQnbjfSxICHj8QXw+FE?=
 =?us-ascii?Q?Len3xFr8wQJNJB5XBzX2wFwcA5UnuwHGE+EyRVBp5xjZmmJraqrUIzZ7lLFU?=
 =?us-ascii?Q?EqYFM+jnnAwOddtnZFl8JIAb/QSk7dBaDzB+UJUtxKM395yIzN5l/h1NM0EY?=
 =?us-ascii?Q?RDnJ1OQMQXGhWxHoylrRq3B3LqO8dLk7vdG9ZIT/ri3DbWRGO1GsBTdAy7Jz?=
 =?us-ascii?Q?k8pKsps+B7TZLr2Waa1TqMSL4NbYHVG3TiSHlQEwhx+97cqkasHngtzNZKHF?=
 =?us-ascii?Q?zTVgKOyak8Dd99jdoLDa+CmVDAoB1wmmPlCbV95U1oZWL1pNq/MibB/Bq8MQ?=
 =?us-ascii?Q?Pdp5qplze/HLlhimaxjlj4Y3Tf49TPpmJsfnHhUsMyqcW6ZfcdY8ZGI9bp5c?=
 =?us-ascii?Q?Frpp7eISr0oXcWfaNsgKBuuHR+3Xjg0Oj3e/aWkWNcxYOamIAoJPX43WxRj6?=
 =?us-ascii?Q?GQoOOxB5P8ZIthcz+zCQ6zT9nnkg4s2QyLqcPMXy5AxdId+Qn/rSqXyZ6C32?=
 =?us-ascii?Q?+u780x3bn9JVmmhgAuBVFU051fLo1hZqmIwTP2Jrd8qYV50mKvfCRgsCEkzN?=
 =?us-ascii?Q?lMCd/s1oY6mrCMAVxzKq1CP/2bepxOtuhuCu4mrN2k62Bn7e3AciXAjDCmVJ?=
 =?us-ascii?Q?0GR9/eJXBTxfaDPTiCcATh7Bac/or2VGtd4Mw0htD1qFHNfRdZIm7pIY3NSE?=
 =?us-ascii?Q?bkdyyra54nXvyoQO6zPwYB2BeCv4o0B4CdqaOvYkqqjhihiGovVU/SA2q5Bm?=
 =?us-ascii?Q?PwxVbNICp66lPu0k4FU8wGYQ0Cbcl6nEPdqUGTZJm74Uo7qrSotdgtd3YEKk?=
 =?us-ascii?Q?7t9v8YN85txmgmTh3noM2jAQkj106oqsR2t2MTBUOTbD4znEYfuT2iCuDNey?=
 =?us-ascii?Q?yJG5Zi1qP9GHVYybj5x9qo3Tx4ipN3LzxOz1Ugh8NGD7vbnbrxODD6GXiV8w?=
 =?us-ascii?Q?7lhr89cAKK0f9zH6zB7UCY0L2yl9BLDR0rIEicfyqeT3ayXNRuoXk24+cIfC?=
 =?us-ascii?Q?kLH27qh1mIp9OlLUbN5okTc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4913ad0-c869-4ed1-d264-08ddd6271ff4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 02:56:08.8786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AGUYvbhRueDCdrRvQ68jqtVv2G9tVMKO2AtxgEU4Mv9CavnAJqcoGBD//XsHgAi6gwaUsJ3WaMyN7U4sFNxYEnaTF8KIUj7IXHYPCwuHAX1CV3brGMOx1YOZkhwyrpT8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7203

In the server, if some workload which will create lot of
tasks, and will have many task migrations, we can get better
performance when we enable the CONFIG_SCHED_CLUSTER.

For example, the Specjbb may have better performance:
    Critical-jops : 26%
    Max-jops      : 7%

So enable it by default.

Reviewed-by: Christoph Lameter (Ampere) <cl@gentwo.org>
Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 58f87d09366c..054c96ea2235 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -82,6 +82,7 @@ CONFIG_ARCH_VISCONTI=y
 CONFIG_ARCH_XGENE=y
 CONFIG_ARCH_ZYNQMP=y
 CONFIG_SCHED_MC=y
+CONFIG_SCHED_CLUSTER=y
 CONFIG_SCHED_SMT=y
 CONFIG_NUMA=y
 CONFIG_XEN=y
-- 
2.40.1


