Return-Path: <linux-kernel+bounces-810989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09221B522BE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 22:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14CDF1CC003A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 20:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634623126A9;
	Wed, 10 Sep 2025 20:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OaGyExaa"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48693115AB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757537075; cv=none; b=XWZ5qPaDJkTVm7eLSQntSVY55Ytqv9BPr7Bq3V3Y0ZcurDIf6Pq6rvmF/ucD+c7nMgMS2cLOCZ1fiQgNi0DGP00jlAIU6Cuys79tSR0BYol3/hzUzCU86M9/Mez5lVat4hnbOAnGk7H6Iyd0a9s8ypz0dE4jT8/IASCbjKA+lYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757537075; c=relaxed/simple;
	bh=TsM6Bk8IU172J5i+V6pxbaDOzPWuVAASo1qAv/7B0Mc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MMWIOgWHU40S98X+RkEf7T8E+j0FJ6AGv02+JC8qI9SZczHEz4ZXKkagBvpblSytHJaMLo0EQ6C47ZKJQEGAepRgU4ZEKrQHpTcy7qrR4+lDmhKL3p9PdY13H3bUhOynhmgs6IRvnlbC7Xet1ab0JXWI/xvyhrrEHjr66Lq3jeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OaGyExaa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ACgD3E003650
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GjMQrOqt1kzUjiB7WrBgzYzLHVWBj+hV2C1YKYXo120=; b=OaGyExaaQQXe2OT7
	yepRG1DWBHoXnJ77boJyY9isfWYOlebMd1ol4dTjE9f4Jbk+f7Ao3h9fvbjpI0/l
	SzQ7KRsns/1/ovmcQSvkH6V2rFDxt+xMrPNSFbMjqRpoveSajkMWR01NBFs87Wg7
	x3oGiuvvCettf+wJJLvswNLXl8wkn+XJS8bp7MyoapEzhbEOvNScSJWjXsgvX4d4
	NiO315xIvBTe6UPN/8lm6JAlZlscv4idOJZYMe/ZwF24p/YkFZz6Qd6l+jgFk0Vz
	iiXh6rxNMoZUFr423h/AUM5jVn5afppPYpwj/JZthBaTNGwu3n78wrHkxkFI1c6U
	SdP4NA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490bwsdct2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:44:33 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77260b29516so7659b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757537072; x=1758141872;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GjMQrOqt1kzUjiB7WrBgzYzLHVWBj+hV2C1YKYXo120=;
        b=kiVJJVtrJOBXuX6f4m6fA0jL4jd8YmSuVYbOo+ntF1CQP+KA5nIQz9psCJt5lOdDQ4
         hPHM/ZV8YbfdD+d0DpolGLcSlAhtU8mP+zu2c1HbH3YLKoyibyqNNb8dgGG1wl5eF9QM
         XKVKY98iq1p9/iHn1tcCaWlCiFpO8LlhVpfgbRZcx/w96lU3uYyKU6krvYusJ9HvO9no
         CjIATFqjnwLjg+qx7B76a6l3sX1H+BcWjrqt61KdbOb6ikJD8Q/A4rn95DVgEbU1c5QS
         dzGJBKr/PRzhHwCekr+iv31PSMwfZkzn9Lnsm7m58E03PBX15LyFIptH8HFl2U0MK6iq
         LTpg==
X-Forwarded-Encrypted: i=1; AJvYcCXrEsbLN+ZVR58T3BbjWtj0dJbBJd+AJ2JvC+w1XgUlprpkjOltjSne91igbwnbbDg3EIm7amRihQ+X5Yk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBGybquBqsEV0zrf2sH4vE0T1nREulJ9AIpnIMogOS/cSFGFcy
	09JUnExavWUjU+THe3VL8LteTgtVhnrmtxEXsE6/+pdSgUpEyoOx55Txypyde9D/iPrOMZ6U9gi
	oJKUeYpkqf0XgvX0Nf0w8zwp5iUehr/S37v/23K+f3nss/PaxxANtF+79jZquULMkQFQ=
X-Gm-Gg: ASbGnctee846NxlJGYPsyK3nJtYkcgTd42IkiQEtBRLv6wQs4XCmJ81O7sS9pEnK5Nk
	4YXN1QxJjaRI8u6JxOxH2gTCK+pv4txt+AcPSUczzJv9B0gP3k4qYVzSnNf7AKydG/FdVbhPvWs
	3hgOs18k5n3ZhGVR+6bmbKgiiOMdWCxZIYVzOpz/7Woc/t5r+L6xrj/f9u1iIUsunhZmVpT/WcY
	rjTMNHacTv4frX/FK50uqO+1eo9op0w74jJ13T53budgYjVcbfCH18r21HgKlj1kHFVCi3HERyP
	kN0MqGTh1JIVM0tMZ7tPHQcvMG1JndonJPa9kd68VTRD2QgQEHpQqmoaLKrCiase
X-Received: by 2002:a05:6a20:3c8f:b0:251:1b8c:565c with SMTP id adf61e73a8af0-2534441550cmr23941561637.31.1757537072094;
        Wed, 10 Sep 2025 13:44:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9OV2MeB3Kpz+lIR7PJ0sGEfu8xDO/gzp+R4DHMG4utoV9wKznHz0MNDx+h6Gs3YDnRszCcw==
X-Received: by 2002:a05:6a20:3c8f:b0:251:1b8c:565c with SMTP id adf61e73a8af0-2534441550cmr23941533637.31.1757537071574;
        Wed, 10 Sep 2025 13:44:31 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd61eaa42sm46771a91.5.2025.09.10.13.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 13:44:31 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 02:14:04 +0530
Subject: [PATCH v2 1/4] drm/msm: Fix bootup splat with separate_gpu_drm
 modparam
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-assorted-sept-1-v2-1-a8bf1ee20792@oss.qualcomm.com>
References: <20250911-assorted-sept-1-v2-0-a8bf1ee20792@oss.qualcomm.com>
In-Reply-To: <20250911-assorted-sept-1-v2-0-a8bf1ee20792@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757537061; l=4407;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=TsM6Bk8IU172J5i+V6pxbaDOzPWuVAASo1qAv/7B0Mc=;
 b=ducsX3eTW444B3LX7ve+GjHgu50CveeJOKhPEVAFz0SDyyqB4N0olEWFgMcuaDv3ZE4VrnB3p
 LTjjhefYUPLCBh3hegVS8gvfT8foSgSNQCh0oqzPjvLSCnjT4I2YhA3
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: h76hm22NxYTgeFrbPiQhL67C4aLC9FHC
X-Proofpoint-GUID: h76hm22NxYTgeFrbPiQhL67C4aLC9FHC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfX1ZypITL55Lov
 cx/v1uR3UUGy/FPWjDQXXyp17py7tBgK3wW3q38H6ztS2Bb8KiLK1UK99WVpTlilDrVZQQRT1eR
 tAfFkN7p1Zzt7CxpBR4UvtTleKnngjHowy6pTCtIPxFT6iqgE3ERkdWlEQ90Vbph0ztDUjra1MX
 5IlGrPk+mVHnl9B3T9sf2DPhQ0QfGC3zZNJ6ObiH8g4mNzz/Az6psOjDpmXxGq2GpnLuKv8TIEU
 CPJ8H4k1dZEh0Yi2S2xb+X7e0D0yZGQPQnxEX5Kj001/J5ZjfKtAgqujkq1IcWYCnd2eE8BoRuh
 RjCW+O2a0G/RfTYY6wkVKp2ruDUO2zdOrtAIIWffNTvZU91JaTkaz2bobl7K2UaF2UwjDJrDHMQ
 8xWAFgiJ
X-Authority-Analysis: v=2.4 cv=G4kcE8k5 c=1 sm=1 tr=0 ts=68c1e331 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=wZg4fdH2GHFv12Tp5BEA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018

The drm_gem_for_each_gpuvm_bo() call from lookup_vma() accesses
drm_gem_obj.gpuva.list, which is not initialized when the drm driver
does not support DRIVER_GEM_GPUVA feature. Enable it for msm_kms
drm driver to fix the splat seen when msm.separate_gpu_drm=1 modparam
is set. Also, update the description of DRIVER_GEM_GPUVA flag to
reflect that it is also used by DRM drivers which doesn't support user
defined GPUVA bindings. For eg: msm_kms driver.

	Unable to handle kernel paging request at virtual address fffffffffffffff0
	Mem abort info:
	  ESR = 0x0000000096000006
	  EC = 0x25: DABT (current EL), IL = 32 bits
	  SET = 0, FnV = 0
	  EA = 0, S1PTW = 0
	  FSC = 0x06: level 2 translation fault
	Data abort info:
	  ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
	  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
	  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
	swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000ad370f000
	[fffffffffffffff0] pgd=0000000000000000, p4d=0000000ad4787403, pud=0000000ad4788403, pmd=0000000000000000
	Internal error: Oops: 0000000096000006 [#1]  SMP
	CPU: 9 UID: 0 PID: 448 Comm: (udev-worker) Not tainted 6.17.0-rc4-assorted-fix-00005-g0e9bb53a2282-dirty #3 PREEMPT
	pstate: a1400005 (NzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
	pc : lookup_vma+0x28/0xe0 [msm]
	lr : get_vma_locked+0x2c/0x128 [msm]
	sp : ffff800082dab460
	Call trace:
	 lookup_vma+0x28/0xe0 [msm] (P)
	 get_vma_locked+0x2c/0x128 [msm]
	 msm_gem_get_and_pin_iova_range+0x68/0x11c [msm]
	 msm_gem_get_and_pin_iova+0x18/0x24 [msm]
	 msm_fbdev_driver_fbdev_probe+0xd0/0x258 [msm]
	 __drm_fb_helper_initial_config_and_unlock+0x288/0x528 [drm_kms_helper]
	 drm_fb_helper_initial_config+0x44/0x54 [drm_kms_helper]
	 drm_fbdev_client_hotplug+0x84/0xd4 [drm_client_lib]
	 drm_client_register+0x58/0x9c [drm]
	 drm_fbdev_client_setup+0xe8/0xcf0 [drm_client_lib]
	 drm_client_setup+0xb4/0xd8 [drm_client_lib]
	 msm_drm_kms_post_init+0x2c/0x3c [msm]
	 msm_drm_init+0x1a8/0x22c [msm]
	 msm_drm_bind+0x30/0x3c [msm]
	 try_to_bring_up_aggregate_device+0x168/0x1d4
	 __component_add+0xa4/0x170
	 component_add+0x14/0x20
	 msm_dp_display_probe_tail+0x4c/0xac [msm]
	 msm_dp_auxbus_done_probe+0x14/0x20 [msm]
	 dp_aux_ep_probe+0x4c/0xf0 [drm_dp_aux_bus]
	 really_probe+0xbc/0x298
	 __driver_probe_device+0x78/0x12c
	 driver_probe_device+0x40/0x160
	 __driver_attach+0x94/0x19c
	 bus_for_each_dev+0x74/0xd4
	 driver_attach+0x24/0x30
	 bus_add_driver+0xe4/0x208
	 driver_register+0x60/0x128
	 __dp_aux_dp_driver_register+0x24/0x30 [drm_dp_aux_bus]
	 atana33xc20_init+0x20/0x1000 [panel_samsung_atna33xc20]
	 do_one_initcall+0x6c/0x1b0
	 do_init_module+0x58/0x234
	 load_module+0x19cc/0x1bd4
	 init_module_from_file+0x84/0xc4
	 __arm64_sys_finit_module+0x1b8/0x2cc
	 invoke_syscall+0x48/0x110
	 el0_svc_common.constprop.0+0xc8/0xe8
	 do_el0_svc+0x20/0x2c
	 el0_svc+0x34/0xf0
	 el0t_64_sync_handler+0xa0/0xe4
	 el0t_64_sync+0x198/0x19c
	Code: eb0000bf 54000480 d100a003 aa0303e2 (f8418c44)
	---[ end trace 0000000000000000 ]---

Fixes: 217ed15bd399 ("drm/msm: enable separate binding of GPU and display devices")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_drv.c | 1 +
 include/drm/drm_drv.h         | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 9dcc7a596a11d9342a515dab694bac93dc2805cb..7e977fec4100792394dccf59097a01c2b2556608 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -826,6 +826,7 @@ static const struct file_operations fops = {
 
 #define DRIVER_FEATURES_KMS ( \
 		DRIVER_GEM | \
+		DRIVER_GEM_GPUVA | \
 		DRIVER_ATOMIC | \
 		DRIVER_MODESET | \
 		0 )
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 42fc085f986dee9261f8b08c4fc7d93b8d6d9769..8729c88fd12ba76eb0084fc1a2ebccaabf377995 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -110,7 +110,8 @@ enum drm_driver_feature {
 	/**
 	 * @DRIVER_GEM_GPUVA:
 	 *
-	 * Driver supports user defined GPU VA bindings for GEM objects.
+	 * Driver uses the drm_gpuvm infrastructure for managing GPU virtual
+	 * address mappings of GEM objects.
 	 */
 	DRIVER_GEM_GPUVA		= BIT(8),
 	/**

-- 
2.50.1


