Return-Path: <linux-kernel+bounces-749008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C01B148CF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A1183B7B3F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 06:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D19325D1F5;
	Tue, 29 Jul 2025 06:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbZ67u7w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEBB25C838
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 06:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753772331; cv=none; b=IAgT6yCRGuEUk9pEZtrD+du6Ifoaid6ox7FeWEJHvF2aUmQDSdaUsEAaOz0Di8F1CJOP9STpVBgEDp/E6QyzWypdImStddiq71YytMjulFgrHNE/iXLlaOtiExhNGXE0f5jEEU4OaOAYaMKxWHcWmXlDinqVJV9JeLr2krOy+kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753772331; c=relaxed/simple;
	bh=TEpkmPt+78Akb2ER3PDQVoBkG5txIWqz0oEew5FQkIE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VTlMegZnlLLQsThloTcGugYXqu1b0jnbzgVPHQJMexUibyX0T1gy8inZDSyDMmlvZKUj0pB8w4oIo8rrlgYs8z/S+Q0Ohadt/p+GfZ1UFEGcz1DDYMcuEm5WeFe9gmA0tMbHFpd0WZLIDWbwQzDvzjlsmP3GOiZliYf3r01Pl+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbZ67u7w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D1DC4CEEF;
	Tue, 29 Jul 2025 06:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753772331;
	bh=TEpkmPt+78Akb2ER3PDQVoBkG5txIWqz0oEew5FQkIE=;
	h=Date:From:To:Cc:Subject:From;
	b=qbZ67u7wXDl91/j/n9G1CNOqwUqz7Ik5kxzKDJQc6OmlAX6MW0h4XqxVFG9zwP3ui
	 0qybYh1NB+Jjyfa3kYO29ZVe7G4iMtmskrIIDOXqACu7BmfGH+ZKdLow3O1yQLPx1W
	 Kh6g1U23tsO608xv337tx+TdzTBaLxKg+ZR83d9zUZj9wC1iXK9smtNjGSQrfhNxih
	 BVWBbLL/nZ5EyZVqhydOLJFwbVV1ARgrNcQJ7JXs2Tz/Kz0Z9y7T0Fit5fywN8d+Ct
	 BGRVBq7UStfb1YzcxEB2n5l0jhmQWhzkIY0O3GFqjYBDiUhyZXszUh9kGUVHuibUvM
	 8oQYPLK8wj+jQ==
Date: Tue, 29 Jul 2025 08:58:47 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [GIT PULL] x86/boot updates for v6.17
Message-ID: <aIhxJ5-wj2mbJBvm@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/boot Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-2025-07-29

   # HEAD: 61b57d35396a4b4bcca9944644b24fc6015976b5 x86/efi: Implement support for embedding SBAT data for x86

x86/boot changes for v6.17:

 - Implement support for embedding EFI SBAT data (Secure Boot
   Advanced Targeting: a secure boot image revocation facility)
   on x86. (Vitaly Kuznetsov)

 - Move the efi_enter_virtual_mode() initialization call
   from the generic init code to x86 init code.
   (Alexander Shishkin)

 Thanks,

	Ingo

------------------>
Alexander Shishkin (1):
      x86/efi: Move runtime service initialization to arch/x86

Vitaly Kuznetsov (1):
      x86/efi: Implement support for embedding SBAT data for x86


 arch/x86/boot/Makefile                 |  2 +-
 arch/x86/boot/compressed/Makefile      |  5 +++++
 arch/x86/boot/compressed/sbat.S        |  7 +++++++
 arch/x86/boot/compressed/vmlinux.lds.S |  8 ++++++++
 arch/x86/boot/header.S                 | 31 ++++++++++++++++++++++---------
 arch/x86/kernel/cpu/common.c           |  7 +++++++
 drivers/firmware/efi/Kconfig           |  2 +-
 init/main.c                            |  5 -----
 8 files changed, 51 insertions(+), 16 deletions(-)
 create mode 100644 arch/x86/boot/compressed/sbat.S

