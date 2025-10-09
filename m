Return-Path: <linux-kernel+bounces-846304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2DDBC7842
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 08:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F2C593517AC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 06:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F35296BBA;
	Thu,  9 Oct 2025 06:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fM3y8tM2"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287B0244684
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 06:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759990468; cv=none; b=mY/87M7W6i4kxRDnQvhRd9UyxiVEhuNDBq8mHOVNDFNRdhwtQS6oPkCvVaxun6awE3fpYhuRtNTilyBGq1e+PbI9MhEBj7fsqqy0ypKfqKePUv8ZIW2ILDWT2lAKXa3LhLu33MOJPCzPpMlpx/1Ah+MOWumrPkXv62xR4yfypqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759990468; c=relaxed/simple;
	bh=+P+32VjyQia2/VMl6L8i5ps1XTSWuqyuULRXQ89ZNT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dX5gao+kal3xlBzlI9EUBRDf4mWtQ78p7EwIEQQzkaePbg4PJodIIrHeIj4xd5yIo0GtgdMccCC4G/n/57+UM9+tTkqdl8ZTh3dhGJvV2cgi1fcudzaVye9qMDg9lru7+oegM+Xi62X5nrJBafE323xxkpNtWbi6bWTlcNMdS+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fM3y8tM2; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3ee18913c0so82344866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 23:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759990464; x=1760595264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tY+RxY77Pgjb4Q3Ych7maYZ2J/C8zV6CQKxbmiyQ6H8=;
        b=fM3y8tM2rrya4xxuvNo9HiIaGOcOn9yhd/DFLSkkYp3LfPAoBLow7MhwGC2KUawJr+
         i1pbP7cmft5nNrFDwxZkBATGNCG8DQmJmEpMOqv6QAYGrcPlM2AFSZzaEtYuigjKNFqg
         +0u/4VqEgD6gr/mD63BJKdDMOpV1APZiHgTyc2Bj7Dto9QuomZGxsxYx5/Cp3+zz46KY
         XyK2bxs7ynpMrujBICbDiXgR9aQHPUWhdV0GVJWcwJgDE0qlA8tFse0bFz6vjAk0Cwm3
         886lZJLJ/NBNnaPXxoghpGUFQluNdm8owgwPnTxgGFXMkUMjOsVIds8b+/YuW/uyW8mK
         O2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759990464; x=1760595264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tY+RxY77Pgjb4Q3Ych7maYZ2J/C8zV6CQKxbmiyQ6H8=;
        b=g8W2WPLIKtczaWSXX+WwaByQx9YZtTBj6+exsIuK0E0FW8MawZlox5N0KiCMVqEgW/
         ln3WECYZ46JO76sBa+ulk+ktIzWghdOFOSuuxVUz7uBRUP+OYy8MhiONmG3FQlK3W2AL
         2j00vle1e+Do+Z9IHT2wjuTbccj0xFQvR6iktyxmtJqm2uskKk5k7o+Zvm94pFRUaQ7o
         rIE1xkJKtIg7EBKNXsfWiTUG8aVfuNb468AonXoJxz+fowC1r0l0YEf9jPNYemrBUfAL
         U5xkboaxqPD4mMK3tYNFl2qNk4q8D5V2DNAivxEeSELCRyDFI42k4jKQ9yBaRSRYmVbN
         DQFw==
X-Forwarded-Encrypted: i=1; AJvYcCVasjuACHRHmAYYQ2rXeVholzQ+HaBXPsbZ3S/5QLiEOiwLwx9t/SVc7NbikcemyEkks8fri9XyOx3qRdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFfp54Mc2U+MFULEDasjmy0iXk2WdxSF+DSe3uxyRdx46LGBk3
	nmdYlVgm+Q5vuYnpW2RdHpQWI4Vb2/d/YqHa5VewEY83pBlpNMAaAIYJDXT3D2EQwXk=
X-Gm-Gg: ASbGncuyHrLtMRvgBOvVfXg22Xs9eQd4+2tGVWsRKKFH+9b4LgXWUgfCNwNlkvHctMu
	IHpCZgsXVPUDaCMBJzFkcy3mzXtzfMrLAHt6WuFFH5D6aIO9hKbKrgJ3hRALI+wWVMJfqTe95vZ
	/9nWCx41OkevDZ4kVfUJgAb8+0GlEj5uSIk3CoOkb/9ZJtOsta9/G5QenjegmMCRlMbolUFxPv8
	mmpmuYZhSQoD+KfJI9sRLza1Rpd5uscaTCQPXh1732aX2VEFOnPo6LT8tztAF7jDMYESI1GZEcT
	xOeeou3iOoufxEFKuoxaviUrRUTnl6gQISsFBBJvEzVXT8CaB6iqK9KjQid56YC6UbZ5UPHlURM
	oDj2MnLcsdRs2wJ7HkBiDH8NJhHZpUZJQVO5Qryav/C44OvtxpOhmYDLV4mJcppLNMr7NKec=
X-Google-Smtp-Source: AGHT+IHag+XyI9AEKljQkUUbITbyiNy7sILEJRnoopPBDpFTzbe1XSGFErdxTP4ZeoFPTMso1aYmeQ==
X-Received: by 2002:a17:906:c146:b0:b3c:f48:ed57 with SMTP id a640c23a62f3a-b50aba9f7b9mr602408966b.35.1759990464254;
        Wed, 08 Oct 2025 23:14:24 -0700 (PDT)
Received: from localhost (109-81-95-234.rct.o2.cz. [109.81.95.234])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b486970b5acsm1816673066b.60.2025.10.08.23.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 23:14:23 -0700 (PDT)
Date: Thu, 9 Oct 2025 08:14:22 +0200
From: Michal Hocko <mhocko@suse.com>
To: Gregory Price <gourry@gourry.net>
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
Message-ID: <aOdSvriKRoCR5IUs@tiehlicka>
References: <20251007214412.3832340-1-gourry@gourry.net>
 <402170e6-c49f-4d28-a010-eb253fc2f923@redhat.com>
 <aOZ8PPWMchRN_t5-@tiehlicka>
 <271f9af4-695c-4aa5-9249-2d21ad3db76e@redhat.com>
 <aOaCAG6e5a7BDUxK@tiehlicka>
 <83e33641-8c42-4341-8e6e-5c75d00f93b9@redhat.com>
 <aOaR2gXBX_bOpG61@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOaR2gXBX_bOpG61@gourry-fedora-PF4VCD3F>

On Wed 08-10-25 12:31:22, Gregory Price wrote:
> On Wed, Oct 08, 2025 at 05:43:23PM +0200, David Hildenbrand wrote:
> > On 08.10.25 17:23, Michal Hocko wrote:
> > > On Wed 08-10-25 17:14:26, David Hildenbrand wrote:
> > > > On 08.10.25 16:59, Michal Hocko wrote:
> > > > > yes, I do agree. This is just muddying the semantic of the zone.
> > > > > 
> > > > > Maybe what we really want is to have a configurable zone rather than a
> > > > > very specific consumer of it instead. What do I mean by that? We clearly
> > > > > have physically (DMA, DMA32) and usability (NORMAL, MOVABLE) constrained
> > > > > zones. So rather than having a MOVABLE zone we can have a single zone
> > > > > $FOO_NAME zone with configurable attributes - like allocation
> > > > > constrains (kernel, user, movable, etc). Now that we can overlap zones
> > > > > this should allow for quite a lot flexibility. Implementation wise this
> > > > > would require some tricks as we have 2 zone types for potentially 3
> > > > > different major usecases (kernel allocations, userspace reserved ranges
> > > > > without movability and movable allocations). I haven't thought this
> > > > > through completely and mostly throwing this as an idea (maybe won't
> > > > > work). Does that make sense?
> > > >
> 
> I'd also considered something between NORMAL and MOVABLE, something like
> ZONE_NOKERNEL or ZONE_USER. But that seemed excessive.
> 
> > > That is why I called it user allocations because those are supposed to
> > > be configured for userspace consumation and planned for that use. So you
> > > would get pretty much a guarantee that no kernel allocations will fall
> > > there.
> > 
> > What could end up on it that would not already end up on ZONE_MOVABLE? I
> > guess long-term pinned pages, secretmem, guest_memfd, gigantic pages.
> > 
> > Anything else?
> > 
> > I'm not quite clear yet on the use case, though. If all the user allocations
> > end up fragmenting the memory, there is also not a lot of benefit to be had
> > from that zone long term.
> >
> 
> The only real use case i've seen is exactly: 
>  - Don't want random GFP_KERNEL to land there
>  - Might want it to be pinnable
> 
> I think that covers what you've described above.
> 
> But adding an entire zone felt a bit heavy handed.  Allowing gigantic in
> movable seemed less - immediately - offensive.

The question is whether we need a full zone for that or we can control
those allocation constrains on per memory block bases to override
otherwise default. So it wouldn't be MOVABLE but rather something like
USER zone.
-- 
Michal Hocko
SUSE Labs

