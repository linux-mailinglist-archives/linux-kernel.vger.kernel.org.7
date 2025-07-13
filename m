Return-Path: <linux-kernel+bounces-728991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC508B0303F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 10:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4FDD1883E49
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 08:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4162571D4;
	Sun, 13 Jul 2025 08:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="c9LOeKuy"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C9A253F1A
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 08:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752396249; cv=none; b=munzWW2hQedqesvYRmBZXWz1/lAqLWzbqKmuwPMxuSj0KNiiL5A3XZmwDNJ2v0ScFdTVbj4QaGxVkEdOrJcrrRoPmnb9hF/vQ+oZuifjnC+d1qvN7OyRQiPwpo0kAQoaTXn5zRYUfgIw/CyUtQGWEEnhkx9RJYo5CYai435PRzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752396249; c=relaxed/simple;
	bh=VjJoXm/OtEzd6WSH8LX9mgg5zlg7VGtKg6xCGq03KOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hKvjxsf6ruGG6hAvW/VVhW8F9rvb20Q08tlczhiDmI1bUArLaJU9mzOCY21m/qxN0c7DwvSihq0+mIV/FvGQHQ8GHVYBwMnqVPamt+MHC3d5zOtz81d3ULW+0R7+8jHHfDGs0pxIMP2Up2OMu0s3p5Y/7n7r54X+xxhHga7IUWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=c9LOeKuy; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a6d1369d4eso1922936f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 01:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752396247; x=1753001047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yoBxPNWdp6682YcqAmqYQy7nMoXgZ5Ir0h8JOXzX/E=;
        b=c9LOeKuyPbPVWiD9M6nvg3aqksWP16qfV/cf778nOcIsLW98/Hp1zlLDTcBZrdRhBM
         NNQEVnTKTvO27YqP7f+qSOYZByQ+R9FzTY5KAcLVGzBb2eL7gJM6zUWBmR9Dn0upLIrO
         q+pyYiv0bTYdudOst4QG0iM3HX6M6RzkQE7rW9JQ1FxYZKo8nKLBUJQcCecQTLaRoM0e
         XRl3brF+yFg4gPECZoFssVJx3XUhdSBrBcpIVSKP2xsaOQQXhbGtZvgnr/cWgZGof7zz
         fPyPdJoOpFm68ipFaXTyCsDopYaDtNToKaa8SqdRDyvWw65FlEixDJYhIlM9WeTPiTuO
         3auQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752396247; x=1753001047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3yoBxPNWdp6682YcqAmqYQy7nMoXgZ5Ir0h8JOXzX/E=;
        b=KBFiahjIu4KywZK47NgVGzE4TsFGXJGeJ9ziWGkZdA7pf+wgQFewSGcHX/+YwnYIZ3
         jT0IbERCsEvWSYlOgy/LsLhA7iZ+LZzI3Z86cZ9282h94GD2mMAERqSmSJK1j1pbZe/9
         mFegcIe1VOcxXj7DEIhF2T8ZT/9fB0c0IheDokuj3YOEpd88WyGvjydlW/bjyR1M3iuQ
         le7ukAAkWJoJxBc4DMUW6Xwj+kldImiR4VSgNeh+rCwA6WWd7V2Nvh9fBhzFtMkz1agr
         8XFJPdIISFUrxCrn+yYjyxgaC4u9H6+Rdqc157OOtxm1TmuER1+x8TEG0hv9zjXsrf7T
         hcHw==
X-Forwarded-Encrypted: i=1; AJvYcCX8GnGdf+yHBVdJZpgCL9pDX6WIIdUbbex7ZaObuSmHTVJjbEwMYU+KTwz+4CCbg+o9Mi5E5V9NUDnIa7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV2FjCLy1V5NpgO1CAREKhLtNW42j2fmCepOcN44ThMIJ145Bx
	JdqnpTAn5cfKknBVYCy/rdGTuG7VOxP2DY5i4441y+rDunwJJwmJDgu/5ZMKWoKT0Tb6NIugI7u
	XO5f20y0=
X-Gm-Gg: ASbGncuPt9Y69rwBMeZyFzaxlFMmScEL50J5IfsDlnrlF4KzTyPa/eSFGI2d9H5j41A
	n6mTEqpSWDvRij60YjcPXoH2C5fFCifISw9bz95IK7xgqpr00ev82h6IozduxHoIro8fQrRWkha
	gJl0Ter+Ww94wZf4LrjPE0E6RIhSd5EcC0DfmpzDGfT/Gx0pXfJo3alLn17Zdm1ERFF/z/b3f/v
	sYngx4sjFuthvLBGl+vj8gK2RIvY2OjLA2rA+Ij6wB+ANT9GmB9lR3r/o6i8uImM35cj1GAunx1
	uJb1F7A+DzANhDfejXwGpKHt4yGefb+eXA4EZUqK23rj+HvWonEDxH7TU+0+MT7+z1o6bwpKEzN
	+3Jpqsh0v3EKtmHX9Hb3SKr4=
X-Google-Smtp-Source: AGHT+IGyIlgk1OerLolTNkIA3PzN0cspSFYNQycDdCytpPtQS8uH98PKP9muX0TGzImEZz6zJlr4Uw==
X-Received: by 2002:a05:6000:230f:b0:3a4:f70e:abda with SMTP id ffacd0b85a97d-3b5f351dea6mr6874812f8f.10.1752396246529;
        Sun, 13 Jul 2025 01:44:06 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:f695:8645:1433:4418])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e26daasm9445615f8f.91.2025.07.13.01.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 01:44:06 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: don't use GPIO global numbers in debugfs output
Date: Sun, 13 Jul 2025 10:44:04 +0200
Message-ID: <175239624288.6032.7125676131677562075.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250707141313.73169-1-brgl@bgdev.pl>
References: <20250707141313.73169-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 07 Jul 2025 16:13:13 +0200, Bartosz Golaszewski wrote:
> One of the users of global GPIO numbers in the kernel are the debugfs
> callbacks in GPIO drivers. Before converting any custom .dbg_show()
> callbacks in individual modules, let's first make GPIO core stop using
> GPIO base in debugfs output. Use hardware offsets instead.
> 
> 

Applied, thanks!

[1/1] gpiolib: don't use GPIO global numbers in debugfs output
      https://git.kernel.org/brgl/linux/c/1bec20dfa3d81be716e7ff5a6343bdec1d29b828

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

