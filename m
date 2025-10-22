Return-Path: <linux-kernel+bounces-866011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CBABFE98A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 01:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2171A07A23
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 23:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6B126B942;
	Wed, 22 Oct 2025 23:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qseaugHp"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8141A1E89C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 23:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761176272; cv=none; b=jGKK4xYqf2BacoA6sTG+lH8maDEnExhC3Ksg+BDtDkSyTWLO9KRd6pi23X9mLPQvmg9XyNjCYoxsfrmVlywgqU0qD38yOE5xZB9Zfky+1xLZ3ItYZ6xU7SR/Xr2U49flX85NzPT0b0F0mN+bv0ELin5QWZMlQDrJ2tRhu47NzGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761176272; c=relaxed/simple;
	bh=dsgpP46O4rf6g1M2YopAc+Pgd3OzPUxWx/EwsvCRtsM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Veek0KxZKUn+Ccho/quiHDNqjIRJl3E+GBiFre/8qWyE0gVLFA8Ip2A4LrhvwpnfLnjH04HQPdxBWBgofR8aIb7Wh76e/wWutV+G/qetJauwQwKJ7XXwPsPmFQ490kzr8GKSmXYWxiyHLkz1b5TgHE15GyJm2haYSaWHP1UgYzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qseaugHp; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b3cb0f2b217so16191566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761176269; x=1761781069; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pve6dtlNTy/+JCUf5PUVzdo5xT8e3BskNXN/KpcpiBM=;
        b=qseaugHpmdkTm9CHsZ16VojrpuAxp9Hz6EQuW+DWS73BbPSyXIZWM0qSjBaXKDveTs
         f7ddFVzl0FTGsGa/ezc/kkwMzoM/zIFZFr4Ph9yh+CNFHJBVOTfoD1xGKF45bUmpLvp/
         THtftJ+i7OgJOkx31udmKomunL4HaqanfyPQbREBLwhtDvgfiNP5r8BLCKFc6wALR34S
         e55CW4OomKe3IWRKLmWGq87/UnVljOB5mDhN3ZvtOv9FqV88l2Tbc9HcBEdUjqvh19gD
         0Y5lHaMwvKpZRgoxCgbhKza1BI+vnOsdY3b0RuNldRjE19GNlYvDbNHev5ofk5S+YR1o
         UXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761176269; x=1761781069;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pve6dtlNTy/+JCUf5PUVzdo5xT8e3BskNXN/KpcpiBM=;
        b=hKFlDYTyU0D5/aP7ILihSXrWcM9zQg8ZyBMM7W+wwb5qoNLpWaOOBIA2pfeQGe1MB2
         pgQFZvW11kYcx8NcUBQaCkzzWpL/cRkCP+0or8hmDb/BkuBwvhdjAe779a7z9IjOBxwD
         lE0HCgAtXNqw6AI9qLaJnf/zXK/N7zk5iNTm60KDEe0aLb++U5EPlyLTHHC6wgtdLtxn
         Rmu5NCDLmnUblnJ+PCR4SLXEuho0mj4ql0Gm5yb5OPk96CoADAHfDv4C9A2cXtiPlPFB
         fl5dxl1EGhvLjYAuq9d6sg9e7S70dap/N+GWSTagcB+JONUP7PsXN05/qL2/C5KEhcVm
         oU6g==
X-Forwarded-Encrypted: i=1; AJvYcCUdIurLar7Cj1an/u7PICWCrQnWFQHCKMetqU8FT9lqJlBM3bJYXVN6cmaAIS+dlzITA7vSAcwFARA9/VM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0IzRuS51aLUPxOCViNp1JLIRoarQWsBE/pKwB1l8KWairfBim
	dtb56pOx/93+fT74tyeIscPfNR7N97ZJKZGm4/MWfhHqQDNQ556qaOaCLP0XRwfawyLwvdVmhEv
	G9jP2OYmy2Wk1n2zRAaUZaw==
X-Google-Smtp-Source: AGHT+IGc68FSP/Nnk9kRexNBkRec8RrJZPhzzkD6TEGQkDOuX6zziLIkfRmQXQefDNc9H7h94EJ9DYD25RnPeYif
X-Received: from edbig7.prod.google.com ([2002:a05:6402:4587:b0:62f:af:6094])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:9625:b0:b3d:98fa:b3fe with SMTP id a640c23a62f3a-b6d51c50c8amr53147666b.63.1761176268777;
 Wed, 22 Oct 2025 16:37:48 -0700 (PDT)
Date: Thu, 23 Oct 2025 01:37:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.814.gb8fa24458f-goog
Message-ID: <20251022233743.1134103-1-mclapinski@google.com>
Subject: [PATCH v2 1/1] x86/boot/compressed: Fix avoiding memmap in physical KASLR
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
since the whole function would be called 5 times and the last `if`
would never trigger.

For the second input, the code would avoid the first 4 memmap regions
but not the last one (it could put the kernel there).

The new code disables physical KASLR for both of those inputs.

Signed-off-by: Michal Clapinski <mclapinski@google.com>
Suggested-by: Chris Li <chrisl@kernel.org>
Fixes: d52e7d5a952c ("x86/KASLR: Parse all 'memmap=' boot option entries")
---
The patch was suggested by Chris and I modified it a little without his
knowledge. I don't know which tags are appropriate.
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
2.51.1.814.gb8fa24458f-goog


