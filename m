Return-Path: <linux-kernel+bounces-851843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E6EBD76BC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9305F3AD488
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA9629ACEE;
	Tue, 14 Oct 2025 05:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrE5TzHW"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A16026F291
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760419690; cv=none; b=COdSZRqGYJVHau5ppBZhKVrXtoU29PlOSrTEbtjvvUUjOekFDd7cPysiG64EYGg0ueyR3bGKnDOtuAgbo4UaQ716lNekBXTY/tFQOiwB2Kjvi1eQK9webFm/JvTg48SFFOaELtTFP+v2iLkYMcxL1VZ24xj07MZXrregMxjvyTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760419690; c=relaxed/simple;
	bh=A+O8Mu5AVJjST6AGpK6YcqU7dC0vCZc73yf6uJmZfJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lQ89dE8iFMfsTgj0KwyWb5hSUQowAoWIvWae9d3qHDLAw9JPpqxFuIWDT0ebJC4MVYI9H1uRzSihBHRdJcLEoSaoA1SwmNtlkH9VG1q1TEcD84alxQXqB4jAvB2Pp2Ar0GpoM+krN5JGW0FyDn4CPs4KkJBsGssC8Vgtil461nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrE5TzHW; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3322e63602eso6591510a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760419688; x=1761024488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tUVXFTv/D7jLsv5kpoyfzsqtL+REv8AzIuYw8UUsFXE=;
        b=DrE5TzHWCH1bPz3/OF4mMSK7TCWKN00N/JaIrXWBIuDesv3U0iKnq5yma/UWBZXojX
         oTayz6e+XSAz/B+4J6YWwTjyGr/TstuOG51Lx5SkaISGA8HlSMm0xYwUXmIdVEXvtq6+
         yG56Z6zy49ypCDHP2JGhFYPOER4SyFTWFlmdag2i/c+VoYdxJZLsiof7wRvqG58ZBcF/
         QNNzxnCErV+lfNEsKiJTqn7xFp4TE61iNwsqa2fynTlYt2p89Yi7Pqq6u5Sq8IqshVKS
         MQ+uUUoIFU9e0pu65gjc4mU0MNs82T714/qAqqwSTZDmU58z9FIMPJo3sauCOwFvLpsb
         kOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760419688; x=1761024488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tUVXFTv/D7jLsv5kpoyfzsqtL+REv8AzIuYw8UUsFXE=;
        b=g6iVAFyEAxfuun+13SQE0GwxAAjNW3sgfwav2a9Ta45SJ7RLt8bo9nGoFYXop1Rsmt
         GNQEodQ8ITlEBdhTs8q98RcH3Q/DDuDQkyagikTuKtBvjmflbDtC7M/OJl8JSTIEre1E
         +dzceLns93rpcsHrNps/05VvA8JPcjWfb+3FkYmruGUsT63Lc+EQ7FMHc5ndyh5cUbwQ
         fUx81Wzb9jb3dUWhznLfHngyx9z5DhMBiZIPK/wmWUrJN1rStNnr+nCGEfsPLWsAyS4M
         LRDckelpV0NdZO5x7hPxariSReo7F/urY3RbW9mSPptmS5tlIrm70l3evgs7AKdCIRwG
         rlWg==
X-Forwarded-Encrypted: i=1; AJvYcCWr2M9j1S/US9acensKID0aKfRlN8a7x2B5Mo/Er9Z4BpZYT7YcRbD5HQ5LbDugu0WEzUGr695yXRzbacA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWQS1hVNPkD9+Ns1sUGrJd/Qqv8NtrQYBRI3A9p53ABLnoFQ7l
	X9fpevFP3Hgookob8JK8FXfuXb8lEbeiZi9TH5+zbuTcIGrNYSbP9pLz
X-Gm-Gg: ASbGncusAg2Y9hJotBlYoM0kBVhVtXz0mYMJPHjTYL0mXl6h8JqIMb4+a583k2mcH7n
	V/cE0ACflS4ulxjDDIm2PBPnBpLScHKExLIITqiCk650ryeoo7cbbQ+0gqvJPBSOdB9Cxg1GwRh
	OdmMeZzv4nAKP1rH3czjeieSluQUMmft256lga17PaZbap/y/wMUmoxk9SNiTq/A0mDkhRvp0eL
	xxXxzjLU+e52F8AYLG9QyfSyPYiVojQQS7/+V/nzT33QMy81e+A6YsmM3JfF/oor/qh+fBLFgLr
	J1Mc5u548Z0kOvoQ33bUcmOeNhHNwX6J2JOHVwiXLp2MfHHCXK/6NOnuxDD1oVe/+LNOGf2Tw9O
	OZDw39l67HwejtIeJ0lUTQckH2tWm2QIwIYl2etvhgBpj5zhwOW/EUW85Kg==
X-Google-Smtp-Source: AGHT+IFntzP8OzdgNYYMHaqHvOwHUMeMx9OXTNUQCyie+jB5pd3spy6Sdf+LQFvsZ9kueWYMJS9Rbg==
X-Received: by 2002:a17:90b:38d1:b0:32e:8c1e:1301 with SMTP id 98e67ed59e1d1-33b513eac36mr31775077a91.34.1760419687520;
        Mon, 13 Oct 2025 22:28:07 -0700 (PDT)
Received: from tixy.nay.do ([2405:201:8000:a149:4670:c55c:fe13:754d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b6192995asm14510106a91.0.2025.10.13.22.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 22:28:07 -0700 (PDT)
From: Ankan Biswas <spyjetfayed@gmail.com>
To: akpm@linux-foundation.org
Cc: lasse.collin@tukaani.org,
	visitorckw@gmail.com,
	skhan@linuxfoundation.org,
	khalid@kernel.org,
	david.hunter.linux@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Ankan Biswas <spyjetfayed@gmail.com>
Subject: [PATCH v3] lib/xz: remove dead IA-64 (Itanium) support code
Date: Tue, 14 Oct 2025 10:54:36 +0530
Message-ID: <20251014052738.31185-1-spyjetfayed@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support for the IA-64 (Itanium) architecture was removed in
commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture").

This patch drops the IA-64 specific decompression code from
lib/xz, which was conditionally compiled with the now-obsolete
CONFIG_XZ_DEC_IA64 option.

Signed-off-by: Ankan Biswas <spyjetfayed@gmail.com>
Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Acked-by: Lasse Collin <lasse.collin@tukaani.org>
---
Changes in v3:
- Removed log about IA-64 support in upstream

Changes in v2:
- Added second hunk to diff of xz_private.h

 lib/xz/xz_dec_bcj.c | 95 ---------------------------------------------
 lib/xz/xz_private.h |  4 --
 2 files changed, 99 deletions(-)

diff --git a/lib/xz/xz_dec_bcj.c b/lib/xz/xz_dec_bcj.c
index 8237db17eee3..610d58d947ab 100644
--- a/lib/xz/xz_dec_bcj.c
+++ b/lib/xz/xz_dec_bcj.c
@@ -20,7 +20,6 @@ struct xz_dec_bcj {
 	enum {
 		BCJ_X86 = 4,        /* x86 or x86-64 */
 		BCJ_POWERPC = 5,    /* Big endian only */
-		BCJ_IA64 = 6,       /* Big or little endian */
 		BCJ_ARM = 7,        /* Little endian only */
 		BCJ_ARMTHUMB = 8,   /* Little endian only */
 		BCJ_SPARC = 9,      /* Big or little endian */
@@ -180,92 +179,6 @@ static size_t bcj_powerpc(struct xz_dec_bcj *s, uint8_t *buf, size_t size)
 }
 #endif
 
-#ifdef XZ_DEC_IA64
-static size_t bcj_ia64(struct xz_dec_bcj *s, uint8_t *buf, size_t size)
-{
-	static const uint8_t branch_table[32] = {
-		0, 0, 0, 0, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0,
-		4, 4, 6, 6, 0, 0, 7, 7,
-		4, 4, 0, 0, 4, 4, 0, 0
-	};
-
-	/*
-	 * The local variables take a little bit stack space, but it's less
-	 * than what LZMA2 decoder takes, so it doesn't make sense to reduce
-	 * stack usage here without doing that for the LZMA2 decoder too.
-	 */
-
-	/* Loop counters */
-	size_t i;
-	size_t j;
-
-	/* Instruction slot (0, 1, or 2) in the 128-bit instruction word */
-	uint32_t slot;
-
-	/* Bitwise offset of the instruction indicated by slot */
-	uint32_t bit_pos;
-
-	/* bit_pos split into byte and bit parts */
-	uint32_t byte_pos;
-	uint32_t bit_res;
-
-	/* Address part of an instruction */
-	uint32_t addr;
-
-	/* Mask used to detect which instructions to convert */
-	uint32_t mask;
-
-	/* 41-bit instruction stored somewhere in the lowest 48 bits */
-	uint64_t instr;
-
-	/* Instruction normalized with bit_res for easier manipulation */
-	uint64_t norm;
-
-	size &= ~(size_t)15;
-
-	for (i = 0; i < size; i += 16) {
-		mask = branch_table[buf[i] & 0x1F];
-		for (slot = 0, bit_pos = 5; slot < 3; ++slot, bit_pos += 41) {
-			if (((mask >> slot) & 1) == 0)
-				continue;
-
-			byte_pos = bit_pos >> 3;
-			bit_res = bit_pos & 7;
-			instr = 0;
-			for (j = 0; j < 6; ++j)
-				instr |= (uint64_t)(buf[i + j + byte_pos])
-						<< (8 * j);
-
-			norm = instr >> bit_res;
-
-			if (((norm >> 37) & 0x0F) == 0x05
-					&& ((norm >> 9) & 0x07) == 0) {
-				addr = (norm >> 13) & 0x0FFFFF;
-				addr |= ((uint32_t)(norm >> 36) & 1) << 20;
-				addr <<= 4;
-				addr -= s->pos + (uint32_t)i;
-				addr >>= 4;
-
-				norm &= ~((uint64_t)0x8FFFFF << 13);
-				norm |= (uint64_t)(addr & 0x0FFFFF) << 13;
-				norm |= (uint64_t)(addr & 0x100000)
-						<< (36 - 20);
-
-				instr &= (1 << bit_res) - 1;
-				instr |= norm << bit_res;
-
-				for (j = 0; j < 6; j++)
-					buf[i + j + byte_pos]
-						= (uint8_t)(instr >> (8 * j));
-			}
-		}
-	}
-
-	return i;
-}
-#endif
-
 #ifdef XZ_DEC_ARM
 static size_t bcj_arm(struct xz_dec_bcj *s, uint8_t *buf, size_t size)
 {
@@ -509,11 +422,6 @@ static void bcj_apply(struct xz_dec_bcj *s,
 		filtered = bcj_powerpc(s, buf, size);
 		break;
 #endif
-#ifdef XZ_DEC_IA64
-	case BCJ_IA64:
-		filtered = bcj_ia64(s, buf, size);
-		break;
-#endif
 #ifdef XZ_DEC_ARM
 	case BCJ_ARM:
 		filtered = bcj_arm(s, buf, size);
@@ -699,9 +607,6 @@ enum xz_ret xz_dec_bcj_reset(struct xz_dec_bcj *s, uint8_t id)
 #ifdef XZ_DEC_POWERPC
 	case BCJ_POWERPC:
 #endif
-#ifdef XZ_DEC_IA64
-	case BCJ_IA64:
-#endif
 #ifdef XZ_DEC_ARM
 	case BCJ_ARM:
 #endif
diff --git a/lib/xz/xz_private.h b/lib/xz/xz_private.h
index 8409784b1639..6775078f3cce 100644
--- a/lib/xz/xz_private.h
+++ b/lib/xz/xz_private.h
@@ -24,9 +24,6 @@
 #		ifdef CONFIG_XZ_DEC_POWERPC
 #			define XZ_DEC_POWERPC
 #		endif
-#		ifdef CONFIG_XZ_DEC_IA64
-#			define XZ_DEC_IA64
-#		endif
 #		ifdef CONFIG_XZ_DEC_ARM
 #			define XZ_DEC_ARM
 #		endif
@@ -103,7 +100,6 @@
  */
 #ifndef XZ_DEC_BCJ
 #	if defined(XZ_DEC_X86) || defined(XZ_DEC_POWERPC) \
-			|| defined(XZ_DEC_IA64) \
 			|| defined(XZ_DEC_ARM) || defined(XZ_DEC_ARMTHUMB) \
 			|| defined(XZ_DEC_SPARC) || defined(XZ_DEC_ARM64) \
 			|| defined(XZ_DEC_RISCV)
-- 
2.51.0


