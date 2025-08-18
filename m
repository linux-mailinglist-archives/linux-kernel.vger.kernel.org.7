Return-Path: <linux-kernel+bounces-773542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82657B2A178
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC3FC5E70A5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DF5321455;
	Mon, 18 Aug 2025 12:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dp1ivFds"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446BE320CB0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755519777; cv=none; b=K3ftYJGkvIm+/2EMU225rFoBmkNx/GivpWoyD+mxXzsGLBeeqfN8v2S+n4zHYAXpp3Gu4bjdbbxiL9WKmB5njpT3gzlfBnIBzVKJfoS0a9eH+1nGa+DX/5OUWcXyJ/7Lu8Op1oPKEvx+NAvSjDqBXbQxxqWTwud3BsNZspbVqoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755519777; c=relaxed/simple;
	bh=1QJy5HXp8RqtbvfH9QjSa54p4CKY+vOGD8v8UxtU1oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q/O/+SglZNWukX9e7XojUUYd4Zi5nt4GpW4wIaJWXAF1BsBF8oUMRIXSvlSwnuuEMGALbgn7UEeQB/BiwuU5ZUsRu7C6tGslhZ4uBfpbV95q///6vkLDges4aaLWuglFN6igC2uq0iHuuBs1pwBDZ8u76brlAc7qJpwiLYtjWos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dp1ivFds; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I7WiYW011483
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=HacHHhvAXRy
	jcyFHFFz7ZOUdKUy5an4FMJmyZykFyXY=; b=Dp1ivFdsODGuK33sbocSiOd/XTU
	VfdsOvOYNu8PXzANreC+N9dRKOkSlFkaihA5loHby8ykcrqxFlaPjTgbLp7stivc
	SwWRJ5HjflMThB8lkWcvqr7rnOOPl1ywZHGLDHDHsPWTChYwg6IARcaNN1p3/dF0
	REc5lDwfAuKQKaC9dKukmzS7WvabvnzY3n4Hmtcgm3SWQjvU3mMX2lX3tifpxiw0
	quGCH77UwDgdHMjItaGkza+uZym1MRdHlIR/Iyaze8IqHh665FrcfKbbEMGNPtyB
	dWD29Y8h6i73klupArg8StEEvlNmQAqYbRamirrbcKHbKq+slAyKw3tyngQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jjrfvm4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:22:55 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70ba7aa13c3so122502526d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 05:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755519774; x=1756124574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HacHHhvAXRyjcyFHFFz7ZOUdKUy5an4FMJmyZykFyXY=;
        b=i+T0s4dSDjvDXoA1QIDqx+e04td4JSFg10UTufAEkQl7ryXQ7Ml9Saa7jFlUbS6wRA
         1eCrJF3yGz4Vpm2jvHwRBZ8MwgFDcIuJIsArmLNP3sIrBT3QShDe51tF5U/pIlkbTwPP
         n9THGqiLDJhY8Gu3DXcCKPIvMSFN74lm6xzr5dSMm7DWk6Qk1mf7j+UxU/hYYFEZKhZT
         2iksUbiACWbC6z75QusQDf/ZBzYP+ufX2dk9nmxr7QKfS+Nf9TW3cfk2/dVX15on5HcQ
         s9D3W1BMeASRUVC/+O2L2WBqnvLuFVhyfdAbJ1oH431GJxk7/ASwcCwq9ZG6L+OEvvSk
         fN1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsE+kjt5K8btTDl4SaOy3Kz3XPgC3/O41JQ5/tClkrwCcvnT2Xa3de66ehZd6YLVGeMVM/xahUPSKEk5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYSL6DLKTNFYWu6KBY7ePYqADzb5dFMsi11C2L2p9gpY4eH16o
	zNokYxjALxSE9QByhFS72uN+fZGK6ReoY+HNsMfx7UJ8qB52+zxkKzHW1eMe+t4TbvK2bdqhCVF
	5BahdXrVfuhC8i0D07a3Eu1+TUj80OcC24XKRclSh8sPj250YLSEz4NUAPIJ2gM43vLQ=
X-Gm-Gg: ASbGncsbnDXTmSzQjLDZ5KHVPj3pCJjN5dEF0RT2QS7dNafuZNp0gURGdibaEl6cSUW
	EZkhxEz38JTg5YTWXZCnZ+rijRDa2q1yMUa5uDzwqFztYxUV7XtjZu3h+3V3gXro1DG/l+3SJpQ
	+yIE9X5eGPL+YNKOvKDtaLmqSMd0lozlXa6VFGdC4P0QjcXCbykdAdDzGp/7SwEekFz7Y3qw+tl
	Zk+SEGNVjCjj7IhFKnlumIEMG9Mk4FqAx1GfVzkIbHEA4+nnd6TcHUiAmRcZtPbHv86ZpUo/0Ap
	bY8l6z6eehcoYq9ORHdWbt4rN9AtVthmCQz6RUXrB9Avt50nELIRxA==
X-Received: by 2002:a05:6214:29e9:b0:709:3ab5:b935 with SMTP id 6a1803df08f44-70bb0589299mr110356306d6.3.1755519774050;
        Mon, 18 Aug 2025 05:22:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCkyZbh90HaFr43NwnI2Xy8gRlPpwFreREm5ORfx3M9PZ9NBRHduIuQl2W2+h3ZKXM+Gd7qQ==
X-Received: by 2002:a05:6214:29e9:b0:709:3ab5:b935 with SMTP id 6a1803df08f44-70bb0589299mr110355616d6.3.1755519773342;
        Mon, 18 Aug 2025 05:22:53 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb653f657fsm12601563f8f.29.2025.08.18.05.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 05:22:52 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v2 4/6] ASoC: qcom: audioreach: fix typos in I2S_INTF_TYPE
Date: Mon, 18 Aug 2025 13:22:38 +0100
Message-ID: <20250818122240.1223535-5-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250818122240.1223535-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250818122240.1223535-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: TqyrK0BfXFMamUw_YrWStM_e1bDl8vFi
X-Authority-Analysis: v=2.4 cv=YrsPR5YX c=1 sm=1 tr=0 ts=68a31b1f cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=NygpE-9J13evsolF8bcA:9
 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzOSBTYWx0ZWRfXx5J7vRkdqSUn
 IXOCYw1XdKg/xRqUBEyu8/oqL0Ad2jSfOSEH2qdJ8Za+kEnBsgT9YVx9ExzNd9s5KQ7w6/a/m+L
 bfXZNGxUnfcu24FCsaqPOqgcQkz6uSVF4Y+BtSNguDC0J7m0Yu0s3xqNvlQdoDPAD892UxMrMe1
 dUgkrX3pzLhz3y6ve16UsJBy8s+iDlAJdNZagvC95Xq6b44pNiAsOWR1KAPd8Yy16dORml9CXc3
 yXGRxUQAelqoHGXF3x6N2JWGNIZ/a7dsK7PULppIuCFzdZhmoNfypt/BmixTwFLWm7rKE1VNAzs
 mFrygVfL3+a5yYedZGedSEnevCV/W9h027/fvjg8Nq3E+akXL2CTfLqjP/PT5QR2nNiJ+xLQOuN
 16383XjH
X-Proofpoint-ORIG-GUID: TqyrK0BfXFMamUw_YrWStM_e1bDl8vFi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160039

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

Fix spelling mistakes in I2S_INTF_TYPE defines.

Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/audioreach.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
index 617bda051cf8..512886042224 100644
--- a/sound/soc/qcom/qdsp6/audioreach.h
+++ b/sound/soc/qcom/qdsp6/audioreach.h
@@ -27,6 +27,7 @@ struct q6apm_graph;
 #define MODULE_ID_DATA_LOGGING		0x0700101A
 #define MODULE_ID_AAC_DEC		0x0700101F
 #define MODULE_ID_FLAC_DEC		0x0700102F
+#define MODULE_ID_SMECNS_V2		0x07001031
 #define MODULE_ID_MP3_DECODE		0x0700103B
 #define MODULE_ID_GAPLESS		0x0700104D
 #define MODULE_ID_DISPLAY_PORT_SINK	0x07001069
@@ -462,8 +463,8 @@ struct param_id_i2s_intf_cfg {
 } __packed;
 
 #define I2S_INTF_TYPE_PRIMARY		0
-#define I2S_INTF_TYPE_SECOINDARY	1
-#define I2S_INTF_TYPE_TERTINARY		2
+#define I2S_INTF_TYPE_SECONDARY		1
+#define I2S_INTF_TYPE_TERTIARY		2
 #define I2S_INTF_TYPE_QUATERNARY	3
 #define I2S_INTF_TYPE_QUINARY		4
 #define I2S_SD0				1
-- 
2.50.0


