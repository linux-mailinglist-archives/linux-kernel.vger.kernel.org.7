Return-Path: <linux-kernel+bounces-839326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8668BB1600
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 19:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FBA019483E9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 17:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CC52C08C8;
	Wed,  1 Oct 2025 17:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="CzkyLBWB"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0469D288DB
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 17:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759340283; cv=none; b=fqyjtYxM1/G+R8rNhzbpd1Wmag6Lnx7f3oYsIgEH2IS1bHasi2ZE2Df6HTI6wVZufbeYO3OVKRiCcB4NMlgBcfscG5wwHuDk1qIjV18CySs807c+yfAb4sjsNBq5l3HiEnUOjbTQyLlHLQI3byIpIVB6lV/BNt+C1/vFunkB+rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759340283; c=relaxed/simple;
	bh=B1gxvvDchJKCvBAARTpLGURcUCItd30x0wIs96iubrc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=fi8Av0TPc6Zq/jAOWl/8/K0GBOXrryJOmKtXAtRpxljcfuNQ/yKSXYq4ZvTIakqIjAhKLzl53xZE0uUGQR1R9RM+IFHRvMw7n3eS3IAgZSNyxctV0nCLGhuD9b3/rdFnMYBYUjk1uJF/qNaqYLV5kHanCFZt+OApGUSFbnEX+ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=CzkyLBWB; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
	In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=RLQF7hlwLiNbgD0/kLpi7LFdq0EzdBt4j9S3ZW5Beyg=; b=CzkyLBWBo+F09mIBNDjONPJ19f
	j2/0o2OpjS4uXs4dqolkJmAAAVEiB2z247jc5yGRZm/tbqXoz9UG28XhzMOedeuke0fRlknifHwSB
	AnlQ/9o13cKW9Qj4LgMuJHNZSppeP8dQV3O2r8UaNWQk8Qfis4Dn+yhfYn8VeT34tSHxjZMO2hzNT
	5TuDj10FNtqdup2Wtk259FYAEO79+LGO8z62UVPi9XkdS9ZPuXS4iXVqyvMf+1FH6LEv9B0vi1Sp/
	0CHNJd2kbRVo/BnOAloVMNrC3SLi927Iq8SgOxiWc0Bstexy1GSxdtJbqBaMqlhL8Nt/SdPOvsVjz
	xddHSs5g==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v40lq-002x6u-Rf; Wed, 01 Oct 2025 19:37:42 +0200
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1v40lo-003D1w-Mq; Wed, 01 Oct 2025 19:37:42 +0200
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail with esmtp (Exim 4.96)
	(envelope-from <mfo@igalia.com>)
	id 1v40lo-00Cxj4-0O;
	Wed, 01 Oct 2025 19:37:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 01 Oct 2025 14:37:40 -0300
From: Mauricio Faria de Oliveira <mfo@igalia.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Michal Hocko <mhocko@suse.com>, Andrew Morton
 <akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>, Suren
 Baghdasaryan <surenb@google.com>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH 0/3] mm/page_owner: add options 'print_handle' and
 'print_stack' for 'show_stacks'
In-Reply-To: <602271e2-86c9-4a63-845a-b84407d3aa51@suse.cz>
References: <20250924174023.261125-1-mfo@igalia.com>
 <aNVpFn9W0jYYr9vs@tiehlicka> <4c2a467113efd085530eb055e4a4e1fe@igalia.com>
 <aNY49sdoFVe03m_Y@tiehlicka> <d9af42d5cb9d427632087c5f51e50501@igalia.com>
 <aNvjDsBuw3hqwy31@tiehlicka> <602271e2-86c9-4a63-845a-b84407d3aa51@suse.cz>
Message-ID: <370b7e1d29a382471db93475f4419f22@igalia.com>
X-Sender: mfo@igalia.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Report: NO, Score=-4.8, Tests=ALL_TRUSTED=-3,AWL=-2.646,BAYES_50=0.8
X-Spam-Score: -47
X-Spam-Bar: ----

On 2025-10-01 07:58, Vlastimil Babka wrote:
> On 9/30/25 4:02 PM, Michal Hocko wrote:
>> On Fri 26-09-25 13:47:15, Mauricio Faria de Oliveira wrote:
>>>> My main question is whether this should squashed into the existing file
>>>> with a rather strange semantic of controling the file content depending
>>>> on a different file content. Instead, would it make more sense to add
>>>> two more files, one to display your requested key:value data and another
>>>> to resolve key -> stack trace?
>>>
>>> I see your point. Either way works for me, honestly.
>>> Let me justify the current way, but it's certainly OK to change it, if
>>> that is preferred.
>>>
>>> The use of option files has precedents in page_owner itself
>>> (count_threshould) and ftrace (/sys/kernel/debug/trace/options/*).
>>>
>>> The use of output files needs more code/complexity for a similar result,
>>> AFAICT (I actually started it this way, but changed it to minimize
>>> changes). 
>>> The reason is debugfs_create_bool() is more specialized/simpler to
>>> handle than debugfs_create_file().
>>>
>>> It ends up with a similar pattern in a common "__stack_print()" to avoid
>>> duplicate code (conditions on parameters to configure the output), and
>>> it adds:
>>> - 2 ops structs per file (file_operations and seq_operations, as in
>>> 'show_stacks'), for plumbing different behaviors down to different
>>> functions, to call the common function with different parameters.
>>> - It should be possible to reduce it with private fields (from
>>> debugfs_create_file(data) to seq_file.private), however, since
>>> seq_file.private is used (iterator in stack_start|next()), this needs
>>> more code: a new struct for the private field (to store the current
>>> iterator and add the new parameters).
>>>
>>> So, I went for the (IMHO) simpler and smaller implementation with option
>>> files instead of output files.
>>>
>>> Please let me know which way is preferred, and I'll send v2 with that
>>> (in addition to the changelog suggestions).
>> 
>> Sure, I see. The main problem with the option file is that it is
>> inherently suited for a single consumer which is a hard assumption to
>> make at this stage. So I think it is worth having a separate 2 files
>> which provide the missing functionality.
> 
> Agreed, we should prioritize a better userspace API over having simpler
> kernel implementation.

Just to clarify, I agree. I personally considered option files a good
userspace API for this, but later realized the different perspective
above.

> Will count_threshold apply the same to the new file that prints only
> handles? I guess it will?

Yes. The new file that prints only handles should only differ in format,
not behavior.

This is different for the file that translates handles to stacks,
though. For that, count_threshould does not apply, as a previously
reported handle may have less pages and not make it, which would not
allow it to be resolved to a stack trace.

> Also the handles to stack translation file could perhaps support
> "seeking" to a specific handle if you're interested in only a few
> handles. Perhaps not necessary though if you plan to read it all just once.

That sounds cool. For the current usecase, it only needs to read it all
just once, indeed. I'd be happy to revisit this later, if needed.

Let's see how v2 goes; sending it out.

Thanks!

-- 
Mauricio

