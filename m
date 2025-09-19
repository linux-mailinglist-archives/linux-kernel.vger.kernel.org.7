Return-Path: <linux-kernel+bounces-825059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE0DB8AD20
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B97B91CC634E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76499322C80;
	Fri, 19 Sep 2025 17:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Qaua9is0"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020088.outbound.protection.outlook.com [52.101.201.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D1A30DD38
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 17:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758304182; cv=fail; b=YNInP/QIcCfIJLM4ddeyx7S7nzDLzHJuc5Q0ODW9OlAETnNyEBdVql87GA9If6g9KBmwJxnAmOAAsBf9JSKhSWKMHtF9hTtwOwWwymkwF+TLwDVHjm+yNiI4ixoe6bIH8Yy3IJJiGYyw1fplplG2OxQ13MefzT5cEM/edxZCRhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758304182; c=relaxed/simple;
	bh=kr0I14z2ha46VqaXHfL51TiX8IM5IANDqvhOpm5NbfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s+XynJKPgcIaIMPeU8vlDyzgKsN+VYbcl1V3wuTtE7OTfj1d72sNkyIgctKJcfgnelxG3iOiPluxTfohfOJ9I0JATnoL+rNaoDXK5oyj649sqpNWm11iGXVDo1WpzIrsyhM6H/uABiZDjK5U5rCVyibvD6TldLrnQF1OoV/gLhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Qaua9is0; arc=fail smtp.client-ip=52.101.201.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EpSPiAv95CsMgnHB0sXsfRZ7oQ4OsIZnrggHfB6F087AiOEw0B3UrPRZFER0ei/UFLJeIP/Eel2taLJOcaSu10GMDzC4tWZYvgpDZEKsmh9O8gtF00ZvGA2MP+HExfne6kExCCE1X7S/W329JD4TIT08N/BzIZneqjXDd/Fl0SL8xR3jwDUHudJy+N5fsEoorhBDC8lsDQvGQ7RpFvtHRcdwCQoEukGhdwjpX5Z6DVK5d1vb0wmLr7GMNo1KLrOvblqR9CWUxs/t/fEf43g5Klm2dX+lisRZuNuQB//TMJFkjXJ/WEBFJSZWAwIOTtP9atqldaaDH952tEIx+jncig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuWwvRBLWRt1IcUC+T9VtvQdlRq+dkuYEjt7Lccqviw=;
 b=t7XheImcdjQPDF1ArA46FdMytH8HOvOv9bMpEzXojkUzGYsuc/ouV69W0VvoEtgmYlL8Z6ZNKELSlCT/oV+QvYZfhlUpeP4yZHGJvXwPL5BSwdfO66QNi/klyqJZakSqJbe/LznQ92ayfj6SVJS9f389dWtJmf2wnTkFu9Z7b5a4mFOWmux89/GcGGBUcNAMiBpLzcc2GMs5lrgbI1QpUMeTRUkf0h9GkJet+rg7f7gSh+MxeqTPPAibFzL47d/l4zxrwo9ihwf5urf7BP0muhlUTDndlC8Sh2ZUyOyDbjECAzLew3QrwejG8EiXDti8B3ozJ38ssE5NZ1hHdMiiww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuWwvRBLWRt1IcUC+T9VtvQdlRq+dkuYEjt7Lccqviw=;
 b=Qaua9is0vyF+/7nS1XVUxvTQBlVGulfjRdxP2aXkD+O6CN2z1g7tJmU/3/iDnZJtg+QF9eRbhfO7ZKbc4itXE78alE1XBMugsxgsZBf48wl4H+bYcXU4gIQoN49Kjave+JFEcEFTdCm0DB13mN/oJddCzoMd58qLHNA9LztgiGk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN0PR01MB6862.prod.exchangelabs.com (2603:10b6:408:161::11) by
 CH0PR01MB7017.prod.exchangelabs.com (2603:10b6:610:106::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.16; Fri, 19 Sep 2025 17:49:36 +0000
Received: from BN0PR01MB6862.prod.exchangelabs.com
 ([fe80::8a1e:34a8:2ad9:7f83]) by BN0PR01MB6862.prod.exchangelabs.com
 ([fe80::8a1e:34a8:2ad9:7f83%2]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 17:49:36 +0000
From: Carl Worth <carl@os.amperecomputing.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jie Gan <quic_jiegan@quicinc.com>
Cc: coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] coresight: Fix data arguments to coresight enable/disable helpers
Date: Fri, 19 Sep 2025 10:49:32 -0700
Message-Id: <20250919174932.3490404-1-carl@os.amperecomputing.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <e1a2ee99-07bc-40f3-8742-a0cb1c273350@oss.qualcomm.com>
References: <e1a2ee99-07bc-40f3-8742-a0cb1c273350@oss.qualcomm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0065.namprd04.prod.outlook.com
 (2603:10b6:303:6b::10) To BN0PR01MB6862.prod.exchangelabs.com
 (2603:10b6:408:161::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR01MB6862:EE_|CH0PR01MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a24d3fc-cb2c-4eac-a364-08ddf7a4e5b2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FUqjTxFDBeL2+F8DtJhLJVE5F8qMRHEDORLIMSQ8+u2Yt6TBko4H8asjPyz/?=
 =?us-ascii?Q?TKxfDJvrjm2R3ZDRm5bab0uLkyj3k25M6RZ6LKo47acLprUN1EGacrmouzLe?=
 =?us-ascii?Q?eel87+8lnW0fQQc+eNp2FT6j88DvzIadJ9FhnsPsnojNxi+jqY/WbiEiAdGx?=
 =?us-ascii?Q?XTtyFbrmnynUxchTfL6aRnEk9FJbXlKCdoKYFd8PwuFXu9wshEbslftQqaEd?=
 =?us-ascii?Q?hDCD5rQjfoDQCURw+41u3VsgVHkkBOLWW1FvcQgM9PHDvXOtRfIJwEZ5/Axj?=
 =?us-ascii?Q?+dP/YZtcyNW0pDt7m1mY0Dot7rKao5/kqkMU5kw+fPMfITsdwtBNqw7qPqSL?=
 =?us-ascii?Q?eaBgGgSglctbCb8vAAymZ8pCTleb/TrYwWI5zarJzo0jH2CEKSN9nUKyMZkj?=
 =?us-ascii?Q?B+UxggHrIxxaTnPvw7GmPwG9P1MFiJSxvp7qxZ70PrrfeeZgfeO4l3/IQ/Eq?=
 =?us-ascii?Q?8z0RLaXlDr6zpW5bCebF4bqas0tKPcnB73KzUM8A6lADiECQhVh0tkyVwCx5?=
 =?us-ascii?Q?Cy/BqmWWk4LVPdYsRNd60raeEAN9oHHXNfs/p651OvXPXBQ9wYNCQyQAbHWO?=
 =?us-ascii?Q?U6bs7qkqk0OSPl32yCc1CTg/n0+4RSwC2pBZ/gG3xTG4OPJrZ8kePae1D/im?=
 =?us-ascii?Q?JtxwE+w35+VzMpNwpIAN0YfQIWt8dxsWxfd3APUZ9FFlnA5PaR79hBmC+xTP?=
 =?us-ascii?Q?7v0U9o1/jEWZAg5uC4zVuaT13PP922rQ8rxDwDIo5oDUDKZZWlttP9et1H3K?=
 =?us-ascii?Q?ggrCxI65bQ34xrEe+ZoU/jz0xeLI/N3CZsm5/lMYnXPWZgeEhFhZleQbZPTS?=
 =?us-ascii?Q?AZ/RnyEsPIU4sI+05qdGU/kZqnK9Yza/I6GyiKGH5KDA6cWHEE3W4+QkLhro?=
 =?us-ascii?Q?78pS70cCuaicChMVDVVsBHnJTtPxs3g5olMJGNEe8cN8ldeeHvmr/mu+QTBG?=
 =?us-ascii?Q?OYouHQ8UmJJzJBpZkELB6x/k2wTWGS5bAbP/J85yrRWVZu0Jw39+9bVr4n0b?=
 =?us-ascii?Q?BS43akanwVGffzmHDFDC12XnMMeGXI3XFty/IhzG4scRuDCNPxAtH4XIe+b5?=
 =?us-ascii?Q?MidOPwa7DlyVTa4Xw4lim1MSvFOWZrD2v3O1A1wTg+X0BBNhKp769NGhpWx2?=
 =?us-ascii?Q?PnQzX3V5QgdqX7riVgbJEyqUDjL4UcjGp7cNNcuHnQWeayEqijZN+tn2/WNY?=
 =?us-ascii?Q?0uOdhjiU45HIloaS79JBtWr5tXsRzBfuYZqCpAWU7zuZyNW4gZSCBbr7ynSI?=
 =?us-ascii?Q?Jj/MBl44DSFtwQygi++PYctOWk0fupblMris1ItlgCpXz1j3GbckyZB2uZ/q?=
 =?us-ascii?Q?HpzmzyWCiF+avZOYtSy+v0diptfdQYGP/fBTIuyngeTJ6qWVKyY4rYvjDT4C?=
 =?us-ascii?Q?FuvTNQF1mq46bTHy+sUDGJjItT37IVoTDe+88IjSbo+CyhE5BuYCCjcT/sVV?=
 =?us-ascii?Q?4AqznEQWMcKqmSUdjOGLUMduRGRPYJUBGN1uXJYMVhHpng9w/IqsJQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR01MB6862.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vLDVwttW5Gm2s+oDAY1lkIBIM1tYSWOQd1zFMehuNLklJSwIRs/vPJrU2Y9L?=
 =?us-ascii?Q?+XkCM+7kHhVBE2mAN8d7zWav/00FDXErDvEPCd3QfHuCMpvH1lCRAiSyTuSS?=
 =?us-ascii?Q?sxCfED43XEoWabdFTraX66xr3qwN8oTvhMUBCn03sopTxeBVGT0hZFevLZSp?=
 =?us-ascii?Q?nud9X3f3WQThkb9ll/+4/93JEdakVhgRsSGcvPMT6htJJefQJpTMOOXIwuPl?=
 =?us-ascii?Q?6iVAwzxMsqrKP9DaNrICX9hj9irZGhped1lweGHJbCZDdP+p7KOKW1sy33p7?=
 =?us-ascii?Q?Xfyp3XtCrTL3ikS/Eo7YiduoJZVYq+zV8LrAC+/S7d/ggy1V4lQrmhKzJfHG?=
 =?us-ascii?Q?CRSnUFgzN3xvS8h0R0OfKWIb8Q1t3yJOZz4KZwffAmvKtZSZNL/TiT+47j7K?=
 =?us-ascii?Q?23ZjjrAn+myPO/EY9RG01d8J5GFi5rCgFSP00964Ldydyi7AT6WQ47RFFaku?=
 =?us-ascii?Q?8VMO8Ukbnal8mA9GbBpQsLl0wQeaQnvzd5p+EMdO4kzvzz1YvgPrOl/hrrLP?=
 =?us-ascii?Q?Covy3RG5J3Ty6Yb2BIvPmdMUyZBjKkK/lLJ0Cwjb1RFAffzwdFfVN50fs0Wo?=
 =?us-ascii?Q?Jrn4XJ7UkfDV6K22wVjP6D3C9HeRLP2qGplijNXNryFsQko0WAzDIMX82IB4?=
 =?us-ascii?Q?qG7s3tHOxKa4i2VJ+V9WAIkPqMDAK5cMjvPiSt+ah5WuCgdpsBBvhYNpH3kq?=
 =?us-ascii?Q?3M3ilN5EJJKX3yKrw/BqzhpFsXFqJASqjkhzwhIeiTuqPBH2Tm/BJ1WiaxEk?=
 =?us-ascii?Q?L7VYok8ibtaTSlKF/fUJxbxbO7BMue5oLPT7aZ0dazCFC/UXxJ9UBdFheS83?=
 =?us-ascii?Q?Hi46R+fq5V0O6u6hHwPGItbPu8EE1+FRcIUVyHWY4iPKrq4aHU66moRBoD+u?=
 =?us-ascii?Q?arbVEUYbrZhwziDtUqN5KOIqpMJfnA6B0zczxN+y5xsYC7gQU7mv5+/8gA3o?=
 =?us-ascii?Q?SEXxtw5iLkusIdoolv75FiiuSlFoQL1Q3AlQKEDQOjeJ6L9Ow9qWK4m5fpfz?=
 =?us-ascii?Q?mWsxcMFArRmNeNq9At8/nwJX/8zbenrY/jy6So954P0U7yQV9z6NOIgb6iGE?=
 =?us-ascii?Q?fvxO5TI8mmdPOQ3F8KeBM9S7M8Nc8JgnzLAbT+UXrlrFEFra2KFXH17c4BaB?=
 =?us-ascii?Q?QEommKlOs09uzAMtl//5s2rwv6SWhBU2KDF7A1dCaVFrfLwLkb5tEjlyaQ43?=
 =?us-ascii?Q?oN4OISs5aG/Y7XEuAI2IgfCVf0VPS8z758ahJhAjXuDr8jbVfneKM9ySheBL?=
 =?us-ascii?Q?x4IlCgHBHKCazNFgJehkltoEjK7yG1wxnO2iZ56sdzjeeHQtOjCzAd9tjws1?=
 =?us-ascii?Q?ScBO6orPHaqi+4JlhioVbhowrffa22gEne5Sv/oIPVGTDQbFKYyhKSNswJRo?=
 =?us-ascii?Q?btMO3b+MABgV0k3Hj2fAnrXHpux/jGPfeZyzT5U47xYkhdHjzxCmas06NO4V?=
 =?us-ascii?Q?kpmKMfNNRfWWF+VWIyBCG0MV/kmoVnq8hBiJxAYpgu3H7UYfm5EETvCSRSMH?=
 =?us-ascii?Q?xiSs8hk2OWSUpsDJiCZB//KiUAiHSrI7V1jrMj9SlSG4Ys5CdjZppfTxCO3n?=
 =?us-ascii?Q?SZunlJOMAsZ5GBCO9mdv7Dc39NLFubWetvbBk51JEYpwm2Oko8oPsF4mi1pU?=
 =?us-ascii?Q?Q1YI4zCOQOFhfLWobNHplIo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a24d3fc-cb2c-4eac-a364-08ddf7a4e5b2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR01MB6862.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 17:49:35.9048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fR5NIyQ4bO7bm8+zIugJG7172bgUptQbbnZX+WoOLN4wYQKPkntdYiEr23p2AquCPdonVnTBJz0Jrdjm/PPPrZ8Oz3EnwwC2aqOpgaOtokg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7017

In the commit being fixed, coresight_enable_path() was changed to call
coresight_enable_helpers() by passing a struct coresight_path*
as the final void* 'path' argument, rather passing 'sink_data'
as was being passed previously. This set the groundwork for the
subsequent addition of the ctcu_enable function which interprets
void* data as a struct coresight_path*, but it also broke the
existing catu_enable function which interprets void* data
as a struct perf_output_handle*.

The compiler could not flag the error since there are several layers
of function calls treating the pointer as void*.

Fix both users simultaneously by adding an additional argument to the
enable helper interface. So now both the struct coresight_path and the
struct perf_output_handle pointers are passed. Also, eliminate all
usages of the void* from these code paths and use explicit types
instead to make all of this code more robust.

Note: The disable function is also changed from void* to
struct coresight_path* but no implementations of this function
need the struct perf_output_handle* so it is not added to the interface.

The existing bug can be reproduced with:

# perf record -e cs_etm//k -C 0-9 dd if=/dev/zero of=/dev/null

Showing an oops as follows:

Unable to handle kernel paging request at virtual address 000f6e84934ed19e

Call trace:
 tmc_etr_get_buffer+0x30/0x80 [coresight_tmc] (P)
 catu_enable_hw+0xbc/0x3d0 [coresight_catu]
 catu_enable+0x70/0xe0 [coresight_catu]
 coresight_enable_path+0xb0/0x258 [coresight]

Fixes: 080ee83cc361 ("Coresight: Change functions to accept the coresight_path")
Signed-off-by: Carl Worth <carl@os.amperecomputing.com>
---

Jie, I looked into your suggestion of adding the struct
perf_output_handle* to the struct coresight_path, but I couldn't
justify adding event-related data to the path structure, which has
nothing to do with it.

So, instead I took the approach in this patch to plumb both arguments
through the enable path, (and changed away from void* as you agreed
to).

Note: I've tested that this fixes the bug for catu_enable. This patch
also obviously touches ctcu_enable, which I believe is correct, but I
have not tested since I don't have ready access to the necessary
hardware. I will appreciate other testing.

-Carl

 drivers/hwtracing/coresight/coresight-catu.c  | 12 ++++++----
 drivers/hwtracing/coresight/coresight-core.c  | 23 +++++++++++--------
 .../hwtracing/coresight/coresight-ctcu-core.c | 11 ++++-----
 .../hwtracing/coresight/coresight-cti-core.c  |  7 ++++--
 .../hwtracing/coresight/coresight-cti-sysfs.c |  2 +-
 drivers/hwtracing/coresight/coresight-cti.h   |  6 +++--
 drivers/hwtracing/coresight/coresight-priv.h  |  2 +-
 .../hwtracing/coresight/coresight-tmc-etr.c   |  4 ++--
 drivers/hwtracing/coresight/coresight-tmc.h   |  3 ++-
 include/linux/coresight.h                     |  6 +++--
 10 files changed, 45 insertions(+), 31 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index 5058432233da..724c25d0afa4 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -397,7 +397,7 @@ static int catu_wait_for_ready(struct catu_drvdata *drvdata)
 }
 
 static int catu_enable_hw(struct catu_drvdata *drvdata, enum cs_mode cs_mode,
-			  void *data)
+			  struct perf_output_handle *handle)
 {
 	int rc;
 	u32 control, mode;
@@ -425,7 +425,7 @@ static int catu_enable_hw(struct catu_drvdata *drvdata, enum cs_mode cs_mode,
 	etrdev = coresight_find_input_type(
 		csdev->pdata, CORESIGHT_DEV_TYPE_SINK, etr_subtype);
 	if (etrdev) {
-		etr_buf = tmc_etr_get_buffer(etrdev, cs_mode, data);
+		etr_buf = tmc_etr_get_buffer(etrdev, cs_mode, handle);
 		if (IS_ERR(etr_buf))
 			return PTR_ERR(etr_buf);
 	}
@@ -455,7 +455,8 @@ static int catu_enable_hw(struct catu_drvdata *drvdata, enum cs_mode cs_mode,
 }
 
 static int catu_enable(struct coresight_device *csdev, enum cs_mode mode,
-		       void *data)
+		       struct coresight_path *path,
+		       struct perf_output_handle *handle)
 {
 	int rc = 0;
 	struct catu_drvdata *catu_drvdata = csdev_to_catu_drvdata(csdev);
@@ -463,7 +464,7 @@ static int catu_enable(struct coresight_device *csdev, enum cs_mode mode,
 	guard(raw_spinlock_irqsave)(&catu_drvdata->spinlock);
 	if (csdev->refcnt == 0) {
 		CS_UNLOCK(catu_drvdata->base);
-		rc = catu_enable_hw(catu_drvdata, mode, data);
+		rc = catu_enable_hw(catu_drvdata, mode, handle);
 		CS_LOCK(catu_drvdata->base);
 	}
 	if (!rc)
@@ -488,7 +489,8 @@ static int catu_disable_hw(struct catu_drvdata *drvdata)
 	return rc;
 }
 
-static int catu_disable(struct coresight_device *csdev, void *__unused)
+static int catu_disable(struct coresight_device *csdev,
+			struct coresight_path *__unused)
 {
 	int rc = 0;
 	struct catu_drvdata *catu_drvdata = csdev_to_catu_drvdata(csdev);
diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index fa758cc21827..cc449d5196a4 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -353,14 +353,17 @@ static bool coresight_is_helper(struct coresight_device *csdev)
 }
 
 static int coresight_enable_helper(struct coresight_device *csdev,
-				   enum cs_mode mode, void *data)
+				   enum cs_mode mode,
+				   struct coresight_path *path,
+				   struct perf_output_handle *handle)
 {
-	return helper_ops(csdev)->enable(csdev, mode, data);
+	return helper_ops(csdev)->enable(csdev, mode, path, handle);
 }
 
-static void coresight_disable_helper(struct coresight_device *csdev, void *data)
+static void coresight_disable_helper(struct coresight_device *csdev,
+				     struct coresight_path *path)
 {
-	helper_ops(csdev)->disable(csdev, data);
+	helper_ops(csdev)->disable(csdev, path);
 }
 
 static void coresight_disable_helpers(struct coresight_device *csdev, void *data)
@@ -477,7 +480,9 @@ void coresight_disable_path(struct coresight_path *path)
 EXPORT_SYMBOL_GPL(coresight_disable_path);
 
 static int coresight_enable_helpers(struct coresight_device *csdev,
-				    enum cs_mode mode, void *data)
+				    enum cs_mode mode,
+				    struct coresight_path *path,
+				    struct perf_output_handle *handle)
 {
 	int i, ret = 0;
 	struct coresight_device *helper;
@@ -487,7 +492,7 @@ static int coresight_enable_helpers(struct coresight_device *csdev,
 		if (!helper || !coresight_is_helper(helper))
 			continue;
 
-		ret = coresight_enable_helper(helper, mode, data);
+		ret = coresight_enable_helper(helper, mode, path, handle);
 		if (ret)
 			return ret;
 	}
@@ -496,7 +501,7 @@ static int coresight_enable_helpers(struct coresight_device *csdev,
 }
 
 int coresight_enable_path(struct coresight_path *path, enum cs_mode mode,
-			  void *sink_data)
+			  struct perf_output_handle *handle)
 {
 	int ret = 0;
 	u32 type;
@@ -510,7 +515,7 @@ int coresight_enable_path(struct coresight_path *path, enum cs_mode mode,
 		type = csdev->type;
 
 		/* Enable all helpers adjacent to the path first */
-		ret = coresight_enable_helpers(csdev, mode, path);
+		ret = coresight_enable_helpers(csdev, mode, path, handle);
 		if (ret)
 			goto err_disable_path;
 		/*
@@ -526,7 +531,7 @@ int coresight_enable_path(struct coresight_path *path, enum cs_mode mode,
 
 		switch (type) {
 		case CORESIGHT_DEV_TYPE_SINK:
-			ret = coresight_enable_sink(csdev, mode, sink_data);
+			ret = coresight_enable_sink(csdev, mode, handle);
 			/*
 			 * Sink is the first component turned on. If we
 			 * failed to enable the sink, there are no components
diff --git a/drivers/hwtracing/coresight/coresight-ctcu-core.c b/drivers/hwtracing/coresight/coresight-ctcu-core.c
index c6bafc96db96..9f6d71c59d4e 100644
--- a/drivers/hwtracing/coresight/coresight-ctcu-core.c
+++ b/drivers/hwtracing/coresight/coresight-ctcu-core.c
@@ -156,17 +156,16 @@ static int ctcu_set_etr_traceid(struct coresight_device *csdev, struct coresight
 	return __ctcu_set_etr_traceid(csdev, traceid, port_num, enable);
 }
 
-static int ctcu_enable(struct coresight_device *csdev, enum cs_mode mode, void *data)
+static int ctcu_enable(struct coresight_device *csdev, enum cs_mode mode,
+		       struct coresight_path *path,
+		       struct perf_output_handle *handle)
 {
-	struct coresight_path *path = (struct coresight_path *)data;
-
 	return ctcu_set_etr_traceid(csdev, path, true);
 }
 
-static int ctcu_disable(struct coresight_device *csdev, void *data)
+static int ctcu_disable(struct coresight_device *csdev,
+			struct coresight_path *path)
 {
-	struct coresight_path *path = (struct coresight_path *)data;
-
 	return ctcu_set_etr_traceid(csdev, path, false);
 }
 
diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
index 8fb30dd73fd2..f92e3be4607c 100644
--- a/drivers/hwtracing/coresight/coresight-cti-core.c
+++ b/drivers/hwtracing/coresight/coresight-cti-core.c
@@ -799,14 +799,17 @@ static void cti_pm_release(struct cti_drvdata *drvdata)
 }
 
 /** cti ect operations **/
-int cti_enable(struct coresight_device *csdev, enum cs_mode mode, void *data)
+int cti_enable(struct coresight_device *csdev, enum cs_mode mode,
+	       struct coresight_path *path,
+	       struct perf_output_handle *handle)
 {
 	struct cti_drvdata *drvdata = csdev_to_cti_drvdata(csdev);
 
 	return cti_enable_hw(drvdata);
 }
 
-int cti_disable(struct coresight_device *csdev, void *data)
+int cti_disable(struct coresight_device *csdev,
+		struct coresight_path *path)
 {
 	struct cti_drvdata *drvdata = csdev_to_cti_drvdata(csdev);
 
diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
index 572b80ee96fb..2bb6929eeb19 100644
--- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
@@ -112,7 +112,7 @@ static ssize_t enable_store(struct device *dev,
 		ret = pm_runtime_resume_and_get(dev->parent);
 		if (ret)
 			return ret;
-		ret = cti_enable(drvdata->csdev, CS_MODE_SYSFS, NULL);
+		ret = cti_enable(drvdata->csdev, CS_MODE_SYSFS, NULL, NULL);
 		if (ret)
 			pm_runtime_put(dev->parent);
 	} else {
diff --git a/drivers/hwtracing/coresight/coresight-cti.h b/drivers/hwtracing/coresight/coresight-cti.h
index 8362a47c939c..73954369654c 100644
--- a/drivers/hwtracing/coresight/coresight-cti.h
+++ b/drivers/hwtracing/coresight/coresight-cti.h
@@ -216,8 +216,10 @@ int cti_add_connection_entry(struct device *dev, struct cti_drvdata *drvdata,
 			     const char *assoc_dev_name);
 struct cti_trig_con *cti_allocate_trig_con(struct device *dev, int in_sigs,
 					   int out_sigs);
-int cti_enable(struct coresight_device *csdev, enum cs_mode mode, void *data);
-int cti_disable(struct coresight_device *csdev, void *data);
+int cti_enable(struct coresight_device *csdev, enum cs_mode mode,
+	       struct coresight_path *path,
+	       struct perf_output_handle *handle);
+int cti_disable(struct coresight_device *csdev, struct coresight_path *path);
 void cti_write_all_hw_regs(struct cti_drvdata *drvdata);
 void cti_write_intack(struct device *dev, u32 ackval);
 void cti_write_single_reg(struct cti_drvdata *drvdata, int offset, u32 value);
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 33e22b1ba043..65c4984d98c0 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -136,7 +136,7 @@ static inline void CS_UNLOCK(void __iomem *addr)
 
 void coresight_disable_path(struct coresight_path *path);
 int coresight_enable_path(struct coresight_path *path, enum cs_mode mode,
-			  void *sink_data);
+			  struct perf_output_handle *handle);
 struct coresight_device *coresight_get_sink(struct coresight_path *path);
 struct coresight_device *coresight_get_sink_by_id(u32 id);
 struct coresight_device *
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index b07fcdb3fe1a..2ed7fa2366ce 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1325,9 +1325,9 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 }
 
 struct etr_buf *tmc_etr_get_buffer(struct coresight_device *csdev,
-				   enum cs_mode mode, void *data)
+				   enum cs_mode mode,
+				   struct perf_output_handle *handle)
 {
-	struct perf_output_handle *handle = data;
 	struct etr_perf_buffer *etr_perf;
 
 	switch (mode) {
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 6541a27a018e..b6e2b00d393a 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -440,7 +440,8 @@ struct coresight_device *tmc_etr_get_catu_device(struct tmc_drvdata *drvdata);
 void tmc_etr_set_catu_ops(const struct etr_buf_operations *catu);
 void tmc_etr_remove_catu_ops(void);
 struct etr_buf *tmc_etr_get_buffer(struct coresight_device *csdev,
-				   enum cs_mode mode, void *data);
+				   enum cs_mode mode,
+				   struct perf_output_handle *handle);
 extern const struct attribute_group coresight_etr_group;
 
 #endif
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 4ac65c68bbf4..450cccd46f38 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -422,8 +422,10 @@ struct coresight_ops_source {
  */
 struct coresight_ops_helper {
 	int (*enable)(struct coresight_device *csdev, enum cs_mode mode,
-		      void *data);
-	int (*disable)(struct coresight_device *csdev, void *data);
+		      struct coresight_path *path,
+		      struct perf_output_handle *data);
+	int (*disable)(struct coresight_device *csdev,
+		       struct coresight_path *path);
 };
 
 

base-commit: 46a51f4f5edade43ba66b3c151f0e25ec8b69cb6
-- 
2.39.5


