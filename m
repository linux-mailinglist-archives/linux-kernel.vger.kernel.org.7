Return-Path: <linux-kernel+bounces-839512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E862BB1C3B
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 23:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98A181714AA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 21:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720A2312824;
	Wed,  1 Oct 2025 21:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oa2dFGNh"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B04311C3F
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 21:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759352650; cv=none; b=k3iT1aTUYiNyck1Mdd7Ri+rHvTERxESzXR22KNmdsunML5KZBZFHJWJP5r9bw25u/nlIgTNETC+RLueWx/3b3U35YpdExnmC0kP+ystY+W87uU4fOvl7NUvrh4WorEiNDIKUUX0QrXULiopO+aIYdU1gkWJ8rZX8QpCwlgaO5yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759352650; c=relaxed/simple;
	bh=SW5mPnOzJITL4l0UqpBY1hKBImd1TIHcagRsxcO8Ux8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aen8wSOG4n0GYyCUzYr7y7AabXHTX4QafpvKnxm7M13PzXRrKblQ3X5chdPmMoBaPEbhIELnj+nDqNOZvta5OgYdGZSf6eY6zLj1RvQhojHyusJwjhly9SacdwDgZaqiNSonXpyHxGYM4+dNOCaPbkFSErDTJ7zAPX/zgJ5gz8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oa2dFGNh; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e4943d713so1254735e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 14:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759352647; x=1759957447; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UZKSd5rMdo9tEwoYCoXUQVE6sJT0wmf8X0NATCF37Q4=;
        b=oa2dFGNhmcvvyhoyP1Si3mFhku55TBbhfKRm+E+pLjSs3LMCkvsVHsx2WfcGA+Ebfo
         ESQRvHYo0E7mvYGv2xxNa7gYa8/qEWhrDYjSaTvWKfgl5twBdfkXI8atbyr6aOuSpK9i
         HkARuRCIFJ7UXK/dlTylw4h9LMjzNMoXuvhY5ho4Jclg/HPbeNbXfpxRjXscKixI0blu
         OtXCMqILnmk6DJ3elccYb4cWGYtykwHGkh7dEr1R4tg/yxBrWVcEq96RzVd8LWJsxS8w
         1jrAqhAalr4KqmbEY9u9ZmAYJKu1Dd14oS5MX+zwAy18eb78mUuS27UAqfKcH9kvndEV
         ZCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759352647; x=1759957447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UZKSd5rMdo9tEwoYCoXUQVE6sJT0wmf8X0NATCF37Q4=;
        b=TkDrzvQL4PgeAMlsQ+JBX7Uwiwb86LRXk/slE2NQgs3f/FaPjZx3uIETqan9rXSQX4
         IYPr5XLtvrb2w5R/AAj4lg6644+m0QfR46YItao4o0mhzGkKFxvBZvSBo90OaICMzzC0
         1E8CYb0t+yPmMuOzt/XY4rSiSFZVWmrWQrxgqMY6M8bN3QZwwD6XYv9ePDqCwWHnvL/C
         TO973xLMTHFKSsBYtaEFSLlxGXiPuJJ8/6a8tQPD0NI4Fs5P8IV4OrtBkTHBGs7oHisO
         G9Jp2mqu9wg5DBS/oFQhqThs6oYvvhAODZDwjjiXg9rxYJBERgzyVDQZDH6oreM+ajQt
         O2hw==
X-Forwarded-Encrypted: i=1; AJvYcCXpkDCKZlXZkb7aVZCKh3JBZib/3Yx5kRRcJajn1fFd507hBIu0Jrih7A+oKtMw2AkWCW5SVnWEifhQ1ZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrbbK1xb/z9cV7W7kF2zPVzG1R7EmVwQP3qaYZuprH8FD53Odj
	ofhoUyBMDvq0JLiCXlabRFGixu6EOJTAhcBSpB+pqHrgOiC2PKnq7XpThwjJ1m9V1YrG0cgfcg=
	=
X-Google-Smtp-Source: AGHT+IEYxGxSDoioNYClblaAj4vxDm8fokdAPOdazIOTblzm8QXHXPeKE11+MRENrVgxIsmYT+ZQ2SYk
X-Received: from wmjs2.prod.google.com ([2002:a7b:c382:0:b0:46e:3422:1fcc])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4fc6:b0:46e:1a07:7bd5
 with SMTP id 5b1f17b1804b1-46e61285d7dmr38854685e9.29.1759352647355; Wed, 01
 Oct 2025 14:04:07 -0700 (PDT)
Date: Wed,  1 Oct 2025 23:02:16 +0200
In-Reply-To: <20251001210201.838686-22-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251001210201.838686-22-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=814; i=ardb@kernel.org;
 h=from:subject; bh=40tSyXfxoCO4pZAvlNOPxZCROdcuajmQXIsSsXG3TMo=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIePudNZjToIdV9WeFedtulX01C0kb9ZiTfM1ap1FWzetS
 rNz+Liho5SFQYyLQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzkSAsjw7scuSlTyt+Fs1z8
 9Tm6LUE4x8+7eQ0f03c1h6unY6tVFjD8FeRM44laGepRWKlwYnJBPce7w3/PGx652jDr06pfoou aeQE=
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251001210201.838686-36-ardb+git@google.com>
Subject: [PATCH v2 14/20] crypto/arm64: nhpoly1305 - Switch to 'ksimd' scoped
 guard API
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	herbert@gondor.apana.org.au, linux@armlinux.org.uk, 
	Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
	Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/crypto/nhpoly1305-neon-glue.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/crypto/nhpoly1305-neon-glue.c b/arch/arm64/crypto/nhpoly1305-neon-glue.c
index e4a0b463f080..013de6ac569a 100644
--- a/arch/arm64/crypto/nhpoly1305-neon-glue.c
+++ b/arch/arm64/crypto/nhpoly1305-neon-glue.c
@@ -25,9 +25,8 @@ static int nhpoly1305_neon_update(struct shash_desc *desc,
 	do {
 		unsigned int n = min_t(unsigned int, srclen, SZ_4K);
 
-		kernel_neon_begin();
-		crypto_nhpoly1305_update_helper(desc, src, n, nh_neon);
-		kernel_neon_end();
+		scoped_ksimd()
+			crypto_nhpoly1305_update_helper(desc, src, n, nh_neon);
 		src += n;
 		srclen -= n;
 	} while (srclen);
-- 
2.51.0.618.g983fd99d29-goog


