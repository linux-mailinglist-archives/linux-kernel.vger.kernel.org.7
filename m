Return-Path: <linux-kernel+bounces-767477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 451DAB254E4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D06C882FA6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805B62F28FC;
	Wed, 13 Aug 2025 21:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="ZqcxVeOg"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4252F9980
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755118810; cv=none; b=SSb5toNkkIDWdZzFZO62qTUFRrrOZmjsEQ/9tf0uJIBuisqfDN8S0AR0GdGRUwtjwygieXOu8y+fOITFGmjQNZ4vRkZM/l+WeSRJz4ctGsb5SMm/BSOaqCG1icBssvQsUugr2xlDslDOVX7W/684HourKzn3HLZl779QzW8mAz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755118810; c=relaxed/simple;
	bh=3c2a2skHRpE+mGqSPR/NEnu/8+vWFYIf/noO11bitU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qf83jToXZ4QT0P/rRc+OATpcWBBZG7ijSaKpGHvGmjBsWdHp9xf8Ig5iM9Ri9XbIv3AkpjVimkyV/FSeHfyWZoWB+gJCb6R8sqVo4/+qmOq4Iewl762ZFbaCopQ6z37Sh+Cz0KoYo34OIVJD2xNaiUp12Ht2gg/1tReiXydLpBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=ZqcxVeOg; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-32326793a85so312479a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 14:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1755118808; x=1755723608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5eLiIt9u895aiPm246tdxZtX0UgwU4Q0T4u/dRMEv9A=;
        b=ZqcxVeOgFIZdRPYkeAzxokyBwxgxCSv3YO0igm4dgR//UPqBZrzPrOegW2tH+A5fnj
         xfRNIn71WhRzC17qNLDdVGVkmhhkSMr8ox0JAdL1tpSKCGYoD+Jz6A24LZuRrCLrk0uW
         P/03FvrurD+CWRHOXGDb1NtTSaiY1rel/Zpw/kzELIdHt6qcZPblmE9TbaMVHoPkDFzX
         Qo+haRqC5o/iwu+lo8ZjOuacYzRhHT597M9IFln8cibozASVat6gfQMkJQimBU0dibDg
         4E2nEqY5xvLnl0+LDr0kGs1jlQBp/0bOJ/PB3b64TNr4yoGzj9QsGl/hV5UGVPWQqTfO
         WK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755118808; x=1755723608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5eLiIt9u895aiPm246tdxZtX0UgwU4Q0T4u/dRMEv9A=;
        b=seCVp8x54zhHVeKmipLOpJ1vUimNepbJ9PprY/uWY5OsVEuypdfAFJJ6VmeyWtE8F6
         EcvJJEYXKJxDcxTw0t8G2QJHfHYBb2iYO04uKuFK5wEzi6McKfsCoKuZ4aXyJu3rMCN7
         IMySTgmWPI3dNnDEHoFK2QI+JhkEStJ3f9A71CAoKroVwtxxyrDEO9SOLpi2VGPsrP/j
         DAug/3kQC4psr3x8F9B8Mkh+mpkev+ag4VK5Zt/Wg4mlJkUtq/V3NoarvuwjjTDd82bT
         GIRO+5QJMY6gd+3ESQsN1sr/gicc41WGf27CZJSnWvkGV7yl2ojIUrDg9/GYktEDz4AK
         Pm5A==
X-Forwarded-Encrypted: i=1; AJvYcCX5BwnZHQ+IIX87OCMh7wUEv17HrOEDr/ZNRKNcxVPoxzBwLaGZ7OC6iVCstVtL/B3pQ3Mv8DLeBehsLOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIzl5naeQTJhYOJqANfVEZRxnR89OtWK7VL9JuJeNINYjnxlAB
	TThYQmpcBQu1sMre9C5nlydnoxaHiUa/x48l60xlThDACBzQjw5iAOI66uo4fR0XY6Q=
X-Gm-Gg: ASbGncsM/b8CD3UvI1XXI4zBmVaamzlg31+mJio8DQZh7Jp6F3NRUsqiCjFE3lYUUNF
	pKhS41GGdR1ylqyMRsQb5HAE8hqxXzfyUe1VGw2tgb95ZP9IRyG28RASUsJ251myrVdocvJcop+
	cmMUEeXbiMKsnDLmpyRGWyj16oRGq7mx8Hk3c2aKRZHeVamIXEbmJr4qfb+bTa5sN/luDeaNWgQ
	RF1O2wkXcJZwKvLfJGjvjtCf/RYJJXPGMyIvuLEknai/6mSzUwgRk57s3VEzPUnQ2xSQRjOm9gt
	OjOgwP3t7a86GqbOM7Xn2tRvp5q7zIjVW3qUQ0ODYmojz4FXzavbQDAmi5gAbrZLkSGANhv+s7l
	ZOX3GbbicPS7Oj7+QruOxxPLQpEYye3u1BUNu+MfTrHLiWy8gbt2vh6xY15kAjAfrzVn4uZD1y5
	Nldst5lpFwFBFAgVlHtRuXNr7nsntTyLPitmLzHMY=
X-Google-Smtp-Source: AGHT+IEXJdeyuZrTaJf/ZC2UNbTT2svIrtVLyam9egGc2fXU0o9BYIyVhEPHIKqfaUK6duZ/rcdqXw==
X-Received: by 2002:a17:90b:58cf:b0:321:2b8a:430a with SMTP id 98e67ed59e1d1-32327b495f9mr872457a91.28.1755118808081;
        Wed, 13 Aug 2025 14:00:08 -0700 (PDT)
Received: from nuc.fritz.box (p200300faaf00da00c2a4b02ad8ab5b75.dip0.t-ipconnect.de. [2003:fa:af00:da00:c2a4:b02a:d8ab:5b75])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3232579deefsm950490a91.21.2025.08.13.14.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 14:00:07 -0700 (PDT)
From: Mathias Krause <minipli@grsecurity.net>
To: kvm@vger.kernel.org
Cc: Mathias Krause <minipli@grsecurity.net>,
	Chao Gao <chao.gao@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	pbonzini@redhat.com,
	dave.hansen@intel.com,
	rick.p.edgecombe@intel.com,
	mlevitsk@redhat.com,
	john.allen@amd.com,
	weijiang.yang@intel.com,
	xin@zytor.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3] KVM: VMX: Make CR4.CET a guest owned bit
Date: Wed, 13 Aug 2025 22:59:56 +0200
Message-ID: <20250813205957.14135-1-minipli@grsecurity.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make CR4.CET a guest-owned bit under VMX by extending
KVM_POSSIBLE_CR4_GUEST_BITS accordingly.

There's no need to intercept changes to CR4.CET, as it's neither
included in KVM's MMU role bits, nor does KVM specifically care about
the actual value of a (nested) guest's CR4.CET value, beside for
enforcing architectural constraints, i.e. make sure that CR0.WP=1 if
CR4.CET=1.

Intercepting writes to CR4.CET is particularly bad for grsecurity
kernels with KERNEXEC or, even worse, KERNSEAL enabled. These features
heavily make use of read-only kernel objects and use a cpu-local CR0.WP
toggle to override it, when needed. Under a CET-enabled kernel, this
also requires toggling CR4.CET, hence the motivation to make it
guest-owned.

Using the old test from [1] gives the following runtime numbers (perf
stat -r 5 ssdd 10 50000):

* grsec guest on linux-6.16-rc5 + cet patches:
  2.4647 +- 0.0706 seconds time elapsed  ( +-  2.86% )

* grsec guest on linux-6.16-rc5 + cet patches + CR4.CET guest-owned:
  1.5648 +- 0.0240 seconds time elapsed  ( +-  1.53% )

Not only does not intercepting CR4.CET make the test run ~35% faster,
it's also more stable with less fluctuation due to fewer VMEXITs.

Therefore, make CR4.CET a guest-owned bit where possible.

This change is VMX-specific, as SVM has no such fine-grained control
register intercept control.

If KVM's assumptions regarding MMU role handling wrt. a guest's CR4.CET
value ever change, the BUILD_BUG_ON()s related to KVM_MMU_CR4_ROLE_BITS
and KVM_POSSIBLE_CR4_GUEST_BITS will catch that early.

Link: https://lore.kernel.org/kvm/20230322013731.102955-1-minipli@grsecurity.net/ [1]
Reviewed-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Mathias Krause <minipli@grsecurity.net>
---
This patch needs to go on top of Chao's KVM+CET series:
https://lore.kernel.org/kvm/20250812025606.74625-1-chao.gao@intel.com/

v3:
- reword changelog slightly to match style
- pick up Reviewed-by from Chao Gao

v2:
- provide motivation and performance numbers

 arch/x86/kvm/kvm_cache_regs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/kvm_cache_regs.h b/arch/x86/kvm/kvm_cache_regs.h
index 36a8786db291..8ddb01191d6f 100644
--- a/arch/x86/kvm/kvm_cache_regs.h
+++ b/arch/x86/kvm/kvm_cache_regs.h
@@ -7,7 +7,8 @@
 #define KVM_POSSIBLE_CR0_GUEST_BITS	(X86_CR0_TS | X86_CR0_WP)
 #define KVM_POSSIBLE_CR4_GUEST_BITS				  \
 	(X86_CR4_PVI | X86_CR4_DE | X86_CR4_PCE | X86_CR4_OSFXSR  \
-	 | X86_CR4_OSXMMEXCPT | X86_CR4_PGE | X86_CR4_TSD | X86_CR4_FSGSBASE)
+	 | X86_CR4_OSXMMEXCPT | X86_CR4_PGE | X86_CR4_TSD | X86_CR4_FSGSBASE \
+	 | X86_CR4_CET)
 
 #define X86_CR0_PDPTR_BITS    (X86_CR0_CD | X86_CR0_NW | X86_CR0_PG)
 #define X86_CR4_TLBFLUSH_BITS (X86_CR4_PGE | X86_CR4_PCIDE | X86_CR4_PAE | X86_CR4_SMEP)
-- 
2.50.1


