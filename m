Return-Path: <linux-kernel+bounces-820860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 015E6B7F817
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 269AD7BF6B3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65321306D54;
	Wed, 17 Sep 2025 13:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hjg/lh2C"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C62D1A76DE
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116461; cv=none; b=TKQQ8p3BlgISb7zQJY/yusWQbDnG//uonZiRDRvQ8lUO4KrQo6TFAOEAzZmGiLEsgJ/vrrFAwk1txJsI92ZZPeDm9azuMdfMl4rYFmchpcbJFRPIchq0Jl52CLfXkeG/f7wFVSgoPCmmAa440NztyTBL86nKCl+f4tD39uw+7r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116461; c=relaxed/simple;
	bh=EGQp1MRtDaRdckxs+Agp0v3ZnZQQydi1Ok1ET00C9Kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZXp4K28kPFs6hGv+iDEE3p4fNTZe+13m/c/UxEn5C7eH9cColrdvFfmCzHkUYHZcDiQ5wE0eQsGaQcMn3HMss2VEkju+9RyJEnknGEUPmQAjhHC0YKDpLBuhjuEjPcr6o0saFUxbWkhPnIXtpkAeuITP/Jwo+MuHrEec/6iq3pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hjg/lh2C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58H8Y3mq020577
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uZP2ryaTODrIgPU66w8ts5GJRn4q2asi0s3U67c1cuM=; b=hjg/lh2CTsnrdijW
	6F4PyhE9Gun6SYCCnH1eNSAo8BCAi5zfd9rbVj0kQtiXuGYhAOPfXxzhYIWNKkVH
	rNoyKYf8d/xAHhqNBgTezT4aSqxJFS+4/tipE6o8W34nz1d1g/9L3ZM3lcszhRQ1
	sHULb9pfbwNn216Io07Ka/7+6mUzX0bo9ZTHKW4KojJ5M+s5bjh1X2Awwq+nHwUH
	ZQ4pwqL0YxrkAld37EmwnUuSQFSF9RB6h7YCGc3AB5TUnNN+ePzGQjlLYynyRAw1
	rUAxhobXeguLVYEenmxWoKXTBt01yzVaeEPf3hCyNycr2b2JkYn7OZgLes1Z49YT
	TZr+vw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy1thtc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:40:58 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b77da4b375so15731791cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:40:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758116458; x=1758721258;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uZP2ryaTODrIgPU66w8ts5GJRn4q2asi0s3U67c1cuM=;
        b=kSXTVttV6rQoCyirEMo6PgdVuh5TzXq9t+Es2mrUBvYdmzGVfSQ9KFj0ZI5QHdxhNG
         CPFCEQEoZC535Pxb0v7z2dvLqO3f+8zfkzGSWuXWAYaBBb0MoDX+pCvxu5BpEEqIyFzc
         f5mXVgi8zcJiCcP+ia0Wo5HJa5YCNL2rJRTaaYMjC1ewQR3ulXAJGsoEjir/Eza6wph9
         oVzdSXWjPCfg/oBumifmtsychbQcQUOQV4KoDRyVD/zVXKzY2aKHntN1PvtNh+3LB3cW
         6z/aHft9V+sHoiZ/wgQGp9N+j0Y+UMP0jxLtHUOakf2wNztswHUeHwGRBtrseAd6HIMP
         ZBsg==
X-Forwarded-Encrypted: i=1; AJvYcCUVCVcg87tgS+/Bm97VH7BpRou8T4dt+s26MGgpLHxjeq5WwWvP4faNScNllBJx9mAjHK16TnHuMoYXGTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcTHWGmw6mHVIRnxE6otKpgy4yTxEWBGmKlUOxNjM37ibCww4C
	a0/slYErE7CWMBADOkITzzJjpcyZTm4/wqkvjMRfY9UtFLDYJCaN90xGsbS3sKB6Vl8Moej+q38
	8R3Luy0C+AWd8Tak8rohTpfknd7xk0KtoubAUWC5ZBukoIP3fPESBiaaD3sJgkvdtcXA=
X-Gm-Gg: ASbGncvgZBM93fCEgMVphJpJVqFZsELJCIyllfpc+AxztpaPjx0VTBiBH9jsakjTo1i
	q/VwRTuOufjc3p5LYFUO+M18DFCa1EVD9zCI9h3gcOUEI3rsQuzIjkM/Jf1x1u7o6LBXBbmPWRc
	sJnQlMctutJyT4HP8VeTu2V98s/gLWkfE2UpCXGUyU0Cwh92w/I80E7aP0IKRjT+dubCS01X2uR
	NsHvEXSOGXdJVfcyaAp0Iy9QbvToN4D9xHEd3jeeUtlS6jxjSZ9KdQ1bG/rI7iYnxB42/op5hQ2
	8aYA96duKYXWDLEB1U71mMm8cq0z7exi1By3LQF3nAS07DYxJUguo1kj+dmHoH5rWZ1LXxqDPrD
	CJp8w+Caaj78azl/vyk5IBg==
X-Received: by 2002:a05:622a:1393:b0:4b7:9ae7:4cdd with SMTP id d75a77b69052e-4ba6ae98dcbmr15405091cf.8.1758116457926;
        Wed, 17 Sep 2025 06:40:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn9y6LGOJWtKLeHHI/lFu4DzeuqWqApyHZRrv7JcmDAID8zEmPUkQuNhNoUxGWDZ5xZBVV7g==
X-Received: by 2002:a05:622a:1393:b0:4b7:9ae7:4cdd with SMTP id d75a77b69052e-4ba6ae98dcbmr15404561cf.8.1758116457196;
        Wed, 17 Sep 2025 06:40:57 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f482a3153sm5597320a12.0.2025.09.17.06.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 06:40:56 -0700 (PDT)
Message-ID: <4428ea30-7324-4faf-98a6-b18eb16f9fc8@oss.qualcomm.com>
Date: Wed, 17 Sep 2025 15:40:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/13] arm64: dts: qcom: sdm845-lg-common: Add uarts
 and Bluetooth
To: Paul Sajna <sajattack@postmarketos.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Amir Dahan <system64fumo@protonmail.com>,
        Christopher Brown <crispybrown@gmail.com>
References: <20250916-judyln-dts-v2-0-5e16e60263af@postmarketos.org>
 <20250916-judyln-dts-v2-2-5e16e60263af@postmarketos.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250916-judyln-dts-v2-2-5e16e60263af@postmarketos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: tMo5kkVFE4EriKd2LF7PTzngyKDbbsZS
X-Proofpoint-ORIG-GUID: tMo5kkVFE4EriKd2LF7PTzngyKDbbsZS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXx377aLLTQUaX
 3qsXPcXYRGRKjFrpFvdU68IYDZg6yQIyN5Y7mslqptdyZesA3h3sAnvr8UEmJHMUttOuG90WLVQ
 HwAtZH1FyC6SXqR1x4P7m8S7/2hGv4uEAv/P9Do1nlkXx4AZAOSIS0ikCkZtL5aDGoWHgAJnz/7
 DfKny2Ep0qepT6MM8+x+v8uGC59hCZVJZ+7oC7v9Ujp3vV15Jb/xFjdnOpmvymXxpPeeltj6qZe
 mB9ZWt9wu8qlAeC8oRPPXTvU5xvBFvQIr680PG3hcMTK8mwBbR+Ym58Em1JUEGKZpHXlhJah7KS
 LD/kWXQHAziLrBwLi9uz6Z9dWcBM4diG06mO7zKTOqrniKWIj06GQFD9mQE3MwBZtw1IOsWLWfd
 srGFHbJh
X-Authority-Analysis: v=2.4 cv=cf7SrmDM c=1 sm=1 tr=0 ts=68caba6b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=Gbw9aFdXAAAA:8 a=BZiE_1MFHw7nqvKuBP8A:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=9vIz8raoGPyDa4jBFAYH:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

On 9/17/25 3:09 AM, Paul Sajna wrote:
> uart9 is debug serial on USB SBU1/2
> uart6 is bluetooth
> 
> Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
> ---

I would imagine the SBU uart requires a jig or some other config..

Could you put that information in the commit message?


[...]

> +&uart6 {
> +	bluetooth {

It'd be better if you introduced a new label for the bt node and
referred to it by that label here

> +		/*
> +		 * This path is relative to the qca/
> +		 * subdir under lib/firmware.
> +		 */

This comment is a little redundant

> +		firmware-name = "judyln/crnv21.bin";

Is that fw different to other SDM845 LG firmwares?

Konrad

