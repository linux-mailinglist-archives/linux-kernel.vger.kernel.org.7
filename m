Return-Path: <linux-kernel+bounces-892884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F59C46097
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 246CC347D53
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086E2301034;
	Mon, 10 Nov 2025 10:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="agia5V3S"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE88730217E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771631; cv=none; b=dSVcanoiDD2bp2byawPLbbHy4Tjdswj9vI0mefMQjteCgi+Q26w316ziXTOrL6HWmK6DuiH3jolTZSBRZoKdjV/+SWIhF/biGMCegJCLi169UxztXs59C0MbnaV0Xh3Irls5oq2F+No2L5A1exMWtuVg7ZV1jaT2PfNz8qgvrYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771631; c=relaxed/simple;
	bh=KWD0dSUvwuItAstvLunIOIEZaKlPBNCzkWHJb6tbpAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ES30UU2Wqe1PZAybydFeWSdKDZh5IZwWY6JdfQILFi/MR+9ICC9lRgkuTl/eYHHwMZ28+bkqDgD5ty9wkGZVqLG85YWE76cpDRK9D0y5CwA9XFnaim/zFb6O2lqozgfhNOTZOIlKyRK7r25lCzooblOfB3yCdwth34jsRb3zJPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=agia5V3S; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso1617054a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762771628; x=1763376428; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XQGzwKFQ+Rtg1mWaUwQhxw/U0dzqmCy2pKOiipYqOes=;
        b=agia5V3S5b6p8rNCtswM2bwpKA2BcIZN3zwGq/H4x9Reiy+69Mrag/JDp8TKRYhX2k
         JXgFq4h90CGcbWwlHOvicKRM4IQwVxLlpF6UIaL5RLSQf0RoH8KPvApcPoQ3gHW1HU6S
         RKUoOJrCH2/iQUIm8yNqen2ZfcHKhVOnj1fWhgUp/sXw4YFPUQ93IUT3WLK5zqNxiAvM
         JWc6kChJfnR82ToN812xj+HuHKuoOl0A8nJEltYzU1hLP+XIJ4x04DyMmNWCEWCUoDWN
         KNh0f8YDC5xz5+xiBclkanJA5vzHjvDCbKG5Yi9CB7kpxI+bhRkFl8UTugirGfReI41l
         WXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762771628; x=1763376428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQGzwKFQ+Rtg1mWaUwQhxw/U0dzqmCy2pKOiipYqOes=;
        b=D1JJBHEYynQHvSnONkCkNfv7RuFWZ+BAyPsrm2L/EZklZLHFOMAHAAbqPHDZwIUDjo
         ZXrBnuzPoctUjYSCozQVkw5avsb2bxuXhR4bRG0TiWhExwvCL19Djr+gaK80BPhSH5UE
         RmgI2pWZg1eOObNqfwYYuzs8sZAytSNTQs2qWqt912DhiPIjwfxzna7t6Cc5xRIu56uY
         9lkv2MJkaW9bD4OeKeWnPln48RCpyjGCqSAPfH0TjQY2l+aNldHZEDLdb2DGAEzZdYaM
         1/S3HLEg/ZaudgAKJ2O//g2LN6yX+reGSUGSbxlRC0MR67rtcw5Rfcm8jqYpze+Gi3f4
         Tj5g==
X-Forwarded-Encrypted: i=1; AJvYcCW10mt5C6zEKTkif8zvPN/QS5lbLPal2jBcxepQQ66Mv2g3vXroUTt4tCwFnWKhgisHR7Ks06qyu8zxp4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzLHWQE341F7fLnUFH3B9PYtRXmLrGfSDf1uFXEkZLd4xPzy83
	c4vVcGHzyOVuqp5/cH3cjfj75DiQ36hN6MI5eGzznYWAuJz6B51ZZQb9Ie4Etz//5dQ=
X-Gm-Gg: ASbGncvgQPd5NY6/te7we5AsgY2efquF7yMMt3Xyz9r6i6lXjHggUXrGwvwrE2DJEON
	QQ3vVaDBCgg7I0erzFf0fg65MXgAiDlSdVbhp29O0yu+jpLq0j7g+fXCo/0GLGu/alEdzJ0BIB2
	wmznzHBKG6YhmYqhrgzTNptKNZFEE+f5XIAsIPcFDRAMn02FHfDHG2uu/IlV7cGXUZEONTcAZat
	NJhH+0XQu2x3P3/rFD5dsxtbeNCl67B77Igyz/8wApZf5qb2aUgKpfS4nKhcMCzvrdhsjLunu7C
	jSwDgWJxpXzfP6veDcMyfa2rvSuNIBEr7Yi5axBx+RnP8sBFeKvF3BCHe9RgfDQglx42BMYU9bv
	BxH95CpVDl9vSV3WZQkENm1i1/R8eBpUd4ru0rp2i8eAHU9S+DOZm6wAXrTcpjozVfTFjz0OJw+
	dxfJscRCT5HaM=
X-Google-Smtp-Source: AGHT+IHg+DThhk+gJUORdYe/ePATJKcs+WA9A2y1rPJPIsw5mDbwrRCWQvQPcr7jYbijEjp+p5km1w==
X-Received: by 2002:a17:902:e888:b0:295:1aa7:edf7 with SMTP id d9443c01a7336-297e56be1c6mr87877225ad.30.1762771627875;
        Mon, 10 Nov 2025 02:47:07 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc179f77sm11235385b3a.34.2025.11.10.02.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:47:07 -0800 (PST)
Date: Mon, 10 Nov 2025 16:17:04 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ilia Lin <ilia.lin@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 1/1] cpufreq: qcom-nvmem: add compatible fallback for
 ipq806x for no SMEM
Message-ID: <y4ys4cp42vp3air2lnlbcglfbh42siguh5zpo3hxugqswwzrdy@qz7mrdzzmhnt>
References: <20251105112136.371376-1-ansuelsmth@gmail.com>
 <20251105112136.371376-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105112136.371376-2-ansuelsmth@gmail.com>

On 05-11-25, 12:21, Christian Marangi wrote:
> On some IPQ806x SoC SMEM might be not initialized by SBL. This is the
> case for some Google devices (the OnHub family) that can't make use of
> SMEM to detect the SoC ID (and socinfo can't be used either as it does
> depends on SMEM presence).
> 
> To handle these specific case, check if the SMEM is not initialized (by
> checking if the qcom_smem_get_soc_id returns -ENODEV) and fallback to
> OF machine compatible checking to identify the SoC variant.
> 
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 35 ++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)

Applied. Thanks.

-- 
viresh

