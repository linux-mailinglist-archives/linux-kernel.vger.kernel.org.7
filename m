Return-Path: <linux-kernel+bounces-745031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E533B113E4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 00:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318EAAC7BE7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51F623BCF7;
	Thu, 24 Jul 2025 22:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqbfNbPD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BE2230BE4
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 22:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753396176; cv=none; b=Y2uUcm5+q+JCuLWb7dmHuxEm6Nz9lFphCqhy7UYJMmiOD1yJ5RCx0O5CcomDVDJBbr6tRxeGP1O03z7MYNCMyvxgwZHaIUF52wB3pG8PMaRRaMjt75ZV2KlGKfX11J+aSL06tEHDl5e+41rawwnG3Nia3fItbHOLfSzQn63OuMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753396176; c=relaxed/simple;
	bh=W+PLhvsmzTgMSVd5jUXqYnhed16MMxVnE25H0ac9/Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wt0xwGasGrdDHNl8eCfcmcLw5U6cPG/efLMcaM59u1P/3joN6BPs23rabwRWczrwjCuH1P9IBXvklRjFlkfcbusRIo9TXhpwwRihyVBtvE01RxSvW2LfhirbYcnl/Byn8mLGfykXF99PAu25Wp/NOh53OPDjjIwqOkwOmTiq1/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqbfNbPD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD4FC4CEED;
	Thu, 24 Jul 2025 22:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753396176;
	bh=W+PLhvsmzTgMSVd5jUXqYnhed16MMxVnE25H0ac9/Pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MqbfNbPDaviGnvO64ciSpBqc/ox0Jl7XneeIO8AVezVenHude+I/K2YyWwGr39t9N
	 Bc5nu38G37xNaZnUluI0HsBJqyGkKbaK9TUxmVu2DMJmYlyIW9VCQ8u3XsqOqB3TSG
	 rbcnnHQVI8ALO80+JF/kmon5qcGn6Clkpt7RYWqU5WPwKNr6rFibbeluZIqnkNC1Ud
	 8Sr+R3Bwy59Tfn/FVFetQPWlI+xFAWsxew6nKq8yJPU6F+OGd+debCHPN/clEP+YxX
	 Bu4hL+mxNV4t05wexN2LVwyT7xs0iPsKVLYrW0VA5cxR/Ndc5kh6AN0BU9MiwWHivO
	 clndEu5FCvSrg==
Date: Thu, 24 Jul 2025 15:29:35 -0700
From: Kees Cook <kees@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH v3 2/5] mm/mseal: update madvise() logic
Message-ID: <202507241528.A73E1178@keescook>
References: <cover.1752687069.git.lorenzo.stoakes@oracle.com>
 <ec480dc1fd4ce04bb11c0acac6c6da78dc6f4156.1752687069.git.lorenzo.stoakes@oracle.com>
 <202507241352.22634450C9@keescook>
 <e0a22433-541c-40b0-92bb-34b0596db642@redhat.com>
 <ef111032-e108-4771-9202-b8cdab278422@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef111032-e108-4771-9202-b8cdab278422@redhat.com>

On Thu, Jul 24, 2025 at 11:41:04PM +0200, David Hildenbrand wrote:
> On 24.07.25 23:32, David Hildenbrand wrote:
> > > As an aside, why should discard work in this case even without step 4?
> > > Wouldn't setting "read-only" imply you don't want the memory to change
> > > out from under you? I guess I'm not clear on the semantics: how do memory
> > > protection bits map to madvise actions like this?
> > 
> > They generally don't affect MADV_DONTNEED behavior. The only documented
> > (man page) reason for EPERM in the man page is related to MADV_HWPOISON.
> > 
> 
> (Exception: MADV_POPULATE_READ/MADV_POPULATE_WRITE requires corresponding
> permissions)

Shouldn't an MADV action that changes memory contents require the W bit
though? I mean, I assume the ship may have sailed on this, but it feels
mismatched to me.

-- 
Kees Cook

