Return-Path: <linux-kernel+bounces-744979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B98B11338
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77A471CC850C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD9023AE66;
	Thu, 24 Jul 2025 21:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b="RKiwrIdP"
Received: from chumsalmon.baetis.net (chumsalmon.baetis.net [209.222.21.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C2123958A;
	Thu, 24 Jul 2025 21:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.222.21.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753393102; cv=none; b=EMjyzh6KJ6ixZozwoFwMAnYdJSuFlktA2KTSmS5/18jKZ46FHX1QwFIjTmb7DQPvcqHliBE2ojn3yBEgz82EsmiOsnLkMF1K4U04Nga1nedsY/51bK2jizUdNenh/fVIuocyBbFJFEE99wTE4++HSznfMWJOzlKoFh/TwS0q2E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753393102; c=relaxed/simple;
	bh=JeAGk6NYkvfPfqHLOr8TWn4GJgc1Cbdem6yu/9lIHzE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=er5Rw2LPfDvOpBMJGDgBqa2RayXScEtrlTyj4kVSUUVtslnANDs3G119WC+uzLOYT0pzCOQ3Z3nBT7E0/zm5+lvhPsV23MzJTurVBNcAHWwnK1s7RWyI+UiZe9QOY1iykQXppvhesiN1sfoLFnc0EDAVIe7NjKVVXRB92ZIdeHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tahomasoft.com; spf=pass smtp.mailfrom=tahomasoft.com; dkim=fail (0-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b=RKiwrIdP reason="key not found in DNS"; arc=none smtp.client-ip=209.222.21.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tahomasoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tahomasoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tahomasoft.com;
	s=default; t=1753393092;
	bh=JeAGk6NYkvfPfqHLOr8TWn4GJgc1Cbdem6yu/9lIHzE=;
	h=From:Subject:Date:To:Cc:From;
	b=RKiwrIdPJv9Ke91bak0N/Y5e+v8AR014Kf6u2TR9GCpbTU4u23emZMVhPWrLqIQ+u
	 BgQD94ilM7Uz5CHDRc67zPSHsTyejew61Va9AC3m7z4Gr/8QaCYSz/gX1nRRairsF7
	 caiM2welyTIINMO06sCFJfzL0MY3f2zxGiuZot4MGrDcvPWVbuBkDU4pBc4mmTspsM
	 25/cvEUMeFiSdw2Xr9frPF+9tQjufJeoIaLbOs8t9kppLNiyzSoRHwaCpTDyy15/cD
	 o+FrBI6JEJokwRC+HnsIOaT6u/V9zo1zSDWKE42C5XbnnQGx5G9gPEFo7qgWTFDFKc
	 LAwd20ZNUPjdQ==
Received: from localhost (unknown [IPv6:2600:4040:50b7:b604:ee41:bd43:23a9:712b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by chumsalmon.baetis.net (Postfix) with ESMTPSA id 3A7FC27E434;
	Thu, 24 Jul 2025 21:38:12 +0000 (UTC)
From: Erik Beck <xunil@tahomasoft.com>
Subject: [PATCH v3 0/2] ARM64:Rockchip:dts:dt-bindings:New Board:Seeed
 LinkStar H68K-1432v1
Date: Thu, 24 Jul 2025 17:37:57 -0400
Message-Id: <20250724-linkstar-h68k-patchv3-v3-0-b9f87b7306e5@tahomasoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALWngmgC/x3MSwqAMAwA0atI1gZi6/8q4qJqtEGp0ooI4t0tL
 t9i5oHAXjhAmzzg+ZIgu4vQaQKjNW5hlCkaFKmCKpXjJm4Np/Foy3rFw5yjvTSqjJqcKj0YaiC
 2h+dZ7v/b9e/7ARgPdDVnAAAA
X-Change-ID: 20250724-linkstar-h68k-patchv3-21094073ba09
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Erik Beck <xunil@tahomasoft.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753393091; l=2664;
 i=xunil@tahomasoft.com; s=20250724; h=from:subject:message-id;
 bh=JeAGk6NYkvfPfqHLOr8TWn4GJgc1Cbdem6yu/9lIHzE=;
 b=+ZDkbpa6vkxeOC0QJD/czLtJ9ist4dUPqRrGlDu34z70ELft/1ITo2EbcQ2hfzsmk22fAvIB4
 8efQNSeZWaPAV+koNyDwfnGKFNnHzhbPmVJo08FAswPC0Lurnon+FbE
X-Developer-Key: i=xunil@tahomasoft.com; a=ed25519;
 pk=FTZVGUexvkWb4j8v0wbtm7CtJLijIAaa5x0XV72WWC0=

Add Support for LinkStar H68K board based on ARM64 and RK3568: dts and
dt-bindings.

This patch series provides support for the Seeed LinkStar H68K-1432v1,
a compact travel router with four ethernet ports, four USB ports,
integrated WiFi, HDMI and audio headphone outputs, eMMC and microSD storage.

These patches:
     - Create a devicetree for the board;
     - Add a Makefile entry for the board;
     - Add the board to dt-bindings;

v3:
  Responsive to comments received from:
     - Chukun Pan <amadeus@jmu.edu.cn>
     - Krzysztof Kozlowski <krzk+dt@kernel.org>
     - Rob Herring <robh@kernel.org>
     - Heiko Stuebner <heiko@sntech.de>

     /* (Thank you all!) */

  Those changes are:
     - Removed copyright line of <amadeus@jmu.edu.cn> per their request;
     - Fixed indentations;
     - Replaced space indentations with tabs;
     - Packaging this patch set together properly using b4, fixing the threading;
     - Clarifying versioning and Changelog;

v2: (https://lore.kernel.org/all/20250721201137.233166-1-xunil@tahomasoft.com/)
  Responding to comments received from Heiko Stuebner <heiko@sntech.de>

  Those changes are:

     - Splits the single commit into two, one for the yaml binding,
       and the other for the board devicetree plus Makefile addition;

     - Adds other recipients needed from get_maintainer.pl --nol and --nom;

     - Uses git send-email to send the patches, to avoid adding line
       breaks from the MUA;

     - Changes comment style to conform with style guide;
     - Removes several unneeded comments from the devicetree;
     - Changes LED naming scheme with more standard nomenclature;
     - Changes naming of regulators, prepending 'regulator', such as:
        ~ from: vcc12v_dcin: vcc12v-dcin {}
        ~ to:   vcc12v_dcin: regulator-vcc12v-dcin {}

     - Removes unneeded tx_delay/rx_delay from rgmii-id

v1: (https://lore.kernel.org/all/20250718075058.243a5619.xunil@tahomasoft.com/)
  - Initial patch to provide support for Seeed LinkStar H68K

Signed-off-by: Erik Beck <xunil@tahomasoft.com>
---
Erik Beck (2):
      dt-bindings: arm: rockchip: add LinkStar-H68k-1432v1
      arm64: dts: rockchip: add LinkStar-H68k-1432v1

 .../devicetree/bindings/arm/rockchip.yaml          |   5 +
 arch/arm64/boot/dts/rockchip/Makefile              |   1 +
 .../dts/rockchip/rk3568-linkstar-h68k-1432v1.dts   | 740 +++++++++++++++++++++
 3 files changed, 746 insertions(+)
---
base-commit: c3b855b67143231dc4ce359936c882e6b71f8ab6
change-id: 20250724-linkstar-h68k-patchv3-21094073ba09

Best regards,
-- 
Erik Beck <xunil@tahomasoft.com>


