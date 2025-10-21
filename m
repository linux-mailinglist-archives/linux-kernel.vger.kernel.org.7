Return-Path: <linux-kernel+bounces-862763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A76BF617E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE49919A14EF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31762F3607;
	Tue, 21 Oct 2025 11:37:58 +0000 (UTC)
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00F532E6A8
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761046678; cv=none; b=Tac06UGcWaRddEASviRqybchu5Iz/Xk51qo9nKVvz6a9oz2mqKoV7l+CtUab3ylZ+VFEhUj5/YJT9cdTnxzjmfw8WxTldrc6agZa2PgdRPvkbcUIgyLA5QRV3WgnHEXjuqnMiTPfTb1ZIUTkE//Zdil/BJnwYAqcDjBv+CpEVTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761046678; c=relaxed/simple;
	bh=LwlKlFHSEbNrVRvKsond5796RbxaXrrqKSRSObBmQZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HM/hVxheAajgN6oNOaZXKaMnpbu0O7LlYju8+90RT3RQBWdc7DOtfsGs3f6TIiOQze8+7g9VKQmQCg9Hx6tbn3hIVC5RXf6ns86T3qjJJ6H2Gs8gnFZpe1CffpkXwJ1h6c+WEA8LT85RiPf6ZPYYPo5xh4SUU6i/RopGE6QLkgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-269af38418aso66787925ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 04:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761046676; x=1761651476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zb/P39EN0zTHeWlEc7WRQeworU4Q/PPx2G1j0YfRkmU=;
        b=SQi+2NxpGf26hxrazSqmG2wgHmUGeQI5683ii2ItiEUp2tN0gulxLg+60PIyXylNAA
         R3cQvnBLYCJZNDuwlN0mJ5ejf3BWTjLIJFy34ElVVfVtRu5P5+Y53ydEqjeUF9toUAPb
         MRieMpOCf+N9/fSkqoInZJLN+G4AK7jbINfB0LUO3BEga2C1MBuaTNJD7tLJz6x3txio
         Z8HGUo00ltpj2DAj2M+G/CX/fF3mjKGwP2jfB/lK6ovJXj/5hbbxakj4wTiPKVAG4Dq3
         wgUWBWe7Gsqf55sUpbWBTg1PgauD2HOgREESNwXm6E/834VoEOL8HcqODbqTdk8GQpLz
         WvQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdc9wqLzhRLsIHE1abZFsTAG40KLW/sNndQH76YX31l21SetezJ6EtPrX/t/kl6QujfkVEz+171Y3wKYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaM4ANr3tKQMxadjj6feFEWrj262yq2mm9LmzotO1wMdsmBgj2
	v95mD0T9ZWXEbQITs9fYWcC55cnkHQy/Dua2601erNLgiSSy381qWzFT
X-Gm-Gg: ASbGncva384RtcEehHz8WxmdsCySacp169A2zmHTDsiDEPrqSK8AvgbmZT6JhdMjlzn
	o/vxIcjoHvtrcNzrb/c04LgOp+sfpJdBBgv7q94LS6QGaezJF3JCzsqVYr5pmlUxi/cWlNlOoZ4
	tIV/TR0Dg1xchey7XSBF94Cje863zrp6ue5A0j2toOPyP+jatDDdnUmf/jaiQzOPWxg4wM/lJEV
	w+o61MvwMoC0HcoTCMxJh62gwLjjrNmerr3mRLB3+oLY9Aei3GDowLB1nZ9we+GSGjeA2ytez63
	ZNTJc9tX22pmPcV3ZB4dNR6qbzXJ8Mr/WFuI095V+SqJEg2qy19GB17HaagPNceE9gl9Br47+LQ
	9Tun96ENsy49bH7tlsdYauIBUGXo4iVbYAv/0vnnTY20A9+0CZBm2x7q+alwffzwJwGxk9nWPwf
	i4jPiXKUrS6PVMV56aVo4alkhtMA4gXPIbCA==
X-Google-Smtp-Source: AGHT+IF6cl/LBwyaFNUn13dpXkGP8NioeG262Y8OPcKXHmKGNZPKgVCEeAVM6LjaxPs3Wd2eic9dVQ==
X-Received: by 2002:a17:903:287:b0:24b:4a9a:703a with SMTP id d9443c01a7336-290c9cbc0d7mr203876085ad.17.1761046676061;
        Tue, 21 Oct 2025 04:37:56 -0700 (PDT)
Received: from power-ThinkBook-15-G2-ITL.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5874sm107138825ad.54.2025.10.21.04.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 04:37:55 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v5 3/3] PM: hibernate: add sysfs interface for hibernate_compression_threads
Date: Tue, 21 Oct 2025 19:37:28 +0800
Message-ID: <c68c62f97fabf32507b8794ad8c16cd22ee656ac.1761046167.git.luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1761046167.git.luoxueqin@kylinos.cn>
References: <cover.1761046167.git.luoxueqin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a sysfs attribute `/sys/power/hibernate_compression_threads` to
allow runtime configuration of the number of threads used for
compressing and decompressing hibernation images.

The new sysfs interface enables dynamic adjustment at runtime:

    # cat /sys/power/hibernate_compression_threads
    3
    # echo 4 > /sys/power/hibernate_compression_threads

This change provides greater flexibility for debugging and performance
tuning of hibernation without requiring a reboot.

Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 Documentation/ABI/testing/sysfs-power | 16 +++++++++++
 kernel/power/swap.c                   | 38 +++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
index 4d8e1ad020f0..d38da077905a 100644
--- a/Documentation/ABI/testing/sysfs-power
+++ b/Documentation/ABI/testing/sysfs-power
@@ -454,3 +454,19 @@ Description:
 		disables it.  Reads from the file return the current value.
 		The default is "1" if the build-time "SUSPEND_SKIP_SYNC" config
 		flag is unset, or "0" otherwise.
+
+What:           /sys/power/hibernate_compression_threads
+Date:           October 2025
+Contact:        <luoxueqin@kylinos.cn>
+Description:
+                Controls the number of threads used for compression
+                and decompression of hibernation images.
+
+                The value can be adjusted at runtime to balance
+                performance and CPU utilization.
+
+                The change takes effect on the next hibernation or
+                resume operation.
+
+                Minimum value: 1
+                Default value: 3
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index aa11576e92a9..d173e276b494 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -1689,8 +1689,46 @@ int swsusp_unmark(void)
 }
 #endif
 
+static ssize_t hibernate_compression_threads_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", hibernate_compression_threads);
+}
+
+static ssize_t hibernate_compression_threads_store(struct kobject *kobj,
+				struct kobj_attribute *attr,
+				const char *buf, size_t n)
+{
+	unsigned long val;
+
+	if (kstrtoul(buf, 0, &val))
+		return -EINVAL;
+
+	if (val < 1)
+		return -EINVAL;
+
+	hibernate_compression_threads = val;
+	return n;
+}
+power_attr(hibernate_compression_threads);
+
+static struct attribute *g[] = {
+	&hibernate_compression_threads_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group attr_group = {
+	.attrs = g,
+};
+
 static int __init swsusp_header_init(void)
 {
+	int error;
+
+	error = sysfs_create_group(power_kobj, &attr_group);
+	if (error)
+		return -ENOMEM;
+
 	swsusp_header = (struct swsusp_header*) __get_free_page(GFP_KERNEL);
 	if (!swsusp_header)
 		panic("Could not allocate memory for swsusp_header\n");
-- 
2.43.0


