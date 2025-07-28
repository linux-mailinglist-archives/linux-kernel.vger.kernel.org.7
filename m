Return-Path: <linux-kernel+bounces-747958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A85B13AB0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C6E3173189
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2081F265CA2;
	Mon, 28 Jul 2025 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/FcKi+h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7702B13D51E;
	Mon, 28 Jul 2025 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753706722; cv=none; b=gdSzBy2y2wSq6QfFOOdQ4DXukQGTayV1UJUgtdfpJVRMKAIjbXgDPmHkO61ws++sXhCZdbxt/KgU8VERjOch4UegwCfimCETPJk0YyLXKWW2c8TvFlsApSn1t94FcVY5q46k5yP5PA+1VTldyUltV8NON0mSOcbjfNSBOFb1ZaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753706722; c=relaxed/simple;
	bh=GugSHvy+IJFFREl/nAn10zyTSudtGXDdHs192vJUo3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cA32a2/k/Z8Bv02Erkv5u8qCrRWkWhFHFnbDtBEOMUWaW1rvIc1RY5+tlFxNOmIzX+EzkM5OTjIcVFYpxcF22HjT+PdYt9d49b3siK9Djuuc7ypI5LTzcnv6SLIqhXz09XsEY+aLztKeyGMtfRng6q3/TnYB2V0CNw0ZQfSa3Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/FcKi+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4175CC4CEE7;
	Mon, 28 Jul 2025 12:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753706721;
	bh=GugSHvy+IJFFREl/nAn10zyTSudtGXDdHs192vJUo3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J/FcKi+hjv9Iqn2RYaI04kXyLfzYaJ0EgCdEefTIVQYhMRE4SG64xA2v937xYdk2/
	 A6bibL8mGIajh5Hmaoket1pqclZACy7UljY7IhoFvs9MsYHJD50c9F4PJPHJ066ghF
	 1iT+HlVnom4L8fCYSKvY1JicpPLt3rToYizVt/mla6cTyXiwrlZQnsXLJEIKkU7AAh
	 RzJx3e/IiE0H6dexSi+y3Syq9vgMdhf6drHB/jrhntmHY2OydFJTUrFxDKsuAnAl2I
	 /9IeKbTDPjfYIFAEOO5g1dwCzor1jFw1+DjiXEnJp1LWpSsDJ60jdPyJ1sMASF06Po
	 crjPWKqWJIh3g==
Date: Mon, 28 Jul 2025 08:45:19 -0400
From: Sasha Levin <sashal@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Greg KH <greg@kroah.com>, corbet@lwn.net, linux-doc@vger.kernel.org,
	workflows@vger.kernel.org, josh@joshtriplett.org, kees@kernel.org,
	konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <aIdw3-G04QQPvJtU@lappy>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local>
 <2025072854-earthen-velcro-8b32@gregkh>
 <df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>

On Mon, Jul 28, 2025 at 11:52:47AM +0100, Lorenzo Stoakes wrote:
>One thing to note is that I struggled to get an LLM to read MAINTAINERS
>properly recently (it assured me, with absolute confidence, that the SLAB
>ALLOCATOR section was in fact 'SLAB ALLOCATORS' + provided me with
>completely incorrect contents, and told me that if I didn't believe it I
>should go check :)

Heh, I wouldn't trust LLM with anything more than mechanical
transformations or test writing at this point :)

>So at all times I think ensuring the human element is aware that they need
>to do some kind of checking/filtering is key.
>
>But that can be handled by a carefully worded policy document.

Right. The prupose of this series is not to create a new LLM policy but
rather try and enforce our existing set of policies on LLMs.

Right now the "official" policy of our project is that we accept agent
generated contributions without any requirements beyond what applies to
regular humans, which most LLMs promptly skip reading and go do their
own thing...

So I wanted to at least force LLMs to go RTFM before writing code.

>>
>> > In addition, it's concerning that we're explicitly adding configs for
>> > specific, commercial, products. This might be seen as an endorsement
>> > whether intended or not.
>>
>> Don't we already have that for a few things already, like .editorconfig?
>
>Right, but I think it's a whole other level when it's a subscription
>service. I realise we have to be practical, but it's just something to be
>aware of.
>
>Perhaps an entry in the AI doc along the lines of 'provision of
>configuration for a service is not advocating for that service, it is
>simply provided for convenience' or similar might help.

It also gives us the option of dropping some of these if we find them to
be either horrible at their job or just being abused.

-- 
Thanks,
Sasha

