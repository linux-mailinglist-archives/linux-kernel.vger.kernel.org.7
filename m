Return-Path: <linux-kernel+bounces-827455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EC2B91CF2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6B9D189C2A2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1635E2D6E66;
	Mon, 22 Sep 2025 14:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="SIm6yQ9+"
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com [136.143.188.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5BC2D29AA;
	Mon, 22 Sep 2025 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758552892; cv=pass; b=RAstOt0VM8XMb9pSbJ4CQ8bxvTUFUiSsHRurgwf60WkOiDoZ9l/6J8ROStd9PPv7fjM/yGCgTyxMq4wiHq+1EPHe2AiijvkxSDzl6G4HGYN/V13aeHS04zz9Lr9wAtEVYn/pu+66M7u1Ixajez6c994Dd1edO13/idt4gR9Sv+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758552892; c=relaxed/simple;
	bh=QTzyuKcq78b1rHf4U4+Ek5P0fIK1pBd2tg1GAgtsSh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WhzXDBv9YNhelfS6p013J8doxMG4xWOXh7LJhWRrK4GoKoQyyQVnZW8vTUVMxrSLFuBmwVW7TdI9DX89BctIVSLvr4tUWpvKJsKLLJQ1nA2nLn/qe94NKL0oZtP1LCVR1E06ufyhyredmFYV1n7yPAKdsez190erkAT+2J40dUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=SIm6yQ9+; arc=pass smtp.client-ip=136.143.188.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1758552868; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RN45ZZ4SGRe5sVd7IraZ6S8tyQq6AraGsKpx8uCJ3ZiXShgEZjQHgTbpgVCHCBgHP+t42nZ5HCCX83vLuOf3cKd3v/GkgYmjG7aL5PDske8cGdesWrtiReAkwxLataJ8nlwTVZpQXFXhfEMNUv8Os0Ovm5K4NnUFKnfSMtM/a2A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758552868; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=g5ht2Ynuy4olVC7AOTttqtZQ3VZCttE+E0h1vADll6c=; 
	b=jI7/1QD/ayp2NBJkG6G7e9UaJ8lacuYLurWhaP7Q2ncxI6PWk6WG8IDNsZKHW0+GnOC1lGF5PFLjjs/nPYCRAaJyjPKwIMso5YZiJGDIM2f7yBfxxLbN867mHYWBxRrxauUm88FvqhgMub15ZHekB1K2AZs/nfSaV9KpyCNOGbw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758552868;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=g5ht2Ynuy4olVC7AOTttqtZQ3VZCttE+E0h1vADll6c=;
	b=SIm6yQ9+ClUeq3mVjJ5Q/4P4s0j+YNAHR9XwtaiC8f82d68HsXuoCxqDS1CsoRS8
	/rF7kw0VGrd9OjFl+yBAm8a9qV1kVaCBwo84fASgYucrO/qvhwr1N5Am4r9MRBGVZxf
	GL1YeseEQB+ssIf9f5tAY1uUEmx/YUnEbUNEUb+c=
Received: by mx.zohomail.com with SMTPS id 1758552867183905.6994838386554;
	Mon, 22 Sep 2025 07:54:27 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Mon, 22 Sep 2025 22:51:47 +0800
Subject: [PATCH 1/5] clk: correct clk_div_mask() return value for width ==
 32
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-dr1v90-cru-v1-1-e393d758de4e@pigmoral.tech>
References: <20250922-dr1v90-cru-v1-0-e393d758de4e@pigmoral.tech>
In-Reply-To: <20250922-dr1v90-cru-v1-0-e393d758de4e@pigmoral.tech>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Junhui Liu <junhui.liu@pigmoral.tech>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 "fushan.zeng" <fushan.zeng@anlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758552834; l=1200;
 i=junhui.liu@pigmoral.tech; s=20250910; h=from:subject:message-id;
 bh=QTzyuKcq78b1rHf4U4+Ek5P0fIK1pBd2tg1GAgtsSh4=;
 b=1ttbEuj65evPw6Elmvdyk7dxGu6wEYUJfmGmo4S/ZNhG5vHJThOFDEMqkdCipXqGi+Pjh9RFX
 7GuI6Ihokj1AptRvH/sj+RLrmINE7j2B2rV6BC1Rjp8spSV9puPYzN6
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=cgATWSU1KfGWmdwNmkPyHGnWgofhqqhE8Vts58wyxe4=
X-ZohoMailClient: External

The macro clk_div_mask() currently wraps to zero when width is 32 due to
1 << 32 being undefined behavior. This leads to incorrect mask generation
and prevents correct retrieval of register field values for 32-bit-wide
dividers.

Although it is unlikely to exhaust all U32_MAX div, some clock IPs may rely
on a 32-bit val entry in their div_table to match a div, so providing a
full 32-bit mask is necessary.

Fix this by casting 1 to long, ensuring proper behavior for valid widths up
to 32.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 include/linux/clk-provider.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 630705a47129453c241f1b1755f2c2f2a7ed8f77..a651ccaf1b44ff905c2bd4b9a7043f9e2169d27f 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -720,7 +720,7 @@ struct clk_divider {
 	spinlock_t	*lock;
 };
 
-#define clk_div_mask(width)	((1 << (width)) - 1)
+#define clk_div_mask(width)	((1L << (width)) - 1)
 #define to_clk_divider(_hw) container_of(_hw, struct clk_divider, hw)
 
 #define CLK_DIVIDER_ONE_BASED		BIT(0)

-- 
2.51.0


