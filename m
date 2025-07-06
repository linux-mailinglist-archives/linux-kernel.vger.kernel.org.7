Return-Path: <linux-kernel+bounces-717717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E05E3AF97E2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 18:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B5CC4827D5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 16:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C812E0910;
	Fri,  4 Jul 2025 16:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="m8REOPak"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FE22DC328
	for <linux-kernel@vger.kernel.org>; Fri,  4 Jul 2025 16:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751645693; cv=none; b=qXlSclNJGyYBV6zXBlzGth+9+RsVQiW6Te4czvRrsLn1MSMeGAwEKCowqTEIhPFkBp2YQMbuMR4f7kQOAGhPS7PXwVu4R+rVMZE1fJJWoQH5lnOEMlKxeEJm6NkR7dDIT+HWF8+veRNfO86WUvdIrYp2NiiA2k4TYAMnIb1qKKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751645693; c=relaxed/simple;
	bh=gR9Wn5lFTL1dH5LwfqEgIlxPVfhpUTsJpw7A7wwQ7mE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FAiel8vEc0id8BbgBrmVQZIyFBHiMN/e27lWcp1q7y8GmRNihOBBefdLMACDGa8pwxvke6UuDXxJWDoQxOMDzNGPRwnKtYfWcKo6jv9+n+lp743pMaFhH/VazC+/i9Gvrh76sdzOfGnWnWncDJzuJ3rb6ZwclzfXc00I+C009eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=m8REOPak; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-acb5ec407b1so186011166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jul 2025 09:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1751645689; x=1752250489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkNu2VPdZ05H1WkOeVUqdreqBFI4sSTNmK5wwP9pjsA=;
        b=m8REOPakEYChY/mVGl38GgbbgXq8xyhEg1Or896sgrIw5Qzg1QW8elA6BNjvsChfYT
         UFLIQDjY1bXM3NbgpofiqjFzcJvWpJEsIzIZelVjooXtoBfKkHKY7FsTCHKeA8mwUpu/
         NOCQDWBd1vrZy61n8WxjirBvbk05J1Z9qph2yinwT/CdxV9eNucZFu7ljm3+nKXoZh6n
         J7XFM2c+NHh+B3QPw0E1fTXCbQvUQRuSHCxqmZRlfXjRZwgGNmdR9XKpo7kc/dv6GZ+e
         oXyMEpHgqwH/F7u4wbRgpRyW6kLmblDiseIaCrPuIqtWC7Ec4Sn9EVV0baoJ1UYM9+JI
         uukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751645689; x=1752250489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkNu2VPdZ05H1WkOeVUqdreqBFI4sSTNmK5wwP9pjsA=;
        b=TfyW0YuEj6LrUlzLum2+J8GrzWYP+K79N7wnUvsVTmqAV7izm824ZZnXU8xMBmVHXv
         nGT4GH541WVf0lXVApeN0hYfEVzJtoxueZuwgrlxtIyZVfv4w5TsUFFUKGLHuBqZ9k6i
         2u82QyVm2FZFbX961h5x8EiKp+rtn7ZUTp0f/nFR4yZsTKXcOZTt2xKB0/+QHqfACNLE
         2jzOCXtRECWs0KvLg/gjIe/zW2TGRpFpbE6KhrR4rVsIjW6EKzAGdNbcFtYKyHtXo8Kd
         alrdYx0xC3A4rqpfv3qdBO9gJhjl/SWmvmFYBn4fU/1NYHveMT5H0SABk2rFCvSLMa4r
         xNfw==
X-Forwarded-Encrypted: i=1; AJvYcCWJWkPQfU16wuODI0njyePJeFmZUW0dh4gYRGS50A7kdI1eJa6ihGRjLWR1cQkPgp9FfKTnKEVD6MRGe68=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC8DoNDFCxEVHmKnsthmWQHTm6s8iLKux+6+hrOMKXPjzZlvFv
	hmXSLU+M44162GIHUx9qlQ2t66PlIe1HGfJ4u5AAuoThbfNZl0so4odnbyUQUWbrQIc=
X-Gm-Gg: ASbGncuJL1uNhjCipGZPDSQgwsE2Ndc9oxScEKKkQ6vjhJRZU/oWenOi0k6exj8t6z1
	UT7G0YStSy/JV3Wg+vx7jMTPn/pM1oysX5ZRFNmqOUWp0Ca4TTRhC7wE9OZDBrTPWYOw6RWSm/L
	7CQRSv5lg07r/iCmDJfzLTodSCzOD4mljexaXiEDaTznzUjQc5zfsu9jgg0PCBx07SR9hYnMtfA
	e7UFvmUAQGrDdht8qvORzMvbDZWEs2MRYZviOCYAb2zT5ITqb06JsBKdaeHlZV+GmIZWTyJ3loh
	XhQR1XFR+rSLXNaTVdjNWtTG+1kKo02q50uwmbHPnqUSve/hn0qN4N4I+iX+k4m1dAp2bGqkxFp
	b2Xqe6z383Bj5fBY=
X-Google-Smtp-Source: AGHT+IF8OBJYopz78uTu4zjr9M4q7cZs8YsJ5lxwKzH9GFcsxUYxUdsvzpbrV/sgFDsSrcOtLDUf2g==
X-Received: by 2002:a17:907:3d0c:b0:ae3:163a:f69a with SMTP id a640c23a62f3a-ae3fbd13e86mr283273366b.33.1751645689346;
        Fri, 04 Jul 2025 09:14:49 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.83])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f66d9215sm194703766b.2.2025.07.04.09.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 09:14:48 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de,
	lizhi.hou@amd.com
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v3 7/9] arm64: dts: renesas: rzg3s-smarc-som: Update dma-ranges for PCIe
Date: Fri,  4 Jul 2025 19:14:07 +0300
Message-ID: <20250704161410.3931884-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704161410.3931884-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250704161410.3931884-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The first 128MB of memory is reserved on this board for secure area.
Update the PCIe dma-ranges property to reflect this.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- collected tags

Changes in v2:
- none, this patch is new

 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 39845faec894..1b03820a6f02 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -214,6 +214,11 @@ &sdhi2 {
 };
 #endif
 
+&pcie {
+	/* First 128MB is reserved for secure area. */
+	dma-ranges = <0x42000000 0 0x48000000 0 0x48000000 0x0 0x38000000>;
+};
+
 &pinctrl {
 #if SW_CONFIG3 == SW_ON
 	eth0-phy-irq-hog {
-- 
2.43.0


