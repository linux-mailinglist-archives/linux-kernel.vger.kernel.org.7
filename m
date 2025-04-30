Return-Path: <linux-kernel+bounces-627830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3C6AA5570
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 22:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA9021C0273F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 20:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB1E2C1097;
	Wed, 30 Apr 2025 20:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJadcvYe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A789A293753
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 20:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746044621; cv=none; b=XO1VtBCciM6GfFlfIVtS5cSQhr54xGD+buKNraduSAeg/7/QmdzWM4qlPjVT1hwhMPBYfVxFNdFd2Ush5EBce8Zu4GLdJ6XJNSTpGn4cBFEZYKIi5Qkus7jznpV82HbCmSVvFNjT4rgGAT5HOG0wr2YLPjNS33FtWXNH4TvcDqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746044621; c=relaxed/simple;
	bh=CdhBGec2WacXI1FF8HyKMPzr03Go/Q3Bl2bylUjDVSk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BcOZQ6dCiN3rVjEGnbV6dmwrIHdMAN9ty72mSDkHK1jz+3CxJSffHWgygh4FJOPiSJ89/kabEo0X8Ty5ABLklNtV8VHM8TZatzXRnNzM3XOkA2oUDSvavNRU5j/fGned4sRU7tkX8hr7XNtSH+GMO52xgLIhLCXDLUWa36vIPKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aJadcvYe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746044618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ueORBRSdk8dfevMNCiszlxJFROHE0iUZRTzx7EwVQFc=;
	b=aJadcvYewhYTuhWK/ts8f9duyKEwqjz36KOZXvH65qeHDFEt7HMC3vSvXVQOS/5r6Tz3Gn
	vMEMB3vIP+SB6B3XBI6HEQ8rmh5aggge5tZEEl3mGhgg0cUkfJcNhSjJJaTQdVb7vfB2gQ
	3F+3m6KEVGjrzMWr77q3YGlzOrs800s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-Y91AxpyiOD2kIYc-u3Pg8Q-1; Wed,
 30 Apr 2025 16:23:34 -0400
X-MC-Unique: Y91AxpyiOD2kIYc-u3Pg8Q-1
X-Mimecast-MFC-AGG-ID: Y91AxpyiOD2kIYc-u3Pg8Q_1746044610
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5EAD11955D77;
	Wed, 30 Apr 2025 20:23:22 +0000 (UTC)
Received: from intellaptop.lan (unknown [10.22.80.5])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E1C381800365;
	Wed, 30 Apr 2025 20:23:11 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Kunkun Jiang <jiangkunkun@huawei.com>,
	Jing Zhang <jingzhangos@google.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Keisuke Nishimura <keisuke.nishimura@inria.fr>,
	Anup Patel <anup@brainfault.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Atish Patra <atishp@atishpatra.org>,
	kvmarm@lists.linux.dev,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Peter Zijlstra <peterz@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Sebastian Ott <sebott@redhat.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Borislav Petkov <bp@alien8.de>,
	Sean Christopherson <seanjc@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Shusen Li <lishusen2@huawei.com>,
	kvm-riscv@lists.infradead.org
Subject: [PATCH v3 0/4] KVM: lockdep improvements
Date: Wed, 30 Apr 2025 16:23:07 -0400
Message-ID: <20250430202311.364641-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This is	a continuation of my 'extract lock_all_vcpus/unlock_all_vcpus'=0D
patch series.=0D
=0D
Implement the suggestion of using lockdep's "nest_lock" feature=0D
when locking all KVM vCPUs by adding mutex_trylock_nest_lock() and=0D
mutex_lock_killable_nest_lock() and use these functions	in the=0D
implementation of the=0D
kvm_trylock_all_vcpus()/kvm_lock_all_vcpus()/kvm_unlock_all_vcpus().=0D
=0D
Those changes allow removal of a custom workaround that was needed to=0D
silence the lockdep warning in the SEV code and also stop lockdep from=0D
complaining in case of ARM and RISC-V code which doesn't include the above=
=0D
mentioned workaround.=0D
=0D
Finally, it's worth noting that this patch series removes a fair=0D
amount of duplicate code by implementing the logic in one place.=0D
=0D
Best regards,=0D
	Maxim Levitsky=0D
=0D
Maxim Levitsky (4):=0D
  arm64: KVM: use mutex_trylock_nest_lock when locking all vCPUs=0D
  RISC-V: KVM: switch to kvm_lock/unlock_all_vcpus=0D
  locking/mutex: implement mutex_lock_killable_nest_lock=0D
  x86: KVM: SEV: implement kvm_lock_all_vcpus and use it=0D
=0D
 arch/arm64/include/asm/kvm_host.h     |  3 --=0D
 arch/arm64/kvm/arch_timer.c           |  4 +-=0D
 arch/arm64/kvm/arm.c                  | 43 ----------------=0D
 arch/arm64/kvm/vgic/vgic-init.c       |  4 +-=0D
 arch/arm64/kvm/vgic/vgic-its.c        |  8 +--=0D
 arch/arm64/kvm/vgic/vgic-kvm-device.c | 12 ++---=0D
 arch/riscv/kvm/aia_device.c           | 34 +------------=0D
 arch/x86/kvm/svm/sev.c                | 72 ++-------------------------=0D
 include/linux/kvm_host.h              |  4 ++=0D
 include/linux/mutex.h                 | 17 +++++--=0D
 kernel/locking/mutex.c                |  7 +--=0D
 virt/kvm/kvm_main.c                   | 59 ++++++++++++++++++++++=0D
 12 files changed, 100 insertions(+), 167 deletions(-)=0D
=0D
-- =0D
2.46.0=0D
=0D


