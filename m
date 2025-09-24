Return-Path: <linux-kernel+bounces-830879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D19B9AC58
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82A022A256B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA4D30C0E7;
	Wed, 24 Sep 2025 15:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DXFQWeow"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B193D1E1C02
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758729206; cv=none; b=hl0c4EecJFPcS6YNdUy+2SJRd/+NJSo9ny4wYSTN42UkiHCGwgOOtfKIn+T8dChZDcaZETSTAK88WPuFJopuahG8c2bw32WICE5RjzIACKN9jGcIJhtZ2Mope0g2Goj/Wt8kHrYDkKqkbO5+YMTEJmmSbIGZb4bjFmB1dwwddhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758729206; c=relaxed/simple;
	bh=mBoQGC/qXP1Y+NF80xUNHpJo5vRdP+mJgOjnYpe6+Iw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=e+sMJ+rOs6XjksPfxK4xqbPqn+icDAdWRYN/D+aucdLwbZkjbPA6nV9BtLzuBZahKpUWuk59Gc4mNoKiAxoO/MWLRpfNJr4e5pLkI6eyUP+brETD8XighYgH97gHV8cSlfNtvYy8bVqe5rXVYKUfQZUbZTqrPNkAo+E3ZRt6ASQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DXFQWeow; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45b98de0e34so66437535e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758729203; x=1759334003; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PpOiZGlYE3bG9q2hQGWV/CtT41/1DXHMadQBXshkUnc=;
        b=DXFQWeowsQAFGuo+Sz/3x3TCLy68zPBxBN0hfWOO67A1Yf1oPtsKPtQeKBUoO1pM5t
         imLZ70nBVZouE1dBTwKp9JLdxqC8e9Ea22+rsUQdBrSl4aO3bEkWQEwDbgjcqjFa2Gy1
         XRJkS7UjifYbHV4e8wkCJYvsqM8J14mD0KgDMTsdGJQCoDDF2HzGKZHQ/SjjXBT9Zs7M
         ptKTIWv6ifSP7VB1glpou3WPB8BwWai6mBnzXRBxI1alyy5I0P+VfV5RwKaudTNcU7uk
         XBLSCyqk8qXSSyhGKVK1pQka4hIDq2ssCNgsqgDmf46cQJ7poOaqfYAkHmYLVwEdewk/
         zkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758729203; x=1759334003;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PpOiZGlYE3bG9q2hQGWV/CtT41/1DXHMadQBXshkUnc=;
        b=XIAKeYmVR9STL1ezPbhBI7BJLUbe+GXSlrcb5ef+WcPhHhyGWm1AAcL8dMQTGU4ZGu
         mZ7uFd+eFMZpJXvRbILAXE5f82rYy4WlE6let2d/78CnzJBJ/jxSB3JW7SufiDODdbL7
         t7uoUZ6jQKDeoRU19JO9M3+4PWMNFG0S1FvDnVlS9S7hjP3NwisZzgd46Ve3flKWvd9N
         mFKDntqunqjy2sBwwBOKBfYjQ8PZC4VpDYhXFVDY1aAWUEGQSFIjxn+dx4SaANtToUVQ
         rdxJDJymnsqntfea9YzjGHLNiwvKbpOVXdO4X9A+SRTW2U+iFDmH5PNXfVe0LuLsGIRC
         eJvQ==
X-Gm-Message-State: AOJu0YwpTvkA3VH9De/9BsU969HeOnPzi/iV1WOg7m1qh//DJvg+EV/X
	2OfZ4xCl+jGPDwUsVSmhvYBSnDRhda74Z3cnVxckot/te1r3otyBzCW8t5xehlUrRdM+g/DWZEr
	O9XyIzSsHeaULEp34SRkTPYoXq7lv0WypvM9Y0aPUval9QFjBQuLRuFbxKeiKHgrVPP7tNckvqv
	VNsWpA/zK0iEZg8I/+oaF7HVw55N/VG7D3tA==
X-Google-Smtp-Source: AGHT+IFfPC69nJQmM0EaCdCuvjkNEWDtxTJ/DiC4Tbx8uFpp9Ug4KJ82Ypgqe4+1EDO4+qGaEJryGoNV
X-Received: from wmrn44.prod.google.com ([2002:a05:600c:502c:b0:45f:28dd:87d9])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1d16:b0:45d:f7cb:70f4
 with SMTP id 5b1f17b1804b1-46e329bca25mr3557535e9.13.1758729202942; Wed, 24
 Sep 2025 08:53:22 -0700 (PDT)
Date: Wed, 24 Sep 2025 17:53:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1160; i=ardb@kernel.org;
 h=from:subject; bh=xBv0NEkS9CmLCfSe1qsDoIEcFYWUDrlFjBEC/h4Q8GM=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeOK8PP2bS+63u1vyjD+t57ng2ntvg+CPUpJ3pdum33zL
 Hl8Iy6uo5SFQYyLQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzkqjrDb5b/VrJqO5ZHb1TX
 dQ3vXhe2V05g3YkW90c658NPeVo2djP895sdOsOiRTvRhD0hOW2t7KWiz8I3CjjcOfZwHXkunXa cGwA=
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250924155310.3341370-2-ardb+git@google.com>
Subject: [PATCH] x86/boot: Drop erroneous __init annotation from early_set_pages_state()
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, "Aithal, Srikanth" <sraithal@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Ashish Kalra <Ashish.Kalra@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The kexec code will call set_pages_state() after tearing down all the
GHCBs, which will therefore result in a call to early_set_pages_state().

This means the __init annotation is wrong, and must be dropped.

Fixes: faed658ce71d ("x86/boot: Move startup code out of __head section")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
Cc: Borislav Petkov <bp@alien8.de>
Cc: "Aithal, Srikanth" <sraithal@amd.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>

 arch/x86/boot/startup/sev-startup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index 39465a0ff4e5..c4c389f7cd06 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -44,7 +44,7 @@
 /* Include code shared with pre-decompression boot stage */
 #include "sev-shared.c"
 
-void __init
+void
 early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 		      unsigned long npages, const struct psc_desc *desc)
 {
-- 
2.51.0.534.gc79095c0ca-goog


