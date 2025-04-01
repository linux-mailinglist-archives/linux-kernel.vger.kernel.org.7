Return-Path: <linux-kernel+bounces-583857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DACF6A780BB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 18:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 669B87A2D18
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 16:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DC020E336;
	Tue,  1 Apr 2025 16:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2RV4GpZl"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E834720D502
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 16:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743525797; cv=none; b=pK3YRFu1qHUupc8IioiybcWNwK3z0MMNvneuVU4Ax4GEqMTn76AhYiCbB6fl/w4fWAGeZG9bvWP3EHeplrrsPOufCK5VZtA+TncGwQCxrpYpu0vcKMPBQd4Bwivltk7azWcPlcu7qHJtb1G0DNl9Mks0Q32ISi0EUSSbrfT28eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743525797; c=relaxed/simple;
	bh=IX2hIEFDZxr1s7mPt549rL+2MP5J40qc7gWfaob7z2I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SIeDx+HmqCNe6jOQXA8WeXRXbDEltBULpKqRM6l2Y+Ode6SBrJ3KW11bKxHQzNFrWZIErYWP3PTdvd3grl/XRfTbmHuKD7waaikz8ZyXUH810bXCs/1ZuHnl95t82bE934OVZRssdVPQ+lTw/xhjFITj2oMTPHwh3Br667dBsas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2RV4GpZl; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22651aca434so108953515ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Apr 2025 09:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743525795; x=1744130595; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=tjqTIWn86XObYZ0dlBWL1fKISTH8kVDuFqpN5liSeqY=;
        b=2RV4GpZlnot4SCQ5wABLNoj1h5/geg50gJV/aZ0WrLzGYB/VV3xhNfojzwmHO0uDYz
         g31k7XvWqBamA1iirpWdFwlIerGnukt8vXTN16dbap04aiQd38ioMrYWgU3kFFc5odti
         G3p58wvcGb0TWKOKcZh4W9l5+3syRSR1wYrrRMdvuji2Yn4VG1pIqMWInZnmw4M6Sezs
         7l2ZkZNNoe0TUoaH4AB6Ite60SMnnBmvXQgUhl2So3HEUiHXZv9jlhMmxdb3We6fpkHa
         8wqwkYjn53FsRSZfxI7C7rZRuTeCyd7KO4GJrlszzn9sFKa8uVGmvZKcdJaFMIDs46Ln
         Ejhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743525795; x=1744130595;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tjqTIWn86XObYZ0dlBWL1fKISTH8kVDuFqpN5liSeqY=;
        b=Ki/PHwKPXGBCrTToVzPBjQFsrOvRNPYJ0ouacuhs0Ph5x8dgBGAluNCaTeNdfRg1sJ
         RK3sY0Vo9+a2AV+wL3e2Bd4LpCx95rnwoFhLFHkqnuweFUUj/vzYf/Maxdoy1Z2snZNV
         Dql4TnUvR0tyMZ/+x2K9iUqFoBuDOoiABH7V4sGtbURWrQgGgQRwxnq7xLepAOUWOf/+
         cRJGs2kL+I/DG9y7f2i9+P8I2c3s114LauMRD0fy0m3neQUgrTBEGswnDmdYw6Pu3GXh
         Ve8xfr9nJ4TLXPVZpC7aPKhpYRteDPpTfePZzIOdAqVBRRH3UdwAkgeJZjn1gt7lVVX8
         4RpA==
X-Gm-Message-State: AOJu0YzRGyrbvkTfoKWSOSk9ZBX/8PyarjfWaeL9JNsumask1ZbvAY6E
	EBqLDWn+lsmNT00x7mDlPZbEseboX3vMjZEBj3Tx21pBA3g2L0joYqmewTJl3lCvzA64OvGHQZl
	kJA==
X-Google-Smtp-Source: AGHT+IF7k6V4hI9NSmqeQR7Ldpinq9z+9LeYTtWSOW3n7weH2d7MasMbpC1/xTtwiRZrQxL5X02TqjREFfU=
X-Received: from pfbhw8.prod.google.com ([2002:a05:6a00:8908:b0:730:7e2d:df69])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1309:b0:736:450c:fa54
 with SMTP id d2e1a72fcca58-7398036acbemr20074041b3a.6.1743525795261; Tue, 01
 Apr 2025 09:43:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  1 Apr 2025 09:34:40 -0700
In-Reply-To: <20250401163447.846608-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401163447.846608-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250401163447.846608-2-seanjc@google.com>
Subject: [PATCH v2 1/8] x86/irq: Ensure initial PIR loads are performed
 exactly once
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Ensure the PIR is read exactly once at the start of handle_pending_pir(),
to guarantee that checking for an outstanding posted interrupt in a given
chuck doesn't reload the chunk from the "real" PIR.  Functionally, a reload
is benign, but it would defeat the purpose of pre-loading into a copy.

Fixes: 1b03d82ba15e ("x86/irq: Install posted MSI notification handler")
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index feca4f20b06a..85fa2db38dc4 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -414,7 +414,7 @@ static __always_inline bool handle_pending_pir(u64 *pir, struct pt_regs *regs)
 	bool handled = false;
 
 	for (i = 0; i < 4; i++)
-		pir_copy[i] = pir[i];
+		pir_copy[i] = READ_ONCE(pir[i]);
 
 	for (i = 0; i < 4; i++) {
 		if (!pir_copy[i])
-- 
2.49.0.472.ge94155a9ec-goog


