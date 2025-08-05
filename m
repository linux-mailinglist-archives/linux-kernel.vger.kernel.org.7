Return-Path: <linux-kernel+bounces-756883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C77B1BAB0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 21:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7B5718A787C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF9829ACF5;
	Tue,  5 Aug 2025 19:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Do8gQd6"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63932BF00E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 19:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754420759; cv=none; b=piIShSHXI+YaedU3oZIbAqcVMPw7dLvUPBkz8xuji74DdVeeeKhUSlrjQsIWY69oiUzLXJ9/M0oXi+HKJD8t/JdrzpTq9o8EcU90yEi2bCMptsnETwMy4dpHyaORYLrYUtG3N4QM6KkmHnFiMomxjxhQmYIYpAUvJTPWL2p+YD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754420759; c=relaxed/simple;
	bh=/sPXmM0Zs1fLp6muGCf+tjOXJkyB32siq6QuACEEbu4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AH7v+6YXAZsTN5nLLTng3F2liLRRqY483U4g/eY3PgCxg/hYpxRQXVLrDQ0/LVl9oYhRmMQdw1iZXRMqlMx+7eUbn+dQ64F3S47cA8hUCRM5zuyLyrAwZesm6kaBKQdIWMVY0CtX1dZNFlV64Fv8kpfSqHgqy7814UozL5gaeTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Do8gQd6; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4225ab1829so3350779a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 12:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754420757; x=1755025557; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=oCGEKAkbeIoGipEXNV8T0RUXqCHxNcix8LcZk/J0Axs=;
        b=3Do8gQd6Zgufyho4I057T0TokdKhRR4BSHkUQNflkztGtIWnCwyPowTcQjJvbIS1lO
         vRwOUze9Lmc6ECoi6TW0iaJUdJUp6oscjVyCsu1v/Tx+7VsNkAck/U0LCo4cWrjYORap
         bsf3MzCp+BtlPYnSt0xvOnJZiOHrtqXOAOoIgkHdrE/hkwdhRXT8/Yl58SyxQZlfzKXh
         3ywmuOkJw/xzIiNoxNOnYNuLOTRPZPRfCyj3BGITlQPcgNFYxpX22MhbA/681QpEdQfI
         31MqCq1759KB4YXfLElR13Lm6HLJAkAHTWn1VjKMk3G3q7lB5A66629iyQKI98NDb38m
         vUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754420757; x=1755025557;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oCGEKAkbeIoGipEXNV8T0RUXqCHxNcix8LcZk/J0Axs=;
        b=wsXIrcbLqAqGshSXSAZ58JpN7kDlTRVYF5WFMASiW2l+UUg8TNzHUKY2KoULSSVHj+
         rqYgKYSUl3oAK8VoXjydcjSwsB3anMN33C9EJf5sxDSx9a7tHYVkyn8AIbW3rHTISVFv
         aZ6zH0KXCNAUQNT1ZQU2z/hFXrBlbsnVdt1vVGP2akg1Woz4YNeuX+kQZyq/PfaidP4c
         MpQf0N4nWMEkH3hl9Rut5gBrWnCGqWWgwWiaMkKDNb/zneuoJ+FdM5DcqBtyfkUkATPj
         AHO9SlyeI/koBxXm+SB5WPzYjONhMZfk7olq9kPQZDU8WkiTt+KS0vHYyDJRkTqhi/hs
         ilLA==
X-Forwarded-Encrypted: i=1; AJvYcCV77SELPuJtfl/MSTm+X80h1v0+JXFYueZO1EBBGbt/6Wpa8HwSdzPPTdQiLAirQjVNbA0/e0x5rVDn174=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC5cMSwOb9h6uSn8CeLh7J7p63Q07/mueSZ8uUt+/yVViNifO3
	qcoAAiKF05KMqWZe9vMpMnC+o0N+je0wp//HEF89Y98rGsvGmcvN0fdThMzf+rjTdKH5jGdxNWw
	fJFJaLg==
X-Google-Smtp-Source: AGHT+IElV3TzNFEvi73astSTm6isgDxLFlXWng4KtkNOcbY0eY9l7+S3hsyx3YXtIUtoz742t5l8ACYhINA=
X-Received: from pgah7.prod.google.com ([2002:a05:6a02:4e87:b0:b2c:3d70:9c1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:5481:b0:240:a06:7837
 with SMTP id adf61e73a8af0-2403146a502mr275717637.17.1754420757037; Tue, 05
 Aug 2025 12:05:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  5 Aug 2025 12:05:23 -0700
In-Reply-To: <20250805190526.1453366-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250805190526.1453366-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250805190526.1453366-16-seanjc@google.com>
Subject: [PATCH 15/18] KVM: x86/pmu: Drop redundant check on PMC being locally
 enabled for emulation
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Xin Li <xin@zytor.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>
Content-Type: text/plain; charset="UTF-8"

Drop the check on a PMC being locally enabled when triggering emulated
events, as the bitmap of passed-in PMCs only contains locally enabled PMCs.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index bdcd9c6f0ec0..422af7734846 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -969,8 +969,7 @@ static void kvm_pmu_trigger_event(struct kvm_vcpu *vcpu,
 		return;
 
 	kvm_for_each_pmc(pmu, pmc, i, bitmap) {
-		if (!pmc_is_locally_enabled(pmc) ||
-		    !check_pmu_event_filter(pmc) || !cpl_is_matched(pmc))
+		if (!check_pmu_event_filter(pmc) || !cpl_is_matched(pmc))
 			continue;
 
 		kvm_pmu_incr_counter(pmc);
-- 
2.50.1.565.gc32cd1483b-goog


