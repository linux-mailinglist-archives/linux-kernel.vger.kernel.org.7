Return-Path: <linux-kernel+bounces-728989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 943D5B0303C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 10:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5AD11A61EF0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 08:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392AB242D75;
	Sun, 13 Jul 2025 08:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xbxAcRYU"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9162417C3
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 08:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752396207; cv=none; b=b80BA9kLf5vwDScUUbqHUAXXXbXg46GHYbjEGw213eVNP0lmWKkfDOuWeJEhkP6JHE2F0htGtKMBdt21hWom7W+vDre4YbpkLyJ0fXQuH7xUsZVogtc2X/JYkMaBRgzy7stCncOLoAwgEq6cjbwuoYuyzES5oReHhIHEwTHKZQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752396207; c=relaxed/simple;
	bh=teFEt5VYoV+y5Dd7IIHlSpW2pgBGTG1QedDMUy1wx8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tTJNDgpSwmrQ8WiPIvdalZevsrpUcV+e2J34B3UWk5yVqK69UtJaARzpW6Qxv0Fn1uaDBum4TkVuQCPs/7jP5xGWbuNKyBYsXG4LMmD7xb/P5Bgwp0wYcqAcLoBN0UFSvESekASMEnVh4lm2S2aVwAUk0gF+a9MR1/EQvbaEYcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=xbxAcRYU; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5550dca1241so3121575e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 01:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752396204; x=1753001004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=teFEt5VYoV+y5Dd7IIHlSpW2pgBGTG1QedDMUy1wx8U=;
        b=xbxAcRYUidJVofzk3N9o884D0j/xmj+1Mntya2TAmL5rMyomrvxwJYe8GFF9QKNOyZ
         aQm2gAUmEih5QTagIMA8js6hCnpRco1TlffNb8gj8FayfHQPFfTNyCjjcdys2QPf3rzU
         vn2qkQnvFTeeR+p8NjRiWsbcItVACaTrshEo9DgFf78b/Mm1irZ11p4QoJvtnXHT7EEU
         H+XN30jyWGbDDDfnZtlhZCjjV6OumnoxLLDHMfUOywy/A0AYdcypMslyi1WoLXqtQyvH
         /w4BBM+XMlPz8rvOi28k43tNGgtElv7T4G+rCLF1osJbtqnjhPa6efNGPsggMiVwKATG
         2cPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752396204; x=1753001004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=teFEt5VYoV+y5Dd7IIHlSpW2pgBGTG1QedDMUy1wx8U=;
        b=btc48B7qulig//bqhA75Roh74WyfhlhWB5QE1Uunu9psGQCWNrs4VMgJ7Vctr+rmGv
         YEr+kLBz2y0RqazdIURaeD1yqCNjigD3xmqxo3waclAzOHnOpFOh9kwc0AodrK7wdKeT
         j4bVxpVa0zVK60hdpWSTUfuJi7o/VXfAK/dPSm4DltVrT95jG+s396QbwzOm+o4RqPHn
         qZPxDdigPD5gYwdeFdOmHhIEQllhWrcjFv0PybgxESSGGyCpZEE3axX7DhBZZOdy0cWg
         /k/r/m88Pj8prE8myV00AM0e18lXxhymv5UJIHdKtlr4ovXi4waJBtjplalorb9EFEes
         u1JA==
X-Forwarded-Encrypted: i=1; AJvYcCX5TyOQwmcU7/HzLfiNnRnR7xnKAyvVLr2zIGtyT6TXdErc2dgLXilz8zJVrZYEjS0E22eltCNBGBNc/pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTksxuqX0+f8orXSaT0BeiqywhWOy7kg0cPv5yRgZDdTnRGKJN
	zqtXbyeJUiHgi4MyMgLtVPIFSwsz+fjgXUCMWI7y1nTsqzsBaTLx3FFPq1cbVziPVQWoZckjGy0
	C176vV7vNxCxOc/jf/dp7snqRcH9k8yp6X/m34gXDsg==
X-Gm-Gg: ASbGncvx38j0gwFWXhdw/R4hapJukkO0CZr+R0VRzDQK0xGNCciTNoPaAr82QIxMbQJ
	3ieQYknzQtcqoMzwaB3JsICBxiYOhfDlOqC+EJDDwQeAeQEGT835DtCq1uh1TGWw2iWV2J2fTvH
	LaqJOkUOTqhFdP3jjo9tPUU7Z12UVOH5eIROSt4lxyKJR2wgyeZvLwoy1jvUmOxtleiIWZoI7fN
	KxN9f3hNlEJFNQop4xroYBtQQWD2HWyvDS2nB02W0LFzX1Lxw==
X-Google-Smtp-Source: AGHT+IHBAbCKD5IYxg9QHbex64TGGdl/hyMZx/O9ZBosB5HyqtSevaVoy0zG6SyjrmS/Wv0vBuuPHSN0g6Rcj3+48Xc=
X-Received: by 2002:a05:6512:1114:b0:553:d884:7922 with SMTP id
 2adb3069b0e04-55a04668194mr2741453e87.48.1752396203838; Sun, 13 Jul 2025
 01:43:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709-pinctrl-gpio-pinfuncs-v2-0-b6135149c0d9@linaro.org>
 <20250709-pinctrl-gpio-pinfuncs-v2-8-b6135149c0d9@linaro.org> <CACRpkdYfRv-B=p61tVThFkjoqDGfcqOjmHxmj4wv-NYyky2-kg@mail.gmail.com>
In-Reply-To: <CACRpkdYfRv-B=p61tVThFkjoqDGfcqOjmHxmj4wv-NYyky2-kg@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sun, 13 Jul 2025 10:43:12 +0200
X-Gm-Features: Ac12FXyIRZr_PZFqMr5GkGp0O9WQSutVaydnaLLulDe-fCJJJZygxCd1lTC-X0M
Message-ID: <CAMRc=Me561DEHio+zN6oX9oqD6ue7z-y9E+cO_7_Z3L4taQd_A@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] pinctrl: qcom: use generic pin function helpers
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Alexey Klimov <alexey.klimov@linaro.org>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Paul Cercueil <paul@crapouillou.net>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 8:37=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> On Wed, Jul 9, 2025 at 4:39=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Use the existing infrastructure for storing and looking up pin function=
s
> > in pinctrl core. Remove hand-crafted callbacks.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Needless to say I'm a big fan of this patch set and it seems only
> this patch 8/12 has outstanding comments.
>
> Do you think you can do a quick iteration of it or does it require
> a lot of time?
>

I don't want to rush it. Let's make it v6.18 material as I want the
changes to spend some more time in next and not break anything. It
affects literally all qualcomm platforms after all.

> I am tempted to simply apply patches 1-7 to make your life
> easier past v6.17, should I do this?
>

Yes, please, they carry no functional change, it will be less baggage
for the future.

Bart

