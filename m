Return-Path: <linux-kernel+bounces-825250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F190DB8B6C5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 23:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEC591CC2699
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA502D47ED;
	Fri, 19 Sep 2025 21:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yt+1fqLV"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC641917ED
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 21:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758319178; cv=none; b=jwV9Q74EPTrDE48Hpw2GvhCkGgfIIrWcEgGyGvzX21kcyPB9CWZhbVmKrRw7tTEq5z/W95+7C7RDFCb2exLRDJhl0EQqG7zeOSiJgIK7CTL/mk2oaBUE0kjD6DDUGEjW6hylYomlNTdn6OLNFagziNUjGOOcBg2e7TFGuIR091Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758319178; c=relaxed/simple;
	bh=hdHEcj+4G3mposoaDzjUkQ2FaAvL0jUydJXuAbQVk4Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HNHjExGe9HxN6GzphOWIH0rmDSHG6/up7o6GUx9k9At5nd/4gBfN4mgcDEuUR1VTnWVaUN6rpjXpWGvOLge6UV+fog9SePc9U6H2KGjbTX02BKJgoahUjxzTU59wNawgS3Fk1F13S97jjFE2lkWmw7qYLmNwxsiTugsnwWvwDXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yt+1fqLV; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2eb787f2so2706893b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758319176; x=1758923976; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLrHMziNYHud1FXXl+dtzIQae0Vcklfo1b9pYdhz2/U=;
        b=Yt+1fqLVuU3364zLTy8REXwF6WY6KJId4CR7m7KNCDFttT12XmokDlAAa+7XubW637
         yIfgRc3HHUNJTiIU7n30WHkm4DcqJP6goAx00g80rTkxx3NqI4T0SE+Tr3NC76zWlFOI
         wYpLGCxoDKpQp7zMv3whPduLyS6Dj7wBhJRQdsyRE0m8EAEDfSKh+h1xIvdx3MLC41TK
         lZpKn8MbfXMqIBb2sEBFOP5QUZJ0YBaIR8Tq435bCaGgLU4J+wb0kJbr7drLOnPeaRtA
         6du3zETBQLZF9o/Bc1X3isft2F1KDdh+mfJnLso34niBtgjJm+/f201zG2+dRfiFNDy/
         2ihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758319176; x=1758923976;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FLrHMziNYHud1FXXl+dtzIQae0Vcklfo1b9pYdhz2/U=;
        b=MfQm6HcPH/sZbvcHftZ4XI1Nht2wr2j75Dz/ESPZ6pWNU9gGp6tZNc5irEkhRg3NTn
         KadRI2NXrU3XT7E/hBIGBq+IUNx75xP8gi2JiJJwkqRFlEWUEVDweNGcwI31im+AnZSC
         IBJwfG3bYjBDqwU8W5nwcrOc0WtkUFghPVWRtKwzbswAB6YYSlaq3hgfcT6PyHDYNN7D
         fFZ6qB4cuL2sf88RnGutskd+T85b9xdzCcm+4TdCXjYTRyvDwPdyJy8WPDLMHPeQ3iSv
         TYft7GGhxyNE+N13iHLVGaozwmbvNRFOjsW7r6bi0DCro9K84lAr+i4JYZX/e0v+user
         l5Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVYdEhdJDeL1o9IT6SUca9aVHa6OKs5YF+/w2F/gUw69fdndkbEiWu8dGCk6gka0KFY3MoJ6vS2aIIz0CA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8z6P08ZHkStIub7w6PUPtkY8DoObuLKRptdbJrF+rNbgQ0bxJ
	O4C25eFy25QVtPZHrzEtZO2/qPHMmyBIdB+iGuvyKae/qdMczlgM6lyO99/xzqYoi6gONmrUzfo
	CObgzQw==
X-Google-Smtp-Source: AGHT+IFKqJBbRMgHHL1TgxE5s+YonDT0guhnmE0Mw0KVOHt5n8O1EJ2Z0F7P2arsEHNwHOTl59hd7z2XlwA=
X-Received: from pji15.prod.google.com ([2002:a17:90b:3fcf:b0:32d:df7e:66c2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3c90:b0:263:767c:28df
 with SMTP id adf61e73a8af0-2925c369f8dmr6927947637.11.1758319176515; Fri, 19
 Sep 2025 14:59:36 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Sep 2025 14:59:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919215934.1590410-1-seanjc@google.com>
Subject: [PATCH v4 0/7] KVM: SVM: Enable AVIC for Zen4+ (if x2AVIC)
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Enable AVIC by default for Zen4+, so long as x2AVIC is supported (which should
be the case if AVIC is supported).

v4:
 - Collect tags. [Naveen]
 - Add missing "(AMD)" for Naveen's attribution. [Naveen]
 - Make svm_x86_ops globally visible, to match TDX, instead of passing in
   the struct as parameter to avic_hardware_setup(). [Naveen]
 - s/avic_want_avic_enabled/avic_want_enabled. [Naveen]
 - Print "AVIC enabled" in avic_harware_setup() so that it's close to the
   "x2AVIC enabled" message. [Naveen]

v3: https://lore.kernel.org/all/owztdzclln5pmgsuxgzt54vneiejtngdkujaebr7r35zx3f4lj@xvvhwvumkkha
 - Don't advise the user to enable force_avic. [Naveen]
 - Gather AVIC related module params in avic.c (by moving code/helpers to
   avic.c).
 - Print "AVIC enabled" even when it's forced.
 - Enable by default iff x2AVIC is supported.
 - Use "auto" to select KVM's automatic/default behavior.

v2: https://lore.kernel.org/all/cover.1756993734.git.naveen@kernel.org

v1: http://lkml.kernel.org/r/20250626145122.2228258-1-naveen@kernel.org

Naveen N Rao (AMD) (1):
  KVM: SVM: Enable AVIC by default for Zen4+ if x2AVIC is support

Sean Christopherson (6):
  KVM: SVM: Make svm_x86_ops globally visible, clean up on-HyperV usage
  KVM: SVM: Move x2AVIC MSR interception helper to avic.c
  KVM: SVM: Update "APICv in x2APIC without x2AVIC" in avic.c, not svm.c
  KVM: SVM: Always print "AVIC enabled" separately, even when force
    enabled
  KVM: SVM: Don't advise the user to do force_avic=y (when x2AVIC is
    detected)
  KVM: SVM: Move global "avic" variable to avic.c

 arch/x86/kvm/svm/avic.c         | 151 ++++++++++++++++++++++++++------
 arch/x86/kvm/svm/svm.c          |  64 +-------------
 arch/x86/kvm/svm/svm.h          |   6 +-
 arch/x86/kvm/svm/svm_onhyperv.c |  28 +++++-
 arch/x86/kvm/svm/svm_onhyperv.h |  31 +------
 5 files changed, 158 insertions(+), 122 deletions(-)


base-commit: c8fbf7ceb2ae3f64b0c377c8c21f6df577a13eb4
-- 
2.51.0.470.ga7dc726c21-goog


