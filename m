Return-Path: <linux-kernel+bounces-836918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA187BAADEE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 03:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF9B1C22F0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 01:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1466D1DE4F1;
	Tue, 30 Sep 2025 01:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GUi+wIQo"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCDE15ECD7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 01:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759195463; cv=none; b=mzsHHJ0XB+Gmm9GJPXu4ZbXyPADbniw5JTVrgb/xKWGEJq/VvBgz+Dlu6exhiJnboa5xfqRArEvTQQNGTJCgqHkAIc++gZLyQ8h8gedIQymK3+V6tdiykE7Wrsz03buGlM0LYjm8PKBPhLP4qSHzIQ+aGOAviYKJdGud2fvlBZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759195463; c=relaxed/simple;
	bh=5kgCx0B7GtxQuKmjJS2bFCsfsTvnnLoF8qyM/AecsgU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pB9zvq64L1DfhQ5JGJ1NgrPUQNm00GPto41Eh7sOeOLcIVB92J//cQc0N/ke6W3TJL/box+6h0C2zr2EvgzA3feTq6QcKmhstUzySMGc/l4Y7O26xrpMXbM1vad80Y3FZ8asawyeJZXpMcrSwF/3QK6sRFg6dlmLOwY2ZcO8h5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GUi+wIQo; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32ea7fcddd8so10724611a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 18:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759195461; x=1759800261; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J0RDHcxeZue32qFdwYRcgYnakUkcEXPAGHJR7B+xksM=;
        b=GUi+wIQocvWRFh+8ImqR+uTt0+fb55+WxNHl2lnjbJnVBctJRasYAhUbw6L9HaEzBG
         j9RwW9nJ8koVEayGnCDv49xyn56PfeXSX4lo+bbax93oM5LdeltwikHSMjiiKl1wE8a5
         EbC9EpwBSHgcKew/4qjWkPVAe2c8tyNSNAbv2lM2no9O2O5XFvZEp++2CUCbqWYL1gN1
         AzfLx5Qd6LOZ7mehIdY8xtghl/xL85SVG5+Rp+Y3Hmt2KbRCgVfSi33qVfGc6huACYjT
         oGGdOvR2nW9EGuwcP0oe+rjYj3ffPudq1IWJW/R/+wAbUwkctlLfkgQnh/ETBW+wxv4a
         Cm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759195461; x=1759800261;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J0RDHcxeZue32qFdwYRcgYnakUkcEXPAGHJR7B+xksM=;
        b=e54NEqehHsYYDceDfIB+u1BvxhYV3YMrhHnKjBcQmhjz4oEszHD+94nFCl+hVB7O1m
         pJlPSOfasXHYV2UGVLA8/9rREYbShpg3iiEPKOYndk429FSoQpJgpx6GpDrRZke7A0RO
         V6Hk0vl8Z3bB8FSF/hNSgsl4qLZ23P3YuPhiYlfopLfRItrNcvA3rmj89uscrr7V2RBF
         QyaGe7/oin0y9O/VjrRHSFycNIW1ng3BJt8on+Jj0FQgtt2hcxEYogycwVpr4G38TmJ0
         hgjE8delTV0SvHWX67u1YsdtKvrlrKniBUJX5aNBXORQlegUMxedGfzu6xqNk4NLGTX1
         T5Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUxTMQB4zjGl6Nh6PinEYbTvjtYwj7Ecncc9m2DlmFLBvcLMDn/7Reh/qcJYLxfED3na8Tx1hQaU8F0yFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcLZDYSUxbc5JoL6rBIbQHN0TzRwsQoltrWywDjp9iv03xXHS7
	t98BcQbDhnHpkWDjBF0Eo8mTIlS2qp8hF6gXsxSeO0t/7ODLNLpi/tt0zLNL25GkeT8QGNQTvEY
	N1p4fBA==
X-Google-Smtp-Source: AGHT+IGhtXfXwA6L9GaEPTI+0jBf9HTCFAgbC0xjyvLvK7pztlQGMoyItS01pkGETX20SLH0jVALCpowLV4=
X-Received: from pjqd1.prod.google.com ([2002:a17:90a:a681:b0:330:9af8:3e1d])
 (user=jthies job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b4f:b0:330:6d5e:f17b
 with SMTP id 98e67ed59e1d1-3342a2ab8c5mr20908027a91.21.1759195461383; Mon, 29
 Sep 2025 18:24:21 -0700 (PDT)
Date: Tue, 30 Sep 2025 01:23:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.570.gb178f27e6d-goog
Message-ID: <20250930012352.413066-1-jthies@google.com>
Subject: [PATCH v1 0/3] Load cros_ec_ucsi from OF and ACPI definitions
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

Jameson Thies (3):
  dt-bindings: chrome: Add Cros EC UCSI driver
  usb: typec: cros_ec_ucsi: Load driver from OF and ACPI definitions
  mfd: cros_ec: Don't add cros_ec_ucsi if it is defined in OF or ACPI

 .../bindings/chrome/google,cros-ec-ucsi.yaml  | 71 +++++++++++++++++++
 drivers/mfd/cros_ec_dev.c                     | 38 ++++++++--
 drivers/usb/typec/ucsi/cros_ec_ucsi.c         | 25 ++++++-
 3 files changed, 127 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/chrome/google,cros-ec-ucsi.yaml


base-commit: 48633acccf38d706d7b368400647bb9db9caf1ae
-- 
2.51.0.570.gb178f27e6d-goog


