Return-Path: <linux-kernel+bounces-899110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B554C56CA3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 609A53B3CB6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABF92D7D47;
	Thu, 13 Nov 2025 10:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f5DuOwsB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wv5u5nz9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4152E2E11D7
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763028961; cv=none; b=AYVbe6mNx6gU+XuJPi/vazlaiUFvrK+VuhVZuEJu5hV43gzwfZDnSZ4sQN+Kf2mbXpeEW5bmV5JlFYiJ/8BYWGZij/pLWC9Luc7h32ZcCNog2/oFeN2S+QMeqxM2USqjJe1DRnUWmO330QrE9A6gjrDKhhyI23WQAepFjrK+52Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763028961; c=relaxed/simple;
	bh=sj66I8SNTItlHb2oNlkq31INBfCrIpRs7vf798R/Qa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qlvH1EaDj6FpOY8DOUqY5xJhstQZOSvWsqeQItCHXUqT+2lTD9Ieea18J2hvW9dCtHSTmkHXxOhv9kRiCWnjm7HdUzXdB5M33fbKI5fQR52ccpmlCdmtUrD7bT7J36bdgPqFm54RPbLskb67xenKsTDm/Rtx7S29+B6ere/Gk2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f5DuOwsB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wv5u5nz9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD8ceB92962362
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JvCSjp0KOt/6f6FBApM09wUVTIiEbjk59DEEY4ZXJZM=; b=f5DuOwsBWJ0oPJ+7
	++1/bYzbYnOZyBwTIJIWwqoyhNJ5WsFSghy5OJPBoG61kMMQiXlg1sGG0njxd/M3
	+I5c9QK50V1RukgWtcZFN60ZxIu7n1XRRJ1DUQJkkyoybnyq/cAFcWp1GD23r5qy
	scktDcFNQip6wHIfZtNU38GveonTYxyONtE+7Qk54yaxRQL4xquX//+7XP5JXfm1
	hyfNp5cYTkRppB/Svc81t+TC+VKy2695vxHIQSUm/RmaR2XjiDjOYzquZxNZTSCA
	Mcp2NOTcMjJnplxn4M6ro3fG9g2y+O5/9q4xjis1X5OEGp9zamXxJ+InSx+1mOZW
	dV7RsA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acwbpu5h2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:15:57 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-88057e35c5bso1493426d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763028957; x=1763633757; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JvCSjp0KOt/6f6FBApM09wUVTIiEbjk59DEEY4ZXJZM=;
        b=Wv5u5nz994rGo5rMUk0WfedwiZmSeQXA276Meva8Ko/nxTIkAw7Jon4OIQdaiovRzB
         SA8u0FLaF21Hnjc9y+/kfK7vqXrJ6aThg+Y9XSE/7FRzRDJHGBCtqWMadivJUMHqImZw
         jJ73KKM21priOYhbIBlJSbdIIlAz12ehel8WfYle5EUkmSOvq1TvENqvWBBZjvjgI3LH
         /BkY08IM2lXOthKyG2M6rvOD3fzefOrZIBAI/55NPWiiYOD04zuAc2GE/U5AArnC7xRh
         53ZfvOrvHDF4zvL83K8xpnVS3gFDLQdtcW53eXPuwY3TpcaPBgoaGqjeEVjBwvQkQQLh
         GnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763028957; x=1763633757;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JvCSjp0KOt/6f6FBApM09wUVTIiEbjk59DEEY4ZXJZM=;
        b=pbFUdUrgqBQFfADio3jkCSzFIrLlKvN3rsIyvSVB3O8+qf22YwVcEOv3vMBtEQMKQ+
         hBJ/5YM5kvmIJI8h902WljeVpc//95Bt8BNGqEUAy/qG8os1Qsf8NwZ1OXHMsSHpuGBy
         3MQObcjAl8gqlCFpnuamDxbkE4FTiVLOl0PkagrrXs2oD0bYFVYy4mwgM0pgIi0BiM2K
         YalXaYEaVAaJxjo2h3S6S3/RZjzdETjXKcLJMCEo/3/Tkcnu+R82I+17BpKtT3F4QAl9
         JUEtg27PGNt8vwZkSTtCo/7r3cklSOQvEqWTAzYamoIlnUfsMeFjcApiQrCZwGgW2Jlh
         0zJw==
X-Forwarded-Encrypted: i=1; AJvYcCXkI0tb9hKqI+G0njXkTyOA6wF/TQ4y3fZbMj+0a4XdDV4YH5s2oqBQEUk3UN7rLyyQyIhscL+VaO2N41Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy9nndAZKrdJXQcKux20mQWrSPz2Jb/Cinbf9lcYt8EFbOKeTh
	TpKe/AOqLNnSUaf+BfsZPubnw+W7apyt/vU6CEhZ4gCpuraZCv0lEJRxRRcpLUrebuQK81bpBSq
	DOlXQB0G+5ovYJaEAXPjYYL8y7si6f5SCGlxxTBDH+NrizZILUGQDziX8R33s652LuLc=
X-Gm-Gg: ASbGncu+omJYvYV2XuvzBwBUB3vJHOwsBP3pfY03jD+2anKlsDEk/ccumIEl4pcyHr5
	9d8UsP/diAJ7SuLRJaVv9FOnpHNJADkp6/m6HpEI3bEzCsSHJuCL5TihR5IPgSsJx+Rtkf/b/f8
	qC/agkax5u/fu6Q5DHm3gbnhIjWGefMm9Kpylg03lUsk/96Xr8XqJtxXbqjviXHm8RM3CFJdktJ
	I9M7Rz80xfsLmYPU9I0hfYePRVz5Ag5Pxun2dppJjsLs3eRafnGxX703EwQ1CS7H+9Bx2To4sM2
	v3LJo/UC+pOw5pASreh3m0mwWSbV+Ebc2aOReoE48P7yIQTrpem8SBam7sh9WEwJVtCT59upoIw
	Tb8Nn8IoC8l6FKUQLsYRhf0hmGvusvDPyVux7+Qri1iURgLJBhpWZl1sL
X-Received: by 2002:a05:622a:34e:b0:4e0:b24a:6577 with SMTP id d75a77b69052e-4eddbc813a2mr56579841cf.2.1763028957202;
        Thu, 13 Nov 2025 02:15:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYGGvlMlXA3tlMF/ZtGBm8iwPIdQWTrlzVZ71x0zfbAy4zIV6GAjpA4kAum7jiWgiDmmhH8w==
X-Received: by 2002:a05:622a:34e:b0:4e0:b24a:6577 with SMTP id d75a77b69052e-4eddbc813a2mr56579561cf.2.1763028956628;
        Thu, 13 Nov 2025 02:15:56 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a3d8775sm1137866a12.5.2025.11.13.02.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 02:15:56 -0800 (PST)
Message-ID: <aff7043c-0029-433c-9340-22718909e583@oss.qualcomm.com>
Date: Thu, 13 Nov 2025 11:15:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/21] drm/msm/adreno: Introduce A8x GPU Support
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse
 <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Connor Abbott <cwabbott0@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org
References: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
 <20251110-kaana-gpu-support-v2-13-bef18acd5e94@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251110-kaana-gpu-support-v2-13-bef18acd5e94@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=NvjcssdJ c=1 sm=1 tr=0 ts=6915afdd cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=WeZqmzoOQpb_IxObF4IA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: BdHVZIBBahGUc4MveOIxRuPenQYPZVDq
X-Proofpoint-ORIG-GUID: BdHVZIBBahGUc4MveOIxRuPenQYPZVDq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA3NSBTYWx0ZWRfX3IJEJAmpJJ8/
 ssytCmr5DPYh6fmvU/RuME2BxIZxxGy3FwSY3gYZoafLOuk8buPbODW446e7BGnRCE4oY8Try9L
 SOxYFDrAJV7XK6IK+VwAOaF3QcKYddyBl4LM5oqRcIMY6uKdG+BXU20cXlyXTGM2aTOOPi6/07S
 zVtFJN/3WIU7uq8H96RdEYVwftLdtTuDrwspNdCbRfmhEiCW13rO42VArXrYRKmbKAYQ4zfUP9E
 ZoREzwRZEYFLYezIL0JNDnteiTsqgrvU/7fzggrDwY7cn2ESGUBfWRAayylaFSE3QaiqRdHSqZg
 gvtNJxkHLdUyv0HGeQoUs7PoPb0BmSRzsIKBE/xnsDXYE80QnClYW0jp4lPEsvC4Yi21gNmY6xW
 hJc1M5k7/Fg9lodqrKyy4+qW/Frf7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_01,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511130075

On 11/10/25 5:37 PM, Akhil P Oommen wrote:
> A8x is the next generation of Adreno GPUs, featuring a significant
> hardware design change. A major update to the design is the introduction
> of Slice architecture. Slices are sort of mini-GPUs within the GPU which
> are more independent in processing Graphics and compute workloads. Also,
> in addition to the BV and BR pipe we saw in A7x, CP has more concurrency
> with additional pipes.
> 
> From a software interface perspective, these changes have a significant
> impact on the KMD side. First, the GPU register space has been extensively
> reorganized. Second, to avoid  a register space explosion caused by the
> new slice architecture and additional pipes, many registers are now
> virtualized, instead of duplicated as in A7x. KMD must configure an
> aperture register with the appropriate slice and pipe ID before accessing
> these virtualized registers.
> 
> This patch adds only a skeleton support for the A8x family. An A8x GPU
> support will be added in an upcoming patch.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

[...]

> +static void a8xx_aperture_slice_set(struct msm_gpu *gpu, enum adreno_pipe pipe, u32 slice)
> +{
> +	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> +	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> +	u32 val;
> +
> +	val = A8XX_CP_APERTURE_CNTL_HOST_PIPEID(pipe) | A8XX_CP_APERTURE_CNTL_HOST_SLICEID(slice);

There's also a BIT(23) value here which is seemingly never set, but
perhaps may come in useful for the bigger GPU

> +
> +	if (a6xx_gpu->cached_aperture == val)
> +		return;
> +
> +	gpu_write(gpu, REG_A8XX_CP_APERTURE_CNTL_HOST, val);
> +
> +	a6xx_gpu->cached_aperture = val;
> +}
> +
> +static void a8xx_aperture_aquire(struct msm_gpu *gpu, enum adreno_pipe pipe, unsigned long *flags)

"acquire"

> +{
> +	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> +	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> +
> +	spin_lock_irqsave(&a6xx_gpu->aperture_lock, *flags);
> +
> +	a8xx_aperture_slice_set(gpu, pipe, 0);

Maybe we can add "unsigned long flags[MAX_NUM_SLICES]" to a6xx_gpu
to make the API a little more ergonomic.. but maybe that's too much
IDK

[...]

> +	a6xx_gpu->slice_mask = a6xx_llc_read(a6xx_gpu,
> +			REG_A8XX_CX_MISC_SLICE_ENABLE_FINAL) & GENMASK(3, 0);

Please define that field in the XML

[...]

> +}
> +
> +static u32 a8xx_get_first_slice(struct a6xx_gpu *a6xx_gpu)
> +{
> +	return ffs(a6xx_gpu->slice_mask) - 1;
> +}
> +
> +static inline bool _a8xx_check_idle(struct msm_gpu *gpu)
> +{
> +	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> +	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> +
> +	/* Check that the GMU is idle */
> +	if (!a6xx_gmu_isidle(&a6xx_gpu->gmu))
> +		return false;
> +
> +	/* Check that the CX master is idle */
> +	if (gpu_read(gpu, REG_A8XX_RBBM_STATUS) &
> +			~A8XX_RBBM_STATUS_CP_AHB_BUSY_CX_MASTER)
> +		return false;
> +
> +	return !(gpu_read(gpu, REG_A8XX_RBBM_INT_0_STATUS) &
> +		A6XX_RBBM_INT_0_MASK_RBBM_HANG_DETECT);

Odd parenthesis-alignment (couple times in the file), checkpatch
usually mumbles at that

[...]

> +
> +void a8xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
> +{
> +	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> +	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> +	uint32_t wptr;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ring->preempt_lock, flags);
> +
> +	/* Copy the shadow to the actual register */
> +	ring->cur = ring->next;
> +
> +	/* Make sure to wrap wptr if we need to */
> +	wptr = get_wptr(ring);
> +
> +	/* Update HW if this is the current ring and we are not in preempt*/
> +	if (!a6xx_in_preempt(a6xx_gpu)) {
> +		if (a6xx_gpu->cur_ring == ring)
> +			gpu_write(gpu, REG_A6XX_CP_RB_WPTR, wptr);

I think this should use _fenced too, but I guess the preempt detail
is just a harmless copypasta

[...]

> +static void a8xx_set_hwcg(struct msm_gpu *gpu, bool state)
> +{
> +	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> +	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> +	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
> +	u32 val;
> +
> +	gmu_write(gmu, REG_A6XX_GPU_GMU_AO_GMU_CGC_MODE_CNTL,
> +			state ? adreno_gpu->info->a6xx->gmu_cgc_mode : 0);
> +	gmu_write(gmu, REG_A6XX_GPU_GMU_AO_GMU_CGC_DELAY_CNTL,
> +			state ? 0x110111 : 0);

a840 sets this, a830 sets 0x10111, please confirm which way x2 skews

> +	gmu_write(gmu, REG_A6XX_GPU_GMU_AO_GMU_CGC_HYST_CNTL,
> +			state ? 0x55555 : 0);
> +
> +	gpu_write(gpu, REG_A8XX_RBBM_CLOCK_CNTL_GLOBAL, 1);
> +	gpu_write(gpu, REG_A8XX_RBBM_CGC_GLOBAL_LOAD_CMD, state ? 1 : 0);

!!state

[...]

> +static void a8xx_nonctxt_config(struct msm_gpu *gpu, u32 *gmem_protect)
> +{
> +	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> +	const struct a6xx_info *info = adreno_gpu->info->a6xx;
> +	const struct adreno_reglist_pipe *regs = info->nonctxt_reglist;
> +	unsigned int pipe_id, i;
> +	unsigned long flags;
> +
> +	for (pipe_id = PIPE_NONE; pipe_id <= PIPE_DDE_BV; pipe_id++) {
> +		/* We don't have support for LPAC yet */
> +		if (pipe_id == PIPE_LPAC)
> +			continue;

This seems arbitrary - one because there are no defines targetting PIPE_LPAC
specifcally in the reg lists you shared and two because it would almost
certainly not hurt to configure these registers and otherwise not power up
the LPAC pipeline

> +
> +		a8xx_aperture_aquire(gpu, pipe_id, &flags);
> +
> +		for (i = 0; regs[i].offset; i++) {
> +			if (!(BIT(pipe_id) & regs[i].pipe))
> +				continue;
> +
> +			if (regs[i].offset == REG_A8XX_RB_GC_GMEM_PROTECT)
> +				*gmem_protect = regs[i].value;
> +
> +			gpu_write(gpu, regs[i].offset, regs[i].value);
> +		}
> +
> +		a8xx_aperture_release(gpu, flags);
> +	}
> +
> +	a8xx_aperture_clear(gpu);
> +}
> +
> +static int a8xx_cp_init(struct msm_gpu *gpu)
> +{
> +	struct msm_ringbuffer *ring = gpu->rb[0];
> +	u32 mask;
> +
> +	/* Disable concurrent binning before sending CP init */
> +	OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
> +	OUT_RING(ring, BIT(27));
> +
> +	OUT_PKT7(ring, CP_ME_INIT, 4);
> +
> +	/* Use multiple HW contexts */
> +	mask = BIT(0);
> +
> +	/* Enable error detection */
> +	mask |= BIT(1);
> +
> +	/* Set default reset state */
> +	mask |= BIT(3);
> +
> +	/* Disable save/restore of performance counters across preemption */
> +	mask |= BIT(6);
> +
> +	OUT_RING(ring, mask);
> +
> +	/* Enable multiple hardware contexts */
> +	OUT_RING(ring, 0x00000003);
> +
> +	/* Enable error detection */
> +	OUT_RING(ring, 0x20000000);
> +
> +	/* Operation mode mask */
> +	OUT_RING(ring, 0x00000002);

Should we include the pwrup reglist from the get-go too? I don't think
you used the ones you declared in patch 15 (or at least my ctrl-f can't
find the use of it)

[...]

> +#define A8XX_CP_INTERRUPT_STATUS_MASK_PIPE \
> +	(A8XX_CP_INTERRUPT_STATUS_MASK_PIPE_CSFRBWRAP | \
> +	 A8XX_CP_INTERRUPT_STATUS_MASK_PIPE_CSFIB1WRAP | \
> +	 A8XX_CP_INTERRUPT_STATUS_MASK_PIPE_CSFIB2WRAP | \
> +	 A8XX_CP_INTERRUPT_STATUS_MASK_PIPE_CSFIB3WRAP | \
> +	 A8XX_CP_INTERRUPT_STATUS_MASK_PIPE_CSFSDSWRAP | \
> +	 A8XX_CP_INTERRUPT_STATUS_MASK_PIPE_CSFMRBWRAP | \
> +	 A8XX_CP_INTERRUPT_STATUS_MASK_PIPE_CSFVSDWRAP | \
> +	 A8XX_CP_INTERRUPT_STATUS_MASK_PIPE_OPCODEERROR | \
> +	 A8XX_CP_INTERRUPT_STATUS_MASK_PIPE_VSDPARITYERROR | \
> +	 A8XX_CP_INTERRUPT_STATUS_MASK_PIPE_REGISTERPROTECTIONERROR | \
> +	 A8XX_CP_INTERRUPT_STATUS_MASK_PIPE_ILLEGALINSTRUCTION | \
> +	 A8XX_CP_INTERRUPT_STATUS_MASK_PIPE_SMMUFAULT | \
> +	 A8XX_CP_INTERRUPT_STATUS_MASK_PIPE_VBIFRESP | \

kgsl also enables VBIFRESTP(TYPE/READ/LIENT)

[...]

> +	/* Setup GMEM Range in UCHE */
> +	gmem_range_min = SZ_64M;

this doesn't seem to ever change, you can inline it

[...]

> +static void a8xx_dump(struct msm_gpu *gpu)
> +{
> +	DRM_DEV_INFO(&gpu->pdev->dev, "status:   %08x\n",
> +			gpu_read(gpu, REG_A8XX_RBBM_STATUS));

This can be a single line

Konrad

