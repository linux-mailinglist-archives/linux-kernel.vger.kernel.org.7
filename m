Return-Path: <linux-kernel+bounces-864562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 934BBBFB126
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 823C44E2473
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28FF31076B;
	Wed, 22 Oct 2025 09:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vWkTnnCx"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6C93115A5
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761124073; cv=none; b=cJknMgsz2/u4PxzwEbXzHdqz3HtYl00/slaMFFfTpc4cf2mlUzWSl2LMxi4yXmsKcgMV96cYfOvRasIw6njinn93J+mTvoaZyL1tnyEapCaW0MLoJzXrzFVG+zsqe+TDNcgZHdG9/sCRzVO3vUYTEbBpnKBnwxbheSlz3rUf0Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761124073; c=relaxed/simple;
	bh=CK4ye5gW8ZQIbFQzPoD9lWgtQo2XoUG4XijMpi4CeCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xw1uNDXyBX2RtFhghvwbHRgQu3QHVwgDBFTcDuWiuUcfen1aRc5VFX+GDEwU0wAZJnPlPtDYL18qgXccJeMHh28dopiOCRwIEAU9CK295EJAS911Bzaz5g0RwgOoo0o5JM/mzM++Bjxq4ITL+JWwNjdo3JvOZUQS2DWXNHaG9zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vWkTnnCx; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-471bde1e8f8so16566245e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761124070; x=1761728870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P1flJABJq76WrUF5m9yiOezJjduWZm513fvxhMdJAqE=;
        b=vWkTnnCxDGCfAS/HR102S0nuMNvpFa6Dy96qaXniOMLn31UI/w2ZA0Ur8BsqJHghXh
         Hbo/lR3O49NQbfQQR9Dcp0txzX6jrXpmSMrmoHZIsjDbbsYC4A/MQtvYJMW8Pv07G8kx
         eMBsSMfGaoyOIXnrqEY1wIzaPFfQIP3aIO4LoLVw2Uqdh4G9x8tRoEXODXP5j0tEh8AK
         tGmEiqM2YFf5fEDW58NX2O+3DnWqr/dNrFI4OoKWGfaM/IYtx/01DcJESJGnfrQTjsuj
         y95avoxVvYDiSolnHWBud9u+fJav3g97IrACeAFWBOB7u7Q/tMy89LauCaRdbijgOA1e
         fVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761124070; x=1761728870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1flJABJq76WrUF5m9yiOezJjduWZm513fvxhMdJAqE=;
        b=gAbfmFjOI/S5B8Mi02Tbp/qPVHMXbTaGkrNDwuddHLofEpwvbagPeC56XABUQ4JMi2
         43/iVtUWdrXXHmyq7xGVVJAgArxT0uhfBhoggL/Hoqj1sg889A7fpcnCCgt2sXo8XrvZ
         Mgidlsh36pfId79HDrzHySsSWkbd0B1VZN45mPZ77S9RiC0htqIA4pIdEHtFfQH8ioIg
         PqHc4v6n3411Yg9ZfAgnL8xu1wr1TrpJDoCLH5mQdsv1/UB1gOShsimTNR2CMUcqr14V
         n0gRd6KY5o4LC0p4ilPVmFt7tUiZYj+a2ApNsW7I8AeDMcUYbSRtAJL8O08P58UKvtEw
         NQ5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUlPxpWDWaXr9S80pucxbcybr1tBvethkGT5j7wqY3Qc6zDGl+ULiYMYksKjK+Yw/uFL5xUj/K1yvg/Lro=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGcguipCi42D4KS3jaynPDflK5K9z8SE/visGsf9ZPkPljytV1
	kReai9TK8L4Bnuv6/kW0D96f2ZMwhXV2vOQwaqcqy4Xd8fURuDCAglumo1ZSA2KlrgQ=
X-Gm-Gg: ASbGncui0d6UpCnUvCfvbtMKq10FIMbL0UYtvNKu+0uzs51GEEFwmGS+9y8PoqGV1BL
	J4FiTs6OajhIAnrUG+fInc21wHrNYeCGbSZEvUBoG1dL5cEO3rrin33iFtMCW1BGi3RYd8pvWdM
	aoekhL1xYFQMsfmrpXuQTCNS10+q9P+6MY1APfzQlsgCKf+YPKNv2daZUaoEPMFyZ7ieVEnCQre
	zLxPJwTcW084GPOxwzEI1HGHJk89LvcUGJsb9Xxjpyv9hGZMFQ0fDSGdU2VITJveQAaaaMm808U
	WYqlk5wku6nzg7pLu/+WI4NMyAU65pj1Afo2GMnfw1Fl6GhmgL7yNZczYADgz7gn3W46AhZnk/g
	Vum0hOxh/bX1HQ2imelWkMIQucPrZEpIDVWpIdWESi1R30gYPnZhWzBgqjtMjIHbnDK0/BTfC
X-Google-Smtp-Source: AGHT+IGFFlqpwATAAZ2BKrCrVb9D7HfZ5rwLRuh4BV5B0Yi0YMlAwBYfX4e0exoRZ0JufSPaMzAqQw==
X-Received: by 2002:a05:600c:3513:b0:471:1415:b545 with SMTP id 5b1f17b1804b1-4711786d625mr156848555e9.7.1761124069502;
        Wed, 22 Oct 2025 02:07:49 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c428a16bsm38447755e9.5.2025.10.22.02.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 02:07:48 -0700 (PDT)
Date: Wed, 22 Oct 2025 12:07:47 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Danila Tikhonov <danila@jiaxyga.com>, 
	Taniya Das <taniya.das@oss.qualcomm.com>, ~postmarketos/upstreaming@lists.sr.ht, 
	phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] clk: qcom: camcc-sm6350: Fix PLL config of PLL2
Message-ID: <5j7dxbp6biaweup6k2gizbx2g5cf5kzf34jx7mhukrcto7mkz6@3azkzkr7bioc>
References: <20251021-agera-pll-fixups-v1-0-8c1d8aff4afc@fairphone.com>
 <20251021-agera-pll-fixups-v1-1-8c1d8aff4afc@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021-agera-pll-fixups-v1-1-8c1d8aff4afc@fairphone.com>

On 25-10-21 20:08:54, Luca Weiss wrote:
> The 'Agera' PLLs (with clk_agera_pll_configure) do not take some of the
> parameters that are provided in the vendor driver. Instead the upstream
> configuration should provide the final user_ctl value that is written to
> the USER_CTL register.
> 
> Fix the config so that the PLL is configured correctly, and fixes
> CAMCC_MCLK* being stuck off.
> 
> Fixes: 80f5451d9a7c ("clk: qcom: Add camera clock controller driver for SM6350")
> Suggested-by: Taniya Das <taniya.das@oss.qualcomm.com>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

