Return-Path: <linux-kernel+bounces-834355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C36BA484F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5219D3BAFA7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4508D2253A0;
	Fri, 26 Sep 2025 15:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A/PCaOZ2"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50F31D6195
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758902323; cv=none; b=ZKW2/tXXFx+RqDlE9xlT5T88aTFM6FPTh8F1LUeCKtvKit5PX3mZM7qh200TbmNC7nviW8w61T6oiZ7B9j0Eidb0mcMfWtUmFiGlY6pWERxnp2w9gZ5AyJ0GrAeOYlMaQVM8XbaVP92nKVtso33H8OZmN9D2ZgBXVHgLe9Iyftc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758902323; c=relaxed/simple;
	bh=ioYNFXSk4x7Lrdjvrdmcd3nR6XgAOSJkZ5hhpjugXk8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=R29JzPcprFg6B8yPYByrtV8i1Zy4Rtgaz/U7AmJlYdfEq4mfEstTvKDwt2zGPRGp5HGKEuf/vDBPv8pJyktDAUEunJvw24d57ny25Jh5c/hdVxvrmr43dUZcxs7Y65cc1ciDK7k2Nuw6b0PuJa9RJGJoTdOjylVP6VbmWvcw+4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A/PCaOZ2; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32e09eaf85dso2978338a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758902321; x=1759507121; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5K8UK2MsZZPVLL6gVUiO47uURDGeEw8rDgtDDz0bOs=;
        b=A/PCaOZ2WX9Wp33dgLh/pdznBfpdfN621R4FSg1FykmjShALeAZdN99wtGanoKMNcL
         d6sQDQUXeWgv+z+WGGZXn3pAjGRBDQeJG+2qy7fuzaCvRQtbCHUPEHhUimO2oSp03Mfb
         JwBp4OXlTtBOizXd+Fkbr947jjBaeHZn5oHEuaNHgkBBb/Cd1+69mWnD53Pzbsdsbwiz
         6cpwwrFRjbjyx5bPRUkzSAAxbtnHRRyZZGvPDbHgrmf6nI54lw7KdfuguBG0xmTARapx
         DaGol8kzJnE8W9/+umXQg3VFa45VXn2IHZLrV1THXB3TkC8BWRDeWrbgMXdW+K0eCfha
         emLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758902321; x=1759507121;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L5K8UK2MsZZPVLL6gVUiO47uURDGeEw8rDgtDDz0bOs=;
        b=ute+eOmZUVYUJvA/Y7LrwPBIhNHgH1r+za/an5oWYpJcp7bRUv2Eyd9PkFjMNLLbFB
         O084F2JC97WDC2I/dTTl8ZHvyVCDTMCF6Q3hH1A2OPRfQT040uIfGgegWQByMe9VpKSb
         NjWDSiduNoxBVRTpyO1j7Kk/sJwEc+xbioncqFFgxyol4GVmiQy09vAh2229mzdF6OlC
         M/4+yXmWR+RX2nEb1Pcxf0UgP+R/jeH7U0WmbZXaVVv/B5Oi2ud9vUF8VC+/jz8ywf9h
         oWsLcmisYq4fcDGNzD1Re3Hcv3RaWHr6RxGhOrY/Tt3ZAHXTquoXhf9sErLVn/Be4OiC
         +lqg==
X-Forwarded-Encrypted: i=1; AJvYcCW9YtJI26ta2D/RdoqYzUfN9qncLAH6kVfxlXEH04DQgebGInncbBgmYCHgLpwIKu5a3lSXaA1DzpHDfQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8ISTfehgTLeJTAI7dvwbSQQJfznnAWvpi4Dolp848vF+hvgIj
	OOPbCzdiAbvENmsXXdac3Bcral2qF7Wrd9W+KQILQ5NgUJcJFo5nhl4OkRBEgwktKtKGlfRluIT
	aEqFXfQ==
X-Google-Smtp-Source: AGHT+IFjpgSzA5Rlw7JbImpaC56pYTXgSa295k3g3PBWsimpHinIifwdOO6eH2ZwQpZ8/ysgQKAAB2w8fRA=
X-Received: from pjber8.prod.google.com ([2002:a17:90a:f6c8:b0:32b:6136:95b9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4f8f:b0:32b:8582:34be
 with SMTP id 98e67ed59e1d1-3342a261050mr7471559a91.13.1758902321029; Fri, 26
 Sep 2025 08:58:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Sep 2025 08:58:38 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250926155838.2612205-1-seanjc@google.com>
Subject: [PATCH] KVM: selftests: Track width of arm64's timer counter as
 "int", not "uint64_t"
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Sebastian Ott <sebott@redhat.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Store the width of arm64's timer counter as an "int", not a "uint64_t".
ilog2() returns an "int", and more importantly using what is an "unsigned
long" under the hood makes clang unhappy due to a type mismatch when
clamping the width to a sane value.

  arm64/arch_timer_edge_cases.c:1032:10: error: comparison of distinct pointer types
     ('typeof (width) *' (aka 'unsigned long *') and 'typeof (56) *' (aka 'int *'))
     [-Werror,-Wcompare-distinct-pointer-types]
   1032 |         width = clamp(width, 56, 64);
        |                 ^~~~~~~~~~~~~~~~~~~~
  tools/include/linux/kernel.h:47:45: note: expanded from macro 'clamp'
     47 | #define clamp(val, lo, hi)      min((typeof(val))max(val, lo), hi)
        |                                                  ^~~~~~~~~~~~
  tools/include/linux/kernel.h:33:17: note: expanded from macro 'max'
     33 |         (void) (&_max1 == &_max2);              \
        |                 ~~~~~~ ^  ~~~~~~
  tools/include/linux/kernel.h:39:9: note: expanded from macro 'min'
     39 |         typeof(x) _min1 = (x);                  \
        |                ^

Fixes: fad4cf944839 ("KVM: arm64: selftests: Determine effective counter width in arch_timer_edge_cases")
Cc: Sebastian Ott <sebott@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c b/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c
index ce74d069cb7b..38493c9cde83 100644
--- a/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c
+++ b/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c
@@ -1027,7 +1027,7 @@ static void set_counter_defaults(void)
 {
 	const uint64_t MIN_ROLLOVER_SECS = 40ULL * 365 * 24 * 3600;
 	uint64_t freq = read_sysreg(CNTFRQ_EL0);
-	uint64_t width = ilog2(MIN_ROLLOVER_SECS * freq);
+	int width = ilog2(MIN_ROLLOVER_SECS * freq);
 
 	width = clamp(width, 56, 64);
 	CVAL_MAX = GENMASK_ULL(width - 1, 0);

base-commit: a6ad54137af92535cfe32e19e5f3bc1bb7dbd383
-- 
2.51.0.536.g15c5d4f767-goog


