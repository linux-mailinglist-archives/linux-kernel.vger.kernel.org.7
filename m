Return-Path: <linux-kernel+bounces-709347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A44DAEDC66
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 14:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5259E163541
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 12:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7571128A1CF;
	Mon, 30 Jun 2025 12:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="yLP+Dzcp"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E863A289E03
	for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 12:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751285535; cv=none; b=geLjepfSahQIvNnLxzi0hrrWuHmL8DaYFVezMYy5r30OY6mvU+6miMoZ91YYa6a+k3LOAxvVmMyPnfAxkUaXRrAY9TfGYZu32QkMwL5WQsiXJHQjf7qeP/dpcUrIYxF2llOYAdisAQagsBjASea2XdP8w+uuIZnUzjA5RKFXaNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751285535; c=relaxed/simple;
	bh=Ohg7lHWaNmfosvJfdJwtJFPngEtlvxXVxUzrVn4Qc2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HwmtqrEyhiHsaJ8xppUCwovrs7MIBwqy/sEvTCKBNtxj35+sdrs2dlCJEYM4iNNfH8DfsvpUDzGEWM1FQ6eL4eEVbupRhlhfgw4jixUBKXBri0wQrAcWIEm/QTsQ6u5MA8QocQ6RN1OjiCGRRumDKacw96NcR9VZj+ecavD8/6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=yLP+Dzcp; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a57c8e247cso1598628f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 05:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1751285532; x=1751890332; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hHXWi0yX60qUZ47U63Zg5gRe8tPHzoc8Gl7zu8pbins=;
        b=yLP+DzcpvKuGjqjXE1vVFvpShQcsafEScKA279oTg7cfYBU/VfzYOzWqiGrIdUMb8G
         DzXePEHrYD97VqJEYDDvLxFt9klHBkgshVqZAaVrH15QF1PtSznCvNFq+SaX5e4WTlv9
         X++aGUfNsroES6kb7VAggUUuH5vlq/rim6GnyebYIUEBdZbfxdFFpc7vB0MZuiOf8Mjj
         T4Wj6/LRFOaJnPF1ex9pDP+B/igymHw/BMk5I+8JuyA3mV/YwyZdwjfy2LuAJBCPUwzU
         nvZ9hzf66xMVrdzIziu9KIiXcXMgOowJNjr4SR6XKuCLv2+7GBaGttQ7+XaOsPXWyCRi
         odcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751285532; x=1751890332;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHXWi0yX60qUZ47U63Zg5gRe8tPHzoc8Gl7zu8pbins=;
        b=jLMRPcfI1rh7QMrrHLhph5S0sDTsPfnurw6TrLFiJTJ7kOhnoBMMfQZLOdC1QuUu5P
         /8UNGjidehIwjQw6G3gZgXub/ToDo2Spbi3r9q1reaMscyMHZUzwGjdJIbdbWWD75loY
         I4tVb/hfPSD2FpQjTbRoSE+up1nC5u2ByowQ6XqeArlm88Zjn9+GX76+BehADg/9CDcO
         DhNbm5ucXmki71cMKuqEf5b9xA9Ur9H8aid13ZexowtpCLmgmfzi331rIBd7OEPUYux4
         YkvP0yeaZu75fN1Y1Xgz9cQDVQHWCif0/LHweWZgfXNKYb8jwg2l5haEdeG4E9PvOuXF
         iqpg==
X-Forwarded-Encrypted: i=1; AJvYcCUgSN61kZKH0foSTLxwVVgt6sWYmYvTkDQ/aDty4EV1BChx13AECMLksfCevGUlupVEUIH5PJ4jl1gjkgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHZ0vZ27N8XZONNiN45hnUVYcBwXpJLkkjGUG+EKr20b7XvrJM
	BFv9/vHwdkYFi5gxv4GUDaXPZa70HfmmEhqMj9itW2agT0dgqk3XcJqW1lRtWHi4YplpzPWbya3
	oOGq2RL8=
X-Gm-Gg: ASbGncthP+6XTUkYGx6evkOJmnj4/WaY0wBf3Q4jKp8kjIRr2SLELYwPRWNlHHyIDpF
	oqxAb7DSY4vKtXUzRbgPzlUukN+aHijWlmkl9SG7P1XfK7P+sPFD4Hl4fcL/+4tRzNi4PYEAgXH
	ng/J/kqM/mcEPT8yHpB5SYyRPFDTIFaUBlRBUGJRgeQjWJNRWptrRlX6s3JZhawsGeAbwRWp+hq
	yOzqJLGozrn6Qr1xJIqtvxHGL5sBOdtOhMZyLG4p12Xv+RB2tTPdXC6HmUAWC8SDdcssl+YEt/t
	u6ITVrTZOIEMs2MvNnpoEewaLemgle3dDOjpg6z0/9nawNGmS/6itFrk
X-Google-Smtp-Source: AGHT+IG7MR2n2/ZV47wed8EHudQp/eHNqsEPoyeopp5kfyyt51ODYXw9zBR32o0zpPwfzzedV7Kqkw==
X-Received: by 2002:adf:9d8d:0:b0:3a4:d8f2:d9d with SMTP id ffacd0b85a97d-3a8fe4bd07amr10821479f8f.38.1751285532118;
        Mon, 30 Jun 2025 05:12:12 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:19e3:6e9c:f7cd:ff6a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c800eaasm10470472f8f.37.2025.06.30.05.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 05:12:10 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 30 Jun 2025 14:12:03 +0200
Subject: [PATCH v2 2/4] firmware: qcom: scm: take struct device as argument
 in SHM bridge enable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-qcom-scm-race-v2-2-fa3851c98611@linaro.org>
References: <20250630-qcom-scm-race-v2-0-fa3851c98611@linaro.org>
In-Reply-To: <20250630-qcom-scm-race-v2-0-fa3851c98611@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Johan Hovold <johan@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4245;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=XXO55uSWhNpf83sskv4v7e1dRT/tHH7zQM4YO9aBRyM=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBoYn8Yas7h5Y154bniUvL2mA/ylmUcLasDDzDpQ
 oFqWilJ7vKJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaGJ/GAAKCRARpy6gFHHX
 cpdtEADcyCkASgTOpv3DbOP6wBQOIuKsDpqi8bWp8NoxBUgl+iRWK+OTsJ165//wOqR26YjSlVb
 Dhx91kE6+Mx5Jw+lQ7hmBIwnRjlnY6W5thI2RJgxQ5/0dn8woygQ95uCpbFK8F2UbpMnfdbRI+i
 4+mELRPZoJfPalL07H+Wq15OVRzlsZzZpO/niCaPLE9plZAacj7hGyRRD2qoravzZWFefZDgl/K
 XrbQqqXeqJCNQXvM6HqGnpEYZ9J5RwRThcSpvbTTKblTwfA/JWt1u0YT5fgC74HQ96QZwjGLWIz
 3Y6RWkxhAZJiZXDFQn/2316exOhDwcbCjDHnp9tAtPn1o0ooZP1zghdyxXSygYab57QqeKraTnv
 B814oS3+eW977IVJU7/dTm70swU/qVXzDyqgfibCGs7Y+oidoA9AXhz++HOQQLAs04qxEEY27ts
 JZvIXqq677pdOfZqFvvn+qXgCz1wT/04f5EOzWsGQbsfmhPcuppYf1TTC/XGrYkaZuczt9eDJV0
 lnRdj9SuEzh8OLBAW7gn54Xn1eH+WrBQk1sWT00xbnQdxz75rVQ79WE/4ZDzlBWTvpHoOnG6A/h
 Whj+l/U94+1Gak5hEf+oTgTmH4bhtepAbC9l616n8kChuNDYSRyT9w9FrDT+B+qyr12Dtm06eZz
 WlbAt0RxXJiX0jQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

qcom_scm_shm_bridge_enable() is used early in the SCM initialization
routine. It makes an SCM call and so expects the internal __scm pointer
in the SCM driver to be assigned. For this reason the tzmem memory pool
is allocated *after* this pointer is assigned. However, this can lead to
a crash if another consumer of the SCM API makes a call using the memory
pool between the assignment of the __scm pointer and the initialization
of the tzmem memory pool.

As qcom_scm_shm_bridge_enable() is a special case, not meant to be
called by ordinary users, pull it into the local SCM header. Make it
take struct device as argument. This is the device that will be used to
make the SCM call as opposed to the global __scm pointer. This will
allow us to move the tzmem initialization *before* the __scm assignment
in the core SCM driver.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/firmware/qcom/qcom_scm.c       | 12 +++++++++---
 drivers/firmware/qcom/qcom_scm.h       |  1 +
 drivers/firmware/qcom/qcom_tzmem.c     |  3 ++-
 include/linux/firmware/qcom/qcom_scm.h |  1 -
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index d830511a0082a6a52e544a4b247b2863d8b06dbd..09b698b9021644660468d59bef496cd7859aec7f 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1603,7 +1603,13 @@ bool qcom_scm_lmh_dcvsh_available(void)
 }
 EXPORT_SYMBOL_GPL(qcom_scm_lmh_dcvsh_available);
 
-int qcom_scm_shm_bridge_enable(void)
+/*
+ * This is only supposed to be called once by the TZMem module. It takes the
+ * SCM struct device as argument and uses it to pass the call as at the time
+ * the SHM Bridge is enabled, the SCM is not yet fully set up and doesn't
+ * accept global user calls. Don't try to use the __scm pointer here.
+ */
+int qcom_scm_shm_bridge_enable(struct device *scm_dev)
 {
 	int ret;
 
@@ -1615,11 +1621,11 @@ int qcom_scm_shm_bridge_enable(void)
 
 	struct qcom_scm_res res;
 
-	if (!__qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_MP,
+	if (!__qcom_scm_is_call_available(scm_dev, QCOM_SCM_SVC_MP,
 					  QCOM_SCM_MP_SHM_BRIDGE_ENABLE))
 		return -EOPNOTSUPP;
 
-	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	ret = qcom_scm_call(scm_dev, &desc, &res);
 
 	if (ret)
 		return ret;
diff --git a/drivers/firmware/qcom/qcom_scm.h b/drivers/firmware/qcom/qcom_scm.h
index 3133d826f5fae8d135a8f03758173903a87e718b..0e8dd838099e1176b6d6bf76a204c875698eb1f7 100644
--- a/drivers/firmware/qcom/qcom_scm.h
+++ b/drivers/firmware/qcom/qcom_scm.h
@@ -83,6 +83,7 @@ int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
 		    struct qcom_scm_res *res);
 
 struct qcom_tzmem_pool *qcom_scm_get_tzmem_pool(void);
+int qcom_scm_shm_bridge_enable(struct device *scm_dev);
 
 #define QCOM_SCM_SVC_BOOT		0x01
 #define QCOM_SCM_BOOT_SET_ADDR		0x01
diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qcom/qcom_tzmem.c
index 4fe333fd2f075a4e92ac6462d854848255665e18..ea0a35355657064b1c08a6ebed7cfb483a60dd3f 100644
--- a/drivers/firmware/qcom/qcom_tzmem.c
+++ b/drivers/firmware/qcom/qcom_tzmem.c
@@ -20,6 +20,7 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
+#include "qcom_scm.h"
 #include "qcom_tzmem.h"
 
 struct qcom_tzmem_area {
@@ -94,7 +95,7 @@ static int qcom_tzmem_init(void)
 			goto notsupp;
 	}
 
-	ret = qcom_scm_shm_bridge_enable();
+	ret = qcom_scm_shm_bridge_enable(qcom_tzmem_dev);
 	if (ret == -EOPNOTSUPP)
 		goto notsupp;
 
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index 82b1b8c50ca3e5f97665e6975e8d7e8e4299e65d..0f667bf1d4d9d8c3e63d69159e3cdec2fb40396b 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -148,7 +148,6 @@ bool qcom_scm_lmh_dcvsh_available(void);
 
 int qcom_scm_gpu_init_regs(u32 gpu_req);
 
-int qcom_scm_shm_bridge_enable(void);
 int qcom_scm_shm_bridge_create(u64 pfn_and_ns_perm_flags,
 			       u64 ipfn_and_s_perm_flags, u64 size_and_flags,
 			       u64 ns_vmids, u64 *handle);

-- 
2.48.1


