Return-Path: <linux-kernel+bounces-847018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DD1BC9AAF
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D0B21A61460
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CD62EBBAD;
	Thu,  9 Oct 2025 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ISIQh3tL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B342E8DFD
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760022029; cv=none; b=h8iaX/oQR+94DmcFFZxD8FDJMHWqvoMt5RTBqi+lRb1SgirPPF3dNpQKwJulaPFrAUZNTWuesqzZQmGXK7LuawHS2tqUpZ5a5zr54qm+eg2SdrDiiatps4uI9BYIx0bIk2ezTpFDv3h/cnUotCQGYdfgTvZMCEqK5tEQe1m+myA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760022029; c=relaxed/simple;
	bh=oQjcIWctgbJPLlW8Qg4pVgJmyLYFTvKpb037ktt4Fko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nj/YvrGNcMEf/R2utYgRmHgVqUnYPWm8Mp0ZiejjQ+XcXgFdDA6mwndRKwnMzpGZcAcJvpUu0DFuD7CRMUuDWi5Jvp3uMPhdj8O1p2DM5gMsP6dOZxarT3izEx3/OWVPJ2qCauask6kLabZx5L5KMP/MzWDZUS0o8cgKHBxclyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ISIQh3tL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599Ea8Ze004125
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 15:00:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=q17C80Ek5kynBMl4n0c/KacH
	qLIjQzsKeaXbG1eV2Mk=; b=ISIQh3tL4s9eemvobK7JjzEVY/QbQpAflx+FeLTJ
	6AUcZL9jY4sHR6XDh91v2gz8rgJDPTnzQRAYO8+t37GqyLFHQ2IgtajG36qQ+in+
	Dt7sHEV/mJlp9rGzXv7XenVhYeqVwP1Xj5m4YEGSkEMAAOBe6teoEz8QVxIPM0pB
	wjGeuUgDXcAueSDHxxm9V9Si+H04qOHyzbapT/z5jo0KX9jOEOU6Slux8RsOLQzl
	KZ/Pk9TlKDlAICW2YAEydpTUHE0WwuIUZpvnCdZJA1mBc2rctMaf0DhGcK4s3oKO
	+tEI0zSwzBk5uovQpZ1/tsRGljcyy+GAiIdFkdc+QrOu5w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4j3a5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 15:00:22 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4de2c597a6eso50845191cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760022021; x=1760626821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q17C80Ek5kynBMl4n0c/KacHqLIjQzsKeaXbG1eV2Mk=;
        b=aSpn91j79r5vje0v0jwNoOFLPqfV8wSo/CcJtuaX9XXUHFz2Hm75e475mu3+9RnFsP
         4SI7RmUUnjek7UB1Ha3wPb6d3z9ekM9HKj9Ct7zlSNxMhIk12gDau65otGz984YSmbJy
         7+xEdpusXpn+9Q02bTDAgvlf3oP08xpab0T/LC4XTweqdgbGx/JZCMivjDuCwKXyeEqV
         7h9gbZR98wl86TXBfJKepuE763xN0bh04wURQJydlWGWDkfnqNHsaG5amPsTkckbBjLB
         HKedECrpKnj1Ls2pHxjfork6RxMtnA4mStXMKS6JWR8Jh16Qx3rYX2mA3opBljjPeODx
         D0LA==
X-Forwarded-Encrypted: i=1; AJvYcCWzhzFiMtRdAtKp6HTIGIj4ALBQ/HK/arn/C52h8Z/5ICdxp6LBduTy4wSxkj1GqWUf63u1udEtYBixI8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVxH3+XAlC8M5BGxiDo1n0iQ0VqKFNcF5XPVvqySMVQOU7/ppA
	qGOuFw76j330jGVzfdgHTv8gQnx0yHiytXsMwc3JVDBngaR0ZmJEoxpZx0VZtm5j//+REtj9bPJ
	C4G6FgeqTOus7N2bXnmXPZ+ZFP1lPGJC/o8Y7RcDn5Iv7PLTrev1QA5dpYFHZMe1XTf4=
X-Gm-Gg: ASbGncsj7Q7XOanAybRwj16pN07DeFB5gIBXXGqCPAqtJWLFyKdAWONGHq9ZYKqqXUx
	jlb1xse54PhKQqqifCMduyGh+NMpjdehrOfuGNZZQ9P73w8zk5/Q1SHIJWxW0C/6NsQciedv7ZE
	JRDQx3qhva3XrKDj8sjJ57pI1AA4Ui1ABSuFXvV6PHkbVHdzc7rXkmuDWtUsvnU221vre83m4xI
	WVD68aVyAWeII6mMDR3i11AT5yiDq+Ls/s2uxp/A8Sxl9gdWIR9keCi5RPKRnN+7nz4l3zw5vgs
	gOBtp3mCfPudWBjgcTqwqMWa8xug/ZsOb6sOUn5Rtoq1PoeiFTwxK1kuUTctsojZX8SHyltqqeX
	NWzmjtPNWmpS5y1787pRo1+3A2PrR0itmh+c1L6JmmnvBW3RlJQxXIchJeA==
X-Received: by 2002:a05:622a:1e9b:b0:4d6:acc6:752f with SMTP id d75a77b69052e-4e6ead67a78mr117796321cf.69.1760022017626;
        Thu, 09 Oct 2025 08:00:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOLeCo/4yfzg4V3OpdNjM0GOglus/bZmIC2kvT6XMMcZnOmkG759gy5ztQPjqbV2UhQiLkHQ==
X-Received: by 2002:a05:622a:1e9b:b0:4d6:acc6:752f with SMTP id d75a77b69052e-4e6ead67a78mr117795121cf.69.1760022017013;
        Thu, 09 Oct 2025 08:00:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-375f39d2cd8sm28630461fa.7.2025.10.09.08.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 08:00:15 -0700 (PDT)
Date: Thu, 9 Oct 2025 18:00:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] media: iris: enable support for SC7280 platform
Message-ID: <um6d7e2su4erqet5fxyaxpyulfrzqvadq4izxgmxu3tol3i7jk@godpxwsqeqzs>
References: <20251008-iris-sc7280-v1-0-def050ba5e1f@oss.qualcomm.com>
 <20251008-iris-sc7280-v1-8-def050ba5e1f@oss.qualcomm.com>
 <3f1979d4-1438-4c9d-99db-d97a09c5c35b@oss.qualcomm.com>
 <gdui5coiazt5ynuz6c6mr5slau33vuewr55vx53m5zzyi537at@cs7dbgirijuw>
 <1118c126-4332-4f9b-afb8-d3da4fa7fa87@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118c126-4332-4f9b-afb8-d3da4fa7fa87@oss.qualcomm.com>
X-Proofpoint-GUID: p9A9autSmyWMXxLYjsVB88ZyuMRbUcZU
X-Proofpoint-ORIG-GUID: p9A9autSmyWMXxLYjsVB88ZyuMRbUcZU
X-Authority-Analysis: v=2.4 cv=f91FxeyM c=1 sm=1 tr=0 ts=68e7ce06 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=LpQP-O61AAAA:8 a=_mRl7PyFU19oPcLm8DQA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=pioyyrs4ZptJ924tMmac:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX+s/v5rZsGaXn
 3bf9c20mSWeqC6raD2PQYC2Be24OxpTTUAcGnIjDf2gJBOv667A4u1bxSXXTZnzBcOTsIqoDMt8
 WMVYAdQQKXnPwb5vrmAPSiZgiYFXs0G55Z/UNBLKU0vuk/XlW4/ZzcbAvjJcNtnC91RPzGo/NDn
 ftxWredUN4cO7aFZglzECBJk4t8UUL8+CyWMnuz5uLVhO+qJi33I+vL+xlZ8u0evCpQIRQAHP1O
 oOE61xkSwN47m4nfwYf82qPvkqTAEmBlMOr3LFm3/5yLk/wHSTsJzEKA5+VydIAG3mmQmOU9OqW
 39TAiTt02OMU/CLNdHzxp78Arzqu+jsF11wYtNFehIfX2ZRR73i7jkRPvqL7wRqH19659WE0vR3
 dcHAlNuBuef4xZuBx9T8PugdWrTodw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Thu, Oct 09, 2025 at 11:19:31AM +0200, Konrad Dybcio wrote:
> On 10/8/25 9:25 PM, Dmitry Baryshkov wrote:
> > On Wed, Oct 08, 2025 at 10:26:02AM +0200, Konrad Dybcio wrote:
> >> On 10/8/25 6:33 AM, Dmitry Baryshkov wrote:
> >>> As a part of migrating code from the old Venus driver to the new Iris
> >>> one, add support for the SC7280 platform. It is very similar to SM8250,
> >>> but it (currently) uses no reset controls (there is an optional
> >>> GCC-generated reset, it will be added later) and no AON registers
> >>> region. The Venus driver names this platform "IRIS2_1", so the ops in
> >>
> >> Which we've learnt in the past is "IRIS2, 1-pipe"
> > 
> > Well, I'm open for better suggestions. iris_vpu2_no_aon_ops?
> 
> [...]
> 
> >>> +	writel(CTL_AXI_CLK_HALT | CTL_CLK_HALT,
> >>> +	       core->reg_base + WRAPPER_TZ_CTL_AXI_CLOCK_CONFIG);
> >>> +	writel(RESET_HIGH, core->reg_base + WRAPPER_TZ_QNS4PDXFIFO_RESET);
> >>> +	writel(0x0, core->reg_base + WRAPPER_TZ_QNS4PDXFIFO_RESET);
> >>> +	writel(0x0, core->reg_base + WRAPPER_TZ_CTL_AXI_CLOCK_CONFIG);
> >>> +
> >>> +disable_power:
> >>> +	iris_disable_unprepare_clock(core, IRIS_AHB_CLK);
> >>
> >> ..for this line
> > 
> > Not only. You missed the absense of AON_WRAPPER_MVP_NOC_LPI_CONTROL /
> > AON_WRAPPER_MVP_NOC_LPI_STATUS. Which in theory can become a flag in
> > iris_platform_data.
> > 
> >>
> >> but this could be added to that one instead, since both clk APIs and the
> >> Iris wrappers around it are happy to consume a null pointer (funnily
> >> enough this one returns !void and is never checked)
> >>
> >> similar story for other func additions
> > 
> > In fact, initially I had them merged, but then I couldn't find an
> > elegant way to handle AON regs. I can squash them back, if that's the
> > consensus. Any idea regarding AON regs?
> 
> Digging in techpack/video, I found:
> 
> commit c543f70aca8d40c593b8ad342d42e913a422c552
> Author: Priyanka Gujjula <pgujjula@codeaurora.org>
> Date:   Fri Feb 14 13:38:31 2020 +0530
> 
>     msm: vidc: Skip AON register programming for lagoon
>     
>     AON register programming is used to set NOC to low
>     power mode during IRIS2 power off sequence. However
>     AON register memory map is not applicable and hence
>     skipping AON register programming for lagoon.
>     
>     Change-Id: Ib63248d118ed9fecfa5fa87925e8f69625dc1ba8
>     Signed-off-by: Priyanka Gujjula <pgujjula@codeaurora.org>
> 
> 
> lagoon being a downstream codename of the aforementioned sm6350
> 
> Meaning yeah it's bus topology.. so I think an if-statement within
> a common flow would be what we want here..
> 
> perhaps
> 
> if (core->iris_platform_data->num_vpp_pipe == 1)
> 
> just like venus and downstream do for the most part, and kick the
> can down the road.. In an unlikely event someone decides to implement
> IRIS2_1 on a brand new SoC, we can delay our worries..

But this function is being used for VPU3 devices too, if I'm not
mistaken. So it becomes a bit ugly... Also I'm not sure if this is
really related to a num of VPP pipes or the CVP.

> 
> Konrad

-- 
With best wishes
Dmitry

