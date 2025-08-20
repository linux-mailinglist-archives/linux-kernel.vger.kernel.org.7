Return-Path: <linux-kernel+bounces-777388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C698DB2D8DA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEABB5E0920
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE882E3393;
	Wed, 20 Aug 2025 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ABGIdaKn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CE72E3371
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755682634; cv=none; b=KxIOjmG18grtNjpQFmNfJZ1fw4Ggt3A5Hdn0sIspUmaVLGlQsP99ALLUKddSv2MeGIG/sPGiHVWAcoeW0tFET5duUIzBeRoTpCva4jQESYHMDlYg/LQSNTCcsoccce8XCspuE0u6vuAj6/IZkZCk2NQlHwThrz7CZQ0O3OYBpoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755682634; c=relaxed/simple;
	bh=TLXmf7CMeiTC8Z6DwRlj4bLrhrN7dz3DcuKvJOyLkT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oGlhCYOvsal12N1SHl4m+59fUPik+lrPte+C7tSyis0/Eqsr+3M4gnooaMtmu2mOGBMkphklF+ZGcNArKBXFR+XMzSWRIoQzgtX5I39rQ2Zs1OSaANkloLPzQ/zs0jwKxZWtTM20Whn8LQWyDMHDqgnBLCQ/qfFh4rUj7o+dObA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ABGIdaKn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1odCF025217
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:37:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HXCMXoEHSzzPkbhgvQAI0rYXROuTcAwPw7wz3hIiRiE=; b=ABGIdaKnG4GHl2d8
	vhzi1spaRkB4HIzlUvaFsFgyz+Ych12at+Y94WxbqxngGfSBcAiBlAEkSSLZQ+yK
	3Q778BjukosfUQutkunRWvB1rKdkhTiEvuD0wK71oudArQ/H2V3anmvFA+HTvFmD
	hrCIbnHWyY2OJyDEesWXDDIHM6HTqs0wIbhgDh4Yn+W5VgJ289C+bUIXgY4E9wnh
	XyJ+0ufZB1A+adwMhhSzGTpMXproXEg2I+IAZ+WdLsS18QIOWKbnmqUJiQy9Vcbd
	VLfOYbJ6tJVF3xdp1iJYLaZcxbpvILupixWDSaqeFRJCMDoOzM0YBmLKtCd+l3fc
	k8ozVg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52a982b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:37:11 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b47643b96ccso122789a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 02:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755682631; x=1756287431;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXCMXoEHSzzPkbhgvQAI0rYXROuTcAwPw7wz3hIiRiE=;
        b=Q0Oa0lMSAhDTb5JpEBKihoDKg+mZp6XwXMOrVk3jUZ/VCYYhmnqvIP+4eo0eJ1EAIv
         +cG94cdodLpaQJMhfDZ0IqnIM+mo8fjf+Eoj0uKa3QnOVAATDrKWVmGE3dkyvsFWIxaY
         e89QIkYfmrPPauQanrhXKOf22oT9TBgw+XyHuIOVHyI/K3+lEGnuDC5SkTDIpaYq/boO
         /gOm8c0XCj6U3KK+/GvyD1yBcegqwYDQTdLXuoj2AaZLX95WwrSOF/bRx/K3aohcfzn+
         pybfwWfRlMhSE+binyQNYgyWQ7qlK2W//6ZE9ZaEA8gNZHyy0ugjKZusUZeyRKxPmfTa
         RkEg==
X-Forwarded-Encrypted: i=1; AJvYcCXVO5Tj9X6cNY2CVx/JiUCFuhsgiw/PHi4SL2jgJEfuDuNa2bH67ECSQ6yXIanYP2I4P0LfFCMftEUwqWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ff+AYMXuFmBkqF1VcWWRpZ9q5B4Em7KuZ07QI118K9daz6ld
	e8ZJva/CnoQdCohl2h+je53u9tVpwRRjVYGLwSi4XrduNrGc9tw+IvU+IQqo0a5hRHBZtnXcThA
	+EEBLbYmNWuc7D1h85ZzVgmS4/NSJcF2S+eoJofnaO/20Y7FLuid+LVCwBG0DQQGUZ+0=
X-Gm-Gg: ASbGncuyfsJeummCr/wxXB1m38Sk8iOhdgKovuFIp4c2p2r/JPE8A6mGrbZ3572ivqd
	wK13rw8k9ZJMknyKHGhgybS3mMSjnCByVaIPqJkSa1ZbCXaJ5c6EFh4lEmTqHg/ux49tSq6yd0P
	SltQobT6G8oCnWKOLiixfWVEqF9VXoXvVuYcSazf7gDsogvmXkDkRvD83uBJ8Tg6K5Erk+w9idN
	sHz49dbdqgByA4kmP5BnPQb/vWI2bA1xLvHtHZyuIWrlkm/uFg7vtObq3A5H8Kt0lLpUZcEko3x
	r3x4QY5M7t3XzxIVwykBBKGvbnDyfHuXB7zktRNjP/8gkSHkIlr/FYQOKccgojMbQUidnt+iev3
	Osb1MZ665K6swICbBtNsE8ZMYa7+vbTqDFg0v+nAedG2Gr1+/4joWa4tV
X-Received: by 2002:a17:903:1c7:b0:240:71db:fd0 with SMTP id d9443c01a7336-245ef25bccemr12961285ad.8.1755682630836;
        Wed, 20 Aug 2025 02:37:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9n+Y8mt33jA5ru0MGM6k0vMA0mnbToTLiA24zruGDf9ewnDEOM2CMV/Nmr32brvdMMc9ajg==
X-Received: by 2002:a17:903:1c7:b0:240:71db:fd0 with SMTP id d9443c01a7336-245ef25bccemr12960945ad.8.1755682630363;
        Wed, 20 Aug 2025 02:37:10 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4ec100sm20954305ad.116.2025.08.20.02.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 02:37:10 -0700 (PDT)
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 17:34:54 +0800
Subject: [PATCH v3 12/14] phy: qcom: qmp-usbc: Add QCS615 DP PHY compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-add-displayport-support-for-qcs615-platform-v3-12-a43bd25ec39c@oss.qualcomm.com>
References: <20250820-add-displayport-support-for-qcs615-platform-v3-0-a43bd25ec39c@oss.qualcomm.com>
In-Reply-To: <20250820-add-displayport-support-for-qcs615-platform-v3-0-a43bd25ec39c@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        quic_lliu6@quicinc.com, Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755682521; l=1063;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=TLXmf7CMeiTC8Z6DwRlj4bLrhrN7dz3DcuKvJOyLkT0=;
 b=tYrwmSqZ7+5gVwIwT7A3TBOs5j5jdX94tAHdFyRh09FRVFwfiHNuGNctJEVjLCL+44jGzT5KO
 VMggrWG6o4GB2Lt8oNsfF0Hw4vF+8wqfhzzMSaHydvX/vBS/00DQKsZ
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Proofpoint-ORIG-GUID: w7rN0HtXumrmiJEO5g7pD-FBYVm3A8dG
X-Authority-Analysis: v=2.4 cv=B83gEOtM c=1 sm=1 tr=0 ts=68a59747 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=3lua1KrjtZAvismTP1MA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: w7rN0HtXumrmiJEO5g7pD-FBYVm3A8dG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX9W2gsY6OsIhM
 OdvH9+0k3lcBbrIfhlEg8iThEcN1quHa2iNpiSpP20fpyCc0Gzs150KgNOar9EJaRxa8uEfCanI
 gpCnz7wZgBTteTLT0ML8FBqNHaIV7D+nY9MhdFqCd8Y/eWrogij5fExpB37lkOWiBwQtExRLL9c
 R7hB7RvvdZ77RuMDX++I1hM1O2AmfTwzGZMdn7OFblpir4mw1pDvIYlQJzm+RvqNdikjW8zmgsY
 qew/Ad0Z0SxwLnNmsBm2fhpx1N1AbiBq8Dz97ookbV9D4Bo5OqkiKe37m2j0YbLsiDACKZQMyF3
 X931+QaMNQSapU0rvlC+IR+WV+sJhuNqGp3x9C6GrjTXUIYxsbAR5kbSgE6VzQ9Ib3rNTRhLgVB
 X1e50F30jjao7QYfZ8SuQVr1vFIkRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

Introduce qcs615-qmp-usb3-dp-phy compatible string to associate QCS615
platform with its USB/DP switchable PHY configuration. This enables the
driver to apply the correct setup for PHYs that support mode switching
between USB and DisplayPort.

Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
index 74b9f75c8864efe270f394bfbfd748793dada1f5..d56e334d58576d15a9ac047abe40a479e790a324 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
@@ -2022,6 +2022,9 @@ static const struct of_device_id qmp_usbc_of_match_table[] = {
 	}, {
 		.compatible = "qcom,qcm2290-qmp-usb3-phy",
 		.data = &qcm2290_usb3phy_cfg,
+	}, {
+		.compatible = "qcom,qcs615-qmp-usb3-dp-phy",
+		.data =  &qcs615_usb3dp_phy_cfg,
 	}, {
 		.compatible = "qcom,qcs615-qmp-usb3-phy",
 		.data = &qcm2290_usb3phy_cfg,

-- 
2.34.1


