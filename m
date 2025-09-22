Return-Path: <linux-kernel+bounces-826682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 892D4B8F1BF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DA8F7AB308
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 06:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA924274FDF;
	Mon, 22 Sep 2025 06:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1wBvq+k"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A8827467D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758522107; cv=none; b=NgYx4rgahgYZn75/Y2n4Q+kYKb2scy9ZGdWSIYlnDNKaPD5Aqwi86CU8oCaoJ0GU6lGLGDkjqT6YZoK4UpTpc/MT/oUmYF1j0usiS79TGxoQrv3qMTF8kyN0rS8pVxz7H2VEYszpNsSCZ8vLtIS3XQoOMftV63bP+7ELQXqYpCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758522107; c=relaxed/simple;
	bh=9bgM+F7I6nEBFXYeWO7UL9pGB4ld3ARupPlzJMnONCI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XjvLm+3p4NK+svhFivyZiciahxTRUkqepPys7+PAItJb1DjSnOfqdrlxCt0OOA2kMvL6pn+45avsca9Crx/2ZUHpdpcWewpIfhewMmkicczicIF/f/PSPkR3xuBKIqfBOscsI6Nhz7HyUu+Z4AYY4eBCtWsPKv1ROO75F3yadBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1wBvq+k; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3652d7800a8so19399851fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 23:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758522103; x=1759126903; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aQvnHof+a1v1Eo43/K9+opNP6misBMbwYQ9JP0aPt9w=;
        b=g1wBvq+kvqpQbEnj6/YCDAyIdTHvebr6qhht638QlApewnAAhdMFzoHI1IBAAMtwxs
         b7GQU4fMrHIUcBmXtmLIskWQIye7z1djXdQPF1fp8NHnvfNwqToyZj1NNc0hYiPQ5sCN
         LvbuFAj79VV1C/9PirdiKlw7IbrXmWcZ+WFQvR0k46zR6wQbwpq5mc3ZeOEs5KamnHk7
         5TVDHd/8+YhqGMJWs86krN/nHhp9mkkiwnqiERbrmlfF1S4sxE2FGz1GT7W11DLIkE2Y
         PsbQyWI2lIPENb1ShZm8psL4MT6JlsHSpNH7TbtBQ6BVdK1Tkg5FSseJwCTDUw2C2srF
         Cz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758522103; x=1759126903;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQvnHof+a1v1Eo43/K9+opNP6misBMbwYQ9JP0aPt9w=;
        b=ndyFPqk/UBoxR6Gny74hELYFi/eozxPvApgDuMz/pWFRm7ONupMTdjiHbhUhOmjNoA
         uvpNRP3bdFrTF2rxgbhW7sIaLocSqfIVuA1SNmLYdfltdIsWwL7o9DwGa8nkWgrzBSEA
         oun3lrPlFpZjoxdGaVkK2TKVAw4+mcl1URmSJhpjPeXD0Dlylbk9ffOT8NiIDdwHSg9+
         k4MyfEkwcLJNre8/TIhVeRak1ixXo+ocanTheWIKvbbRfm4pY0PqWHlmG0yfwWLFPIdw
         OfhC41U347rylDC6X/lIGeKo9xJmtBFDfCae7IGaKfEmZ/RSSnpuyyCV0DiJDayc+br1
         xkXw==
X-Forwarded-Encrypted: i=1; AJvYcCXtAh9TdkWAxfNXytsz/oPcaQenYMCtuK1Jfbx2Ndy0q5U0LJtpXBWx3laW3lEvy6ZOeWx75G4UAqPesO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDQG0YwpM4O26fv4oUHV1rleRLSqE2pwwoJzaT8VIS80oSc2bT
	2mrRaSLDVP4w8sKnDdro2xLFjQLa6tZUEzVauxxSnerffxlM9mdYnG6B
X-Gm-Gg: ASbGncspr/xXhdp56Bw1zuTiqX3H/xrMzeZH8vrEFN0a+q/6Hy0zaLQV8sH2JbfaCnZ
	eRG6iju50UUwjFfUs+C9MgNoFouArDAf9nrWvbVXMDX8C0eeTXM7odSrLqmw5wliaJal16FxQYJ
	FTEnOcdr631DfKOcYMgYQQ8LpFUhoRGqqyl5YCf9XKJ3dpP2JyOWkcmdu4yRwREPSl4ByYee1dw
	vJ9DxCn8wUPYMaH0mToSS5Q2B4INqc1TbXWEC3ce2vPtGAG+32McbPrGbJ1vcP0j9lOGPM/A69T
	41+BF0nRdIHmDEtjoqjswMaDltW/fjtlmpoTCpLLtxtyFCgbedAIjeNZ4mYanPz6I39txprw/tB
	DfHfRFMu3C0nhjaqgGR4eA+gHPPCLQQneMvWfxOkUoMolBzhkadFBGhfuCZsGaHS1kCw=
X-Google-Smtp-Source: AGHT+IEWX9HPunh3YhWgZ0OJpf6A7fWOFQJRUkGvS83H4cItQAhSmXJL+ooteVneLl47uCXET6TCdA==
X-Received: by 2002:a05:651c:235a:20b0:35e:b926:6a9d with SMTP id 38308e7fff4ca-3641ba80310mr35742121fa.32.1758522103183;
        Sun, 21 Sep 2025 23:21:43 -0700 (PDT)
Received: from [192.168.1.166] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-361a99e99e6sm26982661fa.56.2025.09.21.23.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 23:21:42 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 22 Sep 2025 08:20:57 +0200
Subject: [PATCH RFC 2/7] i2c: mux: add idle_state property to i2c_mux_core
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-i2c-mux-v1-2-28c94a610930@gmail.com>
References: <20250922-i2c-mux-v1-0-28c94a610930@gmail.com>
In-Reply-To: <20250922-i2c-mux-v1-0-28c94a610930@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Peter Rosin <peda@axentia.se>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2406;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=9bgM+F7I6nEBFXYeWO7UL9pGB4ld3ARupPlzJMnONCI=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBo0OrTfjsniWp6URWZI3ApnyPsD8hApZoRIAM7A
 qI2Xt32A0+JAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaNDq0wAKCRCIgE5vWV1S
 MhRgEAC24JGh3ARAKo2IuHAVAizurwI0LVGbgPTLOp+OuMCKJH2ti7is6Ni7R1PdOuI2QkMPf0F
 3V1Llz0v8ml/2axaF0X020StWV1zlx7ZXqrCHIepvG0DP2S1jVUXQ2LRRfZoAfOhzkB1v6yNBU+
 kluu4zCd6lPhMpQOzx/1fbsT9cRScclGTSnL+jGdDIQdP6bPhciANQnlQVgSLOkK7H5vc5uObrM
 21rWaoj24i+moR5Ty+YMoPX+8fTdelLGqf+JPQl44trRyXPo9t23pbFDdAxrA49Pxhetq5UsvJw
 lEb0Gc20/sG+m2C4ua+scQVO/fa/aeTiXPN/INQdKjsSRU0qH+1i0zOAL0QVgB9GkrCWkqWwKUt
 8HmQt5rTv1V+dls5Q0+igckCg0rcCQOzN/eL7Wwx5gEalLOUBLYcm04DGOQSTqIfRA5ePlzIfbv
 SY+/69JT9msuRKl3So16O0vrjKazP1P0u+ZaUY3Hy93RymzI+qutLHJuCByu7CFvr0rKvz8BtFH
 RXEBFv0cLojjXWhV/TPSSSSk5cQ02Cnpx9aaV8rkHGcQUNUHOh+n4CuTXygWFJzyYlxKaJNCURZ
 J4ZBGP5FgMQIFXAQ41qfy1crDEoZxg9ssaInr6eivS36tjhFIWaiAHYmxkrhHZOjD6Bob3j5CdP
 yvK0IZpMDl6Lpkg==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Muxes treat their channels differently when idle.
Let the mux core have this information to make it available for
internal use.
Reuse the same state values used by CONFIG_MULTIPLEXER.

Possible idle states are:
- MUX_IDLE_AS_IS: Leave channels as is when idle
- MUX_IDLE_DISCONNECT: Disconnect channel (set HiZ when idle)
- <n>: Enable channel n when idle

Default value is set to MUX_IDLE_AS_IS.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/i2c/i2c-mux.c   |  1 +
 include/linux/i2c-mux.h | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 4d8690981a55dc0e1b35454971923791e6ed9f7f..5caa927c0caae512af029f0d1ae9b7f845ba3f6f 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -250,6 +250,7 @@ struct i2c_mux_core *i2c_mux_alloc(struct i2c_adapter *parent,
 	muxc->select = select;
 	muxc->deselect = deselect;
 	muxc->max_adapters = max_adapters;
+	muxc->idle_state = MUX_IDLE_AS_IS;
 
 	return muxc;
 }
diff --git a/include/linux/i2c-mux.h b/include/linux/i2c-mux.h
index 1784ac7afb116ce64e9e9fca1ee127c2bbbd2fb9..9e230ad69377b74f9ec809c40ccffd95538c4595 100644
--- a/include/linux/i2c-mux.h
+++ b/include/linux/i2c-mux.h
@@ -13,6 +13,7 @@
 
 #ifdef __KERNEL__
 
+#include <dt-bindings/mux/mux.h>
 #include <linux/bitops.h>
 
 struct i2c_mux_core {
@@ -22,6 +23,12 @@ struct i2c_mux_core {
 	unsigned int arbitrator:1;
 	unsigned int gate:1;
 
+	/*
+	 * The mux controller state to use when inactive, or one
+	 * of MUX_IDLE_AS_IS and MUX_IDLE_DISCONNECT.
+	 */
+	int idle_state;
+
 	void *priv;
 
 	int (*select)(struct i2c_mux_core *, u32 chan_id);
@@ -38,6 +45,20 @@ struct i2c_mux_core *i2c_mux_alloc(struct i2c_adapter *parent,
 				   int (*select)(struct i2c_mux_core *, u32),
 				   int (*deselect)(struct i2c_mux_core *, u32));
 
+/*
+ * Mux drivers may only change idle_state, and may only do so
+ * between allocation and registration of the mux controller.
+ */
+static inline void i2c_mux_set_idle_state(struct i2c_mux_core *muxc, int state)
+{
+	muxc->idle_state = state;
+}
+
+static inline int i2c_mux_idle_state(struct i2c_mux_core *muxc)
+{
+	return muxc->idle_state;
+}
+
 /* flags for i2c_mux_alloc */
 #define I2C_MUX_LOCKED     BIT(0)
 #define I2C_MUX_ARBITRATOR BIT(1)

-- 
2.50.1


