Return-Path: <linux-kernel+bounces-833205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D13BA1684
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FFE5560F98
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912DB23B63E;
	Thu, 25 Sep 2025 20:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDot24T6"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489FE26CE11
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 20:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758833155; cv=none; b=QcfEOr6OMbVKMKPJ7GcTWI72yRmNZGCTjZWGza6u4P6ud/KX4tIl7k1miH7XbMiWk6kyG+iXvXmR9ghCqQsTigCS+QYSMkvGyJ4gWnGaSMhF3mFLCN+EAvcoeyTiAuTSRnvpGZlZwCKFrjnDeWP7dIEZbKTVyEJzQC/AGqV2fUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758833155; c=relaxed/simple;
	bh=6/fVemqx0boFHVf8BglV+KY7l1wA+KVgHJ6A3PVERVE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J1myI82Gk23OHDtvnwLoZDLyoJri4ayP7SA0aCfY/bQsbDzYfeQCsdeHUazfGwzLGgl3lfomjn8qUdQMFL7SrwFaiAVMKp4XvxHyf7SepLcIwUZ+3wkC+jpW0pHdc7Oudn0/l/oD1tk+iGmB9LKg2cxrgMAy4H2htdp6uq5x624=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDot24T6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45dd513f4ecso8798995e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758833152; x=1759437952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FawQ9LId3cga0DodGg9MhmIp2lk7tl7dCQ1MCM1JQxI=;
        b=jDot24T6cXDlqEuqT9WlAfFM8crSHKQQqdowlonaStGaiWGulPDsnostmO5y1ZaB6O
         WcO8uaF6hoCSj6PCSwrBGANE16c2wcePGspSZCFfQjiW39pVwpJ01kj61vs6mSfIvSRa
         5J35tFQQiROItEFLHPooSEiOswI7FyO2JypbXRLYU7StnMBOdrwjZXgYg6RqW8kyoxO/
         e0TEtcQfAbI1WqWXzDUePM8QiCwOsWCAoATJIQQbLY5ELbM/zumIHKI9VI9M4J9kgROY
         EbYpr8B63mbfy0dVTrWIfmUxjGLJkaQucI1m2H/Lqcuf81dBZUGWSXFtePDWk8cip3H9
         9+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758833152; x=1759437952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FawQ9LId3cga0DodGg9MhmIp2lk7tl7dCQ1MCM1JQxI=;
        b=O2GDQPm7H4oaq6LhbNR/NQKqfayGsb5+bchpI4djqZp/tBoME4lKEEVXHVwRba3TWY
         9lh/orVJFc+tzCKiqEamYiv5ssF5ZeFeJ044h9mH2iBtLyGwCdK2NkaNgXCapGsci2kp
         YR2bXLjWtjwl+Onj2Gl7xrYNcrARNUyAuJ4jrtHpWuIjW6lEP7QWqYjBM9+mCW4sNyD1
         xACYhSsMZOAdtuuVj707K4lYlNO/2IPqj7ye8TgQCEF6kbkAhXefcnCSiGJlOltUnT2l
         xXYk6sjS7329l7Ex5gcaXrXy/7mltuJCNwXITzWDkquLRVAN6YoX5gE+4Se7IIsgK8cU
         XZ2Q==
X-Gm-Message-State: AOJu0YyplVJ8EMvl3VTrWklsWWg5K87NAXJNvDaB7OMnmm14eN/Kp+kp
	O8tLKu0BybPyJvgGDGuni8gaJ7ekNgTNgCucceCQZYeuKco3jAUtq+YH
X-Gm-Gg: ASbGncufpDUW4coeA7FcW8guiJcgoCrjU/Td4GhK9kYcMwFIfsLnWBHvixXx6VCzkSi
	AJ1GhGzNiSHBv9zcZ4QpOgx0vh50eG7uEncw8soOrYCy8aG5qF12/aYlXIQ1UxjUwk0qNg52NeG
	aP0Cx+jReZM+EUQoNSlGyJRP9W6zjBgZxA91nw/c2XDNHUJZ4U31zC1+1iGa040AnTyzZ+jVECf
	1LlP/hcEb+ZrNXSUH6JxA7nIpP3ybm2BFMUep1B1BxzYfV9OLFjFhxcrJD1B+o8ZQ6b+KppG0sO
	Uuq0aK035eNsWMevdjifAzxKSk26B7+gOi0fZKYsRCbxvLTWSyKtRJLf59mAYb0i2Z0VNY6UVqy
	zeL2maAyOi7v+kBg1Ew+pbLFTmUzI2UX9/NlizUo=
X-Google-Smtp-Source: AGHT+IEHiCxXo80MoGqRQ4HgceWd3FnDtzRwnXBD2L0CdoGsZPj/nAU+IAdeObX5HfW52mzD3aiY1g==
X-Received: by 2002:a05:600c:c83:b0:46e:1c2d:bc84 with SMTP id 5b1f17b1804b1-46e329eb10emr51861395e9.17.1758833151386;
        Thu, 25 Sep 2025 13:45:51 -0700 (PDT)
Received: from localhost.localdomain ([78.209.201.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a996bf1sm91201395e9.1.2025.09.25.13.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 13:45:50 -0700 (PDT)
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
Subject: [PATCH v2 0/4] iio: mpl3115: add support for DRDY interrupt
Date: Thu, 25 Sep 2025 22:45:34 +0200
Message-Id: <20250925204538.63723-1-apokusinski01@gmail.com>
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


