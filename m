Return-Path: <linux-kernel+bounces-733399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33614B07443
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 654B84E1470
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02452F3C2A;
	Wed, 16 Jul 2025 11:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4NdAw62a"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFD52F3622
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 11:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752664066; cv=none; b=agVIuyEKVEO6y5rTqgibvzoJlrAQzN8k78p6IBAEz8MA4yuvJHckoKJiCyNuiI4gBMfmQNEx2zNiN1HSTcuJAImnXcw2QClKmA6QfhGc6FABjZE9iEN6sqCNSpoJOwLIKe4lzYXKBTkRdqH8gUKnyiDWEBmasb5CHZCmjy/pqsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752664066; c=relaxed/simple;
	bh=10ttIjeYifGJfahCuKUTezWJuXS+ZrMIpJRyy5waZzc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LpKSKf0TIYL1JEapqoQdiFpx6SoYheYnpuFx0O3we47F9IQ0bi4BFndcx1vBEYAB/gTRKfiLa4nbtKzy7vuMdRZoO+GryPlPC9OXizdmenerxKqa+kt4cvxs2E+mhf0gAoQyI/vVrAMlaxRF9hereZT/GMa7Pr5PulBdUAcchOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--keirf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4NdAw62a; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--keirf.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-ae3c8477f1fso590725866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 04:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752664063; x=1753268863; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TyfcqbggFsVMkhQ3/vS33VSK/7m2OBGtht93BA9q1Nc=;
        b=4NdAw62atsgTKViy+ScQmBGvpjPhhHpsBVUZ8FMqkU1zqvZdy+ebzCTQ7lSusoRyOx
         mbbDtipJA3XlawTfFALk2n3hM+vfaM27ZXavCD/pSQbLDqZnzVNZHBVy8RXij6B/69D9
         xzQ2g+eAGUQI+ypQb6hPJ4lzv4SiSbFARHFihBvCYCe+NrdLHhCLmxzFTDP/P6NmFzKW
         2H2GPLkdXLpsr8CTFAiIlm7XenSHPajZV7rTp8GRYYy/gvmlIM/OMVizM2eyJzcN8IcV
         k+mX3HxHRbLZOj+jHHyMjLpdv/Cpb9l91bkyX/mt2GRr1W6PkN2U37E2UyMDAL/zcSn9
         AdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752664063; x=1753268863;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TyfcqbggFsVMkhQ3/vS33VSK/7m2OBGtht93BA9q1Nc=;
        b=n24frRB7nCWN0c1KhAMRaa4i186p83aNTklCkj22Vzkqbu0O7ALSN4bSNNCAR7Kmkh
         ZJ5W/MfOJhJQksv0Fo7GNo6IhFujwZeqaQoe5lj/RCv1OZX5cdi5OIJ1qyJSDjjjDoNo
         ryzmwteP3KmwhwAyFRt2tfo1mRx1UCXesSP2BtuHloLDV8O1PKy8YMy9c4tjIhhK37OC
         ZCuU5oZmWNC0n6WQ/c3msrrtoYBzspWCfonoaYqtFIB3Z18jJR+Y4zzYMF+n1tIK6A5z
         5jSE6fsvKGIoQD9hG6GygLUom0Lng0GOspTZYxB2VgEpCtVzQwakKdIeYQMMTbEuMhr0
         exyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQvIjaWBG5Ko8Vq8dXuAtphLtUw9GjiKWEig+qEnHZzhBZvb5oiY1gDsGQWFMTC9rRcG/xgqwoLjPXiBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvTZgr5Xir2UojWTHLI25ZFey3oYdVmje0uYjdriBwSlCFA4H2
	DttrtfDY9oIIuxRWHPp4AXoiKYKWg791p9LQvzBYpzDh6RiScmoZCzoFW3mfrx3WZ/uy80MHn35
	Ysg==
X-Google-Smtp-Source: AGHT+IGeYAejknlz7cV/1SlSOzPhNdhatcheR1F0bGDRmruI6xm7M0czw9xzhGPfq4CQ3wRKJ1YDvke/1g==
X-Received: from ejae12.prod.google.com ([2002:a17:906:44c:b0:ad8:9944:a34])
 (user=keirf job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:3f95:b0:ae3:5da3:1a23
 with SMTP id a640c23a62f3a-ae9c99c0d2bmr228038766b.21.1752664062975; Wed, 16
 Jul 2025 04:07:42 -0700 (PDT)
Date: Wed, 16 Jul 2025 11:07:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716110737.2513665-1-keirf@google.com>
Subject: [PATCH v2 0/4] KVM: Speed up MMIO registrations
From: Keir Fraser <keirf@google.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>, Eric Auger <eric.auger@redhat.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Keir Fraser <keirf@google.com>
Content-Type: text/plain; charset="UTF-8"

This is version 2 of the patches I previously posted here:

 https://lore.kernel.org/all/20250624092256.1105524-1-keirf@google.com/

Changes since v1:

 * Memory barriers introduced (or implied and documented) on the
   kvm->buses[] SRCU read paths

 * Disallow kvm_get_bus() from SRCU readers

 * Rebased to v6.16-rc6

Thanks to Sean for the review feedback and patch suggestions!

Keir Fraser (4):
  KVM: arm64: vgic-init: Remove vgic_ready() macro
  KVM: arm64: vgic: Explicitly implement vgic_dist::ready ordering
  KVM: Implement barriers before accessing kvm->buses[] on SRCU read
    paths
  KVM: Avoid synchronize_srcu() in kvm_io_bus_register_dev()

 arch/arm64/kvm/vgic/vgic-init.c | 14 +++--------
 arch/x86/kvm/vmx/vmx.c          |  7 ++++++
 include/kvm/arm_vgic.h          |  1 -
 include/linux/kvm_host.h        | 11 ++++++---
 virt/kvm/kvm_main.c             | 43 +++++++++++++++++++++++++++------
 5 files changed, 53 insertions(+), 23 deletions(-)

-- 
2.50.0.727.gbf7dc18ff4-goog


