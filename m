Return-Path: <linux-kernel+bounces-876040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB7BC1A81D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6903B562DEE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C1E340DA1;
	Wed, 29 Oct 2025 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="F87I/2HK"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5AA3587A3
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761741431; cv=none; b=XHr1zLwFuKkQcsYyWEz6NMc9xeHHWIEYMNlPImPFLCGDf2hai054EgmnSzb6yrTXpvsUsCLdDv/9fNhgc1y9UmrVkX1a5VFG6NhaFwPwURr0yO98BDRuu8iO391R6rhzmeu8aJJAALnBsQBqtCfgFGQfyh0jPKcpSsKozNMCpbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761741431; c=relaxed/simple;
	bh=ni2P6AAAIna0hjFuAO82zYVMn0J7WfuU6b6IJiF1kKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXRXVjb9knIiiGpwOFnaQJSi4rNtNFLJs+DEvr+eZyg99H5CX731tChip56QMT2gTUZueGlTCbyF0DCQoQfvCv87Zpe0ffOjai1Vpp0CTAwPeaLhNeIBRZzEe6Jz8Pl0clcMpaKF15fToHdaUsHFZw0vFT+HIArwd71CZy9hsvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=F87I/2HK; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-592f1988a2dso1030525e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761741427; x=1762346227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7av6/+8iNuXmmgvTwlUka4Y7XmkOmuVd9YoxH52DeM=;
        b=F87I/2HK8EHJQ7q4NQauRZSN2gkF3Pa6uWaxKT5wFbnJ02O9XJM9CVQa76aAk0TSaF
         76edmu0GN4qf8O7hLOGmgl2m1E/wZWlSCbCwBKWravWbrzWOVNd2Wqlt7J+Ua6qOxZxV
         Vo25gJ6FNxMMGcNYpCsgsF/Dew11WFweBBQN5b/PSxkUJYaDWPJMhjW8sS4ajHDy6GUk
         UcOdOSnXu53Sjp2FtHMI3QAxxu+nHioY2KQfxl0H50DDrK7277Tkwx4zmGEf+2VqRYAC
         XTokfkhjUfDrPSSnkP3OTTs8R08HxGteHAfjxqZNthOIwQp4OQb3FHhc2UN/G9S0PpM9
         LdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761741427; x=1762346227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e7av6/+8iNuXmmgvTwlUka4Y7XmkOmuVd9YoxH52DeM=;
        b=cdh2NTbNk4x6kkgQ8WwVM4Uut3N8GIdw2O+B8JhOobmi7dopCkt13rokImBrftSH1D
         atzu/YZkFE7u9s0Az5Bqogh4i7m0pEz7P9scBmqcvD3cbY6w4aVSyBgh9CnX6xbv3OCB
         6UYS0wS20jS8/yF5FgqzX1/TCAVi/ELRcf7kb8eHm5h6TiPCiTMDCakGbYHCE3KMiptn
         DBfm6YEdu3a5VfwAo44KdatMEldI21NnLwSsAD3M3gc/d9xhIvQEeeja8Tc8Wq/HEMI/
         Bc38m6cLdtpnRLK5loCG7IRptuvOcdOAEgUwQA5k36yocZjyoZhby6/te4XqjYtvhGXQ
         GDmA==
X-Forwarded-Encrypted: i=1; AJvYcCVQhSLGqw5BmTkvuCwSKL/5UY3vPabv+PzfA6cWKVqBqkTacCfm0sZqWNj2MtSBFZ6aVZOm2R0s2XVnYbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP86RFdFPNoukrOnvmXFu2N/ZEAOlGUEB1/4vbCnKergHq278Q
	Cxoqb6zc5pRySpjOyS1C2nfkA0PaiKYhca0+byu522wTnRpVeFeX05w95882GzNTrWLUpO4JWep
	3Zo29gtUxIRXVkTE6NbdhE25VkY9LJvtCn+9GiD57rA==
X-Gm-Gg: ASbGncs9f702zbvKJiftViPWfHdhdYRk4k9NR6ZGrFYqHuD6aAikJb0TFxG4PBBCfcu
	p3vtlgM9RBHxDnTmLt5wLAINZK4eMRNgNfHWZ2pYDTRfmjEN4+NI1964t4DSpTTWiiQLpow81nQ
	9S2Nr2SwxwLRZfI9+lluc+goiu/QEsBe1NzT4Vev0LpGBwvlWI7FJQ7cM1NCcv1WorjiP5Wu7vj
	ncs85h51CVuVVRNr3VndZM3otf+1PTeUmWzE6Nm03zAywAWbhnF9wG5czvPi7mh+1a28SOzsUQb
	D+eHLMsoiI4PlNJtDuEjr1XD/wg=
X-Google-Smtp-Source: AGHT+IEUmGu04036ormM4pltNB2Am321w2VXbEnKTAs3EJCIFCtIkYSiyRchfH1o5wZ/LZR6U90hsv4wZnUUYh2RdrI=
X-Received: by 2002:a05:6512:31d5:b0:591:c763:78e5 with SMTP id
 2adb3069b0e04-5930ee00135mr2032537e87.23.1761741427164; Wed, 29 Oct 2025
 05:37:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-gpio-shared-v3-0-71c568acf47c@linaro.org>
 <20251029-gpio-shared-v3-1-71c568acf47c@linaro.org> <aQH9gE_fB119CW3l@smile.fi.intel.com>
In-Reply-To: <aQH9gE_fB119CW3l@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 29 Oct 2025 13:36:55 +0100
X-Gm-Features: AWmQ_blmOzETrnBiOxNQNAG3OMw6fz-E4Nx4SOD4Wgu8a41SpvuD7mJ9RHyBeG8
Message-ID: <CAMRc=MdKfXJx-cxNr1uOCkifD6YVE2t5w4hkuYy7jcnidiid2Q@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] string: provide strends()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Alexey Klimov <alexey.klimov@linaro.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 12:42=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Oct 29, 2025 at 12:20:37PM +0100, Bartosz Golaszewski wrote:
> >
> > Implement a function for checking if a string ends with a different
> > string and add its kunit test cases.
>
> ...
>
> > +/**
> > + * strends - Check if a string ends with another string.
> > + * @str - NULL-terminated string to check against @suffix
> > + * @suffix - NULL-terminated string defining the suffix to look for in=
 @str
> > + *
> > + * Returns:
> > + * True if @str ends with @suffix. False in all other cases.
> > + */
> > +static inline bool strends(const char *str, const char *suffix)
> > +{
> > +     unsigned int str_len =3D strlen(str), suffix_len =3D strlen(suffi=
x);
> > +
> > +     if (str_len < suffix_len)
> > +             return false;
> > +
> > +     return !(strcmp(str + str_len - suffix_len, suffix));
> > +}
>
> Can you rather re-use strcmp_suffix() from drivers/of/property.c?
>

I think that strends() and its boolean return value are a bit more
intuitive to use than strcmp_suffix() and its integer return value,
the meaning of which you typically have to look-up to figure out. If
there are no objections, I'd like to keep it and - when it's upstream
- convert property.c to using it instead. Also: the name
strcmp_suffix() could use some improvement, seeing how I wasn't able
to find it, even though I looked hard across the kernel source, while
I easily stumbled upon a similar implementation of strends() already
existing in dtc sources.

Bart

