Return-Path: <linux-kernel+bounces-769010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E49B26922
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3613601713
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84089199E94;
	Thu, 14 Aug 2025 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="snCVYQp0"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C9332142A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755180438; cv=none; b=orfxsf6x1qUzIcEpXOdc4SCOYyPAZKlTRegZNUjTg3mdF3omxHQfNsD6Zr/VZK86sm6xY5Aonyakz86twli8PrKNuGSl/kdfQ8Jn0uTenY9hPKAkjTYX65PmPRcZ1xfwjIwRkcguGn7FOlxXuoBRnLCWB+FD/W+4/VvTX/LubIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755180438; c=relaxed/simple;
	bh=7d2NSpvQZW29J09ehkm+qQxzsLpbwZDN65BqtbcIZHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRjCUFuP5SGebRJ119HhgVvbD3A+Wg8Wfjh8mEccZnBW0wAiIr4sfUMVG4KMLUxF9e6L40W0FfMO6+eCAoSlvF+Dc+MSpkyhounVtuMNLmGpkt01M72vXtDhpA8CUTM5stY9sb4qKb7xP/kc10IwHd9btsxRRQusN75R0oxuvX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=snCVYQp0; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-70a9f6542f7so8295356d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1755180435; x=1755785235; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wJHKe8l+vOKZy8o1OFSDsfg10P95a8j8COGNf7Nlfyc=;
        b=snCVYQp0S0w+tsHZ4Qpq4pfprYqud9oKpTHNzrJl7E34Xb+9qDQcKB+4ol5f/rgSWb
         pdl0nqoms2mwXCVeO02P96bsATvxEwkzSaEDbZLDSm2x2POdBbUujLp2vDgAAhKnPBpL
         r1mfz6t6OfchctAfw6uCAbp/bIpXKKcCsWUSKSTxs7h9ZzgteSOi4nTQN46nSbHMO+T1
         nXfv36AAqK//dWMsdfj0FTGlwG0aKIY/NDOTWwcmkxZrYEerVT9WLYHkQxoChdTul4Cm
         mFMQCAGQ6lY0+Fyk+1m5X8JFwcZl8jF1hOLttu05a7Ew6Fpwqb9R23fn+xpzqo3fqy/W
         j4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755180435; x=1755785235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJHKe8l+vOKZy8o1OFSDsfg10P95a8j8COGNf7Nlfyc=;
        b=v1IsnMBj9yVRLhLBTPJnLmt0oxcuy02sMfMOU94ilsH3oKpHZPQRZ458pAXdpiycrg
         0mTbtnJEIYkPlmiwWNuj753enNxivGvFQgFHRo4p+hHPEcyXvL80hiwe1P5htZA/3q+3
         YXIh1jtmm3QTh7x0IXWOzndM/YBMQWrxnaxSxyg4J90W3n7CB/Wr4bgLvfwFBCrmhQky
         A4GWwgOkay/O6+lUA4/TLJwuI9RymrHyBmBtH2tpPVSii/dd9wkaQohwoJzCnaKMNP3Z
         4SgCMbQSN/A0+ygSSRVe7fWm3ZwaCGtoYeOPuX5EEEHHC0Xa2I4DeBUeR8ngGPXh0bsb
         Q3IQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO0ZGMW1xOZubwDY+oW9BYUKI+JETigQz9BdIsD6Nv23EvPk1kgr23Lu9yisPhlofh5oulOSsklRTBOHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFQEO7ecROHobSm2kI3OkVxotRJo8hMoIBWVxvJ/ujT8Sj2USM
	KOeib6i6M1Ws+WwmHQMwiAdK7ET7WnwFmDLCpTLaTMGBRQ3XL4HdL4ii0t4Nk1vrQ3M=
X-Gm-Gg: ASbGncuTPAKSb1EhmSg2bqa15KKkkDICC10IlEEcqKvzSByxsDQv5OnIlb+YuhDXcvU
	bGsCnAU44XGWdyiDjJ14tDiKuz+2+gCFmCI2N8dVRaXm5/MG1zXX0I4uyMGzHeKfemxijpMobMD
	yvldli79KHEw0BkJFXCayPdJmLbZ1P5oD63plgiDT4oWFpz7LVV88EJ+p0LQE/3bVAuKNbSnLDR
	4E33CCXnOMLz59nwHu7GqAhmjWes/0Yj9JCixK6lQjW7eKx8nJLXdHWZGOBdVubMzzzPb/3IjWX
	isNrH0yW0iMWK8wUnsX+ZW4sqo/A0gl3nSTQridH0trV/wSq9eNLd22HuI5KupZl089k6IuPKsY
	5kqx+v4tPG0VHvzZ3d9Hh9w==
X-Google-Smtp-Source: AGHT+IE+zn5U6MmZ5wiWKWqRM/hTgkUWWNRCtt+8nHxw42gEXznrNpPz9mjYvN8GIlVo+bY/DO2prw==
X-Received: by 2002:ad4:5bc9:0:b0:709:2ab3:17ba with SMTP id 6a1803df08f44-70af5c8880bmr40814616d6.47.1755180434870;
        Thu, 14 Aug 2025 07:07:14 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70af5c68911sm13437716d6.85.2025.08.14.07.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 07:07:14 -0700 (PDT)
Date: Thu, 14 Aug 2025 10:07:13 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Ye Liu <ye.liu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Ye Liu <liuye@kylinos.cn>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: simplify lowmem_reserve max calculation
Message-ID: <20250814140713.GF115258@cmpxchg.org>
References: <20250814090053.22241-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814090053.22241-1-ye.liu@linux.dev>

On Thu, Aug 14, 2025 at 05:00:52PM +0800, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> Use max() macro to simplify the calculation of maximum lowmem_reserve
> value in calculate_totalreserve_pages(), instead of open-coding the
> comparison. The functionality remains identical.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>

You can remove the {} from the for block as well now.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

