Return-Path: <linux-kernel+bounces-837765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D208BAD22C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC25419268EA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99992F7454;
	Tue, 30 Sep 2025 14:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KUCfnjlq"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B9D18A93F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759240980; cv=none; b=dZp+SQc4TVNZvVzEQemkS1DsvuQajm++lQgB1WPOW7UKr64fuj7lSFPkm/mzz3zDVrVzgjaYDJ2WCwiwEVOf4R4ZOW1cqlvCTk3Uv0g8P5GUCUK8F9xQGCRNDGQyfLWtdiTfz6K8fGiOaPJF86xUZueyNMZPR5AUxL2TsiNv4D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759240980; c=relaxed/simple;
	bh=hImG9Aug79IRyPKw7qzR2igYgWA5NDp2NJnsXWQxodY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVGN+zxZGjEYEY6U6nB8cIKk+geYVowtSbPNpk2BycjX/Hj+hut/cUMJCHSaHNdsAzLM2+ZI2CRAbLZyM9oLJiven0XIeMRzuGaaur51hl5m5/Il8K60jP6MLVSof6PvClQqnTgFr52iw04QRGf1M/uarb4I+2o/qtVMkqzT9rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KUCfnjlq; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61cc281171cso12195083a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759240976; x=1759845776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=db4oB+dnmVLJdBFQUKkZOAMclZ3E72AB5HReZPRQbFY=;
        b=KUCfnjlq0xLkffq97Sx/RNTQJfpaCBHmpbg0jcv5sAeHROdHRYQ8Kw1J0fNnOl13aV
         gzWmYn08DcWpnT8mGpgYe/VqTfxG6xG2THJ8ufEK089GJdTauG4sYMjIv9RWE/3q6PR7
         uIai2HimDh+QAQ4DGb6mSavFquClRT2dPB+t021NQX1jDB7akP0W3nFbWco+zbHe5AjE
         xO9JZqds196gqycXL14QpGgGxJUhXBT6JXP4UukGIefe/sn6giHLSIU7y5lH59QbqAAn
         rsPEMdLu0j2lAkuFdJN/fZENpPKF6UlaOjucIT/QlYirYWXtYJBksWWtys8nKBv4XAD3
         ssLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759240976; x=1759845776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=db4oB+dnmVLJdBFQUKkZOAMclZ3E72AB5HReZPRQbFY=;
        b=ANOmtDJjVOPFv4ACX8CvWvzc7nXm+nLtvhTxX90KnX3/BaymAb4JMs2p4KSu+6ctyu
         TXSvrDDaZVZ6VTlo1zruTlFmPs8MCB+TJm7E6vV2RE0+tbgT+S6YT+3sHnD3xMLwtiBJ
         eEG6nXcWxOWQZNuVXWo+pv9U2tj9oF7n4nvhjAnTRyr70jzguFEAWO7Vqrr+wSmqj5EU
         vlsrtYQPIWZF7EKfBApY0vWMxVM7A1V5MQpuDXFiON0m9eCrD8nkc5+wGtIYNPTSdiws
         TLc7annAhFec+c2FIYJfd3l3fLIrQhCJVMT+rrtx0YBBmD+hulxB359EWHww6Q+To/w0
         bNXg==
X-Forwarded-Encrypted: i=1; AJvYcCWBCGmafwpB05S15UJDBuq1QImQu+BCSZ6iT8FMXW0xfqf/3YlnJ0AnWkhtALD0aH3kzwNZiSQyoxx9EJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzolNd3Z12BdGYPVWBzVNWPDDLeBfbFi/AP853KWWnbH8D+PnT
	y+NJB6a9KBl+uH4Sd/hwkPcw6yRv6lW0s/uUQqL8IeAnK0Tmho1RVDm2sufMyTpQY7rj49S4JrZ
	Y4Npz
X-Gm-Gg: ASbGncu+/jKxl1y/hJ0DkqADWlYtiigSGnlB+kAQWXuLDKqamZPSGU+30gAvDA64UJZ
	xTlJdP3kKs1SWxsKyR8YRpUrCjVLsHChaB2qVW/VNlsA/EzCr3jQoJnc80mxITP35dqywR2csPu
	gXNhN1VOczBRAUacdaRqdUrpfIvaUobcZxW/N9eLr8CxZJ4efmy4rmx0+3blC6ZxjT3ID4zhBOX
	cw6UmcbI/8tjrYqe+YZgJQAKwA8xVmOrTJBlHp8og9yedvRdBK6pUZi8CMTI6ZxnxD0JekpMlp4
	w8w77OCgjSyvbi2sgJX15B5jyJutdOJEkIiuxY6EpXQ5LGjU9P+TOjLTHib0xymQ1rJpoVQJjgR
	noxkQx0V/yizO4tbXs480lthTJ1IN5cZXCPEVv1/YiRu+NBkGLvAzOwIxZOMQfhZBd4+cD3Y=
X-Google-Smtp-Source: AGHT+IEeAKRVJFWvUX+ebo0ADsGSIRuTxkgSHEm/uyOzRMG2ulX2Iq/k1vfZ2HZ/NayCWmtejwwsrg==
X-Received: by 2002:aa7:d9cd:0:b0:632:9110:c012 with SMTP id 4fb4d7f45d1cf-6349fa8a537mr14218078a12.25.1759240975900;
        Tue, 30 Sep 2025 07:02:55 -0700 (PDT)
Received: from localhost (109-81-95-234.rct.o2.cz. [109.81.95.234])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-634a365093asm9741048a12.18.2025.09.30.07.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 07:02:55 -0700 (PDT)
Date: Tue, 30 Sep 2025 16:02:54 +0200
From: Michal Hocko <mhocko@suse.com>
To: Mauricio Faria de Oliveira <mfo@igalia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Oscar Salvador <osalvador@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com
Subject: Re: [PATCH 0/3] mm/page_owner: add options 'print_handle' and
 'print_stack' for 'show_stacks'
Message-ID: <aNvjDsBuw3hqwy31@tiehlicka>
References: <20250924174023.261125-1-mfo@igalia.com>
 <aNVpFn9W0jYYr9vs@tiehlicka>
 <4c2a467113efd085530eb055e4a4e1fe@igalia.com>
 <aNY49sdoFVe03m_Y@tiehlicka>
 <d9af42d5cb9d427632087c5f51e50501@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9af42d5cb9d427632087c5f51e50501@igalia.com>

On Fri 26-09-25 13:47:15, Mauricio Faria de Oliveira wrote:
> On 2025-09-26 03:55, Michal Hocko wrote:
> > On Thu 25-09-25 16:38:46, Mauricio Faria de Oliveira wrote:
> >> On 2025-09-25 13:08, Michal Hocko wrote:
> > [...]
> >> > Could you elaborate some more on why the performance really matters here?
> >> 
> >> Sure.
> >> 
> >> One reason is optimizing data processing.
> >> 
> >> Currently, the step to obtain the key of a strack trace (e.g., hashing)
> >> incurs
> >> a considerable work (done for all stack traces, on every sample) that
> >> actually
> >> is duplicated work (the same result for each stack trace, on every
> >> sample).
> > 
> > OK, that was not really clear to me but the above seems to suggest that
> > by hashing you really mean hashing in the userspace when trying to
> > create a key so that you can watch memory consumption trends per stack
> > trace (hash in this case) without post processing.
> 
> Yes.
> 
> > Stating that more explicitly in the changelog along with an example on
> > how you are using this would be really helpful. 
> 
> Sure. Thanks for pointing that out, and making the effort to understand.
> 
> > When the interface was originally introduced the primary usecase was to
> > examine biggest memory consumers - e.g. when memory counters do not add
> > up to counters that track most common users (e.g. userspace memory, slab
> > caches etc.). In those case you need to see those stack traces as those
> > are giving you the most valuable information.
> > 
> > I can see you are coming from a different direction and you want to
> > collect data repeatedly and watch for trends rather than analyzing a
> > particular situation. This seems like a useful usecase in itself.
> 
> Precisely. I can make that more explicit in the changelog as well.
> 
> > My main question is whether this should squashed into the existing file
> > with a rather strange semantic of controling the file content depending
> > on a different file content. Instead, would it make more sense to add
> > two more files, one to display your requested key:value data and another
> > to resolve key -> stack trace?
> 
> I see your point. Either way works for me, honestly.
> Let me justify the current way, but it's certainly OK to change it, if
> that is preferred.
> 
> The use of option files has precedents in page_owner itself
> (count_threshould) and ftrace (/sys/kernel/debug/trace/options/*).
> 
> The use of output files needs more code/complexity for a similar result,
> AFAICT (I actually started it this way, but changed it to minimize
> changes). 
> The reason is debugfs_create_bool() is more specialized/simpler to
> handle than debugfs_create_file().
> 
> It ends up with a similar pattern in a common "__stack_print()" to avoid
> duplicate code (conditions on parameters to configure the output), and
> it adds:
> - 2 ops structs per file (file_operations and seq_operations, as in
> 'show_stacks'), for plumbing different behaviors down to different
> functions, to call the common function with different parameters.
> - It should be possible to reduce it with private fields (from
> debugfs_create_file(data) to seq_file.private), however, since
> seq_file.private is used (iterator in stack_start|next()), this needs
> more code: a new struct for the private field (to store the current
> iterator and add the new parameters).
> 
> So, I went for the (IMHO) simpler and smaller implementation with option
> files instead of output files.
> 
> Please let me know which way is preferred, and I'll send v2 with that
> (in addition to the changelog suggestions).

Sure, I see. The main problem with the option file is that it is
inherently suited for a single consumer which is a hard assumption to
make at this stage. So I think it is worth having a separate 2 files
which provide the missing functionality.

Thanks!
-- 
Michal Hocko
SUSE Labs

