Return-Path: <linux-kernel+bounces-764330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A5DB221C0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 779E46E3FA6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BE02E9EAB;
	Tue, 12 Aug 2025 08:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a848246D"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568382E9743
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987883; cv=none; b=HFtgT3j41jIPTTY7ojt9PKPZLFvQwG/50ESs8FAmhsaD6y+LBYamLeEA/ojaSxe9it5TWtme7xfTtGkgpF6kVQXO6wusPnLOqWmSgfyM6RJLGi62BfYKBqoIPIzckKPe5/sjBiT21Hqqkn8t/LEY3oQU0oAV0xwXDC1U7J1cNNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987883; c=relaxed/simple;
	bh=GOPjgHWxv1KwRPxnlny046bCIvHx4fvw/23iFRXh6tA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tt4HaXXtGPQJW1JJVWLozwas5OitSSr21I7+Rhzo1ykhgvLCi5loIgzA7S2gw8aeSQGhVcdubRzT1KuYPo+gDrgGg0s3NAklzy3Oq3YjO81phkd5lIUvvKIeD/D/fxO9J4ZqwxTRz/92A0a4rff8ejlxxYz0a+pabU84fKX7t+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a848246D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C5X9vu021586
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:38:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=nfhiX1ygP2A
	vXXrs0gcWYMD2ZsFc5ZoIj7fNw/kuGXI=; b=a848246DTWrr8GBfTijf6OIzLAI
	HTGVIOm9ZWPzxG9azZHVn6sXBR28x0/U7pScZwW0t6U9fopH9vRS6BvJOLIm4K9o
	zSFoN+rwtXwSDowODTuZd61v3jO3VkgS7SSiNpTe+gm8zkMVKyWmotgOlnycazmt
	nvqKKwSccD8kJP6s2bGcAhoZdnI6u3Xo8ju6VEax8NDfsq8cGb0TKWM6xpvwdkIk
	uVmrquZa99DPS08LBiUfA8pA7O5K9L63pemdNdCmxaTH9eJ2DciVT0bopDqffzmC
	7Wctb8Pc62rlpiGTJ8THL40wP93NU5oKO4ZyiE4p5M1Q1N8CZrlLwWkemSQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxj47dsn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:38:01 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-23fe26e5a33so79443695ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754987880; x=1755592680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nfhiX1ygP2AvXXrs0gcWYMD2ZsFc5ZoIj7fNw/kuGXI=;
        b=mYnMx9LjZK4YSU1AKc+6hEzUN1zng7oWtj8igtFglsEpfmJMhHfaeo0l0FmvnJWH1t
         nrBW1MlUjH0dqWxbIUTTIfD1vHVKl71rjU6Njy3V/oudL/9iRqU+pYTCq3T7BCvZVrZ4
         SBlGtqjcDqMqbsxGOLPjso7WWzVdDna+AtZ2WkwhPXvePCW7LakYLIE7RU/7FbvmGmFy
         F/KsGKe6iJ/FiQguWypCvuKIeFjAV9h7C25RZey7HiXHCz+vOLaqPKkqRIHy4cxcdMza
         Zmrjr7ogEgaUqw6CSKFmxNYoL4z8kce/t61uandFO0wIeU5hZBvZm6sxfRtzYN7P+0vS
         9PMg==
X-Forwarded-Encrypted: i=1; AJvYcCW/cF68RLUD7Okxe8XNHvYqrUSMwOmLF1Qbd8ylwDb34t4a5Jr4lKePtWe5PucZeQMmqxiNJtAsUFJi3aM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaRWgmALvNQh6pztuClAHV63Rfnx8hGURBI2gUkvEa7gD/Vpkp
	yIxBVTjDm1A3VpCKj6acws5FRSFF2C76YpwYjwV2+4y28KWMLxk0H/K/eyFRBCU7KkLScdy6xr+
	ZC908v6I6Det3r4brVTI3rmcuBNw6CZ5kMAQaVN1cWh89QvLrBVz5XVXBI49oG8vtZUc=
X-Gm-Gg: ASbGncssYgPEu4H5pcDC3Gto4qZP51NoE3Ff5Bo3HJ7v92d2w6x9GGAYLvb6P2PIypz
	bZnmIkR6Ls+YKMskH85chJ5+YpQXYxiFEIWLvCyqbSBQV10LB6p85r5LZCFI+Esc3kK0kV8h3XB
	XjMx1of1CyH9t0TyKLE/2jbZVM8S5y1889RajKZbR6oFcGLE7YT8lVfrt+W0lhu1A78pEhLp5Ri
	j/bMTtxMOkvtSf8U/wDOyRxU6NgIAVs6RYz/HypYR9ydzzEJzXt09rsuO2i56RpSp5/WRxYC9kV
	luDEEErGX3z6+VWBTL9e6FRgme/b7b1bgUFRt7Z0b2gSt+xNPY1ROvs/V86fTq2fp2ZLXxklVbh
	7QuluesfCkz2uVaCc5kw=
X-Received: by 2002:a17:902:fc4c:b0:242:9bca:863c with SMTP id d9443c01a7336-242fc38a0f1mr34907785ad.54.1754987880444;
        Tue, 12 Aug 2025 01:38:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGnaHE1ZpiwMNn4UsN08f5Kfog+omLIJ5L0j2dBUjCm2KGFIcXRJMShYCrtbagzF0cmN8OXg==
X-Received: by 2002:a17:902:fc4c:b0:242:9bca:863c with SMTP id d9443c01a7336-242fc38a0f1mr34907345ad.54.1754987879947;
        Tue, 12 Aug 2025 01:37:59 -0700 (PDT)
Received: from jiegan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-243086849b3sm1915345ad.175.2025.08.12.01.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 01:37:59 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Jie Gan <quic_jiegan@quicinc.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 4/9] coresight: tmc: add create/clean functions for etr_buf_list
Date: Tue, 12 Aug 2025 16:37:26 +0800
Message-Id: <20250812083731.549-5-jie.gan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812083731.549-1-jie.gan@oss.qualcomm.com>
References: <20250812083731.549-1-jie.gan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNyBTYWx0ZWRfX7TygWbVfA4Eu
 UDQmt14bkKmj0fnPt/H8GFNU7coP9O1gA7PA96lLXJU1I9+4mxfnmctQhcRVnqax+8O/IjgNPBn
 sLNGd3DczgZDMJuJlFaqtNMGilP9fa3DtarA+amJGwvklbTovUEtTaYXKtT3pmOlGiY7r1vl3dk
 rMRhTI4lmVHYfegshmBJRyAOzuN47VxsGZg0oLlvnKQqtvuUHWBMHyUkrda3ehcdBfUwWgtsqeU
 j1BPwRD2eNKs+ssyTrB7VtrUYgIMiLDARqw4jUqq5EI8VSa8qpeO3blH0rO5AxIpufJAtP7e+re
 F7HYHGjihkDktBgeFyOIeDmk6B0m5uFDGXgjpRb3fPvyoVHB+vNkNK1qiQTzlxuoOimjWnAsf7E
 mSgg8YgL
X-Authority-Analysis: v=2.4 cv=fvDcZE4f c=1 sm=1 tr=0 ts=689afd69 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=HgEQyz239O5rJIWi_rYA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: jFRwCXqe90RIHD40JM34BoD2WTXu_Bhm
X-Proofpoint-GUID: jFRwCXqe90RIHD40JM34BoD2WTXu_Bhm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090027

Create and insert or remove the etr_buf_node to/from the etr_buf_list.

Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 .../hwtracing/coresight/coresight-tmc-etr.c   | 94 +++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tmc.h   |  2 +
 2 files changed, 96 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index b07fcdb3fe1a..ed15991b3217 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1909,6 +1909,100 @@ const struct coresight_ops tmc_etr_cs_ops = {
 	.panic_ops	= &tmc_etr_sync_ops,
 };
 
+/**
+ * tmc_clean_etr_buf_list - clean the etr_buf_list.
+ * @drvdata:	driver data of the TMC device.
+ *
+ * Remove the allocated node from the list and free the extra buffer.
+ */
+void tmc_clean_etr_buf_list(struct tmc_drvdata *drvdata)
+{
+	struct etr_buf_node *nd, *next;
+
+	list_for_each_entry_safe(nd, next, &drvdata->etr_buf_list, node) {
+		if (nd->sysfs_buf == drvdata->sysfs_buf) {
+			if (coresight_get_mode(drvdata->csdev) == CS_MODE_DISABLED) {
+				drvdata->sysfs_buf = NULL;
+				tmc_free_etr_buf(nd->sysfs_buf);
+				nd->sysfs_buf = NULL;
+			}
+			list_del(&nd->node);
+			kfree(nd);
+		} else {
+			/* Free allocated buffers which are not utilized by ETR */
+			list_del(&nd->node);
+			tmc_free_etr_buf(nd->sysfs_buf);
+			nd->sysfs_buf = NULL;
+			kfree(nd);
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(tmc_clean_etr_buf_list);
+
+/**
+ * tmc_create_etr_buf_list - create a list to manage the etr_buf_node.
+ * @drvdata:	driver data of the TMC device.
+ * @num_nodes:	number of nodes want to create with the list.
+ *
+ * Return 0 upon success and return the error number if fail.
+ */
+int tmc_create_etr_buf_list(struct tmc_drvdata *drvdata, int num_nodes)
+{
+	struct etr_buf_node *new_node;
+	struct etr_buf *sysfs_buf;
+	int i = 0, ret = 0;
+
+	/* We dont need a list if there is only one node */
+	if (num_nodes < 2)
+		return -EINVAL;
+
+	/* We expect that sysfs_buf in drvdata has already been allocated. */
+	if (drvdata->sysfs_buf) {
+		/* Directly insert the allocated sysfs_buf into the list first */
+		new_node = kzalloc(sizeof(struct etr_buf_node), GFP_KERNEL);
+		if (IS_ERR(new_node))
+			return PTR_ERR(new_node);
+
+		new_node->sysfs_buf = drvdata->sysfs_buf;
+		new_node->is_free = false;
+		list_add(&new_node->node, &drvdata->etr_buf_list);
+		i++;
+	}
+
+	while (i < num_nodes) {
+		new_node = kzalloc(sizeof(struct etr_buf_node), GFP_KERNEL);
+		if (IS_ERR(new_node)) {
+			ret = PTR_ERR(new_node);
+			break;
+		}
+
+		sysfs_buf = tmc_alloc_etr_buf(drvdata, drvdata->size, 0, cpu_to_node(0), NULL);
+		if (IS_ERR(sysfs_buf)) {
+			kfree(new_node);
+			ret = PTR_ERR(new_node);
+			break;
+		}
+
+		/* We dont have a available sysfs_buf in drvdata, setup one */
+		if (!drvdata->sysfs_buf) {
+			drvdata->sysfs_buf = sysfs_buf;
+			new_node->is_free = false;
+		} else
+			new_node->is_free = true;
+
+		new_node->sysfs_buf = sysfs_buf;
+		list_add(&new_node->node, &drvdata->etr_buf_list);
+		i++;
+	}
+
+	/* Clean the list if there is an error */
+	if (ret)
+		tmc_clean_etr_buf_list(drvdata);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tmc_create_etr_buf_list);
+
 int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
 {
 	int ret = 0;
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 292e25d82b62..ca0cba860d5f 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -459,5 +459,7 @@ void tmc_etr_remove_catu_ops(void);
 struct etr_buf *tmc_etr_get_buffer(struct coresight_device *csdev,
 				   enum cs_mode mode, void *data);
 extern const struct attribute_group coresight_etr_group;
+void tmc_clean_etr_buf_list(struct tmc_drvdata *drvdata);
+int tmc_create_etr_buf_list(struct tmc_drvdata *drvdata, int num_nodes);
 
 #endif
-- 
2.34.1


