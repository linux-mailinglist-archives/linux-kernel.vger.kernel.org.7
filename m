Return-Path: <linux-kernel+bounces-749295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF35AB14C7C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 116C03B5FDE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B0028AB10;
	Tue, 29 Jul 2025 10:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lnTD/atV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFA481749
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 10:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753786105; cv=none; b=pcUPWXG2fCWFSRj2o1i0yAVFl4+VOWFFR1JTWhYXGF7DpijpE+o5IpZicTy3BaQpt88c55Z8NKSF17u+nK0njvANum9vn9gQ5luSbxbUSFX2Bd0evi04YmfA+wuFusbViX3kU3550rnWzEusk+dRq/fLxEUoG1kQEYZ1cPxv/kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753786105; c=relaxed/simple;
	bh=hKHbjjoJ+iGtckzDyicYvICv0iTNTrl7TsrUzNgpKaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9DeMzKGCm98f/GpDkHDVZ56B8JRAL5AmbxgXEcgjJpxnfI97CWmaevDUcaagrBDXnwN9MejGngmGka2efqF95ZciVRiitf4jepaP9KabJ2YZHFExzh5AI6qMt2FBQo2J1cK1otSVxZmjdjJitK1pxn68znSJCOcjkBpSU9sFHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lnTD/atV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T9GMur004936
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 10:48:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aIZodOZfSRc4bXLg5h+oXoOK
	Sy3LJLxbr/aCH937D3k=; b=lnTD/atVx4T4mnTggzkJ16I9SaQKJuhYu++ApJLv
	WcR078znfxHSYM09lIWgW3PCeNT/z3NLxt5Z+saZ3ITy9xrU/4vlXgklzHuZD5hQ
	tPGFNMkae5h8UbvrTOarKQRvH/XM6d2754gZKlmATH9c0hyG+fdLJAVLKt5jWOCH
	tam/MyEDe9todFmT7M0xdCjz0pYKDXGYOXJj2qV3mAhJhg/oq27PpgRuITyf/mH2
	aDpq1hRTNoHGDn/kskCIckJKWYgYhPVIDqLLdgWxgFopjbzPB3D6cUmv3irUXwCp
	TBlUqG+fJfIYtBJFTUUM2SCtX3V1TWSEWa5wCH/Zcoq6MA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484mcr7yhn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 10:48:21 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7072ed70a37so68566386d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 03:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753786100; x=1754390900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIZodOZfSRc4bXLg5h+oXoOKSy3LJLxbr/aCH937D3k=;
        b=LjvwFOabS/paqwLbxdEaEl7uHwa9nmKWv7DdIKKyqBKkFMcdC6AmYlni/ErbISQ4Hm
         uxwRf2yDKsHqVWh1U+bVEJCoxiBtLLHN5MfzvL7sqdfebf5hZoZL+r0t/Y7Z7CBfLYbC
         vcyOvz04uAZbGAsVt+WxvmCM8Oq5fh8A5y4CvKb5vmxb8lMFtIfVIrjT6tUC15LBHhPs
         eGSoXyx5+2/h1Injk/z3NgZ6oeJ1AMC8Kb1MNyU3nGAt3JhKxEA0J2C2ReNIqHhMHdz8
         mjHsOHUthN6K+6Ktc87sBsdtCRV9Sqe7PoaOC8AhBFmQyT9xVErXK1JcWQhMqXijCcQG
         h2Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVTq23Ga/KH5eWXWOS5Zco/KVhpPrCdgdggUEan7KkJ45gBlYW4SzIBF7oI2Xy3yxB5niK1/c8MXvQI9oE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLL6soXXuamexTMlqLSErobIqRg/Oau0BSyxgSy28V8UB5QnlU
	S6DN/NuLQIXBIq9P4iXWHbtrs20GUo+BpJXtZjZkS792BYBiQNtecUHWyyV211+9NQ8dVen2hZR
	+etyXJhEwAfKYHx3SEHjga5X9QpR63WssF17bqdDLBqWe6ZY3fSElIQ/4eIC88xQnfGM=
X-Gm-Gg: ASbGnctu77Ur1h1TAxpm/0MPPeM6oGngaRTLq2x4HmqjhEGYxDwjpov2t/d73Tk+50w
	tgFcIvbH8oI6S5mpt1ffXeM3GIkTG/fLapr1BNZS/RfM9o3L224si5IkwcmSIuzpelpcHbu3TEY
	tBrN6QhY1InRLK9uT7KYNJ1Dtf9Eh8XXtq5ULe/kEXq16L7fBtJUFfxJDPSTpk3OjYsijsX9O02
	I8E+PuJ9EeTYb901GWaJuAkOUWFpHBNtfcLYREP9ES8doflIyrJcOiUSD+0htM/wgj9GErL/g6k
	Oq12eIiVXJuTQU8VbKbVgubqXFAPpP3RR0wRo1fZVHWoAjmiMM/AtlwlF5UOmfA0QEMt25eFLA6
	2ZtLOtaYhZbNsUNchySLGWrGgV+NILBjMMjjOEKyAATWNW4fT33zo
X-Received: by 2002:a05:6214:1cc9:b0:707:1a5a:71c3 with SMTP id 6a1803df08f44-707206fcfcdmr237668416d6.16.1753786100351;
        Tue, 29 Jul 2025 03:48:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFddgyjGv1hFw/a867iR4nqNHV4MwlsaV9ZbCgAmOWAOWVeaSDHwt5F9kad21ptJ0V3bBzeWQ==
X-Received: by 2002:a05:6214:1cc9:b0:707:1a5a:71c3 with SMTP id 6a1803df08f44-707206fcfcdmr237667936d6.16.1753786099873;
        Tue, 29 Jul 2025 03:48:19 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-331f423597bsm15621391fa.44.2025.07.29.03.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 03:48:18 -0700 (PDT)
Date: Tue, 29 Jul 2025 13:48:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Taniya Das <taniya.das@oss.qualcomm.com>
Cc: kernel@oss.qualcomm.com, Pankaj Patil <quic_pankpati@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] clk: qcom: gcc: Add support for Global Clock
 Controller
Message-ID: <25uelsjuw4xxfopvfn4wvlj2zgivwbjprm74if5ddwvht4ibfz@yctc2kvfmxyw>
References: <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-0-227cfe5c8ef4@oss.qualcomm.com>
 <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-7-227cfe5c8ef4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-7-227cfe5c8ef4@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDA4NCBTYWx0ZWRfX4UYs/hs5fp6e
 +ozGre/74c9+KynDvzvaCjP4xu8AbVXimX950WSIlq0gSptqt4CYLZ7a1HqIDNqKc0qVDkRgoGN
 T97glY6yYiZ1CySXZFNm97MLYS0t5Dd+8BVHSwxL7OCB3Qa8ac1uSFyHQXU0umnOJVKhghjI0wx
 QURrNVqz5Be3SiMm//Jv96+4Z7Jv1y69tsflvqgjCYvcFnlg8kkDhuI/HmpaN9+OBxjQCPxaCom
 DxwGaacG/MJMkIxU0uwuQ7F+gWoH+z21kxwWCrmhjF95/9JNEUCWt18TZk13F1nID8es3LZzrFo
 iaUWH6ZzPnIMc2FsT/OuyTfiWhPCZ1X3U0oehd+4dT2dbNfcBqc+Mp4ifzSITNP6f3tqX+tBNWn
 QcFIwCoUf1Tr4fSEsxoOB/Admu8HAO8ezITRWnqpeZ+3CDrDDQRXRrQuwvzJSmfW5BVvhA22
X-Authority-Analysis: v=2.4 cv=Hth2G1TS c=1 sm=1 tr=0 ts=6888a6f5 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=QLzzLPEayNjuskPGAjcA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: VeNDBdXNkW2bw04I2WXWyL54U-uULoFC
X-Proofpoint-ORIG-GUID: VeNDBdXNkW2bw04I2WXWyL54U-uULoFC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_02,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290084

On Tue, Jul 29, 2025 at 11:12:41AM +0530, Taniya Das wrote:
> Add support for Global clock controller for Glymur platform.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/Kconfig      |    9 +
>  drivers/clk/qcom/Makefile     |    1 +
>  drivers/clk/qcom/gcc-glymur.c | 8623 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 8633 insertions(+)
> 
> +static void clk_glymur_regs_configure(struct device *dev, struct regmap *regmap)
> +{
> +	int ret;
> +
> +	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks,
> +				       ARRAY_SIZE(gcc_dfs_clocks));

Why are you doing this manually instead of using
qcom_cc_driver_data.dfs_rcgs ?

> +	if (ret) {
> +		dev_err(dev, "Failed to register DFS\n");
> +		return;
> +	}
> +
> +	/* FORCE_MEM_CORE_ON for ufs phy ice core clocks */
> +	qcom_branch_set_force_mem_core(regmap, gcc_ufs_phy_ice_core_clk, true);
> +}
> +
> 

-- 
With best wishes
Dmitry

