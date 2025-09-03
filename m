Return-Path: <linux-kernel+bounces-798324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3237B41C50
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7247D1A87A23
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654EB2F99A8;
	Wed,  3 Sep 2025 10:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e6U74QPb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C744E2F6192
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 10:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756896724; cv=none; b=WnSMbHvEMTCF/kTneWzgvX9TR5b6yRTFqzKVSu+m4XH116/UF3YpsRVZYseye1McCd3BSrW/Crs4WDFH0bNFKjnfuNLvHzfiJXko7QAORXTYr6th/DHWAmV4tnHDZNbJlW84jzE9I/ErAvb6V+17D3B/2RI0xISW1Uxk8eVe0qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756896724; c=relaxed/simple;
	bh=AgKTuTphksgFdjbRBscbGOKdDdsPzucjkQBsXfU1L0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=biabY5WVL/fazMlf3QK2992uVfOKoT1T6gEGoYD0N2c3wSN8f1iI4iYZNtsDv193MUB02enc8MOqFonv8HHXPUiKoIPmksEKy9W1kiiWyTnP4EyTioURL3RsXo7xOOo2GdCDayXXKoFgdKdx0v9UkOeF9iar+SvaHJbLQWOBRtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e6U74QPb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583AWEYg021299
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 10:52:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OwmE1FNHyvfTAhAmN4j1rp824OtCLZj2GOAqHhiwg4A=; b=e6U74QPb/N7zGnP6
	s+sxCMTohZzHnMvhKBWCdKwxmvW/SDpeKZGnK4VO5JfFiIfQa2YleN9/hqDoPtLl
	0B5SsETXDzYGzN+nSMmC53mJWDK9AEh7a6PCezm6mNT+ix3zDu5NFRROVuYEBsTY
	0DO2KD7bsPiLae0KI7Kq02d+Hnxn41JX5BZUJ+dCVaW9JTI4MO3duHeD3k3FADnY
	JkoMZ7/uiI9aYBApmN8aG9N32PUuLx7W2Y2/xX0sw4JQ5z2x/Sq/yCk75TvSQFXv
	Tv+Bvh9MlvzzLdqYt9JFuK5Ek7UtX0zXywJG/xz1TvRaKa/z1DsmLNO/B1SWBqvn
	CMlyBQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8s3dxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 10:52:02 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e870623cdaso1181043185a.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 03:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756896721; x=1757501521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OwmE1FNHyvfTAhAmN4j1rp824OtCLZj2GOAqHhiwg4A=;
        b=b+j1OID2fiJWiQkx3bQubS828dvDtEyc9TvKWpCQrkNNOZNqEU13iuKJP3srOGeox6
         Y+GL3KaloDg7KxQ55ZfUWxu5+FvOsf7NBoaDsPRuR/OteDNLhlYsTE3X5+aukm2AJWAU
         LAeK2Mm08KkHt+PyAJ/QaoHfMfYkgPq4VE2heZTnLcvdNjJ6g8bTEQS9qinaT8SOKLU/
         CRo4j9zt/vcbulepUwC2l1dpLdAGg5lLE0eagFpcXAbP0RtK1rhvBmYYL74ai6VYgQ96
         QwyV5zHW+N4sfE1eQdpJebdQLdVZNeB5+//6urr4wON187gTUtyFx6ELLjpaMUg4ukCf
         gp+A==
X-Forwarded-Encrypted: i=1; AJvYcCWuxnIO1U06eswufU14KPLJMBQgPcaiOmsytBUKQmGVHy1YWAXIc7r4bwia83VJvYCsWx82lnHSn7U8rQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMq8VPkdN5B4EDayn7LqFe+mlOWmTsyTlGGb5R7BcLVQpMWlfh
	30nVS0JxlVh59IRvZaVz7aimcBn8Gye3hQRLMB7skweTQNWa92EV1aurZAy92qzXrepRfLoMAC/
	bPOmqnss35EqYr9HooTw07uMNhojGWU5/QhthrifYaDNXyO7wkMQzM/E1iuwQJqOWaMo=
X-Gm-Gg: ASbGncsTOaqB9t+UtOG0rGNyJObQNpz6DfYa9KqVtaPU4aaf/8hKcBfrXjSRTUzZCJe
	6QPdTOGtXHp7L41o5UxSa3zu5GdfkNp2lV2TdZYD81aeYM/Ot5cmdd8oCmXsYv4ZEio/nhqt/cg
	sKb1fKaKfNdFzcHSwp4ljLiBGvwRQu0vADa/LVrctM3y0izge/yE23BGyflaN8HM/2nMfPixVqi
	NOpiC579NoGyX6jR92AQqZp5nK+5kNSMb8p6uRXa+nSyCxVwFv13ulD+j5oW6xPwCzIEvWd6Qbq
	fPu7FusKs22R0mVUczpT68lE3LiUF+BbWdzqAHiACmcByNqFL7J/qMdswx6gBhTUNgnVvNSvnw5
	Uyuz7wffw2CAKGif0kaRIOoPdpIu7mUZyTIS00qZmgb4NSUmj+Na+
X-Received: by 2002:a05:6214:1245:b0:704:f7d8:7030 with SMTP id 6a1803df08f44-70fac8e562fmr189976646d6.50.1756896720621;
        Wed, 03 Sep 2025 03:52:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz3YLnuQheLnctM3oOo4lxrx9NLlPPW3v2YzHyl9FZ5QeuhI/S48AL9YBg7OeJCK0FwoFezQ==
X-Received: by 2002:a05:6214:1245:b0:704:f7d8:7030 with SMTP id 6a1803df08f44-70fac8e562fmr189976356d6.50.1756896720171;
        Wed, 03 Sep 2025 03:52:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f5032df6sm9373431fa.39.2025.09.03.03.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 03:51:59 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 13:51:52 +0300
Subject: [PATCH v2 4/4] drm/msm/mdp4: use msm_kms_init_vm() instead of
 duplicating it
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-msm-no-iommu-v2-4-993016250104@oss.qualcomm.com>
References: <20250903-msm-no-iommu-v2-0-993016250104@oss.qualcomm.com>
In-Reply-To: <20250903-msm-no-iommu-v2-0-993016250104@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Antonino Maniscalco <antomani103@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5112;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=AgKTuTphksgFdjbRBscbGOKdDdsPzucjkQBsXfU1L0U=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBouB3Hyns3bJmUAeJWzCRLgAN6ruv2VcZVu6b1W
 St6rwyfI9mJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaLgdxwAKCRCLPIo+Aiko
 1ZmICACBatdifNHq+RNnmtvLJqxuWiOBZ0gmol+G/G31x1B9tK7hwPbFI/ZneQuj9aQuFtTQt68
 r+Is4bOuwuS53H25Zj9SIWKWFbUgwvg23l117x+Se9C8FYpg/Vi8y9aYRzMYNfrHamGQcqxH8Qp
 XMyRMpe2S9c+V1fRmxXb/4wlAceycYENzRnheqQu8mqxmDPDxA5Y85trDxynmALGTXpvoAOtSRf
 GCPGbkOUUM4fDSbNtVJW1sH21f5S1BELVF4oVChcnBrV1etTzBO82HkD5YpzdmNrOC3WDe6akkH
 wp6m+DF960c+UGTRu5NK+u5kbu09PuQjrEtaBqJPKMBNoGPU
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX3DKMhLv6K8Cm
 tUy9gNaM9vOghSq3wBdoXLvFC9eOImy83tWnKLQWuWFw8tAksxhZNg9xNFAVNVzeBAxTtQyQSjS
 TtuKIVwm/ND1vjKdaZ8KuVEaxEZmdwYckdiLwm7S6v9MoLFeXo0VybT0cWcaJEKg2K7EICO1c8P
 LK4HDwpGC9GLq2rvvgar2GiVGM3qsMm9WbMrQh3mF3kjmZENxXkbtR8S4zKwVcwo7BN3zejHNpy
 LEjrAeu/hSMm6pLtYg2RY8SY9c54k6i8pMEdGUbrx5VpPFq1vP2LFzt6o2Wv8EDVMk1JP1qntav
 6yg9E8K16bHHvKswX3SyKrwlchBMiHEGhDUwch9Vm575YxhZGLj0m1ho3WwdbtyLXv7hgjovCck
 S1qXB+sS
X-Proofpoint-GUID: 3B3l3Xv_mtqgKN7m8cuhrj2QU3YsfpYd
X-Proofpoint-ORIG-GUID: 3B3l3Xv_mtqgKN7m8cuhrj2QU3YsfpYd
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b81dd2 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=gwGsY3v9svKR4hS8clgA:9
 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

Use the msm_kms_init_vm() function to allocate memory manager instead of
hand-coding a copy of it. Although MDP4 platforms don't have MDSS
device, it's still safe to use the function as all MDP4 devices have
IOMMU and the parent of the MDP4 is the root SoC device.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c  |  2 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c | 27 ++++-----------------------
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c |  2 +-
 drivers/gpu/drm/msm/msm_drv.h            |  2 +-
 drivers/gpu/drm/msm/msm_kms.c            |  5 ++---
 5 files changed, 9 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index a306077647c317af9345eeff13082230906b5767..4e5a8ecd31f7570beb45fd1629a131e70aaefea8 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1110,7 +1110,7 @@ static int _dpu_kms_mmu_init(struct dpu_kms *dpu_kms)
 {
 	struct drm_gpuvm *vm;
 
-	vm = msm_kms_init_vm(dpu_kms->dev);
+	vm = msm_kms_init_vm(dpu_kms->dev, dpu_kms->dev->dev->parent);
 	if (IS_ERR(vm))
 		return PTR_ERR(vm);
 
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
index 66bfa96965be275270751cba770521cfde2a7004..1d2a1e4f6ce7d02516b9497a494bb1e46297f55a 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
@@ -391,11 +391,9 @@ static void read_mdp_hw_revision(struct mdp4_kms *mdp4_kms,
 
 static int mdp4_kms_init(struct drm_device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev->dev);
 	struct msm_drm_private *priv = dev->dev_private;
 	struct mdp4_kms *mdp4_kms = to_mdp4_kms(to_mdp_kms(priv->kms));
 	struct msm_kms *kms = NULL;
-	struct msm_mmu *mmu;
 	struct drm_gpuvm *vm;
 	int ret;
 	u32 major, minor;
@@ -458,30 +456,13 @@ static int mdp4_kms_init(struct drm_device *dev)
 	mdp4_disable(mdp4_kms);
 	mdelay(16);
 
-	if (!device_iommu_mapped(&pdev->dev)) {
-		DRM_DEV_INFO(dev->dev, "no IOMMU, bailing out\n");
-		ret = -ENODEV;
+	vm = msm_kms_init_vm(mdp4_kms->dev, NULL);
+	if (IS_ERR(vm)) {
+		ret = PTR_ERR(vm);
 		goto fail;
 	}
 
-	mmu = msm_iommu_new(&pdev->dev, 0);
-	if (IS_ERR(mmu)) {
-		ret = PTR_ERR(mmu);
-		goto fail;
-	} else {
-		vm  = msm_gem_vm_create(dev, mmu, "mdp4",
-					0x1000, 0x100000000 - 0x1000,
-					true);
-
-		if (IS_ERR(vm)) {
-			if (!IS_ERR(mmu))
-				mmu->funcs->destroy(mmu);
-			ret = PTR_ERR(vm);
-			goto fail;
-		}
-
-		kms->vm = vm;
-	}
+	kms->vm = vm;
 
 	ret = modeset_init(mdp4_kms);
 	if (ret) {
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
index 5b6ca8dd929e1870b7228af93da03886524f5f20..61edf6864092664afe474cc8d1fd097ca495ebb8 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -534,7 +534,7 @@ static int mdp5_kms_init(struct drm_device *dev)
 	}
 	mdelay(16);
 
-	vm = msm_kms_init_vm(mdp5_kms->dev);
+	vm = msm_kms_init_vm(mdp5_kms->dev, pdev->dev.parent);
 	if (IS_ERR(vm)) {
 		ret = PTR_ERR(vm);
 		goto fail;
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 9875ca62e9adb12dca9bcc74e2825b0364372a54..f4c20dc91cc600d8ab72bce002cbe6b9fdf9a720 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -229,7 +229,7 @@ void msm_crtc_disable_vblank(struct drm_crtc *crtc);
 int msm_register_mmu(struct drm_device *dev, struct msm_mmu *mmu);
 void msm_unregister_mmu(struct drm_device *dev, struct msm_mmu *mmu);
 
-struct drm_gpuvm *msm_kms_init_vm(struct drm_device *dev);
+struct drm_gpuvm *msm_kms_init_vm(struct drm_device *dev, struct device *mdss_dev);
 bool msm_use_mmu(struct drm_device *dev);
 
 int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
index 725367157d90e45854cb8a22ea25a3fa3bb218be..6e5e94f5c9a7474d014e73b0b7bd06a94939ed1e 100644
--- a/drivers/gpu/drm/msm/msm_kms.c
+++ b/drivers/gpu/drm/msm/msm_kms.c
@@ -177,12 +177,11 @@ static int msm_kms_fault_handler(void *arg, unsigned long iova, int flags, void
 	return -ENOSYS;
 }
 
-struct drm_gpuvm *msm_kms_init_vm(struct drm_device *dev)
+struct drm_gpuvm *msm_kms_init_vm(struct drm_device *dev, struct device *mdss_dev)
 {
 	struct drm_gpuvm *vm;
 	struct msm_mmu *mmu;
 	struct device *mdp_dev = dev->dev;
-	struct device *mdss_dev = mdp_dev->parent;
 	struct msm_drm_private *priv = dev->dev_private;
 	struct msm_kms *kms = priv->kms;
 	struct device *iommu_dev;
@@ -193,7 +192,7 @@ struct drm_gpuvm *msm_kms_init_vm(struct drm_device *dev)
 	 */
 	if (device_iommu_mapped(mdp_dev))
 		iommu_dev = mdp_dev;
-	else if (device_iommu_mapped(mdss_dev))
+	else if (mdss_dev && device_iommu_mapped(mdss_dev))
 		iommu_dev = mdss_dev;
 	else {
 		drm_info(dev, "no IOMMU, bailing out\n");

-- 
2.47.2


