Return-Path: <linux-kernel+bounces-844096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1FABC0FF0
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 12:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E5F7834DD50
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 10:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2312D8789;
	Tue,  7 Oct 2025 10:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O+ycNSwX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888182D8385
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 10:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759832470; cv=none; b=WagcUUdKx9j2hObc845pcU7sWiON6dX20qSU1dPRyCVaIay41ey1pSiF8iSjHjPcXtz/XsoYV4Z8yGNfgdvZ2PsTdCq1sRdv2JWlwe6mmAy2g8gMFISxNJPz1sk+UjwV27JiG6KCFJSD21pKM6BTxkbl3gQ5tTRPe5d8d/aZp/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759832470; c=relaxed/simple;
	bh=KlWcesGR1Y3SWb2Pf+LplrfVxqm952BRg+WXsE+1NQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z3RbM+2WB8UAh2KLgsACAmIFq1bMr+zqQMnSfgh9fzDT98VNMq/7inclDa8UZhSqyC4reHtrTTk8Q3E2NwLx1xFPYvjqTPlqs+LC+Cft3IQUob18EFXHnJ4exiV1xn4qPhJ/ik3a9oAg8mOWR26Di1fQVoM1ZORvvel8GSW0xFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O+ycNSwX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5972vWV9025014
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 10:21:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tIo3KVM+K+vyiDHJB/HcD4sh2FPBitsVu91g7TQ4ScY=; b=O+ycNSwX3MX0aqxl
	Dkk4gPB5u1MUP0WEYGqTFzZZJtfONNuB46zqc84Q06K4BJW5Act4A3HfY6cyXuFf
	P+GbZ9/TWBJmuIj9IEAAODyXSyswR78fcRhMo2Q5idReHwFP7eUXsL9IFBe9+UL5
	Hq4KZhMkyLmfNbyBPbj9WsU+pLUXzAod/DtugcNqm4Ik8s3bWtr12n+Iin2w8vXI
	fLWD3sKuqmrLGDxXyskJvMbDcNyb31USMMwkk3imLOaWxowwfNpqJqiuGnxhH5VW
	fLe02yE7ffaTyfLNCi9LfPKLuh0MzVZTTxXX6ufpIX8Xbas3a0uyMlFrHzPU3Yh4
	SmPbBQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jrxn76du-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 10:21:07 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-826b30ed087so16036516d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 03:21:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759832466; x=1760437266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tIo3KVM+K+vyiDHJB/HcD4sh2FPBitsVu91g7TQ4ScY=;
        b=p0LDALdsTE8efXOhUPAZ+ND6+On2zshSp13HAjEViTnxhSJnw7tfSuGtPSUdY/SSBX
         wS4LKewhe9ii8L238fzaFYZ72W/RoEn5DSCAya1chwAu6wmuqawIwTWR8HxAAlF4Ae8O
         pTpfsZJdsBJFGQ35VBm0xPGy/FrkPfAPVHV1XFAny0ndS1I/Ze+16FW25J31ricT/F7A
         odwlJINUmbyY3aOCm2kJeeaRDN8LPG8Mgl0jHDrvtCTlWxhKPIpBt4aClMnFMqf7RP9x
         uH7Tjx37BCx8oHIkjrXgZIgV0qN+ZfuGGYBQjQj03Gatgf0KD6hv70CusaonJQfxTT+c
         0vXg==
X-Forwarded-Encrypted: i=1; AJvYcCWtX4eIXkqPjqeEDbJ2z4MMN46/Mbkl025d8qHFviDOcJ1csYR4WpdyXeK7lAEG5tDyy+NXibLhm+ci24k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW+1l4ENPm7yiBoGNZXAZnXzB1b4gkq2HMIpKcEcYMVHRruw82
	vdxAmBps7412Qm4InmQo3ptRCcPx5Els+fA0rvAY7GYlxWz++JUrL+x+Ylv2pbrhF49TEsNDDGX
	sXW5rQZQjJXoYsZiziVk7JFT5C9MVaxnHfburgSwkl+uMutvnFZ7HaFnn731I4WTjlik=
X-Gm-Gg: ASbGnctJeTd6Diqz0sDlUFHzNYfwazGIVeP8A9YxJeWtJ2MuT6m3UdZJg3xhQpMWnPe
	aTyUzsQi6X90CYTci1Aa/ELmvNIhf8D3Lwv1PteR7ZeM5/zGfgcsV9TFjGhvSfDoHEYmMGSlNqY
	QA2Li8W958NgK6MORANmLdsaCB0VLQjrsH1FjC4yi0v28C4+yuMhOEPb/mtWF5QnQxe3xLPsTwC
	I1fjZESdDLDKJud6rkB+R4Kprl4qvUqI4IbuQzWRi1HkNZVIJSl8OjmsoE4Bim0qkW3qYv+Evs6
	jXhoW1qcIEIzEUrB/X6W/N3wzhwvMluDH2pge17rA6KkUdgywP1rFrmMidSvAslMV3I+XIqa1v/
	dC0hz0bh+/6RlH1AyrwgIfy0tsMk=
X-Received: by 2002:a05:6214:486:b0:815:2731:3f4c with SMTP id 6a1803df08f44-879dc869283mr128952106d6.3.1759832466027;
        Tue, 07 Oct 2025 03:21:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHY3578mf169SfhBSI1JAa+gLNy0tM6jidBQPfZwdM2VQXBIOCyg9olplyRBFv973g54ofICw==
X-Received: by 2002:a05:6214:486:b0:815:2731:3f4c with SMTP id 6a1803df08f44-879dc869283mr128951866d6.3.1759832465465;
        Tue, 07 Oct 2025 03:21:05 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6394bec298csm9271021a12.44.2025.10.07.03.21.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 03:21:04 -0700 (PDT)
Message-ID: <6d9af57f-9174-405b-9131-145fd6d63a5f@oss.qualcomm.com>
Date: Tue, 7 Oct 2025 12:21:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/6] ASoC: dt-bindings: qcom,sm8250: Add clocks
 properties for I2S
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20251006-topic-sm8x50-next-hdk-i2s-v1-0-184b15a87e0a@linaro.org>
 <20251006-topic-sm8x50-next-hdk-i2s-v1-2-184b15a87e0a@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251006-topic-sm8x50-next-hdk-i2s-v1-2-184b15a87e0a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwMSBTYWx0ZWRfX0EB2XakT5Uyo
 f10GmjDAuTX1wGIQYfzx5XDH/LqdK69msKKRG0QbcEzA5UuY2JJweDZzA+0GFt5NknsC5cE7duT
 q40IAt1uoDP8xjdVww4P9FeeHmQAYJE9Fdj9u3OQPfM8c+gD2EQa0wUWBneOkPNVgKZEDXa1ssU
 npBTJ+PgkADM94O97iB1540aUM4LaMjtSrXj+hrxZNxdtr/wKEpvOT5/kd9oKyMOE3ZOnVybj2q
 7l81O8397SLSW7VXhJBoFsLfxR/NnboJzNGBWh2eV/9y1qavhEUQ3Sa3iDpmruCqc79NqIsCoij
 EN6FFF1pr8wVlPQfoEkMqF+z/984fVBfQ7Tn518ID8MN2z/jCko5QdNQLDuT5t/7ao7WhC/Al3O
 AYm2jxXjEADoXl2bzzdODlEvdotUCg==
X-Proofpoint-GUID: mcZjRKGEbDlCAMOYNSii0fygy2kF8GNO
X-Proofpoint-ORIG-GUID: mcZjRKGEbDlCAMOYNSii0fygy2kF8GNO
X-Authority-Analysis: v=2.4 cv=EqnfbCcA c=1 sm=1 tr=0 ts=68e4e993 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=KKAkSRfTAAAA:8 a=MuNeFZabic1NT7NxDHkA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040001

On 10/6/25 8:37 PM, Neil Armstrong wrote:
> In order to describe the block and master clock of each I2S bus, add
> the first 5 I2S busses clock entries.
> 
> The names (primary, secondary, tertiarty, quaternary, quinary) uses
> the LPASS clock naming which were used for a long time on Qualcomm
> LPASS firmware interfaces.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

There's also a senary (6th) I2S bus instance, which there is no reason
not to describe

>  .../devicetree/bindings/sound/qcom,sm8250.yaml         | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> index 8ac91625dce5ccba5c5f31748c36296b12fac1a6..fd0d7a7ddc7b363a66e1e7bd72c7290666efb511 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> +++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> @@ -64,6 +64,24 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/string
>      description: User visible long sound card name
>  
> +  clocks:
> +    minItems: 2
> +    maxItems: 10
> +
> +  clock-names:
> +    minItems: 2
> +    items:
> +      - const: primary-mi2s    # Primary I2S Bit Clock
> +      - const: primary-mclk    # Primary I2S Master Clock
> +      - const: secondary-mi2s  # Secondary I2S Bit Clock
> +      - const: secondary-mclk  # Secondary I2S Master Clock
> +      - const: tertiary-mi2s   # Tertiary I2S Bit Clock
> +      - const: tertiary-mclk   # Tertiary I2S Master Clock
> +      - const: quaternary-mi2s # Quaternary I2S Bit Clock
> +      - const: quaternary-mclk # Quaternary I2S Master Clock
> +      - const: quinary-mi2s    # Quinary I2S Bit Clock
> +      - const: quinary-mclk    # Quinary I2S Master Clock

I think a single top-level comment saying "mclk" is the master
clock and the other one is a bit clock would suffice

Konrad

