Return-Path: <linux-kernel+bounces-804960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 548C7B48267
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 04:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10141795BA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 02:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883361E32B9;
	Mon,  8 Sep 2025 02:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QwrBeEeg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C610721CA0E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 02:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757296971; cv=none; b=a6fS6FWXU5jk0tQ9/a2dHVEMSud/0QoZztZKOn4acb4CTzGYfrHDGSYulcczXKAOvJZyOTJV7kotS0yO9BrVVbHSx6ozAnHT1RJi1/BMKousL66EytO5MRcc8ysLfxrQHbzr3iEqu7EJHefebSQaM83sNXlAHFVnQnswuAwf+zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757296971; c=relaxed/simple;
	bh=9ZOyPv6bhMLRODUqaJ5ztJAwxo4d0yjUaaXYVxTCAts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X5H8yTCOyg/POaXrMLVIxFDXsI9SOczO9ezGhsLJGlYQAAw1CCwrh8p4GBKvDXfyHKPDhY0AfwwUQbgP8eBirQb4QopzOjbMH8eFiP5qOq4LS1XFjbOG9wNjSXEpFb0qxxLK0z+QEgMIfEvfxvVLEZ7vAFpqiAYTdV4tWgmoRZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QwrBeEeg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587LwKRi020507
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 02:02:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Sa1G+6fQ53tFpugkuIt/tI8SnQtTsLjqcg2Jm4DIfOQ=; b=QwrBeEegAs9RlE3n
	Md82rc2JVOOIPmeqSrHxqcWm/Ou/cYbUrlkMW2/oVBhgPo3loP31DiAhm4J0Ljc5
	TLdCW6k3FAkkDTHMbzK/a0ixRTzpErrs32YeiQVdZi3LzZGVM+Xw8sLdO5aSctOQ
	fXD2iFRexTZSqq3dF7cQLgVaHme9TYK0qPA1n8cqdy/CyoVGelVh3bxGHUiCVb41
	7nHrAoXBnNtmmyjxjqd7r6IHjBSmafSNcs9lYoZV7OdO5ElsCSJ7G7hzLLdUH/FI
	iCANYapDTbmNM53F9IVh3yf8iFMExfhFbv7HmX+m29mwzJm8PIIor0cuEvOHJUPs
	TIYr6A==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490d1vaxtb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 02:02:47 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7742e89771eso1298498b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 19:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757296966; x=1757901766;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sa1G+6fQ53tFpugkuIt/tI8SnQtTsLjqcg2Jm4DIfOQ=;
        b=RGbbB4b4dyvTtQlrTm4d3f6mEJ46hIHnJVx7nnsZkrk143uSS9h8CeMKgqirrS8dew
         GH32FOIeK+M0lOpdpOnyePubrSYaXcie+wOY2G3om20aJlUr6+yW8n+UNcCOR3EIsWns
         HXIB2zquvscBGVgZaXgK+dtGDyFqbuidWolx5x/y7WcWHvyMkYx2EUMLNACw0A2tmxcJ
         v1W7wXlDJTK6WMLAxt8n6p1ODJRQxDghffXY13fNkJzkTRmifhY6lI3jGeMokUPAFo38
         EaBiPvt7BxeCr35+fYFd1QuiTgfqNlnPfhTS06+aYDv6CX+a3ZAr8SrBPeRnIOGgmUh+
         /epQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnxLBbDYXDUGGY/TAKRDoUNXrQM4MimL0JXyCYjrurGlNAQN4ym9/XC+yN/cvfpwp7KzhXk6kHupFXM0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwML8jv8T7aZH+BvUBstpKPqEP4bADeR+jQhABdmY5+3OTqr8zu
	tloxLt0tD/0NlRk/ggdgjyke/sAM6mt1SUWxUtBdOmJfKvI9BlXXXmw/RgXNVAVEEDS0fyOAPEk
	PIG9ybP/g/18EGHMeq0jKmm/RQ2XWjyg1qF9olO2JiP6EnWAxexJdI7NAHUKTWhF7KDE=
X-Gm-Gg: ASbGnctUirP3eNIwVFGK82yxSIk23iuLCf9LVgw53Zyr3iUpdnSHY83YkseguSRdXzr
	IMRnhOHIGrxU4A690x1n4oE9jcigIF6oNuzfDm+6NdxcKUiM6fIQA6C3P8mrT3gbhoBoIxTNmeF
	AFOluRCk7yx7yH2XBBwuNlNqKBDHhj93TTvq89q2tVKETHdwegQbyOvRWYOwsF99jVM3XK/rO/M
	NPbi8O/zrP4E/cboL/6RsrTdWXtGsxJy16tFed3E3UCFePAv24EsWTCSeyHGhISf/7GEFD7dcky
	5II5mqcNVeDlIFumOIbpDUR0o6fj+fj/YH0RVKMD/yBpNeab+CjbpaIpd5gLOxTajQyQFeuR34n
	PqRyHeVci/1ej4+CDaVgXrd9/Jqo=
X-Received: by 2002:a05:6a00:4650:b0:771:e5f3:8840 with SMTP id d2e1a72fcca58-7742e4a0b84mr6365776b3a.13.1757296966311;
        Sun, 07 Sep 2025 19:02:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy9b5ueRmogyPXkCj4ZLin/RA5hSyK7llchgmHX3Cc/3cKAgWogXXGMxrbrLzv2ZohGQo4mQ==
X-Received: by 2002:a05:6a00:4650:b0:771:e5f3:8840 with SMTP id d2e1a72fcca58-7742e4a0b84mr6365735b3a.13.1757296965814;
        Sun, 07 Sep 2025 19:02:45 -0700 (PDT)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7723f4858e6sm24285076b3a.4.2025.09.07.19.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 19:02:45 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 10:01:56 +0800
Subject: [PATCH v6 4/9] coresight: tmc: add create/clean functions for
 etr_buf_list
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-enable-byte-cntr-for-tmc-v6-4-1db9e621441a@oss.qualcomm.com>
References: <20250908-enable-byte-cntr-for-tmc-v6-0-1db9e621441a@oss.qualcomm.com>
In-Reply-To: <20250908-enable-byte-cntr-for-tmc-v6-0-1db9e621441a@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Jinlong Mao <jinlong.mao@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Jie Gan <jie.gan@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757296940; l=4084;
 i=jie.gan@oss.qualcomm.com; s=20240927; h=from:subject:message-id;
 bh=9ZOyPv6bhMLRODUqaJ5ztJAwxo4d0yjUaaXYVxTCAts=;
 b=Ext6XQLN/vl2Miak4a6zi3Ok0V3h/UEyTz5zaNVhvOcLYXMtifEtk3eMxF/scd+Y50Uy8GxSf
 KSShG160avQD2blhk4TJzYjiKYrGLH/EM2PNXbqrQAafCaUfoSk3nWR
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=OZh7JyRifqJh4xmrcGgmwa8/LCS8O11Q+mtx4aZGmi4=
X-Proofpoint-ORIG-GUID: WX3IgAt_tvioqL1sw45XQx1OvEzWpsFB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNyBTYWx0ZWRfXwN7YFHnD3xx4
 ii1NZQ6rQvrC8f3CWW5WPLqdCkmMR/B8BiErZgzqBX6q+8sGf0FxudvH7mnJz24EbBM9AgM02YY
 d9IO6HtrBjEo1m3/z+n7qIF2xRjj+jJKNm+/4hScYRQ8HVcZ2d21Z+3bmfqU7LGP2dLTbuAqAh6
 HPOOmOB3rilTsStJFSg4EviqE1HyGQaBEBSQh99RUGynBs8AXnq8x9j9bMmRI3wKM7JNCX590AS
 Pkx7CdhS4VZiW77vIXI25ORHvNo7KpJeGf0BT4eS2PnENFZYBtFqv/soJh4PEBdpbq/OZHAmV4r
 A2pdN0Wp5Ebh9hnYTSyNF3HrGEuiw0+W9XDu2ihe7biqsd9h915VYbNIfLgWdyDzPGUa/1wwWAo
 wromBkhn
X-Authority-Analysis: v=2.4 cv=cYXSrmDM c=1 sm=1 tr=0 ts=68be3947 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=iCabL5HRm4xHoUrnq98A:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: WX3IgAt_tvioqL1sw45XQx1OvEzWpsFB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-07_10,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060027

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


