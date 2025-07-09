Return-Path: <linux-kernel+bounces-723932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4489AAFEC8C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8508E644C3C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB412E54A1;
	Wed,  9 Jul 2025 14:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="oODtWeLm"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95CD1D63E4
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752072584; cv=none; b=FRUNnILjbUxxl4sD6JA3KO05RaFL4A7uac0fgvS5boEiFzYDue8CtA101iA7ysFxR1uBwOBRpbW6hPdVHYZcgNC5C2z/3WX5W3yw6M9/jFRKmMsh8szj1Rb0nnlhFN0zGL1A+28H5lnpovuqtP4zXxdwfcrRzggbTsCcxdvNAig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752072584; c=relaxed/simple;
	bh=i/3T3rgCm3LbTB5t6VdO73xMaOdq9fqlxsmlO44cOGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D+deElhCh4HdkhEZdG6aqPBtTFOmc6z8U3bGYu+WWmqQMIgfYOJql7w8inA3yAUeq/b2vLgJhjRTze3ZNo8cTc9cWPeYMn74vi+5QIcl3XQs1oodP2g+/ZWYwfitXT6yIEN6p4TV3Pyn+PmxR+aBwo0hb8KRHdCljHUqvGsf+JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=oODtWeLm; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a6d1369d4eso10941f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752072581; x=1752677381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+clCZcAmNaEhJNDxw2K6HurtRqBRlDqkioZalS/QiBw=;
        b=oODtWeLmpFA8KAWPi4S1KvNXKqBJpQdCe/FfHceNATbJoJRGtUTMrLJch28HSAvepd
         OWFnBrn2Uwri5FNNpQ8lGnvBHQ+F3ZtH+ytnp+eCB4rvTEzkR9521a8LrnjR/QoZhTRY
         SbeI6qsjBBGoYRVznqLdyZCCmN0T7/aDMtp2nxBqTe8Ga2cskdkn3lJFozeg4CGRaQjt
         IRUwY76ZbdhqmlESPZFScwt8FXbLIeLIZBLp34EYZ88udWJaR1e+pG/AL3vEqr7Hysoy
         C1RAt3BanlSROB+83he7Jk1urRMWY4O+w/c7gJFpMX8HJt/0fOzVxsZ4VMd6Zo+RntBO
         /oJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752072581; x=1752677381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+clCZcAmNaEhJNDxw2K6HurtRqBRlDqkioZalS/QiBw=;
        b=dLhI2xBUif7KADVBAqh6CAv6ZKPAym73RVbEpi6Dt1UfRiNfjxVxWm8enH8JRW2ZCy
         gFB7rxIcQy0SeUfSSw1XPqAliixpcrknM++UfbjDhaMB5c1qB9aegUc1EEcQ5Cdaxn64
         gYxuq4SQHi0rEbFXEw5lxNLb3RuKL6euWx8RcBnhEM/l7ka9jNBLT7vl9acouJnYZRgk
         cVK+os2CE9QgjvfJOSd4UdNc+j1wZmT8GEiFiF82N7/PUrNXFeZcFYG02OeSe338KozF
         n6AXu/ND0+rQ8wibBPE7VihVH/BNb7AZnOo0fK7LdzlzC5hqtujjgscv526KqMi+ZyQg
         t2xg==
X-Forwarded-Encrypted: i=1; AJvYcCVDgt7I265X5A6jj5bKX79DRwFIwhH1s3oPHg6fOBWKs5P0iGzqv9an588Fbh9CCINbzZln9dqeIXzJ7ec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9j3+58lj6alJRhl1hL9FTOKdx6Tqt8w48AEVD3OYrBmS0T7Ay
	38nkkH5kJvXi4l9oM+/EHYtwLPq2trChAZCPfmuoCAnurV6EO1Tn25LLrNCdf4TuSFs=
X-Gm-Gg: ASbGncvkXT1o7BjTqJ0UgeqnY6FEGvyRjNqNkaluH6M05P29igpRskN9GfHhsdvJ8uB
	4/IB6UPhjDxkNmzQxK+8lBse8Vx/9JrPlh+2tb8NEfgnS9uPOkqWfwCVvVrPppYPnlWFLd9XkNn
	Q2Cb+Y2yNx+aWUg1OoObjaRlktCYIQ8Z46vAHx4nkT/gdkOF3S/C1SE1YH3I0f87e50Z49BysXq
	67hZf/5o2QKdPoOPNQFTHkiWrHDXzXYC64IaYE24EGdh4UXi2Aw1REXzXT5doIqAxRogfYFWVUg
	0FTACjhteMI74TPt2BNyvQG5QZu/ofsCgrGi6SQJFGPs5SdIDnXG6pLz+0AwmmAXDwU1H47HcA=
	=
X-Google-Smtp-Source: AGHT+IEvnogMibb4vYHlJHRH2PNaGzoX5smkfBnnJv6Rl4n+ke+bVilxmX5/5ST1QwlJ7GZnt/JGzA==
X-Received: by 2002:a05:6000:24c6:b0:3a5:26eb:b4af with SMTP id ffacd0b85a97d-3b5e44e9e13mr2351579f8f.18.1752072580842;
        Wed, 09 Jul 2025 07:49:40 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b04e:cfc4:3bd9:6180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5062119sm26543685e9.18.2025.07.09.07.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 07:49:40 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Kent Gibson <warthog618@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: sim: allow to mark simulated lines as invalid
Date: Wed,  9 Jul 2025 16:49:39 +0200
Message-ID: <175207257347.43561.5299868235496742290.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250630130358.40352-1-brgl@bgdev.pl>
References: <20250630130358.40352-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 30 Jun 2025 15:03:57 +0200, Bartosz Golaszewski wrote:
> Add a new line-level, boolean property to the gpio-sim configfs
> interface called 'valid'. It's set by default and the user can unset it
> to make the line be included in the standard `gpio-reserved-ranges`
> property when the chip is registered with GPIO core. This allows users
> to specify which lines should not be available for requesting as GPIOs.
> 
> 
> [...]

Applied, thanks!

[1/1] gpio: sim: allow to mark simulated lines as invalid
      https://git.kernel.org/brgl/linux/c/0cf6d425d39cfc1b676fbf9dea36ecd68eeb27ee

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

