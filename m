Return-Path: <linux-kernel+bounces-884115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F50C2F63D
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 06:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3EA33BF201
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 05:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B7F2DAFA9;
	Tue,  4 Nov 2025 05:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HCtI5r6V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IHE/3FcT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0FE2D9498
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 05:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762234762; cv=none; b=lokR5c94SN1Bc9yu9X2WZ+vUEV1hgjtRB32l55uOQYWnDs9UPXtoAfxNW5DiCByjOLyNzhctJgEB1n2nwoWLXwSUy0l4Ft7HOPw5dPmWc1VYUJ8MN+3NrrtH0Umhfr6hJP4z2je6CRX1YomTkRfM6W1AbSLYP0mle3wn82paE+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762234762; c=relaxed/simple;
	bh=dtuRZyZEtqGlK3U1hCkrQMWdm+YNj/fJVZiAp7dQZSw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M1cZ2kJykuIkqDwkHq09zIpqOk+2y3mdGjvC9O/nSQbZb5PyHpCUfwEkpl8STkem8Bw5rmhCe9eCjo0+MAtqNLtue9pzHRkEd1SNiUn6t21NES1VdCHJaP2wnbqVdppJZG3rA8g/YM6wDjg03j4SahcfzaZwiOWN8UGBv4mzg38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HCtI5r6V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IHE/3FcT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A43bwTA3616850
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 05:39:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IjuSOJy8CVVTczhbx4CkNfodIVaw9oUxb4d0A+FKYtg=; b=HCtI5r6VEh9rj/9a
	EhN5tEhvLFJs5RahS6bAgJJZNBja75eoeGOqYVN4CLM6YDaVJHph7vXHJwgmTqWk
	9ZmVA7zA2CwEnS9GtYwhZPWXmkWYsaVG8HRLCqJ12etY1+kgztlCn7HKREa3X/eS
	NeqZ5tJILoq8UGI6WCq9tHR/wTpCb7pxJ7ZNLGmiZTr6gV2QjW+oW3amk0TVSMw4
	aNyxusM1/0T5GIrIU9NGfB+JmW+jrNLd+LB8ywWcx3DX0J5XDKB7O41C0fC4/Akj
	N9Dj3XArUU+rNgNFuv8Fne85+A3Tl2nJgcczyw+Ww1j4BOy1ezGOc70snqB8eRVL
	84rWUg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a70fhsry4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 05:39:20 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b9939dc50e7so1779920a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 21:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762234760; x=1762839560; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IjuSOJy8CVVTczhbx4CkNfodIVaw9oUxb4d0A+FKYtg=;
        b=IHE/3FcTafuS0OdXIuLsqm4IdY8q2Jx6Tr0NKJWjOUihqFbiif/aWW4aVRKznE2/Fg
         wPK2b0eVceYWPonF+BkcEzmaf5jIXReBfodS5E42LBTpVbQWFGnAGnS+VPIrlnGBrdhb
         e8Q8yADvRpHrvurG7ELQJmQoE3OPa8Fbco4yaUkXyKR5yCHujVVSB7T/u5NzNlABMkhZ
         y98Mvlk2w24E7Kv2K1e0hWGc5VVQBPHspzEpgH+oPiYXZppTuH7n3fNdXMyjMtfWXoJl
         /QW+Lhp+6TDybunvxuDqiwvX3/dX5fuGD5DgLkIAN7oiTNfeI+F735gDjpnNGs4pYm+8
         wWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762234760; x=1762839560;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IjuSOJy8CVVTczhbx4CkNfodIVaw9oUxb4d0A+FKYtg=;
        b=LJVUBHGalg0tZbmBjxqWFsx4IBfbu8uyUU9gYTWAuZm3KHb1DgGNlpuXqLuhzZiy0k
         VNJEmEsbPJDnXpKG5imZojG6TwjEGnaY5vsloOf2OcnuPKXL+EE5ZH+lRb7nrsjJwUaZ
         RVK+J+ZARZj9OjmrhSx2LXxJfON133AFkx7m5abCa+GeV64BzuqnngH7zQMnT6yGTpYg
         6t6f+BOyR6x3QUqhgoElJ1j5idEBsXdKpKBpYpRzQNe0iIKRriLCFDI621injxKTyvmj
         WlU0O2QPfzz/ak3F3tUOw7stnb0SEz8Ppqz3zXv6Ff1PoZJ4ctQlt0CsiVYmVl8XQfvF
         F+Kg==
X-Forwarded-Encrypted: i=1; AJvYcCW+BDrBvYSYXaxCIILDKCqs/cBH9oXeIuQmCrSebFn+vKMQJlZvrKxB2uoBwsfNlwNmuhEsb2aK3A2mp5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1zke72TvokgA+fnbY6l9ebHWyRYRlWvB/KwzNn/cCLmiHb+9g
	ld69PhT19uqAZBjkfMtc6ad7dqEwuH4osn2QaUv1ZlUWxIF/Sq9jZUAA9Je55t/3X8Hu4DEaQgx
	xht2ie7G2W7wmQhil8TOswOIL5xdChliPS1h3ELkFnEUgyqeJww6J1DBwt4EwnG/YXZw=
X-Gm-Gg: ASbGncuJts97yBEP93IyaWY+oqjg5XBDeo00bPLf6ITlTQoc4HUJ3m8+CWUM7h+S3gp
	nX+46RxY29O3qihSgZjaXdQxJFcw7jqu07WHCDkJXvMRavrHGCJM1emwQyrSlK+rX5MgYp5vXSR
	kcFFDNrFwIT7fjvD3D1SpGMJaGCQF53DsvIFdGmBDitKXKH7S6ni4qXG/Sne1El+RyLbhkMTFKq
	0SXxSXMHH8GeInpaVso0GaHJ48kCWOvecpggHsMC+cUcwRB08QAE1xGa8j9/lgcozu9lHaVXyMH
	CRg74PtgSvule9TDCs9RAWpmzFl1xyx5wuJXlIT+sVIoH6LDuMiNmLKp+woJMRqOKibb3mQfnjN
	iEr78NKqZo4xtS08r3QbEok4Q
X-Received: by 2002:a05:6a21:33a9:b0:341:3b91:69d1 with SMTP id adf61e73a8af0-348c9d69eabmr16053844637.5.1762234760172;
        Mon, 03 Nov 2025 21:39:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4oakAA99qWn20v9F+HqkC6GSdg8e3l70zkxie1GH4jCVBdFgzAOkin2sgcj0o0WonnR9e3A==
X-Received: by 2002:a05:6a21:33a9:b0:341:3b91:69d1 with SMTP id adf61e73a8af0-348c9d69eabmr16053809637.5.1762234759546;
        Mon, 03 Nov 2025 21:39:19 -0800 (PST)
Received: from hu-sumk-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd3150f0asm1462402b3a.2.2025.11.03.21.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 21:39:19 -0800 (PST)
From: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
Date: Tue, 04 Nov 2025 11:09:06 +0530
Subject: [PATCH v2 2/3] bus: mhi: ep: Create mhi_ep_queue_buf API for raw
 buffer queuing
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-loopback_mhi-v2-2-727a3fd9aa74@oss.qualcomm.com>
References: <20251104-loopback_mhi-v2-0-727a3fd9aa74@oss.qualcomm.com>
In-Reply-To: <20251104-loopback_mhi-v2-0-727a3fd9aa74@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Akhil Vinod <akhil.vinod@oss.qualcomm.com>,
        Subramanian Ananthanarayanan <subramanian.ananthanarayanan@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, quic_vpernami@quicinc.com,
        Sumit Kumar <sumit.kumar@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762234749; l=3486;
 i=sumit.kumar@oss.qualcomm.com; s=20250409; h=from:subject:message-id;
 bh=dtuRZyZEtqGlK3U1hCkrQMWdm+YNj/fJVZiAp7dQZSw=;
 b=anM+z/tuk/MuWJ6IIFZE7opgozQIgdOmTmSJhVlWnAbN8ndTGBEJix6HMiTuOgjL1hPgl7ZJw
 Hu6PxWCqPrwBg1wAsEYa93j9wN6jSQA0BPlntypUuxDxLWg09ZLZeql
X-Developer-Key: i=sumit.kumar@oss.qualcomm.com; a=ed25519;
 pk=3cys6srXqLACgA68n7n7KjDeM9JiMK1w6VxzMxr0dnM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA0NCBTYWx0ZWRfX8iP41b4WFMfl
 Vt/OoKgztGTj0VK0kF1Un5IGwVA4s8kohYt/Mw/77usUhxHV3FpDQz8sPMsbo6UVjZBDzGlVpAf
 8/pF19+BhNZlUVSZW5bhJE0xgcoca9d3zI2YE1G5fZ1HLAILKXCNZ60ItJfu0ny6KDvI+CoW6uJ
 ZoptNHKdhDtb9X6X3eEDukPvaQxn8EZaaeAGCK03ZCKUpGAxfclhiyhomPHOM7Cn0GTZXuEf2Xz
 AirLneCe8J9/Tzl/mbs64Ou53r5k76j0wzAsNGSAifkznYr8mf/GIlrAmdQXTmUzBPD5hpBMf/Q
 WULmswF0DSoLolv73RmUgaCIULvqwH1Vmc06im2G++Ay1wGE03gX74GdwhE+ogiBFh/2d/cSiPB
 PlN4wStNCg6nHeBW+DRSCUg3+wdPIg==
X-Proofpoint-ORIG-GUID: NvckNwEbwZwZQU1sGsPzxYjW1f4UjD08
X-Authority-Analysis: v=2.4 cv=CbsFJbrl c=1 sm=1 tr=0 ts=69099188 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=udtdykpXU_nWVPwV3aUA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: NvckNwEbwZwZQU1sGsPzxYjW1f4UjD08
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040044

Create and export a new mhi_ep_queue_buf() API that allows raw buffer
queuing for client not using skb.

Extract core logic for queuing buffers into a new internal mhi_ep_queue()
function that provides a unified implementation for both mhi_ep_queue_skb()
and mhi_ep_queue_buf(). This internal function uses a cb_buf parameter to
handle both socket buffers and raw buffers through the same code path.
---
 drivers/bus/mhi/ep/main.c | 23 +++++++++++++++++------
 include/linux/mhi_ep.h    | 10 ++++++++++
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index b3eafcf2a2c50d95e3efd3afb27038ecf55552a5..f4b119a8dca2dbfb3ffc24b04c85743fb57088fd 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -544,9 +544,9 @@ static void mhi_ep_skb_completion(struct mhi_ep_buf_info *buf_info)
 
 	mhi_ep_ring_inc_index(ring);
 }
-
 /* TODO: Handle partially formed TDs */
-int mhi_ep_queue_skb(struct mhi_ep_device *mhi_dev, struct sk_buff *skb)
+static int mhi_ep_queue(struct mhi_ep_device *mhi_dev, void *buf, size_t len,
+			void *cb_buf)
 {
 	struct mhi_ep_cntrl *mhi_cntrl = mhi_dev->mhi_cntrl;
 	struct mhi_ep_chan *mhi_chan = mhi_dev->dl_chan;
@@ -559,7 +559,7 @@ int mhi_ep_queue_skb(struct mhi_ep_device *mhi_dev, struct sk_buff *skb)
 	u32 tre_len;
 	int ret;
 
-	buf_left = skb->len;
+	buf_left = len;
 	ring = &mhi_cntrl->mhi_chan[mhi_chan->chan].ring;
 
 	mutex_lock(&mhi_chan->lock);
@@ -582,13 +582,13 @@ int mhi_ep_queue_skb(struct mhi_ep_device *mhi_dev, struct sk_buff *skb)
 		tre_len = MHI_TRE_DATA_GET_LEN(el);
 
 		tr_len = min(buf_left, tre_len);
-		read_offset = skb->len - buf_left;
+		read_offset = len - buf_left;
 
-		buf_info.dev_addr = skb->data + read_offset;
+		buf_info.dev_addr = buf + read_offset;
 		buf_info.host_addr = MHI_TRE_DATA_GET_PTR(el);
 		buf_info.size = tr_len;
 		buf_info.cb = mhi_ep_skb_completion;
-		buf_info.cb_buf = skb;
+		buf_info.cb_buf = cb_buf;
 		buf_info.mhi_dev = mhi_dev;
 
 		/*
@@ -627,8 +627,19 @@ int mhi_ep_queue_skb(struct mhi_ep_device *mhi_dev, struct sk_buff *skb)
 
 	return ret;
 }
+
+int mhi_ep_queue_skb(struct mhi_ep_device *mhi_dev, struct sk_buff *skb)
+{
+	return mhi_ep_queue(mhi_dev, skb->data, skb->len, skb);
+}
 EXPORT_SYMBOL_GPL(mhi_ep_queue_skb);
 
+int mhi_ep_queue_buf(struct mhi_ep_device *mhi_dev, void *buf, size_t len)
+{
+	return mhi_ep_queue(mhi_dev, buf, len, buf);
+}
+EXPORT_SYMBOL_GPL(mhi_ep_queue_buf);
+
 static int mhi_ep_cache_host_cfg(struct mhi_ep_cntrl *mhi_cntrl)
 {
 	size_t cmd_ctx_host_size, ch_ctx_host_size, ev_ctx_host_size;
diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
index 7b40fc8cbe77ab8419d167e89264b69a817b9fb1..7186eb667b081009927af48513519084fb0be3a6 100644
--- a/include/linux/mhi_ep.h
+++ b/include/linux/mhi_ep.h
@@ -302,4 +302,14 @@ bool mhi_ep_queue_is_empty(struct mhi_ep_device *mhi_dev, enum dma_data_directio
  */
 int mhi_ep_queue_skb(struct mhi_ep_device *mhi_dev, struct sk_buff *skb);
 
+/**
+ * mhi_ep_queue_buf - Send buffer to host over MHI Endpoint
+ * @mhi_dev: Device associated with the DL channel
+ * @buf: Buffer to be queued
+ * @len: Size of the buffer
+ *
+ * Return: 0 if the buffer has been sent successfully, a negative error code otherwise.
+ */
+int mhi_ep_queue_buf(struct mhi_ep_device *mhi_dev, void *buf, size_t len);
+
 #endif

-- 
2.34.1


