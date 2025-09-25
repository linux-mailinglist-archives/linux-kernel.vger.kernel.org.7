Return-Path: <linux-kernel+bounces-832379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEEFB9F314
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5CB438806B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC103054EE;
	Thu, 25 Sep 2025 12:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cxmr+xaw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ED6305074
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802550; cv=none; b=Kg+Zlxb3x8UUmuWyCbJR6B4P2WqLpa9StV7zZlZQ5ECwLCaVG5bOE2kIWHZ+9rmZftvRBvAVKG64Gi2VxrfcXGfNDXoLi9xgUI24vTACSBPfS7V4Xv2ul1ri0W0Fzxchneq1+O4ImdZ4OGbsMARRbWxdXqCv9G1SjwpBUrD11/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802550; c=relaxed/simple;
	bh=HQloABzlnB8r/NiJ4QOXbc7ZT8TEzRbdNF3WianAing=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YMG6R/cE4GmhuTYIuGTvoSh8rRWw5ClHuyDu2ADv+qzy+Cdn+FYQ5IyJUC98WVOWs1puikeubLZ/aHNt3bOLy2WqXIQJfPFe78wgbWhMdAXvul6FWAtgB9Q2NkHYw69dzIPV+AMqT890Eky8TTAI5u2TqBYo5FKMFr2O/SzHC0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cxmr+xaw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9EH7F001842
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:15:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ouVUk6EkYRj6EqW6mxcCGA12lGdj8Q5EsB1YmAFNCoY=; b=cxmr+xawu7/OiGto
	hKBFSxw1GOr7BwHSqh1fj6Wquo3GiKjmyDRK/yl1HXNPJD0jUKkKzqWMgH0CvLhX
	krW8IHyL/ZDiyfzMasbn/tY1z/bp2JWwyzMOZ+SyyHAGQNXTUxO70LCU3R+iOrp3
	PNGrN6HvL4o4+gdzd52P+WHgHlIQgDG2QJ6opnagCputPwiQVGJO6XqVVXwfUXgu
	iCPELS33nVpciqC8CmeLbXdRiD96Fwp3oXdGJslWFYza7C92A/HnR+l23HbAbXBx
	vRYM632IUoUHa4mQGfnS8TubLqshbozzT1UCkl5jW8JCL1C0JCT8iex4To2ozDJY
	kHvJ1A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k98r09x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:15:47 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-85a8ff42553so27045985a.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 05:15:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758802546; x=1759407346;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ouVUk6EkYRj6EqW6mxcCGA12lGdj8Q5EsB1YmAFNCoY=;
        b=TlA4hbp54K4HbXBU6TyWPTKkuvolguAj4+YECERR0ZCbDGV4RA/wSqsy1eJWmXCTxk
         RpMQZbyy9quNhfnBzdDrMuaqgIyg8W71hxBr4OHDOe2xGqlH6LK4ElX3jRtC6efIU9Nq
         7lrSUXIIuRY80FbEqwWzn+efeFqX46jdAGX0lZYV5BWm6JxPsCKLdOYvcF7l7S/kO5Xb
         3481c1kuwmksSv/oUOIZG+/f/lEt9F9JmruyRB8DesvScn0hhTnnGP81kwsfSWiNqh+w
         3vUI1md+kmtQMiUW+YmnylVlRC6aj6IB0Ae5HXgBoaGGm3trzxC6zfs6UGtgGDiWJP1A
         UKXA==
X-Forwarded-Encrypted: i=1; AJvYcCW9m7BILH4cR0KiN9qPQPUlUkCIApSAEXzW5Ai6DGGpiFbWyoBxUmGgccnZtrcHT9WQcw4ZIpWSOI6s8ZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMuxpXKrFIoMUN1ObzynuJw2b3CnrWMWAM6OvP02vremVf8Xtp
	6GGzhorBPMNewqE2pA09aHIxRvHsdTEaGD+lFgzTFQS/60KR43SZfOljY5v5O2rLjAeMAMuU6+2
	jLRaELDREQ1QSLCUj+p07SYcWkZeeHAHLr50v26S8Xg52B0oI9qiW1W3YdsWOQTYmGO0=
X-Gm-Gg: ASbGncsYGpZU4lhe1BNcorS5mWYUhodgCW7PxDRxxnhjQe79ZcEDNUx7jSana4RCepM
	zCQSt1DDzNXGQfoottmZdGH3AeWOWWE9lkHRz2NW6QuBDIs//pgndnzbM3GOPvp6E32LnQUNwMW
	SZWCxDH0iLdJ3+LwBWKPWZ0Ch+u5xvgp/X9lg8uV3BMwRM/xd9aXmMmv72sAb7uDHa+npeuklVa
	AMqUvdzzCEpXc8M+Mx8P+AOJohBS0iK9LJzE+bVK6rZlZcdNzO4I8p+pPzqRiEQ9C8qAVQpb07E
	9/k0BnZglVOO8BybjmqQjNobP5RcIDUyec7B52vSbi7OyQuwer5PCz9CRnn18oryufKMofC0Niz
	dbZVjCdqStULYh4JJjKxD9g==
X-Received: by 2002:ac8:5d92:0:b0:4b7:a9cf:91f with SMTP id d75a77b69052e-4da4b0490f1mr25219121cf.8.1758802545971;
        Thu, 25 Sep 2025 05:15:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKDTicP+At3tb6zBRvj+8JVoPm7W3lOGpEI+urWVr96LG5JzmbSw4XR7btbmuKOwHogSvf9A==
X-Received: by 2002:ac8:5d92:0:b0:4b7:a9cf:91f with SMTP id d75a77b69052e-4da4b0490f1mr25218681cf.8.1758802545476;
        Thu, 25 Sep 2025 05:15:45 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3545899fc9sm153299966b.91.2025.09.25.05.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 05:15:44 -0700 (PDT)
Message-ID: <81822df8-1978-4f22-93e7-87b79e1fc9f3@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 14:15:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 2/3] Input: aw86927 - add driver for Awinic
 AW86927
To: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20250925-aw86927-v3-0-1fc6265b42de@fairphone.com>
 <20250925-aw86927-v3-2-1fc6265b42de@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250925-aw86927-v3-2-1fc6265b42de@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: qM3pQWnErWy_nKiUJtIRPs7I-kx_OJZ7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfX1JOz8fQVrWTJ
 MMr7XtNUsw1XlVsod0sDnUQBdFCmpHAnDT8mi4jo2or/0mU+W5Es8359c8acXNANyRFC1XL8xS0
 hgnabZapiVhb6kWXL0yQhAKn0QRz7xbgKo/GFAF7FFfD3hX9sUS1z8rcAPYPOJ+ek/t4QQdh34n
 aJ/jONjlW0WGqtw82mas76ajl2lhxJqDSRZVwbZD4ETkBM9dpYE2QKth+gSw0pdoIowWwA6ddl1
 /9f/QBckseaiI8V7hqEHaHu2AzCaVxrBhdskr3QPfbYUQ4bDU/oZiJaLOpiJoIYmfr4TKG2rtbB
 iWFbXHtfFas8ctHMVIYwu5wVy7gD6xyHKQF5B4cD1r+vxJA3IPydEi8wei/rnyP8O/6Gh2bEm7z
 +4liouoG
X-Proofpoint-ORIG-GUID: qM3pQWnErWy_nKiUJtIRPs7I-kx_OJZ7
X-Authority-Analysis: v=2.4 cv=Dp1W+H/+ c=1 sm=1 tr=0 ts=68d53273 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=6H0WHjuAAAAA:8 a=pLNEalJQesa3U4KxjPAA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018

On 9/25/25 12:07 PM, Griffin Kroah-Hartman wrote:
> Add support for the I2C-connected Awinic AW86927 LRA haptic driver.
> 
> This driver includes a hardcoded sine waveform to be uploaded to the
> AW86927's SRAM for haptic playback.
> This driver does not currently support all the capabilities of the
> AW86927, such as F0 calibration, RTP mode, and CONT mode.
> 
> Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
> ---

I'll give you a couple of cosmetic comments, feel free to ignore

uint8_t is abbreviated as u8 in the kernel

[...]

> +#define AW86927_PLAYCFG1_BST_MODE_MASK		GENMASK(7, 7)

GENMASK(n, n) is BIT(n)

[...]

> +static int aw86927_wait_enter_standby(struct aw86927_data *haptics)
> +{
> +	unsigned int reg_val;
> +	int err;

"ret" is more common (for "return value")

[...]

> +	switch (play_mode) {
> +	case AW86927_STANDBY_MODE:
> +		/* Briefly toggle standby, then toggle back to standby off */
> +		err = regmap_update_bits(haptics->regmap,
> +				AW86927_SYSCTRL3_REG,
> +				AW86927_SYSCTRL3_STANDBY_MASK,
> +				FIELD_PREP(AW86927_SYSCTRL3_STANDBY_MASK,
> +					   AW86927_SYSCTRL3_STANDBY_ON));

this is regmap_set_bits(regmap, register, field), you can consider
dropping the _MASK suffix too

> +		if (err)
> +			return err;
> +
> +		err = regmap_update_bits(haptics->regmap,
> +				AW86927_SYSCTRL3_REG,
> +				AW86927_SYSCTRL3_STANDBY_MASK,
> +				FIELD_PREP(AW86927_SYSCTRL3_STANDBY_MASK,
> +					   AW86927_SYSCTRL3_STANDBY_OFF));

regmap_clear_bits()

(also regmap_assign_bits() which is a conditional version of the two
is a nice piece of syntax sugar)

Konrad

