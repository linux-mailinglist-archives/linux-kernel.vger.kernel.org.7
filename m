Return-Path: <linux-kernel+bounces-792856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 735D6B3C9C9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 11:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE8AD1BA6AC1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 09:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0C725D1E9;
	Sat, 30 Aug 2025 09:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gIj1QqjN"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103DD10F2
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 09:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756545938; cv=none; b=anXhEflogSrggUU0QXag7+yv7ytzbq2c2iiB73ZMRUpPHytdDtO8pwaS50p0kGHfnVgfUMYJnTlAe25KPGOTeHOG+XcUQoRULhVlpfBLddx/ggEtN9GNnrDg9rAXZCsr3RfssByAH9hrPUbDLwKnYE3PTUdw+89WT8WV6sKNWrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756545938; c=relaxed/simple;
	bh=BF7xX4B2+0QDbBe4ABHvaA6gq/vEXrYmUgMAo1IsbnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E90ePIPlTgXjL1WcjJqP0VMZJ2k3pqcPXrlMJEz0kFFZlrKg5dR25KWFcDSLfw+8yuvl/+D0GckN8IJ2wnI1D6vrfxEESLheBYWVaxw1XiKf9lR6TLaDjJtnR7O71VU1JnYX53jedp4jTUeZ5nTi1DSptzR825r4VPK4kLY0aYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gIj1QqjN; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7D90840E016C;
	Sat, 30 Aug 2025 09:25:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id lqsYyd9qyKmq; Sat, 30 Aug 2025 09:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756545927; bh=jLeZMAZIodGrySmmcoRpSKYryUzqyXGWLc65wZY7qj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gIj1QqjNvb0wh1HD5zR6RPMpiHrhPky1bW3pq0noO10Du/+6TRV7T/U87lbK1hq4B
	 +Rl7X7wL85+PS0dH/VOJ1tNs6RghM3htre/SMpVrRLk7Sc9ap2HBSiLil//30varD5
	 WOAoTTzc16GDsO13Slgr36XK4h6/GTWUI7saRn7bUxWedhlTzc4BFunDZKfnemiCt2
	 4mhkB+QmLpbbOZjWp1PdqSfyi/GFLZK2vFQFOZMN29A1fMxwulk2i8xRLRIquZthqa
	 E/TP0W4FiN2ZttuaL7O4A97DtO6lsC953+8jYrCCAT+16UVyaZbOkS4uzV3ddez/sz
	 i3p71gUlTHZAXnz9Fl2ykWvfhtGcizGyJIBKa97kl0uY9eLr8Ry1SEc8qiNwyTtQ61
	 dd6/LUp6q+6+ZA+h4Rn9Dwm6QG/HG340QVEN7GzYj+FPYqmtciHePQyubtmJF0FoGI
	 CkuYoBkqT/E82Rh3BPb8bYMiKLIJBiiklLgP8B5zKUMi/r9FQLDPdPcLgrfOQh6Cpg
	 Om1qSmmFz4vlCfTh9Siknbvjn5PCLVzd5cJsJ08JAUlXsu7kEp8sOaXKAQ5zwXwTyi
	 gkJCnUyZ8sndwI7HruQSYmfQj9rvwbEjFIiT6LcR7mOlz9ta43iumNeWN6igShCe9D
	 CsVm2lwkpecEm6+dgfps2Ph0=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 952C340E00DA;
	Sat, 30 Aug 2025 09:25:22 +0000 (UTC)
Date: Sat, 30 Aug 2025 11:25:14 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Borislav Petkov <bp@kernel.org>, X86 ML <x86@kernel.org>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -v1 2/2] x86/microcode: Add microcode loader debugging
 functionality
Message-ID: <20250830092514.GAaLLDepwTQpZG5KnR@fat_crate.local>
References: <20250820135043.19048-1-bp@kernel.org>
 <20250820135043.19048-3-bp@kernel.org>
 <2cd370e9-6fd8-4aed-8fe8-c8526a1ab97f@intel.com>
 <20250829094502.GAaLF2nkL2EtFlDGOB@fat_crate.local>
 <f0565436-fef6-4999-b878-f4d2d52c22f2@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f0565436-fef6-4999-b878-f4d2d52c22f2@intel.com>

On Fri, Aug 29, 2025 at 04:25:13PM -0700, Sohil Mehta wrote:
> My only concern is someone could easily enable it by mistake. It might
> lead to unnecessary reports and debug. Maybe we print a scary dmesg log
> whenever CONFIG_MICROCODE_DBG is enabled? That would be easy to spot in
> reports, and hopefully it would deter folks from enabling it unnecessarily.

When that happens, we'll add the cmdline switch as an additional precaution
but I'm not worried - we look .configs on bug reports.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

