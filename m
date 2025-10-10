Return-Path: <linux-kernel+bounces-848206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C161BCCE2B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC4B04F128F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 12:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC7328BABA;
	Fri, 10 Oct 2025 12:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REnoYaud"
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C59728C847
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760099137; cv=none; b=Pc/5NGbLQgLUUV3qwTYl0IymYC2skN47oiujyz5SMl2q9JurlnYHdnZkzhGueMngRphYPhkqgu1JOk5/CbqDLrg/Mh+yGcH39m/stRpP/GHaWiE1QCrceWKJ+aW3pO056qJaiJ8mY8X07nkNI1do28IacvzuaSO13MJE/yiJ/7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760099137; c=relaxed/simple;
	bh=WUUlMnT8mDdxkZLl/V5vnw1heeufFiVwi1hMjyBlMwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LJBQ6XRMcuPnBXwMxVgB2oRrhyjy9rVp2zxOBOXBmByOADbhNMqku02DDdIXsOx8xuyFQBg1nh/CgsnRkgGKJlqTLdRJeY1qOOOtprJdQVL/xQRB78RYLf+7Ud7EqotlasEQl6KIFJeLYG24LqzBLgDDmuyNXfqDKrzVcErKleg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REnoYaud; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-77f67ba775aso2994748b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 05:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760099134; x=1760703934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GMTjtSTP26a0dJoaoHvyiJH2hClsgxgzzfDyqZfZoHU=;
        b=REnoYaudNbOmpXNacnGYjzuu+vpdg3l4R9swjR6o2a+Dz0Y8rtRE+T/cUIKrMg1kcn
         7U11BuMsoRj69R2yg1dM+sDyTEvbU8bRG7Zbs+5/xX8gRcqhd74L/QrxLL1yhYzXiXRH
         vCq8NAxjZmoa+TfHkLTLFXiH3AyKpzQ4ZtCFx4mRLPM54oyFWgX7cp0T+tA87cMor5os
         spptWdzUEBtrWAq7BV8LscR2a6lCc4s5QQKy0pEsXO+u+z4HkcRqw7Qsj1xGvzE3BIeO
         1+0+aZR+XqKXOBpPgmoZBHVJLOp8RPpnpRA7XMw0jUK5/N2NLz8LqzeXX4yme23RjM9R
         kYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760099134; x=1760703934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GMTjtSTP26a0dJoaoHvyiJH2hClsgxgzzfDyqZfZoHU=;
        b=M4K8FgGDZo6TOCnWALAdtQkGfNAO/e6unTYtCOEPJVDBFMLVUE83VjQXHGcLW+f0Gv
         uPd5djFWl8sE23HmIX82fUlLNgpXylMm9Cq2wP8ZSX54vtobQ1+r8CltCZTI+TwCJ3Nw
         T9V7k+/4QdpBobjK9TCm4d7dxLtiYS+kx45FnyEPGhMt5URkSeaOtDYjbR8NCZCdIwkR
         PXqljNldIBI93a3jhYsnAt5xFT2MOVbWh7uuf4qfPZHFa3AKg2Y/2oQmkRmyYtAGEXbG
         sc9CkHaY/go0gtZusVktkXzVNnPwVLLT8w+rWT2CgsqDiEKPDiofyEKuZTf5iEN4oDqe
         0fqg==
X-Forwarded-Encrypted: i=1; AJvYcCU+dzdkXZ05kIyWUpCMQPbvcRVCO3xfZ5OXs/g19iw20U/szf5+u8hQQM9X0KaNcNmYfOBjfFbCFOVpT48=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUFaUqVOUrwUnU7nE7mAaN8g2evcDd1J5keqXVu6+KHhxNEO/H
	3zKq4BBdiTk2tnA/Tp9nnAEP4GAulAT+LznzA/jNaJycSIAOL4OJvoAg
X-Gm-Gg: ASbGnctvdPRrmXAApn+MLftdoEAXrFfMeXJrPkUZYc3WP1xm2mkPFEBTgR9Mxf9EEfL
	hosRNnKH250Ch/Jb981ug8rC7W4bG+iRawKgSkVgBSVRi5hV2ekbA9pMbDrPKPzCT/Y7WGAD8Nh
	WjVEGvXQPuQV4Ao177XQo94zUqyrrC/z3mk139Pn53iK1S4mrnHWJR9R3K54dr1icWwyXq7LeQ3
	0zUnNn48nFuQHfJj1TbyY2+qDGrztMnvFSpDhsWBuLZwpupE4TZhmfydtdJiEg0ql3ENwtmm3j+
	9QOHVwoEHiuKv2wbzsTDu8I48Rnf/sfCKUTNpqSf7IDykqKiUZAZhI67seha1kTYpVwEaoMuHa3
	UfQzrYWACmULMoXpQNJOKHDGqa/iq6wLOUfRZr7YLMeA7M1e8
X-Google-Smtp-Source: AGHT+IHuGaDPpsngb55CyhVGgFKRJHx01EMekH6QTnAX9j/Wpkg+15XbkTsmbUUWP2Ump1yFfIKJCQ==
X-Received: by 2002:a05:6a20:7d8a:b0:32d:95dd:e358 with SMTP id adf61e73a8af0-32da845fe9fmr15835686637.51.1760099134312;
        Fri, 10 Oct 2025 05:25:34 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b63d90asm2833410b3a.24.2025.10.10.05.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 05:25:33 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: peterz@infradead.org
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	samitolvanen@google.com,
	thuth@redhat.com,
	jiang.biao@linux.dev,
	kees@kernel.org,
	rppt@kernel.org,
	luto@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/ibt: use noinstr for is_endbr()
Date: Fri, 10 Oct 2025 20:25:25 +0800
Message-ID: <20251010122525.467066-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make is_endbr() invisible to tracing, which has security benefits, as we
discussed in [1].

Link: https://lore.kernel.org/all/20250922065248.GO3245006@noisy.programming.kicks-ass.net/ [1]
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 arch/x86/include/asm/ibt.h    | 2 +-
 arch/x86/kernel/alternative.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/ibt.h b/arch/x86/include/asm/ibt.h
index 5e45d6424722..54937a527042 100644
--- a/arch/x86/include/asm/ibt.h
+++ b/arch/x86/include/asm/ibt.h
@@ -65,7 +65,7 @@ static __always_inline __attribute_const__ u32 gen_endbr_poison(void)
 	return 0xd6401f0f; /* nopl -42(%rax) */
 }
 
-static inline bool __is_endbr(u32 val)
+static __always_inline bool __is_endbr(u32 val)
 {
 	if (val == gen_endbr_poison())
 		return true;
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 8ee5ff547357..9d07dcbd9b1d 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1108,7 +1108,7 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end) { }
 
 #ifdef CONFIG_X86_KERNEL_IBT
 
-__noendbr bool is_endbr(u32 *val)
+__noendbr noinstr bool is_endbr(u32 *val)
 {
 	u32 endbr;
 
-- 
2.51.0


