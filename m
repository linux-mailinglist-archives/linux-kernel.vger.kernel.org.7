Return-Path: <linux-kernel+bounces-733848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF7DB079C5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E64A44733
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4B02BEFF2;
	Wed, 16 Jul 2025 15:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0okP4Ksd"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2274B2F3C1D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679503; cv=none; b=AXZgw/QBxAM9JY9D24lLU/9fB1vH3GTqF1B5KFuElpeqLHz/EmNZgWlDpafr4oGTPkCvhNP3NHcBUdgDw8DeNmgDj3PVJ2tXDX7Rg3Ua+ykp0a9YYDQaDif3Ef/rT7fDfTV6pmHwilIeg+pw6UOu8b6pyOAKNXHT1UeE3WyFrew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679503; c=relaxed/simple;
	bh=ohTqHGpgfY4UUTSymbW6sLvYas+aSmBkVgsQzVj/EzI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hCqi53bqlIJadAwOtB2Y7+Njov7UwO5FMS+fBFOAyWqE+AeRR/8KuTqGQj1lMZUIOalCCH6iFiUgTKUnsI/NnVz44nANbmNhCWaBiMWmlfjvo4pTPGvFWY82cG+pYijNAaYD2fcVeyePVr6YXWd07BiCn4J1FuZ10wln3Ca9SFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0okP4Ksd; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-451d30992bcso53510735e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752679499; x=1753284299; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y020Ei9Bk/dDr2jy5oIxQhB4Mux4H8qkRk2Nk2X5B6Y=;
        b=0okP4KsdUGJdMFYyp3757/SLW9tmoJF3u4SeogKjlC13Dm0j+IXTdSsHPmzSP4ezRx
         hjBdkwb7heBkseLwDCZCUHDNNehiR0mRrcJGuGzFWfa1nSXYAp4sMgd6kMXjrSuoAWkh
         lcXmvQuYC65HD0P/2JeyaJFAEUA+hoWsNO2gRGclJrDnomk6nDhFBsdy/CupAUJaXNUs
         s8oYP9goIM8MbILYl/IzqIkr6MelPgifG78QIH5aQgfOvl+ysOVJ3MGeFjh1/ruOsShY
         PT7xhY/LgMg3t09JgHTHJigJGI6jtIyjb8XzQOuJwZ/+4cgmrTvpJFHrZk4wkZ0tOyRi
         IvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752679499; x=1753284299;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y020Ei9Bk/dDr2jy5oIxQhB4Mux4H8qkRk2Nk2X5B6Y=;
        b=dZ3bwg++KkNiCZaFYLNjwbiAYUs3TTxNLenHcjUU3g8fyfSOOrCkF8jlikh9w++aL7
         lA5UAIpJ2ogVL6MsNIJEadZBvz5E6/Lf5bCbMJJpfB0bvu0m7rgzmSuKnhjmY9GxmV4C
         y0+Une9YMFabsnQL4wwG4xb3RUKdukhHPQ3+f4+p6PbnHNl/4w96ZXqJ2LPvJnWNB4LJ
         eM/Nm8kTXFAwVN1HCbtJ9uZkXsJNrHXZByk4bxUDaRXFXBWi9azwIaPF8KBtQnw1oqZW
         ATuOskja/Dxdg0T3TOgvM9ysgo6Eg2L9wE4DrkIR11xtjD6ST6Kxe0tv8sh5Jblo9R1S
         8rSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjVaHV7kBFFK+LCBG1qEUTXdv5Ss8dtFsfhfceD+hThuElf4cekuCHGfyGdeumgNM7+aGsypnuD9INeWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+TZOvfM4XySxCfxYNVpdLpuMG7HhxDLdE3/6pF5InG/QuoHNb
	kLhTRuRjKtBUlinHyFtM5CLDZkfJCeXieSzP+IkwyUIjdEIP8vqBH2ydvKjDD6Bu7obbhNmU7wP
	jiA==
X-Google-Smtp-Source: AGHT+IG+qln5bQT2mE9wIX8K89bRFDCyEmW+N27eenT0Mz+MKpFiGEtyXe0L5xsEE6EDOAbOFijYhxLGLw==
X-Received: from wmbhe13.prod.google.com ([2002:a05:600c:540d:b0:43c:ef7b:ffac])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:19cb:b0:43c:ee3f:2c3
 with SMTP id 5b1f17b1804b1-4562e37a0ecmr26916265e9.7.1752679499601; Wed, 16
 Jul 2025 08:24:59 -0700 (PDT)
Date: Wed, 16 Jul 2025 17:23:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716152448.3877201-1-elver@google.com>
Subject: [PATCH] kasan: use vmalloc_dump_obj() for vmalloc error reports
From: Marco Elver <elver@google.com>
To: elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Yeoreum Yun <yeoreum.yun@arm.com>, 
	Yunseong Kim <ysk@kzalloc.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Since 6ee9b3d84775 ("kasan: remove kasan_find_vm_area() to prevent
possible deadlock"), more detailed info about the vmalloc mapping and
the origin was dropped due to potential deadlocks.

While fixing the deadlock is necessary, that patch was too quick in
killing an otherwise useful feature, and did no due-diligence in
understanding if an alternative option is available.

Restore printing more helpful vmalloc allocation info in KASAN reports
with the help of vmalloc_dump_obj(). Example report:

| BUG: KASAN: vmalloc-out-of-bounds in vmalloc_oob+0x4c9/0x610
| Read of size 1 at addr ffffc900002fd7f3 by task kunit_try_catch/493
|
| CPU: [...]
| Call Trace:
|  <TASK>
|  dump_stack_lvl+0xa8/0xf0
|  print_report+0x17e/0x810
|  kasan_report+0x155/0x190
|  vmalloc_oob+0x4c9/0x610
|  [...]
|
| The buggy address belongs to a 1-page vmalloc region starting at 0xffffc900002fd000 allocated at vmalloc_oob+0x36/0x610
| The buggy address belongs to the physical page:
| page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x126364
| flags: 0x200000000000000(node=0|zone=2)
| raw: 0200000000000000 0000000000000000 dead000000000122 0000000000000000
| raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
| page dumped because: kasan: bad access detected
|
| [..]

Fixes: 6ee9b3d84775 ("kasan: remove kasan_find_vm_area() to prevent possible deadlock")
Suggested-by: Uladzislau Rezki <urezki@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Yunseong Kim <ysk@kzalloc.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
---
 mm/kasan/report.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index b0877035491f..62c01b4527eb 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -399,7 +399,9 @@ static void print_address_description(void *addr, u8 tag,
 	}
 
 	if (is_vmalloc_addr(addr)) {
-		pr_err("The buggy address %px belongs to a vmalloc virtual mapping\n", addr);
+		pr_err("The buggy address belongs to a");
+		if (!vmalloc_dump_obj(addr))
+			pr_cont(" vmalloc virtual mapping\n");
 		page = vmalloc_to_page(addr);
 	}
 
-- 
2.50.0.727.gbf7dc18ff4-goog


