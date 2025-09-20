Return-Path: <linux-kernel+bounces-825772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CDBB8CCC9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 18:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F243A3BA8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 16:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A02302161;
	Sat, 20 Sep 2025 16:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPoqBo9P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D11310E3;
	Sat, 20 Sep 2025 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758385493; cv=none; b=blQBBA8MW8q2ryntoqMo5ZPaqM+Gw/mOpNItGaagz/VXW+A3inxueGvODEeJiC1mSqufIrqMNEwWqxTW62V+CpcD9zt/h/zqbUTgBOCPyxTabLClpCqiVlb4lVg9oItJ3pTNcE/uAekam0Z8M67pUUz+MwLzlmNcg6z5bNJyCyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758385493; c=relaxed/simple;
	bh=PAEbSGe1wIOU1VKhTsFGw4i3kezoEQ7HO0g02DBBGic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lQEfuhJSxRHC5CrmRz0mDY9cQnJPxUDh3UT8IKah6kUyccwTOdxxkfKSe8dLdRH+d8bE5Jo3oMnd0BK6fEz45j77G1Ovq9XzYYnGpr2FIGS17vbMCJ0TNZliAK+nsNdLR3vOBiiBxFuH5bC6464J3t862XW0t+Pn7nDX/nHvvks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPoqBo9P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29646C4CEF9;
	Sat, 20 Sep 2025 16:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758385493;
	bh=PAEbSGe1wIOU1VKhTsFGw4i3kezoEQ7HO0g02DBBGic=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kPoqBo9PkEIpeYKdsrGhqwwHJL5OMHsElMvH2vvivU8Pyj2PZxule376bxZnJkwNU
	 Tw4xgugwq5gkQtp+NSjclN5LiU5ACYNg9gzUYgdNSrYt9MaG2DcVzc3SiHiZF5PgIO
	 APJh8w0YsR3gnnjp1/aHvGZTGzYSQOQmHmslCy/r1TOaV6KjIfM7yebTrVOe+RwW+U
	 gfNk6ymVv2Nu9aN0lnO+ez0IB/c9ZybZQ/zbH/s7inMr9LkOPvgXOLUCrhAH6yxGiR
	 7WdcFxlxAPYxoSg7j4VJE6WNzvl2NGSRkJcFG3xgjSlL3/lPoEi9JpoU2XQkT0CApB
	 P1FJxdrOWdC2g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1863CCAC5A7;
	Sat, 20 Sep 2025 16:24:53 +0000 (UTC)
From: Cristian Cozzolino via B4 Relay <devnull+cristian_ci.protonmail.com@kernel.org>
Date: Sat, 20 Sep 2025 20:23:26 +0200
Subject: [PATCH 01/10] ARM: mediatek: add board_dt_compat entry for the
 MT6582 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250920-mt6582-v1-1-b887720f577d@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758392693; l=726;
 i=cristian_ci@protonmail.com; s=20250620; h=from:subject:message-id;
 bh=rPW5X0dJhrkjRCNNcYv6faj1inNTS9fRmw61VUQKL+w=;
 b=sk3kgTpc2Yx2+z5wdsgMX0XRjqoO+k8vc8osDkRpQFyJa/JHqcBSNo/vrm8lBDnIOJq4DyTco
 DiaGwpso9ZNBl0PDGiYXz4Q63P8uiDz5rqVgpgW0C9YVonlimW/SX20
X-Developer-Key: i=cristian_ci@protonmail.com; a=ed25519;
 pk=xH5IvIPUNHV1Q8R0/pq2CfuVFR/wTiAyuyi6IwedjZY=
X-Endpoint-Received: by B4 Relay for cristian_ci@protonmail.com/20250620
 with auth_id=438
X-Original-From: Cristian Cozzolino <cristian_ci@protonmail.com>
Reply-To: cristian_ci@protonmail.com

From: Cristian Cozzolino <cristian_ci@protonmail.com>

Add a compatible string for the MT6582 SoC.

Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>
---
 arch/arm/mach-mediatek/mediatek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mediatek/mediatek.c b/arch/arm/mach-mediatek/mediatek.c
index 5c28124bd0078b31665fef647e496f4131b82c8d..fd3a8834fc4fd47adcc91c0d9371d4a1e9c0a7e6 100644
--- a/arch/arm/mach-mediatek/mediatek.c
+++ b/arch/arm/mach-mediatek/mediatek.c
@@ -39,6 +39,7 @@ static void __init mediatek_timer_init(void)
 static const char * const mediatek_board_dt_compat[] = {
 	"mediatek,mt2701",
 	"mediatek,mt6572",
+	"mediatek,mt6582",
 	"mediatek,mt6589",
 	"mediatek,mt6592",
 	"mediatek,mt7623",

-- 
2.49.0



