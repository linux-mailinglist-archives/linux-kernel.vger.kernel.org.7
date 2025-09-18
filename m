Return-Path: <linux-kernel+bounces-755277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD46B1A3FE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42C2D7A7EA0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6037526D4C7;
	Mon,  4 Aug 2025 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oibP+v+z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qG/MoKnl"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA48425C81C
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 13:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754315976; cv=fail; b=EqI2AQeOu8BbPOIDgJRTI++tfYJSL8YepU2V1DxEfzS6KZO70eDSVMDC5M6ed4rZ26QppUh6uUMJrbFbdO/piHyhJkl48s18jOD8fUDCbhwuAlmQBfwB9s9Z58BXT9Tzbed8nFBSGx9u4d8Bz4YoKiSsFIISQ9G77FixBlqrJOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754315976; c=relaxed/simple;
	bh=i0r3lqRiUl+6QiUK3YIpAmituDWR/2IRuKvYkDybc8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YeNukW9HksQeZ2cPugqJ7y4ObF7aMpuNoc36tNlgXPHYDQ2rMCluLEgi2Rf39NKh23thy5GrPtvL41REaRFRCC5m8iYZNmFuPTK2gmgZ7JHIKSRk/3yWQ9ExYL7zFKEqU6tq+0eFu6CkaFkXTSSM14wkDMShIPnjfjCdkzW/Quo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oibP+v+z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qG/MoKnl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574D6Wod028484;
	Mon, 4 Aug 2025 13:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Mhw+DSMKXcJ3ZFvkl6
	8UbtK24f2cviohRh1/zJWWSZo=; b=oibP+v+zXVNXNlfRZz30HsAphgYVHhbUsJ
	JmUQQ73+wrhYgjb4QyzGhKjmfsKhhUgj8Q4ZAfU1yz7YLWNQewlRWOtswJ8KtM+H
	nT7BP0BV3xGywlYZc2cVHNz9asARLxkyKtHtlIO2H/3zYLzhUjK2/hk9cVo3UyQI
	cL/TjZIY+95o/q7yKziZ9ZT5+RGaZNkXzfTAbsdblvmoDPl4b4bANQrRsFXab/7B
	//DJJ9iclcj5vmOCs/XZ6nQ9h39S5JMMQAy5rPQ1tyD51zckNQZ6OVkdrJD15k6J
	9d86a+SaosLsiob51NEeH4SrrQD2XcNZQRxQHwIld8rLY2RKEOdw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4899f4tngb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Aug 2025 13:59:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 574D8mxK018081;
	Mon, 4 Aug 2025 13:59:09 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48a7jvxcq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Aug 2025 13:59:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIaHESaD0KjnV0bc9x8f6ACw4LSzETPiqfM5EPWKtuSCfnYVxpxrPUCAXxnMVPCgAeioplFOV1JONfmQUvz6vKpWEunAlBL7mjE9qbwPr3vt1ZdFcjV7HNBhmLKyZkO3+2erQQhOS3O8UE9myx/ZiVQOXn25zHZWZO3s6/dLMOMrlMhhBN6c6192AkLyuOa1m4Ej+gIpgSGO7lI/AXGeU7gOHCtw8K/UBVwC5JKvPUc826qOMp4h8IeKEA10Qx9YBg4BGgiMdyvvywcge/YlplSrcmMGFmUcQJgodHySH0C8Os9diHxRov8yKva48HhZ3WOOk1vQEAO4xO4SoQn8zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mhw+DSMKXcJ3ZFvkl68UbtK24f2cviohRh1/zJWWSZo=;
 b=s4nZhgM3ZjZL1ahONvGJbAnDt9CaUiFz7fkfqxukZixeSBcJ9sJcaB8q6nkOyFKx5a9nks1HQYzpCkvdD6F8LwirpdI7bFxGxeCOK6Rozev/e+NOHfXSfxJtt+OXOA3A4fPTkJyk8XMk/93Pwmsjtxv2F/OGzb5ahpUnLUZYCqxPv0v0prDpi0igktJf+XiGfmrdo64pCm+8w04KLwd9n8IyhB6s+UnZOP0RyMGHnh1psZccE9FyBpc1RhKZxkdtZUdLwUrZWtqKNv1ZaXHgZy1h2AUfIp/z35zmWtvtbsFVIvWkpE5QgU0ZXtg5EKTBed5EWlxHHrqoCFl55KSJ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mhw+DSMKXcJ3ZFvkl68UbtK24f2cviohRh1/zJWWSZo=;
 b=qG/MoKnl1OjGiPmuiBuKVu7lT/emX89Kf/pKOiD/XfUwW5klopgt6RA9ex7aH95mEYz5MMvTWqNaT4hw7RphMA8EZhGfCLb8Epa/ZfRv0gmsz7A8PbFpeEnP3nE0As2O3lDD2IS/7V5EDuwCSrpslfeOVlvRNpgMadavI31LPD0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB5005.namprd10.prod.outlook.com (2603:10b6:5:3ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 13:59:06 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 13:59:06 +0000
Date: Mon, 4 Aug 2025 14:59:02 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Li Qiang <liqiang01@kylinos.cn>
Cc: akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Liam.Howlett@oracle.com, vbabka@suse.cz,
        rppt@kernel.org, surenb@google.com, mhocko@suse.com
Subject: Re: [PATCH] mm: memory: Force-inline PTE/PMD zapping functions for
 performance
Message-ID: <2a1b7ebc-f27c-444e-be89-df14ac1dc97d@lucifer.local>
References: <20250804123923.296230-1-liqiang01@kylinos.cn>
 <ab22e314-63d1-46cf-a54c-b2af8db4d97a@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab22e314-63d1-46cf-a54c-b2af8db4d97a@lucifer.local>
X-ClientProxiedBy: MM0P280CA0114.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB5005:EE_
X-MS-Office365-Filtering-Correlation-Id: ea56a364-9c6c-4102-0078-08ddd35f13dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i57I0V+7EBPY1xQXaWYN2GWCYE5/KHwXDH/2gt3eEW7qEpAb2nZs4B1JnA/+?=
 =?us-ascii?Q?O6uiHYhauKu+tMjXLLr7u0qi5+fNQm105OgHjYBccPF/AVx6/nO50W1B9Dhi?=
 =?us-ascii?Q?Mfa2M5aadAE5JHa+7KGgARbvHQsxT2M4tIH036nKliEk3o8qNfXXNZj2xsv5?=
 =?us-ascii?Q?C8btHOXz7pgWGCmiJNU+B3nBUJlc+PpOODpAEa2OWOeiDEpVuqXBdlIXo8E1?=
 =?us-ascii?Q?JYUMszICxC3Z7IpfBaKcaNToAItBcsdEYHEidHlzFzVmmtumLUY0CVcGRBmn?=
 =?us-ascii?Q?bc+6hq7FeFIbGoJoebRm1Ia9L7jv0hchXjzVE+wQyaPwpdTv3TvKI/CHgy96?=
 =?us-ascii?Q?t+uds/f+NmxsWdZjWsWH4k9RNgdLwReuBXZsdZOvjZ3o8cHRawxtD7VsbMwu?=
 =?us-ascii?Q?5aNu3L9rqt4NHi2IXi7QwURIKd6EiZwP7F6gV1Rlp92a9ydoluSpTSnf5Ags?=
 =?us-ascii?Q?9MhIWVgTHhyNG46La4A3T5I7Xk6d+zIQN+WqoOTuBiwhVPT4WvxtQ6qiTRsA?=
 =?us-ascii?Q?29jyGOmeb9/8Eica2/3JsVJZN9ePMT46Y08A+gDIGM0si/BbWmQHRvZgPhTT?=
 =?us-ascii?Q?WgfVhTEK/IrrAxRPBQ1l5YVLZ97uDen0yzjTSp2s6lTSxVR6qKhnWU3fiDvf?=
 =?us-ascii?Q?Se09cm1ZO7vAHnSSx6rZPOll0wrCnjQsKeGZ6hs4lNzm9Ewh8yKWv+sd8/Wi?=
 =?us-ascii?Q?sXRGbsf2wMlqlnjzj61fYg5UrvQhhVRAtr27DE5q4esPEWt/QnIfJ/mzaPUr?=
 =?us-ascii?Q?0WreY+n+6kgZ5grZXuICyws3XKqKjbhTAkJfXLOCZr9nkFeMEN/B1N+wIJzO?=
 =?us-ascii?Q?EHmwnU9js6UVJP90bVnPtnZQir1Dh1zjIvUyriNQeJghF7PnLwY4NCAq9r2c?=
 =?us-ascii?Q?0yJRHr1LAKMzxNFWWIT0+39LC0wmXri3xDMrc0+26NlS1ywTcfwxYiMCfuCS?=
 =?us-ascii?Q?WVprF8EtJpzryJZP/d+8hqqYHCBMBDqmuryUdNRXJfiOthIhTiqx5YrRed5x?=
 =?us-ascii?Q?ekbPVI1OVFaThbX5zKMNrkLKOG00d6bXh4imF1J0pWvwC1f0INf7/3mtk96I?=
 =?us-ascii?Q?9cjQXmqUxcvjeBXBDq5RVt9Eahy+UHOG8KPZraPxOkvSEPLR6ktg0JKME2zF?=
 =?us-ascii?Q?lxGHQuCF/ohiunuKaLfeJlmABnitbDD/30cijdK+EkrTSFidKw6iQdN6Eg0d?=
 =?us-ascii?Q?hApAX0kff+LPu6yIUERWC4c0BHhHVutuX/5gZduh1PL3oColSagfODM5gehm?=
 =?us-ascii?Q?iks1cgzqxoQsfyvOB0EEB9fD23bPAZQg932B6U2rduM+1Cx/0z6ea+uANDH4?=
 =?us-ascii?Q?cOqmd/iANM6QZPYrt4rBuNy/1JCv0NCExgXU6GaNgAP7mM2xjiNIhmPM+9AL?=
 =?us-ascii?Q?DsaDwSPSskIVHZGtKz14UrfNrqVQevwThB0xrkLW/ruxoy/zxFe18ZreYT1X?=
 =?us-ascii?Q?ZNz57hwxLtU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D1eZw9WDO9ZS/xWbkRUJFQKLAHpLBIzDUowd5nXdwpxiKOAVM7C9dOXO9SQO?=
 =?us-ascii?Q?uu0sGiXwjrB865vs7j9D9ErWdI8BMv+gUHH4SI5rqBjgfiaxBfvOZGYNOT4Z?=
 =?us-ascii?Q?X/ef39LpiOZ33IgllO8CcnsbbDSXcuznK8RNMj0U681mZcJfMM6m87nDyuod?=
 =?us-ascii?Q?D83T+bsX2gO7AVV6SPittlQe0cxKuXEON6zc7amwN15bewqAwX7Ipqi5x9v/?=
 =?us-ascii?Q?Wfxt/eSQzXa6IaLN7b3znLlruFk4dwxp8k0h0psSnUyTdMbWL1O/x2DBl7Tl?=
 =?us-ascii?Q?AslYAx062e9dKeTS60N69vLH4Pn34RNojoE2xgjzd1bGNA1kDBWQqo0yDGYI?=
 =?us-ascii?Q?V8B80c9VAxTnnPG82HRrEW6Z6e+SArk45j5SfxbP8pJm+O7+CRYjBt7obMp2?=
 =?us-ascii?Q?AsJFt8k2BbypKqiWROJDTXVE79V1mdQsNKbAyhgS/OYNNy4E8LmiofhEzPLR?=
 =?us-ascii?Q?cf66KG/HfeCV5Zgh1cFojeZBQcPuJVHt4kwPsargRbAMyDwyYBoZLyFhUuWh?=
 =?us-ascii?Q?cxx5Dhufm9bilkosNpNrSEcAn8v5NvpgCuk6bmbD1EA0Y+AtEBRHuiGcE291?=
 =?us-ascii?Q?j4zGFOG0BpNwF4ipXN+go7viVu1x+1gPwicAEI2AMxgbo16ZUdhyQCE6Nb0Y?=
 =?us-ascii?Q?WkNOIgmDej1Nmfinp+qBsshIF/Oeh0qcz3P1iAdXR9w2OxGGLT5067nzwCSs?=
 =?us-ascii?Q?YHQf5/v2sxfBFxhPiXvay/CYe3zPxpRq6Hhp+StZXkAyWOzCtTvqnEAsh787?=
 =?us-ascii?Q?rt+Ck9jvlwPv8/EwS/haGn1eqslF72xGJA0K8gubaQo+8vAHbWaVOq3sSB8f?=
 =?us-ascii?Q?Tl7r5VirOcGpNh2i4Q0dl3dAalHlf7gSw9F/h2hoXk6iVJbfHmxUhcd6vfn1?=
 =?us-ascii?Q?XuyjAVW3Er9Fpmin9DEY8kmPrWIXuNELoHXVwqBj/TpI1YgI87BPaeRh2OZm?=
 =?us-ascii?Q?8i0WWEy+gZ9trCfcpFN0SUhxL5sNQ65MctyqKjOoqfsEjvx+MKQC5MFRYKa4?=
 =?us-ascii?Q?Y2asOh8PAQek1seGH3H9/gjT8FCPwVLFbQqJWfGrUECrwBkvoCct9ddNijDl?=
 =?us-ascii?Q?nvkWkFMi1j8FfyuwpCFfi+VAuKbiPQjGzFobD1Y+/rC1GIJnr2TKmNdBpsGj?=
 =?us-ascii?Q?ip9M/SskXbvmM/S/sO40RwyYcyQ4js60c7870IrTrSvCTB+L4HGvEwMZzG/k?=
 =?us-ascii?Q?XQ5k6KSKE5zISUqbae+TClaZKiE9/D8T55VFdm+U5bGSYpBoMztZr/UG0UOL?=
 =?us-ascii?Q?l30TDBaO2OXGCyEpSzIvdaIW+JKSPGqri3bdLVII7alAyQqdmemeu5RTdugC?=
 =?us-ascii?Q?Kyl8hM2K1Ml6wIJFGdia9MpU9OPYOawhuZV4NCrSxqJ4J4/znaIVmKwsUgwq?=
 =?us-ascii?Q?NvioL/vRYSj5x7mJR+7RI4NEbBYRHOivLKh2V18xrHgoNO/WZzutY4EtXUTJ?=
 =?us-ascii?Q?cZYYl8UeDbOoVdOz1RBPeiwLGAel0YMNiMfTcw2q99HLQ5zPDfKYv8EwtuG1?=
 =?us-ascii?Q?bz0nGGctfVUyOjvLwEwPXpglw8YAmeQg/ALl4uuAuW/xXAlh4QmDExIxdKpw?=
 =?us-ascii?Q?zrKTVrqNflru5Ueuwha/XsLjZRoXTtZLS964fosVNBcb3zKMtj2geMFWfNCg?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RcMv9TZRNaou2u8o5ES+KWVnQVmlLfTTc4ReukHWQ0ie75J0lTAIZ0S+A3KAPZ2IWhElyyeGBSxdJBTyRD6PgJyDpieiSBmdajsUAVhhHjr5ENepHnyn4/0DoN0GHFYWkzgyJv5O2r47/bT3NjtCqspy8ySCWWNQdriQkEkNENkPUVD7vYTvGHUC0Dke5isNGxg42+NnDaESL7f0d9g34bHQIs7q3nQyvbPElJXo7iISt33h1yS1hWv3AY8hei6+XHZ2UWBOGSTbka8TubZE3Af12anWnn/AzOkmNBR1wvBEWofd+m5fqrF96Hi7SqIGB5oNowJyW0sz0BToB5KbeW8cIIzj9CvGSrLAZTL60c4jhsBBh/eVkmGvW/+UkXf0EI0k+uKAt9j3y09HhbbqzlF1AyANWMTIdDS9LjnUzExM+ZuU03HgSHpKA9l8v7rvEkkIJY9PvLQrajq369qff79sZmmNJm71cmcr9G/W1PZpw/CpXQ3Jch6wXxCnTtGuPMsBq1/G52Z/B8r/vPblSpKmMWbHgxlseZaBJ7VUSMaiTf5XWF7bdrNbcpIJfk5otO35ulrpe+xDGqfo1UDxtMEHWlK9hQGHsE7OtU8ZZB0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea56a364-9c6c-4102-0078-08ddd35f13dc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 13:59:06.5824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vxbYxRL4hy2ENXehwaSfHgBPwoZT0ejXh3wSKToiS6Sa/DIn7U7UsknxyoiT8gjTcfaOUyWqq6eGWAJ3a9RSVAS9vmBHoPhJe0cZiDXL2j4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5005
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_06,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2508040077
X-Proofpoint-ORIG-GUID: w4jJ4puqjDIpQiHKa-kCjC3smbhJqxv1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA3NyBTYWx0ZWRfX+rGj0gq6JbLw
 Uqi5pZC3n1y2eNnyJRZDSX87yCBgG77ygZwufoR60hWE/wzFaCRqvTtWE99cHSndR7StPdTdjqP
 sJQLxTzAYbwYpuvaJjMBxr/YXpsuWsH1Ot8scIfzs8fG2qnd8enjZi2kXLf1K93Yu7W5bemh39W
 TFWwzqRAQ34ZhNQnGiNx9DM1QmtjbPhTdR2lrW7+QHt6GIW2B60BAxCZQezcWlTmMR5P0gKaqNW
 RuBeHgxW+4Na1shb5n4RmAnYcLC4Em0Txc/zse9YKv8gvPN5Ol6x/Pnu5AHVpi0CSJj8Mc8EE23
 p9xm7FKGVFOjTuHtgY+1ekpjyLvQlDLJu1R7YQAXF6S0/e/Xyv9tYPx2G4AWUwVZDyGaSazm96t
 Ih+cv2yFVUbXIAKFjmPChZV9f19eKYXeIcYG2j2G7ZXes1+7mynbapZMo2Pi0Yjz97YjyXoc
X-Proofpoint-GUID: w4jJ4puqjDIpQiHKa-kCjC3smbhJqxv1
X-Authority-Analysis: v=2.4 cv=daaA3WXe c=1 sm=1 tr=0 ts=6890bcae b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=KZiDZ-_m4866cb_-RHsA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12065

OK,

So I hacked -fopt-info-inline-all into the mm/ Makefile in a rather quick and
dirty way and it seems some stuff gets inlined locally, but we're mostly hitting
the '--param max-inline-insns-single limit reached' limit here.

Which maybe is just a point where the compiler possibly arbitrarily gives up?

Vlasta rightly pointed out off-list that given this appears to only be used in
one place you'd expect inlining as register spill isn't such a concern (we'll
spill saving the stack before function invocation anyway).

So there might actually be some validity here?

This is gcc 15.1.1 running on an x86-64 platform by the way.

mm/memory.c:1871:10: optimized:  Inlined zap_p4d_range/6380 into unmap_page_range/6381 which now has time 1458.996712 and size 65, net change of -11.
mm/memory.c:1850:10: optimized:  Inlined zap_pud_range.isra/8017 into zap_p4d_range/6380 which now has time 10725.428482 and size 29, net change of -12.
mm/memory.c:1829:10: missed:   not inlinable: zap_pud_range.isra/8017 -> zap_pmd_range.isra/8018, --param max-inline-insns-single limit reached
mm/memory.c:1800:10: missed:   not inlinable: zap_pmd_range.isra/8018 -> zap_pte_range/6377, --param max-inline-insns-auto limit reached
mm/memory.c:1708:8: optimized:  Inlined do_zap_pte_range.constprop/7983 into zap_pte_range/6377 which now has time 4244.320854 and size 148, net change of -15.
mm/memory.c:1664:9: missed:   not inlinable: do_zap_pte_range.constprop/7983 -> zap_present_ptes.constprop/7985, --param max-inline-insns-single limit reached

Cheers, Lorenzo

