Return-Path: <linux-kernel+bounces-818593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7A7B593BE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33DA73AA5A8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A933054EA;
	Tue, 16 Sep 2025 10:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qu+7r6xn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967B62C11EC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018355; cv=none; b=ttrae52C8MFqEcgSBrX/Z1DNlKHDpG3NfVfZpi+ILDRF++E10Gog2ZVYoz/dzMUElqc8gG46X9k36vmEqrxFrZVVC59LnfOE32NL7Qw9pDDphctYpXvyiq610LUZq0TTt2UtIY6q4XpKpM6lx1Bv+MtfASwMsxKTIDxflVNDIz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018355; c=relaxed/simple;
	bh=78cQhNh/OCzvZADHozB+sfqwV5S9C9YmKnjhwd1DjHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFXSxi5CO7b6TtOfeeMOlZ+XCw3DhzQ9HA9EnwRLeVQKTXB53ETe8NDY7qQ6yaTi2G3EoOAlvprBfkIW+IkwvatUlrGcWUeNHBYeyp56hNpqs5NclI72HFm+OfAbFPUNkOJyxIzI4noLNGafqj//mF9XcowQrCs80REtWx44Sa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qu+7r6xn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GA0shZ020559
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:25:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fdYk7NreptJTGbbMJJFNX85/
	T6Ks8jqLfPxEeHI0SVQ=; b=Qu+7r6xnxXzFnrx2uN+ktyEmh9oLTi+K9KxOy2/n
	F7WN8dss3UmfDGd2rzDfQ2S2XcZudR0o0nb/QtfkhfTPcSfw5KG/5YPk1nUXEvVQ
	KN4DAEVZmiw+MDTPZ3KdwH9sxFqLSNFLK+/CfDKx953BBBC0pnBOGCbFVycsC148
	X6POQ7HEVp+Xaa0l2UELfydJa9pVkzdE/GJCHs2wWT+9tuAHYG8IsuRBgE+J6AYg
	fujvXNl56347D5LUPtsAfA+LXMDpdjt0vwu6nfyu2omIZZdg4twjFLs2jz7E6xAA
	hrRCnZjzEPPvb4dIL+q4rmbBKJudJ/StKT3Bc43WCG43BA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496h1sm125-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:25:52 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b5fb1f057fso76144921cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758018352; x=1758623152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdYk7NreptJTGbbMJJFNX85/T6Ks8jqLfPxEeHI0SVQ=;
        b=eAv+v/2XPzMjWX/Mh9dbWUuZ2lzmLEwFQpa6sgvnQxmmr6aaZbezbYzi3cPTvmpqJU
         A4Uj6SxsQVdV1u5epOvx59NCJINSVYpZO0dXxgfkQZgikmS0KWl8vQ3/rYZf7wzxmhux
         bHPw2y3lX9OyaDYH2kjAGKvnGj0+4GcP98Zs/zx0ztptOEL8mXpjvVMpZI/3g9APycTg
         rHQZNhBsznhMZU5wDrjmfjqh4uMblJxDUq3Uif6lI1aKRVic8bX6k2wtKLHQwowzH9+x
         QKLMNgr3a4kOHPQP7q1tJZdClKmfLe1CaDpphFvs6+O0bMX1aPa/rjNcijULmNICRYXf
         V8fw==
X-Forwarded-Encrypted: i=1; AJvYcCXZW7s83AIM5KYVv+u8DtKkAOQA86y//KbQ1V2I3Qtao97ekZz40/m9d2aMDk5mN663xgsn59f8zz8Yiac=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA4RAkE58E0mmrEy+mG/xXOU839CqJE+DwoPdFa2o9o+P/GYwO
	2bahQTjbDZlvNAIAO1aQVZKojpJflSXr7/JsIe5V00zADaNO1rLZ/XDosrcyVPKkffeqJlI4iDK
	7LgJ7m9f8qbhT/NE8VJQyE998nJldLhZn3hPGbbH2x0qG/O5vxUCfLZlMe+qeyKM+qv4=
X-Gm-Gg: ASbGncstLmQM2twEMvnKCnJQNqTwq2kBCiDYAGbXpt3Gm6oFOqciaOiuiDiUpDjo2oy
	txxOCBD0TMNdetgjw0g50uqcoAsw0bPnJ+P/GhMFZu8cMFFif2QbJqQ9xY86cQq9zwGb+DUkJpf
	HIgtYBYQwSoeXktaf7k/FPtz7HJ9Nd5JCxM2QqccwCh0smzWlqvlxbeN/rD3Ma+uOWFTWhQGRxd
	V4VXXh1d9rfzDWIrOptZEjS/hcS7v9vnf/zP9ltOwNxCz6fZFrNrCvx04p2vFIOtReXEBx7q1eP
	HT97BnPd3lfam0UW5OK+lXucQTYvlNXqGev+OU0vNJSfMvuBQ6IXwYEVIlbuKVBlNYOSCTWDgez
	2S3u0ICjNpWcYrkOblc8e9ibAyJGyabND/pjMtaoV++nZ/316ix60
X-Received: by 2002:a05:622a:1355:b0:4b5:edd3:ddde with SMTP id d75a77b69052e-4b77d10a730mr186827601cf.81.1758018351622;
        Tue, 16 Sep 2025 03:25:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQP5YPYxOpUVQXHgMsfOO7ilhKtcaPm2siTqf/LOWCcEXazsjWC7pBKu1oB86ZeRmDb/l7qw==
X-Received: by 2002:a05:622a:1355:b0:4b5:edd3:ddde with SMTP id d75a77b69052e-4b77d10a730mr186827401cf.81.1758018351191;
        Tue, 16 Sep 2025 03:25:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f1a82065asm31946791fa.34.2025.09.16.03.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:25:50 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:25:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Tessolve Upstream <tessolveupstream@gmail.com>
Cc: konradybcio@kernel.org, andersson@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tingweiz@qti.qualcomm.com
Subject: Re: [PATCH 2/2] arm64: dts: qcom: Add support for QCS615 talos evk
 board
Message-ID: <axtz5euoa5lyg5clwj44jhdn5gvfubic6un3ilndzzoy22rici@rqqk4eyw7yas>
References: <20250909125255.1124824-1-tessolveupstream@gmail.com>
 <20250909125255.1124824-2-tessolveupstream@gmail.com>
 <v2d4e6py34xb2hjrfnmlrmd7xme45equ76zb2c5cmftgylk7w6@5lmexwfupj4e>
 <70c2f78b-c3ce-4b7b-a961-9f3957ce40f8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70c2f78b-c3ce-4b7b-a961-9f3957ce40f8@gmail.com>
X-Proofpoint-ORIG-GUID: 7rfr9uAyn84_PF5npDKVLdAe01cvp9yZ
X-Authority-Analysis: v=2.4 cv=A/1sP7WG c=1 sm=1 tr=0 ts=68c93b30 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=M5iAUQSpgaS7r5DjpD8A:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 7rfr9uAyn84_PF5npDKVLdAe01cvp9yZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA5OCBTYWx0ZWRfX3e3KdE8aHrz/
 TnR5QDOMoTzlpVirYjvY7b/s7A2Fstxf0PfEOglp9Z4gfSXlrF5X8/SRW8DlU8nfxxlep2HNJ/S
 zIvCqBlKB9f3y5aYDCJQ8G2iyNw+b2i4egIqfJoCHrs+/4/kTQrfTIWQaJ2C0AJqa2j0c+q+XM4
 u1Iqo75UpfYp7tW1XAM7sFDPNrdsFrs5V919aaH7W76AcqWKEfmcLAqvSsp5b+OfHC/+WH3aCVJ
 EdpgoK6dn0quSHlCcMPb4IEpK7J9jWAGoB9ulbp3dKdoUB7M7PTqolId201Tn7WFvjPUQwC1IJr
 YT9GepCD3CxdrQQ3BqDY+IBUMOpw5vMw+ip9lXA7SeYK95iejDNZ2E/rIjmGvUqNn3NA02l9AR+
 IpPx0w5i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150098

On Tue, Sep 16, 2025 at 11:22:02AM +0530, Tessolve Upstream wrote:
> 
> 
> On 09/09/25 19:28, Dmitry Baryshkov wrote:
> > On Tue, Sep 09, 2025 at 06:22:55PM +0530, Sudarshan Shetty wrote:
> >> Introduce the device tree support for the QCS615-based talos-evk
> >> platform, which follows the SMARC (Smart Mobility ARChitecture)
> >> standard. The platform is composed of two main hardware
> >> components: the IQ-QCS615-SOM and the talos-evk carrier board.
> >>
> >> The IQ-QCS615-SOM is a compact System on Module that integrates the
> >> QCS615 SoC, PMIC, and essential GPIO connectivity. It follows the
> >> SMARC standard, which defines a modular form factor allowing the SoM
> >> to be paired with different carrier boards for varied applications.
> >>
> >> The talos-evk is one such carrier board, designed for evaluation
> >> and development purposes. It provides additional peripherals
> >> such as UART, USB, and other interfaces to enable rapid
> >> prototyping and hardware bring-up.
> >>
> >> This initial device tree provides the basic configuration needed
> >> to boot the platform to a UART shell. Further patches will extend
> >> support for additional peripherals and subsystems.
> >>
> >> The initial device tree includes basic support for:
> >>
> >> - CPU and memory
> >>
> >> - UART
> >>
> >> - GPIOs
> >>
> >> - Regulators
> >>
> >> - PMIC
> >>
> >> - Early console
> >>
> >> - AT24MAC602 EEPROM
> >>
> >> - MCP2515 SPI to CAN
> > 
> > No WiFi/BT/ethernet?
> 
> Networking peripherals such as WiFi/BT and Ethernet will be enabled in follow-up patches.

Why? WiFi/BT are supported for the RIDE platform. Is EVK using something
different?

-- 
With best wishes
Dmitry

