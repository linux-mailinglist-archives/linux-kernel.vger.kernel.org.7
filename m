Return-Path: <linux-kernel+bounces-874638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A78EEC16C15
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9AE64F68CF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F9C2BD59C;
	Tue, 28 Oct 2025 20:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c7MB7yi7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hp/bPJYe"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71D929E11E
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 20:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761682985; cv=none; b=sYEU2cAWudZZbuJbz5nilaYITNNDmDZ7TKyDyC8CE/qnZZ8lb2bI9ioPQQafDajK3JGElauipVeCi1CLEADp3qHcOCJgBKpcyYbAoEfG9nO2eQU5TA7Jdh1kiIeocmyF2tTNPRGHDbqQvL/epD4zYC5IpMTpRljKe4eKZ3J+ufQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761682985; c=relaxed/simple;
	bh=k7Pvh4+IZqOHbZLxiVDQt99E9hfg/xaz/UsTh3np7XE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YRuNuPNa/PnQzKnvZdttWeDsvVhh3sQcbdFBGRrR5KMshEnKdk18v98dOfETZ8MWwTpr538KRgi+T0WYDhV3ve18ke+1ECRMZ/KB/hYe0lXrnh7nSmvF8iNw96LGV/puaePc6qoZKX4wsqwBVoK+dVCLD39qC7vs00rjOAGKrWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c7MB7yi7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hp/bPJYe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SJlVaG2539437
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 20:23:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=a+Vwz3fUljVkqmIN9UhEAG/5sDPTIna51tYgjfORPcg=; b=c7
	MB7yi7P2NOci2vHETHVSUBx0oAtbHySifbO9cm4h0EOkQDQTEvUecI33w+aJoCH/
	IxtXX8So5lhtPp5tWt9dDQ8pmWlLVKjr2QLwBt64xwESawh/okqTkg0OXgMvoA4t
	B/m2rHc4L+vaCvXbRhCsqT/nfUM0hkBi4I6BMIoH/Nenk+f+yYC18aweuyu41txa
	R2NMrMYJBZkWNrFrw8nDny06NH7r9kYBRQkbjU7oquRVR4j1nhfdd7gNBCo5QRmB
	y1hlRDEteJpCP9o5tU4tZYICBvPj7a+zAJeRl2dZAEuyW7HoZWN2l53hxH5WBDNo
	Jct/8h1WQQU8s4zekMsQ==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a1g2w7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 20:23:00 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-654f1100759so1877121eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761682977; x=1762287777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a+Vwz3fUljVkqmIN9UhEAG/5sDPTIna51tYgjfORPcg=;
        b=Hp/bPJYeh503skr2qlIMhCGNSXf8N8g9jqRfJzS8ZBEh0RC44JM+EzaEGlR1S2SdFp
         vppLBR2yXRVtW5DKAxGBWGeQ2W4fck2E0NcwtCVk+NH1ArlbCsxWuBGqBjVq1mpGo1mH
         VBv2if2yS6QlWDjxoV/nN4ls/t7pntKu66PJvOR6ttTbkutJz6ittCPNzHgvSC/ayk5R
         2ZDuazrIujI5H6DpFpolPAHbFRvUP9SH7y5YJrbItxgXsxE4lgIKYg6b1pTpD/5PDh5u
         li0OTUssuizj+6GR2XimdU8aqHaakYOzxqR8SC0IVwBgylqjfaklpE+mk2MhXzKI9YNA
         BK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761682977; x=1762287777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a+Vwz3fUljVkqmIN9UhEAG/5sDPTIna51tYgjfORPcg=;
        b=p0EZ5lsLbTDvJbqWyLEEyWuuWN+OJCLBdwDPRkoxmZ4jYLO+l49Rmg28WXt3UGB11h
         yiT0hCeH0qqQKpf0j6/5xrFFuv55WawmEFFI8e7N8YvPVmU2/VF87eLFGOG9H6HV2xYW
         b4S1610cWTF30uLGNUXb3hU7BEYwROHZnZMLR7bbOJy8O2f27ZlZ4jc4drvtrWEVh3R3
         H9b9U0gQcUjsBDZ9wvfxv3N7P8GVoq3wTIambDXGyCl4kuRh7uXshHUZvn9r4iUm/oqk
         cdf9ngizw67/TJvXDUzaum7qlYLvSJJYTzh50zvwpyRb1vibCbl1z46Wh0QBLz8/SsX8
         DXIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVimfAUKZBrxGnZgvKaqlTAg/tRHFlRpkvckkz2yYuug9dtJGFn0xuo4e8Y+1rxISEMBad3voveBtAosCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPg6EWEP4EGsRP1BTM7RGUQRSIeKPIItCwcyvK3C4wblOUWWZy
	AO62xQ8Dkmp4YTqbnGpNsB2sSBRRtcsqHBIhhAfU+vTnHCxjqjxRd7EuWBS8r7+sRH8hoX9MWEi
	4oOKOGAFCHGvcJYHsjgHq5K91v0PC/jEvT0guo416WMUoZqyp8mBGqJiR33kuvKkRQZagnlTQhl
	Jg+wGBC7wOvFLqCLEiK90cOnj87BL3GS794IBCzFZb7A==
X-Gm-Gg: ASbGnct3CRJ63SSzPF0YMcl2OIKqBPnNki9GYDnLddV8tJx61HCPLLp9HXFzq7Z6mnH
	pxCwm5FKCmPS8od/CrTLT9g58uaURrbUQV4JhWQh9C3YjgGtcDHzUeYlq1+s3Co5J5rJBvw5siD
	z6a4AXKYsYlDlu1FQa5rBmct9zvzOCCEEFKjvzJH2T57xnNB8Gw6UWETgV0nHR1OjAZxfStOE/U
	SkfD0fnEvUdjeI=
X-Received: by 2002:a05:6808:1983:b0:43f:68a3:625d with SMTP id 5614622812f47-44f7a75b3camr401587b6e.5.1761682976504;
        Tue, 28 Oct 2025 13:22:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDTTBeERnwNoIxP6/EU+teL5FUQPBhliZRB7borsBRdAq/SZUcL8Zar7hWpL+CJbupFaMLKuiHRtBTNf5WGSE=
X-Received: by 2002:a05:6808:1983:b0:43f:68a3:625d with SMTP id
 5614622812f47-44f7a75b3camr401548b6e.5.1761682975569; Tue, 28 Oct 2025
 13:22:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com> <20250930-kaana-gpu-support-v1-12-73530b0700ed@oss.qualcomm.com>
In-Reply-To: <20250930-kaana-gpu-support-v1-12-73530b0700ed@oss.qualcomm.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 13:22:43 -0700
X-Gm-Features: AWmQ_bmvzbFVf5keFUYm5Ti6gHrCrQR8_BAN8lrdz0I2ZeYNRAc7Y9etGPr4DP8
Message-ID: <CACSVV03HaKAvfDa5A5LqRZM4_o8g-haVU3A6GgWqfTO0QNcK2w@mail.gmail.com>
Subject: Re: [PATCH 12/17] drm/msm/adreno: Introduce A8x GPU Support
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Nu/cssdJ c=1 sm=1 tr=0 ts=69012624 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8
 a=2FcyS5ZzHI4p1F1skQsA:9 a=QEXdDO2ut3YA:10 a=WZGXeFmKUf7gPmL3hEjn:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: TtOLCWx-ZLiON9PDxt4UE1JTYPFMfR0-
X-Proofpoint-ORIG-GUID: TtOLCWx-ZLiON9PDxt4UE1JTYPFMfR0-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE3MSBTYWx0ZWRfX0pdNTbuvgmFG
 bFPaBdQ5Kee7H1bGGHM1aBLMWpfQr46+3GWQ0wzPkDV5eMfqstOmw9nVPGrPUz7sCVmJNKjpKhY
 6uSh359gAzkzOwfEOwNiQ9niGauJzZRctEP35G5YulPPaivXZZD6jGLFc1wsKfX85kWNpArQ7Rh
 ssopGLR5RqexZm9vQyhMH2Wm8FmXE137FR5BRmP+Jlxj5tzl14zESD514/DDT1R6I4FbeonKA2R
 g9QlbsslcyekPSplNeRNBj/agOiX2O3KyCkcVenT1h29hnPDbiWP8BG7rjzwz4Z4JyyhA+/ZGXZ
 GJD1tLionqzL4EOlT13DQEhomzItLiZ/lL2wAsP7eXeAhNRSuqdxxuWb+c5HXzjfkDJ1f1nTcB2
 NcgvMwqIvO7/jckN48BWZF0oK3xiBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510280171

On Mon, Sep 29, 2025 at 10:51=E2=80=AFPM Akhil P Oommen
<akhilpo@oss.qualcomm.com> wrote:
>
> A8x is the next generation of Adreno GPUs, featuring a significant
> hardware design change. A major update to the design is the introduction
> of Slice architecture. Slices are sort of mini-GPUs within the GPU which
> are more independent in processing Graphics and compute workloads. Also,
> in addition to the BV and BR pipe we saw in A7x, CP has more concurrency
> with additional pipes.
>
> From a software interface perspective, these changes have a significant
> impact on the KMD side. First, the GPU register space has been extensivel=
y
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
>  drivers/gpu/drm/msm/Makefile                      |    1 +
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c             |  103 +-
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h             |   21 +
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c             | 1238 +++++++++++++++=
++++++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h           |    7 +
>  drivers/gpu/drm/msm/registers/adreno/a6xx.xml     |    1 -
>  drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml |    1 +
>  7 files changed, 1344 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
> index 7acf2cc13cd047eb7f5b3f14e1a42a1cc145e087..8aa7d07303fb0cd66869767cb=
6298b38a621b366 100644
> --- a/drivers/gpu/drm/msm/Makefile
> +++ b/drivers/gpu/drm/msm/Makefile
> @@ -24,6 +24,7 @@ adreno-y :=3D \
>         adreno/a6xx_gmu.o \
>         adreno/a6xx_hfi.o \
>         adreno/a6xx_preempt.o \
> +       adreno/a8xx_gpu.o \
>
>  adreno-$(CONFIG_DEBUG_FS) +=3D adreno/a5xx_debugfs.o \
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.c
> index bd4f98b5457356c5454d0316e59d7e8253401712..4aeeaceb1fb30a9d68ac636c1=
4249e3853ef73ac 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -239,14 +239,21 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6x=
x_gpu,
>         }
>
>         if (!sysprof) {
> -               if (!adreno_is_a7xx(adreno_gpu)) {
> +               if (!(adreno_is_a7xx(adreno_gpu) || adreno_is_a8xx(adreno=
_gpu))) {
>                         /* Turn off protected mode to write to special re=
gisters */
>                         OUT_PKT7(ring, CP_SET_PROTECTED_MODE, 1);
>                         OUT_RING(ring, 0);
>                 }
>
> -               OUT_PKT4(ring, REG_A6XX_RBBM_PERFCTR_SRAM_INIT_CMD, 1);
> -               OUT_RING(ring, 1);
> +               if (adreno_is_a8xx(adreno_gpu)) {
> +                       OUT_PKT4(ring, REG_A8XX_RBBM_PERFCTR_SRAM_INIT_CM=
D, 1);
> +                       OUT_RING(ring, 1);
> +                       OUT_PKT4(ring, REG_A8XX_RBBM_SLICE_PERFCTR_SRAM_I=
NIT_CMD, 1);
> +                       OUT_RING(ring, 1);
> +               } else {
> +                       OUT_PKT4(ring, REG_A6XX_RBBM_PERFCTR_SRAM_INIT_CM=
D, 1);
> +                       OUT_RING(ring, 1);
> +               }
>         }
>
>         /* Execute the table update */
> @@ -275,7 +282,7 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_=
gpu,
>          * to make sure BV doesn't race ahead while BR is still switching
>          * pagetables.
>          */
> -       if (adreno_is_a7xx(&a6xx_gpu->base)) {
> +       if (adreno_is_a7xx(&a6xx_gpu->base) && adreno_is_a8xx(&a6xx_gpu->=
base)) {
>                 OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
>                 OUT_RING(ring, CP_THREAD_CONTROL_0_SYNC_THREADS | CP_SET_=
THREAD_BR);
>         }
> @@ -289,20 +296,22 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6x=
x_gpu,
>         OUT_RING(ring, CACHE_INVALIDATE);
>
>         if (!sysprof) {
> +               u32 reg_status =3D adreno_is_a8xx(adreno_gpu) ?
> +                       REG_A8XX_RBBM_PERFCTR_SRAM_INIT_STATUS :
> +                       REG_A6XX_RBBM_PERFCTR_SRAM_INIT_STATUS;
>                 /*
>                  * Wait for SRAM clear after the pgtable update, so the
>                  * two can happen in parallel:
>                  */
>                 OUT_PKT7(ring, CP_WAIT_REG_MEM, 6);
>                 OUT_RING(ring, CP_WAIT_REG_MEM_0_FUNCTION(WRITE_EQ));
> -               OUT_RING(ring, CP_WAIT_REG_MEM_POLL_ADDR_LO(
> -                               REG_A6XX_RBBM_PERFCTR_SRAM_INIT_STATUS));
> +               OUT_RING(ring, CP_WAIT_REG_MEM_POLL_ADDR_LO(reg_status));
>                 OUT_RING(ring, CP_WAIT_REG_MEM_POLL_ADDR_HI(0));
>                 OUT_RING(ring, CP_WAIT_REG_MEM_3_REF(0x1));
>                 OUT_RING(ring, CP_WAIT_REG_MEM_4_MASK(0x1));
>                 OUT_RING(ring, CP_WAIT_REG_MEM_5_DELAY_LOOP_CYCLES(0));
>
> -               if (!adreno_is_a7xx(adreno_gpu)) {
> +               if (!(adreno_is_a7xx(adreno_gpu) || adreno_is_a8xx(adreno=
_gpu))) {
>                         /* Re-enable protected mode: */
>                         OUT_PKT7(ring, CP_SET_PROTECTED_MODE, 1);
>                         OUT_RING(ring, 1);
> @@ -441,6 +450,7 @@ static void a7xx_submit(struct msm_gpu *gpu, struct m=
sm_gem_submit *submit)
>         struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
>         struct msm_ringbuffer *ring =3D submit->ring;
>         unsigned int i, ibs =3D 0;
> +       u32 rbbm_perfctr_cp0, cp_always_on_counter;
>
>         adreno_check_and_reenable_stall(adreno_gpu);
>
> @@ -460,10 +470,16 @@ static void a7xx_submit(struct msm_gpu *gpu, struct=
 msm_gem_submit *submit)
>         if (gpu->nr_rings > 1)
>                 a6xx_emit_set_pseudo_reg(ring, a6xx_gpu, submit->queue);
>
> -       get_stats_counter(ring, REG_A7XX_RBBM_PERFCTR_CP(0),
> -               rbmemptr_stats(ring, index, cpcycles_start));
> -       get_stats_counter(ring, REG_A6XX_CP_ALWAYS_ON_COUNTER,
> -               rbmemptr_stats(ring, index, alwayson_start));
> +       if (adreno_is_a8xx(adreno_gpu)) {
> +               rbbm_perfctr_cp0 =3D REG_A8XX_RBBM_PERFCTR_CP(0);
> +               cp_always_on_counter =3D REG_A8XX_CP_ALWAYS_ON_COUNTER;
> +       } else {
> +               rbbm_perfctr_cp0 =3D REG_A7XX_RBBM_PERFCTR_CP(0);
> +               cp_always_on_counter =3D REG_A6XX_CP_ALWAYS_ON_COUNTER;
> +       }
> +
> +       get_stats_counter(ring, rbbm_perfctr_cp0, rbmemptr_stats(ring, in=
dex, cpcycles_start));
> +       get_stats_counter(ring, cp_always_on_counter, rbmemptr_stats(ring=
, index, alwayson_start));
>
>         OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
>         OUT_RING(ring, CP_SET_THREAD_BOTH);
> @@ -510,10 +526,8 @@ static void a7xx_submit(struct msm_gpu *gpu, struct =
msm_gem_submit *submit)
>                 OUT_RING(ring, 0x00e); /* IB1LIST end */
>         }
>
> -       get_stats_counter(ring, REG_A7XX_RBBM_PERFCTR_CP(0),
> -               rbmemptr_stats(ring, index, cpcycles_end));
> -       get_stats_counter(ring, REG_A6XX_CP_ALWAYS_ON_COUNTER,
> -               rbmemptr_stats(ring, index, alwayson_end));
> +       get_stats_counter(ring, rbbm_perfctr_cp0, rbmemptr_stats(ring, in=
dex, cpcycles_end));
> +       get_stats_counter(ring, cp_always_on_counter, rbmemptr_stats(ring=
, index, alwayson_end));
>
>         /* Write the fence to the scratch register */
>         OUT_PKT4(ring, REG_A6XX_CP_SCRATCH(2), 1);
> @@ -706,8 +720,11 @@ static int a6xx_calc_ubwc_config(struct adreno_gpu *=
gpu)
>         /* Copy the data into the internal struct to drop the const quali=
fier (temporarily) */
>         *cfg =3D *common_cfg;
>
> -       cfg->ubwc_swizzle =3D 0x6;
> -       cfg->highest_bank_bit =3D 15;
> +       /* Use common config as is for A8x */
> +       if (!adreno_is_a8xx(gpu)) {
> +               cfg->ubwc_swizzle =3D 0x6;
> +               cfg->highest_bank_bit =3D 15;
> +       }
>
>         if (adreno_is_a610(gpu)) {
>                 cfg->highest_bank_bit =3D 13;
> @@ -818,7 +835,7 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
>                   cfg->macrotile_mode);
>  }
>
> -static void a7xx_patch_pwrup_reglist(struct msm_gpu *gpu)
> +void a7xx_patch_pwrup_reglist(struct msm_gpu *gpu)
>  {
>         struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
>         struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> @@ -868,7 +885,7 @@ static void a7xx_patch_pwrup_reglist(struct msm_gpu *=
gpu)
>         lock->dynamic_list_len =3D 0;
>  }
>
> -static int a7xx_preempt_start(struct msm_gpu *gpu)
> +int a7xx_preempt_start(struct msm_gpu *gpu)
>  {
>         struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
>         struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> @@ -925,7 +942,7 @@ static int a6xx_cp_init(struct msm_gpu *gpu)
>         return a6xx_idle(gpu, ring) ? 0 : -EINVAL;
>  }
>
> -static int a7xx_cp_init(struct msm_gpu *gpu)
> +int a7xx_cp_init(struct msm_gpu *gpu)
>  {
>         struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
>         struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> @@ -993,7 +1010,7 @@ static bool a6xx_ucode_check_version(struct a6xx_gpu=
 *a6xx_gpu,
>                 return false;
>
>         /* A7xx is safe! */
> -       if (adreno_is_a7xx(adreno_gpu) || adreno_is_a702(adreno_gpu))
> +       if (adreno_is_a7xx(adreno_gpu) || adreno_is_a702(adreno_gpu) || a=
dreno_is_a8xx(adreno_gpu))
>                 return true;
>
>         /*
> @@ -2161,7 +2178,7 @@ void a6xx_bus_clear_pending_transactions(struct adr=
eno_gpu *adreno_gpu, bool gx_
>  void a6xx_gpu_sw_reset(struct msm_gpu *gpu, bool assert)
>  {
>         /* 11nm chips (e.g. ones with A610) have hw issues with the reset=
 line! */
> -       if (adreno_is_a610(to_adreno_gpu(gpu)))
> +       if (adreno_is_a610(to_adreno_gpu(gpu)) || adreno_is_a8xx(to_adren=
o_gpu(gpu)))
>                 return;
>
>         gpu_write(gpu, REG_A6XX_RBBM_SW_RESET_CMD, assert);
> @@ -2192,7 +2209,12 @@ static int a6xx_gmu_pm_resume(struct msm_gpu *gpu)
>
>         msm_devfreq_resume(gpu);
>
> -       adreno_is_a7xx(adreno_gpu) ? a7xx_llc_activate(a6xx_gpu) : a6xx_l=
lc_activate(a6xx_gpu);
> +       if (adreno_is_a8xx(adreno_gpu))
> +               a8xx_llc_activate(a6xx_gpu);
> +       else if (adreno_is_a7xx(adreno_gpu))
> +               a7xx_llc_activate(a6xx_gpu);
> +       else
> +               a6xx_llc_activate(a6xx_gpu);
>
>         return ret;
>  }
> @@ -2561,10 +2583,8 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_de=
vice *dev)
>         adreno_gpu->base.hw_apriv =3D
>                 !!(config->info->quirks & ADRENO_QUIRK_HAS_HW_APRIV);
>
> -       /* gpu->info only gets assigned in adreno_gpu_init() */
> -       is_a7xx =3D config->info->family =3D=3D ADRENO_7XX_GEN1 ||
> -                 config->info->family =3D=3D ADRENO_7XX_GEN2 ||
> -                 config->info->family =3D=3D ADRENO_7XX_GEN3;
> +       /* gpu->info only gets assigned in adreno_gpu_init(). A8x is incl=
uded intentionally */
> +       is_a7xx =3D config->info->family >=3D ADRENO_7XX_GEN1;
>
>         a6xx_llc_slices_init(pdev, a6xx_gpu, is_a7xx);
>
> @@ -2730,3 +2750,32 @@ const struct adreno_gpu_funcs a7xx_gpu_funcs =3D {
>         .bus_halt =3D a6xx_bus_clear_pending_transactions,
>         .mmu_fault_handler =3D a6xx_fault_handler,
>  };
> +
> +const struct adreno_gpu_funcs a8xx_gpu_funcs =3D {
> +       .base =3D {
> +               .get_param =3D adreno_get_param,
> +               .set_param =3D adreno_set_param,
> +               .hw_init =3D a8xx_hw_init,
> +               .ucode_load =3D a6xx_ucode_load,
> +               .pm_suspend =3D a6xx_gmu_pm_suspend,
> +               .pm_resume =3D a6xx_gmu_pm_resume,
> +               .recover =3D a8xx_recover,
> +               .submit =3D a7xx_submit,
> +               .active_ring =3D a6xx_active_ring,
> +               .irq =3D a8xx_irq,
> +               .destroy =3D a6xx_destroy,
> +               .gpu_busy =3D a8xx_gpu_busy,
> +               .gpu_get_freq =3D a6xx_gmu_get_freq,
> +               .gpu_set_freq =3D a6xx_gpu_set_freq,
> +               .create_vm =3D a6xx_create_vm,
> +               .create_private_vm =3D a6xx_create_private_vm,
> +               .get_rptr =3D a6xx_get_rptr,
> +               .progress =3D a8xx_progress,
> +       },
> +       .init =3D a6xx_gpu_init,
> +       .get_timestamp =3D a8xx_gmu_get_timestamp,
> +       .submit_flush =3D a8xx_flush,
> +       .feature_probe =3D a8xx_gpu_feature_probe,
> +       .bus_halt =3D a8xx_bus_clear_pending_transactions,
> +       .mmu_fault_handler =3D a8xx_fault_handler,
> +};
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.h
> index 0b17d36c36a9567e6afa4269ae7783ed3578e40e..18300b12bf2a8bcd5601797df=
0fcc7afa8943863 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> @@ -46,6 +46,7 @@ struct a6xx_info {
>         const struct adreno_protect *protect;
>         const struct adreno_reglist_list *pwrup_reglist;
>         const struct adreno_reglist_list *ifpc_reglist;
> +       const struct adreno_reglist_pipe *nonctxt_reglist;
>         u32 gmu_chipid;
>         u32 gmu_cgc_mode;
>         u32 prim_fifo_threshold;
> @@ -101,6 +102,11 @@ struct a6xx_gpu {
>         void *htw_llc_slice;
>         bool have_mmu500;
>         bool hung;
> +
> +       u32 cached_aperture;
> +       spinlock_t aperture_lock;

I don't see aperture_lock used.. but seems like maybe a good idea if
a8xx_aperture_slice_set() acquired the lock and we had an
corresponding _release() which dropped the lock, so that we couldn't
have race conditions between the users of the aperture.

BR,
-R

> +
> +       u32 slice_mask;
>  };
>
>  #define to_a6xx_gpu(x) container_of(x, struct a6xx_gpu, base)
> @@ -299,4 +305,19 @@ void a6xx_bus_clear_pending_transactions(struct adre=
no_gpu *adreno_gpu, bool gx_
>  void a6xx_gpu_sw_reset(struct msm_gpu *gpu, bool assert);
>  int a6xx_fenced_write(struct a6xx_gpu *gpu, u32 offset, u64 value, u32 m=
ask, bool is_64b);
>
> +void a7xx_patch_pwrup_reglist(struct msm_gpu *gpu);
> +int a7xx_preempt_start(struct msm_gpu *gpu);
> +int a7xx_cp_init(struct msm_gpu *gpu);
> +
> +void a8xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_gpu, =
bool gx_off);
> +int a8xx_fault_handler(void *arg, unsigned long iova, int flags, void *d=
ata);
> +void a8xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
> +int a8xx_gmu_get_timestamp(struct msm_gpu *gpu, uint64_t *value);
> +u64 a8xx_gpu_busy(struct msm_gpu *gpu, unsigned long *out_sample_rate);
> +int a8xx_gpu_feature_probe(struct msm_gpu *gpu);
> +int a8xx_hw_init(struct msm_gpu *gpu);
> +irqreturn_t a8xx_irq(struct msm_gpu *gpu);
> +void a8xx_llc_activate(struct a6xx_gpu *a6xx_gpu);
> +bool a8xx_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
> +void a8xx_recover(struct msm_gpu *gpu);
>  #endif /* __A6XX_GPU_H__ */
> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a8xx_gpu.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..6a64b1f96d730a46301545c52=
a83d62dddc6c2ff
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> @@ -0,0 +1,1238 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries. */
> +
> +
> +#include "msm_gem.h"
> +#include "msm_mmu.h"
> +#include "msm_gpu_trace.h"
> +#include "a6xx_gpu.h"
> +#include "a6xx_gmu.xml.h"
> +
> +#include <linux/bitfield.h>
> +#include <linux/devfreq.h>
> +#include <linux/firmware/qcom/qcom_scm.h>
> +#include <linux/pm_domain.h>
> +#include <linux/soc/qcom/llcc-qcom.h>
> +
> +#define GPU_PAS_ID 13
> +
> +static void a8xx_aperture_slice_set(struct msm_gpu *gpu, enum adreno_pip=
e pipe, u32 slice)
> +{
> +       struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> +       struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> +       u32 val;
> +
> +       val =3D A8XX_CP_APERTURE_CNTL_HOST_PIPEID(pipe) | A8XX_CP_APERTUR=
E_CNTL_HOST_SLICEID(slice);
> +
> +       if (a6xx_gpu->cached_aperture =3D=3D val)
> +               return;
> +
> +       gpu_write(gpu, REG_A8XX_CP_APERTURE_CNTL_HOST, val);
> +
> +       a6xx_gpu->cached_aperture =3D val;
> +}
> +
> +static void a8xx_aperture_set(struct msm_gpu *gpu, enum adreno_pipe pipe=
)
> +{
> +       a8xx_aperture_slice_set(gpu, pipe, 0);
> +}
> +
> +static void a8xx_write_pipe(struct msm_gpu *gpu, enum adreno_pipe pipe, =
u32 offset, u32 data)
> +{
> +       a8xx_aperture_set(gpu, pipe);
> +
> +       gpu_write(gpu, offset, data);
> +}
> +
> +static u32 a8xx_read_pipe(struct msm_gpu *gpu, enum adreno_pipe pipe, u3=
2 offset)
> +{
> +       a8xx_aperture_set(gpu, pipe);
> +
> +       return gpu_read(gpu, offset);
> +}
> +
> +static u32 a8xx_read_pipe_slice(struct msm_gpu *gpu, enum adreno_pipe pi=
pe, u32 slice, u32 offset)
> +{
> +       a8xx_aperture_slice_set(gpu, pipe, slice);
> +
> +       return gpu_read(gpu, offset);
> +}
> +
> +static void a8xx_gpu_get_slice_info(struct msm_gpu *gpu)
> +{
> +       struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> +       struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> +
> +       if (adreno_gpu->info->family < ADRENO_8XX_GEN1)
> +               return;
> +
> +       if (a6xx_gpu->slice_mask)
> +               return;
> +
> +       a6xx_gpu->slice_mask =3D a6xx_llc_read(a6xx_gpu,
> +                       REG_A8XX_CX_MISC_SLICE_ENABLE_FINAL) & GENMASK(3,=
 0);
> +}
> +
> +static u32 a8xx_get_first_slice(struct a6xx_gpu *a6xx_gpu)
> +{
> +       return ffs(a6xx_gpu->slice_mask) - 1;
> +}
> +
> +static inline bool _a8xx_check_idle(struct msm_gpu *gpu)
> +{
> +       struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> +       struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> +
> +       /* Check that the GMU is idle */
> +       if (!a6xx_gmu_isidle(&a6xx_gpu->gmu))
> +               return false;
> +
> +       /* Check that the CX master is idle */
> +       if (gpu_read(gpu, REG_A8XX_RBBM_STATUS) &
> +                       ~A8XX_RBBM_STATUS_CP_AHB_BUSY_CX_MASTER)
> +               return false;
> +
> +       return !(gpu_read(gpu, REG_A8XX_RBBM_INT_0_STATUS) &
> +               A6XX_RBBM_INT_0_MASK_RBBM_HANG_DETECT);
> +}
> +
> +static bool a8xx_idle(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
> +{
> +       /* wait for CP to drain ringbuffer: */
> +       if (!adreno_idle(gpu, ring))
> +               return false;
> +
> +       if (spin_until(_a8xx_check_idle(gpu))) {
> +               DRM_ERROR("%s: %ps: timeout waiting for GPU to idle: stat=
us %8.8X irq %8.8X rptr/wptr %d/%d\n",
> +                       gpu->name, __builtin_return_address(0),
> +                       gpu_read(gpu, REG_A8XX_RBBM_STATUS),
> +                       gpu_read(gpu, REG_A8XX_RBBM_INT_0_STATUS),
> +                       gpu_read(gpu, REG_A6XX_CP_RB_RPTR),
> +                       gpu_read(gpu, REG_A6XX_CP_RB_WPTR));
> +               return false;
> +       }
> +
> +       return true;
> +}
> +
> +void a8xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
> +{
> +       struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> +       struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> +       uint32_t wptr;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&ring->preempt_lock, flags);
> +
> +       /* Copy the shadow to the actual register */
> +       ring->cur =3D ring->next;
> +
> +       /* Make sure to wrap wptr if we need to */
> +       wptr =3D get_wptr(ring);
> +
> +       /* Update HW if this is the current ring and we are not in preemp=
t*/
> +       if (!a6xx_in_preempt(a6xx_gpu)) {
> +               if (a6xx_gpu->cur_ring =3D=3D ring)
> +                       gpu_write(gpu, REG_A6XX_CP_RB_WPTR, wptr);
> +               else
> +                       ring->restore_wptr =3D true;
> +       } else {
> +               ring->restore_wptr =3D true;
> +       }
> +
> +       spin_unlock_irqrestore(&ring->preempt_lock, flags);
> +}
> +
> +static void a8xx_set_hwcg(struct msm_gpu *gpu, bool state)
> +{
> +       struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> +       struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> +       struct a6xx_gmu *gmu =3D &a6xx_gpu->gmu;
> +       u32 val;
> +
> +       gmu_write(gmu, REG_A6XX_GPU_GMU_AO_GMU_CGC_MODE_CNTL,
> +                       state ? adreno_gpu->info->a6xx->gmu_cgc_mode : 0)=
;
> +       gmu_write(gmu, REG_A6XX_GPU_GMU_AO_GMU_CGC_DELAY_CNTL,
> +                       state ? 0x110111 : 0);
> +       gmu_write(gmu, REG_A6XX_GPU_GMU_AO_GMU_CGC_HYST_CNTL,
> +                       state ? 0x55555 : 0);
> +
> +       gpu_write(gpu, REG_A8XX_RBBM_CLOCK_CNTL_GLOBAL, 1);
> +       gpu_write(gpu, REG_A8XX_RBBM_CGC_GLOBAL_LOAD_CMD, state ? 1 : 0);
> +
> +       if (state) {
> +               gpu_write(gpu, REG_A8XX_RBBM_CGC_P2S_TRIG_CMD, 1);
> +
> +               if (gpu_poll_timeout(gpu, REG_A8XX_RBBM_CGC_P2S_STATUS, v=
al,
> +                                    val & A8XX_RBBM_CGC_P2S_STATUS_TXDON=
E, 1, 10)) {
> +                       dev_err(&gpu->pdev->dev, "RBBM_CGC_P2S_STATUS TXD=
ONE Poll failed\n");
> +                       return;
> +               }
> +
> +               gpu_write(gpu, REG_A8XX_RBBM_CLOCK_CNTL_GLOBAL, 0);
> +       } else {
> +               /*
> +                * GMU enables clk gating in GBIF during boot up. So, ove=
rride that here when
> +                * hwcg feature is disabled
> +                */
> +               gpu_rmw(gpu, REG_A8XX_GBIF_CX_CONFIG, BIT(0), 0);
> +       }
> +}
> +
> +static void a8xx_set_cp_protect(struct msm_gpu *gpu)
> +{
> +       struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> +       const struct adreno_protect *protect =3D adreno_gpu->info->a6xx->=
protect;
> +       unsigned int i;
> +       u32 cntl;
> +
> +
> +       cntl =3D A8XX_CP_PROTECT_CNTL_PIPE_ACCESS_PROT_EN |
> +               A8XX_CP_PROTECT_CNTL_PIPE_ACCESS_FAULT_ON_VIOL_EN |
> +               A8XX_CP_PROTECT_CNTL_PIPE_LAST_SPAN_INF_RANGE;
> +       /*
> +        * Enable access protection to privileged registers, fault on an =
access
> +        * protect violation and select the last span to protect from the=
 start
> +        * address all the way to the end of the register address space
> +        */
> +       a8xx_write_pipe(gpu, PIPE_BR, REG_A8XX_CP_PROTECT_CNTL_PIPE, cntl=
);
> +       a8xx_write_pipe(gpu, PIPE_BV, REG_A8XX_CP_PROTECT_CNTL_PIPE, cntl=
);
> +
> +       /* Clear aperture */
> +       a8xx_aperture_set(gpu, 0);
> +
> +       for (i =3D 0; i < protect->count - 1; i++) {
> +               /* Intentionally skip writing to some registers */
> +               if (protect->regs[i])
> +                       gpu_write(gpu, REG_A8XX_CP_PROTECT_GLOBAL(i), pro=
tect->regs[i]);
> +       }
> +       /* last CP_PROTECT to have "infinite" length on the last entry */
> +       gpu_write(gpu, REG_A8XX_CP_PROTECT_GLOBAL(protect->count_max - 1)=
, protect->regs[i]);
> +
> +       /* Last span feature is only supported on PIPE specific register.=
 So update those here */
> +       a8xx_write_pipe(gpu, PIPE_BR, REG_A8XX_CP_PROTECT_PIPE(15), prote=
ct->regs[i]);
> +       a8xx_write_pipe(gpu, PIPE_BV, REG_A8XX_CP_PROTECT_PIPE(15), prote=
ct->regs[i]);
> +
> +       /* Clear aperture */
> +       a8xx_aperture_set(gpu, 0);
> +}
> +
> +static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
> +{
> +       struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> +       const struct qcom_ubwc_cfg_data *cfg =3D adreno_gpu->ubwc_config;
> +       /*
> +        * We subtract 13 from the highest bank bit (13 is the minimum va=
lue
> +        * allowed by hw) and write the lowest two bits of the remaining =
value
> +        * as hbb_lo and the one above it as hbb_hi to the hardware.
> +        */
> +       WARN_ON(cfg->highest_bank_bit < 13);
> +       u32 hbb =3D cfg->highest_bank_bit - 13;
> +       u32 level2_swizzling_dis =3D !(cfg->ubwc_swizzle & UBWC_SWIZZLE_E=
NABLE_LVL2);
> +       u32 level3_swizzling_dis =3D !(cfg->ubwc_swizzle & UBWC_SWIZZLE_E=
NABLE_LVL3);
> +       u32 ubwc_version =3D cfg->ubwc_enc_version;
> +       bool yuvnotcomptofc =3D false, min_acc_len_64b =3D false;
> +       bool rgb565_predicator =3D false, amsbc =3D false;
> +       bool ubwc_mode =3D qcom_ubwc_get_ubwc_mode(cfg);
> +       bool rgba8888_lossless =3D false, fp16compoptdis =3D false;
> +       u8 uavflagprd_inv =3D 2;
> +       u32 hbb_hi =3D hbb >> 2;
> +       u32 hbb_lo =3D hbb & 3;
> +       u32 mode =3D 1;
> +
> +       switch (ubwc_version) {
> +       case UBWC_6_0:
> +               yuvnotcomptofc =3D true;
> +               mode =3D 5;
> +               break;
> +       case UBWC_5_0:
> +               amsbc =3D true;
> +               rgb565_predicator =3D true;
> +               mode =3D 4;
> +               break;
> +       case UBWC_4_0:
> +               amsbc =3D true;
> +               rgb565_predicator =3D true;
> +               fp16compoptdis =3D true;
> +               rgba8888_lossless =3D true;
> +               mode =3D 2;
> +               break;
> +       case UBWC_3_0:
> +               amsbc =3D true;
> +               mode =3D 1;
> +               break;
> +       default:
> +               dev_err(&gpu->pdev->dev, "Unknown UBWC version: 0x%x\n", =
ubwc_version);
> +               break;
> +       }
> +
> +       a8xx_write_pipe(gpu, PIPE_BV, REG_A8XX_GRAS_NC_MODE_CNTL, hbb << =
5);
> +       a8xx_write_pipe(gpu, PIPE_BR, REG_A8XX_GRAS_NC_MODE_CNTL, hbb << =
5);
> +
> +       a8xx_write_pipe(gpu, PIPE_BR, REG_A8XX_RB_CCU_NC_MODE_CNTL,
> +                       yuvnotcomptofc << 6 |
> +                       hbb_hi << 3 |
> +                       hbb_lo << 1);
> +
> +       a8xx_write_pipe(gpu, PIPE_BR, REG_A8XX_RB_CMP_NC_MODE_CNTL,
> +                       mode << 15 |
> +                       yuvnotcomptofc << 6 |
> +                       rgba8888_lossless << 4 |
> +                       fp16compoptdis << 3 |
> +                       rgb565_predicator << 2 |
> +                       amsbc << 1 |
> +                       min_acc_len_64b);
> +
> +       /* Clear aperture */
> +       a8xx_aperture_set(gpu, 0);
> +
> +       gpu_write(gpu, REG_A6XX_SP_NC_MODE_CNTL,
> +                 level3_swizzling_dis << 13 |
> +                 level2_swizzling_dis << 12 |
> +                 hbb_hi << 10 |
> +                 uavflagprd_inv << 4 |
> +                 min_acc_len_64b << 3 |
> +                 hbb_lo << 1 | ubwc_mode);
> +
> +       gpu_write(gpu, REG_A6XX_TPL1_NC_MODE_CNTL,
> +                 level3_swizzling_dis << 7 |
> +                 level2_swizzling_dis << 6 |
> +                 hbb_hi << 4 |
> +                 min_acc_len_64b << 3 |
> +                 hbb_lo << 1 | ubwc_mode);
> +}
> +
> +static int a8xx_zap_shader_init(struct msm_gpu *gpu)
> +{
> +       static bool loaded;
> +       int ret;
> +
> +       if (loaded)
> +               return 0;
> +
> +       ret =3D adreno_zap_shader_load(gpu, GPU_PAS_ID);
> +
> +       loaded =3D !ret;
> +       return ret;
> +}
> +
> +static void a8xx_nonctxt_config(struct msm_gpu *gpu, u32 *gmem_protect)
> +{
> +       struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> +       const struct a6xx_info *info =3D adreno_gpu->info->a6xx;
> +       const struct adreno_reglist_pipe *regs =3D info->nonctxt_reglist;
> +       int pipe_id, i;
> +
> +       for (pipe_id =3D PIPE_NONE; pipe_id <=3D PIPE_DDE_BV; pipe_id++) =
{
> +               /* We don't have support for LPAC yet */
> +               if (pipe_id =3D=3D PIPE_LPAC)
> +                       continue;
> +
> +               for (i =3D 0; regs[i].offset; i++) {
> +                       if (!(BIT(pipe_id) & regs[i].pipe))
> +                               continue;
> +
> +                       if (regs[i].offset =3D=3D REG_A8XX_RB_GC_GMEM_PRO=
TECT)
> +                               *gmem_protect =3D regs[i].value;
> +
> +                       a8xx_write_pipe(gpu, pipe_id, regs[i].offset, reg=
s[i].value);
> +               }
> +       }
> +
> +       a8xx_aperture_set(gpu, 0);
> +}
> +
> +static int a8xx_cp_init(struct msm_gpu *gpu)
> +{
> +       struct msm_ringbuffer *ring =3D gpu->rb[0];
> +       u32 mask;
> +
> +       /* Disable concurrent binning before sending CP init */
> +       OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
> +       OUT_RING(ring, BIT(27));
> +
> +       OUT_PKT7(ring, CP_ME_INIT, 4);
> +
> +       /* Use multiple HW contexts */
> +       mask =3D BIT(0);
> +
> +       /* Enable error detection */
> +       mask |=3D BIT(1);
> +
> +       /* Set default reset state */
> +       mask |=3D BIT(3);
> +
> +       /* Disable save/restore of performance counters across preemption=
 */
> +       mask |=3D BIT(6);
> +
> +       OUT_RING(ring, mask);
> +
> +       /* Enable multiple hardware contexts */
> +       OUT_RING(ring, 0x00000003);
> +
> +       /* Enable error detection */
> +       OUT_RING(ring, 0x20000000);
> +
> +       /* Operation mode mask */
> +       OUT_RING(ring, 0x00000002);
> +
> +       a8xx_flush(gpu, ring);
> +       return a8xx_idle(gpu, ring) ? 0 : -EINVAL;
> +}
> +
> +#define A8XX_INT_MASK \
> +       (A6XX_RBBM_INT_0_MASK_CP_AHB_ERROR | \
> +        A6XX_RBBM_INT_0_MASK_RBBM_ATB_ASYNCFIFO_OVERFLOW | \
> +        A6XX_RBBM_INT_0_MASK_RBBM_GPC_ERROR | \
> +        A6XX_RBBM_INT_0_MASK_CP_SW | \
> +        A6XX_RBBM_INT_0_MASK_CP_HW_ERROR | \
> +        A6XX_RBBM_INT_0_MASK_PM4CPINTERRUPT | \
> +        A6XX_RBBM_INT_0_MASK_CP_RB_DONE_TS | \
> +        A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS | \
> +        A6XX_RBBM_INT_0_MASK_RBBM_ATB_BUS_OVERFLOW | \
> +        A6XX_RBBM_INT_0_MASK_RBBM_HANG_DETECT | \
> +        A6XX_RBBM_INT_0_MASK_UCHE_OOB_ACCESS | \
> +        A6XX_RBBM_INT_0_MASK_UCHE_TRAP_INTR | \
> +        A6XX_RBBM_INT_0_MASK_TSBWRITEERROR | \
> +        A6XX_RBBM_INT_0_MASK_SWFUSEVIOLATION)
> +
> +#define A8XX_APRIV_MASK \
> +       (A8XX_CP_APRIV_CNTL_PIPE_ICACHE | \
> +        A8XX_CP_APRIV_CNTL_PIPE_RBFETCH | \
> +        A8XX_CP_APRIV_CNTL_PIPE_RBPRIVLEVEL | \
> +        A8XX_CP_APRIV_CNTL_PIPE_RBRPWB)
> +
> +#define A8XX_BR_APRIV_MASK \
> +       (A8XX_APRIV_MASK | \
> +        A8XX_CP_APRIV_CNTL_PIPE_CDREAD | \
> +        A8XX_CP_APRIV_CNTL_PIPE_CDWRITE)
> +
> +#define A8XX_CP_GLOBAL_INT_MASK \
> +       (A8XX_CP_GLOBAL_INT_MASK_HWFAULTBR | \
> +        A8XX_CP_GLOBAL_INT_MASK_HWFAULTBV | \
> +        A8XX_CP_GLOBAL_INT_MASK_HWFAULTLPAC | \
> +        A8XX_CP_GLOBAL_INT_MASK_HWFAULTAQE0 | \
> +        A8XX_CP_GLOBAL_INT_MASK_HWFAULTAQE1 | \
> +        A8XX_CP_GLOBAL_INT_MASK_HWFAULTDDEBR | \
> +        A8XX_CP_GLOBAL_INT_MASK_HWFAULTDDEBV | \
> +        A8XX_CP_GLOBAL_INT_MASK_SWFAULTBR | \
> +        A8XX_CP_GLOBAL_INT_MASK_SWFAULTBV | \
> +        A8XX_CP_GLOBAL_INT_MASK_SWFAULTLPAC | \
> +        A8XX_CP_GLOBAL_INT_MASK_SWFAULTAQE0 | \
> +        A8XX_CP_GLOBAL_INT_MASK_SWFAULTAQE1 | \
> +        A8XX_CP_GLOBAL_INT_MASK_SWFAULTDDEBR | \
> +        A8XX_CP_GLOBAL_INT_MASK_SWFAULTDDEBV)
> +
> +#define A8XX_CP_INTERRUPT_STATUS_MASK_PIPE \
> +       (A8XX_CP_INTERRUPT_STATUS_MASK_PIPE_CSFRBWRAP | \
> +        A8XX_CP_INTERRUPT_STATUS_MASK_PIPE_CSFIB1WRAP | \
> +        A8XX_CP_INTERRUPT_STATUS_MASK_PIPE_CSFIB2WRAP | \
> +        A8XX_CP_INTERRUPT_STATUS_MASK_PIPE_CSFIB3WRAP | \
> +        A8XX_CP_INTERRUPT_STATUS_MASK_PIPE_CSFSDSWRAP | \
> +        A8XX_CP_INTERRUPT_STATUS_MASK_PIPE_CSFMRBWRAP | \
> +        A8XX_CP_INTERRUPT_STATUS_MASK_PIPE_CSFVSDWRAP | \
> +        A8XX_CP_INTERRUPT_STATUS_MASK_PIPE_OPCODEERROR | \
> +        A8XX_CP_INTERRUPT_STATUS_MASK_PIPE_VSDPARITYERROR | \
> +        A8XX_CP_INTERRUPT_STATUS_MASK_PIPE_REGISTERPROTECTIONERROR | \
> +        A8XX_CP_INTERRUPT_STATUS_MASK_PIPE_ILLEGALINSTRUCTION | \
> +        A8XX_CP_INTERRUPT_STATUS_MASK_PIPE_SMMUFAULT | \
> +        A8XX_CP_INTERRUPT_STATUS_MASK_PIPE_VBIFRESP | \
> +        A8XX_CP_INTERRUPT_STATUS_MASK_PIPE_RTWROVF | \
> +        A8XX_CP_INTERRUPT_STATUS_MASK_PIPE_LRZRTWROVF | \
> +        A8XX_CP_INTERRUPT_STATUS_MASK_PIPE_LRZRTREFCNTOVF | \
> +        A8XX_CP_INTERRUPT_STATUS_MASK_PIPE_LRZRTCLRRESMISS)
> +
> +#define A8XX_CP_HW_FAULT_STATUS_MASK_PIPE \
> +       (A8XX_CP_HW_FAULT_STATUS_MASK_PIPE_CSFRBFAULT | \
> +        A8XX_CP_HW_FAULT_STATUS_MASK_PIPE_CSFIB1FAULT | \
> +        A8XX_CP_HW_FAULT_STATUS_MASK_PIPE_CSFIB2FAULT | \
> +        A8XX_CP_HW_FAULT_STATUS_MASK_PIPE_CSFIB3FAULT | \
> +        A8XX_CP_HW_FAULT_STATUS_MASK_PIPE_CSFSDSFAULT | \
> +        A8XX_CP_HW_FAULT_STATUS_MASK_PIPE_CSFMRBFAULT | \
> +        A8XX_CP_HW_FAULT_STATUS_MASK_PIPE_CSFVSDFAULT | \
> +        A8XX_CP_HW_FAULT_STATUS_MASK_PIPE_SQEREADBURSTOVF | \
> +        A8XX_CP_HW_FAULT_STATUS_MASK_PIPE_EVENTENGINEOVF | \
> +        A8XX_CP_HW_FAULT_STATUS_MASK_PIPE_UCODEERROR)
> +
> +static int hw_init(struct msm_gpu *gpu)
> +{
> +       struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> +       struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> +       struct a6xx_gmu *gmu =3D &a6xx_gpu->gmu;
> +       unsigned int pipe_id, i;
> +       u32 gmem_protect =3D 0;
> +       u64 gmem_range_min;
> +       int ret;
> +
> +       /* Read the slice info on A8x GPUs */
> +       a8xx_gpu_get_slice_info(gpu);
> +
> +       ret =3D a6xx_gmu_set_oob(&a6xx_gpu->gmu, GMU_OOB_GPU_SET);
> +       if (ret)
> +               return ret;
> +
> +       /* Clear the cached value to force aperture configuration next ti=
me */
> +       a6xx_gpu->cached_aperture =3D UINT_MAX;
> +       a8xx_aperture_set(gpu, 0);
> +
> +       /* Clear GBIF halt in case GX domain was not collapsed */
> +       gpu_write(gpu, REG_A6XX_GBIF_HALT, 0);
> +       gpu_read(gpu, REG_A6XX_GBIF_HALT);
> +
> +       gpu_write(gpu, REG_A8XX_RBBM_GBIF_HALT, 0);
> +       gpu_read(gpu, REG_A8XX_RBBM_GBIF_HALT);
> +
> +       gpu_write(gpu, REG_A6XX_RBBM_SECVID_TSB_CNTL, 0);
> +
> +       /*
> +        * Disable the trusted memory range - we don't actually supported=
 secure
> +        * memory rendering at this point in time and we don't want to bl=
ock off
> +        * part of the virtual memory space.
> +        */
> +       gpu_write64(gpu, REG_A6XX_RBBM_SECVID_TSB_TRUSTED_BASE, 0x0000000=
0);
> +       gpu_write(gpu, REG_A6XX_RBBM_SECVID_TSB_TRUSTED_SIZE, 0x00000000)=
;
> +
> +       gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE0, 0x00071620);
> +       gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE1, 0x00071620);
> +       gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE2, 0x00071620);
> +       gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE3, 0x00071620);
> +       gpu_write(gpu, REG_A8XX_GBIF_CX_CONFIG, 0x20023000);
> +       gmu_write(gmu, REG_A6XX_GMU_MRC_GBIF_QOS_CTRL, 0x33);
> +
> +       /* Make all blocks contribute to the GPU BUSY perf counter */
> +       gpu_write(gpu, REG_A8XX_RBBM_PERFCTR_GPU_BUSY_MASKED, 0xffffffff)=
;
> +
> +       /* Setup GMEM Range in UCHE */
> +       gmem_range_min =3D SZ_64M;
> +       /* Set the GMEM VA range [0x100000:0x100000 + gpu->gmem - 1] */
> +       gpu_write64(gpu, REG_A8XX_UCHE_CCHE_GC_GMEM_RANGE_MIN, gmem_range=
_min);
> +       gpu_write64(gpu, REG_A8XX_SP_HLSQ_GC_GMEM_RANGE_MIN, gmem_range_m=
in);
> +
> +       /* Setup UCHE Trap region */
> +       gpu_write64(gpu, REG_A8XX_UCHE_TRAP_BASE, adreno_gpu->uche_trap_b=
ase);
> +       gpu_write64(gpu, REG_A8XX_UCHE_WRITE_THRU_BASE, adreno_gpu->uche_=
trap_base);
> +       gpu_write64(gpu, REG_A8XX_UCHE_CCHE_TRAP_BASE, adreno_gpu->uche_t=
rap_base);
> +       gpu_write64(gpu, REG_A8XX_UCHE_CCHE_WRITE_THRU_BASE, adreno_gpu->=
uche_trap_base);
> +
> +       /* Turn on performance counters */
> +       gpu_write(gpu, REG_A8XX_RBBM_PERFCTR_CNTL, 0x1);
> +       gpu_write(gpu, REG_A8XX_RBBM_SLICE_PERFCTR_CNTL, 0x1);
> +
> +       /* Turn on the IFPC counter (countable 4 on XOCLK1) */
> +       gmu_write(&a6xx_gpu->gmu, REG_A8XX_GMU_CX_GMU_POWER_COUNTER_SELEC=
T_XOCLK_1,
> +                 FIELD_PREP(GENMASK(7, 0), 0x4));
> +
> +       /* Select CP0 to always count cycles */
> +       gpu_write(gpu, REG_A8XX_CP_PERFCTR_CP_SEL(0), PERF_CP_ALWAYS_COUN=
T);
> +
> +       a8xx_set_ubwc_config(gpu);
> +
> +       /* Set weights for bicubic filtering */
> +       gpu_write(gpu, REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(0), 0);
> +       gpu_write(gpu, REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(1), 0x3fe05ff4=
);
> +       gpu_write(gpu, REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(2), 0x3fa0ebee=
);
> +       gpu_write(gpu, REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(3), 0x3f5193ed=
);
> +       gpu_write(gpu, REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(4), 0x3f0243f0=
);
> +       gpu_write(gpu, REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(5), 0x00000000=
);
> +       gpu_write(gpu, REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(6), 0x3fd093e8=
);
> +       gpu_write(gpu, REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(7), 0x3f4133dc=
);
> +       gpu_write(gpu, REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(8), 0x3ea1dfdb=
);
> +       gpu_write(gpu, REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(9), 0x3e0283e0=
);
> +       gpu_write(gpu, REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(10), 0x0000ac2=
b);
> +       gpu_write(gpu, REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(11), 0x0000f01=
d);
> +       gpu_write(gpu, REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(12), 0x0011441=
2);
> +       gpu_write(gpu, REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(13), 0x0021980=
a);
> +       gpu_write(gpu, REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(14), 0x0051ec0=
5);
> +       gpu_write(gpu, REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(15), 0x0000380=
e);
> +       gpu_write(gpu, REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(16), 0x3ff0900=
1);
> +       gpu_write(gpu, REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(17), 0x3fc10bf=
a);
> +       gpu_write(gpu, REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(18), 0x3f9193f=
7);
> +       gpu_write(gpu, REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(19), 0x3f7227f=
7);
> +
> +       /* Enable fault detection */
> +       gpu_write(gpu, REG_A8XX_RBBM_INTERFACE_HANG_INT_CNTL, BIT(30) | 0=
xcfffff);
> +       gpu_write(gpu, REG_A8XX_RBBM_SLICE_INTERFACE_HANG_INT_CNTL, BIT(3=
0));
> +
> +       gpu_write(gpu, REG_A8XX_UCHE_CLIENT_PF, BIT(7) | 0x1);
> +
> +       a8xx_nonctxt_config(gpu, &gmem_protect);
> +
> +       /* Enable the GMEM save/restore feature for preemption */
> +       a8xx_write_pipe(gpu, PIPE_BR, REG_A6XX_RB_CONTEXT_SWITCH_GMEM_SAV=
E_RESTORE_ENABLE, 1);
> +       a8xx_aperture_set(gpu, 0);
> +
> +       /* Set up the CX GMU counter 0 to count busy ticks */
> +       gmu_write(gmu, REG_A6XX_GPU_GMU_AO_GPU_CX_BUSY_MASK, 0xff000000);
> +
> +       /* Enable the power counter */
> +       gmu_rmw(gmu, REG_A8XX_GMU_CX_GMU_POWER_COUNTER_SELECT_XOCLK_0, 0x=
ff, BIT(5));
> +       gmu_write(gmu, REG_A6XX_GMU_CX_GMU_POWER_COUNTER_ENABLE, 1);
> +
> +       /* Protect registers from the CP */
> +       a8xx_set_cp_protect(gpu);
> +
> +       for (pipe_id =3D PIPE_BR; pipe_id <=3D PIPE_DDE_BV; pipe_id++) {
> +               u32 apriv_mask =3D A8XX_APRIV_MASK;
> +
> +               if (pipe_id =3D=3D PIPE_LPAC)
> +                       continue;
> +
> +               if (pipe_id =3D=3D PIPE_BR)
> +                       apriv_mask =3D A8XX_BR_APRIV_MASK;
> +
> +               a8xx_write_pipe(gpu, pipe_id, REG_A8XX_CP_APRIV_CNTL_PIPE=
, apriv_mask);
> +               a8xx_write_pipe(gpu, pipe_id, REG_A8XX_CP_INTERRUPT_STATU=
S_MASK_PIPE,
> +                               A8XX_CP_INTERRUPT_STATUS_MASK_PIPE);
> +               a8xx_write_pipe(gpu, pipe_id, REG_A8XX_CP_HW_FAULT_STATUS=
_MASK_PIPE,
> +                               A8XX_CP_HW_FAULT_STATUS_MASK_PIPE);
> +       }
> +
> +       /* Clear aperture */
> +       a8xx_aperture_set(gpu, 0);
> +
> +       /* Enable interrupts */
> +       gpu_write(gpu, REG_A8XX_CP_INTERRUPT_STATUS_MASK_GLOBAL, A8XX_CP_=
GLOBAL_INT_MASK);
> +       gpu_write(gpu, REG_A8XX_RBBM_INT_0_MASK, A8XX_INT_MASK);
> +
> +       ret =3D adreno_hw_init(gpu);
> +       if (ret)
> +               goto out;
> +
> +       gpu_write64(gpu, REG_A8XX_CP_SQE_INSTR_BASE, a6xx_gpu->sqe_iova);
> +       /* Set the ringbuffer address */
> +       gpu_write64(gpu, REG_A6XX_CP_RB_BASE, gpu->rb[0]->iova);
> +       gpu_write(gpu, REG_A6XX_CP_RB_CNTL, MSM_GPU_RB_CNTL_DEFAULT);
> +
> +       /* Configure the RPTR shadow if needed: */
> +       gpu_write64(gpu, REG_A6XX_CP_RB_RPTR_ADDR, shadowptr(a6xx_gpu, gp=
u->rb[0]));
> +       gpu_write64(gpu, REG_A8XX_CP_RB_RPTR_ADDR_BV, rbmemptr(gpu->rb[0]=
, bv_rptr));
> +
> +       for (i =3D 0; i < gpu->nr_rings; i++)
> +               a6xx_gpu->shadow[i] =3D 0;
> +
> +       /* Always come up on rb 0 */
> +       a6xx_gpu->cur_ring =3D gpu->rb[0];
> +
> +       for (i =3D 0; i < gpu->nr_rings; i++)
> +               gpu->rb[i]->cur_ctx_seqno =3D 0;
> +
> +       /* Enable the SQE_to start the CP engine */
> +       gpu_write(gpu, REG_A8XX_CP_SQE_CNTL, 1);
> +
> +       ret =3D a8xx_cp_init(gpu);
> +       if (ret)
> +               goto out;
> +
> +       /*
> +        * Try to load a zap shader into the secure world. If successful
> +        * we can use the CP to switch out of secure mode. If not then we
> +        * have no resource but to try to switch ourselves out manually. =
If we
> +        * guessed wrong then access to the RBBM_SECVID_TRUST_CNTL regist=
er will
> +        * be blocked and a permissions violation will soon follow.
> +        */
> +       ret =3D a8xx_zap_shader_init(gpu);
> +       if (!ret) {
> +               OUT_PKT7(gpu->rb[0], CP_SET_SECURE_MODE, 1);
> +               OUT_RING(gpu->rb[0], 0x00000000);
> +
> +               a8xx_flush(gpu, gpu->rb[0]);
> +               if (!a8xx_idle(gpu, gpu->rb[0]))
> +                       return -EINVAL;
> +       } else if (ret =3D=3D -ENODEV) {
> +               /*
> +                * This device does not use zap shader (but print a warni=
ng
> +                * just in case someone got their dt wrong.. hopefully th=
ey
> +                * have a debug UART to realize the error of their ways..=
.
> +                * if you mess this up you are about to crash horribly)
> +                */
> +               dev_warn_once(gpu->dev->dev,
> +                       "Zap shader not enabled - using SECVID_TRUST_CNTL=
 instead\n");
> +               gpu_write(gpu, REG_A6XX_RBBM_SECVID_TRUST_CNTL, 0x0);
> +               ret =3D 0;
> +       } else {
> +               return ret;
> +       }
> +
> +       /*
> +        * GMEM_PROTECT register should be programmed after GPU is transi=
tioned to
> +        * non-secure mode
> +        */
> +       a8xx_write_pipe(gpu, PIPE_BR, REG_A8XX_RB_GC_GMEM_PROTECT, gmem_p=
rotect);
> +       WARN_ON(!gmem_protect);
> +
> +       /* Clear aperture */
> +       a8xx_aperture_set(gpu, 0);
> +
> +       /* Enable hardware clockgating */
> +       a8xx_set_hwcg(gpu, true);
> +out:
> +       /*
> +        * Tell the GMU that we are done touching the GPU and it can star=
t power
> +        * management
> +        */
> +       a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_GPU_SET);
> +
> +       return ret;
> +}
> +
> +int a8xx_hw_init(struct msm_gpu *gpu)
> +{
> +       struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> +       struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> +       int ret;
> +
> +       mutex_lock(&a6xx_gpu->gmu.lock);
> +       ret =3D hw_init(gpu);
> +       mutex_unlock(&a6xx_gpu->gmu.lock);
> +
> +       return ret;
> +}
> +
> +static void a8xx_dump(struct msm_gpu *gpu)
> +{
> +       DRM_DEV_INFO(&gpu->pdev->dev, "status:   %08x\n",
> +                       gpu_read(gpu, REG_A8XX_RBBM_STATUS));
> +       adreno_dump(gpu);
> +}
> +
> +void a8xx_recover(struct msm_gpu *gpu)
> +{
> +       struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> +       struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> +       struct a6xx_gmu *gmu =3D &a6xx_gpu->gmu;
> +       int i, active_submits;
> +
> +       adreno_dump_info(gpu);
> +
> +       for (i =3D 0; i < 4; i++)
> +               DRM_DEV_INFO(&gpu->pdev->dev, "CP_SCRATCH_REG%d: %u\n", i=
,
> +                       gpu_read(gpu, REG_A8XX_CP_SCRATCH_GLOBAL(i)));
> +
> +       if (hang_debug)
> +               a8xx_dump(gpu);
> +
> +       /*
> +        * To handle recovery specific sequences during the rpm suspend w=
e are
> +        * about to trigger
> +        */
> +       a6xx_gpu->hung =3D true;
> +
> +       /* Halt SQE first */
> +       gpu_write(gpu, REG_A8XX_CP_SQE_CNTL, 3);
> +
> +       pm_runtime_dont_use_autosuspend(&gpu->pdev->dev);
> +
> +       /* active_submit won't change until we make a submission */
> +       mutex_lock(&gpu->active_lock);
> +       active_submits =3D gpu->active_submits;
> +
> +       /*
> +        * Temporarily clear active_submits count to silence a WARN() in =
the
> +        * runtime suspend cb
> +        */
> +       gpu->active_submits =3D 0;
> +
> +       reinit_completion(&gmu->pd_gate);
> +       dev_pm_genpd_add_notifier(gmu->cxpd, &gmu->pd_nb);
> +       dev_pm_genpd_synced_poweroff(gmu->cxpd);
> +
> +       /* Drop the rpm refcount from active submits */
> +       if (active_submits)
> +               pm_runtime_put(&gpu->pdev->dev);
> +
> +       /* And the final one from recover worker */
> +       pm_runtime_put_sync(&gpu->pdev->dev);
> +
> +       if (!wait_for_completion_timeout(&gmu->pd_gate, msecs_to_jiffies(=
1000)))
> +               DRM_DEV_ERROR(&gpu->pdev->dev, "cx gdsc didn't collapse\n=
");
> +
> +       dev_pm_genpd_remove_notifier(gmu->cxpd);
> +
> +       pm_runtime_use_autosuspend(&gpu->pdev->dev);
> +
> +       if (active_submits)
> +               pm_runtime_get(&gpu->pdev->dev);
> +
> +       pm_runtime_get_sync(&gpu->pdev->dev);
> +
> +       gpu->active_submits =3D active_submits;
> +       mutex_unlock(&gpu->active_lock);
> +
> +       msm_gpu_hw_init(gpu);
> +       a6xx_gpu->hung =3D false;
> +}
> +
> +static const char *a8xx_uche_fault_block(struct msm_gpu *gpu, u32 mid)
> +{
> +       static const char * const uche_clients[] =3D {
> +               "BR_VFD", "BR_SP", "BR_VSC", "BR_VPC", "BR_HLSQ", "BR_PC"=
, "BR_LRZ", "BR_TP",
> +               "BV_VFD", "BV_SP", "BV_VSC", "BV_VPC", "BV_HLSQ", "BV_PC"=
, "BV_LRZ", "BV_TP",
> +               "STCHE",
> +       };
> +       static const char * const uche_clients_lpac[] =3D {
> +               "-", "SP_LPAC", "-", "-", "HLSQ_LPAC", "-", "-", "TP_LPAC=
",
> +       };
> +       u32 val;
> +
> +       /*
> +        * The source of the data depends on the mid ID read from FSYNR1.
> +        * and the client ID read from the UCHE block
> +        */
> +       val =3D gpu_read(gpu, REG_A8XX_UCHE_CLIENT_PF);
> +
> +       val &=3D GENMASK(6, 0);
> +
> +       /* mid=3D3 refers to BR or BV */
> +       if (mid =3D=3D 3) {
> +               if (val < ARRAY_SIZE(uche_clients))
> +                       return uche_clients[val];
> +               else
> +                       return "UCHE";
> +       }
> +
> +       /* mid=3D8 refers to LPAC */
> +       if (mid =3D=3D 8) {
> +               if (val < ARRAY_SIZE(uche_clients_lpac))
> +                       return uche_clients_lpac[val];
> +               else
> +                       return "UCHE_LPAC";
> +       }
> +
> +       return "Unknown";
> +}
> +
> +static const char *a8xx_fault_block(struct msm_gpu *gpu, u32 id)
> +{
> +       switch (id) {
> +       case 0x0:
> +               return "CP";
> +       case 0x1:
> +               return "UCHE: Unknown";
> +       case 0x2:
> +               return "UCHE_LPAC: Unknown";
> +       case 0x3:
> +       case 0x8:
> +               return a8xx_uche_fault_block(gpu, id);
> +       case 0x4:
> +               return "CCU";
> +       case 0x5:
> +               return "Flag cache";
> +       case 0x6:
> +               return "PREFETCH";
> +       case 0x7:
> +               return "GMU";
> +       case 0x9:
> +               return "UCHE_HPAC";
> +       }
> +
> +       return "Unknown";
> +}
> +
> +int a8xx_fault_handler(void *arg, unsigned long iova, int flags, void *d=
ata)
> +{
> +       struct msm_gpu *gpu =3D arg;
> +       struct adreno_smmu_fault_info *info =3D data;
> +       const char *block =3D "unknown";
> +
> +       u32 scratch[] =3D {
> +                       gpu_read(gpu, REG_A8XX_CP_SCRATCH_GLOBAL(0)),
> +                       gpu_read(gpu, REG_A8XX_CP_SCRATCH_GLOBAL(1)),
> +                       gpu_read(gpu, REG_A8XX_CP_SCRATCH_GLOBAL(2)),
> +                       gpu_read(gpu, REG_A8XX_CP_SCRATCH_GLOBAL(3)),
> +       };
> +
> +       if (info)
> +               block =3D a8xx_fault_block(gpu, info->fsynr1 & 0xff);
> +
> +       return adreno_fault_handler(gpu, iova, flags, info, block, scratc=
h);
> +}
> +
> +static void a8xx_cp_hw_err_irq(struct msm_gpu *gpu)
> +{
> +       struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> +       struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> +       u32 slice =3D a8xx_get_first_slice(a6xx_gpu);
> +       u32 status =3D gpu_read(gpu, REG_A8XX_CP_INTERRUPT_STATUS_GLOBAL)=
;
> +       u32 hw_fault_mask =3D GENMASK(6, 0);
> +       u32 sw_fault_mask =3D GENMASK(22, 16);
> +       enum adreno_pipe pipe;
> +       int i;
> +
> +       dev_err_ratelimited(&gpu->pdev->dev, "CP Fault Global INT status:=
 0x%x\n", status);
> +
> +       switch (status) {
> +       case A8XX_CP_GLOBAL_INT_MASK_HWFAULTBR:
> +       case A8XX_CP_GLOBAL_INT_MASK_SWFAULTBR:
> +               pipe =3D PIPE_BR;
> +               break;
> +       case A8XX_CP_GLOBAL_INT_MASK_HWFAULTBV:
> +       case A8XX_CP_GLOBAL_INT_MASK_SWFAULTBV:
> +               pipe =3D PIPE_BV;
> +               break;
> +       case A8XX_CP_GLOBAL_INT_MASK_HWFAULTLPAC:
> +       case A8XX_CP_GLOBAL_INT_MASK_SWFAULTLPAC:
> +               pipe =3D PIPE_LPAC;
> +               break;
> +       case A8XX_CP_GLOBAL_INT_MASK_HWFAULTAQE0:
> +       case A8XX_CP_GLOBAL_INT_MASK_SWFAULTAQE0:
> +               pipe =3D PIPE_AQE0;
> +               break;
> +       case A8XX_CP_GLOBAL_INT_MASK_HWFAULTAQE1:
> +       case A8XX_CP_GLOBAL_INT_MASK_SWFAULTAQE1:
> +               pipe =3D PIPE_AQE1;
> +               break;
> +       case A8XX_CP_GLOBAL_INT_MASK_HWFAULTDDEBR:
> +       case A8XX_CP_GLOBAL_INT_MASK_SWFAULTDDEBR:
> +               pipe =3D PIPE_DDE_BR;
> +               break;
> +       case A8XX_CP_GLOBAL_INT_MASK_HWFAULTDDEBV:
> +       case A8XX_CP_GLOBAL_INT_MASK_SWFAULTDDEBV:
> +               pipe =3D PIPE_DDE_BV;
> +               break;
> +       default:
> +               dev_err_ratelimited(&gpu->pdev->dev, "CP Fault Unknown pi=
pe\n");
> +               return;
> +       }
> +
> +       if (hw_fault_mask & status) {
> +               status =3D a8xx_read_pipe_slice(gpu, pipe, slice, REG_A8X=
X_CP_HW_FAULT_STATUS_PIPE);
> +               dev_err_ratelimited(&gpu->pdev->dev,
> +                               "CP HW FAULT pipe: %u status: 0x%x\n", pi=
pe, status);
> +               /* Clear aperture */
> +               a8xx_aperture_set(gpu, 0);
> +               return;
> +       }
> +
> +       if (sw_fault_mask & status) {
> +               status =3D a8xx_read_pipe_slice(gpu, pipe, slice, REG_A8X=
X_CP_INTERRUPT_STATUS_PIPE);
> +               dev_err_ratelimited(&gpu->pdev->dev,
> +                               "CP SW FAULT pipe: %u status: 0x%x\n", pi=
pe, status);
> +
> +               if (status & BIT(8)) {
> +                       a8xx_write_pipe(gpu, pipe, REG_A8XX_CP_SQE_STAT_A=
DDR_PIPE, 1);
> +                       status =3D a8xx_read_pipe_slice(gpu, pipe, slice,
> +                                       REG_A8XX_CP_SQE_STAT_DATA_PIPE);
> +                       dev_err_ratelimited(&gpu->pdev->dev,
> +                                       "CP Opcode error, opcode=3D0x%x\n=
", status);
> +               }
> +
> +               for (i =3D 0; i < 4; i++)
> +                       DRM_DEV_INFO(&gpu->pdev->dev, "CP_SCRATCH_REG%d: =
%u\n", i,
> +                               gpu_read(gpu, REG_A8XX_CP_SCRATCH_GLOBAL(=
i)));
> +
> +               for (pipe =3D PIPE_BR; pipe <=3D PIPE_DDE_BV; pipe++) {
> +                       for (i =3D 0; i < 5; i++)
> +                               DRM_DEV_INFO(&gpu->pdev->dev, "CP_SCRATCH=
_PIPE_REG%d: %u\n", i,
> +                                       a8xx_read_pipe(gpu, pipe, REG_A8X=
X_CP_SCRATCH_PIPE(i)));
> +               }
> +
> +               /* Clear aperture */
> +               a8xx_aperture_set(gpu, 0);
> +               return;
> +       }
> +}
> +
> +static u32 gpu_periph_read(struct msm_gpu *gpu, enum adreno_pipe pipe, u=
32 dbg_offset)
> +{
> +       a8xx_write_pipe(gpu, pipe, REG_A8XX_CP_SQE_UCODE_DBG_ADDR_PIPE, d=
bg_offset);
> +
> +       return a8xx_read_pipe(gpu, pipe, REG_A8XX_CP_SQE_UCODE_DBG_DATA_P=
IPE);
> +}
> +
> +static u64 gpu_periph_read64(struct msm_gpu *gpu, enum adreno_pipe pipe,=
 u32 dbg_offset)
> +{
> +       u64 lo, hi;
> +
> +       lo =3D gpu_periph_read(gpu, pipe, dbg_offset);
> +       hi =3D gpu_periph_read(gpu, pipe, dbg_offset + 1);
> +
> +       return (hi << 32) | lo;
> +}
> +
> +#define CP_PERIPH_IB1_BASE_LO   0x7005
> +#define CP_PERIPH_IB1_BASE_HI   0x7006
> +#define CP_PERIPH_IB1_SIZE      0x7007
> +#define CP_PERIPH_IB1_OFFSET    0x7008
> +#define CP_PERIPH_IB2_BASE_LO   0x7009
> +#define CP_PERIPH_IB2_BASE_HI   0x700a
> +#define CP_PERIPH_IB2_SIZE      0x700b
> +#define CP_PERIPH_IB2_OFFSET    0x700c
> +#define CP_PERIPH_IB3_BASE_LO   0x700d
> +#define CP_PERIPH_IB3_BASE_HI   0x700e
> +#define CP_PERIPH_IB3_SIZE      0x700f
> +#define CP_PERIPH_IB3_OFFSET    0x7010
> +
> +static void a8xx_fault_detect_irq(struct msm_gpu *gpu)
> +{
> +       struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> +       struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> +       struct msm_ringbuffer *ring =3D gpu->funcs->active_ring(gpu);
> +
> +       /*
> +        * If stalled on SMMU fault, we could trip the GPU's hang detecti=
on,
> +        * but the fault handler will trigger the devcore dump, and we wa=
nt
> +        * to otherwise resume normally rather than killing the submit, s=
o
> +        * just bail.
> +        */
> +       if (gpu_read(gpu, REG_A8XX_RBBM_MISC_STATUS) & A8XX_RBBM_MISC_STA=
TUS_SMMU_STALLED_ON_FAULT)
> +               return;
> +
> +       /*
> +        * Force the GPU to stay on until after we finish
> +        * collecting information
> +        */
> +       if (!adreno_has_gmu_wrapper(adreno_gpu))
> +               gmu_write(&a6xx_gpu->gmu, REG_A6XX_GMU_GMU_PWR_COL_KEEPAL=
IVE, 1);
> +
> +       a8xx_aperture_set(gpu, PIPE_BR);
> +
> +       DRM_DEV_ERROR(&gpu->pdev->dev,
> +               "gpu fault ring %d fence %x status %8.8X gfx_status %8.8X=
\n",
> +               ring ? ring->id : -1, ring ? ring->fctx->last_fence : 0,
> +               gpu_read(gpu, REG_A8XX_RBBM_STATUS), gpu_read(gpu, REG_A8=
XX_RBBM_GFX_STATUS));
> +
> +       DRM_DEV_ERROR(&gpu->pdev->dev,
> +               "BR: status %8.8X rb %4.4x/%4.4x ib1 %16.16llX/%4.4x ib2 =
%16.16llX/%4.4x ib3 %16.16llX/%4.4x\n",
> +               gpu_read(gpu, REG_A8XX_RBBM_GFX_BR_STATUS),
> +               gpu_read(gpu, REG_A6XX_CP_RB_RPTR),
> +               gpu_read(gpu, REG_A6XX_CP_RB_WPTR),
> +               gpu_periph_read64(gpu, PIPE_BR, CP_PERIPH_IB1_BASE_LO),
> +               gpu_periph_read(gpu, PIPE_BR, CP_PERIPH_IB1_OFFSET),
> +               gpu_periph_read64(gpu, PIPE_BR, CP_PERIPH_IB2_BASE_LO),
> +               gpu_periph_read(gpu, PIPE_BR, CP_PERIPH_IB2_OFFSET),
> +               gpu_periph_read64(gpu, PIPE_BR, CP_PERIPH_IB3_BASE_LO),
> +               gpu_periph_read(gpu, PIPE_BR, CP_PERIPH_IB3_OFFSET));
> +
> +       DRM_DEV_ERROR(&gpu->pdev->dev,
> +               "BV: status %8.8X rb %4.4x/%4.4x ib1 %16.16llX/%4.4x ib2 =
%16.16llX/%4.4x ib3 %16.16llX/%4.4x\n",
> +               gpu_read(gpu, REG_A8XX_RBBM_GFX_BV_STATUS),
> +               gpu_read(gpu, REG_A8XX_CP_RB_RPTR_BV),
> +               gpu_read(gpu, REG_A6XX_CP_RB_WPTR),
> +               gpu_periph_read64(gpu, PIPE_BV, CP_PERIPH_IB1_BASE_LO),
> +               gpu_periph_read(gpu, PIPE_BV, CP_PERIPH_IB1_OFFSET),
> +               gpu_periph_read64(gpu, PIPE_BV, CP_PERIPH_IB2_BASE_LO),
> +               gpu_periph_read(gpu, PIPE_BV, CP_PERIPH_IB2_OFFSET),
> +               gpu_periph_read64(gpu, PIPE_BV, CP_PERIPH_IB3_BASE_LO),
> +               gpu_periph_read(gpu, PIPE_BV, CP_PERIPH_IB3_OFFSET));
> +
> +       a8xx_aperture_set(gpu, 0);
> +
> +       /* Turn off the hangcheck timer to keep it from bothering us */
> +       timer_delete(&gpu->hangcheck_timer);
> +
> +       kthread_queue_work(gpu->worker, &gpu->recover_work);
> +}
> +
> +static void a8xx_sw_fuse_violation_irq(struct msm_gpu *gpu)
> +{
> +       u32 status;
> +
> +       status =3D gpu_read(gpu, REG_A8XX_RBBM_SW_FUSE_INT_STATUS);
> +       gpu_write(gpu, REG_A8XX_RBBM_SW_FUSE_INT_MASK, 0);
> +
> +       dev_err_ratelimited(&gpu->pdev->dev, "SW fuse violation status=3D=
%8.8x\n", status);
> +
> +       /*
> +        * Ignore FASTBLEND violations, because the HW will silently fall=
 back
> +        * to legacy blending.
> +        */
> +       if (status & (A7XX_CX_MISC_SW_FUSE_VALUE_RAYTRACING |
> +                     A7XX_CX_MISC_SW_FUSE_VALUE_LPAC)) {
> +               timer_delete(&gpu->hangcheck_timer);
> +
> +               kthread_queue_work(gpu->worker, &gpu->recover_work);
> +       }
> +}
> +
> +irqreturn_t a8xx_irq(struct msm_gpu *gpu)
> +{
> +       struct msm_drm_private *priv =3D gpu->dev->dev_private;
> +       u32 status =3D gpu_read(gpu, REG_A8XX_RBBM_INT_0_STATUS);
> +
> +       gpu_write(gpu, REG_A8XX_RBBM_INT_CLEAR_CMD, status);
> +
> +       if (priv->disable_err_irq)
> +               status &=3D A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS;
> +
> +       if (status & A6XX_RBBM_INT_0_MASK_RBBM_HANG_DETECT)
> +               a8xx_fault_detect_irq(gpu);
> +
> +       if (status & A6XX_RBBM_INT_0_MASK_CP_AHB_ERROR) {
> +               u32 rl0, rl1;
> +
> +               rl0 =3D gpu_read(gpu, REG_A8XX_CP_RL_ERROR_DETAILS_0);
> +               rl1 =3D gpu_read(gpu, REG_A8XX_CP_RL_ERROR_DETAILS_1);
> +               dev_err_ratelimited(&gpu->pdev->dev,
> +                               "CP | AHB bus error RL_ERROR_1: %x, RL_ER=
ROR_2: %x\n", rl0, rl1);
> +       }
> +
> +       if (status & A6XX_RBBM_INT_0_MASK_CP_HW_ERROR)
> +               a8xx_cp_hw_err_irq(gpu);
> +
> +       if (status & A6XX_RBBM_INT_0_MASK_RBBM_ATB_ASYNCFIFO_OVERFLOW)
> +               dev_err_ratelimited(&gpu->pdev->dev, "RBBM | ATB ASYNC ov=
erflow\n");
> +
> +       if (status & A6XX_RBBM_INT_0_MASK_RBBM_ATB_BUS_OVERFLOW)
> +               dev_err_ratelimited(&gpu->pdev->dev, "RBBM | ATB bus over=
flow\n");
> +
> +       if (status & A6XX_RBBM_INT_0_MASK_UCHE_OOB_ACCESS)
> +               dev_err_ratelimited(&gpu->pdev->dev, "UCHE | Out of bound=
s access\n");
> +
> +       if (status & A6XX_RBBM_INT_0_MASK_UCHE_TRAP_INTR)
> +               dev_err_ratelimited(&gpu->pdev->dev, "UCHE | Trap interru=
pt\n");
> +
> +       if (status & A6XX_RBBM_INT_0_MASK_SWFUSEVIOLATION)
> +               a8xx_sw_fuse_violation_irq(gpu);
> +
> +       if (status & A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS) {
> +               msm_gpu_retire(gpu);
> +               a6xx_preempt_trigger(gpu);
> +       }
> +
> +       if (status & A6XX_RBBM_INT_0_MASK_CP_SW)
> +               a6xx_preempt_irq(gpu);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +void a8xx_llc_activate(struct a6xx_gpu *a6xx_gpu)
> +{
> +       struct adreno_gpu *adreno_gpu =3D &a6xx_gpu->base;
> +       struct msm_gpu *gpu =3D &adreno_gpu->base;
> +
> +       if (!llcc_slice_activate(a6xx_gpu->llc_slice)) {
> +               u32 gpu_scid =3D llcc_get_slice_id(a6xx_gpu->llc_slice);
> +
> +               gpu_scid &=3D GENMASK(5, 0);
> +
> +               gpu_write(gpu, REG_A6XX_GBIF_SCACHE_CNTL1,
> +                         FIELD_PREP(GENMASK(29, 24), gpu_scid) |
> +                         FIELD_PREP(GENMASK(23, 18), gpu_scid) |
> +                         FIELD_PREP(GENMASK(17, 12), gpu_scid) |
> +                         FIELD_PREP(GENMASK(11, 6), gpu_scid)  |
> +                         FIELD_PREP(GENMASK(5, 0), gpu_scid));
> +
> +               gpu_write(gpu, REG_A6XX_GBIF_SCACHE_CNTL0,
> +                         FIELD_PREP(GENMASK(27, 22), gpu_scid) |
> +                         FIELD_PREP(GENMASK(21, 16), gpu_scid) |
> +                         FIELD_PREP(GENMASK(15, 10), gpu_scid) |
> +                         BIT(8));
> +       }
> +
> +       llcc_slice_activate(a6xx_gpu->htw_llc_slice);
> +}
> +
> +int a8xx_gpu_feature_probe(struct msm_gpu *gpu)
> +{
> +       struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> +       struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> +       u32 fuse_val;
> +       int ret;
> +
> +       /*
> +        * Assume that if qcom scm isn't available, that whatever
> +        * replacement allows writing the fuse register ourselves.
> +        * Users of alternative firmware need to make sure this
> +        * register is writeable or indicate that it's not somehow.
> +        * Print a warning because if you mess this up you're about to
> +        * crash horribly.
> +        */
> +       if (!qcom_scm_is_available()) {
> +               dev_warn_once(gpu->dev->dev,
> +                       "SCM is not available, poking fuse register\n");
> +               a6xx_llc_write(a6xx_gpu, REG_A7XX_CX_MISC_SW_FUSE_VALUE,
> +                       A7XX_CX_MISC_SW_FUSE_VALUE_RAYTRACING |
> +                       A7XX_CX_MISC_SW_FUSE_VALUE_FASTBLEND |
> +                       A7XX_CX_MISC_SW_FUSE_VALUE_LPAC);
> +               adreno_gpu->has_ray_tracing =3D true;
> +               return 0;
> +       }
> +
> +       ret =3D qcom_scm_gpu_init_regs(QCOM_SCM_GPU_ALWAYS_EN_REQ |
> +                                    QCOM_SCM_GPU_TSENSE_EN_REQ);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * On a750 raytracing may be disabled by the firmware, find out
> +        * whether that's the case. The scm call above sets the fuse
> +        * register.
> +        */
> +       fuse_val =3D a6xx_llc_read(a6xx_gpu,
> +                                REG_A7XX_CX_MISC_SW_FUSE_VALUE);
> +       adreno_gpu->has_ray_tracing =3D
> +               !!(fuse_val & A7XX_CX_MISC_SW_FUSE_VALUE_RAYTRACING);
> +
> +       return 0;
> +}
> +
> +
> +#define GBIF_CLIENT_HALT_MASK          BIT(0)
> +#define GBIF_ARB_HALT_MASK             BIT(1)
> +#define VBIF_XIN_HALT_CTRL0_MASK       GENMASK(3, 0)
> +#define VBIF_RESET_ACK_MASK            0xF0
> +#define GPR0_GBIF_HALT_REQUEST         0x1E0
> +
> +void a8xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_gpu, =
bool gx_off)
> +{
> +       struct msm_gpu *gpu =3D &adreno_gpu->base;
> +
> +       if (gx_off) {
> +               /* Halt the gx side of GBIF */
> +               gpu_write(gpu, REG_A8XX_RBBM_GBIF_HALT, 1);
> +               spin_until(gpu_read(gpu, REG_A8XX_RBBM_GBIF_HALT_ACK) & 1=
);
> +       }
> +
> +       /* Halt new client requests on GBIF */
> +       gpu_write(gpu, REG_A6XX_GBIF_HALT, GBIF_CLIENT_HALT_MASK);
> +       spin_until((gpu_read(gpu, REG_A6XX_GBIF_HALT_ACK) &
> +                       (GBIF_CLIENT_HALT_MASK)) =3D=3D GBIF_CLIENT_HALT_=
MASK);
> +
> +       /* Halt all AXI requests on GBIF */
> +       gpu_write(gpu, REG_A6XX_GBIF_HALT, GBIF_ARB_HALT_MASK);
> +       spin_until((gpu_read(gpu,  REG_A6XX_GBIF_HALT_ACK) &
> +                       (GBIF_ARB_HALT_MASK)) =3D=3D GBIF_ARB_HALT_MASK);
> +
> +       /* The GBIF halt needs to be explicitly cleared */
> +       gpu_write(gpu, REG_A6XX_GBIF_HALT, 0x0);
> +}
> +
> +int a8xx_gmu_get_timestamp(struct msm_gpu *gpu, uint64_t *value)
> +{
> +       struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> +       struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> +
> +       mutex_lock(&a6xx_gpu->gmu.lock);
> +
> +       /* Force the GPU power on so we can read this register */
> +       a6xx_gmu_set_oob(&a6xx_gpu->gmu, GMU_OOB_PERFCOUNTER_SET);
> +
> +       *value =3D gpu_read64(gpu, REG_A8XX_CP_ALWAYS_ON_COUNTER);
> +
> +       a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_PERFCOUNTER_SET);
> +
> +       mutex_unlock(&a6xx_gpu->gmu.lock);
> +
> +       return 0;
> +}
> +
> +u64 a8xx_gpu_busy(struct msm_gpu *gpu, unsigned long *out_sample_rate)
> +{
> +       struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> +       struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> +       u64 busy_cycles;
> +
> +       /* 19.2MHz */
> +       *out_sample_rate =3D 19200000;
> +
> +       busy_cycles =3D gmu_read64(&a6xx_gpu->gmu,
> +                       REG_A8XX_GMU_CX_GMU_POWER_COUNTER_XOCLK_0_L,
> +                       REG_A8XX_GMU_CX_GMU_POWER_COUNTER_XOCLK_0_H);
> +
> +       return busy_cycles;
> +}
> +
> +bool a8xx_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
> +{
> +       return true;
> +}
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/ms=
m/adreno/adreno_gpu.h
> index 9831401c3bc865b803c2f9759d5e2ffcd79d19f8..6a2157f31122ba0c2f2a7005c=
98e3e4f1ada6acc 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> @@ -90,6 +90,13 @@ struct adreno_reglist {
>         u32 value;
>  };
>
> +/* Reglist with pipe information */
> +struct adreno_reglist_pipe {
> +       u32 offset;
> +       u32 value;
> +       u32 pipe;
> +};
> +
>  struct adreno_speedbin {
>         uint16_t fuse;
>         uint16_t speedbin;
> diff --git a/drivers/gpu/drm/msm/registers/adreno/a6xx.xml b/drivers/gpu/=
drm/msm/registers/adreno/a6xx.xml
> index ddde2e03b748f447b5e57571e2b04c68f8f2efc2..c3a202c8dce65d414c89bf76f=
1cb458b206b4eca 100644
> --- a/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
> +++ b/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
> @@ -4876,7 +4876,6 @@ by a particular renderpass/blit.
>  <domain name=3D"A6XX_CX_MISC" width=3D"32" prefix=3D"variant" varset=3D"=
chip">
>         <reg32 offset=3D"0x0001" name=3D"SYSTEM_CACHE_CNTL_0"/>
>         <reg32 offset=3D"0x0002" name=3D"SYSTEM_CACHE_CNTL_1"/>
> -       <reg32 offset=3D"0x0087" name=3D"SLICE_ENABLE_FINAL" variants=3D"=
A8XX-"/>
>         <reg32 offset=3D"0x0039" name=3D"CX_MISC_TCM_RET_CNTL" variants=
=3D"A7XX-"/>
>         <reg32 offset=3D"0x0087" name=3D"CX_MISC_SLICE_ENABLE_FINAL" vari=
ants=3D"A8XX"/>
>         <reg32 offset=3D"0x0400" name=3D"CX_MISC_SW_FUSE_VALUE" variants=
=3D"A7XX-">
> diff --git a/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml b/drivers/=
gpu/drm/msm/registers/adreno/a6xx_gmu.xml
> index 5dce7934056dd6472c368309b4894f0ed4a4d960..c4e00b1263cda65dce89c2f16=
860e5bf6f1c6244 100644
> --- a/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
> +++ b/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
> @@ -60,6 +60,7 @@ xsi:schemaLocation=3D"https://gitlab.freedesktop.org/fr=
eedreno/ rules-fd.xsd">
>         <reg32 offset=3D"0x1f400" name=3D"GMU_ICACHE_CONFIG"/>
>         <reg32 offset=3D"0x1f401" name=3D"GMU_DCACHE_CONFIG"/>
>         <reg32 offset=3D"0x1f40f" name=3D"GMU_SYS_BUS_CONFIG"/>
> +       <reg32 offset=3D"0x1f50b" name=3D"GMU_MRC_GBIF_QOS_CTRL"/>
>         <reg32 offset=3D"0x1f800" name=3D"GMU_CM3_SYSRESET"/>
>         <reg32 offset=3D"0x1f801" name=3D"GMU_CM3_BOOT_CONFIG"/>
>         <reg32 offset=3D"0x1f81a" name=3D"GMU_CM3_FW_BUSY"/>
>
> --
> 2.51.0
>

