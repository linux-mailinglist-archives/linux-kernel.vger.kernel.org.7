Return-Path: <linux-kernel+bounces-784424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1586AB33B9B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B62D07AFAB8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AA82D0C8E;
	Mon, 25 Aug 2025 09:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="EXKoCZKI"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF6C2C21F7
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756115333; cv=none; b=IVMy1qgJgWLUHBjP78SOOs4w5olS+0dGC1ulWNthY2C03Jl3QbRXMoggf93gnn5Q39j3jpEnDP+soFbE1eCZ4mo+FHnvypx+ZteO0lb+OI0Gs0k5hUzJ2QwQ6bFPzDtjya+CuMkdlvqJm6atJ486g+tokpTjVuDm0Bogylit+mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756115333; c=relaxed/simple;
	bh=gzJkrxl2GSQBg3wbrfEpmXDR3TtQwTcP3zezkl/FLP4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bzNSWZhzlFULAr5e1UaSIU1J/m1RS3siwj/yDSL4Gg0yT01Ux/yRyGW9TftD6yZzYNMv2pCADW0D8CAbYaTg1ah3STT0dypmsH2y2nq/j+i6QUpzoaGUh9ovSl0qvpKHnkh8hcU9OxqHwHMik5qTyXmmEGenWruYUksnmP/3Sqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=EXKoCZKI; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3c7edd71bbfso1627111f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 02:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756115330; x=1756720130; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WLr2Qm3e7qPPrbuy9EzFZ4qGFX2Jg5btesNxtQvmJvw=;
        b=EXKoCZKIw7kyRen2W3ath8vrop3/yY6Wrgd3cbp7vPo+zOkGK4Xhpu7obldv06ONZ1
         tMTuE8vD/baKOdGTcHliyzweonnkWnISDDT8uUiEm8GyoGJ/T2DDT6Zh/qip1W7MAuUX
         q41EpkIMtEaO7kc1EOrD0yuLw9r1z/WmD2WHIHtfVKspy5mBv+rEcoR8CQoLD3liT4FO
         uphK4u9SL3132i1+tmWZpp0VyavnGbW/6hJn/khkC5XJ1nYe9jgi3qlgaLDTWV4nSi8k
         chsFIHLCZK3JEwcq91P54lCvTggwPg0DHYzRGc2pIjqfQ8k8bEiPem1R7mGQ/SGMLizu
         iO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756115330; x=1756720130;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WLr2Qm3e7qPPrbuy9EzFZ4qGFX2Jg5btesNxtQvmJvw=;
        b=Dfw6EDpLoBn5QL8WAQsW9j8ULiaz5lGRbHouPewF/mKZYImxUJKXyWhRwN27P5wgqS
         WLzQt/qm2C214tCW0MrwPj6C5bpTrfj+5J4spyasaOBWFkw/+A1LQKf1vTUlLuWOA2mc
         pTgttXJIgvBtcgSMM//15JmqFi4/IF1iIml1/NrPejSFSS18tbR/GsdBn0LevEaAYuvO
         AYQn1gKe05IrOGmDsidKQk740UhfmccQ8PKtNxe8+tOfBn0Ks9lmQeXOahFqS98Mkpxr
         k1GSjL4affhaJ1+bmBtV6wHCAF0fvOMg1YH+W0l7m9ddqPvVM62GDz2xTr0gcNNJoTQQ
         tCwg==
X-Forwarded-Encrypted: i=1; AJvYcCVknZ1SRY3v0VF5SediQ2xkyatYDYIYXcypLHAf5otsiWPYpMD2gOhnBjWgrDqEre5sJrV3fs46+uTYoG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9qWc3jRaVaA+QwkR8O+tbrWgGOkw7UYi3wnK1YoyJihio/AYv
	32NJPeqwCEqa+FbC46hfdsPqASihDpiSw86KPW2Np+N70v8+0YNoSSSMo4ZtoEcPdBw=
X-Gm-Gg: ASbGncuDm10iyPnL4FlUz02P/X9qFzqghKuGESKF7G+ZaRfM7Sv+qzzJchi2lnS3e0e
	mNc+UIbFXnrw1Rdl9xJNwWZ/kVPziAgwB5Rpf0HbSse3wKoM4ooqeb6ALRTmLURL3VGfM6ZFMAP
	A2g2Pf6CktmxoaNj6Jkn+4oZ5q6p9s5qkJrLIU+lIzCMdoMKTCvTDapVMTeshWxZ4LCZMK5w3Fi
	r7GNzrQgWPSabIkAiulJYYF0sxmL+XI7gyMQndFVqyb7Dxfu/8HM8MwpfXms9bEdWaaVWvVecTS
	alsXZiH+leSJXbfoi0PkoyJLqjWDLkaUB6853keP7N/fvj1imm2FzU63Y/rWL/7dQDGZCKQ2cXR
	BI+oimqM2UZUHuj2EhukR76N4kzAep5Eb8emyp0E=
X-Google-Smtp-Source: AGHT+IHZd9byCiRM+Fg3ebBCZ00/QdcAygBb7Xpi8Rv6gpZTPdJa0i7D+jm5xfmQtyut3EDPIP5xHQ==
X-Received: by 2002:a05:6000:400b:b0:3c9:8e80:da00 with SMTP id ffacd0b85a97d-3c98e80ddd9mr1550445f8f.19.1756115329536;
        Mon, 25 Aug 2025 02:48:49 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:ef52:fc8d:34ad:9bfe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711bb1e3asm10877449f8f.57.2025.08.25.02.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 02:48:49 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH RESEND 00/14] gpio: replace legacy bgpio_init() with its
 modernized alternative
Date: Mon, 25 Aug 2025 11:48:41 +0200
Message-Id: <20250825-gpio-mmio-gpio-conv-v1-0-356b4b1d5110@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHkxrGgC/22NPQ+DIBCG/4q5uTSAH2inDnXt0I6NAwHUSxQMN
 KSN8b+XMHe53PO+ued2CMajCXApdvAmYkBnE7BTAWqWdjIEdWLglNdU8JZMGzqyrmnkTTkbScP
 LmglV6lFUkC43b0b8ZOsLHv2zv99gSPmM4e38Nz+LLLfZ2zL+1xsZoURKVTHd1E0nuuuCVnp3d
 n6C4TiOH+RcyLq/AAAA
X-Change-ID: 20250728-gpio-mmio-gpio-conv-623517c3df74
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Yinbo Zhu <zhuyinbo@loongson.cn>, 
 Hoan Tran <hoan@os.amperecomputing.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, Yang Shen <shenyang39@huawei.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1908;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=gzJkrxl2GSQBg3wbrfEpmXDR3TtQwTcP3zezkl/FLP4=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBorDF95fgkfgqjH/0HnaqX+iNA0RpmNhytZ0in+
 thiLMlRL0GJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaKwxfQAKCRARpy6gFHHX
 crJvEACx7TpNiV+8iWSToemqO/HsyfJRu7ALXCsYmREIXqiOBwMSCkC8cHfvU9PKo7uuDh91jFD
 tEcgr3HLkBOcKlNKArUXIcZkZ/LCfTDZ1xTYedJYiXmvRsVJ1hDiMCH3YScP802egjAoOHgdL3T
 z4GAftbqtWxkWYhLej+VR6Nl8tLxojPoaIPSLVz8SUjMIDfXjKjD9wfdHvqseG7qXrrPXT3Mouu
 fb82RNO1KaXIwLkTfEfpBZ+GRsA8TgjR/o68CKLK0Ai4TSQMrf6OmjnSTZuer26m2lHOF7oTx5O
 kAwO8fghfAKJQpvCGtlZQcSUya3pmK3IVfNZJh2+vH+S6ZFmyH4v7TsJ49oupzujYOBSRtM/aUG
 lSsZzVR/hXcWmO6kEib62AWtfEq/+7YTiFqfNp2PchJ6lkE8AIAob0Y+MDIEbnwzFLAcW/gP/fN
 63vv8TZsfPaI0nydFNRLbBXfnLE01ZTlHlZrbOh1NflS4H9/bDAp2xdmvuL+e0gMdQ/bop4/eOE
 VT+zjPa1SoNmacXZB8/kpbCBJoKrtQiOPiexSyni4heDxwJfuVwWHA2RrTwOLSISv2/p/GSJIBJ
 VqPR09ARTV7SJy/L9XZ+bpH6rL6lMBFFpgh08eM5W6h2EGBTD7muEuGrf5RgI/8iUQw8rHX6lMX
 jbsarJ4Pztr8qGQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

Resending due to some patches missing in lore.

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


