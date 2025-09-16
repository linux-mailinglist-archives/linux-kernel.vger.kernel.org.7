Return-Path: <linux-kernel+bounces-818545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCCEB5931F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16F63B34FD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6B12F8BF8;
	Tue, 16 Sep 2025 10:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bg+iBgdv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659D12F83B5
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758017704; cv=none; b=dQrNCpWafpEST1aByokMWn0w5x+BrWbJW9T/88ENPh5XRLdCGqRFh5Yur+HH3NsI2J+a18HV/piIp54i+TOtzc5fK3qH9ZXI9OKVu77eBFoWhd8/eu64Ahj9SvUPEPtHmGoxKdS8CrZGbKdFHOgzsI8ILp37byPN+7vmmaiB97A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758017704; c=relaxed/simple;
	bh=+EHE6h36GP4hqZxcdvHcymNoZdBzFbv7bXJmCFPI3jE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucFUepeTBElCENL2XrEmM7dxUKjfz3+Qw99LLOt3UfLSkrmF7KVxrJC7EDpO/1AiR/bCCpWYa0Tg6nBT5XIR0fx7PnHCjfuJYDXBZw2icFuRXnLoO0y+NhHaDujsUgGUw2SziabcQkhavGjsS/5mSZfDpS9ncBNF2LsxmBvvc/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bg+iBgdv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GACdOt020146
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:15:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=5Fwmjx7MBs4brMM/94CNwnzV
	GXNy2F1qKzPpKtFQCHU=; b=Bg+iBgdvUIyXugJM+YPaO7kKCBNc/nZ7Wr3VCJyQ
	vS2vC6F0mzGDcyuE+PAYKRIGTnKiSJS/PSn5doxNyYfWz/2RFBxrWAEfyO3YAA8W
	zMHEzWbsWjMpeDFYjfzcjNG58IEnPHy2Lemd2zhYGcggzOoeHoexuBLFd5GujR7+
	4pVmagcySGqQ2qor2NE9OmvzUo+z6SN9eFptJykoNxDku/2qTRE5vfA9tjkDSYCd
	yPqYGtnuhlcrk/v887rRbMNksXY71LYgnWFd+wzLca0jgdA4D8H2O1HcUkS0Rh9s
	iKPqFKfch+MRYOYiyyKjlZTS8xtFctML2ArXIv1aVLzmXA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494yma8fnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:15:01 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-76d3633c86dso90319936d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758017700; x=1758622500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Fwmjx7MBs4brMM/94CNwnzVGXNy2F1qKzPpKtFQCHU=;
        b=CdPYwTILAfqD68ICtuG3z82Gi2+F49+gzSgGKStexSKTAxIEZgA9Rx36wdhDn4ne+L
         eJOGL8Xx9zXZwsJZKimCrqaVxnHbNZD5mEv4pXnD96Noh+WX9Y0SMHQTRi3l6NKp8dW/
         s2t052ye1ZTAAV/vEHHD0OSnYKGp8Ky7Q1ReA8CGbOcsMS5rBdPbfLnyAuO8kdBInG8Y
         lJ2fo3Vz8rD9AANvLKHmSUIKg9V+Qc9qgV9Bg1LL243+3RN4bPf85ZttUFPu9joAYufU
         toE0WXoAIoFPNUAWy9XV0tTHhZp996DlAH7h1+LIuZwa2Gr9UDLcAsNLmSDOj01XgfZ/
         o/+A==
X-Forwarded-Encrypted: i=1; AJvYcCVGERHMf8byUHZgVLLm1aIUD2G5f2LObm8ayoMDgCPQ6p027p7qFOLt1uPuRDkBSiI++GBkk0d5zp9nND4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL0K/7Jl1KgtQsELBmGHtSIV1TJnO/lx2nR6TdoYWm19PUBD1h
	EW8aisH2O+9Xn/MpCvI9g5lKYodXH/IuUwvs4M6jCUX6YDQQnagOTARavTi0d+m+Uass+sqQrk4
	ttvKypyO261emcqkX4m2OOgmVR0LsoG+bTlUFfYrmyQZXjFwnFm8KknXw4cVt+UoS0OM=
X-Gm-Gg: ASbGnctkfLu3s+RwwFelgMtqgmplqa3RKhQLRzxb3/Jwsx9eFrEsyM84efZPCcZWV2q
	sX9vQvVBkE4aoz9i1GJL7D8dV8ZOqwf26N5Ne6/e9W+IXsOSqnnFTGHWqkip07fAWgHSEUgphGS
	LxtwosiIu11keyDh6Apr6vv9TDVqIcnGEOQyAXNSJ9hxDrjFlv1WShOwGYjZRIsMGPPRkPrBrPk
	SAkTET41zRUnf1Htci720p8z+Z0mKqHoOQbM0zYPnQ6Gvnh2IwdnNKyv+uHEN8bnOg3I4WhX4vo
	HqEuwka2CK435KQOY7ZbbgcpmOwbK+sfpbDk6GAY5XZ+MyNQM6A25y1e/4/ulA0l/1qFv7h60Ib
	e6SH9uaEkdTFlIpuV6QeP2BQkT39jgEmKBi8tiXd7QBuV/sozsqIc
X-Received: by 2002:a05:6214:19c6:b0:722:1db2:f8df with SMTP id 6a1803df08f44-767c5436ffcmr240450386d6.67.1758017700344;
        Tue, 16 Sep 2025 03:15:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuV0hRyMwLwqzjzHvISeECe7iq+Q18PhhLX7wE1emTPMhlHDwWguYFsLl5+dlfARKvcHfdXw==
X-Received: by 2002:a05:6214:19c6:b0:722:1db2:f8df with SMTP id 6a1803df08f44-767c5436ffcmr240450106d6.67.1758017699863;
        Tue, 16 Sep 2025 03:14:59 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f1c6cabedsm34708191fa.69.2025.09.16.03.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:14:59 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:14:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yingying Tang <quic_yintang@quicinc.com>
Cc: Stephan Gerhold <stephan.gerhold@linaro.org>,
        Yijie Yang <yijie.yang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 4/4] arm64: dts: qcom: Add base HAMOA-IOT-EVK board
Message-ID: <jimz3qnjrcvemvgrqpwxq4zmywfo6psplsg4jefkvvpiwlffek@fwn3juynr4zx>
References: <20250910-hamoa_initial-v11-0-38ed7f2015f7@oss.qualcomm.com>
 <20250910-hamoa_initial-v11-4-38ed7f2015f7@oss.qualcomm.com>
 <aMPhEm8PuhEofHP7@linaro.org>
 <317ffa87-060c-4f1b-a6bf-61bb27367477@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <317ffa87-060c-4f1b-a6bf-61bb27367477@quicinc.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxOSBTYWx0ZWRfX2JDz+Fmgw4vL
 diNcr3WJhQ65CngovsnNYc/IQcNqV7T8fJWaAoIbTG4kU5EF+tyGSSOhHQO6jlJGPnrHsxeFcOx
 8bITFPH9ek+nRDKCq7rwktgpQCi6q/d+NoUjXoPYi4NuGcx8BUjyZgtx8US/w4mXyEr91IaFJ4C
 LbOdKy6KStI4Sq4+y0OQex8p/XLyjnlI+mhWS6YyPn5yMgQYZ5r4PS3sGGNgH08svr5hngYfU6O
 PimgUMWVysQBCfuTfnL2lySU0LPJPTbC/C2sAPa/eKljAupYmFQvqFbBIIcO9T8RophzqWD05l7
 ibrq4UqLodR+hLsoZrds3vEMYDKhvrEwdw3aJaeEDm13GWyOb4pU5DN7g47ZCd9yhhSq06KsDsL
 h9eawmgK
X-Authority-Analysis: v=2.4 cv=cdTSrmDM c=1 sm=1 tr=0 ts=68c938a5 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=J5uJnYprzHOJOAIlhSUA:9
 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: kd7GeOz2i6YytKV_okEUfcSCyPgnRQHQ
X-Proofpoint-GUID: kd7GeOz2i6YytKV_okEUfcSCyPgnRQHQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130019

On Tue, Sep 16, 2025 at 09:42:26AM +0800, Yingying Tang wrote:
> 
> 
> On 9/12/2025 5:00 PM, Stephan Gerhold wrote:
> > On Wed, Sep 10, 2025 at 05:02:12PM +0800, Yijie Yang wrote:
> >> The HAMOA-IOT-EVK is an evaluation platform for IoT products, composed of
> >> the Hamoa IoT SoM and a carrier board. Together, they form a complete
> >> embedded system capable of booting to UART.
> >>
> >> Make the following peripherals on the carrier board enabled:
> >> - UART
> >> - On-board regulators
> >> - USB Type-C mux
> >> - Pinctrl
> >> - Embedded USB (EUSB) repeaters
> >> - NVMe
> >> - pmic-glink
> >> - USB DisplayPorts
> >> - Bluetooth
> >> - WLAN
> >> - Audio
> >>
> >> Written in collaboration with Quill Qi (Audio) <le.qi@oss.qualcomm.com>,
> >> Jie Zhang (Graphics) <quic_jiezh@quicinc.com>, Shuai Zhang (Bluetooth)
> >> <quic_shuaz@quicinc.com>, Yingying Tang (WLAN) <quic_yintang@quicinc.com>,
> >> and Yongxing Mou (USB DisplayPorts) <quic_yongmou@quicinc.com>.
> > 
> > This looks like you should have Co-developed-by: tags together with
> > their Signed-off-by: tags.
> > 
> >>
> >> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
> >> ---
> >>  arch/arm64/boot/dts/qcom/Makefile          |    1 +
> >>  arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 1221 ++++++++++++++++++++++++++++
> >>  2 files changed, 1222 insertions(+)
> >>
> >> +
> >> +	vreg_wcn_3p3: regulator-wcn-3p3 {
> >> +		compatible = "regulator-fixed";
> >> +
> >> +		regulator-name = "VREG_WCN_3P3";
> >> +		regulator-min-microvolt = <3300000>;
> >> +		regulator-max-microvolt = <3300000>;
> >> +
> >> +		gpio = <&tlmm 214 GPIO_ACTIVE_HIGH>;
> >> +		enable-active-high;
> >> +
> >> +		pinctrl-0 = <&wcn_sw_en>;
> >> +		pinctrl-names = "default";
> >> +
> > 
> > regulator-boot-on?
> 
> It shoulde be regulator-always-on

Why it's not boot-on and always-on?

> > 
> >> +		regulator-always-on;
> >> +	};
> >> +
> 

-- 
With best wishes
Dmitry

