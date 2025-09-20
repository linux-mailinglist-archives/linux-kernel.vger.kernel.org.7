Return-Path: <linux-kernel+bounces-825884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EE0B8D0AC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 22:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFE603A9C09
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 20:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BF529B8E8;
	Sat, 20 Sep 2025 20:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c5IxZxg8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A7722069E
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 20:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758399377; cv=none; b=dw2GS7PJuHlu5B0l4t6hIHwoWMElLwwLh3/ita/rFNLorM+fJx/FdQEXQbo8z63PVzDHJRQcpnhey+xNdExCoyAkolKHrvlUxAaJ9WzCIS6rur3GDIEk7GrLE0zWvWE5H6mbfQRSEYGjc3wBfXZDKxY/twKS/gChT7yg3Jb5rIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758399377; c=relaxed/simple;
	bh=9gSaNjRAqWsnV7A8tQ05dx4a1z3WSXwsKDdQMoFHyAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiyzhwX9fH9JuT/IgWciV5aGaYbr6UlMrFnT1RlUJIKAO29vJG1WgjuSVcKfBMm8iJR3wLAlmKtZrzDu6fNJa1+mK96lAmEE72s2fnIWBYABxHJHemSPofjQV3iWSwcsHyaUCWhMH0GcdPclTD70kQFCbMYL1AZx5ZpYSeRFGHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c5IxZxg8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58KCI8g9028908
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 20:16:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9cQlld5QxJYmLD6/7vCxaduv5uU03r8crSu4d602Xac=; b=c5IxZxg8m9ENpNzR
	qP7u61oMfOCl1K+twklJFtIwPFO2+4h/G3nrOfa9oTaTJ3JZO28gtUNFND+VVGqm
	E8+SKUL+eDMzZEcusSfDQr97zUHy7s0FYMX7reJqWYoDgaD8Be6ppo6AaBVumT3X
	ibNpIcZ4/ZFiVMMlmBOzM7+zGRCmYrl53L6PUCmdZgEoZZIwC8LOj5qc1VsqyTvr
	e0lusF+sEs9aGDFV/8Y7hgtMs0yf1X0LoANzUCWlH9jVKVrnHLF3OWO0XfPkN7V/
	NsofbkRjpntSOp7SeYEy0xHs9DPKf5ImgtLL7Rz9sFLJ2EOkSN1Z4PgUS2qlOz/W
	jnHmNg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499mbv1880-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 20:16:14 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4bf85835856so59070581cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 13:16:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758399374; x=1759004174;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9cQlld5QxJYmLD6/7vCxaduv5uU03r8crSu4d602Xac=;
        b=dO3ay0GDU83bQtGFkFgZhrxnyTAPEhf7Wq/xFmDfLI5+wRDdrwrvapfFZdoqB+ZOgy
         hRvy5Tl/VH1eqWQQbtY6vP5jkg+xfLM8jm8kdshhLPukHtYjsDV30/IHFv+wlDQql/vK
         0KwgM6mLLR04EVROiQNzcfHkk9+ssMzmcDy60ZTm3DX6pPiR2vkAlMhrEeyrEXpFylyi
         UpG53kqwbQVWSZPy72/Ad2GnnOnOdJsEexDWdhHV8HVSpQcd0oT1t68KdotuQyQNlSjt
         2zhCva0gu0rroKOBAH0Wf4f5fQCZ/Y5yli8ZgjVzz+aR6lU4Y+vPBBMMkaT3pyQ4NY+v
         /kXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSZDFcye+dzBbiw2wdnL4Hqg2iA1rr4idk+ChfOBbRWNLiKJzgTasGNxDwn9lXMxq0lKzcoUy6gnj5duA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyT5ZnBgU6G7DPtyqeQ0DOYKhscHVjQ+NWAbx2q8bHTSkdbw7O
	qcLhdPgR7pTpK2NCEJWWhuSH0LSWD0s6pU1xbKQ13ZxpkqTPML2h3Ka9QCOB895C++0vbqcUs7A
	bFJt5QNq0xLp22pJcytMJUufD82Mgj/YbuqdrpZiWO+Q0gLhgbq6g5kxWHT9PNDz1rZU=
X-Gm-Gg: ASbGncv8ah3X9mm4m5EhVa3YVb+5bUvnKpnanImNQWJwd3Nhj5fk9WYwIzhu6ji5uek
	roQfYzN9/xMfM+VXVsm+HmUSQ9+CMMxzohQNWH8dv438oQwZCf/aK/DssjIH3hz6gDJOBYfNZIf
	QX19GAC58qjUk5AechNCQpT/ssuGgHQ3ssycymp2aZyG2dErzkplKyJWi8mRYa2qAAHe3IXg4Ro
	LzkUFowef5Y826nYfNXnVG+/DbRR1I/pPAW/Ozih+Wl3BRLx7xJbe9P7qmCe2HXgxwTeiteGwGi
	ySi7hclGDHbj4C+XiiQp+azh72OsXT5zktpkOlrGQ19KQ+ay7Rt2pf5uRnWJVsDXGSnhRsT8NuK
	8Gynys2rz6ppEajAsYvBwkzSe2DGEGVXp8vmgBDLs0PoGZqpri6n2
X-Received: by 2002:a05:622a:14d1:b0:4b3:4299:5c34 with SMTP id d75a77b69052e-4c036de6ecdmr86555821cf.0.1758399374127;
        Sat, 20 Sep 2025 13:16:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1DNyqHIcZCEUjbmIic8X7Hk5Rzdg8lYxc0kB18mG0dSGQEWt0thEl2oJIfyhs5VLrC0SJzg==
X-Received: by 2002:a05:622a:14d1:b0:4b3:4299:5c34 with SMTP id d75a77b69052e-4c036de6ecdmr86555621cf.0.1758399373683;
        Sat, 20 Sep 2025 13:16:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57a6fe56378sm1078181e87.100.2025.09.20.13.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 13:16:12 -0700 (PDT)
Date: Sat, 20 Sep 2025 23:16:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Eric =?utf-8?Q?Gon=C3=A7alves?= <ghatto404@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] arm64: dts: qcom: r0q: enable ufs storage
Message-ID: <vhrxxj36weirztofpxii6iqojdfa4sujrfckbhcga6d5pckzxf@5l55a3rzi5hh>
References: <20250920014637.38175-1-ghatto404@gmail.com>
 <20250920014637.38175-6-ghatto404@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250920014637.38175-6-ghatto404@gmail.com>
X-Authority-Analysis: v=2.4 cv=ZcAdNtVA c=1 sm=1 tr=0 ts=68cf0b8e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=0lCXNLNvAqMk5Dh7VnoA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: c29p94XkS5ac-iwbw2stXKZYdm4KiSWG
X-Proofpoint-GUID: c29p94XkS5ac-iwbw2stXKZYdm4KiSWG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMSBTYWx0ZWRfX7sxRCA1dTJHa
 yymev3xDmAaS9N0AxyrOAewcYWm7rbzKb6fP8Avn96nHhYMD11SyLv7iIMyoEwTcIMcq1Qjvl+y
 NVjNgEQ4FCH3dhrAgZJ3XE5lo8SuwdJlJ0TIWUqCNub27DVJhaD4TFwNnoGc70SuV2AlSLmAuzt
 lB1MOEg73XuV7M6k7fRhri1WrUgbZTO9kk8OxC3KIVXfg1lbkZrMvCpY8E07pgfce8EsP6BqhrZ
 4P7qIxmN5PyFwTquMZJxYqkBHDJZOjXO8guH0KJ2OpP2R3HlX/lfXUkern1lPS6a/BFqKjvUYPA
 fK2RX5EpQWhLhgp6k06LBLbOtFheyPkM8RG543lfmXcgTEgbMDLTGxGyzyJrXgjL31SHNL8Vr7v
 6VwPAMzH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_07,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200031

On Sat, Sep 20, 2025 at 01:46:37AM +0000, Eric Gonçalves wrote:
> Enable UFS internal storage of the Samsung Galaxy S22.
> 
> Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
> ---
>  .../boot/dts/qcom/sm8450-samsung-r0q.dts      | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

