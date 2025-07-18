Return-Path: <linux-kernel+bounces-736461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B914EB09D2D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 212DEA85333
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A6929C32C;
	Fri, 18 Jul 2025 07:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="2upAj3hA"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEE0299929
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752825390; cv=none; b=DdK/h2CBa7vF3DTIp5nVLnK2XD5EmSkGOJtyuff9G9MnfL23aYFoJ+0oTanzIK3uPEAcLq3ii3WzlpJqYgPexmjK9iPIJbuTSNj3e0VLjW1CeEonFk1tYn7UGYaEp3micKj5kROpPRVbniNM2sH1D35cXqv0h88dazrp/Pfpw1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752825390; c=relaxed/simple;
	bh=y7+hycb3D0CBE8U3Q0YDzmdLnL7oASq79gdF5oDq6Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QeBhFTK2SyVDFmyc+NpPX6yyR/yHZVfdRlZdlLIRkuUniJfg1ybH8orYW7d4wcemE8ih2UJpbcSQl62sSvYVhsSBoVhsd3BvWXfFoQlCXGn/mqHv/Eiv4D2TZ46hk33NDhnDFu1c01t9f3ol+g2kU1rOhFdPdlUvE8Q6DlCsahk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=2upAj3hA; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a6cdc27438so1251221f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 00:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752825387; x=1753430187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3gYttOWpdgwpp/zXG5WCQv10lk4U+RHywnhkxe+we8=;
        b=2upAj3hAPyeFQ+CkuBztZBH++G1YsxkvIhiix6265U8gvKDMsTRaf7IPMKWtra5P8Q
         XeaNbsjmxpKaAQawJh9vnWrRedDj9gxjHWikRtQaKmGoEtmbaCuGgsZlmXjQRjMM1EyY
         5ThN+zR8qyZLSqnwmkEAJLpq72Hp6J7ycWT6FpnerZ8D7C/iG8pzs72yyZ/0omoTlokH
         czpTKP8UhYTGqL9h5++UdEauLyGROl50ds4t5RzQ5u0C8k8I42rlubCMc2PgwmDh1Qq4
         u0LnLueuVICn4iERSQbzU20EcIkZkLxUHHR9VsrDAzSRdyeBogcUtmLPSqxXVx6yd2sL
         WZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752825387; x=1753430187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3gYttOWpdgwpp/zXG5WCQv10lk4U+RHywnhkxe+we8=;
        b=pLqsuk3xCI24YNelg5n3AUHAoZ8Hz/Z+5zfaFuFrImyEUZprLPGeXE1mt+YXahCz1I
         HF6J0y0wVXDjJvsSNB7mVx24gt8zDFOtHqpmtHzHm4SlC2yQpMUCY8ct45dx6ME+9NPx
         okM4j3aSy4hOVHPXFHuYPlCJFKvFE4Qyqo3MBlCvkDwMuk8E0jom2ZhHbz2OfwJLmZHA
         Nm+VUX3ntu+U/fL0viWuSm0beODEs8wdfaq5IyOnH4peJiip2Z5Gw647DcUY/TuGk0eG
         6pYoHMOHJ28Z0+/833AXxTEVQX+F9xu2ML7YGW1txYVOL+DD4fxntsoZH6l1Z71i1t1L
         4YoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhoL1GJ5fyYmEJu2gOGZgt+fgFOLFmkEkKjGbh+mJR0t520j46hIGGBnZZFAP66BC4ILiE6L6Pu1BVKjk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm8byAjY/8ubk1UlLKUCdq5yOI2jEHVPv7wRc1pNAot26jz3Ws
	UI1koeOxYYEMFdLIGo0NihUTwjUBTuJ0hp88+c0q5NlWf5icxaPyGGzBmKneA28tmFY=
X-Gm-Gg: ASbGnctIRvQe6rUBWnpluQmz8v7Dpr/AmK+4H75twbmtmrKOqff6MKBcwokwgahoX/Y
	BeZvF8S1BJ5NZEJ8Jc8ytR00AohQ6owuYDBpOeh/Hoq8IS/Oj2kz+cAB+yZ02XTYLUjYxrakNXC
	6eVGk0HxejA4AlLBnI07xrZbo6C1bARutsDU5wtGseSx7KO9u71jXf59ITpPiMC7sqdJVrCQ/qW
	kbS4i/cO7yrb6jYZqPn0xSNRg3naX5AfejbzvTF53D7bl1xiR6oAM1DKnIQE1G60fJtVX/5XYvP
	T7VkODpa5wCHpfrGLEChoR4Lpg0u5zErG0ovm+D1b0hbDhPOOa/RvjNJige8bB1WBhuc/hGl0Hn
	bPh3zoKU3mtTAuNLRAh+eyO9XlSD9gKI=
X-Google-Smtp-Source: AGHT+IFpBXve8FC6yVzffBshmiK1SoLpAGkXD5ALpQXwZZeSlSPGznPrAYcEYYzhbx0iAh7iK181EA==
X-Received: by 2002:a05:6000:4701:b0:3a5:57b7:cd7b with SMTP id ffacd0b85a97d-3b60e4d5d4dmr6575703f8f.22.1752825387228;
        Fri, 18 Jul 2025 00:56:27 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:be63:a233:df8:a223])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48a23sm1080851f8f.54.2025.07.18.00.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 00:56:26 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joshua Henderson <joshua.henderson@microchip.com>,
	Chandra Mandal <purna.mandal@microchip.com>,
	"Rob Herring (Arm)" <robh@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: gpio: Convert microchip,pic32mzda-gpio to DT schema
Date: Fri, 18 Jul 2025 09:55:56 +0200
Message-ID: <175282531511.45055.13712449219071610465.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250714202807.3010652-1-robh@kernel.org>
References: <20250714202807.3010652-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 14 Jul 2025 15:28:06 -0500, Rob Herring (Arm) wrote:
> Convert the Microchip PIC32 GPIO binding to DT schema format. It's a
> straight forward conversion.
> 
> 

Applied, thanks!

[1/1] dt-bindings: gpio: Convert microchip,pic32mzda-gpio to DT schema
      https://git.kernel.org/brgl/linux/c/82388cb24a2c057316801dc390321cfe2bc0f3e2

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

