Return-Path: <linux-kernel+bounces-733402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0DAB0744A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CE0B1AA739F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666152F4A03;
	Wed, 16 Jul 2025 11:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QZ3BZ3oU"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDFA2F3C3E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 11:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752664070; cv=none; b=r9ssUCYkvTU6eFcj6pb6EJWWGrFv497/uX7YAQUXt7acfFtLLM6pYmHCDdBSmRyYYmf6m3Q+ZPJtiWeI0rA4/wGf28hS0Dg+eYaY9Z2quHHEFjHY7BCjvvkAuILyTmTTLsjs0xE6Dfk0ymYLtdAezvAnEvE5zokPyrCG/U5Phbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752664070; c=relaxed/simple;
	bh=PrPZi9FLkMWKmIdJSQLq3BcigSFeFqZOp9S9N0GiAU8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=izI9vTEzQ/5yepsRmH1VbLclsWCHz66oxe+JSgoTcetVcVrt/B+bKzUJoEM4INmFTHq6ZG8mnqHJ/PRjd3imzOKs7os71rh6JMMRYzdYPgAKy8HS7HNu6CVw1XUhyxV4g5M1MbQvUM3E1zoSKFJExl/uLRezc0yGiNyk7u0XCsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--keirf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QZ3BZ3oU; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--keirf.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-454dee17a91so50627445e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 04:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752664066; x=1753268866; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hxqszaeuljrqlm0t8DgnPuG7w9pgNEhhBTVGlWt0Bfs=;
        b=QZ3BZ3oUkA5fkjLHPoQ7w9WB+U8mzCKcAEeN0r8Iyqav47Z++28pidd4psSSn/x8V4
         poA1PNJO9vGFIzQEGMey0jzvcgnsMnAsiaxZybhVZPKqAPJldexQNKA8MBKjxcrvYxm9
         zCN5m5sNokork1u9xiDzhF23F0cNV/zX2xEzLZmjAK5hBC90emprwHkoJWtiZWrhahv9
         U4mj3AXpurSCJiI6lyoKrTyxUuNJUVhuTXYVNA/oYZsznxg5Zzr1HCkCyrOAg9BkiRvT
         e88onoQZYFS3OWSmk1HvkklD6L/PGLg6gHNCWz+wcYYXj/3V5GcHwNfwRMoGba9RpoBF
         ibng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752664066; x=1753268866;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hxqszaeuljrqlm0t8DgnPuG7w9pgNEhhBTVGlWt0Bfs=;
        b=C6uk8Cv62ttx5JQYNqzcGLI4Q8yrAVlHYNontZvF9LNT5eSOr9CHr/ClqI4E0A9j40
         jwSuq2G9mmL2q5cRkrNReDazgWSyruTanGb7N82HP1akPiZMQ2rCptLwtI2yi/nALGfL
         m5xt1Do+eiCO/RFjIa+JagXgnRb5dQWSIDANkU2dLLzEDUAvKk2dXANCBNJ4N7DcWmtU
         5P8IuFfcaL6rql+6d1bURZswzddLRi75iFNQfaocnnQ/FkjD1FaQRmEKE8cpBlDHUqh1
         6srDbuEfsi6xixnY+w+vvTMx8UlA7NJufZcekiTTvUlrl8C10gnaGUN/wvT2t8MBTxxX
         tfqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdx53uKw4lud3SmLAonDu8Odf1Tp0Q+/CVVBT5R+fIBdQWgoOpNy37R9iIDgRMkY+LzBDQ42Gfv0JAnFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGSKdA49BQQKQJ5bN06TOUwBPdT5DWtuFmzGystkfhvizrR6LU
	lJn0XzHqLjuXL5cyh0IbfpTAGoUZCEu3VjgekocJaHjvCl5omlYtjDkoZnNdHd/3csES7Ouplp7
	l5A==
X-Google-Smtp-Source: AGHT+IEc90RI4GCOsQRZO8PqFs/HKd6dYrEM+oA0RTzrbntMXuFw8OS9F/kKOUPw5mrVP3l/ZU5GEG7EJA==
X-Received: from wmqa10.prod.google.com ([2002:a05:600c:348a:b0:455:76a8:b3a])
 (user=keirf job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:5299:b0:456:1c4a:82ca
 with SMTP id 5b1f17b1804b1-4562e3c227cmr18678235e9.32.1752664065812; Wed, 16
 Jul 2025 04:07:45 -0700 (PDT)
Date: Wed, 16 Jul 2025 11:07:35 +0000
In-Reply-To: <20250716110737.2513665-1-keirf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716110737.2513665-1-keirf@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716110737.2513665-3-keirf@google.com>
Subject: [PATCH v2 2/4] KVM: arm64: vgic: Explicitly implement
 vgic_dist::ready ordering
From: Keir Fraser <keirf@google.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>, Eric Auger <eric.auger@redhat.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Keir Fraser <keirf@google.com>
Content-Type: text/plain; charset="UTF-8"

In preparation to remove synchronize_srcu() from MMIO registration,
remove the distributor's dependency on this implicit barrier by
direct acquire-release synchronization on the flag write and its
lock-free check.

Signed-off-by: Keir Fraser <keirf@google.com>
---
 arch/arm64/kvm/vgic/vgic-init.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
index 502b65049703..bc83672e461b 100644
--- a/arch/arm64/kvm/vgic/vgic-init.c
+++ b/arch/arm64/kvm/vgic/vgic-init.c
@@ -567,7 +567,7 @@ int kvm_vgic_map_resources(struct kvm *kvm)
 	gpa_t dist_base;
 	int ret = 0;
 
-	if (likely(dist->ready))
+	if (likely(smp_load_acquire(&dist->ready)))
 		return 0;
 
 	mutex_lock(&kvm->slots_lock);
@@ -598,14 +598,7 @@ int kvm_vgic_map_resources(struct kvm *kvm)
 		goto out_slots;
 	}
 
-	/*
-	 * kvm_io_bus_register_dev() guarantees all readers see the new MMIO
-	 * registration before returning through synchronize_srcu(), which also
-	 * implies a full memory barrier. As such, marking the distributor as
-	 * 'ready' here is guaranteed to be ordered after all vCPUs having seen
-	 * a completely configured distributor.
-	 */
-	dist->ready = true;
+	smp_store_release(&dist->ready, true);
 	goto out_slots;
 out:
 	mutex_unlock(&kvm->arch.config_lock);
-- 
2.50.0.727.gbf7dc18ff4-goog


