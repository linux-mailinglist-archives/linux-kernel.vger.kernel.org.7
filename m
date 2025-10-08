Return-Path: <linux-kernel+bounces-845929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B371BC6843
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 21:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D8343AA2F7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 19:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E3727703A;
	Wed,  8 Oct 2025 19:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="N+n3DIOc"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E827A27467E
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 19:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759953559; cv=none; b=FapPwyVa6+Ypby/IehoI/znzXgViNvBlBrPhkQZfPW1bn1fTgq0cF3qtA0lWOH7TyROsO43b3gI1M1mPHwzrm7uTQ9W7xq4fjwyu4GspBy08n2oszoRXumma890dIRMNh81RRGOU/vo5OMoa6VMvbXJLJujyR+fngzMCAjjCICI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759953559; c=relaxed/simple;
	bh=6nsqwikc+gppKx465Dsw1tXk6ea/s3IqiQajcjH9T4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3QHlYDY2xsewR/8/3gkZ1koJiDb9T/bZvn0aFSwgFtf2/8grklG5vzzQM9p4pcxMR3KcrTj26dgj6V6cfMhgM15DBhvCfOFFtwJenI4oL5JlqkAnjVIy3WXfcuwM2b17jvm1EBmWbl7D564Uo5fB3CAgr9HwCdqKRn1ywf+L8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=N+n3DIOc; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-80ff41475cdso3747496d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 12:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1759953557; x=1760558357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bQgR6a95356dPsVrbrUk33Cag4UDOjeL50G3GytdiSY=;
        b=N+n3DIOcwQMmr6wsL4trcAinkaO4Z8aBNw4mXByxjiNwYRd5zoqUSnFQHUw/3nvAGs
         DFCGPHRHORqcB8DfHme7WG8stuRnx1TSYyQAXGD4ofWx5MgB7jSlP6koMKcMJBMVyBsU
         /hsyP278bFXx3s6g7giWhC7I5rk+1uvsVDT5Fp40P7daHPE+jH754CtoTfkPieKqV3kM
         tF/piJYoUVWfkDVh38jkZvt08KZrLfCM3KNW1yvBJT6S6Y8CeyGaebWxMjFyxNt01uWi
         vqv+894/xf38IQcNCTGTZTfNqHIoNmZf0ovu/RdIm2uGBLP3aewB0KE9jRs1Apy3d6qO
         XJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759953557; x=1760558357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQgR6a95356dPsVrbrUk33Cag4UDOjeL50G3GytdiSY=;
        b=HBhgqErE+pFdB8N+pNErOiIr8Qw91TMD/GGotllvOIkSUbqzQO553Fk6cxxIDwMbwo
         Hbg4+RaAtZta+fmHTTQcY42KsBEfPVJysZ8uLAUPjeNPuH0FXEBd9kYiSqc+e/Xl7G+L
         tcUMjeO38ChlbUpB+5IywBYGq/GDkiZiVkfZXJ0DfoDLlGAZ30xleZ3G+jZtTcRhbxcB
         X2Ep3kSTAo/3/srvtLjzk6Gj54zji0w7ajBk1ZDjRxIwpOmsa6f0KGqk8XuavEVmELDT
         x09x0sORFE9zI4tIWrt/kVoc6VOBXbO84sVd20cCBlodVf6DMoxoNSORyD9l+7yaJyR1
         w8DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWsmi6dAeAGBj5R8ev6fJEPZaKluNGw7SdGAL5DPcSF9E93AN4EtG1jrPMFsJco+bOHb5XsgA+uUsDMu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYX2hzU8qapRcmM+b/PdMPiYaKfiPMZQRG9acHHGaWQ3m302m+
	/OgthpF/hzVYKY9rBiq0Cm4UprajPSto+Sk/49KXokeqM3kPK6CheeURO9M6bPlcie8=
X-Gm-Gg: ASbGnctZzSv7vUJl0Cz8hMeYzVJrzb8Zey3g9PHKLn5obK0qN+yf6KkgcGvxdbAjtZN
	rKN9ARALxhNeOD92w4JLZ0sd3GpfxoM9Hqpfsem+tAERCfrct8UR6fzVb5GsM+4dSCY9UwRgOiJ
	eWQgxmlG14U3Dk1u6mUNgkIXDIBBCP8UWyHknHlNut4+HSdtiH6ZeTq9WHgWElzQSq6EzPhi+xx
	hA6VGGe9xOpI93RDqWylz/aeUn67Uqh8Qh6CbMKSCNv6O3iOnjL/DtvYdzszHrvlbmcZ/U/EQJJ
	za2qtNyEkremNLRT5wMxd5JNhp7AQiY0wpttOwdIvDrc4ACdmrKlDbqagnfJj8k3BQr5oYrVu7/
	1BshOYnjeqexAfUtQ8xiCs1xpqXT0+C0cj3sY7gsdo7szMYtDGt6XYw7fAQMqCJbWj1pmZYTZaF
	OAp4XmfCRSMk51VvyPp5MCO8aQWWExDMRM+R6FWxD3
X-Google-Smtp-Source: AGHT+IGOIjFNFX0UWzmMPfhHtuIlkaHHvw+0tGaxRx+44ltIOKx7Dm5ffks6WimcIFao6ap2lPWKnw==
X-Received: by 2002:a05:6214:410f:b0:77e:aba2:c8a7 with SMTP id 6a1803df08f44-87b21000e61mr61430946d6.13.1759953556821;
        Wed, 08 Oct 2025 12:59:16 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878be61f6bcsm169735486d6.65.2025.10.08.12.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 12:59:16 -0700 (PDT)
Date: Wed, 8 Oct 2025 15:59:14 -0400
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, corbet@lwn.net, muchun.song@linux.dev,
	osalvador@suse.de, akpm@linux-foundation.org, hannes@cmpxchg.org,
	laoar.shao@gmail.com, brauner@kernel.org, mclapinski@google.com,
	joel.granados@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
	Michal Hocko <mhocko@suse.com>,
	Alexandru Moise <00moses.alexander00@gmail.com>,
	David Rientjes <rientjes@google.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH] Revert "mm, hugetlb: remove hugepages_treat_as_movable
 sysctl"
Message-ID: <aObCks3bwrT27CIu@gourry-fedora-PF4VCD3F>
References: <20251007214412.3832340-1-gourry@gourry.net>
 <402170e6-c49f-4d28-a010-eb253fc2f923@redhat.com>
 <aOZyt-7sf5PFCdpb@gourry-fedora-PF4VCD3F>
 <f4d0e176-b1d4-47f0-be76-4bff3dd7339a@redhat.com>
 <aOa0UPnxJVGvqc8S@gourry-fedora-PF4VCD3F>
 <b6d472ba-e6cf-4c96-935d-88c842ab3cd8@redhat.com>
 <aOa_A_i1HUt1wzCj@gourry-fedora-PF4VCD3F>
 <1763f0d9-37fc-4c3e-b31b-2cfac33d5c95@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1763f0d9-37fc-4c3e-b31b-2cfac33d5c95@redhat.com>

On Wed, Oct 08, 2025 at 09:52:09PM +0200, David Hildenbrand wrote:
> On 08.10.25 21:44, Gregory Price wrote:
> > On Wed, Oct 08, 2025 at 09:01:09PM +0200, David Hildenbrand wrote:
> > > > 
> > > > fwiw this works cleanly.  Just dropping this here, but should continue
> > > > the zone conversation.  I need to check, but does this actually allow
> > > > pinnable allocations?  I thought pinning kicked off migration.
> > > 
> > > Yes, it should because longterm pinning -> unmovable.
> > > 
> > 
> > You know i just realized, my test here only works before I allocated 1GB
> > pages on both node0 and node1.  If I only allocate 1gb hugetlb on node1,
> > then the migrate pages call fails - because there are no 1gb pages
> > available there.
> > 
> > I imagine this would cause hot-unplug/offline to fail since it uses the
> > same migration mechanisms.
> > 
> > Worse I would imagine this would fail for 2MB.
> > 
> > Seems like the 1GB limitation is arbitrary if 2MB causes the same issue.
> 
> Yeah, with hugetlb allocations there are no guarantees either. It's just
> that page compaction / defragmentation makes it much less likely to fail in
> many scenarios.
> 

Gotcha, well I am open to suggestions.  This chicken bit here feels like
a sufficient guardrail, but I'm happy to explore the ZONE discussion
further if we think that's fruitful.

Joshua Hahn (cc) did privately question whether zonelist ordering breaks
for such a configuable zone.  If memory can't live in ZONE_NORMAL or
ZONE_MOVABLE, but you want it to have some combination of attributes
between the two, it can't also live above ZONE_MOVABLE I don't think.

~Gregory

