Return-Path: <linux-kernel+bounces-798398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA55EB41D4C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BA7B7AAED0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239D72D3EE5;
	Wed,  3 Sep 2025 11:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eBGY3tdN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45B21DE2B4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 11:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900038; cv=none; b=ZpcZOUANLGsMiWdbDSQOLdR8p/SK+SAKuFvO8CEVa2UF8FXj/5SbteXZG94z1ffyi4C1F5/OVDemKCvXo3CR8g2eA9KhMTdNGOOnGYwyD5fpJNbSeLfaxAd1UcfmT0J0uhjV4LsNNQ7xdklNGv+5JGAhGcy7CoCoYEHknD/zfsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900038; c=relaxed/simple;
	bh=uBEKmasQbJZ3NLivNIZ2IsVU3WTj/03kcQK9nnE501A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FIL2w1Fgcn/+MCmJ82yKEnRgMtVBz9tbFoktIIA23oFDdLdvlzWCCS/QV6bClEqHAYPspBIoHCMXu1QTjAnQd5qj2+vJZnl7EvgLV5vdkFmBNwzZDSE8ggrtcNU1AB5ZEaf0PTct+GUR9CGXt6dnJA9dJ/bwV5un2zW+M5F5kRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eBGY3tdN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BF3M4004538
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 11:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rKQmja0lZJuG+RDQBwsicXmdO8xywN487t/vp/Mywsg=; b=eBGY3tdNpCWDmj65
	NBxU3XuzWfafrWAi5APAiVE3DO3P4+PhIkbVik8mZzZlzepNBnogw2tP6cmFJHoq
	Smcgdzk0lsCyaNWifYa4rhYjKYdgfJBiGbZe8BZZn/qf4fGCG9NrYEvkdvatpr5g
	R09Qo+lB9xZswz7GcGgW2mA9KsPnMtvi2D8GHE6aW+EiU07WaLew+dZVQPhTz2As
	IpSjewc77aeqHSGUq3ytWOj4f1KtseR6eGx8+ifBcnQ89DyEuXQgrWU/DPUynnYf
	Gukc329idvrhPzqcA7P+/xX8hhvvy9blj+7saeHHifgE7CK8zzgQiekS8/7iyE4t
	VFEaUg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnpbnr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 11:47:14 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b4bcb1e32dso482151cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 04:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756900034; x=1757504834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rKQmja0lZJuG+RDQBwsicXmdO8xywN487t/vp/Mywsg=;
        b=VMtGVs2CjW0RZIOwrmTVzZdpW0V1jSXQCwZQRvpBVJJFCvAG2j9qygBCvk9lRnqP4p
         Im0tLe5/8P8fAdJkcXGGcJ7NbSNTBVJIrfXMpHnMxQCGuIDMqe+1YgKjPP+gpini2Xit
         iX/RhDpaAoIIQTxeBf64kw0yPrugHV4iFqEULUXODpcKC932P/RhYoQt1EeS9nFY1c9i
         U1eg+rj1VsgaU+qEl2PKQXBBXEdG7AwKlBj9SLNY7sxBHBMtk8FcgYje1R7Z8FTpm18k
         iU+6u8ssPITGEhx8t5Mxj40Md8HNT2uBXYQYuC/sGnskt5TgtAN7XPytvdnbdK+BUH0p
         VwqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXamOcL9kX5FUNVsOyNaBboCnYHLqS09rruTZ8f2Cr5oJYWu8RBhoN9TkmGPkHNDm7jhStA7FRJPnd3aqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy9+ttzvuhOPiUrr+eYCCfQwxgyhETi/eX7zH31aelcMPsEONl
	kmH10tw4bGYOdnsvtzqIgwlyFdlTDUvCfDRhsOPewR1jnDUc4SVpW7TrMOlvWuGLsvhkkVJlsXg
	NIy48sSlzOJlp8XoSeeQjsz0a0smFCn3/7Dko2pgLnufN+7qgzJ6DSSpFMtugimDDrbE=
X-Gm-Gg: ASbGnctDXhVODCH1GFotd9jXucgrn6ggl7heBHjZjTvxceucosRRApezFkMEvcHdMk2
	Ki8QesufRvKKehrvhGJ5WowU/6aKYeh3oCy8ei9M/LT0L5P70qiUDTl41hL6FypaJ8/N6g5WR8U
	c7mpKa1QTiSLCkMfWC+1jP0VGSU3H2JqrSX9iFjvmfLTrZRYlKsP1s1JY+BxRRHML/5SLOaBJjf
	dncM6duC+cX0M1ddencBScDBGLQFcgHeOsi1RmN2QaZt6s6pSd1P8Uy2p+qtxFBoXSGf6mA+pc6
	3CKmJV6xAc0cvdfVy7QshC/3cjEvEtcMjOPgU31XF2z9laWQ5bHC149faKBEydDIi/Qy+9YnzlE
	Ka0Mi6Z+Fnl2qymatB5utUg==
X-Received: by 2002:ac8:7d0c:0:b0:4ab:6b8c:1a41 with SMTP id d75a77b69052e-4b313e8321amr134787761cf.7.1756900033716;
        Wed, 03 Sep 2025 04:47:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFydRHcBvkKplIjs6YST68JZwtjz2aP/5MtAk4XG78x19SOtMnVjxJiTpoOM5lIkreVwAaXXg==
X-Received: by 2002:ac8:7d0c:0:b0:4ab:6b8c:1a41 with SMTP id d75a77b69052e-4b313e8321amr134787511cf.7.1756900033000;
        Wed, 03 Sep 2025 04:47:13 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc231561sm11483643a12.23.2025.09.03.04.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 04:47:12 -0700 (PDT)
Message-ID: <ebaa5b23-060a-4dab-a14b-d1bfdf14f3e0@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 13:47:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] pinctrl: qcom: Add SDM660 LPASS LPI TLMM
To: setotau@yandex.ru, Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Richard Acayan <mailingradian@gmail.com>
References: <20250828-sdm660-lpass-lpi-v4-0-af4afdd52965@yandex.ru>
 <20250828-sdm660-lpass-lpi-v4-3-af4afdd52965@yandex.ru>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250828-sdm660-lpass-lpi-v4-3-af4afdd52965@yandex.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 6aghMI0sdwkN0jcQtIaOeMereh1moVwX
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b82ac2 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=qC_FGOx9AAAA:8 a=pGLkceISAAAA:8
 a=vaJtXVxTAAAA:8 a=2iSbgZNHDRBba0pzZwwA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-ORIG-GUID: 6aghMI0sdwkN0jcQtIaOeMereh1moVwX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX+wFwNz5FqvLK
 2eYZxbtTqhBpEyNN58peoqAGdbBsv4xQsmC4H+xP0QjH6fdxRWl1rwSNSWmtQzz5zWhHXJ4kMi8
 KNR9cFaGMd6xjwWaLtN2DOhj/qUF1TN4mIJCLNTV1TVqpkb6DMlx+dyKAIJkeodhY89kkwRIMiU
 gSMRrbrilbBznQ0f8/RxeRbhBfGkGgWscejyzQjnm3tiMQ5AgmZZ6PRxD5/70iHdPaF0qfxyNhb
 COu3tUTj6r7SDD0VTc5jxQeH2MJueR2ABooDmo8AujpgpZOlid2JbOI1twBIVLdTdCGAo32dtUu
 hMxnCdqXHDHsG6CxvTOrZH0CMtt/e9DTHSDacaKcMSjhnveRkkn+9UZaH6sgKFOSmRafkoaBTrw
 KW85GNga
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

On 8/28/25 9:23 PM, Nickolay Goppen via B4 Relay wrote:
> From: Richard Acayan <mailingradian@gmail.com>
> 
> The Snapdragon 660 has a Low-Power Island (LPI) TLMM for configuring
> pins related to audio. Add the driver for this.
> Also, this driver uses predefined pin_offsets for each pin taken from
> downstream driver, which does not follow the usual 0x1000 distance
> between pins and uses an array with predefined offsets that do not
> follow any regular pattern [1].
> 
> [1] https://git.codelinaro.org/clo/la/kernel/msm-4.4/-/blob/LA.UM.7.2.c27-07400-sdm660.0/drivers/pinctrl/qcom/pinctrl-lpi.c#L107
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> Co-developed-by: Nickolay Goppen <setotau@yandex.ru>
> Signed-off-by: Nickolay Goppen <setotau@yandex.ru>
> ---

[...]

> +const struct lpi_pingroup sdm660_lpi_pinctrl_groups[] = {
> +	LPI_PINGROUP_OFFSET(0, LPI_NO_SLEW, _, _, _, _, 0x0000),
> +	LPI_PINGROUP_OFFSET(1, LPI_NO_SLEW, _, _, _, _, 0x1000),
> +	LPI_PINGROUP_OFFSET(2, LPI_NO_SLEW, _, _, _, _, 0x2000),
> +	LPI_PINGROUP_OFFSET(3, LPI_NO_SLEW, _, _, _, _, 0x2010),
> +	LPI_PINGROUP_OFFSET(4, LPI_NO_SLEW, _, _, _, _, 0x3000),
> +	LPI_PINGROUP_OFFSET(5, LPI_NO_SLEW, _, _, _, _, 0x3010),
> +	LPI_PINGROUP_OFFSET(6, LPI_NO_SLEW, _, _, _, _, 0x4000),
> +	LPI_PINGROUP_OFFSET(7, LPI_NO_SLEW, _, _, _, _, 0x4010),
> +	LPI_PINGROUP_OFFSET(8, LPI_NO_SLEW, _, _, _, _, 0x5000),
> +	LPI_PINGROUP_OFFSET(9, LPI_NO_SLEW, _, _, _, _, 0x5010),
> +	LPI_PINGROUP_OFFSET(10, LPI_NO_SLEW, _, _, _, _, 0x5020),
> +	LPI_PINGROUP_OFFSET(11, LPI_NO_SLEW, _, _, _, _, 0x5030),
> +	LPI_PINGROUP_OFFSET(12, LPI_NO_SLEW, _, _, _, _, 0x6000),
> +	LPI_PINGROUP_OFFSET(13, LPI_NO_SLEW, _, _, _, _, 0x6010),
> +	LPI_PINGROUP_OFFSET(14, LPI_NO_SLEW, _, _, _, _, 0x7000),
> +	LPI_PINGROUP_OFFSET(15, LPI_NO_SLEW, _, _, _, _, 0x7010),
> +	LPI_PINGROUP_OFFSET(16, LPI_NO_SLEW, _, _, _, _, 0x5040),
> +	LPI_PINGROUP_OFFSET(17, LPI_NO_SLEW, _, _, _, _, 0x5050),
> +
> +	/* The function names of the PDM GPIOs are derived from SDM670 */
> +	LPI_PINGROUP_OFFSET(18, LPI_NO_SLEW, pdm_clk, mclk0, _, _, 0x8000),
> +	LPI_PINGROUP_OFFSET(19, LPI_NO_SLEW, pdm_sync, _, _, _, 0x8010),
> +	LPI_PINGROUP_OFFSET(20, LPI_NO_SLEW, pdm_2_gpios, _, _, _, 0x8020),
> +	LPI_PINGROUP_OFFSET(21, LPI_NO_SLEW, pdm_rx, _, _, _, 0x8030),
> +	LPI_PINGROUP_OFFSET(22, LPI_NO_SLEW, comp_rx, _, _, _, 0x8040),
> +	LPI_PINGROUP_OFFSET(23, LPI_NO_SLEW, pdm_rx, _, _, _, 0x8050),
> +	LPI_PINGROUP_OFFSET(24, LPI_NO_SLEW, comp_rx, _, _, _, 0x8060),
> +	LPI_PINGROUP_OFFSET(25, LPI_NO_SLEW, pdm_rx, _, _, _, 0x8070),
> +	LPI_PINGROUP_OFFSET(26, LPI_NO_SLEW, dmic12, _, _, _, 0x9000),
> +	LPI_PINGROUP_OFFSET(27, LPI_NO_SLEW, dmic34, _, _, _, 0x9010),
> +	LPI_PINGROUP_OFFSET(28, LPI_NO_SLEW, dmic12, _, _, _, 0xa000),
> +	LPI_PINGROUP_OFFSET(29, LPI_NO_SLEW, dmic34, _, _, _, 0xa010),
> +
> +	LPI_PINGROUP_OFFSET(30, LPI_NO_SLEW, _, _, _, _, 0xb000),
> +	LPI_PINGROUP_OFFSET(31, LPI_NO_SLEW, _, _, _, _, 0xb010),

I can (unfortunately) confirm these wild and jumping offsets are correct

Konrad

