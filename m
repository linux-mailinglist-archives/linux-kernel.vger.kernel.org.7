Return-Path: <linux-kernel+bounces-737238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B50B0A99E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 19:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEA19A47547
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079F12E7BC5;
	Fri, 18 Jul 2025 17:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkvZYW3r"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8996C2E7BDF;
	Fri, 18 Jul 2025 17:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752860261; cv=none; b=TlxdxxYvlk+sU+UUGVF8fKn8xXBVhLlLg0DxbyVUnjFDKiLCdJ/7SqoXlWleR5TvcA3RPWg+fYnNpr/KEKYQu+vbZPHOk2xXZPAGBBkrnDuM1dchMboHYQRTGy4zFnDWloHJj8PhUiZ3obrILCmTY2nqTzFx07aIK66VlwTSUWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752860261; c=relaxed/simple;
	bh=IleGqfkJkac9ehTcogGyzSzaiN9An+RKyaQHJZK1S2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwCmOF8bPTrjsn74N0x30e7yRtjcz1x3FA6plQHaqrz61z2n78AkERJmloF1rfSYQHmfSLWry99h3h/u+6nPAn+uHYkXxsF+SOs0e0QCO7v07RaMNvhG0Cuj9rypOKKLovRBLf2vo0LxG/1yIQMfaf/GVkb+C8KRqhFnUnZxL2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkvZYW3r; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-235a3dd4f0dso15048655ad.0;
        Fri, 18 Jul 2025 10:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752860258; x=1753465058; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=34BI7Tti7vnbJ5UQzHNX3MpcNOQlW2ff85WQKd4ASjo=;
        b=IkvZYW3rvBxSWJSSeC4IW1C+R4+ZVrnK7BtUQ5GPNyxAlMyVUfMf2/h+zms+al9NyT
         BFTFybx2t4nAUCA/gDYrpojdn62s/4EDzlntDr+g8171JxB5hCXUHv+L2LjFPL94hOnj
         vGr8p3yW6bObrEJ4JyD41Waiq8KaqUpiNWv7fHzmtzX4a9Es/VnHlEGBJpMZ1VskqDqF
         +Pc9HgV9LF4WFq0xG+Us1ifMy5d7/tK2fuu887UEE2diIGU3VrC+FVRyCGNmJJs3EyFM
         xfCtHARUrZZAQEfyRkb91frdVUXC/0EOBeizEKLqgvY9vRy+lK74OEX/N0WBZc1Zkm/S
         9LHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752860258; x=1753465058;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=34BI7Tti7vnbJ5UQzHNX3MpcNOQlW2ff85WQKd4ASjo=;
        b=qDgkK0QWNna2Vo3QrbIHpT/c3cUAyP0T3Ua9DHui/9CGdrFfi7C2rxjsX6S4HFhZq1
         OvMjxBwxcmB3SlrmKtvRBaWXafOYBiPOp8tJxugzPFZd6owzh9CU+aDOldhTUtZ0yHk9
         sXz7teNbOJ9nIFBolo7SFtY4JHsc8C8mxme34MPg4GdnD4pBC7biMV6+ZPQrJpBv9jX4
         iH6Rp8U9ssLjY4id8KzJDWwrK4MDnO2h+L1Kmw5mfFb/Tw8YwzNVFR3o/cPwSgUj7Tcx
         CTldkEfrmvGrRA38H3nfPgoaOCQgMrTGwBhdaEt7Ggsts7nJoyxzIJi5MSqDriIVuR2Y
         JHfA==
X-Forwarded-Encrypted: i=1; AJvYcCV9hGCVilp9obICjvnhjLIBmoo7NbFFpr8LKSWpgcmCXjsvRSP1xJliUbJeYl/GUm1hAg5ygZHW09KZhYhG@vger.kernel.org, AJvYcCWNNOkaQAhA8uVj1Iq6W5cj24w13WnCPK2mq/A0cuIIKo5OSb+sc31uCWDZYld/UCxXURyjxyiuMoU=@vger.kernel.org, AJvYcCWtmAtfQF64CGRMCeJXKdMqAZG1fC6Xcmj7uR1md6LdRgQrCpb0Z/Ab1ROaKVm4796kbHXdwN0yWxriBtM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcn7a90TVeFDxy8I4xtz+cSCdijYhcwFyyHGNRiEV2uXebNC+J
	BFFu+i6J4NW05lDMNzGQyNpw6y/+WVU28ls/k7lkYhyzziKdfg+X+YkNlpq7qA==
X-Gm-Gg: ASbGnct3sxNk/BMwLbMjaf2hc0qa2qjDnniExEyzM1A0hTKwtpS0wx5qKYCty+DU5dn
	zwB4/b0wv7L786oEnd5CG64W59+EJw/Nuw57o6UXz6N6pUSweNcVOna9UhuSvLK45lTPOj+C+zF
	ZnsKz6NHGiuaJtDK0n0WnDg6dS69yOAPBgO55VktSzQm0IQv8CCEZIn6PLJ3h6jJob1gl/c1n9r
	0MBFp7sKkGyAYHPJkGifwFcGI/hAmA3aZeXjnQ8Tr/ZYu4B1tBnYDuFqae67TVDMUzsqC55UCpQ
	mLstGB0b0CyNP2ltN518mn9jAFHxiYrGNYbrWTnQbzh8uWTvwGzgdxqdBB53isQJHB6MVtwZa1i
	sJZnrZ8P3s8DHkVdh83wPYYvKJ0fIVHUEvLY=
X-Google-Smtp-Source: AGHT+IHVxMAAz4AU6bAb5gLGmWo4lVKYAEmo5o6hXKACzpOC5VB+9J1tjUCvYwOHqFDytRvz7OmIaA==
X-Received: by 2002:a17:903:990:b0:234:ba37:87b0 with SMTP id d9443c01a7336-23e24edc246mr139779395ad.13.1752860257697;
        Fri, 18 Jul 2025 10:37:37 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6ef976sm16066225ad.202.2025.07.18.10.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 10:37:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 18 Jul 2025 10:37:35 -0700
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
Message-ID: <b985d231-8d66-4541-bcfc-27e0d9c8cbe7@roeck-us.net>
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

Applied.

Thanks,
Guenter

