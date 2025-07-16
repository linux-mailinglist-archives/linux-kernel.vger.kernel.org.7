Return-Path: <linux-kernel+bounces-734282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D4EB07F6A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 23:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925F718913B1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 21:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD4C26E6F9;
	Wed, 16 Jul 2025 21:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vcyz9C/6"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D3B2AE8E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 21:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752700747; cv=none; b=usvscRNk90DywJWaAcGhmT1i/3gDeWqs+u1TTvFCj5zEUke4QGCG6Q+7tRoqHKNUNXoiCxplpdLMXbrrpUoHsgzQflj/mwy50lT6jWTpjMwin9pvGbDo11aK7VIaszDPdP3RRfmGh4pLNPPqZMiVP8e2slmqEzeb8VAgw/6By+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752700747; c=relaxed/simple;
	bh=ZnwNzz+9PWC+5EpZJVzc8FVsoS5xjjXuK6o5yM/GmnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6Dr3AiWw85lpvGkbTRRqp6Jb+3K3q7fEa5GpCU4jnE1gGHavqcyhv4TesXr3+xJ1lXJ8bSalRQac1aDyld0WyoIEl5c2fNy81gmvX3LrvqC04Sd1vu06AlFKd8GiX20FJiJ5JE4Hg2ggSGXQyAYnMvayOJl33++r2pMBWpqpk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vcyz9C/6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4561ca74829so3267185e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752700744; x=1753305544; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gRKMCti2Ai/CuBdEyVpIY2yewXiU7F1sYeoCE/NOUlg=;
        b=vcyz9C/6W67eXML8/PbBQ1lbAZnoTHg2D8W7ja3ve2Gq2iptyKkCNce2CyQCIwILkm
         n/0UvayEUlSVkeR2p4Qc3o9EdtDBSTI2EPtBGfuR3jAzfB1s8/uCaWmkV//1WftrO/Xi
         wc8QfXrq3YOMf+iOgAie7O9yx8ERf8OLf7sEvYl/XuG6WupRn4vvXwDNjdvUwcmZIiAf
         y+CVgbJ+a/ZJFRbjxJzJzEZQROLhZp5HJ2I+197x/Y+kAkS9lM6LSxm2QIZMgYPDOaUM
         ++9/XwfCmEONTBrNltDXe/H5AbramJX+7CDVQII6SViW1vRJLl6xJ8owTjZsqM7y67F0
         ICug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752700744; x=1753305544;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gRKMCti2Ai/CuBdEyVpIY2yewXiU7F1sYeoCE/NOUlg=;
        b=GSwXf+BVMSkEtCK4Px4SwkkcpKNZD/nRSNAIpzJ2qT4fjzYilT53LtW89EKUXLj1uz
         HQPKPVyrUnyF42CTofL7N/zFZYciD13dImoXf0wsqN30QMvX/M2mMK9ix0EkZhPnW6mc
         8AqujFtxAKBt8Zljg0LSabR474dcsOmmVAATYCQ2kZbTTb/biJwwHhv4tt0IRrbmlzDa
         EqnD9gg+uJdc8VUMiUld5EhnJnvXKpDp5CnXWkn62pRkz4l2KeATSDTeKYdotiIGo2I0
         1ZQse+9G+V8sGnFFSfZwZvbQwpHJPxElPRd8+X7Da8Ex6dMNdk0ANajYradPXIZXll5B
         svBA==
X-Forwarded-Encrypted: i=1; AJvYcCVz64hrbXqF34SvbY1EnZCOMf9hFM28+Son4WH1vj+1K+OcbxG6ItT2dVGVMySlxVMsZgFLhMbhvtWCw2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YycgpG6kdHvudHqD0YCPbrnzq0fSw1SEgK8991+oLWPVdtzzcXG
	yC5KsHsXZ7oU9uRSrn6+k6j4VPxfpTaNF/GKWhEc3ujVF8+g4M71LG88xl6Ypr0hRwI=
X-Gm-Gg: ASbGnculLJ3PS6e1VdbidpObpAsRMNu4/13wpGP1F4niHhs5wPjB4yc/5ypymZj4X1J
	/RD/ej0uY9eyu0p97l+OKDbpI3jIaY1xIBh4W2dMz/RaTrPynzHlKsozmqeqGuQCjteqCvQxdVy
	BeRPOkjqDRAnaAgW2geTg4z3IfSpcqAD89ABclX1pCUVDjqc8DL1Ou2j1kPhvUzYMs+8z49NqA/
	yBFUKIGvHNOfoEEt+WT7WQAd4cGLHnJHiYs0ygYiH5VYuGjGDzoSsUJBY4kcfzy0+wi4B6ORPPO
	SslAr8Oo99THeMhYULVFLslyMbrwOQgjskAnaM48YnCtewHZIbRIqQMR2BrO7ZxY+/shshNDUeE
	lNxACrpTAvn/6sDFXAtHLAMUm4ITcvdsbdybWDemBls8xLemxyfTWjbrKvDfW
X-Google-Smtp-Source: AGHT+IGU+ypDAJJxAGg8IJL70QMGqBYPckZVXPJfzPAtYPsw777vZbMiHPPbbkBp+5WtNr4iOtNXRw==
X-Received: by 2002:a05:600c:6097:b0:456:302:6dc3 with SMTP id 5b1f17b1804b1-4562e3c4b98mr33569505e9.26.1752700743650;
        Wed, 16 Jul 2025 14:19:03 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e7f4294sm31833045e9.3.2025.07.16.14.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 14:19:03 -0700 (PDT)
Date: Wed, 16 Jul 2025 23:19:01 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Mason Chang <mason-cw.chang@mediatek.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Julien Panis <jpanis@baylibre.com>,
	Nicolas Pitre <npitre@baylibre.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Chen-Yu Tsai <wenst@chromium.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Steven Liu <steven.liu@mediatek.com>,
	Sam Shih <sam.shih@mediatek.com>
Subject: Re: [PATCH 0/3] thermal/drivers/mediatek/lvts_thermal: add mt7988
 lvts commands
Message-ID: <aHgXRcyEWreMC_P-@mai.linaro.org>
References: <20250526102659.30225-1-mason-cw.chang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250526102659.30225-1-mason-cw.chang@mediatek.com>

On Mon, May 26, 2025 at 06:26:56PM +0800, Mason Chang wrote:
> Add the LVTS commands for Mediatek Filogic 880/MT7988.
> 
> This series fixes severely abnormal and inaccurate LVTS temperature
> readings when using the default commands.
> 
> Signed-off-by: Mason Chang <mason-cw.chang@mediatek.com>
> 
> Mason Chang (3):
>   thermal/drivers/mediatek/lvts_thermal: change lvts commands array to
>     static const
>   thermal/drivers/mediatek/lvts_thermal: add lvts commands and their
>     sizes to driver data
>   thermal/drivers/mediatek/lvts_thermal: add mt7988 lvts commands
> 
>  drivers/thermal/mediatek/lvts_thermal.c | 74 ++++++++++++++++++++-----
>  1 file changed, 61 insertions(+), 13 deletions(-)

Changes applied, thanks

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

