Return-Path: <linux-kernel+bounces-799943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0C8B43176
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67413208245
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 05:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A54322A4FC;
	Thu,  4 Sep 2025 05:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zg6zZdZj"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5608B33E7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 05:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756962243; cv=none; b=e8Qhy58FPw7kSos6Rkg0VKVMPvjW1W1cuG4eZd9a5D7mbBlz8XWDcPqSsHxcTlNYrnYmRQGY5ZTlk8IAlLOfHzoHdlXYxyHxMtOySHvP1UG9NUHg0405lf03ZSvsyVGyJoTvh6P+/TcVe3uoNI8y0kGnDGKO/jXbP3gFCgqoY5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756962243; c=relaxed/simple;
	bh=VN0eu04X+Blerv8n91iWc1v8Qm+cbzBBmKAIxRg+pTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3yG1spcPPw9951jjibocv35oGO7fvALML7dHiBaDFQTIxEp5vWlxE32DPau+QCIoIIou2PdR3YkvMnk3NsUP9Pm1mQy/4vPx303tS+arBLTr6aQeDFRzfQZNORzsn/CeNcBaAWyzPc4D9Drf09u+qHI1o9mFQfhGhcr+WNvGrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zg6zZdZj; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-772301f8a4cso902750b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 22:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756962241; x=1757567041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PUDDmkRugVO/LR/xckcLSLxhh+WNZoJcwv9OrEHQ+Q0=;
        b=zg6zZdZjAMwDbXBOanb68YdKX9lsOQCVoGk2abp698AT7KFDZKQzONPHjJoYFqvOFc
         ial8mIUePKWdcRyK77IlSvgcEGdIgjTF3cIVMw5J1qqp1IMgseto7BNwsXT/78VsECsL
         8yD6T56kxi0eRhw5s3guONTwS0LpUynSNrDUndp6Q1CCTJ6LXjijPxzKZsnlCeO7HFlX
         b32C1R7x6J63nLw11uJvFuOj3+3zeh8AgpAxotFNA/OiVM+YeuwDotSmvGf+ap+wiwRp
         ZGQb7nBaOyD825skL28vn+QUm+4VaBTkdPCTgePlZ20y0PaYRmQDywJJNyHyi/7WNtzC
         5oOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756962241; x=1757567041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUDDmkRugVO/LR/xckcLSLxhh+WNZoJcwv9OrEHQ+Q0=;
        b=E6UzU+ilkG/eYyP5P+n2N8yfMRW4dpKssFlEEVwFfWD5rM51gfvMmAy+uFZNDvXFMb
         yy2GWgc8UArgk2d8rRPqpsGuBlt6wKuFvoXQFODLZSdGQrHKYRX0LtaEa9mtJLF0is4D
         cvAtcE3OFOLG+sn9h8ftGSZ9ep+6pmJ+XsJ8AT3E6Z07R8Y+znp0w0/zuyhL4cf8yW+0
         bj/30WGGDCC2XR5clD+KWKullQUg/GnnAvv5Id+l91uNtBhFGc9edXgaYDeo8SG1YPOQ
         IhE4XEGscLwv4Q8cx+42KE+dgSLeY4Pc+w5tNzm4ZHJjr+A0NuAt9go/85zhbuXtbyie
         r0qA==
X-Forwarded-Encrypted: i=1; AJvYcCWHycRT2zo8qu6ZptWyjSIPdK30lu22+TWxSuxR548ZE813tLM9jksJDR7YwkexCnJxdCP6qEoeoD4if04=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9JmHASptXaxaHNAEON5J4glfjOKLqNUx/CDuatviSFUf2r9Zq
	y+vuhzrgwotvlMul/kd/Wfj2RgwKb1oAIKXdTRoA9rf+KwNdldB4iknoO3E0NxXc1bc=
X-Gm-Gg: ASbGncs8Yrc2CTNZdkIXxoroJQpoVlIy2n2dm61mrPm52BUDTOhRmEJFPlLqw4KVQgp
	ux913qp17Jrr9GCMV2SuM553xpDZVfPQVsASZbEjx1VMSOLDlxMBmh/SXDFZzDxDk3QAqYrdwTy
	j2lxlzau4EyPEvxd2MVWbLyR7X1hPocMJNnoTbSFdYzikU3kKVJeLnlKxB6Gl8vxt4LqtQqGlSX
	CO4D9SrEBM0kG7jTn17YTveexb8iEz//nEzbIPtlG6eaN1wNoO3ZIbw45zYVJwKhpe77ujUzMjX
	KJWLPWH8OVU0LA6Ylg1d4NYEDbwUnzO2jGnpTZcIyQ/p3vNgznlTzcONKGK6VWQKQvmuvrzHEtf
	SwYkcIGonHXrw7/BwUht7IDwxfBSA7pde5Eo=
X-Google-Smtp-Source: AGHT+IHag2U9U1XvmmR0U1C9VDKS1Bo6WCQfCQMDOrQGMz82TQz7MiXq1aOJIWslun3n5e6SZdxUJw==
X-Received: by 2002:a05:6a00:2e2a:b0:772:65b2:99b6 with SMTP id d2e1a72fcca58-77265b29bb8mr15449714b3a.25.1756962241631;
        Wed, 03 Sep 2025 22:04:01 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7723427c127sm16918405b3a.62.2025.09.03.22.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 22:04:00 -0700 (PDT)
Date: Thu, 4 Sep 2025 10:33:58 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: webgeek1234@gmail.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Aaron Kling <luceoscutum@gmail.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Thierry Reding <treding@nvidia.com>, linux-pm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mikko Perttunen <mperttunen@nvidia.com>
Subject: Re: [PATCH v3 0/2] cpufreq: tegra186: Fix initialization and scaling
Message-ID: <20250904050358.kj7gxypu5mmov4f7@vireshk-i7>
References: <20250828-tegra186-cpufreq-fixes-v3-0-23a7341db254@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828-tegra186-cpufreq-fixes-v3-0-23a7341db254@gmail.com>

On 28-08-25, 21:48, Aaron Kling via B4 Relay wrote:
> This series fixes an issue with shared policy per cluster not scaling
> all cpus and with some cores being initialized by the subsystem.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
> Changes in v3:
> - Use more clearly named variables in patch 2
> - In patch 2, fail probe if no cpu rates reported by bpmp
> - Link to v2: https://lore.kernel.org/r/20250828-tegra186-cpufreq-fixes-v2-0-fcffe4de1e15@gmail.com

Would be nice to get an Ack from one of the Tegra maintainers before I
apply this.

-- 
viresh

