Return-Path: <linux-kernel+bounces-735265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 675CDB08CFB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 440FEA62CB7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F19B2C324A;
	Thu, 17 Jul 2025 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aakGKykH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7F629B239
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752755614; cv=none; b=EoHhl2Mc7pC/HJee8Q2kwDjy2JwrYpoIMIn3Zl02AMShlATz9hKTA9LalK3QQ7YJkVM5yVVg/QkShNyN0zFtq1cDziyfkYakH5XVgwvxxOFl3mD+pEbnhniPwnb5EViE7MytCC22jwlCHdpVozDlHwvFcXL/YihIloA+mkFRIA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752755614; c=relaxed/simple;
	bh=Gmv7dVIb97BTPREuQrN3CXUNJACJV+uXItbUTKNKsu4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyq01Bp18wAvS7tq+3qDToYX9bAE13wHaavQ5GchqBpZxzJOgfOdzLBX3E8ITIWxkjrvyI0FyU3xG1XlO1cWM3kacxSgx3Q5QNlQjJL4q+9onjWnWMBt9Gj3RdsI4lEIR/XST7bGe1lIPjMOMb4CUHINp/uSXjstzmJSbZHmvZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aakGKykH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCWA3R022401
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:33:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vnoT4/xPZqftSBkokhP4srTZ
	A+sUjdarw39SzAh6b7s=; b=aakGKykHaHKn9V/Czx7qvSHd3+orXpNVX/fgipXe
	dQgtYAT+KUdTadL4MgG/9nsAJF70C/o+adVbLjKzDnpBLZuEaimSK1Xhkfxvm/Jc
	2Q5ZoiK4OHfjjslfrlwOVrLK+TSOBQT06sJ/PjumZKJCLIKon/dKrHUoaRl1B3hn
	gFsve7pKv8zr/Ul+L6EbAh/CdzVrxuj+1+6vSbGiPWpAYH3mA59ObVGxiRmxV3xl
	o8Df6QOIIL03ZQVBF0cpVXcDZbxUoojOppgJZVAB1FFsumNYrx2tMWNsBsLa92mn
	fGHuXqrK/E6IvjGdVV2itMH5RH6JYFmFOu5QLbfvMoC9rA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wqsy7hpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:33:31 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e350915d2aso128210785a.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 05:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752755610; x=1753360410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnoT4/xPZqftSBkokhP4srTZA+sUjdarw39SzAh6b7s=;
        b=SSrecjjOGA9MB8I+nmSR1HdKKui/MYe2O1WruVmFEvZn2Wl0NRT51KNXdykgvjvpqb
         5c6668vVK2hKetPXKhvcii/dqORCzcoyRK3SkAl4Vtxo4WkuFkpLwGUfIc5EWqpy5jYQ
         hV3Yi6S8cTpcsWCYwqYfv5OXeihZogAL07fQ3OWqTwdV78eCOhlT/3zQYWzaPP37t7Bt
         WslFiVq78NG4mpcxavuNKLMFoa2+JpLEy2TL7hqsec9oB5Lvhw9KVMADF43QuTCPHy/M
         uBkN8nB/EyOI21lnEyeuYZcs0n/VWVDmYpyiuZzLgW1ohgBEEEELiAdI/NXtGJ4AHsr+
         kqqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQnqumGLk11VHUmrxcWhZUDvji+9aJJbMLrF4jABmi50tXRGU87D8jCdBnlYT2XEGQzrGdBNS318LjOwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt+jFiQNwBwaavjR3tMFZ2dUx1JfzwUD+KUW19A0ZlC2V7V5p+
	qgKbKYonojqG+3J1vqTLjL8xw9D1znXp3Gw6F9fbtXFZ6KmCpfH5ruZDVhLj85zhjyp1Aurx87v
	Q4JJTNwdDy4G/wyAjwktyOI7QNSxissQAqA2FfKuOXx9mDx0KJokNZo5DmByFyUIh4EM=
X-Gm-Gg: ASbGnctBDQIk5xv7lt3wq9z34IOWnFR0OUrw+r4qy4n2AXKrN1OhSzgAE97HwLkPMGu
	Q5l0kcVN0vLw97BFdWgQEV9iNyR8bTPEH7ZVqJf4/yeSF2xQMdW72eGqOtq8I+cNxzR7vb27C4U
	KA1+M5duAXP9j56Ef/yhO92QOpNevaapnbT3uYokrYso4OpupIpOVjFvSwbV6MF7wBaI/CNiLex
	FhpuG6sSjr1rjpZ5/pz2JC8jctTKSvJBbsmuii8TIooDWPkkcw5TyNJ0+nFLkBuMZX2whfakldl
	B0Po+yesOLhdiqset7Ywm1rQ3/AdM98+K+25Q23ParGaJlinjAYD2moyl2mWFI7bppXRL5F1/Cw
	=
X-Received: by 2002:a05:620a:26aa:b0:7d4:57b7:bc12 with SMTP id af79cd13be357-7e342a628f3mr1054708685a.10.1752755610504;
        Thu, 17 Jul 2025 05:33:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSnIBcZM6ZddE0sOAybyV9BkM2sMD+GB/jEshb6aB2JUCIRPwvnx1f3dg+qsl9snP6iSbjmw==
X-Received: by 2002:a05:620a:26aa:b0:7d4:57b7:bc12 with SMTP id af79cd13be357-7e342a628f3mr1054702985a.10.1752755610041;
        Thu, 17 Jul 2025 05:33:30 -0700 (PDT)
Received: from trex (153.red-79-144-197.dynamicip.rima-tde.net. [79.144.197.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45634fab0f3sm21467895e9.35.2025.07.17.05.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 05:33:29 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Thu, 17 Jul 2025 14:33:28 +0200
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        quic_vgarodia@quicinc.com, quic_dikshita@quicinc.com,
        krzk+dt@kernel.org, konradybcio@kernel.org, mchehab@kernel.org,
        andersson@kernel.org, conor+dt@kernel.org,
        amit.kucheria@oss.qualcomm.com, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 7/7] arm64: dts: qcom: qrb2210-rb1: Enable Venus
Message-ID: <aHjtmOlL8bp6lRze@trex>
References: <20250715204749.2189875-1-jorge.ramirez@oss.qualcomm.com>
 <20250715204749.2189875-8-jorge.ramirez@oss.qualcomm.com>
 <00be65fd-2a25-4b6d-8fb8-7a40f8ca846c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00be65fd-2a25-4b6d-8fb8-7a40f8ca846c@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEwOSBTYWx0ZWRfXzn1I6g13gltP
 a5qF69wPRwEcMsLYG1QgMvt/BcH1RHDjeyfnPN6B+gHxYMZm8bid9ZWAzFtGT0x1/ozDJPKfKmb
 0apI0z50NnJx17VjWr6p4zUZ4Lm71Ri7U20POGBlZwvPZX6kmK6MhwN9cypScxk3d8YEHm9KrQg
 ZdLIXhQLJulkQxFtsOZbUY5MOuxUCMAXmgDnkBkgCq57fle+kJvSiA3OhY1hNrJTdnPBpN+sq94
 H2T9kS0qEF5/JIdTOX/RR1Z9J/VTCUgKLJZC0drjRKRuAIQFY4RYlPKaRMU9iQ9Rs8jMUcShXp9
 68phMzB1iBjCyYt4F6hWSv4ANXRClJePorAr1MoyVOzPv859adBJW8YAdZ/qM67lYYeSAo9IBWK
 lU3nqBBpATUg0L9xov4i3RDyoYlSsjKXbfGGONo+T06Y1F7i+BEnFAdziu8olECxDwvBUn6/
X-Proofpoint-GUID: rSptdM0NP-SlTpF2azZvaRa0bJ1OFIUe
X-Proofpoint-ORIG-GUID: rSptdM0NP-SlTpF2azZvaRa0bJ1OFIUe
X-Authority-Analysis: v=2.4 cv=McZsu4/f c=1 sm=1 tr=0 ts=6878ed9b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=Ki5fnJvzvo7yLsyA0quaxQ==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=pzCxKkVfxTIgAx5FXkwA:9
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=918 impostorscore=0 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170109

On 17/07/25 10:45:52, Bryan O'Donoghue wrote:
> On 15/07/2025 21:47, Jorge Ramirez-Ortiz wrote:
> > Enable Venus on the QRB2210 RB1 development board.
> > 
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> > ---
> >   arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
> > index b2e0fc5501c1..8ccc217d2a80 100644
> > --- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
> > +++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
> > @@ -711,3 +711,7 @@ &wifi {
> >   &xo_board {
> >   	clock-frequency = <38400000>;
> >   };
> > +
> > +&venus {
> > +	status = "okay";
> > +};
> 
> 
> goes here

sorry, didnt know

> 
> &venus {
> 	status = "okay";
> };
> 
> &wifi {
>         vdd-0.8-cx-mx-supply = <&pm4125_l7>;
>         vdd-1.8-xo-supply = <&pm4125_l13>;
>         vdd-1.3-rfa-supply = <&pm4125_l10>;
>         vdd-3.3-ch0-supply = <&pm4125_l22>;
>         qcom,calibration-variant = "Thundercomm_RB1";
>         firmware-name = "qcm2290";
>         status = "okay";
> };
> 
> &xo_board {
>         clock-frequency = <38400000>;
> };
> 
> ---
> bod

