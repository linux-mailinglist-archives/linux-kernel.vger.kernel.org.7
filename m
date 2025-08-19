Return-Path: <linux-kernel+bounces-775781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA8BB2C4F4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 761C47272B6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3710F33A033;
	Tue, 19 Aug 2025 13:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C9c7vdHR"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36262AE66
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608791; cv=none; b=DWVrlkfd4ceWHU0cukpMH5QbibuqK5ITZ0iQdiqA4vnrSr7AmZjB5ypcgQgHekVyuEmrQc9Z9hGhkavQtTsZm0+4aZZtd80IIIkoi9nGwDC4rxtv6a2LeLp4S7XkYwd2W/Zy5hg8Jn/L6amf7x21boyj1OcxnxzfkgX9YJazVGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608791; c=relaxed/simple;
	bh=eD1gZysHH3Kbz+8Qw6JjzfoRuZbWl8/jLJiaW7ypQ5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bKKTXlFB/IL4ZuCX/cQ3PrVo6e42dyKyxUH09wsznPutY6kI28ivcq9JDPOEoit/wzJm99pXjohYeAs129NJOgSPFjCRbXvmEKvHXYoAAwreLFzPhhT8pJXgL0TEJGlYuZo10YmuwbJZlbzJmJkQOylM30jOIpHNPyjHBxuIiHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C9c7vdHR; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-333e7517adcso56200891fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755608788; x=1756213588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eD1gZysHH3Kbz+8Qw6JjzfoRuZbWl8/jLJiaW7ypQ5s=;
        b=C9c7vdHRJdrmCN1oIisZOEtPaE0LtanKquQQzBx1OkBSJiP55HDZkVIRdmvLRYILo+
         ciby8bKy8JJHy4f9AxrEnsN/uFNQiQV7RckzSwTi4pYOsx5QZOt7lKOVvnU03U0KhS+g
         plwhnYNa0+bqwZPIAuxgmzs7P/ekcT92k+YjwqAIaDXgkdhZkG8unuSlVqzuT2vhZ7xR
         ootN7YTHnxrOIytRJcocE9/SyoIP1qqxbXoVbXawP7oorqk6XWvfEDUDKuX4t6Wp457X
         WKUFk3oYWUPtbTsg3pNqKoUkTOXJGE4zCGTAT/Y9jx3SCZd+dvlxyWsjKXpbTJx4SWAq
         1BEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755608788; x=1756213588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eD1gZysHH3Kbz+8Qw6JjzfoRuZbWl8/jLJiaW7ypQ5s=;
        b=nlwNKjy15b2bP3+KKtySJ0pQ3CTS2Qef5pzp0BymxTvhencytmgoM+J7DkBo8I9Kxe
         lGxSadIl+Ymq2bQJCdWtpqjnrHfOgD/prMriqy3KK6G/WW1H43QUnDO1d5278A3+9ldk
         4aWBIa1eXzEfzNjTsjLCi1zllPPredp+6lbgWyXhTjTBB8pRBFuvLL56ooIH7qqCrfLD
         icc/70eHgwozEqVvPX61ZAI8yN7nEUiaFt12TNREXFK0TfWqcX8wzPFW88ELzt5NcPMt
         nferktMsdOrC4neNTshgQ01rv78y7cabcWmPDPJq52GULV+5wgtW3F1VVcuEKp8seajF
         I/Mg==
X-Forwarded-Encrypted: i=1; AJvYcCW7P6gCyjoJGVOB5Hfyj1Lpd/y7sTl56ycyteua+uTiy0ieoZYtLru3x5JTmxkHrXnXl1S3vVS6wYjfEcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBe08x5sodusW0SA7M7weHwHiLLZ/s58H2Omrpa1qL5O9v+BwF
	Ew3SyrmNq24PR1htq4t8Xiw/eBWXb6iHaX14DdR/L1UChAM+KYn0tgIuVeOMkfdhrkx7rLVMtCD
	3uhFi1iw2qKwSYoZmRrDC2cY9i75BXK+mRxbiYA/OX3j74hr5mLFOvwg=
X-Gm-Gg: ASbGncv5XuKLw1rV0DP3cyMVFBcuh37TSk8irHzru5BJKWvlCCf6IkR6tDZlR1QOBpo
	SdbOl8seuYz56cSmI0phzXbfnJFwP6Heloc0R649r9Wejv55kOKU+ozb3uSN9Ta/Uo254eWCcjG
	OUhouw29YxYcLc0kEJMW2Bga/H08S0ECxlfehavCzpNPlbopNzixz10Gn0MXs4U02W0UGFTFGYn
	sb6m1riFqzO
X-Google-Smtp-Source: AGHT+IHuZ1v8yqv5nFpHB3upOq5k48bLEGZvcHQzbQtjR6KTrGahQ6hImQ+OMjokOiyokuX8aJCwdENgo4zYpJr/r7I=
X-Received: by 2002:a05:651c:2208:b0:32b:9792:1029 with SMTP id
 38308e7fff4ca-335317cd294mr8926241fa.14.1755608787940; Tue, 19 Aug 2025
 06:06:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818142402.132008-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250818142402.132008-2-krzysztof.kozlowski@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 19 Aug 2025 15:06:16 +0200
X-Gm-Features: Ac12FXywhv2FGXVaL5z9CRtgqv32XD-L-_xhhK3a7EL-XoMsHmHhIPyxRqHeipY
Message-ID: <CACRpkdbdTHg8Bn5L2Jc33=qTohD7aVAHuv1P0H2x7jxciojzLQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: stm32: Constify static 'pinctrl_desc'
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	linux-gpio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 4:24=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> The local static 'struct pinctrl_desc' is not modified, so can be made
> const for code safety.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Patch applied!

Yours,
Linus Walleij

