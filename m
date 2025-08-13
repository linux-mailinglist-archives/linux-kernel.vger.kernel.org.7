Return-Path: <linux-kernel+bounces-766941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1829FB24CF7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7991896FB3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37F21D7984;
	Wed, 13 Aug 2025 15:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kt7F1x35"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE65D1C1AAA
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755097707; cv=none; b=A481D6BYkgDE3PFhJPhjlBYoAQbcueoYqaPyL5TPx+oZ5hPRqfbnw7nqnojCHf2IiarlqKSniFlnFatZtxprDRpWjYSayf3ntn7UF6E2xK/L5Yud3jZI3/RmT/HeGSyhYWO14o82HX3SblGSG/nT2O5bqk/aA6I0fbL/YYxpNT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755097707; c=relaxed/simple;
	bh=rUCSs06o6DrNRHvahz96qJlGOueTlRrODZJGmaLKLko=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mJiGY3K1VRCv85yCL0ubOWGvMUQuYbRebRChPH25UaXmrOpjSnIGCzA+1Cv9QVM5cOF4B0k9HJxx8gPYyDz1GYjFy7/wpS1GbLe/zLEVJxiXlErVrMxtgylkC+7q5wCX/9XiVcIB05Abv14B87HTDmtq8cODS/tiCur4akXKiVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kt7F1x35; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-459dfbece11so34809445e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755097704; x=1755702504; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u+FoVlivtwf/w/LWwodUpXWeg2oQ/qN8IiA2oOG8wu0=;
        b=kt7F1x35xAVCuToItSFOr3HCwH9fdxAbhy+wuks+ebbwpvMbdDRH0nPwElgp+3nPNT
         /QqGlYmlbWBVRSbaRHNBKOH9vsNZXvApwVlwb8/TlCy0O1eBUTsR4nKFbONB8s4xQhi1
         RH57astUiFJYc3ipgOXlgs/Tl08Ahh3Pm/JxipKyz/FSOHSOMptwots8B9dnla96JVXk
         CXwPeBdRfBK6CMSXuudOzxu477e948oAQJW7imFLz6+iYuhwWrykQL6P2RMyKLhzzOvr
         ocOLopHcMwawgvGpCn8v7T3kHlHuUkUKU/bj9MPRMH9WMehVTgQ/5BuBvcMzdjpnPu0O
         4YFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755097704; x=1755702504;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u+FoVlivtwf/w/LWwodUpXWeg2oQ/qN8IiA2oOG8wu0=;
        b=HJb+S1kAGn+YfRNk0WdGaN7edEJjBpYh2MN+RdYzQnBdNuTfBrLpppJOkwfCWrbybk
         IhHUhbipPrUoFSXo9NKfGunZe+OfsUhakhNvST9SMAMQrnw3shpJH9iucs1KVVWDr+ok
         QezXXoB8F8Gj1ID/1Mg95HEOq2hKUEbmMbpLE36+2jZJH3F/LrMai7WGgefMZdqFE5yN
         1oorzryW+VwVI7pFRMJbZsssEMTgihQE4QUZdk8kZStHFIxkK1zgHqfqP22lKTEU3MST
         sWod40/6Mn/HW+I71ggX2NGha/rggBApGpf4dXr3khCD6hUPrpH74dEBqRwlYUy1fggC
         HEdQ==
X-Gm-Message-State: AOJu0YxWCySu6tnZ3qHkiuQ+3GmG7OZE9v+WrTwrzTD5YvMl6L9kCB2P
	aLLtQxQjhl2WinNI7wU7KdlDhSKxf2yPMRFcjkgTEjyhj0QwztGhK5IxGxFf+kzYwBeviPzeXJP
	/nKxYDap/7gn3pQ==
X-Google-Smtp-Source: AGHT+IGo3x2hW3WWH4Hbk/tgmGQ06+20UZSLEBaC9vtiFZOalidXnAMyGwUoUPnk9nbqsb/ofg+dj5pre1uueQ==
X-Received: from wmby25-n1.prod.google.com ([2002:a05:600c:c059:10b0:459:d776:c35d])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:458b:b0:456:496:2100 with SMTP id 5b1f17b1804b1-45a166098d1mr36625235e9.31.1755097704140;
 Wed, 13 Aug 2025 08:08:24 -0700 (PDT)
Date: Wed, 13 Aug 2025 15:08:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGWqnGgC/x3MQQqAIBBA0avIrBtITZKuEi1EpxoIE6UoorsnL
 d/i/wcKZaYCg3gg08mF91ghGwF+dXEh5FANqlWmtVJjWu+CLoSMfiMXj4TBmllaaXRHPdQuZZr 5+p/j9L4fJ6u3HGMAAAA=
X-Change-Id: 20250813-phys-addr-cleanup-d85f181534e7
X-Mailer: b4 0.14.2
Message-ID: <20250813-phys-addr-cleanup-v1-1-19e334b1c466@google.com>
Subject: [PATCH] x86/mm: Unify __phys_addr_symbol()
From: Brendan Jackman <jackmanb@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

There are two implementations on 64-bit, depending on
CONFIG_DEBUG_VIRTUAL, but they differ only regarding the presence of
VIRTUAL_BUG_ON, which is already ifdef'd on CONFIG_DEBUG_VIRTUAL.

To avoid adding a function call on non-LTO non-DEBUG_VIRTUAL builds,
move the function into the header. (Note the function is already only
used on 64-bit).

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
Note: I started to unify __phys_addr() too since at first glance it also
seems to have the same unnecessary duplication. But actually for that
one there's code that needs to skip the VIRTUAL_BUG_ON() even when
CONFIG_DEBUG_VIRTUAL (via __pa_nodebug()).

I've run KUnit on x86_64 with DEBUG_VIRTUAL on and off.
---
 arch/x86/include/asm/page_64.h | 14 +++++++++++---
 arch/x86/mm/physaddr.c         | 11 -----------
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index 015d23f3e01f12906d4a423ec555ea5fe53249c6..364c8d618fa7e9186f26ecff00d93d0b07882664 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -9,6 +9,7 @@
 #include <asm/alternative.h>
 
 #include <linux/kmsan-checks.h>
+#include <linux/mmdebug.h>
 
 /* duplicated to the one in bootmem.h */
 extern unsigned long max_pfn;
@@ -31,13 +32,20 @@ static __always_inline unsigned long __phys_addr_nodebug(unsigned long x)
 
 #ifdef CONFIG_DEBUG_VIRTUAL
 extern unsigned long __phys_addr(unsigned long);
-extern unsigned long __phys_addr_symbol(unsigned long);
 #else
 #define __phys_addr(x)		__phys_addr_nodebug(x)
-#define __phys_addr_symbol(x) \
-	((unsigned long)(x) - __START_KERNEL_map + phys_base)
 #endif
 
+static inline unsigned long __phys_addr_symbol(unsigned long x)
+{
+	unsigned long y = x - __START_KERNEL_map;
+
+	/* only check upper bounds since lower bounds will trigger carry */
+	VIRTUAL_BUG_ON(y >= KERNEL_IMAGE_SIZE);
+
+	return y + phys_base;
+}
+
 #define __phys_reloc_hide(x)	(x)
 
 void clear_page_orig(void *page);
diff --git a/arch/x86/mm/physaddr.c b/arch/x86/mm/physaddr.c
index fc3f3d3e2ef210fc31b2eb661f4c5f73457d42ab..8d31c6b9e184ff2110ef896e63eb6422070d8b1d 100644
--- a/arch/x86/mm/physaddr.c
+++ b/arch/x86/mm/physaddr.c
@@ -31,17 +31,6 @@ unsigned long __phys_addr(unsigned long x)
 	return x;
 }
 EXPORT_SYMBOL(__phys_addr);
-
-unsigned long __phys_addr_symbol(unsigned long x)
-{
-	unsigned long y = x - __START_KERNEL_map;
-
-	/* only check upper bounds since lower bounds will trigger carry */
-	VIRTUAL_BUG_ON(y >= KERNEL_IMAGE_SIZE);
-
-	return y + phys_base;
-}
-EXPORT_SYMBOL(__phys_addr_symbol);
 #endif
 
 bool __virt_addr_valid(unsigned long x)

---
base-commit: 8742b2d8935f476449ef37e263bc4da3295c7b58
change-id: 20250813-phys-addr-cleanup-d85f181534e7

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


