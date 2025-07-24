Return-Path: <linux-kernel+bounces-744490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDF8B10D9B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B4B5427EE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0252E3387;
	Thu, 24 Jul 2025 14:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="2+HlHoaO"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8442E11B0
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753367106; cv=none; b=O2Bds6UR/4EqB8iZPSB1vttD10CQcxP8QnaEtczi7yErv4HgfmzF83XuGIBzBcVHv3CSYpPuJ+zfZUvAkdfJuyHpo1FzsU4gpLEQR8F552mA/Av5NL2at2H1U9nPdKdSdaAJXhZkxNnAm5SHeSDXjwI9Sc/Je7xIrJRGM8cMzTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753367106; c=relaxed/simple;
	bh=tfa+6qezgu9C6sQHtR8RqJsOg7dClKGTFK37obBkvWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aGl+81Y2DTYoDsGqCHt3xptGTdoq0VhmZDL++T0SWR3YEZP2OGGavPsvIdAAn2jtYr7tO9edGZ7Gul7N+sjp+YD0tOyus+fkVfb0OnXuR5lnm58YNuUD2+8nGmqXtRQIKcPgSLAcB7U6sGkPo1JikQGoO4UDptbUCQXqM6JEKCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=2+HlHoaO; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b773767fddso193617f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1753367103; x=1753971903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDwsomuNdj41hPlMWXxN9KpqGOWNIeXBjQB5e/Iw7d8=;
        b=2+HlHoaOpGMRBkyrfCsGbcyWR5Zr72YHFEW6t/iSRvc/8ZhkpFZERulVw8m6ySJhue
         Wny1dQNbDu+lg+JxmJmLOSkzoAzllKzDrjFSHZ30+MfzI6/ewrxM7Lmar+3Vob6O6Aa4
         avubPFaCsT4h1vW/tC0tg9OdIHob3ngobWLFsDe5zObNHairVpDIVoYbstIWCv1tld8s
         BJq/ccFL3DKGbwiY4Ri711HYZtIyT5tCo8L/Vqljtlx7rBqb5EzOSi69mkesdL2CIzHD
         1lob5Vba4/NcwFnr8pyI2Fvul+OvFSGbBrKHXeW1KCK6umGLDWMgbier3jgxbSHvrl60
         rsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753367103; x=1753971903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDwsomuNdj41hPlMWXxN9KpqGOWNIeXBjQB5e/Iw7d8=;
        b=Yk85BoXa9z36OxucQ7ZlyvrXQb71+Y+QX+AgFn0GJuP36t8jDnRqJdbmBcCriijx2C
         SiIWmtqztlLck1i6pg47r4S63DsaFEBRir5tPOuQgbAUDe2hzzyqIT9Y7vLm1EoDWIZy
         FOuf6DupJtTXRSn7jMsGsaz6x95132AbnSFs5Pr3Z+oXq2PnM1asgc9CTeVMiWSkoJN3
         /Krvm5T/Lb0zbcF6bRShoufXh3aN5UvuiNDm4C5Gp2ShIx0S8RJPjMYkY7mlVGgeeYjM
         dxEyrtsnkzCtTZIrvknEbKgpcUg/mp2HIzmSRT1GDggUK/RdZofIzb2p7l3omV/MIGZw
         iawA==
X-Forwarded-Encrypted: i=1; AJvYcCXE+X92fSLrl0r06uLAA93BfIu6O8Jpkb8XuLkcI2gG0RlvXZqYutxoDzCElI2qbQ7UEEcJjMgu86WF5M4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK71785XJ1z86kvAVMGxiYtC1ePsBaRQugTBSJLhSXeDjurtLB
	8WMy/T7vrlf+DDABQcvg7n98G4ddZLNyrO8UBpRKGvJynPE1h/1vfcaSYn/LGDoJ2XY=
X-Gm-Gg: ASbGncugao7+2cydy83QxCg2/4YG5I5DpsG+StTrjoaT062wBcesw7Ox8qf84d//C0o
	ZixmVptdDKjcTePIMkzbB9AXg4GP/n1htBL6P5A7jy3NsqhnUFvvtOXI4NDw/UXIfQkfG8Q2gb+
	RIV+eyXotzfljey9F63dx87SPu0N7V9CONIjOGoXHm7ddmbSfnFzwomzyUxVIe2yXtppaof9+4B
	1B5DY20aAkKtifUHKaW7obynqg2w0m+PMV31k0XvyuupldA8efIY3hQTGLx2hRd57k06RO+bCYR
	4x/mXrBm6kXAuD/Ox4bWeW8G/WsL2HD6qfNeQ+YGkChJbAiCfYJ+IvQ1jbjM234KfZW1Sc11vLw
	9P34G6TX/f7yGWQxTSiq9C+0=
X-Google-Smtp-Source: AGHT+IFVpPmoVaFnnyv2Q8MVKhGmzvbvMJGKR9lhr6Bsj/oTsmU/UJpFU4LVtR/XBu0GzRRucBDVnA==
X-Received: by 2002:a05:6000:2283:b0:3b7:58be:8fc with SMTP id ffacd0b85a97d-3b768f1f235mr5772547f8f.43.1753367102982;
        Thu, 24 Jul 2025 07:25:02 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:f44c:20db:7ada:b556])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45870568fb1sm21858075e9.27.2025.07.24.07.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 07:25:02 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Arnd Bergmann <arnd@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Peng Fan <peng.fan@nxp.com>,
	Lee Jones <lee@kernel.org>,
	Koichiro Den <koichiro.den@canonical.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH] gpiolib: make legacy interfaces optional
Date: Thu, 24 Jul 2025 16:25:01 +0200
Message-ID: <175336709883.93776.16672644078934370200.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250722153634.3683927-1-arnd@kernel.org>
References: <20250722153634.3683927-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 22 Jul 2025 17:35:43 +0200, Arnd Bergmann wrote:
> The traditional interfaces are only used on a small number of ancient
> boards. Make these optional now so they can be disabled by default.
> 
> 

Applied, thanks!

[1/1] gpiolib: make legacy interfaces optional
      https://git.kernel.org/brgl/linux/c/678bae2eaa812662929a83b3de399645e9de93ad

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

