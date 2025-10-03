Return-Path: <linux-kernel+bounces-841793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3C6BB83F0
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 23:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E21019E301C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 21:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11D8273804;
	Fri,  3 Oct 2025 21:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CPj43sYu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B0026FDB2
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 21:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759528583; cv=none; b=OxDZZYTofFfz6i83E8J6OmGc6T2jM5ar6k+m/O/vuvX5aJL84r3FRkIQjz6hBWzLMqNhEKQRNFzP43vdvi1nCwLF797JYoB5HT30tkSgfuTDQLvDWfVAAEDkpvCnHjvsnJ3MQJwBwo7xhRLkaHYNGQHIBEFVGlMzgAuTgWkkQHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759528583; c=relaxed/simple;
	bh=nfvlN7UkEb0nKtNa+S+QZmXeylN1f1PtuROfmyWs9K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ha0jd4g8qCbDYYuCK09vBOZr4zMxKZ2l36nmE2kVVJRvwNdOhsYSIXC8cQPRjpslpMEQKf5qLBmQB2Z4+RUQbRmDG11EbGblfVqAhw9jMC89eVtkzbZahxoA0Zt0N0rtJtcT1R5sEmUOSvKp/5J44eBPFruFza7MUYv7Qyjdiyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CPj43sYu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 593B1hJV023323
	for <linux-kernel@vger.kernel.org>; Fri, 3 Oct 2025 21:56:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=VZ6THAdlV/2oZwMcMAMqnt7w
	sTsjumTkUR0dkz23Wf4=; b=CPj43sYul8guz+t4yr+JQFycvTuXMbn4d+gOcKDP
	5eGOfSe4ZzhX7rnR9G+d0tz5TP82DfkcieYpkytkmcIDX4MZi48C9v1xOKjdXD4P
	lEBEyD2Gd/WFwyeytUu7/lbCoYs9LIPciQOlpiWdT2a26xqHzDu2sUYoIwM36tYP
	tmnjLdzW3EjB43AUmXzVryCYavzIdfznH3SzNPzfTDMoA0yAQaXSdK/+2vI4zdTF
	puru2U12/gIuLy2lpMdlXJlXjonYQsDiKVGbiNLb+ax4DH/agEPbMN9atAkZ/kl/
	dkm8qisHuCz/51HBOooL+XTlObWlNVyUjQ2dlrm5kqXgXQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8a6c36p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 21:56:20 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e0e7caf22eso74744891cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 14:56:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759528579; x=1760133379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZ6THAdlV/2oZwMcMAMqnt7wsTsjumTkUR0dkz23Wf4=;
        b=ndc/mItJnnIPiPC41qdzO+fE0uyk8WRdLlmC34YhxR6U8N7QeXBHKHf1pWrvTFuO0y
         EmW6SG7KTnVL6BJgfxFUuvRhHmvuYG5WWCSE00gFyPSOimcBfAZEUUAmtFPvuJiNsgvH
         t9o2DM0sT4f09blGCzzyTApXjzMERGTAWVy8SFXslLL/CPhrsy6X8N2tiXL7p9RyJY/C
         fTZiPClqcA/pCpRvyFbdviyEBSR+stRI4gOLJSTyPKa/f1HVxps+XNy0owYxzZ1QOVrB
         t/5p2PBjWAwHKUPN+U37yYigu3DB46Vvob2EM6a/dAK9bRhuPNQ0saVC398HNOi138l3
         i1gQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5FDZpkReIkMW6Q8wtirMFzwgsiau4jZ2altoG+1RNlkftbIuntBkkLQw+y0BstUqCv+CQA8X6ZO/0rZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjQpKdhTK4C52XTqrWjYohrGGFjICJ2nQdTOhlu96HJRbqcNvL
	rD8hQ67Y6n4nyqhQV1IkPwrcaut55pk2IvSk2bxmuFgpka9/p13e11GSp0iIrWYiFS9asNURsor
	H3Z4pVUhAnpCBuROIOhwWE2ytaHdPNfQac3JlmvT/Pyn0KgTIvJ3791UBhs08ueupyWU=
X-Gm-Gg: ASbGnctpiEnTtsxy3V02OpAzxAo7bSyHBxtiud3Nk7vT+PlLjaOYvDClOZEVmuzMLFs
	CBXRCRtPwbmOHv+DRpwNfv82JimSoSl8V50NnABrt1lLR3qbdd9Ud5VOLcDTjdnIUzntglMbosB
	1eHsMD18DaEjDiC4NjoScLWPzwHiCIenhZ7TXm89oE3r1f/wH3/mGFgunTjZewKnY5OgKLNeLol
	lQu/4FBBk/zBGKKnh5dmg1F88F2B7Ky2yRz6L1Vfi22Xuxca/fPcm2hjZ4JsaJyYVYI3mG9S+me
	eQZ46YMT4O7ygAyUZLA24TJaFnM1fvrnWd0HaiyipQ+TVWtu6hH12kR/5NHgXGJauZAqDOUZPV6
	HEs6v+43hqelfBE7AvDMmS0SE67JeltxwT68FrtXJQGRs9PnB5UJeInZH5Q==
X-Received: by 2002:a05:622a:1113:b0:4b6:299d:dfe4 with SMTP id d75a77b69052e-4e576a7eb77mr62757421cf.32.1759528579532;
        Fri, 03 Oct 2025 14:56:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEV+3BdKX0PD5OIi5Zi3YgLxtsWp/Gk+LWDDE0zSja28BemaejJGH9owPkl1jZO6iNfl6UQg==
X-Received: by 2002:a05:622a:1113:b0:4b6:299d:dfe4 with SMTP id d75a77b69052e-4e576a7eb77mr62757221cf.32.1759528579043;
        Fri, 03 Oct 2025 14:56:19 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0118e04asm2179885e87.64.2025.10.03.14.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 14:56:17 -0700 (PDT)
Date: Sat, 4 Oct 2025 00:56:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Paul Sajna <sajattack@postmarketos.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Amir Dahan <system64fumo@protonmail.com>,
        Christopher Brown <crispybrown@gmail.com>
Subject: Re: [PATCH v3 11/11] arm64: dts: qcom: sdm845-lg-common: Change ipa
 gsi-loader to 'self'
Message-ID: <g3p6yi32y532tf4luuzew55s2qjrlozqyggm22sog26oacskdw@fovj54wqxyan>
References: <20250928-judyln-dts-v3-0-b14cf9e9a928@postmarketos.org>
 <20250928-judyln-dts-v3-11-b14cf9e9a928@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928-judyln-dts-v3-11-b14cf9e9a928@postmarketos.org>
X-Authority-Analysis: v=2.4 cv=RZKdyltv c=1 sm=1 tr=0 ts=68e04684 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=Gbw9aFdXAAAA:8 a=v8E5xubLk08JJH_buREA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=9vIz8raoGPyDa4jBFAYH:22
X-Proofpoint-GUID: W7H1pz_OKFjEj3Wj0TiVriHz_-tFfeWF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMyBTYWx0ZWRfX+DjofeCHxUyG
 4iiVCidWt2vHZhVN8giQcBwyOFYmfgE/q5gAMQwmyTLmtAhxdmxmXNy9zHGrXpujfku4hTFkYo1
 Hs/kZSC2v7TgQVVbm38TXX6FB7zuBM/IgLu4kI9XyFlbIU2LZaAVQJlZgxycoYJ4dXQVye9ipg1
 tnSAPQz7sV45n8lQ3MD70VeAahZewsw1f6VHr23ybhPPIacxxPdzhWYt6VqttZPwJToEKv96U8s
 GYwLqHDngRB9HVaol76JkiVvmiSgbQzzFU9ln5d/cF1bjbqLLjH9fPULg+0Lr8d46W392qCPxM9
 k/nfgqaJ6H2KbS8JGzk62RnDQYUg99PXd59erh/TMe3zHmHauIeDQ9SWiUSY40pfPwuTS1hbLEs
 jJat3HZIIiPQfKNVARgXcY+BcNbcyw==
X-Proofpoint-ORIG-GUID: W7H1pz_OKFjEj3Wj0TiVriHz_-tFfeWF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270033

On Sun, Sep 28, 2025 at 10:05:34PM -0700, Paul Sajna wrote:
> This lets modem get a bit closer to working
> 
> [   15.885735] ipa 1e40000.ipa: channel 4 limited to 256 TREs
> [   15.888550] ipa 1e40000.ipa: IPA driver initialized
> [   21.038968] ipa 1e40000.ipa: received modem starting event
> [   23.097401] ipa 1e40000.ipa: received modem running event
> 
> Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> index f309e6ebc075a691c7a522238b4a93ba9e63f3c0..898f87818d3d4d028cc762d7ffdf33b3c2352c92 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> @@ -484,7 +484,7 @@ zap-shader {
>  };
>  
>  &ipa {
> -	qcom,gsi-loader = "modem";
> +	qcom,gsi-loader = "self";

The commit message might need to be improved. The patch itself LGTM.

>  	memory-region = <&ipa_fw_mem>;
>  
>  	status = "okay";
> 
> -- 
> 2.51.0
> 

-- 
With best wishes
Dmitry

