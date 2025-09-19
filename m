Return-Path: <linux-kernel+bounces-825293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DF7B8B86E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4998FB62396
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425BB2D7D41;
	Fri, 19 Sep 2025 22:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LRwzIf3Y"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9912D73BC
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 22:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758321226; cv=none; b=u0CQp2jtpcMZQIItHmo3D0bRL4zxKRtBiOu1gpJd6dDzijVktRd97yjibSwrffUL3SMh5GlpPAhxv1h5uu6E6Pxk6D2CnKLhQxPuXPDyuXKnYN79I5U4NQqR8WqNAlnBDDGG7x7lFCbt5ZQIWBSqIQSCCETUhFw4xStm2lmUM6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758321226; c=relaxed/simple;
	bh=1g+suQtn60veXfeytSPxGzA9zEex48KEjHyupko4/EE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HMsWe4NyZ/sCRR6yUc50r16XyAPXtVx4p9cUO0n6D2b7vVngb/M/wo3Fd8hlOhYSOof5Z7JjZwTIxDIvW6fUQZ6eczOO8I6Y/uG/8qXo34658pUBMwtoZoxmu2hc+Ha6TiYpXigk+cWSWlZJjCca03D7cQAS0T0AB+up7m22jUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LRwzIf3Y; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77ecac44d33so891307b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758321224; x=1758926024; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Fx9hg+85vjiGkpy9V7/uhZK1m1ipmBfIS5//YWebLXI=;
        b=LRwzIf3Y9yR9ElzLHd2dFdY2bAmouRnEJRQfuy3ro6tx04tm5fo1qsXdK/kbEvkH25
         F2qTRP/BuCQi3LvT78OKgNOfdCcKM8KhDA7ZlX1F63LEHycL5H8Wht1pd3wYJy02C1re
         nixelWzgWqP/YvxMjg+brC1NBaPkqfO+c0GXnYRno4P82v0foEkx7q2chFl8cjQLIfFo
         eAtSutDEDlmMNDjRqerYvppPbTbibhtrvRIBUV/KUsRPG57V30K0lY3mat0N4cbwF5/9
         mGnvkyvbUM9ydS1bWpt469uiouneqrBca7Vuif1Bx38pgg3CAI8vPIu4RVffZsFNnG3F
         qYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758321224; x=1758926024;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fx9hg+85vjiGkpy9V7/uhZK1m1ipmBfIS5//YWebLXI=;
        b=aCRYYLRa3HNr2CNaGA7SJtsNwt2qjX1U0Awku2Jq7AHU2segUd7v/VuVeB7r4Lae0E
         eq/NHvhWVnBKvdgua9ZHi98wx22AlF7/jCIMJeS32KWt0oDwyCqfgOTDnvZaVC6ZLA7m
         A9rFk8INZcxmTTWii51NrbVJuwl1tdD0eHNIqCHCJ3WP5UamCy7J4YUC9Lcd8FCIaAnH
         /SmOa81rix3AotpWBW4ZKAAWwcMq5+imboCZeQB2uIn5YZWozVi+kZbTtPioEiaBoW5Z
         1p0SGk6pi8nrNl3uco3AHXDgqSgGNvXMYcNabapuIRViNIQY/F0rszTM0H5DIn+97q1y
         Rmzw==
X-Forwarded-Encrypted: i=1; AJvYcCWaUUU/a7874Xnr1PyudKl20fwuP/0dyxiLrMEW3jXYlJWQG9Qz5fwTI4bzei0tD94Iq0MdCCvCt7OIfJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlOZq3R78L7I6Tg+x/2dPRmsamuUi9wqws64MTI/+KDbP2jsJc
	ajd30xbJW3nM+TvZuuFlhPbVtkbm/P/RRCjV7qstmu532B0Q1KCvRdGUrNavpntmPeX0qHY/imp
	wGq3OlA==
X-Google-Smtp-Source: AGHT+IEhZFpddRJqAtv3ixHm1tklJi/Tv5LlRaFO2FnSMxXxfU+E3oTG1YYf+oq6xBsrKCc/j4UqdgAp1jE=
X-Received: from pjj4.prod.google.com ([2002:a17:90b:5544:b0:327:d54a:8c93])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2589:b0:261:f6d2:e733
 with SMTP id adf61e73a8af0-2925bace0f5mr7496586637.16.1758321224632; Fri, 19
 Sep 2025 15:33:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Sep 2025 15:32:29 -0700
In-Reply-To: <20250919223258.1604852-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919223258.1604852-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919223258.1604852-23-seanjc@google.com>
Subject: [PATCH v16 22/51] KVM: x86/mmu: Pretty print PK, SS, and SGX flags in
 MMU tracepoints
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Zhang Yi Z <yi.z.zhang@linux.intel.com>, Xin Li <xin@zytor.com>
Content-Type: text/plain; charset="UTF-8"

Add PK (Protection Keys), SS (Shadow Stacks), and SGX (Software Guard
Extensions) to the set of #PF error flags handled via
kvm_mmu_trace_pferr_flags.  While KVM doesn't expect PK or SS #PFs in
particular, pretty print their names instead of the raw hex value saves
the user from having to go spelunking in the SDM to figure out what's
going on.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmutrace.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmutrace.h b/arch/x86/kvm/mmu/mmutrace.h
index f35a830ce469..764e3015d021 100644
--- a/arch/x86/kvm/mmu/mmutrace.h
+++ b/arch/x86/kvm/mmu/mmutrace.h
@@ -51,6 +51,9 @@
 	{ PFERR_PRESENT_MASK, "P" },	\
 	{ PFERR_WRITE_MASK, "W" },	\
 	{ PFERR_USER_MASK, "U" },	\
+	{ PFERR_PK_MASK, "PK" },	\
+	{ PFERR_SS_MASK, "SS" },	\
+	{ PFERR_SGX_MASK, "SGX" },	\
 	{ PFERR_RSVD_MASK, "RSVD" },	\
 	{ PFERR_FETCH_MASK, "F" }
 
-- 
2.51.0.470.ga7dc726c21-goog


