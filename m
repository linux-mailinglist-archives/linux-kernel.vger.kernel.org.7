Return-Path: <linux-kernel+bounces-809126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7191AB508F3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 00:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB7C1BC7181
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60CC26C3AE;
	Tue,  9 Sep 2025 22:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="B4Fabnsr"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49AD26056E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 22:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757457695; cv=none; b=iokWYZbchbVnMgy0SH/ApAirWGceq5Lx6Aodi/EWDe9Wv3oNZpsOZR4JLz7WUjqankpFDHHyBu170WBHosrkvAjr8xwWpPoBZkrOBOaK5EUsBq6dnZsdmLtJjyLWtNmOlwX2/4U24xN1qSkXb0mv20hvvashY2pYj8Ruvwr/B8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757457695; c=relaxed/simple;
	bh=felhpwGkEtZLE8TEqp7N70sxaxzcLapntYvYD9bzU9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oPxcD2W3O/wW3AOfVsOel+B6wnCwUCoBlFvwnkopPPmhD3LlKkXBjZ2ea6UNaLloh5NxMY3uPLXD0yB8sIUV1L6wYBBEyc5Pe+ojjhlHsKx3KRW2W/ENBVOBtAhyk8BlTdmd019g71ZUomdoosoacJN5QouGlSBI7NRfX1es9Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=B4Fabnsr; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24b1622788dso43133645ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 15:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1757457693; x=1758062493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u1ipfyK9b5YmSa8JFsuC7Jixb/D0wPo4LPC95p6875o=;
        b=B4FabnsrV0xjhoPDIfyWnGnbDuSG06Ce2afTMm6MHm3srC1ULh5yTRAN5PgzI12GWO
         /Yqe69TACqx9wCJ9PqCxQPwS929IZdKGaRTxI586sl6pXz4KfPQ3rp/QDyeeatBq5dwE
         3XWLHFFJnivdVhhyHuzcjw7iED86H2sLSaXOoGMQ5CpWjcxLWRVH/o3R21TB48cudXco
         uhhfC3/2rsMv1x/vCtBNb6u+/cTlcFoh43B99uyOQjRsGZ9IFDarfxrNVrLxa2kP6o74
         EjIv0ojMQ6vXEeO7J8tHPlmAvcYIGLX3jY8+hw2kykXXdDqK+kMWF0/6RGZZGsNkxdJe
         q1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757457693; x=1758062493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u1ipfyK9b5YmSa8JFsuC7Jixb/D0wPo4LPC95p6875o=;
        b=PDYO/09MOSQ/2QKSdlmsrN4JcywGVf5AIjqasU3+4zqyrySHFxFmNrVIj8N8sksAQ/
         Sl4vYegj7AZNCJJcSWRqtThpcxxuuKfbHUuyM+Ul4ZK4lgBj9WffW9bqddh1nmgYCZdr
         rU7f9Xo3RiAg1kG33P1fy11BSqkREjsw3U0YTwrutuR31BUnQelMybOYN9RLNBPvVnBh
         dXAHIKBtmjMw66sCrI7R9iOabCEua4E6ULatWhiTqfup4HYXgAxXM00V8dbD4d4Tv4iW
         BkIA3oT9hLRwEHOpzuawARhDMUdADBLkkpc2XLMU2SpGhMb06cvEw5eopMUxf5soHO4W
         XUrg==
X-Forwarded-Encrypted: i=1; AJvYcCWcLd1Npwsjzw7IF4hWH/ySrn/v+HDHbekYtpIhgkXfgaB0ZgdU3RauTBO8b1Z06VEekgwCf2Ob+fUd+F4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkVJiLnjlAIu3pHbfoYray3Vq6UjN7bQI55Wl2by58R4JNx27O
	j3aWCwWVbGi/EAs1xzh7+J7PkJUXC33BUsPYhYF3ZInfn2YUaTliBT1DmaAoYcBANuc=
X-Gm-Gg: ASbGnctkQKgCMcV94+YEBahhuEx3Ivzkck646cFmW2gcMosVy7nbA4TylWCJS+v2joS
	aeYL7RsQbf9PuVLFYLrY20P4jQuX784mZR9GjtSJ9zlUAq/jqgQlp1+NZqx8NaQP4G/izy7opSN
	bd4kegchtc8ZnggwGoM11Wfq6ZaxIHoEPvKWfFhbPS3CzuHjr2GRj1V3FFfX5Cv07QqMCdyxJfD
	ZRZvohGD3oyvwE+hAEddnoqdA9AZb9Bm8mr5NE0RVLEtyRZ3PljjGRwkyO+B8wuVnyIkWvOxeM/
	d9I1mdLjdhNs9wCFvWfHjaGI6K7cVUEHMCR/8J0nxLZA0wKW7lxviWmu1Z/VQ9zkWAjlNgBmKnc
	4o1a7s9XEbrMxkzBC/KzSqxvQBkvbq6kG4K1PzZtVyIk/Mg//ltm43uk=
X-Google-Smtp-Source: AGHT+IHckWZ4Zmqgngr3HglCZr4AquYHliN4dZVtohCeeipZhQom/qfD2zWCfOQFtVElwxlYywtNXA==
X-Received: by 2002:a17:903:380f:b0:24b:164d:4e61 with SMTP id d9443c01a7336-2516d531c06mr160527835ad.13.1757457692920;
        Tue, 09 Sep 2025 15:41:32 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a27422e30sm8043835ad.23.2025.09.09.15.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 15:41:32 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Conor Dooley <conor@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>
Cc: linmin@eswincomputing.com,
	Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH] cache: sifive_ccache: Optimize cache flushes
Date: Tue,  9 Sep 2025 15:41:27 -0700
Message-ID: <20250909224131.276800-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fence instructions are required only at the beginning and the end of
a flush operation, not separately for each cache line being flushed.
Speed up cache flushes by about 15% by removing the extra fences.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 drivers/cache/sifive_ccache.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cache/sifive_ccache.c b/drivers/cache/sifive_ccache.c
index e1a283805ea7f..a86800b123b9e 100644
--- a/drivers/cache/sifive_ccache.c
+++ b/drivers/cache/sifive_ccache.c
@@ -151,16 +151,16 @@ static void ccache_flush_range(phys_addr_t start, size_t len)
 	if (!len)
 		return;
 
-	mb();
+	mb(); /* complete earlier memory accesses before the cache flush */
 	for (line = ALIGN_DOWN(start, SIFIVE_CCACHE_LINE_SIZE); line < end;
 			line += SIFIVE_CCACHE_LINE_SIZE) {
 #ifdef CONFIG_32BIT
-		writel(line >> 4, ccache_base + SIFIVE_CCACHE_FLUSH32);
+		writel_relaxed(line >> 4, ccache_base + SIFIVE_CCACHE_FLUSH32);
 #else
-		writeq(line, ccache_base + SIFIVE_CCACHE_FLUSH64);
+		writeq_relaxed(line, ccache_base + SIFIVE_CCACHE_FLUSH64);
 #endif
-		mb();
 	}
+	mb(); /* issue later memory accesses after the cache flush */
 }
 
 static const struct riscv_nonstd_cache_ops ccache_mgmt_ops __initconst = {
-- 
2.47.2

base-commit: 9dd1835ecda5b96ac88c166f4a87386f3e727bd9
branch: up/ccache-flush-opt

