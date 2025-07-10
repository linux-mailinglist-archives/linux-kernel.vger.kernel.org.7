Return-Path: <linux-kernel+bounces-725472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3223AFFF8C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 424397B99C5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B872E0937;
	Thu, 10 Jul 2025 10:46:59 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F31B245005
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752144419; cv=none; b=cuR/sY/Aff8bBYwTon9eWXIcAplQQcbhUfR0sqKx7FZ0qVh+h/zF24N9pXTIPoPTtCTDGfTZbrQzea5J21BMiA7Smie7hHTR4pBQqoATTkha76gZkrw7SK6GF0N2jGAL2+Lbf4GL99xC3MkDHbrqVB4ODot1zo5EXkSCYFc34GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752144419; c=relaxed/simple;
	bh=NZ9JWewDIpJuTxlD3Y6Io3nlZ3dqQ52JIgXmz5U9mV0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EBDs5sTgMLYY8mtOKe9+lCiuit+H2U+CRjuPhZs5IRXb96DePiiG+XbtwTjp+5gdOjVZ0vTgevGsvZHSqcN0jm5ooSrvU1XTw4VagdzkF/V5irhc5gpy0J9SV4v73QuGOZtSmZ16vc9Fe21KX7MKywURJ604/ETi0VwMacxlh6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60789b450ceso1506459a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 03:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752144416; x=1752749216;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DwTBqxY5fhpDH45jt0TkZsDBkbjBOKihn4EmNoV0LNw=;
        b=JySBdUcrFUF+LYaxcKcs0mzSDvW5OxI/j/qb4/9vebeYIt05N2TGt+glNfW3jUbZoB
         vjREkKc0AhGbnmqDQFgCdzzPre+d67MPovemCP6qiZNvq0ZD5s+GZgmh4YNLAYf2BO6C
         bsnAVFe3ddWVCkfs4B7KsnB/9vNZngYTffm3n/tVefq2yCkgpW/Z/Wq4WxsaDHEPR1zc
         nuzeE+kvSihUjCyz3sNq95MtrTd256WPvRZYlL8Q8loiWGMh8mJ9jLamQTJOfd4xwyDf
         B+HQgkobUxoEGhplTwsLviGMHMCbdQtmpCa4Vua9qW5PsUuqMBTU/YqiqifzXBe0S9Z/
         BdzQ==
X-Forwarded-Encrypted: i=1; AJvYcCULtX3DRLUuB1a6qsLTq5/VygvnK2hF0jbD6IxXYp1iwbSlqA9Om6ek5qpsl6rwCORPA9qa4SlIS+wUt6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuK9CiIs5+xoqyANGMRm0c7Y2MrABIuwG9L9jTxiCiPJEuV0/k
	3Bhr5YoNzauFbeZJmy7NOgV7wXsjhdT2SYdJGED6j+d0CrMZhxzoWFh+
X-Gm-Gg: ASbGncsuVsa5IhgYMZQs3bWUO1RYU3qxxn9AMAYA/rTI4GdFcIacWdrCb9HaKd60rWy
	0BoP1O5Dc0h38R2nWDjckTGAWSyTJq9IsIuZ22LnwJg/MDQ12jOTY+2MIG2qqFbnYfsyD2iv1Kl
	E0+AMi+rQ8YA0Fn+ZprxJ67kRL+mqxTwdr1bHS01bLOCMSGcgRijL16zlN8dbJRfYrDD2Y0yzZX
	lM/Xjt2Jfhwg5TGKA1h5gl0KJVvGFuiscEu1ZYKaMt5U8uDiUy+gCO5+qZIVrYjRwG1SrTzyT04
	jxdE/dCvnrCgYxJ/SjBJ0gYD5YPoh1nSHfUSJxyC04LebkzGGgPF7A==
X-Google-Smtp-Source: AGHT+IFmxE1MalHqQ4MMFqA2twYZFP14xfCT5MFa7IETBL9bkP3o+0HFx+OjxlMEEaHq34KFxBsUgw==
X-Received: by 2002:a17:906:696:b0:ae3:b22c:2ee3 with SMTP id a640c23a62f3a-ae6e7043eafmr155327666b.31.1752144415547;
        Thu, 10 Jul 2025 03:46:55 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e8f9b4sm112022066b.11.2025.07.10.03.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 03:46:55 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 10 Jul 2025 03:46:35 -0700
Subject: [PATCH] arm64: traps: Mark kernel as tainted on SError panic
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-arm_serror-v1-1-2a3def3740d7@debian.org>
X-B4-Tracking: v=1; b=H4sIAAqab2gC/x3MWwqAIBAF0K0M9zvBrDDcSkSITjUfPRghgmjvQ
 WcB50FhFS4I9ED5kiLHjkB1RUhr3Bc2khEIzrrO+tqaqNtUWPVQ4/2cYp9943KLinAqz3L/2TC
 +7weXSEVdXAAAAA==
X-Change-ID: 20250710-arm_serror-77fca8d732d4
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, osandov@fb.com, leo.yan@arm.com, rmikey@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1231; i=leitao@debian.org;
 h=from:subject:message-id; bh=NZ9JWewDIpJuTxlD3Y6Io3nlZ3dqQ52JIgXmz5U9mV0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBob5oeoFlOCtV1wQ4BKu2P6QjzzQrcQ7yIvOeHt
 uBPUc4MA/WJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaG+aHgAKCRA1o5Of/Hh3
 bdz8D/4hCtVkn3bLmZOGXYjNhCn//p66gXF6gUi9vJkE50F15RQLs4ZMcNxTlMZ2jkp3MVcGWPc
 LU2DjpokdABLZu2XwLu+YF07c0qz87O6AsFaTXksx01GBzTSjWndJoMxtFQ+criNNmY620oo3Oi
 8MkPthH3Ci8SBZwwnLg1D95UIZtQfUgee7diT3Q6waeIM+a/ytZoWxP6ZqvxqSkYWSIzCGJD+Wj
 lj+xBD4skkXPpSb8ilSKAWDvHwZakMqwDMPb51Mbv7kV/IxoumcIHwWHNvnJ027kpre24C1aEFq
 ziq9YBFxyfJAr42qh2im5VM+PXAoLejEy/4rzVV/1JMgkWEdQyMNcG/F3V3jSCJC40sgpRh2wZX
 A/MZEgiHTXSiU4Kl7TJRYDNu7bxWLbYTBL0Y8ek6NO1v7YuOL5u3E39C9BhtPxJS18v92hzLtCm
 idaYBs6sb8Wumh7033T6urVmc4paeJdqPxjc9pLDxJ1ecSiLXvvLTaXgqrtlUujobr+za+2NH3h
 YTZd+R+7fk75SzmfX6OpexG9TiWK32D8xuhQUhvYJuj9IaBxgJmrxILpNhJc4QOrmb1uwA2wj2G
 44ygpXD9uAll2f2675510KN1O8LihSlDylnODShFmLT5vED0yE6A0g75Z02ihrtTdqkY2moBNTt
 /JUCPecFGMDliHg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Set TAINT_MACHINE_CHECK when SError interrupts trigger a panic to
flag potential hardware faults. This tainting mechanism aids in
debugging and enables correlation of hardware-related crashes in
large-scale deployments.

This change aligns with similar patches[1] that mark machine check
events when the system crashes due to hardware errors.

Link: https://lore.kernel.org/all/20250702-add_tain-v1-1-9187b10914b9@debian.org/ [1]
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/arm64/kernel/traps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 9bfa5c944379d..7468b22585cef 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -931,6 +931,7 @@ void __noreturn panic_bad_stack(struct pt_regs *regs, unsigned long esr, unsigne
 
 void __noreturn arm64_serror_panic(struct pt_regs *regs, unsigned long esr)
 {
+	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_STILL_OK);
 	console_verbose();
 
 	pr_crit("SError Interrupt on CPU%d, code 0x%016lx -- %s\n",

---
base-commit: 8c2e52ebbe885c7eeaabd3b7ddcdc1246fc400d2
change-id: 20250710-arm_serror-77fca8d732d4

Best regards,
--  
Breno Leitao <leitao@debian.org>


