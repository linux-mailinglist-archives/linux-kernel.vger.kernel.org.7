Return-Path: <linux-kernel+bounces-831155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A442B9BB68
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AE5A1BC23AB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E18B1F5846;
	Wed, 24 Sep 2025 19:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2IxPYm/"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086E424635E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758742268; cv=none; b=XF95XlNbhaT1OIo1vQSm0WNfv78f4heR753Te7A1ulrbda5Ip2wsbYaGZe0n/unR4Hm7ulXCwpJ51rx6nyqORYWx8lh+AjCxB483E5vLi1g1VyHhJJRW7pZLtI31SIRI82HbsXf5rptS8nCI/aElfu2rRr97bJ2rfyVHWb+GABw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758742268; c=relaxed/simple;
	bh=GI9Xl+MPFOHHEWNS6m62yjXMQrhju00mYgKx0uA5d/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OK+YVxrhYP+8GhdQXMQZA5Orq9tip1Few4DQLuO/1nHerF6hXVP6+PJZQ6ubflgmyb7+34uxEdXzh8qo3wkiuEiPO/7DDrKXSFT6ckCmr9f/hpecVLtXtc4qaAQXpLHU8nI9Itul8VLxGNVA4t7wkHEe1IUSgaiQaNsQ+JFcuwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2IxPYm/; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso203273b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758742266; x=1759347066; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PmXYYWuE84Zx3GWpt8FZ0tAm371gI0YIhPYxwUcYz5Y=;
        b=L2IxPYm/E765vjxiyaHWxQo8kqevxsH82AZYoCi87u2cIJNGKhacdjSx1isE/nJEJB
         FjXYrxWXVFbVmVKsdRqIAQ6s/v4UNli3/n24/ZFoV9g7A/NHcMInPjpk83nrSBdSl9AH
         z7gQ7+y2EVyER1VljOxeaKSTyJu6SazCy8pOkCfbDYMuTj/3o9KyXXpA4Rc5Eo7GXW20
         d0EsbuQGm2HBLXVCVNz54il4NBxzj3P8l8i6IqMN7pv1nguoCEmN4ZCb0atxsWvRhxWZ
         hCcHpl3d6HK95Bw3TllB0qCrN2z6iXofBPnUfTi+nOdfABMH0qskgO+3HulB6C22YZeq
         GkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758742266; x=1759347066;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PmXYYWuE84Zx3GWpt8FZ0tAm371gI0YIhPYxwUcYz5Y=;
        b=nQyyj/3Qc+uRaBb9XSRQwzsmjCEgpRBo/UjK/+uYeXQ/LF8GCnU2fkJKrZUGZofcRS
         na6TUloHIA7A2GcNrUTAmoEI623vAF5DYYQESMddnbQpWpYBZO8Cj04Wnv2EApH0sD/R
         vzaqJAgDZqRhf6DL05xoW95YHzG9MCjyU2/Mp5X12dS0O98SDlnPtaxlpYzbYckq/WZD
         aQbzHrTVjKoz2AkJOkEey4T1yDepy/GpAPYBne0MVfUtNzkF9v7BJUuJzrWxjTldOBgZ
         3GVltEqNn7lTJaga7P9J+fyew0+8tBtJyCXwv3D7UZ/8Hq3XbmklvV/VZBD1Y3I+uvHT
         JlLw==
X-Forwarded-Encrypted: i=1; AJvYcCV0b9vg4H7f1murri9y78rXeSyEflukC79vDH4UM2FK8QzzUC/OtKPN8zCiMKKl1i3oqnsLvgNXAhCwWdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlrfijOkGd3JjoEQ3KiyRPwlPWJuZ8SVY6m/2ZBEsJA/zJ1FMw
	slt2Fk82SniCHiU3An+mNU5QIIJ+J6n/cHsvV8Kzte2FrGe/C8htMddI
X-Gm-Gg: ASbGncugotaqZDLzRssmsHWy67CWZRSL3vDQnTD8YC+dwToal8AkML+d6++QIk9Tt+3
	hLqvYPwywWybTmXmEvttkf/Xr0lB/llikvxXFahn7eN32YAjoOQtOM1AKXe6xtbYCH5Zci/RRcL
	q1qL4/7Df5gyjLoVPjlujAwz6jpOdlzI/UvFxFx0f8ofMO3DbIdWcmDgosI3VZ5ot1DAv/ADa7F
	W6MAIGkgjCZciyJbMYVRoyOCvXUVI6VOrttxZwy26a1iJSxvm5Vb+soWGSxe/TdWMjVS95nA/IH
	Kk5JM8kVCl342gYoKW3aKPcmGeubefEv7GUx00S5vj5O/KlyNCSrAX7LZTpJLY6H0SezjGRk+St
	+25yNQrglOqIdMM85RWuu94NFgEf+KFx+xsE=
X-Google-Smtp-Source: AGHT+IF5CXklsVDvXe6vgWeVR2NFBBfKBUg2RT7kvwKZ6Qe4Syfm8nnQYr4AnphsGc3zSzkp7zeq+w==
X-Received: by 2002:a05:6a00:1382:b0:77f:383f:61f4 with SMTP id d2e1a72fcca58-780fce1fa18mr1117807b3a.12.1758742266232;
        Wed, 24 Sep 2025 12:31:06 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f2f02c15bsm10810811b3a.95.2025.09.24.12.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 12:31:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 24 Sep 2025 12:31:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Sung-Chi Li <lschyi@google.com>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Jonathan Corbet <corbet@lwn.net>, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, Sung-Chi Li <lschyi@chromium.org>
Subject: Re: [PATCH v6 2/3] hwmon: (cros_ec) add PWM control over fans
Message-ID: <41c71099-d9ad-4beb-bdc5-c8d15293d41c@roeck-us.net>
References: <20250911-cros_ec_fan-v6-0-a1446cc098af@google.com>
 <20250911-cros_ec_fan-v6-2-a1446cc098af@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250911-cros_ec_fan-v6-2-a1446cc098af@google.com>

On Thu, Sep 11, 2025 at 06:56:35AM +0000, Sung-Chi Li wrote:
> From: Sung-Chi Li <lschyi@chromium.org>
> 
> Newer EC firmware supports controlling fans through host commands, so
> adding corresponding implementations for controlling these fans in the
> driver for other kernel services and userspace to control them.
> 
> The driver will first probe the supported host command versions (get and
> set of fan PWM values, get and set of fan control mode) to see if the
> connected EC fulfills the requirements of controlling the fan, then
> exposes corresponding sysfs nodes for userspace to control the fan with
> corresponding read and write implementations.
> As EC will automatically change the fan mode to auto when the device is
> suspended, the power management hooks are added as well to keep the fan
> control mode and fan PWM value consistent during suspend and resume. As
> we need to access the hwmon device in the power management hook, update
> the driver by storing the hwmon device in the driver data as well.
> 
> Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
> Acked-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Applied.

Guenter

