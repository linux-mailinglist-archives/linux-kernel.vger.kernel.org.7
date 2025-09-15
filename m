Return-Path: <linux-kernel+bounces-817199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00276B57F2D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02A971744D1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE5D30BF64;
	Mon, 15 Sep 2025 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cm8h8W+N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7400B1F4CB3;
	Mon, 15 Sep 2025 14:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947005; cv=none; b=KqfyN5Lg9XSwOeBda3wMFOvtXZ4FX1P37Kh1U+4oMDRX6jGQm4tNA6hGB+jEUs7MTboqegH50b+EC4b5LCbmnL/dVGZFndIk39hDVzk2eDpR75RMy0HdfrzQ3IFBAnBueB+bkIvVAozCUQq9lhkvAGbrGe5zwauHLCcqms9s8k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947005; c=relaxed/simple;
	bh=RLaJFRiH9fUacA+g8XK++lLAVHNIs8PaxaaH9y0/D68=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H03nM/2XJ8NZtGlkzduSuP6wLJdhCc1OjNqz3d3mg0n5r2P8NOckEz/FsYIDDiiBA8c2Ce2JqOba7SSpR78J+fVPd3g/Zhum+8EpWqBHX+r6xmfXIwURL08kr7jbgtJbDWcWoefKNaCFvywACw2wYkczs1mexlmm33DeEIbkGWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cm8h8W+N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6236C4CEF1;
	Mon, 15 Sep 2025 14:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757947005;
	bh=RLaJFRiH9fUacA+g8XK++lLAVHNIs8PaxaaH9y0/D68=;
	h=From:To:Cc:Subject:Date:From;
	b=Cm8h8W+NHQQgUhYx7vuPgMU2GxX/rYcW6cDGMwdYtftGZM+ds2S4gGgbjvadMuJW7
	 uZz0cIIRb13Y9XNXQ2fP+Kbeai4RTWs9XFrsDSCg1QrqimGWm2f6C2u70A1bnccP7W
	 79OZAe5oGfLp6K7kRzxFjwwC4E5M/EOVJNlXODnpq7THhEyOk3D61bKy2eekpyWq2+
	 Pi8dbMS52WvF/SCwrCRDLI/0U7MZjzsMOT9x0Zh+rynSjKen3EDQbD/0PMk6cTqtOx
	 R/TzC+Tef7diO72p98ly74SUmGgETUy2IypawrudL66x3Uhe1XwzdDzLrdnKnHzGIH
	 tKTGhk0/3ltrw==
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
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Andrew Davis <afd@ti.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH 0/3] drm/imagination: add AM62P/AM67A/J722S support
Date: Mon, 15 Sep 2025 16:34:37 +0200
Message-Id: <20250915143440.2362812-1-mwalle@kernel.org>
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
In the latter case, the driver will fail with a WARN() because the
queried clock rate is zero due to a wrong cached value.

This was tested on an AM67A.

v1:
 - Don't set the clock to 800MHz in the soc dtsi. 800MHz is only
   possible if the core voltage is 0.85V. Just use the hardware
   default of 720MHz. A board device tree can set the 800MHz if
   applicable. Thanks Nishan.
 - Also add the new compatible to a conditional in the DT schema.
   Thanks Andrew.
 - Dropped the wrong of_clk_set_defaults() and instead disable
   caching of the clock rate.

RFC: https://lore.kernel.org/r/20250716134717.4085567-1-mwalle@kernel.org/

Michael Walle (3):
  dt-bindings: gpu: img: Add AM62P SoC specific compatible
  clk: keystone: don't cache clock rate
  arm64: dts: ti: add GPU node

 .../devicetree/bindings/gpu/img,powervr-rogue.yaml    |  2 ++
 .../arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi | 11 +++++++++++
 drivers/clk/keystone/sci-clk.c                        |  8 ++++++++
 3 files changed, 21 insertions(+)

-- 
2.39.5


