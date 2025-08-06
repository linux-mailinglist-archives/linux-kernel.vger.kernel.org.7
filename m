Return-Path: <linux-kernel+bounces-758414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9B7B1CEAA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 23:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA0A7174CD4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 21:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA25B23875D;
	Wed,  6 Aug 2025 21:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZXFodiD2"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BE5233152
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 21:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754517106; cv=none; b=OrXy0RgwPjpYcJSUc5Exsn4KliMAbUPjeWcNOS0YDgoEILaGAw/6q1tUOpYpEelgfpgSfrFVpAHvY+Ij0s+aYhiYm11HunNJxvTGDRRsF/wSdq/F1INM6xRE5ixTzR5uKZ/8fuo7wz2ZnKYApJSYf74JlzDUN8yFHaUeyTQ5/cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754517106; c=relaxed/simple;
	bh=ioGhk3xk84BoXwkcOPC/uTsbu3UVQYxlGhQBp62yXPQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oFQWHiUGkcgqD/UBAjgPdp9B2vdo2X1hjomGguv3CzT7x64TX3PYCvMZwQKSqFXp5EwVuK0Ks08RKX1hjGuIWRMjbsbqnLiZBTwUYrYWCkK5c7UEMSkIxeTOSgf7H+qBj4uwSVjmXxFVl4WcB0+yZTaDvJ8+MFvzqUlJ+/AYQR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZXFodiD2; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-242aa2e4887so7065825ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 14:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754517104; x=1755121904; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B4YJ+3jCatffCVLDpGjGjNQPin+iS8DfOQi6G+axJLM=;
        b=ZXFodiD28PmINu/pwign8ms5UTAjEXQ5/vegigDrLBdxKyDY2H1mybK4rcFtxIvTnw
         NdNLomjlM9LY1/NtckvlO2KX5/xPS6MJdO31Fg+Ffj6JuteG2UQStNUD632Rs82zB1zx
         tI96+w514z5xxuz6ytthpC4qdWybH+P3ksXWWGeV0Few+T6otbWENWQtp9ty/EjljKlW
         /Fl+o/SwgSLXSJtvW5He/4pdvfzKydsZ3x9rpGjj1cgHHKW1JCoheM3tuXPDwKoAmVju
         4xsQgWlkkOT7XEXpl7+tRTBPTYhoxZFtUgbh5MaQt0WyDImLwJLZF8oMzhuShYQicDTM
         DjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754517104; x=1755121904;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B4YJ+3jCatffCVLDpGjGjNQPin+iS8DfOQi6G+axJLM=;
        b=qlUg5L2CYahenG3+QyvVUbDwqi+5ZE5SYLsOBu4T3pjNA8kQKhV3kOV/wKNErvQ9+m
         k0LOknh2PTSZ+CffaU9I0S0JAWYNUII0stiv9oyB05jwDNsoIBu6wdd16DJ/n5YcthBM
         +dOgLkSV2Z02AwmEUBkTiNcuEcNwfgBJa7yHrOlnELpKNRE5HeywrCeFsH6qe+JYphTl
         vAeF3ABbtwvamZTbF2VhuzO9va4l1vBO6xaF01RI9AWoBjEWHMWN+XPGc5w4uJAntIxL
         Cwx7BOnOFUOaWtWmr7Rcn6f57MTGOSdOk5c0gyDWK+3OjaH+4zdnIikH8fHf8tM6FLXl
         O/dg==
X-Forwarded-Encrypted: i=1; AJvYcCUYj4KUnaiWCIF+IOWlV0yCHoFiO17d4KmRbhVub+7Oi/VF/06pLBBy9I3JqL3h0bdTk/80rDfOe6grb84=@vger.kernel.org
X-Gm-Message-State: AOJu0YypuRVBKtW6oZiDI3oI+KXw/Z58Y762w9GL12lb+u3WPIErNLik
	uWYKrU9xmVpZEYPCrDIslc1ZSn0Dry0nJWXYq/wYdF/6z0sG1CnG2z8LDvvGWw1WIiFkTtpSCS8
	Oaol0AmIte0NyvjIl9+60Og==
X-Google-Smtp-Source: AGHT+IEFHzjbTvF06Bn7ryEnz1G4fFcb0+2rb8vE4CxPsmdqrExCBZEQOrWh+mH7nhcPPrOgHcK/Y1pm7L5bNJ1t
X-Received: from pjbmf11.prod.google.com ([2002:a17:90b:184b:b0:312:1900:72e2])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:4b08:b0:240:80f:228e with SMTP id d9443c01a7336-242a0bc8d31mr52399045ad.52.1754517104106;
 Wed, 06 Aug 2025 14:51:44 -0700 (PDT)
Date: Wed,  6 Aug 2025 21:51:32 +0000
In-Reply-To: <20250806215133.43475-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806215133.43475-1-jthoughton@google.com>
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250806215133.43475-3-jthoughton@google.com>
Subject: [PATCH 2/2] Documentation: fault-injection: Add entries for KVM fault
 injection points
From: James Houghton <jthoughton@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, David Matlack <dmatlack@google.com>, 
	James Houghton <jthoughton@google.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

KVM now supports three fault injection points:
1. fail_kvm_mmu_invalidate_retry, for all architectures.
2. fail_tdp_mmu_cmpxchg, for x86 only.
3. fail_tdp_mmu_resched, for x86 only.

Provide basic documentation for them.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 Documentation/fault-injection/fault-injection.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/fault-injection/fault-injection.rst b/Documentation/fault-injection/fault-injection.rst
index c2d3996b5b407..da75c921d6c4d 100644
--- a/Documentation/fault-injection/fault-injection.rst
+++ b/Documentation/fault-injection/fault-injection.rst
@@ -87,6 +87,18 @@ Available fault injection capabilities
   inject init_hctx() errors by setting config items under
   /sys/kernel/config/nullb/<disk>/init_hctx_fault_inject.
 
+- fail_kvm_mmu_invalidate_retry
+
+  For KVM, injects fake MMU invalidations.
+
+- fail_tdp_mmu_cmpxchg
+
+  For KVM/x86, injects cmpxchg failures for TDP MMU SPTE updates.
+
+- fail_tdp_mmu_resched
+
+  For KVM/x86, injects fake MMU lock contention for TDP MMU SPTE iteration.
+
 Configure fault-injection capabilities behavior
 -----------------------------------------------
 
-- 
2.50.1.703.g449372360f-goog


