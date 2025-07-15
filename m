Return-Path: <linux-kernel+bounces-731721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4A3B058A3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82E127A7BF1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA202D948E;
	Tue, 15 Jul 2025 11:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QO6L1xt1"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4630D22DFB5
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 11:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578593; cv=none; b=d7dKG7c22QVLuekAOVP+dYHLSHDA/sSmKqbfe0W1o/ZVxmUv98zPx3MhC2UKIf4rtunjgza9tYoBJPOP2rUO8Pb+as52kYA+q2GgfNAMn65ZoJpPW/HGBLr4Thucgzo35rC4u7K0rKICKvqcYEq0BG4HCvYFH0v2d/vGg0h7nSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578593; c=relaxed/simple;
	bh=bZ90k2ZHoazxrj+WXjgsKXIynmPY+DOAnPKqwHoqjFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMzpESYCdPqgyTz0VLRMpenqhb0oRNL9bHrpGqmofO0xqwBN2I/TiZ3kRcgXYDqQJRxaSwSVBVRPJPpq5qtZejOqjutKQE57J7JTfAUBK463kQ1Bv6RnPydoy74bHTLKQA9FMZw1yBuHt5b3ivsFPL7QrqnC/akV85ORFcBvtyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QO6L1xt1; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4561607166aso17183595e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 04:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752578588; x=1753183388; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IROohcnT2HQCfIKhsx/yQHN0OEa0Xb+k3P4V46L5bTY=;
        b=QO6L1xt1MVmJYZVTim2Hj+Raz//T4a4YlBOHIbuk9konXnjDvDLOozYy9LV6cOeEIe
         utZW5lkSWG/z8LTnVW3yDWyQtAq0XUt5zAQ9/pVcX3ECqS3GfIjiI5vWGmJmQ7JPAR6j
         R4xfNm0Ix6puXQR3oesgE9cLDAbb5UUnWspTjOv+LIMETI0nDWdZ8IQvYrGxtJJa+rAM
         kXGVFMnUyaN8reSuEFOQe+SOb1Y9lRGuCqlrGpXIAn9nX+9gW+TboiAbB9Hvu/VvAj1Z
         cxJSsoDngBc4uI8PK1BPlkStVhtC7Fp3erAG882HQ29fVle3Z/Hj9JtbErObLzTk1FeV
         Ib+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752578588; x=1753183388;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IROohcnT2HQCfIKhsx/yQHN0OEa0Xb+k3P4V46L5bTY=;
        b=U1Fx//QUabvb2baY5JzPVUExrRz2obiV8roPBOD4d7UAAucVOlfm0fSczPGehJe5uh
         qvQNdnP/wGWn6NYz3cJWUnBuZKMFgJuxjph/i66aXjaBnUKMyhTVR5GDrVVM8zqj3tV1
         PE6pSVHZys3mXCNfdBOT5LzAbDz2Tf+KuOXiMA/rNpQJ2Mn+kpg3yRZ/ll3MqJWKMded
         zsQLz27/viy8etwVElJBIa6PoymO6/u9POmyz2EB1Z1AE+JxfuA4bpLEIn2/qN/AensO
         0WIttf/QCkHSRhQ62wmLcLg8RQgAtYWyGYPHfG1abeBhQ4olJCDuNekKy7kLcX+9Kb4n
         XXFw==
X-Forwarded-Encrypted: i=1; AJvYcCXb8pklYfd3YRJ4eGBHUDQqnmQ65Fs5/B9Y4c5ZT5aeXrMtNXSfFVMzNZTK14XLmNFdmKjKl6tktCab47c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxixdN07/XfUn2KmsYf51KJUFHIqOZRm44Q9AIHE/Xcg0jA7A+C
	rwTgVOa4l9V6Zz/6fkqqr4PohXumCYp0XFiQnrYsF+xxek8Mtb5y/Dpdf17pzgedJAX5JQUH7j9
	Ab+Da
X-Gm-Gg: ASbGncuJYxMGmWDt+/CLi0tUVWwih3C8b3DRcY5lsuKTipA3ZvOKfy+na6GEKyxOu+V
	qxXlEMJPXxyw3Rtd2Ho/Ex08DprnXfxf2x0p0WKJgeh2qtpC3OuUxg8NfeGuEXMvqeRovoDSbHq
	1BHSNsdnY+xk7R4H/2CuVdtbWthUzGjpsgIcyZct+A2lIOStcvAqrpuKyUSFBCapibw/9Pg+44Z
	/3Li4e+ez9/HHfPB1vLlGTlisHxhNjc5GPFFeEYTB79LW33ELu2ZjPese028RT69n8vB5YhzP3d
	kfFpoyiuchM8W4t+ukCz1swjbkJ1mL3JVGtr6AjZil9reRqjPtktPYzuT0yNgRve6DDHtplujHI
	0AgkhhLe3KcxIK4OwKqAvQ8XwGD42VPxNWPtenAbl35WRc7me4CsyYia3KOI9L/twcY75Oms=
X-Google-Smtp-Source: AGHT+IHQ3prgUe5cBnNidral8utHdbyigrerAyg9IXxceMi1779788HUGWodqsh1bemWlLH3jivHPg==
X-Received: by 2002:a05:600c:37cc:b0:456:117b:94bc with SMTP id 5b1f17b1804b1-456117b95bdmr100596885e9.17.1752578588578;
        Tue, 15 Jul 2025 04:23:08 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1997sm15158740f8f.10.2025.07.15.04.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 04:23:08 -0700 (PDT)
Date: Tue, 15 Jul 2025 13:23:06 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:CLOCKSOURCE, CLOCKEVENT DRIVERS" <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: timer: Add fsl,timrot.yaml
Message-ID: <aHY6GnjMW0SSJQgU@mai.linaro.org>
References: <20250528165351.691848-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250528165351.691848-1-Frank.Li@nxp.com>

On Wed, May 28, 2025 at 12:53:50PM -0400, Frank Li wrote:
> Add fsl,timrot.yaml for i.MX23/i.MX28 timer.
> 
> Also add a generic fallback compatible string "fsl,timrot" for legacy
> devices, which have existed for over 15 years.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change in v2
> - Use items for interrupts
> - update commit message to said for legancy devices.
> ---

Applied, thanks

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

