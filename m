Return-Path: <linux-kernel+bounces-852347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6ADBD8BCA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A6454F380A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50B92F1FC8;
	Tue, 14 Oct 2025 10:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VRSU2J++"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E172E8B7F
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760437387; cv=none; b=hewnlCf8KtMia5EwgTAbb42sJz/m3s4fSo9nhDF6Bqd/YeKuXLAzYz7qAyoCpqtFkGEXc5CbK1Zhl1/rHPAn6IrxUldzamGluUGP78FmRIWWSjL0XHf/Dsh1mEP0ajzDF6Y6kp7wr6HJ5Fn8TVH3X7DkcvGIXLErtnhfLAMlmUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760437387; c=relaxed/simple;
	bh=z2WdTcRaPaqI49kofZEevWYMKxOmtfhm/A5grF0PpaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwFEnCOiF8jxq00XyLOWVzm8bL29YstDQIoIFIquuWn7JOB7hZODB66bzDzV6jkeu79/SqFgrLc0WGsdJXkxCQ4TrevBFmJ7P13xuBlI/Tr5zcapTOCUDipu/3gyz55qfAGehtxeGSjIbNkPhmkE/E725XEpcS9MctAuP0affgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VRSU2J++; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87LWw025916
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7Uj/7ATN4u+TUQSCAcK5UK3n
	NiApttHLG6ztUMcWXEg=; b=VRSU2J++mFCvHkkvlPobpzEbjhkwJV0p7WGrp0r+
	UjH3mQUV13vruv4FO2uxwDRPrADDOInLQv2JnjQyDNUP7Lkong/krzOmlPwmCOy8
	ZNqs2ZWM2LNxKkUhBExih9/bDjHRuQuw1WBHEImnX21c/MESQE0dg/5i4AgVnIf5
	KmS9K8ZjJtXkJq5b1oqVodMmXczMx0WlJOiAAMNrFJ/tk3QUSuQyT5w2kTXEAlCU
	PpKLs5Sj51AMed4iEmIkoLOCupi4gaG+ed0bm+O2hSpE20UFf/jFYLNIDYDUNtpP
	wPIU3PEQNjN3wbGf3fS0QUkKN8ekqfNAm4NgzSCMaF1N8A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qgdfyxw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:23:04 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8544316ef6aso1020053085a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760437383; x=1761042183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Uj/7ATN4u+TUQSCAcK5UK3nNiApttHLG6ztUMcWXEg=;
        b=HdlcbE8Rmi9atZPWMzXAv1JrQCIZ9TjCXYH8FbSyIB1LUbJoLr/sOuyndofdMLv7Hs
         W6oIaUzVeEvplK2LRleT1DXXSFOAVjUs1GHKEo/D8xWU+7kBQ+czyL20iIOjVX8fXZ4Y
         fVN4xZiqYanV8a9Psd+kzVR7EUCr1YvkBlsXSsBfckwqD5pB8xKc4E2ll4n9e6JCXWtC
         66QSl2vzss3d6BR4SWMkKj9y3u3y2EKn9gE3Grz4za59Ed3j4P/BuGkPupe2Sv8Hw5zz
         GPsdJ6AZN8QYP/u2sevYOGV6NK3/9cBg1Y2Lbxn7E/vvmmAnTFl4VcGw+n2qK62l7dg5
         uACQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVoA+sucBKzb+ZRTdV/hKrpS99tOFxx2+b7NPELxt2tooa6cVp9ppgify0heldyoKJfqNKCab8xMBqrHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB9e5cifvcmUHZtmaR1AiHflkA7wfgdqux2nG6nm7dg33eGcpc
	Bzgcmf8kp6TeJ9UcxryEMC2MWdlIdCSvK1q/uxV7UDIZhq9zcOmc+9iMArB74hol/38yTHepDjq
	6NSgrm84AheT47Zv1wrLET0J02bSfeJ4UdnGLlKe/cObL9X8K/Bcz2qfBZoncPjKk4ro=
X-Gm-Gg: ASbGncuGb/AMpcXLNzOwXEs8GnvLMwSqqzN1NySDKDayyDZPT5mHBPT6w8N0PrM/z/w
	L2VgVAhmLb+WXvogtYoy2KuQQReuQzu7FmRmqV6iph7JPBXNrJtKdMjSFV0/ojKi5AXdUcGclfA
	skTMUIFl6n3NpQBEGKQlhM3uywxjoEjyradKBTT1Fgu6oRxKoVqQ5z5K6dITL85x8/E0k7eHFw0
	UVd+JYaeNO53BJkHesXcAqf7RlfBdkOBqU0lWWKSnEjASn4MIA9eKHfdshZlVShlbqVEKZJ36wV
	TCxMXmaf0bJ4mks3dy0kBJhqhyu4bEcm5UUditkblNTjqQ43McNY02AHI3ql4e8zHjQVrHIUppE
	qoenufgtd4wDs2ouhfLg06xWpRyV6HAOzs0K/W7QDh4pYvy5KMjHm
X-Received: by 2002:a05:620a:440a:b0:82b:3775:666e with SMTP id af79cd13be357-88352ab09d7mr2876979685a.36.1760437383490;
        Tue, 14 Oct 2025 03:23:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpI9b1UGkdarxfxY2my6QGIRQFNyBFabsw/h2nYcLI4je0hd8JsX+xtryHXf3lrxskF2pXZQ==
X-Received: by 2002:a05:620a:440a:b0:82b:3775:666e with SMTP id af79cd13be357-88352ab09d7mr2876976985a.36.1760437383043;
        Tue, 14 Oct 2025 03:23:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59088585765sm5122059e87.127.2025.10.14.03.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 03:23:02 -0700 (PDT)
Date: Tue, 14 Oct 2025 13:23:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH RESEND v3 2/3] phy: qcom: edp: Make the number of clocks
 flexible
Message-ID: <cjwmyljscgxozzbfdprb43mryoaz66mbqd2ihqdz4fbzzusyon@e4h2qfaeqxux>
References: <20251014-phy-qcom-edp-add-missing-refclk-v3-0-078be041d06f@linaro.org>
 <20251014-phy-qcom-edp-add-missing-refclk-v3-2-078be041d06f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-phy-qcom-edp-add-missing-refclk-v3-2-078be041d06f@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyNSBTYWx0ZWRfX22agTLavg1V+
 qY7H2kFfF+MfD/bOLKSJw5ljMcbdyLCI0lGTWSWjRwBiJJNxWu2fxt8Mf7cSLMd+nUumGhFUhsy
 K8LQLvWIBiEiG6S2P5CAzx4N6qEqCRx5ETLqdxIgBcdDEDPh8K1PpSTvNVGEXw4mHR0uWGsl8u4
 dFV9Nck4am6d1gamOEdrZCsDr/aSd1yhxTTnUHYfai793wAQNOPpdZF5+ozgDaz2hIEjnHupkQQ
 XVm95SDyhiymET7tkxj7q4M0XemZU1Z1A5x5KBm1p3TWWoHqEUB2uHfpk1wxK+3HptjuTi5qR8g
 z5A0DG3gBd3reTPF2pJA7UvoX95/N+Rv4Yr4xaoEtaP99Sj0GZ7MixgLagmKlwxIRpG+uiqRKB/
 g10OGAjYtrwuSbXMQVQXMqlgffWy8g==
X-Proofpoint-GUID: C5pPId6zxHOrBQ9lIYgoyslrSUy1CEE9
X-Proofpoint-ORIG-GUID: C5pPId6zxHOrBQ9lIYgoyslrSUy1CEE9
X-Authority-Analysis: v=2.4 cv=J4ynLQnS c=1 sm=1 tr=0 ts=68ee2488 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=77Gn-jvO4NWksBu-1S8A:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110025

On Tue, Oct 14, 2025 at 12:46:04PM +0300, Abel Vesa wrote:
> On X Elite, the DP PHY needs another clock called ref, while all other
> platforms do not.
> 
> The current X Elite devices supported upstream work fine without this
> clock, because the boot firmware leaves this clock enabled. But we should
> not rely on that. Also, even though this change breaks the ABI, it is
> needed in order to make the driver disables this clock along with the
> other ones, for a proper bring-down of the entire PHY.
> 
> So in order to handle these clocks on different platforms, make the driver
> get all the clocks regardless of how many there are provided.
> 
> Cc: stable@vger.kernel.org # v6.10
> Fixes: db83c107dc29 ("phy: qcom: edp: Add v6 specific ops and X1E80100 platform support")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

