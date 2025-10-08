Return-Path: <linux-kernel+bounces-845578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA4BBC56B1
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 16:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08FFB188DDFE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 14:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8126F29C343;
	Wed,  8 Oct 2025 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="VHdp7bKL"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C9E2989BA
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 14:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759933116; cv=none; b=V2hKz/11eCjVc9SDhAeAlzKG2PsghpowaMRy3EWwsdeYPznkLJqH9Tqsp2x2qk5nPxyMjUiUmd5M5/g761klZJCKWrKQ9jMG+46V4LBvVk1QJCSv9s3VqybGIpU7Z9CU91eMoeN84Utf61PPQKqBwp1lI3sLa526/TF8UJp2YuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759933116; c=relaxed/simple;
	bh=dBoanlnE/kFlixsj+N7u+C4Z7KMpeDGfloepU+PPEJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U684XgO7AWY3y7c9uN4keQb9BmJT0aqdP4E2PMKxyklmkPzPlzFj+BA35hEGRFSWFFzS/xQ85UC8pMGBEGvSepqKZVYnKVfZOCEilVxNBKMj5WqMAnORWUoqcX4FdD6MJeIvjgBFc3Jt9OzoCGdNnFbSG5+v+3VurbVJuBaN4Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=VHdp7bKL; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-7ea50f94045so9605216d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 07:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1759933114; x=1760537914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5QJIQKG0sT9rZgBfipH2pnXvFssK3HlZCOf/vlaj8bs=;
        b=VHdp7bKL5g0CKP4voEaQfrlOikUGCd05QtJgxrMmnjfDrYVx+58R+IbJucANt60AQ+
         lMslHiMZzbHODXxDDECSjFgdYdIJ9GyVPqj0wRLRoew4NGIgSBu/+LlDa4HzEXdDuICy
         NWZ9SqWKiqhTfnxagGH6OmthmCmYVLw7TI+sFFdq0HBbCIKKmx+a0v+9rJaMFJr4RNn6
         1JpeWYK/sQ4aZWokfoxPx6AvAKuX87QgNRo0FZGLe5IFDqSPAtCuQMfhMvofVEoKU6et
         EPHXCTXJUJJWxfOFNhUYgnrWwr6EGcJyJZyyHOHw2IzdVDHVFvWJm6JuTmS1q4gPDaW5
         Ehdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759933114; x=1760537914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QJIQKG0sT9rZgBfipH2pnXvFssK3HlZCOf/vlaj8bs=;
        b=jd9st2vukJmBbrOtm3/tIX5uoGWNuF3Aqx0gZDeQ2ZbFRnE1Di5rk2M+KL7rqOgv68
         C/2dASRR2uoPUTbSpA1wDCEqiKql7yBs3M1MPhSyhFhLJFEGGznxsSL2nBlQkWACqL+0
         M73KQWkjy/sLpUyRkWcXJe0BYjGBGaE2T73kX2HRqbreUaZpethOr7UnArayQcT/J4+t
         8Xn85c85H0VPfKNL9NG3QfxF8l3kHQ9uXUr1GyxaRTwJv3fUz5oYmKdUszjwB86sfbGu
         oObV3heOeUG06awmOCNr82amCZiG+AtelwhUmHqHlA84q4vNLErW8VjyPfdpw5w5s/In
         kjpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXiQFqETYvCgUUWPgS4C/2Y9AoD2mlBTAJ0SdRy1VrEB54iWF6R95zwA9IOU3URb6HimA1dNnZi083SFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnDhpfTNw7Yphss40FqX0ji/zWXlSAD2lKCt/Vid4Mgs6IsmH3
	wNC4cNfaOO0cevMtPmjuDK5oWcuk5psdJpYXN7zo3DA96dZIYoMncAnkYSFx/uYfBy0=
X-Gm-Gg: ASbGncuN5VeooymXUb1HuO8i5ABM6r4sC81mjrvgqBmI4y07ykRPEQ+lvTUhfkM9k6e
	/wuC0vNxfi4trSF66B791vTexcG+czhX5ja/WNAQxuUAaqff8ozUYLvPVpXTAt+ZrdXMmG0ApPP
	HpW4c9PzOcp6EUrbOFhpXAidvoNcNdeGMQQp1H/mlN64pqqTScHFy09ejBV9ujH+y2fpx4y1sof
	FNUI8CsTBClDiVMl2dkx9xxTpvfJTosrkY3UL0jgw8efOgU8sBw8xTcOuzpQdKxVFTSM6rsaQ3X
	kEawz/vvL8cGktVKP5365gOIEfsNx0lKqW9r226sdNrLr2U27eq9Iejl4o+KzI/e4tNa5hwVYJr
	KVBS68Z0XCw24GPSLLqz7j89Gdf+FizvXqvvZ24Q416EX4Xv2cuLghBbxIyK4Nru9Sw9V3ZQ3nh
	DHX5wKJ+WYJWGruZ3cx3GNl9oY9FJddF8d9mbgwCr0dom1IdkhTxQ=
X-Google-Smtp-Source: AGHT+IFNKG/GrbiRc1bEn8TWwx08M4SbG5dcVn/TJ2EzZl4DHVGIFZ6s6jij2fTulKfOfOsdd1koyg==
X-Received: by 2002:a05:6214:2027:b0:802:67ee:bdae with SMTP id 6a1803df08f44-87a052a63a4mr114908286d6.25.1759933113566;
        Wed, 08 Oct 2025 07:18:33 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bdf53134sm162645246d6.55.2025.10.08.07.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 07:18:33 -0700 (PDT)
Date: Wed, 8 Oct 2025 10:18:31 -0400
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, corbet@lwn.net, muchun.song@linux.dev,
	osalvador@suse.de, akpm@linux-foundation.org, hannes@cmpxchg.org,
	laoar.shao@gmail.com, brauner@kernel.org, mclapinski@google.com,
	joel.granados@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
	Michal Hocko <mhocko@suse.com>,
	Alexandru Moise <00moses.alexander00@gmail.com>,
	David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] Revert "mm, hugetlb: remove hugepages_treat_as_movable
 sysctl"
Message-ID: <aOZyt-7sf5PFCdpb@gourry-fedora-PF4VCD3F>
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

On Wed, Oct 08, 2025 at 10:58:23AM +0200, David Hildenbrand wrote:
> On 07.10.25 23:44, Gregory Price wrote:
> I mean, this is as ugly as it gets.
> 
> Can't we just let that old approach RIP where it belongs? :)
> 

Definitely - just found this previously existed and wanted to probe for
how offensive reintroducing it would be. Seems the answer is essentially
"lets do it a little differently".

> Something I could sympathize is is treaing gigantic pages that are actually
> migratable as movable.
> 
...
> -       gfp |= hugepage_movable_supported(h) ? GFP_HIGHUSER_MOVABLE : GFP_HIGHUSER;
> +       gfp |= hugepage_migration_supported(h) ? GFP_HIGHUSER_MOVABLE : GFP_HIGHUSER;
> 
> Assume you want to offline part of the ZONE_MOVABLE there might still be sufficient
> space to possibly allocate a 1 GiB area elsewhere and actually move the gigantic page.
> 
> IIRC, we do the same for memory offlining already.
> 

This is generally true of other page sizes as well, though, isn't it?
If the system is truly so pressured that it can't successfully move a
2MB page - offline may still fail.  So allowing 1GB pages is only a risk
in the sense that they're harder to allocate new targets.

It matters more if your system has 64GB than it does if it has 4TB.

> Now, maybe we want to make the configurable. But then, I would much rather tweak the
> hstate_is_gigantic() check in hugepage_movable_supported(). And the parameter
> would need a much better name than some "treat as movable".
> 

Makes sense - I think the change is logically equivalent.

So it would look like...

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 42f374e828a2..36b1eec58e6f 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -924,7 +924,7 @@ static inline bool hugepage_movable_supported(struct hstate *h)
        if (!hugepage_migration_supported(h))
                return false;

-       if (hstate_is_gigantic(h))
+       if (hstate_is_gigantic(h) && !movable_gigantic_pages)
                return false;
        return true;
 }

And adjust documentation accordingly.

I'm running some tests in QEMU atm, but it's taking a bit.  Will report
back if I see issues with migration when this is turned on.

If that's acceptable, I'll hack this up.

Thanks David,
~Gregory

