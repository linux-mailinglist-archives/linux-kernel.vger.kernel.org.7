Return-Path: <linux-kernel+bounces-813954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC607B54D86
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D1E1C21289
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479EB304BB7;
	Fri, 12 Sep 2025 12:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cw28qy1d"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D6C2DEA82
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757679462; cv=none; b=cirPPxBvRmRs/hV6MP1BszCyawSseF/LW/Dpc/dgzJUtJ/EaJUpyCEoId+R+m23TAYvHy2DbePOI5vAMKRUmfI6P5OrKpFb0zECq5ESYwtkUkTq+mKRiIYcY+dqbD66ZX+RsLcer8QxF5xQsJWnplGrMHx/kng/KiwCAx3lS354=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757679462; c=relaxed/simple;
	bh=pd4aahjlhiUPcExV+Rbm+9NlrXRPwfzHUZwRcgIhFKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u1uUV1jvj+f+M+WjW+u2GMJ3xv+JeGJnPqE7ECqzttE5p9Hg1C6ILkfCgo4QHZsv8udZXBeyWPKOj/0byoE9V3BOqlHkGRgMLavsLHZeETTp9TuZ0+HwbUQBd6XkwBei3KmvLJkDTODxdejRbmImV1xfVtVo/taIcslOFXdOl9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cw28qy1d; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4d118e13a1so1318563a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757679460; x=1758284260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqb2CRdPlux5KWE2mtyji+dOVZljfEIfjqoSGnBGH1E=;
        b=Cw28qy1dAaBkoa8v0Xg2OuQD//xdjKpHRDj9G5d+5BjTCVRNwjyarNX3N1bDvMeS/n
         w4sku3I5c3B7yfoqaagvm45OC2hr1EGNNfRbSkGr4FOWJ5MeqO2vtOKDh7lllHq67mwJ
         9A27Kc47A9HdeF8j5LY5UkPPspVChN/lrlmjNTvPJE1e1lHzo50BdIWfLOohtjSQRNd6
         UNROOvGpk0m72wUpzkXLsPqYtk1fb5NhKb+m6a/E8iguOXJpmK6x6QBR45oIm9yBCqQS
         z/x74GleHSnD/n6rvK8YMovS1vQg6HxsLx8kLK1J762UViAVpCo12Dxjh0Ucvkd/75qg
         dlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757679460; x=1758284260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqb2CRdPlux5KWE2mtyji+dOVZljfEIfjqoSGnBGH1E=;
        b=tf4NMRo1zEbGlYv3o3iYO6uS2alsJX2fImlEDf5kKvRoNWG/fVQHa+mSffdEB3Mesd
         htgR24SKfZR8qOKAJ5dBwH7N8wpua7BQjWk8aPfIuc9ATa3eo8fgw9tw/0Lv6zNDcscl
         NX8v0+vnX+iwW1DebQ1zU31nr1Cuy0eu6B36ResfKTa2gNvmU7WoK322VTKtmPhPgn60
         UkHXdPzhquuQIIKZxHjKXPB5OY/K60RnoG41MtmqiALLtVUYWMc46c2WZXlEuwEDc3oe
         XN+UT+VFw46pMfuRODGQzleJgDt8G55HZaS3JOrwWEQdlh5yaJOnvAuxZ0mKMuH5dwsJ
         O2Eg==
X-Forwarded-Encrypted: i=1; AJvYcCXZ0q1dH5mERaY3zaJ3rCjDb7j9EQQbVrKsUEOqazmDcUxx/P8D6GxU8OS0YZEArvDA8jCV/HyZ0m99+gA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnS98RzyaF/Et/NERYrUtwHXAgJXuWXGSf/Ia7LUoQ+8/w3o5k
	/EBOL4VOadkrkvTl3TZ2Mw5I20jbeNYanKx4TR1IL9rOXkagTVG3kPJnV8i01lABonx2sn15ijL
	yOw7DqLbSbBoI1siqcJmuRt44Oh8qs9A=
X-Gm-Gg: ASbGncsneJLP6qO5UzBMwCj1SpmzTNlke4ANPfVMLo9wRclfSooo6VWcmpdFuFZ5Ee+
	c1cXO6w/lIPmovVwR/9v/Z7kitjhB22V+n8HpKYoKpua19VI4EGIQvf3qKWzYZ0YPYaWi1acVrn
	BglRvn7vYOFbVweElacfs+YRJOLlhJ9iJcsHbU+m1VofB+kv6M5A+tf5oChwPFBHnsKXQUJBkZG
	sa7hQ==
X-Google-Smtp-Source: AGHT+IFwtZ97HGjsQnwDLaSscYiXyUyWaZRXiTzaM5M046FWDXCWxB8k2YOnMd3VJ+Y3cvmtimQrX/EgHhgmJ4CE7Ho=
X-Received: by 2002:a17:903:1207:b0:24e:7a4a:ec59 with SMTP id
 d9443c01a7336-25d25678b88mr27471845ad.22.1757679460088; Fri, 12 Sep 2025
 05:17:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909-gpio-mmio-gpio-conv-part4-v1-0-9f723dc3524a@linaro.org> <20250909-gpio-mmio-gpio-conv-part4-v1-8-9f723dc3524a@linaro.org>
In-Reply-To: <20250909-gpio-mmio-gpio-conv-part4-v1-8-9f723dc3524a@linaro.org>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Fri, 12 Sep 2025 11:49:01 +0200
X-Gm-Features: Ac12FXy3daR3VOEp5n6tNwKkhCq--fDPiLYS4w-Toaa60ZTGN2VkMzc0b_ryiUA
Message-ID: <CAMhs-H-1VrKiknwoukGY2i0ox2VNd=pmFrMcR50mn7tEZ0pZ5w@mail.gmail.com>
Subject: Re: [PATCH 08/15] gpio: mt7621: use new generic GPIO chip API
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, Keguang Zhang <keguang.zhang@gmail.com>, 
	Alban Bedel <albeu@free.fr>, Doug Berger <opendmb@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Yixun Lan <dlan@gentoo.org>, Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 11:50=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Convert the driver to using the new generic GPIO chip interfaces from
> linux/gpio/generic.h.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/gpio/gpio-mt7621.c | 51 +++++++++++++++++++++++++++++-----------=
------
>  1 file changed, 32 insertions(+), 19 deletions(-)

Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Best regards,
    Sergio Paracuellos

