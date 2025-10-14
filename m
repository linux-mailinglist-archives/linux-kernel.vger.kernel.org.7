Return-Path: <linux-kernel+bounces-851988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E982BD7E09
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 220B24239D0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF0E30E0DB;
	Tue, 14 Oct 2025 07:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RMo/1SDz"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF5230DECC
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760426816; cv=none; b=ciJaufy7aL/XqkRbifSv6cOLUYe3r0Og6oz4tMovj+L/JrFKZEtNR5io6jFwg7Fk9pW/2XKIwA1DuYHF+SfVlycw0qc9pBm9/I83IDOfjGHAz6muqAqC+crP7KFyI/6FdDTkf66h89+6mptIkJ64DmpXNI+JOPAklE7Kb+k4ZvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760426816; c=relaxed/simple;
	bh=69j+nJDGYxV0SqldgYPw5p2967aw/hJq9L3JovCxY0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gn2uEP1PTZLi5Ec3ZmL/j/BwP+uyMMTLUo4hPaXo0525eb/B5azNZOB9uVHrM3PSHRLyloD0C/kxRP+wEE6G98QzX2dmEsRq8C5sIuJzFB9DdWghpkeWKOqQFz3RTzEDR0ohiri98jCh5MADB7xxLEuqrpdV6UYRLi4g0LgVuXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RMo/1SDz; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ee15505cdeso4166030f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760426810; x=1761031610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1p4OZlxOY+NxPP/FLfk1SUzbR8cdY55J35+/tdhphko=;
        b=RMo/1SDzLvQCfVz1ubtkj+ohMe7hxvHOkxQK6nAyb6COgPjkD+YNqx9dM03dUwjTkU
         yx28ueUbmimBbnQvk8WrrQlIOA5Xqyyf2+A864An/mwCHN5ZLcSpw5BEbQQi9Czyd5gf
         1Tk3vzIdIswd+R4zM+EWeQnGpw92IXFZs0qgyWF6ypEAJYTTAB8zdOGffBYFEPgKhmvV
         LTlcAM7Mc1IHjS6uwMUd64V6H06feAgvT6mmqdoU9paF++Ue3FGdgZdTPayi9dR7GHrk
         7YJlVSxmDx+MQT7N8UA1ArcoSCqtljlRoEr9WURCfpvb1d0LSmoXdryjqeyNjhrE4nUx
         sxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760426810; x=1761031610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1p4OZlxOY+NxPP/FLfk1SUzbR8cdY55J35+/tdhphko=;
        b=wz2C8GdxqPqeEL0KlrBSBLjjf3UnCVx6JtEYOcIG7g8avHigN+sUljZaar8Y58O+kS
         NGpKdjDRbHAfQsFwlJp1j4QFn1cmnBA1Ah9DCdRF4tGyKOEyphWvsfCURP0jsSCOi92t
         6sGIJJ5+a8MkKCgny+5aNxftMl5fuCtniU/8BtFdbpDbS1sH/ZoD24WGHwCuR16JSu6A
         U9Ao1Y427fNSV7Wks+RSONrXgfy+CZkQy9noZbZnzaZEMBGD+cEWvM/6Pd17JLIhEiUe
         sxyiojj6PvKctjVdIlylAEwNF0HhVqwF3G242qMp3l/zk/MZ4V1FXgAc7BESNTxMSlmT
         7oTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMmR0y6EAzzebl3JqCYwok/J6Lmr8eF5tLpV9PXIB84k60nHglj8YpfvUlvY5n5YvunVlPmH/AqRjQQmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD8vQ+UPWp6R+7JIPxB+odlcOjgC92ekLlq2aF7/VekLJZs3U/
	gzQZi2wDAWep1OoqmFB5cZzjirGIefONAWTLw+Rkf3xxh6xCa64+kRAYqLT1YoHH1UQ=
X-Gm-Gg: ASbGnctZ+SFF/zcFwGr1lMKV2Zhm9k6WPee9Iro8Af4U+cngWXamNRAulaWyAqs48bX
	lKp4JptYcK9f7ufeaA7WwrKlR8q2B0ySCeUy2hF0jrvJEpS7t5I9yl1n/Uajgm9cqUnpwscnrZV
	vZgc/w3H9lpXksAGHm7fn1L/V1N/38kt1XxN/6FOIModBryCh6y2zE3Ofk3ek5+vJyKROhS8VJg
	bTy/1MrQ17YSWHq9MHz2CkEvJrQquzmjYkIuaNGpW8fG5XTpX9pJUKtRvTk/XDnbCRNLasUSURo
	uiYscezOMxskuItvEuoRzT/ggY7E+mr3zp9Vy0nhoZ2f32876CCUUrBtr+zy0BYxtHEXGppOYQr
	vJztDMkj4gCVM3jEa4dhB2atgwbNZNTFCIMFLjnCCuAtkXn5nYPblq4D7rYjHdbwLYFuj4EyrvA
	==
X-Google-Smtp-Source: AGHT+IG56u1B06cKrDgh7gziHnjqzu34szt4cpp5w6eBKrKwAL5+ACYASwYe1mymtdVAayUoB54vVg==
X-Received: by 2002:a05:6000:288f:b0:425:58d0:483a with SMTP id ffacd0b85a97d-425829a5a12mr19773929f8f.3.1760426810474;
        Tue, 14 Oct 2025 00:26:50 -0700 (PDT)
Received: from localhost (109-81-16-57.rct.o2.cz. [109.81.16.57])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46fb55ac08dsm217399135e9.13.2025.10.14.00.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 00:26:50 -0700 (PDT)
Date: Tue, 14 Oct 2025 09:26:49 +0200
From: Michal Hocko <mhocko@suse.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Barry Song <21cnbao@gmail.com>, netdev@vger.kernel.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
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
Message-ID: <aO37Od0VxOGmWCjm@tiehlicka>
References: <20251013101636.69220-1-21cnbao@gmail.com>
 <927bcdf7-1283-4ddd-bd5e-d2e399b26f7d@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <927bcdf7-1283-4ddd-bd5e-d2e399b26f7d@suse.cz>

On Mon 13-10-25 20:30:13, Vlastimil Babka wrote:
> On 10/13/25 12:16, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
[...]
> I wonder if we should either:
> 
> 1) sacrifice a new __GFP flag specifically for "!allow_spin" case to
> determine it precisely.

As said in other reply I do not think this is a good fit for this
specific case as it is all or nothing approach. Soon enough we discover
that "no effort to reclaim/compact" hurts other usecases. So I do not
think we need a dedicated flag for this specific case. We need a way to
tell kswapd/kcompactd how much to try instead.
-- 
Michal Hocko
SUSE Labs

