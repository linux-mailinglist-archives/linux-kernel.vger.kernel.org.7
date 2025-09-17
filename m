Return-Path: <linux-kernel+bounces-820566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 416F0B7D5E3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D434487F17
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 11:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73A42EB5D5;
	Wed, 17 Sep 2025 11:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YnQT5vbD"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012016.outbound.protection.outlook.com [52.101.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4DF36C060
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 11:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758108976; cv=fail; b=lcA66S2ZSCJg94QARWiWImHMvcHbLv/VrOtk5An4ZspNsqS67fe6lteWEx59r79KKnRNz5xfDhz5BqhoVYQnpHSe+QQyQLu7pnO5ES+iM9QbY9QcZfiETt8UbZnmJngs4W/jhAq2OhfxSn09wlHnlzOJ4QzkFgW4lYO6RjErLAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758108976; c=relaxed/simple;
	bh=C3ktFSNqOxMXre8QUqC1W+clteu/TI+fjK2v3gwJQ70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iqQJ9ATIcOAFrhN3h08e0CDYMdmszsHXR71bCIzkV/KuprTfv9IHxTk128MAHk085D+LoH/H/gGdzdJFqNUPwuRVUZJCzZS4wCWz8QljU+OJqoLjkR5yArVC6fdxDxsRvuORFQ4lBo8FoKj3k+NQS9C01clBH0V22qZJCeOcdvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YnQT5vbD; arc=fail smtp.client-ip=52.101.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dM8A5nZAVTNRKohnhstBwCclnsrMi45fEdhstmZMA51D/PLjM2+QsZMVZ8gdjXLYe0DbNnSo5S7serwishzXbty9ZhBur2DxVoGRpp3S31Uurt+Cn2eN7zzQ2JWs1b/IXYLWM7/meaN61dHMhVArJm+N6o6xws8BEcbEhOjC5vqHXlZYmLzQFzvYGgcCIViBiFnKtyGrF8zTYATGIKZESVnX68qA215ttjMbqtxLuaKvkbPMoVOw64TaHU8aWq7f0JvpgErsMrGM+WttLqR8Auj2IXbNjKcotT9uoeVsnj5Vyvh9DInpw430QHhr73EmQmqxfrDNa5jw0+4u0d21aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmMq3uaGeTFcjhNe9C9WadZnSER/SE9hoTQ7LeMy2Q0=;
 b=NrSC37to+WOt32oDSFfPvTCNPtluVgk/dCZTFHQ/ATCMyyzWan8OllipsDwFRhHgLBTkfslrRQ9mP+b+uLZzZNoCZV7szx9zRbM9u1BCxhmBkrvp3FORCMDXaQUbr4d5+BfZPISr9IO2xGnQuB8+I/8YQaFatp6XD/Woe8TUTDNAF3qfjhmA5d1j/NU51y4xvtC5VulnlVwaVGBv289y6XCHThy0At/wAPriIv2utne1FHyEnLKWW4lXiwWuFejleLAKVOpja/LGkLouPKBTLR8sjORzg+iDHuXTRDhkcT0X8iqCj/iEJCwjIkQNTaVlDASqKBpq4KwiWlNdsMYV/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmMq3uaGeTFcjhNe9C9WadZnSER/SE9hoTQ7LeMy2Q0=;
 b=YnQT5vbD3sH1DR/3X3Ez2UCymbFWJhI86B5DAn+aGCko107WCFsPMlyuhUEAScnE3FfwbWVAwgm61XR2mQY9eGtdQ/m9Ms3YRMZd6dA/fcWm9vlUkG/HfIJnOxdEnbn50M7VkWa34P/yNQedale6cdHd2B3HHOiUNBSnsrdvMPAiuFrmh96Ai+wzf22bh6An/dQkBTI5Lp+pdV8tuBSP0fHTQuE1IDT7a88sLCgJhx68QMJ5K+EO487T2kuF4BtXYmAM5E111TFAJNIxmE9NnkX6amA26JVy8+CsnfgY3xFqdeD93h//7AYEkxxCwrP8Jg8I/vECaFyCD4xy/atdbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by LV9PR12MB9830.namprd12.prod.outlook.com (2603:10b6:408:2ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 11:36:11 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 11:36:11 +0000
Date: Wed, 17 Sep 2025 08:36:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jason Miu <jasonmiu@google.com>
Cc: Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>,
	Joel Granados <joel.granados@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Petr Mladek <pmladek@suse.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Steven Chen <chenste@linux.microsoft.com>,
	Yan Zhao <yan.y.zhao@intel.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC v1 0/4] Make KHO Stateless
Message-ID: <20250917113609.GB1086830@nvidia.com>
References: <20250917025019.1585041-1-jasonmiu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917025019.1585041-1-jasonmiu@google.com>
X-ClientProxiedBy: MN2PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:208:c0::48) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|LV9PR12MB9830:EE_
X-MS-Office365-Filtering-Correlation-Id: 71731e70-f007-4559-8484-08ddf5de66a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1Ewm66VGSIZXTG1Gj7Bq1dFqL4yGqxNUSXdWZKNvcNdqUY6Ep4tfFZa4eFGG?=
 =?us-ascii?Q?aWkytNRKaIwSVabCxokgAYcq4MogjwtjcO88rnFJ91S9rNQrCVid0cJUXHrJ?=
 =?us-ascii?Q?AcL2PhEZAoutT+LaEpvUrHIEKGU+NzzWnP56T7l3gceJGvYXrk5fps3cJeL0?=
 =?us-ascii?Q?IZYi/dVrQoryXpL/uffA9dC1549XoOf3gZUBr+it9OwDMXiXJr1pHHaMWNis?=
 =?us-ascii?Q?GalNanVJioHrxEAOe8mLAq+RoPARBmidM+Vs6M5MYRpGbF99BJTES2saYDAA?=
 =?us-ascii?Q?2jk2XFj3/LKDnBgrCFn7CIiviuk+N0bAMYSVP5seO/go2V6vA5nFMuLa8nPE?=
 =?us-ascii?Q?Ov0sX+KLOJdbblJw6nvLl5bi74ekOQNd6HqBstDKlVHUnJSiijIV/9FIIlV5?=
 =?us-ascii?Q?n20nkPEpRtnU78cc/LJFiky46Bix10NGt6RshbMX+09UXV7B78krKJWHjOhQ?=
 =?us-ascii?Q?fr3aLsuZM5ySuBrR/ILZSJ3RlcNjhj0DarwLgxPOJu3CUfsMoUTqpu/Dz/7s?=
 =?us-ascii?Q?jgN2znJEB3ihhHNOmId0pt/ekirCcN1Zp6nxGIAO5+GT6ilhn2aJ91lMO//S?=
 =?us-ascii?Q?RXqGGH9RGV0sj7tP4duU0NgEWEEparhcZWOqN1WH/R50emd7OmBnKpdGvhNC?=
 =?us-ascii?Q?OOXHUTfs07vQOTHUP94NCRD6Zzj9OVEZP6sqG42Qg7kHZz4PxbTSyRBbCIHu?=
 =?us-ascii?Q?dtVFgjWAG+K4KeUevd5ZSAWLGOxCUgZEliz0VPGkPXim7cweEgro/2MbGrg9?=
 =?us-ascii?Q?HAqHYKKm8JCweALzEJQ+Wle8sfkXMG76KnoOQD518Ownsb/orkyPsmD3rJ2y?=
 =?us-ascii?Q?Eu83iTcx4szHnsU/LfKBUAjrz8x3k5HbaekTTSIz92PFVVFhBcMgmEzBkaIO?=
 =?us-ascii?Q?spHQMvqm9Sp3bEBkR/KB2WtK/Ti/R/+2hNZtPUjRJuwViM/4pa0j9hJ2TIiI?=
 =?us-ascii?Q?TFjf1BDoDnK5PhjYVwPUNo/orbdZ2OuOW7vCP71hCKE/UIZXD8694cGyB7f+?=
 =?us-ascii?Q?lPvR6RFspdaHLBjddXTrc93ATAebtt5Xh2553qvpdkWv48AUoioXx2vyBjSS?=
 =?us-ascii?Q?D+79ntgSslbcc4UU1+1YZl6r8NxYlNhqsNbShgSLEeOUp4wk8Ht14HodrcVy?=
 =?us-ascii?Q?GA9GK5ZUS+gX3rN0bSGaFYkglF6EUJUgrYlHeDf3WjF0oaIlIBe/TniamuBm?=
 =?us-ascii?Q?wuPu68EioQWzQOEazbRfaBeRd00VMKWfoRbtAKsG18IcguBW48LfyTlOVwlv?=
 =?us-ascii?Q?rLifea2kboJnG4Rti2HJPSTz8duG/cSj46eNSMzM+o8J9S78bXc8tXq8FCS7?=
 =?us-ascii?Q?9/Gu9d7+qz9lrMMzsYXmPrU1ntAcIn6d8y+cl793wClnTgae81rU3APGLe/e?=
 =?us-ascii?Q?hBEwuOvWjYfO21+q4envAjFQPr2LJ3dSpKtBlbBRiFfC0ORtT0z5YKeuk7FP?=
 =?us-ascii?Q?Y4OLOvHcdp0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cspLpFxZb+k++cOlh0ruLSV3PqUusTmQteQ2QUcNTyOK4gxE5PYWCrwCbxTL?=
 =?us-ascii?Q?brvD5+UzTtgelv+dmSarnnRZH1PKrC8N2Pp+xt2jojXVO6NthqxgI8P9lhDr?=
 =?us-ascii?Q?5mB4jQaHsBpwPetGA7ga/N7EGirqy1bwHjbbU3NWw9a7qysbnwVMcByDdajR?=
 =?us-ascii?Q?iWwOqrBY2ts8TJxUpSHqfa21/P7USe16iRWF1MpK8sBbZUlwsrpvmXeo9a3o?=
 =?us-ascii?Q?rQMn4TP1vDxUxqKPn2IpgtKITgoboECRkJJrWd674Z1qzUfOuzyoicn+6MRR?=
 =?us-ascii?Q?ktpX9/nlo6/V4zqbK/JUVbPatgS615W1MznrZeUTUaEawtW03T/u67qOSpRv?=
 =?us-ascii?Q?4090/adgOXqU48pKvAuYSPDqGrpWsXBBrCgVvBrrWr57BJC+taUdD+zjAMu8?=
 =?us-ascii?Q?nvZtxuBhRZVTYcA8IjvkxkBzwhqz5mN8VXSlhOG0yKn5q7HTYvOc62sMY0cB?=
 =?us-ascii?Q?JmMmKnNbuBT97xJVOR2mDyuez89+modsWbumq1vA05RYDUUPlG8uqarWB1rP?=
 =?us-ascii?Q?tnGXtSua66xw5tDqP7Wi2uizTNGULM0BX+1ce0ru5N87zJqD9Y/SzGgpF/AO?=
 =?us-ascii?Q?1DO3t5OWTxgCoFww5QTKT7MiFxg7Bg1esTjvt8S3nwXpiAOmG7Pwjls5We8/?=
 =?us-ascii?Q?CpzjuVpDsoLttPSTSha0MjVtmuwUZUjAo5u3LPP7vTuZCOQzz/Fpfoi/anSV?=
 =?us-ascii?Q?DA1BW0k+TjT/xk9L5ZWygQbvPtFwMhJ1AEpwHqOppHCwRGQNio6+iC2PeEaI?=
 =?us-ascii?Q?udERoQD2GG9S2GjDSNTExo/gtgSYz7QP2DBv7PmKQrYblDG5Kw9wRJID0oKe?=
 =?us-ascii?Q?KSIUkYBi00SoMNDYrAlLOz2qycmLJfAlOozoJwbhcEgbVvuaT1TKcSm1Fwxj?=
 =?us-ascii?Q?XxqAFtyV3quX4lghO3YS2U+d8mnuG4s6GPFg7txBqX+eeLICVPMnJLSZP5R/?=
 =?us-ascii?Q?3xUOl1GBhbkzS7oNCowcC4v0qC2yHrtklWuGnqevbOYXYREgNGMFVqYvEPpT?=
 =?us-ascii?Q?uRssqq06k8wfiD0c73VnTmSW8RnZJ9F7qQDxqoLhEo3/50Ffw0svgUd9CE97?=
 =?us-ascii?Q?hR/UP0sUhp3eQfvyHaI7mNNcYWXWoCFeeB4evPJCyMAgla8sbDa61SyS5m2c?=
 =?us-ascii?Q?A+CujjLQXDfg6xMbsDI72/v3jSrdu8S20t86e6NyCyxCOIgHLXIsiWc0487k?=
 =?us-ascii?Q?3pN+x1D6Op/F2EkQ/EvaL8V+NuUfQPbTYUmcXIcJGlR3N2SMqoPvwTbJP7Zx?=
 =?us-ascii?Q?+H33Z8mK/fUMu81kmSYVvSxnjp0mSdw5LT+btqo9TPMB2IXA3CfCDpe2CbWe?=
 =?us-ascii?Q?iiwLgcxtVUqjGizqRkrjcEh5un2oVHP5bpoVK8TGYwu7iENJVHInWMivq5qG?=
 =?us-ascii?Q?JQSBb4056eKQECvowbMNBtU/WGSEeJXZhOqzycozdzf4aU2+G6rjsy4eeiD2?=
 =?us-ascii?Q?/tBgkTZWG52la5NFOiFuZxadDqpxcsqWDiaD1wAwu3DYaZBTWo8t3Lj2S9J1?=
 =?us-ascii?Q?H2rnUEpxG/AKQxUEqxl+yAEr6VUkJYLf4UL+Ff0yilYk25pK1Z7q5jze9G6V?=
 =?us-ascii?Q?Ghys8yYfKPMgt0rMo0sJFDkQjKfqRMXKc1QRGzmB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71731e70-f007-4559-8484-08ddf5de66a6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 11:36:11.1534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PUF0av98E+vMW771nQhCJWaJ/PEwiFfM66j+1OfG6x7PtX/aJHBiYM6b7d+ed51R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9830

On Tue, Sep 16, 2025 at 07:50:15PM -0700, Jason Miu wrote:
> This series transitions KHO from an xarray-based metadata tracking
> system with serialization to using page table like data structures
> that can be passed directly to the next kernel.
> 
> The key motivations for this change are to:
> - Eliminate the need for data serialization before kexec.
> - Remove the former KHO state machine by deprecating the finalize
>   and abort states.
> - Pass preservation metadata more directly to the next kernel via the FDT.
> 
> The new approach uses a per-order page table structure (kho_order_table,
> kho_page_table, kho_bitmap_table) to mark preserved pages. The physical
> address of the root `kho_order_table` is passed in the FDT, allowing the
> next kernel to reconstruct the preserved memory map.

It is not a "page table" structure, it is just a radix tree with bits
as the leaf.

Jason

