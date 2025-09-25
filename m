Return-Path: <linux-kernel+bounces-833320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFD3BA1A80
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFD6F188C21A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF23C26FA5B;
	Thu, 25 Sep 2025 21:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c7u+liQd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDA019C546
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836727; cv=none; b=lSyIYBDnkayoZv6+cZUXaaohiY8jIFpnQC9qzZ1iqdw9X5NKTMFv5fJr9aDCr2hvPHEQCLYQd84zwmjjeVhwiVrTEXdxB+naaRvnOYI/yfLdgaBI3SznVOmNdhUpMnkH3NSZMH+CziGj8Gio39a7oXK8+sFMVFPE5ZiHxDAHEqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836727; c=relaxed/simple;
	bh=YhLlLoCcel08r9Gx/Qu2bGRQ4+ve/mWhng6cCkd6vzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HktB9JMqYyxwW1feQW24SGJYpJ9KJU/KFut+ehAP1A70Rs1hb8wyY0nmMmgTpbcYoDyDV44LhOcIDDQNjd2CiTxFjb3yN0Fm4D0vQHl43lF3T9dk/ybAc2l7T2I+7qg6OCwx+y4tTMrQNv7Hc0mta+3UTgPWW9fuM8UVfU7qWsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c7u+liQd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PIPuuT025396
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:45:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EaWCskU7/xIy9v9EzPg9EedR
	NsRDoPnmo+iW5K02zbM=; b=c7u+liQdik0/p4p8xSVjRh4dmJiO0AAOxax1PKXZ
	Fu9la89LPXABeg6F7/osgY45pAkvTDaU0+AgHmzc2RoaQiExCl7e0DEEK/6HFLYn
	d8+IfxNoLFhEh/VOEuiAFx0nCO5T23zZ+M8qBGqZzS55X/d5xCuhkjbkBRdLiC28
	uP7/9NS8YADtYd53Thcmso/aLfmANHgTQcuCemlZJn+M6xyruxaglxf7buDfwAMS
	z/9NtAgjmkrPic6sI+ElOd6RHQm78ziQfgjfIev+//Xn3TrXP4y1q+F+ZSVYdYmk
	R4vCerdHSr/wVm+UrshwfdEF9gFSpC6bpIMGoQgUXE37zA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0u0g8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:45:24 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4cce66e91e3so47867941cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:45:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758836723; x=1759441523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaWCskU7/xIy9v9EzPg9EedRNsRDoPnmo+iW5K02zbM=;
        b=a0+EoHBZmS/SFaQG8m5LypcaAFIf0/fdPgMAgkh44ncN7VQ7gsDfR5wmDuvpV8chWx
         cCOwW+S7HsegcLl4GufHL6eAtEZRM2H2KHNhyBoYf2cgoeMpUEj7KqiFvdqapS8+XQ7N
         zEAW1mdxqxMNnA7QJ1azVK6CoTXxqN0Hp/QFQ3L89KtavVpetjTSEAxOkdxtdvpgmRWh
         v7umpjirTKBuMRUYB29MSW38vR/qCHKA2MZNNh+X2Aj5IWW3iPq7JD3flMviN1XJT7KK
         12+YQF0lIu3EVVBwBMqZ+j5UsoonZL/x84xXaGrEer9suN3VT60A33iX4BqAZdgPmtVy
         955A==
X-Forwarded-Encrypted: i=1; AJvYcCVZXWaEsqtbqJDrmjJlzqLMTFQM82uROXUgyVvp/lQcIM4WJ2Y50ksZ9GGgDxHz0GIsKld8bLhxrAk4aiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGQCo0GvJGKJoG9PsQKzYdMj4+LOwDy/F1yLJ+oHpvUJvSyjsr
	fVyIYhtUGfC/dFeztH+8mEuBy+IY3rgow6US4yzzxTmbyWtowqUOVzgjUk/qal0R6id/fCRVZSx
	DkAE0EddvuHCVNG6ECs2HuaT15C845oouUc/ZapD2cUQUfaHJwxqGDHYwjs8cZyMfV6w=
X-Gm-Gg: ASbGncu3U9Q640UQ/n8cFlieohbY/II6aA5ijoDH2WV2BD4JTz++GesZgub19HlkVfm
	SWiKJhtLWHZ7PvSyMLqfW1KGGs9AH51V4rdADwnJ67AOZH6mVbQqaEWE1qgvatHIkQ5beoTbl36
	2yp29GJzWhpCseIqYNz4Pxh2gKKY0r5T4QX3jd4uVgYQsP6Nxyu90SoLRa2/sDAZHKxvy7OhhIP
	peZV2teZKznoSs2C3KeOl0SA3NCzQYqHcNSiE4xlC1UdQpp3pHxyHl0Y1fsiBi19qsu7eZD7vtD
	mlcmmo5lI2STlh7eue9lT0uFsrPBR4HVPdxLcNn7sYs74l4wsgO4GBJSSC+StSNqf7PTgG7oyqm
	4exbHBjALBb5C6zs/CuSbYzsmfOTaMhu2BHFzXetU0ZI4Dx8wPRZ2
X-Received: by 2002:ac8:5a4e:0:b0:4b7:a16d:e5f2 with SMTP id d75a77b69052e-4da4cd4adc9mr70027661cf.65.1758836723073;
        Thu, 25 Sep 2025 14:45:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ8rvJdYnnVBaGZNPhC5D43eUt6pM6CHAIbkFZJDrYJzaS1aYSU4CbABE20Vz4oU/8LstcPw==
X-Received: by 2002:ac8:5a4e:0:b0:4b7:a16d:e5f2 with SMTP id d75a77b69052e-4da4cd4adc9mr70027241cf.65.1758836722550;
        Thu, 25 Sep 2025 14:45:22 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36fb7fe6924sm8076041fa.61.2025.09.25.14.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 14:45:20 -0700 (PDT)
Date: Fri, 26 Sep 2025 00:45:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Mahadevan <mahadevan.p@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: lemans: add DT changes to enable MDSS1
 and DPU
Message-ID: <5nkxxydmtjt7hzp7v5ym4crx44d5o2v5jsq47bxehzzihyy2bs@owvruxcbde6a>
References: <20250925-lemans_dual-v1-1-9c371803198d@oss.qualcomm.com>
 <b1c12696-9e08-47f4-8fd0-11e415af187b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1c12696-9e08-47f4-8fd0-11e415af187b@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: qlhifzNeE9COZVAJnLYAjAjhCfjWo-k-
X-Proofpoint-GUID: qlhifzNeE9COZVAJnLYAjAjhCfjWo-k-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX5dwBgiRYoW3c
 0k17nm3rUHRLe2S6larOMOZoiDPQpROmxBn0bJNFT3VV19ZGHO8xZ5pB68/h2xxPJof4rhGqJCw
 2669kqI0aghguQ9NGmN9WnomqcROyQ2JkzK3k+XfqIDZbol0kjMYe0z0RLkrbghRx5wpgMD720M
 CRTg30cHwWWCqEAF3TlBkvEgv2F/w/m5Jy8K0JrdbEP4GgTOxt3w4n9BDX8bXZLqiTmW8V9pgRg
 AzHM4QQGBYtxVED8lpcSKqjWIE9A1Ov1QLLdVZ5vm8W1HpqshH19f1gG1Uy8Ak25vw4KwpyPORl
 NYBVuKmkg2RvjmUKJnGazoIxxRLY4MU2SSeM51yZ7aG0R8secpatE4aHXdidwfTQRj0CcHERdMZ
 Jj+ykbN1qRw+uwJBQS9fUhYaz5N0uw==
X-Authority-Analysis: v=2.4 cv=ZsHg6t7G c=1 sm=1 tr=0 ts=68d5b7f4 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=V3-xdiz-50e7mNWZjwIA:9
 a=LDN4jnY7WN4wdhk6:21 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_02,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On Thu, Sep 25, 2025 at 12:49:48PM +0200, Konrad Dybcio wrote:
> On 9/25/25 10:58 AM, Mahadevan wrote:
> > Add devicetree changes to enable second Mobile Display
> > Subsystem (MDSS1) and its Display Processing Unit(DPU) for
> > Qualcomm LEMANS platform.
> 
> No need to scream.. "lemans" or "LeMans"> 
> > Signed-off-by: Mahadevan <mahadevan.p@oss.qualcomm.com>
> 
> Please include your full name in git config
> 
> > ---
> >  arch/arm64/boot/dts/qcom/lemans.dtsi | 88 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 88 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
> > index 48f753002fc459a3e9fac0c0e98cbec6013fea0f..45c11c050d3f8853701fd20cf647aef5c6a9a8c9 100644
> > --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
> > @@ -6751,6 +6751,94 @@ compute-cb@3 {
> >  			};
> >  		};
> >  
> > +		mdss1: display-subsystem@22000000 {
> > +			compatible = "qcom,sa8775p-mdss";
> > +			reg = <0x0 0x22000000 0x0 0x1000>;
> > +			reg-names = "mdss";
> > +
> > +			/* same path used twice */
> 
> this comment is misleading
> 
> > +			interconnects = <&mmss_noc MASTER_MDP_CORE1_0 QCOM_ICC_TAG_ALWAYS
> > +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
> > +					<&mmss_noc MASTER_MDP_CORE1_1 QCOM_ICC_TAG_ALWAYS
> > +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
> > +					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
> > +					 &config_noc SLAVE_DISPLAY_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
> > +			interconnect-names = "mdp0-mem",
> > +					     "mdp1-mem",
> > +					     "cpu-cfg";
> > +
> > +			resets = <&dispcc1 MDSS_DISP_CC_MDSS_CORE_BCR>;
> > +
> > +			power-domains = <&dispcc1 MDSS_DISP_CC_MDSS_CORE_GDSC>;
> > +
> > +			clocks = <&dispcc1 MDSS_DISP_CC_MDSS_AHB_CLK>,
> > +				 <&gcc GCC_DISP1_HF_AXI_CLK>,
> > +				 <&dispcc1 MDSS_DISP_CC_MDSS_MDP_CLK>;
> > +
> > +			interrupts = <GIC_SPI 865 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-controller;
> > +			#interrupt-cells = <1>;
> > +
> > +			iommus = <&apps_smmu 0x1800 0x402>;
> > +
> > +			#address-cells = <2>;
> > +			#size-cells = <2>;
> > +			ranges;
> > +
> > +			status = "disabled";
> > +
> > +			mdss1_mdp: display-controller@22001000 {
> > +				compatible = "qcom,sa8775p-dpu";
> 
> Adding nothing more but the DPU isn't very useful at all
> and doesn't really let you test the hardware (since you don't
> provide a sink)

Only with writeback.

-- 
With best wishes
Dmitry

