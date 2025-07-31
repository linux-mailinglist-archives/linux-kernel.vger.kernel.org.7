Return-Path: <linux-kernel+bounces-751845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9B7B16E2A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D32E71C20173
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EE629E0EE;
	Thu, 31 Jul 2025 09:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P9fNd2UY"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B8128D8FB
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753953037; cv=none; b=qTTq7OL99B8LnRQVauKHRaoB3/6PPh/EyTit1cvUoGeOR3zghgk1ep2NNcsY9U9FmyR518Ya9O8+xpa+PARToqs/w9tmh63gyqaB9dJ/JW8F3t9USx50GMv56LEgOoGNPuvoazSuuh5viyzc6XDxZ94NVq9fbpLIYpUmxXOhE9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753953037; c=relaxed/simple;
	bh=hRwq5x4VwHGS6JkevscNB7G4mlDeMcL9xsQzNX6TfQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MMOsqdhKc+VeMVGxY6NCeah2f7700w4UUt2JRKa8mWHqcJNbfyoxRV5bkqVkWXnXYvKCLXVZ4RjoXGfPMLjJ1PsSGhEY8G6aVnr74OtZ9q6aKdrGY6fmB9u1A2RwtEvROvcTCezZ5ZGJLpkClLfKndMLWTFWUCnp2uWErxJjgbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P9fNd2UY; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-32b5931037eso4851891fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 02:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753953033; x=1754557833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRwq5x4VwHGS6JkevscNB7G4mlDeMcL9xsQzNX6TfQY=;
        b=P9fNd2UYNVNZQqd1yDjNKuMea5eKckDlwKZKC8rR2GOmGrQkvKe5ez2LRsuCYoEhB/
         hQCmSfcv9qh1FjPM4D11yRcCRF2LDbipR4azhKqACk4bxNb/AZUriPPamiqt2lhKcOns
         T85hdfeQSNBKcVOL2dd8F+/7SxyGanrn8kock=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753953033; x=1754557833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRwq5x4VwHGS6JkevscNB7G4mlDeMcL9xsQzNX6TfQY=;
        b=Jy/jgtvmzOoyS4HcGFdvo1766kmIsNWv8WaOcvppKPMFbqcyExoHQEy2aIVDhwSJuD
         WhQ/PTOXh2gCiKpBxO76ehrjjeU+YxWDnrV5jcPk/rg0i9vdIPPAm4YuqxniGijXQ+XL
         ZH9NRBw5itflgU32QhucfHFDogd7MnPixvTLkNd7yrLQusMs/PApdhH4oBXxQuCAROg4
         8f5qKwA8QhxW6OqODKV6wDVPh/l/BMvg7kx05Ea1+SzkV0eWlEWtjquOJGg8P+s5B86n
         DKt4XN2JwBGVEXVt74X9oGUjHCxz1TyhMj0+DR6hdjRMwKWLa2FL/3Oram/unYej5Ner
         h2lA==
X-Forwarded-Encrypted: i=1; AJvYcCVwPWGSyOdK/7/YC7I3vO8JgnQko56Jplb9OUBVxqrXX/vPHSdpoB2NImU3A0qJ137MOwQb8VVd93qZxkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB2tnFSybH1DKe7sUqgvfKYDlr7ptZFHSK3vnfWTpow1nJF9NU
	fGj+AhumCRNRQNJXwqc8scFqDWe5EbS/0eQl0iDTXkdjtW3nRHYJRgBq7MfqBMiTxqvLWzTBmE+
	Y5WbYQana0/aGnSkrcgcMZuFcougXWfXM08nvER0C
X-Gm-Gg: ASbGncsSG9/n4ZvIWeLJl9AMMQ94GsJCDvcytb+r6eOw+zsrvKlO5WuU0TZc5Gw3qHq
	T5+jOH0nFIOZEn01R4C/WixRz1Ow0wXVcjs0ce59dmN2kXg8g15W9N19NmlZg3x8lb0bT30rg/l
	mBU2QAOWiWgdhpju9MEtMQhmdZ5gYUv/2YdvJTXA5UNyUGvEGGSoBBRVifhpmzw8ISPrDj/DAca
	TN9+JV/X5jh0JUkH3PkfWrgnpjPx1C/R/8=
X-Google-Smtp-Source: AGHT+IGy0Gr0CeJFqOAF9pederTnU2rsst1o/T1ozFpoxo2U18QbJElG5oX2wY8idW4WJNxX3lI94NTcxLdGpZxd8nA=
X-Received: by 2002:a05:651c:554:b0:332:1720:2ec7 with SMTP id
 38308e7fff4ca-332248beecamr19682921fa.0.1753953033319; Thu, 31 Jul 2025
 02:10:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730152128.311109-1-laura.nao@collabora.com> <20250730152128.311109-6-laura.nao@collabora.com>
In-Reply-To: <20250730152128.311109-6-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 31 Jul 2025 17:10:21 +0800
X-Gm-Features: Ac12FXwCRD80agK2VpVTgVXGMFnqiS6tk-7RfCAqmaHj7sFRHCdDG6ywSscGSLk
Message-ID: <CAGXv+5En_Yxy1BoWWTsQPSLYCqvd0_r-JCtEByan9xNU0QLmDg@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] thermal/drivers/mediatek/lvts: Add
 lvts_temp_to_raw variant
To: Laura Nao <laura.nao@collabora.com>
Cc: srini@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, nfraprado@collabora.com, 
	arnd@arndb.de, colin.i.king@gmail.com, u.kleine-koenig@baylibre.com, 
	andrew-ct.chen@mediatek.com, lala.lin@mediatek.com, bchihi@baylibre.com, 
	frank-w@public-files.de, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 11:22=E2=80=AFPM Laura Nao <laura.nao@collabora.com=
> wrote:
>
> MT8196/MT6991 require a different version of lvts_temp_to_raw(),
> specifically the multiplicative inverse of the existing implementation.
> Introduce a variant of the function with inverted calculation logic to
> match this requirement.
>
> This ensures accurate raw value generation for temperature
> thresholds, avoiding spurious thermal interrupts or unintended hardware
> resets on MT8196/MT6991.
>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

