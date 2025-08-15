Return-Path: <linux-kernel+bounces-770001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A99B275C8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E1925E318B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380F02BD58E;
	Fri, 15 Aug 2025 02:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jxIN2KNi"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14CB2BD005
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 02:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224855; cv=none; b=rQAGvsM6Mb1xhjk05cgfIWRvUVCMhKTgWUUOj3YBhLplmAkVLj6HQPL1ziuDZ3lxpARSZGWYNPIAv7AAvvAFK/yImtgrYxUXBE2fKc7lap2Tf2rK69aafqEKDtnnRtYpGKJ+Ay+RtXjoVrOsYomWxm+svnRz3aGYkK4ijXgJ1kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224855; c=relaxed/simple;
	bh=i6rjR5I+oumj7Z3gs55v7dXY57HrDi0J9Jvi14F0LO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CbKWgkXWB+E7SvanhVY2hJEtr6uY3Cokxe46yUFbE+26AV2eAj0ke7Q5Qh6rCN7geYy+3r0gTICMiuxvm3k6iYKKFuK+It9f9WPxYdvUO41svcICLygybqg2UBadvGdjaXW/LrBz0uYNV7f6/id0tB/nRUySVc3QkHInOpE2y2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jxIN2KNi; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=A8VOVJHDlB6cQAduRDBiJdgd6GJeEVIIGwtdOH7vbhc=; b=jxIN2KNiCo388EWN4Rj3QUaY5Z
	kssGBrZGi/2tHSa5CcY9jyfL+OFMgQagA1zw/6UNs+i8nb20BHZc/F20D6cpGhcxDXTFEZ5wqf5ml
	P5RcRPY2shROAqcmoaCua9Z8H/ZXMHbPrQn4OEeixuLk+65oF4msmop6ZDi47mfk09enZrFsTxjBv
	izHWN0rlJz8zjz57IRmLNZDNnumUWYabONXSfvYzt1oDQoO+1xz09D78J3IzrCFy+jpBoMJcNQAAf
	r/V0cSZKopMW9JUDIrMXHsoYC4AbzFqOd3pPBbaOdfazSqSfbafVNDMuogEifcfdpgJJIBY8xNWN6
	YAWIWJig==;
Received: from [50.53.25.54] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umkAG-000000019Ub-2SDx;
	Fri, 15 Aug 2025 02:27:32 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jeff Chang <jeff_chang@richtek.com>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH] regulator: RT5133: add missing HAS_IOMEM dependency
Date: Thu, 14 Aug 2025 19:27:32 -0700
Message-ID: <20250815022732.1650900-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When building on ARCH=um (which does not set HAS_IOMEM), kconfig
reports an unmet dependency caused by REGULATOR_RT5133. It selects
OF_GPIO, which depends on HAS_IOMEM. To stop this warning,
REGULATOR_RT5133 should also depend on HAS_IOMEM.

kconfig warning:
WARNING: unmet direct dependencies detected for OF_GPIO
  Depends on [n]: GPIOLIB [=y] && OF [=y] && HAS_IOMEM [=n]
  Selected by [y]:
  - REGULATOR_RT5133 [=y] && REGULATOR [=y] && I2C [=y] && GPIOLIB [=y] && OF [=y]

Fixes: 714165e1c4b0 ("regulator: rt5133: Add RT5133 PMIC regulator Support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Jeff Chang <jeff_chang@richtek.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>

 drivers/regulator/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20250814.orig/drivers/regulator/Kconfig
+++ linux-next-20250814/drivers/regulator/Kconfig
@@ -1251,6 +1251,7 @@ config REGULATOR_RT5120
 config REGULATOR_RT5133
 	tristate "Richtek RT5133 PMIC Regulators"
 	depends on I2C && GPIOLIB && OF
+	depends on HAS_IOMEM
 	select REGMAP
 	select CRC8
 	select OF_GPIO

