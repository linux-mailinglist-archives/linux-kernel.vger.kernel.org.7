Return-Path: <linux-kernel+bounces-785237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A39D2B347F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636AB5E2074
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844053002B8;
	Mon, 25 Aug 2025 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p1aRF4yq"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4614F5E0
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 16:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756140668; cv=none; b=Rm97kCqWRvPwGmxZrsVrDN5rPQ7q/Ew5GbkML2z6FcE3iaskDO+KAbQkkqDTlbt6j5kZ936Evou/ueNWuLAeF4yub8U9NVv7C1gQxHRlLvzJwNZ5/tgyLSLcEJDs6GvKQsYO0ttkN8JtcsgMHT+g6z7cMxuISN+GxF3r69v2qQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756140668; c=relaxed/simple;
	bh=x21msmtWyWTJDJtku9n0CHY/y6HR6N6QTuaKC3bdjXw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vD7gqQsOWgktphW9dznvxRVND+gc1JLZHXhUoH4f3XIczAViwzLD7oKIDQ5LF7PDcwSFwL2fKRXFX+rGqUhfbiQQ+3ht+RuwyhDLcc0mIl6QHqwCjtGHm242n3+iQVxy1pNpq1xmEw2wj9J+7rfE9Nsrg/a39lKxfc/VfMfF1Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p1aRF4yq; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756140664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rqpQFZwVyd9daGv2BdVpF249HwPEKam6Daue11hrMLM=;
	b=p1aRF4yqOC/7j0VRFHM24pw3foU2tCnV9UQ7nVEdYrizM09lraTGVSjjxLlIc+plnHQ/RY
	Yx06LjtEI/KECO6X2vcoPrNsi4VyVrLjDYSnAoPaQcX2VLxsfV286mDR0o2tLpAO2KkRN0
	Mvr6xXXvwbUwBR22CFrD63CvEU4wtZ4=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Jan Kara <jack@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  "Matthew Wilcox (Oracle)"
 <willy@infradead.org>
Subject: Re: [PATCH] mm: readahead: improve mmap_miss heuristic for
 concurrent faults
In-Reply-To: <nbhyazac6tig3u753upst4brgmlo6qlwdntxdgwtfslpmmvp6h@gakfswzn3p75>
	(Jan Kara's message of "Mon, 25 Aug 2025 10:16:40 +0200")
References: <20250815183224.62007-1-roman.gushchin@linux.dev>
	<nbhyazac6tig3u753upst4brgmlo6qlwdntxdgwtfslpmmvp6h@gakfswzn3p75>
Date: Mon, 25 Aug 2025 09:50:58 -0700
Message-ID: <87cy8jz6od.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Jan Kara <jack@suse.cz> writes:

> On Fri 15-08-25 11:32:24, Roman Gushchin wrote:
>> If two or more threads of an application faulting on the same folio,
>> the mmap_miss counter can be decreased multiple times. It breaks the
>> mmap_miss heuristic and keeps the readahead enabled even under extreme
>> levels of memory pressure.
>> 
>> It happens often if file folios backing a multi-threaded application
>> are getting evicted and re-faulted.
>> 
>> Fix it by skipping decreasing mmap_miss if the folio is locked.
>> 
>> This change was evaluated on several hundred thousands hosts in Google's
>> production over a couple of weeks. The number of containers being
>> stuck in a vicious reclaim cycle for a long time was reduced several
>> fold (~10-20x), as well as the overall fleet-wide cpu time spent in
>> direct memory reclaim was meaningfully reduced. No regressions were
>> observed.
>> 
>> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
>> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
>> Cc: Jan Kara <jack@suse.cz>
>> Cc: linux-mm@kvack.org
>
> Looks good! Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>

Thank you!

