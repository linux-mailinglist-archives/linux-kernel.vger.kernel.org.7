Return-Path: <linux-kernel+bounces-801466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E7BB44549
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A631C86D96
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D088434320F;
	Thu,  4 Sep 2025 18:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KPJKlM5y"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CEF342CA2;
	Thu,  4 Sep 2025 18:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757010374; cv=none; b=FzRhO++pym0v4rhhmk81HeQXFNUHgbJZSPrvEK/q6glPsMSBpPRP3Sy3ggUrRNTfwDWRxGpk0hvAAP74399u5MzuzqitVF+7L9tXjGLpNa/KQTHS3TAaq77FycEbcMqSJWvBydZe2UcbnhVOyP/N8pNUoCXTyAeNVYP4M0uo5tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757010374; c=relaxed/simple;
	bh=ue2HZsrzJ48NxpTsNI06KWQFI1W2kpk23BnWEwgmOz4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Pz25Mjxy3uRzzB/YP/A3R1bCdokSMmNEKd94rdHeRXBu2uDZ8q/rHGqfEiOL+LJLberoSEXDaAjSpqJMMsgGFR57ZM+w+tuTubpQgjSktGFlhszR/UpbWixIDFglUHLTbHunRv93NuuAeGmTYxJkIHQNrN2KE9uqP8hC2scQLT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KPJKlM5y; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757010370;
	bh=ue2HZsrzJ48NxpTsNI06KWQFI1W2kpk23BnWEwgmOz4=;
	h=From:Subject:Date:To:Cc:From;
	b=KPJKlM5yFrpBwNgauz48FGg4mkpglun08kHm53tHHhLcD5IhmPPOLXCJiPWWgE6DK
	 jTySAO1W2oL7BAEF4EwEGvUZJfzLFgTZj+7HBRphTO3XKjYUxurqd+GmI/YqtJkkb5
	 AOumdPydE2igzGRmIQbCK1wwlveHdqWo+9EAwvHG30XvYpsag0awo9bjhfkjonz+Hz
	 c8NvfqPIl41V6XD5F56jIWRs+LTOAvyz/htv4rsjWo+q0zFIzVEc+mSC3/IDURtk10
	 +VGEde3PCx71d1JcdTXDj1L1tR1Wl+tZ9Kve5KxXFPg7IF1dBNXIahVYHGetaBKKp7
	 5/LdPZJS5O60w==
Received: from jupiter.universe (dyndsl-091-248-191-002.ewe-ip-backbone.de [91.248.191.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9346C17E07FB;
	Thu,  4 Sep 2025 20:26:10 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 3D4CE480044; Thu, 04 Sep 2025 20:26:10 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH RFC 0/2] arm64: dts: rockchip: add USB-C DP AltMode for
 ROCK 5B family
Date: Thu, 04 Sep 2025 20:26:01 +0200
Message-Id: <20250904-rock5b-dp-alt-mode-v1-0-23df726b31ce@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALnZuWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSwMT3aL85GzTJN2UAt3EnBLd3PyUVN2U5LQ0I4NUC4MkgxQloMaCotS
 0zAqwodFKQW7OSrG1tQChbSTTaQAAAA==
X-Change-ID: 20250904-rock5b-dp-alt-mode-dcff20e80b0d
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Frank Wang <frank.wang@rock-chips.com>, 
 Zhang Yubing <yubing.zhang@rock-chips.com>
Cc: Andy Yan <andyshrk@163.com>, 
 Maud Spierings <maud_spierings@hotmail.com>, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1363;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=ue2HZsrzJ48NxpTsNI06KWQFI1W2kpk23BnWEwgmOz4=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGi52cLKcwSgQR0lM413kTDNqbzI2wLxmMTyu
 SSSzVYhPb9qGYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJoudnCAAoJENju1/PI
 O/qaCC4P/14YdPKAJ87PxwrFQqDmQc2KpPGrS7UMcqZ/n0aURdjNKF6UVR/BmtP0sBtEmQG1YUg
 L5mES0CBAYF6Ruw/ZMrfy0Ac7AYcE0dn9HnlexyKVZG6sMLUa0sdK7r5X3+S7D310dfDUzZs7hW
 OAvIxjFmWEsLVcbTzNi2iiwvQrkPLSsHHpdzfMR6aQuzI80kwAWTHC3qbmnnd89W4WhEr2OyNuC
 ZDT76XrhV+z30mUJ186hcFB/cBgmyhhU710RcYa1HWLmnc+oen4JqFjz41NpFtwek40ryS1ClHM
 gNoTCnsALQxC1dNgWORUT8T8ZtEv1qce2d1xNPCm9EW6e7QfIswIe1PE/RWFfD6wW2jLwkTTlag
 nv0KgkLdUHWm9819r6nuKkShwpD2YjO7HrRYdGChIfsgwFzpEd3kRxzcuor8Av1VWOm14x1JXvP
 u0YOeKCZG7QMv4/ovJhrdzV9Fx+2hyePOgm6yJzKsuk4qeKTZLtdCPZQUwTFiSY8RqQ6jLgC7ZO
 bfy/7MtISegaQU+hYY5Sys7wmTbmmqUL0Fv44bj83oLeqoN+7BGy5IX2inmxjqdhaa4qN7jsHGV
 B/vSR+NVlor3DHZXrBr007kVoB/Am17HifsaGaRWY0vNd4TyH/nqRloPCsV3LeOy6fOQVL/i4M4
 aenlHftrfQWaCUsvK/F03OA==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

People started to become impatient regarding USB-C DP AltMode support on
the RK3588 platform now that the DP controller support has been merged.

I'm sending this as RFC for now, because

1. I'm not sure if the binding change for rockchip-usbdp is considered
   an ABI break. As far as I can see the Linux drivers don't need any
   changes and combinations of kernel and DT should work. At some point
   the kernel might rely on the new binding for some features, though.

2. I've noticed USB-C DP AltMode only seems to work when the cable is
   plugged after the system has been booted. My guess is that there
   are some issues with the Rockchip USBDP PHY driver, but I didn't
   have the time to track this down properly.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
Sebastian Reichel (2):
      dt-bindings: phy: rockchip-usbdp: add improved ports scheme
      arm64: dts: rockchip: add USB-C DP AltMode for ROCK 5B family

 .../bindings/phy/phy-rockchip-usbdp.yaml           | 23 ++++++
 .../boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi   | 83 +++++++++++++++++++---
 2 files changed, 95 insertions(+), 11 deletions(-)
---
base-commit: 6cc18e940db6731556843b7fa2924eb2efcef53f
change-id: 20250904-rock5b-dp-alt-mode-dcff20e80b0d

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


