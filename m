Return-Path: <linux-kernel+bounces-845602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 926A8BC57F1
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 16:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1131040085E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 14:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EBE2ECD11;
	Wed,  8 Oct 2025 14:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CW0cK0xK"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47182ECD19
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 14:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759935553; cv=none; b=tJbKRVk+4ujc+ifA9daiHH1YmmO3NnLftaexAlNvuStFWajlWitDfW/lqpoLL4B4GOW3gi97mJyzGgc3fTAi01FGBq1JR9Rm5fLtmYR45JyGwDQr+SWK4tcR72oMpd8SyIMwKKYJrSxOrS3pmLqkwFRroXFS2DtQqwvqpiytvC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759935553; c=relaxed/simple;
	bh=+yCckR6yn9p7GyvjYoiZcRvKpmENICzodGyAOj0De5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJOhgkB6WFxGCV09AuBEeE4qUwXm6WrbsWy0U4b4BvwugeAiR68j1TuUNd7YEY1yq6497mxErQHPyqSs/9LVXDJZmgVRZmXHmFC9h/vYO7wuL76LaoqoOwQueL2DoOvDdpPTMDw6Fh6Ygn3O0KJ7lVB3EqnU/oYkWKHsO1S+/48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CW0cK0xK; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b2e0513433bso1175296566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 07:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759935550; x=1760540350; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3WqvDkSw2KqYGDX5nwqWxTk9V6PgPZ8rHUAzP3TxPgg=;
        b=CW0cK0xKcUiessnROdGTvqAMLKz5BnjiTzvFDwN/VYdDDbgyDEsDJgtuqGH6UqIrXp
         739G5I39TPPxZo6aWDcQbzht3N6q2GeKmSqFt/Ku2aSqaD7aZFJDIUpdD04nVCExUTcf
         k4imlid25bLvm0fHE8gP1BCx4Chl2R8DO8hxbirYrdH924+HKh1RF4iMckr0pWyvYoMt
         PrVuBknbO/H9eWvf/sZgykJ/4f5juSFuvHYgWtgqicrjwaoaPaoFzffiophUWzA8wO9J
         9uCKWJ5ajpwH4fw/RjOP/hOFnc8MTYgFTO+x8kW9iIMjXNC3NDGbhY8LeeWnfFzfHZZU
         egVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759935550; x=1760540350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WqvDkSw2KqYGDX5nwqWxTk9V6PgPZ8rHUAzP3TxPgg=;
        b=tsZRLc/s3wHSH6Mq6zNwAN0k+wz//UNIloltpNp70T9Ay92AJOTOTxrdNzPZ0xYbgq
         tiu1mliLU42PQlj+KqXjO+SlQ1xgXjnj0/7VmHR13gAPlbBwhyd29zogqB3ClYSpGj/7
         2wyadepG4KZkS3ttCPvRJHkPS8qXu9ofvOzpimHXZk6zw1zRoCD6mKhpU0AIOYTN25QG
         rpEUpXjJm2zRp9HzMQTeB5KwRvNgV978T0kajSydGocqvvx6H3o6dIRDLLi2wUf8KPbi
         P1remPf5TKTIha2YOMdO7XzJXOUWqnf0D4zqT6jcEJB17cu7Qr/kk4drV7/vuG0uWNUe
         b2Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXa19oI8u65PvFPID6OcMnJXk60FiJp9fbhESC7cHVKx8FpLswDm+eMPn701CMmZ981amFnfnz176fx3do=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfYt1lGsNczKkAxNQk5gR7k93lT3+UAsKwk+mC5kizsewxs8Nq
	98il70JPnFjVri83xJIzkzCGdAclYaLEr6miK99eMVbxbohmry7Q1d1gYoZFyHFmsq8=
X-Gm-Gg: ASbGncvqYufzHWgUivs/zRnjb6/fQvVo4QMw+W31NaYwl7HReyJ5yYTwGa71stQSy3R
	hACPkNixPALRKzljaRqTg3CfGaFGcZxJns4jrzU9YeRlZykE0bMQtzol8Bpg6LrAGiUV+FNdRjn
	OCtnGWm7xO9NVEaC8HazY7OaCLgj43V2S3NXhJ+/F22Yz6jEpNMHgm7Oyr4IxQUaMR4fKg0rntr
	6n16oRpiUOvVyW09i/tF8HmLaB4sIY5E1PMQK9jhbW3VEnaWnDx+OVNrNodwoTkCHXiSMBolN8c
	90SaOqIi4Ko2atx9O9S7nkDhQ6syjL3UBb841jkQHY9Iul1hWN9V9202Ru3fT05c5jKt/ty0crK
	V/mc6swQXjyToYei2Nw8R+KURDHC49f513qsFhPcS0wGqm1QlVQkb7qn3CQFcRg5f7AiGQic=
X-Google-Smtp-Source: AGHT+IFBSess4JhPzPnfqXQ4vaR52HMiQOJrNFMXBMaP94ew77X1V9umXx+wx/PFKR0AyuDpLcmESQ==
X-Received: by 2002:a17:907:25c6:b0:b3b:4e6:46e6 with SMTP id a640c23a62f3a-b50aa393beamr401394066b.1.1759935549398;
        Wed, 08 Oct 2025 07:59:09 -0700 (PDT)
Received: from localhost (109-81-95-234.rct.o2.cz. [109.81.95.234])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b4865f741f1sm1679808966b.39.2025.10.08.07.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 07:59:09 -0700 (PDT)
Date: Wed, 8 Oct 2025 16:59:08 +0200
From: Michal Hocko <mhocko@suse.com>
To: David Hildenbrand <david@redhat.com>
Cc: Gregory Price <gourry@gourry.net>, linux-mm@kvack.org, corbet@lwn.net,
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
Message-ID: <aOZ8PPWMchRN_t5-@tiehlicka>
References: <20251007214412.3832340-1-gourry@gourry.net>
 <402170e6-c49f-4d28-a010-eb253fc2f923@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402170e6-c49f-4d28-a010-eb253fc2f923@redhat.com>

On Wed 08-10-25 10:58:23, David Hildenbrand wrote:
> On 07.10.25 23:44, Gregory Price wrote:
[...]
> > @@ -926,7 +927,8 @@ static inline gfp_t htlb_alloc_mask(struct hstate *h)
> >   {
> >   	gfp_t gfp = __GFP_COMP | __GFP_NOWARN;
> > -	gfp |= hugepage_movable_supported(h) ? GFP_HIGHUSER_MOVABLE : GFP_HIGHUSER;
> > +	gfp |= (hugepage_movable_supported(h) || hugepages_treat_as_movable) ?
> > +	       GFP_HIGHUSER_MOVABLE : GFP_HIGHUSER;
> 
> I mean, this is as ugly as it gets.
> 
> Can't we just let that old approach RIP where it belongs? :)
> 
> If something unmovable, it does not belong on ZONE_MOVABLE, as simple as that.

yes, I do agree. This is just muddying the semantic of the zone.

Maybe what we really want is to have a configurable zone rather than a
very specific consumer of it instead. What do I mean by that? We clearly
have physically (DMA, DMA32) and usability (NORMAL, MOVABLE) constrained
zones. So rather than having a MOVABLE zone we can have a single zone
$FOO_NAME zone with configurable attributes - like allocation
constrains (kernel, user, movable, etc). Now that we can overlap zones
this should allow for quite a lot flexibility. Implementation wise this
would require some tricks as we have 2 zone types for potentially 3
different major usecases (kernel allocations, userspace reserved ranges
without movability and movable allocations). I haven't thought this
through completely and mostly throwing this as an idea (maybe won't
work). Does that make sense?
-- 
Michal Hocko
SUSE Labs

