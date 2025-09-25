Return-Path: <linux-kernel+bounces-833194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81673BA1624
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D64B87B922A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C633112C4;
	Thu, 25 Sep 2025 20:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0AP5ItH"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AA12F6560
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 20:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758832659; cv=none; b=urmjky8eJH5zUx4y9NZ5WVHE/xlw1nEAz+jzUUX9LgdfcJYD6ztDpWs2LQEcOuqYJAWOpDBS9k6m7MOunPNrA/EksHKNWa5iccw9vi58zKYtVTdiHixcWE/yW4JgxgTMAq+VP/b4Dhja3GWNPNgDNL8+SnjALRQP99PzHIHZVE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758832659; c=relaxed/simple;
	bh=CXaPqJgmPfMMppa1RfUc94L4Ntew1IQa6R3v7sr+oVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4x95dLBMTMulSq9mjLTe9Lx15VdMwONoY9kOiK1yzErX8xxKwK/oRk8OTzP0dt+qVxDTGpc/7ruzuLcRHTvS5ozEJsQmXQcJNG7NOd7/2TNFJoWbGr6j4bicI64nz6BPFfGP6kd7szsQh5JQ5OilkbNS7otjJquudk7vHKJxDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0AP5ItH; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-279e2554b5fso12502735ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758832656; x=1759437456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eNKk1kU6SOtjUkITv/KCJkuTdw/0nVnpYUbhmN061yY=;
        b=l0AP5ItH2dspA9W0OZZe7i11ks3E+c3kPfL+K1o11XjW5Aa5YKLS+FcMLI+Tvbbe2x
         SgmNWwVQuSjuEhpra7FwVrOn+sXYe6HQxJYwchUokwTgGgsPwZBYTjCcXA9MzESQdGVO
         Ff6ZLfhQyCV93nqdUO2vLZAc+jIrQ/Tb7kFhwYlfgkozkQFpQT0/cq5Uvk4Bu0kon0f+
         FscoY3eT7vqB6zSzSvorgdbGu7AlP9kBpBczmTzT3zQztUNNP4721p2uTNm5IRVfDJxl
         pksOwMh1cCRdUi70Q/xE6ZRbA54xN7po0TddZ/mzuf5vf+GiOOWB4cuHWNai/Rn1zh3L
         dBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758832656; x=1759437456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eNKk1kU6SOtjUkITv/KCJkuTdw/0nVnpYUbhmN061yY=;
        b=Q/UmqGHu0mGcxzcFuVT7sg8FHzMtaQigAGma8DKRbTidjoBIXwZl6BSUB6d0YQTohO
         qcpKIbvc4Ige+htsB9edc6stC6BvrJm45VgzcOXTm1dyfD9p9v63OcSLRDNoAAWBGtX6
         SLRjGuiMmqt+puUpgopIcsjP2AHgginFfkqPASrNZR6IvfV/Ge4YabmphBaV3ipco4cd
         OlGtWRTcR+uUCwjt6fJxRdfM1ArBJ0smriSgfQm8C9COPou5Los39vLLenafRpthpwqL
         VEYeu4zfw5E1quFqgmcryDF98W2q+GvFsZrCJ/q6ywrvATWPSM3+oXKgJzu7EWMx20XX
         sGGA==
X-Forwarded-Encrypted: i=1; AJvYcCUocFZwNM/0a1B6MuoARdUNUZJTNkxX8LK984z2SI7lvhqxDjp9lIMGHsA1QQv1Ha33DfHZnX08D9sVZB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsKlnPyx5NBI6nfTCw9aYxT+9IpWqqfmM8LpT6fkyTp7XEo9yp
	HNhxgUE0Apsmj01NykEbq3YVMVEqexByk2cD1HhzmpTcJDdXfsFjyyOI
X-Gm-Gg: ASbGncusNvsFOr7R4aU2K6sb63YB7g22U/DMWu/LNo8ZjJMWWxprK3s7FkjQhgKjiq9
	mKHm+//MgzCMNylErTfjGUG2exSEsKPUJmEvFhO8RSylmI7eLjJMxis9tFBhjOz3iyj30/fer9r
	2xQvLEfSitj9l5uiSDDhU47QxfSse8qL0+a4hr9xgCrIr2ahNCFQBQruU407AvJdW3RgvMsR/5r
	zkGq64bMl8uKBMp2dEu5Z7P1MLIkLc4CyUdPrG3NP8uKC+AwkL0/Gr6cK99bkuvemjStSFkP/AR
	ykK9n06qXSRrGDNvIEEq8LOT7x4Uegb+JnQjO6p82bLfk9izi2ymQquoVa8qVUdz+ztiV6igtYV
	kw2Ys2pjvwKIPSvDS5xWil0/t+yeMt55z9UgjSWlwJ9ekkA==
X-Google-Smtp-Source: AGHT+IGdaPC8LUhy5y9eJbG77kWOllABnqIUJud8kZmzafxvaX4bFrJ9tXNvo9qzIrnH2+Si1arwcw==
X-Received: by 2002:a17:903:1b6e:b0:267:99be:628e with SMTP id d9443c01a7336-27ed6abad48mr50663105ad.2.1758832656340;
        Thu, 25 Sep 2025 13:37:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cda43sm34135455ad.25.2025.09.25.13.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 13:37:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 25 Sep 2025 13:37:35 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Conor Dooley <conor@kernel.org>
Cc: Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
	Rob Herring <robh@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Stefan Wahren <wahrenst@gmx.net>,
	Saenz Julienne <nsaenz@kernel.org>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH 1/4] dt-bindings: Add Raspberry Pi's RP1 ADC
Message-ID: <89dd04b9-e261-4bdd-83ab-499e46fc9c01@roeck-us.net>
References: <20250925000416.2408457-1-svarbanov@suse.de>
 <20250925000416.2408457-2-svarbanov@suse.de>
 <20250925-outlying-causal-015d8ba33c53@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925-outlying-causal-015d8ba33c53@spud>

On Thu, Sep 25, 2025 at 08:40:54PM +0100, Conor Dooley wrote:
> On Thu, Sep 25, 2025 at 03:04:13AM +0300, Stanimir Varbanov wrote:
> > Document dt-bindings for Raspberry Pi's RP1 ADC.
> > 
> > Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> > ---
> >  .../bindings/hwmon/raspberrypi,rp1-adc.yaml   | 46 +++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/hwmon/raspberrypi,rp1-adc.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/hwmon/raspberrypi,rp1-adc.yaml b/Documentation/devicetree/bindings/hwmon/raspberrypi,rp1-adc.yaml
> > new file mode 100644
> > index 000000000000..5266b253fd2b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hwmon/raspberrypi,rp1-adc.yaml
> > @@ -0,0 +1,46 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/hwmon/raspberrypi,rp1-adc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Rasberry Pi RP1 ADC device
> > +
> > +maintainers:
> > +  - Stanimir Varbanov <svarbanov@suse.de>
> > +
> > +description: |
> > +  The RP1 ADC is a five input successive-approximation ADC with 12-bit
> > +  resolution (ENOB 9.5-bit) at 500kSPS. It has four external inputs
> > +  and one internal temperature sensor.
> > +
> > +properties:
> > +  compatible:
> > +    const: raspberrypi,rp1-adc
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  vref-supply:
> > +    description:
> > +      Reference voltage regulator 3.3V.
> 
> Looks like you're missing the io-channels-cells property that allows
> this device to be a provider of adc channels to other devices.
> 
Only makes sense if the driver is implemented as iio driver.
Which would be fine with me, assuming this is a generic ADC.
The iio -> hwmon bridge can then be used to instantiate a
hwmon device if needed.

Guenter

