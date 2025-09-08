Return-Path: <linux-kernel+bounces-806260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC488B4944D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E838D440183
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8D71FF603;
	Mon,  8 Sep 2025 15:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QSA8mY1/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14C218872A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346751; cv=none; b=F4nBKxSYhJQpNViTpiFJ82UdB8pJBBspFj5qpv210qZNlJVqB12Cc7BL7bHKCW0v+eEeS2cmpRyAkvM9J94dFXIFjDfUx43v68zx5wuHjer6Sti/Jrl3eF3rsLilAYeySMYANnI03sPxxN4Krlq6haErOpF522XZzn8zhLX7nBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346751; c=relaxed/simple;
	bh=crak8uVuJijqzBSbLNMkfylAoCRgXBqUf7/pqgvGjC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OusdylCvctDvDWe5+7wkWLhNk74g3mhIKGViZzHvHXcsyzZ8yuSKT3y5NH9Me9QafUhPLT8d6ydKUa7lVzJI6f088ZZoP9SlQsNQOid75sTtesqnJU0J+zANI4jERYYa7K2g+bJyF2ySuZRLjeuYaSJVloc8/PjaUTVNe0ZTKg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QSA8mY1/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5888xldE017314
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 15:52:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KvaveUZbWaKcPRnxcGEAhJIh2ZBs/hd5bj37QGB+6Sw=; b=QSA8mY1/fZDwh5os
	D4nFX3Tfy1FUurMgL1xsobRGqE6524+y2KwumrwfDgBRQiwDTHpKlKJAtcQ4LD2c
	rbu0k7n7XdV5lBBKmGYNAcdWYdOaOTfTALLXzO9Kz7kTn3b9LMUql+6WRiPqvTLI
	pthLIi3qo1YJpn8+lzmta/HubOdprMBqDOizVP2jhBEu34Kn8UuF3Z+EU5snSW3t
	o5vHEPGSHY2A5N3DJ8c72Rbu8ehOH7sI5n3gViAMsOOkhm7YkgE7xLvLbaLpUY65
	QupRCWN66bXpHxSwnYHpiDzILLtn+PE4DPykUhZvoP67bv/GukosgpH73s2m5AYd
	+nmRQg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8d3ww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 15:52:28 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5f15a5f3dso6707751cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757346748; x=1757951548;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KvaveUZbWaKcPRnxcGEAhJIh2ZBs/hd5bj37QGB+6Sw=;
        b=g2aRmbSQHrfnDolfex52dKVJqPgKSpSiy1l5lINKIjBVCAsewF+PLlmBwkwJqz1/ti
         uqQOGWpGe1ybvgDyQARW1FyTlwLwghNqBneoAqsNnzExumfot1clFY/wmmufEXNCmmj1
         o6aMZx08xJ5gSr/xhVre3BEfnobdweUS3QdgyJczPugBmcsG/ET9qW4PL2n+EWm0kiMP
         tUh1apmSHIuXtvUHggIxklBVLHRkuFsqiX7UOPNDX13oXFnVtFxCLwjbv6Ojk0Vz3sLx
         bOHiI8IGyy/qIcjpPVtk7wWVpw+0XvKFxxs1Mwsa6S53c+RzTm+Pn5vKCuh5McwzV7Z6
         uodg==
X-Forwarded-Encrypted: i=1; AJvYcCV79lRRfK/13D6urjiKOD806D1kj3GoznUEdJM0uxM9qgRJwSugrNXbb7N3EZFS6gewcP7EQ3Q61ophJgY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw+h6y0W33RN3CVyb9+LIh0Lx1ZbsjAuf8cMOuRnIlbgNXZG0/
	FLz8K4LOU6Io4hVZD9NKh0qyPwp3dgnkWwbQgmJA0gaXRcSyCD71MDlqZjWol8QOqYB/Uy02pKQ
	TVg5Ea0W4hOtdb7nJDjGNfUfLs1mPzWVIGHWkOLzLMRV9gYGHQr8iiQQmytGxO6OadkQ=
X-Gm-Gg: ASbGnctE303Su8AYnwzQR4eYLU2K6nadrKQXPPDoopTexhetadUeYznt9d3R/bKPkbQ
	WmYeWV5dzI9oHxpkMSYsuexIjJeC0hLYmvBNckw+MPOCcAcAeN7y3/LzFstNgCK+hcVGK8RVXY6
	3MSrgERHsht+wKe92UCU5sdRGTXPaf/ixCopdQReIQ4hJJsiJyv9zyJqKGRV03doRGhHsON9B+F
	gI7irqh1lSL2C9S9W33w48AdoD3Xsgvju13M+VyWpvdu3dW6Kz08D++A33LsvgpDWPpSqo+Idgn
	NzFvpicvtYhVNCPYeClEMoiT/2P5Hrnxzehr45E8rFsGYbl1PERfnyV/PprdXWaPcYDtNf6V/07
	ij1CdM3ZXkx/1U+j2+FsDhw==
X-Received: by 2002:ac8:5f14:0:b0:4b4:9175:fd48 with SMTP id d75a77b69052e-4b5f830417amr59537121cf.0.1757346747655;
        Mon, 08 Sep 2025 08:52:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEK3tOhFb+I2RxDjGGDb5CGgqX9S5kfnJ1nlfonzI8GnlObtYu5ssVSg4l6gyQ2GQhEeZUzCA==
X-Received: by 2002:ac8:5f14:0:b0:4b4:9175:fd48 with SMTP id d75a77b69052e-4b5f830417amr59536681cf.0.1757346746893;
        Mon, 08 Sep 2025 08:52:26 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0416842ffasm2093150366b.38.2025.09.08.08.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 08:52:26 -0700 (PDT)
Message-ID: <e0924039-285e-49c6-8929-0e62b3513147@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 17:52:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] arm64: dts: qcom: qcs8300: Add Monaco EVK board
To: Umang Chheda <umang.chheda@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250905192350.1223812-1-umang.chheda@oss.qualcomm.com>
 <20250905192350.1223812-3-umang.chheda@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250905192350.1223812-3-umang.chheda@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX8robDcrZZogw
 uAg4rFrTFCm9rKPJqrxTu6B6r/zoAoN75WMfe3QTLe0/UQAtd2Hvy7OCXfWARaJTr2f3ODCOgq4
 yUVTIP2b7KtRI2RVCdZ/H96r4dfs4idJP9Jx878pUjpJZLE/Q2quHmpB54rDfnJKdMBECDp5DpM
 btwhYDMRFm0UUuyYL+PjcSmlMgSmlvAEl1g4D0N1TXUgGHPm0h6h8/i8MdXd0dtdSQyUq0t2nEb
 CGS0Rl0MCt4BB64MdcLJCOkPbZXCUxAPnO7+yNi9nWtEiptiOTn0zhzO+EGNVqAfouU7hZpGPu9
 wJVEih5eG6xsHRdczsHU+5biMhAJPnCp4Q1jsnFJeX1ve/pAmVzAJsteQt7y2yEWWTSHYhCUesX
 yT5IbCcr
X-Proofpoint-ORIG-GUID: RL6ftYh89GgUn6M4drrPKTR6CsY0OJS3
X-Proofpoint-GUID: RL6ftYh89GgUn6M4drrPKTR6CsY0OJS3
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68befbbc cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=IVo3xAofRzk1BSpusREA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_05,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

On 9/5/25 9:23 PM, Umang Chheda wrote:
> Monaco EVK is a single board computer, based on the Qualcomm
> QCS8300 SoC, with the following features :
>   - Storage: 1 × 128 GB UFS, micro-SD card, EEPROMs for MACs,
>     and eMMC.
>   - Audio/Video, Camera & Display ports.
>   - Connectivity: RJ45 2.5GbE, WLAN/Bluetooth, CAN/CAN-FD.
>   - PCIe ports.
>   - USB & UART ports.
> 
> On top of Monaco EVK board additional mezzanine boards can be
> stacked in future.
> 
> Add support for the following components :
>   - GPI (Generic Peripheral Interface) and QUPv3-0/1
>     controllers to facilitate DMA and peripheral communication.
>   - TCA9534 I/O expander via I2C to provide 8 additional GPIO
>     lines for extended I/O functionality.
>   - USB1 controller in device mode to support USB peripheral
>     operations. USB OTG mode will be enabled for USB1 controller
>     once the VBUS control based on ID pin is implemented in
>     hd3ss3220.c.
>   - Remoteproc subsystems for supported DSPs such as Audio DSP,
>     Compute DSP and Generic DSP, along with their corresponding
>     firmware.
>   - Configure nvmem-layout on the I2C EEPROM to store data for Ethernet
>     and other consumers.
>   - QCA8081 2.5G Ethernet PHY on port-0 and expose the
>     Ethernet MAC address via nvmem for network configuration.
>     It depends on CONFIG_QCA808X_PHY to use QCA8081 PHY.
>   - Support for the Iris video codec.
> 
> Written with inputs from :
> Rakesh Kota <rakesh.kota@oss.qualcomm.com> - Regulators.
> Nirmesh Kumar Singh <nirmesh.Singh@oss.qualcomm.com> - GPIO expander.
> Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com> - GPI/QUP.
> Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com> - Ethernet.
> Monish Chunara <quic_mchunara@quicinc.com> - EEPROM.
> Vikash Garodia <quic_vgarodia@quicinc.com> - Iris Video codec.
> Swati Agarwal <swati.agarwal@oss.qualcomm.com> - USB.
> 
> Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

