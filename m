Return-Path: <linux-kernel+bounces-867855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D44C03A7A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 00:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC29A4E53A5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 22:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF83C2E0;
	Thu, 23 Oct 2025 22:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UUasmk3g"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0785B35B128
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 22:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761257860; cv=none; b=jppzFJD7te1wqr7Zi7N5bQ8eb8Cc0jC8G/OnXOTWJe/j408So6lOs+SUocFl0yOvYT52MMNjW7WTkfmYvyxIOtYDtQ9rBb+cmeXCkkD8OdMocEeUTgxoxONK6EWmtcR6oVc0AjJ8DBm+ZKDGK1wfPCmbA5AscLOSj71cONxY96c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761257860; c=relaxed/simple;
	bh=0/6mOrOgE2v/EAXBWu5EaJbxvZ9DvIvrGkrUDTUVJBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sRLfSVTpZzPPso06Rxb6gFfm0LjDAfUOqrvWwq8LMa+skHRxF8sGaAP5Y03JN8nJLcfkFfXD7dGsjPKaG9laizlKHIV4V6GCgxLHOVR9khGTdXD0waUBzsna1MltqhiV1Ri1OziaRnbCXbibxW87KY0AC5YeQfOH9viX/7/3X3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UUasmk3g; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NEVGJu004615
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 22:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eXhgsnolQuosOCqmxN7GIdRp3agVwulspfbFQ5KcWGY=; b=UUasmk3gf49mUvbJ
	7h9Zg0DoBYf71jSH/3zOhijwNaCgP2i+48GuW9H5qosi3VLTbxGHYWQUc/tBO0Om
	VoVHYzeK1ud3GNdPzLS2M+mEosafzK204m8C7oFEn8QyoCkp1Tv512dj/Ji10gMQ
	kO3YAjYEnAm6lakLFShMTXtXvLjFUnoHOZ2mb8tOHMi2qPhSuCcv14O22ZuoV04P
	1szQTcDb5kDMKNffEAzCSvHjrYqo+iBEouBsB3ODzDNLPiS0pA2BDlFFIPISg1dq
	4ECTvchqCaE7OFB7bhUlKuaDE5Wiuy7JVReKkZNV8qizgXCfdm107V4ItHwpTjQV
	5ULgJw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49yp6k1af4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 22:17:38 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e2eb787f2so1162365b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761257857; x=1761862657;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eXhgsnolQuosOCqmxN7GIdRp3agVwulspfbFQ5KcWGY=;
        b=Zs4GZyNJa8KMUkhQ6c5OuexWhkumWDSF3NAVdHpp/8jieLVhh5QaEF1CtsSZ1jocOu
         vPCBqyn7koh83bYpVG5q+FEsTXPtsfwm5ESbl3VP+ysAxAkiCVDC8S8B1467hvpuJQIG
         0OhMftDoYICet9WsXOb6lyOi9gwoG9lpOQ0qMQLZVAblTFmD8//8sEP/FbPNRoJgGODJ
         q+wr1BA2+JduPAsbUsOFB4vY4vN/L9DGerksiZ2eyEP0fCJbPBt1drW6DEIiV0BZwGq9
         QTWIfwuDdfoRsg2SXox67VSBoheJzzO9zIUkIg2EKUq9V2Nv/mvgFJWJ+df4lqHyc1P6
         E0XA==
X-Forwarded-Encrypted: i=1; AJvYcCUOzL1T45S7Me4/5xF5KYejyF4xW06YqP85GIvG3L79RhXrm0o/WWCNFjB6jUezJFhsRPc3eYZ0WBb+o2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCXLM9z6N+DAt/PTIVqx/xa0ddSoO1L8f/H3dwiTtNy250wvLn
	BaHujZyIfGrc1KnjAPbyh1rYai70wv+OZ/KT9pj7CPFyPht819w78yNZ+ul27APjm3wmR6ELqiJ
	YkrFhllqpi7heXF6IAsGj6PDMaY/FyNy/yvGpHoSvP34cYjuKznbzu5gIxyNM5Ny87Uw=
X-Gm-Gg: ASbGncvip2XETHbfawF6gBoxWQQeSqOs1t3eQOCHmucJCcQl7wIXQJwbRc4SSU21Pk0
	zECChDExaAFfY4DQlsMtUoV+J6kciXT2EaLcu8K154bZRxuTXHdSeP6U+th6LijhKIFLwT29AVS
	1SmSHQJG/uEXYpfeNpG3x4ds5+eupbaXNda2no1PlcFeRzEroQX2wqVU+WxliVSFJmYEyvCo0bL
	BQAZF73A2RaYAvHmiwvZ1ZWf9yLSxbjn8CpTHxQ55B4XX6zGF5LNUp79CSGfaVQ0iANH2OLQ0wj
	Ql+ws7uFU/uPmYQ3YsiJpH0MANwLs5wCSXLMQn48vcVlq+weHSICwLiJkdDJlp143h8TBxG/I0G
	/C3J4lrr5h/h2TxktzASISfo=
X-Received: by 2002:a05:6a00:92aa:b0:79a:fd01:dfa9 with SMTP id d2e1a72fcca58-7a286765c70mr34307b3a.6.1761257857350;
        Thu, 23 Oct 2025 15:17:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXCip3lfFlFFHAfU+3zmg9cMpt0K19PwWmMQCOg96oi40mBOKNaVibdgO92QzHjjA63GTbQA==
X-Received: by 2002:a05:6a00:92aa:b0:79a:fd01:dfa9 with SMTP id d2e1a72fcca58-7a286765c70mr34262b3a.6.1761257856827;
        Thu, 23 Oct 2025 15:17:36 -0700 (PDT)
Received: from [192.168.1.5] ([106.222.232.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274b8b32asm3691332b3a.43.2025.10.23.15.17.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 15:17:36 -0700 (PDT)
Message-ID: <25ad160b-b618-4ade-a978-e4ae56c79e32@oss.qualcomm.com>
Date: Fri, 24 Oct 2025 03:47:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] arm64: dts: qcom: qcs615: Add gpu and rgmu nodes
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jie Zhang <quic_jiezh@quicinc.com>
References: <20251017-qcs615-spin-2-v1-0-0baa44f80905@oss.qualcomm.com>
 <20251017-qcs615-spin-2-v1-5-0baa44f80905@oss.qualcomm.com>
 <fdec4bf0-6d88-4a9b-a81a-061476dd9e1b@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <fdec4bf0-6d88-4a9b-a81a-061476dd9e1b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDEzMSBTYWx0ZWRfX9oAJNtUV6LBW
 AHjhSxukUXiY2EHXFjrBmVHI9Vbt3y2NHhwlFC3vjllBmxJSrU5sb1Dwlo/UiZxbiWOuGfBxXk7
 oTrZkkXZ3sLqBKK3Bt8anX8KLJiV5gxRgZUjnCkqYf6HYJLI4GakiFdHmm9EXKAaVYS2TYv30vl
 4PC9DmNqqHhF0ynh5ruiEjkyip4RVwnRjx0wXsg3YdWJc3d4eY06veXFw43tMQIOtvg5L1JMphn
 K7GImBaK+Svazwe70xFuQtu40gUBMMcIMMiySxo3ZLoUcVoq8TXpeRVZ9PKInaGeOxf5eUlEIFC
 OeAGxCKI4GR7sP3XLNuof0LQU4AmbGvFbZfi1Dg7H+34Kt3zEBZKp2ZpCP1tynWwsJhafFEXi4I
 TbO/2HoJ2isBdV9oREfZtZzCcrVQgQ==
X-Proofpoint-GUID: gFQ2TQ12N2yTQmyHvvbvxlHrvLSewLi_
X-Authority-Analysis: v=2.4 cv=bL8b4f+Z c=1 sm=1 tr=0 ts=68faa982 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=OORdEvYNKPdDRPFHMUl15A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=bgAURMIcSi5BoiUHQI0A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: gFQ2TQ12N2yTQmyHvvbvxlHrvLSewLi_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510230131

On 10/22/2025 8:57 PM, Konrad Dybcio wrote:
> On 10/17/25 7:08 PM, Akhil P Oommen wrote:
>> From: Jie Zhang <quic_jiezh@quicinc.com>
>>
>> Add gpu and rgmu nodes for qcs615 chipset.
>>
>> Signed-off-by: Jie Zhang <quic_jiezh@quicinc.com>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +			gpu_zap_shader: zap-shader {
>> +				memory-region = <&pil_gpu_mem>;
>> +			};
>> +
>> +			gpu_opp_table: opp-table {
>> +				compatible = "operating-points-v2";
>> +
>> +				opp-845000000 {
>> +					opp-hz = /bits/ 64 <845000000>;
>> +					required-opps = <&rpmhpd_opp_turbo>;
>> +					opp-peak-kBps = <7050000>;
> 
> Are there speed bins?

None I am aware of as of now.

> 
> [...]
> 
>> +		rgmu: rgmu@506a000 {
>> +			compatible = "qcom,adreno-rgmu-612.0", "qcom,adreno-rgmu";
>> +			reg = <0x0 0x0506a000 0x0 0x34000>;
>> +			reg-names = "gmu";
>> +
>> +			clocks = <&gpucc GPU_CC_CX_GMU_CLK>,
>> +				 <&gpucc GPU_CC_CXO_CLK>,
>> +				 <&gcc GCC_DDRSS_GPU_AXI_CLK>,
>> +				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
>> +				 <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>;
>> +			clock-names = "gmu",
>> +				      "cxo",
>> +				      "axi",
>> +				      "memnoc",
>> +				      "smmu_vote";
>> +
>> +			power-domains = <&gpucc CX_GDSC>,
>> +					<&gpucc GX_GDSC>,
>> +					<&rpmhpd RPMHPD_CX>;
>> +			power-domain-names = "cx", "gx", "vdd_cx";
> 
> I think the gpucc node should reference _CX directly instead,
> then genpd/opp should trickle the requirements up the chain

Do you mean the CX rail scaling here should be handled by gpucc clk driver?


> 
>> +
>> +			interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "oob", "gmu";
> 
> 1 a line, please

Ack. Thanks

-Akhil

> 
> lgtm otherwise
> 
> Konrad



