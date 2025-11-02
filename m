Return-Path: <linux-kernel+bounces-881633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F3CC289A1
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 04:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3C6188F35D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 03:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BAB238159;
	Sun,  2 Nov 2025 03:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CLdrFoc6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DeGD1chO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1193224893
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 03:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762054835; cv=none; b=VuBX19tR0JLnL3WASM2bMf3J71wwT1Lu2yOw1kiz5/l63hQ/baw9KjIl3P7nV8Qu36EL48ejC66EwWL+bXak5lDChq0QOoR+xafrwHR9p1Onpq1dw2LZtiLQcrC9sFSuOZWrx1kf4yQ5WAjBrBZ5Tuyfsj/eXgRykEH/hryzT1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762054835; c=relaxed/simple;
	bh=tsTTP88YqQQw2qNCj/kySq4M0ki8akBPEdfHNXPcJ9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=k9TuSjnesCZO6sTHCNrEpUP/aoi8KrwsEVamOLTbZ9MWG5kyaGrHitj8fuiYxYUb+WDoDXndPg65D1VE0jmEv7z5AOFNuG3N/5quLSCsy+M7MsU6tJ3mBaZeudv1BlS8RUA7EMINwYHQfnDJ2qO016cxadtIslZdPZaskMKLbno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CLdrFoc6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DeGD1chO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A1MaNbp2665257
	for <linux-kernel@vger.kernel.org>; Sun, 2 Nov 2025 03:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=hy9CGwxUFV2jhewlnGeGKH
	PswSddzu4TDZNw7XBAfsw=; b=CLdrFoc6rX2dUdrMCRKv+SldbSrUfU7RxJ7bhq
	PbjdDXOukC5/XDZ8UP46VtMiqfz/YwiayoAXHDPje9zxH9ARXao9tUPJaKQ58Ehu
	3hgutkWrGnqOnOst6uwqNi8XW+Bu1rlnotLWhpfwIQWarfqveCwvRF+86sRjX3aj
	BeepKm43O5bVQGu7na53Q3SyrMYIK+Wn0JYGv/RN0RxxTy1hmu2fPZ/+p4H/j38+
	rsHtbOBytvzG/mBIMa9eQfonOw9jLPEvVwJAN53VPtXxwic3AXx6ow5NEHvpDsOY
	/8/cxcdRahZQKVmLyOsVePDykeuVORxSta8vWKj9DFp5TP2w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a5ae31jcg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 03:40:31 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-277f0ea6ee6so35756005ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 20:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762054831; x=1762659631; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hy9CGwxUFV2jhewlnGeGKHPswSddzu4TDZNw7XBAfsw=;
        b=DeGD1chOPhTGL9eXsog1x62aGJGhz0LEoaNXPFpmL5bcc5mdHMUA6i442zumVgzCxI
         Va70t2wxQSAxrcKN/w1m+tHwvGKz/MsOuQc82abt/fRkVufhjIQSEwhtJiR8SVwUOPlQ
         PtqgMRbJ5StXZLLj0V2kDMhWiV8MqzVY5U2PeB3MAfHOQeXiHEfezm2W08C2gbaugWvc
         7okkmONqKUQDXWrz0xJ4NChFWRlNcUIYqRVcP2zbIjCTUKlyagJLhOwEprbTv7Nggi82
         IGOzzerWMrgl3D62oeWKKvrV9vaIG825G6R/iuVpPIj3BWly4gD+ULK/WICwiDpuK+pT
         DBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762054831; x=1762659631;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hy9CGwxUFV2jhewlnGeGKHPswSddzu4TDZNw7XBAfsw=;
        b=E2VTtYadrAeVm2YZl1XI6BSglXachGDwLU8V3rauUeFSE0y7IXbmRPCTeWrA/GIxkU
         BjHOuaOClkYZpSkteUgQ8uT8cGMv+aoFVcWAXlAssKsEQPCabzgeMdNr+hfwzZ9qiOpE
         fs44s01ys9bGclGD1YZ7HgL5I8HwWbX8KTh3m66SLOiexA8A/9ySWbzYyylB2KO/O3gp
         P66JpKkuyKfkrphnRfk9gI1aK4rOR78Z5Nx1E6FJtPRQ0HX5NdDSOufNVLwB608IZHXL
         W3d2H4Ex/0gHn9rN4bmQUBPIRAf1f7HpEa839J01B8TTGU5R2rTzoBntFztMopLnkJj7
         O5LA==
X-Forwarded-Encrypted: i=1; AJvYcCXO/qdKwt/arJ650mpauJcWu9tymX51NTsNNjgDDczjSBh+gyY3yr2tkB25VRE9BA1t1dALxK+q3NXGBIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUtDUTc6n1evDTt6/OBdNRA9SQ9kcSrsnzm0mj3F/eYVIrEDcb
	5JUygeXPCSIQZK6klikbWlcmhxIzQjhOpuO6ZRi+XAemL1TWM4PH5leFB0ZiwErnzfK5tRhj19J
	B8j0+blXgvqlCggARzJG68ev5R+QsbSWGz+66G1xg8Kx2Ge70v/CxN5mhdDxfHy2eaTY5qArj+i
	8=
X-Gm-Gg: ASbGncsMkQTwX9ego/mzUMapQfRfsL77cf0kllrdXQ7XXbBZpBW+fs5GhWREQgX/Pa5
	hN9krWShGmfOEFXIV1sSt4bI/irLvkTStJ0ePOFDIY8RdJYCyiD7A8kXK1lXbtu0nl3/JTHjKdC
	D7xpSRd8SpwEhTF4Li37E4eIvOJOXphNYt7XM8tWmUigXxfC+thGAo209SgT1fh1NmmUhsfDUcc
	m2g+7iDPLpnRanRgHD6KX2sITWHcEz8W1Ivo0pObQnTOYNBZhI53bt0dIfmYXtYAdVeGeWkTdHD
	dwD8IAFrK08FANwCRkopH9wqSlKYNzFcFb/EFPymrHdXgzCvTDKzYWrDFujwJkW6WJQfKzzcSee
	VfP3hG6z3YJCyqyzLq6RQm/gtPmpaM6Qto9NK
X-Received: by 2002:a17:902:da88:b0:295:5805:b380 with SMTP id d9443c01a7336-2955805b770mr45636335ad.49.1762054830799;
        Sat, 01 Nov 2025 20:40:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn6sLOMnqKd4YQV6ffKNfc4XqFYxeONj5fp5ikFI1eo+sp04UEXUS7roUXZh8dPk87Wj6lpA==
X-Received: by 2002:a17:902:da88:b0:295:5805:b380 with SMTP id d9443c01a7336-2955805b770mr45636085ad.49.1762054830276;
        Sat, 01 Nov 2025 20:40:30 -0700 (PDT)
Received: from hu-dikshita-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29526871023sm71818025ad.13.2025.11.01.20.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 20:40:29 -0700 (PDT)
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Date: Sun, 02 Nov 2025 09:10:19 +0530
Subject: [PATCH] media: iris: remove v4l2_m2m_ioctl_{de,en}coder_cmd API
 usage during STOP handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251102-iris-drain-fix-v1-1-7f88d187fb48@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAKLSBmkC/x2MQQqAIBAAvxJ7bsE1LOor0UFyrb1YrBCB+Pek4
 wzMFMiswhmWroDyI1mu1ID6DvbTp4NRQmOwxjoyA6GoZAzqJWGUFycXw+wME40OWnQrN/0P163
 WD+9DAwpgAAAA
X-Change-ID: 20251031-iris-drain-fix-75fd950e1165
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762054826; l=2368;
 i=dikshita.agarwal@oss.qualcomm.com; s=20240917; h=from:subject:message-id;
 bh=tsTTP88YqQQw2qNCj/kySq4M0ki8akBPEdfHNXPcJ9M=;
 b=Kc5rdsfHPSXdaj/NBj2Obv4p52uiMbY7Lmx5qo8Yp45X2l/+q2BxT5isrvQntQTZ1VlHPMQXr
 W7w4VYdqes+C7yiUcPZiVeYn+HelMrIEYwNU7WFA/Ji92LdNK9L3Isf
X-Developer-Key: i=dikshita.agarwal@oss.qualcomm.com; a=ed25519;
 pk=EEvKY6Ar1OI5SWf44FJ1Ebo1KuQEVbbf5UNPO+UHVhM=
X-Proofpoint-ORIG-GUID: npUc1wlkk3N7A9sKZA281a8V75QcC-GD
X-Proofpoint-GUID: npUc1wlkk3N7A9sKZA281a8V75QcC-GD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAyMDAzMCBTYWx0ZWRfX8AuaYPyUxqmo
 eXLaAyqvfwfTotJ0HmnOLBg1U83NPcM4bNNCYh2aPRjup5dSSt29bip9Da1X6RyXcdm6lWQgYt8
 pEQXuwySh+f/mS3yH0bc68P1IVqxabuJqSJjoSsW8KEb6RhkwHY0dStf5WNc6U7GleIiHUHVBCg
 4TzNsY6MwBMxrXR3EPQBrqjVr1KSXCWOpsdRl6VC7pAd9+ZwiDcL+Ecy3gKRFjQYc95CM80VY3c
 gtX5qRdwvyg8AAjewCOwr97TAlL9cc9eaTCrzD4GrL0NOA9Ldz1IHN42P+srUA+M61JpNQxpg2Y
 By/FstPu5rd2l0LLdUGglzsoDfe9rqncmbH+APi8oCh0l/ziBGnXveIXO7SBW7WYS3bLlthJn63
 K8dnYPnKY531kcxrapt8593dr30tLg==
X-Authority-Analysis: v=2.4 cv=CfUFJbrl c=1 sm=1 tr=0 ts=6906d2af cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=YXM6clFYWdcNeUECVfIA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511020030

Currently v4l2_m2m_ioctl_{de,enc}coder_cmd is being invoked during STOP
command handling. However, this is not required as the iris driver has
its own drain and stop handling mechanism in place.

Using the m2m command API in this context leads to incorrect behavior,
where the LAST flag is prematurely attached to a capture buffer,
when there are no buffers in m2m source queue. But, in this scenario
even though the source buffers are returned to client, hardware might
still need to process the pending capture buffers.

Attaching LAST flag prematurely can result in the capture buffer being
removed from the destination queue before the hardware has finished
processing it, causing issues when the buffer is eventually returned by
the hardware.

To prevent this, remove the m2m API usage in stop handling.

Fixes: d09100763bed ("media: iris: add support for drain sequence")
Fixes: 75db90ae067d ("media: iris: Add support for drain sequence in encoder video device")
Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_vidc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vidc.c b/drivers/media/platform/qcom/iris/iris_vidc.c
index d38d0f6961cd5cb9929e2aecbec7353dcc2d4a7d..07682400de690ad29c86ab2798beea6f09fdd049 100644
--- a/drivers/media/platform/qcom/iris/iris_vidc.c
+++ b/drivers/media/platform/qcom/iris/iris_vidc.c
@@ -572,9 +572,10 @@ static int iris_dec_cmd(struct file *filp, void *fh,
 
 	mutex_lock(&inst->lock);
 
-	ret = v4l2_m2m_ioctl_decoder_cmd(filp, fh, dec);
-	if (ret)
+	if (dec->cmd != V4L2_DEC_CMD_STOP && dec->cmd != V4L2_DEC_CMD_START) {
+		ret = -EINVAL;
 		goto unlock;
+	}
 
 	if (inst->state == IRIS_INST_DEINIT)
 		goto unlock;
@@ -605,9 +606,10 @@ static int iris_enc_cmd(struct file *filp, void *fh,
 
 	mutex_lock(&inst->lock);
 
-	ret = v4l2_m2m_ioctl_encoder_cmd(filp, fh, enc);
-	if (ret)
+	if (enc->cmd != V4L2_ENC_CMD_STOP && enc->cmd != V4L2_ENC_CMD_START) {
+		ret = -EINVAL;
 		goto unlock;
+	}
 
 	if (inst->state == IRIS_INST_DEINIT)
 		goto unlock;

---
base-commit: 163917839c0eea3bdfe3620f27f617a55fd76302
change-id: 20251031-iris-drain-fix-75fd950e1165

Best regards,
-- 
Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>


