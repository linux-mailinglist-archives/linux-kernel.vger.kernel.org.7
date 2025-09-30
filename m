Return-Path: <linux-kernel+bounces-837945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F03BAE1D6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 428E9188C81A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5918B2512D7;
	Tue, 30 Sep 2025 17:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDOOVdKu"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3686B1E5B63
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759251679; cv=none; b=vGpjsnfe4jjWX8bTMtL4XeaBE3ChdIhS2S+z/91IA8uwvA7x0IBGAYMWu2MwPTe4gjJ1YafuiBFZa3cZZy6tIowR25bwKrMJ8yv3l0/jDSJeXRXL+a/Aa+3mnim6OUsklyw6A3L2/MfUFvDylWgzcJQjC+cboL2dJu3GZgeMbbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759251679; c=relaxed/simple;
	bh=AmHuuzpem5111casgiRIX7q6S2eHy1ZsEGaomvXBWBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F85zE0/U11F7279flQO0i+jsWj49n0EdBQzU2J39LTkLtSUwz2ux9JltshoQZdrvyNi3tQXK/gyQrjf7b4qnhJVFxUvgMWAQvYc4D7BQJrzS0FAAsWm+QNGxt5sjXgoSxr89eTLm9vghO8Zp1c3V3VF5BlO1XWppMc6mF67EnnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDOOVdKu; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3307de086d8so5652382a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759251677; x=1759856477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Qn5VqRWJrpHDhx/xNpBlaLWgEArGVytxgRrr8Ys9no=;
        b=bDOOVdKukdiUsInRLL7W1Mr6ucwZPG0GVJ9putQ/fM8dB38/e4znvgFd8TqWdPOWv7
         BkASLLEnQeFq+XOOQdBnVo9SiMm3cq4HzJ76ZdqA2O/vA32XeO03ELa0lNFJO53IQ/yX
         YZM2YnBIUmufFZ0YLh1lphgiEQtMMcMW3NJO50GhlAxvWXQ9O417oWxylwiivmiBQ+uM
         xm5QOfpmFwMsfD0hSlU9O4ytHgUQOFB/KIFUkhR7dNVoFFg5YfdZUiGx2MPuhozQWSjd
         sJk4b+/kPzLR+ZIW6iJwSdjI+5oBC6lhIFYZylIynEqutbXMFgtwNpLlh7P6e7WbVeaR
         Og/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759251677; x=1759856477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Qn5VqRWJrpHDhx/xNpBlaLWgEArGVytxgRrr8Ys9no=;
        b=m/Jp7rlSIJXn/exPbDQ9jmMBTM0f34bQBrgqJPdMDJbk2GkMdnT55d00jH4I9UD/CD
         LV0otUpHFmf+ZDdAgm4cBwEVhGjFLb8mx/w5ZR4snok/Zgn9hPYWPH4V4kTc/zdiKtmK
         Ejvj3V7anoW7m6eK9cj5lUG5NgC3nyF36cl3/RZ0HqoZDeYuJZJ6VthormQgz5MmDJ4s
         HAQiBwzrBqmNCd9xsppdDd32i1Hig+nac7SqXRYYi6RzzXWU3RnFWHwOFDI7cNjTt3dS
         vuIst4KrVvjtM/3ZhT/7Z1q9vmQhuydHfQUw1KosDRWci9FVtUAF46yGB51NNhljq9x4
         YrTA==
X-Forwarded-Encrypted: i=1; AJvYcCX+5VYXnTrBAOJD3705cizmD2eSrP/R7u5aSV4lZVnZ5EXsqDpwpll7XeIy6g5TMMy6ekoBeQzP5ocS3bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YybRjPC4pR73y0xNnVcRvvitWCanHxv5Doc5tycaSUGSkg6lokw
	AMPKetMovNInHI1+1xLAt+L8bDwg8SY3eTQTq0giHX4It5ktvQr//nk8
X-Gm-Gg: ASbGncuyGsOJ8tiu0X38FayU4QLKSs4ZYh1ni5TbFN6aFmBeCbeFQR7g1GtCVC0ijLh
	3od1swSiDddli6d68sN5s5ISvF0Jd6cMLNbz5MjyQTZ1WnAc8rlMuefUsy+P/2gLzOwnrJGOi20
	Hndw9PbsXC538oYFaqKmeW2jSkgC+cASHax5yYMXL2ojayjBIP+eeR+EC28Cth1ZJEb9fJg8K9O
	2IIegpbEXXwgZjs9q0MTdMX+cqr6soSUe0mBC7Jk3k6OWEPn3NI0pLjR2sef/UKRB4shdgqRTTe
	a0MD84OvXiRI4h4NbugqDw4xvL6n9FNK8/wD8pjhN8fO+0fmaAqDC6/PvdltBB3qJLuqyMct+cS
	9Qy1z0qQyP4Ua6WAd+8rFKvoKWNJoI4ZzlQWphP/KZYXldUiojPrvdRlpUnRR3SVMxg==
X-Google-Smtp-Source: AGHT+IGy446EO1dFvrwF+hn4zw2/euRdjV/W41f6FxDTzzbhNgbS5i0TkYtI/qkAdJxguBsSMF5Bfg==
X-Received: by 2002:a17:90b:4ad1:b0:334:18f9:8008 with SMTP id 98e67ed59e1d1-339a6e28289mr264935a91.8.1759251677221;
        Tue, 30 Sep 2025 10:01:17 -0700 (PDT)
Received: from localhost ([2804:30c:b65:6a00:ceaa:2ed0:e81e:8f51])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3399ce47d7csm974066a91.10.2025.09.30.10.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 10:01:16 -0700 (PDT)
Date: Tue, 30 Sep 2025 14:02:08 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, michael.hennerich@analog.com,
	nuno.sa@analog.com, eblanc@baylibre.com, andy@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 7/8] dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216
 and ADAQ4224
Message-ID: <aNwNEHHZ4RXyz92r@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1758916484.git.marcelo.schmitt@analog.com>
 <5dc08b622dac1db561f26034c93910ccff75e965.1758916484.git.marcelo.schmitt@analog.com>
 <20250928111955.175680cb@jic23-huawei>
 <20250929143132.GA4099970-robh@kernel.org>
 <CAMknhBHzXLjkbKAjkgRwEps=0YrOgUcdvRpuPRrcPkwfwWo88w@mail.gmail.com>
 <aNvtfPh2JLdLarE5@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNvtfPh2JLdLarE5@debian-BULLSEYE-live-builder-AMD64>

...
> > > > > ADAQ4216 and ADAQ4224 are similar to AD4030 except that ADAQ devices have a
> > > > > PGA (programmable gain amplifier) that scales the input signal prior to it
> > > > > reaching the ADC inputs. The PGA is controlled through a couple of pins (A0
> > > > > and A1) that set one of four possible signal gain configurations.
> > > > >
> > > > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > > > ---
> > > > > Change log v2 -> v3
> > > > > - PGA gain now described in decibels.
> > > > >
> > > > > The PGA gain is not going to fit well as a channel property because it may
> > > > > affect more than one channel as in AD7191.
> > > > > https://www.analog.com/media/en/technical-documentation/data-sheets/AD7191.pdf
> > > > >
> > > > > I consulted a very trustworthy source [1, 2] and learned that describing signal
> > > > > gains in decibels is a common practice. I now think it would be ideal to describe
> > > > > these PGA and PGA-like gains with properties in decibel units and this patch
> > > > > is an attempt of doing so. The only problem with this approach is that we end up
> > > > > with negative values when the gain is lower than 1 (the signal is attenuated)
> > > > > and device tree specification doesn't support signed integer types. As the
> > > > > docs being proposed fail dt_binding_check, I guess I have to nack the patch myself.
> > > > > Any chance of dt specification eventually support signed integers?
> > > > > Any suggestions appreciated.
> > > > >
> > > > > [1] https://en.wikipedia.org/wiki/Decibel
> > > > > [2] https://en.wikipedia.org/wiki/Gain_(electronics)
> > > >
...
> 
> Though, the above is still relying on GPIOs which is not a requirement from
> ADC peripheral perspective. Also, if GPIOs are available, one can just provide
> them through pga-gpios and have full control over the signal gain with the IIO
> driver. It boils down to just telling software what are the logical levels at
> two pins on the ADC chip when GPIOs are not provided.
> 
Though, as mentioned, the state of A0 and A1 pins defines a certain gain applied
to ADC input signal. Because signal gains seem to be usually described in decibels,
the proposed dt-binding allows to provide the gain value in decibels and then
software figures out what A0 and A1 logical levels are from the provided decibels.
The actual levels of A0 and A1 then have to be set according to the provided
decibel gain.

