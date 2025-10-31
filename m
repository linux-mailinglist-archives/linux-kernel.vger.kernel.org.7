Return-Path: <linux-kernel+bounces-880388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D620C25A94
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E26F1B251C6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9463B34EEEB;
	Fri, 31 Oct 2025 14:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JLPts04a";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M6/zX40S"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364FB34E762
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921807; cv=none; b=S1JDL3xALv1zR3vCBG65z0XEpN3iVX4ODc6Z4MILFCChHj6dfvujPi4I8OEyoFZBXS0zCyJDKLIrpy9m797mnhasVsAGHPsl5ll+hRjU64R4dhs7x2spEGLb38JsTU70JVrVhKkiVdcccxInLyFGOBKXMtWu1Zhr/TQm2r2l/a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921807; c=relaxed/simple;
	bh=5oX84NUeLGDCVUnoaY8enUgJ9uFVY3Jp6pIvf/RX/b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRj5+grdpIjNZTAdhiPJ6ZxJL9WVGAvfMw9Bw5QKbVSuvpaJnvkupslf4IjYf+SUl5MeyyWSsWo6QNTDStMdmPm9QNaPjQM4/IjomNVX9asZLe5QCYr3CSRO2Gvka3+5o7APkwNi5366QMAplvloUFbz3Bu4lzyQ8Ny4TRzesFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JLPts04a; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M6/zX40S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V83amu899094
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=38cZqr818bP3R3sk/R0K+P7k
	RQE7pffVL4S9mTWl7Ig=; b=JLPts04aopKQrXSmOQTaQkbiDnyAlcJjXeAoyV/D
	HLe90pWkVoCl6cRbodNkDBjdjlLMJT5ginDM7GQrcBc42yP57u4rlPgBBV9gBD3p
	+EPoG4C2u30CZcw2uIpoLeJav6RU4T+t3XR+W8ll2f1BYxc24Z35Tb6i1gAPuJhJ
	n6pJoLw8q6ZeMUZj7gCEE1+GFpqIE7HJgaWWsQfKMctoKnV/Jdxsr95A+vX5qMJU
	r7WVWGCLvUp1Eegy72tKu1no9SCNg4vzEjwaA6XLcsSbSWzKYXjNLoHcqXfADZNI
	Ozvpsmjg4SluCDQ9zVhSvRaPhXJLgWEW/fMN9nogpbq8DQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4gb22cuc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:43:25 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ecf5d3b758so41720661cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761921804; x=1762526604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=38cZqr818bP3R3sk/R0K+P7kRQE7pffVL4S9mTWl7Ig=;
        b=M6/zX40SgGIujv251GaBH++jr+Nqn22tIlJO/hBJIyhsW+PPwu6VwLlR3Uwx51Q2Yv
         nYC6qPHQKQFnf7oga/IivG20lwfPpINtREBcvhTLd248SrxCtw0U42P1qvqEztoROXHl
         cnnKbNJJT+saLnGzYRA3NZllkLGnSUVr+19hqgzntm76VWD6BWbTuTy0tHO31bZ5ThkP
         Fn/vJyg4yPnYgvsdIqUVrT751H4Gm1B+9P13xEigPqSZjlI6KD23ROZeeW3LS+wuPaR0
         y3SkV2guotfQE9BHtGWfXNVsWI9Y7Hyow5cJrn/4u3TH9YnOJBaHgKbDQoYqZmfwWnKz
         53QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761921804; x=1762526604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38cZqr818bP3R3sk/R0K+P7kRQE7pffVL4S9mTWl7Ig=;
        b=dS2MaxmArgygRklQAfILPeTDiIaCi+NMIcAdZouDFGV06ZpnHLj4oZzLdaqeBPAS1c
         59rBXt8klmHy8rXJJafbzYuJCyu73ifOHEPLVS0tuxYX6uaevxWbTuIaYM0PepYSXMuZ
         Ap7WJWOVtDUNhI6bLVl4u516Nfy4ARb/gKZe2CpBP+nU+qU2KQexedT6kQII8/Sv2iaY
         CGyGTAptcH9BIv6eE8ngbxQGoLVnq5SYDFLd+uSs7eHSyuXoVO2lJRSHgc+GNq6bmepe
         UAH8vnsyhYM0OH+2RflOZGG0z0h9C7QSyD21NKZrxYsUzQUgQfIM6xwlxcT0dh71HhnJ
         tTWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvyVHIWMwt+2ElHQZXNvQvwb9V9JJEvuBHFKOngj8erA+lXQ6etsY+lJX89b2FKrXPs/2Zy1GUj9bHsgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwreWu37pEg6h9ssP4/DuFzXIsAc4YiaheNDvy+An6htyCFoA2r
	BBicsbtbGZ2olrQHdI4njQ399pxsyUNBwdBwtW2XupC1JWM/wt0gh/OyBojHVRy2keTZoSdwKx4
	3xdc8dIxx2FU/nuevXAEAn78ihHCFKxg8MixXuLIoyEF4HeElWJX6VOhK3wCoQAHMcKg=
X-Gm-Gg: ASbGncsq5SACOuDglrf2IvBjM2FGZcL3PMIw3EYSPPb6N43PcoYYs9PdX496ldd7jn9
	VuXWTz36VU9sEw9LIunsLVM5PZ44GYqAtQudfQ9+h9A3Fx9Pr14kFvowBC2pov3E6Bx50JEo+ii
	0cgqAW86t8eWlDIMR4sfF3j6z/3Z9FtSJN4qhgGYJdyvSgk8zQlCymzxfyMCvzVV7u1FUiGTmdH
	YG/DO3jl+fSQI8ktQ/Bp5281NrDEimSA51rWpHwVX7gMYgg+yzeBt4XZHZMZjqMzfdFgxNs2VgX
	cGisTNmJh4ZgXeOFI/4QkP/QJ+aBSdnzyrn6DqFiJorS++dkGsHDNycSesU8VGjbQBTj4U5AbPI
	1viC5BoOp+elRxIB2AFHf5l+FDjztCGkSIvsFPOjQE3qbHyALjWUCSQcNNrNTnRTxV6RlH6RD00
	N1XhPPRgEhNJnl
X-Received: by 2002:a05:622a:418e:b0:4e7:1eb9:605d with SMTP id d75a77b69052e-4ed30d4ef35mr40414271cf.11.1761921804231;
        Fri, 31 Oct 2025 07:43:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRqfymtoA7HV6xrx57dAac6CGoayjsZUzza90k4x8oucfsGlZ9mGgHYLl+rCflp4srP5Ygow==
X-Received: by 2002:a05:622a:418e:b0:4e7:1eb9:605d with SMTP id d75a77b69052e-4ed30d4ef35mr40413731cf.11.1761921803611;
        Fri, 31 Oct 2025 07:43:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941f5b5c64sm533601e87.51.2025.10.31.07.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 07:43:22 -0700 (PDT)
Date: Fri, 31 Oct 2025 16:43:21 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Subject: Re: [PATCH v10 2/3] arm64: dts: qcom: sm8750: Add USB support for
 SM8750 MTP platform
Message-ID: <35fup52g3x74fzd3u6irfetikivmuamzcihewaimgdbqnvfz57@56zsehp4sqzq>
References: <20251031123354.542074-1-krishna.kurapati@oss.qualcomm.com>
 <20251031123354.542074-3-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031123354.542074-3-krishna.kurapati@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=efswvrEH c=1 sm=1 tr=0 ts=6904cb0d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=3KAOm77SupsxBO3OpsYA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEzMyBTYWx0ZWRfX2BHn8nPEWc5l
 5FkMTTOkcEEB9/aJHZJjSknhUQxcShorGF4nRqIC1n57nbguEGgyDFUVYOTx6Jriv+wB0DpKFUP
 cdQwK0W/BAzbZ+crJRehN7+7kUE/EExWiD2ZaUIanDj9DOjW3Rnx1AtWx8IbaK/c/uoZT3Zsp8Q
 jIaDzCzVPXTxrD5EBn1qedy80f/cPbYXCsCc513mPCXCiwj5lxDQKnVzRd7QEPPvQsn6BJ+G7uw
 M0la4Y42EcMU4yy9WdHvDrOXs6vRXnMNzabgMKporqCeEBMbmYQUIxh8/iiegNDLYgzUvTgesGq
 QcovtUrQal2VYAT4H0QPdgsROp3Evq/xKM+SPMOty3HN886pTTCha5LeCHi/oDuTGchgkpGJcJY
 LqrLe63w9cvBRpiWHgJuZat+UZCqug==
X-Proofpoint-GUID: NdwCh-5UjPU2clEPIhU0ysX9JR4MWAdV
X-Proofpoint-ORIG-GUID: NdwCh-5UjPU2clEPIhU0ysX9JR4MWAdV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310133

On Fri, Oct 31, 2025 at 06:03:53PM +0530, Krishna Kurapati wrote:
> From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
> 
> Enable USB support on SM8750 MTP variant. Add the PMIC glink node with
> connector to enable role switch support.
> 
> Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
> [Konrad: Provided diff to flatten USB node on MTP]
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Co-developed-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8750-mtp.dts | 73 +++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
> index 45b5f7581567..932aeee70054 100644
> --- a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
> @@ -191,6 +191,51 @@ platform {
>  		};
>  	};
>  
> +	pmic-glink {
> +		compatible = "qcom,sm8750-pmic-glink",
> +			     "qcom,sm8550-pmic-glink",
> +			     "qcom,pmic-glink";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		orientation-gpios = <&tlmm 61 GPIO_ACTIVE_HIGH>;
> +
> +		connector@0 {
> +			compatible = "usb-c-connector";
> +			reg = <0>;
> +
> +			power-role = "dual";
> +			data-role = "dual";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					pmic_glink_hs_in: endpoint {
> +						remote-endpoint = <&usb_dwc3_hs>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +
> +					pmic_glink_ss_in: endpoint {
> +						remote-endpoint = <&usb_dp_qmpphy_out>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +
> +					pmic_glink_sbu: endpoint {
> +					};
> +				};
> +			};
> +		};
> +	};
> +
>  	vph_pwr: vph-pwr-regulator {
>  		compatible = "regulator-fixed";
>  
> @@ -1200,3 +1245,31 @@ &ufs_mem_hc {
>  
>  	status = "okay";
>  };
> +
> +&usb {
> +	status = "okay";
> +};
> +
> +&usb_dwc3_hs {
> +	remote-endpoint = <&pmic_glink_hs_in>;
> +};
> +
> +&usb_hsphy {
> +	vdd-supply = <&vreg_l2d_0p88>;
> +	vdda12-supply = <&vreg_l3g_1p2>;
> +
> +	phys = <&pmih0108_eusb2_repeater>;
> +
> +	status = "okay";
> +};
> +
> +&usb_dp_qmpphy {
> +	vdda-phy-supply = <&vreg_l3g_1p2>;
> +	vdda-pll-supply = <&vreg_l2d_0p88>;
> +
> +	status = "okay";
> +};
> +
> +&usb_dp_qmpphy_out {
> +	remote-endpoint = <&pmic_glink_ss_in>;
> +};

usb_dp < usb_hsphy.

> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

