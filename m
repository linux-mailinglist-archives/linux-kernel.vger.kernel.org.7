Return-Path: <linux-kernel+bounces-756708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2D7B1B809
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2BB518A40EA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386AC291C17;
	Tue,  5 Aug 2025 16:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MErQlKi9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B589277CAB
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 16:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410199; cv=none; b=gx3fqXjeHX3X5fMYm+51Y8rWjA3wIxRw2vRU6FTgtSAb/hoZyp5Jnlpx7VPxlmnGO9mwkBT1vN/cHj14L79slzU3yLSGcvH+lHYQ9QX4Lb+tG2BnQo7IRTJFp3FrW5I3Djnk3VM/sZFysW/ZG0/tY5V6SXy1EfqdVFA+Lv6I8S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410199; c=relaxed/simple;
	bh=3r1dS/qNsVeG2mlFiWsRvy9f+7ZseNp4wHtnTQCSJVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I6IaU4ZZue8yL30dcY1tg8MAPF7T4/q6SwyU6VswZNsx4tkQoeKNg1DjgeUiJHrYJSnilrQasd0MRBkAW0pMrOp6atjR9Tvz4Tkedc3jCQd+hHKdZq2P3PbY8UIC2+pahzKw+jl6JC+NVa2ROFJ9TNm/TU0rG6JzUk6UWiYnqgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MErQlKi9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C7EC4CEF6;
	Tue,  5 Aug 2025 16:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754410199;
	bh=3r1dS/qNsVeG2mlFiWsRvy9f+7ZseNp4wHtnTQCSJVQ=;
	h=From:To:Cc:Subject:Date:From;
	b=MErQlKi9ItXWe/s5vj+gbaGxE5Kow+63p4NjFRZxSetef3KutmV0KZDUhkH90j2FA
	 aeK8misnGP3wPJ6Woq+Uy+LcDbchxDgMqWDlvc0utnv6AdkTKP9rkVytf2kzx7bM8x
	 YJ8bKOtUmR0enGIjFScFnTROlh4jmpkjXPhdMp+BOeJQXstzDFQZjv+W3fhnGaK4BO
	 mTP8EPeNTcZJQgJ+yxFEv/CoLl3DQVjvbWWE1jHx34JpKSZljhy94qNGbnaSGFdQ+d
	 9tOEeJ/w61Fhz8SiBnHYpkJv+WXkw2wfG6cilNn1pXIxyqq/PZsTgUvKFjziHBJ4nL
	 satN5mUHhj+1w==
From: Arnd Bergmann <arnd@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <maz@kernel.org>,
	Frank Li <Frank.Li@nxp.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nam Cao <namcao@linutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Nicolas Frayer <nfrayer@baylibre.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Inochi Amaoto <inochiama@gmail.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Peter Robinson <pbrobinson@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] irqchip: build IMX_MU_MSI only on ARM
Date: Tue,  5 Aug 2025 18:09:49 +0200
Message-Id: <20250805160952.4006075-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

compile-testing IMX_MU_MSI on x86 without PCI_MSI support results
in a build failure:

drivers/gpio/gpio-sprd.c:8:
include/linux/gpio/driver.h:41:33: error: field 'msiinfo' has incomplete type
drivers/iommu/iommufd/viommu.c:4:
include/linux/msi.h:528:33: error: field 'alloc_info' has incomplete type

Tighten the dependency further to only allow compile testing on Arm.
This could be refined further to allow certain x86 configs.

I submitted this patch before to address a different build failure, which
was fixed independently but has now returned.

Link: https://lore.kernel.org/all/20221215164109.761427-1-arnd@kernel.org/
Fixes: 70afdab904d2d1e6 ("irqchip: Add IMX MU MSI controller driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---

It seems to be a recurring problem wiht x86 not using CONFIG_GENERIC_MSI_IRQ,
while all other architectures do. I wonder if that is something that
should be changed by changing the x86 irqchip implementation so that
CONFIG_GENERIC_MSI_IRQ can become the only way to do MSI.
---
 drivers/irqchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 96cca93714ef..b0b7143cae2d 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -558,6 +558,7 @@ config IMX_MU_MSI
 	tristate "i.MX MU used as MSI controller"
 	depends on OF && HAS_IOMEM
 	depends on ARCH_MXC || COMPILE_TEST
+	depends on ARM || ARM64
 	default m if ARCH_MXC
 	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
-- 
2.39.5


