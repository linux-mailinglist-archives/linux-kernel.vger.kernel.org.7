Return-Path: <linux-kernel+bounces-844310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FE6BC185F
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 15:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0243219A31DA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 13:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352012E1F16;
	Tue,  7 Oct 2025 13:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Nvi3bpaq"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658A72E1C7C
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 13:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759844245; cv=none; b=CmHpUiJ8jLrgA2FYNvGeeqtea5oPbXCGATjmmrVGjrHUQY79BjmIDy4Gz7dr1WCt4I6RvKit99bubAm0reHEDxiDmmpj+RlcT28yJeMzNcNjEVbuykei5frUry3ONGLtDpdF+rSC1rSkOpWiruBb27xCXqRsc2GCf8r696FgHBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759844245; c=relaxed/simple;
	bh=yaCx/QXvNC+g5usMHZ3TsHW2T6LwSJ/D6SVOOxCGqwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bFMlMn666yJf7EXk83rKnXfse+DdflWH1jXP1tn4CDu9NDkrvfSFwPtRMTtmFL9Mtt1NuXWvFi0GK7sKgAwGWwE49U6JbRGFcqWbqz1vzaDU9y7YigNG2FP5RFC6F8WOwRAQWuykalKs4nydzxuFYlFmJ1nWdTMwCBZCUQf1M/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Nvi3bpaq; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e33b260b9so59611465e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 06:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1759844242; x=1760449042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1z8hWvOzadOavRT6eY0ADJYVQmzPY5Un07yvaG3S8o=;
        b=Nvi3bpaqAeNOr99iDZCXPGZUh/cBiCtvjUs9HYDnQsWXWQod7HuHRsHpQa5xg79Iy4
         6tAVoFt1VO2SKwgfE1oIj/kVl9gbu8w/d7ikwsCkkBp95Ydew2Yo6J818tA/TsqMCgHK
         H7j3ZWYK+py6DtxUeFa5L82eWNU3S2JCIWlmFBClaTJdOola0x9q5oolVoH72cthR0KB
         /88AnyjeItBSGe0/uP6ZHGgZJqAqzEg1tTlpTIXrmRR8ibydKUTk9cmEPE2P1SeKgDLh
         /SBmgbbT7twGNf7dWAw8LkFiC9uVEXs0FxoafghV/ppsenWun3HE3EGRbw4Yp7rSp+f2
         C77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759844242; x=1760449042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1z8hWvOzadOavRT6eY0ADJYVQmzPY5Un07yvaG3S8o=;
        b=LtDpyH5mh+Qp8i0+4f6GlLcfXAJ1SDdTI3QKPbtsWZUO9f0UpeVLT/8wzSZKbajsg2
         afzA1Wkwc46fkbZ7mpJJa3nI3b/VkjLo4hK8qCpLIsT9ZSd10fwqQ+IQmR/t9WB+Y4xS
         GJfLXPt7gVNQMWMbXnyXo0GEs58maniTOstXbkyB+5F4lNQ0M9uJU5Xr4xtOR9WYylPc
         Xy9HEpHrb97Xb0xivdH/5GoAAobZzhJXVXWFNuJ3gu6dbtR+033glPnBGJEjrAfl93eM
         SiGRLTCcR0+BzRKezWHkGqpSzbh4ZuqNjT6wBZbdzcYjHCQYxbdpkzx9S9IWeA+35VUR
         d/xg==
X-Forwarded-Encrypted: i=1; AJvYcCUv8rHYZ4Rs+Hruunb4pyirzPOF5ol1j/12eT/K8I0S8OUcI8IgXoLKmaXYWS8zojOACAOdhk+gi3TY9kQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYKh4bmJdxR2rfGIG0tDDJysbrpyoLxoAbb/GCNz2FzILrqsCf
	NtiRuowiHzR1JOi3gqse35R2oiMirQ7bA8G2Z4p453mE5RTivnaXK/9z8jCTG0IhohI=
X-Gm-Gg: ASbGncsvSiXYXUzlZHXX+ZVFfhlYqgkhldoGZKvrDgKTpgS6fD3w2jjKNMRkfI0Kfvb
	V6gjAMI5wH5cce4V0C5aCT9V0e4lug+NfrNyfJtPZplRp51NGCLqyphYUBIyXgGCtGfsv0XWGcE
	zV3cFnLHQgtlDRHhO9WiaCWgqaucLQ2A249bWHbHdPT4xWcU6g5TlT7EY7yxEUzPAT8bDh4mpyS
	F+WarFyH+9lRAsm8buy0DKPndBANA70RtYkPQDf2QPnu2vCv+gsO0jTfThPCY6b1zHlIhzMC99P
	qyGoF7+4zoix73t2H8YBQGO3/v2tFENqZ+PIcQGQjvovxALFR6I3TGTzYy4dmKYIRdX+A8h+GNi
	KrY23JVmywzVHRgmYV86B90i+nLSl3E0D
X-Google-Smtp-Source: AGHT+IHfz9zJI0lmSyerN85rG4LviPI/1bLy+sw6oZnepm7Ovg0zyDxv3/LrYkgGVaFxC0dz9CvL7A==
X-Received: by 2002:a05:600c:5488:b0:45b:88d6:8ddb with SMTP id 5b1f17b1804b1-46e7115afa8mr119636995e9.37.1759844241581;
        Tue, 07 Oct 2025 06:37:21 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e674b6591sm272189625e9.4.2025.10.07.06.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 06:37:21 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v5 4/6] arm64: dts: renesas: rzg3s-smarc-som: Add PCIe reference clock
Date: Tue,  7 Oct 2025 16:36:55 +0300
Message-ID: <20251007133657.390523-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007133657.390523-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251007133657.390523-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Versa3 clock generator available on RZ/G3S SMARC Module provides the
reference clock for SoC PCIe interface. Update the device tree to reflect
this connection.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- this patch is the result of dropping the updates to dma-ranges for
  secure area and keeping only the remaining bits

 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 39845faec894..b196f57fd551 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -172,6 +172,11 @@ a0 80 30 30 9c
 	};
 };
 
+&pcie_port0 {
+	clocks = <&versa3 5>;
+	clock-names = "ref";
+};
+
 #if SW_CONFIG2 == SW_ON
 /* SD0 slot */
 &sdhi0 {
-- 
2.43.0


