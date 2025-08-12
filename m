Return-Path: <linux-kernel+bounces-764079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F6EB21DC3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89D2E16E4D0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F5D2C21D4;
	Tue, 12 Aug 2025 05:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eiG/uEgG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4EA311C19
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754978199; cv=none; b=O5IddZaNJrhHSc5g2+DUjwKGs5p6x1UC2zA7GZFox24WV2LHZLCinjiF7V6wsZfk3G5ggBm92VYpMybC681cfS22YXxFu0XPEbZnClzpCXHXbsNhzmo+nzpsFSkg5N1rO1IiVY9p6RtQpr3egvQCydUpgVwhLLNglctQbIDNhKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754978199; c=relaxed/simple;
	bh=N/kGy5+Rvl5NkLVtYUZMJPPcbHTjJ6Zdxnfsjdb3SsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EEHokvo8+YAj7J2zgpR5IRatBk0Mey0bqKqfA96nXWE041cuCqrOEdLJZcxUsfi2VjDhMsxmwJ8rzBfZQqQMlYf0p7OQP5OAkfpyoPrBgOVdunl6XGelXhBD7NJmIFQtjM4kWLEO22BurHzwaXNVivIX7e9V7WKUhTMyyYkuz08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eiG/uEgG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C4ggDT019164
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iO3FGVGfT/Y62Gvgar24D6JfUYtCte/97RHmCrhAXvc=; b=eiG/uEgGVyrbsO3+
	Cv1XZ9Mer3nCiMBO/p61JD6OuBveJMJ4+tj09BN98MHk7OvIHz74bVLWgv5tjNMs
	O5mgMe00qPMNNvVxFvilcWxg5/XThXGzlcfP+DCKRF87Ec+Rtnv72479019NeY5V
	+x3vUhob012fGcMD5ucywKYf2X4smkpgWPC0XlNQO7BuFxc++DrysRWXnU93Hg1x
	Mboc7E1YoDLlGKqr2iQkE5f92WFOyuRwQ1+b/+bxFdNK8FFv4PhQRqkzVztsnyr9
	RaISbD+Enz2ytDG9IKRmWL/KFcBImLVPiGz92y5SToTOjTIKvoEq1hSH2QlYp9FA
	GXw48Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxduxyg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:56:36 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b42218e4a59so3781660a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 22:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754978195; x=1755582995;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iO3FGVGfT/Y62Gvgar24D6JfUYtCte/97RHmCrhAXvc=;
        b=XpzJe693SyJsz+zL1A2YhzK1SHzpO98hlPuwquOLHyZqiBnbpMYjWO8zmG4wMImgM4
         6559atUV4L8dSjZRHGEAFm9Y4wmJgoFwS4Q4+In6OvJPMr8hQ8BBM2ANW4bsZJeaK0O1
         zPEBxRm50qNFE4cQk5DfTugL2DBM81s2lft6pEXuFu8VczB6x8dwiDeqHtuz/d5PoWmZ
         MWdM8Ol85ytYzBXePCk178h6lhZV+f+mCFe/rdhiQEj9BvsgmHNmGwrKvdhxnBnMUdvt
         tHvtgW80jtDf+FNvrMwwm4Lm+sgcIRjhUMl0xmtOCRafdfR+tbPEPr9wovV69OQam5Ip
         V2KA==
X-Forwarded-Encrypted: i=1; AJvYcCXPhIx5qkTthwfgZEgrWftb9gU5pZ/KvDf0N/WeBPyteg0TFqkjeeH8xQ762K3oVMJhnrSuHltmhbeTcaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv1s/mv4wYtNqnP1o6PFTG1PIrHYhdv0o2SjvN56xhHyVJ2r6J
	LKCxasM3JWZxSyL9fRZVvJBClXpq90yrWIOXDjyTak5RadV+WrDttfFxcWarIrfPb2n778Gbm0u
	OPXfhawV3VQFSQp9cVkvvg8/2Iz+Y36b003V+Cn0c3LBlg8vUeYDz0tH8EU9pnwbbpNEVP5rlPG
	E=
X-Gm-Gg: ASbGncuf27MCtWWMldNkTI2LEe9ZeLkK0NKHZryNlsg9hyb4fS3MqWQMnn1/7Rhgv5B
	J1Say2ZgvofOrZmh49Bb9KNt18Cb3Y6SZjgvKjIBhsqMZii3vVmL9rwAvXBe+sVQglQ34DdDnOR
	okfNXh8yBfKtPu8I4b7cvMf/msmd43FPpjmkCgIg4WkSotTbEY6ekQJ+oHEGKhkktzjdgzY85nz
	xA3L/lvzGG4184dAXmMYLAnrOrxeYAWcttQWfn8zCQHm9XutJTCGoPazweXdDtzyG90B3H5Lq/S
	UGWXbb7sNHQLBqNbnHh/zU83TCEvy5JF1NwHzt/o0oL0Hu5P4j1+jwXCGIHU7GIBGI/6H7E=
X-Received: by 2002:a17:903:1c2:b0:236:6fbb:a5f3 with SMTP id d9443c01a7336-242fc390846mr36339135ad.40.1754978195112;
        Mon, 11 Aug 2025 22:56:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvQs0243cIKK62HPDyRoRpP+MCHl59jbXme4sVvLLXF1a/UdtW7iKiK6yuH3frFPHTDJLThw==
X-Received: by 2002:a17:903:1c2:b0:236:6fbb:a5f3 with SMTP id d9443c01a7336-242fc390846mr36338665ad.40.1754978194654;
        Mon, 11 Aug 2025 22:56:34 -0700 (PDT)
Received: from [10.206.107.125] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8975cf9sm292027175ad.110.2025.08.11.22.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 22:56:34 -0700 (PDT)
Message-ID: <881fe12b-b2b1-4135-b0e8-f8222293871d@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 11:26:28 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/5] arm64: dts: qcom: sa8775p: add GDSP
 fastrpc-compute-cb nodes
To: Ling Xu <quic_lxu5@quicinc.com>, srini@kernel.org,
        amahesh@qti.qualcomm.com, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        arnd@arndb.de, gregkh@linuxfoundation.org
Cc: quic_kuiw@quicinc.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250716132836.1008119-1-quic_lxu5@quicinc.com>
 <20250716132836.1008119-3-quic_lxu5@quicinc.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20250716132836.1008119-3-quic_lxu5@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=IuYecK/g c=1 sm=1 tr=0 ts=689ad794 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=2Ucg9gNHWiGhv-ArepgA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: wQkZFeV9yY1dF8SEf54VvXj_cvKzxkub
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNSBTYWx0ZWRfX64CWutnkbo22
 c1/syhA/37tapBLZnsJj/7tIW7obrv8NuP1psGN/FD23gvzMsnFc7lqT6BwDtCe65ssgbZykCQM
 PS1xTI7HtG/CjQLiewGeVTSUDD2MhGZ/kbsfP9PPUY0QNvWHqh0FAaCHjHSaFZpIbWykpWSad6e
 Hs9U3Vm09JP/vjYv1sWxnFWyxNRkXWgGuSzFeqeMl0GOv5tMTV/ep48NyNselakZT/TyT925QcS
 BOkf/MsWjvR0rZBWuRPLOH0WrmMsPJdcdhQ18lK0KyM9HuTnOcRq+2Njj3i9pKE5QdRb3qMHQxW
 MHrh/8k147gxDQocHIJ5IPtCsXv6th87g7FdMUg8S2E4m9mF1OotR5Qw/LEZRq80gJMP/D7goIJ
 RyGUq4Je
X-Proofpoint-GUID: wQkZFeV9yY1dF8SEf54VvXj_cvKzxkub
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090025



On 7/16/2025 6:58 PM, Ling Xu wrote:
> Add GDSP0 and GDSP1 fastrpc compute-cb nodes for sa8775p SoC.
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 57 +++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index fed34717460f..5ebc058931ad 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -6080,6 +6080,34 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
>  
>  				label = "gpdsp0";
>  				qcom,remote-pid = <17>;
> +
> +				fastrpc {
> +					compatible = "qcom,fastrpc";
> +					qcom,glink-channels = "fastrpcglink-apps-dsp";
> +					label = "gdsp0";
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					compute-cb@1 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <1>;
> +						iommus = <&apps_smmu 0x38a1 0x0>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@2 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <2>;
> +						iommus = <&apps_smmu 0x38a2 0x0>;
> +						dma-coherent;
> +					};
> +					compute-cb@3 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <3>;
> +						iommus = <&apps_smmu 0x38a3 0x0>;
> +						dma-coherent;
> +					};
> +				};
>  			};
>  		};
>  
> @@ -6123,6 +6151,35 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
>  
>  				label = "gpdsp1";
>  				qcom,remote-pid = <18>;
> +
> +				fastrpc {
> +					compatible = "qcom,fastrpc";
> +					qcom,glink-channels = "fastrpcglink-apps-dsp";
> +					label = "gdsp1";
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					compute-cb@1 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <1>;
> +						iommus = <&apps_smmu 0x38c1 0x0>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@2 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <2>;
> +						iommus = <&apps_smmu 0x38c2 0x0>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@3 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <3>;
> +						iommus = <&apps_smmu 0x38c3 0x0>;
> +						dma-coherent;
> +					};
> +				};
>  			};

You might have to rebase this change onto lemans.dtsi

>  		};
>  


