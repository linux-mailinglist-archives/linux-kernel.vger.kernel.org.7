Return-Path: <linux-kernel+bounces-825964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF80B8D38C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 04:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 500EF7B43EF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 02:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976081EA7CC;
	Sun, 21 Sep 2025 02:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyk/sTMN"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2D7B672
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 02:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758421659; cv=none; b=aGcsF3AXymLbGk19OkmyhBYcf+eggCeZ/svcFB8Ap9MU19JOuopl/5qCW3s0cD99e0DkHa1gQkVve/BFmodWEJKw2UQzcxgwObO4rfrSs440/GsyfJGOjtA53XKHaFxaM74f/0k2LWHvW/fxpcyN0hhVCTSBHGKNe5pGB5Iku/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758421659; c=relaxed/simple;
	bh=bKqbRm7uliKj0cw6LivI1hJQpLFbhELQ9JH5kKq/xwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eoprsdhkrh5nixomR/9ky3mtq2YmdFANQrNvzRBigYhxi2oIJ/TwWqdObg6E9QTIlTLphYJzj1bC2d9AsM2oZAfJiOpEM15R+CIn+m0R/zlhc+tzMrrFslkgn2bhXUGfALq6V2qGfUDJv854VysSMvSkvLS6JBqKYM+XVEVvfDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyk/sTMN; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb78ead12so490374966b.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 19:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758421656; x=1759026456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rP56KXKGrYKQHSd4lR6UJmMGSUbVk/cXV4sww30Y9W4=;
        b=jyk/sTMNvikroHyJqYf8hE03D+D7/tF9AObVX1hXTnLMo5FiMRt31BcdDffs1DyRYJ
         0esagazzKPOA9dQOu2xf1tNnGaZSIZIjlnkV4MZ7glyPaDe2anTR0botk8XHnrY3vUOq
         0oczARN4MERkR9u0OwIGsl0pdcTbhjUS+rULv/KSCoLXBHPot+Iuu6hLZXLw8PioLQLn
         PBnCFyZCCoVVrpxlnHAj009+CqaYkXmsYAFsZp8S05ZXwZnG+8O41/CgbCvi6VWR0LxU
         5k7UbonGlWoQ//4bWV+qPfhiy7SWFBFaISZljETX9cT3vBIhbYYlXKdYRe9KBblYn9SS
         JGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758421656; x=1759026456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rP56KXKGrYKQHSd4lR6UJmMGSUbVk/cXV4sww30Y9W4=;
        b=bpfHYLYrmyaPyIXtGVUmg8lpLCDcPDWkeGpm1GgWEDEvB26UltzCARlGlpeX47m8rC
         zIhz/OFV8g0b+2WGYiKhgzGYerjpkXIUPO+mqc4r9i55Mt9w8x6KzQoj0QjWEtA5b3EH
         tco98nH0KV6v4uAwEV5AUS0rN7w74XNQ5elRB+eJhxAO+9Ts6Pwlr+Jlr5EQxAOHMx7o
         iTPgRqxz0nfvCF5XAd8o5FA1a448w+F2YJF5g3JTbnpxunO5NJRVnRrZEr7o6dkVh/17
         l8Fozjo+D+8dMR9o9kH7EckbGs5aM8is28pLkHKR2IiFNkFoJkdyTs4jxUcTFHRyARA9
         T27g==
X-Forwarded-Encrypted: i=1; AJvYcCU2g41u0VQ4EcabPxqUCdGhuJ+e7YjHmYW9xu34nLA/urxd/I9FWrZdbXAucA1jXTy8GvqrnQZ5zxenG9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT+WMfPQyM+gmXw2ooXW0slPwPPJgJnYZiL88zMoV583q6+mbb
	Tdg9K37CimVlBTwOSH2QM+pt4inukWWJIUEmnGrTrtiKWhZ2Y7u36L0d
X-Gm-Gg: ASbGncsKme/Fq5Hrm9vafCyypAhgKKmuJPVy0L+kwKNYNg8B9Sk7wZg1VCdvIZjLZ/P
	SAeFmNREqlIrPuSt0FaT0zmlAkDknzQD7Fn6bxzV3/VnfalfxgJlEX4BoxbgYQIVp+OnSCl0tAK
	Lg0rROuxNXfe4E4O6XfACNUQK0y5e+CcqhFTXhDF7O8JPVNQB9gi4Mq/hSZ6UmYDi4QvoNvGJy6
	G2ytUFoKq7SGfbc6DLt/fTttGKP7iczAkg2tMNBZY5qtFJC68eTyfw4hLaz8yAp09rrIl01MZ4z
	2LFApNzZEMfXPp3UMXWkdvI21V6p9wpaHd8Jjbu2HcqrEaHQcZqS105zFHmC12jG8lE2Kv4mFBe
	XSJDabhnOJVdPvg/EKkPsrfzTd2zseaUPaxFMhwtk5HdhJjRhYHka/JrdSAO2vqSoQA==
X-Google-Smtp-Source: AGHT+IHiXmiw3L7eWOCC4ObaGkYcVv5rY+RDNbXFTwGxaS2TznMkzaolvLUgRBq0kXBjPI6DHDvPAw==
X-Received: by 2002:a17:907:7211:b0:b04:b981:8823 with SMTP id a640c23a62f3a-b24ee317eb3mr972788266b.4.1758421656279;
        Sat, 20 Sep 2025 19:27:36 -0700 (PDT)
Received: from localhost.localdomain ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2636394e32sm448658866b.16.2025.09.20.19.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 19:27:35 -0700 (PDT)
From: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	saakashkumar@marvell.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	"Nikola Z. Ivanov" <zlatistiv@gmail.com>
Subject: [PATCH net] net/xfrm: Refuse to allocate xfrm_state with SPI value 0
Date: Sun, 21 Sep 2025 05:27:01 +0300
Message-ID: <20250921022701.530305-1-zlatistiv@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reported by syzkaller: "KASAN: slab-use-after-free Read in xfrm_alloc_spi"

Before commit 94f39804d891 ("xfrm: Duplicate SPI Handling")
xfrm_alloc_spi would report spi=0 as unavailable.
Add this behaviour back by adding 1 to the "low" value when it is passed as 0.
Allocating xfrm_state with spi=0 leads to UAF or CPU stall.

Fixes: 94f39804d891 ("xfrm: Duplicate SPI Handling")
Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
---
This should probably be sanitized in verify_spi_info
but doing so will change the interface.

The bug is easily reploducible by issuing some iproute commands:

root@syzkaller:~# ip xfrm state allocspi mode tunnel proto esp src 192.168.1.100 dst 192.168.1.200 min 0 max 3
src 192.168.1.100 dst 192.168.1.200
        proto esp spi 0x00000001 reqid 0 mode tunnel
        replay-window 0
        anti-replay context: seq 0x0, oseq 0x0, bitmap 0x00000000
        sel src 192.168.1.100/32 dst 192.168.1.200/32
root@syzkaller:~# ip xfrm state allocspi mode tunnel proto esp src 192.168.1.100 dst 192.168.1.200 min 0 max 3
src 192.168.1.100 dst 192.168.1.200
        proto esp spi 0x00000000 reqid 0 mode tunnel
        replay-window 0
        anti-replay context: seq 0x0, oseq 0x0, bitmap 0x00000000
        sel src 192.168.1.100/32 dst 192.168.1.200/32
root@syzkaller:~# ip xfrm state allocspi mode tunnel proto esp src 192.168.1.100 dst 192.168.1.200 min 0 max 3
src 192.168.1.100 dst 192.168.1.200
        proto esp spi 0x00000003 reqid 0 mode tunnel
        replay-window 0
        anti-replay context: seq 0x0, oseq 0x0, bitmap 0x00000000
        sel src 192.168.1.100/32 dst 192.168.1.200/32
root@syzkaller:~# ip xfrm state allocspi mode tunnel proto esp src 192.168.1.100 dst 192.168.1.200 min 0 max 3
[   34.267077] rcu: INFO: rcu_preempt self-detected stall on CPU
[   34.267107] rcu:     1-....: (1 GPs behind) idle=8b84/1/0x4000000000000000 softirq=9934/9935 fqs=5250
[   34.269110] rcu:     (t=21004 jiffies g=5953 q=571 ncpus=2)
[   34.271123] CPU: 1 UID: 0 PID: 296 Comm: ip Not tainted 6.17.0-rc6-00004-ge6f19f124217-dirty #55 PREEMPT(voluntary)
[   34.271123] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-5.fc42 04/01/2014
[   34.271123] RIP: 0010:xfrm_alloc_spi+0x2d5/0xe60

 net/xfrm/xfrm_state.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 78fcbb89cf32..4414346a24d7 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2566,7 +2566,9 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
 	unsigned int h;
 	struct xfrm_state *x0;
 	int err = -ENOENT;
-	u32 range = high - low + 1;
+	if (low == 0)
+		low = 1;
+	u32 range = high + 1 - low;
 	__be32 newspi = 0;
 
 	spin_lock_bh(&x->lock);
-- 
2.51.0


