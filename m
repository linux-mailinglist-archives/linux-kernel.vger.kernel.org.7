Return-Path: <linux-kernel+bounces-748616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1433B143B4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 23:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DD5418C010C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 21:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3280223DF5;
	Mon, 28 Jul 2025 21:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="suABp97N"
Received: from mail-ot1-f73.google.com (mail-ot1-f73.google.com [209.85.210.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A321E21B908
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 21:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753736861; cv=none; b=GvFDUetp5ypkycW0FmiubXsgo/WUNXjYx1yaIGoREe4DLJ0tOgE+DRpf9pkD+SVboAIfuPg6qjxUCkTW/MUuAZkN6kZVaII3DwaW2LtgETVoQSxYvPWfsBIOYGwfzAysRLyCYwHu1nprfHnelohvTuhwRm4cFMdUly4Sisc4Dd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753736861; c=relaxed/simple;
	bh=VYvyAPR2rjDj8OeNJRruAu8npV1N/RHzlGka234BYnk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YroORqpy4rpb9wIrE3cdhO0wMO1b3PGqihVJbGI3AJRn63EZrLwjM2z5GUgwW1SgF2fxJonSRTnd0KChtz/MQSdmlt175oPcKRBH1K8CjaR8f6ifKZAFKm0vDfP8RxKlUlXD2RBOzhVqkX/SPoIPeZjBhSlY5gh78GNHwmvESkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=suABp97N; arc=none smtp.client-ip=209.85.210.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-ot1-f73.google.com with SMTP id 46e09a7af769-73d04d16ab0so4400707a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 14:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753736859; x=1754341659; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=slHkTPTO23OubaoGcLALPC4EFvq2t1/SJARmRLWq8ek=;
        b=suABp97NeIJi0fuJT+qtxwB4W13bTKt/Xv+Q6weIAuEeXFhZQBP9GKNDyXlcBTZcVx
         0T69skjxnKQ/GA/OCkOqyKkEaCzYzMvEXKyTv4rPPSugC6sNZG/id8z6ih8SYszP7lNw
         UOKmbdLH6SSwBLeIume+TVRSanAW/ra3gcdKw78a2jF7bSbVylmRWuekv/+G/1n24Z+3
         CfgUXTAyV2WHrzFNNjnTnASHVbBH9Fsfc4Zs8APtylALmrCQ/lPjapGF23XDn9DFHg4J
         dfAX8e4sPyAPy8LkMgHCtY6qLsARDL76739le3d4w03iaWTU83bikwoFO5u07wS7KRqN
         iVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753736859; x=1754341659;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=slHkTPTO23OubaoGcLALPC4EFvq2t1/SJARmRLWq8ek=;
        b=A5pTRgxNmlRPqzWha9eXwx4K8nmfp0WiD2pZIgQMuctu5HyeBr1xhA3ua++BdjDPYs
         FRvnLK79z+degviFO3dP288rr5VOXv6t0Y6OYtSLc3pvRdI0Cd9SgFpG+KTA20srSVHw
         QP4v58VGh/tQfwruqxqiny2Vyz2l1rqCk+/uo4Ed0CrJMj0ELqgmf3islYdBMUC7S35/
         reu+/z7sH1ptUu9Ya0h5lRGCc7LhKpsb6qYz9r4PTa/mY2ZCFtNcGbYJpPjiffbaCGRZ
         0DWiJ3e9n65chhhA8/BeYpSGLebVo2pjhl1iPFxklZxMsTlpUxKpb+tipRZTR8y5pvib
         2esw==
X-Forwarded-Encrypted: i=1; AJvYcCXOVNcRJyt9cth6ZOFA+EGaBmoxK5J3QQ3nbddz5H2ywaHTcQ6F+/+2GiXRSXnWNPFTP4uBJWAGG4cjLv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YykFACr7bpPeJx68x4HNUIG+C8qbWXLcvCp6HAewYzDjxC8YHQu
	zQtnAUnBowmXoTBPWxbbVKG+NF4tuS5uJ6ngaKl6+dn3F6qbV/uIAzdrIYn+4IUope0Qh6pJm/+
	kKlxFv3mqd3PZhyOvfWHQvoyMqg==
X-Google-Smtp-Source: AGHT+IE47Z4A3+D9s5HwxzIu2gGt99OXTdaSbCqZ0hKtmsL0LHdSzeDVlhRw2PjDnFeNQYwtxQNiod7Q3hr1gALGAw==
X-Received: from otbca17.prod.google.com ([2002:a05:6830:6111:b0:73c:b634:7b70])
 (user=justinstitt job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6830:2641:b0:741:5d00:e86a with SMTP id 46e09a7af769-7415d00e9efmr3612294a34.8.1753736858551;
 Mon, 28 Jul 2025 14:07:38 -0700 (PDT)
Date: Mon, 28 Jul 2025 14:07:36 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJfmh2gC/x3MQQqDQAxA0atI1o04EdtpryJdjBo1UKaSTFtFv
 HsHV5+3+TsYq7DBo9hB+Ssm75jhLgX0c4gTowzZQBU11Y08Wgrdi3EQO/uJknBJir+gEcm7kdl TU997yItFeZT13LdwLV25wfM4/t3NQ751AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753736857; l=1926;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=VYvyAPR2rjDj8OeNJRruAu8npV1N/RHzlGka234BYnk=; b=HlGzpA+TYc3ck5X9eKZ/5YyDluZ21Hq1Gvc/SoBUkfkiAD8EgpqAOtMwdmCUD0dG6UEsL7Jja
 ZVx2abnVmotBHZV+zPnLise4jybp/uEsKfEPTnW+S6eenOBCzZVTrLu
X-Mailer: b4 0.12.3
Message-ID: <20250728-stable-disable-unit-ptr-warn-v1-1-958be9b66520@google.com>
Subject: [PATCH 6.1.y] KVM: arm64: sys_regs: disable -Wuninitialized-const-pointer
 warning
From: Justin Stitt <justinstitt@google.com>
To: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

A new warning in Clang 22 [1] complains that @clidr passed to
get_clidr_el1() is an uninitialized const pointer. get_clidr_el1()
doesn't really care since it casts away the const-ness anyways -- it is
a false positive.

|  ../arch/arm64/kvm/sys_regs.c:2978:23: warning: variable 'clidr' is uninitialized when passed as a const pointer argument here [-Wuninitialized-const-pointer]
|   2978 |         get_clidr_el1(NULL, &clidr); /* Ugly... */
|        |                              ^~~~~

Disable this warning for sys_regs.o with an iron fist as it doesn't make
sense to waste maintainer's time or potentially break builds by
backporting large changelists from 6.2+.

This patch isn't needed for anything past 6.1 as this code section was
reworked in Commit 7af0c2534f4c ("KVM: arm64: Normalize cache
configuration").

Cc: stable@vger.kernel.org
Fixes: 7c8c5e6a9101e ("arm64: KVM: system register handling")
Link: https://github.com/llvm/llvm-project/commit/00dacf8c22f065cb52efb14cd091d441f19b319e [1]
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
I've sent a similar patch for 5.15.
---
 arch/arm64/kvm/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 5e33c2d4645a..5fdb5331bfad 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -24,6 +24,9 @@ kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
 
 kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu.o
 
+# Work around a false positive Clang 22 -Wuninitialized-const-pointer warning
+CFLAGS_sys_regs.o := $(call cc-disable-warning, uninitialized-const-pointer)
+
 always-y := hyp_constants.h hyp-constants.s
 
 define rule_gen_hyp_constants

---
base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
change-id: 20250728-stable-disable-unit-ptr-warn-281fee82539c

Best regards,
--
Justin Stitt <justinstitt@google.com>


