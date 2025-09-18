Return-Path: <linux-kernel+bounces-796949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5698FB409DD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA544845BC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCC2322C99;
	Tue,  2 Sep 2025 15:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iYbekwim"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C13324B2E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756828534; cv=none; b=hAIyITaPHx61MOt9NYf6OdvrOYVgQFHRYrlfqkk6IZ1Hjx1CUqYuXmrLckrIT5E+efLqxxcOLH43nMhqa75Dh8tg6fENigj7MgDXl0ahyYVxQ9bFyH2nmHTEt6uGYjcgIDl0cv0wGatGx0s/X4/l1WAi5TiGiav4Y+f1vtqmFfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756828534; c=relaxed/simple;
	bh=dK9sYjxBI31vHpMEu0I2MqTUx5Jz2eJzoqQiNViFJcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ta+SXUjzyU8DEoi8rEXQB37laXbR6I5wzf/Hskpy6v7CIi4QCzsF0hQaW7elb1qeNxeccrHmx2HQ3xW0dDmBARUJll0kIiBpkgm9b5pcEAFdwjC5JFbZkdRNnPjAMHLv1W4LEoB+xaudhVBgJg8yhl1al3a1x7dZotTHX3yYu/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iYbekwim; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582EqCnd019584
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 15:55:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=A3gqSpoIQ3gnaOLqW/dm0/FqkEZT7i2DBb0/fr+ypKE=; b=iY
	bekwim/S+o4b/4mz7R241d0gq1jTBYADedQsYVStLu2BprGGnjer6MEqIN95XOiO
	a50a38xOjdPv+Ac8vCO70lZqQExDRqPZc1tVyc4GCPqEknUSMOODx/oAHig5+VXT
	K0lZvxBC8i2UMmqSTJlqxtStDf248DPJq1iaazjbRL8T0OUiIDLPqQDZAQSGfqpu
	VUXR9olBc4/EKWf5uMtlk1pp1+3hgC6SEwb4RdIDSUYDKmA6cooCp+rlOXrpia93
	sEhlBrvh90zf1wgTE6Ge2MiKlfl/xeuo9nPuhWyt4qqLHATv8H3bOT94QthpFP2i
	sIU829PTMLxWEnngA4ZA==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urw00d89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 15:55:31 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4377b3dea1cso5639656b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 08:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756828531; x=1757433331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A3gqSpoIQ3gnaOLqW/dm0/FqkEZT7i2DBb0/fr+ypKE=;
        b=I88l/unf2R80n+1SO0BZfSAhJkBYdRcO8poyoEIyLl3owuSJ3frLr27IzrX7IcrUq5
         sHcuMAb6/R2wH12RXQD26Gb3SkstfmAmHKkxbTopzR85/l1NSeAw36Qv/EvwlbJ/06aQ
         2C4Iu01pnO4zP52Ti/M1A4ZqY642aT3AZp8iwqKsAHUBGhEGc52lpQDhzG2QobcG6BUC
         WzjNt5rLVjflCkTvuBnjNACp/wYO1kx4Qu9vv0p7VSdULR8zkfoy3ytGzVgekOhHNtgG
         K0srbSxKqpBFhHYYP8Xdcv+5RxgVdJNNOiXtrb3qqtA10GCaTttIomx8f9rrm/zQdAL6
         4mqg==
X-Forwarded-Encrypted: i=1; AJvYcCULwLLWHaHltvk6k5MTq4Zunxrb+pfMJP7y3c45Sy6rW4ei/cuwj0IiR59w0OidqL4ZUlMM8Oyj0LiDbv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeqUpWpG6juppgUjQXj9VNNbi99zhMM7X9TTQCnGMCe2uUgbpm
	VqkFZNgmN6xmHS9vleMYQMkA58H2enjfIMzsUKDRvYZRjeNeN01Dq+qOEnB3XewAQVCTT5GWx0+
	xaegwv/1xMN2CAExvoxZpugnD5kqlPE90o1ubb39XxioTgIDhRdGjZLWQtSkMnH985WvDAqg1hH
	7tXytl1P6u/jlyOse988QQqKWTwQH6VU+Qr6HDa02K1w==
X-Gm-Gg: ASbGncvagTgeLvgoCTRBdOiHVEDe1Nd9TKAReP9Z+cP96fIbADnJXrTQ7Moe3VENMR8
	OavlNvGNqaWH5xhYJyNDJb3Mu1ctr8yFoB6N7pVeGIoBZ8zg/eB+9wKiDl7qAezrzMZVMpWxK0B
	dP5vLJYGhZPe13Ia8EVC0OW4DZWbUvtoY98DgDsQKGtbIErWLSUt4Y
X-Received: by 2002:a05:6808:48d5:b0:437:dade:463f with SMTP id 5614622812f47-437f7d994c4mr4151952b6e.34.1756828530763;
        Tue, 02 Sep 2025 08:55:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1uf3jNioSmAshEc9z3yyLmgANd+2PnHEVtARN4d50VJILUSoxTI1ggnEVO/qE8F0+1dvdgSEHxjdhqo4mTMM=
X-Received: by 2002:a05:6808:48d5:b0:437:dade:463f with SMTP id
 5614622812f47-437f7d994c4mr4151933b6e.34.1756828530347; Tue, 02 Sep 2025
 08:55:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902-assorted-sept-1-v1-0-f3ec9baed513@oss.qualcomm.com> <20250902-assorted-sept-1-v1-1-f3ec9baed513@oss.qualcomm.com>
In-Reply-To: <20250902-assorted-sept-1-v1-1-f3ec9baed513@oss.qualcomm.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 2 Sep 2025 08:55:18 -0700
X-Gm-Features: Ac12FXxe1UwMG2c7pfYzqGvYc64XhcrboIhwaNGex0OludbeUsMDhRZIRxFJEYY
Message-ID: <CACSVV026d+FWS09VOqRfFESJjk0g1Gp4TJhcdrBcWaZ3H4f3mQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/msm: Fix bootup splat with separate_gpu_drm modparam
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: PmJ9FDAR5_vJHA7tCHu951xb0Tt9ntTF
X-Proofpoint-ORIG-GUID: PmJ9FDAR5_vJHA7tCHu951xb0Tt9ntTF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfX7OtkXmeFBFy3
 1wz4pWvwjhSepQVPGv3dTPSkvsoklWFl/859As4W/iA3Zb5n8ObgJ4YJrvRZeLw0nSKHCeNFN0U
 +yFFvsR4G80TMleS+wIkv6/T3e7sL9k6w5jJm+n9soPjpybWYeLYH0A9LxsqPq4adANp7tKHt/W
 hf5k0zYwdd2RYp1wBH+rEZEycVQD8c4u4vO2b3NQdlfsGxSd3/MVtJV1mjlJRJK53ofnGb4nJvl
 kt1iM+QaIEVtstLpbiAEGYE0MWFfCzXozsAaFx74j9TCfb5usAmWog8jg8ZFl4YIYbky6M85Wj2
 Kl6vZ8PcHczvLojpE/2jXNsvVbUazOyXHhzKrG0gXHr6CpYnW21HesXICy+YXXaKBmW7a3SVpNj
 8opWORaC
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b71373 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=EUspDBNiAAAA:8 a=Yc-ri1j8BvKz7xlZgGsA:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027

On Tue, Sep 2, 2025 at 4:50=E2=80=AFAM Akhil P Oommen <akhilpo@oss.qualcomm=
.com> wrote:
>
> The drm_gem_for_each_gpuvm_bo() call from lookup_vma() accesses
> drm_gem_obj.gpuva.list, which is not initialized when the drm driver
> does not support DRIVER_GEM_GPUVA feature. Enable it for msm_kms
> drm driver to fix the splat seen when msm.separate_gpu_drm=3D1 modparam
> is set:
>
> [    9.506020] Unable to handle kernel paging request at virtual address =
fffffffffffffff0
> [    9.523160] Mem abort info:
> [    9.523161]   ESR =3D 0x0000000096000006
> [    9.523163]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [    9.523165]   SET =3D 0, FnV =3D 0
> [    9.523166]   EA =3D 0, S1PTW =3D 0
> [    9.523167]   FSC =3D 0x06: level 2 translation fault
> [    9.523169] Data abort info:
> [    9.523170]   ISV =3D 0, ISS =3D 0x00000006, ISS2 =3D 0x00000000
> [    9.523171]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> [    9.523172]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> [    9.523174] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000ad370=
f000
> [    9.523176] [fffffffffffffff0] pgd=3D0000000000000000, p4d=3D0000000ad=
4787403, pud=3D0000000ad4788403, pmd=3D0000000000000000
> [    9.523184] Internal error: Oops: 0000000096000006 [#1]  SMP
> [    9.592968] CPU: 9 UID: 0 PID: 448 Comm: (udev-worker) Not tainted 6.1=
7.0-rc4-assorted-fix-00005-g0e9bb53a2282-dirty #3 PREEMPT
> [    9.592970] Hardware name: Qualcomm CRD, BIOS 6.0.240718.BOOT.MXF.2.4-=
00515-HAMOA-1 07/18/2024
> [    9.592971] pstate: a1400005 (NzCv daif +PAN -UAO -TCO +DIT -SSBS BTYP=
E=3D--)
> [    9.592973] pc : lookup_vma+0x28/0xe0 [msm]
> [    9.592996] lr : get_vma_locked+0x2c/0x128 [msm]
> [    9.763632] sp : ffff800082dab460
> [    9.763666] Call trace:
> [    9.763668]  lookup_vma+0x28/0xe0 [msm] (P)
> [    9.763688]  get_vma_locked+0x2c/0x128 [msm]
> [    9.763706]  msm_gem_get_and_pin_iova_range+0x68/0x11c [msm]
> [    9.763723]  msm_gem_get_and_pin_iova+0x18/0x24 [msm]
> [    9.763740]  msm_fbdev_driver_fbdev_probe+0xd0/0x258 [msm]
> [    9.763760]  __drm_fb_helper_initial_config_and_unlock+0x288/0x528 [dr=
m_kms_helper]
> [    9.763771]  drm_fb_helper_initial_config+0x44/0x54 [drm_kms_helper]
> [    9.763779]  drm_fbdev_client_hotplug+0x84/0xd4 [drm_client_lib]
> [    9.763782]  drm_client_register+0x58/0x9c [drm]
> [    9.763806]  drm_fbdev_client_setup+0xe8/0xcf0 [drm_client_lib]
> [    9.763809]  drm_client_setup+0xb4/0xd8 [drm_client_lib]
> [    9.763811]  msm_drm_kms_post_init+0x2c/0x3c [msm]
> [    9.763830]  msm_drm_init+0x1a8/0x22c [msm]
> [    9.763848]  msm_drm_bind+0x30/0x3c [msm]
> [    9.919273]  try_to_bring_up_aggregate_device+0x168/0x1d4
> [    9.919283]  __component_add+0xa4/0x170
> [    9.919286]  component_add+0x14/0x20
> [    9.919288]  msm_dp_display_probe_tail+0x4c/0xac [msm]
> [    9.919315]  msm_dp_auxbus_done_probe+0x14/0x20 [msm]
> [    9.919335]  dp_aux_ep_probe+0x4c/0xf0 [drm_dp_aux_bus]
> [    9.919341]  really_probe+0xbc/0x298
> [    9.919345]  __driver_probe_device+0x78/0x12c
> [    9.919348]  driver_probe_device+0x40/0x160
> [    9.919350]  __driver_attach+0x94/0x19c
> [    9.919353]  bus_for_each_dev+0x74/0xd4
> [    9.919355]  driver_attach+0x24/0x30
> [    9.919358]  bus_add_driver+0xe4/0x208
> [    9.919360]  driver_register+0x60/0x128
> [    9.919363]  __dp_aux_dp_driver_register+0x24/0x30 [drm_dp_aux_bus]
> [    9.919365]  atana33xc20_init+0x20/0x1000 [panel_samsung_atna33xc20]
> [    9.919370]  do_one_initcall+0x6c/0x1b0
> [    9.919374]  do_init_module+0x58/0x234
> [    9.919377]  load_module+0x19cc/0x1bd4
> [    9.919380]  init_module_from_file+0x84/0xc4
> [    9.919382]  __arm64_sys_finit_module+0x1b8/0x2cc
> [    9.919384]  invoke_syscall+0x48/0x110
> [    9.919389]  el0_svc_common.constprop.0+0xc8/0xe8
> [    9.919393]  do_el0_svc+0x20/0x2c
> [    9.919396]  el0_svc+0x34/0xf0
> [    9.919401]  el0t_64_sync_handler+0xa0/0xe4
> [    9.919403]  el0t_64_sync+0x198/0x19c
> [    9.919407] Code: eb0000bf 54000480 d100a003 aa0303e2 (f8418c44)
> [    9.919410] ---[ end trace 0000000000000000 ]---
>
> Fixes: 217ed15bd399 ("drm/msm: enable separate binding of GPU and display=
 devices")
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/msm_drv.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.=
c
> index 9dcc7a596a11d9342a515dab694bac93dc2805cb..7e977fec4100792394dccf590=
97a01c2b2556608 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -826,6 +826,7 @@ static const struct file_operations fops =3D {
>
>  #define DRIVER_FEATURES_KMS ( \
>                 DRIVER_GEM | \
> +               DRIVER_GEM_GPUVA | \

Hmm, the description of DRIVER_GEM_GPUVA is that "Driver supports user
defined GPU VA bindings for GEM objects", which isn't really true.
Fortunately the only thing that it actually seems to control currently
is the list head initialization.

Idk if it would be better to make the list head init unconditional, or
just add a comment here?

BR,
-R

>                 DRIVER_ATOMIC | \
>                 DRIVER_MODESET | \
>                 0 )
>
> --
> 2.50.1
>

