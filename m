Return-Path: <linux-kernel+bounces-843357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFE6BBF024
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 20:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2322D3B65FD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 18:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254572D94A6;
	Mon,  6 Oct 2025 18:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iOO0G+qO"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331D22DCF51
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 18:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759776258; cv=none; b=nTAsy6iEiQ4795N6PW+XnBvIzJV6Ab7IW9fpqGV3C8aaYTg3pYQSFI46YfRLDDBjW7cR4IBNtE2ZzaNFCyC/kjgloXtpUkt/bWScnX5MgAw35ZiSFE9uP3RnxzxgqCh360YiKonkzH73QY+yUEGz+yAY0xcSpS5lNrj/TMhpie4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759776258; c=relaxed/simple;
	bh=MzqSX4mMMIUeGXvZ0AqPitgqLOhJnpQLkD9oiUQ2mUM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=b74Xot7flo67vgxz7ZdyrZiNZ4j8QqChZRnYDAQysymFVLC5u3Cmh9rPSiTbzi+7X/RjNIPk7KecwvfP1KEjf223wUSx1b6Nnp4O4PRfeJWvhYQG9Y1jViuzj53kMKcUKBRt47jV+F0LC3+E3rTrpERvUY9J/kBrjXlfEaxhK+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iOO0G+qO; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-269af520712so56391015ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 11:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759776256; x=1760381056; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1of7Hvx3VGU0HY2LTP7d7/Ef9wjWUpj1wrr+qn3OleY=;
        b=iOO0G+qOOGFL8l/HWyfaWci0MZax3dXaTjdeBm0uYCs59LleYLD4z1SqoqIezEq4np
         8STgaqy8ee8xX56p4arPCOkvmJyWn7bOBk8ajJhl75tNc/0Ik2NolUlkpIZ6XbybmmQ/
         yV48GdZuFRszAiYkB29eJp6CcjUPEmUWX0s1C0C/slhSd3jv6Lqx+nYcEDS/s4pYYA6C
         6HHydGALacWQ5gQk0Oh8EFmTdSw5573tbefDS43mtgGVfzM2/pDhf5MPlSYCMCP9r7NR
         hYz5Rk7PpVeGXhEk2YevFFuD8yFa8I4cOYQC5wq7VDfjQAgq10ck9+jFYjgYeydZQmfz
         x+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759776256; x=1760381056;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1of7Hvx3VGU0HY2LTP7d7/Ef9wjWUpj1wrr+qn3OleY=;
        b=joIHp0I34LZyx7q5mhrqTvoME0t9OBdFvE1SW/YvSOlseoA9sUh8x59PN0BQff0C+B
         tgEn3lzNKxV34j8jf04U4+Z6iE07qdOrTrvBciAVMS/U6/+n6XzTcHqnShlwiwSI6Lrg
         MFIwE3JeLNKdRA+Kx7p9tOmmFryK3xD6ALxlo9u5mp30r8UO5RKIsJqm0/qwyBlpnz0g
         L0AbSS7K6n/DLUiGKJ2CW2uvvYe1xsSfuT/IOarRFxSyVgLzUymBEesxNbURhJcNvZV3
         YLvdACkaSf6YODpZWFncOfr4tGqp1PPIj+Nrc4zUgs6P3qPYAgQXC90Jbrqv95E5hU/4
         9T3w==
X-Forwarded-Encrypted: i=1; AJvYcCUs7KmyPmczNqnojsMDdKqvixAwmi0Ls3ym/j04nwhWK8X9gvXwa4VUiRFx6hMSCsMy6qQA13M4tiMCkiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz58XSjh6SuXakedTmUhFptHkp86UyXLiWahjWr730FqfQXjy33
	YIIB/l1ULhSCvDZH2xYKjHQuouGoCzLiL+dtMHZ76Eh09s5dYrNT1cqC9hUhaCo/F+Qsw5xMMIV
	IyCOI4CUCk1Y3BQ==
X-Google-Smtp-Source: AGHT+IFQR4yS5a5D5k9yTEe7GYGNWpCQWs/ytTdlyEInlYNxsKlMz9EOECHwmuCnsgaI2H90QufIKJMUbPlhSw==
X-Received: from pjblp14.prod.google.com ([2002:a17:90b:4a8e:b0:330:b9e9:7acc])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f64a:b0:26a:589b:cf11 with SMTP id d9443c01a7336-28e9a6569femr133490805ad.43.1759776256363;
 Mon, 06 Oct 2025 11:44:16 -0700 (PDT)
Date: Mon,  6 Oct 2025 18:43:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251006184412.552339-1-cmllamas@google.com>
Subject: [PATCH] tools headers: kcfi: rename missed CONFIG_CFI_CLANG
From: Carlos Llamas <cmllamas@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit 23ef9d439769 ("kcfi: Rename CONFIG_CFI_CLANG to CONFIG_CFI")
missed one instance of CONFIG_CFI_CLANG. Rename it to match the original
kernel header. This addresses the following build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/include/linux/cfi_types.h include/linux/cfi_types.h

Cc: Kees Cook <kees@kernel.org>
Fixes: 23ef9d439769 ("kcfi: Rename CONFIG_CFI_CLANG to CONFIG_CFI")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
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


