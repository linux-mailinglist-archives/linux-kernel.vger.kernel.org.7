Return-Path: <linux-kernel+bounces-817204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC929B57F3B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79AE02070F9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3CA31DDA0;
	Mon, 15 Sep 2025 14:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="djgcl1Bh"
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012010.outbound.protection.outlook.com [40.107.200.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB01A30BF64
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947059; cv=fail; b=SGQLkyXkSX9gGxdO7IOgQD7Lvl4k1HaJQCHoiJxms3V8DNtKD30eRRaMkOv2t5SkBTY6F7Iht08h/fiyf8wONb4rJhXaojoMLV9jTA4gmDJoLtubogvFBwYZicGTi/ezQCQEgnKhoJb4fp0TVl42Ny1bGDfehoZMxBp1wndK1sE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947059; c=relaxed/simple;
	bh=vcfW0CvrSsWbRB/etkNkvD3xhNZwiT2mlOowyBZ5h/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D3Jo0jNMjCnsqyuKDyfGyCFh0xlntqsaO8zxjraBXq4m3vAsjxR7+EeM5+1wO9ukL2v02h4sBSz/r1PmIUkKuK4o66Z0vVhAa73JvNWls4lvp7FeVvB/tBNz5MktHHlufYKHgGzgy85nT4vm+Fv1++7d4T0+PJQ+s+GftKL04Ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=djgcl1Bh; arc=fail smtp.client-ip=40.107.200.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pln9DhEF1FVFgbbfYa9hFf+1BmT61kGpVWkHpp92d5dWEv601l0c2lG/AnRSmDlJxCWWr/j+BtcjMnk2+c1KGUgq0hQ9dTpDoloF/pdJ1RkCipq1AMUXg/xjv538OI2Ra6QAJVDYBll6cMpLefmXiTFDetfJOjpEEP6+IA/5yaek0LFHo8ePBlVxM3AQMoYef28uow416HNsfYad5cn6XQ5waDE0ATRurxeqRSpgu7GTRxrMHE7qFzm47jDqDGouyaXRnAz66XQ/o/3sqhGlNRRxQl0O9MeuK1aOEPC44LC2rsnDG8hMbLKPotWtOS8i85y7JNRiZk4/T1fagjjbTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgwEby8XLxCdKBc+kvg5wwv2qNHszMit88gYnfABzb0=;
 b=IUsLjzRU9cEUC32FJlu+N1bluLIdICOv7qJ2ZaWvZTAxbHTtQp7l3/Ajt9CnIMAavYlPjkMjf8iLDzumVvh2RKO+KexvKmOxe/tbdvmZfPqsWGHfOSwbSY76y/34+tEo+fsFvCBQ8+7l33U59xQZP68dkF68X8Lr+0f7HLjJgVciEZeNrfDhgY+cHjL1qabQJdG18W1zCP5hSwUpvYfO/PiQz4lSucQTT+Tzy4dspqjpF6s4SjBrYnThEpYRAPxTbGST9O2B1S9gAbr21mlq7txy03gVneQz7am+lKwiXlrBRG0fVwEuSO+pDRl0RnOqtReBox584ozpGui/E9S7LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgwEby8XLxCdKBc+kvg5wwv2qNHszMit88gYnfABzb0=;
 b=djgcl1BhPamdRas24740Zodcrm0P1JN8rzZ6DZjucsnFgiIJsmumRec29/9yOgHStKhcy8mJObWi9x3WwW1vDlE2Gg+/ngD9R+SpNjhB385E8ekVm6MXgieHwgspZ/n/x7VOve5R3ZNzHsvPzjE2Cab7ATPa/EcL5Jjgqt0N7pIXbIhZUofri7X65xyRXVcXsv4nPKdO+UWfn6PHJtVAAm4i6ccdstcDLrMGevY17sIthUCXdO746KuJ06MiJjkzbAJQnXtToKpH6E9GTyCteWYg56pKVkDfLSKtb9QqjMLtMrMZEmvr90BS3Este1wwtmAwRcpRTn1t8q4Jf68AyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by DS0PR12MB9726.namprd12.prod.outlook.com (2603:10b6:8:226::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 15 Sep
 2025 14:37:33 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 14:37:33 +0000
Date: Mon, 15 Sep 2025 11:37:30 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>, Chris Li <chrisl@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] kho: add support for preserving vmalloc
 allocations
Message-ID: <20250915143730.GK1024672@nvidia.com>
References: <20250908103528.2179934-1-rppt@kernel.org>
 <20250908103528.2179934-2-rppt@kernel.org>
 <20250908141423.GJ616306@nvidia.com>
 <aMgcHWxsEWnKzzcN@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMgcHWxsEWnKzzcN@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0173.namprd03.prod.outlook.com
 (2603:10b6:a03:338::28) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|DS0PR12MB9726:EE_
X-MS-Office365-Filtering-Correlation-Id: 0326e7dd-4b3b-4701-3a58-08ddf465679e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f3PFlmitR2zATsA0yehv/5u2iQB8Bn95jW4zBirvkNhvtHNtdrq92RQoPayc?=
 =?us-ascii?Q?4A75wvjBIPFK8P7iMR5Ok52T4t2G4IRMHwhYgbCvBSSE7VxuYHqU0PnOEfUH?=
 =?us-ascii?Q?4nJPlLpSyxqOiBDqUphjK2E9GfIftz0XsYx7vn9DPFWsL28h/uy88f2Jpu9S?=
 =?us-ascii?Q?S/fZFDktNLrMhPa4dF9wPZKUDHQh2YjgdjJudc99JI6+wDpBeL0BJGUgKZWf?=
 =?us-ascii?Q?iBXzASWOhyOFADXB+DApiiesJQTONHFgLyEgsDr2eTow20aMrphuXoFCY8bR?=
 =?us-ascii?Q?SRbe4C3cDORJc6w7grPlTtVNUrf7O6lZ6J5e2twByVWXFV15EgV4Zunhx0um?=
 =?us-ascii?Q?AimnuMHe8c2W+JSnz06VAk1LhXnFqJEy6sJVJSQZ57vi+fVvRRhnXv9fdZnj?=
 =?us-ascii?Q?bIQ+4j2f7oP8kl9uvQIOTwbYHaW7LLocLHFUimqMenzneF8RGraBlx48f212?=
 =?us-ascii?Q?7YP9ufCU4jpnMHCUqKmQ4ZbObUKFVOQIyrLNdd35fc1Q+C+1CU9i3I+yH707?=
 =?us-ascii?Q?xjC3RagTI5Vi9I0WEFr9nysOJZYntfXsLR8FlY/qD/6OMhp5/c+IkaI+Kliu?=
 =?us-ascii?Q?0YyEMkp3MbZfeuDGEZ82ikJP68UqPdTeAG96tHwqdq4suudEPlhvMHRkvmYG?=
 =?us-ascii?Q?6k/J5QyYwZxN3ibSqV5B7ovmuoxdc1xtFZ9Qgnm5vfJccZ8hDohqeoOVfi/E?=
 =?us-ascii?Q?EX9W8C8PH3ATIVOPCD/uWdPYBM1ymjhsGlpBWSOcbUwEjzQ0t9EGA3flYU+G?=
 =?us-ascii?Q?bG21mImDLqcW3LxR22hF8roPOF4gvpXGFK2NrP0/aK4mQiiFYcbD85cbhUiM?=
 =?us-ascii?Q?Y2PaiKbt+nzcByg5Y3Des1FJULQOZXzCbSjeDX0I9RwuEAPG7kTJZPPQbA43?=
 =?us-ascii?Q?dyBThp083gvDghAXX5NX8UzXS0yl/IbRmMPIG31t+QNHRCEHty/u00NvT9UI?=
 =?us-ascii?Q?xGPyLNWOgOr9dC+4APDi3jkNWL10Hy7t0as5HwwRPoil+knCbhx49uH9necT?=
 =?us-ascii?Q?Ahn4BB/Okzw99R6vJfktnRC67G8a32UooP0DknJTM/b9XYChZXMFD4HYDlkY?=
 =?us-ascii?Q?ee0lQiVk7QUeVoGB1yYMZFrZ5hXq3U6YfBYP6sDze8jdzc+ahVONuth6jcRZ?=
 =?us-ascii?Q?Q1iWRIw8OKSw0lprgUqaZtstE5E82C/n/IEOeN/tL/AFtCcp9mZapJRsnnXD?=
 =?us-ascii?Q?pJLC80XndnluWSZBQ4MnsrM/6I6qZkX/8Y+scoDQitZ3aWEuQ7nMJVkbojSd?=
 =?us-ascii?Q?qcfqD8GrpumAUI4eqldK1UhsfLkpW7qnu1artyHuE4BDEy18aJBfcZPbobQd?=
 =?us-ascii?Q?EFBOa1jpq1l7SGSF8p+/Pb3d0Wwh1bPOHHhIq8wuTRqyhtp25Pw/Px4b99qO?=
 =?us-ascii?Q?1puCHXi+5Tbi/+LTS+VjhIk93K2/YqGmvhNcoVZl28diBkQyxgI77xDMmPBX?=
 =?us-ascii?Q?Gm00Hltux/I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sLT+9SWOyvW8sCZTBqwHDvI0bzL1omNIgTF8Nx/ISli9GefVB6c18f8kgLSw?=
 =?us-ascii?Q?+901GXqZrLDUHbUCw3N3IHkM6Kdl0fWmyP0O5a0RpBBoNooEi/SEJ5ncMJCa?=
 =?us-ascii?Q?oSa0Sg1oCjdSGU3vWC6ZcTnttrs8by1Hcy1Z8l2dOHrMtbd4vrZ4qDlhgxhW?=
 =?us-ascii?Q?9fiqK6egK40Z+l0DGQ530345gLQSqvRr8/3QJxGNNM8JkYXhJYrWnjWoa42r?=
 =?us-ascii?Q?264DUTo4r8XwIuztisd14FE4Xrv+oHd0FWscuuiH25sfKMbgpU6o+y5ODnbo?=
 =?us-ascii?Q?IJCky0zXZDsKSo0mt/3itew7YlCDkVAuK1enHYREsksDfmVzk8EA2ASTYJcy?=
 =?us-ascii?Q?Bq3TxHudn4Wu9niKjmhOKepWrARKuy0K8npG3l5mIiprnxR+3VIl6ZI83ZNV?=
 =?us-ascii?Q?veUenWi4hiRFfv0chM0KRPcpl8e69im+h9xxu/h+zjx/MomYS3840kTx5uue?=
 =?us-ascii?Q?m6xWXQKkuuOQRyNzf9PTCOJWDDpnkCZ9u7wzYzFTPE5OwpC2g3U1uT3/T7Gi?=
 =?us-ascii?Q?9qfVgkZ211BF/puNPAnPI5JBIuvgxCaw/dv/6I0f+9B4ThNBPXoJmVpVzeTZ?=
 =?us-ascii?Q?x+mXlDKGy9tDd9t9obhSoENedZw/jqW2dgrA/BVBr59tTyLsFGPWaEw0tftu?=
 =?us-ascii?Q?e0cosCYyufxACO5d8kdpSgeY5ZKVBHg7Yf+xISLXtYyokN1mzkXXnlio9YFS?=
 =?us-ascii?Q?dMpXPBugCDA6sdTdVMG6fhWtmdUqMjgWDmJErUUzmaio/79YiBhxVbQSYZHf?=
 =?us-ascii?Q?xlZbPkYmGtK7EjIg+Cx1RmAF/ytwV3VopMib0QgenzFzpfWvsiks1AsRZysO?=
 =?us-ascii?Q?hHjqfeFQ7Uf1ZQaBJVOsnBEbw7zTxR/PUT5QRUFeAKG8zkubtYXYt4ndAHF4?=
 =?us-ascii?Q?UxxvNFH3TEABHrpqkZ3GYQcLfqSkLTNjMaL2k66/GZ3HONkccJu2q2kg2fet?=
 =?us-ascii?Q?vwHrZtyr+6VT6b04svNFt0qnpE1/zhIIxJ2gsLuBycXG2Xnbif5zs9/wEIdb?=
 =?us-ascii?Q?vkXylsmcNl4jNKBxPoidXkSbWfsnpTWRyMAkpZkmpY4kV/H5tnb2afhDnIkF?=
 =?us-ascii?Q?MzRRD13ZtN8N77GgBG6/5tiIu9jDiRuAZ/B9cnUyt4slmSCYjRttvjQLSzs1?=
 =?us-ascii?Q?qA0IbHXBQyUuIexTd6sBQQix4inyVLvj/mJN7O9iLcC9c3siEM0aqq4uyyZf?=
 =?us-ascii?Q?zRumUVmm7GalKIfIseaGxHLPmE9qqXM6XsmMOT1/D90EStbO5n35Kx9nBdLJ?=
 =?us-ascii?Q?ONIPhAdjAhYSGqfb0YqNu2+dt19ptGfUOjkS4Yd4nXelwevMtsC3idSlEO4M?=
 =?us-ascii?Q?n4pxwy0BcynFgPq6cdiInkGM5fnu/UXzTi7rVotJpGPwLhYQr3vRQHZDNPNb?=
 =?us-ascii?Q?wXgd2QAtawBIvkNycNASNgTVYRLLT6GCIVdu28+VMBLGPT64Mn8lmOIHcuDv?=
 =?us-ascii?Q?7XYaduU/ZFs9BbdGBgk8OXjXnG+sytk+XoA7PCyROHC0uRFNXU4LhNgIk6xS?=
 =?us-ascii?Q?zAxTxj7Bzu2+WbrAz9i/e6jFxas+jm2Vv4bpK1Ei6u+BAG+/aev8H+uaCAvH?=
 =?us-ascii?Q?U6+DlxhvRIPgxZpAEGQula3B7vHzlVLe8v9kOUaB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0326e7dd-4b3b-4701-3a58-08ddf465679e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 14:37:32.8702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6EOQdT98QJDarndUOujkaJJv1YPok2atJpRljq19i9wIswFVXVmqP94N5pcKMopD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9726

On Mon, Sep 15, 2025 at 05:01:01PM +0300, Mike Rapoport wrote:
> > kzalloc() cannot be preserved, the only thing we support today is
> > alloc_page(), so this code pattern shouldn't exist.
>  
> kzalloc(PAGE_SIZE) can be preserved, it's page aligned and we don't have to
> restore it into a slab cache. But this maybe indeed confusing for those who
> copy paste the code, so I'll change it.

It really isn't. The kzalloc should be returning frozen pages for that
allocation and the restoration will not put frozen pages back.

Jason

