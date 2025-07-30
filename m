Return-Path: <linux-kernel+bounces-751165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE98B165E8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42EC85820E5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6644B2E2665;
	Wed, 30 Jul 2025 17:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="S6J1FdkE"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B06A2E1726;
	Wed, 30 Jul 2025 17:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753898358; cv=none; b=F1HQZVki8E4FNGc3R5kisFdt7mKMbzEe3TDwXmy6tBweYJxQXyrVhTVbucVABnTEZzr/IUEK85SLa1b0t9nfPsISzTh/alyzPQr5SBV+qT7vA8AiNfmykcop7wvHMkOGfO1VkjSbVoql5XFwRMSzka7KOYQGgmnRwoMmjRfCk1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753898358; c=relaxed/simple;
	bh=qEcJaOUH46TT0ovyqaDstceetO9DHyTsZZ58j9z7nU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1eq8qgfHofSS9mKQI5TWxnjNjdQk/qmWGGXUK7A1ETPLrIuhdtMxDF6bP5tJ6CX8DHhx9bst26oUWvy492mctBpJp8EMpOYB8DPU7N6DNj12u8CAliTiBGDP9a5otvsyTtf5EZmr1x30yHhuolFyxXEKJ+WHh5ULOmdtY5uBQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=S6J1FdkE; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8pVaSKs5rzYlGzZBBoOc+Zefw0mGfC/uMT2S9oNz9EI=; b=S6J1FdkEYzPj0YE4Tw8OownB6D
	ZQY2kgNX5MjoetQ/E/xcMMxilINE4uWdIuE7EGaOllU9xGmVFiKD2FAi6UK5tY5sIfKz23ewODrQ+
	pR3shXmO/dmWKkjY/EEV31zNRHQzCQT3R41Vpfr7iT9vDaf/ZnACvEIWNlR7y59kZ5OFo81bUzlQO
	UST/Tf1f4kUJ9qhMImwnNY6w6riJJgaZ5N7cgfco1ciJSjhshHhF9bVp7vIgURFbhfY0guhwjjKvv
	fyrWjzEF6m/0Q0tphVzN7p+9sWo8N17NqdM0YlXLhPIUvEj36/kAOkplJfXECiBA6+qjKel5SLcen
	g6qryDug==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhB53-0000000FOGl-1h66;
	Wed, 30 Jul 2025 17:59:09 +0000
Date: Wed, 30 Jul 2025 18:59:09 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Sasha Levin <sashal@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Greg KH <greg@kroah.com>, corbet@lwn.net, linux-doc@vger.kernel.org,
	workflows@vger.kernel.org, josh@joshtriplett.org, kees@kernel.org,
	konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <20250730175909.GO222315@ZenIV>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local>
 <2025072854-earthen-velcro-8b32@gregkh>
 <df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>
 <20250730112753.17f5af13@gandalf.local.home>
 <158707d7-6729-4bb6-bc72-7556d11bfaef@lucifer.local>
 <20250730121829.0c89228d@gandalf.local.home>
 <aIpKCXrc-k2Dx43x@lappy>
 <20250730130531.4855a38b@gandalf.local.home>
 <aIpah6DTRd99mMqb@lappy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIpah6DTRd99mMqb@lappy>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jul 30, 2025 at 01:46:47PM -0400, Sasha Levin wrote:

> Similarily the argument around not trusting the code is equivalent to
> not trusting the person who sent the code in. AI doesn't send patches on
> it's own - humans do. This is basically saying "I didn't even look at
> your patch because I don't trust you".

One name: Markus Elfring.  Ever tried to reason with that one?  Or Hillf
Danton, for that matter.

And I absolutely will refuse to take patches from somebody who would
consistently fail to explain why the patch is correct and needed.  Sasha,
this is the elephant in the room: we *ALREADY* get "contributions" that
very clearly stem from "$TOOL says so, what else do you need?" kind of
reasoning and some of that dreck ends up in the tree.  AI will serve as
a force multiplier for those...  persons.

