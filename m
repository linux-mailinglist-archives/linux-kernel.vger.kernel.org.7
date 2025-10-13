Return-Path: <linux-kernel+bounces-850454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 309E6BD2DAF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 12C084EC759
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B53266595;
	Mon, 13 Oct 2025 11:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3bJGbpy"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2CE26158C
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760356375; cv=none; b=hRPY15DJSctY4ST0UJBx/mq5AWnqodBu7e5clAgQ1/Gded6a4BrcmL5s9fqAecD9tNv015g1rnQvxfZNq6pJpv21jo5LH9lJCh8MwGvX/FgC7C/9PvQfxPMSZqYb8tUKGM0/ojnwGy6XMtr6hHnaJKpvGxzddDCVDAFJbjpVTsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760356375; c=relaxed/simple;
	bh=i1Lwz9f4Zsz4UsfvVoJqK64sBdSfYTAOFxgfnGkAeDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QhjkKKnAur/HLr9NKb2xvWUUPD8C37QrgGjWl3jzof1PhykkkwH7mosrChXrIgY/7Qe3WIYsc4rvXZj5mIeDz0Qke0vBD4FbFW2WI+KeVHnM+wdRUw7OY93hKrnBMARPEcZb3XNwQxBf5RJTP9TzcmjPgEfMsx+nXyLZRse2AuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3bJGbpy; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-781251eec51so3412641b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 04:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760356372; x=1760961172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Egpoy1X2fQ+8/Yie2BM3N9bWjE4Ih+la0lrQjzSB4VQ=;
        b=L3bJGbpyih0MvgSCDJ0l+6aI8LZ72ubRf9Bth0tqRrhrmn20r3+5ygFCUt4mQiR3Ws
         V1xR50T40OlI/wpTnFiNy2VbYyiBFrmOxUldfmKl97IkdRwzzEzGIA8Hjh8CyXifVNde
         PXTNzyT/VtjdifOF1a4VI01CNO8i/NpS29LBFfTvBDQ1kgZJe0ZBjCe2P5Oo7nl7dxmY
         ftbMGiL3ZjUokrNIo0UDEvVIC2zVSqlO8XIMA1V9aISEWpjjvpOYfiw8d0pxP7JmYxeZ
         ixLjIOxipHJjeRDNqNzQPweIiU4E1m+hB6tB7dH1fOB+QJ0B1U0mZjpzf8IuFOxxUfoa
         nKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760356372; x=1760961172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Egpoy1X2fQ+8/Yie2BM3N9bWjE4Ih+la0lrQjzSB4VQ=;
        b=d0y5Cv6+aRPtGAyWoSKpizKybHc9lcJ4KOCawQIJstX7KRv3+P93664CQGsTbLk4H/
         f+AFu6vcsYGmuh6IkISkNKxTlsxM+nn30dgP7yTQE4Cse35oTsTDtt5Wsi4Ef8stI2Nf
         e7HQazqwnNTCO7ww1rsHiNyUPhPaY4UfJ1uOobs1qqd+vtt1QNlJ18Xl+UFM6EiuxDSA
         2n03/sbUmcEtbKJlUfooGwLlDciceQhmaLjRUhI1vS6viBrmr8plUqHUYS1PDaLp6vUB
         NNE4NCYfCWPtxeUkluE9al19J0GGjCDKG19o0Nm3sg6TCXTu6UQ+j5mdu8J7LeZpkyd1
         b+Cw==
X-Forwarded-Encrypted: i=1; AJvYcCVIm8wRDmKhq4ENfENAc2v2uZBLGG/SFltpKm+/ow/rgGgUq6SvYyU6xYBBYp8/i9RU3zq9D1y0EQXis70=@vger.kernel.org
X-Gm-Message-State: AOJu0YydS0Y/GN7iXNx7FRqaMDS5dLRKA5nXf+iIWFYyKKmrq7vEfV0I
	wTgAZSa/QHEfQWON5PG9vcoBm5Lp/+qYM0GvlbKjjbyIpRuqFEIvewYf
X-Gm-Gg: ASbGncsbA28VswQhWexDQA1XkLQ9oaOuEaz0v6+IUMZ1N0HKtXKbTgX4tuVVT/h7mdq
	muCwZO23pkX03DW6xR1z5A9gsGfpjM6fnDLf1r+kQVio1gC+0+9DtR9II8NfmkYqxD2iOXTP5Ti
	qcuXF4Dwb5exYDKUfpQpzKNCiyWdh6CyNL+59D/fHu4ivPSTD0Z6hceL8HG3ltkU1Qn+vGtuLPq
	M31WiTe63kdaQ76FGUMJYnqR6deNQNC2I3Al6LyhqkFqBY67jj6QWrbzrzuhfKADWOwRvBwgNT6
	f0Eu1zCwzBKoXd1mfiPxs3ZKb2UmZ9XdkA/lYmfeSOMGMkSgfLEUDN9t/+qnTrPMtrmaQTcjuxD
	O/HHdYbieYgeUabKlhRwhT0yCBED70AaOnUCaN7SFFXeKjY0Mx4+VpZ1AdbWNpic/hzDj
X-Google-Smtp-Source: AGHT+IGWqjC6xAnpzEBUQy8WisU8mbnxne5dIHRwu8Eojg9nNNlsaga53eGHSXMq28EhYugtt1BBEA==
X-Received: by 2002:a05:6a20:3955:b0:263:9d85:3733 with SMTP id adf61e73a8af0-32da839e9cfmr28143466637.31.1760356371555;
        Mon, 13 Oct 2025 04:52:51 -0700 (PDT)
Received: from tixy.nay.do ([2405:201:8000:a149:4670:c55c:fe13:754d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992bc13543sm11388022b3a.35.2025.10.13.04.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 04:52:51 -0700 (PDT)
From: Ankan Biswas <spyjetfayed@gmail.com>
To: lasse.collin@tukaani.org
Cc: skhan@linuxfoundation.org,
	khalid@kernel.org,
	david.hunter.linux@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mentees@kernel.org,
	Ankan Biswas <spyjetfayed@gmail.com>
Subject: [PATCH] lib/xz: remove dead IA-64 (Itanium) support code
Date: Mon, 13 Oct 2025 17:21:36 +0530
Message-ID: <20251013115136.16773-1-spyjetfayed@gmail.com>
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
---
 lib/xz/xz_dec_bcj.c | 95 ---------------------------------------------
 lib/xz/xz_private.h |  3 --
 2 files changed, 98 deletions(-)

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
index 8409784b1639..a51da0a30d0d 100644
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
-- 
2.51.0


