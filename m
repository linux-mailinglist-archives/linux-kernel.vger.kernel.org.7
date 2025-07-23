Return-Path: <linux-kernel+bounces-742377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48075B0F0E8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65175583653
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793BF2E11C0;
	Wed, 23 Jul 2025 11:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SGGBfEPr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D682D9EC8
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753269036; cv=none; b=S426diNWLe+ezwM/9gfoSvUgAktSbgiZY7oDYEi+X8BtJ8dcfKxBXop7BnUE1rtT83fdO6dO9ezqsY/ZuJuJ0hbsJArKb9BN6z1rlw4LovNC4Exz/J9wI1Bl8fUsDj3cy+x23QP4LYO1luJsdghr6v0f4ZW8e+cZ9cx6W89y58c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753269036; c=relaxed/simple;
	bh=XHZNcb709QsG2HbbAkiyf/Y2zrRKN0Tk7Rb2azhNs8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEMpr8mUH8jf3sazZQQXRP3VCb7kVNUC1r7fW8EZXroV5EAMiPOao/FdVNNujIN3HN0sXCbINv315FPJVxznFX6rLnGyFXoc6TztXiGC6Dcdt+1oRrQC9bnt7YZ839VwlzO6vBpCr8TfblqAuRi3cPxnBQazbbeEnKmcnYRI5jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SGGBfEPr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9ekd8007879
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:10:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=o8v/bH2NBjx6+BJ/r65MfwKr
	xmq2wQHUa+XHZT7+W+g=; b=SGGBfEPrF/eX72+93Lw6lKpkf16xoPZWUMRMXU4D
	rqgLNltlyAsee1NqncEyKzv6vDJ2sW6t7neWKE1jKxMxpBXRu3N/9AmswkySAh//
	Y5CGliP2+qiQ0ijEKd6ya44NXX363WjF6Lht45zGyvD9plt6/Zi/BHsNXaLPd1RI
	JZQvyh+ZQp9db6fw8Fsv+UjyjMfBoLBR/vhtDc8wqA8qC9fIXOR7sC8hj2QzItMp
	Oib8Z8wsvOOnOjEGPDsumsAV3vj3tWINJPoTX2Rn9SW8lben9deCO4iHKprj/qun
	QyXxhJlAuQ54sAoUfuLXi3eK/ogxdRvskC3FfNXKruPJGw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48047qcwfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:10:34 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6fb5720eb48so14446586d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 04:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753269033; x=1753873833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8v/bH2NBjx6+BJ/r65MfwKrxmq2wQHUa+XHZT7+W+g=;
        b=KSgX3zrKHi+sRJ/LAAUXERp7PHK5ObK+KcKaFIdB694T86yUaAuF4BGLxt+79Lsn4r
         9zm/9H44Tf3hiA8foHHHaNtxKW7kxPVFPS77OiAxxHps6lToSaI63gywtSKxHw1ZGJ5D
         AOBUExNRVr7XgIRtw7sG6urE8sKOqlE1v1htcFOv53vqPe4+CKp/DwiUwwHSATM5kbdg
         lZAERhCQ6qr0y/ABjv0MhV1x/5OHRxTnwXwybPgbAVsa54EwXKWY3QBCdG2DbbrDnQaB
         oC3SH22j+D57SyvYKUzTRS8n4u1RfdDhpOiiRYEZj9cIXPGeO37Ip6z9iT3eWB11F0Vu
         xxnw==
X-Forwarded-Encrypted: i=1; AJvYcCX2VkyGhKD/vXiA0kwtratEcKO/1bFCIFATNGNgfMveBqX9fKb6WmUrHrHCYrfrqmfx3vOTke+lSil4Ox8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5U0hBPqQCxEJ39ahmW/8iFrwJhw6BaSQOMsvoBS5TiNcZSKxJ
	IhOgyYsIJZQ/oyXS+ywKTx0GlOuZHV6RrXCkBqnO1FvwgAW/HIsL0bBVORSQuGB1juRMiBf9sim
	+HrLTwLS+L8i7+R1Kui7HmWSiFmOJqqQRKOI30KqaLEIlmLKAMeO+SB+WevODEF8J72U=
X-Gm-Gg: ASbGncudQ2KkzJs8JLxUDEDI1lcBm1Mt7BCvIvgy9c72xk6D1AOSWU2sceeHydzodVQ
	YOD6Cnz224gI2lrxqBQUeBy68XC0s8GVz4Y1Pfczf7fRRu0la5c6kmDPfsxO5FoTr8QCywqB770
	j7eZ8EiIm8JufA6iiL1PGlPKSymr0GauKkikgQPojs5eWu8NjC1YKaa/1e2Q/QhPDh75uNyEsVk
	u6/kbzXQW62a5CM5hLOwzlQPKRtyfi2zOHXoIso359Zoji84uFksLtTLULPHEF7djt6L/JMU3Au
	OS/8ql/srfvmIZGnMEBRj9CmxnFdQ5R6ko6f+665RUb99uA+wmXJLmLGa/3XEuUC6dVCPNVNNAB
	BtN1TdkKZF8lAxsz0YfirrSm8SOQ7gHeU5ZXVL99SHBjQ/gnPCbHa
X-Received: by 2002:a05:6214:d8d:b0:704:f7d8:efe9 with SMTP id 6a1803df08f44-706eb97e401mr95429456d6.24.1753269033041;
        Wed, 23 Jul 2025 04:10:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKX/yJfDO+WKJkcweygCNZ3fLCTvl7U9+hFOTGqWhqzh7qpDIFbc61paUsq4qoz3Ql+XOQtw==
X-Received: by 2002:a05:6214:d8d:b0:704:f7d8:efe9 with SMTP id 6a1803df08f44-706eb97e401mr95428916d6.24.1753269032389;
        Wed, 23 Jul 2025 04:10:32 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a9102bd7sm20831921fa.27.2025.07.23.04.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 04:10:31 -0700 (PDT)
Date: Wed, 23 Jul 2025 14:10:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/17] drm/msm: a6xx: Fix gx_is_on check for a7x family
Message-ID: <jeg4dw6wpxpfaio5kd5vcbqswq5nlclor7tbbh7er7zlwgdgxr@ksrw7waxj3mp>
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
 <20250720-ifpc-support-v1-3-9347aa5bcbd6@oss.qualcomm.com>
 <84a33e15-edaf-4951-8411-24b17ee5f4f5@oss.qualcomm.com>
 <62391e11-2f26-4e30-9c8d-b47d4985b41b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62391e11-2f26-4e30-9c8d-b47d4985b41b@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA5NCBTYWx0ZWRfX2SkqmLlz8ZT9
 Mk2dnowbzXiTbPwI0biGZGLng3ASiAAlI+v3/uFUEItJ+zP/QlULSzTdVxr2wNI5ycL/p0DW51H
 PVztiEMsO3f7GpjhWIb1yCeuYAFhzLTxUDrjNP3OUUuBvx8i2pEQppLFf+pq73EvH6F3ff1LDRU
 5iiE9hglMJ6Fq+DykBH/mrcuRIfqs8byca34HCalwKP8UfRQRn5WYRvFlWU3jKepv/C08BTAqmK
 X4OBy8UJIC+ruGkT9MYAcRzV/RobwlUmqIwuq/9BP4zc15vfOO3blcLMvJqu7mqIhn5yk7e5MSY
 NSsNNdy/ky6kxu3CQ40f/P2SygjfhCpUAb+QY27qfN+PQSfiELGvx/RqsS3AYDRPmTIe89RDcFn
 GgFEfS+o6br6LHlSktH2PZpNeeyMb6P8lixxNfRo5Bq9PG215j6BSbpwUAK+fohDw3cv+Xvg
X-Proofpoint-ORIG-GUID: Qi0fQrEDeFtRGB-XyoU6MLZSG3-mHVoe
X-Proofpoint-GUID: Qi0fQrEDeFtRGB-XyoU6MLZSG3-mHVoe
X-Authority-Analysis: v=2.4 cv=IrMecK/g c=1 sm=1 tr=0 ts=6880c32a cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=k4jRfATEMmhf2Y4IZEQA:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230094

On Wed, Jul 23, 2025 at 01:22:20AM +0530, Akhil P Oommen wrote:
> On 7/22/2025 8:03 PM, Konrad Dybcio wrote:
> > On 7/20/25 2:16 PM, Akhil P Oommen wrote:
> >> Bitfield definition for REG_A6XX_GMU_SPTPRAC_PWR_CLK_STATUS register is
> >> different in A7XX family. Check the correct bits to see if GX is
> >> collapsed on A7XX series.
> >>
> >> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> >> ---
> > 
> > This seems to have been introduced all the way back in the initial
> > a7xx submission downstream, so I'll assume this concerns all SKUs
> > and this is a relevant fixes tag:
> > 
> > Fixes: af66706accdf ("drm/msm/a6xx: Add skeleton A7xx support")
> > 
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Dmitry/Konrad,
> 
> We don't have to backport this change because the existing code reads a
> couple of unused bits which are '0's and that is okay when IFPC is not
> supported. So there is no practical benefit in cherry-picking this
> change to older kernel versions.

Fixes tag is not about backporting. It is to point out that there was an
issue in the original commit which is fixed by a new one.

> 
> -Akhil.
> 
> > 
> > Konrad
> 

-- 
With best wishes
Dmitry

