Return-Path: <linux-kernel+bounces-770303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B4EB27986
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FDFEAA64DA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 06:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BF02C325D;
	Fri, 15 Aug 2025 06:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zX3ySNwv"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181CE2C21F6
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 06:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755241191; cv=fail; b=ThMXxJg80aBTmhB/jI3ERKGf+G/OZFdrLQgvI0Rw8GmYcJugjvCJx+efWViF7F6HJ1AFsT5HlWGyvBPg1MElSYYUO565GceJEo2i4Q5jhbgzi5j/Zo8Q7qALY2b9ofDeTWHwizJqdwMIzOVRrbq+bP8EIV8pzhNvvjgQ1fsxi+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755241191; c=relaxed/simple;
	bh=U8EI3AJNLR/h/DFr2qcJgYrfki0hf1NEZklT8reOxWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NCaN/UosDw+tzNYgBqwJjgncHnp1BZNw2ah9VMwXjgBZuL64lypZY2nlX3lz14kOOHHojEnJw613lzqnXKv/moFiYmRL94ss3CrnRKfOpSypT0FIILCmekf7ZEYJIJflpT3VQKs0gJb+dMGLPTbmG6W+WvO3+CN7bPLbL5lp+ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zX3ySNwv; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZgdRI/SvL9fzVhMgv0h80VrB09dfrQ1Pq9gwGpzjmo0gwFVow8XW1e8Q6jv8nZl2SNSyMGNUkPuyfbSgMvjSX9pcoG+Xb1mcti8CJVHe/KIwDFVYMokZ0ES9BCHzuf2uNET3D18d8czLG4hedvLkClTAMuH0mEx8Z1NsMr01dOQmpoz97BYeftRQJJahfTriQUj/x/NkHln4otxtfeQuDGCboWZwNGy1nmCSC7Osz7eDDjpUuOK+Ie4QPk7dlTC8H6IHo9+W9BJXC5KAd5Enorc8wiw4d3Ld8tXlyaHquaLa+NEIMsDZwDRBJmT9iWvrO+nzVVRJAN0bNQ/WKnzvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJr9rWdSphk2poClSsweUaIWitXjil2KEzsxPiy1y+g=;
 b=nIWZaDk9/F5O6uddJdZNsH81H9YwMQ1rzuGCh0Zno4Vj/iT7e25RL7UuTm7yHdS0Y1Lkqf7WrM0ZHahYnbwSPN+pppfFnxrzdElQNfJG90s9hBxrYf6RmYHrL9qnTI5y5TZKTu9z9bV/C/0McTLzfzMboMocNdzS6OP1guXKi5rya5opE1W32nJTBjnKY3qfbev+RdYOLeOi5xJ3j+RPWY/PUaJYyqwUPmcfSDIequH+0l7SXdeWIXecixeplEObowh9mPi/+OpL8TGFYAxqlo81t9EmXTpkPg2ix2s2DMNrrk06WYybhby24rcu16Ux/Q5yBKEHmUGZuxnGzLt2xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJr9rWdSphk2poClSsweUaIWitXjil2KEzsxPiy1y+g=;
 b=zX3ySNwv3b8alCXId2w/6No2XFG4Bca+75k5OjrYYRpQudwanUqjJUeIJvicz8GsAhcqbHK0Hf/IxS4Q8kWkg1xnxMa8gcD8o7SF5yjLSEOG9oQHBos7FaNreWlzfZ5uw5/RE4/jIVsE3kO17AO/m3kSUzuw2DnxTLFt4TGbwYo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3342.namprd12.prod.outlook.com (2603:10b6:208:c3::32)
 by LV8PR12MB9229.namprd12.prod.outlook.com (2603:10b6:408:191::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Fri, 15 Aug
 2025 06:59:45 +0000
Received: from MN2PR12MB3342.namprd12.prod.outlook.com
 ([fe80::6582:fb84:3b07:83b7]) by MN2PR12MB3342.namprd12.prod.outlook.com
 ([fe80::6582:fb84:3b07:83b7%4]) with mapi id 15.20.9009.017; Fri, 15 Aug 2025
 06:59:45 +0000
Date: Fri, 15 Aug 2025 08:59:23 +0200
From: Joerg Roedel <joerg.roedel@amd.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH] x86/sev: Ensure SVSM reserved fields are initialized to
 zero
Message-ID: <aJ7ay61K3QYp3Tjs@amd.com>
References: <7cde412f8b057ea13a646fb166b1ca023f6a5031.1755098819.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cde412f8b057ea13a646fb166b1ca023f6a5031.1755098819.git.thomas.lendacky@amd.com>
X-ClientProxiedBy: FR0P281CA0235.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::20) To MN2PR12MB3342.namprd12.prod.outlook.com
 (2603:10b6:208:c3::32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3342:EE_|LV8PR12MB9229:EE_
X-MS-Office365-Filtering-Correlation-Id: cd498a53-dc88-4991-d814-08dddbc950b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aJ3KY6rsZhrh6YzrHFWA81+hJVgAD4LYUe6F605IfMiP1lHcXHGI3YdEXu9s?=
 =?us-ascii?Q?ksdLAbTtlY0iPA/Q1dAQ9vpR9aPgoGqhKT1mw+MoHIgRJ52G7eWA+oMZfJep?=
 =?us-ascii?Q?TAPeflIhYEi7VYvCOxyY0MY38hEmGUdPlD3xuj6E2sKaV5qC8MNrjBgux0lc?=
 =?us-ascii?Q?C1m8vx9sUURJzU71lXC9l1LXCCJWlYQJzQkgW5qFwdIfZBnWaM2EL5WteFNH?=
 =?us-ascii?Q?Vac38tj1k628U4e0rnl3071lwgwSyymfB7FeSXVWWAE/HtOwid7deTGe3icR?=
 =?us-ascii?Q?jZpj3RhTDRFZC8hBsn+qxTtiqbpML4Q0fKiCc2ElY1/ilb/5Lb/UHI2odX39?=
 =?us-ascii?Q?+aQKVj0tAiEZv5g0GZuwd01/cuy5+aSGtlmHJV7Yx3z1sYqliA8F+fy1f3S9?=
 =?us-ascii?Q?vZkjLu/n8yT9LcV/sCRzzF1QgqV80WjO3oDzlWt1fiRRjbZg+YBpPqgm0cSt?=
 =?us-ascii?Q?1bzBi9pyCwRlLKLCBxxWeGowfJQJ8e5ScebI/+IjnbJVXq+gT0UnDETYe8JH?=
 =?us-ascii?Q?agegz//+GDg0mvBvYriDTwZVz2WtxAmw9rDKwe6kvXqheyuX86t3qsBVRRj8?=
 =?us-ascii?Q?303Vlk8w34VJGFacAqd4BSPN1TA0vjrQpKDvtru2+huu53he2SbtGRs0cSTL?=
 =?us-ascii?Q?Cf+S3S3Al1aqf7nLNoBY8yMjczPIiuzO9ZFKW8CS0ZDfMnJsu7Pa4BmGCroK?=
 =?us-ascii?Q?blriUKlEdTTFsY8fVPRZD9sgFBACwyFGlCUPEyMyxVrHnanixl9ibs7GOnJs?=
 =?us-ascii?Q?SXRQHlEgoCfWmLqCCDo+00MylvQY2Ksq0FJk8B0OEFO45jGAfhXmj1DTnMYN?=
 =?us-ascii?Q?LV950pQhzKvzSXb0PXA/aXsLXDbgLT5iBdpJQEzAkBHXWXaSpe65yYe+Y7g6?=
 =?us-ascii?Q?YCi1q0yx0OkHD/csWpG5XPGtp3pQnlKw2CYbuPGbtabdqlI4C5kDqnf9xzwH?=
 =?us-ascii?Q?n8y96sNZhSlsavZ69kBp1YFAhKuz12mLUKV5gh8e9LB7g3IrxhmwFFOwnnF4?=
 =?us-ascii?Q?wZBp2u7QsOrp6OjcVZqVq2vqN1bzGfm3Ahc4TZ1Qna2MN01x5mf1ttLXg/8q?=
 =?us-ascii?Q?CcYA2suwy4xkNOfb1OXS1iXS3hp09zHAxNp4ErqTmGwO/ysf4y7PsNbTGhVy?=
 =?us-ascii?Q?OnrB9fsJ736CtC4smfd+bGrZhA7vK8R6bCMkJmvKKwXc14kH14AVr93DMfb2?=
 =?us-ascii?Q?va0CPZRbJolYp0abwVNmJYINPXaQyOsObi2uVi2stVbLeohC9Hp12gUc+kmo?=
 =?us-ascii?Q?aaqgK2+F2dqpWAUPK3coDmxplhBj6e9ewX9Jji32BqrBEZqWCSHWqlKfdbe1?=
 =?us-ascii?Q?sV+2rjfrgTSOXq7PVcLf/o0R+UzXQF63a4c1BGDA7Pqrq8a/vhZhiNcT+0Uc?=
 =?us-ascii?Q?F4PXgnGmQhhJFhXboKK4I75r/PkoBf12Arme99Ty76eF04qdI3dgD5kDV5RE?=
 =?us-ascii?Q?/HXQ8dW0CWI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3342.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sDy+e5SbNZ9sj+vhOBI3mcl5nlI2wcwaoAFeunSqU1lueCwZo8nGtIs0OiHM?=
 =?us-ascii?Q?Rip+6TGRAeVasKhJSR+PBOqxqX1BgEmrWgdw04Rsi+TjK1q9hyR7noMSOpYA?=
 =?us-ascii?Q?8Xs34yeZrWmlDJ63JH/DLpLUbfQ4qD/UONwTANj8WYOxZlL8/bHSZYPZ46pO?=
 =?us-ascii?Q?+Jdh4SquXHDbWQao/9K06jN7Nd8B6dnEmq0QtiB5U85DBhx1KC3eO9tbHlaT?=
 =?us-ascii?Q?vCRevFGmfHBNPnZebwpH8TyCK2OskQpcZAaciL0gQ88GsGSW1BTwTyuW1TSR?=
 =?us-ascii?Q?TJiJX0UB8V9KwkYMOqbpDlBKe/p6rpQ0OBN49AB2uWi994QRVJD0D3shWS57?=
 =?us-ascii?Q?wDDWS97XvZFb7et5CJlZt91wWXYBbFi6ipFcsMT/5ZHLQLZDTR5YYz2to2eU?=
 =?us-ascii?Q?+DjER3PnoiJpO93IyRKK9cgbWjYjEV2B66WPdk6iSlOsy9Q4mCIPaykNYGuN?=
 =?us-ascii?Q?X4gaD+EqQNY7Pb94sLN5t2Lr9PezWombtLm2Q6zDrSb2/wzzoVU/nDNxlLK0?=
 =?us-ascii?Q?YWYm8uYDoxb5PoBQBo+jdmhbbuy5gEY3LFKaEJDuQrEjcE4KK/izC1RqnVBS?=
 =?us-ascii?Q?1Tab3aKUzHlqwE8jPID8oYqTShFdlaf0UI1NxUbxLZq9TD6XnvNZ4NupfUiG?=
 =?us-ascii?Q?wWMGiZsEZeoAJZVeupfLO7Lthl8TBToNeR6L4MF7raU9oja0fJh5+GHCHwYw?=
 =?us-ascii?Q?28o469WVWFnVPa1Kz6ZIuEsNSutAWc0gM1+IUU1bwDZhL292x/pcG7uWowQ0?=
 =?us-ascii?Q?ChB6dyW4DeNJ2mV+V/nIpSdBjdCAlTGuAHPp/Eqbwu/MZEjH+HQywn25bhki?=
 =?us-ascii?Q?ks5wh1hCxBUauT/KFRjuuq9+ozAkw7G36e45FSJSoCe/e/vDjoAeH57aoIgd?=
 =?us-ascii?Q?haEmopzyLc0yh9f4k3k3eQXI5+l5+dGG4giIhGMMktXfAa+/vFkCqtKF3Ep9?=
 =?us-ascii?Q?C2sDD96H6DtNwMJUhHCZUch8zHbzSSzfk5tQJKNeScKUSXBl2GJj8cDn4idX?=
 =?us-ascii?Q?HESTalrs+6gVBt7HILl9wpVHSKhgaMYOEnIK6iW4N9XllmF+6bZMZBmM9Aya?=
 =?us-ascii?Q?lEJMOifOtS86yV6CrChEqPZc5IDyfm4BFeAXK6ucpmJeIBYEd/jCbAejop5n?=
 =?us-ascii?Q?XLuKZGByrCTcjQmG6QpBO6wciKvi4MRlNejkzGW/tsBy+/FVaR1miPr/QEeL?=
 =?us-ascii?Q?KcRD5lQ97jSsPVWO/xMSp/QwSo3Z5nHFK3TvaqsfDleKQ83BLEDaP2Cjpbyc?=
 =?us-ascii?Q?awDTxrtxBgkLG+AlGS1zl8ExWirsYqDmtrvTCs9osF0TIVSRVISXak2l7sJ/?=
 =?us-ascii?Q?AFYiCAh+JbIxpbJUurN9feJc8nOfrja046TQrhLoCv5hWMkLZd8IWsVcAdxL?=
 =?us-ascii?Q?pfO3RYbhNEmXyFFrc9gSBlq6wLgQeNBdDTNv0CSFGqIdFJeq9TZAQH/1Na70?=
 =?us-ascii?Q?X75YOnMApHgp70hbvahdcozLCafU2V9eC7LQGUQBClsK69frHJsVBMr2eC0L?=
 =?us-ascii?Q?u39oVShQtlyn2TUvJ1VlVh/iJ8Ifu85iXf3bwReMmXi5Tz3JUvkOn5v0COgc?=
 =?us-ascii?Q?IqwKNwGmhPmPRvsqXQEP9/yD8dR8Ee1rIuzO92WE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd498a53-dc88-4991-d814-08dddbc950b9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 06:59:44.9136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ws2tAwH2y0JoTcOD2doEcLpHO5cTpwFAG7PN4nHYwyEZRv3QHCY5A/3t4uNREMa2yX9GFlXNhOZaBza846esNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9229

On Wed, Aug 13, 2025 at 10:26:59AM -0500, Tom Lendacky wrote:
> In order to support future versions of the SVSM_CORE_PVALIDATE call,
> all reserved fields within a PVALIDATE entry must be set to zero as an
> SVSM should be ensuring all reserved fields are zero in order to support
> future usage of reserved areas based on the protocol version.
> 
> Fixes: fcd042e86422 ("x86/sev: Perform PVALIDATE using the SVSM when not at VMPL0")
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>

Reviewed-by: Joerg Roedel <joerg.roedel@amd.com>

> ---
>  arch/x86/boot/startup/sev-shared.c | 1 +
>  arch/x86/coco/sev/core.c           | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
> index ac7dfd21ddd4..a34cd19796f9 100644
> --- a/arch/x86/boot/startup/sev-shared.c
> +++ b/arch/x86/boot/startup/sev-shared.c
> @@ -785,6 +785,7 @@ static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
>  	pc->entry[0].page_size = RMP_PG_SIZE_4K;
>  	pc->entry[0].action    = validate;
>  	pc->entry[0].ignore_cf = 0;
> +	pc->entry[0].rsvd      = 0;
>  	pc->entry[0].pfn       = paddr >> PAGE_SHIFT;
>  
>  	/* Protocol 0, Call ID 1 */
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index 400a6ab75d45..14ef5908fb27 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -227,6 +227,7 @@ static u64 svsm_build_ca_from_pfn_range(u64 pfn, u64 pfn_end, bool action,
>  		pe->page_size = RMP_PG_SIZE_4K;
>  		pe->action    = action;
>  		pe->ignore_cf = 0;
> +		pe->rsvd      = 0;
>  		pe->pfn       = pfn;
>  
>  		pe++;
> @@ -257,6 +258,7 @@ static int svsm_build_ca_from_psc_desc(struct snp_psc_desc *desc, unsigned int d
>  		pe->page_size = e->pagesize ? RMP_PG_SIZE_2M : RMP_PG_SIZE_4K;
>  		pe->action    = e->operation == SNP_PAGE_STATE_PRIVATE;
>  		pe->ignore_cf = 0;
> +		pe->rsvd      = 0;
>  		pe->pfn       = e->gfn;
>  
>  		pe++;
> 
> base-commit: 4c699535a3d483562354432a945a035f15dfceeb
> -- 
> 2.46.2
> 

