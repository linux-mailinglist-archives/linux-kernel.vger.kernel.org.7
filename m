Return-Path: <linux-kernel+bounces-844586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B85BC2460
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 19:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD2E401959
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 17:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261B12E8DF4;
	Tue,  7 Oct 2025 17:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="ICp/gFwL"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF37F155389
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 17:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759858997; cv=none; b=BUQaDH38JMWcF04t/0sao9+Vr4XmjVy8n2OfxyswUdDBu86Fi1ZaOdmAo1P4D37OtXsPMFJzIWs+sk57v47mRtWdwt2p1tto2iOodDP6N6iph+zROKSR22I1NdgOwOrQGY/uXYFdKsy8EtVGtBtWhHGYn856nVBSuSwTJbZW/DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759858997; c=relaxed/simple;
	bh=fy2f4LAugXtX6FZapZ5OpT+5NFkWjLJLRapkjAiumHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVdaeUPvEztDssZLnTefTtSIdX+fkN/EPH502oKlaFxKB4ZRLzgUD7vWBUM+mLKF1xrjvqoCPP9n/30BMXzRFOVEFuvZO9+DaWAyZe6mkYGpxa/eQkSPEO6Ud+3s91WunfcpD53E/9lNc/p4C9FWXhZWa0FwvKtPfpjdIdSDrVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=ICp/gFwL; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597EnmYq022644;
	Tue, 7 Oct 2025 17:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=Pqa21vxAj8soGzOH1rJfeQh8K2
	FdDXLQA3Mrla8f0WU=; b=ICp/gFwLDDMt6d1GuUiUjeXoPQJToxDNJWP0JCGI/K
	t0ReibM3eoszRcqEj+ppJcPWxmOgmqjbI7OKJbT0+jsEo+NsWBF0FOJOiE0yTR40
	DVz5Rj9X3/B7qFzMenmYnG1shvrx0qRVaGO3t9yd+ml5q7Fbp0JnfMg6ZsEL4HOF
	WKzp2zdewhBr4B33b4DN5EaHic95dnerpqBZNXLhLcHQq2GjGAGjkcLwjcU8665C
	0D2/eog5rsDCXsgmiUxGwYfvest7O1uodPfBagtKVDhJ4bLbs3/Ij3IcmnspzIk5
	Xu3YScnf0cuegDxBREJOlIS1TBbdxDSXVXlRstfGlG2Q==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 49n4yd1gm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Oct 2025 17:42:22 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 21AF1130EA;
	Tue,  7 Oct 2025 17:42:19 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 62458800EF5;
	Tue,  7 Oct 2025 17:42:17 +0000 (UTC)
Date: Tue, 7 Oct 2025 12:42:15 -0500
From: Dimitri Sivanich <sivanich@hpe.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Wiesner <jwiesner@suse.de>, Steve Wahl <steve.wahl@hpe.com>,
        Justin Ernst <justin.ernst@hpe.com>, Kyle Meyer <kyle.meyer@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Marco Elver <elver@google.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Nikunj A Dadhania <nikunj@amd.com>, "Xin Li (Intel)" <xin@zytor.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>
Subject: Re: [PATCH v3] x86/tsc: Disable clocksource watchdog for TSC on
 recent UV
Message-ID: <aOVQ9xWyAJzecOY0@hpe.com>
References: <aOVAkYWjk+aWcM3F@hpe.com>
 <20264c7b-36dd-4fd3-a755-3f46584f37bc@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20264c7b-36dd-4fd3-a755-3f46584f37bc@intel.com>
X-Proofpoint-GUID: LVyjav--BhYoibH6ajEYHUIzSS7bWv3z
X-Proofpoint-ORIG-GUID: LVyjav--BhYoibH6ajEYHUIzSS7bWv3z
X-Authority-Analysis: v=2.4 cv=D59K6/Rj c=1 sm=1 tr=0 ts=68e550fe cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=pbH9pSXVR0IMgdhIYeIA:9
 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDExNyBTYWx0ZWRfXzxscCG7vLgnr
 SE1KxRlhvgVUMLEsT89k3ndwDtp6+LEUf6Zv9Yif9ZW+euPsFTdp++yCEj4bTZ+lllSvovH2mUm
 qoH8dQZdlRjU2qWrCGo4laHk3xM3vbJXXu/GxGi6j2AeDsAujF7Q+NvyQX9ynqWgGjuARiHO/CV
 GXUhL0injUndFPsWekZJeE2ggp+KXStndfOa4EFuYxKrbCdTdmruTcLkJnutslB5zfl8IWTkkmr
 uxqI6UMfMBznbWhyekP2dwchSSp0qfU9vLfr9m+HK3ZNSkYkCfX8/IaHtR7JTlXa32IL7phrxxG
 shqr5FBF19HhrJhCK+O2kWkqZH8WrMsR2Robxc81VpRDho21PM0A7AEhElL5qIkLwswkgKJJIBX
 u2YkVChGeWp+3LNaml2HGhiGzN+g0w==
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510070117

On Tue, Oct 07, 2025 at 09:48:58AM -0700, Dave Hansen wrote:
> On 10/7/25 09:32, Dimitri Sivanich wrote:
> > +static inline int is_uvx_hub(void) { return 0; }
> > +static inline int is_uvy_hub(void) { return 0; }
> > +static inline int is_uv_hub(void) { return 0; }
> >  
> >  #endif	/* X86_UV */
> >  
> > diff --git a/arch/x86/include/asm/uv/uv_hub.h b/arch/x86/include/asm/uv/uv_hub.h
> > index ea877fd83114..6e085ce8fc02 100644
> > --- a/arch/x86/include/asm/uv/uv_hub.h
> > +++ b/arch/x86/include/asm/uv/uv_hub.h
> > @@ -246,6 +246,7 @@ static inline int is_uv5_hub(void) { return is_uv(UV5); }
> >   * then test if is UV4.
> >   */
> >  
> > +#ifdef CONFIG_X86_UV
> >  /* UVX class: UV2,3,4 */
> >  static inline int is_uvx_hub(void) { return is_uv(UVX); }
> >  
> > @@ -254,6 +255,7 @@ static inline int is_uvy_hub(void) { return is_uv(UVY); }
> >  
> >  /* Any UV Hubbed System */
> >  static inline int is_uv_hub(void) { return is_uv(UV_ANY); }
> > +#endif
> 
> Defining those helpers across two different headers seems like a recipe
> for pain.
> 
> I suspect a big chunk of those stubs (and their #ifdefs could completely
> go away if you _just_ did:
> 
> #ifdef CONFIG_X86_UV
> static inline int uv_hub_type(void)
> {
>         return uv_hub_info->hub_type;
> }
> #else
> static inline int uv_hub_type(void)
> {
> 	return 0;
> }
> #endif
> 
> In any case, this is precisely the kind of patch that would be best
> refactored into two piece: one to expose the is_uv...() function and
> another to actually use it.
> 
> Also, at this point, this:
> 
> >  	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
> >  	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
> >  	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
> > -	    topology_max_packages() <= 4)
> > +	    (topology_max_packages() <= 4 || is_uvy_hub()))
> >  		tsc_disable_clocksource_watchdog();
> 
> has IMNHO gotten out of hand.
> 
> It should probably be:
> 
>  	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
>  	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
>  	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
> 	    platform_is_exempt_from_watchdog())
>  		tsc_disable_clocksource_watchdog();
> 
> In addition, 233756a640be talked quite a bit about *why* the 4-socket
> line was chosen. This needs to have a similar explanation for UV systems.

I will add the following to the description:

"HPE UV hardware and firmware is designed to ensure a reliable and synchronized
 TSC mechanism.  Comparing the TSC against secondary clocksources can result in
 false positives due to variable access latency caused by system traffic.  The
 best course of action against these false positives has been found to simply
 disable watchdog checking of the TSC.  Currently we recommend that customers
 apply 'tsc=nowatchdog' to the kernel command line."

The requested code changes will be forthcoming.

