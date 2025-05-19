Return-Path: <linux-kernel+bounces-654038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B35CABC29D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 17:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A4847AE5EB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 15:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D768286400;
	Mon, 19 May 2025 15:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="feTif4IN"
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373EC284667
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 15:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747669040; cv=none; b=TYhMxNRaG0A6tb61xI92k/tCkZ9XAy5jf/BMqDl0rENhjckuiyOmJgPFJkhGzqBeTuhFCjpYrkvNVSAzs3wn8lZvEMrn+30SEJYh2ieDcssDXBwRKWyJHb0WB3DHnSPy7HIIWtgVXzIUr3y9yC3PDWDnmxzvsluLSkoSFVovc10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747669040; c=relaxed/simple;
	bh=VviZiAm4TW9x1PuWHHZ0yIOrkiWZxigI1r2ZSB8wlxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wzneh0MIAox45l9hQZaXLVpmdI8c8F0OeBZHoh5n0fyLoheNQKMoR7sgtsUogo44+/cFfoOi9h5auk3xqxZVKNkD+3rddp+lBMfK4D2xBwmnHJKieRgRKxojhUvA6rNBQKYU33ivcNHq8cwQYFTNdc3N94u9dD9vxqJKn2sl22Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=feTif4IN; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4b1M705SSqzfm9;
	Mon, 19 May 2025 17:29:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1747668572;
	bh=o+zjH5bdhelAhX7v5sStM4NHNJMFQNuR9omTqJLTAJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=feTif4IN82tZ+GEvyyo8QMz67cnW1JOJqL9FyGsJ37hRLvkrtYhsLtrLa8XOYXLUS
	 FzExB5oNfwiNnWZLIVtDZYATx3EmAmgYP6rCheTp3/9y7IE1XcgL9387FzdHo2IxwJ
	 k21kzTi7PMfemPBU5CS1u005DFxShuKZZIvYkCXQ=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4b1M6z1FMHz5Tn;
	Mon, 19 May 2025 17:29:31 +0200 (CEST)
Date: Mon, 19 May 2025 17:29:30 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	linux-security-module@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: linux-next: Tree for May 16 (security/landlock/ruleset.c)
Message-ID: <20250519.jiveise8Rau8@digikod.net>
References: <20250516202417.31b13d13@canb.auug.org.au>
 <e3754f69-1dea-4542-8de0-a567a14fb95b@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e3754f69-1dea-4542-8de0-a567a14fb95b@infradead.org>
X-Infomaniak-Routing: alpha

On Fri, May 16, 2025 at 07:54:14PM -0700, Randy Dunlap wrote:
> 
> 
> On 5/16/25 3:24 AM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20250515:

Thanks for the report.

It is the same warning as reported here:
https://lore.kernel.org/all/202501040747.S3LYfvYq-lkp@intel.com/

I don't know what the actual issue is though.

> 
> on i386:
> 
> In file included from ../arch/x86/include/asm/string.h:3,
>                  from ../include/linux/string.h:65,
>                  from ../include/linux/bitmap.h:13,
>                  from ../include/linux/cpumask.h:12,
>                  from ../include/linux/smp.h:13,
>                  from ../include/linux/lockdep.h:14,
>                  from ../security/landlock/ruleset.c:16:
> ../security/landlock/ruleset.c: In function 'create_rule':
> ../arch/x86/include/asm/string_32.h:150:25: warning: '__builtin_memcpy' accessing 4294967295 bytes at offsets 20 and 0 overlaps 6442450943 bytes at offset -2147483648 [-Wrestrict]
>   150 | #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
> ../security/landlock/ruleset.c:137:9: note: in expansion of macro 'memcpy'
>   137 |         memcpy(new_rule->layers, layers,
>       |         ^~~~~~
> 
> 
> Full randconfig file is attached.
> 
> -- 
> ~Randy



