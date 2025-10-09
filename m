Return-Path: <linux-kernel+bounces-846586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EB5BC86BC
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 12:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636EE3A9DE4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 10:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25C22D8DD9;
	Thu,  9 Oct 2025 10:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Vd0SZcSb"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31822C11EB
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 10:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760004754; cv=none; b=e3hJcMI12vXgIZiefLJUMyWDvnGL3VUS1AiSiwcaPoSY8zzpO37NSHRB8HZliFgaTzn3wwW09G8i+8acc+kp7Ls1taDylIQYM6K3ZEgynf7qmOM0KnT4NAtNcme0lpm/4Alh3aw60lwTs8rTX+ycgoTWQfxOM6413ubbyX1praE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760004754; c=relaxed/simple;
	bh=JTtVIAFYf35Hh8feLqqWv19+tcpgXwV0O2h/lrQZ+LE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TjiKaFpQNE+Yug/qJ3hmK+zJ4YVB+pGYcDzMr9rqMzOwIA/4mW8jHPFoG1fAp0VWIDRUIbCrLqulp9/Ldelv5NDKa4JLSVAXTtcV7NduAmGbRq6H7rxpZs75t2kHFPmrmvjuvbew/NNWSEygjxsvsU3OQh8TEUZaBB7TFrDkHQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Vd0SZcSb; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46faa5b0372so5027565e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 03:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760004750; x=1760609550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SO/OcY1CO73Q6LYMqOLX5PvBUeNoOpjpPrCz+L7Phi8=;
        b=Vd0SZcSbAk/uJ6FmS1ntD7NdOfhIZQj8BKd3C/Bq4JUb78zQtlry38cUxTUODbVc1h
         VDhiYCI6usbZcKE5qaCF5hAqe82UdO4pbi0e3feaRimqGN9vCOh4RlJOfaNnF3HCbQ4I
         VO4osTdYxL4qEqr3zAviZOBqDCBUtL90eOb05FxPk39GofwF6YPK4sZ+3vXdPXBiJhNj
         0owdO4vg8QX6LA0k8xP06xIA7PDQtCI4Tb0Lpyq1OoNQlGd8J1VsoQ09HwCS8Aav4f1o
         /bIMDZUcz4HL0bGitT76uU95b6IWDq0GTlJDGUtLObzzWgcDI1WtuYkP+jDCwQviOVIp
         JXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760004750; x=1760609550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SO/OcY1CO73Q6LYMqOLX5PvBUeNoOpjpPrCz+L7Phi8=;
        b=edZkXMRZWnJ2A+FbnfEv5JxsQ0GdkR4TEwk8myj6Lhg5lXKEb9QF+V2G59C6+jMTNN
         QqiSmsTXiG4rb1hZOokjf1mqJwH4e23I192jw42s85L9KUnEFxj3Vlp5Q/xs9WHGkVWw
         hSyO4AUGshpbP/jBqRBXw8DTJtYxbMewRRqklnH45WlCgsWX/oTmQoePuBD7PeZZZ7Qf
         cv2VuU5j54aFPgm6gmt43xdHnXkXVKovtnEhJSQmiqk+/t7B5/9DZ49/MBvxT3LIJ+72
         k7p361mxgSDobS1E+CSQhH2cHztz+asYpeHR1zJf96uoVPbxYGfAH1RWi62O8SyYFpGj
         wjiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpxHtVRdVVcuLdXkC3UwIsJv1ZLn0bQuxmlJqhNPjN8mlkK2m9cMqJl/oTEQMkJ1iHzhwNzyi7Ad6+r9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8maxHdR776uyvdg7q62o7zhMiAmoGKtCa7kNGmATuw1EQabBO
	i/yALZGDjXm3uSe9QnXVlCNSL9IGW1LJn5Lf5QnGiHpJR48NYnUIfkIXEn/UGHWnPJ0=
X-Gm-Gg: ASbGncslnQm2c6NiMRbCEYP4MX4Wa7jV68Js88+2gXQllEAeDl6b3ig/0xTTD+Q8PcM
	R4a70YBSKomTP/WzyXzjBRBxD9x3vver7HtUSdWjHmxCzZs04TUtLlcmS3Hxak324UD9KmbMlEk
	TGEQSGqzeLV37uio1N5SQQ5LGYByusz7Ur5Vyps+vnpI8ksknUUtYDED6Ik65U7zMU8KSYsGz8i
	hHKjxGqoYUEtMJdi1aIzxNxrPs6Uv8TFU5HQ9ddacHAczqnImetnnETQVPzzpOU7rFFQM2ELNbJ
	s3AA0+WY6xP0a/TepePfAXIWuQ5vJTisVAuqVBNSeORHmiRjxKvB7ChRtlf5trvwUczqDox3eu0
	o1kIVxtyQxh2Vg1Et8zp0Zknj+k/icXQ29Khw32lod+Ewbbs=
X-Google-Smtp-Source: AGHT+IG9djRtuVw+ie4GfUE2fCKVw3VDvAD/MGwTeuRqIhTj3DidnkwSdyN5TC7cZH1+rVL/DgOUoQ==
X-Received: by 2002:a05:600c:4ed4:b0:45d:f88f:9304 with SMTP id 5b1f17b1804b1-46fa9b0e7b3mr50062135e9.30.1760004749930;
        Thu, 09 Oct 2025 03:12:29 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:a78:91ac:9309:82b0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab633badsm34723735e9.3.2025.10.09.03.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 03:12:29 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Kees Cook <kees@kernel.org>,
	Mika Westerberg <westeri@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andy@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH RFC 0/9] gpio: improve support for shared GPIOs
Date: Thu,  9 Oct 2025 12:12:27 +0200
Message-ID: <176000470857.91617.1046632810440589541.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250924-gpio-shared-v1-0-775e7efeb1a3@linaro.org>
References: <20250924-gpio-shared-v1-0-775e7efeb1a3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 24 Sep 2025 16:51:28 +0200, Bartosz Golaszewski wrote:
> Here's a functional RFC for improving the handling of shared GPIOs in
> linux.
> 
> Problem statement: GPIOs are implemented as a strictly exclusive
> resource in the kernel but there are lots of platforms on which single
> pin is shared by multiple devices which don't communicate so need some
> way of properly sharing access to a GPIO. What we have now is the
> GPIOD_FLAGS_BIT_NONEXCLUSIVE flag which was introduced as a hack and
> doesn't do any locking or arbitration of access - it literally just hand
> the same GPIO descriptor to all interested users.
> 
> [...]

I'm picking this one up for fixes as it addresses a locking bug.

[1/9] gpio: wcd934x: mark the GPIO controller as sleeping
      https://git.kernel.org/brgl/linux/c/83d314fac266a3d9de61e4a4490c4f2eafc86b05

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

