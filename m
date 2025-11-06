Return-Path: <linux-kernel+bounces-888921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FE4C3C484
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 03FD34FFF85
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D50033DEE5;
	Thu,  6 Nov 2025 16:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="FMqCrZK3"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8562328852E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445270; cv=none; b=IiVMrDXG85kK2NlcCdJynnUwE967Q7euIp9ZCtEkVT5bnT393eYspqeWRtf67Bs6QeIYSL6FPC/WEjJxlTqHwTajeK+Q5lX9X/qhoxP1usWT+hngHtJfeo2H06BSRTH0HTCue7CHr7i0/Msm/YB9ylvcCNme/Yq/+SBz0RTu8mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445270; c=relaxed/simple;
	bh=4ZjsGYfXbmMvZwQ8n4htYvu+MTNXcoG47WYUZFVEgnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NCjFC5z2I2TfJvrq/5fStgpMcg+tbMzXq32WBBtXEQaawAmYYdq97WcI/+BLN9Xsp1/ng9qd1NiKiTQCGCufcY5ecu1M/COPSxvlXY3GUeodDHBnyL69S3XdrIJWlKWUIEjZh7BPMiwK33dlJwAhs4YGW2v+ozxjNTl5EKFdVZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=FMqCrZK3; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=MqjdHvvQt+5moiTUatIvmnnJusOWuTmIDSyMeBxekmc=; b=FMqCrZK3jXXYQMVFQcCaKLaxf8
	+7f2S0nKYDA5/M2smBRXBVtCR386MK2O9GOlLPmTYcIAoeMmt/BMwFDwy4HNFBPdp1zr60uF3JzP6
	7PPDN0srM8M4OufDvh+OB57hOrEafpifrUKfivqR5xvxtWbNgEeWWYCZr4uR4/5HLhhh1fEhDQTeE
	iXccKdCga1r14Puq1wt78fNvzTKsSiw58NITyy9vWKojb4rzBvg0br2IwDrZArhRney8YbIo4RPIM
	NFBXwXIdhxfgRQAj3wdZ4NnhljN8IxbXynDROWkp7EdxXW+xs/rtsgVkCaAf91E1yOecyP8qXlzHc
	srCldqpw==;
Received: from [191.8.29.151] (helo=steammachine)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vH2WS-0034gL-LR; Thu, 06 Nov 2025 17:07:41 +0100
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	Ryan Houdek <houdek.ryan@fex-emu.org>,
	Billy Laws <blaws05@gmail.com>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [RFC PATCH 0/1] arch: arm64: Implement unaligned atomic emulation
Date: Thu,  6 Nov 2025 13:07:34 -0300
Message-ID: <20251106160735.2638485-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch proposes adding kernel-side emulation for unaligned atomic
instructions on ARM64. This is intended for x86 emulators (like FEX)
that struggle to effectively handle such operations in userspace alone.
Such handling is required as x86 permits such unaligned accesses (albeit
sometimes with a performance penalty as in the case of split-locks[1])
but ARM64 does not and will raise a bus error.

User applications that wish to enable support for this can use the new
pctrl() flag `PR_ARM64_UNALIGN_ATOMIC_EMULATE`. Some optimizations and
instructions were left for future revisions of this patchset.

Emulators like FEX attempt to emulate this in userspace, but with
caveats in two areas:

 * Performance

It should first be noted that due to x86's TSO (total store order)
memory model, ARM64 atomic instructions must be used for all memory
accesses. This results in unaligned loads/stores being much more common
than one would expect and the overhead of emulating them significantly
impacting performance.  For this common case of unaligned loads/stores,
code backpatching is used in FEX to avoid repeated overhead from
handling the same faulting access. This replaces faulting unaligned
atomic ARM64 instructions with regular load/stores and memory barriers.
This comes at a cost of introducing significant performance problems if
a function like memcpy ends up being patched because it very
infrequently happens to be used with unaligned memory. This is severe
enough to make games like Mirror's Edge and Assassin's Creed: Origin
unplayable without application-specific configuration.

Microbenchmarks[2] measure a 4x decrease in overhead with kernel-side
handling compared to userspace, and this figure is currently even larger
when FEX is ran under Wine. Such a dramatic decrease would make it
reasonable for FEX to default to the no-backpatching path and provide
consistent performance. 

 * Correctness:

x86 atomic accesses can cross 16-byte (LSE2) granules, but there is no
ARM64 instruction that would allow for direct atomic emulation of this.
As such, a lock must be taken for correctness. While this is easy to
emulate in userspace within a process, correct atomic cross-granule
operations on shared memory mapped into multiple processes would require
a lock shared between all FEX instances which cannot be implemented
safely in userspace as is (robust futexes do not work here as they are
under the control of the emulated x86 program). Note, this is a less
coarse restriction than split locks on x86, which are only concerned
with accesses crossing a 64 byte cacheline size.

 * Precedent:

Both XNU and NT kernels support unaligned atomic emulation for their
respective x86 emulators. Windows additionally supports 'volatile
metadata', which is emitted by newer versions of MSVC to inform
emulators which specific load/store accesses require atomic handling
[3]. FEX supports this together with an extension mechanism [4] which
can be manually populated to avoid e.g. the aforementioned Assassin's
Creed slowdown.

This implementation is a RFC so we can learn more about how to make this
code upstream and what the maintainers think of such feature being
merged here. The code is a simplified version of the original work done
by Billy Laws, where we accept just a subset of 64bit atomic
instructions that are enough to be used with a benchmark tool[2], and
this is the proposed interface being used by FEX: [5].

Thanks!
	André

[1] https://lwn.net/Articles/911219/
[2] https://gitlab.freedesktop.org/freedesktop/snippets/-/snippets/7875
[3] https://learn.microsoft.com/en-us/cpp/build/reference/volatile?view=msvc-170
[4] https://github.com/FEX-Emu/FEX/pull/4773
[5] https://github.com/FEX-Emu/FEX/pull/4985

André Almeida (1):
  arch: arm64: Implement unaligned atomic emulation

 arch/arm64/include/asm/exception.h   |   1 +
 arch/arm64/include/asm/processor.h   |   3 +
 arch/arm64/include/asm/thread_info.h |   1 +
 arch/arm64/kernel/Makefile           |   2 +-
 arch/arm64/kernel/process.c          |  15 +
 arch/arm64/kernel/unaligned_atomic.c | 520 +++++++++++++++++++++++++++
 arch/arm64/mm/fault.c                |  10 +
 include/uapi/linux/prctl.h           |   5 +
 kernel/sys.c                         |   7 +-
 9 files changed, 562 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/kernel/unaligned_atomic.c

-- 
2.51.1


