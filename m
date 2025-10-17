Return-Path: <linux-kernel+bounces-857776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C61BBE7E95
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A441319A02E8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F1B2DC34E;
	Fri, 17 Oct 2025 09:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0MaXotk"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CF12DC338
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760694987; cv=none; b=t3gtSL+ekOZY0zMjJF7OmKFitY0lraJ0kZyqHHMfmXqiQIdE+AjtzXZ0BGejJf4mBj3zAxkkuQ2HC2tTgg06pIrSkiBTDbPwLOG/Rxtty4DcRE2PY8pahziDmQ28JpaufIFlHI6aA0dFhRacmMDvQzyD1QZ1izUiNc9B5HICBlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760694987; c=relaxed/simple;
	bh=rEcdNUhnQkS0I5XtW1CoPlxA7VWZfIMER4FzkAPDWao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BMTU4ao+0ncqBQ8MeBTQfORCS5ZZOATLwMaX3UyOf9fUZZF1atEX59rV5U3AJEsvn1E9aJGDzWRevl+qiYxZ6tR8MP82EIySqMZVLsllwSbZYlnjTEU28wFdE6r4NyoF0dSjtYCcBRZp/RM4MUwMENotVt3Nf7MCKN/If+86T5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0MaXotk; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63c2d72581fso624677a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 02:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760694984; x=1761299784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEcdNUhnQkS0I5XtW1CoPlxA7VWZfIMER4FzkAPDWao=;
        b=R0MaXotkaH4RqT7DXAH8f5PqEsHPR9BlgXGPi7NK+yWcJRykEc3x9+dWtc5TiiGAiI
         +Kio0+vg0scTDpNcGoX5SZ23KWMIeik6AWwbHx073MeJub+u7PZwa6d/4Lp0USz7Z6x1
         /Ydl3xpJWPCK3P9uIdFl69a4llTW0CLvUQ36G+twIOTqPA3hF4JxLAdM36hDpfp4ZPaj
         mtrcXNExS3Rjrc5DpHTABwu5V+bq4UhGW5VPXQxW/9bn1gbdYZf0lTO3a2HcnqY5NlTs
         R6QgL0mjbC3P6fzddzu889EzmzeymDPLQTdBZGLWp7JG6oe5Mxw60VdMa9SM8GYYKMMR
         DHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760694984; x=1761299784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEcdNUhnQkS0I5XtW1CoPlxA7VWZfIMER4FzkAPDWao=;
        b=eKzE4r5G8bZie8Iy2S5snwMqx3dkkQxYIYY8O3RTbEkMONWXU5DK6FGejSGYeURbAA
         4wRh6kj3njGgatHa1D+2hmrR5UNyVnHESeDQkn7cblo0QVqVbYWZXcL5asRPYeCDji4c
         YXOBoYj1JLQ6OfLJRiqbH8hva+bln6BXulbQrhAmCTQLzoKfusYK+7Aj9kdehGVP5fLh
         QPn/tmx1OPu7ZuQCiZQ4ix8QjQlawszS2k3YPlphHmFFNBBl65B/4gFmU/Xnf0XMal1c
         SgiAhzsXgeLUoY4vA0bYuvGo8VX7fXgd6GIdTEPyaBmDj31DCEMsiCeNu9plxVoWkeW0
         AGKA==
X-Forwarded-Encrypted: i=1; AJvYcCVtTTiLEAZJZKjLKFmq6nok+m2gekwPbiH2+sgWTokQ9k0KCZFf826Vaoq/4a6vFTqQ/C6BvHddzxMQG7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhNUG49VX85uDjzOJEYRxNMUJ0VBcj/iH96EQAWZsRk2yngCIg
	uyQxTnz0lrCk51cESU5vl7sgMzpNHG0oerNPadtd/nSPnZEXUDU5AfGD5XmBDA/8b7AxGCkLEXK
	zel8Qip/cyXW6xIB4SV4jEu0V+62gNZs=
X-Gm-Gg: ASbGncum9SwtBTb+rlxGq0fJMA4ZTvOa92a599zMW8rRxfLu0lhXY7rsOfWIjTLwaR/
	p4p9yzXabv4aI/LW8Mj8AGSD/aPfyCbCeRmSbjb7MZfFYh4or8TQEFPT4VCZsRQhzN57RlU2G1C
	G5AiTR/ca3wJptJYa5flH3aSfoPiQ5HODn7vi2uevCMuHJVdIO7pd1rV8U5sdMfJKtT8mrAsoUX
	wwWUOxNjDmK7USEBljnFNucM2M7kJYgNMQMlu6dgCd+RULWRb5Ky74ARDkBbw==
X-Google-Smtp-Source: AGHT+IHIBlLRTla75tbE4L9E1Bgzv5ZIwU4LRrpc2fLmL3EQ7rdSBDBBup9/WYitkzPac2rLYX5kvHc3YpAzwllbvVg=
X-Received: by 2002:a17:907:e8c:b0:b3d:30d8:b897 with SMTP id
 a640c23a62f3a-b6473241ed1mr303420866b.14.1760694983682; Fri, 17 Oct 2025
 02:56:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016154627.175796-1-a.shimko.dev@gmail.com>
 <20251016154627.175796-3-a.shimko.dev@gmail.com> <9f7514c69d11a0377283fe52fa6e7558b75c7ad3.camel@pengutronix.de>
In-Reply-To: <9f7514c69d11a0377283fe52fa6e7558b75c7ad3.camel@pengutronix.de>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Fri, 17 Oct 2025 12:56:12 +0300
X-Gm-Features: AS18NWBZMgvV7iogriyKPktuHwUDFbOQg9VA_DBN6dz8aE_cOJK2Sq_4nt-x6Cc
Message-ID: <CAOPX744yyWgZqkQaUfOf=GwQCS6MrAExP5s3Upnw-oO7inBChA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dmaengine: dw-axi-dmac: add reset control support
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 12:47=E2=80=AFPM Philipp Zabel <p.zabel@pengutronix=
.de> wrote:
> Missing error handling, or at least inconsistent with the deassert
> turing dw_probe().
Hi Philipp,

Thank you!

It seemed to me that these checks are not necessary in the future, I
don=E2=80=99t know why it seemed that way to me, I=E2=80=99ll fix it.

Regards,
Artem

