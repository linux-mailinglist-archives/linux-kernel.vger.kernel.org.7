Return-Path: <linux-kernel+bounces-871698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1130C0E1EB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8D77423979
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DE53054D2;
	Mon, 27 Oct 2025 13:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="etrFSmYz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAEA2F6902
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761572125; cv=none; b=R+PH1irEcDPtnY1BNnU3Ql5T/fFy9PpTHYbhGllAv4X4oxUHeJZWnIlnTY+Z9fy/JMIt8qrzIOo2/ECy752RTZaLMo1tk20jejZEzIc6O8PljaNxGzw5B0HpCMJqw7vxT9wbMiMwe26whvDHRRdKZ4UD7qoVeDCuSKJ6LOaIt/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761572125; c=relaxed/simple;
	bh=fbnJXiQX68kkbm/D1iLlZF0GumHyj/1MlksgTx0Y+yQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=t/2BRrIbHpQ7Ibr0EA/jOKD23vjJ4C77+sIVn7nhb1OTeb+lUky9jJtS3Q6FVw3M1Z0Cr4NE7E5qHG+Qj1t7WNgiTeD6vjZi9BrLfXnMPAx09qaB5JJXpJjNJXZFOSy2MSijmEb2NdjXUyxuy60HRt6e92qE4Ic24io750zJTOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=etrFSmYz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R7K2J32059437
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ErdY8kXLBkkRgO7ggfayGK
	UKWYq0R05r3pV8kdnXxTA=; b=etrFSmYzd3qEMObYGP+YmmdVsUR1EngqecB9bd
	BGWEnI3xtBl9ig7BNdgiujGFhcXW35AyVY23Le9QFfIKUb2iACwwcdM+AbQ+5Rfp
	5t2hjB9dYlKKk6djVqWRa2Lc/lvrBY/WKgZqxIMz1lwBHt8Y5pI+7hDk0yRRNlws
	WmGbefkVXtOpiiIAX6D3AVlFxMp5bE4i5EN1udC3CGcmv5W89hnkc9aLy8RoZPOB
	gzBB5wE/HcyHy43z4uzt+6kFOs61nz1eszbhHMGgK2PoMpSfDeREHrrvcUSQz+Lt
	fVvGH1SaYSL/NYJEqc615NDhxUqiZ6IbCSWD0YkKw2LXUArw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a248p91n9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:35:23 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ecf4540bb6so31314631cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:35:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761572123; x=1762176923;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ErdY8kXLBkkRgO7ggfayGKUKWYq0R05r3pV8kdnXxTA=;
        b=a+RyCa7sIndyF/UVpQS9SFYeim+BQoM3FRou7NBSpKjrQdcx5k7yRr8i+H84WIP0xF
         nt9Vz0NhHvJj6xbRhrh29YMOTn7Ap6ycsOIEwqmU8e8ubvhmYdHFaL9OTaBxT+mzw8gH
         35GlMT1t+S5Hv6qyelCtFwnEG6zu4iwpLK1AWH37qwM/zPQNljLT2gZKJ5JFloIq9dHT
         RFKBKpX1B1pqHtFRGf3gdd1thQ9EBk449RjWKHSoWQ+fuxAn532SjtmBnsfm1ynliOmU
         BXM8itSCtplf03yJWehbT/cgHt7MmbYHI9kBbjAb4PjMov+eKi7zxFFPd1vuqZlY0hOo
         4gLw==
X-Forwarded-Encrypted: i=1; AJvYcCUAJLSHj5IVJEr5D4ux7egpYG3buFOx3XZArGG3i8iG+wzuNa134njZbrkzHU5kzZFUib/w0Yh7gSLTgB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu9HI/RBSLckbSNPe9D1YXKhqD4r8T0Iz5PSaKa59A5/iQafJU
	7Ge2xaXUR+2QWYVlug/1jiD6WTpYmkZ4GHF0zGMIT+o7Ii72M2nTgHuPQH7d4M3hGrVoBP+vLEq
	eBmD5BrjoSNICIomPKlSBvWzDzeq364+aSrezQRtfo7Llwb/VI7+88ozY8z2GZhT7dx8=
X-Gm-Gg: ASbGnctMzwUV/hrHNc2yzK2pxCFb7JcdL/54RVoMGKg/4toKZwUMrafcRHRSq5PmGao
	ud5v/n+OhUWVb3BCsWX3JmrEnGUJduKnkrMlbBRhZzX6eiH2Ok9O+G5rMJXgjJvLUT0eebacUzC
	Zl4DIQmrLiMtmdpc8nCX9RQi5LSlBqoQFl1ZF7oJRoVM8jZeoim7ECTu9MLY3+dSouL24CQi3mQ
	0IGzUhBE2x1Zeq/wB6X/y/Dlpezw4o9Vjqe/FFEFNNULy0vSbzufbKJFozRogk2d99XlUoyDpWy
	I81fXMxxh72Fs6+MwS4OR3QCRVv2EhGZGN7x3YVWFH/BQApvq9Yfto/ioGpE6QtheRQec+ecumm
	XNdDCjsKweXhWFOED7gM/Cagh5dgPUEG+7qr74Q3jI5EIKGaxIE+H0QdtsK0guifKE2Y5RVnftS
	qHsdMfSl3vPzsd
X-Received: by 2002:a05:622a:19a3:b0:4e8:b42c:e34e with SMTP id d75a77b69052e-4eb94836cfemr124817671cf.34.1761572121076;
        Mon, 27 Oct 2025 06:35:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEL/k6oJDubDmBz9RbFEPxNjPP3Xc56xvSbGxP94oLkFvGUc3VW74FMXxrNUcFhRspD7ZNgBw==
X-Received: by 2002:a05:622a:19a3:b0:4e8:b42c:e34e with SMTP id d75a77b69052e-4eb94836cfemr124816291cf.34.1761572119124;
        Mon, 27 Oct 2025 06:35:19 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f864aasm2290602e87.109.2025.10.27.06.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:35:18 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 15:35:17 +0200
Subject: [PATCH] drm/msm/dpu: drop dpu_hw_dsc_destroy() prototype
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-dpu-drop-dsc-destroy-v1-1-968128de4bf6@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIABR1/2gC/x3MMQ6DMAxA0asgz1gikSiEqyCGgF3wQiIbqiLE3
 Rt1fMP/NxirsMFQ3aD8EZO0F7i6gmWL+8ooVAy+8a1rfIeUTyRNGckWJLZD04XR+Vcbw9xTCFD
 SrPyW7387Ts/zA96xHQRmAAAA
X-Change-ID: 20251027-dpu-drop-dsc-destroy-a1265a9b8d99
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1422;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=fbnJXiQX68kkbm/D1iLlZF0GumHyj/1MlksgTx0Y+yQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBo/3UVn1nXqSc2ywmsIG7i7wkAE5ERKMYibym4+
 Os87bouN7eJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaP91FQAKCRCLPIo+Aiko
 1RpbB/9MsRHR+86Nxly0FzfgipVdlEGVe7l+h/K+TFN2Aumo33Zh4sKMYONm2WeQfWvNw7kF45k
 gGMevuD2li7T4CCn32odF2VxRIZDY+hfj5g8b1ElsR6aLJbodSNKxJ//U+gZncGOGIHX8I+PQKB
 BaaYYJzxFCAM6usI2PM/sOiZ0BT+uZnk1KR15EOe/pbkrj2FMjuMdNF3vqKOQSpZQYE2ExZNVU7
 SggI/ub8qWjmEoRuKbIeG82hUPzEWCoYFS3GWHKjBC7oe9AXenLemI9B15RjQBmpCijRdpAYOxE
 kVPwUY62EFaZEgiE1F7x+LzfgsMK/QpdzoHhffzuahsn5J/2
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=Zvzg6t7G c=1 sm=1 tr=0 ts=68ff751b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=s4j7PIB9qVrboWrP3l8A:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDEyNiBTYWx0ZWRfX7MKBxPRKmfBY
 9Xtrrb3dMDFPQPuYNDEB5UyOAP/2icxJkx+QOAXvdQH5ucFhUBbQ62QRdFLhO6GE0yb27Dk54xI
 ksmBFm0dFJCH30ZJYRkgN61+K9ZakTIzMQc2dYVbX3daOnh4m+n3WJhZhjarN8axzerB84i5fKZ
 zROKkdGihwLRMzMCgoTCgbHAKhkJ7fb9yiWIsjF24HRB7SHMCeQS2qw4BoSWtBPPmqutPCCJ8qN
 z8+pQyyqemURw7+k3SJRba/C85vm7ETp2ehD54FRy4GnLwBEoClMUyfZlm09uqGUrZF2i8AUi1a
 iwe58Bdu8YCydWcNEK9rbAYmM4lbNB8s7vZ3UsGYgCr+WF2Db9o/CM6/pItlmbeABCHUY4hkX2g
 bSLit5dJQWlLHZXK+YmUWoQ7DOwa9w==
X-Proofpoint-ORIG-GUID: CxwQc74Y_RLknFEWxYqSHkuqndhgGYWp
X-Proofpoint-GUID: CxwQc74Y_RLknFEWxYqSHkuqndhgGYWp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270126

The commit a106ed98af68 ("drm/msm/dpu: use devres-managed allocation for
HW blocks") dropped all dpu_hw_foo_destroy() functions, but the
prototype for dpu_hw_dsc_destroy() was omitted. Drop it now to clean up
the header.

Fixes: a106ed98af68 ("drm/msm/dpu: use devres-managed allocation for HW blocks")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h
index b7013c9822d23238eb5411a5e284bb072ecc3395..cc7cc6f6f7cda639b30bad7632c6e73aacedfcb8 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h
@@ -71,12 +71,6 @@ struct dpu_hw_dsc *dpu_hw_dsc_init_1_2(struct drm_device *dev,
 				       const struct dpu_dsc_cfg *cfg,
 				       void __iomem *addr);
 
-/**
- * dpu_hw_dsc_destroy - destroys dsc driver context
- * @dsc:   Pointer to dsc driver context returned by dpu_hw_dsc_init
- */
-void dpu_hw_dsc_destroy(struct dpu_hw_dsc *dsc);
-
 static inline struct dpu_hw_dsc *to_dpu_hw_dsc(struct dpu_hw_blk *hw)
 {
 	return container_of(hw, struct dpu_hw_dsc, base);

---
base-commit: fe45352cd106ae41b5ad3f0066c2e54dbb2dfd70
change-id: 20251027-dpu-drop-dsc-destroy-a1265a9b8d99

Best regards,
-- 
With best wishes
Dmitry


