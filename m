Return-Path: <linux-kernel+bounces-869376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 981A6C07B5F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832671C815C8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A784634C99D;
	Fri, 24 Oct 2025 18:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EE9a6UvI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B339534BA42
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329943; cv=none; b=Tq5CnLwLlqOn5nKDXZVyIto92rP1IWMtwWGS7i0R1k2mmpL9xAbT7IwS3j/i+v5mWcya7Apof8Z39TuHY355/MsHX8Kc4TgSvvAvsHJuWsMxSfNM8JVLfZ+CgiXlcw3Ct64UtvRVffNxkhx3Xd4RD9JLaqvVkYLw2zQkiMcUtiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329943; c=relaxed/simple;
	bh=bYKZfRy493BjHUUMMUf8qDIAsdclwDo0cOBzM86O7xE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RRzDmJVh4ZlrPIlVxL3gO/he1OCtm4v7wkC3BvBUryDUDAL8XS9s75kbmzxl+QDNmg54vacPBZQTZFrcu+kESupaT+MmdeexAaZX6pDZPGX5Tv7wNnuIaCJ01UV6DdCYwyoUXs+YywwBOz9xIqVe2a/jLXbxEbh40evvI1O5A9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EE9a6UvI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OI9K03026930
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 18:19:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=FNRiqA6ZWIA
	ZhUHE0CMfI2vngujnY7ny3jYCqjeJjGE=; b=EE9a6UvIV4V+sUDUCbhmJxbkxHp
	HGErmIdtYPc0jKUh6vI7vbGdSzsZ75wwSpIA1RkUz50EB3z7bWSgPSdLH9BlXEXe
	OMhnTCZfAVO0UV4zZi8jZpJKoA67GmTe/ehhMSaAiAqtxeO5wt2g2CaEH6meqtcr
	O35DMWPYoGtEwsVriS2M/nwXOonbrVqr8stvWE9fjlcf//ByALKyM0c7hQZ3EKl/
	ZkP33v3UZx3b2FhcOnb9o02U5Sc26xy2J47XsBo1HJ2uYjWoeuybGjcfuptMXrie
	hTTZew1hHC8DbixYRL04eWRTivolLLvzVssB+VVasZ5QyFSF5XcijHvYxsw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xhe0tvnd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 18:19:00 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-27c62320f16so22912495ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761329939; x=1761934739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNRiqA6ZWIAZhUHE0CMfI2vngujnY7ny3jYCqjeJjGE=;
        b=wt7N73FmOYqI4RmQ++LLBCV4j879H5hS1kuL9fVStaoSPSB00qKyYiYOR1jMkOptmz
         LPcUBrSbundsnc5uEOhFc7B5k7tCW8ktXOVIUHTkxrI7tCvzPCH1gX3z5WmdwQzk2aOT
         0gffAIgjGVEVptz+WP2/GMlDAmgSwCfhzUV4EmANHxHUhR4gBkdaDZJPbDmeQHPpgpjj
         U+ptjOzqg6C8WU+/TwQ6yFXyl7U1DOULU+WrNYH/Rg6nUErsMivgzwsUmBnzXRiMxWf7
         BckL4W/cD/vgM1SHSRuWR90kjIys4BwAu235kezY+Hij2avzjzfc6Lr71P0c3iSdJ10o
         ChhA==
X-Forwarded-Encrypted: i=1; AJvYcCXpRwefH7ygBlseqCYJT3JEgJFBuiWYDqWoodfHaThv822m8OpA0/89FMFCLQPTx7VOwFWx/TkTL6StLC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHSKow1ncTO4Ps+rqvJPT2LzgjmRLLn8tOba23UGsdh/S6zrEy
	Iffy80y7BOvYMiZNJ9MbW8sBtptcGQsic+pgPnN4x2y5b+DXUHiqIU97tzCvMNxdOCFX3HG8mBk
	p30Nlg0cM0BEmReR4RAoqVpzsxK5urJ3+cnyZsuexVlLSUZMcBVjUgPP8h1UPFptPE/U=
X-Gm-Gg: ASbGncvJ/h7pK+E6ZjSci2TDu2VJ8SH6dijbjf8167pGpitT7BCTBUeTn7YlCoB2EIh
	w93I45WzbBAl96bDiWM4id1fV0P3qBfS4PZy2bH25+obufUogAlbLYcipjWIeWl5s6kFrGrqkq0
	6HODtSim+2Q+t9rN0FtxgxS90eTVTgZOunELrvu4ZC+j4NfQ5e+4jCWRy0zQo4QqYcFmRRN1ger
	AP9YXyFErJNAje+xguDa1r8m6rMpUi0r/9z3q9drL4tlOBT8rNHmN1BVlC0iVkQpsG6R+ZkwBWu
	v77waRKVa5CVWFgat1ATkePxNTJZ9shEucqh1tqhn27wizGKT9mNVvR/6nGzqQjyEPj1xI4Xyrl
	gzue0gaTZVIh+CckxAP3mZnt565o9YVeCo0ue
X-Received: by 2002:a17:902:e5c8:b0:27d:6777:2833 with SMTP id d9443c01a7336-290cb18415emr406071585ad.47.1761329938911;
        Fri, 24 Oct 2025 11:18:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSm/bODB+wvY+31q4oQRKstujxXhMa/XtgYhxLhkWB1z17N1nmPow/OM0vlNhYjjaE9nT2ag==
X-Received: by 2002:a17:902:e5c8:b0:27d:6777:2833 with SMTP id d9443c01a7336-290cb18415emr406071155ad.47.1761329938241;
        Fri, 24 Oct 2025 11:18:58 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dfd0405sm62398045ad.66.2025.10.24.11.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 11:18:57 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH v3 2/2] usb: typec: hd3ss3220: Enable VBUS based on ID pin state
Date: Fri, 24 Oct 2025 23:48:32 +0530
Message-Id: <20251024181832.2744502-3-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251024181832.2744502-1-krishna.kurapati@oss.qualcomm.com>
References: <20251024181832.2744502-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE2NyBTYWx0ZWRfX4wx5SflzdWwg
 ZaJzqItVbd+K56P3cl6y9xnvUI0Hl/qc6CjDlivrRnQlNBixruigWnr+R2vFpbD7nuDG+b/bbZU
 cLzpYxcQ9aJF9vxtc7lUhiDbM1448+qpEfBXjMGhQBFdmTz/5kpH1wTtasJdiYZbqwPqG3CHzeF
 HpFa4S9Wb/zMyzkaVHn18A+t4+jsRJixDstRrUNi9o9irWFyl8bPCpChkbJMAJqCarhjXxw3fCd
 V2lM7EGcQHO/OpvI9WxpSuQDkOJxdGFUdxsllauAFgyMsyDdFPofcIwM5l+mJOGqjz9mjQZ510p
 L5SKWinTsQWUfAe7uSQrpo9tSCxXUHb9Kj1TARxlb1J2iVOLOEqVQ0LaIbM3yeyjSJe53JCB+dT
 F1900k/DMflv6Uk3RieL/sObaVFDfg==
X-Proofpoint-ORIG-GUID: D-mK0WWQ3QibnMEsbzlqgpC-qeuELxqD
X-Authority-Analysis: v=2.4 cv=WYUBqkhX c=1 sm=1 tr=0 ts=68fbc314 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=BB6_mFRvN0jHwWjQ22wA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: D-mK0WWQ3QibnMEsbzlqgpC-qeuELxqD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510210167

There is a ID pin present on HD3SS3220 controller that can be routed
to SoC. As per the datasheet:

"Upon detecting a UFP device, HD3SS3220 will keep ID pin high if VBUS is
not at VSafe0V. Once VBUS is at VSafe0V, the HD3SS3220 will assert ID pin
low. This is done to enforce Type-C requirement that VBUS must be at
VSafe0V before re-enabling VBUS"

Add support to read the ID pin state and enable VBUS accordingly.

Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
 drivers/usb/typec/hd3ss3220.c | 101 ++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/usb/typec/hd3ss3220.c b/drivers/usb/typec/hd3ss3220.c
index 3ecc688dda82..089c4168c7b5 100644
--- a/drivers/usb/typec/hd3ss3220.c
+++ b/drivers/usb/typec/hd3ss3220.c
@@ -15,6 +15,9 @@
 #include <linux/usb/typec.h>
 #include <linux/delay.h>
 #include <linux/workqueue.h>
+#include <linux/gpio/consumer.h>
+#include <linux/regulator/consumer.h>
+#include <linux/of_graph.h>
 
 #define HD3SS3220_REG_CN_STAT		0x08
 #define HD3SS3220_REG_CN_STAT_CTRL	0x09
@@ -54,6 +57,11 @@ struct hd3ss3220 {
 	struct delayed_work output_poll_work;
 	enum usb_role role_state;
 	bool poll;
+
+	struct gpio_desc *id_gpiod;
+	int id_irq;
+
+	struct regulator *vbus;
 };
 
 static int hd3ss3220_set_power_opmode(struct hd3ss3220 *hd3ss3220, int power_opmode)
@@ -319,6 +327,71 @@ static const struct regmap_config config = {
 	.max_register = 0x0A,
 };
 
+static irqreturn_t hd3ss3220_id_isr(int irq, void *dev_id)
+{
+	struct hd3ss3220 *hd3ss3220 = dev_id;
+	int ret;
+	int id;
+
+	if (IS_ERR_OR_NULL(hd3ss3220->vbus))
+		return IRQ_HANDLED;
+
+	id = hd3ss3220->id_gpiod ? gpiod_get_value_cansleep(hd3ss3220->id_gpiod) : 1;
+
+	if (!id) {
+		ret = regulator_enable(hd3ss3220->vbus);
+		if (ret)
+			dev_err(hd3ss3220->dev, "enable vbus regulator failed\n");
+	} else {
+		regulator_disable(hd3ss3220->vbus);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int hd3ss3220_get_vbus_supply(struct hd3ss3220 *hd3ss3220)
+{
+	struct device_node *hd3ss3220_node = hd3ss3220->dev->of_node;
+	const char *compat_string;
+	struct device_node *np;
+	int num_ports = 0;
+	int ret = 0;
+	int i = 0;
+
+	num_ports = of_graph_get_port_count(hd3ss3220_node);
+
+	for (i = 0; i < num_ports; i++) {
+		np = of_graph_get_remote_node(hd3ss3220_node, i, 0);
+		if (!np) {
+			dev_err(hd3ss3220->dev, "failed to get device node");
+			ret = -ENODEV;
+			goto done;
+		}
+
+		ret = of_property_read_string(np, "compatible", &compat_string);
+		if (ret) {
+			of_node_put(np);
+			dev_err(hd3ss3220->dev, "failed to get compatible string");
+			ret = -ENODEV;
+			goto done;
+		}
+
+		if (strcmp(compat_string, "usb-c-connector") == 0) {
+			hd3ss3220->vbus = of_regulator_get(hd3ss3220->dev, np, "vbus");
+			if (PTR_ERR(hd3ss3220->vbus) == -ENODEV)
+				hd3ss3220->vbus = NULL;
+
+			if (IS_ERR(hd3ss3220->vbus))
+				ret = -ENODEV;
+		}
+
+		of_node_put(np);
+	}
+
+done:
+	return ret;
+}
+
 static int hd3ss3220_probe(struct i2c_client *client)
 {
 	struct typec_capability typec_cap = { };
@@ -354,6 +427,34 @@ static int hd3ss3220_probe(struct i2c_client *client)
 		hd3ss3220->role_sw = usb_role_switch_get(hd3ss3220->dev);
 	}
 
+	hd3ss3220->id_gpiod = devm_gpiod_get_optional(hd3ss3220->dev, "id", GPIOD_IN);
+	if (IS_ERR(hd3ss3220->id_gpiod))
+		return PTR_ERR(hd3ss3220->id_gpiod);
+
+	if (hd3ss3220->id_gpiod) {
+		hd3ss3220->id_irq = gpiod_to_irq(hd3ss3220->id_gpiod);
+		if (hd3ss3220->id_irq < 0) {
+			dev_err(hd3ss3220->dev, "failed to get ID IRQ\n");
+			return hd3ss3220->id_irq;
+		}
+
+		ret = devm_request_threaded_irq(hd3ss3220->dev,
+						hd3ss3220->id_irq, NULL,
+						hd3ss3220_id_isr,
+						IRQF_TRIGGER_RISING |
+						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+						dev_name(hd3ss3220->dev), hd3ss3220);
+		if (ret < 0) {
+			dev_err(hd3ss3220->dev, "failed to get id irq\n");
+			return ret;
+		}
+	}
+
+	ret = hd3ss3220_get_vbus_supply(hd3ss3220);
+	if (ret)
+		return dev_err_probe(hd3ss3220->dev,
+				     PTR_ERR(hd3ss3220->vbus), "failed to get vbus\n");
+
 	if (IS_ERR(hd3ss3220->role_sw)) {
 		ret = PTR_ERR(hd3ss3220->role_sw);
 		goto err_put_fwnode;
-- 
2.34.1


