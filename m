Return-Path: <linux-kernel+bounces-728123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6D2B023DD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAE8B7ACFD2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300D02F4327;
	Fri, 11 Jul 2025 18:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YzeykREn"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C4F2F364A
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752259041; cv=none; b=SVY3YVWqtjbEOIlgAUnWu77kfXudgM9Dt/kRWt7rEmU/h0P/+WVKxoRVHs3Y1Pe+85eGMvjyn9xnEc4UKuOuhCr7ydTbOXQzfd5XgEP4e9bXQBhIGyL/mSBgqf8KH7p5h+Yd+onNoPWnARxuQcvyWbPweHfa+t4M3RoHSXxEZfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752259041; c=relaxed/simple;
	bh=GCf8INkYZkwdneE2A9LSxUiQ+fJAXd8182xLW+8Tlv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NAS1lkHhXelGdysrOet+woQw3mj1mi/J5wOUiRp9JkFGonM/hSuU6iL1uvYCQ1DvzeLZmBi9Y9QaTHSgQOZwvCvTaxcXhBbnb2Ome9VdBUsNVh9vHgBjx3RphiKDK6YFCI8PAX6jp3ZYTMatO/8hV7zPyArrKATj1I10mCqL+EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YzeykREn; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-70e3c6b88dbso17890657b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 11:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752259038; x=1752863838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCf8INkYZkwdneE2A9LSxUiQ+fJAXd8182xLW+8Tlv4=;
        b=YzeykREnSDumnHnI69/YB7/HpOqUqffv9kuxZjKKZ7zHR/qUEZ4RdTCLBFluf6Ysfq
         Z8AJUhw/0M1fkETJe8jqQl4raHuI26UmI7Gb3xsX+DZYpa14Mu9/mhtt9is6U0bCvfXa
         ehtu4PAeRG4NuM6PsfXTaE+JMROz0csJLMzK4Kgo8Gyqz1gLrl5EX7iw4ndjx3yDUHMA
         Bt/9oLQEdQ8MQxbTonaCMGzyf0+hv2Owrhw99s1IR5VRvAHr19/cKZBLgMTwPCelNMbQ
         mBzqS0Lo1lhkPRflRJiancMNILRNukqXxLf4X2dKsKFpfXGl0O9+L1LWymVW7Qcr5+JQ
         /mqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752259038; x=1752863838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCf8INkYZkwdneE2A9LSxUiQ+fJAXd8182xLW+8Tlv4=;
        b=WzjRSa5XS79TZCvBcejCbYeN6xbtwvX3jPeKSMcp7ckwCsugftrGa5XX7Y8Z4LOdso
         VP7qPYm3BBVneSdtrV9HdFqqVnPHX9tHajzIb/zvEsNFhZBUJDNQqiwSxjSk7Xb82ZOi
         fJZE/jstwxo8Z46gGxFkODaRdCAArQyKOPmlSStK9Ka/QDx/7ZXZIC4RM87AYjuTdLjN
         0iGmL6iBNbIjnW5020vA2QcqO9oza7ebx+ZwLGxzQefghbqWclDNM8wbV0/vjabKb1H+
         bKvSW0Ze50g2H10E3U6WlekbI4Oc6jshzHx5SZK1NCQLv5VLg9e3TKLGA6b2lzy+qZsE
         pIbA==
X-Forwarded-Encrypted: i=1; AJvYcCW/pliM2Zy2L8oGXsHBhb/HamxrhT1LUaXbQYjGzNMT68bYrf002nJklUqYlgbDWwhJUh+nytyccjJa/wU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUZ+wUqAFyyypWkJSEXguS0/VA/c43SOnO5PJa5HJdRJf3cikL
	uyghblnkeuZ62fKYSSj/APCOQl4fMYgeibdzSwCXlEMW80F21281q/xX3kiipibFvT1zCNjV3TQ
	S5D5I1yuofYBNKm/yTrSVo7JQJY7GJ4RyDDTTVxqWJg==
X-Gm-Gg: ASbGncuEfn7NRxl1auIvCeQaCN+2b4t994aAgxCi83bloLYVX1jNDvU41TjhF10PDie
	h1mJeb7jiRu/HFqPwu8ng8t3YMTFX6+zEWlwAta/aRSCvu9voA8NeolrrGyZtpQkCyEgMHuSCSl
	WbMJIaKd/5Z0C0u9wKxhHg0j3aSxT+Mt/ILxkga+tMb/hyI9UkamSW9fdiEdDyvDzOy7vYuh9+C
	j0Ioi8=
X-Google-Smtp-Source: AGHT+IHzkdQtsARg4tgkPF4WasK2Xo6Mfikt+zRNsUMsy8+DUZg6XHckhgK5mt593KfRZFbjIPg2gYdMMhURtB+dxr4=
X-Received: by 2002:a05:690c:f05:b0:710:e7ad:9d41 with SMTP id
 00721157ae682-717d5d7aa0fmr72034937b3.12.1752259038573; Fri, 11 Jul 2025
 11:37:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709-pinctrl-gpio-pinfuncs-v2-0-b6135149c0d9@linaro.org> <20250709-pinctrl-gpio-pinfuncs-v2-8-b6135149c0d9@linaro.org>
In-Reply-To: <20250709-pinctrl-gpio-pinfuncs-v2-8-b6135149c0d9@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Jul 2025 20:37:05 +0200
X-Gm-Features: Ac12FXzfU1xcaSYLqYAP3dXdgN5KjaQup50oBj2gBIW6fBcQFAAh4KjvNIaCjNI
Message-ID: <CACRpkdYfRv-B=p61tVThFkjoqDGfcqOjmHxmj4wv-NYyky2-kg@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] pinctrl: qcom: use generic pin function helpers
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

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Use the existing infrastructure for storing and looking up pin functions
> in pinctrl core. Remove hand-crafted callbacks.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Needless to say I'm a big fan of this patch set and it seems only
this patch 8/12 has outstanding comments.

Do you think you can do a quick iteration of it or does it require
a lot of time?

I am tempted to simply apply patches 1-7 to make your life
easier past v6.17, should I do this?

Yours,
Linus Walleij

