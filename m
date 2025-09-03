Return-Path: <linux-kernel+bounces-797895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E6CB416DD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8225E46B4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3DC2DE702;
	Wed,  3 Sep 2025 07:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qmofkps/"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B45F2DE6F7
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 07:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756885038; cv=none; b=WAq1N6YhQjwqXTYnAxmTPPUeigzI16rZnO0A9yW7Jk7tPVsb5PlE8Bi+4r3vWyDxjdgmDYAXV/IfwmcZbqAstR6TkX40qnduh++DsH05FopPAkwd6RgonBP32lvwEu9wDrJ5Ko0E6909ghZ4qrAxxDYibaVrQj6atCJlOM4f0Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756885038; c=relaxed/simple;
	bh=5/z87dqJONhRttw2oqyDaG2i79PBkosP9EhsOOLmELs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZ5CAksJ7OKCqIhobJQPZY0MaXWaO7I6j9IXbX4wfCnDf1sX1tO1/3I4IC5TT3Zo2S0UsznMx0mSaDOzd9HhRrAvRJdcXQCQ9jWuKCkiiFxPKbQwoeOywp3EDQIhsltklBkZmXNh5zsD8nagITNii92Jf15SPrs6vN6TBT+B8LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qmofkps/; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-327f87275d4so4948869a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 00:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756885034; x=1757489834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JeEr6faqcu2IUu37d/6zjI7aex7l+0Y0LxEBdw8Qllc=;
        b=qmofkps/deI7dbnZkYGSiqjCWwJjM2QmBBObpHXnTflSiSUTXXG27CvSnRiYivqqAj
         iZtDBcu9gkP0WugxCyovGRswJgu7WRJVfThc36JbzRjRpGFhGIhEKJW1MRjkmaz6/H7X
         Pr+j8qCmhSD7OkoAYLEOcNYh0uzD/POd1+t5AzgoCHV6gbycg9GPn7QncA4aj5AWSECd
         d+5DoKX2v7AeGWozk35xtviPnrpDfpdlJC8CQIOobyr1OmU+YoTUgHJW101AdqFEsoLd
         TZTYxC7MP0LM26xj2OzjxbU/cAbYOAl3df0Vky19HGIXLRKh5ZMFZS/4FIzCNcbEi5og
         e4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756885034; x=1757489834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JeEr6faqcu2IUu37d/6zjI7aex7l+0Y0LxEBdw8Qllc=;
        b=uL30bB1bYMq93wYZSS6SKrw4LEXwTFPqHbX8jhC32E8vcypZIXO2qDfZb9/P9vMhwB
         IYcqBsexGJWe9i0805ooHF/lZdMOCJc1GCDHayRCNFJhPSXyK3xwCM9TzT2JGRQF8VBn
         PpOMX1UughpmPw3B94XGTDO16K3O/Trlc5PZ+stAbmsrSUNtah9j1BYxHhUily4DiLZX
         gXeCZwCmBYupT5kPvTf4QmHnV9poU66Pf8JPHSI1MuuWrnJxiRMnxxQCyLSLCQXOtt3C
         moNhjCIOJ873qja8Cj9SCg5scSIq6w8Gs6c2rcEbed+OOH9/2YCZcc3CPckX9gaBMdRR
         nnYg==
X-Forwarded-Encrypted: i=1; AJvYcCUPtQZ5Y5Vrdzql6SxJREjnhCbHILeI8RbRmewFzrjBCy2bTkhD5Qi19dMD84NzI/5NA+jxxm/i/Z0KvyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOF/VsjHqei3xF2rlEW2RnrodaxbIsglI9CNA5HhuK7nfWbNIz
	TYUHzg7Gq1MBs5USH18J6qQ4MQjhN12LS0reiWxgnduwr8uVy0Nyk/zhSbSbag938cA=
X-Gm-Gg: ASbGnctr7iJVaop/2vIA6FLQD+hCsgVhCNmU/c6oT+zjqE1GrRZH7pbrmg7XvpmpSdo
	krNNT6dr7KtlUHkXlimiT/Njs7ntzCC3fb6U2qR7bqYpMrDD99sZNtkrt9xrR4n+p9vP3ZtOe5A
	5sG4Qq+87HP+EZf0D8dJ7nwiKHB9Ieqa5uOPIZwx5DUt8GMIiN9BN+kSCZBSpCf39h9QkFSqV4R
	wymZPJ+6FcjXbhy/U0JuuA4bM4czFA2wkvi1vgqXhYzFzShgQmV/K/idgFiB96RZ8JeaTQu9g0a
	0Y5NbjuRpG9AorO9LoXXZbnU2zc8wd26s6IbpQU9GfFv5uDbw+U/vnQFSjCoFcAWHhnUv9OZiiz
	dTdUPnTPGOelVSUfEAPDkYTbi/F9nsLAgjOHQM9j0BaReMQ==
X-Google-Smtp-Source: AGHT+IG+IgOCqCBBK/GSnV+LZc4Ay0J5k/OAV2zXx4a12mbjTf+uc4/DXdi/dVLFfCCSMBHcAmtO4g==
X-Received: by 2002:a17:90b:1e12:b0:31e:cc6b:320f with SMTP id 98e67ed59e1d1-32815412adcmr15081588a91.5.1756885033765;
        Wed, 03 Sep 2025 00:37:13 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329b3e28a10sm7622534a91.18.2025.09.03.00.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 00:37:12 -0700 (PDT)
Date: Wed, 3 Sep 2025 13:07:02 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: powernow: Remove redundant 'ret' variable in
 powernow_decode_bios()
Message-ID: <20250903073702.g755d3xtjlkkdbfs@vireshk-i7>
References: <20250903072936.4067-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903072936.4067-1-rongqianfeng@vivo.com>

This should have been marked as V4 with details of what changed.
Sending it separately is fine (though wasn't really required), but you
still need to maintain the versions.

On 03-09-25, 15:29, Qianfeng Rong wrote:
> Remove the unnecessary 'ret' variable from the powernow_decode_bios()
> function. It is only used once to store the return value of get_ranges(p)
> before immediately returning it. Simplify the code by directly returning
> the result of get_ranges(p) instead.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>  drivers/cpufreq/powernow-k7.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

