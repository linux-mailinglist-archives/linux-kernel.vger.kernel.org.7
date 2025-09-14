Return-Path: <linux-kernel+bounces-815691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FDBB569DC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 16:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE27218828FB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23F225F99F;
	Sun, 14 Sep 2025 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="tuK3V7Vp"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0C318FDBE
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757861684; cv=none; b=RYvkC2Cn5yydY/9ljfTApIAC3XPM8nheceOCzLTqTacmsJ2r0vJCDlJNzP7EO3QkJ+JohqxWTbBzSVLZE0kEiRksi1crvtyWRXRTsX5S0uKfQonlb8S9S/eNibyK5JrrMNOAQS6/NJwsqEAD4/bg5g2Y2XoebAUYldAV0HiJm30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757861684; c=relaxed/simple;
	bh=Q7M1qPiBwZ81yv2zjfrhsqb0rQtSNwVod0HJ4zI5fms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T0dXa2L6hNcyhn9x2NxJjeMUuIV9cmblIQy+G0SNqqk/gIafocQC/Pxksdb6GCaxhj1raf0T3vM5/oowWJCYwtOkhV4eMOKQ4JHWOv7tW+rE0xpCb7HfmMvOOEsy9Zw49sa6TyiElZC2l1qYcGd17V0JxKmqdeDjI8vxyXm9UVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=tuK3V7Vp; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=tuK3V7VpvgeuZu7KFl/6V1aGa8dz5I/wWRq7YVMO57vMw/uzWtpOtHDFUT7fMDDoWUKjc3ohi/lN2Anzzbo26kHn4oen1V6By9aJ3+C0v5WvYGnOAgUMHqcKAnx/zXLLybWQVMUhn9f4U4ZJK2Waq9q9oJeCWUqag5T7hUiQolh9fR6InO/91dD7+vGMahzd29VQ7P7ivW8jhurd2VvsGokk3t92TeTW1TD7VTVE5oCkWaNX+snQ+7kdcng6swsEVpCulF/iFoW8OnmEojPPRN90/T0jD2WJtA792gvxdGBnReurPYo7u4Ul2y/GB3zp2aABZZe3iQ0D0naCz40jlQ==; s=purelymail3; d=purelymail.com; v=1; bh=Q7M1qPiBwZ81yv2zjfrhsqb0rQtSNwVod0HJ4zI5fms=; h=Feedback-ID:Received:From:Date:Subject:To;
Feedback-ID: 68247:10037:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1880024390;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 14 Sep 2025 14:54:33 +0000 (UTC)
From: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Date: Sun, 14 Sep 2025 16:52:00 +0200
Subject: [PATCH v2 2/4] pinctrl: mediatek: Add debounce times for MT6878
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250914-mt6878-pinctrl-support-v2-2-254731aa3fc2@mentallysanemainliners.org>
References: <20250914-mt6878-pinctrl-support-v2-0-254731aa3fc2@mentallysanemainliners.org>
In-Reply-To: <20250914-mt6878-pinctrl-support-v2-0-254731aa3fc2@mentallysanemainliners.org>
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@kernel.org>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757861668; l=1534;
 i=igor.belwon@mentallysanemainliners.org; s=20250908;
 h=from:subject:message-id; bh=Q7M1qPiBwZ81yv2zjfrhsqb0rQtSNwVod0HJ4zI5fms=;
 b=chyid+n/OiWfG6Xu5ENOh7AJqaaOJaZgKFZxpx5EbRdy5qhLCb2WiRdLnpEU5WNcQdRry5au8
 cYpGEy279tbAfCNoPbwt9Rq5sKAJQinRXb0AHdIRAvUi0xExA2HixpM
X-Developer-Key: i=igor.belwon@mentallysanemainliners.org; a=ed25519;
 pk=t9Kz6B3jEwJD7YAKcp8XftfEz7SUSlGbrsfFlbrrFwA=

MT6878 uses different debounce times than other SoCs. Add them to the
EINT driver.

Signed-off-by: Igor Belwon <igor.belwon@mentallysanemainliners.org>
---
 drivers/pinctrl/mediatek/mtk-eint.c | 5 +++++
 drivers/pinctrl/mediatek/mtk-eint.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/pinctrl/mediatek/mtk-eint.c b/drivers/pinctrl/mediatek/mtk-eint.c
index 9f175c73613f84b47c0160947f32da7aca7d5a18..c8c5097c11c4d14eb41bdd7f9cb93b4a5756d2b2 100644
--- a/drivers/pinctrl/mediatek/mtk-eint.c
+++ b/drivers/pinctrl/mediatek/mtk-eint.c
@@ -66,6 +66,11 @@ const unsigned int debounce_time_mt6795[] = {
 };
 EXPORT_SYMBOL_GPL(debounce_time_mt6795);
 
+const unsigned int debounce_time_mt6878[] = {
+	156, 313, 625, 1250, 20000, 40000, 80000, 160000, 320000, 640000, 0
+};
+EXPORT_SYMBOL_GPL(debounce_time_mt6878);
+
 static void __iomem *mtk_eint_get_offset(struct mtk_eint *eint,
 					 unsigned int eint_num,
 					 unsigned int offset)
diff --git a/drivers/pinctrl/mediatek/mtk-eint.h b/drivers/pinctrl/mediatek/mtk-eint.h
index fc31a4c0c77bf28b106943e9292d0dcc425c4922..3cdd6f6310cd0da5aa74623c5f1dbe8f8495d689 100644
--- a/drivers/pinctrl/mediatek/mtk-eint.h
+++ b/drivers/pinctrl/mediatek/mtk-eint.h
@@ -52,6 +52,7 @@ struct mtk_eint_pin {
 extern const unsigned int debounce_time_mt2701[];
 extern const unsigned int debounce_time_mt6765[];
 extern const unsigned int debounce_time_mt6795[];
+extern const unsigned int debounce_time_mt6878[];
 
 struct mtk_eint;
 

-- 
2.51.0


