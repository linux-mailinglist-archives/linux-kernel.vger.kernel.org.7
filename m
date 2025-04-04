Return-Path: <linux-kernel+bounces-589270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8831A7C3F2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 21:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A849A17BE71
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 19:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E5621D3DB;
	Fri,  4 Apr 2025 19:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="r2iv0ef4"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B040221D3E2
	for <linux-kernel@vger.kernel.org>; Fri,  4 Apr 2025 19:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795492; cv=none; b=FW093glcvmVnztWLLozcCjLazLWDubT7BLR0G9V3+mvDz5m4wIqWXlWAJx5ASe8BArhO5BmwCUorS9Y12QaZ314VTKSxKDTkzygg8T+VmcbmQYRWKMWvlCUZouyfkCwi6Hz4ZX2uRPFgRj5bgLLbvR4QmIk9IPP1QZKXmowPfFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795492; c=relaxed/simple;
	bh=OWnTUtIeczm0jQ3tLKOSnVG07QY4zxIxvceyWqq7Rcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjD3ew7EriranteY3RZehAWNrCw75S041CGqIMkuYNq3NLyHSgrl7r7vhW7umxNZzVxhQRAt40ZJ5ZQJWaEnJfE9ALURbQ0qykvCZi7yZmYQfYExtjs6cn3qRJF07v4zHZY/veB4B9a/EfRFP9Xxkz0gPxaX6oQiarinhnFtuOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=r2iv0ef4; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-47662449055so13163181cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Apr 2025 12:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1743795487; x=1744400287; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n4jU9dZ1c7Yovc2ioTyNiJ82SX9/E9otfhXZzP1ZTJc=;
        b=r2iv0ef4yKGEl8X3YPULea59OGt/Ztw4Gnxff+mVXhI+yZzM/xSWJe7xTVcbuvQksn
         bX6jgrjiPcN+CI+GZX+ot2UMdjau0j1fP8SKQvL74Z9yi7+0faDXca8k/rRJ5ZLbqmgW
         9H9Vzr/wj3tdiPmrEsN7PsnoesYqHtoOZ6lFANaUqfh6O6Gjz96zf492Yh8pYC05Qs6Z
         CPD4P16Z+lr1quV7ZZHx+dOl5pT0pbYWDblD0kJjjymm04T/59RBEttaJUmY4mWx2l+h
         WXOLQPwZ3P2q30CYFpn6bhNYetcdoFeEmkyQct6WNmZ/7iaXdoJQETbQPPRQrvZofMJy
         OHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795487; x=1744400287;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n4jU9dZ1c7Yovc2ioTyNiJ82SX9/E9otfhXZzP1ZTJc=;
        b=BJjbEX/3oPtbBzy4dxDHbPYkOzutY4seNXgNsjHXQQFnXyPZcIBRjr9+MsA54yynjB
         AbMy9pkP9e9eF0TspCYTdzVNQC3fzWu9qv72auCMhD3J38X2bnTFTPF94+QtpcU1OpDw
         JIdz3ZLaSPe5n0hs2PhXx245ONYVPWZJt95L83nd1o3RIzTNcexn4mHFphlOcsq6gmBV
         k84R+fa0kaLALLf/H09Cp0MEyYN5C8RL/VnQtJR/yUy1lYXdUu5A6GK3DfOCzYVS3Ooi
         rxfp7Cb6fDvwEB01+10HyYZdvycFdyTwRiY5XtmwZxhbNuKYWNHN6fYASgQO4KGL3aAJ
         eLbg==
X-Forwarded-Encrypted: i=1; AJvYcCWNV6WwqMnYh1w1w4u1EQFE+f0NvugK4zpkDm3/kZ4BOfKUecMvF2cPUZDKvpPN+w/A8J/4QvcynAFN1UI=@vger.kernel.org
X-Gm-Message-State: AOJu0YySeuyxioIsR/ThjeA889o39bTYOm44YQpc3L7/nti6vTuK9M5r
	NLaNhoAvfT3WyT9C4bt+SGq9B0yI6YdWiK3kHz46Emj30agpQMIp7k5kl0ishIWTRA2LxyJOe3X
	K
X-Gm-Gg: ASbGncuZGTLdmKNWanz9iqYmj7HE6ckIcG2yaw9rwUPaw84vPt6NBpL5Dsev9VmMyWV
	Ls4xOj5zBdpTrErJg9EQcD/zfsFAByYSuVEilxNbKag02v8kM1ekQBqG0H68tPBDqnQ3fCzYMHe
	TJrv5e+wfiN372o514hnHAQjTZ0rwI7xYsx8x2Pw2gP2oXFzeiUABf4L9gpCmHao/87z7Aegc34
	E+jOb0hnr5vXW4DYAI8NdWexzPe2HKJ/4ivkQ46zgMk9X4sfW2aDOGhpmE+ZXImN/vKX/M624fk
	vshDMn4UoMl/kUuj2KUG6Vdc++mV7PFjq0AZ9w/k96Q=
X-Google-Smtp-Source: AGHT+IFiV5JEVHf/H5z/o5TJU4SUbRPdcSgoWSnaiXwlzx82DlAB9Nhd813vrtCnLKQxfZsESH38BQ==
X-Received: by 2002:a05:622a:1a27:b0:476:8a83:960f with SMTP id d75a77b69052e-4792595086emr52294121cf.17.1743795487399;
        Fri, 04 Apr 2025 12:38:07 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4791b142b9bsm25853551cf.66.2025.04.04.12.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 12:38:06 -0700 (PDT)
Date: Fri, 4 Apr 2025 15:38:02 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Waiman Long <llong@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/2] memcg: Don't generate low/min events if either
 low/min or elow/emin is 0
Message-ID: <20250404193802.GA373778@cmpxchg.org>
References: <20250404012435.656045-1-longman@redhat.com>
 <Z_ATAq-cwtv-9Atx@slm.duckdns.org>
 <1ac51e8e-8dc0-4cd8-9414-f28125061bb3@redhat.com>
 <20250404181308.GA300138@cmpxchg.org>
 <c4294852-cc94-401e-8335-02741005e5d7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4294852-cc94-401e-8335-02741005e5d7@redhat.com>

On Fri, Apr 04, 2025 at 02:55:35PM -0400, Waiman Long wrote:
> On 4/4/25 2:13 PM, Johannes Weiner wrote:
> > * Waiman points out that the weirdness is seeing low events without
> >    having a low configured. Eh, this isn't really true with recursive
> >    propagation; you may or may not have an elow depending on parental
> >    configuration and sibling behavior.
> >
> Do you mind if we just don't update the low event count if low isn't 
> set, but leave the rest the same like

What's the motivation for doing anything beyond the skip-on-!usage?

> @@ -659,21 +659,25 @@ static inline bool mem_cgroup_unprotected(struct 
> mem_cgro>
>  �static inline bool mem_cgroup_below_low(struct mem_cgroup *target,
>  ��������������������������������������� struct mem_cgroup *memcg)
>  �{
> +������ unsigned long elow;
> +
>  ������� if (mem_cgroup_unprotected(target, memcg))
>  ��������������� return false;
> 
> -������ return READ_ONCE(memcg->memory.elow) >=
> -�������������� page_counter_read(&memcg->memory);
> +������ elow = READ_ONCE(memcg->memory.elow);
> +������ return elow && (page_counter_read(&memcg->memory) <= elow);
>  �}
> 
>  �static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
>  ��������������������������������������� struct mem_cgroup *memcg)
>  �{
> +������ unsigned long emin;
> +
>  ������� if (mem_cgroup_unprotected(target, memcg))
>  ��������������� return false;
> 
> -������ return READ_ONCE(memcg->memory.emin) >=
> -�������������� page_counter_read(&memcg->memory);
> +������ emin = READ_ONCE(memcg->memory.emin);
> +������ return emin && (page_counter_read(&memcg->memory) <= emin);
>  �}

This still redefines the empty case to mean excess. That's a quirk I
would have liked to avoid. I don't see why you would need it?

> @@ -5919,7 +5923,8 @@ static void shrink_node_memcgs(pg_data_t *pgdat, 
> struct s>
>  ������������������������������� sc->memcg_low_skipped = 1;
>  ������������������������������� continue;
>  ����������������������� }
> -���������������������� memcg_memory_event(memcg, MEMCG_LOW);
> +���������������������� if (memcg->memory.low)
> +������������������������������ memcg_memory_event(memcg, MEMCG_LOW);

That's not right. In setups where protection comes from the parent, no
breaches would ever be counted.

