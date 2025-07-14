Return-Path: <linux-kernel+bounces-729535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9395CB0380E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED3723B04BD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 07:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777A722F16E;
	Mon, 14 Jul 2025 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dZE2CDVI"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FC92594
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752478462; cv=none; b=i2XFPIKHKTmVZRqLo+0HUXjYSpZYpUawxp+CadWqI44BWk3yxqMjvlF1HRaX9eZPuDyIT0nLeG1PeSy7q+9m1yFcbgD6tZt2Hta4Z2jUt/+GBoB9JyYmkdQ0RuX4QdZyHFqh6n28SCSK+wKw42giQissD3ZkOpI1PLrdiEeeTio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752478462; c=relaxed/simple;
	bh=M/vdbqRDN4i1VxagKddWMXRxUQByDoM+LwEgHb4flB0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GbZNhtIf2l0cmx+vyn7V+9VTXa1qAwuXNAg+9mBBe3QxerZGaKhXOv8y1HqcSpDcASj1WYmIy7uBcDKBGUUh5yHAOW+XY0lYSlsrEa3SxkF8d4CwaCtslCvlsSNFUmQQyQrBSNEw++1xdnckNR0RIKxricrL5w2R10vz3hT4j60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dZE2CDVI; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-456175dba68so6517305e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 00:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752478460; x=1753083260; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bo0a5QSkGHyDzAGlJ0bIXiDhnlGQxUSjr/aH2Gjdvas=;
        b=dZE2CDVIwMLu3Y4W4kUwsx+EBfUO1tuObcaPP1srYBPbOQ7vhSxA3iWWCdb2tULlVb
         WORmwTb0YMevQMvSOobf5BC9KK3pY2aUiZic6oAZBtAa6He4HvNOE+CjYjygMqVj5TIH
         X8z+PCvJTtSzAlkxzZTOevogzHVpt3hBqZW5+pYbikdGh57tCgxwL3a+utOxzdhlKYb5
         qIpl/vuL/27IjnAbSAPPUylwJud5iAk7wZaVt6X8QbXG2g4PjawiMBqv9NgdYitzHcSf
         edlj1Ro97dZfy02Oq2n5BxauxnKUjecHFeE1jM5Gdf8yi1P/HkU52fLOtDeVAne0BL9D
         Z0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752478460; x=1753083260;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bo0a5QSkGHyDzAGlJ0bIXiDhnlGQxUSjr/aH2Gjdvas=;
        b=CMY6XBrhk93SBb7ANntNe1Uqi03WuRZ6y84pn33k7DRPTky4x3cCWrbE5FbQqGg132
         VZIYEP0qgBYRJVYL7Swmz8MUo5YmF+tG6yild3t4+NXQHws7Zx7rpzUQIVqUKeGUbksb
         4ZEw7fgovQVS1lZlubHLmih2MvbaD0WuDXAKtKPpTBsF9+7y6R9Cm9XWzpviJwrnhpNB
         MhYvt7Pn6m5RhJGRD/YFMAJdv2YJrl7GWKkACycc4qiPQanFeLEu2mjlS5Ldaxdi+/FF
         T2WyQZi/ODDYUWDEkx0Yx7cL/VpDnJvyDxjC+GDdxIu3XLP4TRVnnI50gVjb2MDfIXEd
         ecgQ==
X-Gm-Message-State: AOJu0YzwhlRtPJ9O5TJqQ5SESW9gzov0c59QSPHXl+aLA1Tt7+kYJNm3
	yrQtuR51sXQIPK9flvyXs6jvsOL/X7AqNZD1fziT3jlEeFbtU8vIwmZaMlt/P8Iex8XhRnlbIrv
	RqRwecLgxmtv9V7lADUMNa+JZgI/JMSUCAlkwSzNknKN1hq5fIRQ3CjZsWzKAZKj30D2H7oIdgX
	IkX4J8flQWaH+oNEM8ar02rJvJ9rTOpma9Pg==
X-Google-Smtp-Source: AGHT+IFdQ4FjOoXbpH35yd7yMmAampwHu7BxMZn2ie4vVPoKNi0Q+pWhqO9nCf7TIbcX4K9P9uowq/Jz
X-Received: from wmbfp14.prod.google.com ([2002:a05:600c:698e:b0:451:d768:b11d])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4590:b0:456:1f09:6846
 with SMTP id 5b1f17b1804b1-4561f096a84mr7109505e9.25.1752478459727; Mon, 14
 Jul 2025 00:34:19 -0700 (PDT)
Date: Mon, 14 Jul 2025 09:34:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1186; i=ardb@kernel.org;
 h=from:subject; bh=2o1K02Epo4PwAK6jFJ1cHgvXPXgf9m3z/Q5tcOmWLbE=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaNk09ury12sN8kIOBxSviYi6b/YyYxp8YLL3Vqu0emar
 gltB/I7SlkYxLgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwET6yhn+8OzpKn2uWsSr4S3z
 b3NmsUNCbFBLiqPMnUdLF5qHrrT4zfC/rFVqo0XSTYXd7XXafBtP6mccXRJ2+On7NXZ8i+7qrl7 OAwA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714073402.4107091-2-ardb+git@google.com>
Subject: [PATCH] x86/sev: Work around broken noinstr on GCC
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Forcibly disable KCSAN for the sev-nmi.c source file, which only
contains functions annotated as 'noinstr' but is emitted with calls to
KCSAN instrumentation nonetheless. E.g.,

  vmlinux.o: error: objtool: __sev_es_nmi_complete+0x58: call to __kcsan_check_access() leaves .noinstr.text section
  make[2]: *** [/usr/local/google/home/ardb/linux/scripts/Makefile.vmlinux_o:72: vmlinux.o] Error 1

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/coco/sev/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/coco/sev/Makefile b/arch/x86/coco/sev/Makefile
index db3255b979bd..342d79f0ab6a 100644
--- a/arch/x86/coco/sev/Makefile
+++ b/arch/x86/coco/sev/Makefile
@@ -5,5 +5,6 @@ obj-y += core.o sev-nmi.o vc-handle.o
 # Clang 14 and older may fail to respect __no_sanitize_undefined when inlining
 UBSAN_SANITIZE_sev-nmi.o	:= n
 
-# GCC may fail to respect __no_sanitize_address when inlining
+# GCC may fail to respect __no_sanitize_address or __no_kcsan when inlining
 KASAN_SANITIZE_sev-nmi.o	:= n
+KCSAN_SANITIZE_sev-nmi.o	:= n
-- 
2.50.0.727.gbf7dc18ff4-goog


