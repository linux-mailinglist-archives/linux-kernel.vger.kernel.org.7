Return-Path: <linux-kernel+bounces-853256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE94BDB078
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B40242000F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51EE284880;
	Tue, 14 Oct 2025 19:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEfsKjvr"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9A9235072
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 19:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760469453; cv=none; b=Epu+icMuUBSJNdhMmBWLyttEOxHGn76PHpmiiX4JRFsc/nxAgmKmB634VaL9xcD9OUboErdtJessx39NvuX0FusY/ZtpAYmWLqKB95i2gpQgOns0NLGUh3d9FXrJgYayCjZ2nwVRQ0qoN9BeEpP44mNAtF2C8DcLB1ZchNQFTTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760469453; c=relaxed/simple;
	bh=eBIenExFVpfeI4CKvfUIL9zyQjpNN1gRKVHCD4mPVUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1V/CMFUpi9OWhDotOD8vsvHuAJa2Rr0PNf4voqTOCde1IlGC+tcX6EEi1Abxd7lurTJeCCIvt8IiZLWrDirrA6I0xAjD8cV/VsHvQnVvUUptdNdb/vMuiUZSUWRk/5RiJI7DT514vp6++encQE9dD1vKW9uW53gfV5wrFQgqbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEfsKjvr; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7814273415cso16221927b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760469450; x=1761074250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uDSBrC8cLuTSNHDyZiLCu5ZpZO8rOAjsl8ZFn/oXgY=;
        b=hEfsKjvrWs1P6Dfs/r9uads9ds1PBDIIVFjqYNBIj5imDgTTMFQYtzu2leOyCr2Zm5
         0Y8+RJ5oW2QPaDSFfYsJTz77Kspj8wZFAnLZbOE/KwW0XoFJsXxCZdRPFYsZ/I7kbgL0
         uUT5wD9I4NdmjeM2hjoiRSfpUJAJO43+d5De1N/I8kqicxixuFOXh0WMQxIWCpUsQsaC
         ZXSuqud+NuixOUv4xZJPOdPTZLUGcjubTiGpYXx5FUl81YXFjOHZQUIawn180Ex/fKYK
         am8TSnr9NYiR1X4/MBZizwrCr/oz00lqW+5Du1h5PepCCk+iWVlNkQWAKdX54P817bPr
         VyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760469450; x=1761074250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6uDSBrC8cLuTSNHDyZiLCu5ZpZO8rOAjsl8ZFn/oXgY=;
        b=Fbpl89rzHbd4laXGQLvdQzR3nGUTS0CujXQ7yI1DsAr6uljgPChesClswEkEPohJx2
         hW4oO9wYTFnZwXgDPsg1UStfx5YusZDekPO+S1JDU0mX4sRz6bqrzvNSvDljG7OuKFoO
         9ClOndZGtdtpQlARiPZRX6Zbk3u/BgC++D098BFUROMNuB/Z2F9QonOeEVfvFSk3FG1q
         8tqPjZVK0M8VIDCsULqnVWEAs/iCKAiGlj/ZenHpMU0uqSfWYhRIKur4sxXG+/qShwUN
         LmrXKzzYAYF7bME7zElp/41R7XEdGJW7NhPOhzWQFn213R4aNk+JP13BLFRCRWeqQqUb
         rcgA==
X-Forwarded-Encrypted: i=1; AJvYcCXzTOL9MJ0A0sju96IpPaSEgQsHhFcZXq5XIE1tyXnMn+ndAstSs54aXCOjHd2uhB5dCSw4bA/HeQkaKBw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0ax7uzM6M8+CInI16LNl+qW8YFl+6bMVgCWdyJb0dFa04gbYA
	yLU0AN+0zH/7kFzyEriQTa37N2aBkmSuNxYj+ty6JdVkuNw/IFD2ZhNc
X-Gm-Gg: ASbGnct7ZZKB6KUU3w1P7QJzMd8f/OXasWAh0nvsYS1nzceTWZK1DEGvMTwx49XPtNP
	AjTaUujQoAbW9tdSltvXmt4CcT4bqno/MmEd14aoPP+b+WyvLpwv51JB1KjEcwJ3T9GHLzA1OBH
	T823eTNHuZytizd6wT7crZAHB5Ngn2o6M/YyRTm1NfgUlQ9dGJjxvxjjUItXTvMw3T5ywwp9WbJ
	bXEQOGTNJH1wj2UvYcieXpkq+WDNu/TJbli/KGFppIoRJ7vBlUosof+IRHEV3ryjYb5Bp1NW75S
	1Mbq405wcvzbP0tqA8B7mqNt19EHUCvBecOssvdDainpGhVi2VVDbRROjyu0OoUAsr9GcUNejk/
	JgAJNPt8u30Hqk8r8RLek5xYOqZqXd2wszbR47c10h2wRYzLbbdTyP4vpGC8d8ofCflDr9dQtRP
	Vycy0aFR581QH9mLY4Fr4=
X-Google-Smtp-Source: AGHT+IF1b9AAnvNc6gLY8LoyIsmgjxUrlXEDNaP9TOJPUcJClAPAZoYgKHkl+ZfyW0Pn5VZag/Uuqg==
X-Received: by 2002:a53:ec89:0:b0:629:9c6b:b3ab with SMTP id 956f58d0204a3-63ccb825baamr16716867d50.1.1760469450484;
        Tue, 14 Oct 2025 12:17:30 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:74::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63cf0ee8ccasm3560031d50.13.2025.10.14.12.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 12:17:29 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chris Mason <clm@fb.com>,
	Kiryl Shutsemau <kirill@shutemov.name>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Brendan Jackman <jackmanb@google.com>,
	David Hildenbrand <david@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH v5 0/3] mm/page_alloc: Batch callers of free_pcppages_bulk
Date: Tue, 14 Oct 2025 12:17:27 -0700
Message-ID: <20251014191727.788875-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <6d62386c-242a-4735-add3-fee9c6e0ba96@suse.cz>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 14 Oct 2025 19:54:28 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:

> On 10/14/25 16:50, Joshua Hahn wrote:
> > Changelog
> > =========
> > v4 --> v5:
> > - Wordsmithing
> > - Patches 1/3 and 2/3 were left untouched.
> > - Patch 3/3 no longer checks for the to_free == 0 case. It also now checks
> >   for pcp->count > 0 as the condition inside the while loop, and the early
> >   break checks for the opposite condition. Note that both to_free and
> >   pcp->count can become negative due to high-order pages that are freed, so
> >   we must check for (to_free <= 0 || pcp->count <= 0), instead of just
> >   checking for == 0.

Hello Vlastimil,

> I don't see how that's possible?
> - to_free is decremented by to_free_batched = min(to_free, batch); so it
> can't go negative.
> - pcp->count indeed decrements by nr_pages but it should be exactly zero
> once pcp becomes empty. It's true that internally in free_pcppages_bulk()
> the count parameter (where we pass to_free_batched) can go negative, but
> that doesn't affect to_free_batched in the caller free_frozen_page_commit().
> So testing for <= is unnecessary and only looks weird?

You are totally right. For the first point, that must have been a slip up in
my mind, for some reason, I thought it could go negative after looking at
free_pcppages_bulk, but it obviously can't since we are taking the min as you
pointed out.

The same goes for pcp->count, I realize that it cannot become negative. I think
I was being too careful without really thinking too hard about what I was
protecting against. I'll send in a fixlet in 3/3 which should hopefully be
folded in.

Sorry about these mistakes, I think they could have been avoided had I
thought more about the code. I hope you have a great day!
Joshua

