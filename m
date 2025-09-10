Return-Path: <linux-kernel+bounces-810196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF92B51724
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A77561C82C5B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374C231C561;
	Wed, 10 Sep 2025 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ar4eojs3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EDB31A57D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757508081; cv=none; b=X3kIjlk/Hjv/2uA8On3R6DQha5/Adv9TRF/e0piTHAy4DABEcS1QrB5AOLZt7B6ARqXqhkXvxrfswMY4MTelnxddBdilICjP6Fx14LhjxA+XYfa0TF4FNOzRoNahInMQOK+TKtP2+PbMDpLwHBOZBmJrJvkBZPMb2g6/+fc+INA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757508081; c=relaxed/simple;
	bh=HI+Wo58Xx8twVdr7BQzB/ScbaKtSqasqpDD7ddXTfSk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kZ76fUkemmjRVRJHIakW2JaC+oO0GnfYKQMyv2vfiKOVy3GKpMzyRmHN3c6ZZtU0du2ijYLtf5yi6mb2VXEA3C703JTCxEmfkyKhfxKx0moZrEPrYUMiTtUkplZ7w6JYiQVCCF/FZ+9cV2V8yqfvyYwXVI8URIMn0LoER+XETGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ar4eojs3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AAFCMP005899
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:41:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=lHFZZKfkltFSPCpfngB13G
	I5dV64wevesNshRHaYxIg=; b=ar4eojs3r8hn/9vGLuWOedDEZ4Qmb9RCI1W7pJ
	SLMZBB6VbRBiy/a87sS/G8nJJB+WxQsl8SWY6zNU4kEyCdAQAS70V1gD1Ns71r8U
	sLpjFp24hpvhGQEkBH3Odo+PRzzbuTc9xteQqn9Vo36EYxJ2hyiOTisg9QaozjR/
	i5ql35Nkuw3udS4xCAKg5LKlG39NeEnaA0c6FyJi4j49mgpi4rNyK9SPvsV62e1U
	+Rb7fKdXdwefLN/oxB+OGeVoleb9Qqwe3stWNMYLRsYWJzoc2LLtf6FeJo0UnIeT
	G+ne0G2f1VQ7lb448ZkqbaCkNnGsdj4iVp/m3LVtBTEXNcFQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490c9jbx7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:41:18 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b549a25ade1so191865a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 05:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757508077; x=1758112877;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lHFZZKfkltFSPCpfngB13GI5dV64wevesNshRHaYxIg=;
        b=MrL/ZakMzzBS+PuqLpJF93UY2acHlNkPXaBnNWV3eigmShwm5GxDtL9vTrB73UlRNy
         MuWALOZ7Kk6/Wa04r3KTTLVZjw777ZC3Pr+XQSBUdmECEyuiR/UhQHS9AOGV1L1uanWx
         xlAlq486+C86NuYd/0drMggFelfrqvGTiBRn1U8liAT7uhMJcqhh1m1zDgr5YcakFAD3
         Bmgs+V3dTk0HNjoGAUwG+Nby88Xx8OjXbVb8qIGO/0SHdAyyB8dYYh1OgV2/MdOAre0c
         +hdO6p4FibPqWPNIzo2/ucIJgCkDVARfwwpKhwOFwnieZ6u4kWNW1GOtXLyXBD6X3kcn
         6Lug==
X-Forwarded-Encrypted: i=1; AJvYcCX/hLKPfPHHQdUubt/H0TSE1rl/ADnfrwsOIgYoh0khWUFrcXCoP2A/9Xbq/yI6GHLw5TEQYreR2OE4Di0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8guh/Sz0+urRWSfTqXW7mLK5ppzWzZyNW2r7J3jXRV179PHRd
	LIU1ffN0H5s4VD1ULTRnTKEB58t+TOXBsskRAIkFPuMS+lM4dbTczwSJT4PI4QbB0+k8M3UAplw
	JTgpDSm4U5LdiGp6MdFj9srczGp7YoBJ8pQxqkDqvWsYCAlc+30pJ9EMM7Ot7W0uXewI=
X-Gm-Gg: ASbGnctKTBQAn0xL1iHT84LhT3+L387eOEzGslPUKwsu/elJ8y1xdgO1uUAoZP71OVj
	TpfGkpULRAkxwu41U0TcHIE5DqSTCw2BLvsZhXoVdPrI2sFYkSuWp7kmcPDXkjTZ5FtPeUinPw+
	fOk7ufuKRNjNoGXZVqcPsw48IOzBxlFx88dFZDzFcLWQHiEhBwoImwuDk6KJZUZI5PaRbwZvjtm
	VUpx3KBbLOqRlw6Fryqg0Cr458NOAns/w8S2UtSeVslXxhmsH3r+YBWJJJebQ7Q01LlRAvMvLo8
	2s0LE/mt8DCRn8WNoUr6GS7CA6CrQu2cpqq2Z6b8v3XYC+wh1dkDIhlfH03POjP0yQ==
X-Received: by 2002:a05:6a21:6d9c:b0:250:f80d:b32d with SMTP id adf61e73a8af0-25335e6f177mr23586503637.0.1757508076799;
        Wed, 10 Sep 2025 05:41:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrftTS+0N2imH3IgPQLdHacgwBKP6X3z3IlpwLVR4e5eP/aF1fk05Jlwi7vkfwOHOoqKQMfA==
X-Received: by 2002:a05:6a21:6d9c:b0:250:f80d:b32d with SMTP id adf61e73a8af0-25335e6f177mr23586444637.0.1757508076236;
        Wed, 10 Sep 2025 05:41:16 -0700 (PDT)
Received: from hu-sumk-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548a6a7fd0sm2537399a12.32.2025.09.10.05.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 05:41:15 -0700 (PDT)
From: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
Date: Wed, 10 Sep 2025 18:11:09 +0530
Subject: [PATCH v3] bus: mhi: ep: Fix chained transfer handling in read
 path
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-final_chained-v3-1-ec77c9d88ace@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAORxwWgC/x2MWwqAIBAAryL7neADkbpKRIiutRAWChGEd2/pc
 xhmXmhYCRtM4oWKNzU6C4MdBMQ9lA0lJWYwyjg1aiUzlXCs7Khgkt6paLT1xmUN3FwVMz3/b15
 6/wCRNsOlXwAAAA==
X-Change-ID: 20250910-final_chained-750c213725f1
To: Manivannan Sadhasivam <mani@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_krichai@quicinc.com,
        quic_akhvin@quicinc.com, quic_skananth@quicinc.com,
        quic_vbadigan@quicinc.com, stable@vger.kernel.org,
        Akhil Vinod <akhil.vinod@oss.qualcomm.com>,
        Sumit Kumar <sumit.kumar@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757508072; l=5093;
 i=sumit.kumar@oss.qualcomm.com; s=20250409; h=from:subject:message-id;
 bh=HI+Wo58Xx8twVdr7BQzB/ScbaKtSqasqpDD7ddXTfSk=;
 b=+vySGg6hSDSPdtqaNt11c7f34fgtcTWBAGEE+bsylMRErej8lEL6cMHyAt6isOoUosMNHYeHa
 OXSaPqv8sO2DUERHBOgJK0YtIqiqUDsdG16/v29BruOHabdV10ImQjF
X-Developer-Key: i=sumit.kumar@oss.qualcomm.com; a=ed25519;
 pk=3cys6srXqLACgA68n7n7KjDeM9JiMK1w6VxzMxr0dnM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMiBTYWx0ZWRfXxLRYsvsSWyNt
 0gz3uN7v65jVcVbOqYwj3Zfz3MX54TE7ya0CLQZwH1CmhR0xA1dWk8QGFf3GVSCeaULEfZcghLl
 b7DtonOcudPJ8oZ213FkimjfiM+BROTZILxaoFvEJ3hR/ZzeS/LROQ9FEdEHGqCk/hLCKfFMZHh
 j0cmpFaoeCKORC8Pcw6upFOvccykO48s52VxoREsZtS7yFhbIzpifOD4Auc+3Xlxx4JPn5bzAff
 XhpPPd5RyhCXcIF7W+zffBdEVqq3RpYlg6FUxpY5JdG/fLbvGllOcnZ6pn12ey9ZzClBSppVBEJ
 UhB8mL7Vx51/QimqG//wdY7opd2YrnzggAHtUkgJbOoh+BE5qLbP5XSh2DAKp9hnpqVlljrDHad
 vZ0ApNso
X-Proofpoint-ORIG-GUID: G_JnT5RUhe7qJm6O-Kqd85DN5BgrJY2W
X-Authority-Analysis: v=2.4 cv=PpOTbxM3 c=1 sm=1 tr=0 ts=68c171ee cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=vLTmBYhAW2SDn_YjWJsA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: G_JnT5RUhe7qJm6O-Kqd85DN5BgrJY2W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_01,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1011
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060022

The mhi_ep_read_channel function incorrectly assumes the End of Transfer
(EOT) bit is received with the doorbell in chained transactions, causing
it to advance mhi_chan->rd_offset beyond wr_offset during host-to-device
transfers when EOT has not yet arrived, leading to access of unmapped host
memory that causes IOMMU faults and processing of stale TREs.

Modify the loop condition to ensure mhi_queue is not empty, allowing the
function to process only valid TREs up to the current write pointer to
prevent premature reads and ensure safe traversal of chained TREs.
Remove buf_left from the while loop condition to avoid exiting prematurely
before reading the ring completely, and remove write_offset since it will
always be zero because the new cache buffer is allocated every time.

Fixes: 5301258899773 ("bus: mhi: ep: Add support for reading from the host")
Cc: stable@vger.kernel.org
Co-developed-by: Akhil Vinod <akhil.vinod@oss.qualcomm.com>
Signed-off-by: Akhil Vinod <akhil.vinod@oss.qualcomm.com>
Signed-off-by: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
---
Changes in v3:
- Update commit message
- Migrated to new mail
- Link to v2: https://lore.kernel.org/r/20250822-chained_transfer-v2-1-7aeb5ac215b6@quicinc.com

Changes in v2:
- Use mhi_ep_queue_is_empty in while loop (Mani).
- Remove do while loop in mhi_ep_process_ch_ring (Mani).
- Remove buf_left, wr_offset, tr_done.
- Haven't added Reviewed-by as there is change in logic.
- Link to v1: https://lore.kernel.org/r/20250709-chained_transfer-v1-1-2326a4605c9c@quicinc.com
---
 drivers/bus/mhi/ep/main.c | 37 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index b3eafcf2a2c50d95e3efd3afb27038ecf55552a5..cdea24e9291959ae0a92487c1b9698dc8164d2f1 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -403,17 +403,13 @@ static int mhi_ep_read_channel(struct mhi_ep_cntrl *mhi_cntrl,
 {
 	struct mhi_ep_chan *mhi_chan = &mhi_cntrl->mhi_chan[ring->ch_id];
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	size_t tr_len, read_offset, write_offset;
+	size_t tr_len, read_offset;
 	struct mhi_ep_buf_info buf_info = {};
 	u32 len = MHI_EP_DEFAULT_MTU;
 	struct mhi_ring_element *el;
-	bool tr_done = false;
 	void *buf_addr;
-	u32 buf_left;
 	int ret;
 
-	buf_left = len;
-
 	do {
 		/* Don't process the transfer ring if the channel is not in RUNNING state */
 		if (mhi_chan->state != MHI_CH_STATE_RUNNING) {
@@ -426,24 +422,23 @@ static int mhi_ep_read_channel(struct mhi_ep_cntrl *mhi_cntrl,
 		/* Check if there is data pending to be read from previous read operation */
 		if (mhi_chan->tre_bytes_left) {
 			dev_dbg(dev, "TRE bytes remaining: %u\n", mhi_chan->tre_bytes_left);
-			tr_len = min(buf_left, mhi_chan->tre_bytes_left);
+			tr_len = min(len, mhi_chan->tre_bytes_left);
 		} else {
 			mhi_chan->tre_loc = MHI_TRE_DATA_GET_PTR(el);
 			mhi_chan->tre_size = MHI_TRE_DATA_GET_LEN(el);
 			mhi_chan->tre_bytes_left = mhi_chan->tre_size;
 
-			tr_len = min(buf_left, mhi_chan->tre_size);
+			tr_len = min(len, mhi_chan->tre_size);
 		}
 
 		read_offset = mhi_chan->tre_size - mhi_chan->tre_bytes_left;
-		write_offset = len - buf_left;
 
 		buf_addr = kmem_cache_zalloc(mhi_cntrl->tre_buf_cache, GFP_KERNEL);
 		if (!buf_addr)
 			return -ENOMEM;
 
 		buf_info.host_addr = mhi_chan->tre_loc + read_offset;
-		buf_info.dev_addr = buf_addr + write_offset;
+		buf_info.dev_addr = buf_addr;
 		buf_info.size = tr_len;
 		buf_info.cb = mhi_ep_read_completion;
 		buf_info.cb_buf = buf_addr;
@@ -459,16 +454,12 @@ static int mhi_ep_read_channel(struct mhi_ep_cntrl *mhi_cntrl,
 			goto err_free_buf_addr;
 		}
 
-		buf_left -= tr_len;
 		mhi_chan->tre_bytes_left -= tr_len;
 
-		if (!mhi_chan->tre_bytes_left) {
-			if (MHI_TRE_DATA_GET_IEOT(el))
-				tr_done = true;
-
+		if (!mhi_chan->tre_bytes_left)
 			mhi_chan->rd_offset = (mhi_chan->rd_offset + 1) % ring->ring_size;
-		}
-	} while (buf_left && !tr_done);
+	/* Read until the some buffer is left or the ring becomes not empty */
+	} while (!mhi_ep_queue_is_empty(mhi_chan->mhi_dev, DMA_TO_DEVICE));
 
 	return 0;
 
@@ -502,15 +493,11 @@ static int mhi_ep_process_ch_ring(struct mhi_ep_ring *ring)
 		mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
 	} else {
 		/* UL channel */
-		do {
-			ret = mhi_ep_read_channel(mhi_cntrl, ring);
-			if (ret < 0) {
-				dev_err(&mhi_chan->mhi_dev->dev, "Failed to read channel\n");
-				return ret;
-			}
-
-			/* Read until the ring becomes empty */
-		} while (!mhi_ep_queue_is_empty(mhi_chan->mhi_dev, DMA_TO_DEVICE));
+		ret = mhi_ep_read_channel(mhi_cntrl, ring);
+		if (ret < 0) {
+			dev_err(&mhi_chan->mhi_dev->dev, "Failed to read channel\n");
+			return ret;
+		}
 	}
 
 	return 0;

---
base-commit: 4c06e63b92038fadb566b652ec3ec04e228931e8
change-id: 20250910-final_chained-750c213725f1

Best regards,
-- 
Sumit Kumar <sumit.kumar@oss.qualcomm.com>


