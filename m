Return-Path: <linux-kernel+bounces-750778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A64B160F5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5003216CE8D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B952957AD;
	Wed, 30 Jul 2025 13:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XhOKRPAU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C32eXhBZ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CF1224898
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 13:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753880706; cv=fail; b=g5tDIAY8Ne1f8Egh2G1l87iQxSYITEul6RdOaTulYl/fdzg3tliOo13BVaO7XXLylEHK4i1Ve6TTgxTrbWxw/3J3UOGPzvbgtZNDnQGVbdgRFrpe8zfS+OF2ZAduil8tOyzPff3L0dprd1Ro010rxUttlBZRv1dmaqtU/pqyMsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753880706; c=relaxed/simple;
	bh=LeUgGm/HEqj+8zH/7DBEIRqvQ3fovlapFT/h0inQ0w0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AHQZCTtcdvZqVeQpab+K26fgW95BdNcSQj17Ez5y9UNEhWBNW/LIE/6fyUoDFPArGVC469Wt3eZ/37gV5fnlyZtv+ybHxyT9F28MgFOfJBC4Rasnx08tftAvplazdhZHNWtQP0qcPb4+dAzzZxqOiKclvgUYHuKJ1xikMa+bca0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XhOKRPAU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C32eXhBZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UCu83d001067;
	Wed, 30 Jul 2025 13:04:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=TTtTrsWX2bJoCeQXWo
	wAJMLbHlrdU6YX+6TvE0xOLPY=; b=XhOKRPAUq7tfWY05PXEeUwYx+8mnAU9Ncp
	/DDi5p/8ZfQ+qlXPp2M4ImcL9TR7SP7NdF2eU1G1k2Jm/KQg5YModCnjaNV0XCYS
	FsWOaPrf3W2kLuvfaeMfDGpGZ3NzBcBVM0jafmqczaalj493+PU/WiwLehG9gjls
	XJ9g4HcMHf4tQ+PSh1aAbwWUawlKk6lN92sWrMQVyiRNXHfaSfz7Vx0aF8hW7cNM
	duNbncKR9mez794OyHJQ9ZHehAZrb3OFFLRZ65+yZo13ishRFD9WhKEGzH7pelZg
	RAo+Izp9CSKXOXlpWF31PpSQBWLWjDi5KSW546dNdH80HXgqaGjQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q2e21f2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 13:04:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56UBJ91C034533;
	Wed, 30 Jul 2025 13:04:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nfbdrmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 13:04:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r70CTUmc/eJ3DyvTsL3fEq0VspQSFBmvdcoYn/Cq9v9Y/MRh3+/uVlJhthn/dQCvr2+uDMt3HMZ91RDIO3Hp2AxiXBAczgC97IZjijUub4Acg9oZ3Hh/y8pd/S2XCG6kFHV5KyMN1HnIujLxu/aAez/vvm5oBFwkcYl+PnPCof4IP0qjI9v1VcigE4sv1HgI/qsGyKGA2pcGhsuaRYyswEmza/b3SogZk98cCh2eeyfGGk7PMNrBIhV6Vx5A4PZNjEHY47mFdyMwet35UOi5cK1Ply2ZstF2VS6dwQGhHfXZjgf/Nc+xPS7ocns4lBl2ophWXBUhHHYcp89IquQiQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTtTrsWX2bJoCeQXWowAJMLbHlrdU6YX+6TvE0xOLPY=;
 b=uJ6Rt41SUa086Lq0L4796t5grEhXkYyTKpPN097qJYxwWFctLZIMB7HRYF/sENifdZr8UwHEHb2O1oiBitEBfhC65wWJ/veD7bKc6L1TmFi0fIMzryHRX5tRTCsaHOwqF7nEpw4R9Rp190rUcGdxNvsy8zczYXzrhkgvSE4fnubSjneZlaKlvXDcPuKBAHDTolt2M1yPNN1egKbwrbx9FoT/SOUUVZGAEdknypWaaBx4pmXlADIyqwyyFWsSIgk7ISOjVhP2t7vHHilNlH4hyZUXycdC3alyj2O/Q1BdVahG94KKDnlzEoDnmC7TF1hKF1c9TiRU4Xb3PrqTEbgDQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTtTrsWX2bJoCeQXWowAJMLbHlrdU6YX+6TvE0xOLPY=;
 b=C32eXhBZpFBO+GmlotrgWx/HziFncwRnm871BIOaw2fow8s0CWmmnEmodUGCiIdydF0uctb7cK6Gg71MhY5skn9My0hheVDObU6UmZpVd82Cz3cemXNyK3sYDfwp2TWoNrbO7MpNyT8VB99bJQ7NCn0CtzejtzMRtt4GzkPkqYA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA3PR10MB7041.namprd10.prod.outlook.com (2603:10b6:806:320::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Wed, 30 Jul
 2025 13:04:40 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 13:04:40 +0000
Date: Wed, 30 Jul 2025 14:04:37 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zhang Qilong <zhangqilong3@huawei.com>
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, david@redhat.com, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com
Subject: Re: [PATCH resend v2] /dev/zero: try to align PMD_SIZE for private
 mapping
Message-ID: <46e94dee-188f-48a2-800d-30a05a31d57e@lucifer.local>
References: <20250730091905.383353-1-zhangqilong3@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730091905.383353-1-zhangqilong3@huawei.com>
X-ClientProxiedBy: LO6P123CA0039.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA3PR10MB7041:EE_
X-MS-Office365-Filtering-Correlation-Id: 8022afac-943f-4baa-b64f-08ddcf69a531
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0XXVC8LHs0FJKDQDPXMW/GnIsMaPIBk20eIg3g9YD5WitLiNY2HsuvKPNnfA?=
 =?us-ascii?Q?0uvwtAAOvzulTKj/oDAUo9ZZfIAoFhrpAOyCkwjPTEx4e1gQDJz0d2pJUfeG?=
 =?us-ascii?Q?CV/FdVyVnjsIojkRYm9Sv1QQ0YLFhe/w8I2b1UO+TmyIb75rPZ4zoKKmBCcb?=
 =?us-ascii?Q?WZklBdEDSH0y2XqBv3rCadbsh7rj8qDrbStYcq6e3QDn4y1G58b+S+O6Drlq?=
 =?us-ascii?Q?lr6HO51L9X6bMtfdb71KQVhSoun9asi1yvB47AiEJHI0z1tJZH/R+3cvcOTw?=
 =?us-ascii?Q?Ynd9kko2IXFa7YogP0sN4d7i74heoLmH1digFMbc2gdqtrBUKdDnMjRKsOSb?=
 =?us-ascii?Q?r0FbRDWJaiGHWqs9JiP/rdiWU7HHzZwzGNQd04CFZPJFnwLERTGZi2wRTdjU?=
 =?us-ascii?Q?TLJv31WvVq628oVVjzu2zgT+61oEwHDBvHy5y4dcHuHv80NQVuTNCA3cn9Da?=
 =?us-ascii?Q?AnRYHXlvhhMENzma+RAYfbDq6iwq+V98Tn/mCN1jW0evSsMrnBa0djZGCEyj?=
 =?us-ascii?Q?F51xb5y9JhfioK0PtvJEOEpkeiki/dTWUgkh0b311aKYJOBoJNF3fU2/BSFF?=
 =?us-ascii?Q?eguZNmi21I40KZHqbCyqZ+BUEnYjhvIe3i7LlVVwM/+qoLj9drip/lwLFTIF?=
 =?us-ascii?Q?uylzZfjG5GGd8bcSCaAlGvdSLJN5e1kkKOTfaXYFHBkrCBzRM+nd/W5yVXB4?=
 =?us-ascii?Q?P6ElzOIPHQDRJu7j7FjojW/MF8/7v4h2ZEJl3npAXrtisU0m0ZISDpEPO2FG?=
 =?us-ascii?Q?F3TMGKTQvlLgAXlpG3XU9+nevGD9AT6GhIgssQLyMvNakXWhfw3dI1AaSMun?=
 =?us-ascii?Q?7FDVYObVCUFIQzmLTqq0nzgVuoMCjqxGsjFVYgxbQlOa8BrJJRJb8POboHah?=
 =?us-ascii?Q?25bGdUk5U2AysNPY8czgKx/tNU7/CjpYxmvJGzVsvYcBSzj1waAarl7P53wI?=
 =?us-ascii?Q?+aNRTKwmZC7AhfjXbm3nifaDxbBgbmJ/mzCMXuSOsTLkMsy3lqyWzTTDbbJ0?=
 =?us-ascii?Q?OwuNvuL9BsiafgwuiJCDTenVaR7nltfYZV7WqSvc0Wog+Q1k6YTzxO0eaWj2?=
 =?us-ascii?Q?mnf4wkvcrmVvVcsdB+Ned0xqylR9sftCrixlnpdObxBdhdYeF6HLxx/+u4cG?=
 =?us-ascii?Q?/oF9P1I1+iCoopnMffenr5yLHe5R+dt+wCtm13i7FqKER3Ch4FGRrQp3WiUZ?=
 =?us-ascii?Q?m3nVIjVpxzQYDdSCNycig7IF9GaEvPAq+oqu+1qic9vssjTcnZ8ldZ/+tbvE?=
 =?us-ascii?Q?YQ+zwRoGSuxq4TtP2/Cstum05zuRKhpPtlX+PYhNCtqS5xLRidpFGsB8uQ0f?=
 =?us-ascii?Q?VhkOLIif6oDzs3w1lSsMX5DZH6cRiHj4zuoM9AiL6cbhPV1R6Vxq5JEvLLqr?=
 =?us-ascii?Q?RJW9mPRpdqv+782cxGpuginjaEkdideR9GvMekW3HF+sp5gWz7IL/9INUl0m?=
 =?us-ascii?Q?L9aRR69wrJY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jyaUKrGBNU/f/f4WvOQt1a7Epie9M9zb1DLfYe7Xl6mFUyuLaIFOUwlRgBOE?=
 =?us-ascii?Q?2EpJAya9rUvRA0KX/Kcel3P4E1tzs4frLMwMdUCdALlqPaE3jr3/5xkgNPxz?=
 =?us-ascii?Q?7pbDzxvN1rL+HGgqsAB/JwTnTSgAGrHgxNCBTemKH4d6jQ7CdFD/qkC5asPG?=
 =?us-ascii?Q?sGw3JzlM9o7i+GJ2HgBH0jyvTbU/HX/Z3qaPDBVZQNppe+KtiLwX/Fberplk?=
 =?us-ascii?Q?aHwzicPj8pNE++t2JNAme7wEFN3OY1Hj7u7KTw2eR9SbaexR/VEipKaVCSBK?=
 =?us-ascii?Q?vke153FdiEr2PqvmpW9KkT7Destha7jvJMXhzy8kxdERJsBWdPCqNNw+fdIX?=
 =?us-ascii?Q?MCtIqeqHpfYHEI8kLL52XGJRcNooJv1wPYu+K1UE/IC+ITey7MgTYJrwWXfN?=
 =?us-ascii?Q?R/e4xNU21wYTTko4UwAT1fIRo6DUJ9nrdLr5mQNQAfti5dXRU864GTxwTxSE?=
 =?us-ascii?Q?2K8XpAXHe/BvzBrEZlJsDcWJGnf3c46qSVis8a+6kcXViQnrYP9cLdTMry8o?=
 =?us-ascii?Q?jk4z1rBt346mKp65yvzx5datqmfj3VVpNTibJz46Si6Up4VKt4SCE2CTtaB5?=
 =?us-ascii?Q?Gu9QqhilDH9vtyE5mIYB4vdNRNEZuaJ8WrljrCrP2XXZ/lBASU/Noqd210Qs?=
 =?us-ascii?Q?JtU9gMjiLM6eOPveSw+RSN2p4X2jeCgwmxpO2B+7r1vSvchB22qmQEb4af4A?=
 =?us-ascii?Q?/9CIVTGozNT5QaHwaFNr0xG6AHFgVAPfpuyrdUtzQ3ey7F8h/AsQ/OU5g9w/?=
 =?us-ascii?Q?2iU+vRI/SDcPiGiXTXEX9nj+b1ghrLyVo14pqhzkVjr3kystdKe1yZXNWiwU?=
 =?us-ascii?Q?FCoanbFZVf1j0SJdD0DfutzTjTDHJWRBQ5oi7KsHuoTbarszmVDN/t3zC38U?=
 =?us-ascii?Q?cYpvRgUzv7XggVLrnkJq6FoJG4jAwP9p9owhQZ9YA2PO4I2jWwd1/SA7s502?=
 =?us-ascii?Q?OwtPlsMYAw+LzlmOD1Mw+drXZEieAnfr5Y9Jzzlppo+xa+lkuZnWwA0Ae3Dl?=
 =?us-ascii?Q?2FJ/khHYucwiqsGWtcShSxXl1x5R9byxcw6LxOOSqJO6WdjrjMwQqGTlxvX6?=
 =?us-ascii?Q?ccK1s2dmWa6w5GZ2XoKwyhed0Y0lyEKCZ+LhVicFgQ2o1yED4WSICzMsapN2?=
 =?us-ascii?Q?hHV/OHp3ceeXdoHU21qnG+WEOBSdI9lTXghXc5MyCCbN4ipYvWBj9Ks0//X1?=
 =?us-ascii?Q?BM+lQtY/jZHTiiHDo09cwf2ahT9NBT1wstKqppPd0uNTA924Uhtqm0zlNihH?=
 =?us-ascii?Q?LeyIOYFFVUf+30uyhJ1UhXw95bFs29viKRLPbpptbNxmN+1qiINN0/W9YsdY?=
 =?us-ascii?Q?CJegpAcFi6z5glwsgMEcUVpOCDQ2M9f+pdWLz03rFqQB6+6KfWBkmU5J1AIB?=
 =?us-ascii?Q?yKVeqEpgizeFpzBiEGTz13RxEij7oBhxZSnEUFimPOfUqEhw0nVGIi4SztCR?=
 =?us-ascii?Q?EHQSOmuYa1sB91nSOJO09s5ytrseWjJLl3ADMHvryh92z0xmplBFeJp8Z6qO?=
 =?us-ascii?Q?i5q5CNY79/HjccGFm4CABajVj8Umih08TM1hC5q+R6sFigD+ExjwHVoQCKFl?=
 =?us-ascii?Q?JDmi3xV/zVn1ksK3rS/QsEqxf5e96/4NLxnOMWEcvM0cglpwpbCydrVM1ZmN?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x8av508R3vXx8Z04/0P2P/VpAfCI5p9CwL1+nvaZQVOtGuxuL3wTiYT9min5Z4ARk8NgrE+cv7hInfQOMBBZGLNkF7NIqjMnL3/+zKsd2eV5XgePZaUrKebV4kShX21uDDJ8xrVXj7td7meIu3CYcNZrh2BDXmff9ROsAqDRFSOK4hXbRbpjR6sUrsoUdTS6OSmnc5E5I5NWhJfAGtQClNkDqrBt8DaV036Moi5UpwOnn0edeeuIZjlJtzeJ+3FvlJQnag4pwv3vp2e5BjHh1BCGe5C1fDH+8YaKLn1ZRhev9IABzQ0PnOGNIaLcfSD6SuRAh/qJYYTTFBnJpWY3sQyWKKr/XV8gyrSHzmpJQ9R8EGIzY4m+q6ZDRMkq5bN2d9gmwnULuSxMekEWL9tExbajdQ150y52BjUJzqTD65pMk60KrBHUtyW9FXSYUdQjF4omKVdrqHztp2t54n7FqQEeKegPyOoU8IBcluea5ebmnpSEgCZNPqOALYb75+QJf6TLTpj3LC2i1bfenpOGZDKVakg6mkFdXuRUnzQd2zn6nNRDacvjUS8VpHchkAFU7KE3rSUrNpWRlW3veSfAMLWdme98F1dBQ972pMHH+dI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8022afac-943f-4baa-b64f-08ddcf69a531
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 13:04:40.7020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /j+IfdmioR1KFXsKFDVPIxDbIR/TOBlVLPaF1SR3YwBZKxk7GVgGqVJABpY9hhnljCNFifUHg3NqM3PBTKHE0KrCobQ1deTuVyNKDGs4D/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7041
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_04,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=917 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507300094
X-Proofpoint-GUID: EbrpF9LTkeWAnsFFSh7uZ0sp9J_aD6gG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA5NCBTYWx0ZWRfX6PnljRocVZYW
 ZXURi5uCpHCiH4iPSzCelgBwJ5byQnTVxYkbxPj2+F3lmnGv77+/AWkQTCUPB8D6nLPp1Kyn1eY
 2eyxKNNcJ97Pde6PL9EyFir/59dDkEWSrjHs7tiwocnpTugq5vABm7KY1p5vO1oZvFv2nWta+Vc
 8JHgwBgFayev8yMQjn35I8yB8FgIyapqd3lJntUOyoy7y8fu3e/kN/qXUxeFQNEei2J749lyZGh
 p0gA/bVD21WZVQdYS5Xp364lJgQqV74+t+8e5l8lQaygGNWELTQ6lYA49Af+93yY6o5A95r6duE
 UEZIru6zb/hGwwODvu1a+D9mkOwyYbaxl2fPmE1AqI5qnWuN3HGmNN9Ce0eNZ7wQv9VmnSKzFOO
 rzqQYrECQG8IMoYu5BbaYEAjmjHhOl8UaTjLq3x+sTB8OtWN/SH1jOOct/dx7nOauJ24CwiR
X-Proofpoint-ORIG-GUID: EbrpF9LTkeWAnsFFSh7uZ0sp9J_aD6gG
X-Authority-Analysis: v=2.4 cv=A+5sP7WG c=1 sm=1 tr=0 ts=688a186b b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=i0EeH86SAAAA:8 a=m8Hz9ToHBu6fQcDdDGwA:9
 a=CjuIK1q_8ugA:10

On Wed, Jul 30, 2025 at 05:19:05PM +0800, Zhang Qilong wrote:
> Attempt to map aligned to huge page size for private mapping which
> could achieve performance gains, the mprot_tw4m in libMicro average
> execution time on arm64:
>   - Test case:        mprot_tw4m
>   - Before the patch:   22 us
>   - After the patch:    17 us
>
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
> ---
> v2:
> - Add comments on code suggested by Lorenzo
> - Use IS_ENABLED to check THP config
>
>  drivers/char/mem.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> index 48839958b0b1..c27cc89bd02d 100644
> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -525,11 +525,18 @@ static unsigned long get_unmapped_area_zero(struct file *file,
>  		 * so as not to confuse shmem with our handle on "/dev/zero".
>  		 */
>  		return shmem_get_unmapped_area(NULL, addr, len, pgoff, flags);
>  	}
>
> -	/* Otherwise flags & MAP_PRIVATE: with no shmem object beneath it */
> +	/*
> +	 * Otherwise flags & MAP_PRIVATE: with no shmem object beneath it,
> +	 * attempt to map aligned to huge page size if possible, otherwise we
> +	 * fall back to system page size mappings.
> +	 */

Nit, but put a space after this as it aplies to both blocks.

> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> +		return thp_get_unmapped_area(file, addr, len, pgoff, flags);

As mentioned by Matthew, and as requested originally, please make this an #ifdef
/ #else.

You might then want to factor out the #ifdef CONFIG_MMU (gross) at a higher
level.

I'm sick of us bending over backwards for museum piece (or should be) nommu but
anyway.

Something like

#ifdef CONFIG_MMU
static unsigned long get_unmapped_area_zero(struct file *file,
				unsigned long addr, unsigned long len,
				unsigned long pgoff, unsigned long flags)
{
	return -ENOSYS;
}
#else
...


It's ugly but unfortunately I think necessary.

> +
>  	return mm_get_unmapped_area(current->mm, file, addr, len, pgoff, flags);
>  #else
>  	return -ENOSYS;
>  #endif
>  }
> --
> 2.43.0
>

Thanks, Lorenzo

