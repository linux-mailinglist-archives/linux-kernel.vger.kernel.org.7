Return-Path: <linux-kernel+bounces-876042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A824C1AE6F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64FF96206E6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8026634B185;
	Wed, 29 Oct 2025 12:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="WG6GeAEa"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1468033970F
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761741526; cv=none; b=s9XwP/zUeGtyzLW+q40Dgm8r3k7TRCzzE+HNJNxdH8EGN+n1AIx7vfyhqIGAZfA0gKh1/W5rv8GP7Vkzrltr6KoQskj5kueSawmhxm6YquKd7Qz3f1IXQiX98yiI1zJXc4bEAl/mk553el61q+UpScS2bqULjaMG3fM3FsIh2sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761741526; c=relaxed/simple;
	bh=Bfi6AIAIv6V6tA7X/XVFSYzwK0kevfl9k/HCUlrw+j8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvGH05VgN71wHD2Pp9RZLyGKALVmZ6B674EdH1TCYYxqFnP1COGKRjxa2supNY0e/axWXTZB/PLI1jsiTCod62FV4JL1S9L6vb0cmDvYQN2AaT4/MPdGdNEC0iGBmGROewmrB7RcS+QeIJGSF2mr5ELlh81ZDHs6ovO4w1BizvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=WG6GeAEa; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9ABEB40E0225;
	Wed, 29 Oct 2025 12:38:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id a_Gzp9zZ6Qsq; Wed, 29 Oct 2025 12:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761741517; bh=rRUOrtCsg5ArrgR/3s+68EP1MNq16vBaqojRFKBA7Ys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WG6GeAEaRE3VjHaJvddiMKl5SZQK/49GS9A23YbOk+fCIk7LWfb55P6ngkeC4L/Cb
	 tVACIygQHaFb91yDoucRRRDtSB/J8p5/E4t9hJvq0DoAApPO18XED9pCHIO4hQ3Jz9
	 I30ynUeCTCqNLOgmAae+K+w/62iiC6dvQm3O9UCQqpUGjznzqlB5MXvLa8sLtXFUug
	 v0Zb10Y0NztEs0jhMBwGbArIYdCCQs6nhGUbcXbT8UuiLoVwzDeKqWRspMqpmcjba/
	 /6/+GzBXZ2kNrYM7bg0dHvy45PHMffmlSG5sQ8dMehJAaSrnT13kr235JK6rqNXkAZ
	 2OT+XI7ZVPVV4WhEYpGR3F2+VmJbK+dhmyKcvdlinz1UjBTSecX/EWdjSXtRv8+3TF
	 jmPEAJfQVil/71vtSXgtBrJc3Is98aB/S0fAHTuRwo94WqvLgvvLSa+Mz8jCp/oVch
	 9os5gxqaJhzjRN3JuAOfKYVwrr6NzxXsOc6/V3twqTASKs8Q9EJj++KevIyCoMh8iP
	 Qgid5DoQdbD0utQIu65TorYNYxD/eGmi7+4HBptM+Rh20Fud+1Zydqs/qqURZnwaJO
	 dmBaSKtumrQ9+04y1d5r55IR6tCVniKabn4mBKcBnKKprXdM/eQhdArh7UPHdC/YYo
	 7m+4mN6FtOTBvqC2LYump8mo=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 1FD7640E021A;
	Wed, 29 Oct 2025 12:38:29 +0000 (UTC)
Date: Wed, 29 Oct 2025 13:38:23 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yu Peng <pengyu@kylinos.cn>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
	Yu Peng <pengyu@kylinos.com>
Subject: Re: [PATCH v2] arch/x86/microcode: Mark early_parse_cmdline() as
 __init
Message-ID: <20251029123823.GAaQIKvz4gUk3Nsaj4@fat_crate.local>
References: <20251029081644.4082219-1-pengyu@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251029081644.4082219-1-pengyu@kylinos.cn>

On Wed, Oct 29, 2025 at 04:16:44PM +0800, Yu Peng wrote:
> From: Yu Peng <pengyu@kylinos.com>
> 
> Fix section mismatch warning reported by modpost:
>   .text:early_parse_cmdline() -> .init.data:boot_command_line

How do you trigger this?

CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y

in my config doesn't cause anything.

That's because

$ readelf -s vmlinux | grep early_parse_cmdline

doesn't give anything because my compiler inlines it anyway.

So it must be something about your .config or toolchain or whatnot, which
causes it.

I mean, the patch is obviously correct but I'd still like to know how it
triggers.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

