Return-Path: <linux-kernel+bounces-779868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EC8B2FA87
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCC8B16942F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D132333768C;
	Thu, 21 Aug 2025 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFlrrDYk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E673375C0;
	Thu, 21 Aug 2025 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782979; cv=none; b=H3OBRPAeHUJFFeDKoi4RjJPjHm+55dAMExAxmv6iUTUTPt6xHf3pnruckIzttqm8WUO1In89BWI6sWWnzlA0G/6YOy4U1dU1EzB7kd5MRk6aXedWrWAFK2Wd9cUMFNZLiJCfCKWwLt5tvQ7FAMDxotj8xI8sYAZGyQbOJu5Ntuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782979; c=relaxed/simple;
	bh=4lsn6zYQJrvb7f4Ds42ABsF1Tgx+YnLe14EVYJURbf4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UXqW0A4dr6kuo76Q9sY01ykPUNPqOonZKSHj3dVhXyLpoKWdbdtpThjdsY2qYyf5BBdPigDh62QJfL8aRVwOaWLXN9vXZsV4cJ56ANR4guw5DLZg9+/TlwT9gsC7DUmqBijI7R1xAPYpFMBjMuD5ziPeyP7WDku/qCsI0NRM/5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFlrrDYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CAEC4CEEB;
	Thu, 21 Aug 2025 13:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755782978;
	bh=4lsn6zYQJrvb7f4Ds42ABsF1Tgx+YnLe14EVYJURbf4=;
	h=From:To:Cc:Subject:Date:From;
	b=cFlrrDYkAa5RI82Aibh3oOTFJJUwpJAnbeBK8ZlUveuAF5lpXvtZkOFrIQ8G36aph
	 B1mHna8bFKp7d/W+Y/HC/L0iBVQYjc5fkXMOguDnO92Fjij5fgcQem31YfI7Bt8cCE
	 Ekf9Pam2R0uvLRrZLRVxnLs6s0hflTa0qg0I1+8rvVEpRiiOUZTmjVaF9ClIIGqQIi
	 egaUTDBdrm7gM8w9sbCjXIvew9GZteuyCXw+K6rME3MkHvj5IYT4GluPppTeqGdQyB
	 zAk69i6F8TAY8sA0XkRjxIJxaZd/a7oQCAXVAnmIvkviPs1Oz46y6/O2i4IvEfikyR
	 AyHcDNzaYiAEg==
Received: by wens.tw (Postfix, from userid 1000)
	id 48ED65FC7E; Thu, 21 Aug 2025 21:29:36 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: linux-sunxi@lists.linux.dev,
	Andre Przywara <andre.przywara@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: allwinner: t527: orangepi-4a: Limit eMMC clock to 75 MHz
Date: Thu, 21 Aug 2025 21:29:35 +0800
Message-Id: <20250821132935.2070398-1-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

The eMMC on the Orange Pi 4A doesn't function correctly at full speed
of 150 MHz under HS200 mode. Either the traces on the board or module
aren't great, or the SoC's internal delays are incorrect. Tuning the
pin drive strength did not help.

After some experimenting, 75 MHz was found to be stable enough. Use this
as the maximum frequency for now.

Fixes: de713ccb9934 ("arm64: dts: allwinner: t527: Add OrangePi 4A board")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts b/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
index c52d09cf0888..fb5311a46c2e 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
@@ -160,6 +160,7 @@ &mmc2 {
 	mmc-ddr-1_8v;
 	mmc-hs200-1_8v;
 	non-removable;
+	max-frequency = <75000000>;
 	vmmc-supply = <&reg_cldo3>;
 	vqmmc-supply = <&reg_cldo1>;
 	status = "okay";
-- 
2.39.5


