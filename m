Return-Path: <linux-kernel+bounces-746200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAA7B12425
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2761D17C8B8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D367253F15;
	Fri, 25 Jul 2025 18:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gh9Zro7P"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA4E24BCF5
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 18:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468704; cv=none; b=mb24u+Pj5dAc+eXprk4IU7O021WAqkUbZqRyLzf3GalLQO5kmBRXiocLubpMoFOohIPvSAec8DYwabZzYgvRjWZF3TMJK72h9zmXAc4z30DCWvDGkGE2lj93hRnVy+cYrTII15StW8xymrILtkIehimdFwnC/Vb888xC8SPuE0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468704; c=relaxed/simple;
	bh=YwRzaFFvyzTPGjng4pvN/sQgScFY2lA5f+URt2Bcz8E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jtWMEKw2kFhodbe1PIEuegVgIvoH1v8122XDNoyxf1In6Tp/KgX2BX2gKo/CWufVo1ll3JKpRH//4bTEbOGukFeVy2W0y5a0Oi0HNOsvUNeUiaIE6welXjxljjC2dvggLYt93eNVNNqNJcsSrDebeeczEvvVHIiyfC7xsisNO+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gh9Zro7P; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31215090074so3729491a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753468702; x=1754073502; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bf3ro3WF1f1XcnzdODBXczCsKq2ws8mpoYevGDekD60=;
        b=Gh9Zro7P3PNYUSdCriCSEAWvQjC00MXOHHq5jaGKvaF8JOJ4m1JtVha0HMa9y9Bj8m
         StdYeFOepC4SgfDmmaru65oPIV7u1+sKGiGtRo0OuI1kXbm0bFmIvV0FfYCVMAyQoDH4
         yT0T1/kttsiwTIKEtlFnOFYMlck9P+ZTdF5DGFIcUxGdvwMb5biPpLHXEzfJFx7tX+My
         GbrMIWDBeadikJ2ppkreaMtT6bE16oXoJN9mfPTV2uXe0d2ShpQxQKwWrsjBCnq2Bza3
         0gkIzWMr5bQkQ8SSKydlO7jlmKKpoa+sg/4Z6V9lD65iIglabH8V5KMK00GHBqaPjmrI
         Frog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753468702; x=1754073502;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bf3ro3WF1f1XcnzdODBXczCsKq2ws8mpoYevGDekD60=;
        b=aqOsTEiwYd4RriisJdZo+iw57nYZ33KZC0VZXaLCzjiO+UCdcaDis0w5LL5oDU9swf
         bsf0xbYVZ7KDOGWOiTDodTqqdseHEuE4xarlc9HVXp41cp8TSN6sKHNQTSYQmpNqj4BI
         rKAeLqKFxnlLfR6s9BLq4h0DyDQiOPnMqbjF0ofJnvRRFG20yfpfk4QV9NAtXkG1C7F4
         U0z8CHDBXKvJNm7dxx+lKLF2QVnPZHhZht/ss3IZ53VzSAekoHQIobt3JzqxIDhzB9Ph
         /zGWaixB2zej2f1+TFMuBmJ3/cW5GLxTLWFH5DIt3jUeMJgge6maGvefCZhRpY/0m/Zs
         HKGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdb+4yFCWDvK+0e8WBwsSwJIt4IzUKSlZYBD/fnMOiwPqm56ds3Cyek9Rn25N4k+XtYMSQD1P1fuYJTaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZl5eC6ow6EROdYwwkUlYlVft+kLYBeDtLxg3ggB1xvzYsZfz8
	2n4UNBW7aHb0OB1uK8MmcIW0VXi2PoLJwLw5Rh9zZoYyKMHjRGqkkxAVf71YZBAoWogx9pXeU/a
	uzI7R7Vc2nKQrZA==
X-Google-Smtp-Source: AGHT+IFDd1ZsorX/GXo8CDkRtzD+rpcA9l+7YsN+QhQ4zN/p/DyrcsmvPror8tHgM4sWuga4LCTr8Sl3OzC76Q==
X-Received: from pjbnt17.prod.google.com ([2002:a17:90b:2491:b0:31e:7f86:99c8])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3912:b0:31c:260e:55e9 with SMTP id 98e67ed59e1d1-31e77afe6b4mr4652520a91.24.1753468702336;
 Fri, 25 Jul 2025 11:38:22 -0700 (PDT)
Date: Fri, 25 Jul 2025 18:37:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250725183811.409580-1-cmllamas@google.com>
Subject: [PATCH v19 0/5] binder: introduce transaction reports via netlink
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
v18: https://lore.kernel.org/all/20250724185922.486207-1-cmllamas@google.com/
v17: https://lore.kernel.org/all/20250417002005.2306284-1-dualli@chromium.org/

Carlos Llamas (3):
  binder: pre-allocate binder_transaction
  binder: add t->is_async and t->is_reply
  binder: add tracepoint for netlink reports

Li Li (2):
  binder: introduce transaction reports via netlink
  binder: add transaction_report feature entry

 Documentation/netlink/specs/binder.yaml       |  96 +++++++++++
 MAINTAINERS                                   |   1 +
 drivers/android/Kconfig                       |   1 +
 drivers/android/Makefile                      |   2 +-
 drivers/android/binder.c                      | 158 +++++++++++++-----
 drivers/android/binder_internal.h             |   4 +-
 drivers/android/binder_netlink.c              |  32 ++++
 drivers/android/binder_netlink.h              |  21 +++
 drivers/android/binder_trace.h                |  37 ++++
 drivers/android/binderfs.c                    |   8 +
 include/uapi/linux/android/binder_netlink.h   |  37 ++++
 .../filesystems/binderfs/binderfs_test.c      |   1 +
 12 files changed, 354 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/netlink/specs/binder.yaml
 create mode 100644 drivers/android/binder_netlink.c
 create mode 100644 drivers/android/binder_netlink.h
 create mode 100644 include/uapi/linux/android/binder_netlink.h

-- 
2.50.1.470.g6ba607880d-goog


