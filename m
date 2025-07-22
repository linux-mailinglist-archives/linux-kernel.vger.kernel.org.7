Return-Path: <linux-kernel+bounces-740229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A526AB0D19C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E0BB7A1F33
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 06:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAD728F50F;
	Tue, 22 Jul 2025 06:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ee9+xFLY"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4DA28D850
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 06:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753164239; cv=none; b=YNFUhj25WU3WxgQKwwTEOxUkKxa2NUevnopKoQtYa1KcN3/4AbZwfz48Jwjx706EQfQ4SGpKQfJ3YE60uj408B58nlvGMoD7/kaG99+wDKGaT0PEji3Wj49rdv0TGWPPG6iDXF3GxcQwuCVDHA1jzSxYV9ys+IfdpZHMqKRMBW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753164239; c=relaxed/simple;
	bh=GZjdihGuJGAFsi3c7Tuyi3hZXAwLdDcTrI1HUVatZyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BC2zdCSHGqlfOdhUhRFFYzRdP6W4AeNAsR7VO2RywcUkM0mpjPPoajh+XvCxZYQYMiZlPX073SUxVZ604ZoHrQdt9YV1DiiP/LPdRbmHnZq1MKjNlcBTpe6Gj4srmFB/JyC1ALY7plu3Dy/Yb5p/ju2RUTESVvITYx+9Qhsw1cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ee9+xFLY; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3190fbe8536so4445773a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 23:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753164236; x=1753769036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mN4Wd/8Z+JBMvOvxD7RVTn6Zo5Ijr5YoqAraprQU8NY=;
        b=Ee9+xFLYdhRzNyuf/2E0QyRRFABjMT0cdk9hRByl4P7gZv3AXGubfAv3eKDVxcS2P3
         PwFB5VC9+JW8+hZnWqiFJJwga62nPIzmYhkJilNfDgDhEoZB47qFTiCR3cwOux1Q3FYL
         BSCNcpRQBJcRPr4Um/wg2z1IwxQ3YA1B2SM0AUhWCpORW45458K6g5Xp4SrcUV+epwBq
         Iluk7I1wJekq9ix4Z8XLVHitBGj9O8wq1ZQHQZ5XgyOQAqNBeUrOIDLo8BISq/g+QKNp
         sGS3zNJrhPNc+n5XxteKkvsFgpE5ZESh/ELCUEKwZ5V+QaQBXRB/pXVa9eaZt+vxVaWq
         fuaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753164236; x=1753769036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mN4Wd/8Z+JBMvOvxD7RVTn6Zo5Ijr5YoqAraprQU8NY=;
        b=pvk5Qn2RYMV5hHHkwzr8ZRYky7hQquTnYA35ErM8joQqEE4ojxDRT3G+D9hv+Kwfio
         fHv1725wcY1FFXuLhBPbPqQGcLXtp+c9XqDTlXCYVpSgs8YaKiYrWcg2Bv5FZzDjyBfB
         27HYYOXAK4ZKjeV4ugpTyFJqinHQqCo1tFOaazP/UcYELbdZGEZxkVophXE4ymFRuECy
         tV9OM9WZ4io0ZOdHBiOjVGzxm+vY7DH73urZIaqfY0uvqY7ScnQF3Osd5WQ58xQaGgOm
         ugnKjVRm7pdW50CzM+ZrRRKFBQqs+1vpANcPVyH1HEpEewSDT+ZIfKuNJ7FJnFhXHtTs
         MCyw==
X-Gm-Message-State: AOJu0YxNIujwttVWNwJcBJ/5uKZoGLZQUQzcEBJjEyGzWoq9KoUoSO4y
	5KtbFS4Xk0F91i5xjFGB2Aqc1xHfJw43X2s731pPaqAdMeR/ka5RayjzOI1d7KSOS5M=
X-Gm-Gg: ASbGnct5ThOkAu7YOTAYZIvR4eKdFnOSMrStQ5kZ4cHzyMjCI1dN6oID96zKepwTe1G
	PiJ8N1haNCzGu0pje3HHl40IMp5tEWD0c6t9CefnezBXY5RQlj6t1NEj4rKeBs/dM3nRaSijL/Z
	69ssPFq0BIyyRBTALgMUuGfRSYCtUAhgOgEPLHKnQokLZAYM7XVfMAQB8GG8+406S5YzSOShXKQ
	pwiQLOC6SGQBGeEhG8Eily5wZa6kIvUk5tZlWgWao6EuhrVORTfX9S3tKsnsLvtmlnjSYYh8goT
	f+2Qcmrey6QA702/XTh69Due0jGyztgJkSkiknZqjmiMaKkFmYO4w2ifWTnaaoDcn88VwuXklYn
	TPgf6/15VVNnTBKHdcplyBBv2FK73BG70Mw==
X-Google-Smtp-Source: AGHT+IGch7eThJUqL2zofbOetD37MUdqzx6uZ9i1unPSssEuWKh4MhkSQXdr9UAtN8dn5bb6iURClg==
X-Received: by 2002:a17:90b:514e:b0:311:ea13:2e6d with SMTP id 98e67ed59e1d1-31c9f4d0f24mr33580017a91.29.1753164235686;
        Mon, 21 Jul 2025 23:03:55 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b60ec68sm68358355ad.83.2025.07.21.23.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 23:03:55 -0700 (PDT)
Date: Tue, 22 Jul 2025 11:33:52 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Prashant Malani <pmalani@google.com>
Cc: open list <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Beata Michalska <beata.michalska@arm.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] cpufreq: CPPC: Mark driver with NEED_UPDATE_LIMITS flag
Message-ID: <20250722060352.pdwk2nrrth4uph2s@vireshk-i7>
References: <20250722055611.130574-2-pmalani@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722055611.130574-2-pmalani@google.com>

On 22-07-25, 05:55, Prashant Malani wrote:
> AMU counters on certain CPPC-based platforms tend to yield inaccurate
> delivered performance measurements on systems that are idle/mostly idle.
> This results in an inaccurate frequency being stored by cpufreq in its
> policy structure when the CPU is brought online. [1]
> 
> Consequently, if the userspace governor tries to set the frequency to a
> new value, there is a possibility that it would be the erroneous value
> stored earlier. In such a scenario, cpufreq would assume that the
> requested frequency has already been set and return early, resulting in
> the correct/new frequency request never making it to the hardware.
> 
> Since the operating frequency is liable to this sort of inconsistency,
> mark the CPPC driver with CPUFREQ_NEED_UPDATE_LIMITS so that it is always
> invoked when a target frequency update is requested.
> 
> [1] https://lore.kernel.org/linux-pm/20250619000925.415528-3-pmalani@google.com/
> 
> Cc: Beata Michalska <beata.michalska@arm.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Prashant Malani <pmalani@google.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index a1fd0ff22bc5..4a17162a392d 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -910,7 +910,7 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
>  };
>  
>  static struct cpufreq_driver cppc_cpufreq_driver = {
> -	.flags = CPUFREQ_CONST_LOOPS,
> +	.flags = CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
>  	.verify = cppc_verify_policy,
>  	.target = cppc_cpufreq_set_target,
>  	.get = cppc_cpufreq_get_rate,

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

