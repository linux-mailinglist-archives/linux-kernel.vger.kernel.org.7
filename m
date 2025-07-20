Return-Path: <linux-kernel+bounces-738265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DE2B0B681
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 16:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B883A18976EC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 14:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D65418A6B0;
	Sun, 20 Jul 2025 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jxK3wqsZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906BC1758B
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753022783; cv=none; b=lvQvVjumsfar+JFbBJl5ia0r9cQUf3mX4jQ2bdcIF8pjjBjqN2NPMEMhZqp/wnKXksZor+oPC5pig7niOUX3NeTGojmjikWvkAg0xCqNjsJ+DSnb8XL7oK91UAkIdeu85ITwzLAmirTbh4+eufJLoreIKVLa6F1SCIAr/565l5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753022783; c=relaxed/simple;
	bh=Jq8jhVW0cCEdf6xyTCAhkmsjUVfRZ2W/5N8mH2cGxOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=L8FSLRf0mPXJVKmy78qM0Q5VSA45roT2bMxKJLm87NzQ8Ht7csmPdVp6Dinw5ffpfOmRPSnksUGslYwBmxaxHDV3tdTqGsGmHEeLFTFYtVY329A+wrugP5RuIpGe6boLRZNIMX0widtq5Nh1ugEJWqfOveeQKoQVEPSEflYuksg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jxK3wqsZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KDo2XD005323
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 14:46:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=xjVSLZuv0o0l1y7ZfSWiHI
	hHW8W40xj46tm+AH/rBNs=; b=jxK3wqsZ2FREWmvh/L/FvUhjD0OPecXKjU3/BE
	FTW5Ap/UBgjYbHsLMhlbaWs3g6+REkFiftdyTyDpMLuYesrC4aefeEgBOUMIo5J6
	lJyvpfw2UrDdmM1bQAVrUotd2nKj/p1kJBgY2VoR2GlqxdG0Tdz39pyOJoqVBb/A
	1YyPd0l7TYTeRAL3LWzDHmP4qjAZ/f5oDx1wq8n9WHorNjxvMbKpThdsluw6odI2
	GwPa89E4WBt9KxGmQZSZVGUE94eYNRtKcC2EANRIziEG4ZRu89AWZXHvzbSVp9j+
	CyQnvLStxNVCaFDB3jRT735vpu1eZ5td7HbThrEytii2cXKw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048v2arv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 14:46:20 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b321087b1cdso4030936a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 07:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753022779; x=1753627579;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xjVSLZuv0o0l1y7ZfSWiHIhHW8W40xj46tm+AH/rBNs=;
        b=BUpVecGnarm2uZ0vG1Ub/6jN1ixYGtLKUWETBPTuAXOT7smlpfBi5jwIwX07LE4vz0
         aS0Lq1vfFf0Pz+6VcpQBfaSi6+MdDGWm0zr9zSErD9cYZRYy//kUxvtgNChEcXh+LDb7
         VbdO8HRi1HKOXXR64DAHXgGl9La4Pg919gaf+xzk1i9KAxUY4bH5sUCFO3jNLUlpB4pe
         8wsA6v7zupInRzx3RfHDxMBmXktKzAP3/gi0MZ5eO41/lWwFW+UiTeWpQ6pjK9kO/dUH
         H8yv2Y8u6m5lOrL9AWEpHDGWmKh2HU1szUHPESJH61VRs41w6oTuPQo9sge5sAiueCKC
         D9SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVh6/rOn8bLL3pLe3SrvWfsG8fU2iNZqofME72l8I0ggl/TYRiIS7x8SfDcQOuzGbiq7NMkA5eLZeHmlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEI/HvjyxJss+8i0iHe3JHOhlZOVfkk80vrwX142kResGFnSo4
	im6S6zREx5NfqnyqNH6kV5Vle/FnwjUSaGhFo4o4lTk9W7PdMM+olTVRqC05deV9NtNWuLm4qsU
	yh3unsTdOKQX0lxADbL5OG5MfN6ouIAQn70zi+KZX91CrCmYU1CAE5NcudAjDoiCZzKE=
X-Gm-Gg: ASbGncuVxQE7M28SMfPu7nKcf2ytgnogfBjobqjui75mFtmlLVSM84sxRzxRLFJqyNZ
	6lhcbKijPNrdwWZE4+/OUCK/0GsvA8U8o0p2xrAX5g41k5q2njnj+MfSWbVEP6hUNUeS0AwqQAT
	ZvN0IGQurYZbTlgo9N1e7a0B70dLVBkvVzQlhnrMHOXhK/VRffC9AIMQZ+/b9KjMnW7CNUOiplt
	2l+J1cibOrRFxsdeqVp4yyr6bWEJ3KZvmeCmaR711T4Jvkq809Hp7jFFiNNlwstZZX72rwnOpNd
	EF7aT4BRF6/JG24M2QvUW4cifXGGHWbesATkCIKB4Uphi3SX1FZ0bvtfjT44qlBdExzTRPPKPuA
	x
X-Received: by 2002:a05:6a20:729a:b0:231:7dcc:f449 with SMTP id adf61e73a8af0-2381153ef10mr27191943637.18.1753022779325;
        Sun, 20 Jul 2025 07:46:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlA5oox/CgRP/D9vKcoxmGsTqGvE2VXR1KcrTRmjRb6uqqi16UWkvuapOOpShICdBz7boybA==
X-Received: by 2002:a05:6a20:729a:b0:231:7dcc:f449 with SMTP id adf61e73a8af0-2381153ef10mr27191912637.18.1753022778824;
        Sun, 20 Jul 2025 07:46:18 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb156a04sm4152377b3a.70.2025.07.20.07.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 07:46:18 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Date: Sun, 20 Jul 2025 07:46:15 -0700
Subject: [PATCH ath-next] wifi: ath10k: Prefer {} to {0} in initializers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250720-ath10k-zero-brace-v1-1-c1ee818d6238@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIADYBfWgC/4XNQQ6CMBAF0KuQri3ptECLK+9hXJQySKNSbZGgh
 LvbdK2ymeTnz7xZSEBvMZB9thCPkw3WDTHALiOm18MZqW1jJpzxkklQVI89sAt9o3e08dog5aL
 SpZJ1q4wg8e7usbNzMo8krtMB55GcYtPbMDr/Ss8mSP0fdwIKVAJ2pSq0rFEfXAj546mvxt1ue
 RwJnfgmxCOkoJJVZ+oKzS9IbEIiQloAQ2agbmTxBVrX9QPwJ0BcVQEAAA==
X-Change-ID: 20250718-ath10k-zero-brace-236a5879d8c3
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 57KlONOsWxraEATj2XiZpK6vZDl6ji-e
X-Authority-Analysis: v=2.4 cv=SYL3duRu c=1 sm=1 tr=0 ts=687d013c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=LHJufyryw8ALvslwOl4A:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDE0MiBTYWx0ZWRfXxs0VDEOY0KLH
 OGqsggA7DWn5D1moboN4292biCq5xgguq22A+3CkI1z12Tfvjyf89rjSvM7CFIqPJaW6ELg8AK0
 ad6QPZkWg8E5eoVcczW2dZ+jXGaNtu0FFkgJBzq1GubVaNBXA2V5YXqKnhF9EEs+xL2nr9BEr7M
 FAnrbDFC1fk1S8cAva2yWhk1UC/DsczxzFD1SZ6xpDOnv4DbJcmGom+ZXWyVvH/I7fw7WI3DfU/
 79ovfqxKUZgoVz1JeygCvcK0335zaap6DSKE3NxExqtOUkKMdJTJCyv9ycBuk2kzmjtDnDAnlFd
 L6xSLm0NfFjwjxi+ZqHEQnX2UiSuqtJPtMGLKiOjsUOHNYoUB7xRrYNlLUjFHCi7OOFYlaIRL/U
 bbHAYHCM7GMkgOPunaP1wSv1apUV8f+FF11wgC82mbwE0NxRDnS8GUhGPCFY4dFoKgaU2cyK
X-Proofpoint-ORIG-GUID: 57KlONOsWxraEATj2XiZpK6vZDl6ji-e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507200142

Prefer {} to {0} in initializers since {} works even when the first
member is not a scalar.

Generated using:
sed -i 's/{[[:space:]]*0[[:space:]]*}/{}/g' drivers/net/wireless/ath/ath10k/*

Compile tested only.

Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath10k/core.c        | 2 +-
 drivers/net/wireless/ath/ath10k/debug.c       | 6 +++---
 drivers/net/wireless/ath/ath10k/debugfs_sta.c | 7 ++++---
 drivers/net/wireless/ath/ath10k/htt_rx.c      | 8 ++++----
 drivers/net/wireless/ath/ath10k/htt_tx.c      | 4 ++--
 drivers/net/wireless/ath/ath10k/mac.c         | 8 ++++----
 drivers/net/wireless/ath/ath10k/pci.c         | 3 ++-
 7 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 9c6c07598b3a12fd544d33c3cb893766c36eebc9..6f78f1752cd6ffcf8eb56621ba0e4978ac23e696 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -1565,7 +1565,7 @@ static int ath10k_core_create_board_name(struct ath10k *ar, char *name,
 					 bool with_chip_id)
 {
 	/* strlen(',variant=') + strlen(ar->id.bdf_ext) */
-	char variant[9 + ATH10K_SMBIOS_BDF_EXT_STR_LENGTH] = { 0 };
+	char variant[9 + ATH10K_SMBIOS_BDF_EXT_STR_LENGTH] = {};
 
 	if (with_variant && ar->id.bdf_ext[0] != '\0')
 		scnprintf(variant, sizeof(variant), ",variant=%s",
diff --git a/drivers/net/wireless/ath/ath10k/debug.c b/drivers/net/wireless/ath/ath10k/debug.c
index 6410d3961e76ca2b4191052277c2072638db4b8d..b7520220465a838ba700bb10bee2325ccc324d20 100644
--- a/drivers/net/wireless/ath/ath10k/debug.c
+++ b/drivers/net/wireless/ath/ath10k/debug.c
@@ -547,7 +547,7 @@ static ssize_t ath10k_write_simulate_fw_crash(struct file *file,
 					      size_t count, loff_t *ppos)
 {
 	struct ath10k *ar = file->private_data;
-	char buf[32] = {0};
+	char buf[32] = {};
 	ssize_t rc;
 	int ret;
 
@@ -983,7 +983,7 @@ static ssize_t ath10k_write_htt_max_amsdu_ampdu(struct file *file,
 {
 	struct ath10k *ar = file->private_data;
 	int res;
-	char buf[64] = {0};
+	char buf[64] = {};
 	unsigned int amsdu, ampdu;
 
 	res = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos,
@@ -1039,7 +1039,7 @@ static ssize_t ath10k_write_fw_dbglog(struct file *file,
 {
 	struct ath10k *ar = file->private_data;
 	int ret;
-	char buf[96] = {0};
+	char buf[96] = {};
 	unsigned int log_level;
 	u64 mask;
 
diff --git a/drivers/net/wireless/ath/ath10k/debugfs_sta.c b/drivers/net/wireless/ath/ath10k/debugfs_sta.c
index 0f6de862c3a9ba8995a72ef451e90371dce0a978..b9fb192e0b48456cc21b281fec47ce607913ab02 100644
--- a/drivers/net/wireless/ath/ath10k/debugfs_sta.c
+++ b/drivers/net/wireless/ath/ath10k/debugfs_sta.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2014-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018, The Linux Foundation. All rights reserved.
  * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include "core.h"
@@ -244,7 +245,7 @@ static ssize_t ath10k_dbg_sta_write_addba(struct file *file,
 	struct ath10k *ar = arsta->arvif->ar;
 	u32 tid, buf_size;
 	int ret;
-	char buf[64] = {0};
+	char buf[64] = {};
 
 	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos,
 				     user_buf, count);
@@ -295,7 +296,7 @@ static ssize_t ath10k_dbg_sta_write_addba_resp(struct file *file,
 	struct ath10k *ar = arsta->arvif->ar;
 	u32 tid, status;
 	int ret;
-	char buf[64] = {0};
+	char buf[64] = {};
 
 	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos,
 				     user_buf, count);
@@ -345,7 +346,7 @@ static ssize_t ath10k_dbg_sta_write_delba(struct file *file,
 	struct ath10k *ar = arsta->arvif->ar;
 	u32 tid, initiator, reason;
 	int ret;
-	char buf[64] = {0};
+	char buf[64] = {};
 
 	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos,
 				     user_buf, count);
diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index f12243d6bee171eeccf4a57e8001cbddfd26733c..d7e429041065ad21ed699a7e75809817ba719830 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -1884,7 +1884,7 @@ static bool ath10k_htt_rx_h_frag_pn_check(struct ath10k *ar,
 					  enum htt_rx_mpdu_encrypt_type enctype)
 {
 	struct ath10k_peer *peer;
-	union htt_rx_pn_t *last_pn, new_pn = {0};
+	union htt_rx_pn_t *last_pn, new_pn = {};
 	struct ieee80211_hdr *hdr;
 	u8 tid, frag_number;
 	u32 seq;
@@ -2402,7 +2402,7 @@ static bool ath10k_htt_rx_pn_check_replay_hl(struct ath10k *ar,
 	bool last_pn_valid, pn_invalid = false;
 	enum htt_txrx_sec_cast_type sec_index;
 	enum htt_security_types sec_type;
-	union htt_rx_pn_t new_pn = {0};
+	union htt_rx_pn_t new_pn = {};
 	struct htt_hl_rx_desc *rx_desc;
 	union htt_rx_pn_t *last_pn;
 	u32 rx_desc_info, tid;
@@ -2465,7 +2465,7 @@ static bool ath10k_htt_rx_proc_rx_ind_hl(struct ath10k_htt *htt,
 	struct fw_rx_desc_hl *fw_desc;
 	enum htt_txrx_sec_cast_type sec_index;
 	enum htt_security_types sec_type;
-	union htt_rx_pn_t new_pn = {0};
+	union htt_rx_pn_t new_pn = {};
 	struct htt_hl_rx_desc *rx_desc;
 	struct ieee80211_hdr *hdr;
 	struct ieee80211_rx_status *rx_status;
@@ -2767,7 +2767,7 @@ static bool ath10k_htt_rx_proc_rx_frag_ind_hl(struct ath10k_htt *htt,
 	struct htt_rx_indication_hl *rx_hl;
 	enum htt_security_types sec_type;
 	u32 tid, frag, seq, rx_desc_info;
-	union htt_rx_pn_t new_pn = {0};
+	union htt_rx_pn_t new_pn = {};
 	struct htt_hl_rx_desc *rx_desc;
 	u16 peer_id, sc, hdr_space;
 	union htt_rx_pn_t *last_pn;
diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
index c1ddd761af3e9ff987fcfd3a55b8747e48783b9e..d6f1d85ba8713d4343605082d91b96ea0df900e7 100644
--- a/drivers/net/wireless/ath/ath10k/htt_tx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
@@ -510,7 +510,7 @@ static int ath10k_htt_tx_clean_up_pending(int msdu_id, void *skb, void *ctx)
 {
 	struct ath10k *ar = ctx;
 	struct ath10k_htt *htt = &ar->htt;
-	struct htt_tx_done tx_done = {0};
+	struct htt_tx_done tx_done = {};
 
 	ath10k_dbg(ar, ATH10K_DBG_HTT, "force cleanup msdu_id %u\n", msdu_id);
 
@@ -560,7 +560,7 @@ void ath10k_htt_op_ep_tx_credits(struct ath10k *ar)
 void ath10k_htt_htc_tx_complete(struct ath10k *ar, struct sk_buff *skb)
 {
 	struct ath10k_htt *htt = &ar->htt;
-	struct htt_tx_done tx_done = {0};
+	struct htt_tx_done tx_done = {};
 	struct htt_cmd_hdr *htt_hdr;
 	struct htt_data_tx_desc *desc_hdr = NULL;
 	u16 flags1 = 0;
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 11569c18204c01c0d8d27ab731ce3c122d78f168..24dd794e31ea2ccd2f8c0481cda395dacce80ed5 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -3385,7 +3385,7 @@ static int ath10k_update_channel_list(struct ath10k *ar)
 	struct ieee80211_supported_band **bands;
 	enum nl80211_band band;
 	struct ieee80211_channel *channel;
-	struct wmi_scan_chan_list_arg arg = {0};
+	struct wmi_scan_chan_list_arg arg = {};
 	struct wmi_channel_arg *ch;
 	bool passive;
 	int len;
@@ -4885,7 +4885,7 @@ static int ath10k_mac_get_vht_cap_bf_sound_dim(struct ath10k *ar)
 
 static struct ieee80211_sta_vht_cap ath10k_create_vht_cap(struct ath10k *ar)
 {
-	struct ieee80211_sta_vht_cap vht_cap = {0};
+	struct ieee80211_sta_vht_cap vht_cap = {};
 	struct ath10k_hw_params *hw = &ar->hw_params;
 	u16 mcs_map;
 	u32 val;
@@ -4943,7 +4943,7 @@ static struct ieee80211_sta_vht_cap ath10k_create_vht_cap(struct ath10k *ar)
 static struct ieee80211_sta_ht_cap ath10k_get_ht_cap(struct ath10k *ar)
 {
 	int i;
-	struct ieee80211_sta_ht_cap ht_cap = {0};
+	struct ieee80211_sta_ht_cap ht_cap = {};
 
 	if (!(ar->ht_cap_info & WMI_HT_CAP_ENABLED))
 		return ht_cap;
@@ -5175,7 +5175,7 @@ static int ath10k_start(struct ieee80211_hw *hw)
 	struct ath10k *ar = hw->priv;
 	u32 param;
 	int ret = 0;
-	struct wmi_bb_timing_cfg_arg bb_timing = {0};
+	struct wmi_bb_timing_cfg_arg bb_timing = {};
 
 	/*
 	 * This makes sense only when restarting hw. It is harmless to call
diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index 1e6d43285138ece619b9d7dc49f113a439e2085d..97b49bf4ad80916dd139acd5f5744922317191aa 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2005-2011 Atheros Communications Inc.
  * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/pci.h>
@@ -63,7 +64,7 @@ static const struct pci_device_id ath10k_pci_id_table[] = {
 	{ PCI_VDEVICE(ATHEROS, QCA9984_1_0_DEVICE_ID) }, /* PCI-E QCA9984 V1 */
 	{ PCI_VDEVICE(ATHEROS, QCA9377_1_0_DEVICE_ID) }, /* PCI-E QCA9377 V1 */
 	{ PCI_VDEVICE(ATHEROS, QCA9887_1_0_DEVICE_ID) }, /* PCI-E QCA9887 */
-	{0}
+	{}
 };
 
 static const struct ath10k_pci_supp_chip ath10k_pci_supp_chips[] = {

---
base-commit: 9e8086b865ab458e4a1ae520aa3a4f304a0a0539
change-id: 20250718-ath10k-zero-brace-236a5879d8c3


