Return-Path: <linux-kernel+bounces-780235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C97B2FF62
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5764817E75C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E02B2E1F1C;
	Thu, 21 Aug 2025 15:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaQRXl47"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D7E2E1EED;
	Thu, 21 Aug 2025 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755790905; cv=none; b=XvcV6e7ISM5iCfsFh73OUoqnAKMViksP7/swmBfQL7eHLPXgSBXVQlSpHmwPEM9DqbeM7OTcVe59YJ4r7qcYWsvJ5wOitT0hQ+UN4R+F3BLHs6Qf/OSk26x4vx8cVeqEpVAHnTWV6xHUZ6jXwL1fU0ye9vQiqAqzgCgN27MibGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755790905; c=relaxed/simple;
	bh=eLbEBiDu1MZJa026cfCMrZqnpkrJBLHiwTu8FT79kCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SrAZY4FdRNFvC0+vn1pwqJrldISk+MpXOMDvAKg4+PYDch5f5l1s8gfAoBVNvpgP6AKpq4ETMGkRtCWKRFNiIh146rNVkvgWODNto6d7Jjml9d6TO6fMe7nBxA0m8qWqBxtLzs4ZKAcC6krL2kCpIYNkhOqH5R+fJuiMJ9VE6O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaQRXl47; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD37C4CEEB;
	Thu, 21 Aug 2025 15:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755790905;
	bh=eLbEBiDu1MZJa026cfCMrZqnpkrJBLHiwTu8FT79kCg=;
	h=From:To:Cc:Subject:Date:From;
	b=QaQRXl47wr72dyvk0iYUkS5wz3kzmaBP64seexFNa8T1bfwv0wM6wx9KQtU6DirPU
	 zhws/2Bm4l8qGRI12DTetFaY3xhg9fq581QU9I3pn3sb5lvJ5hhKqKtwcCQolbcJfH
	 Ur184hzhGccHstCgFR9ClmBjweG1M5rVe0gQFJCqAAY0Frpe9phM+Kinb2mUPizKcu
	 xipAvGfMZojrbJrrHlYBhIPM0bts+dztspegRelR42bWfaU7mhEzjDnJlq4MWymGWX
	 REFgJ6/aDNXHlCOVBEfhT76UCDakVr2wqvpWp1JFHIS298Gz2p0ZGsc4l0Y3A9Ikyz
	 VJXKXUuZqv68w==
From: Jisheng Zhang <jszhang@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 0/2] clocksource: Support ARM SSE(Subsystems for Embedded)
Date: Thu, 21 Aug 2025 23:24:27 +0800
Message-ID: <20250821152429.26995-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is the ARM SSE(Subsystems for Embedded) timer doc URL:
https://developer.arm.com/documentation/107610/0000/System-timer-components?lang=en

Although the IP is mostly seen on MCU SoC platforms, but nothing
prevent it from being integrated into linux capable SoC platforms.

The IP core may have a system counter to generate timestamp value,
a system timer to raise an interrupt when a period has elapsed, and
a System Watchdog to detect errant system behaviour then reset the
system if a period elapses without ping.

The differences between this IP and arm mmio arch timer include not
limit to:
1. The system can add the timer frames as many as it want, I.E no
up to 8 timer frames limitation at all.
2. The IP supports watchdog.
3. physical timer only.
4. The system counter can be exposed to so can be under the control of
   linux.

Patch1 adds the dt-binding doc for it.
Patch2 introduces a clocksource+watchdog driver for the IP.


Jisheng Zhang (2):
  dt-bindings: timer: Add ARM SSE(Subsystems for Embedded) timer
  clocksource/drivers: Add ARM SSE(Subsystems for Embedded) Timer driver

 .../bindings/timer/arm,sse_timer.yaml         |  90 +++
 drivers/clocksource/Kconfig                   |   7 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-sse.c               | 540 ++++++++++++++++++
 4 files changed, 638 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/arm,sse_timer.yaml
 create mode 100644 drivers/clocksource/timer-sse.c

-- 
2.50.1


