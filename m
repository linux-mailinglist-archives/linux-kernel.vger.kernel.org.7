Return-Path: <linux-kernel+bounces-735524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B55B0907E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA75585F4D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46392F8C5C;
	Thu, 17 Jul 2025 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CorH8Smk"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22461237180;
	Thu, 17 Jul 2025 15:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752765879; cv=none; b=rgHfdjSTDyVo1xD7/yF23j9ct6h/pEcWh9CnAD/UDB1+unbsSu4mKhA4yGBklXBqGLPq79ZGWnNEw33Y9suiLpOJt7T8eWyg4n+pAsOSt/B+7qNPyL16MhE+aovH0C/ta2DOLNXcGVkOcKQ32JcWlrcf41gtBaFA5DNfUI+3Tkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752765879; c=relaxed/simple;
	bh=au2v0KQYjlZ54zTmA1NI4ITIh70Ziw88Rb6wV6rH0v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQ25WaUrwwDQ0F1REI4NWZ7Hov+ts9GAT3NoxSW85dPXA3/Gp+A/p8ERegFZ6l544QqLstPS8+35vdtKoUL6UPgDbt6vykRMZjAndReN7X+ZS9bhVoiVmLqiKGPXa3jt0LtRTf94LoQUyfnZW4qBE70aWE07Z+1LJ1CfKxaMMfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CorH8Smk; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-74b27c1481bso791408b3a.2;
        Thu, 17 Jul 2025 08:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752765876; x=1753370676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fVsvjOr1OU4TZPjRga2JGbWbncmoSahep9x2yaNsFiA=;
        b=CorH8SmkW2ZXmZqhwd75o89D36HmmgZQ3V/6yosq9lbtQQLmutGW7UQnCbOSzBtYyR
         HNrlZ/4DPlnP0MLmvtY4+SeaNhaBiiG6wvpD6lMBoxKg/pkd4DQaqN81+FPpw5uO9jYd
         jRaKlxDRE/7uOcy8JTLLm3VQwogj8wEiWzpLZ+7heY3KFfkhT+SbEn8WcXLnFtNqXa+u
         rhGCkWTulhCyOShERv8M8nU0PaGWtY2kQXQ7LrXsl0FnLD+pNaKfxcEsRW+4EBn+YQIb
         ZbSV2t8ErG2rAl/9TgHeCyCKosx236vnbIhd1pxKE2TqDQdYNeyiC5PY7tunhgZMn5z0
         4hPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752765876; x=1753370676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fVsvjOr1OU4TZPjRga2JGbWbncmoSahep9x2yaNsFiA=;
        b=JmvSPp/SHljSgJwLXZ7M2VbPMkYHX1vPadonyFqeb8EDN/f0uUlVkTrYFYCm10qHSu
         vGef/tO+Bux0iPKbdcvRDFLgMxq+SuVfDA5HzPDHgX+DyzyYyVgJvoHhScSc67Vj1olj
         OJV95/fV8dEE8sghvvkJfaF/x2otjg1bE89AKXe1nsL1C7B3Q9r9pLDEP38QwvLxCZZa
         gxfyueZT53vMn4VB7e962z3ewr63+3DVnW6qFNDZZ9WFY1LaK1GK9o3iYquxgaAcWjBG
         26NGtZpZuIlhxhx/DWVtusjtSe6kJRXMg9nBN7m03G6yoIAA98yPz2aXYSGVuwTZV+MC
         h7qA==
X-Forwarded-Encrypted: i=1; AJvYcCUA8PAc/n8HrLDJ+rUryxD9zzYfLrPRs7aqQgWIXQj1hmOjJ7hPowgoXZicN7xFjX4nVu11yJmukv92hLNd@vger.kernel.org, AJvYcCUlmHSHFSHsAOE/vI4urOS5IzXhX4ACE6s0SuqT00SkEkT2bVu6MDgy7c4pizXaueLaSHiKqL6yhcKQ@vger.kernel.org, AJvYcCX6mqT2ZR0btyLzvK3aEN6N33vLfrdYOQulT4I3Aj6Xxzjb3yh62BHEJWhPamannfwkkQAVeVM3Jx4tlrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW2JlVStLENRxdnT1zNI/oFCDZvPqdLlFsnjaVle5PDUL2LdY+
	gHC7ZCzjF9FoA8U6uZrSIcTmeCmxf2Y1t9PTC6J0i1UozYyKx67hGSYl
X-Gm-Gg: ASbGnctmcO6z77dPxNDspa2lF7XZlxhaRoTS2G6SKhum+PZzNxWhLLfOvlm9uGIm1U0
	g1Wr3TALhh1+bHJYuMwbKU1KWwZx33kHDsP2VB7BhaVAKP+8ZEJUZe+C6Uenq6rc3u90zD77kpp
	7ETC/fnQ5kJzPEFXROynP7EGoCy5MjSGvG/ukALOQ4L0UoukB3otD3VkV8M+u1q5JMHDopDo9DS
	r2xvlTnSh4DiR/fW6Zwgq3D1IgBbk/0HXfivMhcJvQrkMXXMsW6pUKTcoT5VDcKQUFdx+Jcdo/e
	Ur/yDG3qdCPbPte1xzMikZSCIpTb2qbISA//2IWFPr/S+mDmIv+Zyyr2gNwHkDR+7spBITI60k3
	e3cm+0XaktI+a+elk1zfhTxAlcsaWOvjkOcgyB3zawV/bKA==
X-Google-Smtp-Source: AGHT+IFV52z6T3hUTzwzRDFZMDV6BA5c97cR2z7Mqk9ErfUXhPPQfI0WfQBWHeADcagAkM1RnIQ05g==
X-Received: by 2002:a05:6a00:181e:b0:740:b394:3ebd with SMTP id d2e1a72fcca58-756e819fa98mr11154983b3a.7.1752765876141;
        Thu, 17 Jul 2025 08:24:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e07649sm16194196b3a.71.2025.07.17.08.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 08:24:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 17 Jul 2025 08:24:34 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
	devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 2/4] hwmon: ina238: Add label support for voltage inputs
Message-ID: <c7294130-5836-46c6-8d8b-e5d5a45f3d33@roeck-us.net>
References: <20250715-ina228-v1-0-3302fae4434b@pengutronix.de>
 <20250715-ina228-v1-2-3302fae4434b@pengutronix.de>
 <eaa183cc-a56f-4a33-bf01-a5279799f395@roeck-us.net>
 <0915032e-617f-4d46-8dc7-6818af751a0e@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0915032e-617f-4d46-8dc7-6818af751a0e@pengutronix.de>

On Thu, Jul 17, 2025 at 09:30:33AM +0200, Jonas Rebmann wrote:
> Hi Guenter,
> 
> Thanks for the review!
> 
> On 16/07/2025 17.04, Guenter Roeck wrote:
> > On 7/15/25 13:49, Jonas Rebmann wrote:
> > > The INA family of power monitors estimate power consumption based on
> > > two voltage measurements: across a shunt resistor and across the bus.
> > > 
> > > Conveniently label them "Shunt Voltage" and "Bus Voltage".
> > > 
> > 
> > Labels are supposed to show the sensor's association with the system, not
> > the chip labeling. So this is a no-go. And, yes, apparently I have been too
> > complacent with people (mis-)using the label attributes. That doesn't make
> > it better, so don't use it as argument to support this one.
> 
> As this chip measures power based on two voltage measurements, the
> measured voltage inputs must always be associated with the system in
> that way, that in1 measures the voltage on a bus and in0 over a shunt
> resistor on that bus.
> 
> Otherwise the Power/Energy/Charge-Measurements will be incorrect.
> 
> Do you have a suggestion on how to use the labels correctly or should I
> just drop the patch for v2?
> 
Please drop it.

Guenter

> Regards,
> Jonas
> 
> 
> -- 
> Pengutronix e.K.                          | Jonas Rebmann               |
> Steuerwalder Str. 21                      | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                 | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686          | Fax:   +49-5121-206917-9    |
> 

