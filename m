Return-Path: <linux-kernel+bounces-846693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 919DFBC8C32
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 13:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4575D4FA780
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 11:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17FF2C2340;
	Thu,  9 Oct 2025 11:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m3MIRV9b"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF74273D9F
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 11:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008902; cv=none; b=uSwiFhHowyPtYY5gsG3So0lHbT/v6VHotp1jyQuOVIlwMCSQspEpDyZhoZ9WoNIDdvmy96ru4RsdOcBUIjzWW9tQ+FPKko2vSfkN0ECZEqtJ+aP8pNu0iZMJj93bC3mzwnnt0ExjZQ72iYu/vWPTD7hcBTqK4M+rDfqMvFZhYPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008902; c=relaxed/simple;
	bh=6sSh5spmOZHPAgftosq8zlVm3OoCuBCxRRQ44DRZGjc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=uHXCrYbVCm5sJ7adNp6forBVQsGkoPoo6nho6K0TmEir8amKGOYLrYdrr0zMMP8zXzJPXnbw/mYANzh3jrqQO12U+JsBwHuHMTcNYJzZVyzwm39LFC+xJFRjWE8uO9a87WDNjiGCljLqBkWKmt55IZFPkzSOkKNqtshxI1/NTbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m3MIRV9b; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3f44000626bso645789f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 04:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760008899; x=1760613699; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6sSh5spmOZHPAgftosq8zlVm3OoCuBCxRRQ44DRZGjc=;
        b=m3MIRV9b1XS61m+5IN+IwLqYRot/WxOMPX/pLjsCv8pEDdgKmbpg3e3qRS4S2z7Vup
         PKrcV6CymqWAM6GSIaXRxOOe23X7YuUh3wae8EzEsO/U06z1ehli74U8TUS33Pu6u7oL
         iC2qhVjg9zkMRMtYDp3SueySjadkMGF4+k89xmigDm3mXBkGLJVhwRDtUJNuNc0pKul2
         6EbCE9WRy7ieKb0HCvyW0EWlIK7pOOw47pUT7dm1PBSoM2f4CZgFJqwXfHJYyFcZHi0U
         J9OPt1mIToH1XILlU7ZFRAJO/U5WrMI1ohhkQdb79FwPhcGKoIjmVy6p9Rg32Yw+Ptyg
         Fn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760008899; x=1760613699;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6sSh5spmOZHPAgftosq8zlVm3OoCuBCxRRQ44DRZGjc=;
        b=PbbGBdaoSIZK9Q1p/9NwRYkAg6LEVRnx1RgJxKqP6X6ljB24mtD+CWwfYfCAni2cn7
         v9hCHBPZczEr0NdaM3a+5gACnLNauAU7bAEu5cNiWTl6uzZq828xazzTVAWsueyOXt4V
         IqEwSDd8Qofwyp22Ey1ZkCWQrUjRp3UZaJPGJ707NFjbzrbEDhWk2YALW5ORj+XNECX7
         YRJnBnTbMA4p/5t76q3iVTVaG2Z0x1iKaX6RWKwhY1bRI2fnT4aUU39IQe1BaoyLSTeQ
         wRyR/tbPGm/9L5WTB08BGzltvvKQ2gUPukrmnjvZz6Nh7ofNjTBJkTvbOU1G7IER0u/c
         JXbA==
X-Forwarded-Encrypted: i=1; AJvYcCWyZKngEi+pA3P82eN/XgUMRTiifiAdovq/z2A9RsKExUj5Y3tCTqQM0FzvZe3WWq/OnTW0kEXkdXc9N7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8rQZVMylcHXIcHYo33Bctd6PEg2YESmaF1DeLaCgeRc6QqOwc
	7kZ2ZHMD7NUxeDA6ubFaDLPsvW72EFQKllRudF7r2MJZfTKRoEOvKKzqZld1ZepOJ3Y=
X-Gm-Gg: ASbGnctZLbaiZ9vBcMg9Sa+epnAZ9Peh6N314IJqin86edfqSed5sSP0N4PnP38o9dx
	Yyr/uJ5W7yGCzqwF8ikA53sB298PoMj4EszYWws4bpERykUJZ5FAvCiNG5XPjCXu+6tG/tAlrxv
	Jz/4cjo6uIMU4+SspdgA61zMmOm0eQm8eJchFBG2tJ2yWHsFSpBxVr73+bny/xG0OKsF7OGgj1V
	egxS6HgWjUdf0LxCfCQEXOhgpphqRmnGGpceZTZNht2VxPYqC07qkPkXTNJN/BdppJOjJg0OzCN
	qlkRqXBTnpw38UG3PfAogsvrCv9JlIVyAexIoXpYvW8ScynQv+V/UNE2grMjDRCHiGyPr8rPhSR
	eML+U7vUjfJA+1znDQrJU+VSvUgIvfs0whZiVhm6zMNP2f4qPyTizqOPxbL6FssTH
X-Google-Smtp-Source: AGHT+IFflhQlmkSN/2tNWXDC3THAhllPJpTf3aMPCOXB2rnMSjN2hhW4xvzZzF5ZeV/gFPVv90cBLg==
X-Received: by 2002:a05:6000:607:b0:425:72a0:a981 with SMTP id ffacd0b85a97d-42666abb02bmr4351249f8f.2.1760008898811;
        Thu, 09 Oct 2025 04:21:38 -0700 (PDT)
Received: from localhost ([2a02:c7c:7259:a00:5333:92bd:dab:a2ab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e97fbsm33992893f8f.34.2025.10.09.04.21.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 04:21:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 Oct 2025 12:21:37 +0100
Message-Id: <DDDR31N2P498.3FYKHZRLUS54G@linaro.org>
Cc: <linux-sound@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH RFC v2 3/6] ASoC: soc: qcom: sc8280xp: add support for
 I2S clocks
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Neil Armstrong" <neil.armstrong@linaro.org>, "Srinivas Kandagatla"
 <srini@kernel.org>, "Liam Girdwood" <lgirdwood@gmail.com>, "Mark Brown"
 <broonie@kernel.org>, "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai"
 <tiwai@suse.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Bjorn
 Andersson" <andersson@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>
X-Mailer: aerc 0.20.0
References: <20251008-topic-sm8x50-next-hdk-i2s-v2-0-6b7d38d4ad5e@linaro.org> <20251008-topic-sm8x50-next-hdk-i2s-v2-3-6b7d38d4ad5e@linaro.org>
In-Reply-To: <20251008-topic-sm8x50-next-hdk-i2s-v2-3-6b7d38d4ad5e@linaro.org>

On Wed Oct 8, 2025 at 7:56 PM BST, Neil Armstrong wrote:
> Add support for getting the I2S clocks used for the MI2S
> interfaces, and enable/disable the clocks on the PCM
> startup and shutdown card callbacks.
>
> The rate can be easily calculated since the card forces 48Hz,
> 2 channels at 16bit slot size.

48 kHz?

48 Hz rate will result in too narrow analog range to reconstruct anything
apart from beeps probably.

Best regards,
Alexey

