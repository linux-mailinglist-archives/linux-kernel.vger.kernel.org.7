Return-Path: <linux-kernel+bounces-733644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0045EB0774F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 998A4565D15
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977AA1EF091;
	Wed, 16 Jul 2025 13:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNBtuim0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40011E3DE8;
	Wed, 16 Jul 2025 13:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752673652; cv=none; b=l5nzagf0DJaXonJdntH0J2ULg5mgOBKDHPeEk4PQMobFsAWg5Nu6qu/Er4Gjw0dCfprxOJXr1BBeAQN5OYdXzOJmSjoA9gUmfn/DHkyoz2uS5sisDvYHZUW5EyTQm2TYmyTZtSwX6b4AEZuT9AYBDT71Y+qzvvel49d7TpHNC7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752673652; c=relaxed/simple;
	bh=gmdutkgfIQniQfWFrKfQBe9pqVMRsWjopT4us94/R4s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R9hqoKWAZlRZWlK/z1WXVe16JwykSvd5AfGp3GG6cxAGJ3pVmcgWIe8F3R3YpUgZ5yeotFGF1C0JSQoZJxnBdcH5HhSmGc1pILp5dkMvjc3ZI7qoWWbXJxNAKR+mfFE89l7dWQ5f1YCuzeiHwaSY/x/f2H+apiYHc7s12ZPpfCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNBtuim0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E2AC4CEF0;
	Wed, 16 Jul 2025 13:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752673651;
	bh=gmdutkgfIQniQfWFrKfQBe9pqVMRsWjopT4us94/R4s=;
	h=From:To:Cc:Subject:Date:From;
	b=RNBtuim0eJlux30Hn+niJkRGONO1Ri9QpPMfiy8l4+53Xv32m5H2mySpMOT8XuiT/
	 vOnly7BJRGqqOGtAhXq1bVQjjlqC1HjtZ5C/C9t2/tD9H+Bk+/Yc8DzTAliBLe8MwV
	 SGmJf9t88fBEm9SXPgcZvN47SgOkcCzAkfZmpTbGEdkg7syA4s241wX8a175aGSl5o
	 iuZrQCYnN2+mSFoo2ewX+pPwAxijUc6lPjQ2D5QgTW128GICYiy6rIvCbrALfFy7Sj
	 XWNtDRn4kgN+xCZ7obi6R6awFR/nQGTlhd01QEC2ngrUAIO+/AmRJA/UmSx4zJNH9y
	 cw6PFBkvj68XQ==
From: Michael Walle <mwalle@kernel.org>
To: Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Michael Walle <mwalle@kernel.org>
Subject: [RFC PATCH 0/3] drm/imagination: add AM62P/AM67A/J722S support
Date: Wed, 16 Jul 2025 15:47:14 +0200
Message-Id: <20250716134717.4085567-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AM62P and AM67A/J722S feature the same BXS-4 GPU as the J721S2.
In theory, one have to just add the DT node. But it turns out, that
the clock handling is not working. If I understood Nishan Menon
correct, it is working on the J721S2 because there, the clock is
shared, while on the AM62P the GPU has its own PLL.
In the latter case, the '#assigned-clocks' property of the GPU node
doesn't work properly. Linux will try to set the clock frequency
before probing the GPU. The clock handling firmware on the SoC won't
allow that if there is no user for it. To work around that
limitation, set the clock again in the .probe() of the GPU driver
after turning the device on.

This was tested on an AM67A.

Michael Walle (3):
  dt-bindings: gpu: img: Add AM62P SoC specific compatible
  drm/imagination: fix clock control on the J722S
  arm64: dts: ti: add GPU node

 .../devicetree/bindings/gpu/img,powervr-rogue.yaml  |  1 +
 .../boot/dts/ti/k3-am62p-j722s-common-main.dtsi     | 13 +++++++++++++
 drivers/gpu/drm/imagination/pvr_device.c            |  9 +++++++++
 3 files changed, 23 insertions(+)

-- 
2.39.5


