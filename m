Return-Path: <linux-kernel+bounces-758167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B2BB1CBE1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14D017AA7E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 18:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E13328DEE1;
	Wed,  6 Aug 2025 18:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4rDuf4/"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200DC26CE13
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 18:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754504689; cv=none; b=unbASvGmQifAh9Pw3kGoQw4QJtfnszYLPtfniD4ZI7HJdmZOs48KF2CDhvWugr75JCMvmJBeFqEb3BB2Pgj4thZKduirfuir0R+dBi5ubkn2w5WR0AWhFUfSUJRPjx6u6cvd0VAzMVRI5NBacxuTuEYlEjesKYT2HetVHXm8ejE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754504689; c=relaxed/simple;
	bh=f6yxQ2gQsQor871N/yqTOIwNuZ8L2WbH+4dUAORaV1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHH59VqnX1j0Xekoo2unLaCU/mY7kNljmh8BCiHEWuM2PaU5trvv0UJcyLiiw21AgqIMMxBs4TnE6uTlDJd05bQrTjBZHg3PhgeYXj4W7u03hvRZVFr96Y6AFnpnGqw5Njr2IsJAAJTv2DyLEOFUNWbN1CCcn/o3na9qm+TkQ1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4rDuf4/; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55b88369530so236984e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 11:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754504686; x=1755109486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jzfnt4fl4r2JAvr3EQAhX7jF93WfuTFzsNkMkN0wipE=;
        b=j4rDuf4/4D1DIoENghPEDBRpUbTH1KP3fkuzUAtb+n83AtRKPCdHQWaCeXm4eCmyZV
         fmkgktzRdFCyQfcHSKXAYYeU9Xbm913odwonveF0pNff84NucK5qwNaEs0Zw24enXcTB
         Hj4aM8smGFJacxGnZZ5S6cmNgFS7FpJQmlNG/mrnMf00YbLJ76TKxyRcMZG6yn0XC2Pl
         IFcaIuOWXTnMXvdAdXAd3bt7fkl0lwxqITHxqihfoIX4l7d3LbW7lFloum8Yda8UvSM5
         bz3GhPKOjqXv0p+IpLWZYFTjOUpvdVl3do2BnHtSd6ZlWh90YtkS+atLS0gnXhtHnj3U
         jg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754504686; x=1755109486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jzfnt4fl4r2JAvr3EQAhX7jF93WfuTFzsNkMkN0wipE=;
        b=iKAvZEzEI/KIPZ/eimDpvUVBiISIWQ0jUmzB7ZbaBDcBFVA71tUSh1AsEE2zj8bp3U
         gayPJ5dl9IM17VWN6+epVQfKzlpA2UqaZwYuh2FlmGeAFJZGk1FmgZUBKRjxGxt/NLiO
         wJnUfUg5HC6wx5LJqDnD244v7NXMMUx3Pi+K5sJmSI6uog2QuQ2ziY69X6iRU/gj+8EJ
         ieWUKTfGNgje/yUKZhDWUXSMern8hIojLBohv2ZBLQlsII8nG4EEJsn5FN4pNRQjDOt1
         pBWHsVFq9HkS2Ki8Bjq/JuzHGuDuiYoCURyXhLwQkhahFizsceFkYbv+Pdy0ERtX3dAV
         LFHw==
X-Forwarded-Encrypted: i=1; AJvYcCWbsiswIt/D3Q9oeoZEyQrvG6EiC8p20wkYnb3XyveiXL6gBxcxi5a76Zu2bNOSBXVBJCHOCT81dgTiIy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFyYAL2PZ/wgGzSHmSEr7V+YZPRZMzAuMcVpwIF34b4U2i3Drt
	HqCRcbFpfKXRKPh/oorx8B2qrNuJaPvt/wC4wiELUuZUxZ2weNIVczxqUifiV3yFnImTmT1mnWD
	Ie+xFC4a1UfpIiqWye/2D9zCeObCyKShHvYwX/mW0pQ==
X-Gm-Gg: ASbGncsT3GAHx2H27uskfzYuADlscO0ME6X6ZYvMAywD0DWvGF7VUuR71v0U0MiS+Zg
	mSIGdGOY/n3g6KyjRzOOx2TvkcHOhkiJhZZPFFj36rwre959trVh1oFPVe5DdjI7YSUyISkY0+P
	wfj1qmeMVWxM+BbQHs83qrPixv6LKm4fiAS6+zmKyaWCrgXw1GiP0IQQCw1q/bWKq1SmLiUCLv4
	U7lqvM=
X-Google-Smtp-Source: AGHT+IF0PXQZi9vqVnGtQAW+0IZx7w81vI5Y5ZNTHdf+iKVApDbJ4sFRSLR1PHAs1LlJtYMmoHssgB5z97iQcbR/02I=
X-Received: by 2002:a05:6512:224d:b0:55b:7cb7:f57c with SMTP id
 2adb3069b0e04-55cb69c0452mr37793e87.57.1754504685766; Wed, 06 Aug 2025
 11:24:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805062333.121553-1-bhe@redhat.com> <20250805062333.121553-5-bhe@redhat.com>
In-Reply-To: <20250805062333.121553-5-bhe@redhat.com>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Wed, 6 Aug 2025 23:24:28 +0500
X-Gm-Features: Ac12FXwvECclFxV4j0m2efvjg_nqG0wG27nQYV0fVI0B5ZHzOZg6GczwOHM9vRs
Message-ID: <CACzwLxivXFYXuF1OkqcP9THar7UGQ3VVAQgQm=PU9Tohb8hnRQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm/kasan: make kasan=on|off take effect for all three modes
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, glider@google.com, 
	andreyknvl@gmail.com, dvyukov@google.com, vincenzo.frascino@arm.com, 
	akpm@linux-foundation.org, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 11:34=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> Now everything is ready, set kasan=3Doff can disable kasan for all
> three modes.
>

Hello,

I've been working on this already and a different approach
with the Kconfig ARCH_DEFER_KASAN has been proposed.

Please see v4 thread.
https://lore.kernel.org/all/20250805142622.560992-1-snovitoll@gmail.com/

It also covers the printing in a single KASAN codebase, instead of
printing "KASAN intiilaized" in arch/* code.
Also covers the enabling KASAN via kasan_enable() for all 3 modes.

It's up to KASAN maintainers to choose either version.
I just need the confirmation now if I should proceed with v5,
or your version if it covers all arch and cases should be picked up.

Thanks

> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  include/linux/kasan-enabled.h | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.=
h
> index 32f2d19f599f..b5857e15ef14 100644
> --- a/include/linux/kasan-enabled.h
> +++ b/include/linux/kasan-enabled.h
> @@ -8,30 +8,21 @@ extern bool kasan_arg_disabled;
>
>  DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
>
> -#ifdef CONFIG_KASAN_HW_TAGS
> -
>  static __always_inline bool kasan_enabled(void)
>  {
>         return static_branch_likely(&kasan_flag_enabled);
>  }
>
> +#ifdef CONFIG_KASAN_HW_TAGS
>  static inline bool kasan_hw_tags_enabled(void)
>  {
>         return kasan_enabled();
>  }
> -
>  #else /* CONFIG_KASAN_HW_TAGS */
> -
> -static inline bool kasan_enabled(void)
> -{
> -       return IS_ENABLED(CONFIG_KASAN);
> -}
> -
>  static inline bool kasan_hw_tags_enabled(void)
>  {
>         return false;
>  }
> -
>  #endif /* CONFIG_KASAN_HW_TAGS */
>
>  #endif /* LINUX_KASAN_ENABLED_H */
> --
> 2.41.0
>
>

