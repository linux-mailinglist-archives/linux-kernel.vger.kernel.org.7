Return-Path: <linux-kernel+bounces-806324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C51BDB49518
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 114841BC57E0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D759330F7EF;
	Mon,  8 Sep 2025 16:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P+6bv3Md"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D90930F55E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 16:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348385; cv=none; b=h0cDtruHbSHlFAWYTsuAAMARwaFGE8R8v3KHBSj0gXWffllIlLOk0gw3NKu1pylCm5bqDVsgrzN0gGhEqldzV9DExHFgZtMZmPKd5APb9am8xT3RWosAHxVb+D783jcNFGeN75XFx1meKYGMaPtsCWzOUfaG12aLkxLfZs+np1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348385; c=relaxed/simple;
	bh=Ybah7AR1kGtEAO8WrL18Bl7ZzAxxHu1yBNmvGsLxKsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bp8jkYIpY5dCCwi7tIbuv7ADRgtbfdEf0mQ0E1LqwpxlBdzQagd94KXMEgk1f+lFk0kxNYIbDP46eH+cFEcDRIckVFn6/bFFgiKtmIihBtIhyv5qBzdfV60FcnzYRWnMY8+sUTfi47bfpHpvQ2hQlpbf5LeP+XQYWQibEIVPjnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P+6bv3Md; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5888xTXq025960
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 16:19:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=L0QJ30gg81Oxrd9I78h8iuZ14JR4Sp6YRKTgsTLCosI=; b=P+
	6bv3MdJzNARmUTI4Z1d07u8noEOB3iTx6JKs21+TDUYHfNJY0a3LrAg4cdeRDDM6
	3SvYYqACI+NLtyvCrZFRQQOmJ0itHKevelelMwyMbuXjfahcON621+Nf4loyuFVK
	+9HqY1TWNJ6JMK9VL1eOJgR5xlS68cfWysRWsxzwhB/gRw5OjzlRg232SPQ0Jx8T
	22pY4LlPot/YkcQwY4FwlYJ22J+uTP+EwSM6C1e6uxz0VGvDuSSgeJcr07G4Fh1z
	ePsEUfHvTgZhH9aLeljel6x6Uja5iue6TmZfNEyF0NXV0NMxNE34wlcVEdOSSfm5
	EPssOCDEN8cjR4bfLwgg==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e4kw35y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 16:19:43 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-30ccebc5babso1983653fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 09:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757348382; x=1757953182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L0QJ30gg81Oxrd9I78h8iuZ14JR4Sp6YRKTgsTLCosI=;
        b=g7MU8LnJqK0jYyoOHlL3U/PXg6VCFB6byR2xYXSIaJkRujkh6x2RCHyOz25/MDWVe4
         Q1fDTt2Iwd3uSP5+XYR+WqQa1rsiwnmD/3yvJ/srBH0Ourw9HH/HGBt2E7yADXvR5Ko/
         ylQALDqMB4bXpS9EVJ6vx+oSXtglu/OeUHiOwXJLBco4SjaV7AOc6cwM3eSAzRkRHddA
         HsWii/KQmiJIGqTueW1DIgEF/QjP3IGgrbg4xyO+Mad+qMgSbKdkHizR0JtJAFbFWTCO
         2tNfLEQivNlbsu8qZBxe10Z89/vQ8UTQhfpsDjrtoM26S/esgruRc32+7fNG/SFh9Moc
         DkFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF+4676qVxNer3oWvo+EbRy1A8/dIAik53hEmu/nECveCGvTKNz47oVnMIPw/HYIxgYsIu4WNseY/0vSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWZqDNp8CPzpO6yeY5BPFqDIHe7hK+SsbUWDvDh/D9LqrghMmH
	QgW9f34s13Xr1jY2g847n80V/IHE7Iw+ezNR1A0sCXvJ6naMQ2FixB2EQOFz5Uz7yniw1oUa0NA
	Prp2ARb3PIFTlkOHM8WPe17Ou2TDLzeIZk0PaTOaPoXsTxcNmS9P4SUYYsqdivHSNxfGtiq26rf
	E3rsyESZ5Hh4dGCQlDyGnp5nYJTHrB3PogKBGXyzK/8g==
X-Gm-Gg: ASbGncukv7Xte0cZwapIVUJ8sFpt47RkHi0y2neiSfU4pz1lJkGqycPsHx5QKD8HgaU
	KN9ub0xAdDFwKw1g/jC+j8q4m2pS8rQTycbVJraCaOWcElYZ8LRKoddXcpK6fvbR4DgtRRqgrMh
	v2H2TkVgRr69ziBfaK+dI2Q/j7qn2Zvt/t9jhU0/ngWkHzidcP2t6K
X-Received: by 2002:a05:6871:520c:b0:322:52d5:bbf6 with SMTP id 586e51a60fabf-3226460b716mr3990748fac.25.1757348382196;
        Mon, 08 Sep 2025 09:19:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjaoaeutro7I9dSBIuzBUghkd2VjlPQvUa7v0CxHYnos6nhxtZKLQUrnxGN93WkhNg2QgLj2eWDObKEiic80E=
X-Received: by 2002:a05:6871:520c:b0:322:52d5:bbf6 with SMTP id
 586e51a60fabf-3226460b716mr3990708fac.25.1757348381622; Mon, 08 Sep 2025
 09:19:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902-assorted-sept-1-v1-0-f3ec9baed513@oss.qualcomm.com>
 <20250902-assorted-sept-1-v1-1-f3ec9baed513@oss.qualcomm.com>
 <CACSVV026d+FWS09VOqRfFESJjk0g1Gp4TJhcdrBcWaZ3H4f3mQ@mail.gmail.com> <f8e66daa-8923-4926-86b8-c51f7f576180@oss.qualcomm.com>
In-Reply-To: <f8e66daa-8923-4926-86b8-c51f7f576180@oss.qualcomm.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 09:19:30 -0700
X-Gm-Features: Ac12FXxuZyq79yD5-k_K4YYyr5q7ZutJE2Sqc8bORaT7hd9fzlKHDPFSAxTcfo0
Message-ID: <CACSVV025zH-T82jp7xfgjKH=UoiJDDDq6xgyVjyrDhSH1=pQ4w@mail.gmail.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOCBTYWx0ZWRfX9ca0u8bmW8xS
 /yeL1mWUtyi2sPRFR18Xw5JJjSHnYq+hjRkbC9glLt7flJlaN5NZC7Q2yihpXzSaqjmk1iTgC+j
 azNPLp57kwYAO+lM7dnOV7XDC0TRO0CCvNfeiY5jYsMIXdnJC1BG3CaAqjizQDKHbR2uG2aA1Dx
 mLeEslNfjLV1iULOzJeSF7/mT134PxsuUZFOP/XBCBImDClOmQ/nnCR2tbzhIhJXUjENTbxOaJ8
 bvqAidbbGbHsHKOk4Vlg1uweTElvzuGsAQ434VKlf6+Q/3GGxJ4nnnmruZY0aAWZ6p1UL/Lk8m+
 lXVwMNlkBfIV6aWF3d6cHIZO4hQvEQLoE7tC0xg1kfwjcNkO8Bz3KH97UqBQU/EdvSiKbKgSfEh
 dHm3Fd9V
X-Authority-Analysis: v=2.4 cv=J66q7BnS c=1 sm=1 tr=0 ts=68bf021f cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=EUspDBNiAAAA:8 a=MaXCzO5kt653ReTLQ1AA:9 a=QEXdDO2ut3YA:10
 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-GUID: UruqlNw95bXX7i2LQXCFxTKT013APsLZ
X-Proofpoint-ORIG-GUID: UruqlNw95bXX7i2LQXCFxTKT013APsLZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060038

On Mon, Sep 8, 2025 at 8:42=E2=80=AFAM Akhil P Oommen <akhilpo@oss.qualcomm=
.com> wrote:
>
> On 9/2/2025 9:25 PM, Rob Clark wrote:
> > On Tue, Sep 2, 2025 at 4:50=E2=80=AFAM Akhil P Oommen <akhilpo@oss.qual=
comm.com> wrote:
> >>
> >> The drm_gem_for_each_gpuvm_bo() call from lookup_vma() accesses
> >> drm_gem_obj.gpuva.list, which is not initialized when the drm driver
> >> does not support DRIVER_GEM_GPUVA feature. Enable it for msm_kms
> >> drm driver to fix the splat seen when msm.separate_gpu_drm=3D1 modpara=
m
> >> is set:
> >>
> >> [    9.506020] Unable to handle kernel paging request at virtual addre=
ss fffffffffffffff0
> >> [    9.523160] Mem abort info:
> >> [    9.523161]   ESR =3D 0x0000000096000006
> >> [    9.523163]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> >> [    9.523165]   SET =3D 0, FnV =3D 0
> >> [    9.523166]   EA =3D 0, S1PTW =3D 0
> >> [    9.523167]   FSC =3D 0x06: level 2 translation fault
> >> [    9.523169] Data abort info:
> >> [    9.523170]   ISV =3D 0, ISS =3D 0x00000006, ISS2 =3D 0x00000000
> >> [    9.523171]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> >> [    9.523172]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> >> [    9.523174] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000ad=
370f000
> >> [    9.523176] [fffffffffffffff0] pgd=3D0000000000000000, p4d=3D000000=
0ad4787403, pud=3D0000000ad4788403, pmd=3D0000000000000000
> >> [    9.523184] Internal error: Oops: 0000000096000006 [#1]  SMP
> >> [    9.592968] CPU: 9 UID: 0 PID: 448 Comm: (udev-worker) Not tainted =
6.17.0-rc4-assorted-fix-00005-g0e9bb53a2282-dirty #3 PREEMPT
> >> [    9.592970] Hardware name: Qualcomm CRD, BIOS 6.0.240718.BOOT.MXF.2=
.4-00515-HAMOA-1 07/18/2024
> >> [    9.592971] pstate: a1400005 (NzCv daif +PAN -UAO -TCO +DIT -SSBS B=
TYPE=3D--)
> >> [    9.592973] pc : lookup_vma+0x28/0xe0 [msm]
> >> [    9.592996] lr : get_vma_locked+0x2c/0x128 [msm]
> >> [    9.763632] sp : ffff800082dab460
> >> [    9.763666] Call trace:
> >> [    9.763668]  lookup_vma+0x28/0xe0 [msm] (P)
> >> [    9.763688]  get_vma_locked+0x2c/0x128 [msm]
> >> [    9.763706]  msm_gem_get_and_pin_iova_range+0x68/0x11c [msm]
> >> [    9.763723]  msm_gem_get_and_pin_iova+0x18/0x24 [msm]
> >> [    9.763740]  msm_fbdev_driver_fbdev_probe+0xd0/0x258 [msm]
> >> [    9.763760]  __drm_fb_helper_initial_config_and_unlock+0x288/0x528 =
[drm_kms_helper]
> >> [    9.763771]  drm_fb_helper_initial_config+0x44/0x54 [drm_kms_helper=
]
> >> [    9.763779]  drm_fbdev_client_hotplug+0x84/0xd4 [drm_client_lib]
> >> [    9.763782]  drm_client_register+0x58/0x9c [drm]
> >> [    9.763806]  drm_fbdev_client_setup+0xe8/0xcf0 [drm_client_lib]
> >> [    9.763809]  drm_client_setup+0xb4/0xd8 [drm_client_lib]
> >> [    9.763811]  msm_drm_kms_post_init+0x2c/0x3c [msm]
> >> [    9.763830]  msm_drm_init+0x1a8/0x22c [msm]
> >> [    9.763848]  msm_drm_bind+0x30/0x3c [msm]
> >> [    9.919273]  try_to_bring_up_aggregate_device+0x168/0x1d4
> >> [    9.919283]  __component_add+0xa4/0x170
> >> [    9.919286]  component_add+0x14/0x20
> >> [    9.919288]  msm_dp_display_probe_tail+0x4c/0xac [msm]
> >> [    9.919315]  msm_dp_auxbus_done_probe+0x14/0x20 [msm]
> >> [    9.919335]  dp_aux_ep_probe+0x4c/0xf0 [drm_dp_aux_bus]
> >> [    9.919341]  really_probe+0xbc/0x298
> >> [    9.919345]  __driver_probe_device+0x78/0x12c
> >> [    9.919348]  driver_probe_device+0x40/0x160
> >> [    9.919350]  __driver_attach+0x94/0x19c
> >> [    9.919353]  bus_for_each_dev+0x74/0xd4
> >> [    9.919355]  driver_attach+0x24/0x30
> >> [    9.919358]  bus_add_driver+0xe4/0x208
> >> [    9.919360]  driver_register+0x60/0x128
> >> [    9.919363]  __dp_aux_dp_driver_register+0x24/0x30 [drm_dp_aux_bus]
> >> [    9.919365]  atana33xc20_init+0x20/0x1000 [panel_samsung_atna33xc20=
]
> >> [    9.919370]  do_one_initcall+0x6c/0x1b0
> >> [    9.919374]  do_init_module+0x58/0x234
> >> [    9.919377]  load_module+0x19cc/0x1bd4
> >> [    9.919380]  init_module_from_file+0x84/0xc4
> >> [    9.919382]  __arm64_sys_finit_module+0x1b8/0x2cc
> >> [    9.919384]  invoke_syscall+0x48/0x110
> >> [    9.919389]  el0_svc_common.constprop.0+0xc8/0xe8
> >> [    9.919393]  do_el0_svc+0x20/0x2c
> >> [    9.919396]  el0_svc+0x34/0xf0
> >> [    9.919401]  el0t_64_sync_handler+0xa0/0xe4
> >> [    9.919403]  el0t_64_sync+0x198/0x19c
> >> [    9.919407] Code: eb0000bf 54000480 d100a003 aa0303e2 (f8418c44)
> >> [    9.919410] ---[ end trace 0000000000000000 ]---
> >>
> >> Fixes: 217ed15bd399 ("drm/msm: enable separate binding of GPU and disp=
lay devices")
> >> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> >> ---
> >>  drivers/gpu/drm/msm/msm_drv.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_d=
rv.c
> >> index 9dcc7a596a11d9342a515dab694bac93dc2805cb..7e977fec4100792394dccf=
59097a01c2b2556608 100644
> >> --- a/drivers/gpu/drm/msm/msm_drv.c
> >> +++ b/drivers/gpu/drm/msm/msm_drv.c
> >> @@ -826,6 +826,7 @@ static const struct file_operations fops =3D {
> >>
> >>  #define DRIVER_FEATURES_KMS ( \
> >>                 DRIVER_GEM | \
> >> +               DRIVER_GEM_GPUVA | \
> >
> > Hmm, the description of DRIVER_GEM_GPUVA is that "Driver supports user
> > defined GPU VA bindings for GEM objects", which isn't really true.
> > Fortunately the only thing that it actually seems to control currently
> > is the list head initialization.
> >
> > Idk if it would be better to make the list head init unconditional, or
> > just add a comment here?
>
> But the KMS-only drm driver do use symbols related to gpuva. "struct
> gpuva" for eg:. From that perspective, shouldn't we select this feature
> here?

Based on how DRIVER_GEM_GPUVA is currently used (ie. not exposed to
userspace, etc) this is fine.  Maybe the comment describing
DRIVER_GEM_GPUVA should be updated to something along the lines of
"Driver uses the drm_gpuvm infrastructure" instead of "Driver supports
user defined GPU VA bindings for GEM object"

BR,
-R

> -Akhil
>
> >
> > BR,
> > -R
> >
> >>                 DRIVER_ATOMIC | \
> >>                 DRIVER_MODESET | \
> >>                 0 )
> >>
> >> --
> >> 2.50.1
> >>
>

