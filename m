Return-Path: <linux-kernel+bounces-866549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A161C0011A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDB52188CE6C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B5A2EBDE0;
	Thu, 23 Oct 2025 09:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P6J0NOkt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCB427F005
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761210172; cv=none; b=uKoZcLKREEvITfhZWpJqUQRjhmao7rKeVOSTidjSf27EA2rV2NYiQkn7DjTfiYwwyEsACtNYtp8Q0zPfnr725f7/G7w+AAKYxl0qIlk/6bZearyMk03Bc9o/HqT/qo1FanYczCVnhzv+Oq5Vq8lrrXlzgYmCT609zMfYTexrt90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761210172; c=relaxed/simple;
	bh=m+eFzGs9vRs/sz3OrS+4k2Cdpuw3Uw6lRRM+fMwbiLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIABRobkioDSwkvevskGomWJIE11xxHEnyFWZPg2Aphpue6YQCqiET0/OTd0W090EJhS/roYp3Of9JFnDf4GopJSOLnw501pZ/9pndC/5OBvz/OlXyCP1s2cst6veJxIGZ8O85wwfkYNjocJTNUxcI4vgFBAvSLPYbj2vHBfXl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P6J0NOkt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6ktXU015109
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:02:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=MalpcSnxYq9dA6R/9QMOFRvU
	abPhDrPSEV9lSVwC0ds=; b=P6J0NOkt6oOMbuj3eWr+66ziwPdaAZFJTRqHlbcb
	A2HmFa6tftnFXZg8ExvCzOspfY2NMEQpXW+q6Jm7f20z8smaax/oPCxFb5N54I/G
	rDKco55nNrd3COa6DqyEOw0ucsQIlbDQ2YFkzs6cK0TlMCdbw4AkEYepsC/Z202z
	ym7QPUej18Cc39bfsXFOz6g7oQuQjHvbXSNy7enzO4+K4pAOAs/ZmisG/elhYwyo
	hF5OECymbrXEC0APwLfiPwbT5p3/wmybp/SOsIOP9BMeaHvIcO0EngoC4UjsUNUV
	5vYvgB0B7OQ8EHTAuDAZKBLR4t+SjaOPYeIMXWekBXB0VQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xhe0nn6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:02:49 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b522037281bso373957a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 02:02:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761210168; x=1761814968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MalpcSnxYq9dA6R/9QMOFRvUabPhDrPSEV9lSVwC0ds=;
        b=ZUsvrOT492EdmZxxiEyqj1h+/boGRxfOMNrdex/13JbiFqQaoAvwvU6v6RtG2fVvjW
         6p5OiRf7hpj6XJoHVIqqJSJmWWj1B0qn3bQFHatIAW6UgLNLyTwhDFzeChqSbYM564ua
         57ADiQSDQWeGjw//LoGlCvVKI6mMWKpzXDTuOj6JyOYywxLFz5GkStyzzzSMpPye/Qw2
         esEhAv2wMgQOPWkArIFNlR9RWBQZb0ZdrgZ8mrvt9ZFjA/MtprTrbpIRi0D1c4yAe58s
         LacJgA8TMHcG5cmfqG5khZM4U3Qlpyeybi7Jl8LrU4c6GkgSSAnX6Zaa60wEpsWOFZ4R
         8AiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYfyDNjiNZGHNGcVqI2FMMYRFsGFFcdBwuYtVNK+ztImLOXqN1z4pp+tWKinooM9ltr0mjl2IDVFcpwc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBFbWZuAcXTWIM4/Vua2Jj/lnD29juBDAKbEo2EyNJEtECRMbR
	sbooqL0FDZsCOMu8ym8a40LIJJvn+0+Jug3pPSkH8l2e4UWEWe2oYu/xeCO3xGKU7sO+5IQV+AI
	8T1s3gbwc5i53v8EUXZyEdvrttMA1bl9Cskig21Fx4TFDiaO7A+IjSdZMUCeyzdsHFsY=
X-Gm-Gg: ASbGncsYNndf45SZCy4FSfbCSlKTAvWqaVq0aKaiwuSjEmKoKEulowMYVRNgxzu9MS+
	ORXAZf87z1DwZZxNURnreIbsrzdarWE6CKiKYqek0n/7oIg9IfSHUF6qlHKmyqn7sf/GwiVyjEZ
	cn3g/ZXxZ3a1LiMh+SEVEUOddzv9CCZRI9vMzLUy9R9i3j8Fp6eUpRRtHH+7sbD/9eFn+Cpv1a2
	L0PXQdh9oxYJKeesc54hcvsdcPhAUii+cfK0XM0j1cOxomQIaMCWxaSOrRNmayflM48yjdoydq/
	XZGxXEdJGWh/1CwTJ5h2Po7PoGkEaFza64LtvC06vy+Ab2CbASLOsPFICNjbPenwIn+aGjokAfe
	UmCHKrBABc04jFDjhr15UbQxnKDZXsAWL9OUkzJdLX1HHEbQhUDBAwA==
X-Received: by 2002:a05:6a20:6a0e:b0:251:43f5:cad4 with SMTP id adf61e73a8af0-334a8523f0fmr34082081637.10.1761210168342;
        Thu, 23 Oct 2025 02:02:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDRzsK8hhHTbHS88g7R6gWrzYmoBOYsl4eyr6xderBPGGwFWTjTdHzLDoKqJbYcV5t7wEgyw==
X-Received: by 2002:a05:6a20:6a0e:b0:251:43f5:cad4 with SMTP id adf61e73a8af0-334a8523f0fmr34082037637.10.1761210167794;
        Thu, 23 Oct 2025 02:02:47 -0700 (PDT)
Received: from yuanjiey.ap.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fb0196831sm1722206a91.20.2025.10.23.02.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 02:02:47 -0700 (PDT)
Date: Thu, 23 Oct 2025 17:02:35 +0800
From: yuanjiey <yuanjie.yang@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
        simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mkrishn@quicinc.com, jonathan@marek.ca,
        quic_khsieh@quicinc.com, neil.armstrong@linaro.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com
Subject: Re: [PATCH 08/12] arm64: defconfig: Enable NT37801 DSI panel driver
Message-ID: <aPnvKxiv2I/XeI4K@yuanjiey.ap.qualcomm.com>
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-3-yuanjie.yang@oss.qualcomm.com>
 <207f25e9-3685-4838-a384-e6bfe6f8c244@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <207f25e9-3685-4838-a384-e6bfe6f8c244@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE2NyBTYWx0ZWRfXzDs3nULru/Fq
 FlBqarobFwhtYVliA1RSiKXGsp8eROIRSgPjIoXIx8Z0cA4qNPP5u8JVQiO9DOUv2Y6w3I3AQi6
 N+nyYzrw2oZN2h/Bv1AwuUHqdqndT5QlquzZD6EF9nAGdFmirM+UXbU3L67ddgVOf5N1+d4I6p1
 cmM3n/byCLA+WClT1qsEQ/hCmhIF4sH8Gnzhhclt8fbsQ8Kv+O93FCtGwFEPLlSCWkhbngPr6iG
 9wOlWY7Xxseq5b/8S4H9zoUvc8ZQouQ6Asg0z135XTx0mK0YpUFEgnLdt7hK2gu54k0f18tEfyF
 lGW5TNBsUieC6ff91t2k3AkNwKVudlu2TzWe3n19Xmdu+8rIWvl7e3qnTqtkqpO0RcWvohxjTXg
 x0U3we3Tu4dBgLjJzviqPEBGyhaS3A==
X-Proofpoint-ORIG-GUID: EsoAQoxkw5Z7WjcUgcqAzZQrr9QUlGtJ
X-Authority-Analysis: v=2.4 cv=WYUBqkhX c=1 sm=1 tr=0 ts=68f9ef39 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=-XBAuW2u0JZaUNqFeVsA:9 a=CjuIK1q_8ugA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: EsoAQoxkw5Z7WjcUgcqAzZQrr9QUlGtJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510210167

On Thu, Oct 23, 2025 at 10:22:36AM +0200, Konrad Dybcio wrote:
> On 10/23/25 10:06 AM, yuanjie yang wrote:
> > From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > 
> > Build the NT37801 DSI panel driver as module.
> 
> Yes, we can see that's what happens in the diff below.
> 
> You failed to state the "why"

 Novatek NT37801 panel is used on Qualcomm Kaanapali-mtp and SM8750-mtp board.
  
 I will give this reason in split panel patch.

Thanks,
Yuanjie



> Konrad
> 
> > 
> > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > ---
> >  arch/arm64/configs/defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index 8cfb5000fa8e..537a065db11c 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -945,6 +945,7 @@ CONFIG_DRM_PANEL_SITRONIX_ST7703=m
> >  CONFIG_DRM_PANEL_STARTEK_KD070FHFID015=m
> >  CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
> >  CONFIG_DRM_PANEL_VISIONOX_VTDR6130=m
> > +CONFIG_DRM_PANEL_NOVATEK_NT37801=m
> >  CONFIG_DRM_DISPLAY_CONNECTOR=m
> >  CONFIG_DRM_FSL_LDB=m
> >  CONFIG_DRM_ITE_IT6263=m

