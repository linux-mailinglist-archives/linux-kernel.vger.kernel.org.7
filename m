Return-Path: <linux-kernel+bounces-604622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 553F4A896AB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 10:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88FD8440B52
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 08:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328A128E5EF;
	Tue, 15 Apr 2025 08:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x+nM67dS"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF4328468C
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 08:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705752; cv=none; b=dzpDk6eRTuWHNHixQ/yn/YMdFO6Lt99NqKzS8CcZCeNxXaC7sK6Y6Hq+dGgm92wo4HZsYbpH357zMWIzRo9VLZ2pevY70H2bK+yHL4yyIpOcu6YP/EAwjqWao/O3yYiZwRPi4oybiU1lUK/fRFovS1NATo4jD8uhHr/l4XQPWM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705752; c=relaxed/simple;
	bh=kbC+rbiQeXAmTKOdQ5ekU8ntNo3bts/iVzbE7GMiRTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jSOdvdT9VpwpcP0UXNJYPAclFRU1/+VeoBb/u32Gg00RtCFcJkHOVYhBlg1PMxYS0xM6A8xpv8Y2daHPiDokOBQcdxpsWZz0FvOk0UEoXf8OOxQAvKvjz88Y//WiUpVcSxwo1upJbAk69jmydTlnEaIPGthaSDzvEo8FprgUxbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x+nM67dS; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30effbfaf4aso51087331fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 01:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744705749; x=1745310549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbC+rbiQeXAmTKOdQ5ekU8ntNo3bts/iVzbE7GMiRTY=;
        b=x+nM67dSH24BKBD6gI01oiwRKdOyXeKhCywonH5cBtRo/IZj0UNWF7FVoZIJNb0Pzl
         F5XJR7RJ80n3lY79jkPI3tlkI8Duz0UusarNUWrT8ynsvjUabQOgsbMFULZ0o8fnUTGC
         NHMQxTlB7qmQriDnVBwFy6ZAg/O05qUsEIDXm20LWsKrGgAkWV+PIptDxKtvUYCZb5m6
         eawkDQ0aKSDUqIrpvIXzDiVRezeV9x1EMkHr1X6RGplA9bsEqW8Scxxz1twUZDHljDUW
         rgt+g/wfeD0gxVeB2FDryevNZ7X/B+9wSvlVCmlIYFWlDEQzmumrxdwGli+kwHZTmacM
         g+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744705749; x=1745310549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbC+rbiQeXAmTKOdQ5ekU8ntNo3bts/iVzbE7GMiRTY=;
        b=hmMmTKzMz+QD4mAxxY6CN0XSamLXxOuapBNQ+jbKGykaAoy88ehd9kSJuJQQrtMGek
         pgmDKdpVwB7z6c5IqSDgI0AXLwNS6KmmHr5Q9H4dUSX3TJoJSp5ENkAa0WT8ogg42V34
         zEnJT5qYR9btb8l7GWBRMIdaOVKI39NQfllbgmS5YO2lujyZlMaoqhytEW8uaJ0nNx86
         lwZc1xDnBVjd0B8K3kV+zxm55zcvjvVQZMFeO4ORcNtb/kc87HM7hO+jIBX3/9GKuqdC
         MI6Q542zu99l9Ja3Z5g0thuPd0HQtNnPC3JhDIC3sY3kFFtxj5DyhB2Rq9fO0mDT0XCN
         cxYw==
X-Forwarded-Encrypted: i=1; AJvYcCVLMgnumA+HwnDltCJelQnS6FS+dywacTxXKmNDbQ6V64zqWG01oukBblUSVio7Yv7iDlcFrtIV441sXmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyXw+sncDx7X6tOyiPRJ/OQdWIk/FcNd6ET8gpaZwt7sKehnWC
	KN6olyuJCCotkNBa/kdsL33Dvich7qTvej7DNwFZOexVZ8ddMfnhOrQaKA54zI4yNTxEKzYTIF3
	8ExKvtIiki19vTPQS8NjhpY4I9e27Jo+AbPwzZnPf29Y0Ncy+k0Q=
X-Gm-Gg: ASbGnct6nvJRcMbTv9IVa5CHuVHQtVCpzM3y8uE+47UmQgrf6jcj0K6gYj4qQMcPQfu
	Ss8nE7PaVuhbG4NAzQwyIJDZzm79lv91vpSQQ43JQPvj5LiduCIWJaJ8RakaMRjhA357y1OrCBI
	hNtq+pn4dUTzBJ+6caZmYLDg==
X-Google-Smtp-Source: AGHT+IEldvSloEtUxO9vAvr6pIUF6+6mI//GyNNWKS45SYnCGnbYk7X+AjHq8bg3bqosme6qdruAqr1basQdBWgZhUQ=
X-Received: by 2002:a05:651c:30d4:b0:30d:e104:b594 with SMTP id
 38308e7fff4ca-31049aaef6fmr47714041fa.40.1744705748864; Tue, 15 Apr 2025
 01:29:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407-gpiochip-set-rv-arm-v1-0-9e4a914c7fd4@linaro.org> <20250407-gpiochip-set-rv-arm-v1-2-9e4a914c7fd4@linaro.org>
In-Reply-To: <20250407-gpiochip-set-rv-arm-v1-2-9e4a914c7fd4@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 15 Apr 2025 10:28:58 +0200
X-Gm-Features: ATxdqUFq-Vl9qhescQDJ20ocPhYf75xWr8mTBKZ04eLcprRDa-HJLgwcNWmq4o0
Message-ID: <CACRpkdYN4wZcnmxjh9KGCa7i_K_hKtzvFgBzywbVAfK46A2fKQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] ARM: sa1100/gpio: use new line value setter callbacks
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Gregory Clement <gregory.clement@bootlin.com>, Russell King <linux@armlinux.org.uk>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 9:09=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> struct gpio_chip now has callbacks for setting line values that return
> an integer, allowing to indicate failures. Convert the driver to using
> them.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

