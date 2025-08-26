Return-Path: <linux-kernel+bounces-787288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC321B37419
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 22:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BDC41BA5705
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 20:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215002F99A5;
	Tue, 26 Aug 2025 20:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDwmr/dk"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF9E2D3A9E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 20:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756241793; cv=none; b=g5kARQ4gT2PAJo7slOurF6yo1fPdN2TKXY/uLjpMhvZoqVJ3Xir3dxTM7yjZDrIsrMUy3j1vriKhl3hvZfzvi77KJ3OQ2bae4UrKfDcIZM+1/zgxW/tUxUywryFCc0C3FSMxndKXhj/6D0dyqnDBpUlU/797C2WxSHFkm/Z9vhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756241793; c=relaxed/simple;
	bh=b/wlUMk4IKuAZ2GTwA8nDxHIbo2jrk1gE4wdCrMx7R4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCG9ei28Q+LSLVxhbIjQ19orKNeZKa/bNRS+8A3juCDSlNwwY+dx6umbVmkVUxP8IQOHQfAduxwVkxwxhguABZV+/GDIKREO93NpODNIAi+NNSdeVNSbT9coGrSgG1DSUls8y+WztVrgc8ZH6lmpaObEUd6BNqqkYjWHm2bW5Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDwmr/dk; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e2e6038cfso6892694b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756241791; x=1756846591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3RZecD6lOIXMEN4BMHwXQ5RekIY8XyyevlTW2TRt7g=;
        b=nDwmr/dkL6QDBsRQjdIJIKfJvIlPoqn8IwlQ3tewsEXr5FBDCgjpa5nH/8HWKY6H7B
         vXj8LixWm3L7AaVo/5+8bTFMmOHZ6OpOwRm6Q9wNVhU8C1SKusyBixX7cli8fme1I/EM
         LoAz3SQUoDZ5sA/qlYgIA73QYWv+oN1+obux/GFSTHgXRlfxWKfcLwd+NNr2y58rTy1X
         Qk9OFJVxHl8LVydFaHuci9MlF+c97K6pPEbN9gkxmP8HdL16QzLUgMNzM+TxR9KO4NXA
         5uMZ1I/acQOoXKbQsoO2xI0/bTZSFP6Azo/JBM115uvWFKYE01Q93l2MZDEOt/uLjmUz
         MgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756241791; x=1756846591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3RZecD6lOIXMEN4BMHwXQ5RekIY8XyyevlTW2TRt7g=;
        b=ExlHbKuVYAtcBBKr3VVT4vjKb2Y7zEaHJ0FlJGuicu+obF24HcuIUQP16GHPyIblmE
         F4MMXjTqAe5ZJFg9KsPvxM+LXXf5C0Q3mvfiX1iumyP3cBPzNHPYMA/Mz7myKY3Rx3Fj
         5mt9WBZO9UuW2juQKCtvuzq0DtO8rqJh2lSMBDFdLwdTuAeZtPF2apybok/emaM2DxBA
         JIR9Niu2SsVXpYo7cbFMyxbEoou09yxIWM50DuEBWp4QUe9qp38MwTCyIN8NabcfvVxw
         GQKsTDqh7SL67QHHRs0dX2vOOp6QKYe34xHIhRAn34V+jmEkAxZ3tN6vORLVQz3xkDv1
         ZxEw==
X-Gm-Message-State: AOJu0YzQ/rw0cFNUfTYTy03fnHWLL7euSELhkeLu1WyAer7wiIS3FgL5
	7TY+pqzpXxRWFP4vEGF1srkpNl2R1TQgNe2I+g27Kt6rMzmC5y7Y1zIK
X-Gm-Gg: ASbGncuQXPtv3ryNxeiBjg8J1so77YIouFxLr7V7Hxq/R2tOB8sNlSrrRz/z5mO32q4
	ot8KBCJPuDWbNT4JbWa5UjmUxFW3RWh6xJdVTloQpn+jeBbhPUg92nFyzGauOLZNvUmkdD05HPr
	kdL8nd5bKHby9+QnO3UeCiX1KMPjoJaucQKfZCqOy9FpdT1UiK52L1u2zzitWLoFddZFXuUNLHl
	+YrnpGo1lSuQqOIsmV3coIPzoaQc4XDlx674HMM/b0ewJxsTZKvz/y/qxHaddkLjvEjLdqyl+Mr
	7GGh+AbpaAl+gODgfxEoTvDRdH1QZTnuxbuC2ke5QYNnL+pZm8JtRN2CQim6QgpYIN+DQg+mRPM
	hxrA/4NXawYNCxTyDYpA5/mR6pk9SFaq/SZGgFDZJgVxnUzFMSoFZhA==
X-Google-Smtp-Source: AGHT+IFkbp2G3sEZhy+jI4BFP7keK5NV3wYCFzstA/KajI6AkUNi7BbF/X/7dqdbsObKoDZF8Sv3xg==
X-Received: by 2002:a17:903:32c7:b0:246:b47f:9b01 with SMTP id d9443c01a7336-246b47f9ee6mr129856455ad.17.1756241791330;
        Tue, 26 Aug 2025 13:56:31 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-771e814cbccsm5817935b3a.35.2025.08.26.13.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 13:56:30 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 3/7] x86: Stop calling page_address() in free_pages()
Date: Tue, 26 Aug 2025 13:56:13 -0700
Message-ID: <20250826205617.1032945-4-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250826205617.1032945-1-vishal.moola@gmail.com>
References: <20250826205617.1032945-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

free_pages() should be used when we only have a virtual address. We
should call __free_pages() directly on our page instead.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/x86/mm/init_64.c          | 2 +-
 arch/x86/platform/efi/memmap.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index b9426fce5f3e..0e4270e20fad 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1031,7 +1031,7 @@ static void __meminit free_pagetable(struct page *page, int order)
 		free_reserved_pages(page, nr_pages);
 #endif
 	} else {
-		free_pages((unsigned long)page_address(page), order);
+		__free_pages(page, order);
 	}
 }
 
diff --git a/arch/x86/platform/efi/memmap.c b/arch/x86/platform/efi/memmap.c
index 061b8ecc71a1..023697c88910 100644
--- a/arch/x86/platform/efi/memmap.c
+++ b/arch/x86/platform/efi/memmap.c
@@ -42,7 +42,7 @@ void __init __efi_memmap_free(u64 phys, unsigned long size, unsigned long flags)
 		struct page *p = pfn_to_page(PHYS_PFN(phys));
 		unsigned int order = get_order(size);
 
-		free_pages((unsigned long) page_address(p), order);
+		__free_pages(p, order);
 	}
 }
 
-- 
2.51.0


