Return-Path: <linux-kernel+bounces-878835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC2EC21909
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A33651A238D7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB4F36CA7B;
	Thu, 30 Oct 2025 17:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EhoyhAph"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010044.outbound.protection.outlook.com [52.101.56.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C025277C96;
	Thu, 30 Oct 2025 17:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846860; cv=fail; b=u60hIEZv5GGUCDfApqckZolWeop7cZcS9APUKiq6jFrrHKxge9F/lIdgx3ViiLjF/J/cZ1g47OyQcI4ooVAw5WYci8tjLA9WqIgFWNmwAyswE9mcpkLQLUhIedvZ7tRKaCX5C8QK0xnnvBrvQ5WWBrWl69GJCv9x6X+djGBLNnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846860; c=relaxed/simple;
	bh=cfr36+gsJb/eOZTgQm7hSB3JcNyIvkTj6E18NmXMOcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mCFPk56goDpby1ToHj24J+o0SjBpPhgbF7JqTHvKGHbzXMRQsKFG4y5UF8ay9tS7G0mRclcpkBmolcHtNC6a+wyRuuNOUzeZGvPdbm4ZvT2t+HC/78wJOXydFKjo5L6194THSpCuEOw1bNbmAl21lkX5IyZEmVyalXmHdhbCy6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EhoyhAph; arc=fail smtp.client-ip=52.101.56.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NwrLaw45vUGcSw/ME/nKDv+nnPdA6sbadq1lRybV67lmQ1L+NdeJwn5beVgxqr/uFVdepZQTRFdHwiBuM1Wew1KebkVv0f4EEtZNffl+ZvNoKxpm7rPR4V8ZazME5PjQ8sQrEo/6CfDEB5W3nfImKdoP+t62Tf+dfwLB4v7TX0p7o3i7Ets3XKLmEP8KYom4VHx/V92tHacLAL35i2QPGhvG82j8wIh6+70IIY6fb7JyxkqkU29t/89uFWm4vx0fx0cS53zaPclVYLgqf1ulQ7pM0xNNaEtZt7IZDpQ3xzbeUm6haOgHOwgFuGuSINPUKAMmjVBvTM7hJbWxVXmBYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lD3SmBbRhm0L/Vyoc5VeX20zFVtLlUUz8GlKGpF0jMc=;
 b=d9gPWAjzrhe6jzRK/YK31U8wlo7bhfj/e4wOsSVFLBGwM6L6+MgfmEE6EUWAR5vaT0ZJUCjA3mtfpIzzdVyAkwMBbqd99Q1+eR0Nj26ssPX3Qseaw74mp7j6eByNAvoD//Jop6RXBj/tz7Wltvsw8aJ2p6inkFyLxbcwudaUfSQpNQ2HDaSv7GMJ3CYubegrTTsQoDPIPWB8kV/uTXdgvfaudyJ66xVoJZzHpGhDboVO3pdEk3FER2Ppvpvvo6TJTEfSr+gblf9+Qbhu8K4bPGdoJL4U6vDK9MUBDlTyydBs6hg7xxhtw7cA3nSqvJTzfy9afkaaTx7Qw9OfRNnpDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lD3SmBbRhm0L/Vyoc5VeX20zFVtLlUUz8GlKGpF0jMc=;
 b=EhoyhAphfzMvPSPfTRFm10xy4TXxGoO4C2eCaE2PA5Zdn5xS3lnlPe/ChDFGYTb2PXgQWKAHny/44lEAsZGhYdgz+jKdh2o/IREpvgekJRCmY3vdnnHnxuaEPD0D5DGZXoNSkym7B4N7Mq7tLosZEnKlZcY4mVkkbowGo0mZ0ntOxpZCnslqCbKhG5gaWLhkfrm9Kh3zHR97prta3sgjERIx8h0iTI5dGWoLEUtUIWnQPwIeiUnak8/Hr86yG9pIGVPRFL80vHe4NpNN4ggW/BlnsmOkErPYBWRCIEoGjorojz4RpOxDhdstiziupyIMq3vzZa0jz8c4DvE8uGPvOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DM3PR12MB9435.namprd12.prod.outlook.com (2603:10b6:0:40::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.13; Thu, 30 Oct 2025 17:54:14 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9275.011; Thu, 30 Oct 2025
 17:54:13 +0000
Date: Thu, 30 Oct 2025 14:54:12 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Zhi Wang <zhiw@nvidia.com>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"ojeda@kernel.org" <ojeda@kernel.org>,
	"alex.gaynor@gmail.com" <alex.gaynor@gmail.com>,
	"boqun.feng@gmail.com" <boqun.feng@gmail.com>,
	"gary@garyguo.net" <gary@garyguo.net>,
	"bjorn3_gh@protonmail.com" <bjorn3_gh@protonmail.com>,
	"lossin@kernel.org" <lossin@kernel.org>,
	"a.hindborg@kernel.org" <a.hindborg@kernel.org>,
	"aliceryhl@google.com" <aliceryhl@google.com>,
	"tmgross@umich.edu" <tmgross@umich.edu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Neo Jia <cjia@nvidia.com>, Surath Mitra <smitra@nvidia.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Aniket Agashe <aniketa@nvidia.com>,
	Kirti Wankhede <kwankhede@nvidia.com>,
	"Tarun Gupta (SW-GPU)" <targupta@nvidia.com>,
	"zhiwang@kernel.org" <zhiwang@kernel.org>,
	Alex Williamson <alwilliamson@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC 0/2] rust: introduce abstractions for fwctl
Message-ID: <20251030175412.GT1018328@nvidia.com>
References: <20251030160315.451841-1-zhiw@nvidia.com>
 <8e0209de-5be3-4d41-807f-1b7e73aa3d1d@nvidia.com>
 <DDVUJRUAMI4T.1OLCH55GSGYCM@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDVUJRUAMI4T.1OLCH55GSGYCM@kernel.org>
X-ClientProxiedBy: MN2PR01CA0048.prod.exchangelabs.com (2603:10b6:208:23f::17)
 To MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DM3PR12MB9435:EE_
X-MS-Office365-Filtering-Correlation-Id: e7baf0a9-c8ed-4486-f442-08de17dd5614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?529nV5mmf6dUJBsBC9UJ6/tUTTQMAwkSa9e0d2K6I0iodhaiXJMIZ0wgaAAx?=
 =?us-ascii?Q?X7tEGp9v1nNwfRd7kT/+tRRqLxY6wl06y/yMh9waT5TldmHYVl2LLhFXe8u9?=
 =?us-ascii?Q?gQ8Y02CMvvnavFd6ZqTfp+IsBUY0GD9XX96zHakZbPibyfFD8kPgorzbVYmA?=
 =?us-ascii?Q?B6+f+mi/U5BTnPSFCWYpVE0D+nDPlb9AawxKB9B/a5WQFwUi/nz5++U3pdIO?=
 =?us-ascii?Q?FqsF2cOd3kJCrIZ9fRLzJ0Jo0FW+AzhqKejEVnT9+yD6SYICYGjc1I6C2f3G?=
 =?us-ascii?Q?f6//VQy7a1pc71oxRRC5SfQLdBsTAyN7YWDKeMuVNqkhL3x+Nh4iLfRi8hwT?=
 =?us-ascii?Q?++JBxp0uR+b1WcQurTTFM+WN7WOtN3XFPuuN5T89AKDlMLjwBFEBEhsIOyml?=
 =?us-ascii?Q?g1Z/tqXa9CVjTMzjuNye9rH3aIc9EJZ2eYOa/ZTAq0f5m2ztlUi3TKuAawVA?=
 =?us-ascii?Q?OuX/9qs6/ZXl+yfiPh1BfxYTKLey2BZ4w6Cu/23IcklJr5aHk5HLY6zAHNrv?=
 =?us-ascii?Q?VV7QDePqGPGXyfgnMCTAnIrnIx25jvMlCWd2JokC0jMmOItvXvXz84TLxkpS?=
 =?us-ascii?Q?9ZIg+APsUYgg7GKJ7CSPCMYfhB4nEgkBR2pxsHZAoGTLDEqjlYFv5ms8xD1g?=
 =?us-ascii?Q?JYbp2az3jr3gs7RPwNFjtvWklIGqPiONRcQqOXkpLa487PG7filxKXnABIDo?=
 =?us-ascii?Q?0+EXYOsaiBRopYbMYBGKMFTMZtTV0H3RGT8zA/lQJpF+gkn30nyDlb8ERsE/?=
 =?us-ascii?Q?x7tcjRTXpZTM8ZXXAqh8i2Sbt8NtzKcz4LXuU7ahl0zr+J3DMIe4yVG5MdBM?=
 =?us-ascii?Q?zxD9qadiicm4qBam5rkoDrYOrVZ3TKDUdxFygOQ0W8nm1eOtOrgw6xU1kPNf?=
 =?us-ascii?Q?VqAOIZjZI1H6QjnboT/HX21AdCGjRW8F4aTMM38jN5ruQTdQ/EYv3313fhDt?=
 =?us-ascii?Q?vphCdIya86cEz7HSZk0tTVTY0UV4iSMtXzPa22OZzEQTtGTAFTeuwZYhM8up?=
 =?us-ascii?Q?SAZYSBnk/hxrF6T2VzINslF5vopMl17Fn7xxmL1OUiPBwOFr/0an+6OLd1aZ?=
 =?us-ascii?Q?yriKPm/8GndKgwSPJTqz4X7oDk59a9ibkBV4JKIQcZbEHTEdc+nujj6O92aS?=
 =?us-ascii?Q?Doyx3x3HENaaHBug/4c81Zdsgl7hOHKpSy3CaYml3+SWXzDx9PgHsH+BtLVU?=
 =?us-ascii?Q?0MePDTClRp8KxQa5hOEX5PDrnvLhWHR58HikDyER82KdOtVRtXBN7StPb2Eo?=
 =?us-ascii?Q?M7j2HQTRKI8rJtfKbY02QyrtQxWggED2ks8S2Gf+Af82UFmeq0oagPexsJGG?=
 =?us-ascii?Q?4oUcUbBVre8tLHofAaubWasuNKjmLO4N2MTOUy6kt5ErVHrShdYKhFJRL2qb?=
 =?us-ascii?Q?D28QvJ97CR9hiNWDSJJZzsM3DtzHSdCDoHcfM9prkPsCZtU0pyvE5LSGgvvK?=
 =?us-ascii?Q?lxubGQLFVKXkUDkqpnzpCAa58U0voG24?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bviwib853Jxmj92GlNv37ys8lDgBQcHVtZS02ihscMMbmW68/m3HdLvQ6aN5?=
 =?us-ascii?Q?bIHB0xajJJGk53AQxNYaXBPQcUnG7H/PYTYE/4Evm0Eh5rJZyY1A2l+Hp2Ys?=
 =?us-ascii?Q?mktqPNnMq6OHDmYulWJYoU/aXMQOUdG9lAly+0NepwQ8SRwNRnHPk3Hj6PNr?=
 =?us-ascii?Q?qAKGzng39lqzRpowsKIFWhc8da9ykS5pvzXdC0RF/31m+nSQNQyXPHnmGtwJ?=
 =?us-ascii?Q?gUdhJ3b+QVmk6RwVhNBPzu1apeyNXHzNQ7YHn110OzsXVo5HFf9Ms7vIapQC?=
 =?us-ascii?Q?ffC/xsq0EcRV6HxrQZsJh1VJKWKoqZcIZgCyI0F4jqM0NIdjQSFhiipoSe8j?=
 =?us-ascii?Q?wjMLmxtpr1U8So+m2mlrDrsAltj3MA57oGxKTq50KhfMJCJxPTbXg9eLOBpq?=
 =?us-ascii?Q?4JX0vDhsG4JZK7tGZ7o5hgsYBVGMqwBcxOakYqmwhEcHC22EtYYMwzfRCI3A?=
 =?us-ascii?Q?HnZZPJUrGRZMnSMZX/To4Cq+vNy1mHWTmLZi16EzKh8Vvl5I3Uks+Gn7b9lV?=
 =?us-ascii?Q?dht2mHTG6KAJQIvvFmbokF3GABA6o704aGmbr/Zuc008Z1HW/IXCMVsU6ARB?=
 =?us-ascii?Q?meTuYzE5TzB2HCCp/53AM2GKssmK5gxfzzB1Hjs3o6Wix8MJBtQ03wP5xdYj?=
 =?us-ascii?Q?Df2pwnvrRPYOREFuAJKAGJuTaouxeqLLuhoAZa6ongDp7kkscvlETzxRHHLJ?=
 =?us-ascii?Q?/EDj4OjKtnywbLz9FwnzyMRLK063w6GOuh9yIN7G7UFgxhf2Acs2WtEg4YzM?=
 =?us-ascii?Q?Bck9bc1Suj+iuBOfdIqYgLOCZ0kggroQINTukZwjsu4gI75dzwMl7CMRRZvk?=
 =?us-ascii?Q?QthNzHAaDwJ98fdTk/R6DaKdUaf4txE1e0KGB+91POiuvH+c+K/syHD6lqxx?=
 =?us-ascii?Q?VUH3NIeKoTCMdeFxwbhEt9rpO6X3UFjOCtPk1lWTc36sVrGXL0fVQKEN87Mz?=
 =?us-ascii?Q?o5JW249l62GjmF0PFTxq6AMtDQdIGCUckreOD5qsF0uLZ4Z/Klx/QenDtfij?=
 =?us-ascii?Q?mMYhgYc/pI8I9viptViO8yMzT2ysdZRlfYB7WfXMIuG3KQEOS++UWSQLrHfR?=
 =?us-ascii?Q?GeNSV6uCTlo/Fmff5vTqyEGgt6Qsbawf4wEPLem8+L9X8jURymxjJz+WKJZR?=
 =?us-ascii?Q?qVxwOP+/FL/cdZy9Z4qAlvS2dxQJ+jerbGscj1G4PVx2T3K1Pak4kURI3qgE?=
 =?us-ascii?Q?fDgMb2528xWkoV7w6S4+cqbjqdo0k+pkeMBndL1wGBIJ29JkBu3rVgQ4wFAL?=
 =?us-ascii?Q?wON5uluGUS1CfwFXL/MwuyMR/xuMcJWGHUopuKs0P1X9ZtX7mCfE2nUrvRmY?=
 =?us-ascii?Q?4qh4k7nrYXKxFRted/rfUBrmtvBNLe92QwCnyudHCXUl+U/6QMbiYmZOrmqK?=
 =?us-ascii?Q?dhl+sw6zzeeMMpKzqzZTfPRDJ1EoZhUa9dDBuq732lP7+qnL5UBliO7Xxo/k?=
 =?us-ascii?Q?QYCRrwlzQrvxdJhNetHf7kexDSq6r9KyZFU0mFv51PApouZug+Xv/P9+4UST?=
 =?us-ascii?Q?euxwX4PNeYnBfVLcaO3fGqW7BlBEac+UfrdAtUHpO4zukUV99hDUVoXnHQn8?=
 =?us-ascii?Q?q1l/KxrIs9wpYRLTO+c=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7baf0a9-c8ed-4486-f442-08de17dd5614
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 17:54:13.4196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3DEv1PljK1sbMv4TXCbcWFYtikgVKeWv6s12pqjiNqKHZCJvv++67ESCWC3iz24i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9435

On Thu, Oct 30, 2025 at 06:52:31PM +0100, Danilo Krummrich wrote:
>   (1) I think if there'd be a change it would be to kvmalloc() and calling
>       kvfree() on a kmalloc() buffer should be fine.

Yes

>   (2) A breaking change would also affect all C drivers, so it'd not only be the
>       Rust code being affected.

Yes

Jason

