Return-Path: <linux-kernel+bounces-834712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1ADBA5566
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 00:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE25D1C061EB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 22:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD8027EFEB;
	Fri, 26 Sep 2025 22:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NIIdeMse"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C271D7984
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 22:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758925964; cv=none; b=KnqQgiqvZ/uzvfp4Ec5RIHbhTks2UrJtYqHYDTpCgXzaP5DlbNwiosLb3FSXqTSznoGo8gE74ar4XNJC5+7ZCIap5zjJ2677TlXg9+9U2MtiLPp5BQMm4HJ4W431Vj1jFybtyQAnqxsYOUK8IT9QSLrKFLZtMlY6b/FLG7omhhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758925964; c=relaxed/simple;
	bh=znFcf1RBV0F44gQwo5us/gWI6yjbNviXchEBoQK6rSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbIjsrYC7wANrqFexmXONZLOtsvKJ7ru3dwj/u2UDu3Yw4MFihtf3eDWsoOkoNFC7sCk5klzDke1RbmDV0SUzUzEwtt7w9VBanIIY5ugpVD7zF8OG8TyUVJs14xOcavgWMyBm867/GXxpx8ncK6D4WVx+Z+Boc+n1h+oI/+p5bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NIIdeMse; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QEWsDm019361
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 22:32:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2SVj+rcrTxYvSoZ0kq/i2JFM
	zLdOy0X+vezT0Ex6p1o=; b=NIIdeMse6Y3bSYMx9gvq5jlmkWzGJ04T9+n4a78b
	MNxEMKfIr110a9g9unBtvcBxZ+gv89wrXtbKus4OLaGllYRX3glsv/pwD7l/A9wJ
	CkEIQFtBigf7W8WqCjGdbyNMqFAsyVu8AfCzKJVf+lgAODVIT0l+mXOdO/l5xBM3
	aOpjumfKq+OUcsA2gyxK/WePIeW6SCMA+uGFAy20hOA3koo+gG0tquk2tECLHRef
	RxBzQahiUGDa0gdSjr5E93PgDbhi4/9NFiu8q2QxpiNGn5O77MU2ddSL2RUUro/4
	mDGRGxIzFhe3G3MrLtaF1FxJX3uP+JL8Dbf7Hm5Ofy2XLg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49dsqrhp7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 22:32:42 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ddc5a484c9so27570331cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 15:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758925960; x=1759530760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SVj+rcrTxYvSoZ0kq/i2JFMzLdOy0X+vezT0Ex6p1o=;
        b=K89xm8mSFNx8xhF4sKZZPuMQbjXf8t1GuR1uZkcy7vgHmvuI2PEGHzrm0a3Ww+OhlO
         8w8FRzVgvZr5riS9JVwF4L5681mm9fBPW8JXCMx/7LPe5Um9ECsZCGZNM8LVf5HhPXow
         z92l+1RHXxxCeyMjIWGElEIfJvYloWbPia4LRgzQwYxvj9s+WdUo/ar1I+XR4k55YEUe
         BquFSW2J7i98vWU52DzMGa6UnlPLYVBTVgkiSvogRPS4Y4vhJjRX/YBdPi8K6qdFWLG7
         CBd3lTwPC6NG9EwR/FXG6ijXS+rAj+8B/w4O4eNrta2dnmycLR/eDi/4n6EAfRutfcAY
         a+AA==
X-Forwarded-Encrypted: i=1; AJvYcCVZPgA7r1YkLBP+Z7A8CgtQyb8VQQ29S741UiZemYxJM3UZNnOUypdmR/4yVAROzamtB28NJtZmS5GdMkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBIQdW1mAVtjQHOyTFQeJSsmSac3SUvlAmVh1AimxosYgZMBpx
	tu+z97YwwsLukHArwav7bN/HM78lgE2t3cpq6Rs8BLBkevriTalMDkuI5nRD5dIhQH42j7kPjLc
	pHF/J97mcxN8nnCgV0gHYBPAvWl+ki0qQBJ5vk+DpnoeJflAxJMZSu2IkuQF6Mz7kmKloSyiiXe
	I=
X-Gm-Gg: ASbGncuocKMcETT1M1dQcVSr1GHS1BIWHygF8deWFY8rMluWLuA+F2vQ+Loa45fAnAi
	L8JdBYG+ZuWIw6tJw4jGuQ7vZorjWfRrfCdNUde/73AjiUgpNOatn+cgfuUiOXnlvmodExoBvO3
	t0YCUbjylLE8W0RYWjnGWDHe94ftxo9vRss6GvkquB7vLwLvwXFRNYHEWPCC1ZuDRlHzcinHycJ
	N93eR8n/g0X4dNS/5LMCeJzqUmsdkAXCzSvl1ZcRyt9htVmkkqQoMd0cIfDirMrhkcNQHkBuOF3
	DI7lKotBJsIOXm4Nz3kCgdbuhnsbMq2MhbTWlSwtYKTHE7RNN6/NfvaRrZKlwoCULcBJBQEcfUv
	M4XDhNe3kgphDwVG3lvMzwXGkW7ogh6ug5SKlwQ2dDVt6XaGwBzTx
X-Received: by 2002:ac8:7d8e:0:b0:4cf:b74b:e1af with SMTP id d75a77b69052e-4da4c1aeacfmr120856861cf.63.1758925960387;
        Fri, 26 Sep 2025 15:32:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSKsflht3AH+ZuTBu3r3cqv4Tg39yfPXMIU2pgxdiUv01mDKS9PShSozAj2uV/V6eYBFeM8w==
X-Received: by 2002:ac8:7d8e:0:b0:4cf:b74b:e1af with SMTP id d75a77b69052e-4da4c1aeacfmr120856541cf.63.1758925959860;
        Fri, 26 Sep 2025 15:32:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58313430ccbsm2145795e87.17.2025.09.26.15.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 15:32:37 -0700 (PDT)
Date: Sat, 27 Sep 2025 01:32:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Aleksandrs Vinarskis <alex@vinarskis.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: Rework X1-based Asus Zenbook
 A14's displays
Message-ID: <nemvj6vyk2mj255l5fi372677znsptawkkhx4zlcsty5enpy6a@fhtpf2c6v4v4>
References: <20250926-zenbook-improvements-v2-0-c0b512ab6b57@vinarskis.com>
 <20250926-zenbook-improvements-v2-2-c0b512ab6b57@vinarskis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926-zenbook-improvements-v2-2-c0b512ab6b57@vinarskis.com>
X-Proofpoint-GUID: ts__Q4QyrkYS6vkkixtP4qL11ryGE9ue
X-Authority-Analysis: v=2.4 cv=d8n4CBjE c=1 sm=1 tr=0 ts=68d7148a cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=I76Qk8w-AAAA:8 a=gxl3bz0cAAAA:8 a=APu70hjm6WG7nynXYqgA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22 a=vUPM0Wvl0xcrLs4nqPIT:22
 a=kiRiLd-pWN9FGgpmzFdl:22 a=poXaRoVlC6wW9_mwW8W4:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=UDnyf2zBuKT2w-IlGP_r:22
X-Proofpoint-ORIG-GUID: ts__Q4QyrkYS6vkkixtP4qL11ryGE9ue
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDEwMyBTYWx0ZWRfX/vxMJpJarFKl
 v7dfe3EVcX1iWeIsQaAlW5TskpWnnkNsIYKCcmJhO4Vw/2IxUNOkTNOg/hvypM7KMssLTE5OjMk
 XxaSmY2APFLMSqIYb27tYj05zp0NBlifkxNROngTRQat+8tk71LMKVe1r/75WXjXpv7yWCDxLVD
 Pd+0+BGukwVGSzGWsPXJySBi+3GWnIqePsBPHVLP+FvNA084isuq5H6janR+zktqrCr66UCkwkU
 ZqO/+wp8RBADjp46B/K5ezZxIyCGForKHQU9+gYFi8wu4TTI4fqvLYQS9iHrXHi+Gyo7RsfKMTK
 wfuiXWyiGiWuretOwaNxoZtSVa4Rjo5U8KAkXKbQT5zD6hejuvC/grJTOHwtD1DlNECkqgjPj0t
 dp1T0xAdEDRY65P7NiQ1H5hOA9tpAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_08,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509260103

On Fri, Sep 26, 2025 at 09:08:53AM +0200, Aleksandrs Vinarskis wrote:
> The laptop comes in two variants:
> 
> * UX3407RA, higher end, FHD+ OLED or WOXGA+ OLED panels
> * UX3407QA, lower end, FHD+ OLED or FHD+ LCD panels
> 
> Even though all three panels work with "edp-panel", unfortunately the
> brightness adjustmenet of LCD panel is PWM based, requiring a dedicated
> device-tree. Convert "x1p42100-asus-zenbook-a14.dts" into ".dtsi" to
> allow for this split, introduce new LCD variant. Leave current variant
> without postfix and with the unchanged model name, as some distros
> (eg. Ubuntu) rely on this for automatic device-tree detection during
> kernel installation/upgrade.
> 
> As dedicated device-tree is required, update compatibles of OLED
> variants to correct ones. Keep "edp-panel" as fallback, since it is
> enough to make the panels work.
> 
> While at it moving .dts, .dtsi around, drop 'model' from the top level
> x1-asus-zenbook-a14.dtsi as well.
> 
> Signed-off-by: Aleksandrs Vinarskis <alex@vinarskis.com>
> Co-developed-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>

I'm sorry, but I think the order of tags is incorrect. You are sending
this patch, so your SoB should be the last one.

The patch LGTM.

> ---
>  arch/arm64/boot/dts/qcom/Makefile                  |   2 +
>  arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi  |   7 +-
>  .../boot/dts/qcom/x1e80100-asus-zenbook-a14.dts    |   8 ++
>  .../dts/qcom/x1p42100-asus-zenbook-a14-lcd.dts     |  62 +++++++++
>  .../boot/dts/qcom/x1p42100-asus-zenbook-a14.dts    | 133 ++------------------
>  .../boot/dts/qcom/x1p42100-asus-zenbook-a14.dtsi   | 138 +++++++++++++++++++++
>  6 files changed, 218 insertions(+), 132 deletions(-)
> 

-- 
With best wishes
Dmitry

