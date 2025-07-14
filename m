Return-Path: <linux-kernel+bounces-730478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9522FB0452C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD9897A5B23
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2413425F780;
	Mon, 14 Jul 2025 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yHMbRUFY"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D015C25DCE9
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 16:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509720; cv=none; b=WNOrlkAmdI/XlC+gncIUjcLgb+piKTDcXl0dwv8mZgSiuaWUNp7AXQs56k4ALLT/5l3PYg8seSfwVCgzyVR4eTptoFWnZhGHVwjzg8JOg93hjr6xZMgEndKGojbhKIqGySwiqbK7a8y8RPbTenqABXE3LAWFHC/gMdIEKxM8dzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509720; c=relaxed/simple;
	bh=IjBeInEqaR1AscqLvKgKjS4XTBwWEKh0ri2IaZtcn4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtFcYk5RG8j54BVwEaby+F8C0PUXcvmmi0TjkxjK0kwVeXTGqmcC5xKPEisWKX5A0z9xu/MkkzjkTWpmPrfav2HfDYSGLp3AoakoczmYIZEy283yTYyCycvr59sWMzhXSZ/Xc0Q2yJMkj3+DNbk/pAFjwMw3pIDMFwelU0qj7ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yHMbRUFY; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-454ac069223so28043355e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752509717; x=1753114517; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3uAikWubYwboCjSRWy3UuVNVoy2pKNWZlPhshgLVbQ4=;
        b=yHMbRUFYaBz3RNIpGguR3WfWlMI6llGgXJPfWH5Wpk+spsP0Z7H3TBF0vuoosFRTU8
         PPn1sSsgHWZuIx4QuWd8FF3oIFVMLt+fnBNnBewu3OGCOOg8ish5nN6Ma7WbkVwPfmua
         QDvAzI3bjMgHxeMuBtY7qvlglEZvinP6C9LtctkFAJZ+F1g9llB3XRCayf3klrIKEIUx
         eH68+o5vyNmhlPOfBFGqOfzlm+Ls/qht/L0tyfiLtK8TKGR7PMQ+jCDLzAuUdm/9pLgS
         gx/oDoOZeMo+SbSl6bGgRgL6kg+UjbO6b/J5MaeTMFpU63kwX87mWg2AxzJ1GZDrax6L
         PsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752509717; x=1753114517;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3uAikWubYwboCjSRWy3UuVNVoy2pKNWZlPhshgLVbQ4=;
        b=ug+xjY0l90CRpzrRdmWcIX0nTk7PARzrMTQjqDC8R0GiiiD++QR7KNiWlODJ0Fro58
         0CjbY5gxC4tDO3O1tOHynGrwAdKKIhhFImWRJyFrN0tOZvXiT8BJeca2wjhjx5hxRlJz
         IPl77Pq7bcjvlr5J/PUnv1wiPxxilx5VOocAq/orOzu8qaS9+YbfZrkEK7WNg0Q1G5gh
         bRZcofTS0wSyl7elZV6J0cgnT5LemPfQcxWnDifS4Qm2IWI+7S3Sqsm1LJP7BbgyEkL7
         TGkuuQfgT9HsGSsNgse8Jw0s2i+QpFsOqbbP14eSKStVNRNjRHSPO2/GS6MFzaKEkSXs
         7WWA==
X-Forwarded-Encrypted: i=1; AJvYcCWZlC5Zn1bi45uBMF5WvWNr2zi26a+Qax5Cq3brjh4LZM60P+XHh1HVa4l0jgVYnQZHT45spUsDYe121NE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTVu+qGCkSRbhxdONlhrDMslRKlIijwHjt/rsGKA40bOJYVzUJ
	wBxgHU4CpgsA0Zj+9bKBkvEEuVwUl4uU0zV10IKgZIs8q2aVZ+JDcUWbBof+smCxbZI=
X-Gm-Gg: ASbGnctp9wV+0WSE3SELLEPjE7zJ46NsOoHWZIkKoYCqWf6d1NZVD2+NJczvqjZtMdK
	RWuuj+jj5Dp/0wdGUtKr1cBSlqjFXwLE3u17U051Zr24/AnUhJ7OxmKMADvWyXnRXct/Jp0Pp/Z
	s/JM+tc7prMB1nuxwC309sFcLfSLBckQ5V+O1ZovQigRAVC5owAfdC4s09uGbJDijw+x1/NIKqw
	YW0OHYkPw+C+YoOGBflMgCW+rBkx8Xul4W4+lhE/o5WhVJ5E/wkYsHT5MeFJtab1xFBUjhhkcLd
	HPVCJZvZY0v6GahUrGn/3LNCvPIU3bJ9GryQzYF7mSWOkqxA2rByWUEZ12aX0v+DQ8qcgjOs328
	/7D+ywYRc9ydszua15RAMx2NOCdjOdItY0pDOSaHCemrO4W45FP5tyhACheUO
X-Google-Smtp-Source: AGHT+IF8Q5A5IBRFKNtkBPYHjR2xPA0d69ZBpYOWGitAoZJklFlZt7awSNWbCXaAjhvDRCs5mvb/WQ==
X-Received: by 2002:a05:6000:2dc6:b0:3a3:64b9:773 with SMTP id ffacd0b85a97d-3b609526044mr126904f8f.10.1752509717039;
        Mon, 14 Jul 2025 09:15:17 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d5f5sm12914206f8f.56.2025.07.14.09.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 09:15:16 -0700 (PDT)
Date: Mon, 14 Jul 2025 18:15:14 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Animesh Agarwal <animeshagarwal28@gmail.com>,
	"open list:CLOCKSOURCE, CLOCKEVENT DRIVERS" <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: timer: fsl,ftm-timer: use items for
 reg
Message-ID: <aHUtEgJxDst0il_4@mai.linaro.org>
References: <20250523141437.533643-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250523141437.533643-1-Frank.Li@nxp.com>

On Fri, May 23, 2025 at 10:14:37AM -0400, Frank Li wrote:
> The original txt binding doc is:
>   reg : Specifies base physical address and size of the register sets for
>         the clock event device and clock source device.
> 
> And existed dts provide two reg MMIO spaces. So change to use items to
> descript reg property.
> 
> Update examples.
> 
> Fixes: 8fc30d8f8e86 ("dt-bindings: timer: fsl,ftm-timer: Convert to dtschema")
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Applied, thanks

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

