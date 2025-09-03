Return-Path: <linux-kernel+bounces-799218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03727B42891
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A183B686447
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7868C31B102;
	Wed,  3 Sep 2025 18:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rc1wyd6k"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF53299A8E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756923555; cv=none; b=faRUoo4HHhVclqhp1o+yO+1kSPmJ+hePfDJffUeYA53D2OPRMz3Iy+koD1rp4ANzQ6gtjTlonU8gpQTEO1iakPr+Pzm2CXVhZb6bmMZv++1OQUYoREk2vXqEt8fiawP/Nn+zLZJJ9WPfj7dHR187J7Y54pD6DbxMcvx3GZPy/Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756923555; c=relaxed/simple;
	bh=QYFhiu/ew0TmuDG8UwlSI6xs7QLDAOSXfKu00N6uQSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWJAPXjwCrVQ0q9ISJwv78IATKAmOSX8ssKG9X27Hff8mcIQBYJf05C4GYNXWEPydc1Y0XvXWO9ZATfdRDSbr/8GMWVHxYzLT3uWHFgzQEfDH2LhNMSHVhBgGf0liCqD0z+e59PtEeg/SmUGlTXQTJ/V0veEuz31yzs3NYwbN8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rc1wyd6k; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32b7d165dc6so93828a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 11:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756923553; x=1757528353; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ke0qcgAMsmvpnDPJypy8RuWNPArs8ss8xx0EE84J2oc=;
        b=Rc1wyd6kw8Q6HAxPSsWkhu5oqrsFhZ1vo+Rx2onjH7wcgwuoNoJL8bvL+2RUdQiOnN
         iOJ553TCSqUNEX+w96xGN6pEHfcEGlNetNkQ1IAH9+Nvn2IW1eqqXovWuXJRX+l+l0f5
         70tC0HLb/cPZkl+zewjCcyCGudFkovzRh9Lcpx8qCg20R0cp2mMEMewdEwshTLLNMFLi
         C1L+OHqGUxwjmd95QYBCf7B8CfBkEsUebeHzJPVg4PUBFpCXB/rMxG6/cfMXvg5typr3
         QfXeWi8aXrLhfxTVgVGl2k4Zwf4s3OuZgc7ZcwxQMLGW/Vgi3XeqjBugWrTaQNogazDe
         gWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756923553; x=1757528353;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ke0qcgAMsmvpnDPJypy8RuWNPArs8ss8xx0EE84J2oc=;
        b=JgMbccMzDNIbmx1oxISnvQKNqsJny4dGee0VsFkviXvyjjNEPQFO5f8vmCmeQ/w8X/
         yzCPjezj/i0rTgm8ool97tq09OWIsU0UH76capFBYyYw7qe+Ho39Ve2d73L4HdXkV3xE
         Pc9tXk6iW4Ox8BFSYenr8vbs0I3Aqk52PzOKJ3LvNB8fpjGzg/DP0XovaO3y9AlvWsUm
         aaGCJ1wIWXBba5cRm55jQnnCdCQA9QbIWELx/JPZ/J7uVAjSwgx3NQAdfgelM1UuUWLz
         NibS7CHF4mT0oXHKfl963rmqOhRVPfxW6eoTq91O1q8N5VlPHgrx0pRQNkHmfvYZCSnq
         Rl0w==
X-Forwarded-Encrypted: i=1; AJvYcCUf9XSg1JMlIwRFpyNmvVcRSN/IFGEUBeZi96ouR3nCWU/qOA/um3sWrLofW375zfkaBh0sD5q8LH1RS6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYkYjX83QtAmK8aMKlTVOfk+wokCWpjwn6JXTVk40XLwQIrexx
	d4KN/6ubi8bgVfdwPG4S6xxIJ0H4hFcSQdzQ4EiStbbpv/M+8gkiQQHg
X-Gm-Gg: ASbGncuqcMjYWtuGqwrmHvln/aIdBcuhf0xvRCs7HIigLIzylyrtaUbhZ27tDcfg4u7
	Vkn6jpjcFMZw9RyOdAr/imJLZgGZaqInNit0Flg4ZTLYx+yrHDzm+mTuiaYMcsi5F1WG+VU/OMH
	ydGB/fQsuXncwuxqURpbEqoMRKmzUnQCqKmWlRY7FpvshbOtLZ+KqSg5+E9Op4NzuIlRtW0+O5O
	W81eHQfMBpaBTNj3TfIaBoZYSTTlaXCHMMQDiF8akK0CXb+Pg6fnykDHCBDHbJBm3IDL7vn3tKM
	pcea3e3cK7x8obbvSw8iKrH5keXbzUiX+ntsHOM5Xu/WNC5er50aFBwAKWpmQsl9JckitLNr4Rr
	ej5wHBdccyUz0ycb//ccSCdpQEuXhjU9zhPGHDUR9QwraTI9B/tOTQw==
X-Google-Smtp-Source: AGHT+IHba2WCf4ULzfzT96OFbGRW5hX0jYX6go5DXCzBh5B4HyqF6qJTJeBbjky+6wZFkd4r/CCdiw==
X-Received: by 2002:a17:90b:3e8b:b0:329:d50e:2f10 with SMTP id 98e67ed59e1d1-329d51d739emr9569298a91.22.1756923552715;
        Wed, 03 Sep 2025 11:19:12 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd38610edsm14886181a12.54.2025.09.03.11.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 11:19:11 -0700 (PDT)
Date: Wed, 3 Sep 2025 11:19:09 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: tag kernel stack pages
Message-ID: <aLiGnSHFJdaTpMc-@fedora>
References: <20250820202029.1909925-1-vishal.moola@gmail.com>
 <ea48bc1f-7ee7-48b4-b389-c3622fc4d3d1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea48bc1f-7ee7-48b4-b389-c3622fc4d3d1@redhat.com>

On Wed, Sep 03, 2025 at 09:49:06AM +0200, David Hildenbrand wrote:
> [resending my original mail because it might have landed in the spam folder]

Ah, indeed the original mail was found in my spam folder. Thanks for
resending.

> On 20.08.25 22:20, Vishal Moola (Oracle) wrote:
> > Currently, we have no way to distinguish a kernel stack page from an
> > unidentified page. Being able to track this information can be
> > beneficial for optimizing kernel memory usage (i.e. analyzing
> > fragmentation, location etc.). Knowing a page is being used for a kernel
> > stack gives us more insight about pages that are certainly immovable and
> > important to kernel functionality.
> 
> It's a very niche use case. Anything that's not clearly a folio or a
> special movable_ops page is certainly immovable. So we can identify
> pretty reliable what's movable and what's not.
> 
> Happy to learn how you would want to use that knowledge to reduce
> fragmentation. 🙂
> 
> So this reads a bit hand-wavy.

My thoughts align with Matthew's response. If we decide "This doesn't add
enough value to merge it upstream" thats fine by me.

Otherwise if we think this is useful, I can respin this with your
suggestion below.

> But I wonder, if this should actually go to the actual place where we
> alloc/free.
> 
> Now that it's no longer required to clear page types when freeing,
> alloc_thread_stack_node() might be a better place to set it, and to
> leave it set until freed.

I think this would be a better place to implement it as well.

> I'll leave Willy whether we actually want this type, cannot spot it
> under [1], but if we have sufficient types available, why not.
> 
> BUT
> 
> staring at [1], we allocate from vmalloc, so I would assume that these
> will be vmalloc-typed pages in the future and we cannot change the type
> later.
> 
> 
> [1] https://kernelnewbies.org/MatthewWilcox/Memdescs
> 
> 
> -- 
> Cheers
> 
> David / dhildenb
> 

