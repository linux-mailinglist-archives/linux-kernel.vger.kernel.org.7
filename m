Return-Path: <linux-kernel+bounces-803266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A8FB45CCC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0128A1717DB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B4A30217F;
	Fri,  5 Sep 2025 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vv8zdK9a"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1293630214A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757087082; cv=none; b=mZOZajVzpORFlfxkJtsfZWaovV0iAH7JM0HyfdmITrMQCQDsOVWga4keL8TElNodaot6yMxDso+HE7moL6qDusQeFub/n830xc9tfm272vugZzsNCaUo1kF5p7tv2NuXlK3/jetTdXBaGyTfWvcmMPRZoDmgU7bCa7u3C7BZ+Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757087082; c=relaxed/simple;
	bh=PhB2wEGrckuh+HShGhmgklly6y1CfiMHr/vjqDHdiKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ScH9TKZQ5vAXofviV47ygsujVkVraGzrOAT7SGeNgfVQzpUOwPJnqOVh1IBUd2z8AU8VN8fOGGJ60leoPat1ZL//t+IScZp1hoILd38S/4OdpLnmxJ9vBvgFdrfHghP32z1obKH9ELmhl36aq513/1tTnUwEqMYHcqqWFR7bweE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vv8zdK9a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857Ak5C007841
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 15:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ZHK+TaiHSdo
	0i2W1eF6c5y+ExVot/td708SwKzVcklc=; b=Vv8zdK9avO0Ifm+uuve/qJ56e7R
	NmudbvEYiA1ytla4nPHVQw6SCsmv6Nsf/f9O+n5iXsQRtVEEupgM1pGbP8kJtbTi
	BVUEaAnWafn7ibu79IWvKiQHi+FyuGjAfAdKyDhQkPJXhLQKejwGeTVO6Pc314EB
	nm6piuQFIRikG2adf9PCf9hbKuiys4yzMWamOAIkPODkvU00nLX4WCivVcextCvu
	lw0F1+z82YJS9FK4W9qU2ZA5asgDpi0zJOSAziQHUJq2qhdBjbZYTYq2wLEX9lQn
	ZyngY90dHkJdO+p5NlX2c4jvjSNZiMZy5qzMJSyoHbeJjraaWUDsfBv6fdw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura93fvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 15:44:39 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b3472b7efeso41096281cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 08:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757087079; x=1757691879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHK+TaiHSdo0i2W1eF6c5y+ExVot/td708SwKzVcklc=;
        b=B3fveNthYLDHJJp81OYlOo21Iga6FCFfm6g16132sWab5Z8Upl3dg2VlBALnLOncAB
         7+SR4vU/ZCWGuMe7pGR9TMkr3lfC3zisE6XPP0hh8X7yAMB8FlpxY68VF7ajVNSA2jUm
         znoGxY/ZUXOc7p43dWCUQMOHHLmiSn76oXkHjeJovFIukifotKmJnAxBU8SHz3gqCQup
         oJXRIouu5IaXOYfDkGEIxvi4NtI6FIRjvv98mpalhw0p2Czt52WJzLdLx/PHr6n1KiuH
         DJdy21oD64+wp4SkFWbYez3ymKtAU9u34MLRLvznqOIf23IuMPMul6AVtb7NhKevMfqU
         idfw==
X-Forwarded-Encrypted: i=1; AJvYcCUp/kH4iN4Ec9yFIJovF4sbtH+DD25VmYq04hWhpQPsA23S99ICxuCVmso/p0RgiJkxfx09HNEYy+ckKkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbgk+kySi3lvPg66qF8GzEQULKc3IZfwYhZ/6eojCfFo+IR5In
	46IIwXS840xXADbVhaQzdcLPbl9RZR6HY7p826iqrzQVmD4OdfMuJAxdc0oe9fzYbzZ3FxXNNnX
	1vUAwafha7jdt8N0bAbb/BWDAzMPFDTXfANiPcKR+4Zvoqt47UwJ4/MTYdryIUhoUrHg=
X-Gm-Gg: ASbGncsuZtOage5d6tj0WaIH8gHkRKEks+kYKL4EftCapox1qg/n5/TSl0LC7z5PT8i
	htJsLOkamzbrRihh8KoMHAUGgMgtcXBJPqdN6N7D6L5a3GBZUPmwjDZwrLVP0SFga1P6elD/Xv2
	9vVHye+IJPemT7HFAKdz+D0vHB7Xi7u5b5mHApDvEgOpIFP//7hHD4W9wl+JpYR/x4PKNrn+2SO
	6Nz8NQ2pdalVFZIIE2FUACLOFQq4R5wUP1uHmEm9VA7ncKGaVBnjBlrJE5md+RANEqJpLKRYWDq
	OJFYBOHguX2e42BGb10pZ8GtB11xN9MPYU8ZrkcAILYJzZumYzANhg==
X-Received: by 2002:ac8:5814:0:b0:4b3:7ec:d238 with SMTP id d75a77b69052e-4b5e7cd601cmr40993101cf.4.1757087079052;
        Fri, 05 Sep 2025 08:44:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCIAh7hGtTrk3JjGWpjyCU0bakKbexV7o3uoUq3SmrVpektwo8ogXEHDmPA2fIURe83QX7mQ==
X-Received: by 2002:ac8:5814:0:b0:4b3:7ec:d238 with SMTP id d75a77b69052e-4b5e7cd601cmr40992681cf.4.1757087078395;
        Fri, 05 Sep 2025 08:44:38 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9bcda91dsm165716585e9.6.2025.09.05.08.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 08:44:38 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, tiwai@suse.com, vkoul@kernel.org, srini@kernel.org,
        yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        neil.armstrong@linaro.org, krzysztof.kozlowski@linaro.org,
        dmitry.baryshkov@oss.qualcomm.com, linux-sound@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v3 02/12] soundwire: bus: add of_sdw_find_device_by_node helper
Date: Fri,  5 Sep 2025 16:44:20 +0100
Message-ID: <20250905154430.12268-3-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250905154430.12268-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250905154430.12268-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: OyJ8oFUzAP72DRkjXv5U0NqPlqyoZlzO
X-Proofpoint-GUID: OyJ8oFUzAP72DRkjXv5U0NqPlqyoZlzO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfXxVoy1QwMUjty
 jT0P42Vu/WpuPGbQ8zODLNZyFxUmIQ3O+PFpH4dYBIVYdcjr6ApDd0y6aenjpFuMI+y8Wq80Jye
 QO3IVVdLXN5LwWvnOJiGI03Fb5bFSyRPhEY9M5NOyJMY1NB+c0KjAhmPjUoqN7jWi5E1NlcazKV
 QkEHy54B0PrDNltVGUPwmVPn57o0gaUbGxUnnyEWJF7911CApW6KLF8znE2okkHmccig+QvyEj7
 yovXD3ny861pqmgfC00JVn7CuOMBUz4gWLiqOQ1AVjEAjMlYe1hFSJd8OuUbR26UNHU8U2eitPc
 ubX9fPzRbRb8bfsFq7UrRFpF53SZ5ziBU3aMEGFgZR5WBJa+uQ/qI8KdHDdwb6SSaGnLRdsXqK2
 vhNh6QrI
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68bb0568 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=Ogeiovxhkh_6Bnox_XcA:9
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

There has been more than 3 instances of this helper in multiple codec
drivers, it does not make sense to keep duplicating this part of code.

Lets add a helper of_sdw_find_device_by_node for codec drivers to use it.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/soundwire/slave.c     | 6 ++++++
 include/linux/soundwire/sdw.h | 9 +++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index d2d99555ec5a..3d4d00188c26 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -273,4 +273,10 @@ int sdw_of_find_slaves(struct sdw_bus *bus)
 	return 0;
 }
 
+struct device *of_sdw_find_device_by_node(struct device_node *np)
+{
+	return bus_find_device_by_of_node(&sdw_bus_type, np);
+}
+EXPORT_SYMBOL_GPL(of_sdw_find_device_by_node);
+
 MODULE_IMPORT_NS("SND_SOC_SDCA");
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 0832776262ac..096213956d31 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -19,6 +19,7 @@
 
 struct dentry;
 struct fwnode_handle;
+struct device_node;
 
 struct sdw_bus;
 struct sdw_slave;
@@ -1086,6 +1087,8 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 int sdw_stream_remove_slave(struct sdw_slave *slave,
 			    struct sdw_stream_runtime *stream);
 
+struct device *of_sdw_find_device_by_node(struct device_node *np);
+
 int sdw_slave_get_scale_index(struct sdw_slave *slave, u8 *base);
 
 /* messaging and data APIs */
@@ -1119,6 +1122,12 @@ static inline int sdw_stream_remove_slave(struct sdw_slave *slave,
 	return -EINVAL;
 }
 
+static inline struct device *of_sdw_find_device_by_node(struct device_node *np)
+{
+	WARN_ONCE(1, "SoundWire API is disabled");
+	return NULL;
+}
+
 /* messaging and data APIs */
 static inline int sdw_read(struct sdw_slave *slave, u32 addr)
 {
-- 
2.50.0


