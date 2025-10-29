Return-Path: <linux-kernel+bounces-876237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1EAC1AE3F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6688234F49B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C8D3491F4;
	Wed, 29 Oct 2025 13:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="a0JFJJ9n"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB5A3469E4
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745050; cv=none; b=OEvvlYlUMRVouEzaWSWBn0A3MNQWUhx2p5uJ4ZI2qMxLo1Xb2ZpxidKcjybNfILnopk+ZYN0WPm0B1aIGwpD87Zfq/YGMzEhmACk3uF+utlW25SR4/pYWH6hCs/N3FkzL1boAwsulxVfbu1n5JpvZ65X3FSOeNQKmA79izreK2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745050; c=relaxed/simple;
	bh=GZ10kK+pYLUSiMaANpNaBmHbt+19wn5/MQvWC5jgaQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qyi7c7EIuz4CEr57ckmd4zS3+laBVPLlZ9wQa3fC3AzyK+UnGyjN8bFqY0PwHFBxKdkbVtlolQ7UBRzn+t6fB8T+Znav+ck6e2C5k36PHCqcl0TdTFMAiRYcs9+jamX8sJlpZFPos3gQ4gciAh+SyS89531bfCmkayb6VIuxe8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=a0JFJJ9n; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-475dae5d473so45223265e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1761745046; x=1762349846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=US6TL4WKOMJYPiF+qfjdrtMs7INfn6qweemcxJelWcY=;
        b=a0JFJJ9nJIw5ExDu00WgC5AVmKvQoezQe5B5Tj/XTdMsCpN2bkIpayke9NZCMmLoWJ
         LM0E0BY/nyUcoiN6nniVYJjPtiFypCYZtnkmKbpJ7rPOEZPxI2ASOsMCsU8nycyQZNpO
         g5GQC5/Vw+eRI78sYt2pQ1Hpry7yeBljNcsIi1UcJD6fTFV7eFH53XDlFm0PgQIxUW/j
         U8Bg8dLBEcZVgFLqHlyt+qeLjFJr4FjljmSS2hw4dRY2H9cxd8lRXJIhPkAObqMYefuv
         gVNG2ptY7QxmuS3u0Lv12/vNMs4W60jE5qjkF9NF2wwJra6QltjtfWh+jRlF4a/RMnKU
         JZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761745046; x=1762349846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=US6TL4WKOMJYPiF+qfjdrtMs7INfn6qweemcxJelWcY=;
        b=KG3DhqbgF6/D788CcOx0GwnWbe+9/i+qPF/4jt/SO/Mk+IDoUoHUdTVTNRtB0XMryg
         hCfpqRJvkKMB4kAiyYJpUDpgYKsVmc1iAWP0QDJXT7zzntucQp//AKZ2ZAGvsNlIwCYK
         Wb/JiLtBdeyGbVUWk/Wt+sUhVlotqx520PqBhw+PfxJ/UT8bl2b+dGup+WGiHBB9YWT0
         +7QWspow7YPrNW7u/3RnQUiso3f0qxmhZewnZSu+6tkisJLVSIoD1NUdUOBJPrw+eC53
         Fm9DLl2RKkIYfTni3NZdc2jMAIX85R8DhQ5E/l2pTI1dkQ/bYz/BWXDywptcfZyrZ6GV
         0rlA==
X-Forwarded-Encrypted: i=1; AJvYcCU+wx9qKpkjdniNagHzv7TaC4Dh+ByXSlLMEez8661fzGD+5Haxy46QU6XkkuaodikvfGLGqm+UsI6vwQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeRfdANzrjHhcmNLBdZaAJp8r7XoJ+LBZklq2zlA0izJgtMeDm
	SKWKZqP4TIFfplm/2kh3RTeQfDanrPy0Nf65IWZj39l3JL1Stz6ZdJpMj7tdrMFB5RY=
X-Gm-Gg: ASbGncsdYCMOLVXpOZ5KgGItk0B5UtnDBLFB6ftQQ6SsAIoIO8LmWGMs0dqzEsZFKSj
	o0Tv/1MJCAfYaOj9wArM2QlPnMsHNJEbnGMbBeBfpFOUppLGYQLEe3Mt+ULeP/uaeb41ef6+tKt
	TelBkftX7PkXfLKer/Q2eLLmksBqibwdS5A0KrtsOadxylm29xFBO5WvgK/E6jAXw9WaQzlLJ8q
	7GyYCOda3QInJVOQMg4geCxwGGTyC/PWicqS34kY+C4Z+m3c078ih0B0bP03DIYM59IKr8M7nG/
	YdiDDsYSWhKi34Ix25BHH/ilguIHrUYef8choDm5y3f86IpIUIsmNCcjDGOvnfzsGFbnDMN8a/n
	oNOHbCzPuL5+8aGggKbuTZf+15ssllrVBg8jsRYAGUxndmftd7KsmgIqtBMa+1NrAN4XSCqL1vN
	IEo8na2muuZzvcRH2N4fF9qi3l5iubVkMOUyA6AaUBC1swD9xRzgUA0iROH6ZA
X-Google-Smtp-Source: AGHT+IEtPz0Owa/uEAi7Mu4+EoNUOeaQ///6DG4yCtEM4dUCCiUVnDE6W6H21Mp9cuh5kJvNRIk1EQ==
X-Received: by 2002:a05:600c:4e56:b0:475:dd59:d8da with SMTP id 5b1f17b1804b1-4771e3ccf23mr25357735e9.40.1761745046169;
        Wed, 29 Oct 2025 06:37:26 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6302:7900:aafe:5712:6974:4a42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e22280fsm49774795e9.14.2025.10.29.06.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 06:37:25 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
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
Subject: [PATCH v6 4/6] arm64: dts: renesas: rzg3s-smarc-som: Add PCIe reference clock
Date: Wed, 29 Oct 2025 15:36:51 +0200
Message-ID: <20251029133653.2437024-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029133653.2437024-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251029133653.2437024-1-claudiu.beznea.uj@bp.renesas.com>
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

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v6:
- collected tags

Changes in v5:
- this patch is the result of dropping the updates to dma-ranges for
  secure area and keeping only the remaining bits

 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 6f25ab617982..982f17aafbc5 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -168,6 +168,11 @@ a0 80 30 30 9c
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


