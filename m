Return-Path: <linux-kernel+bounces-762748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A90FB20A8B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9D018A2866
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC692DEA9D;
	Mon, 11 Aug 2025 13:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="x1JfPdFO"
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D232DEA7E;
	Mon, 11 Aug 2025 13:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754919672; cv=none; b=WrxNLqxHA+5D2mQA+N6IpbdTB72AuLxKjJnq78Eeepvaq0+4iwoOTpJUZ3btDKpDUuG5pvDnr7Wr5CdjU30ntB0srRNRMxql1dNCFCky5qHDNSyM5pOWumyfaQW7gkVooB7yZipPIlMH2+EJXglfC9jL2mHkNmUpba3yuCHnLkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754919672; c=relaxed/simple;
	bh=ZUrL1GUtAJCNKt2pUUAfCSXGuuvKhhmY6ZNaHjLFvb8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CylhYr1guPTWVkXWncEsM+eaX+6vdawBISYRo8TREbSITnqYXFysRfduwqtD97weYRG80gQuwf5UZlol3+Md8musR5MgU6CgZ8fFhBvlV/i9AF/6rRIcRDzBrAgPQoYN0v7Ca1yITBpammoT+IXFnnfiQ24ZgRzczgrxj8XcSSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=x1JfPdFO; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1754919645;
	bh=O7QkqLL1Uz4POVfUWaVHKWCebfO78hHJLlMwMJBxzhk=;
	h=From:Subject:Date:Message-Id:MIME-Version:To;
	b=x1JfPdFOEO2pNv3yYQpdmMP6Zwixb79qmK4f1DEC5YYTFzvm5tPw48ofjqwPijGy7
	 vK+AuVlgdWOYLdV7NO+1nOrMOmKpn2H+NYxMcSsRzyQbhEfiyRRTX0zrjIGXu9ro1t
	 YQZwRBQmrHobDfrWXliwc091ZDNY/XMMg+56w1V4=
X-QQ-mid: zesmtpip4t1754919639tad3cd76e
X-QQ-Originating-IP: PmLamziIaIPd032DoPHS1nGO3BKfQSqngcGX7f3+6rk=
Received: from = ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 Aug 2025 21:40:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18346526074261091734
EX-QQ-RecipientCnt: 16
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: [PATCH v5 0/2] clk: spacemit: fix sspax_clk
Date: Mon, 11 Aug 2025 21:40:32 +0800
Message-Id: <20250811-k1-clk-i2s-v5-0-ebadd06e1e91@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANDymWgC/23PTQ6CMBAF4KuQrilpB2vBlfcwLqCdyoTfUCUaw
 90tRBONLN8k73uZJ/M4Enp2iJ5sxIk89V0IKo6YqYrugpxsyAwEKKGl5rXkpqk5gee4Aw1Ouly
 qkoXCMKKj+4qdziFX5K/9+FjtCZbrmwH4ZibggoPL0DpMbVHujg11t3vih8JgS9fE9C1bvCn9N
 rIfIw2Gslrp3AkA0FtG/HkjlX9dcHulrC2F2bvN/XmeXyuL4D4tAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754919637; l=2110;
 i=troy.mitchell@linux.spacemit.com; s=20250712; h=from:subject:message-id;
 bh=ZUrL1GUtAJCNKt2pUUAfCSXGuuvKhhmY6ZNaHjLFvb8=;
 b=ZhX2jPCvEG84+TItAjUbaat0PpdHLIomj/YTf1ls4//wep425ReggVi+xVcUYktiqWQ5FYuE7
 xd/upGgv2hiDr6c5qsx+zZPwUReCwkZUdfj9R0bYg5jZTE86xd8Vs+r
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=zhRP1xE0bftrurqSWI+SzcSdJGIZ0BTTY9Id0ESzqlI=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NeU1T+XZVMjbiHkVYU/clpt3NXnlFLkJsd4xlq94quBUR2FupVN7zB8Y
	O8m2ogZpE8xSZ4UlzEXJ2FNh4vYNZuetGfpiWmKVjyfOeIpv/Ce8sP983hJp16s2BIAw90c
	+0Mk49CSRrQLQjtmtV8L4YZkdlxIb3nc7DW1v5n3QaM6CF8LZbQtGokWxD0eV5bNf/k50U9
	PpyGd9wze4PyEkuNtme0RiGABODo0FCrpLYp+0vne5luyyrmgdsfYgggQB5/nhl1MsTm5q6
	iZGgpJMwDp0vllGSJGRWJH8Wlt6zwK6H7k1s1QSKIV93VlpsqsRtLXXYZBkB3O1crXggAlt
	2HFhYeXdEGznMDsFoawyyOHkz94eQEVN3mSXysZrb4KGrBoWMrIh1wY1hKREQdBDGLlYx7e
	dvveKYz5jGObrPuOP5Sgto0U7n9nN3CJBj/v2SoYWfjmHQhyEx3g3NfGwkZ+F8yB7K2q/6D
	DrbOAQrPzVlnzHhzgOhA3H5JH8qNffm0Fr+OgUMaFH6ARVlDC44z/gNVXh3sIhsAyoL75Qs
	Hi2LbdO1wJCjRuN2AwdmE/ACheqbSUW2ar6RgDiCFUYDsimql3QU+SV1NniKspuQzNqfnbF
	IUOdAHrUJ6rfSux47eG2Uz5za3Q3h9jMJlwijO0jfNadCNME54bDtjPKrTEWgwRpLSa/S8y
	UR62J19CGNjLpXJ9CS3FjbadIdzXet6kat4hFW56QvHLHcoNm1m/osJDQR0wTINkfzTxQ1R
	Aie9CVBzN7KaI1XSESOaYD7cq09ENP85VOuoUZmEZiFOQEYmsP/2lCHYRA7fX6mfy09y/NQ
	Npns4JWFyQGWx4FxKkYxuo0THEVa3gNgS/NE2sf5h491JKBw040nnkpmZJPfrm5uGW74HaX
	HvAjSb9W3i7YfINS2VrbFJO4zkjDWj7qobgr6jS6xPBnUj5oYw30nMbsUwIVIhxxs4Ef1qo
	kgkxFxIROg8fPXenrttIzddfZxz4h6UvcXZj0Qt+zBloMHAHxWVrwnX0xoELF1DQTgZhQxT
	bVvkN1bbCcMwa8CGyxhnCDMVgV5UmKuspAV5vhKqljfO3iwgDu+InM6X8+jP/CMYR6zxhOY
	LR7z8u5C6oh+3cKd1DZkwpZwhVDbCw7UWcq4kdlJCVYdDc/rkvR0BDYRHAiUr5z0Q==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
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

Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
btw, the public documentation for the k1 clock has been updated.
---
Changes in v5:
  - move fixes tag from cover-letter to patch1/2 and patch2/2
  - modify commit messages
  - Link to v3: https://lore.kernel.org/r/20250731-k1-clk-i2s-v3-0-2f655ddb0c6f@linux.spacemit.com

Changes in v4:
  - add comments
  - add tags
  - Link to v3: https://lore.kernel.org/r/20250731-k1-clk-i2s-v3-0-2f655ddb0c6f@linux.spacemit.com

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

 drivers/clk/spacemit/ccu-k1.c                  | 29 ++++++++++++++++++++++----
 include/dt-bindings/clock/spacemit,k1-syscon.h |  2 ++
 2 files changed, 27 insertions(+), 4 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250717-k1-clk-i2s-e4272f1f915b

Best regards,
-- 
Troy Mitchell <troy.mitchell@linux.spacemit.com>


