Return-Path: <linux-kernel+bounces-727233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F233BB016DB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8D0F1C239C7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A909C21CA1F;
	Fri, 11 Jul 2025 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="WayrNgeu"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDF821B9C1
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 08:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752223943; cv=none; b=Dqq8qI1UV2rZpz3O2t7E7q9ON5ZnGA/ws+mc3CLtAcXp5En6U58gXZA1ySuZVCvmnXPKN8+qxdidGMIwBVcr34xtKlQSSoDddeNqKl+muuX2KgJBkhY0w27K86vPKnnwncDexyyl4PIkS0MlSEPGRKvPYELPQhDQBtNwDyXDds8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752223943; c=relaxed/simple;
	bh=vA5QebrlQcJNv1a91wNZgep7yhevRHrP9idpLiS40Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBnej/Hm2t4jdZ0TiSde0R1XSvr0nL8qfhvMWAU/e2ED/BqgJvsyQw8gWwvy4NJzpMH3qrwEzef0Ebve0WgohEkAQr1BNl+jAWrEfv6hE90zxSxy5+zArRHMg7FCa1OZnlSTsDUGU2EbOz1Z4KuKFUOxt2tiWdn9FoG0To85GdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=WayrNgeu; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so16379335e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 01:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1752223940; x=1752828740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8derBKGkrTEyUk4H7Vgf14bpDSTC61VSwEgs7ngR2I8=;
        b=WayrNgeuzVnNtLgoFyk68AfB/mWNap7Paw0374Cm3++7WYeX4EPQYhdnR496eBmDiX
         SSkBmSmcLpxomzISkEVzpjVGZUmxfsRGWghL6GBSxl5+wyKczrjxAxF/uOOrqfZuWZcm
         hkJOeOqTQlfrJsIs4acWlMqb2eSdrRykMmF2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752223940; x=1752828740;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8derBKGkrTEyUk4H7Vgf14bpDSTC61VSwEgs7ngR2I8=;
        b=pKQZnNlZ5NDrNLxbb29Om/E5OSDetfTb9G9F669wcU3TtvFEbqoIX5CRmx6VlvUiJT
         NZ8aeMXJAWfUk6qAZYp+rOoCfm2XdNHXfh9TTROGauwFJbqOIWXgwOYT/pD4pQsnCbno
         WpX96L8tOqzOfw/pHsLfegrQD+SoS2khzxvudrSFPMvdf6KTpKQYUPI+KznQ8os/tzno
         CXcultE2Xn6M6IuUrQ947qnxB1qufekZv7G/t3IiwiIjVrymay6k3jB1kkIHILT7xqkz
         uLHQNN+XUkbXBHwIi6sfrJ5U8x5sTRk5OGfvAkliIJYe+rnfEFJWnPDzbfhuFMTbZsJe
         oOVg==
X-Forwarded-Encrypted: i=1; AJvYcCUVAgM+b7G4fz3Tk5wc822pUNgGRQrqKCyRZHZg1OsPmant7kdKrgdqwhWkm0VQF9rmPMZDju4Ybn3jlMI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4RNfPWGaF8YUozZJXltxyGyvHMi+d6AZhluqnewiORz7IgA6j
	wudnIrWsd5K8oZBYhBnabWzpVer1E6D5RF27iy8pt0xxqhVoDVKQSv2O3G9L0sftE0g=
X-Gm-Gg: ASbGnct9zRlhDS8RETn6zP9g6LQrhCeOSexZPQWsz6ui8epThrezuCsEXzgI+g7mhj5
	r0D25PfT8BM55hq21/CJVc2Rc1bGT8gVyOXNcvtt4lwPSpYrXGfCyQ9Jtb0jFtKRE314fJ3zoIH
	1uEFd53vm0pVj0uecdEawhM58SUyafx05PqE6bTz2/LRqDQKvnIUvira8pNwn6myFojy9vRHayb
	e4UnVvr7hGN/o0fl6TaIW2M4pQxl/5G53J4TT/jhWcaH9HgG0fZVjdCDhnXqXO940+k9jDg8vEd
	FEut7spDXBvhhJgYYKzclQmjT7xohFUD/zVufm87dOCC7uH50LAQAN4gHB51GMMjl4E9qaxciMA
	7nTv86K0v5ZlVZt4JvyMCqGkGLrnk0MllvsM4ULQLVPY5
X-Google-Smtp-Source: AGHT+IHb717NClqAG1xifIUSeLJK08Q/iqQmZrgvVQp+OyvdWt/usHRp8NPbh9G8VPNNxhojCPLDSQ==
X-Received: by 2002:a05:600c:8207:b0:43b:c857:e9d7 with SMTP id 5b1f17b1804b1-454e2addac7mr22372895e9.5.1752223939638;
        Fri, 11 Jul 2025 01:52:19 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd540b52sm40898565e9.28.2025.07.11.01.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 01:52:19 -0700 (PDT)
Date: Fri, 11 Jul 2025 10:52:17 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Kai Huang <kai.huang@intel.com>, Ingo Molnar <mingo@kernel.org>,
	Zheyun Shen <szy0127@sjtu.edu.cn>,
	Mingwei Zhang <mizhang@google.com>,
	Francesco Lavra <francescolavra.fl@gmail.com>
Subject: Re: [PATCH v3 1/8] drm/gpu: Remove dead checks on
 wbinvd_on_all_cpus()'s return value
Message-ID: <aHDQwa8FnZ33Rj8u@phenom.ffwll.local>
Mail-Followup-To: Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Kai Huang <kai.huang@intel.com>, Ingo Molnar <mingo@kernel.org>,
	Zheyun Shen <szy0127@sjtu.edu.cn>,
	Mingwei Zhang <mizhang@google.com>,
	Francesco Lavra <francescolavra.fl@gmail.com>
References: <20250522233733.3176144-1-seanjc@google.com>
 <20250522233733.3176144-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522233733.3176144-2-seanjc@google.com>
X-Operating-System: Linux phenom 6.12.30-amd64 

On Thu, May 22, 2025 at 04:37:25PM -0700, Sean Christopherson wrote:
> Remove the checks and associated pr_err() on wbinvd_on_all_cpus() failure,
> as the helper has unconditionally returned 0/success since commit
> caa759323c73 ("smp: Remove smp_call_function() and on_each_cpu() return
> values").
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

I guess this'll all land through x86 trees, for that on this and the patch
from Peter to adjust the module exports to include drm and i915:

Acked-by: Simona Vetter <simona.vetter@ffwll.ch>

Cheers, Sima
> ---
>  drivers/gpu/drm/drm_cache.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_cache.c b/drivers/gpu/drm/drm_cache.c
> index 7051c9c909c2..ea1d2d5d2c66 100644
> --- a/drivers/gpu/drm/drm_cache.c
> +++ b/drivers/gpu/drm/drm_cache.c
> @@ -93,8 +93,7 @@ drm_clflush_pages(struct page *pages[], unsigned long num_pages)
>  		return;
>  	}
>  
> -	if (wbinvd_on_all_cpus())
> -		pr_err("Timed out waiting for cache flush\n");
> +	wbinvd_on_all_cpus();
>  
>  #elif defined(__powerpc__)
>  	unsigned long i;
> @@ -139,8 +138,7 @@ drm_clflush_sg(struct sg_table *st)
>  		return;
>  	}
>  
> -	if (wbinvd_on_all_cpus())
> -		pr_err("Timed out waiting for cache flush\n");
> +	wbinvd_on_all_cpus();
>  #else
>  	WARN_ONCE(1, "Architecture has no drm_cache.c support\n");
>  #endif
> @@ -172,8 +170,7 @@ drm_clflush_virt_range(void *addr, unsigned long length)
>  		return;
>  	}
>  
> -	if (wbinvd_on_all_cpus())
> -		pr_err("Timed out waiting for cache flush\n");
> +	wbinvd_on_all_cpus();
>  #else
>  	WARN_ONCE(1, "Architecture has no drm_cache.c support\n");
>  #endif
> -- 
> 2.49.0.1151.ga128411c76-goog
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

