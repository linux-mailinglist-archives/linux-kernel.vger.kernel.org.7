Return-Path: <linux-kernel+bounces-851085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E86B9BD5774
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D12F74F513F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D217C2C08B0;
	Mon, 13 Oct 2025 17:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=airmail.cc header.i=@airmail.cc header.b="g3B465ij"
Received: from mail.cock.li (mail.cock.li [37.120.193.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2242C0296
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 17:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.193.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375963; cv=none; b=NcqX/zLafEMKfQ2XtCSMcgBlSvQLw34iS6KpUMvwrMwapQLklJCpk5mc8cleDPIYh7F4RuXNoUmtGuD83Ee8plWS6uPPg3ObeozsPgPOaxkRlR5z9u9NRt9dC/YNwf8aHsKj/yeKQwyvB27I6+LeR6vLaozHl4TFCxvGazvuvn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375963; c=relaxed/simple;
	bh=yBeX7+xYvuvL245QvTu3U+HIfEbuBqyLnMr+8/cVvxk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=NJEP9z8f/i4GnboM7MuppmDtgDF9jQFlaFnHDdd1xpygMp9KkHYN7dxPXLR7rhD+bU1zkVg0JBBgMccAJFd1GxWeeEesrgah/ilIviDb4KWkuqi1pRQOsQbL/CmhiPx7DEsGHR4ASxhSKOXpEkuFa0IUoU4JHiqG/A5UD3VGzMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airmail.cc; spf=pass smtp.mailfrom=airmail.cc; dkim=pass (2048-bit key) header.d=airmail.cc header.i=@airmail.cc header.b=g3B465ij; arc=none smtp.client-ip=37.120.193.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airmail.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airmail.cc
Message-ID: <34d27471-80a4-49f8-b6cb-f2e51518d9ea@airmail.cc>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=airmail.cc; s=mail;
	t=1760375395; bh=yBeX7+xYvuvL245QvTu3U+HIfEbuBqyLnMr+8/cVvxk=;
	h=Date:To:Cc:References:Subject:Reply-To:From:In-Reply-To:From;
	b=g3B465ijR/cbeWZIBKYaqD+buxy0DTQLyaYNl8Iw2jlHUJNFlVqlQVfIqERoQRNXJ
	 yKPYAde0G9V6kGp3WlU95NdWUmSIoOWPXvlht8nv2L+yjm5qVvh7BSeysMI5csjpxe
	 dByXL9Hva+xWq2zHY8+qRzKlX1mE2bllI+f+pgyuMTpsKE0l+eT4xZGhzw+vWllVbm
	 W+00nA9ljWFR50RmiwEg1Gf8DjG0y9CvGxuS2qDj5kDb1YyMQo3GHOvuQPDWwCkMmU
	 PGCVqRfaNwpPE9MCJrCV6sA8nd2/cypjC2DueycZuZGv01gL9svbYcBjxXe1Ml3D/u
	 idUB8ADhuoG8g==
Date: Mon, 13 Oct 2025 17:09:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: david@redhat.com
Cc: akpm@linux-foundation.org, chengming.zhou@linux.dev,
 craftfever@murena.io, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 regressions@lists.linux.dev, xu.xin16@zte.com.cn
References: <423de7a3-1c62-4e72-8e79-19a6413e420c@redhat.com>
Subject: Re: [Regerssion] [KSM] KSM CPU overhead in 6.16+ kernel compared to
 <=6.15 versions ("folio_walk_start" kernel object overhead)
Reply-To: 423de7a3-1c62-4e72-8e79-19a6413e420c@redhat.com
From: craftfever <craftfever@airmail.cc>
In-Reply-To: <423de7a3-1c62-4e72-8e79-19a6413e420c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

 > Looking again, no, that's not the case. We do a cond_resched() after 
every page we looked up.
 >
 > Also, b1d3e9bbccb4 was introduced in v6.12 already. Regarding 
folio_walk_start(), also nothing major changed ever since v6.12.
 >
 > Looking at scan_get_next_rmap_item(). I guess we might hold the mmap 
lock for quite a long time (if we're iterating large areas where there 
are no suitable pages mapped -- very large sparse areas).
 >
 > That would explain why we end up calling folio_walk_start() that 
frequently.
 >
 > But nothing really changed in that regard lately in KSM code.
 >
 > What we probably should be doing, is give up the mmap lock after 
scanning a certain size. Or better, switch to per-VMA locks if possible.
 >
 > Also, looking up each address is highly inefficient if we end up having
 > large empty areas. A range-walk function would be much better suited 
for that, so we can just jump over holes completely.
 >
 > But anyhow, nothing seems to have changed ever since 6.15 AFAIKT, so 
I'm not really sure what's going on here. Likely it's unrelated to KSM 
changes.
 >
 > -- Cheers
 >
 > David / dhildenb
 >

I have to make a correction, folio_start_walk is present in "perf top" 
statistics on 6.12-6.15, it just consumes 0.5-1% of kernel time compared 
to 11-14% on 6.16+, where it causes ksmd 100% cpu usage compared <=6.15 
kernels. I understand, that something changed in linked function, that 
affecting KSM behavior. Maybe, you can reproduce it with same settings, 
especially it happens with Chromium apps, there is V8 sandbox with huge 
VM size. Maybe, you could reproduce the problem with the same 
MemoryKSM=yes in user@.service, that sets KSM processing for all user 
processes, especially, when Chromium is running. KSM CPU usage really 
differs between 6.12-6.15 and 6.16+. Maybe, it's related to your 
explanation. Thank you.

