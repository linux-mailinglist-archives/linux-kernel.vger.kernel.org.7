Return-Path: <linux-kernel+bounces-744951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84524B112E4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5135A62D6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89E72727E9;
	Thu, 24 Jul 2025 21:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOlNhqH/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3502621C183
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 21:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753391727; cv=none; b=RAuuzIYpgpwkYZYRTBrp+GcQx1AdD0JnQiOptNdUQTkMgaspopXjNCXyRpejtpK+EJbhf9hMqYy5LmEENqaPkJoYwYcJ/i9dh4gkD7f9nyl0Hm57Vtl9BGFwM3WnmaenUY94nzzJx/9ExZZwj2NhGuApxpy0rmbWF8kcRcJKQlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753391727; c=relaxed/simple;
	bh=S+iAs0K4q++C82w4BZwJHhfcP6bn1PDc/SNomW8AIYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWPUmzvTmZ8UeQ9gQLk4Fy5FB3fmG2iKrpD4RKARiFRP35Q8HIlCotzg7SKqc2ZsKNpFSQkaWYsWiUl4bKIhN1XjliFtAJMtp+9OcsEDzW3hjLB5DdDs1qgXwm/2Wu/X2STyizO0+LVra5teKuxg6K9Z9qVe6zh5JYe0O3S3ZAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOlNhqH/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5204C4CEED;
	Thu, 24 Jul 2025 21:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753391726;
	bh=S+iAs0K4q++C82w4BZwJHhfcP6bn1PDc/SNomW8AIYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YOlNhqH/A4HTEzvFS6+BFtKkC0c+zXQ9Hrkfp3nUoNRrwmWVUgBL08T/AOZFsZMz0
	 oxm4vhRqbg+yxGaEu/4Dtl4ZqJJdyTLrv1TKDEboxTTsItx7l9QyhjchBLoF84knG3
	 +KrMBEU2zr/gB0v50gsy1vm+3KufIWqLgXYp5VeFwe2W6R5OV2HPBEflJ7JIDMUAOT
	 LzBTYT7beJC3i094SQi9TEHTtRtgOhT7EHjCtSrvkQISJxNNUTf9KMU77b7kuRLi86
	 0hyYK9kb/qinzcPEIr7y4MSCdvOLWNMNuBmKn4OARL5RrKFHfdM17857FR76Cipo55
	 3u4KJ/Lk9ZxFg==
Date: Thu, 24 Jul 2025 14:15:26 -0700
From: Kees Cook <kees@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH v3 2/5] mm/mseal: update madvise() logic
Message-ID: <202507241352.22634450C9@keescook>
References: <cover.1752687069.git.lorenzo.stoakes@oracle.com>
 <ec480dc1fd4ce04bb11c0acac6c6da78dc6f4156.1752687069.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec480dc1fd4ce04bb11c0acac6c6da78dc6f4156.1752687069.git.lorenzo.stoakes@oracle.com>

On Wed, Jul 16, 2025 at 06:38:03PM +0100, Lorenzo Stoakes wrote:
> We make a change to the logic here to correct a mistake - we must disallow
> discard of read-only MAP_PRIVATE file-backed mappings, which previously we
> were not.
> The justification for this change is to account for the case where:
> 
> 1. A MAP_PRIVATE R/W file-backed mapping is established.
> 2. The mapping is written to, which backs it with anonymous memory.
> 3. The mapping is mprotect()'d read-only.
> 4. The mapping is mseal()'d.
> 
> If we were to now allow discard of this data, it would mean mseal() would
> not prevent the unrecoverable discarding of data and it was thus violate
> the semantics of sealed VMAs.

I want to make sure I'm understanding this right:

Was the old behavior to allow discard? (If so, that seems like it wasn't
doing what Linus asked for[1], but it's not clear to me if that was
the behavior Chrome wanted.) The test doesn't appear to validate which
contents end up being visible after the discard, only whether or not
madvise() succeeds.

As an aside, why should discard work in this case even without step 4?
Wouldn't setting "read-only" imply you don't want the memory to change
out from under you? I guess I'm not clear on the semantics: how do memory
protection bits map to madvise actions like this?

-Kees

[1] https://lore.kernel.org/lkml/CAHk-=wiVhHmnXviy1xqStLRozC4ziSugTk=1JOc8ORWd2_0h7g@mail.gmail.com/

-- 
Kees Cook

