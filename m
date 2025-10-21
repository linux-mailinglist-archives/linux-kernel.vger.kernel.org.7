Return-Path: <linux-kernel+bounces-862334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C51BF506D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19F0F3B9FA0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127A628689F;
	Tue, 21 Oct 2025 07:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="GjKO6I/Q"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A892B2737F9;
	Tue, 21 Oct 2025 07:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032612; cv=none; b=oPB+RrHux/ZYMcTwQZZSKwpxUtMPzB37JleNhhYo3EZ6JTTUtbbUsZJqw3e2i5jrrIdfaMwjVeUT0iZUFlg1M/oFDgRFr2EYB1FqZ2nLoYDGvnyLBfXyhVjkgKZ6Vyb2/AukWZlNSxIXFnUW1Tgy0ajNl/0bMBAoZvQNviTEYlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032612; c=relaxed/simple;
	bh=jXO+Z9cay6NBb4TGsVmXYrxowCv+RGpq2iO/X+EF+F0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dc2UqevxqGU7sWQUTKt8/AMkNQjAOYUVb35BKvedGwMp+EB5E/6GbYOmUajBZCp9PUOXGIjb3Td2vUov6uHAKnUxSCYeCosEJjYNNzUjYktx36UXbLS5IZgPZE64OC8Wmvn9M1RygF4xHJ2nlxfH+1A3HOIsF/qTfsMZxWPtmZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=GjKO6I/Q; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=oU5xEPT8aEVLQudNuyzuo82/ZEcqDr2Z0zwtb+h3Wiw=; b=GjKO6I/QtwVjj13ledu/xMmPUe
	ZV6r46SGUe+AyFZb1Vv+LsGdd54kxGePylhi8/PAUCAXHYYr0JnYXQOcFAlt3BZI2rDYxVwYTpVL2
	MZsCyiaYbPRbghR5YnbrEEJ6jRulARZZyjEa2TK2uLgQ/6OWKYIv+qMyCjnJSRFvuROnItkj7nDRk
	O8nYDAOGe1MbTlD90KH37JZjOqWG7vI4kL3XGVq4ld4IEHgfWTjyItBz3NjiFHqHIStJ2wsoSGeTf
	rd3WlKeWoZlz54wClaKPlxoseWUdGzlk+/gYnia8zEJEfCSz60AP34kIWVAYi3YOyiCdMkb36c7Zj
	GHfIdC8A==;
Received: from [212.111.240.218] (helo=phil.guestnet.ukdd.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vB71N-0000uy-OF; Tue, 21 Oct 2025 09:43:05 +0200
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
	cn.liweihao@gmail.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH v2 3/9] soc: rockchip: grf: Add select correct PWM implementation on RK3368
Date: Tue, 21 Oct 2025 09:42:48 +0200
Message-ID: <20251021074254.87065-4-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251021074254.87065-1-heiko@sntech.de>
References: <20251021074254.87065-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

Similar to the RK3288, the RK3368 has two different implementations of
the PWM block inside the SoC - the newer ones that we have a driver for
and that is used on every SoC and a previous variant that was likely
left as a fallback if the new one creates problems.

The devicetree is already set up for the new variant, so make sure
we actually use it - similar to the RK3288.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/soc/rockchip/grf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/rockchip/grf.c b/drivers/soc/rockchip/grf.c
index 344870da7675..963cdea01ce7 100644
--- a/drivers/soc/rockchip/grf.c
+++ b/drivers/soc/rockchip/grf.c
@@ -91,6 +91,7 @@ static const struct rockchip_grf_info rk3328_grf __initconst = {
 
 static const struct rockchip_grf_value rk3368_defaults[] __initconst = {
 	{ "jtag switching", RK3368_GRF_SOC_CON15, FIELD_PREP_WM16_CONST(BIT(13), 0) },
+	{ "pwm select", RK3368_GRF_SOC_CON15, FIELD_PREP_WM16_CONST(BIT(12), 1) },
 };
 
 static const struct rockchip_grf_info rk3368_grf __initconst = {
-- 
2.47.2


