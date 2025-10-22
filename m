Return-Path: <linux-kernel+bounces-863929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 333DCBF9898
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 02:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 07A344E20D2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 00:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632DF1DB375;
	Wed, 22 Oct 2025 00:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="lSLaLCmT"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050D31607A4
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761094643; cv=none; b=Aw5aM3rfUnnB665C89qOPJWyXNh6xiLrn/Gm1KeMJaiE58FD9YpZmyDQlt3EWikRIDzf7LtUY/2TZr/p6CyjTZLOQP8V9jNf1tCtl2egg67wx0DXo/LoaKfYFQAxPV/DGkpAkWspzN0dlCqd3TU3Fd3eH3fIkz1HxY7KsHlBLXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761094643; c=relaxed/simple;
	bh=9krFfBFzNRyhUMmfeWLlyo3WxmWtdBaTzDL2to5lDlA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VLfHYJCp1WZ64+rhCg96jKC/zcT62KJTqg0OpkG4V2i5gUfGSG98fSkSCxh5oG/EAYK8IrjpYZchpXZY5n/lxOAHD8Ig4AznbODAzNsmawQz0EwQhY62unRkKq33edm/545uLMUcDbHUn+982YSzqMHRRCTNVtEWzIdS/H7KiTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=lSLaLCmT; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4e89183fe47so5305931cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761094641; x=1761699441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=V6rRIjCz5N1D5Ed0cxws3QbJ+B4MJ09ZUi0KecBqWPM=;
        b=lSLaLCmTKjXZDFzC5cprVwF2QrNInMEgRA+kVGEsHdG1PMNAB069TCyZYe9zgzSXie
         K1L+NWHaNoBITTZyoF/V4qD6qqQSx/oUP+kIbwlqhFF2PqMj68DzG7ZzOtFG9WNqsNCE
         Q0v/GtRnfZ1WUGpcXqEk1bYB7xFpvvSTe8/SoH269mAjliugAVzNQchzLI5zOftbAJLu
         bAYUiY/4rrqVeLehcoZ6+A/taVzKlNrs5J5laqDaddMkhqVZdaceZU0/MoxvZy9a6L8A
         BH1SYqcUQHTe+t9m3RkaZgiVmuM54KsO30zFTHYPF3b89n8x2hFoWOFO4FhUBWFJmUg0
         fSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761094641; x=1761699441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V6rRIjCz5N1D5Ed0cxws3QbJ+B4MJ09ZUi0KecBqWPM=;
        b=XmHiB9ZrCFzofWO15+Gqy+t2RHKj4VN7dKrGRXAiwKXVwCnP5rykJulyBDfYZLecVX
         wv2UHHnQe7tRhHWhXStWTMD7RDzpnrBkYZJJC0deFbFrPDLTqynQqmkLboW0loUAKkT0
         UN1Nyxdcw7vWBxISwyaNQ7A/p0vCm7nIfvWUgBq+2EWHnSCGbL/SLlFe7cBYIUzWyXK5
         LQ7bGdaFmTLf0WYQZz5xR16Ay8Lc5IunnKXDqRsyQqYxgULKJ+mLnwW9jok8S+Jb4fGT
         rGbAKqJdur7Xn8d46LQzY9cZJEzBEPgmRqUQd78kf0Tv+YehMGPMzdCgkoyJwUIxZ7Np
         okJg==
X-Forwarded-Encrypted: i=1; AJvYcCVpf4mGBubVC65NpmisTjIf14lhPF+Spe8wiFfmoMv2mNpo+86jPZUQomtnJdzYJnc+vxWWbuBiVKt8Rp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqV3Gj6dp16BeOjTsIFM8Ym4/vLBWnctfdnMR/SfbSA0MKcfwz
	s0bqVGlKKJnhFJbzKAdPSd/pzKmx6ABQhSTlw8EUmCN/utDx+SgUyF+aKxdPum2zCE8=
X-Gm-Gg: ASbGnct7P1pPapSIqn3blWT7Wg3pUPBwj8ncqprGO5BW4xTYk8qz6fuLt25YLRurU9Y
	mmDUix6PGi3i2aERVRhp7eaMBUFI0bPsINX0AIlLalwEA5zULZNY3mepGegaht1oXMEL1rQz8Yi
	O8yiAAEVMOpjmkawPCq2u6pM3aLA/6LiqZ4t6OtalZOr/RMDJZAUmyhT/tRCCO48Fjw6dFCGPTz
	V00mYVjj/MjeCobB2suepUEjy/eqsGfuknNwbl3UwZRW/YFtognqRnulZPgYOYQXCcOOenxPc8P
	FqkigaJcJs88QVbST8ob7I5Fu55ibHOPQFriP8kIg5uNAV2Jfj78BElNLuLH7F6e3JkHwFL/xuV
	Xpj79DT0UezVfvo34/R4qNMruzeBCFPWRV+mwhEcofv2Cxx+KeKVuLMKn70t90rShzQfIFJb/tm
	oESJh10lueJYCVzvZAssrnzbJ0MoMLhFZgTjbMmgwnoZMhPDinc3kCQtrxq5J9uMxtgrJOKtiTR
	IgNGkYjBS8F38WvtCZXGk85gBp0JajX
X-Google-Smtp-Source: AGHT+IEIQnd/1fvDkk54xuNCdb61dv8JtlPct/U8dUFU7qNizs881GaUOM4iAn8ujhSbADE1PGNtYg==
X-Received: by 2002:ac8:58ce:0:b0:4e8:96ed:2e63 with SMTP id d75a77b69052e-4e89d2bb2f9mr209505651cf.34.1761094640840;
        Tue, 21 Oct 2025 17:57:20 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8aaf3432dsm84169501cf.2.2025.10.21.17.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 17:57:20 -0700 (PDT)
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
	tj@kernel.org
Subject: [PATCHv7 0/7] liveupdate: Rework KHO for in-kernel users
Date: Tue, 21 Oct 2025 20:57:12 -0400
Message-ID: <20251022005719.3670224-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches are taken from the LUOv4 series [1] and address recent
comments from Pratyush.

They apply onto mm/mm-nonmm-unstable.

This series refactors the KHO framework to better support in-kernel
users like the upcoming LUO. The current design, which relies on a
notifier chain and debugfs for control, is too restrictive for direct
programmatic use.

The core of this rework is the removal of the notifier chain in favor of
a direct registration API. This decouples clients from the shutdown-time
finalization sequence, allowing them to manage their preserved state
more flexibly and at any time.

In support of this new model, this series also:
 - Exports kho_finalize() and kho_abort() for programmatic control.
 - Makes the debugfs interface optional.
 - Introduces APIs to unpreserve memory and fixes a bug in the abort
   path where client state was being incorrectly discarded. Note that
   this is an interim step, as a more comprehensive fix is planned as
   part of the stateless KHO work [2].
 - Moves all KHO code into a new kernel/liveupdate/ directory to
   consolidate live update components.

[1] https://lore.kernel.org/all/20250929010321.3462457-1-pasha.tatashin@soleen.com
[2] https://lore.kernel.org/all/20251001011941.1513050-1-jasonmiu@google.com

Mike Rapoport (Microsoft) (1):
  kho: drop notifiers

Pasha Tatashin (6):
  kho: allow to drive kho from within kernel
  kho: make debugfs interface optional
  kho: add interfaces to unpreserve folios and page ranges
  kho: don't unpreserve memory during abort
  liveupdate: kho: move to kernel/liveupdate
  liveupdate: kho: move kho debugfs directory to liveupdate

 Documentation/core-api/kho/concepts.rst       |   2 +-
 MAINTAINERS                                   |   3 +-
 include/linux/kexec_handover.h                |  53 +-
 init/Kconfig                                  |   2 +
 kernel/Kconfig.kexec                          |  24 -
 kernel/Makefile                               |   3 +-
 kernel/kexec_handover_internal.h              |  16 -
 kernel/liveupdate/Kconfig                     |  39 ++
 kernel/liveupdate/Makefile                    |   5 +
 kernel/{ => liveupdate}/kexec_handover.c      | 513 +++++++-----------
 .../{ => liveupdate}/kexec_handover_debug.c   |   0
 kernel/liveupdate/kexec_handover_debugfs.c    | 219 ++++++++
 kernel/liveupdate/kexec_handover_internal.h   |  56 ++
 lib/test_kho.c                                |  30 +-
 mm/memblock.c                                 |  62 +--
 tools/testing/selftests/kho/init.c            |   2 +-
 tools/testing/selftests/kho/vmtest.sh         |   1 +
 17 files changed, 576 insertions(+), 454 deletions(-)
 delete mode 100644 kernel/kexec_handover_internal.h
 create mode 100644 kernel/liveupdate/Kconfig
 create mode 100644 kernel/liveupdate/Makefile
 rename kernel/{ => liveupdate}/kexec_handover.c (80%)
 rename kernel/{ => liveupdate}/kexec_handover_debug.c (100%)
 create mode 100644 kernel/liveupdate/kexec_handover_debugfs.c
 create mode 100644 kernel/liveupdate/kexec_handover_internal.h


base-commit: 4d90027271cfa0d89473d1e288af52fda9a74935
-- 
2.51.0.915.g61a8936c21-goog


