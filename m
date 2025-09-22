Return-Path: <linux-kernel+bounces-827329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BCECBB91722
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A44C04E1F16
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C281530F7F9;
	Mon, 22 Sep 2025 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VvSoXGTK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9D630F554
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758548462; cv=none; b=aJTBpBDc1rUhWzXcNF6RJ0xHwft9IQKyzrBCcLF3H/06SrREROvwZOu8nk1++Xsk5MOU6SlOaPBkq2kF/z/6rD+0M6eocWxHI1PQSt+DnihkotlbWKgn9rDlO/N2SFb40MVkf03jTzQk9dLgD9hUeOj3vD70333Zw+fu6Gjw7+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758548462; c=relaxed/simple;
	bh=M034h2Di1cmMjLKB84r2uoAd+40fCZthgOLruF4HJrk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l+1wvGJrWU2PxfTjdNwl9sWZGga7hX3GqA3O5nJitmRm4ra4tnD5uJGB6KfyzWcAJHkNFWfBZADll8mWKlsbAdnXQyGAoAhXxNN4sPIQ1jQRLgJmXNGu51QxSeD0KfNuXYywAN3qL2/FM3B3/Bi2J9ef9CessiZiuISkDlviwm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VvSoXGTK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M7pTkq006138
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nlDpgG4AgbfxwCOJZCQP/7oE/9P96tZjlUe4LmJwps4=; b=VvSoXGTK9QUP2Vm4
	5mKN32K2Om60W+714AYvSkVBEgQqWTf4Za4K8dwDp7LgXboEIkbOBeUp3zlFtt3+
	d0TKODelqe7xJYf2ZVfjKG8o31j6BsOxdsSq1AUicsQz6iGZ0pSbjzxsbqqaBXQJ
	2H4R7aAOxexGqesOzepsTBSCTt09zeTTBqFlhQuajvOKG9kO9/AKQjCKyVI/csQa
	HU8Y5Q3qi5RpGt70of1RLKVm+TIoEmo6cUfOs3kTT5JUiSMQ5U0H95nM6b4EuS4m
	fyoF684uGgvFeHnbyKHU2QERzEFxQY4j1UYzHvpaDdXzAfgYqGYnxerRkaFStetJ
	6zTDrA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b2e112pv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:41:00 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-268149e1c28so51273905ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:41:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758548459; x=1759153259;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlDpgG4AgbfxwCOJZCQP/7oE/9P96tZjlUe4LmJwps4=;
        b=amci/w+auoeQ8FNTrgzHKpLfmsIPfigrBWeK7XtctZ8v/2O8K25ILsk0pL15Vwkk4J
         fDS7epd9yL2P4iNfam92bzufhtdgAqh0z0BMOFjn2Lm8dqepQiUYOzHaFImIy6LOrs2i
         +IpWAVf2qbm+psO5VDLdMW3VYVCAkM09k4cF8mCCOlEN9JTwpO/okYDaT2ryxAOfQKY3
         KSrMQQ/ASliJl6f6O2Wg0gQ2prkxs1ES32FGdKtOwipO3gJ/nz9q09L/OCXA4gLKdQcU
         mBhWibOALm4gPX/brkV40CBE8R4Inya/B8ENOmPkIoejgZ/uKaEOyApZ+g1gBNv7POLL
         sB1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXv+jghv6zRrUeKzJs8fwaPI5cM87L3z/niI3N9x1eRDQlfFAXWXXL0DToagamkx4dtQz+nU8bHvbBF4IU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfurZXZQO2SL/GL864agZgvYfYLS3QJKGK7/n3wWO8u5nv2MSW
	HfM25Qhd0vN34ct49uC81EkzU9exjGA010tJFSlBcFshkaAV6vSHBA1Km8m7KmIMlQzbmRoxdo8
	a3lP6EC8LghaQxqq/REZXLjHhj1x+d+WdGKaOcguzZzbmXLYqpWQ6r6AttzbD3Qw6PTY=
X-Gm-Gg: ASbGncs/91d/P4P/FS4bM85Fv39coKQ0PqplUHuK3GhK3mmTR5WMTVFS0QOfgtW1A8P
	cv3133Ym895QJF3ggXTHtaeInTP6323Wb/GuxRGOPkIlNybJVRUe7n6voLW/YIMi0UZZokY2kzs
	73A8EJHSiaUrusMCf3LMfDhiC8YLpjjbCXO02OtaGF2By0n3VpQ6aLpGj4KNVGu8NXvjc2bdC8x
	6vWCWINNjUXfpxp44PNV1POyeCa03/Ko2qRQ0GAYTWMYLnA4JMHjGw/B59cGQfOKqYtg2xcHUze
	Nurm4Wgb82MUhWC0489sWxJjCfLyXkMfVY5QDphd8Sisvb+i23Uq9pzTfu8SBqSNBuDCYpiwkPE
	i
X-Received: by 2002:a17:902:ccc9:b0:267:b2fc:8a2 with SMTP id d9443c01a7336-269ba46f141mr149984525ad.23.1758548459090;
        Mon, 22 Sep 2025 06:40:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbE5iJ+HSIMUitg/W+4ksQTF2yMwalZu6F17/bSuNgJ3VEVoZeuKosRoBkkFgDRLiaQKQr/A==
X-Received: by 2002:a17:902:ccc9:b0:267:b2fc:8a2 with SMTP id d9443c01a7336-269ba46f141mr149984055ad.23.1758548458456;
        Mon, 22 Sep 2025 06:40:58 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016c13asm134246755ad.46.2025.09.22.06.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 06:40:58 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 19:10:13 +0530
Subject: [PATCH v15 03/14] power: reset: reboot-mode: Add support for 64
 bit magic
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250922-arm-psci-system_reset2-vendor-reboots-v15-3-7ce3a08878f1@oss.qualcomm.com>
References: <20250922-arm-psci-system_reset2-vendor-reboots-v15-0-7ce3a08878f1@oss.qualcomm.com>
In-Reply-To: <20250922-arm-psci-system_reset2-vendor-reboots-v15-0-7ce3a08878f1@oss.qualcomm.com>
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
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758548419; l=6976;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=M034h2Di1cmMjLKB84r2uoAd+40fCZthgOLruF4HJrk=;
 b=QP+FiWdkBwbcJeXV9RT+1lBYacdBujwGLD+FnHhQecZZXVuCAYr3EsNZ6KnXeyNdxzGXv+wy6
 kmYFDUSjjyBCiNXBn48tr3jXZDEQ3UC1N75FMiyGU+6NfqWBx7nrtdy
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA3NiBTYWx0ZWRfX3n5UZdedU5wE
 HyiwVA5iGmH+Vsd3GLeU/E50baU3bOuwmV1KnlQ9HeFjbqQIOErLAgs04oDr1u8Upj9V07moVtb
 hLgfZ6Uq9k8vs1SaDJlBmdWCo9kNkf+v/g8R/lBApA06ryhQ1tIm+LaJvy7LF7AzjaNv1n46NEx
 UEivJKvVhiKRWNI/fs+fZ8nnNky9N6lSiq8HedmeoBcIrflAQJFo/TLIbQ7oDUrQ/tFpAruK60w
 bu09fe565YcaSFY/TVMXUkkGVYbNgRira6E5Tyj5XI++iAIV0lbjLgzVyTb68Ppd93DA/xgcvzO
 kXB3J8JvX6rCRWTi8H/5czyCY2HTXS7FhgsiDmrilJ7e5A54tNY7iMKhWoAYGAUN3F8sWh38NTG
 dC5Der1C
X-Proofpoint-ORIG-GUID: qxjONmfzQvHVN2atCoHrrtGV0GuqBSts
X-Authority-Analysis: v=2.4 cv=HM7DFptv c=1 sm=1 tr=0 ts=68d151ec cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=bqVjg2-MoX4cBg1ZSeQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: qxjONmfzQvHVN2atCoHrrtGV0GuqBSts
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220076

Current reboot-mode supports a single 32-bit argument for any
supported mode. Some reboot-mode based drivers may require
passing two independent 32-bit arguments during a reboot
sequence, for uses-cases, where a mode requires an additional
argument. Such drivers may not be able to use the reboot-mode
driver. For example, ARM PSCI vendor-specific resets, need two
arguments for its operation – reset_type and cookie, to complete
the reset operation. If a driver wants to implement this
firmware-based reset, it cannot use reboot-mode framework.

Introduce 64-bit magic values in reboot-mode driver to
accommodate dual 32-bit arguments when specified via device tree.
In cases, where no second argument is passed from device tree,
keep the upper 32-bit of magic un-changed(0) to maintain backward
compatibility.

Update the current drivers using reboot-mode for a 64-bit magic
value.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/power/reset/nvmem-reboot-mode.c  | 13 +++++++++----
 drivers/power/reset/qcom-pon.c           | 11 ++++++++---
 drivers/power/reset/reboot-mode.c        | 19 +++++++++++++------
 drivers/power/reset/syscon-reboot-mode.c | 11 ++++++++---
 include/linux/reboot-mode.h              |  3 ++-
 5 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/drivers/power/reset/nvmem-reboot-mode.c b/drivers/power/reset/nvmem-reboot-mode.c
index 41530b70cfc48c2a83fbbd96f523d5816960a0d1..5d73dde585b1fd438b1847f884feb37cd9e4dd5c 100644
--- a/drivers/power/reset/nvmem-reboot-mode.c
+++ b/drivers/power/reset/nvmem-reboot-mode.c
@@ -16,15 +16,20 @@ struct nvmem_reboot_mode {
 	struct nvmem_cell *cell;
 };
 
-static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot,
-				    unsigned int magic)
+static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot, u64 magic)
 {
-	int ret;
 	struct nvmem_reboot_mode *nvmem_rbm;
+	u32 magic_32;
+	int ret;
+
+	if (magic > U32_MAX)
+		return -EINVAL;
+
+	magic_32 = magic;
 
 	nvmem_rbm = container_of(reboot, struct nvmem_reboot_mode, reboot);
 
-	ret = nvmem_cell_write(nvmem_rbm->cell, &magic, sizeof(magic));
+	ret = nvmem_cell_write(nvmem_rbm->cell, &magic_32, sizeof(magic_32));
 	if (ret < 0)
 		dev_err(reboot->dev, "update reboot mode bits failed\n");
 
diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
index 7e108982a582e8243c5c806bd4a793646b87189f..d0ed9431a02313a7bbaa93743c16fa1ae713ddfe 100644
--- a/drivers/power/reset/qcom-pon.c
+++ b/drivers/power/reset/qcom-pon.c
@@ -27,17 +27,22 @@ struct qcom_pon {
 	long reason_shift;
 };
 
-static int qcom_pon_reboot_mode_write(struct reboot_mode_driver *reboot,
-				    unsigned int magic)
+static int qcom_pon_reboot_mode_write(struct reboot_mode_driver *reboot, u64 magic)
 {
 	struct qcom_pon *pon = container_of
 			(reboot, struct qcom_pon, reboot_mode);
+	u32 magic_32;
 	int ret;
 
+	if (magic > U32_MAX || (magic << pon->reason_shift) > U32_MAX)
+		return -EINVAL;
+
+	magic_32 = magic << pon->reason_shift;
+
 	ret = regmap_update_bits(pon->regmap,
 				 pon->baseaddr + PON_SOFT_RB_SPARE,
 				 GENMASK(7, pon->reason_shift),
-				 magic << pon->reason_shift);
+				 magic_32);
 	if (ret < 0)
 		dev_err(pon->dev, "update reboot mode bits failed\n");
 
diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index c8f71e6f661ae14eb72bdcb1f412cd05faee3dd9..79763a839c9b0161b4acb6afb625f50a880971cc 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -19,12 +19,11 @@
 
 struct mode_info {
 	const char *mode;
-	u32 magic;
+	u64 magic;
 	struct list_head list;
 };
 
-static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
-					  const char *cmd)
+static u64 get_reboot_mode_magic(struct reboot_mode_driver *reboot, const char *cmd)
 {
 	const char *normal = "normal";
 	struct mode_info *info;
@@ -60,7 +59,7 @@ static int reboot_mode_notify(struct notifier_block *this,
 			      unsigned long mode, void *cmd)
 {
 	struct reboot_mode_driver *reboot;
-	unsigned int magic;
+	u64 magic;
 
 	reboot = container_of(this, struct reboot_mode_driver, reboot_notifier);
 	magic = get_reboot_mode_magic(reboot, cmd);
@@ -84,6 +83,8 @@ int reboot_mode_register(struct reboot_mode_driver *reboot, struct fwnode_handle
 	struct device_node *np;
 	struct property *prop;
 	size_t len = strlen(PREFIX);
+	u32 magic_arg1;
+	u32 magic_arg2;
 	int ret;
 
 	if (!fwnode)
@@ -108,12 +109,18 @@ int reboot_mode_register(struct reboot_mode_driver *reboot, struct fwnode_handle
 				goto error;
 			}
 
-			if (of_property_read_u32(np, prop->name, &info->magic)) {
-				pr_err("reboot mode %s without magic number\n", info->mode);
+			if (of_property_read_u32(np, prop->name, &magic_arg1)) {
+				pr_err("reboot mode without magic number\n");
 				kfree(info);
 				continue;
 			}
 
+			if (of_property_read_u32_index(np, prop->name, 1, &magic_arg2))
+				magic_arg2 = 0;
+
+			info->magic = magic_arg2;
+			info->magic = (info->magic << 32) | magic_arg1;
+
 			info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
 			if (!info->mode) {
 				ret =  -ENOMEM;
diff --git a/drivers/power/reset/syscon-reboot-mode.c b/drivers/power/reset/syscon-reboot-mode.c
index e0772c9f70f7a19cd8ec8a0b7fdbbaa7ba44afd0..3cbd000c512239b12ec51987e900d260540a9dea 100644
--- a/drivers/power/reset/syscon-reboot-mode.c
+++ b/drivers/power/reset/syscon-reboot-mode.c
@@ -20,16 +20,21 @@ struct syscon_reboot_mode {
 	u32 mask;
 };
 
-static int syscon_reboot_mode_write(struct reboot_mode_driver *reboot,
-				    unsigned int magic)
+static int syscon_reboot_mode_write(struct reboot_mode_driver *reboot, u64 magic)
 {
 	struct syscon_reboot_mode *syscon_rbm;
+	u32 magic_32;
 	int ret;
 
+	if (magic > U32_MAX)
+		return -EINVAL;
+
+	magic_32 = magic;
+
 	syscon_rbm = container_of(reboot, struct syscon_reboot_mode, reboot);
 
 	ret = regmap_update_bits(syscon_rbm->map, syscon_rbm->offset,
-				 syscon_rbm->mask, magic);
+				 syscon_rbm->mask, magic_32);
 	if (ret < 0)
 		dev_err(reboot->dev, "update reboot mode bits failed\n");
 
diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
index 7f05fd873e95ca8249bc167c21aa6b76faba7849..3a14df2ddd1db4181ea76f99ef447ed8368a3594 100644
--- a/include/linux/reboot-mode.h
+++ b/include/linux/reboot-mode.h
@@ -4,11 +4,12 @@
 
 #include <linux/fwnode.h>
 #include <linux/mutex.h>
+#include <linux/types.h>
 
 struct reboot_mode_driver {
 	struct device *dev;
 	struct list_head head;
-	int (*write)(struct reboot_mode_driver *reboot, unsigned int magic);
+	int (*write)(struct reboot_mode_driver *reboot, u64 magic);
 	struct notifier_block reboot_notifier;
 	/*Protects access to reboot mode list*/
 	struct mutex rb_lock;

-- 
2.34.1


