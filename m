Return-Path: <linux-kernel+bounces-747435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEAEB133C9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 06:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84E1D3B3715
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 04:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05629217704;
	Mon, 28 Jul 2025 04:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ii/kK01n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA8A15278E;
	Mon, 28 Jul 2025 04:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753678344; cv=none; b=fsgVwmk65YYMyWP2M+iOzk1wSBr63Q/GksQxMKn33nsR6TCO/4AUpKD8Z1UJquYlaO3k7ypvy81/ta7uPf2nnSUYVthc3OnwlD/ACM0618BnEowOqwkHzbd63I7QxedWF9aBR/rtT40gXBAerzw5cT/tlYnKn83CWtEucXt1nOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753678344; c=relaxed/simple;
	bh=UZ80z72GQf4cj2RTuXmwMqdQ+4jeFFJA3CmfekBJiZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UctTlDrtBbXXcwEOjflv9uIna0ZBOXv2+LtiKs6goEI99Xn2avSoyiRuG6jT2Ke8utEDIkQkT5fjY6a5Yzzdbawn5jrBIrTMSPlj8aT6BcnAbwvrmRdQ/ggqyvLIHShzK+1sMlW9eeOyG7aP46RobQ9X48zLiVUgfdY7ej5g4hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ii/kK01n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7920CC4CEE7;
	Mon, 28 Jul 2025 04:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753678343;
	bh=UZ80z72GQf4cj2RTuXmwMqdQ+4jeFFJA3CmfekBJiZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ii/kK01nq/kHB9J70gz5QS+ohNQNAMffjP+bNmkPnqzfdu5oUQInpxT3OPJJ6Hbp8
	 QEuVsR0ZILOkkqK5k5Mh1/2yCEFMERlXt6joSmpIrTdU65dDSOs2nWZuSz7ioicL2g
	 2LQKlp9MtURFCmW9ME1GL22OF7JCmcvpU1NGVl4dQFLFFX53Qb+AVSk4VQ6tEwRA87
	 pcQyIKCSl2oErpbOh6qToV7x2sphsUtwnE1RfDHaor5gbsZrfuyoYKlQQ2U2NYSvFQ
	 Hm6yZ3yMC/ftFe5l6xGosU1/ZsPtmWhnNFlgaLSpcY89K1IxgQWRkTMrc82AzTVqkh
	 wz2Hr/Pcr5chg==
Date: Mon, 28 Jul 2025 00:52:21 -0400
From: Sasha Levin <sashal@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, workflows@vger.kernel.org,
	josh@joshtriplett.org, kees@kernel.org,
	konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org
Subject: Re: [PATCH 2/4] agents: add core development references
Message-ID: <aIcCBZ6MVX1OHKpw@lappy>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <20250727195802.2222764-3-sashal@kernel.org>
 <2025072825-gotten-cupbearer-449a@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025072825-gotten-cupbearer-449a@gregkh>

On Mon, Jul 28, 2025 at 06:24:44AM +0200, Greg KH wrote:
>On Sun, Jul 27, 2025 at 03:58:00PM -0400, Sasha Levin wrote:
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  Documentation/agents/core.rst  | 28 ++++++++++++++++++++++++++++
>>  Documentation/agents/index.rst |  3 ++-
>>  Documentation/agents/main.rst  |  5 +++++
>>  3 files changed, 35 insertions(+), 1 deletion(-)
>>  create mode 100644 Documentation/agents/core.rst
>
>I know I can't take patches without any changelog text, maybe the
>documentation maintainer is more lenient?  :)
>
>>
>> diff --git a/Documentation/agents/core.rst b/Documentation/agents/core.rst
>> new file mode 100644
>> index 000000000000..da171dde1f9d
>> --- /dev/null
>> +++ b/Documentation/agents/core.rst
>> @@ -0,0 +1,28 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +========================================
>> +Core Linux Kernel Development References
>> +========================================
>> +
>> +Essential documentation for Linux kernel development:
>> +
>> +How to do Linux kernel development
>> +----------------------------------
>> +
>> +The comprehensive guide for becoming a Linux kernel developer and learning to work with the kernel development community.
>> +
>> +See :ref:`Documentation/process/howto.rst <process_howto>`
>> +
>> +Submitting patches
>> +------------------
>> +
>> +The essential guide to getting your code into the kernel, covering everything from patch formatting to the submission process.
>> +
>> +See :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
>> +
>> +Submission checklist
>> +--------------------
>> +
>> +A checklist of items to review before submitting code to ensure patches are accepted more quickly.
>> +
>> +See :ref:`Documentation/process/submit-checklist.rst <submitchecklist>`
>
>Why isn't the agent already reading all of this in the documentation
>tree?  Why must it be told to read it again?  Do we not properly index
>this well enough in our documentation tree already?

So by default the agent doesn't read anything into it's context unless
it thinks it's relevant to the task at hand.

Imagine a junior engineer you ask to fix a spelling mistake and commit
the result: would it think on it's own that it needs to read the rules
about which tags to add to commit messages?

Probably not.

Just as with humans, we need to tell them to read the goddamn docs :)

An an example, look at the wiki page for LF's kernel mentorship
program[1]. The first step it lists is:

	Complete the project prerequisite tasks assigned to you when you apply for the project:
	Step 1: You should have completed the A Beginner’s Guide to
	Linux Kernel Development e-course during the planning phase.
	Upload the certificate of completion.

Where the course is basically going over all the processes and rules
around kernel development ("This course is intended for developers who
need to know about the Linux kernel development process and the explicit
and implicit “rules of the road”.").

This patchset is effectively the equivalent of the course for agents :)



[1] https://wiki.linuxfoundation.org/lkmp
[2] https://training.linuxfoundation.org/training/a-beginners-guide-to-linux-kernel-development-lfd103/

-- 
Thanks,
Sasha

