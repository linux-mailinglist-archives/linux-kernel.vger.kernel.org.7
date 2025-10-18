Return-Path: <linux-kernel+bounces-859314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA05CBED48A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DE364E319D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A52F255248;
	Sat, 18 Oct 2025 17:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="eUOvg8Je"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38B342AA6
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 17:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760807880; cv=none; b=i33y+luK2aVK4iPcP2grPinh5rnFiYsS6PihMZOyBwY4mOP76CVEbWm6Ylb2qWzhoNDONqEWem5aUP8ZoVTWWB3AxNgkRR1IZCi2R59Acvw8Gbpu9pOVj8Mnm6n/gVvxHW4WrdxjD4pQzj6YhGlxIK9cnRgF4oJ2VRFtrACGpjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760807880; c=relaxed/simple;
	bh=6TXr/J2BR5RufwC3Lr165ntj1gkC29Vj0I+C60rSQGM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=n1v8oiQIW3hdjGYjGwc0idcHK3G/8RfAwJM3iY1eEqew1ROAVJnf0YpzyykpE4pUohE0tR7SYx/I5Gv+nY+Xib/Qexm2/rnr5YHVbFXghnvEl1hvBPFKrpcnoPpCAT3RCTZvmvreSH0QeS49seJD0gFea7Odri+B0rHy6xoRPh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=eUOvg8Je; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-856701dc22aso459973685a.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 10:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760807878; x=1761412678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GZzPoVlS/aHxqNI+MR86s/hCO0+6teAIiedG4wDBRPs=;
        b=eUOvg8JevJHgDvF1qWNPpOGaNNb7wddRo7gUICuuhvza+h1W2nFoZEHes1flijwuum
         dNmKBTuRjoevfEg9acrc2JrdlMJK0WB5v7LD9cr0gkdUZ4qmmLhmhv9IyTa+r3CSBYFT
         5f9hMBmOXJ4TI9Td85n04nQ+ssAfYqEKQW/Y2kfNMWaIcaLOY1gL5uFWN0HqJj1RNoZH
         6ebwGlgAM7FyDCgJwGDqnVAJ6gBDPVzgCy00dgQyc2mYsifkvu2phFwidCvGrUEy1/ag
         vWmFj1bBa3zBwYtDdCwNEDou+HnDlqt+KflEostk4JHjvPDK2+Pulf6D3hybBCbhhuxA
         xxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760807878; x=1761412678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GZzPoVlS/aHxqNI+MR86s/hCO0+6teAIiedG4wDBRPs=;
        b=iuOsGyiolqS9boTw/ymubud2zG6hOZXlGjjf9/W4yn/dwzafSeyFyiSuXbhoBNH3mq
         Ng14Zgkh5ZQCcy19BT0wr5l6oDa/DNPazb4L65bVYta5UJJgjgnEdQi8P28IwGfFkeP4
         L4b/iYaZscQi+Ht9hiFQ0zCj9oqQ51CKhQR635t5yRuGy+iWAReueW9IeiV/YNMaD9Oz
         t98sUPw9RDOWIlv9i1rDJlD53pRf4pZDgfYNddamUeBL58LckxTnYYeuYiKut6ZPbT6V
         aVhPCdMXFDwC4R/791HEdjslxlxrbEkhqalsjN8KoLEd3mnkA0Euta2SKopEyA1UhgG/
         Il+w==
X-Forwarded-Encrypted: i=1; AJvYcCWbmsvK6QAUzCvlwOTMMn2cKiHcJQD1VaWuefjUBqSYmtStHTFrSYKLPIIOXJXlt8/rc5j7u3Z6rYXeFmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcVQltSWJpVCFN9Hv2D+Ef+k6u/rzHTPTrFvDNkTPElvh7sYg9
	QzRB8/LPS2WipOJdw4b1r3hK8HVWBna66hp0ndDJx3pIJAcryrWksuO1sIvvBwcqNgs=
X-Gm-Gg: ASbGncuHkT4d7yhal9jQdSBHOrPdJ8Lk6bn2/mGreDeqIS7DJOkNHen+Uo7fbkY9Aev
	0lcdiSX6IVf6la9mnOKKkFSBRtOg8ooL0ITroCbt9whsWalprgaPJajfZU1hLrM3vtLBRhskk3I
	iEKivGSLRfZ8wrRXS3AGN56+SQ1sgY3FaZUba4IGH/dADEr/fmoTEQhcD9QNWvMEVH9IF27mPsJ
	b/NCwjhwTWaB7bMUXCVIXNhATe5MKN57+bxw8m1NnhzgGd2Oq1QXyZql86tbr4tZ1pE65dee1i2
	A2j+b8T2J4bWTwBSI7N7zL8DS0rlRE34zKMMRa03HUmLW++W60uwAIa3lZ8kCPnHOtXnfenAMFx
	/F3J0DvpyGKSTt6RUMbHwgz6CA3kUgAhjpEvHzpHhQobQzt1a7pwNzewiSFdtJa/jvOJzOje5YG
	6mfaHiqC2vBck/HYRWZN0DvqtodzTYDpD/GxHarwf2n/3VdUisdIY5+lfldrNRNtUpb3uc0q2pS
	XpBDwKx5/IbLOQYGiwYcA==
X-Google-Smtp-Source: AGHT+IGv1aqeoBs230VoYjhUaedrhhH0BEcn6yibSCLCY4GSXU2MuZWJpHXeteVR05/zPVhCmOmGhw==
X-Received: by 2002:ac8:57c5:0:b0:4e8:a4de:4703 with SMTP id d75a77b69052e-4e8a4de4883mr75059621cf.57.1760807877849;
        Sat, 18 Oct 2025 10:17:57 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d02d8e909sm18478116d6.62.2025.10.18.10.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 10:17:57 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	brauner@kernel.org,
	corbet@lwn.net,
	graf@amazon.com,
	jgg@ziepe.ca,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	masahiroy@kernel.org,
	ojeda@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	rppt@kernel.org,
	tj@kernel.org,
	jasonmiu@google.com,
	dmatlack@google.com,
	skhawaja@google.com
Subject: [PATCH v6 00/10] liveupdate: Rework KHO for in-kernel users & Fix memory corruption
Date: Sat, 18 Oct 2025 13:17:46 -0400
Message-ID: <20251018171756.1724191-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses comments and combines into one the two
series [1] and [2], and adds review-bys.

This series refactors the KHO framework to better support in-kernel
users like the upcoming LUO. The current design, which relies on a
notifier chain and debugfs for control, is too restrictive for direct
programmatic use.

The core of this rework is the removal of the notifier chain in favor of
a direct registration API. This decouples clients from the shutdown-time
finalization sequence, allowing them to manage their preserved state
more flexibly and at any time.

Also, this series fixes a memory corruption bug in KHO that occurs when
KFENCE is enabled.

The root cause is that KHO metadata, allocated via kzalloc(), can be
randomly serviced by kfence_alloc(). When a kernel boots via KHO, the
early memblock allocator is restricted to a "scratch area". This forces
the KFENCE pool to be allocated within this scratch area, creating a
conflict. If KHO metadata is subsequently placed in this pool, it gets
corrupted during the next kexec operation.

[1] https://lore.kernel.org/all/20251007033100.836886-1-pasha.tatashin@soleen.com
[2] https://lore.kernel.org/all/20251015053121.3978358-1-pasha.tatashin@soleen.com

Mike Rapoport (Microsoft) (1):
  kho: drop notifiers

Pasha Tatashin (9):
  kho: allow to drive kho from within kernel
  kho: make debugfs interface optional
  kho: add interfaces to unpreserve folios and page ranes
  kho: don't unpreserve memory during abort
  liveupdate: kho: move to kernel/liveupdate
  kho: move kho debugfs directory to liveupdate
  liveupdate: kho: warn and fail on metadata or preserved memory in
    scratch area
  liveupdate: kho: Increase metadata bitmap size to PAGE_SIZE
  liveupdate: kho: allocate metadata directly from the buddy allocator

 Documentation/core-api/kho/concepts.rst     |   2 +-
 MAINTAINERS                                 |   3 +-
 include/linux/kexec_handover.h              |  53 +-
 init/Kconfig                                |   2 +
 kernel/Kconfig.kexec                        |  15 -
 kernel/Makefile                             |   2 +-
 kernel/liveupdate/Kconfig                   |  38 ++
 kernel/liveupdate/Makefile                  |   5 +
 kernel/{ => liveupdate}/kexec_handover.c    | 588 +++++++++-----------
 kernel/liveupdate/kexec_handover_debug.c    |  25 +
 kernel/liveupdate/kexec_handover_debugfs.c  | 216 +++++++
 kernel/liveupdate/kexec_handover_internal.h |  56 ++
 lib/test_kho.c                              |  30 +-
 mm/memblock.c                               |  62 +--
 tools/testing/selftests/kho/init.c          |   2 +-
 tools/testing/selftests/kho/vmtest.sh       |   1 +
 16 files changed, 645 insertions(+), 455 deletions(-)
 create mode 100644 kernel/liveupdate/Kconfig
 create mode 100644 kernel/liveupdate/Makefile
 rename kernel/{ => liveupdate}/kexec_handover.c (78%)
 create mode 100644 kernel/liveupdate/kexec_handover_debug.c
 create mode 100644 kernel/liveupdate/kexec_handover_debugfs.c
 create mode 100644 kernel/liveupdate/kexec_handover_internal.h


base-commit: f406055cb18c6e299c4a783fc1effeb16be41803
-- 
2.51.0.915.g61a8936c21-goog


