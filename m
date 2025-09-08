Return-Path: <linux-kernel+bounces-805179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9C0B484FD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE5327ADA14
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406592E7BB5;
	Mon,  8 Sep 2025 07:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IZfEPaaI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96762E54D7
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 07:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757316009; cv=none; b=sL4bYZOrl2t+gzuVfDpIhMbSgzc6GmdLY8tNG12nKCcLRYgktFXVeb+HRWpNME1yWvvFPIZRtV4UYBWCOMgVNzbwnPo8p5UMhvvbDLLwjEhI2H44QpxbAm14YOfHtDE/TAfLKk6TpQWwn+WggcCLrPgL2rIk+NO2WPUOk9ppcwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757316009; c=relaxed/simple;
	bh=PqMyOblKEfOraVWVRyMOSW5G4N5oZyOPcmEHnteK9jU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b2HEWjgkgEu5wFDoOroxuUXSeg6ODb7AMap7JvGsHq2y0kyW0HW6M6Jv6pp717KT+w8NpaesyhtmL/PXPzVwQAaPbG3EzAA8wTlhBP4CmBDbuUgfbeXR+Nf0mokomG49Bz0ODaH1+1gn2LVL6Qz4WJojrwb5W5AqAM3OEwXpEmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IZfEPaaI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587LMnaS019349
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 07:20:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VWcKtvk8mFvfLmI00zGKSgzDw0tbzl3o6sU4GJfPEyg=; b=IZfEPaaIDN1l1x7T
	TnF1MTF+bRDRHQxbUua0ygSd0wlAkRtC3j1WrZRPaExv+OwbqMdE64KkYmn+QCQs
	RC8rVme6YhJB1Hsy68yssndvDzHpyAbOSHNpkcueZqfCvgAp1TCD6aebERni0Vez
	zWkLr6RkuDPBvmWRSah/ywQzw+d8Q4/IXKDBhwuyan4zzz9L38g1ImRJNbFjJP0R
	JdXCKEHEAxF0011/Igk+GEy0NopfLO5xRLSi+2te9Gk+E5pXGakkpxQVMkYaLuf4
	4jjhtJ4wLrzgfXVQB26W8Ftgje8vJJ3UEpFTKgPRpKudOlUI31Skz60BoDTdUcho
	ll7Dgw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490dqfuhmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 07:20:05 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b6023952f6so6345881cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 00:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757316004; x=1757920804;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VWcKtvk8mFvfLmI00zGKSgzDw0tbzl3o6sU4GJfPEyg=;
        b=N7LoO5ixne1yKFWG2LsB5J33Uowvn0neYJOlyC1aYAsQfWghfYgFXhBpFGJmevTsOO
         twUAXWUCz3lLTWSkKxDGpkZCKmnaK2f1x6Oc8Ip4KcvFW7vxrOi+ft+4nS3wO50zYoWz
         BmXgmPA2Qx2f49CFls8JwmcwHmpyNUxsq/fY7EuRoX4Ky3hL/UaodJcTTdXaILZqGx98
         n53I1JrJ9m7mrU2kjijOn1bLQFvo88OjDkFDcBbt1VxqKRkSUeYG/kw3r38ZqBi3fQmC
         frO5R8WLkSYmnAKfGpeNqSedk1fQZXQ6xFiZQa5RMEmyNrHRT88M9rpF5ZNA01KE5Ne6
         zbIw==
X-Forwarded-Encrypted: i=1; AJvYcCWyBw6g00TQ8KNQzQE5zDr6ulZ6dtZFexbAuHNrFbwUe6m7I4W6+qPzil0ivUZwnI/YajJabt8sCfyqR8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6ncZ6I56012VTB6o7C5VeHoVmNz/3OVTrZR7knpKOYjCK7iEx
	hEHHs3UVrN5yyEoG2xhOILlvWT6k3UdS5m8/SP16F4Gtuq5/XNL3YUvZTPNQfouc3KLQ7T+Rh8X
	ZtSL4KPmZaoRNVH4mZ3FJtf3qxsDz5GfVykkl0rMDJFs/jJc8FYiqzt+ptDX6NXmMPG0=
X-Gm-Gg: ASbGncupu8K3FrY99/3r8dBNNDc+o0UWhZrALC8xEf2EMUgbud0piamUxYQ2VoNAPDs
	RipJgW65DUx/sYTtTrqVbgBdUAQasHnmYFgxKWaQjO+uja4KbFOZJfwU/7NNLhnudCfWAsLUsOg
	xgPLM4MkG86mOO3mc/4Y+DWIQw2vQB9VwGzmZVol8/ZlIRXnWNk+HX+/QBe+VPHSBV+OFplMt04
	5k5BxfZpkvu/fkp9yhUFJ7UKTxvnX/Jj/J/GQhJVqwM5L8ghXuruQYwEMFRBY7za8LMPyuWz0VO
	TnTShRKOweBMBg3PDyDKHDhOwFkjnu3k/RPI6ZEHufgN9XuTG4kdH4JcB2to3y0CfVW4msMfVsk
	Wg9ZwQ7yjb/KUDH9f9aDD1Q==
X-Received: by 2002:ac8:5dd1:0:b0:4b2:d8e5:b6e3 with SMTP id d75a77b69052e-4b5f8445af1mr48142281cf.1.1757316004499;
        Mon, 08 Sep 2025 00:20:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4+QiJyueOpHGD01U7ZGb5pGulY2uWYz7NY7jH/9d6NejQbnMKqPQkDJBKht2O5pECh1Hjng==
X-Received: by 2002:ac8:5dd1:0:b0:4b2:d8e5:b6e3 with SMTP id d75a77b69052e-4b5f8445af1mr48141961cf.1.1757316003978;
        Mon, 08 Sep 2025 00:20:03 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0409bf055esm2172292466b.85.2025.09.08.00.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 00:20:03 -0700 (PDT)
Message-ID: <0e030e7d-0a1a-4a00-ba18-ed26107d07fa@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 09:20:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] dt-bindings: leds: commonize leds property
To: Aleksandrs Vinarskis <alex@vinarskis.com>,
        Hans de Goede <hansg@kernel.org>, Lee Jones <lee@kernel.org>,
        Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Daniel Thompson <danielt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Sakari Ailus
 <sakari.ailus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20250908-leds-v3-0-5944dc400668@vinarskis.com>
 <20250908-leds-v3-2-5944dc400668@vinarskis.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250908-leds-v3-2-5944dc400668@vinarskis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: IzoURZ6pHRrFGOjdaTPYdnCxHEDsOmk_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzNSBTYWx0ZWRfX3MdOD21YdlUf
 vgvq/UkwlnnMjwnxZYM+BDmoDGi+d5yFMT9DR+tPGPuiasbfUFDJBCQowQtaPd0J0NxuSBTaqgg
 DqJCuDYkms6lDXKi99PloHUldNGoHT2C57bylnXJ4qSnCeHkbAd0Dql3M0nx3etyqeFUqN13flW
 p/8MnfgquhdJhDtCVRnIA69Nzdr1Kr5vT41QHQMsL8mdQhGiOLLorbNh87+4N+XfS/TTjQxwzEi
 hShGErgL8oUQxULpY/DRzbIT5+RJuvlhJcm3JEAI6tPeFjeUVwZleWD1RIsZe+JAaf/SC86SImv
 Bsa+CQ0Zlk13+4Fu7upUduFfQR4Gzm4ar5rk5ghfsVx2lkbSSpBOLQgccPoDPM4uDRI5wD+QTf+
 x9tQE6n2
X-Proofpoint-GUID: IzoURZ6pHRrFGOjdaTPYdnCxHEDsOmk_
X-Authority-Analysis: v=2.4 cv=N8UpF39B c=1 sm=1 tr=0 ts=68be83a5 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=I76Qk8w-AAAA:8 a=zDPauhyOtcwAXlC7rdQA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=dawVfQjAaf238kedN5IG:22
 a=vUPM0Wvl0xcrLs4nqPIT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060035

On 9/8/25 1:18 AM, Aleksandrs Vinarskis wrote:
> A number of existing schemas use 'leds' property to provide
> phandle-array of LED(s) to the consumer. Additionally, with the
> upcoming privacy-led support in device-tree, v4l2 subnode could be a
> LED consumer, meaning that all camera sensors should support 'leds'
> and 'led-names' property via common 'video-interface-devices.yaml'.
> 
> To avoid dublication, commonize 'leds' property from existing schemas
> to newly introduced 'led-consumer.yaml'.
> 
> Signed-off-by: Aleksandrs Vinarskis <alex@vinarskis.com>
> ---

[...]

>  
> +  leds:
> +    minItems: 1
> +    maxItems: 1

My brain compiler suggests this will throw a warning (minItems should
be redundant in this case)
> +
> +  led-names:
> +    enum:
> +      - privacy-led

Nit: "privacy" makes more sense without the suffix, as we inherently
know this is supposed to be an LED

Konrad

