Return-Path: <linux-kernel+bounces-816419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A7DB573A5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA61417CD6E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026032F3C1E;
	Mon, 15 Sep 2025 08:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J1Fvc3C6"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173522F39B4
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926367; cv=none; b=oJO5s+ng8zLWYPDnmjNOkEirwyQDeDMjnmjiRHKJR00TITbaINb3OkuK8K0YyVrmmBssB3JUD6p+EcKuNOIMHGPM7GUhmLuiEsFLTX0V0jhM6Myw+vD0e01MBWQ25QMraSkf+R6ny1lFQx9RG+acm7n3sRkwcDSUG9Kkp9L9op4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926367; c=relaxed/simple;
	bh=m/pZ6y54K3kx+mHExY4bRLVvKw6fj4rniWw50UqeCxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nY+IZYKm/PQxAOt7gG6IQIEBtCy9X4pA90gNVa/HI/5asrySnpSIZnSv95Nn6TJIEV9K8jcKWAfUIdFbg3fYp9iz46koatRR4vX/bWZijF/t3UnH5mJW49ZDqVXCzFg2JgNQ05dx4ClPZ8KatJCAwOejXbB1TAQX8I0UUX/3oP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J1Fvc3C6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45dcfecdc0fso39015025e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757926363; x=1758531163; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N6kxZ21z2ge9LAXdq4SO1toYg+8pc4aXj9MUKAvpBaA=;
        b=J1Fvc3C6hXgnsns+UnVqBAD+6a1Fr2DGrSjtIDwkHiG/ZnUmLAh7ot3JK2sC8iyhbt
         cFhcTtYyd5K6+HY8OWAIjb+B4WjnoRnRdRaKIYZApf6VW/MeAZvbumQzJ0Xmi/S3w8Do
         XrChzRMCMA1eT773rJBiCTpU+Zab9mkdOqEXjgF4scA9vChYG9E1NFIm9VmrMfiKOJa4
         kXHDzat9WbMmipRgMwW7G9H8Nzv/m2fa34B6FH3/MhU7c33VigEIb2zB190kSy0DNw+N
         KYNVl/En9eW6M6Wd3GYbD+XBa8kFZgxt89dch3ql+9he8LVCatcNUDd6N215Y4VVBy89
         tqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757926363; x=1758531163;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N6kxZ21z2ge9LAXdq4SO1toYg+8pc4aXj9MUKAvpBaA=;
        b=kY4IRYZ+lD1VvQK/ZEohS9CcwlrDOPUAImw/v+VsCceUyHmC0pBJHxkuPWhb+pXYiG
         +FAUzn9nc9JbC7j0q3IrHph8fQkHPATIIxbxGqMucTyYOBzFsUq3QOeJAiUTf1I0D5J6
         dq48re1xqFDELavJio/9MfSq148MVRTC+bsUUeC8wEJHY2pLGTO0ZAhlzGsOXECzromS
         xxFFxUGj5R/kryK/geA0hspFgT7h+01uVKKYfcdFD28HlV01WI/3py3cJ53F8VeHm0BQ
         R5eBe5WOzgDuy9nZfOcxTrsKoIQbxVRMI+puzs+3DZ6grWLCA/Dh1QfV5WZCIynTe/r1
         fCOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBsZ7VBLh2/MFBXMnOOXeiWSAqAOak+jBPHimdxGRKDHKVwEbNccI0qehvq6ZXcLvhXa6WOh58uLlheLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YySkvGgVYvzcqAJQTf7eZ2dN33cU1fT39AMOJkk3QR3TXZDO3We
	jSYuNV7uuKj9twVxNOYzk0indPMajQaBHJYQjjCJ0hW4ozBVBx9C9pUOXAvjLF6SE0M=
X-Gm-Gg: ASbGncv4DbdwrOj0lTAS0c5b3FxUri2Z6Cm1Vq4TOTnsyEPsF4gTP3zdavt4ZtPdywb
	lM7Pgex+hRYp7GokTB9DfTJ4bAr/88ZrNlP3emBIGGOfBQsRbz4wOtsqIM4nYpeEZTh4ijVTZnB
	tygHJkxMKJN04QUY4f5VmZsh/Ir7lYkp4pjDO6CJh9Zy1Z5cRGtEBC9HwgQ5YAa2/u6yMK3BQ9N
	guejfiwkQBuuPLnaErfMl0P0FbkIiih68BKp+dvFGkm9JdD9XWFKYt5Qn5/u9jEKp58O/gG/K4c
	tUJCDZwHK+bgGrWinubwQNs9zkRm07tl1hWhFYCvxht/UNnZYcwX3dFleJy4RPxmqLD/zVLPCsm
	8+56PSIou3ibDfxQNFzq2g74j7KgduC7D
X-Google-Smtp-Source: AGHT+IFzSjYN5GyjYoEpwSlYOMCz/spbxZZSVT6DCL0Ah2R68rwc3IWvf7dvYMLqkqc3FdlOFRSbIg==
X-Received: by 2002:a05:600c:314c:b0:45f:28ba:e17f with SMTP id 5b1f17b1804b1-45f28bae1a5mr60704615e9.31.1757926363306;
        Mon, 15 Sep 2025 01:52:43 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:30:ab20:75dc:ab3e:bbb9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f27f44093sm96526395e9.24.2025.09.15.01.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 01:52:42 -0700 (PDT)
Date: Mon, 15 Sep 2025 10:52:39 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Yijie Yang <yijie.yang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v11 3/4] arm64: dts: qcom: Add HAMOA-IOT-SOM platform
Message-ID: <aMfT1_uyZETUEBYk@linaro.org>
References: <20250910-hamoa_initial-v11-0-38ed7f2015f7@oss.qualcomm.com>
 <20250910-hamoa_initial-v11-3-38ed7f2015f7@oss.qualcomm.com>
 <aMPee9wEOrrW-KMU@linaro.org>
 <90dcca12-1a68-4049-bcbe-c333aed07a07@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90dcca12-1a68-4049-bcbe-c333aed07a07@oss.qualcomm.com>

On Mon, Sep 15, 2025 at 10:12:15AM +0800, Yijie Yang wrote:
> 
> 
> On 2025-09-12 16:48, Stephan Gerhold wrote:
> > On Wed, Sep 10, 2025 at 05:02:11PM +0800, Yijie Yang wrote:
> > > The HAMOA-IOT-SOM is a compact computing module that integrates a System
> > > on Chip (SoC) — specifically the x1e80100 — along with essential
> > > components optimized for IoT applications. It is designed to be mounted on
> > > carrier boards, enabling the development of complete embedded systems.
> > > 
> > > Make the following peripherals on the SOM enabled:
> > > - Regulators on the SOM
> > > - Reserved memory regions
> > > - PCIe6a and its PHY
> > > - PCIe4 and its PHY
> > > - USB0 through USB6 and their PHYs
> > > - ADSP, CDSP
> > > - Graphic
> > > - Video
> > > 
> > > Written in collaboration with Yingying Tang (PCIe4)
> > > <quic_yintang@quicinc.com> and Wangao Wang (Video)
> > > <quic_wangaow@quicinc.com>.
> > 
> > This looks like you should have Co-developed-by: tags together with
> > their Signed-off-by: tags.
> 
> We’ve agreed on this as the preferred method for marking collaboration, as
> discussed earlier in this thread.
> 

I can't say I agree with Bjorn there, but ok, he's the maintainer. :-)

> > 
> > > 
> > > Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > > Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
> > > ---
> > >   arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi | 621 ++++++++++++++++++++++++++++
> > >   1 file changed, 621 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi b/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
> > > new file mode 100644
> > > index 000000000000..c7c3a167eb6a
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
> > > @@ -0,0 +1,621 @@
> > > +// SPDX-License-Identifier: BSD-3-Clause
> > > +/*
> > > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > > + */
> > > +
> > > +#include "x1e80100.dtsi"
> > > +#include "x1e80100-pmics.dtsi"
> > > +#include <dt-bindings/gpio/gpio.h>
> > > +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> > > +
> > > +/ {
> > > +	compatible = "hamoa-iot-som", "qcom,x1e80100";
> > 
> > Undocumented compatible (without "qcom," prefix). I think you can just
> > drop this?
> 
> This compatible string was also discussed previously and is the preferred
> choice. I’ll add the missing 'qcom,' prefix.
> 

Even compatible = "qcom,hamoa-iot-som", "qcom,x1e80100"; is not
documented. And it doesn't make much sense to document it either, each
of the boards using the SoM should have a more specific compatible and
therefore needs to override this property. I think you can really just
drop this line.

Thanks,
Stephan


