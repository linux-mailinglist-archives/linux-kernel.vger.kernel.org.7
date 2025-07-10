Return-Path: <linux-kernel+bounces-725346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40161AFFDE4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 123A01C80D25
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF102C031B;
	Thu, 10 Jul 2025 09:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BuFpUYcf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F25294A04
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752139090; cv=none; b=SiUu+rL30UHG4rD7k+kTVhQMk8wdrhEvEA+hhJpWg++JRp72qlyXCLWiZHUzMs6hs4vzqCpy+im5XYkztIurubA9Jos5ivkOQO88lr5T6nK9/oWHpOEjHZhYtKbKUBM7naMSopKqHXXC72gkLVSkWY95Y2bB/dE5SmB2ZftPcGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752139090; c=relaxed/simple;
	bh=sNPObCAn0hHlmeXuawxrFyQE6vuwG7PdJUJ999/BvyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A0G3Ojx7V3fFaP6bV93p/l44P9JCzWq29xU0TbGYEpow2IMjVdG2+2GIoxhaxuAVaHwnMpHxkmC9FaNknpfd653dmayUlfA6veOhC5xnYmAcEkNN12lqDOr+IL8oT5Gj9BLp5G4laQC3UphriAT1FCaFgDuP1hII2ZFiTGtMj1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BuFpUYcf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A9FNT7011560
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:18:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vBKj3/crUvYp4Ips85Vws+1r2KlgFDtGQkXcgWnVP/g=; b=BuFpUYcfun8Vz84J
	pQVzInUwJbie1KwsmBsVwgfqtoydkX3bU4J6CPTHbCijc/jrxpUUsklvC45H7zoo
	resLbWnzGbGbhwXIBUDRRSK3+E7fQ8ZzMGyj6riDtHsXvrdnIUQAYkAiR9Hg8+kH
	94jMFaC+g3gd8x18/Uo2tc+U+xEniso/2x70Ho6yErR2Tf/a9MGoxpcVPvdgrjqS
	N5tZUkkt/2drZR9/ffl6PkDZg61/lsxcbNpUjMeNXF5kd3695KT+eNqfHod9y0WL
	rBGymV1q4fqaccvOQe/1n2B8W2lQ+bDLZdgazSQYDsq+vsZ8H4ReDjMMfgn2lFJP
	a+TTfA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smafmatv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:18:08 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-235e1d70d67so8816335ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 02:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752139087; x=1752743887;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vBKj3/crUvYp4Ips85Vws+1r2KlgFDtGQkXcgWnVP/g=;
        b=hcBlOKvHMMH2niZTKpFuImxS+d7+3Rv0qje06ILSS+owheT6r6MpA5m6a/aH5hhc6H
         f7L+IfxbTMBSHOaWT58qZ3XKN6aq0RUmojyndaUqrN5MO/16n6xoEhtXjw1mOH5NCbnn
         ZN7yMhfP3TKLKVicOu+N1p4e1ZjVkqlfryJI0bhMeIH923BWEBu+2iFkBs2ByOqQBbL0
         HluZbQ9x4HeP9sG7H+aufocpWOhggfUmF+cBREVSY4rmMdQgRdxytLtC6W9j2M418ojF
         GXSlg2xlmJO7ZKLm7xN+l+SO8fVwo+p90MTJWpUfuizyF8FtbIklyXnAh4yPURoqtext
         e4Sw==
X-Forwarded-Encrypted: i=1; AJvYcCXGCpQ32XlAXelZcCg1f9x9IDW0mSVoOWTfbW7fGiNhOBTl0gPwkDykw4BSNzdghza39/NdS1yES6ydg7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM61qK9Bm/Bs0GT+2ou8pgUhZByy6SSh03zZMjKAzgDaahkV7O
	hoO69m4e3/8eQsgiLC3sX23oYrFUFeg3RU414zeqMxyP2BwlwS9yqiLfGfBi1gNuLRSpnn696Aw
	BBstkE7qQCK37Da9Qm9LnqL4B+wn/UncA4AmHhAgRaqiInpG6+TqDQaYrv1Bx1RsFgYE=
X-Gm-Gg: ASbGncs+hHcuYBo5LLzjTWTnp5V0ieIuM+KUw5jUouprwN5cATnpbQFSQLngQNaeSw1
	s8QDCnrqXTnAfkrQRFfHzhW0zJgKo1ayXGpyfrBK1ERO9pwhUR5BqK7xmoENJjMg6kCQl0/xpmV
	Qh6QCXZW9wj1niUr84V/RArQCsoSjXPQ2GQRMnOnvGuv5wbG7IQlH86+rbtR1NwOX/rb749kDed
	AtOuU57E67pQQEJE0829dMC8x2YX3Pdk/4CqyF6aR3Q3JtAoOKQuqIyw0FL+Hadr32F2MSN8rlz
	HT6KzHY68DP8AhsvVx3s7cZp7pjzDpSskgb7X8p+niui8lzLdWzdxM8IhBY=
X-Received: by 2002:a17:903:1103:b0:236:9d66:ff24 with SMTP id d9443c01a7336-23de480adf5mr26726185ad.8.1752139086649;
        Thu, 10 Jul 2025 02:18:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3++zCHPG72HaamcNpmeO+Bll209rYHNgNyYOmL53l1Ne2aXD9CjDh3cQHGGPnX41YVpDvag==
X-Received: by 2002:a17:903:1103:b0:236:9d66:ff24 with SMTP id d9443c01a7336-23de480adf5mr26725325ad.8.1752139086179;
        Thu, 10 Jul 2025 02:18:06 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4341d51sm14837765ad.189.2025.07.10.02.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 02:18:05 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Thu, 10 Jul 2025 14:45:51 +0530
Subject: [PATCH v10 09/10] Documentation: ABI: Add
 sysfs-class-reboot-mode-reboot_modes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-arm-psci-system_reset2-vendor-reboots-v10-9-b2d3b882be85@oss.qualcomm.com>
References: <20250710-arm-psci-system_reset2-vendor-reboots-v10-0-b2d3b882be85@oss.qualcomm.com>
In-Reply-To: <20250710-arm-psci-system_reset2-vendor-reboots-v10-0-b2d3b882be85@oss.qualcomm.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Elliot Berman <elliotb317@gmail.com>
Cc: Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Andre Draszik <andre.draszik@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org, Wei Xu <xuwei5@hisilicon.com>,
        linux-rockchip@lists.infradead.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752138982; l=2284;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=sNPObCAn0hHlmeXuawxrFyQE6vuwG7PdJUJ999/BvyI=;
 b=2a7c4y1EVymbu2XIDK/bSBzOWXavwNhKH+7Kgou3PJREQpHdjfWF5P3WklEYYjhjkesTJleCj
 E7fEUYVuTpACaFQwTlNOMKw/oaee09IuFwlJ2c2sTZy2gFGks/QjdBN
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Authority-Analysis: v=2.4 cv=ZJ/XmW7b c=1 sm=1 tr=0 ts=686f8550 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=5CgfHzhl2afHKY-Ush4A:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: 9oV-9QsAj6bW4qvEuhVMuKjEalscZtpz
X-Proofpoint-GUID: 9oV-9QsAj6bW4qvEuhVMuKjEalscZtpz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA3OSBTYWx0ZWRfX/OFlqkSrHgIt
 geo2cZMqZmzGWMNn7G9Ve20bQXWYMITlFBoDBi0pWOkpZHK+uxuHDktSAtShhkcbnJQVtrShg29
 QRyEAm7cfG4G9Kh/SDDjd8Zk7ydBz0w5MYXnvGHyhE5WW4Jny7++8K7oM547+1zQcTgcjyhWySZ
 NN7Sa1dZweo7ifw//2oY17TapUpxHK9s4PsWs22ozgvDYR9xCI2JLg9GeAFhVJvzRiTsZUWrwiq
 lwvxfasjmAJToIvH4Onrz4HPcdlAAmi+7l926IkuB56yke4P68DQTkcVX66WFumIlDOS5gobRsc
 OUhXmqwks+S7NGytXiIMgXuFmEFi7xS55D5H+W4pBguseNNtoypZ8b99PZUcssOPDMCTyRAeS1X
 5zTn3JJ4+RZ0IXoKJIkGcWvuzbtBLc/2awkfVOBAx0vXcikUFg6gutGe0RSwNaAmda1tMGh9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 impostorscore=0 spamscore=0 adultscore=0 clxscore=1015
 bulkscore=0 phishscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100079

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
index 0000000000000000000000000000000000000000..bf49e6c1dee6f48d791987a50c3d0b349e6714bc
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
+		 normal,recovery,fastboot,bootloader
+
+		The exact sysfs path may vary depending on the
+		driver that registers the arguments.
+		Example:
+		 /sys/class/reboot-mode/reboot-mode/reboot_modes
+		 /sys/class/reboot-mode/pon/reboot_modes
+		 /sys/class/reboot-mode/reset-types/reboot_modes
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


