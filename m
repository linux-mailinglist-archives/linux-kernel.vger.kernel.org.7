Return-Path: <linux-kernel+bounces-870036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C7DC09C02
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 18:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E481A3B0A47
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66AD30F541;
	Sat, 25 Oct 2025 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkSaTt1O"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B954730EF84
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410012; cv=none; b=QqnTh98w0DD5IPWplLR3aWXgxPXTjkAZaPAITqcmhfdUqzY4HNro/KJOxvG9SBJEDtiKVfwE/ivv/MPE5pa63lxyhnVLdTYis81kpBmjG97cbdvTvuKtjLPafDgcCLZdJCEQl4uzNjEoYv4mxs212wvJgQg8tfyulr6UxPBUTPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410012; c=relaxed/simple;
	bh=+b2D4vP+c+kh3wd/DS3NcNXJ9L+1kZpJcsBrgvelyh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I757kh3oLKI8bo4bZJUaldPWQa3SWeWj22kU3+bwkWwCBAyMSiJL99NQHgTLknysOjf/kyJqgTU2FhyaXpNRcui0gOxPoDCcF7RcrPUuuKF68QyV3jybS4grcXgrcJrd0MjSnkoCXY2i1rodypL/fuL7JnsrF9vKwSZVOjK4+jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkSaTt1O; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-89ead335934so136257085a.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410010; x=1762014810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSGBaOZhD7YMIGtASkoY94KR31YSs6yG4R1SCYeYD08=;
        b=bkSaTt1O/+sEEm8n2rHDZlpIfOLlmrQHzBf67p259dd56VJunDvQhn4WlX/J1aIkF4
         b6gLzl8vPHpFV5WhijlPePIxcEPJ8H2/b0ijo4LsJMOupOdmGnUgYtqr9QUPlUwBC8vo
         VNpmazjXF+g9cD9MSFzXIMQcj0lhpCTUMOP73et5Qrqib3a5pLXb4nRxsWHAOYOJ2xC3
         uwusAUbz4jVGYeRLyq+LUHL1N3qFDEjuM9pgn7XtCL2X1OhEPij/9jmDnGCIUvcdBeJT
         fsTloWNt/6Fq5GnJ1DZAbcUe7Pt11m8Py8HIDFVpaH3YNUPns0pDJwLQ6U71DkNl6asM
         V61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410010; x=1762014810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSGBaOZhD7YMIGtASkoY94KR31YSs6yG4R1SCYeYD08=;
        b=T4KgJ7nTv6Qf8JkkF/DAj/mkIqTJb4FO7lqUavSPVcX/oCMElZLb8KEuZaVHq83toV
         YCdXSPEpm4k2HInPALs5j/sWkpMqXOvHSd1Cc57AeZdYyt/+iKtDRSTXEm25+8dPuyUW
         m83Qc9kbTCW04/hsrQA9ptjJTs5rZi5jxmIrvH12N86Enk2Tka7r+P5rSC752sRUBNiP
         QodbOL6NR+Y23hWhD8rcDdYaCNAX06C1gJBjHVPBqv11Y256CrIys0KV6b7HONOjPwm+
         M0UHhryfddiflPGwT1eyXYdy1q2h2KZkjEalwU2/NrxSdI5vYwRkfg4FGfpHxNUsILAB
         N5DQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZhtOIn3RQu0uc15vw+1RKcRY5VEiCyGJliPDmYmlP004WSRTXXyxGxgDJbTMkft5X6lD3dcDSGav0APc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYEoLqYEx7vQ+xxI72PdhRehvs21q0XjbAJ9VVErgH4PrZJxaQ
	PQ0wyqlFfbeaGNEysdAubn5vDCFgLDW8Ttf+DnD8WqrN9y/fHQAQuNiM
X-Gm-Gg: ASbGnctS07ar5tKe8vT+0zyaL4RyFwo3KxUZxd50xIUBRjRHhD5fc1DhYReKcf7PEkS
	dnGEJta4f5dKQRN3gxioePqCwbUs1aIUYwLIRK5f42RnqJtKbd6bYHSWT8a2DZJqXw96BbKKipw
	bPOSNWYnERsNi/UsPWl0+t/067dPpupXVAzFHUwETT1Qh/Zj7AAUQ6u3NNW8SgK54NiBDxzASUH
	v0bq8L+Mkf9jiEAZ82RVA6lr5gPW9o1TKOOcWRkF/PSQr41VhekjD9J98SRRWH6Og58xVLLRkJU
	6kctdqRBwXfohcoI1fjCzNqPuG5ahK2D9KqP1B9fc8C+xiJ/kcvRRju/NuT1kGd3npybNAkxeeB
	P5wtbmLFIm3ui1KxH7hUFx6fK1rViXW6KHTv4d/fio00EKNGslqhRYO8t/xFOZO+pUplkU7FN4n
	hucJSAWCY=
X-Google-Smtp-Source: AGHT+IEwse5jmtf5o3/IBBOm0kKgX0Hal7s087GbKSjPCM9MuS1VqssBnXXTT034Qa8iz97Crbuo3g==
X-Received: by 2002:a05:6214:e4c:b0:87d:fef8:6155 with SMTP id 6a1803df08f44-87f9eeac1bfmr115745596d6.52.1761410009628;
        Sat, 25 Oct 2025 09:33:29 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc48f64aasm16321246d6.27.2025.10.25.09.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:33:28 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Lee Jones <lee@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	kasan-dev@googlegroups.com
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: [PATCH 16/21] kcsan: don't use GENMASK()
Date: Sat, 25 Oct 2025 12:32:58 -0400
Message-ID: <20251025163305.306787-9-yury.norov@gmail.com>
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

GENMASK(high, low) notation is confusing. Use BITS(low, high) and
FIRST_BITS() where appropriate.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 kernel/kcsan/encoding.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kcsan/encoding.h b/kernel/kcsan/encoding.h
index 170a2bb22f53..3a4cb7b354e3 100644
--- a/kernel/kcsan/encoding.h
+++ b/kernel/kcsan/encoding.h
@@ -44,8 +44,8 @@
 
 /* Bitmasks for the encoded watchpoint access information. */
 #define WATCHPOINT_WRITE_MASK	BIT(BITS_PER_LONG-1)
-#define WATCHPOINT_SIZE_MASK	GENMASK(BITS_PER_LONG-2, WATCHPOINT_ADDR_BITS)
-#define WATCHPOINT_ADDR_MASK	GENMASK(WATCHPOINT_ADDR_BITS-1, 0)
+#define WATCHPOINT_ADDR_MASK	FIRST_BITS(WATCHPOINT_ADDR_BITS)
+#define WATCHPOINT_SIZE_MASK	BITS(WATCHPOINT_ADDR_BITS, BITS_PER_LONG-2)
 static_assert(WATCHPOINT_ADDR_MASK == (1UL << WATCHPOINT_ADDR_BITS) - 1);
 static_assert((WATCHPOINT_WRITE_MASK ^ WATCHPOINT_SIZE_MASK ^ WATCHPOINT_ADDR_MASK) == ~0UL);
 
-- 
2.43.0


