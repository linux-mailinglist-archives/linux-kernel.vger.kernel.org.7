Return-Path: <linux-kernel+bounces-756439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B83B1B3F4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 264A4181F7B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0158927380A;
	Tue,  5 Aug 2025 13:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="H0l1uv5i"
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18489231C8D;
	Tue,  5 Aug 2025 13:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754398921; cv=none; b=JWi2/J5wxul5FWzXZwSHM7kEtzkHJDbjeZq/3meWPtV3m+xxI0t1/YWiJr/1Fikt9ES1PoT28YdPLW13FT/essd0P/7g8swPNpB93uwfYudt0HcbTr4HVPjF+K39h0plq1E2sA1HmyrRhaviGSVjpBuwvo0Wh1XNYSF8Cg9DlEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754398921; c=relaxed/simple;
	bh=VIogLUVb+B9m33ED7b0OC4lYwaKwU3CoXfrEw+uoTVI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=o1usUefVHviuwjE97VlnRKrf5WGICvAb9OzPnIc7+pmvzcsNwieyOkSSZJooh/Aa1VcdsttiwHOctu+cxC5hYiFfmCUtZLZpHxdA1ZM36Dwn/FfqnYI6828exnrBRsHNHU9erYsso6iCnt+ulTOxwjZPTIHMsG335xXOc0qKyOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=H0l1uv5i; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1754398891;
	bh=2k7eM+qFUJaAUiL35OCQZ3NGlJIOhG5UcTKZAFRYQc8=;
	h=From:Subject:Date:Message-Id:MIME-Version:To;
	b=H0l1uv5iBOXJ/pgX4pnPsAIDs+84xL0pw/ZE7RmS9Ru+cngRZ7fTS2EYCWIjJIFjA
	 jwY0xd0a/NV7nsaM4G7GsjLb0dGCEDiRVK/nQVD/ZhNfpyn5baZ1D+0SfwFH2X5PDX
	 G5MXtGPqR7eKp5SU5OCIG7ZaW26dndRGwcY2eu9E=
X-QQ-mid: zesmtpip3t1754398884tc0db81a6
X-QQ-Originating-IP: Ak9NAqBwWS0g1NX2QCrCb7EK5+lEsm3U1YdqNdNuPnc=
Received: from = ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 05 Aug 2025 21:01:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1081721539837443634
EX-QQ-RecipientCnt: 16
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: [PATCH v4 0/2] clk: spacemit: fix sspax_clk
Date: Tue, 05 Aug 2025 21:01:08 +0800
Message-Id: <20250805-k1-clk-i2s-v4-0-038181284dd4@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJQAkmgC/23PTQ6CMBAF4KuQri1pB0rBlfcwLqCdykR+DFWCI
 dzdajTByPJN8r6XmZnHgdCzfTSzAUfy1HchpLuImbrszsjJhsxAgBJaan6R3DQXTuA5pqDBSVd
 IVbFQuA7oaHpjx1PINflbPzze9giv64cBWDMjcMHB5WgdJras0kND3X2K/bU02NItNn3LXt6Yr
 I38x0iCoaxWunACAPSWsfu+kci/LrhMKWsrYTK3ub8syxNN/6CXLQEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754398873; l=1952;
 i=troy.mitchell@linux.spacemit.com; s=20250712; h=from:subject:message-id;
 bh=VIogLUVb+B9m33ED7b0OC4lYwaKwU3CoXfrEw+uoTVI=;
 b=lAgY2AmtKu9ClVpMR+5mFhfE5JbN6kb2NJ1/Xg/uQrvsXysInoA5aNHxVmfBnNPLjXWnnN0Za
 wNmNDgfWny+BVjOw4/r98A4rCALssgEEbJSwIwO4bKpPosZAyOd8/Tx
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=zhRP1xE0bftrurqSWI+SzcSdJGIZ0BTTY9Id0ESzqlI=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MoYja8dRtUgA5ZwZuXgd4D6sgoEIHr1ig1uxbCUBgHIqAVKahhbt3He4
	7/X1uwOPKGOTZ8j6Wt2Fnyn8/XuqvnctU4Gd3RwlsmIC+ki3shr4h8bzb+bzf0TC0xnyA8u
	mcFsL/aM/wpS7T+cYX48KC60EOFDzmIeJ2A4ylWmVSEcUQnGmCnEgSimSDnngkzM8p3RqrJ
	nPYQejTeS7d+G+y8rZxjNDeprY0U5VXV3HDsD50RrYvCc5r8oJf3ryAuT9KWxmS+28jtfeV
	KE7eLNOGchU5XuHlz36SMEA0ptJ7kWkVWgZrUpXOe+9CY5BfbPj19jjhfSbjHJQTMugMrQp
	kbzFWHnBl4gt5KtRkjfvzIBrXyuGmHCOuSV4TIp1X8sKljrdb68FShQuOvWWKZdpFgF2fLr
	H5TSkHHBJfziKHcmbLTQzhQ+gBzPZ2BtibPaeGVO/UDtTL0Bnyr+8dgaOHuQjoFsb7qnudK
	Ant03FSd8fwOvLZLHfkg+g1NWpxtH79snbpKqmPlWahAwd0ArEA8WTql6qn3tSzvHY7hdrJ
	kNseSJjIEbG1avddIZJFAn8PHdowkry5IMTlvFLdXNmFH8UQFjHKZ8SkTG1Klfw60xqSWdi
	5lAtsbG5R3+T0aW1gOqaBp/Y4ROEeuiRu34GdLtSWy1evzzLNaOxicQLjySGhuyo2scwQmo
	oH1jW5v023ZFdAWWKCczJ1Q33LKgGPlacLpXG4vDWG49HWmXzZlhHnMbAqzBGHQSGwXOx0Z
	Zs4j0XjwrlDY6azaTkLItRjsyYcFKxrLnJuSTQ6wSSqLHIqlscSlg2yaIwaCKgG+jRKd0IY
	DvjvAmPcfjYKOdIePC9aa3mFd4DLP/K6iTAcGcn0RFeOt73i6D4RGZecn4mStIWjvJBGNz1
	8Emdb30AgLzLobHzDSKFVc9ZfSJpBEgDjlBzRM2faX0TXVtg9TLoRVcifMZ9GtS1eXSUpjf
	KR+j67gopz2VeAJ74W57BM1b4+WQE12X4QCf+QEU735oeweQYg8lr77vKNnRKkFJxzooZ6a
	2lPXRJeYMs3lIY8IPPNRBQRttpnhMQEI3RapADy2RqoONru2bRY+xqwBCWnC7+JZamCs21l
	0LDTnqEhVi/8xQ5oEFOIyWs2RGRK0FIBaFhbDcwG53YWhRnJ2Rzd3+gZTlLg74Th+d89/qA
	b++2t8RBkYpo5zIg8v4M2eytbA==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
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
base-commit: 733923397fd95405a48f165c9b1fbc8c4b0a4681
change-id: 20250717-k1-clk-i2s-e4272f1f915b

Best regards,
-- 
Troy Mitchell <troy.mitchell@linux.spacemit.com>


