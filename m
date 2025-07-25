Return-Path: <linux-kernel+bounces-746054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67391B1226F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 559311CC8437
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E962EF65B;
	Fri, 25 Jul 2025 16:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="QIIxXApt"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE9C2EFD83
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 16:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753462629; cv=none; b=BmW1FypDF55xHBylIxzfM70ubyzJsBaum2ehIKyWULzEEa8oYbgaQ6w7qE/QF/egnTuO1C0WjAfJ3svpVxyOuGEGHec2oHugG0hD6J8oBKpk3AtsMUX0uSVRsV/w/4LLYYv1kap6Cn3hlr/3IInGMtfbvLcU9xgJguSfPhJK0io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753462629; c=relaxed/simple;
	bh=qTiIINMyX04W+9VybjOH0up8SV0plzT94dTsZI6J1WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RzqyZC8Obgg2deQ4kqxG92Qdqjr/OZw8r4lSHhjJIKyGHao7vs4/lqzaxfc7bt+9A6eVIwpAPLOT6aDNC0iIBiGXUt//ACn27sTw6bOQ9EHGSz9LRsUkzuw/ol8uAH1wfmQGkuYhLQV5Yc9LAVOFeDlx6jXTrujxRD9VGoWD/rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=QIIxXApt; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b39c46e1cfso225888f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1753462625; x=1754067425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9VbmyL9+QKF1DzbApD0b7/eOk9XKkaVSIcHPDqQ4hw=;
        b=QIIxXApt8+Nm6AA2Dxqq4Pkj7OkOMxJs6tMihZlBuHQ9jQk0hoGx6rTkZco1U3+zo3
         m4Ccy2iqa2Fg3UnbwAt6P62LnH2KMAzUj5HSnqeTIiWp25Mf1GbT8QvwQBEVvVfSHc9Y
         EqshTSbEEbIRM4yP+xrchxYxo37TEAW80bsAOkdxEfbeqbl8FCdj9GnukTTVbRUhvK2v
         CW+54zQaOTWqmAERlrrPdJ3vnsQl+eJKHCM5P74BsWxRQmqHB6YQzboQGhcL7vWOyClj
         YMoTbah3LYmGuFQIHR+1tZyIlC6U43zQhO+XoNHk92ZLHUvCLeoVFHmB8RPaC/0KV6RD
         ia+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753462625; x=1754067425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9VbmyL9+QKF1DzbApD0b7/eOk9XKkaVSIcHPDqQ4hw=;
        b=aNml7+lTCCDQ57v9+IHDRjrEdmkrUQbfbwX9cLpFBW0prvNJoNx2YrB56qpfSykF+9
         aY0u9+h63FNiIOR940JwIuGx99VMPelY2W21GVlqNrcn/twXsNtQbmcpLAWuuDZe/HG2
         THbuNj/WzNwc8xT5RCB1Dl1aCzfJFs2J3ZCEeHn4xA+arTA7za8vYX/adwtEknWGmUME
         oJ0rHQFGy9yUNR7ET7W7Lkh2h3x3zhwpBEfK6S0HrtYTJRO7zN8rYgr0A06jE6G66GS5
         6xfNFgS+qFMvUZrxxNBgSOkmIBfH7btQ5ra9CnCMZqTyn3DKC+TQjiPiGCaxiLMjzEwM
         i3iA==
X-Gm-Message-State: AOJu0YwhJ8yIRQO0DnzQvaEG2waXT9iODjBJjvuABak6As7yNzqyfxXC
	UtXXr5vm2XPnNYxDtTk0NkQ4NewDd4Zi+SxGBHwKPiSc9Q5qDA7OegsraplBc0EKpas=
X-Gm-Gg: ASbGncuRWYjjxuMyecD2b1lECg2Cnjnwmiq0KCKSD56RPbgPX13i90hb43f4rRWnUAa
	CoLxqFyMRiwuQnpPfLo2XK6elCdfeLhCIWNCkJuOYk9rC9c29+Q3XLGbBsDqYuqbfLwU10KZcoe
	tpzSJYlhXubP8iWkRn/QJj65ZyVBLEo2bvJ6yxNFXfBUxyIxA2JV0sJAL+tzIthButJdF30pSkO
	U/wxtPXsG53nwM1nahzodNVwanSxXlMi5QQY1fGXazbIlLB1m8uxwM1C00L5S2Omp6/sWUxax5x
	u42er8dh7dg+qmVsdyhJKAhRgvbFtMIBShmtdLD/ynoLlGoH8+4t/uPK7FNm4VPn8DUPS0BozAT
	uJDKGzpGtPVYoM8WzVirlhHRwacjOlA==
X-Google-Smtp-Source: AGHT+IEMmcOAJ8Lb2clpW964OZEOhXcOXMNAGas/lQJJNkqbVlKpOBWjApdb/lzcNbu6yqPgzK3kgg==
X-Received: by 2002:a05:6000:4284:b0:3a5:2dae:970f with SMTP id ffacd0b85a97d-3b776758780mr982964f8f.13.1753462624497;
        Fri, 25 Jul 2025 09:57:04 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:8c15:2281:5347:b367])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b778f1e87dsm361748f8f.72.2025.07.25.09.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 09:57:03 -0700 (PDT)
From: =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
To: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Deepak Gupta <debug@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 4/4] riscv: pack rv64 thread_info better
Date: Fri, 25 Jul 2025 18:54:12 +0200
Message-ID: <20250725165410.2896641-7-rkrcmar@ventanamicro.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250725165410.2896641-3-rkrcmar@ventanamicro.com>
References: <20250725165410.2896641-3-rkrcmar@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On rv64, preempt_count and cpu were both 32-bit followed by 64-bit, so
placing one in the hole saves 8 bytes in the struct.

Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Radim Krčmář <rkrcmar@ventanamicro.com>
---
v2: tested and reviewed by Alex
---
 arch/riscv/include/asm/thread_info.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index f5916a70879a..c267d6bd838e 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -53,6 +53,7 @@
 struct thread_info {
 	unsigned long		flags;		/* low level flags */
 	int                     preempt_count;  /* 0=>preemptible, <0=>BUG */
+	int			cpu;
 	/*
 	 * These stack pointers are overwritten on every system call or
 	 * exception.  SP is also saved to the stack it can be recovered when
@@ -60,7 +61,6 @@ struct thread_info {
 	 */
 	long			kernel_sp;	/* Kernel stack pointer */
 	long			user_sp;	/* User stack pointer */
-	int			cpu;
 	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
 #ifdef CONFIG_SHADOW_CALL_STACK
 	void			*scs_base;
-- 
2.50.0


