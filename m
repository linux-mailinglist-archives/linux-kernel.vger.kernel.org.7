Return-Path: <linux-kernel+bounces-815959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 659E9B56D75
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 02:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2E3177D73
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 00:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD951C5499;
	Mon, 15 Sep 2025 00:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kNWjrptQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D12F8462
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757896554; cv=none; b=Tp8MA0oE+KSbmWX35GVhWfm56/c2Bx38ofq8nAoKF/AbTyuSaAcmdaeKaN472f9qgeWtlRW1qrYk5WYvNyj3/JgZEyz99sH0MTinrVlncMDU9ZkNMmnohqR+JGHjNd6MGJ9QR8m+G3/g7VOR9Ij2xlGGRONqBTnMV4LtpPdR4a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757896554; c=relaxed/simple;
	bh=lSZxC9QJIX+S9xfCOuzcDQtUiWjlEROk2ZCchUnn7kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrZWepxWcKINCu+nC7p08m1vwC28gjykCPMm88acNd3zJpncf2tc53r9mdT7F3q0fQmFMtWsI8z3psavUKuQ1U+RxxpEH997PGs/i2WNzxNFkFEs2T7s7A6KLy8PrS8gjgPXspYJ1pAOWEMbeDwsEc3f+kz3s/adDqZAAR9fpxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kNWjrptQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58EMWR3a022271
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=D08sD4breznQvAIPhUVcgY9/
	ePdboBCRyWjrlln0Q8E=; b=kNWjrptQNGBQAPM7mziEVEezRtYX4PcgYn6/ZLIQ
	jSBU7ubKYHrCo6EHBWxE6eqm80opd62fs9/PeSL2VB+vjV3WIanCKDsOVAtR/nFm
	MmajUPXTghhS1gW/f+83Z18pbdIsvHcE9p/nIBoDyRPimjDsW1dJ7O9GGz72tq1M
	UEIVOZ6TCi9AaAOzs9qdYuYhlk+ZQhEbsl/RKvDBLGdwJj7o92xTvkjx86UrK2qA
	x/KaJoWp+xTw/jd2RAaNyAYO1gipFIEHDHJKZMRLzrJYH5wm+lk7bj0AUkRpU2q0
	vldngBdgKk3WuyLrTe+5MoyMKGnnk/JkMz2KbU43kP4rNw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4950pv2ywf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:35:52 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b78fb75a97so15117571cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 17:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757896551; x=1758501351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D08sD4breznQvAIPhUVcgY9/ePdboBCRyWjrlln0Q8E=;
        b=H8nRmwxHqEUcOv/renlLr1A+whyZ3YnvypJGFh5Il4AcfQENKM44Tx4HFXvDuPIbzI
         ekNxEYx04tzV3otcCh8gENIyemtHd2PyJhnYSBHusGnCQmbaZEIcOiCXQqLF5cgLeezC
         qEd1Rb1zaZIGP2x15HVeb8gzSbtXtMTdh5dzA9nW/2C5nTy9xZZIevIVTQ5I7xPCZzcP
         62u0Q6rb48uENsviCKsTpYF5QNvpjdV8FanuIa5bWKY5j95FyoX+aGaOMiKSiUmNearp
         uI7sI64/7Ky3lH1zHYfeW2sUBJPBaBnDhOeuiif5+FMbgyePfjlgw6PShSNBBhQGiLZp
         +inw==
X-Forwarded-Encrypted: i=1; AJvYcCX9R1zzzbt+P/9/1NIpiYq/1y5qxKAgg8pf+o5H++mJZGmjbqN9g2emHpLUU63IzKKoZCXX1sHFe3ASoaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIYhUaHjsIcIYVG/wvzj+R0kyLDuxilPgSJkWuGJ9rOSm9IM/+
	lDF7SyqJ0RCrur/0obdpZ6+huBcxF6iFPsPPYz3VVwwVWXpCi+PP/7XihOzLnRSHfYJHRRXU9qY
	oXzR2NBD8usyg09H3iYs6SaXwjK5InR8Y6NwJmS4y6kWBi8VUbMXVbWhxSclM1kvEFWg=
X-Gm-Gg: ASbGncs5a/RVoloKBgisUYdc2IFQaHArYAOWiIQT6ZIIunflJBNKAQo5F6eWHQTV22a
	HZBUkSdk6c4x1OYOo007A2EIPG4j9ZZpq8MHgAYUw08y3k/qvO9JQSgzH/erBVZec04pNTsQGWU
	NeqKP/jmfrqqjs8ucCQ7yXq43J0Z4mgDNVnO/YuRDb99oYJMSnzDkSSZBlSBFMuKnJnA6LzAp0O
	NY1kJ7rcGIfIeoZOON3PzJMzm/IEKlJp77SvD7X9Sz0Zjrd420LEdJq+K/nz0A5WUgNqpniH+DV
	iSVkGTJtKMyVj0V2buGzqDPQBsgPUUorbaoAGpfM4Hm3XpQUBhR/AJ1LFUqJABTmufYvVygjT7Q
	gpoIwaRAGG7VP2aQBrJ3ciCLvVDnjTlBYXNn2lCADfvYyTU4A+Vmt
X-Received: by 2002:a05:622a:15c6:b0:4b5:fc2a:f37c with SMTP id d75a77b69052e-4b77d0e25acmr108044941cf.74.1757896551505;
        Sun, 14 Sep 2025 17:35:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8SGKk0OcpL8EajdUw1gys0MsCLMCUQPEIfzZJKL+F8vFm0ZeB2KxlkNsxEqoPlkvAnY3b/g==
X-Received: by 2002:a05:622a:15c6:b0:4b5:fc2a:f37c with SMTP id d75a77b69052e-4b77d0e25acmr108044781cf.74.1757896551053;
        Sun, 14 Sep 2025 17:35:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f1b491f4esm25403941fa.49.2025.09.14.17.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 17:35:50 -0700 (PDT)
Date: Mon, 15 Sep 2025 03:35:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Paul Sajna <sajattack@postmarketos.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amir Dahan <system64fumo@protonmail.com>,
        Christopher Brown <crispybrown@gmail.com>
Subject: Re: [PATCH 10/11] arm64: dts: qcom: sdm845-lg-judyln: Sort and
 cleanup nodes
Message-ID: <gquntlik42knkhbe2lklc3pc2tnof2r5kszc72ugmguru2bwnc@t4mjswema7qc>
References: <20250913-judyln-dts-v1-0-23b4b7790dce@postmarketos.org>
 <20250913-judyln-dts-v1-10-23b4b7790dce@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913-judyln-dts-v1-10-23b4b7790dce@postmarketos.org>
X-Proofpoint-ORIG-GUID: i7TTdtUtJ8CcnxFDc3sJSIo75IX88JuC
X-Authority-Analysis: v=2.4 cv=PsWTbxM3 c=1 sm=1 tr=0 ts=68c75f68 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=Gbw9aFdXAAAA:8 a=ijzItukGkLEnUYRUYaEA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=9vIz8raoGPyDa4jBFAYH:22
X-Proofpoint-GUID: i7TTdtUtJ8CcnxFDc3sJSIo75IX88JuC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyOSBTYWx0ZWRfXzaMUCK6pfvHB
 5bFgZDoh8tFrxnoe6aIRIzLUWSsoTlZdfqs9rdsNojvL+MGtKPWJ2/d+eie1MWNpj4T3+A//xkk
 +sw2/OZVX+Xi0JiRK96ai3Lk6ayVTprLL0PbxDEnP1Njfg/6UUpxvM4wCEcnQE1biJn7CPw4N7x
 Hrpa/P+oMj6Hp1C3IaPn/IbFGBA2CBeKEQ/seVg+Y6qwQzeBObVcV200+TOVyKdKzuT5/TsQytV
 2JdL1SYr2w1W7WHxIbdw2XG1JhaVitaXKVrRWN8O5TQhd4AQZ23iU1TbNXwyLR43hovenSgYI4P
 Lc7UyNkn6efXDT+LlzY1GgfNFrlLWWJ8Ug+j+oCnFOjZPYR919EP8YKEiH9LBNVkTyunpTuiGkh
 nMK0NlNq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-14_08,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130029

On Sat, Sep 13, 2025 at 04:56:43PM -0700, Paul Sajna wrote:
> Fix style issues and sort alphabetically

Please perform cleanups before actual changes. In this case, however, I
think this patch should be folded into the MDSS patch, making the nodes
sorted from the beginning.

> 
> Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts b/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
> index 467aa0fd0ef3938e4a8c08b2240d4dca2f74dbcd..493b8554ad8ef083d836a6664435010ea915f2e8 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
> @@ -75,15 +75,6 @@ &ipa {
>  	firmware-name = "qcom/sdm845/judyln/ipa_fws.mbn";
>  };
>  
> -&mss_pil {
> -	firmware-name = "qcom/sdm845/judyln/mba.mbn", "qcom/sdm845/judyln/modem.mbn";
> -};
> -
> -&pmi8998_charger {
> -	status = "okay";
> -	monitored-battery = <&battery>;
> -};
> -
>  &ibb {
>  	regulator-min-microvolt = <4600000>;
>  	regulator-max-microvolt = <6000000>;
> @@ -144,6 +135,16 @@ &mdss_dsi0_out {
>  	data-lanes = <0 1 2 3>;
>  };
>  
> +&mss_pil {
> +	firmware-name = "qcom/sdm845/judyln/mba.mbn", "qcom/sdm845/judyln/modem.mbn";
> +};
> +
> +&pmi8998_charger {
> +	monitored-battery = <&battery>;
> +
> +	status = "okay";
> +};
> +
>  &pmi8998_wled {
>  	status = "okay";
>  };
> 
> -- 
> 2.51.0
> 

-- 
With best wishes
Dmitry

