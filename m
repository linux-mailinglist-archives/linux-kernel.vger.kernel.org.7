Return-Path: <linux-kernel+bounces-751740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED9FB16CE9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9726B1AA6FFD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DED29E0F0;
	Thu, 31 Jul 2025 07:51:20 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFB029DB81
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 07:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753948280; cv=none; b=H0sve0aAeIFyxNheeockcX13c4djL7B1Dm6lsaIKoEUfykOuKjO1+/7aZEonoIKg9Dd0SE4KyEce3myeUhznOLboyoo1ENYO/KmZ1PbEijbVszZQEjaYBNJugPjR2iD0CnIr+cs94sUToQ2JslBNpVF+aNA0lZsSH8zQnbFFDl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753948280; c=relaxed/simple;
	bh=oHvbDT7BnL+h0yB72dGWsqdFY4GTnQsP5Yt0ose8xOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aiGVdwMWyJhBRznMMFnMaMUwe08t4opPLpIp2TxV2G3+DO+rr/y/ptRgV7J2M1ke7iDqmcsotoF1E54ryp/tsJZk9Y2X4K5tcybIEKyQWKx9ik3w0FuJIcJoojTWbqyQbtHD0O0MYXzjf0x+12NlvDcgSab0UWZOOsIbGHSVx2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C16EC4CEF5;
	Thu, 31 Jul 2025 07:51:18 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Juston Li <justonli@chromium.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] gpu/trace: TRACE_GPU_MEM should depend on DRM
Date: Thu, 31 Jul 2025 09:51:13 +0200
Message-ID: <43ea77e79722abf6c16c3c7b59b25453cc88a4c6.1753948197.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GPU memory usage tracepoints are only used by DRM GPU drivers.
Hence add a dependency on DRM, to prevent asking the user about this
functionality when configuring a kernel without DRM GPU support.

Fixes: 5d95cbf21a4a550f ("gpu/trace: make TRACE_GPU_MEM configurable")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpu/trace/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/trace/Kconfig b/drivers/gpu/trace/Kconfig
index cd3d19c4a201c9c6..7f405ce7df5a0a42 100644
--- a/drivers/gpu/trace/Kconfig
+++ b/drivers/gpu/trace/Kconfig
@@ -2,6 +2,7 @@
 
 config TRACE_GPU_MEM
 	bool "Enable GPU memory usage tracepoints"
+	depends on DRM || COMPILE_TEST
 	default n
 	help
 	  Choose this option to enable tracepoints for tracking
-- 
2.43.0


