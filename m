Return-Path: <linux-kernel+bounces-888996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4FAC3C67D
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AB733352124
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFB634DCCD;
	Thu,  6 Nov 2025 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I2F31noM"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD47C27E7F0
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446201; cv=none; b=U3vt1a4a0oXWe3iau84NDZuGp6DsUhCxnbtM8jRPb1ffDfZkxdPlqADL0QkAKJg2GB0pbkDeb35dYprcoXbYDiSxW0O+mDfxhEGVPDJP3RBAdaA1MTlVW2uvGP7636zl5AXJWa3OlChjYjAZdQ8iudOQQjAW8tgIgLLG+nA+zZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446201; c=relaxed/simple;
	bh=0Kl5kgIBd9ZkeIq++uq3B3xJ2Z5OHe2Gu9qnsZWPwRQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mRB4dTGvn8ojVAkTXGsbr55GlWqoINKxa6bax6mbRdOTqwKKmhWkv85fMUZAEMbBH9ZFc/u+JZd9Y5WmCbr2lroM7Mpv1epwA+YpipLN41gPwJVaTkCq+mCj/cNOWt1QXuoJy8HhaUrQQ9RiJKFugaXp6wws0yoz5gMfFBdv7NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I2F31noM; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-471201dc0e9so9947835e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762446198; x=1763050998; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bdBhYjPY0GJP8rJ3frvoG39k33hshYMCy+CHWPylcZY=;
        b=I2F31noMSnvHgz3hxs0p+lsDaexeP71ywX8ZouNTklt9ga2zY5lEzxw0uYA3VXOk2+
         CZPLV8D2iM3qjJAuTHej77dq7eCcbTZMc4ObKGl2Sr7d6BB2dSjLaSd4BJ4Sb474+U0R
         7KDDLdn+sA99gkp+JRg1dvkiMwqKvaaphrxqFur+Vr08qld7E30UCYiBOT6MWphfPQMy
         ScwAbelfEysw7nDIdycbKHWlTav8iGbjTPA/j3YYaHpvZg/H1hi243Eqo/JH0mcJmCSN
         qP8LJfvWWONGUi4W4y/Gtle626S+z3sApKUCMMB62Mqy6/oZsDwsQvbyakfzX4eFQ4ku
         BnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762446198; x=1763050998;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bdBhYjPY0GJP8rJ3frvoG39k33hshYMCy+CHWPylcZY=;
        b=BM+RWDJM3/ske94+f9zgZ7N/ueE9jW969PabwSrdn1M29jczREmIiVHlJI4bUpvKpR
         m2MCb6waDZ37sVU+zp/nB7kMwLodCHXosBhlHW2EJPxSC8AAm8JXMpVPtWk/+y0jIn5k
         y5Y5HfMa6/OpGKbcNscHPOIeOCYKBlQWKSLqxYPvXXrk0u2oMmY1yljmS+l6cXJ6sdFi
         9F6Dx+sEAjlgSR2VW8dGF60D8LqQzrQsXmLiVns755vIqQ/F4eZBmzlacBi0MHLYTLjo
         92N5nk5V928bc1XOEsQmRcTA+4MBXUz3tTnenGlww4Ig4FqIj9La1wGHXShtCM2AiAoJ
         3YCg==
X-Forwarded-Encrypted: i=1; AJvYcCW9RLFwPjahS7oT3Pi6UzoRYsbFM+fT/Y142NBQOUrtXMAVTii+07cdjnREPz8hANIwUowYSNYFEOAMOB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5mTXEuv+QH78yyR1BrVZKwzYnLKk6KEGKzZ+liZ18YFlFL4El
	/Umpeo94z/jP9ilYNDYKp9Oljm9EZBa9ro2/EzOVi51JsgbVDMRBP6p7Y1X+Vam3RiZGAhGyHXZ
	kRb4pHDWVewls6O1boxzdPQ==
X-Google-Smtp-Source: AGHT+IGVTUJFI0jTYdNCuSG09T5k+goxm2XX5uwW2ru0IgUEWYNaV9md2PPwTAiF7ICgchU+lnyJW0k13aG9ZFRZ
X-Received: from wmlm25.prod.google.com ([2002:a7b:ca59:0:b0:477:632b:1238])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:45cb:b0:476:84e9:b561 with SMTP id 5b1f17b1804b1-4775ce14c03mr98525145e9.32.1762446198321;
 Thu, 06 Nov 2025 08:23:18 -0800 (PST)
Date: Thu,  6 Nov 2025 17:23:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1026.g39e6a42477-goog
Message-ID: <20251106162311.2705162-1-mclapinski@google.com>
Subject: [PATCH v3 1/1] x86/boot/compressed: Fix avoiding memmap in physical KASLR
From: Michal Clapinski <mclapinski@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Chris Li <chrisl@kernel.org>, x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Michal Clapinski <mclapinski@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The intent of the code was to cancel KASLR if there are more than 4
memmap args. Unfortunately, it was only doing that if the memmap args
were comma delimited, not if they were entirely separate.

So it would disable physical KASLR for:
memmap=1G!4G,1G!5G,1G!6G,1G!7G,1G!8G
since the whole function is just called once and we hit the `if` at
the end of the function.

But it would not disable physical KASLR for:
memmap=1G!4G memmap=1G!5G memmap=1G!6G memmap=1G!7G memmap=1G!8G
The whole function would be called 5 times in total. On the 4th run the
last `if` would not trigger since `str` would be null. On the 5th run
we would exit early via the first `if`. That way the last `if` would
never trigger.

For the second input, the code would avoid the first 4 memmap regions
but not the last one (it could put the kernel there).

The new code disables physical KASLR for both of those inputs.

Signed-off-by: Michal Clapinski <mclapinski@google.com>
Suggested-by: Chris Li <chrisl@kernel.org>
Link: https://lore.kernel.org/all/CAF8kJuMvX31n8yNWn11bo1wCgXXOwOAp8HbYpSEBy94LR6phDA@mail.gmail.com/
Fixes: d52e7d5a952c ("x86/KASLR: Parse all 'memmap=' boot option entries")
---
v3: added a link in the description and a better explanation
v2: used Chris Li's snippet to change the flow of the function
---
 arch/x86/boot/compressed/kaslr.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 3b0948ad449f..649264503ce6 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -162,14 +162,18 @@ static void mem_avoid_memmap(char *str)
 {
 	static int i;
 
-	if (i >= MAX_MEMMAP_REGIONS)
-		return;
-
-	while (str && (i < MAX_MEMMAP_REGIONS)) {
+	while (str) {
 		int rc;
 		u64 start, size;
-		char *k = strchr(str, ',');
+		char *k;
+
+		if (i >= MAX_MEMMAP_REGIONS) {
+			/* Too many memmap regions, disable physical KASLR. */
+			memmap_too_large = true;
+			return;
+		}
 
+		k = strchr(str, ',');
 		if (k)
 			*k++ = 0;
 
@@ -190,10 +194,6 @@ static void mem_avoid_memmap(char *str)
 		mem_avoid[MEM_AVOID_MEMMAP_BEGIN + i].size = size;
 		i++;
 	}
-
-	/* More than 4 memmaps, fail kaslr */
-	if ((i >= MAX_MEMMAP_REGIONS) && str)
-		memmap_too_large = true;
 }
 
 /* Store the number of 1GB huge pages which users specified: */
-- 
2.51.2.1026.g39e6a42477-goog


