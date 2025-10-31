Return-Path: <linux-kernel+bounces-880931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF938C26E47
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 21:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30EF31897D68
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 20:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C68C328B47;
	Fri, 31 Oct 2025 20:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfcYue1o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6943F2EB841
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 20:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761942494; cv=none; b=jgwxzXsfOvTgjlY0xgFCXI2Y3/1PQBREMai9UUCCWqO+cemZAgj0PwVa9AGnnxrX6eg5ih+dhB4TRDUV58xSQ++pJEAMZUwT28r6D5VTVRdZeyXW6AyDKWAYb7kmXknnuKFtyp9nxIVQWEkt4BR28oV5Zj6h69Cv/J0X7UNAhxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761942494; c=relaxed/simple;
	bh=AjVeRmIbqZi82dYPjfPgsCsGvHgBizwI8tFFClRS8SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNFVPcZOmt/Rq473V3Y+xKoLAuDLmiODtJceQyKkZS7EYpUnvWTsdjcF58PJkcILS9Smn0Q/lzoP94hDcDK9OdpFf4ogIcK0a58pAroOByTPilY1Knyne44dVEHX6DbPOchlf2NYAW6S1v2YHK6JSVLpYCz58T8GtNGKgTUwccY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfcYue1o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27342C4CEE7;
	Fri, 31 Oct 2025 20:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761942494;
	bh=AjVeRmIbqZi82dYPjfPgsCsGvHgBizwI8tFFClRS8SM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rfcYue1oQ3uq8YHp8V1iDJCRGvnrd06gOmEOqlGneaK2xJXHaFDCppvFgMZTXqyeU
	 IOR1iFO16AqKcdQCF1pDx/d4o9macTrIFcAKT0aEJHJL4nG+bq4KR2sJif8BOzWHjg
	 cIAnpkDSmDBA9zYg33ZIO6f1dfUpwHog7yt9oNZWmwFqKL1FLAEBRvEkbs2RGmyrWc
	 UT7GZFuxR81naZ4cOrp6da/ToPF5PA83nkBloOFa+Rtz+oXkqqedFSgbbvmc9Q1IxP
	 zrm1Vav/mHjd5is7c8RRPXU/ICZiJsbC60Tl9HaSTaUXQh7BbBMvOPZPnhXReCxDtg
	 IVlVSuJKDBfJg==
Date: Fri, 31 Oct 2025 13:28:11 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Jan Stancek <jstancek@redhat.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, 
	npiggin@gmail.com, christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org, 
	joe.lawrence@redhat.com
Subject: Re: [PATCH RESEND] powerpc/tools: drop `-o pipefail` in gcc check
 scripts
Message-ID: <skcy4n4qyoqklhbs2gjefdyhu7nfgwxkwyamxal33ckv66bxr4@3xradd7kt57e>
References: <cc6cdd116c3ad9d990df21f13c6d8e8a83815bbd.1758641374.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cc6cdd116c3ad9d990df21f13c6d8e8a83815bbd.1758641374.git.jstancek@redhat.com>

On Tue, Sep 23, 2025 at 05:32:16PM +0200, Jan Stancek wrote:
> We've been observing rare non-deterministic kconfig failures during
> olddefconfig, where ARCH_USING_PATCHABLE_FUNCTION_ENTRY was getting
> disabled and with it number of other config options that depend on it.
> 
> The reason is that gcc-check-fpatchable-function-entry.sh can fail
> if `grep -q` (or scripts/dummy-tools/gcc) is fast enough to exit while
> there is still someone writing on other side of pipe. `pipefail`
> propagates that error up to kconfig.
> 
> This can be seen for example with:
>   # (set -e; set -o pipefail; yes | grep -q y); echo $?
>   141
> 
> or by running the actual check script in loop extensively:
>   ----------------------------- 8< -------------------------------
>   function kconfig()
>   {
>     for i in `seq 1 100`; do
>       arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh \
>         ./scripts/dummy-tools/gcc -mlittle-endian \
>         || { echo "Oops"; exit 1; }
>     done
>   }
> 
>   for ((i=0; i<$(nproc); i++)); do kconfig & done
>   wait; echo "Done"
>   ----------------------------- >8 -------------------------------
> 
> Fixes: 0f71dcfb4aef ("powerpc/ftrace: Add support for -fpatchable-function-entry")
> Fixes: b71c9ffb1405 ("powerpc: Add arch/powerpc/tools directory")
> Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
> Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Ooh, that is nasty...

The fix looks obviously correct: pipefail isn't needed in these cases
anyway since an earlier pipe failure (e.g., compile error) would result
in EOF getting piped to grep, causing it to returning an error
regardless.

Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh

