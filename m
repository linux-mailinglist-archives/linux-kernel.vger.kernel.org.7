Return-Path: <linux-kernel+bounces-760285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E991FB1E8F7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 15:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B64007B1232
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 13:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0DD27BF6C;
	Fri,  8 Aug 2025 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCDxMaHL"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5BD279DA0
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 13:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754658772; cv=none; b=aP8KbgW0/OKPBFjJT7Y7c5zn7WawnWefW40lx/4LzxwBoA92eriHwLFvxdYwp+KGDWplTcFelWeBqtq5ludGr5LA4WZlyoe1axEU6WYJoBzN6HpALApe/2XUI1HMnggZHy6M2rIi5bhC4Mg9dLsu4RS7Zm+Ikd5NRGxDjRkSwpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754658772; c=relaxed/simple;
	bh=zNIupezHLNIBSWnabwse+t3inxhcFfq2Na/DYEEYqug=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZ1w2aEtsxboia/AnmayoniG/RI3AAyrEZ2SBDHPvKMLBxEKtblSozHWuvclr8HV4s1btoUfcSGiiFrGlD0haLn5bzSVUZSnATrQeUQzowrO+TvKTxstSadlWalRiKM9iun9L8m9EMSURbIvsub8jPJPs23Jl216mjfDKi0QIV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCDxMaHL; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-33211f7f06eso22804071fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 06:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754658769; x=1755263569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ttVrBE0Ue08luLt7PutqjyPNAQbrHDVeznsyVuSrlxg=;
        b=NCDxMaHLgtY1vvx7WPDIRqMEPuRhlzPNczrULQWUasV3Ljum4kVMmy29FACoWdMsNh
         6aLhj8JrZn5P0x2CWAklnlK0Olz0Iz5Wufl+5mh+t6uVa96tex9Bt1gLf30qx3ykYKnM
         nLMf+k0Yp/DsBuGR7DKI1BdBUHEk5sBPMGYv5tqRBxYFd0+tno1kVVIOG1st4SOdoat5
         Dz6eKyBTnqg4/j6Xu4ZRodRGAEoMg2dWd9EZez7cdF+VJ99YWU2ynWEycmFU699IhhMi
         TGDYlzLup/dtpZRq5jiI8G22KaEWesIkkoipumRYnSGGXgxCYd5PxA5ZLK5JGh2F2cwg
         mzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754658769; x=1755263569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttVrBE0Ue08luLt7PutqjyPNAQbrHDVeznsyVuSrlxg=;
        b=C4CFsqfMPGyCEfu/EVS3s+wylBQo0PyHhtHOZFHPdEX91ouy+yymD8UMD9YBycBLEJ
         UBIYqGlDczmILyfpj942q2ucNi0UeBvqxLtlcwnvyxeLzoF6/XN3G2REtyp+YqLcAQ3x
         37+PhWhAi0JM1gtCnsFFrMPK6Q8qVYao1oLfoi01CZg3O3fb8c1W+7FSvIkR9zpneBkk
         tFILJNrr3SeJKk5pA29HciObIeUu4RU78soYkhgOlegSNNnYCxHX403AWJnCMyMt7Y4s
         vHtFIJkCFCdHNzKOoOpFBVuh4QG5Lkv1+vZ6TxUVAnYC70HBMJ1UP2xlBmyYesKqExZd
         pvEA==
X-Forwarded-Encrypted: i=1; AJvYcCVpUWH8VtCFmpDd/hy19DslOWjmYSLe+W3h5PGLDa6koCaAGHmjkZ4M01d7AvvWNKrYpKhot6FEHfYy3NU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkdlXWSXAfMUmyRIunnBiuBH0fV7b4cJRK5i79McPclYaR8TV1
	1WvAVH1AmZqXJQiOI2MEjxMbsO2qfaX70ktfvyGg1mco4dw8SJro7QII
X-Gm-Gg: ASbGncsHwdyYe/UJ6bLOa0wKAB+WJ4tDNOuggTLFjvzhR6j/GMCy0kCLfgVQ/8i8hB7
	NeCcVFBF9Ll0btEC2oCyseYxWnAGNsCCOcPVfhqshqkI/2HKfy1x08Y5RGqxByQmT2ccUCdhwUT
	NTtSkBgg0cLsoJjgJFiGAPBEKm2Y6GF8PlMYYGiGpiRCLHVX19CjjAq+sMGWcG1jPQXuL+Y9K1F
	WIk/AOzWqkzh+nkVDetKDDAfWVO36V21TkRKyAYcGUQbe/Dsd4zwN9vgU2W3vZPdMrvzuMPDgr5
	EO5WfNfU0e3QeaffgkML6o56PBX5FhC/i2lLxgoRftcwhXUFs76k4xqWU/K85clFrV+ZM/TGSyx
	LLqt1acHuHfXdw5ZKRWM5CE3GcH4TQSAX/SOMH3AZeQYfEw/Cpw==
X-Google-Smtp-Source: AGHT+IFo5CmOaefgqERYR5w2etAP0DixW0V4maBkIDaveu9VDAFqJz7lV8siIMn1mI1paEnDDReD4w==
X-Received: by 2002:a05:651c:410f:b0:32a:6b16:3a27 with SMTP id 38308e7fff4ca-333a225c879mr4486721fa.35.1754658768325;
        Fri, 08 Aug 2025 06:12:48 -0700 (PDT)
Received: from pc636 (host-90-233-217-11.mobileonline.telia.com. [90.233.217.11])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-33238272944sm28012901fa.13.2025.08.08.06.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 06:12:47 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 8 Aug 2025 15:12:45 +0200
To: Michal Hocko <mhocko@suse.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 8/8] mm: Drop __GFP_DIRECT_RECLAIM flag if PF_MEMALLOC is
 set
Message-ID: <aJX3zbr8QsIs1LOw@pc636>
References: <20250807075810.358714-1-urezki@gmail.com>
 <20250807075810.358714-9-urezki@gmail.com>
 <aJSU3O-pUnTnl_wP@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJSU3O-pUnTnl_wP@tiehlicka>

On Thu, Aug 07, 2025 at 01:58:20PM +0200, Michal Hocko wrote:
> On Thu 07-08-25 09:58:10, Uladzislau Rezki wrote:
> > The memory allocator already avoids reclaim when PF_MEMALLOC is set.
> > Clear __GFP_DIRECT_RECLAIM explicitly to suppress might_alloc() warnings
> > to make more correct behavior.
> 
> Rather than chaning the gfp mask would it make more sense to update
> might_alloc instead?
> 
Hm.. I was thinking about it but decided to drop the __GFP_DIRECT_RECLAIM
instead just to guarantee a no-reclaim behaviour, as it is written now to
the flag.

From the other hand after this patch we would have some unneeded/dead
checks(if i do not missing anything). For example:

[1]
    WARN_ON_ONCE(!can_direct_reclaim);
    /*
     * PF_MEMALLOC request from this context is rather bizarre
     * because we cannot reclaim anything and only can loop waiting
     * for somebody to do a work for us.
     */
    WARN_ON_ONCE(current->flags & PF_MEMALLOC);
[2]
    /* no reclaim without waiting on it */
    if (!(gfp_mask & __GFP_DIRECT_RECLAIM))
        return false;

    /* this guy won't enter reclaim */
    if (current->flags & PF_MEMALLOC)
        return false;

[3]
    /* Caller is not willing to reclaim, we can't balance anything */
    if (!can_direct_reclaim)
        goto nopage;

    /* Avoid recursion of direct reclaim */
    if (current->flags & PF_MEMALLOC)
        goto nopage;
etc.

But, yes, might_alloc() can be modified also.

--
Uladzislau Rezki

