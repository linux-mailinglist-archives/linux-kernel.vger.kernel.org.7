Return-Path: <linux-kernel+bounces-746053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB5EB1226E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A1E24E290A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CEE2EFD86;
	Fri, 25 Jul 2025 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="MljpxHdO"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BA02EF9A6
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 16:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753462626; cv=none; b=pKrMDRQDZ+vvS2v0kCzvA6ISdxsU1iTNqoHkumdncjmDKxHUx75iZzDSwkVa4fsrbk6WBwj1j0bqkAplWCnrKrazZ7+9jKMEssiYBhMRRYfa+0wFwOrvCyzV28CH2J6z6NDu1DQj3jv7BwFrWlw6YBIuuPXm/yxulg4kJ8MzU4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753462626; c=relaxed/simple;
	bh=Vg7gJWGjjXcWUesizlpGiTXzEbuJ3lzYtI572hQW76g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bAzokE6HtzkSGudZt925rksj5NgdLgQ4AUwRcxPoq+UeXWwUDOnLimqQeE8HCQfpV97kbDocR/M52/C3ln2Pth2sNQDE6YxVby5XB1XLl63JLbWycv6Q/S8Q+jxOMNKb4jqrcXhx8nBNGl8+37mx5scZKLLxgussYOxvG+HbUyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=MljpxHdO; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a4f64cdc2dso181189f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1753462623; x=1754067423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXthN36Lo7e4SdP3F/xJxtrDA9Mid3323veomLRgOO0=;
        b=MljpxHdOaWz8/q5EewxQSwv7sLCRJrJIQOGwIhzRALaeQrf3yug6rEIuJIC4sQ46zN
         ATEdaBSKzBCAsOcCGSr0CbBv7v6pl4iw86FZIv0SLzo/zhX0vFjDW4kOxcvQqRwK2dBs
         TXWZEWE6UJmrjtQoiQhVN0T7zpSD7qHgw6lsndxkz5ucRthrQYkpZC51lv/vnK/stQOx
         Ge3q1c1XjDYpfbu+vsaE38b75A8zMxkMjlASCG1rq/6YtL1FRykAPen5VpXLYJ4kqYI6
         /iUyrXBhiEIIABOCebjebklw8FvCxdox586fWe2K6r+mRTHo5uIpfR+2ezNxYLen5yN7
         CDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753462623; x=1754067423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rXthN36Lo7e4SdP3F/xJxtrDA9Mid3323veomLRgOO0=;
        b=sTiX2F3Nzc3Kb6Voh0ioIrWCsIgsP9o4OxHubIzjI0BxRMZ4box05s5T/iGV8drA8D
         22AkxrixKzld8MEFvtRlgf99gWeOYKd3t3qSN45Lb3YV4fUo8BVgihGifXnkU2Ug/vEN
         pYMHjsUcsY4IEWyqgq+tg6GdtAmla2Ker2ZqQ3h/nRRI3wjTE2iKNknAJKO6QDfKNzAu
         xRpaSiEeSMKu/Mx8ARy3M0MEc/asWfG/y53RL8PU5Qp45CLQ4f2sDl/tjWeCI732RDYn
         jJ9AuYT3+zEjvxgkmmMWBr0cDmmNNfg+PXBV7GcMYbcsU3tvjBxa/hykyfL7l13JOg+r
         xk0w==
X-Gm-Message-State: AOJu0Yw4D4XmyEw70pszCORsYZp8evMYQQUlQLI4cFzk6Go8tKjReL4d
	ytstz7LRMvqdzLz6ajw9mH9OHgGFoo/W3TgdqyKicSe0D9ioShwdv7MvByBRInzSssE=
X-Gm-Gg: ASbGncunfkW9WlSDyWrkVGOPCG9/6mc2nt0OVJavrvIhsWGvBx8QaJNA5vQLy7BAAq4
	rgPRMQNbCgp/cbmJOGWtW2bG2hiwLLJlHmX7zJ1vsS5+ua+YG3za00+9ilqDxKHLpan0o02vivK
	i5GCPuCOqWL0ogbsrkATMMJ69Vj7uOpOom6muBNzYmM5fpa+bEhz4Jq3BvSijCsYh3CgamkO72q
	oavuNQW/5ImHWIchDltIQLKy0RBmFG0wcdVEMTHJ73yc7toajH/GgRj78FrGoFKLvvm2ORnGqo8
	ArVGNCI7TYCqRnBAzZfgw83C1BiNCP+dRj1z8szJzW3VDMb6SwpbZR3vzfqcy7Lt7Ol/i74Dn07
	dvWXzguCAUAuclvZ6tHafrX6DtBs+rg==
X-Google-Smtp-Source: AGHT+IGITcuSDw2WS3mGZXN4jojt1rCPjmkMuRkOCVtep1jh4UTndIbn3+VqTiq+4Alwt55pwQeogg==
X-Received: by 2002:a05:6000:22c5:b0:3a5:8abe:a265 with SMTP id ffacd0b85a97d-3b77674fd69mr853133f8f.10.1753462623365;
        Fri, 25 Jul 2025 09:57:03 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:8c15:2281:5347:b367])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-458705bcb61sm58146165e9.20.2025.07.25.09.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 09:57:02 -0700 (PDT)
From: =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
To: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Deepak Gupta <debug@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 3/4] riscv: use TASK_TI_CPU instead of TASK_TI_CPU_NUM
Date: Fri, 25 Jul 2025 18:54:11 +0200
Message-ID: <20250725165410.2896641-6-rkrcmar@ventanamicro.com>
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

The offsets of TASK_TI_CPU and TASK_TI_CPU_NUM are identical, and
TASK_TI_CPU is a better name for thread_info.cpu.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Radim Krčmář <rkrcmar@ventanamicro.com>
---
v2: moved after patches for stable [Alex]
---
 arch/riscv/include/asm/asm.h    | 2 +-
 arch/riscv/kernel/asm-offsets.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
index 2a16e88e13de..93b1e4ce34d1 100644
--- a/arch/riscv/include/asm/asm.h
+++ b/arch/riscv/include/asm/asm.h
@@ -91,7 +91,7 @@
 #endif
 
 .macro asm_per_cpu dst sym tmp
-	lw    \tmp, TASK_TI_CPU_NUM(tp)
+	lw    \tmp, TASK_TI_CPU(tp)
 	slli  \tmp, \tmp, PER_CPU_OFFSET_SHIFT
 	la    \dst, __per_cpu_offset
 	add   \dst, \dst, \tmp
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index 6e8c0d6feae9..49cf2c347485 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -49,7 +49,6 @@ void asm_offsets(void)
 	OFFSET(TASK_TI_A2, task_struct, thread_info.a2);
 #endif
 
-	OFFSET(TASK_TI_CPU_NUM, task_struct, thread_info.cpu);
 	OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
 	OFFSET(TASK_THREAD_F1,  task_struct, thread.fstate.f[1]);
 	OFFSET(TASK_THREAD_F2,  task_struct, thread.fstate.f[2]);
-- 
2.50.0


