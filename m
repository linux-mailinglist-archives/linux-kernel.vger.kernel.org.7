Return-Path: <linux-kernel+bounces-747980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE79DB13AF8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B9AE7A83DD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 13:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAC7264A9E;
	Mon, 28 Jul 2025 13:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgXRYpFk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB4E16DEB1;
	Mon, 28 Jul 2025 13:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753707940; cv=none; b=smJjffMyp20w+/odI1QI/g8clkh+nqDHbz3/lijJcw1AVF2oBj2YXZmSxPhf39KpqhelnQDT7RZGb19ISXg41c6dREQX7jCnM3KXAWmkOcjS0xYlwSwJwauwUWXbi8cD/4mqjM9dB5J1XuvnYxlh0dCfLZQVyyS9e3357RzraU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753707940; c=relaxed/simple;
	bh=R6RI9H1uXWNlU4ETqJK1DDEoTkl/2mn5+ywmuILAy18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDdLjnF8LU5T2dnTaiGYO0XVIF3zkMtWGN+wVaqi1nvWK87wEhrhmoo5KaBe1MWU9/iuy8a9ImB4uQjtD2TLzjHGEBq1/2gQtV5166GeyeqMYEYK4JcE/8D5Pa1JAfx9Y8eOVZDhwtVrxgw/HnVDdly5C28cqBW5pXgk5tgY6eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgXRYpFk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B52C4CEE7;
	Mon, 28 Jul 2025 13:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753707939;
	bh=R6RI9H1uXWNlU4ETqJK1DDEoTkl/2mn5+ywmuILAy18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SgXRYpFkjkwkJw64t2Vwdul68XG1XUcx80GOR6lhsWasEmld1JC39phP0skavgn+Y
	 vmSo8LB/j6HGgIovw+R0pCuEarSMf90s0d/+5QlkorMVmFWQq/rsI42mV6uHeZ1/qZ
	 RrLOsqEf1kY4Ast7Rr/gvVYccfE4EyeSIoAC5EC6d1nZxFzxppKrlZoRT7WT83h+oB
	 vN/kdOXuEG9/8BJgVLp/2b2jnP8DXKGFEMYz7ZyUo8rk3vbVBa2q4jqNjYP2X626q9
	 waL29A3QqiWxL79xTW5TSsBHX6v3fjZu9GmXd1n0PE/2GzGrRPl2vR97PTS9dV2QWq
	 +Hu0O/UeMDpIg==
Date: Mon, 28 Jul 2025 09:05:37 -0400
From: Sasha Levin <sashal@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Vlastimil Babka <vbabka@suse.cz>,
	corbet@lwn.net, linux-doc@vger.kernel.org,
	workflows@vger.kernel.org, josh@joshtriplett.org, kees@kernel.org,
	konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <aId1oZn_KFaa0R_Q@lappy>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <75d86e96-cb18-4996-998c-da7ac0e97468@suse.cz>
 <9afd157a-296d-4f4d-9d65-07b89ab3906f@redhat.com>
 <2025072832-enrich-pampers-54b9@gregkh>
 <1bd04ce1-87c0-4e23-b155-84f7235f6072@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1bd04ce1-87c0-4e23-b155-84f7235f6072@redhat.com>

On Mon, Jul 28, 2025 at 12:47:55PM +0200, David Hildenbrand wrote:
>We cannot keep complaining about maintainer overload and, at the same 
>time, encourage people to bombard us with even more of that stuff.
>
>Clearly flagging stuff as AI-generated can maybe help. But really, 
>what we need is a proper AI policy. I think QEMU did a good job 
>(again, maybe too strict, not sure).

So I've sent this series because I thought it's a parallel effort to the
effort of creating an "AI Policy".

Right now we already (implicitly) have a policy as far as these
contributions go, based on
https://www.linuxfoundation.org/legal/generative-ai and the lack of
other guidelines in our codebase, we effectively welcome AI generated
contributions without any other requirements beyond the ones that affect
a regular human.

This series of patches attempts to clarify that point to AI: it has to
follow the same requirements and rules that humans do.

>I'll note one interesting thing in the QEMU commit I linked:
>
>"Thus far though, this is has not been matched by a broadly
>accepted legal interpretation of the licensing implications for code
>generator outputs. While the vendors may claim there is no problem and
>a free choice of license is possible, they have an inherent conflict
>of interest in promoting this interpretation."
>
>[1] https://lkml.kernel.org/r/a4d8b292-154a-4d14-90e4-6c822acf1cfb@redhat.com

I get why QEMU did this: they don't have the resources, the lawyers, nor
the interest in dealing with this open question, so they're playing it
safe until we know more. That sounds like a very smart thing to do on
their end.

On our end, one of the reasons the kernel is part of the LF is to tackle
exactly this: none of us are lawyers, but luckily we have lawyers and
resources on our side to help us navigate these challanges.

I'd like to think that there's no conflict of interests within the LF,
and that their opinion on this matter best represents their client's
(both Linux Kernel as well as Linus's) best interests.

-- 
Thanks,
Sasha

