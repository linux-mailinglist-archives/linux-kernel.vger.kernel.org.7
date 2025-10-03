Return-Path: <linux-kernel+bounces-841798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2531FBB8433
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 00:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C1C544E98B2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 22:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC75926D4E6;
	Fri,  3 Oct 2025 22:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cv+x0D0I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D3C267B01
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 22:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759529435; cv=none; b=op84mIb6Eh1OURJph9JwJy+lLimAijnATl0CY7EHQJaJExnIDMZLt6a289ihrlAm2LYBrycthnSP7TvNlqdYHctn+pgAM9LWMhEQNB6t9VX3OLe4A7E7ycLQi73JHAqCZU6s5IRcbXtewv0vRcRnkjoF+VBI6zNk4pfKDJLgN18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759529435; c=relaxed/simple;
	bh=+hFSiyVuBUbS0ccYbLDoxwudse4mVbBQm+BsuvZES24=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XfFKyrQbdCjiyBj0HTW7dvCHb9EGBbFplUcTlGGoWS34CyFoVWnhY0cWLoYe5SJCWWb82auI8OP4E/1AoteDo6lKTCWDpc3xS7XVh8av13M+5kbv9KmqwkMAIqZXQRUt4d6eDCcR0C3X9Be44ve4RGEQG+daALMACdsm+nynNgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cv+x0D0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A70C4CEF5;
	Fri,  3 Oct 2025 22:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759529434;
	bh=+hFSiyVuBUbS0ccYbLDoxwudse4mVbBQm+BsuvZES24=;
	h=Date:From:To:Cc:Subject:From;
	b=Cv+x0D0I9zB+AodTPsKQ/qIavTZx6xeS8qhtqwkzUVRNtaDjhSiScCa3lSJiMtqw6
	 6TL2+6RaPiZG8CzufNi6/udUTN3Uac+gzUCcvmfhFSqr6GzuRgUjQW22R+BMfAML7d
	 0IX2tm/QquAjqzmdSz5Mniwfk/HqIcFBMWlv5szhZNT+ajgltCne5yBmfAta9mMOAp
	 E0ddiLpcGOuwr0X9csIxPTiRhodNgXTBXaGRpBR5tD2qs6Fm/Lgra4aJBK9tmAqXtG
	 dlqfwRLqhm0H7RnMnz2KTEXdVA5dcVo1/ACb8v4WwsD4Nb6htvvqEJ43rIY5ifzQDh
	 u5RNHvJP7ALkQ==
Date: Fri, 3 Oct 2025 15:10:30 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Semantic conflict around CONFIG_CFI_CLANG between Linus's tree and
 x86/core
Message-ID: <20251003221030.GA1162775@ax162>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ingo and other x86 folks,

Just a heads up, there will be a semantic conflict (for somewhat obvious
reasons) between

  23ef9d439769 ("kcfi: Rename CONFIG_CFI_CLANG to CONFIG_CFI")

that went into Linus's tree via the hardening tree and

  038c7dc66e27 ("compiler_types.h: Move __nocfi out of compiler-specific header")

which is currently in x86/core. I noticed this while kexec'ing under a
CFI kernel, which needs __nocfi as a result of

  2114796ca041 ("x86/kexec: Mark machine_kexec() with __nocfi")

otherwise there is a nice big splat and the machine dies :)

Cheers,
Nathan

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 41c16fb8eb40..59288a2c1ad2 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -455,7 +455,7 @@ struct ftrace_likely_data {
 # define __noscs
 #endif
 
-#if defined(CONFIG_CFI_CLANG)
+#if defined(CONFIG_CFI)
 # define __nocfi		__attribute__((__no_sanitize__("kcfi")))
 #else
 # define __nocfi

