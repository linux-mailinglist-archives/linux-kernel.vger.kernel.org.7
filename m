Return-Path: <linux-kernel+bounces-880730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5CBC2668C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 928605601B8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CD93590D6;
	Fri, 31 Oct 2025 17:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="XnWPCe5/"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29A4322DD0
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931753; cv=none; b=KAqa88EGW+XjEFF2xwG/tWpqRD/e5C8uJyQ/quFB7Nd++rwsFDhh0J6QAX40T9vFvEnQF50wuCxDqYl1OSrfD3jdbdtzs9BVZ/+njIuBia5oK+eppkPSNT3j4tA16/88wSXwUdLLW/tHba8OFQCKG8i2ojD+BJXJ6np+xXpPlqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931753; c=relaxed/simple;
	bh=IHdpFNsikDjuT9BvG//eWRR5pi+hu/fq3ze+TMixXdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S5bve6Hau2SSiq3jj6489InlmVH8+WCwaUsZGTo4mBxZb08q0H0aMKvH8nTG106P3u3gr1R5k3h5pNlSzsjjSoeCBWsEUUCLEzkgDlk2rcAlvhUJIgeLq5DAF5VmWSiZLny0WQ6zvmG4yJNOGakqMaZJW7k8RymYjjO8vlfulsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=XnWPCe5/; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c69:314e:ee86:ae6e:30:9d13])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9769C1690;
	Fri, 31 Oct 2025 18:27:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1761931640;
	bh=IHdpFNsikDjuT9BvG//eWRR5pi+hu/fq3ze+TMixXdY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XnWPCe5/ePQcLPPtLmqvNtYKtS1yFi7KM5if6ekUiH0zYHDG1BHjOmYeCN6U6RvXg
	 bXAsDFBb7TmeqHkzPsql+i+t+ATN41F3MHHAwcRKCOHTSsjpcTjGR3oGjnupgQ5DcG
	 D1rfTObJzlDn8130tRh4QrPiSKVVXv1gCtu94ONQ=
From: Jai Luthra <jai.luthra@ideasonboard.com>
Date: Fri, 31 Oct 2025 22:57:32 +0530
Subject: [PATCH 12/13] platform/raspberrypi: vchiq-mmal: Add defines for
 mmal_es_format flags
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-b4-vc-sm-cma-v1-12-0dd5c0ec3f5c@ideasonboard.com>
References: <20251031-b4-vc-sm-cma-v1-0-0dd5c0ec3f5c@ideasonboard.com>
In-Reply-To: <20251031-b4-vc-sm-cma-v1-0-0dd5c0ec3f5c@ideasonboard.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 bcm-kernel-feedback-list@broadcom.com
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Phil Elwell <phil@raspberrypi.com>, Stefan Wahren <wahrenst@gmx.net>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Jai Luthra <jai.luthra@ideasonboard.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1474;
 i=jai.luthra@ideasonboard.com; h=from:subject:message-id;
 bh=LKyLKcaXyAoycbYitlV+AZbBL6EJIX9O3KqfvKd+VMo=;
 b=owEBbQKS/ZANAwAKAUPekfkkmnFFAcsmYgBpBPGfPbO6xE5RAvpayH40riclLISxDRq+Kjii6
 LATbX19oEKJAjMEAAEKAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCaQTxnwAKCRBD3pH5JJpx
 RaCyD/9e+AS8wk5pcH9fFNkvLtraQMxN7/XsU/IhBDzTjJJkN8ZUdt7lWtLWb6NyeAFgEvEwcCR
 xaNkMTcJ3czi7F5z8R+H5dK1UrgsIsisx1zRcx9cIRIUO4lm857yz9clw4H6s/DgoIVA4bJ568x
 NzmcF3tE/eglgMG8LZF4MpTkDXkPFr5e3OAhMc/fAsC4+/tRuj3KhonaYXQQ+FGay+aC+HnX1Az
 fbbXGhAzsOhehsCbBjS/UQVlXfEYByWRlIemSgh3YOyymFU8wii/yMynGdWAVr1O7LGmKbrGT2i
 PrMm30SyLp29PvqTXfUZhIfGBJZfRT3LkTt/jpIm+ofi/AFaNImefRAaeLO6iH2ekMdFfMMVeYk
 VaYJAt0NBWzEvEqQUo+tGhaTK//YfPZjMTWz2A7z2FyVg+OqdsRYtrThAvlR+PXlAjmMFQNOE9N
 k/nGSBESspsT9pSsW9ZhsoTuibI90rU6CaSz6mRfWZ1t6kTpsGw3us+S+e7lIIxZfKOlwL3i4Sy
 BPBwRAdJeDwG6qG2ovQRbx8hkrL2GhrhYT7GhEYnrF6uHkhvGSjKdhS2D7X9J76S9iH4AhFlviy
 yfrZN9KDFqiz0orS4WFQzJcK6CZHx75dCk1AYBhCsVql85DV5y/Gi58N9G100BeRq+dfLgqhT42
 vZqStSqkLzxfDCA==
X-Developer-Key: i=jai.luthra@ideasonboard.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

There is a flags field in struct mmal_es_format, but the defines
for what the bits meant weren't included in the headers.
For V4L2_PIX_FMT_NV12_COL128 support we need them, so add them in.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
---
 drivers/platform/raspberrypi/vchiq-mmal/mmal-msg-format.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/platform/raspberrypi/vchiq-mmal/mmal-msg-format.h b/drivers/platform/raspberrypi/vchiq-mmal/mmal-msg-format.h
index 5569876d8c7d60477893c17f00c2e501b49d364a..e8f5ca85a7c4184320b33996967a7a83e938d79b 100644
--- a/drivers/platform/raspberrypi/vchiq-mmal/mmal-msg-format.h
+++ b/drivers/platform/raspberrypi/vchiq-mmal/mmal-msg-format.h
@@ -53,6 +53,16 @@ union mmal_es_specific_format {
 	struct mmal_subpicture_format subpicture;
 };
 
+/* The elementary stream will already be framed */
+#define MMAL_ES_FORMAT_FLAG_FRAMED				BIT(0)
+/*
+ * For column formats we ideally want to pass in the column stride. This hasn't
+ * been the past behaviour, so require a new flag to be set should
+ * es->video.width be the column stride (in lines) instead of an ignored width
+ * value.
+ */
+#define MMAL_ES_FORMAT_FLAG_COL_FMTS_WIDTH_IS_COL_STRIDE	BIT(1)
+
 /* Definition of an elementary stream format (MMAL_ES_FORMAT_T) */
 struct mmal_es_format_local {
 	u32 type;	/* enum mmal_es_type */

-- 
2.51.0


