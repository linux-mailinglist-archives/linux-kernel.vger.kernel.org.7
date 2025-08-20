Return-Path: <linux-kernel+bounces-777876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8C1B2DEB9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7FD7A04BF7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A320E265632;
	Wed, 20 Aug 2025 14:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HHx4EfpB"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F87264F81
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755698661; cv=none; b=Y8mP8viTHkQx24K+C3oHp2yXiPu+wVITtNximuJ9JKWps247nZk9+PAU9r5jLBlJv1714mVlWNqKUTMDqJ+VlwIa+X+XZ8jl3MLioMdlz0BwWQS/NRDWbhE4/NaFO4RWn9eRUkAXQ4dp3RW1sP6mHKEXUEA5ZGL7FMAJBD+7lG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755698661; c=relaxed/simple;
	bh=WxsIGVfIc/D0D5WCu5M1VbLF3y75/lFCZpc7+cW4qDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVOZzaoHL1N1rveUUnGLCHyFe80r8oUZLXjslO39Co875gaF4Ak4eXutVwg3ZC1b6G48RFV+/efESfiXpsV8x876Y8HC0+8SRdF3tbR+Nh5boU/X4er+FTb8ZtrNGUce/n4ok7ekt3FQJ8atwJOlIVn0tOB0xO4vy77F3W8pleY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HHx4EfpB; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 075BC40E0288;
	Wed, 20 Aug 2025 14:04:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7aeywXV78XLk; Wed, 20 Aug 2025 14:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755698645; bh=tTqmZgkXkpWrQPhChF9HjQzE8MA5M+fUsoabGI9VKz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HHx4EfpBRcefLICIJgHWLHi7MNmNkff4P05qN5DQ53li/u1QD0Pj5berI15RqrwLr
	 9jYqSqawfOrSpt+Z+5azg4Me3nZtNxqa8+ZP4PsB0K5yYEmcbSgltaLXqZ3Z1zovrY
	 sdmpAOD1OOD0cu4VGdN6CYPA3KeMnBcZEM1/q4QGnd3V6npPMZmJ1m5U3u6EGpFqZL
	 L93buWb9hU0ulLxBSlECxuATdvKXA0naBJWFNvo2UcR+ycuk5cY+O+58Ut1KPyF7ql
	 XG8x4RzR/IJtRHFdXVOhehCxSg0F/Yn0zXy8L9qT4x18XxLqG0j9qgMnn1fZGU37M+
	 rZNBIMQ+ya/GewVf1sSvdfh33jNR6l0o8YwDSBFfA/L0cg0XmreHWqWKR2cSbd3Pob
	 /cFKKMd7S44QXiX3IwLV1SSMnZVRUcW18Zh3T+qyq53YIkIvbSRX+JlNQRX1DhIp+p
	 e89K3cnQ7R3A9CMmc7QNBxxRwYKP6HU+SqLfAFLmivbgdS0LYE2KiozQAjmvEkR/8n
	 JBAogR9WGZZOU8cz60X4tmuQRe1zsqGAHOknNyPiGerzaFe2nl2OsWXwQxWtNN701P
	 V0tM5Y/3K7Xhn0lEI4hnn2e72YeMBEwYwGLVkARnA6iQD/dj6oVCvima8ZqBqo6T0H
	 1dX2mPb1nuljmOb3YsQtI+Jc=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6B46F40E0206;
	Wed, 20 Aug 2025 14:03:58 +0000 (UTC)
Date: Wed, 20 Aug 2025 16:03:52 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ruben Wauters <rubenru09@aol.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] x86/cpu/intel: replace deprecated strcpy with
 strscpy
Message-ID: <20250820140352.GIaKXVyOpH6kFDKSXk@fat_crate.local>
References: <20250630143225.6059-1-rubenru09.ref@aol.com>
 <20250630143225.6059-1-rubenru09@aol.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630143225.6059-1-rubenru09@aol.com>

On Mon, Jun 30, 2025 at 03:29:30PM +0100, Ruben Wauters wrote:
> strcpy is deprecated due to lack of bounds checking.
> This patch replaces strcpy with strscpy, the recommended alternative for
> null terminated strings, to follow best practices.
> 
> Signed-off-by: Ruben Wauters <rubenru09@aol.com>
> ---
> This patch was reviewed by H. Peter Anvin and (by my understanding)
> was deemed ok to apply. I have not added a Reviewed-by tag as H.
> Peter Anvin did not do so.
> 
> The last time I resent this patch was during the merge window so it
> understandably did not get applied or further reviewed.
> I have resent it again as the merge window has now closed, hopefully
> so it can be further reviewed and applied
> ---
>  arch/x86/kernel/cpu/intel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index 584dd55bf739..b49bba30434d 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -607,7 +607,7 @@ static void init_intel(struct cpuinfo_x86 *c)
>  		}
>  
>  		if (p)
> -			strcpy(c->x86_model_id, p);
> +			strscpy(c->x86_model_id, p);
>  	}
>  #endif

"strcpy()
--------
strcpy() performs no bounds checking on the destination buffer. This
could result in linear overflows beyond the end of the buffer, leading to
all kinds of misbehaviors. While `CONFIG_FORTIFY_SOURCE=y` and various
compiler flags help reduce the risk of using this function, there is
no good reason to add new uses of this function."

From: Documentation/process/deprecated.rst

Note the "new uses of this function".

This is old code, there are no problems with it so unless I'm missing
something, if it ain't broke, there's no need to fix it.

But I'm *sure* you'll find something else in the kernel which is really broken
and you could send a fix then...

:-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

