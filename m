Return-Path: <linux-kernel+bounces-825255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAEEB8B6EB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F4CEA0700F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE272DAFDF;
	Fri, 19 Sep 2025 21:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I59G7LgF"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C142B2D9798
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 21:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758319187; cv=none; b=inP3sq2G3S31EGnRhqLP5jzJy8kz1K3HPa9dkAtQ54b27gciKoN/IJ3f1MylNrW/AHFL39Qbzr8/cREOajUj78kCen2aXtLFufXZHf6VEPVbg4U2i8CF43yGrF/YKiGbOAD/uVUxe8gl0dBFnqfNkUlrurgMFzAajrM4kdRQGZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758319187; c=relaxed/simple;
	bh=LQi9xZFZpomwVS1kvlserOTepF/O5+6tFGi9AO/emJ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WQdI4q15wDAB8Im/8Y/Mr4W6HPFIxMqB4iXwD8Bp/hY7tdANzd2wBy7MjZ/4QtGv3aWF2t/P63/2HLtktZnjKAWjxOhHNBp1r/ee/jDcW3sMMB6eRhLrmyNfl8YbWHp8sw1QnWmaagx0q+trgyel1jBhKmo29NC2JG11sUomSRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I59G7LgF; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32ec67fcb88so2282976a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758319185; x=1758923985; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=pqISDS/kdSq21LbwitCJHTGhR/0duoOZRffbBWrHzYo=;
        b=I59G7LgFSU217vy7Q41SZ5WV0+mkclH6BODGm/U+GgJjk0YVe8hVlDwv6KHFWi0mkp
         jOAr6HufxfbEq+1GRkvjvD1WkuQrF+OQHRcVCaPb6huKKaxY9eTU8QVsKjSPuZqnjV28
         MJUskguXy6YZIGDnU+YxOP5IqckE9L0IQUemqiW7/8bA5W0BPgdwZ5f4ez4cEFOwH05K
         AZ9nBr8UVjqztlx8BqMppAT0iGH72wPZID2i/c8fZuowSUGGo+G4XAqtGx2tHJii/JP3
         7RQzbC75v7qz+c7CwidIjAXwWSeXq2ocHl2lM9GIxqE9zSBbbXsBweqb9CTFvRDhO7L0
         xf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758319185; x=1758923985;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pqISDS/kdSq21LbwitCJHTGhR/0duoOZRffbBWrHzYo=;
        b=PX+olSM1iuFK85Tv/dkjI13G4BwoPSPIJZafxRFp7mTeVdVsRyQAoB5GO3QZEKkCn+
         0c1GzpOzGZOo8I42f/4hiA7ANgmkEVRqDMezoHRUf1SMXVEI4MeS/THp08r1ZUq3Ogny
         hsa0CIc1UNV7B4JCElXgiqAsxa2GzAWl7qQpfI0jVp8dAd2lrod31pG29sIQZrQkGMH6
         Pr/YHXrKD5ip8CeFDRE0HxLSbf4M7mJ9MHi82/EOBrCSJSYADGrPlaa0roSwSp5kst8w
         VBU3LvZ7OiX8XUZ4ZLAow1INusmzNd1EwujJShFlqPAhXgit3s1cJDNUhgg+NWLnnPHV
         xX0g==
X-Forwarded-Encrypted: i=1; AJvYcCWokVyqCi7fWfxZMtpag39voYqHtu//SO0YH+FKKdDoy95nei0gpaPGRP1CTdlb4d0N0LcDeNIyX/YzKqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKw6FZeSyG9QWVnMBa/SZHv5HQw+OCaRc8PaJpShMchr5d+QJQ
	MfoAmb6qsxrGB8qXHeBgFS2Sza8hyjD65pKvAf1kh+0bim3vYi2QOOCZylLqHRpVKoDzLW1tPEh
	cBx0/wQ==
X-Google-Smtp-Source: AGHT+IHPoIDEaEZaUDlf/9uaqIxYyi54zNnK1cgCZ3hFN7LH8DrptV6OdXw09GIMUxInl+VeFAjptl7+3nA=
X-Received: from pjbsy5.prod.google.com ([2002:a17:90b:2d05:b0:329:f232:dac7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2c8f:b0:32f:98da:c397
 with SMTP id 98e67ed59e1d1-3309834b504mr5751177a91.24.1758319185101; Fri, 19
 Sep 2025 14:59:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Sep 2025 14:59:32 -0700
In-Reply-To: <20250919215934.1590410-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919215934.1590410-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919215934.1590410-6-seanjc@google.com>
Subject: [PATCH v4 5/7] KVM: SVM: Don't advise the user to do force_avic=y
 (when x2AVIC is detected)
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Don't advise the end user to try to force enable AVIC when x2AVIC is
reported as supported in CPUID, as forcefully enabling AVIC isn't something
that should be done lightly.  E.g. some Zen4 client systems hide AVIC but
leave x2AVIC behind, and while such a configuration is indeed due to buggy
firmware in the sense the reporting x2AVIC without AVIC is nonsensical,
KVM has no idea _why_ firmware disabled AVIC in the first place.

Suggesting that the user try to run with force_avic=y is sketchy even if
the user explicitly tries to enable AVIC, and will be downright
irresponsible once KVM starts enabling AVIC by default.  Alternatively,
KVM could print the message only when the user explicitly asks for AVIC,
but running with force_avic=y isn't something that should be encouraged
for random users.  force_avic is a useful knob for developers and perhaps
even advanced users, but isn't something that KVM should advertise broadly.

Opportunistically append a newline to the pr_warn() so that it prints out
immediately, and tweak the message to say that AVIC is unsupported instead
of disabled (disabled suggests that the kernel/KVM is somehow responsible).

Suggested-by: Naveen N Rao (AMD) <naveen@kernel.org>
Reviewed-by: Naveen N Rao (AMD) <naveen@kernel.org>
Tested-by: Naveen N Rao (AMD) <naveen@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index b8b73c4103c6..35dde7d89f56 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -1154,10 +1154,8 @@ bool __init avic_hardware_setup(void)
 
 	/* AVIC is a prerequisite for x2AVIC. */
 	if (!boot_cpu_has(X86_FEATURE_AVIC) && !force_avic) {
-		if (boot_cpu_has(X86_FEATURE_X2AVIC)) {
-			pr_warn(FW_BUG "Cannot support x2AVIC due to AVIC is disabled");
-			pr_warn(FW_BUG "Try enable AVIC using force_avic option");
-		}
+		if (boot_cpu_has(X86_FEATURE_X2AVIC))
+			pr_warn(FW_BUG "Cannot enable x2AVIC, AVIC is unsupported\n");
 		return false;
 	}
 
-- 
2.51.0.470.ga7dc726c21-goog


