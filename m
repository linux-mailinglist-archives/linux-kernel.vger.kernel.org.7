Return-Path: <linux-kernel+bounces-842945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6547BBE068
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 14:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B851A1894DFD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 12:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0299927EFE1;
	Mon,  6 Oct 2025 12:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Xvra/uVZ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C3527A92B
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 12:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759753767; cv=none; b=YCmbjYXYxQRm3MlMtPRxwJ2a+UeNtZdeXJD/DhUN5MbH0ECj3NjzPuuzLnrSwRvEe5xnIHrIyLCltHgAr/E0gz14LiwIf3bxPXXUeLPK8U3IJ8ikezh488y5dPRnBDxD0kve6LYxrV24nZfxVKhbNx1W0/oBLCle6L58eFhxKgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759753767; c=relaxed/simple;
	bh=WSUngGvhjlviwhMI59TIbLMHIlpSfCCygUnQQL3vGm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tzt9LcarfSG0nKODIJIN/cgFQqqezHprAOvf4ex9Tdkzp1dg15QverkjlD7GcLuFlyQkQNmmfWNfx5K+kPl32LaQm5TM25oqNF0PLOn0sZEz1vTsvTFDe+s1F7+KhOyiAiw8H1dPmeaSCPYoOFhcvqg1LrYPrLqONbMpdQUL2e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Xvra/uVZ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A260B40E00DE;
	Mon,  6 Oct 2025 12:29:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id F2YHX0EjXORJ; Mon,  6 Oct 2025 12:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1759753749; bh=shHp2p7X/NXg98enthwXv75VmuArihHmWN8qdsKTu+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xvra/uVZhVwiQU73R7JYqdHbWIdESIcriOUcooW16WOIBCd3gkEUur2/bwMNpLB7y
	 x5hInpPbUoph+jO1twtCi2SZw2bxRywRsciLMqBQtQlXTH1jMtADpf2olQxbT7M6le
	 yKVUe9CxA99180VlC6bPmVrVazsPraSgcd/5c5ax1erewm+tu4HWdS/vNtddIxcRWc
	 PKTx1Qdq9sHfdou9jY92LIpN7nsboAC74Fd0WVFQiXB7X3DuVgbN9DImMfs7GqOO/k
	 Ykwq1KdRnnvKAlnD9imotrwkfh0V3cpjohMyL4Q193Wf0XQ1OxLompK4gsBgFFQa1Y
	 ADhfJ3DkpJKJ3Tf8MMaxwa6NH9EfYuvquu5q8J1p51tDxL6JghnZ4uUB2wOcA3qUHr
	 6Zm9ZEPvpS61w24Z+9LIm2xILjyDQiJ++xxRqwiiP7AjW3v6cJPFDuSFBbwzBiINXz
	 bLpkEAvc6ylYgXWse1dW5JcqbyPaeX7GX4t8egPW8llWM8oFQYCA2bzst6iM0LV+kK
	 XkLq/V+oQ/tFD65wpBNAsa8Wtt/I4ymJR8ljltgzct/6ifgcWwTVWGPjPEePmmFY25
	 Bu7oxcESV28OanJRB8MvXmrKCHJZmOxYTByV8YNPN35PyH7hrR02kxIw3nAnL0xKYh
	 Bc3ZGd5My+P3FCMKH2RD2Exw=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id E91A840E01C9;
	Mon,  6 Oct 2025 12:29:04 +0000 (UTC)
Date: Mon, 6 Oct 2025 14:28:57 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] x86/apic for v6.18-rc1
Message-ID: <20251006122857.GAaOO2CX8vkmVw_4Ya@fat_crate.local>
References: <20250926102823.GAaNZqxzXkasrXXFjn@fat_crate.local>
 <CAHk-=wibOJBAp66CPz0qfSWe93iisGvN4xL_MzuwSZ8sAut09A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wibOJBAp66CPz0qfSWe93iisGvN4xL_MzuwSZ8sAut09A@mail.gmail.com>

On Tue, Sep 30, 2025 at 01:50:48PM -0700, Linus Torvalds wrote:
> On Fri, 26 Sept 2025 at 03:28, Borislav Petkov <bp@alien8.de> wrote:
> >
> > this branch contains two big features because it was deemed a better idea
> > to merge them into one.
> 
> Ugh. I really wish that hadn't been done. I would much rather have
> seen separate SEV and apic branches.
> 
> And I don't see the _point_. Yes, I see a conflict resolution. An
> absolutely trivial one. So mixing up the SEV branch and the APIC side
> seems to have had no actual reason or much commonality.
> 
> Oh well. I've taken this, but it really just seems ugly and pointless.
> 
> If there was a real *reason* for merging those branches, it sure as
> hell isn't explained in said merge. That just has the "fix conflict"
> explanation, and as mentioned that seems a really really bad reason.

Lemme CC mingo - maybe he had something else in mind which I'm not
seeing...

Sorry for the confusion.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

