Return-Path: <linux-kernel+bounces-805173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9A5B484EA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6511B20489
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4112E54D3;
	Mon,  8 Sep 2025 07:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="VYK/8plx"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A3513B2A4
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 07:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757315862; cv=none; b=M8d3otZhPe8SxTaiuR/Bbzd+rcooug2HMMIH8QPj1o9IPCMLJt9bZZuYdK7BVnKUF4kJ0RpvLbHWTV47wtsc1c3f/za1YzC2gJLLzKPu8TrAR9rhSQyjhB3fB11h/TKdLR1NhjktSbkrHhcF0ilIL2ECIWPoyD+vnaWIo5276H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757315862; c=relaxed/simple;
	bh=dUVAueJeZqpIFFHmvSvQckiuNKmemJY+H4/Nqqh//Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nNe7/FcZivyD1lSo2WLBnXbkTIZqbsw+XMXdG5hRXcMoD3KUiEWRXI1giE/NED07VpGYtfeuhREykOt4ZCYAwLr09L17yNBMgS20r8yu48VpJLmAIGTHPt3JMpti+ipRDUwtgsyH53ALT807K6lsta8V1EL7HJVdk59dz4MOX8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=VYK/8plx; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3e07ffffb87so1816450f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 00:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757315858; x=1757920658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mf60KEpOtYo2ftzrTueGZy7sJLq7dX4TNfcH1iOJbrQ=;
        b=VYK/8plx3N5VdPQw+WNSJLKGLTB41RPo7bt+SXUD/2QgibDydf0qLec9xyAxLoLksn
         fgjf0z442/vwljqzsFBpxqgCfXGSDrdqcke8ovZvvLCjgxioABXftHxhBQ1CBx93zqfl
         4wBaWXTedAY/1BK0Tv+lB4TeJmc1t7W2vLcc5AB2PBchj8flAxY/VJrnn1dyRkx+xrUX
         ZjbNuwv3yDf69uOQiX0UNgIzdxNhS4IHJryFSPUDDWf9tlG04yAr4vQLTnMOPFBp1lHr
         74UPTU07zQsiF40Bg7O6aJeXoOCm8ZCABRontM2r+MwIHUSOFqI48LCHS16UbKG/AIdB
         wH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757315858; x=1757920658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mf60KEpOtYo2ftzrTueGZy7sJLq7dX4TNfcH1iOJbrQ=;
        b=mvqvOUj/JJIcZQBa9imjJ1NfWdotTSQiMwyZrUTlm+HlUmSXcEF/TViDuAjjDZ5pgf
         g0mdaRMNv5/nySvASURBw9p0t19I/8Vlob5sdAwQ1RbLYIg96sVVSdbTWCt4i57g2uee
         1F5/UGp+ndxGsRqMPhFuxNRHSgytAFogeZtyoCF9TVBrtXMMXDUC9u9T0fSrDFh7wWJs
         +mwEYywAijusHfVTkyIh66yOZ4ybD8nsU4keo7Ljp0MKpsBMo7QLCyCo20xcEyiKNcZH
         FFZqnHmYyS5XZrnDcuQnP7FfizADVWTEhNwQWueUIMNGjn0qL0p8pWrR303CzAiaj4Sa
         9b4w==
X-Forwarded-Encrypted: i=1; AJvYcCUP+rmcGGc4kJqZM+/jQs8YzgRE+RpvNlGBYr+4A/F3/xK8f1ioheq8holb6RZNA30aXA85tdvGW27+nPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhY7NidIvPvHWTJuYe185g9wjpoYVK0EntD0anYXUPNN63t/Ad
	PQUCvRkeBicxkYrZXVJJcIaiaYKlRLkuxA3Ch/SHY3qLc0D4kvWyAt6CorE4VGsVw5Y=
X-Gm-Gg: ASbGncuh30yiTp5XfsB5EPS1iMFD44/40JnFy8lLkZXyHdKCtGHrvbUQys+kWGZwG+L
	hcrZLw9IIusvhJ2M9jEI2neCZkXf8eE6IHlJApiDo0EI9oFQIFCfowYu2eWGd8riX9GMmXibyg6
	dGYuEA7wTPqN+WYKk24rQc2xy/GeNfidZ+2lIIx/dteU7w7HK8pF2cLOUMfMEgB6ICPhkBUU57d
	3XqG9U+slF8/FbAu0tN9hGQU9F8wngOc0haYCSNnPmv+egH6bTnh3rc0FFyFiu5t8kcsRog/WfW
	u/i3b0SdM1xWYh+HeDshRr5tFL0Joy7K8ef45vIgDU2xp79xCVoHG2Z3EwWhNbci2opnce0myc2
	UOkFwub5jN6+KBQ4bn0ULY+xxzSrgMenl5dg=
X-Google-Smtp-Source: AGHT+IH0JqpYFZVqWeKkKeYkUTLaNhia75dqiVhZQk0HOUL9KAlQ31w5rYSX1BpNLT/wUCE9UcSj9g==
X-Received: by 2002:a5d:5889:0:b0:3e0:6dbd:df8a with SMTP id ffacd0b85a97d-3e64c3b02c1mr4817342f8f.48.1757315858062;
        Mon, 08 Sep 2025 00:17:38 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:5cdc:d980:b6fb:1eb3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e748aa8104sm2982913f8f.40.2025.09.08.00.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 00:17:37 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Linus Walleij <linusw@kernel.org>,
	Imre Kaloz <kaloz@openwrt.org>,
	James Cowgill <james.cowgill@blaize.com>,
	Matt Redfearn <matt.redfearn@blaize.com>,
	Neil Jones <neil.jones@blaize.com>,
	Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/12] gpio: replace legacy bgpio_init() with its modernized alternative - part 3
Date: Mon,  8 Sep 2025 09:17:34 +0200
Message-ID: <175731585128.11344.13482539951129166733.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250903-gpio-mmio-gpio-conv-part3-v1-0-ff346509f408@linaro.org>
References: <20250903-gpio-mmio-gpio-conv-part3-v1-0-ff346509f408@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 03 Sep 2025 10:00:04 +0200, Bartosz Golaszewski wrote:
> Here's another round of patches converting GPIO drivers to the
> modernized generic GPIO chip API.
> 
> 

Applied, thanks!

[01/12] gpio: ixp4xx: allow building the module with COMPILE_TEST enabled
        https://git.kernel.org/brgl/linux/c/b23c22a8d715e6f681381592db377aaabc1a2178
[02/12] gpio: ixp4xx: use new generic GPIO chip API
        https://git.kernel.org/brgl/linux/c/bd9bfafae0239f9d7187116dace6e0d80d27b678
[03/12] gpio: idt3243x: use new generic GPIO chip API
        https://git.kernel.org/brgl/linux/c/f21c10649acc15802e942ca6ae78cb76657a0639
[04/12] gpio: blzp1600: use new generic GPIO chip API
        https://git.kernel.org/brgl/linux/c/59b82bedbfe7452996a7163a9a19ff1239fb86c1
[05/12] gpio: tb10x: order includes alphabetically
        https://git.kernel.org/brgl/linux/c/76e61b03d1228914928eb57e55dcb2c62b6caa0b
[06/12] gpio: tb10x: allow building the module with COMPILE_TEST=y
        https://git.kernel.org/brgl/linux/c/682fbb18e14cbb47dd30d2c65053be9d8f39a23c
[07/12] gpio: tb10x: use new generic GPIO chip API
        https://git.kernel.org/brgl/linux/c/8bbe11bb2fa378016a7e764c6207f6f5360cc979
[08/12] gpio: mlxbf: use new generic GPIO chip API
        https://git.kernel.org/brgl/linux/c/fff086ebc554b8f7942e3839a758cb8e8dfc945f
[09/12] gpio: ep93xx: allow building the module with COMPILE_TEST enabled
        https://git.kernel.org/brgl/linux/c/74dcb9473054954fcd8b91f7155aba5af3e4d555
[10/12] gpio: ep93xx: order includes alphabetically
        https://git.kernel.org/brgl/linux/c/a685ac653958f7249e7503d69f4f3fabb0642f45
[11/12] gpio: ep93xx: use new generic GPIO chip API
        https://git.kernel.org/brgl/linux/c/ab61c8b6138f4987cd1cbe605d6cc698b4902aea
[12/12] gpio: mlxbf3: use new generic GPIO chip API
        https://git.kernel.org/brgl/linux/c/f3c19e70eb897544160c4b96b9ad6b7d921c9fac

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

