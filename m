Return-Path: <linux-kernel+bounces-853700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFAEBDC5CB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 05:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22FB819A0858
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1C229D289;
	Wed, 15 Oct 2025 03:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TKXT4ETs"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9704B1DE3A4
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760499531; cv=none; b=Za7Dzj2ML5bJIYmAkKdDH7Ve28WWH/tES1bbJaJPQU2gvCjuemcGuQtg7bkr5FE9rZYkOBn3kuWMiC5U3CbElW+abHC2cX2IGEu8kYAZt2x360muEQzAnKCzzr4soL80Vq8/+8RKPJ0s0ijbasJzNglrEJr04pfAzee/UIjl06k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760499531; c=relaxed/simple;
	bh=4wJt+gpoa406fX3ntwa3yiMH3j+kDH0t4mBuoWTLNIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hOXOSK64/CN3hzCOFK1vK0XXZKU8Qk1uwkRLJntVtEOv4c3va7iUESsKorDwnWWuL1+LIcpM8hQJHWbMY4Noe/wcY/t63yRS9wwjL9jiiYUdKq+7GTOZQyIibCIG5IN/5ijTC2C8rTJR8DDvEhdzmJFQ4UoiyV7ndFmlWIYEsPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TKXT4ETs; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3f2ae6fadb4so6726926f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 20:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760499528; x=1761104328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCkYlbRToLYdFFXJcENf2IQzzKVCQ6jcGYcB48CaRYU=;
        b=TKXT4ETsVo/AnWDGN4gTHQoOmppjqK6jJd4IbaqB3jQzKkng1GPFVuKYPjsEzs3izu
         f0g5GIRJRP09dg6PR2fH3SNPT2DpHHy5Oe+nQoqOE8FAQskbp7pxyyv2EHA6UaQkb9ca
         spBheRW0BDBunLF0LE020VRKogvx1KHqZBfAG00///Ne4f082Pn63JAiRqc0eeRjZbix
         Um3noxtz2cqwbUFZSJtB6XuYstLt3dLPznqBFGSQJeMhNflbnb5e1uCYQqoZU4h5ueNQ
         gq3daAy0kg4VLyj/wqeOCoITTleNisoliE8ZnsQ09tMFPMJIsN13fvSWQfAii3BwgVYt
         gWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760499528; x=1761104328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCkYlbRToLYdFFXJcENf2IQzzKVCQ6jcGYcB48CaRYU=;
        b=skfR1PzIruIeH8hnOkR39V2gNE3uNajiIkYMDYsF+c+qzBXR97caxFuPd2rxogunRt
         ujWYR9J4xi217LEiRq9Y4UsNrzXsTyFGEtYoWdjiaXnLh0f6M1df21+m30OQviIYFzpF
         4rTRiiyxUwBOBMzmlUkuZ+6YTt9d1OSvaRun0+8nNbNpsyHP0MTlJad1Ts0Ak5t7Ra/Z
         wI+zmJ1/Xy/+9Q20SUYzPaY43Bv0K4Div4XQE/IxrLuW7AlhXeqHp7mWRTAIpqVVrIdO
         AeV8RGHNfRr/DWWFbrARiLV1hTp25FRwAG4d3HMca9BoQ4qh+UGQ8MoaHnS5JTnYnAma
         e8jw==
X-Forwarded-Encrypted: i=1; AJvYcCWhohld0MMlui6ev6p8Kh2sD4e7ulNhEDjKpu+IGYxzP/O+SZKQPsoqrprMrPnszotmXbcKg4eU+MsaFkM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+W7TMN5FtP/syVxHmmD0G0UaZZFV4X69Y88JEKgwfANVjCVKP
	/K8sxAB41joMtaHcFF+QUuO5tsaAIqj+gSZQY6EQgreKr2fxAdKHtxf90nJyNrkLrQuiZxZK5BQ
	9xhPT/5q5xu9DfE8z9OlacLbPP9jwSStExyezYNvV
X-Gm-Gg: ASbGnctojLmDgxNtx+zK7mPLp+NPhuA6O5yNXuoGkarY/HGXlUVP7LNJOf61CdQ014Q
	JE4pfBTH8tu5u/LHe3UzpRbVNIPmCdgudy3Nngo1xiJilhxy/cW2yQeypXKi4zXXhspGSVKL3Ol
	dWfSOHJU0fqhon9O8lopQ0D+OCY769b2u2rj1eaooILNizM8by43VgamkNq7iIzyX9+VKUgUDr+
	uUL9baxGaasNnLKWD7bThuZiwUbbU65KqeRkwO5QPg=
X-Google-Smtp-Source: AGHT+IEXqrUaXr8DHCM+aI/npfJJzTlagvjXjvafVzIGuFHFtOvaU6LGphM/lgPuvpr67IHJYligctKwRWzsmwrMOL8=
X-Received: by 2002:a05:6000:3111:b0:425:825d:15d1 with SMTP id
 ffacd0b85a97d-4266e8db601mr19071351f8f.44.1760499527730; Tue, 14 Oct 2025
 20:38:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014191156.3836703-1-xur@google.com> <20251014191156.3836703-5-xur@google.com>
In-Reply-To: <20251014191156.3836703-5-xur@google.com>
From: Han Shen <shenhan@google.com>
Date: Tue, 14 Oct 2025 20:38:34 -0700
X-Gm-Features: AS18NWAAoTZwilsHeALUNIPooAM-rlbEq_tGr0S8vEjTAZ0hT02nDM65-kCnNvQ
Message-ID: <CACkGtrgWRJw2+KX_=Xww773ovYkjq-Bf4Sygo=Hgn86TM7VjLA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] kbuild: Add config to assert profile accuracy for
 aggressive optimization
To: xur@google.com
Cc: Alexey Gladkov <legion@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Bill Wendling <morbo@google.com>, Ingo Molnar <mingo@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <kees@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Tamir Duberstein <tamird@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Yabin Cui <yabinc@google.com>, Sriraman Tallam <tmsriram@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've verified patches 1-4, with the following configuration on X86_64 syste=
ms:

1. autofdo without profile (nothinlto)
2. autofdo with profile (nothinlto)
3. propeller only (noautofdo no thinlto) annotated
4. propeller only optimized (noautofdo nothinlto)

All the kernels boot up successfully.

Thanks,
Han



On Tue, Oct 14, 2025 at 12:12=E2=80=AFPM <xur@google.com> wrote:
>
> From: Rong Xu <xur@google.com>
>
> Adds a build config to AutoFDO to assert that the generated profile
> accurately represents the intended workload. This enables Clang to
> perform more aggressive optimizations.
>
> Signed-off-by: Rong Xu <xur@google.com>
> ---
>  arch/Kconfig             | 11 +++++++++++
>  scripts/Makefile.autofdo |  3 +++
>  2 files changed, 14 insertions(+)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index ebe08b9186adc..6fdc676cb0fe4 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -886,6 +886,17 @@ config AUTOFDO_CLANG
>
>           If unsure, say N.
>
> +config AUTOFDO_PROFILE_ACCURATE
> +       bool "Assert AutoFDO profile is accurate (EXPERIMENTAL)"
> +       depends on AUTOFDO_CLANG
> +       help
> +         This option asserts that the AutoFDO profile (specified
> +         in CLANG_AUTOFDO_PROFILE) is collected from a representative
> +         workload, allowing the Clang compiler to perform more
> +         aggressive optimizations.
> +
> +         If unsure, say N.
> +
>  config ARCH_SUPPORTS_PROPELLER_CLANG
>         bool
>
> diff --git a/scripts/Makefile.autofdo b/scripts/Makefile.autofdo
> index 5bcfcef273745..36abeae2accdc 100644
> --- a/scripts/Makefile.autofdo
> +++ b/scripts/Makefile.autofdo
> @@ -11,6 +11,9 @@ endif
>  ifdef CLANG_AUTOFDO_PROFILE
>    CFLAGS_AUTOFDO_CLANG +=3D -fprofile-sample-use=3D$(CLANG_AUTOFDO_PROFI=
LE) -ffunction-sections
>    CFLAGS_AUTOFDO_CLANG +=3D -fsplit-machine-functions
> +ifdef CONFIG_AUTOFDO_PROFILE_ACCURATE
> +  CFLAGS_AUTOFDO_CLANG +=3D -fprofile-sample-accurate
> +endif
>  endif
>
>  ifdef CONFIG_LTO_CLANG_THIN
> --
> 2.51.0.788.g6d19910ace-goog
>


--
Han Shen |  Software Engineer |  shenhan@google.com |  Sunnyvale California

