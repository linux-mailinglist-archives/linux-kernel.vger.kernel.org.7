Return-Path: <linux-kernel+bounces-733403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC02BB0744D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93077507816
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC402F5092;
	Wed, 16 Jul 2025 11:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ZTgm0gA"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B142F433C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 11:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752664071; cv=none; b=GMB6dmd8GuglslXP87LVB6FPHXzfgDpGI8kmYVBxpKhD5hLINp7QfMy9LkrrZBZTr3J9whwO23YzErDoWNGkWeX6cVB6rgERtwbypfQhlRoTUuzVLWL5xiGSXAwt9TMrNCKrAUHequ7TyR7V8nRLmXqy1bmBUHly0MwyKe5UwH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752664071; c=relaxed/simple;
	bh=SwRbVQZAJVuZZ3KPArKlcrn8a8LengWToebo4ivdzPo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fwbbg45qzUfW80scpyQwRI5u5KGnnP3veFRcSZ1a0aOvrK2fTcMu1Ajj2sKhe/wZ2QxN7PhmrXH483kK9pj7Cso0lc3kLQ2PamA4q+FJfF+3dqghccSViO+tdrlXerTotQUPQHEHfI39Po/V5cdZ9q28kUHsrBaLEpsRcJLMbM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--keirf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3ZTgm0gA; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--keirf.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a52bfda108so3166697f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 04:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752664069; x=1753268869; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bFiBh24vfyxUkvL/qAF91ZLaWMijXEEuq00t+Y6HBLE=;
        b=3ZTgm0gAiZmMJU+oBt2B575JcO1wGtvdpQ9FrcIeml0lmRslMfAPKZGeL9D9NoL8pZ
         rPhFECcZ98Wdu8mk0a6KfRsvGYPlPmmi0jBK/b8/vaZOiolxrz1Xj4bLftBszW5HwYCW
         Rj8eqQOm2XuCtDDy51GdpCg9EmgAjrhUfw/KxRiDbjTZ7A595qLGfQTHH0dD6hxtf/BG
         eyeEImos8O5UZ4YyCGJs9u7D6Xhq835577Vq7ZeJbDrm3DG4dXCKqJEs6fUcLa1SICYE
         gy8iTgy4InENVuloePP9+8MTT8VVsLoLGeTzcpOcmCCDoqpF/CcuJRL01RfTCXGtzvr9
         IZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752664069; x=1753268869;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bFiBh24vfyxUkvL/qAF91ZLaWMijXEEuq00t+Y6HBLE=;
        b=ix0PAn1a6RRt/ayw0KrZI9JYfVjwzSCaj0e7DbINA5mKD403iHpVH0fLKiBFegIgOU
         WBWkKZRIKBpLZ0gswzGQdi7Db1dRO2vGrbCg7CAEkYdn+N0AahBKUVWBzeUzz/gw9Fbh
         9vScxY15+9NtfzP+KHY72/lgddstjFWyAMsVRvF4z7qHNHzyk0vPtCx27eGIvd5eSJLr
         L4Uf4Z/vuAn8J8YGvS3nC7eA+AEgcR8GmrFYrjCuMp56+LsAK9Gc8K7b1Eh7rGaSE2wr
         LVkhQVJgPKsCHV/N49KKxV+EMg2ki2BZu+KL0/vPl5Ta/gpHJ4zFoWRmS0cOLc3TL6Uo
         kJdw==
X-Forwarded-Encrypted: i=1; AJvYcCXZcdVgYhR0ftqNFoLSjbGMPUaoeloxKIin2645FaMhfPQYR2bIay/HHqUFHj7ECSx+q9RgLWlsiy2O5aM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye+FN3KD+aDDPPamPt+bEyNJW9N1MVWxcZNVX0pDbz0Sh/gMwk
	udor18O55E2f47T7mIrfsRvnJzHDli9t6KR6XKBUHCDQ2bAwm7y2dF/hF4co7iVIwgUL77LksU+
	rwg==
X-Google-Smtp-Source: AGHT+IHS3mDNKI5f7HxVRvsGrhgPtKyzq6M9m0VkLvornMAR5mJ3Yg4oC8wem/+qjRBiPoyYxBKnOYGMMA==
X-Received: from wmqd13.prod.google.com ([2002:a05:600c:34cd:b0:456:23aa:8bf])
 (user=keirf job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2486:b0:3a5:232c:6976
 with SMTP id ffacd0b85a97d-3b60dd99677mr1925159f8f.44.1752664068593; Wed, 16
 Jul 2025 04:07:48 -0700 (PDT)
Date: Wed, 16 Jul 2025 11:07:37 +0000
In-Reply-To: <20250716110737.2513665-1-keirf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716110737.2513665-1-keirf@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716110737.2513665-5-keirf@google.com>
Subject: [PATCH v2 4/4] KVM: Avoid synchronize_srcu() in kvm_io_bus_register_dev()
From: Keir Fraser <keirf@google.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>, Eric Auger <eric.auger@redhat.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Keir Fraser <keirf@google.com>
Content-Type: text/plain; charset="UTF-8"

Device MMIO registration may happen quite frequently during VM boot,
and the SRCU synchronization each time has a measurable effect
on VM startup time. In our experiments it can account for around 25%
of a VM's startup time.

Replace the synchronization with a deferred free of the old kvm_io_bus
structure.

Signed-off-by: Keir Fraser <keirf@google.com>
---
 include/linux/kvm_host.h |  1 +
 virt/kvm/kvm_main.c      | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 9132148fb467..802ca46f7537 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -205,6 +205,7 @@ struct kvm_io_range {
 struct kvm_io_bus {
 	int dev_count;
 	int ioeventfd_count;
+	struct rcu_head rcu;
 	struct kvm_io_range range[];
 };
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 9ec3b96b9666..f690a4997a0f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5948,6 +5948,13 @@ int kvm_io_bus_read(struct kvm_vcpu *vcpu, enum kvm_bus bus_idx, gpa_t addr,
 }
 EXPORT_SYMBOL_GPL(kvm_io_bus_read);
 
+static void __free_bus(struct rcu_head *rcu)
+{
+	struct kvm_io_bus *bus = container_of(rcu, struct kvm_io_bus, rcu);
+
+	kfree(bus);
+}
+
 int kvm_io_bus_register_dev(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
 			    int len, struct kvm_io_device *dev)
 {
@@ -5986,8 +5993,7 @@ int kvm_io_bus_register_dev(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
 	memcpy(new_bus->range + i + 1, bus->range + i,
 		(bus->dev_count - i) * sizeof(struct kvm_io_range));
 	rcu_assign_pointer(kvm->buses[bus_idx], new_bus);
-	synchronize_srcu_expedited(&kvm->srcu);
-	kfree(bus);
+	call_srcu(&kvm->srcu, &bus->rcu, __free_bus);
 
 	return 0;
 }
-- 
2.50.0.727.gbf7dc18ff4-goog


