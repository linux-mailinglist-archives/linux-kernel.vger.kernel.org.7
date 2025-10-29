Return-Path: <linux-kernel+bounces-875045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD45DC18137
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2EE51AA3645
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 02:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E7C2EBDE3;
	Wed, 29 Oct 2025 02:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XXWZjrTk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hqNFCzEF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446832E03E0
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761705472; cv=none; b=rn2OzHhF99tyHM5COSgEO/odZalCfkhBZACN/zCMpDb60ti+DnoNJrsrxJSeGt3NY5k2HyCTaLc1bLHGQGZXGc0pklFEzoKlyFqeA7ld/buVU22DRPyVGoOuzQ19H99yl5zPbK6O67W+SmPJnUsnODhfEJVQcIeXoQW/S0rDV14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761705472; c=relaxed/simple;
	bh=d6h8BwPEoEpBaR4PWqheH1siX+Dt2vQwXa52l0/ZV4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOqPjoRb820uCOo9raA0f+A3AvJhK6REyZgMYTIFfx1L8L12exHdzZfhGVpt1492+Nk8pCF6baD/S5iLA8NSYqtY8rrRh+oaL/90fovnVnksQiiJz0xaF/nHzt1Q81UZNnYVdB2YNiiwE5zeztbK2hD/OV9wMDY7BEtdMWLp1RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XXWZjrTk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hqNFCzEF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SJlDtT2616656
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:37:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=0MU0AfPnpKaX0wUSQTeDsGNj
	N1sxzIkts1un5DkBdeY=; b=XXWZjrTkn25TznXvh15LPt4hslGwgyTqqhgaIoo9
	g1g5zRJeHdSi0QFaO/L3QjbmehOOUxk8KtC2znoLu2m8ELsz0ZoJ+ZRJar39N853
	/l5eir0IJEUeBPSSfgp3hcyaj9CFyhRnZiTfk8T4g3fHU4IhX/IYMPOJ/uLDjc/m
	HaEt0hmAG82xW6Es1oQBJE6Z3I6j7je4GMEMCddzMq5kPx2vavfhpitjkcZrETfu
	hDMWFsX5wWyGjwaLbaa6zdCf3luotzUpnkzC+aZ65Q2TUEbWeR2zDBOEgujahb8X
	NcYh7tKE3FQdNis2yudm7dE5acfM05Tu6pxvdIkT24F6Tg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a349y0wms-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:37:50 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8a27ed89773so957301485a.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761705469; x=1762310269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0MU0AfPnpKaX0wUSQTeDsGNjN1sxzIkts1un5DkBdeY=;
        b=hqNFCzEFfA9phW0dQ4Q5+9wpdK0bwsZIIpFU/gMeiqYAXZ2fE1BnrnWCuqCcnnhYeE
         X1SXvH3ZCiFD7yc0y6KqJThbEDT9hpC4a6tLr5LOo4P14dvyZr7Cwqd0PLSlBXpZuu60
         +zhSYtmBMyUoRvurb2vMUBN8T513GITSY008ms7QJd3uTSQWnwzZnOsAhjZPnRs8wiyU
         lfDZiEqbxOS19ENuLoET1o2XpG6jvOJ0BCM14yFRrLIrxO/9so7oQvt+ltkb3STWTVj5
         b9AK/5J6D4rD/P4TVhWFcHzj4jSyObJLMb49OFvz/0xslEnXdecyb3WHD+ronqXCvYfd
         Hlmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761705469; x=1762310269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MU0AfPnpKaX0wUSQTeDsGNjN1sxzIkts1un5DkBdeY=;
        b=H0iMhHXqMZ66gjSIqA6DSWBtgJ2gv+zqsVKbNIU9JG291hDcUPRCV1Vu9vKAZ3UcCH
         SWK6Oa3JCzGxQXNIrG3iazLbq2t1kszqaZhbBXQcstb2P1wU+pqMHJHbwadjwd55Tbps
         XmIMx8BYLtLemlnOQHRlOWc+FbO7NJ/cyltYtIHdRe6O1w26LnW8lGO4dPFlCsK855V2
         h18cls+OqjhQxNgI/WbMt5tiqQ6uyDdRuNl8EMEq44/cS5RY5o8YrINgIa2lpSPDvKfF
         lMIY1IYYohi/DpXYnCaRfU1tTMRPI/8Xz/uSlPK6JckCPkwXFz8JtZqqCkVw0PVwO9H9
         Cbrg==
X-Forwarded-Encrypted: i=1; AJvYcCX2oyw5iPkCjKGTVkK8ftB81Jjs3MzINv1WYJunVep/ZqSfZprg8IGnpe9jtSvY69F8/2bBXkDjheR1VkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT48fCxEHgvXMg4tjxpz5nvA9jOeDu53O4EI5/b83HoWbj2anq
	3xqqdxlMHMLzX47lT52Dfk7jMHBdv4qYSakbm32MNNst4i6vAl2AZcwjzZaylTKwdwEGfT228OO
	2M9bmGUhZC1vXEkcZYvAeMyzWj7cXmATfEQpSFS8gJsOMgYRQ19o4JxQUxbN4cV3Nenk=
X-Gm-Gg: ASbGnct1DOr8m6YK3EN0fM4nMv9/43HBgAfdFT26d4PkGAD6GNHP0ub41ML+qj+mVUJ
	ZhcSQWBOshw8mKQNJYNAD9g01uHH8rNz9IpWZWThhh41b2QnWCum3PH+7e9Y3hNiQ5q//vTnG3v
	IpGYEsUPOW/SlriuaZBag5bcaTv06Gns4TcsQXKAWyAjrmtS3IIUwPRbtmk/hEk6eEmXBNN5q27
	kb7ABj3o2qffeF+8/sKF0Utfuiwt5tViRrKXpqJ/GrN+9y57sOb2oaRTFPfnSoffQvb17dtLbxE
	Ea8KRiE+/lQIzncwL2LOjd4lHipbO2bsUcSMCvCSn5HGOlzWK5JnzdT9jq0mlXkVJpuUuXDAyEV
	uzUdRkH+rEVeouscyt4AXGvTUO4cES8hz+7efldWwLv8mnVz01AQJ/NSg/E0NMReG
X-Received: by 2002:a05:620a:4412:b0:862:3e8d:e4ec with SMTP id af79cd13be357-8a8e6954aebmr215710885a.60.1761705469460;
        Tue, 28 Oct 2025 19:37:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLoBX0vUikArQtQfx9YHtcyAX45KfBodi8D7Jo3dT7imVYdDfzHcZOA7AEQgVHqJh3CLxDUg==
X-Received: by 2002:a05:620a:4412:b0:862:3e8d:e4ec with SMTP id af79cd13be357-8a8e6954aebmr215707685a.60.1761705468912;
        Tue, 28 Oct 2025 19:37:48 -0700 (PDT)
Received: from yuanjiey.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f24cd5617sm963961385a.19.2025.10.28.19.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 19:37:48 -0700 (PDT)
Date: Wed, 29 Oct 2025 10:37:37 +0800
From: yuanjiey <yuanjie.yang@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
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
Message-ID: <aQF98RvLuOlJZlFi@yuanjiey.ap.qualcomm.com>
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-3-yuanjie.yang@oss.qualcomm.com>
 <wuh7agcgg6spghilnx4amqukaaydj25u7kbdiod7fl6pu2ulvm@pmosyuo43cyw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wuh7agcgg6spghilnx4amqukaaydj25u7kbdiod7fl6pu2ulvm@pmosyuo43cyw>
X-Authority-Analysis: v=2.4 cv=D8RK6/Rj c=1 sm=1 tr=0 ts=69017dfe cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=yK9oDwkn9_E4VEaIOE4A:9
 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 2f_d_N84NdS-I2thWp6imHrwIbk__M8K
X-Proofpoint-ORIG-GUID: 2f_d_N84NdS-I2thWp6imHrwIbk__M8K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDAxOSBTYWx0ZWRfXzwMsC8AU8naE
 ea6RlyVCK2njCwF0sEWsvYSOTjLPoQH6lF6yFbli0NeqOnPUY6Rk5ywSJcGEhKcvonXiEgKyIwz
 UEqCsYBZsQ+Hpy2C+gOQh6N49GrrIC9sQ71Nu/Dl9t6x+PPFdM8hIP+6r54TVOAzfsC1on7aFTP
 hfL9mzVJ+CusdBA72DwpjJCbBCiQAFRHsYx35XkYeqYE6ipbJTE6Mo2Z9ckk8iVPXHjQkeTIotN
 58NM7R95WuNlpwKpNf67EB1KWd8lZhQDTf8SclUkEMwVMAmpOPyk+q7duw0xkeEQSh19BGfuz+Z
 VOHBebYY5u+Nckerib/8kxasMwFKzhnzmnvW7Vx68SytvUHc5Y1bSH50PrGE7ShGPEbp2aqvJJi
 3z61GPdQwzm65WsgzKdNltLTFNFMlQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510290019

On Mon, Oct 27, 2025 at 10:51:23PM -0500, Bjorn Andersson wrote:
> On Thu, Oct 23, 2025 at 04:06:05PM +0800, yuanjie yang wrote:
> > From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > 
> > Build the NT37801 DSI panel driver as module.
> > 
> > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> 
> You (Yuanjie) authored the patch, but forgot to sign-off, then Yongxing
> provided certificate of origin, then you provide certificate of origin
> and send it to list?
> 
> Please correct.

All the display patches were jointly developed by Yongxing and me.
So every patch 
I do sign below:
 Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
 Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>


I am the author of these patches.
So author is me:
From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
 
Do I need to fix this sign below in next patch:

 Co-developed-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
 Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
 Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>


> Also, all other patches in this series are merged by DRM maintainers,
> while I'm supposed to merge this one. Please send it separately, once
> it's ready to be merged.
 
Sure, I will split this patch to push.

Thanks,
Yuanjie

> Thanks,
> Bjorn
> 
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
> > -- 
> > 2.34.1
> > 

