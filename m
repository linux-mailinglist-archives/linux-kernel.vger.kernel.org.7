Return-Path: <linux-kernel+bounces-847001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA0CBC9A25
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E27A4FE626
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840342EBDE0;
	Thu,  9 Oct 2025 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AMPjiVY1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4310C2E973A
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760021336; cv=none; b=XfVJK2QXcYe5q4aMvXPdkcdTT2Ej5FVgheAeI2WxZTAvAaZtIUpJxORbgz9hs+qvALwwGJIj9QjRm6AwR9pIsfbmMjn0RHoMPUbwCYSUdFQ06UGoSqffiosw1hmnDiPjdhD5ZAzJeBiv7Nctw+0ElMw0fDGWo+H5gQzHVx6zivo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760021336; c=relaxed/simple;
	bh=PDfS/sMvB68vOw3mL+A49DJwYJqE6CQQsVYqnK7PdBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjVVBOS665BZYFok0oqwCh3jhuOvnkVItD0fgopglgbW5iDMR5qnq/YIcIQN4pV3guRI/BwqCFBxKuc2xFQN6kn2tDIJ6GsP1De58WMc4E0zFFQdl39Cua9u7fssHPSNglLk71BpBCG2U/Fpk4TB3OFBWkSrt+WFl07582kqA+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AMPjiVY1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599Ef9n9010854
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 14:48:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=sdcvidYHKOiMcWY+FA80ilvZ
	boR7i7iogh2OGbNmJCQ=; b=AMPjiVY1N0EVgRPHTsnWKg58k4BFh2Mr9Cj+taSB
	y5OcnYvbL0Xry4sWUiKQyjZYe6Px9XIyCh/fFjdwhieyk1gGwuZRZ5VG6VCbIJLF
	HSrIC7GPa6ZHCLx6OQTWodRBRfPwNe2uPUZGnaRylLLNY0F/i8Dj6VTfoZHVZLxH
	8lqVOSmVyd5pD/CRptQH1vpvn6SegTMh364IWLgoVAVkpt5PpTxOajqgl7vHgCGm
	cLyb2iKrZm46dkLpe05ww4goFBO8H7XX/n6EeOlQy+kVE2drB+edrCz0NbiXm+2+
	CCYinpvj6x5h2TORtqeVh83NYA7VGemgxDZ7vpJ7GgQfJQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv9ab7ub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 14:48:54 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-54a7d8436a4so574416e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:48:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760021333; x=1760626133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdcvidYHKOiMcWY+FA80ilvZboR7i7iogh2OGbNmJCQ=;
        b=LIdWJZNt6e6vBRUBx1vQMdvs2FWFn0SRcz3lEYlT++7ErrPZycGyEm0zstQHSCdJkB
         LvK60VYgGPeZsjqJ09PPbbUbPTO5lUF9dxZQOddpAd5hRhka/MwF2DP8TxcloGpnaGSx
         enenGB6jymzRIST7h4LV8ACUY638kwxCQbtXwHt2RZ/6xY+M6GsBFb1c5/9pa+Wyg6rw
         eVbKO5qAlCl1vy7a7FAIcohdz5doBVNuqpmpt635/YOESgX2pyaq4kGbWbWashji7brP
         OnOEHXjQB9l1meS5HfEFNCn58HwD7dqgN5DZNDqEFMIGNYb98pKzp7jbN4Oy4Dj9e7GS
         8OSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7SpImHzRRl2GWGqpIr1bZVquuS5hvqNQWjkHoqckGqbxVhwtpVjM7XrLE4nWnUZr3LKoYFBm0LSR4XiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/TZwnuBGrWgVrcU8U+DBO499T0nZqBhRUdydw+Fs8StX2mPC8
	7bB2TiBdTMOoFUk8SKSMYpa12U6mY1BQuOQS2u3n8mHqZhWa3dgFsdWRFPOxWL0m66k2Lp924IW
	yl6Os+FYoKK6VjPZk1f7ZBpXfwU6TBpVNaR2glAyM+3DWD/T1G3vfft88OxLEl/xnAd8=
X-Gm-Gg: ASbGncud/cRzpANAcNafcP9ByhUjHWbTF7mHTtny822SfskftiL4qRJn/d3nYRJucwH
	43vpmmYOXM3SWoRNwVtCk382S+igD8HFB02Vh6AcYDptVksc7icIhSubSE/ZqSDNE7QtAFpWhAi
	Twr/STyBMi4pAeA9suumYms6E2Qnn1WXxtTd+601BxXIfO1BCQT2SCvWQxQ/SvIyU+4PUNRzJ7g
	N66kazOMml/mG+tPN/rqMLqpRp5f5Ic3BGuXtF1wyJ9O+1lThTNikyCaKfSx79zZkp4NOOBwgak
	vzTmOWxUUSRfOs3h/WCQIH9TU+ft/D4NYpKz/esMP4XIypLh/ULnfebS3AdF84Wo7iVmlhqoxXy
	fdEvd0mYCyHWhrVgHO4LzSFFK9rnZk81TgBY5E+TbIB4fRaMmB4qy347SIA==
X-Received: by 2002:a05:6122:8d3:b0:54a:8d5a:a678 with SMTP id 71dfb90a1353d-554b8a9ac98mr3185074e0c.6.1760021333059;
        Thu, 09 Oct 2025 07:48:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrYg2sJ1HiSErx/z+VUowsLWWSTFGC6kpcwvORUTnKFt4+Ob9OBYr9xOs/fUslXCVRuwIehg==
X-Received: by 2002:a05:6122:8d3:b0:54a:8d5a:a678 with SMTP id 71dfb90a1353d-554b8a9ac98mr3185029e0c.6.1760021332353;
        Thu, 09 Oct 2025 07:48:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-375f3b82334sm30008961fa.49.2025.10.09.07.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 07:48:51 -0700 (PDT)
Date: Thu, 9 Oct 2025 17:48:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] media: iris: move common register definitions to the
 header
Message-ID: <dzorzudzpjipvlkwik3uylomwi2dy5ticxromzegzgi2jhibot@reqv5ul5ifuc>
References: <20251008-iris-sc7280-v1-0-def050ba5e1f@oss.qualcomm.com>
 <20251008-iris-sc7280-v1-7-def050ba5e1f@oss.qualcomm.com>
 <b7eba4b5-1189-7506-4767-0ef3234fc6f2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7eba4b5-1189-7506-4767-0ef3234fc6f2@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMiBTYWx0ZWRfXxt/jDx6VVAm8
 1j7y4BNYOBnc0VDY/hH4vNj3xitYZvDx7myFHFUcFfYZVWYahVAB7MwTQJBe+aZFAx3EkxXXHPY
 DgG8ADF9gJurlYHxnnOBMV2kr4VjaHbSsnumvoFQviKijhbnecPuUZPp+95PzzxkLNNdvA9Djv3
 GuQknL50Ng9/GyD9kCmBeoY0fShX1xyauZImJ6PabFBOEJj0g9gJqRpGn0SZNYJhpXyFuCUf2DC
 O6w80QADD4gJeFipZTy7IIw/FwReN/yIrQvnORHJxdGVNx2B2CG2+xaVQ/Po56KcW6O/kSsN+m3
 0pj5tBiywn8z+840boVv7Q3yLTsOSa8iUODSVNkncTike9Rwchx2N98eRHvCRFWCjy6/HEv+cfr
 fjqe4vFZ8An8SpErjM/WFzN769GJ2w==
X-Proofpoint-GUID: TUZF_lfeKQ5VvwofICENW2Xrb3oSEATy
X-Proofpoint-ORIG-GUID: TUZF_lfeKQ5VvwofICENW2Xrb3oSEATy
X-Authority-Analysis: v=2.4 cv=JPk2csKb c=1 sm=1 tr=0 ts=68e7cb56 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Z5nuntwH4KBwj2E1mcEA:9
 a=CjuIK1q_8ugA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080122

On Thu, Oct 09, 2025 at 11:40:25AM +0530, Dikshita Agarwal wrote:
> 
> 
> On 10/8/2025 10:03 AM, Dmitry Baryshkov wrote:
> > Simplify adding new platforms by moving common registers definitions
> > from VPU 3.x and "common" file to the header with other register
> > defines.
> > 
> 
> Similar to
> https://lore.kernel.org/all/20250925-knp_video-v1-5-e323c0b3c0cd@oss.qualcomm.com/
> ?

Yes, but moving more registers. I can rebase on top of that series if it
lands first. Or I can just pick that patch into the series, to remove
the dependency. What would be yours / Bryan's preference?


-- 
With best wishes
Dmitry

