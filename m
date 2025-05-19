Return-Path: <linux-kernel+bounces-654113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E1DABC404
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 18:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AA573AEABF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 16:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2284D288C3A;
	Mon, 19 May 2025 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G6ILHzI/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2222B288C1A
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 16:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747670798; cv=none; b=tmdRO7Vhrimm8aqxvUoB/nSq2BhAx3JHnLxfvvbXD4hOM4OqlgL2vcLPDor/KY6B3kADTkardwRrm56X8jM+/cKNTS6veMXrI/bikBrfo/DKXjREZ7CGdN+mHlGrtdKCdklEEDhQ64nP9D0rjBwJnbKJhydVEZAkqkXSpWvoTJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747670798; c=relaxed/simple;
	bh=TluCJ+QE27SqsbEyuiqmlkaOj0JcS37taUo7hHpS8vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=leBBdanE/avcphM4H2zCotbiEghAb29jzmmL6uG5UFFnXDHkDRroxB8Nq6d72ChteKrEUG/x33s/Kp4pyi18AtUTTAHs0oZcT1OVHY8WEwAcih2vCeSUfS50lcyEsyVtru+zF0iixZFzn5yprLe9RKpfUpYWegqByooDQhPWgJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G6ILHzI/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JDUl2f008303
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 16:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=pCInV1QBCyzl4b6q6TN30j8i
	Ig3ET3mzjESHX804HKM=; b=G6ILHzI/FXwbRN4wESyPXLnJftX77rHjbEO/llOq
	6tzTNktXbKIRbmyhExsSWNa1kCDmQLitrNK2bwNOhPhxYtrqdBeQViGonsL1vipp
	ZmwOxHeOk2IZa5pmkCpOf3bduSfB2uwCAsmP6VapJQV78jKcFBHmwxvYDRLZ2rvP
	Y4oUMhbD8rtzyJMlVp4PmwZeZeSbcKHLnOkhchfRMSFGTisemiBIxLTKGGLhFmz+
	ze5sNB9LnTJJw+vlW9UCJBW2DjWi6DqizyYg/CQNORc95BOni5p2NW7fkW+2TuZV
	d3ysm/dRaFVXCfLRV7v8J9EV3Y+eXvoNCsKsd++ztA7R6A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46qybkhnay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 16:06:36 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c793d573b2so857800785a.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 09:06:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747670795; x=1748275595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCInV1QBCyzl4b6q6TN30j8iIg3ET3mzjESHX804HKM=;
        b=o95oxWvr+BqYvMpqPd52d1F7/BKX05gKaOFtsUzZ2l5D1NUAd6nxRvwrA0Bddoapm3
         P9lQAIpYvk8Y9kVWHivR4KFwKkF1QVGg15e5Pekdwa4TT0BQgTAXKFUvZQ5EkNSI9lHn
         cHx2x2dOUvOYzRU4RVynfGL1DiTzIU/RJpMMQT/H/Z4jlHO3c1ZSUbl2ahFGIjCt9Ky6
         hAdQVAtGH4zomeb2MuwyXYWBRgKvx7ryQkdTqWucJ+lSgucDm1FGNJOocQ+rHyD0wbsb
         LBDQY8ZdkhkWWxhpVIopJZ9S8Pmg1u4Pzwh2AWo62Vap6clYR1w7uKXZdAi6/kKWhH3R
         X0Rw==
X-Forwarded-Encrypted: i=1; AJvYcCW3c0qJopKkoXmYyrvHUS0IRZgJ7uYYCSiQ8EUEK//iato1nGoaOsLbSgVTk8FMh9euBbr6SETLtkS0SsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwErqH/0hsejuGs0kcO4fd8Qb8Me0C7XUxhTbuhYLakH569j1Aa
	Z+8WbDesEbnhWeYZscG8tDzXYnpv7QDrE6bn0jrcuTxl9LgXUaqIx3Hd7Ct6ucJmv3cZL6HstWm
	cZcTRBWfDMhN/w3rMUjwJBBD9yflZzSxVFYAUXTxkvyIOiv9cykAwsU3TyqA+ltKMSSA=
X-Gm-Gg: ASbGncsF+fD52BmHUwF466c1HzgADPvErQOPNMH1QPl8uhcMSaQ8rPpsEAi0xiHG1nD
	3ERYjAyp00h1SPrywN3PstWH6lTKWFrnn15YN6Sbv523OpAXua+vCwtJ0lDoId1bcC98loF4j+G
	iXBhrmp8KTRs6whzCDnpF+8UOD0UKQk108nyPzilpEQuyjZGP03W7EuMORjO86Jy6+sUpO/wgvx
	ocaFvfVba3tlG64Z/D6PxNF1uwV/RTWjhApX0y1yaNXVqMTxtSmztXv8B40PucYwrNdWfPWHbnr
	4OcMQl+dYUWoQ/9/z225A+OhWezpA2QKNL5Zmxt5HyjvU3vQecWXZhWsx9LQA8PnYMcnCWHfCfs
	=
X-Received: by 2002:a05:620a:5e50:b0:7cd:5090:3319 with SMTP id af79cd13be357-7cd50903498mr1489186485a.50.1747670794629;
        Mon, 19 May 2025 09:06:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMFw5Roez60YZW75hF5ZwRt982I58W/G/fp9+fvjelzz4QBS+enmm/pZaPsaXJOzOWO1lQFA==
X-Received: by 2002:a05:620a:5e50:b0:7cd:5090:3319 with SMTP id af79cd13be357-7cd50903498mr1489180385a.50.1747670794160;
        Mon, 19 May 2025 09:06:34 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-328085ce31dsm19233651fa.105.2025.05.19.09.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 09:06:33 -0700 (PDT)
Date: Mon, 19 May 2025 19:06:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jie Zhang <quic_jiezh@quicinc.com>
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: qcs8300: Add gpu and gmu nodes
Message-ID: <t5jk3gmv6gxy7fhr7nbj6wwnutylsgenhepae7im6xqn5udys6@65ysrfzjakhv>
References: <20250508-a623-gpu-support-v3-0-3cb31799d44e@quicinc.com>
 <20250508-a623-gpu-support-v3-2-3cb31799d44e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508-a623-gpu-support-v3-2-3cb31799d44e@quicinc.com>
X-Proofpoint-GUID: -IlQEHRVOP3_D1-AISbCDwia2HFmk_Fu
X-Proofpoint-ORIG-GUID: -IlQEHRVOP3_D1-AISbCDwia2HFmk_Fu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE1MCBTYWx0ZWRfXwSikkLFyT5K2
 EiVTwI3wqR/x0N7Q6SYFB9Ff59QdnDFBCx46ONcKSF9NzsCa34+qPeZFBsnNaJiRZqOxGrLzVHx
 mYx6qLHKH1T6Awpz/HaR+l6vwF5po+Rc7H4ZdzhZC+C2km78z/TGTET9BK6Cs+4ULT0RcXX+EmN
 NTS7keTfifxZRc1Xlu9T8IemuzFi9I19ItVfGwk2ugF2J/VSnftChMTb/Of15+jVTDPU6yOi3WK
 b8saP4nXq64Bt6s9MyvR05uDS1YRuMDFyp3/Lzf1YycODlC96JXXrbVFKJw86WFTIGic8W9O7OS
 sYX79GSFsWycJxtQD0NfdIzggFEhszvAOTxOER/BaoPiNy6zLG9/rp8FAw2VLcUHzpYG9m56axN
 5ca0iFZer0eZQQ1NCsQ0J/COyxGFbrf4OUo4unnpZ2uR13ngoRfLz0AITPdX9FsQXLihHAlf
X-Authority-Analysis: v=2.4 cv=RZeQC0tv c=1 sm=1 tr=0 ts=682b570c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=3Gb_2g71upWOQPDw1swA:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 phishscore=0 mlxlogscore=664 malwarescore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 mlxscore=0 suspectscore=0
 impostorscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505190150

On Thu, May 08, 2025 at 09:49:20PM +0530, Akhil P Oommen wrote:
> From: Jie Zhang <quic_jiezh@quicinc.com>
> 
> Add gpu and gmu nodes for qcs8300 chipset.
> 
> Signed-off-by: Jie Zhang <quic_jiezh@quicinc.com>
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs8300.dtsi | 91 +++++++++++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

