Return-Path: <linux-kernel+bounces-762828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B79F2B20B2F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B7DD44E361E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86308235067;
	Mon, 11 Aug 2025 14:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="vEnDzEeK"
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6F022F755;
	Mon, 11 Aug 2025 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921102; cv=none; b=BiudKIy0mf6+xUOnC0cfSZB98A4E3pI9btFeqiHJ3xd1sB7tZjNZQw082G0A0GBTZb+DucYEgiAIZothDoeSyHujGVwqmhNJdNvFV38YgamiYiCS/Awd4P6Kix0hQt7a4+BkTugwFEf7753q4lcX7FviJ9NhFK+Pw/WrRNU69Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921102; c=relaxed/simple;
	bh=WFzD3JxmXZH2A/HVSLYZQ1zRbumApEBwgTZWddNtTRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tYwGn4HZ/c14jZpzViWJRGX5gVbQfBzVC+PBxDcX8+VQiQYuYdN9jkjKYSLDpMhdB8Tqr+z6YBnj/FsJG50XPghyhKEbc7KFDE1aSQiNabuGl4PHh8I/zCZnftl63spT0hokh4sgMYIGPTiXeBiyhgFGcIWywaJRKcIkAE0aHNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=vEnDzEeK; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1754921082;
	bh=VnVbQJFTKT9KqK9RrK42D0ZPWUeaI/Fw5R+S1EtpFzg=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=vEnDzEeKJVVJlOePPf0OIiMV/SZ5zmaY5C4Rpcsk0Tfo+T3HKFq3N7DD/U7foA77m
	 cWnaaJ5WY3OcXuy7CwJm8SSAruGNaRxJwKE+6xDq9XanMuJEgeVKhGdL8yRWBrjadu
	 lvGgy/hUy8VPkrzj2lkMQcNDK7Uy9eIcAW1sH+Tg=
X-QQ-mid: zesmtpip4t1754921080t0cee6af6
X-QQ-Originating-IP: 7OmkVN+qzWmNrNPB6kdQOPDm4g1ogZjUvbkSpLnPYLg=
Received: from = ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 Aug 2025 22:04:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12793305655331086450
EX-QQ-RecipientCnt: 16
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Mon, 11 Aug 2025 22:04:27 +0800
Subject: [PATCH v2 1/4] dt-bindings: clock: spacemit: introduce i2s
 pre-clock to fix i2s clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-k1-clk-i2s-generation-v2-1-e4d3ec268b7a@linux.spacemit.com>
References: <20250811-k1-clk-i2s-generation-v2-0-e4d3ec268b7a@linux.spacemit.com>
In-Reply-To: <20250811-k1-clk-i2s-generation-v2-0-e4d3ec268b7a@linux.spacemit.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Alex Elder <elder@riscstar.com>, Haylen Chu <heylenay@4d2.org>, 
 Inochi Amaoto <inochiama@outlook.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Jinmei Wei <weijinmei@linux.spacemit.com>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754921074; l=1059;
 i=troy.mitchell@linux.spacemit.com; s=20250712; h=from:subject:message-id;
 bh=WFzD3JxmXZH2A/HVSLYZQ1zRbumApEBwgTZWddNtTRo=;
 b=MwM8g6ePB8qFUqu+QWf2+Dd40fsyq2XhFG631In6WZXoTzuMThqsfAVXsjFvgWb1fESK/4zji
 wAO2FZ3uhtUCOKXPoMxLEMKVVkf+XLoC69QqiJQL9CP9rXxus/FPTV2
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=zhRP1xE0bftrurqSWI+SzcSdJGIZ0BTTY9Id0ESzqlI=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MzoGiWnNk+AmNy+SNg9BU8Pqt2R9Ba6Svy7WE3kOFjyONDfKWsN5UcGV
	r/SX7mcsW1LEKWubHHDd3KrrJd1BcSQjdx8ba64bcaQ2KOvgsPKm2KpmWV3fyv47j+NB7B0
	ANw60I0x8BY8idgZvDwJUVw693MBwtFvsPOkVoO/gPJ22P44JGObc4j9/XE81cPlKUioXaJ
	456uBEWczhwhL+Vt8jC4cbvjmbZLpWdt2GVgdfzlUp0juf4Z51CNfz0G8Qf2RB8ADXMt4jO
	wa12O5ERJQWXXFTthowmrwRm/7GadeBTbKgYro0uLxrmm1pVz3971UHN3fjMjRMNpw2hM1w
	7aZ3W6ccmBrEnxJCCewnzve5Cn//lN2SsywNUAoueIrOznfTRwcYvhp5+Ud/c3FaoyjcNjY
	WnvgQfBWpLIyoYp6qxFnAnZdV7nLEqTSXQbsQCqqzDRqfVv1Q9NyQOBh8NdzPgEYdzzRfPz
	oc64oKwDvJgjCvBJ06wMBueajhzVGtMcxDlqu/EK8+P7W5jA8i/1OawHUeZQ+mFhyK8538A
	w2BDmBr3nIFjNHbNl6/G8/D1e054DOjSqU7V+FBnAugOf3uuoIlgMpJ1gLswUATt9nsmUKo
	JWSc0DM2Jkt7unqbUScRvLKDJMvuZfx0H1Bxc2MydNDZXaGG2uEz+Nm2XXNCRivbgk8uC1F
	tgpYe6RuDkW0J5I+7BoUUofqszpazuBaACcAANKdHfFabZaDwsS348mSYwuLQMoahf/WWSb
	DZuo/kx+/7nmpY0o75dto9BbB7KaLby/Ajw18u4U4T+DAfTr0ht+RfevI0kXihgsWHKl/ta
	nVlf3EzOFBXmeRmlAo+9Y8me0VPJotWzK44754W4lyqNkGOGmDaAzASzVykHzRkJuqByveH
	7Ejw944Jz69z5qVtGh3+a0HWpc1+7pre01YI15Y1poWLgApR4Xw25RoSIoDhn5mpC4bRhp2
	eT8r/YZ8UWa7ozEYtcvYKMChXbSItf7LuIiJrsZA3HgIIcanyPkuWzFEo/f/BhLqzXWAQ7j
	Y+7GklQts6qfFuN1fUqhbBa65p9gDTSzaEVGT+y32stiZup4/d1i75q59gkmMyFqeAnk4zn
	9r64ESiZJZswpX7cl7TFzXA6pAEZl6ffi/WDePcWZUp5cWMSXBVep6PNBDiHrLrmcXwWEcM
	Nndx9ZKKg/whawE=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Previously, the K1 clock driver did not include the parent clocks of
the I2S sysclk.

Otherwise, the I2S clock may not work as expected.

This patch adds their definitions to allow proper registration
in the driver and usage in the device tree.

Fixes: 1b72c59db0add ("clk: spacemit: Add clock support for SpacemiT K1 SoC")
Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
 include/dt-bindings/clock/spacemit,k1-syscon.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/clock/spacemit,k1-syscon.h b/include/dt-bindings/clock/spacemit,k1-syscon.h
index 2714c3fe66cd5b49e12c8b20689f5b01da36b774..524268246fedd3f1238320f35244baf32354fbd2 100644
--- a/include/dt-bindings/clock/spacemit,k1-syscon.h
+++ b/include/dt-bindings/clock/spacemit,k1-syscon.h
@@ -77,6 +77,9 @@
 #define CLK_I2S_BCLK		30
 #define CLK_APB			31
 #define CLK_WDT_BUS		32
+#define CLK_I2S_153P6		33
+#define CLK_I2S_153P6_BASE	34
+#define CLK_I2S_SYSCLK_SRC	35
 
 /* MPMU resets */
 #define RESET_WDT		0

-- 
2.50.1


