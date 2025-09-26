Return-Path: <linux-kernel+bounces-833694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D453BA2BF5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AB414C3CF8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 07:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42D428851E;
	Fri, 26 Sep 2025 07:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RPr50GtY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F84296BD8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758871625; cv=none; b=cc1pTa9gSdy0ofEt8XXRVff968zpso0Eh49SGpG6yK4xR4YHDb+MSTYbzkPcPIGAlztgvaDoNYPVMXexmg8EqlCJI9Z5ojzXoWTaKzayd6IJjzL/HvwpeX45VvX+8euiN5Fii0/gDNj5OJfgnXFeD+v52oJ0jjsCjXHF8HF+y4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758871625; c=relaxed/simple;
	bh=2OW0hX9TF4LQlObLysgxoFrzLXkqUgu/cavYoT3SHP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k6/+2J3qsqA3Ox6xOU5rwjio6XCwnaejp2V1RWWHx6yoLnL9MXa9HOeTlZMMqje8QW0JD/U38SzNfjMdP4g+gln/KFAim8HwbiJS67swaohetvCwoMFoWc0yprdkQquR7W1HNLa5mhrJpMjP3zpuJXWaNjFKDzc34U6jJbr1ZNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RPr50GtY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q6p672014879
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:27:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IxgE0hKaY239kxGeqZ+8x/JCG89cRYkF0bkaQ2dVCzM=; b=RPr50GtYbu331Fr7
	6uqZL8bF1SLiEM8h0rMRK7Udfa0FjSNLHTAH536sn9KLs5OZwRYgoA0+MYVxfnIb
	+DtCXyrAdMytGHio40wjlWUA8g7rOC2uLsbGJt8mUilxcve6RT9HIuv8VdTfDLeF
	fekZsobX+NLsC9IJcHUXF1uLM862eOqTFNCkq3JNeY3jIx3F+hNNo/VSxGXyhoHI
	6qxyyi/3fl2UpMVBoOGpUALAZRzpmq6teE84eJf9tu/yUQsggNgUqncj9GzMOUiI
	zkxys/hj4LXHOmzzIU7u9jvRbvo8vtKss+g9ejNzRuuNKMTDj8yWksKirSWmTmrU
	CaunvQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0t9wrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:27:03 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-33085281806so583486a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 00:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758871622; x=1759476422;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxgE0hKaY239kxGeqZ+8x/JCG89cRYkF0bkaQ2dVCzM=;
        b=jHUw1ClfOU95WQSpWFktY4L8WZrPp8vqyFVnE8OUj4YDB103C8GXAWxTFHrgUBYFcK
         Bm0GwULHBgcvUalUp/JSlECpz/UvrS3l+DypWEsalikQGFKl9jy4jz9UJKOVqE/LbKuE
         p9k02TK44ykY8CQlBSnN6c5azLbnhBD3wXM4Acy+RJm97W0cIv7Ta3GIuRlMoGM9D8T3
         UqHJme5M/qX7Ggzd1BPbinjmdHTicYyqlmHPpQ2LUXndFrurva4hm8d3hgTQ+Wi3TwAt
         pEAbKW6YptruV6vRfHMerrRfWCLyoFG5DsQwO+KEeHkknxz6npHOosQpsaP0NqEP6rwT
         G3Lw==
X-Forwarded-Encrypted: i=1; AJvYcCWQvZwSBegVEbOMPylzDUbygx3IBOIwfOAeA0Bh6X2ISnc04yy5l5AXe0Wf98o6xVpm91BrcTRjx1xwygU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwwJWVqxEeK6tj2PxHTRGdJ+jD1sIif+8k7hXDLcBf1IF8RdwK
	zF2+telG7cMhqaCenAyj4ikpEVP6ZL7CcAy6aH8Lutkek4oJGfcG5O4pcIxTho9+WhRBkUQbwI+
	S15n66TZO9rao9vofyWCUfVgTb+ZNQr9bBVq7asksNPhjV/G0xHrpxwOxOswcnc5XBQA=
X-Gm-Gg: ASbGncuRdr/vo+U4zomja8dEyfuYooU9sWDI0t1ffpxO+PDD4YdpyS2Ns4s66A2N/LN
	dMHHfxwlSJ92SbEG45WeqHXni4z4L8MR2IOKaFNQa463sYbXoKOgy3rJ3Fo5Hu5nyDjqTMvOdRR
	XqsSJavfRWMY8VCPUNyr8oRdxKBGBUOwEKdzNAxwCp0zIvTuakEeA+J3hxUhvRaY/WUjWZmLrTT
	U9b+fm+5jNcDeThyLyyADeq+qbbMwlin60W8z1X64lDBVRElghE7ug2Y3ivpgVm6eDb3n4eytmk
	kNtO9lIkpWOJ5MzojF2VlTy8A5QawVzYNhNGmdpP9He3BrPod1PvIUPHartRp27++PbV6l6zO7Q
	hihZ59fPoGoLiXeNA0KvV6WgE5tE8QZgBGQLjTHn3QgS0DyzrdHsRSXET
X-Received: by 2002:a17:902:ec85:b0:272:f27d:33bd with SMTP id d9443c01a7336-27ed44d5f06mr43818375ad.0.1758871621622;
        Fri, 26 Sep 2025 00:27:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELcGDRUyHhDjRuK+sfwMHvaCkFijxaFU/1OQEc5tsi7wGyfqnm7Rd7vXgkx97Obwa2yIJ71Q==
X-Received: by 2002:a17:902:ec85:b0:272:f27d:33bd with SMTP id d9443c01a7336-27ed44d5f06mr43817965ad.0.1758871621114;
        Fri, 26 Sep 2025 00:27:01 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671d8a2sm45117985ad.55.2025.09.26.00.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 00:27:00 -0700 (PDT)
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Date: Fri, 26 Sep 2025 15:25:43 +0800
Subject: [PATCH v7 07/14] phy: qcom: qmp-usbc: Move USB-only init to
 usb_power_on
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-add-displayport-support-for-qcs615-platform-v7-7-dc5edaac6c2b@oss.qualcomm.com>
References: <20250926-add-displayport-support-for-qcs615-platform-v7-0-dc5edaac6c2b@oss.qualcomm.com>
In-Reply-To: <20250926-add-displayport-support-for-qcs615-platform-v7-0-dc5edaac6c2b@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758871563; l=2424;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=2OW0hX9TF4LQlObLysgxoFrzLXkqUgu/cavYoT3SHP8=;
 b=o+EwyMZL/K98MOCjTKEANPF15zjybJyWzaygL2LdekPrK23Nbpo2cRjW2t65GTczfpyFcNO1A
 Kq6j6hcnQLdCpTI5xm9JEDlxg1/Xuwp+qm75/ijFHpz6J4XrHFoaCPB
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Proofpoint-ORIG-GUID: 5W5zrfGvH56KJO0VILdBpye6ke69_gvL
X-Proofpoint-GUID: 5W5zrfGvH56KJO0VILdBpye6ke69_gvL
X-Authority-Analysis: v=2.4 cv=Jvz8bc4C c=1 sm=1 tr=0 ts=68d64047 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=JIg05Gv9We-wtn8mShgA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX8/WHykC1FOdZ
 qnuzfKnoiF2YAD31oOypohMPtCOSr/qxiqYPaSJM6GV9Bu5rdML5U6QUZVF0maICm9jJXNOTMvm
 x9/p5iSueer3k5eSa2IHJVsREfLjq2yJZe3HKjCuFxahr99dUHxQx/3ekYKIe6vD7LwfdTv9auJ
 yqWhiV2iipSJ5a6j+mQqdvkvv1zlHWtd4/5JvDk2wnANpCm4ypwB3bKi9nRNoSfcGRP3G4YvjYj
 Bo46E1dV85EllRIF8SYkFBPM2UiPNX+VNM3emo06+GoHcTjJ88y+G7Kv8Y1NkapF+YWUw3quP2Y
 Bg5SgvPAv2sRbN+TYeKDRCc1ezLbuCPJE7esp9J9u6pkRDMd2seH/0Zjd88LTSX9/n/UHyMNOvZ
 SPtIjCPLX5OLrdxtQkz03yZdKDLUMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_02,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

The current implementation programs USB-specific registers in
qmp_usbc_com_init(), which is shared by both USB and DP modes. This
causes unnecessary configuration when the PHY is used for DP.

Move USB-only register setup from com_init to qmp_usbc_usb_power_on,
so it runs only for USB mode.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
index 7139f4dab82fd7b0d1362dddefba178465e76fa4..a971bdc3e767727e69ea07b14d9a036347d365f4 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
@@ -30,6 +30,8 @@
 #include "phy-qcom-qmp-pcs-misc-v3.h"
 
 #define PHY_INIT_COMPLETE_TIMEOUT		10000
+#define SW_PORTSELECT_VAL			BIT(0)
+#define SW_PORTSELECT_MUX			BIT(1)
 
 /* set of registers with offsets different per-PHY */
 enum qphy_reg_layout {
@@ -531,8 +533,6 @@ static int qmp_usbc_com_init(struct phy *phy)
 {
 	struct qmp_usbc *qmp = phy_get_drvdata(phy);
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
-	void __iomem *pcs = qmp->pcs;
-	u32 val = 0;
 	int ret;
 
 	ret = regulator_bulk_enable(cfg->num_vregs, qmp->vregs);
@@ -557,16 +557,6 @@ static int qmp_usbc_com_init(struct phy *phy)
 	if (ret)
 		goto err_assert_reset;
 
-	qphy_setbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL], SW_PWRDN);
-
-#define SW_PORTSELECT_VAL			BIT(0)
-#define SW_PORTSELECT_MUX			BIT(1)
-	/* Use software based port select and switch on typec orientation */
-	val = SW_PORTSELECT_MUX;
-	if (qmp->orientation == TYPEC_ORIENTATION_REVERSE)
-		val |= SW_PORTSELECT_VAL;
-	writel(val, qmp->pcs_misc);
-
 	return 0;
 
 err_assert_reset:
@@ -599,6 +589,14 @@ static int qmp_usbc_usb_power_on(struct phy *phy)
 	unsigned int val;
 	int ret;
 
+	qphy_setbits(qmp->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL], SW_PWRDN);
+
+	/* Use software based port select and switch on typec orientation */
+	val = SW_PORTSELECT_MUX;
+	if (qmp->orientation == TYPEC_ORIENTATION_REVERSE)
+		val |= SW_PORTSELECT_VAL;
+	writel(val, qmp->pcs_misc);
+
 	qmp_configure(qmp->dev, qmp->serdes, cfg->serdes_tbl,
 		      cfg->serdes_tbl_num);
 

-- 
2.34.1


