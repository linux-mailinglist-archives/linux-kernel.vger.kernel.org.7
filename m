Return-Path: <linux-kernel+bounces-809137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1D6B50913
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 01:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B2641C62088
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 23:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285C4286430;
	Tue,  9 Sep 2025 23:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouJB0jh0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CE4257858;
	Tue,  9 Sep 2025 23:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757459786; cv=none; b=LZseyolNvDt4fBwnzDIeH9hLXgcbNZL2IpkdPMtaK8b10iSrA6ywRYKzyzg6cI1vnLPIz/AmVnmEvhw925pXYqTWRlmBEZcjRaZdbpWORnkPwjZQeSbJqwPWIiYjacvbo9l10VGkjnaw0JqSF77FtnW3vwAOlaFX8hrVpzars6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757459786; c=relaxed/simple;
	bh=uqkl7Px7tQkx+fKrwIt2Uqmlnhb6p4SSaE3Pe0nxwhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RChbdVAhx3XuIFuiIB5H/FrUmZm4FnWCqzUnvHBZ5uo/zMfBd2JBEYmU/vBda75RMl2HBSuJ9XvKSRlZo3ljso4EOOTm8MRLuGEjsR8CQa3ISKpxi16qsoXUmlDO7gn3a4luFJOi8iKymHel6dm07TbWwACm5Yymokb75Z61674=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouJB0jh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46D4C4CEF4;
	Tue,  9 Sep 2025 23:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757459786;
	bh=uqkl7Px7tQkx+fKrwIt2Uqmlnhb6p4SSaE3Pe0nxwhI=;
	h=From:To:Cc:Subject:Date:From;
	b=ouJB0jh0FsjExT9I3J6SGM16P/1zDElKVGEkWy8viHBigYezpQt/NFUeHoVk15zVy
	 MQ3Vz53cyyffdBkfqLDiZV0Vq/Rhjzfg4b3FBwRF6EZByTA8wuY0UCgDRO7NYVckdB
	 /AohO5bq8KC3gVGqRR0BbGDJ7Bjl5KtpwksKSVftjo8WpNQzXZR/aBV5l3nBSDHREV
	 Y2+tH+nssP2ITuV92napcx+6pUTfETyumICjwQNdKhrQQi85+25BQNz6XK+sL8i5sL
	 xtj791CElTpczOpWDMJs8ofKmNRaZWdNL0vxI59JDLoldHQabq4hHy3FpAupdo2ItH
	 dVZKl5tzVfOxA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	fsverity@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	x86@kernel.org,
	Sami Tolvanen <samitolvanen@google.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 0/6] Optimize fsverity using 2-way interleaved SHA-256 hashing
Date: Tue,  9 Sep 2025 16:13:20 -0700
Message-ID: <20250909231326.1074672-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is targeting libcrypto-next.  It can also be retrieved from:

    git fetch https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git sha256_finup_2x-v1

This series adds support for 2-way interleaved SHA-256 hashing to
lib/crypto/, implements it for arm64 and x86_64, and makes fsverity use
it.  This significantly improves fsverity performance on many CPUs.

Later patches will make dm-verity use this optimization as well.

Eric Biggers (6):
  lib/crypto: sha256: Add support for 2-way interleaved hashing
  lib/crypto: arm64/sha256: Add support for 2-way interleaved hashing
  lib/crypto: x86/sha256: Add support for 2-way interleaved hashing
  lib/crypto: tests: Add tests and benchmark for sha256_finup_2x()
  fsverity: Remove inode parameter from fsverity_hash_block()
  fsverity: Use 2-way interleaved SHA-256 hashing when supported

 fs/verity/enable.c              |  12 +-
 fs/verity/fsverity_private.h    |   2 +-
 fs/verity/hash_algs.c           |   3 +-
 fs/verity/verify.c              | 175 ++++++++++++---
 include/crypto/sha2.h           |  24 +++
 lib/crypto/arm64/sha256-ce.S    | 281 +++++++++++++++++++++++-
 lib/crypto/arm64/sha256.h       |  37 ++++
 lib/crypto/sha256.c             |  66 +++++-
 lib/crypto/tests/sha256_kunit.c | 184 ++++++++++++++++
 lib/crypto/x86/sha256-ni-asm.S  | 368 ++++++++++++++++++++++++++++++++
 lib/crypto/x86/sha256.h         |  39 ++++
 11 files changed, 1136 insertions(+), 55 deletions(-)


base-commit: 54e7bb6ade8acd3fb1c486c9f3e2c0dfdc18f84e
-- 
2.50.1


