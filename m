Return-Path: <linux-kernel+bounces-847070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99659BC9CBD
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B7331885B32
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD301EDA02;
	Thu,  9 Oct 2025 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Ld4G2DyO"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E361DEFE8
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023802; cv=none; b=kuJo2mFqTZ7UrUsFFMEjCqr+R+UeURTK+D4xVEJmP5qcex0LSL1/Zi+QWKqiDmhxZ7mR5gp4hS/c420Rpm/IItorvl6jayu3amgQRRH8hMrA/O8wWLEWsQS/IaCxDDW759IIKDdvTu+oHs3aNUoMhvwGVgQ4DWYFN5r9+DI6D7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023802; c=relaxed/simple;
	bh=gd5cjc2YDQCWkA8evLBN0VUFvCTfmbJVeE9I3tDWPk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0HatgJ3fX9nooK437zGirnx/b2eXEQuZpOHmBYPA3wG9cgbrnV+1zVlBXnhdZcgezNMZiSEQL1LgF5tnUJO3O0ju2CQ8nTKoCx+Xr9zNbD4NcVyVq8k4GArvIDg14ucwCnM3GDvJWGPjMXIlFVmUBPvT8uovIzeE3rYbWdRqWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Ld4G2DyO; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-80ff41475cdso16976046d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1760023800; x=1760628600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5KXAYePP4BLP0oPw4Oo2yec/zLTGELhv7tKRSHRmraM=;
        b=Ld4G2DyO0tepnMs45JoXCcL17nkacHSQL3Lh14ZisIFERpBxhy33A9XOHu6e7ezDQ9
         XrQugbSNGmT5m7cBOEUG7uz56OlLT52nKTLYBGZez6ZIYNSJeVL44LBra5NauLPXqou2
         wo3tgCU2ztH7cAFuWqwAE/VQqNEwEEdyLTvMjeFSPqap1SJYOoTmjRPP1Jnbzag2DbU/
         mRbdybrhI8ztX/7VHJAep/4uE4oZXHFNxsHwTSILJ7NHikPVOJS7PYAvWEzeU+DkqMSJ
         NH+VkfDLhWPIuzZAXcGEgF1Um2cyOzM3eqLIWTr1ysXT9bvmHGwY5UO/enkVl220dhh3
         i33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760023800; x=1760628600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KXAYePP4BLP0oPw4Oo2yec/zLTGELhv7tKRSHRmraM=;
        b=BMinBhUC+lJbEiM2UIRKKYDRSZtdyvT6rWfJUYlvMHCgjkCpMNYPJjLUG4v3pwFT5H
         n4w9eNFr2fGdpUP4pU5Vi1G2PMQ4CsZ6oz8RP9UOGyAf26sMUcuT5KNFXKG/zga8Kj2J
         jMLZpa+0jilJAwuKxRysMCC+5a9NXsbCkk9xQYkOdfKbRw9yBS0sPopkggI8Gm1Ja4o6
         k8F+JfJLWA9KjH5KMzvVN4LjHMprYtsJnVaZj5ye1NeNnXS++1c6712nliypc3h1W7M0
         S9G1RtbEbnoBZqpTq8FydqRMv3yYp6uE6O0RfjWCV7mWMgU19YEqohNbQ3wEhS9/+wm9
         XZBw==
X-Forwarded-Encrypted: i=1; AJvYcCU95tz4Begzy0ah0zqBY8zCghkRi33NgTdLfpaoB7jJcSXMYjHQTj/pLTXS8k/C4Uw95HVl1yvCoX3WUo0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2ax9i/UKYGSutZGzkLurrfz7LZt5hnhh6QgrnL1CggIcmKVsQ
	DE0c0COvtU1ci7qE9/mSkdBoKtpL8du1Ap3lBrcOexRrHpSQvUfI19XU5LcQ6CiMn7I=
X-Gm-Gg: ASbGncty1vfWl65XyRFKWthvJwuEPnI+UQKQf0L8ZckUwoMAG2+pgL/jTE6bj1W2JkN
	DbFxEyFEGb3KUOCVfE6NH2cfJkyMEIbltBDwIRw8qtgsmshlzusU0uFwxMC0y8DR+TUNb8LaFHt
	omy4iVVQw8lLsdF/HarucobaJkzLJoZed1iPMvrdp3ncltB47VHMSsPQRxlZVxZ/HSxFBzpBqW3
	Ilxec83cXc11qLG6VwFeNpWMtqDX+dpNjdu8lQ3+i9oxfefCVpBnAJl9SmpAiLpWo7ljbuPN1ik
	F9/iiPsZYchflhcpB0XHUJMIFaYdyP4ziWzrf79ZrXJ/reZOM++3kiU1ITQGq9YFx0D8NSZ2Sny
	eoegt+0x9DUTqyhMIrt789yy9re52fErVv2wOkhBI3m9VYNNNIr1u5e3Gnat4E/ES9WH8dKY87/
	VWWUkEO56KNWlOP6Xp0+tRQB7NWY9fiA==
X-Google-Smtp-Source: AGHT+IFdgTVH9uyu/5o64basHMKsbAG88LBs1aBY1NSyzfZE3IVT45kHm7IlO9M72p9+htOIi0Mntg==
X-Received: by 2002:a05:6214:29cd:b0:772:4853:48 with SMTP id 6a1803df08f44-87b21002ac1mr103016176d6.8.1760023799963;
        Thu, 09 Oct 2025 08:29:59 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bae60c89sm179458576d6.12.2025.10.09.08.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 08:29:59 -0700 (PDT)
Date: Thu, 9 Oct 2025 11:29:57 -0400
From: Gregory Price <gourry@gourry.net>
To: Michal Hocko <mhocko@suse.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	corbet@lwn.net, muchun.song@linux.dev, osalvador@suse.de,
	akpm@linux-foundation.org, hannes@cmpxchg.org, laoar.shao@gmail.com,
	brauner@kernel.org, mclapinski@google.com, joel.granados@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mel Gorman <mgorman@suse.de>,
	Alexandru Moise <00moses.alexander00@gmail.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] Revert "mm, hugetlb: remove hugepages_treat_as_movable
 sysctl"
Message-ID: <aOfU9YTKMPWzYOta@gourry-fedora-PF4VCD3F>
References: <20251007214412.3832340-1-gourry@gourry.net>
 <402170e6-c49f-4d28-a010-eb253fc2f923@redhat.com>
 <aOZ8PPWMchRN_t5-@tiehlicka>
 <271f9af4-695c-4aa5-9249-2d21ad3db76e@redhat.com>
 <aOaCAG6e5a7BDUxK@tiehlicka>
 <83e33641-8c42-4341-8e6e-5c75d00f93b9@redhat.com>
 <aOaR2gXBX_bOpG61@gourry-fedora-PF4VCD3F>
 <aOdSvriKRoCR5IUs@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOdSvriKRoCR5IUs@tiehlicka>

On Thu, Oct 09, 2025 at 08:14:22AM +0200, Michal Hocko wrote:
> On Wed 08-10-25 12:31:22, Gregory Price wrote:
> > > I'm not quite clear yet on the use case, though. If all the user allocations
> > > end up fragmenting the memory, there is also not a lot of benefit to be had
> > > from that zone long term.
> > >
> > 
> > The only real use case i've seen is exactly: 
> >  - Don't want random GFP_KERNEL to land there
> >  - Might want it to be pinnable
> > 
> > I think that covers what you've described above.
> > 
> > But adding an entire zone felt a bit heavy handed.  Allowing gigantic in
> > movable seemed less - immediately - offensive.
> 
> The question is whether we need a full zone for that or we can control
> those allocation constrains on per memory block bases to override
> otherwise default. So it wouldn't be MOVABLE but rather something like
> USER zone.


Mild ignorance here - but I don't think the buddy allocator currently
differentiates chunks of memory based on block membership, it just eats
folios from certain zones/nodes.

I'm scratching my head trying to think of the discrete mechanism to do
this that doesn't inject significantly more complexity into the buddy
allocator.

Looking at the recent[1] THP support for ZONE_DEVICE, I wonder if we end
up with something more along these lines?  But this aschews the other
requirement of wanting the memory to be otherwise general purpose.

https://lore.kernel.org/linux-mm/20251001065707.920170-1-balbirs@nvidia.com/

ZONE_USER does feel like the most natural solution.  Literally just
(ZONE_NORMAL - GFP_KERNEL).  This might need a new GFP flag for certain
use cases like KVM (GFP_USER) to denote certain "This isn't technically
kernel memory, but it needs to be pinnable".  That would slot right
between ZONE_NORMAL and ZONE_MOVABLE.

Alternatively we could go the opposite way and introduce ZONE_KERNEL
below ZONE_NORMAL and disallow GFP_KERNEL from ZONE_NORMAL - then have
strict watermarks on ZONE_KERNEL to ensure the kernel is always able
to get memory. 

~Gregory

