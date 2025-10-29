Return-Path: <linux-kernel+bounces-876239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44802C1B910
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A47D1660575
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F2C3563D4;
	Wed, 29 Oct 2025 13:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="KjsO/YA9"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7253563CF
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745056; cv=none; b=NYiwcKeoCvCxVQtHx8a9dQVh7Jz+OXztd3UfqP49NL8QoVpFdLioZOR46ezNfayaaClGKziTKHRPK/rw7dD23PAg0r0UKx6G5eLckXCLte8rsKEUITZzB7OqqSmw4F7UfQL18X9S6wMtDsnLAFqCDj9gmbt0KWKVuFZXTObQSNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745056; c=relaxed/simple;
	bh=t7G8Jycuz8+wzAu2xCWQPBZrSzG9Z8VIdsvKbiXuUuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQMe1Slrq/+g8Ynz/uL6tpALhGlc4KXON0bIvS4znZqNQcMrWVQ/AvrpKy2iKWU3gMZ8YVZwz8/eRvJEcxRHAZ0Xx2AGsAOJFuQJ3u3EGYEzw3MmVWj8PB0o1vUdH9k9MOFKx8JnzckiNruGrGpA/l3Y1uXVdAba6kwGpHIEVaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=KjsO/YA9; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4711810948aso54778005e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1761745052; x=1762349852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ri5sAKlO3KnC2SWKs6OABcUyoM7Qv96rgwkPvQx4cuk=;
        b=KjsO/YA9MG6WQzHJwhKGsQsWI9xGrV7ICzsWm+5fSdiGt8oPOl0CiMP+cOruXtMPMc
         mr3ygzSxIsSia9E932EHbkwS2fRzksawDCgFJCQZmV75NRY1Ld4ZTlg4fbRTJrKMoqde
         OSFURz8CKUdWaOL0Euf3jjfSayOGnG2q7pLF6k8Mhn9d5e6vx8RBm0r5o3ayDo8N5Xjx
         CQLlC/ZXE9nnE+hAiYkthbt6wt35c37hNwA1I1egDnIKuuE8thHQV0LfDetp+EeKI5Pv
         6f5HrsUnOg+xp+MC/zmvKTCDuxj6s79frWmyNWLyGBDBhTbG8/bYhe2O/86uHbhi8lDC
         7Uag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761745052; x=1762349852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ri5sAKlO3KnC2SWKs6OABcUyoM7Qv96rgwkPvQx4cuk=;
        b=BRnduqVLIfmtIH5EJW42Xl1LW9fQ/wVg+mZypCWeNmlY6rJwyVlkL5IGhQdovN7ZDE
         qpv/FN5ufD0PVhA173JloYmte++22T7qp2EUbZVwI+McVPwukOpdo1cAyBjkPKnLVq31
         vbe7+55Nw6BArqh5J+PAwEoK5VfpO2T4DyYJCns5srsg69r7wdoUNeCi2PYuVhZVCXxL
         g0MgDgt0J4PmBr5fJbTS8bX5gqxJc6VRi8wn9x7tDg6nEa7icQ8ZgD6Xnihqcs7t5eOT
         Wb+wLwxVpZy1WT+5AP4Nc0OUCQuNkkZOz+hprW8EFbi3xsIyKKuWxWe9uBlGg1f4aLpL
         2hYw==
X-Forwarded-Encrypted: i=1; AJvYcCXulu2Z2RlrUZkQC2gw0jGuaxSQlm6OQu7XneEUwyCQ058cFb8m+bT7BPw6l/p8HtCJ0YLLpNUQnKwQIPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWTyu9fuzZB8NbbsBzvsz4bw+wm2rCoIeyuFt+X5FHhq7uVBE0
	7olC5+vbO/6GnZcsTondJ5rpdAkPEeqSDePP2BAENLRfoDEnFsRMc4JP+ozbEYqb6w8=
X-Gm-Gg: ASbGncsqCTAX4aiQoh6xVAGlMAiEEAKgKfyIR6/7hOxcKoH/RJGIUVpjf3bfm0zx8J4
	zp7kdr7sCYqHsZPfAx4mPniwYnV22+rufQRNEa7EOPqJwFBhJ7nRoSNcIQ6P3zVLN5wq7l9Xv2Z
	4NW6sB8jUwuHezermr28HfkviHq2PDxfi8O/dzAuZLvPew36UuW5rGG/eAfckboNoqcDFb+z7o5
	rWgMZOtoMCUsJjACtYG2ePTHhY7vIWLKHYBQniepJRlruSrQhcKTRzCQgoTwZo6TzaxHdwu6edG
	x8/DCR3sVi603D3T4RWgE6EXaXAmUR9cBmGI6rL0Y2CgRFb4/G517vHy7icJaMh5v9+uJUBNrud
	OPMazOekMrSlnLRdx2wTkEc2Ybigj0Jj7ofGXoJuOTg0UtDB5xygQ8in8/oUioTcBBVnAnnjqYD
	FurgH8h7NMcHhvtv85k9hFsWIejpcMOOlaZbWyOfksT+c9/2Od7dARcMAMr1c0
X-Google-Smtp-Source: AGHT+IEJDplrheJ48QLqfg/pR+eu4ZCGROUq/p3ZBNkawUoNXH7zM1oOgMgH4Xfw2VwWuaEypaznsQ==
X-Received: by 2002:a05:600c:3506:b0:46e:345d:dfde with SMTP id 5b1f17b1804b1-4771e333bbbmr23167265e9.16.1761745051964;
        Wed, 29 Oct 2025 06:37:31 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6302:7900:aafe:5712:6974:4a42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e22280fsm49774795e9.14.2025.10.29.06.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 06:37:31 -0700 (PDT)
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
Subject: [PATCH v6 6/6] arm64: defconfig: Enable PCIe for the Renesas RZ/G3S SoC
Date: Wed, 29 Oct 2025 15:36:53 +0200
Message-ID: <20251029133653.2437024-7-claudiu.beznea.uj@bp.renesas.com>
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

Enable PCIe for the Renesas RZ/G3S SoC.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v6:
- collected tags

Changes in v5:
- dropped Tb tag

Changes in v4:
- made it builtin

Changes in v3:
- collected tags

Changes in v2:
- none

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 1d2d1458bef0..ad314b82423b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -232,6 +232,7 @@ CONFIG_PCIE_MEDIATEK_GEN3=m
 CONFIG_PCI_TEGRA=y
 CONFIG_PCIE_RCAR_HOST=y
 CONFIG_PCIE_RCAR_EP=y
+CONFIG_PCIE_RENESAS_RZG3S_HOST=y
 CONFIG_PCIE_ROCKCHIP_HOST=m
 CONFIG_PCI_XGENE=y
 CONFIG_PCIE_XILINX=y
-- 
2.43.0


