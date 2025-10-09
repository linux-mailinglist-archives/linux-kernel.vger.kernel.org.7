Return-Path: <linux-kernel+bounces-847098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3AEBC9DA4
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 34577353ADF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3260B220F3E;
	Thu,  9 Oct 2025 15:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V67TbqKb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB01C202976
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760024897; cv=none; b=AXTjWXMk0ldGrFlhBt8/nSUB4+9KY4qojxwfDVsOQFc4U4+v9flAw7kcbHii7n6+IDjpCHsDlK6rH1RcvYNX5/OZ19fbD8l08O6T9NAcBVJq41hGT4ZyZI6kmOatT6KzKIXD94+ytH9RVgwGll5HjS7HyYikISvKmcUEBMVOgv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760024897; c=relaxed/simple;
	bh=FdGeuY3W8mvdm/qExZJi7tpwSR8w4c9hnwnrzb4Ai7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RU92woIEhh5TmwOj4hoLxiVOTlnB1iqaIhTjoza3Ak7EzM69fTSpd6Uh1afEWOWPmoRNcHZ92rXubONzwkRzPCiz7cAqwXXMzqq8BrYriXXmz/VvntJadx1+AS3fSuqByCDw5Z3w7XMT/D5X08nhuc3pf3kj46svhyIHUOCGq1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V67TbqKb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599EVrVd012246
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 15:48:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2DDEV48VDPFYZ0jZ6QTevwjys+EA6TchZ+jUUNOGm0w=; b=V67TbqKbObMWP/4M
	bDRXummjEUPUZngwt2S7scL6LFGJRTn1vJCy/GzsfaCvyiTp4L/RvggsZ+kEMQHb
	Og9qwNi1wKP2PeOuArt8WRLI8ASsi+dSFhv2+rHv3wVYtLZo7m7lTMTntKOvlxP6
	nQ2W1atyn5SOIXpG8E8N+c1rxvvGR9tI5MlAYNgzfy8sXAdvti3vTdtcNGYjuXw+
	o1Fq5/tFIt/aUTi6WoSmo01SEB5u60fCM2i0fkOEChKcnfNEqekPbp53I87ViofP
	R1trUJZa9TzD2a5Tzbyr1/W67eCbAKfvZJV9g+IFH8LrGXF5CFqiB/DD31rdJW40
	Z/AaWQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4kkfbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 15:48:15 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-87bb67409e1so3296106d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:48:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760024894; x=1760629694;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2DDEV48VDPFYZ0jZ6QTevwjys+EA6TchZ+jUUNOGm0w=;
        b=rcMOcSGnfJml2mzwmhvzvBwto0jQYqHDEaXQmAkXkmQr3+vF04rb4424sdw0rvNjqe
         7clxc5FcttxwnjHm3uYThRkAhZ6E1itmvPEMi+7lB0kdiwrbhcjcrwtNVTUpN84KNAw5
         KvXRsviPhGKettYgW9jazgY1pXmFKczMIOAbE+5LVAqTQ8Fr9OPj90CnpreE/eGsaFaP
         Nu3ySfGzfYX3BHmDuUtFaOo0z4NidRyFem6PLJ1lNpFnmbFVB5RRNFWiywT3UcVqWTAw
         T92g6g74S0E1wMrSJBj1OCUJGlS5a84NYr8jTuKKgKT0m5SBNOQxwKHXYoifeQzv7n38
         rAUw==
X-Forwarded-Encrypted: i=1; AJvYcCVWOw1LeW8eHdmXOWv7fwJuOda/0O/YP0EW0f0R5NxIuKPG7NolybFuLq/G7YWxx3EN4NEwPLJ4Io0KfOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMd/PSjESBoSyxUdJrZQ2MeN2Gk995uoygzBdKWa3AqE/NxCGC
	5inYFoAuABm9G6oPW7/YjynXVQMpG+lfLx50whmd4ea6vlZD7EK5jfbndr/7JLXGVkn1SNKAqHs
	twfiGiEUR7xqzgkMrPm+c0kyV4Yd/b68kSwaFuZ9pMg14ebh+2fbS/9Hg5tPUMtw7CT0=
X-Gm-Gg: ASbGncvyTSfxJdDi+jI8XpgZ1L8JLskkdzfcn4F9gOG0GwoOgQOGX6lIzCVBF1l9YhJ
	Kvhu1XOmmG+mJh5iVeRzapxBxRaj5iHhM0p9/xPMbbtEFYUNoSPuAXd1ODVeeGXmyx2JnwPKQU6
	O0AScOxOj8nj4gk+HwDq9EgRua9zFT2OYW0IY6iX32669hcEReVAf2JPYKII1GVGWVw6vki4Z0w
	gg5tpyztzPrBX5V10pWyiuplBFeloewkoYcK/VzJZ8tyIX2Uwvqy88XY2WKYbHSgIqov2yLs0ag
	b90IFfp89Ujx9k5yFrlVHI90slR+IZb+XwjdyF55ERQEzln6ygxayjAk0AefGa0Cvix8ieicqZg
	BeQfuOr7jXjwSU0YHS/B65SnhaQw=
X-Received: by 2002:a05:622a:20d:b0:4b5:e606:dc13 with SMTP id d75a77b69052e-4e6ead5855emr73803471cf.10.1760024893657;
        Thu, 09 Oct 2025 08:48:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0ruy6yJ/BZlKqcZfk6p0U7R+rA71Ut4DUTipMxm2Z6tUdVKsiKhaWki3j8Ulc1YtdmunKNg==
X-Received: by 2002:a05:622a:20d:b0:4b5:e606:dc13 with SMTP id d75a77b69052e-4e6ead5855emr73803061cf.10.1760024893171;
        Thu, 09 Oct 2025 08:48:13 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d8c12b4csm1278766b.56.2025.10.09.08.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 08:48:12 -0700 (PDT)
Message-ID: <69ef6c4e-aea2-4528-9b5a-02488087ad0e@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 17:48:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] ASoC: codecs: va-macro: Rework version checking
To: Alexey Klimov <alexey.klimov@linaro.org>,
        Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rao Mandadapu <quic_srivasam@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@oss.qualcomm.com, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com, jingyi.wang@oss.qualcomm.com
References: <20251009143644.3296208-1-prasad.kumpatla@oss.qualcomm.com>
 <20251009143644.3296208-2-prasad.kumpatla@oss.qualcomm.com>
 <DDDW9FN6B097.188MIFGQOOSQW@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <DDDW9FN6B097.188MIFGQOOSQW@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dojWylg4 c=1 sm=1 tr=0 ts=68e7d93f cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=5XlMMfdK45PIep8T4oEA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: GwAi4CIFwneMiJOJVz07q2-SdzjQ_iBv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX4WHdedMs9Agx
 37rj08tthOFeYcKpvAC1uBYhwxJkK0cizhdlTGhEFxEjDzd4JPAkRuk8FqUvVJuYabT/fLpTfQy
 yskk4iMD7RcmVEDHJ6cyFLtyU1OxfXOQKkgxbIRGyPnRSIdYCUN/yPRtQg11IgFnofHNHF24SD9
 z+Gcikw58aYiDtTl9Kx+/ZfWyMyf3x+2MEHFJLRvawDdjRw7fjMy6Vsvsj3p87OPIAVqARfA4kB
 16LnDmQCIRSvqAm3Pfu9Z+dGLZN+3t+LjesYNyQFd1AKfRf6edpBZA8W9HGI7hguj4loVGBteXU
 D2nF+H3FVvMvVPPoJfPmSqF7PqmJCLhqvSMHnaUM6Z+WovIEwmC4H4+x0rAYAV7MBgY5Mr/U0q9
 UyDSDFfXMSDt84DIgo8hqnaL9HkiFg==
X-Proofpoint-ORIG-GUID: GwAi4CIFwneMiJOJVz07q2-SdzjQ_iBv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On 10/9/25 5:25 PM, Alexey Klimov wrote:
> On Thu Oct 9, 2025 at 3:36 PM BST, Prasad Kumpatla wrote:
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> Open-code some of the registers to make the checks anywhere near human-
>> readable. Error out if the version is unsupported or if the VA macro
>> isn't supposed to be present within this LPASS instance (since we can
>> check for that now).
> 

[...]

>> +	if (version == LPASS_CODEC_VERSION_UNKNOWN) {
>> +		dev_err(va->dev, "VA Macro v%u.%u.%u is not supported\n",
>> +			maj, min, step);
>> +		return -EOPNOTSUPP;
>> +	}
> 
> Why?
> 
> As far as I understand the behaviour before this change is to continue
> even with unsupported LPASS va macro version. IIRC when I enabled sound
> on Kaanapali QRD device it worked even with unsupported version, it just
> needed a fix to calm down the warning.
> 
> Why this needed to be changed to error out as unsupported now? Will there
> be a permanent damage to hw/fw if we continue?

Unsupported hw is unsupported, simple as that

We can not predict what a new hw version will bring and it's
better to have the human decide

Konrad

