Return-Path: <linux-kernel+bounces-885636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F3AC338FC
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 01:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C5F94E22B7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 00:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4AD23EAA5;
	Wed,  5 Nov 2025 00:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HitUVvu9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616662248A4;
	Wed,  5 Nov 2025 00:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762304169; cv=none; b=ULQMrysCcMKpRwZFWDzOt2Nar4fgivSZO2c8ghm1xYEta5VrCcfTd+374vmsqHf0OshmXIkP3EkOqUMsAa3G0eRNisOQL3ZIptDUm2b4/iNMuK6Y86NHqhtkEWpchx4m5Egns63MQB7KT+mgOwhBiFbRXHS1Z+DWIS5E9TIFB9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762304169; c=relaxed/simple;
	bh=Bvm2Nhl2+r7royt5yqzJsom1ydwfu9ptstfPqK7iPMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8gBKG/1uetV6WdIpF9h+zGKZHdNmESFegdkWF/hvtRpZFU4ysZSo1QWKErN1gc3md7j1hqXQ1Vcy2aqFJ4A2NG4HCm8742HBhJ4BJyPhUVhTKH7bgFYFxIVOwqPWb2Ld+J8FLqCcii/E1wPWBnigI9GKSFe14ar62RPBFWfQM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HitUVvu9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4AFDC116B1;
	Wed,  5 Nov 2025 00:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762304169;
	bh=Bvm2Nhl2+r7royt5yqzJsom1ydwfu9ptstfPqK7iPMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HitUVvu9wiVErxtr0ah4QUG+vMFNYwwqaDx1QJqR4bhbUWDJ9S1hTYO9+AylLAzeF
	 5PkDCpNRx+cagT0xUtJYIjCra1JnthcghCtelhFwJwUnx1qMnO1dSVaQ08ClWuzdyG
	 6lvhGTf1DhHYXM1c/ZKmQqTl4nNlXNBYyuP72OQJLgEZithy1tEv3tJNN9VDtjOE8F
	 iLMP9evJPksFuF9IjeJvOzwlLmQ79aOtU12ZPqNC3MeUGKn64G59xeS+dDX8Lflu2p
	 f8GzQhWdxc0UIDOFC8p0DiPGWlQq2HCzK4fbLvphwox5M8SqqZ+SLPSSDmR60K7OoH
	 Yj2ElC/Ug3g1g==
Date: Tue, 4 Nov 2025 17:56:03 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Omar Sandoval <osandov@osandov.com>
Cc: Samir M <samir@linux.ibm.com>, linux-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, dimitri.ledkov@surgut.co.uk,
	stable@vger.kernel.org, Nicolas Schier <nsc@kernel.org>,
	Alexey Gladkov <legion@kernel.org>, linux-debuggers@vger.kernel.org
Subject: Re: [mainline]Error while running make modules_install command
Message-ID: <20251105005603.GA769905@ax162>
References: <7fef7507-ad64-4e51-9bb8-c9fb6532e51e@linux.ibm.com>
 <56905387-ec43-4f89-9146-0db6889e46ab@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56905387-ec43-4f89-9146-0db6889e46ab@linux.ibm.com>

+ Nicolas and Alexey, just as an FYI.

Top of thread is:

https://lore.kernel.org/7fef7507-ad64-4e51-9bb8-c9fb6532e51e@linux.ibm.com/

On Tue, Nov 04, 2025 at 04:54:38PM +0530, Venkat Rao Bagalkote wrote:
> IBM CI has also reported this error.
> 
> 
> Error:
> 
> 
> depmod: ERROR: kmod_builtin_iter_next: unexpected string without modname
> prefix
>   INSTALL /boot
> depmod: ERROR: kmod_builtin_iter_next: unexpected string without modname
> prefix
> depmod: ERROR: kmod_builtin_iter_next: unexpected string without modname
> prefix
> 
> 
> Git bisect is pointing to below commit as first bad commit.
> 
> 
> d50f21091358b2b29dc06c2061106cdb0f030d03 is the first bad commit
> commit d50f21091358b2b29dc06c2061106cdb0f030d03
> Author: Dimitri John Ledkov <dimitri.ledkov@surgut.co.uk>
> Date:   Sun Oct 26 20:21:00 2025 +0000
> 
>     kbuild: align modinfo section for Secureboot Authenticode EDK2 compat

Thank you for the bisect. I can reproduce this with at least kmod 29.1,
which is the version I can see failing in drgn's CI from Ubuntu Jammy
(but I did not see it with kmod 34, which is the latest version in Arch
Linux at the moment).

Could you and Omar verify if the following diff resolves the error for
you? I think this would allow us to keep Dimitri's fix for the
Authenticode EDK2 calculation (i.e., the alignment) while keeping kmod
happy. builtin.modules.modinfo is the same after this diff as it was
before Dimitri's change for me.

Cheers,
Nathan

diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
index ced4379550d7..c3f135350d7e 100644
--- a/scripts/Makefile.vmlinux
+++ b/scripts/Makefile.vmlinux
@@ -102,11 +102,23 @@ vmlinux: vmlinux.unstripped FORCE
 # modules.builtin.modinfo
 # ---------------------------------------------------------------------------
 
+# .modinfo in vmlinux is aligned to 8 bytes for compatibility with tools that
+# expect sufficiently aligned sections but the additional NULL bytes used for
+# padding to satisfy this requirement break certain versions of kmod with
+#
+#   depmod: ERROR: kmod_builtin_iter_next: unexpected string without modname prefix
+#
+# Strip the trailing padding bytes after extracting the .modinfo sections to
+# comply with what kmod expects to parse.
+quiet_cmd_modules_builtin_modinfo = GEN     $@
+      cmd_modules_builtin_modinfo = $(cmd_objcopy); \
+                                    sed -i 's/\x00\+$$/\x00/g' $@
+
 OBJCOPYFLAGS_modules.builtin.modinfo := -j .modinfo -O binary
 
 targets += modules.builtin.modinfo
 modules.builtin.modinfo: vmlinux.unstripped FORCE
-	$(call if_changed,objcopy)
+	$(call if_changed,modules_builtin_modinfo)
 
 # modules.builtin
 # ---------------------------------------------------------------------------

