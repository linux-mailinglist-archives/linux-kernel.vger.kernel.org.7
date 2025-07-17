Return-Path: <linux-kernel+bounces-735291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D5EB08D5F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB180A45C86
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB912D7817;
	Thu, 17 Jul 2025 12:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UdTlnJxz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B012D5A08
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752756483; cv=none; b=iO4P3MkaggEwzGr9P91vvNGmHttaivMf8RqLCXFtxvrFwimtN/7OqjDPJ/rhIAAh52vD76Sx8rOR0/aKws/C6/2YtC9+wXk31GgfAOiL41cpN1YjaEgebNUso71hpR/Zz+2sXAtWi6T7PxRBfFQk02ppdOrje5M18Da/QCD56qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752756483; c=relaxed/simple;
	bh=UKHC8eZAoHyXEZlPPTpz/4QLM3qhn581r0uuXJUoOgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tMbrl7d3WgjcU3Rs5vIbfq7C3SilMNGWAlqTZGzcB7wywOJy6mBmu6ROOYQ6hy6OemBBaDvu5AkTd1Ft+VzUgsQxh6yHS8cFdXj0Jm50D1Al6SulCpri+6HKww0a90aogClCqzkRRH6+u6XMyX9btxtb+2IMWPdIFqJUpSCbnxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UdTlnJxz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCGTVa000541
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ndnZbAUz6f28J4I6Xb/FkBP9eQc/v/Yc+2hDDgd7eLk=; b=UdTlnJxzXyItwjsM
	HeZi32sOlahKgZBb9tJZVIRjfiOFIz1VNZ8ttWBW9VcGKE/XmzVVana5CTMWGWaG
	p7P0rVczeTUEUU8exs+I6bDUfHRrOcYek8Zey188XSZAFN6zmvbQm+iRyB4/2A5r
	qaACCc0FR84ZeG4oBLp6wWeYX6kfeqEXFrNEdAGP7T5Xav8JENrJqXakRA+xBB9n
	ZCkosJUtJhQ+ps8fKvu12Kbnc1eh1rGWAkkDpIwBXtGpx4ZEdW+R24FUJJPRKfE8
	fvVdeA2Iwu+XWzLBscgW2j5SM+YkV6HkvH/RFvtPk5Uq7jMWIXzL4EhTun+saBgl
	zG4LXw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5drtq54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:48:01 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3122368d82bso1374217a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 05:48:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752756480; x=1753361280;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ndnZbAUz6f28J4I6Xb/FkBP9eQc/v/Yc+2hDDgd7eLk=;
        b=j3u4NDDcg2MVqZOiliUuPNNQZE9vstqiRUHLQs5uHdFv+j7n15rQcLV0Cp7zRBGhTn
         ZxkVPvnSkfzmhSzbZJW0vRLrmKerU0Ny9kzfMJ62Ij7Eek1+ttJTku/bVTM5Hq3n/6gj
         IR1Iga93y363akVG1OdapUhlSw+AF/anlE6EXiCVqrHGKjlodBjTiEyxX0mkl9c9k8qv
         QceoWPWuYAFcxZrEtPupLAOcKhXPLOouvmvc5KNZA3RXdjAoHPqlVtjWN4VFIHb5uvPB
         Jzl5iPUpaY4g0zOgwupbqPlLrsYlLV5YZCjwRgtHCj6/9d784rLkuJArxIeh/odN5veo
         K/oQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+ZL3GvDqobYQRk31KADCE7cO9V6W3pvowHywf6jMqTtbVWXZMfNbVZFwzemP9OmjyxXnpYXikbUeNv4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr1Gat19ySMjWj7dUbvjwFoLPqbt6LDmZgQaK7C7nt9/M9lvdH
	bCk3Z1kZFSWVu3npbaa7sdlaDIvRRVaeWljRXp3h/L6w8tzJ+Py6oM7JGJDKHm8bGzPSuVLIswd
	23dvgx61NfCQlayzIrJeL16NB9FtzGGsbzgoU4qYyV/Vi80yWZ0rnX6kEgPBXo7T6Wqs=
X-Gm-Gg: ASbGncujMQOo567UBnUdGKNZ4D+aBhBe0dlI6KgVLyobTG1Gb4F+YLAZ2CYpXgmDitI
	KpHBwKECca0/aA4iWV0hsJe6JyvHIbY+UpIMb3IkEch/Djl9v1dJcrdfk1+2aIhrvlG9jf7kEbY
	vilm1mQqqQeTuhiBV69NrkX+fV+2a8GPLlnyo5RsOStUzyobs9xjpPli+W3AEl0yhx2bqRR3VwJ
	KoxyYOjeq4uJ3XJnNp348NuXTQRrDp1Z6DhEDVE+ySkWORtdQnqrrys/Qq2EY5GQBWCZeuC4ea0
	LhLqg5lFUdOfNyVAmrIYW4tN8leqzLlAjgaGgoCPDbIxXnGGtYLZsZiaQRMtieHkO3YqElYxEo7
	D
X-Received: by 2002:a17:90b:270b:b0:311:ab20:159a with SMTP id 98e67ed59e1d1-31c9f47ce74mr8791568a91.29.1752756480054;
        Thu, 17 Jul 2025 05:48:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSOTf6eWDU0ft+hKrp8ihh0WiXr7hyJaFtJBeCdXFKJ8P8KRZZCoFlpcTtg4Y4L60jS9UJvA==
X-Received: by 2002:a17:90b:270b:b0:311:ab20:159a with SMTP id 98e67ed59e1d1-31c9f47ce74mr8791502a91.29.1752756479474;
        Thu, 17 Jul 2025 05:47:59 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31caf828a0esm1505283a91.42.2025.07.17.05.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 05:47:59 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 18:16:48 +0530
Subject: [PATCH v11 2/8] power: reset: reboot-mode: Add support for 64 bit
 magic
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250717-arm-psci-system_reset2-vendor-reboots-v11-2-df3e2b2183c3@oss.qualcomm.com>
References: <20250717-arm-psci-system_reset2-vendor-reboots-v11-0-df3e2b2183c3@oss.qualcomm.com>
In-Reply-To: <20250717-arm-psci-system_reset2-vendor-reboots-v11-0-df3e2b2183c3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752756455; l=7499;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=UKHC8eZAoHyXEZlPPTpz/4QLM3qhn581r0uuXJUoOgc=;
 b=AKgwqjmRPiLizBw9dD4+7Y/kPL4CJSLKmsWjhy1mzs9Xe4lxaMckMUb3MamNinpFqxyhA/y3+
 /gypLngaYBoBQOUdTlCFiAc+4hmG6d4L6/OuR9heG2gYM2El9tjAKKU
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-ORIG-GUID: 0jayyo8vsa1B_T8MAIM-fOu7DWB8iv2M
X-Authority-Analysis: v=2.4 cv=D4xHKuRj c=1 sm=1 tr=0 ts=6878f101 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=MO_J9Aa4ypbE8kPWTcIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: 0jayyo8vsa1B_T8MAIM-fOu7DWB8iv2M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDExMiBTYWx0ZWRfX7lZAA09Ev2po
 4Nzc+IyaQvk3yThv+4ZWHtWG/AJAnUsmZoyrpjjTTaWBxDqhgoLh1PQb8qtNuc6ydllfA14qJXJ
 yvxmsyCyV2Ojxp3fSkIWmOYxyWwEGQ8QeEVTAQYwKYMOVpvADFN9zXSQy4CMmoVocrptlKUNdqr
 SllTmK4xQ63DVTfUR3uDz7cPkVz9OSnhGazRiINNvizYMKBx6/KakDXpkgwqljX/R14cBTdAUto
 OTE4vP4KqOWBmaIh2TpXWmHCN4rRz5opRNERHsTYhJEj9V0FpZZOOXUB8yKEBFrk/82kHJFqvJs
 z1kKmDvCcdgJABDHs8qQAl8yArODa1VHjYpo45XL1tcPzpKy4eVruNk114HlzSlRoYqJKSZjKA6
 2P2Ni3wSHxiYQ3Q8phsgf5hdi5QpzrGbi7OBoJ53tGiTY+OBXejxK+jUjDQPcvH5LFMDRX6K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507170112

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
 drivers/power/reset/nvmem-reboot-mode.c  |  5 ++---
 drivers/power/reset/qcom-pon.c           |  5 ++---
 drivers/power/reset/reboot-mode.c        | 27 +++++++++++++++------------
 drivers/power/reset/syscon-reboot-mode.c |  5 ++---
 include/linux/reboot-mode.h              |  4 +++-
 5 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/power/reset/nvmem-reboot-mode.c b/drivers/power/reset/nvmem-reboot-mode.c
index 41530b70cfc48c2a83fbbd96f523d5816960a0d1..e3eed943fdefa271b22e1f1891abef5c9095b9a5 100644
--- a/drivers/power/reset/nvmem-reboot-mode.c
+++ b/drivers/power/reset/nvmem-reboot-mode.c
@@ -16,15 +16,14 @@ struct nvmem_reboot_mode {
 	struct nvmem_cell *cell;
 };
 
-static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot,
-				    unsigned int magic)
+static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot, u64 magic)
 {
 	int ret;
 	struct nvmem_reboot_mode *nvmem_rbm;
 
 	nvmem_rbm = container_of(reboot, struct nvmem_reboot_mode, reboot);
 
-	ret = nvmem_cell_write(nvmem_rbm->cell, &magic, sizeof(magic));
+	ret = nvmem_cell_write(nvmem_rbm->cell, (u32 *)&magic, sizeof(u32));
 	if (ret < 0)
 		dev_err(reboot->dev, "update reboot mode bits failed\n");
 
diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
index 7e108982a582e8243c5c806bd4a793646b87189f..93daf93c097f970afbaf43d36b1e4f725ca7a81f 100644
--- a/drivers/power/reset/qcom-pon.c
+++ b/drivers/power/reset/qcom-pon.c
@@ -27,8 +27,7 @@ struct qcom_pon {
 	long reason_shift;
 };
 
-static int qcom_pon_reboot_mode_write(struct reboot_mode_driver *reboot,
-				    unsigned int magic)
+static int qcom_pon_reboot_mode_write(struct reboot_mode_driver *reboot, u64 magic)
 {
 	struct qcom_pon *pon = container_of
 			(reboot, struct qcom_pon, reboot_mode);
@@ -37,7 +36,7 @@ static int qcom_pon_reboot_mode_write(struct reboot_mode_driver *reboot,
 	ret = regmap_update_bits(pon->regmap,
 				 pon->baseaddr + PON_SOFT_RB_SPARE,
 				 GENMASK(7, pon->reason_shift),
-				 magic << pon->reason_shift);
+				 ((u32)magic) << pon->reason_shift);
 	if (ret < 0)
 		dev_err(pon->dev, "update reboot mode bits failed\n");
 
diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index 0269ec55106472cf2f2b12bd65704dd0114bf4a3..1196627fbf98d87eec57a3d4ee544e403e6eb946 100644
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
+static struct mode_info *get_reboot_mode_info(struct reboot_mode_driver *reboot, const char *cmd)
 {
 	const char *normal = "normal";
 	struct mode_info *info;
@@ -35,11 +34,11 @@ static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
 
 	list_for_each_entry(info, &reboot->head, list)
 		if (!strcmp(info->mode, cmd))
-			return info->magic;
+			return info;
 
 	/* try to match again, replacing characters impossible in DT */
 	if (strscpy(cmd_, cmd, sizeof(cmd_)) == -E2BIG)
-		return 0;
+		return NULL;
 
 	strreplace(cmd_, ' ', '-');
 	strreplace(cmd_, ',', '-');
@@ -47,21 +46,21 @@ static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
 
 	list_for_each_entry(info, &reboot->head, list)
 		if (!strcmp(info->mode, cmd_))
-			return info->magic;
+			return info;
 
-	return 0;
+	return NULL;
 }
 
 static int reboot_mode_notify(struct notifier_block *this,
 			      unsigned long mode, void *cmd)
 {
 	struct reboot_mode_driver *reboot;
-	unsigned int magic;
+	struct mode_info *info;
 
 	reboot = container_of(this, struct reboot_mode_driver, reboot_notifier);
-	magic = get_reboot_mode_magic(reboot, cmd);
-	if (magic)
-		reboot->write(reboot, magic);
+	info = get_reboot_mode_info(reboot, cmd);
+	if (info)
+		reboot->write(reboot, info->magic);
 
 	return NOTIFY_DONE;
 }
@@ -78,6 +77,7 @@ int reboot_mode_register(struct reboot_mode_driver *reboot, struct device_node *
 	struct mode_info *info;
 	struct property *prop;
 	size_t len = strlen(PREFIX);
+	u32 magic_64;
 	int ret;
 
 	if (!np)
@@ -95,12 +95,15 @@ int reboot_mode_register(struct reboot_mode_driver *reboot, struct device_node *
 			goto error;
 		}
 
-		if (of_property_read_u32(np, prop->name, &info->magic)) {
+		if (of_property_read_u32(np, prop->name, (u32 *)&info->magic)) {
 			pr_err("reboot mode %s without magic number\n", info->mode);
 			kfree(info);
 			continue;
 		}
 
+		if (!of_property_read_u32_index(np, prop->name, 1, &magic_64))
+			info->magic |= (u64)magic_64 << 32;
+
 		info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
 		if (!info->mode) {
 			ret =  -ENOMEM;
diff --git a/drivers/power/reset/syscon-reboot-mode.c b/drivers/power/reset/syscon-reboot-mode.c
index e0772c9f70f7a19cd8ec8a0b7fdbbaa7ba44afd0..6783d05e80fbc2c812b45ffe69755478af90d30a 100644
--- a/drivers/power/reset/syscon-reboot-mode.c
+++ b/drivers/power/reset/syscon-reboot-mode.c
@@ -20,8 +20,7 @@ struct syscon_reboot_mode {
 	u32 mask;
 };
 
-static int syscon_reboot_mode_write(struct reboot_mode_driver *reboot,
-				    unsigned int magic)
+static int syscon_reboot_mode_write(struct reboot_mode_driver *reboot, u64 magic)
 {
 	struct syscon_reboot_mode *syscon_rbm;
 	int ret;
@@ -29,7 +28,7 @@ static int syscon_reboot_mode_write(struct reboot_mode_driver *reboot,
 	syscon_rbm = container_of(reboot, struct syscon_reboot_mode, reboot);
 
 	ret = regmap_update_bits(syscon_rbm->map, syscon_rbm->offset,
-				 syscon_rbm->mask, magic);
+				 syscon_rbm->mask, (u32)magic);
 	if (ret < 0)
 		dev_err(reboot->dev, "update reboot mode bits failed\n");
 
diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
index 36f071f4b82e1fc255d8dd679a18e537655c3179..d9d9165a8635e5d55d92197a69c7fae179ac2045 100644
--- a/include/linux/reboot-mode.h
+++ b/include/linux/reboot-mode.h
@@ -2,10 +2,12 @@
 #ifndef __REBOOT_MODE_H__
 #define __REBOOT_MODE_H__
 
+#include <linux/types.h>
+
 struct reboot_mode_driver {
 	struct device *dev;
 	struct list_head head;
-	int (*write)(struct reboot_mode_driver *reboot, unsigned int magic);
+	int (*write)(struct reboot_mode_driver *reboot, u64 magic);
 	struct notifier_block reboot_notifier;
 };
 

-- 
2.34.1


