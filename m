Return-Path: <linux-kernel+bounces-845756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11ABBBC6076
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EECD019E32FA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A75A2BD024;
	Wed,  8 Oct 2025 16:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="cc3/mKyA"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ABC29BDB6
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 16:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759941091; cv=none; b=Xf4CV7XUbMJQ1mJKdOONWvb0yCfAHR086wpDB/8NCEMSM55jGRlBct1j9Eh8zJ11m2/zf0ts//YOVV3C0pXCMZqvHuLHfzLpN7YCqhTaRco5rZcWws4FVBgJrz3p+/w+pIMSfglADZX+mcafHyffI1xvsWPyn4VuCctGGjug5jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759941091; c=relaxed/simple;
	bh=TrrcF9VvlM8y9jx1omUO5ImthqYGOXo9CnJHYDJv+EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwAMsKLIYulE3gv5ATYu3CtgUwrAfaz0nKKTUuwIChw8N9n7eysitIG+Ea5GKbc1M8rqp6L97OohdZlc36F4A9gRyAHkPN8WJu3yQVEl/qGAoi9CKxswkt8uDQE+KWJr9uEsHR3MGwaH4Qjff3luI2I5Ndb0wPwQ/T+ynz7BZ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=cc3/mKyA; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-796d68804a0so809776d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 09:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1759941088; x=1760545888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ftJpOb1xcFQZv0a+i4an7Jz1/tLAQUsdU9C49sUWsFQ=;
        b=cc3/mKyAWWVfWsryi56paPHL8vaRFPx6nTyMLHNU8J3DARHD7b2PPXvYsdoDKUTqYz
         cesIW/k3/HsruexDnHjxCcW6zJdX9Wtw14MNS1ls8PuBcBgcjiJQtFUs+cmJKvTgsj+r
         oaNzoIl2v4BYFsUFavWsqI0wXYjN1OzZJEE2aCeK2zk8NBHdbaUBGOOcPSU65ncG5Npb
         muGNqyIRwBrJqYXD5BSL08VemB2duojC7VUFu44YVehWFI1meh7c7cz5x3vuFweck/DW
         0REWVdsUAnaxT4Q3ACTDGYoxXvyWy+HkTnvRjJ2wJl4E0SDa/3p/0E63am6AmFEK1hlX
         wa2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759941088; x=1760545888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftJpOb1xcFQZv0a+i4an7Jz1/tLAQUsdU9C49sUWsFQ=;
        b=Fez12jEeraJ85T7a9sdwMtkKabatnz52AGqowUjm304FapjgDxDbtHyy8vqtHwp53s
         LTqG5wJT2iQPymHGcfPt/tTIlkMv0+RnKJ0bCBI4kehmPOSaMDNUAVQato0ee6vdh521
         RJv3+08YUneVSmnmr5666PNPny4zIWJ9pfN9abo888KWxwYtYlk5dg/9SsDJhDs7zo59
         LcHTogFpkuzDyTrz5GQsVwQj/m5J3g7iPgzStrMXDG96FfS0KFiy/u9f3i/hN7uG8Ml5
         6JKdzOd7jSRvU0Uc7x2jxutFWVKVt2mjRuM0rbEFzg09Ugn3wLP8M6/RQ7falScFyyK9
         WpMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjb6xbj6XPDjMGzor/BBXgiJD131+0b2aBOWgLc6H/84hwHjTU7pLkV3FLNMxbel/iQ5UtseamM1vgjTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YywRfWIgjsBoUulw7EjqhJB8xpG9M94Q0aVCzo2zVsQdE1V3C2u
	H/kOFRSz7sIoWAZHaVxfeHnOFlNsdApwlLsWVOrU5ynvql0B+48F0OYPMfOeJfHlraTxKtQ0FAc
	lr0SJ
X-Gm-Gg: ASbGncuN7AK+aL2JyOwqi1TEUCYTKNPLQLktdz4afIWgTyPbM4Y3mL7csZgBd0lZxSm
	9qZduVldF0Cbs05CibA0L3v3aE0M4uL03FjRhX3gSe6SXu3y7tlEMNkkMqz3jTpUnPhBvo/EEeo
	I2SVF4CMhY6SktYfHq7MgY7IYqALJ1uGQZx4mxPrLyOOxwKyI5DvjUox7S+JNFWNx6S0wwrx5vS
	9gwfjpQHvYDw/+vJ6fpu9CLXm3RSxNZiB/w2VCi9ceHuQcuW4DxhA8dw04jq9vcc4vhIpI11f6L
	X2k6HvbyOTuQPz6wDN+VogECYkPpIrtMxNwqec1YIHvDtKK5KHsrvMbcLzPWuePxyDYSLBYbYdo
	racwFNs4Uq68XECtxaPsZxl+SmHWFmNG3PsUZrmuZtUOLtNUt0/AdQlWAAesBMi6gmuJ7AoQqgV
	wHXE96tsEPRPuYJaRN3TqXP0hRAMBG57XU3lYmEw2PAJ2ykRXx6pg=
X-Google-Smtp-Source: AGHT+IH3li9YLOy2HwLU9l6NJx1hAvZugBHxS1HCl35MSzFjO8cle36MgAd2/H/V1sd72ii7wdm6jg==
X-Received: by 2002:ad4:4ea6:0:b0:73f:a7c8:980b with SMTP id 6a1803df08f44-87b21001056mr61864846d6.4.1759941084963;
        Wed, 08 Oct 2025 09:31:24 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bb446e8esm164513976d6.18.2025.10.08.09.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 09:31:24 -0700 (PDT)
Date: Wed, 8 Oct 2025 12:31:22 -0400
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, corbet@lwn.net,
	muchun.song@linux.dev, osalvador@suse.de, akpm@linux-foundation.org,
	hannes@cmpxchg.org, laoar.shao@gmail.com, brauner@kernel.org,
	mclapinski@google.com, joel.granados@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mel Gorman <mgorman@suse.de>,
	Alexandru Moise <00moses.alexander00@gmail.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] Revert "mm, hugetlb: remove hugepages_treat_as_movable
 sysctl"
Message-ID: <aOaR2gXBX_bOpG61@gourry-fedora-PF4VCD3F>
References: <20251007214412.3832340-1-gourry@gourry.net>
 <402170e6-c49f-4d28-a010-eb253fc2f923@redhat.com>
 <aOZ8PPWMchRN_t5-@tiehlicka>
 <271f9af4-695c-4aa5-9249-2d21ad3db76e@redhat.com>
 <aOaCAG6e5a7BDUxK@tiehlicka>
 <83e33641-8c42-4341-8e6e-5c75d00f93b9@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83e33641-8c42-4341-8e6e-5c75d00f93b9@redhat.com>

On Wed, Oct 08, 2025 at 05:43:23PM +0200, David Hildenbrand wrote:
> On 08.10.25 17:23, Michal Hocko wrote:
> > On Wed 08-10-25 17:14:26, David Hildenbrand wrote:
> > > On 08.10.25 16:59, Michal Hocko wrote:
> > > > yes, I do agree. This is just muddying the semantic of the zone.
> > > > 
> > > > Maybe what we really want is to have a configurable zone rather than a
> > > > very specific consumer of it instead. What do I mean by that? We clearly
> > > > have physically (DMA, DMA32) and usability (NORMAL, MOVABLE) constrained
> > > > zones. So rather than having a MOVABLE zone we can have a single zone
> > > > $FOO_NAME zone with configurable attributes - like allocation
> > > > constrains (kernel, user, movable, etc). Now that we can overlap zones
> > > > this should allow for quite a lot flexibility. Implementation wise this
> > > > would require some tricks as we have 2 zone types for potentially 3
> > > > different major usecases (kernel allocations, userspace reserved ranges
> > > > without movability and movable allocations). I haven't thought this
> > > > through completely and mostly throwing this as an idea (maybe won't
> > > > work). Does that make sense?
> > >

I'd also considered something between NORMAL and MOVABLE, something like
ZONE_NOKERNEL or ZONE_USER. But that seemed excessive.

> > That is why I called it user allocations because those are supposed to
> > be configured for userspace consumation and planned for that use. So you
> > would get pretty much a guarantee that no kernel allocations will fall
> > there.
> 
> What could end up on it that would not already end up on ZONE_MOVABLE? I
> guess long-term pinned pages, secretmem, guest_memfd, gigantic pages.
> 
> Anything else?
> 
> I'm not quite clear yet on the use case, though. If all the user allocations
> end up fragmenting the memory, there is also not a lot of benefit to be had
> from that zone long term.
>

The only real use case i've seen is exactly: 
 - Don't want random GFP_KERNEL to land there
 - Might want it to be pinnable

I think that covers what you've described above.

But adding an entire zone felt a bit heavy handed.  Allowing gigantic in
movable seemed less - immediately - offensive.

~Gregory

