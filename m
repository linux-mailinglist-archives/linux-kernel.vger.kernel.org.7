Return-Path: <linux-kernel+bounces-841766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B17DBB8303
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 23:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7865188F6C8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 21:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E63264A8D;
	Fri,  3 Oct 2025 21:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BQvBvPjc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351F02472AA
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 21:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759527063; cv=none; b=uFDLeRRTbMK2F+EwbrTt2mEqqL1yXmBcdG5YdLhfAhoP7drey8Ck8coGhUjM6OPVb/fMA8O6Xje8StvI9pjzg3veRK5ntlgzb3WAoem0n1FuklaW6exlPPGktrOdQ+lvBqdhW1sDEzvxnhnNSaImy/D2+vJGkFSdiBtdPUhG9gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759527063; c=relaxed/simple;
	bh=fq/fY6JqxN6dNqCJ5P8kQFzhneXSbn5maPTRGVNN67o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2Ws7biZuxVdXE+Vy3fYHW2HdTNQCoM+1TowLyFD76xqEtN562mZwqBPDwwfIsoyL7rGNg2PJj9NjOgVcztGt7mPTg3n5TkSC+LjFMmFVJVdR3dq9LbWDMcO9JcWym1Fis+ZDhN/9wqeAexqBRgp0HqZiJ1/QNaASWvF/h93YWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BQvBvPjc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 593D0LNe017999
	for <linux-kernel@vger.kernel.org>; Fri, 3 Oct 2025 21:31:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=53GD0wKdX2v1xIpZL/WLa0QS
	fyyHKKezHxL8P/DVLl0=; b=BQvBvPjcO2pKigMd5bMO6BPzrdB4vVM4zW7/pVs4
	eEOVd45pngf6L5dByrIbvmnYYDqXDHHbob1Ea2lfz4gjF08X+bgd+xDEpc8aQxvW
	G5iKWvR8BrUOqPeEoj3hF4OT1Ep9DIhAaIcOx3lPBtwg8t0QsYm2X0yWlwgDEAel
	uHCHq8Nn5SdQupzYVcbwm8RT0JGepSPj4W0VD/Vu2jJ2C+bSpAfchbcPTiSlTTds
	GztC5pmQ1N3A7ZEHI2NjHNse4/5NiAqZ1tCH6q4FtOb0ugjplakhftzV12GjhNne
	McRK0vfLoS3l9i4yG6CPH9/IHNPL6hmv4PPWIE5+3Jc4VA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49fyrfdhb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 21:31:01 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4dd6887656cso14284921cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 14:31:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759527060; x=1760131860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53GD0wKdX2v1xIpZL/WLa0QSfyyHKKezHxL8P/DVLl0=;
        b=h4H7u051jGGFJHF7ZMvt6K5ZWVKfqmhfy65FPgdgjRDpZmOELNLR2pi6cfikmI2oMM
         ut4vRnmUshQ/K1uBmwscGrvi8Xl1ukQkY/ehckwzqndQu2d5VRK9dZf1QJ/PRuWTOzxW
         8nmn7vCvXd3h6WFLTFaMAyjvaKEiVdJ5pT8V5YiEHJlw+Q1cOUYU7C9NmD+tEGT0xwA1
         kDEtVBjeGQM4NHQ0sKcZjsJ0NvP1UvueMNW/ikw/nGaFKJ0PwEQxlmHTVhlJWxopyiz2
         DjGB3cmL1rATvgIrWQAWdVP2te0paJlRpO2J8NFm2A6NOZfedPJfoK+yU+V5UVa5/YLf
         9yPg==
X-Forwarded-Encrypted: i=1; AJvYcCUWsqSKGNmf6UbJ+dcE4CLDSGsp79fFIyKnb7NWRKeHd46pnf+mhhRkfZg7/LHN3MU5S1qH2W0uC60T6Dk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo7UV0SvMIuLRIR3LlsNo+dXFghpILFispqulAlNrOPLJuUswH
	5G+z9uKLV8vXAK4LUT2teBX46VEX6usXBweN4pUkALAcMOLturJXF4Sad35NlPun3im4UCfn+TF
	uKiadmHM41vKuiQIMAyIL0/KuNHR8VTzNXtV+SOwvHmDBO2f5u0FD4GYu6SlptwVimFw=
X-Gm-Gg: ASbGncuAbbo6cyIMY1oGNayqVYD5I1BQgMC/uK/UPLZLepvSYm0/i+hAgE2JsAM4tNT
	xD7Mmzr5tXlDVX3ZTT5JFQShurYeLnqFLDAJkUbG2fziFEUFmt982npX33TZzIz8f6Bnlv0BQ8i
	Mc92cgost6Dl3oJekeSBVUaNlXIaozoZNyIWPSTaA8BnQTRO2Nk8ZWvG7vAdK2EGxTZirOqJ/W3
	2p68weoSR47oMfqeQWBxDFOLMOEkVu7Jnzavp2Z9V2VWbQA5ftzddqkBKzczZfrUP4hEYVx4aae
	56otTlJNVHGp+qRBZTB5752yE0f8Yj6rcmPPk0QH+q1eIjd/wvw4UvaMv6CdWC4EeMvGBmp7/Pz
	45dw4CG+WBX9P0NFo3PjparsDIG584vOsJciNBr35G4qnl5hWH1NUqnSBkQ==
X-Received: by 2002:a05:622a:5c99:b0:4b7:9ce0:43c4 with SMTP id d75a77b69052e-4e576a453eemr60116061cf.5.1759527060045;
        Fri, 03 Oct 2025 14:31:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbWgg1m6ArZd6deTxtHGQP9AEmpq7RXsHx30Vj5OcL3B8xyMb602ba9wWnqn1h9OZ2s/kPsw==
X-Received: by 2002:a05:622a:5c99:b0:4b7:9ce0:43c4 with SMTP id d75a77b69052e-4e576a453eemr60115521cf.5.1759527059351;
        Fri, 03 Oct 2025 14:30:59 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0118d6e6sm2175292e87.78.2025.10.03.14.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 14:30:56 -0700 (PDT)
Date: Sat, 4 Oct 2025 00:30:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Paul Sajna <sajattack@postmarketos.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Amir Dahan <system64fumo@protonmail.com>,
        Christopher Brown <crispybrown@gmail.com>
Subject: Re: [PATCH v3 02/11] arm64: dts: qcom: sdm845-lg-common: Add uarts
 and Bluetooth
Message-ID: <qg4rlyl3gqlkih7sssixi6sfvdrkreoaz247ckmbja4zkybxt5@vkfvvhmce4kj>
References: <20250928-judyln-dts-v3-0-b14cf9e9a928@postmarketos.org>
 <20250928-judyln-dts-v3-2-b14cf9e9a928@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928-judyln-dts-v3-2-b14cf9e9a928@postmarketos.org>
X-Proofpoint-ORIG-GUID: 5iVB9E_O-jTfSOZCXAfstnE99olzuKQD
X-Proofpoint-GUID: 5iVB9E_O-jTfSOZCXAfstnE99olzuKQD
X-Authority-Analysis: v=2.4 cv=etzSD4pX c=1 sm=1 tr=0 ts=68e04095 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=Mq719mGqAAAA:8 a=Gbw9aFdXAAAA:8 a=EUspDBNiAAAA:8
 a=8yVOI8cEZPrke_ejmRoA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=gOTWM5O2Sh7P_NUuVqe5:22 a=9vIz8raoGPyDa4jBFAYH:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDE3NSBTYWx0ZWRfX2L1Y39YM6Q8s
 0csLFGy+L/apwtkRNAMbIqaF7pGN/ja0cfDMqr5fHw4vL7iB2DJNR5g/TEGtmA6KNgR/WDyx+aP
 7PvZks4TfYLc+nuyzi87q6cjoRqNDDDV0H3WhFoZOgnxJfnN/Ghzic1e9aeuxZHvGWeT0q3/0qF
 EFXfBQYz4LXAUFKkZgcr+7YUo7xpstdQNg0p3CRVNitp7BM6N2YjwcrWAGlaHqyZE5vFndjTet7
 /W5Sa+I41MsprCIFznsrMl2YgHfsIe75gRTwvlQHN4nZKXcXoQX+9Mb4x+Q7XGqB5bUNLp1PdWQ
 fXSfVcKTeZq/u0RoER1nSj3DfXGkywiOxpfcMJMsh3VzYT9866l9ObQRcenbDxT7hUl2/N4QLK2
 lV6CWpfrcy1V0FiKvnGwoWfWpTlZgg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509290175

On Sun, Sep 28, 2025 at 10:05:25PM -0700, Paul Sajna wrote:
> uart9 is debug serial on USB SBU1/2
> 
> UART RX is SBU1 and UART TX is SBU2 of the USB-C port).
> 1.8V Logic Level
> Tested using pololu usb07a https://www.pololu.com/product/2585
> and CH340 USB-UART
> 
> uart6 is bluetooth
> 
> Add bluetooth firmware path
> 
> Signed-off-by: Paul Sajna <sajattack@postmarketos.org>

If the series get resent, could you please add the boot messages from
the bluetooth (hci0)?

The patch itself:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


> ---
>  arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi | 45 ++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts  |  8 +++++
>  2 files changed, 53 insertions(+)
> 
-- 
With best wishes
Dmitry

