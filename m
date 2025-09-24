Return-Path: <linux-kernel+bounces-830425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A19F4B99A13
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA23B19C42C5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119F32FE567;
	Wed, 24 Sep 2025 11:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXB/+eis"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5782FE054
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758714286; cv=none; b=DEIX5JPSjMXqKTC/AfhiHdrx58oKamtmSuquJ2O6zp5oLE6JWbCGgiFvpHXt8UF+HltSuVO1PIgFvQyfRkRxTxWm9Z+8HLpVPwnjkgdT2r5vXuFsJ5gyxU9SXtONTjHPNoCQ+VRoQs8xfl+Hnn5/k9Cbvm1qK0yQb33b/CbVS+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758714286; c=relaxed/simple;
	bh=I8E5+njcKXsXjDyzwZ0OooFrSkL9LuY0bLNsmsEwEGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=siYE/vSwQzb0fqocQzOirPbyxh7NDJab+1CTksTW312Qrlp4MBb7JfIgac6MyTunXv/zxH4cfT0W4grbWQSdF/e2ytJ9nX4PS0f790dzewf8dh5Dd2KtktPB9jOyeKXeE+repqvScD6+fXZdzkZP408pj8gaJQELKrQAHtaLn7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXB/+eis; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CA7C16AAE;
	Wed, 24 Sep 2025 11:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758714286;
	bh=I8E5+njcKXsXjDyzwZ0OooFrSkL9LuY0bLNsmsEwEGs=;
	h=From:To:Cc:Subject:Date:From;
	b=cXB/+eisiIQ/qmXyGMN7t2JE5xXBMwFC25K6l8waVxyY+TPk0+0XHHvqr9wkH8C71
	 w4rX50nEcvzYj+LIhjdZ8BXkVfGq1BsrCW7bwHsj5b1YlxDrp9LAfw4ctqkOf6Wgqy
	 c/QLuVJjnF8JE2oaqA91h8XWfBrbV7j2LDeoOW8dcyU50jk5q3u70q4J9cRNqh2efT
	 zV09hbaVfR9ATYkY+xNQjv1rRB2GZVcUk7VrHqhla7fgYP9t8DwIwkdvgdCEpt85Na
	 alsJ7pnbmTLg9OC6yklDLMQpqaEVUG0hOqHI4c4w5X6WhXD0DaLzv2ZnXRmjcjZYqd
	 mHzjhCYO+j4tw==
From: Dinh Nguyen <dinguyen@kernel.org>
To: torvalds@linux-foundation.org
Cc: dinguyen@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] nios2: updates for v6.18
Date: Wed, 24 Sep 2025 06:44:44 -0500
Message-ID: <20250924114444.33618-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.42.0.411.g813d9a9188
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/nios2_update_for_v6.18

for you to fetch changes up to a20b83cf45be2057f3d073506779e52c7fa17f94:

  nios2: ensure that memblock.current_limit is set when setting pfn limits (2025-08-25 05:55:01 -0500)

----------------------------------------------------------------
NIOS2: update for v6.18
- Replace __ASSEMBLY__ with __ASSEMBLER__ in headers
- Set memblock.current_limit when setting pfn limits

----------------------------------------------------------------
Simon Schuster (1):
      nios2: ensure that memblock.current_limit is set when setting pfn limits

Thomas Huth (2):
      nios2: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
      nios2: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers

 arch/nios2/include/asm/entry.h       |  4 ++--
 arch/nios2/include/asm/page.h        |  4 ++--
 arch/nios2/include/asm/processor.h   |  4 ++--
 arch/nios2/include/asm/ptrace.h      |  4 ++--
 arch/nios2/include/asm/registers.h   |  4 ++--
 arch/nios2/include/asm/setup.h       |  4 ++--
 arch/nios2/include/asm/thread_info.h |  4 ++--
 arch/nios2/include/asm/traps.h       |  2 +-
 arch/nios2/include/uapi/asm/ptrace.h |  4 ++--
 arch/nios2/kernel/setup.c            | 15 +++++++++++++++
 10 files changed, 32 insertions(+), 17 deletions(-)

