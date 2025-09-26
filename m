Return-Path: <linux-kernel+bounces-833995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AE9BA38DD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D64D93BA7D1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42AA2E8DFD;
	Fri, 26 Sep 2025 11:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ha1U2bP8"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCA32E093E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 11:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758887780; cv=none; b=qTxAfMwCK4R+B432Vh2uzaLvdDwuiSN/lGi2F8m7odou5IYqr7IOxonaIYuiha4mcr6gmLvIjolL9AJJnkuzO1XVQuMW5L2/fQdpwdQkpCOS+YxbRXhjecyJfQaotugHDhSvfOjEdrMRIKOYfbr+8W8a9qpnjPiqPoQC97uskMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758887780; c=relaxed/simple;
	bh=Y5lO/lajfG3GUkVLo5ia+BO7S+9AfAuPZaobXibEtLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHc6TJFVhnd2q5wpJygzEIiaDYD2kIw7UowDL+Mw6XOpLHWRuKoEkOhW2766wjpagyRQXNdxpM3J8ik71+fKzXdLBzoFU6L4gpf8aBEfF6vribHqlDpUdZz4XdZTRE27C6z85JK1gWyKP+AXvKkHPMQXVJqdaoV7MKP/+GXhuwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ha1U2bP8; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e2e6a708fso12237885e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 04:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758887776; x=1759492576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Ut9PX3cAo1VE+qoXsWqw/nQBs5+sgJFMGOIiq69Ad8=;
        b=Ha1U2bP8vXIYtd+MiUjiRJAEA3nP8LmMKJUWB8TK/LxG6oiw4CGkW9ggmB8KmLvNMB
         nmm62GRs4jpGTKW7+QDbxnnJ1qRyJMOjeFhD3pW6k4V1dtmlO4fZABp77+ccqRK9Z31v
         MWVrtwNpLhxUvD750fSK3zZbbwTcszfqn04uDEeh09Giupkdu+xzTqBO7cudRkZUZbq6
         dO3pTrtWEqB6qKr/pNJ801BEjBnIW74Mjz/WAcfGw7aJImRAlO9VxyqU/8Y/kx/ySXPo
         wXYjekB0xNIFxeysXAomystm+FqSZ5X6ypafaj1Rze2Ah7wciwCDIU+r9f6LUl3a4iLM
         E/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758887776; x=1759492576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Ut9PX3cAo1VE+qoXsWqw/nQBs5+sgJFMGOIiq69Ad8=;
        b=wE3YqC8pRz/VQXCDzAiP8e4DtNoUkfXnA2ymA486jwPQk88/xH/WZ3uNCTHEVBo8gH
         kAIYecvMPW1XVKyA5Q6qZDdcgJAcXOTc3KkbNHX6DS+n3advQoVu4sL9XEPMLhppmlPQ
         xbfN8Vu3KTXL2CWyWGGaKwIWXlSs4DKCa4sa/YPWOv6VhtFt1tnzY2pdz1L37IrT/gEE
         GnmFuBBUtB/d2HvUuaVcJPb5CO1hHJ5T84S9MKYUpdjzO5Av335y67I5pqB1wngLD1In
         9cvAPLW4rlELdNo57daiwlgugZAH33sfvE/z5w+8lb/dgR7oUm3anYUQLNz4KxzEfNKY
         O/FA==
X-Forwarded-Encrypted: i=1; AJvYcCUHTvTajjIco+Dny4SdYxgaoTyiyMnoCdmb0NhH5F6PLUF+qvi2c0O5WOxNRly/+ntoSM/Sj78/DY+dbSA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0QtEUpDsF0eKpbLdkivTxrWelTbK6XG5pMrUl0W+xpOz1/IW/
	vcUFMDASANHGGo6WVehO78+Qs6FQduxEOuKxjNolil0jrKuddq+9eLT+gV+4f/RBvxI=
X-Gm-Gg: ASbGnctd28ESc5pAy56bdyoaXiawf8oXZ9GKIbUEWgGO5/GrExZbMXY9I8fL3hovXX6
	L0e6x3Ckq/QQvKLdbc3YZFmyDRXb2w/tYvHJs9NaKdtBWT/72aXDwTpaiyxqLenX4FUM2zpwKTU
	C8s/YSV0yk+LgCqPbs5QtK4HfRAtuKbIAs7sDZKs1haqZpWrWam7v8CrDaHs6ukH+k7GLZiahwY
	hvQYgYWRTWpaBpawC8M+Xms70/3PLJgyY0P0GMCl1vCWcCyVl0osHeGHHwQFHtO9wLBWeBrq87/
	kAvwCVcc3/Hztd/TiEFZCO4c+LSGyTGJoiRLfpbfs5KaET9aQVvUgl1Tkihiomdyh9Ui/IxbU+s
	mb6YiNbh+pYxGX9PyzCJLnZ7mLB/Rw5ea
X-Google-Smtp-Source: AGHT+IEhOtwCtT7hGmRGCgAuHa3ZlRs8uxFPuN5Php6GAeEsMeg5YY7gRCrXkIv2ffaFf67OznqytQ==
X-Received: by 2002:a05:600c:1f16:b0:45f:2cf9:c229 with SMTP id 5b1f17b1804b1-46e3292ea63mr65336745e9.0.1758887775546;
        Fri, 26 Sep 2025 04:56:15 -0700 (PDT)
Received: from linaro.org ([86.121.170.238])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33b9e3bdsm77800905e9.2.2025.09.26.04.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 04:56:14 -0700 (PDT)
Date: Fri, 26 Sep 2025 14:56:13 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/msm/dpu: Fix adjusted mode clock check for 3d
 merge
Message-ID: <lteybuylw4ejxsnqbyv5cyrc45od4y5sccg4k4nfjkzbwc4how@xd323dg6agbd>
References: <20250923-modeclk-fix-v2-1-01fcd0b2465a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923-modeclk-fix-v2-1-01fcd0b2465a@oss.qualcomm.com>

On 25-09-23 16:03:50, Jessica Zhang wrote:
> Since 3D merge allows for larger modes to be supported across 2 layer
> mixers, filter modes based on adjusted mode clock / 2 when 3d merge is
> supported.
> 
> Reported-by: Abel Vesa <abel.vesa@linaro.org>
> Fixes: 62b7d6835288 ("drm/msm/dpu: Filter modes based on adjusted mode clock")
> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>

Tested on Glymur CRD with yesterday's -next as base.

Tested-by: Abel Vesa <abel.vesa@linaro.org>

Thanks,
Abel


