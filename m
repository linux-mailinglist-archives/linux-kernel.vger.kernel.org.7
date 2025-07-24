Return-Path: <linux-kernel+bounces-744218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DB0B109AD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A8B6AE2024
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4AC2BE64C;
	Thu, 24 Jul 2025 11:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JtWQumYZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCED2BE628
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753358132; cv=none; b=nSDQtvYgPDXCCEtjUq1Qor3AoPIqcVJs2+E2Z+mZVSPlzQ1YYYr6YFRuwgn50YTn5onoPYmS1IYigw5BVWzQtpsy+5QxWJUlXBqsPks0peCNBAnI/kWYk1zY/f3NxghNOtG9laLtKpothzDRZUGMeSfyMMB4EXGQNnIQonTmVWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753358132; c=relaxed/simple;
	bh=jfCb++kTsyb3iig2h1ycKbyRXElJw3YUbi8qzbAl8/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKxzhnHUgyhcXlQcTa7OlrrFFSP31KAhwxBvmbXzMXB81icf6cOkY86txWpWLsoegXISOGl2hIEdbS3iPHv/O703uSxbhVDvcrAg1slz3/YxC2Ll8jGU/TJWe5WWjae1RY3isp2/Gc78uyiArEOJGvGkBC9ZdOOfVMEL501HZxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JtWQumYZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9ePmA006564
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:55:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=mINbh0hT0mOMLjUaQwlGXcWW
	ToNWDwkhWfpfbCEFXxs=; b=JtWQumYZJkZLJV4AipaSDwxut0syaib3lRas6zal
	9hzcGjFLqShot4RHdNHklOX5WV+cPhH47AAe8yqT0jX2d8dZgOUbuVwDQN3OKcIo
	pBJnKVL2u527aYZm/oNeiLL+semul1dK55OAdm1vjxvEljN2GLcEAIlh/uo/IQnN
	M/daUF+SHZ/V3H5qR5zNd3iJ5CTzl317BIg/R3VLv9vHtebx4LuqPL39ye3qbMjo
	dn/BtO5izWiF09IRSUhHoca91PjSQQn6OGqTH3NALZKHEmPZ7bsVy3zkYTl7E/Si
	5rnvn6vHyUC/lAVtRld3HfnxzmR/Bbwj4BInBbpO5p/ZKQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48047qgm2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:55:28 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70713aa9fd6so8506716d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 04:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753358127; x=1753962927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mINbh0hT0mOMLjUaQwlGXcWWToNWDwkhWfpfbCEFXxs=;
        b=faXcL3hRo5G0G4mvi5PKvgbF70VwGZnqB4fSICGseBSUKl0omeGhak/rDw3DMMg4a2
         /BVdKkE6uTQOhDpDzmrJe4LIlrxRkYFed6P1bdAGoHe/HZsCd0Nt2R0u37ycxvdZEJx3
         Jr01gRiHgTsrLhd5s4bHCR6vK9QRevkQeB+9VoG8PuIR8WtovJpUrbjnGjHBKxkfYQmg
         zXL9gjGc+1N3rCcUD9q6ProVzLk3dpD70M7Z8uwa902pMM8tqqaHxlvMYJ1LxlGaTfvm
         9DMizKPg0SN9/F4KGJVtFN7ehCidiAkmecuE2mkn6hnwoXEVjWrC4nvLpIhSxD1TS0vG
         fWvw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ8xP3TxtVTF2+E7ySpEgYR5r3brYk7k3BMnrpt3KZkNL7H4TJACS2sp+/z983myL+lZl0cSSeHS2PKMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuT8iu2HKlNVN4iK96dzQnpSnjY/RElaHyJdYCOCmVKndqLQ5g
	0NvuJkHXrH7R3FWVuLSXXwZW4mJK/DcgrF3AIsdQF7rxhtLFxCMxQ+qmuQb0UCF6T+zDH5xBgRc
	Wby9ieZcOOCEgc46KleShMhrSr5xCBB1ZI5yEBGrCgO/p7E4NxY2KOtQIOEyODiOvcJfMDVPQjF
	Q=
X-Gm-Gg: ASbGnctWgij26VgqIaNs7RiBGV2SY/rcMxfjHF+T6Ytd8Y2a5QeTuohScvli9fzB2tw
	m5/hbXz20zeK6RuAbcGyUHt31lUMcYFqhK2nS6udpdZIfUcOqQtpuVuz/6DhJDqgs8eoOYFxU2X
	SLLpxVYzd6l3SeElmgbcKgW6mZRitVkXqg41X+Si74Xk9U+ZxsmvBYQGkJbSZug1qUoiVUxf/pp
	bT8JKZIDfxqen8dcNzfFHZOaTJqHAh+jljTUoMUG7qaFu7f4lewYt+yhiBchj1XzvS7i0SCedhN
	6l0YMwEzn8ayiyuVqFM5YyKqEwpMDRGiNn/w4wWuzCZNWNpcs06lWfqZq+2cphdGLBbJLja2Kir
	Tu/3mYV7z15n55NT83r73GW6uXOPH3utoYd0sAiPf45Q8HLwUBF0t
X-Received: by 2002:ad4:5aae:0:b0:704:f3ef:cbc2 with SMTP id 6a1803df08f44-707006800c0mr78839436d6.33.1753358126487;
        Thu, 24 Jul 2025 04:55:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGd1t3+gJxk8pnw1F60NxFlYtusGeWg+p73JrUwlRncJWEKckPZk4d7/2qrIO4VrYiW8onn3Q==
X-Received: by 2002:ad4:5aae:0:b0:704:f3ef:cbc2 with SMTP id 6a1803df08f44-707006800c0mr78839116d6.33.1753358125983;
        Thu, 24 Jul 2025 04:55:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b53b2286asm327797e87.32.2025.07.24.04.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 04:55:25 -0700 (PDT)
Date: Thu, 24 Jul 2025 14:55:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Mahadevan <quic_mahap@quicinc.com>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Danila Tikhonov <danila@jiaxyga.com>,
        cros-qcom-dts-watchers@chromium.org,
        Abhinav Kumar <abhinav.kumar@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Yongxing Mou <quic_yongmou@quicinc.com>
Subject: Re: [PATCH v3 4/5] dt-bindings: display/msm: add stream pixel clock
 bindings for MST
Message-ID: <5nqzjnrivsuuttslzfecdwzigkqhdipy2wbjmgaa5mijr3w5hl@rbz47vnykzzn>
References: <20250717-dp_mst_bindings-v3-0-72ce08285703@oss.qualcomm.com>
 <20250717-dp_mst_bindings-v3-4-72ce08285703@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717-dp_mst_bindings-v3-4-72ce08285703@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA4OSBTYWx0ZWRfX4hel85BMqTig
 8J28saIHnm5wvjh7ALA5ph9QCNhszJQw4rHovEPOOD4mRHdjR31RbTgF1gyxrYLG9vIZZGi3H6B
 +prwkWKXe2lj33WHa8UhiOiHW9/Q7GB2h3THg8KK1vomjX4AB934+DzrctGwoDqETlClNUDF/UG
 5fnu4kk9Y6HFO0Sc7fMRSJKgClyqERP9XsnpiQeHz5teCY3+KuLTnXQtXicHsq0jTDFEeBQf9/q
 taDzYEIs9DC0ZYkfhaoR6T0LegCNXZp0fenF/YBEGEmkBC22+Mu/4fF7qrgao9Ar3w94lSGU19i
 9CElK9Ak/KP7R3peu6dMyD6ULUUaAobM3AhxKm51dsU+gOhf/1/UxgDDQfR8O7m7ztO9uBoOQ1m
 SjLH+TTx1VJGV9kOaFw5I9DIg5qL9wMDCmQD3sKnkcITF1xRH60CTBH+qe+Ng2bN8/eeLJQL
X-Proofpoint-ORIG-GUID: Ae5wLN4ONiBuEfZnVizcjzQ1u6K7O8Ih
X-Proofpoint-GUID: Ae5wLN4ONiBuEfZnVizcjzQ1u6K7O8Ih
X-Authority-Analysis: v=2.4 cv=IrMecK/g c=1 sm=1 tr=0 ts=68821f30 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=TLo0AdDBy_HI3n6x0gMA:9
 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=810 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240089

On Thu, Jul 17, 2025 at 04:28:46PM -0700, Jessica Zhang wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> On some chipsets such as qcom,sa8775p-dp, qcom,sm8650-dp and some more,
> the display port controller can support more than one pixel stream
> (multi-stream transport).
> 
> These chipsets can support up to 4 stream pixel clocks for display port
> controller. To support MST on these platforms, add the appropriate
> stream pixel clock bindings
> 
> Since this mode is not supported on all chipsets, add exception
> rules and min/max items to clearly mark which chipsets support
> only SST mode (single stream) and which ones support MST.
> 
> Note: On chipsets that do support MST, the number of streams supported
> can vary between controllers. For example, SA8775P supports 4 MST
> streams on mdss_dp0 but only 2 streams on mdss_dp1.
> 
> In addition, many chipsets depend on the "sm8350-dp" compatibility
> string but not all (ex. SM6350) support MST. Because of these reasons,
> the min/maxItem for MST-supported platforms is a range of 5-8.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> ---
>  .../bindings/display/msm/dp-controller.yaml        | 36 +++++++++++++++++++++-
>  .../bindings/display/msm/qcom,sa8775p-mdss.yaml    | 10 ++++--
>  .../bindings/display/msm/qcom,sar2130p-mdss.yaml   |  6 ++--
>  .../bindings/display/msm/qcom,sc7280-mdss.yaml     |  6 ++--
>  .../bindings/display/msm/qcom,sm8750-mdss.yaml     |  6 ++--
>  .../bindings/display/msm/qcom,x1e80100-mdss.yaml   |  6 ++--
>  6 files changed, 59 insertions(+), 11 deletions(-)

I've cross-checked. We need to stop declaring SM6350 as compatible with
SM8350, it doesn't provide MST support (and so there will be a need for
a driver update too). Other than that, please document DP MST on SDM845.
With those changes in place, I think, all platforms will be covered.

-- 
With best wishes
Dmitry

