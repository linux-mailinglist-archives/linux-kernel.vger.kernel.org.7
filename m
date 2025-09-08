Return-Path: <linux-kernel+bounces-804954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCA5B48257
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 04:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA77A3BD6DF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 02:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018FC1A2387;
	Mon,  8 Sep 2025 02:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nk4C1CQp"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6A825771
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 02:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757296952; cv=none; b=mNRChA2Uu83en9G2sOh3Kez34q3E3HWsZGT/STsOqPtT8shdB3cV+TnSHqV0GwSLW74OMdgvNTdJLsIqFt0HnMLiygJFTL7ql7++cYLfdRM/YDI3wBnONzsiHv27iOvhH9rWZoL8TjnClmTc6jCzaiWK82Vvwm+ZvkcL/9vWw8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757296952; c=relaxed/simple;
	bh=dyqo7JudljblWc6HLE7pKuUumHsM5eHxacl7uIaGJ04=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dlIixUmO6FKl+kJEz0Mrxbah7R1XLCpDfY5ULtJOLVXl6/DSEVTLF8S2ITXdWm9tEuzj17yd98zup1qDucB1T/5oGkQWgQXL65qWCP6X+zstBiN0Hv7azS/mG5MIt2RNQCuqMp6p5undtbIPXUWDt/8NS4BzNR4PDa7TU9iLlV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nk4C1CQp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587LMn5j019349
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 02:02:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=yoV1214w9m4MdRhFcbUnI+
	7YO3fgfW36gurgCqQNvzA=; b=Nk4C1CQpXlsn7EqrlSsnFIywu1uWXKqKlGqVAq
	rE+Rl1kf/N1JHtkzdYEXYjwDI960Lmil/UjXhP393OmbhxSCnqbFitu4uakV/iBU
	qBJ8E0cRhkxchODp++5KU2cxKCzgJ5yictWxf+jKSdB4nboB1nHvdSP6ToB/5v9n
	xQxfRFwIXIKrjTW4H+DQ0Ui69BfU1cnzfG4Gcir4eV9lZhZpspJ+Qf0Tr4Z8xwUT
	9U2jZbd+GJEuPuQIf1qmzi6+ucSVL6oU5pS7l8zHdNccN+tzzxaXdg3t5J/RzoZh
	SZHfKuwD/xX16+nWeZKNvu2j3OSxEghbEjpxiJkFOA0ZUQEg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490dqftutd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 02:02:28 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7741ef59d18so2090924b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 19:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757296948; x=1757901748;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yoV1214w9m4MdRhFcbUnI+7YO3fgfW36gurgCqQNvzA=;
        b=sHHcTgsX/L0OKpB1kUdK2Ne1bw/LH4bJ3wEMzV/HwY+AtKrNF7mGHWEE8BkWu+49h4
         6z/ivvytZQ5bCZOLvKYH2G4JZ4CGuq4uxKtPFG9df2Bmq/ythzhg51Mw8uyr9qQukDD4
         k7rjpEeFywAyrp53GJaKOD/xAZGlSppIZ2lKkjtdkDgUDxXpPL8txJKyHZ9ELxjwDv+9
         +YxNQYENGpGVDpZLBInl7aKdhXo23lFMBpCaPaR1aiNC5IUUS8KQVFuLuVZSzjY0+dUU
         Exw4dPIg4IygaU5ILS4F43Um5UwpkuEWZGp/j/dojLrr07gkuMFf7XzVNWipUOJKcvFG
         c7qQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8ih1h7kv7IpEN/R+3oagnWBUYC8OPZBIhgotDMY7nLr+Fel0r9R5wu3Uhnpy3cS3wzbOs9RVX6YF/fwo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf5aT9YVu/v2urCvV0It+f1dL9o9Qn/IU/S+3lPHzeAyGNwHkt
	RuOSIb0SdjuIbqSi+fQnYzvYE12cXirL5Z+ZL8axiVAhODH2asHA57e6jlQECuTcYUCQYZMOZJX
	V9bh+3ukZKRiTp2BnNKq/0zzlAut61JwbBx6CvLPRbt7formYt4dU8pFdOvr2xkAd9DA=
X-Gm-Gg: ASbGncv8oTZy3/Wfmw/YCL8OtXtSDseQ44U0Y4AbgppW035GYlOsuAyS9vs5p0jIUwY
	9EGOaaSkF0Fjh6vC9Y2E53TBjbHz3iAqTbrwpNCIglGko5lk31yXyIur7tF13thpleJx1SKbUKv
	Euwi4BOSIHHMJgZOB4D5w2d4fgvmAH7IXqTyD3TCBpRupa7HZO3jwAzT7ZhdG89/hm8QfqlAV0S
	jR6oM7+Ezp6j0jI6iHXLQZa34rIKe+IWWLi74d1xVCArHTVDrqxCVa8N5oHkL4QV/kQmzMiqrg3
	END2TdotdUKsLGWT3zmt5a31eNsYQF3X3GauMhHZWySHHLGDNA8j5rOgfdcQhNyu1x62PVlnxKI
	wNfuoAmjGomyOjhmW1WP8jPaK6Ps=
X-Received: by 2002:a05:6a00:1996:b0:772:638e:5f61 with SMTP id d2e1a72fcca58-7742de6fdcdmr7012203b3a.30.1757296947025;
        Sun, 07 Sep 2025 19:02:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEc+g3yuUbloYGNpECYFQ5mpX5NmX4kSQdUKemXIAqYso/plZARjLfRT+z1zpo9pZgH+Ci6Pw==
X-Received: by 2002:a05:6a00:1996:b0:772:638e:5f61 with SMTP id d2e1a72fcca58-7742de6fdcdmr7012155b3a.30.1757296946428;
        Sun, 07 Sep 2025 19:02:26 -0700 (PDT)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7723f4858e6sm24285076b3a.4.2025.09.07.19.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 19:02:25 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Subject: [PATCH v6 0/9] coresight: ctcu: Enable byte-cntr function for TMC
 ETR
Date: Mon, 08 Sep 2025 10:01:52 +0800
Message-Id: <20250908-enable-byte-cntr-for-tmc-v6-0-1db9e621441a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABI5vmgC/x3MQQqDMBBG4avIrDswKIr2KqWLGP/ogI1lEkpFv
 LvB5bd476AEUyR6VgcZfpp0iwXdoyK/uDiDdSqmWupWBukY0Y0reNwz2MdsHDbj/PEs3onrG/R
 haKjkX0PQ/71+vc/zAtbObEBqAAAA
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Jinlong Mao <jinlong.mao@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Jie Gan <jie.gan@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757296939; l=5486;
 i=jie.gan@oss.qualcomm.com; s=20240927; h=from:subject:message-id;
 bh=dyqo7JudljblWc6HLE7pKuUumHsM5eHxacl7uIaGJ04=;
 b=/yeUaHpdizTMW9GOyBdOjn5ZVmJ8Y1/KvDNh7jwUI4URuGBXwisiLFz69WlpuOe8Zo0NKc+ew
 YzxMZWKc1yxC8hwW6JuxFHxVmLdQ2IdAyJpeGQghs+CWvhTjbdqy6NT
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=OZh7JyRifqJh4xmrcGgmwa8/LCS8O11Q+mtx4aZGmi4=
X-Proofpoint-ORIG-GUID: oXsUtzX2HardRlY8qI7kGimW7H6_QkBS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzNSBTYWx0ZWRfX248ulepuske4
 l3V3noUqIFPKYzuzdEQ3v+vDh7nyGeCNngsBaxmhuoll/X15ETlbZh3S5IM72Hggvp6EuAY5vhg
 QtQQZ/ZSo3XPLhaJ5MONvGPb5vU+SQHQq4bHD+M3S1nM6LMURlqeJTh9gcsnkr/ZhiO1cZIHkoa
 z4pNMjk/F4aVttbrZQ/RA839Aem4az6LEDG9fP6rGMKHTaR+u7a0IRra/ibGYRqttZtD8oFTRT4
 QE3pHayb6jt3mAqEs/OqcHtfkgKpwz2Sm/lVM94I5g9XyfieN3wecTc83IeFHn5CNxmeEHzgwDa
 udPuVYV6CjzKaZdut1Gq5Kwsm1UDugwb7jQ6ZipFOD7hPsLApCeGhB4I9FOu4/C3kFVB6f0CuTl
 YpLaKKZ0
X-Proofpoint-GUID: oXsUtzX2HardRlY8qI7kGimW7H6_QkBS
X-Authority-Analysis: v=2.4 cv=N8UpF39B c=1 sm=1 tr=0 ts=68be3935 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=4JJaRIKzVo7dG1xzKtwA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-07_10,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060035

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

Changes in V6:
1. rebased on next-20250905.
2. fixed the issue that the dtsi file has re-named from sa8775p.dtsi to
   lemans.dtsi.
3. fixed some minor issues about comments.

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

Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
Jie Gan (9):
      coresight: core: Refactoring ctcu_get_active_port and make it generic
      coresight: core: add a new API to retrieve the helper device
      coresight: tmc: add etr_buf_list to store allocated etr_buf
      coresight: tmc: add create/clean functions for etr_buf_list
      coresight: tmc: Introduce sysfs_read_ops to wrap sysfs read operations
      dt-bindings: arm: add an interrupt property for Coresight CTCU
      coresight: ctcu: enable byte-cntr for TMC ETR devices
      coresight: tmc: integrate byte-cntr's read_ops with sysfs file_ops
      arm64: dts: qcom: lemans: Add interrupts to CTCU device

 .../ABI/testing/sysfs-bus-coresight-devices-ctcu   |   6 +
 .../bindings/arm/qcom,coresight-ctcu.yaml          |  17 +
 arch/arm64/boot/dts/qcom/lemans.dtsi               |   5 +
 drivers/hwtracing/coresight/Makefile               |   2 +-
 drivers/hwtracing/coresight/coresight-core.c       |  59 ++++
 .../hwtracing/coresight/coresight-ctcu-byte-cntr.c | 368 +++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-ctcu-core.c  | 108 ++++--
 drivers/hwtracing/coresight/coresight-ctcu.h       |  62 +++-
 drivers/hwtracing/coresight/coresight-priv.h       |   4 +
 drivers/hwtracing/coresight/coresight-tmc-core.c   | 104 ++++--
 drivers/hwtracing/coresight/coresight-tmc-etr.c    | 112 +++++++
 drivers/hwtracing/coresight/coresight-tmc.h        |  38 +++
 12 files changed, 826 insertions(+), 59 deletions(-)
---
base-commit: be5d4872e528796df9d7425f2bd9b3893eb3a42c
change-id: 20250906-enable-byte-cntr-for-tmc-0ca0a83e8f93

Best regards,
-- 
Jie Gan <jie.gan@oss.qualcomm.com>


