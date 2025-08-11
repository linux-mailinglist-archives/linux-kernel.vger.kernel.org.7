Return-Path: <linux-kernel+bounces-762896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD5BB20BF0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0491165797
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3220021930A;
	Mon, 11 Aug 2025 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WQXVCN+x"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D5E255F33
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754922517; cv=none; b=PnXCCypTUkDWE61reAubXhFvzkxR2VcudicResOeUfbsY5nME6Wu/rcxSHsMegtMUp8btJm54A1RcJIi1bsvcI5ihvx/ND24g/feJ9BdWqzGLedz3NKBp0Z5LKUDBMti1AOJ9lfRvYA4forjfLiF5yhTwDp+3zzPhzNcr9NVXUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754922517; c=relaxed/simple;
	bh=BF2o0J4X4dNDWLPmAfaZ4g7ss5WP8AJTmouy9JzbXbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPYuLcN1go6WpJL73FIZhfjq0MPUKdRRdJJ5iLqCjCHOztY1PTCoPkhWGfRT6HxEUNgEW7t8gXPTTyOYk1N6/BxmlcDep+UXsghBF33tJAUyoI8eKEUMsFoMzO9uAYhD7Mf6xYIrBCRlMfaMIfCbdfQ+sfDwt6tw1l1SYGOsGlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WQXVCN+x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9d9Jt007563
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8otk79pR7SX3xFs7QNxJWm0WRrWf5HdOaBbrijkB5Yc=; b=WQXVCN+xwBKDUAoN
	j9P4Ovg5Fs1XYYB+yBwIMqBBm+ynckIuOKQHfYwG042m9z0MOS6ngTNkczRYMDEM
	yHHrSSJXaj+GYOf85cRfpzRzASiG2SB08D4Fjp0nvp5PVLGgO8Sgl0NCfTJt59k4
	tu3ZHDNp5Jdy/lvsujRjHzQekqaLbvuBxsCXwhMyduCdWVyY8IIUx3VOAlhtSPUE
	UVkl9ClhMyjjiI5P9tYJKZuX+sBnCBa7Vv+xqItfHbViuIqEKi0mzjAuX3c83dSV
	j1XvXWA9tKYJ/+ojiFxb9t4Ar7v/HlKMT9iAE9rZHgRfshlzUKxdOdSvoKPGg36S
	tOh1Fg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dv1fmxw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:28:33 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4af199d0facso139722231cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754922512; x=1755527312;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8otk79pR7SX3xFs7QNxJWm0WRrWf5HdOaBbrijkB5Yc=;
        b=iD4HwrTS0ag/vfU89v1y7okkh7TgMTpPlsP9v7Fxc1z2dO9rOgPYpCVCcaCJiWktyV
         OmmoOxnQaCu8SXH7alTvOSlPXLK2Mb5NsN6+ta6UW5R2EMpqe+Y/14TzhgxTOAKQpPCN
         nKWVzqsWrjAoDYBRahp66L25bQ/Mf6AHmw9VGFkbRetf6Xt5Dd2J0DVptVH0PHAiCbYt
         5oAvcZdSavGh2ELECjWM2ah6ia3r4OY83nHP4+PNrqRXv6HNAChlD6x76NScujfbMN9u
         u1vuY4J/tFpciTvwqyxbrvThVn5t2u0nZbllJl+qwNJtc3KgVaosKtdt9B7Yt8eT/io2
         yx5w==
X-Forwarded-Encrypted: i=1; AJvYcCV1i2ln0Rpxl03UALg20x2yUmfMrA5NJL9SQx/peMr6bFp1AZk3DrAxXcsCp3oqysVMFarbW442H69rEGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyYEBiVllFIAba+BVGule0E6rvSpMyaiOZl36n+zW5uCrDL3rU
	RE7rAKT3YDYeWQr8f9X0YSIjkYVCT0QHuURF9H6QrXk/MoFMIzrGzSbUK3PEfg4r9484OZd3aby
	msk1En5W7WUA5Qc9egAVgmo3EK6UIFZOm+l/fWdtMLhRun0m3TzSRU8L6GVez61AsbT8=
X-Gm-Gg: ASbGncvQ8G+sxe+0z5Gg3ptOIRXD2cOAwVANVgYgHaQNSn7505YNvvVwJ0ZFGcvQ7Z4
	xrlvf/iWa0mcJaYVMxjo7JVqfi4dHqdSO2bag4yCLLp7MS6N8dMry6kYxMv4W+/J2gOc77BE7KF
	9/d+QdEbkUP5QwCySO1u4gsnZzdO4ymUwZZtJ8CUIdWUW3gVeLR0GwjzQydBotwo770N8NvKlDK
	ome10GI/u5xEKN6U30yMtgZ81dtQ4/rW9VYVcl/qaXA4+/YxNfzL0UfLyBWr3oXusHVzn34Rm67
	8B2rhOzezb9nN8+GwjPlnRC5oeL1OpKh5zlJonBJVLprVfWY8lAReH2hQvs/J75tNsM8L2WOPPv
	5IxUAKx88cns34wXsfsOVUGsIKDRb3dZEXV29nwnpQqIAXtI2H2gw
X-Received: by 2002:a05:622a:49:b0:4b0:66a3:f130 with SMTP id d75a77b69052e-4b0ec2bf18dmr871661cf.11.1754922512401;
        Mon, 11 Aug 2025 07:28:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfTZBcEJUyG8F52ssE1g5amBQt/le8ogJrgC3XhWx7A+L1MHHysrn3sNgcMm4fUuwp+wBFsQ==
X-Received: by 2002:a05:622a:49:b0:4b0:66a3:f130 with SMTP id d75a77b69052e-4b0ec2bf18dmr870901cf.11.1754922511734;
        Mon, 11 Aug 2025 07:28:31 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cc6bf7fdesm1263782e87.137.2025.08.11.07.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:28:30 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:28:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nikita Travkin <nikita@trvn.ru>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Describe on-SoC USB-adjacent
 data paths
Message-ID: <hjey4kizoizskf3cdcfko2jao2zd3aqpobk35hxsepxqy57p77@jzmldv5ieu3o>
References: <20250808-topic-7180_qmpphy_ports-v1-1-718d7c52921a@oss.qualcomm.com>
 <7bptwqmqimkuixgo3zvwfafktx7sj6a5xzfcedip6vuudhwmqt@ey7cs7x2ucxr>
 <4478d71458f7ae1501de6cc1a65e98e3@trvn.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4478d71458f7ae1501de6cc1a65e98e3@trvn.ru>
X-Proofpoint-GUID: SQDQ9_LBbQbkfBfQrneFxGAOVa3DGQyz
X-Authority-Analysis: v=2.4 cv=cLTgskeN c=1 sm=1 tr=0 ts=6899fe12 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=mP_-9QhUD8djvHu1yBcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAwMyBTYWx0ZWRfXxeMIJC+oBRvi
 0qppRPlD5hNoyMP9DakTOmNcZ23Y1Xfn7hKF5ou32DAspbd1SvH90EdPRQjfwXG1DUGAGv1bT0O
 MBZO8+CosQvxH7GZtsqT+EgXj4wzTcXM2Ur7ZH9TkU605vCW7hhUs8HWpMr1RV9eQC1f4EA4swN
 mz046OconQNVDGO7LHR0743iJVB4ayF17byT5YteL1uqAhIpitw0sFFxuotNb9/mcJ26VQSmPYl
 kRxbs+Z9vPU3g2gWT8PQtJJlH68chsLOrGpqiZJSiUEEty7e9kYVhwzj/1Frmptyb9Dla/M1qib
 oz5rR4IhB3n/LtVVT49cd15Is/z/GmW9HCg/UdywHEq96B3AbQxvVILcRWZyG3v/uWm6IPeiaF7
 b0jBUSh0
X-Proofpoint-ORIG-GUID: SQDQ9_LBbQbkfBfQrneFxGAOVa3DGQyz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_03,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090003

On Sat, Aug 09, 2025 at 02:43:47PM +0500, Nikita Travkin wrote:
> Dmitry Baryshkov писал(а) 09.08.2025 12:49:
> > On Fri, Aug 08, 2025 at 11:20:45AM +0200, Konrad Dybcio wrote:
> >> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> >> 
> >> Define ports {} for the DWC controller & the QMPPHY and connect them
> >> together for the SS lanes.
> >> 
> >> Leave the DP endpoint unconnected for now, as both Aspire 1 and the
> >> Chromebooks (unmerged, see [1]) seem to have a non-trivial topology.
> > 
> > If I remember correctly, on SC7180 the DP is still routed through USB+DP
> > combo PHY rather than having a separate output. I'd let Nikita to
> > comment though.
> 
> Per my understanding SC7180 has only one DP connected via SS+DP combophy
> (At least this is the only thing that is exposed by the QSIP module)
> 
> On Aspire 1 the SoC USB0 is hard-wired like so:
> 
>   sc7180        USB3 Hub             Type-C DP Switch
> --------+     +---------------+    +-----------------+
>  SS_TX0 | --> | SS_TX   P1_TX | -> | SS Tx           |
>  SS_RX0 | --> | SS_RX   P1_RX | -> | SS Rx     Out   |
>         |     +---------------+    |        (4lanes) | ==> [Type-C]
>         |                          |                 |
>  SS_TX1 | -----------------------> | DP Mux ML1      |
>  SS_RX1 | -----------------------> | DP Mux ML0      |
> --------+                          +-----------------+
> 
> So, basically, the SoC combphy is assumed to do 2+2 DP alt mode in
> primary orientation, and the actual orientation switching is done
> by a separate DP mux/switch (Represented under EC in Aspire 1, there are
> multiple chips roughly governed by EC that make it tick)
> 
> Currently this is represented by merely connecting the MDSS DP to
> the EC node directly (to represent the link between TX/RX1 and Switch)
> where the EC node implements a bridge injecting the HPD signal, which
> I assume worked out because the combphy driver so far just hardocded
> the correct 2+2 config by default.
> 
> However if we want to rope in combphy into this (which I guess we want
> to actually configure combphy and not assume it works), we'd want to
> connect mdss to combphy and combphy to EC at least in Aspire 1 case.

Yes, please (especially as you have hardware to test). I'd really prefer
to have DP being connected to the combo PHY (as all other platforms do)
and then we can manually /delete-property/ orientation-switch inside
boards's DT (as it is not being used for switching).

We have a way to describe onboard HUB connections (see the second USB-C
connector on C630).

-- 
With best wishes
Dmitry

