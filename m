Return-Path: <linux-kernel+bounces-806307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD18B494DF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBA5A189EFF7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812BD30EF81;
	Mon,  8 Sep 2025 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JWP7pwRJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8243030DECF
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 16:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348101; cv=none; b=CdIIm8zz73PbX9QN+AL9OvQSQhdsnkxnraIGGZ9fiHiJ/87F8wPeE1MtOwjdyHvK2ATq9h1S92eH0S2C0vFKlQ9cwPhCNc5wmoxsmXyLxLZExX1maThSINnY8tObCGvBn0eqpvjvSNZcPFgVsymCeapW9L7qMGVKAwZjLpDvS4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348101; c=relaxed/simple;
	bh=my2J7ZSJKgwOGws1Hzn3zA5jTkV8FObsyOMISQJ3baM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fESlTsxB/6sOYxeoqZRMsheFsksY+FBt+CrC4OWRsar2ddAs9L0hKhqeZNyoDDESr76n8Ceh2y4DIcQHg3cdyNRs2R7WLraEcC7j3onx7JtXYpm1mwltUcQDjRrGjwSxY4E0u2/MVqqz1hIUsnexhSv9SA1iAyQGTkGmdS7zubw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JWP7pwRJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58890EpT019349
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 16:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uNUg7SeCQHOb1a3Kr4zUTJOlns3BsZPwl8vdQ/gvp4U=; b=JWP7pwRJqb/4XlNK
	BSNvvQAQIwgdwBtdYDtuX4xfXMrzCZkoe4s3IuBXiYQ+9P/hGqp9akDdbZ6c9dAL
	iVyB3EjQJp1Y+Gsxs8Yopt0UTQzUfMlo3jfxNEmoqvgfFjgGScLVHoHMsWjp6Rrf
	+rs7Eo2/IQhagay0vlyaCMy4JwQTpZRUiHY1oqXq2glG+jG55s2zJ+QUPVpZQF4E
	NWcB7jKWAwGmcBH+u3gTsUazNdi2+nKGBcmgLxcNMppUfgsr7Gqj6dHX3yfEBQVf
	fwaCklWz40tP12XQt3qskJTB8hHCbHFnQU80gthIPNLsD7d751jx0ExxPhkIUX1w
	BM/eBQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490dqfw2ft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 16:14:59 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b4bcb1e32dso24132031cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 09:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757348098; x=1757952898;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uNUg7SeCQHOb1a3Kr4zUTJOlns3BsZPwl8vdQ/gvp4U=;
        b=S4VNqfFyLEPMbhWuswafkakiCo+dzz2yGlfa1qgjspu8hPuG2S52R7OSsGesiTQzK9
         lebt/UiJtXaNt0tfHX6PoDVZ9uUqPSG3bBIOmyKHZLBRkBH317kOFd6CC92NjZ0slnm5
         yjWtVNrQCn2CpdrJV1p2wYusexnWeqZmjnCgJhGkVrM4iWNtncuphef52RajW4JNsPQZ
         +gLj+p+zyhdPijqHxrBcgsfhKiwqp8T8M44x6bnXKFLZhxqKNukvmoTGPYwbThlt6HuJ
         CzqiF79sR+2aGLfmB7JbzZA7JPVRwQ11JRsjCCqQ3Jl+UAk9mFgizVLsD2pDP/QmNW0K
         7KEw==
X-Forwarded-Encrypted: i=1; AJvYcCVzmktjh0fxsKdRlkJ0+JocoId2XjDcsemc2AX5hNyn83vgyrbyNKa6ApIAArUnynF8oLdDAcw90/08Yeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YziBQbIyyXrrF/Mm7VNM/Cblv9LNmRgKGncmnuq8cpZshqwnOw2
	mdYPK1jqT3iZz2PNv5AFadRhZriizTF1PACHpTadnvMA40nQTKW8xHCbAv2y9w4kcsOW0B1gI/1
	RW38mLSepefOsO1hqaD48nA1eRZyI27yloeEVWktTyAXKRIxN87z7XPUBJVbVS7jrpHU=
X-Gm-Gg: ASbGncs1FFH6CiNZWHarG7NIT1lsCpFpc1xHZPpaTp0icGd4/MetIzL2pofSw7SUaaU
	dHtoGwJOk7hO2LGo4fkrFP1ZIazWe/gsGXclRpfBDPzn4Dx6SLM5Y+MHTimUYRr8Ob2SVC/3n2a
	GL/UK769Qa/SYPDz9ShHbmigcqh9GwftheAF9A4VAE5mR2kaQEfKED+nm+ciZZL2avBw9OL6ih6
	aOmsvhIAQu4wLnC01a7O2zHs3yRvAx56jos5C7x06pe7iWwyy2A+Ny25spc3b3JrYRhZt2ZWTAN
	VSKBGkLwiXss52u7pfemiPHCwUJ0e20GYJHChya/kOJgw+Hrg7bLkQLVsEErBgZEZAt7V1oe+69
	U1x0CxMBzjVcaFtdzZCXvqQ==
X-Received: by 2002:a05:622a:1803:b0:4b5:eeb8:9dbd with SMTP id d75a77b69052e-4b5f8389c08mr70178071cf.5.1757348098028;
        Mon, 08 Sep 2025 09:14:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEco+Q/q3RTA++gNO5I3yZ9Bu9pgiKTfiyr/MiXQ9nF5ACsplPzOWYy4LyCZQCEZJJixvAMtA==
X-Received: by 2002:a05:622a:1803:b0:4b5:eeb8:9dbd with SMTP id d75a77b69052e-4b5f8389c08mr70177621cf.5.1757348097446;
        Mon, 08 Sep 2025 09:14:57 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0307435422sm2283685766b.78.2025.09.08.09.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 09:14:56 -0700 (PDT)
Message-ID: <0583a79e-d87a-457c-8416-f3a0b240d63b@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 18:14:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: lemans-evk-camera: Add DT
 overlay
To: Wenmeng Liu <quic_wenmliu@quicinc.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, bryan.odonoghue@linaro.org,
        vladimir.zapolskiy@linaro.org, todor.too@gmail.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
References: <20250815-rb8_camera-v2-0-6806242913ed@quicinc.com>
 <20250815-rb8_camera-v2-3-6806242913ed@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250815-rb8_camera-v2-3-6806242913ed@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: qAbZGMpihxji36B3zKmU5ZdcK-v7YrOP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzNSBTYWx0ZWRfX36JsD3MoesIp
 KiQ6bSLPkoKGI8aQ+yGjW58fLtEckiuYtHmI6x7drdzF6q6023qgjPZcWUOhu6rNTRNfUScBv7j
 MhoqMESfWKDIm6mZv3Y6y/wJUoszkRPxRLUiJmhfmQHMm5J7bzhJbtLbm+quu4HIbF8IlvlBwXH
 zGo9mQ6Q6PlXGqO4Hvpb4B9FMa5x22T5bw1tbEyAkfJttUpTTphw9sEqofM8LEGDFqkK7fLLWNY
 PRtl+ut5S7/BF3TNJGvAeiOaGR7ksj4hJMCp9vvE97wIEc9HmeHw79dk8hVwsmnU3xmHISk3h0y
 Bgavd+tN0nYsP+FHyLmkULVF6JLcisTE1Fb2kJSiTmuA1cgjGYebJbjGdsRfaNgzq0n3TEXt6y+
 7e6keYn+
X-Proofpoint-GUID: qAbZGMpihxji36B3zKmU5ZdcK-v7YrOP
X-Authority-Analysis: v=2.4 cv=N8UpF39B c=1 sm=1 tr=0 ts=68bf0103 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=gJbItJof4LNU2qWXpP8A:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060035

On 8/15/25 9:07 AM, Wenmeng Liu wrote:
> Enable IMX577 via CCI1 on Lemans EVK.
> 
> Signed-off-by: Wenmeng Liu <quic_wenmliu@quicinc.com>
> ---

[...]

> +/*
> + * Camera Sensor overlay on top of leman evk core kit.

"LeMans EVK Core Kit", this will also fit in a /* single-line comment */

[...]

> +&camcc {
> +	status = "okay";
> +};

It's enabled by default and there's never a good reason to disable it

Konrad

