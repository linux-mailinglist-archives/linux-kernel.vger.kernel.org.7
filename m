Return-Path: <linux-kernel+bounces-879177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A04CC2273F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CABB14EECD6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F79330B1E;
	Thu, 30 Oct 2025 21:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ue3Nl992";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bzpy78OW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287CF524D1
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 21:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761860718; cv=none; b=O0yHWu4FyfinwaZOPD8Mf3Y3vq+4uMARgm+6wupVFZnAmcmzDkM6toeHpo5AOyX5fu+MJF1BQyYRGuf6J3q0GRQnVcDYE15LV3Kys92DyCP7z4neBMZcAWWyTJApa1V68yhoHWLjtdGPbhoW5tfNzmodsb7rlg1IL9dFZbAXKEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761860718; c=relaxed/simple;
	bh=yoJyzRpSCCIReS9JjsFWUlo+3vKaeWCXo30gNMnXofg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q8tm/FCBzfamKo1MgfHUM9txSpP6SsrxCfQWX5g3FVV0YnYGpABKqG8v25D/fWD/0wPZDyUFf1UKI2TFXwPioN/IbrTZlPLItWOEJi3/5tz9uM+PWwFjU+3WsqezX/ixalXiSoBn2g3ItXqebHgWnBaEAbctz0GPjZvFIzET2C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ue3Nl992; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bzpy78OW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UFERjC084000
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 21:45:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D805xAVnHSLtQWp6QWfqoMXrGvEhPuuHYPMCcOzODRs=; b=Ue3Nl992P1vXTS7r
	2Kr9PRYarDt6PFsjHetNQJ5iXRjWthFw7vUr7/Cls5DA3qkatjX9sLs+B5ulKmt7
	2A2DApK7uQ2OJdVT00r6dNjs6P09QDLkZzTGEo0l+e3/qyXn7Kg7IaCjKIJW2dz0
	VlBMNhr+J1rWFYgJhC4QWZCCcGno3k0k40leCOUM1B2Xzdzg/3agIZ2Up6gN7enP
	WVK1GhbbDq8OcC736Dxxkn+O8Yx3pUUWkLJb6Rov6Sb7YNfCdEMYSNKKT4VgdcV7
	WFeb0eKJlZRimkoWzqt8hPs1cDc/JYvWUsMqGkdiktiCXzZpK8/BWdNie4YvCvs4
	i1nr2A==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ag3930u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 21:45:15 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87c2085ff29so41983216d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761860714; x=1762465514; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D805xAVnHSLtQWp6QWfqoMXrGvEhPuuHYPMCcOzODRs=;
        b=bzpy78OWKx/dBbU9jXd7xVIkn9EqWIy3tfc3nvjAVHoCXSRYCVxDGfBQx4WyjyKaPg
         FqytnF0WNlB+w1Ru5sK3bSNslSrqvrCmWnjb0h/qlPnetXpK/xc2FgpHvB2pa1lBSACS
         hFMR13yNtT88mZchubyidy6nkzNcv/LQCKeH+OJUp3MJivDztkUCC52YhKlG0ZWWWNMX
         hiqNu1s/e1EmOgjK3oWAf/S72NFJmXSv+gT48B2BjilGYMo8oXwPJCf2FjDr7OEhSJoj
         /rbvqMY4YNCT26jxG+dhVo+cn+BzyRnGRxPPC6RWEl0d9isXb9JPg9o+mWBCSR4bwAqY
         9JWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761860714; x=1762465514;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D805xAVnHSLtQWp6QWfqoMXrGvEhPuuHYPMCcOzODRs=;
        b=nzGo0dx6EI93kJNIkQ80N2+RXqLSkpFGYSAnxxBAqt3oe3z/TNyyo1c1dDSF4IIGuP
         UQkFJD9ErGAVklIa3vX6ihZ2VtUjzPAa/t8POwpcJvp1lEAQXgJJwD8FnjrEHOLTdLwN
         Er/9QJNGwCpJ9JQIghN7ZaVgxkC26yaTMcTRuOaMwWBTAcSyL6VZeQVaYUQXnGfa0hiJ
         V5TfTzJZfP2TEfin7niM4RjAxOGOCMc8VONSO6GSm/Z1/P5HoF8Wkgk5vndYcu+eGojH
         209YBp/cSzb5l7wIRSgUFMc0rLiJPtSx4J4OjPobWhs5HOgOi9MR9G4LJ8r5BzLCoT+K
         YE8w==
X-Forwarded-Encrypted: i=1; AJvYcCXFqGoQb3PUn2HhNWt1jsxc72LVBGpXWEDFG1qfyllvN+gpHgkO9YBIPg2AetjiE2njQtshFZcY1LExUFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHveNCJSJXIhkqYbk90jmAaolK27QWhI7HzcmmWnRPht1ZZYY4
	KCdFmziO/AUktvs1H7YPkKhsezM/4Y1TyyjvMIol2rRGEQTuD5N2gmQjYImZl2ncwdYj4eD9N5V
	yIKIdQCFTAnz83+LTdmkCDF6t36/sc++vZBdgeW5sLZDChJFlVssdgmwywZljqy7o0hk=
X-Gm-Gg: ASbGncuo4eJqxoqZ9Z2xRgRKN+HV7dK+YYbg3PNnLnxQ9exMahzOCirnu/ZgzPFC3DE
	wMerM0aMMnlzP4jvteuQeTCOl2w7KfA2geXR7JhAmIPMOz/weZ9tH2zRd7uvefmOu50snZn7j/p
	HvxON7c8kGE9HegQPicn++/Eqnu0MYoQ2x/kbGvOFfvlJnwR424sQTIYHhUeDyJbhtYjkFcMu3b
	XPKf1RXW7bgDxScOgA3kwuvqu0m3RiP5cXgDBKN5zD+FgM6uReR9Dyid8eXwDzhITVEJL/3VFTq
	5qVQrZc1KNsPHM2cQhmHLdUTBrlze1u+mm19L4UpgVH5SdFYZIZBNzzydunWTGDqj0E2gFUK3V/
	oxiumzDW367j88eeP7JnIqg6f9g==
X-Received: by 2002:a05:622a:5a15:b0:4ec:fafd:7605 with SMTP id d75a77b69052e-4ed31004db9mr15212941cf.60.1761860714349;
        Thu, 30 Oct 2025 14:45:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEH+HqEuczJpMlpDDzdccuf2/KSeYvFUepMCMr+zEaProU5CUwiZbOCeHQ214hDIAAxXqCQ7w==
X-Received: by 2002:a05:622a:5a15:b0:4ec:fafd:7605 with SMTP id d75a77b69052e-4ed31004db9mr15212691cf.60.1761860713800;
        Thu, 30 Oct 2025 14:45:13 -0700 (PDT)
Received: from [192.168.68.121] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-429952b7b43sm34225050f8f.6.2025.10.30.14.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 14:45:13 -0700 (PDT)
Message-ID: <d51f38f5-ff04-4dc1-978d-ad8ee6908836@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 21:45:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: dt-bindings: pm4125-sdw: correct number of
 soundwire ports
To: Alexey Klimov <alexey.klimov@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        broonie@kernel.org, srini@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, perex@perex.cz, tiwai@suse.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20251029144636.357203-1-srinivas.kandagatla@oss.qualcomm.com>
 <DDVYM9SMCT7O.17T5SIB9IEED4@linaro.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <DDVYM9SMCT7O.17T5SIB9IEED4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE4MyBTYWx0ZWRfX5zI1pRw8vERr
 H1/+dimY/GsJntPcHqzL03jgN9Pm+k7ZYdD8zRtsKWZ62HF5xE0OF7/uzhSTMuJuC7ykO9bznNU
 /jyJFbtTnukI5Bjle0lHpw/HID7KjwGab8/fhrpU3bc5zEJ2gQBv6Zm2uDwt1GwbqnFJzJJOV6W
 golGrmY01VNQzg14zPtgIWe2N/XfKmBSrgUCSMibQLlQaMPcyXp4DCZ3AHe40Iu5RhkBMg8D29p
 oHNecg8b4KR3wg29QMmjJevE4Gd0rLS94lYhxj1q3kEHEcRuNPqW1xlmbd5BORdmRFk4mnm7r+S
 o5sHgStu/vaya2XDpFlOqQuveRYUtKpYw1YDPWp9ilCzrQuaVbBYK3FlbGkYJ2VunWEyBgkLrDn
 F2ZNJmJQDQ3iCsSfIhNAhlnVbcFiPQ==
X-Authority-Analysis: v=2.4 cv=TrnrRTXh c=1 sm=1 tr=0 ts=6903dc6b cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=cZRtUSbEUlCTYNoyqfMA:9 a=QEXdDO2ut3YA:10 a=-_B0kFfA75AA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: xQ9Shu7Mat1EBsuXElCcUfS8X9d0mlkk
X-Proofpoint-GUID: xQ9Shu7Mat1EBsuXElCcUfS8X9d0mlkk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300183



On 10/30/25 9:03 PM, Alexey Klimov wrote:
> On Wed Oct 29, 2025 at 2:46 PM GMT, Srinivas Kandagatla wrote:
>> For some reason we ended up limiting the number of soundwire ports to 2
>> in the bindings, the actual codec supports 4 rx and 5 tx ports.
> 
> The reason is quite simple. The available _limited_ documentation at that
> point suggested that there are two rx and two tx ports. There simply
> were no better docs.
> If you finally got access to the right docs then it is good to fix that.
> 
>> Fixes: 88d0d17192c5 ("ASoC: dt-bindings: add bindings for pm4125 audio codec")
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> 
> You should run get_maintainer.pl script when sending patches and check who
> should be put into c/c. See [1] too.
> Here you should run smth like this:
> 
> get_maintainer.pl -f Documentation/devicetree/bindings/sound/qcom,pm4125-sdw.yaml 
> 
> or check with b4 how it works.
> 
thanks Alexey, for the suggestions!

--srini> The c/c list is not full.
> Perhaps this is a consequence of putting all Qcom audio related things under
> one entry in maintainers file.
> 
> Best regards,
> Alexey
> 
> [1]: https://docs.kernel.org/process/submitting-patches.html#select-the-recipients-for-your-patch
> 


