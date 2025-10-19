Return-Path: <linux-kernel+bounces-859789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF15DBEE985
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 18:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C5124E037A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 16:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05ED2EC0A0;
	Sun, 19 Oct 2025 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A60wrfVL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898502EBB9C
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760889753; cv=none; b=iF5+S9MR24uArRx4oKNzl/TmsbhEjSuhX8F129uXMkfdSRoq2wre8Plp9uPpijWZR1h6vU7w/YCVbMjtlZTIPtQk5OXBhdsM5A6VZt9V253+X+UkNZSNbz2dYQWk8nK7VduT02c/VPfCY3EAhG4tSN+a6BHvbmUSwpT3HgllQ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760889753; c=relaxed/simple;
	bh=+xf9X2P4LBJXHBq+W5F0WMYPtUAcqU/5yUdWFR8RWg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8vIIxWyi5AqAojSUjhOgyTR8eYnVGbDu99q87/MngPRcxPD/nKewONmvy+KpxRKOFCweMukZCZNdFUDuj2KmREd/rI6fsuq7VR28zUUpGYrtJmMnBV1z/aL017mFiMidv/VYVH4nDfsRFynIfrmNU9hQv41i7y+JTchj/M4O9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A60wrfVL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59J8PqjZ022238
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 16:02:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yrSgxSLSjug2hqzstf5hGIeQ
	dvScIsYA26L3fjhfwUQ=; b=A60wrfVL9zZXiJo1IpYz5nSiXDhJggSOBHOpZkcc
	tlEyseTYqS/ksvdbaDIM4xqXhH0AI8SNEg5poSQa6MnO0U3gkv0/wHZ+LW401cjl
	TbpqwHrALb3oAEU3qn8lDhxRWU6UjE4aA0EP7S7HhCQ95vm0ShrjGSygZnkV8DfV
	u/1b75DmFFnSSN7r4zNkl5rIOQexFxo47+aLiFttYBRZrGcB7lugIdY6BdlEwmIm
	LVu9DQpsYbPjUFdm8qtASQ8ptQKYjFfAIVun/PdmA3OcU46mVZNAH6SlHqa/kAyy
	xkh0MQo9VfIfM5eqvPM/87ayI4rlCiexYTCfrN7WlcCNqQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27htpj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 16:02:30 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-932cb539eceso352987241.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 09:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760889749; x=1761494549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrSgxSLSjug2hqzstf5hGIeQdvScIsYA26L3fjhfwUQ=;
        b=oD07Kfski+uXwkAkZLeJJwapdi9ygyWjra2iz5tDboTOjbQ/wshpMMi8y1Y+YJt3ho
         +w4R+L7Lm9Z65X//iWNu+KPF19nSQhczelC1cpdhryKU0fe05IrR6Orn/kP98YoFMQAW
         jDp4trT+KCUiHVkpf5oJ8XtAEIZjoAtW2bQXleXTzq6N/tJV7y20HCCXIAOzXLEIwx1u
         4oABdsusSUHE9dFbGCs64TL3xy9R1CG1JRvxbVsdh5mI4jWQa2rNz1eIcHYNYCCcxK+n
         DO6atoDTw0pZYSGmFkqwH5oghKmWi+PI3BSCeo3COZg1ZfdU1yEinaEBXFF2L9SSYvKq
         pQkg==
X-Forwarded-Encrypted: i=1; AJvYcCVzOFa/iLE27WbfqJFEDPbuNmPYsB5DsooWCRxChzVJgXzrAhCN6T0aL9qkB87pFrLIygKBB8Wry7EDaRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf4LyEFTECmHeO0K9pSHREnnwjF7JFGfoeq+5RLgA8Ue+tB8Go
	KpOVTq76lg2sChb1u58+w9TKEijeSB/YLuBHoLPl26uTI2tPRvyYWAZcvJLwCy5hn1+z2LN8fzI
	NJ3y/MywxVjWv+WxOTJz9RKfsaMOUZt6cGVqpllQ06V83D5tdLVXd2JsY1XhDZsl5Mmw=
X-Gm-Gg: ASbGncsUYAFABybjaCswZhex9hk+tkfWtz6ircP2kdmPccBO0k25Td3Wkml6epSeD8C
	b/UwBFD+nB9Gt2ga3tdHeK9YOXufZA94CXY406sbXIJIpOzZHNVKpIpJl8nL7jqsX6m36etRJam
	PuAfD3/UWih2tOyfMLHs94k8D7UQMaDeIT+ud6/nL5CidGS0JtRZ81EgzK3zmmWH2hjbx4ovs0A
	s+ONhy/mGJt9/vPnjFWbd7m1OiCp+Gmzb/t3g9vaVFFNlk3EMhRdh0hcCjS2xvuXjq5EuJStxNX
	3Pyr3Zyt+ZJamSh58E+cOsb4BChM/IUqeHh7yAHqrj+mblap6nBDIlD4jr5sjiqpeEToCCL/FZN
	zFSPXcvjD4nFMYVEATkQL0ybgELaOqp8YAcLAhq9tObzecr24gpbom2Pf8ch/I3z0y/XAZbH1FF
	DWRi4FO/tN8pw=
X-Received: by 2002:a05:6122:3d05:b0:54a:8cfe:193e with SMTP id 71dfb90a1353d-5564ee5fc31mr2779091e0c.5.1760889749460;
        Sun, 19 Oct 2025 09:02:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX12e9u2jTwAw/ohWphMrO/Z/+CwpFfiWoBiRqZoykAWDjj50XtmQqV9+4tCn2aAkVSr9v8A==
X-Received: by 2002:a05:6122:3d05:b0:54a:8cfe:193e with SMTP id 71dfb90a1353d-5564ee5fc31mr2779046e0c.5.1760889748963;
        Sun, 19 Oct 2025 09:02:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377a9578a51sm14051151fa.42.2025.10.19.09.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 09:02:27 -0700 (PDT)
Date: Sun, 19 Oct 2025 19:02:25 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: xiangxu.yin@oss.qualcomm.com
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com
Subject: Re: [PATCH v4 2/3] arm64: dts: qcom: Add DisplayPort and QMP USB3DP
 PHY for SM6150
Message-ID: <aruuyvtzi2notuxdoi6mk45y3zybu7dpttpteqrektszkhh4hw@uipxhhy5nar4>
References: <20251015-add-displayport-support-to-qcs615-devicetree-v4-0-aa2cb8470e9d@oss.qualcomm.com>
 <20251015-add-displayport-support-to-qcs615-devicetree-v4-2-aa2cb8470e9d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-add-displayport-support-to-qcs615-devicetree-v4-2-aa2cb8470e9d@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfX/XrQvZk5titx
 EnSuA682t2cHE9SEUl5Yvo5K3h3J5vIC44IkPTZsyBTe6jWnASVFJYfd05I8uB5O3DtW8ZtkvWD
 eEIwlHh6qbeLEV2VYZWyxRkWNdWKS10wyZRLbxJwWGl0uV0LZ3rrQn7TsNc88r4lVeKaTXIw5ov
 w00ajR2ur07h/+J6yXt3yKhLpxV8VAFkS/tDGTYjBCAhJBe4jF0oAw0pk3QoiNzG/SxH7QtH5Dd
 96lXyX6LHjfFiRsFG7WVyMog3H5ddkr8cnD7nIZSyk0Aypd6OJfekHYjQxfuzOewI0dXam71a83
 YiUTuKkLfZ6E+9NXsYH1yyk37rXlm7xMbK7DnnHQvOm7tRZn4cpGiPNR0W0+vsU0yGiVSAC3mVm
 OxALyRLM6hB+HvWj9ca5KgeyYObdRQ==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68f50b96 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=jqVs4JzIjkIIVyEy1LMA:9 a=CjuIK1q_8ugA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: aQhPOyhwhClAjGcN3fYScbinTzNJVz_n
X-Proofpoint-ORIG-GUID: aQhPOyhwhClAjGcN3fYScbinTzNJVz_n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-19_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018

On Wed, Oct 15, 2025 at 09:53:19AM +0800, Xiangxu Yin via B4 Relay wrote:
> From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> 
> Introduce DisplayPort controller node and associated QMP USB3-DP PHY
> for SM6150 SoC. Add data-lanes property to the DP endpoint and update
> clock assignments for proper DP integration.
> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sm6150.dtsi | 113 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 111 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

