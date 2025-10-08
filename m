Return-Path: <linux-kernel+bounces-845849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B5ABC64B9
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 20:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0CF4A4E9EDE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 18:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE611F9EC0;
	Wed,  8 Oct 2025 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M1IQ5W2M"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43485259CBF
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 18:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759948275; cv=none; b=qXPd6jITovkdWmvI1U1x0xQrs4GAQpQr6dwUwYTaV/ljQBBqdXq35os+U2HEuQttTAZCZpQAqQulE+DpmqRzgzZ1McGHT2gxPxS69zKEPHf7Eio4c07YNjhJLL71qXLZNb5CUtt90pCwzpz/Bl2Sj7v5W274AX5tfMBwkSQ3fLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759948275; c=relaxed/simple;
	bh=OogXdKkIvLZJMEkHkVX9LD3bgFRmz60xSvAhqaYh7b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQEsnMJV2dPXqF342ODJyduNOGFkJjjTdBa6lNPaeI4O0D3lPwHC6dVe3WzDZUxDTfNLsuhM8KGvOyE1lOeedkAaxa6XHbNUlG/FqbhtOESR/zKtkUTZhMWUvjOFtBGSTe08HYHUrvxFtfxeyhVdHS4MLsuVZM44XONAG2KbVbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M1IQ5W2M; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598I5IMi004515
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 18:31:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8ZrtUOclJ/U1N5OLRJux0uSH
	lgak+fmTzi1yZZM2c58=; b=M1IQ5W2MMPzf9WbUYXL63sHIBxJmDjASPkNojiak
	ob7YtqTqAbmxWrw+Y6lymfD9imIUrj8NsM6OFX02yMTYWHyKZTq06Gi+Uz29dkrc
	DtKqJthsF5V70FhaHdOPvqhyzjQE2405GiLdZdISvPFYW+PrGzipLpPZt/eztqeH
	em1PpP8+xmHlH1OKkhd9PMB5QLKwxjIOHGSNqoZ1VGg2F8h7Wmzb0e8cPcrr94m7
	RnF3Vx+gwX+1KeP3AbUrpOXqRRu6SQYgX0VfJrzB3qkCaUijgjr+LzshZwRTnFXz
	nwqr5cZ+NLIeeU89cuYTrMluA34sg1z5r5hvct3Xu1OWtg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4kr7eg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 18:31:13 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4df7cdf22cbso48927071cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 11:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759948272; x=1760553072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ZrtUOclJ/U1N5OLRJux0uSHlgak+fmTzi1yZZM2c58=;
        b=F6emeK6I3b6VhH2gQdSn1fgTENBmLVyTuynRcdBuJBjR8TfW4klA09XA8C5JvCRGfv
         peDuYvCt/7D7Tql+nN75mrCXU7W5VsWJVI341WlS8Dl4eAmYTMlJaN62BdXKECgXx4Cv
         ZispPV+5EA4+bzdHUrRES/ddv6f7SSkvwdeioOv0wFDl3+A3ArmZ4KvCEUVcQhuIf2CD
         KLCvtjbKukmFXvmDH2CQPos74GoLexxVZ6qPauJhVkN3X5KjiuPJtzefGWXhLobSuAag
         nVQl5Mu67vJAUMXY3Y0elbSe7gSl9dyfu3beYSEmsbwq/V2vK5dyqXTGp4s1Bd/qnnr2
         7HBw==
X-Forwarded-Encrypted: i=1; AJvYcCVr2TyV7g90+U17DEa8hYBMxNmh/86ZTdAqQ2AkE/4xy5HOVEysBTKiitPtOifPWL5A9ql1KmW5vLG0rPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY2fmhByxUq9ncYnYT5pVJdDoCFtRW9AMtbsGAHOeh4EohKy39
	m2IiaoiRtdWSMGbrP2nsQfgHtzP90nP/BKKvDpSsoEfQMNSFjGJgJ7b4vztcD517qNrkbMMfd8G
	MPobsjCytrt2TQL8mOCcfAZDwIu0hBwnWLROnGIAN00RjMHRlMrDvOcFx17ZXR7XcqOg=
X-Gm-Gg: ASbGncv1OLmDyEqdB8wPc1qk/iC7Cd3VtT605xKHXorRRHqo6ON2jdfg5Ues4jr9cx3
	4fwfDGxiOk5ngexzE1GdyvwcMSQwAqWA6GNslFGwhQs1axI72AGaUJO29YX+6QB1wrlLrRqBrFC
	p19RBIukfj+8fC9Arc85Qy/fkjIKMkKpUsxCl5j9cTMF5si2xB1OL4IVxkUN/8KbjeAKtGhVl3q
	j3tWJqbUGp16hgwYgIAGWDWYfulSWuHZsKc0DtjR2webIWi+Hl3GAUkdzDrMgVqTyaM4dj/1SjI
	LRbSZljyKciwJ+Xy8i8dzdcuOchRm9fJgi7efkL/6jeDWgp8G6hnlwTApYzB7UjraxMrKWGFe25
	3ZIGz7OgQehQzbfLwYxQSe7TTy/HKJTX/THRIXpyo3zXF6fQNg4foA/BRWA==
X-Received: by 2002:a05:622a:1818:b0:4d5:eedd:6882 with SMTP id d75a77b69052e-4e6de7d4b17mr116741691cf.12.1759948272131;
        Wed, 08 Oct 2025 11:31:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJtSpqKBSZKvXYXxQCgdKyC4eKRCPk5+UecIUdKH5ytFi4FHdeM06tgDluKM6vR+E1V+nfug==
X-Received: by 2002:a05:622a:1818:b0:4d5:eedd:6882 with SMTP id d75a77b69052e-4e6de7d4b17mr116741061cf.12.1759948271489;
        Wed, 08 Oct 2025 11:31:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5907ad9e45fsm232657e87.70.2025.10.08.11.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 11:31:09 -0700 (PDT)
Date: Wed, 8 Oct 2025 21:31:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: lemans-evk: Add OTG support for
 primary USB controller
Message-ID: <6t5u7pwzztqbkso6nq35y6ohtjywkbacf5cug6gmtfnmnulamc@h4sbsli2bfxe>
References: <20251008180036.1770735-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008180036.1770735-1-krishna.kurapati@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX5e1TQvKPl7yK
 fb1fChfYn820BRMXd5JFq5N8JPbKgzUFUKMKXUrq3pjUCnRvSl+lGf88ybtYal170OdGg/MlfH0
 hwIlyDESCxjYn8wpZJWLRmr0I4n3Gt7O7jPKsAktfVdEY3Mnuyqp2hCAv4tTL/4e+0IVaIRZTU2
 KyJuPcdOtImcBZ4cCV/IlLkj7abVLN3Lokrpm7Fymgzvcbs2ovXdxZt/QquSITOLw/ud+JxNdk4
 cHqbmC/Q1Lw6ZvkgxowOqRSxO7RBKLYSaazgG0vng2DKw0xRDNmsc9y3N1VJmA6hFRrIL6KR6EC
 URbpboVFLK8XiArjtAi/GBSK4W5/C6YuHXWPmJmsCqZRZE8d7EKSdZce3P9XoUrizgDoKZT5g3z
 2Um5jD+gcD6iQhafultW5XAFQZMw/w==
X-Proofpoint-GUID: H9KqYFso7B-QFq6Geq-5PAscyjUy3t7w
X-Proofpoint-ORIG-GUID: H9KqYFso7B-QFq6Geq-5PAscyjUy3t7w
X-Authority-Analysis: v=2.4 cv=SJxPlevH c=1 sm=1 tr=0 ts=68e6adf1 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=WIxSJfHCS5-6cMSheEwA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Wed, Oct 08, 2025 at 11:30:36PM +0530, Krishna Kurapati wrote:
> Enable OTG support for primary USB controller on EVK Platform. Add
> HD3SS3220 Type-C port controller present between Type-C port and SoC
> that provides role switch notifications to controller.
> 
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> ---
> Changes in v2:
> Removed redundant property of dr_mode setting.
> Added power-role property in connector node.
> 
> Link to driver and bindings:
> https://lore.kernel.org/all/20251008175750.1770454-1-krishna.kurapati@oss.qualcomm.com/
> 
> Link to v1:
> https://lore.kernel.org/all/20251002172946.589061-1-krishna.kurapati@oss.qualcomm.com/
> 
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 122 +++++++++++++++++++++++-
>  1 file changed, 121 insertions(+), 1 deletion(-)
> 
> @@ -751,9 +849,31 @@ &ufs_mem_phy {
>  };
>  
>  &usb_0 {
> -	dr_mode = "peripheral";
> +	usb-role-switch;

This should be a part of the SoC DT.

>  
>  	status = "okay";
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		port@0 {
> +			reg = <0>;
> +
> +			usb3_hs_ep: endpoint {
> +				remote-endpoint = <&usb0_con_hs_ep>;
> +			};
> +		};
> +
> +		port@1 {
> +			reg = <1>;
> +
> +			usb3_role_switch: endpoint {

This is SS lanes endpoint, please name it accordingly

> +				remote-endpoint = <&hd3ss3220_out_ep>;
> +			};
> +		};
> +
> +	};
>  };
>  
>  &usb_0_hsphy {
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

