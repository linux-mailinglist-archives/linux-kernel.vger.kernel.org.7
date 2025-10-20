Return-Path: <linux-kernel+bounces-861292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 722EBBF24D8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 226A818A50CC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A12283C89;
	Mon, 20 Oct 2025 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="rkXE2R7r"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227FF26B2B0
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976346; cv=none; b=klWTSmWrqqdre7XalGLcWj8skRV3a/B9Ctz9p4CzSRyOEa2gSYrzQGDSgcOiCcRorI8NkCogtC3wQpbF7iELAUEafSGsxzP8pnkZ7YbUlpaThWRtS4SA338WZck695h3GsXs0qBs47s7zpnu/LVpAchwuOFRYs+Ln1UbQ9bV7bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976346; c=relaxed/simple;
	bh=qMbp2Diy4U8QOB57q1OG406eTNxLv51sA/JgZoIVxkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUHP3H1LphKDjC/5Mm489gE0QS2Z6eh3YBKKVDPNQsTpO4f3RYcxDafSJ3D0CrQ4oLodSA8wA4kI/nbvzs40mbEl+G7c80BOxJvBgJUM4P8THM6gup4FdLE1PPnYT/FFiqnlyICBPWNJBRG5rbNQCldGbwQ+c84LvFoN5vS5BRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=rkXE2R7r; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-87c148fb575so72436926d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1760976344; x=1761581144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p4JsBaddaRYoEAs4W8WEBwtA+SYjh8zLzD82hzn+tek=;
        b=rkXE2R7rkqoNJUK+RD7jTuveO/WEnn0dBcwX09GQ2jAij4DUWkcOnWtDVXIp0W4y58
         BqloU8n6CKIVXDV3QUIj0SfEseW55YYjMsh292rJXI90CuOmCy94MukGbAIlO1kCkZh0
         bOf+Pv0Bz2whfhwSd5owJcyE6+vQUxQoRXCpnBsjKveiqu38AoVKyaWIvFtBYaMJRC81
         vkU+VV79cX4hMEsEvb6IPHZDeFMeA64NPj37NWDp88bpjsA5h0/cJmpcFonC+6IGLPAN
         wDiLQyvZJfSs1X2cDc0EAFQZ5pdIJavaLa7quYmWzoOOCGNEQFAFmhc7/badG5dKn6Ka
         EPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760976344; x=1761581144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4JsBaddaRYoEAs4W8WEBwtA+SYjh8zLzD82hzn+tek=;
        b=n0phrourmf1AfHAeIflCHxzw7/ko/trHE+n6eJLlIjeHdDsamjoF3H1W9d/YivLZF5
         f/ZeNGInWnAaR74qfPQAdMVd6XxAOYNwmzRiw5dGIkMvjpQG5NCeKHIbgCiBMPgKbuGd
         L1r7tbo2nXTAaExWlMEqPQYzJi8Fc5Tz/J4AOtRSWXKC8N8mKy79xoixGNnVBjcTveQS
         /dnoGto43TIRAReypAxOGDr+MPMlyEuFwp/g0d+pOGisulZ4DoCr2+KpL8I1gSAC450P
         Si6lOU9bG5KNmUMpnrLmM9AMb00IBaGGiuvn0bY8iczs4KTIRLPVJHVtHJuIOy9r5ByT
         FHtA==
X-Forwarded-Encrypted: i=1; AJvYcCUXRBcXh0pD0tg0fe2EdKuzvJps+ch/ZMJI9tjDexVeVTTEMCWWjt+qpc8er6cXkr9oG76fWM4zD29aOVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtX2AkKI5ioUBzgdqOEVkTCU1DNub6PeTVkcZPS/X9NkGFGmQb
	Cf3Qd/+89pcQSD+jw8i4/VPdVX0taTHw5WdX20BrHA+eYn8rvBQx8x3m76prZsOfEPE=
X-Gm-Gg: ASbGncsrlzs2kd0sBt3rE5IOQYS7aazLmA8KQH2P2YdvNFdLereFtHAqE4HbJNTnhuH
	54fJ0N+FsT4THtOoN7bTQNzl8aNYdD+zrM2wZepAU6TcndtXmEK4c8GCDd19PAx8KMF8ghjBBvo
	u1ASaXOv/ma0ucH+fbkEbWxFDqxB0xNudLyW3sMoLaMnt2t4fRx4+IZhayf+Ea4FvDcZc6LP/J5
	cC5Z7yPpYj85fZR8FFItWdGzT5zK3JqQDRj0Rgz/Yfam62y8x+bH5DKtQtjEtP1yKrpzmyoo7Bn
	MLq+W/1l6dZkYww19dHackNC9owARsQ5U2pkRRvKMZ6Ri59C00L+KiAO75lOcPjLD3fFZdGjkPk
	DyWiIKDrAfxMfenr823Bqk1o7tRxpOhl5+oShFkSVgq2BlPTOLDNTg9aFLJMvdnOYs8dFMR6IL7
	9PqmqXk044ybYYZZ3jcsf2F1Pd5GcW5TxbmqjmWB0Wezz3RQGuzVYwfUzxpnE=
X-Google-Smtp-Source: AGHT+IFO0Fmmp1MECEFi2jzErsOgbxowWqJ/ySBor/huje/sLrMYVoPz/DTL50HIV6LVQv5D46sXow==
X-Received: by 2002:a05:6214:230c:b0:87d:e2b:cdf7 with SMTP id 6a1803df08f44-87d0e2bd165mr123924826d6.66.1760976343811;
        Mon, 20 Oct 2025 09:05:43 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87cf521be67sm53378076d6.16.2025.10.20.09.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:05:43 -0700 (PDT)
Date: Mon, 20 Oct 2025 12:05:41 -0400
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, osalvador@suse.de, corbet@lwn.net,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	hannes@cmpxchg.org, laoar.shao@gmail.com, mclapinski@google.com,
	joel.granados@kernel.org, jack@suse.cz, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
	Michal Hocko <mhocko@suse.com>,
	Alexandru Moise <00moses.alexander00@gmail.com>,
	David Rientjes <rientjes@google.com>
Subject: Re: [RFC PATCH] mm, hugetlb: implement movable_gigantic_pages sysctl
Message-ID: <aPZd1dAIzAw7Ii8E@gourry-fedora-PF4VCD3F>
References: <20251009161515.422292-1-gourry@gourry.net>
 <6fe3562d-49b2-4975-aa86-e139c535ad00@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fe3562d-49b2-4975-aa86-e139c535ad00@redhat.com>

On Mon, Oct 20, 2025 at 04:17:06PM +0200, David Hildenbrand wrote:
> On 09.10.25 18:15, Gregory Price wrote:
> That could be supported by allowing for moving hugetlb folios when their
> size is small enough to be served by the buddy, and the size we are
> allocating is larger than the one of these folios.
> 

I think this is roughly what you'd be looking for?
~Gregory

---

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5549b32cdd31..5def2c53092e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6922,8 +6922,12 @@ static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
                if (PageReserved(page))
                        return false;

-               if (PageHuge(page))
-                       return false;
+               if (PageHuge(page)) {
+                       /* Don't consider moving same size/larger pages */
+                       if (!CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION ||
+                           ((1 << compound_order(page)) >= nr_pages))
+                               return false;
+               }
        }
        return true;
 }

