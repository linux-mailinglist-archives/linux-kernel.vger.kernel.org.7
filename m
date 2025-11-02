Return-Path: <linux-kernel+bounces-881901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1C4C292DA
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 17:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2102B188D175
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 16:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482F32DAFC9;
	Sun,  2 Nov 2025 16:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O7BYyLfP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GVZKAk57"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24BD26B973
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 16:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762102121; cv=none; b=b/WhxZVnIEMfs3YqYm7HzFCo3B+x/4OpFqoB68QVoG90slvYasG273+490YC0uZenEkDu6gaZgdwrvecv0F7r/f4j/8Gnf5WN1DYYr7mk/4I9D7GuqPt/SoAxTtjlXVOQPK9x2AXIIIX+hmiulGIT68LOzy+AtuQ3GagmDAwksc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762102121; c=relaxed/simple;
	bh=VUhk5tIVS9kKX6hvNn1Es93BtcU8P+wTv3tQ6hnUW+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ADMtsWvSpJULh1tcE8atultL1jnGHfWK5qkR/yopx+huPZ3EF2Y+rI75y1ZuP3wvzQp7Djnzr0SSEb5Zlx6VUftY2yOAslUqyqFM5LXOigdRErkKujepK1JW0eOu6UEpM79QEzrOJKPeAV9+SR+ioSMggw3RoqJMyYK5ZBYpCoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O7BYyLfP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GVZKAk57; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A2GfbNG690431
	for <linux-kernel@vger.kernel.org>; Sun, 2 Nov 2025 16:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ITtX/QM07dZ
	9B4EGpnJ4gs20tfWjA0oXsFBww9pw5kg=; b=O7BYyLfPtInSv5eSXiLgdq5EhJP
	0c3zeYQC2voS0vB33mvcKCSVLPedBHKRjJjIH6Pvye+y4jWD9X7Uf8LP2oaJiWdP
	wFd8EkRqRtmQW9FZ7Eg9rGYsE+lLKHc4FxBGImQabNSANan262vW5oVyYAEXPEPr
	Nm1RCHy433dxFXC4zB5EN3ExX/fTVp5jPfBHBRGOU0KtT3BxIeK5oZfpudqs8TKU
	2kKqs5XE/7SE9j/wwOEzAabw164PPXtRoWQg1jKadYBTC8OcDa106Zgt2pXL34Bb
	Q2picvBCSgQZaCSIjm8dDotkgxA0ivsJ73WcyalwuUFqTV2SZdYsAO1pLVw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a59hhjddk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 16:48:38 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7a28961ab86so3055344b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 08:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762102117; x=1762706917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITtX/QM07dZ9B4EGpnJ4gs20tfWjA0oXsFBww9pw5kg=;
        b=GVZKAk57MJf+4PKhYDimVLXOfWlqPq8KgZmnL7PIGzvH7QCeYoBc9Q7jifJaZFlQzJ
         Rs4CsH68tUU3LBkDfR4p7vRJzJjL8SOpUqW8aq2bfvrZGRGDqvfp6QQO3krzZOzXBRSw
         JShWKhsh96Ya661e3VhPgCb0qWbbLM/oKGnU2EYx4yruO0M0Tirm2dg7rvLJ2SF9MGQM
         C3DZeD76Ojf2DleG/JMr0O6VGZnt6vzrOjMW08m464APqF1WsW0TMfNSOxLJuKajbZWR
         zi4rrf3thENwc2hzggrOfuHwswLushazTu3X6gkzNM+xj8IbGi70nWreKjghqqvcI63d
         26yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762102117; x=1762706917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITtX/QM07dZ9B4EGpnJ4gs20tfWjA0oXsFBww9pw5kg=;
        b=dpsk1Qn9s2dxOLigJauHMhsVAcuOaBDg3heESUDrEEJZ4L6a/VXPUW+bnuy4Hb7IIC
         YkXBI/v+yuncq1ts1CI4uscQuOr+ZBObrc2ScJIC+0wmOBGgXTKZ6/VUIAQQYXFfJ2Lz
         qbzqbbvpjLcVKynZSfEgOhz2/wZv5I5pLzX/cuwyXwrKXuhHZlTJNKVfj3AkiSeHFjaL
         QgkDyzHrr4wLF66tr8jhLpBFertdNgTOSbTRMPssqq2FJLLTWxoZ/RQs074v4dWRjQaG
         WXg1q5PM4tt3xFovADvpM0sFY0rX1aaTBmlgFxJplhDTZdXuMoWF2t525pEuagDB+R8R
         NhBA==
X-Forwarded-Encrypted: i=1; AJvYcCVrSVss2NwIP6A+gGkeQVS1fWMNRMiCJGNrpwFhIpKW93uDlIrnmYIf5YJO4huOqxS5jZlTLxl97gBz3qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcQF4GDFqUAjVnMHg6obeJA4nQe8/QlIFmgRZIxzjepUPSdTAg
	vx84ai3DgjceSHB2ngv7vZT+aDz6etHfA935K95WocgrNnvrYBHoXU6dIgAi+zqE40L6HaNHuNw
	gbMyvAMqlfZfT6Ic+VddV63RocRBwrkrGpC0dH9IdBMR7Yi2GUoOe8MrGWV49SnMN5CgThKLQOp
	o=
X-Gm-Gg: ASbGncvVB8K5PmFv6p1jR4qK7Ga7eIBdLQrTeaVIxm5fx3NDvdBJbZDN91Ps7NgQbj2
	BjtML1mhuZi9R/SOba1WYoju5/uh9SM21i3MhG/NnzgCTPFlvghqTYhbeuQCRb5ORceNDRidJqD
	YgjDREolirsxPT0g7QPIWOzEAzQg6o3c3jNtE0ffovONRb+5kSgPPvCTpo7IHXIincVwAzafwF0
	ssMZ1EJhgKq2kUElt0tfu93f32BNz5hHSZjKS30EbndATSuNLvotUiuuYlcLzPTiJWAmGrz+vcM
	iXQwDGQXoX99DUYZSmJAoQdUdW/uUaGih4IFMWTLr7IwwJ3pcSNXYQDrJoNDFvzJgTr7ErXGS1c
	Nd736GlHi1Z2phyAwdrRG66jNTIJjbthkol7J
X-Received: by 2002:a05:6a21:999c:b0:2e3:a914:aab7 with SMTP id adf61e73a8af0-348cc6ed95bmr12421585637.47.1762102117261;
        Sun, 02 Nov 2025 08:48:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4nhNS7nlqb2YAi5SG0s0Ji9IjMUZXRJ64Vy+PMlEEPlTIQJRkSfTGlck3/uwqMo4IbTmG2g==
X-Received: by 2002:a05:6a21:999c:b0:2e3:a914:aab7 with SMTP id adf61e73a8af0-348cc6ed95bmr12421562637.47.1762102116700;
        Sun, 02 Nov 2025 08:48:36 -0800 (PST)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93bda55f74sm7708125a12.19.2025.11.02.08.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 08:48:36 -0800 (PST)
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
Subject: [PATCH v6 2/2] usb: typec: hd3ss3220: Enable VBUS based on ID pin state
Date: Sun,  2 Nov 2025 22:18:19 +0530
Message-Id: <20251102164819.2798754-3-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251102164819.2798754-1-krishna.kurapati@oss.qualcomm.com>
References: <20251102164819.2798754-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V6lwEOni c=1 sm=1 tr=0 ts=69078b66 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=3eHL1KmHa9FwJ4YL2wMA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: jmDX517W8B4I0yTMpoEkDQdpVzOwSF79
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAyMDE1NiBTYWx0ZWRfX/DSlSqQymMLA
 s6ogoxJ7FujqWCyp98zvdQVh/PslBVfWcwQEZw1eSz/yDKIP5ujVVHz5l9DVm/aw3YbMlE+yLgw
 dfCO9JmGXRzu+NHKaI4egyy2T00M6dfB0VKtRuistIIvioPAZe0ruGn8MPhsOUtymzDBalrdLUf
 vUFiwNIwBOKbvZrBQ/yqZWOxINlOVmKTmfiephM1MLlUfydAha2YPeGDe6zp6J9+jfSxxJCW7SC
 5BVsWyPpSBGt868BTmVCV+zBgiTGrAUyoojhYDdCx6LRh8dboInpaRR+F8BNTxIWjXg2arDgbDJ
 VLE202qf2z12oU9cqvK9gRqefTixUOw3oXG2eRFHqeNcjSgJ1/6izRjz6sxfEnehn2wj3cn/HLd
 Fq57H5YPXOJpUzl+qfYiZ4+dbuWoEg==
X-Proofpoint-ORIG-GUID: jmDX517W8B4I0yTMpoEkDQdpVzOwSF79
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511020156

There is a ID pin present on HD3SS3220 controller that can be routed
to SoC. As per the datasheet:

"Upon detecting a UFP device, HD3SS3220 will keep ID pin high if VBUS is
not at VSafe0V. Once VBUS is at VSafe0V, the HD3SS3220 will assert ID pin
low. This is done to enforce Type-C requirement that VBUS must be at
VSafe0V before re-enabling VBUS"

Add support to read the ID pin state and enable VBUS accordingly.

Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
 drivers/usb/typec/hd3ss3220.c | 72 +++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/usb/typec/hd3ss3220.c b/drivers/usb/typec/hd3ss3220.c
index 3ecc688dda82..75fbda42eaf4 100644
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
@@ -319,6 +327,44 @@ static const struct regmap_config config = {
 	.max_register = 0x0A,
 };
 
+static irqreturn_t hd3ss3220_id_isr(int irq, void *dev_id)
+{
+	struct hd3ss3220 *hd3ss3220 = dev_id;
+	int ret;
+	int id;
+
+	if (!hd3ss3220->vbus)
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
+static int hd3ss3220_get_vbus_supply(struct hd3ss3220 *hd3ss3220,
+				     struct fwnode_handle *connector)
+{
+	int ret  = 0;
+
+	hd3ss3220->vbus = devm_of_regulator_get_optional(hd3ss3220->dev,
+							 to_of_node(connector),
+							 "vbus");
+	if (PTR_ERR(hd3ss3220->vbus) == -ENODEV)
+		hd3ss3220->vbus = NULL;
+	else if (IS_ERR(hd3ss3220->vbus))
+		ret = PTR_ERR(hd3ss3220->vbus);
+
+	return ret;
+}
+
 static int hd3ss3220_probe(struct i2c_client *client)
 {
 	struct typec_capability typec_cap = { };
@@ -354,11 +400,37 @@ static int hd3ss3220_probe(struct i2c_client *client)
 		hd3ss3220->role_sw = usb_role_switch_get(hd3ss3220->dev);
 	}
 
+	hd3ss3220->id_gpiod = devm_gpiod_get_optional(hd3ss3220->dev, "id", GPIOD_IN);
+	if (IS_ERR(hd3ss3220->id_gpiod))
+		return PTR_ERR(hd3ss3220->id_gpiod);
+
+	if (hd3ss3220->id_gpiod) {
+		hd3ss3220->id_irq = gpiod_to_irq(hd3ss3220->id_gpiod);
+		if (hd3ss3220->id_irq < 0)
+			return dev_err_probe(hd3ss3220->dev, hd3ss3220->id_irq,
+					     "failed to get ID gpio\n");
+
+		ret = devm_request_threaded_irq(hd3ss3220->dev,
+						hd3ss3220->id_irq, NULL,
+						hd3ss3220_id_isr,
+						IRQF_TRIGGER_RISING |
+						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+						dev_name(hd3ss3220->dev), hd3ss3220);
+		if (ret < 0)
+			return dev_err_probe(hd3ss3220->dev, ret, "failed to get ID irq\n");
+	}
+
 	if (IS_ERR(hd3ss3220->role_sw)) {
 		ret = PTR_ERR(hd3ss3220->role_sw);
 		goto err_put_fwnode;
 	}
 
+	ret = hd3ss3220_get_vbus_supply(hd3ss3220, connector);
+	if (ret) {
+		dev_err(hd3ss3220->dev, "failed to get vbus: %d\n", ret);
+		goto err_put_fwnode;
+	}
+
 	typec_cap.prefer_role = TYPEC_NO_PREFERRED_ROLE;
 	typec_cap.driver_data = hd3ss3220;
 	typec_cap.type = TYPEC_PORT_DRP;
-- 
2.34.1


