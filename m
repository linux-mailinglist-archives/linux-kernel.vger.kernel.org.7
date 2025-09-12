Return-Path: <linux-kernel+bounces-813765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39765B54A70
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E072216CAC5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E82257827;
	Fri, 12 Sep 2025 10:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qjmv+W+e";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uc8vnDTh"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B6D1EA7DD
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757674405; cv=fail; b=XbDhbc0njvGD64wcBS8jKuUHbj5Z/VPOGIxpWM9iBbl2/NXwqv/rEQwJCotxckBtaT0F0ENj93k0nZfzSaBajYbhGlaymZoVut98beCFnGzmV73182YbD5IBVlXwXhBYm4Xw7MNcjDSl8HOuEjkgKk1BjvTXqSGBqXf2eROVjuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757674405; c=relaxed/simple;
	bh=HzseF6u90sVKCIWBfFJJA8O3fHlyPJX+f6bWaiWC0cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q0kHqyuEtGWs7kVMZD4gOu0GR+pVInGhnPntLKJ97t9pHa+2SkglF2R9UaZ+4I4i5aLhROtXdgGNsP9q/hTPoav6To1waqq7N+IPLMHE6odVDX6G52yX3eiWETQNy3MGusIeEJqnGDUAJ+CLFer3S5XKAkt7MREYh9aDGKboVIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qjmv+W+e; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uc8vnDTh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C1uSjB031627;
	Fri, 12 Sep 2025 10:53:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=E9EkXctosfkH+1RXiZ
	SB0FTikEt2LibZiYkcXSTRvag=; b=qjmv+W+eqlLuscurp8I8FagvWVk/1GPhkB
	12WLMh+ctS4a8bUJINj+MNdSZa+Hdq8gitLZJWGzvppIG5h7B2isjXczghv2tOY8
	IcWtPOPv32rZKQzhCVWzxT8QQNyIKU16PlXXL78FvdzlsSSiCgdNO0I8rFLzmw7X
	XEkw/uafK3UYuD++vYHQ1bL5HbU5Bsy3W1r47hADFgW4slgMPp+C0bnd+SfKyyZy
	ixVSvHiNFJIufPmxwVJNXdSmaE0KTN1mX/dHD6v+76p/eET0W0s9Gy9/3niua05U
	aLbwiHIpWNTRlU7w0BQwcFkD5+/iArP8+hsQevQS2NeIbS7jkM/g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922x97y5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 10:53:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58CA2jbF032849;
	Fri, 12 Sep 2025 10:53:06 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010043.outbound.protection.outlook.com [52.101.193.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdeph6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 10:53:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFPhLomFPhvV1IFcYlGr4mDb5O2tKJXzD6A7yyV52zAoT/6JcVzMvLxCjtbopxmx6W6ybtom/+OqGh6RcYqKHWJl7YpigonzrjKT100/IOFtQRh5W8BN6w/WF1R2Ff02dacCEJeKTEb3ihA4K5ub6Rik23U0lPK2bdhS+F8VxyFYUeBLm2K7ZYX+f9+5h1LoKXMbpUJJitnnQtCYM08LZTL0KWKlPG0FnnCFxf7yum+lcCmSWtv4pMIdfiDValGYC2Tn7k3ecWJqdPdm5Qh7L1sde0gpb32dKOuC59dCpaAL1cAQPPFIhD9xlNRk9prYdyRXWpPsbbnZCKCJ2eqG3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9EkXctosfkH+1RXiZSB0FTikEt2LibZiYkcXSTRvag=;
 b=JF2Z1PSKpit6fhUGVK9alfTVYXBbiMUqJJGkfHrndUieFGwiT0ak51aN93Ry8skJrL0eT6cV07N2cB0XKQ49uhvB4oubyF77mW7IK79wcahDsleitru07MdVWDdHzxErkYRGTaYJ4Q+yvOybyrLZFxiSaNlq/qM3jxDrRmdPFfC2AnJSri4Hl58EOpjomjIRMUW4NSxGJdHV0B9h3t2rNEVnMZfTXc3TiZ0wk733lTBFPZa1CrKhx3ebuzu8sQrZ3K16Ehz0Qc56EDn4Ey4TI7S3KD3g4yqNhKA77yrpoUh/y65WNtP5qqQ49yvyGEEwIYNKHOh1JFTJijW7cC3VWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9EkXctosfkH+1RXiZSB0FTikEt2LibZiYkcXSTRvag=;
 b=uc8vnDThAGYTZBvUiDvmCbbEuZK1ZeER8NDBqi5gh0KlVKRzLg7WdZXrP07HjVD4fqK/8ky7XE1gyA3xGHKtD853Bm9yUGSrHIop7cBYBg17ZmgBZMF8k7ZM5chWM4Pg3JW9UbmVvNmrM8pj/GkOfRL1RJUSTOa+CmcYoExbWOk=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ1PR10MB5979.namprd10.prod.outlook.com (2603:10b6:a03:45e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:53:02 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 10:53:02 +0000
Date: Fri, 12 Sep 2025 19:52:56 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] slab: don't validate slab pointer in
 free_debug_processing()
Message-ID: <aMP7iOwAm-nC4ZYH@hyeyoo>
References: <20250911-slub-slab-validation-v1-0-8b67eb3b3dc5@suse.cz>
 <20250911-slub-slab-validation-v1-6-8b67eb3b3dc5@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-slub-slab-validation-v1-6-8b67eb3b3dc5@suse.cz>
X-ClientProxiedBy: SL2PR03CA0015.apcprd03.prod.outlook.com
 (2603:1096:100:55::27) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ1PR10MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: fbf2b1b0-333b-4067-55f7-08ddf1ea8b9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QPIWE62qmoAVYAdM96C4sO77Y0YRcVJaJBhIiKkOKD0pwTYB3YQwmkGt23Y+?=
 =?us-ascii?Q?HD4HYVvMyYreVI6cb0oWQ3sex7d4OqiBpcpFsOHH2hNXRgdJ7ayirmIcrrRA?=
 =?us-ascii?Q?aGPVmYLz6ZSftAgik03M7qbUtqXuuRR92j9hqo5duOrYVXtP6qjVTXfbapfm?=
 =?us-ascii?Q?+GxbQ8xLfGczq2LevY309N6CJfef8unPn+4e3+I5JJMqbCQxaXt9pNaC/B6P?=
 =?us-ascii?Q?b8Z6ya4AJvgohlB4KuylZUOZV2nySPEc+tVmYdKpGG7yJLz5wMIIGm0a32kV?=
 =?us-ascii?Q?HnktlrnraniKA2mkoUGw650J54ecE/eGunPrBxwNWkk2ZxgIlKYz4izz8uUm?=
 =?us-ascii?Q?UfFLl6uSyGhmC7SwuPGs3QnBYTe4RJBhyIBt5fP6wk7zyoZgrQq7IV0H0/rg?=
 =?us-ascii?Q?O9VhvhvVu6tAI1cbKacnJe5z+w6LAkEc9rnCthZZF4TutDXPb3ZPGamg6ouM?=
 =?us-ascii?Q?+IiwZG/MDCj3PIS9fv1WkZ3FVw0YEA26bLhzoSJp39TMXziyASnCq+EcRZ5W?=
 =?us-ascii?Q?74ZRlIQfNaDeRlJXjr7Es2SgHyEzwZDqwIYfCurwRkjHb/GyOUa8eVSAWliM?=
 =?us-ascii?Q?9nu4ihWjOnoBsY2MdO9ZLQGMnTA2dUxFrk4VI9FSPN4hMNDv28mVwihSwLd4?=
 =?us-ascii?Q?QtDYpjI6tZ4ov2Qj7Ku8SaW0CgUUQhAdealRgL+T/ENaMvdnhNd//9W6mT2R?=
 =?us-ascii?Q?x67QviPjHaMSmLWESqu3DaTztEfObc8Xnxyj0kCF0snwS+U3um0nDJYTpBSb?=
 =?us-ascii?Q?o/dXWgGV5D0LUEwBLMLtqsB2of2fq2iptOEnPpC/x+lF8hpX34oHMujyGED+?=
 =?us-ascii?Q?2xuvcHqVqIa2ti8t9Arb1ahGUtHTKh/oXfDWvHnGWGQIvLN9Gw8WDHc49bhn?=
 =?us-ascii?Q?LCMatd+OnSv5xanE6y5zUJ4xOfaKVnyIAcX5fPtn5uOa8HdNZG3ttkrTKLvb?=
 =?us-ascii?Q?WF+XZw+FJSbaJD50CGb6Y3TxVR//y4dnnSakTA5PdoFmhMJPC2zORJv1cKhB?=
 =?us-ascii?Q?pUn7HJ9L7w41J/za6ydUSbRfJSEGUsSY4PXIk7suQuUoHxHkI20fJJgYumTK?=
 =?us-ascii?Q?23cjBsHd1i1YGOzbo2G4KZLMBjnv+/jNtwAQT5quH7Sx6quPk3DQe+xLq8Xz?=
 =?us-ascii?Q?A6/ftQ8oNxC+jleLNsex+7vgFhguzNXWsEw0bNo/k6atXeRPbZ+SblQDj5uT?=
 =?us-ascii?Q?WPYWMIkSV6TZlhKpzfHZL4Fn84zxKQ7iMTA+kRH2VBq/N3yI8pduPZ0rWYlE?=
 =?us-ascii?Q?dM6/kAJjvGN7kDTT5pTJie/MGJRjtjoeDhzWsQoQVuQ49FqlThgilP7ju0xq?=
 =?us-ascii?Q?ZXVi2/ur82MmdMcMIrWu5ThBgvq+jrLxbKL+5euKeTBS7pygNgLBjOVj6LFO?=
 =?us-ascii?Q?5zQnXWj7KCRzzClN6BJVp/caLc6rYgCOwe64VQGVkv+11s7HnSNJFV1cE1yB?=
 =?us-ascii?Q?uh11FXCapok=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YsSfJaP3EngmrOQPXnJygO+XuS0l38itvKzHfgY6ApuFgZfQ8Smmn17Qw/4L?=
 =?us-ascii?Q?BnZXf1w19Xkw9rW1Fw+oKMx+ERV99biOOfXp0bjgK2/x5EQyGXJ8DhTdq981?=
 =?us-ascii?Q?Fw6djPo+mV52Om7bQ0xzS5NtNLDW60bv14ETpqS8gvKnPsMfAtPJNt4dsNfI?=
 =?us-ascii?Q?qnB7wNAM5jrfN3lDf5FaI7yy33DZhBK6WsvjUpyoJEkdsrQsvh5J2PRWc3yI?=
 =?us-ascii?Q?JzRzsO6P80TJRpuLJaC4q0qYrEUgidluVWhKzPn9dmCOul87EqW9qGvRIgYd?=
 =?us-ascii?Q?EIl0sbRitnwOS30E0PyQHP4+aXveg9ZFSns4KRNF5eeQbut85l6C7YOYHPFv?=
 =?us-ascii?Q?rDMH4wN0CnzKIKMoNCmwgziuOstHACy0eSizMmx0ETzIvDUZp8/JZ1dANszf?=
 =?us-ascii?Q?ArVZuC6NtjX/GM4LF0YFCsYI0lA4A8sdnqvbBnbDLTmzC9F7eIQE7Eyva83P?=
 =?us-ascii?Q?5M9yONZEfcAgwhrBa+VvGZ48pNwQtc9iD7zXxV3P4EHLdSjomLFpzHq6dxrd?=
 =?us-ascii?Q?xBZ+Nf5N32UX4ozJqCRloPbiAiSq5eNQPWExlXmijFMItUtrN7z0UQeIyDfn?=
 =?us-ascii?Q?p3Bf8rAKqF2LMEOhAxpy9W+tAVRT1hgFyfeaolWsdnR5OlBlnnCEsF0P9YP5?=
 =?us-ascii?Q?vCypjt6WeRTF0PJr08SxwDANYj5q/h84TG7WlfaeLRScxgkVrXiz2qp1ZmOp?=
 =?us-ascii?Q?1sRu4rFp0yveXBNZNrrSVBsQsklxEOQvz74FlAifzTwwXbHhMDyqN8YYgNDM?=
 =?us-ascii?Q?HsHKZ555mxvvhpiMvEKt+wRVRm8Dgt/8E2oJgEM9NtjF48ukqIRwl9uO/DqX?=
 =?us-ascii?Q?8+JFVtXV7QA1zMr0GiHzCMDhX5LPrfIATkGYBhDKVl6sQaf8Nv6F4AluvEsp?=
 =?us-ascii?Q?p4VTfv/w7WtTVu5yX01mkSXQ7mXted++oJPj3aC5OnDOAQw1h8IFf61z77dK?=
 =?us-ascii?Q?WhikhEMlaT/rGhFHxbJ7sE0Hi5xTZ/aoptGU2SAfhMXIASWxT9KQU74hUlQR?=
 =?us-ascii?Q?RWydvWQZAHgaTS2fsTPt7iUL4LhfNghMEjQPam+u/3uOpHVEmoRvx/c5wvo4?=
 =?us-ascii?Q?+V57rJAeWgyPxR0PiUTe3dFGbpXcf5vvUSDplJ/58BlvzdJ2wHVadaW4ksrn?=
 =?us-ascii?Q?mlRNAuiEaJrbUOInkefB3eoenGFjs25WGpMoeg7+pK7zrqr1jKUKygXwMGTS?=
 =?us-ascii?Q?xST7gJ71AeK4aInlBjRPYZP1e8mxvAsYMrMQpNZVlEVGKCArI6eTgIeDtgHa?=
 =?us-ascii?Q?c7ieWuyb4dJm5uxE0wKanPjCrPFnRFDnu9+LkeF8a86xf2WEqDglOOiNNCkl?=
 =?us-ascii?Q?K4/BVh2PyQ4Ab9CTKl4SjH622KTMKpkjzs13ArlMIkgE7ZN1QLcnPdosEdqs?=
 =?us-ascii?Q?HKe92m3zFKGWxRb5bWdsiUkbPZiKQXBCl7IdReuSLYQOzSeP33O0N1f1cYlx?=
 =?us-ascii?Q?x4Hotzl2jNg4eTjV/kYdQX0x9DYFcinR0Z0/6AazSI9W2O8/EZEhARQePbxw?=
 =?us-ascii?Q?VdVm/+hDMkwoU8fF2AXWIg2u8b+1IUa2Xw3GUhJxSjftvAI+3IhatWVZRH0n?=
 =?us-ascii?Q?y9F4MaxQjcMwEZGNc1+3+V09oKL9k0eDT76wERcv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mldYcmSsNRBXY5dHb2yfqJtVwtmF2lY3lJ6tJN615lR6DpRiFUTZRxigvYX+KhjauDA8XWuRspjage1HoAZfOYV2nS9wdws0vaFxxLpk3V1Z9GUN7bWBoSw9P63WwvowzH6maH7dUHTu6AQ4a89WeGLigwxSFAyVLxt1XkDrvsAVEfXAARN+J0c5/jJEUwq04VwNRNn4BZhGHf8tGdLEXfDZ8gTOrMEXOGgpsGa5xHd4YN7Rv2b1XeMWeZGziOyhundyGSJ68dUISvslPLgumpkqYs5T+O74FRTYWa2P9f5nxlXuIIJltRASJ2wuCHs70t4QN0cL7AUBDpdfCwkSv5gwnh5plneNOblVlL9ZaT5ovYPPol8IarcnLtbmGVc8AwHvCscMM37uW/l+T9Gec/HapJ+SJsau4OYXuO7hWjoENS6G8ZwfVCL2/lRve07xiAbWxhAOJoI5g/GF7F26znBBTdWeCUWtQyHz9R08SujfMX1R8XyeCtlnb/CyxFK4SHUWs4p4SpD0UpXyXsNFFY16vJ5Fx/wu2wvWQNfgtnJ1ig1qKsxdMwhKqgXcAXw0F4mS+qBMZ+ND4u9pcLQv2ozmGEaWAkEAUASUS6CangM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf2b1b0-333b-4067-55f7-08ddf1ea8b9a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:53:02.4775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWQObKBNig+wzKqASpaWtuJHb7mKrGs3c8x+gkO0nW7GtBLFWS8GliaVgEWx9xShI8msgRi1n3HENUn190BrGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5979
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509120102
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NiBTYWx0ZWRfX+A5HRoCh8HaH
 /KIPVJUpYUsvg4NxFZsv2mEBLKoAWA18sS7UtSvSHwjvbIlidUxI3E72RQl6gdn6n+xowPvGrIg
 Ia4cTPSW0J+1ngyhe9WTkm0AjYCac9p3qtEj3h5BNugvc6Te9qBsckBwjh54Hn9IqZGhLVmggQM
 lqDc5gMGW40PCm7SkBROxDPDLDBnT3NXiNHMbSjdK7ad15GcUitTedsXA60TQjDzN6VEJD7RiF8
 EVew0W/9RCxpmqwKyDRGmeHu3jsleBHRjK7pgbzKj8ebxcJxZBMUEWWOKmNWvwp3KG88f16Lzjt
 K12J0tqN5f9LUC7YXQaEBtTKVMbtT19+Uw7hYVKE4myWEb9SJAmtOrRy43o6WWvieRtWwu9fwSe
 Zz3qQskT
X-Proofpoint-GUID: GychikCf4tB2rFxh-NYmtEA2gYC1C0EN
X-Proofpoint-ORIG-GUID: GychikCf4tB2rFxh-NYmtEA2gYC1C0EN
X-Authority-Analysis: v=2.4 cv=LYY86ifi c=1 sm=1 tr=0 ts=68c3fb92 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=nV3S-9ZYvslrOZ1EEj4A:9
 a=CjuIK1q_8ugA:10

On Thu, Sep 11, 2025 at 07:02:39PM +0200, Vlastimil Babka wrote:
> The struct slab pointer has been obtained one from the object being
> freed on all the paths that lead to this function. In all cases this
> already includes the test for slab type of the struct page which struct
> slab is overlaying. Thus we would not reach this function if it was
> not a valid slab pointer in the first place.
> 
> One less obvious case is that kmem_cache_free() trusts virt_to_slab()
> blindly so it may be NULL if the slab type check is false. But with
> SLAB_CONSISTENCY_CHECKS, cache_from_obj() called also from
> kmem_cache_free() catches this and returns NULL, which terminates
> freeing immediately.

Oh, I thought it'll crash even with debug caches
but it won't and I misread the code.

> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

