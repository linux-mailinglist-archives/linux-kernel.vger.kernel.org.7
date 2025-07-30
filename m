Return-Path: <linux-kernel+bounces-750047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0158B1567D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 02:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C51818A513A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 00:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03D97A13A;
	Wed, 30 Jul 2025 00:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaHP5KK7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F5E78F20
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 00:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753835382; cv=none; b=KRBGsHipUHUZUD8T9ZHULt4TkgErJzl7EZmdSU/sPzFV6iUydPy5hP09231lzrQZPAZuyL9haYZ907gZqfxgsO7Rbwgqh7bZlkn3QYrKeXc0WEnkYR09Z+/WJAjLfKE2fH7zQlbSLEk+HJ8deg/q1+oPErAgML0bFrOHpUlZmC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753835382; c=relaxed/simple;
	bh=OC4OtHfXtUe3oLH7Er0ZKmm74+KEMTlem/lcsyfF39c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mFSjCFEFn7rti3eatfTMpv7taeRUM5pFtkH566hwCQJd7jjtURhzmvk6Dq/OKjNsOWzQPHXYqldO5K4/BLE3H/YLFOUMyGBAWzxNexVOutmrjC1ZOJ+ScaZMqt+yW8toK5N7MVQGmAm6brW27lWngYyxyQyCYx19RB2oeY2V+TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaHP5KK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BAFC4CEEF;
	Wed, 30 Jul 2025 00:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753835382;
	bh=OC4OtHfXtUe3oLH7Er0ZKmm74+KEMTlem/lcsyfF39c=;
	h=Date:From:To:Cc:Subject:From;
	b=RaHP5KK7+vJNw5Mtf54JCflv0njRNklaeXbbjdWgTlOw6ezHNiyDaOaTiqlBwqg5f
	 qOQeMQyt5hrqx4svThahljl1o0PJUSV4ODtnZmyCSIAc50egWrUgNaCYepcQEFgoA3
	 YAf+n4AuFrXGIJ1FLZ7T290LB4EmuzGURN7NUPlTxsBm0rjiIkeJgQGLWSQPwwV5wq
	 nv3tZcneVEqNngOUxbURLMbUbJVyaqzpUojl1ok76wM06LBy3ThE02L6ZHw9Kf4c90
	 FCz/OrVxD0bGKdax+w62JfZRGRWMYm6CKu10xdiJCgaTSRycqJNbptUOKZQFzreMMJ
	 quDirU/xpnaVQ==
Date: Tue, 29 Jul 2025 17:29:41 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Hans de Goede <hansg@kernel.org>, Kees Cook <kees@kernel.org>,
	kernel test robot <lkp@intel.com>, Marco Elver <elver@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	syzbot+5245cb609175fb6e8122@syzkaller.appspotmail.com,
	zepta <z3ptaa@gmail.com>
Subject: [GIT PULL] hardening fixes for v6.17-rc1
Message-ID: <202507291728.51BAA26@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these hardening fixes for v6.17-rc1. Notably, this contains
the fix for for the GCC __init mess I created with the kstack_erase
annotations.

Thanks!

-Kees

The following changes since commit 32e42ab9fc88a884435c27527a433f61c4d2b61b:

  sched/task_stack: Add missing const qualifier to end_of_stack() (2025-07-26 14:28:35 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.17-rc1-fix1

for you to fetch changes up to f627b51aaa041cba715b59026cf2d9cb1476c7ed:

  compiler_types: Provide __no_kstack_erase to disable coverage only on Clang (2025-07-29 17:19:35 -0700)

----------------------------------------------------------------
hardening fixes for v6.17-rc1

- staging: media: atomisp: Fix stack buffer overflow in gmin_get_var_int()
  I was asked to carry this fix, so here it is. :)

- fortify: Fix incorrect reporting of read buffer size

- kstack_erase: Fix missed export of renamed KSTACK_ERASE_CFLAGS

- compiler_types: Provide __no_kstack_erase to disable coverage only on Clang

----------------------------------------------------------------
Kees Cook (4):
      staging: media: atomisp: Fix stack buffer overflow in gmin_get_var_int()
      kstack_erase: Fix missed export of renamed KSTACK_ERASE_CFLAGS
      fortify: Fix incorrect reporting of read buffer size
      compiler_types: Provide __no_kstack_erase to disable coverage only on Clang

 scripts/Makefile.kstack_erase                             | 2 +-
 arch/x86/include/asm/init.h                               | 2 +-
 include/linux/compiler-clang.h                            | 3 +++
 include/linux/compiler_types.h                            | 4 ++++
 include/linux/fortify-string.h                            | 2 +-
 include/linux/init.h                                      | 2 +-
 drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c | 9 +++++----
 7 files changed, 16 insertions(+), 8 deletions(-)

-- 
Kees Cook

