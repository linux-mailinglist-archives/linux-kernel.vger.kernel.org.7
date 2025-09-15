Return-Path: <linux-kernel+bounces-815941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE81FB56D40
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 02:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C1D4188EFC5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 00:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68669189919;
	Mon, 15 Sep 2025 00:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GPInVoiF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B675153598
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757895595; cv=none; b=a12maE336A6ccvNkgX/JUVDNVUeWi0E7IZos4MMdmfwSJKNYgSgsQeZihmkZT7+Lfqsuw3VDhbQgGRSTn/FaGOMEyJFIegL+8/Q10nydVfJXUr1aNZzOOQTJ+mnBbQRY+hK2vx4UhRpCYWni6R8dGpdsp1YvpJ1yTsFJUdtLPpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757895595; c=relaxed/simple;
	bh=Mt0agHXYjcgJbC62txGxd9j3OcLaiV9jsFfBZlS07lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o40KXPdqftUanHOixwECbu/6XeMarqg+Swu4rDzVQY8qfAR2bQfy18n/36/hcOgkCfjTKupijMISzmQ3cbBJt24WyvtfBwi67UPphhwa/m5M65//gQRgKnq2PF/IRnJ3jtCebElKmhKeFi9V1kcp3K2V+qFY2khWUSvvY8Ylpmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GPInVoiF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ENUS3G014089
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:19:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=p6RUAlaocnqnR7wsuVRgu77e
	RMC9aNnV4DXxPUYw8Hw=; b=GPInVoiFYQo2OarqZGwbhvWQaGWsLSYZOl4meVGs
	28ZgxCyb1L5B+upgUtVCAjNW0FLH415LGRVTsolIk1wybeoBT0PPXUNL+0rlISCH
	FIWZYWCYvcjLywfZkwsxxNu375rXKpJ+ban/cxZagC9G7QHJ3+SDdac+y/oxdJPo
	Ixo0bQ0lB74G3wX1sDHkcb3gebvJZbTRrww9BbQfs9/OCBQ0s9MHRrVIgaV3VIPN
	/0IskUzMHpZPR6tbEbGqSuPbrjeg6INOUlwFDlm7qtMxYxvHpfAdbWne+12coDGa
	1tscG+ldHfFEMypEXxARNKd9KaiSkIT5UMsqbyozkIYXrg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494yjv326a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:19:53 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-828bd08624aso189292485a.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 17:19:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757895592; x=1758500392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6RUAlaocnqnR7wsuVRgu77eRMC9aNnV4DXxPUYw8Hw=;
        b=sCsmvtSoMxQpmqQpqBbzx6x3LG+E/N388vIt+UiXihzgJbNtNfAbAZcKoU4QlNC0Rn
         NA2RfAKDEUNUA1mVWkhOu/oQVl+yKhylJB0Ybh3ELH2/W5UOXmiy8IvhtDQvSBYnnwO2
         BGCpr2Gq/Vwv4+9qb+eS0rsVqoepS4mxxs+e+3oh7WTW+7uf6I4b585upxI8ZdL+Mc0v
         HHPLSOcS4m9bcJj7f9iIWYUSu4pL4ecHE6DATbJU2cNf30Pc0CVuwrs9c7YjTSW1GroB
         /+DZ4W63HMR2t+aX7/Bt6SH9GGHUBaoq4b2JNpHjR6lvCWB6KSSOi50PFxhmm1ceTwtK
         qucg==
X-Forwarded-Encrypted: i=1; AJvYcCU340rS9ArD1PEzmmSPgVjZ9AllMpJSBtpe3OmuuCGG+aSHCeUFWul8vpCCs0hhlQaZk4LkbV/p/XtmBcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnAm+aeV6RrUW7UrJR9LIWugRNTSizCV4XvmZxVJDmaCIvbF8g
	pTHXtyDxGqkpMOc98P3USCzYafNkB90Xt1V+xxYyGvOAF6PYhzdVFYzUSa38wBT1qgkZbLxBy1N
	4ViEf8D/Rtg+yIbKlCW9k3WXUsgwwo8+HI+ASd5GvnHO0Xup6Q8EjDR9GiJTimq/42qKazx4GoI
	Q=
X-Gm-Gg: ASbGncsdgOmSJan1Px9hmQ5Cg9jxv/ElY7KHtJMHmC6nNw1+GkcuLNSE1wfsciQl0PG
	ry+alriz2IV6IV5YlmrNKjbVJ7E+R/kKH3CsVFWz/6467hSy1cnRg9LBsOP6yvM/S31Dn/f+ecs
	DA5nAPHnJFbRtowlcQQGmoxopg8ANfnlCydMxBJpQxgeshMo9I+Ci4j9ANqgZXU9LGflhekQgEf
	ZrcbtHns0Avf6i2xRdbtdl75rLwc2EehGxbNTjiQgt7FYe4nsadSRB5ZMwBmg563c7WxoEhUvlv
	sOhMtl/JfZqr6EYRBOLRhtiaoWowyeIQ/4EBKs74c7orVnE3yS1p4lakcMTzbu8g1XfhXmG7qrI
	tdi3spFjPH8OeK+BrvlZYB5WTQyBF+k12Jt8UjhkBDVShd6W5FsYC
X-Received: by 2002:a05:622a:4ac6:b0:4b7:9c5e:84ad with SMTP id d75a77b69052e-4b79c5e87d4mr42864621cf.15.1757895591849;
        Sun, 14 Sep 2025 17:19:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCj4N70HdgyI43enSOIyoMIAg7MrsmXC9QaxOnHUaJ1JBgSkPZ0ERy+ZvYMZzZpA1N70rzng==
X-Received: by 2002:a05:622a:4ac6:b0:4b7:9c5e:84ad with SMTP id d75a77b69052e-4b79c5e87d4mr42864371cf.15.1757895591374;
        Sun, 14 Sep 2025 17:19:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f163f400esm25360971fa.23.2025.09.14.17.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 17:19:50 -0700 (PDT)
Date: Mon, 15 Sep 2025 03:19:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Paul Sajna <sajattack@postmarketos.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amir Dahan <system64fumo@protonmail.com>,
        Christopher Brown <crispybrown@gmail.com>
Subject: Re: [PATCH 01/11] arm64: dts: qcom: sdm845-lg-common: Add uarts and
 Bluetooth
Message-ID: <djduil6xb65qxmjp5qrxliskjii2nbijnd4w4rwsz4d7nmpo4f@crut3ib4hu6y>
References: <20250913-judyln-dts-v1-0-23b4b7790dce@postmarketos.org>
 <20250913-judyln-dts-v1-1-23b4b7790dce@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913-judyln-dts-v1-1-23b4b7790dce@postmarketos.org>
X-Authority-Analysis: v=2.4 cv=HcoUTjE8 c=1 sm=1 tr=0 ts=68c75ba9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=Gbw9aFdXAAAA:8 a=zNG7vcL9-tlF-_c_ef4A:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=9vIz8raoGPyDa4jBFAYH:22
X-Proofpoint-ORIG-GUID: kzAM-GaCeB4AM1WsBVpHwZn0xvW5-uUp
X-Proofpoint-GUID: kzAM-GaCeB4AM1WsBVpHwZn0xvW5-uUp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxNyBTYWx0ZWRfX/gyZ/UG2uLL3
 q91KuLEU39CSTunOauLqdQd/E94Bx8qyAOwitmIF7i9TMz0ojH402umkkKw+xchgFud/0ytiRq1
 hGxNg4S82TSD6K4kJ0vfucfgK3W7LCP3mnX+lvfvGC8B9Diax14UPzeMVvOFBg5TafJMEhpemZt
 5DpLX31k3MXVFSgxiBxjq2Y6TF7Ec/SOrYAqN5oheYnGdWePPS/HQk3zluBofv5CrWBhQLVnKkx
 r5UMG1u0txmX+fjIgWAzl0+PLjM9SAfwI/2Cejc3HnValVn5GOEMODlXqu39Fb5B75S1wOrIOBO
 cGwTYv7JqdcJ2rbrvqxmsIEfvFhNOwYB3mruOWvvAgLiuSJ2Ke4k7mAC9DbPrZ1L1Gee9DGuNhR
 5Hl3iJcL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-14_08,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130017

On Sat, Sep 13, 2025 at 04:56:34PM -0700, Paul Sajna wrote:
> uart9 is debug serial on USB SBU1/2
> uart6 is bluetooth
> 
> Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi | 47 ++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts  | 10 ++++++
>  2 files changed, 57 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> index 99dafc6716e76e25aad0755e6004dc952779689f..1acc418b943443f3ba4f8a8a1cfe2c575da11876 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> @@ -31,6 +31,8 @@ chosen {
>  		#address-cells = <2>;
>  		#size-cells = <2>;
>  		ranges;
> +
> +		stdout-path = "serial0:115200n8";
>  	};
>  
>  	reserved-memory {
> @@ -159,6 +161,11 @@ vreg_s4a_1p8: pm8998-smps4-regulator {
>  
>  		vin-supply = <&vph_pwr>;
>  	};
> +
> +	aliases {

Please keep the file sorted. 'aliases' < 'chosen', etc.

> +		serial0 = &uart9;
> +		serial1 = &uart6;
> +	};
>  };
>  
>  &adsp_pas {
> @@ -595,3 +602,43 @@ vol_up_pin_a: vol-up-active-state {
>  		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
>  	};
>  };
> +
> +&qupv3_id_0 {
> +	status = "okay";
> +};
> +
> +&qupv3_id_1 {
> +	status = "okay";
> +};
> +
> +&qup_uart9_rx {
> +	drive-strength = <2>;
> +	bias-pull-up;
> +};
> +
> +&qup_uart9_tx {
> +	drive-strength = <2>;
> +	bias-disable;
> +};
> +
> +&uart6 {
> +	pinctrl-0 = <&qup_uart6_4pin>;
> +
> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "qcom,wcn3990-bt";
> +
> +		vddio-supply = <&vreg_s4a_1p8>;
> +		vddxo-supply = <&vreg_l7a_1p8>;
> +		vddrf-supply = <&vreg_l17a_1p3>;
> +		vddch0-supply = <&vreg_l25a_3p3>;
> +		max-speed = <3200000>;
> +	};
> +};
> +
> +&uart9 {
> +	label = "LS-UART1";
> +
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts b/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
> index a12723310c8b630a4961de671ea8b60f1f8b512b..49225e4fa80e5f45a36964d5d733dc238e4413f8 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
> @@ -66,3 +66,13 @@ thinq_key_default: thinq-key-default-state {
>  		bias-pull-up;
>  	};
>  };
> +
> +&uart6 {
> +	bluetooth {
> +		/*
> +		 * This path is relative to the qca/
> +		 * subdir under lib/firmware.

Why do you need a special NV file? Please include BT information into
the commit message. Also, if qca_read_fw_board_id() returns a sensible
information on this board, it would be better to fix btqca driver to
apply board ID on WCN399x boards too.

> +		 */
> +		firmware-name = "judyln/crnv21.bin";
> +	};
> +};
> 
> -- 
> 2.51.0
> 

-- 
With best wishes
Dmitry

