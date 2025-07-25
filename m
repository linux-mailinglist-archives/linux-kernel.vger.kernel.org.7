Return-Path: <linux-kernel+bounces-745587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92819B11BEC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE51F7BF14F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8672ECE93;
	Fri, 25 Jul 2025 10:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="haLl9Imb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA002EBDE7
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438135; cv=none; b=MeRJ0vr/1X/y39aAbmizXJRmZTB7g9dfDKXLJOEXA+8qVKsJqS0EtP5URr7Uh76hLZvB0CDtESyEiqgMQdY5fS3aaJbvy4wrgzHY1xk/IReUygPoK3ats3H7c0+9fA+NX2GsTJuv9iSBm3hqQDRkPNqFZJnp45H7f6rjcaUhgEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438135; c=relaxed/simple;
	bh=xKQ+/Rx/dzM6RV6e/DwULemIMqUa7j0+N1nJWqQg93c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KnBaJ3+otlHUZvwqyt52ftAIBCA3FPgR6etvR9tiscxRjef4V1CBidQsAMAASPKSU1M/vxAagO/UesW5aJuXD/0axjdeRWLGe9QMA0FrcdOWRHh97VMPJEiBC7d7Kuz8td0b5Rl3H2xFrgVS2rGCk/IWAu7sH668505Xp+S3XeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=haLl9Imb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P9ILN5001129
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:08:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Txr3kBSGXuJ
	M1NcPlL0RigHdmQCDNw7+9K0Rj1x3VAA=; b=haLl9ImbzgXKYq/6fRYTzUnyghW
	wTNkpUdG+3EAaaiGR3ISGOciy87wgq9dK8gpiE11dpuObxFt0grW7DbzZJdUrYRa
	iGlbk2rIsYWN4lOUB/E4MPJBLJVTYOWn7Ti6BEVHvLUlbJUiaCHBNeGDPAs3fOxW
	G8HH22BP2D0+JCZqIa9mS6c+2VhIDvUDolg3CKajjkub/DHJOU7M57RJfiTmjIZz
	3cGYzNoiVW+fn2CakPdBLJvAzwsJ4SjfSUy8+4MkSvJinqRhKLO/aBsLZKh+mmNX
	nYtP/IScabGOXj1HzORlssL7hrF9ySWYyvsn0zIiWD71A8hZHjREKq4lirA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w2xhmjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:08:52 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-234f1acc707so18904505ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 03:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753438130; x=1754042930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Txr3kBSGXuJM1NcPlL0RigHdmQCDNw7+9K0Rj1x3VAA=;
        b=Tt3Ymwzev9kSMlS170AJEzioxuzdrKa+dr5GqJ7cVWyU3N7IZ9LlncHoCeWFsqPf/P
         +WYGRTm4oy5woxQyyFA8CJMhthRJjVWTLi/28R3fSrrPLNS/Jfh6ljc41lyGqXgdTEpV
         FwCxtm1aKeD6IvhkfnLJp1VlW7gaHwmZK7DMxdorAnkJInFZnncUFzOS3EV58rXpZZ9c
         vh/Ki9DGDBUWvuSWcsGzzEiw0fGKqDvzphnJiWHUdkZMApCV0wh0hsQ4CRsW964Iwc74
         NP369omsvD9SVpYm8tmjuMvqEjF1zvW21o6UAtyHj2E2RhHTiBhmxHA3hFyMFkv184Cg
         YbNA==
X-Forwarded-Encrypted: i=1; AJvYcCWS2muGttj4aPqDDIkq71B1jG9aYBDwtpoGvYhJkk8bKBU3sFJvn3Tpg6247atzUPpXaoagpJoyyjzmqSE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+GdCDyV8MN4dk+cpiJY+YHjPJKKnAttKQAgnrYuAnb1UfTmWj
	16AeBZ+BygrRcwry3hl49gV/WfU0ZE59mjlZeYBwq2+X+8Xhfj/t0XBaH6XvmsGFj8fzgLaLUVJ
	eXcNbycX5V4Cnm19tF7magYtmWrkWXNnEAnaZSSb3RE3vCjV279SveNA9gWG5Wso4ocs=
X-Gm-Gg: ASbGncuIJsVIFzGMxzVTTm09HStF+XaGlxY1QcSLzqJP6+lnkIHKu/IKSeRsz+5vP9W
	MUBp2BYLPfXDQA1Zs05NoZwcx0Ujqm/jtg8I9zodVF0CflVX5sXF7y3tH64eTE5gxj0nE0ZmTwo
	tNm+Xp8mZxN0+cb7kD4qxCm+85UvIM/PtbVAN4w1ah6jVVrobqLyd79F5TndwloR4gsA5XyifNc
	QIv4cKNP66M1nCMzd7c7MKjJGIiV4Wi2SHkQH1b7JXpVcTPuErBL0AJfxSzKRUmm6XSKZtvG+g0
	/wnNllWzYmQUTZAj7EZKVXL4VDDt30oMFR2XJAN4m19QJZhsEKP784vHowXQm0uIC8EtppeDXr8
	RnB4BNnJ7CZaEu3UqHxc=
X-Received: by 2002:a17:902:f382:b0:234:b41e:378f with SMTP id d9443c01a7336-23fb309b9e2mr11944825ad.15.1753438130043;
        Fri, 25 Jul 2025 03:08:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElHL1J4HjZlxfV/xkGQlCThZW+w8mmt5K25h7rX8vHPVJbhFPxXe4QK00qDdLox5Muncmuow==
X-Received: by 2002:a17:902:f382:b0:234:b41e:378f with SMTP id d9443c01a7336-23fb309b9e2mr11944605ad.15.1753438129635;
        Fri, 25 Jul 2025 03:08:49 -0700 (PDT)
Received: from jiegan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48fd29dsm33641435ad.176.2025.07.25.03.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 03:08:49 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Jinlong Mao <jinlong.mao@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Jie Gan <quic_jiegan@quicinc.com>
Subject: [PATCH v4 08/10] coresight: add a new function in helper_ops
Date: Fri, 25 Jul 2025 18:08:04 +0800
Message-Id: <20250725100806.1157-9-jie.gan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250725100806.1157-1-jie.gan@oss.qualcomm.com>
References: <20250725100806.1157-1-jie.gan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: AisGdSvUuKa-7bn6xk-xLm6WQZGeq8V4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA4NSBTYWx0ZWRfXzDFfEH+1T29e
 rfsGKJwFh4h8KYicxGFfiMDNx9X5wj4DrsD6j3PT9gXApHlch2Wg8iSArq5lZdz/O/2Le5uJrCw
 UajxDyIQSFFjUrLAZBp6YglYENPUONZXRZKinVjqwt/8tYlSD+TfS3meJnRsctvGhoyJkB6qmkG
 lrl0eZxAFKoVd00zXaYesycZO++bU0wgqPcibtpU948d6/PPOvd+6CROj2HobK5201ejLxmU8bv
 h8AJMApzkQBPv8BNA7xIYvrQGI+HhBmqAt0zBIegBJ2EVk2oXhtfZEhwO7/jmmtv/ecEZ4QdlN0
 qOpBUBi6jzZNhTEusVECa6j5RCYExWWV4HSIo/94qGupn1eYg/YJFnn7+1B/li4tAV0s4Pwt0np
 WWG9eeig4mHHl0ZghAY5O5UfkwEcfhgMygjrdBoz2srJubZBRNZhHF6fphKRmvlNOZ0nDtDp
X-Proofpoint-GUID: AisGdSvUuKa-7bn6xk-xLm6WQZGeq8V4
X-Authority-Analysis: v=2.4 cv=S8bZwJsP c=1 sm=1 tr=0 ts=688357b4 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=vagHEfzm_U2ljPniXDUA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250085

Add a new function to identifiy whether the byte-cntr function is
enabled or not in helper_ops.

The byte-cntr's read_ops is expected if the byte-cntr is enabled when
the user try to read trace data via sysfs node.

Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 .../hwtracing/coresight/coresight-ctcu-core.c | 35 +++++++++++++++++++
 include/linux/coresight.h                     |  3 ++
 2 files changed, 38 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-ctcu-core.c b/drivers/hwtracing/coresight/coresight-ctcu-core.c
index 8fc08e42187e..dec911980939 100644
--- a/drivers/hwtracing/coresight/coresight-ctcu-core.c
+++ b/drivers/hwtracing/coresight/coresight-ctcu-core.c
@@ -234,9 +234,44 @@ static int ctcu_disable(struct coresight_device *csdev, void *data)
 	return ctcu_set_etr_traceid(csdev, path, false);
 }
 
+static bool ctcu_qcom_byte_cntr_in_use(struct coresight_device *csdev,
+				       void **data)
+{
+	struct ctcu_byte_cntr *byte_cntr_data;
+	struct coresight_device *helper;
+	struct ctcu_drvdata *drvdata;
+	int port;
+
+	if (!csdev)
+		return false;
+
+	helper = coresight_get_helper(csdev, CORESIGHT_DEV_SUBTYPE_HELPER_CTCU);
+	if (!helper)
+		return false;
+
+	port = coresight_get_in_port_dest(csdev, helper);
+	if (port < 0)
+		return false;
+
+	drvdata = dev_get_drvdata(helper->dev.parent);
+	/* Something wrong when initialize byte_cntr_read_ops */
+	if (!drvdata->byte_cntr_read_ops)
+		return false;
+
+	byte_cntr_data = &drvdata->byte_cntr_data[port];
+	/* Return the pointer of the ctcu_drvdata if byte-cntr has enabled */
+	if (byte_cntr_data && byte_cntr_data->thresh_val) {
+		*data = (void *)drvdata->byte_cntr_read_ops;
+		return true;
+	}
+
+	return false;
+}
+
 static const struct coresight_ops_helper ctcu_helper_ops = {
 	.enable = ctcu_enable,
 	.disable = ctcu_disable,
+	.qcom_byte_cntr_in_use = ctcu_qcom_byte_cntr_in_use,
 };
 
 static const struct coresight_ops ctcu_ops = {
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 4ac65c68bbf4..b5f052854b08 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -419,11 +419,14 @@ struct coresight_ops_source {
  *
  * @enable	: Enable the device
  * @disable	: Disable the device
+ * @qcom_byte_cntr_in_use:	check whether the byte-cntr is enabled.
  */
 struct coresight_ops_helper {
 	int (*enable)(struct coresight_device *csdev, enum cs_mode mode,
 		      void *data);
 	int (*disable)(struct coresight_device *csdev, void *data);
+	bool (*qcom_byte_cntr_in_use)(struct coresight_device *csdev,
+				      void **data);
 };
 
 
-- 
2.34.1


