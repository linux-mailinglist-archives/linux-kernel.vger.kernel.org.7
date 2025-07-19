Return-Path: <linux-kernel+bounces-737582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86013B0AE0B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 06:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2372D7A6967
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 04:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA890218E96;
	Sat, 19 Jul 2025 04:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bq9C0mB8"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4365A12E7E;
	Sat, 19 Jul 2025 04:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752900334; cv=none; b=dVYjI1cLT4+N+iRDxfbK1BjTH8GwGH1v4vmNgLdsjR/qhTILoLFSs7QOskXRZpjcoJCM2JBNf3GZDbW0u0UkvTDakwOWb1WTLjCDIoGlFa26KM78DIivg06gOitkyuAOHnNXpsy9SacVUM6oCrM4j96aCVGN2J0+4VzXYibZ6zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752900334; c=relaxed/simple;
	bh=91BZLZBnHol3G5D2pQNEOuhB92MjBsnbv9dL7ro7hKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsvNN/V5PYAmK5bhBbYyzI7XaVbeFudtzu6uI586SKDxojDES8gswDXbfo81zWvlgS7yzyyuUHw08XLke70H7p96aisVqWW7WSd/KCDe774cGSL5ujTrP006auGYYnZyIVmGt3Be3XmeK0SAmHI0tR7FHO+LlA5/DLdC7ySS4nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bq9C0mB8; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3122368d7cfso2079165a91.1;
        Fri, 18 Jul 2025 21:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752900331; x=1753505131; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VDSwmwyHdOHdY5y6kv9+AKkxnfvOoBedcBRoJCdOkHI=;
        b=bq9C0mB8PL1QjEQslZBxkrG2L4aQT1Vy62x3pjgyxrrm1VepVXHu//m5VfdeOYUEFx
         L1563chhMaRwIZqquACRWjPJkcr3QPS7Ky/c/+mLBgVq/Uqw3zUW6ArBLnFmCfFadzEN
         ttXT9fwtb1MQShqYjJ6OcBus2X37kZoZpwPFmG4w+8l5ZliBcgIFAzssa/KmLyzWs8Yx
         jwZ85m8WPkkZZZcE+sW0kDec9zEiCtlDcxG7YHjK6E3SVg9LOu+oR7euuUNAGVsEpIy7
         FeKRZL5WJdtQLSPIVNAoq7TaDBrxubzqUw9G6L8+0kdaJfl90Fmrnt5cbA73bn5JYgv1
         72FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752900331; x=1753505131;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VDSwmwyHdOHdY5y6kv9+AKkxnfvOoBedcBRoJCdOkHI=;
        b=nGWC9RBRYze6/Fy/b2Ktjd1iccbwL5Mz59FQjoSLmP/ezxSl60ufC4lz9lBIV+dr8y
         e0O/HuDkWQCHfH8klaNX3R9xsD57R8cAVcnGTjoKrn1F1un6z1ZvI52Iku61zziWf38v
         9UAxD6hLK24Qgknqg94cnKdfWDwplpnuhMIS5qNgx8fDEr6jyaoRf1HIeBuVr+uONfmK
         cdE7aJslPOSavlK0qJBIl/tRHeqdCt0skHXltTj8iHG6XtjpjKYSPq4/UD8Psyd/R3x0
         tg6rXam9j/RrGxVP703PTvS83lpxLZyjXuB4Iafn9bDq/JZwVNPLKdub0tc1lmXlk9Va
         HXLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUax9pVij8OCuLYc3qlmj2hHttvSAUdm2J8QmNw9L5qvtvaeyEIt/EcHMnDiFCSkQKSJ1i5M5dB7oEbzhbj@vger.kernel.org, AJvYcCVssjy2CwHoIu3oiq5LL0t2wV+glPHORcrqQARcYrdWTokxEbLlZg009qTDzDT+YBKnCT5sQPrb6JwvCyg=@vger.kernel.org, AJvYcCXp6rAt86rwUPpfHFup//5q6/KaamivMcbwSxQg9HzvtDKsENymewPFBSJpHEp8vgUqEc0ohbBFE28=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEP3KxwFBBjUfqIWwofp56QITgYujROvLKzj2HstjwK22MNyXA
	ELda+zu+qtwVOuozO+lLfv1HrWu0uTQ4zqTflIHT7ax5O8x1DyfCScoQYDI/zA==
X-Gm-Gg: ASbGnctkej8Rbq0UXB8USOkpnmkQJiXGDB53JEYT5Fu03U96o0gj0n+wm0Ewx9OfEjH
	pPf3mTgPPHRU+GZC+Bv8sYHM/DtvOLixZFja7jwuxs8PgHkVFk3/XMsliDZSKglqq5LTmg0yDGm
	0MR/ggWx0+60HUTlWpVz1oDfaVdGAVW0SziwiwXfCR83mj9En9JOAGAVvryukcoie9klELMDNTA
	bPYKrwTzhE7ZNcvWT0SwEzqbQCFF935+wjZ8V2Rj+nzUIuV4kcch1K8RUtmvlgbmclgtGnmMtOM
	A9Aq/A+oTHcgwA0uFUSVtM23Lxd22k3kXfIp7n9YQ6Z+/WeBQdvSeXYWhcnpttke3GxdyR2K9KV
	wbMUiVekJQH/sPhQyObupnwuWk0Uv8LVav0A=
X-Google-Smtp-Source: AGHT+IH80ZxQCk9Ldxy2HcCZ94uxkc5cXHP4oMobg8T6kOM+VRAaXBoHX6GyCi79GvkHwqNKchitfQ==
X-Received: by 2002:a17:90b:1810:b0:313:271a:af56 with SMTP id 98e67ed59e1d1-31cc2608a57mr6627758a91.30.1752900331477;
        Fri, 18 Jul 2025 21:45:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f1e61f3sm5956304a91.15.2025.07.18.21.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 21:45:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 18 Jul 2025 21:45:29 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Sung-Chi Li <lschyi@chromium.org>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@weissschuh.net>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	Sung-Chi Li <lschyi@google.com>
Subject: Re: [PATCH v6 1/2] hwmon: (cros_ec) add PWM control over fans
Message-ID: <8869b525-c32d-4a8c-8e1c-b2718896dd2a@roeck-us.net>
References: <20250718-cros_ec_fan-v6-0-8df018396b56@chromium.org>
 <20250718-cros_ec_fan-v6-1-8df018396b56@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250718-cros_ec_fan-v6-1-8df018396b56@chromium.org>

On Fri, Jul 18, 2025 at 03:08:29PM +0800, Sung-Chi Li wrote:
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
> +
...

> +static int cros_ec_hwmon_read_pwm_enable(struct cros_ec_device *cros_ec, u8 index,
> +					 u8 *control_method)
> +{
> +	struct ec_params_auto_fan_ctrl_v2 req = {

ec_params_auto_fan_ctrl_v2 isn't declared anywhere. Looks like some patch
is missing, and I don't immediately see it. Dropping the series.

Guenter

