Return-Path: <linux-kernel+bounces-832344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F70B9F056
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 982A61BC7DD5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CBC2FD1B8;
	Thu, 25 Sep 2025 11:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QrgsvBkZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02992FD1B5
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758801269; cv=none; b=R3s5JykHpidcDCw0fPIVln3xbnrt6jU/FZJTMDNJJdbi+RMNZq74ex9YGcseIKRdECwh1gAigyecf8OgaPUJhyl/mc9PeRRkavGVo58appg7KLUbMNF4k31W+ITrE6OJJYaICI8eJu3mkEa2+BqO1uNKPstZ/ougRkazSs+Duqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758801269; c=relaxed/simple;
	bh=9jsK4VDmm7LJ+YLkeBDIcPI7vSmCmKyAZvCHjfEz/yY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ndy363QnHAiDjnLRcjFf3lQkm0Pt5vQJ6wS3sY4QtarccfE6oVXjt8nddpkCGzjeARmR+Zw78iQa3giNDpqNZS/pB7zyqOkF+KxNY6P5EE9xpCgmCbgdWsEOxUsbzXvVmkU6BJ/mYWvn5nrOZVPCKiaaoE68zlQsTI5AC8DZ5t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QrgsvBkZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9EH4w001842
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=IcQRAOQdZqK
	M5AAtXRvgWEwEH/H9DHPEDvxp2DSgWr0=; b=QrgsvBkZkXweqgEzKz8xzjo9lgS
	I4Cghic1LlrUsLqMIP8m7p7zPQ3MgN9s/WliDzuNgDOEZ0pj3ViDdMBXWMQK3dwL
	FnVBHQ6qBhtw6K5ygFitmI0ljz72D1FGORKkrTLXRQsct7Nj11u8Ki/Y95SD6Xnt
	1tAuSqs9DqteamJvRCwJnzX1H0LVFGeJ85CGlKfiAPKrdsLTXl0V7kWPKfnKHP+v
	DP2BIR76fE1UUGpnFXhlYtdc6m1tsXXFbOkwd2fofWXsUXvf5e2yrWqFPK4b8W17
	zXnvnOcS9lqOM+G0pcBtMSoINzruztAWlcyIbAyChKAlvR/98V5pBtAV4xA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k98qxb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:54:26 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-277f0ea6ee6so10402775ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 04:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758801265; x=1759406065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcQRAOQdZqKM5AAtXRvgWEwEH/H9DHPEDvxp2DSgWr0=;
        b=OdGYRoskXh17Ioi1cc5yl8OyW++CrvECY/+EdyaUH32mZoAbALwVJ/QUfwZN5HokbS
         2B4OCeNo2zE5Mk2GFMeLOKJLKYQDaWW/AApF3R8mdGXPG2FCl2BYFbAnGZol345aXZKq
         Cb6hW7KyS7GNJOEKY3S05Af31DC/HHyC8F17/4ZhpPwUDgX80b6bKhVyOz8qYkVcSZeE
         T5snZbiOGq8YZw2I27wYXWbyCWr32hv1QZK4ObEOJz6NAM1pbkd8fWjy+5wLs8uWDx18
         KL1jDr38MCHpGoNxn/rk3H4ccvuuGt7Lb6hV3BTHG3/Kp2mPmwjO6xsPUNCE3JSdAvMH
         alBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU28E2zV/RHCDXnBpjhlEd/WGbF+EtTDGFxbz+wdqVSku9OH6HYWQWwEd9ZuNn5ebjlgShIHmtep3MmQwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXT+3uo7iI84g8HB8MBmDhZbBX458l691+WUcvsjk1GtMrIVnf
	Y6FlGLbsoP2by/Xd1lUuZcCN8wqimH1VnN50hZaiu020teiGXSXH8f6oAbXSArLDumPpAhEEG9v
	zwWlmirjFMhMGUyOoJ0WDq3v8OKyw5ac7sQoTjEhEPGfK2AR+mqfB5Gangf3FCy1wH6E=
X-Gm-Gg: ASbGncssFp6tCIgbUlv+DQqQ0mR+YunnMOmh/mNo/epY4Rfy1yfIybVMMWi8Gdf+H21
	sx4nWmdGz6Ctno7Q7cKuHPS2CBn0/89QSEAgMk8JOfhQgnjp1U79IF69LO3zlgDoGsh52u821GW
	32E/rbOx+O4mVmboHyllyc3toeQk/eAxAibCukQUxRE91STE9kNC/KEZf+1Pi9Pj90II/AqEWdF
	JaAP0VoUyAobgzoFTQwcC1wnqMh4OAZvs3GPF1Rl0MaC8cn0ULpgBpH/yxaSyFmMhU0Yz2769vr
	dn1+LQkG9Cma95srIWtnYN8wMJVxdfvgCq8dAIf6oXbt1PT99EUX5uxDvlNSd6pabwtPX1IA234
	=
X-Received: by 2002:a17:903:3884:b0:274:3e52:4d2d with SMTP id d9443c01a7336-27ed4a76e00mr32338005ad.37.1758801265288;
        Thu, 25 Sep 2025 04:54:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9ckvMkGt+IFhS7y1WdXrjnERoOor8+C8TXNTMEGz1eO6XtWc6VahcrWBEIiWDA6gEc4+jIw==
X-Received: by 2002:a17:903:3884:b0:274:3e52:4d2d with SMTP id d9443c01a7336-27ed4a76e00mr32337705ad.37.1758801264692;
        Thu, 25 Sep 2025 04:54:24 -0700 (PDT)
Received: from hu-jseerapu-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69bb502sm22087935ad.118.2025.09.25.04.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 04:54:24 -0700 (PDT)
From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>,
        Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, quic_vtanuku@quicinc.com
Subject: [PATCH v7 RESEND 1/2] dmaengine: qcom: gpi: Add GPI Block event interrupt support
Date: Thu, 25 Sep 2025 17:24:11 +0530
Message-Id: <20250925115412.2843659-2-jyothi.seerapu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925115412.2843659-1-jyothi.seerapu@oss.qualcomm.com>
References: <20250925115412.2843659-1-jyothi.seerapu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: knyVw9ql08bH9IUAVL_QrFDzpTCS2RvP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfXzx44BAOm/oHJ
 aODFzxdPONmbofKTgC1nouNFc4nS7XzhmwSQMXWXMKjxYt93vtYX6eGoZIv3w5/xvxXqDvHA9nE
 bR5GVDS4A4GE7qWNjBqxOvHaIbioSxijpWjY6P5AXEOiHZUTpK/JAqdsxzCgXjN2QBlpjK+9sB7
 fcEI7pvvEq7XaBsUD5XrPmAzJ+XPK3ywaVeEC9XE4mIQNMs/kdSz9b9sy8FSLPTv4ULPO/mdptV
 6xo7GDQDmMcNiYOI2nsiP+r1XSxd1Ou/F5dcwqKEeAjZPDUmxTPlJEQRLkNA1ZIQsRjIyC/RfzZ
 gMviPDwZtp8A4BTpTUmRNoiAjGLmrD7siuarSz0EXH7O2ctdGElaG/jKyFY+e0AqUBrfxnyUBAM
 35+Ki9jE
X-Proofpoint-ORIG-GUID: knyVw9ql08bH9IUAVL_QrFDzpTCS2RvP
X-Authority-Analysis: v=2.4 cv=Dp1W+H/+ c=1 sm=1 tr=0 ts=68d52d72 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=hwQltXbWhlPaccoBuB4A:9
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018

From: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>

GSI hardware generates an interrupt for each transfer completion.
For multiple messages within a single transfer, this results in
N interrupts for N messages, leading to significant software
interrupt latency.

To mitigate this latency, utilize Block Event Interrupt (BEI) mechanism.
Enabling BEI instructs the GSI hardware to prevent interrupt generation
and BEI is disabled when an interrupt is necessary.

Large I2C transfer can be divided into chunks of messages internally.
Interrupts are not expected for the messages for which BEI bit set,
only the last message triggers an interrupt, indicating the completion of
N messages. This BEI mechanism enhances overall transfer efficiency.

Signed-off-by: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
---

v7 -> v8:
   - Removed duplicate sentence in commit description

v6 -> v7:
   - The design has been modified to configure BEI for interrupt
     generation either:
     After the last I2C message, if sufficient TREs are available, or
     After a specific I2C message, when no further TREs are available.
   - In the GPI driver, passed the flags argumnetr to the gpi_create_i2c_tre function
     and so avoided using external variables for DMA_PREP_INTERRUPT status.

v5 ->v6:
  - For updating the block event interrupt bit, instead of relying on
    bei_flag, decision check is moved with DMA_PREP_INTERRUPT flag.

v4 -> v5:
  - BEI flag naming changed from flags to bei_flag.
  - QCOM_GPI_BLOCK_EVENT_IRQ macro is removed from qcom-gpi-dma.h
    file, and Block event interrupt support is checked with bei_flag.

v3 -> v4:
  - API's added for Block event interrupt with multi descriptor support for
    I2C is moved from qcom-gpi-dma.h file to I2C geni qcom driver file.
  - gpi_multi_xfer_timeout_handler function is moved from GPI driver to
    I2C driver.

v2-> v3:
   - Renamed gpi_multi_desc_process to gpi_multi_xfer_timeout_handler
   - MIN_NUM_OF_MSGS_MULTI_DESC changed from 4 to 2
   - Added documentation for newly added changes in "qcom-gpi-dma.h" file
   - Updated commit description.

v1 -> v2:
   - Changed dma_addr type from array of pointers to array.
   - To support BEI functionality with the TRE size of 64 defined in GPI driver,
     updated QCOM_GPI_MAX_NUM_MSGS to 16 and NUM_MSGS_PER_IRQ to 4.

 drivers/dma/qcom/gpi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index 8e87738086b2..66bfea1f156d 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -1619,7 +1619,8 @@ gpi_peripheral_config(struct dma_chan *chan, struct dma_slave_config *config)
 }
 
 static int gpi_create_i2c_tre(struct gchan *chan, struct gpi_desc *desc,
-			      struct scatterlist *sgl, enum dma_transfer_direction direction)
+			      struct scatterlist *sgl, enum dma_transfer_direction direction,
+			      unsigned long flags)
 {
 	struct gpi_i2c_config *i2c = chan->config;
 	struct device *dev = chan->gpii->gpi_dev->dev;
@@ -1684,6 +1685,9 @@ static int gpi_create_i2c_tre(struct gchan *chan, struct gpi_desc *desc,
 
 		tre->dword[3] = u32_encode_bits(TRE_TYPE_DMA, TRE_FLAGS_TYPE);
 		tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IEOT);
+
+		if (!(flags & DMA_PREP_INTERRUPT))
+			tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_BEI);
 	}
 
 	for (i = 0; i < tre_idx; i++)
@@ -1827,6 +1831,9 @@ gpi_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		return NULL;
 	}
 
+	if (!(flags & DMA_PREP_INTERRUPT) && (nr - nr_tre < 2))
+		return NULL;
+
 	gpi_desc = kzalloc(sizeof(*gpi_desc), GFP_NOWAIT);
 	if (!gpi_desc)
 		return NULL;
@@ -1835,7 +1842,7 @@ gpi_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	if (gchan->protocol == QCOM_GPI_SPI) {
 		i = gpi_create_spi_tre(gchan, gpi_desc, sgl, direction);
 	} else if (gchan->protocol == QCOM_GPI_I2C) {
-		i = gpi_create_i2c_tre(gchan, gpi_desc, sgl, direction);
+		i = gpi_create_i2c_tre(gchan, gpi_desc, sgl, direction, flags);
 	} else {
 		dev_err(dev, "invalid peripheral: %d\n", gchan->protocol);
 		kfree(gpi_desc);
-- 
2.34.1


