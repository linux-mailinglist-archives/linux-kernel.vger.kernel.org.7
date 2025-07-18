Return-Path: <linux-kernel+bounces-737426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA70B0AC6D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 01:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB0EAC1554
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 23:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F64122A4E8;
	Fri, 18 Jul 2025 23:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eGdaFKpp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625897D098
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 23:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752879685; cv=none; b=m+g0pgoVl+8NXOp/AtG1vLRJW+a6XWPj12ZbPxvAUyeeo/Hsm8S6yUd0YnRGcEuwjiYbqLIWvEIfQrl4l1mTB6YpQO2OE3dcnkt6wPlB2zHE8N+dRmCxlh8XXXtEACSqQcJ00lEpeD3HSdT98xhtBDLxUdaxWs14TJyNsi3GFqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752879685; c=relaxed/simple;
	bh=o1MhyC7RjS7VgJz0VSkaMv32v+76Isf0N7bHiSxUwrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6CH+HHpQqbt9WaKDKPUYzG9YxVNzAuBabgEjGA8H69F/XkrcKNWHUBstMBNMvuokM5eJvdCMu4MaVayy3+S22QzRoErKT9/u7cSgM8MXwrpcKNIIP8U35FqKrca6Af2arfwrbjelQWMqD1oEjlxkSjLVCaJ//BNFm4Z74LwY/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eGdaFKpp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IG3DVH025369
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 23:01:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xounN+Z0k90J1xcOu2qxIF/k
	zUJ4PTRWo/eJEBF8yyQ=; b=eGdaFKppVPxyOPbPOHp7874GCxQPuoj9aGXk3d0V
	sBFpfLndDHmxSy1sxEG7kivH33ulxXSlVwAFKn+PZOTf3Qsrtg9vbw+HhDl7EgEc
	7svHTr751m/gr/crMpD3FA8zIMLgCuiJMkHe7KIsWhx1Hk3eLcSj6UnlMMjbmidV
	mSyCHQcBpAbTXkLPMYmNS1GnxmPAC/VFl6VQ7+kBx6tAUu23un6d0Uq3U+i5QJFE
	08GHkE5mC8pOxEhE+fnGs88rDhr7sdBqfN4VJiNjKaFIe/AhBYf26OgWOC4Z3TkB
	WNv7RNBzuAq64HbFODJiht5RrU0OLsa1nMRYb7xRWLWraQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47xbsqha41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 23:01:22 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-87ec97f5c93so401518241.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752879681; x=1753484481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xounN+Z0k90J1xcOu2qxIF/kzUJ4PTRWo/eJEBF8yyQ=;
        b=Iwt4pNGDvQZwE26lYaZrKCiu2wPZi9F77JZ2rM1hOB7OMIQyJtDszdv+lPJ2sy0b2k
         M0D37nABxE95mJ87InkePub8Mq/1azlC5wPo7bKsfySN1SmaCilNZ3IMz0Tvv2otWG39
         aIXN7zBMQb2p5bNYT300xBH30w4nsAT40glLyCP2wx0wf5K3xUgXkqfwyM26iBUXTiHQ
         VsEXgj/ckyXpI780naSujgm0FNfI6wDtKu+20fwjq3kb8vEojsG5N/UQlNtFWNFd2lUH
         bG3x4TG6GJOFkAiUlBQ6gAeTYFuk4AicHQnfzxa56L0fJ2Lsw9PMaJtWOBsyCeG+plCo
         xBEg==
X-Forwarded-Encrypted: i=1; AJvYcCW0rsEdS5lrc1aoaNDU8L0nXg87DaZ5QuuGQi/HUA24ODNWpbpVCe5mYSBbzqQHD/bIo7hfj9clVnPtjpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZSw57XujirRBEcju4O9FgyhP1SasvgiosY+gk5YOBjA0r211e
	LH3I6DD3BdgKn2/dZsAIXsz2Ht3Vf6twwVvO3dZdS13ig4uf3FtEb420eWwnoNEJOOW4krgHQ5a
	TwLX1FUAJrbYX59VeT5wG4ffNRGxCe7nk2x2XxDbsVVH7PLL5J1gWfgWdbvymdIqx1Mc=
X-Gm-Gg: ASbGncusd7vkGjwc23sneJTXgRswjW3G2GGd1A9bL/djGt/ZZNDLb5BhunpvW25tonv
	mNJXyeQ+fD809HpCAvM6BjKfjr+CPLXiGMelFVX9tXQ6P6oxKEa7AKM/nVggeIoUoKYxXvd4q6s
	SgNawyEm7nPhgKvtJI9npBureGz/QR4lZ5mA7ayMmLqnD2R42pgoy7xFQClKj9OOh64cQeIfqY2
	Aes1sqFh/M2w8YZZL8tIg9+KFmvPxxOv43Mtfx24VTWv/cN4fsPTkXuhzjLKuRKapcASaQtWI23
	qBAqnD6EbPwafMi1j1PeXb95nXxe0ub1uI0ZKk4CjVmUasV1NtkQkC5x1g0A9ddfOiQ6ETQcK2B
	KoixuHNrOlToQrMLq7TxLYslaoNGRwfvrkfCKzxNaM1m/mk8OdjAe
X-Received: by 2002:a05:6102:149f:b0:4eb:e04c:f5ed with SMTP id ada2fe7eead31-4f955a7a6bdmr6898899137.2.1752879681347;
        Fri, 18 Jul 2025 16:01:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgHNVAt2FNfbpkxkswFgS8/fnxZDo97stUFORKL3rP3beeFKI+AoJdG8668ZH5nxa680wOPg==
X-Received: by 2002:a05:6102:149f:b0:4eb:e04c:f5ed with SMTP id ada2fe7eead31-4f955a7a6bdmr6898826137.2.1752879680955;
        Fri, 18 Jul 2025 16:01:20 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a91f0b15sm3730461fa.93.2025.07.18.16.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 16:01:20 -0700 (PDT)
Date: Sat, 19 Jul 2025 02:01:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: sc8180x: Add video clock
 controller node
Message-ID: <f2grec2qahffqgeiirr4i55uv4i344bnj7qocapsjodev7rbdq@dptsliaosgjo>
References: <20250710-sc8180x-videocc-dt-v4-0-07a9d9d5e0e6@quicinc.com>
 <20250710-sc8180x-videocc-dt-v4-2-07a9d9d5e0e6@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-sc8180x-videocc-dt-v4-2-07a9d9d5e0e6@quicinc.com>
X-Authority-Analysis: v=2.4 cv=ad1hnQot c=1 sm=1 tr=0 ts=687ad242 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=gRvX9a0DaF5FQXGff3AA:9
 a=CjuIK1q_8ugA:10 a=1WsBpfsz9X-RYQiigVTh:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 8SSVuMr1fesvS_w_pZY2EgdwgWMcOgnZ
X-Proofpoint-GUID: 8SSVuMr1fesvS_w_pZY2EgdwgWMcOgnZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDE5MCBTYWx0ZWRfX0eUfq80PesqT
 OOHhla3cuHgykZLcZrrYSe5qXfDlK/9Hw5ZYqlqIDgXmwyUbYAmLr8U8+gGxAeGEVv4VzjG3ODL
 7SCq/tmJqHoqIXw7A33dspZSTon0pO5Uy91hlTSQYbBj7stPfjoerI8L+lZwa/6st66+K9M8T8T
 DvCkSMmYvfsz/i5SLcMg1f9m5X3aNSlbofV71PfROxRb8mOGasXvd5dNLeFKK9LWUWYDxzuaQSk
 CkAMsuDBCaLn9DXTJyjVKWZr1Jm42QgwrkF0Zx7MMlhpuOjH1TYYkQmYs1knlzZv669U0qTgVQG
 N3BdQb/WurBiq0AGCv7kH5+mT2p/nmybJIr0IeZK0NxZ62Z52ryMPBf51DnInx3ddI/IjL+Mk6u
 EmKpzC3fizdXT20nKZVbK0Ps9Cn07E0Xdh8htwGsWRqHrwFYCOAk8aOaDl4tac9vC1bE5uHp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_05,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 mlxlogscore=889 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180190

On Thu, Jul 10, 2025 at 06:30:40PM +0530, Satya Priya Kakitapalli wrote:
> Add device node for video clock controller on Qualcomm
> sc8180x platform.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc8180x.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

