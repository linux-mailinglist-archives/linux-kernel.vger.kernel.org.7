Return-Path: <linux-kernel+bounces-815141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CAEB56038
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 12:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B8F4AC0E15
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 10:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E982EB869;
	Sat, 13 Sep 2025 10:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6Wv3eaO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFBD1DDC08;
	Sat, 13 Sep 2025 10:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757758711; cv=none; b=rNvCRbi8LvH/mFpUh8LGyxweLBEoAeZUN8u8rACClI/NoDiMbyTV49BHpVs0F3Q7ripLX9JTcNEu2l2LgCgc3Tl9BnaZOHh1SDypJZlI0nCJ2IudvFoGWe0khM6HyvYYYTmi80Ryk3mdmJCi7Z+99Qz4XM7i355jA11yzSaoaFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757758711; c=relaxed/simple;
	bh=xxZ7/bSRZZCSdbWxvvdc7KpqpiEO/14awaySh1hSXPI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JAcumy7wQ67C7oqCKINdEx6XgJEeHkxbm8aS0RPNAZU6x0+/J8Ser/gSt7UHPhN9cYICJU+6gNa+SPreMXN780u25AHriSq3Y5o4Du2EgoMFl4NdKjv3CZZ/aEX/js4Rw+grtZJ1UvzBAyXIQ/Ixm9Fg6nKjKATqGENo9j/cQhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6Wv3eaO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428C7C4CEEB;
	Sat, 13 Sep 2025 10:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757758710;
	bh=xxZ7/bSRZZCSdbWxvvdc7KpqpiEO/14awaySh1hSXPI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n6Wv3eaOzCX43KDux2KQkXsqUYTIGGSFJYpV2oWGOZ7FETL2Ku/Kvp0rysrIf8eW2
	 M9t9qiYaC5cyXjoX1UMW/nKFPHcUeTdWWMmMSlihRcLACKGiUe2g10Xs/D+0YGTPYy
	 knTdfiZ63fIgeruPw4k7/TzxLNplrQynMUMsQfwGYRK4Wo0ts5nK6fyQYPyDnO9cO/
	 VGix15BXijALCYvehFZwsDuzun8MuR9NJHp0z8UCwU3nMHv/ACFt+2AkN/YWtEAvAP
	 TfsGQole+bFu5oJ6oOs0W+KuByBidOSvl6R3vdFsqCY2OrcL42rzVjHE7c0Ye08ZlB
	 hVZqCZp6orMpg==
Date: Sat, 13 Sep 2025 12:18:25 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Jonathan Corbet
 <corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Alex Gaynor
 <alex.gaynor@gmail.com>, Alice Ryhl <aliceryhl@google.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, Trevor Gross
 <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v4 08/19] tools/docs: sphinx-build-wrapper: add a
 wrapper for sphinx-build
Message-ID: <20250913121825.002c8edc@foz.lan>
In-Reply-To: <3cc0d2bb-d7f7-4e8d-96d5-35863da244b0@oracle.com>
References: <cover.1756969623.git.mchehab+huawei@kernel.org>
	<e019f951190a732f9ac0b21bcda7e49af3bd5cbd.1756969623.git.mchehab+huawei@kernel.org>
	<e13837a0ac46dffe39c600d11fdf33f538bdc9c3@intel.com>
	<20250910145926.453f5441@foz.lan>
	<45888ca6c88071c754784495b4ef69460ea67b4f@intel.com>
	<fuv4p45tvjfdvwu2625s2l2kvcw64p4ohherlwyum3vmogmrfz@yb47nt66xgm6>
	<87zfb1p0r3.fsf@trenco.lwn.net>
	<a1333c717bb5bcea7f7c616cbf8604fa259c3158@intel.com>
	<87ldmkojo5.fsf@trenco.lwn.net>
	<20250912100645.15c79351@foz.lan>
	<1e5ea0314833519fdfda3a75c79fd046d41c086d@intel.com>
	<3cc0d2bb-d7f7-4e8d-96d5-35863da244b0@oracle.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 12 Sep 2025 13:34:17 +0200
Vegard Nossum <vegard.nossum@oracle.com> escreveu:

> On 12/09/2025 12:16, Jani Nikula wrote:
> >> Here, any time increase is problematic, and SPHINXDIRS play an important
> >> hole by allowing them to build only the touched documents.  
> > This is actually problematic, because the SPHINXDIRS partial builds will
> > give you warnings for unresolved references that are just fine if the
> > entire documentation gets built.  
> 
> I admit I don't have a full overview of all the problems that are being
> solved here (in existing and proposed code), but how hard would it be to
> convert the whole SPHINXDIRS thing into a Sphinx plugin that runs early
> and discards documents outside of what the user wants to build? By
> "discards" I mean in some useful way that reduces runtime compared to a
> full build while retaining some benefits of a full build (reference
> checking)?

That's not a bad idea, but I guess it is not too easy to implement - at
least inside a Sphinx plugin.

The good news is that conf.py has already a logic to ignore patterns that
could be tweaked and/or placed on a plugin.

The bad news is that existing index.rst files will now reference
non-existing docs. No idea how to "process" them to filter out
such docs. It is probably doable. See, SPHINXDIRS supports pinpointing
any directory, not just Documentation child directories. So, eventually,
such plugin would also need to "fake" the main index.rst. Now, the
question is, if we pick for instance:

	SPHINXDIRS="netlink/spec networking"

What would be the main title that would be at the main index.rst?
I suspect that, for such cases, the title of the index would need
to be manually set at the command line interface.

Another aspect is that SPHINXDIRS affect latex document lists, 
which can be problematic.


Thanks,
Mauro

