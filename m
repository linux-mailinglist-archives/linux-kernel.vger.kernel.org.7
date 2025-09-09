Return-Path: <linux-kernel+bounces-808500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F45B5009A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F8277AEEF8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00F1322DBD;
	Tue,  9 Sep 2025 15:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="gc5smJqC"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D602288E3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 15:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757430212; cv=none; b=PBeNzwF78rwCI5JGTQqy4bTj68gtMP78e2RRe++0mfBlKJP6DcQWZ20XFzXp4aDsBeTGkSPPsmtx1liY+MS+NKtO0mAkXhzsyRpSyq5ZwTVFQcogXAhD7F20g4FS6wZ51A+Gk/kXmIipyce/X76DEQjibKNMJhu7yndDIQaEfAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757430212; c=relaxed/simple;
	bh=YscVxmRs77C+ocGIJ6BRzR9DziZhehkf8AD1nlT+xDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSHrqbSU15Ua8OqX3QefMaycx6WsYRUudeMNi5mnd9bkGVcRtjE0MwZ88BB4Y1bmB/8be2Iom6G1m+SNTj0BfhgDZgLDjy62eOMRkHWbTPWRu8PqJ7JujcjemfZiTV8QgFgn2e8cdn6xGmDROdQRJPldhW+zSWzJGru3VUFYzA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=gc5smJqC; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-70ba7aa131fso64158476d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 08:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1757430209; x=1758035009; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Mu/1i0QY1lAahv44Zab7jGfKcHqDQqbZccixOVrtOOw=;
        b=gc5smJqCkmxEtpgVoN+NvQ+nVHW2WQdG9FIE3EnB0vF3sVIqlE6ItDeEl5vjQxPc0g
         bgPLX14D/hK8jp4Zzrx8XCbNA0f2fvA0op7irR14AOHHJXspJTEqjjOuiKt+Ul9FYPOE
         SlrqdCOjOZQVX8iK8Dp1UN68JCG6p7zATrrc90s8nyPAeeoTEBoxfV/gCjw6NqfbgB0Y
         45f7SFAakPIcGUIXg+wirJP47LFFwBnsS1sUAlHYoVRjsbQn16RQk+3buC+NXSkuaWz4
         zval0XISv8ddD2fMdbKGrjWaFulflevlqAX/Vn9YgDS6fpm+dZbJ8a9u8/fAFSGZpWiL
         p1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757430209; x=1758035009;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mu/1i0QY1lAahv44Zab7jGfKcHqDQqbZccixOVrtOOw=;
        b=jt0HmA9b9DIjmBj8I8Bf3/z3QLZ16fvxiddoqlMNkABJkLmR/ahyDEFE7uwbLwQrzH
         Q/vwdypYF620/IGfBfbsGb+P/3tRdLG5jgg32mbT6N1OEAgpYNBju2/x7M34T9El/Bc3
         hP8l5A70qUc//p8NiCfK4/TWyngspZw3rGFFxCEMV6yZdJjjFw/2EhbL8USV5EKrzrp+
         R9l5y8bPOOQ34SF7gYZNxzu+/lwUx8iX7m8+L1IOhL2OFfDCrbprphiu6CooZ0gT/fUE
         voUdlysDRL/npPXZGDlfmm32JU66UTIYR4z/eLjbt6pC/dYDA/mtFp2hovx7Ry016gmJ
         7/lQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtPDyEkUYEAiYuwsm54iLA6cVhKgM0ZiVwn3AXLjLclFE68g9hK/nxtaSdYaw0XzS16taokyPMINKkAyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKa3CQ6U2eR2P6OLvULtVdtvI18xLCyiagfpq/ZlOkscs9WRoo
	9F/etrkWHcOkKgFNPS1bYTHDNJzDeLoHjg6unR1uJfxjQGxKhLsBNzucG45vs+Vn+WU=
X-Gm-Gg: ASbGncvZ3laaMAK1Fqie+tSJ5p8jJhdftJzh7RBW5BrdIY/FXM33ahVji6TFCeJqvru
	hW7I2q9WmBY1+GrpRonfQgxgOQbmjdGULGoq7mDDaw5OtGnP/R/89xuOMUR9emH+xhoopfR33+L
	oVQdx1iDsKd+a6Ml5NOzVGX2nhhDVyZd7uSwNUnu2PjdbKEX4WJWrxi8p6mvf9aPFwFiO5a+uxG
	ukUrdQFlxL2YA057yW0a3hB1Ij/xQEO8SZeYzHf7zCCUqHj5LTud9mTa/tLco1mytFWRoLXnVcs
	9ulVicr/d/U+8XFSjd40f/THGRa5O2cciDb/Qu5PjYFMiP3BEVuhJTBzN83SIMyr1JyrR4AxAD9
	UHlKdK/RVsdge
X-Google-Smtp-Source: AGHT+IEjOrf2aDiDBedKoPEPVw6yfvKoqORxFwFZL8tpRk7gQlzrwvc8I4YBCMey02oIsQCUL6PFJw==
X-Received: by 2002:a05:6214:c4f:b0:734:4ca1:1d97 with SMTP id 6a1803df08f44-7391c8e0647mr128950756d6.16.1757430208186;
        Tue, 09 Sep 2025 08:03:28 -0700 (PDT)
Received: from localhost ([2620:10d:c091:600::43c9])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-720ac16de47sm141863736d6.15.2025.09.09.08.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 08:03:27 -0700 (PDT)
Date: Tue, 9 Sep 2025 16:03:26 +0100
From: Johannes Weiner <hannes@cmpxchg.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] mm: remove zpool
Message-ID: <20250909150326.GC1474@cmpxchg.org>
References: <20250829162212.208258-1-hannes@cmpxchg.org>
 <CAKEwX=M8ccnsOUc4_ZcFrg-8MSwDDF250=LCFKctvTrL5vJZ6g@mail.gmail.com>
 <4vpqew3bfs74kesmgd6kaafgm6nr6zbtt2t3hl2khkc6ds4zep@hllgy77hdumf>
 <CAKEwX=P=2cm7X4VMGO==xqmcFfBj4tq_YU9DqCSbyAmCioDccg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKEwX=P=2cm7X4VMGO==xqmcFfBj4tq_YU9DqCSbyAmCioDccg@mail.gmail.com>

On Fri, Sep 05, 2025 at 02:35:12PM -0700, Nhat Pham wrote:
> On Fri, Sep 5, 2025 at 12:45 PM Yosry Ahmed <yosry.ahmed@linux.dev> wrote:
> >
> > On Fri, Sep 05, 2025 at 10:52:18AM -0700, Nhat Pham wrote:
> > > On Fri, Aug 29, 2025 at 9:22 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > >
> > > > zpool is an indirection layer for zswap to switch between multiple
> > > > allocator backends at runtime. Since 6.15, zsmalloc is the only
> > > > allocator left in-tree, so there is no point in keeping zpool around.
> > > >
> > >
> > > Taking a step back, even if we do have needs for multiple allocators
> > > for different setups, having it runtime-selectable makes no sense.
> >
> > Honestly I think we should take it a step further and make the
> > compressor selection only at build/boot time and completely get rid of
> > supporting having multiple pools. We'd create one pool at initilization
> > and that would be it.
> >
> > I believe this will simplify things considerably, and I doubt changing
> > the compressor at runtime has a valid use case beyond experimentation.
> 
> You are completely right.
> 
> And, even if there's a setup where we benefit from multiple
> compressors, the current setup is definitely not it. How are we
> realistically going to use these sysfs knobs? Change to one
> compressor, then quickly change it back? How is this remotely useful?
> 
> Let's remove it all. In the future, if we want to do multiple
> compression tiers, or per-cgroup compression algorithm, we will need a
> completely different architecture anyway.

+1 Completely agreed, it's not worth all this fragile code in zswap.c.

I'll send follow-up patches.

