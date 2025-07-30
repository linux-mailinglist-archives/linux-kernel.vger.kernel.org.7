Return-Path: <linux-kernel+bounces-751170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34200B165FA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7B89622A9D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB042DAFAE;
	Wed, 30 Jul 2025 18:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UooCSMW6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140871E376E;
	Wed, 30 Jul 2025 18:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753898621; cv=none; b=mignWpTx8rSPHfQWsf/kNRUcJxQYjZIyR5gX90FFLGYd59eGuCS6WWSxAHnebmvmSg7+zEuFlNeMj3ZL/fXmXoxXDl/sdul2S6V73SBRt7HHCLSFMYWcZlfB4dqMEW8/tlnA6pBccGmwud051Bw5f7dn+H/L7Tg8Jpe/E89I5W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753898621; c=relaxed/simple;
	bh=XuIxZJXkGvsx2aUjEgpfoOLrFgjT3OxAJ1hevZ2QySY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6T0uy/RAs3nTGutWMFaEKtHcybvr+N0HyV+ZVcgivi2vijr2J3DeKQV0anFneKMbRTGpdP2/FoCD0HIwH9xfQigJHh4LX1lpqh+lt65i3wtTKzZ/JWQQ1hY1jp6+WmguH57EzKmCoYJYCqRTvuP5Em/hOCZcbd4MozXpsTAFP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UooCSMW6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996EBC4CEEB;
	Wed, 30 Jul 2025 18:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753898620;
	bh=XuIxZJXkGvsx2aUjEgpfoOLrFgjT3OxAJ1hevZ2QySY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UooCSMW6Sm2y20Y0DPRwxx4eoXjJk+GG88pv1lQjtg2JHP1xYCnL9q0XvHvGycWzv
	 dAkUQXzcqXI9eV8dEDbngzalImxXzXsXXuGjkINtlVCvCEXQrBop6VUCgRMHqp4G4F
	 wUz+8jTYGe1kUjErQKBvaYKXvsau6OmZNzpSn17M/oG0/yBmQ3bDVO8lurEIZp0bYW
	 xzteCOvwnG92ih9X6YPg06A7Ai2WrcABgr8rlLSHyXLf0234AuwGtQmRU2xIo9v6tZ
	 s7+lMkE+2WfGC1hDzTX1TH+T7HNaDxEWI0vbDJupOPWPeZmL3zlKHfEhABgRzSQ0wb
	 t2Yar7cuWOemA==
Date: Wed, 30 Jul 2025 14:03:38 -0400
From: Sasha Levin <sashal@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Greg KH <greg@kroah.com>,
	corbet@lwn.net, linux-doc@vger.kernel.org,
	workflows@vger.kernel.org, josh@joshtriplett.org, kees@kernel.org,
	konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <aIpeera8s_tKAllT@lappy>
References: <2025072854-earthen-velcro-8b32@gregkh>
 <df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>
 <20250730112753.17f5af13@gandalf.local.home>
 <158707d7-6729-4bb6-bc72-7556d11bfaef@lucifer.local>
 <20250730121829.0c89228d@gandalf.local.home>
 <aIpKCXrc-k2Dx43x@lappy>
 <a1022055-52bd-4948-9399-908b29ca140a@lucifer.local>
 <aIpSlhPTC9G1AqvO@lappy>
 <eaf1366f-4b28-4312-a820-1cd04796ff1d@lucifer.local>
 <20250730133220.6e7e9370@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250730133220.6e7e9370@gandalf.local.home>

On Wed, Jul 30, 2025 at 01:32:20PM -0400, Steven Rostedt wrote:
>On Wed, 30 Jul 2025 18:23:14 +0100
>Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>> You might suggest presuming a policy for maintainers is inappropriate, but
>> you are doing so wrt the LF policy on the assumption everybody is aware and
>> agrees with it.

No, this isn't about the LF policy. Let's completely ignore it for the
sake of this discussion.

All we require now is a signed DCO. The kernel's own policy, based on
Documentation/, is that we don't even need to disclose tool usage.

>> That same document says individual projects can _override_ this as they
>> please. So the introduction of this document can very well override that.
>>
>> We at the very least need this to be raised at the maintainers summit with
>> a very clear decision on opt-in vs. opt-out, with the decision being
>> communicated clearly.
>
>Agreed.

Right - if this is brought up during maintainer's summit and most folks
are in favor of "red" (or Linus just makes a desicion), we can go ahead
and adopt our own policy and set it to "red".

What I'm saying is that we can't just arbitrarily set it to "red" based
on this thread as this is a change from our current policy

-- 
Thanks,
Sasha

