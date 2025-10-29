Return-Path: <linux-kernel+bounces-876907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CD627C1CB4E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8DFD54E041E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27ABE350D6B;
	Wed, 29 Oct 2025 18:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ontVBKK+"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5F332E732
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 18:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761761475; cv=none; b=oNiUFZ0K/gN8KJFjqGrjo1bQzpCMgrNvpzjvKfQzXdM4DRQz4ImnJhYqNz8d4bm6/3Rhl8C3hmU1vLuCpJS4JZvuGkTp6z9xgBry9g9131tp73c3/jrSSWC4avAUgV7YyoJ1oxEOo9NXKGUFH3E4zhbeafLxnRp8OPV+jZLpFGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761761475; c=relaxed/simple;
	bh=PS/7n9x0SP2BZyrHR1BTFixdmeri6N4egFYDeinoFag=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ec/tQRnS5nlkfpURMy9Ih5cqsX2B2qlBX7Ug8mxCcc/8YcXpQ3aisaY/m4pxZkcPEmez2EgPHt/tLguolrxcBH6soqhyBI+kreERKhdANtreRVwqUss5QxCRiTpwjLb9wrC9OS2gPibxOkEA3GbXOlC7Z5TlM1AzowJcR2eq9rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ontVBKK+; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-87d8fa51993so2805586d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761761472; x=1762366272; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IwNfSf4EgKsKIKvP8jeDid+9LUvLVTcCHffdJ2kF0dI=;
        b=ontVBKK+iz0CmwtStWZOtGZPwbo4yPsOKQ2UfQqVl63MB3gAvW9/DOVQoRladYxRDe
         +E/xHXil+Jj4mw6IJ+lF1nwtLDt947JwQB+oPts2dzYSZ8caNf6qhlcskIjefqGsH4RX
         XT6LvB1fm8w0EMoWa4BfiBGG6R2cnDeIcgk0GtnoIMW9QC1HIQRLMIWcW2aL4byGUozn
         jgKW8sb24DwJZsCeVy3il2B/PY0RIIcUdEPCuxwFh8dbo+zveY1OhrcCBGyhzaAcCGWQ
         Lp6oRIvXp9SX20ZVhoW9q1mXXp6W1laop6zpN8WtVU8sGxy7P8XFCMbWf2KVo2/wjcbK
         S1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761761472; x=1762366272;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IwNfSf4EgKsKIKvP8jeDid+9LUvLVTcCHffdJ2kF0dI=;
        b=oS4KNX53ad/EaLMhbe2SjInCUb5MFy4Iiu7wClM43aC4Z8NwpSzqrbKSBCw/BmSLGW
         maSZTiDpj7dU5gfZ+ZBmohq5+J8+2NI9uZf2QqZZlYo5XJi0nXNe6sBDfKPUfGS1ZvLX
         EYBtF0Y+5Qa85iiBGsLitKVKXlyDOX2GXhYWdfiYSp88K4z7GtPW+0gE81n4V1RJpzrx
         9eJD/cqyprqw2IzEs2ulSliX9hJu/anA2BZ0rEgfS6tWH+FAuXhwch+FKo3yqNnva9gZ
         VJJcMjbVbnZdaEtnZNuvDUUifmdBu9us7S5VZZk4Q4Eu/uthMpA1QL4HuhlvS1OUAtaU
         GLEg==
X-Forwarded-Encrypted: i=1; AJvYcCXKM8kW8ItaT6H1MraHBnHQIBkubOqvpWTycvfqP3kJVhUb3LrTDc6EDKwUTSPTEO+5PiqaZfShwwJRucY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy719WpNmClO1edvQGy9rkhox1WEwhfvXpEnYmePcpMWgJAU861
	8ZwjeTTDIrlorFpQr1TGmFDYfN4KCP61mSh9oyfUCw2XNFyjYae5nGq67npnJdnI+64=
X-Gm-Gg: ASbGncuE8+4HhgrdXY2q7aSp8UFcuJqPqNN31jMGICUQrUk56BjTE1ZrIuIKWqN9QH1
	kO3qjoYKFHNDuc3fhugORdyv9vGMRIV5W+anoHpTbMX5Sni/mkTffQnIcl61wKOgFpCXKNcmbtR
	pyE3QGV8vZSDkC36bVbQCqaKUQJ9DT4uUkkF31fhnR3LmSpAPNxnhY9i+UklqJHOCN9RqH6joln
	kEJ6Z3s1dAxUIhJL9y2ntfcj0pMkZ0xGG36/dD/BtFRDfae3s30zfA2VFcIZapG7P2mqRf2j11L
	izOJmaHYDd2av6fedjT9CK5hqmesy/0hyK4Av/OgikOeW5ap+cHUVCU/tFGEwKqLK0WHmHeLSwX
	h+p/u989Juxw+TjotmMklAzqFbZwhdr2097wOmqm53YsPlS3y1dvexkf7rMuMzZwxOTEfXymZFW
	7CkrYAWLZdvCUDfUmZqPBuUkmo1clZtw==
X-Google-Smtp-Source: AGHT+IHl90kl2owsJeOf3MGXe9B7WDc4ExJecfPXPhnl5lX6ZQAJM8lViEHT5OvHkk2RcyzqXPL/tw==
X-Received: by 2002:a05:6214:20c4:b0:86b:4ffa:a8b2 with SMTP id 6a1803df08f44-88009b2d2acmr53413306d6.22.1761761470605;
        Wed, 29 Oct 2025 11:11:10 -0700 (PDT)
Received: from xanadu (modemcable048.4-80-70.mc.videotron.ca. [70.80.4.48])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc48e37c3sm101967766d6.22.2025.10.29.11.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 11:11:09 -0700 (PDT)
Date: Wed, 29 Oct 2025 14:11:08 -0400 (EDT)
From: Nicolas Pitre <npitre@baylibre.com>
To: David Laight <david.laight.linux@gmail.com>
cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
    u.kleine-koenig@baylibre.com, Oleg Nesterov <oleg@redhat.com>, 
    Peter Zijlstra <peterz@infradead.org>, 
    Biju Das <biju.das.jz@bp.renesas.com>, Borislav Petkov <bp@alien8.de>, 
    Dave Hansen <dave.hansen@linux.intel.com>, 
    "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
    Thomas Gleixner <tglx@linutronix.de>, Li RongQing <lirongqing@baidu.com>, 
    Yu Kuai <yukuai3@huawei.com>, Khazhismel Kumykov <khazhy@chromium.org>, 
    Jens Axboe <axboe@kernel.dk>, x86@kernel.org
Subject: Re: [PATCH v4 next 3/9] lib: mul_u64_u64_div_u64() simplify check
 for a 64bit product
In-Reply-To: <20251029173828.3682-4-david.laight.linux@gmail.com>
Message-ID: <26p1nq66-8pq5-3655-r7n5-102o989391s2@onlyvoer.pbz>
References: <20251029173828.3682-1-david.laight.linux@gmail.com> <20251029173828.3682-4-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 29 Oct 2025, David Laight wrote:

> If the product is only 64bits div64_u64() can be used for the divide.
> Replace the pre-multiply check (ilog2(a) + ilog2(b) <= 62) with a
> simple post-multiply check that the high 64bits are zero.
> 
> This has the advantage of being simpler, more accurate and less code.
> It will always be faster when the product is larger than 64bits.
> 
> Most 64bit cpu have a native 64x64=128 bit multiply, this is needed
> (for the low 64bits) even when div64_u64() is called - so the early
> check gains nothing and is just extra code.
> 
> 32bit cpu will need a compare (etc) to generate the 64bit ilog2()
> from two 32bit bit scans - so that is non-trivial.
> (Never mind the mess of x86's 'bsr' and any oddball cpu without
> fast bit-scan instructions.)
> Whereas the additional instructions for the 128bit multiply result
> are pretty much one multiply and two adds (typically the 'adc $0,%reg'
> can be run in parallel with the instruction that follows).
> 
> The only outliers are 64bit systems without 128bit mutiply and
> simple in order 32bit ones with fast bit scan but needing extra
> instructions to get the high bits of the multiply result.
> I doubt it makes much difference to either, the latter is definitely
> not mainstream.
> 
> If anyone is worried about the analysis they can look at the
> generated code for x86 (especially when cmov isn't used).
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>

Comment below.


> ---
> 
> Split from patch 3 for v2, unchanged since.
> 
>  lib/math/div64.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/math/div64.c b/lib/math/div64.c
> index 1092f41e878e..7158d141b6e9 100644
> --- a/lib/math/div64.c
> +++ b/lib/math/div64.c
> @@ -186,9 +186,6 @@ EXPORT_SYMBOL(iter_div_u64_rem);
>  #ifndef mul_u64_u64_div_u64
>  u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 d)
>  {
> -	if (ilog2(a) + ilog2(b) <= 62)
> -		return div64_u64(a * b, d);
> -
>  #if defined(__SIZEOF_INT128__)
>  
>  	/* native 64x64=128 bits multiplication */
> @@ -224,6 +221,9 @@ u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 d)
>  		return ~0ULL;
>  	}
>  
> +	if (!n_hi)
> +		return div64_u64(n_lo, d);

I'd move this before the overflow test. If this is to be taken then 
you'll save one test. same cost otherwise.


