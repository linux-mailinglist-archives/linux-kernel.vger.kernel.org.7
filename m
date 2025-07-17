Return-Path: <linux-kernel+bounces-735853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B917CB09475
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA2291668D7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189DD2D3206;
	Thu, 17 Jul 2025 18:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NRZyiPw9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6A01EE7D5
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 18:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752778349; cv=none; b=LG2VbPCkebMjRbN7r5kN1Qq0riify9TnW8+jBqpJkCt9gid2A61BLmBsE/4rdlvr98R02VFNe+eLf3diDA8d6xy+SezuY3800XIZ118mUjQD/bITEj+8fYxYb56E84B+b3Qe+70cHZTltUhfd8q9imf0bTQP8Sicbxdxn2t0IL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752778349; c=relaxed/simple;
	bh=78JI1/FfqMPzK+79CvGubp0kjxFRxs/Jcwii3KSkawo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsyI9QUW142yjZNu/WCES1e+klzHXDU7JTv6Rjv/PfAU06eL0CJw34A4DgC7oVhhYOAhTktQBA+EjNc6JUF9Ma659zyuoWs1Grco/kBkNqVXOA6PPQ883aE6VL0UUIqZ+geG51BnDMnxthMlKP1aYjjKmcfWLaxt2J1IxEzBNCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NRZyiPw9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCRO60008515
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 18:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HrkyQj2h8WWy7OgZiBBtyyS646DmSEdm9ifAy5URrnc=; b=NRZyiPw9j6nbhnIV
	SGq0f9E5rQCn7mRL85uf4NL5R018NEqH56s1aab9YRGU6Gh+YcNmybSyrm5rRARg
	MTzqmeXCc6EOpjU6SOI8RI8J+4OQakatNqyzpGFuvUFGS03Iv0Y0OHq2UsvcMM5l
	Tk4HSx48S/7qj6AobnHBY6hVIVpUmLNZm0l1dzPrtVbg987Q0N3Ivg4OTRvLoDNl
	tOgGybheYZ/Hz98lCzQCmbwKukjTpBLgXRM14HKQ+YljfyfeTDeRiEEtjc5wVSjx
	vapa0iPU4huB7sgRbfpRKlr2KtwCtYn/P2EZh8nglCAM9/M8U+tFSnq3iaiwUqEh
	G7sumA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxb8vqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 18:52:26 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e207330a45so203755285a.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 11:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752778346; x=1753383146;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HrkyQj2h8WWy7OgZiBBtyyS646DmSEdm9ifAy5URrnc=;
        b=ZJx5e0r6gthzPZaDVSrJleFoCFTsxDMxeMCy5e63gZzQPzJcjpun2S/kQ5wFZ5w5Lt
         0RwWCr2tcC29FGpF5chSB2LLhTdsXqJcN0QabBqW/fufrhLSyP2vT8XsJeyM4lEXPCAc
         mM+//2Vtz3zovI86qegoaL6B8p6fKFUieGUJuOOcLdm9AY13kBUDpepW6YDRvaFyzHgo
         0orr8R8XNP8FP0QADyuc+ime5XY1rGtzFEehut+ezRyAb9r8h8T0CzKE3SJ5xq457OTz
         y946gqt3yANuv2rojuzm1fNRCigipcTgRqAQ/dmfCBymlu6wKqG0kNOeMpS1TEtjwHsO
         9h8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWzL+B7wrOepE/paWXPdBcXYKkdKoB1/6an5B5guaPkeikfVfMtNwdpBTGcpQNjluOq0a86+MDeNx71QAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzpCNe6n6l6z02mazbtnjTC6tVP+JutSt/pWylxtmta8/9b7mF
	1NtE2CEnH1g7a+aV1HJ+7IldL/N6sHFLJHLNPTjTwf1cbDDqul8wM2QM93UdcZ0cOVgqs0/l7yf
	HC9tdYd1yASKBLTyLpVJrm27/x7thpZwleclWALjLFBIyQSMxO7ik8ps9vlEOXZhIKRs=
X-Gm-Gg: ASbGncs3U4OZrjbk67iZveGkPMPvfFHBjyv6YcRk0aNoxGykKoRgN0Pi1VbYNynjs0A
	pFreGTrRnbq6fuzcE15ZBIkehlbchU4q29q38xdsmbz+hbjFmREBIRbU+ji/QJRHf250WOEF1xW
	B4QU5lJe0gjYDkBPnBKR/ripRSOvTFn/D4/Rm96HxT6l8Bymn7NLbxz5IcZQQP35TQxl2kJCEcx
	Cf4VBK+4VXJwd1CjM1z2AGEOhymI9OT17W4r104PFn5T+Drp7i35wXzHe9G7hB0e/rRR9WrmX0c
	RlEyw/hl/A/U0KCEoGCtIxylUwi+16hKPdrjbx/O/9YlAC1QT9Jzh5Do2tUWmW5Cz5sXcbN3S9L
	u7oyT6vzBq5zqpORcPBTx3S/ykB8yS7kS352gnsYyRHNthEs9FoxR
X-Received: by 2002:a05:620a:454d:b0:7e3:3fac:b679 with SMTP id af79cd13be357-7e3436353f4mr1044841585a.52.1752778345585;
        Thu, 17 Jul 2025 11:52:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdNjK2UCt2oKspwymCVWfIJVTAsgjsbMOTdUvDq28EVYpDczXqAuW7gocVbG8NYtCqLKGREA==
X-Received: by 2002:a05:620a:454d:b0:7e3:3fac:b679 with SMTP id af79cd13be357-7e3436353f4mr1044837985a.52.1752778345128;
        Thu, 17 Jul 2025 11:52:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b6be39sm3137456e87.181.2025.07.17.11.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 11:52:24 -0700 (PDT)
Date: Thu, 17 Jul 2025 21:52:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yijie Yang <yijie.yang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: qcom: Add HAMOA-IOT-SOM platform
Message-ID: <b4nxjsx4fu4xmookpxukumw36wlcpzelh6axjucqe4lyswptm4@kczsldalq53n>
References: <20250716-hamoa_initial-v1-0-f6f5d0f9a163@oss.qualcomm.com>
 <20250716-hamoa_initial-v1-3-f6f5d0f9a163@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250716-hamoa_initial-v1-3-f6f5d0f9a163@oss.qualcomm.com>
X-Proofpoint-GUID: A1n0Ch1U7gpCh_AhE56Iq4eQWRuPIsRq
X-Proofpoint-ORIG-GUID: A1n0Ch1U7gpCh_AhE56Iq4eQWRuPIsRq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE2NyBTYWx0ZWRfX4NbeasWa2GRl
 HFp4lp0RUP2WJDRkF3GSt8mCLKI/Cy6EP9D5gVKwQPX1hTk4QVYJ4aYj0oXq6W+vBoWCkoxdoa0
 GNSOb8iIm/hsW+s9nDd6yEy6s9Fp/gp0Rp0SBxu0IOEKGCzmihco1D8LeuhzUMxnfUNarfRb6l4
 DQ5vsShMLnGez2gyEJgLLH/fSFm0Gorw8yh80sX0y/o6nWIY38I5RRColq+PFsLFGNruz2QXdrn
 Ugjyxcz8s7jWUcouA/1ukGGLGR2qw5LBo1iS0UfXjKCpRC+GFsjR8rijlqFRNT/qdv5J+hM7Oj0
 rbStx8zsBlAaFEqV4nP/GqtgFApSbqlcUnQua5PGgcbnILmX839ZENyqVDk298lwzAync4LASIh
 6zHE4mVNYLA1WFHs3TLreI+7+nKV5ufAJnCJEJtYKZEmGdShe0GSo8Ngbj1prcX+uoerE+AE
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=6879466a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=PhgHo22kut4TJJxNvVMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170167

On Wed, Jul 16, 2025 at 05:08:41PM +0800, Yijie Yang wrote:
> The HAMOA-IOT-SOM is a compact computing module that integrates a System
> on Chip (SoC) — specifically the x1e80100 — along with essential
> components optimized for IoT applications. It is designed to be mounted on
> carrier boards, enabling the development of complete embedded systems.
> 
> This change enables and overlays the following components:
> - Regulators on the SOM
> - Reserved memory regions
> - PCIe6a and its PHY
> - PCIe4 and its PHY
> - USB0 through USB6 and their PHYs
> - ADSP, CDSP
> - WLAN, Bluetooth (M.2 interface)
> 
> Written with contributions from Yingying Tang (added PCIe4 and its PHY to
> enable WLAN).
> 
> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi | 607 ++++++++++++++++++++++++++++
>  1 file changed, 607 insertions(+)
> 

> +&remoteproc_adsp {
> +	firmware-name = "qcom/hamoa-iot/adsp.mbn",
> +			"qcom/hamoa-iot/adsp_dtb.mbn";

Is there a significant difference qcom/x1e80100/adsp.mbn ? If not, can
we use that firmware?

> +
> +	status = "okay";
> +};
> +
> +&remoteproc_cdsp {
> +	firmware-name = "qcom/hamoa-iot/cdsp.mbn",
> +			"qcom/hamoa-iot/cdsp_dtb.mbn";
> +
> +	status = "okay";
> +};
> +

-- 
With best wishes
Dmitry

