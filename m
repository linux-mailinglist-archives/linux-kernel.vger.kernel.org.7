Return-Path: <linux-kernel+bounces-778833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD573B2EBC4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 834465C6DDD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C30221D96;
	Thu, 21 Aug 2025 03:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="zDe4jXS2"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF2F18C933
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755746125; cv=none; b=EiDXmmG9iLvahIdmB628GCvYH1goJaqaFn37q/wbM+kSo4mWHieeo1olqtWXVOaPUOaDW2Jp1yQWqMwEeOK8xyOjtCOvqgWSCWgkrIimDtgmM/tVzEB7NC9bmrwRtlVHuATB4DnRb9ZMqBqYbKOlGOiqvWKYnJR1pPIS9BOP5wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755746125; c=relaxed/simple;
	bh=vg1GOk0MUyhUYTWNWXxSXx/yMJDlP+wEjm+cU6WTJ9U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nS/6X6o+wUbtmKpmJ7hC/gIqNZLrYyfcoXvVcnyJ4R/gbWwHLyZwo0CVuVRc61GaBSNCrsjmRkKPhipEDlZJ8wUJxB2UBjU5x3bMHT0paDCEgKLhQnSzFZf6R/crF3zxEoK4qqIjlab/Wy2PMDRIskCS/ThO+M0w44ZI0ws1esc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=zDe4jXS2; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b47052620a6so1183266a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 20:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1755746123; x=1756350923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fM9jqXVt0YyM2f04tCncYCm9RoZvYA/H+kQtbuzkBRw=;
        b=zDe4jXS2XvJmeVoGsN/phc9oRmMc8GHSNxCn0hj0CWorGwEJdRMXuzPp+Kw2Z3ZvFv
         vny/WiAP1g0qRllP4/mo6uBnt8jzwYmcl93JkqKazKybZoCvyJnBsIfOzmx2dPQSm3NP
         rkMYIYXvYgMtCf7ppIbQomRhalc4gTf7ipx+0tKpDd7Tyj3hWTRBreqe+MLz/y7Y3l7j
         mDSu4c2Ercm31uS7qyfplAClbiWSkmbDhARp2O2C81E3L2tUanD8zv+P2+o8Si56xQC4
         Zjf9Mz5XmPZbLPAokeNKYMGdLVahVbPqHiPb74yMO9UEcVTE3iM7nG66A9Y0I+XSdGDw
         ntpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755746123; x=1756350923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fM9jqXVt0YyM2f04tCncYCm9RoZvYA/H+kQtbuzkBRw=;
        b=dBdEaGB+Z4VLngJJFS70Sx49c/kgcj5RL5w+5u4nGJvWswoXua1aLFX00Y3n7/KU5U
         aWu6Zl/7w1JfUMs9KVV+zquaw22QamFIrRqMUU7uci6hcaq9H3s/7mLri2KchtFcz1S5
         ZX/BCiTvVQ+ZyIs2q/rzVKjlQ8s/buNNsFRjaUHy3ZzGHrfd3nJmgQaTrVuf1l0cTIVY
         VgU/CNOW9cuG+GWdMqnp340D40LhIQn/JIGWtibtYVL1j63qtOcx6cgBQ6/A/hfillun
         1DR/9KRUHb4uBtbsTd3jMlNpOBuDR3/tpdUut9PXEyUCCWK0u3wFN59XR9B6s9hlh/4z
         UJgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIA4srWLQ/oUQ0ABn5XBg5Q/BrXFVWJOEVmKdO0TcHZ3Dma7qE63K8m22pA8lcdUZOoXbvleigZ8eNK0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHdOqxUWVyccLLm1i7Hr0kNi03ZAi0fFuvIZ9lfJep6ZFxCukr
	mnf2rssmCmeIXwVqYG9JwUMgZHEqesZ/5+P1NyHxlafOYd2YABj/WQPns6rDwJpAk3aTWVALQW4
	pcJYZ
X-Gm-Gg: ASbGnct34Xd4CCcXAorxMYn4Ge6ZmUWprpcdwzW19K7WuFB3cNGnr4WOa9r1Q+nMY1P
	ZOZhQJAnvxQ7ZRx3Qapf2qQg+6/pCb2fL5izve1f3B2G+d4ulI1dOaHzTfxorXqYQ2RjUNVmFzH
	6BeUM29ZL+pZ9UGjsRC69RC7ellNiAx9kgHXtcGpBy+8nuhLalcQlYRW+njbAHwLJjBdMNY4Ea4
	o3Vtk48cRp2mvXgDi0YwJvleKETosWzz05PUtdLsG0sVBQHbCZbFOt8UOcrZqMYoFSiBhjOu2i/
	2GyoASJ1yKHo0e0mzD+qegoLsQOEBA0WvMU/yjw52zJ0zfOUEh2U9h+6FRE6RrWSpXKU2SSNa+w
	YLbBsvbkIZB0mngb4txEIxWbQtuBxOsvGoggJ8mz9Cif5tO8N4Cvc0FGxdhMD5n8m9inNuQ==
X-Google-Smtp-Source: AGHT+IGE4HVZWfohQCAFtw4L9SUGaGz24S3ewHYjLJieNJ9qHAVoWPYrUsOmf5tjq0RXHgkSWcVwOA==
X-Received: by 2002:a17:902:cece:b0:244:9912:8353 with SMTP id d9443c01a7336-24606158c4emr9353775ad.6.1755746122965;
        Wed, 20 Aug 2025 20:15:22 -0700 (PDT)
Received: from dgp100339560-01.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed51b3d3sm40285415ad.147.2025.08.20.20.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 20:15:22 -0700 (PDT)
From: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dianders@chromium.org,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
Subject: [PATCH v2 0/2] Add tc3408 bindings and timing
Date: Thu, 21 Aug 2025 11:15:12 +0800
Message-Id: <20250821031514.49497-1-yelangyan@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tc3408 touch screen chip same as Elan eKTH6915 controller
has a reset gpio. The difference is that they have different
post_power_delay_ms.

According to the Parade TC3408 datasheet, the reset pin requires a
pull-down duration longer than 10 ms, therefore post_power_delay_ms
is set to 10. In addition, the chipset requires an initialization
time greater than 300 ms after reset, so post_gpio_reset_on_delay_ms
is configured as 300.

Changes in v3:
- PATCH 2/2: Corrected post_gpio_reset_on_delay_ms: 100 -> 300
- PATCH 2/2: Dropped Reviewed-by tag from Douglas Anderson since code changed
- Link to v2: https://lore.kernel.org/all/20250820122520.3356738-1-yelangyan@huaqin.corp-partner.google.com/

Changes in v2:
- PATCH 1/2: Drop redundant "bindings for" from subject
- PATCH 1/2: Improve description (describe hardware instead of bindings)
- PATCH 1/2: Drop "panel: true" property
- PATCH 1/2: Drop redundant description for reset-gpios
- PATCH 1/2: Use unevaluatedProperties: false instead of additionalProperties
- Link to v1: https://lore.kernel.org/all/20250819034852.1230264-1-yelangyan@huaqin.corp-partner.google.com/

Langyan Ye (2):
  dt-bindings: input: Add Parade TC3408 touchscreen controller
  HID: i2c-hid: elan: Add parade-tc3408 timing

 .../bindings/input/parade,tc3408.yaml         | 68 +++++++++++++++++++
 drivers/hid/i2c-hid/i2c-hid-of-elan.c         |  8 +++
 2 files changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/parade,tc3408.yaml

-- 
2.34.1


