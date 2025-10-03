Return-Path: <linux-kernel+bounces-841781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D23E6BB8380
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 23:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2FF1B21A36
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 21:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADC9267714;
	Fri,  3 Oct 2025 21:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZZrHut1k"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633BC1F8BA6
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 21:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759527320; cv=none; b=czf8bVoIlluWD6kDt4hRZTVEajx6Tr+a6zAep7nq7L39m+788SW5po5hufjKzhfIZNCx3tpnBYJ39OQYmxhFUALpqjnTVr8p1IibUxahu6wh+QZIdBTkFp5EH0Apdsp8PLA7pAgNHB6RDTesr/gXxT3kTJvy7voe7MQB1l6dcZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759527320; c=relaxed/simple;
	bh=DnrF73u6uMcE7A0hMfqbDRM6WB4hE4mM5ce2ULK284s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BI4bCaT0yhhEVr12C63OtDZ00yt7E49WARoXDQKQ6sMUlSSIW0HnaiEGyrSrzI1ugfhkhr3cvXScnKiG2JO+/ivD2MQNqOHEFyIezU66OYtxiGF6z6bNdhqTgK3qf+TJ8DVl0nuHRnX5iPy9iFXoWvBpqZr+NqPoAc9FpN1Zk8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZZrHut1k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 593IMEIT008063
	for <linux-kernel@vger.kernel.org>; Fri, 3 Oct 2025 21:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LpI/7yRJpPkrv000URxHAeRb
	Qcf7cqEUhbfJVAFL+wI=; b=ZZrHut1kRLXUxPCNTSP2FckZ0jQQGQkQpJBrO813
	3B0FN7Uz1SxNlMBo2cvdJOujhsIlXSs9D6xTusN275IoAV3FdE/GhNcl0QPoMrhE
	ADR2NicnCOBBnv0w629S75dger0Z8aNyUoZBZxEEr+Bx92oZ9hseSBvNE3Lz66hx
	0DGrgEjaljUqebpriYAcN08kftzfHkDp27fXYODp0emOPs5P8+PgvpPeHGqmuN+M
	s86/5PQQcx1apuQOkfcWy9qmzQ1gwdFP+LqS20o27jIGTg6py4PnrT5aDhegNKZv
	mD0STJqX2gdjb12+H53dHhmgyI0vINh1oswYyMJL2f2rmQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49hkhh56jm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 21:35:06 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4de35879e7dso15335861cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 14:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759527306; x=1760132106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LpI/7yRJpPkrv000URxHAeRbQcf7cqEUhbfJVAFL+wI=;
        b=eD/jquAtDrBX0qM31tWWjHIlHFvay7iOTn4f5ylpxtZ4y97ABjzUaOyOCmBCF9TThc
         a91DghNKc8DpKS0hDaGp0MAnP+E0AAwQ2COkm9SkQaVEcmALQGP9BiejF1vM4c1IWrNO
         z9whL9QNdVdzNtbN/nm+5JCPq+nzzoFdgoqFb4LTscPSeTWlwiotKjADM58o5hbvkXvE
         sZCHFgjC3is3cAed5kloDcKo4LwSX6izr0X1aKYWnxd/5KHrTnBvfUpxmIAJYSMNNdiD
         +wD7ojjQLy17HDRUA4MCt4MvzzIFRVKPAyqbwrEIO/+e+EcKD+0u7OsDOhiCP1if/qHa
         jp9A==
X-Forwarded-Encrypted: i=1; AJvYcCX+QH14sKOdetr3mJuRtSXuOAjcXqkirj2Q2TiIjXs/drbfz9ctEw8ywH9wnTUDr2bTtXU6Vz9C++NtORs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRXqWYTEknmDSo2aaRPWRpWpMdXm1nXxtB+s5tMseGXQYx+ZOb
	5u8aIod2FrtJcZqoW0Ut2/k12jbdH7jxtca6U7qkzeQRsPK2eG1sVtcP6kJIqGydYq5d7uLOvvQ
	aEEau+nTB3MmBLmlmUg5Cb6cZH+CzMGYANq001H+zBiCLc6hdfPFVDdizLJFaItJ0xn0=
X-Gm-Gg: ASbGncsbxwckkxWMeuU9mMxRrZqJV2QCPumhWrG+ofnpWxVFUJyxwTB1SoNcHNDiaYI
	eKJZPqm5+/MJupguZE651ZseOFD8aYfWajIuJWQ+DUv792SMtKwnzy5AfOuFmlhr/7XyV7Hn8mP
	BbeFNsSOotUU9KH0zb5OUzb9z5Ccpev4z7rOCsl2ui273X4FBNGkZ8kPd+yt11yTiGvHV1VdF+d
	fLnJpmShQvfgxiuBHE8J99KO/sRWD/yC8x5ESUPLZwdd2Y6dQNYbEkPQtI9YSLKuLtrq5Tnxn3S
	DVEbUbAaOuUTYUKKVhsMKxPZ0sr9oN2ZtzBR8+IDWQZ+fQOoEkmmmqype1MoHSdlauksWL8w/cs
	OnBB/Fpo838STGICLrtUNmcIYlc9Y4r1RH8LicKOIqfAzaM7yu4oCW0pxdg==
X-Received: by 2002:a05:622a:590a:b0:4b7:983b:b70c with SMTP id d75a77b69052e-4e576b1514emr67212601cf.67.1759527306017;
        Fri, 03 Oct 2025 14:35:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOVVXTCFK0bJqYHUQeg2fOzIn1NMy0zPMk/luomgQCk++Xf/E/5Va5+hVQu2xGh6/6fUAjEg==
X-Received: by 2002:a05:622a:590a:b0:4b7:983b:b70c with SMTP id d75a77b69052e-4e576b1514emr67212161cf.67.1759527305386;
        Fri, 03 Oct 2025 14:35:05 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0113ed8dsm2191806e87.44.2025.10.03.14.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 14:35:03 -0700 (PDT)
Date: Sat, 4 Oct 2025 00:35:01 +0300
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
Subject: Re: [PATCH v3 02/11] arm64: dts: qcom: sdm845-lg-common: Add uarts
 and Bluetooth
Message-ID: <6zfmjxpnruh3njx5ts2f7h6zsegvks52izchzj2jaciprdvnly@nnyvivpmehkh>
References: <20250928-judyln-dts-v3-0-b14cf9e9a928@postmarketos.org>
 <20250928-judyln-dts-v3-2-b14cf9e9a928@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928-judyln-dts-v3-2-b14cf9e9a928@postmarketos.org>
X-Proofpoint-GUID: Z6THmM5jfrWohMOteba4rJ5jzxNme1to
X-Authority-Analysis: v=2.4 cv=cILtc1eN c=1 sm=1 tr=0 ts=68e0418a cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=Mq719mGqAAAA:8 a=Gbw9aFdXAAAA:8 a=CXzs4G_5OfBr_OUmaxkA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22 a=gOTWM5O2Sh7P_NUuVqe5:22
 a=9vIz8raoGPyDa4jBFAYH:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAyMDA0NyBTYWx0ZWRfX8A10W9gL8fR7
 XmGQVEkwB9jyfuTi8FwAKbW+ryF2N/XSY5TL1jDY8KprqemE7dUNKoxQgjpWu0IMR3gsbx6giaT
 iE9+OabNiONa2FeWVUO9IbN89+HosnYYwKL9+x9KPS3gmLJYX4p0AiZXSUz6MS4gOhIpNMaNG2V
 Ff6cp+IhqGU7AvsJD67MTDgQs5i8lD1FaTZLXO6GrNXi7VWXi/WXOLekG73Mbm5EAAllgSGaEDd
 /9YBugoM+u0lMJQKcPhBvBdPClsNG5N19790XjUbGuULPWVZ0KAnORMORFW+LFbCwxuZ61TiY4U
 /HOD0gKKwDF5ONmkIs8jKhH+xbOAo082X0jbfQexw7ZDi+D46Vij/CnJNghTwbhN9KNcyeRx888
 7rB2QvLZJdQ5gSScekTGnoXsrCtopg==
X-Proofpoint-ORIG-GUID: Z6THmM5jfrWohMOteba4rJ5jzxNme1to
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510020047

On Sun, Sep 28, 2025 at 10:05:25PM -0700, Paul Sajna wrote:
> uart9 is debug serial on USB SBU1/2
> 
> UART RX is SBU1 and UART TX is SBU2 of the USB-C port).
> 1.8V Logic Level
> Tested using pololu usb07a https://www.pololu.com/product/2585
> and CH340 USB-UART
> 
> uart6 is bluetooth
> 
> Add bluetooth firmware path
> 
> Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi | 45 ++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts  |  8 +++++
>  2 files changed, 53 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> index 82d6543835324ed92300c4ed24c51f4b79321f99..4c631df56f262ba9e730f6720abd94d374b14692 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> @@ -27,10 +27,17 @@
>  /delete-node/ &wlan_msa_mem;
>  
>  / {
> +	aliases {
> +		serial0 = &uart9;
> +		serial1 = &uart6;
> +	};
> +
>  	chosen {
>  		#address-cells = <2>;
>  		#size-cells = <2>;
>  		ranges;
> +
> +		stdout-path = "serial0:115200n8";
>  	};
>  
>  	reserved-memory {
> @@ -595,3 +602,41 @@ &usb_1_qmpphy {
>  
>  	status = "okay";
>  };
> +
> +&qupv3_id_0 {

Hmm, I r-b'd the patch, but I was too quick. Please keep the nodes
sorted. qupv3 comes before usb (and maybe before some other nodes).

> +	status = "okay";
> +};
> +
-- 
With best wishes
Dmitry

