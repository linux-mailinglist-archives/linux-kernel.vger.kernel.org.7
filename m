Return-Path: <linux-kernel+bounces-742138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BF8B0EDD3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA438189ABAB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D9E283141;
	Wed, 23 Jul 2025 08:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="cpXcXHC/"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D182820BA
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 08:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753261042; cv=none; b=Hl8Mgmj19H8kaVEzB5Hwb7XJPohl3kFRSBy97kkheSX9D5dMe/cnkYTTV9JkGNy44R4hBDNFTE3qhzBVe1CG5kNovKbOAmLpw8cstDlrwrP/vPCiism7feHB+JBhFsxagtDjOVs3aZbSEY9RduvxcXV4FiDMaOFnC2GYtayAib0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753261042; c=relaxed/simple;
	bh=ZHY/h59tAbqK/0wbesbk+X7El4NFH8OPaCa2ytpNm6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=saH00wmPD8Y7BKPu+e2lJqm3uIRgS6Q3pHJWyKEhKmqCtybIzKMGK2Y9sH5jVgNaGKA/HDVSGl9uVeNbiD04ZT84EIddiZTlPMAjMLOXjtw4qA3ZTDB4BwoDL9SQtlsnOQ6bHhGrm6c0EOAN0LL64ClVOBRl6CtsoXjcJTay0LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=cpXcXHC/; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1753261039; bh=5pA5ShgQgZcidUsbKYIv6FiytemMQ/qpkIyWSNUV9Dg=;
 b=cpXcXHC/8CVoXnxqYDyGMTbHTq4+OGpzRRnVvqbK6Ta+khVYuKAEHVThiyFmGzCaghG/Oa4Bo
 3ZOAaHzkLO++WiGcseJmbqf+8ZMvKCKWOm4pnPittp8ahWync2llfbkeH+BZWk9xSqcp+jamaVt
 1cJBmzvTvvNce51FqxFvRzmJI/yju9Eizk2Cg98yRLO2Arf2YuPB0mvXx05XOQL4MRerwZBsh28
 CwFcCrKKeoV5wBYIarfIQwKvLuwzwAHqIBxtgKXAwwfItpi2YdkQyxanQZAZ/GMnmpaU08D3lKR
 k2D66oqVePCzfSPCrNLAt5YbHZqBnLtOpBFB6UBd7vxg==
X-Forward-Email-ID: 6880a3e9144dc4a5e5baee32
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 3/5] dt-bindings: iio: adc: rockchip-saradc: Allow use of a power-domain
Date: Wed, 23 Jul 2025 08:56:45 +0000
Message-ID: <20250723085654.2273324-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723085654.2273324-1-jonas@kwiboo.se>
References: <20250723085654.2273324-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SARADC controller in most Rockchip SoCs are part of power domains
that are always powered on, i.e. PD_BUS or PD_PERI. These always powered
on power domains have typically not been described in the device tree.

Because these power domains have been left out of the device tree there
has not been any real need to properly describe the power domain of the
SARADC controller.

On RK3528 the SARADC controller is part of the PD_VPU power domain.

Add support to describe an optional power-domains for the SARADC
controller in Rockchip SoCs.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: Update commit message
---
 Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
index 41e0c56ef8e3..f776041fd08f 100644
--- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
@@ -47,6 +47,9 @@ properties:
       - const: saradc
       - const: apb_pclk
 
+  power-domains:
+    maxItems: 1
+
   resets:
     maxItems: 1
 
-- 
2.50.1


