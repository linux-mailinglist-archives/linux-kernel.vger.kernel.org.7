Return-Path: <linux-kernel+bounces-875666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A0EC198F6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEABA4FB607
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C961324B12;
	Wed, 29 Oct 2025 09:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lPcOsO4r";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MaYIfF+k"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC802322547
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761731997; cv=none; b=XYGsQZvIvmsHvAigirRgWWGMe6D8G7Exf/bxPIu6AisVCALkIb2notoPpBmlVHVWpCvh8rFNWoM1y5xh/HP4Mz3UiQfm4aYdp0I8mK345NNb1654/YD+wl5UYJ2GXKvUJQR5RBSMHgtkhL6nv0xXuRHzTgCCEVODEkltxJgwTbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761731997; c=relaxed/simple;
	bh=uRU+W5tm9ZeihGOSXH5XGdcCxMKq9ZF5PCIreGS/pso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qrvZlZheI/0XmIjGbpoFStFCuYjaGJe/kch9Ze7rxtufdSI+dpIiSZEfrQM3BPoG41UHSsvw5ySBoKwyMJq3pZcMMeTmF9D1P/2qh9XjDNxsiyMVuecqRJoZtoh/p9m0W67pG+jZ7Nd+bo91IMsJ/xBL1UkOfBgDZhn+CS3RY14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lPcOsO4r; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MaYIfF+k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T93B494155405
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Piz8rod4lz0FtmBYgSwSVPwpSZnz6NSh0sr50I+nrGU=; b=lPcOsO4r3SX6Ym/V
	XyPlofVFzvTrGI2l0UP5NsYv4j28pOhXcDNyo+1K9h4pcDMI8F/eaA0IrYvwiyyH
	ju/qnQ9MAPGJnMTXHV+I/tFOs7/EDWeklEj5SQqnvCn75dAmpeNCchuAdibM9iMJ
	kntrb2Ym0p+c3KKy1TDAqcNw4C5FUNycUxeN0/Th55oUEGSrcM8QjRLNz/io8uJ5
	AF9LsxT1iG2g7SAD1DGviacyfguXDCzx2vIMqLO4Kf3oG3JKehZA7QPJB8H3Wf8Y
	L3Q2ufs7iQDOsjrsnJnunM1jhwXVerjc6Zzba09+Src16zAcPIUKa/0d4eSQ6nmM
	Nm3+kw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3fy0r65m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:59:54 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-267f099ca68so14524685ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761731994; x=1762336794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Piz8rod4lz0FtmBYgSwSVPwpSZnz6NSh0sr50I+nrGU=;
        b=MaYIfF+kvDP8KSSPukHn6J+AA2+Ttvok00Qza1bbiKrP/AaMucMRpy336uLjopMNXL
         zJa8sXhY8wB7349H6E0cKFnObk074AmxZEJ26YlhxiYsrH9Zei8BXHXpLGFds2rahJYR
         hHfrUZDtJvslYdkB6eOVw4yQTFwMixCnPCrNutT5tqcU6QUHd86xGWo+IYh/hOo8JvKK
         40AA1/S2X9M9TrWmIUy03SFTqqeX2L/KLSyuo0fncF485IfRpo/uIgMuj8ZUW22telcC
         9kt1qN2JQM4KQk1r5+gSt4o+6oM2s5i50295na4U2UN67DqQhg5jBMSlYWqGe/rUEBQY
         A6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761731994; x=1762336794;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Piz8rod4lz0FtmBYgSwSVPwpSZnz6NSh0sr50I+nrGU=;
        b=nhj3UY3Ud0HbaWCtWJ9skF3vSK2DTWsTP3Yiy/7jvstlt5P8dZWXefV8W//CRyxf+k
         FNFAvqXp7ObUicy7aFgylCiPcjgJYM0l0jT4XHz/MtqA75GEm0cGvTHSQXgCCa5OFwQK
         ZULkZt5BFOJsxMKafpUxo29IZkR0Ry3JcRV1g55sgza5UgmaDWl1R10EUCOXvz7JTp7G
         pp5cQxoOf7FRID1z1P6wyO+UTt/t1mDRE9oX2lQN8ODU3u0PV/vnk2F7Kv6uGzTGC6nK
         j9TiOOSqumj1rDBltpKhJHWjNM+s4xb0dvso+TJRMU6tT5k7+yXy8oif5SbC9UevOgHs
         LunQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgkxvuw9ld+dCcsfl6WcILQ8tm0eXdSFurS51fZ4+eLQHHxPdMm5dyWCF7EO4Oi5eKt2FTT94fU9H6otI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP4YwJhfXFrLarnE95DzfWUYTiOKjOcMLOzhTY+pjOThAKNmcn
	ldcygT/DdAeyDfQZoaFSaTWsKYnFt9wPMcG1B3o1/3HTS8YrOqs9ZRukP0ebAkwRStUT3KO5+vO
	eJrrFHL+HruklbhNgP4gXdwYkbCF898/i0pjk7Wr25ewuweCb7NMCJ9MPGK030f6FFPw=
X-Gm-Gg: ASbGncuHb07qJJz5XWAecp+WrHK/sTsA+eaIG9CBIOs0nhobfupxhY8VNyhnlOEm343
	T6xLDqonQQBhDPxyJI3uWxJnGQI4nfa0oXCNcSGysKV0WmCMfsnETnTMFy2cz9Tfbb+l/VHyKmj
	evMQW1D729YazMdWmR8Lmdva26EsGjs1iMEh1hh4TPHh8WI85rFsuuhubPsHpLSZDvPsGmCWqlR
	804+wBXglboBD9Tj2ynYKM1owfhrRrxOo/MGLpOnl7rhyjl2f3NCG2o4/Faj8knzlMC7ztEBwOA
	UTIE4xQJhKl4UKthvCvv/6nEPGcg1oqhsS5g8fqnwgttQFdCpe0G/ibi5feYAgjPfrP5R6xT8aq
	/qEO+H6h3iGoLInkZxQRPitv3IdEfLvIqU/ViFghLdr3X3cvhXIIsDZ7mRwovSMoEs92Iww==
X-Received: by 2002:a17:903:2f8d:b0:269:80e2:c5a8 with SMTP id d9443c01a7336-294deeedda7mr15829105ad.7.1761731993608;
        Wed, 29 Oct 2025 02:59:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4z4olbHvLZYuxygnDrTvnj3GVSCIDXrQfTkLlCd2lWeeIOL0S3gFqI+0DsjMVOy8PFkbqAA==
X-Received: by 2002:a17:903:2f8d:b0:269:80e2:c5a8 with SMTP id d9443c01a7336-294deeedda7mr15828705ad.7.1761731992999;
        Wed, 29 Oct 2025 02:59:52 -0700 (PDT)
Received: from [10.133.33.251] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d2789bsm144130825ad.62.2025.10.29.02.59.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 02:59:52 -0700 (PDT)
Message-ID: <7fcbb624-7c92-4043-b5aa-0fbfd3dd125c@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 17:59:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] dt-bindings: display: msm: sm6150-mdss: Fix
 example indentation and OPP values
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com
References: <20251024-add-displayport-support-to-qcs615-devicetree-v6-0-c4316975dd0e@oss.qualcomm.com>
 <20251024-add-displayport-support-to-qcs615-devicetree-v6-2-c4316975dd0e@oss.qualcomm.com>
 <ggrtehmzg5bajbglcjhlf5jynhwqq6vztc2fqwxxgip2q3vmip@t72qcggza2or>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <ggrtehmzg5bajbglcjhlf5jynhwqq6vztc2fqwxxgip2q3vmip@t72qcggza2or>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VJLQXtPX c=1 sm=1 tr=0 ts=6901e59a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=v3LxePKqoqSeXojOrL0A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: Ah7KRN6qIYRpohqrPdihXgyfuX4VDKPy
X-Proofpoint-ORIG-GUID: Ah7KRN6qIYRpohqrPdihXgyfuX4VDKPy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA3NCBTYWx0ZWRfX9nW5LAZwUevc
 2Sw+/CkrU28+ajFa8QFcx0gWW1ctgBStAUU6B276NcfrCbr3MEzTxv+G8z3mYapi0cnJWRD61Ei
 AHjJ1Q9cN2mBmGszVTG6hu14hdi6+GRSqiTh9IMqfJYi9Z2i0xrNmiB1h4cEvGJ1Yol/M2qptAd
 0YCnJb7FKR32rEoBl4RTb0yaRxtMT3dDgOSm9JJ0DtBjX0eEgOCs3Z01Yj9Qcso5TGCuZjxkFJu
 eOQtl/cr5Ru+h6ULHluE7AMmHv8XlKuYNID2ORPku08caHuxTtfsDUbNYqTR1Y92TclwLUGLsFi
 inX2gePTHSPf5b7zRNFHGDUlTgLHoC6WqB2Is1ld1WWoqP6m7qb2rfQRZq9GYlzwBp8iw+2d404
 CqnZcO7tehbbBzfNKGAM/aUMPq735w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290074


On 10/29/2025 4:00 AM, Dmitry Baryshkov wrote:
> On Fri, Oct 24, 2025 at 01:21:02PM +0800, Xiangxu Yin via B4 Relay wrote:
>> From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>>
>> - Adjusted indentation and added missing blank lines in the example.
>> - Corrected OPP clock values to match actual DTS configuration.
> See Documentation/process/submitting-patches.rst to check how to write
> proper commit messages.


Ok, will refer guide to update commit msg.


>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>> ---
>>  .../bindings/display/msm/qcom,sm6150-mdss.yaml     | 32 ++++++++++++----------
>>  1 file changed, 17 insertions(+), 15 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml
>> index ba0dea2edea98cee0826cf38b3f33361666e004a..80183df71cd9288f652dc42afeae101e8edcbe65 100644
>> --- a/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml
>> @@ -140,35 +140,37 @@ examples:
>>                  #size-cells = <0>;
>>  
>>                  port@0 {
>> -                  reg = <0>;
>> -                  dpu_intf0_out: endpoint {
>> -                  };
>> +                    reg = <0>;
>> +
>> +                    dpu_intf0_out: endpoint {
>> +                    };
>>                  };
>>  
>>                  port@1 {
>> -                  reg = <1>;
>> -                  dpu_intf1_out: endpoint {
>> -                      remote-endpoint = <&mdss_dsi0_in>;
>> -                  };
>> +                    reg = <1>;
>> +
>> +                    dpu_intf1_out: endpoint {
>> +                        remote-endpoint = <&mdss_dsi0_in>;
>> +                    };
>>                  };
>>              };
>>  
>>              mdp_opp_table: opp-table {
>>                  compatible = "operating-points-v2";
>>  
>> -                opp-19200000 {
>> -                  opp-hz = /bits/ 64 <19200000>;
>> -                  required-opps = <&rpmhpd_opp_low_svs>;
>> +                opp-192000000 {
> This is not necessary. This is just an example, so it doesn't matter,
> which values are actually written here.


Yes, but I think correct value is better?


>> +                    opp-hz = /bits/ 64 <192000000>;
>> +                    required-opps = <&rpmhpd_opp_low_svs>;
>>                  };
>>  
>> -                opp-25600000 {
>> -                  opp-hz = /bits/ 64 <25600000>;
>> -                  required-opps = <&rpmhpd_opp_svs>;
>> +                opp-256000000 {
>> +                    opp-hz = /bits/ 64 <256000000>;
>> +                    required-opps = <&rpmhpd_opp_svs>;
>>                  };
>>  
>>                  opp-307200000 {
>> -                  opp-hz = /bits/ 64 <307200000>;
>> -                  required-opps = <&rpmhpd_opp_nom>;
>> +                    opp-hz = /bits/ 64 <307200000>;
>> +                    required-opps = <&rpmhpd_opp_nom>;
>>                  };
>>              };
>>          };
>>
>> -- 
>> 2.34.1
>>
>>

