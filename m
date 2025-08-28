Return-Path: <linux-kernel+bounces-789758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87446B39A05
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C65C985B7E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA0130C613;
	Thu, 28 Aug 2025 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IeHJaJ9a"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F8D187346
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 10:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756377143; cv=none; b=KgA4hXGTRLZPxji+7+yspQbH+wJ6Yofg48p8d5pVrYJLamfvFBAdRWEdzQPXP+zoRzcBJOy3fmrp9TI11M87eS/Bsa1Bf1HagrmTphK62huKYj5NdMOcpkQ+dl3kCXDw+/KvBhoIXAl6sgx3ocIDZ+iZ0GAw7cuGcDn9vFJONdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756377143; c=relaxed/simple;
	bh=dt9wxlmAwg0N5A5qd4O6cT01R165bdElqjuRlYhrIZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DARJVSipvx7ZphnKiUvmkQ05sX3NxidWhHdSx0WZrArUONhwOLGcLEYRrI1M9xx9Opj9DbRBECWR2REMAxnG2oZoIslQzjt2ALgCVwBKoolLzDWrKpQLhQKD36ukhpdS6nsjn796vqCuS81qiELa7Z0lo6nm4OddX2M9eWTOTN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IeHJaJ9a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S6RlxP016081
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 10:32:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=pF1QVg0WiTnUKPs8/wG6SRgz
	3ikdq5fxvM7PGeVRu+U=; b=IeHJaJ9a4NYIPb/H4JVKvsKJhliLe7FlwSqYJ2ls
	gMrbQAuyXe1VhxJVUhcz+1aTlrRcLXMBZF2mmFBiEpu1P7KJXCO+h5B9/6+R1AN1
	5h6sD7ED1qBKixhFGSIxN3dn+AN+tAAKyqasMH5u1cbBeCoTRgE9f51zs/Lfpdf4
	YNCMFOmL4sySKZalRsnbcvsurPvL0vPuah6RbUDLxcCFSrFOUMOFRYlsCa3fHtEk
	gIydrKMNqaG6QdOHCAUjB5lPO9qtwAro0ElKPt9pLu1eBvnJrekLw18++XKRFzTQ
	2BaavOZZzA4gyX/k4WKWveAIPyUgox3AjFD/fwVdGamDaw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48rtpf26cn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 10:32:21 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70ddbb81770so18777686d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 03:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756377140; x=1756981940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pF1QVg0WiTnUKPs8/wG6SRgz3ikdq5fxvM7PGeVRu+U=;
        b=GrJCxnkF7PVPQJRurVM8qyUbD/sUK2Cpb5Yg0+XbTe8QlUqOJPZaInaV3Ty67Rz/P4
         y3kc+pUz02EQifd0W8vIXVkWmbxVx52sPGQkil4BQrqRn5Rqv7jMP7jxFv8pQGKaTNMo
         kg6TTxG/IUIIDmU1M1Fd19JiG1hiADUtv8Mmh4yrH+Lp4fu3fCSsOq38Mwyjq5WDMa5x
         567CoqZ8BW+0qlR7N7oJB4sjBVl5YFySYHJOBOA+7MkBqhIb9Vkaq4MbEAttxcRTprok
         BLMeiPb+zuEVarggDihsgNmCrqeHKoQlbg1Igs6KdXmoM8TjSrJegeiF8Jms+AHe4cQT
         WPLw==
X-Forwarded-Encrypted: i=1; AJvYcCUdcqcCbrUGRFEadNjf11XGNnQko+K7jeJHeBBCys1lyL+XTqKAL616ApHo5dywD3kDH2mcTTf1A4SYiPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuPsU7BF3hi1HyZ+3xRt9UKauCjytCLUahbj/Z9+urWAPPZkS/
	uoCC+UBJWFqOJhOZxcbJibtYuJf6G4BTLVXBJsBEJUW8b1DoUQqk0Y1h5pWyLvqvCVEm2QjY/Mo
	C3Cmt9EZYz367xS2vvacicF04J0jrUh+3NmbAym4aD0dex1odKLjYz3d0WEPIbR16tlY=
X-Gm-Gg: ASbGnctIJyzMOwFlPCzFpv81UqK3bKF5kpyGTfIYpi8lFPKFvD9ri2vuDqkjM09DMaf
	hYLm/LShb8mgNTp2MNFFNhhnlwUTrXeJ9eEmsKp88dTEO+0v/7M6z5N3S2Qm4d0B2SiZ/snXKxX
	4eawGr34NeA5dBQ49vVqGO1Xw+nn2JHdQgiHQK6ws42FUfZeAXCdJKtkuKXcmj+QVGvZJwoPTYv
	aTOjJcgBLA2bb5FgAz2E5Z7tMZjfMLBj6U6juwHVFf0eri62tkTp8+nrftdkreCTMkyeaBl7Egl
	M5TGYOq+Rzyh2T885VKHIwsJ11OjPMJprk60boFYA3zmXQq2rhwWdSpgSxrJDap31JSAUeme+J4
	sVxpLFChuHMEkb1riIj/QETcasEOFoZSzpPNXOCiNjtbynp286hzJ
X-Received: by 2002:a05:6214:d6d:b0:70d:fd26:f234 with SMTP id 6a1803df08f44-70dfd26fc03mr809966d6.59.1756377140448;
        Thu, 28 Aug 2025 03:32:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9RHmS+Ep97yyR3FC0zlcb74IJbJ/77cI8edf8G9P9RRNhQsn1iB3HWlX/2n/MLMZQ0ByuXw==
X-Received: by 2002:a05:6214:d6d:b0:70d:fd26:f234 with SMTP id 6a1803df08f44-70dfd26fc03mr809586d6.59.1756377139998;
        Thu, 28 Aug 2025 03:32:19 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35c9a063sm3239190e87.112.2025.08.28.03.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 03:32:19 -0700 (PDT)
Date: Thu, 28 Aug 2025 13:32:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "open list:QCOM AUDIO (ASoC) DRIVERS" <linux-sound@vger.kernel.org>,
        "open list:QCOM AUDIO (ASoC) DRIVERS" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] ASoC: qcom: use int type to store negative error
 codes
Message-ID: <o6ui2oopflsxb7dyrdet3ti57zgms4lywrhibyks64qk3tmh53@vhlrrhpb4zr3>
References: <20250828075406.386208-1-rongqianfeng@vivo.com>
 <20250828075406.386208-4-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828075406.386208-4-rongqianfeng@vivo.com>
X-Proofpoint-GUID: HdrmBjsCyuH9Al5FDkUnMS6_ImwTzFw9
X-Proofpoint-ORIG-GUID: HdrmBjsCyuH9Al5FDkUnMS6_ImwTzFw9
X-Authority-Analysis: v=2.4 cv=Hd8UTjE8 c=1 sm=1 tr=0 ts=68b03035 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=1WtWmnkvAAAA:8 a=EUspDBNiAAAA:8 a=IPwh2cHtyxZVSPeiaZcA:9
 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDE0MiBTYWx0ZWRfX6BRNMVLFYB0W
 NSQm3jQXO6l0WMM1UfQq8bTHaOhlupbSdXvSugY6v4y0sSjYv0GOUHWfNVTm+HO26RbLY5Nnohb
 KFvn5QItSv1K00MD6AEW2WBPENssxsEv0kejiNjK0GaR58w5IcKRwFQ7DE1iRyoUwfM6Qt/V9do
 ziqfi9CYEFDu8viVauXTy01HVB+sLGq7y5uruEnkwvLhVXWDai7EsZsVkUvQpmQh7Hp5bPAF1q4
 ujH4JHvEN4YYFZH6fe/otUHCA/naRlRynsqRBrhYnRWBkfiEZSApmUP9AyibwH8pDIavZgsMyCE
 RettXH7hblymgP/ZWCvCJP8QggDGZ6EXUPXnwWeZmd/SHHb2xcQFo4PGTsWrVZQrM3uoBeMvY8m
 xM/wHYYy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250142

On Thu, Aug 28, 2025 at 03:53:59PM +0800, Qianfeng Rong wrote:
> Change the 'ret' variable from unsigned int to int to store negative error
> codes or zero returned by regmap_field_write().
> 
> Storing the negative error codes in unsigned type, doesn't cause an issue
> at runtime but it's ugly as pants. Additionally, assigning negative error
> codes to unsigned type may trigger a GCC warning when the -Wsign-conversion
> flag is enabled.
> 
> No effect on runtime.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>  sound/soc/qcom/lpass-cdc-dma.c | 3 ++-
>  sound/soc/qcom/lpass-hdmi.c    | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

