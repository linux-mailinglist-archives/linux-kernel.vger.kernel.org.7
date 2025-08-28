Return-Path: <linux-kernel+bounces-789953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F031B39D48
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 280933AD6D7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0831830FC14;
	Thu, 28 Aug 2025 12:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G1CR3y5G"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C2130F547
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756384090; cv=none; b=VIc3aZY0ruA4VjyxblWeGt7CEe91agTAkMSoum6ln2DZ/gcxPFYWzVtHaYTQK4id6s01qQLT5JjW0JHsDoShmwdTLEjA+SbjwdCddETs79E1A/4ZPTN/6+gB6tSrDRsQi1/nQiuBevOe6BsYjrLYOLpk/RT4IlyzT44MGQ1BMz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756384090; c=relaxed/simple;
	bh=EmboPdxeD9U1RTTfc6lvCHB2Qk6VER1hrEBN1mp8C/0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I4wI4kTYk4Yj7elsE+NtmmrKiYsA4eVDQA8zaplH74J1McOJezqUQa50O/+ORw2p44pfUoUMqyhwXwf9CLCUcb52mEe17cMKXtM7mgVKV7mGxYO1yc98n+eYQHGCSV7siSP9SfuLxsAIh8qoUEQTB5AVYqN6Fr10yrbiXsbErWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G1CR3y5G; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1b0c5377so4554625e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 05:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756384087; x=1756988887; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qm9V93bDt4mzncYEvbMk2UnVnKCadpO9FtS3vTNJKSc=;
        b=G1CR3y5GIyvjJPXQoCPNpN/zZUMrjlSSn9E7na6aU2wTEH5AXKIibvrHGyXXzbrUNV
         7jYcVVQ/8e1k7bUgegfOuL4q6binATc8pbstwW31Z4KiGKOaMT/wY0ECp/LndNwXW5HK
         r+ZBPtz4S9rx60IKR+eauDkqmIDxWvClDrN68cmPyZsiJjlILezkIm/Yp1bt5NEzoRsD
         UTsG65VH+WmTIKCT0RJOUDy4sC2XMNCiQE6I4zXirAgtrcSKCaV5imHyvcl2k2o3YleL
         JsSwgIucNlyE9jxC0wMg0wpwp5rjFUzNPP5SNo20WETRX/HoSQe005UYmsmNO8mrJ4Tx
         z/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756384087; x=1756988887;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qm9V93bDt4mzncYEvbMk2UnVnKCadpO9FtS3vTNJKSc=;
        b=WyTo7XXs/eXsVTRY3Qhhiq3/syCDuez7hh5kRnJQbZo2hpPjcEIr17tF0k1LBjESxq
         3VSxSAQj0HMUZLuQ43aTHWuIm1r3+iZynA/e9dF+zePKan0/EsEBYkeXf6+UikuDdkNt
         i0M9VAWesbccM8YMse2T13Is2tji6mQJiP61xeebAU4xzTgKTrGM++wlIUREmSdPrGZU
         wxPQjYuQYpqNIx8lgduJtVh/lhFz/G4NQlY7oy0hvd9fKJo2mKa20uAEvzfg8Wyy8q4+
         WS4S12IaniV4SsYvD4ZYtBmajrBikA601TjJ1EOUK/AYJT8XBphP+TolfKb6uy646jpX
         wetg==
X-Gm-Message-State: AOJu0YxfNXOCUGtJPNXJJBxLUelpA3/oTzjTMIXAZtRXnmYBCj13/5IL
	1QQdxRl5U9jZwBeXjglUiEKZGf3YEvvJJR+k392pik+XKNyYKivEzmBpT/jOq8p7YeXz7VOz6iU
	Q6Tnmua4zBSPYCQ==
X-Google-Smtp-Source: AGHT+IHX4/WrNzbX/FYn6VIRfFQuxMO4r/uZ6gK2OY/lKgZ1ymFGCjrrA2HbF5ORNJdD5g5bjBWjoWc/vSleOQ==
X-Received: from wmte19.prod.google.com ([2002:a05:600c:8b33:b0:45b:73cf:2862])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1f95:b0:453:78f:fa9f with SMTP id 5b1f17b1804b1-45b5179cfa5mr199709225e9.11.1756384087019;
 Thu, 28 Aug 2025 05:28:07 -0700 (PDT)
Date: Thu, 28 Aug 2025 12:27:59 +0000
In-Reply-To: <20250828-b4-vma-no-atomic-h-v2-0-02d146a58ed2@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828-b4-vma-no-atomic-h-v2-0-02d146a58ed2@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250828-b4-vma-no-atomic-h-v2-2-02d146a58ed2@google.com>
Subject: [PATCH v2 2/4] tools: testing: Allow importing arch headers in shared.mk
From: Brendan Jackman <jackmanb@google.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

There is an arch/ tree under tools. This contains some useful stuff, to
make that available, add it to the -I flags. This requires $(SRCARCH),
which is provided by Makefile.arch, so include that..

There still aren't that many headers so also just smush all of them into
SHARED_DEPS instead of starting to do any header dependency hocus pocus.

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Acked-by: Pedro Falcato <pfalcato@suse.de>
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


