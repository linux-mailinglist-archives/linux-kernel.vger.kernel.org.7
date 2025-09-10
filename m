Return-Path: <linux-kernel+bounces-809578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF403B50F63
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0B9D7B85AD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 07:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E0F309EEC;
	Wed, 10 Sep 2025 07:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="S3ZBQqHi"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949A730648B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757489354; cv=none; b=lOD2WtkEGnQ1j1wOQEeX9AJ3c7MzD7L6p+cDMimT6zwe4hCMNLlp8yFfw691lkvkYGdAg8KxUbix+LKrHbdbmv8mN5y9mx07VlZgawoMW+yK19qUyBPfcQXig41neoBih1nR4kMksycHm4C42nOorSfx7SgI2VkKlX0zoNXUwHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757489354; c=relaxed/simple;
	bh=dPns3UYk3HTy9Cu967vV+y/kprcH9SmJknyIiH6KUPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lx65AuKdaVxYRvmC2S7sM/vgd27k74XQNO8WrfGk1+qo2RW5aKv0CEOqi0uFuUQazyZ/5eazsA75YWPaW/geqIIeAfZfj4YDnZfSnPvbBfWBlMgc5yUezfIierp3NRRXPseguo/hzHEI+DPnc0O5fW78QdvgTZn2IHs4j9E5nA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=S3ZBQqHi; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55f720ffe34so522434e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 00:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757489352; x=1758094152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPns3UYk3HTy9Cu967vV+y/kprcH9SmJknyIiH6KUPg=;
        b=S3ZBQqHiikNskd8ERRrm+ddhpCoyKNLWEmgM/pvHM0bJG+CpqUZTk7WciMYTQm3v5Z
         N2rd7hIqOHrRSKANT2hUVCahtf5YQ+Leo9VMtX5ryuHzLMWz51KanPEmS+YHVG4eoUpA
         1gUNgSnTfLcOmA2acD2IFBhr2gH8dMFJbMAkfNRvHmsde1UZ0zyQcDSPvCY2F/pnmjya
         xvkeNorLrYeT7bOXDwHUCPUujc2tCl19ih48UyUA42lASex14+TFifLPOy9/83vS64st
         M3vz8JIO4izSQ9ffKiWIKMV1Qi98/+kqaRkpyUXjpBiudQUaFuFQ4eBFHWeiwwd7QRlT
         FnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757489352; x=1758094152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dPns3UYk3HTy9Cu967vV+y/kprcH9SmJknyIiH6KUPg=;
        b=C8D2wGsLzPaA5nSf5pKe7StzR9XHBzrbJwDtcll+CjsBSvfW6Zpoz3xvj/HG/dR6dU
         nPvp6XUJaB0dIqzmMlg2N4oJETNX0SQBpBqEo+8QOWte8kDq+RVcG1U2ENcb+epz9VIU
         ZF70bHuDpNCq2rTsytY3W2uLqs9x6Pp7GAgppNKdNSoZ1CaRFqVFPLUAEr7mTpckihzw
         aRn3Mhxyq/pY16NbFxFFT6ebapgN9PhtAem4Raia+25uzopZ+f7MN7/LTxcmRCHrClPf
         GVWJgNJIe8LBlu9nH2CkKQ40JoeQ3WnRKFf/RX5n4DbjpnZrvEE1AiqBDW3AkdBkGJWO
         SNoA==
X-Forwarded-Encrypted: i=1; AJvYcCUlEARDDFaeXoTCcHtIheNrOOg0kJLdeejLwPdzjoLAYPLUY4gz4vwNrYCU8Xc60JJap0er9mBNG+uvkzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE36+15iVbaYdI2ujaTNqTM2/mx1KUkFfGqZUB/V7RgbNdF/7K
	BEs6IJj8teA2FtnrDSQvXdKMTmrJos7V8X2tk5/W+ojlqe2XxzvNPYO43yh6Ppin8h3T4l5wDkX
	HEKyvGdryd/dXNcFn0xMF8DkL4K4s2FqMidUNaQMDwA==
X-Gm-Gg: ASbGncs+GAwCKlA93ucBHoA4lNDjYT3aH2EqyNR5idjkJ6wFn7VMscqdt1sdVybBvMm
	jiqR6PFvhDLq8dFZx6O/oga0mq6NL3Lo3nIfVEfTymK9ivZHHdJRK+1874PePLw319TY3g1R4+F
	Y8nPns8siSNWkZhnPf6t4nROm+NyomQSBXPUutBvcrDkkeA6UGwsisgzkYGDjc28cXpQbCEZ+Oo
	YGyWIc8KoXgB69VGQ8wlM//rOzOzOL5qKVA4N0=
X-Google-Smtp-Source: AGHT+IEqPJ9kigcz2GLj3mP+JOGINamypRE0PiCaaHlUwxbs7HlrGNQFZsWt9jHWryRE9N3BOTU+Nqgodo1ymFIXUx4=
X-Received: by 2002:a05:6512:3c93:b0:55f:552c:f731 with SMTP id
 2adb3069b0e04-56099453ef8mr6704484e87.7.1757489351780; Wed, 10 Sep 2025
 00:29:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-gpio-mmio-gpio-conv-part4-v2-0-f3d1a4c57124@linaro.org>
 <20250910-gpio-mmio-gpio-conv-part4-v2-13-f3d1a4c57124@linaro.org> <CAHp75VcczAm_=XXAjwLFqNTCF72-UJfdisPvavadDEXJR2G19A@mail.gmail.com>
In-Reply-To: <CAHp75VcczAm_=XXAjwLFqNTCF72-UJfdisPvavadDEXJR2G19A@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 10 Sep 2025 09:28:59 +0200
X-Gm-Features: Ac12FXylJ9GUUlvsjAHDZW0ZjH7_XucWxGNpk3CSzJ659744jxYcf8C0LoVlvQM
Message-ID: <CAMRc=Md1kLjELc48-fvjsgpZH+t+kE00v0uMDztubooM_AJ2oQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/15] gpio: sodaville: use new generic GPIO chip API
To: Andy Shevchenko <andy.shevchenko@gmail.com>
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

On Wed, Sep 10, 2025 at 9:19=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Sep 10, 2025 at 10:13=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.=
pl> wrote:
> >
> > Convert the driver to using the new generic GPIO chip interfaces from
> > linux/gpio/generic.h.
>
> In case you want to take it
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> Otherwise I can take it via my tree and then PR to you.
>

I would prefer to apply the whole series directly, this way the
conversion will be done in one go.

Bart

