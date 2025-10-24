Return-Path: <linux-kernel+bounces-869590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CDAC08405
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 00:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12D1A1AA7C96
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 22:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6475B309F14;
	Fri, 24 Oct 2025 22:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Lo5bTlqP"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6233305065
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 22:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761345521; cv=none; b=dMol2e+MATCVcceyebQ73kXtEJwzTtEB+M5JM0A/p7y2doTc9qBWTJOgXcKiTdEVIgjg2EFU0fDK8PAPTNgwwCUQuuimz0JGbbq06Jd2CNS8DMOr2K+tYsYFzVdGZ+UqKYA6oUanKUSH0HX23qQ+NiyuP8rZvaRp+Fh1CYo1DC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761345521; c=relaxed/simple;
	bh=8h1ba1zLR5sliD/Vajgncrb4GIEaj17sBigkG3fmnNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8sfOJn2SAJcS1+WvUaTS9B6BEUTdBIklwhd+9a/6EmYIOkafd3BZoMCHBZF97I/e6AnHCzXjjv+9rmsf8H9+OZ+DKc45HcQxjbqPODZBfaPsU601HPzIa+w3X1Qwick7msKCkOJJPXr4cAT97m/33z6ZmdNYIqSbewr6fAqq9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Lo5bTlqP; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 088FB40E0200;
	Fri, 24 Oct 2025 22:38:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cOwGoV0MZ8VE; Fri, 24 Oct 2025 22:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761345508; bh=cjiWvHOz96eVWBeUiSoBAexp8LAy46Vszw62SUjwR/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lo5bTlqPQSXK3Lal9wLXwg3wRc8QxEUY7IUksdU6pYq6zD5sD+hZNAiktj9sFFuTw
	 rjF/o5+O04RUvyx7EpuGIxz7HoWFjNkaijoc+A1i1+/0aO4tBaggAjxWHXRnInfAeq
	 Zhg0r7133XfBadt49MbzCHHXBVXFyXeTIs8ffusMvHCLcg7hX7RpplLJwQVY2loYqZ
	 SRF6kJZRl0nmZ1xF6JmuDKPz/aD7NmTnmP54tg/gZfzriHkTiNRwgtfiRucMGk3T6s
	 p7Ahf27EptzvoMsOvg9HKPDV1YcDcpHLBnfsDzzJ2F+R7T30gl2YJvadeTAGINkhNO
	 mBuAn4s45rpC+GcgBQz++v6nL6PUSJCxGwAfWkZQ4Yu7R5mXQvnUlMAOLTDPAfIFz3
	 2aFHdIXRxS4UuRaR3HumwpXXVwHw0AZsOPwbRN8hfTln9BC/JkgL4NQQ7Bw2PJ5E9i
	 TVx5zO5ejfU/xY6WF2pHKe6rQ7xmS/bQalBGwCJ1XxJWRvMAxdNkuqQgFOIDp33naN
	 0eVfB0nBNHmwHwFfo4poFGkS8wVW3B6IlyK1wHaMBUGhcD0xpopnG3un0elZKbSyLX
	 /Mp/MHLoxyhx9a4mX8b7tF1oVS1ti+Zk1ISMS+3zwulMWv0SOS/o3/47YtGB9aSjmU
	 Q8ZQYzozoLOTwILXQ5M7cS1k=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 4EEF440E019B;
	Fri, 24 Oct 2025 22:38:01 +0000 (UTC)
Date: Sat, 25 Oct 2025 00:37:46 +0200
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
Subject: Re: [PATCH 01/21] x86/mm/asi: Add
 CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
Message-ID: <20251024223746.GTaPv_uiyc0wd1fPjV@fat_crate.local>
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
 <20250924-b4-asi-page-alloc-v1-1-2d861768041f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250924-b4-asi-page-alloc-v1-1-2d861768041f@google.com>

On Wed, Sep 24, 2025 at 02:59:36PM +0000, Brendan Jackman wrote:
> This long awkward name is for consistency with
> CONFIG_MITIGATION_PAGE_TABLE_ISOLATION.

But why?

I bet you someone will get confused and mean
CONFIG_MITIGATION_PAGE_TABLE_ISOLATION when she means
CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION or vice versa due to the
conglomerate of similar words.

Now compare that to CONFIG_ASI! Wonderfully short and clear.

Especially when the namespace already is "asi_" ...

The only problem with ASI is it doesn't tell you what it is but you can look
it up with simple grepping...

I'd say.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

