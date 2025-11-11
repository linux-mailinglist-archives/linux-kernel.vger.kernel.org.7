Return-Path: <linux-kernel+bounces-895016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FACC4CB9B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A22F6422193
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C082F60CC;
	Tue, 11 Nov 2025 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C+HR8Wp3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VEKHqN+s"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CEA2EBBAF;
	Tue, 11 Nov 2025 09:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853746; cv=fail; b=nesHZCouFuWYRJ9YYFQK65MYmWdWfwQVtLlrxoJwKfTF0896r5XG/WdJeieouni+e2LLdHbnRPOgNj2OiSvLss+IsaZAcbW+0tOBnuIzoQ2pXPP5MiKz5KJ4YR2L+e0um0wGFdtzrNnTHoli05n/N9p7+WyuP+Z6diAVGyyGXKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853746; c=relaxed/simple;
	bh=4iykQ4oOyjANoLZfFLPn79FP7n+fgMrgFIzTkqT5Oss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o80mzwtCgxKKTbsM8fMrWmBUDgY9jet3SVxe7k26HcdKS4EmloEylTnLBNh3V4x2S7D8ti0Ar2d6rjDs1EqhMVKpfdU3yKk/mce5xUlI8g1v4clHPCjLda5ns2pEVkvTKbVGbXMzCYNwkG6/8twOl5OZmBYG1UrTNqydcQjuRds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C+HR8Wp3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VEKHqN+s; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB9MkoV025581;
	Tue, 11 Nov 2025 09:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=+CeXvHQxcR7FHrmEra
	03zow4a64LkgGYC1J5Iq1Elgs=; b=C+HR8Wp3nLV409w84ODirfy6MVY2z0EuwF
	H6zkrBn2KjhsawQfSv2MPbU1kVr1tgBU3Ljs4tOUFDU5bldiaYhBSvlnS+2ZC8sx
	Z85sLJUdPU6JsRKEtpgNRu7mTklY3Z6Val+Vgw3CcsTHRuWwiC17rXMv0FutF+5W
	1aWtF0YGLXZ/nUgM0A0xDVm7eyXtHfMz+7WcrMBY0K5ReOFKMz1kljz2D6P6P98y
	eWUWoYLwYHbtmgKb4a+UYFe5Hr5AABsR7UyOQq2wWZtcKuaonOfwuGS5jvSpu2kw
	JerMd9pmuwbkb51/ltIkA8dN0Xn6lPwD1vvopX/pimjnBGudbE9Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ac1wkg2hd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 09:35:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB97GSD010037;
	Tue, 11 Nov 2025 09:35:23 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013020.outbound.protection.outlook.com [40.93.196.20])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vak23k6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 09:35:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZucR+OPH5h7SvitkOv5HN+jCFpp+IrT/IxSbKFOfC2wPoBvZoLpIBZtfp855+lWv+sesblEuhUAr9b8KsSu4hv8BKoLs+0a7VMk2mAC7FbaRpoKK+fbPK1myWfufYxIpADGwhlrSRgMetI+k1MajIEppB0jMdsaAp+i5E4l1kSZcNT8GMP1JJ0TUAo4iewdSJdWGaHKTKVqGl2ZbzpqXP0AnYm5dGsnIFC/U+8Vx+1M7wZFw86wHjYwc30kasqV3CaE9i33R4Pown+MjvfYxxhLC4s1pHifIWJ/fPWDTDMBcff8cicaJPGEw7PScsXR8/2zDwVpjLb9hALB3l1FwcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CeXvHQxcR7FHrmEra03zow4a64LkgGYC1J5Iq1Elgs=;
 b=jV1pJ5dx4+ghRJJ9tw+TGA1inMMqjB5mdNTGTVAe4E40Nfi/gCO/hh5W+e8LLzVqqXnTp49vDQRVjuicc1BYB1H+mRS9TeBPdkfBjotUF8f+ZWgmnC5dArVzg2MSlJT5IJOPoPrEzT/fUokWONdz6fS4z6Ce+FUiTfzEbmW4MV/+qdFynPaFgoeRMIMsyjQ0tKow+UB/nHKt5omOIHC+tBrRV4eCjb4WUQ1RWLs84c3iG9oIo0gkryM3/Z/H76n1Hok9aFAID88eVTrG77gHFSNCW3aj0tcxFcBVX34b726tKFTJvKKdfPH3HYxwKA1ccoyaMhMaIKYj+dqiVX7AFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CeXvHQxcR7FHrmEra03zow4a64LkgGYC1J5Iq1Elgs=;
 b=VEKHqN+sDf2x76hipqhrHbe156Jsd1kONo23UZoBZYH9KtbAHpEKghrhETYGy0Fm8HkA5CFcuiVSgOJgS0fTaUHH0w04k4e23IT7KBV+CQz5QxD71I/eSakYuq0xOM8apnRJdA5nPwwA1saOU3sTUhMVHpQpzIk7P1D0asCBCuI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BLAPR10MB5108.namprd10.prod.outlook.com (2603:10b6:208:330::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 09:35:20 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9320.013; Tue, 11 Nov 2025
 09:35:20 +0000
Date: Tue, 11 Nov 2025 09:35:18 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Mike Rapoport <rppt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Christian Brauner <brauner@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        "workflows@vger.kernel.org" <workflows@vger.kernel.org>,
        "ksummit@lists.linux.dev" <ksummit@lists.linux.dev>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dan Williams <dan.j.williams@intel.com>, Theodore Ts'o <tytso@mit.edu>,
        Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <kees@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miguel Ojeda <ojeda@kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] [v2] Documentation: Provide guidelines for
 tool-generated content
Message-ID: <8bc25747-fcf0-4e45-b10a-566c5cfe771a@lucifer.local>
References: <20251105231514.3167738-1-dave.hansen@linux.intel.com>
 <653b4187-ec4f-4f5d-ae76-d37f46070cb4@suse.cz>
 <20251110-weiht-etablieren-39e7b63ef76d@brauner>
 <20251110172507.GA21641@pendragon.ideasonboard.com>
 <CAHk-=wgEPve=BO=SOmgEOd4kv76bSbm0jWFzRzcs4Y7EedpgfA@mail.gmail.com>
 <aRIxYkjX7EzalSoI@kernel.org>
 <CAHk-=wir-u3so=9NiFgG+bWfZHakc47iNy9vZXmSNWSZ+=Ue8g@mail.gmail.com>
 <A274AB1C-8B6B-4004-A2BC-D540260A5771@zytor.com>
 <CAHk-=whczwG=+-sAzoWoTY_VOwdFH3b5AkvQbgh+z98=p1iaXA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whczwG=+-sAzoWoTY_VOwdFH3b5AkvQbgh+z98=p1iaXA@mail.gmail.com>
X-ClientProxiedBy: LO2P123CA0099.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BLAPR10MB5108:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d5dc03e-e58d-4682-c9d3-08de2105a1b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DFJ5BqhY1CqXIkCPo0z7NWc+zpnbMA4J+A+jg/+kWVCq8Xk9SVjt7JRA9qjW?=
 =?us-ascii?Q?t3w2uao9mY1urOsO7tXTEXNQMvA5rwCOCy3fnppYEO9AJahqmDbJ3Y7Z9wpx?=
 =?us-ascii?Q?kpXaikSuPO7l8djUDoY5bywr7RO2EokPxnjXFHDk0PdYrbOpKEZFEh6bOrmm?=
 =?us-ascii?Q?LIFrNApy6BOd4Ad3AoU8i1elXZnRC4Y1YwLzrtW5rMEUvri5Xx2CFMFzV0Lz?=
 =?us-ascii?Q?LnMRct41Zyk/qnInzV5usz0jU6+MIkKFS0iPB2y32pz/b0ejjG0I+nrgTkAr?=
 =?us-ascii?Q?/5up0owik9xWgPuVoqEXBcMGn2u1tvqmtlRojejgNaL0JqFgXGYekigCywAc?=
 =?us-ascii?Q?hp1siAjBH6JHg+GF9CX5IDo505gfEPuNPJ8GRVof0N01nhkv7RVL240lKZv9?=
 =?us-ascii?Q?twKNCX3NcIAb1YRCGzcX4pdwWlIOFO3S+rs5QaHUK67pw0bWmQdCEZZH7Fcz?=
 =?us-ascii?Q?XhNUM15+ru/HHNuu4IkQVaVFk12TvPuLZP3vhnAbK2hQbkXJMEQloYl1ppnk?=
 =?us-ascii?Q?kGMzICO9wEOrQKmhfvEZQz2dd8uHu/RCfJYsS8aDYUVnS9i9+IRm1tp+appd?=
 =?us-ascii?Q?9Mw+wp4fKY+lKmdlP0+U3R9fAqFRcND+HpjgyRqwAOQxqsWK5oNh40YJxvSc?=
 =?us-ascii?Q?uM5npfyxOE69qyoryoDUgt5vvaVLw7iyHb0Ri3tBB4jqsmTSJZHGDbqpOoda?=
 =?us-ascii?Q?yvWBM09k6OcSGBzyD/iti9mKg1KLRTLQwkkl7jWrL1GNQH/pMCZXdHnQOoQw?=
 =?us-ascii?Q?ca1OF36z7F+NkonPpAqs3zOs89Mi/KdmVgNUhaQyLefm97yz0vp0gNgx1ar7?=
 =?us-ascii?Q?dA8B8GF2VK5+wVS/wj6IVvhKCrg5bVInMc2AulnWOnrmqsjLOezzzu4S1sID?=
 =?us-ascii?Q?RhAQgHgDn111ykG0DUZHEW29+j/yyb7+F9Rt9pMAy0eO25SJJ5iZMJcbZ/pn?=
 =?us-ascii?Q?T1YyfqD3cBXLlOtytHNF011bdBSuUraDGSYhYv53jWcDfjnZ2S4P6Vzf0qmJ?=
 =?us-ascii?Q?GD3kb41t8NkbK3hFcJXxMD84pcq1lIVsvL2hA79PH+56YPt+v4EwTghRO/F0?=
 =?us-ascii?Q?epnqk8n4XiJuU6CnZC9e8+01/5NcfU1A6UKZnkNCKwU36dcnT/9iiQwN/vU5?=
 =?us-ascii?Q?DbYGStYShpaGWhIEf3nYLDjmnKhv/EdUOS8NhKm5BTWKI2slVtfXzjDf5xTy?=
 =?us-ascii?Q?duzA7MFOgadqpJw+1oFgsCCvqcZeq7viHRKU+V+vYoePvxQsId9KcXkGwk4a?=
 =?us-ascii?Q?gUkp664mne3mQWiXwiAOSAjhGPERdfw24pTFMvXHvu/7XESUNOpVXM5niss8?=
 =?us-ascii?Q?rN6LDKU/sSh2Fzp+iGz2xo1Juxk74w9J1+xqhXZLceaxerHWzAVaKkfdn/BI?=
 =?us-ascii?Q?cgChs1sII8qaluMTJpcE2SWFmOGwWLmfyR7HMa0VaZ3XiyVr499I+0fjwihk?=
 =?us-ascii?Q?FGQABbMRm2FC7b+dvmAXWFR5CWdydyb/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V7rs1EpqrUNFl4Z9EXWx1J6ShOCN8CYyBgwY4dQxZpErrqkyDXHaEoEVSSYd?=
 =?us-ascii?Q?tzsG+SXo3XPSCeldwvbJouV/0tUxlLyVAWG79zAsSC1Q1SskBu8RS/HRu5YF?=
 =?us-ascii?Q?defVBaz1DdXZU38xhqwtAjFKzAAlbNDFBsnqEqwFr0D/4kV1WDCE5w6y/BaC?=
 =?us-ascii?Q?ofnxE1m3xvpTtu4UrWIWu+9JvjJzFD+08ojrsWm1juLw9pZ/PhQ6noUjXnnf?=
 =?us-ascii?Q?YlPTBrevJ6nOTK4xs0CrPYNQ722s3ILKkMVzxO14FOB8hfexsGZMVoRPhLhp?=
 =?us-ascii?Q?ZQtX3r4YYkgJ065H+cKcZNTSV0/1Femu0BhIvLipfrJsFdVxiuRUQNQZGWZG?=
 =?us-ascii?Q?l2MgSmgtTktOMsXM2bdCF+NB8V4WzOoDwXqbFU0JVBcRqpsQ/iY7Zpb8yrCM?=
 =?us-ascii?Q?7zZExmJgR3rhxgH0Tsdc36FtoD3rBVLQ8rCPu18Pbv5oQczkPNxPqz3Jv6br?=
 =?us-ascii?Q?oEDofVK7BuCjU0TdmOqRdNDrn1z6TdGn5l7aHYkrAjvuyfyvHOL2WnPsV3lD?=
 =?us-ascii?Q?OXfbiBDOhFTXTUmzhFLu0Qxnt2T1uo5ErsZWGtE6nbgxiKSEqZRKiY4IjFXB?=
 =?us-ascii?Q?6a4GENASL34M0BiVeSVPvpM7Zqs3jxO/9+HRLkpfML4tRu86xDorHzIZE53H?=
 =?us-ascii?Q?uQFXBHpwb49xN66ZAwKo5SdSnTjVoc5JJmO5C27x+wZ9aNXod8onJYXXJ7Gz?=
 =?us-ascii?Q?VgBJ8l1Zm0kUZvwMqy2r6OL4jBBBG/2xDPy+CxHcAkhS3IEj/uR/1txH7tAE?=
 =?us-ascii?Q?xTb3DGpzt+Kpsa3UyZm0Hu6mn2A4ANG3TaGVSuCyD9VTga6zp/ql7cL8JIgT?=
 =?us-ascii?Q?ganhQGez5tuzihQ+5z2F7dUrWyuL2sYK01Y4gf4pvchWBEmxphbtNpMY6062?=
 =?us-ascii?Q?SVcTKExOZmF0sKaYac1jhWLEHma/NXallMyi7KQPSzCllqr8vZwZmsgVzzGG?=
 =?us-ascii?Q?SPZsUAYPxbSHzRdPqqusqGq/B0HiUQisYigMUVllIywYCdD0B5zUBvs6X9Wu?=
 =?us-ascii?Q?FXKwOtQd6SwYyqPZJhGwLTl763Q+Efx2rq1fNyjf1luL1nRRV4Tz27cPjM+h?=
 =?us-ascii?Q?5UM6XgmvddRnVtTzNrDZiCr6TmOt8S6qbs8NMqsX7Xo8+n/TnKNHdVGsghY0?=
 =?us-ascii?Q?IsecCDZY6pUODiTvH8I/um857SufHZjh3fLkr6GD0M6FKtmw9IKUgh6okiWd?=
 =?us-ascii?Q?OT/ga0x8kHaoyC32AOfqI/1XfFMbK3m9wdJ3sAF2Y+CwcQ3/wK22j9y2uKvG?=
 =?us-ascii?Q?/ftiC2gBnFlap+zSW+rOYmP4XdXpjyD+dYOIOBL8fppOkvw4XsZkegw/u2+Z?=
 =?us-ascii?Q?wyiGSUo5K6icd5+Qkd0nLu0TE125+MsQZ3XncRHjJC7FsOw5JpOQoeP3fe5d?=
 =?us-ascii?Q?biU1qmMAPF78cs0MrYLrHljDBFCZT9O5aSybrYF3rqchnGjLCfzts7nS4Yx7?=
 =?us-ascii?Q?CO0RgbsX9NImfmggE/5cLSZ5+JD0eozZWxsvgM/31esVd7+sJP8q7v86DETz?=
 =?us-ascii?Q?5z4pB0BtnNLT9JyFSocwko3arPFmt/xQZgnQZwtV29ZYrf6sTjfb/5CLkdmm?=
 =?us-ascii?Q?4XCNgJo0SoZzP1I1gmaMpRNw81+JnaQBEsFxFAbEQtBHhAFnGmgAwPXO8vMj?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	N+vw4H65U6e0Lbo5k0qPqpnXINXLaB+X7+ErjXRxbw+Un4WXoc6/lzBliwgOUxwPbR55lFL3b4RFPJuFli484WTWgThz9U5kQsii9zEnkfD+aZDyWphln3o4DLHgP1ADCZmGD8q6qfVIaIALqhnOdrQO1Vi5l6xrTfiHqWB56tuzoNaTwjlGYG4EMWs0Tq2sLFXlqSMGgJ11SoWZMSQqhww5JCiIIaK810Ia3FH6FvzxPoscagz4dfWuZV8aByABjzFls7JAfvO5wM0Ay/ZNXCnbu240sh6yD9OOCS33KI/GfuS7PS9Lw8SlMKNJtEshZaU4a3EJ/K5fWBT9BDn1jSIxa8Dw3NEEm0d260QL36PJIGqvOgkDJVPpU4Hxorw1mzDdn8vI5rQ9RZ0ZDlIrAucAwPyDYXxYwfGNORpT67eMM8p/w+s4AtvuA36koh0Qog0/8SfVeNzh6JQoMvWSUjhZjjzr7efMTdVtX2dvtrqCZ/zNN2BG6UN2oNvZ/JCu+WfLi2erUzSJGSzaWdrfHB8OgEerkYoNT0kKJ6tul6dy8iscIvecYM4QkRxx0NYxh+DE+Wh4M3fcvhGffxNlPE8RXwqjHlN+pNvdg3XYkig=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d5dc03e-e58d-4682-c9d3-08de2105a1b3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 09:35:20.7611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eh1LyOx3QMixZAoFak+uziKhsVT4ZtNJoreba6mvsz0GoV40c9rEIRkuPycnXQ9tNjCGWJdfZ9Nryqwmhvylsa8WEOj0DE/2m+1iSg7ym20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5108
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511110075
X-Proofpoint-GUID: 67vLidcRjs7y-W0Yz8uI7j6CMhHv6nAZ
X-Authority-Analysis: v=2.4 cv=LcwxKzfi c=1 sm=1 tr=0 ts=6913035c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=LLbJ8tfs99Rqgra_czsA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12100
X-Proofpoint-ORIG-GUID: 67vLidcRjs7y-W0Yz8uI7j6CMhHv6nAZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDA2NyBTYWx0ZWRfX4TZ3powHLvbw
 jMsAI+OLbD3zFojIB9MYQ8lZ2InUrxvs2qtGrgkOzScX8IkorNQPQ8Lr4QnMjdX8HA+Kk+gzt34
 zbLCY4X+LPWEct79n/Se8YlXUJA2o3ETa2cqy0+QhC032hDmYAGj4f7vu7LNkdXERP5vO8os1Wd
 3PMtInfE+TrXIDoIieYOwuUrqz6fs7NjInJzs6DrC6+xxUslUYc7VwYh58SEiienQ/FQwgN/jta
 q2Oa101dBc4GBCu2GhYR9arXQ6J9VIEv4iyKNXnIEzcdXSILmXs1FyHEoJH8NzDjtnMEmjtlTsO
 bob70KNt6GHkXI+kNyezkjrpMUfp/DdjxraQSYATXY7hANbxAajqZG9s6EmsjyEslRWT0Zhqv0C
 ZVOmrRa0B9ebzKLHcXl7l2wx81i8U5b4hOQtgQZaZ8CoJxmTEO4=

On Mon, Nov 10, 2025 at 11:36:00AM -0800, Linus Torvalds wrote:
>
> I really don't see what makes AI generated content so special.

The thread's become one of those jump-the-shark 'everybody + their dog
commenting' things, so risking adding more here, but...

As I said (or at least hope I did, or eventually did :) when I first raised
this on Sasha's original thread, in my MS proposal, and in review (which
Dave responded to very graciously - I think the doc is _mostly_ really
good) - I think LLMs really _are_ different in one important respect:

Submitter/maintainer asymmetry.

The issue is that people can generate sensible-looking series _EN MASSE_ that
now maintainers now HAVE to deal with.

That's the _BIG_ difference here.

With coccinelle etc. you need _some_ level of understanding of tooling
etc. to do it which acts as a barrier and maintiners submitter/maintiner
symmetry SOMEWHAT (with, err, at least one notable exception ;)

Now 'any idiot' can fire off hundreds of patches that look at a glance as
if they might have some validiity.

The asymmetry of this is VERY concerning.

I also hate that we have to think about it, but the second the press put
out 'the kernel accepts AI patches now!' - and trust me THEY WILL - we are
likely to see an influx like this that maintainers will have to deal with.

And much like the 'Linus doesn't scale' issue we hit some time ago, we
might hit a 'maintainers don't scale' issue here.

SO.

I think what we have to underline is:


1. Maintains MUST have the ability to JUST SAY NO, go away _en-masse_ to
   regain symmetry on this.

It might throw out the baby with the bath water in some cases, but it may
be a price we have to pay to avoid disaster.

Rightly people don't like BLANKET NAKS. But I think we need to be very
clear that - in this case - you might very well get them so to avoid
unworkable asymmetry.

2. Those who submit patches MUST UNDERSTAND EVERY PART OF IT.

'that which can be proposed without understanding can be dismissed without
understanding'.


I think as long as we UNDERLINE these points I think we're good.

TL;DR: we won't take slop.

Otherwise, sure, plus ca change.

Cheers, Lorenzo

