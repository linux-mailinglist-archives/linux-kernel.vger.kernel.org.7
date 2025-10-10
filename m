Return-Path: <linux-kernel+bounces-848571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CBEBCE107
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 19:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 126D84EE41A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645A21FF5F9;
	Fri, 10 Oct 2025 17:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoeziE5l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0604216E23
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760116587; cv=none; b=X30L0+DoGO2eTsoGX7ASuVbTykjtFZfVYQTdvzvWV7/WqAwSywf5Fyv6sZzKZ111+xPTywQX8De+Wa/qoWli8RFrsgg5QMHg0blNuHfbutyt1nCBrzxqoM8y380ArtvDezbFBZCK3ozXqDbET6mds+OnVObvcSVJl3jAZwFJ89M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760116587; c=relaxed/simple;
	bh=9YNtDjY0aaMTxDGqBzpJuihnTbbfeShho9k1I/iDzko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RwAmJ03udibLoLm9TdV+lPInSY5JSZNqaD6vwqGVrHA1l0YNb1OQJHULt1GgpuF7oxN9A3Xrco48hLwgyljbQ9o1DSuV1asJYBVNHoKtV029DyeRhRmED2o6cs5M0s8rODeoilpreDkfY2hH3wJL1gbbABzbT3zptWomjva0ADY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoeziE5l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74596C4CEF8
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760116587;
	bh=9YNtDjY0aaMTxDGqBzpJuihnTbbfeShho9k1I/iDzko=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EoeziE5leDTQuMaTQWdDIjyfK93VH3byeksfUxrxmj+AjwFdDlSCZOORl5IicF3bN
	 dqcrB6PGSr7OqyXTwiTXRMWp/Dwzabpe51AQWLTdrinm33G1eOtl7/40+2Lt/TVaat
	 +d/4unC/iRa4tIuCgurOJ26L0fGo/94fI9tf1VU5wyjyryifG95Lpbi4XbB50ZKdce
	 rGeBiFVckgbLc4nzxTEN8s1/unz6yaZLHNjMPd0NGtYgDIw3nV0YVUxlrs+E2xeGBN
	 a6i4pC6tdZJfqPAhdf8dqiNPWTwl2Nl9VVZq+xjTJx5WaA7Q4YVvrcTcQgpw0LjV8M
	 LgO0L2O1vqwzA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-57d5ccd73dfso2431724e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:16:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWhX8INHhBFr3LZKxWByNmm695lAr+HroWwhUvBIcrY87RYdF8zg7PS5aPAVwPs+EXv5prcfnoAAWPximU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuubcXMUdS73QyaGfVrET6gMz1yapSbOLV0oXJdUjBJTIsxgSx
	HfvPOzMSQoQFsLBek6N/MKGRax3fPibSp3qLXJyaZvSKS7V9oVXHku2NvzyuG8HZkB4Eo5MnMuQ
	NVdOQp0XxbBL7Fa9ymkVWiLxAd4GEIAQ=
X-Google-Smtp-Source: AGHT+IGqjzPItbFI6jGLvg16WPlcUtcB/SyvLVUZ4hypPmxN6mA33rq7E1HgZbgBWLrxuQL9XcUXMPKdt5yKP8dsUKM=
X-Received: by 2002:a05:6512:1291:b0:57d:ffa4:56f4 with SMTP id
 2adb3069b0e04-5906dae5904mr3545979e87.41.1760116585846; Fri, 10 Oct 2025
 10:16:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008-kbuild-fix-modinfo-regressions-v1-0-9fc776c5887c@kernel.org>
 <20251008-kbuild-fix-modinfo-regressions-v1-2-9fc776c5887c@kernel.org>
In-Reply-To: <20251008-kbuild-fix-modinfo-regressions-v1-2-9fc776c5887c@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 10 Oct 2025 10:16:14 -0700
X-Gmail-Original-Message-ID: <CAMj1kXH8zHwszosJVNYT=o+CfKBMz4mOp0NoxpEEDUpKm6Dcxw@mail.gmail.com>
X-Gm-Features: AS18NWCiLkt3LHlYWoSTA35aXA7btFnwEifEZNsHsaa-xn_DY2Z_rG_Vr-a6ugs
Message-ID: <CAMj1kXH8zHwszosJVNYT=o+CfKBMz4mOp0NoxpEEDUpKm6Dcxw@mail.gmail.com>
Subject: Re: [PATCH 2/3] kbuild: Add '.rel.*' strip pattern for vmlinux
To: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>, Alexey Gladkov <legion@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Oct 2025 at 15:47, Nathan Chancellor <nathan@kernel.org> wrote:
>
> Prior to binutils commit c12d9fa2afe ("Support objcopy
> --remove-section=.relaFOO") [1] in 2.32, stripping relocation sections
> required the trailing period (i.e., '.rel.*') to work properly.
>
> After commit 3e86e4d74c04 ("kbuild: keep .modinfo section in
> vmlinux.unstripped"), there is an error with binutils 2.31.1 or earlier
> because these sections are not properly removed:
>
>   s390-linux-objcopy: st6tO8Ev: symbol `.modinfo' required but not present
>   s390-linux-objcopy:st6tO8Ev: no symbols
>
> Add the old pattern to resolve this issue (along with a comment to allow
> cleaning this when binutils 2.32 or newer is the minimum supported
> version). While the aforementioned kbuild change exposes this, the
> pattern was originally changed by commit 71d815bf5dfd ("kbuild: Strip
> runtime const RELA sections correctly"), where it would still be
> incorrect with binutils older than 2.32.
>
> Fixes: 71d815bf5dfd ("kbuild: Strip runtime const RELA sections correctly")
> Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=c12d9fa2afe7abcbe407a00e15719e1a1350c2a7 [1]
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/CA+G9fYvVktRhFtZXdNgVOL8j+ArsJDpvMLgCitaQvQmCx=hwOQ@mail.gmail.com/
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
> Cc: Ard Biesheuvel <ardb@kernel.org>
> ---
>  scripts/Makefile.vmlinux | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
> index a62639982be5..c02f85c2e241 100644
> --- a/scripts/Makefile.vmlinux
> +++ b/scripts/Makefile.vmlinux
> @@ -83,6 +83,9 @@ endif
>
>  remove-section-y                                   := .modinfo
>  remove-section-$(CONFIG_ARCH_VMLINUX_NEEDS_RELOCS) += '.rel*' '!.rel*.dyn'
> +# for compatibility with binutils < 2.32
> +# https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=c12d9fa2afe7abcbe407a00e15719e1a1350c2a7
> +remove-section-$(CONFIG_ARCH_VMLINUX_NEEDS_RELOCS) += '.rel.*'
>
>  remove-symbols := -w --strip-symbol='__mod_device_table__*'
>
>
> --
> 2.51.0
>

