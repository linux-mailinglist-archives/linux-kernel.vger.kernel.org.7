Return-Path: <linux-kernel+bounces-749280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 671A2B14C49
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1A8545AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDB0270EA3;
	Tue, 29 Jul 2025 10:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yNwA2w5u"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528C8264F8A
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 10:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753785395; cv=none; b=fNNm4bh9ksevwuYeS9nRrP8w25m5Lhz7Iv5KFHiGfcbOh1pMNTdHUqY8EmeqXOtHhYdwvdkLyRpKCGLxWluS5M+1IOlMD+imVhTCjlSyMjHRhqXg/7qQyEo+rHVwGtj3+vz3g1juASUNnt25XKkvllcFdQ7SDS1l/u3X3vBQfEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753785395; c=relaxed/simple;
	bh=JkOOl1qHh8wPHce4AVCasFuw0+R40eyw5LBg2HuecrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=atnMG0TNZ84NpyypX0B2dioEvtGFEG4G/RAbZCOb2uyx9N03bwRHbsiIW9Pw8j2N3uoCDgk4ucSswDOkVZlU/8mriOt1xGxlQLVH8KMBmI+ID6d2ZWnS7rnLZviUr0yO5uMlZqgUxwqg9Q1Uf0chahDcrTQSdC63c+k0RLA8hZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yNwA2w5u; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b782cca9a0so1915154f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 03:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753785391; x=1754390191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5SlpVvwQN3dO1/Sw/WT9GrsHCvzTZlBS1ya2qhGGj2M=;
        b=yNwA2w5uXyUqKA2rOlr/a49zxtJfBlSW9Z3V0y2tHZMRGdtlly46dK4LpY9N1qCif4
         yuIvq9pOCtVvtctqu7+yPcGVkTg5myFfPPZFXjyzr4YrztTjxXAzh0OwBUZ1JXbj4GU6
         auBCl1K4ddJku2zTdKKoVqMMMr2+wzLm0h0LlAIvuprzAfB40SByo5UE051YQPkVl/qq
         E98CLf4ccNa36xT8SNecqA/XVArjgB7XCN0OG9uPYdG9VhwraZEEUWl2vqcyiz539X4w
         MV2Gc5f1fRCefhQ388GXrnTiUW+5YI9U+SlHrgCKvfVVDY4LP9uBeo/SB9xnCLcFt/GP
         yu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753785391; x=1754390191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5SlpVvwQN3dO1/Sw/WT9GrsHCvzTZlBS1ya2qhGGj2M=;
        b=spX7cqC9HDye7LfsGeFYkE/OQJCCcYbQ2rV68tpZL7JRs0hDFZx5eHIw0R5A9oGK2L
         /Xe0My8YF67Z1DmnxLlSvj2lNh8PL4fUaAC9+Dwm+vIYYzr3HIjhhVo/BpWIH1yguNR2
         KDHntRdhvN0cN7FcvFHi5Yk/cTE0AVUg//Q66cuVgg/hwenZrXqnY+rxDLiPJLsAjlhX
         fgBNSnPMXp+rCyrYji5uE/u4+c1nXrSP63obza6Jr3fnI1zpPCdfpk6jv85YRr/m6Mhv
         noD14GFlBofAh+dZOwbob4ZWjjYawm6rvGcD/odnIG68CI69wIuMHMTaWMdyPgQjJ7pD
         x8Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWFxPC0mOyR13yjMq9XI8kiKW9d9mRtIManmyndf+xa+vZtxQ3bV3N2Tr3hcC/O+cRD7TBM6kkIS+G8A2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlgzvKZshqvpPUWgwT3bjdG65+EF73ulSwackEU3lMj4hXpkrN
	up0QMbVNPsiHHNjxtgl73R1SLHhqjCd0RhfPm6jneqLiqN/UkI5Aef5IR+/kU6hgSt0=
X-Gm-Gg: ASbGncsysYAyz8pWQU1SUSyRnXGT5LQQyNl29k7FgszzuZPvxOKDb6ujNOjrGhUgro1
	j6ypZRDkEOAL6wcHcYYnYbwXXvYfbAyvbQ+2x2Ju+zdc4TkLOrpknhNNQ2x2mwArkLH/pNnZ7Ok
	dpA15RTtZ2dCJrhhAnyIUp9DZnJTA9bgda7MAUQPkBUQTQJoDOVTnrIHTf2wylDzGc2qETv6wJP
	bzLWZoIMylwZ6rjLB/9csUVZduSnpEFcDQwrCBei9d8I4zfv9HL98Rcht8ELzSayH66aCRI05L2
	ln1+qWHLtqNA6Lcyma+1W4dun4Udx2vBCVVm9QydWJEojSQxw9Iaz16yMstUxkGgmM94Ab7RazG
	7uG+Q6QPFGkhzUM4Y4NXrvWOv9fZ8UjgLffHTrlgh3HwQDXmCepLNSHr+xq7wr204
X-Google-Smtp-Source: AGHT+IGzeWX+Xnx1WFxojWPmyuVy1qNE5mfB/5ypGs8kFSziF/qB8m1k3GfOBoFqnttO2zo8LLpWpg==
X-Received: by 2002:a05:6000:230c:b0:3a5:2b1d:7889 with SMTP id ffacd0b85a97d-3b77667470bmr11089986f8f.43.1753785390605;
        Tue, 29 Jul 2025 03:36:30 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-458705bcb96sm198733475e9.21.2025.07.29.03.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 03:36:30 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: David Jander <david@protonic.nl>,
	Clemens Gruber <clemens.gruber@pqgruber.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] pwm: pca9586: Convert to waveform API
Date: Tue, 29 Jul 2025 12:35:59 +0200
Message-ID: <cover.1753784092.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1191; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=JkOOl1qHh8wPHce4AVCasFuw0+R40eyw5LBg2HuecrI=; b=owEBbAGT/pANAwAKAY+A+1h9Ev5OAcsmYgBoiKQPca6C/vrx+meTg+nZPyEslSZIGN74SFQB9 XEl5jm5XtSJATIEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaIikDwAKCRCPgPtYfRL+ Th8pB/YyHv5/fmuidPs6QqWuBfe0NAgkVUTVTbg81DDBnaxEEXVeC1axU8ZFkw66Dua20PH+vKM V+yS+8EFFR6hSO5PQi2DY+gGo19Abp5mVsawNd7HRpKem9wP19IdLq4cv8dOgxk+ZLKsuLikM7h BxlQ+h9iBY9zCCqRnZpOG0uiwegVulH357205tLbhjYgNaG4MsGbbtb1pVSnWHoCL6VNGbeTZ0x 1MKDMjhU+vzDHGhAkpLzGIKXj57+/5lO5VtMjmUSlqtfDhSg/aUBfiTlkUN70V8aNarx0snn+7z cIGrhkdN3ce8NdWmYbtlmKLiJa3TnaXZp21dOZUzIgu3qHs=
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

this series eventually converts the pca9685 driver to the new waveform
callbacks. It starts with a few minor fixes and cleanups before the
actual conversion.

Note that this driver was the only one that supported the usage_power
flag and when it was set increased the duty_offset. Now duty_offset is
under control of the consumer, so no functionallity is lost.

Patch #4 drops GPIO support. Though the internal details differ a bit,
this is superseded by patch
https://lore.kernel.org/linux-pwm/20250717151117.1828585-2-u.kleine-koenig@baylibre.com
which provides generic GPIO support for waveform PWM chips.

Best regards
Uwe

Uwe Kleine-König (5):
  pwm: pca9685: Don't disable hardware in .free()
  pwm: pca9685: Use bulk write to atomicially update registers
  pwm: pca9685: Make use of register caching in regmap
  pwm: pca9685: Drop GPIO support
  pwm: pca9586: Convert to waveform API

 drivers/pwm/pwm-pca9685.c | 555 ++++++++++++++++----------------------
 1 file changed, 229 insertions(+), 326 deletions(-)


base-commit: 68b9272ca7ac948b71aba482ef8244dee8032f46
prerequisite-patch-id: 917be1150626d7632f99929ac9f7dc1449864979
-- 
2.50.0


