Return-Path: <linux-kernel+bounces-730465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2D7B044EB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F3417DB6E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36457258CED;
	Mon, 14 Jul 2025 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I40DXnfB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QlZMNlFe"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB69714D29B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752508911; cv=fail; b=A49QWiJC3eNPQDNihvFif/BqkvjOq2Jl2wZwgY+OGcmVWjwd0b7XAEeSqhNGJw2HeQqhZcOSvcjdVbDzZCW5KzxCcTVxyHtBoi0qlqWSnKd/HYo+W8KVRDERQKRwHWxjmIYrfg9NXpqBP4kLEqKNgyNQCjppar4DL4kGaANup+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752508911; c=relaxed/simple;
	bh=2Y6FDf5oODP1rkCrGTDxop6wlct3lkd1ozUzedz66mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PSmbOQ5tL9d7azFdBNTlQhdkAzCbEILrfDimLglBWheksDUSV7UN0lc7M5uuwfDBGutsT+DjbImm7gAjdl/xx2PfJ9niBamUi/YFoBb2uAjQIdKziTU1DZLyRNLtPrtNASM5g5WfWa/X7CNkYWEgVY1LxIlUw8ZzY+97uGCGZV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I40DXnfB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QlZMNlFe; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z5CO019040;
	Mon, 14 Jul 2025 16:01:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=2Y6FDf5oODP1rkCrGT
	Dxop6wlct3lkd1ozUzedz66mM=; b=I40DXnfBhcATc4f2oF1G9HSqseWz/a2Oeg
	YLBLQlQxYbInorqCKBLel+aQbVRVfIyOU7pLLsgZIgmdRwKXA7rsttGFoFk3sFsB
	PzjvpgD6nIaFmoCujgeRbVUhmHKLf6mk6s77nzR3tqfxsYgT3SRxo3JSPSqbWjph
	4bOMzuzD2+a/Htrcj4zr2TN3CSQ+dOu3NttypsT4iytpPc5EBcIsXBk6Ee40B1mg
	l4Pns92LOoizuJvqLpGVbhMvuoPsGqidRVxqTtTdK/plJhbtwpBIlM8ItPQOTdVS
	RDghNX1oA1GejRG396MGBEspLCJnOOshEW6MKl6tfYWFwDIU3klw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk1avhrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 16:01:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56EEdgba011670;
	Mon, 14 Jul 2025 16:01:34 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue58pdus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 16:01:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohlYxTtUtRjchJ6ONjPOlXjKmH1bTnwxQG9i3drX6wxDbaSiMJWKGc132tia82EmS9fBuWRouyhfDacQsWbBjxXOtRoWgjWaiJ/mMzlHfePI3AYME44kZZcA+vV0OOEZLQ5oQ8TzYf4lzKBAjs7k0bT9wTeU1ueELpgf9DeMql6fsfn+YielSFVm9ZZ/xXqw6qfLdZA8IgfzHnK6DPc5pDQ+FjdJM9fOfafKME4rZptDSLI67nHf15WA1GPRoxy0+YoV3uCqX4qbqxuwlJ6x45u7ESkOqxY9E4irFjTbb9r3N//MNegHmEB4kK0CKlBAdaJXFlmW6xS1ed6tzpNxlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Y6FDf5oODP1rkCrGTDxop6wlct3lkd1ozUzedz66mM=;
 b=VgXDfugUMak4kR2K3Rh5IwCYVAAL45O4QZVd77f9CxHjSxUukXIpGkgqItsOZdPMyUBJEE4VjdOtHiCCvkeK9oDJCggcMZJZpFXi2qAG9F4oIdn5eUzTRbq1lJgoB7wHNq5wuOvlx359buVgyVolsIkNuZSPptbsF6djSSm7Psc4d0L1L1NZJ3UC5wSNvdxpCRS5vzzuI3wRqh5irHXU/95NrJdO1MSXgjmMXCzRXZdrL3pBFlIro3NcV0dC8jc7zF/zoA3LPqta1rsQijuWpxBDHKOv/GqLjcfr1B/2XtkNrDSIQoOZDREmdLWYLYABWp+5WyvcPMqp7KfhC0EEvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Y6FDf5oODP1rkCrGTDxop6wlct3lkd1ozUzedz66mM=;
 b=QlZMNlFez65PbPKCOVvVM5Z4ALu2PXLWpEKeli4h3/klkckWVUJIW8T6Qov459HczpqcSTiIE1ZPe9kj+8sdO9UOZGK4XOc/l0gZMpKZFQlHdCFfqkq0JcuJZca4p0ZEdCbVUPxn7lzSE0u+ndIJXecZkmofNz1hnK2ntwSQoVc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB7152.namprd10.prod.outlook.com (2603:10b6:8:f1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.35; Mon, 14 Jul 2025 16:01:31 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Mon, 14 Jul 2025
 16:01:31 +0000
Date: Mon, 14 Jul 2025 17:01:26 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Pedro Falcato <pfalcato@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH 2/5] mm/mseal: move madvise() logic to mm/madvise.c
Message-ID: <3768ad47-0096-4e4d-81ce-74c401dd5fe8@lucifer.local>
References: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
 <5d932ec1f9d0ea115aac65067e4cb8241a06e791.1752497324.git.lorenzo.stoakes@oracle.com>
 <5e21df9f-7f75-412b-a173-fe6da49952e5@redhat.com>
 <b9bb8416-24a0-4bd2-97c1-055460cece23@lucifer.local>
 <0925c64b-c721-4dc5-913a-c43a94dc64a3@redhat.com>
 <nnm4cmygbeyzwxfwqduo5lq3d5cthuic5irof2l3tb5x43n2hz@mmjklktcfk2o>
 <184d7f4b-6ffd-4047-b245-aec32ebda9d6@redhat.com>
 <d7959e95-c248-43f8-911f-628db9313a61@lucifer.local>
 <60b0b01b-d397-4e47-8e85-295241ea3230@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60b0b01b-d397-4e47-8e85-295241ea3230@redhat.com>
X-ClientProxiedBy: LO4P123CA0037.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d528752-2e27-41b8-2e16-08ddc2efb315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K8ezn0KM3/U4L4lcFVFIqG5TgIdGiPaT67GNSxnXUwEIbwfhJ3+ArbvfFYzB?=
 =?us-ascii?Q?3yihRV+T/QlYVumR5242TVJh9Dueovfx4yHPtCIAkKzOaHWNL35ODitJ1asU?=
 =?us-ascii?Q?gHId0x4S9QDnCvCMldHWDsQnLqcQvFo5xFyKASK2fPRivZLP3fIErpUeT3H7?=
 =?us-ascii?Q?NoT5Gq0oBbcLE62na1gq4SmAsBAp6L8iK9Rg0Wh1JmsIAweJm0HlRImpRSWp?=
 =?us-ascii?Q?ioXzGfGO3K0WBYCq5B+CWgNf7Th4/F/fKvvjouIHlFC6DceiboRJ65awhL2Y?=
 =?us-ascii?Q?WKMLuoFKTUhNZRJRXlnhSZY8O0Nan3X40be6ljuRCGeaSS0UQKfHEJsFz/O0?=
 =?us-ascii?Q?2GCdQA5gW3gHjvj3fJyg0XyFu7U1EsMudIXvCb0oOIrX5HMfeoOHYpRjPC9t?=
 =?us-ascii?Q?uzxjYjUBA5P7vMLW2tWhxXAPQhoHpUiX/2yx5DH+vWmjgrWN9tdF4qibufs0?=
 =?us-ascii?Q?PJ7ttbmOuMLTp2wWx0Kj5PiW2wG37phoR9H4H+BKWYQ7e0dkfSq9phHS4ENN?=
 =?us-ascii?Q?atCGO4yopz+G0LpvlZnnBaLDfE27IjZRSkZa1V6y2rxRELaU3fUoFf1JctyR?=
 =?us-ascii?Q?QKnyFiaQJAX29xDgZjRcQ06FbHdywz+JbXSQRHASTiHjBht8pU5Qp2YX5kAC?=
 =?us-ascii?Q?xlttlk46Cik2K4vaQIjgcqLUW+mMLmCRZ1hi5ruk37NerLD4Kcb0XcXXjV9v?=
 =?us-ascii?Q?OgEeaPlWX6NIBlxBzI0X3m6/Ddi414pjZ3Nt4wMy6swyjQhW+y+InN3jgvyL?=
 =?us-ascii?Q?NAb1PZw3a9woy3brKedB94BHm2ggC4EuDz7ErbfnLjjUnoil1rwr0HMpOu1H?=
 =?us-ascii?Q?sM9yCHSxIjN7QUDu3zbkExgNoJjZeYQdmp40s/WaEndoAKE80J3c80Apokjk?=
 =?us-ascii?Q?1zJ+xFW5SqlF1Y+uMOCGuLkuiYUks1m+kVLWay3j1jeGYbWzUssvAHj3OvZR?=
 =?us-ascii?Q?QHA8LWfYIEKIAKMrXtZTPgqjIYHTnWK4bDDoe4iYBHjsROpk+1Q+gUtuSs66?=
 =?us-ascii?Q?vBlb3aYowiimV+8s/KbxD9njwnG1ShEpjnBxhMMWCZXYWa/NpDsEIIG9xW4M?=
 =?us-ascii?Q?b0f8TyikxJyy0P5SR9rxAdgi1jwgiC3Y9gD+7QizAJ+5uRFNJlWE4V71ZmHQ?=
 =?us-ascii?Q?Vjhk/qvsxQArZJ+4C9KnWEtyVJtSYK7LDndcvTu/XPAxVfhnT88wO0VHPXlw?=
 =?us-ascii?Q?gBPqPKGKm4ythxlf7KGfyesnPrzdgefxSKdIwyeSC4SrNQ4+Nhz/tITQEs9M?=
 =?us-ascii?Q?c1C5CrDPd/KPHc4xsXCSZ9aDtrFUd6SKiRqxiCB3lGR+ZKATg2QwnDn2Xe9K?=
 =?us-ascii?Q?5etE/N+NXpZXV/c1WklMyBSZ6bItcGJOHYbUBR5QD0bIu5G/a/vGBmUh3lfy?=
 =?us-ascii?Q?H01biJKTuoOvb2DhwocHMJudPSAoQbXQNACzcnYO9Jw75Wrq8A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zp+kww+htC2P+S3ExX/g/3efE/KECB5Aex1/EFwxy1LnNmxEXcHxU4vOJo4x?=
 =?us-ascii?Q?Q05e1nKIXGIFavLHyYBDdxiYONXmHSaQ4llfCfNSFd+xaeYEsCPHYa+9o8/j?=
 =?us-ascii?Q?g/Wihyuc2yalQIXTZZO73hleaNc6gGpIhhqCCLxjotbkxHZSDvhEuBYlBxaj?=
 =?us-ascii?Q?it5mwBGMMoyYWIzxlz0Q6WJjqEiPyTFuGreoigyJQydKXIwWQFd3EB3XrBuk?=
 =?us-ascii?Q?TJ4Hqcnjk8co8mzKUrVKarVkcgQSnDPieSXU+uoAavV7Gjsxgswm+1Wz9jh5?=
 =?us-ascii?Q?9XpocmHtrU/tNPyHjDZZB4zL5NdJ8lU59nwX6P8hP6TDkWdtxLJXWVN7Fb8C?=
 =?us-ascii?Q?+T1w0gfvQuXMxIeM2hCaj2i2QQuya3BbS4bALJPHIz8xk28j+VOjDtUI+T0L?=
 =?us-ascii?Q?se+yiw/Dt0NQhV7LrdJ/k6YWNAKKod/LVbrRPnU5U3LxvkF/iqNc3OGaox3e?=
 =?us-ascii?Q?qtVe0+QZ7HZkqt2c1Azdt6I+t+Bx2O7mPF9H0dMp8GuPwSi9hoQUuLdle7ih?=
 =?us-ascii?Q?ydCuLtFxbgA9cUG0lZin0aE0osXjFwyp35Miy9l7li0RyQ14oJpI6+gOalNL?=
 =?us-ascii?Q?MEZSy93xb4nWvlPguYcrwYkEC37ZSvisPd1hkSxe1uBzyvNjdUZKP75TpxeQ?=
 =?us-ascii?Q?WPiGwwamaULx7ttw/Ntxfuz1j1kPNUuG+2iAeVexlivClzJR6iAmguGlS+yV?=
 =?us-ascii?Q?98EPa8tQEHnE8uO3ySPezZz5Ce99QPL1oPe1j+1OzLNGfbRh3F4Kv9Yqpaia?=
 =?us-ascii?Q?LrmRM4B+CH06dfOM1abm6u4NbiLc/h7JUpIFLo8pps7rer7tfw4ePQiMWX5/?=
 =?us-ascii?Q?s2Yhjl+YURuIDsxGIsGLcTbZZ03PdXh9icl+3bI7P+DHhyjpvxBCavZozmMh?=
 =?us-ascii?Q?6Cln93tqWlMpH2/6+2vevb/leLfRGGCne7komE/cf18E7qRKYicapkqOq7mJ?=
 =?us-ascii?Q?GAGhGt5MqaoQ0D7eHm6HH/YKGsVWRk6TsO3z5yNx+egLsBqG0BSxj6HANSFQ?=
 =?us-ascii?Q?21Z7SZw0R6im5I+znPwsiUp6KmOktrjH4N+k3plLUG61fwuCQsVjXy/vwSwn?=
 =?us-ascii?Q?KJIQU3oEPEktbDKhOKa6zWW/lEDOZhAOhSvPsQAfdPyzSIaH6b+oe0Uu1Lzv?=
 =?us-ascii?Q?MOvw2uFNxftUnv/mI4NbiQZGsR7d/qP7sNHqEWCMaDPYUod4GvpaZRIvi/n0?=
 =?us-ascii?Q?XMT0840RSU7PCj8slKajkdsgB9wa4/9T/3YG+SpYWku7V3KUKLBYzQ1QR6XU?=
 =?us-ascii?Q?obySoNETgfJIfh1MVGxW7LSfh5DZ/a+J9hcbe1tw2TQmIz/TJ0c1cV2vIC7s?=
 =?us-ascii?Q?dpWs8LFz4oOlTsWp+l6S5aEwJT5sVXexdCJ+iBuHlwn2pQNcOHM8/o5iMgUg?=
 =?us-ascii?Q?ovkim5AyDQORVD64ZgzfL5hmJeTqF7VsbF/xzm/xNoetW8GNs+KLSpxU+6ci?=
 =?us-ascii?Q?pprk9cLB1Rfnh9yTmxf4qbkNnLrP6dce6NnT6HXjWeGYiabRj360Edp7fDYj?=
 =?us-ascii?Q?Gqd/vRTTXtMyY9nqA13c+yxsGhiAKXNUsGqSL1B2WFJLMxqA1RRCHmvyZRJF?=
 =?us-ascii?Q?8bJBnLh9BCyM4jenVEwMgQCZRB70Su5ivKQiLtBeeK5AbauEZYRXGqsioz6V?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NgI8wWRHrPSjvbCTORTxeA4a3BzvJZaskgt/eNW0QnehDjrLP3kF3JbrFHKwvTN7+AzZaCnu+PmaJVG+N1jZ83cnIyKYC7/gc4grONyNgLbhirpO5e6Q4xY/g8Bn5pDpjUkb5hYR4B8cRkN5IWBnzFdCB8NQ3gsJTP0KJDJc0SlqpXDgjT4XwetwG3+yc/YOxI3FymBUGI0Ca5AV7vKcGc+/RrqUSLLTlc27yXMhNLa4kIBG2YX0N93M+Aq6EsrPCGKQ/klsVJJgwqFmaaVTmaE0lpRY/P89a0gfF5LazLMn+k4IBsPjO9eSm93Lvs4lxXFD71FniFeK9eV8GQXuicFNvRys5qAwUt51xEPTPi7zTF994jEp0UfGCxQlmiVoG8UeksJTAUSLyquh9USj1qgY3tSmFOSvwjbHjSyVR6TgsklAAtoJves+Enwi/8Rp60xwc0j9ZOIkdVfbpnEir9vihvfiZ5+BaKzlbTbZ5/QaaJj0O3qmLAmKi7jH5texYNDYRfKqWa/dRTDXuLzZoBzWvI53XVQNvs1HW0Gl+XLlbx57UttvUptGmQ/xjfNgfZQkFJC5CevgWJYe6gkiCMR1cBrw23Id5qcNZaZ7Jic=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d528752-2e27-41b8-2e16-08ddc2efb315
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 16:01:31.4646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJLxPfepg9KMrf/VefZhiLHODDytPFE3C7/SDkvwhagDoSV6kH9+bdfk4xJMkp85pz9tf8PB9A+Teg3oNJ52oVjuImOzsW2dhH43psxS7vY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140097
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA5NyBTYWx0ZWRfX55kkLzVPh5nJ J+4H8LDMhMLEoRuyMpcL7emY7AYR5I7uua+vL8/y0D46pzpKvhKo0Ho8myC5zyUBaA4Sj294bOq lCWEN6Z+70SF2w1HxedjRnWJEsOMDrlga9Wri1zCnsxijqHkfMCXAAsCmqtSLdlsj7X9pUciwRZ
 cDH4ZqM+Ll+pShaJ4ifqknrgedvGGEzeHlJIjYBIVDTZzpRLiT8lkIAhHGsknAG5K8bFtU2eWmb HzliME0RQbylrXtui5k+2x86qBOy1xoa0AYvSmYXjtACM1rpe0i28ErChacNhzM1ZVREKZQjEiq iJ6kzoPsFCuhZisj17JyqB9w53jvD4YT1JCWdBy1t7V6PWjK+A8SCRjdjZVEcMCIRYBZG7nJOV3
 RCIxpvSzwE8d4UtVmAEx+tPDr1dl6geq6fLL4gy7wKel2cFwY0PxteMOlFucn4sXKcRUo+iX
X-Proofpoint-GUID: 4pWWm2yhm_yFXutreYGvzRashuQAZISv
X-Proofpoint-ORIG-GUID: 4pWWm2yhm_yFXutreYGvzRashuQAZISv
X-Authority-Analysis: v=2.4 cv=J8mq7BnS c=1 sm=1 tr=0 ts=687529df b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=okDpSKLG64WqDUYWkkIA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12062

On Mon, Jul 14, 2025 at 05:52:56PM +0200, David Hildenbrand wrote:
> On 14.07.25 17:45, Lorenzo Stoakes wrote:
> > On Mon, Jul 14, 2025 at 05:41:45PM +0200, David Hildenbrand wrote:
> > > On 14.07.25 17:31, Pedro Falcato wrote:
> > > > On Mon, Jul 14, 2025 at 05:03:03PM +0200, David Hildenbrand wrote:
> > > > > [...]
> > > > >
> > > > > But now I wonder, why is it okay to discard anon pages in a MAP_PRIVATE file
> > > > > mapping?
> > > >
> > > > IIRC this was originally suggested by Linus, on one of the versions introducing
> > > > mseal. But the gist is that discarding pages is okay if you could already zero
> > > > them manually, using e.g memset. Hence the writeability checks.
> > >
> > > What you can do is
> > >
> > > a) mmap(PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, ...)
> > >
> > > b) modify content (write, whatever)
> > >
> > > c) mprotect(PROT_READ)
> > >
> > > d) mseal()
> > >
> > > But then still do
> > >
> > > madvise(MADV_DONTNEED)
> > >
> > > to discard.
> > >
> > >
> > > There is no writability anymore.
> >
> > Well, you can mprotect() writable it again :)
>
> Isn't that what sealing ... prohibits?

Doh! Haha. Yes :) very good point...

OK I'll send the fix once this refactoring lands.

I think the check should simply be replaced with a vma->vm_flags & VM_SHARED
check then?

I wonder if the argument was that the MAP_PRIVATE file mapping is somehow
ephemeral anyway so not so problematic to lose. But I'm sure there are users who
feel differently about that...

Note that a truncate operation on the file will immediately drop the MAP_PRIVATE
anon backing anyway so it's sort of 'droppable' the whole time.

However, since a user is explicitly asking to seal the memory, and would have
expectation of seal semantics, so I agree that we need to fix this.

>
> --
> Cheers,
>
> David / dhildenb
>

