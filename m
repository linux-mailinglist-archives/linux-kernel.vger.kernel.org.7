Return-Path: <linux-kernel+bounces-832476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3669B9F6B1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8E3E324039
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57F320E6E1;
	Thu, 25 Sep 2025 13:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZeENdbTf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B87F211460
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805621; cv=none; b=YPOtKK1jKWJFl/PF+q9QtMQ4Km/JXGSZixbMIbyXQmwlbaalpAqv0Uc8njrxbmLz/o6XPXbpUT2udwLByY2NQhOMB91muTSno9p6xZ4ogdDWb9OYKXOxCNt1ZyFWSMFpYshYhbVXYQ8N8gDzbkEev0+3c6wLI/QETc/4NVP+/rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805621; c=relaxed/simple;
	bh=nAK6kdbUzHM4/UGUR3q8N5tZ1hG3tqOpnRJo+Jk09Mw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nHHqrFPREixdHAv12TbJzx3jMLNwJhEd52/d2eKDxajl7GIYGSzArXN9POYLQhNim8mZActL1pFDDJ474D50Q8CXXuaH0xQfVxkXKf4olyJ4Et4FsNY+kE1fvpI2C8DOQm32iZMCPNFl+HZOtLUoEejYr+G2IO9grTxuJAzVhhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZeENdbTf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9VOgD024230
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:06:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M8bm1xNryD9JwqI5a8BhCBrryB0+T9GrgctFwTKY2P8=; b=ZeENdbTf3n3sWxBD
	wKPP911mmlSehUBaiz7KQa4aIW2HQD91P/iYpS5E1QzEtgNKb+VxfGMCG0DkqpJK
	KkXXBwwxO20Rv29LpKNW7A7zMXed64xdgE+myvN85o85ry17EtSxMeZ+yGCo48TP
	rYq77292y2djTCFT2BZUZ3gyo9ugoXTXhtmkSlB/qwyoYEpIY+wCFB6GDIlteLW8
	XRPvVAwWKcNGFdgCHrkOi/ZYhqlFHWFRPog13aIMg6OmvNlTeckYlpR0Bn7q8/8N
	pz0A6AG9q+EeMAVDAcM+/TcUJct+XGeTpdhdBg2sAR4KfNLpZu5+fs6sFhkMavwM
	DYmHDg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bwp0f6fj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:06:58 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4c9764f3bc6so604341cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758805617; x=1759410417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M8bm1xNryD9JwqI5a8BhCBrryB0+T9GrgctFwTKY2P8=;
        b=PLH09FkBnZ7+QAtIgW9mYW/Xq4AlerUH5dqk5WtlOJcEdgDJpmvGInGrEyu7MIh/y6
         sATyCAWzYSeoHKfJwCaf7rEXyY0ZUh6Gr04hPDMkRsDCkLRio2JES3HJzYyr8bHVcuHF
         y27pgduAQLaReVVMYaFR3DLvC7QFLwP7xOoC5h5TlZ1w4WtTexqetHcgKtQA3CL/eH9G
         M7fCzqGmfllTUFf9YqdYQLFTJTho7sbZa5bPN6lUQR2DLBBfygOmhGXxodhOVcKYATh0
         E7d/2xOzUMiSbyafrrLM+XvgQ9vYKxyRQ2BMYUnFuLikH6BcPldPO7Xc3hi68W6DGl5O
         AkaA==
X-Forwarded-Encrypted: i=1; AJvYcCXa7vyJIP7hkSBNXXpWOaSe3BaTvxxvgFzU85ywT7eUA6nRXieg9LPTH/PXntN6CDmNBY7VziW5/a5tHN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwihdC74LiBeGmlgRl/Ud+FSYDBPfiB4KdImsjUZNECZyMZDYmK
	Dr4t26siUzITYJJBNyP4ltnssEaRCOPuaPagCwmlhDciRdN5McUJk+QFsRm56z/Jcra2dTWKMQd
	K3rNlWuQftzmKnsQdA4hDB6xyPPVN/LfkVsNeBAJU//AV1GN/Q29xfmzgBAqAUv2awHk=
X-Gm-Gg: ASbGncv05hzY4Mma4hSQnBP4WDq+/QZ/KX3CPyGxJSIFvEDPt4YS7XxpHTyVpIbU0ja
	TrGgZ3O+TntSptGd/NysJFaIZZHZI1tC8cFDnxwOvVBUgnZDUKQOgfnUtCA/2hMpn5IC+/JZp3s
	fqgTFlW1wdbD4q7WkzyzzaqixmVH3FtHHnd2/3VQRTCDQzJU3Vh9QM3xapvyIq1Vwxu5cR11ke+
	Nbbsv9Ij+LLzU0ej39BA/qWBwPSDdywO9vtMGjJKRZTt4VOsPUZxxtYoJxPOyT1OjIPZXcKyj2r
	9AteDBPnEmK1ndKSMjJDdYBNX7/svzc/sOf+kJedEAeF72RHXMlZMRwM3IDSKNJMVQN9aFNZfVs
	kH+OsmRd8U4Ig/2cTbO0Hug==
X-Received: by 2002:ac8:44c6:0:b0:4dc:24d3:c70e with SMTP id d75a77b69052e-4dc24d3ce69mr5366531cf.13.1758805616983;
        Thu, 25 Sep 2025 06:06:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwnD/+DBSz4FfSNFmFPTiH1GEY8oMCJCmsKgUxzjNXAh2WUGJd1eXwBf2amv5cSWlKmUN4vw==
X-Received: by 2002:ac8:44c6:0:b0:4dc:24d3:c70e with SMTP id d75a77b69052e-4dc24d3ce69mr5366211cf.13.1758805616340;
        Thu, 25 Sep 2025 06:06:56 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353efa4c35sm163751566b.26.2025.09.25.06.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 06:06:55 -0700 (PDT)
Message-ID: <53b1a622-3afc-4fd9-98b1-3c166f563ad0@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 15:06:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64: dts: qcom: r0q: enable max77705 PMIC
To: =?UTF-8?Q?Eric_Gon=C3=A7alves?= <ghatto404@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250920014637.38175-1-ghatto404@gmail.com>
 <20250920014637.38175-4-ghatto404@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250920014637.38175-4-ghatto404@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KNxaDEFo c=1 sm=1 tr=0 ts=68d53e72 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=VyAeMZAD-TxZKk8BDF8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: f8RoWQNjZqwBcgl4aNoMOp0JkMl2UCE7
X-Proofpoint-ORIG-GUID: f8RoWQNjZqwBcgl4aNoMOp0JkMl2UCE7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEzOCBTYWx0ZWRfXyUr5ZYVbpsK1
 O76M4pG+IuGFGdFtXrTJr5HAb7ylmUxuXz4/P/nhTGimRwk4drxkaG4Xk4NxV3mrfsTavAPXmjh
 CApqi78ZfMCKW8lk9cawxnkpS8df79izt/EsC+j+nRBHp5EKyPEeHT7XsnZU7VGsHe9KLhXIvVn
 sWJAhISZY4kB4maFj1kqIwE0iw8Br1vdLZmHN10dYxkeaEpEHHRs7N937WfruwSVDx6/rikTikq
 Lulk34ahxWKpyEZLnl9vjHEgVTRjN73VL+Fs+KasES3GTADoilWkynVJXCWC37gksiayP5JAW3D
 KsZH2mD/ayTYwtXFhVePkBaoaLzzySaALBuS9lsuN0EeUY4llaSHvdWPwvic/yMLGAsOzjQpPq1
 Wsi1bv/Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230138

On 9/20/25 3:46 AM, Eric Gonçalves wrote:
> The Samsung Galaxy S22 uses max77705 as its charger, fuelgauge and haptic
> PMIC, enable the fuelgauge and charger for now.
> 
> Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
> ---

[...]

> +&i2c5 {
> +	status = "okay";
> +
> +	max77705_charger: charger@69 {
> +	    compatible = "maxim,max77705-charger";
> +	    reg = <0x69>;

Please use tabs consistently

> +	    monitored-battery = <&battery>;
> +	    interrupt-parent = <&tlmm>;
> +	    interrupts = <5 IRQ_TYPE_LEVEL_LOW>;

interrupts-extended = <&tlmm 5 IRQ...>, here and below

> +	};
> +
> +	fuel-gauge@36 {
> +		reg = <0x36>;

sorting by unit address is welcome

> +		compatible = "maxim,max77705-battery";
> +		power-supplies = <&max77705_charger>;
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
> +	};

These nodes should be children of "maxim,max77705"
(see drivers/mfd/max77705.c)

Konrad

