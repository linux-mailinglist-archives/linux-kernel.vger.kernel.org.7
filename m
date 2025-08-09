Return-Path: <linux-kernel+bounces-761007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E58B1F2EB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 09:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EE855806DF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA12227702A;
	Sat,  9 Aug 2025 07:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nTgVFaG+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B556F13B5AE
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 07:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754725808; cv=none; b=lkMGN17sx2jZljxqQUYPqoi23WULKIALPb3h+D+A7+wVldTioCwn4B9kZ+i5rF77O+R//HYBvexS3fK2Khi+PevrUwFz0KiYPegUEM2JbtLL0zO81ogjxeG0YLh0k8j5EampnXVSuZKM5YG7TyXlIJN9yOnkOLk+uDyMfptrCXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754725808; c=relaxed/simple;
	bh=tuG6zqQ5L9L0iyhIjN9ZetGHu95N3Cy/2VOf7ioHYHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1ehFmRTd0dpLbOEUYsN2XuJHg4b2ZBDTyI/qwSvy20L+BM/gqCqkH/Oeo/OPk9qaskudPyq+yMst8/aX17zWYwLpHEfecgVkB25OLrvJRP+jzCZDQS5NWxmkPJIZl2ADswc+OkTRb1NroJAylXcu46XgtmgYcJjEr2+D6/EVk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nTgVFaG+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5794e2kG010478
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 07:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=KIv+87WZnmPNL4ThTLyntiJN
	mnPRtbH0PSGM5L0qqYw=; b=nTgVFaG+K+SEp+Vfk+2TVXAI/wDQYdOOXCLlaFpC
	/YgJwFRzTroZB0bxc0qpZK0MpXPcGoG3Ul0bkSwD0ZwgIJsugo80Zlmz47OAwaqn
	m1ndpen2AP1F2BV7MCpk8CqUMfbPiuAbIemyXKoiFKrfXLTQ+wiuceWkiCBVC5rC
	0ovy9bsoFIyaYmCMz3DVPWS/HhCIXPf8Tn15jEaEqNBh8nrIVAiRREoAgA/G1moW
	9aHMTFg4p1IC2ok1LlIgv4hKs20/qXHZsIlPmN2ymfQJGqhk+AtXAMEEFmNJYm8L
	GhScut/QhvrH4FnZLAw0vIxLD4YffTmflAkx3knMAjPIHA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dygm8715-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 07:50:05 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4af199d0facso82818761cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 00:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754725804; x=1755330604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIv+87WZnmPNL4ThTLyntiJNmnPRtbH0PSGM5L0qqYw=;
        b=mKgGsEFi7ZNo07BULgzOEeAIp4XXNlUNaHCrP8+vYPCkxqk3cv08mGG96qbdpxc+pX
         qdqiFdncJFDz/2MEmeptGnw01dny7ySNCxIebh9MCGEFpGQcP1dO73qglUUEIuHzRsNu
         lg1ojo3G7/5lO8HMyx423GCi+1f52m2uin4/HFDrIdkU7NC8QoIrk3JhmSR90dcb9/4Q
         7wVkK0KJ74hwlmK/0LdQH2xLdpOPBOm5vv8UPwyit2qfg16lbyftLcxxI+0vfQUfD7Zx
         qKzjELbGgTQhTynlVeRHVGIxxGT5F+0YhKcTK08Ck2Ryqiexy1UZ4WGCWGqpYLcIW7sP
         qgTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5OOGmvgmAyuVUi+DeywZnJWMAWgYuo60M029PADbJi+yo0NKMP0Pc1RNYtUZySjx01IgRig39mj0R7hY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaYpPs/NiXUkkVNiyGM5Rui4fHhbLDGdSi02DRIlFhCJNVaqLn
	JMEhrmzgEULymKLAAUQLKVyp46l2b0SCYnZooBV7uLhSgsNpZDPfUqpquJb8o4G39Y6rm5MfIsT
	kzmagmihkMZidsRazIRPFO4wiTR/FcfbpLA5ItmyF3VT2Mo7wOXqJ8U9HFvc9d7xhBPc=
X-Gm-Gg: ASbGncshMcezQ4OtM8SO1gPsA9i/H/ZzwdSUudk0RmGo1F1pNrT6NvaMvJ3dNXm+toQ
	RESIHB1Fp9DEJrJCsU4IjCpfeGCYggCMjT5HRvcZegjEPvZIZyRYSP4kWF3letEyEuWqTbTmhKW
	LQpSSFgGgm95+d67IcIwoNMelsJWuzFEcpe3vDO5xdFrgiZ3ddxXiC1bPADPq6U1sdjuQgaGUrn
	K2Lklso4tmu0XVxCFO+mXohauenBInwTbymRU3/La3+G2eXHSJXpOhamWmdNfXiVgrt+fi/Rtqf
	s9EXrg+4wsnD1Xy8UavpIFP+PF1po8bm3y4neIdItooQ36vex3QMPjnK1HzQCBGfYHzqXuycp4y
	Lp8wyAjfH3DH8u0UZHk7vrWepSoTJhCJg4B2J46kQOToJ6RQEpyGN
X-Received: by 2002:ac8:5a51:0:b0:4af:202e:8089 with SMTP id d75a77b69052e-4b0a08148a0mr125899411cf.20.1754725803038;
        Sat, 09 Aug 2025 00:50:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxI+gjavNM6ggie69vmxassR2R0tQvO+7zh1RHMuETVx53XdjkoGj5x4yo5p2INqhj3jTguA==
X-Received: by 2002:ac8:5a51:0:b0:4af:202e:8089 with SMTP id d75a77b69052e-4b0a08148a0mr125898621cf.20.1754725801027;
        Sat, 09 Aug 2025 00:50:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88ca334asm3273607e87.131.2025.08.09.00.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 00:50:00 -0700 (PDT)
Date: Sat, 9 Aug 2025 10:49:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>, Nikita Travkin <nikita@trvn.ru>
Cc: cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Describe on-SoC USB-adjacent
 data paths
Message-ID: <7bptwqmqimkuixgo3zvwfafktx7sj6a5xzfcedip6vuudhwmqt@ey7cs7x2ucxr>
References: <20250808-topic-7180_qmpphy_ports-v1-1-718d7c52921a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808-topic-7180_qmpphy_ports-v1-1-718d7c52921a@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzNSBTYWx0ZWRfX/7176KXz5OKf
 6DZjsfVfHPkPtMNzMKWkGQTxdaptaBGVfWG7c36Oy7mUmiehAym08nj0Tekuvtp6gp5JSUxAzhj
 k7ao+pw1HDp7+/GkTbnj3ZWQam9wKcf/D0q+gV7rDdCdI6iTgMxgSAk+3YG+4P8PapRqJcvjXJr
 iQmv1yu6DUtpERg52Yd5nnT8Ds6Dg/YGY0VFjogjpQCT4u6CwL7Oc9HeaKQw2CoVJyYxed3A8cn
 zFcIm/j4uxxW9OSJXYvWovudwlTI1Dstj55Isx+cHypt7r+FVT4et09QFNgIkUg94/o8c89Mn0n
 l1897fLtTQO5u4cyqQakVSD8ctgS9+e+FLiPlAYGHsEilaAnhxLMCo6gAKg39hTuzJXn+hlLx/w
 bfQQuqZ2
X-Authority-Analysis: v=2.4 cv=FvMF/3rq c=1 sm=1 tr=0 ts=6896fdad cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8
 a=hE8mw8KEZpgZAZYcw0gA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: eTq-6oJmfyi25GzMgr2J404SgQDUGK1_
X-Proofpoint-ORIG-GUID: eTq-6oJmfyi25GzMgr2J404SgQDUGK1_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-09_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090035

On Fri, Aug 08, 2025 at 11:20:45AM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Define ports {} for the DWC controller & the QMPPHY and connect them
> together for the SS lanes.
> 
> Leave the DP endpoint unconnected for now, as both Aspire 1 and the
> Chromebooks (unmerged, see [1]) seem to have a non-trivial topology.

If I remember correctly, on SC7180 the DP is still routed through USB+DP
combo PHY rather than having a separate output. I'd let Nikita to
comment though.

For the patch:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


> Take the creative liberty to add a newline before its ports' subnodes
> though.
> 
> [1] https://lore.kernel.org/linux-arm-msm/20240210070934.2549994-23-swboyd@chromium.org/
> 
> Suggested-by: Rob Herring (Arm) <robh@kernel.org>
> Closes: https://lore.kernel.org/linux-arm-msm/175462129176.394940.16810637795278334342.robh@kernel.org/
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 48 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 

-- 
With best wishes
Dmitry

