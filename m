Return-Path: <linux-kernel+bounces-870050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C6BC09BCC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 18:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D3661B208F5
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9049D30BF6E;
	Sat, 25 Oct 2025 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/pBvg4b"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD624308F1B
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410442; cv=none; b=K1G3herzI40nlAygXmp3PB7aqAVzvIOW6efRRmOdQkAgdkN5LsVGkSObi0Sef93+bGcLS9Q7PS2RaXmbpC/I1n8/O6Xib6kcjoZH10jDI2sjeyXxIxVKaaC75oKx7Oca+wCXk9t4fgNIV33HL/k9Lj840DHDdDoTRL5z3g5haH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410442; c=relaxed/simple;
	bh=vSOmrnKl9j6cBNY7sSNJF+HbPImP5X3RfSSeVaTTTB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kR7z0xnUmJPwXEuvKbBWMV0dyIQHrFiEKLar9Un5g8mi7qKv8JFmjpHw23SW+FoUtX054I8Rneq9KrL3omQnNVfSaaIXNPspIkER+L+Jw8IYJ4cmt2jNDb32estr4RtY7hLhBWOjpHg+fxjaPTQUuyLFeZc+u8GoA2mJrZIgbns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/pBvg4b; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-87eed34f767so30567686d6.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410440; x=1762015240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJO+MeQ4RtFqJ9ACNBMsRAE4YNMhC0BoZJ57Lb9WxOM=;
        b=J/pBvg4bD6nlrmhy2WkpCtAYiRy1NsaQHVYzjHOattRRHA73ly1OSYpP/cz+gKvRpS
         zUk02V+ewAGOf/q1qBLWGa4fQG/InW5QStc10DMHarCXjVIHKwpR80C5xjO/GtSHbLaw
         BR5Pxt4EX3PqXRdpQy74eg3szRQTzXuC7uCmyXtUSDZYuIi4SrPNMmLNrYmVLjWkYwso
         F+k//7Ne2SytIH4mpdY0vAiLtD5SkexjyxRTeesp9xvXSlEFRR9TSHH0Cjx95j40CvVK
         T5b836tWes+YOH97wiVm/fEjWCeywikOG/PbEfFkQ06KURz4KKjNcZIo6YAxlLz+YXSv
         VhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410440; x=1762015240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJO+MeQ4RtFqJ9ACNBMsRAE4YNMhC0BoZJ57Lb9WxOM=;
        b=RVLvfmxq2vBk0IVOY4iTlMsvdYCR1+BJ2E1jft4jusG13KUg5cO71Q+34Ef6rnZ6XL
         znm4bLwhlHke3+LCbjR9Rnqu8tBZ0CSa4D6mbXstzBwclag6/8onrCtLDWnRZZedUFhv
         VYkviDFC1E8iHfdtcBidyXNYMAe3W2H0mVbdQYat5irfvgFOnsfLfYFFWJapr38EQN/n
         I+PQWVgUQDtICAJy25nT8BzJA9hmM7EF4h8BgbklsTjnPctd5P+eniuMeUxqUDXZpFQc
         r00jyAQhKaDD5eYa82m6N7x5nd9YL3WzPifTRKFe8Exuw8TMan99Yh4wJhTM4Vw+3eNE
         /fCg==
X-Forwarded-Encrypted: i=1; AJvYcCWW/d6CHhf0HELhDEvUnUxrRTv0hSNwvcEkyRLmGhlcYYqSGKyX/XobyHS42j0woNJF16lvniUpVsgMDJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvoJVDuxWqvEEETl3W8uXvSdn53VSRRlBMug7ocldKYjVapOAf
	pm8XRR8KHBgES71BHjmbR5qU7UsedzBoNy0qEKZ9yWICzG650ceSyLRW
X-Gm-Gg: ASbGnctSkbqGkk31IAa6gpcuDraqWS5E+MUYbYXE4u7b3rmVVdKC9YoDeoYkuSo4qMQ
	p1YVQmaw5egKgoqc+JhcCN9y2qOAdwutHvhXQ04OYAhuuKb5P0PIKPhQwgPkTCNeQ9R5p17xIoT
	faDJXD2O36znC7tAYob5V2n4cVGdFKy4xy4njBYuZvCqy3SOTxE6//BFEkr0JPQCvoYtd7nfvcW
	iAQh18a/To78eqmxJZAabsxI1IgUNjW8gTq85HT4vGetPZHdIkufC6Z6JRnlSIc97yKB2pSo/w7
	Ly9QLmTFWik12dQqLFiTP5XF7lsfsK6Ou2n/5wEjcsu2TkWAhQn5NwvAnbEmMNp78FS3QShFzJG
	+GQTcUNz4lL1Oxva8+lK3WjTYxmkWnHr/JSN5jaqpJptggdyS/ELhEpNRjO3WkHGSBwrwnAH8
X-Google-Smtp-Source: AGHT+IEjzlUxBHT5SKcjYBFCzIkSq3QG+F9tz4biOwCVVJqf15/90wSyKHSXScePaTErfc6IgULEng==
X-Received: by 2002:ad4:5c46:0:b0:746:e5b3:e123 with SMTP id 6a1803df08f44-87fb647acfbmr81429146d6.59.1761410439724;
        Sat, 25 Oct 2025 09:40:39 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc48a6fedsm16348196d6.2.2025.10.25.09.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:40:38 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	"Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 05/21] zlib: rename BITS() to LOWBITS()
Date: Sat, 25 Oct 2025 12:40:04 -0400
Message-ID: <20251025164023.308884-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025164023.308884-1-yury.norov@gmail.com>
References: <20251025164023.308884-1-yury.norov@gmail.com>
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


