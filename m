Return-Path: <linux-kernel+bounces-853048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D0FBDA8A6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 840634E3E63
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E683730275C;
	Tue, 14 Oct 2025 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ujo7wo3J";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XpRTwsWW"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DE8770FE
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760457465; cv=fail; b=PyagoJ/C4cIkGtcx+AGMDgO26KqhYxEOHfz8agnv+Ku7cAHo1wO5VFP+S0HggKr1QNvJN5BSm8ykCpPAd12Kf6qxBS0T8x4eYsKfET0S9+Q/JK1w2VyQYPxoFbHJn8q4rj4VjN7311t1QQ8Yb+1ONUf7eSenZK2YrZFPZNEN5oM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760457465; c=relaxed/simple;
	bh=9rH3SP4ILImYiPqoDp5QUO7YlMcZEKJhserFzQyoIQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Oc7JY5BxncTV3DPnk7BxlrAy3YnkMRd4Lw60orR2AeoXUbAlzWkfXiUoPacMpKDnH1R9tiNANTJnvUbYxyEgAuq2zmFeFGcC6XslyjNnIK12wnvL03InYTkMgq1K0gErJd5vL46SGIA9hnccDhk7owZ2K52xGOfKo1insUsBFJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ujo7wo3J; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XpRTwsWW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EEfR9p002094;
	Tue, 14 Oct 2025 15:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=9rH3SP4ILImYiPqoDp
	5QUO7YlMcZEKJhserFzQyoIQ8=; b=Ujo7wo3Ja0Z5ArSdJ4q0XcmUhdvGbZVRUv
	Xq8CtjtAeawGshgqm2XRqTglZZVuTAG93qdPrRlMEZ0hOKLAz3Wg1v2PsuBp4ijk
	iVWeOS103DQ0oaLloIKUTsZriy4oTNyGmG7pFkZz5u0P7pFISY6Nv0qHUnRIB1+P
	rFb+lbh/JKTkUbgthnDP2EKoE3vZ02bDRZ8af4TNhMCC3stw/CQYWm6QiwU5ooR5
	pRNsbXXHzlnND5h6MelonuuK51IqWOPAxPKw7yc/PzrPnadX4t/dN/U6v/OTRzr7
	KUfMv68QrjotPTbA72oa0lv9fGKcCXVbr3j/ynraQepCPRAMQS9Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qdtymqd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 15:57:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59EFJfoU009784;
	Tue, 14 Oct 2025 15:57:21 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012052.outbound.protection.outlook.com [52.101.53.52])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpf4jfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 15:57:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVT5Slp0isqEv1FcbgRy4ySgS6npB1Pl/BQzrPjv42YDAr/qatamungEkMjaLyyrp6+1qdKQAKpcuPlljT0jjc6y1T1bYOaoYYu1Kp40sX//Z+lto1OoaURKX6400i5ujAz6vum/wkZ2hITZYe8aarEUzOvxZOBz6LLNeX21yJvEXccbHOF5TedAGkxGRZg9tzUd/vNAqKwOzcfiKb1/XcQoRRjNXF0IsBCxcwajwDa8kGEiCfhnCbMGjAm4xY/KAUQUUtNx67RsAszTGuOlB5o0cYx6gB92TYwCgxP9sP+eqqjIHNmjW8FgsSUN1z1mN82zXhSABOk8mqU3rZIDag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rH3SP4ILImYiPqoDp5QUO7YlMcZEKJhserFzQyoIQ8=;
 b=jxTjDmbqdrNTSq/NFCmHWrHmx96Whj5tzle4GoitudmnFmTUjBNnWcvjzFVV3aUYUE5p/nrRmy9EIHt0hVG9S4W5a9mMYfXi5kQir9l9rmtOT7XmNmU2OTLQZG+7CITPUwOpbZlSAi+/fx+q4L5abywPtub9VV8ex/cCUp9+OIaYDtajqqJODC9gWk9QRYyjZJ1aJ4kfQN0edilxntNIFu7qUWVCU2p51j+uA8+zLyXJWbf5R4TIvXOjcuGPKtRbh6Wnu5DDWbktHJarJzMsOCiuYP3FKS9QWnGWOqWI+RFoNBfWWN1SJUO1kOnl7po7N/lALLmEPWDKTYEg03r2pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rH3SP4ILImYiPqoDp5QUO7YlMcZEKJhserFzQyoIQ8=;
 b=XpRTwsWW/egQ9Ix62GHzUatBeoZIm+i8nZlCNAmSqcLhjyNggMX36c98IUuvShWEe6eNsE0g/R9eLaaDOYr2ZkmwNulHLQ6Ftye2yatu8COteqNM+XAQmDn7djyrmmpWGWpuXCJj8aG6E8bbLsJHSgSCXDyFiC6FpUjKErg3owo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BN0PR10MB5159.namprd10.prod.outlook.com (2603:10b6:408:116::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 15:57:19 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 15:57:19 +0000
Date: Tue, 14 Oct 2025 16:57:17 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
        Liam.Howlett@oracle.com, baohua@kernel.org,
        baolin.wang@linux.alibaba.com, dev.jain@arm.com, hughd@google.com,
        ioworker0@gmail.com, kirill@shutemov.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mpenttil@redhat.com,
        npache@redhat.com, ryan.roberts@arm.com, ziy@nvidia.com,
        richard.weiyang@gmail.com
Subject: Re: [PATCH mm-new v3 1/1] mm/khugepaged: abort collapse scan on
 non-swap entries
Message-ID: <24b12296-aa82-4269-a9ff-def815c3cef3@lucifer.local>
References: <20251008032657.72406-1-lance.yang@linux.dev>
 <f33735d3-b38d-4b6a-aeba-b415e6b24ea2@lucifer.local>
 <0bfdbccd-9d4a-409f-ae43-b44bb7347d70@linux.dev>
 <f7392f43-b8f1-4e6a-b9c8-25ad8a47f82c@lucifer.local>
 <d2e5b099-94bd-444d-9946-182807443539@linux.dev>
 <c44e198d-7d46-491e-adc1-86cc306c27db@redhat.com>
 <b35b649d-5566-4467-8222-e358439b4f84@lucifer.local>
 <89d1f871-54e3-4c66-bd93-e8a08ff640d3@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89d1f871-54e3-4c66-bd93-e8a08ff640d3@redhat.com>
X-ClientProxiedBy: LO4P265CA0171.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BN0PR10MB5159:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b033506-5857-413e-fe46-08de0b3a5aac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8UteV6TQpI8LQ/H7bCGYSOE02ejRTVdAlfVHG+XAjdirWvLFYW+6H4sd9fpH?=
 =?us-ascii?Q?aLrX8DV58zDXPkSwiA4iVeQ17aSrTlVLg9oXs7GYkv5kuM7KxfmGJL38Oay4?=
 =?us-ascii?Q?QVEGYj3cHdSebm5UdT8vYQl4Pp4cRhor8GVGN6jfCOPAJ7Q95TL3GuAFnHtQ?=
 =?us-ascii?Q?S3nl0OXoOyuQfOCF4K8TdhACtVKnV2a3P9XbhgC1859iNGRz2GExphOyQWNV?=
 =?us-ascii?Q?tMMRLeBUNE8g41d6eYroOyK895DG+VDJGCE6m+vhK+WsGouR/kRTC+n82gqf?=
 =?us-ascii?Q?eRKP2aOj/2LXfWlscFZF+/fWHJmiLj2RzAu6Pcj4GPEh6BMB7YJA0rdLlaRD?=
 =?us-ascii?Q?5LI7M7mUa7zdX5MSGJMLIkvPeZjD2VJrRzPa8d/pWDSG+DdKSPuIja+LPr6w?=
 =?us-ascii?Q?ya72KZJH3bp37Ug8q2fQza+mJ3f4Q6MOZ+d4UblCFWAAf8uJy+JJtjlug0W7?=
 =?us-ascii?Q?uuTFgNqLfqEfVj5uv1t2aObTgcfYnT+ooqmoxCEW6VtSz4qk+6ooV212Qwcx?=
 =?us-ascii?Q?WqSRNrbI7SJic8FAz6x/8ZXboNIZkZnGng2g/toEysX6ygRF7EfjcRJM4Q7L?=
 =?us-ascii?Q?lq5hQf/25mJD9nlg5BE6A8qeXZX8aoF60WgwKNzEGkDBu6IftxzabfUhjmnV?=
 =?us-ascii?Q?m131ZywfpvwjMMbrpZyxNYEsVN8Aam5gfQUxtJ7JAVGtzh2BWeIrfeBfmJuF?=
 =?us-ascii?Q?77pC1sMfh9rA2L5jL8ue0rTz3ZYAApAJ0+Y1q68SAH7tjnauKP6CRhauOMQJ?=
 =?us-ascii?Q?7TFQKebW/yoqmkfIctuKhC4G/LBEkmAWF5F4Oo//iIDGxW1U2NaO5vGjIXgl?=
 =?us-ascii?Q?bedVDXKxT6SmaELt6X9J7EwtbZ0mkOitTfpFr71KmW3v0Yow1A3cl83c0ZCX?=
 =?us-ascii?Q?V67Qfba3bEaCRvgCaNFeLB9tJqgKP4XAN/61emFPO3Js4aSF4HhJ4ORb7gRT?=
 =?us-ascii?Q?d0cAQCZeGFsRFZKbdL93Rr6mF3eXYAk6YRs7BV+lmIdfwtJ0OAmF8K2fmol8?=
 =?us-ascii?Q?KR44mi2euN566aYlOHnNSMDRLGuUz0EF9T6N0RH2gJTT/4e3WMNmzQt4wxjq?=
 =?us-ascii?Q?Pczx2TlXRugAiASfhxOYvR/d9Mj3x64HuCsOsxlLc3S8H5O9EM11EDoEOMth?=
 =?us-ascii?Q?HxM9sBEvVLnxtHR4DmiDdWWZoLd1w3hJNHVuAqBCjOhjPE7pmooiv7wJhp9r?=
 =?us-ascii?Q?rF4EYQ2ZlFOqzcVKJbpytiGOp/5h14QTw1Eo+iJgQv7LmXaeJ8cty5sys5fG?=
 =?us-ascii?Q?K8SVIqM0+y89wcqMzmwxova05b/eeqdUbnd2WfpoKdNKREDvMuF9g2WZvyOI?=
 =?us-ascii?Q?3B2IK7TPZWRlWk1vtrhYZr4OXGVukAv1K12+36mpv7cFNORj9rUNKoxNMis3?=
 =?us-ascii?Q?WIoAYm+1bImaGKpNJbqk3/NLfAv1JljeO6mfhlRyFTyvzYNsmZTvsBlV6pS1?=
 =?us-ascii?Q?kWas7w2WFZg9a8iDbkiZy58HZWc29YYy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cg4ZmyhTKQ9gcpaWPUKRikdbpjnuKQHA3tFHx80OMV4yvh61+/tNdZdaS4sN?=
 =?us-ascii?Q?KF/zKj+Ecj4h9rS548fbGF3UD4o6b3AsAc14ikmbEH2XcE0PoywHuf5xqHGl?=
 =?us-ascii?Q?6ZTKXTVHLDSmIm6dqennzXyD1yEEYb8iYpdqqvba/BcdTc/T+TucWHDmyWqX?=
 =?us-ascii?Q?cRGLWGktohA/pG0Tvu9xN/vl+lCWw6JV/MjN5e27hEtcTgPDncWWRV4wX9wV?=
 =?us-ascii?Q?DVtL8hi0XCCLKFYJOGCdgqjGzoY5PoACoIVR+1rqvSqHJgViAP5ktczte1ir?=
 =?us-ascii?Q?eCrLS7tOEBEdV1M6Fe+yjS/nkQAAeqXGGAg3SZMGU0zuxQkndulPQ6lK/WUB?=
 =?us-ascii?Q?A6GNxmfKDw0vV2QqzWiROLbcP9m8usA8hKd21N19BDj10E77ERmBjyuu85t0?=
 =?us-ascii?Q?Bvl/SLXzZ261pxaO2qRfu6XalbRSgiv0dym4fLBigywRIJ6nUGRa68lFEqW5?=
 =?us-ascii?Q?JTlZjK36W7E2dKW8ZXTM62+LXG1AdTUAFvTxC4IxLBEmMX7uT1yD22j4WXZs?=
 =?us-ascii?Q?0kr2zXt1Ryru3V1g+EYJR4xCwQO3YGmAGOWsYYyeubgb780xgezJbfp6qRov?=
 =?us-ascii?Q?ZX8sKvfOvCfaJ6QxSIs8qo2HoIWPXRxBP0hV5EsYYZnze5s6Lh0XE5rmnMQM?=
 =?us-ascii?Q?42UoJw8TW1UqsD/hutaahcbd5R5TyuIyLfw1A+ooZvdY6b6gVnUdQbj42mpp?=
 =?us-ascii?Q?P1QpvZ/qQfAxng0dJGqZA3Z0vbt3oURc1EcjXXEDge84SaIW90BZ9staESCL?=
 =?us-ascii?Q?lWrWBAaEPEAYATwzhy3iFXIK9RBFr1EQkY5TWenioeXVmYVsW+aaK1w6jezn?=
 =?us-ascii?Q?YLnQLl/a3BiaMtijdnadsGlPejf4DX8/o5E8mfYqsatZWscxDrfgDdRVApBK?=
 =?us-ascii?Q?ynlYFoqH+weiWjxhP3it0yf7/DaIjVetx5U5spXra/o/KoVEDeyac+1CHFeV?=
 =?us-ascii?Q?Isb1b8MqQnRlf/O1h/9luhnvxwpUF71MmiwynHDqbAU8bE5JoeyjzA5A7iKR?=
 =?us-ascii?Q?RawQCJ9VEWsglq5GUOTKFHW9CA6dg976KtKFbm3MU/zDwq9E7E/EuISnUeuS?=
 =?us-ascii?Q?aIc1V/aL8L2cz/6f6ZLZSY/AO1sb0lXhXOl06RIFkrP0NfcKF0+80InA4wnh?=
 =?us-ascii?Q?+s44n94EikMkYJ3Rnzoy2T2wTQiOIbsKWQx3p4sejeaGxredUg5ReRLvtv85?=
 =?us-ascii?Q?iTmA3omYLQWfkgxFR50DJK6XEDgn4cNcs4KNTi5joWWG6tKQ6DYIaHj41lyv?=
 =?us-ascii?Q?s+7N7IU4UZeEPhVHJ2lXBg5LKLM+LPmWacQFlEOHOT5xFgbWeaJdw3k894/q?=
 =?us-ascii?Q?41ARHic1Qx9pvKC/DpE7BwTyWIgPhztNvMW9c+J9kKdTJ/NoN31v/cgsvipc?=
 =?us-ascii?Q?7D2mfF6zIEoLXbW6nsNBaMSS5lb6ACtGloAX0cIR9Pl96fCWmhznTY95KE5o?=
 =?us-ascii?Q?v+1uIcKESrBm+zFDV5oA0244fOMPKw1k1FP+V5QSl3izp+0yc8862FTCSMpX?=
 =?us-ascii?Q?aAy5broyX7XCEFuRlYdUzmo53yb1rLgJRKd+Y30xWxpy/EOI2aHDb+Ee1zki?=
 =?us-ascii?Q?TTSKNpZSkopKcDbc5JKW/zPjLpe3UAX/fcImRmzngrQhtEXvJzg9lfeZ7T6K?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Fyd7T0yuc6Wk/cju21EaOW2syqSo1A/gdSzruuoFt4H39xExVbKvF7Q/5C+uBPvTiwjHpxGuD7Wp874lJ7P7nadzEgWY6XjMHc/FExCePw9qOWL8l7VmqdBGCzJX4pZJIj/EYY3/vYZicELx/iK5uBBLbydCMZo0Rs4rWgVgM7y1UFHv5967cd5KeBo0STLC3cR1DRt1GYMeI9pIAOkhHccMC/tOFNlra8R+fer5mXp/Fg0ht/JdcgExf9gdfTaCu0kTWlQLSxWCwonsg70zXM41oAXAg1vF9v9JXs79hPEKpCS7A9HLnhWZGwXSotVTh+J8aL5Bmup3iZstCmrs9B8Z0Xk5grKvW9Ix8ejbUR/MKcjmKXCizztNAJ4dIp52MQd56KcCmKmpzJpm5wfSZVGzQUF17uk+9GC1BoA/imyFtVfUUspHqSiKOdWQuaEz3wI5PX8mc5PDK2FAuvJUow3GWEMV/wK9CXePRvOkhckaK+5+WRyEdrJ5rXxrZqi2Mwt/dNZoeHz7DiLITAzQ3Z4ZGH9+5VjIM6oDDMvQhsOEijjiju6M9W1l+r3MQ+LwAo5n0PHjAXHyGzzhjF/X6RmJPNr1D3hT31j7GqBo53Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b033506-5857-413e-fe46-08de0b3a5aac
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 15:57:19.1128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WsV301Ea32dzonctoo9o5flkvHbQpP01ZuKX8S0+Ew4r4UQyvcnfaN/c+Anp8kFkrL5GDNr2RTfkEvaHlkEpMIVVCo1lmPaiA/mAHFy66uA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5159
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=737 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510140120
X-Proofpoint-GUID: B9gcsRYsqcn-PME0VysZOrRD9m0z4hP5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNyBTYWx0ZWRfX16352lasQaJZ
 TY2OMQj66vAbSmHuwyTSA82Mk1i84U7znKw+3PnVtBGFJydVNWDSA2+5xy8sP0dndcfeq6VDPWL
 eUguFfduUNzeie0M1uuxCsyhe8N5WUlDrK6jUI16uDf8iLZKQOWSCvCRBCbWy4amRZ0xL0ViyXX
 rSRcDpvsroZFMkzuK/AeH0rjjx9wt6eB4AK4ZXyWTtkNMJB4lSJKkWb9jo6QnS9U/FvBuiWXg9W
 UiuVWTvLDK7fGrXnPkvIK4NXC+1iqXBJrg3Y2QRBA7mWGBn1ALQ1w/F9xYMT/tIAp2z66QkO+Dm
 KlO9nUo7zDFyu7X64u26Vxo6jydYRF+ucFZexR3Lo4KsjyaqOVehtZHLLT3skJ8+oEyjal7/DVn
 qunUzciZCipH5R+qJW93VJyJRILvEmxJeLSBuGel4FsniHPT85U=
X-Authority-Analysis: v=2.4 cv=OolCCi/t c=1 sm=1 tr=0 ts=68ee72e2 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=lWvdhc1y6eYD6KExIKMA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12092
X-Proofpoint-ORIG-GUID: B9gcsRYsqcn-PME0VysZOrRD9m0z4hP5

On Tue, Oct 14, 2025 at 05:48:04PM +0200, David Hildenbrand wrote:
> On 14.10.25 17:41, Lorenzo Stoakes wrote:
> > On Tue, Oct 14, 2025 at 05:12:18PM +0200, David Hildenbrand wrote:
> > > Can we please take a step back and make sure we are not starting to do stuff
> > > differently than elswehere in the kernel, please?
> >
> > The code already had the is_swap_pte() check in it, so this is not changing
> > anything, it's just avoiding confusion.
>
> Well, in hpage_collapse_scan_pmd(), in __collapse_huge_page_isolate() no :)
>
> And then it's called SCAN_PTE_NON_PRESENT and it all starts being a mess
> TBH.

Yeah ugh. THP code is generally a mess :(

>
> But as raised offline, I don't have the time+energy for that today, so I
> don't care enough.

Time, energy? What are those? :P

>
> --
> Cheers
>
> David / dhildenb
>

Cheers, Lorenzo

