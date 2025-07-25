Return-Path: <linux-kernel+bounces-746052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04919B1226C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4447D1CC7F50
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436A42EF9B4;
	Fri, 25 Jul 2025 16:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="cfWfGWUN"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0925E2EF656
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 16:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753462625; cv=none; b=rcLS5OYgd3Wvq95YOD0Za4ku+Mlh7OwhVQlKa3CjoNZrLXSDK/3t8uQ4ALia1XkP5b45Ki1C9FDtGG3oZOGG7b6a3I8MB/xLKEvZL2H4+Fgik6VojNebfByf6SdKMMGz/gbEH9nb6sGtztlVm5EhZuHfOhTyj2WOZs9NZaUDGaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753462625; c=relaxed/simple;
	bh=WTVgwj0NqIM1mwrJwTCHrv0cVZbvjmz1jy2rjbVpIak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FpMX+Cra0m/VXswgzz9H9sx0Pfke0ukb6Wv0KHzIc32iZ5CUqfR+0+8vBJz3n3zFI7C0ZsASp1ke9ZCm7S8WtFUdQ1pjh7vnT5J9ngNtsA9mzETXbHLVSxL/InYSpb4ieveF8mrGofyIGBUIHN+wTeG6U3kVyLkUj1KwoR0Sx5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=cfWfGWUN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45611d82f2eso1185515e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1753462622; x=1754067422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nu92pVnSGWyGOs+NZnSegiv1w6Yea+eMpYHDq7DsV5Y=;
        b=cfWfGWUNSXG4PBgwbOlFxzs1mSVkaQcosATqwcCYkuRrDWGb802lZsQD+X1VukxNrU
         BgP0Y3vnf40QbQa13mkwO4/NME+/KCvnqxPM4Z2ouC6OmYCYiO2JNbPJs0iRs0TZ6NtS
         80Q/EjgT7lyZaQkiyz9CoMqj5dv5+VfnBb4EZA0asWyhjqadVM1WAvqHXdbpDZnPa8R7
         WbzHwzNdTvO7zaQSSsWDTyl6vVTlLhdINO0+ad41mpESqyDruq0UyCRfA0vXfbNP2vP7
         PUB5xP5MeSSao5QfzDJIV1Q5wbqqgX+FwqyTeZtP1eSpadeurl81q6Iu5Mygk9IkM2yT
         FskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753462622; x=1754067422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nu92pVnSGWyGOs+NZnSegiv1w6Yea+eMpYHDq7DsV5Y=;
        b=SzdtnrSjVNbmbUwpseXK/l53FDUkIZreWYqRjC9VserEvgIR4o11JDKyO591wq2RQ8
         bb1W1Dd7w1BRcPeKbifirxTtI8Qj3EMNqYfDyLPAJocHS7Ys3o/mjWMN3DNSYL+R7Uwq
         pO8h64lq+a+KUcXSYzelBnSKXxsiYBpyJfMVEIJSq/ccjlyVmb7pF+Zk6miHr2hb6OQ4
         t1tFQu/BVg39w0x8VE536JtQQ+SvM/EmQB+j2hZWlq54MhcPsAxGjKN4Mr/YS32O7zZm
         BIIcFz+LrwySEJkpitQekGski1DneO0eGWo+gk5QOkEpvAeB3X7iV27bgMwnkcrhvoHz
         jZVg==
X-Gm-Message-State: AOJu0YyaPvvzHbtNHI869hkhjsBfVm5luM+W2U/+znIAxJ63KJiHE/Nr
	EcyzzVIhuMHLbG3V98tQHz3Wl8uvkc6lLigoybmtj8XU6LmSnyt6i8J392Op4VheDSY=
X-Gm-Gg: ASbGncskFCduJvkZkeH+h8dgRvn3iBVpEOAZo5qfw/aUWJGvkYHAdxWgyweDOaLD8cT
	wcLUEeefBjg7JuPSH2UREVj3l6n6Pwvydm3eYMqB9qwT///TN9o2dwodlRehYlpc2IgDynVhU82
	vVx0Zgnd/S0/yMdcGJJM0k7p2JU9mEE9/1N2179FB7xX9QwFFVAnmRIkjsaBcHXOG2hlxdCRvhI
	jRa60p9XGeYPQdxL1YojObc9vvyE/Po9bb+e3sBh+p0/VCGjxXBbeg3zHMO83MZdlvis8Rxd6dd
	yX5PVr3YEbehagvDIzgW9LPv0NHM45Y4kb4G8o5jqG1A1NukYjW1nIs/LG4hjFHlnVbdu9F+Wtt
	vLOuhJ0MuqDAUCoorJqnJUlZZ4BOk7w==
X-Google-Smtp-Source: AGHT+IGLDnI7S2DxdD4vV12toUgj+4yMXj/sNb0KZhkdWDQvG5ZTMV5h/+RVkNNZKk1RId3rYnFmdQ==
X-Received: by 2002:a05:600c:3507:b0:456:4bb5:c956 with SMTP id 5b1f17b1804b1-458766c1d21mr10060865e9.7.1753462622148;
        Fri, 25 Jul 2025 09:57:02 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:8c15:2281:5347:b367])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b778ec36bcsm380333f8f.37.2025.07.25.09.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 09:57:01 -0700 (PDT)
From: =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
To: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Deepak Gupta <debug@rivosinc.com>,
	stable@vger.kernel.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 2/4] riscv: use lw when reading int cpu in asm_per_cpu
Date: Fri, 25 Jul 2025 18:54:10 +0200
Message-ID: <20250725165410.2896641-5-rkrcmar@ventanamicro.com>
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

REG_L is wrong, because thread_info.cpu is 32-bit, not xlen-bit wide.
The struct currently has a hole after cpu, so little endian accesses
seemed fine.

Fixes: be97d0db5f44 ("riscv: VMAP_STACK overflow detection thread-safe")
Cc: <stable@vger.kernel.org>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Radim Krčmář <rkrcmar@ventanamicro.com>
---
v2: split for stable [Alex]
---
 arch/riscv/include/asm/asm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
index a8a2af6dfe9d..2a16e88e13de 100644
--- a/arch/riscv/include/asm/asm.h
+++ b/arch/riscv/include/asm/asm.h
@@ -91,7 +91,7 @@
 #endif
 
 .macro asm_per_cpu dst sym tmp
-	REG_L \tmp, TASK_TI_CPU_NUM(tp)
+	lw    \tmp, TASK_TI_CPU_NUM(tp)
 	slli  \tmp, \tmp, PER_CPU_OFFSET_SHIFT
 	la    \dst, __per_cpu_offset
 	add   \dst, \dst, \tmp
-- 
2.50.0


