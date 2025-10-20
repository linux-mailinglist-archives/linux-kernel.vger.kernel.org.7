Return-Path: <linux-kernel+bounces-860078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED86BEF445
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 06:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF1984EC716
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 04:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705202C11F1;
	Mon, 20 Oct 2025 04:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Stmy11bH"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4BC2BFC73
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760934338; cv=none; b=V95NTc+6fw4YCmzwfowpQsCmsVhU3Whp7vpPoCPYET7kfgTi+TL5vxq/D0Qo2iBAW6RCkzvbMYf9YWgM3QEJtsfh5NVZ2x8HA+CYI6zAS3d6JGrCNLojsvPge45xv3bYoCiu6grKHgNREhGtpSd1rvXHexO5Sr9ZYCe0vIzj4Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760934338; c=relaxed/simple;
	bh=8hNEznhKZts7nsJ+/Md1hqEm+KtJGCPHkBh501JLIEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OGOYRFaKzBrIQI2YlDux8XTGpjNCTuitPW9tShhLrPJVG7AUl/41K9PfvgjAng0giyMxT/wY0RJbJtyukqEBEPIcaadv22z3PvO6kWOCwCXyLPV8Ta8uMtgwn116UCvcq5YSiIaJ2S5TANPP65Ox72r4pRzwYPqOQyaslQHtFqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Stmy11bH; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b6a7d3040efso956221a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 21:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760934336; x=1761539136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Dx3bjUZwp+FDi5HGHRvFmbVTrXXeKiS0FzRK/EiFHI=;
        b=Stmy11bHlbtB+FCDM3N72lvFypHEqmDaCdkIBk4dvYHEXWSYbZjkmUaCLg9ibvm+aV
         +tBJT7JrQ+OWBwWUW+V7RvOPp7+dBAKV9NtfQCMefduyrAondxZDckMqpCFrzKHIX6Fa
         uYy2RuZQUJsWzih7+a77KtJvu2TlZlWNKSXR8xpia4RXDKdAQc6Vuq4YCd9jrz/4qsg4
         /tQUIb+B/uSJuNcuwZTTmuYjteul+9jOPHrFQ47XSAviBXnD1RnSYeL7mcohffacyoeN
         Y6lEFIunSYFtAh3whVE20Pzbi31sbVNEbffHHXiEMGYPXfck/E81aYv+N7roEMHMPPo7
         oViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760934336; x=1761539136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Dx3bjUZwp+FDi5HGHRvFmbVTrXXeKiS0FzRK/EiFHI=;
        b=vKI+QK6Ux8L+naS2jd1UHbsu2bEj438qlptddGGQto7iiaNS8nT7ySN4Hub385abYE
         CTSOeD1ib2SlvoQqEmas9jyJjkG7XUjf2SC319m7Tu/78a0dTbjSw8+nAr/AB3LgC0SJ
         J19ktmDrPAU/zUOVW9aYCVTrwm6VF6qwzqFGq9Y2oyD6gCufGhpS62wViYIDkZmrSKOt
         9edTGUAqauc6rGA3kyIRtktvSv9bJSI9pUv351xzHt3fbs1tw5fT7OZqzkI0i4KUGOi/
         7DJS+kcA0Dz2jC5K9Z4eAz3gxhKmHqs9LyaLoqKSNXdXI5FeUIRLuINKr744nQ7sQxTn
         TmDA==
X-Forwarded-Encrypted: i=1; AJvYcCV8qjUrkcyhluIPZq/C8NlxXR/0jMqZ9/gxULVJB60waoiWlHjin08YKyJx5aAFoDiXebbGWsGoxwBJzuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC+BtZYfAWQrOPhxIpuzTHEVaAqoMmUWUciPf6gkYjc+q8zy2n
	fvRFIOy0GnNXiaSoOTTC6JVws74Gkr0TgxvWsAyRTAbh8H3bd2H2944eZmBQzt6H/so=
X-Gm-Gg: ASbGncsCcYIjlcPYATuYMGTMvMPDaZ1jlWLwxFlNcpalc0rHLkP+KT5/TEeBZgWwUxP
	D9s9/vvwOXfK1evGeOvQK5UmYGih2/sWFjFY70JKVkCvApY9uXaRL026MB+kPdwWeYmxG2jW/+F
	jZ59ou+DMR8KkrV0zk57/k/2Tllc2jJpeRq0XDK29vuyle9z6gHpnF1h/4fcD6+KlYBXCMJ/ky/
	W/GMelnPHsN4KhUSRmMDTYM2KHU91YS+y08t4ddvHt+fM98tvpsNfobJZFYEpyj/KLaUT6WKmSn
	7Z2rSJrYpp5jGp1K5VSx5ZTAuiefvjUxksSr0GqstmZRQ0VG20y0Vp+89okFKanFmcqBDZgzphW
	ZVhmA0xWFd0OdwW6gB/Jjz437NvCujCzgTJl4c8WovdhbZ1ZAlFZ4+54xikENYmlC0zpzVFKl/f
	YTPd9ThhWQra6+hhBPJOoxLHr4g9LNcpxCIZAzK+57rppdRTcCxo6r5qsDB3HBXhU=
X-Google-Smtp-Source: AGHT+IHd1kF3POpTVpfQwriGdz/AzJEchqY/kwdyjm7t3VNt+rro2wzxG/dmQOsLktQwlvjqL1Trmw==
X-Received: by 2002:a17:903:b48:b0:290:29ba:340f with SMTP id d9443c01a7336-290cb17c05fmr150708105ad.42.1760934336328;
        Sun, 19 Oct 2025 21:25:36 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ec20a4sm68319325ad.7.2025.10.19.21.25.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Oct 2025 21:25:36 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: corbet@lwn.net,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	will@kernel.org,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	mark.rutland@arm.com,
	anup@brainfault.org,
	atish.patra@linux.dev,
	pbonzini@redhat.com,
	shuah@kernel.org,
	parri.andrea@gmail.com,
	ajones@ventanamicro.com,
	brs@rivosinc.com,
	guoren@kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	apw@canonical.com,
	joe@perches.com,
	lukas.bulwahn@gmail.com,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH v4 08/10] riscv: Remove arch specific __atomic_acquire/release_fence
Date: Mon, 20 Oct 2025 12:24:55 +0800
Message-ID: <20251020042457.30915-4-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251020042457.30915-1-luxu.kernel@bytedance.com>
References: <20251020042457.30915-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove arch specific __atomic_acquire/release_fence() operations since
they use fence instruction to simulate acquire/release order and can not
work well with real acquire/release instructions.

The default generic __atomic_acuire/release_fence() now provide sequential
order via 'fennce rw, rw'. They are rarely called since we use real
acquire/release instructions in most of times.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/atomic.h | 6 ------
 arch/riscv/include/asm/fence.h  | 4 ----
 2 files changed, 10 deletions(-)

diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index 86291de07de62..6ed50a283bf8b 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -18,12 +18,6 @@
 
 #include <asm/cmpxchg.h>
 
-#define __atomic_acquire_fence()					\
-	__asm__ __volatile__(RISCV_ACQUIRE_BARRIER "" ::: "memory")
-
-#define __atomic_release_fence()					\
-	__asm__ __volatile__(RISCV_RELEASE_BARRIER "" ::: "memory");
-
 static __always_inline int arch_atomic_read(const atomic_t *v)
 {
 	return READ_ONCE(v->counter);
diff --git a/arch/riscv/include/asm/fence.h b/arch/riscv/include/asm/fence.h
index 182db7930edc2..9ce83e4793948 100644
--- a/arch/riscv/include/asm/fence.h
+++ b/arch/riscv/include/asm/fence.h
@@ -7,12 +7,8 @@
 	({ __asm__ __volatile__ (RISCV_FENCE_ASM(p, s) : : : "memory"); })
 
 #ifdef CONFIG_SMP
-#define RISCV_ACQUIRE_BARRIER		RISCV_FENCE_ASM(r, rw)
-#define RISCV_RELEASE_BARRIER		RISCV_FENCE_ASM(rw, w)
 #define RISCV_FULL_BARRIER		RISCV_FENCE_ASM(rw, rw)
 #else
-#define RISCV_ACQUIRE_BARRIER
-#define RISCV_RELEASE_BARRIER
 #define RISCV_FULL_BARRIER
 #endif
 
-- 
2.20.1


