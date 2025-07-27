Return-Path: <linux-kernel+bounces-747225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D3FB1312D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 20:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03F2C3B6CC8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 18:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB9F21FF37;
	Sun, 27 Jul 2025 18:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e4TmBtBL"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EF4145B3F
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 18:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753641055; cv=none; b=cNzooPKkL/SS5j2YXBPgFUnU3gxRjiqTJbh4XfGzP69IT6IjSz2UKzSMOU2p4+eBsfVGuEg7g+7DSr7nn3u9W8FzxMY77oFXFDJTrgMEy+eGO3oOmXtHVoLxCwLAHvYHOCTbdgM/Oz1TFofM+6P2R7qEAEXpVmom3CsuvQQAY4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753641055; c=relaxed/simple;
	bh=Jch93u4dddBCM+4zh4u4VF9kachuFUccOMvqa2wvpMM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lbN0z8ixinnI7nJouhlaE+ApJ0zHFYUdaGj7m4CAdqYTjat7z00lReoxDQgovSBlG6fMo06Z/bwR6yLN9nOtzcVm4UDPj+6rJH/yLJPgxds9lD5LBpLKuHGUMSEPva5YC9C0nESUq0FnxnhVDolcdpLEfjrNFVRh5X11dak5lgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e4TmBtBL; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3141a9a6888so2843813a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 11:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753641053; x=1754245853; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v8Qf5T04i28bf1zSyDnzy7KEP6ifkrCxLLS5my/D4aI=;
        b=e4TmBtBLYuP1uqS/zYF4rdIA+G5Xf7lF/228zIviS47xQNhXVGEI6lAnsAhzx4JYaq
         pgOI8wSWIOyN8oHtB1qRNM3MkCivgNs8Wvb1ljZEDhlSNZUu48+t/eEsyOJF95xLz+xw
         Fv7t9dAFeLHctyAXrhe6iQ5lcniWVC2DFKtYNFS2juee+CwfjWyHiab/nqyOF6ehZfvK
         PKQjfWlTJ3h98ieyhbob5a4ptbOShkTbjxtkIFi3DBqebw0g7+Y7CRNB0BRHYSBITtjp
         +fzK+WSRjZEbDM0a/KfgBX/65MhpaO7H2W5goD9MBNTyPrlLJl3cokGMDogEP7oghuK5
         +uDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753641053; x=1754245853;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v8Qf5T04i28bf1zSyDnzy7KEP6ifkrCxLLS5my/D4aI=;
        b=iOBWevEp75CAN0911FFOxIdUzHij2/9QzA3isN34zV18TegaQCbLLjwS7cp3rNmjio
         /xhs6+MBYnLpi9sMzdl/AKFfM0Jf/1BwXfPxQB5gp5v7B7eHITAb6EripYQ/81je20uK
         FfVdudA+lP2266pjc6xt0ONwiIdmCc97wMzYyqzM5znaMVy4KwO3m2JKoMB1PAz03rK5
         7CrYy0JVg2aqOclUK7KGoGl4x+mptvW5tt6Sw7UpsudIZ5b0cb7bC/vn7ExKyB/LoFms
         rzWpHhWOLzg2ppXcOw+O7ifd8VwEKxLTk/0WUNL88WGCOJyaCQUy4DMl9oNwh6dUAujy
         dkMw==
X-Forwarded-Encrypted: i=1; AJvYcCXyIPZ/UMCmEaPz4wzTx+wX3vM2+ZjjBEnhpOjp4YFDqHJfgbAGAPsvUmUZ43HIzjXRH2YfPFVMx9smb/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsZd7q9XEvNnX79dxP2MpEbQ9A8s0+RkqtDqt/LrdK96iEKGmX
	tZk9SWabOqonMHCeb4k0GGnES2dzx/8w6Kr1WuSbr2YX4/MyoozAKSPfqfZzqpVOtbdoZUqVYib
	/Ww3J8LgfmQuihg==
X-Google-Smtp-Source: AGHT+IEyrLSbmShxWrH2L++sVNhCrAjNYzJ8ukqPEcNuFwzTp/1ibLYMxPTm0SUPZ24Ne8FtsWAfYKW/T0ow3g==
X-Received: from pjbnw7.prod.google.com ([2002:a17:90b:2547:b0:314:626:7b97])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2e51:b0:31e:cc6b:321f with SMTP id 98e67ed59e1d1-31ecc6b330bmr3603538a91.29.1753641053313;
 Sun, 27 Jul 2025 11:30:53 -0700 (PDT)
Date: Sun, 27 Jul 2025 18:29:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250727182932.2499194-1-cmllamas@google.com>
Subject: [PATCH v20 0/5] binder: introduce transaction reports via netlink
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tiffany Yang <ynaffit@google.com>, John Stultz <jstultz@google.com>, 
	Shai Barack <shayba@google.com>, "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Todd Kjos <tkjos@android.com>, Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="UTF-8"

This series is based on the v17 patchset from Li to add the transaction
reporting feature. There were several changes introduced in since that
version (detailed below). However, the motivation for this work remains
the same:

> It's a known issue that neither the frozen processes nor the system
> administration process of the OS can correctly deal with failed binder
> transactions. The reason is that there's no reliable way for the user
> space administration process to fetch the binder errors from the kernel
> binder driver.
>
> Android is such an OS suffering from this issue. Since cgroup freezer
> was used to freeze user applications to save battery, innocent frozen
> apps have to be killed when they receive sync binder transactions or
> when their async binder buffer is running out.
>
> This patch introduces the Linux generic netlink messages into the binder
> driver so that the Linux/Android system administration process can
> listen to important events and take corresponding actions, like stopping
> a broken app from attacking the OS by sending huge amount of spamming
> binder transactiions.

=== Changes in v20 ===
- Dropped unnecessary header file inclusion from YAML spec.

=== Changes in v19 ===
- Fix yamllint issues in Documentation/netlink/specs/binder.yaml
- Rebased on top of current char-misc-next branch.

=== Changes in v18 ===

The most significant change is that I removed the "setup_report" command
from the netlink API. So there is no longer a "configuration" step to
filter out transactions from being reported. Thus, there is also no need
to add a new selinux policy.

It just doesn't make sense to keep a single global filter that impacts
all the clients that subscribed to these events. Instead, any filtering
should now be done at the client side (if at all needed), potentially
through a BPF program or similar.

Note this makes the implementation way simpler, which is great!

I broke down some of the changes like the tracepoint addition into a
separate patch and added a couple of preparatory patches to make things
more convenient.

The previous documentation was also obsolete and placed under the
admin-guide/ book, which is incorrect. Instead, I decided to move all
the documentation bits into the YAML spec itself.

Some of the attributes in the report are now optionally included. The
"to_pid" and "to_tid" are only included if they are known. Similarly,
the "is_reply" attribute was switch to a "type: flag" and is only
appended to the report if the transaction is a reply. All this is
documented in the YAML spec.

---
v19: https://lore.kernel.org/all/20250725183811.409580-1-cmllamas@google.com/
v18: https://lore.kernel.org/all/20250724185922.486207-1-cmllamas@google.com/
v17: https://lore.kernel.org/all/20250417002005.2306284-1-dualli@chromium.org/

Carlos Llamas (3):
  binder: pre-allocate binder_transaction
  binder: add t->is_async and t->is_reply
  binder: add tracepoint for netlink reports

Li Li (2):
  binder: introduce transaction reports via netlink
  binder: add transaction_report feature entry

 Documentation/netlink/specs/binder.yaml       |  93 +++++++++++
 MAINTAINERS                                   |   1 +
 drivers/android/Kconfig                       |   1 +
 drivers/android/Makefile                      |   2 +-
 drivers/android/binder.c                      | 158 +++++++++++++-----
 drivers/android/binder_internal.h             |   4 +-
 drivers/android/binder_netlink.c              |  31 ++++
 drivers/android/binder_netlink.h              |  20 +++
 drivers/android/binder_trace.h                |  37 ++++
 drivers/android/binderfs.c                    |   8 +
 include/uapi/linux/android/binder_netlink.h   |  37 ++++
 .../filesystems/binderfs/binderfs_test.c      |   1 +
 12 files changed, 349 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/netlink/specs/binder.yaml
 create mode 100644 drivers/android/binder_netlink.c
 create mode 100644 drivers/android/binder_netlink.h
 create mode 100644 include/uapi/linux/android/binder_netlink.h

-- 
2.50.1.470.g6ba607880d-goog


