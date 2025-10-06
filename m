Return-Path: <linux-kernel+bounces-843560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C17BBFBA0
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 00:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5DB1883EF5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 22:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7944619C553;
	Mon,  6 Oct 2025 22:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vCq8KoYK"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFCE4A00
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 22:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759791118; cv=none; b=Q7LsX5vV7uttagk8rF167+FupNtEUfu1G+C3PedUoYOyp56OooK0uojZTJiojS50bxnwMHfzJO3TdLCuHuobV5EGKVU4lhofk6RNKjtbL3gyjsIHCEF0nsmWm803xq5udP3fAH4kXAUKzIne4CP1KMt80QkBtlTTwljULmBSRpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759791118; c=relaxed/simple;
	bh=ig03M+wH/717yirGM8YLezSVIL69WWPFSeDx4iq9EZc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SLeHh/05OnHRIgf3DC93UKXB9YgNieMuomWHmNYPiy4p8RCsW/z9Pty2DoSmShXZlXwKiXW0muoJLbbbUFX//Xx+Nkt8ee5KqabwzhiIelifSNjLKU8t+srYq3lNhDjhVrbBvL7g9Wmzf2SgG3tiR2g3re903N+mPrlTph9YvJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vCq8KoYK; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-28973df6a90so53660465ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 15:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759791117; x=1760395917; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g+kHLt1BfDUooT+OCPYIvn3v/bcwWrvcBesUiHdzIrE=;
        b=vCq8KoYKpZarzOGS/rSz0S4scWNVjdHCVrtPjjDqGkbvCg2S0HZQPMf0Bj2Rv+lDgv
         trSbYn+pLEzIzZeFpwYRfOc7qCoFhwAmTNskCGnfO469proQAtP3LpOuwTsEG/uCqhHW
         fafeejiiHOaAG/ASIoGvE+0nz1acCJiLgayS+b6prHPkziJZ6KgYfeyUEhbD4Xbt21QH
         3cioN8dxAhE72AX8BzdthAZTdrJO1W4ElwiiKlM/DJ0vYixc8BVxKukW5C+XWBJmd5Em
         pNLlNHft3P9pjmmidf6EqLZCWB8tHOKTzjODtviGozcumQs3C4uQDeNlgiHO7n/hAMzv
         JPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759791117; x=1760395917;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+kHLt1BfDUooT+OCPYIvn3v/bcwWrvcBesUiHdzIrE=;
        b=N15BdveQlfblRkBVju80gjJw7HlTqtzp3kWKG4PndUf+ywpsqFzlTmTMyopGbB76AC
         U2Ms32agevSOTcP8C3feHagysl1zWrhU10HizTy0D7Rhj1jbJnq+LQh0BgJLYR+0q5g6
         /3c6boTqOT29TGIQZmq2nggaQLTGEAnUixMubzDL7hd4JvuofWkT9ER6s1K4mPRdJkQ7
         ZAyleckJP9R+/7hdkS4EN3V46myimaQWAVsgxFtLnqHbsfbCQzHB1f/Vc5euAZJjTDRQ
         cF8vB5WHLzTYSdrrUD7bGWD9VpLn2e8JeGbLO2lnbvNC6TPx2S4rgY3oqg3bBRiwWTeR
         O/Rw==
X-Forwarded-Encrypted: i=1; AJvYcCVuJo1jBn4Xu96zTvtPAM93QntOo6G/NksU1QxWMWkNI8gfVGQI3gPIrizKq2it/euS1vyzxcleu2sVdCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjbFTd60hQFEQswqqwWRqIDxE95trV71XOeo5sg1N08HD77v5b
	WdqcraiQvA+hvx66EoF5yAlyPtTVrbz7nIycAAYFlyYpVvnox6xBO8rM+a3dYxm/J+2dSbo19MG
	2Pl9WAQ6l/xhUGg==
X-Google-Smtp-Source: AGHT+IF16BM/QjElKKU49MuQJ2UVNVZobzbhmaE2dhXtqBvTirIHIE84c/Bc5N1gkqHQndSUrBnPQ7pJjTWdbg==
X-Received: from plhx5.prod.google.com ([2002:a17:903:2c05:b0:27d:1f18:78ab])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2409:b0:27e:e96a:4c3 with SMTP id d9443c01a7336-28e9a54423bmr180090815ad.14.1759791116824;
 Mon, 06 Oct 2025 15:51:56 -0700 (PDT)
Date: Mon,  6 Oct 2025 22:51:32 +0000
In-Reply-To: <20251006220500.GC3234160@ax162>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251006220500.GC3234160@ax162>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251006225148.1636486-1-cmllamas@google.com>
Subject: [PATCH v2] tools headers: kcfi: rename missed CONFIG_CFI_CLANG
From: Carlos Llamas <cmllamas@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Kees Cook <kees@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit 23ef9d439769 ("kcfi: Rename CONFIG_CFI_CLANG to CONFIG_CFI")
missed one instance of CONFIG_CFI_CLANG. Rename it to match the original
kernel header. This addresses the following build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/include/linux/cfi_types.h include/linux/cfi_types.h

Cc: Kees Cook <kees@kernel.org>
Fixes: a5ba183bdeee ("Merge tag 'hardening-v6.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux")
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
v2:
 - Tag the correct fixes commit per Nathan.
 - Collect reviewed tags.

v1:
https://lore.kernel.org/all/20251006184412.552339-1-cmllamas@google.com/

 tools/include/linux/cfi_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/linux/cfi_types.h b/tools/include/linux/cfi_types.h
index fb8d90bff92e..a86af9bc8bdc 100644
--- a/tools/include/linux/cfi_types.h
+++ b/tools/include/linux/cfi_types.h
@@ -43,7 +43,7 @@
 
 #else /* __ASSEMBLY__ */
 
-#ifdef CONFIG_CFI_CLANG
+#ifdef CONFIG_CFI
 #define DEFINE_CFI_TYPE(name, func)						\
 	/*									\
 	 * Force a reference to the function so the compiler generates		\
-- 
2.51.0.618.g983fd99d29-goog


