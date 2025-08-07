Return-Path: <linux-kernel+bounces-759018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 645E9B1D71E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48C0118C160D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 11:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1B9246335;
	Thu,  7 Aug 2025 11:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KXXHSYoT"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC36246BB6
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754567905; cv=none; b=d++EY4t7ow24wu87NQL3hk40IAzu+62osxU3am2Z3qiJYmmBQWhtRFgApA64d7iiDbQcKlc5JXSAa93w14SdD6VuUz81gsgbCrG3gK5jFGuGHNoTDoEIiL3HGBo6zTMNVkcp7IkMafqdR53DCpxjg60hvKcW61MRxAZei8ZDeAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754567905; c=relaxed/simple;
	bh=SN9g39cLqAzYSOTSMSjv5YitFPShMgxH/v/PUOCJ5JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9O/TRXQS2KqYDOZpHo3wWDF3lQR6QXgVl+CiCF6rhXU8QNBR/mM5hcPz4XVgzaKXZ/t8DlgLRuGlJUxFjJ56JYUKBCUVnYcCxavyLst21XHTg+Kppste6gmc91gVssrgRoe1LicLn83/Lu1wFB6xEv1GWK16ywruRNr6SJNPsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KXXHSYoT; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-459ddb41539so2962215e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 04:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754567902; x=1755172702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oEwamW+fTRz5W2tukoAtJ50nny4AOmxMr4ZAI4xj6H0=;
        b=KXXHSYoT4YqwQ2IujEq1p4qYhGUvoshIusWNkRR/xLnHWhvFFH1BtaIZ4B6/wm60sp
         yEYj0NTlXm/AwskYahKfOTWaSMuJvLIFrZy3yTmn4o50xZw4UZVZaieM2i7bioXco7NW
         rZ5ghITLZG0D3ascLWGBcGOBsdzoOUoSl7gklKFqZthzOY2eokLmk2oXpTDCg1UhzMHw
         mvV7wrDsKOPcF2OhjcPCtLDWNEaTg7J4bxcxCIT+famXa0OdZMmoZJJBgddPP093Ghi6
         dKRe1ca8ReGZ48vxM2+MozeUAVp5VKnXb6rt9jnc30mR4NDk8IYZ/dyuBIGmZPd8dF79
         4q7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754567902; x=1755172702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEwamW+fTRz5W2tukoAtJ50nny4AOmxMr4ZAI4xj6H0=;
        b=E7Hh0hW37PelVP0/sj5FNpPqQB4S4rDZEy4971nIjX+CjL/Lvou3Wu49MA475mzkCd
         CC5O1ero/WNdG9rgm9YT/XhknKqs1dZmrS3H922sHhRBOSKOkGX5rHGPNaU6GlKqk4lk
         QduTI2/Krflfc+OwKAk4iq7Gldx3KFGsdJQdsIttonfRlOC/cJFiwFz7pCHYNYQ6MALe
         M/LVXLlNXEgjrQSRXz2Un5CZsynpAFufpNrZzU2gMesmIRxK7M0QvSQTWxcytaE0bGxB
         f01DguTlKV7PJ/bk1Y+iw8tRXxR6YhRiN8GxnUDnmcTLJ1lrBmcibF2hvLfDobayqTfa
         FH8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWiwJRlTp0xgynUfu3Hz6am9vVgqG8kP5n1o87DwriZSoQYT4zr/y5OHPbZdlMQCB+buF8jNhw1ie2Blmo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd3dDjqt9ZTzC/Q5sy4oYDiB58syr1LTX77hB4Tn0s42BUFGGj
	DqH4Vg7+wxvlUgMAg3jLhcvcsMeSqI9ZYf9KYtzbp5bXLZJa4EDcNTNOfAhJR56rCsg=
X-Gm-Gg: ASbGncsUkGMUP9v+9X/B7rg96R0vPfPuVnnUhdN3dTDBy91fw1bHPSPrpDXJyCeWY34
	gkPo81JEBY0HgKwhKDvN1j8U+5FvWd+Q6mVUNmauqisR1L0sKp8slRsCGcMfsOmRHLXKyX4Eo5f
	5RqrUBWOfwatW4P8F1dyZ3V7bHifG2HuB9QpvlYWldYY40PW1SXm2D8YRE5qMwOyu0Orc20J74A
	6pCzEnyds2XzXbiELPxKMwFMbjX7+uitysFLE7E09wPLuy5dPg/WT8gEMMvZ49pv1MeFjbwgNvM
	Z/lvGT4Zw2RRUxmUn12XUEmwJs5VG/IHoM2GhS26GGwJpDZvc+mw+A6E29CXfzEVOgbnHnMVqZt
	syKV0FIY0hqabDc9n3hv/PkuvSJHowibHK8w=
X-Google-Smtp-Source: AGHT+IHkj6EB4TheQIsgXjPsOSdAMwVvBUUvVzBRTFz+9EO1TMkeOl6rO09TeVq1Dqf5kEBw9RNIMA==
X-Received: by 2002:a05:600c:4fc4:b0:456:161c:3d77 with SMTP id 5b1f17b1804b1-459e748faeemr70285315e9.16.1754567902154;
        Thu, 07 Aug 2025 04:58:22 -0700 (PDT)
Received: from localhost (109-81-80-221.rct.o2.cz. [109.81.80.221])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-459ebede65asm44807495e9.8.2025.08.07.04.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 04:58:21 -0700 (PDT)
Date: Thu, 7 Aug 2025 13:58:20 +0200
From: Michal Hocko <mhocko@suse.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 8/8] mm: Drop __GFP_DIRECT_RECLAIM flag if PF_MEMALLOC is
 set
Message-ID: <aJSU3O-pUnTnl_wP@tiehlicka>
References: <20250807075810.358714-1-urezki@gmail.com>
 <20250807075810.358714-9-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807075810.358714-9-urezki@gmail.com>

On Thu 07-08-25 09:58:10, Uladzislau Rezki wrote:
> The memory allocator already avoids reclaim when PF_MEMALLOC is set.
> Clear __GFP_DIRECT_RECLAIM explicitly to suppress might_alloc() warnings
> to make more correct behavior.

Rather than chaning the gfp mask would it make more sense to update
might_alloc instead?

-- 
Michal Hocko
SUSE Labs

