Return-Path: <linux-kernel+bounces-845113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6CDBC38BA
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 09:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9DE34F6ACA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 07:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4788D2F0C7C;
	Wed,  8 Oct 2025 07:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="gYVRsreT"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BBB24466D
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 07:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759907897; cv=none; b=DQTWiA0kkjIyPrb7Eoo4mSNNaqXThnxZSogEhGTaStVGe24MCxcHitPxJKoO1xPOWJ1ZlmeuBsnrBNqMnByhiUuXMH9h7HoimWLLJDRY/R0ddze15Ix7eiovWCXCva30qZu9aFQoaSa9bwHVN2P8KAPuW2ybV5ykfiraFmQ+LI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759907897; c=relaxed/simple;
	bh=MKMPHmTNcAyRlJ1MMOFGz/GHSinMTp7O8OBhdYfHbpU=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AOHvvmHPCsU/Z9I9A+FAMYp9yPulAvVm4k/wRlwoT1mTzVZT0bcm/t3fN3c+A9ooXiU78fULX04hRvBP1whGH75gi86PfS4KqsG8U3yqUdaHToFtBtgRlTljV0bl5mCat5PbuyOXgQ5dpVylMwaZroUkZIdr6I+qzA4awO0rk8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=gYVRsreT; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-57e03279bfeso780532e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 00:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759907893; x=1760512693; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5JEjUmbRYna0jJQ4Njy9dAhQR6lXc/eOMFRhsvlDe1M=;
        b=gYVRsreT1Odz3RwnMQjfrb3S9xql+yKBaWBsn9NxddchMP47UjHkLFkauplykaZBPm
         y59gLSi7kpUyr6/l2syelQUA9OHjh8xidhdxnDKDJr9mjWYJt3yk3XukQzhjv2DmfhyQ
         mDEr67Abu81VMDqGV5BxPDZ0rub+WysGFD+w/17izdsXG2OdshOUkT1zjkdhwFczeeDR
         fXLtRAdbEsBW5WmQx+n9+Q/JVy/jb0GYctTRpVDnVy3UoHy4yHWS7zJD75CfJVY/vkaI
         0nuRF1/X5jIuAyjXH3WSyC44BBNSKqWEI7GyMUlWn/l2xw4EqAGXS6K+yADvOjcsOChe
         v1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759907893; x=1760512693;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5JEjUmbRYna0jJQ4Njy9dAhQR6lXc/eOMFRhsvlDe1M=;
        b=FYQlU13qCwRmT4k2mPcPFW91Y4weUi+t8IqQaXi4RTbnEqlm2aTf3uVNN/XAddYTaL
         ig4Cv2ME+N36l9NieP4Y1JToSdxq5LwW3Qq9Sdij/Z8BXe6jAKHocG8x1c8hD5WEE63Z
         5fNTANw/ECNlehw/R2LJSOuTdlfWGyr8+dMmUnJlWtAoUEonGric2JqMduILVWWyJuej
         b73foN2VTyiOvoMkPoDHsKGEPfwMd1w836GkQVqaX/3CB1fDelr47DS16Ne65aWn2nUT
         iROI7jxNAsUQVPaIkHu1Cn0E819m9yRDKZdlsNm+W/ZlAXyWnG2rb00DTeOPVTRX1Ipv
         Pf9g==
X-Forwarded-Encrypted: i=1; AJvYcCVk9lcH7e2s4KJ2RsI92sna3T+5KN4d0I/oKAd5B24ShZkO3MztOpx3KD1Mqs2+bb4lZk46kgs1tkZsrZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvS2QvcOkWBrJvvgQLg6Rn0sfuWpwdoPFZy55IsxDd7yylvijK
	simLOrao1cChDWMO1Q3Ju5ZWR7Sy3UerBZcSJ8aqaO5TT97HxhymNZcKnVCRxeWHHW4stgS198u
	PePBHqLD6jeC3ivNH098jpxGlrNEu2W0rPRGUwzZ4/A==
X-Gm-Gg: ASbGncuttmbcTXwScBac+G9rAbTcLXwFD1aXElGLYXfqIlEN6gMReHoFsOmHVbzR3N3
	nQWlV/uNsPtgmHi2wMq6B07NVD5WlQg5W08OrZzLOGzCMFdQYZjdi2xOI9tq/SYJ8ecoUd4HAOD
	CMuPvmT1kSAeG6C/TTdwsGmfE3rvk2/pFVZ0s9V7qlXtOQwVdDAOE5bsxxfZLgAblrgzdMLDMwN
	Ces+6HRcxwn3rzP4xUYQHj/2IElvIR4f5DK1/4o3DgvtCeZJs1hOJIQxVJ4ljY=
X-Google-Smtp-Source: AGHT+IG5aOcnm+ccYQhLqgJ3TKrokJSDSPR6rxIvbwXnDayoiMYaXJGBtFH/ZMoT672DX5xrsE6gfIzBKLxyuKOlaB0=
X-Received: by 2002:a05:6512:e85:b0:577:a108:93ca with SMTP id
 2adb3069b0e04-5905e3a0d18mr1622290e87.28.1759907893425; Wed, 08 Oct 2025
 00:18:13 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Oct 2025 02:18:12 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Oct 2025 02:18:12 -0500
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <20251007-pinctrl-drop-advert-v1-1-df16410680af@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007-pinctrl-drop-advert-v1-1-df16410680af@linaro.org>
Date: Wed, 8 Oct 2025 02:18:12 -0500
X-Gm-Features: AS18NWDkOJhreUAnXAv42KKCZwAZT2qhGPcwzJvh9__UaJ7jpoiFhCKWMr1GEnk
Message-ID: <CAMRc=Me5h-Fk2sNYpCc+y5Q9FjBC=z1m4raZ4JHF5_C_hKiCnw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: Demote subsystem banner message
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Oct 2025 15:18:50 +0200, Linus Walleij
<linus.walleij@linaro.org> said:
> There is no reason to print any "hello world" from pin control
> unless (maybe) if we are debugging.
>
> Drop the banner.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/pinctrl/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
> index c5dbf4e9db84424ae9ceb90ed3681341654d1871..157510157d47aad96b459abf68cc0e4eed957f2d 100644
> --- a/drivers/pinctrl/core.c
> +++ b/drivers/pinctrl/core.c
> @@ -2416,7 +2416,7 @@ EXPORT_SYMBOL_GPL(devm_pinctrl_unregister);
>
>  static int __init pinctrl_init(void)
>  {
> -	pr_info("initialized pinctrl subsystem\n");
> +	pr_debug("initialized pinctrl subsystem\n");
>  	pinctrl_init_debugfs();
>  	return 0;
>  }
>
> ---
> base-commit: c746c3b5169831d7fb032a1051d8b45592ae8d78
> change-id: 20251007-pinctrl-drop-advert-d1150d425942
>
> Best regards,
> --
> Linus Walleij <linus.walleij@linaro.org>
>
>
>

Good idea!

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

