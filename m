Return-Path: <linux-kernel+bounces-818596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A98B593AE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA69B323970
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCA63054E1;
	Tue, 16 Sep 2025 10:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dfyAVtDw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CCB305074
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018564; cv=none; b=L/heM5yTxT09QrbhNp8Ufb09vTlC7trNeH+6wyb4B3lq9TDCYnxM9RuLPGs6zFLmY/WvgkdhV4JhzVVx3USmEhmdwwHeCzmT7YXJdnXy0wbkgeI9R5R47s1/bHrJ/vMkFybkd44xOExBjxkXJMp02o8twBEvvsMHzmpA2VL6p2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018564; c=relaxed/simple;
	bh=W41XG+VcXt43LUvirb/AV12HcyVDg1aJXstceROvD1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4rZbBMtnCKf0EjfkKFkYYcmrd1nYA/mUanKW2k6ekTCECEdQOxRWrXZsMA4s1ji2ri7t7mV46l1TO59poChJazuYd1d7Cq7cz1i1n5o+hLj9aaVQREbFr2VSW2WfUYevgvDrBmGGzZApeQ7LGYBp74x/ole6kSIzMUNl+17RRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dfyAVtDw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G9btca001512
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fjc236GagAAuG1GjVxN5vmBCcQ2QaumH8QuL7GP8Krc=; b=dfyAVtDwQvq5KdOz
	Ggs5DIzcIKeF4anPCYkTsYZZBYu1r5pZwAGWa6fSA1DT2gO/nG3bPScSkeGpYOGR
	q9uJu1PgUpF6dbrNNMRR5NetstUdN2PGfx0Z/92LYtRoPgE2/OkNFszi79bvnJCv
	XDeNhVOsc4if2eiwOtDPzzAH4HK7fsjKdU7jwc6O8zaSZNfqf1bChsRghrd6arvJ
	resSivQKyd8m54lqdQuwyVvLAGuv8iSCdukRGHr/rHOj/vWh1yvSVSgKFLhKKd0y
	PPRV1sEADcHzrtU0mLTmXE2zbeJA7QgoazpSCZcndzVhdbyEb7A94IYIe+dH55ZO
	RhmAjw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 495eqpygkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:29:21 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7814871b57dso32189776d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758018560; x=1758623360;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fjc236GagAAuG1GjVxN5vmBCcQ2QaumH8QuL7GP8Krc=;
        b=LNAcg4ezbsP28TRmwxjUmItHXWZuZ6Iv4P1HxisAyoRTNzy5ZVop9qutDeg3jofwPE
         1HTfS7a9q+RJee4pAhOLeLOkdu7l3Hv4WpAz+I1QRh9QVjEW0LSoUdBGRQ5mEfYFh9GT
         fV2km5E3sfe1KeEqG3kW6V/IlrOlJ6ORsG0+JTI3bzXkHfj0li9caCFN3QxvavodFBZR
         qkKKzUc5Sr9MDGhBHPCfYcWYqgFHtiOEhEaIrNgB2D2XIBktRFA8aEzc7YxkfL5l2yEw
         M3qdlb2ZpXi7gjPrPq2/BZOWxqJaOQy0w+EqA+oL54B9XFdLEQ/q0lDkYLoML/2RZtu9
         RUNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVm3UPunIeCxu+Hs3LsR5ILoQ8oRPJ5rsIdsmu9E369o53FUq/K/R5YmExN10HOi/f5lXno6dN+as2KOoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz00Kqb4MwqrH7F0glOu3UL/HXfZasuydYa8EK+mLeKeU842gWD
	xZGBWXvggB6dvMv6zfCSa4ndKUOGEz6mp+UX1h7n1PHxPMzzqdGSbc97Oo2uwsr52lViWlU1LeE
	63JRkdiFTNBlyXNj27DuqdFarsrRIe5LSeH6PisqxdqwFW0gvZ4t0QWRrFnXH7Y7/EiaiRc5cK7
	o=
X-Gm-Gg: ASbGnctJuC1rCVAOUj4+WvUgaKiRNTj9M1BFFG/gzHqQbqrPdGRUWKqbDiZIu4whPjD
	ngHS57bFp+AYMRl3aYpLlkL9YraU1xQl95SCAzGZsh+U4LRBXuZsw+JaqkyhQQdHLZtRHGHF3Pi
	zu4L8Txi4zCZboDblXYjtl7mf3Yk1mpfjUw1F6wykv7tMRcadAXrtWp3hJ526oVHqeAPHOl4phv
	NkGdCrltFdFHqQrBTg8eIRCJI80NWRnN3hSFLfnpp+XpjdUmMKVP0AdKxAsVgcx9Q8p6hYgEyZy
	awK5GR7wy58dRFa5g9l8q9O0iFLDWrseUPvNAlPm/YL/NQ0Bc6X/Nbxp1v9z8MySBZvSFjcNYPi
	VVBuxwgidPHAqyXe7K6KNF8nQUh8WbmMDV+56wIDn1lPaX2dax/sH
X-Received: by 2002:a05:6214:20ac:b0:780:a69f:d7a8 with SMTP id 6a1803df08f44-78d5e5ef10dmr13227316d6.21.1758018559790;
        Tue, 16 Sep 2025 03:29:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHlOk6xxLvmgGoKl9Oz0VBGIlnFZcTk1O6pZfk8xFUIOuu/r3qlX4woNj4vW/bK9oeM9aVww==
X-Received: by 2002:a05:6214:20ac:b0:780:a69f:d7a8 with SMTP id 6a1803df08f44-78d5e5ef10dmr13226936d6.21.1758018559048;
        Tue, 16 Sep 2025 03:29:19 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e65d11f49sm4346755e87.142.2025.09.16.03.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:29:18 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:29:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Tessolve Upstream <tessolveupstream@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, konradybcio@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingweiz@qti.qualcomm.com
Subject: Re: [PATCH 2/2] arm64: dts: qcom: Add support for QCS615 talos evk
 board
Message-ID: <4e5hygjnmbnxm7gmdqce5w75nupwxo3b6ehgocmrjmfuhlomf5@6ydkk2yaxazj>
References: <20250909125255.1124824-1-tessolveupstream@gmail.com>
 <20250909125255.1124824-2-tessolveupstream@gmail.com>
 <f6kaau5sxgleuim7cgdw6hsvlwl73ye7emwjtrxwvtpl3pxsvr@frxbvtv6ixho>
 <98a92bff-db74-4b14-8a19-1171e60e87bd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98a92bff-db74-4b14-8a19-1171e60e87bd@gmail.com>
X-Proofpoint-GUID: pS97lP3TYCqH_u6E_lmMIqG0eHSM_QFl
X-Proofpoint-ORIG-GUID: pS97lP3TYCqH_u6E_lmMIqG0eHSM_QFl
X-Authority-Analysis: v=2.4 cv=XJIwSRhE c=1 sm=1 tr=0 ts=68c93c01 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=t2fj3te4-gpxl8S1CQ4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDE4NiBTYWx0ZWRfX8ie1qSvcY/0y
 eP1vpB9woFzZiccUwLXh1ICoyjS7OhyTsB6uw8J984EFy0ZhAJzOV/GrE3/0luTUSMlm2kUscUL
 /Ohyam1fQZzGZ8zeJ2qyG/yaGWASCG55bmd/G8bgmju029Fw2Ka2x8jAcqwLrKdI65mUb69Puo0
 07xpw35yGIRVUHWQTt0GtUdKWzgOsw4fAUeQq+MMVhaoHkfV2u1IsQqykNns6skiwkSZCPbnfl8
 FBRZe8Ju0EpQ2OZlQ6OOdQGQEwfhy26epcfj3F/NCaEcdnIG9SHva6MKA1yO5l9xF6obgiT0mO3
 wkeWPJuuaAQ4HHBnX/dyH0GZnXEiKR88sKJ1OaIkoYnEyzRgMiEnCb7eSBigqki7yze4yunV326
 NfCapW7P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130186

On Tue, Sep 16, 2025 at 11:17:31AM +0530, Tessolve Upstream wrote:
> 
> 
> On 09/09/25 19:56, Bjorn Andersson wrote:
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
> >>
> >> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
> >> ---
> >>
> >> This series depend on the below patch changes
> >> https://lore.kernel.org/linux-arm-msm/20250625063213.1416442-1-quic_ziyuzhan@quicinc.com/T/#t
> > 
> > This was merged August 11.
> > 
> >> https://lore.kernel.org/all/20241224-fix-board-clocks-v3-0-e9b08fbeadd3@linaro.org/
> > 
> > This was merged December 27.
> > 
> >> https://lore.kernel.org/linux-arm-msm/20250604-qcs615-sm6150-v1-0-2f01fd46c365@oss.qualcomm.com/T/#t
> > 
> > This was merged July 16.
> > 
> > You just wasted 5 minutes of my time, tracking down the status of these
> > dependencies. Don't list dependencies that are already in linux-next (or
> > actual releases), or even better, only send patches once the
> > dependencies has landed (or send them together with the dependencies).
> > 
> >> ---
> >>  arch/arm64/boot/dts/qcom/Makefile        |   1 +
> >>  arch/arm64/boot/dts/qcom/qcs615-som.dtsi | 414 +++++++++++++++++++++++
> >>  arch/arm64/boot/dts/qcom/talos-evk.dts   |  42 +++
> >>  3 files changed, 457 insertions(+)
> >>  create mode 100644 arch/arm64/boot/dts/qcom/qcs615-som.dtsi
> >>  create mode 100644 arch/arm64/boot/dts/qcom/talos-evk.dts
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> >> index 4bfa926b6a08..588dc55995c5 100644
> >> --- a/arch/arm64/boot/dts/qcom/Makefile
> >> +++ b/arch/arm64/boot/dts/qcom/Makefile
> >> @@ -117,6 +117,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcm6490-shift-otter.dtb
> >>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
> >>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
> >>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs615-ride.dtb
> >> +dtb-$(CONFIG_ARCH_QCOM)	+= talos-evk.dtb
> > 
> > If you look a little bit harder, you can see that all other entries in
> > this file is sorted alphabetically.
> 
> Yes, Will sort it in v2 patch. 
> > 
> >>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-rb3gen2.dtb
> >>  
> >>  qcs6490-rb3gen2-vision-mezzanine-dtbs := qcs6490-rb3gen2.dtb qcs6490-rb3gen2-vision-mezzanine.dtbo
> >> diff --git a/arch/arm64/boot/dts/qcom/qcs615-som.dtsi b/arch/arm64/boot/dts/qcom/qcs615-som.dtsi
> >> new file mode 100644
> >> index 000000000000..1b9b2581af42
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/qcom/qcs615-som.dtsi
> >> @@ -0,0 +1,414 @@
> >> +// SPDX-License-Identifier: BSD-3-Clause
> >> +/*
> >> + * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
> > 
> > This is not the correct copyright statement.
> 
> Thanks for the review. 
> I used above copyright since qcs615-ride.dts in the same platform tree already follows this format.
> If you’d prefer me to switch to The Linux Foundation for consistency with older DTS files, I can respin the patch accordingly.

Please check current marketing guidelines, then you won't have to ask
such a question. Also please fix your mailer to wrap your responses on a
useful boundary (usually 72-75 chars per line).


-- 
With best wishes
Dmitry

