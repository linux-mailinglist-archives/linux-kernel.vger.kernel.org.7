Return-Path: <linux-kernel+bounces-843725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 03308BC016F
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 05:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A00554E4DCB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 03:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666AA19F115;
	Tue,  7 Oct 2025 03:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="WTL6iwSp"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BDD3C33
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 03:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759807869; cv=none; b=tpR0Jtcjs5Xu7UqqK6sN23ZtSqZO8PvCIbShWF4e83sy7/Pam6FxTVeuTBDQcgor7LXzw85CzeqVXVXHy15OgIV7HaYL/i1ohrbGhRc1t432GZe+U37pCFywKEm+6gmQ7cPkDTQgIYSHSMxRP13SoeJJLTSdQ0V7Q8mSkwO2+wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759807869; c=relaxed/simple;
	bh=MhQ6oJejU6PDuMID1wCmHAiUGwf2Bfqf9rncwjrHPQw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jrHqiD5lzGQnLWrEL87GWE2xhOOkcpWffhSX0yy5auzjeA/HmcRgyEf6QrYIOoGgJb2QK3uAmCkotks/wmQ0QB1RdTFUbvfFP/BHwI386WNJB7ePWLFuaf/UZnKnw7iw3mMotMYFghayAspsM8HVFKOjTZk/6kq+UoEmMweUi90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=WTL6iwSp; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5c7fda918feso6197356137.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 20:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759807866; x=1760412666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rjctk86pjCIgeyP/NdtThstP3+9eB+EELMA59nxuFWo=;
        b=WTL6iwSpS69VOe17zYnHhBqm+nkBidSvzd7Pj9gEFDXZyR/uouifYQAWiIJrY7DA41
         nEZGvUwiXISWhc4jYz8F1H3Gfa/qqXBUufc1nGrbZFhZmH7o90c8dzogGfQ5BRDPwWmX
         ytkgC+UpAhvWm54gvhCQxDjVCMWNnpPqbUlThUEA5D4icp2FyvMRi2ZcPKhDqwsKLnrt
         a4eYlkUaQDPE+EAcLgPRA9dd7vnBVdI+8B/ij9TH0F0TW750nFoWKskZTNLTk+klEfUk
         x5j3IT49IDd2gnewq/NUcjtFqLB5+Y3batYxFzkzYE8RZkm7ZFen3ME7uDwSU67INgBi
         RMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759807866; x=1760412666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rjctk86pjCIgeyP/NdtThstP3+9eB+EELMA59nxuFWo=;
        b=TjXW7/G0OPhkrr66OFhtBHjw3BX9IjY4WZzDte//Sr1TcgPjiis6sYlSBuV/0zXm10
         p9hv7MQ0iB5TTAUT+v2Vh+KuFhZgKSvDtmN6Z9Ys47W6ePoqJRsWad36qt52qfDlyITO
         A6fINwarfANv/nnoKX8PYW+Xvgo+lf9l39Sxelkieg2sOciooCVNSfW70qybGukiUoOB
         9APhqtH1vUUpGeLx0srFQgEjESXiQHEHqS2KoSwmQLr6gXJ2/M/eAralLANcmbo3dI3+
         tHwmVhVCJvSaEN1XuVWaVSQ7CSd1WWb2iXBAt2oj/cjL78dhKsZZEjsmF0U0wQPsBqgl
         p5rg==
X-Forwarded-Encrypted: i=1; AJvYcCWY7trPp8ifbEzccJZcg5bO/xbMKkav196TBKt8lSgvBxyZsn3y7rR4p4qiIh666DKTd7XYa9+kAG5tpgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkAvggNn273QYBqCpKvccG8OdsgPeQ28ZuNCvJ4TAwP9CQa1mj
	SP5iP2eIEW4ZDOjQovjmw67pYEkBxTgUTsC0MM65x2zRKVuL50ka3WmIuyMzf4Z1Yng=
X-Gm-Gg: ASbGncvtuhgag6vAjtKdsaXmbi/bmXZde4GWnFqvdU7/sqsVcnl8X3SoHXbCgIE+70N
	N5Ybsuch36JCp844bgp7aTXFC4zvBUI6D7FDaWihSdsHPBHBOk97NHSTVtJ3iuw1RPgoiCMpdI1
	g8fH+X3LIveWgYTwIFChtSEm+Y80hb9/2MpAMJHFKaeFbGCLqlCrEoKUuDp+I3WHj1GPIufnRfl
	jYJnnVTsifienf44HoU5s9fjzIIK5Zl0byoUVCxmfJzfE3Kc8eirVgCf284iZh8JRbvufdhrKMK
	DEWsp0N91kppjGGdj53tm9+nBcMPvgwWecvkQ7CeWlQrueTk+oKAMGwcylYXa/D0hLoaoLsMyGU
	QjQFRchecJq4gWv79xBmnTtfP7Y4sl0O+WIbu972DgwbGnUqWNiPsm9dHHqUllGveplqUqkVmCP
	ODNxAvSdDaXE0yVHSl7YT9b6YM0rdj91w=
X-Google-Smtp-Source: AGHT+IGKRy0UP3vTkTlJTpx5s9AazpWHtvbvNx1lS1PdbgNpyNUKLM1G0yemMh+rckd5h8dVv5lWbg==
X-Received: by 2002:a05:6102:5347:b0:59c:93df:4fe with SMTP id ada2fe7eead31-5d41cff3341mr5630492137.9.1759807865789;
        Mon, 06 Oct 2025 20:31:05 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-552ea335f07sm2446030e0c.15.2025.10.06.20.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 20:31:05 -0700 (PDT)
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
Subject: [PATCH v5 0/7] liveupdate: Rework KHO for in-kernel users
Date: Tue,  7 Oct 2025 03:30:53 +0000
Message-ID: <20251007033100.836886-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches are taken from the LUOv4 series [1] and address recent
comments from Pratyush.

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
  kho: add interfaces to unpreserve folios and page ranes
  kho: don't unpreserve memory during abort
  liveupdate: kho: move to kernel/liveupdate
  kho: move kho debugfs directory to liveupdate

 Documentation/core-api/kho/concepts.rst     |   2 +-
 MAINTAINERS                                 |   3 +-
 include/linux/kexec_handover.h              |  53 +-
 init/Kconfig                                |   2 +
 kernel/Kconfig.kexec                        |  15 -
 kernel/Makefile                             |   2 +-
 kernel/liveupdate/Kconfig                   |  30 ++
 kernel/liveupdate/Makefile                  |   4 +
 kernel/{ => liveupdate}/kexec_handover.c    | 515 ++++++++------------
 kernel/liveupdate/kexec_handover_debug.c    | 216 ++++++++
 kernel/liveupdate/kexec_handover_internal.h |  47 ++
 lib/test_kho.c                              |  30 +-
 mm/memblock.c                               |  60 +--
 tools/testing/selftests/kho/init.c          |   2 +-
 tools/testing/selftests/kho/vmtest.sh       |   1 +
 15 files changed, 553 insertions(+), 429 deletions(-)
 create mode 100644 kernel/liveupdate/Kconfig
 create mode 100644 kernel/liveupdate/Makefile
 rename kernel/{ => liveupdate}/kexec_handover.c (79%)
 create mode 100644 kernel/liveupdate/kexec_handover_debug.c
 create mode 100644 kernel/liveupdate/kexec_handover_internal.h


base-commit: 4a71531471926e3c391665ee9c42f4e0295a4585
-- 
2.51.0.618.g983fd99d29-goog


