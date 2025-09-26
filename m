Return-Path: <linux-kernel+bounces-834140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B50A0BA3FDA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E58E87A99D4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDBF2FD1BA;
	Fri, 26 Sep 2025 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hg2wO8C+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9B92FCC1E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758894793; cv=none; b=PSj0i8BOnQlNBfMmY8gxoztG1CYHAmrzGaqSVO3UkltNd/tNM+ZqyUdfT02eGBsh7o/NMJOT1HYOghfwYQ/rNJtoUM7evgqiL2ubJBwvNDvaBQWhwhUgvNRqox9L/532RLY2yHL12eFzFAK/JmFVUROvLpLjUXt4Y+zjxUEunuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758894793; c=relaxed/simple;
	bh=cyvgMnnP3LY2SVnviOoMKhwzZV0UGO0ZVHTIbpXE9RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlBaQQV4xGBbLavYlnIqm1LF9fjqc+9rJzdFqUV4qca/hntkhNq3yTMgZnJ7fzEBOSCSD8Q5jrFC+SJgX7/hs6h8XyMtGugHvGNGu7xUPNrxedEqnAlnd82GpQrd5/HIbgfTqk+iaEtgWgZsBOEsLldgfmf4cPcD84Qqg2+0FyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hg2wO8C+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q8vbHA016009
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Nj2RnivyVd0n/WCOVEL7yqPG
	a2Dwqhx2efpqU1IBZH0=; b=hg2wO8C+R0urRtBfZxtj2aG7BOq4ov0hngmLSsaO
	X5KuzdguO8iTvI1k6mXqGMiRPYJhwB94qyXgwQWNc541Kz9d66RpEXEz0bjCYVXT
	0GO4tHcML2p8xnAtjveHkOLeCRCbY/FFYtvoNPnggr3izeH0iDy8t2Iumh6RbF7Z
	f+jLphKHo8upBAAeyGYNhpDo565cesigtjO92ZjDLPYo6Ty0WTGD8Q+uePLX0jVh
	ZWCSJmRKCMrSHOMcC+cFW8ZleEqi7inzPWqClG4zSHQZmI0YUPF87j0ciz/qN+qH
	vyYAXw2tlmrzlvWE1AbAXFTf1CEqoRPvQRhuba1yuwBANw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0rk27y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:53:10 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4d7f90350f3so46470941cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758894789; x=1759499589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nj2RnivyVd0n/WCOVEL7yqPGa2Dwqhx2efpqU1IBZH0=;
        b=bqSYoB1GOAvJJAT8AKcuIOD/TT4LPDs3woEeLwiWwQ4xJcAxwc1Jvzg6+s4or3hZbz
         2eDCWjVsSDl4Q3lBOTJm3PdXyszLUZU6yPrJsYWIoD6OlHa6z4h4Ub2I2N7IOMwaXtAi
         Xc9eEI/YS7OTK/a3rJhPpiR2LF5QK5gmzzzaC22lFwBfRDTKTeCjjZqaF4PUAApfYSz5
         XeN91y4yiOuBJYQZstui2ExfDR+xEJ0OmVWXUGamh+Oy12hliFM5p7tpFrK9CucPTwDs
         Y3u8qOufG84jOoCiP1bGwQtfKVBP9yMqMpcpag/0XsoqOEcPfk9NSxd7RKKisur9DD0G
         jKBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9mMEaf9iPth5Ddk+SPkh2SDkmqDSoyd+Q6mJQ/XYmsiI8hq/MZOAWtCITgW6qgxGlZA4i3fJIm7uCJWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUlWlS94xUJ03Xoj8ROEm7uDMamnqwly+JKP5GueVI/0t0YgkY
	6pDuu8s2EX71UiwODTOWw9nPGfGqzsbaGXTM4Tdy1T8HDowVEtGryoQtpyv0NMogHHDUUzaV9Qo
	VnUNwFt6SA1hiXY0BcXy9loitZQ0Tlj92hXymNYj5ZOgfQzICt5JwD5MK/73+rUie5F8=
X-Gm-Gg: ASbGncv5XtM4V5zmSTc60CXoTidFJEHB1OFy2yjckixNH8JnClA3JAdX2LOugbBW5oN
	rBfExoh7u88LCFJMev49+z54F28VoUxqsoNuHxGcr3bsd+f1+Hui/k4T+9tODm/my0Ew+ubsPyf
	qMyKmg59bETevy5j7JkF/fsS3S9aYlfSS0KR0h8IakCEN3567JWuaR3qQBMpKPGWLmurrQT2Sbu
	LYKlKrq0J1d7w97lgRZaU0brz32kvr4MumyIrBucCEdI6CEQTLzqkD2r1X69lKfU3vSfyxo0Rzw
	PWIzW44TZNtclvUk0tqIc5ScO2UhoOKS/TynMC1E15Q6cQxWVjwM8F8jxM7eU61nzyJ83P5uAgv
	C4MMuzOi8H4eaf8+N1c2Vt3OlG0O7S5gszgsSd3E4YU1bVVWhWWa4
X-Received: by 2002:a05:622a:1389:b0:4b7:a1b6:cf29 with SMTP id d75a77b69052e-4dace86b1e7mr81075571cf.41.1758894789342;
        Fri, 26 Sep 2025 06:53:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMoJDS8aWtbyVs7IfWYIbTpQ5DxMdjd7gKuy6V247TUGZ3bJClP3qwuMmbDr8kW0U3F2DuOg==
X-Received: by 2002:a05:622a:1389:b0:4b7:a1b6:cf29 with SMTP id d75a77b69052e-4dace86b1e7mr81075101cf.41.1758894788737;
        Fri, 26 Sep 2025 06:53:08 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58316ff55acsm1846590e87.129.2025.09.26.06.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:53:07 -0700 (PDT)
Date: Fri, 26 Sep 2025 16:53:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mani Chandana Ballary Kuntumalla <quic_mkuntuma@quicinc.com>
Cc: marijn.suijten@somainline.org, swboyd@chromium.org, mripard@kernel.org,
        abel.vesa@linaro.org, andersson@kernel.org, konradybcio@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        robin.clark@oss.qualcomm.com, jessica.zhang@oss.qualcomm.com,
        abhinav.kumar@linux.dev, sean@poorly.run, airlied@gmail.com,
        simona@ffwll.ch, alex.vinarskis@gmail.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com,
        quic_riteshk@quicnic.com, quic_amitsi@quicnic.com
Subject: Re: [PATCH 2/4] arm64: dts: qcom: lemans: add mdss1 displayPort
 device nodes
Message-ID: <kxy6p3fj656utoubj37ujzycmmszebmwb4c4u7zkb7t46ddwuk@xwg3xht5elj4>
References: <20250926085956.2346179-1-quic_mkuntuma@quicinc.com>
 <20250926085956.2346179-3-quic_mkuntuma@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926085956.2346179-3-quic_mkuntuma@quicinc.com>
X-Authority-Analysis: v=2.4 cv=dP+rWeZb c=1 sm=1 tr=0 ts=68d69ac6 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=jz6_z25kcqxLI5rURXQA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 7SXnP1Hs_-IindMroO4yQ0pU1otoapgn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfXyP+lql+q+h+L
 Zp8EWgQb5mcGlPVYQwqZ/HdxBwRWfRoIa2hsqP5q2r1KTrGkzCAMU0FVS/BcJ6HXdLRo4IRdAR3
 puXWX3PHukBMTXL3l0DHs3Aw+nI1/hUiB9D8mh91ajPVds6bfTZqHf927lbTgdMoppv5aMYaU56
 Cjuy//mBWiEemamGPPAtqowQrhXRk3A5GFmo0f7rJHjypMRYKH6xmI7sOhNLebe9TmwmdYfViYz
 LuFNrgrMv2IK7vaRYTKUt2stvLWKfzySdL0xO1EvaXsuyezPpSWnOs2mLN6/YrxPP5zg9bvveFj
 XK8OGmzA5ub7fZ7wEWw0VWQU3PrgQ29o+qlVWQNCqX1WFw5GHJnmh7bH26ZFkQPW/xyFvlG+sTX
 UbP1blLpzuvznZjjOMfSA3CbH5V49g==
X-Proofpoint-GUID: 7SXnP1Hs_-IindMroO4yQ0pU1otoapgn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_04,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On Fri, Sep 26, 2025 at 02:29:54PM +0530, Mani Chandana Ballary Kuntumalla wrote:
> Add device tree nodes for the mdss1 DPTX0 and DPTX1 controllers
> with their corresponding PHYs.
> 
> Signed-off-by: Mani Chandana Ballary Kuntumalla <quic_mkuntuma@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans.dtsi | 245 +++++++++++++++++++++++++++
>  1 file changed, 245 insertions(+)
> 

Squash together with the series adding mdss1. There should be exactly
three patches: fix for DP, addition of mdss1 to the lemans.dtsi,
addition of mdss1 to lemans-ride.dtsi.

-- 
With best wishes
Dmitry

