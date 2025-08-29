Return-Path: <linux-kernel+bounces-791424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C10F3B3B69D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C34FA0463A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 09:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E76A2DCF6F;
	Fri, 29 Aug 2025 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L2S5C4qX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vIWobjxL"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2008022259B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756458264; cv=fail; b=SiEWbF7srhglu5JDnN0h9EHGM+2Hlytisz8Qc1xpMFmfkLgXSd+H0ViV4mw0Wuu4tk+6dHws8/gY8+2pfD9NKn9tElLN3VCOjAgq+aJQbJVktwnk7qmV70t1iAU7txoel+5N25G80TaVfK2RYnlj8H+38WRaAw+moR3/FRjEM6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756458264; c=relaxed/simple;
	bh=I5pLr+HBEh+SdTMQNK7fEEESduY3yIbBAzmW0G3I5+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MzKYVcP/xxk+vfYnP2xW6n5f1c+I8ZOxaGbRC8W8MKbi16UjCtdl2AC233mk0+wfJ/dkcO+ugSSUvNU05Rcyb7f8klg/qFGXqtmmGNunIVhOG0GSq4AcxqUdVwAdua2UHuQd0PzvVZamoOTgI88YqoRe9Uxs3COCemWa8zMck6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L2S5C4qX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vIWobjxL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T849Rw020485;
	Fri, 29 Aug 2025 09:04:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=I5pLr+HBEh+SdTMQNK
	7fEEESduY3yIbBAzmW0G3I5+c=; b=L2S5C4qXzBjGV80mQU2eg7aCB9zZpP8iu4
	YEfjDId9HXMosrj6uQpXM/Mt14T0Vw0bDY7eXFwcooY8iFVaoFGWUfZ8sKY2wXPV
	kdl47/6c1wPSRRyFe6fI3JxRQk1rQCESaFA0nAqxIhhXukqWVfioeh6qz26dLb55
	laMsc+dGu+S3E/uKCyTuZdYp9hWPM7IehEFhwbbpVAfX/6uiUhLu+Bb52hkKskrn
	S653MnlWHEb+0XF2TABofizWenn8AFiaRUn+Zj6MfWlmIxVQX9NZ9g4znUFtvvrz
	LFFzjpfD19M+8yANBXHy3qiLR19Dls57BoYHqGW+qW4WWzT5uvSg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q6792497-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 09:04:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57T82bgK027103;
	Fri, 29 Aug 2025 09:04:06 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43cs4tw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 09:04:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuSRexGgXa5sbG5YzP26QI13jUMLzPFqm6ARDx7sDfFV65/VEz7WahOuo14It90sFsJaQfwFBBAOYP6IM28ypabzCW4RCC2pCtkuHYQYh/8OTzrTw73fRBdyoZNnPyJydnvXhI1AwoHheLi2VFBYQqvit6RhJ9SjKMMnotvl/cr/WPiASCIUdyML5PpZ8RHwXDKuORLnoXAjP4q0b4eOUim1BQL92XimJxQaYS6tZZw4s502USTAv5NltNNl7PnUg9UGgs2lkbZMMG+err0BlAa0SRY+R4Tjpo4plm/ebVsH3u7K+DFrQJR7qKlDW2tqeFDN6DML7FzoWJHbidiYwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5pLr+HBEh+SdTMQNK7fEEESduY3yIbBAzmW0G3I5+c=;
 b=P1xLtEPkope4g+DGffx5fgLedph0o1TBfxcBkuvvlP1kMN6d3Bddz4yEvE8G7qMwTHq1UJURkL0eu84czD/ap2lN676jM8AQ3LXwvx4kZIbLoHlx4n6DsnpTQVVL+Yqp6xlkJm85NU+7QjnAPQgVVHMf/Rg6S2aiGkIZo9uAleqcEDKTKySkkFM7ehlUpTevgn8Sgt4ZyiadrqdbG5TxuHNt6TccsyzDs4Edo7d6aRZyJSxaNW50xq1NpJhQLI/Km1PwrevTlT5XHwBebb8Dcmn5QsGHnZtGwvuOYorloYWzWn0zInqXmPXjTOfl+luaJ0pd8c9HV/RI0raT2f7WmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5pLr+HBEh+SdTMQNK7fEEESduY3yIbBAzmW0G3I5+c=;
 b=vIWobjxLyfVYsb5wPJcAnLqI3yAJie6WqGGffkOyoP22cgZl2REpLRShdWY6W+OIs8elNtqZZGTe2n3SjadSZFLwUjU9xE+2UK7ZRttiJyJDerIKuo44IJ+hteafBKcfPY0UTVlH+asnnr9A/+bydwQkMLUPh349wLXlaltpk4A=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB6834.namprd10.prod.outlook.com (2603:10b6:610:14a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Fri, 29 Aug
 2025 09:04:03 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 09:04:03 +0000
Date: Fri, 29 Aug 2025 10:04:01 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Lokesh Gidra <lokeshgidra@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Harry Yoo <harry.yoo@oracle.com>, Zi Yan <ziy@nvidia.com>,
        Barry Song <21cnbao@gmail.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Peter Xu <peterx@redhat.com>, Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        android-mm <android-mm@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>, Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [DISCUSSION] Unconditionally lock folios when calling rmap_walk()
Message-ID: <e6b12ef9-1808-45a3-9d64-5c7fd1904b5b@lucifer.local>
References: <CA+EESO4Z6wtX7ZMdDHQRe5jAAS_bQ-POq5+4aDx5jh2DvY6UHg@mail.gmail.com>
 <dc92aef8-757f-4432-923e-70d92d13fb37@redhat.com>
 <a0350dd8-748b-41d5-899e-1505bd2b2e80@lucifer.local>
 <CA+EESO73TRAcMWeo_aXkLM+0rT5nt1cxyvf+Ye3Xp9kqxL5=6Q@mail.gmail.com>
 <f5cb68a7-19eb-40aa-95f7-51fd004a3f8e@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5cb68a7-19eb-40aa-95f7-51fd004a3f8e@redhat.com>
X-ClientProxiedBy: LO6P123CA0049.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f43ada7-fd7b-4120-f02a-08dde6db007a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FpbdY9eIzx2piaES/Ikgari0iT/t90wspCdZ/EQqSDEgbbthq0KYRzmenYLb?=
 =?us-ascii?Q?kJmUpHcqz//zFmrAY5lstKQdQqI6o4Pp3VQ2ENw5LYrgxAditX99z4sFthEE?=
 =?us-ascii?Q?birIS6riNs68/6XOce+Kjw42LWx8+cZrdtutegcCu7x867kMztlAUWNKgA74?=
 =?us-ascii?Q?OMF7bf7gIjoNxI7hNrfe3wIb7y/tw9HHqPY+ozHgi9+HSE9G0JLp2KXBvB2f?=
 =?us-ascii?Q?ILI6mP4OYNAZjak5DWdDyY3Z9zkudODwSOK5BvUByxWkBKwxH6nr/P4OfGfY?=
 =?us-ascii?Q?2EuNcVkDECDp2PYYDmutU6IdBjEzANkmBqF887FFIK6hG9wUiTPyTJjulYkA?=
 =?us-ascii?Q?OurEsizXWFeUy8B0j4m/LVzsynTzOaoezSL+lNuu/+bj9CBheePjxqjKdeG/?=
 =?us-ascii?Q?JOBwPSkLcQYOIewQZSU5g5aC2W9KusjBI7u6fU5tp0+BfTPfzQvn+8B32GI5?=
 =?us-ascii?Q?nJnv8Y4Pm4yDy1pc3S7mJTXdprFtMwPcIyJRZ0LXviKwwZ/eaWK3nZuj7Ry3?=
 =?us-ascii?Q?vf+lwWB+4sSIm2tv4X7dCzJTbtVfzzOpQ7+6lvFU0TjyWcAkKQ7pk8QlLDKq?=
 =?us-ascii?Q?L5PZ0U2j1yQkAbLpQaG9gOlZXH6AILUfE6WKLQHJgJhyHLJHikHJkxtFuo0D?=
 =?us-ascii?Q?DNYGPU/ZhhIqNN9dwxzcAbuy09P+6suVFG1Fl9+5mINurMmDWMiBc5ZE9LKb?=
 =?us-ascii?Q?jEJhNkyfYTBI3CIW2E1rJDL1DIuvqImo5p/gFNWWz1orjMihv0A4Nao/tZ5A?=
 =?us-ascii?Q?+L26A1hkuvtRK4BNJlzGjiXpVnLA/dD+S4M+LhmeLtniJGMTujZ+lhnGG51A?=
 =?us-ascii?Q?D+DyYWmMd4Dw0BTtKzUPx4OL1uDrRPCYZcQBCs2beq/VzFHiOMaPUkCO/5tk?=
 =?us-ascii?Q?X7AE2hzJKE0xeO40KZ0Hxk1AW/bbAVIBNRfyR27CiRb+Bol2kKZnulLgxZZz?=
 =?us-ascii?Q?IrCVORlu1n/uALs98zEA5V0HJcF2/PS5wLm0lQd2VKTf9Ym8KmySindrKs3K?=
 =?us-ascii?Q?ryNK8o52nS0MKirh1CwzSlbH2OemETPhqthzfd7zHTbIaehGKkZSmCXvPUjP?=
 =?us-ascii?Q?WDeFePxik5UxzQ4mLxb5C0JQQpjz/Fac/PdxZkImeYeE0Xzv8cXx7Vznexuh?=
 =?us-ascii?Q?m3bkUkIRTne35HqzTO3Y0/foMnIOEf9pSHEsGcZtWwrc+AFR1uBmBev2Al0R?=
 =?us-ascii?Q?J847klerdXE4UlOAWjwIQRSBsZtQtDX9KAwRe02e64NG/2TL/kiqWibu1J/R?=
 =?us-ascii?Q?60sDPTnFQX8A14qAGgAXDPyMPGW4PqsbWDkQVdfgBsqzlDqAlen9LJ9BstHu?=
 =?us-ascii?Q?WQWXZQaWvz8IjDTxszpjWhJgkYhTUV78nCTdaqqzRDSu/wL+jyApHDLuUwK0?=
 =?us-ascii?Q?D1ht5gSTFrs7/YGf30P20Ird2yAGqJXjBhSHDBodR8MftinOIw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F79gNoa60FgV++9wb80JRVaqUAKRyt4N+P7ZzHhS1C3wVYUgdiCR9u+XJKEL?=
 =?us-ascii?Q?FLKOlWnERgjAyWN7FAllUUS699OVuXaq3+RsogkyMLzpEEZZiZGTTM1cojI2?=
 =?us-ascii?Q?QqLAkymOOnvNlNfZbymcNaCZVQEGXR4RkYW0f19jdkQpGdshrbYWVxXf5Coc?=
 =?us-ascii?Q?EWaQ5GBLgukFSLq8I7GP3h6+jinPhslmVr4ux9mH6l+s10q4vt+deHvlRQAE?=
 =?us-ascii?Q?IlbAkKl113/d0z5+Xvioqx50ygqMlJLsQxAxphjJFzTrg+YyHyjqbMMmOXTg?=
 =?us-ascii?Q?fN1SLvx+8MXBa4VNhEkXFFbJIRIkix+8q7DchaKP41pIbNtPggj4r5mqDdHz?=
 =?us-ascii?Q?ewyW/pwU/zrdhi8giDdPvSPpOXF59XIvaAmwcncgidiezjw7qSVuH6WgaNm0?=
 =?us-ascii?Q?hyTOrm9nCs3ymzkbNY8/xDxbiG3N6w12QjvXqkM73jkf8KTgDfJ1P4CaS13h?=
 =?us-ascii?Q?pe8WrQWXyMW74ppXWEnC05Yoz7MgfJhv2izWFUdkzaklbM7pTnJBeOVrlYBq?=
 =?us-ascii?Q?cU3jBMnggjOgclK8xgF+KhLJBReB9WMQKQpLmPKbJUvkqZnpfkoLOQJBCs4i?=
 =?us-ascii?Q?X4cKt2jofJVdv3WKD452K1mjgDDOqKQEf8dR16Q/ctV4Dml6wM6v6arYf3iF?=
 =?us-ascii?Q?jUPUniwUobFx37FQ2xVK2zD5+lpwqq/43ivs3C3oU1f3KFd9S3uECyaSFBbm?=
 =?us-ascii?Q?76wY9yA76qdITiSZM45uJgyzA720G0nKi3AhUK8J1GjtzChD7bJQHC5x4dlg?=
 =?us-ascii?Q?aNhNiEEk+b+WYzyH3nxg+dL7xB1UfYXVqia77Au2tXlgXcPGx8YGRFTwiqFx?=
 =?us-ascii?Q?N/GsqFyghDZmj6I0tG0lLdC5cSlI4901o5BE6FOtfzDf9tpcQeKDQiGtPEBy?=
 =?us-ascii?Q?Ob/5n28oKe7FbMkmG7fn4dBg2Fa7V1raxiEs9kAf3c0t11NTN8wAT037g3Ij?=
 =?us-ascii?Q?fJIA/cGjQgNVM4MTybEaJxpfqZVMZvm0cVSBib3micSOCJojW5dvgyHRHMoh?=
 =?us-ascii?Q?UjAwDyUGnaoX2iGMK5vYz9HaKtoEqkQZ1kkO+nf/Qy8BWZhhIb56PKr1P03c?=
 =?us-ascii?Q?1691Be/+cVztJBrcz6jIPA1caZR1Y4ATbOQE3H54oU1zvLkQJ2kcYvTmr0WH?=
 =?us-ascii?Q?RHE5AdHF/GSY7RWcByTNfrppp1k2zsjw25Px2qGK/tYUgTtgDNYTiy2kIMcv?=
 =?us-ascii?Q?MmQgT0XSQ7fdfkOLQgNRy6BqZRQz+Cuu0Vcbb+QMd2vZom5LBTsovdJkq3iF?=
 =?us-ascii?Q?apq6KwNSsMEflGsxp4MchETZ/G612VoUpEUxoEj2EyKw/K/T2T6N9LuVRWvp?=
 =?us-ascii?Q?zTT8N6KNjfzRhcldff8uDjgzZNcQ5Dyzj20R23Txrnv0Rv4MF5VY550g0NN8?=
 =?us-ascii?Q?Hd3jsXo/njIGbB16lgqjG11jGkejMj2M1PVPkkNDRBWTn1fL48kkgaBLLgBy?=
 =?us-ascii?Q?zoNGWi6lrRZmA7gXBl6YO+5gB//z+XFyP6LcsJGMnkZ0mDBgCPALjDj6Y5dd?=
 =?us-ascii?Q?V5zxAJBRZMh2m+vkS4Pn+Xpi9lXnjQRB+ctzFwSZUZ5jXvSCG5Q5HrBE8IDW?=
 =?us-ascii?Q?5ra9lymEZs0jCZ5Du0JCUb+rtAlBzM/rhQw4YwNEHqErWXNqvoUCa9l1y5qj?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IkOnhTh9mMK6AaZxQU2P7jP/oGWr83Tcz0j8I8g9PWrKx1LzhoFkM4xxr1tKjF51LmDc6wvqcDYLEULogv7ojEKposxD+ojIFFqFJbwJeMMd2+itUdFE2SCfk/35tKOzVH+R38TSDP987SyANiKZfcMlbhWqTs8x0Sg3KfdjKKL2AegGywKx7wrCu/tY4Q+8VHLl3SE7kj0RSgC8UBeyLTRTkOldyY/lSfW6oAnZ75mzH1aL5WT2MywDP9/aNTc/EFBtg+ssZoPHm9XyEqRwyOaWNlkTJlNZYu78ILsQIuLk7XFEH6PE2iJFUHOjKerRIRXZuxRJr/61ZFO4CGfoa4cuhAHu/OZo/faZ80o+FeW8gxDYmiQEeDTP144m1RCfzKghGwtUCu3DJMzTwY9Ro+fUIhBUnFZXpplAR8Tr7emoRZYjhhW2fzHcX0newsUWkAczACSxS19mTu5V/uOCLZ+BYUy6kdiCIwjdWgWAC23tx5CIhxcgVEMfeRFMMSpS/Be60BAvwf8DauUhyPUJxWG/4hnU69VQdjb6G4YZIGA8rLQ2FcvYnz+E4UEjuSBNl/4ModHHJFXdKdLNT+v7FRApe153QHxuSB/qXElPgfk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f43ada7-fd7b-4120-f02a-08dde6db007a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 09:04:03.7384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 778BldrTpBjz3ay6M142L2qD3PH2DLBhcRmiK0ZDadcOS7aOPzlhznIz1VJMyEYbHo9NZu8ytzYtDdMoNzZ7prEU0RkiMPWsdZFdNsrrIg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6834
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508290075
X-Proofpoint-GUID: ODlkJtTZqoH181r5ACPR1kCIsj8S7q5g
X-Proofpoint-ORIG-GUID: ODlkJtTZqoH181r5ACPR1kCIsj8S7q5g
X-Authority-Analysis: v=2.4 cv=NrLRc9dJ c=1 sm=1 tr=0 ts=68b16d07 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=JdoVae4-h-sw5cXxKuYA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNSBTYWx0ZWRfX2O7y3DwK8VvU
 IPomvUXP5iwYb0MLHFU5rJDv7jSgFU0fkmCW752iXWolon3qX1nfjCpGE2LNmpM2tdidFbG0ivJ
 ylxwhMCbw70OzNVzRmG/U7hWWs9JPEcfRQOrmlFE8xr5kQLeRoWFR3jPB26yfI87X5votf9Erim
 ZS34yJusyNY13Ek1M/lkYzmjT5nrv7GhMk8nYeViU5gjZETo0smiKaBlawR7Dte59Gih5RjD4/t
 kjMeg2LAeLlyHsg3I+qVgUh+wnJ4jWJoP/SopOhT9EurThTRDIX3y84dtPDLVWTjC54t1NKppTv
 vnoodLo3j7INksA3S0eBzSPpIMrZW/U0/w9qEGc7Xf8Cup0Q0apppUWnCkSHa6J9MgMoYJJT0nJ
 t7lS5miI

On Fri, Aug 29, 2025 at 10:42:45AM +0200, David Hildenbrand wrote:
> > >
> > > I do wonder if we can identify this case and handle things differently.
> > >
> > > Perhaps even saying 'try and get the rmap lock, but if there's "too much"
> > > contention, grab the folio lock.
> >
> > Can you please elaborate what you mean? Where do you mean we can
> > possibly do something like this?
> >
> > UFFD move only works on PageAnonExclusive folios. So, would it help
> > (in terms of avoiding contention) if we were to change the condition:
>
> I think we shouldn't be using PAE here. Once could consider using
> folio_maybe_mapped_shared(), and assume contention on the folio lock if it
> is maybe mapped shared.

Interesting!

>
> But the real question is with whom we would be contending for the folio
> lock.
>
> Is it really other processes mapping that folio? I'm not so sure.

Yeah, I might go off and do some research myself on this, actually. Nail down
wehre this might actually happen.

Generally I'm softening on this and maybe we're good with the proposed change.

But still want to be super careful here... :)

>
> --
> Cheers
>
> David / dhildenb
>

Cheers, Lorenzo

