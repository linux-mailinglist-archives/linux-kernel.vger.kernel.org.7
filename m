Return-Path: <linux-kernel+bounces-894714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDB5C4BABB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95AA73AFE9C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 06:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6AB2D5924;
	Tue, 11 Nov 2025 06:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e6vunGxQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rUu0IsjL"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8892A2D3EC7
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 06:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762842309; cv=fail; b=L8YiwRFdUM2J+uOOUrJBMZaKeI30GmQAa7m0bFNYR/IPt1yZS/nG5ZuXTZOosk2HydYU9nAEn9O0j6k8rFclG/yg64l4z3ertcJJxcz0wzHAY00Sfo4OUm5cBLCjwdMAmA//XtFMyW1hun+89nwFv1Qet7XoL6wNcrPSWI6J/So=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762842309; c=relaxed/simple;
	bh=TwbI1gLlLXrOID6SG4K4GaOy1NH1imxHgXRLjyENG6I=;
	h=References:From:To:Cc:Subject:In-reply-to:Message-ID:Date:
	 Content-Type:MIME-Version; b=BJSDFHpNgaLWqunIu0tErr8RNAQbc9la2r8+tMPQBJMvMHuff1iKi4loGgemH98JVE4nkeA/bncwto/Y7BOVCIQ8O8TjQWAHbkLtWeTLlNRqIi5iu56M4IbakZMD994IsjycbrlUbbdvh7kj5Scw59pZxWgq1kP8JcJ4ccEjvTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e6vunGxQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rUu0IsjL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB5lFsh010800;
	Tue, 11 Nov 2025 06:24:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=gI07SyTlelHd+SFYth
	r0aUVFlkGT38SHbRn63dMDh70=; b=e6vunGxQ6nJBACj0+tDP7rHPOhbK/QvCLR
	6l6Y6u5vdUH7yvcqCBJ7bD0YANZZyLt+Wx0bU7fMrvN8K5/tnHKSD2sC4rgPQZJQ
	odfFhSIPj8Dq6JzXO9SCuj3GTE1KH2GNBnELbT/V+sKuGBQB1PO9UQrdaWS1xfr1
	e08Lom54MX18FIvwN1jfBqMYDxUrpx8E1Dca44j1y27KpszEdZdSg9ccfLkTwNzd
	NIY0tDRZB9FVsxf9qcr0ulaAYL9j/oxmHlsZoQngAwn7yAcv3kUpDf4IGHDfVPvk
	O97jS7fX7L4B9DnbFGRudXzMffE26FqkE0apGiI4vsE9oRVXe4HQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abwn7r5x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 06:24:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB5RBHp007658;
	Tue, 11 Nov 2025 06:24:29 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010042.outbound.protection.outlook.com [52.101.85.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va9mqcw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 06:24:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+lIzbm4hQwhq6ND3kkmwSry0GSmT/lf9MYtoQ4CTeiOgXJ475AFm0FaQzpxZPgxg3nN+DgFHG+5MeUjDQbHG8/yR21Ap207JFAvxAhloGroKsVrhi4tsptnHTO9RghU0fDa2NJf65kch3LudzhIRhCXIgmJY96jyxfBkiTbbLhs1i+KhOa8ioZ+HM2OnIv8bG3LDKcTXAs5ID27Z+Ft/sybuvc0FOiIVlOEnbyQ+NTjYbrMch/ef+TrGGMFyAXzlRc5HngI/011Z0v86c7COArEOMTWxBzGIHAo6qyLnx8gmrL6rWf2TGbhw9Qpw54g0FLnAgao2w7eiO3dcrN3gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gI07SyTlelHd+SFYthr0aUVFlkGT38SHbRn63dMDh70=;
 b=pzHa5B/dY+gpF7AA45g5jiXP7BoYZORRkxo5Vrf5xVy1MtPVp0Ql1P3GwrhJOUoJgQijpJW8nbfjPxIaTXh1CRCKW/5O2gIbeNRPMTCwVH2MU9WsCkKqODKQLtHpSW+In+ZYJQGpCZqng46BVO7+4pewPR+y3R8cXQXufmlzFNeOsA8JnIpj43mFBMWbebk4NYDkPLXG6TMTqAwtY0V6Ei1Fo2rwt27WPnAna9Fvi0O79n5kOwLr5Y39nYeWREUR87pnbW0RJutIFaDGeYMlfL2XzcntydhPXt7jLIgvnG5Iabsze+PvHW8RSN+mTaAQcFOUpDnAERxHkE2PrMl16g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gI07SyTlelHd+SFYthr0aUVFlkGT38SHbRn63dMDh70=;
 b=rUu0IsjLlSBCWRUH0Jq+KKcZ0koWjT7R/LBK9AG5U81ZeQ4pJJCMnKauQJBVLq9N3fhzKmuqLBgYxbuoJZbiZ9FAG0yaZlZEiAd6Z2fzll/oInpueifBsx3164xGOymI2J3spxHFuAMRkbbKJfMklZS0YAOPkQm6+ROUTWFr9iY=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 06:24:27 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9298.010; Tue, 11 Nov 2025
 06:24:26 +0000
References: <20251027202109.678022-1-ankur.a.arora@oracle.com>
 <20251027202109.678022-7-ankur.a.arora@oracle.com>
 <77b2ae9c-2700-4c7a-ae45-323af6beaff3@kernel.org>
 <87346o582b.fsf@oracle.com>
 <93b2f5eb-362c-49b7-9d90-01d250c9b6ff@kernel.org>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
        peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
        tglx@linutronix.de, willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v8 6/7] mm, folio_zero_user: support clearing page ranges
In-reply-to: <93b2f5eb-362c-49b7-9d90-01d250c9b6ff@kernel.org>
Message-ID: <875xbhaxye.fsf@oracle.com>
Date: Mon, 10 Nov 2025 22:24:25 -0800
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0224.namprd03.prod.outlook.com
 (2603:10b6:303:b9::19) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA2PR10MB4684:EE_
X-MS-Office365-Filtering-Correlation-Id: efbea6f0-c0c5-4ec2-735c-08de20eaf66e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W3g4onIX3atasSy8TIywJoZO4ywtpHJ/XMYZjsYjK/eoME7IhlAYucCpG2/F?=
 =?us-ascii?Q?pz7ttQ5czeDqeQlCVLaw+6IX46u8M0teE4J2m+Sd9FNhilQXr4CKiT+Gyihe?=
 =?us-ascii?Q?SF/elgrs6GbATFxQL5uNyaBGwtMBmpwwz0Q93EbTIT+6viKcQZgEVgZVlpi9?=
 =?us-ascii?Q?3xY28q8Zepyz+1bzTee628UNJEhf7z11Lle48AWqSmRJJJmcB0ESrsTlXng8?=
 =?us-ascii?Q?dz/UipGz0JxGcnpgkYC0wjrlwI1Zv32KOXCJtJ5bOJXNGlyO7OSbVFoWmCMJ?=
 =?us-ascii?Q?FLRSuuiy0lDwTqfYZx7k5OuOurKdHadSOZskffMRyc6lAO5vdISs+FNx6fWs?=
 =?us-ascii?Q?foF7ZX0oypbXo9PaId/Jr0aqC7HABX5a3tnPCfFs4+8Zm2ngwMki50xqx2CY?=
 =?us-ascii?Q?XNoK5qN9hmMBqb22bDHCdZYe1raJudOcl+oes/zOGs2wBDp930GT1p3qr2bR?=
 =?us-ascii?Q?MHM36JcXSyC0oexekyNJExRPyr/PTqXUY8a1n0pToiXrMugR8c0bWJS8Ryxx?=
 =?us-ascii?Q?ytmvulo1KPpAqmtx1ssTIWQ7KsenxJWivBQxQBn3xMaJimG47Yc0E7e7inrf?=
 =?us-ascii?Q?PBoudDbZDwvr4KYzizDikv2cS8cjFjBJgrc75/0FL+781P6571ECpQcPdS8z?=
 =?us-ascii?Q?pbBgqWnWREz92kKrA9anlmamNNP3B0wismmkZwYnleR8D4idv0TjIfVyx0Gs?=
 =?us-ascii?Q?CHDLdc8GlW8l4ZKQaU6k50Je0WgR+sUcQnhy6tl1mFnIEQH2IUf8fb/OjiTo?=
 =?us-ascii?Q?C0NNTea96V3JjFWkjHGc/lRvc3zU/J+h9jatKXC+6wWOXAyCiKOMT4kuCkrJ?=
 =?us-ascii?Q?HVIBoDQEgVqR9owQfW774fmj5mWFD2IcvZtHQjxFF/kNYXkkGM4OOKXTkKnB?=
 =?us-ascii?Q?XEdexoEXMdTa7eYI+dKUTCy4RFkuGV260atmJRkRFbIXTGgEUcyBt5xwtksj?=
 =?us-ascii?Q?o6fB/Fz/Pf8xnkIxamU3jBkX3FNTn3HUBj+/CAia8kp7xFF/5kx0pZ1bUynq?=
 =?us-ascii?Q?eK2prGYrWDvY5+yELZQsxp+u3jv6RHUf6BewNmWAuhh5oftw0Faph1zfOrJT?=
 =?us-ascii?Q?kqAbv42b4I2hCfsKON2ajQR3FZvPY61aj6//Ntj2qSKJXE+10OAAfZhy8QWU?=
 =?us-ascii?Q?sp+bEbdP/pB1Iq0VNMDLKqtuYNHEwPiEyfGtI5EGX3cnIEduHNVS8Bi8am1k?=
 =?us-ascii?Q?BJWiBsAaiczT72vihLF0XOnGFcdKmMOz09l3hXBcslEOXFCzJCim/w43xb/p?=
 =?us-ascii?Q?NuZBEjgsaGC2PpzHPSa3hStwyMvO+/+ANlS6pdnsukqPMSjx5PDOYYSe/7jj?=
 =?us-ascii?Q?q7JDIg+PIadi9KuqpUWGS1/MlJ6g0iTfgua3lXrDZnTZMranIk5rSG9kqypv?=
 =?us-ascii?Q?3ssxsIK0dd6I+n+02343/3+QkI8UAD5z+9s938tAw2hyq3xeyNvut41z7oHX?=
 =?us-ascii?Q?0V4XSGSQSn2mLmLA+ggb0I1tPEEl3nO2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?krsWl7a7M+Gpo2sGjfBPTR3ineQmFrdPpmOY1R1dK4HCy3bj4E8T7wlwpKmy?=
 =?us-ascii?Q?6zDFGuucRlA/UvcWxU27AA3AijWdzbdaJOGDfVHUg54uXn+4xo8tEhlzbNtm?=
 =?us-ascii?Q?S1QKviWtHSh2ghPjPsE3Dk1JefOB63vuErJtZQNqfswFwUhq4IYjk3HYGX3R?=
 =?us-ascii?Q?shx0lFn3/rSTofi45kzO237o61/P1XecIaBknCTbu/kgsP3a/0fT0t9fuh+0?=
 =?us-ascii?Q?TRsko1B0CTWTT3iCA+RtHCl+ZPIdtSC2B/aiTkx1SvXGObISuOTIbw6LKKYv?=
 =?us-ascii?Q?l4ZR8XfbRDVdyu7n3mLbbd7RYPDmBds0E5z/FRad/sl+lJHRscuOSOv3r0EJ?=
 =?us-ascii?Q?ItDpJUWIa9+h8YC4cyu9n8hB1pLCHAmVmd23cdfFncVfib/O46kL3z4pMMGp?=
 =?us-ascii?Q?wpCTy2iJzRzx9CjMjBAgy061SSL0FkLit5CzMRrC5BCFlGLhsINT8kDpiJ1c?=
 =?us-ascii?Q?TK4A+wGvTjRV4v9nXOIm3Z9DqS57YL0TsoJV+RCeMMbCKaE7YyIC/Nhp0HwH?=
 =?us-ascii?Q?xn5Ab3R0blDNlcOQCz+o/86OjAQCUWOfK/+QppPe21E7+42Htpi/m0sz61ag?=
 =?us-ascii?Q?0GdLLazU3vtAXQ4VrPFQdty2JfGC8WgjQDmn5LgS3OU7WDKhALNa+UMbKrJV?=
 =?us-ascii?Q?RuSHK4FNv14nS2mWtvWQGkhwSZ9LvdvKL8BLC89VgKsnIM+syQk7Gr8XT4Yx?=
 =?us-ascii?Q?hURhcfB8eL5ZNAY+wlvK7bXjALsqmLwjNdKOtkEQntjhRf2EvTQu8IG2sdwv?=
 =?us-ascii?Q?PpCVgETCYhUltSFXM19rXYxdfmC0nrvAFaDHHvyYosP0br3zpDE3X4UtVGf0?=
 =?us-ascii?Q?SA0W/aEdX8qQ/WDhm9l8SxSi0aDLilWA/q4TrvodyTo1rVO+S6IRUW3Hg87f?=
 =?us-ascii?Q?OyO82HUpMr53LAlpq+W7J7qfhTdh09JTOTwJ94s6lVisyX68xVqeVpi3v+2i?=
 =?us-ascii?Q?O1pPAjSjckyER4fcPhcfH6gWDlWKMCYARE/EHJATgp3UcnGne9JfjshQYq5N?=
 =?us-ascii?Q?JQValsUVUrunPkEkMqZu0cSR5/0VUcAGa7CO3mQExnB9HaZDmmysOnMBBd8l?=
 =?us-ascii?Q?1wlIsYsXDudDN7ityM8untizHIfXBmuz40SFDSbKxlOW82FEIfAilFXfFrLZ?=
 =?us-ascii?Q?ZhLWx1IuT9nCt3l5qfZQIBAIXC0Vtkjx7//isvBnjmzB8B30AE24OCgSfaQi?=
 =?us-ascii?Q?ILQqiZdcKPRaYNIMfOCKkeWz/EMZWnFWaAJ3T4fJwtb2UHm5elfMer4OzsPU?=
 =?us-ascii?Q?B4mDK3qEwU+lVYdSd05TCe+c6H9XCpEf1T3gp3tFmDZ6K5/EJUNn5ZqxH0Jw?=
 =?us-ascii?Q?e3mpJc7eiFlJxvn9INpu0uIpNol8XH0bWtFoPJfQUPgS1rfLtj8zjE/l0OSS?=
 =?us-ascii?Q?vBoiudimaFdI80wMGcHQJjFM5UpBm/cyCdNZoMTFyl9h6Fr98Ktl9pPP6K94?=
 =?us-ascii?Q?Yo5ghzRevmBXrbDTh6joug4fbmXaDgDrz15SswdkU0vRjDaYTuA9mmUfrFAI?=
 =?us-ascii?Q?pcyz2mhmYE7hWq9Bgk/mJ1NKWRbLxkNW34ZqO28h8hb2zadJ1B+lcHkJcGDo?=
 =?us-ascii?Q?TW4rfPDuc7VUvKbA0/3o49U4ByfZRprAShR0zFmW0doI2zpAQV30PAY1yBH5?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ela4Z4aH/9S7/x9pN5ox+c/2GvH+/52l6dc65n0igwCBrC2WL/P0pJa4lnV/hqU83FgCtViYespn1Dr2x1ZxtjOMIgq5QRA38lo3HwNY/Wj2RkSLuN4Zbh6X607LqLrTecY78Z0UfmYHaESFE2G5p61+ghmPYm1NgV4JN4mAGyuBS0DuZKg501BJtiEZEmDQXRJ0ptd6bMMaAWwOVinLkZsRmbbnV4h0DRCzXJewPqesE2tRiwA/vLJoCSjEuGLsFB/c2ijndUhZWEkhBDizdNMZE7USHeJR7C0YP3dFg35JnBxbmdIGJEhtyCm/NKFQBkbNjcUTji3wSaZfF9opZsl+V3Xmq9EUjGNiFctCYGuFFbXlY37i2Z1sCS9jdXuXY34uESZ45+1uAeMY1gbrp7IdTN7R0ZkGwDuhWhl9BHuPBvHr0bFES6+cun4VkEDeN9JI22MKRb0z06RK0QC10MGPT0yKhGS2CEtqJYYpqTYlatW1gBB1U3XRORhJsh0Chg+Rz3kZl+7gTxt8b1L9F6Lbgl//qj4YybFW6ozAfI1vXJ2hw9Z795Y50ypYxiR2QATroXU5lMZY98mxR9+Szu5dth+TlkcZJp94y5mUD8A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efbea6f0-c0c5-4ec2-735c-08de20eaf66e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 06:24:26.8570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JDP6iV5F3wRV4N8JN0aNaUQXsU8WZGrmnBlG1rLetSuJl3DdCS1pM/fY4n2f/hK/swq7DC+FAD3P9iqWf5l59Bx1xjbM4H7ESV2fRraMXoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4684
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511110048
X-Proofpoint-ORIG-GUID: DDUPNELMldY8UllgLftXOwvz7hzPFhug
X-Proofpoint-GUID: DDUPNELMldY8UllgLftXOwvz7hzPFhug
X-Authority-Analysis: v=2.4 cv=YIGSCBGx c=1 sm=1 tr=0 ts=6912d69e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=zd2uoN0lAAAA:8 a=1TUf33fbrbP_5_3H7UcA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDAyNiBTYWx0ZWRfX/2i9K3PpAsIz
 iXuO/XHc/bUlwq8J9qkzGHAauhJSocLcEh6EKwY2hIlo572pjWA7l27QPpztC4bIfdHUSvzy/Aq
 tCWnnWkYQ6DHRW40M8eWiXK0mWEoCXn8FdPqZmMfEgk+iv8JeA0BAIXVYx85onVZw4uoBAcJWbe
 Ma1BCrJ3mDq5V1ufYyGtyphLR7EUoxzApi5/t4zAdYG6HdTmgvexPqMABo/OiX6f6cOqX/1zgTH
 IpuSnepEwqtoP3kTUHo7TAiOnjgUQ1Y6WXJP557Gdcdg00wumvomeo8gVUOuo4iYlU2+5SnNN9+
 UZxL8Ap9rR5sxRdCVteDhW+LakIMElkEBEvdaR0COZIvz5T45Ye9J0WFOEnBD0d11nDCTdorMLK
 bVaet3lgLTAPdAHQIKflqWVzox/7zA==


David Hildenbrand (Red Hat) <david@kernel.org> writes:

> On 10.11.25 08:20, Ankur Arora wrote:
>> David Hildenbrand (Red Hat) <david@kernel.org> writes:
>>
>>> On 27.10.25 21:21, Ankur Arora wrote:
>>>> Clear contiguous page ranges in folio_zero_user() instead of clearing
>>>> a page-at-a-time. This enables CPU specific optimizations based on
>>>> the length of the region.
>>>> Operating on arbitrarily large regions can lead to high preemption
>>>> latency under cooperative preemption models. So, limit the worst
>>>> case preemption latency via architecture specified PAGE_CONTIG_NR
>>>> units.
>>>> The resultant performance depends on the kinds of optimizations
>>>> available to the CPU for the region being cleared. Two classes of
>>>> of optimizations:
>>>>     - clearing iteration costs can be amortized over a range larger
>>>>       than a single page.
>>>>     - cacheline allocation elision (seen on AMD Zen models).
>>>> Testing a demand fault workload shows an improved baseline from the
>>>> first optimization and a larger improvement when the region being
>>>> cleared is large enough for the second optimization.
>>>> AMD Milan (EPYC 7J13, boost=0, region=64GB on the local NUMA node):
>>>>    $ perf bench mem map -p $pg-sz -f demand -s 64GB -l 5
>>>>                       page-at-a-time     contiguous clearing      change
>>>>                     (GB/s  +- %stdev)     (GB/s  +- %stdev)
>>>>      pg-sz=2MB       12.92  +- 2.55%        17.03  +-  0.70%       + 31.8%
>>>> preempt=*
>>>>      pg-sz=1GB       17.14  +- 2.27%        18.04  +-  1.05% [#]   +  5.2%
>>>> preempt=none|voluntary
>>>>      pg-sz=1GB       17.26  +- 1.24%        42.17  +-  4.21%       +144.3%	preempt=full|lazy
>>>> [#] AMD Milan uses a threshold of LLC-size (~32MB) for eliding cacheline
>>>> allocation, which is larger than ARCH_PAGE_CONTIG_NR, so
>>>> preempt=none|voluntary see no improvement on the pg-sz=1GB.
>>>> Also as mentioned earlier, the baseline improvement is not specific to
>>>> AMD Zen platforms. Intel Icelakex (pg-sz=2MB|1GB) sees a similar
>>>> improvement as the Milan pg-sz=2MB workload above (~30%).
>>>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>>>> Reviewed-by: Raghavendra K T <raghavendra.kt@amd.com>
>>>> Tested-by: Raghavendra K T <raghavendra.kt@amd.com>
>>>> ---
>>>>    include/linux/mm.h |  6 ++++++
>>>>    mm/memory.c        | 42 +++++++++++++++++++++---------------------
>>>>    2 files changed, 27 insertions(+), 21 deletions(-)
>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>> index ecbcb76df9de..02db84667f97 100644
>>>> --- a/include/linux/mm.h
>>>> +++ b/include/linux/mm.h
>>>> @@ -3872,6 +3872,12 @@ static inline void clear_page_guard(struct zone *zone, struct page *page,
>>>>    				unsigned int order) {}
>>>>    #endif	/* CONFIG_DEBUG_PAGEALLOC */
>>>>    +#ifndef ARCH_PAGE_CONTIG_NR
>>>> +#define PAGE_CONTIG_NR	1
>>>> +#else
>>>> +#define PAGE_CONTIG_NR	ARCH_PAGE_CONTIG_NR
>>>> +#endif
>>>
>>> The name is a bit misleading. We need something that tells us that this is for
>>> patch-processing (clearing? maybe alter copying?) contig pages. Likely spelling
>>> out that this is for the non-preemptible case only.
>>>
>>> I assume we can drop the "CONTIG", just like clear_pages() doesn't contain it
>>> etc.
>>>
>>> CLEAR_PAGES_NON_PREEMPT_BATCH
>>>
>>> PROCESS_PAGES_NON_PREEMPT_BATCH
>> I think this version is clearer. And would be viable for copying as well.
>>
>>> Can you remind me again why this is arch specific, and why the default is 1
>>> instead of, say 2,4,8 ... ?
>> So, the only use for this value is to decide a reasonable frequency
>> for calling cond_resched() when operating on hugepages.
>> And the idea was the arch was best placed to have a reasonably safe
>> value based on the expected spread of bandwidths it might see across
>> uarchs. And the default choice of 1 was to keep it close to what we
>> have now.
>> Thinking about it now though, maybe it is better to instead do this
>> in common code. We could have two sets of defines,
>> PROCESS_PAGES_NON_PREEMPT_BATCH_{LARGE,SMALL}, the first for archs
>> that define __HAVE_ARCH_CLEAR_PAGES and the second, without.
>
> Right, avoiding this dependency on arch code would be nice.
>
> Also, it feels like something we can later optimize for archs without
> __HAVE_ARCH_CLEAR_PAGES in common code.

That makes sense. Will keep the default where it is (1) and just get
rid of the arch dependency.

--
ankur

