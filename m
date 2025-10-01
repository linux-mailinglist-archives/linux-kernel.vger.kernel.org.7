Return-Path: <linux-kernel+bounces-839269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BD8BB1374
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 18:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A66491C4C62
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 16:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307E628507D;
	Wed,  1 Oct 2025 16:07:17 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922D5220F2A
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759334836; cv=none; b=ndrHccLPwn/CCcGxgrgKxUwjjGGSsMIz8nCfbMbSmqERDSpVcE4ikGRNnAqIaR9PerSskIdi2WiPMUGacZBeTslWyYyzgNtKAYN9zLc7QjTNHit+p/BaGX4e06qxVHLD5hKFBtpY6MMccOXd5q5AHfLgTz5HeF1inyZg6jSALjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759334836; c=relaxed/simple;
	bh=yGthKrJgjptv1SsVBgVQ+xaQq3apEw2V386nO3JE0tA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=C6dgXRJH8gjoo2i9VVVLkbCaNqM0ZooNIIJFX2nd/iKOeaLLrBupZVmc6zVjNG7iOLCFv1vvq67Bg9aexWv4+uSQGxgWoGSVP6lIzELLwWwydBd4rmnRRJBr+6mquWcpUe3+p6Hb23dUjABa6D5wJgt5VwVpWgiN5s1fZ3UGlhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3e234fcd4bso6722966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 09:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759334832; x=1759939632;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5F/ZlmahY4v9ng57M3b3RixWviloAxPsx1h4/uNyS2w=;
        b=fYffG1/8wew25jETf9k119nur3cEq6MhQHT57WSyBtL6V3XcrlBngCFRtV217Qpcbd
         8jnkiamRvPufn5yU1742dRbzNrB+sNE3qdREYkhViEh66VTG9ZT48bVGQ8mXuSF4qsaX
         LfWpiR+D72v+Ah4Nd61d/zLTv+SfwTDFuVjj/8OhQx2CdPIbh1xgLLB/BoTkY7/AB6vB
         SWgFRhi7o//z/7NNR3xeHEFpEA9WWwEc6EuV3bItnJ0A7li0gnj+8qncudJAZRaUiT8/
         CGmwq5gobFHOJIGCNiboyQDikBFf4BM3scunMBfO1dSKgm1GZ0/sq1zdOWD3HrjwmBMI
         jrfw==
X-Forwarded-Encrypted: i=1; AJvYcCXKnDMG0T6zWOnZliFsokd7GKufB/MytsounrIHAjf0JaEOUfXWpdd3gRqCwURrGzhwGRbrkBC1d5HRcE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDFp71OO/bcmFu/8a0vPaPUjhUoUnPSMjlAFYpGGHHx5eJMBsL
	3ja2EPC9pMgNsf3/OXmo4xLnOuyXRfC8JTjinNLWDBsWNFrsyzL1/tWJ
X-Gm-Gg: ASbGnctMZNQLIrwEeXonhCHu25wARW2qj4UIsiFVxaTeJBXQktCZN8Zsd3viUBzY17/
	MI/BiZ31wmtXmpICG//N3kyfOUFm4Xst/fZa8B/8jdfeLuob2GnqNv6Sc3fU0Zh7bcrv6CH8YxV
	y3A5Ejzk55WcInochsXvuaflzCokBSteuGxHf/5SGzblRZ4Hrf3vPcL1i7QjX7F2brx6fFAFwOp
	R5h/QI18BdCl41JmgfSSgfm/uwMDj6kyZxY4WrkFHzwiQnHNsNEET2bpLKAxyEX5JZus7rlFEmY
	GN1Lmb3vWX690M7tIxIi+zBXBvfZd9H6dYszjb3Q+nJc6jZIavT1UwXi1yGoBhUUmCRJNkYZvLT
	lYqidsttHshoGzgjVNlWBUaKeSz6OmU6MMz+V
X-Google-Smtp-Source: AGHT+IGU2oV2XoghFFNjXpeXFR8ZpMH3QCRErktbMJOKfZuJaKAV1DQAvKt87juoFqsJakAyIPoG8w==
X-Received: by 2002:a17:907:7212:b0:b43:b7ec:b891 with SMTP id a640c23a62f3a-b46e3ae19e4mr491578466b.28.1759334831631;
        Wed, 01 Oct 2025 09:07:11 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6376b3b8df3sm51976a12.13.2025.10.01.09.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 09:07:11 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 01 Oct 2025 09:07:07 -0700
Subject: [PATCH] stable: crypto: sha256 - fix crash at kexec
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-stable_crash-v1-1-3071c0bd795e@debian.org>
X-B4-Tracking: v=1; b=H4sIAKpR3WgC/x3MQQqDMBAF0KsMf20gk+omVymlJHaiAyVKRkSQ3
 L3Qd4B3w6SpGCLdaHKq6VYRiQfCvKa6iNMPIiH4MLH37OxI+SvvuSVbXQk8cU7Fj4+MgbA3KXr
 9u+er9x9vAtTRXgAAAA==
X-Change-ID: 20251001-stable_crash-f2151baf043b
To: gregkh@linuxfoundation.org, sashal@kernel.org
Cc: stable@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Ard Biesheuvel <ardb@kernel.org>, 
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>, 
 Michael van der Westhuizen <rmikey@meta.com>, 
 Tobias Fleig <tfleig@meta.com>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2044; i=leitao@debian.org;
 h=from:subject:message-id; bh=yGthKrJgjptv1SsVBgVQ+xaQq3apEw2V386nO3JE0tA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBo3VGuPtPcA/FbB8X5L3sATv/wd4PcV5twNu9J+
 9M1P703yCSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaN1RrgAKCRA1o5Of/Hh3
 bYx/D/4oyRu9MKW9AfBVPio3fDNu8pXycH+g5imDGXWy45s4UXL9Ncnb/lNfMBFFL44hC8uAB/Y
 bycLfU3OJLP40P3WwHV+tXrT0cSU2N5Zwy2x21twyp59R/G6EkXhRQdXsAf8vTMuQAPXcZV0BLg
 Ok7fk1Jwsc4QD835ibz1CzTegXZtyye0LoCCbF2kuJHY0C82L2SsoVfsCf2K7SLc2vlWZCWMEOX
 zE7u8Q7Z7RJbA2nllYagJWW+byq3R2bO/f0gdbNhU9AtfkqgW5tAg8kNZb4cCYBqtbfgPANc6Nk
 eHRz6xvX2EZlABpCZfbxccm+km7nVlj+1jIS8zd5DCJKEup/wLEO31r7gYZ+N3h+RE8KidBKbp/
 DV/90DK0MoU2wFb+GT7rz+yRhBNmasapS4rocrCkCD0oWs0zPhmWScBnF1D2SbNvAunTFVBQDnn
 DdiKCFho3CfON96LAkZzpgEPbkIjW8ZzjA0nxNJ6Ts3TvZRatgNpt4qYxDSh6SurunNgYanK2Kv
 tzPEsvGghgTVWjMa5ViHlWTIEsVqSR3vzmIWXi0RyK3ZuEq0EwRfxdWgqNuCP4xwJAuUoE/w738
 024vq5PU3sfeOEcbA6wv9IIAKH7+wpVurdwQk5BgV9KoL36qQYRkW4ampOy0jJS8YZuF9YYJh83
 xSEprJRPwLiyb/A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Loading a large (~2.1G) files with kexec crashes the host with when
running:

  # kexec --load kernel --initrd initrd_with_2G_or_more

  UBSAN: signed-integer-overflow in ./include/crypto/sha256_base.h:64:19
  34152083 * 64 cannot be represented in type 'int'
  ...
  BUG: unable to handle page fault for address: ff9fffff83b624c0
  sha256_update (lib/crypto/sha256.c:137)
  crypto_sha256_update (crypto/sha256_generic.c:40)
  kexec_calculate_store_digests (kernel/kexec_file.c:769)
  __se_sys_kexec_file_load (kernel/kexec_file.c:397 kernel/kexec_file.c:332)
  ...

(Line numbers based on commit da274362a7bd9 ("Linux 6.12.49")

This is not happening upstream (v6.16+), given that `block` type was
upgraded from "int" to "size_t" in commit 74a43a2cf5e8 ("crypto:
lib/sha256 - Move partial block handling out")

Upgrade the block type similar to the commit above, avoiding hitting the
overflow.

This patch is only suitable for the stable tree, and before 6.16, which
got commit 74a43a2cf5e8 ("crypto: lib/sha256 - Move partial block
handling out")

Signed-off-by: Breno Leitao <leitao@debian.org>
Fixes: 11b8d5ef9138 ("crypto: sha256 - implement base layer for SHA-256") # not after v6.16
Reported-by: Michael van der Westhuizen <rmikey@meta.com>
Reported-by: Tobias Fleig <tfleig@meta.com>
---
 include/crypto/sha256_base.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/crypto/sha256_base.h b/include/crypto/sha256_base.h
index e0418818d63c8..fa63af10102b2 100644
--- a/include/crypto/sha256_base.h
+++ b/include/crypto/sha256_base.h
@@ -44,7 +44,7 @@ static inline int lib_sha256_base_do_update(struct sha256_state *sctx,
 	sctx->count += len;
 
 	if (unlikely((partial + len) >= SHA256_BLOCK_SIZE)) {
-		int blocks;
+		size_t blocks;
 
 		if (partial) {
 			int p = SHA256_BLOCK_SIZE - partial;

---
base-commit: da274362a7bd9ab3a6e46d15945029145ebce672
change-id: 20251001-stable_crash-f2151baf043b

Best regards,
--  
Breno Leitao <leitao@debian.org>


