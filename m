Return-Path: <linux-kernel+bounces-819137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07046B59BFB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38F6A176355
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1637317708;
	Tue, 16 Sep 2025 15:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PE/VZWHY"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE642266A7
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758036198; cv=none; b=XuZNBl410TU3GCHdk8gllLfdpWdEdB35pkrCiwafKxlkfuurq5+mhzQ11WOqxHBfpzd/YdElnshILwWNMm4mKx4Ysg2rqLwxLH9cdCwJ2jQOVCgLsUQREF0rjdWotlfKFQ0uLB3uwaWpvXRDTWvuizjhRrMJb6WsDtoGnp1/cc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758036198; c=relaxed/simple;
	bh=n/Yap0mMZI6PAfAGNazMJTaTVHxM9I1l1vU8l5AZ8fM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czmfuN9oy89WZn+7RvqwboJYRXxzMgQtbEBNaMUzh+O64LHFNOSLqkLphMsW4gzmymao4L0AIU5C4JtzYkfNK+xXWXD5w98pq6Z14ST7XfRNGRU9Wg3J264lwRChDOhp3XrBExh0ygZ4Awaaj5HyIdGyuyK9T6PQKPumngOtvOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PE/VZWHY; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-336c86796c0so45706651fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758036195; x=1758640995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/nuSVLC68nX8Z52Tryz9BLSU3qdeaRF6+fP5+6ZIUdA=;
        b=PE/VZWHYyV5u30/UfWkQEkBNvtBfI/Yg23H7oWR6CTsFgqfFqJEjsyqCvMWdeoij/i
         7fennR3XUUGVWjzAYCvnXUklPP0Rs+L1qnvfXm6ZYglmdTkByQs9PPVWjzajr3d2dZ4R
         3XGcB8xtuy/EjPJx9Acmyt4NuBP57s2NSNjB2tTKxxucheeUhDVR6gVgtNstak5Jkmv0
         PJEAmQbzOCe+mwhurW60tZzm6ji2T90Nhf+mYdf0Iqb95YCFk68cuA2UYG6DwuGTV9xb
         Bwj8l/PrdJZ+kJgJ3a03kA5BWWhSvRVMC/oiv7Vr4WKh0nwL23ugmaCoea+ZIOaYlqtW
         T1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758036195; x=1758640995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nuSVLC68nX8Z52Tryz9BLSU3qdeaRF6+fP5+6ZIUdA=;
        b=S3L/n67GpeBYZfn9oYnnSXVZNpdsNSVHh4TKJgqYc91UvkN3f5tXuyEfi4LtlEZsH9
         zDE3R3mWRIPcFxxNqv6J4xhQX4IUQ29hwzF+Ifdyv7RLM2M1lDmZfmweIudhoOsqhvTU
         gI22yIPCv5iamt6r0/qsYT3tw9pLJ9PIJ4j+z+z3Y2wVvOnK8nLpdy15nYSmmblkBeGc
         6t+zZE2SS7kScONIAkv6WuOdeRPekNHjRM/o8V/YOKyVWrF48sxmyHC3X+EYhQEajj1l
         zCDFuE06zAsIRQSHfDA913r2syn8kvzcA/7NpebyfSq6yy86WKP8cqrEqg9RtqjWybFi
         8Ipg==
X-Forwarded-Encrypted: i=1; AJvYcCW2nYg72J1tHIjLY2Mmy8BdDaHpL6eoyGEVegvBT72JHlEjcIEWNItzYObAMgb3lrC79YksxCD7wL/5QrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv3eyd4mLgi8f5DNh3iGe5B9epWKKsbjmVIEVIxvsbr7WqS3XF
	FypiIZrfeHVxJNuKRUs7WRMnc/lDiLRz8jpssYOENCZGWHRHT7ncsJUa
X-Gm-Gg: ASbGncuqBpqmmeDO+oRIZ8OlOCB3qCbd8R+gDsB95SnxbfPdbYoIbpcFpILEuZl4F/F
	7OpwBC7DpzHGZinvnp+75lJYTikiQD0zJJIMmIrXRJkM98biwg3HunvKS6RvEmwi96rOeRPZ/+k
	JRLT62hU0FKp7m1NfmZ86Q09fDn/xbvbTtlmlrmKb+D07pJCcM8z2pe3/JZmzGiNR68T23KuIVk
	lJ5a4v6I463tMO38wJiVZwUHh5x6tsD36e0JBbOiZYjJOScC2W2ZDXlDz9AXTOL4IHIt87qpdcv
	PzS4e7JrlOaqcgh4UuyzY1gjGNLuzcphk9PGjeZ9dvsSobEjtkmRUbBb17wh3Rh5xQ==
X-Google-Smtp-Source: AGHT+IHB4r5cBNsmY9gvwcEAPOYB1cQlVCkB6XSDMxPrU8k2LqqAODvmkpEHD11QK026BXiH3iN/YQ==
X-Received: by 2002:a05:651c:3245:20b0:336:e176:cd3c with SMTP id 38308e7fff4ca-351403ed5aamr39716711fa.38.1758036194420;
        Tue, 16 Sep 2025 08:23:14 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-350a153c10fsm31333581fa.3.2025.09.16.08.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:23:13 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Tue, 16 Sep 2025 17:23:12 +0200
To: Michal Hocko <mhocko@suse.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 09/10] mm: Skip might_alloc() warnings when
 PF_MEMALLOC is set
Message-ID: <aMmA4Fnvpd9Szyq2@milan>
References: <20250915134041.151462-1-urezki@gmail.com>
 <20250915134041.151462-10-urezki@gmail.com>
 <aMhKAnO1MmkKHTO-@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMhKAnO1MmkKHTO-@tiehlicka>

On Mon, Sep 15, 2025 at 07:16:50PM +0200, Michal Hocko wrote:
> On Mon 15-09-25 15:40:39, Uladzislau Rezki wrote:
> > might_alloc() catches invalid blocking allocations in contexts
> > where sleeping is not allowed.
> > 
> > However when PF_MEMALLOC is set, the page allocator already skips
> > reclaim and other blocking paths. In such cases, a blocking gfp_mask
> > does not actually lead to blocking, so triggering might_alloc() splats
> > is misleading.
> > 
> > Adjust might_alloc() to skip warnings when the current task has
> > PF_MEMALLOC set, matching the allocator's actual blocking behaviour.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> I would probably just bail out early for PF_MEMALLOC to not meddle with
> might_sleep_if condition as it seems to read better but I do not insist.
> Acked-by: Michal Hocko <mhocko@suse.com>
>
Thank you, i will apply it and place the check into separate "if"
condition.

--
Uladzislau Rezki

