Return-Path: <linux-kernel+bounces-897848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3A8C53BF5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CC066345CDB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DFC34C81B;
	Wed, 12 Nov 2025 17:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="olfkkNhZ"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BDA34AAF8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762969196; cv=none; b=qfkSXbzgeFdmt7HOCZ6fvd6X6RwIbvQXozLXPV41pyqF6fwwQizrVkE82jyoremiK5VziAykJ4DbeosPyhwazgoRAfPWqPxZ4BWw8IIpMR/F46AoqlhRgjUUC3dgFkjoSIYCX/IsaYBVGfWZ9m3583I4s+HKn7aAzJoNTr+JlQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762969196; c=relaxed/simple;
	bh=lbv7KBOnId+FabH1167dMbnJJpBWntZ2AQurHl0Ymh4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SbyB3CQcta3TuN34Tgk5PpjabM+eARlA6tG7DNgQo8ewHKFJx3Fo45Ay3Ay2SLkCmSWDU58FvAGsdwqH5X5VmIaMyfEdaC7hW/B1tMtgX1AfH5P0EDUh/ZwuPX/JIVzhWDBwkKpl78x4BcByen4fHHxpUABkETQ7Qc0rNUuI2C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=olfkkNhZ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-340ad9349b3so2230251a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762969192; x=1763573992; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=5TnDpCtdkW5EjfNm/WK8+BC1Q5HsHLmqdVi4Osqi6cA=;
        b=olfkkNhZWRcGazUd1JqEEuH+f1nLwKOQBE3vuPUpfH3w1y7gpdR8/nMJJSiSdhqfzr
         i1hS+OxkvMf9PVLS80WMN4uAGnXbA8BYySRXNqeMpYljUGSEQx02ikTVZZ4KGklkd4Wk
         O3bTjaRxv8/ZubCS4id0RXbw38eI2RX8KB9zG43dnUK10Oo+/UVAjqk0GrIK5D1PcbVq
         g6xqUF0veor+AQ1wn/s45vm4oJcjKq9KSYRoKGYrxXHgK6hR48CTtmn/KAnLSL3di5cK
         /VDXElIeCcPmKBpLMsmEPd9VsA7YUoPhmgZE1DnZJDRoLTFMxl0E5BTS7xKPJfJ/jdWx
         qHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762969192; x=1763573992;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5TnDpCtdkW5EjfNm/WK8+BC1Q5HsHLmqdVi4Osqi6cA=;
        b=h4Cn0znb2vsWbx9Gsxwbu2jijzXzUlFhUNkdrQpCsrlTegTSX4nDnCE9UHu1JUv06h
         MVr0rKwfQA/FT21VvNzWb8tIJTi2KHUVIpWV4nfTS0f+DBlgib4fx9l5pqUj6t/hwfh9
         Rn1TlkUB9nMnw32vckGP8OIg/+HXQbQabQi+4gweGuCjxn8bY2w/WqU10RM097yWKzn5
         HOnoX3yO8FYYqRW+fseoKI9l03Y+s2YOrjWdhrvb3qVa24Qsv9npRKvmLM+JJPgsvTo4
         KAClfly0maQPcJk2I8UGuUki8Dvs5vbs+UCLahQyQpte4cmm7+JYYB2v0cbBr4mXsmvp
         972Q==
X-Gm-Message-State: AOJu0YxFxJ18yjmCuESCvuLrD+Aob3SIHUhqMSKxobGxt79Um6ZVuGIR
	4u7a0wCAOslPfKg3N8KqeJn71mnflC8egUr/l1j/Bn5Dgqx6RO6UbI2tLjlfkCUlJCbKFD5n2qd
	O1GPkpA==
X-Google-Smtp-Source: AGHT+IHz/l05PZRgfyqRId2a6PpuZL13C+FOannHS5GzYwvPYmTtNXM3YC7Qpo5B6cCtNaEfJoKUfU9w7hc=
X-Received: from pjbeu11.prod.google.com ([2002:a17:90a:f94b:b0:338:3e6b:b835])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a91:b0:341:761c:3330
 with SMTP id 98e67ed59e1d1-343dde8addfmr4774092a91.23.1762969192338; Wed, 12
 Nov 2025 09:39:52 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 12 Nov 2025 09:39:43 -0800
In-Reply-To: <20251112173944.1380633-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112173944.1380633-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251112173944.1380633-4-seanjc@google.com>
Subject: [PATCH 3/4] x86/mm: Drop unnecessary export of "ptdump_walk_pgd_level_debugfs"
From: Sean Christopherson <seanjc@google.com>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Xin Li <xin@zytor.com>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>, 
	"Kirill A. Shutemov" <kas@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	kvm@vger.kernel.org, linux-sgx@vger.kernel.org, linux-coco@lists.linux.dev, 
	Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Don't export "ptdump_walk_pgd_level_debugfs" as its sole user is
arch/x86/mm/debug_pagetables.c, which can't be built as a module.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/mm/dump_pagetables.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index a4700ef6eb64..2afa7a23340e 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -486,7 +486,6 @@ void ptdump_walk_pgd_level_debugfs(struct seq_file *m, struct mm_struct *mm,
 #endif
 	ptdump_walk_pgd_level_core(m, mm, pgd, false, false);
 }
-EXPORT_SYMBOL_GPL(ptdump_walk_pgd_level_debugfs);
 
 void ptdump_walk_user_pgd_level_checkwx(void)
 {
-- 
2.51.2.1041.gc1ab5b90ca-goog


