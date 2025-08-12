Return-Path: <linux-kernel+bounces-765635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FDDB23BA9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 00:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 836B4720CF9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 22:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934132DAFA0;
	Tue, 12 Aug 2025 22:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="drLoDCj4"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBC020C001
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 22:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755036244; cv=none; b=a4MbeRbE7ypWp22+UZ4NqJkfWm4mdjQwBusPsLTYK9F7dvNlMc2OskDMZ4uHDHKF6uEFz0WK98XyRff0eLd8PQrwufYcmkG0Cp2Un6eeRSMLKLTyAPTySxs3cbh7F4QvL3bA719/fhsdqa72gLP0zUgfKDxoYPPE6eBGe98YGFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755036244; c=relaxed/simple;
	bh=lblk0YPban2IyO6F5iYAQ5NqvLgvYCPF4JfgcsrpiFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzrCjpLx2YwHdlio8e/mVjPmWNe/iUaIgz4g2R4zEKIeJg5JSW3ARwZtipgOqkkNrL4iNDb4T4opZcjPTOXCeWk4dYbmCSoQUwWl4enm1l8nYW/H7RsGT33odK2bLDOh7z6gZYk/uYwrXYVM6bNrupzEefAJh14bs1UJIMP/CMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=drLoDCj4; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6723740E00DD;
	Tue, 12 Aug 2025 22:03:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PqYU883hzQXC; Tue, 12 Aug 2025 22:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755036234; bh=rDFlZ+gaie3jmVv3p6ws5+bmRr4zneAsCGbdz++M6GI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=drLoDCj4eE55Vm6a5sD6FYwJcUjZEwJbTIe2leXdh4ojo2sizhmTelshhgiQYC6Tc
	 ees8NaQ0yq2oALbVav+9zMWmgCF+k63+MeTdz0znw+2PvRUfcHdwqutVPYGW26Xnw3
	 /t9UVLdYyGU9MNsTFC+EUtdsCjp9Sn+FV0lDNPf1QKlnD8OiJQU0Uwf4pOYtXo8v0f
	 qNvOky46k7Ub3NUd4S2hL/mgh72HY5EJH94O4oM3hOcSy0/8dF9bcJt7KeEl65wUD5
	 vBSIi7qlOYb7G8oR80ykd9YC1CN0fmgOZ3I3lZarubVkyxlEprABUxJxjX2+AlB92v
	 q3AVZ+LSau1NIWtLelaQTpyOT1olNvJwLZy1h8FsSuNHud+gFjk0gjjwMu362flzF4
	 o4uw9kXr5xcJEjSfqy0ysfsd+w23RwQ00sjO1lAE61/lsRqdUFQxdiq258RwmeyLIk
	 usrPOwZGDiS99b9jcCVBxhl0+VqG+pY/a8DUW7/WNsj44yQ17UMVQMTE200XUl86yQ
	 l3/WJixTJfQtFhuiHxMx0HDf5rTF1Big3TqvIZ1k6iBiVjQLyoNbcCVSSqp5Z7IQVA
	 o4iCVufwj9kEPIcsFxE7hLhPIMyy4WpsdWDLtcPnwk4W1p6A5MNJpiyZQ+W+GLS71T
	 aXUsUxu4iGhGw77TXmN5IvTM=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A61F840E00DC;
	Tue, 12 Aug 2025 22:03:47 +0000 (UTC)
Date: Wed, 13 Aug 2025 00:03:41 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/CPU/AMD: Perform function calls post ZEN feature
 check regardless
Message-ID: <20250812220341.GJaJu6PUo4Kl3pTprp@fat_crate.local>
References: <ee4e9ea71713cee72bb637e848c6a272f8a9e631.1753290066.git.thomas.lendacky@amd.com>
 <20250812213718.GIaJu0DgbRbBq2mfDY@fat_crate.local>
 <b88e7df1-7946-21cc-db0f-d5ce9dcff9b2@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b88e7df1-7946-21cc-db0f-d5ce9dcff9b2@amd.com>

On Tue, Aug 12, 2025 at 04:56:29PM -0500, Tom Lendacky wrote:
> ZEN3 and ZEN4 won't be set if we do that and since those families don't
> have RMPREAD support, SNP won't get enabled on ZEN3 or ZEN4, so we can't
> do that.

That's why I said partly.

> Hmmm... i guess? Not sure I 100% agree with that.

Look at it this way: you can't really run old kernels on new hardware without
doing at least *some* backporting. So might as well do the family extension
patch too.

Let's worry about this when it really happens. But for a decade at SUSE I've
never even once thought: oh, this new machine support won't need backports.
Because it does every time and this is business as usual.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

