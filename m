Return-Path: <linux-kernel+bounces-856608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CE7BE4992
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B10194EDCAF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB7C21578D;
	Thu, 16 Oct 2025 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jQGoijNm"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010003.outbound.protection.outlook.com [52.101.61.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FFF32D0CA;
	Thu, 16 Oct 2025 16:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760632253; cv=fail; b=FIVQUSirr6KXj++IXlWTAbvJomaztRzqB5Rl3pD4UQckmxfC2p/h0NCBsYaZBddNFuVoOH8pOtSJ4D97H7SVLccPvZl4H1g3IPfH/0O7SiuaBj5nhb9iBmev/VvtV+mpfEhuuWoIH1oM4zDfdzU9RhcFpZqzd5muGH+dv7TlnBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760632253; c=relaxed/simple;
	bh=KHor6SkoL7CJptIIqi9XIKTA60HzPS0IxrlnRPoH6NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LwqRmKOwYv8fi2HsK6gzJfbrufOgEe1p8FryAkQovBFkWvqofhjItPwM3NP7YcE303ib7DgWf8iS4W7RkNqQ/MLVsQ+7hHwZsU6GEyxtlb8J9EK3Oqc5lNZmhGBwacbadsA5CeacMAf+s8CSTzcr/DNc7XIjdA4WPagLgHp5HAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jQGoijNm; arc=fail smtp.client-ip=52.101.61.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejanqM8mEDq2qaTfc4BLlfHkTIdt188cA7u63tTJIgRgif1To+UtAJ0/tp9EetOTj9AnrZ+UQk3cByZ2Yk3/ciDooy7J4XvdhTi5CwPCSy9XPCs8dEVVMgwhom5ix4bv0W3jkRYr+/bdP+Z6y/eKqbuUfPiIBh2/w6gDdaQWdL+f6cCmw4MrcklKE1N51vI6uRWgTVW2MuEx59HckCqPuNckZDgnVIBei8PXXbLNe7KcZccb+xLPwjLb7hyEbWqANoJCQiSJPmFpefSGRF2quNOCwVQeNkY8qz0J3TwcB5E5DttFrLJ+cogQcAYa8eDgUvQ4ujFX3hyGQWsGiVfgVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRe85JRAg/jMgPTWKqQm/Bjlc8RWmuTn6oY7EX9GCgs=;
 b=iYAeSwAR1t1aNEItm7PYoJXb5N4dkqbJjdiZoa4KFdG+QDaoruFUZVqkHUc4uNtgZFx/gT72P4bjVgS59ZUjAeA53Y7pJyTN8bQVyE+PLD7k0/ew02aV95pHuaupaEwS+Aq1mfWsUytGmehRgV7IFKb7LfMbWkaOUGWUxHeJoCue+J5rqjC/jT7vDVJhwKpNrRnTltv8u2hViYRDxEDzlxMCEjSWBE748MwKPQpdS+jxhenqBzW7K3PKv4dWWFtrdE58Y0Ix9kAXDxlzove1Ef41jses/b5LJUdiAagCug7xtXqq41sqklsvFxsRpNNHb+0TbpRgKaUXWSpxGcYjPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRe85JRAg/jMgPTWKqQm/Bjlc8RWmuTn6oY7EX9GCgs=;
 b=jQGoijNmP+iA5BCb3a9EvHYSiKlru4SjxZG5BgXXDjY/+wMx6gXY1Dh02SUS/KxAdv56iWBQH+P0mFrzbZ6Msheyvd6gfyH89JYLN+8irNYciL+OWLDok6CjquHb28MJWKJlXc7LdxYx9czpld8a79D3UKcbp1nAZdV3sn78nL0T8aWW5Dvkz+2Xmz1RhmDAGHFD/HjW9vbmDRN+WZRHIG20bo+Awmppw0LyooRQl6fHKJh3hzjLyAMKsz8kMa5gA954f50wSCxBF8p8Qx0ZftlsDaey+bbhEATF8BRjlllVsCEtp4UIxv+lzZHdWNuhVcZ0pZZHPMOAF7idMvTbFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by IA0PR12MB7505.namprd12.prod.outlook.com (2603:10b6:208:443::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 16:30:49 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 16:30:49 +0000
Date: Thu, 16 Oct 2025 13:30:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	David Gow <davidgow@google.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] taint: add reminder about updating docs and scripts
Message-ID: <20251016163046.GB88213@nvidia.com>
References: <20251015221626.1126156-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015221626.1126156-1-rdunlap@infradead.org>
X-ClientProxiedBy: DM6PR03CA0097.namprd03.prod.outlook.com
 (2603:10b6:5:333::30) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|IA0PR12MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: ff5f322a-a258-4f8d-ba39-08de0cd15d0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YICuHIMad8qms95RRqMvEMZTl7mKSAtnREl+qrawscxjPDdHeobM541nJDpa?=
 =?us-ascii?Q?xNEyhskcW1ltWFOKBSZbZvaD51782Ri0F7EBXwt/cVV5eru0vmYbYEMVHPUZ?=
 =?us-ascii?Q?MG96EWUu+1DtBmm7GPbXYVFIvaapIeSayDsdpiPwXi0cQz5i0WTxTi3tLrLH?=
 =?us-ascii?Q?exfhP7NlXiuoOjTwWSdm0iC3l1d/HtjOERoI94grQayu6SMIDFGvFMF+78iK?=
 =?us-ascii?Q?Uj1Bu/zURxdQB8gx2kQHIUCkMflcszbbwcrKOZGLlMcLR9P2bdOdiCAkcK53?=
 =?us-ascii?Q?VIPGi/uOONRx+f7v+Ijax8QPWcpOaOPvEmb8sAKjR3Lm7FkzsFDoQRd+AnW1?=
 =?us-ascii?Q?Z2bO9gCE+/X12ND2Lc1MaXCw6dM8pABWDbfPCrR6Hm7xL+y9QAMDlem8AmrR?=
 =?us-ascii?Q?9WU+Xi8bFsBgodWF7qVxEnlce8ibZd09QagEyrjIZOJ3fNajQ+VlVJtz/LuC?=
 =?us-ascii?Q?v7AzBaHd3LkF5g33etjHqJKKiqzZUrkjtUjD6FMoNPLOhJz+66aB62EgjzNt?=
 =?us-ascii?Q?cQr20QxYUJF3lPHaZiheSfGMBdyvXNc2VntTZdRLp9dhmHVmcpSnFAEtDH17?=
 =?us-ascii?Q?jXRXmR4WhUUV8+t/kI2Kl1b7QUbKyMbtlrUGnw0VMJa/wf83mVLKGKBwK8/P?=
 =?us-ascii?Q?mVLGPjjXSB00gfzEmtPKtjbMaGTokTZF6wsdGZ3s/CI6frvKkK3Cn0uKJRdW?=
 =?us-ascii?Q?3H6J+McWlbGWeKVuq2CJFzxVN0s18ygiJ7Xd+fihUVY6LzJCoxf06xLFGb2E?=
 =?us-ascii?Q?XYch/ta7OdTjEa3t31M7CAVzKZsw9wwR77j8aP5mVNUYNGgrQFGuZCfXezlP?=
 =?us-ascii?Q?aKtM4P/gWyYyVd/XYV9+mEqn8FvuAFN6aoOIcXy47HQ06tODRwLAY/qHiyXl?=
 =?us-ascii?Q?giPnEK6CF8F0mBQGEzXRY+F4UymL0/AXrSPJ3hZ4f0oGPLc+xzAlQwKtgffA?=
 =?us-ascii?Q?u7WhbA+AIXxMVLProcNk9Naromwr7cpuR4xo6ZLQAt1w9Gko4Ukjudo8JR5t?=
 =?us-ascii?Q?khl+es/+8lhVC2M/aMm0H/g30VaMjH+glmemVI0pzMOuAyCQUZFFwhD/Ek77?=
 =?us-ascii?Q?8xk00W451zLwiPXIfmxBdiPqrRUFS+vAKtgEgU/IIEW71DBqyhZy4IbhUJmG?=
 =?us-ascii?Q?g9hprpJj90BNPDOszqmJ7OgwCklz/t23PzOxCZ+c9rebA5HT/hPP8jlmIsRb?=
 =?us-ascii?Q?eKDIpsgbg2CKygxyjluVE0GkgiuBEL3hRFDBrme0zMfR/QzjHRrutrzGBXCM?=
 =?us-ascii?Q?uVQIrM66CraFmpBBgyg1iRFsrmXR/m2lju2jKZpnMDnBjPwYY1qPnbgi6fgl?=
 =?us-ascii?Q?y1V9usKhlYBreWMqEBQ1PklH2YkxhyiNLbksXcbmKUzHvUGvmHX0hfquzZ7a?=
 =?us-ascii?Q?/PlRn+t5uynbL7STkOlRJoriV7cwiduV00ZUmqpDdJ0JOcdZJGflxAhPsvjl?=
 =?us-ascii?Q?cme0DAg7vEUsKvxX3znXml4pq5/3CzBE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hYmsE+OX7bOIXqgFbkHhQ4MKsne1OEOO+kP0ir3dORUFlvDlHFJmBninnYNe?=
 =?us-ascii?Q?kvthYvpWWKg7h5a4rt1xSX2iLqDkViTVQDEE4dRj8+BF0LhdJkWkrC71vy3M?=
 =?us-ascii?Q?WZt+FsZSVoo2jDfXKqjaMYG1123sac/pjddCKPPKgNmhDxbqI1SQfS2a7pRK?=
 =?us-ascii?Q?fccz9I50a2OtV2kcBZ7SqK/nAisb7psWmhmgepJH865hLLX7mE6j5fV4LaLr?=
 =?us-ascii?Q?nzbGlYoSOa7lPJ/ZMdzgRsOGXKam39LJ/fhvZMlolSEJ3XFVapLY49xiTny7?=
 =?us-ascii?Q?boldqktscu+jW6THbVopDcAuebGu3ne5MVAYV58/ii9eIvLq9pmg4/IJW1O5?=
 =?us-ascii?Q?sOsfg0/m+O+IADQI0ZJfo3dBhgNnQw1Nj+1g50JlyFjioD+cNSr4nsoQA8KV?=
 =?us-ascii?Q?G3m69Xq9L3dTIovk1fgKjTYwr8JzoJMla/eMaxQu+ahdQyZ6n7kxGySOa9kJ?=
 =?us-ascii?Q?BezwsULVkpDKmrjpQF1SeYlU+SRbdNdgwkAT2kCNUCf0H/gCs1CmhSkKunk6?=
 =?us-ascii?Q?aRcyz2nmIEGpQRaBh7xRbq2GFHPzdUScUN/sBoWOv/oyhm2hBNruoC72OkD9?=
 =?us-ascii?Q?WECcT+agH4prkf5p+Vgq18v9sz11ZqaCyl4DHEDNi2+XGMwnVB6zH2zvRr7j?=
 =?us-ascii?Q?mJozXQXeIVW+f8Sa8eEyWOOQbK+WRgKJTl4OQrgP1udtYaT9cd8oiBd+ka1q?=
 =?us-ascii?Q?laz+xJpUQohWHelb9lV0eWT63CVhodZidTRmM4kPc/8u6+MGECQn9dkYGn98?=
 =?us-ascii?Q?psOq1QOf3TmEDRhg28qYp1PfI9BxSZOWKpAbAbXPpe3etg07jwvllYOM4HCY?=
 =?us-ascii?Q?9E6symiSF3vAAnJhGW6+FmAui36v9bU4hpgjbuUQ28VoWTdZRFx00Y9D8hM7?=
 =?us-ascii?Q?JQltIbkfWdsMIgsqSQfmw9IJJu+6WeCrhdKimDzZYIisF4tF/VASZAmLoDfD?=
 =?us-ascii?Q?78PDwGYf5VsD+Pk72EvtvTs+FVi4R1VTHs3aVS4ygwNTq2laP2NX96hpgfqv?=
 =?us-ascii?Q?Khp3Et0s+LVDUJZiH3+AVZObl1j1Qy8g7cx66iQvpKNtr9gQY/MI9VvF9cPJ?=
 =?us-ascii?Q?A/mj4yEqdE0NrvC5JohcgiOoqoStYvBSf7J/HRSz6IkYUMzQJXTzTGfWbsd2?=
 =?us-ascii?Q?e2DEmK29dAH9YcQ5Jydcl41gVMiZT5uwH/s7WvhDLqZ/1RP8tcdQJ3x5Y01g?=
 =?us-ascii?Q?Tfm4BAqwHBhIGRSSplTSV/hueabckjplroIa9nWPcOrulgUVMIbvgcPIKVO1?=
 =?us-ascii?Q?nxHM9go864DTepGiz93TM9r3+Zwv8Eo5ZR26CoMR0uImrNEf/pFgAG0oDzBy?=
 =?us-ascii?Q?EfQVmry+Tm3cGp3RBN7L4wTjTUG6yCOyoFWDjwXPY9dvCPXypvKH0qurOfyx?=
 =?us-ascii?Q?4O6hGq859B9TDKteEOJD8+MzExI9Mx8ESiUK3/GIaKXvY6Ukmwk3E3G9AFnm?=
 =?us-ascii?Q?tqLIcJphxJKJmS0vkhTfOc+bApHKW/cZnxu0i8/pUvFzHdH4dY2z88NaUh5j?=
 =?us-ascii?Q?zjIgdZTHb3wgqKNkY1hbGAhzpYh/dqznc5yZ71cECypVUpv3wV5VVEkUjNim?=
 =?us-ascii?Q?3HQf+PAFAhwp9+ZRSqXZ1SYzXba0pRqKs0mc8DSr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5f322a-a258-4f8d-ba39-08de0cd15d0e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:30:49.0400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ec7yQnwg40R836zg2JZuiQF7HmNfUAsAasnuBNcDSPweaBWuyeGy+n1GOu3FFOYT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7505

On Wed, Oct 15, 2025 at 03:16:26PM -0700, Randy Dunlap wrote:
> Sometimes people update taint-related pieces of the kernel without
> updating the supporting documentation or scripts. Add a reminder
> to do this.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Gow <davidgow@google.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  kernel/panic.c |    6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

