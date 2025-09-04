Return-Path: <linux-kernel+bounces-801537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7FDB4465E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8EDF3BF3C9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EAD272811;
	Thu,  4 Sep 2025 19:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HYPoE5sW"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620BD271A94
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 19:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757014099; cv=none; b=ttw5Y60XLSj20oeEJsWtEnBqrlbQYzGAUnTdUtm2umz3M5mQxq4B9Y58wfng3qUGbmrRaiPH0gj8R/9WpJk+nnI1hy2VaA/2Qooa0WbmidfvmmveTH+h92XBDeS9mtxd6eR3bE8vP8vVLcYqpjIexTGtcjFnoDd9NmwpbZsBzXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757014099; c=relaxed/simple;
	bh=6wWeqZDwihsnWU5fR8qAMJR8kBNuhg+2Et/0lB5o0RQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sck8jTB5i+CK24jf6X2eOlE3+pZi8p+y95PeuAjOY3Ar4HsQa2Au+wNZipq7yGVt6cegjILhnzUX1/34G7Opi37bp3DJFlRx4gbyLU8QmhqoIsXbB1k9OF1J59u9dEIBE7I+1+9/1SvI/0Vcpf2lmSWTdch9Z/Oa/ezOsGzKmXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HYPoE5sW; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-336af63565dso11984951fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 12:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757014094; x=1757618894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wWeqZDwihsnWU5fR8qAMJR8kBNuhg+2Et/0lB5o0RQ=;
        b=HYPoE5sWz3tO8VwRYECtJrDKpckN0NPclo/BK7PYa8U9XW9zMbqE9edDoiMTKjRHa4
         YqdGd81+6ZMuUU/wqTr7O4awI20rYpd96unYO/VTWjzqoEtH02M9X5zL1G3TvYfnv+11
         mCTa88AzhocgY7I92tY9gIG4UmVtwDH/1B8RO2iB6xgLxYTN2j0eK2Ji6uMNQUIV/Ldm
         P586Xi/IolD+XAXUHgGPrsmBKgrqwC0oQgIBEYmfstxPSFE6iy7HDfV2pPg2hLuMLbB3
         gTJChImDeHyYJwF4VZ4fJf6hE5k0ob3rYHLcZYMQT27a08WtBiov4wQpEfK7VTQ7SWvo
         OB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757014094; x=1757618894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wWeqZDwihsnWU5fR8qAMJR8kBNuhg+2Et/0lB5o0RQ=;
        b=nlx4picKi/qdoGHaMLHDEfPvBvsvUjs9ACSPGGSWWgYM4PIyvZEBxvV23sKQM7O6Mg
         Ormj1fDy8LKaArBCDB2HDMczn5a36x+iveYTSl1jhJ6/ruNaNmY3cmE3jCvAPJrw8rwJ
         Q15NcZVUROaFgPWeKqw24+yBR6u7c7WlCDAIahC15mfZWySpf4xdo0fardROxifzvEii
         mLAnv2v1nnOurvPgZL2mhbEHUo6TxrUhMdM/5K8iCUGClWg5juCncIz0SG5VrDWwOw3B
         wBFr3v743LEEwEwKO5EK0fiwq0lI2G1k7S8nKEAFIZIMnz47tStgsW+WWzaIdNuvtrpX
         N8Wg==
X-Forwarded-Encrypted: i=1; AJvYcCW4iL61Lj2icqC8pZFSg2kyal90gmZobLNqcQHhgnuNkY2b9zadkqKhx4gYUtRN3iIg7uJDCQjz6udjSs4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaw252PeOsLyqDSI8DcyyakxcKgga5THAKjpDUTNcZWfohltt1
	6MB9+afBwWsBiaj2Sv1SRyGKzsvvxQDJB2D8g3d4/FEhDijOGZ3qND3/3NBq9tuF2iNflvfIS8C
	vkR6cXJicD46GBR4XQTbQtepjGobSN12E2a9Xthi7iA==
X-Gm-Gg: ASbGncuuNKK+wAQXMipYyvv15kmrvAWSVEEOLKAax8yLNlw0Ci7mkDyrSRX0amTkW2Y
	ItSM11vW/1sykrMNreSuXZkE4QzgdrpG4Av0zHFwphCklWneFtO7jYvwk9JscfMf2JW6ujEI43p
	irezPwCWxWBcnB3yOVChs07cnrWW5K/EBVlRI3HadKnZD+sX5EK8TS46hQyFTWBRAQxr/tOafQm
	9w3oTX3feANtfa3kQ==
X-Google-Smtp-Source: AGHT+IGZAJ8b0YkPbJI6nwB9uPLeNgs9zpFxiiAnMFlzG1hMkafUbWpHwREF8HCDungZg0gtUMcuWAk+xx/lpSPuMFA=
X-Received: by 2002:a05:651c:199e:b0:337:e4a0:ccf9 with SMTP id
 38308e7fff4ca-337e4a0cedcmr45750021fa.6.1757014094390; Thu, 04 Sep 2025
 12:28:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903-gpio-mmio-gpio-conv-part3-v1-0-ff346509f408@linaro.org>
In-Reply-To: <20250903-gpio-mmio-gpio-conv-part3-v1-0-ff346509f408@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 4 Sep 2025 21:28:02 +0200
X-Gm-Features: Ac12FXxWk1sRNmIPIFT74qDA0maXJ9q1kB4ftn-8phhL0UCY2e53FJ6aUC-84vY
Message-ID: <CACRpkdbJ--fMu-io2ryGu3QBY4EuiR6Eya4Wvor4-wb8QZrimQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] gpio: replace legacy bgpio_init() with its
 modernized alternative - part 3
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>, 
	James Cowgill <james.cowgill@blaize.com>, Matt Redfearn <matt.redfearn@blaize.com>, 
	Neil Jones <neil.jones@blaize.com>, 
	Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 10:00=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> Here's another round of patches converting GPIO drivers to the
> modernized generic GPIO chip API.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

All of these look completely fine to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

