Return-Path: <linux-kernel+bounces-831162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E098B9BBC2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1327F4C322C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAE426E719;
	Wed, 24 Sep 2025 19:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BMIUtBiN"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ED926F28B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758742851; cv=none; b=O/pZ7Vg7RG15sbceGpuFb92W5hSGH9QXJR9esf5qpf5kJ2gdlmNBLGqxGt9T5mKIFigc1d6dLNr1q9kdJ0nUxE+qI3LoSGsd8ZugQ3KMZquGHKysj+GAUqmsyWcWwegigNzabUqTXBAXy6mUxAJgSUZZzyeX7k7gPpYwUU7SCiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758742851; c=relaxed/simple;
	bh=AFOZkj2TG0Be/KXXpalR/RLNcoDJKbSXopPQd3sWv2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a54mmRRS2WvtXNl155icwGodDH4o1Bi3uN0HsohMFdpquuJFNkRYYoj8HJ5mKMPzoIs4cmj0A3hB8qT2+le435pXhn33SgWxNcTXSjUEiDVp+iugr8VxOhu9hITSCrrQwqeya6Lm+3W7s4ChNRwXZlMSguqjQ4jRvKfTkpkuwMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BMIUtBiN; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b2e0513433bso34350066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1758742848; x=1759347648; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1+Zm+Mmot6AwL4K5F9sieXv45xvE31gzhvdEZdWA+A0=;
        b=BMIUtBiNSD9CkxYrFh1hD637x3Q+Z//aQDaqMhiAAYJZpZAPC0mj3hpte/DUG1OI/l
         xzjtcerdFJvypw9LOhYeZxUC5eXVAKIIHa51owx9AG5fKbifh2tqV8herBu5zcVhT+Lu
         Deb2BRCqzjViZTrE79ObMYjK2R7tvovgWmcp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758742848; x=1759347648;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1+Zm+Mmot6AwL4K5F9sieXv45xvE31gzhvdEZdWA+A0=;
        b=vb9VOZUmyux1ZCSt4ULM8tHjMNj4iqvXSyJxuDTqT0eKDum/2O5FYF2mOnohIfrwza
         q0VR0udNLEMHvXNuUT76iQhZR00rCEMaveQ8GYheA3P4XoePpUqupIn9ewtbaJpUgkHf
         DRZDXXKYnBny/QpfDx834Ro7FBmyc4q6XbxpBMNKCjQz2rIeeu2/WDJLT+KZJboHjVW7
         e38fs+o/cZpSW4eMFbJbNdbFKBBxcaxjfFGDHM4erCxR7KlIjsReSvjWZuFgowTfDif4
         EdtBeaSXcigx8ocIuiIx1PE8LY30f/faiE2QV2mw+YS2IcbFcaL+7qIrkjHvr7OQbG2S
         c6dw==
X-Forwarded-Encrypted: i=1; AJvYcCUEUUhYjrhSjpXAAif+hU5a5zYecZ8sKSRSmvl1f4Aatj2gDTA8XbnJcxZ64s45uqCDZEbPZke97NnnWYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwPwPlyGYlItPFWAjSyteixE0I0jepAmROreftHA2KN8tl+JNC
	7ouJSmUAHyX26wJ5Zv6Jcr1t4jRQ+re7V/QmvEWclN5jJc6UfsKlgUkBHICNEUqE5reddb2nVl9
	tGGxRZ2c=
X-Gm-Gg: ASbGncsmqGqU7pwhESCqTLY36wMrEOfV+HVMYdPT/ZEDZYumH60wJomRW4oAetz8/hr
	K2vzE5P5rw6h8PMA28492Od2xl3Z47NVu+fQ4E+idiyA+4hQYjt3sf+STbJcGSOx0SuSMaTAwzx
	NM/Q0yoVaFIg3QR/qi7fKuRjYEEtE/B+qDEv8jPj2PceyifzaDyxCboXkDEojIvEXKjVlsa79HZ
	0jiQHdDuVedXyu7pkTMtqqJbqvmeCFRY1JzaexCgq58HIVtw1oD6NcqIygPaseNCkuyi+z/Awmk
	OXQpcCkWH1xdfCmu1+1DYVfFYrcnsGsYYXt6SaIxx6Q7O+Uvl2VoV5fsITkK6nXVrbDmbICHwxG
	2vPYyH4N1x94OGZlWYRHyndRtRdVdvcNvSv6C0xNE69mMtvchXvTefaywS718wXmYt6AbhBTc
X-Google-Smtp-Source: AGHT+IGlnH4CsiLrd8GmkrlbohNPiqRxpiJ1gtPOm5tLDaoTkn+SVLtdX8pPIjOH3AmTjMQlVsiJBQ==
X-Received: by 2002:a17:907:9713:b0:b2e:4590:e8ba with SMTP id a640c23a62f3a-b34bd440ee1mr104483366b.40.1758742847644;
        Wed, 24 Sep 2025 12:40:47 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353fa65be9sm4392166b.48.2025.09.24.12.40.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 12:40:46 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62faeed4371so217133a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:40:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWzn539nENKZtAqQR1iJLcxqx52q1cCjA3F6i3iW/gCvThGt55153efw07rFJX3VZYkEp5Mmphgdb09+P4=@vger.kernel.org
X-Received: by 2002:a17:907:3e0d:b0:b28:b057:3958 with SMTP id
 a640c23a62f3a-b34be100c78mr100247466b.48.1758742845971; Wed, 24 Sep 2025
 12:40:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924192641.850903-1-ebiggers@kernel.org>
In-Reply-To: <20250924192641.850903-1-ebiggers@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 24 Sep 2025 12:40:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wieFY6__aPLEz_2mv-GG6-Utw9NQOLDzi4TF93xFAnCoQ@mail.gmail.com>
X-Gm-Features: AS18NWD9qiI7hge6j2kywiKpkeIcPfny81AeITA2ton2nw7pONLugyyBMzBP1WY
Message-ID: <CAHk-=wieFY6__aPLEz_2mv-GG6-Utw9NQOLDzi4TF93xFAnCoQ@mail.gmail.com>
Subject: Re: [PATCH] crypto: af_alg - Fix incorrect boolean values in af_alg_ctx
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Sept 2025 at 12:27, Eric Biggers <ebiggers@kernel.org> wrote:
>
> -       u32             more:1,
> -                       merge:1,
> -                       enc:1,
> -                       write:1,
> -                       init:1;
> +       bool more;
> +       bool merge;
> +       bool enc;
> +       bool write;
> +       bool init;

This actually packs horribly, since a 'bool' will take up a byte for
each, so now those five bits take up 8 bytes of storage (because the
five bytes will then cause the next field to have to be aligned too).

You could just keep the bitfield format, but change the 'u32' to
'bool' and get the best of both worlds, ie just do something like

-       u32             more:1,
+       bool             more:1,

and now you get the bit packing _and_ the automatic bool behavior.

           Linus

