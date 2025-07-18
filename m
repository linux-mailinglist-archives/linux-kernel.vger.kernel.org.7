Return-Path: <linux-kernel+bounces-737164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A36AEB0A8A6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E28A97B903B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16C32E6D14;
	Fri, 18 Jul 2025 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UnR0uMjX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="S8q9QOB4"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46642EEDE
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752856898; cv=fail; b=rHOGCNK9Uo0e2DMm3RhNpw+/UUrLG3eWLXz/kT1mzdPcfFdy3LvB+QfGR95j5YcHgrA/Lt1SDvgdCEvIKZaMuKt7vcs8z1n8Kb0aVkPzsDnK4/zmxE0r0H+yAWD7ldLur4pqSsHsCTW8PQQ845EXpbOUpvJERKwfEXVDkO99PQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752856898; c=relaxed/simple;
	bh=Q/4PrRz8++PYNCPy1i124+dczIDKwa6Tq/uimO9N1NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dgmrwaGVtvuBSvOXeSpA2EfqsFMc7arShJ8KCG+xFoGUgjZtWgzEom77SbD2EcbxiGmV+SFHs9QqjY2oqMilH286hhBxuK3pH8ZWgi81HXhFxP9w0CcFE+n5tHQpWJOs2uWaiFkiOb7FlrIpoKm6neIF7DQFoUcB5uMi/QE3E20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UnR0uMjX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=S8q9QOB4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IFtrtn004446;
	Fri, 18 Jul 2025 16:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=w9FOQyE/Vv/gHUsm5V
	vXWZL73YhfyAvmTrMywulc6bI=; b=UnR0uMjXi/sZcuYrWjKqjda24HyhFNrBm2
	3vjXV1xYy3TX9EfnpozC295xCOZd2CO7NbrFYQa2OylgfCDmgDIbAouTQCsO8pCX
	Fk+V+yWmz66u5VRwowckMVppkMpLfbWp44Ft45nmSfEaugFvA9Ss47HJmuYfXQln
	HnkCN4RSVTQgzjjsAVBfjnpB9fnO1c461fiCffkEOgc0147KqdKZ21dhsdUy84Cm
	jz0QdN6eH6IMJ8/DxM77BLvVItnfmku67zIKlbN3QKkaJg71MIRZx7dpufd6HNwF
	50J/NbPJYYfMmTakWV9bogzUNG3s16UM+GPg6TQ4dhYmcRibCZ2A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk6754v4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 16:40:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56IFna5J013753;
	Fri, 18 Jul 2025 16:40:57 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5dtg4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 16:40:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8Z6mEERvkmjAPZeOKJQNBKE+Iv+ONILNia4XorGd/0eLySyPzTO6CkDAYGVj94+agGSsk2k47+7KnnyXZcHv0K7qfl/t47zK9CVyv1TVPPdAjURrfEmjaVDrZWr0GB1NGn+FvPmlkPAAnLVtZAGZ52/nSmZ7PjVVlUwp3PcP3I5U2xFkqmsCCv/0TeWGl/bwp9ohuJG3u9JaAunnnVCP2nfESkFkEpFH7yRnr68qRFQ1CuRFh4SLonlvtdILdlotrYmyYZPE1vkwAGFKI9xsrGkWviDg6bBRWz4kaYkib7VBdxLfhvgKbpskRGWDnP0UTo01mYlYZurNHobgJkOZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9FOQyE/Vv/gHUsm5VvXWZL73YhfyAvmTrMywulc6bI=;
 b=dGJulFm/IS4f58ifnWUQzAK+rONytGHM6VubI/VnxsKBDKCzs56FjqLe/bNjAGIxexHtjsSv+48WVRh/a88N9/UD7JEck+FrduiuWeI978dyReaKsm4F96JEeUP3X5WOqoGaYbFq6tvHK8i/5SFfdBux/kuC+mA7o3TYmwI594yBxWgrzwEOYjwXup6YPVZa7jD3eswo9IPzF0zIQ/9Ubw0cLBs5y3JuaQpr1I/+d2JZ5pEjAv25qds2Lp/s1fA3ea154QG/DOvJQR+2DQSdyFxccGuQIwnzHYLytaRuSfBVZ5RPtSS+4gko/U9V/qCisxcjNRUvDh9wb6erOuAloA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9FOQyE/Vv/gHUsm5VvXWZL73YhfyAvmTrMywulc6bI=;
 b=S8q9QOB4X6aqrDEiF/Wp8/PnIHyUG8JDS+IRuHZa0CoQfh61JsZazwv+dFEqlQXlloOQct4nguvZE2UXCMlnoxLJo1luGqtucOL1Wk/QGRaH4tEXIoM+0uorYx5sIPepRXHy1t7SdRu2AgJVIObmIAFZb2Jw4SjZ3+Z9XnJanbA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB4543.namprd10.prod.outlook.com (2603:10b6:a03:2d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 16:40:54 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 16:40:54 +0000
Date: Fri, 18 Jul 2025 17:40:52 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, david@redhat.com,
        willy@infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, Liam.Howlett@oracle.com,
        vbabka@suse.cz, jannh@google.com, anshuman.khandual@arm.com,
        peterx@redhat.com, joey.gouly@arm.com, ioworker0@gmail.com,
        baohua@kernel.org, kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com,
        christophe.leroy@csgroup.eu, yangyicong@hisilicon.com,
        linux-arm-kernel@lists.infradead.org, hughd@google.com,
        yang@os.amperecomputing.com, ziy@nvidia.com
Subject: Re: [PATCH v5 2/7] mm: Optimize mprotect() for MM_CP_PROT_NUMA by
 batch-skipping PTEs
Message-ID: <070ba06d-c32c-41ad-af0b-4bbc5e59f085@lucifer.local>
References: <20250718090244.21092-1-dev.jain@arm.com>
 <20250718090244.21092-3-dev.jain@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718090244.21092-3-dev.jain@arm.com>
X-ClientProxiedBy: LO4P265CA0184.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB4543:EE_
X-MS-Office365-Filtering-Correlation-Id: d9f9d85c-8444-470f-6b3f-08ddc619dd29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kURotK51MH81gkPHbnQi/JnT3qisgZuHAIRHSQHh4fzqjOiM6QONxlfQU8SV?=
 =?us-ascii?Q?bauM2hsfvCTKGXkmAm2jjEz19diyQRjLECb5LjRWyAKAj6/dH0FPTlXywAgA?=
 =?us-ascii?Q?AmI9T5rKQOGBEPUt+tA2fGqAiK2fKilpJcqneK+2GQ3GY2SsteJ5GYrnSmih?=
 =?us-ascii?Q?CO3KHmfhriEX8hX9k3+BkGbItGoHmw4JRXMU2o2EINAch76+wt6aAGIkZfkT?=
 =?us-ascii?Q?nGpJsvws4/2UcczNvDxYFe9cMGlX1xcwtQdWdYI25iHe4ThplmLeP0s2Lrf4?=
 =?us-ascii?Q?qxya67n3cX4CWX+IFGytTkv4YsEP3Mr5iT2mCCEYfXhOC9y2aLLY51/ROxLA?=
 =?us-ascii?Q?S7UXnaUsW0os0ClVgOUgJYNk/BllPkkDPCVlhg+NFNGzbnBvtpyxK8YK/8eM?=
 =?us-ascii?Q?eve2dJnzHDc6b0rp/kq8u2EZh9M1OOQwub0Yp2eByCUZecZl6gPPieKN6c8b?=
 =?us-ascii?Q?piiZhC5VdU+6LaMhdgnrBilRlTiHkhu2eaE2gTY5LVq6A9oJqYTiogdOL696?=
 =?us-ascii?Q?FqsZJQgnk6tkRKnsk72ORIDoaZbG4QYKLDA9HHMN6Ce6N9W8Sr/OZpRf5sFG?=
 =?us-ascii?Q?wSOUU8Jc95kfrpBOKf/0sJjDOWgfhxR50rcLgWCOmR/7D05UFt510WGl1Y12?=
 =?us-ascii?Q?AfVdpmS13bCYs7iDt9hyFexvj24affxOhT45NkH9re6sX+ilqDXjNLbzXlwN?=
 =?us-ascii?Q?TJAC7iV8qmJ/MfHtrX1U5zLeJKlUa0WkV+2JbRHY4GYYzPbF5UPIgJsqSfGC?=
 =?us-ascii?Q?7pjuJLzTMKCOj3KpXF0YcjMSEl/Vswe1ExDNDwVhzz1INag1Ysk1ROjvT3pR?=
 =?us-ascii?Q?3dhuwwvUkY5FiLs37Edzila9G18Tji6AX0da9se1uCZrVRMrsKOs/nHd9Gim?=
 =?us-ascii?Q?Lw/ns5fxpYxZskChAnvH3TIvx/g7L8SfaMnAg6PlB6iMFA4/ODleQR3gJfxl?=
 =?us-ascii?Q?ezy7XH6roFke++KlNTuV1QGoZntGo8334V2EEpCcMIkLWTBF7mZYg+Muyxgd?=
 =?us-ascii?Q?fooiOsaHjGt01dg05Pao1uzGCZuTRoCtAiXFwLocXC5hTQcjeEueeecxdkfT?=
 =?us-ascii?Q?hhs4WeaqmyqpLjf9oACJ5NMaMgjsPScMFcnxR+8WYW3+X8VuA4Jz0JNxQnv4?=
 =?us-ascii?Q?fRUNo68xhoVAMLAxKgVNavg5Pt9pwLOkiH1gawbzcIZkFlB7PMQz0DKc3JD/?=
 =?us-ascii?Q?kHNoYTIT1UAp0buXaD9BzvJdNwes/5M5kCsLYtn4CDfZOzo1rPFa5/aA4GD5?=
 =?us-ascii?Q?rXHRjt+VgZ2ppF2DKzMwrrlqEqtifSwsHLOrfvkzPWRMv3TYsYqY3ccDj+Uo?=
 =?us-ascii?Q?Mtko8O1AE1mGsYAThP/EBzqpW5DR3iekdU/MwKUv4oLMW/Q7ClDNrIjTzOqr?=
 =?us-ascii?Q?Cc3j6wEajeylJkLA6x7xHgpcvhFlNdItpP008hh2P3O9t2pXSQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CLEny7vgJ3rQVwDERbSvw0C3VxPKzJX+aJuoFdTZMvN+PX/FtGwsvJ0q4wPN?=
 =?us-ascii?Q?bMGtW41UqXg0udT8p06QLbf6Unp3Sx8egLLQ7lGnLtuuRVLwMYmn+IoZ2d63?=
 =?us-ascii?Q?iolwczgyM6nz2hDUmT3jJwn4WeGEWM+9ehDjAMEUHF8wGM8z1WKcGVP0lY13?=
 =?us-ascii?Q?KR6D0SJseS0wavvN6r4kkKO9+TnlkGQslxGTjVBlOP5WpePQDcflzzQBFup6?=
 =?us-ascii?Q?V2SsacmJ7K1+8ClbAI5PZ6i1GjRs9f0aZQ2Xu046wSqmnIJOi8aHjn9JH9jC?=
 =?us-ascii?Q?qwGOK8WfiyzaYDgYRaC0cZ7ZXkdQl6pta/M+xMuB1wZooPjjVzUAUCvtx8ov?=
 =?us-ascii?Q?u1hKCNMtdESc/0Sl4et3fCFtNTSRI8ZOcozOIghPBLsXW6Jerythi21L5L1l?=
 =?us-ascii?Q?uaLnxsW+81rp/hm9zMT8UmLq5dwXGLe3y7dt85XYrPTPcBOd1POsNRSrUUV1?=
 =?us-ascii?Q?MC+RMfO6/fHqlY0C4j/r4+g/xpium/10O07iWEPm5czae4iFnkZYINsPdRBr?=
 =?us-ascii?Q?qI2cM8mRC9I2hTqOqTgfzmrmraRNOtm98/eZ1yg/wiUD2/E+pPVutfLtXPqN?=
 =?us-ascii?Q?ZbPRxwbjd8TMPJ7IafB3PM8vJ/01X9WldZvbadsaJpbUaBtHFWgAr59hQI9R?=
 =?us-ascii?Q?9b1J3MfUrV3cKwkSoGSnML+3pxnX/TO/a8ZwMadh53YxLH7ojUbKsGq1ADWh?=
 =?us-ascii?Q?nA9agT1CP7Tyj10csIlWkkIGUPKKauPHiEM9l1IqV9pYzleCRoG/mpmlDe8c?=
 =?us-ascii?Q?FjJvuW4JMY5aALM2/gQ0b7tonLQEIkGPWsAOZkA7BM5HnKuGniY9N7aLDMq/?=
 =?us-ascii?Q?atMAD8WMzfpghiVLPemAoyWYS87vRmgy5myszBJdQt/rxWBoVFD/N3G3XlE3?=
 =?us-ascii?Q?Yu2LrzEqZPJLfl35OluU6GB8JsF1bvXByLbfUNzFTSUfH2++/CFmsywmD3Kb?=
 =?us-ascii?Q?hC0/cQyUD5qGSO6QxkndPGmN26k60CsWt9yoCjYzT4iXMwpUVXAc0RABInpN?=
 =?us-ascii?Q?TIN5fmPGMV45HNgH7tnYl0ZX9F2WTdifaDDqbf7cIBsOnmjIFGAgONf2HaWu?=
 =?us-ascii?Q?9obRKgm7FW3a103JYOChVIJKNueWXiUZ2FmsCZo8eFPToxgxP5khYRIpNSye?=
 =?us-ascii?Q?aGDIqP6V9Dr+bfpvjU2PRXSCoH3JqwD3HbXtzpCAqkbUYk1h/2PGyOLr04xk?=
 =?us-ascii?Q?Pt5ROgKgEFyER53Y7eAo+iHjtKJjgcaW+wF2ox4qeIjZhk6ceQyny2LHZ6v9?=
 =?us-ascii?Q?99zFnp0MC/HnD1It37y3OZn1IJPJVRmS5jLxiJeSLZIpiOduLKD/AAKW/CqJ?=
 =?us-ascii?Q?KW1RyHZDJJtYVGeAe4oWtc7K1o6IN1HpIzVegM81RhQY7fI+Q2feeDSign3m?=
 =?us-ascii?Q?4pmz4VKN//NQx4bzP/zMDPubgUqiQ+FwA7cKVoI62M8KizDm9bq+TzebF8Yw?=
 =?us-ascii?Q?zONjZlez3/ZIFik1ek8T3gO7wspccUjunflvn2thMuYLSoLkxw/nYijYsAR4?=
 =?us-ascii?Q?UCNS5HSf6qpM99lpArl+iuVzvtK+qrrldf6yBA/ZsQkGvEtbWWvmuI4ezAJd?=
 =?us-ascii?Q?p6DLpt+eHmx7nGmScyAUqrFVLIgiTvHW38AZ3b/dsyU/t64Y3ymjMyCi6Oar?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uefY+JBKpmMoCzS8nhcSZWzLLOZ8tfBSLXbiZdxEP/mddZwOlv1Ivpb7QWwaspwxIbZBy+rmJE6pf97tDAK5ZAnL+dFKKyDmbA4CVWTRIAfxP6HZqy08RG6liMIvKIDfBPdtox499hDqu8qX7V0s/4fLh/gVuLgIGNrv70k/PAv0b0M9idT1PpWkBVbq5QUZOUtHG35rxiKQFOACkMzgQF7+bSx3aDaFrb93xt2pocczis9ZxNiS0gThHp5PYgN8nQ8kUyBiYttSCT29V0nQXAXE2ioY5PC5BDEHnY9ueSKvPfGl5ll0APYxD8vIaiSAsEgYK9VN/lHvQTcu6iQSIvcUMkGgWQUdIofQCsRPDvI2iG7kKJUWGVAbLiC9T+g4KScjPGEH8DBkfeSiLiMowiJoKWTRY4iaNZtBK8ASjNAJkyUIHjCkStXOzBoOJku1jUD750S9k3nlb82GTfo6J1zshQy7XtCRNsqp6zPgWrcxA3etfiEs71YL1jlxoqv5Y1SNpreNk8z6wuqoGA79u2yQlM/c7+gK2ZHjPDUmDiz0CHivQ1+VSc+FnXS+8SZwwmWiqeowMEjx11ogDieodsW5WOJ74HL/mZUjZHF3Amo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f9d85c-8444-470f-6b3f-08ddc619dd29
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 16:40:54.4178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/j9GnB3MjoTaYb+oaVfLViXGfuzjA/24eb5vTGepdxojB42UJaAjXx7tdWSHDaIvA8Fb0e9ngttDVsvYm9jULHkTEsLIUN09NNqcZDPYdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4543
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507180130
X-Proofpoint-ORIG-GUID: y3kKwyyeMPcqi5j2z0L2X3NEWIKkqRW_
X-Authority-Analysis: v=2.4 cv=AZGxH2XG c=1 sm=1 tr=0 ts=687a791b b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8 a=8Hv2gRMSoWPEaWc8n_AA:9 a=CjuIK1q_8ugA:10 a=a-qgeE7W1pNrGK8U0ZQC:22 cc=ntf awl=host:12061
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEzMCBTYWx0ZWRfX8C7gEr27vZjW JKFMd8fn9iqi9SWfTBcHRb2ki+H6r5/je1XIIIa5NnncllshJW7T8DOUtjbZRjwrX9DmO9/7R/P VcxnNmzjdH+O9WL/Ovw4AOT5s9aks/0KjJ+uHPJIKxexI6NBpWhzkbQmM36T5lhkGusoiJguxpj
 ber+ZFL53bsciISM3I0f30DRQo+Sd3zjbASmw86NXWpkJMk1fSQTOueI3pvuVQBDknIKKg+Az6T k7fXucj3s3I8Gq+EnX8EsTn1V0HyvunmAlKcC4+ydPQgHq5YCkIQjBCgT8MO+6KQYfbQ8AWsXt+ XpuTk/0he+M66ZgJ+Qhk6ztaZwX8b6Vp+Fy/HaTVIljhZGjwmP0KtEH/12cH3Hy0FgVho6Ge9OJ
 UXjdAosh8X3tEYxbsf7sRyj1YG8xYGxArzNGQWX2HI7SUbDfCGpThP3DoDCY/6uvzxcmeqJ6
X-Proofpoint-GUID: y3kKwyyeMPcqi5j2z0L2X3NEWIKkqRW_

On Fri, Jul 18, 2025 at 02:32:39PM +0530, Dev Jain wrote:
> For the MM_CP_PROT_NUMA skipping case, observe that, if we skip an
> iteration due to the underlying folio satisfying any of the skip
> conditions, then for all subsequent ptes which map the same folio, the
> iteration will be skipped for them too. Therefore, we can optimize
> by using folio_pte_batch() to batch skip the iterations.
>
> Use prot_numa_skip() introduced in the previous patch to determine whether
> we need to skip the iteration. Change its signature to have a double
> pointer to a folio, which will be used by mprotect_folio_pte_batch() to
> determine the number of iterations we can safely skip.

On reflection I don't think this is too bad, it seems neat in this version
at least :)

>
> Signed-off-by: Dev Jain <dev.jain@arm.com>

Overall looks good to me, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/mprotect.c | 55 +++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 42 insertions(+), 13 deletions(-)
>
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 2a9c73bd0778..97adc62c50ab 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -83,28 +83,43 @@ bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
>  	return pte_dirty(pte);
>  }
>
> +static int mprotect_folio_pte_batch(struct folio *folio, pte_t *ptep,
> +				    pte_t pte, int max_nr_ptes)
> +{
> +	/* No underlying folio, so cannot batch */
> +	if (!folio)
> +		return 1;
> +
> +	if (!folio_test_large(folio))
> +		return 1;
> +
> +	return folio_pte_batch(folio, ptep, pte, max_nr_ptes);
> +}
> +
>  static bool prot_numa_skip(struct vm_area_struct *vma, unsigned long addr,
> -			   pte_t oldpte, pte_t *pte, int target_node)
> +			   pte_t oldpte, pte_t *pte, int target_node,
> +			   struct folio **foliop)
>  {
> -	struct folio *folio;
> +	struct folio *folio = NULL;
> +	bool ret = true;
>  	bool toptier;
>  	int nid;
>
>  	/* Avoid TLB flush if possible */
>  	if (pte_protnone(oldpte))
> -		return true;
> +		goto skip;
>
>  	folio = vm_normal_folio(vma, addr, oldpte);
>  	if (!folio)
> -		return true;
> +		goto skip;
>
>  	if (folio_is_zone_device(folio) || folio_test_ksm(folio))
> -		return true;
> +		goto skip;
>
>  	/* Also skip shared copy-on-write pages */
>  	if (is_cow_mapping(vma->vm_flags) &&
>  	    (folio_maybe_dma_pinned(folio) || folio_maybe_mapped_shared(folio)))
> -		return true;
> +		goto skip;
>
>  	/*
>  	 * While migration can move some dirty pages,
> @@ -112,7 +127,7 @@ static bool prot_numa_skip(struct vm_area_struct *vma, unsigned long addr,
>  	 * context.
>  	 */
>  	if (folio_is_file_lru(folio) && folio_test_dirty(folio))
> -		return true;
> +		goto skip;
>
>  	/*
>  	 * Don't mess with PTEs if page is already on the node
> @@ -120,7 +135,7 @@ static bool prot_numa_skip(struct vm_area_struct *vma, unsigned long addr,
>  	 */
>  	nid = folio_nid(folio);
>  	if (target_node == nid)
> -		return true;
> +		goto skip;
>
>  	toptier = node_is_toptier(nid);
>
> @@ -129,11 +144,15 @@ static bool prot_numa_skip(struct vm_area_struct *vma, unsigned long addr,
>  	 * balancing is disabled
>  	 */
>  	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) && toptier)
> -		return true;
> +		goto skip;
>
> +	ret = false;
>  	if (folio_use_access_time(folio))
>  		folio_xchg_access_time(folio, jiffies_to_msecs(jiffies));
> -	return false;
> +
> +skip:
> +	*foliop = folio;
> +	return ret;
>  }
>
>  static long change_pte_range(struct mmu_gather *tlb,
> @@ -147,6 +166,7 @@ static long change_pte_range(struct mmu_gather *tlb,
>  	bool prot_numa = cp_flags & MM_CP_PROT_NUMA;
>  	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
>  	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
> +	int nr_ptes;
>
>  	tlb_change_page_size(tlb, PAGE_SIZE);
>  	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> @@ -161,8 +181,11 @@ static long change_pte_range(struct mmu_gather *tlb,
>  	flush_tlb_batched_pending(vma->vm_mm);
>  	arch_enter_lazy_mmu_mode();
>  	do {
> +		nr_ptes = 1;
>  		oldpte = ptep_get(pte);
>  		if (pte_present(oldpte)) {
> +			int max_nr_ptes = (end - addr) >> PAGE_SHIFT;
> +			struct folio *folio;
>  			pte_t ptent;
>
>  			/*
> @@ -170,9 +193,15 @@ static long change_pte_range(struct mmu_gather *tlb,
>  			 * pages. See similar comment in change_huge_pmd.
>  			 */
>  			if (prot_numa) {
> -				if (prot_numa_skip(vma, addr, oldpte, pte,
> -						   target_node))
> +				int ret = prot_numa_skip(vma, addr, oldpte, pte,
> +							 target_node, &folio);
> +				if (ret) {
> +
> +					/* determine batch to skip */
> +					nr_ptes = mprotect_folio_pte_batch(folio,
> +						  pte, oldpte, max_nr_ptes);
>  					continue;
> +				}
>  			}
>
>  			oldpte = ptep_modify_prot_start(vma, addr, pte);
> @@ -289,7 +318,7 @@ static long change_pte_range(struct mmu_gather *tlb,
>  				pages++;
>  			}
>  		}
> -	} while (pte++, addr += PAGE_SIZE, addr != end);
> +	} while (pte += nr_ptes, addr += nr_ptes * PAGE_SIZE, addr != end);
>  	arch_leave_lazy_mmu_mode();
>  	pte_unmap_unlock(pte - 1, ptl);
>
> --
> 2.30.2
>

