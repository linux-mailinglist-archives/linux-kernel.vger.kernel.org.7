Return-Path: <linux-kernel+bounces-800311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3710AB4361E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1BD404E559B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AAF2D0C79;
	Thu,  4 Sep 2025 08:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jzWBWKeA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5E72C21CD
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 08:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756975256; cv=none; b=KKH7iLSUk7YwRP8x3Z6QeGFilWzgRNMg4MnEmSGQ9blxacVjWsiMjBzfmVbZ2tyshJ02I43uDFUSnwvY9LPSR/WGnbNiliN5WjsZBluz88dQHqMYC+vi/K5lOXQM7ZdRKSKX0SiVlpX9nCPELpJscBkitoDw8pcO9RMiRvqKee8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756975256; c=relaxed/simple;
	bh=NeuaUx7smKmYtWJXPRDCSomZ5mneveiatz9Nf9EB2u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUDrbuHmGZJvRWHJFT3zu4a7uTttDcn4i3YiD7HC8NoXaZOexl0vSWJupMYUiCoj74Z4qCNL0i+S/gK5QmnYCwfVcLPvq+odvxzA2BLl36DYdI3v2TWBibl0LHeLKr3z4KhyAnjjU5+fdnngn7qKzQa423P5ZdBekZQL1/xAjN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jzWBWKeA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5840bfNQ006037
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 08:40:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LVRFBw8y4TYM0aV+IQrAzF1l
	KHpBMR6sAe/MnFd5W2o=; b=jzWBWKeAKpndbqbxCUK94/bpit/U2ASgLoaqpyKR
	iq6f2IvpOPsjCXSb4dOlBcfj0HZwmrKEwdm0pAmYAcMZ27rCGVNbaiuxqaeQmaRL
	ww8ynHlEYTgXkARIEA4SrublB4toxeQprTmMKC7HMajpw/Yb0zKDZUhn9nABOgO6
	mLcua/gsdL4g6Cmec5xbPZ3zW8xxv6jaHsCh+D9uGQ1PTM2onq/Yio7RC8T2RWoE
	9+Em7kGE84DrwvV2SQrW1LRy3acqFAgSRj5jl71LdKAJB5XA8HZZTapllwclTDVN
	063Vww36bMc/WHYy8tnHeg25lGfq66TuHLNqtx++ScIflw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8s6vex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 08:40:53 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7722ef6c864so803536b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 01:40:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756975252; x=1757580052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVRFBw8y4TYM0aV+IQrAzF1lKHpBMR6sAe/MnFd5W2o=;
        b=mVCQq/4QWD4RQBam8Jl8xlgBgsvJbWHJHGBjLwC5k7dUmVvSn4kQVpml5g93Wk9SCW
         ZqqL7LMX4jgfACjEF4Ucq1dsb9HCS5jhElXRA3MeX5A4pRdI42dxIqrV5gI+bJUDI8iY
         oZ4i0EJrBbGTevsudzy+rT1AyI9pXasRIQ4qiKPl4mqB+ewjAxpKeXGcn7cbfUCvABWn
         FYNVIjidzb0R1cGQamEUMwzl/rCq9gqzIPjxiw4oki/lRUiTZzsoWbBhmfktsj4pJIPa
         XnQg0RI3RhukX9bJkjjW35LH+iDvtFLs/miiOOz7UA62gU5LZsavYSdmEJ8fSP+3uzrr
         wk3w==
X-Forwarded-Encrypted: i=1; AJvYcCXcOPhqdpaLgl6bPdDpbB/7JqpfvTUQXijRNk+EZqsJwMN10jPJEdg2iqNjMogMJ5pOuMBMvDUInb6gMDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+OxdDEtv3wlJvQkd9PlbJPbKEkLmtLDfh6JXG05HkHg7cExRr
	/oC8yXHk54PQXCJ2C55vvMQQQqxc9h+Go1PD/Ko1iYTjgMPXYSFE9Fp8TkDm2cPJf6zKsiKeRxn
	izKaV/DQsTNdEDmNLKj8OUXK7ajGCNF8dBUTpPncAS6QVYGs0lduDfVf5ogmhdReVlZE=
X-Gm-Gg: ASbGnct/FMMHeD4UHTsxjknPUkYCLtHD9CGxN5hAF7fWmA4b81OaEEXzrLhTcnlNvJl
	OqMeFc7/3s4IhR+V/1YDF5Jvsftcc0JLdncjSk470paL1rqNsqIqqAkJKn1KzSdqhbjM9+legaT
	Ku0mMnObHMkX32E1Rlndbt7RudXu1OM3O9wK9rqlfuwMOwCRTSvMAeeJH6KlYUQ/k/UXzVNgaIT
	YKgAA+gVc5ze5XSo6uclD7p/7K0/Cln9iW42xmJH7lzeET72YS5Ej1F7lgTqU6189oXLVYwrTy7
	GM3aUH5fr54t9ALIG9Vw7fRpb8veR6kp1+nltiqvzdbbFqXTaY7gnMs+vzZwL+DBF5NO
X-Received: by 2002:a05:6a21:8311:b0:245:fe25:7024 with SMTP id adf61e73a8af0-245fe257561mr7818355637.30.1756975251863;
        Thu, 04 Sep 2025 01:40:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHShG+ywVPwMMnN5ITlEBaV4t7zgpBVXXayaVZuxH1iz3KDcZhyTFEKIB2j/DH6XqeArvxfnw==
X-Received: by 2002:a05:6a21:8311:b0:245:fe25:7024 with SMTP id adf61e73a8af0-245fe257561mr7818320637.30.1756975251313;
        Thu, 04 Sep 2025 01:40:51 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f317ee7cfsm11700910a12.3.2025.09.04.01.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 01:40:50 -0700 (PDT)
Date: Thu, 4 Sep 2025 14:10:44 +0530
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>
Subject: Re: [PATCH v2 02/13] arm64: dts: qcom: lemans: Add SDHC controller
 and SDC pin configuration
Message-ID: <aLlQjAmEe795u+nF@hu-wasimn-hyd.qualcomm.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
 <20250903-lemans-evk-bu-v2-2-bfa381bf8ba2@oss.qualcomm.com>
 <8a963e12-1113-4604-b15f-a5867c4b5bbf@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a963e12-1113-4604-b15f-a5867c4b5bbf@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfXyQg9xh0GLS9l
 LAOGnew73BMC5I3J/wKtD9+37uFh2HKPedJRNq8ocfjpkY5atn3Z9YVfU0IkU+9glxgI97dPm1X
 VBhmdfcDHeGG0AQctNFWelzZf1sF5T6L8o57GTIQv8+rq2jJ4UIQg0jTARZYZr/Eo5u3J7RePAN
 nRPbE80U1Ydd83+WzNWFTaZ5wzNxOUkaZQxnIZ6y4vFT97sPvFcntnwVwZxo4pAX6I2jN0K8qot
 QJ85iqXL5CtadjB9JMPD66ohJeZpUST4+kwNCXOGvzTUTtZRnSkNZQA+TmTSbZiQUYiscYHDeYQ
 UR+Tzo/4dM5pHBShRPrPCkZpBwif8uvgLbFXUnTgIEM9YUgeyGwpG/lmjymLhVKDiUIWuLXdv9s
 KP476ueM
X-Proofpoint-GUID: E_j3JFbPrObACFEY60MmrOI1ygHKqgXu
X-Proofpoint-ORIG-GUID: E_j3JFbPrObACFEY60MmrOI1ygHKqgXu
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b95095 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=k3xEAXBReI645-sCZUAA:9 a=CjuIK1q_8ugA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

On Wed, Sep 03, 2025 at 05:48:40PM +0200, Konrad Dybcio wrote:
> On 9/3/25 1:47 PM, Wasim Nazir wrote:
> > From: Monish Chunara <quic_mchunara@quicinc.com>
> > 
> > Introduce the SDHC v5 controller node for the Lemans platform.
> > This controller supports either eMMC or SD-card, but only one
> > can be active at a time. SD-card is the preferred configuration
> > on Lemans targets, so describe this controller.
> > 
> > Define the SDC interface pins including clk, cmd, and data lines
> > to enable proper communication with the SDHC controller.
> > 
> > Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> > Co-developed-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> > Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> > ---
> >  arch/arm64/boot/dts/qcom/lemans.dtsi | 91 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 91 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
> > index 99a566b42ef2..9e4709dce32b 100644
> > --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
> > @@ -3834,6 +3834,57 @@ apss_tpdm2_out: endpoint {
> >  			};
> >  		};
> >  
> > +		sdhc: mmc@87c4000 {
> > +			compatible = "qcom,sa8775p-sdhci", "qcom,sdhci-msm-v5";
> > +			reg = <0x0 0x087c4000 0x0 0x1000>;
> > +
> > +			interrupts = <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 521 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-names = "hc_irq", "pwr_irq";
> 
> 1 entry per line in xx-names too, please> +

Ack.

> > +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
> > +				 <&gcc GCC_SDCC1_APPS_CLK>;
> > +			clock-names = "iface", "core";
> > +
> > +			interconnects = <&aggre1_noc MASTER_SDC 0 &mc_virt SLAVE_EBI1 0>,
> > +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDC1 0>;
> 
> QCOM_ICC_TAG_ALWAYS for the first path, both endpoints
> QCOM_ICC_TAG_ACTIVE_ONLY for the second one

Ack.

> 
> [...]
> 
> > +
> > +				data-pins {
> > +					pins = "sdc1_data";
> > +					bias-pull-up;
> 
> Please put bias properties below drive-strength for consistency
> 

Ack.

> Konrad

-- 
Regards,
Wasim

