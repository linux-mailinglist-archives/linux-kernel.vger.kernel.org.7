Return-Path: <linux-kernel+bounces-816811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE3EB57890
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42E0216A84E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36B42FCC17;
	Mon, 15 Sep 2025 11:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HJOEX9B2"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013021.outbound.protection.outlook.com [40.93.201.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F4E18A6CF
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757936120; cv=fail; b=PfjTVztfyK7uZ2bD76SOve3fHsHXr3RPyItRYv3MUohuXGSWdNa95Xp1DwOMyCiC57NXXKnMb7GM4UMzHIsZwHMBKdyDLu6lXLz9mRB331rd1RDbkP/vAA6tkcABbW+vMTKYIAp/jLv3um9Ryo1Son5ZUwMQxYQtogWKgcsCTsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757936120; c=relaxed/simple;
	bh=lghxqhzQ+Med6Fcc9bCZh+grzFqffBUcYJ5vK899uOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UPhISYEZ5YR4TZUlm0eBhw7FmcgOL4V+ZqG5TYVFCPepP3KezKtI9+0r21CAF8TIWsPROWxDy1ktUFPkFOOSJEBUSkv3BjhQRmwVo1x/fjUY+NzREostQj7Ujr83PU8smFs4Gppw7K5dazPUg9BltLeo007HC7HsDShN8MPfkwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HJOEX9B2; arc=fail smtp.client-ip=40.93.201.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sot5YhBpK8HmKE9/aQx+YUcaIAygLxgnsrQbti2WD3I97wuXAuVKGtzOp9pZNt4VXBWmUFHxi32IFmBcQrsp12B9cyW61aOt+kwXmAUaFeQr1reALCiynCZFpaACpBSIOvoARwd5tkJivkmtED19kdGT3/SbeOQb8K/Qbq+VNvVjYOhu4IWOrIGzPP6xi9U+8PjWHu89sTE9OOQljCQ7xfWClWq5/DDF4q6RaCtaz4Yj1BydBJM3iRirougDJC8+XsMYisEqIs7yQmbhChNXaln14mO0t5n8YuZ/VlHiLYEFHz2kJrrgF6stPTNa9/BGRf9JwXfAILxphidTJkzZ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxWi7mUWXKnxFx6nnTAJGAz5vhrnBI6j0MGAcs6ARfU=;
 b=VooeU/jldbOxaqOB1Et2ubid7pLFPkrKnWO3gU38I2bPn9igIxZe7MXGMuDH6KATyn5QUWDn40jpg69u+e4ZnKCMg0x2xTgveEyqMUIj/dZUB/1Q3TvXDZLiaLNDTxrdrf1SQ0n6ny375bwo8Tw+sETOK1THw8iiHADQUsRm3tmc31k8O6FwYjAGLPFXxi8BAxBtdTMoq0t2fF/eIR4nj6Ywc/yhcuG8j4bffL1oUix+HHPUMJgdDivVPBlKqitAZpipfs5I8WpRY6hOHoySmg4m64csppsk6C3feOzkgLXJoyOMkGS7+zqKWyFG3g0hY09JfFC+QYcLfEJt7YMLNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxWi7mUWXKnxFx6nnTAJGAz5vhrnBI6j0MGAcs6ARfU=;
 b=HJOEX9B2+pNHYYcMNHGC7y9CmNU1gZQdTZiO5wUzoJB0XEqgPT16q9HDV6gVFcFpA7RSXOSvYjkQ6vZdsKazbYRZ95yXgdBk2L5+tdh7d2KSNw2crxiEWl4bGFXTLgFj+x9CqNUkZm0BkwTlvl1nd0uvTWDQWaVRBkAXgCOaQ6omf7hb6PMjvO2OHb0EUDlKKaKTwVbc4dXkcBqRNp1d81pcTrISxxMWE/G89B9bPO8L3UsYaSOegFhGtg4jwQj0dHUtkvmdJJeRksFuNFc+kXMA4pgoc1RtYvdBAR+r+ajjffHZOvuIidVfq1rmMAx5BGplnWZkN86p4c2use438A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by SA1PR12MB6872.namprd12.prod.outlook.com (2603:10b6:806:24c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 11:35:11 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 11:35:11 +0000
Date: Mon, 15 Sep 2025 08:35:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
	"Hansen, Dave" <dave.hansen@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, "Lai, Yi1" <yi1.lai@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"security@kernel.org" <security@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v4 6/8] mm: Introduce deferred freeing for kernel page
 tables
Message-ID: <20250915113509.GA1024672@nvidia.com>
References: <20250905055103.3821518-1-baolu.lu@linux.intel.com>
 <20250905055103.3821518-7-baolu.lu@linux.intel.com>
 <20250905184355.GR616306@nvidia.com>
 <BL1PR11MB5271A6FA21418DD8486089AB8C08A@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR11MB5271A6FA21418DD8486089AB8C08A@BL1PR11MB5271.namprd11.prod.outlook.com>
X-ClientProxiedBy: YT4PR01CA0319.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::22) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|SA1PR12MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: fa71d695-cb89-4a04-bf8b-08ddf44bee4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UD3yuW6UMMIMsghJpqjoVGxT0ueGzT9UJ3p7FV220/RbQ+O+KkU2GkB04geA?=
 =?us-ascii?Q?plv/MONg00n9bqgMeFdy/p1aprydGIh/z6AFZfT+ssWGIfXiJR639uGfTF/Z?=
 =?us-ascii?Q?Bvnyom9Towpn1f8SHkAK6joEUYRwu5SG0huhxerMc1y9KeRDZZ64LRznTGPq?=
 =?us-ascii?Q?BYDHbWqmLzEB+W9wpXkQZxQreHCptaSMNMP1fMGaddlzqIovqvSJpKcrMLOr?=
 =?us-ascii?Q?2i1FpjyBEOaQp58UhHqIQrruqWQg38CBP/BBCiQZRtKrh1YMDKXK5k8Qu7mi?=
 =?us-ascii?Q?yROcz6LLNOuFqnrSiK4WyTEF7oQG9m2aScGzCp9hFTVcvIe8PUVuIvVrBFoa?=
 =?us-ascii?Q?J7JJCUXlDe/QfEWWPyZjsBVbrvGDA8mH7y743OJBM1+xarPHDQeNSdIVCOXV?=
 =?us-ascii?Q?EOt2danoJBn7F/APdJqOOUbUEk52n+Rlmpa7I6FyCRaRgeH3a/pDd+RTKEay?=
 =?us-ascii?Q?DTQAYe7seiD3nxroRsX4IYp/TzAwe/58EXLhQvkqFXOdj/+0G8xZGn0DdYaX?=
 =?us-ascii?Q?Iish+2+AUgFzbwzWFFRCU6Fa6KcA+5v8rSNs5YNE0SVOxfncOViPqDsORvwt?=
 =?us-ascii?Q?W0FImcNh4GwLvzsqDVZ2EA6vXI6I7Rnr7S+Me8GHOgTAsXB+JS+t3ytAEm/Y?=
 =?us-ascii?Q?aAVzRGENm/yarxgPUpklMh+WFv5uwpkdhLywToXIBV1uYej0WL5PmGrnjY07?=
 =?us-ascii?Q?5KC3ob7cNupZUktmmDXw/n+Rp+NLKLWG3Oz7FqRQkP81c0XjOeDYE3fKKAdA?=
 =?us-ascii?Q?QDAdWNlj0AZNAX9iTiBpcDMpaM5SyB6O4KVkgbNxHxPuaiAUjuMb9BeCsfDX?=
 =?us-ascii?Q?JEvYZpJyfR7OEWnetBmjCVqIIr/NavIyr78InQ/VdL9zVS9XiCiYhjI0yUdG?=
 =?us-ascii?Q?fsp1dv+XhLL39LVMkWi5O6hWNCFWLD/5ExSchDdBVdFFyEG2kgVflBYhaXS/?=
 =?us-ascii?Q?waQBCYktdjFJMC02LVrtIA41Xc4xlHE/q9+DWDMVqbmtlPsLI/qFtnlqRMnv?=
 =?us-ascii?Q?VseqtC2oGZXTt1v7xa8oEFRghx4JwwrdHBrGFkRGGApTAz90rM1zQxy4/GJg?=
 =?us-ascii?Q?sJnJzM2zVjjMXEwzeQLx37yZwtjNDX0qQC19mxm9SlpibZ9jNxn0uAU8XjQg?=
 =?us-ascii?Q?DSo/RV9EVTmJxFURoZvxtLRVklSR8ajzqUUM2jSghuIs+JZAyDNaz4wfurJo?=
 =?us-ascii?Q?pm66b85+VpC+WZoeiSX12iiqU9xgx5beEYT9tcMupoUqAwfQx5egOmr+m+lq?=
 =?us-ascii?Q?DBtUL3OAyfxO/2nPLNW/qoBOsJmnLt5IGgcZKI6o+G9ZtYD/I5FP+ndS53xf?=
 =?us-ascii?Q?oGbSO1mgSB8B2zJxphIeXrqwNm5jPQLTY0KwNS8+38xl2kefpSDZ3KMZJuIc?=
 =?us-ascii?Q?wbmqZZ9sKZyjU/PrVI/i3I5vuPNtfF4wRthFR0X3czxRgsIqmA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/+2CuxjZMJmwY1lpbxdJkid6m4fsbUkgmyoqMvUjJP58N1bMzoRE/gl6+J5R?=
 =?us-ascii?Q?gVrYJAKLv8csA8cr7w47S3gvjkRfEjr+7nAW8dKUmehDxLu1W72fbPjqFV1n?=
 =?us-ascii?Q?VSUj1Yc4H44uYO+ES0ZxYH4pODWf32an9/hZ2JN4p6tVNpg5Ouq31xcH9RMW?=
 =?us-ascii?Q?QPIfoxTYPOGQhLerTdlPwAdBYRJNJN2Bb6D4hELiIZem2kBVV08x85jXR1wF?=
 =?us-ascii?Q?O5q/ZIQNLQY1VYo8SO5zwmCrcVL6b05tcY7oyeUbQeqTj/Tsl9/cxToDKiDn?=
 =?us-ascii?Q?4U81aaIkX7ElkvTTPN2kKfDYf+07q51OES3Zqop/uTv07G2nucJT0qtbRGbh?=
 =?us-ascii?Q?G7FYf+cs+ZBugkv7kaGrBp2IFew49SKQUGAx2f1OwOSFLGSBNQkNF9ckidnB?=
 =?us-ascii?Q?ON4s4BqUD9pZJXYOAuJFcvLkvdrfA0te+H5p5SmULZnzZn+pLartgALDgEA6?=
 =?us-ascii?Q?y7CETAMoJ44b7ef5ALiExZ5ciFIp72STZv5BrT1KsZnx9a7XSUnpelIBQhOX?=
 =?us-ascii?Q?n2zB1bILlrSxIiutOFKMBBj3PUyLu2YKCAavRl3Y/oEV3hDnB9zxGOjkfLl2?=
 =?us-ascii?Q?3np6oeTFTOQYikSXVtE+YhhW4jO13ZqC+L5N7QuB1NHXxzLUPnmyaLOofLZu?=
 =?us-ascii?Q?ZZxK2hxF6VNvAcWYbHZ84+k89a26LSanlrMEkja+fjjRXxL1cNYKp48hr25S?=
 =?us-ascii?Q?srf/EFFEBqhtnc/lnUJvM9W3woFKqCZmvz9OpYByQRS/1dWXmHZQZj3Wb/Lk?=
 =?us-ascii?Q?g53yBO95IwbAw5o+K3W9GezhpzCiosGMpl5Pu2aXT8jVa/qzI8rKpbmCpH5D?=
 =?us-ascii?Q?qcPlPKrtI9/Z5GsF7pbMHWKZjMBwWlU8XyPZtIq8VFSAZ8iOo3fblIdoeQCf?=
 =?us-ascii?Q?pB1qivsmyKTbqZBue59rRstdsB3PJBiGT3PTDpAAUwkjRmakUgE0CQHasu4o?=
 =?us-ascii?Q?69veGZrBzXiEx/O7zAyNIv2wIGiqMpeQ0iGRObaYXftfJQWtABZ3h8Nbd/l2?=
 =?us-ascii?Q?rGm09kJ2xkOBu4mlWsew91UdvKwZJVpAOve1yBwJ0GZWmKDN/FFfgTfVahaE?=
 =?us-ascii?Q?9ChePYMDG+hPjL5B9ceMpbEdbJPXh8uQe76ZdNlX+DWr42iZxmeIBQZbGiwh?=
 =?us-ascii?Q?C+MSf2gGn+DVkMwPhE4fDBg4gZFLWpSt+7aNHaF367jsXHCgLUwRV6EDCody?=
 =?us-ascii?Q?QDM4W7g97GcU0tIRG79OB9YiFfpYcfowA/p+vkFIQqfbAwySouXGFigKebjv?=
 =?us-ascii?Q?DJO+hRiVIDeaMCxE/pAiiKwWAGpHwqwMWme0VI7bvQTNj1AyesP/YBAO4rVN?=
 =?us-ascii?Q?9lC1GpT/jqN9WcJUGeUChYYuLc7slOkFeePsS/og/lEpGno5ObF6Odoibg7H?=
 =?us-ascii?Q?xZJj34VW/gAy+4dUz7ZaLs1RU3f9bspo09uPkF54tEsdABuRdEiGbCFDyc1c?=
 =?us-ascii?Q?r9YhdfJOriYD7wJR8noyPG7ToxBzoC2xn75FhcjHYSn9IoWvDxMp6Mcqckz5?=
 =?us-ascii?Q?NZ7tOJzMXzJS7nr3mDySnS1YE/U98GnbPT542DFV+/nUNN/DRD91Va95nH6i?=
 =?us-ascii?Q?q88bdUWLbYQWQYPlONw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa71d695-cb89-4a04-bf8b-08ddf44bee4c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 11:35:11.5997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0RhxyrGCOpxcII5kzVXfesv6HQmWl6yeZBMg69H8kwqtMeHeFf29J34qANrGfJJI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6872

On Fri, Sep 12, 2025 at 08:17:23AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Saturday, September 6, 2025 2:44 AM
> > 
> > On Fri, Sep 05, 2025 at 01:51:01PM +0800, Lu Baolu wrote:
> > 
> > > +	list_for_each_entry_safe(pt, next, &page_list, pt_list) {
> > > +		list_del(&pt->pt_list);
> > 
> > The list_del isn't necessary, it doesn't zero the list, just _safe
> > iteration is fine.
> > 
> 
> if no list_del why need to keep the _safe iteration? 

__pagetable_free() can change the memory holding pt->pt-list, it is
like kfree. So _safe is needed to allow that.

_safe is not just about deletion, anything that could change the list
element must use a safe iteration.

Jason

