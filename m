Return-Path: <linux-kernel+bounces-808498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E919B50092
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4CD21C634F7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343E5322C66;
	Tue,  9 Sep 2025 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="CeN53NkP"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8814F226D1D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757430132; cv=none; b=Y9cmSPeY5RfqTQxQ2Kanwa9nA7tX77w8Wp2+XAuu+2CqgroGgoXJ7sZ5YWKHwN1CcqiDU5Ede9s2JIessJeuCD/EcEYuM8UQYthY7bY2KziCDZvZRRi8IkQL+PiBLgald3IuiRSKBmzGM/a3nD/On5Q4okd+CETUeCVhMVjGVyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757430132; c=relaxed/simple;
	bh=qoj7mzHYT9f1wy0zIuGFs5Y3sZ5ArqKmQOu/ZbfDY8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/w8oBZD8+3sY1mF5kgRpSK790+BjkkDjoxDbEKxum79IuCMnujW1ECOD+oHTdqGYogGn32Lj4mfFANhcq8JZ0Q/vElGRvMPTkrqyFDsdlpu8GpizW38iPwWBzvzGcI4BZD77+5S3bdeqcTC5YGtf7zMfWcrAIBEYieuFwq0QEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=CeN53NkP; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-7221ce7e814so46164466d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 08:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1757430128; x=1758034928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yh0fjNDYqjzdJxYcthmflSzVU8lAPQ437Tv8jqJmBNM=;
        b=CeN53NkPXCSrwkx18dHHJyrusFRAiIIvviYNB77R4zGm+W5l6wUHmmnlt0jLvRYPrP
         yIhQPSyGwzELEO6BBqQr0vWj1ofnUtUHvz+n85DdRk1U2BPsSYQArWWpa4pz7cu54YlV
         PpI9xzb7uzaO1vQC5zNkjqR5CyhfNIo8R7yDPtzwp1qR4xqAbRVwNdbvGEEXG2q901bW
         aduQelvgnaFdMFG13ACIopc02ke55r8znaIETeXYBvJROT5k7tHuiblylpIjaumAeWrE
         v/0NKZMlsm3j4UQuzX2vcqooa1oXqhFdf8j3fIN1MxF7JmjzrnPBhNPKLfny5o2yliUE
         jYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757430128; x=1758034928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yh0fjNDYqjzdJxYcthmflSzVU8lAPQ437Tv8jqJmBNM=;
        b=JXmwSNENAB/SNx0NY2+U1RPPyWN/r90RGWZ11ZI7+DD7jycxrbj/ukeYzZMffoUsPj
         z0M40/z33EOpB92dyaDX4ePmhdJxzLi+4ahfizjmNiwTSzXJTbH7eo7s+SHqQKOF9V7H
         F863Vqbx09YCYqgSwW0Pv9VebblWe8/R0FL5V5HFQtiBsO2yN9pn/Fr2XodqZ2/b3HNj
         dbFiNRlXhfDMqH8FKkHX8riRHPXMNNvf4Zf4REP++t6qtLv5Dwft4QU9W3Bqsd022M25
         wR0PeWdYiM6m/w3uh98Jrd8dTv29O8aOiLkG3inZvnTZuiJ3993My9FYJ4uWqUfMeAnc
         vMWA==
X-Forwarded-Encrypted: i=1; AJvYcCUwK20JQOE+8qAcTmfy5ZUUQrnqFs+ZPmcQ//entajcm8m1YTZvUFTwhejjYm+kA0U+7KX70UmL1qpaAY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNjhZMJZwPDmlNshX0FXMubBVbYTR0Fq1Ase52sk0y+zkpTejH
	0ahaM/d+9ARfYewgaasWWAWCJvYqwhaNw1Lrll6DquBZ6v0KZJCINilv6MbmdfPY++0=
X-Gm-Gg: ASbGncuYqZ1yE8Rfnok9PoMsaJyVL2WU4SfmMKq5fQIg3AFjb7KtjHWo5AzhpiwFUCr
	EbfmR4Go3/t5qc6nFbkK4YhnAO+u8U29fI0YPLmXI19Xx/n8QLclKXf+0ZWYrGp25TAY9cKSnQ0
	/wBIP2qcjc2J1XWWtM9u2ShH3CRgD8RBiaGwDtCADYrVRh71ib10Qsp5d1VZhkV0ZeqdnOFG+pG
	nBwJnn4f9Ctn5qQKzd8bsleufpWagjc3u5E2anSuTunedhyLxlzsFK8Vr1WdVNvn0rHfSRJ9i73
	CjRfQpKNL4Y0fRl4Pz/4WM7mAXiH2CqRkCXYkicgKL5wo5iHOy8hdSwQJSQJw3I88FmAf3blyYR
	c/Q==
X-Google-Smtp-Source: AGHT+IFOGeEWrEyaAhZ9HLZ8ljGlKxieYtI7L7qfboXpXt08DoBi9j/dcjK8l0X0zckOHyw5S1Wt3g==
X-Received: by 2002:ad4:5aa7:0:b0:729:4be4:7fdb with SMTP id 6a1803df08f44-739435d4633mr118482876d6.52.1757430127822;
        Tue, 09 Sep 2025 08:02:07 -0700 (PDT)
Received: from localhost ([2620:10d:c091:600::1ad8])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-727b2c047dcsm112542926d6.59.2025.09.09.08.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 08:02:06 -0700 (PDT)
Date: Tue, 9 Sep 2025 16:01:56 +0100
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: zswap: interact directly with zsmalloc
Message-ID: <20250909150156.GB1474@cmpxchg.org>
References: <20250829162212.208258-1-hannes@cmpxchg.org>
 <20250829162212.208258-2-hannes@cmpxchg.org>
 <r3dzlbqyvhaho5zuac7eba6pxz47zy3cz4lopxza3ls3ibadlh@6evm5aryyuxp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <r3dzlbqyvhaho5zuac7eba6pxz47zy3cz4lopxza3ls3ibadlh@6evm5aryyuxp>

On Fri, Sep 05, 2025 at 06:53:15PM +0000, Yosry Ahmed wrote:
> On Fri, Aug 29, 2025 at 05:15:26PM +0100, Johannes Weiner wrote:
> > zswap goes through the zpool layer to enable runtime-switching of
> > allocator backends for compressed data. However, since zbud and z3fold
> > were removed in 6.15, zsmalloc has been the only option available.
> > 
> > As such, the zpool indirection is unnecessary. Make zswap deal with
> > zsmalloc directly. This is comparable to zram, which also directly
> > interacts with zsmalloc and has never supported a different backend.
> > 
> > Note that this does not preclude future improvements and experiments
> > with different allocation strategies. Should it become necessary, it's
> > possible to provide an alternate implementation for the zsmalloc API,
> > selectable at compile time. However, zsmalloc is also rather mature
> > and feature rich, with years of widespread production exposure; it's
> > encouraged to make incremental improvements rather than fork it.
> > 
> > In any case, the complexity of runtime pluggability seems excessive
> > and unjustified at this time. Switch zswap to zsmalloc to remove the
> > last user of the zpool API.
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > ---
> [..]
> > @@ -315,52 +292,29 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
> >  error:
> >  	if (pool->acomp_ctx)
> >  		free_percpu(pool->acomp_ctx);
> > -	if (pool->zpool)
> > -		zpool_destroy_pool(pool->zpool);
> > +	if (pool->zs_pool)
> > +		zs_destroy_pool(pool->zs_pool);
> >  	kfree(pool);
> >  	return NULL;
> >  }
> >  
> >  static struct zswap_pool *__zswap_pool_create_fallback(void)
> >  {
> > -	bool has_comp, has_zpool;
> > -
> > -	has_comp = crypto_has_acomp(zswap_compressor, 0, 0);
> > -	if (!has_comp && strcmp(zswap_compressor,
> > -				CONFIG_ZSWAP_COMPRESSOR_DEFAULT)) {
> > +	if (!crypto_has_acomp(zswap_compressor, 0, 0) &&
> > +	    strcmp(zswap_compressor, CONFIG_ZSWAP_COMPRESSOR_DEFAULT)) {
> >  		pr_err("compressor %s not available, using default %s\n",
> >  		       zswap_compressor, CONFIG_ZSWAP_COMPRESSOR_DEFAULT);
> >  		param_free_charp(&zswap_compressor);
> >  		zswap_compressor = CONFIG_ZSWAP_COMPRESSOR_DEFAULT;
> > -		has_comp = crypto_has_acomp(zswap_compressor, 0, 0);
> > -	}
> > -	if (!has_comp) {
> > -		pr_err("default compressor %s not available\n",
> > -		       zswap_compressor);
> > -		param_free_charp(&zswap_compressor);
> > -		zswap_compressor = ZSWAP_PARAM_UNSET;
> > -	}
> > -
> > -	has_zpool = zpool_has_pool(zswap_zpool_type);
> > -	if (!has_zpool && strcmp(zswap_zpool_type,
> > -				 CONFIG_ZSWAP_ZPOOL_DEFAULT)) {
> > -		pr_err("zpool %s not available, using default %s\n",
> > -		       zswap_zpool_type, CONFIG_ZSWAP_ZPOOL_DEFAULT);
> > -		param_free_charp(&zswap_zpool_type);
> > -		zswap_zpool_type = CONFIG_ZSWAP_ZPOOL_DEFAULT;
> > -		has_zpool = zpool_has_pool(zswap_zpool_type);
> > -	}
> > -	if (!has_zpool) {
> > -		pr_err("default zpool %s not available\n",
> > -		       zswap_zpool_type);
> > -		param_free_charp(&zswap_zpool_type);
> > -		zswap_zpool_type = ZSWAP_PARAM_UNSET;
> > +		if (!crypto_has_acomp(zswap_compressor, 0, 0)) {
> > +			pr_err("default compressor %s not available\n",
> > +			       zswap_compressor);
> > +			zswap_compressor = ZSWAP_PARAM_UNSET;
> > +			return NULL;
> > +		}
> 
> Hmm it seems like there may be a change of behavior here. If
> zswap_compressor == CONFIG_ZSWAP_COMPRESSOR_DEFAULT at the beginning and
> crypto_has_acomp() returns false, the old code will go into the second
> if (!has_comp) block, printing an error, freeing the string, and setting
> zswap_compressor to ZSWAP_PARAM_UNSET, then we eventually return NULL.
> 
> It seems like the new code will just call zswap_pool_create() anyway.
> 
> Am I missing something here?

I don't think that scenario is possible, due to the way the Kconfig
works. Whatever backend I select for CONFIG_ZSWAP_COMPRESSOR_DEFAULT
pulls in the crypto module as built-in/=y. It should always be there.

