Return-Path: <linux-kernel+bounces-741423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E99DEB0E3F1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C3E7567FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B2B283FFD;
	Tue, 22 Jul 2025 19:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JocEb66P"
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B211288D2;
	Tue, 22 Jul 2025 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753211549; cv=none; b=JT0LJ5Ql80wiHZrxmz6WCf5QCEDEd3DCf3QUU7g3VpJTpRfj2UZ28M7AEIxja9+2VbRdmRF3L6zmB6C3uQfojLTb1A5f9pWV748A8bsAS6Pz9Xjwhx64acQcOiKc0cj4cGDRMkO7CkUSQVRfo7M1XaKlj2p160TJyTrU+MWOUXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753211549; c=relaxed/simple;
	bh=ABAS12ezzYmrtN7v93FKetnFJKa2m94SENd5WjcHKEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eXnUX6jmgaA6lZ8tnraUmyU2TocJd3HR2tmO4oR5Gth8I74EdtCHZd63MwBsTOiGZreo39dfr1EFC/Nm/kb7ihttskh4A9hdiBu4Rl5TxRD8APvuKg6ZefW8qs0l6M//TvUotdMxhF9AESCrMex778/hTEgfvTR2jGFwtQeFZSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JocEb66P; arc=none smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-4ab7082b3f7so75264451cf.3;
        Tue, 22 Jul 2025 12:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753211546; x=1753816346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hAEyQoj8nYVOSEcOTU9c9zY4e/flGPpP2KD6ZZoywm0=;
        b=JocEb66PQeCwnwQ27cRy75HiDRZcVRbW96FM3+LdjJVBWWZrYc9pZKVS2niYOFc+bt
         BYJ0KHwhHdxg1wmzm2r6hP9TwEtYEJG1+vnQp5PpcGBu87FT7Y+2JDvmHxrW1TOdsdqq
         vSJdhFcc6lWzqJTb6yBDih6NPqutn5LwvaheXeo2dtOc95La0bs1q+hlDG8IHsJFFIbR
         4u536V76gx1TIjVC+h5eDVq7XD0IT7UqEStYuzlmWTtY8N0OmTqA1CV5u74rzX+bLWxo
         PVGFxO3xTiwOqRnrNCVyAPxtVBaHwMTKL4QgeBU7XfnxDb23t/iHwbdeOOsi6e43YSrf
         sMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753211546; x=1753816346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hAEyQoj8nYVOSEcOTU9c9zY4e/flGPpP2KD6ZZoywm0=;
        b=IaF3TJhrfqvOY5o3cganTQRA2sz2c1e3N1ofXB5JvpGjJwcGmJrOdR/BHq15eBQDL/
         MaWHAGQD0E/WzPBLNd4xjaF6+qvKkR09Zywsc8Fnn50AtrvRpsZ6amkA7zx5OLOQk9QE
         B64H/zQNr3UdtMZpO2Gjm0LJNdWr52yloLN/v5s0bAalRYk8ZdGEhwFAw/AVXh5rKGyo
         WdCuTfByfy6fyaP1rSPLlLkqQsy8OVhRDznTXoIEDD8+c97THpkqSqqYiojEh0wib/m+
         dy9Vn/guy1EAsNeCDn1WNc1Jv3VKl0K63gZVi22ZP66S77nVb3IeLn3OXQXyyN426yr8
         sTqQ==
X-Forwarded-Encrypted: i=1; AJvYcCX603ayjA3GvyWRSFryNqFnakwZDOc4DX4AanToiPqiy8NZY34hvlHRNvJe+0nMEveR+OVbpBE7UrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJW68n7KIZXIEmkE/aGO3f/xnjv2D7sqZfKyUoCAvui4ixx0Sk
	LSEOS9FWXZ6gGoGOFrT2ihXZO7oACNGFlqIo5pigkrt+s8ugemiAxzy6EU6M4+CoySY=
X-Gm-Gg: ASbGnctrMXsH0QC9SfsGLFRL3+HrAPjB3PlTsVigytszR+fZaPfhnBpTZkDUOoel4yi
	jHJ7xJi11XdWfxS84gKXli/oP0EEfiIZSQ12p52V/qbBpWrjEyXWr4fdtCjqXjpdaRLm0LmQJz2
	noanR3D2pz7wl+0S/oRH8BBsmEZ1YXZ4d6BlpbFQv72seCotEsJIxDtT88VI3Bf1spUGQCmd7Ax
	NEJbPMW8KSYvtYVW3DuqfDigaCd3Jr9V9IjRDEK3M1lySmZlnALNtHJrOeIODkDcNZV3J00JxHC
	Xgj/44giY6nWOx33hYp1kIOYXIWYW5WRZleM9qdt96Pr8nsgIclW9g07zn0D2SuJgLP1PKehx56
	N0sGYUs1r+c9VbsJtQuYAxAMvAYCXSI9ED4jo4w==
X-Google-Smtp-Source: AGHT+IG9lRL9Ig2rhAmNfXpOd3VJWSypzdminGKOjDZMmMZWVbB2f160g1YnJ/0nnczKwigGD7w0SQ==
X-Received: by 2002:a05:622a:299b:b0:4aa:d487:594b with SMTP id d75a77b69052e-4ae6df3479fmr2719371cf.35.1753211545749;
        Tue, 22 Jul 2025 12:12:25 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:a619:8500::2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b47a31sm58197651cf.65.2025.07.22.12.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 12:12:25 -0700 (PDT)
From: Bojanala Hithashri <bojanalahithashri@gmail.com>
To: 
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Bojanala Hithashri <bojanalahithashri@gmail.com>
Subject: [PATCH] Minor documentation fixes
Date: Tue, 22 Jul 2025 15:11:35 -0400
Message-ID: <20250722191139.7195-1-bojanalahithashri@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Bojanala Hithashri <bojanalahithashri@gmail.com>
---
 Documentation/block/data-integrity.rst                | 2 +-
 Documentation/bpf/standardization/instruction-set.rst | 2 +-
 Documentation/cdrom/cdrom-standard.rst                | 2 +-
 Documentation/trace/boottime-trace.rst                | 2 +-
 Documentation/trace/events.rst                        | 2 +-
 Documentation/trace/fprobe.rst                        | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/block/data-integrity.rst b/Documentation/block/data-integrity.rst
index 99905e880a0e..b7b10c8abbcc 100644
--- a/Documentation/block/data-integrity.rst
+++ b/Documentation/block/data-integrity.rst
@@ -154,7 +154,7 @@ bio_free() will automatically free the bip.
 ----------------
 
 Block devices can set up the integrity information in the integrity
-sub-struture of the queue_limits structure.
+sub-structure of the queue_limits structure.
 
 Layered block devices will need to pick a profile that's appropriate
 for all subdevices.  queue_limits_stack_integrity() can help with that.  DM
diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index fbe975585236..746eb3c421eb 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -350,7 +350,7 @@ Underflow and overflow are allowed during arithmetic operations, meaning
 the 64-bit or 32-bit value will wrap. If BPF program execution would
 result in division by zero, the destination register is instead set to zero.
 Otherwise, for ``ALU64``, if execution would result in ``LLONG_MIN``
-dividing -1, the desination register is instead set to ``LLONG_MIN``. For
+dividing -1, the destination register is instead set to ``LLONG_MIN``. For
 ``ALU``, if execution would result in ``INT_MIN`` dividing -1, the
 desination register is instead set to ``INT_MIN``.
 
diff --git a/Documentation/cdrom/cdrom-standard.rst b/Documentation/cdrom/cdrom-standard.rst
index 6c1303cff159..22dc6db04a14 100644
--- a/Documentation/cdrom/cdrom-standard.rst
+++ b/Documentation/cdrom/cdrom-standard.rst
@@ -89,7 +89,7 @@ CD-ROM devices behave **exactly** the same (insofar as the underlying
 hardware will allow).
 
 The goal of the Uniform CD-ROM Driver is **not** to alienate driver developers
-whohave not yet taken steps to support this effort. The goal of Uniform CD-ROM
+who have not yet taken steps to support this effort. The goal of Uniform CD-ROM
 Driver is simply to give people writing application programs for CD-ROM drives
 **one** Linux CD-ROM interface with consistent behavior for all
 CD-ROM devices. In addition, this also provides a consistent interface
diff --git a/Documentation/trace/boottime-trace.rst b/Documentation/trace/boottime-trace.rst
index d594597201fd..62646130e1a2 100644
--- a/Documentation/trace/boottime-trace.rst
+++ b/Documentation/trace/boottime-trace.rst
@@ -198,7 +198,7 @@ Most of the subsystems and architecture dependent drivers will be initialized
 after that (arch_initcall or subsys_initcall). Thus, you can trace those with
 boot-time tracing.
 If you want to trace events before core_initcall, you can use the options
-starting with ``kernel``. Some of them will be enabled eariler than the initcall
+starting with ``kernel``. Some of them will be enabled earlier than the initcall
 processing (for example,. ``kernel.ftrace=function`` and ``kernel.trace_event``
 will start before the initcall.)
 
diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index 2d88a2acacc0..c35f640e1cdc 100644
--- a/Documentation/trace/events.rst
+++ b/Documentation/trace/events.rst
@@ -629,7 +629,7 @@ following:
   - tracing synthetic events from in-kernel code
   - the low-level "dynevent_cmd" API
 
-7.1 Dyamically creating synthetic event definitions
+7.1 Dynamically creating synthetic event definitions
 ---------------------------------------------------
 
 There are a couple ways to create a new synthetic event from a kernel
diff --git a/Documentation/trace/fprobe.rst b/Documentation/trace/fprobe.rst
index 71cd40472d36..d632073408d6 100644
--- a/Documentation/trace/fprobe.rst
+++ b/Documentation/trace/fprobe.rst
@@ -118,7 +118,7 @@ will be cancelled.
 @fregs
         This is the `ftrace_regs` data structure at the entry and exit. This
         includes the function parameters, or the return values. So user can
-        access thos values via appropriate `ftrace_regs_*` APIs.
+        access those values via appropriate `ftrace_regs_*` APIs.
 
 @entry_data
         This is a local storage to share the data between entry and exit handlers.
-- 
2.47.0


