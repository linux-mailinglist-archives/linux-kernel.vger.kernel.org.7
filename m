Return-Path: <linux-kernel+bounces-841549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B14D1BB7A16
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 18:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A25BB34059A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 16:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30622D63EF;
	Fri,  3 Oct 2025 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mQ0XLfbz"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5495C2D5C61
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 16:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759510639; cv=none; b=QxysK5ZKgUHPq9KYnX1AkDSUaPtR2TXEUWNjZCSpddjgfcm63bl/pXtTBByfIkrmcTRksl4yj2u6UaadymWto2IoW3E6753QmrRMeME+TEXfnS8qs0a5Ga3GkovFw+CcR290L96MYX8Ap9crCLZ2luNR++tRjGei+Wo0rKlklg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759510639; c=relaxed/simple;
	bh=g6Mm4TUgTDnV1BR6GzocDWK6ZMXTQJuChssLMTwZ4F8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mtM3AuFXY2YPwinEishg2L1A8JsxShi/8orWVlyuGd9hLjYtMGB0n9ged2dz74xX352YIUSPbSiefFaoCgfG/nfIkel4VS3moMSmqGr0z9ioamkEq8rUqMdL74qWneTlV51J9yhbPs62crKisT61JXGAx3DzBys9hvUPDzVclvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mQ0XLfbz; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e32eb4798so17232915e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 09:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759510635; x=1760115435; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mhn98EaAcLcg+nBixGVyZd4SWTCSm1c4d8hazGzt9BI=;
        b=mQ0XLfbz8GMV6ZKwIXL7+0JARFvxAFYkQ/gyemUZ7fTjmjoMjXORTZkVdSeasoqzx6
         zNQCfdO1bW0q3+lVQlzETdMgwYKBS6V+QuyuGefEJkZL69x4ERABJebzy4veTW4beouz
         ZZ5wdzbCfqK43a10J4GI055N2vfZVMbY/YR53ttsvQVuLkBfxVdB3ljhjWACEnhKu9vB
         CiY7wKdCLQSFMHrIj28e0kWOVBvCIk0p7LI2sIX7HeOlosV7RRYvsFjFACZAras2AeoT
         8s0oCfz1tMEFivfUNZ7hTAIJNYDi0ZGjep3hqgBEQwEXy1PGC7DiwTJ+DA0OAt2Z3K/e
         aEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759510635; x=1760115435;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mhn98EaAcLcg+nBixGVyZd4SWTCSm1c4d8hazGzt9BI=;
        b=vrPGWRNzAUjI5iPITX39NY5YomyjClNNs6xSoINaqfBpMPkebnLqFmx8Yl/9Z0Ft/y
         5PB0rjcIJiGVgzplzVz4EqDRUzliqih/X3BtzX/IVZLzQZY5yN8namKhs1B2N6xhEF+b
         NS+a8/84Ic4+9G+MjNS7SaEwyyaaj304s/ZQ5QGooqdIl1DbTpG54vldgIDOHKrKKeBx
         2JxVmim2tXGYO22G692M4yhYGAlfx8FVoS2SPQbeNi1mngPq+GWJ2PxPEry1bNeix3wY
         arT/tt0lTBE00iKwqExtkrQZKQS9RFLtFbueVCSeuxO9dyGfjEK2aZFo7Fb62cm7s3Jl
         jhkg==
X-Gm-Message-State: AOJu0YxISORu/FcZVEJW99lTEn7lqdQ4DYtSd4eiK540aXjqEcKAlk5T
	wHaAguH9i8Zq9VopxFBEuCn7tQDjLUktylUuEi2TFSNyV8ClAERVPG1w+5NEYPI968gJez/ZNHF
	F7UJBvZ1bXej/qA==
X-Google-Smtp-Source: AGHT+IGaveHbqK86ADiyFuvJw5XNDwZwRONz5lJqmAVx6TUk1DyQePdpi513vgqPwu4JGdvqaJDtAqD1V8+v/g==
X-Received: from wmfo21.prod.google.com ([2002:a05:600c:2e15:b0:46e:19f9:cfe9])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1e20:b0:46e:4912:d02a with SMTP id 5b1f17b1804b1-46e711640aamr22086405e9.23.1759510635664;
 Fri, 03 Oct 2025 09:57:15 -0700 (PDT)
Date: Fri, 03 Oct 2025 16:56:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEgA4GgC/x3MSwqAMAwA0atI1gZS/3oVcVFr1IBUaVWE4t0tL
 t9iJoBnJ+yhSwI4vsXLbiNUmoBZtV0YZYqGjLJSEeX4NBWKlRPNxtpeB5Ke6rJoFY3aQMwOx7M 8/7If3vcDq4webGIAAAA=
X-Change-Id: 20251003-x86-init-cleanup-0ad754910bac
X-Mailer: b4 0.14.2
Message-ID: <20251003-x86-init-cleanup-v1-0-f2b7994c2ad6@google.com>
Subject: [PATCH 0/4] x86/mm: some cleanups for pagetable setup code
From: Brendan Jackman <jackmanb@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

Per discussion in [0] I'm looking for ways to refactor this code to make
ASI easier to deal with. But, while looking, I found some little things
that seem like just straightforward cleanups without any real
refactoring needed. So let's start there.

The last two patches are closely related and could potentially be
squashed, but I've split it in two because the first half is trivial,
the second is more tricky and likely to be wrong.

This applies to tip/master.

[0] https://lore.kernel.org/all/20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com/T/#t

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
Brendan Jackman (4):
      x86/mm: delete disabled debug code
      x86/mm: harmonize return value of phys_pte_init()
      x86/mm: drop unused return from pgtable setup functions
      x86/mm: simplify calculation of max_pfn_mapped

 arch/x86/include/asm/pgtable.h |  3 +-
 arch/x86/mm/init.c             | 19 ++++----
 arch/x86/mm/init_32.c          |  5 +--
 arch/x86/mm/init_64.c          | 99 ++++++++++++++----------------------------
 arch/x86/mm/mm_internal.h      | 11 ++---
 5 files changed, 48 insertions(+), 89 deletions(-)
---
base-commit: 47870f1fa057a411519108f0833dd2603179234f
change-id: 20251003-x86-init-cleanup-0ad754910bac

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


