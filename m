Return-Path: <linux-kernel+bounces-803619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E136B4630C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 072323AED4D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DC0233145;
	Fri,  5 Sep 2025 19:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juszkiewicz.com.pl header.i=@juszkiewicz.com.pl header.b="7FZXBHoR";
	dkim=pass (2048-bit key) header.d=juszkiewicz.com.pl header.i=@juszkiewicz.com.pl header.b="EY3Rm5jg"
Received: from haruka.juszkiewicz.com.pl (haruka.juszkiewicz.com.pl [185.243.53.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8DF315D47;
	Fri,  5 Sep 2025 19:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.243.53.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098924; cv=none; b=IfYqTsEbyWkovM0/2KkjtfPM+6ElYNppnAW3IeXfgqFkl8xMsHf50PFbHxOVkwG5pmlA+DuHQLAbDNPRnHerRdE5rf9UhPZkv28KUrAZR83aiJqD0Cp/IY622Baiq1RWeea69kmIwrasPfocZ5Q2sXDzHgy9jbgS7qfiKQWqWIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098924; c=relaxed/simple;
	bh=OajqByBsH5OPlXRdcq8gSwhpir9mkJFlhq+DtZdjgdI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KvneUm+g7h+93t901nvA+fU8/XH08LmVfrDsJJBqHM3D9gC1JYmG9UULdQ7XJAmiz5ZcnamGLpi/560WEN5fVG+3vpEweP7idsBzKLukiZk8boozSAYVbldU2cLHoFCc917iz0wDrbU1/hqfw3EVgEi9ywJrpqkEHyI3TuRKYD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juszkiewicz.com.pl; spf=pass smtp.mailfrom=juszkiewicz.com.pl; dkim=pass (2048-bit key) header.d=juszkiewicz.com.pl header.i=@juszkiewicz.com.pl header.b=7FZXBHoR; dkim=pass (2048-bit key) header.d=juszkiewicz.com.pl header.i=@juszkiewicz.com.pl header.b=EY3Rm5jg; arc=none smtp.client-ip=185.243.53.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juszkiewicz.com.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juszkiewicz.com.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=juszkiewicz.com.pl;
	s=mail; t=1757098920;
	bh=OajqByBsH5OPlXRdcq8gSwhpir9mkJFlhq+DtZdjgdI=;
	h=From:Date:Subject:To:Cc:From;
	b=7FZXBHoRYSwGBBrBLCOJJADr8bmZs3LwZrIyKHRnc+7sk7nlQPIdl6Y/dF9MKAr7O
	 7Vsp6FUout0+mrDKRKNtlNGK1YTsaTNUO1K/lJ3lWxB0Lv25OMHQZ9FNYfaervecMq
	 eWialhNQm7+AeO5PNvijdXMbJ7dzD/fl2vI5E7Av1u90U7ms244lZEtBfogU/lOgvG
	 Vhk38sDyZOgMO3kUK4h17jigh8t+CGEv5hfKbpCIZBqsqgdrquZCcP8s/5HPXOnraN
	 f6qcBZ3JTpEC+LHP4qhhW9Z4X2sfvf5es4bgeAaYXFbKyaOyLNAzy8Mfd+i9Ar2qV4
	 pBfBuO6C5ufUw==
Received: from utena.juszkiewicz.com.pl (utena.juszkiewicz.com.pl [158.101.208.177])
	by haruka.juszkiewicz.com.pl (Postfix) with ESMTPSA id 04B481FB29;
	Fri, 05 Sep 2025 21:02:00 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7AF3545439;
	Fri,  5 Sep 2025 21:01:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juszkiewicz.com.pl;
	s=mail; t=1757098919;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=B1gRGSjw2aAAw0vLwu9XQY6YhFjjAP3pnVdOLPu8WI4=;
	b=EY3Rm5jggcZGpgieNP9yQ8+ZMZ8Hh1diTRhlS961pP4bMMQgbMgIcP6GiDK7O8Esa7Mk9Z
	924TAdvAKfcMbLUzGnPLwxraSHFmTsHOkiDc2+fdT/i3YHOrfyi+KB+7QJ9w02U9iXelkx
	QgEgiAMDOzVc0yDUWW6q0SkweWbUIuNlxg4uw9bhRUo0oqe5kHdDfIIgdPzZ0CEtD7FhXT
	KTh6X2BQMR7F9LJQpSFjZ79nsKUrqFplRWoGglLS3gPXLEWHqkUDSjHzGf9YqOaLgNKJnK
	pp1CNjAVYdyVFpIh6ipDbGikj1XZF5A+V5NNzoroQeyo9qoeDWE29K2UtDklng==
From: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
Date: Fri, 05 Sep 2025 21:01:51 +0200
Subject: [PATCH v2] arm64: dts: rockchip: Add vcc supply for SPI Flash on
 NanoPC-T6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-nanopc-t6-spi-nor-v2-1-098b476d9509@juszkiewicz.com.pl>
X-B4-Tracking: v=1; b=H4sIAJ4zu2gC/x3MQQqAIBBA0avErBsQIaOuEi3CGWs2o2hEIN49a
 fkW/1conIULrEOFzI8UidphxwH8dejJKNQN1tjJLGZCPTQmj7fDkgQ1ZpwNkSdnwxJm6F3KHOT
 9n9ve2gciHILRYwAAAA==
X-Change-ID: 20250905-nanopc-t6-spi-nor-70ddcd62f9f7
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

FriendlyELEC NanoPC-T6 LTS schematics shows VCC_1V8_S3 being used to
power SPI NOR chip.

This fixes the following kernel message:

spi-nor spi5.0: supply vcc not found, using dummy regulator

Signed-off-by: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
Message-ID: <1652891b3fd7e1d1a279a3eb0e7a05ac763e48fb.1757097941.git.mjuszkiewicz@redhat.com>
---
FriendlyELEC NanoPC-T6 LTS schematics shows VCC_1V8_S3 being used to
power SPI NOR chip.

This fixes the following kernel message:

spi-nor spi5.0: supply vcc not found, using dummy regulator
---
Changes in v2:
- fixed format of "vcc-supply" field
---
 arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
index 3d8b6f0c55418805c0d614a4d65f67b0c660ca0f..69833a0a94d0f18d9ca86005ac22e58f4c036fa8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
@@ -731,6 +731,7 @@ flash@0 {
 		spi-max-frequency = <104000000>;
 		spi-rx-bus-width = <4>;
 		spi-tx-bus-width = <1>;
+		vcc-supply = <&vcc_1v8_s3>;
 	};
 };
 

---
base-commit: 4ac65880ebca1b68495bd8704263b26c050ac010
change-id: 20250905-nanopc-t6-spi-nor-70ddcd62f9f7

Best regards,
-- 
Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>


