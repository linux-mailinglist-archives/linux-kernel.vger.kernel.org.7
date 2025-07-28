Return-Path: <linux-kernel+bounces-747700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A127B136F2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE4283B5C1C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DF8221557;
	Mon, 28 Jul 2025 08:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PuVCWtNm"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22AC18C928
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753692516; cv=none; b=QPv7jzm4JPrL9BCVDmVGMLDHWb80T69B9jol2uA1xM4bFRA+AZEWDVyQAHEkNYGE4Wo90XhQFjhmhzqz10ROPPhvfRurs98m95GOdAoBW9h+uFOs3qSgwNFE7YswC5JUXbstS+DzbKy4mt8+NbpiUJ9ZOH14JzhK8Tr5XQneMmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753692516; c=relaxed/simple;
	bh=arOIL0ciNZJGHQKBzLiJUR0zN/sOECmImc37CfGLPw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQcmTZvcjCDhCbQIw66qZjumTJK9TXujGm2u0VvVeolXolBm7gHdWdXDx+ti4002wK7wB7JyBEou5x1lUBg+063CIU9xP3jsiEgqNdn8qBoqknD8r+sp55lFB+R3j97ApYV5x5tWtLXTZ/RpxTWM3ZG0Jc0WrREBRLWqB+6qX7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PuVCWtNm; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae3be3eabd8so887525266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 01:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753692513; x=1754297313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bR7c0ZAFAaKzyT27ZB0Kt8Fjp9yREUlIQznWSSclreI=;
        b=PuVCWtNmUVabecBAnAr2KUi+qhH/oMi+w7O2ZiUhrjXV7ABbL7LvBvObeNjiGK2S7b
         KObYG/AeycuoWTdLxndVgBIvDymrNiPO3ajiseVZP29Ikr2zu3xL/fE+1tExFOpdD0Mz
         qXt8LGV2ueE5eM80H8ZMWFNQFG/58nSOyNLEgnG2oqr+nz1jh/G+jPabIPc17SEsbrxk
         Cj1h4XvrB9ON3wgK5DbxLL1tR8UC/phs3TBBD2JUi24Pkp5Oen3PTxbrHRZOw9bHjbwv
         uFpTFXaerEmS+iAbc2JwEGAdY/2Q7YV9SsSo36n6G3rJWQArBYYGfn6+24GYbgDJ3dcg
         RBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753692513; x=1754297313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bR7c0ZAFAaKzyT27ZB0Kt8Fjp9yREUlIQznWSSclreI=;
        b=YMLi4CokEFkhM+gpdiq0/Iz11a75C66rXSlL7UMq2BeQEUNuRhXEY23JuOgVO+wTbO
         z628hNg6X0lhZKJx8AToZQdcl0j7MN1IHpReg36L8kk2KlMhU4sfXUrPPCb8nk4gL5XD
         2Di/v1f+zsHIcVv9WaSZUDGbTbbgbb/Bx1m9DGUEYDIUqIf3gSUw/k/mmrbw+htdPsYX
         frDF+uFtThd+BsPy2nGgD1ueO5R09jzqnaCC3mNjX7Sf26Fj5U7Irvc9Vy/TR3kWGm47
         JiSNNcvf0nqxe6UvoyzsWW8K+qOboaU5aIm7lFObc+6e9yWMvWrbb5vGWWfoTu8kY+PS
         piow==
X-Forwarded-Encrypted: i=1; AJvYcCWwcZT6wSM5MOPUYZgbMYXHggcoZ5jVe2UA5GBkWHjIvZglYLjNHk6lYd7qgjV3y2iZeKBiHHSM63ISkpA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3XrXY3RvBx3uahgc85/qrMSAOLtfsVMJ+EFOnuIr5xGDy4Ncm
	YIsE65Wfv5XDt2Ru/l/bPPtLQUTFZS6lSSK6OGFaDX8W5WM7pVTvXe0vUxi9TMyp9veXEhFMejY
	6sxMqJzw=
X-Gm-Gg: ASbGncvFR9yCe/RhHOcS0mdbeQNBgUfF8bxU9U7JYoV0Y/IA1xwDgBNL+QSf3e2PEKV
	Z2nAthR2pdvnuixcHLbl4HCPgGu26KN+iBQlLZY28oc28um24vILHaEGG1scELW7FqIirMRdSzv
	3U/YC7oPRtjmS9L6moIVRn4DQSHpiQ0PCrxn2BWhUj1KAQ20nJXWiUahvUMSuMLThiuxC84sKyv
	6RMArgwOsPB9dpvuNY4fzUaHtj9s68aXeWRgfiI7b1o6sYFyAI7uXWUtOOGJkF93A6G8z3qzTx1
	Il6qMIyd4el4CgDqa6xxzV5WjKN8HLnYQPWqwikoKhmVvokWRUDyBB5meQ1ao8sRvVMiefwqP7M
	kMdCXahWlbnUG74a75RNX3PxBdht3ofA1AbY=
X-Google-Smtp-Source: AGHT+IHi7H8NR8o28tIzJSeZI/+7HlESXaOn9KT46vVqBAUj4Gay+LjMHcsh9y9oWHszFX14+DDgrA==
X-Received: by 2002:a17:907:1ca2:b0:ad8:942b:1d53 with SMTP id a640c23a62f3a-af4c4908882mr1459481766b.27.1753692512525;
        Mon, 28 Jul 2025 01:48:32 -0700 (PDT)
Received: from localhost (109-81-20-172.rct.o2.cz. [109.81.20.172])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-af63586008dsm394972366b.16.2025.07.28.01.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 01:48:32 -0700 (PDT)
Date: Mon, 28 Jul 2025 10:48:31 +0200
From: Michal Hocko <mhocko@suse.com>
To: Oscar Salvador <osalvador@suse.de>
Cc: david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: Re: [RFC] Disable auto_movable_ratio for selfhosted memmap
Message-ID: <aIc5XxgkbAwF6wqE@tiehlicka>
References: <aIcxs2nk3RNWWbD6@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIcxs2nk3RNWWbD6@localhost.localdomain>

On Mon 28-07-25 10:15:47, Oscar Salvador wrote:
> Hi,
> 
> Currently, we have several mechanisms to pick a zone for the new memory we are
> onlining.
> Eventually, we will land on zone_for_pfn_range() which will pick the zone.
> 
> Two of these mechanisms are 'movable_node' and 'auto-movable' policy.
> The former will put every single hotpluggled memory in ZONE_MOVABLE
> (unless we can keep zones contiguous by not doing so), while the latter
> will put it in ZONA_MOVABLE IFF we are within the established ratio
> MOVABLE:KERNEL.
> 
> It seems, the later doesn't play well with CXL memory where CXL cards hold really
> large amounts of memory, making the ratio fail, and since CXL cards must be removed
> as a unit, it can't be done if any memory block fell within
> !ZONE_MOVABLE zone.

I suspect this is just an example of how our existing memory hotplug
interface based on memory blocks is just suoptimal and it doesn't fit
new usecases. We should start thinking about how a new v2 api should
look like. I am not sure how that should look like but I believe we
should be able to express a "device" as whole rather than having a very
loosely bound generic memblocks. Anyway this is likely for a longer
discussion and a long term plan rather than addressing this particular
issue.
 
> One way to tackle this would be update the ratio every time a new CXL
> card gets inserted, but this seems suboptimal.

I do not think this is a usable interface.

> Another way is that since CXL memory works with selfhosted memmap, we could relax
> the check when 'auto-movable' and only look at the ratio if we aren't
> working with selfhosted memmap.

This is likely the only choice we have with the current interface. We
either need a way to disable the ratio altogether or make it more
automagic and treat self hosted memory differently because that memory
doesn't eat up ZONE_NORMAL memory and therefore cannot deplete it for
ZONE_MOVABLE.

Lowmem (ZONE_NORMAL) oom problems are still possible but kinda
unavoidable no matter what the hotplug interface is as the CXL usecase
really needs its memory to be movable to operate it as desired AFAIU.

> Something like the following (acthung: it's just a PoC)
> Comments? Ideas? 
> 
>  diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>  index 5c6c1d6bb59f..ff87cfb3881a 100644
>  --- a/drivers/base/memory.c
>  +++ b/drivers/base/memory.c
>  @@ -234,7 +234,7 @@ static int memory_block_online(struct memory_block *mem)
>   		return -EHWPOISON;
>  
>   	zone = zone_for_pfn_range(mem->online_type, mem->nid, mem->group,
>  -				  start_pfn, nr_pages);
>  +				  start_pfn, nr_pages, mem->altmap);

Shouldn't this be a more descriptive (enum like) argument?
ONLINE_MOVABLE, ONLINE_AUTO etc..

-- 
Michal Hocko
SUSE Labs

