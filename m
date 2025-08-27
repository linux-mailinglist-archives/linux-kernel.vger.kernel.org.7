Return-Path: <linux-kernel+bounces-788797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6940B38A63
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 21:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81F8B7B9222
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 19:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A066A2FABE6;
	Wed, 27 Aug 2025 19:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XSvNYN3N"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237262F2913
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756323682; cv=none; b=FVp1BxNYQPAx4OdyvQuOnGTMta4N9d6RPKR1dseOYVFXQOgoSt1ZGWr1pZECtwadyIUEboC/Y0VlxT3iYooB+DKXcy2vI64zj32laOkJCbSbC5SfC6aQ8XLG6Jqt7HV9J+7OjbZN1ln9iVzFfwzzIGOC0U4dfzpLK6asTXZ24EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756323682; c=relaxed/simple;
	bh=lTJBUXa731wmAEkf8x8Aq275GNYxHtJHPWm/QJRsZcc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YvP5uz6+P/5z3DgD3y+9wqMv9QruuMIfeHLiNfygl7qAR/r2tPAqOtF6WG1cTx9tZdDdWsydu0TDIUn9AdkiIKzwFjqfcpoBODq9hsb++fZSJyeD6CdpFEuHQI7+yWFYFkN6JEg0j+cDrO8SIWlPYcXFcOIs653GRDji67taZf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XSvNYN3N; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2ea9366aso158762b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 12:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756323679; x=1756928479; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=CAjH9n8kkSU88PuzJQYl+lvrDTSiqH/ka8e0rLGYB4Y=;
        b=XSvNYN3NiHj7sEVZF3XAAW0ZkXOrTD9c+GLnwNP4+LOAp7J1KZDqNfegtCsNb5xY2v
         ERt8u0/Yet6Au4WQs1H/LiIZLDwYtI5+1dQ6ZzgNT4qFuNqCo9oHX91Tp95Us4HXejMR
         DhjHr1hVNc6KiUNC5p3GA3tmGgzZv8bQNrGt3LRoc5vzbaEYLxGLfsNIuYYYzT/cNa+2
         4BeKfoAruzWVEyIcLW8VLpkHp3DXVkRx23v27AKV+FALcvd3bpXrIcSsXqaYRFi/KdNY
         R+eOMYe+PgYeZI4Pzwl7VQwHRa7SsmukCI2o0qn9ED8j75g4ExuM0JpWo+faw+uwQK12
         SahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756323679; x=1756928479;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAjH9n8kkSU88PuzJQYl+lvrDTSiqH/ka8e0rLGYB4Y=;
        b=JJyIP1q2H1aX2ZN9CZzBQxN4VrdKw92Vmjw2no3EbVb36ZYcSLFF+N7s43LmBwVSrX
         NnTWieAKjRMnAxcLCK6nBOwVJKMXPDcJqUwDambVBYUcgn+GF/3xqFl7q9lNur6COvoK
         lhJvO5O+L/3LAA7rlKoN1zvnUiyTQY9SE7tX5jCHHO0OnAvHGo7uLl4eUEoj9NFU7hyS
         j6G90DZdFMxVIhJzWtbDPHRLkE6n88DkGi3FaAyrVBZMPdmRDMLooZHqZYUATk3UIXF9
         +3ce3iQkxJ+EbKupPtQyuXRS0wEcfxTsFSjvKrPxCrAwYBgEyXz/lh6rqLpphCuiooMi
         56rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJeYqToG1jATEcyJR9IzJyQXA6GlJoP8QtRDtzuB++/qNt0r+JuFfc3aiteLKp2WRPF324OXLwLMtLUUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxGTCnBAE3aV8rdJN9W/8OtUrN7Swi9xP1sgoDUxWNvHOGem50
	1xiLTexz4gRejuQIedvgRT6c0HzhvM98PjV8lFLz/9M72r0YB2TL5kqHEjvKzHT48WrSsKZt1ae
	xxlRmWA==
X-Google-Smtp-Source: AGHT+IGn5ya0kUr/fIdsXYaCYO+ay+bA4LFPlBe/3Tzu+o9LmKU3qy0T5mYaH3gAWJMuIZiqZ0SiVacudbw=
X-Received: from pfbk11.prod.google.com ([2002:a05:6a00:b00b:b0:772:77e:bc4d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1399:b0:770:5544:dc0c
 with SMTP id d2e1a72fcca58-77055544aabmr20236423b3a.32.1756323679372; Wed, 27
 Aug 2025 12:41:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Aug 2025 12:41:07 -0700
In-Reply-To: <20250827194107.4142164-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827194107.4142164-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250827194107.4142164-4-seanjc@google.com>
Subject: [PATCH v2 3/3] KVM: x86/mmu: Don't register a sigkill callback for NX
 hugepage recovery tasks
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Don't register a sigkill callback with vhost_task when creating NX hugepage
recovery threads now that said callback is optional.  In addition to
removing what is effectively dead code, not registering a sigkill "handler"
also guards against improper use of __vhost_task_wake().

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 6e838cb6c9e1..ace302137533 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7677,10 +7677,6 @@ static void kvm_recover_nx_huge_pages(struct kvm *kvm)
 	srcu_read_unlock(&kvm->srcu, rcu_idx);
 }
 
-static void kvm_nx_huge_page_recovery_worker_kill(void *data)
-{
-}
-
 static bool kvm_nx_huge_page_recovery_worker(void *data)
 {
 	struct kvm *kvm = data;
@@ -7713,8 +7709,7 @@ static int kvm_mmu_start_lpage_recovery(struct once *once)
 	struct vhost_task *nx_thread;
 
 	kvm->arch.nx_huge_page_last = get_jiffies_64();
-	nx_thread = vhost_task_create(kvm_nx_huge_page_recovery_worker,
-				      kvm_nx_huge_page_recovery_worker_kill,
+	nx_thread = vhost_task_create(kvm_nx_huge_page_recovery_worker, NULL,
 				      kvm, "kvm-nx-lpage-recovery");
 
 	if (IS_ERR(nx_thread))
-- 
2.51.0.268.g9569e192d0-goog


