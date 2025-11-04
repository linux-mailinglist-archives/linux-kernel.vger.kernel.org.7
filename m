Return-Path: <linux-kernel+bounces-884764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DF753C310B9
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 13:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 49CB834965A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 12:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D071F131A;
	Tue,  4 Nov 2025 12:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M/4+2Buu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PzplkmJC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD5C1F1513
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 12:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762260457; cv=none; b=PNcoTERnlH/03aJtbW83yl7JVTpUM0MVgaRQ3iRuO7JHjZP5ecIdn22XbGXx5Hw7jVebQzKm0lBEEA4KbxiUAVNkD3N7kAdxQcx2/XfQvy+oYaVgQvnwwYxyI3CA1xZMKUdUDfRdlUStEAldcg2rRTetC57ucfxecQRSaRy2xoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762260457; c=relaxed/simple;
	bh=gTxs5rn49DdYb8Oa5KQlFCzJzQuiPSQL8X+NvSES2ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=usR4kgypp5pZlTcmgv7XT/Fvx/2uTpNjgNouSRDhTKZ9WshtJYLaWCv9vcfMuN1utR9DHsgOmDYNAysS3nxQr0H10a5NYqB23RcDfGL+zk4ChNhVxbSccFXKpn3lpvYh3WS2lzKhcV1w0FajC1OU6/llwt+/Rl+GSr51rYws1SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M/4+2Buu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PzplkmJC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4CfkwB2049149
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 12:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	btCLUFG2JW2R6lSb/zI9bygKazt32LU1QnP6IaOo4lg=; b=M/4+2Buukf5mYu89
	WA05TNN2VSx7YL7TBTGKfpPHBA0dSJvcQ7YRGmm3HbkjYf0hWUxdeGH7ZXKMqZPN
	ml+wEwweBqeex3ao8Cq5D5Kebss6kBgv3Ydde9gOdNITp82yk2FepnmughxKUkLA
	L8C5GZNdJIYbKe9zCR/IzPPm+vhHErPMlW4+sFANg4Rec4n1vnR3//njyNDMB2Yq
	rAScset5mlmSSq3UK9yIbikkIP1xUioHby48GoXB0oGH14847f8zPc3KZtv0G1ja
	7cIZkv3IOMekJ6QMAYTU/YkDJtyMbNBUTemE/5bSmrSgfz6iQV95mF+3WtONIJKU
	c0cAgQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7f250f0m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 12:47:34 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b1be0fdfe1so13985985a.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 04:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762260454; x=1762865254; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=btCLUFG2JW2R6lSb/zI9bygKazt32LU1QnP6IaOo4lg=;
        b=PzplkmJCi6iE4uURukblF9Zf5YfG1wEhS2rIJvP/j2IdMo6FvTqUmXeCimgVKZZa76
         HgHlFfgZ+hNkCRM0jvOfLKQfRx4v5sQtkCFmyyjvdC6QbERZq/geuDkbyiF7nboTA9e0
         5+K1OccVRVJiu9NdarzyLyVuytOXO+QPGvblqveG57fGiAuMIFAZU9Oitp6O7kF9MCXY
         0gKjwZSIa5RfsDeVUjhAS/heatfjyvRS09sYjh4YIPhUw46H46I5gkC5Eo2AqJCaRSbx
         qlvkCqS6D+9K1bbv5UOdIAE5c9yRvRjFFmIlP9nouYI+cvyIJaTRhv0OOBnPVXlQ7cXk
         OQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762260454; x=1762865254;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=btCLUFG2JW2R6lSb/zI9bygKazt32LU1QnP6IaOo4lg=;
        b=wanO1YgqQM4wKGHbuYp5IwuCrD95AuSRF27EqFPYVOEeLhD3SSCbQ7QLSIy0TJpjyH
         uAB1FTQGKxfQC5y830QM8xkRSYqkAgiUMtJQWazu0gr+1bzaYHZxww5a4Jho7Tx1sOqJ
         hNRHFQi1/aAC+LNyNEyKLnQiHfvGe2TRycha6LRHtIGRS7wfgqsu3LvHv1css/MbfYEx
         Q6aWBFGelTFUPt3EzvGWXXaLId8TCQ8vKf0mPoGTfsmoMCbqSHcJPRcWlhZlwXextipv
         dGwhNWJI5hh5c4jJdGjX2ctM/9qCogB2dYnh23FzuCPAzj49Uzx/ZDWdN09OvMKRRd8F
         WhrQ==
X-Forwarded-Encrypted: i=1; AJvYcCX12S+ivfpHYUt7efoOrb2r7a2/gG3rKTMMuqC8YyXjX/eVLJlwSgQwJgJCjCZ0NSjV0q4mLuNM7Sy7iWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlPfB1J2EGngyLiyitwy+Bn2MzVzEEeaOa67qvnXx25yqWZOHf
	KKlV+Xly+fhhs6v8KnF+PTzCnZiKj4uAbtx+jPmnoQJjoBydrDPH/JaPmV6JYm77uOshtAIGo+E
	s9C+PD2K5mcZZpbxTo2EMYzQgx6TpiBygpzZO/jn9urWCsv0QdoQtgPBecR659Meskow=
X-Gm-Gg: ASbGnctGMWsuELBK9Pf5okZ16OOeeaBVIbyGgkp2m+4Ag0DKaC46RHdlCA0t2IudHBX
	jxC5HRwNKrATEYhtRu4ZBrL+47RhYrlnqe/UiLz5Fm4uEPvWcO+7LuHlb6GQaojkdyY15IzZXWx
	MYOyrPIb9wklejvlETtgjMxRNcnY76fbdESUccdAoX6Q67ncrrXGKv/M/fjHSKoQKsYF6gC/mJ8
	vRKvvsuib+2SQa1fKlGBKQlfEvPtHVGqPjVyehEnoQKyejihJSi3JGYUE8o0qNDgOg21Mc+Szjo
	IElNohEiZWEn86f1K6roMMh06LmMKFPdzZ2kwQXox43RpVajk/8nMm5UKmPOOIFSyvusWhGApZz
	gDEdXEzaGm8LBeMDBiGEVddufPRX5bDRbfLcEIoRrXstS02sBFhGnY/kx
X-Received: by 2002:a05:622a:1889:b0:4e0:b24a:6577 with SMTP id d75a77b69052e-4ed30d4af53mr132226781cf.2.1762260453859;
        Tue, 04 Nov 2025 04:47:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAViUaNmyoIrrrtJRAsJFTDtaonsJt68AYLkIMFNWARiJlxrMxIPqTiGU7C28cF/+f/XRsAw==
X-Received: by 2002:a05:622a:1889:b0:4e0:b24a:6577 with SMTP id d75a77b69052e-4ed30d4af53mr132226561cf.2.1762260453333;
        Tue, 04 Nov 2025 04:47:33 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723f6e26e7sm203838566b.41.2025.11.04.04.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 04:47:32 -0800 (PST)
Message-ID: <25b7abfe-1881-41e5-914b-ee16ce63ed3e@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 13:47:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: hamoa: enable ETR and CTCU devices
To: Jie Gan <jie.gan@oss.qualcomm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
 <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Mao Jinlong <jinlong.mao@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251104-enable-etr-and-ctcu-for-hamoa-v1-0-af552cfb902c@oss.qualcomm.com>
 <20251104-enable-etr-and-ctcu-for-hamoa-v1-2-af552cfb902c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251104-enable-etr-and-ctcu-for-hamoa-v1-2-af552cfb902c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dNyrWeZb c=1 sm=1 tr=0 ts=6909f5e6 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=GSohi4rL9rV8qtWeFt4A:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: ywNsbCPrs1p-qUFtHRRtsY0yxRY-atQE
X-Proofpoint-ORIG-GUID: ywNsbCPrs1p-qUFtHRRtsY0yxRY-atQE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDEwNiBTYWx0ZWRfX1YK3ir840Jdc
 POGGykPZ5dADXRVD8dwGikkFkrD8mhwKYfWzJ0PN5DP8OuIjwPJA7On/naCelOKkfUI5IjmzyQG
 xWUhPDbhrh4lrXVhjXTRU2huw/W8l48u/DaOuJpvOAQjmuJwsy0/AvuzFYNrc9WMErgi1IanKI+
 PtCnu4JsZpzIaqUUSLdOoFfUK+eXfht/n7cbHX00yV2vVGkiXbygBHHVmKNUH78zCCpAqRGfidr
 oPm+P5pb6pITgBtBYMH1qfDMLNinVpW6j0yGLwmcq0kDBKTMGObSWE27t4AeKhR701CgxH6bMM0
 w9fwG3iyokvEoviQgBb+cmFT5gc45plVwAimN7SOxQetl29ro8dPKBmzQaiL+e6dbE42U8ce/yK
 KLCXHTr7VigSU611rnBXSFsLLoBMPQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040106

On 11/4/25 9:10 AM, Jie Gan wrote:
> Embedded Trace Router(ETR) is working as a DDR memory sink to collect
> tracing data from source device.
> 
> The CTCU serves as the control unit for the ETR device, managing its
> behavior to determine how trace data is collected.
> 
> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/hamoa.dtsi | 160 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 159 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/hamoa.dtsi b/arch/arm64/boot/dts/qcom/hamoa.dtsi
> index a17900eacb20..ca4a473614ee 100644
> --- a/arch/arm64/boot/dts/qcom/hamoa.dtsi
> +++ b/arch/arm64/boot/dts/qcom/hamoa.dtsi
> @@ -6713,6 +6713,35 @@ data-pins {
>  			};
>  		};
>  
> +		ctcu@10001000 {
> +			compatible = "qcom,hamoa-ctcu","qcom,sa8775p-ctcu";

Missing space between after the comma

no issues otherwise

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

