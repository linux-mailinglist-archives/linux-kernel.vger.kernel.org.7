Return-Path: <linux-kernel+bounces-835652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D8CBA7B47
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 03:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 625C417AC1B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 01:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE35283130;
	Mon, 29 Sep 2025 01:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="FbSIkthQ"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BC226A1CF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 01:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759107884; cv=none; b=DLLyuGtBjT2Rjg8/eIeYTgUtC9KsvEqnXQieAMNXnZkoS6/XBphR0TNGmQ0XsBo4ftdKB9HW51C1ptZQzBI6UpV/FELv1B9bWMF0yaEWvE+LyFgO2UV+IiUz6b0CH0yJKt/F9cEnaIEnBOvu2bqUPaw61rPmOlzMKl3mebLcB6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759107884; c=relaxed/simple;
	bh=TZZO/P46r8g00GY+tV6D7n7mil1OMeqdQT3ahHm3ces=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UKwHPNH0FKj+x+mfijtqDbTuOICJ9wZoSAvmGRct+yHSh/b3AdaVL2zyfc+hI7TeiwZUNuwsT0xm95sLFsRr7iLMXLa+OSqIW+ewccrDaMuHAR+ZDVTmqv4AKFbar3X02Ej+MVb4HmIA9jZ/uS7yt+Ix/ac7ueGphfx9VSuhf00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=FbSIkthQ; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4db7e5a653cso33688441cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 18:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759107880; x=1759712680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qo+j6vvSs0kYXvlpvUfoWrks4CXynF5fRGFMBKVd5/I=;
        b=FbSIkthQlOj+3XizBHveKhbLcXK6qQHekhjG4OJUBWy8szfN5fMow2YkXERBY/9FMP
         afyQaE6aVRSL8gO75nRyuBmIjfqjBtgDo/iDwDJnClbZTwyRp+VWarJd4YSGy7Y1MT9r
         WU16WI2csyTtKJKQwwBFDWfeT6SZ8Q87QKY+xeQAObRcYN4TuczQlOavjH+wG3enEep3
         /f5/cROo3XbQUgcn/8xKTQA0euedIRtLL4NnqAFSJIHhnCUCUMr+FxcML9h3/Ktb6++H
         Hxds0xFcPsIxymlHe4nKxaYN2jCnXHKAcY5e1brRpSowjFf2fcfIhMVO9OfLkZUB1cpO
         r1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759107880; x=1759712680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qo+j6vvSs0kYXvlpvUfoWrks4CXynF5fRGFMBKVd5/I=;
        b=IPg/vd9+DapqzU3Cyw8ae+ug8V5zpjgosVDllMEDSfbpN4gjoqZbd6/Wcur/9HpKF5
         9T0K5QaKzqicoq9x85JUZDqZ70LKyZqShw8e0jM0n36A9dw8B3ZHl1LzAtoCwpxMkG1V
         2cIQZWHGBDtWmCgGxAF4DfEMR2p4g7GypL3uwsHK7ZjCiOh2G081oGfNLGZzHzBVwS+0
         DEOSywOC5q4BZSmFd2HcigH9Y4Xol6xMdIKhlU2dB/5YxhZGmfkBmxVbpI74ZRWn7/8k
         KBlWPPqEirLfcf00whUgEjUFgfqFsgJYfsG2SgvNlNh06gJ2BZ1s8dSAzzJYcoTqoTmQ
         JfxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE6ckDqL5xe33WV84gqrddAw6l16Ux+3eDtkmbPx1CGcJm2HP2Zlhq01Gl39aeDk4zDNGX9Ll6rn13+hY=@vger.kernel.org
X-Gm-Message-State: AOJu0YygmITpeUbp3Iy5ZQB7azLH7GYiVvQIEg0fTq0PLfwGTZRqLQPN
	F82hEVlrrWbRQHa9Qq5Jl6TF27ARSXzoKRWokMXbNhlgT+y0OdG5F37f6/JSTwFr3K8=
X-Gm-Gg: ASbGnctQTjV0v6ada6+rN/+SIeKrVVwEcmGVvLNEQL05TFw2I5MuB7pSqErpxoDUWtD
	WWfFk8bEsg6+41iPv//gEgMuO/O1KrShgzz1OnC9F5PBe8wBAi0ON/ya8ZybXHAkmwfkQ3jV4vc
	7rtbpGLHaIjq/hPRwVFL5bVlmYSLPqc9+kFgqAFfzbISw7YoZ4U0MNcfKG6klMysw6M0b4eOUaM
	GIMeWIHLyHmlXYmyzOCD7Eqsbhzx2aKaHm9AqtROMnsjoUycjckjJriYI8YEUAszkLvqzMEXjKr
	f/MaaDhKeUSYDp2iv5m4hFhtotHkHoJDDb2urA9y9Ux3GXscP9lUE6SwggAdYHYnUEmgX1wdyFN
	PY/fCABA4UDcqliyYOajoRuhVVpvFpJ+1tD5mqtmwdRihGbrbeCSQfvZGflGYNLCMMg0DsPtwX8
	upYkaVzSo=
X-Google-Smtp-Source: AGHT+IFnn/Ai8Ev964hSNdZizcDfUH5OIiSZcW9Lxxs1D7Eu4fY6PuQ8Bl+TY2i03llueVLxiUozLg==
X-Received: by 2002:a05:622a:904:b0:4c3:a0ef:9060 with SMTP id d75a77b69052e-4da49253c74mr204367941cf.26.1759107880566;
        Sun, 28 Sep 2025 18:04:40 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0c0fbe63sm64561521cf.23.2025.09.28.18.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 18:04:40 -0700 (PDT)
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
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org,
	steven.sistare@oracle.com
Subject: [PATCH v4 19/30] docs: add luo documentation
Date: Mon, 29 Sep 2025 01:03:10 +0000
Message-ID: <20250929010321.3462457-20-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
In-Reply-To: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the documentation files for the Live Update Orchestrator

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 Documentation/core-api/index.rst           |  1 +
 Documentation/core-api/liveupdate.rst      | 57 ++++++++++++++++++++++
 Documentation/userspace-api/index.rst      |  1 +
 Documentation/userspace-api/liveupdate.rst | 25 ++++++++++
 4 files changed, 84 insertions(+)
 create mode 100644 Documentation/core-api/liveupdate.rst
 create mode 100644 Documentation/userspace-api/liveupdate.rst

diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index 6cbdcbfa79c3..5eb0fbbbc323 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -138,6 +138,7 @@ Documents that don't fit elsewhere or which have yet to be categorized.
    :maxdepth: 1
 
    librs
+   liveupdate
    netlink
 
 .. only:: subproject and html
diff --git a/Documentation/core-api/liveupdate.rst b/Documentation/core-api/liveupdate.rst
new file mode 100644
index 000000000000..7c1c3af6f960
--- /dev/null
+++ b/Documentation/core-api/liveupdate.rst
@@ -0,0 +1,57 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================
+Live Update Orchestrator
+========================
+:Author: Pasha Tatashin <pasha.tatashin@soleen.com>
+
+.. kernel-doc:: kernel/liveupdate/luo_core.c
+   :doc: Live Update Orchestrator (LUO)
+
+LUO Subsystems Participation
+============================
+.. kernel-doc:: kernel/liveupdate/luo_subsystems.c
+   :doc: LUO Subsystems support
+
+LUO Sessions
+============
+.. kernel-doc:: kernel/liveupdate/luo_session.c
+   :doc: LUO Sessions
+
+LUO Preserving File Descriptors
+===============================
+.. kernel-doc:: kernel/liveupdate/luo_file.c
+   :doc: LUO file descriptors
+
+Public API
+==========
+.. kernel-doc:: include/linux/liveupdate.h
+
+.. kernel-doc:: kernel/liveupdate/luo_core.c
+   :export:
+
+.. kernel-doc:: kernel/liveupdate/luo_subsystems.c
+   :export:
+
+.. kernel-doc:: kernel/liveupdate/luo_file.c
+   :export:
+
+Internal API
+============
+.. kernel-doc:: kernel/liveupdate/luo_core.c
+   :internal:
+
+.. kernel-doc:: kernel/liveupdate/luo_subsystems.c
+   :internal:
+
+.. kernel-doc:: kernel/liveupdate/luo_session.c
+   :internal:
+
+.. kernel-doc:: kernel/liveupdate/luo_file.c
+   :internal:
+
+See Also
+========
+
+- :doc:`Live Update uAPI </userspace-api/liveupdate>`
+- :doc:`/core-api/kho/concepts`
diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index 0167e59b541e..64b0099ee161 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -61,6 +61,7 @@ Everything else
    :maxdepth: 1
 
    ELF
+   liveupdate
    netlink/index
    shadow_stack
    sysfs-platform_profile
diff --git a/Documentation/userspace-api/liveupdate.rst b/Documentation/userspace-api/liveupdate.rst
new file mode 100644
index 000000000000..70b5017c0e3c
--- /dev/null
+++ b/Documentation/userspace-api/liveupdate.rst
@@ -0,0 +1,25 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================
+Live Update uAPI
+================
+:Author: Pasha Tatashin <pasha.tatashin@soleen.com>
+
+ioctl interface
+===============
+.. kernel-doc:: kernel/liveupdate/luo_ioctl.c
+   :doc: LUO ioctl Interface
+
+ioctl uAPI
+===========
+.. kernel-doc:: include/uapi/linux/liveupdate.h
+
+LUO selftests ioctl
+===================
+.. kernel-doc:: kernel/liveupdate/luo_selftests.c
+   :doc: LUO Selftests
+
+See Also
+========
+
+- :doc:`Live Update Orchestrator </core-api/liveupdate>`
-- 
2.51.0.536.g15c5d4f767-goog


