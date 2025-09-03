Return-Path: <linux-kernel+bounces-798489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB881B41EB4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F5191B25B3C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096902FCBE5;
	Wed,  3 Sep 2025 12:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WeKZUD+t"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C20B2E7F20
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 12:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756901897; cv=none; b=iXVZjTPG+IqOkMkapznU3CezO/mNbqFrlSrGFiD5bUDmitVGZ/WQsROu78uV5dwbVYfEb4BYnSt8WqmeWxkZMAU5p9XzcMbM8RYvuiMBsqDoNnQeeB4WLjuAXIuYPwOD434rgb9ZnGjnqLLv5kxwzsWlbsJck2KJksxPcXJBaDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756901897; c=relaxed/simple;
	bh=h5MwF6L1pjz2m1cXTQs903RhWTNIphI7ZF58yr9PH6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GQe6WvvIAtFIFEjD4URJ2Tg7lhYuPV28UYh8VSXx8eYlxC4BuJWiTLp4Egd6d8ehlheHQrqGdozK6CRLKGpCbHBiTqi4p3a1MtoJDcJbGUQIx8fCD6/ZW1jm04ThMmoL/ixTCIwlGc1KIdPPI6X6zCahaq+OVickLlBga6z11Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WeKZUD+t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BExAr004951
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 12:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AutDsvD16EOr0OTgbsZtdjV+hXDkbazkLSfLhhee5as=; b=WeKZUD+tSWL6z40p
	46t9ccDzdqNz9IhWmGqyqH5aDLYGYQJK+DPJ48xUKg32UdsD2jGpejoet7Uk2+gO
	ETQXNDwF2wohwDfUVpr8bqrlIga0Mzi9jSsdrVd5+w0jELoajzvf+WBwH5ryFxVT
	ZAulzIWcPAtqxA04EEEEavRIfla0Dc6VWQRH/iS3lLKm0McyXimvMwNvxH5YcSiW
	4kfq0vPZA3oT2AQA5BoqPbznZm0EC+QHym7j9Z6BxPlh6fJ02Jv3OdedoZPdp9es
	PKpP30WUABusKrKe9ilMVbWz9sixNw9MGVLNkikYqE6ZAPsvd7tPdoVQzp2NcGs5
	PSA+6A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8s3nus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 12:18:15 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b32dfb5c6fso15574161cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 05:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756901894; x=1757506694;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AutDsvD16EOr0OTgbsZtdjV+hXDkbazkLSfLhhee5as=;
        b=Dl8nCF3MA8lpwYH0Nn0JAx4edXhZZ03UfLQDs3a5I4UGh5GJLRRPG09+YuuKYVqbXf
         s/qNHK2TlH2PuBGMHMVjo12VjGMsFjJ8akpsQ3CXLdW82aAQaWLMy/vcqQZ/s71DBmbb
         JsNDosAcfYBkOd/Qb2NcAkJ0G36X5M3YkyqfjRTUG/ruI5CaUtHWtLmh4vx6U8O4/VL1
         QU+OW6j5by+WJl3Y4MA1tVx16e9/6FKJEaEw7Y2tvKl98ziUDVKbycQoDJiX9sjxSzcR
         me3GCbnLXM+6yUkWgeApCHqOja2N917jKfM+NcjNHTB0zd7ohnVYi/hlyh1xRWBzqNA0
         H2Rw==
X-Forwarded-Encrypted: i=1; AJvYcCV441TI2AIuPWT7K6VebGIlWmPnVDjMEJLdjMjY5lRy3/DRMdPhzHSdgVyFDQ9NXtUW3xN16VUoLPf9gUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhaVANLcii5mJUsX93BDFXFPue7Q422SsH7AjpdpJIG6KJ7tK+
	Rr3MVGfS2bt/kJAhitIMYNRzByq/kXJ7ipGb47PpAOXBXn6jG5SQwxIHvWTHe/nMZTK/Qt/JCrs
	MOrcp9dLvkaJkjZ61Ide2Hix79KGxhtJ1OwmthbFYOwmA5dppnG5ph/sThIyXPRnboQg=
X-Gm-Gg: ASbGncszrAZOxPOCZjOrTm9gHrQPyQBcVNWGrwevGpX3ppnu4kG+bcubWPphIQa4O2I
	RnmLRCNyKSkxHlpmKuVoX4D2bTcqk9osdw+i8Yp/N4LJIGSoMwrmKilwG7x9Q8e/CLxzMpw4t7f
	UXDclvJNtPVB9/bAwatiSmonpBJXbI5n66GChTH4S6WDzIzgjh9MzX/kSqnQlHTBS0yxH/wLUoH
	3Xu3CVLcom4cx8wNCnp4c01sKdr05oXSNCEiJV/Ot+S4fGycI4NM8X9jKHOmaqFxprkhAFvuPsl
	nRXIvE1kk2EXBwwF9+qbhnA6kbLnQMYYhbp0Bl9/tFWOLfoFsZDo/Cb2x8CarpT/OAI2lwjBCEm
	XazsMcowNAzVaHvGC7eK7xw==
X-Received: by 2002:a05:622a:1789:b0:4ab:6d02:c061 with SMTP id d75a77b69052e-4b313e65205mr133752701cf.6.1756901893687;
        Wed, 03 Sep 2025 05:18:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRf8S2c7HLcbCmImimNW5RYrayUocv/8HOkBFVTA7YGJOz+PpskH2Zk0DqGoAc387ucyJKuA==
X-Received: by 2002:a05:622a:1789:b0:4ab:6d02:c061 with SMTP id d75a77b69052e-4b313e65205mr133752031cf.6.1756901892843;
        Wed, 03 Sep 2025 05:18:12 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b041f6fb232sm882398566b.87.2025.09.03.05.18.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 05:18:12 -0700 (PDT)
Message-ID: <4ac0ff3d-38db-44cc-9e36-44f9e819e96d@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 14:18:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] arm64: dts: qcom: lemans: Add GPU cooling
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Connor Abbott <cwabbott0@gmail.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
Cc: Gaurav Kohli <quic_gkohli@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250822-a663-gpu-support-v4-0-97d26bb2144e@oss.qualcomm.com>
 <20250822-a663-gpu-support-v4-4-97d26bb2144e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250822-a663-gpu-support-v4-4-97d26bb2144e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX4EuhShfy1DVM
 bhacFPq0Cgp+jv/Xq37ChllGq8YPigmTsCS1Lc/yeIeQaABL1YXjD2Q0XttNc7XEnD1OKeGa9lj
 aS9CQw67ALcm+Ep1myy5i2oTJ0E4nWCtFKQGlxlTHUWB5Wlp0WLxTUq28DP1GmNxnO3SbvHgRsA
 Wzf/382CxI+GXJ5PMHZ+L7N9L3vGYUq8vwODSkQHWh62aGu+CZ1WL4gzdgPdYDuzeXg2s8OaBRk
 lna5nrz43PvXcl8FpU7sSWn6CEfQk7vSX4CEpOEY7EEQqiSa+O1MJxA8FbbAWNjYoGgGoM18dl1
 GIWx609y3P+JDHKCc+CG9fO9xTGjk8Lc8+RtDxJcD/+HkOOwNqs8NjpBiarpWw6Ytn6a1uQ3TxZ
 iCx5eyVO
X-Proofpoint-GUID: NcjWIOSkN-GDXmMQuJRzz_mX-HolMYc0
X-Proofpoint-ORIG-GUID: NcjWIOSkN-GDXmMQuJRzz_mX-HolMYc0
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b83207 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=R3Qjy7WId1ItUu-RO-4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

On 8/21/25 8:55 PM, Akhil P Oommen wrote:
> From: Gaurav Kohli <quic_gkohli@quicinc.com>
> 
> Unlike the CPU, the GPU does not throttle its speed automatically when it
> reaches high temperatures.
> 
> Set up GPU cooling by throttling the GPU speed
> when reaching 105°C.
> 
> Signed-off-by: Gaurav Kohli <quic_gkohli@quicinc.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans.dtsi | 67 +++++++++++++++++++++++++++++-------
>  1 file changed, 55 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
> index 8eac8d4719db9230105ad93ac22287850b6b007c..b5d4d07b2fd9c14a6f1cc462c695e864394cade2 100644
> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
> @@ -20,6 +20,7 @@
>  #include <dt-bindings/power/qcom,rpmhpd.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +#include <dt-bindings/thermal/thermal.h>
>  
>  / {
>  	interrupt-parent = <&intc>;
> @@ -6816,13 +6817,20 @@ trip-point1 {
>  			};
>  		};
>  
> -		gpuss-0-thermal {
> +		gpuss0_thermal: gpuss-0-thermal {

You don't need labels for the thermal zones, just the trip points below

Konrad


