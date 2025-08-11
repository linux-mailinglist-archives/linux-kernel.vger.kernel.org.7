Return-Path: <linux-kernel+bounces-761893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7842B1FFB2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5DDA179183
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 06:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BC12853EF;
	Mon, 11 Aug 2025 06:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PN0emzbw"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC161509AB
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895495; cv=none; b=KrdP53y62d5bPXGwDbIpxuXjunmQYiHIcVTt6K9qguufqbqQEol67sfmiPuHDG3kImStmMl/b/eIzwmoWDp/XYShx/fT5Qu8GKkCxVT1id1POm5jG7Wulq0KdNKqAwAne3sv+rfxOQDIO6MrcpVEmoeHJjl5xcAG/sQiHSPs80E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895495; c=relaxed/simple;
	bh=mPEn2tUqV0VDvUBivVCyIGNkt25kHVG5g2vC4oAjlTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4iEDAPfePNKStxvPpdqcsuPt2DRHX/HNrWJCkEqzil0wY3WFvYfgo3gkCtYr1t+/jfArD+fh9wIgfig5Kg7SKu7sCNi+WB15JNmd0vviB90rlP2hH4XikBt/ur03dpojgzFXIf69SLRFTNbytjFEmAjYiII48agaM2aLonEmSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PN0emzbw; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-31f02b6cd37so4147894a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 23:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754895493; x=1755500293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qj4hp02pi3+Fvas+cfw51dF8x4V7PPZb3b5a0f26w30=;
        b=PN0emzbw6uynRdmul2tVtnoZo1+B3SmROmVyVgOAHRyFPts8QCvJnFAIsKyRilQ+Cl
         n2QpXFi9s9R1DvNw186YfIECMlbBPfNAPcb9kKRq5GMcf+/oU+Niom9JH/UdW2scpaQf
         HbGOYcGAkWwIXSU6qa1z5L4tS3mMQzH4N1uQf2YTusXisCWhuESsIyI3O/74oU3bihqY
         wEaFjgq+MpcXM/EE8F74kHhUJcIbqJes5hIJtHuF26vIc3xje2zhW8JSph+ggBSRUi5f
         wSROj/3yCxS1HfS09TvMI4yxP+oGw1uo4qfRvjLKWWEtbZjSIrsDak4mHFXD6I3Dupnu
         bprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754895493; x=1755500293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qj4hp02pi3+Fvas+cfw51dF8x4V7PPZb3b5a0f26w30=;
        b=numD6h2p7V+Pt3G+bpybAlrswDK9fb6UKFY/pNs/igJ+8kZ787m0IJF8II39CBTR3i
         /2PiyzzFmXHwOmyAakWXCN/+4kFr9HbM/0Iwcoc3C7kw4cUPJOreGuGXh9/zo3zZhc2v
         hZPFU3pdROkNUQY8mY/uZDADUEnkB1ZIQq1QLvKTqsjVk8R3vyT3njB4a3gwHgxhXMAr
         oAOPjpX9/B1aaQEJzS0e0BPurv480aDkEnE8XRWVTCLWWLZv5IkTFqU/ogJWj1/hnFcM
         OGWDQv4LzF6fWMNjcvZSQdNv2VJF118br53zAXBLuEIsi3P7UWRfMF7kNWk3cOQ2J65R
         I3BA==
X-Forwarded-Encrypted: i=1; AJvYcCXKwsVkvUWXwabS9ikJHIdBzfxb/F7OxTtp2QYlY2j+xnXlTrQV/29cLyK/hj1yKlqiwLiLpXqvjxAWSMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNkAvxz6Z02fWLIohVpJ7fJqkWXg7eByqZ1pf4aDOvH05rlPZj
	qANrSDPpQ61mah7LXYtejA/KLPOFlw0SEh+2dLYJJ5jYT1atg4YLFols3yV/+Wmsfj4=
X-Gm-Gg: ASbGncva87AscjKy9/Vn5U/kJXA6whyxw28vtNd700Vj274389PiJLVWVAJG2HrU9V2
	bMvGWYD8pXLT4n2nlss4eYYk5ECLF+/Om+BJnOmytza0FbffAf9tOj8ZLxc4Hv8aspfvC+/bkth
	1HTPMnV4Ly6dj1MyfKHtOUxwRklHNyhAmkFq2bUrvfvVUfA4PUqJNo/dsUiHHEdzxAfn+p6AyfS
	cn/0IfjVFP//0hCyEBkoa55r8cVVEKY9JzM+37CWBJNnDdLd2T5w+vcnu6JqL2BXzozHP9L8Rq4
	IMERIMoFe1lajS+2zs+mriUt5TZwxNxJlq6Rk39/iTBIDt0ccQbJ+Q0CVldqPDwmjQAg05Pl+5j
	FMsv688jXZQEZEsRLgYWKEH7ZmhMjykXMHYI=
X-Google-Smtp-Source: AGHT+IGLtc7a//OfFj6ZG9+B3qw4ntIvd3AReQNNqvydUWUlWk7x6oot8u6tFdHA1E3a4aWom236mQ==
X-Received: by 2002:a17:90b:4a82:b0:311:a314:c2ca with SMTP id 98e67ed59e1d1-321839d795fmr16326481a91.6.1754895493053;
        Sun, 10 Aug 2025 23:58:13 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-321624ed650sm7427532a91.6.2025.08.10.23.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 23:58:12 -0700 (PDT)
Date: Mon, 11 Aug 2025 12:28:09 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: BowenYu <yubowen8@huawei.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com,
	lihuisong@huawei.com, zhenglifeng1@huawei.com
Subject: Re: [PATCH] cpufreq: Remove unused parameter in
 cppc_perf_from_fbctrs()
Message-ID: <20250811065809.nwfdfjwidoacqtca@vireshk-i7>
References: <20250730030649.151272-1-yubowen8@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730030649.151272-1-yubowen8@huawei.com>

On 30-07-25, 11:06, BowenYu wrote:
> Remove the unused parameter cppc_cpudata* cpu_data in 
> cppc_perf_from_fbctrs().
> 
> Signed-off-by: BowenYu <yubowen8@huawei.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

Applied. Thanks.

-- 
viresh

