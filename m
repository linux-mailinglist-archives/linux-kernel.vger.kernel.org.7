Return-Path: <linux-kernel+bounces-870387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 667C0C0A905
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 15:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBCB33AFF6A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 14:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB83240604;
	Sun, 26 Oct 2025 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="D+qD3Ktu"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04F21EDA2C;
	Sun, 26 Oct 2025 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761487809; cv=pass; b=GX3gAe/1SBfg6MiFYjSYVZuzOMVY1bHVd8SmiRF7T87AgNOXvi2OIavjyUT2AIXlljbqFY3p94gXizmVI8Csdys7J9ieqXRbU1X3/5itTVpIOApt57IqHeDYlgHYKg3M3rQTW312CGz+ziBm/i+Kf/BQczD6zb+gETK838Z3E40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761487809; c=relaxed/simple;
	bh=7/UVqIqnf4eo/7LUhhfYZZ+DfTO8tqTc+Wv8YNWh/fY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mcP2B6dtUjBbhX9iVlr5s2zmXO/bI/KO4Ky1yLczzkJM2Qn3XC7nvWEJKrPjqrPcoAUT+fFJgcESNX6ElUsUjV+qAEYgrjdthfpD8bOBaqEdqWD62/E/yk/ymkpXzZ+JMFhNbEwTnOzuDJOZIq4btxtlOWJ2u6ldZUeiuBLrXHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=D+qD3Ktu; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1761487778; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=R7/Kio8AJVFFc2Ptav57+hb7JjqIWmsd/L0aWLyqewkQWwQyBxKGMHrhSdZL61Tykwx3UF6VLACMY8z7ViKFcoMCd0SyLzEKI8+KK7TABzcM79Oujk8LwqcRV+Nrb/wdmGGplBBt4jcovgGK2aCCdq8FxJcBv0eE4Afzv96lX/k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761487778; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=E8yjXuWAHvV6vcYuCnK/LIsovNlBw6mNZGJWIQfRA78=; 
	b=g7PLEKTo9FX42oVf4Bad/5l6Fyjq1DGOoarJopZnYpiu0WB414Y8FLiI59NRVY6xZBqvLCs+E0LMuzEhUy9riZrKnlP/SryeaB/qiLiy8q4GgsoJ6dgyBIHsIBe2ewmHZfOLEZ7RM5tAuy52XMiSzpbmb1nXr1bvMzXjSTcRklo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761487778;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=E8yjXuWAHvV6vcYuCnK/LIsovNlBw6mNZGJWIQfRA78=;
	b=D+qD3KtuoNKTgEapPV2y9k7kcfpPoSVcCIawMCbnDqFj99FMrKhPmKq65ZAntz9n
	/ElWZWOT00NH2iBhMVWdHbiGKTEr+e/lPxsDN61i6XemFshC/kYxX7SP/RuDElXzxOv
	hYtYyajzwlYPGmSxDSNQ1+l/BbI7bUAg+yJRzFyg=
Received: by mx.zohomail.com with SMTPS id 1761487774155471.7747200896756;
	Sun, 26 Oct 2025 07:09:34 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Sun, 26 Oct 2025 22:00:41 +0800
Subject: [PATCH v2 1/6] clk: correct clk_div_mask() return value for width
 == 32
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251026-dr1v90-cru-v2-1-43b67acd6ddd@pigmoral.tech>
References: <20251026-dr1v90-cru-v2-0-43b67acd6ddd@pigmoral.tech>
In-Reply-To: <20251026-dr1v90-cru-v2-0-43b67acd6ddd@pigmoral.tech>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761487753; l=1263;
 i=junhui.liu@pigmoral.tech; s=20250910; h=from:subject:message-id;
 bh=7/UVqIqnf4eo/7LUhhfYZZ+DfTO8tqTc+Wv8YNWh/fY=;
 b=E0loCwSup45u/X35105lYlPt15ypmWkBsyZ64zyYwXF+DX2IqzAw5836O0FlGLydzLauHjEYL
 3TGT28m2L0HAuxgCi3+QHokXq5VcgOzaJ7l396Y4CexBxFE73kQRuJa
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

Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
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
2.51.1


