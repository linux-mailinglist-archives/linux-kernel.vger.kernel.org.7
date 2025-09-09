Return-Path: <linux-kernel+bounces-808670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFD2B5033F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA834E4DD6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C815035CED4;
	Tue,  9 Sep 2025 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FV1vL++R"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3783568E0;
	Tue,  9 Sep 2025 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757436800; cv=none; b=CpEL7bFl48h8nb43vYGUYKpZMLfypvXpA5NjcwYgVWSuE6B/N2+35PgmgWxaehZEQAy+DZRVvFJC+IieN9KZyFymW747TG4UfOAj5jUA/J870gfHv+gbFDCf8+rQXYAkFYVQekWPfdZYbkH7qShcZEDiZOjRVFBKDIUaUckF8qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757436800; c=relaxed/simple;
	bh=tKY2MNB6vzcb9BPviZtHENs4BVa7a6Ti6a/3n3v81Dg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=k379MQcoJ+XtFQ03UuWWW4vVL0KbtmIHhU7zhU/fiycLuDlUnhmD/Qrz51GPj2KAU3f51yRIRXQ46i4Dl2m3EYWVL0YnVJPccla9VW7LaJcCVDB9mlAabil8RqoFKKEROVdUtwujGgzLriviQCAvBfedqVaPRVzz7fQMIPTkLQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FV1vL++R; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45dec026c78so15466875e9.0;
        Tue, 09 Sep 2025 09:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757436793; x=1758041593; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dImAwV6zE6y0gbIr2Lmn2XIli/Ka0KuvRpKkEpffFbs=;
        b=FV1vL++RuECNzGkXaojO8YMXFv9N5UyRDKrscxCQ0DhDUXDBHnvzHcoE0JfQohlcy9
         1WYso4AmehDGBBvUVVJcRPX77vFrStBIuGycAX5qMeqU66nyM99J8yzrYzC/SfEHjCoE
         ebN2GxDVYlsjIa+8oQ0wqZA+5rVUbxoC28fOkgEBNfyhr9eZ+H5Yy79ct3Nd0Xh8v1kX
         j07OqzBH8leY+ND6Wd+v/fOvb5BsIIMndpjfEFZynxF3ZJWcsXxXnpwrH1I7HcKkZxgK
         tjFQydJgv6dL6NsldJfveyWHXNDZE55kmFNxNkwcFshgqADVpAkg3bU9c+UhT1hfXTsA
         5acg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757436793; x=1758041593;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dImAwV6zE6y0gbIr2Lmn2XIli/Ka0KuvRpKkEpffFbs=;
        b=YLX4OngCsldMs3w2RiYcsuCeMmB2VdKOikT97KY2WTS7UnlkjLn8Ccl3HXSyUu3inJ
         eObw4Q7/fNu3XAOVRkZfLoJn5W8Gs7DDpFxbIQ14Tz910yia+eqJ2OK5gEGgy6YchmRw
         i5kppWRFKFqpiMjp+s3nRjokHXrpvh/vRMn70ZhfKM5cw/kbJrRiCGFHGIkmSJ6KveCd
         gPnHcGsEA5jxQOcd9cJqd6Djltb0+RBs1egOAc7qFQ6VAo7gyOZ3itaB3pe3KHXaDJZC
         xznSpA6GIAzd1XDNyr4UnnLz7+WmXK+ZmIrgrFZW1YrXL740Gn98hF0nBc1HPeUTcKVI
         5y5g==
X-Forwarded-Encrypted: i=1; AJvYcCX2f4fKmXpR7UfQrvxVT5F8Mr3qRqJ08NT9ilbnoXOFePDepN/OV6FA0cD4FWtHSbomxlQ2Ctnx6PMI@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf1eF15vTdtdqDGa9DckGaaymx/JJedUGkFMDiylL0SoTgRqgZ
	Z6srB41FLDdYLn3Coj5yoIoKbD4fPw4jyEW4uHCvuB6GSAi75V1SN4wI
X-Gm-Gg: ASbGnctXJ23Idf/pkiQzsLlYeSEQ8JCfXC+Q2rpmZo9Q4scs2pCf463Gi1ZzPxvHVB+
	rsl6wbxkDfpKZecxRlsLNP/pY8K5bb/M1MqXyEyuHWk7Xdq1dGTwydVcBrvIQWXNOETvGFnOk35
	qat1I5FNz4+m61HGhWOwKUy0nMEytsig0mQhWF5aP6JEydwxRqt/GW9yViV7TB9IFkXARADkIaR
	nDJcGgKEk22IN4lhYKP20xXNAIXiWa/4+YVEIvXfyc1eAOdc4Cf/5wy/qRO+953/VNDzygCHkh1
	Mg2Nck1cxdiER4vut9qBHx4G9igLHfeGbUHx2rqEEBcGG+1y/C659675BDJ87re97t+YQSlvbH2
	YBu1IAeX9MhBctGlSqHn+SFzYr03ZepuKWJjsfjav5lqEPv8rR0AqpyBECSCq9TxXSzCIZzMuzR
	s=
X-Google-Smtp-Source: AGHT+IE1PWjYpHqZLFNqkgLtImgZj8W1intWEZo/Zow9WV15/zUB7H6mECbHQGK6PDFhhZsFo2M5ww==
X-Received: by 2002:a05:600c:1e8c:b0:45b:47e1:ef6a with SMTP id 5b1f17b1804b1-45ddded5aaamr108676605e9.37.1757436793129;
        Tue, 09 Sep 2025 09:53:13 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([5.225.138.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9ab7c7dbsm314379085e9.11.2025.09.09.09.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 09:53:12 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Subject: [PATCH v2 0/3] drm/sitronix/st7920: Add support for the ST7920
 controller
Date: Tue, 09 Sep 2025 18:52:42 +0200
Message-Id: <20250909-st7920-v2-0-409f4890fb5f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFpbwGgC/2XMQQ6CMBCF4auQWVszFCjiynsYFlMcYBKhpiWNh
 vTuVrYu/5eXb4fAXjjAtdjBc5Qgbs2hTwUMM60TK3nkBo26wQsaFba206i4JUuVthVZA/n88jz
 K+4Dufe5Zwub853Bj+Vv/iFgqVKYm21BVjx3hbVpInufBLdCnlL4+QICwnAAAAA==
X-Change-ID: 20250806-st7920-e7aba32b3ab6
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Iker Pedrosa <ikerpedrosam@gmail.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

This patch-series adds support for the Sitronix ST7920 controller, which
is a monochrome dot-matrix graphical LCD controller that has SPI and
parallel interfaces.

The st7920 driver only has support for SPI so displays using other
transport protocols are currently not supported.

* Patch #1 adds the driver.
* Patch #2 adds the DT binding schema.
* Patch #3 adds the MAINTAINERS information.

---
Changes in v2:
- Refactor SPI communication:
  * Internalize error handling and delays within the st7920_spi_write()
    helper.
  * Split the main SPI write function into smaller, command-specific
    helpers for clarity.
- Improve DRM/KMS logic:
  * Relocate CPU access calls (drm_gem_fb...) to the atomic_update hook.
  * Use standard DRM helpers (drm_crtc_helper_mode_valid_fixed and
    drm_connector_helper_get_modes_fixed) for mode validation and
    creation.
- General code cleanup:
  * Remove dead code related to ST7920_FAMILY.
  * Replace WARN_ON() with drm_WARN_ON_ONCE().
  * Ensure single variable assignments per line.
- Fix probe initialization order:
  * Move spi_set_drvdata() and st7920_init() to occur before device
    registration.
- Devicetree:
  * Update bindings to address feedback from review (e.g., reference
    common SPI properties).
- MAINTAINERS:
  * Add a proper commit message to the patch.
- Link to v1: https://lore.kernel.org/r/20250806-st7920-v1-0-64ab5a34f9a0@gmail.com
---

Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>

---
Iker Pedrosa (3):
      drm: Add driver for Sitronix ST7920 LCD displays
      dt-bindings: display: sitronix,st7920: Add DT schema
      MAINTAINERS: Add entry for Sitronix ST7920 driver

 .../bindings/display/sitronix,st7920.yaml          |  52 ++
 MAINTAINERS                                        |   7 +
 drivers/gpu/drm/sitronix/Kconfig                   |  10 +
 drivers/gpu/drm/sitronix/Makefile                  |   1 +
 drivers/gpu/drm/sitronix/st7920.c                  | 893 +++++++++++++++++++++
 5 files changed, 963 insertions(+)
---
base-commit: c571cb70e1ed43ee543c70151e61a001ab2eefa2
change-id: 20250806-st7920-e7aba32b3ab6

Best regards,
-- 
Iker Pedrosa <ikerpedrosam@gmail.com>


