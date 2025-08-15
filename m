Return-Path: <linux-kernel+bounces-770201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EACB27867
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E4ECB6247E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A8224EA8D;
	Fri, 15 Aug 2025 05:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gXn7m9DU"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA552236F7
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 05:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755235426; cv=fail; b=Gw0DaKGp6ormrswthUjIAB/sCDOoEuYHE9W9LULtYSSY2EH52o0xGRtaD9l/K276H8lO4mfsZ8EiMcLu28frAURAuxUdMkdZ1nPvLzTO87LRuyhfAFU/Ao9ai/AM00MF/dp8UoIB9C842fndwee5k/AE4H3BLcsgHiua9L1QZ8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755235426; c=relaxed/simple;
	bh=976lrv+/JmzzPyvXy63h085YspfmwZ7shoanBoE3Bcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZQKnz0hIuNZ3Xc9Fd9823atxzYwR02FkYthfUNmz/+/3GnruPYqm62XuNIUa/b26WXEfwIGqaYRS6QD5qM4eS/l1Ovo9sAYV90KXWG3oJ9nAyc92hvymeVHaSKjRjftx097l4VaraNdR441Pb2QF1p1If0gq9ouldTdjWFAJXfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gXn7m9DU reason="signature verification failed"; arc=fail smtp.client-ip=40.107.101.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDLhm+ilpTRcp244+bAKEc+rqIhPV74XxY/ZDSOSGowt+Y7BGG4yZK9jYJUYb0uQqv8ZpWQ+uUCbAiCzCwIeT12+RkUB65t6izxgeOprI9n6IFmkuqa0V6E57a8zelZUDdRII4Wb7wqy8NXlvEvfy0ZdiZgw1/VQoIjdnrCpfKjdz7VPWyeCM97KdQqkrX8ubZIVPxyFmoc2FhdPXKNU9IA7RnQJvv15B3LSH2v70pcnBvMqGH25xansEeMvPY8+3ECp+2845Ttk0jMWpGL0xzYXoUJUd2z+M0Q5xnCXVBWnqPpFZlIE5O7ylSJRCfoYFaoOLiogvoUUGOisOz1lhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2wsOVgLFUFFYMg79wl57kKK5Pp+T93Vp1LeZZs5UWk=;
 b=wsW9Q6130HYxoCp+ig/LublMdrOtiMM9txNKtA8qbDWQPdxq+PAiBXSbztfhV+OeCBqHcFH1txrKsl+e+LPEq3y9GqinI5QKAJlGg9ECY/puv9I7+n55YXktV5gSggIULjQaeigPYvNwezt+x74qPbt3nLzYbI7wSJFJBrMPqZxJewUiqAAPE5K30dVIdLGqp7sUotL/8d453kZOUHkRJmFnNrntlzradicZ707q3StmlvwTB608KRCe/FWSl7/SbyZiD+llOIfytlXEpIlUohCBEm/MHWAinnPVKIz0LpPp/xsEymui0nV5M85ofDKzQJyS2aSDH7M7Fc0lfyqalA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2wsOVgLFUFFYMg79wl57kKK5Pp+T93Vp1LeZZs5UWk=;
 b=gXn7m9DUyIYgz7OgK42rOUvY8QcaIVUrlBhnPbmLW89dyLitQ5lXAdzlxLzjuuxjBzeohFwqlSF9N0WfHDusCmfGB1Zo8DFzdHM+5GHuzEfz7oXtWUZydVVM5xT02acNKNWxgMiTdPKLsqN7WR/VNj5zL+j7RCw3w0EMLb0fssFDd7Y/XkdLXADjqZgPjfCfMUzmFhzctt+5/Kflqw7W8HW3YpdmSrABndZ0It+2jkQCsRcHUmD6rXRVQZG3PM6rP4JVZbnHYf8nYK5Fz6W4Kf647+0nZmrTFhQCF6+VTuxVo1yAWv+1dkeoKdywrht1mqbGluaCuWq9uv/pvO399w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by LV2PR12MB5871.namprd12.prod.outlook.com (2603:10b6:408:174::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 05:23:41 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%7]) with mapi id 15.20.9009.017; Fri, 15 Aug 2025
 05:23:41 +0000
Date: Fri, 15 Aug 2025 15:23:35 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Mika =?utf-8?B?UGVudHRpbMOk?= <mpenttil@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Balbir Singh <balbirs@nvidia.com>
Subject: Re: [RFC PATCH 1/4] mm: use current as mmu notifier's owner
Message-ID: <pk4yq5kt5csh5yqd7f2s66eux6yvluxv3rcwrskaagyxcgo34j@6wei37bgqlye>
References: <20250814072045.3637192-1-mpenttil@redhat.com>
 <20250814072045.3637192-3-mpenttil@redhat.com>
 <20250814124041.GD699432@nvidia.com>
 <2da9464b-3b3d-46bd-a68f-bfef1226bbf6@redhat.com>
 <20250814130403.GF699432@nvidia.com>
 <67b6e041-4bea-485d-a881-cc674d719685@redhat.com>
 <20250814141136.GG802098@nvidia.com>
 <c7bbbbc8-b9fc-40f5-b86f-e43b9a85aaef@redhat.com>
 <20250814172018.GJ802098@nvidia.com>
 <2982b6f1-7c14-46ef-afb0-7951f7cdc2aa@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2982b6f1-7c14-46ef-afb0-7951f7cdc2aa@redhat.com>
X-ClientProxiedBy: MEWPR01CA0147.ausprd01.prod.outlook.com
 (2603:10c6:220:1d2::10) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|LV2PR12MB5871:EE_
X-MS-Office365-Filtering-Correlation-Id: 77db1422-78b5-4acd-2a11-08dddbbbe590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?170wRzoKiV59Ya/2F05ciaiYs66O3Zp3DNURSldI//TsEGMeF+IKTnPkAp?=
 =?iso-8859-1?Q?yGhd9tr+tnDlDHYtT768P4tALuMI3btiVqUnhODx5elgAHrnGWa7e8XqM4?=
 =?iso-8859-1?Q?j1Hpk2eUEukvM2UPob1kDSIrKlpLyNmdDRxqmpTJgBxfDU3gnf6kGL7o5s?=
 =?iso-8859-1?Q?BZ//swZf0uX0WHRt9eJymnZLZDUQEkRf1Vt2NakyNOqd48X3mmgcLAAqJC?=
 =?iso-8859-1?Q?jeGqkpLTbcPGy/j6gPShii8Z7Cg/raJr+XyI0Lesd/E1eGfhcR9R8AmCLi?=
 =?iso-8859-1?Q?WVH7sq7gDy5RMO/IRLr3w9uorjnstMrDcTNL1yS93Ap+cgqQrRt8mZTQwJ?=
 =?iso-8859-1?Q?nOPlgvn4W1BFblL+u2z7mqPwl18/4nMrIkx7VHdVUrnX1zWjMYwjTqiD4w?=
 =?iso-8859-1?Q?eWRbd/YtocQsVciKZhRIh9vA5bFzKtYsCO1Cv1X2aOuio0G0dJWRjzKntO?=
 =?iso-8859-1?Q?suKTDxH+ycFE+4EbjrVwcE3iQY0JKU/yY39VNW/fc6t953J3APqvqDJIeg?=
 =?iso-8859-1?Q?yguNfTYoL1IYEAEgZIYh3kiy/v8LFr8xobbUuiScRAAhsAhkr0kpEi6QJv?=
 =?iso-8859-1?Q?kM6zJLm1QzRAGPLSAJNiQhL4RPYZlxUpFkzRT5Ht456b+TEUDZ1yXgqyon?=
 =?iso-8859-1?Q?3SYpTpKP4JgrImSkIIlFRgt+v0uYuk6fK7/j8ciygWZMEx/pjr4ocPc0wN?=
 =?iso-8859-1?Q?O+Et4as19IrUJOR/Xc3dgcoZMcGnPjhWb9sZGLZUjguIzAldnIxj2xsY1f?=
 =?iso-8859-1?Q?OMc9LJO0jD3/92nwyrBZustbOUuUVEQ7jo7+a48Eoad5vTtd35EKzzBjwk?=
 =?iso-8859-1?Q?icgg5MDSYFpZ+4Zib8XnHzAL6bua3ivH6j/yCsoyKo3ZM5NjMnBP6njPVD?=
 =?iso-8859-1?Q?mexzwgjMWQNa0ABZpE9LnxFXr2NmpiUdBqybGJQL73BZt95BO6iJxqFmqF?=
 =?iso-8859-1?Q?g0gV6s4COaSR/p/PgXLRcER6oWsjn73tvi7Y8tLWfdt/s0PJvsJK0NuWl6?=
 =?iso-8859-1?Q?Q8AQSev/gFA7Inx2kVEK0gRmAhQmyMzosQbwSSgW2V4Lfqu6xuBae8PWwO?=
 =?iso-8859-1?Q?WUhnbb1UU9X1ik0SydC/eIPMwTySyNbeONfG05AO315ouBkFxvysgfGpNr?=
 =?iso-8859-1?Q?KT05wkFmmSFVUNf2q+168cy11IDFjL/HYExrBTc6pP52Ip9O/u6Q89+d6Z?=
 =?iso-8859-1?Q?qsQ+Uk5LviPoSj5y1HnEeABz4yCzIe30EsHo2w8UcT7xqg7eeHyRA3Fe7U?=
 =?iso-8859-1?Q?obYRixAlQIBnpZn5X9VxnO6qhH7NOODPAq2qsb+dAp0kbnrjBfXWZO7a6K?=
 =?iso-8859-1?Q?C5C3fPJnEmkOfH/3mvxWGnhENerTr53gG7znL/mHHMJLJGMNWwi1tDC4wN?=
 =?iso-8859-1?Q?ibvYZxEkCA53vVh5AdTYbvNhAJMon6s9ce6a5TWTVXOto+jVRGs3x0JIFB?=
 =?iso-8859-1?Q?ty/v6N5+UidtNzLviOmwwdXBgrvlae8pO9OD0DbeP83eK3veSgfkpLk0kM?=
 =?iso-8859-1?Q?Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?IBi2EXgOF++/cny81vtlrgh5xEiyVXi0mrkMUvUkwTQf9hd4SXy9PXKB9a?=
 =?iso-8859-1?Q?Mxcc1N64xzPVSdT6XVHXKhvuqJqKV7bvraj3282VkC/1Ldepf5V+TiRhef?=
 =?iso-8859-1?Q?KLMnW9Rf0pQTBGoh/0Hic84NSdYXJBL3sHIPZdmyoAohCbygqI65cJnxzx?=
 =?iso-8859-1?Q?azIz7flINLDhErJ4i1n85+1avJ8HCSms9wrhGygYOP2PKhYmAbin3X6J8x?=
 =?iso-8859-1?Q?Stb5ix88OaQV1SjxRpxhnYlBJ0aRn6xyauwmo+NHBH6rCz62B6QDuWO0A8?=
 =?iso-8859-1?Q?7bWW/OOe0mtdZzeuoMdimiKjSciEVsUtC4yuH4QU/KDLqSRrunoJXowmp3?=
 =?iso-8859-1?Q?Tj/92r8JNmKr1iJW2NvfTnxhfYjffdC4YnDRhYeF2Aavsk7AZfnZO0USbS?=
 =?iso-8859-1?Q?21WpgW1npIwUbIh33GDrhGBT6x9E2p0SyyutkDBhscE9nX5HWWVjwjUihA?=
 =?iso-8859-1?Q?hMWm1n3QaVbQ2WSp9EZ2TPZ7iHFN7jEf/W0sBNVPMM5EET9IAxacjHSxqe?=
 =?iso-8859-1?Q?Q3bbc+IEvvsCHVgQVuVMfCVzSc4fWbxNPrp/e0WbwXeBgq0g5UyqprFsbl?=
 =?iso-8859-1?Q?bs6uLghVWNgRcXhKftd7z3orb44CdvSFCL9dAtyR7pXscaN5gc6rQ5V47z?=
 =?iso-8859-1?Q?2Tc6kw1zZeLRjC56FqjecLOPcE9GhaN+f3P9zcMmebBOOQK4Mza6xyGSIN?=
 =?iso-8859-1?Q?GXxTygilGZ85phQEfvB5h2LEL6FRMyhnUg9Np6EhqzyBjVc+S9PMaqiCDe?=
 =?iso-8859-1?Q?+QTNLm3k/ci4Y4FS+h5Sg3+tlrCRlJnUMj+H0FaNT6x5fqorIpnTbr7J6/?=
 =?iso-8859-1?Q?WFe2nLbTqBbg22jQRG3QbgraX4n+5SCDYJxXze3lJf3m45Gbc7mKyCO0J+?=
 =?iso-8859-1?Q?LnPnJt4cheVUVEuY0sXTy1ZrO3em/KMkstd5QDeIOvOKIqX9CevVrkNrD+?=
 =?iso-8859-1?Q?qFcifZlCYQBoDNFeXsTL1Xn/mvvAaT0KM1wRJiFwi8Sj8xyV0qsrlWK8c+?=
 =?iso-8859-1?Q?xL2LWqbOTXAkNN8SYlXffoDC21FHoOVoz+DwJ9IxXA+ZVq5KJQKirvM98F?=
 =?iso-8859-1?Q?8VDcBdYNXx+OjaNlbRk75Fi/N3R6Q/Q+C8gmi7ipO3q88/IwCEWsL4vbUc?=
 =?iso-8859-1?Q?SoYUxZwXSaqsYpW0UJFuNaI/Pm/C2wBHj/Onf4OjD9R4tgMqOp/zqKr2fv?=
 =?iso-8859-1?Q?sdBlLmKIF9MrMvX0LnzRt+rNZuBM5qn7NAYCnPuFXVhU0alx/EbSoCFOGd?=
 =?iso-8859-1?Q?4GOovXF09aW32BAOrILRIsAYBQMwR7WZDucsKhtyjr48NTzGa9kbXAcozD?=
 =?iso-8859-1?Q?3WVQmL+IJLkrWynpTKG1p8bBhHUFmbATTKp8eUIkyulmJJ5nMrS3s0L9Md?=
 =?iso-8859-1?Q?dlu5Jqj7YDGqn8p6EK5+9eOJgbcl/8/D4sQRDX4RDp5O0Uz+ieSxWWJ1ss?=
 =?iso-8859-1?Q?CDqZY1n+o0vc1P0bTcWRBXGttP3Kc3UVTNSV6+dmdJuOooUBWsbLrXYPam?=
 =?iso-8859-1?Q?XpCkALRGCsUBpqh5D+RSSFcr6p72SKYzKTwP1dHd6ueuKGnEpA2UlPbOAE?=
 =?iso-8859-1?Q?UQXsyyS9kXoza/HjTnFfjZyA45j2bH/W327D1KHFQNplbjx5LDYs5tx+t6?=
 =?iso-8859-1?Q?Yh1C+3hxha47iihBhrgmQO9BSP89hTt0Bf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77db1422-78b5-4acd-2a11-08dddbbbe590
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 05:23:41.6499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQ+Fj4q1EefSUNKZtFV3TPcxwqwQt2cq+FvPFvCjsdDXfU9B0TylCUWXgBGGtKy7MtPPmWV9dgbNgD7fPzwkyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5871

On Thu, Aug 14, 2025 at 08:45:43PM +0300, Mika Penttilä wrote:
> 
> On 8/14/25 20:20, Jason Gunthorpe wrote:
> 
> > On Thu, Aug 14, 2025 at 08:00:01PM +0300, Mika Penttilä wrote:
> >> as well as hmm test module with :
> >>
> >>          * Ignore invalidation callbacks for device private pages since
> >>          * the invalidation is handled as part of the migration process.
> >>          */
> >>         if (range->event == MMU_NOTIFY_MIGRATE &&
> >>             range->owner == dmirror->mdevice)
> >>                 return true;
> > If I recall this was about a very specific case where migration does a
> > number of invalidations and some of the earlier ones are known to be
> > redundant in this specific case. Redundant means it can be ignored
> > without causing an inconsistency.
> >
> > Alistair would know, but I assumed this works OK because the above
> > invalidation doesn't actually go on to free any pages but keeps them
> > around until a later invalidation?

Right, the pages don't actually get freed because a reference is taken on them
during migrate_vma_setup(). However other device MMU's still need invalidating
because the driver will go on to copy the page after this step. It's just
assumed that the driver is able to be consistent with itself (ie. it will unmap/
invalidate it's own MMU prior to initiating the copy).

In practice I suspect what Mika is running into is that the page table
synchronisation for migration works slightly differently for migrate_vma_*().

Instead of using mmu_interval_notifier's which have a sequence number drivers
typically use normal mmu_notifier's and take a device specific lock to block
page table downgrades (eg. RW -> RO). This ensures it's safe to update the
device page tables with the PFNs/permissions collected in migrate_vma_setup()
(or the new PFN) by blocking other threads from updating the page table.

The ususal problem with this approach is that when migrate_vma_setup() calls
the mmu_notifier it deadlocks on the device specific lock in the notifier
callback because it already holds the lock, which it can't drop before calling
migrate_vma_setup().

I think one of the main benefits of a series which consolidates these two
page-table mirroring techniques into common code would also be to make the
mirroring/invalidation logic the same for migration as hmm_range_fault(). Ie. to
move to mmu_interval notifers with sequence numbers for migration, perhaps with
filtering if required/safe and retries.

 - Alistair

> > This is nothing like what your case is talking about.
> 
> This one is actually pretty similar, MMU_NOTIFY_CLEAR is also fired in migration process
> (split case) and invalidation handled part of the migration process.
> 
> But I have already a working version without any of that.
> 
> >
> > Jason
> >
> --Mika
> 
> 

