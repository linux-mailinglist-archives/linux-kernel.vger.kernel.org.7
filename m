Return-Path: <linux-kernel+bounces-830714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBEEB9A5D3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55F31B2700C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346ED30AD06;
	Wed, 24 Sep 2025 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fARj2G45"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ACE30E828
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725421; cv=none; b=Aiy4vD6OkYfAAoh8MXmTjpEHYq6QcXkZGd4F92o/BHrhF/gBghVy4BcVFoO9UAW8nhijmvpR1gB1jdOBdMGr0oqCQP4fjgWUnI1YnzEmdcFWTA8FHhOIfaZNM41vbsqJxdaLe5De+AUymQqAhuncbVZs0EQ28oZZsDc2Rq9wFfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725421; c=relaxed/simple;
	bh=2v58a2Ms4SzGlOmfnHzQTJ6OquVF8bjJ7gbAV/oLr/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vrv7QQMTuiBQ3uEjPq6v0Xd8osDUhdAKQItbiZE/lNB1B1gXEdj93nlML0c0IHKbj/fI7KxXy4y0K/b3M4rbP8xtraN3bCn85road6bPhTScxrMi4XNsd2l3HkpJMTBRp1rF35l9SQVoS4pE9W043DjREl5la9Lj8hoOvQHzDrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fARj2G45; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ODFGbX019923
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:50:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LOIwUpILHzWH2xAe7aoOnVRAWvWSgZKyb6P3XpLFlVw=; b=fARj2G45QTES3xF3
	dyIqhnpX2bS71VpsHfUetYxaCogmcz3MfySQjWE/ZAi9vp2NzOgULfu1DxXxGgwS
	hjI7e/YU2z5jQUPfBtxT2fK1wVuzKiAbiKtp2te1u2WaLzxmKJf+uz6YwpOSObr9
	xWJJekuXRUGl4dbyIt8ruaaltWCHbyylgQRTiulrnFxEKnqUZkOMt8/Yum66DVPV
	jlTZs85r4lmEMYVQ+MNtebRtnvztSoKbA/fG6Q60GfnfMYJaPzFufKYU3oK7Tky5
	mfly4svriCqsIxYG6s2i4ZOW7Ehi6zeHNMB4wM2qbuDOKIiyZNmGwA0hfYbIEBJU
	W9XsSg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bjpdww89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:50:13 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4d40407c6acso3869881cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758725412; x=1759330212;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LOIwUpILHzWH2xAe7aoOnVRAWvWSgZKyb6P3XpLFlVw=;
        b=am2VHZpFafAzd4PKFHVIVrCBpE7MaEYFpb6Kc1GuOKhJ5PVwekgKpvFP4+30FJE7qD
         5g+aVa/RBCUp4Dar6+LpQEbPeqTMy5KihMMHFeShxWDw3T4spTOY8jn0VMwMH3M5HFh4
         Rife72kR4xOwnx8XcDvSsuG4lfRFKmdtya92lCD/Z2GVXZgePKjmdqK2Il7aqk/7qZYu
         lV4QIuVJzjtR0tJChj++dp37oNFlbZkLu9+jvmDL7cnCJTHv61JlZSjoiwBeiuAzCdEY
         wecTmrSEuC/cjU0WA//jW2U7NEPxS4cvlL2Wg6bLyWj6VRTXd0SCGrJiPApzWME2upxx
         FoTA==
X-Forwarded-Encrypted: i=1; AJvYcCXvSa3NPlzIQ339q7F20jC6ScWXdIDjUs5Z5py6WHaLy17OO+u+cnR7p14HPF1e86vPP/KCbJw9gbhVK1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0NrV3h+ZkYP1ZRijoHRuWK5RevbX3TajrRvCDpwsTIT7jtK9F
	mLT2YdwexpQnLuEbwRafQtYBpPUyYyHnJSrS7MCUIoK+j0dRCTxZqOCKZtwoJ3JpfxocHTJAqJP
	ZVa/JWkt2YCRGJYAXudcPD0+Aky7tjypPp8NknlgvN5aCCodBmiwYTYD9o6CIhD8gWBA=
X-Gm-Gg: ASbGncvjaYgiRzx1jaOHQGcstzMnhNf3SL90F/OG4JPAd0glxokRSCsLImMQjjx3jfa
	ChoDIUL/3lLiBvdm44dI7En3Hy4onscIySvkweCH8blBtY9Doh3PuRKKlvXwXtXc1CtUtCmMaEu
	ugnELUOiNoAFCYVPdZEKBl1G3tPMFoxfC6yxMbfGaQbo7tMUsa34IbZj3WJSvD+yKxxO4WST4MU
	wcWcDpx4e1YddWVfN34H6eQlQxXRCpGoH/ISAgw+0SNQnRyAoR0UBg79YqxlbWsp+Jfp0OPZtqT
	yZOI2qCiwkrKxhCd/SbfsiXF+Qpd7RcXDJ0C/e/AQb5RzgSMzqNKQsC0BOXxJgRoF+XKNt7mUKO
	diwMV4dgxp39uv1IvjtAx9Q==
X-Received: by 2002:ac8:5d92:0:b0:4b7:a9cf:91f with SMTP id d75a77b69052e-4da4b0490f1mr104651cf.8.1758725411642;
        Wed, 24 Sep 2025 07:50:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/m7Ig+ntA4VCysUPYjwN26MObXEox0OR1XdnFAJSB9eyhSHSgSZI0IYmixSGdsHwEOjXGBQ==
X-Received: by 2002:ac8:5d92:0:b0:4b7:a9cf:91f with SMTP id d75a77b69052e-4da4b0490f1mr104361cf.8.1758725410925;
        Wed, 24 Sep 2025 07:50:10 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fd1102d7asm1582827266b.76.2025.09.24.07.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 07:50:10 -0700 (PDT)
Message-ID: <15c56c70-928a-4939-86a2-e7b81f1596a6@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:50:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] soc: qcom: smp2p: Add irqchip state support
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Lew <chris.lew@oss.qualcomm.com>
References: <20250923-smp2p-v1-0-2c045af73dac@oss.qualcomm.com>
 <20250923-smp2p-v1-1-2c045af73dac@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250923-smp2p-v1-1-2c045af73dac@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: m51UJYlEdxmZ2aa2_J7SBMh-ctgMeYkU
X-Authority-Analysis: v=2.4 cv=Pc//hjhd c=1 sm=1 tr=0 ts=68d40525 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Ficpkn55UaSewbb4THMA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: m51UJYlEdxmZ2aa2_J7SBMh-ctgMeYkU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAyMCBTYWx0ZWRfX10M7q9PX5raN
 5ba6baOs7xD1HNrrsGxpqc8S4EbNKvW11YGUxyoaKCXyvbVl6bgPkmAYAAUlzV+DzHfIkUY8GIy
 dyPcAKu8YXS1Zxm9hbJYeNPdE9S5/BXrQIeZJRcKcbhYhw3IGFOQvVPKZf/FBg5sDPhHiFKFyGw
 gUlHLOx2+7CZCMAl3rTVq31DQw50NTmhKabChgo721dmupTAz9SjSn81oUHJur+ijOSi58s2k7/
 +Z8GfHps/T/5thcG5UWOeKddhXthj0s2f2Fc3PN+xiu8K+5JSamMM4jaTufKPFbdym50ueKmpmr
 hC5eQIv4VWh9cFdc8CIbJ2MvGfkOeZWjugZeaI/xrtU6EzXarrsaUqaZ7RjjVlA1isUMuWk85iM
 pqcfWcw2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230020

On 9/24/25 6:18 AM, Jingyi Wang wrote:
> From: Chris Lew <chris.lew@oss.qualcomm.com>
> 
> A remoteproc booted during earlier boot stages such as UEFI or the
> bootloader, may need to be attached to without restarting the remoteproc
> hardware. To do this the remoteproc will need to check the ready and
> handover states in smp2p without an interrupt notification.
> 
> Add support for the .irq_get_irqchip_state callback so remoteproc can
> read the current state of the fatal, ready and handover bits.
> 
> Signed-off-by: Chris Lew <chris.lew@oss.qualcomm.com>
> Co-developed-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  drivers/soc/qcom/smp2p.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
> index cb515c2340c1..e2cfd9ec8875 100644
> --- a/drivers/soc/qcom/smp2p.c
> +++ b/drivers/soc/qcom/smp2p.c
> @@ -222,6 +222,39 @@ static void qcom_smp2p_negotiate(struct qcom_smp2p *smp2p)
>  	}
>  }
>  
> +static void qcom_smp2p_start_in(struct qcom_smp2p *smp2p)
> +{
> +	unsigned int smem_id = smp2p->smem_items[SMP2P_INBOUND];
> +	unsigned int pid = smp2p->remote_pid;
> +	char buf[SMP2P_MAX_ENTRY_NAME];
> +	struct smp2p_smem_item *in;
> +	struct smp2p_entry *entry;
> +	size_t size;
> +	int i;
> +
> +	in = qcom_smem_get(pid, smem_id, &size);
> +	if (IS_ERR(in))
> +		return;
> +
> +	smp2p->in = in;
> +
> +	/* Check if version is initialized and set to v2 */
> +	if (in->version == 0)
> +		return;

This doesn't seem to be fully in line with the comment

Konrad

