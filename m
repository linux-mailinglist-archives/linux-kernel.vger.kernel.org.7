Return-Path: <linux-kernel+bounces-767470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCF0B254B4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E9541C2576D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C332ED179;
	Wed, 13 Aug 2025 20:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="GcbAgkr3"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C4B2E8DF8
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755118132; cv=none; b=pKVaU0Gkxwn3bVPfhak/yVPLn58+NkRbeG3ix2BFfXlISvdfgYXczYVIPwfZ2x9xKHDAcsN48+R5tEV1zWy22kUZgbxzI50xIV/TUrVXJoMPNfKXLoNGrZNcUre3BQyFgdWNLGHyU7Q9UwfZLlikr6hD0jaiS6pJSZ6uH7i2Rv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755118132; c=relaxed/simple;
	bh=ta264qR5AwXM4nebAmUF/1tK1KqaLemj9HpkV0LJA7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tx5cymMb1jUgfWObwAYbC7pAlk6mUxuh2qfS5YsXElATukovHetRUgnwrbW9V9+LKn/O3G7mU0Oo8jJo8eJjogxvo85ar7gg3CotXywRIkKFI9Yy4MUqkWqYubkByJzNeZet8jXSej/B0JqFKYS9hXCBBf1AwUXC6ciEyY6Apl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=GcbAgkr3; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e86faa158fso39766385a.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 13:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1755118128; x=1755722928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8QU7WwnnYzgxeH9QchqHrK0qbqQ+iKF1S/uY4NskNUc=;
        b=GcbAgkr3w+EYxHM9yafVWoplEcfUa16ZZr19ETalldBBR8QEpJZanqgZ/4gOiRnieD
         h3lu8Ot18VCrRLY6n0AQOlGRstJCDHAjcOB+QGVEBAzJdwZlFApQ8t9FDMojAW2vjSXj
         UvAY0CqLfSVhNoFwxhwrrLzQeFFR58VpF4VC9ldKr7lLhrSOefvnwlEwrpQT1ME35NYR
         mkT+XmsG6Y/wl6qXuSOl9zpkYC2iIaIhaB+yg9FpJ04shL337ivMr4vwK5POCljU2lKY
         ywBYq7zrbxQcwIJ/7C7W8U56Y6GeDmF9sg2ywwZK5FeN5YGoki7ws6b7qDwOsbmvpPtk
         zV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755118128; x=1755722928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QU7WwnnYzgxeH9QchqHrK0qbqQ+iKF1S/uY4NskNUc=;
        b=QUHLAoLvHSvhXseQ3PW0+UtW2wD+43GVxWbHpqaReu4R4deh2itnc3Ol00s4623LJ0
         FQMKO8QAcf294jNFKp4QAJOt0zRmO2Rd4bNnUfkcWEz1CmPXP5RPsm+TeTXXEb0Lq640
         k7Y3wdxcDAh09DO6lSARHcrQ9v4NhAAsYznfeKI7Euuf7dmysId2e8ueMW9A76QrNKKM
         tBu4T0DH/SUCVtK3G6igMKpGX28Hsa2+bBLfAzmOfIQuZUCmhePmGz5LcPygSB5A7HaY
         I9x1EmqrqQkVo2CcMtWURXf23XgFN8TCOZMk+u8irSAGkgWGex8Lml+R9pNQnaClwG1x
         R2Uw==
X-Forwarded-Encrypted: i=1; AJvYcCWUD5rgt36dd9oACmZAcXfbcFjvHP8EVKVnD51fmkMoaJ6TLvV8EDObf0SnT6gkjrPkqKe9wH5oPDKHawc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAc2J8t4ziNmsmHlJWUZk82QZa3OChBBGIej2JROggfEh541E8
	+w/tG5vA2LOQYNAiLUCRetn8/1m+VmRq0qlghv0gLGBnD8f82VGQ/eK8aDNf5fseMp8=
X-Gm-Gg: ASbGncvdMqGdKQhJvezcb41FTOHvikuxw17FW5nF2D1fI/w1uO0EFuH98qXsYRvTkvd
	H3KAnyZGF9JRSLCnzjIQB8oH2tF+SNnVeEpyu1HvSBC8aMAWH2NN7PY3vQbbDKd2nNfrUIyXU0z
	IuRGps1CZw5QR3DDUDlS7fpl1Yg+tg0wLN2PYpBfs92kTpMf/GTg5J5rfPBNDo5q1jVYg9FpjUH
	27Wvri+e29ZfujRDiEAE2aqxLs0Rm4kkFDasK5jJRLOk5NJKx0QZGjR2pvw7/cfpIQ7g3GQ08ll
	77YIR2Wwf32zubfrIsu25j4nSNJlI2MwB7aMHZyX2pWbpTvEZKlm1SDE7lAhjNH9Dq26Q27FXa6
	MGF4l72/9LlDiosBVVI8H++LEbmbmaEQH
X-Google-Smtp-Source: AGHT+IHz7GMMnYpZ4wiU0jk2n1e+DTQ8iUPbC7vlSKZF1R1r+EM0QvuCypZHUr0KQmfRxyjkSfm0bA==
X-Received: by 2002:a05:620a:a81c:b0:7e7:f2a2:251 with SMTP id af79cd13be357-7e8719ba2e8mr12990885a.27.1755118128568;
        Wed, 13 Aug 2025 13:48:48 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e85d4f5ff4sm372396285a.3.2025.08.13.13.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 13:48:47 -0700 (PDT)
Date: Wed, 13 Aug 2025 16:48:44 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Chris Li <chrisl@kernel.org>, SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	David Hildenbrand <david@redhat.com>, Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Takero Funaki <flintglass@gmail.com>,
	Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2] mm/zswap: store <PAGE_SIZE compression failed page
 as-is
Message-ID: <20250813204844.GC115258@cmpxchg.org>
References: <20250812170046.56468-1-sj@kernel.org>
 <CAF8kJuN1BH0rqC6czj9govNOugd_5K9ijYcxbWYpEpUdQKn0-A@mail.gmail.com>
 <uo6vtumoy4txklyqy4njitf5ex4eanudncicbbzknmuowopd7v@jm4ao4qapiza>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uo6vtumoy4txklyqy4njitf5ex4eanudncicbbzknmuowopd7v@jm4ao4qapiza>

On Wed, Aug 13, 2025 at 12:42:32PM -0700, Shakeel Butt wrote:
> On Wed, Aug 13, 2025 at 10:07:18AM -0700, Chris Li wrote:
> > 
> > If you store uncompressed data in the zpool, zpool has metadata
> > overhead, e.g. allocating the entry->handle for uncompressed pages.
> > If the page is not compressed, another idea is just skip the zpool,
> > store it as a page in the zswap entry as page. We can make a union of
> > entry->handle and entry->incompressble_page. If entry->length ==
> > PAGE_SIZE, use entry->incompressable_page as a page.
> 
> The main problem being solved here is to avoid the scenario where the
> incompressible pages are being rotated in LRUs and zswapped multiple
> times and wasting CPU on compressing incompressible pages. SJ's approach
> solves the issue but with some memory overhead (zswap entry). With your
> suggestion and to solve the mentioned issue, we will need to change some
> core parts of reclaim (__remove_mapping()), LRU handling (swap cache
> pages not in LRUs) and refault (putting such pages back in LRU and
> should it handle read and write faults differently). So, the cons of
> that approach is more complex code.

What Chris is proposing would also fix that, even for configurations
without writeback. So I'm not opposed to it.

However, for deployments where writeback *is* enabled, this code is an
improvement over the status quo. And it's not in conflict with a
broader fix for !writeback setups, so it's not an either-or scenario.

Specifically for the writeback case, the metadata overhead is not much
of a concern: we can just write back more zswap tail to make up for
it; the more important thing is that we can now do so in LRU order.

The premise being that writing an additional cold page from zswap to
disk to make room for a slightly inefficiently stored warm page is
better than rejecting and sending the *warm* page to disk instead.

So I agree with you Chris. But also think that's follow-up work for
somebody who cares about the !writeback case.

