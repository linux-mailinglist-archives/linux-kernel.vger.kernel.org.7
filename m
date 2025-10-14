Return-Path: <linux-kernel+bounces-852954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D1FBDA537
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E3DB7505CC9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C775C3002D1;
	Tue, 14 Oct 2025 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZeXvKawD"
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F172FF65C
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454892; cv=none; b=Os31b/sjDg9keunfbcTC8cZfG9n39+9iGt082ZQC/dbJQatHsquW85McpHWRiAMQ3m1CerefqBDADSz+Z1y0zq7uFbe+M0kdGpekk3uvwlBJ8qPRHEd1zLP/KToyA9hdqy2qEQNydUiVRW5jBbXp7CxCfpFq2JZ4++PMrituQZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454892; c=relaxed/simple;
	bh=PhjtL3HD6534h9vTcz70HRQ4Ghvd6KaR4lsu8s+WwWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBmm9Hcttu/urXfJCsj1Hp1/7C5U4JbarKzhHHbqNDxdhUhk8bY2KmOistX6p9BqDG2KRYOmgAADkwUbENNCKI0p17EwfjVTi2PjGlOiXqDZieaAtH/mpv9GN1p0Vjgghw1K8KAL7BV1zXsWQNYZZtkNouqkGWohSVhtgaOsf1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZeXvKawD; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-46e37d6c21eso30840825e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760454888; x=1761059688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xQLfTHNnTKNjH+34TPL7Pi8OhXbeEQ0J4cWXx6jAeow=;
        b=ZeXvKawD1Tj/ucKm6ywTes/XRey9q5W9b146tXZlHWh3i8RMXKREAE6WQzD3JMbrLv
         CmBEKfgGnIVFQRYN8Tq06YaKVtZNvRqozEkPbW6FPKWZ3pLVOP9s7IjfSThQ9iT4Si4J
         fN+VbPJGoJgrhJyZDurPKz0AG+ol5cCNS0mnPqesXsN6Kz12exiOX1ugKLfQvppybecy
         gXfYKnP75sQnm5M+2s+ZzDbpAuHPkG1/d3Y06xPnonQr29FSN367krqdWuS4Uiu3lWsp
         LzNzdoKzaq4wrM5EQ3wEjflxJ7WLZqfUvTEGsDKuwvj2crreP0qgWzyaxm7arXLFgW3N
         nCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760454888; x=1761059688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQLfTHNnTKNjH+34TPL7Pi8OhXbeEQ0J4cWXx6jAeow=;
        b=LAE6M93VwZcNpv36XS2dyEhX8oP9RIz3/V3CLC5N5Up1Sj5itOYpFxr2/RlMEiXbWk
         A5SB63UWnmrACybjSyJXrPfXYSJRuQK8ZSeOGh1623sCVGxFWMsve66CSjVSCvWRBvSW
         1/HqRYRXpEOp5Sl4UC1U3K+7REDG1XlVpEb9KOY5dauckRMKCbjxzNpB1q5LuFUKw0vo
         slMj8Yv2uKfbxqd1ivCYyQ8VMjsyBWTclJ3XWs4RpouxvUsDXy9/CLRXrBNAJVS6YkM6
         o2yC8z+fiyBlGZGqPDKQKYRBSoxRqjYoLVpVMwRBy1Xwgfcm+Xkp3CEBqZ5JjXbNlQ9K
         6ZMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUje/A6ORbKrFYPL90HktgHBtwWy8PTgdR5JqLpU7UO3kfsgmapai0x924CW8QPqyzYwTyy9PgGFjF11Pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWiQaUfibrok86tqJQXLEV9F7Nq2mWO5Yt1GkheLM0Bwm2s3wf
	pV0vvzn+MQrQMMWOcHGnhmWArSQY0SKiXUz/Q7+bgRsCVwVGvYlRgwIu8Pl6uTt99Ss=
X-Gm-Gg: ASbGncto6srFMitZ/uhjKa2OYoPQr0pkiCP2hAMD0wjHiWo1Xa1j92mB4cueXu916L3
	QXiAoC5pyQjXpIDnuiIoNFbDRgvEZlxPUnE8LCzAxxYo7vqnBFB3B8RgoweLjbpLPhSblE0F6WU
	wSgbeOWCvOQAc6uIyNZ7cb7s+M2rVofWZc2LfKe3eSylwsjLknjlvMHESGaLE9vBwK9j+kqfPGY
	dAW0Xd6BrBswbJLiGMVmgvXXo5liQZ3g+IaVaUKFyQRM0P1kNN/JmhVF1M7kjjXY/kzYD5axZvv
	4ITisNVIJe59NmC8Eaj1M/HlTctr9bmVc41wVjSlqrJrOkECAVKKpdOxWabwAGeIIpvAaU8ArBj
	YYn0peOZ4E94sQ2PAaQ2sfXRiFX3D/q/nwmP8rI3lYz9sa6pHWF0Lt1xwWHJcVPSPM/4cuiF1/g
	==
X-Google-Smtp-Source: AGHT+IFTHGjFphXZexQjbUWRV0zNN1oAawyBZFjG8j79GJAZYI0e5RFLHEUzsaTaFKvHfVpvOLq1+w==
X-Received: by 2002:a05:600c:6818:b0:46e:36fa:6b40 with SMTP id 5b1f17b1804b1-46fa9af915emr172798525e9.24.1760454888343;
        Tue, 14 Oct 2025 08:14:48 -0700 (PDT)
Received: from localhost (109-81-16-57.rct.o2.cz. [109.81.16.57])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46fab500706sm157838725e9.3.2025.10.14.08.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:14:47 -0700 (PDT)
Date: Tue, 14 Oct 2025 17:14:47 +0200
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
Message-ID: <aO5o548uQAuBcw0P@tiehlicka>
References: <20251013101636.69220-1-21cnbao@gmail.com>
 <927bcdf7-1283-4ddd-bd5e-d2e399b26f7d@suse.cz>
 <aO37Od0VxOGmWCjm@tiehlicka>
 <qztimgoebp5ecdmvvgro6sdsng6r7t3pnddg7ddlxagaom73ge@a5wta5ym7enu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qztimgoebp5ecdmvvgro6sdsng6r7t3pnddg7ddlxagaom73ge@a5wta5ym7enu>

On Tue 14-10-25 07:27:06, Shakeel Butt wrote:
> On Tue, Oct 14, 2025 at 09:26:49AM +0200, Michal Hocko wrote:
> > On Mon 13-10-25 20:30:13, Vlastimil Babka wrote:
> > > On 10/13/25 12:16, Barry Song wrote:
> > > > From: Barry Song <v-songbaohua@oppo.com>
> > [...]
> > > I wonder if we should either:
> > > 
> > > 1) sacrifice a new __GFP flag specifically for "!allow_spin" case to
> > > determine it precisely.
> > 
> > As said in other reply I do not think this is a good fit for this
> > specific case as it is all or nothing approach. Soon enough we discover
> > that "no effort to reclaim/compact" hurts other usecases. So I do not
> > think we need a dedicated flag for this specific case. We need a way to
> > tell kswapd/kcompactd how much to try instead.
> 
> To me this new floag is to decouple two orthogonal requests i.e. no lock
> semantic and don't wakeup kswapd. At the moment the lack of kswapd gfp
> flag convey the semantics of no lock. This can lead to unintended usage
> of no lock semantics by users which for whatever reason don't want to
> wakeup kswapd.

I would argue that callers should have no business into saying whether
the MM should wake up kswapd or not. The flag name currently suggests
that but that is mostly for historic reasons. A random page allocator
user shouldn't really care about this low level detail, really.
-- 
Michal Hocko
SUSE Labs

