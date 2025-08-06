Return-Path: <linux-kernel+bounces-757758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1E2B1C64F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0065C564B53
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D492B9A7;
	Wed,  6 Aug 2025 12:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnZ7zfvF"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8311C18035;
	Wed,  6 Aug 2025 12:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754484505; cv=none; b=VRKM/tWnCnHwHiForYqrid7X8HJS5tMbXYXswDNZiqT/FDZhgym6eFjfRMb2E+J2BBowW9zcrKcdA/JQ9SUIZaJ8XTHXOB8nf+V/W4ZVuqkL2GJxngx9bUDRryuYHAqTa4wh+Q3b46M1bQrqg1VJJcNb9THQLrA1HFwe+6YgJM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754484505; c=relaxed/simple;
	bh=wawPi9AOaooZpaSkkidqzN9MmLVJ9arThmBgl/y7SaE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dHftpEEL8rYPgBawkdJ6M2jxYy+PG491TwekRRjU33g7oIHr/NUMcBK7CasTc4WAoO0UOIdxoHK0ulSpwTFVvvi0tB0++U0Kdq4z7xooSEyC3eCUsg+EGzPVCkiywoVlEbMwfXcQ1MuH5G9wl4G4aFmdBZknhCvKjMsFAsedHB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnZ7zfvF; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-455b00339c8so43034105e9.3;
        Wed, 06 Aug 2025 05:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754484502; x=1755089302; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D53t7Gt4BgTj27r6S11MtMrbQ1+uu9jwiGO/fo4z3ao=;
        b=YnZ7zfvFwiGK0NqzZssMTV6Yb1sALLyVx5JrXA8bGJxFtUK3VpDKU4kDzHDfVc2ZWl
         n7CAbjn1IUvtdrj1IZ2BzMAViRC7VEJTfj7NhUir/UcN2Z63b5vJl9b958jfsM2ZB9/a
         rRB/9Y6oLNug6S+qEei3Xty+AsdElUqPrcMalvLONODT8gq+ZTQyl4ZiD1AYVeK35yUD
         tH8VSJSRau54fEUZ0nOtDoEIn0v9/LNLN7DxBDztBoVhn24Xq2Qy9hZxjcDChMB9TzlW
         d59zb/VSCdVNB07orqh1UD60OYI8o6bp8WRlQS2PVljuxQ0TNQmTReM1R0r0/vTH83U6
         +J6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754484502; x=1755089302;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D53t7Gt4BgTj27r6S11MtMrbQ1+uu9jwiGO/fo4z3ao=;
        b=qjgN8XIz/BbeDhx2ottqg4TJ1qY7mCsv+pIy3JRRu4nrvRcjmZfMdm3Cmr8DW5zu7L
         Xc1/YFhnBQ+fu587c6fp61Rb6pT5w7/OZQVfjHKqjAWSx7430fvXBpz6yG/rdY40YuMO
         +UZMrW1peGdlNKDqbwS9ecAg4Cq/JCOWR7L86DmEJOweDJsMf8GO1CpkGBcZSDtZ2iOi
         Ir6t/bsNfLzH/e30TfugbaMuqTe/+PgmMBjWKZvEhjTXbxK13TchK+l85LHuI2N4hr3L
         ls6OsuBRSS5y6uHus3LuQ5vd+6mViVvULDDBHEe5w/BPW+VOUI2m/2IfojUUMY2EZgWx
         WX5w==
X-Forwarded-Encrypted: i=1; AJvYcCWwpZNjQjqu9+rPzqkLuCyd/c+lOd5nLF4l4FOA/1ByJ+sf0clcZQhgefm0oF92DMqOlUHmpreyOrHP@vger.kernel.org
X-Gm-Message-State: AOJu0YwoOtIraqKLQlDLhknBPLwbttCP/VQlRWAiTZeKow7whroHuafy
	ZfwxrIVNimCTXQRdET6jz/kpDhdLHSZf2gdDcHWXNd8PZHiJN0/K+XD0
X-Gm-Gg: ASbGncuGO8zq67fIhp1dvOSCHMozEFSD4+La/mQzOQiyCnELj1e5xcHWTSK6FZEqhjP
	DPBQF3bs5WFWKpMsMYjz6G5aihpzvCbxiM8UaMOA/tatUcmTve0DiM/Q4zoCYHfzU30be8lHb5t
	uQVBXIc868YJzZsIKEV5TbjVUHIFsx6Epr9SWi3pg8DmjqewhS9NAjUHQmYXxAc68U7k41XfMol
	wozf0Qy2cTO8bM+eWlT1g0ok8ACWFc12/PWtOt093VGuLwfjfuduDPyE4V5RZqN1U68ukXsZ8ew
	otnVdf5zkLkIQ16TItT/j/Pizww7sGZjxv6Ct3w1NMac3Gr+WHTdttdpSDPRJgld1Tcai5Zo1/0
	tv5+QqLGy/SB7jg8Z1qzXaDXHJxOoLpYU5onG79xGJYCXJivhXTnb97Jh/naFWrE83DUkI9x5Er
	c=
X-Google-Smtp-Source: AGHT+IEMGRZoqIzd1YpdMiOznQ3MbLmfPYCb+cml25DJJ2TOqFLSOHhSTx31kwUALgscCaGAHNC6BA==
X-Received: by 2002:a05:600c:4ec6:b0:456:29ae:3dbe with SMTP id 5b1f17b1804b1-459e7103684mr22614175e9.24.1754484501337;
        Wed, 06 Aug 2025 05:48:21 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([91.116.162.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458be70c5f7sm170110045e9.26.2025.08.06.05.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 05:48:21 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Subject: [PATCH 0/3] drm/sitronix/st7920: Add support for the ST7920
 controller
Date: Wed, 06 Aug 2025 14:48:08 +0200
Message-Id: <20250806-st7920-v1-0-64ab5a34f9a0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAhPk2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCwMz3eISc0sjA91U88SkRGOjJOPEJDMloOKCotS0zAqwQdGxtbUAg49
 2xFgAAAA=
X-Change-ID: 20250806-st7920-e7aba32b3ab6
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Iker Pedrosa <ikerpedrosam@gmail.com>
X-Mailer: b4 0.14.2

This patch-series adds support for the Sitronix ST7920 controller, which
is a monochrome dot-matrix graphical LCD controller that has SPI and
parallel interfaces.

The st7920 driver only has support for SPI so displays using other
transport protocols are currently not supported.

* Patch #1 adds the driver.
* Patch #2 adds the DT binding schema.
* Patch #3 adds the MAINTAINERS information.

Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
Iker Pedrosa (3):
      drm: Add driver for Sitronix ST7920 LCD displays
      dt-bindings: display: sitronix,st7920: Add DT schema
      MAINTAINERS: Add entry for Sitronix ST7920 driver

 .../bindings/display/sitronix,st7920.yaml          |  55 ++
 MAINTAINERS                                        |   7 +
 drivers/gpu/drm/sitronix/Kconfig                   |  10 +
 drivers/gpu/drm/sitronix/Makefile                  |   1 +
 drivers/gpu/drm/sitronix/st7920.c                  | 869 +++++++++++++++++++++
 drivers/gpu/drm/sitronix/st7920.h                  |  55 ++
 6 files changed, 997 insertions(+)
---
base-commit: c571cb70e1ed43ee543c70151e61a001ab2eefa2
change-id: 20250806-st7920-e7aba32b3ab6

Best regards,
-- 
Iker Pedrosa <ikerpedrosam@gmail.com>


