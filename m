Return-Path: <linux-kernel+bounces-877333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D350C1DE1D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 01:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 105544E4593
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 00:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F8A1C6FF5;
	Thu, 30 Oct 2025 00:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="biKZ3Pik"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779681531E8
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761783514; cv=none; b=W09Nj6FcsOJSI4YBsuiWu8oWeXtYerv5+vsxU+LV2GJeIhDZSH/RZLf8j/C0OBtjvFRn8V+ATi/Fq+dUeKcSWeBoLxdiV6k59mhDX3UZ59NhXV9EcSXBfNquqtfSGlhDd7E1z9wShrJsON9Ojzk2iRuKI/QxL2zrKHyjR8Ihz04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761783514; c=relaxed/simple;
	bh=s1WESjp6CE1MJ3IpkAjEChWoBFEk89MrqYWeeMGBkTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOqhN7yTWwu6SndJV4JcpmkN6s9fLFoOBJoEUUO7M1V1OB1ZR/9I8cj15+c3kz+fJLiTmX+oPLhLLa0nmdbGiWmC1glbddyYKc4x5l4tJ4vyqEQas+L8nrgLC8fMKOyk6XJunv1yZPCDAsGWL2vQ6MRYa/sQz8+/rCeDh7Gsbko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=biKZ3Pik; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B0CC840E021B;
	Thu, 30 Oct 2025 00:18:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bnZK0vyu0ec0; Thu, 30 Oct 2025 00:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761783506; bh=rJdGVM0fYYqCu8kyXIu2/exDMrXk9NdMp/cEW7NMUwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=biKZ3PikxiXLQerqs7qYrIk+pNR93sJWyjuo6Vv35tOUOPkiLokFiljgpGyF9xu7n
	 Z4AobkdonPebY40hAQFwfqgap4wFewUVVy1hKv2h1MrUnhl2+xWQrVobjX/zqeaKb1
	 Bry2VjIC8bAumfInaRJeTcJKSMTrSRQ1DHcRn0LAitr6eKbwc/zHmoruPUcuWhp7MF
	 TSTMs6kibpbGsfZ8busx88FRdYV/HwJTynW+E4A6dEgka50joT0HvIMZvRj/cZGKC8
	 Y+yYVXxKLGCAGE3w+6vwbQR1fYlw1iwUQoJiRW6JTB0awQIhuh25Dly3+sHUkrIfd8
	 SNgLdpEVj8ABGjE3vtu9y/0JlNcPZ7NXtFn19v6MF81Gr1Mb78u5vTmOIIvs16oagQ
	 OoJEFlGiVBf7uZ7lEdCkX3gbGqMJdlGKTkLXFw3yoXTcAKR+MhaQLWuIT/Nc1M8vGE
	 WZJX8cWShuS7CSEt2W/Z6Yd7qEHx7QaAqOZvwbloKvVqlEJQuxAKy8w5mwGfHq1NzR
	 N46UzysEesoHgf7RpR04sJGu0yK7iycC+zhJ1HKeqjuySLgs97f+0JAyHbWpd21iDF
	 Ni+65uamXB+T6N6BwqQBINBm/pKbfrS8JHZS7RxGZ6SVlTW/u+UunZTcSXESPF/XDl
	 /wjz/fHhsAOmBLYy3mHCXk3w=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id F1EE040E0200;
	Thu, 30 Oct 2025 00:18:06 +0000 (UTC)
Date: Thu, 30 Oct 2025 01:17:59 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
	akpm@linux-foundation.org, david@redhat.com,
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
	mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
	acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
	willy@infradead.org, raghavendra.kt@amd.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v8 4/7] x86/mm: Simplify clear_page_*
Message-ID: <20251030001759.GDaQKut2wDtopc0qn6@fat_crate.local>
References: <20251027202109.678022-1-ankur.a.arora@oracle.com>
 <20251027202109.678022-5-ankur.a.arora@oracle.com>
 <20251028133648.GAaQDG8PfOwrSiHYuk@fat_crate.local>
 <87ikfxguhd.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ikfxguhd.fsf@oracle.com>

On Wed, Oct 29, 2025 at 04:26:38PM -0700, Ankur Arora wrote:
> After this change the only remaining functions in x86/lib/clear_page_64.S are
> this one and rep_stos_alternative.
> 
> And so the _orig suffix seemed to be a little confusing. That's why the
> change to the more functional name.

No, as said,  having "clear_page" somewhere there in the name should stay. It
can be "__clear_page" or something along those lines but not something
completely different.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

