Return-Path: <linux-kernel+bounces-810576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F277AB51C97
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA2CC7AFC55
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B1032ED4C;
	Wed, 10 Sep 2025 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O75m8XPE"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8D724113D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 15:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757519758; cv=fail; b=OOLmESilRmCJXKVxVfT9jC3zpqdeyWi8XVVxGtGEKakMv79EpwJ7BNeKsaSIDPuE/zHHrzejuAs274EpfCr2O+c/uvi1jBf9bzu+f5opsqc7bCTlUr4meAhr4tLabrotnrPg6puF6VjCUzvu9T/rBren5Sry02vKSL3aBdLscTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757519758; c=relaxed/simple;
	bh=0edvQ9o09bseC83Gc9DsIx0Ivh1SvTo7WZlxwmFNp94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OKCT9dogtpGCyznNYGAkNOY+qaPXeyZ+/RhjNYek6h9fG24ziMpnKnvsKq35iRfFvweHujEZb/FPUO66WgdSJOrcCc+Mk8EviB+DvYqUBD70Fy55umo2uHCkMITnAtockPuPaPxLI9SqnSdbLHjroRCshJlpzTo1y3gtdhDEm5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O75m8XPE; arc=fail smtp.client-ip=40.107.220.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/aN/Ap3BHV6pJYwkwKXah7d5/hNMWYKSuLS+rhBZbyspHJk2vDbVi44QxsPJTsq2QO/9aF+dzs1sg8zAuaNFbdMwyq2HGet1JPA3zHMaNzaZxfNV1PyAkBcMAQyxsQbugtsrQIG5ENDdf1zVCLoUR++fM6RUCD2jYX25CZwwwzUs3YnM46yI1Gwpej1ApPcgpxp3N3WNXI+FtWPiYYvCRwlDlbtMuiCM9wIxyGN1IQlLnktW+hziXwsmP+6vs7JnvcVzwT6/50x/iLBPealQtdNq4asnB1zKFskEp5UFo5FgMLe5f0mSM8l2p36QFMK/ZIstZfpdIH5VBcyqpfmhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecNQJ8L9OxyjeVCtUGHLNP/hxHpCw7UcmTPbPIc+ph0=;
 b=bdHEQMw3VBf7TN7duta9Z/NSavtwLJOEaQJvCNfFw4lXZnBI28h5Y9e6tpYpiPqVJJ7RYPxnKejCxqRXv3qoEmLn7Nz29LUKI9bHTwlkssX6xsP58HDIrmNzey0GJWbemy3WfaRe15dRF5LHS4uYurqU6mShQ94+WTYYDpY3u0WyA9Gz3ztyZ4oG3q+7mIoimqhhvCO2osUviTWfMgAwMYbDpZrhUh9KkMJJORnYHSdGPfmg7ka7UKFpI9Qi6LB196vNC9pCNXING3r0TWyBP7R1Pb6Z45d9JEaAlxZsDgKzGS9ziePmjZyH2Eow2Qu9FcBXkF24FbXoVZCgxhrEDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecNQJ8L9OxyjeVCtUGHLNP/hxHpCw7UcmTPbPIc+ph0=;
 b=O75m8XPEjYwsRxkE4yHRG/dRu4DAvll5fI9FCbND64IXOZA91f3dbByjYind70N2JC5Fu9i8ZjxCbPFgxoTbU+JiL/8hbt2iEflOYInhrukcnE0bEb7hSNKxHSP0oRGSxIgeb/W92AwXezaOwvUY53maxnO2N8GNeoFCxM/G+w4UhxesUpacsgX6OqbW6ibDnvXE9emV5nQ/L+o3lIHJ5AGYaVydBMlqf07f1Puwnqqbzf+qccOqGKtgDO0UyPJlRoMJuzKkal/TNqAArRh8RXkA/nno5xzZ4ESCU+KztOd5GyZsuL51GBMHucLk1ayF96Oyzw8yLDKCrKb6sTKGpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by SA1PR12MB9513.namprd12.prod.outlook.com (2603:10b6:806:45c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 15:55:49 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 15:55:48 +0000
Date: Wed, 10 Sep 2025 12:55:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pratyush Yadav <me@yadavpratyush.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Chris Li <chrisl@kernel.org>, Jason Miu <jasonmiu@google.com>,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] kho: make sure folio being restored is actually from KHO
Message-ID: <20250910155546.GB922064@nvidia.com>
References: <20250910153443.95049-1-pratyush@kernel.org>
 <aMGc-ExhkqwAyY_C@casper.infradead.org>
 <mafs08qimjoez.fsf@yadavpratyush.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs08qimjoez.fsf@yadavpratyush.com>
X-ClientProxiedBy: YT1PR01CA0146.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::25) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|SA1PR12MB9513:EE_
X-MS-Office365-Filtering-Correlation-Id: c8507a99-ff1a-4c50-d87e-08ddf0828267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HHJxuWHqfmlvIp0e8jETj5LZWHi4K/ShZtdBGzjQLLd5HPLX3kGEBY5jfytR?=
 =?us-ascii?Q?2VKi3FRcevOiEZkX78nk5PsUFgp38iwrl8Jt/teKu4zM+ab2ghHXmdZCEEsc?=
 =?us-ascii?Q?AWC8/6R9By3p9if29zF8PY7hOCvZWG4GFaHi+rdvTyetRibA88RVUmCtr7Cj?=
 =?us-ascii?Q?fEhKQUJ71yPtxC7aPRIJHABLirz5VRTteRVK5kg02681F7alnd/P/ctAXYpk?=
 =?us-ascii?Q?nsWdr4pSvhMAwwD5ssWCac0F4WWZxlLX8lwRpkJWToSgdxBEFpY7HtzL8dji?=
 =?us-ascii?Q?2wAuKSB5qJyuVwHu31dZYiG+of/QD3K0bWnLVAzoUYIqDgdtVLv8I7CJvQw6?=
 =?us-ascii?Q?Igwhb8XzX9aRE3Xlm02etiB2Ie+A3lzWosn9Q5j3mBisPu1kIbF3xfwXcJ5l?=
 =?us-ascii?Q?zrUbzlw1tO7SnYwlk53gYJ4qzkp4xFAVKXOVCI+mN/tU6tBIOE046SaPS+go?=
 =?us-ascii?Q?H7r1wLRH8AWKcLXFVw1n3kuxWNnTvj/apsw80AyWkJYkPCfuUozx6iMnpVaE?=
 =?us-ascii?Q?/9fHHAt5mllxZtKqsdQpTX6e2icCGs7ckw9at3xc4++N16viCCfgOnwJ9eU8?=
 =?us-ascii?Q?+v6zyFRzaSH+hCLXRWCDTsWpuO450Jsy1RQGqHrmYXAxw+dDCZ4VkC7flws6?=
 =?us-ascii?Q?udwRA8+MiYQfjusn5GR/+feJ/Hs1tR8eHzsr+EuHPmjzLo1O3N2Wpt0eXLUi?=
 =?us-ascii?Q?mUkPehOsQXO92eiSa05eIn6la1RD0LQ9aDZoQmOgdEOgOEvXHHsDClt4XdN/?=
 =?us-ascii?Q?L+bXjjdOg5VYjaxFeEGA+3urALPybb/D9I8eUGCC3se6lQ6sMiB+PSdY77Fj?=
 =?us-ascii?Q?fj0nmxf7yRqapeZr0lGvmDw6wa0GuGLZmNCfxd6r8Ny8N7Sr+P71JXBhnB22?=
 =?us-ascii?Q?96fgF8kL1RMXGqY0mfa8lKznPpf3pleB1kDyiGD3RlaQUPr/bVic4kFwGGlB?=
 =?us-ascii?Q?9+FuA+rSGG4Xr41GRt2jyf2rOIrDihJfeKKVylBopx9jn9e5zb8er5iIKEg0?=
 =?us-ascii?Q?ObJDIRq4LZeUMRG1agcEIROHjvZQOUBNBWzQXWj9zj9nU3gU6+E+RZL/DKs8?=
 =?us-ascii?Q?ZBoOIpHdI02bXDDhwjaS+Ly9rXGoDPfJ1QGMCz6ja25a7uZU1AiQBpclPgYK?=
 =?us-ascii?Q?XlZ8TxR7DkyO2hqj4GB09cxZ4Z658yRm3Z0KzPTrvPAz1d+omdNKaqjLKoZE?=
 =?us-ascii?Q?YCiswhQuBTnTcs5vMOymoq6Q5bmIpuDS1LCJL0jW+Lf6Uqju8Z5syuilActb?=
 =?us-ascii?Q?7fEAf4l8ch3wjZ+8roU/GF4hia7B9XiuzttC+zvnPs8uIV0RSqYjkTNf5HYZ?=
 =?us-ascii?Q?YZPzglzqv4o8pS0Bg1zyS1+fchZf2Lw1l24xxHMaAI7Bj35er6HfmzoXaeTV?=
 =?us-ascii?Q?tCEJKmqZeoLLiuaXEdUY35PaXnWSUyNrYGZoBfgpUnvrxSa3PwzRdWnonxbF?=
 =?us-ascii?Q?l0L04OuVXRg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oa9x2sqs2y8BofV9H7oBFyi+kFbvfBqpQk5RA1NxT3Z5jDGVI/Wa1TxelPrN?=
 =?us-ascii?Q?1GOo6MQCNCpEfl7kJFQ/9QNxsWce9mh7+2bstWxX7o15hwPL9BObGw7sjvDe?=
 =?us-ascii?Q?9SQlmHpUzTWpMm4/HRLGHwPeHRMcJif0NCL6Xpud+NVEHPlQSefzZ7ZqYMvh?=
 =?us-ascii?Q?u9TeKvfpISr6OU8HTqL/1ghsqTe4PW0l+VB/++KSrnGG93LERDZsywRvDeie?=
 =?us-ascii?Q?3WsR/LeqD1zGXfWDh2o03AFM0EfJJ5P+PosMZt72RpUM8l52VD7CHX3fI/qQ?=
 =?us-ascii?Q?wXUkHYaTX4F0Sv8guUClPHwwOx0/tRADCCEJcxOk0RMyYEZBIVLvmcKkugN5?=
 =?us-ascii?Q?WLA9A6Uioj2Ka9eb91eVw2Ryeg1RkOz3tJfH8h3uZ+TYDXztfcedzv15Jm7x?=
 =?us-ascii?Q?YF+cU/ch41659XPb8QzFSkVI4EzyNqLW9fSToAC93ivxncV4Kmj7sHDk9dpu?=
 =?us-ascii?Q?FKWOryYRVAOm8aosW1S0gD4f5l9OuL7V4gQhdC6hbddb17BFOiPDV57Skqho?=
 =?us-ascii?Q?Xq351xuh9At59krRwWWc9LApnZVMHwO3+b9MOUkSyUS7gd1Qr0eVQPn5WbIC?=
 =?us-ascii?Q?IH8J8QoMyLaqB4/IJ9zjl9SkfNF1uQ0GSB47pfOPL5cF/YA+XZO6fzfSOV5E?=
 =?us-ascii?Q?ltSEE8KI1AxUVJwp3rBAB32BHY0jsigFfx8h36f4F/+2ThPJfy8xR29deZGz?=
 =?us-ascii?Q?MKV90OHkfulPqMY4vYEC/Vus9obpnet/pAl8Gr+rQS91hsUAP/hrELeiYaY7?=
 =?us-ascii?Q?t45w5tnk7zJ9Mbwx2mZyO0OBFTvgxoNoXR6wma+vZP93a0CcS9zxikklgcOw?=
 =?us-ascii?Q?AkRJub4lTtiGUM2IjJR/MJHqIcM78SNMy9DYhQA8UVEkN1NOlEFklDrKC/jF?=
 =?us-ascii?Q?gKu5sJFcaFV6fiyDQkTjgYM32TcgMILZ2TtN4sBE44yqIs7tp8MN0EmnjzK4?=
 =?us-ascii?Q?IlFKSYhGbi2nst01OJJAuN5imcfysGFvmdM74vhUjUuAQYS9AcAhSGQX8X8t?=
 =?us-ascii?Q?qZsJZ3nWJ48mNOcLkW25piZtNC1ZYOolrZRLhfIxSc2344Leh9i/XipsWHHO?=
 =?us-ascii?Q?vjIpC3EmRyD3iQ6cYoj3AtNMyM4150JyvJQn/yjnQXkhqcRs0F2lSoxDIjEd?=
 =?us-ascii?Q?Xbr/6ir7tOPcW6AZOgkojZjcRAWu3LcaP7Kiym6tEsWZSQCF+o6LCEatgp7n?=
 =?us-ascii?Q?kn8/yMKZHrwFtXQWxy5O4Xl5P8HqWdCNo0L7eqW7PFHBZO4iMnjwpPX3iOlD?=
 =?us-ascii?Q?LRYR5plPN31a6cgPn/2XvSSQtvqAFEMuwybn7Y+D5beceuDhQUYMIaBtYkNz?=
 =?us-ascii?Q?8a+bfd5jRU05z30ICXT/ztN5Awb96pkiCi726iPh0sXFb4LtecCcqXjh77+s?=
 =?us-ascii?Q?5xce2d9ZCehTVoGswaeoyr/WmbdqsE52JlRjEH2275wcxyjsU78wc33q916G?=
 =?us-ascii?Q?QSnfFuR81ydY+mLMzNTuBevVL3P5cOP6QeF0ofjkhg2UXSeW9VnfWhqRMuhm?=
 =?us-ascii?Q?eVYP3V/+4Gwd5dq0vWUcz0ZDvqXVOzZNUVVtUPb12bSIDxDXgZZquFhdYWYv?=
 =?us-ascii?Q?TTG/1yYNOcczdMC32Dk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8507a99-ff1a-4c50-d87e-08ddf0828267
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 15:55:48.2058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WkNeXBh2gzC1m+p3UUelpPsnRmb1I9ty0dWTY6xx4XvTkkvnWL7oyIjTb9RY2Imm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9513

On Wed, Sep 10, 2025 at 05:52:04PM +0200, Pratyush Yadav wrote:
> On Wed, Sep 10 2025, Matthew Wilcox wrote:
> 
> > On Wed, Sep 10, 2025 at 05:34:40PM +0200, Pratyush Yadav wrote:
> >> +#define KHO_PAGE_MAGIC 0x4b484f50U /* ASCII for 'KHOP' */
> >> +
> >> +/*
> >> + * KHO uses page->private, which is an unsigned long, to store page metadata.
> >> + * Use it to store both the magic and the order.
> >> + */
> >> +union kho_page_info {
> >> +	unsigned long page_private;
> >> +	struct {
> >> +		unsigned int order;
> >> +		unsigned int magic;
> >> +	};
> >
> > KHO is only supported on 64-bit?
> 
> Yes. Currently only x86_64 and ARM64. It is mainly for hypervisor live
> update so there isn't much reason to support it on 32-bit platforms.

Presumably this will eventually change to use some special coding on the memdesc
pointer?

> >> @@ -210,16 +226,16 @@ static void kho_restore_page(struct page *page, unsigned int order)
> >>  struct folio *kho_restore_folio(phys_addr_t phys)
> >>  {
> >>  	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
> >> -	unsigned long order;
> >> +	union kho_page_info info;
> >>  
> >>  	if (!page)
> >>  		return NULL;
> >>  
> >> -	order = page->private;
> >> -	if (order > MAX_PAGE_ORDER)
> >> +	info.page_private = page->private;
> >> +	if (info.magic != KHO_PAGE_MAGIC || info.order > MAX_PAGE_ORDER)

All the impossible checks shoudl be WARN_ON()

> >>  		return NULL;
> >>  
> >> -	kho_restore_page(page, order);
> >> +	kho_restore_page(page, info.order);
> >>  	return page_folio(page);
> >
> > This all looks very confused.  Before your patch as well as after it.
> > I don't see anything in the current KHO code that requires the
> > phys_addr_t to be order-aligned.
> 
> Right, good point. I can send that as a follow up patch. But I think
> this patch stands on its own without that fix too.

Maybe it is worth adding some KHO_DEBUG kconfig to protect some of
these extra checks?

phys should be pfn_valid, phys should be aligned, the page should be
in the right state, order should be valid, etc. All worth checking.

Jason

