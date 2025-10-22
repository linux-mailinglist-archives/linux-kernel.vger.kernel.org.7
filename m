Return-Path: <linux-kernel+bounces-864755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6B9BFB79A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 652D9508EBE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AD8326D48;
	Wed, 22 Oct 2025 10:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z3A5pfvH"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C128325482
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761130317; cv=none; b=BDc23rHWYj0seYjPcRTIbHYIRfakw8/bdYcL4ALeB4Yg4THaiiN4zfX4Dm5MOS4lXZDPZdOQHkkRVX6fwUkwDnTOTP7ewBc4Y7v4NF1lF+ghF7gycpWQzYtMTuyirFEnS8uno6689ienRcg44oUhGeOO138bvkyGTfrYYKl8Png=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761130317; c=relaxed/simple;
	bh=0emIbIHta2KZrdaQPWJL6o23SZSpJgnhglkKqaRrkZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzjzVxmyA0ON0shKtYux+keEv3W2wFqzsYkF2MAaGBW19NGbe14tvckeHwP8to2m3ZMOnTrxW3VKVyvPqlyfqizfQlkm0QQk+fvmJrcAp989fzxDIcGnN1jzaVP2NxvA6EczibuTHgAvHtqHLjHvMMGZsKiwuXqE49Nbjg+3DGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z3A5pfvH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47117f92e32so44801345e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761130314; x=1761735114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wj0NZFWJVRGALI2+fvxHBDNu33Sev5bvshrkRXRWHmY=;
        b=z3A5pfvHkk8n7wHYf6hZGe3uhD2CtjlY/40Zt9gH8422sKNt3c00rULicZ7Ay7QEXW
         q+iQKrDqYlPbLnVEpk6cuW9idbQ4AoWC/f/r6BvtRgFpwpuIodK8+LXuDJ8Az6ukeCJO
         U9z5AL8qT0ukpV+0GVkHtgkJkzvFfq3pX4kF1yd+8mo8KhAl3ruXfm241uKyEqMR1H6F
         sNuv4JUhwOvyBGcmJhBi8Re77yMLsiCxOUoGJUPrveKm/aBNwJaeUIsJDyZvdtzfaEKK
         dSm4sBG9HNn4ofHVlk6cmnX+woZTHuqgS6Z/w3mPsw0tQGX2eakfdIfe5o7sJ6xkpRiw
         tMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761130314; x=1761735114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wj0NZFWJVRGALI2+fvxHBDNu33Sev5bvshrkRXRWHmY=;
        b=qSYjqMgPxNF/34RVFmTT0ylX/R5yym6aTvz9txwklRMgoOzEyxj9oXCLNv7OtY/TtJ
         FcbTxkKO80aOVawUpJeCZq9bT4aHzadHEqP5hIPXEm7Odbjk7i+OOuOBbaprHbqRxMk4
         tYrbXok2Au1/yBGJtnwDmhzmTarKbCeQsF0uuXRWV2q6oUD0D4XPVcVrgRA4R9Uww2K6
         Bg/1muEa+UtdhD04xwUDcccCQU1005RzZSJKImIcByoWC43ZSTXzFtqRcA/9668sPDvj
         ZycURWKxzW3gAYNp6T3zmDCaWV5gfUANgGJQI7bj6jcLBaEql309AtoDCCM7xaISbuQm
         eTfA==
X-Forwarded-Encrypted: i=1; AJvYcCXSunSFawjxSYqRV4/hjoC5i1ZGWcgk7dmkWHKvrXwruCxss3CZP4qhIQQhn+FM2o1GIfUIMdKJSkE7Snc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuOHydG9ja9qzw5nNiOZMprjCBVF/DrnpU0r7RGkDATkxT0an9
	JgUQ2BwwTdOb+K1Ggje+fFtfwwJ4YfGtS02Gc19QXPDD1Z9IjYUqxSN2Z3p/sOvPdwI=
X-Gm-Gg: ASbGnctPXYzlw1IghgwzfThknDcJZ9XRc8CS2f2yKL70hlvOCNMR85kuz/1jT0zET+z
	opyTpMHSPe+qbmN69PoZkfE5I9siegu9eyYrXO8eAUR8tEmh4Zg4mXMsgGKzBgUif3pUyMPooY/
	8foCbyHA6vDRsqJJEp7IJClXdVri+fbOWvY+i4xJSmfsRVMLZpz/9UAoII8dgH0m7QK346vxSPK
	vQEg+jUUhbtMqF3q/9JDj3PVqE4jh0tVDKfdkMIX15DA4nYVybGQnmyXxSXT0X2Pw453EdmpbQj
	w/Mc8k0Ijgu7XwIwb/R4RQP0nFh3ADxb4/JF5Lc0Ghrbb3TjKPuf7wDPzgZzr6FB/AORfhs9zF1
	Doxi+4Jn5bjImZ2n6i6d6WX+M777GuSHeTpy9OCFh7iXWQepDniugI/lD7AAOy2lE62WGLJwz
X-Google-Smtp-Source: AGHT+IFqoTQ2HPqFhE+xoTH5Tzl+i0vK7I5FUuawS0A8siSroPNadoWtujMORQ1HXcf2sw7QAqJLcA==
X-Received: by 2002:a05:600c:548a:b0:46f:b42e:edce with SMTP id 5b1f17b1804b1-47117925db7mr136759365e9.39.1761130313599;
        Wed, 22 Oct 2025 03:51:53 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c4342373sm43403635e9.12.2025.10.22.03.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 03:51:52 -0700 (PDT)
Date: Wed, 22 Oct 2025 13:51:50 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/7] drm/msm: Add display support for Glymur platform
Message-ID: <d6ivp57mh77gxybjvvwpmqoc5fsy52yydtvs23bepwdxgkxhzj@ahryeick6yaw>
References: <20251014-glymur-display-v2-0-ff935e2f88c5@linaro.org>
 <20251020-astonishing-zebra-of-respect-1c2eca@kuoka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020-astonishing-zebra-of-respect-1c2eca@kuoka>

On 25-10-20 12:40:24, Krzysztof Kozlowski wrote:
> On Tue, Oct 14, 2025 at 03:38:25PM +0300, Abel Vesa wrote:
> > The Glymur MDSS is based on the one found in SM8750, with 2 minor number
> > version bump. Differences are mostly in the DPU IP blocks numbers.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> > Changes in v2:
> >  - Picked-up Krzysztof's and Dmitry's R-b tags.
> >  - Fixed the bindings check reported by Rob.
> >  - Fixed indentation reported by Krzysztof.
> >  - Re-worded the commits to better explain the incompatibility
> >    with previous platforms.
> >  - Add the UBWC config patch, as suggested by Dmitry.
> 
> Where are lore links? b4 provides them automatically.
> 

This patchset was enrolled with b4 due to logistical reasons
which lead to losing initial kernel tree.

I thought the b4 prep -e should be the one to use in this case,
but now I realized that has a different purpose. My bad.

Will make sure links are there in the next version.

Thanks for reviewing.

