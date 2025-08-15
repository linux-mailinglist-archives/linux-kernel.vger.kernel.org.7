Return-Path: <linux-kernel+bounces-771039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F484B28201
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829BD1CC679B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6321D5AB7;
	Fri, 15 Aug 2025 14:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bfxoMusV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A0F225779
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755268601; cv=none; b=CVXFHeom3uH5UcBPIWtoLSNbMIzBfdqm5Jslw67vs2Xyqj7m55XG+dw49A+2vqIuiX2gdbaVZrJOXss+Qe5z7txY55PA+I6aZ3t8SRE7kGDwKvid1txIMOVQzwKxB1ur8UwedWf+FJ/HUNHwwzO+qnILTOEziT+v6rjLKx/HMwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755268601; c=relaxed/simple;
	bh=FC7RrRfjKXNVyHBQzF6uwLhcss5N7idT7lbjBm/hwDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QRs72XNIiO14ockA41kXp2Xl603LjEL956LDJMuHSe/hufPRVuQWe94cxZtj3XA0QJ1BzRIBWTte9BgtZykoBteigcuCLqa7qfK3iUJDCzcCJTnf/oWQapMPpywQCoMAxjaimUcZe5T4M6X1yY8nXWUDh1gL26hgTNBwiV8RVk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bfxoMusV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FEKMY6021968
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:36:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v4YCBWmY0mp9H7MQ3j2gakQJBYTosZxb2APt1bK5h/Q=; b=bfxoMusV+UeHpJYS
	tVHWrsfZOEK6xVzwa+eAnGLEM2Aqciwlq7CI4IB/UoLpjhHfbPoE84geqQpcR1Eb
	F9+4fXqNoElfeUEf9uaXJKS5XDsDnOkxLR+ecgcutM+weSBgFXlPM4nbSlJKZqls
	uQYv05X4h+nVUeqkh6n7bsQquvWvji90fYjVrnzLX09FDydmJWs0SXz2DZH01mt0
	Vs+E73FQwjQ+JO8YT1IwprMQEHiHb41mrB+0cYROltsng5+7Jr1NlRY7ggiE3jUT
	IwHtnJd3QOne8M5AQNbq1oUPoIQ67YJyeTR38pJDbkwij2/AAeKrn/lohfHNFuFJ
	m38lDQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fem4q613-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:36:38 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-244582bc5e4so22166125ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755268597; x=1755873397;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4YCBWmY0mp9H7MQ3j2gakQJBYTosZxb2APt1bK5h/Q=;
        b=PIT0TeypYf/FLduJDMNuc/THO5O2dRRDjktHbxb6ZS+IQ8icznPAhHV4TPaOB07+5/
         7HjcKXkiZe26FHUmz4fVeZyKnVeYw1Xqh1R/Bcu4frhKHLZVvh195X9tPI7P4NybYD8U
         qaATaB+3AwEbRMCvIO9Ph7xyt5p1m5KzXpi6TL/FnkrWUocsa6c+XlAZ3j4ko5uT4met
         78EhGdPNc+UhI/ZKTVbRA14sNv0M2UMIipVupe5msL9cPslaTrIM+bqJU29PHKVz0F8B
         qpJnzgvyc4Z5vTedbslky+8G29aCezBS01CY7AE41J9bYI5rbQOORGmqIVq/bMulunIo
         +tbw==
X-Forwarded-Encrypted: i=1; AJvYcCWg12QpXd2yqwE66sHrRfFzHFjz565vARF0MaLtBwM2/+VAoo+MAnwJsA46CbUTra1sNXhdn5mOzTq4BOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdefTTkzc91q8VywyPqxj0O2j9g7gjAydb2MdgMrISRjPegaeP
	+/7dLCbGVRo97KC0QLnXbXOHg6YSfKPPLt07D+SbtwGeZBFSmHXU8kKjiBmq326E87LlxfYQ+EE
	IKHOpurIt4pQqqyTYQMI4VzHXvFZUydkeJM6rHbXuigNOyMD6Mh8zLSHQPVWb/Tp2+6I=
X-Gm-Gg: ASbGnctnMX8swqXgU12nVZMfqgk+bCjxq1KUxzNqrD/rEBhuEIJnaP+pCi8clcQIxOC
	tajudDfP3lpi2iQUzeK5twyRu8uemT0mQI6MucX4qqkN9EbTGa6oKUCu2wWHaVhMQLCWSGST/5/
	XsWYbLfUOWCcvJVYrYVov5l6Kj2Wl0xELM5bar+T5zr9yuoKr4QZPlb4CO9j4lt2bxPgb+t4roi
	Dm3EG9HjlSsK/PPPoCPN8zHmq/PnN44ohH16Sv8lDLTzJQLr6eNHfc35RLE6f7Mw4iyn/Y/4MkW
	sPVz14sD6MmM2VM6ylMwCA0WBT/5c9h8WxApPH/1POuG5HKsqmLjahivnOZGypsX+yUKWK54bGV
	q
X-Received: by 2002:a17:902:c404:b0:240:2145:e526 with SMTP id d9443c01a7336-2446d5bced9mr33643405ad.6.1755268597527;
        Fri, 15 Aug 2025 07:36:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8j2DBTSDu5n5h8GFZmi+daS6bzM/R0ejhF0k7J+060Go5g2KE+vK8hO6LMHELOHeOiEIIIg==
X-Received: by 2002:a17:902:c404:b0:240:2145:e526 with SMTP id d9443c01a7336-2446d5bced9mr33642895ad.6.1755268597056;
        Fri, 15 Aug 2025 07:36:37 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d73619fsm1437576a12.39.2025.08.15.07.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 07:36:36 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Fri, 15 Aug 2025 20:05:06 +0530
Subject: [PATCH v14 01/10] power: reset: reboot-mode: Synchronize list
 traversal
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-arm-psci-system_reset2-vendor-reboots-v14-1-37d29f59ac9a@oss.qualcomm.com>
References: <20250815-arm-psci-system_reset2-vendor-reboots-v14-0-37d29f59ac9a@oss.qualcomm.com>
In-Reply-To: <20250815-arm-psci-system_reset2-vendor-reboots-v14-0-37d29f59ac9a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755268580; l=3679;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=FC7RrRfjKXNVyHBQzF6uwLhcss5N7idT7lbjBm/hwDg=;
 b=g4yjAP/BCuktcWiGQdYaKnjeQsltqIlsf61mfAvCUxLEzZySADm+zJuHV9ye2qZLIB3RDyx0V
 W/C8BqZAcwoDo313Sw6zzqFi+iyDxtUYtypSJx0xwxb8KDxTU93zSzF
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-GUID: gTw473eaEjFIfZKfmUsKGAvySdecZxy5
X-Proofpoint-ORIG-GUID: gTw473eaEjFIfZKfmUsKGAvySdecZxy5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2OCBTYWx0ZWRfXwtNzfPfYn8EU
 DqdYi1PBKFUHkOhMh52K6gFy+LtTjZaetyJdvVqRxxIOBsJ5VpaTZ1XCo6K+xDMiMjwapqFSMPR
 9OAknhEmMYV+9qs6UodKZx+XdvGHuuMmMu0v0mpxSteFAohzFgcvzkBoccqzlIXVZSDQ28CYkPv
 vzr6hH10H9DxSwEyUoAZoYMu02v+k3WUDIp78R+n69vhs8dapqjVmr5XXZK0bszEblH3eeKTMsZ
 sc1hlOucSHK1L5w1drKPQMNAc3pE6LQAMpYMIYywdlTDhkaFuKMiT+wzz8nBIFM/6iKhk4S0tT8
 HuGGKGdG+s1+0QnADEVhhgfs69jk9q5WJCtzqJ/m9zv4SUBDeqB9rrXBTwH23wUz06cGXb/iu+D
 TFdUMPsc
X-Authority-Analysis: v=2.4 cv=YMafyQGx c=1 sm=1 tr=0 ts=689f45f6 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=iWTyA_h5fkyOTIp6uasA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110068

List traversals must be synchronized to prevent race conditions
and data corruption. The reboot-mode list is not protected by a
lock currently, which can lead to concurrent access and race.

Introduce a mutex lock to guard all operations on the reboot-mode
list and ensure thread-safe access. The change prevents unsafe
concurrent access on reboot-mode list.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/power/reset/reboot-mode.c | 24 ++++++++++++++++++++----
 include/linux/reboot-mode.h       |  4 ++++
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index fba53f638da04655e756b5f8b7d2d666d1379535..42bb99128ed3846d4bff62416dc31135ddeaeb90 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -29,9 +29,14 @@ static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
 	if (!cmd)
 		cmd = normal;
 
-	list_for_each_entry(info, &reboot->head, list)
-		if (!strcmp(info->mode, cmd))
+	mutex_lock(&reboot->rb_lock);
+	list_for_each_entry(info, &reboot->head, list) {
+		if (!strcmp(info->mode, cmd)) {
+			mutex_unlock(&reboot->rb_lock);
 			return info->magic;
+		}
+	}
+	mutex_unlock(&reboot->rb_lock);
 
 	/* try to match again, replacing characters impossible in DT */
 	if (strscpy(cmd_, cmd, sizeof(cmd_)) == -E2BIG)
@@ -41,9 +46,14 @@ static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
 	strreplace(cmd_, ',', '-');
 	strreplace(cmd_, '/', '-');
 
-	list_for_each_entry(info, &reboot->head, list)
-		if (!strcmp(info->mode, cmd_))
+	mutex_lock(&reboot->rb_lock);
+	list_for_each_entry(info, &reboot->head, list) {
+		if (!strcmp(info->mode, cmd_)) {
+			mutex_unlock(&reboot->rb_lock);
 			return info->magic;
+		}
+	}
+	mutex_unlock(&reboot->rb_lock);
 
 	return 0;
 }
@@ -77,7 +87,9 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 	int ret;
 
 	INIT_LIST_HEAD(&reboot->head);
+	mutex_init(&reboot->rb_lock);
 
+	mutex_lock(&reboot->rb_lock);
 	for_each_property_of_node(np, prop) {
 		if (strncmp(prop->name, PREFIX, len))
 			continue;
@@ -113,12 +125,14 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 	reboot->reboot_notifier.notifier_call = reboot_mode_notify;
 	register_reboot_notifier(&reboot->reboot_notifier);
 
+	mutex_unlock(&reboot->rb_lock);
 	return 0;
 
 error:
 	list_for_each_entry(info, &reboot->head, list)
 		kfree_const(info->mode);
 
+	mutex_unlock(&reboot->rb_lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(reboot_mode_register);
@@ -133,8 +147,10 @@ int reboot_mode_unregister(struct reboot_mode_driver *reboot)
 
 	unregister_reboot_notifier(&reboot->reboot_notifier);
 
+	mutex_lock(&reboot->rb_lock);
 	list_for_each_entry(info, &reboot->head, list)
 		kfree_const(info->mode);
+	mutex_unlock(&reboot->rb_lock);
 
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


