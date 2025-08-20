Return-Path: <linux-kernel+bounces-776720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFA1B2D0C8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 02:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E8967B5D12
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 00:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6908A945;
	Wed, 20 Aug 2025 00:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LHsOTYVt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F2635335F
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 00:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755650947; cv=none; b=jLEVn1QqgkRUeXCf+07DcM6rJT9nnb/cSPwDvZkSzHMaRnWS/z5+hMbgF5hByA1XyCeE81R3TMl7dpxT9gRMpbMB8e8tBR5U1TbPXNeVSTnzaINYZKq2ldPuTV4XisCG1Npnvat+wQb+joG/NtEuImg6tnHfVNjE0T7CFqkh/ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755650947; c=relaxed/simple;
	bh=ifngvILoAini9peoSf3tBc8xYYKF636hlf9WsMzC8hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBmhx6xi6MFPIqQXF+CqYp3sFx+HsV7qPU7sJzXWC+LOvHe6Z62XneV/pt0r16dQ3Pc905kqeDu8D6HIaFsFVL/EVUPQjg/hw7JZAbxLmgpXnJQ4u7AnCnBL5K/UfTAiKO7l9z8VkBPtBkSyLvvw2ZqvZBhamh5wEFEcujkfAy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LHsOTYVt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JL0p3n019575
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 00:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zdGPX+sVazYZfntqn3tBRkI7w2+oZmtbp2Rt5/0C3fs=; b=LHsOTYVt5wHnufDe
	JotsIsKjFc2o1dFD1PJrJwelFm4/3qpSJEcH9kZNhO9aagvB7ka7xjPB68uTmTxk
	/LdeMTHAKCbzXDb4fgfrMAcYYilXteAzEVWSWrC41uV8FFkoGg271d009EKeaaJh
	1MlwJNMNDzwQelu3BgMHnn6oZL4zG4BTNsRFwE8UtRVJQN3nCnHKW9/YbMELWq3X
	ezZg480q9vU51xvbteNOAnR9NdKBXY1RzpuDVhmhnjyNVYjpY4290rZO3CuIBX7V
	9uvrrhXbSqjKi7XCIaxn/vuvQauYpPieg/6pdX2ojSkRzrikiWD/Dd62BjyaqNlx
	MXz7Bg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n0tggdda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 00:49:04 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70a928dc378so140571476d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 17:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755650944; x=1756255744;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zdGPX+sVazYZfntqn3tBRkI7w2+oZmtbp2Rt5/0C3fs=;
        b=RjywYBh2+m42nb1K3HlK7mP9gAIblYOUfVxqeB0YlaWKSBeRrkcBlKX83le8Fkcu5a
         zhr4Sotc3+A3dCBGsANpf5Xf5xIyhgEFD7quc6ZZQazzJlMvzbP2whi1xgYzrMdDOogH
         1acpR45ZgKgs4o+zrBReNZI8YyQaZvh5EWtw+cFnnTBmLDWs7D1XCU2LC246vWJUlrLp
         12h8gCVyrzNswzcCWF0UL9utGnVhSxsihk5Kl8w6iyk9ZZ2jMxrqqg5kTMCQzwX7NcVu
         +NAcf33LzXSGdxLidsA2F20RT4IajPrr5DAtYzU0ppvlaBx/au49uwi6KrHavxfHxtDY
         WFFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDiPXiMB547nQ8KcMLEQ7FWmiBAUhJoT0jGhzPpQHHAGIWXvN4RigIjUqwMyAXB9/bGvv+7AdJB3LUua4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxic1bsCxlVztqtFKQo+p+ctJON3QWLLWaYKMRz73J52yod8gC
	363662VZUXlJAuzWT9MwHxY+/fLH6X7RFBPyot+d6W/uP1wnBMVEaKTJ6TANkCzS9yfcIcFP5KT
	GxLg703fs2qw26ny41iD5yeCSYcTH3gqkxVjHqkmwDg+Gzlemd863Wl5NVBeqgj7YFcA=
X-Gm-Gg: ASbGnctS7rkNaCXITvLUotMLjWJ4PQKOJpqjpqfKMcZ6TeWCFDacTHlAoJFF58y0aOn
	TjDeGOQGfQpXIsbXPkCk12LLAOgQ1ZHMDTWfWTBe824uSLthVcSjMTRpsys3pUSDeVtEsIT5UuD
	F9KmPeoQ+H6RU9Ye5tBsbo0AzDVrxi9OiibXWOM4MPUAoxPnJmCboHm0TTkGf7A/TPXRdl9+Sxz
	4Cr+kD8PFkK9X+6kdTJsb2r8ugQgr+t+vVMNMl+UxV91GMkquVrhl/sjEUtNzMl4gVsAHvEHMHs
	uRjsicNOonyn3H4RsXm0zzJLLUwtjDBftfkN83q3FfMyDW4h+aYKCi1e6cIjCkrA6RCo/6Hn5BA
	Dk81H4pXo5mnznGBCTFBMcO9lYbN+BalV/UarD8Wq8na3tB7phhaT
X-Received: by 2002:a05:6214:e69:b0:70a:3792:71b3 with SMTP id 6a1803df08f44-70d76f870a8mr12484576d6.8.1755650943711;
        Tue, 19 Aug 2025 17:49:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0VWxTGtLD5PU9po310OhKUtTjJ+Hk9q5X6gOfFD31dOrRi5WEbsKp8p0ifOTHNuzOWmOY6w==
X-Received: by 2002:a05:6214:e69:b0:70a:3792:71b3 with SMTP id 6a1803df08f44-70d76f870a8mr12484456d6.8.1755650943315;
        Tue, 19 Aug 2025 17:49:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a62638asm24966551fa.58.2025.08.19.17.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 17:49:01 -0700 (PDT)
Date: Wed, 20 Aug 2025 03:48:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nitin Rawat <quic_nitirawa@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, mani@kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/2] phy: qcom-qmp-ufs: Add regulator load voting for
 UFS QMP PHY
Message-ID: <agsqq6fwrj5paejfaefgtcz57gnxwni3l3plxpslcxdhzshuda@lypqqueqcfkd>
References: <20250819222832.8471-1-quic_nitirawa@quicinc.com>
 <20250819222832.8471-2-quic_nitirawa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250819222832.8471-2-quic_nitirawa@quicinc.com>
X-Proofpoint-GUID: Lnrkvk88AXTAYVOZoctnrcMejPCJewYf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NiBTYWx0ZWRfXz2TCPZGZb4K+
 nIfLtbpkFZGt+7FEago0HWgHi5nKI6nY7zCFj1Hy4m0b0GfpVUXBSTWBVZoSKp7nj5PrRRSoHIq
 EGW4S1v+9hvaAAoRe0jLsp7O7MDWFsMm8B906KYIv0BoUJhfae9HHlNvQkRFpgkbKIYYYLMoKqC
 N62JmNA4MCdOfmk7r7rrAduoGJjja39X/N2sa5JwExNNF2874YQSl7VGSlYOtI49vcmMq4EkN2m
 DU72HNxvaKo/YttxOSEp+qmQgTjqJzIUxKV5gN67EevjExgvShfsF3FFg+vpZYNAkFZ6KDA8ieh
 LIA6Y9U7lbVCL8QNt/GSnNS31I97RHtsD/0KZNif8JpHwbTf7h2ZeA/1CmkX4ZP5ggmT8ie4Jzd
 FrjFaqLzYGSbQHTfjAzm4XIbw/JOAg==
X-Proofpoint-ORIG-GUID: Lnrkvk88AXTAYVOZoctnrcMejPCJewYf
X-Authority-Analysis: v=2.4 cv=a7hpNUSF c=1 sm=1 tr=0 ts=68a51b80 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=oWWDGgvsAfvsrky3NdgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190196

On Wed, Aug 20, 2025 at 03:58:25AM +0530, Nitin Rawat wrote:
> On certain SoCs, power regulators are shared between the QMP UFS PHY
> and other IP blocks. To ensure proper operation, the regulator
> framework must be informed of the UFS PHY's load requirements.
> This is essential because the regulator's operating mode—whether Low
> Power or High Power—depends on the maximum expected load at any given
> time, which the regulator driver needs to manage accordingly.
> 
> To support this, replace devm_regulator_bulk_get() with
> devm_regulator_bulk_get_const() and inline the qmp_ufs_vreg_init()
> function. additionally replace the array of regulator names with a
> bulk regulator data structure, and utilize the init_load_uA field
> provided by the regulator framework. This ensures that
> regulator_set_load() is automatically invoked before the
> first enable operation.
> 
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 29 +++++++------------------
>  1 file changed, 8 insertions(+), 21 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

