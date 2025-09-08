Return-Path: <linux-kernel+bounces-806214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 007C4B493B9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0DA57B2F44
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B04F30E0E9;
	Mon,  8 Sep 2025 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GFIdD8hN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2503030505D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757345887; cv=none; b=G7PkbrCPBZWDwqhO63mvNFAs9uz1z5XZ9B4+FI0S93cs76Cd9V2NkG+2z7MoULoQ7mKMbLDT+FjgH1hFsg3gAVtxTg5YZJIX4CyasWham6CkvEQfeCOssJcF81mOgbeFB9BnwJ6HQZX4fWzu4wQ25qUq/76A1ewvM+5CTCHUUCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757345887; c=relaxed/simple;
	bh=qE4t/JphJuE6tOWkF9SSkebo1CiAgeSUWHmJQwKOopk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S1HCc3oyq3i1zS96mC/ejWzUkrWA9Ly3M3oejx0TzDdKgHnmvgE/JZN5mpuK6nvF5724E/YiU2/KrB23Vr82zOWlcKeUqQWvBEHXiP4BtR7yyaD2ugdYEu3tJbX2ET/Go6g/j5kJB+bOhB+iy0FQiXem+utDA47J4pGLiJfmBng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GFIdD8hN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588DkUNU004725
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 15:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7VfDo+K2YxkxcNLtYJDXPL/1mkJcb89EfTCTUVk46hQ=; b=GFIdD8hN8FyF4bNq
	dhcqYmW+iPIZ8TBq67UlEy0/8yzA3wwwpTrRyxIPuKOEergP7gnMI0zpbK/dn29f
	XRqI7AbVN8X2shw6sNLMD/hNfk/37wp2yktw8PqpDnEJ+CHz+tAX+NK9hKxUE/iX
	Kr+pkHyJSI6G7+xZ0d9oljO+hlnTjrVP3RZJdx+KAHb5Wy0Qoo5PvDrYBP1CjupA
	SsTpnwpGbRKas8Ag+0PqeB+SX/1deC9XXir53r5AfC1C3MEhkFeKQBffcu9Ydqv0
	gcS5sXoIN5Op9wOfZIvAEuhjF+sMleHovORE50aHAyTAUXWIR1EO+MLGC7xvkljz
	dQJwjg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491t37sh55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 15:38:05 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b612061144so2622621cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757345884; x=1757950684;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7VfDo+K2YxkxcNLtYJDXPL/1mkJcb89EfTCTUVk46hQ=;
        b=HPMUTsJ40/3sOST8CMb2g4bTmghn81e2Om9EGDcfYfDjQSpiC7wtLMhkQZvzbImkrc
         OimQVjVNxtflYp243Gnemc15bwsBcE3BtYDhVJDp9aIWXG8h8QrZ1I9xkfmoDuE5fycX
         fL6TzS0HiHbP7Lv2gNJUtLptgjCwvmOJqbYC1sIsdMuiACTapCdGbWMU5WFmrzTKhspU
         VYa7qtCSUbIR0ki8ydwWNsTw9e23XE9PPBwVQ+zzYDog3ZE0hHkoFNpw+JHRNCKh+phx
         E2rh/yvt5wjIwg9//tHwFjHIkDFgkKt+7TUMaX/dsSC0IJoqSK/CGEtfQguqWSJ61EGI
         4+yw==
X-Forwarded-Encrypted: i=1; AJvYcCXXvqCASBjeaJCLWnPiLUT9RgdADYz6bOggDKRiRrDGDg1zR28JLqC0InhGYfwudCrlXdzmkqfhRp+9f2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx12IqheTRcL2MRknnTnOBGB8TkJ7xs4phUh63oTygRnd2Nqfse
	23x8izEmH5AT/Vvxv+L28AyZGXXdpYNAgMeozMevvIwB2/4IJW1hlDk4s4nEb344hXWd2hTBBWk
	XAWBAiSaMTPRnC2/lt3ygizALBP/l9yCTADnRribrVBL8PpkCnUUM+9QXKjHSru8SNrc=
X-Gm-Gg: ASbGnctf5D9HIXZrcq3iu0Fazx1502TSTz+UagIvwUaz2pzO36i4/doNjE7gmjXKkWo
	BInJiYbNXD8K5iHaJFjBddv8P0Im0G1Lf6fK6QRvz2tIaZkFMfeoiqjiKQJPPQ71hnj12j/j84k
	IG1mlA53GgOXtwv3N7V8fxmQZN42z9UbKRuVEd+7n3OAwSlSSm2k1qTmcOh9fY44o8/vkMdwYMx
	xzTaVGpwIF6ppN0Z3VhiqmiOEltmCYI5XzIa66me4agQXrofNAM5/LGcb47kIDbR3E8m0UsObEG
	b4H3jnPK4OrA6PgZAjKyG+ipctsImUtN0L+cVd2jd60JiVEXEiw7LS2V3kmYFqIhbXeN+BRjX33
	Mz1cGAvIgnnN140z54WMdUw==
X-Received: by 2002:a05:622a:1787:b0:4b3:4590:ab6d with SMTP id d75a77b69052e-4b5f848d05bmr58304561cf.7.1757345883520;
        Mon, 08 Sep 2025 08:38:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcsvpKBaQ4jCcWP5NtvuePywTOTY5oNYfv92gdyrYQkqbJJAvrzNLEIVI6ZIbznl8lDhI5wA==
X-Received: by 2002:a05:622a:1787:b0:4b3:4590:ab6d with SMTP id d75a77b69052e-4b5f848d05bmr58304161cf.7.1757345882765;
        Mon, 08 Sep 2025 08:38:02 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff0d9b1b53sm2408307666b.96.2025.09.08.08.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 08:38:02 -0700 (PDT)
Message-ID: <59ac7827-6258-4268-8b71-4cbcbad859db@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 17:37:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/16] drm/msm/adreno: Add fenced regwrite support
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Antonino Maniscalco <antomani103@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250908-ifpc-support-v2-0-631b1080bf91@oss.qualcomm.com>
 <20250908-ifpc-support-v2-7-631b1080bf91@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250908-ifpc-support-v2-7-631b1080bf91@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: EAq0FAuab9RB2wtJYNPq8RrsWv-fjcgH
X-Proofpoint-GUID: EAq0FAuab9RB2wtJYNPq8RrsWv-fjcgH
X-Authority-Analysis: v=2.4 cv=NdLm13D4 c=1 sm=1 tr=0 ts=68bef85d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=sRrLox2IjJLVq2cxUxUA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA2NiBTYWx0ZWRfXyzmklhId7uVg
 3PHNkPJGyeixxNueL/6KjXqtXP7f6Co10RfOjCIM2inyuenIdqt+PMec3aGd8PqzpYCWpByKHJu
 fX65XB5/nZRI2Ly8EcohVrJV3cil3GrMTLRaM6d1R1pjmGc1gQkQFhZuHq8LUmm4qhTx2JCM4hL
 LH598g3CQGgTW8kzNu2C1f8DtqjQyIXS5eCJBlrmkPU8eKzkGdffQVMvaH3Id1aAGzirVKrHMzI
 NLELFaS88H4VKTMyLRG2ZUZO01RlKMhQ6A6N6NCb/wmGAX1JkO6idvx/Sq0fEEHrAJ8b9ZivlrJ
 DajRHHqXOm0950ciADL2XhwGiM0pXkUJvITmjHo76nCSj11t0krD5gJHgcatruzXi7javEeISpq
 LUSOwLTJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_05,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080066

On 9/8/25 10:27 AM, Akhil P Oommen wrote:
> There are some special registers which are accessible even when GX power
> domain is collapsed during an IFPC sleep. Accessing these registers
> wakes up GPU from power collapse and allow programming these registers
> without additional handshake with GMU. This patch adds support for this
> special register write sequence.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 80 ++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  1 +
>  drivers/gpu/drm/msm/adreno/a6xx_preempt.c | 20 ++++----
>  3 files changed, 90 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 45dd5fd1c2bfcb0a01b71a326c7d95b0f9496d99..a63dad80ef461da45d5c41a042ed4f19d8282ef5 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -16,6 +16,84 @@
>  
>  #define GPU_PAS_ID 13
>  
> +static bool fence_status_check(struct msm_gpu *gpu, u32 offset, u32 value, u32 status, u32 mask)
> +{
> +	/* Success if !writedropped0/1 */
> +	if (!(status & mask))
> +		return true;
> +
> +	udelay(10);
> +
> +	/* Try to update fenced register again */
> +	gpu_write(gpu, offset, value);
> +
> +	/* We can't do a posted write here because the power domain could be
> +	 * in collapse state. So use the heaviest barrier instead
> +	 */
> +	mb();
> +	return false;
> +}
> +
> +static int fenced_write(struct a6xx_gpu *a6xx_gpu, u32 offset, u32 value, u32 mask)
> +{
> +	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
> +	struct msm_gpu *gpu = &adreno_gpu->base;
> +	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
> +	u32 status;
> +
> +	gpu_write(gpu, offset, value);
> +
> +	/* Nothing else to be done in the case of no-GMU */
> +	if (adreno_has_gmu_wrapper(adreno_gpu))
> +		return 0;
> +
> +	/* We can't do a posted write here because the power domain could be
> +	 * in collapse state. So use the heaviest barrier instead
> +	 */

I'm not sure I follow - what's the relationship between the write being
posted and the power domain being collapsed (i.e. the hw not being
powered on)?

Are you trying to get rid of the delay that could happen between this
write leaving the CPU and arriving at the GPU (which would then be
woken up), so that the 1ms poll below has greater chance to succeed
because of how these "special registers" work?

Konrad

