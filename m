Return-Path: <linux-kernel+bounces-727958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 391B0B021C4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 058E1B4573F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106DC2EF2B8;
	Fri, 11 Jul 2025 16:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b2kH2iyn"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD0D2ED161
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251378; cv=none; b=nUmUl9mhhbcMzhlpa9BDEfA1Ynpren5+GRfJrCuEgtT/ec+Zw+nd72IrXwK+zSTvJ4eURfX0ySJdTZHcEp0lPDCuSffeBsLLzQ4lfSRlA2W7FbwoUV0XdF3JR+lRpuEc0otk+WkK46teEzJwyxsbT5y7G3TheYSCVI1oshBJJ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251378; c=relaxed/simple;
	bh=aZH1xiaromS+i12xH9TFJCnMhRtsOTSRAhpwtTQZvmU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q6/S9P4GPI+WVPsRzMKVyi2QrPM9qBvrQO/5SmOSkx4ILc8aYdAU3l8gvp5ilO7/U7zvVP89HUL0Pf+F7Gwrkh3f9Vj5/HR64E3USKuaHU9z+Sa5h+kObkTAycOhQD72F+cV3jyn10CmSvcAch7+aGQUYxl091RAfRGXdN0arig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b2kH2iyn; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752251370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WhuGDLFC4gRIGmhrJvIxGirWHjMh71q+8beAXtBUQOo=;
	b=b2kH2iynvNunCAs/PZJqW0pEp3JTTlV0Aageh0UBokaogIboKSCl8x0RRjWuij7ZJsTfT+
	z3K+V7iGnMwCR6rysOxgBDilxxHoOjy4QEatVzaplfoja57Yxsjl3D5u3tI7xrY+DOAGWd
	LqXZP8waRIrPYNznRv+/WYHheRybywM=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Jan Kara <jack@suse.cz>,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,  Liu Shixin
 <liushixin2@huawei.com>
Subject: Re: [PATCH] mm: consider disabling readahead if there are signs of
 thrashing
In-Reply-To: <aHA0GBVJmAt-WS2j@casper.infradead.org> (Matthew Wilcox's message
	of "Thu, 10 Jul 2025 22:43:52 +0100")
References: <20250710195232.124790-1-roman.gushchin@linux.dev>
	<aHA0GBVJmAt-WS2j@casper.infradead.org>
Date: Fri, 11 Jul 2025 09:29:25 -0700
Message-ID: <87ikjywv16.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Matthew Wilcox <willy@infradead.org> writes:

> On Thu, Jul 10, 2025 at 12:52:32PM -0700, Roman Gushchin wrote:
>> We've noticed in production that under a very heavy memory pressure
>> the readahead behavior becomes unstable causing spikes in memory
>> pressure and CPU contention on zone locks.
>> 
>> The current mmap_miss heuristics considers minor pagefaults as a
>> good reason to decrease mmap_miss and conditionally start async
>> readahead. This creates a vicious cycle: asynchronous readahead
>> loads more pages, which in turn causes more minor pagefaults.
>
> Is the correct response to turn off faultaround, or would we be better
> off scaling it down (eg as low as 64k)?

I think at this point it better to turn it off entirely.

For scaling I wonder if we want to scale it depending on PSI numbers?

>
> I like the signal you're using; I think that makes a lot of sense.

Thanks!

