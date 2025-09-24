Return-Path: <linux-kernel+bounces-831453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 561F3B9CB56
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B105424070
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B202BD5AF;
	Wed, 24 Sep 2025 23:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yg0f5uth"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183FC1A9FA8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758757607; cv=none; b=aGRVq3uvu4QTusRLKSkd6CKyzmR86D37ByHT/CFg4BkrcWQRKKiVtsQtLH9Urb8emkj6hH1xw49LfRemu7kahjc5L1S7Pkx1N7sUZ0Z+8mW/54THJqt/n5VSnogVMUv20mc3ecZP9FNAhb50fA2Lbfk9QFFXZW+hhs27UEoYLUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758757607; c=relaxed/simple;
	bh=g2/3CXxFWBOUXC2gO/bz9GIepGtcpyazIhkgkbnJiO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IdULc3nVVv/3TpTBZWX7wcwmhVJ+IyVA8BUrtyqIIC3xLFLAkIXuZfiCmRMYGqu1L/175MWq45dvqumSAfMq6Enq5Gyg56RKFXZQmzhNqfqpAHajEdn/2aEbrDqYWJv8YhnMA4NmSvWiEXJzaJUt/XsTOKUqjqaX83dVhsddBrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yg0f5uth; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCKSaU025366
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:46:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qV9ItHEjUJjFkqDNpm9AeYOsqDGDG7ItIfgn6ExfwT4=; b=Yg0f5uthwx6AaL/P
	P7cs8rJ5XpNB5ycMU3Tp7LmY20kT0I6puAV9yO0T6NaO1O2+4/tT4Uu+vRfjh7Ql
	305dn67StXGN26L4R/eEQbckvVR2EDueWByB7aDDxlYiyNOvSjVzcxwaCWoA85h5
	8y1tP+FYqahZCajiPZ4WO34mVEkcS7/3PXxAE/P13h5qxy8OqsI4QiDkwf2DG+1G
	zi4Z0Vy1Q281nR9iPJ3m3g0PTv4F/G8JknKwgQkzvV3XbYm/QsT43hNZ93e8tklO
	P8+ZwzjnSVzL/QjRlsestfTTb7wdF1FHchMg8s1eQ3WxHlfXF+4xN4jdXPHZdb2K
	AuGTHA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyexd49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:46:45 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-268149e1c28so3284705ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:46:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758757604; x=1759362404;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qV9ItHEjUJjFkqDNpm9AeYOsqDGDG7ItIfgn6ExfwT4=;
        b=daCdR8AEj21tAGws6biN89GpYZCy8kIhXdd95CTefINmYbxUgL9LEisqW5Rt/ly01I
         JzRcI5KdXMRzcII7/qKOBjvE+B/Po671pa787GrigWq0FLUZAA65ZzrF8j6DwG997clz
         bM/Fcr3ZHJAh26ybEgz7N0pM6/XPb83nv4m0v4RU0wzmXDt5+E/D5Oqc9DtgfPYdTguO
         z29e8L4xM+ih4dQ7SizCAyi2Fy1RXogv27AuKD0gAp7jTMVhfH+HdQ/0Z/rnhhfD5Fjg
         6u7h56UQpof9J//hDS3hq5kIfHrkWS3EAby5AD9LfmrsODXYPZTc4DddEod7jsgxDsPM
         a+7w==
X-Forwarded-Encrypted: i=1; AJvYcCWhwQxp/xYr+cZXF0P+rGsL8Lx+ytzVnhL4oty6Y/3XqNoTua5+q2tiS8zWTBXhksjYcA1NeTQlCKWnmuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJuzlvuSzGFF2QRP+0ZQwbJ66zo7pDId64noNt98FHqyCqXQ6L
	7WlwFbJKiPjkLrskh2l+AZ7DukfuasagrEbiXG/ikZHkIhF422rpiMFkBFRPCBrKEmGhH3bAiIw
	qyp6cro6CmN70yTS70VlGh+RaFIIwxWeeMbpw1nIadSlaF3P0DRT/GL+4UwlBxEG4liI=
X-Gm-Gg: ASbGnctutK34cYFkW6gNJOBszd3ByuP3N17Ew1bcm0SnTT7wlgJrENSNUjpgP5Ook9r
	O2II+8J95+41DMvyaNBxHg8P50v3+imTcQFJeK2HUWaevrnn5ltgJqxRPYPQFkt0t5xKmwGwdk7
	mfQNRZzlUZW+/zZGYkT9M4DwwBwgsiL48dlZVULtdgIxH7C4QtLVe/yjTC1FIzmnd7JIuTmPZTt
	hc0IUvBoiQJ5JLilC/hufk5HoxAMdBPQvAmq1p/5xaQJ0UPIkOncyzBqZ3zWgHGtyt+5wieXLRR
	4svoolC7dSVcdmnK1u7Uy1b/nWP+YRrPO1BTN1z6CpUU+MVvwz4duDVSrfbBbPhX5/GWzCo4/pQ
	C6LD2TTc7T/tVNrs=
X-Received: by 2002:a17:902:f549:b0:264:ee2:c3f5 with SMTP id d9443c01a7336-27ed49d5b3cmr14796545ad.19.1758757604047;
        Wed, 24 Sep 2025 16:46:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOMv8i7DNIHjAdTVSla7dHPR+o+BJeTxoyB6uM935XGng2Q0Dmiyk/mferG3jgoimXPzgtug==
X-Received: by 2002:a17:902:f549:b0:264:ee2:c3f5 with SMTP id d9443c01a7336-27ed49d5b3cmr14796295ad.19.1758757603597;
        Wed, 24 Sep 2025 16:46:43 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69959e1sm4318405ad.103.2025.09.24.16.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:46:43 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:46:36 -0700
Subject: [PATCH 1/2] misc: fastrpc: Add support for new DSP IOVA formatting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-fastrpc-v1-1-4b40f8bfce1d@oss.qualcomm.com>
References: <20250924-knp-fastrpc-v1-0-4b40f8bfce1d@oss.qualcomm.com>
In-Reply-To: <20250924-knp-fastrpc-v1-0-4b40f8bfce1d@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Kumari Pallavi <kumari.pallavi@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758757601; l=6515;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=S19jilbj7iYbywe2b8F10V99zSDUKUvU/DzMK/hBxow=;
 b=DNgEpFTgVe2sbcpunAFV7X15WOVL8mlV92KXOkA9sPgNknw1oVLYtjduNcqerSSD9T2lZUNFL
 djxGIULhiihDKYeMkFhhf9WjhZUOH0Ygh/l/vrUOYmsJWO8A+K2Bspn
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: Av1Iqd7wrUc4RUCyrBOj8vYCaRL1MNrp
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68d482e5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=SMfjFN7pHoWw_NirdsAA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfXwFhO/MHDbazt
 6gzP90c4GjLGdKG4ALlyL+05v6lcubytubBkJ4wgha5HFkFfN38bb09rIm0TqyfZ2DW4Sfj7IvC
 yTkcMUol8ZE9lYMtWT+61W+rYNzBblttOdo3jtvFqkzmBagmumwDhoH1xKhJheETscAEdfXw2Eq
 ltdIvS8PlUnYjWOmvQww/U3jZMSrkbuA59spP9P31uEcjBKlFWOYR2eoKQ0DBxJ1WsLmqwyaAao
 rW7JtlSL7dG/nZdEvX+8O3JN+PWi+AHdNetMpZOjnq8oJWNdIcauKPXOeSE5QGre+RJG3AkHvxV
 SKtN/UoF3FfU9hjn2qKsVt6bCJaONfrKPmJ+Q94HLa0jmcV1loUH6bvzsyb096S7HTtxRtH0YgX
 H7XV44Pl
X-Proofpoint-ORIG-GUID: Av1Iqd7wrUc4RUCyrBOj8vYCaRL1MNrp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004

From: Kumari Pallavi <kumari.pallavi@oss.qualcomm.com>

Implement the new IOVA formatting required by the DSP architecture change
on Kaanapali SoC. Place the SID for DSP DMA transactions at bit 56 in the
physical address. This placement is necessary for the DSPs to correctly
identify streams and operate as intended.
To address this, add an iova-format flag which determines the SID position
within the physical address. Set SID position to bit 56 when iova_format
is enabled; otherwise, default to legacy 32-bit placement.
Initialize the flag to 0 and update to 1 based on SoC-specific compatible
string from the root node.
This change ensures consistent SID placement across DSPs.

Signed-off-by: Kumari Pallavi <kumari.pallavi@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 76 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 68 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 8e1d97873423..db396241b8ce 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -33,7 +33,6 @@
 #define FASTRPC_ALIGN		128
 #define FASTRPC_MAX_FDLIST	16
 #define FASTRPC_MAX_CRCLIST	64
-#define FASTRPC_PHYS(p)	((p) & 0xffffffff)
 #define FASTRPC_CTX_MAX (256)
 #define FASTRPC_INIT_HANDLE	1
 #define FASTRPC_DSP_UTILITIES_HANDLE	2
@@ -105,6 +104,26 @@
 
 #define miscdev_to_fdevice(d) container_of(d, struct fastrpc_device, miscdev)
 
+/*
+ * By default, the sid will be prepended adjacent to smmu pa before sending
+ * to DSP. But if the compatible Soc found at root node specifies the new
+ * addressing format to handle pa's of longer widths, then the sid will be
+ * prepended at the position specified in this macro.
+ */
+#define SID_POS_IN_IOVA 56
+
+/* Default width of pa bus from dsp */
+#define DSP_DEFAULT_BUS_WIDTH 32
+
+/* Extract smmu pa from consolidated iova */
+#define IOVA_TO_PHYS(iova, sid_pos) (iova & ((1ULL << sid_pos) - 1ULL))
+
+/*
+ * Prepare the consolidated iova to send to dsp by prepending the sid
+ * to smmu pa at the appropriate position
+ */
+#define IOVA_FROM_SID_PA(sid, phys, sid_pos) (phys += sid << sid_pos)
+
 struct fastrpc_phy_page {
 	u64 addr;		/* physical address */
 	u64 size;		/* size of contiguous region */
@@ -255,6 +274,7 @@ struct fastrpc_session_ctx {
 	int sid;
 	bool used;
 	bool valid;
+	u32 sid_pos;
 };
 
 struct fastrpc_channel_ctx {
@@ -278,6 +298,7 @@ struct fastrpc_channel_ctx {
 	bool secure;
 	bool unsigned_support;
 	u64 dma_mask;
+	u32 iova_format;
 };
 
 struct fastrpc_device {
@@ -391,8 +412,11 @@ static int fastrpc_map_lookup(struct fastrpc_user *fl, int fd,
 
 static void fastrpc_buf_free(struct fastrpc_buf *buf)
 {
+	uint32_t sid_pos = (buf->fl->sctx ? buf->fl->sctx->sid_pos :
+					    DSP_DEFAULT_BUS_WIDTH);
+
 	dma_free_coherent(buf->dev, buf->size, buf->virt,
-			  FASTRPC_PHYS(buf->phys));
+			  IOVA_TO_PHYS(buf->phys, sid_pos));
 	kfree(buf);
 }
 
@@ -442,7 +466,7 @@ static int fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
 	buf = *obuf;
 
 	if (fl->sctx && fl->sctx->sid)
-		buf->phys += ((u64)fl->sctx->sid << 32);
+		IOVA_FROM_SID_PA((u64)fl->sctx->sid, buf->phys, fl->sctx->sid_pos);
 
 	return 0;
 }
@@ -687,7 +711,8 @@ static int fastrpc_dma_buf_attach(struct dma_buf *dmabuf,
 		return -ENOMEM;
 
 	ret = dma_get_sgtable(buffer->dev, &a->sgt, buffer->virt,
-			      FASTRPC_PHYS(buffer->phys), buffer->size);
+			      IOVA_TO_PHYS(buffer->phys, buffer->fl->sctx->sid_pos),
+			      buffer->size);
 	if (ret < 0) {
 		dev_err(buffer->dev, "failed to get scatterlist from DMA API\n");
 		kfree(a);
@@ -736,7 +761,7 @@ static int fastrpc_mmap(struct dma_buf *dmabuf,
 	dma_resv_assert_held(dmabuf->resv);
 
 	return dma_mmap_coherent(buf->dev, vma, buf->virt,
-				 FASTRPC_PHYS(buf->phys), size);
+				 IOVA_TO_PHYS(buf->phys, buf->fl->sctx->sid_pos), size);
 }
 
 static const struct dma_buf_ops fastrpc_dma_buf_ops = {
@@ -793,7 +818,8 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 		map->phys = sg_phys(map->table->sgl);
 	} else {
 		map->phys = sg_dma_address(map->table->sgl);
-		map->phys += ((u64)fl->sctx->sid << 32);
+		IOVA_FROM_SID_PA((u64)fl->sctx->sid, map->phys,
+				 fl->sctx->sid_pos);
 	}
 	map->size = len;
 	map->va = sg_virt(map->table->sgl);
@@ -2153,11 +2179,14 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
 	sess->used = false;
 	sess->valid = true;
 	sess->dev = dev;
-	dev_set_drvdata(dev, sess);
+	/* Configure where sid will be prepended to pa */
+	sess->sid_pos =
+		(cctx->iova_format ? SID_POS_IN_IOVA : DSP_DEFAULT_BUS_WIDTH);
 
 	if (of_property_read_u32(dev->of_node, "reg", &sess->sid))
 		dev_info(dev, "FastRPC Session ID not specified in DT\n");
 
+	dev_set_drvdata(dev, sess);
 	if (sessions > 0) {
 		struct fastrpc_session_ctx *dup_sess;
 
@@ -2256,6 +2285,19 @@ static int fastrpc_get_domain_id(const char *domain)
 	return -EINVAL;
 }
 
+struct fastrpc_soc_data {
+	u32 dsp_iova_format;
+};
+
+static const struct fastrpc_soc_data kaanapali_soc_data = {
+	.dsp_iova_format = 1,
+};
+
+static const struct of_device_id qcom_soc_match_table[] = {
+	{ .compatible = "qcom,kaanapali", .data = &kaanapali_soc_data },
+	{},
+};
+
 static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 {
 	struct device *rdev = &rpdev->dev;
@@ -2264,6 +2306,23 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	const char *domain;
 	bool secure_dsp;
 	unsigned int vmids[FASTRPC_MAX_VMIDS];
+	struct device_node *root;
+	const struct of_device_id *match;
+	const struct fastrpc_soc_data *soc_data = NULL;
+	u32 iova_format = 0;
+
+	root = of_find_node_by_path("/");
+	if (!root)
+		return -ENODEV;
+
+	match = of_match_node(qcom_soc_match_table, root);
+	of_node_put(root);
+	if (!match || !match->data) {
+		dev_dbg(rdev, "no compatible SoC found at root node\n");
+	} else {
+		soc_data = match->data;
+		iova_format = soc_data->dsp_iova_format;
+	}
 
 	err = of_property_read_string(rdev->of_node, "label", &domain);
 	if (err) {
@@ -2343,7 +2402,8 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		err = -EINVAL;
 		goto err_free_data;
 	}
-
+	/* determine where sid needs to be prepended to pa based on iova_format */
+	data->iova_format = iova_format;
 	kref_init(&data->refcount);
 
 	dev_set_drvdata(&rpdev->dev, data);

-- 
2.25.1


