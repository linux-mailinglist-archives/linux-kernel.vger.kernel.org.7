Return-Path: <linux-kernel+bounces-813340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D08B543D6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22D464676D9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 07:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB492C0F7A;
	Fri, 12 Sep 2025 07:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="QWBvJrUZ"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87CF26AA93
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757662025; cv=none; b=NcODSp7X0Zk+8ta+pvBvJHWG63LnwMBRtmC12eOXHR2SAN+VbgEb1rWcJzCGJXdo0rN0IAEX75p9u1XOB3v/4JWsBxLZWBcRQt0IiNvNFxEq9NabLgN/Xp60UNmk+UTBAbRAe9ePSjdd0B+uuFi7ljUI/KqHnX7g8/es7eZHxMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757662025; c=relaxed/simple;
	bh=5lNIpCLod1ZLxeOqceiGCotAnAHsNRxodHXq4jW10nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sn2UnfvXI7n8VbSH7iSr5uBnuU4gLmFHoZvUa/qkOIixkZwaTEUL+K32Y11dhGNmPvlHU2Wc2WjU9kUZZFRclBCJLxnxGJawnf7yYNOB4oVkvicBIhYVAjC+euJ/oybo3Lu4hlsPM4gZhnU6k+ML1rdI0cTm8JY/rxzYA5orNBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=QWBvJrUZ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3e4aeaa57b9so1445073f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 00:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757662022; x=1758266822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFDxDxYxS3ZKV/v8Txauv0qOZ1rvVssij3n5NtqF28s=;
        b=QWBvJrUZcfBG3wVnQa+k5f7KH2D59edH+PCnRV2Qg0xoVZOlmIRHOjmT4aEWlroUiZ
         16KyGdmg7lPTz3R3ro1GhoIrABaAn9jzSPAz0c41hwx3szew7rssUyNkRe9lKpkBbAfT
         7fygQdPdyPy2PPvyNM3wFNBui+EEOPEcB2E3qdIXzs6hbqfQHDPRaBQcNYM5sZ6Yn27W
         0mj85raDW2llqTfadI7JYlDp02EqjYMNuGGOsDY47xZkOdguSAesQFcZCcZwFfci61j1
         Ntkc5ksEHqWF/O3kuAtyShUlKEkhBlXwlqEYZIoX6vNtIt86Wy10pDigNrFGl0xeP2rd
         zkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757662022; x=1758266822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFDxDxYxS3ZKV/v8Txauv0qOZ1rvVssij3n5NtqF28s=;
        b=LCIVR92su3a0ZUMPQmIxAqsUaT1aySDckrQFvsUjIUKCRWdIlhtyfaRZ920/ntHXwP
         LVnsWUEC4uycm4y98IsDawoFEh4rvyGftBRPZa5jYFP1ldjq1/0B3DemC4rQHJxepVOO
         dUdU4a21necOv2Q4XyC7B6Sm0hbmApkcMh2Y6Z0nrXJAWaPpg9CcALGmPrNHL6IO+0zW
         vZhjlz2/2Dhc1q0Tv+ihHtSrQgUYMraa6BT7UPL1gnJ89OX/Nn2qMigkBT8wxx8r0BNc
         X/RLALM48wAF2FaKETrh+mIMYdQHMxOkh1cBN1yABtuoWft+LEhPW1Vlnkf/UNdWdzlZ
         MHJg==
X-Forwarded-Encrypted: i=1; AJvYcCVvSc9njGg/ruFTXdqhyA/HwmLdlw84gMKXgagOrdNddM/TiNrCaeRPPMqjBmBG4DqPdfN0fC2g1pF24ZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAbH10KhAoGQ/+/U9hs7PFvaVpHDNyKOMb4vScvTQ1YPqLq5Q+
	a+ElrauAGwBoa1lEfqkBRUsa+guIsKZcBHzuPwkOdz2qYdhilTDzdPxdQDmS5v8/HpE=
X-Gm-Gg: ASbGncubZgUxB9J7qqgzg9L5zqg2o5ygkiHMefro/M+cbM6oX+ymsZUZsw4prXr1Zd+
	Wuw+RoumiNCTRQuoXXW3mcoHsiG7OF4Fjt/YLdmbP6LT+HmHtPiYnkl/IBS4bh3UfI7BT/OQI11
	x1091rDWmPm4KUiU2wFAF+rc5a6XyTP63Qfj9Tt/a7oF7KoBUuR0djpqLdEUIX/nsBVpFoC2qUk
	vfswuodapW2tAiuBJPLSEzRRNOqQRdy0Q/z/RMmlt4BTRW6ZfNWG5qQVD+hwXC7YVF7gneG1wI6
	A1IvVmd7n8Ib2WtuiGFHCynx4mtrT7QWcjKFCkjIWYYziMe1c64wrMr5N1KSMeH8ps0BPGizzKf
	tGSOpUrd95ZlymUhl68l7Sx/sdYA4oZEMrQ==
X-Google-Smtp-Source: AGHT+IFatmuX95JKCSPc792YndUNojFLqNhVLhXzW0tmPmShCeo/svvR7nixC/n6URYb31ZyJKxSNw==
X-Received: by 2002:a05:6000:26cc:b0:3e0:34f4:3225 with SMTP id ffacd0b85a97d-3e765a09238mr1952786f8f.45.1757662021871;
        Fri, 12 Sep 2025 00:27:01 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b6ab:4211:ebab:762])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e774a3fb5bsm730202f8f.58.2025.09.12.00.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 00:27:01 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Kent Gibson <warthog618@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: add a common prefix to GPIO descriptor flags
Date: Fri, 12 Sep 2025 09:26:55 +0200
Message-ID: <175766186358.9646.9647501924700863520.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250909-rename-gpio-flags-v1-1-bda208a40856@linaro.org>
References: <20250909-rename-gpio-flags-v1-1-bda208a40856@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 09 Sep 2025 14:28:43 +0200, Bartosz Golaszewski wrote:
> While these flags are private within drivers/gpio/, when looking at the
> code, it's not really clear they are GPIO-specific. Since these are GPIO
> descriptor flags, prepend their names with a common "GPIOD" prefix.
> 
> While at it: update the flags' docs: make spelling consistent, correct
> outdated information, etc.
> 
> [...]

Applied, thanks!

[1/1] gpiolib: add a common prefix to GPIO descriptor flags
      https://git.kernel.org/brgl/linux/c/571c65bb2f4d17198189cf8d161b96f32674642b

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

