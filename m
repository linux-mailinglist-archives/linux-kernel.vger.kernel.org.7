Return-Path: <linux-kernel+bounces-787518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFADB37766
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 03:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D9128E0487
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 01:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07733165F16;
	Wed, 27 Aug 2025 01:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kg56D+a4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF96F30CDB5
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756259273; cv=none; b=Z8kDbkH2zDxwB97Yd+yQW5KC3egTc8YChov4NX9Q57e4vf6cQ2LMlfq3EgCs+kdbHJndVPRTmqAjm9HnbIElj9+z3SdYOz63sGmYt44h45R1+oMHLIz0hKP+pmUZgHBw5ImVHiIKjUatxnAgp79QVoErPcAASMVsTr/nH65uG+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756259273; c=relaxed/simple;
	bh=tQwxUSIq0Kj2ITXgGAuR54KOzVXtZ2RDQiyDExb73GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1st0p4Qs2t0HvBNWkhCO53YKeYXV8DF3G9hYKazqMh+eu9RcdoMt7myyA3hMTM92oefOX6l6vE94qvz+hbnC/XTMC+/GqdNeELPOdbOltyIMuNSGg0Rm/AQmQz5TddSDdGFL1BEpUMvrHbfxf1ZwmwGnisofdVhj/xt9UDIhQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Kg56D+a4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QFsOvA027881
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Xx/i2cO5t5bvYG8Jnj6rptwa
	dH+uLUpX0bk5U9Ers4Y=; b=Kg56D+a4P8nAhTjJmi9qpmI0aJM1ZaYROFgaEVPV
	t3pF7Mf1tHDeiM1HCTckr9JYpKPeAUInurtePCh8aKmMCtIfeQedKxAoiwu7YcP1
	hA+TlPjgT0NIGcb9G7OT6JhILRlUSplCj4R5OGtfivDEt0raKQ2hVZKWqPifCgLn
	+cJfPLy70149GekAi4rXBJ+0oJhhYQNlC/7TiR5E/KGxMJ7GFApguEP0GVVwQK40
	QbtuM/MvUKLW3hKtLAYbQI+WIV9yre/LOohOtUk34adWYtAvoZRNZDw+xr+3DbXx
	N7c4qaFCTjk95h6Ddkk2e51hX9yQARCIRHYUdudVBDbtyQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48rtpewa5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:47:50 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b109c7e901so147095571cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 18:47:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756259268; x=1756864068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xx/i2cO5t5bvYG8Jnj6rptwadH+uLUpX0bk5U9Ers4Y=;
        b=ThmdaGCJw0bJwng2pC/9HeCGcYNyxYtcbJ63HeeVSu8o1/ms5M9WI5eHBYtU6zgJeS
         NLrIz0mn1AbDiol6r0cxK3cpCCOCAjFQ/jGpp5NbmI+OAsyHj/wbVQGG841rG6gHGZBO
         aFE715ZlgJgb6r6cy1Tw1LZxIxywMIRcWuCpB4E0dUWcakOpShMnBo++s2ea/bzGZ+w0
         yTVupuWOj51v8eDVLtAc4nrjJIZpMlcAlPg7Oj7tV5S1uBe7IEEr5z5NboTs9Cj+QCm4
         9idp0g727kJF4f40bmOQkjmiVmJLWKvqLaupTJIBKQ19OI85xt/0rys4WZiq3rODjfEe
         HPjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQrPFAZHPbG8NACXKChvgXQDSzjkuzb8ic2Dk/Q8YLku+oeBfKzZq2W7z4arQfhqj8FvYhWXDk8VVw2hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyS6Tf/lFq5vE0K41/kzOLBvgq49IFUNVLhzg4LH7CChmfzcul
	6gAdrc5eaCikSXqC0RfgG/kuPPgd328GQg8eynqJSIPYZL0nWMd7o0kEINppM8ipCdQ9wLio9PO
	wYsjiKscWhFlIzAODreFx+R4sVfxFxUCv9hggTeNNZpRlCOTIVqunyCdl4xhBeQOibH0=
X-Gm-Gg: ASbGncubdAnkoT/RgqdnU+YJyc+07+tx1BJ/NENIA/j8C+PdrDaVhVHFqmqX9EUAm+Z
	5YrkRGFtfHwg8p/90TL9ZnrsbVemyRqxtcW9IclIgdX3JLmjlTKNw3Hu9mK+svnIW/P6/SDRuHr
	Cur47SBZZHLkT5deraUA/8P4eAnDZ6k2ll6P42+YB14iwUv0zBTSfwuhZMiaknl90DPOp7zviJt
	H8sQNU0D89fi0zDz5XOIss0bQ0mHScVkD5/NNcU6at1G2jdkkmKaG7nYJ8GKMhvpNRSuLRVyhqo
	//pHtDrOOEIjDqHn46IrZtG+bMxkICJbi8n6ezXdeg4281mdyvpQd5kWpoOKdqsdmb58ak06nvT
	hwU6xWGulXEgFcnRlIE6m+UEsIwO/GF+17tjqrwk3V35zXz4a6+ID
X-Received: by 2002:a05:622a:249:b0:4b2:e151:a1e3 with SMTP id d75a77b69052e-4b2ea694690mr28935841cf.36.1756259268290;
        Tue, 26 Aug 2025 18:47:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBHJPUrlKW+2YGHEaVIwfEJxbzGaS+UXxCsnH3ue7BGMARfOzC3ut6mn4j0kUEjyJboob2Jg==
X-Received: by 2002:a05:622a:249:b0:4b2:e151:a1e3 with SMTP id d75a77b69052e-4b2ea694690mr28935531cf.36.1756259267642;
        Tue, 26 Aug 2025 18:47:47 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3365e20d2d4sm25123951fa.5.2025.08.26.18.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 18:47:45 -0700 (PDT)
Date: Wed, 27 Aug 2025 04:47:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: setotau@yandex.ru, Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Richard Acayan <mailingradian@gmail.com>
Subject: Re: [PATCH v3 3/3] pinctrl: qcom: Add SDM660 LPASS LPI TLMM
Message-ID: <xcsx7fxl2wcnd6ocbzlptwkzm433aneaopigp5j2bxqq64mltn@56uq6lflgyio>
References: <20250825-sdm660-lpass-lpi-v3-0-65d4a4db298e@yandex.ru>
 <20250825-sdm660-lpass-lpi-v3-3-65d4a4db298e@yandex.ru>
 <wgpxw6pj5xmtlc3kabprkfx4o2nsvmykyemmdulhvyxmahes3z@xb7tlzec7nv2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wgpxw6pj5xmtlc3kabprkfx4o2nsvmykyemmdulhvyxmahes3z@xb7tlzec7nv2>
X-Proofpoint-GUID: RiGYiuau2luuiTgQOgHP7HnydDfI4Hk2
X-Proofpoint-ORIG-GUID: RiGYiuau2luuiTgQOgHP7HnydDfI4Hk2
X-Authority-Analysis: v=2.4 cv=Hd8UTjE8 c=1 sm=1 tr=0 ts=68ae63c6 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=qC_FGOx9AAAA:8 a=pGLkceISAAAA:8 a=vaJtXVxTAAAA:8
 a=pdFGTGbI3ZYik3Y3MvEA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDE0MiBTYWx0ZWRfX2ymwSGJeA2vl
 SY8mdGwi2AVRqVBVLt9ct7jMkIEFJX6w69cZqoFHNXXdi1evh5ESg29lJezAfN+JwM2bIsX8unA
 kbS4PAtMmjpb4gKEKE3GzsxrbEYRXzdS8fXDvfMEIy4TTsURSohuZOL3nvqmM4Z5xOpV2yXwdUq
 vcwctl1jXqzO6WZMu8aAp1UR/+atFR9+Jt7SC8y9YsPjuHlervVR2Ag0DR3fLsuptnir9d8Dptq
 qTdGL2Kcn6tnvGa6SnPOnfV0hvQNo1FSOUElAK9Tfy6IAZn85ZXbDZrCRZaqJ42g6URYhYcu+nm
 8u28bjzWRXDyhBsM93rr+94VX+H98w5Z0wY4shCn5qAB4GP0IgFvPmRzwl5Q28aITF1cbGTYyjt
 ew3dKht5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250142

On Mon, Aug 25, 2025 at 10:00:28PM -0500, Bjorn Andersson wrote:
> On Mon, Aug 25, 2025 at 03:32:30PM +0300, Nickolay Goppen via B4 Relay wrote:
> > From: Richard Acayan <mailingradian@gmail.com>
> > 
> > The Snapdragon 660 has a Low-Power Island (LPI) TLMM for configuring
> > pins related to audio. Add the driver for this.
> > Also, this driver uses it's own quirky pin_offset function like downstream
> > driver does [1].
> 
> Please describe the quirky behavior in the commit message, rather than
> just referencing the downstream code.
> 
> > 
> > [1] https://git.codelinaro.org/clo/la/kernel/msm-4.4/-/blob/LA.UM.7.2.c27-07400-sdm660.0/drivers/pinctrl/qcom/pinctrl-lpi.c#L107
> > 
> > Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> > Co-developed-by: Nickolay Goppen <setotau@yandex.ru>
> > Signed-off-by: Nickolay Goppen <setotau@yandex.ru>
> > ---
> >  drivers/pinctrl/qcom/Kconfig                    |  10 ++
> >  drivers/pinctrl/qcom/Makefile                   |   1 +
> >  drivers/pinctrl/qcom/pinctrl-sdm660-lpass-lpi.c | 196 ++++++++++++++++++++++++
> >  3 files changed, 207 insertions(+)
> > 
> > diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> > index dd9bbe8f3e11c37418d2143b33c21eeea10d456b..ef42520115f461302098d878cb76c6f25e55b5e4 100644
> > --- a/drivers/pinctrl/qcom/Kconfig
> > +++ b/drivers/pinctrl/qcom/Kconfig
> > @@ -68,6 +68,16 @@ config PINCTRL_SC7280_LPASS_LPI
> >  	  Qualcomm Technologies Inc LPASS (Low Power Audio SubSystem) LPI
> >  	  (Low Power Island) found on the Qualcomm Technologies Inc SC7280 platform.
> >  
> > +config PINCTRL_SDM660_LPASS_LPI
> > +	tristate "Qualcomm Technologies Inc SDM660 LPASS LPI pin controller driver"
> > +	depends on GPIOLIB
> > +	depends on ARM64 || COMPILE_TEST
> > +	depends on PINCTRL_LPASS_LPI
> > +	help
> > +	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> > +	  Qualcomm Technologies Inc LPASS (Low Power Audio SubSystem) LPI
> > +	  (Low Power Island) found on the Qualcomm Technologies Inc SDM660 platform.
> > +
> >  config PINCTRL_SM4250_LPASS_LPI
> >  	tristate "Qualcomm Technologies Inc SM4250 LPASS LPI pin controller driver"
> >  	depends on ARM64 || COMPILE_TEST
> > diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
> > index 954f5291cc37242baffc021e3c68d850aabd57cd..cea8617ac650ecfc75c2a0c745a53d6a1b829842 100644
> > --- a/drivers/pinctrl/qcom/Makefile
> > +++ b/drivers/pinctrl/qcom/Makefile
> > @@ -43,6 +43,7 @@ obj-$(CONFIG_PINCTRL_SC7280_LPASS_LPI) += pinctrl-sc7280-lpass-lpi.o
> >  obj-$(CONFIG_PINCTRL_SC8180X)	+= pinctrl-sc8180x.o
> >  obj-$(CONFIG_PINCTRL_SC8280XP)	+= pinctrl-sc8280xp.o
> >  obj-$(CONFIG_PINCTRL_SDM660)   += pinctrl-sdm660.o
> > +obj-$(CONFIG_PINCTRL_SDM660_LPASS_LPI) += pinctrl-sdm660-lpass-lpi.o
> >  obj-$(CONFIG_PINCTRL_SDM670) += pinctrl-sdm670.o
> >  obj-$(CONFIG_PINCTRL_SDM845) += pinctrl-sdm845.o
> >  obj-$(CONFIG_PINCTRL_SDX55) += pinctrl-sdx55.o
> > diff --git a/drivers/pinctrl/qcom/pinctrl-sdm660-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sdm660-lpass-lpi.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..36fba93fda1160ad51a979996f8007393555f222
> > --- /dev/null
> > +++ b/drivers/pinctrl/qcom/pinctrl-sdm660-lpass-lpi.c
> > @@ -0,0 +1,196 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * This driver is solely based on the limited information in downstream code.
> > + * Any verification with schematics would be greatly appreciated.
> > + *
> > + * Copyright (c) 2023, Richard Acayan. All rights reserved.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pinctrl/pinctrl.h>
> > +
> > +#include "pinctrl-lpass-lpi.h"
> > +
> > +enum lpass_lpi_functions {
> > +	LPI_MUX_comp_rx,
> > +	LPI_MUX_dmic12,
> > +	LPI_MUX_dmic34,
> > +	LPI_MUX_mclk0,
> > +	LPI_MUX_pdm_2_gpios,
> > +	LPI_MUX_pdm_clk,
> > +	LPI_MUX_pdm_rx,
> > +	LPI_MUX_pdm_sync,
> > +
> > +	LPI_MUX_gpio,
> > +	LPI_MUX__,
> > +};
> > +
> > +static const u32 sdm660_lpi_offset[] = {
> 
> This should be write only, but I still find it error prone and ugly to
> keep this array separate of the pingroups - and I don't fancy the extra
> indirect jump just to lookup an element in the array.
> 
> Can't we instead extend lpi_pingroup with an "reg_offset", and then use
> lpi_pinctrl_variant_data->flags to indicate when this should be used?
> 
> That consolidates the information in the groups[] and avoids the
> additional function calls.

I R-B'ed too early. This seems to be a good idea.


-- 
With best wishes
Dmitry

