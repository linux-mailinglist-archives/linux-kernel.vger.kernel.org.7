Return-Path: <linux-kernel+bounces-856134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6180BE330E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48A65485E1E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274DA31CA4A;
	Thu, 16 Oct 2025 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iv+SxoED"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27301DF748
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760615599; cv=none; b=nzLW+vevGStUrLnvHLUS6MrSTfKRhpWMZv9R9h4LILoDRIRdooRrvQMssk5bWoOaSr+16Vp3RXQl61pxiWWm1BV2fWKzb2bHtwh2rzOQHLjOXl/91Kxb+gaXC1+OhC+VLWtANQKf31+aB/xdm6wEDhpwJkuCRBryUCoJpboifPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760615599; c=relaxed/simple;
	bh=4l16njzOySsQYhiKHcvzOF3Iu+BnOY/e9/5MLuMZpu8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfwRzB4LghaOM/ybFvIP+kOlQPLSz8IpxJHEZrG33fREk3apLwOk3Et5E49zmTXVHp9ZGlhhq0kcSwtgHnNZSfRqU2SlVDDDnwy+9XPRPxOcsftYTgjJmWEvWFMNO4eWD15YhCbLcxkX8hn2ZnTOiXF1qmLyw8QUTL3hVEuMEeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iv+SxoED; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-57bd482dfd2so628181e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 04:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760615596; x=1761220396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H9/WZc6tWPP7q2IgMsfnC644i4MdiMeKhOgO7bjxkm8=;
        b=Iv+SxoED2l9nmA2JgniELBq5UJOnKaNI+nRO7Eh/gPo8RlVf2ItXhSPqB3rNRgqVip
         lBAMP9pGB+wYFrf4nUysLsIBKJY6dnGN6uBrQwEjJeU1Au6L+ogwM6m9NmVfWFMwtdqv
         qpPmf1DdSNaov5jAsbxEojm9xq2yZx+8sjrQoWsONzn0luWWNY4UQbkQMFGyU7kPeH8h
         lXtRsIT26IyitVJ0/K1a0MCNwESqYjhq8e8cm7TpKSoMO/chx6P+RFo4F/NWGF86RTD/
         93ioZTGxkZ4h/7SWS79UQ9SEuaUu03q+jKGCvxNoIKCiB+jPmIaTLN6IPfMTYjCTPRgI
         KxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760615596; x=1761220396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9/WZc6tWPP7q2IgMsfnC644i4MdiMeKhOgO7bjxkm8=;
        b=njTto2dtXj7HfrLOSnR8Ny+aK3JkGk0VNxxZUEk14y7Pn0D1KeP1O591dx54KeELhE
         ant3xiHiRx3PpoLE8LHe+anybhQVXm37Y0uEsxD1QC6bowXoFnPSvvMftGmkjxzMAP0b
         HmYcZkv4FA1qISGwu1mxO/WNROSUPR3VilWPf29gdygu3GsvH9ooKYfQlUZEVVLzmXBS
         X7SDeFD9HJiTnvXfj4y9z4G8crB3Pfan6HTT/i1aU2mVZ44NuICS3Bdria1oyz8i4yko
         xoHEvTcse2J6cgxIuNazfGptI0h189nOBYe7Dr8xb+EuqUKkyeKkNIVWLlYTNH98lzPw
         7iig==
X-Forwarded-Encrypted: i=1; AJvYcCW9wbULk6uooegdvyRHbM45n821j13YuWvkNWP8gwleyZXnD6oSKAO9kzVGcFbC+MBJ/BD6GRhCxuGshBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUTlujV0DK1K6+zSjrlpBcbntAOMU+NyBNmz8q9mrpqpIuO9wl
	DwrmEmBX0yEv3UxjayGbj0f7m6+yqFat7t2SAygFoOZ66SrygNqaSrqp
X-Gm-Gg: ASbGncvPUzOrO0sF5OD3/YX+1HXSeOYo9R1X/TbQdsYf8GNlfhtXAuuNgksFqmO1Z3b
	ApnIj0OybQavHj2VP2lXjU6CEed1Q5PYyZ11qOkb10jSfxjy2hCrjS+/c86yyO/gyoWbnqSzUZ2
	lz3OmBEECmPVqoaWoGABmvbKEKa4mk3BXyThXZ9WJchcJdGbH7EkkmqHBH0Lo6RcXM45RQEfbCk
	IhjS7WMrFYIq8MRwQjlhuwC96UoJMO2kzWyGtKgOJvXh6cstWvydrH3/3l6ox/cir19XWfPX7L+
	RqBWjk51pviNsxDp2t3E4P9JKk34+A0JLgvVOQ8S85UqXHAOp7XUq4BXsBhSX9KX3v4ItyuE5FX
	7h4fEfzEWY7it++EMySDWq/zDPC//YXHAfCN4xotmXUU=
X-Google-Smtp-Source: AGHT+IF4BoxL8i+TQCVTGE+8R5s02XQLVhbg1to8ADSbMDVrwm5ieJsYsFq7vaP2gTbLxO7SMudzMA==
X-Received: by 2002:a05:6512:1511:20b0:591:c202:45db with SMTP id 2adb3069b0e04-591c20248e0mr2615876e87.39.1760615595507;
        Thu, 16 Oct 2025 04:53:15 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881e577asm7050809e87.11.2025.10.16.04.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 04:53:14 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Thu, 16 Oct 2025 13:53:13 +0200
To: Christoph Hellwig <hch@infradead.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH] mm/vmalloc: request large order pages from buddy
 allocator
Message-ID: <aPDcqeHUj5xJEbV4@milan>
References: <20251014182754.4329-1-vishal.moola@gmail.com>
 <aO9Z90vphRcyFv2n@milan>
 <aO97BjvNZNh0UV3u@fedora>
 <aO-Wxj7al7I-IadV@casper.infradead.org>
 <aO-k2hBimow9oYuR@milan>
 <aPCXdDPlBMdfFQgK@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPCXdDPlBMdfFQgK@infradead.org>

On Wed, Oct 15, 2025 at 11:57:56PM -0700, Christoph Hellwig wrote:
> On Wed, Oct 15, 2025 at 03:42:50PM +0200, Uladzislau Rezki wrote:
> > Agree. We do not want BUG_ON() in split_page(). I think it is better to
> > control this even though nobody invokes vmalloc() with __GFP_COMP.
> 
> Please explicitly warn and reject vmalloc calls with unsupported
> flag.  The fact that many flags get silently ignored or dropped or
> could lead to behavior in gfp_t based interfaces is a constant source
> of problems.
> 
Thank you for input.

--
Uladzislau Rezki

