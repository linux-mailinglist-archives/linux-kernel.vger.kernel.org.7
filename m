Return-Path: <linux-kernel+bounces-729473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD78B03730
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0BC116DC02
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 06:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD31233722;
	Mon, 14 Jul 2025 06:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p0Ml7n0v"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08184233714
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752474721; cv=none; b=iFmQOkvnDnn7np7XlLayK9AidgF2sD1uMBtxL+FFwr8Zq8l0lyZAUnPrfREqIKd9YAoBb9HjhxtZAaNwF45L3BZy7tCs8zruRZ79ZsyqjJ831Gha+KIOtMpztfVHRC6qHk/l4p3zMp31eM0+KCf+TQmNeuBhTRgRD22XKieG5RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752474721; c=relaxed/simple;
	bh=d/N/TB61i7GeVIWGxfjbRQ9Z2F1vTqrm+bBemdmjw3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uorHGxhJkJccB7vZQfUlMRy10Dd6p4flKuK+SkCTE8cyu/V10jsloj/mSkB3oEd6LNCx/qX5qIuD7jWisEnn9hjM9+9FPG/qxLx0wYHPHXcc3TqJPmtJByyDn4n918jXrc2oZwufUZq9ijSZ1AQbku6Rs/B9nKxfX6heNGfV54o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p0Ml7n0v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DNsB9o018138
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=x07SNj1YXpj
	6RfRQ48AeQgzrdGK/jYfZ/E/HEUOOxeI=; b=p0Ml7n0vTDmc1YlunS231ZIeuoW
	jT/NRHdzV5N7ud9iV/wl48L1N+pjnhRWvIP/vBZun14m4tVkFSRo7zzpYRpAEifv
	VwhE21dCrtAgQESi6Nc5dIQK0YS08/ZUTGzeNXQRoez7mPHx3JmsTdDy7xfK/Q5g
	ujl7LdCj5g7TbHHFnYzNhLs+zoJYhwCkjcDob2Ocr8m55rVgd94vpZfAYbFpalPw
	GLfXp14uEOL/Z4IRfIyEOBHLmf9HvLIkJOguk2beaSPK7nIphx0hKoUMPTtsjPUt
	x/TCH3EQVZ/Zj0aEbBb9+Aons+aN0mx+488hXaUh37kUP3gZeIuk1zWsfVQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufu83eg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:31:58 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-23692793178so36592815ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 23:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752474718; x=1753079518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x07SNj1YXpj6RfRQ48AeQgzrdGK/jYfZ/E/HEUOOxeI=;
        b=nM9FTz1/gkGZlYqwM7vPKhaTltReqEm6/YYfMOwMznTahMQ1qeAbG/DWfZ07KM4EVT
         hLCLjyq4mgA+VpYa3px8WX/wm677Cr/tuFwL11GbK7S3qBsVADzcLRf3FJlGPUfe6S9k
         21nadcDCtFkvld/2mWTc6rpMEdb/Zvd5wzT1udwpBHLTg5OIx9heyoJwlyByHdOGLz0N
         ucL0DgmjF7rYmf0YhzuBo7lZeTR1iwT18nR0ypdY2o5l4OgVBOeIIWA19uCUAds8eQLr
         Y8MIOMuiTIQ3HhpNRia9UdEByOfzd9sOfkSTz1kEbLA/CUWZni79U0C9ZWTs8dRxs8+N
         4zRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsVWm+pYPRS7qMQiZC4DG7f8vrwgOjzkpxQ1BDblhgGZtsIjLPLzzU/HK1zrGDMUgsURQzxrSK2Tjm0Ug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Xg24YJDh724WhVmEM0zDjLqslvOkVgxCqx8Rm0sVF388O7DF
	Y6pLwcEfQGzADT4SLlFVio7ziVNdwVAyENpI9iaNBsVo3q1ui4cfODFmZHaO8jORUCcCwZMiben
	nFtGyFEZynbIFV+s/ZcARNqyskWWaUIWrUwDURzZJ4znweT4haz59OtdsyUh8fvErWls=
X-Gm-Gg: ASbGncsXW3W9mz/uegeZUuaEJbc5NXVWc0+fsqG4D4eJGSKdyBH/K78lJleP+61H2RN
	bseK9B0JJRCAh4U/niyk42hp9mB2adBU0yzR1FjjvqdtErtw/xSJOEj0Hs+4vSn8CSzBa1UFF/l
	64Cp8JkhGXT68TUNfOz/h9K6ZkX8tY2rLF8gqFJmAVqqsqlDSHkhcat7L+U1yMStK8NigXYF34F
	ssq/EiEFt/zhqHtBmrnnR/CWiX7M+mvlsuYUy6ZuPCH8uqFHt6ehYj+6Nrd9HuYyfNB6of1Zhwk
	e5Z23DbNStjor2hl2H2ABMVCkyCBSFdra6UeevBrp5U5EdY/EClDH+chSMS8uii0rzO3L6mNtH/
	ZC4Rc/DiQLUz5jA7P8GjU
X-Received: by 2002:a17:903:1ae7:b0:238:121:b841 with SMTP id d9443c01a7336-23dede4611bmr207184725ad.17.1752474717709;
        Sun, 13 Jul 2025 23:31:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfgAAT9PdM9bRbi+at0lzqsfYnbzx5YAban5kucbRgbI52/04jPmJtMd8Ou3a8XsGgoWkAiQ==
X-Received: by 2002:a17:903:1ae7:b0:238:121:b841 with SMTP id d9443c01a7336-23dede4611bmr207184305ad.17.1752474717246;
        Sun, 13 Jul 2025 23:31:57 -0700 (PDT)
Received: from jiegan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4334005sm86138255ad.158.2025.07.13.23.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 23:31:56 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Jie Gan <quic_jiegan@quicinc.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 RESEND 08/10] coresight: tmc: add a switch buffer function for byte-cntr
Date: Mon, 14 Jul 2025 14:31:07 +0800
Message-Id: <20250714063109.591-9-jie.gan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250714063109.591-1-jie.gan@oss.qualcomm.com>
References: <20250714063109.591-1-jie.gan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAzNyBTYWx0ZWRfXwyX6MiFgcBdH
 SOXOYH9g6kgt2+EiGeZ9lJ3WNs4eCACq+B/CgFIGoSHC/MeO4j1ZgkWe0xew/aZIHPouMjJ2d1s
 Bk736wbzoocF+Ycfua8KwzyDr3/BtGBd2RHhQAIQeYNP8Nx6gVWc6Xi0GNCm1h1+G0UO88KUmlm
 h3TXj7yFkUczISnah3AtGi5EIumoxYjJTZQGQBAO9nwPx7EfiIJ2NquSv9L98qI7TC7n4vWcPzS
 3kQAjaJKX6wiXtRXvywVMENTw9hOGIgY5Q4Y7j/rL/6KgMd4lb0sbMsVb8b+U1x7+SFwv/g4nGY
 z6GOdUGEKaxBfMlh4Q7A/Px6ixHuTWoWiVKjEipwZjnc7GaSmqcDsGfOpwgbl3T6SFtcOLxnLxX
 BSwuVa30BQSsuC4byy07vxCg3Uwza0Ibm5W6OcFyP9IEgNSUflDC9KilOFns6l1aJ+pT1spz
X-Proofpoint-ORIG-GUID: 9cxcrnnIW301uWfLzFBdF_aKCXfrvMpE
X-Proofpoint-GUID: 9cxcrnnIW301uWfLzFBdF_aKCXfrvMpE
X-Authority-Analysis: v=2.4 cv=f59IBPyM c=1 sm=1 tr=0 ts=6874a45e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=wDWrKlMOwBuH9W2KgGoA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140037

Switching the sysfs_buf when current buffer is full or the timeout is
triggered and resets rrp and rwp registers after switched the buffer.
Disable the ETR device if it cannot find an available buffer to switch.

Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 .../hwtracing/coresight/coresight-tmc-etr.c   | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 2b73bd8074bb..3e3e1b5e78ca 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1287,6 +1287,58 @@ static struct etr_buf *tmc_etr_get_sysfs_buffer(struct coresight_device *csdev)
 	return ret ? ERR_PTR(ret) : drvdata->sysfs_buf;
 }
 
+static bool tmc_byte_cntr_switch_buffer(struct tmc_drvdata *drvdata,
+					struct ctcu_byte_cntr *byte_cntr_data)
+{
+	struct etr_buf_node *nd, *next, *curr_node, *picked_node;
+	struct etr_buf *curr_buf = drvdata->sysfs_buf;
+	bool found_free_buf = false;
+
+	if (WARN_ON(!drvdata || !byte_cntr_data))
+		return found_free_buf;
+
+	/* Stop the ETR before we start the switching process */
+	if (coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS)
+		__tmc_etr_disable_hw(drvdata);
+
+	list_for_each_entry_safe(nd, next, &drvdata->etr_buf_list, node) {
+		/* curr_buf is free for next round */
+		if (nd->sysfs_buf == curr_buf) {
+			nd->is_free = true;
+			curr_node = nd;
+		}
+
+		if (!found_free_buf && nd->is_free && nd->sysfs_buf != curr_buf) {
+			if (nd->reading)
+				continue;
+
+			picked_node = nd;
+			found_free_buf = true;
+		}
+	}
+
+	if (found_free_buf) {
+		curr_node->reading = true;
+		curr_node->pos = 0;
+		drvdata->reading_node = curr_node;
+		drvdata->sysfs_buf = picked_node->sysfs_buf;
+		drvdata->etr_buf = picked_node->sysfs_buf;
+		picked_node->is_free = false;
+		/* Reset irq_cnt for next etr_buf */
+		atomic_set(&byte_cntr_data->irq_cnt, 0);
+		/* Reset rrp and rwp when the system has switched the buffer*/
+		CS_UNLOCK(drvdata->base);
+		tmc_write_rrp(drvdata, 0);
+		tmc_write_rwp(drvdata, 0);
+		CS_LOCK(drvdata->base);
+		/* Restart the ETR when we find a free buffer */
+		if (coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS)
+			__tmc_etr_enable_hw(drvdata);
+	}
+
+	return found_free_buf;
+}
+
 static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 {
 	int ret = 0;
-- 
2.34.1


