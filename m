Return-Path: <linux-kernel+bounces-793222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2241B3D0B2
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 04:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1AD3445433
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 02:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC931D799D;
	Sun, 31 Aug 2025 02:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkLiJnTi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA0B54723
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 02:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756606421; cv=none; b=sKBBQkv5nselAB1hdrn4klWotp1ld6O9E520WS5B7jvkUL9+3VfhJKcdDDQVEwKKdNPP5oEfBU4MPuI+5+z5AalQJxmnMlC0S+LwQ+4p63ioBcZArvVzqg6orrH7uq+FrNYDKL47zyft8wkW6PjYxK3HORjW/zQhg09atRWy6Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756606421; c=relaxed/simple;
	bh=21Tzkx2XPYhP7aS4/H+WwINeJ5mjZtoUwhG3VJ+JspM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XcGW/xLy6lhA7eDSLo1Q4HHTn7XwwiAc0z7AAAQ4oef/Gb4D391FRqACna0aKja3/cCr+gs90pe3TraoZYm6sUdq09Ra4kz7+CskWqL0IHZIVCfVVIMFrQCk62CGQA9SmJkLOzMH2SeBsu+85f8BbDzQgPNhIJ07/VLkkXw9U3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkLiJnTi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0898C4CEEB;
	Sun, 31 Aug 2025 02:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756606420;
	bh=21Tzkx2XPYhP7aS4/H+WwINeJ5mjZtoUwhG3VJ+JspM=;
	h=Date:From:To:Cc:Subject:From;
	b=VkLiJnTiEQUvshsGcCNNozI5hyxIJ6xxDemjn0jd8bJTUvTKhQMROG/eZSJ1Y4MVe
	 KwKvPu8xyBrHrLojIpJquqyScTS5MD62JkPV0o67AQ6ojOtDHob5wfWsPlE+zYnIri
	 NR0jYQsfzNN8OPf78wCLXe88eSN8iSBMn3zlJj8AI1VPGfj6R73+3ncvi3Leku/PDQ
	 M1MVEVZzqfiOlH70L5VwDKaV+e92LxX7p//ULqiEFRo8oPyIqipwHGZGeprps7rgtC
	 1/xXyzWVSplWB13iKRx31TBNOo7hjFUYsN2dPfdFY6SvWme1UXM4fTXoSlRoBzz6tv
	 fS+DQzFjiwGZQ==
Date: Sat, 30 Aug 2025 19:13:40 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Junhui Pei <paradoxskin233@gmail.com>,
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [GIT PULL] hardening fixes for v6.17-rc4
Message-ID: <202508301913.69AE63B6D@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these small hardening fixes for v6.17-rc4.

Thanks!

-Kees

The following changes since commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9:

  Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.17-rc4

for you to fetch changes up to 86a9b1250602d877a393dcbab5f42472f77ac0f7:

  hardening: Require clang 20.1.0 for __counted_by (2025-08-29 12:04:53 -0700)

----------------------------------------------------------------
hardening fixes for v6.17-rc4

- ARM: stacktrace: include asm/sections.h in asm/stacktrace.h (Arnd Bergmann)

- ubsan: Fix incorrect hand-side used in handle (Junhui Pei)

- hardening: Require clang 20.1.0 for __counted_by (Nathan Chancellor)

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: stacktrace: include asm/sections.h in asm/stacktrace.h

Junhui Pei (1):
      ubsan: Fix incorrect hand-side used in handle

Nathan Chancellor (1):
      hardening: Require clang 20.1.0 for __counted_by

 init/Kconfig                      | 9 +++++----
 arch/arm/include/asm/stacktrace.h | 3 ++-
 lib/ubsan.c                       | 6 +++---
 3 files changed, 10 insertions(+), 8 deletions(-)

-- 
Kees Cook

