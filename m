Return-Path: <linux-kernel+bounces-795729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F07CB3F725
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179F5170544
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701A92E4279;
	Tue,  2 Sep 2025 07:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y3hNAYYZ"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565191E515
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 07:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756799789; cv=none; b=rraYbs1l5vbxbvkbQxw4Kx5AwIOQdOtTpknazAU2PN3cgByVbQKZ6TiiJHjnWQPz8L/mb3GkqSxg9lJ70Y8MKFxGg1B+2H15jfQCPEtcDjdh+0MOqQ5ZTeDNbYOAbEju+ZhBVcbewJVVWAxVVa6UYVn3zeh3927OqZjPUT7D0/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756799789; c=relaxed/simple;
	bh=ui3oePyMPZ7ndf7uaJSF49rTpYBZufVZffiGyrMrruE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2CX2h5JcWPTTZQflteD3hVd5ldd6Qp9owJrcLv55uxFLptha9DMPYnQKLDVODhB4Cyq/2BQ2kEvKexZZRyDx5KzCM/R1qSGfph/HxPErin42lHLlqHtMnDFhgeGlPajb6GqUiK8OcBVEZ+LbSqtoGzZ7bwGzGCZo5yiu6djEbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y3hNAYYZ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-248dc002bbaso42508965ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 00:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756799787; x=1757404587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=haHbEUWBm3c83oit6a5jb9Xfc6jP/F8jfjASNQLcAMo=;
        b=y3hNAYYZnLezyTn+8V5xhIgFCB+Qgn/SUVUX+4KHz1IuRRRTizCJwK8POC/+B8VX8L
         HkOFBjTz2Dha64OPd+4NkXL7a1vWrBlXDrhpx26lEp0V3C8DGz98jhrRp1qWKrw7ISgX
         Ewp2HhhwqZxVfHbERnjL1FAyJKFb7E5F+h9Om2h4Fjb2weDl/3Z67G9uNdtDxozJvqn/
         DQNAgLNzymGKEtIgyTwGqXZLLh4MjCuPnFZQ5x+4+ecdUIiNS5XnrIrUOsiKN1EQMuzv
         sxaZ02ItmrkFKuGTbvKOt//L/4AfOX0Dv5MrR/KVU6zhRLrnSy73hQME7oy5TBxsg++R
         5t7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756799787; x=1757404587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haHbEUWBm3c83oit6a5jb9Xfc6jP/F8jfjASNQLcAMo=;
        b=uKUmlC9uYP5z4xjh50wS3JbanG1PzMKbmSA0lhIULoWwATjiCJweUm6ifNt/4/2dT0
         bOYVmYM73v3hKGrGYMkE6dwS2TeR+DaEAKM5zOO2369UDYppM98vvERD2qiU8SDtrfnG
         KEmr6XKjDVe98bbgI5fR+JQsDDUwt1LVOq8FCvOE1/8vKGiazssFQipcC54NB/FWqZiL
         A5j3fh2MRtBO/MYT4iJgvECukBRyTw6TgWju9kbNz2vPJiqiD2OD8+9v0XHa78zJNVxj
         wAafGuYKuvqYwEvCPg2Ut4GawXraVBiwCfkTtUOZldsQFBYzB7ul6TGse+veQIBjR6HS
         4NRw==
X-Forwarded-Encrypted: i=1; AJvYcCV032pf4fxbjFkEa7dm5eSU0zGJj64V93yCrZl1r5PfkyJTo7wTWngg9CUUCMt5agZQQPt3QFQNj/2m310=@vger.kernel.org
X-Gm-Message-State: AOJu0YybY23crsSbnxetZxqyih3cYIefxPEFzLGHUqyxkE5nYRgA91YN
	l2ZR6pICZe5MPNjtrOSHaAGVIEKePipQwmfmdHQG9yOrfxKSqhCVoKUWyj1XK0c1wF8=
X-Gm-Gg: ASbGncsWB4Jl64ghSmw4sZrU0Egn/iifQW1jzhu2wK/YEshi3wvqFC//vuQ1i4A/2zA
	q/Uf+kP88ZtZsibOmgNDgNtlIfCx2adNOcrKEVoZI1nHaFFvdrSsixF1bC8v5yFLcNkVxNRZn24
	7vOB8EGFF7n+ZjVIwNM5TB6A26emsLXEkPT4d+yGHoGP9+JXK1+flcU99w15XUZ4Af7FauOnrTv
	jPWgGMKz6JRKMyavcAczWWb4OSgl4ielRWRP5tB3VRU8AxlbxH4PkECpHHEwMWgrh6akyuF/Y+U
	PfEDD4VVOyzWqw1L7AZWkOpKYHT2Z8P4pztqm+5YILE0H+1vOFNXnTUuJsyiSJj2xB6kjaURAOG
	clzsr40O35DBKUoCeF9YpP8TT
X-Google-Smtp-Source: AGHT+IE3yqUwRH/YIbc2yPSfX/WoGHQsAVl3CK7cSBY/cp+Brg4Ss3otjZYUZ4wk1ng+NOv6OTVdGg==
X-Received: by 2002:a17:902:d2cf:b0:249:3027:bdb3 with SMTP id d9443c01a7336-24944b19c4amr133476015ad.34.1756799787613;
        Tue, 02 Sep 2025 00:56:27 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903727e23sm125568385ad.45.2025.09.02.00.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 00:56:27 -0700 (PDT)
Date: Tue, 2 Sep 2025 13:26:24 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . wysocki" <rafael@kernel.org>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: Drop redundant freq_table parameter
Message-ID: <20250902075624.gcacapuytmwenaxo@vireshk-i7>
References: <20250902073323.48330-1-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902073323.48330-1-zhangzihuan@kylinos.cn>

On 02-09-25, 15:33, Zihuan Zhang wrote:
> Since commit e0b3165ba521 ("cpufreq: add 'freq_table' in struct
> cpufreq_policy"),
> freq_table has been stored in struct cpufreq_policy instead of being
> maintained separately.
> 
> However, several helpers in freq_table.c still take both policy and
> freq_table as parameters, even though policy->freq_table can always be
> used. This leads to redundant function arguments and increases the chance
> of inconsistencies.
> 
> This patch removes the unnecessary freq_table argument from these functions
> and updates their callers to only pass policy. This makes the code simpler,
> more consistent, and avoids duplication.
> 
> V2:
>  - Merge three patches into one to fix compile error
>  - simple the check suggested by Viresh Kumar
> 
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> ---
>  drivers/cpufreq/cpufreq.c         |  2 +-
>  drivers/cpufreq/freq_table.c      | 14 ++++++--------
>  drivers/cpufreq/sh-cpufreq.c      |  6 ++----
>  drivers/cpufreq/virtual-cpufreq.c |  2 +-
>  include/linux/cpufreq.h           |  7 +++----
>  5 files changed, 13 insertions(+), 18 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

