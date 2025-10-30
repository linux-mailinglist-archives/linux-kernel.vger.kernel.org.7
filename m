Return-Path: <linux-kernel+bounces-878872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CB6C21A83
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831501885631
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C8F36C248;
	Thu, 30 Oct 2025 17:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VWetDbam";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JG650cJM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10361F4CB7
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847134; cv=none; b=ZsmV5GlyfhYmlK+4CrkyRT1gOhgnM5ueWXhDsmCgacFoY1+3XgyP1F2aV2VbEzWn8zKfFqAwCG43It61yD9JqEL9XLwx/lkuxDpnRXUzk3Q88IuXzK1S10RMHUopIEwEhblEmfIn34/nH4IkTXPiYcIhgVnjSBdEBVKG/BlGSG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847134; c=relaxed/simple;
	bh=Q52OrGfLDGta4QWoGq5iz5GAVO2sT37KfMJDoKNIZe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQN9xc/InWW7vwaOjYp+YKcvbB+UThJQnuVCD7I8U707zmkDaC3fanyZfZDalbmcFYH0krY4SeSmg5V620phuJqViAPqj+PJ8BwNANLDZcVtZ+nTFdDBja75rTqoKKBaOTPjsM8n7RxOVktEBCmG0Hq3RrE0ryQWQbnkSRXzxVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VWetDbam; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JG650cJM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UHZhM83115666
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=1Q0deErh+I54GhIS1z7OGdth
	5B/KTJBRbE+7iTB3hcw=; b=VWetDbameGekInwSnlRyNh7GOnjGcynxubTf4xBC
	maKc1jX6pXd6QtsZunBVwz88enhEIpfl12MyLKasK7LnZ6Nv9BMDzxL4SUYVIW5U
	qh3AJoydlaZStSkExjf1XvMfAFaE/lwYgWE7Ns/n26BsY9MVh8IasnkJ26kV0pJ4
	vNii05aQ/eOoZI8XIoawFzX224h+fusm2TvXDawh3+HkEF15Xl1s3D5e1+iS5Dmp
	WdVXaWqkY4tovjYlTdT5xCS11TQRCRoCPq7VubjJG6pk7KmGlVTznSJwqm45TT3w
	VJUFR32zqVP4EYgiI4RQy2r4PKtEPCaRzBzxEKMRfJBhMg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a45b41g23-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:58:50 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4eb7853480dso35154571cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761847130; x=1762451930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Q0deErh+I54GhIS1z7OGdth5B/KTJBRbE+7iTB3hcw=;
        b=JG650cJMpJHPpCZEXRwGWABGl02ZR7WQmIih+EMW1cjdzGL1jwOcR+Z75mJf+actTl
         d9a/dIGNyZM1TQo4eSGPX2PTWcfRMt3tlAzIyNOm8zGOwonx59ubVTTqEkrO5sqEO7TR
         Xgvmpo54X4DQsHZsapo5iX7BgWY+aBfKyLSLAVxUG12C6qT6yPY70Top0PtfdQ3LLVN9
         We7b//RJL0jYCFCTfB9Uu2CAM/Nx1EjN1gy7eF8sBQy5FtbZHLOF7wz/04MarnF4Zg+H
         PiJ6ZebK6e0Y8/bPwmTosqqSECNaP9ML3gazSVqe0aJ+P7wKkARyEYFsCXGaqlCBFVgg
         GPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761847130; x=1762451930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Q0deErh+I54GhIS1z7OGdth5B/KTJBRbE+7iTB3hcw=;
        b=pz1vcUwLJVF+OTMN7/BZ9mgzFXh+i4JO5lfj0cxv2nFSXRM409oPnWKCvB8//6q6Ld
         rHe7TolHJGEgZbnQtJCNxgF7z4/rYvGOfeJ8JMm3zcmA4Um5ZELBdT57+SPc8RBB6gzq
         mm08yu5XQvp0MO2cvyjuXs+EjzwEC5BZ4hhabyi21J4I7dIHZSpThjQ9t+JySah6B6ex
         D4qsuIHnYRSPSRTbyJvkYFpLoUeeuaOJT41TJ8akoGDUTOeyLefVZbufN8npfIb4fhXa
         n5+8zpQQ8iVSwQiXhsggXtyY+3zMglcb9PNl1qCcdIBC77Pk/RQefDarYoqTk14KMi9L
         nI6g==
X-Forwarded-Encrypted: i=1; AJvYcCUhWUs5yrD3e1Bpz2tuVm4clKFBrbD/2YqeVQy1cyMGMp9xobB5k3D815vc7Zbktu9vtqYnGpYC5OVhCk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YztDbZ//6HHIaZ3t5wzocCjYHtCaGD/VdsxWxXhYT8xxxMfm7OA
	cVIKpXqCBTiE1RqCW2GGY3vawfYGu+UUFY3DrmLn+f3VESHf0xxaQAnFuwZtRIbyvU2CsjFlvLU
	Ut6N0cKxbwPoSs78LfTYx92UwMYwaza+TNhhsLZRNcsTvutCkTe8g3ttPz3W+ML+2ByA=
X-Gm-Gg: ASbGncsYZ0Z0P3f7tPFSWrFDfrG+ZbpFVRRkhYyKbGCqNZ5emWp18ayalEiEuobURjl
	UvAkRCssGCVKImwn4UWjJK+s3LD7+Z8kZAhpkRjEYK9ElKxDkUEp+hdHbHYJLucbeIPaIHkZ223
	aaY1e3DuQ0zWDVItp1A3F5cYSzWfvXGji+gYAGnV2zVBMKQPlG7nvpBzyQnzh06USGAuwlDLmLD
	gLMNJ+BOKEkEKGLrN7HDOWNT7q2ryEbpRVe/CS5ZJ2l0JzR9UrBFn7TzqGFs8roasLCXe2UYfiG
	gk0bXMO/vNamkxwwgIc3aJZQ9vTcd49DMUFogxUFsAuPir1hgs6FGFl7dQ8iSNe3WeC9hTVSBnO
	E/vxNJq0rO+CmH+7H3nVkNYT4m1p99cSNWd13Fh9qB61vOHoYktnpHHskuhM4nm3VDliP4sbUX3
	O0cqSWrsCQrxF/
X-Received: by 2002:a05:622a:1886:b0:4e8:aad2:391c with SMTP id d75a77b69052e-4ed30da2680mr6941111cf.1.1761847129689;
        Thu, 30 Oct 2025 10:58:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnEyIEQZlV9AL9hQo39GA8tkdTMFXooFYwSJ4HzSOksJTmwx0/qrIgEOylTfOt9zo+f+r2yA==
X-Received: by 2002:a05:622a:1886:b0:4e8:aad2:391c with SMTP id d75a77b69052e-4ed30da2680mr6940501cf.1.1761847128768;
        Thu, 30 Oct 2025 10:58:48 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f5bba2sm4718168e87.52.2025.10.30.10.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:58:48 -0700 (PDT)
Date: Thu, 30 Oct 2025 19:58:46 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] arm64: dts: qcom: sc8180x: create common zap-shader
 node
Message-ID: <p5apfg5cbwcdmilfr3omoncvuj7z7zbj6dkex2eicjdubkyxwj@h42bzzhx4amt>
References: <20251028-dt-zap-shader-v1-0-7eccb823b986@oss.qualcomm.com>
 <20251028-dt-zap-shader-v1-3-7eccb823b986@oss.qualcomm.com>
 <c90b917e-b3bc-42fb-a127-ab47d5154d0d@oss.qualcomm.com>
 <c62a7f9d-6984-41c0-88c5-1d6c40d411dd@oss.qualcomm.com>
 <weyze7a2pqmt2klt763lbwyvpezqndm5rjnitexalru7hy3xhh@tdqx6xeqp3qu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <weyze7a2pqmt2klt763lbwyvpezqndm5rjnitexalru7hy3xhh@tdqx6xeqp3qu>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE0OCBTYWx0ZWRfX3x9SSiTM/GhJ
 7U0ClwW19OQn/vWiHXOoo0ZARApNI3Dor7fLtAwU5fkMHHJHLGY/FOE1JMdOY/kLdOc9k+g4QpL
 yd/+UqDUjBBMMFzEYY6T/jFvQeeJp2LXjywKvSC5hWxlEka1gDaN+YjC/GQnUU1nwkw9eG49wxT
 G51ODCluVtn2RWlj4g57CuxKozsc4qvaVBQZ6YVdK15EznyZzeP486ZHBfULsBU3E+UAxLzQp8W
 PJqWseW9czAtMYReJJOB4KjzXUg9wLY/TwIOpgYRLJJPMXXZ2mBJboGod0+2EQx2LcQTd9pqK8v
 tIUWgSCdXEKARSlQoGlFbHcc5yOKT4cf7Y1DfTZPRPBtzAAKtLip1Ld017Ag4V309uYAD5pcKNi
 DAHPlhUeWglghW/BMMQJ7f9FeyqaUA==
X-Authority-Analysis: v=2.4 cv=KePfcAYD c=1 sm=1 tr=0 ts=6903a75a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=76FKqnuqe-XMp3VuG3UA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: BEVfSFJRUr3odWWKRuV-jmpeqxbUSE_Q
X-Proofpoint-GUID: BEVfSFJRUr3odWWKRuV-jmpeqxbUSE_Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300148

On Thu, Oct 30, 2025 at 12:28:31PM -0500, Bjorn Andersson wrote:
> On Thu, Oct 30, 2025 at 11:59:00AM +0100, Konrad Dybcio wrote:
> > On 10/30/25 11:58 AM, Konrad Dybcio wrote:
> > > On 10/28/25 10:00 PM, Dmitry Baryshkov wrote:
> > >> In order to reduce duplication, move common GPU memory configuration
> > >> from individual board files to sc8180x.dtsi.
> > >>
> > >> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > >> ---
> > > 
> > > [...]
> > > 
> > >> diff --git a/arch/arm64/boot/dts/qcom/sc8180x-primus.dts b/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
> > >> index 93de9fe918ebdadf239832db647b84ac9d5a33f6..069953dcad378448800d45e14931efe1fe1a69fc 100644
> > >> --- a/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
> > >> +++ b/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
> > >> @@ -14,6 +14,8 @@
> > >>  #include "sc8180x.dtsi"
> > >>  #include "sc8180x-pmics.dtsi"
> > >>  
> > >> +/delete-node/ &gpu_mem;
> 
> I agree with your hmm, seems this line should be dropped(?)
> 
> Dmitry, please confirm and I can fix it up as I'm applying the series.

Oh, and this line is necessary, because sc8180x-primus has its own
location for the gpu_mem.


-- 
With best wishes
Dmitry

