Return-Path: <linux-kernel+bounces-888917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 30252C3C463
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 450A64F3302
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D259346A12;
	Thu,  6 Nov 2025 16:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KriLsZPJ"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D2724678D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445185; cv=none; b=OFeU87GJdue1Y1+D2A64xx1Y3mc/+ttvl4ffsGFMv+X/j7tejj3v4WSDG60bu8D6V3gjTal/eOOHHWZp9C+K1L5fElbrXkJYCfnN4IK1FFDWU5WaEetPqlYZvi/DgUhkDt8tZSs2nuy3usr9hCGhb2hzVkU8YHY8OnVNyOL5I1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445185; c=relaxed/simple;
	bh=64JRVtjzbfWhHvVYd5BCYw08LXdxlWiblZki7wHvahI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QuabBcP1pIk5xWx4qOgOK8x6L94pD136DKE97kLxq+qk9KMWvEyAyVzxqnNRwqvQZC8/aReIzXcDm+++Jf72vyVpreQ6VktP/isqA70RwaZXP5JedSqRaP5HT+vMP+iUL8hqU0TdoYX5StIXBwRcGxmtHC/8oyeKbe8/kEGPbic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KriLsZPJ; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-37a33b06028so10093311fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762445182; x=1763049982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7+3lIOUqNBTQh3n9CYA+4M4KGsXczp/rbUXLDwpXjmo=;
        b=KriLsZPJtqEbNB9QvGDqM0JaT87Dlk8v6HEL5k9aG1jnsqezfgQzE/q37wc7/2R7Qw
         PFzKaBMf1Em6BKai5sFu5P+up4aY8rM6yLcg2xPiU9TdXccdmguogEBYwmYia/PwZCu1
         32B/Xde7RaakPRNW7Vuq/gN/xvZZhz0/P7nUYQihfIaDrHI6BB0ahQYiRTR4PoZJy4QC
         3x79mZX9Sn9F37WWVTbewT2klRLUxB0TLANrBpY/v3RhO115/4LxZL1T6eGzxrhgjMWD
         YqDjf5fc5stz1tzLQD2aDqtFgvCuLlgi1J7qh2PfdmzT8Akzsq6AjDRAcd/jYSUSYI8P
         0Ung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762445182; x=1763049982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+3lIOUqNBTQh3n9CYA+4M4KGsXczp/rbUXLDwpXjmo=;
        b=i+d9ygTbYKKOMhAbmsCVTuAyyvbm/1ijpWGG9dO8yv2oG3HU9XfYbo8c4j2HCXrrm6
         y0HTMMulb1riRDBt7uRplHwL0oqxz90QAtdSKJwGNZ22xICu3n3YLxMg1qbw8FwfAuoV
         eIIvNA/2UmbpJTE0wvnmr3nWPt395c7y5tBIMycV/WZwjVpGC4p66AfuGntWbdOkC0+O
         PYHlrWZQB0NGpx/RhzNhITKVT9TUCfm/lU+QdjQe2hDLALSiwijxC+otY7VByhBtIGip
         NqaDZ1iUB3xyha9C0phewyuVVmk8VrIvSEIY8jtnExil85P4NWhxMPvgiFn+eB/bTbZr
         4Xqw==
X-Forwarded-Encrypted: i=1; AJvYcCUL9zxlZBaULnJSMf5+cVQJoZbJgwrQ67G9RaVJ7vawaCUUihuj0keNR2Lc7VqLsAst/Bm5DaQMMSOulos=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhEmGB1OcDMjMekQ9Kzo/Q01KvNr4jvXOIQMz+0xdSSv36dDVm
	/7uZTsIimMctt0LDB3vLDXmxXUYmiEhfRNYEffyQeuJ9XANWFqxvzfa7
X-Gm-Gg: ASbGnctNSJolYDMQ+wrwvm4iEMTIYNhqDmNJdNS6umJnrL7AKIQfPTXb25qcoJgtdQA
	QOtjZ0OSnCcVafg5hzQ8dQlcFwtzz5M7rMOx6CJD4l5Nlt6Dbo4vLIR5znxpRlyjDznEvAiey+c
	9QBMsUuLYFnlc/Udz6ULud0xwgPc7DltpayJpjh/zQDqMD6rmYUGESvV/9EZSdAtqhbIl3SoSie
	etRNHW/I2y8XR+A8vNDv5KEE6mPfqArYvmdfL0ywVUxMrZFrwSYyvbHGibIICI9vS75swYvG+u5
	bFyo5eQaPfVz+8jLIOFXOb7fY6f946zt1HXsC44/pOYxPNmzfvA3ak3QysXXAT3jNLxhTQSh3Uj
	n86i0jBT2MWyt50oS4ElVwuh3QyFx07J3yQ0n7W1qD1BQz0J5o6iB2A==
X-Google-Smtp-Source: AGHT+IG+GOa0FwAU+D9wc2hOalDEt1xYX5HTga97mHqbsRvIpDR9OdEzoo4fxwLubpazlMX7fGBJFA==
X-Received: by 2002:a2e:ab06:0:b0:375:f77b:b308 with SMTP id 38308e7fff4ca-37a514c0b50mr22440461fa.37.1762445180047;
        Thu, 06 Nov 2025 08:06:20 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37a5f0ee46dsm6730111fa.41.2025.11.06.08.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:06:19 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Thu, 6 Nov 2025 17:06:17 +0100
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH v2 1/4] mm/vmalloc: warn on invalid vmalloc gfp flags
Message-ID: <aQzHed0RfWBs3lK1@milan>
References: <20251103190429.104747-1-vishal.moola@gmail.com>
 <20251103190429.104747-2-vishal.moola@gmail.com>
 <aQopoAj3i2jdIX6V@pc636>
 <CA+KHdyWxjqAxVEBjOun9VxoeErWEyba3OvcJveLqnRuBLk2RLA@mail.gmail.com>
 <aQvlE8Hcy0uYAAmh@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQvlE8Hcy0uYAAmh@fedora>

On Wed, Nov 05, 2025 at 04:00:19PM -0800, Vishal Moola (Oracle) wrote:
> On Wed, Nov 05, 2025 at 02:16:24PM +0100, Uladzislau Rezki wrote:
> > > On Mon, Nov 03, 2025 at 11:04:26AM -0800, Vishal Moola (Oracle) wrote:
> > > > Vmalloc explicitly supports a list of flags, but we never enforce them.
> > > > vmalloc has been trying to handle unsupported flags by clearing and
> > > > setting flags wherever necessary. This is messy and makes the code
> > > > harder to understand, when we could simply check for a supported input
> > > > immediately instead.
> > > >
> > > > Define a helper mask and function telling callers they have passed in
> > > > invalid flags, and clear those unsupported vmalloc flags.
> > > >
> > > > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > > > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > > > ---
> > > >  mm/vmalloc.c | 24 ++++++++++++++++++++++++
> > > >  1 file changed, 24 insertions(+)
> > > >
> > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > index 0832f944544c..290016c7fb58 100644
> > > > --- a/mm/vmalloc.c
> > > > +++ b/mm/vmalloc.c
> > > > @@ -3911,6 +3911,26 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> > > >       return NULL;
> > > >  }
> > > >
> > > > +/*
> > > > + * See __vmalloc_node_range() for a clear list of supported vmalloc flags.
> > > > + * This gfp lists all flags currently passed through vmalloc. Currently,
> > > > + * __GFP_ZERO is used by BFP and __GFP_NORETRY is used by percpu.
> > > > + */
> > > > +#define GFP_VMALLOC_SUPPORTED (GFP_KERNEL | GFP_ATOMIC | GFP_NOWAIT |\
> > > > +                             __GFP_NOFAIL |  __GFP_ZERO | __GFP_NORETRY)
> > > > +
> > Also we do support %GFP_NOFS and %GFP_NOIO flags.
> 
> Both of those are subsets of GFP_KERNEL, so I felt it was redundant to
> add.
>
Yep, that is true. But then you need to explicitly check which bits
GFP_KERNEL includes. I mean the white-list mask becomes less informative
for people who check or review the vmalloc code.

But you decide, i do not have a strong opinion.

--
Uladzislau Rezki

