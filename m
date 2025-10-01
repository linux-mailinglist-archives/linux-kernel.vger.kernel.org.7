Return-Path: <linux-kernel+bounces-839514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E600BB1C4D
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 23:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C05F3B7EF3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 21:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701CB26D4D8;
	Wed,  1 Oct 2025 21:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AqV4lIUV"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA47231282D
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 21:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759352653; cv=none; b=jqb3CB2hBhmLek9fUuWY4kK/D5mnmm/MEMqZrTn/6k8djAuvWUx60nU93ah3HnlsdYDYqhla51vrpfChd4Xz/j39d3ect0mDbpSQUK5VQsd0s9QXHwWKzvHlCw6w3oKIKiCq/iXPes121NKS5QJ3kV9caMKzgKUeR5UsTzP80BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759352653; c=relaxed/simple;
	bh=ZgELTmYgz5fIxY25szP3ldagosc57h1+aL7duMm8keQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KTYe+epunlUjG/yYYYkygax2GkqtDSSVQknhIvc3E7umP1kJTHK9D4Z85HNPEVpSiwPK8DgyMvTGRF/5EOoHc1YQISdJpldoka1RJc8EVqL3Q92kz8vnBXcYoM4wfcglrFyOa2GSWJfxILZDVzTFi/2OHmcNHZpPC/EVYngBxfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AqV4lIUV; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3f93db57449so103497f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 14:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759352650; x=1759957450; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AGpAD7So2A8Y91ye2lz/R4t8i6WlG+BPLoLmcvlg798=;
        b=AqV4lIUV0SLUhZYRWXSW4BndnhYOU63hd9R7TZC6FZvmtEj9iLQmUwwt3ApyYeENEL
         EHusT6kaccNoC8cZCSNlla52JvAJM2sDD4S+694q6PiR8eznuPdw2BSF2I7rZZ4JEMfE
         KQf7c8oP91ZSDs3aCBf7WNfFJzw+xAsaidMuoAwA3JNiYH3Z0lEsNrKjM/zFPaE6y5ur
         FreJBY4p9PTTpSOMNwgK1iLNflvagS4Vo20J8qbMGcBDn7ChnFYetl9HYnJVyqL5meLX
         j5ccSg+kbSFatYFZl7tB6b03KiNmdNiJ5rv2XYkS8NFNsUywuk8YqItRqKJgpbiAo/1z
         oxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759352650; x=1759957450;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AGpAD7So2A8Y91ye2lz/R4t8i6WlG+BPLoLmcvlg798=;
        b=WVDrUnJp5l9b+sJWU6q1l0E7MeSoXMM4cz+MVKgARgy321AHNcZe4rAwdNfcgp443u
         3ls1sjEUnCKigeSLSM79vySl7Umbk4LFz2bOY7XivQeLUQJfBiDXOdAC700KsLH1nFoO
         lwLVD0Ff8j525AzDda8I3jmQCrw+/JOdbg1a61mcKn1O/ZUmDvwu/JbqF604mT3m4T7N
         S5ln/yYlKqmxBvIvmjCJqhvqdtp5WZgoKv03aDQsEHInjNGTyb5BOIxlQQrb/4TFV4lW
         GWSrG3sjibS3XhxzTGoMRc6zZpzcvcf89913qWXtBw8dD8N4458PRkdspyGiSNudn0ef
         zV/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4RuMwMNav6Qr3WSgelDXE+ueHD7PaqVKfd4DrJfme7uzs7XC2gwimArM7vSOIMs4Yw4GO+9EY+ykUDvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZqITb6AkuucWv4nV5syLoJxAP+I9b1ZjQPH5ahiGKpzGPm+EA
	+0x3iM0G6SXKweI2yNzA+HsuObDHnrGllauyMeto0yueypuyBjsgzsz4uuxukp9PjyqZ1Zw69g=
	=
X-Google-Smtp-Source: AGHT+IHWWReVgSgZUQEq8XT+L+cxH1DIu/oJIKEaKdRtIQPT1yPlkOb9ch5vfT9GQM1XrYkcIG8pVP20
X-Received: from wrxg11.prod.google.com ([2002:a05:6000:118b:b0:403:1719:fe2])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:5f53:0:b0:3ee:1296:d9e8
 with SMTP id ffacd0b85a97d-425577f057cmr3436647f8f.17.1759352650072; Wed, 01
 Oct 2025 14:04:10 -0700 (PDT)
Date: Wed,  1 Oct 2025 23:02:18 +0200
In-Reply-To: <20251001210201.838686-22-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251001210201.838686-22-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1156; i=ardb@kernel.org;
 h=from:subject; bh=oFEUnftgBXE3h0R5t48zlJmEk3FO4wNTPpQmOq7/RvQ=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIePudD65SYn5avG5Dcvubcq+/Oeqwd7/dv8Lvh7dE+bzK
 E5H5/bpjlIWBjEuBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjARkQRGhu9nlry9Ll7B9c5p
 S3eg+lWV5s/JX2a+vP7s0xz5d3LhTPsZ/kplbDI8nSli739/azmz6Vbd0ilZXGuOBjtYvLxl614 7jwEA
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251001210201.838686-38-ardb+git@google.com>
Subject: [PATCH v2 16/20] crypto/arm64: sha3 - Switch to 'ksimd' scoped guard API
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
2.51.0.618.g983fd99d29-goog


