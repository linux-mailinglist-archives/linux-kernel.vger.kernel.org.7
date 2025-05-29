Return-Path: <linux-kernel+bounces-666848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE71AC7CDE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 13:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08FECA26481
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 11:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C209290DA8;
	Thu, 29 May 2025 11:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hF+sCsj1"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACED28FA9E
	for <linux-kernel@vger.kernel.org>; Thu, 29 May 2025 11:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748517754; cv=none; b=VzodBjrOa6JkuXHH8dQ/TJ1woPhBgJKjW4GjlJLW/6V2Yb/AwofUAAvWnCeVu4kffEjdTo8ttwzDtLjNzaZ0pq5W54/DhFFCl4EFqBUTIBffaaEJmc/VVSULVWDzQcoTFZOaievCRn5cojXOuwwP/UnezX8A9e8dmLMqEr/vksM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748517754; c=relaxed/simple;
	bh=tcS1OdtYYeMI7g/XHAbOHs513PqKnIFqXgFxXuW43MM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PHpQLx3d4WTxXU5VoMx/3IOQdUP+56NEy12yMX+Z1lp6mUpuosGc8+V8a9IhpnZqFKhmeos8etYBm3LLhTAGmR/qNVNchn2hbf6w/RvXrdhWOZbX6NOJwv6FXx555cDihXHy9zMdLhFf/A0bLJUEBW5Y6/mOM9K1nYBXLZdV7zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=hF+sCsj1; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ad1b94382b8so131149066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 May 2025 04:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748517748; x=1749122548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLh4eS1a0IWerdW1Bha9yJdjwbF94WZ0emKgMLeoZKQ=;
        b=hF+sCsj1flHN9nBuUis3qV5S4myi/hCxOSx/IYooPSziMv7dhu+nvT/YDqxYpoYhiH
         AsypeXh/3eOkih/YIk1AoWFfoxBC05RQo46ON/VSK+EyGBEmbkysrEhGkQA0B1r+x8A3
         WoAzCopOrkeU2NNmccD79tjRsdBGpYzGfLs7PPFRD1IXe0w9JEQOa3oZJ76lPsPuM9dv
         HhaCo/Yx41rKr8oev5yZupxjQcT9cC9+cZ6+yd3vpJ5zGh8z2SteRcOKgEA464WBYYHD
         ynEIqXHCT170Pv5B+bHAEk1eqvUuoNGL9kYlDgaZgQ7NUk0rSCVThLQfbohVlq2DnL/M
         /49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748517748; x=1749122548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLh4eS1a0IWerdW1Bha9yJdjwbF94WZ0emKgMLeoZKQ=;
        b=H45QTeZZuOoyHkgap0u0Z7gINd4PLWUqnRHelzeLj2qivCWxI8EGWy/cj090ImDlb8
         buvWiPa2TchWgmb6/PQ0cjDDbPTTrQgsFy2wle5JQpkaJEOsEzq3CiB7Uk9O46R84chX
         cw8W1RvDhnzKwy4EmfGQSrBQezeijqzxnzHQ+6Qa/SGfoJML3/7kkG5bJPzgnCvEdFqg
         TkBkNy8elN4tjwCM0vuwYBtnEdTpN8R+jj9gPe4lb8798l2uyJUw/kULNdbFgRcJtQy8
         Zz04LQ/TMFFFqfnwlhO66eXLG2EtryjgSoHbnxxin9fnDpR4hmnQQDuzT4TdfDdck03P
         byGg==
X-Forwarded-Encrypted: i=1; AJvYcCUpUbHxz60NeeVlC9Gm4MZweltMR6HzsVY1PJFzFEuFWA0EZlT1LLcG3GrXXCFmSg7oLMwwGSw/1zEcknA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuecRQCokcatCjqZ0mp46q8EyHsxwz2+VXDQG4w0gchb/bgzRI
	7yz1GkD5ngqyZqQF5IZcPoeq5+UAoqHl2YVl+Y8A7PcplxftcpEycjEB9F5asGWWOas=
X-Gm-Gg: ASbGncsEmFgxo+krp2vONQjSQppNbXOO2SyQ57sAdnYM9oQ9FVjzZ1vFHThPpxjIVfC
	7o9Sv+eLSk7DsuUVFTzyyodZTFhRzkBej6d2nb3aqdqy6CNU3NVEK3idilueuAsts4V+bGP6zlA
	wXCAVfkYlYj7b9IIBdXuVCyG/Ezt7OpgcxH3eXxnPCM8e57yCqVPLvqZwYoRYgvVjj25IWrY3z1
	J4xYFPGZo7jMu9nruJvk5YVPpyKPoejPqoNV82qtvFpLfNSRaIsNG4VVQc9jx1f9yjIM3CyOB+y
	32+zwtzoVDvNqotbXuz38EMkyRZKU1MyDPQZcU33vSUP8O2Cc2a4mAa8gNAlGx2KwYsYyoV6Eqo
	4ILSJ3sbXdFw7rr4u+qeG9w==
X-Google-Smtp-Source: AGHT+IEJVaL78WGUYXXOjvm6W0GxbUpCLixhBH4c/y3R/OI7jUleYio+vMA2WVkvn9YFZoalSxDrog==
X-Received: by 2002:a17:907:7ea0:b0:ad5:b2aa:847c with SMTP id a640c23a62f3a-adadf2a13e1mr175465966b.54.1748517748298;
        Thu, 29 May 2025 04:22:28 -0700 (PDT)
Received: from localhost (host-87-21-228-106.retail.telecomitalia.it. [87.21.228.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d850d88sm123925166b.77.2025.05.29.04.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 04:22:27 -0700 (PDT)
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
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
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
	Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH v10 11/13] arm64: defconfig: Enable RP1 misc/clock/gpio drivers
Date: Thu, 29 May 2025 13:23:46 +0200
Message-ID: <20250529112357.24182-6-andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1748516814.git.andrea.porta@suse.com>
References: <cover.1748516814.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Select the RP1 drivers needed to operate the PCI endpoint containing
several peripherals such as Ethernet and USB Controller. This chip is
present on RaspberryPi 5.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5bb8f09422a2..f6e9bb2a3578 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -620,6 +620,7 @@ CONFIG_PINCTRL_QCS615=y
 CONFIG_PINCTRL_QCS8300=y
 CONFIG_PINCTRL_QDF2XXX=y
 CONFIG_PINCTRL_QDU1000=y
+CONFIG_PINCTRL_RP1=m
 CONFIG_PINCTRL_SA8775P=y
 CONFIG_PINCTRL_SC7180=y
 CONFIG_PINCTRL_SC7280=y
@@ -702,6 +703,7 @@ CONFIG_SENSORS_RASPBERRYPI_HWMON=m
 CONFIG_SENSORS_SL28CPLD=m
 CONFIG_SENSORS_INA2XX=m
 CONFIG_SENSORS_INA3221=m
+CONFIG_MISC_RP1=m
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
 CONFIG_CPU_THERMAL=y
 CONFIG_DEVFREQ_THERMAL=y
@@ -1299,6 +1301,7 @@ CONFIG_COMMON_CLK_CS2000_CP=y
 CONFIG_COMMON_CLK_FSL_SAI=y
 CONFIG_COMMON_CLK_S2MPS11=y
 CONFIG_COMMON_CLK_PWM=y
+CONFIG_COMMON_CLK_RP1=m
 CONFIG_COMMON_CLK_RS9_PCIE=y
 CONFIG_COMMON_CLK_VC3=y
 CONFIG_COMMON_CLK_VC5=y
-- 
2.35.3


