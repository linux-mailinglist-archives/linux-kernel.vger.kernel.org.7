Return-Path: <linux-kernel+bounces-820340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1993B7C433
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BAE4463F2C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 09:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263DD343D7C;
	Wed, 17 Sep 2025 09:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="qqO+9jS1"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CDC30BF59
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758101317; cv=none; b=gJvVbHEuuz5F/0IwoeuBkWK3ujacGrnKj6BxzBBaucXS9RwKVhaav+2QKQtGQ6LQuz9fFzsNOwh24ZxgTTuLt/YwErQZihmi4vF3yuXFKSdgjnWNOz/iAjqK2y5p26i6t/jqnRcS+5dDLQo0tl/2KVRxsTz8LVBqOUGPHvBbzkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758101317; c=relaxed/simple;
	bh=S0Oe46tsoZZQQ29GDYRq7t5r8AFIzm0CHvummlNxQQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pxeIyz1Hs0V8a990UstX6WHLCBeljxTwwX5vUl20ieucDJ1DIHFSpbkpcmuPJ6yfwjY8XbcVna+iBZpox5+iodUYUWo9LYdX9pXGnpWqCnNBPq7zxUklNcYyYTEx3x6hjQBeyuZLTq7QNFwM9ZDE410R5TNYQcq9WXfFnvPlNXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=qqO+9jS1; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-267a5aeb9f1so20076915ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1758101313; x=1758706113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qEv+391m/JkY9kaqE3gl8eXIZOO7uG0r/XVqxW+72wE=;
        b=qqO+9jS18WyS5DjTAqTeCYlTmetT+jIq9JQ1M2munm6Wzg7o9cYhZ4g5OJ+ZmL4To0
         U7SlOQ+/+E5QIwLEcT9I84OHXy8zz65ZgkJuSRvjlhKxqNOS38rBEnipFg43UYWzv9+1
         C+G1Z1HqzlcBmDUdMTc1+ysRbnsgT3QYpBowtOxCLti2cFq0OYcrTpGDm5kOCRPm5vvb
         nftMn1iOgfJiJTDuk29ln863U+UXJQHPZmXCPQNjasBEfWQQJJ/Ybrt+QfjeDqSSH225
         v9gf6nVazi4ZMBUYN0wahZNTjbyElIklHAqDH7oj10pWg00toZGldjhey/lZ8qwCMEth
         Tbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758101313; x=1758706113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qEv+391m/JkY9kaqE3gl8eXIZOO7uG0r/XVqxW+72wE=;
        b=tyH3MAb2HNFBoPI5fZz7NNdi9AuL6Bte+M8j/4+38kjqsmUwmuRinaen/6SXfRYKAq
         i17xS99HqUINIDZyiCpiQysywLxgst5p+472zE5SnBjMSNJjqCIOyxt5iTXWlcyOVhi1
         mmHmx5IyO8XhcnjkYyeu4UsYvZUewgEs76PtJ52nwILjKmDU2ds7bK+TvUkGyEGA8pzn
         B4fQpudUCQ1IL6pUST2XcbmFTtOsdjnvLOsjJEMei5WcCQHRQ2IZANw+YGyqvZk6wsq/
         qBxTwf3dhWJzLj0ewLMxUas36q5yQkTKMXauItgtbmDRBBxrsx9+rdmD9gbEbWj0p7JF
         Q03Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHb13hWfw0pFmgDUWQrRFRFsVL0bEVpA22twAwbHr6P2aA5aK/ZBZOgZiiATy1uAWV2m9Czm7k21cot1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFh4I7NgxpowBEukYwi6gWABuLG+FqZ3lobW5+/M+fcrwOULZK
	Okw++rti17ODMZCgaPPwZYIL2HaTLqL+aGZldeHifh+sREjYCxQMss9wdMclZCPJ2LM=
X-Gm-Gg: ASbGncvQeu8EshcxO46SYd5x0AyZMm0h10ribBJBKMCQUI74jmh60XZeFarUAElZDEL
	/XLdNDx0QNYYQa8DDQZGzyJVJoe63g03dMpDW0S6aW8b4nzTu6UyOWgaPly60hZ4WtDa3XbEpiM
	yEe/ZyinXAyAURBg1VSi/Xb+MbyA9r4ucUS/p0TQ5DPRT87wCtm//2H1O+ZY57ut9NEEzljpx2s
	h3qXpzKS+TaEj0rtOCqrdQrrQmM6UGiqzaO6E2kV+lYi19EeVfAe/f5V8zropLth1RUzOwvQ9kk
	tlzYkOQ+JI3gMsYv5INlG5q/rVgG+xdbMvHim+SOL6hPE0AncyFUrfyTp2reG8qM601ZofdqZUm
	BZLJNtSCPLTkv0Vb3jo31skSMR5OhA0xurOGW1rSEZBR65jzGvMc=
X-Google-Smtp-Source: AGHT+IHhbsgB2Q3Kh5WyQVZOJDD1xHNwQPX/mtP3TCwpKgY/yR9ATV1q0YKkCnNjtrFK1Y6/JhyJeA==
X-Received: by 2002:a17:903:2f87:b0:262:4878:9dff with SMTP id d9443c01a7336-268118a5cb9mr19386995ad.12.1758101312823;
        Wed, 17 Sep 2025 02:28:32 -0700 (PDT)
Received: from localhost.localdomain ([193.246.161.124])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25f4935db09sm137047885ad.61.2025.09.17.02.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:28:32 -0700 (PDT)
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
Subject: [PATCH RESEND v1 0/3] kvm:x86: simplify kvmclock update logic
Date: Wed, 17 Sep 2025 17:28:21 +0800
Message-ID: <20250917092824.4070217-1-lei.chen@smartx.com>
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


