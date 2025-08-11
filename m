Return-Path: <linux-kernel+bounces-762102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6ADDB20229
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B5717AC335
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0792185A6;
	Mon, 11 Aug 2025 08:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="osG2UEHS"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421521C8633
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 08:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754902071; cv=none; b=ISm/b650ZbTbcbhep4bZv5T5ZJUXaK+RVJrVhvlYLjtjJRMlqBMHc5c4whqwkPdIBxQ3hF6NYELwm8sIvL3QjqK16IDJ+QfxVIJAfXNcuaJwI8s4nLTjHeu11fRI+EDvVYXuVmsreIOad6/sfxlx/qHCm7HvEv1sodr2qDSiGnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754902071; c=relaxed/simple;
	bh=SSPG/29HLPpTquYEWU6PYBjygo8k+R9iRTUXFr14dhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5s1l22BO8zJlJQkxHJDtRu9+I8J2wZZjuE+Vb7YhQ6rBoxcalGVVl2PXmTYcQBb0698hGpZHvsR3Aqdx2YMBgKzcTJVohmbWg45LBg5afiz5KJMb9ANLYzvCYO8oLc30zhEHSQbb+cMJzY+rRgOL13sIWQVWmV/RYvvkm+pYMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=osG2UEHS; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-32f1df5b089so39444951fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 01:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1754902068; x=1755506868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSPG/29HLPpTquYEWU6PYBjygo8k+R9iRTUXFr14dhg=;
        b=osG2UEHSvby1bINCMZ6JGoyBRcHzJKpsnqu/bsn95suZ/vLwzHemIpuknXCrHSZ7NX
         iqJH4FVZWqhz559eEtdBH0CKl2cYBq1VkrdOPt+beOxX4pbrhKFbFMnBnyBrFYyGIgVO
         tVM/GHtlqEA4dLJDdCdHbf+I0xnwWXPJ0xkGqPXPyJBD6N5Q9MPzvmhCUy1v3pk75sOJ
         hl0Dz5hv7l73hHtKfm0YiSL7TfycgGbxT6uhB25/xeUyliPPFR55yq7LBumzolKYyFYt
         +3fKMn26rG3k6R/xqoHAH/aMBr/FAqu6ezPFUYHxtr8mhWCNBryzzPkTK4UIwI87ioHr
         5ctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754902068; x=1755506868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSPG/29HLPpTquYEWU6PYBjygo8k+R9iRTUXFr14dhg=;
        b=eN/1lkhuEhSrZhXVJmg6iayqeK3m6xOg7p2ddQGnF+H4akMMDtDCuNt+spSgBdTFNg
         YZh27DDZNmNF1XeImyq7YnKro6mQe8WRarSiEU/c3tJyIvEewDf0ISLRBRcvYGpzXI6W
         D/pwpULcJTCLVfNzjICiJTP7Uq3sfkH8+lHlP4V6PprBwzD0MIySFD1mOwpHWnJcu0ZL
         XxQzUKiJio50c3pxlhGnG3yYYwRQJJv8QfeVpOn7c55JntIeBGeE5xilHet48ZJbnss0
         Jyoe0xIMZeibtzli+vCr5JydlKrMuKl/NuXuWGvRAq0S5mbU55aPf+kdLCHyPZ2kFiFn
         phcg==
X-Forwarded-Encrypted: i=1; AJvYcCVlIBfOcGvKVVs2vJB+jKOPkXFmi+azvaBLdXyQb0LuZGN7i7fwPumqUtaiRyk0jd+93K85qg2hKMMB64Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxitG45Vh7z/grn45bysuhy9JodF7HxNau7quGtdgxKb4IgkZr6
	WOWBCDhskj0MBT8QfeidIL9a30hyYdmMlkSHi0zxg629CS30P/1s7rbDs/6yKgge9tPvBYculiF
	seVlk1IEWON02ssr+mizlHQtcgxD0UjI8szjrmjxiGw==
X-Gm-Gg: ASbGncuhNddMwydNsvYJ0kMKOFqkpXbVHi/9LiZHJgfnH5IoYRO/nSGYMUb/3476b2a
	3c9Gd/iP6QTj/Fyn/mxlLItzx0q/IOQb/KNdk72lyl3jteNmHA/7Er4ZBiGXhu5s+hIkE33D32O
	f1ljma9UolAyCC68Iz4P8cfhkGtpDwkFWz4Loa/mp0zKT8gedinYQOlsMJxaPSunXGX9f9RPK2a
	Yy5ht2Nxc5X/h7hVqkZnk45f6hMre/DQ1gi+UE=
X-Google-Smtp-Source: AGHT+IHQZ+Li30LXuVPBZfJzPpG13D46HKjbN25jcZH83z5JqqyWQ0KsRoIqrZmp1XcJkfaY59nLPEzi39QNSDtz0OE=
X-Received: by 2002:a2e:a581:0:b0:332:612b:6f49 with SMTP id
 38308e7fff4ca-333a221c4dfmr38476321fa.29.1754902068345; Mon, 11 Aug 2025
 01:47:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730071443.8758-1-brgl@bgdev.pl> <7ff48289-f738-420e-ac69-de544833725b@kernel.org>
In-Reply-To: <7ff48289-f738-420e-ac69-de544833725b@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 11 Aug 2025 10:47:37 +0200
X-Gm-Features: Ac12FXyVM43pAwwdhH2UZx7AIEJGJLKbhJiBmr-EDd8zuJ-4n2CsNR4nFxP1rYs
Message-ID: <CAMRc=MfYdHa_3=2Vv8Memv9_GUKTD7Z9U-aYGHqk4z=3eVoh3g@mail.gmail.com>
Subject: Re: [PATCH] ARM: s3c/gpio: complete the conversion to new GPIO value setters
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 10:46=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 30/07/2025 09:14, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Commit fb52f3226cab ("ARM: s3c/gpio: use new line value setter
> > callbacks") correctly changed the assignment of the callback but missed
> > the check one liner higher. Change it now too to using the recommended
> > callback as the legacy one is going away soon.
> >
> > Fixes: fb52f3226cab ("ARM: s3c/gpio: use new line value setter callback=
s")
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> > Autobuilders pointed out only now that I missed the other line that
> > needs changing in my previous patch. I'd like to still queue this for
> > v6.17. Either through the SoC tree if it's not too late or through the
> > GPIO tree together with my second PR for this merge window. Please
> > kindly ack it.
>
> This does not apply for current RC, so on top of v6.17-rc1.
>
> Best regards,
> Krzysztof

This is no longer needed with v6.17-rc1. The callbacks have been
renamed back globally to the original names.

Bart

