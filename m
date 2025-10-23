Return-Path: <linux-kernel+bounces-866922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D37C010A0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D39021A611C9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5601E30DD04;
	Thu, 23 Oct 2025 12:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="eGkwRJvx"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452F431076C
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761221726; cv=none; b=Zh3iNcpMyBxGxn5UI4TCz292Yf91NSrL0DOn5MjoKyiAmq9IRUo/6oo7PAMv2m+0269hgZnovH4ZFcUdY4SF/a1n2H88rwTwyhN58350zoQOS+ZwiyGpv449JYmlAzfJPGykAbeIBF8AjX/jkVSjuapVf7od298a21ldCwKsgKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761221726; c=relaxed/simple;
	bh=/Aa9/p5ixgjp5gWgZv1LUcGcEIoUWo0x8Z1c+T8nOPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjenY0jiWPv9AU6hPcQilJc1rMaFXYMgNapH7+E362QOsNQYwp59n55tOWOVM9feAMcZYjE1lx8Q/d7h6a9YM3S55N7kdcdu3Mg5BE165mDF4T8ruLP7jOrZSFhd/m+Dswww3+VoFnROtXCJiQ6I1SHkR9oyZOIhKJTnCMmGsgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=eGkwRJvx; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AE4BA40E00DE;
	Thu, 23 Oct 2025 12:15:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PEGJEf8Oi9kU; Thu, 23 Oct 2025 12:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761221713; bh=jNnUSZNer5DkpYV3DRAZLxkJtVPD6JU88mvtvzlUzrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eGkwRJvxA6ZWwjgoz+h6Ny6iNgdo8S9sWJs5wzlLkqFRbZkmwKaQDv9LJrkPF2vmC
	 p7aIUkdFVsrNKwpq1KnO1nMdelg6z1Hr2mn3eAbEmVFOVVTP8o1AOHVSxlZ1XKSl7U
	 H4Ifbjyu9DBkP0K8MlklOffniFDhhEISfC7qZcKpQ8oSX6SuNV2DY8Jc0msWAIU0ed
	 k1Cv0weEk9/Go/SjHPEWp3KN9PTTTm/AI3Q6/JkxDJgcTifwSxzeVdvl0jqs6sTZ9v
	 OJJfhpyO0nkAIBfV+sLMZuyGTKI3jhzSgTx2JPQj2702qb87gM8dPcjGe7mT+i5W+P
	 CnSOK4HBuj6cHMQc5uJVH8uHirtcFPEyTw++sYGhpAglZSYkt8tzuQyb4vfbIDqgCM
	 fNpgqQsosfznobp8apjq3Q/e3wr0isccF8pLFZzZAEABRX36xljT5ujUplSZlE75XJ
	 vfnSxRkKiIvyXu9ouD0uTbyIoVVt6fy0Mvx6rue/voSFuoNvZzuLdVCLSlYZVHwlxO
	 JML4IhfvK3/ZHOeCvZg4zUp007UrUTefyOD7weNrJmTZatgKGiIt+U/yuDFne4gJRp
	 bEmNtO2XKtju40bf01PcG+hxWCRdsiB/zqjShYq5TdqA3RKdqA1Rko0HxE1XLYCIpd
	 E7cCFHHEbzgDRLp3fUrLWXQU=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id CBB0F40E021B;
	Thu, 23 Oct 2025 12:15:00 +0000 (UTC)
Date: Thu, 23 Oct 2025 14:14:54 +0200
From: Borislav Petkov <bp@alien8.de>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	virtualization@lists.linux.dev,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [PATCH v3 02/21] x86/paravirt: Remove some unneeded struct
 declarations
Message-ID: <20251023121454.GQaPocPvNMDYuOBod2@fat_crate.local>
References: <20251006074606.1266-1-jgross@suse.com>
 <20251006074606.1266-3-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251006074606.1266-3-jgross@suse.com>

On Mon, Oct 06, 2025 at 09:45:47AM +0200, Juergen Gross wrote:
> In paravirt_types.h iand paravirt.h there are some struct declarations
		      ^^^^^

Spellchecker pls.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

