Return-Path: <linux-kernel+bounces-891991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F050C44073
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 15:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22426188BCFA
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 14:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1622F9DAE;
	Sun,  9 Nov 2025 14:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HIoQb7Uj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DqKsCLBb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD342FB0B9
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762699096; cv=none; b=QMl8cQ8bXdAXh8ni+wkcKv9Av3EdU6b3cCsT1LiLjWJJWHKLuw/nEWg3RsUDnQxI+6dx3LaFYb9yyYG46CxOf7p1G1qqPtZSGzF5HZZI1SqLJ85QUxErI/IzAoOQ3nEenFai3tTMoKxDKjkF58fKupHR7SZYiJ/mRoWO/0oAuGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762699096; c=relaxed/simple;
	bh=tSD2yNZaJDc5m1jdDRoQ2dA6oSVGR8ZTHjS4GRBmNcg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YrWYUvlbH3hoPyLmTbV7yeTffCCxjrrLdHCtl6wy8wutm5kCx94d52NHKxIaCjQ/QyUS4SFKpkvn+cAhBydWO7bf6PArOD0d7o96JnW+AIj9dp+vKKXgt99HacUVwB40JxmpPOkPnDP81WasvrsttLFrzuuKv7lL38pTlUCr+DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HIoQb7Uj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DqKsCLBb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A9EHBUp786941
	for <linux-kernel@vger.kernel.org>; Sun, 9 Nov 2025 14:38:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jiNDMgJ1PRczoI1657/zd47IielAoH6hCTaVhiNKpyE=; b=HIoQb7UjY9q077NI
	kVl2CpnPnEJvwugYDSyD0BYY7Ki1Ddbt4V2S12+fnDUy7cDXHr5lEwCKvV8sfzI4
	UGzOvjxgkrxhEUwljXiwKmposcK1U9CsT3eDZA48WD9edb5d24OEq03Qy3iKMW/l
	gm0pZPVbVktoSzG9zqMu1MEuAM/FnB5PduxO6LdBsEO/sSKBZO6gkjsIglsAlUl7
	ucvhr1MhO+1vPJlKDrGpgkph5Id5Xk3qpn0TgRkyaMaOmdXOHOuBCrhDfDG8nNrR
	bDGsRSZXq0NYbxd/hjscqlwJHKiOraj4NgN6QLnWQ9jauzBQkncuaBsVC+vb00o/
	irn1fg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aaue0g3ce-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 14:38:13 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-340299cc2ecso2896738a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 06:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762699093; x=1763303893; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jiNDMgJ1PRczoI1657/zd47IielAoH6hCTaVhiNKpyE=;
        b=DqKsCLBbFDQft/ZoGsDbfSkzCNmoOhIn+rQjC7NCEHqAshONiYsT6cuUhZsfhcFQs0
         WRqF7iwG0cZRrMtvevOukeUEzaqhbwQ7wfUtRWhsnwwNNxAHQDE22WuOqyef1nte4Ue6
         Z3QL/GAHMi/h17jO4dhzEpicBbZu07CXmJKsdNQ4C+gts1rI5ZvdUJ5lEMkFHTr2Iez3
         A8skSGTo8bmWWXWm8s37LjRYmvT/pqPAJEf1Q2DeSs8rfgL1qKtcAzuVLbjdqJ7lmr0D
         0CgzYxFhBmfdcc5ZJrY8f2VEflbEWmaE8aqx076ILATG9m2uTXlKCwQAMLABE+J3gNC7
         9CJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762699093; x=1763303893;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jiNDMgJ1PRczoI1657/zd47IielAoH6hCTaVhiNKpyE=;
        b=L1yTc9cTfyAeLbUm8ysWtD0SG7Py9AwoaRL9oRrhikTeYAj2j24/UzMOKTjBByQuaL
         Mc0SSnz+rXktFQEV/LB0UlRfTLvoc1SIb9RTeUoGB3MOJ1nV0ARyxR2RDwWBW5Tn0gBU
         ADXbfUGXrvYcQl1//Gi6F56cQ4u/EFSdwZ721NxzURCrQm+5NbHGynkI3NZV3YjaKYmV
         HjoY04kebMp571oHKWGXFAt2g3o82qsjsghPUjPsNUDW3AKPjiQ2ifQ6dNiOfDfPEkw0
         DtF4L/kSzQs+r9I3i2QjzWXEaSURUOEK92XIuTZx+K5JRWAOUuBgI1EU0orwnkgWPuyd
         PTHg==
X-Forwarded-Encrypted: i=1; AJvYcCXKJuiDeqSyqPmF+Ov68RqIlqyikacmBtBi4O5P3YATaH7s9Ag4VzdG+YNJHO63EQ1m/V+Gb8OPwgyGAN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcOpzMufMJNgsQCrR+QqpTutnf8ZzBWGClxmLceRuV6kntgj7c
	z7eZhWTN2dpKTdcEj+jyqv3qnlidcRBy58SOOG+ElsRNZW+Rk+aV4n/ZLgDZiss9WVd+pb5YSKg
	Czq49JrK7R+6wszGWJwWw+je5pGRuCMfI7SIXZYDVj1GVH2eL5Dlpv8Mf4Ia+AdP2L9w=
X-Gm-Gg: ASbGncu8HTpJM8Wr9bFBJvUflUjVKKMBs6IUoQNd+Bfg00pHbChHNwwKwPl8GuLhFSG
	LMmGUMCnVb7mQQwErIQn5Tem/iHxs3phBKQQEkOo2JfVcV/65U+LLJJU456X92yGLk+L27HMZRe
	PnX1UlApCUXXTSeTQXLMEx2j4a/QzPU7MR1iiixp0qT5Y5MN9xxdBRWnpljMgUwG3x88hh5khyf
	sEE2ncdEVGb3yYoR+KdVKjM2j8mf7NBTESTwkf2Po3Q+XJ3G5yDs1Ah6v0TD11j59+wfXsgNAPR
	JXm77yp1CHZ34se6+ECMq7PIRA+78QlgTrpjaRyJOIRmCGb9pFcDPDP3R3GwtkhFrL2VQje5N4G
	ANUc3WAg+hd/rlD+jTCH5JaKoQ+Kd8LLtCKw=
X-Received: by 2002:a17:90b:2e50:b0:32e:8ff9:d124 with SMTP id 98e67ed59e1d1-3436acc10b1mr6325921a91.15.1762699092565;
        Sun, 09 Nov 2025 06:38:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsz33mCu2I9XufPajBf7LFsiT4u4peJwvXKj1MW+NqngdPeP21HWE8OBRYf1Aie7N1TK+YOA==
X-Received: by 2002:a17:90b:2e50:b0:32e:8ff9:d124 with SMTP id 98e67ed59e1d1-3436acc10b1mr6325873a91.15.1762699092004;
        Sun, 09 Nov 2025 06:38:12 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68a68e6sm14845401a91.4.2025.11.09.06.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 06:38:11 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Sun, 09 Nov 2025 20:07:14 +0530
Subject: [PATCH v17 01/12] power: reset: reboot-mode: Remove devres based
 allocations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-arm-psci-system_reset2-vendor-reboots-v17-1-46e085bca4cc@oss.qualcomm.com>
References: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
In-Reply-To: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
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
        Xin Liu <xin.liu@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762699073; l=3273;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=tSD2yNZaJDc5m1jdDRoQ2dA6oSVGR8ZTHjS4GRBmNcg=;
 b=bUjyq9xpjS9KUiS6+Nw78zrsSxHqaWYFJL0jGHwwWaOkVhD0IIgjEAY5Z0HoEPo/CcR3Xz4oA
 IulwmmBv4T4A9e0Vrji+SnFgsZO+5ByFEtY5OaqNKYLzIpwTq8pESLl
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-ORIG-GUID: dHg5l_0y27db__R4UGRPJpoPY3XjfZk_
X-Authority-Analysis: v=2.4 cv=BfDVE7t2 c=1 sm=1 tr=0 ts=6910a755 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=wx_w4_m59dWKJ5at3RkA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: dHg5l_0y27db__R4UGRPJpoPY3XjfZk_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA5MDEyOSBTYWx0ZWRfX1wCnv8x5L6mu
 hrdG9fCCZ1FxlElbZ6FcmIWF24AaSHICe9GcTMBcOS3lde1TZeqZdNfsMbRaUEPgrOXNSK+RF21
 BLpLJL4UxWqlDflwKZ6KKjuiWDBN8GdBwEMVNTl7KB6AFw8Bi9p1167ULhjuJ2xZUOigkeBv58n
 jDb0qdbIEUe/qX5zKDXnJtr5LEPnFxBdWR5umrKsu3ZVeQBOfx4iyckchTo7YEieaUnM0RsVpYp
 pq1KQAcwn7fLhuGorYXKXD4scH9gELVqDZf2Mfn7k/ISELRcqb8FLS5rBv+B39JBvtqfscY4Cgf
 u9eIut37x/kCh/sNyn5oM+99KZmkGHjhM41FtceEYd19RdNmsVD9bVlWJdvxmkNqx1UOtJyK8Yl
 jcFH1As3bEJaGdWfRqoyIUTp3ZkP4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-09_06,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511090129

Devres APIs are intended for use in drivers, and they should be
avoided in shared subsystem code which is being used by multiple
drivers. Avoid using devres based allocations in the reboot-mode
subsystem and manually free the resources.

Replace devm_kzalloc with kzalloc and handle memory cleanup
explicitly.

Fixes: 4fcd504edbf7 ("power: reset: add reboot mode driver")
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/power/reset/reboot-mode.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index fba53f638da04655e756b5f8b7d2d666d1379535..ac4223794083f36960b2bd37a601b7e1f1872de5 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -3,6 +3,8 @@
  * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
  */
 
+#define pr_fmt(fmt)	"reboot-mode: " fmt
+
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -71,6 +73,7 @@ static int reboot_mode_notify(struct notifier_block *this,
 int reboot_mode_register(struct reboot_mode_driver *reboot)
 {
 	struct mode_info *info;
+	struct mode_info *next;
 	struct property *prop;
 	struct device_node *np = reboot->dev->of_node;
 	size_t len = strlen(PREFIX);
@@ -82,29 +85,27 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 		if (strncmp(prop->name, PREFIX, len))
 			continue;
 
-		info = devm_kzalloc(reboot->dev, sizeof(*info), GFP_KERNEL);
+		info = kzalloc(sizeof(*info), GFP_KERNEL);
 		if (!info) {
 			ret = -ENOMEM;
 			goto error;
 		}
 
 		if (of_property_read_u32(np, prop->name, &info->magic)) {
-			dev_err(reboot->dev, "reboot mode %s without magic number\n",
-				info->mode);
-			devm_kfree(reboot->dev, info);
+			pr_err("reboot mode %s without magic number\n", info->mode);
+			kfree(info);
 			continue;
 		}
 
 		info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
 		if (!info->mode) {
 			ret =  -ENOMEM;
-			goto error;
+			goto err_info;
 		} else if (info->mode[0] == '\0') {
 			kfree_const(info->mode);
 			ret = -EINVAL;
-			dev_err(reboot->dev, "invalid mode name(%s): too short!\n",
-				prop->name);
-			goto error;
+			pr_err("invalid mode name(%s): too short!\n", prop->name);
+			goto err_info;
 		}
 
 		list_add_tail(&info->list, &reboot->head);
@@ -115,9 +116,14 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 
 	return 0;
 
+err_info:
+	kfree(info);
 error:
-	list_for_each_entry(info, &reboot->head, list)
+	list_for_each_entry_safe(info, next, &reboot->head, list) {
+		list_del(&info->list);
 		kfree_const(info->mode);
+		kfree(info);
+	}
 
 	return ret;
 }
@@ -130,11 +136,15 @@ EXPORT_SYMBOL_GPL(reboot_mode_register);
 int reboot_mode_unregister(struct reboot_mode_driver *reboot)
 {
 	struct mode_info *info;
+	struct mode_info *next;
 
 	unregister_reboot_notifier(&reboot->reboot_notifier);
 
-	list_for_each_entry(info, &reboot->head, list)
+	list_for_each_entry_safe(info, next, &reboot->head, list) {
+		list_del(&info->list);
 		kfree_const(info->mode);
+		kfree(info);
+	}
 
 	return 0;
 }

-- 
2.34.1


