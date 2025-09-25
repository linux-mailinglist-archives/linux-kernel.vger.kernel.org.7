Return-Path: <linux-kernel+bounces-832356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEB1B9F10E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ED89386CD1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A4F2FE04C;
	Thu, 25 Sep 2025 12:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ofo94ddN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403BF2FE576
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758801662; cv=none; b=XnLeU490p2JZtAnlFGiA64J0M935CHHjiaS09XhNMDxOvcQPLI8EE/ZB0J8AIkDpcjn2iw+l42WdNE73qS3KnaL5ZxHA2XDk4Q3bwXRhAl9UCo9gCCVKH2TZNDPaiZNWh5OeRXyaXOhnNU6/ENyrlIpL3OzecST1CIhUMcTlwcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758801662; c=relaxed/simple;
	bh=9jsK4VDmm7LJ+YLkeBDIcPI7vSmCmKyAZvCHjfEz/yY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FekjeFDbsvViJl6RumI7xCKTkegEvLJZK0O8ozr8MLe3uMNmxUyOBYvQqLbvVu/x1DHovPckHnLNcbrNMti0RM3Oy1kuuMwLfaRX7kzUThMo5AdNDFAB79flrVoIdFMU42l18HEFttLtwubQ+rOps7zZB+kVTDfsBir71fehsS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ofo94ddN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9gCpm002400
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=IcQRAOQdZqK
	M5AAtXRvgWEwEH/H9DHPEDvxp2DSgWr0=; b=ofo94ddNFVgvb9Xr0nweiMXmFz+
	4+GYBuXkhtS+9zcH43zYqtSFPkPEOqrDg+3/GY2jcsTMVl6+rfm73jV4/reNfQL3
	W6O66xNNhekYiSuyRVnuuBLRJCXFRiVcE+LXy9UYIJYVErtixh7g+97PNFReBBvi
	AYcJpdsw31W+/rOEDA46CCUhnbJLWSdGVgLTt5N1QY7akautuFp24+o39ve15R+i
	FFME/V9iLOoKAKl3lDUsvZkf7cE+l1mpEljpG/sNhIpbg54w/jXz4l/wdukZF0Py
	9qVNuBGG5EpHw073FSpaPnPjfbeU6S0Vn/MR7CKBuW2WefND9M8ouFMg40g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k98qxxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:00:59 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-244581953b8so9639825ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 05:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758801659; x=1759406459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcQRAOQdZqKM5AAtXRvgWEwEH/H9DHPEDvxp2DSgWr0=;
        b=CKYhIPTj/ND508xaTCAbnBFEEalXB+A5CnshHPsr5TACFG9RmZeYlbpXRFK41pI1dJ
         83zpLOv4h0+wuL9DnZNNMXTIPDsN/ud9ghDAoK++ul3uN0VNQxvzD7Y5tfo4jEorMta0
         4+CUROnBcXkQ10r6CKmVDhA9WrEvdSzDcAb3UtH/vdGmJ/HRqBzZMDcNl5958Rbg2c0k
         JNnpNreBBqnfcCr9xF00lmOWazVmhe5bA9Pta6lGC3DUFeFIyBQ6g96crSJ7HVTHcbiK
         XaSn9isPw2dpC/U8e++MsnwzYYaeDYU761zzytMHsQjV8ROt9coAe2kVHalERnckL2mQ
         2qKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeMoqRp3/8pJLIxdrVA0WMcncED5WPuHuyUtp+I7Z82uJwXOxpaibkB8ljUFYyAEIRdMtCogivq5BLfeM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx4waealHHuoPzzMGbuhhhWtug7TSV+fVU8ZldOuOYlCiblNr3
	DZ+M/1zDs97wt+lyQ8Y52xsSC/p52jzp8rfVdcH7ocDM3D0FKjkc/TBA0szpHsWGg0s9mFh7d3J
	6d5EHp9+nNZWCvB/FF5W3ejsD6WBnaZkxu9DwYE6H2nfb4n7dGb3QXZbSbIJJpNKgV+M=
X-Gm-Gg: ASbGncu/fwVWrevsNFLD/aQDq4HfyFd5AA6DvbqSSWZDKiO16guyv47S6qyQr+9DWIS
	seX/GdgjqftkpzhoT8F5A2vsb6TiVNdtwteu/ZIApP2a/9XLSpzzBm2gv++Tqh8+uu7Bv/iXJC2
	ouiONvK0/Ls3HkV/UO86g8yRXA++Mc/d+YAf/1Wx7IMHHKPulQTZs258oCTXxC68b88110MsG8y
	1Uy6zbRQnjoE4Y0m5bjbKintxqGSlB0DtR2X/Bd9P4hCmkCqT80yHy+CF49hC9wP7UqOD8R0mjy
	n9fk6npKPMTF32GSoP3w+DXoadBZfFZOanI8lH5pi4tY4Q+MdNWZSxRNbfWRVGgfbLDxv+xjgB0
	=
X-Received: by 2002:a17:902:c40b:b0:27b:472e:3a23 with SMTP id d9443c01a7336-27ed4a3e0bamr37683295ad.14.1758801658357;
        Thu, 25 Sep 2025 05:00:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7fGumgQ6JOPyH/fSwTAK6EGGHDGgY01Kvp+O07ZDrk9v36JqaRmQzhWX1MAjvJ0hmce/VeQ==
X-Received: by 2002:a17:902:c40b:b0:27b:472e:3a23 with SMTP id d9443c01a7336-27ed4a3e0bamr37682445ad.14.1758801657390;
        Thu, 25 Sep 2025 05:00:57 -0700 (PDT)
Received: from hu-jseerapu-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69a9668sm22266585ad.112.2025.09.25.05.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 05:00:56 -0700 (PDT)
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
Subject: [PATCH v8 1/2] dmaengine: qcom: gpi: Add GPI Block event interrupt support
Date: Thu, 25 Sep 2025 17:30:34 +0530
Message-Id: <20250925120035.2844283-2-jyothi.seerapu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925120035.2844283-1-jyothi.seerapu@oss.qualcomm.com>
References: <20250925120035.2844283-1-jyothi.seerapu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ZwuFgA1LK8aUpuchgvK8qgsd3Nc2c9mt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfX/GsjcpSUNYmD
 zw+yLUqG6i1/yOd8ipitAq3AlJMYvcoTDPFZQVXj4/Ngs0yzyoHGDiLsKujv1sGpQKYDJ2wmhLN
 xI7Js5uGN2aPt+8rQymHWENvz8TSXQcvfRVe4oZpc2B49hZwWRDQyAmbsH8uP9fBrP0qxTGaw1v
 x3SdCZG2sYIiJCEaHLCp3EvfxyhH202+0mgsJs4UatqOOb97906uo7R25klQj9HV+caPlLVGSJk
 3q2l5zgcnzusG7BEF3tc8q814Ci6znEpHBDKF6MdVFhdHbrDpXfX7YgH4T69wl0TZVrmlT5F5aR
 0DprdEGL0zBVqTsZElvYBd5g3DcgNGZYHQ5FIGlnHMR3TVQVbZLsVODDUJyNnn4UiSdbHMvCLTv
 ayA/4O+S
X-Proofpoint-ORIG-GUID: ZwuFgA1LK8aUpuchgvK8qgsd3Nc2c9mt
X-Authority-Analysis: v=2.4 cv=Dp1W+H/+ c=1 sm=1 tr=0 ts=68d52efb cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=hwQltXbWhlPaccoBuB4A:9
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
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


