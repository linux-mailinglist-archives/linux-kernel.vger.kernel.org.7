Return-Path: <linux-kernel+bounces-758978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6377BB1D68D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48EAE1899A9F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 11:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F97277C9B;
	Thu,  7 Aug 2025 11:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gYlDBY/+"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51058238C16
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 11:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754565764; cv=none; b=WblrDCd6fcqpKGFc5bqaEtA4XYqmsi0UEDGxmVE4APKAeVT7X4Bozvg9JOUszz6N5IU/0kWlsh273AvN71zIsQozkRyKqpve1DVJhNgnFSQQcojzOkPvXieYQU7iNkfJdjLR24QYVHPoKFQWttZAbrGkevIQU1sxi4j5K8IeGrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754565764; c=relaxed/simple;
	bh=/Lyz6Y478XwCWiMxICNCWD29e/SQvCT67SBndBcNMlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoCDXRNOkqwKL6ThNzFM9UXfVVveVl3OG40nXkrGZLI3wQFHHri9XJS3tPHoheSZPbIPuFwINdm5webrSGT0atDSwoZk5CVM+cNn0cB2MED19J1Xanpau/mqx2Af8QwppTHlQGb+uYsk4v2PNNvI2UM2cgI+4Ui7UMW2Z1jRgqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gYlDBY/+; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b785a69454so503475f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 04:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754565757; x=1755170557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZbKQJ5W6ertupco9EzwscMnQ6iskl29md9zy6imu7Y=;
        b=gYlDBY/+c9fa7LQeLKFin4ATfLIxyaiaiqIW3W2MzbxwZcXMP+KA8ESr80/5Iq/meI
         twi1rWPN7o0XE85cGQ9y9/l4iAuhSJ9UqWV2aUrUOiFPU8/8xPDpLjHSNL1tC85hKrXo
         aujVfCyWdxtC6eIrkIpi893PBrGFhIOjWbbVeEvur25IYFYvvEuHrlyqShJVVNiF8MIx
         T17C/AoFvjp/G7THg36IjSb/Ebf+po8REUbrCef/4PQ2mr4T+4b4h1Wlrb1HHxxaY/q3
         EXJaPq1zqaRmuGytjkXf8I5GdD6IupEt3jI5+tIwKMvytB40Fh4HZAONEpE7qwrNs0LD
         oqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754565757; x=1755170557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ZbKQJ5W6ertupco9EzwscMnQ6iskl29md9zy6imu7Y=;
        b=uBPpx7h/gWLRQLMO4QvVC50apmsrSEMAb09myRQkNnaVXbYqMs6jh7hEQhmmSfYkQA
         julPgW98U7ANpx4TQxk147Bs6KPzdKcPwy0AIPal7v3Fm5Rj39DXWWA8Y47LwnmMyX34
         oMlBOpAByazlj4lestUtC09MF44fmotobCggcUsnLKjtefh1K7MCv1UH1J8ApEiqb/sA
         TKEpotC4ektYml11xEHRAoOOU5to4CCvpaFLY0SZPZzmuFrCLHdc8r/AwxLpJdvEpkF9
         8sX8tQ5BaQyuSNODuKmuPOtaHZNQjVM5UOYuSfHr87mQF+zGK6vYjZazUz38Nl2cGjsV
         EhOA==
X-Forwarded-Encrypted: i=1; AJvYcCUNK6cAOinYZcQb1YVru1srhB/78gVeGqLpD8tS18ZgvR2PAuc1JMXYdFlqXiBzVoW+NCxm7x1IjOfji38=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvLy9OYrrKMfu3oLWjyWq8FXxozSvsVukY9LZam/mrYyl0oAoy
	1PByomFcYlt/PWLXleqHjutY04YPB7tCOhvqXcOj4y6q59ONGLLLUOx4TrL9V+Wxeqw=
X-Gm-Gg: ASbGncve1yUiSIiPmOcdYF6rJoLiT9I/2jezrIayh0oXujG6wXt8sWIhG+/ISSBDMjP
	L3u9X3payn4grhYgproeJnvvyp3UZLkh4hRkiZCCcZzOreUIbbvCNgyiACwOUSj/Vesp8sC0WHO
	lwLqON/bNb8OMlXoZ/9+QBF5SHJLq8Xai1RnWy1VPhDOUxEqtcv7ujRsgpU6VCV8xFTAruKBcUc
	pm0uz5M+06WrGokDsubIq/hgsPMep9zpwQg8M63yzmzUsRgbcjTbaZGFaTh0n0Nme/gW7Im9i1D
	5sQixGXJm/pgaiio16HwdtzuYEYNcL0q/QA64QmW8+Rdh3BleZwyiDY8twGstjTireoJFKZ5KQg
	HQf/v5P7ZAu92cAKCDtjeVG/y94iMuFiAKmiGkNXW1h3x/g==
X-Google-Smtp-Source: AGHT+IHpcvEuPhORaYXA7n7MCRIWBnQ/M3PrlPL9izMPtoJsoR7KrAC2MiYimpXbbI1MYSV6/obt7w==
X-Received: by 2002:a05:6000:4201:b0:3b8:d15f:45a2 with SMTP id ffacd0b85a97d-3b8f48e2e45mr4360108f8f.14.1754565757391;
        Thu, 07 Aug 2025 04:22:37 -0700 (PDT)
Received: from localhost (109-81-80-221.rct.o2.cz. [109.81.80.221])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c3b9c7dsm26206779f8f.26.2025.08.07.04.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 04:22:37 -0700 (PDT)
Date: Thu, 7 Aug 2025 13:22:36 +0200
From: Michal Hocko <mhocko@suse.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/8] mm/vmalloc: Remove cond_resched() in
 vm_area_alloc_pages()
Message-ID: <aJSMfJhBOltRiSUh@tiehlicka>
References: <20250807075810.358714-1-urezki@gmail.com>
 <20250807075810.358714-5-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807075810.358714-5-urezki@gmail.com>

On Thu 07-08-25 09:58:06, Uladzislau Rezki wrote:
> The vm_area_alloc_pages() function uses cond_resched() to yield the
> CPU during potentially long-running loops. However, these loops are
> not considered long-running under normal conditions.

To be more precise they can take long if they dive into the page
allocator but that already involves cond_rescheds where appropriate so
these are not needed in fact.

> In non-blocking
> contexts, calling cond_resched() is inappropriate also.
> 
> Remove these calls to ensure correctness for blocking/non-blocking
> contexts. This also simplifies the code path. In fact, a slow path
> of page allocator already includes reschedule points to mitigate
> latency.
> 
> This patch was tested for !CONFIG_PREEMPT kernel and with large
> allocation chunks(~1GB), without triggering any "BUG: soft lockup"
> warnings.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!
> ---
>  mm/vmalloc.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 81b6d3bde719..b0255e0c74b3 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3633,7 +3633,6 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  							pages + nr_allocated);
>  
>  			nr_allocated += nr;
> -			cond_resched();
>  
>  			/*
>  			 * If zero or pages were obtained partly,
> @@ -3675,7 +3674,6 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  		for (i = 0; i < (1U << order); i++)
>  			pages[nr_allocated + i] = page + i;
>  
> -		cond_resched();
>  		nr_allocated += 1U << order;
>  	}
>  
> -- 
> 2.39.5
> 

-- 
Michal Hocko
SUSE Labs

