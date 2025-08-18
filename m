Return-Path: <linux-kernel+bounces-773286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEACB29DBE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3429A3AA1B8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FF830DD37;
	Mon, 18 Aug 2025 09:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tTKMA83C"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3076C30EF73
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755509114; cv=none; b=Y6sOmN+BaHtXfZ03IhKCag7+U5ysYJr0tOPfVbZCOpVmo6mkeIYYwywBsEq5R2KLI/oGx9NOR9k914yJc74lg+v/Uv9EOdi0/ZagK5+hUJT5ag5d34ML+AcrbxLmdSbcTJDETvb8f0vcTY3nyP9OyuZcq+uj6/j7jIsmVJ3aaaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755509114; c=relaxed/simple;
	bh=HWl9Wdg6tQt829hLiKPSU5FXqMuW8JcenL87lFgKzLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NeZVN9Q8NMw/k7sqWRuEoRKNmSeuFjDO6q7lVazkcJkgiDnFpi9qzyqR2VzktwTXPGGByZvaUGCRX8PieNspchkpuFN7ptOuuAYhpxl6VpuWxYuYz5eyMm1MOhOEh3wlTv6ryEOZMLL1Nj2WcF8bYH9C2l8f06hl+LGCuVPVoCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tTKMA83C; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55ce5253a57so3874177e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 02:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755509110; x=1756113910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWl9Wdg6tQt829hLiKPSU5FXqMuW8JcenL87lFgKzLo=;
        b=tTKMA83CTZnwG1Fzs1wd+x8pdeVp4sIF+sUxFUEH+4OCpsOj5gcch24dW2ify0XSN1
         MtYzgg3CAawwvv9RsQQFAQFRyBGqhr7hB79k9djrywVjEHdjH1sDtAv6fJkLQ0NN8Kg9
         9gGV3b6eBVV9lsgDTW5CzQp79BVUckLC5oc1/mWQfYQ/kn80xYMmrQkcA/RWf8QEl6ZH
         WWLHae5aVyX05yRdufqBGvyxSIS+Frc3bXDtoTGcJ8892M4MBPkGg7bbnl+606sUiLwd
         auOs74ZiVNn+2CBJ7c7ivVpxjnPc/Hj5Rdf1DLTgvlRtyx8q2MhCErrfPTwZ7b8nsQPS
         tTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755509110; x=1756113910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWl9Wdg6tQt829hLiKPSU5FXqMuW8JcenL87lFgKzLo=;
        b=G5RGF1z0EiZjplrUioS0THfWiy65jL64ZTsZwRtDkF0RmMjo6Q3HVoOIoGlJvkL2vz
         PaMKx2Wn98u04g8rMZ75t0tDhjD18luqq1vhPA4LwcvPzK00ymhCOGyhRamTlshzF6bG
         6et+rB0Gn0ovdJ3TcdtFsOOa3STnyzJ1GN9r6M3a0NyVbqxa/zEJ6k4y4PzHlTHPilxZ
         IzGHLOFfY+yL91iLdzQ6ZMrfj+rZxgjoXZEk5hwkrzsiQKn9BKFIEBEjwp+vDUwT1NWv
         kaKy7Na/KUFYVKZO00dtYXR9ACF6rJULoU28r6UhTans2jvCkRZpEmWeu7+8shmxeVh8
         K3mw==
X-Forwarded-Encrypted: i=1; AJvYcCU25v9O7BNqkpqjRNCjOov7UfyYGsuIaHikCIknI8AN57EP8gT+cg8QnkfTzFYezRonYjU4675u9xFwQ9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/3pPgJk/5EnuQyd+sXs7bzEnCrxpE5rjMxBdMjaoq28SGT/iE
	r+P5jwctRXysDJW/IEIy+a0m6Og2WBel5CGHuCVqKfVGg9IhGmq2bmqegLo0rrhdwkYUlziuQKk
	OuT20iTQGyctA0aM+LXpZFnYS5O5gBeerqxXodk8k1Q==
X-Gm-Gg: ASbGncsH4W8xcLS/GXAbaAeOWTFFxkLH+CjP1RCyaphzHMxcvgQ/BhHVhu8SrSnwK+0
	m1vvWvhDZVsnF77z+1iELdkBpwwD4SI+cSL2e4PlaeUMQzlJ8mrHLCoa3YsIIHGuKyvPu0b8o1X
	BPsT1FyoY1DvZ07VAR0IskVHj+CGPWiNNt9jTq4GeLpacipCOS5aNynWvHXdJszsJotvE/enI61
	r+A88W3oI+I
X-Google-Smtp-Source: AGHT+IFC1ZjNERncmt6aCwcSemfraYYSYedGgU7En/j6NqE3CZM6qjD72eC9aTSLaWwQX3FdwMknfiQchSSy/0ZOP1k=
X-Received: by 2002:a05:6512:104a:b0:55b:760d:c2f2 with SMTP id
 2adb3069b0e04-55ceeb68062mr2942102e87.33.1755509110245; Mon, 18 Aug 2025
 02:25:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730061748.1227643-1-me@brighamcampbell.com> <20250730061748.1227643-2-me@brighamcampbell.com>
In-Reply-To: <20250730061748.1227643-2-me@brighamcampbell.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 18 Aug 2025 11:24:59 +0200
X-Gm-Features: Ac12FXwBqttAHWn-Fzo0FTZhwhrfc7nvpSbb3PEL3L84qoflel5B9j8C02N8kLo
Message-ID: <CACRpkdaZxPKmi3XWxKVG+HpssdH=HGDa68Ek=bcX-GEaQXaSbw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] drm/panel: novatek-nt35560: Fix invalid return value
To: Brigham Campbell <me@brighamcampbell.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, neil.armstrong@linaro.org, 
	jessica.zhang@oss.qualcomm.com, sam@ravnborg.org, dianders@chromium.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 8:17=E2=80=AFAM Brigham Campbell <me@brighamcampbel=
l.com> wrote:

> Fix bug in nt35560_set_brightness() which causes the function to
> erroneously report an error. mipi_dsi_dcs_write() returns either a
> negative value when an error occurred or a positive number of bytes
> written when no error occurred. The buggy code reports an error under
> either condition.
>
> Fixes: 8152c2bfd780 ("drm/panel: Add driver for Sony ACX424AKP panel")
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Brigham Campbell <me@brighamcampbell.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

(Maybe this is applied already...)

Yours,
Linus Walleij

