Return-Path: <linux-kernel+bounces-812627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A543EB53AA1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6C1C188D0ED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175C93629AF;
	Thu, 11 Sep 2025 17:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1923mdy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D072472BC;
	Thu, 11 Sep 2025 17:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757612834; cv=none; b=DXv74Aoydup1xCn7nSUtd/g0OOUgq61DxUnDcluyHt639GYQRM1VjdeDvaK77XQ3Cpy/E0EBQrGphG+d9ccO4RP4X7zHPgi6sjhgRJXY+/VAjAklzRJMLt/Hu9TrtfH82i6pGa+VYdq6/i4O0chT7U0oLO83UiJWY99Pg6HNaBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757612834; c=relaxed/simple;
	bh=/cTSt66cQ+6yac9OFUXZq7y3BS/9WNfqleMKgu9n+cU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oHWb+wwScNFgd6e0KCVcJoSlgM2aYOcXiS/mnClXrSeHvK3+2zRb7sgUWaVQF64eybzUVjzO0/rCb0AyT4q1JVDpgClhG8mEbP0GU4t2fs5yk1qDVwlw6LV+i4C3BDHmLEJ/8x7/QdO32SEkiorBtC81VvPcwIg3rvYLNR0OQM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1923mdy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0090C4CEFA;
	Thu, 11 Sep 2025 17:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757612834;
	bh=/cTSt66cQ+6yac9OFUXZq7y3BS/9WNfqleMKgu9n+cU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W1923mdyrb6wKeWPz0BQ+K8Ki71BI7YgVstxpHbobJLymlXvdhlo8hm3X5Dn9Zp74
	 Fi2SbgYSlBfITlSafaMwz/93h3RuiPr2ZQ9lwPcn1JmZyXXM/TWjrhiUNkNqfiaL/L
	 bOv3FtrzuMGfDpZU/1LYOjmvlx3O2MMEN2P5TSwVnK+zg+EZQK2+/wkp9jInk3MhJf
	 2tMmCbOUaNnpnguDcaZlGqriNK7wP9ilM5KZeKro8Vrs4EQ5ca85Dsqji4VpgrkskA
	 6xM9vghqFvn3s4bBZexgbjkqdJqkNCgrk2hUrpOO+RPBNqjAdw4vA9kY4DiNOsf7i4
	 QqA94Wd2+qDwQ==
Received: by wens.tw (Postfix, from userid 1000)
	id C990B5FBEB; Fri, 12 Sep 2025 01:47:11 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
	linux-sunxi@lists.linux.dev,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/7] dt-bindings: clock: sun55i-a523-ccu: Add missing NPU module clock
Date: Fri, 12 Sep 2025 01:47:04 +0800
Message-Id: <20250911174710.3149589-2-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250911174710.3149589-1-wens@kernel.org>
References: <20250911174710.3149589-1-wens@kernel.org>
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

Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
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


