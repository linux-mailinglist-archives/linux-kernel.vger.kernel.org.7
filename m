Return-Path: <linux-kernel+bounces-747148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A74B1305B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 18:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B748E3B9CAF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 16:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C5B21A928;
	Sun, 27 Jul 2025 16:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IDf2+nCl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0A321B1AA
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753633171; cv=none; b=TOlCswJaZ4nui/JJXVTwAFq2CbWfvEsxnY1iDwWhZ1xl6Q3HzdyGnxXX19vy0UY+YmV0Gh72UiaGcfaGCpPGd8ScMFdOcz26ihmEM7jXOGVh/qlQ8g0ylfCi7r0XqY/nI8dxj0U+z7h919L7kIyuBjjK//FmraNyPFRANMPbFVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753633171; c=relaxed/simple;
	bh=zk0/momZBJ22XiQ3Zdbe51H83JVBUxT1l++e5D0cni4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/4iKflFh0+5ADh+vwZxK46/3uw133pNIUHACWJZvWjELcNb8h48fwnTXEpDdFqZPKoEb1ns3j04/q0CJKslShr0UbU346lm6Krg2eG+anfEYLeVH313MIaPYsKFa3DiTEIbf8NRnVlmdftSC7biLkq0o5MLxb/zSE6AjBL2toE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IDf2+nCl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56RDq2A7013175
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 16:19:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xog9pMwnTfyyxDALiAzNjbCD
	9BofGhoxhGYWP0UmMU8=; b=IDf2+nCl7wRx54VmXRaUeNB9EC2WlJjSQrpf1jZJ
	vQvLRYJfrlwn1T/+I4BCQukjzL7+C/aQFQOSnL8ATryk9cj23SqtNQGYWs6rVjre
	vyl8ady4KuFv9cU2kw5eyFz0yknPYABPiQrF6HChvTbYQW6itf9xJvVoOP00v3FE
	iAY1KgzlzLqEuPbrJppMdAj2ZOfDjsLUEzJXzqHMiREG8LG6tvic5+N4vBP9GZMw
	I4B/IYsUiF2mo/znvqjv3/7nBqjclX00Ekqk0sJ3aUyNQz4Vext546iJKKzl63DC
	aqLrCvIS3JEUMhS0OpIxE38J8F7OWEieRDPYVzlapROg1Q==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484mcr2jds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 16:19:29 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7073d7fbfe6so13099496d6.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 09:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753633168; x=1754237968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xog9pMwnTfyyxDALiAzNjbCD9BofGhoxhGYWP0UmMU8=;
        b=t9FVvRhAA0DD21Q6PD8lDlvvkXwXUVbigliz1jwMALD3Mnzst2j7tCGLXZo7yAPVKi
         kfs9sMw/smYsx3nlp56t0RL6Rq9hZ2IFhwXEnuY2TzC18LIW59q+tLW7/rUOVitz6LfN
         ss9f5Sg4xQj+cpDTiWsNNzqx/sSwCkJJO2+d7eSxpMrwWXlBTjIlv9cfjJkayl6UZ2eM
         lK6bsiDsnNo8pBaSrTxDuXxY43UE4otAtzs2SRDCRCxmPGTWCoJaJrVc4UVR4aTx2mUl
         aarBmt/uCrkAVQeIkpmoCRwtk0C8Po3CwPvMp256jRHX8t/6ZQpUZqRg3SbfPQY1UHHe
         l9fA==
X-Forwarded-Encrypted: i=1; AJvYcCUsdHJQ0D28IUZxlSmX7Z68ZoNlD/qU/oTUoGtOUipspDLGHyaD/QvFv2ufejX8oUSDRD1d3eMd9C8E9mI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjweCeSobYxx1cXyc5sDm9hkG2SWfZwiy8brBQwBuUQftmVgAl
	m5zAXnkobWtf4aUJNTSg0s8I11EpBk+nbC+MNSXoMAT+UDhAQFzglk26niVmeV7o4Cp37xgGNJ2
	br2k7xirEcOgwqFJiwakaLp31NIkoEHPCMuMUIfs2FBnZL5BR1XQWbjPlSbCx2ZqbOac=
X-Gm-Gg: ASbGncugJ1AgwxC9WJ1Ef/+C+xjX7/VUGnAVWgZFEq1uV8ZBzqO6feIjcOD4oNjroWz
	8Y2j6LzsSJhD1coylQG4288dNz2xZMFzuixAtggOEJs2sjkTNLhN85tTs2NtW8kPqjEsENkC5FX
	bjTODCPzVHt3JSRCRsQNix2d4wgFOuWl/xljX0e0NBMSfGK3Mu1kugMDmHjXYHDspcSS/jbVQ+M
	TrCfm26DMn8zfKEoU9lPpPAoCGPtmJJP2Dk9XWlCpEkEO0tkduQBhV9gRQjC+KNfrZQ2lTpsKL5
	mTmOZavqLMeBnWyMadVDNpk/Wmir4oGHJMVggblDfKeEUscuObj/Vyo95buJYpOGU5Kcay/t63g
	0UPFxlIdxiETcliA6tciQ3fEXZrbuMmi5oMKvhk9w4fXyxFECEYk9
X-Received: by 2002:a05:6214:240f:b0:707:92b:477b with SMTP id 6a1803df08f44-707205d64dfmr97744876d6.44.1753633168076;
        Sun, 27 Jul 2025 09:19:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2TnT3REp55fBcuDgbNxcPR6JFi4lJ3WbDg8RfzzK6v8g//TLZH0w+iEyl3THFdkppmKDF0Q==
X-Received: by 2002:a05:6214:240f:b0:707:92b:477b with SMTP id 6a1803df08f44-707205d64dfmr97744576d6.44.1753633167592;
        Sun, 27 Jul 2025 09:19:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-331f40a2f3esm9079341fa.34.2025.07.27.09.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 09:19:26 -0700 (PDT)
Date: Sun, 27 Jul 2025 19:19:25 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] arm64: dts: qcom: qcs615-ride: Enable WiFi/BT
 nodes
Message-ID: <vgjnrsy2x7mkgfanmyhkfdq63n5kyyll7voa5ttfekn3wqokip@4kdsaa3hqfkx>
References: <20250727-615-v7-0-2adb6233bbb9@oss.qualcomm.com>
 <20250727-615-v7-2-2adb6233bbb9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250727-615-v7-2-2adb6233bbb9@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI3MDE0NCBTYWx0ZWRfX7ptUncZ56maD
 tP2lscJBWbxr0agkthLwOqgMtJ6NQydH47Gz8BtniuOgmepUAyzAEb7F4hNVx1ef1vgkyxt6iOd
 l13JVLLls9Z15g65kPZ0T8qqRTOV/W9hfxORuzupSX5uSJS2BJZcNQCYalN12onL18dGjV9HFwj
 5+GFfLlIgmX15vZ88EGyJPOmKaFH/gzGNzifwbZOUvKgiUoW/IT0XjNUrWw9cGxdVpaLZiwDokC
 /B6RUos2nx8KkYQ6vBrOf5vKq1R9RZoMxQQx+51Dk86IRRbxts95SFQgPzqCWuZO2UNrrAbJeNB
 ASab92gQIHk8wAVbUAiXples2wKJZ2bgCA7CHK4ZDvolQpYu50JyB5lW6P+vaRj1691IG18e+UU
 M9U+nDwEaDLEvQIhWtEhKEc6MVW3dTipiucKulxhNoGwC0AXnuhhsOyJ1qsE2bG+su69n9Jb
X-Authority-Analysis: v=2.4 cv=Hth2G1TS c=1 sm=1 tr=0 ts=68865191 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=lazYHay8Bcf_2JzIvrUA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: pAb_BzY5uxNg4xmQzEGXcwzkFPZf2PcE
X-Proofpoint-ORIG-GUID: pAb_BzY5uxNg4xmQzEGXcwzkFPZf2PcE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-27_05,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=654 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507270144

On Sun, Jul 27, 2025 at 06:22:37PM +0800, Yu Zhang(Yuriy) wrote:
> Enable WiFi/BT on qcs615-ride by adding a node for the PMU module of the
> WCN6855 and assigning its LDO power outputs to the existing WiFi/BT
> module.
> 
> Signed-off-by: Yu Zhang(Yuriy) <yu.zhang@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615-ride.dts | 135 +++++++++++++++++++++++++++++++
>  1 file changed, 135 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

