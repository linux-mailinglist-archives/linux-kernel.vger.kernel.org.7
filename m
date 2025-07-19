Return-Path: <linux-kernel+bounces-737809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E2CB0B0CF
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 18:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60DAA563CF9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 16:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0721C287515;
	Sat, 19 Jul 2025 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LE2BqCM5"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B645C40BF5
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 16:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752940950; cv=none; b=jBgWM2h1UYlOBMVu6efxJd48qhjsXdr5MM7RA2kuIKtdPmsXd97XuOstJEPX7LbOZw3NnkXN//xGR128BMRdYB+rR3aSZmaJDIiS2zSIXhBeAHDh1ndO5VsK8mGHRMymsfXpB1HNF6Y+RgUc+ftRWO5Ag+U3Dt0GG/hNv/NFqgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752940950; c=relaxed/simple;
	bh=omxcvlFB5WsNU7W/SPacQy7pFjeWx/NXXRV3R/gNeMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s0+76bRVwAgqtQcnl//8hQZmgQNbCvBqAAojNKJXmf8vaYTEBZz+a3lFVPNbZvZGrQPRGQOg6uvUFn+epliJyBtv1yN2Iu9Jm3DlXa/Haoa6FkLMBfy0FfsCNWA0sASsZzJMyy5RQgGENbwx6aV0DW1o9uIRFzo509ee8OXuulA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LE2BqCM5; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-553b3316160so3197216e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 09:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752940947; x=1753545747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJxRZr7iN1QAKs2m80VW48YbRh0uObEphOGlhuo4nf8=;
        b=LE2BqCM5hp9mS1GmvHga7NVq3laPX2EZtx69qWEeidhXmOCJyc+9rVO2IOpA3QoWfT
         QVnut84cqtlhsWWrBDZ3x3BAzj3XlUkhVxA7VHWMvaeLpm5IFdqME/G60u3gl0SiPBpH
         xPXWqwP4VpHqscqBsQ7I09Ed0w6/SOTXE2TpfyhJ3RBxnPJxNp9VBouWVBnTaT9JfPqi
         7o+IaR+DdrgP+K/Avh90KxJQPkLoufmSqYGTkFY3B2ko0SxMDxiKEeIelC7stOdPTN6L
         cm9E3HR0lmp+VXmp+Su6hDg9AfCfScwJHgQ9RPtpfi0m+YC/DSfKHnmntKDQcl70Hzs/
         Pyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752940947; x=1753545747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJxRZr7iN1QAKs2m80VW48YbRh0uObEphOGlhuo4nf8=;
        b=s00PuAM6sGmn2mPazRYrvI9eHtCv3uja9aGwEpk0eYVBU7wTMuHUZKvVnKDE+NeIjr
         uXXpRnut5mf5CFh+uL3NXWGMjzhzqtYWsiXYUgvXzl/MAwd+zbP+LjmaN16ulqrOxXve
         g3R7o0IKcxqAyo4LFqkjzy94m1ZTUiKZlqN8lfMOGWhx9hkZEfj54BoJ3X0KOjWOayhZ
         V7ucRRShE3zYTYjJ7drEptyV5oVc2GRlk6vsxYH/Q+BqryuA5WUhq2D5XES8uZ4TXjVR
         CQnjdqhWtvtG7U5jvp6crsn2BncsH0DJuAvsTovTN5avLuNfi9X1XuYXOZTBbLbC5YWD
         MTnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXlv1HXf1wEmFLV0wUHM9MN8x1HEBj+DrjvR5fzQIs6MysVQnr0gUdJxlWS/7Q1n934rEQ3bn/EV2jBF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbMZDn1GkXOfi1LS0H4d3641aHWFDMESMmW8tQW7+u4SgiTB0d
	/nXgMFJ2G60lLjhRQ7cQd3LL9lmZ8+k7WAzU9+q/Ny3t3SDWo5GLhtOe6mRXWewb/K25ABvtp3G
	+Vu119wIPUeW/9BxJB5p9Wwfr4GR1tP/mbWBwXDrxzQ==
X-Gm-Gg: ASbGnctomk3fNPQryMUQO/22TJH3cnEqye6K93lWL/I3cp3HJbY9qFdZix7m5qX2ZGI
	D7YA71mi9vgiYAapSXGfH6Zg2LyKG3m7JKOwH9cqrNqJkR+HqlLYmWgNx6rQzK8FkeObP4F6lA7
	lDs3/iABgl2QZrm3NTguRkCs7Tdow47sJxDuz5HGiAWEafybl81EXxaKl+P9D3R5Pfq0OB4969B
	Dvd1GE=
X-Google-Smtp-Source: AGHT+IEoUxfZHhjopPDobqn7dOjOmBm5Yh2lx21AMKQLkwO7yH4BlU0K80uOKrtvDizTOqyz64KGrJ56htRl33CUOe0=
X-Received: by 2002:a05:6512:3406:b0:553:241d:4e7d with SMTP id
 2adb3069b0e04-55a23f6dd82mr3887668e87.42.1752940946812; Sat, 19 Jul 2025
 09:02:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709-pinctrl-gpio-pinfuncs-v2-0-b6135149c0d9@linaro.org>
In-Reply-To: <20250709-pinctrl-gpio-pinfuncs-v2-0-b6135149c0d9@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 19 Jul 2025 18:02:15 +0200
X-Gm-Features: Ac12FXztrlt_TII82ZBIkZmMLTzLg24otRAxfGOCzM7K4BljVaj3bGcukozw-cQ
Message-ID: <CACRpkdZN3qAJdvDkzvr0_=7grNHWFQ6M+_b=BvREq+PyosBmiA@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] pinctrl: introduce the concept of a GPIO pin
 function category
To: Bartosz Golaszewski <brgl@bgdev.pl>
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

On Wed, Jul 9, 2025 at 4:39=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> Bartosz Golaszewski (12):
>       pinctrl: pinmux: open-code PINCTRL_FUNCTION_DESC()
>       pinctrl: provide pinmux_generic_add_pinfunction()
>       pinctrl: equilibrium: use pinmux_generic_add_pinfunction()
>       pinctrl: airoha: use pinmux_generic_add_pinfunction()
>       pinctrl: mediatek: moore: use pinmux_generic_add_pinfunction()
>       pinctrl: keembay: use pinmux_generic_add_pinfunction()
>       pinctrl: ingenic: use pinmux_generic_add_pinfunction()

Patches 1-7 applied!

Expect qcom to follow early in the next development cycle.

Yours,
Linus Walleij

