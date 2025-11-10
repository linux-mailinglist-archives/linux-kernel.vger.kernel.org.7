Return-Path: <linux-kernel+bounces-894064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ABCC492DD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BEDB3A3F10
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227B833F396;
	Mon, 10 Nov 2025 20:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iHZoEb+7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z0QGnCEN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42592D7DC2
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 20:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762805076; cv=none; b=X9vGxG00PjcXURUspCQiEpt1OHqsOFi3S8GyKuhrZG2UQohLE4pNDqNn7YiK7q1qN/MKAFkCNktTxj7+398WeX76CI/QRm7mj2UxVzmoEx5EW3+SHnyRUUtIGTcCTPhWF59iuAZyCEqRc2lxxfVty/SdYM7Ysm536KB0HmWDzwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762805076; c=relaxed/simple;
	bh=Fkcw2qew7eVStl/+jGAeuW+KaRb7Jjz96jXXyII4x7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qd1cjZhKDKtssV19Y/cCQEw0FDKA92+A6ZVmR2wMypxWSF+Lrmkm6fdR9n6HVPPqeOTRg7V7CzdVESJeUMrnxhoqLzHWRLvlUPkZZEb5Hh4ykXG0mzXIwrkdlr798NI0Y9cfnLBZAH4TaIW/2nw/kXr24PRPDhMIxpojloHm9Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iHZoEb+7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z0QGnCEN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AAGZrx62867945
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 20:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wywLQuZS84UaCfivN9hBRyvo1mTqLh2yeP1DKGiRq6I=; b=iHZoEb+7rvrtIGQY
	ZdifNm7zQg6ObBnG36sLNVmkMToc6JglIPMxJy+j4phnAhWq8JdOK3rZqcOuCjsE
	DiVo5rYj7xi8eg/Un7A7vRRh3TM1+tSH2+nAdhMWS+qF28anMvbdkLpLngazP6wI
	E+diKjovVkFr9MyuLeBfj3Bei45WdSbnWWoJKu/cK0vruY7q/cX1DJpClJfaiUOh
	c95agm6xEj3zDG/f3oVL9T6UfIDhxsUFJ8oi6otHx0T0ttsMtMP4LFNPElBZx/MP
	21YUa7uKEC1qe8PF+x8gaiT8YwV8G/kYqHSFY0UlOInvwhnVsdGaVd/A0146OewZ
	NO3//g==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abd761xuy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 20:04:33 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b609c0f6522so7691931a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762805073; x=1763409873; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wywLQuZS84UaCfivN9hBRyvo1mTqLh2yeP1DKGiRq6I=;
        b=Z0QGnCENeqnBC1x4msz9V78SSG1mSFNbdjn/kmikSlDnYlnXKm8Aeqhw/9OdMPFs1z
         iTL1zaCInEyALdqvLpeesmCfr9xuvI2sxrSou8koyUZdfkzGJjm/BYtvXgw/2w9pKgWZ
         pX0MORfru/gJqioEwgfyADXh3k4s9rdBmzOKiWfImfzBVtGZ0BKvdcSJu38zaJBWJpeN
         6yZto2mZCne0+LYE8r8QyGACS3KyRgUvpdmOpDnvJ7ZlyvYVLj7mHNJfojwk258c5TGe
         fhIkb3sNQUgnt9TXeglsBlvsk/yKEEuP/ahqh7Uu4isJZbt857fl1fXo2pVxSQykJrDm
         GMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762805073; x=1763409873;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wywLQuZS84UaCfivN9hBRyvo1mTqLh2yeP1DKGiRq6I=;
        b=V/Fyo3r3Y45HTap3VikqY/CY58aPfl0uzW7H0mLFHRfUN71IPDPq2Rp+6bEJQoBU1F
         8NUKRVG1EoDBjROZz6EAnxo631+wxKzZ3L5Mp95GMqs3sp4dTtA5akmIv2cSzqjCHLyY
         L+PUvmmF8mKMSZxy6ImDvDY9Ml5HgtivU7hyDKVAcSdL7Q6tRI8x8Y9Py+mSyi8R5NPU
         aKRVAEmmwPVSsqVGqPRmPiiYW7E060qvpMOFjrZNumrDYWWhNzcvCMHSkRO6jSg1KAng
         zxvID5vGZqJ/VWnGNYlBUYj1RRlma/6e9vEW1zNR3V75nwI8QsE2xTRytrCovxaZi9WD
         YnvA==
X-Forwarded-Encrypted: i=1; AJvYcCVJNrRtV0AeozzGHhFkmxJKNxlnCkW99yFLaFVdGu48GuorOIDMbATrXL7uGkGKDu0jlOWU1tNmGn1yK9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ0YgRLRriRf+TxznO+xYqNxlk90ivBcLwzKdoAvRxkXuUV/KI
	Y7O9tuktRwFIU08xiQeYtBcv1oHOysxZet7XwY/9L9CVABjp7+xvC1mdE6bJ6plhs1pl9pZcgVQ
	ygSsWpNWK0dIrg5hGDQsuIXFW8at8rGG4rRYGBZ834P0ZnH9mO44pFgLItiG8AbbENZE=
X-Gm-Gg: ASbGncvdQp3Rgf1QbkazsljLYKeAngSKTiKmCrvG0JpV0+RwjTgaI4QsPDwsNtJ+wrv
	dmX5TEmYWoQ5UzlXa45PXRRifFwyJI3mghRJdYXrZeKMOoym9euXXgclvIniJKfGbOaMdro0vc5
	BzAlpr6+qNQdH64cLxv1M2sC8eEHsmaEkERoOTiEnXjgT/rN9OaalNI0U+v0TwYkBHpQKV1elIK
	85lmSGHPmAyJXohhFqfbGXa4E7VQdEUQ1DC7cfkYPC0UmfjKV8dVfLF97RZHCw7/DejU0JU5eMR
	Gft998LwK3TL+3vGsxuhN4XfPXsyA1OIOTyvn8353Vfi3YR6R8zuD8vJY/Ly7uzgy43E/kMlcpW
	X/gY0xYNlMJINaEKQocPc4aKUVsq72Gtxv4lypo6oTdWYPRHuQggI9BZKgS+HeYZ7HA==
X-Received: by 2002:a17:902:c94b:b0:294:9813:4512 with SMTP id d9443c01a7336-297e540dd6fmr127849575ad.3.1762805073089;
        Mon, 10 Nov 2025 12:04:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgRlu+QHDT2qRkN8FN4ZfcELPFfekO3p0qsOXqvaypumnws68i1D7DWIV/z8geDOvCYuPmxQ==
X-Received: by 2002:a17:902:c94b:b0:294:9813:4512 with SMTP id d9443c01a7336-297e540dd6fmr127849065ad.3.1762805072440;
        Mon, 10 Nov 2025 12:04:32 -0800 (PST)
Received: from [192.168.1.3] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297ed6808ddsm81285505ad.17.2025.11.10.12.04.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 12:04:32 -0800 (PST)
Message-ID: <2b34ceae-5e31-4dba-93e5-3fa35754fab6@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 12:04:30 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] ath10k: Introduce a devicetree quirk to skip host
 cap QMI requests
To: david@ixit.cz, Johannes Berg <johannes@sipsolutions.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        ath10k@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        Amit Pundir <amit.pundir@linaro.org>
References: <20251110-skip-host-cam-qmi-req-v2-0-0daf485a987a@ixit.cz>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251110-skip-host-cam-qmi-req-v2-0-0daf485a987a@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: GcuUCHi1ppFRfxYdZpjlCxpzY6NASume
X-Authority-Analysis: v=2.4 cv=OK4qHCaB c=1 sm=1 tr=0 ts=69124551 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=p0WdMEafAAAA:8
 a=V89vUnNgf5GAzAs4dTEA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=poXaRoVlC6wW9_mwW8W4:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE3MCBTYWx0ZWRfXx0pGf/NfK6Sq
 PmykIjrE1lxmOH4U0NBIU9tMq2TNvTMf8aW7Vc7nZBLyb3hT6TGhWPiUdhzBAP4slM/lZ2JWcHt
 16rT5SDWxJRLJHa0zU7e0pZGKJ+CvZaAE0AJb5vs8m/RRDuas7LwfKOeYDdYSo0aZ2s0qAc2g9S
 Ok8NFBuJMasE/cT39knnNCLBNqYm7b4PXWrRT7e9gwViS4/apHUA3X5MMj6WCXrvjzMmnU5syGS
 paUAk6e0vVHAQ/a3B8Ma7deTp4RYnQ1uirijN6RHMFPnDsz2MiG7ipg86v+H5hGr4Ddn2tuf/3c
 y0biSr9ps+M1M4rlMsiuxzjc6Qgd78pPMxOabdpjmNe3069zu8mKTBIYSpsddE09RVg6Dy2u7C2
 R/PO7K5za4mSpj1bDv54Quy59uMvsA==
X-Proofpoint-GUID: GcuUCHi1ppFRfxYdZpjlCxpzY6NASume
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100170

On 11/10/2025 6:26 AM, David Heidelberg via B4 Relay wrote:
> This quirk is used so far for Xiaomi Poco F1.
> 
> I'm resending it after ~ 4 years since initial send due to Snapdragon
> 845 being one of best supported platform for mobile phones running
> Linux, so it would be shame to not have shiny support.
> 
> I'm very much open to suggestions how to solve this in a different way,
> as the original discussion thread got quiet, see
>   https://lore.kernel.org/all/b796bfee-b753-479a-a8d6-ba1fe3ee6222@ixit.cz/
> 
> There could be other devices in need of this quirk, but if they're not,
> we could make it compatible specific quirk.
> 
> Until merged, available also at:
>   https://gitlab.com/dhxx/linux/-/commits/b4/skip-host-cam-qmi-req
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> Amit Pundir (3):
>       dt-bindings: wireless: ath10k: Introduce quirk to skip host cap QMI requests
>       ath10k: Introduce a devicetree quirk to skip host cap QMI requests
>       arm64: dts: qcom: sdm845-xiaomi-beryllium: Enable ath10k host-cap skip quirk
> 
>  .../devicetree/bindings/net/wireless/qcom,ath10k.yaml       |  6 ++++++
>  .../arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi |  2 ++
>  drivers/net/wireless/ath/ath10k/qmi.c                       | 13 ++++++++++---
>  drivers/net/wireless/ath/ath10k/snoc.c                      |  3 +++
>  drivers/net/wireless/ath/ath10k/snoc.h                      |  1 +
>  5 files changed, 22 insertions(+), 3 deletions(-)
> ---
> base-commit: ab40c92c74c6b0c611c89516794502b3a3173966
> change-id: 20251110-skip-host-cam-qmi-req-e155628ebc39
> 
> Best regards,

The original thread predates me becoming an ath.git maintainer.
Just for my information, is the firmware and board files for this platform
available in linux-firmware? Or does it leverage the files already present
from the original (Android?) installation?

I ask because the alternative solution suggested by Kalle would require
modification of the board file on the device, and that seems more of a hassle
than just modifying the DT.

So I'm personally OK with this suggested approach.

/jeff

