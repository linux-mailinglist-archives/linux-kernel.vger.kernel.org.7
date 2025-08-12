Return-Path: <linux-kernel+bounces-764503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66610B223DA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520D31B6251F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA5C2EACFF;
	Tue, 12 Aug 2025 09:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="aIypiGie"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DCF2EACEF
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754992686; cv=none; b=tdFq7+3fcT28Z1WyLh2vxA506vdMJulfMpvXlWmNliWuDp4PoDb+ZLS2c/BiPDHFK5X3REypqn0/aESBtBkAqT8xpUenYXf2R3yrn9upTWoI1/Ep7XPseCXZcmhFsIeLgw+WMQnP0rcJoywyjxhGrRV5mZnmuIhEROdiplhXda4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754992686; c=relaxed/simple;
	bh=ufruTN/rsMjpZogkg1bX/2fwukSGxpr2NY77MLQ1ScE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SZMTI8rZYJKqvl4+aZQDMjwcnPz4DGwFlAwwq5QA4NBmgpFqYS6xkDWYrUy09FiMULgKnv+kXPnoBZ8oqnc2cXAWEuRLfPZmA3pKFESuKfDr7MHesyLnI35D4MGnn5JDHRTbrB5gLV276lKol89OsmjMsp4/oIMWf1yviufqlws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=aIypiGie; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b792b0b829so5114050f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1754992683; x=1755597483; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eptxpJ0Yx0wWZW9/nNNpkoZdSzIonCkt4KahodklTGQ=;
        b=aIypiGieyva8FJCeAsFN4XAlCXUh4wkB2iaPYXnm0OBuLoFu7EexBVhGypowFH2iMx
         K16m5h3B/Bhe9TwX2SOH7f7YgXFPkTGQK9Hde/s7AhBw/awTIrFOOgmG9Kkw9rF+M3oW
         DEWJQVdvGh9hL2lo73XrAZt6rGMsrikBL1h3uYbHWhrrynQA+SIQV6t/+XoZqHg1Bit5
         thDD0q2/jcv4DV2H9oJnVa4pQICZHP5nkoAgYghi+WbKnoVtGuxfGdRmX+p92YAjwPt9
         +437uiRGZHTT40JF1QKlmEnxNUsRkCSKILugM8Fnqe4v5J9C4H40qauwxROXpRHUFMpP
         YuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754992683; x=1755597483;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eptxpJ0Yx0wWZW9/nNNpkoZdSzIonCkt4KahodklTGQ=;
        b=D0rAb2IvzM7PbpMe+87chZfUGCdOsGQHZnRWXeAkW7gt3RVL/H3SY4kJiwmWfs4EDu
         1irsC+tio9wW5VZTCMGtbZYE5fd4e0roZSqXrQPy1C3da7kkB6a7i2L3GJQi3RBYcb/c
         DVVxfbMNtbzdR9PXxmoU009+UuXAtjxKmw1Qsyz6MkZxB5cyy0tx5jgcFLzlGPC+pQs+
         /WY8ox45uriHItDJT/5A2gOAGkTu0Dg/99MXaewDk8VVnszhl8yb1cK/aGGpPXv2Tz1f
         VwvoholljG8WND5+i1GOCTRGAGMqgEGq6e5qcRRYChMgR3fsc6mQKx7wuqHlLKJG7D/+
         Q0Mg==
X-Forwarded-Encrypted: i=1; AJvYcCV3KXUD31zinEKeurC3lCpTpypPJ/ACWKpGOKpPseC97OlfhsdHZ2KiQp9hwEJ8mIH7N3s8qeNFiHdTT9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ0nLfYNWBKmLMnVE03jkVjYLy32+0ZWT7stY8U3975kpcK31D
	uwjV4/AzWDg41+z0QqU2eKMYejtYPu+N3Q6dgdx0l+esO/L+2a3i1j0NUx6e0znwj3I=
X-Gm-Gg: ASbGncuuJ7mhgyYSGClY9UUt+KVXWRdZHGixVeHMMu90DjmfFe6a7hyLqvH5XgJ56No
	Rm85ZcbLx8xx9cxMfRIz4/OWC6LkeRndpAAdf0YbgIxlZf23amV1UHAvYAsy5BdmVbrM9qdNLMW
	2D+sk8pEhgwVNfK+gN9PHxFtdOPLfp+16qL9W+7gQdRBQj4UDCroxRIwuU5R42TnLicUZ+iaFkE
	OuOcjKQf+bKlCuQN5/XpRkYMO1y6rjYgaoJnHWPWwRuh015qxO+IRXrBq92FXKDItBmPFnr/eHE
	+pQAxRv5oS9GctUl/iLR3OCnFdH+ErfknkG1eCIKAu3xfUPxHvfeI9rFx4C+5u8T61WfSxhcalW
	H/TMmGJmJ3X4A3CHDqAuIviHq
X-Google-Smtp-Source: AGHT+IFRKMOjNEq/svqoqO1+OAGml8rvBrYHa5cXxdGYNGhaStnGkXEy6t37GrH8g1J/ZYMdLyL3ZA==
X-Received: by 2002:a5d:64c4:0:b0:3b4:9721:2b13 with SMTP id ffacd0b85a97d-3b900b4efebmr12112320f8f.14.1754992683274;
        Tue, 12 Aug 2025 02:58:03 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:16c8:50:27fe:4d94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e0b2d2fasm33098977f8f.50.2025.08.12.02.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:58:01 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH RESEND 00/14] gpio: replace legacy bgpio_init() with its
 modernized alternative
Date: Tue, 12 Aug 2025 11:57:55 +0200
Message-Id: <20250812-gpio-mmio-gpio-conv-v1-0-8492f4a4c1e4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACMQm2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcyML3fSCzHzd3FwgAWYl5+eV6ZoZGZsamicbp6SZmygBdRYUpaZlVoB
 NjVYKcg129XNRiq2tBQA5H9IJbQAAAA==
X-Change-ID: 20250728-gpio-mmio-gpio-conv-623517c3df74
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Yinbo Zhu <zhuyinbo@loongson.cn>, 
 Hoan Tran <hoan@os.amperecomputing.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, Yang Shen <shenyang39@huawei.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1929;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=ufruTN/rsMjpZogkg1bX/2fwukSGxpr2NY77MLQ1ScE=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBomxAmNTPMkGkiqt/PmqfVx7KF0BvJK3jOlcR/s
 vzc2p9DeYiJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaJsQJgAKCRARpy6gFHHX
 co0oD/wJyJDy/+JHZq/BZAtMequ9A3BorEjOl5uF842dcksIJVorgAYhwAIdgyM1t6tLqbN/Pqo
 8gll31b8WC+059WBQiqYEwE3XIUwtEb0kSC6m2UINtPcx7pb2msmdkElhNZpzyog4is7nUgvK9Z
 /8Xa3ixR3x8mkElgH+q84PpjTnI/9fXoSpWEa2N6wFXVdoVuvQfNKMvoMvYXdql65AKRtdxzTuG
 gJ/C9HIhds0rws0a8My83avs8FUo3/LwM+e4NGO/ZLYLBf5/76s6YPA5Rs4M6qw2x2jJ82qmosn
 8ULu6iR7/ToDEfw9GW1V2DSS139Gn7b+pK0iNN2UyyogWmCbjo60shBX4NIebTHD/p12iuYcvJs
 CEZb+v8ql305dmJddhiBFYTTdvfZd+dw8zXYPKnSWRENswgcfpeTt2vVCV2wNhECOAvoFJdOUzc
 0y7aIb5+/anNL1UVq/7NLZvT+6l3GWLMK6ow53Sr01ZJnYTlbKf+ykf++krTuUckbEXPeCP7RNg
 grg4xG0ooTcJluVld7DSsvC96hyNOaeAbmo6ADxUHLAehGo5fdWfD7oTZ6cwGfduH+tycpsq3Q8
 pz4ZRCHiiUkd77Ny9k/pQ6eHVO9wW0GaPPAoqE5TbW2CuE9BRZ9JTVOGpO6UYRdV42m7BEgdir9
 /jFfL/c5aovbNvQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

I hit a network error when sending for the first one, retrying now.

This is the first round of GPIO driver conversions to using the
modernized variant of the gpio-mmio API.

While at it: sprinkle in some additional tweaks and refactoring.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Bartosz Golaszewski (14):
      gpio: generic: provide to_gpio_generic_chip()
      gpio: generic: provide helpers for reading and writing registers
      gpio: hisi: use the BGPIOF_UNREADABLE_REG_DIR flag
      gpio: ts4800: remove the unnecessary call to platform_set_drvdata()
      gpio: ts4800: use generic device properties
      gpio: ts4800: use dev_err_probe()
      gpio: ts4800: use new generic GPIO chip API
      gpio: loongson-64bit: use new generic GPIO chip API
      gpio: dwapb: use new generic GPIO chip API
      gpio: amdpt: use new generic GPIO chip API
      gpio: rda: use new generic GPIO chip API
      gpio: grgpio: use new generic GPIO chip API
      gpio: mpc8xxx: use new generic GPIO chip API
      gpio: ge: use new generic GPIO chip API

 drivers/gpio/gpio-amdpt.c          |  44 +++++-----
 drivers/gpio/gpio-dwapb.c          | 160 ++++++++++++++++++++-----------------
 drivers/gpio/gpio-ge.c             |  25 ++++--
 drivers/gpio/gpio-grgpio.c         |  87 ++++++++++----------
 drivers/gpio/gpio-hisi.c           |   3 +-
 drivers/gpio/gpio-loongson-64bit.c |  42 +++++-----
 drivers/gpio/gpio-mpc8xxx.c        | 102 +++++++++++++----------
 drivers/gpio/gpio-rda.c            |  35 ++++----
 drivers/gpio/gpio-ts4800.c         |  39 ++++-----
 include/linux/gpio/generic.h       |  37 +++++++++
 10 files changed, 337 insertions(+), 237 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250728-gpio-mmio-gpio-conv-623517c3df74

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


