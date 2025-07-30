Return-Path: <linux-kernel+bounces-750130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 199D2B157B6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 05:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA5DB7AFF96
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 03:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4820B1A08AF;
	Wed, 30 Jul 2025 03:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="bDcFjy3Y"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36943FC7
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753844735; cv=none; b=aqoBd2l/V9BMaEiBk6xFi7kInFsOsqXj2rYYnX3Pp/nnr0SGQ0yJqra3SwMb9JmfzdXQAEhDN0krkx+xTTwWdreXr6tHZIfpv6YRFpMqr8xZ2UjwZNHqnHh9q9YbxkM/hHKwLvu0RCgatcxCwJYCuaBtKxHZwA2fhhIJ5PbzB0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753844735; c=relaxed/simple;
	bh=2cVmjzL48aF89y9hD7R/ewVuoHnFw1lFm3kvCRKwczo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOJhZ5ldpVJvL+5VCrdzuXuLTEBu83EzIbwPfFcpLRtavf+C/LLWHKxvkyZxYlevP/CFDW/mbh7G/uBoaq0plcx7GpeW0EVN0rOLHwyaGcqund22G0fkeyvjRFafCdzOT5qJrodnZzvH8NM0s5YtbVvjLmfgAnL2iRMGkWa3iog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=bDcFjy3Y; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-136.bstnma.fios.verizon.net [173.48.82.136])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56U35LuT013902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 23:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1753844723; bh=X6FCQBxWODHzp7D9KqR+LcddZ0o4svswD5nsGmPdAtY=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=bDcFjy3Yh5sbBsz8TnQVmg3/VwxuKPdB0FUywv0wZBn3x2a5uKsTcfMXzJ1c9WECU
	 c5HV9ouxrtCUtzSrhJLm4udVcqj98biM2qLQX5dm3nq3ZROob67gw8/QvzOdRl83TG
	 bFBwyK3jvukzf5zm+cOOFlSEhCZaD3TEPaaMGeTYCQZFT2NJgrHvMnDJQHTGI9DGPP
	 nLrR/pNLSXDMlW9Itb6qqg9sK+D8HcKu1StXSDeDRmAp/+Cf+k+ozwUTYv6Gw6jW+K
	 bfKMdnHt5nLK+h1pPRboqVX07F+Xgm6mgL05rgvBkrzryRiOl+6It7EUcH8nFrxvDK
	 3+qYpb24r3Zug==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id EEC202E00D6; Tue, 29 Jul 2025 23:05:20 -0400 (EDT)
Date: Tue, 29 Jul 2025 23:05:20 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Pavel Machek <pavel@ucw.cz>, "conduct@kernel.org" <conduct@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Code of Conduct violation complaint
Message-ID: <20250730030520.GD273706@mit.edu>
References: <13a6b8e3-a35a-425d-bafc-006e0a52599f@linuxfoundation.org>
 <aHanGu9nOGOegUg2@duo.ucw.cz>
 <878ca180-c54b-44cf-aa14-cf6028723167@linuxfoundation.org>
 <ed6f49c8-d47c-4cf9-889a-76f6886e1a86@linuxfoundation.org>
 <aIXsYh9afmTxiqXF@duo.ucw.cz>
 <f145b475-5b61-4565-8406-98894e706077@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f145b475-5b61-4565-8406-98894e706077@linuxfoundation.org>

Pavel, you might also want to consider that there is a range of ways
that autmation and/or AI can be used.

*) When coding a patch --- this might include Coccinelle, not just
   Large Language Models

*) When writing text in the body of the e-mail.  And again, it's not
   just LLM, but also scripts that might automate Pull requests, or
   replies that maintainers like Greg K-H use when people send
   malformed patches.

Accusing someone who is using Coccinelle to generate a patch is
somehow lacking ethics is hopefully self-evidently nonsense.  And I'd
argue that if someone uses some AI tool to generate patches, or to
help backport a patch to an LTS release, that is similarly a situation
where to claim that therefore the patch "lacks ethics" also just
does't make any sense.

And with both of these categories, there is a distinction regarding
*how* these tools might be used, and how much the human is in the
loop.  If a human uses a tool like Coccinelle, but spends a lot of
time verifying the result, that's quite different from a situation
where Skynet sends a T-1000 robot back in time which with instrctions
to kill without any human in the loop.

Developers have been using tools to help their work for decades,
starting with Emacs macros, perl and sed scripts, and then on to
Coccinelle, and more recently Large Language Models.  So in many ways,
this is nothing new.

It does seem that in your e-mail messages, that you seem to be
engaging in a bit of "all or nothing" thinking, where if someone is
using some kind of AI tool, that it is automatically the most extreme
end of the spectrum --- and so not only do you not know which e-mails
might have used LLM in some way, you don't know *how* LLM was used,
and how much a human being may have curated the output before sending
the e-mail or the patch.

There are discussions that perhaps people should disclose when LLM's
are used to generate patches, and that might make sense (although
people haven't made similar demands when Emacs macros were used to
help automate say, a global renaming of function or variable).

Regaerdless of how those discussions turn out, your making the
*assumption* that a fellow developer must be lacking in all ethics is
just not a great way to interact with each other.  Whether the tool
involved is a bash script sending patches or a pull request, Emacs, or
Coccinelle, or some Large Language Model, using tools is not grounds
for assuming that all messages sent by a particular person is "lacking
in ethics".

Cheers,

						- Ted

