Return-Path: <linux-kernel+bounces-870052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59826C09D4C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 19:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 901CA584A76
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9462C30FC0A;
	Sat, 25 Oct 2025 16:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvDZsl/F"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6393430BF66
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410447; cv=none; b=V6oUAADWxrCjjp3y83dlWp9jyHGNHWGl0ANLOiRwx5Fau9u2CUspzwLf8XvSdelQA1cPQSlcr5ZQ0qyn2PGdICbejYJlgfeFIByO6Lmw5fgmBDko2b0m/7jVfg3932qODHdyDOVlcGrJsmzeLsQR5dFmb+U/HRGPMukaGJGGupU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410447; c=relaxed/simple;
	bh=6VtH0YRJIJT6wM7OnyxPz0sTaONVtRxS45ztLq91gUI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CsbuGxuFBywyGyBhYE/IExeAntheqpsV/A+kUL8oJYFdfSoHs6w/uWACMzkTPxFTi7B5grcXELFw6IIAEP/KykJRZ+axPXOmTK32W5KVrDVl6/Qm1H6HZ+ATmkM1el7fV+NfaJ+d//vi05MPGRKSGrGLN6zwdkf7f8JasGlS5+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvDZsl/F; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-7f7835f4478so22924946d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410444; x=1762015244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rg54zbsiDVSwYkKftv5+NDhQ1U50ovc7eDauHPziXJ4=;
        b=kvDZsl/Fl7oBZpOxXZCdNS92r8JKczW4/ODkzUDS3nBDpG+CQ8lubiDUy9kVXoqamH
         Mz+19/1Z4MkcQyw1syWRCc2cu+PnfT43EcWNNkXz0sS8VPcaDs/05Hg2Dwz0uHgpHBUu
         maDY5AYRAMRc7YyaQ/ojX2DpqfsEDMWQ+M1gZ3RLuvXHnQ++x5UTZwyUtuhVy8+ZACVN
         psj73tc8voCa1z2c3Wfdlznu6Nia5NyKODMF0YwWbrRY9MYniWNh9o3MznzePB9jbKk8
         phk05XLO8WGPfLpPYro4OGMAHvsbQnenJGhSrrafvT4076+aNxuFdhr0/Lv4q8zJ3fZm
         /Dew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410444; x=1762015244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rg54zbsiDVSwYkKftv5+NDhQ1U50ovc7eDauHPziXJ4=;
        b=PMmj9mfjESi4q1NtM9y1EoCSOMmosw5H8t7NSfIqolGYyiw/MbCkltdQ1u4yWypD3V
         UDeKwDhQsrQBRxlSq75rzlmOxA0fb6DpRK8F3PKoyg7MLKJXol4kkcxkNZIzQHnyi3Lt
         UUg0vYT9sSY4oEi4TWag+b/q8k7ipIzkUHnv/PYuC+5TkM+COGGUUXYHXCseRKRJy5sR
         7/SpKBdkoFW77wDxvlzR1uGypdq2s6pEDXlsfugdQdzgrtw10tYh0/DeC9KCUYRTJaVS
         RTCySi9oQnh+qIDWKtHu9V6+qCyvfy2h02yilG+aLyfBfwSXoIAieMY0LbwrhVsma3BO
         Cs5g==
X-Forwarded-Encrypted: i=1; AJvYcCWo2SnfMz48nGsdtcrbsjrzRb0wdCDAOJgHtymdFjOPVQ9EjZ8pZJIE1iTtTFNefqX1RdbhEyURDG1Rz2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbtsDpIB4RzBCpZ8HKxBKOCaXupMsWKY30mLlTXVurVoA07zdo
	Plwt4JH7yZ8WH5nTv7XSC8V81xRtn9t+10YELxbj8QoJPjSmzj+S4fmF
X-Gm-Gg: ASbGncujhqL7E7tt/RheVzYBJG24IJfkb+r2G0eqbYORZowAPjTmrdt1kVmzLC2jScN
	jz5gcMw78JCsMvc2vNzWdzoF7vZgtUNa1PCGp9jDrm69ZRPEMrh6YKa/3+DVX0qKrcTlQZTTofm
	atN655/NhHlGLpJ9hCpcpNDKfFD/OPK8lo2+9sBn0L8Cwthke25qthrT4yFx9wDmdEvvmedJvOj
	s9ZqFg2xUy8CEGsTtExdqC+FexaGTFd+Mzbjnp2kXbKn+1SRGuT+n7VVw0UHMfaJBzE2qgDleu7
	JHPkO14INzaWlvpp270pRQEw9/OVT6JC3PhNgh7Je5ENEOGNvDDaktslMhM2h1nHXVcV8vNsWsJ
	OkKZwI9RdDfz7Ui2TKmcAjHOGvmhVP3klI1FhjWN83xUh1BsoVxUucqSpRqRFCcENGAEn51FT3f
	U17PZ8Cg0=
X-Google-Smtp-Source: AGHT+IGKsc2keEHm/1YFQYrnIMTwMslANRJ4raDN9IkDXbXLCbSXAIKbrJmhJuMSjVOFvhRcYi6AIw==
X-Received: by 2002:a05:6214:43c4:b0:87c:20f5:84e2 with SMTP id 6a1803df08f44-87c20f5873cmr525350756d6.25.1761410444250;
        Sat, 25 Oct 2025 09:40:44 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc51e3809sm15359146d6.26.2025.10.25.09.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:40:43 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/21] bits: Add BITS() macro
Date: Sat, 25 Oct 2025 12:40:06 -0400
Message-ID: <20251025164023.308884-8-yury.norov@gmail.com>
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

The BITS(low, high) macro is preferable over a similar GENMASK(high, low)
because (low, high) parameters order is more natural. The (high, low)
order is confusing and has a record of misuse.

To enforce unintuitive parameters order, GENMASK() is enforced with
compile time checks. In addition, fixed-width versions of GENMASK() had
been developed. They make sense in describing hardware registers.

In generic code, using standard ordering (low to high) is more preferable,
and fixed-width features are not that useful.

In non-driver code, BITS() must be taken over GENMASK(). In drivers code,
BITS() is preferable over GENMASK().

The following pattern of using GENMASK() is highly unfavorable:

  /* Status register (SR) */
  #define I2C_SR_OP               GENMASK(1, 0)   /* Operation */
  #define I2C_SR_STATUS           GENMASK(3, 2)   /* controller status */
  #define I2C_SR_CAUSE            GENMASK(6, 4)   /* Abort cause */
  #define I2C_SR_TYPE             GENMASK(8, 7)   /* Receive type */
  #define I2C_SR_LENGTH           GENMASK(19, 9)  /* Transfer length */

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/all/CAHk-=whoOUsqPKb7OQwhQf9H_3=5sXGPJrDbfQfwLB3Bi13tcQ@mail.gmail.com/
Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 include/linux/bits.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index a40cc861b3a7..c7c587e90e2d 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -57,6 +57,9 @@
 #define GENMASK_U64(h, l)	GENMASK_TYPE(u64, h, l)
 #define GENMASK_U128(h, l)	GENMASK_TYPE(u128, h, l)
 
+#define BITS(l, h)		GENMASK(h, l)
+#define BITS_ULL(l, h)		GENMASK_ULL(h, l)
+
 /*
  * Fixed-type variants of BIT(), with additional checks like GENMASK_TYPE(). The
  * following examples generate compiler warnings due to -Wshift-count-overflow:
-- 
2.43.0


