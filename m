Return-Path: <linux-kernel+bounces-844955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F67BC324B
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 04:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AB2A3C6EF4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 02:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC79229ACC5;
	Wed,  8 Oct 2025 02:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iK+v+Ryg"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47768296BD6
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 02:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759889267; cv=none; b=fltXZCJegRMds/f1FT6xx4XNxg768tBxdeDnvhHvBkI6D5RJj9GWO5JLe0SyLjOSKktYtqDgCjaY4Kn428hlFTtRslDfSukpGn4Strzxph15fT5eNR9C3X69tb6B/AnNOfnLRuELoTuuTfgM8aZkKA9i8RYeqPulrAPGOtj4Zmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759889267; c=relaxed/simple;
	bh=jYd48FCslT8evndw80GHjjsg/fp3Yn4kfLmlemTdycY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=seqsIZBOb76Or4kKKK5opjh0z07615HcEuf+tuIQiPomiBELhQIhhTpxP6m2tWoJUWE3nUVliDUIZba5Peuo+tAVGgMW7+vWJipPk0wUrjqb2fKA+2rLmzic/c//v4G3grlGMn3SzuPsD2qQ9eCgh67n1kL7372YqDFmGkV/iXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iK+v+Ryg; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759889261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HcPmPhUz1c0vqDGf/BJJjPlQYYOjd9QFCOfmGvu2dws=;
	b=iK+v+RygeTMZeXcVkOCn1vhtTEahSVmwSjRGVt0bfdG7/2y20M9tDnQb7Yt9aiZcZAhODk
	Amo7BEuRGY8OSiRi/6WdXsWEpjwtocI/nnkYPeYMy8OKc+IWRNdoyvV3cSftItvQgeCG9Z
	feLWm8udWPWo1H90xp22KmHSU0kc1fM=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,  "Matthew Wilcox (Oracle)"
 <willy@infradead.org>,  Jan Kara <jack@suse.cz>,  Dev Jain
 <dev.jain@arm.com>,  linux-mm@kvack.org
Subject: Re: [PATCH v3] mm: readahead: make thp readahead conditional to
 mmap_miss logic
In-Reply-To: <20251007175343.107b17191734cddd7bbdeb54@linux-foundation.org>
	(Andrew Morton's message of "Tue, 7 Oct 2025 17:53:43 -0700")
References: <20251006175106.377411-1-roman.gushchin@linux.dev>
	<20251007153424.1b46a4018e17d5dafd7fb126@linux-foundation.org>
	<87play1fzy.fsf@linux.dev>
	<20251007175343.107b17191734cddd7bbdeb54@linux-foundation.org>
Date: Tue, 07 Oct 2025 19:07:36 -0700
Message-ID: <875xcqi1sn.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Andrew Morton <akpm@linux-foundation.org> writes:

> On Tue, 07 Oct 2025 15:52:49 -0700 Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
>> >> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
>> >> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
>> >> Cc: Jan Kara <jack@suse.cz>
>> >> Cc: Dev Jain <dev.jain@arm.com>
>> >
>> > But I'll slap the Fixes: in there, it might help someone.
>> 
>> I'd do exactly what you suggested: Fixes + no stable backport.
>> 
>> But I guess it still might end up in the LTS tree thanks to
>> the automation picking up all fixes. Should be ok too.
>
> They've been asked not to override the MM developers' decisions (ie, mm
> is special).
>
> I'm not sure how reliable this is...  And I'm not sure how they
> identify the dont-do-that patches.  Maybe mm/*, maybe mm.git, maybe
> s-o-b:akpm.  But I haven't seen any transgressions in a year or three.

Nice! I didn't know this.

