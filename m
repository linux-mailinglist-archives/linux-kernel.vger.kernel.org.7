Return-Path: <linux-kernel+bounces-838730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD18BB0079
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 12:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBFE81897488
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 10:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FFE2C0269;
	Wed,  1 Oct 2025 10:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="y+Qrg6t2"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1912627A929
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 10:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759315101; cv=none; b=i2W78J26qq/BUjgs1mWFA9fV80taz5rFlTtZ7Hi7MjpXx1wEYEKd0WFtOf+1FBz/ewZ3HS+kmFPvw/qpE85WxgeRq5kZJjpWt5kCRNu+aJTqFuWNlI6qopBabdnS8MdxvMw8c2boWnaX5aOV3ZCrnQ0S4TVIU1x/SM6I3IB8jqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759315101; c=relaxed/simple;
	bh=6WpRzUY1xB9VvC/VEjbYbB5z3j3GxfQ6hBgggjbZ6EA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXA1yRepmFP2C68eEjyi1gsxA/1tzJfIMRlACrAt9L1WleJ0NNY2q/Jq8TmjOaITANTicOV1TPaq8XCTdkBLnJcvHLYZ0K2c+I7fXEjOeTAE9T4imfITZbbdZCsbpZPHEWYILs1JltRehVZntVQ1yr8Ryhc94GvJhUZyQVw0Xts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=y+Qrg6t2; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e384dfde0so74465145e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 03:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1759315097; x=1759919897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4mF0RoLdx3iYd2wCJGbdBLKsyAovYaRReQN2weBYtMg=;
        b=y+Qrg6t2+x2XATp4qoY42IpRtEEqTMo+ykgdzwd5GUoPd95dWiV0NKZVydDwFCv5TT
         5EOiYYiElupqnYTbg6ahOFnzxnRnpRmyVQhpkIWiJkoI0XJhvBOZha9MoPxLBmEUAQih
         7OiC5JbiOch7qdXoOnM7o5KH/2vwFlbgnkUxlw0JCOkxpNjvfjSfrfsijG33waVj9rp3
         EgaXwCD6ivCBUpb3vb7ZrEuU4G4Ru5ovUfhZB/46618+I+TUP6BeITd5QuIeod+CqLG+
         f9HUHKzdome3ICyoaRlY59BztYhqNTuYCTW/d/swcoDc+wS3iLXDv3smiC/9tMSLOFLe
         p4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759315097; x=1759919897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mF0RoLdx3iYd2wCJGbdBLKsyAovYaRReQN2weBYtMg=;
        b=I/VVX3SoP7+0V7Axk8Vx4UB07T/XMRNe6AA9rE5E7SpXis3qDby0AKbwQ4E55papd/
         w06QJgbU1R8abIA5pPoyLscKEP681VrLmcnVtELxuhNV4lFPJ0epK2TEk1MMokc2gWva
         aucLEhbSlmQiLx3SsY7vDdghcA3qWRTXSPzA/cWH89WLEzqS0PpeTv3IoKBo4WzpMin7
         mSQGn74hdEvU6Iezz7ygGgKUEbbxobZeGr/bjW82jPsPNlGf2bgwS0Nvsgt3kWXWj0D2
         s3BKtt/r8OwPBUQZ5LKURN5yxECeFgoI9EGuQQNZxcuWdNQRZS2RSeI4SSEyFZU1I9Wg
         aL3g==
X-Forwarded-Encrypted: i=1; AJvYcCWY24UwOI6hyrFcd/P7kWdtrFravg2Lc3uhc/9gxREFLY6gk2AP+s44JcYK0xW8lzqhhwMoYJXAIjarUiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhOEiZNRukE/VL1BuKfMp5Tf99jyRFaDXm/dvYZMzE7b/fjN8O
	vuZ7+gCjzZcpFy/b+tXB4YSzQQ73AmY3gJGuUmMjsJ72SRQGT7xRbQUPFrb6jfDIfDDuzJgYAeT
	X2zQ5
X-Gm-Gg: ASbGncuSeWzZW4DMSm3HBhQGoulQH9xhu46PsUhD8TE3xxtIxtuYBQqOXsDeHi+xKmT
	Z3fg+a2uyp+HR3hhc+vU/LoJbM+/wlXhLDBFviIa6kNPULjGivv6eN3rfECu6sAJu+gzT8GaqGi
	zRzFq2nVR/dLW3V6Ran3amvwgZJYo4W6vPDRy3fSJ6tvRd5PfPb/YgcDpYm3TzpG3ziXsuEMPyh
	t9phRmjMWzVH3pX6pa9oaW1TpM3uxlCAvOBmYG9HvNFPcd+vqpR5iqA1KycjKYtSRg2kHukqXug
	zvbOautipD9Wuc+DtsDzewFL1znvBlLyGaoypt740P7gFP0yCI7zo7vXhgcJIWb1XGxCwwPENN+
	3y2AYTfxr+hIuAD8Nd1itgQc4jIZO44j4oCiR7R7o2LHcRNJ0zovL+GWdjSzzuIrVB5dbkGkVCJ
	lqS0e7/62UkRwsPFGb5SyhZTEcVgc=
X-Google-Smtp-Source: AGHT+IEaer9MYyjKdjU2yY0Pc7X/yiVBoIWcheLdIRRZJC17ULlWTNZ7OJDYC5pxYdi3TVVVua5g6A==
X-Received: by 2002:a05:6000:2086:b0:410:3a4f:1298 with SMTP id ffacd0b85a97d-425577f3522mr2447321f8f.15.1759315097237;
        Wed, 01 Oct 2025 03:38:17 -0700 (PDT)
Received: from airbuntu (host86-146-64-97.range86-146.btcentralplus.com. [86.146.64.97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc7e2c6b3sm28297378f8f.54.2025.10.01.03.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 03:38:16 -0700 (PDT)
Date: Wed, 1 Oct 2025 11:38:15 +0100
From: Qais Yousef <qyousef@layalina.io>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Jie Zhan <zhanjie9@hisilicon.com>, rust-for-linux@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Subject: Re: [PATCH v3 1/4] cpufreq: Make drivers using CPUFREQ_ETERNAL
 specify transition latency
Message-ID: <20251001103815.a57cc3wyasyhmrmt@airbuntu>
References: <5069803.31r3eYUQgx@rafael.j.wysocki>
 <2264949.irdbgypaU6@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2264949.irdbgypaU6@rafael.j.wysocki>

On 09/26/25 12:12, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit a755d0e2d41b ("cpufreq: Honour transition_latency over
> transition_delay_us") caused platforms where cpuinfo.transition_latency
> is CPUFREQ_ETERNAL to get a very large transition latency whereas
> previously it had been capped at 10 ms (and later at 2 ms).
> 
> This led to a user-observable regression between 6.6 and 6.12 as
> described by Shawn:
> 
> "The dbs sampling_rate was 10000 us on 6.6 and suddently becomes
>  6442450 us (4294967295 / 1000 * 1.5) on 6.12 for these platforms
>  because the default transition delay was dropped [...].
> 
>  It slows down dbs governor's reacting to CPU loading change
>  dramatically.  Also, as transition_delay_us is used by schedutil
>  governor as rate_limit_us, it shows a negative impact on device
>  idle power consumption, because the device gets slightly less time
>  in the lowest OPP."
> 
> Evidently, the expectation of the drivers using CPUFREQ_ETERNAL as
> cpuinfo.transition_latency was that it would be capped by the core,
> but they may as well return a default transition latency value instead
> of CPUFREQ_ETERNAL and the core need not do anything with it.
> 
> Accordingly, introduce CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS and make
> all of the drivers in question use it instead of CPUFREQ_ETERNAL.  Also
> update the related Rust binding.
> 
> Fixes: a755d0e2d41b ("cpufreq: Honour transition_latency over transition_delay_us")
> Closes: https://lore.kernel.org/linux-pm/20250922125929.453444-1-shawnguo2@yeah.net/
> Reported-by: Shawn Guo <shawnguo@kernel.org>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Reviewed-by: Jie Zhan <zhanjie9@hisilicon.com>
> Cc: 6.6+ <stable@vger.kernel.org> # 6.6+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The whole series LGTM. I think this is clearer now without the CPUFREQ_ETERNAL.

Reviewed-by: Qais Yousef <qyousef@layalina.io>


Cheers

--
Qais Yousef

