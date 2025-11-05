Return-Path: <linux-kernel+bounces-885936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB47C3455A
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 08:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB4021885D34
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 07:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35B82D372E;
	Wed,  5 Nov 2025 07:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fF3LHdFj"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062602550A4
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 07:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762328620; cv=none; b=OeBkObbyHGO5p5xoWoazpwgcH1TPpp8rbSmdH80QE3okKp7am2QkNK3nA4309k44pppsI6JYRPa308AiFrBmqnRmQjH8KNsLbYH3vqIxh6ZJof9nnaBo+nCT7/vfx8RCnqQZMybrvBILOZIUpBqogBF1l/j13nV/FeHwhcJwOd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762328620; c=relaxed/simple;
	bh=F6g9/A3XDIA70+2v7KFfVHx/BGh5EQx+QdUDajZfXlU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZC3KkqUzwYqXIa29mz2E/ZBcMK2u9ETB+SQG4cfDM1DSgWdr2PZVchvMysMu/+3ekqMAwaH2VtGmm56V75MlTCBqLJpI8+rDPk42XTOZ0n/uhn3egDKqs94H/rx9/Z91GiV5tiUj/o4V+OvUK4oQUQErgH7hAcFcNhAj3EcOfBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fF3LHdFj; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-295548467c7so40434825ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 23:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762328618; x=1762933418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BqbaGd3ujMFfuQvly4MTGTSUQZsIXSUIxiFKueQlRMI=;
        b=fF3LHdFj5I9UAcy8mzRRS9npqVjX1RMEL9BbXJvPwW33/QoAuXfQuqFns+pCWxQB9U
         /T9KKEMat15lMFTLMZsIcNiMBpPSw8suSI9h0YcdR7xBLBafyMvGCf/VwoddqmVofWlc
         TdtyynVHzoi3FusF2coK2H2D2SCmKSl3+0FbfmMieXErXDKxRpKLI/xgCkvjxsyPEz8b
         v0rK2jM7KYSpgUjOpM89NPYgbvfSG4zP/OP+tjcdYeIYhHSOAt0qP5Y9Lll+zg3nz7DC
         SXQ7MFNkQntPGtrxd18fevqRrweNeB3GRE3fmzaHdwDrLZXjzgt+u9znkwThhIdq1Gas
         Ay5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762328618; x=1762933418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BqbaGd3ujMFfuQvly4MTGTSUQZsIXSUIxiFKueQlRMI=;
        b=ZFArnScsprsttfYZkwDs+TVDND1+caiv0dK3uTbB7qEHsLMy5y6a0NUe5G5fJDBFKY
         YYe6sNL4xxjPsOkw6PRX8pwFu8B7RWdKi/6FEN5UKClwuO9cNj34Yb4uy47mpuzSGSbb
         ASgTESt2XA7gwGSoRlsmkRmUH1MnsaQtzqOyy0oXDUmzuHURf1cC5JZjuti9aF4BJMZN
         uBsCnpyWbXaQpxUZmrBJPE9HilYhQLnq63b8W7eZzkngxruGFxThH3O38+Ex85RWpgsG
         +DnV3+XjSbuX6vnixmdeurf1Vcmd6ZJSGcjjw1IWl1Q/94XOLisvc7nTv+CtHhug1NHZ
         N+ww==
X-Forwarded-Encrypted: i=1; AJvYcCWni0Mi+xXAM7Nnb26OdwZH2Kj5kp/6L8ONj1eXnYqeHazWjhDS1UEOWq1lrc9Pga4PFpRf+gHRxxut43s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMUm/QQU62U6FoeycikhC5MT9wDNDSHPg13sipLGfx6y8SdnXc
	8AZSPVEDEF0SMOvk1ZNVksXoL9YT019ocu1RdJTBjGp1T69BvPcwrbim
X-Gm-Gg: ASbGncvxaJdpo/vr/RPY4mdmue5DHq7YzHNaj9w9/fh1Orx7NS8pijJQB4+SKma7brE
	YpWaKOqBf7qHtI/bbm6fwqZAUhP0f2mH/pbPBTs2xkgX7QmAEkJWU//RF7ptp5hsN53Nbby5ae1
	sjS7Vg0Xn1Zd7F6bPbAC4qkQDSdy9lzro6afs1xBijD0EmohSoLd0U5IgYpbG6W3Y3p5Lh4nwW4
	ADuv7sALBBLhgorlBWazCsF50SyrW5hL16CeXUgAMIuBJsop8EeDgwUa9KARsRRwD6OtkZdH6DQ
	FwKyMnEKYpKzDr4a1iWFRJcM0VBbY8zZkwW/cwrI0bDu9gOcJmDuPq6rfUaZrCNMOeRAqYv45Ug
	ySaLE3lVqlJU7um0P+9bNF7fRtdSvOkeKhVwMnHwcTyq5QuB2YTm7eKMs3SQvz7o0RCqtLK2kGk
	1hzb/+7Qijb+aA6VaRtA0xTHGx7p8juOzXkeUn1MVjmonjDw==
X-Google-Smtp-Source: AGHT+IEPd474pPje7iLLe9uuqifhc8lmW7a9y+LRT4XgZRgbuby6o4bf268JRA/KDPXfx02yR6dTsw==
X-Received: by 2002:a17:902:dacc:b0:27e:c27f:b834 with SMTP id d9443c01a7336-2962add0774mr36068595ad.56.1762328618318;
        Tue, 04 Nov 2025 23:43:38 -0800 (PST)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp. [210.128.90.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601998eb6sm51062025ad.29.2025.11.04.23.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 23:43:38 -0800 (PST)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: will@kernel.org,
	ardb@kernel.org,
	bigeasy@linutronix.de,
	catalin.marinas@arm.com,
	clrkwllms@kernel.org,
	leitao@debian.org,
	mark.rutland@arm.com,
	rostedt@goodmis.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	ryotkkr98@gmail.com
Subject: [PATCH v2] arm64: use SOFTIRQ_ON_OWN_STACK for enabling softirq stack
Date: Wed,  5 Nov 2025 16:42:59 +0900
Message-Id: <20251105074259.209131-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For those architectures with HAVE_SOFTIRQ_ON_OWN_STACK use
their dedicated softirq stack when !PREEMPT_RT. This condition
is ensured by SOFTIRQ_ON_OWN_STACK.

Let arm64 use SOFTIRQ_ON_OWN_STACK as well to select its
usage of the stack.

Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Will Deacon <will@kernel.org>
---

Changes since v1:
[1] https://lore.kernel.org/linux-rt-devel/20251013013508.74677-1-ryotkkr98@gmail.com/

- Add <Reviewed-by> by Sebastian.
- Add <Acked-by> by Will.

---
 arch/arm64/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index c0065a1d7..15dedb385 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -62,7 +62,7 @@ static void __init init_irq_stacks(void)
 	}
 }
 
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 static void ____do_softirq(struct pt_regs *regs)
 {
 	__do_softirq();
-- 
2.34.1


