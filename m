Return-Path: <linux-kernel+bounces-858141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B170BE91B7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2112F4EA9B8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB10436CDE8;
	Fri, 17 Oct 2025 14:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="bu9ROv6k"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB77332ED8
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760710281; cv=none; b=flSUakSii7u1r/w2VZjQ224FqapP1pbajBNl3mDs0y54ce5oW9mPA3y8pDbgsOmnhiOJYdYAZotZe//nPVkzs3Y5Pj1Tu9pCeXTKqYV//wK9catO1nVE8zyYQD/r4FiO74reJCLjMbc34W9oCrvBN4NJ1r1FtBLzGUj8UYX/c1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760710281; c=relaxed/simple;
	bh=9B5vEkIH8nKOMJ2pa7dQQHpQMvOjno74wZoZO+7Ez2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/Uf7u2i83wHILPQHil9ZKrspunr7pipz2/y91bbEvNmDR8XiDNHMFVmrC5Pv72ApL2NTwcihN+q+X9ufL6/R58Jd5VXlXCr/RCUTw4r20pH7daLsk98Bp7XdT4bW+F9TzOAx9ciGrXxyM+0FOHHTJ06hlACzFOFGjsXFSslFaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=bu9ROv6k; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-88fa5974432so259769785a.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 07:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1760710278; x=1761315078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M6ds8aPxh7S7Lt5UrZxirxWPacqgdchl1177Nxo/2fE=;
        b=bu9ROv6kRYO/7yAFL6Z9SEqzTekWbqoeU4XfwcDrbs4fXlCbA1MaTl2aqE84k4xFDY
         JehI8c9rn9w/0uzzmTea78QvJaFuCruDL8RikiEO+uMJSW6SyiP0Ftd/a3YvZ5lnp+iu
         633rdorIihpKfleYDegeSiDHkp5g2xIaYJ48VA/sz7TeyJwH36Iy1R6LWpq+X8rtXV+9
         9EtlaGtfMq5U4ITAw5MUBvV/2MyC6jZbrIt16qUIrvFP/UZ5rbYEpAGlA+Qyox1sSBVd
         +Z4ZKjLe6e+myFc0d2YIj3DySBqmNPv+9PxEde6EyFddoMtwVzt9BYF4fGIRsozdjyq7
         uHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760710278; x=1761315078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6ds8aPxh7S7Lt5UrZxirxWPacqgdchl1177Nxo/2fE=;
        b=i2KeQbg9HD3YsWdYzAFq+b/3oI5AEqASqMt8NhCPSQtaoCuAiqAlngAvusi6/Qv/CM
         wByKO0gDfr6efZyxPjDNam8z9Gsw+7X+YfoDHi3tMYNoA0WGUuzPZ6AWzRBkfuCV6JKG
         ESMydMYgSBuQIICip7JV+2SAerrJSnx4xIItGTVvibGNPAdsyrwBflsZZOoqGQX2eZ9N
         FVSY2/blO6GatY2vPeeZK3Qd+8rYgb4SSSBB8lf3urRLsmckRqmz8BTzuUqckxM/X/1N
         n2qK0lQRPZusdPIidWspM7abDPFCBBoT2NftGehrYOwLUSzlLlIuf2CjpWVInNEzOrB5
         UXyg==
X-Forwarded-Encrypted: i=1; AJvYcCUr5G/AerkbVNup0hiF2VUmOm5YSEhlnM6ZXA8DWNqdJvNsZ/51FuVG/C3SngsPTLftct8u8lzhUWx3Cq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YysQDGs6mLjDkW+12+R/+j8SQdMayw3w/otmHxxiTtYeKMNE6ar
	djBgL2uo/Qi9GHQ+z02DiDQXdlDloszs0zHJXv7UcES+pSwSfqiL4Jgf+HDGq8fQ9c0=
X-Gm-Gg: ASbGnctS9E/ZBBlNnafULEM68CKAVa50j60Ranbi1vP/xwfjzfHkVaoVEcTCukYLLmD
	lWHAdLvSbT9XWjZPbp/KdvyQrOv0eMC19pCgRa9U13VuZWt4QiBW72j7GORY8XyiTmXpb/nfpZr
	W+1yRjuBbhRFl6QfkkLTKmWR+pDrqV6Cggm4cfggh2LlvML36Jy0Hr4vUIrwPzxMWQWF2pn4n2C
	TyZBqYgecMAKumIxpECkxVoyYDugMyL3jX2c+pYSEL5GH6PtQgBTSYkzOUuoimN+xopjwVJ2RMO
	39aLXS10oUQXOAHT2pxbVmH+0dKHk2Z0Xshn6hBQiHJn2iQ3OVtnYSRug3LVEwu09w2MaWy8pLH
	aoyNddAF33pgO6HJdZznALv5y3SoWxgiDWzViFT/EZgtlGJUxgZAurjHDEwxO28SgCJsFooPIi0
	Xt/Pq5BAjm4NodNF/DzV61pdTcnTqCdewJbVullWQInfruhoxh8i7isZ0wpC8=
X-Google-Smtp-Source: AGHT+IH8LpteQZDQ+J2oywG/+kVC1wIwU+JCaxUxk0r7zdVU9vHyFVi491xjxlagAerjw11v+bZ9fQ==
X-Received: by 2002:a05:620a:a1d9:20b0:891:2447:9d91 with SMTP id af79cd13be357-89124479ef1mr147297185a.66.1760710277492;
        Fri, 17 Oct 2025 07:11:17 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-88f358726c7sm431196185a.7.2025.10.17.07.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 07:11:17 -0700 (PDT)
Date: Fri, 17 Oct 2025 10:11:15 -0400
From: Gregory Price <gourry@gourry.net>
To: Szuying Chen <chensiying21@gmail.com>
Cc: akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
	dan.j.williams@intel.com, jhubbard@nvidia.com,
	akinobu.mita@gmail.com, sumanthk@linux.ibm.com,
	peterz@infradead.org, huang.ying.caritas@gmail.com,
	linux-kernel@vger.kernel.org, Andrew_Su@asmedia.com.tw,
	Yd_Tseng@asmedia.com.tw, Ed_Huang@asmedia.com.tw,
	Cindy1_Hsu@asmedia.com.tw, Jesse1_Chang@asmedia.com.tw,
	Richard_Hsu@asmedia.com.tw, Chloe_Chen@asmedia.com.tw
Subject: Re: [PATCH] kernel: resourse: Add conditional handling for ACPI
 device
Message-ID: <aPJOg2XsyIYUUaEi@gourry-fedora-PF4VCD3F>
References: <20251017023531.5616-1-Chloe_Chen@asmedia.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017023531.5616-1-Chloe_Chen@asmedia.com.tw>

On Fri, Oct 17, 2025 at 10:35:31AM +0800, Szuying Chen wrote:
> To avoid address conflicts and related errors, specific checks for
> the ACPI device "AMDIF031" should be bypassed.
> 
> Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> ---
>  kernel/resource.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index b9fa2a4ce089..9ffcd5bdb62e 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -177,6 +177,27 @@ static struct resource *alloc_resource(gfp_t flags)
>  	return kzalloc(sizeof(struct resource), flags);
>  }
> 
> +static int IgnoreResource(struct resource *tmp)
> +{
> +	char *pt, *name_sep;
> +	char *name;
> +
> +	pt = kstrdup(tmp->name, GFP_KERNEL);
> +	name_sep = pt;
> +	if (!name_sep)
> +		goto out;
> +
> +	name = strsep(&name_sep, ":");
> +	if (strcmp(name, "AMDIF031") == 0) {
> +		kfree(pt);
> +		return 1;
> +	}

Assuming we actually want this, i think we probably need to put this in
an arch/ extension, not hard-coded into kernel/.  There's no need for
non-x86 platforms to ever touch this.

> +
> +out:
> +	kfree(pt);
> +	return 0;
> +}
> +
>  /* Return the conflict entry if you can't request it */
>  static struct resource * __request_resource(struct resource *root, struct resource *new)
>  {
> @@ -202,6 +223,8 @@ static struct resource * __request_resource(struct resource *root, struct resour
>  		p = &tmp->sibling;
>  		if (tmp->end < start)
>  			continue;
> +		if (IgnoreResource(tmp))
> +			continue;
>  		return tmp;
>  	}
>  }
> --
> 2.39.2
> 

