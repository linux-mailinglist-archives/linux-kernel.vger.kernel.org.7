Return-Path: <linux-kernel+bounces-777488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B758B2DA0C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 741F71C462FC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C34A2E2DFE;
	Wed, 20 Aug 2025 10:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="XjdDVwN2"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F3B2DCC03
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 10:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755685854; cv=none; b=Xn1d7ybCnGDtW0bdVMeF47Ixcsm7iW/NnPw8FqDrkUuYjesnXOi5D8+4dbYKINRG5kO4ioNsmA777IYxdN+ol7BvTsYa1rKRVJAABaTDZ0De4vGrS77iRyiltcqjgibu3OY6vk8s/dH8Qcn7Za8NIweGd3W5ALSUnXlEBdQoJMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755685854; c=relaxed/simple;
	bh=cqsbuIFj9PniccXai5k9E6X4bWeT/KOS9vofF/O5M7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2uO0PffKq0X/Phu8Yu6RqteVfFHe+JBsWiXHQNs42P5AzrEabls1JRGkdWnX1hDj6eUvH3NFBSYctZ6E399I/wZQkboMaFwoLQDzvbx6NSmZVFACgXZidIznKi62+BdBTuRSnHk+DUv/efOKQE/8J7yiWu8z+LpC3JCqbAJLBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=XjdDVwN2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EEE2840E0163;
	Wed, 20 Aug 2025 10:30:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Ww3LEJNfKeUk; Wed, 20 Aug 2025 10:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755685846; bh=k1hpsehjhy0ShJnJy02/6eNVagci2nZ1Mnfzm8tgclY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XjdDVwN2ICJb/csOYQQgJ7WZr1gg+TH7zj/74lZ2+0YID9ZBKi0wkoA7U2z9xNFgC
	 ClxrvwKdahf+FyqwHGNyfx2RTl14tFfX54vQyd2X6L7ITJd6epKePI7Stzqlz5iplQ
	 +uqLoVW7iP2/a3fDP1m1Bp3EF3H4UpGwSL2GH0H2+4gIoH3Zh3P0J5Kxg/T2lhkmNE
	 cNv7NT1zuhASkIOpW3JVG9ohag6GlWFLj6awKxfKURlBbrbkCHGV5dPiY2Xvelfb3i
	 gT/OooLfjM99low1GWX8ayP8M6s2mj9ugOIeREKOmGKz/WDnB6sCtXcnB6BjiZiCdH
	 5kOHHviRwpDvxTbOElep8GhFjwU8CdWRT7f0LX2yeDTVKU8Eqv8HjNkL/wT2a6d+2c
	 O+hw+IsxF38GRW2G1qaDNC1woWPxOjhbkTUlGT146gHd+MxY66T9udK8edUUcKVIm5
	 eddliv7sWXRGt02cBYbstZ5TtmOflbdR6pCCng/GcD0mqmtbC0gmriQh6WVfxw+4Mv
	 8TwoQ5u+gbDEwZIW/bv65SCmwUaovtqHCqcbFsd9bu3c3BecKCJ2z/b6Ha4byaHh0K
	 Rj7OFZObqTuxPgQAeWDBY7eR2yyT5Iriqx3ss59u7TxNj4Ik7Ak1uBX1lEwjRZZQj6
	 P9OJEGfwgWXCZuqu7OpTgDVU=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7B51E40E0206;
	Wed, 20 Aug 2025 10:30:28 +0000 (UTC)
Date: Wed, 20 Aug 2025 12:30:27 +0200
From: Borislav Petkov <bp@alien8.de>
To: Marcos Del Sol Vives <marcos@orca.pet>
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>,
	Uros Bizjak <ubizjak@gmail.com>, Ard Biesheuvel <ardb@kernel.org>,
	David Kaplan <david.kaplan@amd.com>, Kees Cook <kees@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Oleg Nesterov <oleg@redhat.com>, "Xin Li (Intel)" <xin@zytor.com>,
	Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Subject: Re: [PATCH] x86: add hintable NOPs emulation
Message-ID: <20250820103027.GHaKWjw_eVAbFEe8se@fat_crate.local>
References: <20250820013452.495481-1-marcos@orca.pet>
 <aKWR8e6VUEZEgbkw@lx-t490>
 <2cd7b099-095d-405c-a7d9-b0f1f72184c2@orca.pet>
 <20250820094347.GDaKWY02hR3AAoT7la@fat_crate.local>
 <be242e65-b056-4e12-93e7-9a297aaf231a@orca.pet>
 <20250820095556.GEaKWbrMh24T7jTfBg@fat_crate.local>
 <3db7d599-c2a7-4bec-94b1-4872649dde8d@orca.pet>
 <20250820100812.GFaKWejCFMSAS6QIfS@fat_crate.local>
 <ddfe73ac-177a-431f-8e6e-807ff0746213@orca.pet>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ddfe73ac-177a-431f-8e6e-807ff0746213@orca.pet>

On Wed, Aug 20, 2025 at 12:21:40PM +0200, Marcos Del Sol Vives wrote:
> Would a simple:
> 
> > pr_warn_once("Your processor does not correctly handle hintable NOPs.\n");
> > pr_warn_once("The kernel will emulate them, but the performance will be impacted!\n");
> 
> work for you, then? With no thread information, as that might make the user
> think there is only once binary impacted.

I don't mind if you make the warning message as helpful as possible and even
dump current->comm and whatever else is needed to help the user address the
issue.

What I mind is flooding dmesg unnecessarily with the same stanzas over and
over again.

If the user can do something about it, then she should be able to find out
also which executables need to be recompiled.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

