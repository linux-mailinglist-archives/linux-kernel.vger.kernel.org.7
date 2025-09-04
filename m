Return-Path: <linux-kernel+bounces-800756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1846FB43BA3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A54E57ABE16
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03B62EB5CE;
	Thu,  4 Sep 2025 12:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HJxtBmAq"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728E22C21C7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756989038; cv=fail; b=Sq9PTbJ8HItPawp2PfjFW2LKeqcNajstwMXNKoyGo2FHcVMZXmWkdx4Pxj0S/ktiLXlAnEZFOse4xFX0PaVUpxVwyh3chQ9PYxzdm4t1+pFp463UGzSmrWw8Hq9x5R1baZCCPbnDbZ9D7Y6lUszLefaVdi1O18nDfFu/iXfKozY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756989038; c=relaxed/simple;
	bh=rrJ8W3KbFKnuZgTcy6Uzyi8X8PcSF8JDOWcqKMyRgQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iwbtGRe1oMhv38/Gl0a8qC43N2hixr8RvXWKBCo/be5FdKujC3D/3NjZza+LeHZQGxOUZ7B4dbgBLwyIGuC6Mi3KKhZHzrccGt6dA1WHZrfPD7Uk7p9qo/HhMoJwwAfSaE92AE1SBCIWJshnC9r0cohHjryn2xdcxmLALJbB0kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HJxtBmAq; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGghbrEVzY+yIgC50/20SqIX0TU6NK7ynSfGxLMp/6PBPqsc2BFKFNdzmfXzr6moQFfxi2rUa+U7EpjwtxtplNBQndn7hYK9cYdThObDTWSimfP2xpwJlmMKNfYP8u6nb0ID1jxVksKVCPsfKCbp28QiCuQfgEoruSq7WNBuzUc+QXPpvK/n08Yixjov8k7HtlsV9+lLuY9kB/J90rBso/6ukYV74KZzxpI2QTOCux9oUlSIxaoJhJHPVQSxssMM6ZR3q0e/PTlS1M42WcnuMYri08PHN9k48xxYjnrfXSPsOhJCPCywsMptVvSDjfX7EL6NFKlcGZxvLcE2uL8Eqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1iKONytI5VprWHix9kGVJSDeCfqd9fAtCYLYsbhXHE=;
 b=oLtOhXJsBgeHvaoW0wzHKivubBqMNQn8FEsBb3UtV8d55+ZJ1wzqlYu4fma0gjD9lDtaXGRc4S8aiNJCVeStFamz7L+GEOCj7ChnHL7FXMtyGxZMZSHVNuuQMj9H5sXhhZXA2ZIwKKru8e8MW4F4uCg8nFp/ucHZ3iCDR53BKTJVHm9Shq2TzW4W5uuvkDeYdEqMTg9HGuQF+MrBKu5IRITvPt+BsGHt1g4MrBYewla/qa47iQMIcfHSRR9fFf6HSD1OJ31YK/qw/1D5JNUBPF68yFbJEozay8mnW5ryPRjk+toC6+iqaQIGgi/WZFfw2i+fK5utCXbsZtbT/1PtpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1iKONytI5VprWHix9kGVJSDeCfqd9fAtCYLYsbhXHE=;
 b=HJxtBmAquUbav++thaVI1VY199kiX4cTkKjbwHzzHeINYHf/heRhL1OnWglJ4zTs5vwXcGKObY1nvbLOuvfS/q1ZdnPuLquV3wDYJB5pqD871FYycFsZtZKMxoyFYza5Autq4CkBcnOd1o3dnwe80v9wJYpJsO/KO+1vOY3SIJi+rl6k9fj/MAj7rm9BJ/KRCElDpWXKFHB7FuDR1Wg+UivmbeIuqnn4yp2pabpqUJSdi9a80Td3b+cT1eGghtGIytOp3UTGiruyXyUao6FXfOhONV+JGruFoVHs+GAW1fhMPIq4Mvvb7aqhLJP+qeUsRS7FV7VFW274wdz2PmD/xQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 12:30:34 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 12:30:34 +0000
Date: Thu, 4 Sep 2025 09:30:32 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>, Chris Li <chrisl@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kho: add support for preserving vmalloc allocations
Message-ID: <20250904123032.GM470103@nvidia.com>
References: <20250903063018.3346652-1-rppt@kernel.org>
 <20250903063018.3346652-2-rppt@kernel.org>
 <20250903125620.GG470103@nvidia.com>
 <aLhg2Jli0KUe-CXC@kernel.org>
 <20250903170631.GK470103@nvidia.com>
 <aLiWDl3sq3RTkdfJ@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLiWDl3sq3RTkdfJ@kernel.org>
X-ClientProxiedBy: YT4PR01CA0383.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::29) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|DS2PR12MB9615:EE_
X-MS-Office365-Filtering-Correlation-Id: c2c4e4a2-066a-4e6e-26fa-08ddebaed848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DVrQn59uapZ8yqZGTn1kmGwxo7h9gE4qNnlwQWbWg2iRIBNGvkSEphbpv0+T?=
 =?us-ascii?Q?WVxVdoxIlw4TfpTpJc3zNySc5D30KZWLXy3Sel/Y5/YLT8CPBgRc7Fww5LGg?=
 =?us-ascii?Q?xKzq9wtiEQ0w/A8Z/65+j2a/+DQ8ZT8QVC7OBq4oMHuDX/ZTMSUZSuUdRXGu?=
 =?us-ascii?Q?q4h7xnZozC6u0zOWTNYYrA0yU4FO8wFypETL4lmf0rsQofHaLoqtswzA9xHP?=
 =?us-ascii?Q?iDU72360OC2AWYGB/zY6hk2L34wx0l9YKD16HMO6KhRNmRiUi4CR86S+oxSV?=
 =?us-ascii?Q?FpGFjLs7RSEN6yklp2K305SVBb0RaxMYcQipzflIN/gn4XgraKzUYMoc133t?=
 =?us-ascii?Q?DfBokQg6TNVK9EgW85K0zk6EaOaL5FWz/Usv77UgkUreLp9F6Y6WXaU7gY1A?=
 =?us-ascii?Q?dP2HUUUPmQHehJabA6Wu4L79Nm8EOyHh5F8z21CcaTLT6DdunwGbNQVNCN6W?=
 =?us-ascii?Q?ikQURD/22MbLEq7fISf9MaRlf8I80lw/chBg6pURN6XJZsPepVuWbR/5lZjZ?=
 =?us-ascii?Q?4IGKvyyQGe881qQv22fueP88SkvIc/7AJjWMeFI67w2iTQzygsLt1NRVYGJt?=
 =?us-ascii?Q?m5iY2eiwsXCHqvmgYBtU+sZ0aVsE7zgSZdkrHFViox+oyB0yCOT4elzDwRdf?=
 =?us-ascii?Q?C1tDRQmL3IBlR206Zhpl9yObUDxerfIsX2ne/wOVzytYDtwlQ+SWPWs1YBXL?=
 =?us-ascii?Q?MdmurIr+4hAQnfRmO7IBgtJP5OLxImkD3whjpKLteZMNIAGzUb/l+Tk1RRUU?=
 =?us-ascii?Q?KmknoPCLocKTEwYUebpz7FHFTbSd54UVZc80s9wyASHUMrf9nZ5DTO45OVSd?=
 =?us-ascii?Q?ITsHHJWELqqikLFcFSO3VZX7I+VUp/M4MboggCmfVY2LhKYxJ1lxI0cG51vL?=
 =?us-ascii?Q?tcUoPdAxbBbGuTeUtaqE0NLeUbvpueOq9jPn0opr9lOFTYO8l6V+Hq2jal90?=
 =?us-ascii?Q?8gCvdqp0fnRvoYQEY3gBUK00JSrU6jEq1+2T1fHKp1MBi7eDUnc9W9mO68X2?=
 =?us-ascii?Q?jPoK8nluMWITFKwiDpfpGVMfbqP6x3IkhpD8d5lT5L/ubPIr4+oO7OJ23qkT?=
 =?us-ascii?Q?N/yy/LG8SXZqoPPO45I/DSfNzdWuR51U9BOL/8/GXXKHiBsZSUPc86HliGRH?=
 =?us-ascii?Q?1dXSSGfJ4Gne30u+Jw8Sg/jkCRW+Z+7IF20UMDsIL3nU9Q5G9Rff4Campt7B?=
 =?us-ascii?Q?EZ3UIp1youZMqXJwL8S/PbBH07pWiKXHhc75H8n5hTtcTsmu+UFkjRNG8vYx?=
 =?us-ascii?Q?xDUKYuyhWQBwJTSGNe8KalcP9ETjTIa8yWa3zZotBBGf+Hf/5R6dLuHu6jNJ?=
 =?us-ascii?Q?L9obE21AY6RL+2eKAgUKuqEgiMqWsozXSfROPWgxJtJQpdDf7/vzwCDAr7/m?=
 =?us-ascii?Q?Q9awKc2JiY6Wz3wg8L7oTUWqwHY7OGkCxExfEm17FbkJlAa5V1ULTQJG+nPE?=
 =?us-ascii?Q?lNhFbpWU9g0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H1o9yxe6b8vtVcIKc1Fz/73GMYwvwRKi6sS5wijfAF51L6mY7JYsP0VII7C5?=
 =?us-ascii?Q?Va6DvUSj/T4Ead9YGFgQjygKc4Yw405tacoId0Og9rtI9XmmtqQ8HjQ4lZux?=
 =?us-ascii?Q?uqvQl02uKqIW+QOwmnbqgJSDut/DuAxV7OcH6mSLAmBuyoWCSJNNtsZ7afZf?=
 =?us-ascii?Q?LtVKxRU0MvmQpc1urUQw6XkKTVWDeKJIl0D9rXKDcXiXYSnjdeYNnNwb8QDk?=
 =?us-ascii?Q?OPCsqQfj9psYb5EMQEzrEmkVnbMS0ROKWyZQt67oZ07mxpwxSWnnmPGbtAWV?=
 =?us-ascii?Q?DjwAFf6X2SGuE+LvoDD/owL3mmYjWKdjbW1+NfRI0YEO2fAHuhdpwZ16zEA2?=
 =?us-ascii?Q?9i+mkWwPKdsz6Jls1oec5qsKFSz18A4YxJ3UWknw6rDpr8vZBNHiypM6NFTH?=
 =?us-ascii?Q?Bjx1x3qTaJZFBrWq+Z0QRen54VY2bZM1gYBk/ODdpPO/3pqH8ReFTMGYXKuU?=
 =?us-ascii?Q?H3Qs+SbgQgUbzDsccJxeby+6zzmw6cJ0uez9KrQ9XlrsO4TPlf1wGuexDnlB?=
 =?us-ascii?Q?jxsR4zj+3Lvc/qgzVpDGvCcwuPpA0jHgyW0nW75kkvaWxr4/uKDxZWEkWWwl?=
 =?us-ascii?Q?kdj/YcGuCCECnXlKk1t/HcuhwhBh565Ebn5dYeZ1gtBgGN9SrqoYyx1DjFqA?=
 =?us-ascii?Q?IgWPNfw8CNVs95iyB+DWPPg8wER+S/wSJVZgZ3uj1MepQ5BM6rwYxS6sS8pb?=
 =?us-ascii?Q?5ZhN774Q8MAzDZYax0chQGpDKBrQPBarNWiphn+0lbjL5rY1PSKDtR0ZhgVl?=
 =?us-ascii?Q?62vMs2kcAdcq3If97rP4YgqF5sGOdmPkwUubQSfbJqaVg3kCVKVInooZUJ6K?=
 =?us-ascii?Q?G42BtYMt7VvjkIabHApV5x12vc3IXsp34TNcxeMzXIDn20xN99PE1nvtWDO8?=
 =?us-ascii?Q?sH/ZmIoud7yfOVszbgWVuigdS/D3iLoBL0RXRSIvrNTKWM/e4D6y/33PO/Gf?=
 =?us-ascii?Q?GQ1AfTrJDjPMQRqqLHHnSKUboqtPAlp6Lplp286JJoYAU86+0u9qiL3dt45j?=
 =?us-ascii?Q?k1zUdP23w2rxBDx/sQ3rtkHtxpAaYpgmrNdnnkUuNFIugzjf7BUjOiZ5I7ep?=
 =?us-ascii?Q?Fr2YXQKWoH9WIMAszJ4TVn5Wt7KreTXHSPhrLWLrnM2voavUybu8Wuswzbtl?=
 =?us-ascii?Q?BtXaHRaHShzZoL3BjD/BURxcrrDa9fses17K2bFtz1FVD/SytFuoJGxy1JAT?=
 =?us-ascii?Q?hBTeKAzw7IBfP/A0dS4MtSURvzRJ3FBENsHcOH6evp/NNln3ZBl5Ed4s5nvD?=
 =?us-ascii?Q?fMVn3OREwBaVS6hVZw5IJfW+uBDE5uwF/lnLzagVz2gjoPnqWGZ6lmzof7mD?=
 =?us-ascii?Q?9QLuF6MCNR/w9gY92zWeWoqXGhpt9izY1aP5llpi7fBrIXSKpyQ4BtEbaFCY?=
 =?us-ascii?Q?BCJ+WMyCrzpUQclZZJEdLRd0typl5J047AYC1IF6+BcsuUw4MXZvXyvHJOxs?=
 =?us-ascii?Q?nZd663ITHMmVwdUqTkQvaoa6Pe5y0e4otn/lv6DmaDKZGWYK5pMSzgHRnD/1?=
 =?us-ascii?Q?/1STUi5QakcIGVmo9FUJrv1lv9rh/eUE0Vo6xXCpauho9mIO8vvq7Ctr2E+u?=
 =?us-ascii?Q?HcHGayrIjGIUg51PLjo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c4e4a2-066a-4e6e-26fa-08ddebaed848
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 12:30:34.3246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p430fchxrdDiDCPcM0EAQRSF8nHK0qfyTH8YXGX09BjYgMbuSzGm5dVC7cOHFoyy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9615

On Wed, Sep 03, 2025 at 10:25:02PM +0300, Mike Rapoport wrote:

> It seems that our major disagreement is about using 'folio' vs 'page' in
> the naming.

It is a folio because folio is the name for something that is a high
order page and it signals that the pointer is the head page. Which is
excatly what KHO preservation works on.

I don't know what the next step is when folio is split - presumably we
will get a new type to represent an abstract memdesc head of a high
order allocation that the lowest KHO primitives will change over to.

> I'd rather stick to the good old 'page' and when the time comes we can
> 's/page/memdesc/g' supposing Matthew actually plans for it.

I think you should just convert from the vmap page to folio for now
and most likely vmap will stop using page someday..
 
> This way we won't need to handle the fallback from divorce of folio from
> page. This indeed is less relevant to KHO, but there are a lot of
> folio_alloc() in LUO and PCI patches that will have to be changed to a
> different allocation apparently this year.

I'm not sure what to do about this, really we should make slab work :\

But yes whatever it gets changed into needs to have matching
restoration. Most likely we will get some kind of API to allocate
PAGE_SIZE units of frozen pages with a special memdesc, so that will
need to be paired through the preserver/restore as well.

> There is a struct page for everything that's memblock_alloc()ed. And we can
> do page list, but for large  physically contiguous allocation it does not
> make sense. 

Arguably you could make them into high order pages and preserve those..
 
> I'd rather replace kho_preserve_phys() with kho_preserve_memblock() and add
> a restore counterpart to properly set the struct pages for it which we lack
> now.

Sure, but my point is if memblock physical memory has struct pages
then you should be preserving the struct pages as struct pages not as
phys. Upon restoring the 64 bytes of struct page memory should be
restored back to whatever memblock expects, which will eventually
include the proper memdesc value.

Jason

