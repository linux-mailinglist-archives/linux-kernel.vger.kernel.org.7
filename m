Return-Path: <linux-kernel+bounces-862335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB6DBF507A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD7418C4E16
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A145628B3E2;
	Tue, 21 Oct 2025 07:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="XSIgqbQ8"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBC724678F;
	Tue, 21 Oct 2025 07:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032612; cv=none; b=KqhckBJXBjjCtI+Mne6IYV10gD6Kznr7FqarnaTGXClCWdqlpJgzm8gkjDNVQX1eSKh1krxWw/yEsGPx+KmPKVIQDUILWDAdJR0glP47Ylmja/Tj9L4CCeuMI5HdB4JcwjEvIFbQ1NTHx3irkBUkkSkRkZiIWeF/nw+ezt93SKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032612; c=relaxed/simple;
	bh=UEyms7NO0DBfcmNP+ZmCya+I8AxDdvyi3vjgJEnzqtM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PsRCLKzIqC3Uv7O8OWTPnhp/8gOBmZjASqbw9xC0Vf6ij7dvq5vJu89Bvk7z5HVLF3cB1YQjqXFigHql35Ju9Zdo52mVrZtohJv5kFRnRyjrUCiti6aD/4nl8DQ5Xn5EA1aMCf6Rn72JznUwnrTQyZUipgPsR6FJT6n178YWh5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=XSIgqbQ8; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=UxK1OP46sV11zbhWQ+0/zP7tImTHzu011gOU5DK+oxg=; b=XSIgqbQ8NchDx3T8OcaMUkhoS2
	Ql52y6+JPPw8y/0PzCt+36TBG54fvqr7vQmQcEbGB3X6iYlpgv5HpLlqKo7TIE9FX4FOu5bh8cHk2
	wa/yDCXV8GCgC8RN2z8GU5wqw+vdr5ZfmrV0m5AM7wO4LizdR5SLXEbUDQ+jom7RkSnyaJOpLMX2g
	6QYDmIh/aXNzPd8cBJSFnhjqVBejlIxeKYfAYqFAVYvfgpKVFJBz2vT7v6aVmGLrLnDRZ+wyWcTbL
	A2kvYtJYWrOSjSWbxijjZ5QNCa7Li87XIrXjtbnU4iQ4wEjCPXc0ZzTstz7TyI/s6pVxwesA6jP33
	ahp/mnhA==;
Received: from [212.111.240.218] (helo=phil.guestnet.ukdd.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vB71M-0000uy-8P; Tue, 21 Oct 2025 09:43:04 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	quentin.schulz@cherry.de,
	andy.yan@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	cn.liweihao@gmail.com
Subject: [PATCH v2 0/9] General RK3368 HDMI support and 2 outputs for RK3368-Lion
Date: Tue, 21 Oct 2025 09:42:45 +0200
Message-ID: <20251021074254.87065-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds the necessary bits for HDMI output on RK3368 and enables
this on RK3368-Lion. At the same time, use the recently added DSI support
to enable the generic Video-Demo-adapter as an overlay on Lion as well.


The reason I'm shaving this Yak is that the recently added DSI support
created DTC warnings about a single endpoint with an address.

So it was either removing the @0 from the endpoint, or adding a second
output option :-) .

changes in v2:
- pick up Conor's Ack for the compatible
- fix the spelling errors reported by Diederik

Heiko Stuebner (9):
  dt-bindings: display: rockchip: dw-hdmi: Add compatible for RK3368
    HDMI
  drm/rockchip: hdmi: add RK3368 controller variant
  soc: rockchip: grf: Add select correct PWM implementation on RK3368
  arm64: dts: rockchip: Add power-domain to RK3368 DSI controller
  arm64: dts: rockchip: Add power-domain to RK3368 VOP controller
  arm64: dts: rockchip: Use phandle for i2c_lvds_blc on rk3368-lion
    haikou
  arm64: dts: rockchip: Add HDMI node to RK3368
  arm64: dts: rockchip: Enable HDMI output on RK3368-Lion-Haikou
  arm64: dts: rockchip: Add the Video-Demo overlay for Lion Haikou

 .../display/rockchip/rockchip,dw-hdmi.yaml    |   1 +
 arch/arm64/boot/dts/rockchip/Makefile         |   5 +
 .../rk3368-lion-haikou-video-demo.dtso        | 174 ++++++++++++++++++
 .../boot/dts/rockchip/rk3368-lion-haikou.dts  |  36 +++-
 arch/arm64/boot/dts/rockchip/rk3368.dtsi      |  45 +++++
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c   |  16 ++
 drivers/soc/rockchip/grf.c                    |   1 +
 7 files changed, 268 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3368-lion-haikou-video-demo.dtso

-- 
2.47.2


