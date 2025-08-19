Return-Path: <linux-kernel+bounces-776081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D6DB2C850
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CF723B5C36
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47FE28541A;
	Tue, 19 Aug 2025 15:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="oec5CXSL"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3252127A108
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755616840; cv=none; b=ZJoivi3tbbrjn/kkbCFTmXsA7Q42lQjcdXYIMhpf6h7T8R0yzs2AAdUyVwFUCCa/tC9hox6BiGMih5SojMLU4QsnYFT2TXbpeDNZcUzZWH1ELuvi92R1JOnKTgT6gdvzrjB3HXyimtRJ3/D9D3ifA7DAlB17Cj0I09vtRLbqK6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755616840; c=relaxed/simple;
	bh=NrN1uqcJdpnrp2jcDM9mNdL4V79R23IZ3fHrn4EeoLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M+EOLcSUhY7xJCy93Qwnpbru7BPuaxm4MPJJDAYMTVvZIzPbtgfzC2Si/hTbQ3kLO9sAsvNXZyAMmOg5/x7j/05FjpGf1yASAqZ1hMNyp6//wr2oD2mzOZLl07LCamitEqPUOoyFBiDRLe2j+NAd+/inW7wvofuo1TWpgbcVMoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=oec5CXSL; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-323267adb81so6415700a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 08:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1755616835; x=1756221635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IEMm8uKDjjFHpgykUaxgoa+ApFNTkgehyJI7jW32h00=;
        b=oec5CXSLiZpDuztTTa13iJbcB/Zoh9yAUZVRW7DaydXtrgg2qD7hZ80oczvRs5ktFT
         XOd847wmrqGmO+r/qlSCBNo7hqmJvFQvXGL5Q6jstSoPu7DYFm0wU5C7ArRP/9Y/SsP3
         UcDCpFRytSEsW18XwnED0qGTP4S5pmASh2+RQMI7ytqJE8Qt8N3I1n+xECNWv7g89pLz
         RX1Vt4OsC8T2PcVmLx6EfaYGNVvEYmgoCCWcMWtCk9zQyN5tZTKwqrVksdmu8Peb1APt
         Raa9zDkrTnxgifBw77RALoRiJBjPszvWkhJP/NMjpNdfIbwcwIfDEqtOFlCs5wBTpeAc
         rHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755616835; x=1756221635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IEMm8uKDjjFHpgykUaxgoa+ApFNTkgehyJI7jW32h00=;
        b=vVKPwpdIJgRdQTkeqV1vWJotRGwWVS1KtL+DMtKHPrZQHeU9KPL1BCNd/7nqJ/V6DX
         ZK/XxS4H3lhQzlxVoPWzkMNgGfkM6DOIGJFsSngUkngCEH3PBjXJxtc0sB9RhRmR/AHl
         wf2tOXy80Aj0TXJZptL7wM1jt3l3l+Hw/heDMThw7GaSnE/Ad65h/r/x8V6/x6L0ULir
         X0xTiP4R94Ir1FOJh0eIfnrgXRKZNuGF9erbxlIT6yXWu1/njW6qkm9vSY8bxNzNjY24
         PWrlCNB9l/Aa2LhYuH0T1SoUn53CrGVMsdP3bw8ZeZA6mMQvq25dJyHpIzzjGHDlIuau
         C9Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXiAFfeAS7ktvJ6OOaiYep6n3O6xPGPH0MznoaikHjWZGmakIcX1UBqWFUrZY7hLDgw2yxn2UyS7Mh0nH8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy/7wB03I1dFBbUkAKyoml6+38ZzG6pn6y24S+AWOpXjfPa9bT
	aHDPlVuIdcB57hpAafq8KfEYseqnO7MdY+9FHP/e0nGDo+evr6zBt+R6xMuDK6N1k0ELSUBRoR3
	uGlAsK9pqWQdn
X-Gm-Gg: ASbGncuyH4o5zDEsp4y4hR42nxGYJKai7oM/4FmB/dlD/Zp9M1VS2DPhayzSPcn45kr
	wXa12X0W/JRCfUhvM4zgAX/yY1WMVdUDoIcwKWQ/uyLdpUoBSrjGK4ZFvOKwVgDip48wQs4+2bi
	Ja59LCDffjPo0YU7oXF6vnVKo9tkpI9qxqPkwlycDUXYyUUzNySQ4Rze5Xn2t4iwmgbpyHlgXdz
	ecEkbo0cGVnkkgNeYgnEDGIcLIMm/OkWKaxATGtFRAY24GT5GdUYEsiDzn5FBsOaANtNadMRYQ2
	Vst4ADKZOKZKiH0vDg9J9d3PFeI3USOCbIS0cto0lNoNLJgUEtqBS8OM0GXXuCq+O8il95FzDqP
	nAvfZyFy/xHC8pzirPUfDCuU/sizQJOCilPZ4HnuOkB+LyDqt
X-Google-Smtp-Source: AGHT+IGykYJRPbFbofmtPcUluhHPVwhSmJLbKeQ3EY9zb5I1jlXalnsi2pHhddtB8yOO4hX9AXZOnQ==
X-Received: by 2002:a17:90b:3cc5:b0:31f:762c:bc40 with SMTP id 98e67ed59e1d1-3245e59151fmr5112184a91.16.1755616834733;
        Tue, 19 Aug 2025 08:20:34 -0700 (PDT)
Received: from localhost.localdomain ([193.246.161.124])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d546ce3sm2771227b3a.103.2025.08.19.08.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 08:20:34 -0700 (PDT)
From: Lei Chen <lei.chen@smartx.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] kvm:x86: simplify kvmclock update logic
Date: Tue, 19 Aug 2025 23:20:24 +0800
Message-ID: <20250819152027.1687487-1-lei.chen@smartx.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series simplifies kvmclock updating logic by reverting
related commits.

Now we have three requests about time updating:

1. KVM_REQ_CLOCK_UPDATE:
The function kvm_guest_time_update gathers info from  master clock
or host.rdtsc() and update vcpu->arch.hvclock, and then kvmclock or hyperv
reference counter.

2. KVM_REQ_MASTERCLOCK_UPDATE: 
The function kvm_update_masterclock updates kvm->arch from
pvclock_gtod_data(a global var updated by timekeeping subsystem), and
then make KVM_REQ_CLOCK_UPDATE request for each vcpu.

3. KVM_REQ_GLOBAL_CLOCK_UPDATE:
The function kvm_gen_kvmclock_update makes KVM_REQ_CLOCK_UPDATE
request for each vcpu.

In the early implementation, functions mentioned above were
synchronous. But things got complicated since the following commits.

1. Commit 7e44e4495a39 ("x86: kvm: rate-limit global clock updates")
intends to use kvmclock_update_work to sync ntp corretion
across all vcpus kvmclock, which is based on commit 0061d53daf26f
("KVM: x86: limit difference between kvmclock updates")


2. Commit 332967a3eac0 ("x86: kvm: introduce periodic global clock
updates") introduced a 300s-interval work to periodically sync
ntp corrections across all vcpus.

I think those commits could be reverted because:
1. Since commit 53fafdbb8b21 ("KVM: x86: switch KVMCLOCK base to
monotonic raw clock"), kvmclock switched to mono raw clock,
Those two commits could be reverted.

2. the periodic work introduced from commit 332967a3eac0 ("x86:
kvm: introduce periodic global clock updates") always does 
nothing for normal scenarios. If some exceptions happen,
the corresponding logic makes right CLOCK_UPDATE request for right vcpus.
The following shows what exceptions might happen and how they are
handled.
(1). cpu_tsc_khz changed
   __kvmclock_cpufreq_notifier makes KVM_REQ_CLOCK_UPDATE request
(2). use/unuse master clock 
   kvm_track_tsc_matching makes KVM_REQ_MASTERCLOCK_UPDATE, which means
   KVM_REQ_CLOCK_UPDATE for each vcpu.
(3). guest writes MSR_IA32_TSC
   kvm_synchronize_tsc will handle it and finally call
   kvm_track_tsc_matching to make everything well.
(4). enable/disable tsc_catchup
   kvm_arch_vcpu_load and bottom half of vcpu_enter_guest makes
   KVM_REQ_CLOCK_UPDATE request

Really happy for your comments, thanks.

Related links:
https://lkml.indiana.edu/hypermail/linux/kernel/2310.0/04217.html
https://patchew.org/linux/20240522001817.619072-1-dwmw2@infradead.org/20240522001817.619072-20-dwmw2@infradead.org/


Lei Chen (3):
  Revert "x86: kvm: introduce periodic global clock updates"
  Revert "x86: kvm: rate-limit global clock updates"
  KVM: x86: remove comment about ntp correction sync for

 arch/x86/include/asm/kvm_host.h |  2 --
 arch/x86/kvm/x86.c              | 58 +++------------------------------
 2 files changed, 5 insertions(+), 55 deletions(-)

-- 
2.44.0


