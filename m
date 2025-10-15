Return-Path: <linux-kernel+bounces-853741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7648BDC7E7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A574230F3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D61F2FD7D2;
	Wed, 15 Oct 2025 04:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NeMyofGS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EB42FDC4D
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760503131; cv=none; b=XgV+1U8oVe2zXKPWO6r4v0XgmvxzkZI92SBOz6WXycd/GnAMyzfe9JpT/AfCn1Q0ptIWGO4b96+el0s5nqsoSE/I7GC0Dh919fmfVj6JIP+OEnLtrW9Mz+iYboNEw5fiBWA3xuh0lC6o7BJSB54XoLvp1CUaLq2WDe/92t6gkDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760503131; c=relaxed/simple;
	bh=+LF5Rl/5f5znpMQv1GLZ4NG0dpObtQwZ7SckbxZ5OJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TN9NR1AkpkjqGsI43VbYMyK1Ff9zHhIOP9kpvs39LLCRG1yfXDFBVe1rlpgwbplpf185fF32KAyIiaCL3tOc/IO8jcReQH/4a+EXUDSyIkY/igsiUuxDST9OtJdJq2OBZg8DgbubmLUM+B56n/kP0Z0h0Vqn5dB9irmp8nHRZug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NeMyofGS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2s6tV003404
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:38:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wck1RFL3Etc5iANJFBisnl6A9QEEqYSWtMuEcnVHG7E=; b=NeMyofGSEPD7nble
	7u4vK4vF1Lvmcr3EAJhxZLCFe9wQE2QAfTSqt8a7V+3QYgCU0QJU1AsFPm7JGsNc
	/J4GlR2nz2VMggOt3mR3tOHCzQ5kbHFVmuXnALpj0qhvo6KCGXwo5ake57C1Ehpq
	t5mm7TO5DRKiCHjwWqiezSod+ipy35j2QhoMJvHUR51SDowjmfvWZyJP9cBcbaYh
	Q6kfWPAhI2jwRnEKimD+mdV3uMbWudjBs4D6SRptx4FoUIC/H8O+PrqhrLxgXR0H
	76V2NQc2N9XLau4piN9vCRSUHCbKuOgFtP2PLKAd+/x9B63jOgzKalXKAdYQ1Vib
	bEGReA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49sua8hmcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:38:48 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33274f8ff7cso14167932a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 21:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760503127; x=1761107927;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wck1RFL3Etc5iANJFBisnl6A9QEEqYSWtMuEcnVHG7E=;
        b=qsk5/GtNs/ek+3tYn8lJHcBEeTY+edRy+pd3rdZ0yieb0x5rNJZXlA1ai8CF3dbK64
         8VD3YHtJmgPJU4ZUzV8518v1DUWc7QeJDpNLe7AM3Bj7h5haEsQ8S8PMHJ3z8Ov5HgzT
         MaHNEtnr9DVez8aEqVtLBpk6qjveC4mboFy3PdCyM60NGE90FQFtI4xyNFUkcJA6n3nE
         710IAPIR6J/wc32qqyFafjGGiiFWc0WHvBcr6f80qMmqBKN4XDWf/HDhwQm5LUl7GZPP
         9DLktjF9A6toNXNGXs3Zk/V+qKuNZHuGd0rLcrc7trK8CICYrgjgqWWo9op050MfkHxa
         oDVA==
X-Forwarded-Encrypted: i=1; AJvYcCXRdYTCqT0xUZuAscv7sLzvmuKhHj85vvpvDKMM2TZH6r2mt57MGrYnX7CB7kfMM7HUtM94KkkrQ7ziFHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5gPiCqOhojELRObaCMgCEXHnEgTgSYWMJWFsRL7WEXB2Sdt3s
	9TicQ19gdLIlZjw5T8TrWgf46/PsEmOSsprnLyfsmt29YX48m6Pkvcc719i82QUbPKLlmHXpiOx
	kS0QbfPJTLYwfm6XWaSKSk/EjIJZAYkPOTY6cfJrkh1phtMHGDA/tXxNZ/1rBJWxJ/Wo=
X-Gm-Gg: ASbGncsczKgAak6MVa5nixOhnY1T2OtSwXmz38pIHCjj+K0RIQCyQhT3u4aQOR/NIdF
	4yHEbCERFUsCjv0NoTLQ/zW4vvC4FqcdZ/+xVycMNXnBc45ofmt+KDU0ngvOsZ1dAD2hCJy9hMO
	85Jw4M4k6wlJB8JFHcFJHijYOMrNuI0AfbKDrnv2kJNsgl7Ao4ZCMTHst721PZ0WI6OcAWUCra4
	bgZWLnNVPuhVMmM62uPKNS7Ip/XXE0dLmu7C8s3eZ5tBkBCHvqHEhhcSDj37SRe7CYiA+kmjCCr
	BDGoMPC8e4FH1kGo2QeQO6eKurcz+ZPP/sSsP34JTE8JQOMBfhcJll/nfv79qj7mSl+4zVIKBsq
	veWevCYd1rzsyAGwi11MqazcUmtWRFgX4F8g=
X-Received: by 2002:a17:90b:1b11:b0:32e:38b0:15f4 with SMTP id 98e67ed59e1d1-33b51149231mr41033775a91.7.1760503126788;
        Tue, 14 Oct 2025 21:38:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcE7BVlkZyFvP65jtmD82QS6auIKSOb6IQDfvqpkbwzRYwpRA963gMl1T170bPhVqowG+flA==
X-Received: by 2002:a17:90b:1b11:b0:32e:38b0:15f4 with SMTP id 98e67ed59e1d1-33b51149231mr41033685a91.7.1760503125868;
        Tue, 14 Oct 2025 21:38:45 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b9787af5asm705406a91.20.2025.10.14.21.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 21:38:45 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 10:08:16 +0530
Subject: [PATCH v16 01/14] power: reset: reboot-mode: Synchronize list
 traversal
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-arm-psci-system_reset2-vendor-reboots-v16-1-b98aedaa23ee@oss.qualcomm.com>
References: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
In-Reply-To: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760503106; l=5404;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=+LF5Rl/5f5znpMQv1GLZ4NG0dpObtQwZ7SckbxZ5OJg=;
 b=snPD9SWri/7WPNXnr/mfAI9TPr8Ul7090wSZuFr3hvCeRxC1BaCSscVG7MMy7xWGZC8yUHPFg
 KTwa+VD6tfIBELEX0z/Ht6VTERYuhSEoPgGHb0yolprbsmJR9+HFeeX
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-GUID: sk_jp-JZbAbBildO-GQFkCBwmDDT8V1_
X-Authority-Analysis: v=2.4 cv=e5MLiKp/ c=1 sm=1 tr=0 ts=68ef2558 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=gP18aZtcJwKeVuiPoooA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDEzNCBTYWx0ZWRfXz4/AkvueIxVv
 jSci0AnBjh/q2x/JdlNqmFQy+EAVQVUxtH4GbpSJ4CCmIgVIUk5hMjrsGm+W9o8gVjJSqjzfBZc
 SIwA3RUC+5IX2FGSH7B+85wM8y5oU3l9k2G9ULx8MvBGbqzKaz8p6ZF6RVk2u+9m5ha1TVZPBSX
 b8/L0XW5+g6aNZRp34aevW6qcG3VzFTUG+h4NT/Qjq4ZTPfzKJlCeBnmqJqwm7Elhdttr7UqQhS
 AnaVpK36v3QLZpGIZdAGfZhjksZyf9m0b+//zFEN+TcLOSwi1n1xg7rYmWWQAvjdFgk2EJDygcC
 Rn1ERVWtr98RcIyzytwHPOgqCOHAGfQxzvw1CWz7u3ksW3GBrGRZ5pmQzD7lY3SeEP99bJTFfn6
 OaFZBDWzmfDMGHzxy5bNPCrSMa4A5w==
X-Proofpoint-ORIG-GUID: sk_jp-JZbAbBildO-GQFkCBwmDDT8V1_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510140134

List traversals must be synchronized to prevent race conditions
and data corruption. The reboot-mode list is not protected by a
lock currently, which can lead to concurrent access and race.

Introduce a mutex lock to guard all operations on the reboot-mode
list and ensure thread-safe access. The change prevents unsafe
concurrent access on reboot-mode list.

Fixes: 4fcd504edbf7 ("power: reset: add reboot mode driver")
Fixes: ca3d2ea52314 ("power: reset: reboot-mode: better compatibility with DT (replace ' ,/')")

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/power/reset/reboot-mode.c | 96 +++++++++++++++++++++------------------
 include/linux/reboot-mode.h       |  4 ++
 2 files changed, 57 insertions(+), 43 deletions(-)

diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index fba53f638da04655e756b5f8b7d2d666d1379535..8fc3e14638ea757c8dc3808c240ff569cbd74786 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -29,9 +29,11 @@ static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
 	if (!cmd)
 		cmd = normal;
 
-	list_for_each_entry(info, &reboot->head, list)
-		if (!strcmp(info->mode, cmd))
-			return info->magic;
+	scoped_guard(mutex, &reboot->rb_lock) {
+		list_for_each_entry(info, &reboot->head, list)
+			if (!strcmp(info->mode, cmd))
+				return info->magic;
+	}
 
 	/* try to match again, replacing characters impossible in DT */
 	if (strscpy(cmd_, cmd, sizeof(cmd_)) == -E2BIG)
@@ -41,9 +43,11 @@ static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
 	strreplace(cmd_, ',', '-');
 	strreplace(cmd_, '/', '-');
 
-	list_for_each_entry(info, &reboot->head, list)
-		if (!strcmp(info->mode, cmd_))
-			return info->magic;
+	scoped_guard(mutex, &reboot->rb_lock) {
+		list_for_each_entry(info, &reboot->head, list)
+			if (!strcmp(info->mode, cmd_))
+				return info->magic;
+	}
 
 	return 0;
 }
@@ -78,46 +82,50 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 
 	INIT_LIST_HEAD(&reboot->head);
 
-	for_each_property_of_node(np, prop) {
-		if (strncmp(prop->name, PREFIX, len))
-			continue;
-
-		info = devm_kzalloc(reboot->dev, sizeof(*info), GFP_KERNEL);
-		if (!info) {
-			ret = -ENOMEM;
-			goto error;
-		}
-
-		if (of_property_read_u32(np, prop->name, &info->magic)) {
-			dev_err(reboot->dev, "reboot mode %s without magic number\n",
-				info->mode);
-			devm_kfree(reboot->dev, info);
-			continue;
-		}
-
-		info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
-		if (!info->mode) {
-			ret =  -ENOMEM;
-			goto error;
-		} else if (info->mode[0] == '\0') {
-			kfree_const(info->mode);
-			ret = -EINVAL;
-			dev_err(reboot->dev, "invalid mode name(%s): too short!\n",
-				prop->name);
-			goto error;
+	mutex_init(&reboot->rb_lock);
+
+	scoped_guard(mutex, &reboot->rb_lock) {
+		for_each_property_of_node(np, prop) {
+			if (strncmp(prop->name, PREFIX, len))
+				continue;
+
+			info = devm_kzalloc(reboot->dev, sizeof(*info), GFP_KERNEL);
+			if (!info) {
+				ret = -ENOMEM;
+				goto error;
+			}
+
+			if (of_property_read_u32(np, prop->name, &info->magic)) {
+				dev_err(reboot->dev, "reboot mode %s without magic number\n",
+					info->mode);
+				devm_kfree(reboot->dev, info);
+				continue;
+			}
+
+			info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
+			if (!info->mode) {
+				ret =  -ENOMEM;
+				goto error;
+			} else if (info->mode[0] == '\0') {
+				kfree_const(info->mode);
+				ret = -EINVAL;
+				dev_err(reboot->dev, "invalid mode name(%s): too short!\n",
+					prop->name);
+				goto error;
+			}
+
+			list_add_tail(&info->list, &reboot->head);
 		}
 
-		list_add_tail(&info->list, &reboot->head);
-	}
-
-	reboot->reboot_notifier.notifier_call = reboot_mode_notify;
-	register_reboot_notifier(&reboot->reboot_notifier);
+		reboot->reboot_notifier.notifier_call = reboot_mode_notify;
+		register_reboot_notifier(&reboot->reboot_notifier);
 
-	return 0;
+		return 0;
 
 error:
-	list_for_each_entry(info, &reboot->head, list)
-		kfree_const(info->mode);
+		list_for_each_entry(info, &reboot->head, list)
+			kfree_const(info->mode);
+	}
 
 	return ret;
 }
@@ -133,8 +141,10 @@ int reboot_mode_unregister(struct reboot_mode_driver *reboot)
 
 	unregister_reboot_notifier(&reboot->reboot_notifier);
 
-	list_for_each_entry(info, &reboot->head, list)
-		kfree_const(info->mode);
+	scoped_guard(mutex, &reboot->rb_lock) {
+		list_for_each_entry(info, &reboot->head, list)
+			kfree_const(info->mode);
+	}
 
 	return 0;
 }
diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
index 4a2abb38d1d612ec0fdf05eb18c98b210f631b7f..b73f80708197677db8dc2e43affc519782b7146e 100644
--- a/include/linux/reboot-mode.h
+++ b/include/linux/reboot-mode.h
@@ -2,11 +2,15 @@
 #ifndef __REBOOT_MODE_H__
 #define __REBOOT_MODE_H__
 
+#include <linux/mutex.h>
+
 struct reboot_mode_driver {
 	struct device *dev;
 	struct list_head head;
 	int (*write)(struct reboot_mode_driver *reboot, unsigned int magic);
 	struct notifier_block reboot_notifier;
+	/*Protects access to reboot mode list*/
+	struct mutex rb_lock;
 };
 
 int reboot_mode_register(struct reboot_mode_driver *reboot);

-- 
2.34.1


