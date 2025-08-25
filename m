Return-Path: <linux-kernel+bounces-784047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E347B335F3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 07:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2A3B7A8283
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 05:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4781F2797A1;
	Mon, 25 Aug 2025 05:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="odtwJzgt"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEEB22E40F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 05:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756101054; cv=none; b=EfgPHp7o8eEDEFii1lRsHfquoFt4WxG7+/1eG0CRCnGNAALTnfVU4Gyzz+AbMfrJNH9Gl9YBCKppk/Zm0Lbe2h1XKC8K60/+ZyT35qXHjgYUaYNnEcstdPipj1T1324T72U6Cng+R2tvSAEHh9oQJj5/paBdCVE++NNJshS6do4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756101054; c=relaxed/simple;
	bh=BAqTAdXs4MjQC8FvQcEMzCUW5UWfMeCMYzz/lFKaXXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=teEx+o3KIwLYPUeaqeYE3EgnY4QkhXMlR9HdsvQpUj4qKuGbpYbVF1uobConDDO+2Ue6wY/dmI0Z58y8iSExFDVRqBzu6IU3TsXGKVE3projFsW0Y3NH+BfOZP2gfH/50lcjB/Tw2HW8eKTcVeppU5+czZb1lW83c53hIdHE+Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=odtwJzgt; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso19898555e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 22:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756101050; x=1756705850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XxtmnzOlVO6p+V95rUDP1WiZ+MmPfDK3rKZ1gsByIZs=;
        b=odtwJzgtkfYyUdh1XKZR1PoDxq1l2mHF2cybZD3VFR/SEh+VSGef8MUacJiDsLtoX7
         iNAjC1YlrMBHl3sbhhPiDW+/5/Sz7Y/+rqeioC/SMKXIpjBbWnQ/4V0HBXhkqprHTrPs
         SN81kd3O3P8S5Bvk2XyLuboyKMqVz+OZnmPkr+QrtFcFFSfz1t+XtiE9w25R0zUehaRO
         MqwgYQXuJ4+6ClQR0irT5wLxAJL4OAHr2bWk6uoM8bW8FSl9XPRTs/hSA15iyfkfOms3
         k+ydEB9pXzCo8SoJxtVR2pBv0avfIB5LuS8v4wOwKwvaz6FxkybZEAJXeK5Er6ouR9z3
         VlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756101050; x=1756705850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxtmnzOlVO6p+V95rUDP1WiZ+MmPfDK3rKZ1gsByIZs=;
        b=v1bhPSQrzbBmqv4m+AGOP5nrGuWHZ/fG6JZF0MCmhFaodwSd41GbmrL91Tx1uYXdQI
         h/smPBGv4+AkP/gCrF71MsF2P4PMZr005afU5tWNfEXVsfyq2FdMAKE3fWhqVnC1r9Xa
         zWPYca3UEHLhUSnS40UDdQS4UdF1z3jQQRDK5dDkKczmE170BYDLhX1fkWRytiJg+xbQ
         jbn5fb/CnngeRBnXODbBJDjNITsPMvRUanciZbkaEEZLsceHdlU0vEK2xcTJ6IVUicRK
         VpwmWPT1n5Rw7t3vULooTojZSKjBJyIIZsdW+4USRTwFEtQ/OinBm2V2+H2eLiYBT/IE
         4bSg==
X-Forwarded-Encrypted: i=1; AJvYcCWgy6iZ1h2Iq0KPBDlzF6GifmeDYOSS1mXtLDydW23v4u3XJYiNSPocRfWBET5gIoUhXhOj65r7h69GKec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxhsl+m5EKHuyNs5WnG8o3RmGskXIvXs6jAbiuAGcESl7kd5ZM
	EGhLtKk17ugBryJMUsUkw6VpCCyO/lUNpP6GA5iATOn4G3Jq5CGqLe+CrrkR1tPrkxo=
X-Gm-Gg: ASbGnctCHhyQ+xE6YxqMia4I8MJdpvkFc4gbt16KDLRHvZTDOGahaPP4B+BfuhOcBoO
	szh2Z43zSY493GcgcLjBkoRmV9EFU02/Gj+UoFqeUn2cjAEWZPscq3BDTFu0oxdnDwlpfDJ6zVk
	T5/Uq2mBaoMM1hwlTYJ4RvdXxrCFIM8a68uPUXf70Hwp0lYjjA5eJR3lN6iBIlKlpGmHxbUinps
	sR93+DzJVzYCdP9gIovJ8LKc2qVXzTMGEcHsj8BdOA5ivVT4MqMmyWu0yLhf+a7rM3rHRsBB0CY
	h867c+/5OAa6kqhfwmWgTZlrpmdhpaniLBxj7AV/v9kLWsr7OE4u1pL4VLOYaYoeUlQ2hu7LJl+
	OxxLgrH0zUWrv2K8O3lYYL7xl+F0=
X-Google-Smtp-Source: AGHT+IGz2aNXINA9AVw27//eFJnmfZs0Q3t84LgC59OwvDU14iWZUpLl1zIrpYWB+eSKSTk8r90CxA==
X-Received: by 2002:a05:600c:154d:b0:459:d780:3602 with SMTP id 5b1f17b1804b1-45b517d4185mr86200605e9.23.1756101050486;
        Sun, 24 Aug 2025 22:50:50 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b575929a0sm93063515e9.25.2025.08.24.22.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 22:50:50 -0700 (PDT)
Date: Mon, 25 Aug 2025 08:50:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Brigham Campbell <me@brighamcampbell.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Douglas Anderson <dianders@chromium.org>,
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	dri-devel <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH next] drm/panel: jdi-lpm102a188a: Fix error code in
 jdi_panel_prepare()
Message-ID: <aKv5tkJghj6DZQIB@stanley.mountain>
References: <aKcRfq8xBrFmhqmO@stanley.mountain>
 <DCAVWVJ990VS.255346CDNF1GK@brighamcampbell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DCAVWVJ990VS.255346CDNF1GK@brighamcampbell.com>

On Sun, Aug 24, 2025 at 12:54:41PM -0600, Brigham Campbell wrote:
> On Thu Aug 21, 2025 at 6:30 AM MDT, Dan Carpenter wrote:
> > If the mipi_dsi_dual() macro fails, the error code is stored in
> > dsi_ctx.accum_err.  Propagate that error back to the caller instead
> > of returning success as the current code does.
> >
> > Fixes: a6adf47d30cc ("drm/panel: jdi-lpm102a188a: Fix bug and clean up driver")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Good catch, Dan! Thank you for the patch. I'll try to be mindful of this
> kind of logic error in the future. Please let me know if you have other
> suggestions.
> 

Heh.  This is just static checker stuff.  https://github.com/error27/smatch
Humans are expected to have mechanical attention to detail at the
same level as a computer.  I just try to write the commit message out to
prove that I've looked at the code as well.

regards,
dan carpenter


