Return-Path: <linux-kernel+bounces-829043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B9FB9625E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 320C3189155C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87C023BCF8;
	Tue, 23 Sep 2025 14:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BOda4Zr+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322D322D4E9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758636299; cv=none; b=gmxIUSC4oj59MtxcqLGz2T35mbB5XdMTUAVHy6D4dw6d3vH8z78XSBgd0C3YTRjrE5nvPZfVIBmubLJM42uve8VTQEx8ZViQAktbtkPCwJmZxe/tDa+PkUq26UKAgXxAaPpoDaSq0woTzqX/Qeh0f+bvULS9kL2RLKNaxGTGnQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758636299; c=relaxed/simple;
	bh=2fousLnzCI9SazH0eEA8Hzz/eK34wqY0cplvtTgLdC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=exOROfoX2Eug2uEOF1NID7PJzxV/w5qqiCsm77VspZv7hVRi3LiyMjJhqlwx2hOq+1hGy6eAQrmehuQuSGZhS/W0MWTr7nyqXNzZz3FHPmek2JySWbc9rjgqkuNMfmFv/KEP1QXd34WZC4tZYDfYFj6IJ37mLnTsJPyqFbAag3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BOda4Zr+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N8H8gH020615
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:04:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=qF7JNnnC6auZa30uLt13ZSI6pihLUX73qMp
	x0C1fb54=; b=BOda4Zr+Z+o0FBg4piDvNbmefDrgjEeT2fGTBubRDbKmioOlKb8
	o5TfpFoeX070XHy9n41ON7M3QC1sGCjyCfETn+lH3ekRxxHKuSKtYOW3gZpAtsNW
	YMtocaj/mjwqoTxfHbKDYENh6a7KM6maUvnkWWlTtOAlpBYnC3O77UfO0Ti6zZOG
	Nnwh6MRZ7+wcMMA1i65+mc96kUSAmdskM7jNQ3pbJdWK5FOu3ZujvrqsQmb/8brr
	/IPvgpn1oB8Tvh1WUMvRvJs8puGsq7QU+/7smkLVrrMvWCO+Ti4uFMjIfP1CSehh
	vnj+s1BY5utHaJ3zzEVqSzNUAMCl1Y0JYMg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bhvjt30n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:04:55 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-77b73bddbdcso5432194b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758636293; x=1759241093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qF7JNnnC6auZa30uLt13ZSI6pihLUX73qMpx0C1fb54=;
        b=TmC8w/wpPCB5a2hMlLs6EeMVYS+5362icJgpoFeMpNaBzkX8uGYSada8nbkGQe+PIB
         TimMw7C+rDworZJFSNbBfOjJsvSApAwsaFSno/2VW5hrr/PgYqjMs6nbnf8FbO5IVdu1
         9QoNXCQ8O3qLRNHGfcLLeI7Ir4SR1hKglTC+EWv/4sVKPjIojqsPNIlA183xv/hO6mV0
         lqq6jyT7GZmCQLXUXah8o98wGAL+ePw9GKNQsXhaJY5y1aooOapJHLt2Z4b6TcYy/yRi
         03DDRGWRv8gNf2AYXVuvqE90NKV9G2aoD8Ma8m5ytGep87d25yHM432BFzUy6jG/RaP5
         bnRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEDiqIsYK99BLpVX2VD8mwNbRKoZQb/wbrxw107hJFVK12YPw8pVUxTTBcHqedceteGVc+nPBSoWoQxVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdaVECLjowY0OVm5jdemwaoCMSI/1vp69o/JeEUBA5YGG2VGAw
	Xi/i+wg2WQHLIJGdYO/DF4nNHVpDoRtXbVBkzg3geIqCcdkcRqH0bVYHen+vlniY7vLH4Ou3xkY
	PrMPdmubF4M3hSJFstnOJmOggDViGyJHBHUsIxkjFhLXuHoQ49pQFEyeAwnmX11Ehfcg=
X-Gm-Gg: ASbGnctaF3QCaodb2SUe/5wgWkjCEoZqRRNVo4wYfnsuVHXywzrUm9kLrLGe7rKndg7
	WTugysH/8el97a8GR/VOa3VJJXB0CVtBVkGjaPK6LvvHR7HmfcOH+hdzj8WSR+/nl07VLWyM5nF
	CYi6V3P7ysikz4CW9nBJDQoJyb00Eu6gV5O+HU+W84CYe3eNPsD/nYTosoozwShap1m/1ektCM4
	09ttBMyZjm4JyqBgnbtYFz+2Xq9bCfGyCRAZ4MI+q0yLXZL3UKShspUPljgppbWa21iKew3Q6Se
	QZMWLmyKIiL8BihauVx6c66lsII6RLUeUsDRnlS910OQf038tFE=
X-Received: by 2002:a05:6a00:2389:b0:77e:eb28:c59d with SMTP id d2e1a72fcca58-77f5483555bmr2964426b3a.5.1758636292702;
        Tue, 23 Sep 2025 07:04:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHriibLVf2iW30g+eltTQYpwyfphiwc7EROq76RBdBzt9+tjnANNboDPlS44Gb5y7K/RblhCQ==
X-Received: by 2002:a05:6a00:2389:b0:77e:eb28:c59d with SMTP id d2e1a72fcca58-77f5483555bmr2964368b3a.5.1758636291921;
        Tue, 23 Sep 2025 07:04:51 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f2deca77asm7401739b3a.98.2025.09.23.07.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:04:51 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm: Fix GEM free for imported dma-bufs
Date: Tue, 23 Sep 2025 07:04:40 -0700
Message-ID: <20250923140441.746081-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: fb1Pq9iiWGsRb9VysLqOawl4L4Uyxcch
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAxMSBTYWx0ZWRfX5hRruGv6grEb
 hC6FOPwdPtXOapyHB8vbDRCs23iL83XFTcrRp/Gvj5nddFDjQTDYcQdXO82EDEfb/vSAvkFcSex
 QY2oanmb51ip6eo3K6FAW2G92/RYa9F1qpCdi9maHjw0xBNQLUejm9RdbEXKBhmPKlO4j4srkv6
 uKWm9cTQ0oZc6aImpPHqwxK+IRN+x/cLR+WXk+USy5rWVfHlLPDgXAaNaXgDa4i2CCBiHRoKxHG
 1I4LVkA8Pe8dY3kAjebl1dJ7YU1VYGpIMmG4U7N+c6j05YEhHCIeLeeEm3up6BXh3LpsJpa4HgX
 J2Fb6e+tWGKNv/V0bQDxudWAJk4U3ZTLPUxG5YHnqz3R8siJ3VwiKIA5wj8NPekVmFYseyYRDNZ
 nwnKyO35
X-Proofpoint-GUID: fb1Pq9iiWGsRb9VysLqOawl4L4Uyxcch
X-Authority-Analysis: v=2.4 cv=Csq/cm4D c=1 sm=1 tr=0 ts=68d2a907 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=9zJA0kw6ANc6jqlDSAsA:9
 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230011

Imported dma-bufs also have obj->resv != &obj->_resv.  So we should
check both this condition in addition to flags for handling the
_NO_SHARE case.

Fixes this splat that was reported with IRIS video playback:

    ------------[ cut here ]------------
    WARNING: CPU: 3 PID: 2040 at drivers/gpu/drm/msm/msm_gem.c:1127 msm_gem_free_object+0x1f8/0x264 [msm]
    CPU: 3 UID: 1000 PID: 2040 Comm: .gnome-shell-wr Not tainted 6.17.0-rc7 #1 PREEMPT
    pstate: 81400005 (Nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
    pc : msm_gem_free_object+0x1f8/0x264 [msm]
    lr : msm_gem_free_object+0x138/0x264 [msm]
    sp : ffff800092a1bb30
    x29: ffff800092a1bb80 x28: ffff800092a1bce8 x27: ffffbc702dbdbe08
    x26: 0000000000000008 x25: 0000000000000009 x24: 00000000000000a6
    x23: ffff00083c72f850 x22: ffff00083c72f868 x21: ffff00087e69f200
    x20: ffff00087e69f330 x19: ffff00084d157ae0 x18: 0000000000000000
    x17: 0000000000000000 x16: ffffbc704bd46b80 x15: 0000ffffd0959540
    x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
    x11: ffffbc702e6cdb48 x10: 0000000000000000 x9 : 000000000000003f
    x8 : ffff800092a1ba90 x7 : 0000000000000000 x6 : 0000000000000020
    x5 : ffffbc704bd46c40 x4 : fffffdffe102cf60 x3 : 0000000000400032
    x2 : 0000000000020000 x1 : ffff00087e6978e8 x0 : ffff00087e6977e8
    Call trace:
     msm_gem_free_object+0x1f8/0x264 [msm] (P)
     drm_gem_object_free+0x1c/0x30 [drm]
     drm_gem_object_handle_put_unlocked+0x138/0x150 [drm]
     drm_gem_object_release_handle+0x5c/0xcc [drm]
     drm_gem_handle_delete+0x68/0xbc [drm]
     drm_gem_close_ioctl+0x34/0x40 [drm]
     drm_ioctl_kernel+0xc0/0x130 [drm]
     drm_ioctl+0x360/0x4e0 [drm]
     __arm64_sys_ioctl+0xac/0x104
     invoke_syscall+0x48/0x104
     el0_svc_common.constprop.0+0x40/0xe0
     do_el0_svc+0x1c/0x28
     el0_svc+0x34/0xec
     el0t_64_sync_handler+0xa0/0xe4
     el0t_64_sync+0x198/0x19c
    ---[ end trace 0000000000000000 ]---
    ------------[ cut here ]------------

Reported-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Fixes: de651b6e040b ("drm/msm: Fix refcnt underflow in error path")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 9f0f5b77f1bd..3aea9b493375 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -1121,12 +1121,16 @@ static void msm_gem_free_object(struct drm_gem_object *obj)
 		put_pages(obj);
 	}
 
-	if (obj->resv != &obj->_resv) {
+	/*
+	 * In error paths, we could end up here before msm_gem_new_handle()
+	 * has changed obj->resv to point to the shared resv.  In this case,
+	 * we don't want to drop a ref to the shared r_obj that we haven't
+	 * taken yet.
+	 */
+	if ((msm_obj->flags & MSM_BO_NO_SHARE) && (obj->resv != &obj->_resv)) {
 		struct drm_gem_object *r_obj =
 			container_of(obj->resv, struct drm_gem_object, _resv);
 
-		WARN_ON(!(msm_obj->flags & MSM_BO_NO_SHARE));
-
 		/* Drop reference we hold to shared resv obj: */
 		drm_gem_object_put(r_obj);
 	}
-- 
2.51.0


