Return-Path: <linux-kernel+bounces-795448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6162CB3F226
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 04:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ECE92048AB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 02:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A197526A0C7;
	Tue,  2 Sep 2025 02:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZVlNej93"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04501189BB6
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 02:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756779014; cv=none; b=uIKDO9bYditOt1r5NMbrvgT0xNo7mG7fJcT3qa4st15actGgKMU+mRZ6eZLcCajm3CK+cL29TPjKpJ7lDGoNFErfHe21/Y092TKMbUsLrXL6Zl3/jV3BVX+fPgQKOYMq6NHB+jGwgcJDdVXMJ3AZl4csppvV3jElEFGrITPexVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756779014; c=relaxed/simple;
	bh=M/1zDnriG8ilm2H7iQwKqlgOR9ONJObBvnbqBpDcnsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCE2FtHiDSj45TdvYI1JSVKzJa8JJSy2BmSAGGLfjhah0u6CXzZeYBAghBsVM5OQGzUrHg7I1YUkusag/h4ZmVkmV1U569pe7YsJWrHlU36+rJSsRMlEwtKNbERtsUVu7UWWBVM0yxQ3R46v7zCIYLHjbcroCrGPqqNoI/OBg6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZVlNej93; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4d1e7d5036so2256985a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 19:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756779011; x=1757383811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xMToDNcwi+JjPobVyHU6qbfn2l8RCkFP2dBoE6EGpl0=;
        b=ZVlNej939gxr09q0GM+YkdQbts4n+A7/WDy6lQGMTe+CSgevjctOJWFRmo9K+8B3Vb
         bzvKKJjCW4SXgU+F51r0IX305wWapSdNGjvuSDmBpyjSqU9NnVw3BVEvcwkjD6GgxX6F
         ghQZ4eUznJNHG8B1AJgGfl/HKuJeIIYcRaw3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756779011; x=1757383811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMToDNcwi+JjPobVyHU6qbfn2l8RCkFP2dBoE6EGpl0=;
        b=CkwHSRu6zm6pJCv4SfreFVGSzlF9SajKgAF2eJfpK2ntc02Eu7GPUnNMBjiXHF6QLL
         NQDav8dtZqS7CzyUH2zcPWF5u0kyXvf6tE0Xmwk4SOHUuy8yi8NyiVYsjN7BxuePc19o
         DGqaByDEmIRdV5ETqtqWdVGBZ9Wp1DEtDPnrM1E7mXAV/AGKGtpKU1gzmssMawJaiFVO
         /PH+D8QhPtrIJ1uGBMvXjNpw6Vq2onoCUPeHu3gG0uTsHZ7fA2BQQc7kqsvYrvAZWthw
         Y8V2q2dsAIErxN5LFG1i+6quUn4SVPOBZEglBrimxmYzxkDI6vS1+ZpQ2smdRTVlN1/A
         90Eg==
X-Gm-Message-State: AOJu0YzppPDGiScPfDoxbs+Wm6RimFgGk1HOQZ1n1wxFLKmMn9mGfufo
	WaIRihf2iL4xwz7t3wrLypCOCGa6xIYyo2tGrahCOnrDmJsRbCuXUnmECs+VdSXLBw==
X-Gm-Gg: ASbGncuM+Nb4isWxOV7prdfyBAD3CrjKTHOO0wxnC9/i+Z0MbY8Bv7VYUXr2dPeYnxT
	R1D5iLqckF8iY7BDNjTEf3zig6QWscIaRGQrm+QbAcFYAThmhwPiuxVzMft04bLtDjExJASonVu
	tKxg/wvjRgfQmEvkJD9CJNVvmHRbHk3FJSmpbPjziPDGmTEMBRrT3KYEidz/S8Awdv1bkbdg4qE
	gokHOOo52B+XIjrvT4Q0XRa2yvyT8hCUt76fMN8Lk76ngfgJmJVVSfb+IIxtNWYD2qHe98Wckw0
	mSLRa6vDIvE9g1eW9/QtSLA7i/QEPMEMqzaG5OJR1aU1iQ03ccuCuUgmQBNFFzA2y6ChTwxgWEU
	fIcIvtISI7XS882R+g03guk8s+A==
X-Google-Smtp-Source: AGHT+IFFsgaUMNmStaw7X17phzd3lUhWjfR+pBLqnu11jIGmAdr9OFQevWfZTFcfLRVDyRy4wJSiFA==
X-Received: by 2002:a17:903:28c:b0:248:fbec:7c99 with SMTP id d9443c01a7336-24944a7728bmr128727935ad.26.1756779011223;
        Mon, 01 Sep 2025 19:10:11 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:52df:d776:7862:776f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b0d881afasm9754075ad.47.2025.09.01.19.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 19:10:10 -0700 (PDT)
Date: Tue, 2 Sep 2025 11:10:05 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Vlastimil Babka <vbabka@suse.cz>, 
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, kernel-dev@igalia.com, 
	Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>
Subject: Re: [PATCH] mm: show_mem: show number of zspages in show_free_areas
Message-ID: <ypp4byiagmgmdaaq3wskjxwxvub7pxhhqlvwsrhsyqlapqp5v2@rbfidxth3z6z>
References: <20250901183729.3900578-1-cascardo@igalia.com>
 <f25b1ad3-c2d9-4267-bf7d-f48c78beebc7@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f25b1ad3-c2d9-4267-bf7d-f48c78beebc7@suse.cz>

On (25/09/01 20:54), Vlastimil Babka wrote:
> On 9/1/25 20:37, Thadeu Lima de Souza Cascardo wrote:
> > When OOM is triggered, it will show where the pages might be for each zone.
> > When using zram, it might look like lots of pages are missing. After this
> > patch, zspages are shown as below.
> 
> AFAIK zswap can also use zsmalloc so this would be reported for zswap with
> the same effect too, right?

Correct.

> > [   48.792859] Node 0 DMA free:2812kB boost:0kB min:60kB low:72kB high:84kB reserved_highatomic:0KB free_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB zspages:11160kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> > [   48.792962] lowmem_reserve[]: 0 956 956 956 956
> > [   48.792988] Node 0 DMA32 free:3512kB boost:0kB min:3912kB low:4888kB high:5864kB reserved_highatomic:0KB free_highatomic:0KB active_anon:0kB inactive_anon:28kB active_file:8kB inactive_file:16kB unevictable:0kB writepending:0kB zspages:916780kB present:1032064kB managed:978944kB mlocked:0kB bounce:0kB free_pcp:500kB local_pcp:248kB free_cma:0kB
> > [   48.793118] lowmem_reserve[]: 0 0 0 0 0
> > 
> > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

