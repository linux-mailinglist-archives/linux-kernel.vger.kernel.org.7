Return-Path: <linux-kernel+bounces-870988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5798BC0C292
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F04CE4F1733
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA0E2DCF52;
	Mon, 27 Oct 2025 07:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aXEOm9T6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8042DF6FF
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761550704; cv=none; b=QLOrIvqMgxeO1WhD1Fcg/BSXhdGTf5wo1BwqyF5JuVVe3oCEoDRGsHbPOErkcGOZklIadWJYSer5r/3XKEClea+8n99YC+oTBo5ugjUs2F2FRKX/AedBB4kTU/xeIB1fHuqsXvSC2s/zKncEszm0jHYutlRpNyKmehyCAAdjA5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761550704; c=relaxed/simple;
	bh=E4Je2rPViKLDFP+GJRJLkbrj7w2wfCy8afgxPyLEqSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sLClVn+UNCe0DHGEVbPRi2IMzMKwH1WJP+iiCDSFug3V2whWVFBvwIvKfpA11LXx7ZBbXZi7v95yuU9lFQRrw72xJzWbGCpPqsNKZudvy8Shd/JkrFY1r6DIur+FAKZFsh74vH8ivcOub+AkVvzXPJmA92L/a8+Cx6MXdWOEpvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aXEOm9T6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59QMBPPT956986
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:38:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=i1gNHOGlPF7
	+NDlQ8YU12ofupiA74QfpuNeFA2SP8Ho=; b=aXEOm9T6K7JOHpamJRR1Ku4pdlg
	Im4D9qD3CwehbFuJFUWwSNvqRY47qrUt48dFbe1KxXYbON8aUb4ZJ9x7TsNeQV1J
	8NceBe9PYf8jJ4kFGcQZ1oC5kdKaTjHw4AOKQ3K4aiozZEcwwJiKA4xoeIOL9swO
	clJGJ0eKITdnB98J7Dhp7nDeusnNqeQBb1MRSkbre+74WkzeJJ1mbeUcf+Uns2D4
	8cgfTQ4iBVTorYTnQsBci3SHNUSX3EDzYgntmQdW6qfw0UFWoLlhcSaFNQN/cOMQ
	EYj7MnhDEN18wlP3hJCPvpS30ErW8bdOsXJc2ICqsXLAwh6Yk2gRMNlrcBQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0p2q3pe5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:38:21 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87a0e9be970so133161156d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 00:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761550700; x=1762155500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i1gNHOGlPF7+NDlQ8YU12ofupiA74QfpuNeFA2SP8Ho=;
        b=ib8Rd1E/N+ZHyc+SCFHBo3p6NpM6kQJKaQUg3Waf9x5wpJqrqNCJBpU5gaGRHl9XoE
         dAT2sCD2usa6jj5huWLV5bAnJJo0hppL03OrFRci3/Pj6OozG5T98E98S6Dux61fyojj
         5lYFqIvNZxq7+2JmivZKjf64sZA8w6H1C3fci6/eZe3zQYN6z4y/a3EscgbbkRMlDs5N
         DjcyC2ueGbUGK2FYYzXX5ij9GDqtrLSA88K5r2mh2vzZh7XMiJJb7+CKSnRTAICcRojk
         9e7m9EbMhK940hir3sGNjvXZrV1ShcmkviaYoM+76wB/M56Aae/hqERmzUgRNFW/FifY
         NOHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhFAoV3kL8peNFi01PL8JwhwYrR/0Mc59zyqeW5oBHv4NLixX9k3jEjYM4DTCVnvnqIBAhJlNXFqgmwUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRD3LssNVhWt4D5u/HjaQ8QVWdcBix6NEx7ndz3QFm4xfk2T2Q
	Yyxs1LVgVEnrJcistuM62wTqlqjhLuhKV7+My2caSelSJNv7HpOou/tkA6mno5T7QaNwioHyDPh
	ak4fniSpb4AVqjc/dcYL8b6Pv3VT76G5mSaA9/mE1CbQR9Tpx8nfThWRfwbP55umBiFw=
X-Gm-Gg: ASbGncsHXKP/3MgDWhNhqZK5VemW+BOP8/F5zxcjpnqFOGua1FRVMuVmg+IcPeTaay/
	7ihfqHqSWmwWdZ2D2jQKZZwbp3zqxS3JGnN4S46UsQkU7K6stSSzwQR1nZ2rYC/zvrmLGczdyiD
	tM7qx0/eK6j5DkfS3eHbvWXUxzewaWb/qIu9PvIL7E04IgZZuv7orzGf/Yggo8+WhB8E7Vf2I3I
	ZACdcCeiHQfElurlRa4YE99Hcbzy8aerehIh75tEczO+K8cocQX9ogKSIGwPN0RVE2JmaRVNEuX
	XZdSfUM3rLll3daPPozOeEGOfryZ6ta0NBH7MpnWtVrsvxQMd8av/VY5sjgJop6iLtT/b9L+Frh
	N0s6iA25nAvJY5kt4AF6jWh2baEH8q/AabH1m
X-Received: by 2002:a17:903:b48:b0:290:29ba:340f with SMTP id d9443c01a7336-290cb17c05fmr458121555ad.42.1761550079839;
        Mon, 27 Oct 2025 00:27:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO2bHBpzl/TELOhb9izc16IAllt2WXipWLIt7QEoIl6UWefgCqunkcnTKWKnKsOYg5kuqFSg==
X-Received: by 2002:a17:903:b48:b0:290:29ba:340f with SMTP id d9443c01a7336-290cb17c05fmr458121195ad.42.1761550079287;
        Mon, 27 Oct 2025 00:27:59 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e45a4csm70710965ad.108.2025.10.27.00.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 00:27:59 -0700 (PDT)
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
Subject: [PATCH v5 2/2] usb: typec: hd3ss3220: Enable VBUS based on ID pin state
Date: Mon, 27 Oct 2025 12:57:41 +0530
Message-Id: <20251027072741.1050177-3-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251027072741.1050177-1-krishna.kurapati@oss.qualcomm.com>
References: <20251027072741.1050177-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QvpTHFyd c=1 sm=1 tr=0 ts=68ff216d cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=3eHL1KmHa9FwJ4YL2wMA:9 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA2OSBTYWx0ZWRfX6KQMAWSJA7DH
 ifYe2eBEih7lMj0R74rzv8wZpZD7fjYh4MhGlPEx0GAVkQbA6f4OKliQAfyaTROfKga+964Yjsk
 qivZCK0j8ZC+IfsSZr/OvNGfBd5TmYH8FcbX9FBJfQapfTyyzNiK1W9wPQ64bPzc8i0rOoJE95b
 NrZIypx6mM6MzHa6e+YYpK0Q24wHOQU0/1tR29M4BaqTbDN7JsZejUMyASwESCMWkNWdrbypxsa
 hHvULvKBH+mllQpR+KoD2LTxD/QOg8IL7Di9Tdbaz75QOQDf7hH/kNz1MA8RqNQcpE1pkT6c6aD
 LR0mm9oGQdFmkmW/SSDYY2H/cfQwt6/95XFZIXi0c5M33WRI7rdyAd2/aJz8Z5iTWQ4rMaqRezQ
 XKaH7ugC61DZXfvWfWeQP1jGheNPKg==
X-Proofpoint-GUID: WccKXxLGYmcqJZbi-K8pD_Ql1cMsLjqb
X-Proofpoint-ORIG-GUID: WccKXxLGYmcqJZbi-K8pD_Ql1cMsLjqb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270069

There is a ID pin present on HD3SS3220 controller that can be routed
to SoC. As per the datasheet:

"Upon detecting a UFP device, HD3SS3220 will keep ID pin high if VBUS is
not at VSafe0V. Once VBUS is at VSafe0V, the HD3SS3220 will assert ID pin
low. This is done to enforce Type-C requirement that VBUS must be at
VSafe0V before re-enabling VBUS"

Add support to read the ID pin state and enable VBUS accordingly.

Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
 drivers/usb/typec/hd3ss3220.c | 74 +++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/usb/typec/hd3ss3220.c b/drivers/usb/typec/hd3ss3220.c
index 3ecc688dda82..8614c71d7ae5 100644
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
@@ -319,6 +327,48 @@ static const struct regmap_config config = {
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
+static int hd3ss3220_get_vbus_supply(struct hd3ss3220 *hd3ss3220)
+{
+	struct device_node *hd3ss3220_node = hd3ss3220->dev->of_node;
+	struct device_node *np;
+
+	np = of_graph_get_remote_node(hd3ss3220_node, 0, 0);
+	if (!np) {
+		dev_err(hd3ss3220->dev, "failed to get device node");
+		return -ENODEV;
+	}
+
+	hd3ss3220->vbus = of_regulator_get_optional(hd3ss3220->dev, np, "vbus");
+	if (IS_ERR(hd3ss3220->vbus))
+		hd3ss3220->vbus = NULL;
+
+	of_node_put(np);
+
+	return 0;
+}
+
 static int hd3ss3220_probe(struct i2c_client *client)
 {
 	struct typec_capability typec_cap = { };
@@ -354,6 +404,30 @@ static int hd3ss3220_probe(struct i2c_client *client)
 		hd3ss3220->role_sw = usb_role_switch_get(hd3ss3220->dev);
 	}
 
+	hd3ss3220->id_gpiod = devm_gpiod_get_optional(hd3ss3220->dev, "id", GPIOD_IN);
+	if (IS_ERR(hd3ss3220->id_gpiod))
+		return PTR_ERR(hd3ss3220->id_gpiod);
+
+	if (hd3ss3220->id_gpiod) {
+		hd3ss3220->id_irq = gpiod_to_irq(hd3ss3220->id_gpiod);
+		if (hd3ss3220->id_irq < 0)
+			return dev_err_probe(hd3ss3220->dev,
+					     hd3ss3220->id_irq, "failed to get ID gpio\n");
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
+	ret = hd3ss3220_get_vbus_supply(hd3ss3220);
+	if (ret)
+		return dev_err_probe(hd3ss3220->dev, ret, "failed to get vbus\n");
+
 	if (IS_ERR(hd3ss3220->role_sw)) {
 		ret = PTR_ERR(hd3ss3220->role_sw);
 		goto err_put_fwnode;
-- 
2.34.1


