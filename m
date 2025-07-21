Return-Path: <linux-kernel+bounces-738542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4837B0B9D4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 03:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 327673B6C2D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 01:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904EF1990D8;
	Mon, 21 Jul 2025 01:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UDIkX8q8"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3A9153BF0
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 01:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753062263; cv=none; b=mZItS4nSEhrLqtcW0QRLTbeb5nQBSK6CyKunHEPPf7AFnM1si/xR93vuy0LCpsx9BE++rrHr0iR9RX+1XnokcfPfr6Ub0G+CHYBgdFvmYusspdo/Q4+3YIAm1ZNG8BFj3iaAsOLKNcQ13or2tkay0IogzeV5ICZoh4GB5plDdLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753062263; c=relaxed/simple;
	bh=L0Z9t9Wh/A4zDDhS1MGR1fwaP7pno+4uy6OTqGnwfSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOy8J39Z/55EI+Z97vxGOaJHYUILRNf/bzgjw/zoJVPqQK2q9xoieUDOxTYRhlkS7jU/+vfcNQQ/kglI8IQHXx/A88dzfpJWpMTX3vgb/6duTnzu4jw7xpgZ1ENLEsvfRR98e+kWea2599Jx9UyGuUdk8W3Xq2qrRPLeuGrOcHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UDIkX8q8; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23602481460so36183075ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 18:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753062260; x=1753667060; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tHBrdYq45/4WdF0whEY2tHmY6Z0msFU6dYk6tOWf77k=;
        b=UDIkX8q8yOmYyKQIfapdj1Uh8+eJP7VxIQPGXoiEYXpw/cBI3JlLBCpx2vw6+LVsWO
         mRpjFqcH5lmVguVxWJicDpg/TWo03L0F4bwyU0S3Mr0xAcwDHtBq4e6gsDuRLNbzmXlE
         I9tpYXyGnh+qmmquACC8Lyfl3X4M07VXg72Zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753062260; x=1753667060;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tHBrdYq45/4WdF0whEY2tHmY6Z0msFU6dYk6tOWf77k=;
        b=ZV7MnZrdz+B4B+brI+V7SdPc76kpnWOBiyLDwFHgup2fBE22f7g89qeFnGNnboMR+R
         jp6cIhOKOXRMmNV6QTt69YixfoPKNVskEkZ9wyRVDPUxPVye3vMoac3xihlaKRRZW0zD
         zyFuNSL1fyHDIJryRZPdugCtunn8/jVGIcfrgo8WVnOqYxyk4nydbtaeUsI5xqKO8oSM
         hke+VNJ2PIU4p0ocJ4kcWumpCn/Vv3EhADBsCGNj6Fr/OLMoYax06NTrIAOLhKEWrdc0
         NsUgqajidpw5XRj12YYTzvKz5S/bhxYXPQQoMgWqu5Y6JsvQTnZOIWy2+Hwa3TlSd56X
         bMIA==
X-Forwarded-Encrypted: i=1; AJvYcCXfZXBx9inLpD5/B3GgnO3lJjZcGbvHKFfrYz/dGEEXxTkBRKknBlK3yA2/CmSTds7Wgjv4ok9CvTdNwl0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy81cABya8ZSyeU31taOkiLXBtcIRm3n2TBQMf/zDq9I4IpzGrN
	fiKr8F0NH0DQ36r3RRlOrehFrgRlWw1kpVZT58K0WSxhRR0NbNJn6mTs6Ci2+pXLWw==
X-Gm-Gg: ASbGncuNyr0kXN/5RXmxSTF6pbH2RT1VUOmx0AZsmWBjBJjCEIwhZhDXuxPniouV7IA
	CeC4kg6HCEff3DPwXjOh8HSEtlMy2Vk3owMC34Cm+ggBxQNLDP010Y8uogasB5DeYibg9sS6PEJ
	7IYZxyn0QGy4DFl9isdNXkJH4rQpnElbwqtnwMwhh7TlZorKX+eMkiRGRbBGnz1m1t+na1TPtmM
	TmuGZ9IWBu8BOfRFiFU6gQMAL49JYdo+JbsIJ6nUTBx4hTCAk5XXA5+s+EzZaEH44g4ymCDKrjU
	UPH6swSVNjtIaKJGF3vCWK/o6SwuAkMnAhKa9kv5MVYDiBCiEZrRoSVe6QFtUz6m2I3uK/qR4HZ
	L+slIo6EUHSlwx6Do
X-Google-Smtp-Source: AGHT+IHHK3JkTcCKaUDYK0J7ie9NU72X6OylFLHnhOs1ylG4T57NGJcGpo7Az0XrymfkUHKXHfTIYA==
X-Received: by 2002:a17:903:2f06:b0:234:914b:3841 with SMTP id d9443c01a7336-23e24fe9429mr272868615ad.39.1753062260496;
        Sun, 20 Jul 2025 18:44:20 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:43c7:b6cd:7386:78ec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b48e5sm47188745ad.101.2025.07.20.18.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 18:44:20 -0700 (PDT)
Date: Mon, 21 Jul 2025 09:44:15 +0800
From: Sung-Chi Li <lschyi@chromium.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@weissschuh.net>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 1/2] hwmon: (cros_ec) add PWM control over fans
Message-ID: <aH2bbzDbpf3RMcMp@google.com>
References: <20250718-cros_ec_fan-v6-0-8df018396b56@chromium.org>
 <20250718-cros_ec_fan-v6-1-8df018396b56@chromium.org>
 <8869b525-c32d-4a8c-8e1c-b2718896dd2a@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8869b525-c32d-4a8c-8e1c-b2718896dd2a@roeck-us.net>

On Fri, Jul 18, 2025 at 09:45:29PM -0700, Guenter Roeck wrote:
> On Fri, Jul 18, 2025 at 03:08:29PM +0800, Sung-Chi Li wrote:
> > From: Sung-Chi Li <lschyi@chromium.org>
> > 
> > Newer EC firmware supports controlling fans through host commands, so
> > adding corresponding implementations for controlling these fans in the
> > driver for other kernel services and userspace to control them.
> > 
> > The driver will first probe the supported host command versions (get and
> > set of fan PWM values, get and set of fan control mode) to see if the
> > connected EC fulfills the requirements of controlling the fan, then
> > exposes corresponding sysfs nodes for userspace to control the fan with
> > corresponding read and write implementations.
> > As EC will automatically change the fan mode to auto when the device is
> > suspended, the power management hooks are added as well to keep the fan
> > control mode and fan PWM value consistent during suspend and resume. As
> > we need to access the hwmon device in the power management hook, update
> > the driver by storing the hwmon device in the driver data as well.
> > 
> > Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
> > Acked-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> > +
> ...
> 
> > +static int cros_ec_hwmon_read_pwm_enable(struct cros_ec_device *cros_ec, u8 index,
> > +					 u8 *control_method)
> > +{
> > +	struct ec_params_auto_fan_ctrl_v2 req = {
> 
> ec_params_auto_fan_ctrl_v2 isn't declared anywhere. Looks like some patch
> is missing, and I don't immediately see it. Dropping the series.
> 
> Guenter

Hi, these structs are defined in the patchset v5
(https://lore.kernel.org/lkml/20250620-cros_ec_fan-v5-1-5979ea1abb31@chromium.org/).

I removed it from v6 because it was applied before. Can you help pick that
patch? Thank you.

