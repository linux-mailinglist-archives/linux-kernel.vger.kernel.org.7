Return-Path: <linux-kernel+bounces-843469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F950BBF8B5
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 23:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DEBE24E3EE8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 21:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B2029B776;
	Mon,  6 Oct 2025 21:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="AO0KEAPd"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903431A83F7
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 21:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759784979; cv=none; b=GEobbj4Ny4hz5xrPruhxWpCYLfX+pkp5FtrTDNi3sxJfFnqw3u2htKeH1oZwMHJ56CTvcvN5ZdUUktdmoOjSQ2Nd/eTIbdhSgnmHLVqYEOTIaxGTt+UKWHnJQ54KBFNI4KBGsVGQa7Ns/ti8lFN4SOCQMhf/yqyeyHQgpXwNIU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759784979; c=relaxed/simple;
	bh=Ap074zAXu4mFrWRLm0JmNuIFRsZhfvi1z8w8FgfUmBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKlOg6MJhCQhiBIJdjshCu4yFVGEZ5uLYL3JdFE14F7VtYXQ0RtNx9k9BScKM3q+rNppsjHo5EbQfpxWqqbzJU5B16zgZXbCiVpgaRUhJbvIIbIw9z8bl8HlNBzdA90jIZW3cPsOkt0m/zmp1gOWbeqjB5S9zaRwI//lt1/XjGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=AO0KEAPd; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E2A4640E01C9;
	Mon,  6 Oct 2025 21:09:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kO3OOCYxCCv7; Mon,  6 Oct 2025 21:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1759784968; bh=c1+6SsyXr16iTJ9Mxlw1sQUYPEdrrt9C/MDPFCz5oQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AO0KEAPdmak5kRZvbh+e01mPzXjcPeHZCiS0xWxsAS1eszdoNs7KjyvcEaSYvRZ1q
	 2FPsrvEh2yqV6krGFgLzaaucDGzpu1CrWXQKAefaxjYGVaqSv5XfmkWuxXxQaEmq+y
	 RXtJMIGOSpbz3WzmLb3a/evVa7wklFQLgABJ0juUi95nG5dzv5BxC+NyBykYDbKCTv
	 CC5KS8Y6UlZraisI6n6W+qvzTf+m0NB751l28oRwVoUc05HpbukcSRk8yFUshhPaKJ
	 86QX86hdyuMZhKViNqA/+I7f6Cg5js0WhAusT8TW1NVrO3oaQOfEERGFKOmnLG/V0+
	 L//RiJXyJZZd2IIl8UC+0+jZsuh+cFfk7+rpyl72aEToR/H0+Nwd0F8agUsmT0D9TR
	 HVkP5eBnYtwOprWa3cxigmP+n+uDePA1QdL+Gov0McM30JJr7mYz0bXhqcOK9sriZi
	 /ric9zerBvVhuQ6Z2JgaF0JXvyW4P/Yp1oVxaIu5CYtLoUrPW6b9wveHjLFGWboqiK
	 BO5UiufMZ0pGMHaS7O92gzAQvTHdBZPNNGBcJ7YsL6wmC0tHtnvyaLVtU0gjOsvqy5
	 4BYGt6XqqTd0QRAGL3l4CLYCjLQ4P6sq1t3UnKZ+O8bAZfOYWWcyntJzMvgiT4Lfn4
	 okWIRMFGNrfK8E6Rkpayoccg=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 8DFD840E019B;
	Mon,  6 Oct 2025 21:09:24 +0000 (UTC)
Date: Mon, 6 Oct 2025 23:09:19 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, x86-ml <x86@kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] x86/apic for v6.18-rc1
Message-ID: <20251006210919.GIaOQv_6AwhmPRu7fr@fat_crate.local>
References: <20250926102823.GAaNZqxzXkasrXXFjn@fat_crate.local>
 <CAHk-=wibOJBAp66CPz0qfSWe93iisGvN4xL_MzuwSZ8sAut09A@mail.gmail.com>
 <20251006122857.GAaOO2CX8vkmVw_4Ya@fat_crate.local>
 <CAHk-=wg65RDkvPd3rFZr32n8L_LQJAcWie1K-=azcLS6Y5JwkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wg65RDkvPd3rFZr32n8L_LQJAcWie1K-=azcLS6Y5JwkQ@mail.gmail.com>

On Mon, Oct 06, 2025 at 08:59:09AM -0700, Linus Torvalds wrote:
> So the biggest issue really was just the explanations. Both the
> explanation for why the merge happened in the first place, but then
> also the resulting explanation in the pull request.
> 
> Due to the merge, I feel that the explanations in *my* merge ends up
> being less than great. I think it would have been good to just have
> separate explanations for the apic init thing and the SEV parts,
> because they seem entirely independent.
> 
> But maybe they weren't as independent as I think they are, and there
> was some deeper reason for the merge that just was never explained.

So there was some confusion with urgent stuff we send you during the -rc
phase, see

85df1cd15ff5 ("Merge branch 'x86/urgent' into x86/apic, to resolve conflict")

but it is still not clear to me - maybe I'm missing it - why mingo did those
merges... when I merge the topic branches, rerere works just fine and there's
no need to prematurely resolve conflicts and then make them permanent.
Especially if things might change later...

> Basically, a conflict is never a reason for a merge. That would be
> unphysical: conflicts happen _due_ to a merge, so a merge is the
> reason for a conflict, not the other way around.
> 
> If the merge was done for some linux-next or testing purpose, then the
> merging should have been done in a branch _for_ testing or linux-next
> integration, and then there would be a reason  ("merge for testing /
> linux-next").

Right. There was a x86/merge branch in the past for similar reasons...

> And if the merge is because of some future conflict resolution, then
> that should be stated too ("This conflict is so complicated that we
> don't trust that Linus will get it right, so we're merging it for him.
> Linus needs all the help he can get, and he's not always at his
> sharpest").

Bah, there's no need for that. That is basically done by: "Hey Linus, here's
the merge I've done, the end result should be like this..."

:-)

> But "merge due to a conflict" is simply never a reason in itself. It's
> like saying "The sun came up because I woke up". That's not how the
> world works.

Right, like I said, there might be a reason for this which I'm not aware of.
But for the future, I'll pay attention and keep such branches separate and
give you the gory merging details + patch tetris instead so that you can have
some of the fun too. :-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

