Return-Path: <linux-kernel+bounces-873967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B23CFC1530C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A6F188F56F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFC732D0F0;
	Tue, 28 Oct 2025 14:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S8B9wxUY"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011027.outbound.protection.outlook.com [40.93.194.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F028622A4E8
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761662203; cv=fail; b=ZYyJpa7wHJW0WoOQkZjydpxfJ4DkGClgDD5NI4Uv/eIL8SCSCwhimaW5twp6wu+mwTErh8CCAkOdYrcc8gm5GfgRGnhq3GhuP3w3QczY5jyRpsXwW3oPboqhYBP9UnqC8ezGf+JMUa19BfBljvxsRaRbMgxcSOS0JrUH8JlTDUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761662203; c=relaxed/simple;
	bh=xaeQI9OEScDU812X0KpKD8pYBZ1CxCVhSh95s2Lqvl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UTFTaklnUM9oMu2oIf7R90v/WGxGQoVcZDdnRQ7mbCo3kDdtXFn8nFIjFRTtA2HxtIYR9jhQObUhxCx7bsn3x/F3URZIA9re/ajwJgB5pPP9wtR2nDVwzDEn4uU+PowUq8K1SNIK84fYRvnkQw5jVjjBhuJFrz62WZbFO/+LdnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S8B9wxUY; arc=fail smtp.client-ip=40.93.194.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMv3QwSARinp6Ma1teulTdZRpLv0vnyH41w8jJovOl/8EkXZlGNMFf4bSpO5qSaMyB+hfCzI+HNLDUvWtgJHbvmfKzWJqjkbdhUm1Xut8LAOaCviV2KDW/PevbL95QwxoZHS/w4C62gdRImTa1dLYDPWm3juHzuw1IQfsPIWzpCpUvmsoP4c7Vf0DNAk5vbTiWJGUC4GbDLYQ+j9bLCs+IGrNiOnL2h2GIKZ3yFskWgdlJAYx+efBK+zOsYUDFiHajZPbZ8vVJR9WCX0duidOny7XBd9wP+0A2TAjQPu94mv+rDfE1738gRxo66qJTjD1paHIYpQWfSjDdZfn+UTuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IP83VSWuBvm7r/Ir9bOCEcvScXbh66a6RRdfadz7UyQ=;
 b=bD1nL6RrjuJD4mt7wUw8cHQ7UorGCyoDvR+O6VUIcagq2hAhf1aTuXwrd1mMvHWUvTfyyOU6CmMSA9Q7/kTRsN7nMZCkGlxqhpsMLQvEFgpInKo9vqluC2ku+mj5l62J4+Ndg+QqprKlP6jE3Ji+ejRfnft4kJwFSHa+6ZdjAX/Odp+AGnD3ABgPjhK/ghGjML6uYwzNqEbtl9IXAf1TIqvUJHOtJ7OZcTNxpasLT2J6nOiPo0Cswri96lFz05AavMgyO9bU7bG2wAKnkVoLQ/RfYUjpfGWhTZHKFKv+5jnpeThjz6Q79v9lo4jtGQZ6AuH4kn5c5/IGzB2vNkmmlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IP83VSWuBvm7r/Ir9bOCEcvScXbh66a6RRdfadz7UyQ=;
 b=S8B9wxUYXWDg+vIkz75wPZFQkLTnXNlQfYf/oFYNKNmG0BZmw3+WzFpeTOFgk725iZMzKjToFBYsaCNbkRuIvYJ8g1kna0b++6HIDkmnY0O2zmw7HA0+Fn0hXkFH7J99RNNFx5RV8au71yUtlBHCjlFGDUbHkLR4ujVX5O6LfPE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 BL3PR12MB6403.namprd12.prod.outlook.com (2603:10b6:208:3b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 14:36:36 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 14:36:36 +0000
Date: Tue, 28 Oct 2025 10:36:31 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Michal Pecio <michal.pecio@gmail.com>, x86@kernel.org,
	regressions@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Eric DeVolder <eric.devolder@oracle.com>,
	linux-kernel@vger.kernel.org
Subject: Re: AMD topology broken on various 754/AM2+/AM3/AM3+ systems causes
 NB/EDAC/GART regression since 6.14
Message-ID: <20251028143631.GA468145@yaz-khff2.amd.com>
References: <20251024204658.3da9bf3f.michal.pecio@gmail.com>
 <20251024213204.GA311478@yaz-khff2.amd.com>
 <243b5260-3dca-4575-a8dd-d9e774de311a@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <243b5260-3dca-4575-a8dd-d9e774de311a@amd.com>
X-ClientProxiedBy: BL6PEPF00016413.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:b) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|BL3PR12MB6403:EE_
X-MS-Office365-Filtering-Correlation-Id: 511832ea-7477-44f3-eb86-08de162f65b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XFbr7YKQOF/1yY+Z3wP5Vc2w8yu7llGxLTtMwDwURaSThygCDdijJOgLvSvL?=
 =?us-ascii?Q?RXUIlMf9awX+zxUWXXRnaLFSYWOUIbXrZHUr5JOpLiJxe6cYyTlA4nYM75bJ?=
 =?us-ascii?Q?uhDVMIs0U2rJpxeMqnvVZbeNHY4N7ktRrjtOYCfFc3jrlqCwlvOFy1mYkeww?=
 =?us-ascii?Q?ZyNmOyEVizUvR1pCgHeQinFqC3B4zglbw9iIg2WwKYf5PReRgKyWDWRJDV+n?=
 =?us-ascii?Q?e4Ildm/FfWGr8JntxDtLy9mKNNnHDa7+bN1667dcpiG2FhG2htDi+WAvfbEe?=
 =?us-ascii?Q?iX/688yh+KRsOkV8fUGHjCKpbjsTdY0E9MxfRbX7wnxUj72Kj/89+rxY4vEw?=
 =?us-ascii?Q?FimZGKr6/RchRJ15o2u382jY4KuzoGEGp2zkhNOb3CHfL+WNBud89BgdqH5r?=
 =?us-ascii?Q?924QCZiIHbOgVl3fxRRW6OdMcX3DCidOyoDtW34oOoH7ZWrTqhmikKmbgAtZ?=
 =?us-ascii?Q?etWRJsXGZRR29Vd9rfQk4ohPYQ3O9bG1SFaczSR0u6qc8Jb3HVCHj+e6123D?=
 =?us-ascii?Q?AuEmiGjByqSyg1pzGgIZr1GXuT/i4ZmC9mevMRLLfCGSZhgpuw8L75KNCoIX?=
 =?us-ascii?Q?2kYUhrGOKNJB+oCoAXCwKTHCCJPvQe/N52txFpheZs+7xsCkIE2kjElOu3fw?=
 =?us-ascii?Q?pBELwhKTUhVrc7oenTxbDGZxCcwqWupvmUs/gmyRnL0cuiHj1ZGaN4K0X60i?=
 =?us-ascii?Q?jBRXTK3pFFP8GD0sh84Z8yhYCxpyud+htvvxvq2PGXvi+H7vC363GKzYN//i?=
 =?us-ascii?Q?qmLCTqZZE0coZXOCnVW1WC6ThYdQ7iE9kgxOQ7e9PaOB8v5ZbvDxb/3WBMOT?=
 =?us-ascii?Q?y9CL66swHe0EcqHVlFs+LoaLCNZ41aJwBiQaOHEzGJghfBIOHJ5wlA1kA6ip?=
 =?us-ascii?Q?J4T84ro7km9TJ4PtZ4fOTIGXWAwrHNgEWwThrHT80EBX+k84rdJ+RIuvUfZ3?=
 =?us-ascii?Q?SDt9iWI4yIxYs5fM9XumY95OjxJw4F8oKZnDEp1AmZYf714gJ0LJiD7oRFeU?=
 =?us-ascii?Q?gTb8RDhRP/jl/ecuupKajbKEOIHRFEgDFCHOy0849mUCkRPsT0KM8bjnW01j?=
 =?us-ascii?Q?QfqMPWQUROO/U1mpH+ago0CnwkRSn3HRS11fwK48qVTafzZPD3tK1MDfpYGv?=
 =?us-ascii?Q?qXnpW4c36INSMkO1I8cvhVQoGwe40bqMP3Bh2BstxbLaDcYiJg2nGY/UmU/X?=
 =?us-ascii?Q?pvOYrUrmX00Q1+XJnQwy6xCJUr0CdK4PgGzxAvEcjByywzNHeCMpbpW1/PQ3?=
 =?us-ascii?Q?sIs78n+8bC+glk572RgOrxVQqtoqm8hQRPDmJeQ5ZQpXGtb2pTUY3q7kOWCQ?=
 =?us-ascii?Q?XsOCjX2P5G9ofyNooXbiQJmDq5+hoPzvrnIptXvRv+lobYoDfaDL5l9NgOIT?=
 =?us-ascii?Q?oSxNGKgJwzeDa1KIMOwsrm5uw1z+6Zp+qeZmyOKrt4Q4il/RV9w1s1lZEbgA?=
 =?us-ascii?Q?X1CjJ7sX+izAyb1zR3OPBlc4V8ho+m5p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?59xaPYXjrCwLQwIOASc+M1XQJU/fAJfbx6p9Pc8VeJ1MDIQZhUwWXBrjF3Tb?=
 =?us-ascii?Q?/dsp2ekmoukJ+NwUkdgNmZw3SeAFxudVGqdw03UhbNfWFLRkUaksnXxGUpBU?=
 =?us-ascii?Q?dKO1jNeK5WVLvnxWkC1QMW6tMKGqVMXs7ArcWsZcRR0ZxWbmcLT31l34ZCSk?=
 =?us-ascii?Q?D5Q1lSGqqUep5+uyBGbrWNW1sMWEgercKAyWp86OjKyjqWCccCC/nNN+F7os?=
 =?us-ascii?Q?vpx73wOYMQJnghJclYjCbiXBCvtMeQCq0bBfZ+wTu4gwdFCd4yX60Fpm2COE?=
 =?us-ascii?Q?+SLwW2sMiMgLPJ5oUYYN00owAoRktUqagcO5YpZXQfoNbNnolMfJe8SG8ok4?=
 =?us-ascii?Q?M2kMv5LBGStbgoI0zyt9k76WvQvSClTrtq2ptZ3CAFrZfGhKrbXX/YMbCV9Y?=
 =?us-ascii?Q?wxAf5xuoQLGMDivMagF7Q3m2nrsbLtdjcYfAmMI65M+sjAuNZ+ElHzamFzHA?=
 =?us-ascii?Q?GBVQWuxVvg7NqzeAQ5YJW+LmbW9r/oYbPjO6jG2sTKnLBWtzC5MHr4ZRtrVl?=
 =?us-ascii?Q?LpmltFcE1GSaS4aVOdwiR8bfOgNbf0tQKb6D7LioCveQXlAFaCIdZqVJCltz?=
 =?us-ascii?Q?qyTEn0ImFrfcOCJJm7wWB9xf74VowIGp+bV3R+6R5gU+NBn7h7j7DjKLS5PW?=
 =?us-ascii?Q?g+a8Kctgih3XoQVe66+R2PMvDuQ3puUWnba+oQKxWBKQIrS9S5q7OXoaAc3a?=
 =?us-ascii?Q?1ihaZ63KEVCOOIhtDm1wfaRsPvsJduOka90826WK8UUxwRAXIA2Hqg9rVMIJ?=
 =?us-ascii?Q?7uGShTn6k2QxOO6ivfP+Ee3p5M8m0IJ3744K4m4QiGEF77SS3nfJ0eX3uXqn?=
 =?us-ascii?Q?IQtDoj27dbC26YpgO098BG2Bb+gHfBdt7lFoIA2RjegUCFUxtBB1Nu6HJkwT?=
 =?us-ascii?Q?/CZqlkBGifn1AVeyPm6Em5NNOGvv6qhnVHL6fFV03wJ8R3QSCFYGRFs/zEdO?=
 =?us-ascii?Q?21P3B5+oEyhpQw9g4o5M7/iS0is1VjGmaZuK6LYix7qnAmrJkeBZe84ScL5g?=
 =?us-ascii?Q?YADhnVddtVLQUKi2C4+yyFOTyG0/EjWYqjTaNSMfI6kudXqKXsDZEa6AKR/d?=
 =?us-ascii?Q?zlso+avj67kGvFO2bHR6cKhPqAQClFUR7jXA0lYiA/ic1phH74vwOd9nwoHx?=
 =?us-ascii?Q?jHGuXCKyIT0WvgacD8HatsvVGq1cR8ilnLKUh7wxCkeaXc0p7/32iJXLOuzM?=
 =?us-ascii?Q?U2tB/1FGmTt1UWFt5wC4w0uxVA/m/gzOYXR9CsjIRId1y/ufr8J36FPK68hj?=
 =?us-ascii?Q?zqqREO/TBhQPeaoj7rPdLMWvhY3vu938vakfxUuUhoEeksbUXy2tYkKuoaul?=
 =?us-ascii?Q?DikU9U4O+p6huA0MX6ZTBfUOBVVR7ypR5DT6AYpVt1NggDlwqhWE0mlDY35Q?=
 =?us-ascii?Q?YhG299G23Um7leWdGm2cJwcvWa7sRO9xkD35ICnOeeSceHXIk2Ovle+uRyFn?=
 =?us-ascii?Q?rf8TMFBWySjBy6CPaCEJOQKYPlbIDlf/AOaCicZxx/zlHVzzS0HW4Np3mj/8?=
 =?us-ascii?Q?lac//LvpMsyxd9fVEQIs2GWFZ9dav8Y9x84MwYUtEVteExTGUvc7DHSHNYEV?=
 =?us-ascii?Q?PB7vw1DhzwUOL1zUN0iTKpy7Ah9dRyR3eu59e6nB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 511832ea-7477-44f3-eb86-08de162f65b8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 14:36:36.1285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: egyLeBovuKkPpRwevLUDacu/H3abhrbDHMX4+JB4+ql6iGZFTIqxk5ITjuz7e3SwxClrBP+YF4cOf3aahT0uAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6403

On Mon, Oct 27, 2025 at 11:18:38AM -0500, Mario Limonciello wrote:
> On 10/24/25 4:32 PM, Yazen Ghannam wrote:

[...]

> > +/*
> > + * Some older BIOSes include extra entries in MADT.
> > + * Do some vendor-specific checks to ignore them.
> > + */
> > +static bool ignore_extra_apic_entry(u32 apic_id)
> > +{
> > +	u32 pkgid = topo_apicid(apic_id, TOPO_PKG_DOMAIN);
> > +	struct cpuinfo_x86 *c = &boot_cpu_data;
> > +
> > +	/* Allow "physically not possible" cases if in a guest. */
> > +	if (!hypervisor_is_type(X86_HYPER_NATIVE))
> > +	       return false;
> > +
> > +	/* This model only supports 8 threads in a package. */
> > +	if (c->x86_vendor == X86_VENDOR_INTEL &&
> > +	    c->x86 == 0x6 && c->x86_model == 0x2d) {
> > +		if (topo_unit_count(pkgid, TOPO_PKG_DOMAIN, phys_cpu_present_map) >= 8)
> > +			goto reject;
> > +	}
> > +
> > +	/*
> > +	 * Various older models have extra entries. A common trait is that the
> > +	 * package ID derived from the APIC ID would be more than was ever supported.
> > +	 */
> > +	if (c->x86_vendor == X86_VENDOR_AMD && c->x86 < 0x17) {
> 
> Maybe look for lack of X86_FEATURE_ZEN instead?

Thanks. Yep, good idea.

> 
> > +		pkgid >>= x86_topo_system.dom_shifts[TOPO_PKG_DOMAIN - 1];
> > +
> > +		if (pkgid >= 8)
> > +			goto reject;
> > +	}
> > +
> > +	return false;
> > +
> > +reject:
> > +	pr_info_once("Ignoring hot-pluggable APIC ID %x.\n", apic_id);
> > +	topo_info.nr_rejected_cpus++;
> > +	return true;
> > +}
> > +

Michal, does this patch resolve the issue on you systems?

Thanks,
Yazen

