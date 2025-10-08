Return-Path: <linux-kernel+bounces-845662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4C5BC5BA4
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 17:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03F6019E3CE9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 15:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84BE2FBE10;
	Wed,  8 Oct 2025 15:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wYBMgz54"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5771B2FBE09
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759937646; cv=none; b=RYm6Z/o+RFIEB0Xwld7QvK9m03afnILHiu3a3RHqQT1lvu8QYqVP379R2JgbrllFaUfedGwRXCdRe5b3IpzXCR0pVYJGKjDbT2aX+GS87jeWSb8WFFGg6tdL3xERPo7CateFbLmLUcj4knrL+UTZHx2BGhvqgt7pTYpNDT+EJNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759937646; c=relaxed/simple;
	bh=42RqGuehjRDSpY2gsrVZJlk6zt2QYdS+W6t8m/VoWXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0ros2Kcw9lLzhlbrwWLIA6790We3XaxWuQXavJXE+rYQxZPNXuNLYqWlLlPxqB4jEhO/c2QPQ6MWFglSq83CHZFS6dBQi4kwJGYU+Rykdlxyta/ZbyF/BphPOItP/uxYR8G/KVgt6P5yXjS7iG1hksSZUUx7Kw/5Znt3brbUZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wYBMgz54; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e5980471eso38622815e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 08:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759937643; x=1760542443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3nT10c9+RtbCyZpgzKMKOftV2ncNLF5WtmF89g9eodc=;
        b=wYBMgz54rI2qanBpnS/yUaLctWQRbskcCwiHIiuLdt00vfamaLNmUQSdpKDXfbxn1I
         a6z2V2dDEKYb5QdKAlP/2HwY0M30bMBaCQlHIKgKbcmRoKYsTSUshurlpuQRGrrBtwai
         DPXNyMaqyAuFXTj5wvvUaorLOUd6o/VidvrMHSnVvujIDpSk1qXZ1TU1xdizwyJLXGll
         dHV5rA+ei/8m/wzGYxZ2nDP8DK5gPeeJkIgmX50SCl9kZJL+7BlhAWtbKG3VwMgBjWie
         EnpQcDsSnf5FcIOKcOknRetHXcNauTRl1AFhlwYeoMxVlmthrDor60HNiTQooud8UVg2
         1JzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759937643; x=1760542443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nT10c9+RtbCyZpgzKMKOftV2ncNLF5WtmF89g9eodc=;
        b=d+pzOKzZ6c3Mr9E/VPrKIZZkvknzyxpauH4bkBK/dkHDV/bsg6SF/pnzk76mgDeTLN
         Rdm0Stn6KAUHtzloJZ4HU+Y8r+Jz1fKGUIJHiqYaiseVmJSsTmvzTARf6yH7WG8W7f7W
         Ff1WW5YgvXL6dan6eBlOHaWjrvSt+gJ9/yxFZhllqQkdwgy93AaDot8dby1rd6MYVDW7
         4U67c2y8gtbZoCTtKmnQ3XOAfB4eMDCU8tJ5CXjcuvFQ91STE3QfB+Sam3LPyICCeRiA
         +6HjaK23Fe+D4gyRz4H97zSqiHcFyA+R1Dwo2KOJEZjCG+zaMMtBGHjPVAzpg4y8XJAC
         QHlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJyHT59st0Yjif9p5RqNhxrEL0+lT82CI+zAG+MiSiNHo4s14kMfMIkvGN5TW1RTBa+ovCyXWFTX4BNmg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4iAQqNRWksqqVUs1y+di8cCWfYZnCyU1u9WS7tGHUoBj9e1Rd
	pLkHFLhDba0CcrB18zNI+jdUY96TS8bJZbYYx/+qb/UiNKsyXPYc/WaMSiVNMxlv068=
X-Gm-Gg: ASbGncsqePVom95HKcJHAR2F9L/2HcTqCKR97bEnkeeEz8ehjnhybe3e6Lui4uXGfFz
	dY/SJh+kOTyjnAZQhS1Cnxi5KtZ4b49cMmI8/UJhIccEVSrtqzm5uoEg158NBMdXDLKvQpTEf85
	fB1/dlj1RyAEx0KrHVYCUJLynulmpp4NzANNT3Px+Blg5g0y3w6Dw4y4GG5uatIJdlE6PBBBwXl
	B9k/uAka+uRC0uND8rrIi7mAbIX7PFbiptLcfTBFkgfbXkJesjtg1fAD/DxSIIG9mfNog1j8bYg
	+9fGn7Ro5SRmExnl+4TCYbCQVO9lsBLHABxlMnaqgJVkPTaxJP4/jLMMNfJl6SOLnCoUzulhcyn
	6KaMSQGNJ9wDoEpHGwk8HrXBwTO5Djqarm8hRp+W6f6p85bwNUDKVepMqIUPmkrbvRfI=
X-Google-Smtp-Source: AGHT+IHWKpjkgnJ6mZ4SxdFrASKIm3+agiqKwM+jn1niikJVBh/tK845v90Y+pp2KpRiWUEcs/aoDQ==
X-Received: by 2002:a05:600c:1f93:b0:46e:376c:b1f0 with SMTP id 5b1f17b1804b1-46fa9a8ca9fmr25983455e9.7.1759937642542;
        Wed, 08 Oct 2025 08:34:02 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46fab3d7df4sm17562785e9.1.2025.10.08.08.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 08:34:02 -0700 (PDT)
Date: Wed, 8 Oct 2025 18:33:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: cadence-quadspi: Fix pm_runtime unbalance on dma
 EPROBE_DEFER
Message-ID: <aOaEZmrWgy_g0u7c@stanley.mountain>
References: <20251008-cadence-quadspi-fix-pm-runtime-v1-1-33bcb4b83a2e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008-cadence-quadspi-fix-pm-runtime-v1-1-33bcb4b83a2e@kernel.org>

On Wed, Oct 08, 2025 at 03:38:39PM +0200, Mattijs Korpershoek wrote:
> In csqspi_probe(), when cqspi_request_mmap_dma() returns -EPROBE_DEFER,
> we handle the error by jumping to probe_setup_failed.
> In that label, we call pm_runtime_disable(), even if we never called
> pm_runtime_enable() before.
> 
> Because of this, the driver cannot probe:
> 
> [    2.690018] cadence-qspi 47040000.spi: No Rx DMA available
> [    2.699735] spi-nor spi0.0: resume failed with -13
> [    2.699741] spi-nor: probe of spi0.0 failed with error -13
> 
> Only call pm_runtime_disable() if it was enabled by adding a new
> label to handle cqspi_request_mmap_dma() failures.
> 
> Fixes: 04a8ff1bc351 ("spi: cadence-quadspi: fix cleanup of rx_chan on failure paths")
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> ---
> This has been tested on a AM69 SK board.

The patch seems correct, but the correct Fixes tag is:
Fixes: b07f349d1864 ("spi: spi-cadence-quadspi: Fix pm runtime unbalance")

regards,
dan carpenter


