Return-Path: <linux-kernel+bounces-699567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B5FAE5C6B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 08:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6DD61895BC0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 06:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B101231A55;
	Tue, 24 Jun 2025 06:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BXlVNVWe"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004F32135C5
	for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 06:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750745088; cv=none; b=Vi8ecAJv4ZHIHArljcM7IYJxNDC1YejmaT90+rP0gC5Pxvc+r4SGkxJzWY7DX0lwEenvWbqgSrB+CqI42zvCjgAptY98pso+sjwTIistE2jBfiTPLhVw3Yz2Hjn9z5OIUfuFKIrBjDUoQmzdaMYHNX5suoYQOhmRObFTHE59rZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750745088; c=relaxed/simple;
	bh=5PfRKrG2GQlwzmgsaLI652rauEwE9lVAADzU9VRGpTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dzJ0qeuQFjNH+qzMS60ywL9KFFKM+yigUUkzUiGdfQcC8x6tjAFz0g7yGAt/D00b7DpoB7+AK14vM3WaVlGgIRZSB5YAmA9ku4XqkzK6uJ53YJhCs/1Xc9vcJZhd58teNOeJ0ILkrsCl2z3OxKgPEnHNugM1FrFD26LHzZHtAz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BXlVNVWe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NKlH1T021016
	for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 06:04:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=AACehQz66jGML8jtfQhLKZ7tYZLo0nJOPda
	zO4YxUuc=; b=BXlVNVWesgxqUOvTjzPCQ5ZJc0msLInU21qKJ6fyiUXhjLVIIhP
	c3hcKCqPBLHhzDttiiXg4HPozL1j9XKvZKHbhBBhTXu1TAI20yxMu5DtKNOj4tYS
	qMubIzjPlAWZGyVIut/q8hxuwDzJ8szxkFcChh46iaGCvTcQ9auDRpIwjqY2IvJS
	nqixzPlfMjCjE24qnjwshfqsuQaj89wjz6HzwWFPzK90zTAIqL0DWlQ9E+MxcWdi
	7NGARuzl7Mr8KG3BJ+owZI/MSpkLZOP0EA+mJg3INS1KNyVP/L0LAyFTuhU2lcNw
	joltiArW7Nztmi6GObE2GBXfzQ9awoKrtKg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47fdfws54g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 06:04:45 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-23692793178so687695ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 23:04:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750745084; x=1751349884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AACehQz66jGML8jtfQhLKZ7tYZLo0nJOPdazO4YxUuc=;
        b=LtmZJyzZQFOOJnqeTqk1kd/GogN5d8OaoYzHx0EQCF3t+ngaceMsaf7E+D5AI8U4Zm
         6+ElX/CI8uwHaMeva6fatnp1FShPE7aFOYkMWwfscwqgXAitOBd7fhDakncVIYdHlY2o
         ZuhMrBVq/bvmmXub96KgXJ+yhjN7XljF4ljKKMgDdGd0NA3QV6rmJO+rSiCz0feaqKM7
         o69XD9HTMKbAmMbCiDEPrOlf7+nJRW0g3eQwl6fYjNROy9AU0gPo042t9xp/p0qRLDME
         FhtLlLvM6azRiQlLYsUZpzgVSPekzrxRPWkjg+lvE3J2ecGZIdKIsTcNJoUz+xCChIfV
         c6yA==
X-Forwarded-Encrypted: i=1; AJvYcCUfM5E2Qu4qVmR+DYkvUtKb7TMfOFDuUyB+TmOsDH5zJ0djFQxJFXBd/OqDoZ5bZiskK1A8AZCUI9Fqnbg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy52KZitzkMPRjFd9v980Tj6fVQ9HoM3RhPdE5noZIHaznuI/Ej
	3FeavjTeSO+9EAi5vlN8e9WlPGwZOeQfDDmxXS1eCuBgFuwizAi/BMqe6PvIDDBC9Q4skCz70Qc
	5VshS++Xf1jmd7Y7bqVEMRRPGrer04xk6CA2DAxa3IJQSc43d3VHd/EWONtNeR4Z6WSA=
X-Gm-Gg: ASbGncvEeVKnIvh+r7hv5/VuIC5W+uKpN6Tesgpr9vmKBNwvpnt7nCiEFDLrLKbSLxd
	TqzznwjQfWG7ye24Xyfrd2Ud3ZW1gFbMNwhzCyWM3+akZ7AUMSGlaZlHztYfYDXsQ2V/jNG3AF9
	M/gtZOSV8/7tWsdgmpFW0HIgLlpSuoVtj88rETzjIifnprbHiUsz0bV2NT5fgeLPsvYdpza5gLO
	Daenja6YqcutnKMfz/3sYLstAzIQVrOq5iWuGwdAvh5zsk2jm1CuTVH+rueXBNj4MPn4Dj1j94B
	cjUNOF2T+SigVGwiwmd5PskEO4sROon8mLaCappV2zfIC2yHXLQtC0+/9JpYnSwdJNB1GUPF9tA
	KYQ==
X-Received: by 2002:a17:902:ccc3:b0:235:e1d6:4e45 with SMTP id d9443c01a7336-237d98f3c69mr197464655ad.25.1750745084285;
        Mon, 23 Jun 2025 23:04:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhyCnnLv+KHyzd+4i525LIpKE8PA1HCFGX9nqqpvvzEsPVeUBt24MhWCwVB6lZ0lyOe2GQDA==
X-Received: by 2002:a17:902:ccc3:b0:235:e1d6:4e45 with SMTP id d9443c01a7336-237d98f3c69mr197464415ad.25.1750745083875;
        Mon, 23 Jun 2025 23:04:43 -0700 (PDT)
Received: from jiegan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83937b1sm101371455ad.52.2025.06.23.23.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 23:04:43 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Tingwei Zhang <quic_tingweiz@quicinc.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        jie.gan@oss.qualcomm.com
Subject: [PATCH v3 00/10] coresight: ctcu: Enable byte-cntr function for TMC ETR
Date: Tue, 24 Jun 2025 14:04:28 +0800
Message-Id: <20250624060438.7469-1-jie.gan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 6ocde_9LsBQk5x5StPNMf9TqFx74ICnf
X-Proofpoint-ORIG-GUID: 6ocde_9LsBQk5x5StPNMf9TqFx74ICnf
X-Authority-Analysis: v=2.4 cv=MtZS63ae c=1 sm=1 tr=0 ts=685a3ffd cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=nBcv9sv72UtkhE4thMQA:9 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDA1MCBTYWx0ZWRfX9cXLmpTHaBiL
 D4HUxgN7IwXyXbQC6YjXJwmYQ0p5oWC5UVMx5PIseUQFJJBCOLkm5pxp1HbIQZ8gRDbIEd347mz
 ID/W8O1XGb/gFVdo1l9qGBexMz+Q2I+UMIyJcifkyIRCQDweYlvws2BYvoqpiKIPkhHZbgnlAjP
 GnXS4j6yUTouL6Ss1DOZYcx5ePMDFIB8hzC0D1+CI1Kfh0lUSc+8x4qiQB+o3CctvvfzdG8pF1X
 UEhyb5vzagFOq4gnv7iorgNLvyebL4mgcuvPH3dOhIDBD8Izp+kmwILhteFe8MBqJXfKuW1rMAy
 4YW4EEDmDXmI6fEDyiIwdEP5XdN+iXwd9oxVptreL7nVrVnp67FpmEZ+4P65pMWkKCs4ud7chk7
 5bTo7QaiYKQWrrdQ4xpg5/niLKpsbAyv/NamcrXS1G+9V4t/3+BpFFyti0VYv/FzekeKXtM9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_02,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506240050

The byte-cntr function provided by the CTCU device is used to count the
trace data entering the ETR. An interrupt is tiggered if the data size
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

The byte-cntr read operation has integrated with the file node tmc_etr, e.g.
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
 drivers/hwtracing/coresight/coresight-ctcu.h  |  52 +++-
 drivers/hwtracing/coresight/coresight-priv.h  |   4 +
 .../hwtracing/coresight/coresight-tmc-core.c  |  70 ++++-
 .../hwtracing/coresight/coresight-tmc-etr.c   | 270 ++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tmc.h   |  29 ++
 12 files changed, 691 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-ctcu
 create mode 100644 drivers/hwtracing/coresight/coresight-ctcu-byte-cntr.c

-- 
2.34.1


