Return-Path: <linux-kernel+bounces-816468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94427B57423
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8518E7A1FF8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D17D2E5B0C;
	Mon, 15 Sep 2025 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="fAo2iTxR"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EAA36D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757927417; cv=none; b=J1GU47XlAtpQfoKGwWtPpER06K+Y16rOEMp5icKeATW11Hzj22RdoxrH7y+vorn5/pN48/xo8tvIuC4Qc6JbOdvMcBL9k9E303D7uWdFaN9fehyFHsAuPNw9yvd+XWfSGTR6aK8NAgt85dafcfHJEa8dJCNb13N41yeYnUv2354=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757927417; c=relaxed/simple;
	bh=uiQSyjJBLeC/MEWWFA0joFafr04ol6ZutVaTfVfNm1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HAmSi50Lncp6lh6j2uzKJ8B8GenVYkrSB8nKeZsSqp+i27yBE30KX7iOdHXTxkmNLKxUKT3MkJLsknBDOnftHAJBIOzUyQ3mldAt9UIYIYxEz8K5SB2Bb/78Bt5N734iASfWuHiYY0G+dsOXbrpZk/LivOIGAIvWivFtBqpcEPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=fAo2iTxR; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ea7af25f42so533454f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 02:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757927413; x=1758532213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4gC48CuIPVAUpIaPPbdHqCEynXZPl0UGj9pzUZ/ahgw=;
        b=fAo2iTxRWbc/36BZFYDH4zxOzrnY4vmIOGc7cqviboGCYYT6xtZXZLaHZiu/1fQHVm
         z/pJ9k8993OiP/l3Nv9W0sWG1jnDqAC+XHpFiM6CRFf3BitysgGGj35j6pxr7OHA0TJN
         h8tUx44aOkn9gnlqLZi7g1wmuNtwnp/wyNi7vRbU8YXNqf5tMohzWrQ6MOzV0o51VIZN
         Gyb8YgUTC6Vi0BLoKkV3BHW5Ibe2oD2In7mK1R8KyNk2CTqMxjQS2fdm5a1IqU2ajxsh
         nz+UCLt5F9b1fYXB+6Ql9OkYHcHN1rjn0ECxLOU/niRfySqK03qrYEhPqdeXAsdoKwmL
         1CFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757927413; x=1758532213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4gC48CuIPVAUpIaPPbdHqCEynXZPl0UGj9pzUZ/ahgw=;
        b=gSaKf4ssBpKAVU5CkPICgFhOOgfVZOLpR5kxhXkNJiC9XLevDY8CAW/QgAxyi+tw1I
         gGSO6HNsThjvH1g6xtHii2YigTB2J07p83lSmbvMAGYvXH61nqzausu8T8ODreo3QWYF
         VqOdc0JZDY9IrXycKrpW9gdR/eA4EVetJR4LNTUmNexlXW8waFsaEeTn82EY1MB4EGKU
         TmPCAb4O1tpT5C9YmrgXPOMKDEcCOHwld4DizhOteRDRwZyrrHCBrEVEtWzEI7eItCCb
         BWkNAo3gGv8zTE9E6SQkqF0sLTzanwKpaJIg3dHStnj6SWZsVTMyBPcbFjwuPQW71awX
         lRtA==
X-Forwarded-Encrypted: i=1; AJvYcCX1r0Xqgv1MgC/1s9btK/S3OkCCml4cLWc/ur8aMYjqnMaRL7d2mWdnnHYsEt2EkctqyfLuDaIflRunlt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKn2x9/ePlbJI4QQ039k3GX2RaONRa+B4VvkmWg19KGsYMFOSm
	VYGtJbmAhg9MFyKopnX5EpwVebd7jsPqdhXuUCBX/bR5LBaD/FAGUOQEyCW3GHYuzw4=
X-Gm-Gg: ASbGncuVyjg8O0Gn7avpGbc6iCG0cXUrkGu4pHQVbZbPBBSCkuUwgTUZIMzS8OnIpWQ
	XZsaRjAlZkERwHwKAFSzA3MowZQNRTnLUSpvXELFj+LbL4vFROMg1EknJOBlKJ11LNr4bhwgDaM
	/ryMEQNJc/e2fZhTtGXjwbagNNkoi11a4DwXVyGQLqIreTaYaC9NFayNFMstgTH+MN/R238C6/O
	1wmRlLqfEwFh1iQ36cOTIpAx+QFODd/FVg/nA6q6PORU9961wUjytc2vvJ+0zEyKDaksLf2mMs1
	GhMLYMS0bJPfS9G/OV2qwgMbrnxTajQviyn474KjDz8Yl5EG5SEMGp/CFEW+nmKmW7DUvvNDaBi
	JLGe8+y2aHg5REka0WhYegtk=
X-Google-Smtp-Source: AGHT+IF8U9aFuvgybHAns+BSiaqZ/+CjA5sBe4WvlLdR4faa+ocFyZhcYRT82b5ZorzzOtUHEBT2UQ==
X-Received: by 2002:a05:6000:430c:b0:3e9:d34c:17a0 with SMTP id ffacd0b85a97d-3e9d34c1a24mr3494142f8f.34.1757927413116;
        Mon, 15 Sep 2025 02:10:13 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:7ea7:8025:6711:b617])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e04cf2870sm90201145e9.1.2025.09.15.02.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 02:10:12 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] gpio: nomadik: fix the debugfs helper stub
Date: Mon, 15 Sep 2025 11:10:07 +0200
Message-ID: <20250915091007.28438-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Commit ddeb66d2cb10 ("gpio: nomadik: don't print out global GPIO numbers
in debugfs callbacks") failed to also update the stub of the debugfs
helper for !CONFIG_DEBUG_FS. Fix the resulting build failure.

Fixes: ddeb66d2cb10 ("gpio: nomadik: don't print out global GPIO numbers in debugfs callbacks")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202509132232.12viPUPB-lkp@intel.com/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/linux/gpio/gpio-nomadik.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/gpio/gpio-nomadik.h b/include/linux/gpio/gpio-nomadik.h
index 7ba53b499e16..592a774a53cd 100644
--- a/include/linux/gpio/gpio-nomadik.h
+++ b/include/linux/gpio/gpio-nomadik.h
@@ -268,8 +268,7 @@ void nmk_gpio_dbg_show_one(struct seq_file *s, struct pinctrl_dev *pctldev,
 static inline void nmk_gpio_dbg_show_one(struct seq_file *s,
 					 struct pinctrl_dev *pctldev,
 					 struct gpio_chip *chip,
-					 unsigned int offset,
-					 unsigned int gpio)
+					 unsigned int offset)
 {
 }
 
-- 
2.48.1


