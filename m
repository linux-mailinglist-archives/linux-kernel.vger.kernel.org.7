Return-Path: <linux-kernel+bounces-747869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84835B13955
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C129E189A7D8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B570424EA80;
	Mon, 28 Jul 2025 10:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PozsuNcv"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA08246BAF
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753700142; cv=none; b=sRGk1wdMufScALWThFMF+XI9YpduOSECFD8S1dtUrWGemdavPaLg2W2cB0xQhTFFSlz/xD1Sthzld7bLuF3nPQzJ1/IKvQSlNzEdrUWw47TAe7Y+cM7UieXnNUh14VfJueQBzlAgHz7N2X9024FenqiiD+ChPqcvcjoqm7g1EL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753700142; c=relaxed/simple;
	bh=T3yVWyLqsLby4OnM5n5I2GurkAPr7cuQQb0vT9XHXzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qiiaVrnP0RshXztqINn+LaEWEA5m5jPqTruZQQl0bY52CQNKwmjntRe9ujpFSQlWdoyIm//s5xfwFeNZatMaNfn+GAFQXEz7DOTdLc01B/ms/GoJjnqGHz1sATctca8CB/jq1UGYqzMGl2wKrF3QeiFmG04OqTX+HodsEfnJ514=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PozsuNcv; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3137c20213cso4153567a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 03:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753700140; x=1754304940; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Adsk8sZq9q3h5/nndLVo9ECCof8eNE45Q3IOI8YE3aM=;
        b=PozsuNcvKYkRcrzRuKFMywZDPNQ3XAcYiXyJrxgsbTKN7Se3hb+8OVtg3FA5UZC6X0
         0G5At5370gbMlRsfIzwcW3R9rOhVghXL0wMo0jy4BT/WAytuVyj4C0btn8+cb8Ff+4Rt
         /h19aJP+9AuH+7o2o09GJ0YUgnyq5iHQJH43XARLAQgs4rheveXO3azZ+5GwlPR2k2+z
         topUxK9bn8CZsZXM3WyQ1nuCFvQupmaoLh9eaYLj5pN0ifDjNwDQCKVLLYvIlUxalupA
         eWKqbY7cibov0fr2ZFhs/YZPKzIRGRYfTX/SXw8MeOCMQWTKaauSX1ZKL7p6CLMfMe71
         5uqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753700140; x=1754304940;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Adsk8sZq9q3h5/nndLVo9ECCof8eNE45Q3IOI8YE3aM=;
        b=VXjYYMf3TgVemT9OjARMmXe+6Pw3jrIbe9Azbcyk0ygsMlxbyzERjrTx67uSku0RZ6
         ErnH1EF7FjuDMq4Voiqe+z6N5W9IXkrmtz478jOkVMBpRJj2mlrV8HZyll/yRGjgg8sO
         vfmsmo++v1DeheyKD2Z7yVQ5q3z4DlYazCx5zLirdc2shTrK0wRh8ALaUiYB4/KNRLTR
         dDSmvraBe27yeFdaqI5o8ux2umLmYgqRNrYPJSrIA7hGMNgkI0SQg8y/5bf9+w9UAp3o
         IwiL2x1dNoCusW5RV6+WMf7FUlpDgGMu83lpzIVSxMMt8l8JBJHKsBrzaGnXlqsol//N
         hNPw==
X-Forwarded-Encrypted: i=1; AJvYcCXAYFSJcJ4BnwqtomLtHsl8rZRQ4/AtRdDGI1vyo1SN6gZqDePBvMc9jFdO+Tio7LYJeyqohlz3c6tlRXk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2DyHXh/Rq21LrYfYTlTN4qvscR0X5JqRqbRtdWDpyes9QRS9x
	WWOGOAQ4tjTlDfmybNJIIdusHvBHvXF24Dm/CaLCzA2ocpRDPaXY4/5Ok/zMGCC/E0k7p7YAd6T
	KcE4NH4ww7EzoQM9M8/lrZP+N7X6mCqthJ1TFaoUR
X-Gm-Gg: ASbGncs7pOALVptwA1JIFEngW+1VO6n33GRdiUTw8vG5HpyUwzMcLGlSN8q0CwxlWmx
	9Q9ZgSKO2RbIVI/Mc1dDtP4CHhuRp8gkbX70poJVKFQffmmWBTa/e5lnxnKIyMMHpt8wRKFtUF5
	SaNPF+nDwhdBVanHQLoOd7CTlhZ98Zn99XhBpxGoFikSbjV7N9gRnSNPghd7xCYKi1AIU7Bz5VZ
	R4fvOQVrRkndvSHC6ThWnH29VGhZeOBAnf7hgY=
X-Google-Smtp-Source: AGHT+IF7MUuluWh/tPkYh48F9HQt6qlgnz5zHSAe1liO/KN0LO7XylyhxU89wQ89Tv6910OZiq3r1F7PERYaOPl8sMk=
X-Received: by 2002:a17:90b:2fcb:b0:31f:168f:c0b5 with SMTP id
 98e67ed59e1d1-31f168fc27fmr749827a91.30.1753700139773; Mon, 28 Jul 2025
 03:55:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728104327.48469-1-jogidishank503@gmail.com>
In-Reply-To: <20250728104327.48469-1-jogidishank503@gmail.com>
From: Marco Elver <elver@google.com>
Date: Mon, 28 Jul 2025 12:55:03 +0200
X-Gm-Features: Ac12FXyBK8DcCBqGyQPdxNkl9Qg0JHmvrSElApqOqMPaILY5OOBqZMtidrJDC3o
Message-ID: <CANpmjNN-xAqYrPUoC5Vka=uohtJzhOfJsD9hhqhPJzQGt=CHGQ@mail.gmail.com>
Subject: Re: [PATCH] kcsan: clean up redundant empty macro arguments in atomic ops.
To: Dishank Jogi <jogidishank503@gmail.com>
Cc: dvyukov@google.com, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, rathod.darshan.0896@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Jul 2025 at 12:43, Dishank Jogi <jogidishank503@gmail.com> wrote:
>
> ---------------------------------------------------------
>
> - Removed unnecessary trailing commas from DEFINE_TSAN_ATOMIC_RMW() macro
>   calls within DEFINE_TSAN_ATOMIC_OPS() in kernel/kcsan/core.c
>
> - It passes checkpatch.pl with no errors or warnings and
>   introduces no functional changes.
>
> ---------------------------------------------------------
>
> Signed-off-by: Dishank Jogi <jogidishank503@gmail.com>

Nack.

Did you compile the kernel with this?

> ---
>  kernel/kcsan/core.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> index 8a7baf4e332e..f2ec7fa4a44d 100644
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -1257,12 +1257,12 @@ static __always_inline void kcsan_atomic_builtin_memorder(int memorder)
>  #define DEFINE_TSAN_ATOMIC_OPS(bits)                                                               \
>         DEFINE_TSAN_ATOMIC_LOAD_STORE(bits);                                                       \
>         DEFINE_TSAN_ATOMIC_RMW(exchange, bits, _n);                                                \
> -       DEFINE_TSAN_ATOMIC_RMW(fetch_add, bits, );                                                 \
> -       DEFINE_TSAN_ATOMIC_RMW(fetch_sub, bits, );                                                 \
> -       DEFINE_TSAN_ATOMIC_RMW(fetch_and, bits, );                                                 \
> -       DEFINE_TSAN_ATOMIC_RMW(fetch_or, bits, );                                                  \
> -       DEFINE_TSAN_ATOMIC_RMW(fetch_xor, bits, );                                                 \
> -       DEFINE_TSAN_ATOMIC_RMW(fetch_nand, bits, );                                                \
> +       DEFINE_TSAN_ATOMIC_RMW(fetch_add, bits);                                                 \
> +       DEFINE_TSAN_ATOMIC_RMW(fetch_sub, bits);                                                 \
> +       DEFINE_TSAN_ATOMIC_RMW(fetch_and, bits);                                                 \
> +       DEFINE_TSAN_ATOMIC_RMW(fetch_or, bits);                                                  \
> +       DEFINE_TSAN_ATOMIC_RMW(fetch_xor, bits);                                                 \
> +       DEFINE_TSAN_ATOMIC_RMW(fetch_nand, bits);                                                \
>         DEFINE_TSAN_ATOMIC_CMPXCHG(bits, strong, 0);                                               \
>         DEFINE_TSAN_ATOMIC_CMPXCHG(bits, weak, 1);                                                 \
>         DEFINE_TSAN_ATOMIC_CMPXCHG_VAL(bits)
> --
> 2.43.0
>

