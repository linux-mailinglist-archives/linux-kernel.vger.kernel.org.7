Return-Path: <linux-kernel+bounces-784423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4FDB33B90
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 558E21B23CDD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129F22D0C7F;
	Mon, 25 Aug 2025 09:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mQTan+/f"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71E728B3EB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756115299; cv=none; b=sJC6+975mC7ASHywC2lexjM9oIl+OvJgABX4wQxqFGacO0mhrjyKun//ZKzTHrdVNbjFXFc3tVFGdre3/6UPauP6BHdUMcXWgIFJLpmbnFWNDL/i2yJG4Dd5zfcb7VNpl+MsbFlBAj2MGRnRQyALjAqN0PxiKgvSa99dm8KI0eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756115299; c=relaxed/simple;
	bh=RGPjNT7eYla33Kxu+DaatsNooHQFM4EPX41laHhicrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIVB+wO3Al2vF9U+penZUe4zzHgXrfyeCKu1rzeT3SP2kXpjLzXoTLXg4DEu2R8MXRx2gLlojWmKKp6YJQd15jtGJ6pbLw8ES5GmdIxBXVNUE0p6tf9R5BLqDHFfXgKuHsXw7ZT6j5RtOTFQGRVi4glvfTDVT31QdBllP/H48Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mQTan+/f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8XeY0006224
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:48:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=TsxGny5bZmfquQo3c1L1zs/H
	NsPbZHYPUMZ3nblGGiM=; b=mQTan+/fHsOrHGVNQefyE5T5MCZ9H17uK+l5Qq98
	kau9N2gHiyDWr85nuN7oNhlxCAB19HeYYI1LhPOcxfuhdJ9aJmFrRxMUfv9ST7jm
	bltkZ+i7BjHg/hgYmgiD6lJ7Gq3XSeEcHFq0H0vW/JS8Isl8vJtSnp/x3MN8GcFc
	ZggqMXpLOwbD1XMs7GIYpl+EAXApXT5pYydv8273vu0dS5CqzKfIR0/ZNL4Qkuaf
	AW6lyb3oE5duJWWEoTe2QTJ2OZwowiThAbKKPWaTYqOEUxpw7L6ilrd59oV+HhZZ
	LHPy/jGqBqGEUjHMepibYQN9VxfIklQDyTISRnHCbB/LRQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5wdvjuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:48:16 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b1292b00cfso40569731cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 02:48:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756115296; x=1756720096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsxGny5bZmfquQo3c1L1zs/HNsPbZHYPUMZ3nblGGiM=;
        b=agnVRK6opUcbVxe250xgbHHVq+g/8+Sw0V9Vh7new5xTEqLESGanE8l4+40XXd9yQ2
         +kb8AL2HiFQMiQL7XKD05e+srzb9ySb+I+k7c16WYDEUujWKUKZGBKHZwO2+qG4ezocT
         hfW6fqIi+36b8TkiugJ3TuA92lH5SjOvaxr7sQcNQHt5MHVzL4wwttj14w1y5TrvYVd8
         0I8CLG21vPrd4AAHn7xZoc1S25BB0xhakxd/DpRPbFwJ0ZlKdxUJwrAKLzOpPFoQJibd
         Mm/5W+eIKbTb3RNYd/QfNSpqs5YMbv2vpZDW7d0Eui0DbLBh69dWRwPvppVcTBN1T0l5
         OBaQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/7qu1T8+PaQ215YCqWkC2yMKHEGlU+ZJGJ5hMHBlD9vdQSrRWc+cT9K4athW5ZeeN0FoDy8doFEOf0mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YysvSvL9cus2dl8O0vR1TkjhBIBJt0KERKU5/SqBdQ8oSvGgNhY
	CDdkiqSiG4hsJz7oZR8u1W0n9VQ+tpW8HYvc4rHh/5dOoBUpkvFoRELbwwiT7sISjWa5Lr9ssky
	4qE/Ujh/FCJrcTEE7wZP6nA8gWNUtRRrHV5+zmjDnla3hBmPGZSq7MZ18CtXIfJM7Rpw=
X-Gm-Gg: ASbGncto/xijM/43/e77qw7yuPS2+rhMVXioyRnpDMs7ADdWqaxuLwJUIub9lFRCny6
	sDJUeBu/4aYyiIjlNP+DFBFDsvSd9fVphnTIkcsoxSemipw7KAgHwNRxtX/A93e+1xtc4Q0bsIw
	RnTV0TqeIAKSmcMgBAmCMqa8dx3cAIR8Vld3MkddUBdjw5dVoI/Jh9PwfM1ADU8GZ3GVCSF0K+E
	Jnk4ixUmB5NrW1Av/Tr0hayuffdZ9cgrf19tAyu1u8OOm3ATXB+lDd69e9iGgS/RuAN408i0oB3
	EGbnz4VyCkuedLtLHehmjUgT0wEBnICSfvpr7hcdpFej6CPdWFi0wX7ovRYuiuF+AVkdOV9YPcF
	/8oilPqDTREKDg6H1huJ/BnXmS0UCZ4/5v5UyjDt4q3cV+i/Ev67m
X-Received: by 2002:a05:622a:199d:b0:4b0:7ad6:ea9c with SMTP id d75a77b69052e-4b2aaa6e769mr105923891cf.31.1756115295740;
        Mon, 25 Aug 2025 02:48:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA24ublCRv50GDQgudcMmYvfl+amokeNBspHjLCVwUTk/6j0Vcg5F5U8Vdo/x+kxEbdB1w/Q==
X-Received: by 2002:a05:622a:199d:b0:4b0:7ad6:ea9c with SMTP id d75a77b69052e-4b2aaa6e769mr105923731cf.31.1756115295226;
        Mon, 25 Aug 2025 02:48:15 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f49af0439sm95112e87.109.2025.08.25.02.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 02:48:14 -0700 (PDT)
Date: Mon, 25 Aug 2025 12:48:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nickolay Goppen <setotau@yandex.ru>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Richard Acayan <mailingradian@gmail.com>
Subject: Re: [PATCH 3/3] pinctrl: qcom: Add SDM660 LPASS LPI TLMM
Message-ID: <lkoealhzrqb6obk7qqchu3pomwo6bklczqtycnrylo3p7rhgug@h7wd4cofmwxi>
References: <20250824-sdm660-lpass-lpi-v1-0-003d5cc28234@yandex.ru>
 <20250824-sdm660-lpass-lpi-v1-3-003d5cc28234@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250824-sdm660-lpass-lpi-v1-3-003d5cc28234@yandex.ru>
X-Proofpoint-GUID: X7g_ZQjJ2CMnRNt4SkdKYnkcdm8FQNj2
X-Proofpoint-ORIG-GUID: X7g_ZQjJ2CMnRNt4SkdKYnkcdm8FQNj2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX4MRzjcJ4qWeT
 th1tCx4GyPUYj3tS/4hzXdEULpBVSkqnjGhs6PIMfIBWuS+GcvBCoXMk1H9i2ZkZ9cHggUc1Iwd
 m9ZvDQWsQujrkw3FpPV4D5OZFFXAYhDFRNIAD7NHOReZh5UIjurTnhyVNqWIRX+CT5EYS8LfgsG
 NDkTMID8/GR1MyC5ygOiwBfBV0rGWsfO2jrCnAP0L/VcBsDFnrzuLI5UcTnYSShZ8pIIlHbjqId
 5S05UD4KefHX2A0W1p5MVSDjbv6PRj6CRJW5l8TillzcoQcYDQSE7JCMIhTvoS1u/TsM3e+k/hf
 lGcOtRMWL8lGI49VPhxaTKFCcpA2+l2eAIcb9lyowRd44LdvKuVww5BkTZDAUVFGIfaKV1uHa12
 aMKfjtgw
X-Authority-Analysis: v=2.4 cv=BJazrEQG c=1 sm=1 tr=0 ts=68ac3160 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=qC_FGOx9AAAA:8 a=pGLkceISAAAA:8 a=vaJtXVxTAAAA:8
 a=JhL1wmR7AAN73KXSh2AA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230033

On Sun, Aug 24, 2025 at 11:42:25PM +0300, Nickolay Goppen wrote:
> From: Richard Acayan <mailingradian@gmail.com>
> 
> The Snapdragon 660 has a Low-Power Island (LPI) TLMM for configuring
> pins related to audio. Add the driver for this.
> Also, this driver uses it's own quirky pin_offset function like downstream
> driver does [1].
> 
> [1] https://git.codelinaro.org/clo/la/kernel/msm-4.4/-/blob/LA.UM.7.2.c27-07400-sdm660.0/drivers/pinctrl/qcom/pinctrl-lpi.c#L107
> 
> Co-developed-by: Nickolay Goppen <setotau@yandex.ru>
> Signed-off-by: Nickolay Goppen <setotau@yandex.ru>
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
>  drivers/pinctrl/qcom/Kconfig                    |  10 ++
>  drivers/pinctrl/qcom/Makefile                   |   1 +
>  drivers/pinctrl/qcom/pinctrl-sdm660-lpass-lpi.c | 196 ++++++++++++++++++++++++
>  3 files changed, 207 insertions(+)
> 
> +
> +	0x0000A000,
> +	0x0000A010,
> +	0x0000B000,
> +	0x0000B010,

Please lowercase the hex. LGTM otherwise.

> +};
> +

-- 
With best wishes
Dmitry

