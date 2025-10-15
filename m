Return-Path: <linux-kernel+bounces-853830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A04A6BDCB34
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59BD73E1030
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550AB3101C5;
	Wed, 15 Oct 2025 06:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W9wD8I0S"
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B378830F921
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760509291; cv=none; b=L3NGXsK8ANlWE+KimNvRe3iY0QWbaZTUEwT06VIBZchHI9eMqYGaB4dS1A8y7g1ts7wmxH+lVXWZ/rNwmOuJycLsoAWQZiXcIWbsMDdv8C2EFwHdmrDzIu9m/jLZM3C/faF9kWIttnHX0XtPg8agmdFb5y54UD5rU19hZthAyrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760509291; c=relaxed/simple;
	bh=K+PHF4WAM2ycA1aZTNdIhMu/j5k4OgimgvuS0a4OP2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvlOEKOGYiMZg+GFJc3glZ9RuNohxSV7QGNRgv7Swmnb+j7ngRzYE2zArgNGRLJaDuShuOfv1FKq8pZY80bfwQTs8qLkBTk7W46O4OZSYGYvamdFO5IUyBSrC3ank74eaCWueLIUzZGw4NBLABNB8CjVZwqwuN4qKapmuTh5GwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W9wD8I0S; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-46e52279279so43761685e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 23:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760509283; x=1761114083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L3PV9C1telyfCjlpsA7EV6fPruE8tbKt63BPSU3FM4M=;
        b=W9wD8I0SB6umE7UJDUWbEUUD7Yxa3gqCMXWiL0S2Mj2ES9vqkPGuvoMmbGbdntAAVQ
         9glktcDA1lkVhA/ZtjKipFsLFHpPNnWPoqON/3Hu5GPl5ayHt6Zx8Mg5tOQSY/CcVOhL
         JDfogEU+cXq411rjuEDJxyOmu1C6FPlKMuxG7Y1F+fdIBAo/6H1LJjiR0MJ562KvTCsS
         W9MNNIZM6iR2M+AvAfSiZWnowwzhOpXvfbsQFwv78P/r3gmY+ig5QO69ZWV7CkW0kkpN
         dHoMNr5Fom2lZyJBzyYI3hN8GAyERHl98i30SAfbbM2rCeeNrU58slSsKO2+sQhcXpGC
         OTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760509283; x=1761114083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3PV9C1telyfCjlpsA7EV6fPruE8tbKt63BPSU3FM4M=;
        b=NhWqNeX5eLLFDD7uk/DWZ4Uu2QHC2di+q2M0TeAOePu3sr388+Fr90eatjGUsoC0Z/
         5y7d7CLlDSip5Ghr/FnxcNMfPnfRIwSwOBZzek9jpQO7dRF7Vylba60VS92D2nHexZbu
         d11LgS9Lk7cg58ZqKjdSo7FKI9iTaayH485SPobjU5NrPx8qPF5qjSByE4s8v5n3ZdEp
         lUOz177tHpiY1x3UNiD/2/Dm6Z8uYBtOBo0BGLlLN/xgyeyj/djLJQFTZpgAmz/420HS
         L8Mrlnf3f922hetR6Ljy+wJpOjBBwvVR+QzIPdobYq3G7LzCETutY7zJBePVZlYMpeYD
         I2hg==
X-Forwarded-Encrypted: i=1; AJvYcCX48lO2qNCQMLffTbvJnU9v5Pld8RkteZ529jz+KWUjpgOnwwytu5IuguZ/MEbHAif5tEesSSDY/PXNnI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOPB2HT0sbC+rdj95wNBPwSxwINw3+MSz+XidOJXTUjfB8vp4k
	EkBQ5y68n1PBiLJDvmZhW4s9O4S8aJGwbyVjbBl+0pSJsP8bcvKNNKB2QuRGOA80+2o=
X-Gm-Gg: ASbGncspoNRnwYPdR5Ri1L07ZanJ3W/LZNavY0UD4x/W8F8c2LlUEZ/abir9wjCURAc
	5YzzQFI2BsUcJpxg1Qpg6UWVQSkPeKct4jp3sPGErnRJlYgwFYxxQzkQEEds/n5XJW6FsP06XIr
	tZmdPmauJ0EvKWsBt59eAkx/dhdNpCo0q9Z12l45FKSvyI2hWivpsiQAiIW8g9SNmIzygfBsm1o
	b7L9fNB/71wgh4kTXaHKKN6YTS/iNThuG5zdO9Q0eakGIbmtWly5cyejMgPm778XMVNLBZrjmlO
	UOJD79HiOWrOPW4A948+tJygblPcYsFDa0WU1HYbhsLigQFDROtuIxHnfCWkJcIMaDM3inf8cYL
	7yAwqhZmWc/j/1hyUGT69AfBMk81kCxayL2CkPQTn+lvKZRIza4AF/AWqJZp1IvQ=
X-Google-Smtp-Source: AGHT+IGxun/Yco6mevgEGwKjaOT0R/pW6Puo6dQ1aSXUtNSS99XdqPVFdMPH7X0OcIpuodI7EV7NzQ==
X-Received: by 2002:a05:600c:6383:b0:45d:d353:a491 with SMTP id 5b1f17b1804b1-46fa9a8c425mr178418635e9.1.1760509282825;
        Tue, 14 Oct 2025 23:21:22 -0700 (PDT)
Received: from localhost (109-81-16-57.rct.o2.cz. [109.81.16.57])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-426e50ef821sm12670523f8f.38.2025.10.14.23.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 23:21:22 -0700 (PDT)
Date: Wed, 15 Oct 2025 08:21:21 +0200
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, Barry Song <21cnbao@gmail.com>,
	netdev@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Huacai Zhou <zhouhuacai@oppo.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [RFC PATCH] mm: net: disable kswapd for high-order network
 buffer allocation
Message-ID: <aO89YYhEJ-GDPWFg@tiehlicka>
References: <20251013101636.69220-1-21cnbao@gmail.com>
 <927bcdf7-1283-4ddd-bd5e-d2e399b26f7d@suse.cz>
 <aO37Od0VxOGmWCjm@tiehlicka>
 <qztimgoebp5ecdmvvgro6sdsng6r7t3pnddg7ddlxagaom73ge@a5wta5ym7enu>
 <aO5o548uQAuBcw0P@tiehlicka>
 <itljl2e4rwbblmnhe2vucmsvxzbu42x5foszf4y5b63evbitpj@qsxj3amwhts3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <itljl2e4rwbblmnhe2vucmsvxzbu42x5foszf4y5b63evbitpj@qsxj3amwhts3>

On Tue 14-10-25 10:22:03, Shakeel Butt wrote:
> On Tue, Oct 14, 2025 at 05:14:47PM +0200, Michal Hocko wrote:
> > On Tue 14-10-25 07:27:06, Shakeel Butt wrote:
> > > On Tue, Oct 14, 2025 at 09:26:49AM +0200, Michal Hocko wrote:
> > > > On Mon 13-10-25 20:30:13, Vlastimil Babka wrote:
> > > > > On 10/13/25 12:16, Barry Song wrote:
> > > > > > From: Barry Song <v-songbaohua@oppo.com>
> > > > [...]
> > > > > I wonder if we should either:
> > > > > 
> > > > > 1) sacrifice a new __GFP flag specifically for "!allow_spin" case to
> > > > > determine it precisely.
> > > > 
> > > > As said in other reply I do not think this is a good fit for this
> > > > specific case as it is all or nothing approach. Soon enough we discover
> > > > that "no effort to reclaim/compact" hurts other usecases. So I do not
> > > > think we need a dedicated flag for this specific case. We need a way to
> > > > tell kswapd/kcompactd how much to try instead.
> > > 
> > > To me this new floag is to decouple two orthogonal requests i.e. no lock
> > > semantic and don't wakeup kswapd. At the moment the lack of kswapd gfp
> > > flag convey the semantics of no lock. This can lead to unintended usage
> > > of no lock semantics by users which for whatever reason don't want to
> > > wakeup kswapd.
> > 
> > I would argue that callers should have no business into saying whether
> > the MM should wake up kswapd or not. The flag name currently suggests
> > that but that is mostly for historic reasons. A random page allocator
> > user shouldn't really care about this low level detail, really.
> 
> I agree but unless we somehow enforce/warn for such cases, there will be
> users doing this. A simple grep shows kmsan is doing this. I worry there
> might be users who are manually setting up gfp flags for their
> allocations and not providing kswapd flag explicitly. Finding such cases
> with grep is not easy.

You are right but this is inherent problem of our gfp interface. It is
too late to have a defensive interface I am afraid.

-- 
Michal Hocko
SUSE Labs

