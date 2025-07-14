Return-Path: <linux-kernel+bounces-729465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CADF2B03718
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28C5517487C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 06:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D49B2253A7;
	Mon, 14 Jul 2025 06:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XhAP8100"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE5320B7EC
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752474681; cv=none; b=ArPFtb67ZL2LLI4zMkMuRIP8grxBesz9e2ayHE3cJXAInHu7JT4RfNDpHeac1T8QJ8P0K9G8xzsnir9S88PFsH5rV2QGPTe+qMIm2Rw9BSFwLpoWSAJPA5tAYww3LZ42HC5PAylXVhNbaBQBFNB6V4KEU9Icp0IacJWj21L6+Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752474681; c=relaxed/simple;
	bh=+wPOWYKwugoIf8mklL3U53Tn8gBLZL7yLlWIIj4mpnw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tLZ39CKhQkOt42J2nJbwF3fG/teZXphXdE5+DMQxIDv6TFtuVeVUXZQ9l9T6FzrDcyJVUcwfY6RTiy7u4R4aNHSZZ7+k4kUGiVlyT/MnFZzGh2Bg1G+btXJZsul/Ld8k4W79N/rly4wzHSLi0N7JEKnAktxPC+PxKzTf1tGZsLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XhAP8100; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DN02bP001306
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:31:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=0wqXPJCmIO0vUREoCEbzWcWX5UzhT3+oWJ/
	3YK7SaqA=; b=XhAP8100rPlBQ50pSDQ+lHvfwHFkb6Xjs//lS5nBhJig58p/NQJ
	tLektCMGsNISv8FI8PfXqecQ+u4Pis2ZpCbAJSVmqnmYkBqjDTC4NaO5YeUT9LOv
	X7IL5F9NZiMGzHYaloCMbUYTs742r+5JcwtHEvznLVre9IGhylOVRKq6JTP+clin
	6a9t0Y5scbsiznIU8VK/reUGVNp57qeFf76jimiVkyw9g7PxR7mnTAvuztGjA2w8
	bGJR4GY5vYU8a7JX1AoRrCVOMmXiPanziqGoIdLxKTHoaKHfqYMSo07NToSbKnsR
	ejmjqQhn/3ZqPeH9tSgeCJtvO/A28TfyQow==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ug37ufdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:31:18 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23824a9bc29so55747775ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 23:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752474678; x=1753079478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0wqXPJCmIO0vUREoCEbzWcWX5UzhT3+oWJ/3YK7SaqA=;
        b=Em+yboakjnfaJBC6K9r4M2X/GL9QRusQ8/EgLcoXNoAS6zrB/K9bY9gkw8GhdJNV8Y
         lfYWegslVNlIwTKquZrMSF3BRqoK0FdqdkqrQvHWpKxE2nCRx1BSn0oQRKLDlGSaiNaw
         HWccUqu2XPls9iO16ecO3XzwaNRuV7qtqbOWTHA/icZlgZ6yYUqUqt0wTOzP17b1aiuj
         TxS84F+wEFlOZ6h9k9RMYY80AyQBvNauIixjUv1eAoHb2CYWbvd6Mh28v1J0tKRXJjcX
         LGeG12VmnYmpytXOTl3oBC3OuKWFHK8wKHt7cTi6+ZPom20+rvSP8FwiH4589L+hvkrH
         uHxg==
X-Forwarded-Encrypted: i=1; AJvYcCUtezgMbBCRvTKUIHVYnBWvNVk20lQUp0uKXwHxNjbfnHTLe3WCWhnk6z6+c0K+ci4Og8JVrz+SR+vmRzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsdPo+TDf+m9RFwV0cQvznz7oQ6vsthahhcIDsqP/Beo4OP7il
	UXRjBOPDBF1HRccWd1nfBwTu08UC3BB+dq1ryl16tBWfr1a0qF9tLjxODz/xYPKCRaHo356i9FM
	STJYyuAJyarADknXdybMvSSegy8EwZSCzRQZYnEP2uam0VTjTHbnkUAa0RW0FjaO7sj0=
X-Gm-Gg: ASbGnctp5JJO4u6hfLDXSZdHcEBpGBWEo6VSsXmIhaeidEUM9oUNo55Zw0dnJbzOmE6
	0tbT1ki/GWz+p/TmBaugNfnVxsN1z55wx/etXZtWc6wD6/iN5bhgphY9MQjiXJJPd0uXipyUZkc
	rdYaH8DFAbpxHTt4pR2K+gYW0ySLwDfkjGfg9MaQ6M5bqHzRgLc0HgpXk3FoI9XshGH7l9NWNvo
	WpCC0WkCqRtc+BpSdYx0YRaXtm2PEmB8uzmxw6mROSAsu6x+ldiQnnt8RlTJNRBeDKgAa6HNRPb
	W49itTxrnIBGp8YGkyvErZRb508Ig3dkB5BLT8Hci2nzow5Egmj3YApzSp8lxFqRtAubD2N4EcS
	xxhrJnOQbHm5hMCbzEIB0
X-Received: by 2002:a17:902:e54d:b0:235:f078:4746 with SMTP id d9443c01a7336-23dee263c53mr150587475ad.42.1752474677604;
        Sun, 13 Jul 2025 23:31:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPLKAuifJqLzIISS3WOtiE7PpBWt3Y0U9Des4cLciVFaSNQhBO1Bz9VSSEWj3nEmc8jMwwxA==
X-Received: by 2002:a17:902:e54d:b0:235:f078:4746 with SMTP id d9443c01a7336-23dee263c53mr150587005ad.42.1752474677123;
        Sun, 13 Jul 2025 23:31:17 -0700 (PDT)
Received: from jiegan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4334005sm86138255ad.158.2025.07.13.23.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 23:31:16 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Jie Gan <quic_jiegan@quicinc.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 RESEND 00/10] coresight: ctcu: Enable byte-cntr function for TMC ETR
Date: Mon, 14 Jul 2025 14:30:59 +0800
Message-Id: <20250714063109.591-1-jie.gan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAzNyBTYWx0ZWRfX5qWdn+DbB2eT
 bnptNoqv/AbNYM4l3BaE8m6AnS9TjcZjiYyJrgq4osl8uIsPGVIvHe8mqX3FR9betv7vvFi9v3z
 ZJKROSPcIamFg0QzD4QpixefvUOZRJKGHmxO4c7xWzgw2MuNEDeMXxKSdyWb/tWoiR3pfq2Oy8I
 6KWPTApOGRT5xEojqvvIdx2nGh2UDoWru4kCogC5nUskiljRIdZrrwdLOkZrcv/3EOJh64owgLf
 2zeu8aNued8ZxEfmMGU9d+owrlebeuLtf5LrzxEVXqYcyyjPHYt4tn6UouzYNZLqqzlx+Ot+U72
 b85eYKqdpRU9HuafGMXG6uAtMX//CvlikYI0ICeXkAnb6EjCVoPB+6sBs++qp8sTE+ysNWT1AI8
 sl1ZDbprewEuJ9UhzXrJPefTISDGud1+/8j7oQUV558H3bE53RXVZ1wIMYqJ911YLVBhOs+L
X-Proofpoint-GUID: vtLqGS0DMETOmR48TKbh6_uFiLI44Oiw
X-Authority-Analysis: v=2.4 cv=SZT3duRu c=1 sm=1 tr=0 ts=6874a436 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=nBcv9sv72UtkhE4thMQA:9 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: vtLqGS0DMETOmR48TKbh6_uFiLI44Oiw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140037

The byte-cntr function provided by the CTCU device is used to count the
trace data entering the ETR. An interrupt is triggered if the data size
exceeds the threshold set in the BYTECNTRVAL register. The interrupt
handler counts the number of triggered interruptions.

Based on this concept, the irq_cnt can be used to determine whether
the etr_buf is full. The ETR device will be disabled when the active
etr_buf is nearly full or a timeout occurs. The nearly full buffer will
be switched to background after synced. A new buffer will be picked from
the etr_buf_list, then restart the ETR device.

The byte-cntr reading functions can access data from the synced and
deactivated buffer, transferring trace data from the etr_buf to userspace
without stopping the ETR device.

The byte-cntr read operation has integrated with the file node tmc_etr,
for example:
/dev/tmc_etr0
/dev/tmc_etr1

There are two scenarios for the tmc_etr file node with byte-cntr function:
1. BYTECNTRVAL register is configured and byte-cntr is enabled -> byte-cntr read
2. BYTECNTRVAL register is reset or byte-cntr is disabled -> original behavior

Shell commands to enable byte-cntr reading for etr0:
echo 0x10000 > /sys/bus/coresight/devices/ctcu0/irq_val
echo 1 > /sys/bus/coresight/devices/tmc_etr0/enable_sink
echo 1 > /sys/bus/coresight/devices/etm0/enable_source
cat /dev/tmc_etr0

Reset the BYTECNTR register for etr0:
echo 0 > /sys/bus/coresight/devices/ctcu0/irq_val

Changes in V3 resend:
1. rebased on next-20250711.
Link to V3 - https://lore.kernel.org/all/20250624060438.7469-1-jie.gan@oss.qualcomm.com/

Changes in V3:
1. The previous solution has been deprecated.
2. Add a etr_buf_list to manage allcated etr buffers.
3. Add a logic to switch buffer for ETR.
4. Add read functions to read trace data from synced etr buffer.
Link to V2 - https://lore.kernel.org/all/20250410013330.3609482-1-jie.gan@oss.qualcomm.com/

Changes in V2:
1. Removed the independent file node /dev/byte_cntr.
2. Integrated the byte-cntr's file operations with current ETR file
   node.
3. Optimized the driver code of the CTCU that associated with byte-cntr.
4. Add kernel document for the export API tmc_etr_get_rwp_offset.
5. Optimized the way to read the rwp_offset according to Mike's
   suggestion.
6. Removed the dependency of the dts patch.
Link to V1 - https://lore.kernel.org/all/20250310090407.2069489-1-quic_jiegan@quicinc.com/

Jie Gan (10):
  coresight: core: Refactoring ctcu_get_active_port and make it generic
  coresight: core: add a new API to retrieve the helper device
  dt-bindings: arm: add an interrupt property for Coresight CTCU
  coresight: ctcu: enable byte-cntr for TMC ETR devices
  coresight: tmc: add etr_buf_list to store allocated etr_buf
  coresight: tmc: add create/delete functions for etr_buf_node
  coresight: tmc: add prepare/unprepare functions for byte-cntr
  coresight: tmc: add a switch buffer function for byte-cntr
  coresight: tmc: add read function for byte-cntr
  arm64: dts: qcom: sa8775p: Add interrupts to CTCU device

 .../testing/sysfs-bus-coresight-devices-ctcu  |   5 +
 .../bindings/arm/qcom,coresight-ctcu.yaml     |  17 ++
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         |   5 +
 drivers/hwtracing/coresight/Makefile          |   2 +-
 drivers/hwtracing/coresight/coresight-core.c  |  54 ++++
 .../coresight/coresight-ctcu-byte-cntr.c      | 102 +++++++
 .../hwtracing/coresight/coresight-ctcu-core.c | 113 ++++++--
 drivers/hwtracing/coresight/coresight-ctcu.h  |  49 +++-
 drivers/hwtracing/coresight/coresight-priv.h  |   4 +
 .../hwtracing/coresight/coresight-tmc-core.c  |  70 ++++-
 .../hwtracing/coresight/coresight-tmc-etr.c   | 270 ++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tmc.h   |  29 ++
 12 files changed, 688 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-ctcu
 create mode 100644 drivers/hwtracing/coresight/coresight-ctcu-byte-cntr.c

-- 
2.34.1


