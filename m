Return-Path: <linux-kernel+bounces-796422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC92EB4006E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C0A0189046D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D16927FD78;
	Tue,  2 Sep 2025 12:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pbruc/lT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58182EF675
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756816029; cv=none; b=u6K31+GeXjkv+WOhntlVaVI8BWss+aNWmeCE9my03+lA4QvbgPusY1BNdjht/UcjcrNFpCHhv0DeKoo2i8wwBVQ8d4KrAOxGm+XsYJ2h085LOyNPGq8Q914O9JN2kGNDMqPdwQE3b6iVIxmhWM0cu5+DBYFxp6spTUUo1RZHcnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756816029; c=relaxed/simple;
	bh=mZ9PQB5CB5GkG1hetMSkc58XHb3VCjzkGfyhQC0jEbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5Z0YOGajyHso/TYlcbn4d2s6QkWVyrs37tjLJAQrf1P2aIWO5rGsRFSr9m/gsGQO5RyvxUlwT+2S5zKZosZjktx6yuMjHHcphJURfD0oMKdT+lufTA9LVN2K0SYMspU6EdP1hTMspaWbYGWBfwMA5kWanEikzGrmlugZW8eWBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pbruc/lT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582ACS2T030589
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 12:27:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ntn8ez5J94Za7jHLbwRFNJMz
	nGA5D/WaHlKS9xvVPmI=; b=Pbruc/lTVXGDuI0JyUwi17FkWWiZESNihSfkAnsC
	mdciZdD2y6eHHsGFT4hcwOD30VHUWYlS+/xcoZXmoQQRHZZm7YLF98s+R9DKsVyi
	khXsX6zHGoNkvihV6B0zT1sdCzI8JkLbV8eZm34U51+hgWl2m2FJCuD8gOcUzK1g
	g+DhE/erjOAObK3lRlmQ8Jc5LQgqfah5Z6ykzX6yzNei7xRP4+iDwwDGcVJ36mO5
	Vony3YOGyEd69ejY2Nl7aRuyTW+3G5lJKbDET4mGiRdkh1zqQrxvbwEzGyu6jGRR
	OTSjcgWB6gV3Edm9p73L3by4kw05ScjOA0bZHfzMjcI5Kw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8qqk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 12:27:06 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b311db2c76so34337641cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 05:27:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756816026; x=1757420826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntn8ez5J94Za7jHLbwRFNJMznGA5D/WaHlKS9xvVPmI=;
        b=qw+OoI3RqG8WR7A/knbtc976UfkP65TTtjfWAeMwTWb/h9CoiU5sIehVUDNCeoUZyP
         713sS2EX2gjEOQdilPFevMoquMUaxB/p6jtEMJVPLrabj/MeasW4Mzl/26WAGqPcWWRi
         f7JundIQbSBWOILQKGV6z61cSHzUGUDYKTX3ab8R4nkwYllLIlsLSZO+1xFOkqgxZoMC
         vxca/1xe5fznPrilh7jpWLxaRxMcYWBYswCK92bocnn9eFMGmP3oa/GvhQ7N4Sp8y34u
         ePQOqMypG4dGT2ETJ52mELteHKqJgEBHz81KtZdjGmPst5TWmoHmTUbQfsoL+k/mYxrk
         jeZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXs9w4I5EvQVxOc/D/Dms49SJnnpCnHr69yWsoh+Pq/pV48wYcfNQ2/iUlOIeDn658UDiBJ1lpKwNnHBDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6KTNq5zZmvHyj1+2I+IwSsKQNl7Th9sln2SPVqYDjj0Mj1G06
	zJiHpz7TSRtWhtJaq1YFOFf8Ro3zOq0Y0NyOPzTvSxHVVSe+VD803CQVHjd1SDaJtYvrD2TOWeV
	zqKbuBQ5WD0jrmgaVxbMO6XpoTqfLnO6oaBnx/Iy3yMuMGzPZmW8ee22+TlUgFPvxIb0=
X-Gm-Gg: ASbGncvT8ITGKVqyw/0kyNAJ09DSs6e5icCU8qLzKhsWuXtfcl8upieJS5/JEaZwSRz
	obt+JT5NGpD/dchZ+Io+eyZstNrYLklCv9Pnmyx57pvnP6CJItDHdaOl8FxGnUZL+d+Tq46mpho
	n1+6EWetGcLDmMpJhxkBiSTUf1K5fx5ITH+dZuP92CvMGac5HsKdQh4A7DmyoiBof8O9hpj+qqD
	pxPKegmz+ZaL7GK92HUB/yvNEpWlAk58Ka3DiZkMsR9dJmLpqcJCOgYT3CXmtSqaVewsxdMubWc
	mhH3I6frBCnKNctDeteO7mvHlfyweehZBfWXWID3mLDpHKRjCmP3PMZUGh61p8WMIsgH8S4kVWp
	h2D/speAktz+vN3pJlGNgmCdxkEQj2O5d3EGof+1RGfSHnjgykSZJ
X-Received: by 2002:ac8:580d:0:b0:4ae:b1c9:85ff with SMTP id d75a77b69052e-4b31d7f0cc0mr137942931cf.2.1756816025561;
        Tue, 02 Sep 2025 05:27:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExdU4n5PNydxyc4LwpOYj8vbohHbgS+IfS3msCD3N4Fhko9KMgmFaw92YOVmTJZXPyLhWngQ==
X-Received: by 2002:ac8:580d:0:b0:4ae:b1c9:85ff with SMTP id d75a77b69052e-4b31d7f0cc0mr137942321cf.2.1756816024972;
        Tue, 02 Sep 2025 05:27:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f50332cdsm4498401fa.36.2025.09.02.05.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 05:27:04 -0700 (PDT)
Date: Tue, 2 Sep 2025 15:27:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Jonathan Marek <jonathan@marek.ca>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] drm/msm: Fix bootup splat with separate_gpu_drm
 modparam
Message-ID: <2mhq73sckc3x7rqvllbmfk3qwla2lqqidchecogytxyramoeu5@66j7zupcni2i>
References: <20250902-assorted-sept-1-v1-0-f3ec9baed513@oss.qualcomm.com>
 <20250902-assorted-sept-1-v1-1-f3ec9baed513@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-assorted-sept-1-v1-1-f3ec9baed513@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: _KWmq4PMDiQO3G__U5GP5AZwWLexOON9
X-Proofpoint-GUID: _KWmq4PMDiQO3G__U5GP5AZwWLexOON9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX0EezaDf9BGPZ
 HbLv16uGXy2QwscPRLQUloNdiiPsng4dhFzWs/cm7fNyYKMm42SQQuNMndoWEERC3Ug5pDBbK2s
 iNv6+9O9d2MwoXuzyoZQfIByFm7nSxWe+cGU0VP8MA2qfI6G6+80pLSqz7QUuVnKlMdBnjXxaYY
 J+ZnKVANFRPfRgQ6UgMR5WFm9kYSuhYEbC0RPnPsaXMYMzYbujkBPIjlWiy5XocydnsDHobXrjI
 udiZc7ooDeE2xbQKtJ0/MKwT8f2dESxfi24KYzjC3cbahi0/GF+yxP4YtPFm7ga84RTN2viEWx2
 bPJ6S908WmS5JyBI6255kHgZ4CjhYwYcPBsr8DkDEMiKGunOn2YW/DFChqPOmu/dHzL6Du/mNZd
 9c4HzNQW
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b6e29a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=OXd86HWgjIUhjzT6azQA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

On Tue, Sep 02, 2025 at 05:20:00PM +0530, Akhil P Oommen wrote:
> The drm_gem_for_each_gpuvm_bo() call from lookup_vma() accesses
> drm_gem_obj.gpuva.list, which is not initialized when the drm driver
> does not support DRIVER_GEM_GPUVA feature. Enable it for msm_kms
> drm driver to fix the splat seen when msm.separate_gpu_drm=1 modparam
> is set:
> 
> [    9.506020] Unable to handle kernel paging request at virtual address fffffffffffffff0
> [    9.523160] Mem abort info:
> [    9.523161]   ESR = 0x0000000096000006
> [    9.523163]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    9.523165]   SET = 0, FnV = 0
> [    9.523166]   EA = 0, S1PTW = 0
> [    9.523167]   FSC = 0x06: level 2 translation fault
> [    9.523169] Data abort info:
> [    9.523170]   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
> [    9.523171]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [    9.523172]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [    9.523174] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000ad370f000
> [    9.523176] [fffffffffffffff0] pgd=0000000000000000, p4d=0000000ad4787403, pud=0000000ad4788403, pmd=0000000000000000
> [    9.523184] Internal error: Oops: 0000000096000006 [#1]  SMP
> [    9.592968] CPU: 9 UID: 0 PID: 448 Comm: (udev-worker) Not tainted 6.17.0-rc4-assorted-fix-00005-g0e9bb53a2282-dirty #3 PREEMPT
> [    9.592970] Hardware name: Qualcomm CRD, BIOS 6.0.240718.BOOT.MXF.2.4-00515-HAMOA-1 07/18/2024
> [    9.592971] pstate: a1400005 (NzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> [    9.592973] pc : lookup_vma+0x28/0xe0 [msm]
> [    9.592996] lr : get_vma_locked+0x2c/0x128 [msm]
> [    9.763632] sp : ffff800082dab460
> [    9.763666] Call trace:
> [    9.763668]  lookup_vma+0x28/0xe0 [msm] (P)
> [    9.763688]  get_vma_locked+0x2c/0x128 [msm]
> [    9.763706]  msm_gem_get_and_pin_iova_range+0x68/0x11c [msm]
> [    9.763723]  msm_gem_get_and_pin_iova+0x18/0x24 [msm]
> [    9.763740]  msm_fbdev_driver_fbdev_probe+0xd0/0x258 [msm]
> [    9.763760]  __drm_fb_helper_initial_config_and_unlock+0x288/0x528 [drm_kms_helper]
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

Nit: usually you can drop timestamps from the kernel log.

> 
> Fixes: 217ed15bd399 ("drm/msm: enable separate binding of GPU and display devices")
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/msm_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

