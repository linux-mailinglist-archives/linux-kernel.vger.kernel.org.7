Return-Path: <linux-kernel+bounces-745260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D778B11759
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 06:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A74E1CC3320
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 04:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDAC218EBA;
	Fri, 25 Jul 2025 04:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QD2Ivqf+"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43861CEACB;
	Fri, 25 Jul 2025 04:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753416926; cv=none; b=mpgXTqtZJyMqXHGnjO5K0vZqfoSgPdXv1uJrPd5d3tFmtdoVYbZ+QdM9eVDlqjBUN3CKRbfNcha4rnMv5W4Ytgx9LKapxYAULa+PVX86dediZb118I4tnJ8i/D8iEC4c6Ohj4x7WYwPx02GZoP4Cc0eiQcT12qqYZhClHe8Tik4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753416926; c=relaxed/simple;
	bh=ia+Uplhotw3xzAyUsEBx1SrfYmXW3e4sNs98db1KqyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K1qyTMn+iMebTi10tJanNSO1yIj4X9LSY6OwKmcJJCa4wY8t4J5LZMBA4C7Cbe+4rfKYbOFCAig40YX1tYWNQHYjkhdCZjUiE8gJ89HZUjFJHYbua8Z+EwBsUT5mShqbZ5v8AdY4p/CPOBE9he6CWeunuoHZqOjGTPpl6HbIw34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QD2Ivqf+; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-236377f00a1so14893955ad.3;
        Thu, 24 Jul 2025 21:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753416924; x=1754021724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IDyVDVsX2sxwOV8uMemwYGtSMwijwnR2f7fa8U3UVF8=;
        b=QD2Ivqf+UZbBDGgX40/EP3uGDcllHy6ZIsQdATjoBau4Fcfgrehh24v7nLzrae4r4u
         gvR65kPQu7g0oREOtkEAmXURWiJBQIGzY8NIi8uBSQafFDVkDrrM4DRKxzm7afWliuVE
         DMFhi4C69E0ApXIiQ6z8qgBl4yutLj6WkBQjRc3Rj1qdfi0bWpf/Lum/jH+rSfmEEqX5
         JfmE2zQ5koX4DyIC1IBHbqGqy+ZDFKVxTWaU3Pb9sxKuKVTUFThNO5dYjv+v3kVRrAVB
         BH8BsHTendCLFKmiKyo8GIygyod21KEK90IRjF2FJpRhwpG0w9oR7fQadOsx+Lj13iHN
         66iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753416924; x=1754021724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IDyVDVsX2sxwOV8uMemwYGtSMwijwnR2f7fa8U3UVF8=;
        b=bM+OExksvRYyBHsfFGVxNiTdjUq6op4rzygCLKST/LG9XKdyFa36Q2QNaErvgRGY95
         qb5UvhpBgD0Bp15tQJd9kQN1dG1GM0PqLcodMZ7mC3040fl3at5Z7uL+MDS43a9Nl868
         QFtiu73yosTaf6I0BXGGFbqNlVNnDWwP5HrcI0U6/BNi5vsDB+5M8mkEVeYak9I6QSJ4
         7nmgH7byJbW2hLHV5ndEebyk39k9lq4iVdhXUwFVdQzfRCabWqaEgfc3ImALUWieOoa5
         UiM2BKBPfimPY6RmDiyhbojTSdjuqj6F+rY/Q4V1Oyafc4DMAGSAXrVkgOPjatl/ZAEx
         SE2g==
X-Forwarded-Encrypted: i=1; AJvYcCV0HUNVpLzQclxR0Hsm9Nb+gLJBuAjM6ruUAaYSufOBReA/D0NQLZxwsx9CJ2Eaxq4JdkSXQaASzYOz6GQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQVQHjAIUrjT1BPHZ0zszxgEkYI8E8OVGTaXfPZUEPOusP9blG
	adICWVQWQbePnrjksuiXL5rsOOvVcAScX96C/lQiB/Mz8yiGm76NsR9q
X-Gm-Gg: ASbGncsLCYQiWVzEEqNi22EAAPw4Uv4YVrxtANndIxqvsIra3fsUK8etVwju7kgMgnF
	MJyWy3tqRlNlzWbrB90SDKcRDziRVWiUJNBwU/N3ZuX6zzTmDopFI5mfop/pt/liq4sKI74yHTG
	koY3QzCtVJ62kU3yJG3R99KqqntsNrjhkFU2sTX4Ec7Bb3Zy/RFUVPTmO8wFjSA8T5V/hu1gSCE
	/RjczSypSaXeEkDlR8L2bkNDoVvRDGrYdRh/KtoJAAw1R8nw9UELaYViLpb3rW9hl++6qZYNXeZ
	fvBBVWgxImFQwUM6abC3RqcpGP8hhnVAunZCmk74Zit9HH8syqrScC1jbodBDLxyF2vufIbw5GC
	XhD+5MQW/blzcHIk/zUd9yM04542va1RJCPN5zHTFE4skAeQsC3SAZnCB
X-Google-Smtp-Source: AGHT+IHvLjm8C7PH4YVF1VnSS5CtquSsiLEUI79iiK/G9qjF0tWAtGjk4vtzhzb7uVTS547nIuvuMA==
X-Received: by 2002:a17:902:ea0a:b0:235:779:edea with SMTP id d9443c01a7336-23fb30e545fmr7872485ad.38.1753416923903;
        Thu, 24 Jul 2025 21:15:23 -0700 (PDT)
Received: from fedora (181-162-135-125.baf.movistar.cl. [181.162.135.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa47847c5sm27147165ad.75.2025.07.24.21.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 21:15:23 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ignacio Pena <ignacio.pena87@gmail.com>
Subject: [PATCH] drivers/clk/clk-asm9260.c: Fix typo 'devide' -> 'divide'
Date: Fri, 25 Jul 2025 00:15:24 -0400
Message-ID: <20250725041524.73660-1-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistake.

No functional change.

Signed-off-by: Ignacio Pena <ignacio.pena87@gmail.com>
---
 drivers/clk/clk-asm9260.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-asm9260.c b/drivers/clk/clk-asm9260.c
index 3432c801f..595cfa533 100644
--- a/drivers/clk/clk-asm9260.c
+++ b/drivers/clk/clk-asm9260.c
@@ -92,8 +92,8 @@ static const struct asm9260_div_clk asm9260_div_clks[] __initconst = {
 	{ CLKID_SYS_CPU,	"cpu_div", "main_gate", HW_CPUCLKDIV },
 	{ CLKID_SYS_AHB,	"ahb_div", "cpu_div", HW_SYSAHBCLKDIV },
 
-	/* i2s has two deviders: one for only external mclk and internal
-	 * devider for all clks. */
+	/* i2s has two dividers: one for only external mclk and internal
+	 * divider for all clks. */
 	{ CLKID_SYS_I2S0M,	"i2s0m_div", "i2s0_mclk",  HW_I2S0MCLKDIV },
 	{ CLKID_SYS_I2S1M,	"i2s1m_div", "i2s1_mclk",  HW_I2S1MCLKDIV },
 	{ CLKID_SYS_I2S0S,	"i2s0s_div", "i2s0_gate",  HW_I2S0SCLKDIV },
-- 
2.50.1


