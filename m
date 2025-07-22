Return-Path: <linux-kernel+bounces-741568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A39A1B0E5D8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 23:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07F3568102
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A7C2877E8;
	Tue, 22 Jul 2025 21:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C853fdJ0"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B192928725F
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 21:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221491; cv=none; b=LU0owmD7GWNDvj8OlA7ENhTJGeovW9BkQgz5Gtr2VoG0tiL5RSkIxb6GHWP0Z97fO7k6xHAJTKtgVvsEpHVI6PAnB7AClSNtRSsi5h920Ep8GMxpUaOoMsSbO5DfrCfpB3O6cOsueXXnT1G/1ZHqJjzznTh/p+7yvbS9f7GdLa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221491; c=relaxed/simple;
	bh=Y9rAwk43R5Qu/XneIvtPPaxorqlg9IJwfPk0mko3rAw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=smuJatBg5aTNG29SUcbopvKe53HrO2AiERtddPsMgQlk7CBqqfPjp9YZwkeEl3WNrWBK8bmV1tFSv3m0POCEm32dJH5c7qC7zAnTDdhOri+NbGXO1jkjrZo3ndVsh3i3nJVX9bp3j10QpOcYJdXRCHeYb3h2ZYgpoeVp/rjaMGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C853fdJ0; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-315af08594fso5678350a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753221489; x=1753826289; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=06wlXYRsyscOOukfm0BoHmWOsjunsh8IZmbqRpcqtRo=;
        b=C853fdJ0xOQbgEZtQOkgX2C8yILwNijR7CiheNFg56U/T68obrJAaKZOBRtXdAJdpY
         2cEl1M1y2ST7E96LEmvGdbRRMKKAv6KPmVDG5uAchPsFPqcoiUI/PqS2h5AiLGfzzosP
         dzVkjKfe2us7v/rGB8m8ZC8WFTxeYb0xrg6y6jpZuSh1C2fiZupOLk8Y0ZkSxtWb3Nke
         KbI+h7XRtNUmhtM81RvMDSBXuJaF598mPEkfsIO4BfPKMpzL/kM8vpjDQYigeLk3myWJ
         jbr2L6L2xfZQCxj+ASc/CF+RzDE8sjGWezkmF9zorii4CRIRX09b5hNLovLdNOg9KCfu
         vJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753221489; x=1753826289;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=06wlXYRsyscOOukfm0BoHmWOsjunsh8IZmbqRpcqtRo=;
        b=gbTNyP6d4UGQvFaFdbJMdYUTBzFvb9lgAcjpaDe1XG7QZUz+mW0nEOVeSFZNyRAQUC
         cEH3dAzcNrd0cUjnvNXz4lKyMSbJWu1/jyEh7lDH03vKzisE6WaLjQgrgpvQDQnebFGD
         ZwGmUhCJiGaIQgGCvxlLOegfo1Bxsm3fz9bd3N7KeDPLl+y3JtfyAd3tRheY1DiSmn8X
         /bPe9Eskb4J4ZNIs20QUTVIQMqKya2WC4kqxLxbBUkfxm+oWxatVgkuolsuKMZDmIJbv
         tD0X1KXNS/PBBHkI+Daknfx6/E3i5I7+0tFa9NL3fn9KO/jkTL7V/GEtKIB55MFb8jNj
         n2Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUSUVTL4115ytSsBf8XA+CtW5A1L7Zm6QIY5OAIMyLHyQ++ppQc5JotDmN+Wq4KGUVMvYZk+EvKxSKRnXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YymVhMwBy4w0mwh/DF+ryM/i4et9Ewnlx1EHQHLglnhReh9Fc2L
	Ww9Ra8sS9XJxzeCVQqxZ2sQ36u4DJNIqNTR4ksKxh8z3+m7QG6xaBqhLmedxw58WM9PhGbz4RNG
	+J/KXR6n7NA==
X-Google-Smtp-Source: AGHT+IEfl0qr0pR281L9dJaXexJr+ertXkeG0LYGx/wzbCfiyuMlqHnbJNq3oMgCoRDj/DcPskPxdJRnCpAd
X-Received: from pjg12.prod.google.com ([2002:a17:90b:3f4c:b0:312:df0e:5f09])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d09:b0:312:e91c:e340
 with SMTP id 98e67ed59e1d1-31e50859540mr1050005a91.35.1753221489083; Tue, 22
 Jul 2025 14:58:09 -0700 (PDT)
Date: Tue, 22 Jul 2025 14:57:54 -0700
In-Reply-To: <20250722215754.672330-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722215754.672330-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722215754.672330-4-irogers@google.com>
Subject: [PATCH v4 3/3] tools headers: Remove unneeded ignoring of warnings in unaligned.h
From: Ian Rogers <irogers@google.com>
To: Eric Biggers <ebiggers@google.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Now the get/put unaligned use memcpy the -Wpacked and -Wattributes
warnings don't need disabling.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/include/linux/unaligned.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/include/linux/unaligned.h b/tools/include/linux/unaligned.h
index 395a4464fe73..d51ddafed138 100644
--- a/tools/include/linux/unaligned.h
+++ b/tools/include/linux/unaligned.h
@@ -6,9 +6,6 @@
  * This is the most generic implementation of unaligned accesses
  * and should work almost anywhere.
  */
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wpacked"
-#pragma GCC diagnostic ignored "-Wattributes"
 #include <vdso/unaligned.h>
 
 #define get_unaligned(ptr)	__get_unaligned_t(typeof(*(ptr)), (ptr))
@@ -143,6 +140,5 @@ static inline u64 get_unaligned_be48(const void *p)
 {
 	return __get_unaligned_be48(p);
 }
-#pragma GCC diagnostic pop
 
 #endif /* __LINUX_UNALIGNED_H */
-- 
2.50.0.727.gbf7dc18ff4-goog


