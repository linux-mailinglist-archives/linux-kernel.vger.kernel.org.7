Return-Path: <linux-kernel+bounces-824712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6814AB89F65
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA587189D3B7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0D73168F1;
	Fri, 19 Sep 2025 14:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="FKN0ZR6n"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EE5313D50;
	Fri, 19 Sep 2025 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758292063; cv=none; b=asQWG7rvEwBq4k29PlsLYVqf/THLhtvYlq9SFoJ04dX2TWnHEKF+BMTua0NPJyjACK3znxm4Gw7vCCwX4vonxa8phdnrrHRu0PlNbPwvmZkKJd5sTDJ0pqSFfvvdC+YB0DAvxLsSi3kVrSVO06AXgcDS6aMEf+WXKQjy72/JOaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758292063; c=relaxed/simple;
	bh=W3t9oodd0h8mbXHDxSoPHsP9rVuywlZj0hRu4ydwEWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OK7jTQOFgUs4UExsjDed3rPwCZCas6PrSHCuxLsApxJsHhtZdw0rmxPtpvJjcnb5xd74/Rgt5PPQxDIeRZt5wPkdOLxrLOAtxK7p/0EIvz+HWOYsQj6Zg8a4Q2hmyXlMr+/v07jI+TeMixkJJWLlUMvzCX4k0ippOEjJaVvZRhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=FKN0ZR6n; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 7841720CA1;
	Fri, 19 Sep 2025 16:27:40 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eeExqzb8AmV2; Fri, 19 Sep 2025 16:27:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1758292059; bh=W3t9oodd0h8mbXHDxSoPHsP9rVuywlZj0hRu4ydwEWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FKN0ZR6n/og1Oo1c8HN37DVf7lMad1bmDYxi+TKbsgM9hUGqpJbqssZ1CaiCGu4i9
	 0KHUzbKoT2ZoSoqzZjr5a6uCIO9mpeqQv99MvqCp0KMd87u3URf/l/ufw/4qDts0W7
	 DER6fy6FO44M8bZVOmiTQMcfjH5ZRfxu0X0ZY5Lq2ZtryWSr70LE9UfjNbFuCe26T1
	 jOlrq7yOwAT+8I/cwUzu+oKGpdyYSjwj4dZHyrO0yy9PS0Ji+7+Yvp0HWd+lKlkYQY
	 RuaXLq6dl+GpW5X64ssXYe8h1wb/jCjL6DDIK2XiTJDGwpjHz+Fz00OvOkJ1FNDB1r
	 865SzWLRFxJWg==
From: Yao Zi <ziyao@disroot.org>
To: Yinbo Zhu <zhuyinbo@loongson.cn>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH v4 2/8] clk: loongson2: Allow specifying clock flags for gate clock
Date: Fri, 19 Sep 2025 14:26:43 +0000
Message-ID: <20250919142649.58859-3-ziyao@disroot.org>
In-Reply-To: <20250919142649.58859-1-ziyao@disroot.org>
References: <20250919142649.58859-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some gate clocks need to be supplied with flags, e.g., it may be
required to specify CLK_IS_CRTICAL for CPU clocks.

Add a field to loongson2_clk_board_info for representing clock flags,
and specify it when registering gate clocks. A new helper macro,
CLK_GATE_FLAGS, is added to simplify definitions.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 drivers/clk/clk-loongson2.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-loongson2.c b/drivers/clk/clk-loongson2.c
index 27e632edd484..cc3fb13e770f 100644
--- a/drivers/clk/clk-loongson2.c
+++ b/drivers/clk/clk-loongson2.c
@@ -50,6 +50,7 @@ struct loongson2_clk_board_info {
 	const char *name;
 	const char *parent_name;
 	unsigned long fixed_rate;
+	unsigned long flags;
 	u8 reg_offset;
 	u8 div_shift;
 	u8 div_width;
@@ -105,6 +106,18 @@ struct loongson2_clk_board_info {
 		.bit_idx	= _bidx,			\
 	}
 
+#define CLK_GATE_FLAGS(_id, _name, _pname, _offset, _bidx,	\
+		       _flags)					\
+	{							\
+		.id		= _id,				\
+		.type		= CLK_TYPE_GATE,		\
+		.name		= _name,			\
+		.parent_name	= _pname,			\
+		.reg_offset	= _offset,			\
+		.bit_idx	= _bidx,			\
+		.flags		= _flags			\
+	}
+
 #define CLK_FIXED(_id, _name, _pname, _rate)			\
 	{							\
 		.id		= _id,				\
@@ -332,7 +345,8 @@ static int loongson2_clk_probe(struct platform_device *pdev)
 							  &clp->clk_lock);
 			break;
 		case CLK_TYPE_GATE:
-			hw = devm_clk_hw_register_gate(dev, p->name, p->parent_name, 0,
+			hw = devm_clk_hw_register_gate(dev, p->name, p->parent_name,
+						       p->flags,
 						       clp->base + p->reg_offset,
 						       p->bit_idx, 0,
 						       &clp->clk_lock);
-- 
2.50.1


