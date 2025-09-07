Return-Path: <linux-kernel+bounces-804571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC018B479E9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 10:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 878843C635E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 08:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9C321CC6A;
	Sun,  7 Sep 2025 08:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="CmxG6WY4"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35757220F2A
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 08:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757235517; cv=none; b=uluEzS4ouwghHAbsXrtkOnl/jh0BrnO8Ptdpvg9T2QDbhn4qrqP9wWTBo+InN9G03OqxJTMhOlrtE2AUq3iy9cFzrvOputB+3N7Nz0KECXu/A7330LsNHzTLNOBOrQnOkZ4PEvW27roTUG8wQk2gyuUIwYULkMKKsoR22AetfNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757235517; c=relaxed/simple;
	bh=gzkhOVFDEtRngN3J7SgKqr/lOPzZvzCr/eMzgUueLLM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HAv7K6C1DuW+/KgwVcXpBKDDy6EZ2CftiP924fCeR4ba5QNFeKHAlSg8AScBsIpfyeDbwmQNyECFQgEawd98IeV9sdslX4x3jTdaYx7Y23AsFxtXtXpvXTqNFw2MHfvEya4LGZv58MjJfqiNW8q3ECb+ScLUmNXyXzIjO+cj+vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=CmxG6WY4; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c67:84a2:d86d:fcf7:24b4:e467])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id CDD5919E7;
	Sun,  7 Sep 2025 10:57:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1757235440;
	bh=gzkhOVFDEtRngN3J7SgKqr/lOPzZvzCr/eMzgUueLLM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CmxG6WY4r32B7mQb5iW8zjLitO6jRGV8QF2iF+J6aCbzEMeqev7YXcY4b7UznAvmm
	 QEMYcuaKuVYDa2g9U30dGmJf8EbiVj+q7QNtYNXmqQiN51QslWCLdPUMMBy2NygtDk
	 qTyjKb0dTqqAISONtQrpNHn6jIKezkZyghjQOuRw=
From: Jai Luthra <jai.luthra@ideasonboard.com>
Date: Sun, 07 Sep 2025 14:26:25 +0530
Subject: [PATCH v2 5/5] platform/broadcom: Destage VCHIQ MMAL driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250907-vchiq-destage-v2-5-6884505dca78@ideasonboard.com>
References: <20250907-vchiq-destage-v2-0-6884505dca78@ideasonboard.com>
In-Reply-To: <20250907-vchiq-destage-v2-0-6884505dca78@ideasonboard.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kernel-list@raspberrypi.com, 
 Stefan Wahren <wahrenst@gmx.net>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Jai Luthra <jai.luthra@ideasonboard.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6811;
 i=jai.luthra@ideasonboard.com; h=from:subject:message-id;
 bh=gzkhOVFDEtRngN3J7SgKqr/lOPzZvzCr/eMzgUueLLM=;
 b=owEBbQKS/ZANAwAKAUPekfkkmnFFAcsmYgBovUkKCaNG5rPdrLS+WujdutznZZQFRR683DVhv
 cvm/lXfJfmJAjMEAAEKAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCaL1JCgAKCRBD3pH5JJpx
 RYGrD/wKrhPFRmcpmEC/yBI5wtQ9FN7jPwo+fw7ymT8geQ2Nyx01vlx7OlwHOoEd+TmOntuvpB0
 SVf4daIQ/G42RBtn0XEV7hhYIOa1gwUuIhK16LO16daxONXZGbRR3EKAWYJq2SuHvNLP5ZOwVTb
 pFyBZ7d+bQUilc3wZZk0ktLXK9KOT2tv5TehynP739CxMn3yJnVTWWTLm0cynUMLXw83v/izIiE
 yf3AZxdfM1mO9MLq4zGk/JOgSBdkPOCJ5+bBF5sfEWw/Ufrl7FUnTbM3rbnF092J8A0LYi62VjZ
 c3xkfYk3Oo+OEqLgFBdMGztc/Xuxixb6GSiniINqpnjrjBLhmOsjXupZttbnMa07gGm+vPGeBGd
 fWjhyY0weqFhBp0LuNnA/2oIX6JliAd8nAs2gsOFY3g00NnK/43ujy19Plg+N52cI0S3655DQyf
 4roaqvjR3+qPy/rZmMItVr3buQA/CwOs4bN6xJAsFLDiyI6PO8AeFDFtFcPv3ofhZPF+MeIA1Ld
 tzaPDdA69R7mFctWR7CY3UMTN9VnX/PohcOddVZxGowozn2WkDKUk9hfJTsFgrWEPWru35izYmM
 b4lRrPctD64deKemgJeL5An0u+M0OEdZr+dhjqzItk5FI5cHIPrp2rKlvcqn4qpjrHIl4TsLvVo
 +mWmvU65QfHZ0SA==
X-Developer-Key: i=jai.luthra@ideasonboard.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145

Destage the VCHIQ MMAL driver to drivers/platform/broadcom.

Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
---
 MAINTAINERS                                                             | 2 +-
 drivers/platform/raspberrypi/Kconfig                                    | 2 ++
 drivers/platform/raspberrypi/Makefile                                   | 1 +
 .../{staging/vc04_services => platform/raspberrypi}/vchiq-mmal/Kconfig  | 0
 .../{staging/vc04_services => platform/raspberrypi}/vchiq-mmal/Makefile | 0
 .../vc04_services => platform/raspberrypi}/vchiq-mmal/mmal-common.h     | 0
 .../vc04_services => platform/raspberrypi}/vchiq-mmal/mmal-encodings.h  | 0
 .../vc04_services => platform/raspberrypi}/vchiq-mmal/mmal-msg-common.h | 0
 .../vc04_services => platform/raspberrypi}/vchiq-mmal/mmal-msg-format.h | 0
 .../vc04_services => platform/raspberrypi}/vchiq-mmal/mmal-msg-port.h   | 0
 .../vc04_services => platform/raspberrypi}/vchiq-mmal/mmal-msg.h        | 0
 .../vc04_services => platform/raspberrypi}/vchiq-mmal/mmal-parameters.h | 0
 .../vc04_services => platform/raspberrypi}/vchiq-mmal/mmal-vchiq.c      | 0
 .../vc04_services => platform/raspberrypi}/vchiq-mmal/mmal-vchiq.h      | 0
 drivers/staging/vc04_services/Kconfig                                   | 2 --
 drivers/staging/vc04_services/Makefile                                  | 1 -
 16 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fc74a9e2e5a47b8c82cf68ef7c1fe3d37e2fe89b..856a2a489afbc95780769a708540444aa5aa983a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4753,7 +4753,7 @@ S:	Maintained
 T:	git https://github.com/broadcom/stblinux.git
 F:	Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
 F:	drivers/pci/controller/pcie-brcmstb.c
-F:	drivers/platform/raspberrypi/vchiq-interface
+F:	drivers/platform/raspberrypi/vchiq-*
 F:	drivers/staging/vc04_services
 F:	include/linux/raspberrypi/vchiq*
 N:	bcm2711
diff --git a/drivers/platform/raspberrypi/Kconfig b/drivers/platform/raspberrypi/Kconfig
index 9085e7464ec348fce5ec9f41a9019ab12eee964b..2c928440a47c08e4d452fe838fe4105c608995a4 100644
--- a/drivers/platform/raspberrypi/Kconfig
+++ b/drivers/platform/raspberrypi/Kconfig
@@ -47,4 +47,6 @@ config VCHIQ_CDEV
 
 endif
 
+source "drivers/platform/raspberrypi/vchiq-mmal/Kconfig"
+
 endif
diff --git a/drivers/platform/raspberrypi/Makefile b/drivers/platform/raspberrypi/Makefile
index a807571c59a47bb418cbb1dfcc389219d0d0ff22..2a7c9511e5d8bbe11c05680eea016ef40796b648 100644
--- a/drivers/platform/raspberrypi/Makefile
+++ b/drivers/platform/raspberrypi/Makefile
@@ -12,3 +12,4 @@ ifdef CONFIG_VCHIQ_CDEV
 vchiq-objs += vchiq-interface/vchiq_dev.o
 endif
 
+obj-$(CONFIG_BCM2835_VCHIQ_MMAL)	+= vchiq-mmal/
diff --git a/drivers/staging/vc04_services/vchiq-mmal/Kconfig b/drivers/platform/raspberrypi/vchiq-mmal/Kconfig
similarity index 100%
rename from drivers/staging/vc04_services/vchiq-mmal/Kconfig
rename to drivers/platform/raspberrypi/vchiq-mmal/Kconfig
diff --git a/drivers/staging/vc04_services/vchiq-mmal/Makefile b/drivers/platform/raspberrypi/vchiq-mmal/Makefile
similarity index 100%
rename from drivers/staging/vc04_services/vchiq-mmal/Makefile
rename to drivers/platform/raspberrypi/vchiq-mmal/Makefile
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-common.h b/drivers/platform/raspberrypi/vchiq-mmal/mmal-common.h
similarity index 100%
rename from drivers/staging/vc04_services/vchiq-mmal/mmal-common.h
rename to drivers/platform/raspberrypi/vchiq-mmal/mmal-common.h
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-encodings.h b/drivers/platform/raspberrypi/vchiq-mmal/mmal-encodings.h
similarity index 100%
rename from drivers/staging/vc04_services/vchiq-mmal/mmal-encodings.h
rename to drivers/platform/raspberrypi/vchiq-mmal/mmal-encodings.h
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-msg-common.h b/drivers/platform/raspberrypi/vchiq-mmal/mmal-msg-common.h
similarity index 100%
rename from drivers/staging/vc04_services/vchiq-mmal/mmal-msg-common.h
rename to drivers/platform/raspberrypi/vchiq-mmal/mmal-msg-common.h
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-msg-format.h b/drivers/platform/raspberrypi/vchiq-mmal/mmal-msg-format.h
similarity index 100%
rename from drivers/staging/vc04_services/vchiq-mmal/mmal-msg-format.h
rename to drivers/platform/raspberrypi/vchiq-mmal/mmal-msg-format.h
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-msg-port.h b/drivers/platform/raspberrypi/vchiq-mmal/mmal-msg-port.h
similarity index 100%
rename from drivers/staging/vc04_services/vchiq-mmal/mmal-msg-port.h
rename to drivers/platform/raspberrypi/vchiq-mmal/mmal-msg-port.h
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-msg.h b/drivers/platform/raspberrypi/vchiq-mmal/mmal-msg.h
similarity index 100%
rename from drivers/staging/vc04_services/vchiq-mmal/mmal-msg.h
rename to drivers/platform/raspberrypi/vchiq-mmal/mmal-msg.h
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-parameters.h b/drivers/platform/raspberrypi/vchiq-mmal/mmal-parameters.h
similarity index 100%
rename from drivers/staging/vc04_services/vchiq-mmal/mmal-parameters.h
rename to drivers/platform/raspberrypi/vchiq-mmal/mmal-parameters.h
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
similarity index 100%
rename from drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
rename to drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h b/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.h
similarity index 100%
rename from drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
rename to drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.h
diff --git a/drivers/staging/vc04_services/Kconfig b/drivers/staging/vc04_services/Kconfig
index b9e6f369f54c3af6225f181e08ac14e3de044062..2f6d1aaffdb2c1f11ec27e0fb8050fef56e6a875 100644
--- a/drivers/staging/vc04_services/Kconfig
+++ b/drivers/staging/vc04_services/Kconfig
@@ -3,7 +3,5 @@ if BCM_VIDEOCORE
 
 source "drivers/staging/vc04_services/bcm2835-audio/Kconfig"
 
-source "drivers/staging/vc04_services/vchiq-mmal/Kconfig"
-
 endif
 
diff --git a/drivers/staging/vc04_services/Makefile b/drivers/staging/vc04_services/Makefile
index 7a716a5c781530b673027b9f82ec94ebfd615f8a..ba15ec663af0fabaf0060456fc997deb5e5e0533 100644
--- a/drivers/staging/vc04_services/Makefile
+++ b/drivers/staging/vc04_services/Makefile
@@ -1,4 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_SND_BCM2835)		+= bcm2835-audio/
-obj-$(CONFIG_BCM2835_VCHIQ_MMAL)	+= vchiq-mmal/
 

-- 
2.50.1


