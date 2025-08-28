Return-Path: <linux-kernel+bounces-790541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC2FB3AA10
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAA84364481
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D627273D92;
	Thu, 28 Aug 2025 18:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BNeBrZ+E"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6441F4C8C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 18:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756405848; cv=none; b=njRpIJse8AtmztYhqWK/hldeCYSkGGD9AkPpGqKhQzywGADsjc+bBfbnn5YiYP3M4TICULH1Q0HZe3aq93URHC8IMFyiV6LgN63yLJb8FBazPTeA9L6QT+gRUH8N+dKxKfpN5otkOxy/KD8E0Ac2zxHFM5BfJEezcGxNMvgHQNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756405848; c=relaxed/simple;
	bh=+cJ/42k0VYV0M2aXW9zlZKPdMXAl4MnJ7P2jUvIq4L4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SCHZBwMTiNd4auCdR9I6nBwo2B1fG4om1btPCDAA2BhZW3YjOyBIgPBaoR/8uTBm2iuBToIGWqqmnAlvVAYUdY7rrJ87a3yv3FeLHbNjrGiKm582a1nPC8kFuKO7tjcwhafHLyc9vK0Pnbkoh6Y/S3hlF6PZIpa+HoVlpKC6fcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BNeBrZ+E; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55f469ad067so1407088e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 11:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756405845; x=1757010645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuEqj8/T+xiUJS7ax+9xjCXIR39EG8IKnjSfY7eLrqE=;
        b=BNeBrZ+E38BjyjvupSb2gQHpE1SplDzA9594rrZVAFinmH6jndpyrOES7ZCYjEawX7
         Zu0Q+VE+9IdXeHMVLPrzvkbDzItx9IfMnAyP2IPlsOLU7HMiawzKS36nYt6dXjtbRZNo
         7xjwH7XnljcnSyxmb+MSrj4wJegCell3tik0YXHc+v2KiffxqsVvM1lSEye06j4wS6vy
         bDOdXZEF5uKfzfsC2q1hTZ46afGd+A25JzBmdbv+dl8D6dR+/5+k5c3e3lNdBrn5WOBb
         RLCjpTxvYXpM23xRSqmyhs0S8A2MVZyr1ZrA2S2bDx/aWlch9M3VRKTjNMchJcnIpS5T
         avQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756405845; x=1757010645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XuEqj8/T+xiUJS7ax+9xjCXIR39EG8IKnjSfY7eLrqE=;
        b=rAkB9KrF0g32rBUbTLyEEGHR8x1nzd/wewRxJ67RHHXJkFs71s8BSKq3vnWOUCkK6t
         3FjcPqqQAs0wa1L4O7X45RxKZP52OHXfJEpdO2OPk6kE/LlfmL5wJb6aaVxZh+/SJvzS
         OZUq43t/YDsb7h70NYfYaGp3uFm4VbPm5uiMEyQX4W63kVlRuVYJtTpeeo5gvUWD4BKb
         L9duvBQDzNEfqbiNeuB8bqG1PzvLWjx1hVH5ajNbtub1UBqeuIEx6g/Wld6G/hI1WhBU
         4EQ9LmoZCmMABgNV5y1xQ54JsHJpxzzdQnPZnWuTkEDm8YxzCkMlXcN69UpLr1/jA4rb
         LPUw==
X-Forwarded-Encrypted: i=1; AJvYcCWN8CP4XqVGKmUeaaQCwFZIqtkM4+ktWfzt416OcUFqGmct1YRWWR7ucL12yI38ttKife2KiDrdi/nfGgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzquMYEToBWo/SGqr+SQ5s/j8jTqm61COBlmVl5FWphE3+JQXdg
	9fOIdVfXYH+0Cevi4bAi/Pi9LLDHLn8vuO1yE6/Z8C+VwMkkLijJA33SMSNvHk0KjrHO1QiCB8g
	aVrdGjPfaUNfU1P+WN1+mmjx0Z7TBVxzjPHCXD3QKkQ==
X-Gm-Gg: ASbGncvtUafXGEE2SVQfbME/CE4FZALQzmUmH1Mxk6szmAH+oBSf57xoCkXeQeq1DFG
	IEYR/kSZGF1/pIAiMQFZD/LAl2iQEVP2/tLoxoAiX0vOte7OI59zyosyJ6v8LTDkBzr9TWfkm7w
	NV91eeF73B3cmyYt1IzSkIv1lvYN5V54xZ6RofyosrQfRh5vNDKUxIzfsuBS7WvvIG81cGH5lAz
	M5a65tuuaCN2F3Lpg==
X-Google-Smtp-Source: AGHT+IH/8kZJERm22+qgVkI/2abRlg7jFqSaoz19NfilAs8gqvm1/HMq3/qWcpNYFOG6zrPS0q3FvE7sFdLPB8sog2w=
X-Received: by 2002:a05:6512:2c0f:b0:55f:3f0c:e267 with SMTP id
 2adb3069b0e04-55f4f4c66f2mr2837563e87.17.1756405844595; Thu, 28 Aug 2025
 11:30:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827074525.685863-1-alex.t.tran@gmail.com>
In-Reply-To: <20250827074525.685863-1-alex.t.tran@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Aug 2025 20:30:33 +0200
X-Gm-Features: Ac12FXzu3BqzQAEjjUx4V_NHl1QbSsY2Iqe-wW7HgjaVEzgtXC011QXplgETcSQ
Message-ID: <CACRpkdbct3o-=-hy97OMg1O+E_Tw8cNzRTa_kh0WB2LxJrHwJw@mail.gmail.com>
Subject: Re: [PATCH v2] docs: driver-api pinctrl cleanup
To: Alex Tran <alex.t.tran@gmail.com>
Cc: corbet@lwn.net, linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 9:45=E2=80=AFAM Alex Tran <alex.t.tran@gmail.com> w=
rote:

> changelog:
> v2

I think Jonathan will trim these two lines when applying...

> Replace FIXME comments in the pinctrl documentation example with
> proper cleanup code:
> - Add devm_pinctrl_put() calls in error paths
>   (pinctrl_lookup_state, pinctrl_select_state)
>   after successful devm_pinctrl_get()
> - Set foo->p to NULL when devm_pinctrl_get() fails
> - Add ret variable for cleaner error handling
> - provides proper example of pinctrl resource management on failure
>
> Signed-off-by: Alex Tran <alex.t.tran@gmail.com>

... but it looks good otherwise!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

