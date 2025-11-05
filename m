Return-Path: <linux-kernel+bounces-886408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE07DC357C5
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 12:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D182E4FD19E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 11:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CD930F7F9;
	Wed,  5 Nov 2025 11:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O1dxvZaw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h0+EvyRN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E633E2E11AB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 11:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762343245; cv=none; b=OQk5yuH8BjkFQie4/fdD2UHMCCQ8IQ/pmZsct2ZI6+P9t4MDd3TQCdT+/QGYMaC0XNqJIgGf8AMc0N/nbFgxhdj+HX91WC9UmRzHdpV78t7qT34mUkYpVF6ClGSg9+dDiGLG17LBodf2NEggkOqvwkBbpSAu4ure40maUntPBxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762343245; c=relaxed/simple;
	bh=yK++sN1Bh8hBuz6ZUX6sKLa5D4fzpdKScK59Pwwoa1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=syzVVB8auSXzEFx3ZctUoBo20SGRBdlhczelAxnZxdYukKhjAnF/pdla3je2TDNWfg1zc/NUT51tUr2jB9M7sCxh16ovIVr/NCaaxls9NaUyhA4wxQsXd4/4x8WaXHWvSIa8+omMsd0GSM78wfzK/oJqr4XUlA9JacqueA1PbOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O1dxvZaw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h0+EvyRN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A58U0rN3165295
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 11:47:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dR+CkS6w+PXkDRROgX5IJl3PVYVkdiZyzmqb+OibW2g=; b=O1dxvZawNyF1ampy
	hOFZejQQQW7acmlaJ6rDfsZy0oTxH+o5uPzXKjk6RsX4akslzOgF6Zz2yWz67i60
	T7dBGl5kuhMTqgI/5TeDOLeKn3hINwKGp3O1PjQN0VspnrnTCi0zxGSnT82EFIB5
	X5pfnWRZoXQltQLrM/acwbXF4JqDm/Zm0RzvGT1gAjzYxoE0cgYgVcXERa9epETe
	BUILl3y77vfmQe/yb4HAdSCNX3ygxydV7nI/1Masah4ABs3g4dKzFS23MUsLrqIj
	JTYgZtF+lRg/BsRL7psjIibDurVeEPsi4JFd1kDyJcLISZizVNG2uM8bLJGuWB5L
	NT+Pvg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7ketkeg5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 11:47:22 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-340fb6acc39so4826617a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 03:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762343242; x=1762948042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dR+CkS6w+PXkDRROgX5IJl3PVYVkdiZyzmqb+OibW2g=;
        b=h0+EvyRNYkxQ1VoCyYHyzJ+niVtg/1yNSnxBPJv8/it3Tlq1wCUys5dx8hEtApp3CF
         TNwAJZSS6GjyFT6VwgO97Ciu1nDXmyXp3u+oxtdS5VYve0taZi779hNz6z/pzawHV6LD
         FGxKoQ+P/HQczsjEfkIGdaF2/EXxD6j3pqRyCEGz8+0vgs9sHWQwdRWYxs6PJRJJIH37
         vz3wsFllrHwxPkW6M0fM0QXcLijb1IqvaO7OW0lcUL4VDfZLIaBBmmQse+qZZkhgkNzg
         LXDHMlmNgCpd86ESvl7n4giBl5tthJN2QYbifO+ENI7jmzBfFQu/BCdUzde/MB3sjVDZ
         HdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762343242; x=1762948042;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dR+CkS6w+PXkDRROgX5IJl3PVYVkdiZyzmqb+OibW2g=;
        b=UjBQXuZ8YMINwaiDoPAssAA8CWWu5ordATghB+QIO6iQ2XrVqsSclNUkrfz0dzvnZz
         OfVwydNuI8499iRH9DCbWBcJMEI/DcaWDAHn+KR90ZHCfZUWhCLnDchzUj10CREb/+mt
         UDmNMsVf3awALEEXxcC37ZawmjsuYaFUrcVE2y64yNQcG7GY9MG/dlABlvIWp/7oYdEO
         pSLaqgRGteUPKUCbZnBkxMEDfIPFf4fK2jklE3YguEm4UJXmWSrdsnXK007XqDHPMLHA
         OiK21s2UoshckeHawAfXkj1HzWC88wCH289LxI8vI8YAKLJ/LrMa8snCUY2jeSU8g65i
         9hbg==
X-Forwarded-Encrypted: i=1; AJvYcCVQi+R1GbNsZZ/oQRfHg2pSFy3Sdv2FVXNQSweWpasn+YKd2qhTMsSD6zPL+t6q24rmmoF+TByZmGxDMUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7h8QPOWQIztmDxj5gxXWVGzPE+ydvVPnZPcSf0c+TJT++Gwhu
	KNNzjGM3SP0W6t2e3KltlMPVQKx5GIZCA88AkKQ7Pql1mlGFCMw00/xTAzM5Zw9T/6j0H78ykUz
	LFq0A98IEfIMTMd0Whg+YYRQay/BmUtequPebAxIbTBHGXMB88oJmCaRs9Nya3rBGYvo=
X-Gm-Gg: ASbGncs71+OkENfnE2hellqI8Hq/zKn0tigDOI9Nw9qgU+Fjqsyfgvswb37/yF3DTvE
	cdF54J+yGwwsB3PrSD7jJccvcCiZhYjr5n5Gomkx4LOZQj95WEwH42ErZ+pg2VwMJzKIZWNiN/d
	wch86dusm2BuZEHmjYfu/rXF5IURCwaCv6ht+RukPXbyuujjdc/053KXWDBflP605R6D6wat1Kh
	40cFRoM3UfXN8BuaUT5+QCQH5MBFPJ82uP6KcFAxpWRgmmf6NrGRNxKbJl03Jjodxlj02GlXsFM
	Yz8UikFXmc0e3u6vGXRf0fqr9cOCHX/4VsfXT/Md+hH3nQQ9UQMbssrPs995ESA9SKU2CJC+NS2
	l8rFkPpCCeuA8oO+DSbj+kP5FNV4=
X-Received: by 2002:a17:90b:4b86:b0:32e:a8b7:e9c with SMTP id 98e67ed59e1d1-341a6de90aamr3359478a91.29.1762343241566;
        Wed, 05 Nov 2025 03:47:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5ab+BuIMW7EEe8KGrCPBR+KCmyAPB1gT2l4Arx0WUviGh0Gta1z8ZmjeET1gPTGcz1MSzNg==
X-Received: by 2002:a17:90b:4b86:b0:32e:a8b7:e9c with SMTP id 98e67ed59e1d1-341a6de90aamr3359432a91.29.1762343240996;
        Wed, 05 Nov 2025 03:47:20 -0800 (PST)
Received: from [10.217.217.147] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68ce9e9sm2635595a91.9.2025.11.05.03.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 03:47:20 -0800 (PST)
Message-ID: <b25280bb-c85c-4f5a-b156-f64383c3033f@oss.qualcomm.com>
Date: Wed, 5 Nov 2025 17:17:14 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] arm64: dts: qcom: x1e80100: Fix USB combo PHYs SS1
 and SS2 ref clocks
To: Abel Vesa <abel.vesa@linaro.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251103-dts-qcom-x1e80100-fix-combo-ref-clks-v1-1-f395ec3cb7e8@linaro.org>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <20251103-dts-qcom-x1e80100-fix-combo-ref-clks-v1-1-f395ec3cb7e8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDA4OCBTYWx0ZWRfX97Aa3GMKuQ/g
 Y1CoCwzuAAdaNN6I30kmsI0K9rZ5cbw6vjKgNAk8+KfKO3i2A97qmvANkQ4XJyHPu7kEIEPA793
 J4QgUsTLwJsVfNV1f89eSwUJctlcJjfESyEFNrb+RTO45kmCD00Cn0PCR6fgcSnUo43wiOlo3VU
 nQ0kk2oDKNwEFY7y3qj8yFAK3ZV9Va5MSjadyP9aQhUIxJ1p1mfv94B4LDrjukd9d6ptgwFR/jc
 9yYbrSdHV5cM5Mv+P2clyyWoCntiUgExt8VCBqkGJHf//0YVs5lhF9mGhNgglJ2HVu61ztzCzfV
 cA16kf5t9h7NGmfFdE8w/kVYRE4X0qtLPPmSr/z0P0w0plgSZZK28LZ9VAnef3J7cYBGZWNd84/
 KDmH51lN56nOojuFGKEAHDz0JztPbA==
X-Proofpoint-GUID: f-eWDm6WlI40aV_iOGq-v4nVatowDaes
X-Authority-Analysis: v=2.4 cv=IdSKmGqa c=1 sm=1 tr=0 ts=690b394a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=rR7qPUVVgLrcBC-Q94AA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: f-eWDm6WlI40aV_iOGq-v4nVatowDaes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050088



On 11/3/2025 10:21 PM, Abel Vesa wrote:
> It seems the USB combo SS1 and SS2 ref clocks have another gate, unlike
> the SS0. These gates are part of the TCSR clock controller.
> 
> At least on Dell XPS 13 (9345), if the ref clock provided by the TCSR
> clock controller for SS1 PHY is disabled on the clk_disable_unused late
> initcall, the PHY fails to initialize. It doesn't happen on the SS0 PHY
> and the SS2 is not used on this device.
> 
> This doesn't seem to be a problem on CRD though. It might be that the
> RPMh has a vote for it from some other consumer and does not actually
> disable it when ther kernel drops its vote.
> 
> Either way, these TCSR provided clocks seem to be the correct ones for
> the SS1 and SS2, so use them instead.
> 
> Fixes: 4af46b7bd66f ("arm64: dts: qcom: x1e80100: Add USB nodes")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> I dropped the clk_ignore_unused on my XPS13 a while ago, but only
> realized now that usb_1_ss1_qmpphy (the left hand Type-C port)
> doesn't initialize successfully.
> 
> Traced it to the TCSR_USB_4_2_CLKREF_EN and then checked the Glymur DT
> patchset. It seems it already does this for the SS1 and SS2 PHYs:
> https://lore.kernel.org/all/20250925-v3_glymur_introduction-v1-23-24b601bbecc0@oss.qualcomm.com/
> 
> I think replacing the bi_tcxo is the better option, since the bi_tcxo
> is already the parent of every clock provided by the TCSR, including
> these for the SS1 and SS2 combo PHYs.
> ---
>  arch/arm64/boot/dts/qcom/hamoa.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/hamoa.dtsi b/arch/arm64/boot/dts/qcom/hamoa.dtsi
> index a17900eacb20396a9792efcfcd6ce6dd877435d1..9c9e567731556ff532fa64c7595e2570b0597da3 100644
> --- a/arch/arm64/boot/dts/qcom/hamoa.dtsi
> +++ b/arch/arm64/boot/dts/qcom/hamoa.dtsi
> @@ -2937,7 +2937,7 @@ usb_1_ss1_qmpphy: phy@fda000 {
>  			reg = <0 0x00fda000 0 0x4000>;
>  
>  			clocks = <&gcc GCC_USB3_SEC_PHY_AUX_CLK>,
> -				 <&rpmhcc RPMH_CXO_CLK>,
> +				 <&tcsr TCSR_USB4_1_CLKREF_EN>,
>  				 <&gcc GCC_USB3_SEC_PHY_COM_AUX_CLK>,
>  				 <&gcc GCC_USB3_SEC_PHY_PIPE_CLK>;
>  			clock-names = "aux",
> @@ -3008,7 +3008,7 @@ usb_1_ss2_qmpphy: phy@fdf000 {
>  			reg = <0 0x00fdf000 0 0x4000>;
>  
>  			clocks = <&gcc GCC_USB3_TERT_PHY_AUX_CLK>,
> -				 <&rpmhcc RPMH_CXO_CLK>,
> +				 <&tcsr TCSR_USB4_2_CLKREF_EN>,
>  				 <&gcc GCC_USB3_TERT_PHY_COM_AUX_CLK>,
>  				 <&gcc GCC_USB3_TERT_PHY_PIPE_CLK>;
>  			clock-names = "aux",
> 
> ---

Reviewed-by: Taniya Das <taniya.das@oss.qualcomm.com>

-- 
Thanks,
Taniya Das


