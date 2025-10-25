Return-Path: <linux-kernel+bounces-870023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FC1C099A7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 18:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E5AC534E692
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37637326D4C;
	Sat, 25 Oct 2025 16:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHMQtyGN"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5E8324B2F
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409756; cv=none; b=gNFEOjA/ZfDtgyDB3F2vSUetvy1FmPa+2lDdSLpXjCaEjyBtKhToX1Nbwyfh1vpq6FLZ55TfSL6Bl59uxiI/SPsMR+fYRgUohctzJHC42IoL4T50ThF6XM3CxULCUX33jgs9Su4RQlcqpAUvP9InQXch5aQ4bj2HUW/fKxtWCwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409756; c=relaxed/simple;
	bh=vSOmrnKl9j6cBNY7sSNJF+HbPImP5X3RfSSeVaTTTB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bOEC5V01tveW1RQ4ZKeqp1FbW+qJf7xRT8f/S5sM41SYVPeCt7GKvpVuEqGUCbFBKS7cA9bPETb3dK6q8IqiTdnjBTUnvIbB3Du03k3g/fPWPq8p6ApF0tu3moDX2uBMtRAPge/gpsGHAuAAChaLKwoaZjbfJIYiBhVplgMgzWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHMQtyGN; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8a114591f15so29345185a.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761409753; x=1762014553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJO+MeQ4RtFqJ9ACNBMsRAE4YNMhC0BoZJ57Lb9WxOM=;
        b=gHMQtyGNHqaGs40F7wIBmCDbZyWtl7y6iRZL7ITBgu3KXCEJBQNGHC5ktC0SaQp5eq
         CYeNzHJF0EV48k/T80bpx2AeOCz3M8lbFSnplH3egU0vB5mcqwVhRtMRhqjOJu2xEAqO
         ODNtUj0yXgcyAdcIn/t1FxQoiHUbe2YitCMWoysztIM19sIpQOQwhCrVawWVLlKj5prc
         yub9NqMvB8vP7hjip1C4dXpf0naeeLKJNhgcHa9H96Rf2oZKB6MYMsCBBeHLA2GnAdtx
         w9gzoSkIJebT3GXFuzh3eWrVZN90aT5ojrRUyGHU21iKFB8hfZ163o6GXvQ8tOEqw4+Z
         5tKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761409753; x=1762014553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJO+MeQ4RtFqJ9ACNBMsRAE4YNMhC0BoZJ57Lb9WxOM=;
        b=iFtm3eBfFJTLW/GNjy0SvtUUtf1GsMrii0Y7aPiD0Ku/jiMP+U4/BRBYRswWZRskWk
         v+qSNYnojdF40PeUFWuEtA7VamsMFvTxuC4yfW6M2pWRs/Voy8LEIH0ehc9uvWlzEA3R
         UCaEIxX7ZzAkamA/pLqn/MbjDSPFYSvERCNIG48QjADW0bkSxkxFMJhlY9nQWs7Yz666
         PGKVvMyD+o9/PBHgU0stYsb+27dkywNzUuM/4C937zjqfufeNtEG9hNZHI3magyqvmW1
         L2gq8D83vT4pEr0HDkV49Qa/MuPaeUyCiAU3mh8N8OE1EscdXTFSFtHBphQsmQko8SzP
         MQrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdLgR2mw5f1cQWKKtZhYwjBvyHaF5pqneOXyaJKxwrAT1xtEYMk4671jbsX0a2orEphFY4xcfqqzPY8XY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1vSri0ho9WkyhDyVChrKaWrKTeOTWPdbH4X4SiSy/FaNcT9kS
	rymrYQrZGCYlrYi+dHVz5NGnX4yi09/8KxR9NyGssRP93w4ZYqNHirek
X-Gm-Gg: ASbGncsz8s2jpXNnqzbOHGfEijkkDhQ+O3FZV0Llf23Ad5ZX28BW3CWi+B1Ql3RYEPM
	/gO9ORi3NIT0F/cytV07jdUVQ2GFFTU1rW/Li1q7VtXgG4lPgfktOL6MGMvNrDoFAS7PsyxB1Ms
	4+JP4r3t3CbjSJeZvX4dhANIsgo5tU5siNpdanJW5WCnTLGpDqhymUcXDPD5ban2wU4c/sbeUJ5
	9FcvkClJAIchLoMVKA5fiSPs3+CilnAaK7u/W0ijdsV8zqaEm1q6F6kqkuL4H0sSG815xAYGunD
	1Ler1zM0a4Fo9edDe2T80ofVKV7x2iQa26otIg23ROkcy4tvMFG5TfkDDmlmzxaktYPtv0XMftR
	TPAgIgYkq549ezDP/TtQe/JS0ktAvs5ZSIlHijDmCUR63EtJUXCAT4/ir9CndWxA7ISSmQCOB
X-Google-Smtp-Source: AGHT+IH6uNIrkZmsMoZ8MZ+ODlZIL9OIXHsVfJ9kwXcOeEFldBGDrvl1xoiZUliWzp4QZq0d8LiTBA==
X-Received: by 2002:a05:620a:4627:b0:890:e60c:de2c with SMTP id af79cd13be357-89da018d159mr957294285a.14.1761409753403;
        Sat, 25 Oct 2025 09:29:13 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f24cd592bsm173777985a.18.2025.10.25.09.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:29:12 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	"Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 05/21] zlib: rename BITS() to LOWBITS()
Date: Sat, 25 Oct 2025 12:28:41 -0400
Message-ID: <20251025162858.305236-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025162858.305236-1-yury.norov@gmail.com>
References: <20251025162858.305236-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation from adding generic BITS() macro, rename the local one.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 lib/zlib_inflate/inflate.c | 48 +++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/lib/zlib_inflate/inflate.c b/lib/zlib_inflate/inflate.c
index d1efad69f02b..3102137b51c2 100644
--- a/lib/zlib_inflate/inflate.c
+++ b/lib/zlib_inflate/inflate.c
@@ -229,7 +229,7 @@ static int zlib_inflateSyncPacket(z_streamp strm)
     } while (0)
 
 /* Return the low n bits of the bit accumulator (n < 16) */
-#define BITS(n) \
+#define LOWBITS(n) \
     ((unsigned)hold & ((1U << (n)) - 1))
 
 /* Remove n bits from the bit accumulator */
@@ -270,16 +270,16 @@ static int zlib_inflateSyncPacket(z_streamp strm)
    is:
 
         NEEDBITS(n);
-        ... do something with BITS(n) ...
+        ... do something with LOWBITS(n) ...
         DROPBITS(n);
 
    where NEEDBITS(n) either returns from inflate() if there isn't enough
-   input left to load n bits into the accumulator, or it continues.  BITS(n)
+   input left to load n bits into the accumulator, or it continues. LOWBITS(n)
    gives the low n bits in the accumulator.  When done, DROPBITS(n) drops
    the low n bits off the accumulator.  INITBITS() clears the accumulator
    and sets the number of available bits to zero.  BYTEBITS() discards just
    enough bits to put the accumulator on a byte boundary.  After BYTEBITS()
-   and a NEEDBITS(8), then BITS(8) would return the next byte in the stream.
+   and a NEEDBITS(8), then LOWBITS(8) would return the next byte in the stream.
 
    NEEDBITS(n) uses PULLBYTE() to get an available byte of input, or to return
    if there is no input available.  The decoding of variable length codes uses
@@ -295,7 +295,7 @@ static int zlib_inflateSyncPacket(z_streamp strm)
     case STATEw:
         while (want < need) {
             NEEDBITS(n);
-            keep[want++] = BITS(n);
+            keep[want++] = LOWBITS(n);
             DROPBITS(n);
         }
         state = STATEx;
@@ -369,18 +369,18 @@ int zlib_inflate(z_streamp strm, int flush)
             }
             NEEDBITS(16);
             if (
-                ((BITS(8) << 8) + (hold >> 8)) % 31) {
+                ((LOWBITS(8) << 8) + (hold >> 8)) % 31) {
                 strm->msg = (char *)"incorrect header check";
                 state->mode = BAD;
                 break;
             }
-            if (BITS(4) != Z_DEFLATED) {
+            if (LOWBITS(4) != Z_DEFLATED) {
                 strm->msg = (char *)"unknown compression method";
                 state->mode = BAD;
                 break;
             }
             DROPBITS(4);
-            len = BITS(4) + 8;
+            len = LOWBITS(4) + 8;
             if (len > state->wbits) {
                 strm->msg = (char *)"invalid window size";
                 state->mode = BAD;
@@ -416,9 +416,9 @@ int zlib_inflate(z_streamp strm, int flush)
                 break;
             }
             NEEDBITS(3);
-            state->last = BITS(1);
+            state->last = LOWBITS(1);
             DROPBITS(1);
-            switch (BITS(2)) {
+            switch (LOWBITS(2)) {
             case 0:                             /* stored block */
                 state->mode = STORED;
                 break;
@@ -465,11 +465,11 @@ int zlib_inflate(z_streamp strm, int flush)
             break;
         case TABLE:
             NEEDBITS(14);
-            state->nlen = BITS(5) + 257;
+            state->nlen = LOWBITS(5) + 257;
             DROPBITS(5);
-            state->ndist = BITS(5) + 1;
+            state->ndist = LOWBITS(5) + 1;
             DROPBITS(5);
-            state->ncode = BITS(4) + 4;
+            state->ncode = LOWBITS(4) + 4;
             DROPBITS(4);
 #ifndef PKZIP_BUG_WORKAROUND
             if (state->nlen > 286 || state->ndist > 30) {
@@ -484,7 +484,7 @@ int zlib_inflate(z_streamp strm, int flush)
         case LENLENS:
             while (state->have < state->ncode) {
                 NEEDBITS(3);
-                state->lens[order[state->have++]] = (unsigned short)BITS(3);
+                state->lens[order[state->have++]] = (unsigned short)LOWBITS(3);
                 DROPBITS(3);
             }
             while (state->have < 19)
@@ -505,7 +505,7 @@ int zlib_inflate(z_streamp strm, int flush)
         case CODELENS:
             while (state->have < state->nlen + state->ndist) {
                 for (;;) {
-                    this = state->lencode[BITS(state->lenbits)];
+                    this = state->lencode[LOWBITS(state->lenbits)];
                     if ((unsigned)(this.bits) <= bits) break;
                     PULLBYTE();
                 }
@@ -524,21 +524,21 @@ int zlib_inflate(z_streamp strm, int flush)
                             break;
                         }
                         len = state->lens[state->have - 1];
-                        copy = 3 + BITS(2);
+                        copy = 3 + LOWBITS(2);
                         DROPBITS(2);
                     }
                     else if (this.val == 17) {
                         NEEDBITS(this.bits + 3);
                         DROPBITS(this.bits);
                         len = 0;
-                        copy = 3 + BITS(3);
+                        copy = 3 + LOWBITS(3);
                         DROPBITS(3);
                     }
                     else {
                         NEEDBITS(this.bits + 7);
                         DROPBITS(this.bits);
                         len = 0;
-                        copy = 11 + BITS(7);
+                        copy = 11 + LOWBITS(7);
                         DROPBITS(7);
                     }
                     if (state->have + copy > state->nlen + state->ndist) {
@@ -584,7 +584,7 @@ int zlib_inflate(z_streamp strm, int flush)
                 break;
             }
             for (;;) {
-                this = state->lencode[BITS(state->lenbits)];
+                this = state->lencode[LOWBITS(state->lenbits)];
                 if ((unsigned)(this.bits) <= bits) break;
                 PULLBYTE();
             }
@@ -592,7 +592,7 @@ int zlib_inflate(z_streamp strm, int flush)
                 last = this;
                 for (;;) {
                     this = state->lencode[last.val +
-                            (BITS(last.bits + last.op) >> last.bits)];
+                            (LOWBITS(last.bits + last.op) >> last.bits)];
                     if ((unsigned)(last.bits + this.bits) <= bits) break;
                     PULLBYTE();
                 }
@@ -619,14 +619,14 @@ int zlib_inflate(z_streamp strm, int flush)
         case LENEXT:
             if (state->extra) {
                 NEEDBITS(state->extra);
-                state->length += BITS(state->extra);
+                state->length += LOWBITS(state->extra);
                 DROPBITS(state->extra);
             }
             state->mode = DIST;
 	    fallthrough;
         case DIST:
             for (;;) {
-                this = state->distcode[BITS(state->distbits)];
+                this = state->distcode[LOWBITS(state->distbits)];
                 if ((unsigned)(this.bits) <= bits) break;
                 PULLBYTE();
             }
@@ -634,7 +634,7 @@ int zlib_inflate(z_streamp strm, int flush)
                 last = this;
                 for (;;) {
                     this = state->distcode[last.val +
-                            (BITS(last.bits + last.op) >> last.bits)];
+                            (LOWBITS(last.bits + last.op) >> last.bits)];
                     if ((unsigned)(last.bits + this.bits) <= bits) break;
                     PULLBYTE();
                 }
@@ -653,7 +653,7 @@ int zlib_inflate(z_streamp strm, int flush)
         case DISTEXT:
             if (state->extra) {
                 NEEDBITS(state->extra);
-                state->offset += BITS(state->extra);
+                state->offset += LOWBITS(state->extra);
                 DROPBITS(state->extra);
             }
 #ifdef INFLATE_STRICT
-- 
2.43.0


