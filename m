Return-Path: <linux-kernel+bounces-811017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1ECB522FE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 22:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2A64583AF9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 20:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66ADF2FAC17;
	Wed, 10 Sep 2025 20:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V8F4g2wH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074212F0661
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757537445; cv=none; b=Lg+8pk0QTAfjg/guRNjoTSh7svyG7H0zNkgjgLs8pjr0V8frj59+dcjpcVUrU5vhoVWkWFqC/EoY72BBkX6RiIUbDupAkfrUay3n6f8lLmBqXQ25d9t0lPBQfqkeX3KqsHNiMnUsgDTjf3pAkzS2YVbM+VCRiBDr0tYw6+l+dTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757537445; c=relaxed/simple;
	bh=XWprFPpArhG9hGfbEYNbQ0Z5KMjikP2t9OLlwy31ke8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HLbwtUAdfohxT7HyYQwT/8TfHH6oCYh5KpYA5aQ1VzQzH1W+PIPdzBZHUN+/fNeoPFyVNeE8evmSQutLYox9wZu/VKP2FXfZTryzkB+gNije8SniEAPRm3GAaxPmcxLYwUqCAcw4/VoFvXgxqvpXe4+qFHYtwCZiGSPA6nNNJP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V8F4g2wH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ACgGHh003911
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:50:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SPob3xHolBsWwjw80JPpgSx8g/7DdiQrQAaQRydH9WY=; b=V8F4g2wHOl6fj7hm
	4qkm0WgSAHE/uy+VoHAMy+ROcydNcqBvT4x+C9Yh72Xffie0sm184uN4Ug9ByPKp
	w49V8bDrrPxsfEU5i56Y5TvWozYh5TPB27EH6liK2hxR7g5mAg+v5aZduW736bYI
	wIr/qsEkvVLwS8Mz+RSCOGY74+lYogsyqgQe4bjb0v/FEjiJlij3EvHA3kgJcJz+
	2YFK4fRYHUUl9JbnfqlTIa2qZR47WODt6IUbd1s455yVK5fO2zNMv9Szhb0hs+UD
	mOSy7gByFmK08M8G2bI8khzQWVmwiP1iL3C6kUD9wr5J+OV6/mKoL9fQY8DgYWRr
	5WaBfg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490bwsddcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:50:43 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-324e41e946eso15648853a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757537442; x=1758142242;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SPob3xHolBsWwjw80JPpgSx8g/7DdiQrQAaQRydH9WY=;
        b=T4eCeKMTMi3pZkKw6veSPDtptaesuFSBv9fQo2ypl4/1FQxiAUKBSRuj7T0Xcoc9qY
         4k8jOAQi8TKAWvIspDvQcTTAEG5tmehOEw3N7iXWj+EuqhPHsY3q6DN1VUFULdKbukNF
         zIF+fks+ntw+fHmO4oN2F9mRQR+1Z/1f6jeYebeJcKld5oDdbTI5hXx+76xiwW3CyE5J
         nyRHQ1R1xXYfpZFvKG+KZFb3c6R3bfAq5/x/oOnhu/Aelc9uxNrNhQsOJNN2ZwQuB2An
         j12ffgZ01fBHrNXoqtL7l6bUQYj5DC41WISfQpSxutw+7nPoiERy0No5xiHYiphi2Jg3
         6UAA==
X-Forwarded-Encrypted: i=1; AJvYcCV1uXgdUexuy/23vdshixcViVn3ruO7Cn8THgUWIqOT1NnOo4DSNbz5FCjboMUHE9QIW8yPEP1lb9/Z7Bo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJxnvScwTGATGOQ8/tyO0S6lZvig9oF8c4MBsfhSUYtZvb+lxF
	wgItB+pjgcpDuBbPoNqh16BE+2NmEkTLAXpDMAyv0lGyJOdbztY3Xfc+oEsxSBT31t0K3xcLcKx
	OINhOsvlQHJ0PefyBpe4WNuOHBNwMOlQUkgk2P/mZkKc1KEiaXziz/agLELpegiDz9ZE=
X-Gm-Gg: ASbGncu78AOnVuiEvIjCEIbh3TvQhLC0CU8v9BCxVsRqwKidoRHD6XrzK54EzUrup7L
	tXuy5R4pW+4a/a1wgNI6eDfmjJmvLB5cxRBDxGn5vVBL57cbKmh7gdBtT75hFb+n1hIC8Aitb7+
	eov3eZ8i/5VPXULI+bpCltOcXUCmDBw05VZUt52kREXxShI7G3Joa8Z/+tYoLltqujSb1E6JxfD
	nLBnzv0PJJ6LVOsdEffxxYNoXrLFao9c7CsybWuNx7lgrfPwZqsXVB4D6bJ1IO2piR0IkUPGnI2
	mxBn84jPv4POMXWwWZp7xXPMnZfnsedPyWC8Bafg2WVwpHYhe+KhOmdDLXJu3SCA
X-Received: by 2002:a17:90b:5584:b0:32b:cb05:849a with SMTP id 98e67ed59e1d1-32d43f936fbmr20933663a91.29.1757537440759;
        Wed, 10 Sep 2025 13:50:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgJXUpYTL8I7hHNV60o5NvlVmaX9wyglwKhRnYCLq0zaPYXXiRus2xum9n0Qgv2GWgeXlXqQ==
X-Received: by 2002:a17:90b:5584:b0:32b:cb05:849a with SMTP id 98e67ed59e1d1-32d43f936fbmr20933645a91.29.1757537440323;
        Wed, 10 Sep 2025 13:50:40 -0700 (PDT)
Received: from [192.168.1.6] ([106.222.234.137])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd62b59ffsm45380a91.7.2025.09.10.13.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 13:50:39 -0700 (PDT)
Message-ID: <69af97f2-75bb-494f-a081-cd967c442c15@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 02:20:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] drm/msm: Assorted fixes and changes
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Jonathan Marek
 <jonathan@marek.ca>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250911-assorted-sept-1-v2-0-a8bf1ee20792@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250911-assorted-sept-1-v2-0-a8bf1ee20792@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: UruWTVnevJ1KZTc1AHGbhQOZQ_uazoS7
X-Proofpoint-GUID: UruWTVnevJ1KZTc1AHGbhQOZQ_uazoS7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfX/YvFubLrqwq/
 crnoitGrXfHBhaeStdiq0T3fLhf5pH5kvhPn4Ua6CTZUlc44JNnJj3yDz3hm5PBSj/Cv86T+5i4
 jlGLiuJQ6lkgJANcwuV32nbNXwh+CBVx+Vr38qPgRUxAhixS2cgJfnx/C8+72PwBYR9QXDC6D0C
 1mUv2JjrAnaYgShhUljqYivWQOOUDRGNa6HyuYPyS8iFh/OVdbuFTk4nP0LxmXDAM8HB9DcD29j
 eKbxtGj5mOwUpnklua0J0D4HFP3EFCrhn4HReeyFTij+Jf8KXxAFyr5oOxkinGF4pay4DCDA7lG
 Z9YpAT7jKYM/LS0+wRDWnQ6qqQFwubwATkRAuBKuf2i4tphpBctphGd3mqB18UfsCNFQ9YcuOL5
 YZmnh9ph
X-Authority-Analysis: v=2.4 cv=G4kcE8k5 c=1 sm=1 tr=0 ts=68c1e4a3 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Cna2H39EMVpDwGpHkUETmA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=6_OwgA1yP801watpjiAA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018

On 9/11/2025 2:14 AM, Akhil P Oommen wrote:
> A few changes and fixes that were lying in my stack.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
> Changes in v2:
> - EDITME: describe what is new in this series revision.
> - EDITME: use bulletpoints and terse descriptions.

Oops, sent it too soon before updating the changelog:

Changes in v2:
- Update the documentation for DRM_GEM_GPUVA flag (Rob)
- Use parenthesis in Macro definition (Konrad)
- Reworded the comment in acd_probe() (Rob)

-Akhil.

> - Link to v1: https://lore.kernel.org/r/20250902-assorted-sept-1-v1-0-f3ec9baed513@oss.qualcomm.com
> 
> ---
> Akhil P Oommen (4):
>       drm/msm: Fix bootup splat with separate_gpu_drm modparam
>       drm/msm/a6xx: Fix GMU firmware parser
>       drm/msm/adreno: Add a modparam to skip GPU
>       drm/msm/a6xx: Add a comment to acd_probe()
> 
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c      |  9 ++++++++-
>  drivers/gpu/drm/msm/adreno/adreno_device.c | 13 +++++++++++++
>  drivers/gpu/drm/msm/msm_drv.c              |  1 +
>  include/drm/drm_drv.h                      |  3 ++-
>  4 files changed, 24 insertions(+), 2 deletions(-)
> ---
> base-commit: 5cc61f86dff464a63b6a6e4758f26557fda4d494
> change-id: 20250901-assorted-sept-1-5556f15236b8
> 
> Best regards,




