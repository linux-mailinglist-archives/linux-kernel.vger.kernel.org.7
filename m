Return-Path: <linux-kernel+bounces-893010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 121DCC46546
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD3F14ED28B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8ABB3081CE;
	Mon, 10 Nov 2025 11:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OnKYx94E"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363DD1E5B9E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774757; cv=none; b=uuUTperHOeVsX491pjLztPl8tjZJER8TPfZqZ01SJUbnh9T9JzKGwmYCvKkOAOEh7+8RL87c+vyEgjXSOwk3rDyy93EZjuw2e9s1mncX9vYRfWOqGY1rcRxEdw2YYL6ur2yxo2ioXBGHhYA3sJVPPdMuuMRk1SGM0/0oMjC2Kyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774757; c=relaxed/simple;
	bh=oDeYkVX8EjZNh/AtRZ10BCLF/ipfCxZO85NkMLOeog0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdF2W1a3pFZiX/yHuUkq6JoZtcwhuMpyMeBNsXh1slizKEiCFJKqrWmkOTftu0P+l+mVTs4Bv2XtPeUmADN611Z8vbmLnaforspFhl5+Z7vJVR6Yy1KGAFH173Sl+CW8M6nFazede3meeOUjoXioBLMNkiphjSMGrthrIJ1Iu0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OnKYx94E; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 65E2D40E01CD;
	Mon, 10 Nov 2025 11:39:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Pa7YrT3kZa47; Mon, 10 Nov 2025 11:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762774747; bh=4AGg5z7WB7yGesyFSg8uTe5UjZWoCr/Y1LVg0PE2ceo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OnKYx94EZoFO51ta5Dmjmjm9Z1BzOqlpQpurxAu2RH2jxL/klCqkKRPXfJ7bZoXx1
	 OykubkkOd+ElmoatXs9ULH2vnFxBxZohjAu60D7FgSNa147RWigXSOpcfa4MmN9HSm
	 l1DilJRbrV/Pt9IT9BoBZ/FN0uwOChO52wGInrFIAjMPwd9V/4VVKzwWCvRe9mrFqo
	 I8xOcmoFnKPeYsFAnKjZXfHb3muAZFOEBXlVDlGlvpikRJ7Hkgugf9/beU9Hmb61pl
	 hBaFsZppnk1A6oXvrtAZqaNRbbqmkrCAD7pxYuTTVd3OIPk+HrIeAKuk3qqMtcLbVd
	 MyF9dWkGKGansiGSc9XGE4yxgn2w+U8my5i6a40oxP/u0llQoL4jFZVTC35BMF7HI4
	 gbj3tpvfgsFE3Djw0Cqhpz/EiqluSy7o45TxdZPquITE0f2fDSHzKgE4XwcXOmjSY3
	 enzG/IelEdOWvy28swqsTG6KYyAqHP5HVLljO8k+Yo+I9Am01ey5P3CV6dIxJMe408
	 tMx/nrVEL7j2TyvtMT3RkGBflvvBYhfsrrhFPyPCBBtjBSR1V5gm+H32TwsvBCZrMF
	 8LUsKN4ASRk1ZjqInQA6EqBp1vVQu+jRH03KNjeHlqsI9safg7a2QTjM2GiuX/7/MD
	 s72XT/NweEXDx8CdQNYeuvFo=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 42BCB40E016E;
	Mon, 10 Nov 2025 11:38:40 +0000 (UTC)
Date: Mon, 10 Nov 2025 12:38:34 +0100
From: Borislav Petkov <bp@alien8.de>
To: Brendan Jackman <jackmanb@google.com>
Cc: Andy Lutomirski <luto@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>, peterz@infradead.org,
	dave.hansen@linux.intel.com, mingo@redhat.com, tglx@linutronix.de,
	akpm@linux-foundation.org, david@redhat.com, derkling@google.com,
	junaids@google.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, reijiw@google.com, rientjes@google.com,
	rppt@kernel.org, vbabka@suse.cz, x86@kernel.org,
	yosry.ahmed@linux.dev
Subject: Re: [PATCH 03/21] x86/mm: factor out phys_pgd_init()
Message-ID: <20251110113834.GWaRHOuqnXgNa0UiFn@fat_crate.local>
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
 <20250924-b4-asi-page-alloc-v1-3-2d861768041f@google.com>
 <20251025114801.GWaPy48dhlZ_EVoqKi@fat_crate.local>
 <DDSLXKU87HTE.G0XUZ5BG5M8K@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DDSLXKU87HTE.G0XUZ5BG5M8K@google.com>

On Sun, Oct 26, 2025 at 10:29:23PM +0000, Brendan Jackman wrote:
> Per Dave's feedback I am still slightly hopeful I can find a way to
> come in and refactor this code so that it's gets cleaner for you guys
> and then ASI becomes a natural addition. So far I don't come up with
> anything in init_64.c but I'm still planning to stare at set_memory.c a
> while longer and see if anything comes to mind. So maybe we'll be able
> to reduce the yuck factor a bit.

Cleanups like that are always more than welcome!

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

