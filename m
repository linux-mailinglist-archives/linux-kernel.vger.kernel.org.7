Return-Path: <linux-kernel+bounces-894090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C55AC49425
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E8F494E8376
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C242EFD91;
	Mon, 10 Nov 2025 20:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h8QbNoBr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ot1WIuoZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146512EF646
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 20:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762806958; cv=none; b=bxPotZB27HnhXfVjnOmm5K965czGq3mYPO6+t9V2QVm6EInH0x0jYXcXSC6INY85pKD/ba458wUjSKdTjDWxxQO2H/R0GO1J/ZZ2649VDRCDhqns+zYCs7ZNWgk2fM0HFUY6im+oF5pcmYonNfGbt9aAPpqwscsim6dPy4SXjVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762806958; c=relaxed/simple;
	bh=6214/vB/U2T9ZxG1wVNkrl1tZxoGhwbwSuU0K4bc0oU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVwXH4Czd8/7bt0hQ5OuUxf2dWN/1pSw79dsbdL3Iq8BSE6AdELF8qmFYASycRRFEO3/YpNvSh0b995Dks0X01YS9zWOev8szfJQ9OFsuMQtKjAvEuM9cOYvz/Mo1prhOHkfY0TYjGg0z+r23mPI7/wdkBp4L0xtmpm/lD8/hYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h8QbNoBr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ot1WIuoZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AAFhXTq3985490
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 20:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=HrusHWa4xpz02NNq9Rv00ajz
	hsc5feN0A2MEhrWFj7Q=; b=h8QbNoBrG44TqkkpXtfasvkklbUzYf28BBnTtLPd
	CVq0Gch/ivO9Z86GYUrPpG6y7SDtJBZvkdDPeQI2zrhP5LxpDO1zR4ACotuTaO6N
	2yoY+57FkIBCWaPs2Z5fbg8/okriYWLgZELUfCVTFCyzWKgCYT9ltpSE/dhpplLF
	JB7J2XG2WsCJHMh5/+0fg7D7GfJe9Kf17kUYhyG5SNrUclP7ATSVEA/+IzZFb/go
	yXMwQd10dGgodh6eqzdshBR8pV3fMzk7nbDWV49RvrsaZHH2P5Q4MDiuCXjUD2Hm
	JrH/eFeMAJWGegHu6rtMwwSFhZNdk8Tg3w3trcRQIGdX2Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abjxqgvjy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 20:35:55 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed7591799eso97979771cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762806955; x=1763411755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HrusHWa4xpz02NNq9Rv00ajzhsc5feN0A2MEhrWFj7Q=;
        b=Ot1WIuoZr1jXGaqKoID78kWyRMNSsc5aJAKI6EA5t6nlzvPpgCL5+/8inKsVR7B8xZ
         mPsrwZod4f6LLOUOUuHF+kqvctd+Qp04n9+X9lNnjXE+foynGJUKbcotAE5VvSDPmZob
         lYT3g1MRurw7HkISrmGVwU2XSVCAJkD0TgKFvK5TnckHXmZgTZo5N3QFXq1E3DGv23sm
         3nlIljBgerA7ppqQW0SOPRXamgB5TR8unz2MJqhj/9soZqs6+ZM3im1UisKnvESglv0Q
         +l0/sWF3lKYiVxLeFtOPLEKRvA+nTKq4y3MmskuHcWZbVwqNW4kyp87cYe7xHSafxRWw
         PACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762806955; x=1763411755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrusHWa4xpz02NNq9Rv00ajzhsc5feN0A2MEhrWFj7Q=;
        b=lxxzz/skkNuT5aBiQKhHih//eAU8qYf1HgkEa+s4zaGK6sgihZTAKT13JNw9oMXvAe
         wjk6h5sV62XKCCo65UGJtUl6KPgTsrjKVU6wuS0kEx1+a0VO10r4GJ2O/rZEHCejyzxO
         /l9VMX+oZqHrkzFjxl1OWAgZHB6KmxoCMkrnLkKE6h1bSYjT/Obb2pKk3rMDLoRu1kNm
         25/rIFHpRvwVTfr8CL2h32setoaKpwgJ7sylwNYyxWZJ2w6N8SNm9saOt7oyE8WMGyO/
         LnPVTY2lA9VcHHpaTJDjgFGBxquK6S4HqcCYTcgH7QmcCqcrrGUXOGaaPDkJAjqIQ3EE
         k/Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUw/hxTptgitenYUxe24PI37vm2+RHemMyGn4K4niP2q0qPoUpz8F3tECR8Bk2QtRki2/z4EP08bseCcsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBgD5oPFZ0LGpvbvr6vhrPqdwL2ZMaqc2SdHjE4AgxylH4HZnQ
	YNoEQ6+8P6insc76fwtnZxFV4T99axLAyuFbOEtzoM/b5ngbcUFvgtv/hHyLFMoLqyI9KfSZemQ
	2rmdEsNNPx680fBRBVpAgZVqmFhG/+6a7yc8EB4z+d48LtKZIahyEx6n+hj8MxeL6Lnw=
X-Gm-Gg: ASbGncsy5Zr0QEliPO2kNtaaD9HvRIDfs0KG6W8cOBw+swl8Y7wsfIlDE8ge4PrQrmw
	JN8Fiuf8HR/k6FGkXQv/Cc+hd0Y4wDoV9cpmOk68cva6feIjWDtaMhdfuxW1d29kvdPfDgVypd7
	qqx2Uxp8wbSGA+QRWGM6Ry7FklVxY/Ps4mNFakMSgYmfU8kEgAVi7oAjE9HoL3EG/I5+HEW41GT
	G0rUNP6z8B9jc9Jz0xV6V2D7LJ5s0aKE3CBAPisRqnqkYOuBfzVw9sw7d06fknY//XVmR2oHUNO
	LXA35TeUkP6P9Vs9SBc7qGgBktNdab/8A3YwP6famxazqhEV7Swlbqc/4bAYttpwtKaShM3Wt9W
	OAkQnZLGMn9kZeoYsajnG3iCJxNfzbsml/gs5QtRIl/dTcFgesgUpC/6ODP6vTuspzolQB78hV+
	1+YbncLt3AAQU1
X-Received: by 2002:a05:622a:15d1:b0:4ed:67bc:50de with SMTP id d75a77b69052e-4eda4ec8bf8mr113489681cf.24.1762806955262;
        Mon, 10 Nov 2025 12:35:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJ5ssDcgmggW4lpYvEvrEq74tSuo8cOVQiuKY1y0jHjepaZLONK7Do79X9y4s2nxZqgmpA+A==
X-Received: by 2002:a05:622a:15d1:b0:4ed:67bc:50de with SMTP id d75a77b69052e-4eda4ec8bf8mr113489431cf.24.1762806954848;
        Mon, 10 Nov 2025 12:35:54 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a013bd8sm4360891e87.1.2025.11.10.12.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 12:35:54 -0800 (PST)
Date: Mon, 10 Nov 2025 22:35:52 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: david@ixit.cz
Cc: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org, Amit Pundir <amit.pundir@linaro.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: wireless: ath10k: Introduce quirk to
 skip host cap QMI requests
Message-ID: <xgyd3ofvv7blcfo2iw26p7sh3p7lkb5w6kkbogryzrgytkrmva@foo72an5qs3y>
References: <20251110-skip-host-cam-qmi-req-v2-0-0daf485a987a@ixit.cz>
 <20251110-skip-host-cam-qmi-req-v2-1-0daf485a987a@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110-skip-host-cam-qmi-req-v2-1-0daf485a987a@ixit.cz>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE3NSBTYWx0ZWRfX7MhErHcDWgaj
 LgQUiQYUXyX5huRktNroLR8dvOuvoiHGyWMzSLsdPhRC7dSWLgtEx0g9fsNJnjhQa9V/24SwPfJ
 tqL5+5eBXf7Qbha8XSazWVfVEcGJc48kNfqyTSTcesDlWhw9VzjnKeFSjLZKgfeqYjmtcQi9LI5
 4D89PUX5bIgYWAo1FVeMnvMIy8z8aVAjdDeiAT1KN43xPKybN2iICWkBqeWgBlXPAUQ7kJ0gC26
 R8xoXc4jqX/rxq/9nxV18J2/9Jocc+JxqQ42PPlivHnagYnbgtVPVvbkUOtw23RvLjrATI6jAlT
 34P9aSWZ95nDhQPcUstXYpd0UGNG4X+HZxyJzf8xVX97yBOjRLyB9w6B0rIu3D8OBgD65ZpDRLr
 6OQu/IqP0K8vFzPK5uBEOJ+dNwUHUw==
X-Authority-Analysis: v=2.4 cv=CsKys34D c=1 sm=1 tr=0 ts=69124cab cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=bBTs48EDRqzxHWfT9_gA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: DT-mPM9kvhhaCitI6jN0-n0LPJHj4BRL
X-Proofpoint-GUID: DT-mPM9kvhhaCitI6jN0-n0LPJHj4BRL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100175

On Mon, Nov 10, 2025 at 03:26:24PM +0100, David Heidelberg via B4 Relay wrote:
> From: Amit Pundir <amit.pundir@linaro.org>
> 
> Introducing this quirk to skip host capability QMI request for the firmware
> versions which do not support this feature.

If it is a firmware mis-feature, why don't we describe it in the
firmware-N.bin file?

> 
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)

-- 
With best wishes
Dmitry

