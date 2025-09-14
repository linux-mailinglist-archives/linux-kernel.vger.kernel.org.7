Return-Path: <linux-kernel+bounces-815546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1545EB567FA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1563F3A3499
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 11:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC0311CA9;
	Sun, 14 Sep 2025 11:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgvYWpGq"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39E6524F
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 11:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757850304; cv=none; b=ZgJBr8kFS8FFNJ6t3ge+/ejLADDX2oJq4X/nP7WZmAWjyDDh5xkHYNxUb2aQcyHnWDhktQyxYUmNUHw0sBE9E0BbVNCReWCX4pMHljrlScVRsPP0VtgXu/kgXlCOV/VDa1gRBfEUQeVyx/XsiTsQnBkydWxZXu7NcqEaraYQtmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757850304; c=relaxed/simple;
	bh=fIdw23kCtB7mdE2ObsS2whaNsMI65r/FonqsAsCDIf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kM7c2Q8j05QxzBkUTTZ6GttH/xEEQf6gozGpvkpb8ch2ffO1WpkqmXPNWv0oLESY60avWRNSuPffaT7CqAJZgOk37Hh3do5/NwkS3FkoM/sP/9MBZdW6FQyKdqOBlFy7tCTV14JpDzPIuAS6yPhnIKVQ/ul0eW++UYgihBukshk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgvYWpGq; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3e7428c4cbdso2217806f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 04:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757850301; x=1758455101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zl9epDnVBDf5FGwQnol7WPxPj6t42uf2hUNcw7PBwX4=;
        b=SgvYWpGq43cB7t/JShNl/aLM3QH5u9bIB3pCoTaxzCbWGihOg5NeWk1sx5jlRRN2W/
         1hcEmxw8cjnqyQ82uXR5AJj8YkTgD4ASMagzuhe5BUsfgdxrIp9X15PGxBrGJnp5hfwU
         SJhad+5ot1AcgqYquRMtS/calSmiXLIiPxqxk8BCc1i1jBgXLO41azrxm3zhNLHGgt+f
         +m6snHE/CLDPCd7WBnG3bK/3Ur/bq3uLuXOnV6YxFHaQE3xuMTCkMFwcl571r5vYcTED
         8MwRQncNaxYJgNWro+1TzaoKmEQ1fVXgu8RMh9gmxp65xC4XpvaCN6gLrj91v3DPdxAI
         rhYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757850301; x=1758455101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zl9epDnVBDf5FGwQnol7WPxPj6t42uf2hUNcw7PBwX4=;
        b=sAj8U89O0Ysf8yQN4Zp4G4IhZoUIpBg+zkuK7Goyh9lrhzjFXH2e3617cmPr+r7WFn
         J/sROw69H2eZGpqNXgyUQu1KxYTEOykD57TtVVim/lWZnVvbMILS4zTnr5T7lU/JeGRF
         F7w+vwbIAP2y4ibtGJS6r5MQJkpYDqrjvTpwCjP5CHn2xs2oN6GBeq3y28j8JE86Jk+3
         dnVCFlDnmT9gf+SOrNnftBgMyjQaTQWaBsSTvtP2GE47e9BaWQCb0AbSMxRJWNgftiil
         A4/fcqXtCT3ezbp9htAqOXzYCbPkOQBZAxxOSvYrnvLESpjw+1QmgloIW7Z8qN92G9kC
         1DTg==
X-Forwarded-Encrypted: i=1; AJvYcCV2XkCjhSNGEv9X7z2ZhGcl0mNVaVgBrTrrRkQsU6vrHzYbIZgAOFPwIgriJWBrAJD3ar8JbT8iRC9XA2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLm7kANOBeZH/w4J+v+EuGgwJJv/1xNVobDNHi57snBibu2EZ6
	uWvuaAn/By+2hP/Oh+gaPpREMyXufbqNI4BzAWLZtwX4ylqRFfjvVeXD
X-Gm-Gg: ASbGncty69gQ0Oclq1oCmAsASFWzrnId2Kp6E23lBqr+fViIKay/UW0EnqrFgD3l9B1
	GFuPzz/hXJAz8gfpRsqNokZ22JYxwgdPn+ucvNKtvxR/dkYxUBRO6bwoWiM1zJI85dIuiNNRmP6
	FwX0yA5gh7TT5y6WL8v86F66frR4lhNGbERigJJnnwQqNVRDUffueN6UMrXqjP7YJ/rSjmKoOVX
	W6cB0cc+nbuqwFHb+TURP6erHgkIj/7o8r85a0KgbFDRtLXSC9E/hbUH5Dn7Ib6FaLa3wWX47q1
	2ggpInWBNQClhVIFe8k9ICDzgMPn8YvbaS9NASf6QFRxwk+fbNMXE4DYNZIde+J43LjaRexL6jU
	wMadVtXVooqq8qcgjAUlH7JQN11ubm8n4yXbEsTzQt6wgJSXdzDb4Db1skmokAgM8z4+1QZT43u
	J6N3MENI9k
X-Google-Smtp-Source: AGHT+IEKZoR43PuG4u0ovxcf8LSqoSkXytpnNXieBus8x9zq/gDUlem4pul2S/1lpLAukbDJ5yAyag==
X-Received: by 2002:a5d:5f53:0:b0:3e2:a287:2cf2 with SMTP id ffacd0b85a97d-3e765a0915amr6836384f8f.23.1757850301352;
        Sun, 14 Sep 2025 04:45:01 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ea21a6e4basm1503252f8f.11.2025.09.14.04.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 04:45:00 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tomasz Figa <tomasz.figa@gmail.com>
Cc: linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] pinctrl: samsung: add exynos8890 SoC pinctrl
Date: Sun, 14 Sep 2025 14:44:54 +0300
Message-ID: <20250914114457.2610013-1-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey folks,

This patchset adds pinctrl support for the exynos8890 SoC.

Best regards,
Ivaylo

Ivaylo Ivanov (3):
  dt-bindings: pinctrl: samsung: add exynos8890 compatible
  dt-bindings: pinctrl: samsung: add exynos8890-wakeup-eint compatible
  pinctrl: samsung: add exynos8890 SoC pinctrl configuration

 .../samsung,pinctrl-wakeup-interrupt.yaml     |   1 +
 .../bindings/pinctrl/samsung,pinctrl.yaml     |   5 +-
 .../pinctrl/samsung/pinctrl-exynos-arm64.c    | 157 ++++++++++++++++++
 drivers/pinctrl/samsung/pinctrl-samsung.c     |   2 +
 drivers/pinctrl/samsung/pinctrl-samsung.h     |   1 +
 5 files changed, 165 insertions(+), 1 deletion(-)

-- 
2.43.0


