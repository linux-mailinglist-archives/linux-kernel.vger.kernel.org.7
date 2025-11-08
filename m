Return-Path: <linux-kernel+bounces-891405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 96164C42973
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 09:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0B17734A83F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 08:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B858D2E5B2E;
	Sat,  8 Nov 2025 08:21:24 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4891B283C87;
	Sat,  8 Nov 2025 08:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762590084; cv=none; b=ZN/+jl/gVtmBhC5Au+Lds1H3zEq92BKmTrEDlEBFEGeLJqcbPlpfKoXlyMf3qQYdtxo2Azsm4RW5S0geUKPj1nS/jGD4Pr+yhy1oB91qFk7c4WhBAmIehfgiq1dUbMb2RazeFtKi933T9SMs7u3iXvL2BUVQ4GXNHRAz7fveGFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762590084; c=relaxed/simple;
	bh=YI948oH4beFT5GR1kOI+UHzyUpIAe6wdqESMCkQ+wuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rGdWURvUjR/D8RxvGjZ5eG2IP/HxtnJNKQkCzt8lnYEhNIJ2bWUF+TvwclGBRa+xFbRaRewEUAsVBvoJeilR6lgqqyBS2hAwmBEjCQqdS6YoIBgqLZPi6Lx2LIP+PazXOcQcM8cCnOIzmhhudVDw7aMlt88hdKX8WmmHkFq7wc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [223.166.92.44])
	by APP-03 (Coremail) with SMTP id rQCowAA3texL_Q5p20b2AQ--.57722S3;
	Sat, 08 Nov 2025 16:20:37 +0800 (CST)
From: gaohan@iscas.ac.cn
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Han Gao <gaohan@iscas.ac.cn>,
	Yixun Lan <dlan@gentoo.org>,
	Drew Fustini <fustini@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Guodong Xu <guodong@riscstar.com>,
	Haylen Chu <heylenay@4d2.org>,
	Joel Stanley <joel@jms.id.au>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Han Gao <rabenda.cn@gmail.com>
Subject: [PATCH 1/3] riscv: soc: re-organized allwinner menu
Date: Sat,  8 Nov 2025 16:20:23 +0800
Message-ID: <d17a3a01e2b1297538c419b51953f9613426ba42.1762588494.git.gaohan@iscas.ac.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1762588494.git.gaohan@iscas.ac.cn>
References: <cover.1762588494.git.gaohan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAA3texL_Q5p20b2AQ--.57722S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uw18Xr1rWF1xWr43WryDKFg_yoW8Jw1kpr
	sa9rsYgay5Ga4SgFW3ZFy0gFW5KFn7J3y5G34DAa47X3yUA3yUCr4kt3Z8JF4DJr9rXw1k
	GryFkFyF9a45ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWl
	e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
	8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
	jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
	kIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxAq
	zxv26xkF7I0En4kS14v26r4a6rW5MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRRmLvt
	UUUUU==
X-CM-SenderInfo: xjdrxt3q6l2u1dvotugofq/

From: Han Gao <gaohan@iscas.ac.cn>

Allwinner currently offers d1(s)/v821/v861/v881 on RISC-V,
using different IPs.

d1(s): Xuantie C906
v821: Andes A27 + XuanTie E907
v861/v881: XuanTie C907

Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 arch/riscv/Kconfig.socs | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 848e7149e443..7cba5d6ec4c3 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -54,14 +54,26 @@ config SOC_STARFIVE
 	help
 	  This enables support for StarFive SoC platform hardware.
 
-config ARCH_SUNXI
-	bool "Allwinner sun20i SoCs"
+menuconfig ARCH_SUNXI
+	bool "Allwinner RISC-V SoCs"
+
+if ARCH_SUNXI
+
+config ARCH_SUNXI_XUANTIE
+	bool "Allwinner Xuantie IP SoCs"
 	depends on MMU && !XIP_KERNEL
-	select ERRATA_THEAD
 	select SUN4I_TIMER
+	select ERRATA_THEAD
 	help
-	  This enables support for Allwinner sun20i platform hardware,
-	  including boards based on the D1 and D1s SoCs.
+	  This enables support for Allwinner Xuantie IP SoCs.
+
+config ARCH_SUNXI_ANDES
+	bool "Allwinner Andes IP SoCs"
+	select ERRATA_ANDES
+	help
+	  This enables support for Allwinner Andes IP SoCs.
+
+endif
 
 config ARCH_THEAD
 	bool "T-HEAD RISC-V SoCs"
-- 
2.47.3


