Return-Path: <linux-kernel+bounces-873223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E970C136DE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77B66502BF4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6272E4A32;
	Tue, 28 Oct 2025 08:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eLMmtv60"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB4018C031
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761638455; cv=none; b=K1jsfJ7oZKmPzwCUrrLsua+/mGVym7oAAZhPbyBJE6oVt8EdGUhx+RkuLQTM/sR8CyYZ4AhCHqURtwgGLTLy4NBf4nlMQuCkCBAuxqHox0OSlVrJ74Y3xmSDM3OIyzHEnCokRA/ZWVsrkqZbRnz2q37+fjOk4J60j+U3iawFBIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761638455; c=relaxed/simple;
	bh=p9YYiGlKWgw4AtQNH2Pf2cZc8xQeU5M46AS2Um1i0yc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=rybZ/NLBmr+FE64aENCa0M3LqzVUbDLqgM89tcI2tlZKaU2/iPGLo4B6Artoi9OL4ivyZhtzwou6adYIP2UhKP/DD842STCXWlbJPDsP9iir7RYWefoa6ZrvgyR1h1I0ASkIHNaiRqk6ZeTMWaaACZSPRaNOc8OPwKrhwRz1Icg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eLMmtv60; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59S322YT353623
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=eUjArtBAoNmM
	vZQeI9dQSlhhFP8tiTS+QMPHjZvTUV0=; b=eLMmtv606npCfrCPTNO+gFQgNwt6
	Q8COFepTEReOQRw9yQsf9400oi89WJ+D/LnbJDRZdAezJP/eOEzhkJMpWQ/DlXo1
	9lKETymDG+4mLFrDAadIeFmlR0vjQF01FaA4y/4lDbgE/A3jz5qNCSi2K4zloZDo
	A7TFEAUMv7lzgFzDW1ozsm0GvjFCEXrixj9GzlTEhbizA2D5GjrrUS1ob8BgXB9g
	hSe3jeNDIayPuMsLaCc95tY7TL2jJ2hs8PESw4YeiVRV/DNeRBYX7ur7JRlNVtnS
	mcMNuoNiGZjgEdNLGgu3tAZKFtm0OmXUMr4Cuivll3L86mRc5yiUYcN0Cg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2njrrrjs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:00:53 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-78108268ea3so5321055b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 01:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761638453; x=1762243253;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eUjArtBAoNmMvZQeI9dQSlhhFP8tiTS+QMPHjZvTUV0=;
        b=JqxqDdsR/c/2Nj2Y27UTdoGwd0lUSJs3y6TCo5Zsa8Sgpko3viPACdTqwjrR6G4XVm
         ltcbv46ACAtchTGkQrSh9oFVR5ZxxrXG6zjth9kKOrN6SEJOqSXc1ko/WoMTfc0rQK3N
         Y5UBnqe2jSS98O4f9zLwu4E7j4VhUmGPRYrRUusM2hcgkgInMdnFBS69vkTK7alLPos8
         BNS6qcl8ACbBpMXL+3HkrSIR66IjxLUDZWgmSkqueA12gUZloCPhFB4VJTLGOwieCPoh
         dtj1BrZnjq61YjEtnwTZKLx9TDAGoZP1W35k1E/ngVPLLbkjyzqKmmAdf2fSvhNwNeHD
         /mKA==
X-Forwarded-Encrypted: i=1; AJvYcCVd0MHmJZqDHGhEeD0ES9k1CbIha7PYKXbLWBITbuhCRuWMxBmOkDJQ9h98gSOh7Ux9ueHb5AxmDqZHs00=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2vVi7r72Ton8gtDgaXXLjFkBeumXMxaVryqIj4DxwooiJNMiq
	tu7gVxgzmjCLOqsWOzrnck1KAg4Z2HytEzEfc79fdT4wuRRR809oc6+SgtQ7FeJpRg12Ic7FaxS
	oOpMRSREbuNc/yw690fP73+P+EsLs63A7BAxig2WkzczMqHwHB1sgXhNYtVZfsR7x7VU=
X-Gm-Gg: ASbGnctmw7EmUToG0J1qco7Peu+eDK2UNwbDRLETnErDQPyPCHn+lIjTjLjd+KztAmP
	uSW/5ev5ApJOIqw9T1kZPWOxM8ojrFf6T/YRtod5dAktk8j9EcXh7Uk2yuHzRCw9oAxtjYiiY71
	HSSUt0RHrBi4fGAsCW30GQnkB445iJxEFxMJd/NFP9JDjesAahOASyHfUoCkngDNmG7u7vfOuvT
	bGtOxpe9odHMLDV3A0hj1FV/u01DU5AESjXRsUNFRmXA8pdsBqufZqRdeKuwdeLtHk0mUN4avew
	a3cxgSSFI0b+JLs1e6h6DW3Hyf+xawGHXB3AqoLkn5gLNZJjRhQrcipvrKYj4FF9PA+qLcnWbVn
	Q1AI4pQt07hFijt+BT6mzwLIt6DmYKTA2RAyMbQ==
X-Received: by 2002:a05:6a21:62c2:b0:343:af1:9a4f with SMTP id adf61e73a8af0-344db1b47e6mr2766474637.0.1761638452147;
        Tue, 28 Oct 2025 01:00:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1IPgf+9vefzYbbw6JRAKwPbUIZ+a7crwRx+RyJwI8REM8LTrArs/uCUDjZaB0QqEn8TOtqQ==
X-Received: by 2002:a05:6a21:62c2:b0:343:af1:9a4f with SMTP id adf61e73a8af0-344db1b47e6mr2766427637.0.1761638451568;
        Tue, 28 Oct 2025 01:00:51 -0700 (PDT)
Received: from hu-uaggarwa-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41409e456sm10621284b3a.71.2025.10.28.01.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 01:00:51 -0700 (PDT)
From: Uttkarsh Aggarwal <uttkarsh.aggarwal@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        wesley.cheng@oss.qualcomm.com,
        Uttkarsh Aggarwal <uttkarsh.aggarwal@oss.qualcomm.com>
Subject: [PATCH] xhci: sideband: Fix race condition in sideband unregister
Date: Tue, 28 Oct 2025 13:30:43 +0530
Message-Id: <20251028080043.27760-1-uttkarsh.aggarwal@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
X-Authority-Analysis: v=2.4 cv=dqvWylg4 c=1 sm=1 tr=0 ts=69007835 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=Se2M_dWrVOHG7u8n9bsA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: pwRkueTWJDas-nD3zxkmV8GQ8v2Dmoij
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA2NyBTYWx0ZWRfX6R8EGC0KEwd7
 E9VgJMRDdpKlyaKhzp5rmDrtpAAYFjGpm17Xs6UAnDe/gVyvgcovxxT2ZDcBKkLlCJ2hUM1Ph0q
 ffn6p5fiB887EQ09rEAAORz4MnhAC2d8ZNZdZgua9rsfFed5IJ/FwivNRpcGJg5Bze2XvLMGGBD
 szQ9mALpU0CeK2Vt5RRd3b+IAATDa8XKs2Q3zg3kYIxL7mBLtfpMjcFLt/K9E+A5YJWukIiDS8y
 E/DGKtl7rhk33bkRKJa14JgcB3zp0n2rakYI2gEZCllYDnlWfElOXJPskxSqOSSR+1lwQS8CM5a
 xEKW2y2HdPkZDGjdCndwpSk4jKCB+kx2NJ4MdS8zZv+2qiR/jvAMw0ol9p8byPiqtP30KxTahgq
 GiRLkddEBJucFtWWc4OnXNXbsjNjpg==
X-Proofpoint-ORIG-GUID: pwRkueTWJDas-nD3zxkmV8GQ8v2Dmoij
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510280067
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

A kernel panic was observed due to a race condition between un-registering
sideband and creating sideband interrupters. The issue occurrs when thread
T1 runs uaudio_disconnect() and released sb->xhci via sideband_unregister,
while thread T2 simultaneously accessed the now-NULL sb->xhci in
xhci_sideband_create_interrupter() resulting in a crash.

By locking the mutex before modifying sb->xhci, any thread calling
xhci_sideband_create_interrupter() will either see a valid sb->xhci or wait
until xhci_sideband_unregister() completes.

Signed-off-by: Uttkarsh Aggarwal <uttkarsh.aggarwal@oss.qualcomm.com>
---
 drivers/usb/host/xhci-sideband.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/xhci-sideband.c b/drivers/usb/host/xhci-sideband.c
index e771a476fef2..74a58f759cee 100644
--- a/drivers/usb/host/xhci-sideband.c
+++ b/drivers/usb/host/xhci-sideband.c
@@ -481,10 +481,12 @@ xhci_sideband_unregister(struct xhci_sideband *sb)
 
 	xhci_sideband_remove_interrupter(sb);
 
+	mutex_lock(&sb->mutex);
 	spin_lock_irq(&xhci->lock);
 	sb->xhci = NULL;
 	sb->vdev->sideband = NULL;
 	spin_unlock_irq(&xhci->lock);
+	mutex_unlock(&sb->mutex);
 
 	kfree(sb);
 }
-- 
2.17.1


