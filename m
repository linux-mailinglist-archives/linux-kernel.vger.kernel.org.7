Return-Path: <linux-kernel+bounces-798154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 577DBB41A18
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4EDD1BA36BA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B77B2DE1E3;
	Wed,  3 Sep 2025 09:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nQebEawf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A2026E6F4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 09:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756891892; cv=none; b=SUPQYeo/LXvtmOh7HgFuT6z6yZMiyCDZTtUzk7DE36h2cW37f2ghPjo3AHSleZqPCuBVwSlEucO172IcinpHOqLVD5XxOjgQf77lf+jcQmFXVSt7aPtguRfy1bzdm/eIrS32g55j8H/V1nE3KqtcAxaCu5zgwnqXXamGkyz1xGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756891892; c=relaxed/simple;
	bh=6Rj7ZCcgFaQLZFfPj+MoHP0Ic6ExqyawNXwy1Rm5OpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHxKtGnMDdbJAEiNOhgKitHiN2wSAthVP1dURMnQA3hcmnDWgC3d1oJeuM+XlX3Q1kDloSCRn7eo6XYDH0IZubDTi4bzYyCecbLBuQLtaOdCgD502yRdogWWjq9BFwB00kTzczoyKoagQaROr7hPhn47xCN/Gfa4qfR5VJVLjLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nQebEawf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5832BI0M025291
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 09:31:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R11J2ZPvgur12OjpaY/ZBN77+0uB5Jyxu+Du4WBbtJU=; b=nQebEawfeJJnuXoR
	oYb9e0BDMX88zWnTCjsF7RF6K4CiWoG0eQaks94P1AOzf62xoxfRioKg//b8fT9X
	fP+cikewvFXxRHKyqCKbk6k9DsvyB/DbI679LULgbnnA5SDlCQvQxR2ywD+EtRFv
	dfdRvo4+psm8oJqYiISEjExTEU2olybDvUQT+EkvatX1rAakhNK+aFUDlaHAxqgS
	eGnySm59KpzSp98H9OMWwvs9kKvidnq3ZHMIMTDmWxRZzcTh7+XO4FilZw08cXEe
	g2sPvJq5lY6Q3oxlKed6nJ5bG8voYlnRsi/0MOfmZ5IaHVbDBalkp7eeI2Cv6uBU
	BBhlYQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscv34q2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 09:31:29 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-726a649957dso1650746d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 02:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756891889; x=1757496689;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R11J2ZPvgur12OjpaY/ZBN77+0uB5Jyxu+Du4WBbtJU=;
        b=TT7dvMrJbfztWGq4RLJrFHAdAURAn0fltfeNNUuMCq5c0x6xwO/Ze5DFey/yXXkGj5
         RaNlF+f46viyBGlY2SYhi5Qh8ClUsk5Y8ZhCpyt0ZoToOSLzonU6G++2FcBfql/tgl1j
         OLwkLqHo9hxh1XU8ILxg4qZ8j88LX9r2j8/vTQyla+GY0pmON6ahHyB+V4+6HWV0ktDD
         rHL69DkIbQb9JpqYtfL4tzpa/e10Iy4JhTkK2QjyrZVlHk5XIhEY9XBKuzO5JqIuRAps
         +PrIO8MVEXfAfX2EPJCKkFvzIXzhir+qvpaCS5yqrkwM5KhdO+tEDLPW141x2sjAxJiT
         PWeg==
X-Forwarded-Encrypted: i=1; AJvYcCXHE2dGOMvVEmE/DDFQK+2OCyhrZg3veBEw4g9qbxaluARWkhM3s2SINq166aCVTQB/y6T8WnagZxCbrns=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQNiMw1YbIawGX1Ein5KWtF/raMNG559YtcJ6ZMhHigGguxb7P
	HQ7cppIEmGFCo9MVP1vZm+OvPgLQkjaishxFJM36jbLeM7fBPLMto2VGqiJ1eOD0QVULx7BUF/S
	bFsxe0zrSqyvXXPBgBhvze2r9CIkOZSF3XVA7OUnNp8YXLV3K82y6oCBehQcitIThA3I=
X-Gm-Gg: ASbGncs5fLYtXdhPsDSpF0kNWxEG1QlVQWH77TPcH2Y6sTa5Br+1a5pZXdBHmVApSF1
	StEwI81HsI0Ojsp5XMjwy+ve0ZfLvFjEsCXwjSBjOxArR/JCLmRIaNj1PvV8zVmCsCwrBohVJRs
	O3SF45/Vjk300u6e+O9wYflZ4Jl5yk84Nb9yvaSsNENuFvnD8wvBH9l5vgegEb52tQnxANfFIdO
	JOvDWjXwUZWkY5DOFxLty07/knh2YgQxYBI+kN9emIdwkeV6X2u9k4HQAtMQppk5Qx8UszZF/6w
	5z5NLCCze0+fWxuwMTq+oBINpDyLM01DPl4YgyNs73/I+mvuzWv9x0aifoo3gUYyUUYAguGkpUb
	pYGuD2uwZh9E06NyS3uSQUmH1rsYL0+JXzE0ZmsUSd5rRPYVFnqAa
X-Received: by 2002:a05:6214:d87:b0:71e:d4f7:b43c with SMTP id 6a1803df08f44-71ed4f7b6fbmr81039276d6.18.1756891889163;
        Wed, 03 Sep 2025 02:31:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpn1OxrJPfcU6oHH4NoCR91bC/412PrDtsPmAKHu53l4V9VVcrDS9TC7zY3OUCJn7dGPO9ng==
X-Received: by 2002:a05:6214:d87:b0:71e:d4f7:b43c with SMTP id 6a1803df08f44-71ed4f7b6fbmr81038866d6.18.1756891888652;
        Wed, 03 Sep 2025 02:31:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f50b0e98sm9071431fa.60.2025.09.03.02.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 02:31:26 -0700 (PDT)
Date: Wed, 3 Sep 2025 12:31:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Gaurav Kohli <quic_gkohli@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jie Zhang <quic_jiezh@quicinc.com>,
        Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
Subject: Re: [PATCH v5 4/5] arm64: dts: qcom: qcs8300: Add GPU cooling
Message-ID: <tjdqt4pgagy52xncrqk7dkjjpsfqukjbthrgpddjatfkd3xd6g@7vglhah32f5x>
References: <20250903-a623-gpu-support-v5-0-5398585e2981@oss.qualcomm.com>
 <20250903-a623-gpu-support-v5-4-5398585e2981@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250903-a623-gpu-support-v5-4-5398585e2981@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX7SJ+xLhrfEL9
 CTS6AROUF5zzPl2xDbMFqlUiUscZ3m5BeAbnZHpTYhRzooSjJsYx1Os2yz/BAQbQRw19HDuHN2b
 BJm29RsPG6oWkvIxWGjJzBQOz3NAazjWylKYbGOuw0w6KdvSu6tqOTkAHldffy7NOrcPpze8Rdp
 S9iU/uTmS1dWQdoaeJDazFipZi0eH8O8zLpl/REXJA1BWgdgR+rGnuQPHEhEYWRChBl3kS6iXSM
 sZOC5qRsp/dBQ7qhjRI+38nCBNvRJ7r0CtrRlard4GXZcUhEqBm1kc0T/ISUt00N0/XLcxvkh+x
 kV6DRywsQNXurbvPorPK7Tx7P/pO+7KSYzKHYHkCzkCFxbznBLL7turslAmuUZt7fgNubTJbxch
 pZ3qGFJz
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b80af2 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=8h3n1EBGBd86Ebf8828A:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: sC-mIyiHpwY394eQLHOhcJliwf5Ralrv
X-Proofpoint-GUID: sC-mIyiHpwY394eQLHOhcJliwf5Ralrv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031

On Wed, Sep 03, 2025 at 12:49:55PM +0530, Akhil P Oommen wrote:
> From: Gaurav Kohli <quic_gkohli@quicinc.com>
> 
> Unlike the CPU, the GPU does not throttle its speed automatically when it
> reaches high temperatures.
> 
> Set up GPU cooling by throttling the GPU speed
> when reaching 115°C.
> 
> Signed-off-by: Gaurav Kohli <quic_gkohli@quicinc.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs8300.dtsi | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

