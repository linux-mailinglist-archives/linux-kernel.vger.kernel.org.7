Return-Path: <linux-kernel+bounces-751409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2A1B16940
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 01:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BBEA167163
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 23:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FCC1990B7;
	Wed, 30 Jul 2025 23:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gjcp16CT"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD390139B
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 23:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753917526; cv=fail; b=gAIWNlWqNb7aHBeazAN60VRajFyiTzO4jY14lb0G4ScXfxe2xXhmHKbdOf8CL/krbDr8HxqR38tGNz3ma4rBVCZqUddZEimMaiycsO0ji1KrVDvbJYpXAtZAqU2jF5wvclWtULaNXPsfEmcl9+PPRlDkrAuFQJ7Ae2PaHdGwRUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753917526; c=relaxed/simple;
	bh=4BqeqvrhVMagKb4VOKcHGKaqPnmS/IqpQ9vW7WX/vY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k390yZ5IK6LTDTviopiyNhenuKDEa4I8v3S3OVoy1EFyYfVcW9SBzrxZYTOKeFh3Ya2F81YTbMZhsKp3f0GELvGeLcUcdwUz8aSO/uLBuJbRSQzi4dyCSjODYUwRp2LZfL/SozHA8wsckgO/laMShMytRjCaPjwDKxaa14aTnHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gjcp16CT; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gMxDW4hL84Kbch3J5vHMPU2A6DKFp+td3zrxWGDsf4yEDc2HgnZJPjmVXKCO6Sb9Slu6dBDN8i5oChBt7tw03MmsNs/mf+errO41KkuYsUu4pgvBTanufnboZXybLCQ1CxRFYx+z2TNiB7tl932KAYH5AyHOy5T4qEQ/PDvekwXV2DXIQlsg5RPgBN6c7KRLYOojrpQQ+PBQSKql192v1I+/1XyqTMcflwlmnJJP4SwuEZIoqSILjXLNFfBaSdjcjO/YbMNpb4mDwx3xIYYVcEEhW0oc35hIhIpkHeUad/Wpk/jsi38B6007CIZ0wbD7Ny+77GGPq+HhWsSjsRfxSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysgi9L6PUEGRPZbF+YJu6LnBcxVkvcRoWD30J+2+jmI=;
 b=U/LmwnqIvSxH9PClFHflPvxXKi5iMOtFgjUfXBiMw7T/HJ1oUi8EIoECnXYlKLvQ7LO6skhy9LQSZ5gsVcmab584hcObdAvXHDATey/QSgNZ9cvbEG5bl4RK1O76UBPAodP4JqYWpPmjXBAl6BrHQ/RhHLVmdHdhGYPcs58T39/lfMz79IxhCZQ78wn3PO0rcy8tumqZj9Y3KhdyqyRBm3+J4TSxSTkllxY+64h3lIZ5iZLpPe1HXzNtsxJwU5sSwQQlLwfnDdalk6UeiIgqr9VbicJ2L+bfYJKQE4oin2ao1RFeGtqsG7p45YtmxDYK7ZoXbjUf8HezFLagwdYHjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysgi9L6PUEGRPZbF+YJu6LnBcxVkvcRoWD30J+2+jmI=;
 b=gjcp16CTNESeatHDdOJ8MaThYBIAAPmUScluhcLmjIT5Ig0M7DolaUlW9zhns+V6SbPxU/S8zUmOqK0IdFtdEEaiBzt0k4guxC9f7HjD2qSm8jExJMLJXcgCgLFbNnK2FA5oRRxeiFyDR3gmlSjlQ3rEEHo5SLlJQmZnVxgNRB4zqA85ul0xLGtyx8WUyR4P52Fe8Zn+IK8TLud6NT+EX4WeJS7ShYAUMUDpBMp19FKcTJtBYOJxJ4AvxGFDHnn0Duhu+1huE7xcqIbCezUjKCB0VRBj1sB+koJnFAFOZG2/DMzBkmSzBGeXdksoVwVVNErONAwdV1Y4CL1Gcr0I+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DS5PPFFF21E27DC.namprd12.prod.outlook.com (2603:10b6:f:fc00::66b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 30 Jul
 2025 23:18:42 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.8989.011; Wed, 30 Jul 2025
 23:18:41 +0000
Date: Thu, 31 Jul 2025 09:18:36 +1000
From: Alistair Popple <apopple@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Balbir Singh <balbirs@nvidia.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, 
	Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Barry Song <baohua@kernel.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Matthew Wilcox <willy@infradead.org>, Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Jane Chu <jane.chu@oracle.com>, 
	Donet Tom <donettom@linux.ibm.com>, Ralph Campbell <rcampbell@nvidia.com>, 
	Mika =?utf-8?B?UGVudHRpbMOk?= <mpenttil@redhat.com>, Matthew Brost <matthew.brost@intel.com>, 
	Francois Dugast <francois.dugast@intel.com>
Subject: Re: [v2 00/11] THP support for zone device page migration
Message-ID: <xuogc6tjrstage6ezhk4kumqqjr6okogtd6nxdmanyqmhc44r6@eggx4qujdsav>
References: <20250730092139.3890844-1-balbirs@nvidia.com>
 <e0153fb2-af59-4bcf-a07c-d650fa56d55e@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0153fb2-af59-4bcf-a07c-d650fa56d55e@redhat.com>
X-ClientProxiedBy: MEWPR01CA0204.ausprd01.prod.outlook.com
 (2603:10c6:220:1ee::15) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DS5PPFFF21E27DC:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fe789f8-dd38-4019-4b41-08ddcfbf6c2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/PndvqDGUhmapuUST3w/m+jCG3D0m8CxqCgFJMOvPiVQSm65ZdB1FOmhiyOA?=
 =?us-ascii?Q?/sCnFwTfhyQ9jt6emBYnmCvfc5JEcKyBxgl9Rbql5ttLFx+PMZUJYhJjsb28?=
 =?us-ascii?Q?qLQyAGyK+kX569TTw2i5maVu/cc4MF3nDzTOF3vWjb9QI3Q3FJzZ7ZtyLfVE?=
 =?us-ascii?Q?DfGkIKx8rnVfTZaUy4KLBATcvG1WZVbfg0eIEGe4T7G5xEwyFoalHatUBZxb?=
 =?us-ascii?Q?2JbuObOd/Rw4olwdr6QyGpo72KsFKKTUUGzSiY/5F9Vb7kGcFU1wcaPgpzbG?=
 =?us-ascii?Q?DjadBa36WY8uw/FH7ixdTSKEHfOLP9172aK7ri/EuIQbkY8+EtHNUkj+mnBb?=
 =?us-ascii?Q?VSLWpx+WnQ87TazwNuEjNp/0sLEw8IdYKYHC9cgqOjpgzQEN2zHfYBMOhJ6e?=
 =?us-ascii?Q?94hNe/zq3PWKBB4CD/f+maBvlDghqvOCoTDOf2BxOEgi5xScF2TN5FT0W2pF?=
 =?us-ascii?Q?UXlOsE0blzZxmJDWir6xNdJZdX87D0p06HrFtDJB5COv+F2kJKwbGzfHhnvc?=
 =?us-ascii?Q?Cpfb6VW07hh2zNSpdDbCaE92pu0DnN2wUZeP7M0zKKjUVw1qYwbO99fQXHBJ?=
 =?us-ascii?Q?kCZa0h9YaJjETBrkhNDmm4xHIZZN1TzP5vfyHkwKp+HMryQdDkVIxG+goyCc?=
 =?us-ascii?Q?xmRDN4j2l5g4tVdKNTAb4CUuvBxsi0NWIZAkcht87kGWRq+Qi3PWS/Gf3i5m?=
 =?us-ascii?Q?SzTAl0585aN6DGtSIqoYrm/S/YS2HsF0kcQAyxL5KyZJQkR0oVG0bTOlpgw7?=
 =?us-ascii?Q?gV9pu0aTyVS7CAHwX0J6pag62CEnnL5J7Jo14l1N+rJ9pgtTi64Dik4gH7OG?=
 =?us-ascii?Q?JhAIV9cDpcb1P0tlCledkGdqFJLbSCq0fGnnmpN0bcE/9iOwrfsa24VXkfTs?=
 =?us-ascii?Q?H2dYnRVIVqUpc68bJkWqM0yRCI0CTmj1yPkkDgb4KyIxeFP8bfbWoFCZVLvk?=
 =?us-ascii?Q?PIgFBWy/zZ4WqXmQQgNRiv1iQVZJl0Ux26KCqb/DS5TN8JEQffBtDiB3mZud?=
 =?us-ascii?Q?NlS9LU1QtmYPQwrrZVIQIWrhAGmfydYtrwJnlrQ3LIOyD3pNI2zoBeU+xohp?=
 =?us-ascii?Q?sRsUezPdxPHoqDao5UCpanB87kqFZLHptDvJGeFTz7mxVj2tTY7eX8x2pJRJ?=
 =?us-ascii?Q?s7U8FVvtJ02I/B7fjQOz9oEbUEvuGMiJdnOEEogYNh2Q1E9z9p59pcaXvj0u?=
 =?us-ascii?Q?fRTaHw91uhSnCwtqJ9w701IEZCi3o5xbSqVrw0f71eNOTgjXfMNWEtlrwZwy?=
 =?us-ascii?Q?K2mHeUknad3bF/9yPxiK+pTkeaSJqIBorgMwZAPtamgSigdlH5cO+KDNdDHo?=
 =?us-ascii?Q?FbfIo8qzOF79Kko62yMJU4OYfaFMUX6UQu191EexYtxdR6+IsdL8RkJVAhTl?=
 =?us-ascii?Q?xc8m7iqe4zG9i39+WYU34+2ZDMCq5A9ODw9KGScJ6oieXbLyKO1BAJPsgbsC?=
 =?us-ascii?Q?6KZRUX0+gWE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jkgTrCbtbpEu5e58iEEpIbRzLw6WmJetqpo0OfXJCpLXKAyddZpDMxgfQTpE?=
 =?us-ascii?Q?hSSYrsRnv7uN9Bmsd94NsEJKGrX+gB7cymmmNf875LHnRpmqFzHETfPL0uNu?=
 =?us-ascii?Q?4chL5m9UQ+ObzPdHyfdzJZ7vzCbq6a8KrY0XxmUIHjkY9paItmFLhehEG+AW?=
 =?us-ascii?Q?PflRWtjHKL/1khk4KkK7r5eH/6MtYQjH/f5uipEhBsKTa0Fm1/rikK7DK4wY?=
 =?us-ascii?Q?cSnXU+pFzIcCSpSYdqwC9SLyEImc8qvuZnSHl4NzbV0S6l0ZCasaTsCC8xuw?=
 =?us-ascii?Q?T7PeUnsVsF5Bn6H4yGyysPNOpf3JFOWvRiqRE6sYBYRPYvXaFe+iwLcpENPT?=
 =?us-ascii?Q?J3mQ0kI1+PlXFLET7my5rp67VoTZj/jY4F6InEfvbUfU0qhL1bHp+VOJvN9n?=
 =?us-ascii?Q?WvAC/RsbMHzmT3NERkdgF3fVu9PODEQKTJSVPjqvcWh6fdQaPLzV6x9wEyA+?=
 =?us-ascii?Q?V2aJ2Du4Rvb2cTokHeMrEUWtRiKf9SQmgLvGWYw9MlsTIOMZu/cqXfnPiuyC?=
 =?us-ascii?Q?9zgDIjAvIRp7dQtRMYoIofroTOy70ioYD+WY+FOuGWKVIQJEXT+CuRA9U2z5?=
 =?us-ascii?Q?98cxEMiU5JUkGdaaIihRZLJzhN6HKth9PwQDrypibDYCE+jitv5wwfXglrvp?=
 =?us-ascii?Q?sYSXC+WKFj5DbUK6q9+BgLdqNa3LvpcjxKP1MEzrRJbSUlQDQQCqtqL06ZLt?=
 =?us-ascii?Q?nK3JMLKhjLSzZCro9t11AEc785zIFo3Qp299nFjpwEY24FO2LEBJVEB/OfBs?=
 =?us-ascii?Q?eEP6OdIEurzlK6jo3EEWqWYa/hHUVEuGr1UxMLlaNx237osMpfmwaAuwaYF1?=
 =?us-ascii?Q?cffMncb7S8/Di1Y4v4ROcMWDn/ycYvhDAT09VcqrbX3r8Cd2JwWJLRtYJ692?=
 =?us-ascii?Q?ZEwSOFOrLCJEQePW5rWOfpIqWvC4Si2FBDy7wJa4AAg9yc0wTdRR/FY/KI1q?=
 =?us-ascii?Q?lOUAhE8f4ZUSJF7bLvKOBD2nd0h0mk7E9mXCt7k2a0LQcmX76CLESK96feWz?=
 =?us-ascii?Q?bFoQFqeqYZe9YfIc9/Nxi5hcuVcUlr40Bybt9m0INvn4ZrCqFF5Gl/lNzgaF?=
 =?us-ascii?Q?OPC9QZ89HN0g8xcoKBriw6R7H4pyYyV0Zm3pB135cRfKGYonaOpUPK02dY18?=
 =?us-ascii?Q?MVbyPE1HMt52v6rBCw8tA3kPPWQjmalfF2HEHcn56MV328U3gRZvmcbrm2BA?=
 =?us-ascii?Q?+FJ9WFydl9+6TrpbwAvmUsOcpvX8q1FTYlqf7IfnNw32RccSoJSSiXKlyMP3?=
 =?us-ascii?Q?spr0MaCWs+V2nCsuhghh+pCKnJHHjxHI+Mx3/lgkwwMkQaxsdkayDXUmPdIZ?=
 =?us-ascii?Q?IaZdXAMtM0iOa78l282kDrxBo8Rp39qifnCWKXdmqi6Io7XbJp/MWwksEPn6?=
 =?us-ascii?Q?uYTnCpmkkAbQs8KqkAIc7vCgcDYBm2qWu1K2PmmLRj40/mtMftD1pmYl0Ahs?=
 =?us-ascii?Q?F5kLJHWg3pPX0HYyxKAlgIng3R5gf6ro3S2pEKRyAlPBU26Kf49NU/ao62GA?=
 =?us-ascii?Q?LwtYgqxCY5SX6XsSmo6uvzoV4uqhkwyyWm/Jf26XEFUZYSITLxIv1H61mov6?=
 =?us-ascii?Q?wsjeb87Zmzw1D9RVlAFEgBkH4eX+KpQtQENrLBxm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe789f8-dd38-4019-4b41-08ddcfbf6c2c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 23:18:41.8630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: obKp+zgb2eUoI4XUaGhn7FC+7VVbSqTLGMki9mZCDPC5SC0+50UFb4sWrv9DDEQsbrjaVc/WmOe4LHHTAJakmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFFF21E27DC

On Wed, Jul 30, 2025 at 01:30:13PM +0200, David Hildenbrand wrote:
> On 30.07.25 11:21, Balbir Singh wrote:
> 
> BTW, I keep getting confused by the topic.
> 
> Isn't this essentially
> 
> "mm: support device-private THP"
> 
> and the support for migration is just a necessary requirement to *enable*
> device private?

Yes, that's a good point. Migration is one component but there is also fault
handling, etc. so I think calling this "support device-private THP" makes sense.

 - Alistair

> -- 
> Cheers,
> 
> David / dhildenb
> 

