Return-Path: <linux-kernel+bounces-621243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40110A9D69D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Apr 2025 02:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA843A7FCD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Apr 2025 00:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6607718BC36;
	Sat, 26 Apr 2025 00:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lybnRj71"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7F51865FA
	for <linux-kernel@vger.kernel.org>; Sat, 26 Apr 2025 00:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745626444; cv=none; b=kmaEUKyXF5bw7eilR/v5wEfpSFQ1BxAXWE+IJM+j1TP95zGgHwlkveqjrCHVcojA5SOHGpOKmLX2/iMnanIoGeEMJku1FlaqEkhX5V4twT9/efje5kK3iX6+41uKChb7c/pLp5S93zZ3T4KCSKHyw54W4dsv7Mw1HM0tJXt4l2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745626444; c=relaxed/simple;
	bh=5ZI1miHdJz7wfQVJ3AKTnq8ZxdU0aecNlHa6tzNWZxE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uLSh0nJhHSyK9efgIVV3z6TMTolzeS4PXTFlVF1u8R42PGybs/WdnLvAobTk8szDC1c2lPY7Gqf/ZyLpunstXPBgSox6hAMlggtPNviKB7RYP4i/wMhmfpgPdBy8RduoG2QGAu8d+Ki8EDsTqo/hpCguH/Tj4TD4oXiwmopw0ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lybnRj71; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2242ade807fso46554625ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 17:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745626442; x=1746231242; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxpVCBLHTfcLtbj0gBx4eYSK7GUN1WhxDLmW+4nAY1I=;
        b=lybnRj71bcsgCzrsxS62lOXwTsxB+aoTRgUedTWvZQ9SQHi9YkxQyifFe8QytC+RcE
         sZd4BWyrzwf86MXgPEV95GYGbwxwF39To/u0H+/WPtO/YA19J2x74vjnbZineKCb1UrH
         FMAOoqKx5v94b3MA6C8QideorQoXqRksdlebX1KnS2LVqkKc+vgnV/Zurjmi7NOGywNr
         D0wvtSMkf48+HLkg+9ZE1rK4b3ds6mHOvL7R56SST9YUon9eEdP660N7W/jLruMzJ3dT
         Hwiam5MacLwrfznZPk7/d9uAd7mpPKTpqSuVogjS3JjOovkbQ79kWqg8MY0JBcMLC0cE
         d4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745626442; x=1746231242;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bxpVCBLHTfcLtbj0gBx4eYSK7GUN1WhxDLmW+4nAY1I=;
        b=S0kjn2J96i6WHCryEu2f5vstGuG9WUrMp4bjifb9NyeFfjxxPd/oLh5HRX3Cw7c/Em
         tjXDIsuQl/9mQ16vis8lAHh7fzx1XDvWDzD0wUigDd7hPVx046NDWk/JQwvOzx6/8WxI
         ZXDRSJfQieRpJOpilplqToBYD+tOLe9TmGESK+PIT2btzJkjU780j0YfeGcQM+EJMoTA
         CnVT/S/ph58bdCACmJg8ARHJvcwWoGpKUZKp32ERtjAyfu4qcEJIDekArT/0wdX+pq2d
         tTmFgvJGn/9CMcsGjsAL+6FgNnfMfsvIZYnX1A8UrrDjFL/m3IQJOf/jjI39Qh6rcZWI
         PzYg==
X-Forwarded-Encrypted: i=1; AJvYcCW3mPMuKS8KyBFjqSE5wCfV7t4Ksy+ZEhwNm/+1LiuZ4GOnl6+K9Wu7YAtwAEFvp5gmsZG0eg5wpJG/Xp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF/DFvnslMuGyArdmNhh8oE1SIxEDR52pZAR2oOIQ9mzUEFwnx
	/JcZ4qpSqLEj/JenFt1eQuL9JqYSQXOjmx6LZwnXHzkyg99mb11gzvLSMg1/iZnMMRzIaShRcm8
	iLw==
X-Google-Smtp-Source: AGHT+IE2zeHpQPZegtnClFnzj4+h59uTeKaFQ58TNuLPt2n5wY8qYg8PRH47N7frx+oBKxsilN/R1JEII2E=
X-Received: from pgns27.prod.google.com ([2002:a63:925b:0:b0:af0:e359:c50a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ef4f:b0:224:24d5:f20a
 with SMTP id d9443c01a7336-22dbf740c03mr67564265ad.48.1745626442696; Fri, 25
 Apr 2025 17:14:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 25 Apr 2025 17:13:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.850.g28803427d3-goog
Message-ID: <20250426001355.1026530-1-seanjc@google.com>
Subject: [PATCH] perf/x86/intel: KVM: Mask PEBS_ENABLE loaded for guest with
 vCPU's value.
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Seth Forshee <sforshee@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

When generating the MSR_IA32_PEBS_ENABLE value that will be loaded on
VM-Entry to a KVM guest, mask the value with the vCPU's desired PEBS_ENABLE
value.  Consulting only the host kernel's host vs. guest masks results in
running the guest with PEBS enabled even when the guest doesn't want to use
PEBS.  Because KVM uses perf events to proxy the guest virtual PMU, simply
looking at exclude_host can't differentiate between events created by host
userspace, and events created by KVM on behalf of the guest.

Running the guest with PEBS unexpectedly enabled typically manifests as
crashes due to a near-infinite stream of #PFs.  E.g. if the guest hasn't
written MSR_IA32_DS_AREA, the CPU will hit page faults on address '0' when
trying to record PEBS events.

The issue is most easily reproduced by running `perf kvm top` from before
commit 7b100989b4f6 ("perf evlist: Remove __evlist__add_default") (after
which, `perf kvm top` effectively stopped using PEBS).	The userspace side
of perf creates a guest-only PEBS event, which intel_guest_get_msrs()
misconstrues a guest-*owned* PEBS event.

Arguably, this is a userspace bug, as enabling PEBS on guest-only events
simply cannot work, and userspace can kill VMs in many other ways (there
is no danger to the host).  However, even if this is considered to be bad
userspace behavior, there's zero downside to perf/KVM restricting PEBS to
guest-owned events.

Note, commit 854250329c02 ("KVM: x86/pmu: Disable guest PEBS temporarily
in two rare situations") fixed the case where host userspace is profiling
KVM *and* userspace, but missed the case where userspace is profiling only
KVM.

Fixes: c59a1f106f5c ("KVM: x86/pmu: Add IA32_PEBS_ENABLE MSR emulation for extended PEBS")
Reported-by: Seth Forshee <sforshee@kernel.org>
Closes: https://lore.kernel.org/all/Z_VUswFkWiTYI0eD@do-x1carbon
Cc: stable@vger.kernel.org
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/intel/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index cd6329207311..75a376478b21 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4625,7 +4625,7 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 	arr[pebs_enable] = (struct perf_guest_switch_msr){
 		.msr = MSR_IA32_PEBS_ENABLE,
 		.host = cpuc->pebs_enabled & ~cpuc->intel_ctrl_guest_mask,
-		.guest = pebs_mask & ~cpuc->intel_ctrl_host_mask,
+		.guest = pebs_mask & ~cpuc->intel_ctrl_host_mask & kvm_pmu->pebs_enable,
 	};
 
 	if (arr[pebs_enable].host) {

base-commit: 2492e5aba2be064d0604ae23ae0770ecc0168192
-- 
2.49.0.850.g28803427d3-goog


