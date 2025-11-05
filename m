Return-Path: <linux-kernel+bounces-886560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3510C35EFB
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 14:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A65344FABDD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 13:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D511432549D;
	Wed,  5 Nov 2025 13:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LF1M03Aj"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E2F32038D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762350911; cv=none; b=pY4QY8rLLrUgQwiVxAwmxeH2HwDJLqeKuTRZn3yfCLSaTqpRmh/nF6Pm6IcrUYGSWLwkWSyD2YwAOCVfnfS+Ign9Xut/ymuKHd7Z1fklPGa242ckxou5Sh6tuGp39thbitZcs8ADhrjdVHpbtu0Or9ex2eOPU7yK2z6uhhMMfU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762350911; c=relaxed/simple;
	bh=SPXdnNRcrMHhEFoAZ0SK2hGx2kpGzR+ek6KvyCQYrCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fg3+IUlPGqByP2nFNQt5DgGv4OAHO8ZZmlGRzo5ae1ncYv4VumSyq7szsE/yOSactHqfS0lmEs4AGezwtfp1C32nGPdz5SDvS0ttAbQdO4/XgGgKEimowfn6wX47Bk283aApO8JRpKfhnov0Frbm7To8G7iMB5LY8XneE89Ymsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LF1M03Aj; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7810289cd4bso7509043b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 05:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762350909; x=1762955709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OJlKW/m6trI8y99S9SvdMNz+LWIPmPAKJyUL1bEks0k=;
        b=LF1M03AjRI3jiTOMvbiaLNBX60oB5Hiw/JkYCwBB+F4i+UMWZM+T6h9oq0SEvaiVpx
         FNOQhE3RJ/qu47SgqlaYfyZHOns4GLmx77JZwCDBYxnJgx1FyooI4zB8AgTvk7IzmJAn
         6LFn2u+TGYpu+drinbIgtNnzKrlHZ3rlwr0qLNt6h8nryuNDFCVR9irF5Lh1Kksp/lul
         k4vrcK51T74imaLAnRxBnYSdsUyboktpTwIn/JB/UMbjp6gbtAiM738d69otf+8Gc5yR
         yxvE9aajHQyC1sTAZQbqRlFEapP4LW1dBuPZPUh+UMQk7ITcVbjfXwsu9GX+LJTr7Qh/
         zwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762350909; x=1762955709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OJlKW/m6trI8y99S9SvdMNz+LWIPmPAKJyUL1bEks0k=;
        b=q6R25Wkn1+RcijPbwojS86cA+c08g3qYpyG27qsT/BBBBII/6iIyF/mlNG0g2s7obQ
         xYfMkyX04FzMBGs4beKeXWfno3IG4aQDF7sAByev50hzZNuPl8mJWLagKWOOjnMMC7jN
         CEmnXHcxYRcWXY3Ms5THg2nndlOPmiIJ9TxdsWtmszrInnlG2HfYlMMEoD7BE4qrOWGt
         1ayNKuQEcfjboOyiJqTFoPtE+7AJ2L9Op9Aw66aJ4rBt5RxlMwo0LRPG+O5W1atcO60F
         qEzQ7p2uyW/hfbo5cSNTRSOzkB158ITxaLSCes73RR0OybBh06e7USHTshj5gnWfzlAL
         nDUg==
X-Forwarded-Encrypted: i=1; AJvYcCV693KNta5LiGFLYf8MIP1/2QXzT528O1fj2cOPMoepETxoQoXXsuc8TOvwAwMqRjQ+wJgUQUSs53400O4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0o6jCiS7aVPsJ9L8hHDUz7JveR1q/DM6KItJ7OApNQKVTwiyQ
	mnd/DiNF+w+1V68/8TRjP1k74LgWm4WBAe27cds1r1q7oqrjlAhm+Rkx
X-Gm-Gg: ASbGnct1XmEfhCTwbmNby1apZEAQcHW5PlqTOf7bg+nEv2KGUbQRtMMXl1XtvivXPhb
	k/lQskCEEgTwjt7mh+zRKajJ1nBYpbQ0KHJafU8urzBpKCZ220a3zJyEfHMhU4zBX8Vw9Y0bgfm
	U7zywNtNg724SwWBqTJI2JHVgfknxh1XT9QVzbqC8YZyri0brhmZwPO2n6Aj/QHzCcbWHJUi4XF
	hfvqGg8sgpZlUf13LxwQOUqW2QKOuPUh3ZG4hYQjY2S71s1dBWSEuwULqg4VXpwmge5C2cof5NB
	1GdJl/VxHEl+1I+sWbtA4xw3AB5Vaj8BRHHQ9OSFyRkmZD1P4tG9BizvypJVf4qlWVq4po8u0qV
	aXBaoUNk3/IGsDlFNRKrZrepA9LwCRT/CjfdfiCdzSn2qW4dENxvbPhFs/ThywbDYRtf06DWiOQ
	yO3KAtFCjFtoTwuQ==
X-Google-Smtp-Source: AGHT+IGvBZtGexCqPRCEXHwELt+N8SgQVO5WlxnDkfj6ON9Mo7Xjf5egZdjImwAsnQkJ/f2ooOccWA==
X-Received: by 2002:a05:6a21:338d:b0:33f:4e3d:b004 with SMTP id adf61e73a8af0-34f8601d2c6mr3941581637.47.1762350909040;
        Wed, 05 Nov 2025 05:55:09 -0800 (PST)
Received: from localhost.localdomain ([129.227.63.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd3246d33sm6467321b3a.13.2025.11.05.05.55.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Nov 2025 05:55:08 -0800 (PST)
From: fuqiang wang <fuqiang.wng@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Marcelo Tosatti <mtosatti@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: fuqiang wang <fuqiang.wng@gmail.com>,
	yu chen <yuchen33988979@163.com>,
	dongxu zhang <dongxuzhangxu910121@sina.com>
Subject: [PATCH v4 0/1] KVM: x86: fix some kvm period timer BUG
Date: Wed,  5 Nov 2025 21:53:37 +0800
Message-ID: <20251105135340.33335-1-fuqiang.wng@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

This patch fixes two issues with the period timer:

=======
issue 1
=======

If the next period has already expired, e.g. due to the period being
smaller than the delay in processing the timer, the hv timer will switch to
the software timer and never switch back.

=======
issue 2
=======

Resuming a virtual machine after it has been suspended for a long time may
trigger a hard lockup. 

Marcelo also talks about this issue in link [2], but I don't think it can
actually reproduce the problem. Because of commit [3], as long as the KVM
timer is running, target_expiration will keep catching up to now (unless
every single delay from timer virtualization is longer than the period,
which is a pretty extreme case). Also, this patch is based on the patch of
link [2], but with some differences: In link [2], target_expiration is
updated to "now - period"(I'm not sure why it doesn't just catch up to now
-- maybe I'm missing something?). In this patch, I set target_expiration to
catch up to now.

=========================================================================
other questions -- Should the two issues be fixed together or separately?
=========================================================================

In the v3 version, I split it into two patches, but since in this patch, if
it is found that the advanced target_expiration is still less than the
current time, target_expiration is updated to now.(If target_expiration is
updated to 'now - period', splitting it into two patches would look better)
This would cause a reversion of the code in patch 1, so in this version of
the patch, the two patches are merged into one.

But keeping them separate helps clearly show the two different problems
we're fixing. So, I still don’t know what the best approach is. Please give
me some advice.

Changes in v4:
- merge two patch into one

Changes in v3:
- Fix: advanced SW timer (hrtimer) expiration does not catch up to current
  time.
- optimize the commit message of patch 2
- link to v2: https://lore.kernel.org/all/20251021154052.17132-1-fuqiang.wng@gmail.com/

Changes in v2:
- Added a bugfix for hardlockup in v2
- link to v1: https://lore.kernel.org/all/20251013125117.87739-1-fuqiang.wng@gmail.com/

[1]: https://github.com/cai-fuqiang/kernel_test/tree/master/period_timer_test
[2]: https://lore.kernel.org/kvm/YgahsSubOgFtyorl@fuller.cnet/
[3]: d8f2f498d9ed ("x86/kvm: fix LAPIC timer drift when guest uses periodic mode")
[4]: https://github.com/cai-fuqiang/md/tree/master/case/intel_kvm_period_timer

fuqiang wang (1):
  fix hardlockup when waking VM after long suspend

 arch/x86/kvm/lapic.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

--
2.47.0

