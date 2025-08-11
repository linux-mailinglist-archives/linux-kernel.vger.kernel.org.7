Return-Path: <linux-kernel+bounces-762847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 550ACB20B5E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 851D22A6ED2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7ED61DC9B8;
	Mon, 11 Aug 2025 14:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="c9siHFSz"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E517E21019C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921454; cv=none; b=r1AOX94g8ka1/3DOFNk9tcvvM3O/gzimhikj8sdITorEbItcws/q6XUewIvMbY8INyecXJ30OvixoluI39H6EI2pflUNvgsHXE5ZY9ZcfsR3Bhe8JTilNHciI4cSU6LAX5UPxIRZUzEh038x3OYeMrTbxaJGxhoyhMgsZdK2YWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921454; c=relaxed/simple;
	bh=4QCFtRW/MxF9J/+GsGpUTijni3ULMWgMsH+JZsz8La4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GlDC1e4iA0yhdSwtKCT2YqkE02p2CBnTS7cXY/NQQNvkuSxwqR8BKC9Shku5r7tzq0wto++X3EMjEz90I1WEgM2YCQfmMRCoT6yTpyQ6C1TbPDFQLhT5GFP6tNLvE3hKv4Gc1IZPOI55KrJ8LsOAU5mo1PbQq3F9TqO4HjZTt8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=c9siHFSz; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-af98b77d2f0so816644266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754921450; x=1755526250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=63J39CyFqSLdGcoY+lFnsbjnjETWfUjBwWRQVTsQ3ZA=;
        b=c9siHFSzeTYLdZdarn6XHrmrahFZ+2fzoQ5GVM1QNqaNmqvdVbbpLyOvSlbvSorGCl
         aeQU2wkMqyK3cDjKcuoFDAnDNEYS3w7KO8v62suzc54O6PvAdDfvl/izbWndowEMp5yH
         pHGDltoRLF9yEjG3PPbAy7+dJUXImyls+lzkuESrClSFH5dhuU6ABG7j+FnPcjEf3U3D
         WcyKJM0DEjTU7l2QWihBzKmStm0WqsEQ+Co1pB70MEynRtzTNX9Ia5VjKXeMucQ/Yh8X
         aYEOUMXxEOKbXA/4Ep/afb9PFxIvVvuW8+YNzXPoHq3gB/X5yDCuKFUJfKB9O5ZMkusi
         NB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754921450; x=1755526250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63J39CyFqSLdGcoY+lFnsbjnjETWfUjBwWRQVTsQ3ZA=;
        b=Na9kqHD7OOd8VHiE7wETdsINyeK6MFzCLtNBuFQAMO2M/da/3XHir6fZFgxOFYy8UX
         s5W3+kRrE0AvLxebr2vlpcUyCrY4H8efTUzloyLOUOes21530XSVId/RXUk2gOQaR8mn
         ppxCvGEhqq5smNGmOYiviqqk+Fe0X1P3Gre4DW6aAFrHMUSRjm5mTUdMikmfKQ8pr4xM
         d/irtvOOYlhkOFdpYqIQCkDGvQMZeQdLbU7GvHRBcnPbquEVGCmKU60qChZdSOsIgywG
         N83pY3b4ygPVW5MqcMvIkEAMrQACLysN5+9CtjGev0Uix+scugLbNSZZcVsM4TnG00mM
         EJVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUVHEkqu1sC4TWb5qkvRxr2Zpr62lFOXtzUN9Zx7iu+iCq6UVJJ1sZPcQ11s7Wv97qnpqJ2zOSIlBQzk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNlTEfS7naU3QuGPUK5oAXPxm+SONIUKEm9q23rsgACXMy78w4
	Zsb3r5IgxzgL7Yc3XXkzq5zLQLiPhHIcAp11TjMTpIAZGfy82qHezu1CwCACfO1xHgk=
X-Gm-Gg: ASbGncvMeLI53xk+lefjMGuM7Rx3G5/LJE9icshktCSOJGa51th+9byQWF/UsFvH+Xe
	pvB9IftPWFlWWgAhdXwnX5HKLcNlhgKzu91TUMwjj+y1R+5eVLcMZn8f/L/AkL4KOnKzI6z0dx9
	Vd01U98GDr9R0PUSPnNtzQUyRmpjccWihYHaqP+pjAKpBqjONO6qv2179P8irSdv+uJkERuThGU
	lcaK1eupLyFclDbim6+8dqyvO4aSkzIYhgEzfS/4G+QXH1SzKI255ybVsSU/G+iSnzF490F9foE
	rlj5saFxOSa3/QA4AtXbEyVS84egSvUv7QcVhArqIM2Zh6UG5PAuQCFDWphHvwkBOih8NXn2r04
	/0HejR6crLKnqd6Jt+KG0VViL/KMHnxwcvcOb1jERRWnLT3oBues7+4WBmPPNKvuMzw==
X-Google-Smtp-Source: AGHT+IG/M8+ibyfZa1rZEJRPdNDgrfy4rJ6HCiKO3wMUuimZDr1wETFmlPT6yaYQrOBYlXmZ2auvCQ==
X-Received: by 2002:a17:907:3f1b:b0:ae0:a597:2959 with SMTP id a640c23a62f3a-af9c6516d10mr1108890066b.32.1754921450120;
        Mon, 11 Aug 2025 07:10:50 -0700 (PDT)
Received: from localhost (host-79-44-170-80.retail.telecomitalia.it. [79.44.170.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af9383590desm1818429466b.76.2025.08.11.07.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:10:49 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Phil Elwell <phil@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	kernel-list@raspberrypi.com,
	Matthias Brugger <mbrugger@suse.com>,
	iivanov@suse.de,
	svarbanov@suse.de
Subject: [PATCH 1/2] arm64: dts: broadcom: delete redundant pcie enablement nodes
Date: Mon, 11 Aug 2025 16:12:34 +0200
Message-ID: <2865b787d893fd1dcf816e1c96856711754d612d.1754914766.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1754914766.git.andrea.porta@suse.com>
References: <cover.1754914766.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pcie1 and pcie2 override nodes to enable the respective peripherals are
declared both in bcm2712-rpi-5-b.dts and bcm2712-rpi-5-b-ovl-rp1.dts, which
makes those declared in the former file redundant.

Drop those redundant nodes from the board devicetree.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
index a70a9b158df3..adad85e68f1b 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
@@ -15,11 +15,3 @@
 &pcie2 {
 	#include "rp1-nexus.dtsi"
 };
-
-&pcie1 {
-	status = "okay";
-};
-
-&pcie2 {
-	status = "okay";
-};
-- 
2.35.3


