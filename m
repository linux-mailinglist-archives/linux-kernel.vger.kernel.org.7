Return-Path: <linux-kernel+bounces-785441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 80308B34AAF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F1034E38F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F7327E056;
	Mon, 25 Aug 2025 18:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="oBmUIleK"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5F8272E61
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 18:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756148158; cv=none; b=nsTvIZKNh1a6lFlyBnxTEt3ndKUUurE+j2VZe3hYJ+XJtGKjsQu6Jo68F137dnE7eSrlTqCiequcQ9dpvozvhODePfyo/JF+wyeEYSrcZoeBTUzuYvtKPuHRTjflmvfHLPdiZ82DPxaAfe9qMrec/+OwL1xLbqcFPA1E7ScMwQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756148158; c=relaxed/simple;
	bh=YmDbGVYBJ+9vMA9e2dBcq+2FxY2Q/1XKrFd+tq0bRVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZA6zBZdFDJXT5v4Khd2VyqnbT6u+ZoHH2bOmEH772CvyEShlaBVAbYsHBvDVghUdoSc+FoRSXwNJNMI6znGCVXSJ8HE1Tf1QGNivomUhYbqThpQLjb/QzDL0nR7YJ0s0zRYVPO2XswnAkwX6M2zKm7pMej+kaEdeBnXR9qZwncU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=oBmUIleK; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3c68ac7e1c4so1383976f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 11:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756148155; x=1756752955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOcjuqp2a+AQWa/4BjFDLaLGrGNoZlGDy0Dboe/tYr4=;
        b=oBmUIleKGXP6y9Q6IvAwolFCJ38mcwx3OxWJPCDs4xCZkHJ6j5Gu8NIAzT8hwpAMg6
         PLE/wHDgMic2ocCZZEohsrntC/mBPZcjnLclWYtNQzCJeb8OgoAnEu+vQlQvDcQyh48u
         4mr/4tReGaOHk4Qub9SHzD5kKZ+tWrK9ed7YC6Q2Tz4xgahAmZVn+gTEO/4r26MX+Jg0
         EGxm/UpKUgQzeY0joTnyvUeEsXvGVL3bXlH+6CPz0upCRCPBOEv1MoMC6G8ph+i3Xma0
         dx09uu92A7tV/+zSOWvxWpXNmKcsgm+rXWBU78vVJ6/+C2kTkFtVlOgJlU9bTBZgx2Yv
         Bs1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756148155; x=1756752955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOcjuqp2a+AQWa/4BjFDLaLGrGNoZlGDy0Dboe/tYr4=;
        b=B6vV9+SOlj3/9kE2orFik9f6fEIli8sD90mKcE3ckSlgkOxfY3jm8MlsEy/oCoxERy
         HaAhcx1P6GQVlTIK3H8cwuru/TdpUqOaRO/fy1hkr7q2flvdlcbd35nAnFcIjKizkZSr
         b2sNkkMmTKKQY8ug8i9mRu4IC+5RKEThpQ6q5ranh1M21FgosSOHjJGLihyv9+GUN84K
         g74EwJ6yMtixarxwC1Kgd2T/irUR1jHKNaw5jkrj01nquo7rPJrCG05G+ymQ754xwb04
         x1aPJk9/17TCgoYxuqCkT/ZxvUu/stGG7B/WxgZu8x95kTFFmApLAa4LQAEtWMbM85kx
         jKng==
X-Forwarded-Encrypted: i=1; AJvYcCUPguYdphXeb63PEL9yz30H8mAp8NJgif9mChVUmDnqesFVM9o3Bm1r00MKyopn/7ag/42N5PyfCHSv1cs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqJI6WLeCcn4XClz2aeW2tlMJFBx+41hsYUa/ew5U5B20wDscM
	s2o0H3JUosB2vQwPaRqWZVqjwrUbXlyAQiWb9V1srsGjTIOC0iM0vpo5C6s0ICGjuugjhcRvJoJ
	IGXL9yX8=
X-Gm-Gg: ASbGncvrsY9XlmQA2FVGccwc6rFJbcaw2IWQ8uirfCf4cwIB50Bn50S2gQOzNxahiBN
	yBH+ojdJL9HbjlAH4wpivITl9VHmpch9USvHQxbYizpwYjm/pI8mOHPXf6HDHxFmRIUKjh8dWbc
	xEF06rOdCs9InET5XYfm/iMu9rmP3ZmsvkScMetkyU+4OXFoBNzFZaENQDYR22Og9bPRHLp/1Uz
	4TD/0S4mW7G1oXFr1Z3Xaci+kyjKe1Iw4A/uo3sf/Hgkvg8VBKi4NF1ZEWKI0vwkUPKUDms13DL
	1r7NfaMT/v/hDzpniCWdqc+GnCr+WolkoucHxCy8IeISx4WrPiHGRKdnPnGlDhI3vShHg7H4BBa
	mWLrb0S1PYmiDS39xa1e+UP1JKNLedERwUVKjK45EaK4=
X-Google-Smtp-Source: AGHT+IETHkwhkd+96DAgFu+2AKKBRYcWYpFOYdvJs3gDUctCwBERpoYuxxiBj5OEWAsSDDqWzul0fg==
X-Received: by 2002:a5d:64e3:0:b0:3c9:c3dd:769f with SMTP id ffacd0b85a97d-3c9c3dd7954mr3831038f8f.2.1756148155199;
        Mon, 25 Aug 2025 11:55:55 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:490:f8af:73b:7a00])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711d9f389sm12665109f8f.60.2025.08.25.11.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 11:55:54 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: sim: don't use GPIO base in debugfs output
Date: Mon, 25 Aug 2025 20:55:53 +0200
Message-ID: <175614815075.9139.9315465514348100034.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250815111733.79283-1-brgl@bgdev.pl>
References: <20250815111733.79283-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Fri, 15 Aug 2025 13:17:33 +0200, Bartosz Golaszewski wrote:
> We're in the process of removing unneeded references to the global GPIO
> base number treewide. Use the HW offset instead of the base number.
> 
> 

Applied, thanks!

[1/1] gpio: sim: don't use GPIO base in debugfs output
      https://git.kernel.org/brgl/linux/c/a16a3cb07140a094ffd918290cef76135876b532

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

