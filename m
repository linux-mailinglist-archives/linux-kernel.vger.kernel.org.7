Return-Path: <linux-kernel+bounces-885128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D90FBC320F5
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED06242076E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F12332EA1;
	Tue,  4 Nov 2025 16:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gse0mVpQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="atu45Jun"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4DF3328FC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 16:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762273603; cv=none; b=p26Mtl90amkfQrwn7oci9gUIpxVVsalpKyxdNXQiUAbYcJy61+DY9gbdq+h6gVkoeouSd5E/ohQrE1XxqIO6L6/rTvERDRVZmV7NU847ONomL4PG0DOWeoKHRo3mjyOCkyEsEkU3hMgBuvud3PP6L6s/fWKAEhFiziaybIYwP7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762273603; c=relaxed/simple;
	bh=Zfq0tRzBMK/stIqYR/fNd49x0GpwLSnbF3DD/tpTY64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jHS2Z4aTSpE0dCTmRLj8D4vxB4aMKF+2NOGpsZAANM6x0DYS/Iky/xjrClVFqb9tNB5TUcgIW15czUXRcK9/Bk5b0l4WyAR8paESl7YpPHuZroCSk/plNm6RNN49jqElCNU89mmoh05b29LCtDieECOZknWNc8k8slTtaC28wy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gse0mVpQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=atu45Jun; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4Cfg5K2098840
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 16:26:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=5Vssr73RyQ+
	FszqtmkVaSpa6VDKHA4NdGYdJks1BQS4=; b=gse0mVpQzJ7H9T+CYYVtnNuCqZ3
	lL0KaN3MNnmA7TZnXUucjxWbFtZcRzO2725b25NEQTSTcoAoXxvvQMXDZitcQgrW
	Z715FtQ2U0xCeaHGApns8WfjhWC++EnSbkeu9sFq5SXmbq6L0E0QyCOWs0ltNaRw
	fLvhAKcQicU6oPQrR0o6aRqOZsGOeyW//jVAtEKyGSWl0F3i895EaNx2zr0U9Jbm
	ktUpjiqXKnHYiGmG2jVgUyn4NC8neApJm2BDQ4EbSpprkqN9DIJL0TST7ie6zGK/
	TTzM5dudvkuhpu5DfhL5jPa2pcm/iBtwUifRTqED1HpuFFdW8x0zQZOkyiA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a79jjt2xw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 16:26:40 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-295952a4dd6so31846355ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 08:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762273600; x=1762878400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Vssr73RyQ+FszqtmkVaSpa6VDKHA4NdGYdJks1BQS4=;
        b=atu45Jun46I/xJSNSmcSYMjD5xewq+qpT15HpEIcpRpbHnlkz1FJnVkD6ONFS5+SiV
         YC7dJIJbSWy8Q285VULRi2DtuAqSKfexYBPDzhckx0IjUHg4rspxT7QPTYt/CXjiAZO5
         iqM1XaLZNRLzdhaZwRLFiV6ST4xZy2QOzUq9s7HrMcWLAmdH/kPmkWwVM4U/ybTqUPVz
         /QvyVj49LmTl+14pzMnDrY2VUmbFyXVLKeh34qDRc7uVByZOwfC6h2HqjDhXVuJC4c3C
         yYscJCXBacOJZwpIut8bIv6BxBLWHxiJfwK233xfFDpnNwdEWNmiLGa4Xln318zqqM2E
         614Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762273600; x=1762878400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Vssr73RyQ+FszqtmkVaSpa6VDKHA4NdGYdJks1BQS4=;
        b=D5u3mWpBxh6Feqrpd4C6I5OsKc9b9XSLOt4KjabIdN7Kwu3YGqMg982mYCjKYGWJSl
         19WHGpnGa+EUXBZuj9MFUQOtEbdr0xx6IxfpFa6OjVTO0GMCnmxsSbSss/OOiwL4DAUX
         HOSiQqctzJJUMvwriHY/emWiIfb+V8GNDgbgGXvwBS1ohOLrA+Xu/G8K8S5OknbpI3rw
         1zM8MdMOntLLP76oSkbvrW8G1bZkJUZ1xQsHiu/87H4YbkDK2PZEaihBOdMaWFokjOpP
         JiDAcM6+6+gRfYZw4xCkgotL4NBmeFSQZGZG8qkXURW0sL+pkC6XPX2APomESI6l1Znj
         MTwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxeWeto0DrkxuzXC/YC3oU3qreSxfEu979ov2c1E6nPrwyY5h6qhRddyqjSPE9UJdYkH8W88qpP8xkf94=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOjqsaNJasYXYNi17AYC3JzAUH80uV59hCmpLL+uPTm7bC60su
	UHQ07YPMzudkSayRLXKxswujgHYjgrDm0Fg5RWqpdaFX7mgyZz2aYBDia7b345fPdM67np+krgc
	nRxONrajjQD77UaH70ouNKVNm3ymCgeiw5+QEZJ8ErqQYXfa/wOT7/EAvoL8Tw8gQbpZZFsewhh
	QxPMEq
X-Gm-Gg: ASbGnctbPzYhMUlfMHGzy04H3MluYuyq2gMau5DM0BhoepuWZZ7GfsBD9qNoW5jwjP/
	q09J9gIrjdF9N2nYhM6Ebz4QpqujDatbjZ6PjM9x3Gj4k+2c605ZyKNZqvG2mh1JyvCSSnso8xz
	hF8PTSxlGUmcgD5OW47qAdA9B1ZLzvg2NEDSTUSAbQcjammDqO/VLZF2bI885esD9OvsnCQr3El
	sE/5pFW3cm8hzixPtMiIwd049ETunVSTspVTrYiGBrGZPcWf70WI+6x9na838+/S7/ggaU3usHE
	lUmOlH0Lb/WtbPDjFllPdeOtiO4V2fGYmI2qwr4v/NBwbFYTBBnRWZ0RP1C9yhYKyXd+8Cpahmi
	0qiGfmB6e1qQXOSBJEBakcPS9yx8RbsUiaEU0tmi5NRTN
X-Received: by 2002:a17:902:db08:b0:294:fc13:7e8c with SMTP id d9443c01a7336-2962ad41aa1mr3110045ad.13.1762273599583;
        Tue, 04 Nov 2025 08:26:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNZs7Qx9rkasOM8xWADo/sxz4Q2imfM3mJR8YCwuWSazJuiOsuh4+13f7zKN4iISctrbrl1g==
X-Received: by 2002:a17:902:db08:b0:294:fc13:7e8c with SMTP id d9443c01a7336-2962ad41aa1mr3109615ad.13.1762273599075;
        Tue, 04 Nov 2025 08:26:39 -0800 (PST)
Received: from hu-yuzha-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a7a8a9sm31508435ad.107.2025.11.04.08.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 08:26:38 -0800 (PST)
From: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: baochen.qiang@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Yu Zhang <yu.zhang@oss.qualcomm.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Subject: [PATCH ath-next v2 4/6] wifi: ath11k: Register relayfs entries for CFR dump
Date: Tue,  4 Nov 2025 08:26:31 -0800
Message-Id: <20251104162633.3007874-5-yu.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104162633.3007874-1-yu.zhang@oss.qualcomm.com>
References: <20251104162633.3007874-1-yu.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _qkmhQvONV4hbTCXNmSr4ZS6wfvhwd9a
X-Proofpoint-ORIG-GUID: _qkmhQvONV4hbTCXNmSr4ZS6wfvhwd9a
X-Authority-Analysis: v=2.4 cv=TuPrRTXh c=1 sm=1 tr=0 ts=690a2940 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=6mQ44K8ZfP1dJrZg0vYA:9
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDEzNyBTYWx0ZWRfX6dgZCC9SjioT
 xgGGUH0u/ZUxKlQKDXAwW9ewBfkmnTWgddWXWM1qzDnlabyi07UoOwanCrkM/W3m1ZGvWH7jVUP
 cM50741lYHZ3mRH92VplLdjM6aeUxcOFw/Cxr4KZ0933wsC11aUGn/ASwGbaDcW5TNmbEm0E3da
 3BlEd494r6deC5bfJgSH453jNZrbxO+gBg7VbrjnK4FgT636eZhgU3FqTSho4DgsvZPOeFVQwxh
 w+VQMs0ZisczJkWbKyE20mUPzqS1QNyi3+DDthtFiki1WK9fhUTUYvpBl6YaxunU1hyWJcA805K
 F0xOol8aRjh+JYsSMVK1WSPOLqQGNVjKuIWJmn/sgZ90qXTG9NZVsH8e3QO65mdinxT4NCXw/Uq
 EIyfTd3lnjOcbd46PmvwBukzNkffHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_02,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 spamscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511040137

From: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>

Provide a relayfs interface to collect the CFR dump from the user space.

'/sys/kernel/debug/ieee80211/phyX/ath11k/cfr_capture' is exposed to user
space to get CFR data.

CFR format to user space:
 ___________________________________________
| CFR header | CFR payload | CFR tail data |
|____________|_____________|_______________|

CFR header contains the following fields,

* Start magic number 0xDEADBEAF - 4 bytes
* vendor id - 4 bytes
* cfr metadata version - 1 byte
* cfr data version - 1 byte
* device type - 1 byte
* platform type - 1 byte
* CFR metadata length - 4 bytes
* metadata - 92 bytes
        peer mac - 6 bytes
        capture status - 1 byte (1 for success 0 for failure)
        capture_bw - 1 byte
        channel_bw - 1 byte
        phy_mode - 1 byte
        prim20_chan - 2 bytes
        center_freq1 - 2 bytes
        center_freq2 - 2 bytes
        capture_mode - 1 byte
        capture_type - 1 byte
        sts_count - 1 byte
        num_rx_chain - 1 byte
        timestamp - 4 bytes
        length - 4 bytes
        chain_rssi - 32 bytes (4 bytes for each chain)
        chain_phase - 16 bytes (2 bytes for each chain)
        cfo_measurement - 4 bytes
        agc_gain - 8 bytes (1 bytes for each chain)
        rx_start_ts - 4 bytes

CFR payload:

CFR payload contains 8bytes of ucode header followed by the tone
information. Tone order is positive tones, followed by PHY memory
garbage, followed by negative tones. Dummy tones are uploaded to make
number of tones always integer number of 64. Number of tones is not
preamble type dependent.

Each CFR tone has 14-bit I component and 14-bit Q component and is sign
extended to 16-bit I/Q. Two tones are packed into one 64-bit unit as:

[63:0] = [Tone1_Q(63:48) Tone1_I(47:32) Tone0_Q(31:16) Tone0_I(15:0)]

CFR tail: end magic number 0xBEAFDEAD

Tested-on: IPQ8074 hw2.0 PCI IPQ8074 WLAN.HK.2.5.0.1-00991-QCAHKSWPL_SILICONZ-1
Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04685-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1

Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Co-developed-by: Yu Zhang (Yuriy) <yu.zhang@oss.qualcomm.com>
Signed-off-by: Yu Zhang (Yuriy) <yu.zhang@oss.qualcomm.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/cfr.c | 35 +++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/cfr.h |  1 +
 2 files changed, 36 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/cfr.c b/drivers/net/wireless/ath/ath11k/cfr.c
index 0fa81c939860..861e457ec5bf 100644
--- a/drivers/net/wireless/ath/ath11k/cfr.c
+++ b/drivers/net/wireless/ath/ath11k/cfr.c
@@ -416,10 +416,45 @@ static void ath11k_cfr_debug_unregister(struct ath11k *ar)
 	ar->cfr.enable_cfr = NULL;
 	debugfs_remove(ar->cfr.cfr_unassoc);
 	ar->cfr.cfr_unassoc = NULL;
+
+	relay_close(ar->cfr.rfs_cfr_capture);
+	ar->cfr.rfs_cfr_capture = NULL;
 }
 
+static struct dentry *ath11k_cfr_create_buf_file_handler(const char *filename,
+							 struct dentry *parent,
+							 umode_t mode,
+							 struct rchan_buf *buf,
+							 int *is_global)
+{
+	struct dentry *buf_file;
+
+	buf_file = debugfs_create_file(filename, mode, parent, buf,
+				       &relay_file_operations);
+	*is_global = 1;
+	return buf_file;
+}
+
+static int ath11k_cfr_remove_buf_file_handler(struct dentry *dentry)
+{
+	debugfs_remove(dentry);
+
+	return 0;
+}
+
+static const struct rchan_callbacks rfs_cfr_capture_cb = {
+	.create_buf_file = ath11k_cfr_create_buf_file_handler,
+	.remove_buf_file = ath11k_cfr_remove_buf_file_handler,
+};
+
 static void ath11k_cfr_debug_register(struct ath11k *ar)
 {
+	ar->cfr.rfs_cfr_capture = relay_open("cfr_capture",
+					     ar->debug.debugfs_pdev,
+					     ar->ab->hw_params.cfr_stream_buf_size,
+					     ar->ab->hw_params.cfr_num_stream_bufs,
+					     &rfs_cfr_capture_cb, NULL);
+
 	ar->cfr.enable_cfr = debugfs_create_file("enable_cfr", 0600,
 						 ar->debug.debugfs_pdev, ar,
 						 &fops_enable_cfr);
diff --git a/drivers/net/wireless/ath/ath11k/cfr.h b/drivers/net/wireless/ath/ath11k/cfr.h
index fa9d98cc72b7..4653b04c30de 100644
--- a/drivers/net/wireless/ath/ath11k/cfr.h
+++ b/drivers/net/wireless/ath/ath11k/cfr.h
@@ -60,6 +60,7 @@ struct ath11k_cfr {
 	struct ath11k_look_up_table *lut;
 	struct dentry *enable_cfr;
 	struct dentry *cfr_unassoc;
+	struct rchan *rfs_cfr_capture;
 	u8 cfr_enabled_peer_cnt;
 	u32 lut_num;
 	u64 tx_evt_cnt;
-- 
2.34.1


