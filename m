Return-Path: <linux-kernel+bounces-750054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47039B156A8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 02:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FC403B6291
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 00:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D7814D70E;
	Wed, 30 Jul 2025 00:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxOrnxBQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE99A3594F;
	Wed, 30 Jul 2025 00:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753835976; cv=none; b=MaWFSDYBUNP6B/RRKN27lW36KUBi9sfiLxFrIVFCpJ9gPuPYHplK6bvUInuyOkdKcBuu6u3ZAkcUx4b2XobrqpO8H3UMrv8PeRXLknTot/Ms3Ye9k9gIjqpJenuBHogfdo0xA7+S5XusD7npA5w5ITFBguTj9pStbXo4xxZIHZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753835976; c=relaxed/simple;
	bh=WnOG4V+bPLI97m9dWmTwO5wl8jjkLQXzMfj40MYmTCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htMlWRvF96HEOOofYZzjTZrIBdn998zscaLjkf13URkmB4/N+B/U/nNuudA7y7e0bIlcRXabCb6aVGpGvrvJcC+AvS5RYd3NsvO3y5Wc7zvnTq83hYkoH971u4abl9t5U/s5HOV17+06GEe+PpxHiYZKOzrHzWuOcanUkccDH+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxOrnxBQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359D7C4CEF5;
	Wed, 30 Jul 2025 00:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753835976;
	bh=WnOG4V+bPLI97m9dWmTwO5wl8jjkLQXzMfj40MYmTCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qxOrnxBQ5LgP2+fdyeglquYIz3PhpmHfQcFH/uN5dnvOBkG07d2J8y2FT817qbzLn
	 dZwjdL/XnoUWVw5Yd6SKlXtuptPUIbiZO+YUkzeiBXhmCLL1ZbUazeJ/c18AYlr+k1
	 Y0GlxDDV2tzOxAkhnUSCCbPlk8ze9rXmRpyZX8Px1Vy1MvxBIv1XwLbzvYHQ4Ifv1t
	 oaBYzQMRo0d8PQIOpLIe57MbWWbs2LCljfoffKIAuryJpUooclqx8Guz/dHuo95bay
	 X0klPqJBo+lJi+Z4UanHhCkLzQ0OrVaGZs0UPgXJA60bZm2BtrJJ1AADy4S1csXq4H
	 qsS2kByItAcJA==
Date: Tue, 29 Jul 2025 17:39:35 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: kernel test robot <lkp@intel.com>,
	syzbot+5245cb609175fb6e8122@syzkaller.appspotmail.com,
	Miguel Ojeda <ojeda@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
	Marco Elver <elver@google.com>,
	Hou Wenlong <houwenlong.hwl@antgroup.com>,
	"Kirill A . Shutemov" <kas@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>, Uros Bizjak <ubizjak@gmail.com>,
	Marc Herbert <Marc.Herbert@linux.intel.com>,
	Yafang Shao <laoar.shao@gmail.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] compiler_types: Provide __no_kstack_erase to disable
 coverage only on Clang
Message-ID: <202507291738.262CEF2095@keescook>
References: <20250729234055.it.233-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729234055.it.233-kees@kernel.org>

On Tue, Jul 29, 2025 at 04:41:00PM -0700, Kees Cook wrote:
> In order to support Clang's stack depth tracking (for Linux's kstack_erase
> feature), the coverage sanitizer needed to be disabled for __init (and
> __head) section code. Doing this universally (i.e. for GCC too) created
> a number of unexpected problems, ranging from changes to inlining logic
> to failures to DCE code on earlier GCC versions.
> 
> Since this change is only needed for Clang, specialize it so that GCC
> doesn't see the change as it isn't needed there (the GCC implementation
> of kstack_erase uses a GCC plugin that removes stack depth tracking
> instrumentation from __init sections during a late pass in the IR).
> 
> Successfully build and boot tested with GCC 12 and Clang 22.
> 
> Fixes: 381a38ea53d2 ("init.h: Disable sanitizer coverage for __init and __head")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202507270258.neWuiXLd-lkp@intel.com/
> Reported-by: syzbot+5245cb609175fb6e8122@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6888d004.a00a0220.26d0e1.0004.GAE@google.com/
> Signed-off-by: Kees Cook <kees@kernel.org>

I've now sent the PR that includes this fix:
https://lore.kernel.org/lkml/202507291728.51BAA26@keescook/

Thank you everyone for suffering through the mess I made! :P

-Kees

-- 
Kees Cook

