Return-Path: <linux-kernel+bounces-834687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD8FBA5472
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 00:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D819062848D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 22:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AD1298987;
	Fri, 26 Sep 2025 22:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIQY2NCy"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A871D7E31
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 22:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758924139; cv=none; b=BuO+Tb5vULzOCE+Sg126INWVEZpC/RPuvMjTq9O9GpuVpukvAwFwwkJAvUkuBMBGHf/pWJBug0L/0+gzceyJY9VSkt+PTGauX/P+z5ix9sNUp8CYkWF7SrjnFR6Gf19sSkwsLMXj9yowq38n1xHWOPGDiR7b9Zu4DKBLI3/+/14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758924139; c=relaxed/simple;
	bh=Fzii6xFMlq2tmZrhMKrNSx2r3cN9Y5yZ6BuKvSWLAQI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SpNiMD/dqJISsdUMjmuPv5JECQYzMf06is3GdxSHQHAwinAGS4+Ae13ufm4qitCxHnMbOoDcwvNICDSAhAAGOGGWmivPqU0fDaSULMM8F8grrO79+JxbCavr2XDFxFNUJVg4lnqp15tBTtXcF9pbUxJr9CeE9s9bZzpc3UusQ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIQY2NCy; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3c68ac7e18aso1661211f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 15:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758924136; x=1759528936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WiK0o9OsPPIgnlfmJq/d9pxBatMc1jJsoABLigao4DU=;
        b=UIQY2NCy9DlNOrYxMIR0XxQw28GYK9+6neyP/uc4goA7MbHwrAzhaexkiyda0IUxvT
         m4QRO2+jgaxPWntO2X2QeNVv7KPJB4rqh2jAplU1xUtxTdn5xvSxgzCAkBbIwmMPzqK+
         nQxBvysqjLaHvKaBgw2kxi3AQNxspgZKNrpwrE6VutIOFIeNQov6jykxLLby/N40lwSy
         MngQlKq/PIcub9P7Q4lxJrU7frD/Ht3IhqU66BDwfe14ruP37YsgDRZrcu3DKxwslOiG
         Tp42T1UZdZwGa9zU02Hqmhj09RO6+94oSVQabapgc5QDA4pvbLxWllkDrPR9D7x1Ysqh
         O5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758924136; x=1759528936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WiK0o9OsPPIgnlfmJq/d9pxBatMc1jJsoABLigao4DU=;
        b=si6SgypQvPqbEjdPBGiGiB7hcJuA/kOm2Wz7z1J0C/GL1OHBu/8yF4k5CP+69D3syV
         E7T5IIbwB1AUC8Z/1HMupmzx6J7AAsNWiAuJC1A5WSbrP+Nn13LvsIUNTrCloqG1ytje
         GN4o45BXEEaPv+IRYapv3OxW+KRrq0kmD1Laho7kdkQj+Jm8rNlPDhDqygVhEhh0WKAI
         PyIw/6ieu3nJzDWzxcN9l0dP8gVi07+KRF2yiGRpTZue/hfRwSOwoXSppQhGpK/DyHKi
         5JX/RMj28S3NfSis+VcZRauc8QajEMxLyOqr4mgjJpwYq16FbdRBXGNGjfUwlFyAMb4A
         x0/Q==
X-Gm-Message-State: AOJu0Yx96IoMwmrq0u+XsIACqt3G6aWQZ1mEhqwM2MNee9qmbZ9MUpJC
	Z9qPvkLmKRB2zM+hWphcBvxP5GSkq1RH+4qJUDrg4wcZkIwJERNLMDqFGaMkMGT7
X-Gm-Gg: ASbGncsdx5BOJ12dMbNgNFQ4cyXsSkSRfkB3+OIWCvDtsxxYQ369qNMSpE1ep/GsjKN
	4/XoWuQgrXXpHFnDZe+FQHPEtth2Fwv6Zzcs6WadU2V3+SVa5dUYyGE3UL541y9fHiLzZf+3/VA
	Q2QZ1Wh2M51FXxECsXQdTE6uPPb4QZPoI/k5oB/GT8Tv/21LjmiEbHQ5aDIYU3foXVJnr88viWo
	ubtLZGb0UrG64yasWIGJYgaWzJ12GrPQZSaVqVZ7MBeGyGFXEnNSFCNnvA9lqViT6HbmKB+qtcL
	Y4LDiAGKAORbZ8bFnZVDerOqX33Hv1YSa7XfaZPsl2URj1H3DbXQwyW8HShgmAkt2vgrzqAHBIQ
	TDzNsz7/njmnxn6bwbRP3cgpaFBVsx8J22NGYJZfs
X-Google-Smtp-Source: AGHT+IFOpFRZvqIjkfBl0P4vtqpIDNMACFW7mLBlCtVmhjKs7Ub89Ws2JgUgQ8sZ1aDgm5ZAaXD9PQ==
X-Received: by 2002:a05:6000:1866:b0:3eb:6c82:bb27 with SMTP id ffacd0b85a97d-40e4accc83dmr7196825f8f.61.1758924136008;
        Fri, 26 Sep 2025 15:02:16 -0700 (PDT)
Received: from localhost.localdomain ([37.163.230.203])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc82f2965sm8410236f8f.55.2025.09.26.15.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 15:02:15 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux@roeck-us.net,
	rodrigo.gobbi.7@gmail.com,
	naresh.solanki@9elements.com,
	michal.simek@amd.com,
	grantpeltier93@gmail.com,
	farouk.bouabid@cherry.de,
	marcelo.schmitt1@gmail.com,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v3 0/4] iio: mpl3115: add support for DRDY interrupt
Date: Sat, 27 Sep 2025 00:01:46 +0200
Message-Id: <20250926220150.22560-1-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,
This set of patches adds support for the DRDY interrupt in the MPL3115
pressure sensor. The device has 2 interrupt lines, hence the new
binding. I also added support for the sampling frequency which
determines the time interval between subsequent measurements (in the
continuous measurements mode) so it's obiously tied to the DRDY
interrupt feature.

Kind regards,
Antoni Pokusinski

---
Changes since v2:
* P4: included linux/bitfield.h

Changes since v1:
* P1: add `vdd-supply` and `vddio-supply`

* P2: new patch: use guards from cleanup.h   

* P3: change macros of control register bits to convention
      MPL3115_CTRLX_NAME
* P3: MPL3115_PT_DATA_EVENT_ALL: use GENMASK
* P3: trigger_probe: do not fail if dev_fwnode() returns NULL
* P3: trigger_probe: use devm_iio_trigger_register()
* P3: trigger_probe: introduced enum mpl3115_irq_type and 
      changed IRQ setup logic accordingly

* P4: MPL3115_CTRL2_ST: use GENMASK
* P4: read_raw: samp_freq: use FIELD_GET
* P4: write_raw: samp_freq: use FIELD_PREP
---

Antoni Pokusinski (4):
  dt-bindings: iio: pressure: add binding for mpl3115
  iio: mpl3115: use guards from cleanup.h
  iio: mpl3115: add support for DRDY interrupt
  iio: mpl3115: add support for sampling frequency

 .../bindings/iio/pressure/fsl,mpl3115.yaml    |  71 ++++
 .../devicetree/bindings/trivial-devices.yaml  |   2 -
 drivers/iio/pressure/mpl3115.c                | 314 ++++++++++++++++--
 3 files changed, 352 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.yaml

-- 
2.25.1


