Return-Path: <linux-kernel+bounces-742751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A66B0F635
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8593B1737
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313452F5499;
	Wed, 23 Jul 2025 14:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="GWv9AWc6"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42A22FD86A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282080; cv=none; b=dcPQx79MvaqvNl/Q71lI9d6eqbrwiGeWLtN/rWvyEEsbMDnIhBZh2BpcxlcDs9bhXvzZGZpMZr7bRc9PicyU83S1R904luQ3HXW9ACR5iEwWFZ+CmsC0Chli3clpea8F3gcOe6hCVO1jW06KDT6dCmUWJN6wTIBajGalp2E4w94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282080; c=relaxed/simple;
	bh=zC6u2biwGcXL2iC3P/2IdgSx0g0kQc0JVTiEcMEVtJ0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=olbaxfhsiRIw+l4YmRV0SizbGhOAVSjFx1MDdurloLUzypRuaWQPLG+y3SFKf2TqpYTRi/QXE8RyT5nWdAdU21GI6y0H0+q5SdbnAtU5aCgNTm6meteobGIH6Wg3vRYIL3dPWiTBfEiV8j+/7VFSzncZy9Rdy1pMfNdIr04DvPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=GWv9AWc6; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7183d264e55so67251837b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1753282074; x=1753886874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JgvqzDIiRiBX+3t66TRkd0Ymp5/wa/ERt/pQr69clFU=;
        b=GWv9AWc6wLaC4emA0ALPX+CyHF9Lnl2b/UeBHZvMpBb9i3OphFQYQchconaWIW6H8y
         bDa0amkJDboEBvga1Rg9hGIuq+aQP44YWBnRBKYo0s1o+mHLH0TUgcBi9h5ZVr9ggcwt
         Nw8bKVv9mof6LT5oXMy4axHpQ+Q1qGlKQ9dFkXAe1FceaW95IzfEYzVF+/p7i6HvHpTg
         j5ihmIBTN3+2JpZINiUIUdT5AjwlGs4YfFC01qN2YQA6ZDg2jvyl2QKS8e1xQmBX5ImN
         SvrL5GLnmXmvRX5cgw4jYE0XxolX23Lf/x7TNSWJFfQh/6mAjmNcyz233tXpW8LQPwok
         3+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282074; x=1753886874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JgvqzDIiRiBX+3t66TRkd0Ymp5/wa/ERt/pQr69clFU=;
        b=ki4VEhB1ojcvgl5qND/2nvb0ZVVEidIAeFIV5KeP7qPmMBHXtaupQDHNZYYafkxIE0
         RyzAFeWlhbr8JYSWhKmEegKwKTnYMPip2TliiBR1UH3vPmQS4BzyeeR53GX/uatB+rJT
         +q7LE4suhgC7H5SOt7giPKB0mRF7BXrFrcojIdxp4e0AGjNVAKpogjIA9Ua5PYtxM/Er
         IX8Rc2558ojj+KCfXx+k166a05rn+PkJqtpuF53etv7cDVlbBcVU97582M6jPM/PKjAs
         g5OMfF2M7bGOs3yOfPDPopbasok6BXXM3El3K0zo4KWkzyaoAHRefRKN+IscfAGImWyV
         aqAA==
X-Forwarded-Encrypted: i=1; AJvYcCUjJQVkwMUxNkkHIiE5VGmV5OluvQEQ7Geif/Eyz6FK6QLcP5JYQUFUI2G9pdrBCi8YcWLePwhx0GI0vmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvTAPPcNyE1+4Y4t/BbGWsH7O8yJwZqVR5FRdgMU4xc2mGN5oA
	rbSr8OFGbH5F2RW6KSfI5/qSp+OFtA/TQItkPXIswXKiHvEngnRP8kDiOD6MhzF1MHM=
X-Gm-Gg: ASbGncsPfyQU73+KY6ExJvAkwNJYBfqM96yL0XXVxT0u9nrDqfTvElyTE+oP/wF3ysE
	cy7qvv1psUTKwrAS9Nh0TgUa2wZlKM/er0GMX7etamJYKTVJiheWS5Qme1fGxFPEuzYhwHCj/0P
	+WBHzNk0CjPAPzdRekeWBou68iCqKmrcmGNbvozzjqMeM3K9+lp2dwgFYYfnYRPpdk+Y3gpJpf0
	eCV1KbX7rMOEmzPvSzy2VEtmLTqPZOqKtSR3FDkEKCAXY4MWXvWgH3TdfxD5r327VIUmCdecs6X
	bfRkOCVrbtxM+PpGGuml3R30Xf0jNB56VAhl3YvTe1X1KVPSxT6ymmswUXOurWz/s9zegkQ4d52
	zXbhALTyLnZTcfs8zC4sf+XOp/YcuX2BTlFfSC+whDJ/tQ+W5lawt6SONWf/EAAYS7ncwFDQwCE
	lIcIkgif7GwRmVbQ==
X-Google-Smtp-Source: AGHT+IGGfx7z148fU3GfejgZgpbPyTfIvTW82LKz4E+3FHtFbrw8wPq+9rOHj4lG5MqVILJufgSXww==
X-Received: by 2002:a05:690c:358a:b0:70c:a57c:94ba with SMTP id 00721157ae682-719b4166f53mr47129757b3.17.1753282073888;
        Wed, 23 Jul 2025 07:47:53 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719532c7e4fsm30482117b3.72.2025.07.23.07.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:47:53 -0700 (PDT)
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
Subject: [PATCH v2 29/32] docs: add documentation for memfd preservation via LUO
Date: Wed, 23 Jul 2025 14:46:42 +0000
Message-ID: <20250723144649.1696299-30-pasha.tatashin@soleen.com>
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

From: Pratyush Yadav <ptyadav@amazon.de>

Add the documentation under the "Preserving file descriptors" section of
LUO's documentation. The doc describes the properties preserved,
behaviour of the file under different LUO states, serialization format,
and current limitations.

Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 Documentation/core-api/liveupdate.rst   |   7 ++
 Documentation/mm/index.rst              |   1 +
 Documentation/mm/memfd_preservation.rst | 138 ++++++++++++++++++++++++
 MAINTAINERS                             |   1 +
 4 files changed, 147 insertions(+)
 create mode 100644 Documentation/mm/memfd_preservation.rst

diff --git a/Documentation/core-api/liveupdate.rst b/Documentation/core-api/liveupdate.rst
index 41c4b76cd3ec..232d5f623992 100644
--- a/Documentation/core-api/liveupdate.rst
+++ b/Documentation/core-api/liveupdate.rst
@@ -18,6 +18,13 @@ LUO Preserving File Descriptors
 .. kernel-doc:: kernel/liveupdate/luo_files.c
    :doc: LUO file descriptors
 
+The following types of file descriptors can be preserved
+
+.. toctree::
+   :maxdepth: 1
+
+   ../mm/memfd_preservation
+
 Public API
 ==========
 .. kernel-doc:: include/linux/liveupdate.h
diff --git a/Documentation/mm/index.rst b/Documentation/mm/index.rst
index d3ada3e45e10..97267567ef80 100644
--- a/Documentation/mm/index.rst
+++ b/Documentation/mm/index.rst
@@ -47,6 +47,7 @@ documentation, or deleted if it has served its purpose.
    hugetlbfs_reserv
    ksm
    memory-model
+   memfd_preservation
    mmu_notifier
    multigen_lru
    numa
diff --git a/Documentation/mm/memfd_preservation.rst b/Documentation/mm/memfd_preservation.rst
new file mode 100644
index 000000000000..416cd1dafc97
--- /dev/null
+++ b/Documentation/mm/memfd_preservation.rst
@@ -0,0 +1,138 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+==========================
+Memfd Preservation via LUO
+==========================
+
+Overview
+========
+
+Memory file descriptors (memfd) can be preserved over a kexec using the Live
+Update Orchestrator (LUO) file preservation. This allows userspace to transfer
+its memory contents to the next kernel after a kexec.
+
+The preservation is not intended to be transparent. Only select properties of
+the file are preserved. All others are reset to default. The preserved
+properties are described below.
+
+.. note::
+   The LUO API is not stabilized yet, so the preserved properties of a memfd are
+   also not stable and are subject to backwards incompatible changes.
+
+.. note::
+   Currently a memfd backed by Hugetlb is not supported. Memfds created
+   with ``MFD_HUGETLB`` will be rejected.
+
+Preserved Properties
+====================
+
+The following properties of the memfd are preserved across kexec:
+
+File Contents
+  All data stored in the file is preserved.
+
+File Size
+  The size of the file is preserved. Holes in the file are filled by allocating
+  pages for them during preservation.
+
+File Position
+  The current file position is preserved, allowing applications to continue
+  reading/writing from their last position.
+
+File Status Flags
+  memfds are always opened with ``O_RDWR`` and ``O_LARGEFILE``. This property is
+  maintained.
+
+Non-Preserved Properties
+========================
+
+All properties which are not preserved must be assumed to be reset to default.
+This section describes some of those properties which may be more of note.
+
+``FD_CLOEXEC`` flag
+  A memfd can be created with the ``MFD_CLOEXEC`` flag that sets the
+  ``FD_CLOEXEC`` on the file. This flag is not preserved and must be set again
+  after restore via ``fcntl()``.
+
+Seals
+  File seals are not preserved. The file is unsealed on restore and if needed,
+  must be sealed again via ``fcntl()``.
+
+Behavior with LUO states
+========================
+
+This section described the behavior of the memfd in the different LUO states.
+
+Normal Phase
+  During the normal phase, the memfd can be marked for preservation using the
+  ``LIVEUPDATE_IOCTL_FD_PRESERVE`` ioctl. The memfd acts as a regular memfd
+  during this phase with no additional restrictions.
+
+Prepared Phase
+  After LUO enters ``LIVEUPDATE_STATE_PREPARED``, the memfd is serialized and
+  prepared for the next kernel. During this phase, the below things happen:
+
+  - All the folios are pinned. If some folios reside in ``ZONE_MIGRATE``, they
+    are migrated out. This ensures none of the preserved folios land in KHO
+    scratch area.
+  - Pages in swap are swapped in. Currently, there is no way to pass pages in
+    swap over KHO, so all swapped out pages are swapped back in and pinned.
+  - The memfd goes into "frozen mapping" mode. The file can no longer grow or
+    shrink, or punch holes. This ensures the serialized mappings stay in sync.
+    The file can still be read from or written to or mmap-ed.
+
+Freeze Phase
+  Updates the current file position in the serialized data to capture any
+  changes that occurred between prepare and freeze phases. After this, the FD is
+  not allowed to be accessed.
+
+Restoration Phase
+  After being restored, the memfd is functional as normal with the properties
+  listed above restored.
+
+Cancellation
+  If the liveupdate is canceled after going into prepared phase, the memfd
+  functions like in normal phase.
+
+Serialization format
+====================
+
+The state is serialized in an FDT with the following structure::
+
+  /dts-v1/;
+
+  / {
+      compatible = "memfd-v1";
+      pos = <current_file_position>;
+      size = <file_size_in_bytes>;
+      folios = <array_of_preserved_folio_descriptors>;
+  };
+
+Each folio descriptor contains:
+
+- PFN + flags (8 bytes)
+
+  - Physical frame number (PFN) of the preserved folio (bits 63:12).
+  - Folio flags (bits 11:0):
+
+    - ``PRESERVED_FLAG_DIRTY`` (bit 0)
+    - ``PRESERVED_FLAG_UPTODATE`` (bit 1)
+
+- Folio index within the file (8 bytes).
+
+Limitations
+===========
+
+The current implementation has the following limitations:
+
+Size
+  Currently the size of the file is limited by the size of the FDT. The FDT can
+  be at of most ``MAX_PAGE_ORDER`` order. By default this is 4 MiB with 4K
+  pages. Each page in the file is tracked using 16 bytes. This limits the
+  maximum size of the file to 1 GiB.
+
+See Also
+========
+
+- :doc:`Live Update Orchestrator </admin-guide/liveupdate>`
+- :doc:`/core-api/kho/concepts`
diff --git a/MAINTAINERS b/MAINTAINERS
index 361032f23876..b4fde9f62e9b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14020,6 +14020,7 @@ S:	Maintained
 F:	Documentation/ABI/testing/sysfs-kernel-liveupdate
 F:	Documentation/admin-guide/liveupdate.rst
 F:	Documentation/core-api/liveupdate.rst
+F:	Documentation/mm/memfd_preservation.rst
 F:	Documentation/userspace-api/liveupdate.rst
 F:	include/linux/liveupdate.h
 F:	include/uapi/linux/liveupdate.h
-- 
2.50.0.727.gbf7dc18ff4-goog


