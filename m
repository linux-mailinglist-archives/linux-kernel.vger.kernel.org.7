Return-Path: <linux-kernel+bounces-898797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5F9C5609E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7BB99349511
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 07:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7164732255C;
	Thu, 13 Nov 2025 07:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="chlb+Qxx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NaxqcM05"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE31029CEB
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 07:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763018609; cv=fail; b=FyBSl5RdtfxRVNtZMHVs8bBaLmg225wLt0A67aAfsf8gnh7E2fy6xCLAcJ5Ij4wsZZNYQqjI+0PzF9ywKmr+aQPR1lizQigbjRGaVVHa65FrIbUEprBgothfQWoRYmCP3a/n+XCMRAARV6/kVlOj2Co0JmoCKFlyHvWLGFqv3cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763018609; c=relaxed/simple;
	bh=qvN/XO0W6+lhtAjNGgEulmnWWayT76NcKFuJjEnz21c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GhoXVSYXgZWDl7V3TZf27ADwVPcPjCiy0cF+RMouS69YN4SpNLZ7Za5zzO1RuxMvtTUbq1vGVYSL+sj2FdW6uCd61PcA4BbjOXbLKqQX9PxNstVYmay02OfeU+AJ4H4sURCFw+iFHZbBN6yCunHFrzkjIDvn5cHaAfpyEJpu/tY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=chlb+Qxx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NaxqcM05; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD1hvKT022199;
	Thu, 13 Nov 2025 07:23:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=fFzT42YeVSEUFDiS6H
	ILCnmqet0kwuNpIRZlA0lWC1U=; b=chlb+QxxVXm/ECyZsAnqX1RG7mPi0Czg9n
	XnvCd1pOsX8k/VENWpwt8tFHy5Lp4kRER5d4CdBc/rUucKqpfcaP9+s6m6WmTwRR
	e544NH3avaG9zW/EZKSugd6GQoWjXa+sxdUkrwF0174sQOIQHWFqF1+GGOVGbIAc
	0/PwF05++a0EqFq4c0D/0RRYUbF2OXyPCQChN9eACqnbnK+zZgJsuLUCAktfUcAG
	yrnIMs2BsxnCBt58oRQUB6N8/4Q1eDNP/U+aT6OZdJY73mFtzEvSPmusknpQmbCe
	VI4/+7oj3Eq1dU79Nv4D/3XkgZFacjIPDXx4N7R4jOE1Wh0ovmtg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acyjt92g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 07:23:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD7GlJK011342;
	Thu, 13 Nov 2025 07:23:15 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012024.outbound.protection.outlook.com [52.101.43.24])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaf9kqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 07:23:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWWWUpENcB+NLLYp5p9mldAB3vZKyrXSXg16wYqtWW3XF0+9obbheeYuyfh9qygMX5kAccSukTTGkSv/HC9cPX9IsA2uZrjXl+MUqQ7P1FCo5tZ87V1xJIZNH8kMP1liIGLoIVAqoxp/V4fbAnRgP7ZgqpfNZ4+xD9uQGuTL3aNyVIexd8DU72r+gariQRY/fUQ7oStMgiQTVMDz6f4m1OONDTZK60mqPohqQgtiQPXf5sGZr47PvTYV+wIuq3Fd7WlVRtll2eAfR3Wla4f7Qy45r+1lUgyLNIB4tdDai5u2jj+cxSHx9yeRPrvmzhRvIPzenpq0yVgt+4F9l683dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFzT42YeVSEUFDiS6HILCnmqet0kwuNpIRZlA0lWC1U=;
 b=KylGhCFXptlSv+QKgTlwUtwMGAPZnGVFgHGAO8Lqgk0XComFp2grcb1dshfO7L47md6flKNmHmEZqQvfqcXPK/4N9C7v8buB3hwj2WdXQ2EItEeVIFBEd8FvZ0lEZZCJ2Mr3lTsnzfcRuLNQughYHfvuUoTJ15rY7V5j+LxV+qRpVDgmAdzFlU4e6Ywyx5VEZgF96B8gOprqow5MvWDEQ2Di/Ibun4iqx7ciDi8fVShgl9/Q+8DYeo0nUWRU8fxJ5N+tOj76iLIKpBszLHKruvKyaqa/gfBimvBXQZkPjB1CSvKOgxlSWbaHpgzLXF3ml5/44ta4wYQdohzZuvf2SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFzT42YeVSEUFDiS6HILCnmqet0kwuNpIRZlA0lWC1U=;
 b=NaxqcM058w7RjBhL9z0zXIMzBm5Hxwt6eQp3wz/9hCRIqE8AVegYs3cWrxkklq1+0YXIy2zgMTYWakpI0MdyqzhGfH9Z7neYIuultTp9zN8Nc2O4huwcsdgT4tSh6x56IICf7sNkkMlCqerwMIe69nCmx1KECh53IePz8k4Vtfs=
Received: from DS0PR10MB7341.namprd10.prod.outlook.com (2603:10b6:8:f8::22) by
 LV3PR10MB8180.namprd10.prod.outlook.com (2603:10b6:408:286::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 07:22:56 +0000
Received: from DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935]) by DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935%5]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 07:22:55 +0000
Date: Thu, 13 Nov 2025 16:22:48 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] slab: separate struct freelist_tid from
 kmem_cache_cpu
Message-ID: <aRWHSDnLIVsf6ex4@hyeyoo>
References: <20251107-slab-fms-cleanup-v1-0-650b1491ac9e@suse.cz>
 <20251107-slab-fms-cleanup-v1-1-650b1491ac9e@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107-slab-fms-cleanup-v1-1-650b1491ac9e@suse.cz>
X-ClientProxiedBy: SL2PR04CA0019.apcprd04.prod.outlook.com
 (2603:1096:100:2d::31) To DS0PR10MB7341.namprd10.prod.outlook.com
 (2603:10b6:8:f8::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7341:EE_|LV3PR10MB8180:EE_
X-MS-Office365-Filtering-Correlation-Id: c1f32c22-d8e4-4f0e-6226-08de22857709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q92mFGnnxRI9+kWWM4uEbNpEOOERRxi4XVTzjDLywQaZubMoVYIB8PgXWnYA?=
 =?us-ascii?Q?f7X6grV+nnvxTAN+kGvNf5l63EDenOmXlRublYBji7Yx5rKlk6bdwF+hpxJr?=
 =?us-ascii?Q?g0Oy86gzg0DmclVUu1JIfeHcYkwCWymEyB6NlF3FDhQNFmuQD5q+rVYZ36L3?=
 =?us-ascii?Q?VU/+1nyAgpSx9cOnyFAw/Xjf8x5+2lOVTuTegm4fczytOxMl1hvAeLAZFrNI?=
 =?us-ascii?Q?t8WbxY+iuB1k6hDGNv9NSQkVNP8eX+HA8AyGyjbRm7m2q9R7vl8MJxdXmnh0?=
 =?us-ascii?Q?Jj3ZV+mA2tl8+6ZhN6deUzujKCSaIcgM1zMBunvL8spIFw6R2gza2q7QFWY5?=
 =?us-ascii?Q?eYwhk746yY/HRv67pdwfhtfsX8SkROuuXOeJiJO8Jj8qfKvJEq6rzXVnjUDb?=
 =?us-ascii?Q?HJKcEC8jvNojSIwYgSOyUbyIuzUt9/KeK6MObhrib7M3x3d9242HNLJwsDtX?=
 =?us-ascii?Q?J8ZkRzYcxiR1lfUpOAaPl3vsXYh86exo+Ep8AUFAQlvzZ/Bx5Qxc7H1a9Xoo?=
 =?us-ascii?Q?+KeV/fhuHEyaNF8v0QM+Nq/Zc+P/Aha2DHfkFy8gTFYrXfLw/2hicpw2shzZ?=
 =?us-ascii?Q?j6DbT+4E0847tTE4rQoAQBDPmWGzkBVY5PPMltFtUe9/6Z8DLeuH2Uf7MbEl?=
 =?us-ascii?Q?UpI8qoYibrWofslrgfoNxUdqXkQ9PYYJNDSpn/Ck5Edey1N+151W+mi88MDp?=
 =?us-ascii?Q?4rJJfvwnDDdWdLC80AWnKbFX9ZEc39sOP0KQxiSJIoEeAIAwile1mb7BQvIn?=
 =?us-ascii?Q?27YhLW83IbDTTeHPqZyOnsTvDzV1webtJ0pbmPZbG/4QAvlx5bA73ueR7CuZ?=
 =?us-ascii?Q?scsUikoIsMIZnJx1XwrYzU+U1IImC70Eoie7kSygiWq7MK/OeEC1MXBHScPN?=
 =?us-ascii?Q?/g/nEaT4JgIDneAbm13BPalZN+x81j4EuH0yZeRSviV/JM6Ec6M6wy3f5hqI?=
 =?us-ascii?Q?nt9fuH2y/Q39N7nDJR0bbkWzFL7yTy1AZdJZd4RxO3XfTjBlWM5rq9hIdnSr?=
 =?us-ascii?Q?lTScEgMCL3gZkOMZYlfpzAzvCL4MFRAt+vJ7XDjxAXqS4yXXCxMt/lyDz+cD?=
 =?us-ascii?Q?8GpIvagsdp3YIX6h0NcC2rc1oVm7P6bmof8YTMRZo0Q30J7+upPLTjeXnCSN?=
 =?us-ascii?Q?JwBITCvDsTUliK/YyFAZMTZ7elKs9OOEt6cM45PUBqWgVttte5f8IAlAd3Yn?=
 =?us-ascii?Q?uKKet1byP2BsCjamA3TxOq0Gn1ungBs+WwwgnrWFX5OiWhQDQlkOahOpHjQq?=
 =?us-ascii?Q?uCgmFd/ySteq/dG/Xp1jpvkVDh+5BoIJ9QQOAiGtvAf6HkaKtYXFHJrq8aNG?=
 =?us-ascii?Q?jH82KgF6ZURev0jO8lwa7p9mWDWd7RgfKPpFzLer1lH7KvDJ9vPZR55tQ/dT?=
 =?us-ascii?Q?pURnHEJue4o+/pxFMFubjvc586hUu6lID2UoIMRsCpqpFhNdDX9R+jGpanQG?=
 =?us-ascii?Q?EKhujGkcz/KTA31JXpc98D290tD0LyIi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7341.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?71nFpr6qKMhd+LM97qC05hG5yg3CjrWyhbN+iSn1gkgk28T1YjSt/rFhuqVZ?=
 =?us-ascii?Q?GqiJ9aYtAPtBdo+9PKw2ncvdtvPjAKNOl39x7Cwy7YbN/H+YA5DIny/eB/LH?=
 =?us-ascii?Q?fthq34XKYnDvs0Q4ea35VJcH/qbW03YxcLePBHh+OiwDCzCujstKakeZHH2R?=
 =?us-ascii?Q?iZIh84+NfDCzb+6NwrLUr+POVedbVG7JrEKyBJ1qMqjA0ntaMrMlzPdVxwAh?=
 =?us-ascii?Q?5D+Z7CW/cNA4B4QsBwkNwF39pxMXS8rvdnEzNFkJyZ0d+jipFOk66oBeH4vp?=
 =?us-ascii?Q?M4R4fcEBsp3S5EOsCG1qrcDEW9sw5QHyFbeJKN9on2KPd2jdwQ/O5vlCoI13?=
 =?us-ascii?Q?dK2UU45Cvz1HahTX3uiENNRH8tMBLSTe3enjP/JW6GVI2cB8Pzhg8GggfSFr?=
 =?us-ascii?Q?/BICKYgckj8oKjY+izbWuOaXlRYpGSW4XdSRzO59lyrI8wBP8/XbL/ae91sX?=
 =?us-ascii?Q?YHRjY2s5Z02hf1aXcdx+t4qf3l2ETZTxljRC1VB6JQcbaX7+xEeHx0+LcfIt?=
 =?us-ascii?Q?rYsYTphMjo9OyYtWclbGkHEdOz5ITaECpvX/sL1ZdfSGB6lrF3vN0aw+QrCr?=
 =?us-ascii?Q?zDv9nmlH7OEvvx82odlsvW/poRN36qUK0GbJqagP52JsXr5ojlezDvYlW7gb?=
 =?us-ascii?Q?jWT17p8skZHj+HUUppfZ6nBMwJM31w0vpxY0JyKe4pKG2L8EHWfGlIGEBVxS?=
 =?us-ascii?Q?5aPRGw5bFulI4aoFw2LlHmHRizwv3oCHaQxGR0+5wNygmsLSLMGWRfxuejk9?=
 =?us-ascii?Q?FyiVchu93mFa4jmLV1xO3OvJLGrJAfhrw45064Z/BY6iNDUmOKcwBs5MM1by?=
 =?us-ascii?Q?E/zIgGiLq6dokDMo+t3yZkZ5woeHqTAyupRGmWV+jxLQbJrPcuZ164cUmBsD?=
 =?us-ascii?Q?4FmVdyssMp/PIUZlgmz5DNzuMXjqiFoNikdASowVaHbiRNq+xs1sui37AnX4?=
 =?us-ascii?Q?Cmmo0NCmLU7Rc90OiTGl7wqngtkiCQav7zxndMxQVUY9lZ5D+sDJb4tUyOYB?=
 =?us-ascii?Q?A78G6lDFRKPeEQXGEaZmIpZvJNajdJjEQGz3W6tK1D1TqDPfdmndPHz/YGI3?=
 =?us-ascii?Q?BhVBZd1efFayvfQhHgbAjff1+YSNMuxmJjx2LqQ1JOr0tm6Eyet+bjTSHq2C?=
 =?us-ascii?Q?ku1D2f82BUt7fiQRb+uqWO0Y1QiFH6UiNMruP5r2Q9htgnhkNpfHpMWRCWJw?=
 =?us-ascii?Q?maoirgt7vcJExl0trShln1S4r3TASJX7MmP/smp0e2VN1/1gXrhRvBhw1Vn2?=
 =?us-ascii?Q?qrUIsQrR8c9KTEEHMUaLCrcxHJTxDw62DKBOGxLNbQOCgt8drqxRUq88BypO?=
 =?us-ascii?Q?OyrRqPf9Je+uEfy7bS0dxA4S3Cy7/ubw052iTSdd3cEMhX/SP3viuvUiI99M?=
 =?us-ascii?Q?V2RDhcxgbig59is+KhSF4m2Vyo3jXEXO+SrGd0LT1rk3UpdMTVvslb8MgWtI?=
 =?us-ascii?Q?wO5HFnOZGdWsCtAFYafHIQkbt5uFJLM4Xm7W6iBBrpjY1iJ/32xjI+/x36ui?=
 =?us-ascii?Q?0ipHfb6M4AOnE15YMDhLmYLwaCQ4yLm2Pz7l49CFjBirw9DbV7Wrxp4OgDqq?=
 =?us-ascii?Q?gezX073ID+p72U0HTe1jSGkHhT3ycxiOyG3rFPIs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	umMv93AbzeeVhviRvGJiu5IVu8iIevD9SNydNYohmHGWOlhRnnRfeHXGf9B4WCoWAAlXFVnelcOfLiFP/w7vp1uKhm7wlL3AOXLxCPgk9E6cWRqR0y/60So39H9s3xJ4EYnM9x2Ce3b0za65dBi21q0EhzSHdOeSvJv8iqB+W34jArQ+OCGppt5ZwbyFRFNgQPE5U1E+F4SvRgkJ/FYIFWK5+7Yek2zd8fmEUE1Gunrz3DQjuwS2HHqhzvuAGP4X1i0DJDeZtkLii/QOWuKnossfwJa9XeiOW6SdBFqPCcWtedlEU5xylZqVonbPF0+SLVvcv/Smbg/0hMyzVkYaafThu0BnpOkZiUYKmmnysucGnUT8yUGQ/Mbm+npODqc6h+kD0cYxBs1vta83UweOnRXKr4wzTnVJcbEcRXo2eOsabtzKIAsDeFWuezhXKo/4VVYex480fAvByqWg5wcbwB45g8WZ5mNcWSOsX67t3FSx2t0mcXZBSLNSWdo+lnVdVX/nkbJ3Ez8CTarQQS0E+Jmc9y1mckKYRlXcgYnDOYLhukgWh3VQVV16rfe22XdeSSPXn2gUCaVSW00zHqaL1J7gQIZLXapF3w/eEPyiLgg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f32c22-d8e4-4f0e-6226-08de22857709
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7341.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 07:22:55.8539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HdlCCyPg+lcfle60q5UmesTb52oq98BoESnbtTgQTD3umlhZuZ9qhpe5cdKbgcr557MIdrNuRnD8cHqZSuYDtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=908 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511130051
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0OSBTYWx0ZWRfXzSKRI0lxaTSp
 iJJ4zvX0jE6rNMNd5rd+oNeIywGiEcEEeah9uxuN8d5FNmKlwwS9FRgeSe0sys98NNKx7TWQJYg
 sEAj/lvC9sZn3iHrPCSBz1RjmrtGnpdGbAebMswM/y22nbhj0KcGIHssVgn8iDC0lgTENAyVcrl
 caayJ4KOq29i8Fgk6lmAhYlrQu7f+seYh9PhAAK4y5UH2YjyNURJDglJO0I46XrN4Oh89yuQd4e
 FTHg0OT5n/8f5ukaDxphtLYjwvdG72L8nGSV+XVwecqvSQ2kP7PrGKJxoI0RraLk9/YQSWdk9gs
 lYhWCLdUvZk3DWsM76fKdX6OBk1DCOBDuFFEPn2KE+tQA8Rz80GhjpPP9Y8ck7e18TDY4T1CekZ
 JYlGFWFORke4JVZqDotyUi/lJQ7Du3sJhfERyAlU7lxZYHP2aZc=
X-Authority-Analysis: v=2.4 cv=S6/UAYsP c=1 sm=1 tr=0 ts=69158764 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=qiMz8tWPJYnlGiwox8QA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12099
X-Proofpoint-ORIG-GUID: eYWHPIo9qLNM1PE2_ZmXksUpEEZSbsSz
X-Proofpoint-GUID: eYWHPIo9qLNM1PE2_ZmXksUpEEZSbsSz

On Fri, Nov 07, 2025 at 02:51:23PM +0100, Vlastimil Babka wrote:
> In kmem_cache_cpu we currently have a union of the freelist+tid pair
> with freelist_aba_t, relying implicitly on the type compatibility with the
> freelist+counters pair used in freelist_aba_t.
> 
> To allow further changes to freelist_aba_t, we can instead define a
> separate struct freelist_tid (instead of a typedef, per the coding
> style) for kmem_cache_cpu, as that affects only a single helper
> __update_cpu_freelist_fast().
> 
> We can add the resulting struct freelist_tid to kmem_cache_cpu as
> unnamed field thanks to -fms-extensions, so that freelist and tid fields
> can still be accessed directly.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

