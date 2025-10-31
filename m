Return-Path: <linux-kernel+bounces-880137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8F9C24F53
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 247D71895D99
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2C02DC766;
	Fri, 31 Oct 2025 12:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="QURF/YQl"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2BA2E401
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913125; cv=none; b=fWBZNbeEg7Vmz6J7S1yKwwfKUOdNmdvdUUK7W3dzHv7Q4A0XnT115DN6Mp9rBly4J9WWtEBdI56N+YMUfLgj0S5klssc2mwtrc44+EZzaYIRWH1DnWXbcqLdz8x0ZJGUxv4RAa/vX2cG0OIgLRB49M7oKmQMEIqJb13wxu5Van0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913125; c=relaxed/simple;
	bh=icg2BUvcFjPrpOZLahuLBtboPRuzCt+PWs9Bs43HGUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A3+7rIi/WFIXY1rK6l+GzzaWAS6CJffZFDj9jnkGLBeCxFZ3Ek2j9h1XUrAzaLmdIpPKeqZB5MnqKRh1Hr8KWZxd1BBtCI++lJkd6zER17wW0NI+ZOJ6VUBWCPbbKh6WqZBHvabDxtqf4+zwVlnEnm/uXF2w8bFivC6q/LUoFmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=QURF/YQl; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64071184811so2958291a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1761913122; x=1762517922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PzKiSak3H689Kj/X1O/4ml5yQuQJC0SG0bQRjKYqUog=;
        b=QURF/YQlIFpxPiZdnb5AlkgWAH0FExWEKKS1GY8g9E4ArRAwtmswrS4lVh2ehoOOlB
         BweNcwUNS/bCEw6nU/LnBKU7Tj/CiCckFodZoYsZ5V3NDF2AdEYULwpRalnaeN8VmFKk
         KvFk8VckGtemWfGCzcDXNsVhMdYpBNkd4ycPBjJcHOqk3GN5FEp5HDvOsCOgdJc8sf2o
         WgoKJ34gGma2LCyZXlgemdrzwzrKNW9oofenFAD76fKAA5CH+gM667tfyd1+Lxs9w5iX
         ZDCHo7Hll3p4PPkQFeMEwQFUQ4V+AFffJbjalYJJOID6MLriW4IUhGTjP3eC9gqFLR9b
         1jNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761913122; x=1762517922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PzKiSak3H689Kj/X1O/4ml5yQuQJC0SG0bQRjKYqUog=;
        b=E9ofuw5VJ4OalO7p15pe69RX8RMzktNjMVgrpAVmuUlnav3y3hrXTtnsz46pcmXVFF
         hyCAHQmaGp9C5uHALaK5zWjY4R1WrVSbKkwG1mY1LTOz8dEeOCTH33GdsCeUgzp0EcbM
         GDLvxQQ/N/LCH8M+w+CTjs7qo/Jh0WkpO8US8LqI2elLYNgkxue+fOR4Wapas4i6e/7w
         JJmbJzCbpTmXzgY0md3r5rzAe1rDIQ0GKmb1aqJQU58wXbktFtvIwDqijIO747guxS1c
         whV0ZWWypVCf5M60fGev/Ni+rUNUhHjJCpOurXna//2biXuNcPuzvhSqRl4zXIy+SeQE
         Losg==
X-Forwarded-Encrypted: i=1; AJvYcCUvg1ysRAgA91lMHjCp9vs9gURulCEwrRb7yhT8F01QfaSsFP94mQtL+CMSKOwvbC4JLntygH6rWqZkI3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLw+eDNJ1VSwxEknA+mVfhVK94LiCDWRStCHZCItgjInzcDdXE
	dFLnctN6obCwAooYgPEbdWatHnEg9/6IAVWLHQO+EtyDdWC646a/9JxdsUTHf0sG888=
X-Gm-Gg: ASbGncuMycMSM7xPmK3I1HFeIEZdbMcVBALrjElNTmgh2kTBf2H5+7k04+HuGSOTSse
	afiJrUGZ6prv+focnAGZUhpgWAiIpK5Yd0surosWiqbOf/+7wgqT9pwiYOXpz6qVtHLRKZKYetf
	xC6UmkUKM/Z1lyyCAZhvE7y1RaynXdXHGzoIgK6/3YTL8ngMLbMO/2aGSU1RVvzFCTVmIw9+VmS
	ifHSc6x4wlTMQ08w15l4zdSPMy5G7oqA0NbAilCBTOv2SnPXWPyWIu+yafFacZEI145xrzLuZN1
	oKdTIFqqaaZ3ffmW4CMOVqwC62bkZbXrnNquTC+rAOs68m3Pa46FoyXXQ93PTi+iOzLaCgCxxts
	ecEbOxG3NaxExvej2R+/a14B7mxoIt5FPdTltvSTe3tyHY+7mOAzCG4HorQ6ToNvD27Cq5dWfMf
	bVI9arWPyrZB0SbkTCa/+i
X-Google-Smtp-Source: AGHT+IG/jTXCewNozopd7/aZCUUfDCbJQWXqJ1h84YETMOzj3GHZCqpEJTDBqjQSWUIN5XPosC+pEg==
X-Received: by 2002:a17:907:d8e:b0:b6d:825b:828 with SMTP id a640c23a62f3a-b707019c787mr347754566b.25.1761913122141;
        Fri, 31 Oct 2025 05:18:42 -0700 (PDT)
Received: from fedora (d-zg2-227.globalnet.hr. [213.149.37.227])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b70779e45a2sm160253666b.31.2025.10.31.05.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 05:18:41 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: vkoul@kernel.org,
	kishon@kernel.org,
	geert+renesas@glider.be,
	herve.codina@bootlin.com,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>,
	Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH v2] phy: sparx5-serdes: make it selectable for ARCH_LAN969X
Date: Fri, 31 Oct 2025 13:18:12 +0100
Message-ID: <20251031121834.665987-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x uses the SparX-5 SERDES driver, so make it selectable for
ARCH_LAN969X.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v2:
* Rebase onto next-20251031
* Add Reviewed-by tag

 drivers/phy/microchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/microchip/Kconfig b/drivers/phy/microchip/Kconfig
index 2f0045e874ac..2e6d1224711e 100644
--- a/drivers/phy/microchip/Kconfig
+++ b/drivers/phy/microchip/Kconfig
@@ -6,7 +6,7 @@
 config PHY_SPARX5_SERDES
 	tristate "Microchip Sparx5 SerDes PHY driver"
 	select GENERIC_PHY
-	depends on ARCH_SPARX5 || COMPILE_TEST
+	depends on ARCH_SPARX5 || ARCH_LAN969X || COMPILE_TEST
 	depends on OF
 	depends on HAS_IOMEM
 	help
-- 
2.51.1


