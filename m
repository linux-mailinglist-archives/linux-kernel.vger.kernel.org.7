Return-Path: <linux-kernel+bounces-751344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB26B1680F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 23:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78E6B18C58C9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA92C222590;
	Wed, 30 Jul 2025 21:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v2ehqj2B"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F9921FF39
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 21:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753909884; cv=none; b=l5WEw64Yuui2x2nAz3E3eH6ZutF0DmGdsnuW504FExWujE97evFhjukP9AA4+BA9fq9Iu6gG2DZs/R0mF0CgtEpWco8cE/65Eq+ESk6ak4aH6IsJs5rmZ11F/5lWBu5ua4/Yeo3ED47Hj2+96BEugVbun4BZ1KDxuiAK7bhlOKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753909884; c=relaxed/simple;
	bh=cVmFzsj3OpZTUi6FUzCWejRWJRm0o5ncvOdXgEoC+OE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZxcBvfFKvcAcj9y4hCq08ObgjKPD8NKDbzjfVKEWH+IZ7SFKx+M+YVYsCjry4D4qpAmCnXHb4CK57yAMFVLXy7l+UPbGISHI6iWwLPTegPBc2cESbPvermFNJIOgK8Pq+GGoM2mIr0KzXIBrFD2VPjg+pP3RN4lO03BJC2s4iDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v2ehqj2B; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74ea7007866so212467b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 14:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753909882; x=1754514682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zcr0HAZVJL/wPM68//kB0QFOkcy4cqNgVvPP1uhkVrY=;
        b=v2ehqj2B8kahSbPAjtrhq5Gx5GsOrGx4NGAKgBnFM3FtBEeVNMzmrReJ1SZiUBwo4b
         BjzMoWUFhUCet1vUOyls2ea5sfZP2KAjHxx9jsd6bdsEbFbtCxNTcvCoH72E47N6lO1s
         kpUyDc9TvCit4qnrUg7hY2ApCIoYSII+OJUx/W52Y3wlKKTAJGgLSH7ovOjNWcjKIjU7
         rrJrxI4BheB3UzExcRZlYFCrzrNHyYlsaKSMtK/mupgD7Txg27UTsd0wbb1yikRd0F1K
         lHTPkXuey0ZNeqFquA1YjUmyJTEQLiSfmR0gW0cvUUNWVHQdSmPAYymdZYWbxdk0MP8W
         E+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753909882; x=1754514682;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zcr0HAZVJL/wPM68//kB0QFOkcy4cqNgVvPP1uhkVrY=;
        b=ZkYWtrkLgpErHP0kQxBi31+bMSXcVEw6HHmmkaSdc4xWevNL1S/GixY3Hcd5sN7iaX
         oLoqwwk3/Z8S7nRHGV0DElnGCKPwZVvFuAW6q6xx2ONyBtIID0B909T1jr4G05tbkncM
         IArYsPEluVqW4bOSbPsqY44gteQpdn+Z1s4r1N4GJbhIbNUBvuFsX7nzPZC75Ukjd6mv
         40qzBNPGkC1ZlRbH16cGiRvX2a/vEMZblh9FuPx0t7W6tiXvCFewdoBegf+oBY01Rjoh
         hmBWd7ppfq0wrtfG7sTa0oJytwVp2fl+IubvI5e79IJzhfQAdijkIP8VMrXRl3dPIqys
         xSGw==
X-Forwarded-Encrypted: i=1; AJvYcCXZTHvor//pAQWxHzA/l/+Gbc12NLeB/YvrWpHN79ccA85GHwg2dHYklD0jPYKSHl85iAqdwU+jyrL4sEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT6Y13zaFZRc5J+F99Zj3McKDreeJyapht58J58p6qqI4Ffp8p
	biuHeAZDwmSeoanCRKGci6cPxyCroxH+iKLcskJAROnGEq7DNIo/TWTTZxB84nE6RRyfZcpvtIl
	LCabC9oT5Dn7c2R6vuuxcmw==
X-Google-Smtp-Source: AGHT+IH81SELHZh+GPX7YKucdrOrQjsD2qC5Y2tfTvaMHB5OVH1Y4cxqU+ojrj5t1POmR4E8onsMP+EV8Hr7rDZV
X-Received: from pgmb10.prod.google.com ([2002:a63:1b4a:0:b0:b3b:d2a0:df40])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:12d3:b0:234:216b:cf98 with SMTP id adf61e73a8af0-23dc0e8609fmr7392654637.35.1753909881916;
 Wed, 30 Jul 2025 14:11:21 -0700 (PDT)
Date: Wed, 30 Jul 2025 21:11:18 +0000
In-Reply-To: <20250618042424.330664-6-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250618042424.330664-6-jthoughton@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250730211120.4163536-1-jthoughton@google.com>
Subject: Re: [PATCH v3 05/15] KVM: x86: Add support for KVM userfault exits
From: James Houghton <jthoughton@google.com>
To: jthoughton@google.com
Cc: amoorthy@google.com, corbet@lwn.net, dmatlack@google.com, 
	kalyazin@amazon.com, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	pbonzini@redhat.com, peterx@redhat.com, pgonda@google.com, seanjc@google.com, 
	wei.w.wang@intel.com, yan.y.zhao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 9:24=E2=80=AFPM James Houghton <jthoughton@google.c=
om> wrote:
>
> Only a few changes are needed to support KVM userfault exits on x86:
>
> 1. Adjust kvm_mmu_hugepage_adjust() to force pages to be mapped at 4K
> =C2=A0 =C2=A0while KVM_MEM_USERFAULT is enabled.
> 2. Return -EFAULT when kvm_do_userfault() when it reports that the page
> =C2=A0 =C2=A0is userfault. (Upon failure to read from the bitmap,
> =C2=A0 =C2=A0kvm_do_userfault() will return true without setting up a mem=
ory fault
> =C2=A0 =C2=A0exit, so we'll return a bare -EFAULT).
>
> For hugepage recovery, the behavior when disabling KVM_MEM_USERFAULT
> should match the behavior when disabling KVM_MEM_LOG_DIRTY_PAGES; make
> changes to kvm_mmu_slot_apply_flags() to recover hugepages when
> KVM_MEM_USERFAULT is disabled.
>
> Signed-off-by: James Houghton <jthoughton@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

This patch fails to remove the WARN in recover_huge_pages_range(). The
diff below will be applied to the next version of this patch, whenever it
comes.

This WARN can be hit by enabling KVM_MEM_LOG_DIRTY_PAGES and
KVM_MEM_USERFAULT, then disabling KVM_MEM_USERFAULT.

I've been having offline discussions with Sean about this series; I'm
waiting for him to rework the KVM_GENERIC_PAGE_FAULT bits. I'll dedicate
some more time to the QEMU side of things too.

Thanks.

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 7f3d7229b2c1f..2d83ddb233a9a 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1779,7 +1779,7 @@ static void recover_huge_pages_range(struct kvm *kvm,
 	u64 huge_spte;
 	int r;
=20
-	if (WARN_ON_ONCE(kvm_slot_dirty_track_enabled(slot)))
+	if (kvm_slot_dirty_track_enabled(slot))
 		return;
=20
 	rcu_read_lock();

