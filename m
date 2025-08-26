Return-Path: <linux-kernel+bounces-786378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8FDB3590D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B3B716FAD8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2988D313537;
	Tue, 26 Aug 2025 09:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="B6FlBUV/"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874CA2FC87E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200915; cv=none; b=uLd/NGMc+X46hlsiFpdWWPpRYFIljAHtWsVYtm26EBIa6+eHq+hguOzbMo9AdgFP20jsUWDYzhwMkP2KiRavEpiHQPLxRFv6QR4fo+t3c/TbZKL5xu3yrMVOBEFtFM0LZ4piMjsPUDLOJkbVLw+w/7mNlzwGGOOOC8ej83Zsn6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200915; c=relaxed/simple;
	bh=Q4ut4up6GX/HdckreW0R8OaX0WDAeyY5hviNTW/p74Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=l4OZ9dyAlnxDGV0sffAxBHprsZp8NrjyTicXrwzXGdyRB1HckTJMXVQnT7z9h8x9kKgbgKN1lDvfRUiAXfamYUkyyknKByILUDkfGTglCU/fxMfFqs7ygiwDI5n1b9Wi1KByVL1n3Hf97AtfYb07jbI0Cr9ZKiuB/HolqSv/EoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=B6FlBUV/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a1b0c52f3so32714895e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756200912; x=1756805712; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hkJG+WUZSpEwjO7HzoCtPjyyNbjxdrmMzotvlEggg7g=;
        b=B6FlBUV/9v0CVEYfAfwF86r4mvRoXMjxtNRqwwGqFtZ7frTaU+jKwqWAcz8RZEFjUM
         UUo1Ao9tZixW007NvfqsiiT3q5LqR8CkW7/1wbKWMo82Ftk1ad3noF2zQ5eGwxmBzVPF
         b5JOTQx66ZMlLJUD4r1+qp8c9/B4IT7YintfeAt6uBSuIN3qg1fKLPUYqFpt4obU4Meg
         IcSsLx6ixNhVzqX61EK+43k29mrH8chxUvWLySTvRMmiSh1zTPQmzYAT1bQY4c/Coes0
         vXTGIXNhjE16QQCnm3DRP9kWqVmBxpr9k9erQIyOiRoxXBW8/aw3+QM3ntFKiTqi+t4m
         DkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756200912; x=1756805712;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hkJG+WUZSpEwjO7HzoCtPjyyNbjxdrmMzotvlEggg7g=;
        b=VRi8rrRL4f+iKBpz6jgsh8od60jKUAHhw1qIwjPOAX9QwPFpSKChcnjWFOpy1cyW1U
         0wUsE4+Q7zAb2/+dlJyqD9LuEJWVrd2BW/pCFxv9ysx8mG6ZjkzF8+//HQeR/o0kvqNg
         sygZO8qN7AYu6yRN1SpFLMtmioyZi4ToAT9TSZ/SfKo6svesxjzhGKKod5ZAqGsSw9Qw
         m4AZZzt2OeCybcCOCOeKR+wSpUx8maBsY9Vc222hxCP1bTqAw0lgbiubR3P342+WVOOb
         oRRIOYikmT0cY6VLShrPrQA3XYcZkz3uoX7T2SniTcMaRR4cTfR4X3qQiy1Fi9HnitSa
         t8gQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaEwsxNYtvTs/6w/o+pyAguuvRLnX+He8ezp1jqfWQCx/5mSPApTCBMenvahDzeR4B3QgkvI2+Eemrwqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlSZ8avmeND5RoCN99vUFjqNyy79SiKgei9A5DxmJu8ZgFMZlJ
	oTW204crVk9y7C9PZ9LLigVjEKKFHWh9kXVIltpjooqwxL7Y5FWiEYtRTsk5rPaLjjU=
X-Gm-Gg: ASbGnctZ1NOdyXKjU/SBPmfMNAXONgCv7dEftNLeLxoRsWKzMnaPormdG8feMpKW15o
	RUk8I4uz3WKKHiLPsg+m4LNlihfZs0ircogQYWj/JruxCaIgtVWcbEISqU8+5PlVYoNMtPn73K8
	+SrFr368jvP3QwQwKMlf45tqdxzCh2aukJM8lE453PmfqgvdBhkL/S1D9CHh9cjcJ8PSIWo/N2f
	2IeRA4DDTybaacStj+TIaMgbdhczY3tc+4152A3+kEGGnUpOAgHlv7CyQtJ6THwINm6ASb2xyNe
	7XK3FiLVy/qEhOQ0oRLV6KLeguqh72NvDEfugmx3MKaHZKqZtaP/viHFeqjOyyl8ltLzJXR/T2+
	RbENYpOcf3da1/1jbMUCt7U31LsE=
X-Google-Smtp-Source: AGHT+IH2xF7cWf9zPiJpCZDblnQIkHuRl4owRmxgCh3l1f0u4tvEtpqb3bPUkqR7KcRXy8joxsDAmg==
X-Received: by 2002:a05:600c:3b15:b0:458:c059:7db1 with SMTP id 5b1f17b1804b1-45b517d4580mr149020165e9.30.1756200911704;
        Tue, 26 Aug 2025 02:35:11 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:fed4:79fc:9440:6629])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c7117d5b10sm15308255f8f.47.2025.08.26.02.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 02:35:11 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 00/12] gpio: replace legacy bgpio_init() with its
 modernized alternative - part 2
Date: Tue, 26 Aug 2025 11:35:01 +0200
Message-Id: <20250826-gpio-mmio-gpio-conv-part2-v1-0-f67603e4b27e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMV/rWgC/x2MQQqAIBBFryKzbkClSLpKtLCcahapaEgg3T1p8
 /hv8V+FTIkpwyQqJCqcOfgmqhOwndYfhOyag5Z6kEZpPCIHvK6Gf23BF4w23RqlXQ31ZlSud9D
 +MdHOz9+el/f9ALS1ILVrAAAA
X-Change-ID: 20250812-gpio-mmio-gpio-conv-part2-0ab8e4871d4d
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Yang Shen <shenyang39@huawei.com>, 
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1645;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=Q4ut4up6GX/HdckreW0R8OaX0WDAeyY5hviNTW/p74Y=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBorX/IsQ61XrGh+TV0cTJdfuJwQ0IU2AzJI6U6B
 xODhnvRaf2JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaK1/yAAKCRARpy6gFHHX
 cmJuD/4s6vLLL4IJvlMcBRWt+fL3p/MdEMPyIgv+IS4S1jqjqxW26UsphEQIOFT4zd+2Ei6Qx4E
 bYgNLNqataNIqWb6AtcX8wjj3CWWIqrMTZD2ZXpw7rLb951R5Dotmo1R6kM58oDlTaNJFZjbg9n
 ChkAEyNlA5GRhB6foaz3+Do5OJTbItx/BFm0lH2dyCt0s/6WsRMwal4Iv66YCXtvOGUGiQtRnEP
 Jl0NjctXUHuT0bmeBEDxXiB9np1PybcUOTk1AhTTyvajEThwU8fCt+oaavXD+6mn4QIBRfnqyTl
 jYArmBFJBtDETk2cAIcyPpsRLaXJQfHPIXK+35E53tBd1AVBBWm9wpL/18OzvnFdcVibRnfb+dz
 DpPzPGdSpxkREQGdv1S4HNICQdTQ/FtrRdk0CEJluBKeMXcPSEI0yuhZMEORT20nSri9kTKJgAL
 BMa8VJSwoEoUkx2+GBgUcJYRyPlZ5d4vMM3eFjuiezT9WnyRp4/QLxWBVFxrBIdwvb30HB3FZ24
 WMbajv8vTcO7A4A+txRMVD1IoNqnjKQ5ZR0KDXSRml9ykbYzC8TKlOXRAEJte+Z96Yt5BWlfzIc
 5oHMXijNS4BrvrtEiPsnVbf7kA8XquJdZMs1dq7KwCkiXlLtRlhonbsjN9GGfNZBkyhVrchsZNd
 QX+14T53A7wjY2A==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

Here's another round of patches converting GPIO drivers to the
modernized generic GPIO chip API.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Bartosz Golaszewski (12):
      gpio: xgene-sb: use new generic GPIO chip API
      gpio: mxs: order includes alphabetically
      gpio: mxs: use new generic GPIO chip API
      gpio: mlxbf2: use dev_err_probe() where applicable
      gpio: mlxbf2: use new generic GPIO chip API
      gpio: xgs-iproc: use new generic GPIO chip API
      gpio: ftgpio010: order includes alphabetically
      gpio: ftgpio010: use new generic GPIO chip API
      gpio: realtek-otto: use new generic GPIO chip API
      gpio: hisi: use new generic GPIO chip API
      gpio: vf610: use new generic GPIO chip API
      gpio: visconti: use new generic GPIO chip API

 drivers/gpio/gpio-ftgpio010.c    | 48 +++++++++++++-----------
 drivers/gpio/gpio-hisi.c         | 46 +++++++++++++----------
 drivers/gpio/gpio-mlxbf2.c       | 81 ++++++++++++++++++----------------------
 drivers/gpio/gpio-mxs.c          | 31 +++++++++------
 drivers/gpio/gpio-realtek-otto.c | 41 +++++++++++---------
 drivers/gpio/gpio-vf610.c        | 27 +++++++++-----
 drivers/gpio/gpio-visconti.c     | 25 ++++++++-----
 drivers/gpio/gpio-xgene-sb.c     | 53 ++++++++++++++------------
 drivers/gpio/gpio-xgs-iproc.c    | 34 +++++++++--------
 9 files changed, 215 insertions(+), 171 deletions(-)
---
base-commit: d0630b758e593506126e8eda6c3d56097d1847c5
change-id: 20250812-gpio-mmio-gpio-conv-part2-0ab8e4871d4d

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


