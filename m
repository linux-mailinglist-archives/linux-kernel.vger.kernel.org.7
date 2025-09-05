Return-Path: <linux-kernel+bounces-803017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F43B4597C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFF00174DEA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314D1345743;
	Fri,  5 Sep 2025 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d8bULyHx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB1F352FE8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 13:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757080024; cv=none; b=dGYCPW+mDuw+h1F2EE0sjKe4LjKAIL5TWDgdS3Bcvpsq18EINBo7gj1c3suMskKHhCtcedgbYXbYAhOAbP5FrmGHz2ZQ4T1aRZEFbFbHORvY3DGNJMohWBejB040s8eBsp99EMSSpVcvSc97CG54uYRfhvGHbBDjhs8/bDP0NKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757080024; c=relaxed/simple;
	bh=h0O09iRsf9dHfeMthnJk999pMS5aMUcInRudkzUILkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uw+DJZ6M0lPoDTtwppLsXsZxsVnfO86MeW5Sv5sGkWmTDI8Pp25ScF/IrTGtQ2xIeu3bt07WbHXxk4EDKkRVwiurJjHVdj1IEeMZUCnnvV7e69gY45TUoiWeoskC51hHW01iT8xT2pnHYUQaJuJCWF8YVTZHFGF0edtGx+qoZTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d8bULyHx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585D8Chu018103
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 13:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LEqUXc5cbwTjOkkBL1dldf4G
	sxuKtt2JT9JVdaymvUY=; b=d8bULyHxtMyy4qKNiXFY3gFBjl+3oJl1y6bSpPD/
	QcfaJvpSj4Fsoa2XWuNo3HoorvWL+qCd7f/DVfvWB6pE7hh7zQ8WEeCIfQ+wwT6S
	w5Al1qefwhoV0WxtQWY5pqjLdtiureWuFqmAKyXstBrp2dp1qDJYhvSyTuReedqR
	QPzK1VztV7pciEa4bzqorSv3m0fhDnmusvYtD39dgKuA9Eu0yslelaT9KamiRY2Y
	SIEvqfeULowexsIbINxuoiJzfvNrMaTGFAgaCPcsN3DI3U3+cMuWVOgZCZntgp34
	MUxKXsh8yERd3uqUR3OgyO4ifCxgEnyjP5MZ00gIhdlQfg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48yebuu678-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 13:47:01 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-718c2590e94so58297836d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 06:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757080021; x=1757684821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEqUXc5cbwTjOkkBL1dldf4GsxuKtt2JT9JVdaymvUY=;
        b=DQncgrCFcQdhOKTndXbOWTi+UO3AbcO9uNYJw7F1Hic0cSBLeYV46Go9BtksVQsdbS
         oldyzFj4fHcJP25bSRtCrRelsxBpoa3BWDPGP0gJasUR4VmHufRi7ZepNLCm7IOwpaXU
         z3wtZjmb3lV2Snw+/P3sMM6MSDfkKZe6X0q+KnfxSMA2kQiv8+bpDCN4a+zHbqW60UNd
         D6KAnLe9S854f5AsdPbxuFdsjnjEZ4W7CCIsxbmnB7oQvii6L5TbfXKbLjIeKIDO2Sa0
         MWc8eb/UJybkBuH2+R/Pck4W2XawQklDk9OzPauStHFs+cM2cp9lNjO0bd8SsjDii4o3
         etzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXn2Rb7EIrejDAdMlp+5oLIfcdr1hJ+P0SDaWf8hjtsAzgFeL4rpPTHDcXVBqDfoi/4OzUcgGvb1dZXfr0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywiaj3YQCNdXqTYft/uL8HuFVxS3+0yDtGK+7JL6XHwBDygTPfE
	u9bl13wi52efLOvS5hYREecR/TP3EOVlrHbbob4aKNNqHis4n2RHcCv9cwmbKmOC2SHdSBINxmy
	R4g7NKT31+YX8kF54lws6JJgc3Z6piPpBduTLTu6Rl6raT8qrDO9GSppGABEXgDqogrs=
X-Gm-Gg: ASbGncuq721MmXiJWX/XX+ClBuNCvIaTEzOHlNypcdRz6wqes9TxQRigPMQcMmrC2JO
	FF3aD/l3aEj7EFCnL2PCwzJ9E/C2WboQcwZKUQcaQxnbBTDr9menRutWedS+NPGyZs/U8WnYEC6
	2Kbr9lZcO017ehUu1oBIOm/l0x49kTPKmY/0lgIt6MtbiZBYidwJ/+HK8KGETPd8H3740/blSob
	yTy+9oa8vCQpnSjghWqGD7gdy2ndZBG/2ALV1ygCshHCKaiP0xtaAZFOigAU7Hw5L62KlafgJvy
	V1WK41EBrgGJkpkhRMO2Q8IDGNXe3VhhOmSOeDfdYd33IXGJ6LIDq3gXufDC1kKTZPEiN/r8d6a
	HEo6EC5lYtPqS7E3LUty+djAEWnj1S+3yGH+dwSwsE5/thZTEOSdm
X-Received: by 2002:a05:6214:1948:b0:716:fdea:db16 with SMTP id 6a1803df08f44-72bbf3fb1eamr41244636d6.12.1757080020541;
        Fri, 05 Sep 2025 06:47:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF99i4+ZgNHpEENrXMMJgwJoCqpA1mmRHdqXIu/OPhQnChIfbPSAVcT15ZOYrUVmX+skG5VYQ==
X-Received: by 2002:a05:6214:1948:b0:716:fdea:db16 with SMTP id 6a1803df08f44-72bbf3fb1eamr41244306d6.12.1757080019748;
        Fri, 05 Sep 2025 06:46:59 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608abc63c8sm1812504e87.61.2025.09.05.06.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 06:46:58 -0700 (PDT)
Date: Fri, 5 Sep 2025 16:46:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 2/2] remoteproc: qcom: pas: Add Milos remoteproc
 support
Message-ID: <nxhx4ocjpeeyyttqqbzwfax2kf3qd27cbfurvggzgds5utplyr@zt3vk4zpmy6g>
References: <20250905-sm7635-remoteprocs-v4-0-9e24febcb246@fairphone.com>
 <20250905-sm7635-remoteprocs-v4-2-9e24febcb246@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905-sm7635-remoteprocs-v4-2-9e24febcb246@fairphone.com>
X-Proofpoint-GUID: DSL3YGLhfihu3GO3XKuMXzX8rYYTnB0E
X-Authority-Analysis: v=2.4 cv=X+ZSKHTe c=1 sm=1 tr=0 ts=68bae9d5 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=6H0WHjuAAAAA:8 a=ENn5GrddmNxYPxOGv5YA:9
 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDE2MyBTYWx0ZWRfX6gOLkVjnnQyq
 M4Y+6ph9EIYQGwGUsMDHsOTNfMS9hr7eDXg0QQ5/GEC09ZePKHNc9mEoPWE3SZJX+RspA7gMaSe
 kMuUiWNIIyNayK4MZEkQwHmfBsdJUsP33uiI9rPVS8tt70LBaaGHw4D820ylS+UOfClMUTMQKy1
 zMSe6H/prawRsaVIZBvIYDSWKaEBdcpXj44kekz52FuiKSNuEssc5geGNo+lxVtmxkxpKvoV/H1
 Z+vPRiGQCjQ13MbSSMzOV81sKc+rTY8eKRuvoWp4dkofJldmHVgg4+52dEParZh1JHkGQ8OtJ63
 mwcZPZhY3dG42sH1GwjpiQmCx0i6drDjLdp0lRBoc7EkFgRizAqdmh8d4qsGjb6AOOJNbg21bPz
 DRnmgJjc
X-Proofpoint-ORIG-GUID: DSL3YGLhfihu3GO3XKuMXzX8rYYTnB0E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509040163

On Fri, Sep 05, 2025 at 11:37:05AM +0200, Luca Weiss wrote:
> Add the different remoteprocs found on the Milos SoC: ADSP, CDSP, MPSS
> and WPSS.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/remoteproc/qcom_q6v5_pas.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

