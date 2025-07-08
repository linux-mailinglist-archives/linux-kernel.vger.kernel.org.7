Return-Path: <linux-kernel+bounces-721912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F73AFCF67
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B84E43B1698
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA682E172E;
	Tue,  8 Jul 2025 15:36:56 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E93B1D5150;
	Tue,  8 Jul 2025 15:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989016; cv=none; b=otxVUk5gv6YgpAehrMrUvNDgzDwMyBpQM8IhbuzrHuXIT5WJRGpd762avRpOL7jWJ2eSryeJFPGpbNByioj4UAah6vRhEn/l42epAMrfA7ISUtCUs4Iq6Ob85hLPQ8WnVcPL5rsk7P/VsS8AdxPPlO8GQZfJJ5BXTA5A1+bGIHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989016; c=relaxed/simple;
	bh=KBQo6WJ6K7Z011sDfx4sCVXePeIEXzyf1V8eTYUmdJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cy+OOPWZKSWdQaXQa+W1sfYAln+luRwns2wnPPiM7rlxwQts7cd0Q3KP3yySJC3fFrBawW3V8WflufXSPCXHDHtLEmrDqMBh0hlRAI9Leavb5y/TEF0iwxHljgwCa3xQcS3hE5rZh+k/LnMUG8MQh8SrVxCpbcd12KVgpGCpD40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BADEC4CEED;
	Tue,  8 Jul 2025 15:36:52 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	Walker Chen <walker.chen@starfivetech.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Conor Dooley <conor.dooley@microchip.com>
Cc: linux-riscv@lists.infradead.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] riscv: defconfig: Remove CONFIG_SND_SOC_STARFIVE=m
Date: Tue,  8 Jul 2025 17:36:48 +0200
Message-ID: <0886d3eb81bffbc1d48e701cae21c42cad29fefe.1751988704.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SND_SOC_STARFIVE Kconfig symbol was removed, but it is still enabled
in the RISC-V defconfig.  Just remove it, as it is no longer needed.

Fixes: acc317e5254a739e ("ASoC: starfive: Standardize ASoC menu")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/riscv/configs/defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 37c98c0f98ffc0ee..82be92dd70dc29a8 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -191,7 +191,6 @@ CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_SOC=y
 CONFIG_SND_DESIGNWARE_I2S=m
-CONFIG_SND_SOC_STARFIVE=m
 CONFIG_SND_SOC_JH7110_PWMDAC=m
 CONFIG_SND_SOC_JH7110_TDM=m
 CONFIG_SND_SOC_WM8978=m
-- 
2.43.0


