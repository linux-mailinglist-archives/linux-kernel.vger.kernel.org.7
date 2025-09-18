Return-Path: <linux-kernel+bounces-796227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F112EB3FD8A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6914B1B242AB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192ED2F60C7;
	Tue,  2 Sep 2025 11:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ONSrSVfI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mZLPfBsb"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E3527A124;
	Tue,  2 Sep 2025 11:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756811645; cv=fail; b=llYSv6ljjMJS4r/ioDH57UDplrERP7q3TuPkQO8AKVaVIoj3yvzgJpMhRHOa+cBM2CcT/lrhSrYHO5JojtwQtXLkQv3KEzlFUkRRpOP5YOgrjc1XczfLFLGECiiVsh/gvBa2y02nAjYV5QpC2iBIia2tae3D1Te/ttafJkVkEMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756811645; c=relaxed/simple;
	bh=7SFt8UdCpnp7H3MpMhT/HSWxt5wnYWOdrQNE16Y7xAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VEbxkOtAHUvKtA9lvapgEUJuuskutVMir9wSBuyfodPp0OIi4cdd15FIHspLL9/xk+j1uLQQ/f2vgOmOYHj+TsQgDWqnzTD6ZRkbZ5MdeGOCrzjq+qn68WggZiUznJP9CFU0vppRwnEottxq3gBBZct+SYUhkeUpsWD6pNnAQm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ONSrSVfI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mZLPfBsb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582ANVgp015347;
	Tue, 2 Sep 2025 11:13:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=qUSabZ2ImtDOc8hQqB
	EjXnuNo7sTm8kjUlDYbPAGHpM=; b=ONSrSVfIpDim2ltVTpGsR+QAwyh8O73mxu
	kWK6fnQ69v6LofAGjBeS8nBOkIP3q2RfSj8C+rf215q46k1a18H70Jv5YuDzoZoa
	bHOcnbog8SmkptEck9aM7NOE0i5RlUUMwL7WD108K0FkvlCgN7Bqcu3GHvrWOKi8
	NmL1m0o/nm1hIZn1nX3ZBt43wFHTa4kU9SadvAp5RM8Enm1LiD5NFqg9kMDJL0h5
	qS+Cf2yjT+Nqa6ef/Gk69vDY/MDSZNDSgy8yjBUD1td6EBZqfDXXHvfw2KxgOqdj
	zcdg0XDfUDpkBB+7i8ueKOdoskDLRUNMaLTXSyg2v58XTzdZms9w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmnbt96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 11:13:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5829f6d0032530;
	Tue, 2 Sep 2025 11:13:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrf93er-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 11:13:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMWdk9x1Qk/osW3U+Qkkk2aeBkvQpr+H3YnztLkQVUgLr3QdenQgxx2PCW97O2jqv/0dO2d0hsbEZq+8WEgDjbeIt14ScTGtR3BVIzAhqPWIQayoJZeNW1veccpnu2+xZZiagDFmZsSlEY3kgW5QBFoZcFSHljNDHHQGlTvJjdWhwaIqX9bdCLSJmbIEt2t1x1c7q9TsDnAEKFzqj4z1/5f7zUZOQcnl1CMmKkQsCMxLBmzi9Gx4qfeqiRm3vSboUBTVY4qzYTpe5x/rYJLFg2Lu6HZ4fRH2Zv8bOKozfp4bj8tTHcs90ibnvuKJgpvxSBWFKm5lVsrOqXkV8LyrZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUSabZ2ImtDOc8hQqBEjXnuNo7sTm8kjUlDYbPAGHpM=;
 b=JM6CneiSKceZX0o2934fzYY5hMzF+s7C+okMYi5PrfGDM8mHU+JzJ5APxHSprcOZEUSs7j78N5DQbsGJlJJPyyJ+mYj/yQyVsmXZ61hgpSc2xa9r7u35IDYXmhdKZfnYNkR9oKvUDYVSPfmGwzRtXaYVDlPSo5BiHNF10CmAjHXm8KAh6pbee6QPW8geXLs7QDg51PNlop7oVlfctDIRpG/fyvC/2iz9WMVD40Wco43apbmFiY8SPr18RfjKx7pYqlktOdrVp4kuzjOD9OGO/GVBYMmer2Rvwbgx2/Yk8IJonb0TwXVqJ1f10SnMC3A+e5ZW+j8aleQyZTpqf/1Dpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUSabZ2ImtDOc8hQqBEjXnuNo7sTm8kjUlDYbPAGHpM=;
 b=mZLPfBsbSjfc0hUuJIBcmma3V+93stY3yuJmKRoaQ5BhACeXUPFOa3JFus0bEtYa3oxQaObeVJWRsMR+AvTimzqk41FMZMjUfUsxu+g5odsAR2vM9/HCOtmcQrH4kXlTkpkvrvXPA0biE2/aY6Jq8mXetJEgYGWIHooF3zN/RfU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV3PR10MB8009.namprd10.prod.outlook.com (2603:10b6:408:285::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.24; Tue, 2 Sep
 2025 11:13:44 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 11:13:44 +0000
Date: Tue, 2 Sep 2025 12:13:41 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH v6 08/10] mm, vma: use percpu sheaves for vm_area_struct
 cache
Message-ID: <195d00ab-5429-48ff-b5dd-a45b26cd9ea9@lucifer.local>
References: <20250827-slub-percpu-caches-v6-0-f0f775a3f73f@suse.cz>
 <20250827-slub-percpu-caches-v6-8-f0f775a3f73f@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827-slub-percpu-caches-v6-8-f0f775a3f73f@suse.cz>
X-ClientProxiedBy: LO6P123CA0035.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV3PR10MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: 338ba9f0-3da1-452e-d381-08ddea11c789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YFzAZRPzbzEtcJonSDzrFZ5JGb2OinBfVU4os8n0hKOrTGkbaLfR0Oqzlz/t?=
 =?us-ascii?Q?E4ILTaOZgTVCOIhoqjwqt77+ZUUw7L70kI0ulbbRH9XcMJZMfoKN0IARXr5U?=
 =?us-ascii?Q?O5TquCfv3AwUbF1Wpc4PJZLy3NXZxw0kGrr7hU6VOprF1We8CcKDFU/jozWV?=
 =?us-ascii?Q?8UbqsP3Nq78zfttaItW0+RxPrJ1aJwi71jKszJcpOy2x7M2KsrEIg354XaCN?=
 =?us-ascii?Q?e8uFuwuUrSItG4JVMKQ8/CZsFfGJ/dGUn5iFCA4s0UStFtrrgN9bE/9+juIR?=
 =?us-ascii?Q?hxyFSfeukQcUl3e1AQLoyj076QeBQNLQMrgttOJG9HelHNm9N70C+LHVb9UE?=
 =?us-ascii?Q?9cyiRQPxGZ9S3am52nZx3pPmDHMM/IPegcdI4BJPM/CXKhSokdIpWcCEOgwU?=
 =?us-ascii?Q?eQ5b9WXqKzrtqCYsy+XLT19pjaI+5U7yYVFWQMs0LVCDNQjYaW641NnWdvj3?=
 =?us-ascii?Q?c8KTqDhqvxl7MVYaWLLh7imiMSGDl096p+cTu15E1FLcWHqlajHVUEXtguu4?=
 =?us-ascii?Q?mXv99nJhL273HHJeVI8eGCeQ7xSzIICM6sFyS01XDnV0kD6Wl1RzWUobnBZo?=
 =?us-ascii?Q?Q/30vhbGpcugeZf5vt7/3pzxB32aasVsTvhog9VfgzoFRZHHUWgn5FRRwrfC?=
 =?us-ascii?Q?oXcqfalQD2yvPle5XmaV/FmhPevWBlj8Tj37XHV8q0y9ESTvXNjYXl2bcYIg?=
 =?us-ascii?Q?in2KYqwh36Cnt28BWAyXM4cvlO4Qyiwlb60kkfXfQbnZYHA/af3w9q1VmaCN?=
 =?us-ascii?Q?0pT77L/p0sAD4i58KgFfT8X84e90DwEkJ8dGSQ+i4FoYvcA0ptaMuMhSuWG4?=
 =?us-ascii?Q?qB9gDWISLM0X7zDMWQMI7xCDPb0gFtr7XrZUXpMWDbsDrZHMqm022B64PNOX?=
 =?us-ascii?Q?JDwlbT1Niimius1aeFUyn9uCjlTzobP5zjwWRKBRVKpe+AVNq71qf5AVhvyO?=
 =?us-ascii?Q?lEKaC81VzXXQNNZpVgoOyvdKqKf4D4AiC6xdnzTgg7fcwxAuIriJJ8ZkTV3e?=
 =?us-ascii?Q?lZTAlILeLB3tAjl4TF9mJXKzFj0pskAWOQxYbRXgHZIGONKgsnBMB7DPr7gd?=
 =?us-ascii?Q?dEZBvIrAxiaSDmZZW+DjGlELSVqNoHI6Ly1rbICIlP1oLjMMFleNcn4RVLTG?=
 =?us-ascii?Q?HZvPeGnYMCymhJMo0s6UxDYHUSz2fWw5Ow4HdsrqHw8Cvcfm5MyP+RFF+jtv?=
 =?us-ascii?Q?K39dIRgl8qCzq6o8fIjLFtBUVfrfmj8g6eJnXub6gDErhR3RhjFKzK3/LhtN?=
 =?us-ascii?Q?+uGnjxE/nhv/ToeS3brttujK/2j/76iBJSKNblf5SiyH7FfAMErhsV1UglMC?=
 =?us-ascii?Q?CvIMC0fd5qX7ADNXOdkGS9xWsN/drlq6uZUL7JzH8ri/5eacluzzza6quHB9?=
 =?us-ascii?Q?6nSPPsCVvyYN1f+h5khh1ICffglC8slvttuEcM3M5TxC8liILNGQ5sArNMR2?=
 =?us-ascii?Q?W/3vLQXkxP0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GxwHQ/dAi6Nek52HWLvoXQSWGT5UKsWnq2lYkhM9DwVw5zP7cMC5F0x150Kt?=
 =?us-ascii?Q?9LTYY/oYPU1WQ3xOJgGu0HJeypKe/8uTgR32iNaKyAyhMjdO1zKOqM4Fpza5?=
 =?us-ascii?Q?drBNHZg/KDLHOJ+beiVbtZoZ+he7+xBrSTLNYV6jPskt/w9LfjmQCUjApIAx?=
 =?us-ascii?Q?zwwwyeWdVpUW4bVfIoxnocWHfgYRg+wO1gpUKBKI6b2F0XGhzevTGfPpDfS3?=
 =?us-ascii?Q?/iITS0hRcFlGfpxOm2V50Ef53ALKbYW6R+5FnmsI0Kp97XTiVv5QZoi48hKt?=
 =?us-ascii?Q?NFK0ogQUUQRa92AARVIIGqH4iJFGyFe9bGUgR/TiWbJTPPJ9D/f6cCkE1Bw1?=
 =?us-ascii?Q?jd8Xdo7rV+upZXupTPP49G2EAN30c9y5N9Mv33oq+7BGeizYWrNDibmAICUI?=
 =?us-ascii?Q?g2csQ/u9YzXJnXcKAJtjGfQ8O3AJsdffZ/Bv3GLpQJ0fRihGa/eqm3dK6TAU?=
 =?us-ascii?Q?DKezOW8qBuy2Gu8uxoeygFDpiLG7qTso60H65WYzrJaXH4t+KMGEOlj2l0hr?=
 =?us-ascii?Q?wIovDWVQEpIh/KB2pDiMlnV8EzUMp3G1r6ziAVfjUASCtg7DwvcdvUkFSB2w?=
 =?us-ascii?Q?B7ESCteZsH0H8k34Uo7qzkTNE6pT3r2HS3dfdZqd2ZZToSDh2mOeJrNY9J/y?=
 =?us-ascii?Q?fm1pLigIJ6Fn0UYT8HuVEvSyx3s1Pc8aX8GHN2ygGK6opEkLjtiEQlpSQBwZ?=
 =?us-ascii?Q?Jsa/cY1wrxKFqe6w0CwWhmLBseC8fSxIAVu08JofyBij8f49sSrwJ8qFVUcd?=
 =?us-ascii?Q?BM+CzsImZJWdsMJXpgYAjzxcr1jDJvQopO9JzpIcgifz3m9yg5SnbtqqlGXL?=
 =?us-ascii?Q?6YqMt9xPem1hr8BHnm+E/XcJNUn77374jVhhyZE9LrpautFhdAYpoKTCiQR7?=
 =?us-ascii?Q?AgmY8S/bJeMOpX2enJdAxPmrs7+GEjypqayFXXrG9kmpoRB4bXNZ1OOM/5Rh?=
 =?us-ascii?Q?nZMskXrCJcsswl1gpTy1ExiCkyolJd/tM7uQDCG6635OGv+kG8vkK+8rd7aB?=
 =?us-ascii?Q?t2EJ57IypXuqd6X2l74o24oVD57GP/iBznfRLlRCupsDXTmT3SY3k8Ypmo2y?=
 =?us-ascii?Q?S+y7DqkCkGRlMhD4lfMhiwCRRog1RIxOy0z69SAUQFJ+fc04FBmuN7UhKy/S?=
 =?us-ascii?Q?TDkbUxFIsm6d52qdeFClVBj2JEgRA6ebmuE+LGUT45mnyOl1yQdlxZQhGpya?=
 =?us-ascii?Q?4OOiK7nqgFoAfEjVTKtAQgleDoT3S1RFZGyrlYJfKfFsp6HeLud9SFWfIHOR?=
 =?us-ascii?Q?vUzEdQ0GvIWAIDI6RBhbmyeykcn5ilzBI9AySIt3bsY6FRiQRv+kCuttVCpb?=
 =?us-ascii?Q?vHQA5n3/UxhC2WZVKqdnU+zknsle1qyB++rHzA71mnpAKOmQteCFyAC7zEjI?=
 =?us-ascii?Q?cFHrQQDKFejATD0VaJ5q4lRh20+rSi/t4AaGaK5z3FhF88mS/8rGkqkbHQVT?=
 =?us-ascii?Q?DOBoQU0rzCThGeqLAPEtus43RG29+aL5WL90rWCpHbUBdD8uIXsOJDlSxrKV?=
 =?us-ascii?Q?e0zmtSEVeKBh6Q/W26DC5HZgp3GMMbVflrZoBOYspDzNzrjbkNBbI0kTJLu/?=
 =?us-ascii?Q?WpC9wwUHSBx1iKKEhQrPBSHZIxqtEvNQEstxNIxOXQ65DxBxhbzL2SQbtYV4?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vUFTYByj9WIHL4nH1BKn0Jg8+17oQM8jOY4ZGSHWZxQVFZtz4BQgpR+5Rq6+tekDVovGLboQL/yz1Y43fLf8XPgX82zBNN2F56jME1AFpE5xVytOwl1GYW2h1ye1YgyiOOMr9rh40FoxBeYDoYCkd7W+baOpBwQWR8DHR9mw/aOy6qtdvb3JIlf691lUd/uvIW7wmsq+dnasNyPTFY3AI1nxkuCR4q7EDMxfDxradNd6bCK3KJmPti99TGoXDXm64OCni03y7n2utvZeDD2lj1gjz+kEs+wMh7/Q7YdZ5BtobwDCSoNAuq8oQeedFPCplMPyF6E8/QOWe7ucUYikZs8GYuBo3RK52uZG8PzFqk3U7KlEKfs7n/DS4jXiKakNo1NEYWwoX6MwD1j3T8Nd6JeMWJOlalstu4un14vhWIAv/2E6IV2Ioz0+54pmwLIUo5SM4q03rbZcGD6wclDLTXa8YbF3mgjA15EezpDwtplVptmVlk8Ka23bSRIkmEiCPennnIC75JAz+hnx51IdSiDDcKQv4m2MML4qdwDr7QIs4kStD1knbe3bnfFbZU/JuFfrcsa3IBdLwnZm9JcTLeYqXDaAUNADTtL5qrg53PU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 338ba9f0-3da1-452e-d381-08ddea11c789
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 11:13:44.5521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NhtSWVUiBn3y3sx1NKKOAiQ+Vo21dX1wluHAiLb2J90RFQ9n81/SvcMmtFs9H1hb29ve9FsVWCEgy0XwPTUHGQiVMGUEQDT0bPTiGLBQDhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8009
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509020111
X-Authority-Analysis: v=2.4 cv=D8xHKuRj c=1 sm=1 tr=0 ts=68b6d16c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=1XWaLZrsAAAA:8 a=HxM71CRb7kdi6uNY8dYA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12069
X-Proofpoint-GUID: bLURbQzGfWw9ZU3Zbx_JAGu6MTo8hOCO
X-Proofpoint-ORIG-GUID: bLURbQzGfWw9ZU3Zbx_JAGu6MTo8hOCO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX10zswDwMOvkm
 ndhP7WP0w9GEkMPZPZPeHd4GqG0ZkEUF6O35anr4MI7CydUaLTFRrIoeJ5fg5dCG8G9P70Gyvsp
 1RJTW0aruAi/kdJyZsmD31rCaKSfoWeiP9hU5h+wKphYoLZ3CIh33h5m3AMxXD63w3wXwRiNI+k
 RPljNFAHQ+j7Ihfzy+B40z40Uw0dK1FIkw2gZdE4pxHp/ivmJLEWR7to8/CGf75HZES9i4ml6Oy
 CsnYND691Rp3uEJjIpkfWf1UL7LIzvIceSVficArYlxYrt2ZvZAg3wV59QAnO0s4KGBtkA5SuPv
 OkYyNadnBkLLFL/03/3tgzREl+/TAnFuEBgkMVbySf+GKbBAooXHCKfCajBUIDuFZX6caiPmt7k
 t3nLMMLCHy0kxpfugfA+knAmvJI+dw==

On Wed, Aug 27, 2025 at 10:26:40AM +0200, Vlastimil Babka wrote:
> Create the vm_area_struct cache with percpu sheaves of size 32 to
> improve its performance.
>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/vma_init.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/vma_init.c b/mm/vma_init.c
> index 8e53c7943561e7324e7992946b4065dec1149b82..52c6b55fac4519e0da39ca75ad018e14449d1d95 100644
> --- a/mm/vma_init.c
> +++ b/mm/vma_init.c
> @@ -16,6 +16,7 @@ void __init vma_state_init(void)
>  	struct kmem_cache_args args = {
>  		.use_freeptr_offset = true,
>  		.freeptr_offset = offsetof(struct vm_area_struct, vm_freeptr),
> +		.sheaf_capacity = 32,

This breaks the VMA tests.

Please also update tools/testing/vma/vma_internal.h to add this field
(probably actually at the commit that adds the field in mainline :P)

I do wish we could have these tests be run by a bot :/ seems today I am
that bot :)

>  	};
>
>  	vm_area_cachep = kmem_cache_create("vm_area_struct",
>
> --
> 2.51.0
>
>
>

