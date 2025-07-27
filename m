Return-Path: <linux-kernel+bounces-747160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 007B0B13080
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 18:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1FD4177FEF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 16:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338602236F8;
	Sun, 27 Jul 2025 16:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ll2dnarX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4DE21C9F9
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 16:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753633537; cv=none; b=TxrIA7w1U0nlq8u3uP6PKp93/9sCMp27O/tXjj85E082UIdgIVSNNY9aw5TUjX+o9ATbEvdbVSoduBxrF/TPuE4hA7EEBIuZga+BS1uS/u9UmslHvxvLNNf6puh7m0WLHTYt0zJ2T7ESW9L1xjJLUUksagXm+DbbvSeVf4H53Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753633537; c=relaxed/simple;
	bh=B5BLAbfGWAu1tjZeNLd2S/l/pA+itiinQJEbqhqQ7Iw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YiXgU1nGCtas44rC4ColRmntRUWQ+rtcSVF3hCB3ApCl5+5ynL/1BsxFpQlyeIrXxAqHDEsE53xQCpOx6g4W5/K4QRC1BQAED+ZgGwu+M3eINamaXMzTNFKNjd+0WE3u3YNLqCoSuW3wOWSSkA5XvTb79VZaXjB6p9SD5RHJs6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ll2dnarX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56REOEuP018457
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 16:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LAjdEtX3RT7zSV5WrhnDDtIT/eTrigKKIJeo9CD77g8=; b=Ll2dnarXF3tA763o
	n0D2snUMmai1xsB9hkOvnb2fifsSLg1eWkxr6LBWGPBJWONv1lc7QUlNM3CJ5E3H
	NMm/+P1jsD/L+TRxS2KeEdHs1QuQ+5eeZ/Bxyz/1Ko/TJAVN90y0DFU0kzbO7TZb
	1uazZIYQWW2I3TZJoyZconGYcOXvAs85jsqQwgeH903e71Uy8IM6YxYyE9LMN25K
	2RCMgvxVUxaIDe3Bm0tJjyp/b7K82bwNDMIheJX9tSheGicesNanxpmyUXn2PzGP
	/kc/qpXNoKhDl9WOfzHEPgFE9zdV/Ve3LVmgzyG7HiI38Rn1+tN9+5y5JkxJg5p2
	qDCFEg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484q3xjat5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 16:25:34 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b3f38d3cabeso2561533a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 09:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753633534; x=1754238334;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LAjdEtX3RT7zSV5WrhnDDtIT/eTrigKKIJeo9CD77g8=;
        b=K5J4EhnKRtPDq7MMrhgEYa3w9YDs+5H5eR9TGtfq3ijuU9PgpemGKNPkKBgIjxWcMn
         wbHuFPiFw2NpFzzLHfhs1t01S46I+G+ubBVfxJRmrUo7HSOODuzuc2iTS/AYDtCg8U9d
         vAArQ0xztNh3VJSa+1LFvEkNTZbvLEoGS4X8m+GF7EaXdbQSfcF9H2XnlPiBzxVLmDrb
         EhPu30VHbcTt7mQJGf6kF9J/XUN+38r9Y7p3ptxtpUt+Qn2D7BPCnY1iolzZd+MHXfil
         9cvkYKyevLsdC9aQ45Mi2SQ6mxFs+51qlcCYvGTxna/vMcKsfxam05HJvhG+6FIta+Eq
         6x0A==
X-Forwarded-Encrypted: i=1; AJvYcCUMy8+ISWJVukLwA01msxxt97R4gn3fr+6vC2KDem7Yxh66yc6yejB4kL6E+LEYMfnqIWmrQC3NvIqmeWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkFwYdVjPrvVX6QP58jA0WJqAvQYW2v3pD/B8NWwZKBXf6QC0T
	zSmJRPxg1dr8sLGywlP6K1Zp5TPe++YX/bs2lJQiQpqmoJrjrcWYg8tl2SH+t211j+Q1QdIE10j
	fnGNInR1f7JxVZx6Zf58UqkgNdB7Ju272GDXQQGSUJSuAaJKQAmFXhHsXtwN8kRvNItU=
X-Gm-Gg: ASbGncvoV3zeRtjxsmKm2KIuYrZJeoPSFxxH8kt0snzmtFHwg6sJEcFYhf8wsIn7Y7+
	vdhfeX2iDK0IYz9dD/2zAXYTg4wcUmEAK/M0cleJSb3Bem9ShmrtaFipD+cuUQ2f06zENIHyq/4
	0tEJRN5kl5bnwidE2HOu3647hu8tgWW5WHaktlEEYIsNvNWURKcMlO3iY5Nth1MuqIqrx+n1Huf
	RIXXEQT8t5Rto/VsXKSvGiDxtdN0g2oh+sHom0XT8E7PiHKsFsxcil4h73bnX3Sjnfnh9kO88LN
	lsotuui8ebyt6IIN+FVR4Dg+iewZIRtH9EDnOsigkqc36UN0/Q7gC+hSP+ReWDDo7FwXfp2xUN4
	B
X-Received: by 2002:a17:902:d2c7:b0:23f:8df8:e7b1 with SMTP id d9443c01a7336-23fb30b3224mr145314595ad.32.1753633533666;
        Sun, 27 Jul 2025 09:25:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7X/a1NVbBv9ysYl7a3wo9LMuxbvZnRFcCXyu7AESYMzqbL9vACORQwwTa7YynJTdngrt2rw==
X-Received: by 2002:a17:902:d2c7:b0:23f:8df8:e7b1 with SMTP id d9443c01a7336-23fb30b3224mr145314215ad.32.1753633533214;
        Sun, 27 Jul 2025 09:25:33 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fd9397ebbsm29110325ad.210.2025.07.27.09.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 09:25:32 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Sun, 27 Jul 2025 21:54:47 +0530
Subject: [PATCH v13 04/10] Documentation: ABI: Add
 sysfs-class-reboot-mode-reboot_modes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250727-arm-psci-system_reset2-vendor-reboots-v13-4-6b8d23315898@oss.qualcomm.com>
References: <20250727-arm-psci-system_reset2-vendor-reboots-v13-0-6b8d23315898@oss.qualcomm.com>
In-Reply-To: <20250727-arm-psci-system_reset2-vendor-reboots-v13-0-6b8d23315898@oss.qualcomm.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik <andre.draszik@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753633495; l=2307;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=B5BLAbfGWAu1tjZeNLd2S/l/pA+itiinQJEbqhqQ7Iw=;
 b=pgH9mIPi7GA0ayDqkKnR2+E/P0dq3sd1IZAeVGSFF5+JaYFGGS/XBZthLHPT9KAF1UJ/RpQH4
 Hoy706MVMLNDID9ZV+MW3XmZWBEhJJ0oZVWXtccIrzCMNUZQ3rPFPly
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Authority-Analysis: v=2.4 cv=JovxrN4C c=1 sm=1 tr=0 ts=688652fe cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=5CgfHzhl2afHKY-Ush4A:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: u-08hAgoo6lHwWlrK46iupfw8obYeWkD
X-Proofpoint-GUID: u-08hAgoo6lHwWlrK46iupfw8obYeWkD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI3MDE0MSBTYWx0ZWRfX1vdLhIhvgvdA
 tFSlTMgYSlRL05TJCl2Tff0GGL7DOSKhn+MpZhgo+/yWxCKmjoVtCO6h8LYdWpQOOjV7Y5CekVX
 kVOtGTnV4bgyxXR54Chnsskm8jerJoPGN9M9fcXKvhpmvfnFS+pid+xg6lYyALMnqolfZoE9U4A
 QLt0wwK/Op8b/4oxditNCiyApXsuCFysBJkJh1K52X5RSlWzlPDuY4Xebkonk+YZnlMxYoMm7te
 K/Kh6fSTh7V2sBA12kYjnIBVfgTXzWqbi7Ds4Oc5C0+uHwgz7QWR+yaG5xkhsVdXEiP3qanptcE
 FF3V5M5hlV/7veGbLCHYVLhLtvbufl6xzmSy2/rElUSo80LcKLCd9UoaC/OYFmeh/5rbyEcVJDR
 RToe+4hupyzcfQFJn01tViXge49v0hyN2O9V0QWvqHhsni/1+3oH+1MviTEXq4pGvcoDSUq2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-27_05,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507270141

Add ABI documentation for /sys/class/reboot-mode/*/reboot_modes,
a read-only sysfs attribute exposing the list of supported
reboot-mode arguments. This file is created by reboot-mode
framework and provides a user-readable interface to query
available reboot-mode arguments.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 .../testing/sysfs-class-reboot-mode-reboot_modes   | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes b/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes
new file mode 100644
index 0000000000000000000000000000000000000000..7147a781e5d4d11977c3a156bf4308aa13310e39
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes
@@ -0,0 +1,39 @@
+What:		/sys/class/reboot-mode/<driver>/reboot_modes
+Date:		July 2025
+KernelVersion:	6.16
+Contact:	linux-pm@vger.kernel.org
+		Description:
+		This interface exposes the reboot-mode arguments
+		registered with the reboot-mode framework. It is
+		a read-only interface and provides a comma
+		separated list of reboot-mode arguments supported
+		on the current platform.
+		Example:
+		 recovery,fastboot,bootloader
+
+		The exact sysfs path may vary depending on the
+		name of the driver that registers the arguments.
+		Example:
+		 /sys/class/reboot-mode/nvmem-reboot-mode/reboot_modes
+		 /sys/class/reboot-mode/syscon-reboot-mode/reboot_modes
+		 /sys/class/reboot-mode/qcom-pon/reboot_modes
+
+		The supported arguments can be used by userspace
+		to invoke device reset using the reboot() system
+		call, with the "argument" as string to "*arg"
+		parameter along with LINUX_REBOOT_CMD_RESTART2.
+		Example:
+		 reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2,
+		        LINUX_REBOOT_CMD_RESTART2, "bootloader");
+
+		A driver can expose the supported arguments by
+		registering them with the reboot-mode framework
+		using the property names that follow the
+		mode-<argument> format.
+		Example:
+		 mode-bootloader, mode-recovery.
+
+		This attribute is useful for scripts or initramfs
+		logic that need to programmatically determine
+		which reboot-mode arguments are valid before
+		triggering a reboot.

-- 
2.34.1


