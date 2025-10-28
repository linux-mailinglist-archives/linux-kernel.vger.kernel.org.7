Return-Path: <linux-kernel+bounces-873448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C118C13F26
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A86119C19B5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9ED62FFDC4;
	Tue, 28 Oct 2025 09:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfhMTxv1"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902C9288522
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761645202; cv=none; b=ppLZCAVn0nHqO+58M6GzoL08pWuVlLBAM1cYM/o4uEAEwQvPkAWxUe1u9rPZLlwCmnoYNRBB4gm5tOshDCucxWmOoIvgr1gd5ahLJfZgGvPW2kV8qNBvvKBLdy/bnE5IAUHvwL3dvhCENAu+tlMInxc9mlpSpbk2C849e/aP4qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761645202; c=relaxed/simple;
	bh=4/Nb3WWvH/1mUIXPrTIH4b2yaDJsbnyCRLr9hPVOhPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pKImRA6Peo0yMlgXxR+IxmIQ8soqnLVPNNYDJT3sJ9719BuSB2+LSWd65L/EQuJ6tW45Y1Tl1vOz8oTUe0szrbsEX+y/ZKZ4hVuRkX4s+h2VEMJnMPuv3KbkrKwpz75cRhFenZGuYPzMhp+0dU60nLYCvFASZiRQ/qmT3W55zVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfhMTxv1; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-44da917e7deso1304420b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761645199; x=1762249999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/Nb3WWvH/1mUIXPrTIH4b2yaDJsbnyCRLr9hPVOhPI=;
        b=FfhMTxv1RByTSeNNYzyNjwkSpL8g38WpSTI2Mb+Pt+7Xh0BcGfUzyzp/RJQ2D9YHQ5
         UgjgOuJLBTIPsQv59GRp0/R3NvjYqp47RVE4vpb1kvl2TqKMkr+vQhu7PjZUQeXgK4zu
         pJrDUMcJ+W/cD5YOxNdk8blVOwpmYeptuNuQ9hMA2mBtXTi7QsliLxJTIxqUyzMor8iT
         9QzYIkjrfnrZ66ukQxC8PYdgMOBjX+9o+ZQD3ILWMOo/NsD2tuVMGT8vub1YC9R3eZtL
         6PD/RV0kMpqLstJ+CG7b7UzqEND8h4B6z0rU7LwOaPymTWSE3FZFBbAE9RQu2mXPQsRB
         /I9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761645199; x=1762249999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4/Nb3WWvH/1mUIXPrTIH4b2yaDJsbnyCRLr9hPVOhPI=;
        b=WdxVU2eOxaejbOFCcLK2zb9crVXd2j/ltyPG7FvtPMnUdb4rkm4ceTcBsWCraQLQNj
         x3o6bbglBUxwm2/WTgnb2vT16+xmGPmEabIDB/e2NfjiHO3mVngoVgF8d5DTnhSp2OhU
         exDgPvpwQHznpkbSU5n4meIUU30xJ192evSFncX3RRvSWY3W0W0njQ7EE5lt3F6oHVWd
         I6T2cF1pbysSQMUfuoLWDO1zLGPtabu0Yosnlr2C7v+Aj+ikEJJKPJKqvRgEVXG1I0kX
         55q9XKvgz8xIgnBt656YSxG5SCkq85xyI5ymNsaMMKVZC8jz2aGzK5/T375j2C4hWRKa
         15gQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUiYKbR/k7wvFEuJYVDkZiJgesy7nfODCvOT798MSlz4ZcczX+O68vKiK0UWVEklSy7ZYW6Tp6C0iIxBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0wNDM0ZZsc+WvlPFwXqusZecl8ckmniAee/0iDTM9YsVsm0rZ
	V1XeGMnkPYl7m6jLayW3UHGmwhfweB3SUwO7doIA9aZOFsr38YvSAYUChATxViUtLOc4d4gZoz7
	b81yG9lVO0vynHCzhLyvxA9MKn0Rr9JQ=
X-Gm-Gg: ASbGncthfr270SRGicqlQWDWK0+zcFlpQfqnBSoXVEhgvqbOP8OX2hq5IWH45jf4+MR
	Rl8RAlJHAacR5WQGovedYyQvAaQ/9xcfY6eQ3GFFC5T4o7Dcifjrizyjdx0xYHnfCIqFZcXEIDf
	fVYw/RbRA4qMFTm6yZfJi0qV9cItoTr1x6IsiajVg/mMqqOUxpgCVaRfeyt6cm1ACA9Skm370xG
	UyuX9SUJrCz7CBbBUBWSmraw3jkjGWzZG8yKjeobbYkbbGg9RnalUBmmpBM5Q==
X-Google-Smtp-Source: AGHT+IEbWmUMugzBeIPUgI1/BsJBgV+0SWoENDsfOHTRTsl6JEQadKCa6qWvaTqxnr9sGbNnfs44CBd9zTl5zKommQA=
X-Received: by 2002:a05:6808:320f:b0:441:8f74:f0b with SMTP id
 5614622812f47-44f6ba984f6mr1130597b6e.53.1761645199645; Tue, 28 Oct 2025
 02:53:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028031527.43003-1-linmq006@gmail.com> <0103d31e-f7f8-45df-9add-76adcca3ec40@kernel.org>
In-Reply-To: <0103d31e-f7f8-45df-9add-76adcca3ec40@kernel.org>
From: =?UTF-8?B?5p6X5aaZ5YCp?= <linmq006@gmail.com>
Date: Tue, 28 Oct 2025 17:53:02 +0800
X-Gm-Features: AWmQ_bkMyjcKORFWNp8J-vJD4NSkB71CvF6mfPoA-5wZktbAILoRLRbfvGQOD3w
Message-ID: <CAH-r-ZF9r6hoDOBak5pj7Q5+2wmFto=onHF4_Atv1qcyVjbeXA@mail.gmail.com>
Subject: Re: [PATCH] soc: samsung: exynos-pmu: fix reference count leak in exynos_get_pmu_regmap_by_phandle
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Peter Griffin <peter.griffin@linaro.org>, 
	Sam Protsenko <semen.protsenko@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Krzysztof

Thanks for your review.

Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2025=E5=B9=B410=E6=9C=8828=
=E6=97=A5=E5=91=A8=E4=BA=8C 16:42=E5=86=99=E9=81=93=EF=BC=9A
>
> On 28/10/2025 04:15, Miaoqian Lin wrote:
> > The driver_find_device_by_of_node() function calls driver_find_device
> > and returns a device with its reference count incremented.
> > Add the missing put_device() call to
> > release this reference after the device is used.
> >
> > Found via static analysis.
>
> What static analysis? You must name the tool.
>

I use weggli (AST pattern search) followed by manual review.

> Anyway, same comments as before.
>
> https://lore.kernel.org/all/?q=3Ddfn%3Adrivers%2Fsoc%2Fsamsung%2Fexynos-p=
mu.c

Got it, thanks.


>
> Best regards,
> Krzysztof

