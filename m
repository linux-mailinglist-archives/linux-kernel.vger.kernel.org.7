Return-Path: <linux-kernel+bounces-789692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2DCB39937
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD2891786FC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF833090E1;
	Thu, 28 Aug 2025 10:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hD7qthLA"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0753081D2
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 10:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756375786; cv=none; b=lwdW1KgsokmRYeMoUgOSaAjotRlYzavMloOHWuQxnv/8OHyUQignkPB7b1LrqNvLypQwjAbfU3TcsY2G5ph3mzKkYZHcodNqAZRytiLulQMb8d5kKKx9v2R6HisE42qIvF1lP2+xc9Ex/Obs/L8rkWzLDB6EQJ5x+XUC/o2fwsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756375786; c=relaxed/simple;
	bh=8jdiDqybP1rNyJexix7rs7AjqI+q7J16imZahw8LOIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4Aqz5G8gMhIuNEJcrIRrz4r40oFU9Cu4ClRAz9MeCLkQ2bXHQfsfdZ6vBln6zLartrzQp/mjM4qHwVEQqbPyERe4A32g4jeOIU1S5RdKH590rILkf5cRsgJrKw1OA93AA1zx74W6k6zKh/BzB86REqxrp9MrUSlB3OklDTQZ3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=hD7qthLA; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3c46686d1e6so459419f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 03:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756375783; x=1756980583; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UxO8AVYywtt3WFeQdWxvD+biuxcMZ9Aq3qNXesryy44=;
        b=hD7qthLAunDze5NjbMlKA6/Wgm4ER6Za39cof1DifsJ16dXvQbAsfImFHrTQ7Gnz99
         tbCpTW3hx+2R9BkFpqpAjDNdeBopBoqMn7ywpb2x5AQLwX/eKl6I00hIUI0x/B0anjhB
         yenLVMuhSZI76cWRwAi71dZUBlqQJFehlsCO85a5v3NsiK4A5AOGB9Df9CBuxMXq4i0q
         tbrboCYMMtnZz3ZVb4YK3fuRVofpeu2xPBkV06S/UxKONhu/lSAJasLd74R1NHqbaCAG
         fqDUoWN3ZNuPuzcHGUauCGlsg6nW+aZtnC7R0JbrRNdqyIACdGfORLbDJ40FRZun2Ff/
         dHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756375783; x=1756980583;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UxO8AVYywtt3WFeQdWxvD+biuxcMZ9Aq3qNXesryy44=;
        b=lRW1KyZ0QOG8Re/QqKfIK622s7hqBDy08daNJLPMFsvfWXeroKQWxa+bpWYoP4+xag
         zgJFCHkwFxkSq8X2xWqwhM9cX/2QuNNgK4/1zbf8tM1NJ3nF2QL+ZAQFfroPniae6bvq
         wWFwQt2mhTc1ncHaaKTnXP2pIshumR7sw6Hml3fXI9S/K497nO2oCPzzIL2ymcFrywmK
         ZFUlb2mhywUA/5mSMp3xUxScBijD9WNJkC8Q8MRolhwrgyFydGplI9p4ePPIbiUpZ4vo
         whnVCJWX+cLoDNnfTKYrFh0tWq1q0xnw+ZybdWdwCKamrFuqBWI1igtwK0ZzsLHZXje7
         7aEA==
X-Forwarded-Encrypted: i=1; AJvYcCXT1BGA+8JGrIeW+Q349U3YNcxEV1Lq50X+3nmdF5As8rb8LRW18WE0BONI5pDCj7iufsmN7u0sffHZNZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBdK7xKQxwZNCIrRcZB1kIuvJFMedVigLtFS7ZyddW1ScQq+BO
	pZ6XrMS9+5Jh5jQmGFnRR/1EJwITyTtVxnDpBQV8nCHUFBEqsJRKSOyyRkwbehvKJs0=
X-Gm-Gg: ASbGnct6z83PKvn1dZ/KE3bCvApQdnfMFe5hGPBHmMlyDN68Xhjd2HyrDqXhqXfFtOk
	p9hTuFC9tLOXC7k23gCDCdhzQsXFra+nTRZUu1JOekikQATjlOiwsbWrbBpT6PGKegLB7KPX7/q
	GdVtpMVij5p6OtQNjYCM2WFLFnX2rj4NUK+ZJjpB2+KJPAa8lnrw/5tRY8aBnfElZAgHlPiDPCs
	cwnBdHQPu2IfIBWFfc3nFuoko4+MCf+j8JP0V32fVko9AWG33ECCI6TzsHgKrAbHt581cRRoWUV
	6tQc5Afdbcn/lBuR90Pkv7q9QM0R0jXcHHAK0CtFolNi5l0RozrjrRHWx1CnuI8EhRCVbY721LJ
	eZUxreUUQweo9Y3sjF9zAXjhFrKfk85hDhd+ctIAXBP58gFHK3G4r9Qel
X-Google-Smtp-Source: AGHT+IG1bgAvLO+S+tRFi0k2B+ex+LKH/y8F2ck7rpkxCTrTkkjnj8LahK98IeLP5+ayEiaJgPZMqw==
X-Received: by 2002:a05:6000:240e:b0:3c8:9bb6:ac42 with SMTP id ffacd0b85a97d-3c89bb6c170mr10721965f8f.32.1756375782585;
        Thu, 28 Aug 2025 03:09:42 -0700 (PDT)
Received: from localhost (109-81-86-254.rct.o2.cz. [109.81.86.254])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b6f0d32a2sm73554565e9.9.2025.08.28.03.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 03:09:42 -0700 (PDT)
Date: Thu, 28 Aug 2025 12:09:41 +0200
From: Michal Hocko <mhocko@suse.com>
To: Weilin Tong <tongweilin@linux.alibaba.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, vbabka@suse.cz,
	surenb@google.com, jackmanb@google.com, hannes@cmpxchg.org,
	ziy@nvidia.com, linux-kernel@vger.kernel.org,
	baolin.wang@linux.alibaba.com
Subject: Re: [PATCH RFC] mm: Use pr_warn_once() for min_free_kbytes warning
Message-ID: <aLAq5TaqdR7GQB6J@tiehlicka>
References: <20250828030602.204332-1-tongweilin@linux.alibaba.com>
 <aK_7GKJ4BWjye4tZ@tiehlicka>
 <35e0a580-ae78-4485-b285-7f71f91e046d@linux.alibaba.com>
 <aLAj-itGT9DD3SU3@tiehlicka>
 <9639adfe-13ba-4c27-8ba6-8bf3e2190450@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9639adfe-13ba-4c27-8ba6-8bf3e2190450@linux.alibaba.com>

On Thu 28-08-25 17:48:54, Weilin Tong wrote:
> 
> 在 2025/8/28 17:40, Michal Hocko 写道:
> > On Thu 28-08-25 17:23:40, Weilin Tong wrote:
> > > 在 2025/8/28 14:45, Michal Hocko 写道:
> > > 
> > > > On Thu 28-08-25 11:06:02, Weilin Tong wrote:
> > > > > When min_free_kbytes is user-configured, increasing system memory via memory
> > > > > hotplug may trigger multiple recalculations of min_free_kbytes. This results
> > > > > in excessive warning messages flooding the kernel log if several memory blocks
> > > > > are added in a short period.
> > > > > 
> > > > > Sample dmesg output before optimization:
> > > > > ...
> > > > > [ 1303.897214] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
> > > > > [ 1303.960498] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
> > > > > [ 1303.970116] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
> > > > > [ 1303.979709] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
> > > > > [ 1303.989254] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
> > > > > [ 1303.999122] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
> > > > > [ 1304.008644] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
> > > > > [ 1304.018537] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
> > > > > [ 1304.028054] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
> > > > > [ 1304.037615] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
> > > > > ...
> > > > > 
> > > > > Replace pr_warn() with pr_warn_once() to ensure only one warning is printed,
> > > > > preventing large volumes of repeated log entries and improving log readability.
> > > > pr_warn_once seems too aggressive as we could miss useful events. On the
> > > > other hand I agree that repeating the same message for each memory block
> > > > onlining is not really helpful. Would it make sense to only pr_warn when
> > > > new_min_free_kbytes differs from the previous one we have warned for?
> > > Thanks for your feedback!
> > > 
> > > The dmesg output above comes from hotplugging a large amount of memory into
> > > ZONE_MOVABLE, where new_min_free_kbytes does not actually change, resulting
> > > in repeated warnings with identical messages.
> > Yes, this is clear from the changelog
> > 
> > > However, if memory is hotplugged into ZONE_NORMAL (such as pmem-type
> > > memory), new_min_free_kbytes changes on each operation, so we still get a
> > > large number of warnings—even though the value is different each time.
> > We can check whether the value has changed considerably.
> > 
> > > If the concern is missing useful warnings, pr_warn_ratelimited() would be an
> > > acceptable alternative, as it can reduce log spam without completely
> > > suppressing potentially important messages. However I still think that
> > > printing the warning once is sufficient to alert the user about the
> > > overridden configuration, especially since this is not a particularly
> > > critical warning.
> > The thing is that kernel log buffer can easily overflow and you can lose
> > those messages over time, especially for system with a large uptime -
> > which is far from uncommon.
> > 
> > I am not entirely enthusiastic about rate limiting because that is time
> > rather than even driven. Anyway, if you can make ratelimiting work for
> > your usecase, then no objection from me but I would rather make the
> > reporting more useful than hack around it.
> 
> I agree with your suggestion.
> 
> With respect to your suggestion that “we can check whether the value has
> changed considerably” I would like to seek your advice on how to define what
> constitutes a significant change in this context. Do you have any
> recommended criteria or thresholds for determining when a difference in
> min_free_kbytes should trigger a warning?

No really. Certainly increasing min_free_kbytes by 1% would be barely
noticeable but 10% might show some difference. This will likely need to
be tuned on real life usecases so start with something and we can tune
that based on future usecases.

-- 
Michal Hocko
SUSE Labs

