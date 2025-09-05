Return-Path: <linux-kernel+bounces-802525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4E6B45324
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CAE2188E2AC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731BF27FD68;
	Fri,  5 Sep 2025 09:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juszkiewicz.com.pl header.i=@juszkiewicz.com.pl header.b="06WDOYgs";
	dkim=pass (2048-bit key) header.d=juszkiewicz.com.pl header.i=@juszkiewicz.com.pl header.b="HnWatuYj"
Received: from haruka.juszkiewicz.com.pl (haruka.juszkiewicz.com.pl [185.243.53.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334014C9D;
	Fri,  5 Sep 2025 09:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.243.53.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757064515; cv=none; b=Jh0yDU2vyyirzV14jl9bxwtpjBNAyrMo9aVugC2NIk7Mk0fTj5MTnDfpmZwKISZwWFz1fwr/l1IRqNiGjtaZzTBDeftjJ8Vd/5bqDt7ikYEEmP/K1Fh9fbpHbQGafqYZ8ER2x4jeE4RzPcN3E7QV6lL21JlLN1ElKZBLgRU5poA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757064515; c=relaxed/simple;
	bh=KU82z1h5lc5ENlG359nM5e5o66V40HCTdLEYj9iSvTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NSmpYXD++AFgZihCUCCQSIlwh/h3eRRkRIQFk7Yovl48BpwUL+ANuoglrBrI6WBhfjIuXpI+TOKSki2fz0dDBYHItK+EDcMMfYmc9oFyitUwkCz2Jl2QrCU492KOB8jLdLCH4QJB8ozCG89L1cJIxF7U60C6yfNRW7yiRDlISUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juszkiewicz.com.pl; spf=pass smtp.mailfrom=juszkiewicz.com.pl; dkim=pass (2048-bit key) header.d=juszkiewicz.com.pl header.i=@juszkiewicz.com.pl header.b=06WDOYgs; dkim=pass (2048-bit key) header.d=juszkiewicz.com.pl header.i=@juszkiewicz.com.pl header.b=HnWatuYj; arc=none smtp.client-ip=185.243.53.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juszkiewicz.com.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juszkiewicz.com.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=juszkiewicz.com.pl;
	s=mail; t=1757063950;
	bh=KU82z1h5lc5ENlG359nM5e5o66V40HCTdLEYj9iSvTA=;
	h=From:To:Cc:Subject:Date:From;
	b=06WDOYgsa5jHjhmZpHkh7K8+d1bnh6ERsaO+qP/JPrp5I3tcjPtcsKIAf5uxHlpVS
	 zAkDXBqAY8RPs/qkr0SZRdphTspmrm+5KBuIsmbd+XlgpxiK+Cjshw4ft72ZSbUB1O
	 RKXoJqw8r9uMclaIpoyYOLW4cOrfphVP9HTtjTmgz4DKOZrEJ/q7yf0fHbFuYasi6H
	 26xwJQ4I2UBU6ZJTMUc82jTWhTNY45XcnuCN72kDW1JlhHhaiXi75K/RpUAf8l6Yxs
	 VJtUNgn7XQzP3jg9wrStCKRrXMVXjeZJBaA8Lls3kdAc+ehVF8M2rZ14jBRSNKtgWQ
	 wGO3Hswggos9A==
Received: from utena.juszkiewicz.com.pl (utena.juszkiewicz.com.pl [158.101.208.177])
	by haruka.juszkiewicz.com.pl (Postfix) with ESMTPSA id 0BB631FB29;
	Fri, 05 Sep 2025 11:19:10 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BF28045400;
	Fri,  5 Sep 2025 11:19:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juszkiewicz.com.pl;
	s=mail; t=1757063949; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=A4ZJp8Qib9+DD7lKkbek2dTcXjA+p73Zi5iXZ8SVeBk=;
	b=HnWatuYjas/e+bApgrJ9duKZe1mZPRTa2MbfZpGYPc1koomEtur3yUneu5GXXTuaKXvwHB
	wgD/PJ46dqt+6ROdqEyEPrG/jlAnysm5n6YZ4bX8MF9kSxf049h5UTE4GyW4CX7rotcEvU
	/aidztoi3mmPug2SS1LR8vKDULIzNRQTHAn+Ar6OH6TWTsgfcj56PPJSZ2sLPNJIhm0tH7
	qv7+LBHsBwrVfYsJ3Z+THszX0WUGUhHsNQ7qIxzvsN/PnrrFTFz3WjGnGfiub4UDYXJP6c
	EYgEuZ7ZJ08gduL70z/45BU5Qt55ZAHvn8XVTFXSNG9zCn9EROsQeeZpa3GPSQ==
From: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Add vcc supply for SPI Flash on NanoPC-T6
Date: Fri,  5 Sep 2025 11:18:59 +0200
Message-ID: <de71cbe5db3347756d3173245d01e091d3ad1b50.1757062843.git.marcin@juszkiewicz.com.pl>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

FriendlyELEC NanoPC-T6 LTS schematics shows VCC_1V8_S3 being used to
power SPI NOR chip.

This fixes the following kernel message:

spi-nor spi5.0: supply vcc not found, using dummy regulator

Signed-off-by: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
---
 arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
index 3d8b6f0c55418..e359d74f20885 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
@@ -731,6 +731,7 @@ flash@0 {
 		spi-max-frequency = <104000000>;
 		spi-rx-bus-width = <4>;
 		spi-tx-bus-width = <1>;
+		vcc-supply = "<&vcc_1v8_s3>";
 	};
 };
 
-- 
2.51.0


