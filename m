Return-Path: <linux-kernel+bounces-845697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F8DBC5EDA
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B7AF42744E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 15:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F40B2FC891;
	Wed,  8 Oct 2025 15:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QUv55FJ4"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9DC2FBDF1
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 15:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938425; cv=none; b=pqcHYz/rUSNz4tJVWh2aSdvwdcU8ke4KKhZgU7JGVt1hDcZcqzeRnkfQjE2SUeFVjovJUI3qj9p0hI4R6XYlq8w00nhGSPCC95Jw1XUoRboDinCn26jZYsu4Cqv0vtTXPBr0G46jKbfFxlo0/yEOvH+u2xS0QwLWct5fhMJ7ZUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938425; c=relaxed/simple;
	bh=FQD/z+6lXiIcL/7kTxCFE2DLvjr2aRXNJXgQtJfNEVM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fG1buJ5xVwSWGjUGjYVcZKowrXczaW+lKMylCxWOvpm2WbgB6NXYnIbKZZOrfzU9fuAFHpUEAyQGgcYOs5GjZzvYgBpjqlnu3yVS3dAnGFWOqSZ5m7ZTK4xP3vBFFhCDzF7kEi8c7GVqO454/G7Rk4P8ij98PWVHUF1p9uIz6uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QUv55FJ4; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-426c4d733c4so34942f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 08:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759938422; x=1760543222; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s9LVoYmYTtGptKcGaIqz4TtHmJpnpszkhgfxtgMZN1E=;
        b=QUv55FJ41cyPQSy1Go9/Fx3VS66mEDNWnKAcDNwDq2WMUilUm+w2uRu5CzwU7NWdYM
         4X4ClEq1r7Xg1EJxQnMpPNElfXYTp3Kq8pkbC6N1jrW9xdfu/MqLsruvxONNz0MBucgM
         9cGSlHfARvzdkAp2LIYvuD0cqEBn8p61Gp0YASB54kmvDY4ZVyr8jrgWrV3wx8RfU0l8
         SV+VMFR49gnXviJxyHPzfT+bM2ZgNppSc5S0hMiusfIr9v9Cij/qkq7VesmQZ93HfCzL
         10AMs86L3i0b/DIQolYfyCS9gxxK+SverYdiACrwHW0aHIKmrpxiK18kKygh6TsAtI7L
         W6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759938422; x=1760543222;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s9LVoYmYTtGptKcGaIqz4TtHmJpnpszkhgfxtgMZN1E=;
        b=URj0H8AeaA166E81y/OhQk8M9jlndhxHhD7hyBwb8aQ1MVTT9ODpzpx3H5C1P0H4F4
         PVLz7PN5+IC+WoqrNLw7w6zBCzvipDSShziKGOu9qQE7qrEDFjRjkhi+jKcBGgzuXvao
         +vLPujwwmKQ9dl2S0ntHArG0H5xFRrtoioCpZeEm4zUb17jpjZJEbxiPdwNdmY/O3Uom
         d9nxH9+nr2jdYDUrRETl0mimYEGn1cFP/AKXO16bKm98pJtMuXRRM/7Lejos5jNMenjq
         drloP7ZeHVVdcw9QfFkCVWTfLm6HkuMG7+boV5s3t/jfdZB5jLvEXzQweGO7H1TaQUIl
         m9UA==
X-Gm-Message-State: AOJu0YwW8gHH4LJNqIj48gdIQ0EhngZPLjVJghvMOAFQmUf1aIByZg/Z
	SpoDqz8D7mf9Zer/rcUoWiQBE3UolJPGhkii8Pt3YwMy7LQ/zydw2Brl2UHUHYUjN655iw+l4g=
	=
X-Google-Smtp-Source: AGHT+IHpvSRci2gpv7ZU1IAhZM+xVMFiXHJZypmfvURMXvnTa0pwgCk5eYUgWECkxlzPguEf0Tz1w3HD
X-Received: from wmbd24.prod.google.com ([2002:a05:600c:58d8:b0:46e:4943:289b])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:5d03:0:b0:3ec:e0d0:60e5
 with SMTP id ffacd0b85a97d-42667177bd4mr2760140f8f.15.1759938421849; Wed, 08
 Oct 2025 08:47:01 -0700 (PDT)
Date: Wed,  8 Oct 2025 17:45:49 +0200
In-Reply-To: <20251008154533.3089255-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251008154533.3089255-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1531; i=ardb@kernel.org;
 h=from:subject; bh=KbLRn3K+fhgTbW1ynT/DmRKNIqX5FUyDJ4LA4JLPqDs=;
 b=kA0DAAoWMG4JVi59LVwByyZiAGjmh0mgHwxNRpFR0uLeyEM/7Ru0XZRuTjmbCFMD+pwVKCMPv
 Ih1BAAWCgAdFiEEEJv97rnLkRp9Q5odMG4JVi59LVwFAmjmh0kACgkQMG4JVi59LVyXkwD9GvEh
 GB4myAwRpn32iKqBOQuzHl9IIEadlLMcTujoQkgA/ie4fhaKFva43l0IM40cGryU1yaSMyBQQI8 ARZPeCzsG
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Message-ID: <20251008154533.3089255-38-ardb+git@google.com>
Subject: [PATCH v3 15/21] crypto/arm64: sha3 - Switch to 'ksimd' scoped guard API
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	herbert@gondor.apana.org.au, ebiggers@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Switch to the more abstract 'scoped_ksimd()' API, which will be modified
in a future patch to transparently allocate a kernel mode FP/SIMD state
buffer on the stack, so that kernel mode FP/SIMD code remains
preemptible in principe, but without the memory overhead that adds 528
bytes to the size of struct task_struct.

Reviewed-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/crypto/sha3-ce-glue.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/crypto/sha3-ce-glue.c b/arch/arm64/crypto/sha3-ce-glue.c
index b4f1001046c9..22732760edd3 100644
--- a/arch/arm64/crypto/sha3-ce-glue.c
+++ b/arch/arm64/crypto/sha3-ce-glue.c
@@ -46,9 +46,8 @@ static int sha3_update(struct shash_desc *desc, const u8 *data,
 	do {
 		int rem;
 
-		kernel_neon_begin();
-		rem = sha3_ce_transform(sctx->st, data, blocks, ds);
-		kernel_neon_end();
+		scoped_ksimd()
+			rem = sha3_ce_transform(sctx->st, data, blocks, ds);
 		data += (blocks - rem) * bs;
 		blocks = rem;
 	} while (blocks);
@@ -73,9 +72,8 @@ static int sha3_finup(struct shash_desc *desc, const u8 *src, unsigned int len,
 	memset(block + len, 0, bs - len);
 	block[bs - 1] |= 0x80;
 
-	kernel_neon_begin();
-	sha3_ce_transform(sctx->st, block, 1, ds);
-	kernel_neon_end();
+	scoped_ksimd()
+		sha3_ce_transform(sctx->st, block, 1, ds);
 	memzero_explicit(block , sizeof(block));
 
 	for (i = 0; i < ds / 8; i++)
-- 
2.51.0.710.ga91ca5db03-goog


