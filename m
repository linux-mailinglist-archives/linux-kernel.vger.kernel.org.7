Return-Path: <linux-kernel+bounces-850852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CE2BD429D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9314334F3C5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B123090FA;
	Mon, 13 Oct 2025 15:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Igei7WhK"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AD626E6E8
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368532; cv=none; b=e901/tewGo7zmregpeTDgRPS+lezgVDItxoMQS11PMQyb3djwP+1bZi8Xinh4ng+nSqpCwtl1J6SAbSnBVWtzujMxmV+zsIM4fuynVPS9Uc/LAqXqelhlDbxKqidMGywbZrCQWEZ2PIbS4ifoa1N4aIvg0FxoIxdbkTavLaF9nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368532; c=relaxed/simple;
	bh=u9a3zosxSdz3WZpPJYTywNjxVaWRBJXzveMfBERek7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EX3P4Ug0OR4ALBCtGFqsEa+vGK0bPXtAygfweqR0INlK90A0YMsTC0uCjQIfLMoIvpEfyarXzxTc2TUIvGQgGERKZ/iJuKhjn23x3aKu+LC32miBWqVNTnIVuIzPWGAYm0UHYkGf1l/OOhCpmX2LjyweKj3ns9ffU3a8EyFKbeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Igei7WhK; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46b303f755aso37727695e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760368529; x=1760973329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H9v2BaCzqTwwaKihxHneX2NKtRg+AsrUK2wCvz8acXU=;
        b=Igei7WhKP5Kaz1JuzN2EnBPWGVEewypfuD6vJmbwH+Cy3T41RVr8URMXUjWTgRF3PM
         cMz/L8mjH3/Li2MzJp3LKA5yCja0tqM6K0aLswC2VsgG3UXB9OUHE7R6j9lPEZdGC2bc
         942h+8L/L5bhnhpgrEA0DSlR5m9s/jO+a1xWnELlCLsFRPC75S6nwvxHj0/PRwxtGgjI
         6GtnsDzDnEYr2YO7fWy3e1lOeTYqo8RgLvwbTno3K9BHRL+UWbVM9mWCFqppK9b7Oy29
         aj5FxRNjG3XhwwAo1L551Moa2Vm+Dp8LAKgcR7DVWcFkHdiKWb5bb5Fff1iAAwBl2G9V
         888A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760368529; x=1760973329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H9v2BaCzqTwwaKihxHneX2NKtRg+AsrUK2wCvz8acXU=;
        b=HxooMzxEXbL38HqgOKchzbD37Ax7wptNLdjqaXD2ndw8d8mim4g7/WDlz2J7dyMvO4
         e6sVeiRFCGZ/wCZEb/9QqVmb3mtkJwUN3/LqlIAj687q+WKjN4oNR/pAzLuGW5cOcDmh
         txoEkpeuZPOiGsp48DD+2MGiC18mvde3pn0TsIc0M4dO0bYZ0DgFLSl1/JNFYpiw+se5
         yG+0jjSl0/YU8fp8ftcPgcGMzBXhfR3Yko+7vAjegFI8o9F0OQqRJduWwEUhkwZnzqXc
         oGrFAkOfbTz6Ul05vpLU2X69ezPwYFRT3C1CqKuxh5O0S+py38IGnFdG5nxXou33BQbo
         xD7w==
X-Forwarded-Encrypted: i=1; AJvYcCU1yPg3k0XRPZpJB4rEf5snxPVNed01BN3rRgreLsW3TOzGKOpOB8HNOz1jpvzWhIdJr4J0qDbH8u82/rU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQdVV1fYIUEBH67moKqjehVh/pPKrKoAbzJD1Vpfe05eI1j7oz
	d/GCNyBl5PW2h2WWvq52NlWqvSeVy+deJRYH5PeqOyXdjXhp8Y//Ewk9
X-Gm-Gg: ASbGncsV2s+HOZb/+6kEtgg+3oYkWOcuH34cYyEotefpoOJ/6xryb4xjibQe1mCc89r
	vu61awUx2bufVSy33r71atHobrcL5kZkLc6Fs1F6mBgtNWKAKplKfCWdPy4iJL3hR6A2qKHWpAL
	jQV96ah3FZIkmDc/nCKaRfhkrGMJMymXYQ4ovedEcItiTmU6Z2XlBQFMB8ss+gzCFttJ8+E8P1t
	aQffHnQJpKHpdsmcDRqZDeKDJ214DitJVufXuPY6WsnUv0Hzho66VtVJBOEW1IJI5i9WnhwaIWW
	/l+9SxfflWzX3oA9A2qsav6tOinCJoE66ZDp/nnsg6dtj7acZq+SJAX+3JJQ5pAHaruG6i9iBrl
	qHBdNEt0Ciw2IcuZpC3ciWVhH677+L/h6vGsEjz8JoTWpyiDVcA8sxBF0erurcpPI+gKweBnfCI
	qw5rEzUd3wiHMCh9k=
X-Google-Smtp-Source: AGHT+IFb9QSIj2pT5DqJHOGWLZeoKzR1HcGUwSCz8TPcIH2zmr4COlYJoCPacXO6TFFsZZUZ1uzZWw==
X-Received: by 2002:a05:600c:1c23:b0:46e:32a5:bd8d with SMTP id 5b1f17b1804b1-46fa9a892d7mr154828545e9.3.1760368529113;
        Mon, 13 Oct 2025 08:15:29 -0700 (PDT)
Received: from f4d4888f22f2.ant.amazon.com.com ([15.248.3.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab36a773sm135545825e9.0.2025.10.13.08.15.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Oct 2025 08:15:28 -0700 (PDT)
From: Jack Thomson <jackabt.amazon@gmail.com>
To: maz@kernel.org,
	oliver.upton@linux.dev,
	pbonzini@redhat.com
Cc: joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	isaku.yamahata@intel.com,
	roypat@amazon.co.uk,
	kalyazin@amazon.co.uk,
	jackabt@amazon.com
Subject: [PATCH v2 0/4] KVM ARM64 pre_fault_memory
Date: Mon, 13 Oct 2025 16:14:57 +0100
Message-ID: <20251013151502.6679-1-jackabt.amazon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jack Thomson <jackabt@amazon.com>

This patch series adds ARM64 support for the KVM_PRE_FAULT_MEMORY
feature, which was previously only available on x86 [1]. This allows us
to reduce the number of stage-2 faults during execution. This is of
benefit in post-copy migration scenarios, particularly in memory
intensive applications, where we are experiencing high latencies due to
the stage-2 faults.

Patch Overview:

 - The first patch adds support for the KVM_PRE_FAULT_MEMORY ioctl
   on arm64.

 - The second patch fixes an issue with unaligned mmap allocations
   in the selftests.

 - The third patch updates the pre_fault_memory_test to support
   arm64.

 - The last patch extends the pre_fault_memory_test to cover
   different vm memory backings.

=== Changes Since v1 [2] ===

Addressing feedback from Oliver:

 - No pre-fault flag is passed to user_mem_abort() or gmem_abort() now
   aborts are synthesized.
 - Remove retry loop from kvm_arch_vcpu_pre_fault_memory()

[1]: https://lore.kernel.org/kvm/20240710174031.312055-1-pbonzini@redhat.com
[2]: https://lore.kernel.org/all/20250911134648.58945-1-jackabt.amazon@gmail.com

Jack Thomson (4):
  KVM: arm64: Add pre_fault_memory implementation
  KVM: selftests: Fix unaligned mmap allocations
  KVM: selftests: Enable pre_fault_memory_test for arm64
  KVM: selftests: Add option for different backing in pre-fault tests

 Documentation/virt/kvm/api.rst                |   3 +-
 arch/arm64/kvm/Kconfig                        |   1 +
 arch/arm64/kvm/arm.c                          |   1 +
 arch/arm64/kvm/mmu.c                          |  73 +++++++++++-
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  12 +-
 .../selftests/kvm/pre_fault_memory_test.c     | 110 +++++++++++++-----
 7 files changed, 163 insertions(+), 38 deletions(-)


base-commit: 42188667be387867d2bf763d028654cbad046f7b
-- 
2.43.0


