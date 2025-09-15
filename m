Return-Path: <linux-kernel+bounces-817349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C05B58111
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607F31896051
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C033E2EAE3;
	Mon, 15 Sep 2025 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="f51olPMy"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60CE42AA3
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950609; cv=none; b=WPKp+wl4BxZFEq/qP5gZ71OHEH3QwWn/WMLysr5GiSN6CStDrgc891ksOIaRpThOL+9KKpDi/iwA1+UC9HowiBZUaEVclFd0R2anQdxXqAD/iqdQMh43cC3dbC4wapkpQYBcLKax9KsuSXxmAeC0YEAWvjPDxox4GjmQIp4VLKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950609; c=relaxed/simple;
	bh=g/1dQSbL9ecDfQJ7qQ8iZkBu9jxDChRi2xiFi5l5cl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHu8g89YN2P5uRYu/YuIm9cKUKAFQ+2oz03aGxmlq2GwfDnVijusdVMTYsLErB1QtwN40kT7DEQ4Alo5EAB3LOLNHMgHU8mG8BBuYjKMk3M4foO697SdF+BIR+/CouG5RFdVlHxGsaJoAPoOrtw65Q8Z3isCX6eYpt7WeHro+RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=f51olPMy; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8127215a4c6so509426985a.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1757950605; x=1758555405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0q1aTmJzhVKCzLEtotPA3ZHCkECo3p9tyTLfevkeiSY=;
        b=f51olPMyoPczxQhD5+2hxEl/x+FWh/6JxokIjvngEJSU0gr327JMVnAlSAqKTULXfM
         SVmu9ecl11WN3j8a13JjOVrlMEEcphWnRDz7/Kc5Npv0eKgCfLyprgZ1dzcigIVbRN5l
         2daoh71sakjv5nw96hNB51ooqUssDupy40Lwc/dZnHLnim/E3laJLsSOyeLZ4FIjR6j8
         JAQAwn+1YCkxsnkwrX1wz/3FscdJOSIg1xfg48eh47r1IS3CJ6KsgYjscC0+JeakJHxl
         CRHB3DLvdlQzCPE/aUpzrc+8e0miRAIL02PGB6rzAlvkNShHmp81iKWjNXy+hOLnY5m9
         SwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757950605; x=1758555405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0q1aTmJzhVKCzLEtotPA3ZHCkECo3p9tyTLfevkeiSY=;
        b=sr0xTarFRJnuAClEPKFe/YtalGlMuK7jecHHQRF6b09b6hCALZY4N4wbs5bO7/vZVW
         ZVJ6zSsMLODvO7BBbYqm3G2vh5rEdOgZa318EtOGPql7E6RCXhrVreJHoWWEtKXsGUj1
         n12IRBUBmdPdYr4BcynvtUt6VFUVFV3RXtUAOvLnT4hj8Jky8fPVhbkGjdyPT35x7Wks
         lXU/sAyNu89ru/wW3mOwQ5wCGepz3WFyMOBxy1xvh5MfYaSpkML735TkD+59tAwFDsWt
         s70ReGaGPHzoOwDqx4I62uUaxDQkRGoEOgT34PVDs26PZnhP+x73okqvSVhl/I2UDBk9
         C6lw==
X-Forwarded-Encrypted: i=1; AJvYcCULlqNsl18T5isHZU2J/KfD86f7VqXOgLa1uqBbCknU4xs9sGiyWvl0Z0AgRlWxvUYONAvFEei9awW5Msg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoIgWaEEQRXTmAHlKyJnsG6NdwG8+R5e6FfTa8ZmHAT/I6dg+e
	46GQwiQhPAfqCPu51pTMoZs1ZeaSnuCM1cVM8ivBivyDE7i+byIzbh6/+oIuGd80N7xD+AKkVGP
	Jgloa
X-Gm-Gg: ASbGnctL4C3XUunzJBNW7G+1JsV+LnJRfyHhkv0ScRpneDX8i1gbyhAnrE2w1RsB2cY
	FFU4AFvAhmtSpZOM6Ibo/XGANEFJhX5B83GY4KEIv4Oc+hvAkIZkxh6dBXV9Ua5FR64MsHjaPe/
	t97ihcgPiYJmVWp59v8BLxdzW5j8nm8123yvsQz8LKy2zTAoCkba6sYIW91eHCWYHLliEnUT3Rs
	cAmDwJQfSYTayKVnMgqzeUKnkEYYZaHahGh+WGobqqRTd+5SR/Ff+576I+mk70hoxXuhTztNZM6
	yS1TNT1PUY4/T22DfoQ3FSDUyiWkFO4rxbbO2L5YkOfGyAuz5YQAgMAaxguOCe4BYjSX6nLlj82
	x8yFs5lReChSBDGaqFXRfj6PeT8Nsh5Fz8xiUHObdxEk=
X-Google-Smtp-Source: AGHT+IFW9KnCKRb5PDF5V208B6P3t0e7Q6CTOoRS/R//UBWQOsBJCExtXlGpi3IUSyGz8irfB7JJTg==
X-Received: by 2002:a05:620a:6f0d:b0:82b:269a:f201 with SMTP id af79cd13be357-82b269af209mr72205685a.10.1757950604983;
        Mon, 15 Sep 2025 08:36:44 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-8290e22eef4sm294192285a.49.2025.09.15.08.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 08:36:44 -0700 (PDT)
Date: Mon, 15 Sep 2025 11:36:40 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: zswap: interact directly with zsmalloc
Message-ID: <20250915153640.GA828739@cmpxchg.org>
References: <20250829162212.208258-1-hannes@cmpxchg.org>
 <20250829162212.208258-2-hannes@cmpxchg.org>
 <r3dzlbqyvhaho5zuac7eba6pxz47zy3cz4lopxza3ls3ibadlh@6evm5aryyuxp>
 <20250909150156.GB1474@cmpxchg.org>
 <46xtfjznexpdlemxjwykin5k74oqomedb2fyli5jrb4xnquuke@ztcmxhmhlkx7>
 <20250910134240.GA1111@cmpxchg.org>
 <f5hn4awbmkelckl6khlaosw3tbfrwzvf5l7kn6mnqpbastsdnh@77mqvfjzyfys>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5hn4awbmkelckl6khlaosw3tbfrwzvf5l7kn6mnqpbastsdnh@77mqvfjzyfys>

On Thu, Sep 11, 2025 at 02:30:31PM +0000, Yosry Ahmed wrote:
> On Wed, Sep 10, 2025 at 09:42:40AM -0400, Johannes Weiner wrote:
> > @@ -314,6 +314,10 @@ static struct zswap_pool *__zswap_pool_create_fallback(void)
> >  		}
> >  	}
> >  
> > +	/* Kconfig bug? */
> > +	if (WARN_ON(!crypto_has_acomp(zswap_compressor, 0, 0)))
> > +		return NULL;
> > +
> >  	return zswap_pool_create(zswap_compressor);
> >  }
> 
> Sure, looks good, although I think it's clearer (and smaller diff) to
> preserve the old structure instead, up to you:
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index c88ad61b232cf..bbfc087792648 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -300,18 +300,21 @@ static struct zswap_pool *zswap_pool_create(char *compressor)
> 
>  static struct zswap_pool *__zswap_pool_create_fallback(void)
>  {
> -       if (!crypto_has_acomp(zswap_compressor, 0, 0) &&
> +       bool has_comp = crypto_has_acomp(zswap_compressor, 0, 0);
> +
> +       if (!has_comp &&
>             strcmp(zswap_compressor, CONFIG_ZSWAP_COMPRESSOR_DEFAULT)) {
>                 pr_err("compressor %s not available, using default %s\n",
>                        zswap_compressor, CONFIG_ZSWAP_COMPRESSOR_DEFAULT);
>                 param_free_charp(&zswap_compressor);
>                 zswap_compressor = CONFIG_ZSWAP_COMPRESSOR_DEFAULT;
> -               if (!crypto_has_acomp(zswap_compressor, 0, 0)) {
> -                       pr_err("default compressor %s not available\n",
> -                              zswap_compressor);
> -                       zswap_compressor = ZSWAP_PARAM_UNSET;
> -                       return NULL;
> -               }
> +               has_comp = crypto_has_acomp(zswap_compressor, 0, 0);
> +       }
> +       if (!has_comp) {
> +               pr_err("default compressor %s not available\n",
> +                      zswap_compressor);
> +               zswap_compressor = ZSWAP_PARAM_UNSET;
> +               return NULL;
>         }

No objection to moving the branch instead of adding another one. I'd
just like to retain the warning, since it shouldn't happen. And ditch
the bool, IMO it pointlessly splits the test from the consequences.

If you're fine with this Yosry, Andrew can you please fold it?

---

From b8fa4c7edd4f3c84853665b47acec8cebb4f4899 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Mon, 15 Sep 2025 10:56:15 -0400
Subject: [PATCH] mm: zswap: interact directly with zsmalloc fix

Yosry points out that the default compressor check only applies when
something else is configured and we fall back, but not if it was
configured out of the box but isn't available. Move the test. Kconfig
should not permit this, so replace the pr_err() with a WARN.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/zswap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index cba7077fda40..c1af782e54ec 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -309,12 +309,12 @@ static struct zswap_pool *__zswap_pool_create_fallback(void)
 		       zswap_compressor, CONFIG_ZSWAP_COMPRESSOR_DEFAULT);
 		param_free_charp(&zswap_compressor);
 		zswap_compressor = CONFIG_ZSWAP_COMPRESSOR_DEFAULT;
-		if (!crypto_has_acomp(zswap_compressor, 0, 0)) {
-			pr_err("default compressor %s not available\n",
-			       zswap_compressor);
-			zswap_compressor = ZSWAP_PARAM_UNSET;
-			return NULL;
-		}
+	}
+
+	/* Default compressor should be available. Kconfig bug? */
+	if (WARN_ON_ONCE(!crypto_has_acomp(zswap_compressor, 0, 0))) {
+		zswap_compressor = ZSWAP_PARAM_UNSET;
+		return NULL;
 	}
 
 	return zswap_pool_create(zswap_compressor);
-- 
2.51.0


