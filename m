Return-Path: <linux-kernel+bounces-844935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ADEBC3182
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 02:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 796FB4E83E1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 00:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8282B2882BB;
	Wed,  8 Oct 2025 00:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PT4mQTP/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28632877DF
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 00:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759884824; cv=none; b=WHKoSiy2SQlwL3twAi6fVxlSIjDvSOMxSaJk6RdzvhSDINyBMjlwmh3brk1o5V4IXc6c13Dc2xv6B3IivrULGoU7Z/0K5AZGCGRzSqgh9KTh+djHjwziN9N7Kmfd4C4ICYwSVwoY7r4kL24h1nrcbcCawP3FYanOyA/Upr+BDvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759884824; c=relaxed/simple;
	bh=1/BSCo/joxh3w0gawL9XVBCVbqacTF5mYaO97AtXT5s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bbxiUYoSjO33wPpGQ3TJYXIaZy+/mjME4UnQTUpHZj2CKy4BDur88Bi+e298KoTn64M1lqipHvGF+dLyX1QpWVslaWerV4iE3mVxqBSL5bALIGBadNcDZzLMeURkWxLl61pe4idkqlsRsAjks6zkI1MD4XDf5cKE1MRIfoMLPJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PT4mQTP/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36594C4CEF1;
	Wed,  8 Oct 2025 00:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1759884824;
	bh=1/BSCo/joxh3w0gawL9XVBCVbqacTF5mYaO97AtXT5s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PT4mQTP/K6GkWEsNf4ei2POarUVxGgv3MHpmHQcTv80pfoGWUt0yxbUzuKJSoyP1D
	 RTdHMumSMr2EloY0EbO2htHUtkg4jgpM8Dqbbd0EbEgX23Ovl+iW+6HYEp2cabfhRQ
	 ejoIL9iUlKMHQ5zLx+MTg1jnQ/Kwoy4S3lETa+10=
Date: Tue, 7 Oct 2025 17:53:43 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-kernel@vger.kernel.org, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Jan Kara <jack@suse.cz>, Dev Jain
 <dev.jain@arm.com>, linux-mm@kvack.org
Subject: Re: [PATCH v3] mm: readahead: make thp readahead conditional to
 mmap_miss logic
Message-Id: <20251007175343.107b17191734cddd7bbdeb54@linux-foundation.org>
In-Reply-To: <87play1fzy.fsf@linux.dev>
References: <20251006175106.377411-1-roman.gushchin@linux.dev>
	<20251007153424.1b46a4018e17d5dafd7fb126@linux-foundation.org>
	<87play1fzy.fsf@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 07 Oct 2025 15:52:49 -0700 Roman Gushchin <roman.gushchin@linux.dev> wrote:

> >> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> >> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> >> Cc: Jan Kara <jack@suse.cz>
> >> Cc: Dev Jain <dev.jain@arm.com>
> >
> > But I'll slap the Fixes: in there, it might help someone.
> 
> I'd do exactly what you suggested: Fixes + no stable backport.
> 
> But I guess it still might end up in the LTS tree thanks to
> the automation picking up all fixes. Should be ok too.

They've been asked not to override the MM developers' decisions (ie, mm
is special).

I'm not sure how reliable this is...  And I'm not sure how they
identify the dont-do-that patches.  Maybe mm/*, maybe mm.git, maybe
s-o-b:akpm.  But I haven't seen any transgressions in a year or three.


