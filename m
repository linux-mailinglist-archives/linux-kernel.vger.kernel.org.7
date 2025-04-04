Return-Path: <linux-kernel+bounces-589374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFD8A7C4E2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 22:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 735F81711B7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 20:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9681621A455;
	Fri,  4 Apr 2025 20:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pJVvUSiH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C5916F8E5
	for <linux-kernel@vger.kernel.org>; Fri,  4 Apr 2025 20:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743798499; cv=none; b=bVJPTeSw2w3XsT8023CDDWFJv4bTCsfysL+rRV37EjevtNLOxAB7OCAa1JbJXStNCTF/1nYuOdaxM+DYRKz5fpv3k7y04WU+lvAhPzDYDlQ43hCaSmZKSjbeqG0rmyTeg89avAsbs6Eq4hZ3Hy3TUqt1G/GJQLOAOClF05bCsaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743798499; c=relaxed/simple;
	bh=6VdnbYhGy3r5+8eECcpomK5pToziEFD72vAtfF1wNLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JLYEZiEUjso+Sa3KWw1dqY5rHeChq+HQCqSkAMohgoecEHaTf07w3sPaZa/byfdduh6kqkGbKuiAK45DHp1U9darh4RBbMN0V9YPHeRikSX8J+zWkHEEXmdNIqXBhn+3GBL2af6sJNJzjJz91lONQ490NFQqWetzAJhITPiHYxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pJVvUSiH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 534JFItG006913
	for <linux-kernel@vger.kernel.org>; Fri, 4 Apr 2025 20:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GHRYAy9VYazkChkIxg8YtCXwmpRsQX0Tl5KM+EPPgvU=; b=pJVvUSiHwqmvo86h
	Mqz4Q/WnqANpbfqZlCaDSPUWlkMubqtdXp/NaRc9naRXuxP0prRMEmBbAV49djOi
	UK+On9tkJ5vdP0DhZ1mRJXRhJXZ5vwWRG8XadPvXFA7XtnAQtQQrfaKi999ImzN9
	BbLTI7PMR2ayw1pjmyL2JNIMFBjOIa/UvqdlknD7EToePBBBl2wQv0qZI1bqeDL5
	xPLtEJAugYwpzUGlPHz+tngdqJ9Ss8wnwxuAxNHJOyJ4KtmGPSbkZ7v9QzqrdQkU
	2hdWTedgIQq3DFuV39YYB9DewaZ+Y+vxeInHLQfMyWokX4IGTGB57SrId8+LNDot
	T7f62Q==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45t2d52vw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 04 Apr 2025 20:28:16 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6eeb8a269a7so5739286d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Apr 2025 13:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743798495; x=1744403295;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GHRYAy9VYazkChkIxg8YtCXwmpRsQX0Tl5KM+EPPgvU=;
        b=Q3u0i3VnBYB6I2JoEub++uVAlZr47gMGXwHLayNb6YeaS6s8dg79uukQ12Kj94xcw0
         DDQneacs7cS9LO+dRO+MA40pUswb9xTgcY9jxwzenmGsJvNeD98bKiiVrVwx2RmB9g6E
         yDFLh7Z/WZsCaGDiAOBiaCQHe50NYrBS4zSGes0RcSqcdx7SJxeB0cfUJXpg0Ns58fR8
         KeVKxpoXAXeCEFbfw9Rq/2t3aAk+fQy85s3OLJYQ5I299ZpeXSULrYox8ihVabyMWCA9
         yWWEpguSv7MMaIivE6ep95lYesUOsnh8o0lPbSx/IkOhoANQNeNQVl7OkTjStFxB5Lkl
         pYBA==
X-Forwarded-Encrypted: i=1; AJvYcCWN/rkhkUHUTW4GwgfxgGB6Q95RnWNLeDi4LOapTTZp4iIO/JvyrOVCQibQbyk6KWjCaLEAKVWYrAK+GCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1dpt9sDQ3c9aE2Xm3LYX9t4ChjHjPaBygy7qX1191c5kztWuW
	DYgPzP9fZfMDijl5PeuGTOTbBFxVNCKtUxyGNf3WsT6Kw/Yq9aVRPd3Fx9w07tqgiq9eVIVOcsG
	gLGMpT1hlfHszaBj1aBZ9xuvsxtM0v2GtW/sX9TjdBGXrBn1bFDCWzC3hO4aVgxc=
X-Gm-Gg: ASbGncu8sXF2tfZHZjUsvD0hIzyAweWTvUNve4x0BqLTYyaje/Dw2Nmw9MNWnNUEaQA
	u8uc9Yzk/LKja+zNRzWFNFQsGqzQCcl54Y5P/iSc2zH6iWiVjuZagD78ARsERlFjh2rvP3wMc5A
	rPQcYu65u1Kf2z5ffdxexLvFY2xWDQupTUyTBJZem+4Ve2EGModoB4aFIpYHqwgXkVUk1nbmJH3
	xJflEqpq6Rb/e+F9O52eYuRQhmi0dlHdK0U/hdlhVQalCBw9ntz1XLrTWF9A0Dl47Ne77IRLfdS
	+lZMLDZ67iiGHTnvQpf+4V6ZAj+dUImsxyCNgQaM4vkXpVKrKi7v1vj7HpQdQM73fSLJrA==
X-Received: by 2002:ad4:4eee:0:b0:6e8:fbaf:fad8 with SMTP id 6a1803df08f44-6f00deb2207mr23904456d6.5.1743798495073;
        Fri, 04 Apr 2025 13:28:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoIVAXrUTfJsMNH3k0XqfcfQJdY+GOn1kP1o4noSEmw/2wsl4BJad6Is0Sd5MjPz2dbgObFw==
X-Received: by 2002:ad4:4eee:0:b0:6e8:fbaf:fad8 with SMTP id 6a1803df08f44-6f00deb2207mr23904146d6.5.1743798494647;
        Fri, 04 Apr 2025 13:28:14 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfe5d420sm309414066b.2.2025.04.04.13.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 13:28:14 -0700 (PDT)
Message-ID: <69da0db9-8f32-476a-a8fb-ddb5e6e185e7@oss.qualcomm.com>
Date: Fri, 4 Apr 2025 22:28:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/19] arm64: dts: qcom: qdu1000: Fix qcom,freq-domain
To: "Rob Herring (Arm)" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, zhouyanjie@wanyeetech.com,
        Conor Dooley <conor@kernel.org>,
        Nicolas Ferre
 <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-mips@vger.kernel.org,
        imx@lists.linux.dev, linux-rockchip@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-renesas-soc@vger.kernel.org
References: <20250403-dt-cpu-schema-v1-0-076be7171a85@kernel.org>
 <20250403-dt-cpu-schema-v1-5-076be7171a85@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250403-dt-cpu-schema-v1-5-076be7171a85@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: EAc2B9VBmLshmpuANpAWHs6yEB8aDDwL
X-Proofpoint-ORIG-GUID: EAc2B9VBmLshmpuANpAWHs6yEB8aDDwL
X-Authority-Analysis: v=2.4 cv=bZtrUPPB c=1 sm=1 tr=0 ts=67f040e0 cx=c_pps a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=nTi4DTMcPcBUEvcNss0A:9 a=QEXdDO2ut3YA:10
 a=3T6Gmkx0uuYA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_09,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 mlxlogscore=926
 mlxscore=0 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504040139

On 4/4/25 4:59 AM, Rob Herring (Arm) wrote:
> The correct property name is 'qcom,freq-domain', not
> 'qcom,freq-domains'.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Thanks for spotting this!

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

