Return-Path: <linux-kernel+bounces-742747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 104B0B0F620
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6A189627FA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279E42FC005;
	Wed, 23 Jul 2025 14:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="fNJQNMa6"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3972FCE17
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282069; cv=none; b=Nb58JPmV9uY2OADe9Wpt7UClZqMLfXGvHdhVb15p4xEnfUGira1peIYtI+ee0mz0RD1TqGaJD5q790kSSjgFT2NbXW5YtYqBPz9sG9X+6qLFB5QYaFNV+UkULiWazhZtmSgCau9SjI5xp2ZQiivOsYlBQiCFZEpm/MCEIxUiGpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282069; c=relaxed/simple;
	bh=p6mnW8nHz5mmsnmxHLqpu00m8RR2v1Mvzx5SXmQ28YA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+3+NrVqHcWddi+lwhkiaWoSejuPFz2KV5a+F6IsckdFqgy3w+o8df0RyktdW16Vfek1xQGSOOvBjwM7N3RnsT7NuWMSeS/YjCTAzcARJ9DzDpjr+yln/ULZ5yO6AKt1EdFTXgNSguhSDRLU7VGHGDyAnCftyAkNGFapGufodgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=fNJQNMa6; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-70e3e0415a7so267537b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1753282063; x=1753886863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vA7LYlc82x3WwgY57zmotOihPt8s/pKmtJ2MhRkxfkk=;
        b=fNJQNMa6f1p8o9RygaADlwqx7OSnnaJFpIl/A6sRVgQasSvGeE3vggpKgKDHD85bwv
         qeEsuTGhhJFZopgjYe4ZAXcJ8xRjNE2KyT8noqLdunAzs1gAY8jVByk/v2NPbB29WIAB
         wFvy/Ty9RWKmNNwMDyWI+ytsL0YUvnJ9h7peQU9F8WE8xD+GsmYKXNtzsSqolNlAHhoN
         cT7/yWvkxRp1wV0b5aVebw3uvBs2OxxPF2gc5yy8wXQUmoG0jdvUTeJsVyrbBXvtCH5j
         RMRYi8uCufah4jhbvTMMHME+1+VwUtfaSZx6HdznbqEaAyYHq+EMYO0RiBxdepMlZ7FY
         V74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282063; x=1753886863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vA7LYlc82x3WwgY57zmotOihPt8s/pKmtJ2MhRkxfkk=;
        b=kJPQs4wgkYaGSI66uiQ7uX/KLErmMuVHpt248Nu9EkOxEPGJgES/8pUJDcrwimvZ9J
         MDQhoSSrtbhPmPXVxpikMsk/0DpJdLiGR87FGZDCGhX7E1GP4SVmb+r7tJf82mDH2pH7
         fzLoHpf1famYrcDWHiLAHaO2tzmFPdfLW/r3gqZd7zwpflIWCl9jihlmbyQxVeXBMjpF
         UDLITgaasxDFqSVvE+v1BmGZeIzRefrTDyGavZb2rdXsKefFzvbTAtG1Q02vQieePCev
         C6Mxbyz5y41qE4gMQloBG9DDbt4Ddaa2H4Zd0z2uOPaTl3g1bBuoSC9uU2OdZHjxgh69
         gNDw==
X-Forwarded-Encrypted: i=1; AJvYcCU4ZjwuK7i0L/XqXehEBMY0fI5Xv4yrPlSfHes+hg95ntk7kJUESzIHhok5jzd7vSPaUWmqVRZ78CI+lzM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz8W6NvqIfuSri3lffBsKEU8RMkfozIj8qDICB21s8fnysL8KH
	ucRyVEIkYakuIoL6SlQLP/YQ3qmAt6spn/UuCv4PM11SE95s63F6flYetscoL+Vgcfw=
X-Gm-Gg: ASbGncvv6QLLhQ5lzuK/WZDttaQDPUvypizMUi8EfIWVzUicdXPPqPYPcHV+tdhtYOL
	hs/3jv2NkPS92JAc9ENPl39KfVOZ/oLp+r7VJ5akEu7USi7Jcv2XhBII3d+gX4dqXdb/nya88Gg
	bEDKwvF2tT2oiLSq6mPU4HcP8ApECgIcUY76i+4R2VAoYeaMjq9lntlXDPgBp/LRuT0A6/s59Vx
	NvLGs7Wag7OClTBhZNDaD6sYYa9VrwZIIlarOUmGMdpryTRzjfZuRCjjNabSMK6aym2h5NioTKr
	Ga/gT7Q8vp0A4OQk8fT8l0euZTlPykmTjoeVQODp8zPTouVt5mQS2cuyu7NFFwt69Y2uhgvvs0k
	oM4pOKU7ZAUUVQWgTlokwpZotmDhan4Wwl70iAmYs3bnvh0DJezzQ/7vuOvO9kACKDfNXjY7XRu
	/9r9H29wOols2krA==
X-Google-Smtp-Source: AGHT+IHqS70M03S5he3NvWDhoQuPFBoBKoEYJVBTcn9mZuJ/zrlY+6jXwnz4jOOosBMr5/pOQwUPow==
X-Received: by 2002:a05:690c:480b:b0:719:4c68:a713 with SMTP id 00721157ae682-719b4b26117mr35918287b3.2.1753282063460;
        Wed, 23 Jul 2025 07:47:43 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719532c7e4fsm30482117b3.72.2025.07.23.07.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:47:42 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com
Subject: [PATCH v2 24/32] MAINTAINERS: add liveupdate entry
Date: Wed, 23 Jul 2025 14:46:37 +0000
Message-ID: <20250723144649.1696299-25-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a MAINTAINERS file entry for the new Live Update Orchestrator
introduced in previous patches.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3b276cfeb038..711cf25d283d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14012,6 +14012,19 @@ F:	kernel/module/livepatch.c
 F:	samples/livepatch/
 F:	tools/testing/selftests/livepatch/
 
+LIVE UPDATE
+M:	Pasha Tatashin <pasha.tatashin@soleen.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-kernel-liveupdate
+F:	Documentation/admin-guide/liveupdate.rst
+F:	Documentation/core-api/liveupdate.rst
+F:	Documentation/userspace-api/liveupdate.rst
+F:	include/linux/liveupdate.h
+F:	include/uapi/linux/liveupdate.h
+F:	kernel/liveupdate/
+F:	tools/testing/selftests/liveupdate/
+
 LLC (802.2)
 L:	netdev@vger.kernel.org
 S:	Odd fixes
-- 
2.50.0.727.gbf7dc18ff4-goog


