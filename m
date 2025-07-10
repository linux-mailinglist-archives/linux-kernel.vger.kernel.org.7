Return-Path: <linux-kernel+bounces-726646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E9FB00FC6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEB061CA4762
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0439323B627;
	Thu, 10 Jul 2025 23:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G3UX+MoG"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABAF1FF1C4
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 23:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752190561; cv=fail; b=J6V6Op+WVxMYAX7LRVbokxsHJ11zn3Yrr71Q6Ij0m5VPkNDDjhn3ZroeACoB433zqy779p2AwowbThdKo1nu3bW+7eML52ZP5EAvWcIb6GK1ROTI9SWB6APlAVcjRogexIwKTc4erwbucQtAyyhNMGxTBIno7paiTT61jqjCz5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752190561; c=relaxed/simple;
	bh=yToqxxx5wA/zqYRmA3RJwXaCqihVhaLMcOnyFg+8nX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R0KfIY0ebtkCoNr/c/s1COhMXxixyGCiLxqcNND05Slu1gfINuIQ1tI/UWTf0CbG2gFeZNReK9Z4uUkqSear3mZpWz8gKzmK7g9Lj84uz5issHI2xdXgfePlr3gGujbTVFXYlgvvOSf9SzqSSDYUR0qhm0UmJNTeDU3hEnjaoAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G3UX+MoG; arc=fail smtp.client-ip=40.107.100.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yK57MbH5ySi072QOTaAtO/SF+Usuz0ZY1NZft0pwWlfqBFWIAmZlmF4bLMP5WzJHB5mo/sHQSqi6qkb1Jfm/hD15273GGKGAvhy+U7+iotQYdWt5hCy8SXZ54Ckgr6G7sFMPQAQVsFnHkJDHM2SYyOLntkWBdwuK0Enxx6aynpu+3rnxeqcNqHW8PHB3SInrMf8UHw8nOD0KljvZGTdeO+JUEgU8y/hV2RIqrzUadFZGINIwdyUms3wX7gynsTjQlHj2UNxZDJHG8B5HEL2813Eah7+3KBQatT251FhmWwYVgghBA4M0/xwXupl6bMY+LOp9uzUmsoG0zXI1FP+HUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDDsNPE9+iVqRINBmztKZzAT13hBw4XQ1G9oG5UPD7Q=;
 b=MqTgsROZeIpVyKYeG5IfFtbBRycilzxfo3oq+GqIO8h2GiNCg+B2ph3GMMXymexndk5mVypBwpc0BP/NbCj6mQiT9HYkvUSDYKN/U5A4J/55t7kRxVr+/KTtPudInwQKbL0iT+vQ/uTergpPWlSwtcZoU8oHpE+M4H7KldOvUA9seI4ljLN/TBfPZ4caXoc7oXdKxB69aL7Ywa9vubHN4fzJqQY2gAZH5E1oZLuZh6jGJzaDKxcvzzBk8ikPD+nOlbC8Q4sdYta8W1u22SBrxhNv1bFOxDU+D6Lm/9ld9wVZR4uKVoSjdwV4NdDz2l/P69ajHkCYeE3jZlNxGh2rew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDDsNPE9+iVqRINBmztKZzAT13hBw4XQ1G9oG5UPD7Q=;
 b=G3UX+MoGyLbm3itR2r/aFyrBY7QQFk5xAGojNAoCN9bWpkxAClIFXz4NhVPXzs3g1sVzlekhPZvtX40yPrWv8RIL3qLlzB/j7tP+pMilfFLk3oGYcWJkwlGgkSWMYHQsGGmEYmUJ5oECaGQtFc3PWtqpIaEKiDv8q2O/UVIZpR5YqztvtyDaiDQOZRtO42l9nikeaIaN0HELBB4T0HLpUcirPGZL9Xw/7CO4QzDBtRUXSEg6G+jj9qVPpsqz1oeHjto+gjhNhNk3smJ+//hOV47GSmit7tfTwFI3zQBv4NC0vA0M7lbdTdeh1bDNZzwhnO073OMiu72wjrTjt6syOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 PH7PR12MB6718.namprd12.prod.outlook.com (2603:10b6:510:1b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 23:35:56 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.8901.023; Thu, 10 Jul 2025
 23:35:55 +0000
Date: Fri, 11 Jul 2025 09:35:49 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Leon Romanovsky <leon@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v2 1/1] mm/hmm: Move pmd_to_hmm_pfn_flags() to the
 respective #ifdeffery
Message-ID: <wcaeymjmxwdm6gwlpwyklgq4hqzj4bheml3pe7ri7mc7jbjf7n@yjtixgld2ojm>
References: <20250710082403.664093-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710082403.664093-1-andriy.shevchenko@linux.intel.com>
X-ClientProxiedBy: CH0PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:610:76::29) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|PH7PR12MB6718:EE_
X-MS-Office365-Filtering-Correlation-Id: bf889b6a-e793-4b9b-5a5b-08ddc00a8401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L/PV7SrfRlUP9xYFEaSzVQqKNxRNnOLruQsg7iTrZtLOCFRLVeHxE0Df/qnb?=
 =?us-ascii?Q?itWZsyHt1dTBXNn9g7OWG0C8W5SJpwfAv24HNcJOq9E1zlbjE3s72nQ7XLia?=
 =?us-ascii?Q?t0mly/faq95LoKS5Kb+O5xEmP9RD0WGSIWSbhfZkI+IUUqvBhly1JlEbo0sS?=
 =?us-ascii?Q?IHD+8gL59hgP0G7gzfkRymCShZwWQ0URmtMXJlaFugAk2UIIPMgf+8HOi9ps?=
 =?us-ascii?Q?kHTh/YC3hMmTHxGCgzv7HDgJzNL3CR6EX+CGODMyIx6N71jZyY4YNU0q623K?=
 =?us-ascii?Q?TTAfzmugD2NtSOG/hwgRf6GQ7Q0qmKT2wFjifMGnEcMD4VnTrHJB9zmtpRgj?=
 =?us-ascii?Q?gbh9GEMmb8GCv7CkeqTJS+zlSAN18OjQCgLymVG83mhhPTQ6rbjjgoxV1fgf?=
 =?us-ascii?Q?YnJyOLpuPsSnG4FhEp20/JuD8jn74lrDK0VNVrJdJek9oxmDaxsWme1DH7qB?=
 =?us-ascii?Q?fxnXD8wWPt1sdFKYzc8boh9squtp8pnrjq+WXbk1yBc8cvWTRkxHS/vF0Cni?=
 =?us-ascii?Q?GEoIwWCRjou8k0bLC4l9/Oxae41RRNLnEn4i7AvcPNRSGLtQP32Ws+ZNDeoD?=
 =?us-ascii?Q?nyfEfYKEYiHXW4ErkRSwKCNVRH+reZMVIov7hNj/KXX69kiit2YfdYq0b713?=
 =?us-ascii?Q?lcXrKcSttUoFuFhZpQGc0xZf1PArlELUxa7B4oEwqzNK980WoTwYKAgUk/8H?=
 =?us-ascii?Q?uBqBB82hIm4x426DWoe0a2v1ZXGfft01dh9Y/24mjeHAlAdVZEt983HKP9H4?=
 =?us-ascii?Q?47u3kZxnyAXsJ0mZAev1sYNtuvRas63ypZsFR3tZMwpZRvw5q3kFErJCE+I9?=
 =?us-ascii?Q?uXFg1zt7kOv++Tw4s8bXoy5gG7y7hP1f2fVH4X4FtMDS8p9lVUbuZnvVxO2o?=
 =?us-ascii?Q?GXEd7/TObSlmIr8ZVRMQmX02haY1pS+KHZlq+RFanIyfprHCcXHnrQBSZtEK?=
 =?us-ascii?Q?mw4aT80R46hv5BS+aAeMAFFRnZ0tIvqxnvlKvNywlYondm0zCjz63HHNYHms?=
 =?us-ascii?Q?PvnWY8iG3zwOmXggNKDpg0LpPxZN25XQuJ19yuw0YE7bOvS0zZ8OPUrEvoUi?=
 =?us-ascii?Q?XyjHyI8egPoAT6Q31Q/HAoL9n83l0RZmF518dWh5IoxEFRnBmcX6+JPbO9Md?=
 =?us-ascii?Q?2Hg29UQ9wyGByQDsJW0fc90/sHQZf5p6yEbZt0/mgwWgeiRrX+C6+hoIRtY8?=
 =?us-ascii?Q?DPu9cp1escvgo9lGWD6AZpo+f+TF631gRdqZAUA2s8xu45AeK58YU2/3F/KD?=
 =?us-ascii?Q?yR5dRLK5pESkxAy0J3D8hBjHwDPHouDBgQ6BAnJi630lM0sApmc8UThPr+UE?=
 =?us-ascii?Q?ji30gduaWPar8EsI8k/1Z38Ttg0+6IjurN/lxuABOjWJScIuAFL28Dl26wlI?=
 =?us-ascii?Q?YgxsbXfLOfnoH1PvHEqEQE42l2VydSXmboOaCqcu2MHXRq+AsnqYySPOdaOX?=
 =?us-ascii?Q?m6aSxHMgoZU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o+p2B56W4LWJvRNlNpQ/3QQ+AyxfBM8YGCnkNwCRbbZbWULadceG7bliC9kg?=
 =?us-ascii?Q?hz0FRVKiFIWWyLhXDQvtxVNfwHEjiQEs1FZ5W13t1/wztOOndXugRtEi0/vD?=
 =?us-ascii?Q?tboNLizIpbikxSd3PkPHrRXwne6udvzPTLMuE4JIfIRseRUGL5By5YdDxQB4?=
 =?us-ascii?Q?dFuecSIEYrfTlQsBk0TArEjouQadlr28TucGQHQybQ26Pnv3VAXbeAToVlS0?=
 =?us-ascii?Q?JHIxL5KiZVUfGnCdgmzXitqoeT70xEXWSUsqxzxpwR6L3mCvwT1VLRqz51HM?=
 =?us-ascii?Q?Xr4FjyJfa9s6RbAES9bLbNUL01DLU1a8I7jm1qk0wOJg+0ARLAqjmX+VYeoM?=
 =?us-ascii?Q?s1peYjIxMNzqqIx17Q/XxR4gP1rtWQNGEV+k1akIa5tfbNd7WyCLZ67TArHU?=
 =?us-ascii?Q?Bp6qseqfH+ocTPM4lTCAJOPgwONrncTvB9xjcOLmW7QoUo1N0iJmSHyHhfqy?=
 =?us-ascii?Q?E0q4qFNIBZeYWZfsQVh5DC9J4azsSp+kzE5ikoAjJWsiGe6PaoWgP3TGO/6Q?=
 =?us-ascii?Q?k/43Eh4P7WsiJ2lgK0MndZDco64qieW76BETG7pWH4EC2iSUR71dswWXo7L5?=
 =?us-ascii?Q?G8Ki7ZMhywpY4+pL4T3b4CphcTvat/tPS0aEiEpU+loJpdPaCKBXxPHWn3ot?=
 =?us-ascii?Q?F3CidbxiJCiddsIE5VoDHfegpyxAXbrniejfBSICb/XNxLNjA6S1+tYDfkla?=
 =?us-ascii?Q?MA5mHQQRS61MXuOKHMehw/GngvMG8tx77tlEf6OHETj5zo3bwZrXJCn37dAU?=
 =?us-ascii?Q?0/rNzP4PRDNwNLg4OIyd2fo6qy/IF0jPz0WHuKmYliOBchjoW+/rrzrYjOIk?=
 =?us-ascii?Q?P3MssYwuFV9xOG+flZYSJHhx6j0Qked/b+Gk5bhKCnADiOisMm4TIrnsE6sW?=
 =?us-ascii?Q?qpN4+BTUYKiIk7ZuxaCvPQbxDtqFRiQ3IU9UA4IEzV9P/0GEAmJdt7EV8+aU?=
 =?us-ascii?Q?+NkCRKkVq1tcHEJsWJpXpGEE74itkADjUo/L2fOcws8X/FV+c3J/TrH+UeT8?=
 =?us-ascii?Q?FIrJ2FYsHjzYme4WP6r8SmB5t4kjDCPjgKwOUUSfvgGfHSF2HuYyVEnZrdrH?=
 =?us-ascii?Q?jXCrrs2+rSNTiu0B8MvN0uNQGzAueYFLoDdlQMWXefcCtFgsCO5/7Z77T0jF?=
 =?us-ascii?Q?fJugQuMKnNtkRB8p/ZliRSnhSA5s50mgWVVmxIA9OD1M0bYJHVpaRWnjnJBo?=
 =?us-ascii?Q?NGakilVwMd8EfJ4Jd1SMx7exrqlktx+gffcVdIzqfrWDulnDZQJ+f1q8bK6f?=
 =?us-ascii?Q?YGqt/jdE5c810kWWiJOp17BwQ50hpKpUBl09ZxvyoYla5sUqVI3Z05ptptIY?=
 =?us-ascii?Q?IME2VRJp8VCjid1YpUte6pWkG8JKecK95UtKQ9luvNtGrNsh9ClaHyL8zY+y?=
 =?us-ascii?Q?OP1y6Bdg86CRv1pHnSXJI+HKXbuDDWuO7+9e02u5xk4X3mi/ULGVmEbw43zt?=
 =?us-ascii?Q?0Uczcjq+rWkA8ob4bhEpfH+tO2bdXTMbJqBeOpDfzWn9hTcGUG2BHKzHlDWR?=
 =?us-ascii?Q?/LR2P20ggSzFRrusqWxT1RSsyYLBIrK47YNpnomebqaJTYBGaCd6sbDUQodH?=
 =?us-ascii?Q?ayJEl4tVaXOuEdoYc31YNRO1leORX4dHqR7jSFRv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf889b6a-e793-4b9b-5a5b-08ddc00a8401
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 23:35:55.7493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5PaqO9S7GV0UAh2dPh3B9OYpF72sbKKcBbJMhrPEvh2lcKJkmf33UfsX9FFVuZDylKEjgFv9ODd/SCcnmhwTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6718

Shouldn't the Fixes tag be for the commit that introduced the #ifdeffery in the
first place? Ie: 992de9a8b751 ("mm/hmm: allow to mirror vma of a file on a DAX
backed filesystem")

As far as I can tell that is what would have introduced the warning. Other than
that it looks good though so feel free to add:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

On Thu, Jul 10, 2025 at 11:23:53AM +0300, Andy Shevchenko wrote:
> When pmd_to_hmm_pfn_flags() is unused, it prevents kernel builds with clang,
> `make W=1` and CONFIG_TRANSPARENT_HUGEPAGE=n:
> 
>   mm/hmm.c:186:29: warning: unused function 'pmd_to_hmm_pfn_flags' [-Wunused-function]
> 
> Fix this by moving the function to the respective existing ifdeffery
> for its the only user.
> 
> See also:
> 
>   6863f5643dd7 ("kbuild: allow Clang to find unused static inline functions for W=1 build")
> 
> Fixes: 9d3973d60f0a ("mm/hmm: cleanup the hmm_vma_handle_pmd stub")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> v2: fixed Subject prefix
> 
>  mm/hmm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/hmm.c b/mm/hmm.c
> index e8b26aa838b9..015ab243f081 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -183,6 +183,7 @@ static inline unsigned long hmm_pfn_flags_order(unsigned long order)
>  	return order << HMM_PFN_ORDER_SHIFT;
>  }
>  
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  static inline unsigned long pmd_to_hmm_pfn_flags(struct hmm_range *range,
>  						 pmd_t pmd)
>  {
> @@ -193,7 +194,6 @@ static inline unsigned long pmd_to_hmm_pfn_flags(struct hmm_range *range,
>  	       hmm_pfn_flags_order(PMD_SHIFT - PAGE_SHIFT);
>  }
>  
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  static int hmm_vma_handle_pmd(struct mm_walk *walk, unsigned long addr,
>  			      unsigned long end, unsigned long hmm_pfns[],
>  			      pmd_t pmd)
> -- 
> 2.47.2
> 
> 

