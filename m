Return-Path: <linux-kernel+bounces-764325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0912B22190
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B24CB565198
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797412E541C;
	Tue, 12 Aug 2025 08:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eIHbKDV3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117582E2DE8
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987862; cv=none; b=HBn1R9ElgGjZlxqR+CjFnIpZbuBragHqbGf0aSKOaK3wWjvsaV2hQZTKx/oB6uAPHiHH7LD2ZqecjbbjxGTNmKAJrYiI18tT0fzTPWsS4mc7MbA3rjDkIUZC7zO0ahpb6k/SGDWO7czYSxVNoLDLLLZos8j3OlNLEC2WsvLCFZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987862; c=relaxed/simple;
	bh=0VCd99O6LrGYwRbWbx4pM+c1MroHvq/q4GBW97EYiik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qb8lTQG/b8WMIghncqnCJuIuclWu1OOvAvAQgTZMZXLEXCu9Q4gBAsfzV4jNogDT00RMpzrRtN5HFQGK1ZTECuyeRO+M4TPPfSQgramRzlePL6qT5qXbCQdNjf/QcPCG6a5brxkLAWCBqn2a9AsfDwWcmC8g3WwxmWHWif8vLQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eIHbKDV3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C6uRgr008406
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:37:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Z1Lt7mTUh6uvsmhgYSXEZ76GSYjAMP1zqmi
	O1GoGrtI=; b=eIHbKDV3MjUzxC43bePYJ/T1dIk7iaXT8Y5ENuelPQWIoOpzngn
	VJEqyLVOBpnlpQyDIaCahVunB/E0SlDHfmHA/X52SCyDNOqzu7EWlOuquqTGCUZK
	8gq9MgRMQJT5HB2EDth+k/jkZDvYQ0SWn7NJzEZT1bAVF0iw9RqsI5Id+wkI0Uaf
	yFkWHrBhpVqkVh8jRwdg1z/gaxmzNGkrqYwrKtIPoSf2E+EywWYnoQdKzIkO4FCt
	ZYZmQFsI6oKLNm3fMgZ09Q+VCfQJI0KsfltOZImL+ioB0iFnZ69E5YjNJ0tRB//1
	ad36gw/6B0qd5GrmHuOFqmbdLB1cFsOHWNQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffhjk8np-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:37:39 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b42a11d7427so3154302a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:37:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754987859; x=1755592659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z1Lt7mTUh6uvsmhgYSXEZ76GSYjAMP1zqmiO1GoGrtI=;
        b=Y51yFurWRoNu95fzKnOK1U9fo4cmO3zILfRH0LZGkkdl8mSPYe9wuEBcNZ7PaLFFBZ
         mEBMmwaDSip+OVLf02/YubnZEBfEats6fGWtFy2pfva6+gWp01UkkYHskAN+rty2MxDo
         bqykfuzXnx2Z/kloztlJGIm6/T7ALJsV7cxx+WkVNHirZ4jEJIDw/10LMbkuSeEf63xv
         U0pCmbT90+2mhFj2IgYWcjMqyDF7slNcrOO4qe8Zoju0FBxwyG9nUBYYJHt6AX0Pzitj
         /+jpxQp+46bH0iODCtk+DmPz2zAAs0xclGV10XDq5qnrdsgmROwfvMG9o/uVZmQyVh5V
         142g==
X-Forwarded-Encrypted: i=1; AJvYcCXpqsEs9w/pG4VIwgtI8RqIcpuB5r3nvo0YBuak4O7tyri/4rHDhTabFjZY6b8ZQxQ7EPSapsR/MocQ2sE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUYcNTYpzjf6r2AtEVg8ih1XijkBWh0YngEN4S8UJ3XVzogg8L
	6tXQpx5X9SoHVTo9Ba10SvfZB0GuEeqxTiNbGphDIdzzH3DxbYWQrj+HdZbPeEGnkIp2DQ5Wfkv
	aD0WsCsXy3oBjbhiCHi7xjuvsl3aTi6QNJ8HCJTSH+oQCYlgQMQgKNSrCr4/kWAnuqsg=
X-Gm-Gg: ASbGncvsVNYm3D+XR8UepgSHv7zrN79CeirxXIdPBVcKPqYs2Qt6yyKxJGXr4oIkoj4
	nur3qV9Yl3e2ROku9SOMd57Em1wcdo6DyNDQBsbH/GiVC+dje8ZviQ6eoXYDqJXaA/IQV28XHTD
	ZLTLs1qrKMw/0cKafDQUWcm4+MyRXMT0MkUOfFv1A2dI9Z69fO9yZxL38O2IlonqUIldeqHIdWa
	DO+1JWj89/iNZJQmr9Y5TrwRp11Qk3+JYrKaN7+5f3eS0GSWpq/WbNVyMtc5ymjw1Cv64hmChFo
	QrfAAwG9MadP5rkh+t20bJ6rotGvCG6zJLOTAhPUE8z3I+ncrdWFUu0w+3g3HloN0pxjMLE7l7a
	1HB33JHQUZs14VNRLaWs=
X-Received: by 2002:a17:903:1b06:b0:242:c66f:9f87 with SMTP id d9443c01a7336-242fc36f96emr37851125ad.51.1754987858536;
        Tue, 12 Aug 2025 01:37:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOIW2no7OJ6os97Vg5PQyYasdcSRJg5XoXMAC1vlcjWlUPX3TpM4GpyxqBcIUwLHq/CN1fyA==
X-Received: by 2002:a17:903:1b06:b0:242:c66f:9f87 with SMTP id d9443c01a7336-242fc36f96emr37850735ad.51.1754987858089;
        Tue, 12 Aug 2025 01:37:38 -0700 (PDT)
Received: from jiegan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-243086849b3sm1915345ad.175.2025.08.12.01.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 01:37:37 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Jie Gan <quic_jiegan@quicinc.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 0/9] coresight: ctcu: Enable byte-cntr function for TMC ETR
Date: Tue, 12 Aug 2025 16:37:22 +0800
Message-Id: <20250812083731.549-1-jie.gan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NCBTYWx0ZWRfX/uNxOMZzp9S3
 gN+8PJulHi0ueGY9GYl0NXWTCSzy1pS4IfduSVnJfHLeNjS62S6XNQxXNI7pVM53PuZQ5W9SrYU
 OO5WUX0ib9r1zVEiCP/7klzn/1cXvgcBqrUn1Asgh4x3QzGYH1Mv2fYhIUYKNWaIQ15IUM1pPi2
 lxNX+bmsUB0LIa1rgFc8Ig9uRYK80WrSzmZQso/MFu5fQfYYnfLdO9uwUALh3U1Rvj9cSX2N1nM
 i2vPvF/mLyQOJUTtsdCDtxUQFEmM8fXIAAinaR72cdqV5tVZC0HLHFNi8w4TheVwJPGbe8G3IWO
 YYLLMlOvNNSr9UetH8pMqSsHzIbP1B3ZcXrjIfZa6Q/lkYGLjiLXOXz7vp9pISXWHnLpl6zlvP1
 35RsWdT6
X-Proofpoint-GUID: w_rYvgQoEdION7o-Uv6tkjZcW7QR9vi6
X-Authority-Analysis: v=2.4 cv=TJFFS0la c=1 sm=1 tr=0 ts=689afd53 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=4JJaRIKzVo7dG1xzKtwA:9 a=bFCP_H2QrGi7Okbo017w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: w_rYvgQoEdION7o-Uv6tkjZcW7QR9vi6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110074

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
echo 0x10000 > /sys/bus/coresight/devices/ctcu0/irq_threshold
echo 1 > /sys/bus/coresight/devices/tmc_etr0/enable_sink
echo 1 > /sys/bus/coresight/devices/etm0/enable_source
cat /dev/tmc_etr0

Enable both ETR0 and ETR1:
echo 0x10000 0x10000 > /sys/bus/coresight/devices/ctcu0/irq_threshold

Reset the BYTECNTR register for etr0:
echo 0 > /sys/bus/coresight/devices/ctcu0/irq_threshold

Changes in V5:
1. Add Mike's reviewed-by tag for patchset 1,2,5.
2. Remove the function pointer added to helper_ops according to Mike's
   comment, it also results the patchset has been removed.
3. Optimizing the paired create/clean functions for etr_buf_list.
4. Remove the unneeded parameter "reading" from the etr_buf_node.
Link to V4 - https://lore.kernel.org/all/20250725100806.1157-1-jie.gan@oss.qualcomm.com/

Changes in V4:
1. Rename the function to coresight_get_in_port_dest regarding to Mike's
comment (patch 1/10).
2. Add lock to protect the connections regarding to Mike's comment
(patch 2/10).
3. Move all byte-cntr functions to coresight-ctcu-byte-cntr file.
4. Add tmc_read_ops to wrap all read operations for TMC device.
5. Add a function in helper_ops to check whether the byte-cntr is
enabkled.
6. Call byte-cntr's read_ops if byte-cntr is enabled when reading data
from the sysfs node.
Link to V3 resend - https://lore.kernel.org/all/20250714063109.591-1-jie.gan@oss.qualcomm.com/

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

Jie Gan (9):
  coresight: core: Refactoring ctcu_get_active_port and make it generic
  coresight: core: add a new API to retrieve the helper device
  coresight: tmc: add etr_buf_list to store allocated etr_buf
  coresight: tmc: add create/clean functions for etr_buf_list
  coresight: tmc: Introduce sysfs_read_ops to wrap sysfs read operations
  dt-bindings: arm: add an interrupt property for Coresight CTCU
  coresight: ctcu: enable byte-cntr for TMC ETR devices
  coresight: tmc: integrate byte-cntr's read_ops with sysfs file_ops
  arm64: dts: qcom: sa8775p: Add interrupts to CTCU device

 .../testing/sysfs-bus-coresight-devices-ctcu  |   5 +
 .../bindings/arm/qcom,coresight-ctcu.yaml     |  17 +
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         |   5 +
 drivers/hwtracing/coresight/Makefile          |   2 +-
 drivers/hwtracing/coresight/coresight-core.c  |  59 +++
 .../coresight/coresight-ctcu-byte-cntr.c      | 368 ++++++++++++++++++
 .../hwtracing/coresight/coresight-ctcu-core.c | 108 +++--
 drivers/hwtracing/coresight/coresight-ctcu.h  |  62 ++-
 drivers/hwtracing/coresight/coresight-priv.h  |   4 +
 .../hwtracing/coresight/coresight-tmc-core.c  | 104 +++--
 .../hwtracing/coresight/coresight-tmc-etr.c   | 110 ++++++
 drivers/hwtracing/coresight/coresight-tmc.h   |  39 ++
 12 files changed, 824 insertions(+), 59 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-ctcu
 create mode 100644 drivers/hwtracing/coresight/coresight-ctcu-byte-cntr.c

-- 
2.34.1


