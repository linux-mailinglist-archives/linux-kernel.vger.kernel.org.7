Return-Path: <linux-kernel+bounces-762162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD58B202DF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8495616E1E2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FABC2E0907;
	Mon, 11 Aug 2025 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="SR8NFlZ8"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540C62DE71E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754903429; cv=none; b=i2aIjmK23SObzwImI627DEghOsWZ5KZ7VvE3TuVTanXjsAZz51sW3+yJ8XU6N6/tf9Rc1U24AjF7Z7CdttpMQqmuQnjNgyBkxTfZH8KsYXDK6AuRNaXXQ4HhJE5ALbpbTIyRn7t11/wDjU8GlVbGQ0lElHHkdMpEhvzWwvwr/e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754903429; c=relaxed/simple;
	bh=M68uVMQpulbgye48v0v6XRugtABzksy0xafNWUr1d8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j/rUS2lH66TPmqomybe36ktZ50WpdrjjqgwukM+Xu5ic6pUVkWe9drgZdy3dQu3o2CAucr6xMy/niBGBRrNJ/OjOZkJ8WV/nZyOK9TYOm7Xj+HOKACzQkQ/Hxf/cn51VmdAk18XUe9khivhTAB2XfAK7B2GGqtoaq8UVTYU6Elw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=SR8NFlZ8; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b8db5e9b35so2511084f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 02:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1754903425; x=1755508225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCWWcnBEIfeiHc1uumppXRXN8TIhuTosOXsIOWKXc88=;
        b=SR8NFlZ8oJ24+FbhNxZnVUKahU4+ROy+xEkf9pcDuJfxDI1948KDfhZ9S/4wHI/ucR
         xg9lVVym4Tixouqyb8YwqdIjwmPDqSQOUEIXK1RWfTgp1qDyENA3T6gx5ttfis302YF1
         AAqEyHYD1DrwM2cKOoWrdMfn89Ya4k8U3YHT9IqeNOo8oh17oM0jAl2UkrI9ZA+ZRU78
         lLYPNfAWeg7CpwdbQs1tXWJQkEV7BIg9HMlz5bvHCDhL2HRjdGFO/UgZSYpcujnubiHS
         IW0/9IJfx4R2du5W9Yrq1CNlXXjPAWXX5vTgLDo8L6KlT2Bgr5CKj8Fj7lWxkGr88/Sr
         7NdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754903425; x=1755508225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCWWcnBEIfeiHc1uumppXRXN8TIhuTosOXsIOWKXc88=;
        b=q8IXfwONorPy5ge2/ZIRXuMkqo5DAmsmb1lZO12MyNdI1gY/3/PUK2Yh0y617Nz/Ve
         915jrjY0TtQNUnbgwaKP6lnzWKnPPZAqq48tiTrsK2HS5mKDmEgkEzfqs2gDOPRmfxGv
         gsf8nJXdjDnHk4/T72yvou72N7lFAGT3XK9MF2d6T2MLgsYQGGWgCsFcJDQtCbKoABTR
         DIImdkQf7k1KeTrNN90weX2+NbrWmh9IhQr09LRhLVA5OYlpDKeVQNob1XCLTlqv43Yu
         7xgupZx7RekxctegOfzWghKpk3gqYUvmkYAa8JpFyKBH7OpUP2SxyVL0CwmFoNtKCRND
         48nw==
X-Forwarded-Encrypted: i=1; AJvYcCWDNgIbDZyR8PEyryVpnb7shcgZAVHyRhSPs04vsn1VA076vK6RH31tDSlTvM9iEHVAnzQ8nSmPaM0xVoA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz6ddix+y4rQeY0c4yHEsfS3Z6A3rtQmtj4mAQfnphco/w71d6
	x2u+rvwUWZAhmrDVXJZzpTor0YiYEBQJoR2sLANSiifE81z6pUi+eAy/C7vVkivM7ow=
X-Gm-Gg: ASbGnct7R7XKawRW0GBfVJJcVN11IlfBz3x5Rb4M053QZChs5aEZLsVjlVKuvjp5G+g
	gk2gomZqotXdlgYUS0YkKlBbcdHLZI/uRRMvAWj7M1XAtb4Ajr46OPohydsJqq2pQOng4lecwXP
	dAb9hHsoPCmtyOSftCf3UEkHjsfdPXxFrfhm4rfp2712PezE0r+jJ9FeUK8VMh65k3LH/vzIr3b
	I6gq1wuZVWjWGD2gix66UsUXB9nt8zhdnxJKlX3GrEaD1+bSdRq5ES4bpMc1d4sNVjdoCXEtnTt
	DrAnv84KIfL1CyWZ5gls/v7O/sfliEaEFrp1rZZ/L+ujHb1ie2JtsZvwdHmfYXuM44vJt28bXFc
	aZKKIIHypiZ/qsHtUpV3rbKB1
X-Google-Smtp-Source: AGHT+IFcsRQpF2y3qvZCx8CEhahwxH5ywYYmgyKLZxCskge/Ce/FxoMSAajJ5ljwUgcIeV+8J9CNHA==
X-Received: by 2002:a05:6000:40de:b0:3a4:f50b:ca2 with SMTP id ffacd0b85a97d-3b90092fbb3mr9639037f8f.8.1754903424211;
        Mon, 11 Aug 2025 02:10:24 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6841:8926:4410:c880])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453ab0sm40220239f8f.44.2025.08.11.02.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 02:10:23 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Waqar Hameed <waqar.hameed@axis.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	kernel@axis.com,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] gpio: twl4030: Remove error print for devm_add_action_or_reset()
Date: Mon, 11 Aug 2025 11:10:18 +0200
Message-ID: <175490341188.22509.3589235210519192885.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <pndjz3im7te.a.out@axis.com>
References: <pndjz3im7te.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 05 Aug 2025 11:33:33 +0200, Waqar Hameed wrote:
> When `devm_add_action_or_reset()` fails, it is due to a failed memory
> allocation and will thus return `-ENOMEM`. `dev_err_probe()` doesn't do
> anything when error is `-ENOMEM`. Therefore, remove the useless call to
> `dev_err_probe()` when `devm_add_action_or_reset()` fails, and just
> return the value instead.
> 
> 
> [...]

Applied, thanks!

[1/1] gpio: twl4030: Remove error print for devm_add_action_or_reset()
      https://git.kernel.org/brgl/linux/c/0d1e68fb1efd2fe951d68cf05460e3672d4a846d

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

