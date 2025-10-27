Return-Path: <linux-kernel+bounces-871318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFC5C0CE85
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B78753BB802
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8503C2586E8;
	Mon, 27 Oct 2025 10:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2djFAOX"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573AB4C9D
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761560057; cv=none; b=GkjdcZKjgVrcuFXxGLGS1wfRLAVuYgEIlQYUL13HzoWd2SE5sRzzb13pJoMe6IqnlOZKRV6CEIxYegrEav/7T9r5qrcDNplQSi4zTcSkMmhgC1VIIEJ47Sde2R9TUK1SGv5EVS2FofDhj45znmDUnlor8bTFMUpemoWFj1q1wns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761560057; c=relaxed/simple;
	bh=0W198tq9syL7RzHk/dg2UdWGrq6EP/bXXQ1FwXijpt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrhatecDNsJgu+8Yacqj+4eh1XMRGA6nqQbKXLg/rM+CnQhOhIdx0TGHpVe1cmz7NSr607mC/VJJxbBkHKQCu5WaUxzne2v+RbtkASzhUMKYCWnYvswjY+fJWAvrVpFpFP/gb4twvrCXte6da/CpHUdg3KwGfw8K86kk5IMRlfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2djFAOX; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b6d83bf1077so483616866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 03:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761560054; x=1762164854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aTqsNz7aSAEuO3Qu/0965qQzJTzUJ1fOn9AY/UKGfhc=;
        b=B2djFAOXEp7ojeBJHXNcT7VFPHajCRAQwlHImGisF1DDe8zbvXSPl1jH5d1x030DZU
         nxfESPYiVeMuKcFOJ2Hl6T70KSUtXY39VMWo3mYPMG6LrJpbvt1sKHu/eW2lC2kUe79B
         kGM0R2Kx8m5R8GZWKlfifiYpCdwZBsYjdS6qIm1dCDAlYjJ9wot9w8husZN+/DkWEDG2
         MHxG8Sm7wEfuXMHht+56BKyrBdL3mkz9HZXOisTgKfxjppibmSLtRVuKGeFlBhSEzAjr
         4e+a6XvCChMpoijIRZpX2CskXGx+XJoxK7m9WZ3AgvqxGgEPFEvk3st6QVuMDQQtWURu
         jHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761560055; x=1762164855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTqsNz7aSAEuO3Qu/0965qQzJTzUJ1fOn9AY/UKGfhc=;
        b=S3YRgp1/lV5XrgoDJjB68eSEwAgitGKOtH3fHvNS6rIrFvQALYTCVG0cWPrK3fOQcm
         Y83eYHSnWmvSADAxvYHDXkgHz1y0VPh94AMifDmJhpWutSgvJipSFWOpIMhovjIhlS+t
         M+jxx1yyz9/6er7c19O4f5VxhGFwvKd5uTXrz/EjIANkjDnH0d3Kyvo3+sJeZGtCe3Ry
         GZV1PAZ26v+5MnKkAHk6orTa20jN3C1Ib7uNOeA2IeMtbK4lHlvgAToTzJroRwfqxnRx
         DGsjxZOtfakf5bbbBy7fMxub7N6/xicNnR5TQCsZpuHEGaZTfSIqK45ofWs/TD8+cF1Q
         egnA==
X-Forwarded-Encrypted: i=1; AJvYcCXOuu0pVkxDFkKb90B1BCL+ph8zBX6/RkiHE/Kna0Y4ZjZcc4w+ykbaQfUHikAj4WAdgFh555GUtAznIIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpXzZzMxUSqhRsPe7oHUdAG0hnIwwQBMbMgHu2mfdqf+uXcDy/
	B7M2tZzr9GF2m7+E3ei1iFvWw4tpQSzPGhWR5jylOj7Sxj/T1xtFXhIn
X-Gm-Gg: ASbGncsoMDxTkBUtWnf4dBP1IeARpa5X+cVPSXZnV5t6x6QRpq/pCCNG0F3uORA0MFL
	o7MjvVrBbD6QnLxkoi69nOvi/vbekprVs3PYTlVdjHuUZYnZCtYec+hvgi9e0x3aABQ3Oes235R
	MJtsiqa9tLmCHK9VNq8aWr6nRX6PP9+2y6FEKaTFzN5n4kwTeyk+Kohf7GkDUMq/DDq4dCFtOyW
	n8y0q7Ota+IEwMt70E8Cv5JQjsCrCXZtYOo+Xv17yofvvWK5W6a4NzcVricZWvpVCbQbYmJ4kGC
	JGfSBUYIVomTQzmyEPbzpYMVa6Dmk8jAvwcrV9jhrDJdrGRoPvHaH5xIb8Tti+dvxDj83EOuyzr
	94kMPJfq6JuldfCuNKzheQPaEE2fIUS21+U7y3kCFhIgshTcw8GsZ2H1I17dJPX8HbMVOO/vj6s
	vF1KWr4WrGlRNF+jZtHL6cerxZtqlz+RyvYqnXd9/eA5c6HsoGfRpl5eihLTYrH8ImJAE=
X-Google-Smtp-Source: AGHT+IHuypx/1E4ZSbA9a3TW5kaMs8g53ODTMc8NURVmeWR0+FhA3IWWamFa9Wtwow5u6cxfiIDvDA==
X-Received: by 2002:a17:907:7e8e:b0:b41:4e72:309f with SMTP id a640c23a62f3a-b6473f4543fmr4207388166b.50.1761560054349;
        Mon, 27 Oct 2025 03:14:14 -0700 (PDT)
Received: from toolbox (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853696aesm725747766b.30.2025.10.27.03.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 03:14:13 -0700 (PDT)
Date: Mon, 27 Oct 2025 11:14:12 +0100
From: Max Krummenacher <max.oss.09@gmail.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Max Krummenacher <max.krummenacher@toradex.com>,
	Adrien Grassein <adrien.grassein@gmail.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	David Airlie <airlied@gmail.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: lontium-lt8912b: Do not generate HFP
Message-ID: <aP9F9ETIipU55zI6@toolbox>
References: <20250728150059.2642055-1-max.oss.09@gmail.com>
 <20250911153453.GA80715@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911153453.GA80715@francesco-nb>

On Thu, Sep 11, 2025 at 05:34:53PM +0200, Francesco Dolcini wrote:
> Hello all,
> 
> On Mon, Jul 28, 2025 at 05:00:50PM +0200, max.oss.09@gmail.com wrote:
> > From: Max Krummenacher <max.krummenacher@toradex.com>
> > 
> > The datasheet of lontium-lt8912b doesn't require blanking during
> > the HFP period. Thus use LP during HFP.
> > 
> > Tested with a samsung-dsim (i.MX8 MM) and a tc358768 DPI to DSI bridge
> > as the DSI host.
> > 
> > Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> 
> Just a gently ping on this

Any opinion on this?
Max

> 
> Francesco

