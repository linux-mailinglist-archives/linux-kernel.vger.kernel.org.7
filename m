Return-Path: <linux-kernel+bounces-775477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C225FB2BFB1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71FEB1B62AB7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA46322DC8;
	Tue, 19 Aug 2025 10:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S/YUhGLy"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C92231B10B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755601170; cv=none; b=ZXG/C5y8SiL6yXBZZdY2tpMg1z36vBQpT4yme1+AqnXVGfRcWMd13EsOgLZh4qp6aCoaJC+R+rWEbNTNnx1igSEWpfHwOybdF7BOXPwtol24qTq/RESY/THrR+tUxy/ygAJth0IJZhR/1pV60Pbu/fkecbInds9CefINh3QlcWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755601170; c=relaxed/simple;
	bh=KAFaqRiE6nzXS+LKL0cxSMUTq0bKgyZWfJfaI8+aWgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+KWSP/hxI2/PG6PuJt0gpMOQW1ycWEcIkKij9n9WL9rZuZSvVgkYJAA2X/UeBN8HhCuSOxpRGI0AdpklP+iumEhEAJJqQ9jyTp9NGIvvk9cgy7ABUGO59AIB5v0ZAa5b3/zF8Syni1ppLQxRDYH6Qbj0vc1+xZ6Az7MJ4Wg5aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S/YUhGLy; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32326e5f0bfso4252167a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755601168; x=1756205968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=arvz5a88RitPQG105vjnEOt0s5EixJi2rrNrtSKMeTQ=;
        b=S/YUhGLyC5EPRg1nckw192LHJQoUVOQQ3oC8afbIyJU+iYtken5CTdLRf/ARPutVkV
         oVcQ0LEaHY8+mqwXswzdIK0IU6hnyr9Uuwbei31nu/6gVdzsJCjHQQF/nud30P1/EQQL
         RPLq0tUJWhj0CvsyiJTdg5GRbR4NWgrlsOQLwMqBRRRVoJlJMgRFTsXmuPIGPGyjISYp
         p5DF7X6sCd3YSR6y97wJqaohwRh7mI5Txo3nCbQT38I+2tAVgaaLJMMHlLJnTfPmwp3z
         brMsPznj4zJRbuFYTtBJ7LhO3f+NWzRzTldiVJbW4o0gQhBCTp7aUhBwK9dvWrTMjaV2
         /bQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755601168; x=1756205968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=arvz5a88RitPQG105vjnEOt0s5EixJi2rrNrtSKMeTQ=;
        b=VY+Zv1toAlfFBNV0QT+u63vNYlUmAx1SKKDUK/tuI1AcVKUPxSYRNGa88XqERV2AEr
         i5YnUJOZmQBJtyNZWNL10YPWTWY9E63K+dVcDnNn4DCT8QljGV3Uncss8vSCqJr6uELJ
         rQO9pqVi/eJsJlpyQ1yi3ruiRP6lzKs9jImy27C//iHjABSGCSFpouXs+3AVY5BS4Dn5
         DIt+9EmpvgMfXmHbousIvy/9bQKqPnbhgKZ0Qs9JYVfFkIq50d360Dwh7r8UbjwhiYhm
         vcpTO4dmSxvM/zJGXhRF1vUZOPcWzwZNmanJDuri2CMl6FS3gVeLO4c9zj1B3yA2JnSY
         Bdsg==
X-Forwarded-Encrypted: i=1; AJvYcCVyAy9Wq4awDYYoWDkQg3fvFpANjolg8eR28lt0hgHa64Wgazr4fWSQURL+YliCXcrQ/Sc7nCioEl7i2iE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNGeJkzWH17PM5xDpuZafdkN3Ppe2yefnXXkhZyg+VcyYxiw4l
	uXTgBPIIT75WpJ/irQjbo5FdfSu8BqLt88mef3n0Swn/ymAb2D+auDqisC3bXH6zkoM=
X-Gm-Gg: ASbGncsouSe7SxZxLQ6CkL6dPyxCzm7iGzp+Cp/L7+PxmyuYyZ/+mLgcf6J0Of71ddQ
	iqOnCNt9L0jARVfOIYmJNv3qWSND1GvZI6ZVOZMQQdxyZSfeokfQipiGjafLk1/4ZCTBsymfG1F
	YIaMGi8FnYu96wgRhKvnqv4hONXlttw9JZJnem64E2IXLJw7S7yroPKtbxrpFT6T86u2j7wgcjC
	0HonM5pwieKgnHpUVvcqwMyPWwqliW3Uno1MGz4KvJSU8seb3Kt+td5UFHqvrKc7cBTVinKW/6D
	04mUq4zFHKXgQTERs2tdAMSrkKv+c2a2iU07XUpNJ8lLu2rlJsblYA0oZb89z0cVduHo8b3ubGC
	y1bOGTGaLX5h3j+NeNY4ksQIG
X-Google-Smtp-Source: AGHT+IHZoCtAtUE9HPPvtVCogZL2oXfh8LTo7Si136WDL03ocU1HMP0CuJhciYnWxrYvmwQ36mxi5w==
X-Received: by 2002:a17:90b:1f83:b0:31e:d9f0:9b92 with SMTP id 98e67ed59e1d1-3245e594983mr2850492a91.14.1755601168469;
        Tue, 19 Aug 2025 03:59:28 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b475028dcffsm2716166a12.23.2025.08.19.03.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 03:59:27 -0700 (PDT)
Date: Tue, 19 Aug 2025 16:29:25 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "rafael J . wysocki" <rafael@kernel.org>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cpufreq: simplify cpufreq_set_policy() interface
Message-ID: <20250819105925.34o5f5attd5rboh7@vireshk-i7>
References: <20250819103940.342774-1-zhangzihuan@kylinos.cn>
 <20250819103940.342774-3-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819103940.342774-3-zhangzihuan@kylinos.cn>

On 19-08-25, 18:39, Zihuan Zhang wrote:
>  static int cpufreq_set_policy(struct cpufreq_policy *policy,
> -			      struct cpufreq_governor *new_gov,
> -			      unsigned int new_pol);
> +			      struct cpufreq_governor *new_gov);

A driver will either support the policy or the governor. If we are
keeping `new_gov` around, I don't see why `new_pol` should be dropped.
And changing the policy for a `setpolicy` driver should happen from
within cpufreq_set_policy() instead of the caller. Also there is at
least one case (verify()) where we may end up returning early, before
changing the policy.

-- 
viresh

