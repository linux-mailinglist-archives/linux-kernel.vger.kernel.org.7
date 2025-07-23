Return-Path: <linux-kernel+bounces-742792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CECB0F6C3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F9913B6919
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748002F2C66;
	Wed, 23 Jul 2025 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ooBIyhSK"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C342EF660
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753283372; cv=fail; b=nSOtSly1ijY78FkhueaWdu1buzpehw6G9tCDtlFUyBnuegp0Pm1up3+jQVbjZMeSbeYLi1DJF8u269OID8/zwdMcCdoiVkFYF5jHj0gRXiF2EfYfl0sr3/v4pdc8NAsPTKwJvFIyG7IzQQIUMmrsPAlW/SG3HqfoAF6GXBwABa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753283372; c=relaxed/simple;
	bh=tUX2PdilEe9+AGF10yJGsxISOyoHhadYIoPlJVfKk/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qVFADZMQy+3DDnL54wklEUdWCkjScbMZdPT6ezkJByaV/GK7RAVNafZePAaLBU5aniwMOJYRL3P6eLf0KCe5zrDgmOs2yxJVhHIyD5L6qmonhcq21kqX0rKICzPJg5XPRGFTKwn2ZecSR2CfV0mm52atzHERRk47hU6Ui/gpXfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ooBIyhSK; arc=fail smtp.client-ip=40.107.243.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vzITIrbjLE7A2pJm8b7P7jl+MYdfhD2rCLfEFGAbDSwTMkmmWEzfBDEjd9SbLHZ8sUYsFma8c1B4DOsXIv/Zq7Ej16db5xBU8yLBCIZGimVYoif3Yi7vIy1yALnilfN/8CEw+5Mo53gnad90CcPWWiUoqjEg2zSEn0pyO9YtY9fSDe/6Mosk2ecU8k0/kjm3KQXHyP4LbCBwegphJQOTpHN5sTwBlr0B03AE6oLTTQhSDXPlPGmoSvUzf4WULp7AuCMlDi4/jgkx+QBg3toxY8JVdipTSOmKRPEU7d8ij09ocS5zsoHcRgCUOhzxqW6ppXKieLg2jShu+VhJV42gug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7LbttFiHziZqXpZ0IXLgg78CKB6G+IxjTAVAcAbr7U=;
 b=o1v6+WBe/aHW/w4709/m7cOytBc+7pMizSApoTcsTzQrNZIFAH/7ov670tX2xb3tHYDqUXVMy/ONtWE3IPnGv3Djo6lHOWLUv7h6nIiaPuiwXGmpl49F1aiB4Llf66Qk90YnG5xuHIkU0Un8os8HEUL/UfuH/WIonIlfhtIRRdklDE18pQvlploqxRuMEkhR/E1U9A1I4MNScUsH+siXHnlG5K8Q+ega9Jvz+v5w7ypnPYxJhQ4T5INKk+k9Yj23YjzyT77dUgCN2jfEQYKCcvbGSwwDcQpCrMzbh3XY85Zm8kfkch2v4VYJS6CcQBmdcojgydWHJlRhOb1lAjAxdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7LbttFiHziZqXpZ0IXLgg78CKB6G+IxjTAVAcAbr7U=;
 b=ooBIyhSKemKLXbn30xfddfr4lVRWdIa4WtXajsAzwTQloEXCTQetBdRc2uxSiw6Tek8wbksDaP17NVuHrTHNMDZ1wgc5BeLphd/OTmtCU6/bskXh9a8hsJ5IjmImxJM9p8UW/dSi70bfXrW57bQsgIvKD2iIEt/ybHbhNUtAL4KylJii0O1h0Nw+DJq0eLc8XrisPWurrBPADRkhfjJkSBmU85796OE+94lGNiqjXAnH5JLsWM2qDvTjBnvmma6PW69ZxVRDLGZCKC5n60VlflEjaAPlxLP10+JM9nWKO4Le3La/7N1Fcnl798ojG2wpwgS/MgvioGZ1eK2ThudEmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS0PR12MB9347.namprd12.prod.outlook.com (2603:10b6:8:193::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.21; Wed, 23 Jul 2025 15:09:26 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.037; Wed, 23 Jul 2025
 15:09:26 +0000
From: Zi Yan <ziy@nvidia.com>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, david@redhat.com,
 willy@infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 catalin.marinas@arm.com, will@kernel.org, Liam.Howlett@oracle.com,
 lorenzo.stoakes@oracle.com, vbabka@suse.cz, jannh@google.com,
 anshuman.khandual@arm.com, peterx@redhat.com, joey.gouly@arm.com,
 ioworker0@gmail.com, baohua@kernel.org, kevin.brodsky@arm.com,
 quic_zhenhuah@quicinc.com, christophe.leroy@csgroup.eu,
 yangyicong@hisilicon.com, linux-arm-kernel@lists.infradead.org,
 hughd@google.com, yang@os.amperecomputing.com
Subject: Re: [PATCH v5 3/7] mm: Add batched versions of
 ptep_modify_prot_start/commit
Date: Wed, 23 Jul 2025 11:09:22 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <4526856B-A908-431C-AB9A-063BAF810AFC@nvidia.com>
In-Reply-To: <20250718090244.21092-4-dev.jain@arm.com>
References: <20250718090244.21092-1-dev.jain@arm.com>
 <20250718090244.21092-4-dev.jain@arm.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0138.namprd13.prod.outlook.com
 (2603:10b6:806:27::23) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS0PR12MB9347:EE_
X-MS-Office365-Filtering-Correlation-Id: 880f2e23-6110-4d1f-99aa-08ddc9faea38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fuEua9cYCYctU+GariTSygse58rgVI7UyzsbrsFf1vHKdkQ4bSMTMaUmmS9X?=
 =?us-ascii?Q?Q5azySaLvFQZcd0XQOWsd5FAVCh2nWlyvyjcZm9HJjcCEBKFQNLKsoheRdHT?=
 =?us-ascii?Q?vRuSjOm45/bZRMoq/iCUa4mAetl+SVyOblUEz+bK5VoC32IOff7cWMJ/86Ro?=
 =?us-ascii?Q?3MWh85ZhEiyDx+nm57UYM6MC1QWi4JLldcE0JTAvffzRcAHC/Kg7iUgd/zEv?=
 =?us-ascii?Q?hy9kTDMqP6UzVNvEGG4+3WgCpR2c3EA48oxh0zKJsSnk7O39fWhiXhDWJHyx?=
 =?us-ascii?Q?dyr094nGK/+zSrQuZ1H4tpGgc1icD6cu7vThl3HVugq6K+ugOgy953loB6MV?=
 =?us-ascii?Q?DOWKEz4lHLoeBKrrbPvKDK5Ll7uCGC6FmPz1adNzjq3yPBPzShKvBfKtQgEX?=
 =?us-ascii?Q?JeYpfYy1i9bzqRaDJ8LZyIHLftWRjPeh8TnbcurA+15xC+x9bxv097nLd7Hh?=
 =?us-ascii?Q?y1D2BCYo9/03q66LvvMwofk68e8t6fsM7KnoshrTUKZdXzcAJvg78FNjlAh5?=
 =?us-ascii?Q?1qG0l8lIXCLjjNvyceRL4O278Q3Awx/vkeYmo3SnYQuKlzp+g6jj7IjkvHwS?=
 =?us-ascii?Q?B9/KGUy3l+MKXpMVprq+i82wqhqOqmy1WmB/HJFE1o8gzzKOJQUgA1uP7i6K?=
 =?us-ascii?Q?7HaJ6H14caf4B056Y2gk+Tk6mgXEKjs5ubeftdjuWuDrGc4WKBuelKmIGFQH?=
 =?us-ascii?Q?5fW8tFrzAG9RTWVARPEQqFa0/zPX0AL8L56unK3A6PN7/xOUn/HBjthvWtd9?=
 =?us-ascii?Q?hb1z3cpq2w+lwMHwGWN0VTYyqFOXR9L/cvR/v2Fvv0pBtqcuH4WjX0Jusx+V?=
 =?us-ascii?Q?jvV7CsWjrXzK3LYnzTUDmJGbUPiMm4FOM6fFnPtteUgx1CGPPlWs9A2lIfKG?=
 =?us-ascii?Q?pHW+lFTW2LheI9ivLW4PRXmdQZHXupW/ON4mNgdsMdctZ5xdUbeIuyZrzsfQ?=
 =?us-ascii?Q?5hKXGV9Yd/z3Y57td79Te290HvSqKtd7ydfRQkAW9O1oG5vuBrmnj87FU7cx?=
 =?us-ascii?Q?Zaq/3WGN2cRaRbnq6zxaE3CMSCTIJcS5oyr3wOC1CwUVoM8azfCC8OXJdwB0?=
 =?us-ascii?Q?X126ReEvTggmBCdG6gmksXwJhtdEw5JrNpibQXW9yo/L/YotPiHxUpD1fSdO?=
 =?us-ascii?Q?cNONCGpxslTC79tYDfvd3L+PqUtPocBdLdKwmd22+qAyQbLxILFoLAnr2jqG?=
 =?us-ascii?Q?Pjj0/lKs1HvCze0KcYB1qwGKwMbSDAXvMYOWDTJScep1dB+BqsczJHuFqWpP?=
 =?us-ascii?Q?deDiLnCLWssL5DtBzgJjuUpLn9379mFHRLEzXri27wAHHVIFQgZvB5Px9rzD?=
 =?us-ascii?Q?Uittzd7poKEqmSRR4WPUo8jxRjW/jVORg9dpqkxm6yoy7a5dVWZ+y8Vnqg5O?=
 =?us-ascii?Q?hOg2bIkVO31Z9fvwdetYz1qhkxNEq2Isqs5IqyqqL6cTZX2uhA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5K68X9repAjFR4K2IQG80Q+v+RhtWRx7CLDcnfdx6dqJvrHB8trT2j9d4zCZ?=
 =?us-ascii?Q?DTLoqMH1bGPezH6WhuuZiNfUcAChc91HVh0sSTMLKm3p76AYulplVMkYo6OG?=
 =?us-ascii?Q?hhMqvqadvCF7ZO/xGpIigpji1RtmY3gt6YxncrNGXa/n/RI3pJnW4peMiM2d?=
 =?us-ascii?Q?ZT2JzHnJ3o7YkFgDowm5NNbvSmY38IV3L/2DnHdMEjnz/VB2Oll+Jzly4gck?=
 =?us-ascii?Q?eDAEE6YEMddwCpkRBttBOWakIF+Op1gEDpRfoy/EyXSQ1WhAvxcLVW4hID9h?=
 =?us-ascii?Q?Bacn360udUksnblSRwNNfuw2ZtAlWLm2QTZ7zbPJ0T6BEYr2AdGI6JD1FCef?=
 =?us-ascii?Q?2z7pHGeTx3N5VZqgciQ894M4IHV4l6i/YciU8RPwydsmtt/yhGDBSvvZI17w?=
 =?us-ascii?Q?7Y6Jvw+7zNnPpnWUDtxuzc7p3wPUycPTYtDRRIgM+gEorhw0arXj20Mb5aRR?=
 =?us-ascii?Q?rMU4UxEEB6gj1Rf5UOni2W8IKYWNds5BI3O/GpCRnrfnutk9RNTdfLLCE8C5?=
 =?us-ascii?Q?URUKLVe9ahVumafGG4QV/80BUko2o1330u04Hbhy3u2acc+PebGo5ZGT0d15?=
 =?us-ascii?Q?n5u/UKNVBscdYpdS6oaShrMoQoyPKvw6Xf+iOftUDvHU/GVp8oJOMpjg/6zj?=
 =?us-ascii?Q?FYLD6NxkDquHfvnBq3NN8zCJR5iglk5NIoWEMr2FEQdBzorL6VPS5rWtXTDu?=
 =?us-ascii?Q?TaAfE6h/v5i6KS9mVBxs+Kai3v6uVB+CTxPyv2M+qQRe9hSgfQdNu/YesGG/?=
 =?us-ascii?Q?at2ZjtR/eaz4Kpv1vnJsj40aCuaCGbckmSwBc6xjV94fx3z4XBzb7OGDE+M+?=
 =?us-ascii?Q?n9KGA3uTQ18gxybUf9p2b0b/1oukODk+IWSo2v3ZhCs85Kv2gw1dRbn5kUNN?=
 =?us-ascii?Q?0ZEVbGH40Vw6Ms/IIO+eWU0wI3V/Co+JtaqPnZqerKR1XjszHZhmdEAc8t0F?=
 =?us-ascii?Q?UXiW2e2AMSOEPrP7mrlRBLY4GGxOa6j9akeQm2e6j46so0wnnwIsOYYQiF06?=
 =?us-ascii?Q?Hs1KSrzBm+g69JOhQvQkbo+oCFHAL8o20KWCyqDPqFGw6EWriNvUwylk7XmJ?=
 =?us-ascii?Q?xRj/cDro6eb91xRMOsZQWyEw9l4+4HLLNECyjEP5S3Df3mLffNuxba+RbV5G?=
 =?us-ascii?Q?DSRIJVpJ8J1NNlgjO2ftE+sSFFZDaeeUHjUlycEUmyY4BzMAPrutU/I1p3Jx?=
 =?us-ascii?Q?Rt0LXlFyDASIn/ihL6kARZNeTt3YyaLdEVG2F36AGaymmEPoq2HtRstPqcL/?=
 =?us-ascii?Q?uK/sVdwkpWaioIA4CZNoMM2BT5QG5WqDCvdcvceEwP1SFDF8GwaitI4R0YXP?=
 =?us-ascii?Q?o84gataqQxzLqjxXOm1iAV1EGVpRd/8TFlEiNpnHsbbeegoL1a+XBxRD6Abt?=
 =?us-ascii?Q?sACi0QwG/91JrUhOj/Pq1y4I5ND0gHiz93+dHRzcAjzbJ6K9kADaLl+PO3hr?=
 =?us-ascii?Q?gCgLmJDvasKvazWa/Osl0zmRpeNhyqTJERRgS4uDYmROmL3dmd8RBE6iGJyU?=
 =?us-ascii?Q?EOqfC+drxV6Dl5IwGvaqoLBaHSvk+rha1w+cCOG+ivjfEfyTc/fb0SMLSkRS?=
 =?us-ascii?Q?2G15oIzBg4Qmm5BP09ZCerGKFKEDhyvlz5SQGEtU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 880f2e23-6110-4d1f-99aa-08ddc9faea38
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 15:09:26.7197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R4Jt1ellmlGGNcsso15cQyrD7bM7gQN1T4gPxq3mYpc6qs8bsNKtWBVBP06bOLzo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9347

On 18 Jul 2025, at 5:02, Dev Jain wrote:

> Batch ptep_modify_prot_start/commit in preparation for optimizing mprotect,
> implementing them as a simple loop over the corresponding single pte
> helpers. Architecture may override these helpers.
>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>  include/linux/pgtable.h | 84 ++++++++++++++++++++++++++++++++++++++++-
>  mm/mprotect.c           |  4 +-
>  2 files changed, 85 insertions(+), 3 deletions(-)
>

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

