Return-Path: <linux-kernel+bounces-770283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BC7B27955
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F4105A52C0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 06:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC1B299AB5;
	Fri, 15 Aug 2025 06:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJh+5Le6"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE2342AA1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 06:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755240211; cv=none; b=oONlz7JhU4NW82QYocXxkg2jjQqveWcqF/F4DfZ/rU8pY2WIsdrVGqGGJa+/yriSAP+/u9/xjQtnZiYNFhm847uXe3oDIPXwm+YtbdNxX9P32tQb2sLaZmAO9j36A6G0ZLxzDeAp351z93KEZdnHBiK6hxUVzUCUellvDeaKPHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755240211; c=relaxed/simple;
	bh=xkCLba4G6E1+UldU9eajjTFLYGvxB4goimC/qTArDEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3hO2r/qaIa5DFlVGuL8+xrLFoik0fkl34Hp4b7EWAqoy5Ylzhvc9RZ4fOEh0KTcUhK5hqI1Z2nDgaTKohSdxvHud8wZ7oeLbQcQlN00f9vf9YmqMKO5molHUuYVeiYm9LSuWIpYcwkBiCtaUH1LEQ5aTOwL+Y6CKLEgMG4+s0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJh+5Le6; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6188b656412so2518071a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 23:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755240208; x=1755845008; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQ+FKPOPxHYzBg0qRiV9WQnD66XSjRAhVwtd58VUZ+w=;
        b=OJh+5Le6YOoYjHQX8q7F3xyTN6cQJO7nDg/CsZH+fXWZnyeDOAPoRFI6QiEZu/hSRm
         7XfpdmZ4AKu/U9RbCGsuyvz9PutJPfNXAef0u4JCS9uHu2f35OZCEq3wl/qUmHQvXVmM
         J6vZNGuNJZJyemLvyZu51+IboJwm/bWct1uHdBSFWgaLD9/MffyKCM/SaQILpS1VuWFj
         l5eGSrZ3ULkivr4mJDHO58YvLakyXcO0+5V9geQ1SwU/+0Ynf3QkfBjYmdc5GZ4b/oIk
         5FKd0FwNuHNcWVOCojpJPWsTwmDa5qugPtFjFnKzEDhH21ZLaesilEcAPxgPSGyFoiTl
         dZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755240208; x=1755845008;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RQ+FKPOPxHYzBg0qRiV9WQnD66XSjRAhVwtd58VUZ+w=;
        b=hEgLvmfq7e4pqvVKJRbNiOYNFrgsAvW5HYfw+NJCPdLWXLoeeZSy9iT3GNUQhX/oP3
         3JqC2X677OPQRgTtfBd8X6Cdtq+z/BdQcClsRtR58zFIYF/aZrk4GIEPgYA712XKjwnZ
         eE91aY4S/A3gsWpNV3jkTb3BD01RiIsGxU0gsU6T19IBdu/e4/3Cmia/oXAyBPL9nMyc
         meqlc8NN2z/MIyNLjXvdq4qxAyIMDf6TYzvVuLkjT82zo0KxerR9DQuvHtuGc2qN4seX
         ZbartihGTYOKTg6JU0F2JP8Am2V/2HI3XImzHBo+nnN66VZoqQrjnLcW42eb0x0GVvVE
         G03A==
X-Forwarded-Encrypted: i=1; AJvYcCV8lm5sMQrL1hHoL0Vaq933Vicr5e05P2iqiCGLDrX6BV7vGqoXU6EzkYmN4cltovUvWD9xEIo49B8ZBR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8YS3bhApES8rulOkxRNvzYubi88V12Qxpr75GGmo1X9me1Jyr
	GdR4yAgTHjynibjorOymE/WZJRdahcyojL1RSVmSAvKTXvGGlPgg16kHkyBn2zzO
X-Gm-Gg: ASbGncuFQyfQeiUgbjqREX5UVp1AC0MKtG5xF6bb9JSrDmIEbOSGcrBuck2ov3Cp4ka
	9xOcpBtA2Do1WnVIwDY86FWWcQTRAd7R2YOZVSWNUW4hAfBDJyweLhhECNUyh2Ilekv5M7ORviY
	HK5ITUuFDfWxp9TyB3U7hK1U4+q80PM6Ekom0uEaBkuMztefViARRFA7HOsCDqBMbugn18eXd5y
	L4mnnM6s2cJQFBiKlJLoVSXxbFJALkf5pUUwpkK4TQ9Ep8yZZ/zOQHpZ0HUpZNGQCxbgEGDXPZf
	GJEyQ1VYychGwhrH6ZBAwL5KRHeMM+15ITmlPZS3cimQF47lvZ5v7YS/7ZQXtDQvTgJ4UGtwEc+
	aNt9mOfvhYkkMtHiKk14IQQ==
X-Google-Smtp-Source: AGHT+IGPFk4+EoYus2GiJezFDslbVAG50BHI7St5CSnh5npe7++NmJQ+qpasnKnRTuGEMgD6zS98Qw==
X-Received: by 2002:a05:6402:2713:b0:618:1485:3749 with SMTP id 4fb4d7f45d1cf-618b056089fmr728966a12.18.1755240207429;
        Thu, 14 Aug 2025 23:43:27 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-618b01b5facsm727726a12.41.2025.08.14.23.43.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Aug 2025 23:43:27 -0700 (PDT)
Date: Fri, 15 Aug 2025 06:43:26 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Ye Liu <ye.liu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Ye Liu <liuye@kylinos.cn>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/page_alloc: simplify lowmem_reserve max calculation
Message-ID: <20250815064326.itngdnefuoihlk2j@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250815024509.37900-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815024509.37900-1-ye.liu@linux.dev>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Aug 15, 2025 at 10:45:09AM +0800, Ye Liu wrote:
>From: Ye Liu <liuye@kylinos.cn>
>
>Use max() to find the maximum lowmem_reserve value and min_t() to
>cap it to managed_pages in calculate_totalreserve_pages(), instead
>of open-coding the comparisons. No functional change.
>
>Signed-off-by: Ye Liu <liuye@kylinos.cn>
>Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>Acked-by: Zi Yan <ziy@nvidia.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

