Return-Path: <linux-kernel+bounces-836046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EACBA89ED
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6AF63C5E63
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2948F2D0634;
	Mon, 29 Sep 2025 09:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GICeAGSD"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0548B2882DB
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137986; cv=none; b=VkuHiasjHPoOAMwkrJ5LrFNJAMttSatAVP5vldMN3Y6IZgfk7yM0tnQTIZos31tgyHYVIvB0Amo0MCA0JrNCUyj8KztQlhh2wETmin3VFBDQqj8iHiLomC/fIumw1adAQurFiGNva7Z4RvNdGIdKy5Ld89txiV/F6e4io6nlTiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137986; c=relaxed/simple;
	bh=F6QPMSQ0e3v6IYWGpsg1DAlGPrduv5vyeTegzDeIf+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCppf+7ueU+50WUBLvQMihJTQ9YMyd7iakm185ga4RoNGTpCuSYG8j56H+2TdhaqLCPMWdr6M19dcBe5GAOcX2iKXTcPSg4znk4T1GAMa0lQ2tgqDu00cJzlZsjxdYeoiFc9lXiqENYAfh4XCVSQdxMTGmvWew+VwX8Zsf0ECo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GICeAGSD; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77f605f22easo3869674b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759137984; x=1759742784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vjBDdW6a6A4A7TeFZHGH031gzicAXAbFO5MjRo8D+ek=;
        b=GICeAGSDCIZr+G8YWm827/UMcEck0c6Xhc0zLQvCsfvCByug0NkDIiTLlgTFuidkrp
         miYr5wvib+HUmQgsfaR8TvgwkkUFjJyBx3vkGccWMdtzfJ3nYSCrCvkopmKM5NXpbAZi
         zjALvleaNxjrVycaqqZlN9Nf7aJbVzRKBjyYKwF+pBxYQgQKlAF4JF+0Yh6PtODv4XNp
         WhFqLItWTuscS5b+gUKlWFdoYczzpv/UsK6hyDn4TQaI17eAORGIQvjAuJl8IAYEFmzH
         OO1IckKb5K9jRFo3fQmfwHlnCU4b5ygbO7AWkNPVcaJQNNpa4TH7YP1fVwNLcFhsVI1v
         sn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759137984; x=1759742784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjBDdW6a6A4A7TeFZHGH031gzicAXAbFO5MjRo8D+ek=;
        b=O1CIuW18Ds7IxdGw3iU7xQkugwEJhg9ZN2Se3rIocFQJU4l2phlJ5wQ4WvyuX6C3e1
         dHXQwJbKYyibUyq5n/Lk87k9m9vNuolernQlt9PkNiZB7nVmG/KmErMW1axrCatpF30q
         zKPGrJfXRgJrB3K77pVtnYh9ZFrS++wsSy4ShtCjlBIhXbypQd6SiGk3hvRSUHfpazuD
         BKs4u72tznUMDmzGLHGt7zzxVUH8hN3GDxbU7WQb7Px7OnjPlAmtYQ3+jM0gkhXNI1C5
         VsK3iBaJxTPFxISeBjG3v+nkrnhKCecjuYCWfUz/MKLf/VBfyniG8SgbHJ88DnZHorus
         SHqg==
X-Forwarded-Encrypted: i=1; AJvYcCVSsIO7n/nxpTxn1W5bs1Sr+P22XWcLRI+7Bw7xAMKtuz4uNco/+g9w3RIpxZpHpha5rWi8yWr4oW770eM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT9AQC/rGmdNUhrsxSQvq+7leCy/31OvEgaxoUvl8wmQ9VYmCx
	ML1u0WVE5KdWqHARzwdKpfBowCrGUjES+JMmR/8+vSNdm4o92eHeJnlWD9Gvy/Om88A=
X-Gm-Gg: ASbGncvI9QIj5z8SZHzIYlY1RI8xkm9RwbSlM41zEh7QQuinhebr8U6Oq2c56Vpi9Lh
	BkZQS4IVVV6rGh/uk+vr03caNvre12XER4K4+Y32+0VoLk5j8p7eZkLGG8Ya2CTRwxTb8uvZqAF
	YE/c6twqyupbekOQuIV+D/GABQybq5spBAOn62pyv1euleuT1aI89vxw3g0MGVRYJOh0zUIMMB1
	0Q5J2EfZ8U225vhH0h+ZonOsWmJOSIYWB2uDEVs++iUm61J92cRTeJPs3bvxH5wuP1D3s4Fklv/
	KPfAdRbpvAGTbTupliigKKiuUDDg4jj9APDBrZD1kdOWl3I3IJahO/9/EeNlQOgQcS/mNC+HQp9
	LGrOxqO2th9qsdnRgMaqhwTwUfKD+cwveizM=
X-Google-Smtp-Source: AGHT+IGusX2FU775hDQyaDVeUQ2fzYFr/WVOzWLXyy7HzrXzVv07AdOmx8KqU7JGAyhS3O+CN7fWhA==
X-Received: by 2002:a05:6a20:394a:b0:264:94:3f5f with SMTP id adf61e73a8af0-2e7c131dbb4mr21160856637.15.1759137984423;
        Mon, 29 Sep 2025 02:26:24 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238ca29sm10479302b3a.6.2025.09.29.02.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:26:23 -0700 (PDT)
Date: Mon, 29 Sep 2025 14:56:21 +0530
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
Message-ID: <20250929092621.zvodzktgw7ok3rin@vireshk-i7>
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
> 
> Changes in v2:
> - Set max freq instead of base freq in patch 2
> - Link to v1: https://lore.kernel.org/r/20250826-tegra186-cpufreq-fixes-v1-0-97f98d3e0adb@gmail.com
> 
> ---
> Aaron Kling (2):
>       cpufreq: tegra186: Set target frequency for all cpus in policy
>       cpufreq: tegra186: Initialize all cores to max frequencies
> 
>  drivers/cpufreq/tegra186-cpufreq.c | 35 +++++++++++++++++++++++++++--------
>  1 file changed, 27 insertions(+), 8 deletions(-)

Applied. Thanks.

-- 
viresh

