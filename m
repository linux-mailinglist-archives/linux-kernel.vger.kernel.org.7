Return-Path: <linux-kernel+bounces-825773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16230B8CCCC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 18:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 024FE188D239
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 16:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0A5302168;
	Sat, 20 Sep 2025 16:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/5utOKY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF4026FDA8;
	Sat, 20 Sep 2025 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758385493; cv=none; b=KzjwR2Xi9qhZZqXENNO3QIJrfqaDozey6q1OFdw4E0eX/V4eLjluC+KgTeiL7gJOEY/wc/gHj7BUjTDS+q5vz+oPpARPifda7ZoARiJ4C4Z0LhqJHZ4NHtQ/CCpaqnZ4a3tkkOEWh2MUq6/JQIYEuvG7k/N7lzJicyeZwTRpyK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758385493; c=relaxed/simple;
	bh=OsZkTOUSdYN93gDiPavU6jI79GYwymxdttqPKE4rtDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CFW0UoQ0x9XpQT/Uf6HnQVJkHf5Z1WXfa+3d1HVmqa6zmZqVjrrXwKyeRK1CFBj9neUzXHuRCtiF+VkOxF/AF0qSjRcWHBB3FsSTjB6tnsA2iYjbAgWUFR6O6WtQR7aYz1qLOIdIrQTpU+txJnU+xGWw2+fnyfPj8rJQP+yPMVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/5utOKY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36074C4CEF1;
	Sat, 20 Sep 2025 16:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758385493;
	bh=OsZkTOUSdYN93gDiPavU6jI79GYwymxdttqPKE4rtDE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=o/5utOKYdl4onN9Rv7w89chRCnMZtE/EfpcEuu64z76UTj/2qLfSOcEMEpSD8e49+
	 uswww9LOX3QPjxS6rLirwvUjGUkh7c+UCwuOjUGPba3+GJkoJe8ilZYdEs/jyP/KgC
	 KQPfqHCaJxWEly7jDiY7KveHqndcxjBWgZMsvAjwConn7aiIj62VgCRn/xKis6RNAs
	 SfCW9HkZ7H+yCAG+VjB8lgNdrJm7UoSDcNf6TGxPz34qb8k5xB54mlMshvqFdsV4fG
	 1TJgVWPhzsJON6oE8GMKFMjhBGvvOpf7LdpUxXW5tLnTHOFm3mJFMcHnaw0n47CgLY
	 oP1zmQATQE4Uw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FE8CAC5A8;
	Sat, 20 Sep 2025 16:24:53 +0000 (UTC)
From: Cristian Cozzolino via B4 Relay <devnull+cristian_ci.protonmail.com@kernel.org>
Date: Sat, 20 Sep 2025 20:23:27 +0200
Subject: [PATCH 02/10] ARM: mediatek: add MT6582 smp bring up code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250920-mt6582-v1-2-b887720f577d@protonmail.com>
References: <20250920-mt6582-v1-0-b887720f577d@protonmail.com>
In-Reply-To: <20250920-mt6582-v1-0-b887720f577d@protonmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@mediatek.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 phone-devel@vger.kernel.org, 
 Cristian Cozzolino <cristian_ci@protonmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758392693; l=1555;
 i=cristian_ci@protonmail.com; s=20250620; h=from:subject:message-id;
 bh=6uGXxS/2ULG475fJT7BkyoFxyDRGMUY7v8S8MSscjII=;
 b=0BSKMlESDh0HSgKA66zOwG/vKXy8rumfTbKH0/oBaj0WYfPac5Dr3DPsPO7BXsVTtuPGbzNcu
 6MV2oVqGHcxB08BzovBXSx3YPLnOAlJR9v3yh/Jm2NO5zhidVkE4axn
X-Developer-Key: i=cristian_ci@protonmail.com; a=ed25519;
 pk=xH5IvIPUNHV1Q8R0/pq2CfuVFR/wTiAyuyi6IwedjZY=
X-Endpoint-Received: by B4 Relay for cristian_ci@protonmail.com/20250620
 with auth_id=438
X-Original-From: Cristian Cozzolino <cristian_ci@protonmail.com>
Reply-To: cristian_ci@protonmail.com

From: Cristian Cozzolino <cristian_ci@protonmail.com>

Add support for booting secondary CPUs on MT6582.

Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>
---
 arch/arm/mach-mediatek/Kconfig   | 4 ++++
 arch/arm/mach-mediatek/platsmp.c | 1 +
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 638eabad2dd37ee56244fc036cb76af135aee416..64ec487c13abd81dd9a866d29b8f47d9ed42490e 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -19,6 +19,10 @@ config MACH_MT6572
 	bool "MediaTek MT6572 SoCs support"
 	default ARCH_MEDIATEK
 
+config MACH_MT6582
+	bool "MediaTek MT6582 SoCs support"
+	default ARCH_MEDIATEK
+
 config MACH_MT6589
 	bool "MediaTek MT6589 SoCs support"
 	default ARCH_MEDIATEK
diff --git a/arch/arm/mach-mediatek/platsmp.c b/arch/arm/mach-mediatek/platsmp.c
index bbd26d423bdef23629ec5ca9d9c61903748988b7..6b0943d95555afa52d134183c61ab6d5c1495ff1 100644
--- a/arch/arm/mach-mediatek/platsmp.c
+++ b/arch/arm/mach-mediatek/platsmp.c
@@ -56,6 +56,7 @@ static const struct of_device_id mtk_tz_smp_boot_infos[] __initconst = {
 
 static const struct of_device_id mtk_smp_boot_infos[] __initconst = {
 	{ .compatible   = "mediatek,mt6572", .data = &mtk_mt6572_boot },
+	{ .compatible   = "mediatek,mt6582", .data = &mtk_mt7623_boot },
 	{ .compatible   = "mediatek,mt6589", .data = &mtk_mt6589_boot },
 	{ .compatible   = "mediatek,mt7623", .data = &mtk_mt7623_boot },
 	{ .compatible   = "mediatek,mt7629", .data = &mtk_mt7623_boot },

-- 
2.49.0



