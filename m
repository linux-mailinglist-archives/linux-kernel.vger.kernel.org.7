Return-Path: <linux-kernel+bounces-742847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8688EB0F74C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E87A03B1A88
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698DE189F56;
	Wed, 23 Jul 2025 15:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PWMm8J5Y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xGrz5sxx"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA7920AF67;
	Wed, 23 Jul 2025 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753285335; cv=fail; b=myCzlSDyORRuMqG00outK+HxvZz73+gWo9brRY1cIR56QH0KDwvKPjX9UVZKBYDWUkSvGIzhF3Eb8WHOdGwq7ra0QlHUpj/94yqLfxW/ULlYisvFCD/DeIlb1M3bWJVevCdSSUImgTv3QAfPBYaez67lV+EM8gwHnf4+Bb1FvDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753285335; c=relaxed/simple;
	bh=fM2Ch/fvWVogRAeimoj9OjCVSZyS2GSSZq4YgYtDSx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KSsyF9q5k82t0lTwoQd8sCd6pOFomYI3kQ+e69uI97Al7dmY5X7OJvihol3L6uLgwJLmfFuRqmrcH7Pgamd/QljC4jGUNjM4dTTE+TXRVPkDQkSOi3R/QKo9NERNhtvLHDTygIzrQwU3pPsWI1AgrPymQ8shvLVptq5PH++7z6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PWMm8J5Y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xGrz5sxx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N8NL3c026107;
	Wed, 23 Jul 2025 15:41:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=RReTv2IeghL7f7ekP7
	xarCiJKVBr+rJkwmvMSsIbZBQ=; b=PWMm8J5YlbqlXGTeOrpmXK3ObM3MjpJnA9
	qZxZ3amIG4bRm914tqRy9fEpjhM3dvmx+fna1lDJ2fw2wf+ZvcJNs/9AD5OFt1//
	iF1UIwEPelk4PFAjWqzVK50XrTuiVpVCEJVHUAf8Syq66Q5sy+wEADaINt8m1At/
	NyHeLTnWREe1Vqxvhkt1f7crd8Dh/ysLlCzZOn0hRcydHt1x1/DGmWK4AdPwg+lu
	Ka4v666A/WIgTIJkfujPlSzfsD6HJ640pj7DkKJjrzeeNG5LXA2isscSvHjs+Kh/
	ZxzKbJkWR5E3G4IPhOstafH+cFMkT4LbPbxbA9YfekU3heOexD3Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805tx7x47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 15:41:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56NEB0Et014428;
	Wed, 23 Jul 2025 15:41:55 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011002.outbound.protection.outlook.com [52.101.62.2])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801th2sak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 15:41:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mr6xY8gzFhHulGvFJtIWab6lRKDi2riJiNdYl0R0v/XAbckf3v2N99S4iUv3KlimHE7RxtwR/eVabqE5/rcLu9ylmZUqnooTugmyQLu0Tq4Udy9dJ+1ioNvSiZir5sNjZ7A3R2AQct1dRxabt8At4NzK/HpCQeAztaAvqxyhsgPvrVds68rdN2JjfB+uoB1SZSs3hVamC3Sou+YHYMx1CHgdlVgTSWac7RZHl3pHl95UOk6ZcDBHrIjkHgfn4tW3H3fxcgCq4Bh/mMwUnMXzCLFHTl/IUc1rligbC7ffCCpqraIacXQWgsKZS3MWZPu6GfKjGpX71ECHmE+3+R0gfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RReTv2IeghL7f7ekP7xarCiJKVBr+rJkwmvMSsIbZBQ=;
 b=mn171BQYie46zLKg9krrYMzFAqQavEc9+gembW9t7JG8elzwqC2CevjtmYSQ0+awq7CcgRA74x/mJODdmuVG5T9EV999tM2LkMsgfOpQfzwFUW7bLU3JOdSRVaKZoUD3d3FrMsPUHJ1sIHMMajp9oJtnosRmfOoEUn6Xd9idJaOrTuMKMZJidRIdfxpedpBQkAzvkBhK/ADNg2EXx5b3XHtU6eVKrIRBuwIRR1frFYjQfqDv0t9IM4OlcTJzp7+7agP+3mLgR66kq3uPvvyrNtF0NZkYqeEEbhVgu4Zca3t9s/g5Jj1FhdUQ5tx93QilFr1vcMYcBHvlAUgosjskVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RReTv2IeghL7f7ekP7xarCiJKVBr+rJkwmvMSsIbZBQ=;
 b=xGrz5sxx7/RMCepJeZ1o8FTB9mgoKARZin8F0dSfxO63Ng/1RSDp/1QPYffj2CdX0U76IOGS5XGLn0Do+gestNM3bCiOxKSwPlEtyCF9ogLaK7dGizYMttfAwny/6hBDh4SSwsk7EZTokr1TtR/vWf6BEIHqZtQMTVnY6PncFPE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPFD1D499C15.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7d1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 15:41:52 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%4]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 15:41:52 +0000
Date: Wed, 23 Jul 2025 16:41:50 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Barry Song <21cnbao@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] docs: update THP documentation to clarify sysfs "never"
 setting
Message-ID: <d5211214-183a-4a13-80a5-1434aca785f4@lucifer.local>
References: <20250721155530.75944-1-lorenzo.stoakes@oracle.com>
 <35df32ae-dc95-48e1-bdb1-90f17bfd4d5c@linux.alibaba.com>
 <CAGsJ_4yMLi_+yxJYebTbEALujcVmeqbfHh=ArkZRxMwE+OBWgQ@mail.gmail.com>
 <a7062d0d-804f-4b9a-ba7f-62d67064c584@linux.alibaba.com>
 <CAGsJ_4wvWZwG6agXOzDoYBD_vnN6k4TRJjhFfR5dw5pQrk2mwQ@mail.gmail.com>
 <c071c478-c6c3-47c4-a504-b1fa650d528f@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c071c478-c6c3-47c4-a504-b1fa650d528f@lucifer.local>
X-ClientProxiedBy: LO4P123CA0636.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPFD1D499C15:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f67681f-a527-4c43-a447-08ddc9ff71ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9H0klEiBbCgiqnjK8AVlXDzFIvn5hpi/g/xm25gb1FuB10xOaJXd37cinakh?=
 =?us-ascii?Q?HgtHi3dpHO6Ub71sEw6QtwriZ6FneYlqG4vvaJtjrcAXTY+B27zOe9j6p087?=
 =?us-ascii?Q?2Bc4jyBdU8z6czj+Ny2mV2Vc+7kngkmb3uuK9raTgZuBNLcTIEyVN7ZgqCYQ?=
 =?us-ascii?Q?zrULxpxO83xDegQaV9jKjjlCaKeXNZCeTX7FIGukv4xzGTIfVcoW1DkcTOo5?=
 =?us-ascii?Q?62eN2V+lVSqOECYCqvyYcsdtfMX8jDR5qUNIAjJ/bVldwv9Lsdv4ZVrYKvK4?=
 =?us-ascii?Q?49/x4LZMSvNxZbvDlEm1+TEVHwLHNLa+CFKIhY/NTYs76qPStscTYsvift1o?=
 =?us-ascii?Q?/d3qkoGh2jceyPsG7nCBHs3KLYbmiXeOjPJNpJxFOmvfXNyICBxcBh5jyauY?=
 =?us-ascii?Q?Vo2ZPg9CbQdExXMvqInsQXPliQc4wQ4KSQexkOkpiagFCVfH7TcRAP4VQgEq?=
 =?us-ascii?Q?rEFL7PsLgx+NKrSvUPQb7KD+luCkXuV7o1gC6+eNN2oSLep3JeE9a+UWBmuk?=
 =?us-ascii?Q?N/A62EkiDvAzL1iwgF85fQMUaA4m6Ef/aR1YXRLq081d5ia+KtXC4MONsmUg?=
 =?us-ascii?Q?5331fyj8dnlMvEnbhLgOT/DvyasM7Me1NApQ3C8NgvRt7r3m8K/Rdppjs9qc?=
 =?us-ascii?Q?vc2wg1cXRsXIo3BuXFZ2c3ZR+brduZ0mI/axXWyLAS0sPwC8oSotdTs9X3Ie?=
 =?us-ascii?Q?2x7ICUmXMRsgGmHKSl9py/aho/tLPCSiPd27lAZsLw09UYV2RlIxAWIEVCc+?=
 =?us-ascii?Q?dL0pVjjDAtIHRkc9d2asr0fKB1uNWoiDSBDyYDsjh1wZVXuibGSrInMAfr7Q?=
 =?us-ascii?Q?PUepNblT0kgrX/VnEqIM+BBbT7Ty36qVr3uZetcyZfT4q3tVa2y/JH1cO033?=
 =?us-ascii?Q?Rle+E9AYHSbwP7Bp/1+/RmBitAXv2A1rLflhxxT+m+vZVmItyTwIANRExQ52?=
 =?us-ascii?Q?kTHwk3irrxYqh03SYnx/GJEWYKOuc7UnEqPofOfL/ZhAC6PDWnm0uybIK52S?=
 =?us-ascii?Q?ZUhZFXHF9L9ZXo0SkxN00SSuSUPxgJYs2dU7X4nvul+CKYvrBYEjWdfqNDRb?=
 =?us-ascii?Q?J4n0uuFZBFrXbxcFbevgf3xSpTkqDNEVvg+0Z2DBj6I9wLgFSfZJ6HKMzIYk?=
 =?us-ascii?Q?QBm1AnhFXSkdrzG4RPh4CMpA9GD3QAVPQqoL5fC14w77bJDUdmbl+2BsARR4?=
 =?us-ascii?Q?pgq0wkuOI7k3xc6C+ALXqRsxYaQ3vnHc56YECMgcSLRYEBzAF/sLzygkwtsd?=
 =?us-ascii?Q?uexrI9fhdeWIBuJMBdb2gYK7tTVxA38CbKrUYh3b1wZM3FQQ3YGvlr0dQdTS?=
 =?us-ascii?Q?AYdBlYIxQiyDkSmV/Wi6X1MkN25ife6sOYpmm6Wl6OjSMZmsblfoDIZ+frTQ?=
 =?us-ascii?Q?h3smpp2KZG4YMz9bg7dEzm8prvhE9exrWNqof1+aZiyWZs+qvWUpmDPQiS/+?=
 =?us-ascii?Q?tZhNfN7+5kM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/UiBsApRt6ycxY0CYce3gcaSEV4HD/HcqdH3VgPUJOHhA2goLJwEpBzLhx5b?=
 =?us-ascii?Q?uFhcQlAoZTttPsSO3059ykfm4Gpxf4nbxUNuJDBDcEC/ObM0WaE0qXtSsqWq?=
 =?us-ascii?Q?AAUYTQRzwOVbbUrf2i/9N7GzyuYeqj0+zqkAjdCMXzOwYz6mTeOco616CL9w?=
 =?us-ascii?Q?72Ragktl8mmm5z1V6lRCpqZN0qE198RzIxzGGq+V9Bu30QlzqozuRGcSv5qs?=
 =?us-ascii?Q?B1X5AsvNtBwX1IsYgcW7XTxuYTib9qn60nZ8Wc8uw+QJ2qiAR7dzDe8z3Kg6?=
 =?us-ascii?Q?gLz/DbqQcZRQZQd60AKSbr9atuhpF8/ZJmfXsbzxCfuiQdgvKDgMpUK1iBeO?=
 =?us-ascii?Q?lPUBSLfOjNkAkIsrCLk50n7djyGAGXMr1KqNWuZEk63BJu/iFElB89iPUSwZ?=
 =?us-ascii?Q?hUStAXjpcamwVJX8663tR4won46+8NNpskcBmHat/m8XFrlI/m+tkA4pEBpL?=
 =?us-ascii?Q?Fhzxv3fpxl0zviZBR3nXtwKBOmnqo9d6+tPX5v0d+FCIa5XG6TrNeyZwyd00?=
 =?us-ascii?Q?ix6xaUgmpZB46a6reUBxqia4VRTmQC63Otq7zmidRol7r2Ulv16mh4tmzY+t?=
 =?us-ascii?Q?MPMfrXWSKtIzPFHxLIrlzsY+XiM8SfQQnuOEzKtviKsku6OseeKGE9/aT7x+?=
 =?us-ascii?Q?mo3f91Hnayw5ka/+ps/pMQuEI0Ej6PKxrAGXyLlgDIzyDehNA82eb2xQleGV?=
 =?us-ascii?Q?h7F43PambWrauttPN/o5sy/yOy8U8UzOHRyVdOUonTeJu/w2PxZLZuH46lIJ?=
 =?us-ascii?Q?T3uzlwtIwauX8bnt7U24ONI4N0KocLcUM1SQ8o7x40rDOKt/WXMAVjq1FgsO?=
 =?us-ascii?Q?vh5ED2aqeo2Ba7wAG+jgltsP1pSEr3mTBHYmgu+kisi7DZahJJGvEY7h5uqw?=
 =?us-ascii?Q?UiqkUEcBWWYCqSrimNn1ANVYKyNdxgEPzs0rmdIVQEz0xmPOognVCEAssuy2?=
 =?us-ascii?Q?Icooko97TBTbxA6X3skRd6dxA8h7r5ib0fHwKAV+W0D+0ZXCjKLtElBlANRO?=
 =?us-ascii?Q?NTpCsoRb6ukyXdcH2TyqqBlMlou6/JTxRCyFhYQ+5ydHoskjY5fF7qHEYRC0?=
 =?us-ascii?Q?EWYwL51fivfB5XetAsUaKQbiuQ1YcW2sUeKnT52qrxjifqCmT4SJQinxPK/G?=
 =?us-ascii?Q?ayNqNN5ZBGfaSxWG2PpKsqTg5xwBB+t/7twTj8DWqf5Lj58/boN+yHkyb7/e?=
 =?us-ascii?Q?mebg0KSdnTZTsa+qxHs9ixFhp55NXWddaj9D4QemfOxZMmpw5YJJjpINiZAB?=
 =?us-ascii?Q?1kYLIe+03Sd25TUg+HOXdynpU/ctxwjDPIdSM3X6pkVoivNcwjUF01hGRJPr?=
 =?us-ascii?Q?4mEguxHb09o078TkGMz6J0OrqxbKMuTNV+ZBMCIHpSdoMTTTxJ6jsOC0kVYu?=
 =?us-ascii?Q?ILARBorhweQ+SBJCjpYzK/Aj3dlcM3hC52/hG1YtTT0LPDtkWTk41mthhZgX?=
 =?us-ascii?Q?DUTKLUGsOP4wqdR3Goi27iMRV6KRJRQ2rfH5o996TL/eHhqFYzA52gfdSMIE?=
 =?us-ascii?Q?FBc+XcIUZC9sRz03//n2/s2XvQfHq3Twk5JPQncUAOA3XhFUSHjVg+mU9a70?=
 =?us-ascii?Q?j+v2Q3QvP32k/V8sv5RnQohjRa+PzX5dMlu0iQ26ONmbJBz+vsGRWxny5KqQ?=
 =?us-ascii?Q?og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7OFVMYCEWjF22mj6/7eVsaiGP+V0edf09+nP+GqEcgxoTIfMncYJXaanULVkir2mVRZEPw2e1br8KTIwP3D6eBcU/IWY/rzcnI83SqWJmBVEIqA0AERWyVeVbcoUeayAiT9YjKWDDPrHn7xnw6hcZAKdNbdyR0lx8UAco9S1qxUvYOdpdialI/BaOqJKVwH1qXwraN9awptTOW/xop/byJ4vhPnjzJnXUbABwAxjlt38df+BzxaaR0KbM/xRBfSNsD35q7bf/r9iYUXOamPG94aO2I9cI+6BaRpqjBKi3EFzpejU+R6FBuhFFsL+gK256I54Ui03YGF3ZfEarEQDTmnrKGs7keOVedmPakEMd/BvLL86n2Zn3WmJqa+cvel8qQqEVVnOWq26cq7/+3nIsG5ikeIa3VEsTHPhwAaWbflqmfF35MQyx7PehkYjOMfqxVU4GRuirKc5UqzcClp8TiMtmXIvursVc+DnFF7JTskvlFi3Eo0G278ag2z4TLgAJmpqdiUtuTUxc6fDR+i0xPnnplZ18qJeWbJK7N48ovLnFfo3yCYCszt3+abtYcFNv5QjrqXJWqiy5QOnr+QJ221/fLZyqz4HW9ug/w/0LwI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f67681f-a527-4c43-a447-08ddc9ff71ff
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 15:41:52.3556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KaS9nVYqfHxqMrGtQ4Rb0/BPEIS1mq84Gfw9H7cXcWv230JvmIwzErFd6YkykvCU8hnFQVIA/r9wU8QfZVTKos9RBP88cD9XLSoJx7Y5qM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD1D499C15
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=870 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507230135
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDEzNSBTYWx0ZWRfXzc2Jfl5DzT8c
 DPZjKc72jSxLA87HHEZrrkxIDL7ALXw0WEjDBa9WVHNF7JgjqE/7Iv7uC5xbtGcw14d+PpMcAtg
 Cg8j0oL61wdm0OJuVM/mEWCF7wVnRRMZss52Rw/DRlxXTMoh4BA5HCLYlCBEnvoxcnz6dxpWWo0
 Bs4PSNfND5taKtoGa8DI6T3MGR7guIEnn7jW1wbGmFx7hBM/wjOWIi1r2rhuWmyiTwxNDJHiAw5
 /mdS3vRXOjrFpSxhrBPG6cuCZCdAK/9FPuaDWZsu+Ivb4Es8vdLjYc8V78Xl/ALs28iuLPSu4+C
 wgjBT8nE4lxOFhRUu6F0OcVfuKxFJ+srnF+fIrs2XTPQYEIHA9vpN5moE6mLxZid6ZJe4/jlwtS
 ZdiiA3CihD1DLR4/H81zy8WnD2FQfxJgXyv+JbbGUMfDHozdhpbgzBCg3x75SUUIw6VKi2jM
X-Proofpoint-GUID: NllOnQ10J6BdXXUYZ9c6A6noO0V65aTT
X-Authority-Analysis: v=2.4 cv=IsYecK/g c=1 sm=1 tr=0 ts=688102c4 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=WBmEIh1BeXNLfXCyMGIA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12061
X-Proofpoint-ORIG-GUID: NllOnQ10J6BdXXUYZ9c6A6noO0V65aTT

On Tue, Jul 22, 2025 at 06:29:15AM +0100, Lorenzo Stoakes wrote:
> Re: man page - I _do_ intend to update the man page as I find it far too
> vague on this topic currently, so that patch will be coming soon.

Actually:

              MADV_COLLAPSE is independent of any sysfs (see sysfs(5))
              setting under /sys/kernel/mm/transparent_hugepage, both in
              terms of determining THP eligibility, and allocation
              semantics.  See Linux kernel source file
              Documentation/admin-guide/mm/transhuge.rst for more
              information.  MADV_COLLAPSE also ignores huge= tmpfs mount
              when operating on tmpfs files.  Allocation for the new
              hugepage may enter direct reclaim and/or compaction,
              regardless of VMA flags (though VM_NOHUGEPAGE is still
              respected).

I think this is clear enough to require no update.

THe confusion arose from the doc page seemingly contradicting this. By
referring to the doc page which now makes things clear, we're all good! :)

Cheers, Lorenzo

