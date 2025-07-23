Return-Path: <linux-kernel+bounces-743114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FE8B0FAC9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 21:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74A341C22D9A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1E123183C;
	Wed, 23 Jul 2025 19:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VjzrmpCL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECFF22F389
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753297740; cv=none; b=auSLI6dqOxTcL4ndyCakjiX6FU7iZuDVIGxbO9XtVJ2VF1YWUwI+rG9spHR1m5pnYilfMPq0yOOdMYtkEeEiYgX1H2vdyki6Y1yKhJSbMKcSWNbsczl4CMvthEGTqs2+jQjDFTv4Gl/yM5OVF4IPrM1FQcoXmN4ZWedk6lMcfTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753297740; c=relaxed/simple;
	bh=xutK1F9r4si/Rv0Fu5T/891uE1sSWBFUL3taaWLxkwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRvXrRLZIOuxKjhhvv6x5G4DlwPMMs5kp4RbxId9st9xYKQJ9H6PFIgeR+m3+u4klQDalTwIDdmuH1So2NCBKbSbNcUn74XrRz2vPXTkkxikgt5szcQuTwXKGLgZLnCmljCUoqpZ03ms/W0FZu9JWDxrohPDGgvEvvkVeCMwGzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VjzrmpCL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NH6lE1013723
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=DySszsnLFN4
	6txmewo3gUR0DN+Qtxzt6DPVvLE0QlUA=; b=VjzrmpCLJaIuckolJY0HFwNaggP
	Wkcum93o4SrXx4L9Rtkx2n7wxenmvWv1KaaG0KXnrdmeKXSjhyCxFs/fC10UCsQQ
	tHl1c4cyL+5zpw9FQyL2fa16dSrWSgCV28FfEFmc5h1OH7SnrSq0GHVrb4XIP2DQ
	p3q3QmXGuI66ue7oC/pgo2KHFIv9+VmR6SgexsT38h3zvPLA5CgqmkF53fTfRYhL
	ukr5TPlXd3s5Vj7wtFzArtegjLnpzVoxnZz5l9IWwBUZ691qjMLsFIzDFFvD6zON
	4PScvQsaQYfNJuCxPYn2KtwFnupSjqXJsqjT1t3TipAD4qUKdcQPx81x/jw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048vcn8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:08:57 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2369dd58602so1289345ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 12:08:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753297737; x=1753902537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DySszsnLFN46txmewo3gUR0DN+Qtxzt6DPVvLE0QlUA=;
        b=OXPDov7hMMCWa5NWsasiGYh5HRsHZ7SwYG6Y4yIf+KTOs/3cHBxkb5X2hQSkzREB+j
         CZToZZ3JRq8hqHGXdRg6Li8oDx3wTSSSvA7UxQAycaVXYzo+wYkkjcwDTXQFn6IosMtt
         y28K4dxjIBBwHxzB4wlTZvniciZM1JQhuoKoQeCJgD10gvhyfjvoessI+Di6jN8M17Bp
         hleOUme13a4QfE+rexLE8N6OUmA2yFey2AbsowSalWLoSIIh3CyIbjwXjNLT5zGz5TZf
         lJhSB96DGXoCLDvGIWgrfZV4nzZ83uZeo2aiEftfhAHznG+KJza9Ga6jcF6r6lVvx6mQ
         +VGw==
X-Forwarded-Encrypted: i=1; AJvYcCVgNodhnldH2trkC9qSc+h5v961MYK6Ys0NEcAAupyW+sr8OjY494OjoSSbE7mJILYb8YZwR4d/sbtmSBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQmUlQJFrR85CaBl7ctIwp2bBsoSFr64n6rOsRKhmwanJOgGic
	za6stzS0NUeoHR72FCWYIGCc1iumGLfFGpYUCQYmE+8N0vyH/cEG/nWzfaYGTtK+nKLMa/X+ZmD
	KAxzSTGQBUiOHsJij/nPpdjV6pnfwyxoD43RpH4xAIE0Th9j9KG/ygZ7NKrQE/pZI7lg=
X-Gm-Gg: ASbGnctq0M8jGubv72EaiAxuwMfKPSFBrINahPqtYvKKiSInz23V0xQUWDEmuIa0TGP
	4dqsqi8U+CkPp25AEFUNV+Hp/HVqyoUNzqfEKmpZzugfZ5+h4EEFWMaa2zw4ZCIGwr8a/4uZQ6V
	k+gMfOoJqaFAIvxsJmFWkp9xviiKj2RceKjpB7tmNYTa8V+aXohKz69IHt1fT3tLxAswWVUYZDY
	m/YshgNFAhqciBVFJELKdowWyhyCYV61ArQJ5WlwkOS/1cu8xYIwPlqJT9yw3aVMIDpgHXWLgam
	jpsmI2m54RUzYWYopqpALk2XT7dSrSI1c8xPiXaWVlrLxwaIfQY=
X-Received: by 2002:a17:902:e892:b0:234:b41e:378f with SMTP id d9443c01a7336-23f9814e994mr60313635ad.15.1753297736817;
        Wed, 23 Jul 2025 12:08:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvO2wHRoQjvHn2W4SmUFBRllrdv1e83xv0jpGEErywCjUsrAZwZkzrYZm9UaPLuj47t1U5KQ==
X-Received: by 2002:a17:902:e892:b0:234:b41e:378f with SMTP id d9443c01a7336-23f9814e994mr60313235ad.15.1753297736352;
        Wed, 23 Jul 2025 12:08:56 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e2d06sm101524775ad.43.2025.07.23.12.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 12:08:55 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] drm/msm: Fix refcnt underflow in error path
Date: Wed, 23 Jul 2025 12:08:49 -0700
Message-ID: <20250723190852.18394-2-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723190852.18394-1-robin.clark@oss.qualcomm.com>
References: <20250723190852.18394-1-robin.clark@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MiLDJSzYAlt6yTJijmELAiTjh5nZL7x-
X-Authority-Analysis: v=2.4 cv=SYL3duRu c=1 sm=1 tr=0 ts=68813349 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=EUspDBNiAAAA:8 a=CtOTWVoUMOquu4jWpgwA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE2MiBTYWx0ZWRfX28Twl4QqRxuM
 rS925ftU1UOwqv8x6M/g34a7JzjPmcyPxCz5LqhErzt9JWmjAytutSZmVJr6tdhcnP1UofK+ARs
 8TrNrqN6sjhHjjkmEoMGMp/mCg3QstkyitYaAbfDlNWN8Uo5BVnQ4HQslUvLSvYIFds1t2FNsVp
 MeLXZEU3Uq7DAGf1fPaE9RMM6gJ0CQhEH46H4ogn4SlEY1cGe3EQ/XklSxss+OPFc1VabV+kpKV
 ssP9naMmzGCh62DLtW6QxDbxUxfh8CKAx6+hvCnBfZippPtX0/zxPA9Sdro+w9auY9S7hc1rxTS
 x7zeb+gi+aM2l3kYfDdSVSAg9PEcnGSRzFd1UVnmbVb4Cs0YibyfXczAZV6dwcwYxksSZ/pII4Z
 bcjy6Fv9NXzvQeAM4yu4kNfKGALYCUrB+TyE9qqeONenJKC2NQyyg4ljgjGJ80yiL0i1N1TG
X-Proofpoint-ORIG-GUID: MiLDJSzYAlt6yTJijmELAiTjh5nZL7x-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230162

If we hit an error path in GEM obj creation before msm_gem_new_handle()
updates obj->resv to point to the gpuvm resv object, then obj->resv
still points to &obj->_resv.  In this case we don't want to decrement
the refcount of the object being freed (since the refcnt is already
zero).  This fixes the following splat:

   ------------[ cut here ]------------
   refcount_t: underflow; use-after-free.
   WARNING: CPU: 9 PID: 7013 at lib/refcount.c:28 refcount_warn_saturate+0xf4/0x148
   Modules linked in: uinput snd_seq_dummy snd_hrtimer aes_ce_ccm snd_soc_wsa884x regmap_sdw q6prm_clocks q6apm_lpass_da>
    qcom_pil_info i2c_hid drm_kms_helper qcom_common qcom_q6v5 phy_snps_eusb2 qcom_geni_serial drm qcom_sysmon pinctrl_s>
   CPU: 9 UID: 1000 PID: 7013 Comm: deqp-vk Not tainted 6.16.0-rc4-debug+ #25 PREEMPT(voluntary)
   Hardware name: LENOVO 83ED/LNVNB161216, BIOS NHCN53WW 08/02/2024
   pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
   pc : refcount_warn_saturate+0xf4/0x148
   lr : refcount_warn_saturate+0xf4/0x148
   sp : ffff8000a2073920
   x29: ffff8000a2073920 x28: 0000000000000010 x27: 0000000000000010
   x26: 0000000000000042 x25: ffff000810e09800 x24: 0000000000000010
   x23: ffff8000a2073b94 x22: ffff000ddb22de00 x21: ffff000ddb22dc00
   x20: ffff000ddb22ddf8 x19: ffff0008024934e0 x18: 000000000000000a
   x17: 0000000000000000 x16: ffff9f8c67d77340 x15: 0000000000000000
   x14: 00000000ffffffff x13: 2e656572662d7265 x12: 7466612d65737520
   x11: 3b776f6c66726564 x10: 00000000ffff7fff x9 : ffff9f8c67506c70
   x8 : ffff9f8c69fa26f0 x7 : 00000000000bffe8 x6 : c0000000ffff7fff
   x5 : ffff000f53e14548 x4 : ffff6082ea2b2000 x3 : ffff0008b86ab080
   x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0008b86ab080
   Call trace:
    refcount_warn_saturate+0xf4/0x148 (P)
    msm_gem_free_object+0x248/0x260 [msm]
    drm_gem_object_free+0x24/0x40 [drm]
    msm_gem_new+0x1c4/0x1e0 [msm]
    msm_gem_new_handle+0x3c/0x1a0 [msm]
    msm_ioctl_gem_new+0x38/0x70 [msm]
    drm_ioctl_kernel+0xc8/0x138 [drm]
    drm_ioctl+0x2c8/0x618 [drm]
    __arm64_sys_ioctl+0xac/0x108
    invoke_syscall.constprop.0+0x64/0xe8
    el0_svc_common.constprop.0+0x40/0xe8
    do_el0_svc+0x24/0x38
    el0_svc+0x54/0x1d8
    el0t_64_sync_handler+0x10c/0x138
    el0t_64_sync+0x19c/0x1a0
   irq event stamp: 3698694
   hardirqs last  enabled at (3698693): [<ffff9f8c675021dc>] __up_console_sem+0x74/0x90
   hardirqs last disabled at (3698694): [<ffff9f8c68ce8164>] el1_dbg+0x24/0x90
   softirqs last  enabled at (3697578): [<ffff9f8c6744ec5c>] handle_softirqs+0x454/0x4b0
   softirqs last disabled at (3697567): [<ffff9f8c67360244>] __do_softirq+0x1c/0x28
   ---[ end trace 0000000000000000 ]---

Fixes: b58e12a66e47 ("drm/msm: Add _NO_SHARE flag")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 33d3354c6102..958bac4e2768 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -1114,10 +1114,12 @@ static void msm_gem_free_object(struct drm_gem_object *obj)
 		put_pages(obj);
 	}
 
-	if (msm_obj->flags & MSM_BO_NO_SHARE) {
+	if (obj->resv != &obj->_resv) {
 		struct drm_gem_object *r_obj =
 			container_of(obj->resv, struct drm_gem_object, _resv);
 
+		WARN_ON(!(msm_obj->flags & MSM_BO_NO_SHARE));
+
 		/* Drop reference we hold to shared resv obj: */
 		drm_gem_object_put(r_obj);
 	}
-- 
2.50.1


