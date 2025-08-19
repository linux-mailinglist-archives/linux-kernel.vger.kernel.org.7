Return-Path: <linux-kernel+bounces-775014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6E9B2BA4A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582B76245F8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC0E2773FC;
	Tue, 19 Aug 2025 07:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ILI6UCHT"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E07311584
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755587611; cv=none; b=iqH5t5r1rb6j8L+WaIEj895wuD3mkxTMpe5rOpewtN4k84LAbUiOSA+NbZNrb5SSfb7cllb2sLNQVCJ2n4fh8usKQlPSkgBONZCmpeD5SBAnHMKFtRX4ABM0tZDCSdUI1kLqtrCbnE1zClPDhOvv1JINq2egdND6xS0X28BGv/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755587611; c=relaxed/simple;
	bh=3pMFrlDOZ8T8T8r3hLD0YaeAwhJrzB3FJXY+D50rxjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tk4eQzB9IUlyF/m+0SXjuL7e2ffhy6eNM2Pa5abf55p7OOl/XYJM76W61BC4UQHlQJHIB0MDKoYblgBclrnjtTidc1hX3ei+n7FpPkSMEjYYIZmwOY+GIuc0LPWS2tR2TYhjDs5ALMloxadWt88yqxGK2Yo1sMAozGmCzyNcpXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ILI6UCHT; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b47174c3b3fso3068415a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 00:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1755587609; x=1756192409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=54h6HYLCIyFowOQ5k+dd7fW4m0Sq6cnWtzdVWW1yskg=;
        b=ILI6UCHTay75NzCHy40jNiPmsqUTXfK2OPI+bLoFrgKpHMETewvsLAbBYuKPTArUga
         KZ0IIpHtZLjrGKJPY7YBwv8/jPXGqH5qFoJn7paOKdV7aaGI2xv8XKEbp6e9T7xymZSm
         208KFRWdohdsOgI/Mb56wAXG32FFsillMOnfNdPE8T1m7AxjkHruF8UfaaUCaBAD//Sq
         CoTGB6aCkR7X5Px33ZidyzP0rO/wMY8I5AEmpo1b9JoPVA3jJWZbRy2/wLWjZB+RpP86
         TVmDWs/Kgl744ZERDbhhPtunSZWdnDUlHSYiYcZ0fltl+NFWzU1kuicI7vSK9qs9PEdB
         8K9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755587609; x=1756192409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=54h6HYLCIyFowOQ5k+dd7fW4m0Sq6cnWtzdVWW1yskg=;
        b=bCsyE6Gf24NRpq63T69atuo+1HQPrx0wAcpckfiIR4lyLG3tO+C1FiwTkbm+IQmC4S
         9pEXGfqrfdIxPKACRr/jDFOaAXWdT2IEJanOW7mZPpk6wbQXfYijVGzeVrL28gU3RWzj
         QPsHZJVEwyCyVb8A4xeq7+MQXkunwUbRlzeTUr9dAn2tTUVpIqI/kEZLKIwjdrIufeiS
         vuLZi8ZSLU1FqRbabafMJCQvf613MqvxzzYnEMrGE524vrM4jYdvtn4XuVSxuwEVZTBN
         83UHlLqr2bJAsRQqgkbaTlKtZSHjjdaXwQzoSSp8KtW+r7nmnQbYKFxHKjMSgu+zZ3ma
         VZrw==
X-Forwarded-Encrypted: i=1; AJvYcCWoXUIH2Y9nm7C2FImbrvg4msURFFyG4NwUmpIrT6E8lSKrhqLwWsm82kP6tIJBljICeNKKCf6b0Y+5pZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUVu3qS3XijwP6l4btqPUJAdONpvFjK/wtCyCo7GWSjaQTt9yW
	8pVYl10W3JXwoyPl/JWP/9FFmos6j05jRoQlYp/Li3SC1Aob+a3T8AymVwseuZUNY7Q=
X-Gm-Gg: ASbGncvS2lgmFb1nLVwqx4H+KbQanA/R4AynPqbeBszmzTwl5ttRZnpLneGhotZDXQn
	vEoIKQqbTIAeTTicjLbJ3/SmP1xJhukCSjg5obBYciQ8lwM/LBFnu+LbqjyB1/vxBlgOdKrWpEo
	A2Y+3qxN3o41qMDckEGKPgd5gcB10oB2s9xXMfJoTeCWdg7dWbri81eSzh9KDAfkl/OQQ9CDdVM
	3y5OU43W1M/XF9wY/8m4zT8DQAAf4rZV9mJp1wD+Zyl3Pg4Y5GgqEIaU1pB8W/TVAYQoxhva4m2
	e9Qm0gZz5y6WbOYFUHSrE1kxejlR1mIn4WG8gHe/n1StWAOQUKfdUEp8xOpUQfvz3YGHtAqqoxc
	DbKZhuF9zWOyYA+vGiRYnUlqKWig8gE5P7PXx7bpRmWMu6A==
X-Google-Smtp-Source: AGHT+IFgLj8ZUjinADX0iiyxMlpjCRbQuMeIpCjPaYhpGuAKm0Pcum7h2PqqQ0wUNesJ6iACw9jDCg==
X-Received: by 2002:a17:903:22ce:b0:234:f580:a11 with SMTP id d9443c01a7336-245e0309271mr19635405ad.19.1755587608797;
        Tue, 19 Aug 2025 00:13:28 -0700 (PDT)
Received: from hsinchu01.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446cae6213sm100213915ad.44.2025.08.19.00.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 00:13:28 -0700 (PDT)
From: Jimmy Ho <jimmy.ho@sifive.com>
To: linux-riscv@lists.infradead.org
Cc: troy.mitchell@linux.spacemit.com,
	ziyao@disroot.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	cyrilbur@tenstorrent.com,
	cleger@rivosinc.com,
	charlie@rivosinc.com,
	kees@kernel.org,
	ben.dooks@codethink.co.uk,
	jszhang@kernel.org,
	linux-kernel@vger.kernel.org,
	Jimmy Ho <jimmy.ho@sifive.com>
Subject: [PATCH v3] riscv: fix using wrong load type
Date: Tue, 19 Aug 2025 15:13:18 +0800
Message-ID: <20250819071318.21103-1-jimmy.ho@sifive.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

thread_info.cpu field is 32 bits wide,
but is accessed using an XLEN-bit load, which might be 64bit load, fix it

Changes in v3:
- replace space with tab to keep it aligned with code block
- Add "Fixes" tag

Changes in v2:
- add a comment to explain why use lw instead of REG_L.
- correct commit message

Fixes: 503638e0babf3 ("riscv: Stop emitting preventive sfence.vma for new vmalloc mappings")
Signed-off-by: Jimmy Ho <jimmy.ho@sifive.com>
---
 arch/riscv/kernel/entry.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 3a0ec6fd5956..492ae936dccd 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -45,8 +45,10 @@
 	 * Computes:
 	 * a0 = &new_vmalloc[BIT_WORD(cpu)]
 	 * a1 = BIT_MASK(cpu)
+	 * 
+	 * using lw instead of REG_L is because the thread_info.cpu field is 32 bits wide
 	 */
-	REG_L 	a2, TASK_TI_CPU(tp)
+	lw	a2, TASK_TI_CPU(tp)
 	/*
 	 * Compute the new_vmalloc element position:
 	 * (cpu / 64) * 8 = (cpu >> 6) << 3
-- 
2.39.3


