Return-Path: <linux-kernel+bounces-844832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC63BC2DEF
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 00:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D59CC4E6D31
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 22:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1D5258EEE;
	Tue,  7 Oct 2025 22:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XCsEC90h"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7E3223DFF
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 22:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759876262; cv=none; b=V/UNqQd4dqm3ad4HkP3+zcktkw5Xb4VXLMq71FRKhnou1VVY7UDJFJ0JQd8k1h/HF00efWmSnNju4YpPTVqxHRsJ09z8Xu+ysjWq5jGcmo8wkYJGbD/Em4h5sgHa1o131RR44nMnCs8tu8r5u42pjnbTmgID+Z2/ifnayFK0qlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759876262; c=relaxed/simple;
	bh=4GT0JYNNJp14TRPJ4IvCKX0AbERFj6fjij123PiuZCU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=X5IPCgtKTWoTY49knS8pOltfQf4S3Kw32IgmfUSf5tA1J4rUaxGxBTA7sc0ltNjw+uDA1mjEpXeuWx7gWReAOukbJM87CzwWgV8abe/UGJhE0AXXm48ZIN19VMuaWhHWXg50tyY946ZZntteusKFeGvxCQ2f9jtFVtquCyo0N+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XCsEC90h; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33428befd39so12972841a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 15:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759876260; x=1760481060; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XLTm89EnGL1d4GeiOqB4ADSUI4cSZa52RKpOynTWFCs=;
        b=XCsEC90hyt5faeCqtdbMbnACPPjJ8NRaK6b2hwLBUx8HVcO2OqW1rNRSExKEIDemKq
         lrn7/0FLbinf7FMgdITW1tmikdkMCaA57OuD6EumWQK1atZyO7H6Co41PwlmUFwaZq3z
         fD/ty0ctca4ivOnD/EHDcpCL/9MAYjGwgjXqEBp/wpLWdQyjBzEoF7XYUtE3inPkU1Xs
         oLWM/bzmjklFlQG3F+QjjCCo8hbQp1rcQ1A52wdgnwgIFFNaUsu+pyXKX5aKGv3l0I3g
         eHlABotl9Lpwser8+nr6wj5Q1WMQHaDxqB879/Gg9Q8zz9eSatk1VT71RBQA/qvMXb4G
         LhiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759876260; x=1760481060;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XLTm89EnGL1d4GeiOqB4ADSUI4cSZa52RKpOynTWFCs=;
        b=d0CCV3BcUezeFWxewfi8v1v6mI4hkYydUQu18xSIb8oNxp3zi5l+npG/8LVwCOckyV
         yFXgyQhzapTMnvNYcwWSYbFG5VdY0ILwTriQI1IhgKC6AypgnUOFH4u9aWoHoBjiWxtL
         2g3ZURTTn3pz6OIoN5UjMmNwSDLiRU2KeJl0Ve1zr0IrM8Pwzs8obA4CZDdiSbBpB1Q1
         l+3CMMCjzjRXrtTD6r3HJf75mruhBEfLJygctliCEUEc8rrewcf9q+WLTCltza23oLcq
         KobxbSFtwzNd/ff2GWfwD716+pJ67LZX2+xPibw+1SA+mbPTZ7Ax5bjHVMUcGg8091uw
         WUIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFqEoYSNn31d1iaEeGA5xdlazwkp0evq4hfPvZR1Z5rAcVfylA8qSo/YvtmKePMeKww7LjvsPQ75lu5Fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmvI06iVi3Mq5usj86/dF9+IcjeVD5X4HTtWlgi/k5lD20jvzJ
	MfwBKbKKPubGDUwC5qGFmtZ7HMd1FY08LNQXEYLpgSdVgcQPZdDCSHK9kb9DN0UnsZI5mjhMK2a
	JrDT6xQ==
X-Google-Smtp-Source: AGHT+IH345XfJXRLuhB0inzBYMubD5YL6ItH+xqRKBgb5PyGlTNXy+8Upl1a25C0vbAJVvpSEh6+FBGfB7w=
X-Received: from pjbmn8.prod.google.com ([2002:a17:90b:1888:b0:332:8389:c569])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a06:b0:32e:dd8c:dd2a
 with SMTP id 98e67ed59e1d1-33b50f2c758mr1420134a91.0.1759876259731; Tue, 07
 Oct 2025 15:30:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  7 Oct 2025 15:30:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Message-ID: <20251007223057.368082-1-seanjc@google.com>
Subject: [PATCH] KVM: selftests: Forcefully override ARCH from x86_64 to x86
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Forcefully override ARCH from x86_64 to x86 to handle the scenario where
the user specifies ARCH=x86_64 on the command line.

Fixes: 9af04539d474 ("KVM: selftests: Override ARCH for x86_64 instead of using ARCH_DIR")
Cc: stable@vger.kernel.org
Reported-by: David Matlack <dmatlack@google.com>
Closes: https://lore.kernel.org/all/20250724213130.3374922-1-dmatlack@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index d9fffe06d3ea..f2b223072b62 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -6,7 +6,7 @@ ARCH            ?= $(SUBARCH)
 ifeq ($(ARCH),$(filter $(ARCH),arm64 s390 riscv x86 x86_64 loongarch))
 # Top-level selftests allows ARCH=x86_64 :-(
 ifeq ($(ARCH),x86_64)
-	ARCH := x86
+	override ARCH := x86
 endif
 include Makefile.kvm
 else

base-commit: a6ad54137af92535cfe32e19e5f3bc1bb7dbd383
-- 
2.51.0.710.ga91ca5db03-goog


