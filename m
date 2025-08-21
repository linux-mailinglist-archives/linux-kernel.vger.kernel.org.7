Return-Path: <linux-kernel+bounces-780734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D58D7B30888
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63B5E7B0D5C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDE22E173F;
	Thu, 21 Aug 2025 21:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y7LajL2k"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E4F2DFA21
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 21:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755812533; cv=none; b=LqjbgQBZRowx+38AZWbifs2EP7zSb5+B8Zlz69dapEOGMcVd4we3AuHXzEkf6MVwYVJF+kHgkZ2yzu4YeHvw+IYHVq4qQnJYMLUmyf0cJjItXL3JbP2TFrGjp+DavGJhfxO/PjNK1ZJCYR5Yz3vqm5ExtdC3DSoLQnTBok+wdcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755812533; c=relaxed/simple;
	bh=6d1NpiY6CNirwuB32iXKvxQgeJfaKGkzBRWT2zfaawI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JM6Ej/fdfqv88vV7mQlY/riSQnT05EYClDqZWJ3A6fhkqvzTPNYBYqbMn3vSymx18emfbLX5YtMmQ/kJk3Ap6rLnFknzy4kjwlKI4LWIYlThdoTZFBllZdzOeqcJzje/qhbYwd4dmiQAHqO4+jVSuO7RfimPh6l9xuKn4HIalTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y7LajL2k; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b47173ae6easo2265523a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755812532; x=1756417332; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGTtMfRs1p1LjrrRqCwfiI7lq7kQ7leeLunUyA5zoU8=;
        b=y7LajL2krZ8PI2jXkmu+5c1UJRQN9QUb6SiJunejVH9kHz8N/6sFIK+MeTp8deZbTO
         fOtBN/r3KErHfRlhKutvb0EoQesh8Um62KsRXb3lw0jAFPRB1WA0lmZ2Vl3N0MDerQwE
         /y7+YW37RyChzi1VJiqMdpYFuaJbC2s3uATki1Q5GYcah98PPctNALzO14iX0LGL1+OG
         8CnfPpPm4ouh6binYaOPynfHbKvJ2UK9iodSav0lX+MzqBanyRUErFVIXAfEcJYP0Jg1
         m/pBvSWsMW8f78qjfpcz+kvUSBaUD8G+JPXW86j1DWXhGvJEHuUXocFh8fX1VWEC1f+r
         1w6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755812532; x=1756417332;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RGTtMfRs1p1LjrrRqCwfiI7lq7kQ7leeLunUyA5zoU8=;
        b=Gq+CJQXEd5IjaMw7E/uDO6r0qPqpiF0VyMpbUIaELwTA7qkaY8BuVadKoK52xv7y8b
         k4BDCx+vb19Wab1dGg+rV8sqsJvqTNjO7QYhKF2Y8wMJ1ctgnKmuBKUx2ZKQpNyCMK27
         S44Ypr44Ky5lCO5UVcof9bouR27cQOMVQ5IALWLZ8BILcniYjbo/gvkY6Zhf0v7dcDDk
         8wyi5XzBi8oB95U5Uzkpxu6RRPlQwg3o5BiQJ3GdkOXHyYzIRiAu3xgEMfzEzdsK26zZ
         GtiwKx5D9D/GJq0/UlleOjeH4ZYtjmXqA3oPaFQupGFfbQyQB/0eNr1yWInE1gshFErI
         b7IA==
X-Forwarded-Encrypted: i=1; AJvYcCUnC3R7ximwTNI07lWyYyjo35hzZG1QTUia+q/fDfaYz5R4QNooVO/cc2rNoOkJ+HF5GOhXTN09U6ckRJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjB3EWwFRzSckExa8JG+IgS51vgQWt55AjEmf07+CKrzzXbhXY
	J/QasTCBW8Kx5QaQh/nit6l84VzHdRC3s3HiNKjkyZi8PYMhAivUQvbwoo5eiJ+RfTwXHOIEbKc
	EHK1AcA==
X-Google-Smtp-Source: AGHT+IEpQ1Sa00N5Sn1QccLk0FiJbYdI55Nqdbds78TD5OwaESH9bS6YdHtt687v4M01z1fED1O7DkwOTSA=
X-Received: from pjbsn7.prod.google.com ([2002:a17:90b:2e87:b0:312:dbc:f731])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1584:b0:240:cd6:a91e
 with SMTP id adf61e73a8af0-24340b0ed25mr1001848637.20.1755812531857; Thu, 21
 Aug 2025 14:42:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 21 Aug 2025 14:42:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250821214209.3463350-1-seanjc@google.com>
Subject: [PATCH 0/3] KVM: x86: Clean up lowest priority IRQ code
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Move some local APIC specific code into lapic.c that has no business being
exposed outside of local APIC emulation.   The lowest priority vector
hashing code in particular is *very* specific to lapic.c internals, but
that's not at all obvious from the globally-visible symbols.

Sean Christopherson (3):
  KVM: x86: Move kvm_irq_delivery_to_apic() from irq.c to lapic.c
  KVM: x86: Make "lowest priority" helpers local to lapic.c
  KVM: x86: Move vector_hashing into lapic.c

 arch/x86/kvm/irq.c   | 57 ------------------------------
 arch/x86/kvm/irq.h   |  4 ---
 arch/x86/kvm/lapic.c | 82 +++++++++++++++++++++++++++++++++++++++-----
 arch/x86/kvm/lapic.h | 12 ++-----
 arch/x86/kvm/x86.c   |  8 -----
 arch/x86/kvm/x86.h   |  1 -
 6 files changed, 77 insertions(+), 87 deletions(-)


base-commit: 9c7a1f8d8784e17bb6e0df4f616fbd8daae02919
-- 
2.51.0.261.g7ce5a0a67e-goog


