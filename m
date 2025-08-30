Return-Path: <linux-kernel+bounces-793075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 570CAB3CDDD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 19:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 225DC4E20EE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 17:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB8D2D3EF6;
	Sat, 30 Aug 2025 17:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4ferjS0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241B32D027E;
	Sat, 30 Aug 2025 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756573760; cv=none; b=KWpQnNctJ8wNzHdnLhn+Ta2E/jlNCJD5HRXotIb8r742dkRk7xV0mH9TBS6buTzYo8gZovhwUacOAcAZkD+rK22DsAFibRhHcoyxN3/JbxFENTaHFv+4S2D1BxoNs0MgBazPq+hQ0eQgPSSkjh90L2lYwfOLLjOkFTFQicfxP2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756573760; c=relaxed/simple;
	bh=u+4gHkt5DXNrjLXkvTpfwwb6DKaKcxGOlqkLQ/0Gubc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lghQ5Va4iSZuREctEt8HgBuyVq3GGlnkI9aNfLCC+ivwvBkc/b+wxB28SqcttLVK/4cxwa2sv/yJsSIzW1u/Yu769KzobIksMs/q3QCQ7e30S8tCZibYnFKFm8SbZwdPV01ece2NybgOUBTtDy1rJse+vHpATs0eggYkpafRb2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4ferjS0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0378C4CEEB;
	Sat, 30 Aug 2025 17:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756573759;
	bh=u+4gHkt5DXNrjLXkvTpfwwb6DKaKcxGOlqkLQ/0Gubc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I4ferjS0lWDaRDEPSigpfpZXcn1ecAQ4cv3cFgwhBBCG2vX1kOc45QAnqBpUwdVq9
	 c3v44Y514Aw0hG7KECWZeN6eT4E2F65t7NZ+0tnWQkbD/ZDqHM7HibVSUasgoadxa/
	 uxHudqTidIvqbjllVV4lP0TOZRN8YZHXkDSUnRxNBCZ+TX5xilo9HoBYy76ii41tCu
	 KbP5/fRr1EDXUInEbNNKJBUTbPPgfAu7ENnVUUFNfLKAFwPVHUxW/Pg5lPwlkOqZAE
	 vrNi0me373DjR7oHTJUqmLTEgRr7GT/uMoikO86PZ0bYpnWKqMD4vfp0UYFgmobLMw
	 fnUkdpeZUMxaw==
Received: by wens.tw (Postfix, from userid 1000)
	id 2686B5FA73; Sun, 31 Aug 2025 01:09:17 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
	linux-sunxi@lists.linux.dev,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] dt-bindings: clock: sun55i-a523-ccu: Add missing NPU module clock
Date: Sun, 31 Aug 2025 01:08:54 +0800
Message-Id: <20250830170901.1996227-2-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250830170901.1996227-1-wens@kernel.org>
References: <20250830170901.1996227-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

The main clock controller on the A523/T527 has the NPU's module clock.
It was missing from the original submission, likely because that was
based on the A523 user manual; the A523 is marketed without the NPU.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 include/dt-bindings/clock/sun55i-a523-ccu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/sun55i-a523-ccu.h b/include/dt-bindings/clock/sun55i-a523-ccu.h
index c8259ac5ada7..54808fcfd556 100644
--- a/include/dt-bindings/clock/sun55i-a523-ccu.h
+++ b/include/dt-bindings/clock/sun55i-a523-ccu.h
@@ -185,5 +185,6 @@
 #define CLK_FANOUT0		176
 #define CLK_FANOUT1		177
 #define CLK_FANOUT2		178
+#define CLK_NPU			179
 
 #endif /* _DT_BINDINGS_CLK_SUN55I_A523_CCU_H_ */
-- 
2.39.5


