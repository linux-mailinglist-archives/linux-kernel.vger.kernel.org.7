Return-Path: <linux-kernel+bounces-893534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5CFC47D42
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0DA23BD7E7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D35A2264BA;
	Mon, 10 Nov 2025 15:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="oPXpjoEe"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AEC2236E5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789453; cv=none; b=S59npfKkRss9O2AQEwzlNfffxjl/U7f5lP0/QSIrnxmXLz2VhbCCN9RCGkCbaeL/SYQnzI0vZPWwq8P6tr6A78Y9/g6svbSQsIMY1l9eaLD9HmqKOT0IobgRXd1MICVH7nXhdqD5Nd7VzrHF4BACOn/iFmv1Pb0JVkyyKSrTXI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789453; c=relaxed/simple;
	bh=m1Hi0yONI4EaULJNgBROwxy7rsqEZV5zIc3zZaLnWA8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qlgIsml6Jg/MWVyXXXbaQMAfMu2dd5gwmrpvN8p1H6unX77QGw1t4pu52J1Ba/wQFtjGx1lcdfz6VKJaVZwlXoako/Pb1LoYPhFSQ/JPJf4w3lIMDdALs4rbrD+yC8+CAhgqr/eiLo7J3EP+TdtIqTJiqViaEAya5XY7VHeWc6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=oPXpjoEe; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A740640B1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1762789450; bh=VIBUdo9LhDz++8I9kKiuqHA89LV869bDVf4M/P0h3vg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=oPXpjoEeeIoaYzjFTdIBbf+/0qsCPQ/iOiw/STZrJ9NtYYiYExKtm9ZmOVvcS9vtX
	 ro4O2TUnZFNSnZvzUV3P4oBwT7oGm3161YfUMLpl0WqeCqAiT07urjPAa0k/chAYsw
	 lN451/CvRDGFRhNLN6P7oP1OuYOqfecw0JDON4Qb2V7uvBoHJ9E2JGvsEiiZzH40IC
	 3lcnTVn8ZESAPhBvpsIy+sNRjZRzRIJ+GGmHjMMeDRwK1uXPdqMU+cbV6jdDdhOBNo
	 dR5CmbDzIUMgfB4xp7QeIViHrVrIrFACte1fHAGT5cUSSGC1jhNNBCCzUDyOrUScFt
	 X2cBxP9CBnzHg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id A740640B1B;
	Mon, 10 Nov 2025 15:44:10 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Dan Williams
 <dan.j.williams@intel.com>, Theodore Ts'o <tytso@mit.edu>, Sasha Levin
 <sashal@kernel.org>, Kees Cook <kees@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, Shuah Khan
 <shuah@kernel.org>
Subject: Re: [PATCH] [v2] Documentation: Provide guidelines for
 tool-generated content
In-Reply-To: <414139b0-92bb-4516-8286-732f2d5e6bda@lucifer.local>
References: <20251105231514.3167738-1-dave.hansen@linux.intel.com>
 <11eaf7fa-27d0-4a57-abf0-5f24c918966c@lucifer.local>
 <87h5v1zzib.fsf@trenco.lwn.net>
 <414139b0-92bb-4516-8286-732f2d5e6bda@lucifer.local>
Date: Mon, 10 Nov 2025 08:44:09 -0700
Message-ID: <878qgdzyd2.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lorenzo Stoakes <lorenzo.stoakes@oracle.com> writes:

> On Mon, Nov 10, 2025 at 08:19:24AM -0700, Jonathan Corbet wrote:
>> Lorenzo Stoakes <lorenzo.stoakes@oracle.com> writes:
>>
>> > It also seems slightly odd to produce this in advance of the maintainer's
>> > summit, as I felt there was some agreement that the topic should be discussed
>> > there?
>> >
>> > Obviously there may be very good reasons for this but it'd be good for
>> > them to be clarified and those who engaged in these discussions to be
>> > cc'd also (or at least ping on threads linking!)
>>
>> The reasoning, from my point of view at least, was to have a starting
>> point for the Maintainers Summit discussion.  Trying to start from
>> scratch in Tokyo seems unlikely to get us far.
>
> I Would understand if this was an RFC or there was a big block saying 'this
> is not yet official' or something, but lt the moment it seems like a change
> sent only to the TAB committee as an apparent 'fait complete' with no
> indication of it being just a starting point? (forgive me if I missed it).
>
> I think pinging the relevant threads would have been helpful, but maybe we
> need a better procedure in general for this kind of thing.

I agree that sending to those threads would have made sense.  Folks are
busy ... I didn't think of that, and it only occurred to me this weekend
that I knew a certain web site where it might make sense to post a
note... 

> I'm not invited to the MS but I wondered if this planned to be discussed
> there? I don't really care about my involvement, only that there is
> community engagement on this.

The agenda has not been worked out, but this topic seems certain to be
there once it is.

jon

