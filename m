Return-Path: <linux-kernel+bounces-648351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5C3AB75BB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 21:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 203E216E3A2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 19:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BE3292938;
	Wed, 14 May 2025 19:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UJ+nSYMP"
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E4328D8DF
	for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 19:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747250529; cv=none; b=dTwxp/jLtB3zacUamYOFSuycnKyQcweZGkQOpVQKstROrxDDw6RdN+ZQzD1tpXrFfSFH9UU4nPOH3od6DfdF9n5TNvBetC8DgXBcYDyYBHW0yndROdvb/HUrgTGW+B9uJjpkmVIXrB5ozoYyYl75HdzQXqkBs6+hZseCQeqLPCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747250529; c=relaxed/simple;
	bh=6GLh2vAUb131giOvQk8M/um3okSJGroCjyJghDkewc8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=K1ukvOipv4x/EHSONeDOerPSk1vtt7Tx453V5BZ7WUtiAq50wnJDp+JsLrNKOXyRjjy10zypCgOUs3JNrfoyxLY8q8hfztjykBy+GgEyVmC5azNdtTUL9YXkBwth2107QXSeSiLgZSRaOS0ub+N6zsr/IDoAb749vJgt6zRB52E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UJ+nSYMP; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3db6f98ddf7so2665455ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 12:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747250525; x=1747855325; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c8ePtC5HFZo+bckSClZmheBHRBfYWwooCNAcmQiJQhY=;
        b=UJ+nSYMPX7xyaXdluGbrLXYlIgkX+ncmsGE1ZoopKj/U8aYSeceM5ClmY34DUvOXyf
         Jdf7ptUaJ8+ePDlJy+UNpxwSWbaxdASi+u0gYEZevbJVahqMlHbPtNGIvyJyiJ1zIBw1
         dSbtIkKdfB49tj3Ew57ph7EyrrnZONv2FtVwdAWuNMFOkjTnhFxbKILXFkgPl289t+Ph
         zYaKmTnc008o8tVFgk/ZMhj2Pyo869S3kj8OB1ownMrUBq+8X9XZwWSrcXNRaHaTmH1l
         RIxJqTomrn1FuuB8GOENr6Jg68fjGwAiBToF29W0+JKRn2cvte4X5j3kCg4VhJYheNei
         XTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747250525; x=1747855325;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c8ePtC5HFZo+bckSClZmheBHRBfYWwooCNAcmQiJQhY=;
        b=vxHfndI4ZeTv0lNnx2EpY1NiQU52GnC7TePO3pVMX5pTRJX7W83gHqozl/KUjPnL1/
         19m6Yz+K7Bei/adVrG13xBtMDuetO1z0rHtPSoN+15IJvsqqpqYhfYIsZv4kIiYeC/Rb
         I+d+ork0pKd5/LcvX6rkPzP7jKMfKRlPBwwTOfyo5J9UeRatYr50pKoKqNg5DdtGVbSP
         m4dnPSla/E7MuxwHBOzamMq+q/KeYRiRX89p8w6S8mq9lzG0Sg4i1/wBH07+Np36l3Zq
         ypuD0v9BMBnFA5sq/c3enztSv+rKaCGWk8UBzRKBWF4t8J0gWkuULsKx/Wk0FEntdYjC
         Z6HA==
X-Forwarded-Encrypted: i=1; AJvYcCV7Tpka3Qrn4z98/LSPSEsW4YnoRhgFHgzUzXjFnXNMCP6NXPNgCgstr0CzpxmnSDbe28PlLK/VNKf042s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3uuCIpoMkSOJozYLohl9Up+7j/gPzMnQny4OLhK0Y7Ffhpvmu
	t87biIYFCQaq7O0j3TiEpLyJsqbm55qfLg/GuFwQASHG73RTqXH0IQ5Dx+s3FV51rZS9cfNHVOq
	WjMbcjQ==
X-Google-Smtp-Source: AGHT+IF1ogsTmn2Q4LFsh6tOmFxWnhQ3nGtiA78U3XsyCpRhWXAptzz3zxmhkhTqbmqZ1kXN3wTOk6bikL9+
X-Received: from ilbbt9.prod.google.com ([2002:a05:6e02:2489:b0:3d9:37ff:afd7])
 (user=rananta job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6e02:178f:b0:3d6:cbad:235c
 with SMTP id e9e14a558f8ab-3db6f7ad141mr53575415ab.6.1747250525722; Wed, 14
 May 2025 12:22:05 -0700 (PDT)
Date: Wed, 14 May 2025 19:21:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250514192159.1751538-1-rananta@google.com>
Subject: [PATCH 0/3] KVM: arm64: Allow vGICv4 configuration per VM
From: Raghavendra Rao Ananta <rananta@google.com>
To: Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>
Cc: Raghavendra Rao Anata <rananta@google.com>, Mingwei Zhang <mizhang@google.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

When kvm-arm.vgic_v4_enable=1, KVM adds support for direct interrupt
injection by default to all the VMs in the system, aka GICv4. A
shortcoming of the GIC architecture is that there's an absolute limit on
the number of vPEs that can be tracked by the ITS. It is possible that
an operator is running a mix of VMs on a system, only wanting to provide
a specific class of VMs with hardware interrupt injection support.

To support this, introduce a GIC attribute, KVM_DEV_ARM_VGIC_CONFIG_GICV4,
for the userspace to enable or disable vGICv4 for a given VM.

The attribute allows the configuration only when vGICv4 is enabled in KVM,
else it acts a read-only attribute returning
KVM_DEV_ARM_VGIC_CONFIG_GICV4_UNAVAILABLE as the value.

On the other hand, if KVM has the vGICv4 enabled via the cmdline, the
VM absorbs this configuration by default to maintain the backward
compatibility. Userspace can get the attribute's value to check if the VM
has vGICv4 support if it sees KVM_DEV_ARM_VGIC_CONFIG_GICV4_ENABLE as the
value. As required, it can disable vGICv4 by setting
KVM_DEV_ARM_VGIC_CONFIG_GICV4_DISABLE as the value.

The patches are distrubuted as:

Patch-1 contains the KVM code that introduces the
KVM_DEV_ARM_VGIC_CONFIG_GICV4 attr, and adds all the support around it.

Patch-2 adds the documentation for the said attribute.

Patch-3 extends the vgic_init kvm/arm64 selftest that tests the get and
set of this attribute in various configurations.

Thank you.
Raghavendra

Raghavendra Rao Ananta (3):
  kvm: arm64: Add support for KVM_DEV_ARM_VGIC_CONFIG_GICV4 attr
  docs: kvm: devices/arm-vgic-v3: Document KVM_DEV_ARM_VGIC_CONFIG_GICV4
    attr
  KVM: selftests: Extend vgic_init to test GICv4 config attr

 .../virt/kvm/devices/arm-vgic-v3.rst          | 24 ++++++--
 arch/arm64/include/uapi/asm/kvm.h             |  7 +++
 arch/arm64/kvm/vgic/vgic-init.c               |  3 +
 arch/arm64/kvm/vgic/vgic-its.c                |  2 +-
 arch/arm64/kvm/vgic/vgic-kvm-device.c         | 39 +++++++++++++
 arch/arm64/kvm/vgic/vgic-mmio-v3.c            | 12 ++--
 arch/arm64/kvm/vgic/vgic-v3.c                 | 16 ++++-
 arch/arm64/kvm/vgic/vgic-v4.c                 |  8 +--
 include/kvm/arm_vgic.h                        |  5 ++
 tools/testing/selftests/kvm/arm64/vgic_init.c | 58 +++++++++++++++++++
 10 files changed, 157 insertions(+), 17 deletions(-)


base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
--
2.49.0.1101.gccaa498523-goog


