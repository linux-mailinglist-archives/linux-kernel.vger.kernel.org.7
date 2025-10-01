Return-Path: <linux-kernel+bounces-839436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE8CBB19CB
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 21:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6BD94C43C1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 19:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104E6175A5;
	Wed,  1 Oct 2025 19:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LejC3s+u"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8380626F2B2
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 19:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759347233; cv=none; b=ZxcBwtkdiJ4KdHBNCraaI3Q5KhiI8df/XnYITV/ZCGMPbiwz8ieLNkuC6cy1SxEAIwG7mhofyf7AIZ4y4BW3TyhPbJ5Pd1qOVHnZSggrqIjgepxli7yMqd2pesF8flsI22i0oFB7P1wAphAwXJPOBl3kq3X/ZMF+VFu2P9NLkxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759347233; c=relaxed/simple;
	bh=oMlT0rSozXjZZ7YPGdWknn8R0T/lM0GFdFoB9iHdVUM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HHX2Qov2d4a1nxEToS3fnqtoMfDSc2HhGluvQCDbKoBT+kpW7MqRfOOizr1mCVMG4icJ8KU7H/z4HxNRSLMEnlX7/5/nexuCVTxjoZP0r5TUduVnLNqUOvI0NjzAQ7mnx+uE7WNvIDts9vRaLqqACegb0Qe0Em+AM4DI5iG628k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LejC3s+u; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-27356178876so968025ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 12:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759347230; x=1759952030; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U7URaJzWJaVTawsdlY1mWcQUZJgD58fTnHuXHAWwV3k=;
        b=LejC3s+uHtSnFEzeeHpL9iqLqXA8OQXBRC5fSNx6qxigYGFHX0oIFLLie0La/6uYld
         1aAfIwlIFYhFWjRj8e14AASB75Y2/pNOCJN73b1Cq7WjaHki9Y9DwI/Pacw8Tj6R2RRX
         wcsbEqt16GgfQ6D3eEcxi1Gj/OM/KqzfMPeurVvnHif+dZOMlx66rM8C92l6hSLcU3g8
         qfgXAU2PEAKAvmImMhJtWccBIZAixKifx6d1YANZcEzwcAMjLdJSEgw8T4YcW96fOOya
         qsJSFCUsW7tBCmE97zDZUnsxH/21GXUk3W8myfqrUzJ8SWjnjUrSG8TMrKeUaR2GlEAJ
         P/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759347230; x=1759952030;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U7URaJzWJaVTawsdlY1mWcQUZJgD58fTnHuXHAWwV3k=;
        b=cLlUysd+yEIsRPIc2+rwK1AFrKR6J9HmPZDUU/6hMxubXTi8jmyZh8IVXAyuyt7pWF
         FKm8V93/OUwLszp4oe8knmFpyILz8fNDe9FWhcO4kMDEDpFRAUdxYNkKAQrPpXkshVKO
         iuTfSno/4Byr1YH6FB+CBcI2vFslIuPIgyAQxdj1I6+S7demYKkjy07dxLRSodRKFKqV
         Wm8vDC1koR6fSVpJ8++NJmE+i56OLQ/ybR89y8TJRgTBOS2PGglyuRH2ag0DTUCxmjuq
         Nrc3FnFzeFAoFxr0TN1D8TS1KmDtjX4cDQ+etUYLrxLElTzBI1y4MKOHLPqa8gLRt9XY
         HTqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqeOZlFuAhMAsgPdJ71OFpMS6WdSYSxgLQPPac8S9lvaO7V4u37qacb0EAylBLBTZY19J0XralIkKDNdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygq0H1WuxX+oIf6lw/oDIiml31aLQb9cdMJbzjhO4dYYul6UzP
	C1mdpDcmuAlbLgaAJSUxbvq0XFJLnKDZKA0UT3RPLI0hp8bnLZ1uJpVnE0aqXR3zS4GAYUvlTd8
	6PUp1xg==
X-Google-Smtp-Source: AGHT+IGkH0qUr//bkgYHfKtx7Vcs5BLj3vf2rBk7ho44eq/0TLPPDY1HD1e7BnRuPnvuJrQBf8vM8fjNLiY=
X-Received: from pleb9.prod.google.com ([2002:a17:902:d409:b0:260:3d:8a7c])
 (user=jthies job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a2e:b0:277:9193:f2da
 with SMTP id d9443c01a7336-28e7f27dab1mr62308035ad.5.1759347229875; Wed, 01
 Oct 2025 12:33:49 -0700 (PDT)
Date: Wed,  1 Oct 2025 19:33:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251001193346.1724998-1-jthies@google.com>
Subject: [PATCH v2 0/3] Load cros_ec_ucsi from OF and ACPI definitions
From: Jameson Thies <jthies@google.com>
To: akuchynski@chromium.org, abhishekpandit@chromium.org, krzk+dt@kernel.org, 
	robh@kernel.org, bleung@chromium.org, heikki.krogerus@linux.intel.com, 
	ukaszb@chromium.org, tzungbi@kernel.org
Cc: devicetree@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jameson Thies <jthies@google.com>
Content-Type: text/plain; charset="UTF-8"

The ChromeOS UCSI driver (cros_ec_ucsi) currently gets added as
subdevice of cros_ec_dev. But without it being defined by an ACPI
node or in the OF device tree, the typec connectors are not correctly
associated with other part of the device tree. This series updates the
cros_ec_ucsi driver to load based on device definitions in ACPI and OF.
It also changes the cros_ec_dev driver to block adding cros_ec_ucsi
as a subdevice if it is defined in the device tree.

For context, I initially sent out this series for review in March 2025
(https://lkml.kernel.org/20250312195951.1579682-1-jthies@google.com/).

Patch 1/3 has been updated to address comments from the initial review.
There were some open questions on patch 3/3 regarding adding MFD
children when there is no cros_ec_ucsi node and parents conditionally
checking if a child exists to create one.

The expected behavior of this series is to only add the cros_ec_ucsi
subdevice when there isn't a corresponding FW node because always adding
it would result in multiple cros_ec_ucsi devices and too many ports
being registered with the USB Type-C connector class on devices with
correctly defined FW nodes. It also does not look for a child node to
create a child. It is looking for a child of the parent EC device to
only add cros_ec_ucsi if it does not already exist as a sibling.

v2 changes:
- updated google,cros-ec.yaml to support typec ports defined by
  google,cros-ec-ucsi.yaml. Tested with make dt_binding_check
  and dtbs_check

Jameson Thies (3):
  dt-bindings: chrome: Add Cros EC UCSI driver
  usb: typec: cros_ec_ucsi: Load driver from OF and ACPI definitions
  mfd: cros_ec: Don't add cros_ec_ucsi if it is defined in OF or ACPI

 .../bindings/chrome/google,cros-ec-ucsi.yaml  | 71 +++++++++++++++++++
 .../bindings/mfd/google,cros-ec.yaml          |  4 +-
 drivers/mfd/cros_ec_dev.c                     | 40 +++++++++--
 drivers/usb/typec/ucsi/cros_ec_ucsi.c         | 25 ++++++-
 4 files changed, 132 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/chrome/google,cros-ec-ucsi.yaml


base-commit: 48633acccf38d706d7b368400647bb9db9caf1ae
-- 
2.51.0.618.g983fd99d29-goog


