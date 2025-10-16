Return-Path: <linux-kernel+bounces-856307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 24017BE3D11
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D78DE4E7EEB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7990833CE8D;
	Thu, 16 Oct 2025 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="mg7y8tH2"
Received: from pf-012.whm.fr-par.scw.cloud (pf-012.whm.fr-par.scw.cloud [51.159.173.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2E81A0728
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.173.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760622914; cv=none; b=R4kQMmccv2YSKxEmpemcUCNqTyL4+shneiKU5Y0W9bOc2Qp6FQNApi7F8FxXTPLx5kjc0Xr0MNSOQcHSxmfVxAyjX5UU3dNfAAUtaU3LejKJKfWlvyl2uKypSIRYnUGbgZcauF3dY10n8+NqU6EyW40zqycFqk2rLFQw843bz2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760622914; c=relaxed/simple;
	bh=Qpv27fpsXm8jxsD0h+jONZzlfRHhtgt03BiW9Giys7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxtyoXrn+r4iLQbji+WZ90iUS8o1ceqSE0q6AVXfb43WLf3KmgiUf6av1pXWYjyRqwCZ1NGdV2RPllSIs23CoQJopxjp5i/XXhP/ypNk4qr8kwdxc4XWbRn9xdpV9/mLKVNXkSwfo4bTFhSX/R/Bm4cxALoJkj+BWQuJiH1peHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=mg7y8tH2; arc=none smtp.client-ip=51.159.173.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=i2vvv78M0Jc0qgLmHMvHJhgChDzXNg/57Bm9I9IOT5Y=; b=mg7y8tH2N2LyqAy73ICGp6y8XD
	nOsTybaY8oRWQhuZMkBV+gRgG6lvShhsQ5+wFKfDbM4IKD5qKiJQvUL5KULweObigQgzuSEPgGwpQ
	reNpXxEQV7QZMzf1bFmzh2o4i35KLN2q7mtj7LnAjKr5c6rVm0UZ4DdBvqVGp2Puz598ri9I5QNCN
	abIcHOU1ab4dbgWxd5KdwN8Vbmx5WXYhZJbm/ouFdDHeUAIb4V+rfe2EbTziOqK60MsZgXhcG54cd
	il3U1DMqYI38QCgMOn7FfJrng/KGBMLC0WKZ2WWh/B3t7uPpfgx73RVncYcn9Wq5jMOMiX+UOVyH8
	3RGxs6NQ==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:61866 helo=archlinux)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1v9ORj-0000000H9QG-1Ve2;
	Thu, 16 Oct 2025 15:55:09 +0200
Date: Thu, 16 Oct 2025 15:55:06 +0200
From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, 
	Aaron Rainbolt <arraybolt3@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Xiujianfeng <xiujianfeng@huawei.com>, "xiujianfeng@huaweicloud.com" <xiujianfeng@huaweicloud.com>
Subject: Re: [RFC PATCH 00/56] Dynamic mitigations
Message-ID: <o5decnfriq2nfg5o23uuwptzxnsbwalltm5hjxpwgr6eje5p5s@faehapbq43rd>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251014231039.6d23008f@kf-m2g5>
 <LV3PR12MB926564CC5E88E16CE373185694E8A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <cnwawavsdedrp6yyylt2wqiglekwsgrofimkvh32fknj676xsh@4vyzzoky5hzd>
 <LV3PR12MB9265837FA51DFD9D2F11474D94E8A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <a5kvnas7cttg3pxqdxye7qhyesbtyulhhdiunl2hr5tfmecpbz@y4ggjfafqawn>
 <LV3PR12MB926513717F67A02278659F5094E8A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <lpv2uouli7b4zi4up5434mfdjngbvwbnn72vgyz47b76h2ac7b@uqlaa6mh7dfa>
 <DS0PR12MB9273B5438371E67441C042AA94E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR12MB9273B5438371E67441C042AA94E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: nicolas.bouchinet@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: nicolas.bouchinet@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

[snip]
> > LOCKDOWN_DEV_MEM is an integrity reason and should not be used for this
> > scenario.
> > I'd rather like to add a new Lockdown reason in the confidentiality set,
> > maybe LOCKDOWN_CPU_MITIGATION ?
> >
> 
> Ok, that makes sense.  Just to clarify, would that mean something like the below:
> 
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 3f9410dee67c..9b4864f84146 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -691,6 +691,9 @@ ssize_t cpu_write_mitigation_options(struct device *dev,
>                                 struct device_attribute *attr,
>                                 const char *buf, size_t count)
>  {
> +       if (security_locked_down(LOCKDOWN_CPU_MITIGATIONS))
> +               return -EPERM;
> +
>         /* Save and filter the provided options. */
>         cpu_filter_mitigation_opts(buf);
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 92ac3f27b973..81cb52cf2111 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -153,6 +153,7 @@ enum lockdown_reason {
>         LOCKDOWN_TRACEFS,
>         LOCKDOWN_XMON_RW,
>         LOCKDOWN_XFRM_SECRET,
> +       LOCKDOWN_CPU_MITIGATIONS,
>         LOCKDOWN_CONFIDENTIALITY_MAX,
>  };

You should also add an entry to the lockdown_reasons array in
`security/security.c` with a description of the reason.

Nicolas

