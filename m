Return-Path: <linux-kernel+bounces-776910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AF4B2D2E2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 06:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBD223BD90E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 04:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019BF23D2B2;
	Wed, 20 Aug 2025 04:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dWsP+1Zw"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3879194C86
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 04:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755662847; cv=none; b=KkSC+yZCbkeYJCVCcCAEOwzv1vjEk+r/EtYVUjvZvXLPLH6lEDEqj0LCFtNwf0EBWY84JKayAEPiutNBeUQjoTxB+T2/c/H2W01QquID396MXAsNJpsAshrVOUvBeIKjawiuknkDymfieu9t9+AX7+s6Zibg4A7QypH0xqoQzB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755662847; c=relaxed/simple;
	bh=fAgaMPplb2lrDBwavf7iOGhQZHwJMxat6ZSt4nk3FYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=id+iwgY0xQbeRFnS6fVXQcADP3pktNMceUkbGffeJXIyMBlcU3xJQoUO/FWV0hcN9zEWbGIZJh5eoXbOhYviY18oPzF4bNbW37/A05zDDoaHnmVtXfbInF1C+MxDrUHyiY+owpJp7a2uBnDA5Yn/w0WlWNT+BVVf69xfgeMf87o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dWsP+1Zw; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2445826fd9dso71456485ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 21:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755662845; x=1756267645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=61TbShyZGmEFoOQMK1FLzfzRsfZunqsPJaTJZw2MfRg=;
        b=dWsP+1ZwoxZ5KWVgUrz0+gc9H/sT1LC+c2a8+kJhL2NjH6wySeINx9gnktOLvdQZDf
         J2hTy/7FmGxH9qp1c1YAAJRfO8mYfAz7XcMI0HLUjTvJrpH80H4Qyf5JgSI4EaJiNF6X
         Ujpbf5a1yFMoEVzlXTVZ7Ggcyj4pvUNbxXBJ4CJcq8MxmIgHWuYge8bVWCLBp5KjdLdC
         Zv89/3NIDKBlAIV3ttlCzMujUR217jzrCoKfZPoypmT7L0ipCNGVUNQ6xMSdglkp1vWV
         1Xm6Qzdkqm+EGNh4xoS7k+PLhEmgVL+NUGPnxzzjxSlsgWolodkJRocZRsakpALhzQly
         GBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755662845; x=1756267645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61TbShyZGmEFoOQMK1FLzfzRsfZunqsPJaTJZw2MfRg=;
        b=ZBZ2hHDOr58BYZ3CphUIMunX86pRPGR93SCzDih5GMTvbBYgooLmmugpbK2CifEUmN
         Fqwt4J99ssVbksNqL02J9shBGwpJyH2n7WCTijlpectZRpU5NFASA9s+9g/Oo3l0aDWs
         bjKxT2UxBJqIb8+xdPtsG/Qb72sxGkBcc3na/aQ32zEti+CeqF7quppimcfCYOnKRLkh
         NyWF0gBUvu75rjv/tMm9NvxS3p8u0PJavdBibaWkHgucnnBA5cqPg9osN+kI45/qjEdN
         CPC/sQAbKnOvSdD41dH2vzQlmArdOTjBdEaI22ZR4oSFsH7/7415Wh0ttDo+oM5P6O6b
         2VWA==
X-Forwarded-Encrypted: i=1; AJvYcCXeZpVvH+tlSz4rjTbon5fpGeNbhv7P4+z8VaHCOyk1ImkVOVLzyxUtlzgr6USfjlArv8SDUcCor57MPaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzueezWPFritEI5CDsiZuxF+xL9KdDydaCrylCCdWOHrW6SkuUc
	09kAET7tjMOODUlgwAdV7uUDf1N9y0RgvaqqBIdn2mwj1qcfn0WDEGvzWZ0McZZMLlY=
X-Gm-Gg: ASbGncvQ3rhfcfp9fA385/4kbXszgu1LfLXHtZGaR2eCPa+bxd+mWt+E/w/dkCRFAjZ
	MkPpKLXpOFrJZD/qDjavS5dfhphA5BFSF6jvEgu73nU3bWkVOxtrm30xBS04zKjNXavZBJSCWUq
	Kz/wKqCxFvh7WpuUL5FHhBZAMAYKnFpeQPog6H33qBvUHbC7yKyLLC/NnqcMC5O9WPVy87rxDwD
	6/Rbe0h3X1vFRG8KrgCzE5QtUq2E7y79nHQcrQ+M0mPTu1TRDiKMbqoca3gbWoGnfM+GhiSsfQC
	1VCW0tU8oKM35TSExLrOrknolAkyxJMZleykTncC3yH9AvgO4NLIjryScUAVYYkKmTKXxoixMQI
	cvCY4C3pj2wXRm/xTZAJY1Wf+
X-Google-Smtp-Source: AGHT+IEF8aL/OwClRkLK03kIO5ZYX/8TW6kXe9vwkD7+3xAbrkceAzbVpiAbQQ6RgDwBHRsjj6oH3Q==
X-Received: by 2002:a17:903:1ce:b0:242:29e1:38f0 with SMTP id d9443c01a7336-245ef14b770mr19823785ad.24.1755662845050;
        Tue, 19 Aug 2025 21:07:25 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4f3bfesm12339785ad.119.2025.08.19.21.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 21:07:24 -0700 (PDT)
Date: Wed, 20 Aug 2025 09:37:22 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogiaocchino.delregno@collabora.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] cpufreq: mediatek-hw: don't use error path on NULL fdvfs
Message-ID: <20250820040722.fdf2544cdz6k6dcq@vireshk-i7>
References: <20250819-mt8196-cpufreq-fix-v1-1-adb60a3082dc@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819-mt8196-cpufreq-fix-v1-1-adb60a3082dc@collabora.com>

On 19-08-25, 13:21, Nicolas Frattaroli wrote:
> The IS_ERR_OR_NULL check for priv->fdvfs is inappropriate, and should be
> an IS_ERR check instead, as a NULL value here would propagate it to
> PTR_ERR.
> 
> In practice, there is no problem here, as devm_of_iomap cannot return
> NULL in any circumstance. However, it causes a Smatch static checker
> warning.
> 
> Fix the warning by changing the check from IS_ERR_OR_NULL to IS_ERR.
> 
> Fixes: 32e0d669f3ac ("cpufreq: mediatek-hw: Add support for MT8196")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-pm/aKQubSEXH1TXQpnR@stanley.mountain/
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq-hw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

-- 
viresh

