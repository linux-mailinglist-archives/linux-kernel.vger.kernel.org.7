Return-Path: <linux-kernel+bounces-766039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1350B24181
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0A357BB164
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 06:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15832D6408;
	Wed, 13 Aug 2025 06:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HEM1V3A4"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB93F2D5C86
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755066508; cv=none; b=MB3Iodk9WFY8V7kXISd7jYUrd04DAPgm2qQGUarRfspPnoLKVXBop+PU+0MJtvK1t3SBxxXw4H+IH0D0f//J7VPZYaOXQ8RHh65/uxsiHWTNN4uCEPq7ivvvIHV82EJ28yOcDzKOzUn9iZTs5ysCfRn9UVrNPbw6q2pcrvBOIUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755066508; c=relaxed/simple;
	bh=ruSc1og0k+neVyIZpEtyljRVj11cTbE4xBOWaKErHVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgJgrwWi17qUENUADy03GDkdjgKOuKrMo5vZIVLLUqWGC97tXWFzHzjha568Exj3bziZYdlV8in1mxhMYYPHBQL/yFGZm9t5HXIvd8vJoxwasNH7gX0lgYe/Vc5abjThX1YxBUNf7sUwd5ysmCd3/pU1Wh9zZgI3WWhkRGsnwrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HEM1V3A4; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2407235722bso62159875ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 23:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755066506; x=1755671306; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hkkOFNG1twvUB4ikm7yQwDp0IAPOj20d67SV/lZx5C0=;
        b=HEM1V3A49qCvcgXmqP7snlpX991MXWf0ktgiOKCnWTQS9nRNAIktxj7fkMYpuTOUpy
         YRrclnlkwmsW3iYNayjPClLV0ngxtrbZduRvnAnvCvG5F27sBBETWIh0U8sqFDLgHoe0
         e40w9dKUlznzBVLVITeBlXZpPRQ26Z3CnkIP1o6dAXbpkIpFJiMmtFhP4vq58dtyo6mc
         xSfrsgb4ICFaLJC8ANCjOB3uZP9NNKePIB0hDPfBn7Bsd0W/4NOavcUenugulaFPofC+
         IkawKXCrQ4XmXL+a1JcGntlygJ/qZfkCD2773P3Fc9PO1CHGpTV+apqNLccSaKtkL4Sx
         W/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755066506; x=1755671306;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hkkOFNG1twvUB4ikm7yQwDp0IAPOj20d67SV/lZx5C0=;
        b=ehrZP6dzX/3yyKsrlET9JT+7I78Ak/P5hYYMyH0b9rRcsf9PxIMvXYqbNGYUFUKEFb
         Q8NW5yQRKeXN3rcAu6uMteuzwVUOlIsqT+LSt+KsCOcyV5botMu8muC48Lb+Osbi7OzU
         XqWWFDdowOjkvaIVei8g45GMHR1qOEElgkx7Y7txqSKjjs2EVOlGlnccDZmDJuAgeGYk
         PaIkAVrDRST/N74Eow6Y8+ennnCXqAGuPRPFyBwsbRbTiZ9yPOy89RPToP/34ZUoz7NV
         bY865MRDG4XMxbFY+GzXnXEsVKN0FfiRSVYuO2Lpg/qTdQmHoPeK4PhYYYrhZ2O0mWtn
         sMwQ==
X-Gm-Message-State: AOJu0YywNtFoabTIGbtLo0Q0b50vEO9lDIfTwiFifOf5q5T1poXyoNOE
	8uDMg42LoXyvHO73FwQ+tvf6MrvVg+SFOJiH9B7or3SrPfJ+QlFUYSHrQvMtbDlA3/g=
X-Gm-Gg: ASbGnctrxgDD+2eH8G3C5cyGwrP0Ra1DecA3/CMSq3YUOId6MTUD+20hZwGA5krQ+Bz
	2hpU67paewiIIBehh34rwc/hwIK8jRvKE7ZUnPxxDs/dAapV8Y6+3Z44dGjfE2rNh0NHWOtEdfk
	kdiJCG4ZxDeMFnkfPL9GSjshNPXDQWIBBrsUv6KIWGL08PAeSsZoqu/u3WKwo/ir3jA/I+JKoBW
	KDch7PpWQQbQvTyxaugV9a4eG6uffm1KPbMIx4bZypfkcvV07wUg+/kQCsggDyCq+WbtEkElINw
	HBEbP85ZTg9p4ALFJWfnB7gfJ2ZEMAf8zjsuihxm6shTZ84pSzj2ZtPC2Qart5nlXVOl6Vana3+
	nPm+vSbH4fzjBWDP+/ywJqKR9
X-Google-Smtp-Source: AGHT+IFYTVLKZy1oWyOc6hnM/pMXzM/G8sghp8UldVXVga+3t7fJRL5dFPBL8RVz5xsAnY8qYxh7aA==
X-Received: by 2002:a17:903:18e:b0:23c:7c59:c74e with SMTP id d9443c01a7336-2430cf2d4bdmr32205525ad.0.1755066506029;
        Tue, 12 Aug 2025 23:28:26 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-243017dd480sm32575855ad.33.2025.08.12.23.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 23:28:25 -0700 (PDT)
Date: Wed, 13 Aug 2025 11:58:22 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Saravana Kannan <saravanak@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Bill Mills <bill.mills@linaro.org>, devicetree@vger.kernel.org,
	virtualization@lists.linux.dev, Sudeep Holla <sudeep.holla@arm.com>,
	Bertrand Marquis <bertrand.marquis@arm.com>,
	"Edgar E . Iglesias" <edgar.iglesias@amd.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [RFC PATCH 0/6] virtio: Add support for Virtio message transport
Message-ID: <20250813062822.3rsgdx5fmefzslc2@vireshk-i7>
References: <cover.1753865268.git.viresh.kumar@linaro.org>
 <CAL_JsqJn2XtvWaDBSqYPUe2ZVxE7t4EbAt8OPncbQaKjh1jY5w@mail.gmail.com>
 <20250812094955.fdyil4cbxr3bx4bo@vireshk-i7>
 <CAL_JsqKHGFPF-2d-cH4KhxFQ-KA1WO+TuDn722vYbs4Jyx8iYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKHGFPF-2d-cH4KhxFQ-KA1WO+TuDn722vYbs4Jyx8iYw@mail.gmail.com>

On 12-08-25, 08:28, Rob Herring wrote:
> On Tue, Aug 12, 2025 at 4:50 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > I tried something like this now:
> >
> >       reserved-memory {
> >         #address-cells = <2>;
> >         #size-cells   = <2>;
> >         ranges;
> >
> >         rmem@100000000 {
> >           compatible = "restricted-dma-pool", "virtio-msg,loopback";
> 
> The order is wrong here. The 2nd one seems more specific to me.

Right.

> But is "restricted-dma-pool" useful?

I need this to call kernel/dma/swiotlb.c: rmem_swiotlb_setup(), which
makes all the memory allocation for the device happen from that area.

> Should an OS that only understands that and not
> "virtio-msg,loopback" use it?

Since the reserved memory isn't linked to a device in the DT (via the
"memory-region" property), I don't expect an OS to use it without
virtio-msg.

> The format of compatibles is <vendor>,<device/block/interface> and
> "virtio-msg" is not a vendor.

"virtio,msg" is fine then I guess ? Just like "virtio,mmio".

> >           reg = <0x00000001 0x00000000  0x0 0x00400000>; /* 4 MiB */
> >         };
> >       };
> >
> > and this works fine. I am adding two compatibles for virtio-msg:
> > "virtio-msg,loopback" and "virtio-msg,ffa". Yes I will properly
> > document them in the next version.
> 
> Why do you need 2 compatibles? Can't you discover what the remote end
> is with some message? We only define "virtio-mmio" in DT for example,
> not that the device is a console, rng, etc.

In case of virtio-mmio, the reg-range is trapped by the other side and
meaningful MMIO messages are exchanged. And so the OS knows the kind
of device the DT node is related to.

In this case however, this memory is going to be used for virtqueues
and buffers and I don't see a way of communicating the device type
here. Maybe I can get rid of two compatibles and add a property that
links to a device type ? The memory is otherwise exactly same in both
the cases, it is just about which device is using it eventually.

-- 
viresh

