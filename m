Return-Path: <linux-kernel+bounces-841551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 62549BB7A1C
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 18:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 55AED347312
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 16:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8FC2D73BB;
	Fri,  3 Oct 2025 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YtvZxk//"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86762D6603
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759510641; cv=none; b=lz+YGoA+LdAqpUsIDGya9A+AVUZjJDprfv93+iEkwmGBcDP7LGnOlnrT+kMY4ogq6GdvSkwro2I7u3dKyzbYK0Hk0v8hyV0m2tDmTjtv1jTbEH65YwpqYIAI5C8nmDMaIu9qx+nQnbuAW0360oGShBk4DrD36I/iE8EgFz6ufHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759510641; c=relaxed/simple;
	bh=FBnZUWrao4xDk2sny2hB2i0YpqUaYxXcjVD9MKtr7DU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f0JPyvUwXnBq1LX5uIUQ7IBhlzmyl7h2N1AbvFjP8kuNF81xxWzPBRHZ7LjjHQRLRrgAsVZeHuCqXmp3RB3V7aG8WXJSau/izCJNCxNL7fmOoGqOYrSk+lkGcNBk7vjtD5RyJ0sUHW9YxWs1JEZtTez2ncZUEqE38R3dH/DRXQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YtvZxk//; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e4d34ff05so11648325e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 09:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759510638; x=1760115438; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gC0UUs1MxRL/9leGnqOkfqW8jxMDETHu7dBcMx0PZdA=;
        b=YtvZxk//bJde/QtdIN5LcvlshjSI2c3n8XEcjfbmxSdqSJkGO8UP+vdULbUQcD14Zr
         rHP7b3B5bktE5ifE0LEDzepIfVXW5Kf2M+LZEieR+j7mL/sXvywlnP+9weewaBw23R9V
         EeQmDhQU3MBu+8nZBprra8Zpdbe2Q/CYykYmo9GDXv/D1PEiSST7GBobr63/XhSlFiDb
         gbNHSqYBhTLu6jkr0ViCbXkpOucYQdCL5oeKuN8Cg8DYLqTaGwJdeHGJpurIA6Sq7aGQ
         w+xL1CgmTQvDT9/7PNHRSZVXFhpBHGJDcVycK6wG1SAtcDCS72jM3dA9zVgBJkYU+E1+
         U0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759510638; x=1760115438;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gC0UUs1MxRL/9leGnqOkfqW8jxMDETHu7dBcMx0PZdA=;
        b=wsmk1hCDzu1MfdI8nSKA61OGoo0Qy0Z2YOZ5c9LlXhLXW3su6OD9dMfu6YHT8VOYdG
         VDfZEmuF50PgxXzQ7nCpj0YrrXNdAIuhyZoGlVODmtPRZ9/F56fEnzcO/Dw4b01L5QPy
         fIb37D7w1yi9lGOZ5w5o4abctmUt0fWkPoleiJ7SLoUQSGLvor2N8TTksVVJo6YZQ+vP
         x1KBt+4HKpRQ7CJmIiusf38A0QIIay6YNkUY27Dd8yT8l43tQxbqEhzyNUUuztwKqCFu
         dbhRlUGiX+fuDGrTwF2zhAGW7wln7K6lPf9h92cFn/bOdAXbuOwRw+G/1LuMxf54kUzV
         gUoQ==
X-Gm-Message-State: AOJu0YyPtkL7/MOk2U67IC0z0b4h6NNvswt6fvEhMX8mwNzaPrKLahoO
	lVdXkObKFgDzipb6hwGopRoLmq7FUuVmqbLYhHli4qgUBynYe7vVuO6B1buFKLNKLLzOOIhOte6
	Qoo2d2tw4LUDT/g==
X-Google-Smtp-Source: AGHT+IHJcKF7j2WFIL/M4GDc4qk5ekOcxGa0ZgJnCW3cH6qhK6l1U+DS6ClzIoQlXQSY+22gJpavrC7EgKJ3FQ==
X-Received: from wmaw22.prod.google.com ([2002:a05:600c:6d56:b0:45d:e232:8a3d])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e52:b0:46e:36f2:2a62 with SMTP id 5b1f17b1804b1-46e71151798mr24309465e9.27.1759510638117;
 Fri, 03 Oct 2025 09:57:18 -0700 (PDT)
Date: Fri, 03 Oct 2025 16:56:42 +0000
In-Reply-To: <20251003-x86-init-cleanup-v1-0-f2b7994c2ad6@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003-x86-init-cleanup-v1-0-f2b7994c2ad6@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20251003-x86-init-cleanup-v1-2-f2b7994c2ad6@google.com>
Subject: [PATCH 2/4] x86/mm: harmonize return value of phys_pte_init()
From: Brendan Jackman <jackmanb@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

In the case that they encounter pre-existing mappings, all the other
phys_*_init()s include those pre-mapped PFNs in the returned value.
Excluding those PFNs only when they are mapped at 4K seems like an
error. So make it consistent.

The other functions only include the existing mappings if the
page_size_mask would have allowed creating those mappings.
4K pages can't be disabled by page_size_mask so that condition is not
needed here; paddr_last can be assigned unconditionally before checking
for existing mappings.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/mm/init_64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 9e45b371a6234b41bd7177b81b5d432341ae7214..968a5092dbd7ee3e7007fa0c769eff7d7ecb0ba3 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -492,6 +492,8 @@ phys_pte_init(pte_t *pte_page, unsigned long paddr, unsigned long paddr_end,
 			continue;
 		}
 
+		paddr_last = paddr_next;
+
 		/*
 		 * We will re-use the existing mapping.
 		 * Xen for example has some special requirements, like mapping
@@ -506,7 +508,6 @@ phys_pte_init(pte_t *pte_page, unsigned long paddr, unsigned long paddr_end,
 
 		pages++;
 		set_pte_init(pte, pfn_pte(paddr >> PAGE_SHIFT, prot), init);
-		paddr_last = (paddr & PAGE_MASK) + PAGE_SIZE;
 	}
 
 	update_page_count(PG_LEVEL_4K, pages);

-- 
2.50.1


