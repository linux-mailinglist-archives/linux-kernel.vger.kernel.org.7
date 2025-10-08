Return-Path: <linux-kernel+bounces-845822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E83BC639B
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 19:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3A3B19E1A72
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 17:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CF22C08B6;
	Wed,  8 Oct 2025 17:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PX9lRh/P"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB742C0292
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 17:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759946300; cv=none; b=ffTaFb9wn+G+6sXlIpe8M2vcIjcAnc4tWrN8Fc2h1wHNIkF0IQA8WsLqlnHUJ1PkYrSrUwP1x6eKrUEgu0iAgMu1/Cfv+Rq3nUg8TZe3KjZRmjIwKlu1Dr6LfDM6Nm4ZRSGpDGLq+9zQylHJuFOXbsHwMNX5p0vGjUKnzua2NIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759946300; c=relaxed/simple;
	bh=HLIAZSi34247RaLpZred5z6QQNJ8JD4vy4SJe5suOTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aLVsSIM8PWiDznd14jTve+owzKHcWFqHI05zNPZ7hcmAm9mbwdd43ssV4LKLJWtuN5mqqk5u6JIchacSREMhuc4AKp5aCZtOMzr4mCiNHu1GDcosXRiA1lhUvKe6IHBsZQQYVIZrFfWgdcGwD4vEI42GG3SXbaosB0WbDymio8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PX9lRh/P; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598HBo6u020389
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 17:58:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=81UhKZbZqiQ
	3FBxbCNxzpKfrvsglVuqKJ2pg4yT9dwQ=; b=PX9lRh/Px7lUxAdDETHz3kchLSR
	rnjSicCjJfTVe0rmfTBQO3qIBDNw9WWfAQiwbwSw/VVQMG1UqtD8M6bfkfVsvfkW
	OdK2X6/xhkZK8ZVaeoCLdrcig/NbVERVYZuoCmPZwx4m0niHwjg/9vq9GTB/igpf
	0ek142jDbDvo4skFpwHcevNiDlS1Q3cczK7Xr7VpVKPU2nR8dS7Xdq7iwjpsu0pV
	uk03QFGi4o3dFXEqneTiM6NvOu6uF08AfcP/qQAtBX05k+fKi0x/yFFDFFPTZeLH
	hbPBuZe2wCt0/FVQgUops9H2vlP8FEDt5sJsVchViuioUHc27mGAQbrPikw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4ng525-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 17:58:17 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32eae48beaaso391145a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 10:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759946296; x=1760551096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81UhKZbZqiQ3FBxbCNxzpKfrvsglVuqKJ2pg4yT9dwQ=;
        b=ulPCRif9Jo02ZzlkjN0LEMemnZhDSfoSHxcS23dRlMjf6jgwPwh7a33AXMFD6swEw0
         zclSHN8jCK6qV1jZruiQCT6X/dyVOCwZaEsWRiGygfrIAm9bz+Q02forwR+Ez8tPsF+G
         nDK+cXwcLr+X/scTngt3HvSoWsDBXoNGgm79rwALHFBj7+ubkaquJRJTFtabpWiU7q2F
         awL9U34qEclCednYkqBEX0D8H9njD7Hgykj7uSiNGeETVKhE6UjJG8KVh3oa+VVW0SWx
         vubgvZfgFOnbpaxtAHgGM8EavpR7/0J6DEXGt8HTD2p0Rug8R+W2kdlcj3ylQGSjHDIH
         Qb8w==
X-Forwarded-Encrypted: i=1; AJvYcCVQVERvL9YWuPph5xmxJMcxTizUyLAYlUgv9ZbmbbkfPnvpQ3djxeWZppYnGfIvtajmntPgt04Ug0Un/oU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB0SB4ezvyNgmP2qaLRWkhW7bCmJySTtFHzbSAw7lCfqP4+b9t
	76fPKMJTX/9nMLPv4hbbKRu6L9uhuI+8URmoJ61GGr4Eo1sMGgHsklMNiDh7RupjCAs9ADSH0Vy
	JaXQRZYsdWLyZrMETTmC+whNVUwhGcIKKJ7lzJiarJSuzNeTn16/dmX9gEMpBJ8e8jno=
X-Gm-Gg: ASbGncviza0rVOiNPjlP+2NmOhCuG1Rz5sEcOrSgc/K35GaPiIpmZugAYZYKlSx37mo
	FFGPzsTDcNhCppTsCD7G2u7c6dKhdmcw9o5qB88eNQh/LzaeylnlMSvOYisOBEh5HnrLa1AsLnM
	RRktAWNw+QyFHbNpQOSPZXVCFgkEf6x2jc5Vgw6X3G5TeqmxyBbaOqLpOjT6pRv05NwjgyFVYyB
	3cWKzRKA9f0bHEakCQ3Q8YpjIcIxv8j5/y+8rKJHopRnfrsT7+lhSiEHsE1ibmYZLiNU/bB7O2H
	zrrsVwduwZ38nNyNfzGxKgt1TSiT+VA6X2+qg4VIFxkoy+gzeXDH2wUkWajnCFAxojsS7H64A7o
	21GN5PfI=
X-Received: by 2002:a17:90b:1b04:b0:32b:6145:fa63 with SMTP id 98e67ed59e1d1-33b5114d48fmr5471945a91.4.1759946295979;
        Wed, 08 Oct 2025 10:58:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGY4sUxC2tkm7oYuuyKz8ydAmypwi3ie0On6gCk1oXghiSu6JmLInMP6vDCt0OA/hoeAYbvzg==
X-Received: by 2002:a17:90b:1b04:b0:32b:6145:fa63 with SMTP id 98e67ed59e1d1-33b5114d48fmr5471911a91.4.1759946295416;
        Wed, 08 Oct 2025 10:58:15 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b529f51b5sm1275726a91.7.2025.10.08.10.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 10:58:15 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH v2 2/2] usb: typec: hd3ss3220: Enable VBUS based on ID pin state
Date: Wed,  8 Oct 2025 23:27:50 +0530
Message-Id: <20251008175750.1770454-3-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251008175750.1770454-1-krishna.kurapati@oss.qualcomm.com>
References: <20251008175750.1770454-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX25hhlxiLpe/2
 DSsZ3WlLKomsjrkMSBOpJdvn4Z3ds33BIP0hriXvkPbbaRaAUubcEB2lN49/uk/KPeQCdPyHMVr
 iVQLDeSfE335P2S7EbYmcYdMtHM7+b0DUJ0Ch5hZwYxwN3WhnkcBLbi31LpkSi2nfvHoWlahemT
 6iaB/szYmqxXE3kcuqoQgmsjUIKnAISC1wSBJgu3h+PgwaZOmOKNI5zOO3WHj59jngmBD1n/96p
 J2OM/evonWUoXBPMUzHdS5EgeoH2fdYAq0mBKXrtk2lIoy1QcmaNPjlANlcOfIB01CGc1zqxIEP
 TU5E7vkCjafbcRHiIW96FVDKrNPwSUIELGOHVWESh6yM7T10z2oy32OUI9GJgHpENap7N2ur1tt
 p3XlzXtETTO7leQMQLXbvXF8tRvjIA==
X-Proofpoint-ORIG-GUID: mAlF_2_bUA4Khot4GkTxQObgp48OSpUo
X-Proofpoint-GUID: mAlF_2_bUA4Khot4GkTxQObgp48OSpUo
X-Authority-Analysis: v=2.4 cv=VK3QXtPX c=1 sm=1 tr=0 ts=68e6a639 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=3eHL1KmHa9FwJ4YL2wMA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

There is a ID pin present on HD3SS3220 controller that can be routed
to SoC. As per the datasheet:

"Upon detecting a UFP device, HD3SS3220 will keep ID pin high if VBUS is
not at VSafe0V. Once VBUS is at VSafe0V, the HD3SS3220 will assert ID pin
low. This is done to enforce Type-C requirement that VBUS must be at
VSafe0V before re-enabling VBUS"

Add support to read the ID pin state and enable VBUS accordingly.

Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
 drivers/usb/typec/hd3ss3220.c | 60 +++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/usb/typec/hd3ss3220.c b/drivers/usb/typec/hd3ss3220.c
index 3ecc688dda82..0e81e92f253c 100644
--- a/drivers/usb/typec/hd3ss3220.c
+++ b/drivers/usb/typec/hd3ss3220.c
@@ -15,6 +15,8 @@
 #include <linux/usb/typec.h>
 #include <linux/delay.h>
 #include <linux/workqueue.h>
+#include <linux/gpio/consumer.h>
+#include <linux/regulator/consumer.h>
 
 #define HD3SS3220_REG_CN_STAT		0x08
 #define HD3SS3220_REG_CN_STAT_CTRL	0x09
@@ -54,6 +56,11 @@ struct hd3ss3220 {
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
@@ -319,6 +326,28 @@ static const struct regmap_config config = {
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
 static int hd3ss3220_probe(struct i2c_client *client)
 {
 	struct typec_capability typec_cap = { };
@@ -354,6 +383,37 @@ static int hd3ss3220_probe(struct i2c_client *client)
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
+	hd3ss3220->vbus = devm_regulator_get_optional(hd3ss3220->dev, "vbus");
+	if (PTR_ERR(hd3ss3220->vbus) == -ENODEV)
+		hd3ss3220->vbus = NULL;
+
+	if (IS_ERR(hd3ss3220->vbus))
+		return dev_err_probe(hd3ss3220->dev,
+				     PTR_ERR(hd3ss3220->vbus), "failed to get vbus\n");
+
 	if (IS_ERR(hd3ss3220->role_sw)) {
 		ret = PTR_ERR(hd3ss3220->role_sw);
 		goto err_put_fwnode;
-- 
2.34.1


