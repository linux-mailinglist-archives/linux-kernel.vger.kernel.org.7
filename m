Return-Path: <linux-kernel+bounces-860810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBB8BF0FEC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A429D4E83E0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0842FDC20;
	Mon, 20 Oct 2025 12:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j5mR3DmP"
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012059.outbound.protection.outlook.com [52.101.53.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC99354ADC
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760962264; cv=fail; b=pItW3uMBuj9VIrsQ7pVsU3AxHC6XPtmYn6nwaWwvZVEjeU6E9ThyOZau98Be0hHdB19GJCFa5umQEyY/I7F8lg4IHoSeUXDuHXXeD2RY2TVd31+uZymT7nl0xYHzSbtwjBeDxELBsOLUimNV13syNRt4Gb7sNt5SL0FZ4uF90sQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760962264; c=relaxed/simple;
	bh=BOhn47exf5yNKtulN0iaFuj5ITfGnAKeNC6/vdiqaWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QNHoQVY4QgAmKr/Wwv+whd67RfEhgGnvwePwpaWJ/KH/B6jYzp0dRiaf1JbrHcluLhh7SUjbfV9OOnCuXwCOySmAumfGX/s1TPutnyIgLaMsFDCR64vmnnDq+11nd/IVSksoMPILeacK2uWOyu5LDlvucHsQqf3+a+QR9Mjxmqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j5mR3DmP; arc=fail smtp.client-ip=52.101.53.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSPAkmF1aZCxGBtl9DcONw2tappDbuuWNF4+PsFyKB2P7DKaxO48BGU3NSNVSIrFPO5ttwUjf9L9NVGYvYIGAGCp2lYa39vg6HN0oqfZL8YL/VqSJRXZ2MMnOteL1kesWrYBYIyKKWBlV2+sWWZAyG1IggaEyOl97ISUvd5Og/+oGOxWRsAghaVoWaXFBqsm2nk6EYgPiSE+zcCInc3gSxplWp1Dd47q4wwsTI20+S2cMKtIjPEG83z2eJEWCls66RhtJgTUICNwkYILgEvjeU+0RrBLj1CSUWahxFHXbv/9nqjG9bHKlwb/DVylaZTjmxqGUOC9DQyNAr7a6hRj+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1cZtEChazCSj4pKCsaocaDVs+bZ4WJGN5S26Prhi/s=;
 b=PcVErihx2EMx2AlBVlFIVkcQQzi8BpnJGr74o9/+GeBylPsr9xEaey8uylQauL+GFA8Q65LSiXX9qZWlgfeyOkqoK9criflVrgAEXh69m29UnEgDY85KrGVfTbJCNhCyVTjiTyQXpZxfIJ42KSUWbhgWWX6Vd/qWqbN1zMflxaf0vE31xlaeXz++qqofsazUmNGZqYE8QTPH1hTgY1Llv5TuFJkjzXjvRCJo4hb6Fwv5V2HcEB/dEFKOU4gjuHGBXoeUPCZCaZnQ0x9bO2PK5aDoDJgi5vOFFfj8yQWVJ9ABwoJSWA0lG/PMj5qumTU0JXVsdP5ju6T+cDbyPLaauQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1cZtEChazCSj4pKCsaocaDVs+bZ4WJGN5S26Prhi/s=;
 b=j5mR3DmPtCEoxOfVGz7lf/plPyxHiAqcpPxaD7d8M/mmHxzIJvKSob2kflg848nW/lmp5nXt+u3l+M2MZmrPDIb8ZV5rrqeMimOS4K0D8nMKvSEUe50KB7dGpN/fZoT38oJovK2RbgLypQXXlRzuSVGXafIHPDmcuZTlgX/NVLNws9mHcqBGgRhVWH4jvlwL69DVDINinyZChPP5WzarOuWBkfne7X9CBYuDqbKwWgReTXEImQZObxWxs7DhujUOzVD7vcgFmXIo+G5CAytd5l02C5T+gt1poI7yKeblwjxYW9pLzCuiuGlVf2nYrpYnkcxsgVJGntA5CF2pFAWmSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CYYPR12MB8853.namprd12.prod.outlook.com (2603:10b6:930:cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Mon, 20 Oct
 2025 12:10:58 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 12:10:58 +0000
Date: Mon, 20 Oct 2025 09:10:56 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kernel test robot <lkp@intel.com>, will@kernel.org,
	oe-kbuild-all@lists.linux.dev, jean-philippe@linaro.org,
	robin.murphy@arm.com, joro@8bytes.org, balbirs@nvidia.com,
	miko.lenczewski@arm.com, peterz@infradead.org, kevin.tian@intel.com,
	praan@google.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] iommu/arm-smmu-v3: Introduce a per-domain
 arm_smmu_invs array
Message-ID: <20251020121056.GJ316284@nvidia.com>
References: <345bb7703ebd19992694758b47e371900267fa0e.1760555863.git.nicolinc@nvidia.com>
 <202510172156.WHU485ad-lkp@intel.com>
 <aPKjEvxCJoRhzU7K@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPKjEvxCJoRhzU7K@Asurada-Nvidia>
X-ClientProxiedBy: BN0PR04CA0057.namprd04.prod.outlook.com
 (2603:10b6:408:e8::32) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CYYPR12MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ab6e197-c12e-47d4-4468-08de0fd1ba50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cKKvWf0o8vsQEKgtjRs5uxTUvdcuPnUb0t4KMXDSvesrIBe813mkWxuTiPBM?=
 =?us-ascii?Q?fIt0yWR+Qp3Kop6rA+WlaWq3cuq4jR2i/DwRTmAWCr0hwrt3xJBgoJtLIljH?=
 =?us-ascii?Q?+dPKDLMpldBAw9IRBj0xxc5OQZ2jbZfnywl8wWgSOipU+08r3VY/snuxmqKt?=
 =?us-ascii?Q?yWXv+1NpNhK4uJX8wEJ/khQ5AJyKCpPAbZ6CBNdTDjKrVy/h/sYRV6JrtiMl?=
 =?us-ascii?Q?KZnVH7ZChYFZuCsQZIFcjOT9knhWh1w+qaFhqJqWgiCI4uEbBIEqL2ZnOiH5?=
 =?us-ascii?Q?K0e86qowd6VD+Pf5tqKXDyQ3BO/4ZsvUqSegi1TeghHfHozvgGtvPlLkn3Ry?=
 =?us-ascii?Q?TJrIBDW7v7keZ4UCdU6FndomrJ7EQytx04qHvo1gjZks1/fd8ZA+aJRapOlh?=
 =?us-ascii?Q?ri5y5ADKaQd0c5ASHdROKeKjCeBmyW7AeJyjcENV4iylHZdXgcE4qGGBXETG?=
 =?us-ascii?Q?iY1gkXCyIoPIcD7uPFdJRXsMa9F1+0p68TWX3gGWX+ZR5IrOGcoguB+iQu/9?=
 =?us-ascii?Q?TTgQxCQZJFtcHfqBGgUPeKH5G3mzxlUV/0tZnIdmaX26qZ3Jk7bgh/WDOGC7?=
 =?us-ascii?Q?j840mf5mnSWSws9/5PE/N1jhrrbV+qqgWmi5n1KPxB9yjgp8e0QQyspJBrA8?=
 =?us-ascii?Q?4CGkjlbtZSJPxtmue1H7Vi4RBx5hANsYi13aIcuo4rxguZaAea2OsP2VKy28?=
 =?us-ascii?Q?3BZZEm9yx7rFZSOs2O636ZQk8L6AuHsRBCciXRbMEKyioWlJDM1AElbYP2id?=
 =?us-ascii?Q?dpENExGr8nfzYqVSgfsrl6gS+wZamCsDg1+7lyyvvzOG7fAjD92oMrx6erbA?=
 =?us-ascii?Q?jOhwfwZhlYy+kV6CnVD9xFbzuj8XNvRn8xtqvnJgYQwlJhIaHmPsAqFUDbVQ?=
 =?us-ascii?Q?ZXWEZC+taBJ4NqExleOSUyIi/4TLgaTmErDSWupv7Hx71OaAfazvKygTLQ6b?=
 =?us-ascii?Q?SdmvQ5qhcuHX35Z/9tzIlg/yRZITcxcwAyeAG/Q5tjZVxu9qYc0KS3kjEYZs?=
 =?us-ascii?Q?aYQ8fK7JHFZNUDFfdIml8rkUQFjy1rusc3n6NM4LmROa2uL2UsNtpNXd/l1M?=
 =?us-ascii?Q?EbBhnqC5u7SGkZvnikkE5QRzoPwb+m0AYXCcmBOC0UJbcAqLg+n6y7YAzeW4?=
 =?us-ascii?Q?Inw5BRs6GTK+8rr+0fw7hztJD64F0U7KMgbv6E7Bw8xO5b3YfVVTOW2uTPfC?=
 =?us-ascii?Q?4zMgpgNJH273qfpzxXWZJyyqHnd1hHVBeaKGlRMEQTABzWBLVRHGuuGQcFpq?=
 =?us-ascii?Q?YUOHqgatW0vSYlhK6jENKU5kpOXwg5vXKahjCI+frgAgS5EDGodJsbP1rwV6?=
 =?us-ascii?Q?HGa6oyVi+Cv6+bHEhFIgS0uTHLAsxjaHEt7bEZYU5cxlKAlOxG6ineM2YJun?=
 =?us-ascii?Q?F7NKEyzeZwZrG6JKvfYMDeiDtx+6Frmeai8gtCGNEz2FXrymKTN0Kjhaei0D?=
 =?us-ascii?Q?ZcfIFHmDporB7m+py7lVp1j5jiGz6aEf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0N6XQxp/eMaveakfyRrHHLmdeOymKu2wFMq8rb1k1hOLdxEoB6f4n2K8AmwB?=
 =?us-ascii?Q?kPgEl8ltbv4bgd1lyZVNzjHWMCnsZAa0pWyAuS4+HsMBP3mgBCKMnlQMmif/?=
 =?us-ascii?Q?RmXpncjxS9cm5++x8iCZv4Y6xqTRhUg3uGY8/4HvTPlEMFmZKlZ2bzEiRnPt?=
 =?us-ascii?Q?Zk0OK2yStUkENsjw4twDuwTA8hafnDIWFzVXQZqNkNiYMvtZGIEL7vzId9h5?=
 =?us-ascii?Q?e8JGMhVfqkKUgJVCzLKEhNXs5qTV2CPmdeA3biR7L5EKtuUwZvXI+p/voZMJ?=
 =?us-ascii?Q?aOfJxExYtNDWWv6asSYVHqbQ49HxaNO1kkA7GLCFnKIiVEgW92m/qzWxdCC7?=
 =?us-ascii?Q?l3Q2YbampndudYTwjkU0ORY0OhpbsNSr5dlrR7li9y91g8o1VivolgPQ6FKy?=
 =?us-ascii?Q?DNMvlT8hH4YtQ2vC/ujvya47t1zxHz8jXDNZSClvDdKlg8540N+CHIxlhYrk?=
 =?us-ascii?Q?4doaAZLYBNgDZtAmraGvYtxUlPCMwk95LXUUTu7lxoYCkS/PrK1U7NJBZqUr?=
 =?us-ascii?Q?6G+cdLIYDnPzyvLTYTzqdIqJAs+ghDle4RAnhz/LnjFjEgZb51ZsCrRqHde2?=
 =?us-ascii?Q?NFkcI0N7DrV11uDO+kCncIAqhTB3ehToiKPBiND6h2svVPxkH3/FEl9vqdgc?=
 =?us-ascii?Q?NNmDqtuLnT6gXclB2csrPbgo/byYkglJQO/wwdnn4t9jQbR0wAjN9Z+jTe2Z?=
 =?us-ascii?Q?nOnsppdUXbm3KMcgjerfB72KVXRmp79EIBhC1g4eXsWYRPS3Knma1vWvmQTJ?=
 =?us-ascii?Q?Hgi1ePm7+JmHjJnGdfYCLrIEnTOBvTKZzw/IRWYLf3+6ZQdi4vmwKmIDMPUu?=
 =?us-ascii?Q?rj2ZaKrJM+bvqe/PdUj22x77VeCbZh7irufM+Go6eFranDb9LHrCXLHZg6xC?=
 =?us-ascii?Q?py40x/eaouHsaaPdIHyjHE6WBfrAtAHCXQu9Duk3ShLoT9rEXVi7gzjqSk97?=
 =?us-ascii?Q?X/HR8Vu7TCj7QQgT0EjVBdj7l3s+T08AGXFBz6C2B32BrHprfXhwcosO0a1g?=
 =?us-ascii?Q?fCO1HPkcS6BHJinTecCA5zopLRXG7izM3Ff3PaogyoJf8pf0DFjEprd21Bsl?=
 =?us-ascii?Q?eXkydi+cCX6EojKkyen5DM1TffLOAXEPQ0XgUpuu2m4cZ5H5ZCpVkoTLFhTK?=
 =?us-ascii?Q?ADm4UbcjJFS69i/+dLqPaXM1U4HNTozT1s7s0cJtRcLJP0Yc9YlsVsEMfoIs?=
 =?us-ascii?Q?2kmKARxxn+v1s8UCULEeNFMpDJPsmoNikdbYyfkLCsP2i8xLbZVoT5DfFMTt?=
 =?us-ascii?Q?O0De9LBXXh/tJ8xeieO822+7NFNeT4JIQcwHPB6FMnjj0yCt/ePPSvQINOLa?=
 =?us-ascii?Q?ZtH81nm84mN0lFVhzCge5+b+ZlmmWdrR9Nng34/xx8QtT49bnsVJB8jjadtB?=
 =?us-ascii?Q?BHV982rNeQKHKtQFF8azJ1WEx5NlZ6QolFkEV4OJ352KK6NeYl2Kriv+mZu3?=
 =?us-ascii?Q?B2eP3ZzHRVJ7SUxTWiq8Q5L1K2iiu9lHgKmxX1fHObp9jP+EAjlvqfOI266h?=
 =?us-ascii?Q?ficLfxXBimH1jRpwpvuRuzLhN7V6x728SUIPtoKMZTsh8Kt4UBcWu25oeb5q?=
 =?us-ascii?Q?mdmlcqBIWlvZBdfGfxwB/2x1+HfoRyD4ItPEjawx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab6e197-c12e-47d4-4468-08de0fd1ba50
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 12:10:58.3317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oqvvgvr4Msx1WPRRNOWtzu8+nI8bTLWD7yu2YIOtlMCWxabkIk5axQC/ejQNv+A/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8853

On Fri, Oct 17, 2025 at 01:12:02PM -0700, Nicolin Chen wrote:
> On Fri, Oct 17, 2025 at 09:47:07PM +0800, kernel test robot wrote:
> >    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c: note: in included file:
> > >> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h:1048:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct callback_head *head @@     got struct callback_head [noderef] __rcu * @@
> >    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h:1048:9: sparse:     expected struct callback_head *head
> >    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h:1048:9: sparse:     got struct callback_head [noderef] __rcu *
> > >> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h:1048:9: sparse: sparse: cast removes address space '__rcu' of expression
> ...
> >   1045	
> >   1046	static inline void arm_smmu_domain_free(struct arm_smmu_domain *smmu_domain)
> >   1047	{
> > > 1048		kfree_rcu(smmu_domain->invs, rcu);
> 
> Looks like it should be:
>  static inline void arm_smmu_domain_free(struct arm_smmu_domain *smmu_domain)
>  {
> -       kfree_rcu(smmu_domain->invs, rcu);
> +       struct arm_smmu_invs *invs = rcu_dereference(smmu_domain->invs);

rcu_derference_protected(,true) since we know there is no concurrency
here..

Jason

