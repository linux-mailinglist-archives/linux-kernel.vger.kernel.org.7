Return-Path: <linux-kernel+bounces-810164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8585B516C5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EDD74E70A2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2F131A540;
	Wed, 10 Sep 2025 12:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bt7UpaHG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B16B3191DB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757506970; cv=none; b=qyLwKDsF1O42S3R0uYttuH5PEHxkoZjgzN20WB8eq58+LyQrP1fQTvMxreYPh3Q13EHDeqd1/o18/WBmtvtBWN12R1m6+nqsTT5D3HvhQQzUmuCP7y7VgaS5yWgyKC0h2FJSsTueCTCSjb3pkbapMdLPKYGE3ECHiiAT8vSnT2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757506970; c=relaxed/simple;
	bh=vymP7SZBRqYD9TXG8E8GG5R4bEZaDPWBI5kRzRHzE8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WVqlD0zwKpn6MIa+TatPH3NR0tI/ca29o0g1T6vIMEATJvE+0gz+OPBbWde7U9Z1qTM/7TbbtBX0LAH98VwFhwzGy+f+9XK33h9472fKNzow0E+W3xxFRdAJKgevn29Ojnk3N7KUfvZey3dC2L7VyYxsGK/vWeM7jpCMamKbEdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bt7UpaHG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AAFHkM003769
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s/bVuPEBsh2YXnfDsGyxWB+08ksXo2EZydxB1awYjm0=; b=bt7UpaHGoUvYS6iI
	/kAJ7Vjm5Yv6vlIbQeUcsBwNhWBmag7+obJUyCmpk7nNR95wdy9m2VvSgbB7oPoK
	Jmoop+10eNEyCouFT4LIPZWnumIL3MSWl+m8M2QItjaIeQOyMqZS8VFluEIcFH1X
	FLVO4ymeorHcc1uTNUEvmJH18WU/ZFnmogLLXu8csy4OeTrjvreO+5v4IvlQt0x+
	Wpw26rRj/Aets/VA3fI+D7biJlIBTs0O6ej0RgEVELnjI59Dke1iMyeBjF5gA/Cq
	I7QQkquc4n+EdCYCwXe6RRLqYdsPraFyXJvvb7Lx0zjJOJPUDgdMNcEFJdolwnxM
	JE1jfg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8ku47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:22:47 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b6023952f6so17467221cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 05:22:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757506966; x=1758111766;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s/bVuPEBsh2YXnfDsGyxWB+08ksXo2EZydxB1awYjm0=;
        b=n0x1WhN1jqDme4KQAgdSjmnrzXWGotN4SIdHAE64xZEg8hlqoCHC1fRZPA/5/NRDas
         GhAcYqyNiAn8n0eh2yi77/V+UFaxMq+EassDoYidJx/+Q/opNMi3fYcUbs6v8hjgNSDE
         Ke6D7YpWSQPS+erc8f8WgOu9m8VXaAaGF/bhdsCX9Or4kAZ8ee9iwCbwljTQbeMlC0Kj
         Vej2w6N2AS0CEAvSIGgHv92+PggWS8cY71KW3csMaCwkCLLdXdMeo3ssJ7a4aJhcu2C6
         Xc2zEx488R/LV81eMkz2YQhWDsW6ao0O3L3vbugB/sjTKquS8Sd/3+a7NdPoWK+Zk1P4
         hLbg==
X-Forwarded-Encrypted: i=1; AJvYcCXNC9F7g7SN7lDJwCngP9BwQLqDmY81X1TBJYkG6wc677n53hIh3kVTrZUIHj2YU20jx17Gc8OucJQztrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWnuPpY3rSU2z3eduBFnzLaNwc67164mtFeNfMZsl5PfMpUWFJ
	mktZcUDWqCJTJtM/T8Saqqc5CFOIcmDr5Xh7kiCxDZLUh66Yx4AjWDXYlWf5qNwQRqIPC4MotMT
	0b2YWT+dHcmRB8vmsEszsBiiO/T4z/kYuxT21ChP/pHb+aAI3kDv0BIQItssN93MANh0=
X-Gm-Gg: ASbGncuAAHR19JdbkA+rpv/BO1VYN9bINi7d5n2ywPw3JpRWnYM0BvW64WOavBqhz/a
	E7WerlM4cYXI7W+bMefQOiICiwL5a3flIcI5xp3fEIImvS7nlcmxHm/QO2EYGAipVt8QO+EkXyG
	AyO4Y14xXmrrbNnzs7Enf23dxkqs6QKQIN3KPA9CZuT2uJIFJpLcot3vMS5ZqlGt3ANmGHTKHBA
	25+aeKgGD2AzDlw+PP1jJuV68RGfbZZi2NVKWyMFKSlVygTBrVequ0LljZUuj9aE36oKbZXofTW
	Xojt29VT6HhLy2fjr6jKiJ32aif4YGHi6236tUe73wjcHfFcOtckH4IYyWfuXl4L0ILQDxgTEum
	SgrXVrrW3Pu3/Ur4lBwiRBQ==
X-Received: by 2002:ac8:5ac4:0:b0:4b5:f7fe:4e25 with SMTP id d75a77b69052e-4b5f856938fmr104411621cf.12.1757506965907;
        Wed, 10 Sep 2025 05:22:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK96mIjsi7BIczF8k3Y4/aamKeJ97m8Mi+OeD++eGrVhR+uItPR0oN5U4hm/goOgUc9ybqVw==
X-Received: by 2002:ac8:5ac4:0:b0:4b5:f7fe:4e25 with SMTP id d75a77b69052e-4b5f856938fmr104409021cf.12.1757506964359;
        Wed, 10 Sep 2025 05:22:44 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0783411a3csm159621866b.100.2025.09.10.05.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 05:22:43 -0700 (PDT)
Message-ID: <b9017909-1643-4cef-bfff-5b672dd73960@oss.qualcomm.com>
Date: Wed, 10 Sep 2025 14:22:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] leds: led-class: Add devicetree support to
 led_get()
To: Aleksandrs Vinarskis <alex@vinarskis.com>,
        Hans de Goede <hansg@kernel.org>, Lee Jones <lee@kernel.org>,
        Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Mauro Carvalho Chehab
 <mchehab@kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Sakari Ailus
 <sakari.ailus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Daniel Thompson <danielt@kernel.org>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        threeway@gmail.com, Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20250910-leds-v5-0-bb90a0f897d5@vinarskis.com>
 <20250910-leds-v5-3-bb90a0f897d5@vinarskis.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250910-leds-v5-3-bb90a0f897d5@vinarskis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX85R4Y3MFBvSI
 K0swmObTIuxp5JOvNHf15uSdHLCquo7Arjfrm6w7BX4Lyl+Cd7aeFyTge6QMa25R64DsmRqIFB4
 7e3v8dlQGzhJkqo0i+TJjhE0Z8oggZnPKyl34rOtmQrDzRbK5iGxifRMPX4XdEELv0YMdEbs7Nr
 TuYzAtb5kNNOREyIgj6u84Km21uzff/SwJAz6TRoYgoqDxFyed2pLbbBmxKG7mTDnR7IYISHene
 /fZcpXT/TrrdSFhA7cNdEQ5xeaXw49qQvV9U1ax/C9mbLPHWAkZAvfkpppcbtce/AC1pnJ8Nzfw
 tv9YHv4BOm4LmihCrowE5xoEg/Teq1vnq4/1s8Ma8PmOm2owuvFt9HQtlMcR81cXQTX5FtlNE5u
 CEVB+lA4
X-Proofpoint-ORIG-GUID: 0YDscV-h9RBJh8_bB_3NoX90XYRbUXhW
X-Proofpoint-GUID: 0YDscV-h9RBJh8_bB_3NoX90XYRbUXhW
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68c16d97 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=KKAkSRfTAAAA:8 a=I76Qk8w-AAAA:8 a=hKb3k0M6aziuvKwtClIA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
 a=vUPM0Wvl0xcrLs4nqPIT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_01,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

On 9/10/25 2:01 PM, Aleksandrs Vinarskis wrote:
> From: Hans de Goede <hansg@kernel.org>
> 
> Add 'name' argument to of_led_get() such that it can lookup LEDs in
> devicetree by either name or index.
> 
> And use this modified function to add devicetree support to the generic
> (non devicetree specific) [devm_]led_get() function.
> 
> This uses the standard devicetree pattern of adding a -names string array
> to map names to the indexes for an array of resources.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Lee Jones <lee@kernel.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Hans de Goede <hansg@kernel.org>
> Signed-off-by: Aleksandrs Vinarskis <alex@vinarskis.com>
> ---

I was thinking, perhaps we should introduce some sort of an exclusive
access mechanism, so that the e.g. user (or malware) can't listen to
uevents and immediately shut down the LED over sysfs

Konrad

