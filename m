Return-Path: <linux-kernel+bounces-792545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFA7B3C568
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 00:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CCE0A084BF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 22:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C422D876F;
	Fri, 29 Aug 2025 22:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmQP6/9J"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5C68F48
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 22:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756508134; cv=none; b=keJmv0bfG8oUGgnKyI7t1jKJJw7FLDXCAtwRPGwuG6AVE7lt4Zv1rg6FilALlweSB88BmxSSfYZwyJjUu76dT6gzzjWqycIQyI+b5ZlqYJyVA2d24nZEFjSsGhkyZAiES3ic7IlegMkK81YLC867WTMIeWRGavvE7EjrQsK9Ja4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756508134; c=relaxed/simple;
	bh=rGX/TkuoLTBFTC/IzaSiJCs98c7+wkk8E/mxNP8KWRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvUQ44A4z0GLyGXpI5M1CNgx2t8KxbB3dDKMpWV6HxL1gdKZoUpXFinIngGRsJgSIw7j7FvY7RGIv9aD5qT1gexOyV/QyWtWWUz+7s/iJtEvNyGUqZ9QcByq8RxuNsF2y0g5f7KpE2v4g2S4UkftILfA1JiuDFkqp5OAp9dthY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmQP6/9J; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32326793a85so2140927a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756508132; x=1757112932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lrAJaMy7hduOMnREthROQoMMaESzxew/avDD/RyMjuI=;
        b=RmQP6/9JPiUoJwOpV0sACu8uLvxkxCtJEUPGSEKtt2P9cm7Tz4lkE1KR1RiB1wYiqO
         2hwM6rHJadqFDpBGX/dSUccLGusSVn7upEI/1OiEWBkYtO/GUBR3jda1yBywkn2Y7qiC
         /ypmVC3VHLIRsCXdGGn4okD3DyYO8QC7giPBtQx9tMfWCnyS+HVTGVVcYFb1wlfteP9+
         jM0z4u+j8eUZfyH1iGEnPZktJPcpA2YhfHHibVEs8H0Ys+U70NdnYWYBAIAiDGLpL4gg
         5q4GvJKlQe6iJ4fyJumh91TVt3aeROOxONtVTiqUAslApduO0OCVd3Qc9Bz4Frc3K9d3
         imfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756508132; x=1757112932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrAJaMy7hduOMnREthROQoMMaESzxew/avDD/RyMjuI=;
        b=ZpoKuMMIJXRziU/w+o3oY2PkpAlCu4kIW577y3gJfVKyx+T7l7m9iT3r4iX6HatHWc
         Hlz47sLqruDs6OsAphNuwK9fzMOUvBlNUcB85PVbfjZ1E2r3+106rvO/DJYe3/ZM8Nhh
         Yw0PTdyGAyHwC/eyF6oEL4ofgvyzAo/l/BWehjbKx4mb0PUUio0Ih7cYCrM9rPTCYq18
         6eMkxI6h7fzDthPuRvam3XEFcjIb8BgZcnoDmzxa2Xu9yYgwTZCzTsyvEMjQhyltWy6z
         9QGJJpauJJbMlKfhFKO44Tx4eU1Z77Yo6loj/foJ7mdUWlDvSsiRUGj8OcTwIIyEFyHs
         HmsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDA0TeLcBBeoSiiDgLrgVVK+D6oiow0PndibdXpQJbD4yG5xJf0HUdddDjdSMv5UjdiOZs4giNkHSkis8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhXSAevmkbS7p26VOVeZV2CCz151Ew/To8xueK8yR/57noRn7u
	AGRxAmWMjed4rRWLcZ0FabiHfbhM+HoHQbhxr20igZscqQ52wtHQtM/M
X-Gm-Gg: ASbGncvYqt0IzPNWrOYJiytumyvnmc9dYHo24zEczakmdJOh7pBUnbbo5nPFJm0CWM2
	Vg5mBq0yA88iA5tvmkhT3QT7Zx0ieytd3dMU8iduyv7wnHvngYQ25dfvEFXqpP9CwDm7O/83JEX
	VRaNYECp8JeDrAw9t4Z3KiWHd5xQ2ZlxoQdk0b2+mrfpgWBKNZ78e4BKuxrQO9mLfKBM2hETIHZ
	6fXOc8CZLUd475qMKVm8n+lfBHyxaYL6NJ44IAVORpTTj7B0wzQzcL/2aMstusJev1K/fBMVDdr
	8CtGqJMj4ylppHewyjgWoy96FGdtklh04J9GNZZcnAMdttZDd4X6Fnnqz8V0Rl3KPdPoDXNgVXr
	zBG/Wbvv17xEswTYuqxmNsJNwR3io3dNnhG77D3qssxRvbXQQbP/fVg+Jin0dIF1J
X-Google-Smtp-Source: AGHT+IFrPKnFakJua/gvKlF1EyBAEQ1oDkAjCqkDWD0uLjDx3iCLSPNR3Qp/0MhK7vYieeKeFiT0lw==
X-Received: by 2002:a17:90b:48c3:b0:327:f216:4360 with SMTP id 98e67ed59e1d1-3281541434dmr400473a91.8.1756508132438;
        Fri, 29 Aug 2025 15:55:32 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276fce1160sm9304701a91.22.2025.08.29.15.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 15:55:31 -0700 (PDT)
Date: Fri, 29 Aug 2025 15:55:29 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com,
	yuanchu@google.com, willy@infradead.org, hughd@google.com,
	mhocko@suse.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com
Subject: Re: [PATCH 02/12] include/pagemap.h: add `const` to lots of pointer
 parameters
Message-ID: <aLIv4ad8iaZ9e10B@fedora>
References: <20250829183159.2223948-1-max.kellermann@ionos.com>
 <20250829183159.2223948-3-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829183159.2223948-3-max.kellermann@ionos.com>

On Fri, Aug 29, 2025 at 08:31:49PM +0200, Max Kellermann wrote:
> For improved const-correctness.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com> 

