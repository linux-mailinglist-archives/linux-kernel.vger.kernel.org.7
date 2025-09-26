Return-Path: <linux-kernel+bounces-834446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC941BA4B47
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 405614C4571
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D58305958;
	Fri, 26 Sep 2025 16:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ljXSG67H"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A152FF676
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 16:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758905261; cv=none; b=CRe/n5XmFw/k2MXNL9NvB/KmhWCSWAuVLsgVblJTI4ug4x6mIxLj6Q4lqq8Lkwz4FZVpHfLVic8AZ6MOSTzdkK2tui5v2Ds+5SU+wpINmcOSSVLZ4UYNxEcrtikV9/TbX6Hu0CAGWkhai9yBxB6woaaKPAaZFH388IaK/f3RQeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758905261; c=relaxed/simple;
	bh=jO668Vg5SJ0mX9orzDmjWWn0ftBagXD63nxSOMWwzh4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=vAaN5yymUugqUKmdpkAvb4d81i+4rsLCv8W4jLw9Kk052kJBe60N7Nx1XlR31f/S+l3cHhPp2MpDtzKlLySrhDyaxJlJguOotqjLs/UOS/zyu/Gy+5ivUGxm2tbvAWHVVi07N74l/7sMuEQz05/N1Ns8IyFg6jo+YWcMA11n7QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ljXSG67H; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
	In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kkJDBXqcTBkhFi7bi5uYOrbxPVdpxGs1mDpjP3yjmjA=; b=ljXSG67HJCSdMt+v99g66xPI3h
	mzfwaGEtzzmi0+C17cEPOGCSKs0fLLtWDnqW5sPYZfVSzrIFsfBiRXOIgZ6uW2iGiJrwY2kJw9eQP
	BCjpT3v4Qwknyx2U0KBL+TL6I9udxPEhyonFAm+ttIGYKPYAKLF03L71FgAxoZOW3IwRrL3vQcwPb
	CPh72OQkpjtqMCr+v5eY7TUECiQLBC8/fXowZcWCBXDUMUwArKSlCayGPccdoI1khlWcmRIS7/TMi
	drF6o5nlIKcpu6CKIwqDkjBRzKP9Ja4dPVp71DTtODpM0seNR+3oexWxXNlsVbUglrawv6kIw1r5l
	gJC5XADw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v2BbK-000jlo-5o; Fri, 26 Sep 2025 18:47:18 +0200
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1v2BbH-00FPgX-8f; Fri, 26 Sep 2025 18:47:18 +0200
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail with esmtp (Exim 4.96)
	(envelope-from <mfo@igalia.com>)
	id 1v2BbG-00BzAS-2B;
	Fri, 26 Sep 2025 18:47:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 26 Sep 2025 13:47:15 -0300
From: Mauricio Faria de Oliveira <mfo@igalia.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka
 <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, Suren Baghdasaryan
 <surenb@google.com>, Brendan Jackman <jackmanb@google.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH 0/3] mm/page_owner: add options 'print_handle' and
 'print_stack' for 'show_stacks'
In-Reply-To: <aNY49sdoFVe03m_Y@tiehlicka>
References: <20250924174023.261125-1-mfo@igalia.com>
 <aNVpFn9W0jYYr9vs@tiehlicka> <4c2a467113efd085530eb055e4a4e1fe@igalia.com>
 <aNY49sdoFVe03m_Y@tiehlicka>
Message-ID: <d9af42d5cb9d427632087c5f51e50501@igalia.com>
X-Sender: mfo@igalia.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Report: NO, Score=-4.7, Tests=ALL_TRUSTED=-3,AWL=-2.462,BAYES_50=0.8
X-Spam-Score: -46
X-Spam-Bar: ----

On 2025-09-26 03:55, Michal Hocko wrote:
> On Thu 25-09-25 16:38:46, Mauricio Faria de Oliveira wrote:
>> On 2025-09-25 13:08, Michal Hocko wrote:
> [...]
>> > Could you elaborate some more on why the performance really matters here?
>> 
>> Sure.
>> 
>> One reason is optimizing data processing.
>> 
>> Currently, the step to obtain the key of a strack trace (e.g., hashing)
>> incurs
>> a considerable work (done for all stack traces, on every sample) that
>> actually
>> is duplicated work (the same result for each stack trace, on every
>> sample).
> 
> OK, that was not really clear to me but the above seems to suggest that
> by hashing you really mean hashing in the userspace when trying to
> create a key so that you can watch memory consumption trends per stack
> trace (hash in this case) without post processing.

Yes.

> Stating that more explicitly in the changelog along with an example on
> how you are using this would be really helpful. 

Sure. Thanks for pointing that out, and making the effort to understand.

> When the interface was originally introduced the primary usecase was to
> examine biggest memory consumers - e.g. when memory counters do not add
> up to counters that track most common users (e.g. userspace memory, slab
> caches etc.). In those case you need to see those stack traces as those
> are giving you the most valuable information.
> 
> I can see you are coming from a different direction and you want to
> collect data repeatedly and watch for trends rather than analyzing a
> particular situation. This seems like a useful usecase in itself.

Precisely. I can make that more explicit in the changelog as well.

> My main question is whether this should squashed into the existing file
> with a rather strange semantic of controling the file content depending
> on a different file content. Instead, would it make more sense to add
> two more files, one to display your requested key:value data and another
> to resolve key -> stack trace?

I see your point. Either way works for me, honestly.
Let me justify the current way, but it's certainly OK to change it, if
that is preferred.

The use of option files has precedents in page_owner itself
(count_threshould) and ftrace (/sys/kernel/debug/trace/options/*).

The use of output files needs more code/complexity for a similar result,
AFAICT (I actually started it this way, but changed it to minimize
changes). 
The reason is debugfs_create_bool() is more specialized/simpler to
handle than debugfs_create_file().

It ends up with a similar pattern in a common "__stack_print()" to avoid
duplicate code (conditions on parameters to configure the output), and
it adds:
- 2 ops structs per file (file_operations and seq_operations, as in
'show_stacks'), for plumbing different behaviors down to different
functions, to call the common function with different parameters.
- It should be possible to reduce it with private fields (from
debugfs_create_file(data) to seq_file.private), however, since
seq_file.private is used (iterator in stack_start|next()), this needs
more code: a new struct for the private field (to store the current
iterator and add the new parameters).

So, I went for the (IMHO) simpler and smaller implementation with option
files instead of output files.

Please let me know which way is preferred, and I'll send v2 with that
(in addition to the changelog suggestions).

Thanks,

-- 
Mauricio

