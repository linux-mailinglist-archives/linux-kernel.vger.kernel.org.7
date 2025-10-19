Return-Path: <linux-kernel+bounces-859819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 036C2BEEADC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 19:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF8B94E1408
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 17:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8322E3387;
	Sun, 19 Oct 2025 17:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3k4fezo"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF1F1F1932
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 17:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760894815; cv=none; b=Fypk2ztZYnXyAllpmLHXvUvvyfBZb3bUUch+z54mCB8QMyCNVozQxGeSbqmJvDDzeez2Jxzt2dxSYYL19TpnfYgUBAxyc0bPqK5/18zU2ZXihA8bIW2YBNVmo1S037YPwYQHnT6T2B7NUvn0aCWfeHXDUSsO91wAvUzONhyCEeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760894815; c=relaxed/simple;
	bh=WKISn3FBpc6krbzD+pqM1hrHFUEYtLB5hDapFGbIkww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rie/1U5xxeX7GtCbeQuyj+uG33OqXL9B4hEBJcO++coGjqtVpdFxk4VK39CwHUumvauj6rcndfuJWL+9eFdHRDfZzizkjjXJCRHDAKNZKu+2whiFIazXjkkKgynsBWGsAMYmf/45KGlMRy3CGQd5DJFE2JxG+rjavzDmp0sYR0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3k4fezo; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46b303f755aso36946705e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 10:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760894812; x=1761499612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rfk3Iz74iG04i8jgiAEKJ+IUy9T7n6c85dOHEZsHbEw=;
        b=J3k4fezoCrYQNxw0OeGbvLKOHwuK4XCqj/7H4BO3Ms2jCQLQw0XK+JxNRaW9m7LoT9
         2BqgNVAPqMmRAAyBSvX5824rm3UTsuwk/Sutu2xxF33EXz8j7+Z4i8FrDr9f9wdcFF9e
         bBMv7LztKwv1eI/MPu1p4hymQiFy9GF8Kr5Qx6WmiUQxVa38DZqcqDw/bQcKPbr1Uuvf
         7wTEhTuT8EMSgokpbpg+OaqzcUui2Fy3MKxGmhSEsIdTbrhUsivwHUwRXr1HWd5KOfz2
         Q3HObYQ17CxCk+uPDwNtJM1I+BVojNccu9ExG9ZStYkbGhze7yGl7VqNIteEtHVDUPwS
         1L3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760894812; x=1761499612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rfk3Iz74iG04i8jgiAEKJ+IUy9T7n6c85dOHEZsHbEw=;
        b=UJJGpar45ijC5Y6mD3lyKKkGmtDIZdy3bitKn3JsOZ4d3y5I34imKe+kA0be2R75HZ
         y3+IRE/mnfSTK5bQGKpy/tdmD2SIizxhICKy8p+H1yVueKbQnsyBR3nJ3652ZQFRt+Rs
         pcUYzvaF6McTB5nP+i3gto6jcf4pWSN2OF7y5/iL1B2IT6i+nI8/eBZFzUG4frQ5JAkZ
         4yi4KZ5qD4auqNz37g1Vg5sWr4ugxGO26xL09hVzKKKXeZBbMDCXdBBEe4ULCbpokScf
         C4EXrA4cTaq1oMdiYRsRqMpKdiJydHxaLGUwH6s2QH3cMx1GngvBwxaFg24RRMleGTSA
         ZOVw==
X-Forwarded-Encrypted: i=1; AJvYcCVk6n8PLgQ3gLVATuANm0XiCR527Wd9Z610ftDTrD3zjCcHAIrUfXoOOJdpu3t6DlKGvhvz0y8h6/BZE9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzflj5uhqzYsuiRpK2bPwccfF9bfizpsYPacVq0y7Owa2FhdcGu
	Ebbit2Dz1sWXXn6jrNPQHa9HMNwmjm8BXe3UT1zjVQcsdc2lqTGddBBzGxY7DA==
X-Gm-Gg: ASbGncvssWKudm7unCdP1RSK/DMuSXc/qJrs1z0sqh3Pn0NzJMQsXqaUsPBK6W2ftR8
	xT8E6PMi7UxuXhOlA2Jo11+MBjX0rhMHkdpXCCG03UmRIG2Lx4rVANLufqR3xNFrkKp7/sbqoMV
	pTsV7mVdqfWihaJNhFs1sy4xItDr2gl80cNasrHMRdVdU0gYcr6glgQ7zVlPLOwc6eIytara8BB
	ZRqVKE5bhEoCUlIRPBq0LHGDX4TCMmrudqk0C+Sma4ZYJfvfc2gBbqZJNc7TPFhNCIHOM24e7jz
	sAbtGFWWhjusFAHuZD4+c+ukU+CxHy41NCMohkQcqkMcl+omGezJdwlCfQEbCwfZn0H/83JFlOg
	iKdQhXZTNyAs14p/xDN6TxSul7ybktQe1zU1pdCpGyzbzjSHpDCV8j3oJM5zh57+lGJizJRkH0d
	BhwTTELbByefpyBiFO5xkpZ5eyLQFrggQAVMn5dXbuiE5Ue6T9KMhkRs31qVsrWK+Ka89hKFh+b
	bWG
X-Google-Smtp-Source: AGHT+IEPw1kFE6Cr0CGLWoQL6JabKMRRHciBsQ11hcnzheTmiOhMaQJbH3sEDwu47c9YBtVmkqG8uQ==
X-Received: by 2002:a05:600c:3b8d:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-471179174cfmr75189675e9.27.1760894812237;
        Sun, 19 Oct 2025 10:26:52 -0700 (PDT)
Received: from jernej-laptop (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4715257d916sm101069715e9.4.2025.10.19.10.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 10:26:51 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: wens@csie.org,
	samuel@sholland.org
Cc: mturquette@baylibre.com,
	sboyd@kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] clk: sunxi-ng: Mark A523 bus-r-cpucfg clock as critical
Date: Sun, 19 Oct 2025 19:26:47 +0200
Message-ID: <20251019172647.80379-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bus-r-cpucfg clock is important for peripheral which takes care for
powering CPU cores on and off. Since this operation is done by firmware
(TF-A), mark is as critical. That way Linux won't interfere with that
clock.

Fixes: 8cea339cfb81 ("clk: sunxi-ng: add support for the A523/T527 PRCM CCU")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/clk/sunxi-ng/ccu-sun55i-a523-r.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523-r.c b/drivers/clk/sunxi-ng/ccu-sun55i-a523-r.c
index 70ce0ca0cb7d..c5b0d4a2e397 100644
--- a/drivers/clk/sunxi-ng/ccu-sun55i-a523-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523-r.c
@@ -125,7 +125,7 @@ static SUNXI_CCU_GATE_HW(bus_r_dma_clk, "bus-r-dma",
 static SUNXI_CCU_GATE_HW(bus_r_rtc_clk, "bus-r-rtc",
 			 &r_apb0_clk.common.hw, 0x20c, BIT(0), 0);
 static SUNXI_CCU_GATE_HW(bus_r_cpucfg_clk, "bus-r-cpucfg",
-			 &r_apb0_clk.common.hw, 0x22c, BIT(0), 0);
+			 &r_apb0_clk.common.hw, 0x22c, BIT(0), CLK_IS_CRITICAL);
 
 static struct ccu_common *sun55i_a523_r_ccu_clks[] = {
 	&r_ahb_clk.common,
-- 
2.51.1.dirty


