Return-Path: <linux-kernel+bounces-752248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E62FDB172F7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593F51AA782C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21252D2390;
	Thu, 31 Jul 2025 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="wc/6XWjF"
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F28928D8DA;
	Thu, 31 Jul 2025 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753971282; cv=none; b=Ixoil6k7XME3X57HMAumOO/EPxqCKQEQx7IJPnIds498gDk5il1cQ24moW3NOejdVe6vjkD0LfxyK6Kv2SlARIwx7AKC3JaiK6IAgEldbYlqrC63uVctjNfPFTlNzYY7rRrwaGC2JyVO01zVI/db30F56yZy8ZvPzsOg8rtqiuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753971282; c=relaxed/simple;
	bh=MeZJ7iFErxrIWkTZf3XiMeKPBVZVufDsMgudwp5Pj30=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FhKiYkAvpa2Epy7RjpYEcORAtxWlC/BNRexgjPWV5TIiRbsGVZzkKBgxxI5hh1MkwzYvvIZ7+p3epOFOq9PGfq08dU06OhYh4piyQBoDY4mS8sWdg7n1LRqdI/XjtH1rkkju5OZZzUKW0/kzdi3w3sYbkEULg30uyQkR+miFp0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=wc/6XWjF; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1753971260;
	bh=y5AT6lF5XTZBycAdijjBHgbPYBOSCrxMOhOkBi/y28E=;
	h=From:Subject:Date:Message-Id:MIME-Version:To;
	b=wc/6XWjFrjtvGx6PXHZArOubpKzFeSyRiZbvvk+vWtDIkz+ILUHEc+edZMAsGxlKr
	 M+rBPLo4ZqfwM90ODTq5PrWiHMqD4tCQpMU5KGM7SZgFPVMr38TREcMd3I45maTbyO
	 BFYC5XVQcu5hP3HGCeNuN5WBJjLk3bejTzokWhrc=
X-QQ-mid: zesmtpip2t1753971254tbad9d452
X-QQ-Originating-IP: kw5QdBICyGZpE/R01gvvA+wL8LDI2K5Km7e1hNHDSm4=
Received: from = ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 31 Jul 2025 22:14:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11873278860039367758
EX-QQ-RecipientCnt: 16
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: [PATCH RESEND v3 0/2] clk: spacemit: fix sspax_clk
Date: Thu, 31 Jul 2025 22:14:05 +0800
Message-Id: <20250731-k1-clk-i2s-v3-0-2f655ddb0c6f@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC16i2gC/23NPw+CMBAF8K9COlsCV0jByUFWBx2NA5SrXPgbi
 g2G8N1tcMHE8d3L/d7CDI6Ehh29hY1oyVDfuSAOHlNV3j2RU+kygwDiQIaS1yFXTc0JDMcIJOh
 Qp2FcMPcwjKhp3rA7u2a37HJmD3evyEz9+N42LGztlwPYcxZ4wEEnWGoUZV5Ep4a61+ybIVfY0
 uSrvt08K/ZG8mMIZ8SljGWqAwCQf411XT+BjA8f+QAAAA==
X-Change-ID: 20250717-k1-clk-i2s-e4272f1f915b
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Alex Elder <elder@riscstar.com>, Haylen Chu <heylenay@4d2.org>, 
 Inochi Amaoto <inochiama@outlook.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Yao Zi <ziyao@disroot.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753971252; l=1801;
 i=troy.mitchell@linux.spacemit.com; s=20250712; h=from:subject:message-id;
 bh=MeZJ7iFErxrIWkTZf3XiMeKPBVZVufDsMgudwp5Pj30=;
 b=l5Pw2gYPmhUkf1L5UIOu0v+z7f9SM0aedihENvDPX6gEWxnmNZNHB+um3AiA0UeUkp491rvx8
 D1hJ639UelfARKtSab+txoWd56/wQa1RXBmSAMdfXDLfnHbhwxgcdUS
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=zhRP1xE0bftrurqSWI+SzcSdJGIZ0BTTY9Id0ESzqlI=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MWcocoo7mKajzQAUh/oZwuWFFrVg6hQz5vSZvAWlEMK85Q6SaIEN7apG
	zmOG9sskcnZ+YzpTWCOjTfV3YGGukoVd1gAbkKHG1jkjfTvsU1xmPl4adhBu5len5VmpMG0
	A37VwNWt3N0WfPlXj1ffFLP9Nq+RQPV0OPsLBB3Lidiu888ZruFS4NzCN9qYwdx6z4amONa
	R+iYVWbg3FVNdOoaI0PqFHI9FHqw9oLzhN4e/jFGqq+RLgwd47Y4ktzWfrzz4v7Qc9IJBzn
	prZs+wae3tn4CL5qfS94vhpyKwU0xS591bzkftTNL6VPaoingAMsOb2X9ogLVsXuYyjCBXF
	UA+X4vHlJ8fsxBB2rOf/hRVzyO3yiRAKQLB6FW5I/7BJPz5HrClxkbWdyAnccGhN2y+Ws5O
	Fe/dnSsUvj6KLnS7EOmleA6uIFsBBWB3tvlPdh62jRQtfLN9u9KpsPNo3b5cqfz5xvZ6ArT
	mELyKouRJkUJgz/TqJJ/q+isjKXOUvY26Nr0h1ldcVbRCcVYH+zNhLdZEbuNAyiTBYaewuH
	YQHuzVHJnbatJQg/C4RFqhNpL5epIEdkxprBQT6y01zb2AicGgqwRkqR/Ll/9dxsrREdjro
	H2trP/q5dibt1n2h1Y5tQI5nLK8Sp0dnhxv0uATImpCT5KEpK9ywMfPz1SSobfWYKR6gLd/
	oOVaO6OIPlu4JVYdgbawf0WwIiKIt+rcGwQCFWqYc+90hRz6EqCrS6GO4zRExGuyL1kLTlj
	L3B0VNj/9cBnA9ElSoK3xTzcTC6mu2iWAjqkCFzuV0MaBuEQ1Lp++jSIH+RWS2kH09agm/9
	QzS4C6QXFPfDLchUXdq4J/rE/DH0RbVT8f5zw374iuuzLTiEYakM58pYlmK4u7I58w/L2vH
	GDG5UMK4yO74CdO68E6bGTnqeWdx21sT8Spy6Cuczsq2N8Cq8h5aJibjeyciAoy4dtfRAvb
	9SiT5dg9JrljW8IULKYSc4R0hIe/Ef55g8u2lDkcEFST1r65yIaon6F0C1IZsx7gC19zQW+
	lli9LOtLQ665wiitbfiWBQcxVDnjD/5Yfcv4Yy3R5Z0+5iq9/Qmg4mQgj62/YF1sA1yGsBK
	+bNloM9GzLgqv+pbPY8NASTsN8GN66eACIDpRA2b7GfxxNAYkpU/fzd1ci6rU4JtUN+1KEd
	mMyxmO5scyAJjHt72rG3Va7rQA==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

In the SpacemiT public document, when the FNCLKSEL field of
the APBC_SSPAX_CLK_RST register is 7 (3'b111),
which is a reserved value. And BIT3 of the same register is
a reserved bit.

But the documentation is incorrect. In reality, the value 7 (3'b111)
of FNCLKSEL is not reserved. Instead, it indicates that i2s_bclk is
selected as the parent clock. Similarly, bit 3 is not reserved either.
When FNCLKSEL is set to 7, bit 3 determines whether i2s_bclk is actually
enabled as the parent clock.

In all other cases (i.e., when FNCLKSEL is not 7), bit 3 has no effect.

Importantly, whenever FNCLKSEL is set to 7, bit 3 must also be set to 1,
otherwise the selection of i2s_bclk becomes invalid.

Fixes: 1b72c59db0add ("clk: spacemit: Add clock support for SpacemiT K1 SoC")
Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
I sent with a wrong email so resend.
---
Changes in v3:
  - Fixing ABI-breaking behavior
  - Modify commit msgs
  - Link to v2: https://lore.kernel.org/r/20250722-k1-clk-i2s-v2-0-2f8edfe3dab4@linux.spacemit.com

Changes in v2:
  - Use virtual gate instead of new function for sspa
  - Add Suggested-by tag: Yao Zi
  - Add Fixes tag
  - Link to v1: https://lore.kernel.org/all/20250718-k1-clk-i2s-v1-1-e92c10fd0f60@linux.spacemit.com/

---
Troy Mitchell (2):
      dt-bindings: clock: spacemit: CLK_SSPA_I2S_BCLK for SSPA
      clk: spacemit: fix sspax_clk

 drivers/clk/spacemit/ccu-k1.c                  | 25 +++++++++++++++++++++----
 include/dt-bindings/clock/spacemit,k1-syscon.h |  2 ++
 2 files changed, 23 insertions(+), 4 deletions(-)
---
base-commit: 733923397fd95405a48f165c9b1fbc8c4b0a4681
change-id: 20250717-k1-clk-i2s-e4272f1f915b

Best regards,
-- 
Troy Mitchell <troy.mitchell@linux.spacemit.com>


