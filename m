Return-Path: <linux-kernel+bounces-833107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CE3BA13BE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7BBB188DA4E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CC231D721;
	Thu, 25 Sep 2025 19:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="MB6FHwY4"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4385E31BCAA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 19:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758829143; cv=none; b=A48fi7fZnoWX/XSEujbbEb4oT2c+kHy8OjdITG5o/m+5p+49elkHQuBWiYyaF8r6zMLUq6gN/2gOtRr9tCX7Vf0bQ/j6AJpTQu0Ns9eXdGHi2rgE6q8cf4dxUi63fBRjLkHy3IXGtVzft7f9od136MdeX3wb0Vsiu7Jhu3IMR2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758829143; c=relaxed/simple;
	bh=2QdIpLT/qFFnsDRFxB6Vnf6qCcJvWKZEl43z/88zefU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=h3YGlEgZ+DCPPef/Om3sDi5dCpCQ6LatFU95+Wem4a1GpDFOJg7MjqiB9a0HPqVW9MPvrJ3L80Tzrj0eelUIRcrDciqNTdZ+dFx6mV6oBX8C+g3YvTRtGuxojf3Z+QyR5vb0Vx3uNFVd/lddiLKMFIPLEjvXkOLJQ9H5c0c3BdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=MB6FHwY4; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
	In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=75E1Q5XfZ4Bfg2w2EoM2j48gcNpE/T3wRma7TEvZTJE=; b=MB6FHwY4LDBtbxBXqasNGKvKmb
	S/OHSszJAWTRT0GHLUTxTYu0nt271jQEUCIbnfuVQPz2NHc08vzEq/kOfVsyZcmda6wFRS8CNXnMn
	uyvWgj0flV3U7LjTvvWPHxidi8WOos0kKym6b2vG/lmEnwb2C5DNRC/drFq0cHwMeLGsHjQ9EtEpF
	1LcntmscQGblOBfN/Feu2kxsbohB4QB0dUhUUZyFqscXDBo/5lJiSkjEUjdQVGLtxdCIMEPl8diu1
	yn8s7IEaBmOvakBloYUqIFhdbdeaOVXNni/kdUYmkolP6O38wbl7UUyxpCDxXp7NgM9S0eszLMjkf
	Y/0YuR3Q==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v1rnk-000GyL-KV; Thu, 25 Sep 2025 21:38:48 +0200
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1v1rni-00EDOR-G8; Thu, 25 Sep 2025 21:38:48 +0200
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail with esmtp (Exim 4.96)
	(envelope-from <mfo@igalia.com>)
	id 1v1rnh-00BmjL-2w;
	Thu, 25 Sep 2025 21:38:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 25 Sep 2025 16:38:46 -0300
From: Mauricio Faria de Oliveira <mfo@igalia.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka
 <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, Suren Baghdasaryan
 <surenb@google.com>, Brendan Jackman <jackmanb@google.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH 0/3] mm/page_owner: add options 'print_handle' and
 'print_stack' for 'show_stacks'
In-Reply-To: <aNVpFn9W0jYYr9vs@tiehlicka>
References: <20250924174023.261125-1-mfo@igalia.com>
 <aNVpFn9W0jYYr9vs@tiehlicka>
Message-ID: <4c2a467113efd085530eb055e4a4e1fe@igalia.com>
X-Sender: mfo@igalia.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Report: NO, Score=-2.2, Tests=ALL_TRUSTED=-3,BAYES_50=0.8
X-Spam-Score: -21
X-Spam-Bar: --

On 2025-09-25 13:08, Michal Hocko wrote:
> On Wed 24-09-25 14:40:20, Mauricio Faria de Oliveira wrote:
>> Problem:
>> 
>> The use case of monitoring the memory usage per stack trace (or tracking
>> a particular stack trace) requires uniquely identifying each stack trace.
>> 
>> This has to be done for every stack trace on every sample of monitoring,
>> even if tracking only one stack trace (to identify it among all others).
>> 
>> Therefore, an approach like, for example, hashing the stack traces from
>> 'show_stacks' for calculating unique identifiers can become expensive.
>> 
>> Solution:
>> 
>> Fortunately, the kernel can provide a unique identifier for stack traces
>> in page_owner, which is the handle number in stackdepot.
>> 
>> Additionally, with that information, the stack traces themselves are not
>> needed until the time when the memory usage should be associated with a
>> stack trace (say, to look at a few top consumers), using handle numbers.
>> 
>> This eliminates hashing and reduces filtering related to stack traces in
>> userspace, and reduces text emitted/copied by the kernel.
> 
> Let's see if I understand this correctly. You are suggesting trimming
> down the output to effectivelly key, value pair and only resolve the key
> once per debugging session because keys do not change and you do not
> need the full stack traces that maps to the key. Correct?

Yes, exactly.

> Could you elaborate some more on why the performance really matters here?

Sure.

One reason is optimizing data processing.

Currently, the step to obtain the key of a strack trace (e.g., hashing)
incurs
a considerable work (done for all stack traces, on every sample) that
actually
is duplicated work (the same result for each stack trace, on every
sample).

That calculation is a significant overhead compared to the operation
it's done
for, which is '(calculated) key = memory usage'.

Thus, optimizing that step to just reading the key from the kernel would
save
resources (processing) and time (e.g., waiting for results to be ready,
on post
processing; or reducing the time required per sample, on live
monitoring).

Another reason is optimizing data collection.

There is some overhead in periodically waking-up, reading and storing
data, and
later in filtering it. (Admittedly, much less significant than the
above.)

However, despite being a minor improvement, it actually prevents the
production
of data that is discarded at consumption; that helps both producer and
consumer.

The cumulative improvement may be interesting over very long profiling
sessions.

Hope this addresses your question. Happy to provide more context or
details.

Thanks,

-- 
Mauricio

