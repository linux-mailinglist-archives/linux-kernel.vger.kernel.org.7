Return-Path: <linux-kernel+bounces-844845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC52BC2E63
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 00:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E0393C8217
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 22:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00322258CFA;
	Tue,  7 Oct 2025 22:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lXCJDcLG"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EBA2475CE
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 22:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759877583; cv=none; b=sj69nb8QG40JC1E5tEXUGPxoKy9RH7aL/T6VCenVOBnmJsZxppFDK7Zgm1mIaYi6hYT1Jm46G+uUAxP5A3KsQb2z6q0OM7DH8YWtK2TH4A4Z2k7+8p4wozEDOUxSdgcO95E1Pq6/Eiua6K3x4Vquck1O8Smw8JWQmfnrY+ESS9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759877583; c=relaxed/simple;
	bh=GMp9eOBBxkxCv2LqIY9MRCC0DFxxeBdOrkTDHvDkv00=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nD/8KH05T5NPo2yGkLMZhd8s7uobR9162TYicw1V+MnXUxAnE8/ZvZF18d9I533ZUYdsiEFeDsRzFPpZ2MEjdHoswda70HOAyniP7pqImqs6V+5lPfhQ8vzjICfN6lqwoMo7gZfvJaiexPuZ5peWk9sqEolphJzGJE7K+/ryTCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lXCJDcLG; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759877576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+zGrEhn9yIbxrx8akVC6Rjuew94sMfqEV9qMdvVonCg=;
	b=lXCJDcLGRCwwkU7jnZ6bJv2a3MjwgazcrxC0yJDKX0uEgsGEiDtW8vVSPksXSB0lOUih7r
	wYcsqQKVxqBhyasR8cNmnFe5KxrJnjYHEonk2ybtQeg1pM1/fxvhkoV16ih1XjUDmeKkRV
	xPToa6kJLGuv9CFDOcW6yEQpU37guAg=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,  "Matthew Wilcox (Oracle)"
 <willy@infradead.org>,  Jan Kara <jack@suse.cz>,  Dev Jain
 <dev.jain@arm.com>,  linux-mm@kvack.org
Subject: Re: [PATCH v3] mm: readahead: make thp readahead conditional to
 mmap_miss logic
In-Reply-To: <20251007153424.1b46a4018e17d5dafd7fb126@linux-foundation.org>
	(Andrew Morton's message of "Tue, 7 Oct 2025 15:34:24 -0700")
References: <20251006175106.377411-1-roman.gushchin@linux.dev>
	<20251007153424.1b46a4018e17d5dafd7fb126@linux-foundation.org>
Date: Tue, 07 Oct 2025 15:52:49 -0700
Message-ID: <87play1fzy.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Andrew Morton <akpm@linux-foundation.org> writes:

> On Mon,  6 Oct 2025 10:51:06 -0700 Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
>> Commit 4687fdbb805a ("mm/filemap: Support VM_HUGEPAGE for file mappings")
>> introduced a special handling for VM_HUGEPAGE mappings: even if the
>> readahead is disabled, 1 or 2 HPAGE_PMD_ORDER pages are
>> allocated.
>
> Three years ago.
>
>> This change causes a significant regression
>
> So no backport suggested?  I guess reasonable given how long 4687fdbb805a has
> been in tree.

Yes, this was my thinking. Also you need a very specific setup to reveal
this regression.

>> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
>> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
>> Cc: Jan Kara <jack@suse.cz>
>> Cc: Dev Jain <dev.jain@arm.com>
>
> But I'll slap the Fixes: in there, it might help someone.

I'd do exactly what you suggested: Fixes + no stable backport.

But I guess it still might end up in the LTS tree thanks to
the automation picking up all fixes. Should be ok too.

Thanks!

