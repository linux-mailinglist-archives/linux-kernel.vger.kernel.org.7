Return-Path: <linux-kernel+bounces-798814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA20B42350
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BCBC1BA7B57
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C7D30EF87;
	Wed,  3 Sep 2025 14:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l9Pe4LlO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331DD1F582F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 14:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908941; cv=none; b=SJJCfdXxaJrsMdA6EMfiu689UOg97lUvxCzXSpcLnLOolrs8u8v1fQHJpl6eek+4Q0nWf/FauykaiRSAWNCibQltsLheltuLDidFQrEwBlFw1wFc7bz5WweEJI6S7vAno3LErgKI6Ew3EmmA207nNq7o1J6BL4Qp/SO+M1lozaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908941; c=relaxed/simple;
	bh=HQXjdiIWY6GV0ST39+EojeXyRY7MXzjWNNCvjujQ6Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHtDrjkQjv6GUg4dmc2I4GUFKCPzaPIwZ9b3MJYlW9KpDjV/uLwJoHfJ1uWN5kojOaQFTEorQJ8qBDNmiAGRlNfdAPAnDaY8GqX1U+sRWcGyh7DsbRJqyyF98OWRhTzu5JTgPuhXfZhbgVRlnf3LvVaaVzQxhMCVmtM7fZ+uIq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l9Pe4LlO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583Dx4EO003933
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 14:15:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=0VzNlel62yPa+SyyPLg/se3d
	IslRaGTpf2G+ejZAHH8=; b=l9Pe4LlOnoJ7lcxOaTdXD1cd047A5yETSUzBKRe1
	FVMxnYUuITdqVMGblNqGWiVr4Tgc7G5P0EmYS/AfBI+vGnosTAPDZ8m3Gfx3YnMi
	lK3cRRh0UaUtcBgz+r+UO2qmoe4CBC6htGghMVkfFe3lt6Y0kNINsSk7LKUbGAiT
	BFyc1nnSZz4JVJfFd61GndKLbYtJKFY9uoLZ20Yyz/XSDVfVzfF9/Kq/RfII3tvH
	6oJUHOTxo1lJhi8j3cBYC2q2N2zVhiw/6Uqn8lIP2/FWWcn0uA9acvBGfXF6wgoT
	Aps9MBcN+Xn9vHhEMTL6Z6vC/++J8x0UHT19QIHYC28tPQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8uvvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 14:15:38 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32b698861d8so607491a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 07:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756908937; x=1757513737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VzNlel62yPa+SyyPLg/se3dIslRaGTpf2G+ejZAHH8=;
        b=HvZmHyj37n+xk59gSYGmKTqi4x9MmSkwgDTkwOo/XAZYN81Af3uiNYAHqgQwjgReev
         wQsa01adRDB/qkI/gdnGIcrRL/bKJQ/rtHH4fTkJNQnm0ZCnY2m73XSpVKVq3ieSJo89
         KI0d3HUVzYZMnpK79+T6yc4k9yI59l9FZJ83zsSYnu1Ti0ZMdfC10CNfW7hmt+r7j8ng
         rggGO/Pqg5dtD17wFXvnmekqsoFFx5rG3xwjnPZQWhHhmBgzILpbN9T+EQ/nMvxaLTRH
         mmIVAj4QMhYo2JCARQV9kWUV0gB8YtoZm25+fMWP8uvYXaC6QtvGl5FpymQKhJ+L33jr
         hjhw==
X-Forwarded-Encrypted: i=1; AJvYcCX2ERUpNBFnXLPMgv6v/iFpZN0PHzoi7HnAJZryoz+TLlvBQyd26pL42pbUcF4N4Jyt9sjfzLSS8nEKOxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUEbeydpcrjP3Wm7u4JvA9fQZHGvYhlnL8utfTJbCVgMDIdoka
	3twyhx2AovSX0njqu/PWEVhmu/jHlK9syKm2TmYS3QOg0K4Ta61PDJt/Y4zAWt19vvPXJiv3zKg
	FYhYVVbIGIFQGB/DWO7Pjorsevm6nNvxgfur+C9E62uLkv7mDo2JkVXz3bpIbWEOaQmo=
X-Gm-Gg: ASbGncvmPEapnCzmFTTkWlo7zv66d3ISNF94W0AzejLAj0fEr9DOwe+iIttn5jPnHeI
	vLrzYBkDM9QKTr4yvADk+2AaBpvv1JfbxuUxsWw04d1ydLAM9YtVN//BfHS+ieaoZxihTVVp1yc
	67kjzaJ0+8wG6vRIxLPF3OcUuv7wAt7vTNmFNksZ8g6xHx8aZTbSN8ohMo0v6orAzB7oCnKaiIP
	FcQPufc0eCtzghbhSBeNL++sW7oahzka+JwxXVP2gqtYT7EgYatjfHAyMS9/9V4dWg62c9JU9Yl
	g16FFwZejEa0w7pX9EQJW3AQhEa0B9yL3FqYxIUO/zpzMGhNolArBW8P1B/jLWB6+kD/
X-Received: by 2002:a17:90b:570d:b0:329:f535:6e3c with SMTP id 98e67ed59e1d1-329f5356ef7mr6857480a91.35.1756908936218;
        Wed, 03 Sep 2025 07:15:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyr3tjnshT//538kzr5X5b0VHSeB28iN4p9ecCqREiYD9oSxtfYFdYbnWB2PiVBs2MwLu25w==
X-Received: by 2002:a17:90b:570d:b0:329:f535:6e3c with SMTP id 98e67ed59e1d1-329f5356ef7mr6857406a91.35.1756908935730;
        Wed, 03 Sep 2025 07:15:35 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329f633749bsm4435336a91.27.2025.09.03.07.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 07:15:35 -0700 (PDT)
Date: Wed, 3 Sep 2025 19:45:29 +0530
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: Re: [PATCH v2 05/13] arm64: dts: qcom: lemans-evk: Enable GPI DMA
 and QUPv3 controllers
Message-ID: <aLhNgQJtimNmiN31@hu-wasimn-hyd.qualcomm.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
 <20250903-lemans-evk-bu-v2-5-bfa381bf8ba2@oss.qualcomm.com>
 <olv66qntttvpj7iinsug7accikhexxrjgtqvd5eijhxouokxgy@un3q7mkzs7yj>
 <aLhMGqYGzabIoyjS@hu-wasimn-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLhMGqYGzabIoyjS@hu-wasimn-hyd.qualcomm.com>
X-Proofpoint-ORIG-GUID: Xcct8ZVYvutPtlXf4or__-Onodjnp_z3
X-Proofpoint-GUID: Xcct8ZVYvutPtlXf4or__-Onodjnp_z3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX/m+3XWpAvWAu
 isRWFQcE/NSVQvlgPd2/IRsYffDc/BAS82IhTK4Yu0Cn5ZORM6RWywHPNXIWkq2/DDKUYI3w4Qy
 g+gmRHbjQ2t+l4OhnHdqZM5GT7nnSTWqEvdjxEBe6R04WgUehDmiZOxHOw8zjul4w34TVfxgdi5
 tuGFHZTxnBaYb9x2W+xEu9T7NuD2k9nCC1xF7ug0la2CPKeq1ZLiDZUq+qggZrGSiC26uwKaGKw
 nr+wtt6R3rxqNgJwxRmrJ5ClNFQgtpyu1MOkdKQqzCbz+zv/fwOjjyC2YRN35N4g+6mZY5uNBIe
 BzXa5wGqqyS6/I/YUFcVqN24upWvpA40jNF/tCQcxoFD3X4lpudWCUSr9hz2+7GfBhv4WzmWcbx
 /Jgm3PTP
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b84d8a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=M4mhlKS_8liedgrrcqYA:9
 a=CjuIK1q_8ugA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

On Wed, Sep 03, 2025 at 07:39:30PM +0530, Wasim Nazir wrote:
> On Wed, Sep 03, 2025 at 03:16:55PM +0300, Dmitry Baryshkov wrote:
> > On Wed, Sep 03, 2025 at 05:17:06PM +0530, Wasim Nazir wrote:
> > > From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> > > 
> > > Enable GPI DMA controllers (gpi_dma0, gpi_dma1, gpi_dma2) and QUPv3
> > > interfaces (qupv3_id_0, qupv3_id_2) in the device tree to support
> > > DMA and peripheral communication on the Lemans EVK platform.
> > > 
> > > Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> > > Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> > > ---
> > >  arch/arm64/boot/dts/qcom/lemans-evk.dts | 20 ++++++++++++++++++++
> > >  1 file changed, 20 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> > > index c60629c3369e..196c5ee0dd34 100644
> > > --- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
> > > +++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> > > @@ -277,6 +277,18 @@ vreg_l8e: ldo8 {
> > >  	};
> > >  };
> > >  
> > > +&gpi_dma0 {
> > > +	status = "okay";
> > > +};
> > > +
> > > +&gpi_dma1 {
> > > +	status = "okay";
> > > +};
> > > +
> > > +&gpi_dma2 {
> > > +	status = "okay";
> > > +};
> > > +
> > >  &i2c18 {
> > >  	status = "okay";
> > >  
> > > @@ -367,10 +379,18 @@ &mdss0_dp1_phy {
> > >  	status = "okay";
> > >  };
> > >  
> > > +&qupv3_id_0 {
> > > +	status = "okay";
> > > +};
> > > +
> > >  &qupv3_id_1 {
> > >  	status = "okay";
> > >  };
> > >  
> > > +&qupv3_id_2 {
> > > +	status = "okay";
> > > +};
> > 
> > You've added i2c18 device in patch 1, but it could not be enabled before
> > this one because it's a part of QUP2.
> 
> Thanks for pointing this, I will update it in next series.
> 

Also I will try to update the clients in commit message too.

> > 
> > > +
> > >  &sleep_clk {
> > >  	clock-frequency = <32768>;
> > >  };
> > > 
> > > -- 
> > > 2.51.0
> > > 
> > 
> > -- 
> > With best wishes
> > Dmitry
> 
> -- 
> Regards,
> Wasim

-- 
Regards,
Wasim

