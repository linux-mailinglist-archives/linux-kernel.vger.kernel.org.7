Return-Path: <linux-kernel+bounces-800820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A60B43C7F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 480B77AF85D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523EF2FF14A;
	Thu,  4 Sep 2025 13:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="FIvXTskV"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9E32FF64F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 13:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756991121; cv=none; b=dl1tNmCsG+dxMd9iogCw+L/NCwRtZFu2Qvn5MqqnNzWOqiX3yHJayzWMXLwNLD7jB48+nQln6hQhf5CQ968WTMpvQcOfWKeYYpQZUK9dKwOY8VwJGpWgrgdS/4ubRRGyXsmiywItD6TOoUEa5ki5F/SJj0WLXAAG2y4A4jS2tdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756991121; c=relaxed/simple;
	bh=iGB1WfaDiptXMv56qqe3zTv/ryomvTxp0VuyGWvdQo0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZZsk81OWbEpvSgOGGHA5dJw/2E23ZOgj9Qj4eBXgZbEQ+TcNskqd1gACQT6h0yp4BCUTJb9713JxuBB9MT+uKBDfHAhO3QvBFGHv6fl6noeWKYnsSulx/qZ7rSJVCO6LBei98bjxa20tQwhh4JqZJG2QESPe8VtuS5vir+gkdW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=FIvXTskV; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45cb5e1adf7so6781085e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 06:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756991118; x=1757595918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wYkWbCvyzrXYcRtGccULZYx96qOTZhMo/W/nEtVwCNo=;
        b=FIvXTskVmsD3bYGSStxh7dmwjXmzJzJOD7rvdFpkZ9speFRoivWeRoHg8VpnG3Kl4f
         vw+8slms2JUzKJ++9nApQ8yrFOSmdyrFf5CDcD9SYpC51ZemHhAm0HQ7xpTmLe2dx0bW
         VTBaTtGbVZqxmQoD07rat4S54K6bnmyQjFv+uyJSBIyzArynV7S3g2F3Wj3xOiCfTbzt
         NTHUdgpxl7NRSsSvU9EdZ0+uTeALT67aEeg/cVZDtsd9VukXr9fIMEogJ2OVqUEv+/tf
         gYTZqr5ONUu/4NqH5giPao81lnZ9Jav/wPj4dCfug9FkJf1YFj4x5FJ2Wq5gC1xDVt41
         /mZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756991118; x=1757595918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wYkWbCvyzrXYcRtGccULZYx96qOTZhMo/W/nEtVwCNo=;
        b=C00v1Kip9YHZyMfA5kF5JabaLm1OLnCykgqnZMWaQIF2DcbfmaqVHm7SPwcZoJBlty
         +eIC6I5cJCmj1VSSZjA0av+R+QoQz/+JroL7EENYLh7RLv84uHjNq9/sXefP5JF9TXul
         6fvocpAVL1Iknxizh6F3CfGRxDRHeylNjpukZ1XrHYksiiZMAYrdDncy450T775Ikcqr
         VqoWGz05/9Xu8EFIpMAn/qGZhTChVTM9Ok6/snkFbo/M7VaVECnaj7Br2KylEWBoPwYf
         M7/tmAYdd+xldGdK/WN4tKG91SodiMk+zop4r3/8zlhgbY800s5iMPAjd/WWx9MpevCj
         4PmQ==
X-Gm-Message-State: AOJu0YywMiej9xb5S2ED4NTMLeX7fVZKkfefdQOXOmbHEk8kHNbuq1LU
	eUji0da35kiJ003t6gKiK9wQSM3FAej62WAIUXdRH+Vfip+aCL288pJRUusE0HSLhGo=
X-Gm-Gg: ASbGncuUYQu734sQyao2LyZY3LDUMkdvqsKu6lfHehUaphGoW79j/tW21f1b2eGt7K/
	NeBycShZlJfImF/bbYvKdPOzBmt/fC+COJAwVm/kPIZEoRwPM4fA6fdJxE5Y/L/ayf2S/7X83UA
	IYHyVyiNJ+d4x449CclV1K/omZGhrTdfpDQ5EjB7cDl6HA94okZrIJEJlANrXAHQaH9UhRzCrsb
	OZ85o8IU9ez2LhzXq5R4KBJ2KoU9RgA6hBOyD2x0mcOATnoJudZH3eCu9NxBvWixv1elzHCDppe
	aqH0H2GzYcqmNM+psfw2biBcjdZjdFWofFpCeE/iN/MUmix4zLTnVwp14XcC5g+1C19rn49Y5Zu
	Sk83BdJAEXHPgnUSCiSP6zFW4Fmbvn8SE0w==
X-Google-Smtp-Source: AGHT+IGeiyinvVoDIY4X2T0SG++4d/2SLzsdQmO+tL6RfTknWDo1frGnFfVgbdD6pRFAo9bc8mLUsQ==
X-Received: by 2002:a05:600c:190f:b0:45b:8939:8b03 with SMTP id 5b1f17b1804b1-45b89398d27mr126045955e9.27.1756991118284;
        Thu, 04 Sep 2025 06:05:18 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6e82:a4aa:49e0:a7d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b93fae643sm131185925e9.3.2025.09.04.06.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 06:05:17 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Lee Jones <lee@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] Immutable branch between the MFD and GPIO trees for v6.18-rc1
Date: Thu,  4 Sep 2025 15:05:16 +0200
Message-ID: <20250904130516.72266-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Lee,

Please pull the following MFD changes that depend on commits I already
have in the GPIO tree for the next merge window.

Thanks,
Bartosz

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio/mfd-stmpe-for-v6.18-rc1

for you to fetch changes up to df6a44003953fb23ad67f82d299e439e7ff7150a:

  mfd: stmpe: Allow building as module (2025-09-04 15:00:53 +0200)

----------------------------------------------------------------
Immutable branch between the MFD and GPIO trees for v6.18-rc1

Allow building the MFD STMPE driver as module.

----------------------------------------------------------------
Alexander Stein (1):
      mfd: stmpe: Allow building as module

 drivers/mfd/Kconfig | 10 +++++-----
 drivers/mfd/stmpe.c |  6 ++++++
 2 files changed, 11 insertions(+), 5 deletions(-)

