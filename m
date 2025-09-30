Return-Path: <linux-kernel+bounces-837220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85537BABB93
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB07A3A91A8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF6C2BDC17;
	Tue, 30 Sep 2025 07:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OOut8Vw5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296A2222587
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759215782; cv=none; b=ZGt5KxfRG7deEk0G3sc3Cvu3sR/LX/evenGtxD6L9XO4TlL/c7O0dvDyim9f3erX77nqFEyYZ4NE69WJFp42EG0Y0uYHHusa1983hOjaZJeN4nC6FnOJXu+661eqcnac9xUh4sBL66ZuuvC/TWvQozJNIbQzbhZ7B0358+uOK8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759215782; c=relaxed/simple;
	bh=F1FiYxViKywIbSE573kHTnjfzX7LXToBGFkMvAHPD3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ED6ZXbJYgReGk2EO4RDHy6GKnxUOEz8bLLIEyqjz89pD7DH80rNHo4P4OZq0Bj/KgtSvVBU3gGU5HcVPgcAXuwSY8BMlCnCi+6lD5lyru3H6UrNegknYaOjYvdoPCjbdvF6fAEBjh94WB1H4x5heE6N2iInRnY4TyExc7SJNOQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OOut8Vw5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4Hft6017628
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ZILBarotSZWQdM56LLJz3+w/
	7JscPhGYyLjRbrYgdnY=; b=OOut8Vw5yYRY4OGq48yBkocOurdwvVdz2F1lCt6o
	k2gP3wjxwc5Aysiuye2xQK2pZM1ndn2A08UC2m1ielc6IQUggOShqqOGyiZXadlm
	vhpKm7dbSBDU+VPSb/YE0XhgUHTUEqZLq+3yacne2pSC//8fyBfWbXLFqhlG7/p+
	3BuJ7W3TU6nEUBTYIdkpFLp77cyYQwCxCvZnvHAQTNtd97eHYTD9YylFAH8sBFA8
	lje4KKku7gcJcPdVJwW/6MMd9qL14cPT+Q0IGW5rpts3lhEI4sz1qEwVj0bYYlKV
	RKee9WgC1CRvh3/JcmNlaoeiMIOrdP0vRyclmTH5YulaFg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e80tr2kn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:02:59 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4df7cdf22cbso73255601cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759215779; x=1759820579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZILBarotSZWQdM56LLJz3+w/7JscPhGYyLjRbrYgdnY=;
        b=SdgPta27NXrCuEkCN+CD9Tuf8i1wlxtl19j/lct6+RUr2WmvsID0rD2cZ3DdxtgOzO
         qIIDhFpTIwl5XYIqrKwkfDkRoW41O+jLdMcgE3dtOqfdHJzCsqClAsxvenGXuK/+9jmz
         1ZybHN5hDSCjr4dCDtdAR+b102wHldayD45N6FsPF1MeZ33cqQCtciZqZG1aXovOhweQ
         TkxetocgE/ChkyokwTrtvlPZyh0CRgEk1ySjVKkV+sI94HZWHba7oGKIXTSEkybfjQG2
         yfhQQF9969OayyH5Jk9CygWMyMt8STCHVSpCZ3/OUN4ugOPj7rUWjNkoCPHE2GToXzfn
         kj1g==
X-Forwarded-Encrypted: i=1; AJvYcCUFlsL98X2EMmm7LNrrVvnRAsWpWjy+u5ILJWmkaamLtMiaxbqy87V1JLLuvwkKeEtV3e5TrisichYNJvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXD/xJ/7o9iDt8I1o5niRwnwXKdqgfPHjs9MQu5VUemTbe0THh
	WFBX84gF6IKdNiz7mgLqq9ckdW+uNep2i12Wl4afo+BKo3K0rFKuVzxtoF0ysFLBP4aTLQB4lC2
	RovtZUp2cuTEwFHSX2lIvh44wEhrouJva1Vb1645ILvfGbtfI3k+s+SwRtc4uU5rFq58=
X-Gm-Gg: ASbGncuZL+M85tHW5dwX1OXdj+RD+9qbsxgpLR2NOeS1SzdLajjrTgx85agAVN/pGS0
	Tq1oNO2IbHCDCKmSnhtJ0YSSClKxAvMe+0uEJQXCD6Ov1w/Y1ljkD9C3tX6oePtws3ZuJoU487E
	Yj7gWLuM384ckUy4FONf4vfKOR1azdkDdcV3bbdGFO0FrJsQr/b7La3IXmRxNB+rGGaueSmZTMq
	S2NLZTN9XOMvfol7E44mZ/hINDiCqShj0uXdfqZ6Pm+0etO+XvFsJRTuO26AQ32j9iPghhPuRDD
	ULwLkuGGNvky6FK/T9NmacBZ8EpbIQ4bmyHaxbEryDw0olunKoVwqOHH/1CS+dspvJnUttmL/se
	Y96FtU7lWg+H7Z7dQD/JqeDGvgqPdSaztn2H3zakDBDUJwsIScQbK8s0/hQ==
X-Received: by 2002:a05:622a:255:b0:4ab:6e3d:49b4 with SMTP id d75a77b69052e-4e27d7c1b65mr43578501cf.7.1759215778785;
        Tue, 30 Sep 2025 00:02:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFA6lGjRTL6r8mC989qOKGIofS9wz03iYOMq+60qPx/pT9WrIKYNjXkEHiEux+C3IniYKpKBg==
X-Received: by 2002:a05:622a:255:b0:4ab:6e3d:49b4 with SMTP id d75a77b69052e-4e27d7c1b65mr43577931cf.7.1759215778195;
        Tue, 30 Sep 2025 00:02:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5839329881dsm4325236e87.87.2025.09.30.00.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 00:02:57 -0700 (PDT)
Date: Tue, 30 Sep 2025 10:02:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH 01/17] soc: qcom: ubwc: Add config for Kaanapali
Message-ID: <yhcqj3beliary34msn6zbaig7j4krn32st37g4n3ey7oipswea@ckio3yjuwswo>
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
 <20250930-kaana-gpu-support-v1-1-73530b0700ed@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930-kaana-gpu-support-v1-1-73530b0700ed@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyOSBTYWx0ZWRfX23b9rRhCTAyL
 90rT/PQlhDhYcEFR1yATOYPV4FcuwvQU4JWJu6QphC1958pInROop34ScPdgYv+HnH1UfvWtl+i
 RQD5UCbDnqFOuGIWdX4YtdPJ0BTXf7qkseYQDRg5LGlUjNMeDAw42Ggk/EiWgFLaUYk6HQxfw6i
 achCh1/RvpDWXp9Vq/bBPpHy3+rLVAeULd8SYGM8HM6kYsRt4WeNmuOCyNaxjK174IK2ynPu16Q
 FByejlDpxOm6qBv/FJ1Ki9OXdxlJzFZAS8TVfJ/qoszxDcHdgoD3A+ZmukYY4Ttvy34BU7fkgd8
 R3wSqNeFnRZ3SZ7RQQqNsb0KWV118v4rjy9e98LOaNQtk5MsBQdxcOiaEE9JnUHBZ3yPQTQWDKB
 shmLP3znWXBTDh1QsDzUVmfOSIZtmA==
X-Proofpoint-GUID: 2ZHB5j036PQ7-EVNL_XYh7XEQ00dbW0Z
X-Authority-Analysis: v=2.4 cv=OMkqHCaB c=1 sm=1 tr=0 ts=68db80a3 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=_QbXVIGTKPyQLETMuiAA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: 2ZHB5j036PQ7-EVNL_XYh7XEQ00dbW0Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270029

On Tue, Sep 30, 2025 at 11:18:06AM +0530, Akhil P Oommen wrote:
> Add the ubwc configuration for Kaanapali chipset. This chipset brings
> support for UBWC v6 version. The rest of the configurations remains
> as usual.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/soc/qcom/ubwc_config.c | 11 +++++++++++
>  include/linux/soc/qcom/ubwc.h  |  1 +
>  2 files changed, 12 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

