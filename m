Return-Path: <linux-kernel+bounces-759935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 244DAB1E4A6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C15683BF3F8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF54265CC0;
	Fri,  8 Aug 2025 08:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1BXKykN"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE0A14885D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 08:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754642914; cv=none; b=esZ0/US9iEOzQtX+ZIaaw52xBapOn3jETQ7AihsXOiTp3qEerD0SMVF1xc9HLRDnjlcJbrt2v3F5N3//YMfLPcCUAaMX04cmTUgqMii3DDXSIjy/j/5asmkbz8H3o9yQTros7I5aysv3cQ4XHfM8vlKZLrHK002gZLUSpngpxxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754642914; c=relaxed/simple;
	bh=Q5YbCcLqPW3z4SzbswJEy4OyzYUCSx+amYB9xYk9emE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anyEXUNbTvJ+xh3/tIk4bVFw3jQVCQYxxh2L5nGipmuM0J/Jar/zBaruVfcp0F2UxWw4lKiQlj6KoR72t89RXNW8TZ5ciFf9D2xwERmL+71sERKlZ9q890+pXfmnP0bUHl27K2ZkuTJq+165H5SwgjCnxvBzjOqti2ZrC5+bznw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1BXKykN; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3338149d8a3so22673621fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 01:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754642911; x=1755247711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v9nfb25BPwvJZ+khUKkOpGadyQIkm1x1hsyBk6u4F3w=;
        b=Z1BXKykN/OrhxU/gEBVOIPE8QQhRqqEE4y/dIM5+8b6cyjWq+y4e03bkDrJM6Oo/fC
         JOzEnjWXy7gay6HXT+wk1sfo0mXdkwsaib2B64GzNnV52Bb6v5tCBLyZuteX1zlXOlQ/
         loWh/BC3vwrGDK8dfRFdIzDrSlhoCKxUZWJZPEIZgvUUJa0M+xa6tl4vBc2PP26FgxQi
         c+tBP9VZINEZ263NBFPQKMzbJdT/EsrluqbcFxo1gfYSd8FHa9Pfjt//ApALhg6pIIy9
         umcIFjtS2k+7tk3FJaEt0N2bJijHVq0YtSl/oSRH8I5kBci1jzaQdhmk1hPbFJu8BPph
         sFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754642911; x=1755247711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9nfb25BPwvJZ+khUKkOpGadyQIkm1x1hsyBk6u4F3w=;
        b=E0JwVaBYeqIPgSmUqfiHCn9wKliMvfs9fgvKiXCSxuSJ+ft25wNhS9RgbIyMKx2XIP
         OJKN4Twpj4lDzHQLb7xhuziDkUvfPmyBbRbxYXUza3JpH4ebi27C4iZTvqVBZZH0B0I6
         daopaIMML0qFQOvcmFA0uZSdGOmkFkjyTpnUgkSEgv+L3hz1mzO4pHnfFX+6hRloo9K3
         6aN7rqKG8jMuTNaZylspvKvD68Q2SEhz6mIMtBwWCziq79KCn1FANmK22qrUIwKXVYbl
         NeEhpX94YSfJ/88mEdsrdT3JgnWW4Nau3+qzh1grXB7HUjyxniP3XU1k1RVDa+o1vual
         VVYA==
X-Forwarded-Encrypted: i=1; AJvYcCXkliO6RSzry7QuZje1Ld/cSWUzGEq0FTLgsV/nFWN5dQWa8D5d3juPJTYqwBxQY4GtVTbL5ruQeGIudyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh93Uo0Fcf6dUbkOjwbmupyIeuXy19PqEMynsR74PQ7OP3Thja
	arIHgCcfr/Iv18dVeGaIYVLBsw2KnbzjUssevIkZjfzYM3xGNbo/Djkk
X-Gm-Gg: ASbGncuBRrLB/ywyJJbYK3g16Y8eizl5a6s5l5biAlhxUalTgMVC4eqPqdg/1/2RlKc
	7GwPX3AceRODvrIRDuqWgroGu0HdAGgc6VEIXqIHE1YSvacZflWEVIcDHVK71WfzeXlu1CaqQCZ
	IaMMm4wjBa7zf+m3zzhV8l/ttIEJtX4vyC47nYa/nf7VUaKV1uHdfqmvz68AGMugV2wuitEBvV0
	LXFxomvqUpUGpWrUXTN0I1xZ6482VER7kEZawVgiAmuKJR+Zg/y3bMUg9O4+FBSqoiRnqoJtcoe
	eboEgV7Uyd8K9k2bO0PvToVnn2wZwasvQAhJhsNhorAL7TC1EH2HapaEZxyGNkyIhWh7mTzkF4q
	8YxG1ycUlXadXH5O9SnTm5qbCeBss8QB4doEB2/zFUmp900jO6rhazHdupei+
X-Google-Smtp-Source: AGHT+IHvT0XYEWQ0ViZuhDl7GWh1hgaQjAzFy5t13nBqp0OTBNM85tmsrZa7UxMhIAMZiOtWohN+RQ==
X-Received: by 2002:a05:651c:50c:b0:32b:7ddd:2758 with SMTP id 38308e7fff4ca-333a236da8emr4056051fa.0.1754642910978;
        Fri, 08 Aug 2025 01:48:30 -0700 (PDT)
Received: from pc636 (host-90-233-217-11.mobileonline.telia.com. [90.233.217.11])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3323a85d7c1sm28777831fa.68.2025.08.08.01.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 01:48:30 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 8 Aug 2025 10:48:27 +0200
To: Marco Elver <elver@google.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
	Alexander Potapenko <glider@google.com>, kasan-dev@googlegroups.com
Subject: Re: [PATCH 0/8] __vmalloc() and no-block support
Message-ID: <aJW520nQ78NrhXWX@pc636>
References: <20250807075810.358714-1-urezki@gmail.com>
 <aJSHbFviIiB2oN5G@elver.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJSHbFviIiB2oN5G@elver.google.com>

On Thu, Aug 07, 2025 at 01:01:00PM +0200, Marco Elver wrote:
> On Thu, Aug 07, 2025 at 09:58AM +0200, Uladzislau Rezki (Sony) wrote:
> > Hello.
> > 
> > This is a second series of making __vmalloc() to support GFP_ATOMIC and
> > GFP_NOWAIT flags. It tends to improve the non-blocking behaviour.
> > 
> > The first one can be found here:
> > 
> > https://lore.kernel.org/all/20250704152537.55724-1-urezki@gmail.com/
> > 
> > that was an RFC. Using this series for testing i have not found more
> > places which can trigger: scheduling during atomic. Though there is
> > one which requires attention. I will explain in [1].
> > 
> > Please note, non-blocking gets improved in the __vmalloc() call only,
> > i.e. vmalloc_huge() still contains in its paths many cond_resched()
> > points and can not be used as non-blocking as of now.
> > 
> > [1] The vmap_pages_range_noflush() contains the kmsan_vmap_pages_range_noflush()
> > external implementation for KCSAN specifically which is hard coded to GFP_KERNEL.
> > The kernel should be built with CONFIG_KCSAN option. To me it looks like not
> > straight forward to run such kernel on my box, therefore i need more time to
> > investigate what is wrong with CONFIG_KCSAN and my env.
> 
> KMSAN or KCSAN?
> 
> [+Cc KMSAN maintainers]
>
Sorry for type, yes, that was about CONFIG_KMSAN.

--
Uladzislau Rezki

