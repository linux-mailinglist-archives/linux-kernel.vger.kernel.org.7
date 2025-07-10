Return-Path: <linux-kernel+bounces-725958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D6FB00605
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33093566288
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F0F2749D5;
	Thu, 10 Jul 2025 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hygZvzP2"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC422727F3
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752160130; cv=none; b=KM6ESDX2vKFh+ozYSe7ObfVjAKgvWsWkME19yDn6xN66uELE1uIAynp7VMcSbpOeKRYCqoBG74zyNvj38/xsD6tQXEpMyy3O+sg2V8Y1c+7RczBrKZ14GKzmQhtnxYLCyrkl1aTjhxhgore87aKjVFcdI0UgnQdwXwFJ6tnVqqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752160130; c=relaxed/simple;
	bh=QyVa336Ax4fYxIVQnHT2lv1xl803ARX1EKCvvArbBpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qyWX2My1IhfFqR0mj37JJL+0mN0hLJza3lMvkxy0vyBkDOWu9I/i5ei3W9eHdAdRZiWWMj7INFkwq5F82/lJiJAMWUNFAx+tGCqDzQzIEwtdhVSzM0UzoFcn3u06EEnvk4z4xhuI/SsZ+/VQIbkc8Z/qB7vS15qLk0j8yI2by7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hygZvzP2; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-86d1131551eso39737439f.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752160127; x=1752764927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ge1nC4yCBIiNPQ1G0qBajhIAzAiOK+EhF/zLDgsIM/U=;
        b=hygZvzP26whIkw5yAmbYEnJbTkbkptUkFYL+QQqXQqP7RQ9Z/WHtj1KVe+IchID8uo
         z5Uz0KBbeDaPrn+1ds8EXobtSe8pmxU2q5jxYg/I8DD5PtsbsiyN4xYuJiwJnYG8k8EF
         GEu+5BVrt8igKHkHv0TSnujJhRWTmkAtYDRWyZH0Jxq9Ekbeeko3dx2FzfW8MRFG6+t3
         xChK9WauqbAgU6iQ0UTkMoHCfRqv0j9Oe3Z0Blp0y3MU/TWlOfo3sRgLRbTcPuANCdbL
         r5joFfAuF9HKTm+hmiAiY20+P+41wFkxHQvwdJP4h7vwMhCo2bfkvFHc2Ut5J1Kb6gEf
         LlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752160127; x=1752764927;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ge1nC4yCBIiNPQ1G0qBajhIAzAiOK+EhF/zLDgsIM/U=;
        b=C9UztDrm0DQOa3dPpEeq3XwZzZMc4xKqBuH56IXjHcc/BMiLdwRn4TyiPoCKlMeBEs
         TIhqUhSrEbBi59HfqTJen3eUd0OktYs0tYZNsz+/tKSTY3u0SX/kSf+5q6E/8iq3rv4x
         aDiI6HMkUprZlKt1x+SKxOhCwils1TpFsIxoAuMmJW8ZDyzRh4uKSlcX2a42a6trUOwi
         elQhn8XRP3Kyh86mnYO5X7+H+u8opj4PzESANdwjwm2JNqnGF97SLzZmFeGnF5cFowmO
         OyKVbQvaecXLPUapH1K3JQvRaDJaO1AEXcGVJE6ELKEUuOZkR2xAkA8GV/H8kT6f5LMM
         NI1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZ6oJgcxeZBifnxKFCvkeVZ4FGk1da6yrUQAaRsZVyHVLpkiHAqWoLcG/c+SqFFOMUxypa9m2n194hA/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz2/rTNBcUH+v2yMNd3tbsvigkxju5frA38Fj/OvTsknvjJ2oI
	eg8AFJh6WlNSqMR2/iSVG/w7jzvloc3jIQaTh48S9YpFHJ2P0d0/3dYiqlKfriU6UIE=
X-Gm-Gg: ASbGncstZarLHA+ZNjIi5+vF1VPeFfBXpjxyG6WV6M3o/RhVbkYwg+DnzbLP3J+2lvp
	szC6Iz06ao7DZhddkRrVzcPgtFvfhnaDUU39GF7MS6HwssgkZhA61k0ZROxstMO4b6y6xkWXYSl
	KVuEs+acBXopQpsaUPyM34obR9jJu1lzm5C4sx3c/3LrN0/N4v7dJGtMNQzrX6jk/zKWaTuRj5g
	p64p4dix3bjD9dfIdVV33fytRdmlUUx7sKL0/MAwUGK0v1LhHWHV2ypgQe88HCWnRaBb9azXBPQ
	R3FtDCFncMGdAfe7RYmZkV1A7UHloMSlpL2CTnXS6ScwHiBE9zJcBi15NRWMiNMl0sDmWA==
X-Google-Smtp-Source: AGHT+IGmdMCnI9PM5J20YVfQZv3O6vQotnLPNVuRWKQQFulsqOrvRtJsNYHyRleOJsO9cj/dzaQlSw==
X-Received: by 2002:a05:6602:13c2:b0:873:47fb:a455 with SMTP id ca18e2360f4ac-87966269ef0mr451794739f.2.1752160126577;
        Thu, 10 Jul 2025 08:08:46 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8796bc5bc60sm41323839f.47.2025.07.10.08.08.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 08:08:45 -0700 (PDT)
Message-ID: <04620cc5-7c3a-4e4f-87ce-b691d9b57917@kernel.dk>
Date: Thu, 10 Jul 2025 09:08:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] block: sanitize chunk_sectors for atomic write
 limits
To: John Garry <john.g.garry@oracle.com>, agk@redhat.com, snitzer@kernel.org,
 mpatocka@redhat.com, song@kernel.org, yukuai3@huawei.com, hch@lst.de,
 nilay@linux.ibm.com, cem@kernel.org
Cc: dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
 ojaswin@linux.ibm.com, martin.petersen@oracle.com,
 akpm@linux-foundation.org, linux-xfs@vger.kernel.org, djwong@kernel.org
References: <20250709100238.2295112-1-john.g.garry@oracle.com>
 <20250709100238.2295112-3-john.g.garry@oracle.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250709100238.2295112-3-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/25 4:02 AM, John Garry wrote:
> Currently we just ensure that a non-zero value in chunk_sectors aligns
> with any atomic write boundary, as the blk boundary functionality uses
> both these values.
> 
> However it is also improper to have atomic write unit max > chunk_sectors
> (for non-zero chunk_sectors), as this would lead to splitting of atomic
> write bios (which is disallowed).
> 
> Sanitize atomic write unit max against chunk_sectors to avoid any
> potential problems.
> 
> Fixes: d00eea91deaf3 ("block: Add extra checks in blk_validate_atomic_write_limits()")
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  block/blk-settings.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index a000daafbfb4..725035376f51 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -180,6 +180,7 @@ static void blk_atomic_writes_update_limits(struct queue_limits *lim)
>  
>  static void blk_validate_atomic_write_limits(struct queue_limits *lim)
>  {
> +	unsigned long long chunk_bytes;
>  	unsigned int boundary_sectors;
>  
>  	if (!(lim->features & BLK_FEAT_ATOMIC_WRITES))
> @@ -202,6 +203,13 @@ static void blk_validate_atomic_write_limits(struct queue_limits *lim)
>  			 lim->atomic_write_hw_max))
>  		goto unsupported;
>  
> +	chunk_bytes = lim->chunk_sectors << SECTOR_SHIFT;
> +	if (chunk_bytes) {
> +		if (WARN_ON_ONCE(lim->atomic_write_hw_unit_max >
> +			chunk_bytes))
> +			goto unsupported;
> +	}

Unnecessary indentation here. Why not just:

	chunk_bytes = lim->chunk_sectors << SECTOR_SHIFT;
	if (WARN_ON_ONCE(chunk_bytes &&
			 lim->atomic_write_hw_unit_max > chunk_bytes))
		goto unsupposed.

Also avoids splitting a comparison over multiple lines, which is always
annoying to read.

-- 
Jens Axboe

