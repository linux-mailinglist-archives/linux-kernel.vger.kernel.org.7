Return-Path: <linux-kernel+bounces-873113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 305E1C13249
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 792E234FE8E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 06:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41CC2BDC34;
	Tue, 28 Oct 2025 06:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dzDC5idH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2973917555
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761632895; cv=none; b=ocRH/6m7fm/xuILGUeBK7AV1bYzC4e+uUujBUgbQe1POJA8wIYJ0gr8ecb5tE0uLG+3rDhP91gAdp/yYhmRxV+hp8RuJGHIxg6O7X1AEvZ1K/ocVEFsyMWyb/qAfM5v/jp7NVCLi9h1QhBIoxHV9SCYD1ywipQzhQFypITuS1iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761632895; c=relaxed/simple;
	bh=6PnlglbBdA+sT72qw9FSQQcvFbM5sLJUf0oCBFAlNsY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DmhpnKoi7unQQoeMfgwm1lR9qylmI4A/8BxXKl9an6IK72ZU8f2Z85oeI/sLDdyD7PRtzB6XAzm7/ZELIDnDWdPtMtMbME3WdJByOMVOzqHW742wdatAuGwTTlX/WFhruTsjcy/JTTtR08UOBQQKAW5KJoF9phXxxqa6MFaTdOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dzDC5idH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59S4ABgO552820
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:28:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=JLnYbqr9msvD1/79xuZ9kB
	CdhSNS4ncRjKXElM3L+tA=; b=dzDC5idHe0Jxo91n7QH8zNFdFHQw4ZgpsTIOv1
	Q0pHCZGi+FzlQQjUK26QRIxsY2drrWPIF9SSqFmZfy35UpyYFD73HJgs4t8l6m1n
	pZ4Vl8O5xqLJgoyNbaK7wtluIydB0eroX4WqEK+3MSTv+01ZyzbbwmjTQeet2kmp
	YVMEQxWppgkrKtzf8rM6mPUqz1MdoRAW8qPiUK52qSlEB2aCMsVjM9PGjV0HSqUu
	zV9i5BvMYbt4xizCzFcsSkfDxhqnzJVQNzCcC8P0KIntjd1/M61Vs8921aL82YZ9
	IJs24ENyZtBkKdt34z3hUcyEwFlsl4G7T9VbqoO2aY2ALBSg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2pjf8a31-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:28:13 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-26985173d8eso144112975ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761632892; x=1762237692;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JLnYbqr9msvD1/79xuZ9kBCdhSNS4ncRjKXElM3L+tA=;
        b=iyRRlWauySY9OjN4C1OqfLt7fcaMNmqvl3dVa5PDetSD+S5jZX0uwBnCPb/stZ4hHG
         xgYQRaMLeQAN4DkKEaZdzgJagxZliseLAcC7HQUmrUtNezJdKen4egtE3bg9Ul0Q/puh
         51mW65tfQy5LEQcu60KKTNSY0zCXFA+Zu8+6Txotnz6WcSN1j/jGK5VbWrNA9uiqbyUT
         N/u2tTODUyayfl12TOeqyLSdearEmsvOa6gMZmk5xbJ6AOXe8hLCnI5coDAPHMF1DNoY
         BvAIAjngnnWYval6qEPJi4KlvGVpQRyaV+0ZDlQZn6RmAD0UTnxRtTtjE0QEU8wzf4J4
         jqWA==
X-Forwarded-Encrypted: i=1; AJvYcCXsIl8gM0O/cBeTxiKGVbdLT02qBqUXc2duUhmQVdWoQhUrExpZkHM5zfyRCdWz9hsdMZR2y0alotU374E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdcFWnhLwoHZ2FcJnL/CorNijkqubtawyDzr8YT2Ig5Zwj8V08
	PuIRLhwlx5YEdNMiosXjUxIwQ1YmcQ9gTCpoCQBjdPFzx0yGLmszPrIcfuUouoqWu9O8f6/vGzA
	1tazfZKAl6KeX6IBQByAN+uLUA9CJRn3o2ywFW1jY4mZ6MTdU19haqpWL+euyAIUCuzJ5mWrKQ7
	tLuw==
X-Gm-Gg: ASbGncsqrrujF9eTTKVdnTBJhYs8JWH5BLliI9dWOY4K332GvmnQHhMyH/B2I+A6dWo
	/NQbFN1w4GVYaiK018WsRwwkgk2i0RfLd+ZUIu1BA3YWhG2gtG+CgWMyhQttlZ04DR0lAHjUBul
	Adqaga8AC15EexvdW4ck9e4x7D7eu14xFuPSlqaZWwhiU8BH5pW9zuHGZuq8RYz/lvOk/em/iWV
	Iagc3xbk9B65aOvCHERaManPpsw3dTspn7CS9U17415ooIlnMtJ/MtwclPZAcQOHns4c1kXyJ1W
	9u3+tShx+R9eDmN/3G98/zW28VkX7WezEBImZVywWDCeP8kDfpNaQEDZI7HjdylT7JP4YAS9X4H
	8PVQLhtu4jkVwtSNp5ZetfCdIkZMUkyhZ4BJQUiRCQYC9miJQPL/9fzei
X-Received: by 2002:a17:903:38c5:b0:24c:da3b:7376 with SMTP id d9443c01a7336-294cb3a11dfmr30302205ad.26.1761632892462;
        Mon, 27 Oct 2025 23:28:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkoJ0/BWbeULjwvKLuQumjd4K3ei4AcaGQDzrzd6IcSgDpV2RBGOWAbR62jWKf3T2tuscaCw==
X-Received: by 2002:a17:903:38c5:b0:24c:da3b:7376 with SMTP id d9443c01a7336-294cb3a11dfmr30301865ad.26.1761632892019;
        Mon, 27 Oct 2025 23:28:12 -0700 (PDT)
Received: from hu-yuanfang-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf359asm102503265ad.12.2025.10.27.23.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 23:28:11 -0700 (PDT)
From: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
Subject: [PATCH 00/12] coresight: Add CPU cluster funnel/replicator/tmc
 support
Date: Mon, 27 Oct 2025 23:28:02 -0700
Message-Id: <20251027-cpu_cluster_component_pm-v1-0-31355ac588c2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHJiAGkC/x2MQQqAIBAAvxJ7TsjKiL4SIbFttVAqmhFIf086D
 sxMgkCeKcBQJPB0c2BrMsiyANxns5HgJTPUVa1kJTuBLmo8YrjIa7Sns4bMpd0pkJTs1yy1TQM
 5d55Wfv71OL3vB2Lq3UJqAAAA
X-Change-ID: 20251016-cpu_cluster_component_pm-ce518f510433
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linux.dev>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: kernel@oss.qualcomm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
        Jie Gan <jie.gan@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761632890; l=5210;
 i=yuanfang.zhang@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=6PnlglbBdA+sT72qw9FSQQcvFbM5sLJUf0oCBFAlNsY=;
 b=LALf6twg1OIvxPNPoUXNnYLUruCA2bLqVPFCSjxVHlq0x8jHuF1l0snyO9zy7Y4Zt8YntjTkp
 Oh08LcncK+5DapwYzG0b/O8jyAPAEAGclo9D7j34geQ6cr5DLet7C3r
X-Developer-Key: i=yuanfang.zhang@oss.qualcomm.com; a=ed25519;
 pk=9oS/FoPW5k0CsqSDDrPlnV+kVIOUaAe0O5pr4M1wHgY=
X-Authority-Analysis: v=2.4 cv=Ut9u9uwB c=1 sm=1 tr=0 ts=6900627d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=6muaAK4ZDRYgKIjbAQEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA1NCBTYWx0ZWRfXxuqYnnYZl+Pb
 SKSsJNgtBLPGFPP62SoeyDNRlfdagmL++nqaS+uDFQ5/E/rMrCJEHkCEQuK1snaYnoB8D/asmJk
 U6PBIj0pBbwywxxQXdWH9tqM+9RFNoELw/I0ZHV8fS/DL8ZniXkVsAEqDXhV7bPFjStWfcYyzBH
 IXMRDoqVbXSiSLLHKq0Hp8Qz2/PyACT4daRgM/ac/xGED3T4crzVpWUJfQgSDLGCcLBYt7aupI6
 E98UrDdNfVcWNJ1v7EPRRHH6u03cJKj3ZAXM16z1NT/xkDW4kLkI9A7g1JOdq9PpZCEw9wZfqp/
 gkqDmW9PtYHuBwHPBaVdsyIqIprHEMJUAjs0vTU5EpPvoZi4hnhp/P9YwjDm+jXPbDNdxGqx5e1
 xYKd/gVc00fYiK0nDo74gwbAlaKCTg==
X-Proofpoint-GUID: aj_Lh5By-gRNx8Mpd0etlq7VoaRQvj9r
X-Proofpoint-ORIG-GUID: aj_Lh5By-gRNx8Mpd0etlq7VoaRQvj9r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280054

This patch series introduces support for CPU cluster local CoreSight components,
including funnel, replicator, and TMC, which reside inside CPU cluster
power domains. These components require special handling due to power
domain constraints.

Unlike system-level CoreSight devices, CPU cluster local components share the
power domain of the CPU cluster. When the cluster enters low-power mode (LPM),
the registers of these components become inaccessible. Importantly, `pm_runtime_get`
calls alone are insufficient to bring the CPU cluster out of LPM, making
standard register access unreliable in such cases.

To address this, the series introduces:
- Device tree bindings for CPU cluster local funnel, replicator, and TMC.
- Introduce a cpumask to record the CPUs belonging to the cluster where the
  cpu cluster local component resides.
- Safe register access via smp_call_function_single() on CPUs within the
  associated cpumask, ensuring the cluster is power-resident during access.
- Delayed probe support for CPU cluster local components when all CPUs of
  this CPU cluster are offline, re-probe the component when any CPU in the
  cluster comes online.
- Introduce `cs_mode` to link enable interfaces to avoid the use
  smp_call_function_single() under perf mode.

Patch summary:
Patch 1: Adds device tree bindings for CPU cluster funnel/replicator/TMC devices.
Patches 2–3: Add support for CPU cluster funnel.
Patches 4-6: Add support for CPU cluster replicator.
Patches 7-10: Add support for CPU cluster TMC.
Patch 11: Add 'cs_mode' to link enable functions.
Patches 12-13: Add Coresight nodes for APSS debug block for x1e80100 and
fix build issue.

Verification:

This series has been verified on sm8750.

Test steps for delay probe:

1. limit the system to enable at most 6 CPU cores during boot.
2. echo 1 >/sys/bus/cpu/devices/cpu6/online.
3. check whether ETM6 and ETM7 have been probed.

Test steps for sysfs mode:

echo 1 >/sys/bus/coresight/devices/tmc_etf0/enable_sink
echo 1 >/sys/bus/coresight/devices/etm0/enable_source
echo 1 >/sys/bus/coresight/devices/etm6/enable_source
echo 0 >/sys/bus/coresight/devices/etm0/enable_source
echo 0 >/sys/bus/coresight/devicse/etm6/enable_source
echo 0 >/sys/bus/coresight/devices/tmc_etf0/enable_sink

echo 1 >/sys/bus/coresight/devices/tmc_etf1/enable_sink
echo 1 >/sys/bus/coresight/devcies/etm0/enable_source
cat /dev/tmc_etf1 >/tmp/etf1.bin
echo 0 >/sys/bus/coresight/devices/etm0/enable_source
echo 0 >/sys/bus/coresight/devices/tmc_etf1/enable_sink

echo 1 >/sys/bus/coresight/devices/tmc_etf2/enable_sink
echo 1 >/sys/bus/coresight/devices/etm6/enable_source
cat /dev/tmc_etf2 >/tmp/etf2.bin
echo 0 >/sys/bus/coresight/devices/etm6/enable_source
echo 0 >/sys/bus/coresight/devices/tmc_etf2/enable_sink

Test steps for sysfs node:

cat /sys/bus/coresight/devices/tmc_etf*/mgmt/*

cat /sys/bus/coresight/devices/funnel*/funnel_ctrl

cat /sys/bus/coresight/devices/replicator*/mgmt/*

Test steps for perf mode:

perf record -a -e cs_etm//k -- sleep 5

Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
---
Yuanfang Zhang (12):
      dt-bindings: arm: coresight: Add cpu cluster tmc/funnel/replicator support
      coresight-funnel: Add support for CPU cluster funnel
      coresight-funnel: Handle delay probe for CPU cluster funnel
      coresight-replicator: Add support for CPU cluster replicator
      coresight-replicator: Handle delayed probe for CPU cluster replicator
      coresight-replicator: Update mgmt_attrs for CPU cluster replicator compatibility
      coresight-tmc: Add support for CPU cluster ETF and refactor probe flow
      coresight-tmc-etf: Refactor enable function for CPU cluster ETF support
      coresight-tmc: Update tmc_mgmt_attrs for CPU cluster TMC compatibility
      coresight-tmc: Handle delayed probe for CPU cluster TMC
      coresight: add 'cs_mode' to link enable functions
      arm64: dts: qcom: x1e80100: add Coresight nodes for APSS debug block

 .../bindings/arm/arm,coresight-dynamic-funnel.yaml |  23 +-
 .../arm/arm,coresight-dynamic-replicator.yaml      |  22 +-
 .../devicetree/bindings/arm/arm,coresight-tmc.yaml |  22 +-
 arch/arm64/boot/dts/qcom/x1e80100.dtsi             | 885 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/x1p42100.dtsi             |  12 +
 drivers/hwtracing/coresight/coresight-core.c       |   7 +-
 drivers/hwtracing/coresight/coresight-funnel.c     | 260 +++++-
 drivers/hwtracing/coresight/coresight-replicator.c | 343 +++++++-
 drivers/hwtracing/coresight/coresight-tmc-core.c   | 396 +++++++--
 drivers/hwtracing/coresight/coresight-tmc-etf.c    | 105 ++-
 drivers/hwtracing/coresight/coresight-tmc.h        |  10 +
 drivers/hwtracing/coresight/coresight-tnoc.c       |   3 +-
 drivers/hwtracing/coresight/coresight-tpda.c       |   3 +-
 include/linux/coresight.h                          |   3 +-
 14 files changed, 1912 insertions(+), 182 deletions(-)
---
base-commit: 01f96b812526a2c8dcd5c0e510dda37e09ec8bcd
change-id: 20251016-cpu_cluster_component_pm-ce518f510433

Best regards,
-- 
Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>


