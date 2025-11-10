Return-Path: <linux-kernel+bounces-892503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 409FCC453A2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D133B2DD6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458A72EBBB7;
	Mon, 10 Nov 2025 07:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jI6FNHaT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yi8qFsPO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA7E2EAB81
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762760155; cv=none; b=YrSGRTeRq1McGi2hJ/6nanwrPyrEk0c5OgWtHuByq3hzDZnVMd7VgwJTJqkfAFVdrQ0xZm7eBmVat2OeLMZ0yvsiIu1i11ZXCrfzY/IY3RIOAH7Bd47Zn8smXnJTYNbxgUyUjd08SsNn+qH+7Y6/CGLs16NMiBgl1+PSZk8AFTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762760155; c=relaxed/simple;
	bh=21nICoZNv0xtRro07vJ8g1b48UZfbTR27eO1M/t7uCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kok5T4Izb5QMtzUA1utoz1OcdXgvpO5Y32Wp0WkEfsrE2/mqZUbcKoXO1WJ+SCdXx+VwgPih1A4OhCUMpSM+BbotPQ6Q+ApHNqji2buaqRmuPm4GvcUTkUcago/EX7pg20E/rd/M1QeddfT3KsT5olK0h3PHA/KCTkm3K7FDvi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jI6FNHaT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yi8qFsPO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762760152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MZKl7FZF/ch5ijr8g/yA88XxaRvqJkiXLlx75JjOq5E=;
	b=jI6FNHaT8FdLn9EEbbYfHnA7s3RgWCKHDmXuYBs4QFpvJeURCneaoSfks/64LTrqibtQJU
	oBYD891iThDQVQl2qS5VKC1x4AW6Arq/7dg08pwMXZYpzaxd/VhXuKmFEgdTZivyIekexG
	9Hx22wtTAHXo0W7sJGmxhqWjtywAYV8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-p1f9E3ufPgO0SKksE-7jDA-1; Mon, 10 Nov 2025 02:35:51 -0500
X-MC-Unique: p1f9E3ufPgO0SKksE-7jDA-1
X-Mimecast-MFC-AGG-ID: p1f9E3ufPgO0SKksE-7jDA_1762760150
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b726a3c3214so264428266b.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 23:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762760150; x=1763364950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MZKl7FZF/ch5ijr8g/yA88XxaRvqJkiXLlx75JjOq5E=;
        b=Yi8qFsPO08Tog/Vv6/NK+T2Esh7zcTr9RSo/ApOOKb6PAr4GPo5D+a2/6rHGnn1Yyl
         F0f55iN1XIIAHFn8GbkC8LpI5sWeSmGpLIPwLZ3ZbK4dpIjgFFxAUYoTFSFBrUWM//D1
         auN7TRXF7NfTHOCjhbQroCx9IhvXgRUC3tk+CwC/RDc6u1GRjzoz+iD/WptfzRl3naMA
         hya3LmisWVhWhH1lw8JAHY6zfB/pLb2OphFH/BUfm2P+CylQ6qJsRigmMGF5momSJqwG
         pNQVDc2EYgJdXR2BGlsLH32CcbpRHSwrJIhBVAijVKEzji9fc6VqflkhS755E62WUNgC
         fqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762760150; x=1763364950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZKl7FZF/ch5ijr8g/yA88XxaRvqJkiXLlx75JjOq5E=;
        b=fTf8AW2C/S4whnsqKEic9gCg60wg6E9BIElbcA/Ng2XlQJzYTnL4ym0RhVMNB2nvc0
         T7k/v38ub2WFLtkhde9fFiN+aUM9rNMx9PWFt/0vWRSY9xcewfN8Y93ymxeVrLUDdl4P
         sdMEpUGodP4ySmMXqDzLp/TT7VPBuURyRFUwPmDuy91cp2lQ2Hpw+iuwWu/MAWeKFiRN
         dv6928yn7hsmiaZR7qzZwrLrEQM4+0EeS00LR49AQYOqRTBmY06rxWv/scdJh7b+16mD
         hVqgEQ0PD55q7cv3TUZjZErStY1y6V2mV5neVPxqfpcrp9NZwmTnTkUKNaPoweag8CtZ
         UBiw==
X-Forwarded-Encrypted: i=1; AJvYcCVlCFI0OikTNSclzaWqN2I7JgK9aCUur4rezDJlFMYHqfEFxwy8Apsa1JW+jekmKs7jyjjRpaJhgQDgRqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF2ikRh8nw2A0WAzlsim37KkktR0WhcwVq8tLPhs6UrbPJASn2
	32LsvEjEn1RXekVE1uD5NODYEUw/iF94aC4d3rVw/D+Rv+zJ3tNVL9tAJ/5cWmjY2djxu6MWHAz
	+Z6k+08UoatwLHbDKQEKq4bxP7yEtAM/IMhRBzgDaNHNQuA0YmSm60OGHUBjCi6nrNw==
X-Gm-Gg: ASbGncsk+d0vrX+5uJLfey2fqF7mGC3UdToie5bCf2p+wTi9E11Biv3m/SnJ/F1OdJJ
	puVw5mFhoKAWCBun4ZqwWbfcxjNBr313pjxvgw73p7s2QnxoMzcKk9I5A/aDdUifqmZ/twv4FO1
	/5jX0DSnRg+NWGF4GI90iZrubAi94tP6Vcy/rKUYZvfaOlwnh0CiYlQCtgOKWfaYIjDjhju0/Zu
	xlWA6pg+bIP8uftMxDK4pflBgwkKEnGYZNG896DSWoT8mqXvtrFziC9Dh3++7kcAmQsz/GAJ/m7
	QhN3dx4kTzTpsmCTS99TYsWko14FgYispb9ZimM+aXT1Y3PGsJPOnrHe5MW61wpiRMxSsx25jSf
	0BjxIoMMqIgB5I2ZJOgEBVn6LnBSydKmTMxrQg99UQzjACzF/
X-Received: by 2002:a17:906:cac7:b0:b73:845:4171 with SMTP id a640c23a62f3a-b7308454190mr178621766b.64.1762760149662;
        Sun, 09 Nov 2025 23:35:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiLhLSDBHf+cnguxwEfwJFhitfhGonUvcR76zFD9RWMeGVCjQJ2GOJyu6W6FkcShrY0ZWgcg==
X-Received: by 2002:a17:906:cac7:b0:b73:845:4171 with SMTP id a640c23a62f3a-b7308454190mr178619366b.64.1762760149287;
        Sun, 09 Nov 2025 23:35:49 -0800 (PST)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:1622:5a48:afdc:799f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf9bc874sm1039395666b.54.2025.11.09.23.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 23:35:48 -0800 (PST)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Shubhi Garg <shgarg@nvidia.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-tegra@vger.kernel.org,
	linux-rtc@vger.kernel.org
Cc: Jon Hunter <jonathanh@nvidia.com>,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: drop unneeded file entry in NVIDIA VRS RTC DRIVER
Date: Mon, 10 Nov 2025 08:35:44 +0100
Message-ID: <20251110073544.443816-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 9d6d6b06933c ("rtc: nvvrs: add NVIDIA VRS RTC device driver") adds
the section NVIDIA VRS RTC DRIVER in MAINTAINERS, which refers to the
non-existing file include/linux/rtc/rtc-nvidia-vrs10.h

Note, with the changes of v6 to v7 of the patch series adding the driver,
the content of this include file was moved into the driver file, and the
include file was dropped from that patch. It was simply missed to adjust
the section in MAINTAINERS that was newly added with that patch.

Drop the file entry to this non-existing file accordingly now.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2a881629003c..b2b55947efef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18586,7 +18586,6 @@ L:	linux-tegra@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/rtc/nvidia,vrs-10.yaml
 F:	drivers/rtc/rtc-nvidia-vrs10.c
-F:	include/linux/rtc/rtc-nvidia-vrs10.h
 
 NVIDIA WMI EC BACKLIGHT DRIVER
 M:	Daniel Dadap <ddadap@nvidia.com>
-- 
2.51.1


