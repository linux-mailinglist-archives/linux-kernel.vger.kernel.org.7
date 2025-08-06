Return-Path: <linux-kernel+bounces-758189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8294AB1CC36
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0B1216A4E1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 18:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD4D29CB53;
	Wed,  6 Aug 2025 18:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rowyPyW7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="crGt/IWo"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28B719DFAB
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 18:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754506426; cv=fail; b=AqEHfgUeV1RB6yG8YXCJMmWHbU2zap91YFM7O2r6wIuKi1AjSibSkkgzWgS6Of0eFwMknzbM1l5SQla2l3iTkRV/VSIIqryM7h3hoCgaPrxZ4fcBjRQv7rU4Ckbx2PJom/3cb5t/aQwkNk1cB9jt+vUTV+vkX2BIA2a1qbVEEuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754506426; c=relaxed/simple;
	bh=qo9/hvlCVbIDA47tFKuW3SbuyQU8Y4cxS+dxBkzaCI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UtAdP3qVtfs4MVhKDP2fzu+hKXD4plcCCfwoF4VjHeSTjvl8kr6YZXDzgdOk0m6Q3KOWbfXk01hchvKW3oMr7gvabBXOvXVAIK9+1WTYZ9fbPbFPhS1PWza+57/rFM840+Eua+x+Qqp9O+pjeNv/mSpmYmCVo46CUjLFk2Ky6zQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rowyPyW7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=crGt/IWo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576GRPat010802;
	Wed, 6 Aug 2025 18:53:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=vLRWCSyyHoSUz33e4S
	g4No89xl0FopAPd1l0u5cJrV8=; b=rowyPyW7escrxSeV8dNsf/927VSuw0kzZS
	TSNOxgxgNIM+Nf3C4e3yC+qPDtngbOVJeETWjDRo9RGyOVqWc8KnBJOr6ViJ09Mg
	t4BTS/1LSYC/FOAVMupoSl9bhixhK3yP/zI+cJGsDEoTQJs9S2DgLkujuJbf/2l1
	RQvHLMqQ7BKG0wlBQFrBH5IVMZ7vacrclVXllcZOPNX4x6LsZQFnT1PHGMPkPIqV
	huhE8V1PoaUYu6dTSYwgjduKNtwh7gezXO/VMRL1zljk++T4qWtEYPt3Q1N+Jh2c
	SD5hRZA2AJs1x4m3KBieNjk1UskOJcFx4iRL+Ythu+teS4zkSLNw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvh2cxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 18:53:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 576HITKf005633;
	Wed, 6 Aug 2025 18:53:29 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012027.outbound.protection.outlook.com [40.93.195.27])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwxe879-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 18:53:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WcrF1o4Cm5/MKAlQsgbX/gsqwOTrCSvdj7vFBMJnRBxaJtzyPVyYNLQNYFPpKyAR3c1U+sja/QtrS252FDPwQgRCxWbdj4+JEJOIvPwY7WBS8j+YsBWAYoVcLF+XanzZ+LEPoZxZvXi+IzG4SG7HvO78duAfaVdyrj1cZHz7gz5Pn2yGy19TAwWS25vWd4rX+dBzlWRw4dCl/OM1iSYE2vXuki5GsjRhU1A6jLF/WqGlGBVGSpRfBcAeiXtTHgKaMae+SgbjG798fTO+Lhifm//uyI1z9UMo7HBrg6yZw8gfzkqtGmSjLQLh0dr64nHAv5URNioPHK0BleSYN6AdKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLRWCSyyHoSUz33e4Sg4No89xl0FopAPd1l0u5cJrV8=;
 b=Lxk7wgWnlh+ZzsgcqoGzkWucgN3i3AZEVAMMqddH6pRa9lTsSZd/Iv2mgZjZ/LZmNGF3Zj3soLMalX9yvEDml9g/ACK7dael8zxijlk1NGcNTgIttME5xclr+q8/lhEiA1mdn3/5ZvgfCvRdW5aFx5b6I+U+ZZy8LF0vrCl4nmsTeVGej4XnlsdKH/yM+5688NCJstTHXzCjfdOHCZ9X5ny6oU6+HIKCak7Hf/hOlEPemoCZxVfwl3tzlzG7G8FN0ViINvbY2OXPyvb2fbeseaghk+Kd4vum1CDbGdzVBAnXwdAqaEm2IlPQkPJ/ACUxO4PRY0xknl2UTCwPAL6/1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLRWCSyyHoSUz33e4Sg4No89xl0FopAPd1l0u5cJrV8=;
 b=crGt/IWoShJt7c9O05psc4SQOJa9+n44BOfejYN8ZgdINpg68cYpsa05h/OXrU7o3rB9Z8JWvLuCV5Wut7/Fz/3y3mPlfg9hWvK94J27D/SRHW7l0qkgkB0Z0QtucJcseJWIcX07Yz+3VwQnE+wgjhJBuFfbEm9ZjM6ZXh2vQ8Q=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by PH0PR10MB4437.namprd10.prod.outlook.com (2603:10b6:510:3a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 18:53:17 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 18:53:17 +0000
Date: Wed, 6 Aug 2025 14:53:13 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: maple-tree@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        Alice Ryhl <aliceryhl@google.com>
Subject: Re: Maple Tree Work
Message-ID: <bgfvgss3ojbgspmlihmv227x3w2v3y6xjocxu2jaq6bjp2tozv@rgaj5koag5eh>
References: <20230707163815.ns4kdz7iut5octjv@revolver>
 <eec96998-fefe-4e60-96f2-549e349a46c7@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eec96998-fefe-4e60-96f2-549e349a46c7@kernel.org>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YQZPR01CA0094.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::22) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|PH0PR10MB4437:EE_
X-MS-Office365-Filtering-Correlation-Id: 41a7aa45-56a8-45b9-38fd-08ddd51a811b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xMKSD7FmKfMC/8gCaZfvq2IdUxb7Ej6L/XHIm4EVWTr4VGdK7B/b/VfAuQMP?=
 =?us-ascii?Q?KBxUJJbhKiYzLiE3S1qAb2zSBML4ACTQROnC8nliAbesFlgRoWMfepEfsZor?=
 =?us-ascii?Q?Y9I4VDaxhoQnPdbQQkwLCSeRIoWwSuymf2RmvyI/OoNwZ/OGbchPRddFkyHN?=
 =?us-ascii?Q?N0bxg0eyhImXk21UIXvp7J71GET6noQx6LXA2zwI10TN0HJIxJkErEruIqnq?=
 =?us-ascii?Q?CtnHD3XRdV8f9LXLIBbVq1F58pd/5qFGKJsfPJtuSTzYrSSyiNXcoeTSntXM?=
 =?us-ascii?Q?FsDSZ5St781F/3uDQUF5k89PbiXyuyB2JHdIseyuCdfcUONeotXfWjKZqWRp?=
 =?us-ascii?Q?9rFp9aWRv9DKR5kpd1mR+f4QAa8XhQrud4QE7OTEN4PlvooF2QnbHRmZFI/I?=
 =?us-ascii?Q?a06PixuZmRwBXtwj8WkuxPLW2QQX0smqm1Q9jAZWyrrzjbyth7HYO/+yaBgI?=
 =?us-ascii?Q?KQ6xKfti3EGP+ab6bO6qVCKc/WiuS4AbN9ELSoNwekdZRYuwQCfEcZvtOcx5?=
 =?us-ascii?Q?2mApnBuxg3oNnYarnaz8WNH2tOt+jXEY6HSZtFvN11NYUeD1XYYa7VD9lCu3?=
 =?us-ascii?Q?5TfMwhsTGgBQ7RH0Nj2UK0nlTg8OLme1nJED9sUpSbEZq5263EZNHaO9DcCq?=
 =?us-ascii?Q?f7tjdnKnP6Q6r88bKKL/mjesgvlV33XTJ6KL6B47qZwCXRmRpA69MddO7fm8?=
 =?us-ascii?Q?NjQA79F9/Bf7E211jsSEqUX5XC0701at7d7KZQw6dAXZj/zQmtBDVN3ChKVT?=
 =?us-ascii?Q?4DSGsNLr3SIwu1gSdyeWoIdiSor5ECgGWQogXBqQAzMDcF4Kq1SvO0dfSaT7?=
 =?us-ascii?Q?5ujVReaL1YIHrM+/Pt6eHRcpP1Gu7AcmsmS2IjoAWaU+Xq8HqX5s4FyS72kf?=
 =?us-ascii?Q?/XqMCDlgNuqeZDbCVyAm3TBCVJ9FoFJ3nfdl4F9thRO43CeEizyqjSIzI1Fq?=
 =?us-ascii?Q?84P3MJdxu+yUlfK09N+UIGTbsif+smJYSgTNzHp+W2ww2KX7qjScjG1AfjXa?=
 =?us-ascii?Q?A875SEN3QJ84395c9b+9IQWUuwbDx/kBy9Sag9Jl/IObu2q38cWQz0znNtX+?=
 =?us-ascii?Q?vbdM4gyVhNO7pQgDQlOiVyhlijph+hB+dTEktFJkDRggxQHfwAQhQauBHP8o?=
 =?us-ascii?Q?w0SQz5SCFDkiXO+zWhlWZz07YPMiaGVcBYBBvvm6NAVV/vw2q0dlAvvW5Dj4?=
 =?us-ascii?Q?KwFJIiebcjz0yojeOhAtv6QRyYyEVqDr5zQAQJympvgwFda5QHVywdLyOwsU?=
 =?us-ascii?Q?mK9ySxFbT8ZNq+Uotk3AuJTnG3Zm+43iG2dhR1vpvYcEadeyfYejewoh0ilv?=
 =?us-ascii?Q?rjk/cgJKgJD7S2MwwoHuqix8enhriaM9I9SROPh+1tbEV0m9hY5j9g3b1+5p?=
 =?us-ascii?Q?F1xlAnk1WQCkWvoYVvOesg3Q57IeYcBUNjwO28EO1gjM8mWS8agwHFYbKLxF?=
 =?us-ascii?Q?tiyaIKqk4Ko=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T4EjO+2L2LJWAcgNgMF62m8w6e5osI476H/j/WdNTyrLlOGoFA+5aBHdQLoG?=
 =?us-ascii?Q?uMziFJ6pmfUfsx6F6PyRKoarBg2aDRhBefdjEN42VT+cE+5yAAV8ze3FA5gu?=
 =?us-ascii?Q?OuvQdHmJvgrO1WFqxdUMeYuVO+BsnaV34MtlyXDcWx104u2wjGwvz883wbsF?=
 =?us-ascii?Q?Iw3jB/D821qUexZS+ci3SWal0dR3CCOYOrj/bOTzWwo5n6B5MnE8raGfBGHO?=
 =?us-ascii?Q?/BYvUfMKmdxRHO4vcF0nlVWRS1yN4YqUanyU64x2tkFQ06lYd4x/YRDZHyMG?=
 =?us-ascii?Q?4V6yR4FjHlJHcBvcbhg3ErewHNmffdjHlafKxEZllDoH/K51gkAbiwkBbD89?=
 =?us-ascii?Q?xiKs5rGMHyqW9NrvLcYPW8MQjqm3MpKWZFReCt7Bq7rzOx/6VjU6tydS+u2d?=
 =?us-ascii?Q?JsELMsedJ1lqROQUzhrrxAE+VUarpXWPoOJTP+fyci6XXKjYq4BLCEKtAVNk?=
 =?us-ascii?Q?dY1ijKA3kK1n7vKJAXvOhnpcqeijE5xAZuLfIRQkVPlcRPm4w8i4BXKtjJ6s?=
 =?us-ascii?Q?HlBX60DqV6KSywFvwhSkRPItBr88l3rhHy87SPUA2XgIXQ42k1nI1MBL6Et8?=
 =?us-ascii?Q?ZygF7ujP4Uuoa9tEpUm/Au6FTOaPs1id9oSJE2lR1PKfNGhAmTXQhqn+akJ/?=
 =?us-ascii?Q?TqhOQ9FJPklb07KriTbYytXFvn1zztkzk6h7BY1/eWt4WkWO38mDT+EPrUiv?=
 =?us-ascii?Q?4liJR/7gzyerVBuClxFVDupWkAq2BoSkXeOg0bysSGbnuRRE3I0uTKLKTvWU?=
 =?us-ascii?Q?SbaG5W6mZQ1hyiI0EY45hGCLyrmc2HmBW/l5ztsM8HY74dZTe0wo8RexSqqB?=
 =?us-ascii?Q?yvzEHG62mAsFFRhjhYtgxQGscC842ad3OMvN0kQe13W03rDpQLTgQUFCliHV?=
 =?us-ascii?Q?1Bb+/eGvuGYPcVOM/HDYJ1Pn3l7G8zGEaE8X90/2dV0ev6SkoeatP9cEZkgs?=
 =?us-ascii?Q?SbznM9a1Aq4KLMzT5zSH1Kpu9wxtQtRxDhSHOwNeN7FXmbW7U/PRNLO/Y6/Q?=
 =?us-ascii?Q?pVrAFFy6snxL/2xh9US3k9fSBjkbBSc8O3LfJCQBBa1FBvUs7LB16jEJ2/WW?=
 =?us-ascii?Q?dlowjE6UZBFSC5Q6Ul+dFgQCHm+9+fpk+epxPP61BQr11QSpYkDShhDxd7k4?=
 =?us-ascii?Q?357UVvhxOI+IQ51qgX3Id8fFZd6aBJn4w5hOL6C1MdKSHqO059NTGrfwGf3M?=
 =?us-ascii?Q?bkAyxoes/cjd0wWEuUEIglntSV7iz0WQX2KXihTUIGwHEmn1ij2h8LUQSnc3?=
 =?us-ascii?Q?2MOTw4GZDNCrrbJhKYmYmSf53pG+R5K4KlClAL8Hj6meXSty2CGDmT1LW9Ca?=
 =?us-ascii?Q?mghapz54IZ6LXE3HKum2gOkPHV2PNKebMdnjA5nMM5ObrXeE6/Ly29kGvSW2?=
 =?us-ascii?Q?QZNvXvXrOOAG4y/n4CdkSgHLpcmy6NMM/8JuYo6opJIqzDCFyZNb4Jx7/R1h?=
 =?us-ascii?Q?4DTJRffzIfVCfYSt0ezqC1XXjO+qPK1L1Yj1Zb5rnpbe3CWFFOnsLLt1jtFf?=
 =?us-ascii?Q?3P1EUoKvJDTuvCo6H1vmIR3QjXko4zlI0vAjMwX6L1uC3DeCzum+9iyCYVha?=
 =?us-ascii?Q?7dYfuagKd53AnhsdmaraJS3M/5rsSY2Eve2wnpX8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	F0SGW+c2I0rBdUtH4T5pVe5MaX/7YgKc/AcU3YqfZVmkaMKotSo9RkWxv4o7PJTGNm0K7AClDlteKvaYeJKQDtMizH2mTlM5NOqg3dOXPnAhxY+kaEcAqdyAcd1/Q1yzbzsatdxe3Xnt/rwI4IX17OoTu7Qhp2onQMVECXvsSd6z/adRb7pWI4wBFTOWkaEKWwBs6WLhwcfnTDxfhUpz1wneZbU1zoKzoHrGy6vxynrJubiCwPmte0l+4FMgWEdDBIkpvwX8NgkZa2I/T9yhJaBWDp/DPaTcpsFYFQlS7wgY9U5LHHXbL99anJdE6urtilkP3ZGQGRR6QX9DF3GzIvOXzaD3hLvrNhylmNR+zm5v1rdCSRSiSnPVj4zNSJd+wAPIaiVlES4fBjhOdN94k7ZCrgOQ7XAen47GzumdVW8aETiRVOXYjCUUkXoD9SWr0qynFzLNP5TowZT11m5fMOBWjqIQM0V9AsQxPe95hExgDoKiaF4VPZj1SbeXg7h3hQ3OQGZ2mwjHk60f1Aiwb1Gn7fVRlYv4+lOj2gjub/n0cApdyIzKlwE3cQjIlUiX7q8QpvshZAUOC17O1svGlAdYAbDZZN1ZQB9/AItdiQg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a7aa45-56a8-45b9-38fd-08ddd51a811b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 18:53:17.0231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6hPaJ7iPfYC+GV90Rh5v+f2rtM3Rtp667geRNSBlHF7WJT1RLc4NhIxwEv5FTj9cXyOhXcdEU9ujAZFzv9+ZIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4437
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=829 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508060126
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDEyNSBTYWx0ZWRfXzMWMgruAjqLT
 Qym9WsG+D+uqWk5nTWoi9Ss3Y6BadmoWZN7oI6T6fGWDc1ANKbhYCN2GoDaekg1EJT/E/SDSuo6
 fYVwIdBMSNBqT/627tmG66EniIlvthxLMISi6vehXCsAsZoQb3sIMSbAEPFj9mQbfmCNziiLPlV
 UWX2K2Ysb8ba8R64qROaO7j9+07cg34JPtNxjYhNfTtX9yKQiDjW19/lVaBZeSyJDYUMlwq6o0u
 EGvquF8Opcnv9BYqe4gZfUiSTsn4v7ZW7XF+A1H8gx75wvKcf8Sdu9LoCXDiVwb+7MYJ2gd6efc
 EqaM1DSigbp97L6vof+nugosFshY0ExhcK9fnynOQybjn+Pr3yDYQTydufQm+m5VTUA8sW3U9xy
 OPbWjRdVYhmx6Nl6tL5qGF6CQTwPFIvH7TJqh4UWT0tTBk1NXeSJs7R7j/0fhsy9tZxv5uBE
X-Proofpoint-ORIG-GUID: u0I9FZbluFok0ZCbQrHLJW9DGzUC2J3Y
X-Proofpoint-GUID: u0I9FZbluFok0ZCbQrHLJW9DGzUC2J3Y
X-Authority-Analysis: v=2.4 cv=Hpl2G1TS c=1 sm=1 tr=0 ts=6893a4aa b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=HKTvNjBZAQSsPUk-qdAA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12069

* Danilo Krummrich <dakr@kernel.org> [250729 08:03]:
> (Cc: Alice)
> 
> On 7/7/23 6:38 PM, Liam R. Howlett wrote:
> 
> > Larger Features:
> >   - 64 bit stores on 32 bit arch
> >   	A number of users want to use the maple tree, but cannot because
> > 	they need a storage medium that supports 64 bit stores on 32 bit
> > 	arch.
> 
> Has there been more thoughts (or even progress) on this? Managing GPU virtual
> address spaces is still an interesting candidate for this, as they may be larger
> than 32 bit even on 32 bit architectures.

Yes, thought has been given but I've been working on removing the big
node to get mixed node types going.

I think I have someone I can get working on this now.

Thanks,
Liam

