Return-Path: <linux-kernel+bounces-849976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B03ABD1849
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 07:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE5FA4E4296
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 05:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0595D2DE71E;
	Mon, 13 Oct 2025 05:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L7M9vKm3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD7D2DEA7B
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760334600; cv=none; b=X3/mdJfwY/I4tSQA87ZsrIx3ygiJTVBllFRqGj/9osn5+vJ83X9wVcAjKc7t47bHtgIxYrQaYTyKhNrr5pEtBE8ob+j9uMVl9cJrA6FX4ikPktCiB2tjUOEHRKXUluH/tHmTnXEAO4y2ybCOaNGlRupPj4U4eVtKH4ooNjA1deA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760334600; c=relaxed/simple;
	bh=L4bB/4x9HRGWluep/4LcqZEwsWYNFYbPF6SpnxWAKBg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=niAl5RGXuHOlMx0Rec7TvVtK4bSLK1v5gDhzj2yWC6+EpCKf+Vw1nOZS/D81OV9RWLy1/7kuuDZ+O95Ol6liBkinmNTGdVdp4qeIkuiEg7pMnmtwOyjh3ZG2/2aEfVeRD2yOjolz/JXW4xckhEHpvacIE834P0ipDbrEBzOTOyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L7M9vKm3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D4pF6I020190
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:49:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aYcq8RLq3GEaww9PDCIrz1x+sabd6SzQwWj1jmTGFa8=; b=L7M9vKm3cLrNv08R
	1/VekvKguheOHvohgBD6dEOGXH/aUf4ZolDD1AIwmnXQfUoayK16pAoE0XWlrydS
	MJTFtq3wXwziCFMVXxUl7rpId4JjOLpC9yKOV9jewd6DJAqhERzMCFqp5Mb9Yo5e
	IlSfa/462SEQ3lwkCAiFhBvQYqmR4w/zykaT+KqQViLsLc6VDP0K/A91AZ0ACwMU
	Me2AWp9AhxDJcmJJGw0MS0w/LjVQCy3ukTAh/Pw5SK2IZKO2ZTLOeux6brBOBmV7
	Aav7mAJXYkBqkcXlR/LYuZhWogO0YmQ7WGtgSBA2LdPgUjSgxwT+TJvKGpTVO5Md
	94/onA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rtrt03u9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:49:57 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so7323958a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 22:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760334596; x=1760939396;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aYcq8RLq3GEaww9PDCIrz1x+sabd6SzQwWj1jmTGFa8=;
        b=Mbpqb6lV586itxYG54563gkJV44YmJAzEUXKMmHYPyDtd5qWU83ZFz+aJiPJUGGX95
         S0gvAcIyeFAfjS4C1tG0RGj6HVHrTy2BweQ+g5dk6jKW3VgnFasK2IeBdjVaaHCtnNvB
         tBlQb+AN2aMw6Th1WeIRQ78bXXGjUYPQ3mMZmdFzGZ7xw87g5dhb4NEsg0fnIhK8rYJi
         VwQJ2cj9whFrbOKLozBdQA9QpMVLeNRAdOssg/Y+OfBRZUIJHzWGAM9vquehvJU71x6l
         jj2f6dSPBMDo17m52ErIc7mfgIDRFMeKQRXJmRJCaGG7S+pTKq2tG7FkfRBXG7QSYCaG
         Lxzg==
X-Forwarded-Encrypted: i=1; AJvYcCXN+5o4Bu7KYhTysy+h60FkSBe8JdVFO9HStb5x8SGlY2pKR4033dpkxzCq5dje03scPR0npCLRQqkzHUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuqghj1n/coCxXcd5y2LIhI0n0JWSUO2wL8uk8GDGc/P1cJV0Y
	hyPgKKG1r5g6ZrD+BDwV3Vrkewvwiy/Xvy6uYUvYJuGG7ZZbhXgefK1PWaWs1GpeE+L0efI5E0K
	qxk10ePv2h5LM27AHtZnvEBJchieax1iWf4MAGnmKRFBEc+U3myHyBNACVUtPYyqUUQ0=
X-Gm-Gg: ASbGnct5eL2b9xl5E4+Jp1Hzke21UGjO/Qv/UwztWg2njcwimL925vn5ph2MJYW/NWq
	ygD0qx1+w2MQu8t7Pivoc9sjSzoCNsT/AA5hEMXLOIQ1tHPIbPWPo2wSKRU13pQTaSjX1dzenwc
	FhlIzyVhPWM05MKySF8VJJ0tO6BdD55xyRijSsBaRwjr9CBKFtqcx8rRLtpubf4IpYmJ8y8bK0W
	2rPE7TPeiaV1y7YUrRjuDnp2ly1fDlDuFqU5Jjn5LUfeJEjsQjzEaD/dZLjl3Ru/KHKUIMWfUVH
	YaU05gbXEu2ATmyhIwWEd3/lZS2kV/O+JYfNgOA3SjTRM3jvOvfMgOs40WFxu/xzxzKNvER91lt
	Pa+yT3SgxnT/ex5TdEghcPjbC9kk=
X-Received: by 2002:a05:6a20:7286:b0:249:ba7b:e361 with SMTP id adf61e73a8af0-32da8511961mr27030237637.49.1760334595846;
        Sun, 12 Oct 2025 22:49:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7LvePajPfCGBrDB3UBpDITIFqXGX2Q3RL9cwCvFyt4LKIBynMkXTnqxbMSG5t5Ee+JQLwOQ==
X-Received: by 2002:a05:6a20:7286:b0:249:ba7b:e361 with SMTP id adf61e73a8af0-32da8511961mr27030214637.49.1760334595339;
        Sun, 12 Oct 2025 22:49:55 -0700 (PDT)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e1336sm10129898b3a.59.2025.10.12.22.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 22:49:55 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 13:49:13 +0800
Subject: [PATCH v7 4/9] coresight: tmc: add create/clean functions for
 etr_buf_list
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-enable-byte-cntr-for-ctcu-v7-4-e1e8f41e15dd@oss.qualcomm.com>
References: <20251013-enable-byte-cntr-for-ctcu-v7-0-e1e8f41e15dd@oss.qualcomm.com>
In-Reply-To: <20251013-enable-byte-cntr-for-ctcu-v7-0-e1e8f41e15dd@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
        Mao Jinlong <jinlong.mao@oss.qualcomm.com>,
        Jie Gan <quic_jiegan@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Jie Gan <jie.gan@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760334567; l=4084;
 i=jie.gan@oss.qualcomm.com; s=20250909; h=from:subject:message-id;
 bh=L4bB/4x9HRGWluep/4LcqZEwsWYNFYbPF6SpnxWAKBg=;
 b=hKsJBah/TFS6zLR53QjFr/ajQFFUd4v2fpkqyLlBaw5PA4yQViDQwvJ+UgUySjQUjd0rlOaLB
 XPLMactZz6nB1gij1laeF985/O8gBYK4dbrq5AZy0GsiMJLZgSa99iE
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=3LxxUZRPCNkvPDlWOvXfJNqNO4SfGdy3eghMb8puHuk=
X-Proofpoint-ORIG-GUID: 3BXN3e8fJKQjErl9pozXn3c8VVVyjHUV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAyMiBTYWx0ZWRfX4qKeqo76Xgj6
 5+EYGz/tPZGhIslMhbkH5x0j7qakqvUf7D/dyGtVB1aSoDozhNChhKgczJwuONjTTp6/x44t6vE
 sDIS9tM2j0mGc7GL7VwUdjkyoJK34gjriLs6QK89tQKSL169cDOqsaGfEPbtcoNF0kiYnSKNkQc
 z4IL62Uiq1BcarzYzWN79YIXcRpCb2STNN7+ZPYrV7+K9cn1lMHBl7menuLrAFuGOJBglt4wS+9
 UMRZmMsdK6at98JqGf8p1HnlOtYqsvgGDHJAs2nkSDhVJSp2zWqb3Opt9QyYjx5HczbX9L4l2E2
 /WdUHQBlSe7OzJn9YHBUhAN5O05aZtSKATwvS6Wpt8sBV36ZKBN84QXq8ti0n2PXrv1H+8izscn
 WRSCRYNSLhendjD+x/o/LOJHWJt+2Q==
X-Authority-Analysis: v=2.4 cv=SfD6t/Ru c=1 sm=1 tr=0 ts=68ec9305 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=iCabL5HRm4xHoUrnq98A:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: 3BXN3e8fJKQjErl9pozXn3c8VVVyjHUV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130022

Create and insert or remove the etr_buf_node to/from the etr_buf_list.

Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 94 +++++++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tmc.h     |  2 +
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
index 3a6484998530..4bfb3db44482 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -461,5 +461,7 @@ void tmc_etr_remove_catu_ops(void);
 struct etr_buf *tmc_etr_get_buffer(struct coresight_device *csdev,
 				   enum cs_mode mode, void *data);
 extern const struct attribute_group coresight_etr_group;
+void tmc_clean_etr_buf_list(struct tmc_drvdata *drvdata);
+int tmc_create_etr_buf_list(struct tmc_drvdata *drvdata, int num_nodes);
 
 #endif

-- 
2.34.1


