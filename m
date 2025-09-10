Return-Path: <linux-kernel+bounces-810284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0ED6B5183B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6E931893FB9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96951E503D;
	Wed, 10 Sep 2025 13:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="p88fSQcR"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25AE200C2
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757512000; cv=none; b=jog1dANd8S4Rr2navxox1P2j1vKXyHvjb3qlKTNgW+ouTSWfCejY6cQAyn0VI42pFObAFd4gzuds7ehPcqOAkjAoOb6c3Xg6EcCssLPzqrsgAPYNg3NfJK9/BvSsxFXvPsGVmjy9U2k1I8K1w9iRuHxxZ3bpX/R061/oEOeeAhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757512000; c=relaxed/simple;
	bh=pHHuEHqxoQ0Vo4jp4dTcq0pvTBFzxKdGo+2uuhOgfXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8W6i+5bZ6ybYJAYtOw0XmfUOVLfBy2y3/Q4T78KqSGypNLXCuW7ZXgCo4Yqa/ISABE2K2V6AJzk8uvAiWMULBSU/0LlWSbARXhAHquFxEEei3nBR80JDxJ8YaHckkdq1rqdcJIkaEarZY2XeWoe/JLYj1/eTxuE3oXrVeE02ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=p88fSQcR; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-70ba7aa131fso76225166d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 06:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1757511997; x=1758116797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Af9b+zWkct/GsJsGHqMcZiJ29hiwuRshIos/tH0QIzs=;
        b=p88fSQcRstM73ciPijN+7xdYHfDNx8GOmZYF8Et3uYaWGOpMPXQPfW5BeTpO6oavL+
         fzbontjj5evdPgNYMxZDuekt/tXHnBh6s2l7pjZfUjAIQYISXOTdt/bDV3N3vcy/Sqjt
         ptTFyi5azfo4JNl+Gfl8M86QY5BKMcOufb8sei2zodxA2xCZLiRmb6krD4ITt+6zAfNf
         iAZsCttbkLxL5uhLGZDzcYkkY6EPuO1/hzvoVL9HDVbYHdpsv9Kji3OYsnOL2B+SO6sj
         w2Ws0aiuQ0qOIhG+7HcAcX7phs1OZrsaVeku/CIPTGMICZy910Gu5qTuiS9etB12NSFm
         3nAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757511997; x=1758116797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Af9b+zWkct/GsJsGHqMcZiJ29hiwuRshIos/tH0QIzs=;
        b=YRltLVqXqT9LtFy9kLHpx6HKPr9qD8hNV0wD2HSSP5/IfkFklKvr0o94z/d16O7ZxQ
         AdLAGRWE8JxNyYrpfKhu8LAY4YVjJKfcbJrWcaM4oCW295Q48MuLpul20kTBuA/EvEEy
         xL5rvY+6kl9cGzMFHuVGjEKGV4B/GmyCJV+fV/olKVRJZ89eOCsKvq9x6zKmSuCivMI9
         7Q42JFHGa/xhTZz7zO3dxMsRhejMaayD3LPL8w0IYqDg/z2Cw1CsLBwnmFZYYRkXVaOo
         RyPGRfCBFFN/LNAQiEwJ+4hj6OnjS3ANi9+rNBbX5gBPfMoqFvjj39ThhkXo2XKaMTAH
         C6og==
X-Forwarded-Encrypted: i=1; AJvYcCWfB9JPb68GSW6Vb/7bXrafSswcK+j5Ard9RNSfEkI+T6n/qoOvM1+t0p+agnyJpbivnc50C3qeMcHEiZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/9os3a5NbVBUO0bQWzdxix+qNXBaZOG6jQKWlfxF1vNyg8oHA
	F2Jm8GPyFDJDHWlqelHlONSESU2wQi1VEiXy4uEP2Y3vf+r+EJy5iFNgr8/S0cuCgmc=
X-Gm-Gg: ASbGnctM9v6xs9QVab29cIb7F6Pc7c4DJl9eeXpCX/Zix2DHv0KsngofChVDcK3+LR/
	paxGm8kFei529N7QvOAL0ydI9DJay9kDESmezCZVC6nNY6powPn8kLUA8QButHiACLpWiVUJE3z
	Q98aBMcz118lLzWcQt4nvtZHzk25LqhUjPsSuABy4XmVZ2a1e+v0Xz/0ww9E6hiwumrQKWOO0t2
	FRlivFD1DNdzh/Mr/RVRP2BdymQ0B39cPh5CaUcvFL5n0L/bgGuqRnCbnekaI6RBAdkWti2qKBt
	f8FnzpWrp8mZbOPJAFsXf7tFQk8m/6Z61KJ1wIabARRwR8G3kJEyU10zbEjZ9G42VHlyAc8uWOG
	S3VaCEWWCskKMXKed6MsLfKQ=
X-Google-Smtp-Source: AGHT+IFH+xY6zcLHZp1R7dQuxNyCBZBMpa63uJHwAlgVMDzPHOhi+hDTCg2JXA9cZiRHOYknWC0uzg==
X-Received: by 2002:a0c:f096:0:20b0:743:5b18:caa with SMTP id 6a1803df08f44-7435b180f23mr114883876d6.56.1757511996502;
        Wed, 10 Sep 2025 06:46:36 -0700 (PDT)
Received: from localhost ([2620:10d:c091:600::cb89])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-728a860bdebsm121998106d6.69.2025.09.10.06.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 06:46:35 -0700 (PDT)
Date: Wed, 10 Sep 2025 09:46:35 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: remove unused zpool layer
Message-ID: <20250910134635.GB1111@cmpxchg.org>
References: <20250829162212.208258-1-hannes@cmpxchg.org>
 <20250829162212.208258-3-hannes@cmpxchg.org>
 <rcxmemdxbxuvtag2qv4sjxoh7ho4z3bz3od6i76rc5yholx2rc@vncn6iuuee7b>
 <20250909151639.GF1474@cmpxchg.org>
 <pmpmejmw4swnconhf3u5uzzhwtki2fdnwvt73vf7lzkigrhwmb@sarxlksng7nb>
 <3dmy2gxowbmq5wmpjtsb26d25k5fjev2geykik3du2ltmhrj7z@nfkwjjhndet5>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dmy2gxowbmq5wmpjtsb26d25k5fjev2geykik3du2ltmhrj7z@nfkwjjhndet5>

On Tue, Sep 09, 2025 at 08:09:22PM +0000, Yosry Ahmed wrote:
> On Tue, Sep 09, 2025 at 08:08:12PM +0000, Yosry Ahmed wrote:
> > On Tue, Sep 09, 2025 at 04:16:39PM +0100, Johannes Weiner wrote:
> > > On Fri, Sep 05, 2025 at 06:58:47PM +0000, Yosry Ahmed wrote:
> > > > On Fri, Aug 29, 2025 at 05:15:27PM +0100, Johannes Weiner wrote:
> > > > > With zswap using zsmalloc directly, there are no more in-tree users of
> > > > > this code. Remove it.
> > > > > 
> > > > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > > > > ---
> > > > [..]
> > > > > @@ -125,45 +122,18 @@ config ZSWAP_COMPRESSOR_DEFAULT
> > > > >         default "zstd" if ZSWAP_COMPRESSOR_DEFAULT_ZSTD
> > > > >         default ""
> > > > >  
> > > > > -choice
> > > > > -	prompt "Default allocator"
> > > > > -	depends on ZSWAP
> > > > > -	default ZSWAP_ZPOOL_DEFAULT_ZSMALLOC if MMU
> > > > > -	help
> > > > > -	  Selects the default allocator for the compressed cache for
> > > > > -	  swap pages.
> > > > > -	  The default is 'zbud' for compatibility, however please do
> > > > > -	  read the description of each of the allocators below before
> > > > > -	  making a right choice.
> > > > > -
> > > > > -	  The selection made here can be overridden by using the kernel
> > > > > -	  command line 'zswap.zpool=' option.
> > > > > +config ZSMALLOC
> > > > > +	tristate
> > > > >  
> > > > > -config ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
> > > > > -	bool "zsmalloc"
> > > > > -	select ZSMALLOC
> > > > > -	help
> > > > > -	  Use the zsmalloc allocator as the default allocator.
> > > > > -endchoice
> > > > > +if ZSMALLOC
> > > > >  
> > > > > -config ZSWAP_ZPOOL_DEFAULT
> > > > > -       string
> > > > > -       depends on ZSWAP
> > > > > -       default "zsmalloc" if ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
> > > > > -       default ""
> > > > > +menu "Zsmalloc allocator options"
> > > > > +	depends on ZSMALLOC
> > > > >  
> > > > > -config ZSMALLOC
> > > > > -	tristate
> > > > > -	prompt "N:1 compression allocator (zsmalloc)" if (ZSWAP || ZRAM)
> > > > > -	depends on MMU
> > > > > -	help
> > > > > -	  zsmalloc is a slab-based memory allocator designed to store
> > > > > -	  pages of various compression levels efficiently. It achieves
> > > > > -	  the highest storage density with the least amount of fragmentation.
> > > > 
> > > > Why remove the prompt and help text here?
> > > 
> > > We shouldn't ask users unnecessary questions. Zswap and zram are the
> > > user-visible kernel options; if one of them is selected, they should
> > > just quietly pull in the zsmalloc code.
> > 
> > That's fair, although ideally we should call it out in the commit log :P
> 
> With the commit log amended:
> 
> Acked-by: Yosry Ahmed <yosry.ahmed@linux.dev> 

Thanks!

Andrew, could you add this to the changelog?

---

With zpool gone, zsmalloc is now always a simple dependency and no
longer something the user needs to configure. Hide CONFIG_ZSMALLOC
from the user and have zswap and zram pull it in as needed.

---

