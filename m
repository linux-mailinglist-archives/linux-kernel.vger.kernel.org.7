Return-Path: <linux-kernel+bounces-895185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5167FC4D26F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDA57189E2DC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2442C3502B8;
	Tue, 11 Nov 2025 10:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zCzix8om"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2218347BBB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858012; cv=none; b=R/kLbSqmbOquShUCpZalJkWJmTa5MNZz7PRJmKWa/fz2F7Yy48Jkde4dpDC0WZutTHmiOETGhuTz9AcfYypYBoIMOzgngf9JvdPgRuJbUQIUwh799tEBRUrG4swQIVMeBYz8XZAc0yJ5npL3ufpIESqyoOmtqx+PFKmsBOkl87w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858012; c=relaxed/simple;
	bh=Vzxu8qssjIhFl+4HzQqYw3E2J9WYZzlt8qmmQpR/9RM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scEm2tAIMXlZlcqZrRjcyjwASJ8xyR69UbkT6TTahBikL8cPJZlh6iGiE0ffs05ClCOdOJvIo8WkfZRkGwVg3gvETqiTyUN+RhURp0RpGX4NdUUOQqwMCthSyUvw8/gU6fdlLVlSXw+ZeDyLexMQjPW2eXMqyBS3qqJSxpWPx4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zCzix8om; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59435d82c1fso4121110e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762858008; x=1763462808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vzxu8qssjIhFl+4HzQqYw3E2J9WYZzlt8qmmQpR/9RM=;
        b=zCzix8ommVmBggohX2nU+Nx+FqVGx4/zUmmK+OjaJhvAI3brORS7qwNax8HvXSpXh8
         CcJa2oGucKwgAfdrStMagzvTnzRg7Bv65JgpYOlGqq4MObFK+/GMg4fEFgp2K8zCGhlo
         DWMiqIcU9N0+bL0z8Ft3BUIe1kSxP1tqyQD4Y3BHzWK89xnN9Fv14T/eU9BqR/EGOB6l
         HyUfRQHjhARMcL/wJNAimVU6ufIpLIyk35vSx3x6liplpDrfUXuklPWOcfdqusBZN4Q4
         b2tLhUe5Aw93PhHJN6fET/FppHDUWA8owqFT4k0oURldYsDci3275Vya8GOz8t+zI+wc
         ZEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762858008; x=1763462808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vzxu8qssjIhFl+4HzQqYw3E2J9WYZzlt8qmmQpR/9RM=;
        b=oHUF7faG/vjC1RdPvHDbJ2nEKm0KS4kpOca0jLgCzy+z2rpl5hjAkKesrdBmAuTPu/
         q0r+6yIP+4/LTIV6kgJkVwMBBsctxJuD0lfgikPE/TVw+1cHK1qPcs0MxyX0gX2637iV
         A1mCEKzk5hYNdNrzWbGh7A9KMV4YyKXl2wZVwbLtjTT/Gqy4rpVLAFw28Xgkhq5QmAGG
         EArT8Jkj/DDZ1U3rxsRDbJiQRDECK+NW9McfzmpxoNa8XUPYO+vzFigFtEi+ac0jkKux
         rtf6YFmlQDY7QpBp7zmaKP/sYZrDa5+nIc4TSaDHviYlV3wqD5QqZR54r4mcMj3xeTcJ
         jgpw==
X-Forwarded-Encrypted: i=1; AJvYcCWQcuO8k6rb5NqiNLyr8PxLl6FTrAU+CDZGa8OBnnzsO5UM29Nz50gvYnDQHuzGudp0ypP9vcmiQjR3wBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtfxVhrXRAkPGLA+K+Bsb6sRICDyw5uG9L4uXsvm8y6fjBpRCO
	BALaiTLKc5m9fySDdnc4UvobxQS5Xh736DfPIcEd/UXFpcYk0U9qxZ9cQc5740LyY5lfZz0sd7V
	YMcANtM/vk+aUk96GZXEOLRwonXIBvZ1S7bF67UWWeA==
X-Gm-Gg: ASbGncsq8lec6EmWUKWgEToxS1Df7hBfmzG/Lk1muvGrP1r0elz1Xx9FuiRm0eAhmFC
	CT9B4DkrAJncVxETI1kWGVLc3YiFksPsSoD+47+ISnMElX3cTigVXkakgXuFjGp6ZwzSwzYeHj2
	cbw/rCLNIYYrfq5LogEHOtP98HvZ1SrVrXCaQPzbA8C2qi1xQTjJ6Kfh/PeACdbcxuQvsFEp15R
	jPkCLvkAXC+79CJeCzU8sHzCkNtA8l82NA1B7gehbpK2AycCvAYyEymyfOC
X-Google-Smtp-Source: AGHT+IE/zC5OMsYl03Nj0mPJmaD1a2IXwBvVIbEcz3pKu9CsBoN95WeMpa65Ti7xOQGESKhkoy/5byt8ZxIuQV5LRlc=
X-Received: by 2002:a05:6512:3ba6:b0:57b:5794:ccd9 with SMTP id
 2adb3069b0e04-5945f1465b9mr3570547e87.9.1762858007876; Tue, 11 Nov 2025
 02:46:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-gpio-shared-v3-0-71c568acf47c@linaro.org> <CAMRc=Md4X-GWpeRgun6zv6dddKFqqrjUSveq3fNOe5AboLAcXg@mail.gmail.com>
In-Reply-To: <CAMRc=Md4X-GWpeRgun6zv6dddKFqqrjUSveq3fNOe5AboLAcXg@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 11 Nov 2025 11:46:33 +0100
X-Gm-Features: AWmQ_bmu8Uv97qyqiqkPQLTOzsrjTmZVCm9AYfJGSsxfxSYvRIGYvQTliDsDKgo
Message-ID: <CACRpkdYBZQJsptXhxOHvFdNwU5_-_QDfaLN6tiDqgL=bBWoXmQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] gpio: improve support for shared GPIOs
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
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

On Mon, Nov 10, 2025 at 10:46=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> Can I get some Reviewed-bys under the GPIO patches if there are no
> other open issues? I would like for this to start making its way
> upstream if there are no strong objections to the concept. After a
> release or two, I'd like to start enabling it on more platforms.

I'm convinced of the soundness of the general approach so I have
added R-B on the gpiolib patches, FWIW, for the rest:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

You clearly have an idea and a plan here, and it looks solid to me.

Yours,
Linus Walleij

