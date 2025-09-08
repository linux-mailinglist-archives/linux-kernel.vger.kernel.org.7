Return-Path: <linux-kernel+bounces-806646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8E8B499D8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D82247ABBA2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B7127EC73;
	Mon,  8 Sep 2025 19:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPTZShuv"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A4227A906;
	Mon,  8 Sep 2025 19:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757359332; cv=none; b=dSgpvb3JyIx3CgI1zUxVgIFAhEMUOzBwUVIplaYn6vU+vpe97m3W3OTXGuAsDQL2ZSC6S0Xrm5z+e6xjwZiEtyQalo2TuQJld7SO3ImF/aD7a/9+OCTKJuAsnORN3WygB5LPI2bnqRq5kqWBKZKVYh6CMbQvFYQ6TIcCIXnHy84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757359332; c=relaxed/simple;
	bh=qcWJzGuPgJy6Wxkhs9bsk8CssRtmCR1MXSevYvnlw2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/1UQZTKNWX/ak5CAKBuFprcc1X1S8X5Nt7Y/nT2R0jWyl19NGS0Aicte9jEWD8cBYO3MEkkAf2ehb+QvHLj7HLrMvDA5T1wC5rCoROh55epsYWo5MIFCeBzAc6FOSk0D0zcdw7zyG+JfmUohlKmMBYvU51Ql6eliT6pHEQdI4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPTZShuv; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7722c8d2694so4037279b3a.3;
        Mon, 08 Sep 2025 12:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757359330; x=1757964130; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jcUeSd1Xhl5Z/Ntdd9zEza6ROBMbvPjB+KiGGcIc7F8=;
        b=aPTZShuvYnKFEoaIj3AxANwkN99lEeTTB+toR5S1KpBrPPtAnONE1Hyedtfdc2rye4
         RV0UlANX54u0hQdLhpVFxfRjJL+eh80Gyk+7IPtbu8QW4jMtj6e8ld0pbmnoFzZ4zcRC
         sTE28RMuX7ugO5KW1NA0SoZm7Q1aJtqlL1BsCdA4L2052UZGIIdiq7kZILlzSLyHlsU1
         dn+7a6eMfTEpvZYA0AHX8GQgM9slA8wJkHZXusscbKoLllnk2zefEXMJW8+E8ZuhTLSE
         vI+ROxzPlnICbuPeP00yQH7JNGHmN+nSD+phmdcWQ5c35llCIB1NNpu3HRXtVUbzlzkn
         2Jdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757359330; x=1757964130;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jcUeSd1Xhl5Z/Ntdd9zEza6ROBMbvPjB+KiGGcIc7F8=;
        b=aELDjv7E4lWNLdCJSJshAwD90Fx7oYUP+ol7777MpsMmx0f6G+2VlA9Av7po+YAmdg
         jRcLRkdxFtFlITlo7SZnkOzSsTWw7hfIpvPfv/mYxQbhkIRqdBONuYonIWE+E9e1mQNE
         3QPaI696fZA5Us9MBfBp8gWiIr68lrDwF9SpmgnsJ9eIZaFn6WQ/ipj9cGXcJDuoJNAt
         4wkJNlMOUu2LGX3zGSW42SQXxrqrNC+XEciCK8yDXtDI4Lv6Emh9S6JkDxQrDVjb27Sz
         udW10/rWgs7UFUQHV/4zS0X6x2Z0OezJnvtcH4fW1qsWQ2A8VjX8I1t1KS49fRWVmYTY
         Xxbw==
X-Forwarded-Encrypted: i=1; AJvYcCUwF10MbzJd0tVOimxr0gJCtD4fKhpRtuRdRUIWU+Wz6uK9DD7ypwE++gIIV0T2LpmmjHYZZuTO9T96ZYYg@vger.kernel.org, AJvYcCW6ros/gWAykAxrglKENbo1yKcaVP4+CnMbv6Ni86VBnumNxYbPgzumI8FPg/SvTsgX/bgPacz580I=@vger.kernel.org, AJvYcCWm2iaWYGj1f3g7xRvLDZt9pC2bQB8N1oCmwzdSxUUYzqKHAO2Ai0vU1mV2BoULNSM72uTMc97BUyEjteU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGnNjFQGGE+/BR+oQj4jCevJelcHTk0xAj6uR77blZ4En4MGMH
	gW4ncntpHqxLECOUsUfObNm1FUdFrZBcXB8dCFsFUdyakazExXvnkbCN
X-Gm-Gg: ASbGnctRmG+TM3N1R13Syqg0qgwcqQafWXIea/gjhGnPBfjUtIqZe4jRmvqPWOHDrFG
	zbXR85BKkiD0kNojr6Mo0U1qKZQmvAVoGzNcn1XsIQkhiNJiVh0o/5GOPxgBlG6b7EhWVCG2MfP
	OckYMOlTAT+uMhbOHn5ZQixocB3lT/HeYYFRQMi6T3RuGiTSk8xJJP7Nl3M8sJ09ib8iHfBPLLE
	n6lAXib6noR6NVAFt30psQkarmav4nFmMjv0dQfqOG/Ln47Lfd9NqbB06DWLgvJRyK7SYlbqHcT
	24WuNVQzScXOzIhagYPyzCGZWQUhGItcoInG/ht4UWrd2qC8yQjTvQk20WTW/OwYhK+ezmcqCB1
	jZPU8gG7l89A5bWNmHyyfrOG+6LIzIviJrsDWaKF/B1LeQQ==
X-Google-Smtp-Source: AGHT+IGgHHKUV/MUIRPJkCgyZX/wv8ggnpajfPF4r872o2h/zHhOsW0NvpcSvOMSPYi+7Z493KHuxw==
X-Received: by 2002:a05:6a00:178f:b0:770:54e6:6c36 with SMTP id d2e1a72fcca58-7742dd12490mr10906364b3a.7.1757359329658;
        Mon, 08 Sep 2025 12:22:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26a34fsm29706882b3a.6.2025.09.08.12.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 12:22:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 8 Sep 2025 12:22:08 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Cryolitia PukNgae <cryolitia@uniontech.com>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>,
	Yao Zi <ziyao@disroot.org>,
	Derek John Clark <derekjohn.clark@gmail.com>,
	Jun Zhan <zhanjun@uniontech.com>,
	Cheng Nie <niecheng1@uniontech.com>,
	Marcin =?utf-8?Q?Str=C4=85gowski?= <marcin@stragowski.com>,
	someone5678 <someone5678.dev@gmail.com>,
	Justin Weiss <justin@justinweiss.com>,
	Antheas Kapenekakis <lkml@antheas.dev>, command_block <mtf@ik.me>,
	derjohn <himself@derjohn.de>,
	Crashdummyy <crashdummy1337@proton.me>
Subject: Re: [PATCH v9 1/2] hwmon: add GPD devices sensor driver
Message-ID: <5cd4516f-0589-4701-8832-4f604ee79bd4@roeck-us.net>
References: <20250908-gpd_fan-v9-0-7b4506c03953@uniontech.com>
 <20250908-gpd_fan-v9-1-7b4506c03953@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250908-gpd_fan-v9-1-7b4506c03953@uniontech.com>

On Mon, Sep 08, 2025 at 10:25:44AM +0800, Cryolitia PukNgae wrote:
> From: Cryolitia PukNgae <cryolitia@uniontech.com>
> 
> Sensors driver for GPD Handhelds that expose fan reading and control via
> hwmon sysfs.
> 
> Shenzhen GPD Technology Co., Ltd. manufactures a series of handheld
> devices. This driver implements these functions through x86 port-mapped
> IO.
> 
> Tested-by: Marcin Strągowski <marcin@stragowski.com>
> Tested-by: someone5678 <someone5678.dev@gmail.com>
> Tested-by: Justin Weiss <justin@justinweiss.com>
> Tested-by: Antheas Kapenekakis <lkml@antheas.dev>
> Tested-by: command_block <mtf@ik.me>
> Tested-by: derjohn <himself@derjohn.de>
> Tested-by: Crashdummyy <crashdummy1337@proton.me>
> Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>

Applied.

Guenter

