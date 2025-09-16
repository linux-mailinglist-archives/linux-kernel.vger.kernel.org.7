Return-Path: <linux-kernel+bounces-818645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C73B59496
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 287651891604
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB082C0F7B;
	Tue, 16 Sep 2025 11:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hWrnFyFJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964752609D9
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758020481; cv=none; b=KjSLkc29GWfQYhwJcCcVHaIB2GmfA4iFAKuimZGULOmbLPJIUANOUfrmJzzmd+QCwpf1iNdn7Ufdhd9XHVmlmfXaJ3ds6UOkl8PTLYLW9CAbKz82iASeNeNmx1OTRtzbJmnObEIRcYwXbM1Db+tnTIANRFlwtOox6Ma3uB+YEKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758020481; c=relaxed/simple;
	bh=NCB9zn+1OoC3HfwDpn00j2J+X9Iiwehic5Jfs6gBc6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRr0DbkNKK2KHZ5lF4VhkCT/18UBczC1hZCYNSGiYajvYh3ms/RJ/9EY3aN/RjQvUlO/hKX1eqQtjuneWJ9l3S036Q6rbVBqxF6q3yyGa5hxwyi4AM1aOfjrjIxqlzFs4Jb7hyK63o9EgcyShJufEFNXqbLRqPMoEQbkIxrn+tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hWrnFyFJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GAKlu1020394
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:01:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kVUremSztL9SXw9vrpclbs+f
	CQ2ClcMRdwOTbzI7vMQ=; b=hWrnFyFJvxm6g+Lift+rgcEvVLmDxPebCs81lC9V
	M1SQ2Du/4aHvWlV+iYY6FitiLKOefbQSXdy3nQ4KgUkZX1zgfKNn/5CymZVnHPQf
	/ZDFCruMcP1nakG0b3973jNJKnLj6vH0culupLgKoSXM37wK3mhSwRXU6tnzDrpe
	j08KJUyTXA0vp9yPWyA9+RSsuEWQAFIcdaAsJJCSWhdwUV9+5lSa8DWKelV4kcfU
	bymx4QqGW8+HCmDYZKDZx6nbM7GxcrX56+JMfUqSgjria5FX/lMhCo9b5rgAo/Cb
	Xz82PeTIxro8i9Ac+C90NeyZ26Ep+Fti4W4/GGeu/Dzz5g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4951chghn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:01:19 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b31bea5896so62327851cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758020478; x=1758625278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVUremSztL9SXw9vrpclbs+fCQ2ClcMRdwOTbzI7vMQ=;
        b=ochhAcNtiaiyxJp3ILxfiY5wazGaFuj9H7lW2EIXYAmnhdk3LwwC1QsWq7UsY66K1r
         QO4c88CVRZ92FRcfRzxdZPEV6URC1v2VLhIGG7peljHgf6vcuW3SPye5aC1/DK1e488P
         UesXBCV76Y7kr5MuTp00u6y1uicQJ/CdeJ+5DpwVXAxROMfM40PH7Y1PcQU2TH7aSp7n
         YSEguwtVCzH7yo2r5XrWxqfd9Tq03z6H8RbxFE1XX7Lr27veYFilmPWc7vU1BnJJl3Ed
         iMXAtI1nOmRAWlqtQTn+jRTNeFU6360NDjXdEPQKvN679trdzLyv9qYHZIKrzKm8cJXW
         9qrw==
X-Forwarded-Encrypted: i=1; AJvYcCVnOCAhXW6B9xtK/q7GrIV2TE3SG601oHJQmbvfJ5AoD9+eXH2bTUQ0zJubgnJSc2jvbpLzMiOGBdsF6t4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzDKBjj4vODyAkK9gLXx2gYDBD/p+pDvFQ4s7udydyMSOh5CmJ
	LN5xD6hZ/aACkFQXjNthAUko5vG77t9zpWMgvUdLt7HV/7vV6RsujEw/09GNEmYz51D7C+JgBFH
	yJr7UdNZxV9iw4kAS2ROoTxxKr1vV5o7fJIR4dzeoDDw832yfVjsrWs/PtvvVfZGAPI8=
X-Gm-Gg: ASbGnctKd2GqeumkRBayYktWIDrgiVvylZrmO5iPeY8Cua3urvNPbmbLHPtM91xhZQl
	q7x4Bpqow57cFsA9FO3X6CjYVFGCDrL3+1fKt0cMTGl/ubiaTW2GLP/niVbxkrtbN49eunDKQyD
	FZSU0hNucHZ/e4A4/pwjJ9ghXFgjqbzVCN3BiMZL882NnkyJQhukcWMVP9rXJ1ZxmHS9P3ROpaU
	4vD5GrSNSyNAgM1MaqtqOWoN6gj8rqD79ZCEYDZjJsjcBiNGBbl0lZPN4whL1cN4QNvLwF0+TF1
	qL3JbaxbhFfhn830u+elfVTpuop5nfcHgQW+qT0FA2sXPsnpSAq3q3/X0Su7is+9d+2SdnYFJkq
	xKwmxOgSIXvVy9F0RGny+vq56aQPm09mwQtO8nkXQ03hq3XmDA0Bq
X-Received: by 2002:ac8:58d6:0:b0:4b7:9313:a35f with SMTP id d75a77b69052e-4b79313a964mr132544321cf.2.1758020478173;
        Tue, 16 Sep 2025 04:01:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLAF3UeE0KRBiIqMl1GqNbWZHZDnQRL51kIuIAuObbsA7nu8iKYJBvUfO43iyEhrcGCg745Q==
X-Received: by 2002:ac8:58d6:0:b0:4b7:9313:a35f with SMTP id d75a77b69052e-4b79313a964mr132543501cf.2.1758020477568;
        Tue, 16 Sep 2025 04:01:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e63c63cc6sm4391757e87.66.2025.09.16.04.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 04:01:16 -0700 (PDT)
Date: Tue, 16 Sep 2025 14:01:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-i2c@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Subject: Re: [PATCH v5 07/10] arm64: dts: qcom: lemans-evk: Enable Iris video
 codec support
Message-ID: <uega7zdkprvk3ediiu4lykiukf7iz2wgk56c3pdloqrpzddt2c@yc37f6payhca>
References: <20250916-lemans-evk-bu-v5-0-53d7d206669d@oss.qualcomm.com>
 <20250916-lemans-evk-bu-v5-7-53d7d206669d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-lemans-evk-bu-v5-7-53d7d206669d@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=eeo9f6EH c=1 sm=1 tr=0 ts=68c9437f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=yPPeNZB_paKBOZgJB6kA:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: gnsTYf0EyDvaToSoRlTFWS5C9dq6HBrr
X-Proofpoint-GUID: gnsTYf0EyDvaToSoRlTFWS5C9dq6HBrr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAzNiBTYWx0ZWRfX8cgOGFHmm3Qx
 ZudnpIoBMqk2Avx0/QDJW3e95Scr91VxJcrIhFKPAYiJQE67qLWdrQIY66xe7mUbsPvQm7iSuRA
 orjGzXfx1u4FYeem0esT8fTb214d/tNyfYb9IxsyVjLEhZ2wsgAXCyFt4grvkWhMgH6Jv3gtpHJ
 n2DAsu6c3Dos2s1AtFFUG/3myAhhxbawflC/Am4JRvYAALLy/wyNV/8J0gSR397U+4SrL0MrzQb
 NFRxHn/VzdOKwq85vTCG1WpdiNc3numIS52yv6fJVvXeJ7jdTjcM5eb5R4d9lq6LptEkVMqykEK
 Uk91aFYQTAdz8weVeW5LLBQw8NU3DHx969j4Q2tUfwtRDtRL21ubwci4pKQUakxNXY/kUE0W7qV
 qWU7w+PM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130036

On Tue, Sep 16, 2025 at 04:16:55PM +0530, Wasim Nazir wrote:
> From: Vikash Garodia <quic_vgarodia@quicinc.com>
> 
> Enable the Iris video codec accelerator on the Lemans EVK board
> and reference the appropriate firmware required for its operation.
> This allows hardware-accelerated video encoding and decoding using
> the Iris codec engine.
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

