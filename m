Return-Path: <linux-kernel+bounces-788159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 506EDB3807E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21B62367F24
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D1A2D12EB;
	Wed, 27 Aug 2025 11:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lgS9MXP9"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9302287257
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756292689; cv=none; b=LeuiC4V2PpzY9iR/O9K+Ya4JBegdKIK/SPWnu/3QuQL+ZIB9gnoD9bClG0iiVeA6DFc/tWACY5n15pkSOxR6vDSprEi50BGmuEwIUFhw+5PnFiv4Cwq3nojeHmAYC8nzQ0tJ6hYQkUylc8srXhvCpvnwEn7+FKDdqF4gst6yvtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756292689; c=relaxed/simple;
	bh=j86wCjork52YcHNP0G8QYH3M20P0o4gvNc3xBHSW35Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WNXMpC0/L/EVtkr4wrxZ7kPbxHCsQYieh3mbBQonQWTE4i3UfhsKzAbEVzbM918b/E6lsHjaykJa5jJSha6a6MypSRmTErfKElfz56sGep13OoEz+P8reJgGwzlEsUNxx1XLUM0703tyA2YLYkk8ljbrMKwF32PMJOKYf9N0hcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lgS9MXP9; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a1b0c5366so40041745e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 04:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756292686; x=1756897486; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B1JLDczBck6DvgDcQzS2GBWgdu9LwuHv0ctBDRr5UCA=;
        b=lgS9MXP9+m0MAJcAkRAGmPv+j2e+d6OwFJB6gp1uvnom0MsLMp/KXaIILOSZlDvdbV
         0lWEcg0vIDN2n/fXNpoDEO0WpA1TEt5wSpnh9TrE+3/ztPg53kmjBaYDY2h6x/Fk7NfJ
         4njeNuopQcijXkkxXdjUab+dfVxb9dKrxxwKTaq8BW0x0Ys5qs4gsIXfeP9aUzkRo71B
         pgRGcF82qBWswxOas8t5+ozoOuMgphy3BjDxYog6umUFAq3JRAVX0dC3LRp5WGD0RDgH
         LrXsguxoSCXpPaSrvYno+8oxxuVWDUnC/clfNSYqaOKOx3yMF7EM2nAPhyKHWq0b9O1F
         KODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756292686; x=1756897486;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B1JLDczBck6DvgDcQzS2GBWgdu9LwuHv0ctBDRr5UCA=;
        b=VD+sRtVtyYw4QrO7XEoONF58OheRJX7S7GQTz0rpzs/TBg7YTJ/ZWs/2AI9zmFM8W6
         DIn3HkewFS7Bz1F0YyQ4d82o7o3pmnMuSDQ13bqnw5h5QXBxb1j6RFIiPd0U+RQwlgla
         OIuDzgoTSNLqRqo1sOTggb/uI31U0lR3iYq/XUUAW8HykRLp8KB94Gl3/8zY0G+E/sr7
         UWhq/R2vkVqY2pITsi0IiT2fZESR6ElYfD5xfvS6WhDi3F9L2IWizzGpoSvMZ3y36h6p
         v1Kfu+ni7si5/yNlmq5jFcxJ/zSrKXKwzR4WXA7qG3amStG+OXW+t7MN/Dm9rxj7bLBa
         fJPw==
X-Gm-Message-State: AOJu0YzRjfihuxed1gG6F9nTtl0js5rn0JLO2O24a/g3wrS7cNZrmaJm
	ErPF4+/DosfHSqYZmfT2QkGGPiquZ5iPuAGFhE9UNiS778riyRne4w+jUEBPv+oFfh/P7cuNOIE
	MVdxF+v8H3k8E4Q==
X-Google-Smtp-Source: AGHT+IGrAcbdSroEv8381iwG9fFa7HIZzG92rr8VYjO8Tn1BstPgPDU22+oW3fciclP7XBaLivl8yhvcXwvINQ==
X-Received: from wmbhe13.prod.google.com ([2002:a05:600c:540d:b0:459:dcca:571e])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5251:b0:455:f380:32e2 with SMTP id 5b1f17b1804b1-45b517ca54cmr175548825e9.18.1756292686018;
 Wed, 27 Aug 2025 04:04:46 -0700 (PDT)
Date: Wed, 27 Aug 2025 11:04:41 +0000
In-Reply-To: <20250827-b4-vma-no-atomic-h-v1-0-5d3a94ae670f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827-b4-vma-no-atomic-h-v1-0-5d3a94ae670f@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250827-b4-vma-no-atomic-h-v1-1-5d3a94ae670f@google.com>
Subject: [PATCH 1/3] tools: testing: Allow importing arch headers in shared.mk
From: Brendan Jackman <jackmanb@google.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

There is an arch/ tree under tools. This contains some useful stuff, to
make that available, import the necessary Make helper file and then add
it to the -I flags.

There still aren't that many headers so also just smush all of them into
SHARED_DEPS instead of starting to do any header dependency hocus pocus.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/shared/shared.mk | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/shared/shared.mk b/tools/testing/shared/shared.mk
index 923ee2492256b693c5cf16cc014d9d2410be5457..937aaa7623320da1085a8e0f43f6a728ddd3ab1c 100644
--- a/tools/testing/shared/shared.mk
+++ b/tools/testing/shared/shared.mk
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
+include ../../scripts/Makefile.arch
 
-CFLAGS += -I../shared -I. -I../../include -I../../../lib -g -Og -Wall \
+CFLAGS += -I../shared -I. -I../../include -I../../arch/$(SRCARCH)/include \
+	  -I../../../lib -g -Og -Wall \
 	  -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined
 LDFLAGS += -fsanitize=address -fsanitize=undefined
 LDLIBS += -lpthread -lurcu
@@ -11,6 +13,7 @@ SHARED_DEPS = Makefile ../shared/shared.mk ../shared/*.h generated/map-shift.h \
 	generated/bit-length.h generated/autoconf.h \
 	../../include/linux/*.h \
 	../../include/asm/*.h \
+	../../arch/$(SRCARCH)/include/asm/*.h \
 	../../../include/linux/xarray.h \
 	../../../include/linux/maple_tree.h \
 	../../../include/linux/radix-tree.h \

-- 
2.50.1


