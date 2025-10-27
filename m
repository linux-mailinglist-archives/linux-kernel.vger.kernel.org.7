Return-Path: <linux-kernel+bounces-871024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB5AC0C44A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E8F53A8E0D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB9624E4BD;
	Mon, 27 Oct 2025 08:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLjnx9JV"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CEF2E54B3
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761552839; cv=none; b=frwBA+UZKAddBTGXatkgbDMcGo2aZR6VUW7zGkoa14kXOuZYMbY4wJvQyzm7+XnbrkHC44KlxIlJUdaRi6wluSjLL7xNxSLctI1Bmgi7H6nsJa+Xz6RCXXfdYyViLipEdB1Jzw2MT8fcVle8VNS5jv6tKzZPk2CfNJj2iL1kdMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761552839; c=relaxed/simple;
	bh=enS/F6mN1iHfHpS53q6f936aFCD+XV9LLSTHe1AVNh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQHDnb4x3WSH3dfdNJ3V0o61PnUG/nH8DvfRe1K81rvfkEv8wjeYYNi6xw2fGFgiaBTExREzoVqO5tzqRF4eLP2V/OkzWnnwAckHEaM4XAFQzn5xjs9zfhGt4ozuIPnwJ6/r3R3wsotzc16NWXLxtUNHiVRoX8uoZiYg2G+DXTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLjnx9JV; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b6cf1a95273so3168410a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761552837; x=1762157637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V0QVTefXgNzUye+HI/uLqeIzUYn06juse2TNOrMfCso=;
        b=dLjnx9JVbi2DWq8aIjYOm/OqOWbVekm6um+Nmzdq5HKjP9KEwrHILIytPxlVaq8dlv
         5tjh3l++Eq8N1MrHB/haUcCWm56oaJw00BBG8wGTlJfAl9rtBw7UNiiDUU5MgUR0LP80
         x8pXGGk1g8jkhx3aoS3yunUHOuEQEzhGoHfuUcjLjryFa/FfjNvkq3pmLFPI157k8A7V
         ZhX3ElCWAPatGvXi7Q3ex7ojQ4E52qHkcFTg5Avjli8ibqBq97Wa9JxOmFLXcBL8phpF
         5+h396stlOUef+0fLkvKma2q9xXUUT522VMOwANehIu8Np6y2w82HjJD8CqxlzuWB0jd
         dLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761552837; x=1762157637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0QVTefXgNzUye+HI/uLqeIzUYn06juse2TNOrMfCso=;
        b=JekAcnUYP8cFUB4gQ6dFbkS8ojFWq5eBypwY9a8edDqDEb4qhyv0kao6VXgSACle+q
         cRQFMigRvyeMbWUalbS8b88+jZ11M3ceDVMJ0JK4y7vgTmSYomdYo2wofCx0Ayn9pM5M
         +W52Mn0/Co7zYui6JJJXStYdQmAQ7YY/WGr8o4iVoEcwdsNLpgn0hjaLAn32Ucvj1miF
         +AjqwOJOd3DPHdFwf+nKje3KLhBgrtEzUPMpwez8pV5ruAWBa+wP8L5c4F3bX48iyelB
         zlnpM/+y0hoOGGYeyaZ3YlY7O6plu4DXdge6qYt0Y7iVt3sRh8Cs2nFVn/zu8yeNff7i
         MKBg==
X-Forwarded-Encrypted: i=1; AJvYcCUETz+c5D5+E73VdLyyJAl11OCmS07sLzV7K5n+R3LsZkJ3YhbOpH0Rv6g+qKFhKeHrl6XdQhJH7g2FOXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzdrZCsKsnbjcOtmL9LDAS6GDroqM+T8p+c8gIfuS2ylnGSwzo
	syCkNi2tz2X0ajk8lzwCW1ptQSe1mhnbKxnFsA5pe2P4GrnUZfNbQWy0
X-Gm-Gg: ASbGnctLHVcPtEDVqxPi99FDOZa5z8C/JENpagzGPkoj0vzrn34CQADheTge6U6wJRO
	skGQANUUrKacGfuY+6+b9QF6kkoPf31m6SGkJsA0yFYgNvccQeVKWYy2haU8N3bEmTmslHF8nJT
	VXyzH1Gs3sPPv+Fde3F5YctZ4Cw206nFwurFW8Pa7IkOATw+D6DwkGBMBRGkL3Z2QAO/AEzp3YG
	6rGjeEmeA6ynhcoNbctOT3YE0rG/zxPY876R7YnAl9BSA/Uw17f1P+6zkFs0x9M6F/5Eq7YOPoA
	qgQ9XDa7fVuxzKgV6V8/QESmne1Nfd9DSgbRa5PCLavkqgxDlFsFCHslfd/Ci/w9Rf7sZcPPZzY
	duSNtJWYz26C3Nd1jmsxF4D4+FNT+9HS8TMP38/FQw7BVZDG03Ay3i8pUNiflmIuCDsdN3C8SLn
	RQWbzThVyDpudniOlykQ==
X-Google-Smtp-Source: AGHT+IEVkaehq6w2UKlI/xDGgXeyzB7DjUNszWthMqA1V/wFsKy6bxNgILVs/1a7HtyhVDlBCVbqqw==
X-Received: by 2002:a17:902:f550:b0:275:81ca:2c5 with SMTP id d9443c01a7336-290cba42439mr525901875ad.59.1761552836923;
        Mon, 27 Oct 2025 01:13:56 -0700 (PDT)
Received: from google.com ([2401:fa00:95:201:5608:417e:ee8f:7ab8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d4253dsm73593165ad.83.2025.10.27.01.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 01:13:56 -0700 (PDT)
Date: Mon, 27 Oct 2025 16:13:53 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: linux@treblig.org
Cc: akpm@linux-foundation.org, hch@lst.de, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] lib/xxhash: remove more unused xxh functions
Message-ID: <aP8pwXISYx2l4uhK@google.com>
References: <20251024205120.454508-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024205120.454508-1-linux@treblig.org>

On Fri, Oct 24, 2025 at 09:51:20PM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> xxh32_reset() and xxh32_copy_state() are unused, and with those gone,
> the xxh32_state struct is also unused.
> 
> xxh64_copy_state() is also unused.
> 
> Remove them all.
> 
> (Also fixes a comment above the xxh64_state that referred to it as
> xxh32_state).
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

FWIW,

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Regards,
Kuan-Wei

> ---
>  include/linux/xxhash.h | 46 +-----------------------------------------
>  lib/xxhash.c           | 29 --------------------------
>  2 files changed, 1 insertion(+), 74 deletions(-)
> 
> diff --git a/include/linux/xxhash.h b/include/linux/xxhash.h
> index 27f57eca8cb1..587122e2c29c 100644
> --- a/include/linux/xxhash.h
> +++ b/include/linux/xxhash.h
> @@ -141,21 +141,7 @@ static inline unsigned long xxhash(const void *input, size_t length,
>   */
>  
>  /**
> - * struct xxh32_state - private xxh32 state, do not use members directly
> - */
> -struct xxh32_state {
> -	uint32_t total_len_32;
> -	uint32_t large_len;
> -	uint32_t v1;
> -	uint32_t v2;
> -	uint32_t v3;
> -	uint32_t v4;
> -	uint32_t mem32[4];
> -	uint32_t memsize;
> -};
> -
> -/**
> - * struct xxh32_state - private xxh64 state, do not use members directly
> + * struct xxh64_state - private xxh64 state, do not use members directly
>   */
>  struct xxh64_state {
>  	uint64_t total_len;
> @@ -167,16 +153,6 @@ struct xxh64_state {
>  	uint32_t memsize;
>  };
>  
> -/**
> - * xxh32_reset() - reset the xxh32 state to start a new hashing operation
> - *
> - * @state: The xxh32 state to reset.
> - * @seed:  Initialize the hash state with this seed.
> - *
> - * Call this function on any xxh32_state to prepare for a new hashing operation.
> - */
> -void xxh32_reset(struct xxh32_state *state, uint32_t seed);
> -
>  /**
>   * xxh64_reset() - reset the xxh64 state to start a new hashing operation
>   *
> @@ -210,24 +186,4 @@ int xxh64_update(struct xxh64_state *state, const void *input, size_t length);
>   */
>  uint64_t xxh64_digest(const struct xxh64_state *state);
>  
> -/*-**************************
> - * Utils
> - ***************************/
> -
> -/**
> - * xxh32_copy_state() - copy the source state into the destination state
> - *
> - * @src: The source xxh32 state.
> - * @dst: The destination xxh32 state.
> - */
> -void xxh32_copy_state(struct xxh32_state *dst, const struct xxh32_state *src);
> -
> -/**
> - * xxh64_copy_state() - copy the source state into the destination state
> - *
> - * @src: The source xxh64 state.
> - * @dst: The destination xxh64 state.
> - */
> -void xxh64_copy_state(struct xxh64_state *dst, const struct xxh64_state *src);
> -
>  #endif /* XXHASH_H */
> diff --git a/lib/xxhash.c b/lib/xxhash.c
> index cf629766f376..4125b3e3cf7f 100644
> --- a/lib/xxhash.c
> +++ b/lib/xxhash.c
> @@ -73,21 +73,6 @@ static const uint64_t PRIME64_3 =  1609587929392839161ULL;
>  static const uint64_t PRIME64_4 =  9650029242287828579ULL;
>  static const uint64_t PRIME64_5 =  2870177450012600261ULL;
>  
> -/*-**************************
> - *  Utils
> - ***************************/
> -void xxh32_copy_state(struct xxh32_state *dst, const struct xxh32_state *src)
> -{
> -	memcpy(dst, src, sizeof(*dst));
> -}
> -EXPORT_SYMBOL(xxh32_copy_state);
> -
> -void xxh64_copy_state(struct xxh64_state *dst, const struct xxh64_state *src)
> -{
> -	memcpy(dst, src, sizeof(*dst));
> -}
> -EXPORT_SYMBOL(xxh64_copy_state);
> -
>  /*-***************************
>   * Simple Hash Functions
>   ****************************/
> @@ -239,20 +224,6 @@ EXPORT_SYMBOL(xxh64);
>  /*-**************************************************
>   * Advanced Hash Functions
>   ***************************************************/
> -void xxh32_reset(struct xxh32_state *statePtr, const uint32_t seed)
> -{
> -	/* use a local state for memcpy() to avoid strict-aliasing warnings */
> -	struct xxh32_state state;
> -
> -	memset(&state, 0, sizeof(state));
> -	state.v1 = seed + PRIME32_1 + PRIME32_2;
> -	state.v2 = seed + PRIME32_2;
> -	state.v3 = seed + 0;
> -	state.v4 = seed - PRIME32_1;
> -	memcpy(statePtr, &state, sizeof(state));
> -}
> -EXPORT_SYMBOL(xxh32_reset);
> -
>  void xxh64_reset(struct xxh64_state *statePtr, const uint64_t seed)
>  {
>  	/* use a local state for memcpy() to avoid strict-aliasing warnings */
> -- 
> 2.51.0
> 
> 

