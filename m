Return-Path: <linux-kernel+bounces-807402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D684CB4A3F7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84F44541C58
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15313081BB;
	Tue,  9 Sep 2025 07:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIDVW0rS"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C67306B3A;
	Tue,  9 Sep 2025 07:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757403525; cv=none; b=sL4irPuEJTJSE7sRbhg7naFcGfmir8QYuGAHe+t4RaT4mxbYgHT8u90utjbdAtNVwIYkqYmYBnDBDRyqX6uMN5+DlUXndakaDma5rTuMOpPqMXZ2HQmSrJca6tIb5x5+81phszYvmvlfQDelMNa1DjbKxwjbqHTyEpVV1WxKcIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757403525; c=relaxed/simple;
	bh=CMaurVLA2GBvRU/hVLbNItZkdoYpYV9+6zJGCChjSz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N6qXtiRVNuWCBYKRQ3oPTqVdwSOO6QAe6O6k6Ct+NqOusyujBKeZVuqttqoYKbfFddjvCpLvxocXJiIloYLayV6i90R67IAHjF1gXFjlMvmHiwVfJftFYE38R0kFC6eF1j1HrTjUk7JExz2w17A7CQ9J+Ivx+c5I+GwO/WZ1W+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIDVW0rS; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55f98e7782bso6056777e87.0;
        Tue, 09 Sep 2025 00:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757403522; x=1758008322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MCB88+vbweUJHwwH3EqEE8pXooyU0sixwISDhtVREDg=;
        b=FIDVW0rS1SwHHVRGOQ7qDKkbE7T60vjPqhMPWCIVfsYyWF9aU6VHfq52n24nMTMb9Y
         bFIu/11cSOUTY7sAIVRvLfcp1YtTDxE4B5c7HLi2k1AiOy1LRZLfGHFDPzb4Z3+BYS5r
         sMEUPQxGCIvmol3IMUlAHqaOmD25cnq0vqMiodA+yGnO9QvTuvzVjaWnzBEhqA1Rt+se
         NvXbAeK2AibjNP2C6IHsulc1nKvQyoJYjAnpWUMqovJnxhejjl+Z2vQKnTQGgLifMGto
         b86r/NR2g3g5xrFBmwXWxgecUealh7b+E9pj4yPZ4e9/KcnCS5ACPVNDCupKrPkXMdpi
         i6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757403522; x=1758008322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MCB88+vbweUJHwwH3EqEE8pXooyU0sixwISDhtVREDg=;
        b=pO+bKvEfq6qIRSMjwgC+3v/tgYCjzdrf9d0AWt9IH/aq0EfMOV0H9ph0DFEDOmeP5L
         yVkb7TCLOqw/gGWzhHuPZlUl4DqLaO2UEG/oE1aD5/RztKs3BG07ExEUMT1ItioVQX7l
         8nzcch5xEASJOxCJLYgaNUY9p0+opljL0wJCZs9wCq1L5ybMEBWsmJqZnlR8Iwqo1brr
         t0Lb6P3cbrmHWh9cU4wzqHnnaSUYT5OaAbvdNfl0C1Hx7X5Ua0/6h23QeNYH/ZQUgXvU
         iccFqM0j/+MsUAiEnfvrX9z1El30RBN5gFm7jVmsIFgN1+67ja5wxQDmUA2f2K5dBU3O
         56Lg==
X-Forwarded-Encrypted: i=1; AJvYcCVnKM6Gj2PJ1AJ2kKV9M3QqUz+LhRF4EcI4f81BR+ybpkBbyyPqx8MQgIhxyN0WpHoZolu5iYjlZJB7Xs8Y@vger.kernel.org, AJvYcCVvKW7PRv70wxUvXiX7CdsGzFSEnr962xSiKY1Ejx9gGQsTTkYbpYW7qEzJmC232u1rEKbTNH/YSWM/@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ2Jzs9Gm9yqXJ7jxvOSVfyHcHjDeHIJ9IiKhCyHK2y1eR6j13
	/cIX13I4dtigqod3e1btxyExIMUQQAqrXHqw+dR44eSOQ0dpUZ9Cx3CV
X-Gm-Gg: ASbGncv2MdvBPZV6OjVn4Y9i4tgOCySHgRXBvKLDGC/cGoqBSsdffAFhTCc51p/Jeen
	h2O40NzYHotmnw2WPTtUQgiRqvnoJSShC8uAbTy5X4FSovGVdnaacJhG0Xu9hMu7rwxKwH/HUWe
	MC/sJBtpWG3Oxwd4gC+orAxuFURJYbT5OtyYDzLTmGoQJZ8oI7a6vthfJxVIDt7nvEztzMJqMsx
	BZ3SJB4sx2rYaVn4lazrHXM1zVigIW7nI78/X7Ov8qgMP0OQdG+ZLCFfj71KTyvKEgY94YT5lwm
	2hZLCbDt8GNO09Mw8ayvQT/KWIxqSvuUxAscRMHP74mjIKO4ei7sWFf5xl1JOMvsK/DTF9IdF7D
	bEu7fx2p9aZOJLhEuv8EE5F4S
X-Google-Smtp-Source: AGHT+IHJBwIkvW/VwHsEbpXKyVfJ7RBEnWnwN0U8Py57QMTHTnwvYi3mfGECjwrqurnM3zc+Iv7Q5Q==
X-Received: by 2002:a05:6512:3e17:b0:55f:67c6:be48 with SMTP id 2adb3069b0e04-56099434be2mr5502271e87.1.1757403521219;
        Tue, 09 Sep 2025 00:38:41 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5680cfe2496sm342580e87.61.2025.09.09.00.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 00:38:40 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] DRM: panel: add support for Sharp LQ079L1SX01 panel
Date: Tue,  9 Sep 2025 10:38:29 +0300
Message-ID: <20250909073831.91881-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sharp LQ079L1SX01 panel is a LCD panel working in dual video mode found in
Xiaomi Mi Pad (A0101).

Svyatoslav Ryhel (2):
  dt-bindings: display: panel: document Sharp LQ079L1SX01 panel
  drm/panel: Add Sharp LQ079L1SX01 support

 .../display/panel/sharp,lq079l1sx01.yaml      |  99 ++++++++
 drivers/gpu/drm/panel/Kconfig                 |  15 ++
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-sharp-lq079l1sx01.c   | 232 ++++++++++++++++++
 4 files changed, 347 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/sharp,lq079l1sx01.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-sharp-lq079l1sx01.c

-- 
2.48.1


