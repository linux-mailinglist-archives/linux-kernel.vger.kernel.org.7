Return-Path: <linux-kernel+bounces-844365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D86BC1B27
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 16:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85D5188D82B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 14:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6263B2D7DCC;
	Tue,  7 Oct 2025 14:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VgPjb8FL"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32254170A11
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 14:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759846866; cv=none; b=bQsXsyT+j2dWWV6gWDczqQhCgy34uwq45CzVJ0oAZWkM296HjAg6aXlesXQ/WdEZIgvmgvl5aGOr1kaHiPOg6pOEpYlHnZWMWTKetmOAAOPE1oIO43chcaZz43RJzLk6nsFyRMJv1ZxBscZfCK9HneVVO09Ticg0/ViLQaRCNJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759846866; c=relaxed/simple;
	bh=eYh267DpK0JEPWYWeQXSr0dMemZXuGTwZ1cjG7C/2GY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VVpBUdPyP0HoguTHaPoGUaSK6ii/iKgkM4YbDrFoQ7+s6Ei4glEw1UlpUaalkg9CGqgoF+UF5kEZ2TASOBF92MK3awY6A7glV0Wk+hyebqiq5kUpQKArYBLhHhlLZlcO52CjF8RuodrmSe77xxSwSaOUqlfirj1/ckhim5i96Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VgPjb8FL; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-77f9fb2d9c5so51345097b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 07:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759846864; x=1760451664; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3kLAmeOzoiivbz2Rz1intsMYvYNbnajfLd/kVGShh0c=;
        b=VgPjb8FLFTlF22SytV36Vx3dd/s2qjET0Vc5Dt/0Doy+Ur71aV1lf/DvzjN/c7VV98
         krkAihFnbiMFOWhL29FWtG1AuPC9huOgwqXXCupYyCy8BtDnIYSTZHRoNOSLX0IEvpil
         TrNLmN1QoQgJr6LGxyNn8L/JhMh5lwB5ckRBGh3rPW8v6ytn7VhEvW3o7gN1iF2953Xx
         mcMZXOIgZmVmBn4Hxgetg86hvwaoKseEZa0JvJJBLSr/jd3P2Cxl4ZtIMa0N+e7IqaxN
         wXjEnEbadMves3wkBfLN7iZENHSqO02V36C3hFKtPxldvAxdvs/xKRUVbx9rWbu3RY71
         X8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759846864; x=1760451664;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3kLAmeOzoiivbz2Rz1intsMYvYNbnajfLd/kVGShh0c=;
        b=FLDrsNOCazF1I3eO7laxB8IQOiwSXtTNwKzJ11snNT2gB47UI9zjjLy7Td7lBIwzxI
         wynsydXT3N3ff00krFLejOfBmKSe7OrpLVnx9UIKAfAqidMW6a+F01RlNQpv4Y9gNoS0
         ix8sWFtrl7V5yXUrfQ1rj1jEwQ17WprOyiGP3qiyYxwltbXApYMs0ikpqnDIFkndHJt0
         a73OxvCP4PbadZkJsBAYOV00Pq+so7vzHf6Z0JzD2nHVm8ZdEti0kibBe1X+3kJx+uaL
         ty4ezscP9Fq066xJH3jXmBgRLBwrV25wcplU6Ttb+d+iSEdZJRB0fNrNgpzQ04D2bAxg
         uTgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE3YZyMQzDEphyouDz9rLX07o+Wr4fLFozTGj+FqwZX4RkIXShGqQU3H4CAHKHugtm23EFhrXe+UchTV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw/0XsJdJymZXeS7RaiHs+Yw+P6jk/wVD4tbHCZIu+2dBgF4qP
	OjdCfaEJeFjThbQP5UNnp3OTkgHu1axiHMTOY4sfvG4GSmdZZ/iP6cfDY+2gw/y592ojbqQzpXG
	Re/L0fGMMbnCOOJp50Dr9QY2SGHCXbphMbjoPcLKKiQ==
X-Gm-Gg: ASbGncupfrOyyJj1G+VM0bHVTeu4drFC00n4XCsDcQzccvHQWzPhSYPEGZUgUH6fert
	iu1EK91kSC4HKkaLQSmy3BEDdz8zQ3xvGdCj70e6idOC4AVqEtLT8C4x9wj0CIZeefGJRi9zqON
	62MowVhbtoq6ZRz/ctK/gZQRGasPu+ye8G/6246UxtSbWTVsSnOzTkQnrrOlT92+yc3dhL9OmmL
	CY7wqr/o8RXAsj/3TglLVy91kGFqAGYtDjh
X-Google-Smtp-Source: AGHT+IHSu/XJh+M6pXg6w283e6qpfz26caVJ7eid1O8N8+iWFGTtXTS3y40R+fiRfyZEmkxA4OGvQcU2hkcnBIWtEAc=
X-Received: by 2002:a05:690e:2490:b0:633:a47c:6e35 with SMTP id
 956f58d0204a3-63b9a0f0cabmr13114664d50.35.1759846863578; Tue, 07 Oct 2025
 07:21:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007-mmc-no-advert-v1-1-0e16989d28ef@linaro.org>
In-Reply-To: <20251007-mmc-no-advert-v1-1-0e16989d28ef@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 7 Oct 2025 16:20:26 +0200
X-Gm-Features: AS18NWAOO_m_RwP1_tkC1Z18kCa67QlTsJoT-fje8jLLTgPaLM6lvL_IB-sGLFk
Message-ID: <CAPDyKFoKV6K5AJgXHrJ0DBycCJZfx9D5cJhDUJjRnTR_W2EegA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Stop advertising the driver in dmesg
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Oct 2025 at 15:15, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> As much as we have grown used to seeing this message on
> every kernel boot, it does not add any technical value.
>
> Demote the init banner to pr_debug() like other similar
> messages in the driver and drop the copyright message
> altogether.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mmc/host/sdhci.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index ac7e11f37af71fa5a70eb579fd812227b9347f83..001802a3aa202c4d8f185ff4924838579ee44c4f 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -4999,9 +4999,8 @@ EXPORT_SYMBOL_GPL(sdhci_remove_host);
>
>  static int __init sdhci_drv_init(void)
>  {
> -       pr_info(DRIVER_NAME
> -               ": Secure Digital Host Controller Interface driver\n");
> -       pr_info(DRIVER_NAME ": Copyright(c) Pierre Ossman\n");
> +       pr_debug(DRIVER_NAME
> +                ": Secure Digital Host Controller Interface driver\n");
>

Why do we need a print at all during module init?

Typically sdhci drivers end up printing a message at the log level if
they succeed to probe in __sdhci_add_host() - along with the other
error/debug messages during ->probe(). That seems sufficient to me,
but I'm not sure what other people think.

Kind regards
Uffe

>         return 0;
>  }
>
> ---
> base-commit: fd94619c43360eb44d28bd3ef326a4f85c600a07
> change-id: 20251007-mmc-no-advert-8f5646c44dd6
>
> Best regards,
> --
> Linus Walleij <linus.walleij@linaro.org>
>

