Return-Path: <linux-kernel+bounces-810276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB9BB51823
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EFF21B22D97
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A86B31E0F1;
	Wed, 10 Sep 2025 13:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="ZxTdiKsS"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3434F31E0E4
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757511774; cv=none; b=AFooy48CXqm3YSZr+77PqApykACIuvZ6gbPheWT0Y5OqcVnyFtnNGkfrKc+EfDKFWoacOBUp9qAmO3Uzfo3v2b7z4cL8r8Bt+FM5l5j9mCS2/BlKxn5smASN3+N1U4KDPMY49MokwyCDER5PmMLJPyG6Oa9qiKg5KCQalrtb1qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757511774; c=relaxed/simple;
	bh=DtXNZ19JMKsYpezttNKrA3CHNtY2ZKqb7LlM1y0krEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVdbwW6Nu8F5yiVANeHRP1G5nzPdu1dpIuFw5aBGOrI0A8120Xmv+FEETj3DoP+QJqfD095knEOlBgEfW4ZL3OEY6WFbF9XLQDYTvNtOEhxLEYezu98NIw0wfs9x6zubfKEQ8ySuKCTXFypuDFvgI4NZuY9LUn76Vo50IVcthxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=ZxTdiKsS; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-720f0dd2809so37760866d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 06:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1757511770; x=1758116570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s3qjo4wmUBfQicHBvmITf72ixUInKSEILfcLkw3UTyM=;
        b=ZxTdiKsSizs74jLlS433aYO17BioyYYRDUON4i6N3GvsTdEIENqEaEJx1FBkkkMNva
         WnRpey8zpS2y8maRtKizoSvt0wbhrCl8hP1eW61c7gBRelPAxXU8ZGPJSIvNYDEZdayt
         j4u31fzig5BMMzAO/PwmeD0J0faoT7MZmfjFsArK8HisUrmVbq3qPw9deOh0nNGQR9/Y
         zlpVNTbPmJ/YvVtQuxmuE++KHtKP8d6YYpSKZtn4vOwG4EmVbFbkc/MCx3PAnco2L1Gj
         RExf/njZIF72xRDG351CqbZ3jfCSVpHtxVHYpOc2aCCTDweapYJx2wRSKJVnL+e6+Pgm
         VMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757511770; x=1758116570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3qjo4wmUBfQicHBvmITf72ixUInKSEILfcLkw3UTyM=;
        b=QzCeLaam6ZoIv7nnHGI7s/R1bgnErfm+m59QgQ9TxIFeCSNSWQwbfk+guvNDDWU3JU
         q+lxLH0vBx0h2RvSYaB5F9vNh/5uerY9JnRyVR3vK2I5LUfEjMsmTU8gU90f7uhxaMe8
         8FyZckWbHQyHsgfR0NSZ1/nFFYL2hiPuuZy2+u7566jP6kb9OiXVfTUcsnKgNsKqR6jH
         irdi4IwL7Tn0N+33tA/8ZY29cSk9EnRKhFBT0HA9Ni+mctPbh5tofh+px69O9oq18rzM
         gJ0UF3cn4WMgIYYPSgY/1tg7poaYSVSRRToPQEHAUACXwsJiDtrONZAFUsCqLmS5p5pl
         Xu1g==
X-Forwarded-Encrypted: i=1; AJvYcCWKZx36JiA8eD3K6k0zpOz8lkhP15Xv0fagBYCC7PosGFb3uc0P5z6tN2Ui9noA2N2Z74iYgKnveW9ZQ40=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXsO3oQ0SfRKrgYlN4t98o3lnowNGoNhMz/xz7WY0wltQM8EKo
	jAeia7qgDW2CKIKDfw0yxTK/7Ut/13HQscsTlX9y9kRO0Kb9j5+1iUfS9xcYdyIOWlk=
X-Gm-Gg: ASbGncsvnrJyHhRB+rZXBfESbHkbVH8rB4HiYsGUPQjoGpA0BAVJdBMel2zZvNtsuUz
	MoYnsRkbJltNpPwm07vmUeGXydXDNoW767d6JbAoZEo1HekmG+Dm+5F2XLLMqUEf8/Wq6bOvmod
	g0h7S2XdC8anwQPzxuCx4SiOfKP5kXDxecLuXl3q6YCavXnii2ouOin3egSDzcH5HJvaIfz4ZOn
	/av55F4zy1ek8TwNDF4ncFuRYV8pA564Csnf4Z4A+Zd+uO/N3LA5yItDpJs6ofbLEQyCInAshmY
	pjJ/4TCrFZnKKKVcp4XPBtQu3rinJH299VZwGOefN56Wd+7JF7JzgyZE7ocwDewrGZZ1Yo4ojyY
	xSw==
X-Google-Smtp-Source: AGHT+IEAT3o5C7Gf7qk35CltddL2BbFIvyxesOkWR7+WzvDnJ4VN07flllbdjhyr6rnI0d2t9+30Xw==
X-Received: by 2002:a05:6214:2aac:b0:70d:f64e:d496 with SMTP id 6a1803df08f44-73921b39bffmr163174036d6.2.1757511769681;
        Wed, 10 Sep 2025 06:42:49 -0700 (PDT)
Received: from localhost ([2620:10d:c091:600::6ffa])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-72bc240dc3esm109663606d6.24.2025.09.10.06.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 06:42:49 -0700 (PDT)
Date: Wed, 10 Sep 2025 09:42:40 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: zswap: interact directly with zsmalloc
Message-ID: <20250910134240.GA1111@cmpxchg.org>
References: <20250829162212.208258-1-hannes@cmpxchg.org>
 <20250829162212.208258-2-hannes@cmpxchg.org>
 <r3dzlbqyvhaho5zuac7eba6pxz47zy3cz4lopxza3ls3ibadlh@6evm5aryyuxp>
 <20250909150156.GB1474@cmpxchg.org>
 <46xtfjznexpdlemxjwykin5k74oqomedb2fyli5jrb4xnquuke@ztcmxhmhlkx7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46xtfjznexpdlemxjwykin5k74oqomedb2fyli5jrb4xnquuke@ztcmxhmhlkx7>

On Tue, Sep 09, 2025 at 08:10:43PM +0000, Yosry Ahmed wrote:
> On Tue, Sep 09, 2025 at 04:01:56PM +0100, Johannes Weiner wrote:
> > On Fri, Sep 05, 2025 at 06:53:15PM +0000, Yosry Ahmed wrote:
> > > On Fri, Aug 29, 2025 at 05:15:26PM +0100, Johannes Weiner wrote:
> > > > zswap goes through the zpool layer to enable runtime-switching of
> > > > allocator backends for compressed data. However, since zbud and z3fold
> > > > were removed in 6.15, zsmalloc has been the only option available.
> > > > 
> > > > As such, the zpool indirection is unnecessary. Make zswap deal with
> > > > zsmalloc directly. This is comparable to zram, which also directly
> > > > interacts with zsmalloc and has never supported a different backend.
> > > > 
> > > > Note that this does not preclude future improvements and experiments
> > > > with different allocation strategies. Should it become necessary, it's
> > > > possible to provide an alternate implementation for the zsmalloc API,
> > > > selectable at compile time. However, zsmalloc is also rather mature
> > > > and feature rich, with years of widespread production exposure; it's
> > > > encouraged to make incremental improvements rather than fork it.
> > > > 
> > > > In any case, the complexity of runtime pluggability seems excessive
> > > > and unjustified at this time. Switch zswap to zsmalloc to remove the
> > > > last user of the zpool API.
> > > > 
> > > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > > > ---
> > > [..]
> > > > @@ -315,52 +292,29 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
> > > >  error:
> > > >  	if (pool->acomp_ctx)
> > > >  		free_percpu(pool->acomp_ctx);
> > > > -	if (pool->zpool)
> > > > -		zpool_destroy_pool(pool->zpool);
> > > > +	if (pool->zs_pool)
> > > > +		zs_destroy_pool(pool->zs_pool);
> > > >  	kfree(pool);
> > > >  	return NULL;
> > > >  }
> > > >  
> > > >  static struct zswap_pool *__zswap_pool_create_fallback(void)
> > > >  {
> > > > -	bool has_comp, has_zpool;
> > > > -
> > > > -	has_comp = crypto_has_acomp(zswap_compressor, 0, 0);
> > > > -	if (!has_comp && strcmp(zswap_compressor,
> > > > -				CONFIG_ZSWAP_COMPRESSOR_DEFAULT)) {
> > > > +	if (!crypto_has_acomp(zswap_compressor, 0, 0) &&
> > > > +	    strcmp(zswap_compressor, CONFIG_ZSWAP_COMPRESSOR_DEFAULT)) {
> > > >  		pr_err("compressor %s not available, using default %s\n",
> > > >  		       zswap_compressor, CONFIG_ZSWAP_COMPRESSOR_DEFAULT);
> > > >  		param_free_charp(&zswap_compressor);
> > > >  		zswap_compressor = CONFIG_ZSWAP_COMPRESSOR_DEFAULT;
> > > > -		has_comp = crypto_has_acomp(zswap_compressor, 0, 0);
> > > > -	}
> > > > -	if (!has_comp) {
> > > > -		pr_err("default compressor %s not available\n",
> > > > -		       zswap_compressor);
> > > > -		param_free_charp(&zswap_compressor);
> > > > -		zswap_compressor = ZSWAP_PARAM_UNSET;
> > > > -	}
> > > > -
> > > > -	has_zpool = zpool_has_pool(zswap_zpool_type);
> > > > -	if (!has_zpool && strcmp(zswap_zpool_type,
> > > > -				 CONFIG_ZSWAP_ZPOOL_DEFAULT)) {
> > > > -		pr_err("zpool %s not available, using default %s\n",
> > > > -		       zswap_zpool_type, CONFIG_ZSWAP_ZPOOL_DEFAULT);
> > > > -		param_free_charp(&zswap_zpool_type);
> > > > -		zswap_zpool_type = CONFIG_ZSWAP_ZPOOL_DEFAULT;
> > > > -		has_zpool = zpool_has_pool(zswap_zpool_type);
> > > > -	}
> > > > -	if (!has_zpool) {
> > > > -		pr_err("default zpool %s not available\n",
> > > > -		       zswap_zpool_type);
> > > > -		param_free_charp(&zswap_zpool_type);
> > > > -		zswap_zpool_type = ZSWAP_PARAM_UNSET;
> > > > +		if (!crypto_has_acomp(zswap_compressor, 0, 0)) {
> > > > +			pr_err("default compressor %s not available\n",
> > > > +			       zswap_compressor);
> > > > +			zswap_compressor = ZSWAP_PARAM_UNSET;
> > > > +			return NULL;
> > > > +		}
> > > 
> > > Hmm it seems like there may be a change of behavior here. If
> > > zswap_compressor == CONFIG_ZSWAP_COMPRESSOR_DEFAULT at the beginning and
> > > crypto_has_acomp() returns false, the old code will go into the second
> > > if (!has_comp) block, printing an error, freeing the string, and setting
> > > zswap_compressor to ZSWAP_PARAM_UNSET, then we eventually return NULL.
> > > 
> > > It seems like the new code will just call zswap_pool_create() anyway.
> > > 
> > > Am I missing something here?
> > 
> > I don't think that scenario is possible, due to the way the Kconfig
> > works. Whatever backend I select for CONFIG_ZSWAP_COMPRESSOR_DEFAULT
> > pulls in the crypto module as built-in/=y. It should always be there.
> 
> What if none of the CONFIG_ZSWAP_COMPRESSOR_DEFAULT_* options are
> selected (i.e. empty string)? Also, can CONFIG_ZSWAP_COMPRESSOR_DEFAULT
> be set directly to an arbitrary string?

No, that isn't possible. It's a multiple choice symbol that forces one
of the options and has a valid default value. I tried to made it an
empty string in .config by hand, but oldconfig restored it; if I
remove the DEFAULT_* line entirely, oldconfig reprompts.

> I would prefer if the code behavior did not change to rely on the config
> possibilities.

How about this on top?

From f842e1338594c4b78456f878731a261a074d5277 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Wed, 10 Sep 2025 09:00:01 -0400
Subject: [PATCH] yosry

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/zswap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/zswap.c b/mm/zswap.c
index c88ad61b232c..991fe380c61e 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -314,6 +314,10 @@ static struct zswap_pool *__zswap_pool_create_fallback(void)
 		}
 	}
 
+	/* Kconfig bug? */
+	if (WARN_ON(!crypto_has_acomp(zswap_compressor, 0, 0)))
+		return NULL;
+
 	return zswap_pool_create(zswap_compressor);
 }
 
-- 
2.51.0


