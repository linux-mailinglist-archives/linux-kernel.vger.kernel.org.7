Return-Path: <linux-kernel+bounces-819677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78448B5A517
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 00:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1ED322402
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17DA2222D1;
	Tue, 16 Sep 2025 22:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="QbA2tJgU"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233F84A04
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 22:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060156; cv=none; b=o7yQwLGaH37nPuZ3rubDCOyCL+ysZt909mvjH5VfuLXnzGZL2h+6uOXaUUjWMe/xzP4f4Ukx39J5lD0chaO+jhhtpszZyOK1VRnWnrAWkzB1DErqOZNU2MXHup8/uSN98U5k3d4bBxPW0k30KU/vgcZctCIYI1BKtJoZQKSp6tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060156; c=relaxed/simple;
	bh=Ul/BNFptLLzAxDwFFZBt2lSNKL6GvzOQ1vw9cp2BOnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ej9FXFmQRL9+TVMUbDmRsTQZcJkbmXpQjaCsBTz1fi8oGRTQSwxy0jVQSTSvh8GndbJ6FqZ3Fw/Gei/wE1jRTmF6gqS/rcvEEH5oi8sYOl2+JiyRVlq4sCxxI+1T11k8Z4mz9xP5uhV/oWgmKngxGbwIMaNh4YmlnFX50f6f+pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=QbA2tJgU; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-81076e81aabso497240385a.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1758060153; x=1758664953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xQ8K4gFLQK8N3VAF0ow1iMWGtXpNTgEuNC+GqpxwwNg=;
        b=QbA2tJgUNBx11IzLGaCXkFOzV6AqnA+shfQ97u7cWpVeezzA3Xtx2yrQ4cko+++6e6
         kSe2t2f/240NviLtls+Xu8hnlxYTW+1SDPgaQYfXEo085tM+F18zxSiWwbfwfr2mhoR0
         KB+YLJlMG+6XhC0NQcsRHaxcx8VKcVKm2du5O14Z0XU/KcLm6oZ/sWFusRDR8pj+E22R
         nPN8gkNdX4J3U/4h3zYWleQAHcLvt5CHf9Lb15BsZa/Kz3PHuxTKOpRm2It+KDl50/m8
         fpoBXAmPqs9bljVdLbV/gqQHvSuaFUzzQJ2GfC1RfVRBeRhgKK7kklcwwWzQFZ/vBlre
         Te/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060153; x=1758664953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQ8K4gFLQK8N3VAF0ow1iMWGtXpNTgEuNC+GqpxwwNg=;
        b=oAn96jutTFhCpLGp0fmi3hh6UMKfvNHHLeRR3SBTH4+1NeSLu0de1j6GAwAqhudUr7
         qrUr2MU9xs1D2twYfEEidzzYYeM222nPFVM4ducxXcPjVPJs4A5Bk1oCO5CZQAV/nBdA
         Nm/kapTHRkqjkxn0/zsOXmtFwyDnnogIX6pZk3lnTrehmCks1oDy/FFsdEKliq+mJuIq
         G0xfUm9HqhdmTosgIMXUYoQD/Ru8ZCrDzesb+Yv/2ekOhZ5a9HCIgFjt8Fpd5mwIzFXr
         evDWwMUFLurrYHbimu7qr2RYIVKEjpd31NM+SiUogFqWfmfwINKyksUyMIjNs+UtQKL3
         Q8vQ==
X-Forwarded-Encrypted: i=1; AJvYcCWi6P7B1bc8oHmqJiR7Rs4aEg/xmseOc+2NMPQtxXm5E3EPzZSvII0VEQ4k2FbtAt9rXbbZWH9TXxwDg40=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOidDscnMnqgikRZMp2mdNxwdSmNbqlMYgH/4tMml+M5lIz8gk
	g7I4DjvKzmZwpYKmw8xx7O4wI4R0ww322MlpCe9xsJ7rIqnHJLsds+TZ/uo3UVvWN44=
X-Gm-Gg: ASbGncsleZTXVXimdiwgetggSgmtbB5o4TRUPdPT7K8w6m0xwK9uj+irFhDRTjGprxN
	y2y+B90rgU3vCNBDwmwoYNkaEGBCvJp05SiE4ihQBL0s+u/sMYECDJ/yiIiSG77sNPtP5263bJh
	E0KxIqJxTLc1/sApbBzKW90jeSbAYMMuP89HEHz9cfetTIEITmWZHyPtiLcoZ7TQ4NDaaRwY/yz
	TcoFA+FbdgdrqmqrCW6SVTLy7zF0DJqIdVbzzhH/LKW5YYUcYdS31E2GKbzco8SrvWJ0G1gMPWQ
	GffFoVVAvAbsGVz7fxlTfnvl2zYCxHkhnsfuZzE9GA8VAfc91XWiMY98fu34u9wvRXDgxWOvJRU
	akxaT/b7EeuTtxkx8T1aBBWtI/uKkwuo2TiVtsaTZCIK13jHUvLjU6ZZSRFub02itE0tIFb+UrZ
	OGwIY=
X-Google-Smtp-Source: AGHT+IHE7xHsOsLEaNHRsG77KnmSH05/ThEIDM5eGgWVC4AoyZnlllTOGd/v1EC79Ig1+Af+801yew==
X-Received: by 2002:a05:620a:7013:b0:827:fa83:ec0b with SMTP id af79cd13be357-827fa83eddbmr1358277085a.52.1758060152617;
        Tue, 16 Sep 2025 15:02:32 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820c8ac45a3sm1040371885a.5.2025.09.16.15.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:02:32 -0700 (PDT)
Date: Tue, 16 Sep 2025 18:02:29 -0400
From: Gregory Price <gourry@gourry.net>
To: David Rientjes <rientjes@google.com>
Cc: Matthew Wilcox <willy@infradead.org>, Bharata B Rao <bharata@amd.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Jonathan.Cameron@huawei.com, dave.hansen@intel.com,
	hannes@cmpxchg.org, mgorman@techsingularity.net, mingo@redhat.com,
	peterz@infradead.org, raghavendra.kt@amd.com, riel@surriel.com,
	sj@kernel.org, weixugc@google.com, ying.huang@linux.alibaba.com,
	ziy@nvidia.com, dave@stgolabs.net, nifan.cxl@gmail.com,
	xuezhengchu@huawei.com, yiannis@zptcorp.com,
	akpm@linux-foundation.org, david@redhat.com, byungchul@sk.com,
	kinseyho@google.com, joshua.hahnjy@gmail.com, yuanchu@google.com,
	balbirs@nvidia.com, alok.rathore@samsung.com
Subject: Re: [RFC PATCH v2 0/8] mm: Hot page tracking and promotion
 infrastructure
Message-ID: <aMnedTTmmpuvDxzt@gourry-fedora-PF4VCD3F>
References: <20250910144653.212066-1-bharata@amd.com>
 <aMGbpDJhOx7wHqpo@casper.infradead.org>
 <aMGg9AOaCWfxDfqX@gourry-fedora-PF4VCD3F>
 <7e3e7327-9402-bb04-982e-0fb9419d1146@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e3e7327-9402-bb04-982e-0fb9419d1146@google.com>

On Tue, Sep 16, 2025 at 12:45:52PM -0700, David Rientjes wrote:
> > I'm hoping to share some of this data in the coming months.
> > 
> > I've yet to see any strong indication that a complex hotness/movement
> > system is warranted (yet) - but that may simply be because we have
> > local cards with no switching involved. So far LRU-based promotion and
> > demotion has been sufficient.
> > 
...
> 
> I've been pretty focused on the promotion story here rather than demotion 
> because of how responsive it needs to be.  Harvesting the page table 
> accessed bits or waiting on a sliding window through NUMA Balancing (even 
> NUMAB=2) is not as responsive as needed for very fast promotion to top 
> tier memory, hence things like the CHMU (or PEBS or IBS etc).
> 

I feel the need to throw out there that we need to set some kind of
baseline for comparison that isn't simply comparing new hotness tracking
stuff against "Doing Nothing".

For example, if we assume MGLRU is the default, we probably want to
compare against some kind of simplistic system that is essentially:

if tier0 has bandwidth room, and
	if tier1 is bandwidth pressured, then
		promote a chunk from tier1 youngest generation LRU
		("hottest") and demote a chunk from tier0 older LRU
		("coldest") [if there's no space available].

Active bandwidth utilization numbers are still a little hard to come
by, but a system like above could be implemented largely in userland
with a few tweaks to reclaim.

~Gregory

