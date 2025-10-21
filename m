Return-Path: <linux-kernel+bounces-862068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE14BF45B7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 04:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59775404783
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 02:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508C227603C;
	Tue, 21 Oct 2025 02:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOkdXt0M"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F722737EE
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761012550; cv=none; b=T8Fa4GuLT3nhn7CODXQ9JlVW0W0h+kFIoOMSK2uESjMyJO+EyVjjMs3rsWuuu9xU2TjyC4AusAQPKcsA4N4k2JooMirWPEQphOnOmFMnwB58S32QB8IkDykvwyXSK+IwSpG09zqR5rDZTHdmvPWr73ZWzDD+qS8q10byYrdQI3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761012550; c=relaxed/simple;
	bh=yGtbk5lHI3kq7dyR6Ccfn979PbRPyfWmTul2ikCiYio=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=O+Mc2xqnuABpAueocU8J+2N6LsTlvsoPqayJNvm5Eb22T8qmphunqRg3ouVlfRWOzps4k6dbiLwVNmZLK7sr+BnLlFegFup+Xnt/Xc9HFsRcJOVFd0VMpIITmJtOJwKfbvcuSH/ECY9f5P7DIvu1X7P7mtOSYd/leB6MTB2HCw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOkdXt0M; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b62fcddfa21so3267844a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761012547; x=1761617347; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RSHZrMdT1rNKLCfHO0WzHkGQXMBPH1VXE0UZcdITjiE=;
        b=aOkdXt0MDl9aBkRGHyw++3wUld6q8+dOq9sbqlDRjsd1ad3ZJYWa75/wMiM7r/uVb7
         QV1e5vvV4iHjL40vnZqyELu65QVSlR0XYxoH+kF8FTU+0q0Kz/hBx6tJHWROUww22+oV
         PB9liGTb0b6xDxpEpXpgnA0eMIgIuWi9wIurU4f7KJWezZ2Qvo20tIw4h94kmevY4p77
         FA4tZwjQEqYn7UzLeUXh/gZkB7+l4o1YwsIKYh+Gvf7r1+NuMwXpiHOqBKC3xCb6Qf2k
         ghnVZuglZkG4rdCvlqcNLHlhmUe0ZcfoxyqzQ2BfqzKp9wpkR1cJ69iEJhwGO8Ontpb6
         0B6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761012547; x=1761617347;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RSHZrMdT1rNKLCfHO0WzHkGQXMBPH1VXE0UZcdITjiE=;
        b=ta+eEx9dSb+NPyfDx+G8SMUHC8SVfLxnwfX6B6RVA+P4NV2bQbiCkDrcl0iPXOANs6
         IRRy/RC1wYVz14C4W0WioZR6djeWgLmC6QUdLq3iMH7Sc0k/stpEDBfoYXSmrei3YlAv
         JHoTmc6yelYtM4U6QHKOyX59UUaaSq6WHVH9RzHllA0pYnphRIkdu1SqPCg2x75yePzm
         QW5MpY1V9v6kdDAol7Ea05EgITwUmKGX6FBIrWy+wyUEe+Cv3Osl6DpKSf0AOachBijJ
         uq+guX5qpIv5BLXjEtHknmj0WvJBP7dDziJGF4nBrNupdVGL3QGrhUTiiEHcdk1B7v+M
         8c4g==
X-Forwarded-Encrypted: i=1; AJvYcCUcJ1A72adI+B3u+3mz6jW/7OgWX2KFzOdz7jnyLliygqGFvw5gcYvCxveaheXJjmMWulVHBedkE/yIaVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDOLPAga3IpbrsRdoXxpLBM+Rfv/JQQGjnmmcubhGsrG+bdwQs
	WxcSH4/2ynlcqefeqTOT4Hpbt616Qxwl10Bov3ad8eQT3zMjwoQl9IVpPO8wXm1WDKf9alpH+4g
	GVNF9aQ1IJozADtBCfk0Yi9/vS7ec6OA=
X-Gm-Gg: ASbGncvkgX+Tm/DngAjV9VW6s9CmPJmty16UZ5dU7rBW8ep+kLIGGn2Bb+l1CHb9OKo
	SRdR6pV2e1v5StKOWykCXlxGeBWzCXFFEICzmlx7v2cbaBLNDKFxBueUF+iR19uKgaQ4yL2kEOR
	jOgYGq/6czc2DEM5po4oNxo3QUryhK0Q79Ku4T7sDw+yFvtFgyia0hE7owecR03OBjJT8FsTIrb
	CK928MeUk8VggyBnBD34A/YVyQEJccgegA0IMlZtPghAFlLLNUorDdrKCwdUauqpHhnRQ==
X-Google-Smtp-Source: AGHT+IGI6nmhwmy6qVV/5p98VPbodX2KbY/ejETa/NKy48hQF8/IWksWUPDrLNOcGYbgqzWaEnpoxE+cPeFDLYDBOeI=
X-Received: by 2002:a17:902:d501:b0:28e:7fce:667e with SMTP id
 d9443c01a7336-290c9cbc6d2mr196330075ad.17.1761012547292; Mon, 20 Oct 2025
 19:09:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jesper Juhl <jesperjuhl76@gmail.com>
Date: Tue, 21 Oct 2025 04:08:31 +0200
X-Gm-Features: AS18NWCV60O9H_TfISsqY7ZnWFD9f_H8XtVJP2DI992D3PQ7BXcUyCc296_2jFs
Message-ID: <CAHaCkmc_CrwBRj-Gji_td9S19oPg9U9-n8B4u8yTR4sPm9Vx7Q@mail.gmail.com>
Subject: [PATCH] Fix up 'make versioncheck' issues
To: wireguard@lists.zx2c4.com, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Jesper Juhl <jesperjuhl76@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From d2e411b4cd37b1936a30d130e2b21e37e62e0cfb Mon Sep 17 00:00:00 2001
From: Jesper Juhl <jesperjuhl76@gmail.com>
Date: Tue, 21 Oct 2025 03:51:21 +0200
Subject: [PATCH] [PATCH] Fix up 'make versioncheck' issues

'make versioncheck' currently flags a few files that don't need to
needs it but doesn't include it. This patch fixes that up.

Signed-Off-By: Jesper Juhl <jesperjuhl76@gmail.com>
---
samples/bpf/spintest.bpf.c                                | 1 -
tools/lib/bpf/bpf_helpers.h                               | 2 ++
tools/testing/selftests/bpf/progs/dev_cgroup.c            | 1 -
tools/testing/selftests/bpf/progs/netcnt_prog.c           | 2 --
tools/testing/selftests/bpf/progs/test_map_lock.c         | 1 -
tools/testing/selftests/bpf/progs/test_send_signal_kern.c | 1 -
tools/testing/selftests/bpf/progs/test_spin_lock.c        | 1 -
tools/testing/selftests/bpf/progs/test_tcp_estats.c       | 1 -
tools/testing/selftests/wireguard/qemu/init.c             | 1 -
9 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/samples/bpf/spintest.bpf.c b/samples/bpf/spintest.bpf.c
index cba5a9d507831..6278f6d0b731f 100644
--- a/samples/bpf/spintest.bpf.c
+++ b/samples/bpf/spintest.bpf.c
@@ -5,7 +5,6 @@
 * License as published by the Free Software Foundation.
 */
#include "vmlinux.h"
-#include <linux/version.h>
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_tracing.h>

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 80c0285406561..393ce1063a977 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -2,6 +2,8 @@
#ifndef __BPF_HELPERS__
#define __BPF_HELPERS__

+#include <linux/version.h>
+
/*
 * Note that bpf programs need to include either
 * vmlinux.h (auto-generated from BTF) or linux/types.h
diff --git a/tools/testing/selftests/bpf/progs/dev_cgroup.c
b/tools/testing/selftests/bpf/progs/dev_cgroup.c
index c1dfbd2b56fc9..4c4e747bf827a 100644
--- a/tools/testing/selftests/bpf/progs/dev_cgroup.c
+++ b/tools/testing/selftests/bpf/progs/dev_cgroup.c
@@ -6,7 +6,6 @@
 */

#include <linux/bpf.h>
-#include <linux/version.h>
#include <bpf/bpf_helpers.h>

SEC("cgroup/dev")
diff --git a/tools/testing/selftests/bpf/progs/netcnt_prog.c
b/tools/testing/selftests/bpf/progs/netcnt_prog.c
index f9ef8aee56f16..3cf6b7a27a34a 100644
--- a/tools/testing/selftests/bpf/progs/netcnt_prog.c
+++ b/tools/testing/selftests/bpf/progs/netcnt_prog.c
@@ -1,7 +1,5 @@
// SPDX-License-Identifier: GPL-2.0
#include <linux/bpf.h>
-#include <linux/version.h>
-
#include <bpf/bpf_helpers.h>
#include "netcnt_common.h"

diff --git a/tools/testing/selftests/bpf/progs/test_map_lock.c
b/tools/testing/selftests/bpf/progs/test_map_lock.c
index 1c02511b73cdb..982bdbf0dba6b 100644
--- a/tools/testing/selftests/bpf/progs/test_map_lock.c
+++ b/tools/testing/selftests/bpf/progs/test_map_lock.c
@@ -1,7 +1,6 @@
// SPDX-License-Identifier: GPL-2.0
// Copyright (c) 2019 Facebook
#include <linux/bpf.h>
-#include <linux/version.h>
#include <bpf/bpf_helpers.h>

#define VAR_NUM 16
diff --git a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
b/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
index 176a355e30624..e70b191162359 100644
--- a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
@@ -1,7 +1,6 @@
// SPDX-License-Identifier: GPL-2.0
// Copyright (c) 2019 Facebook
#include <vmlinux.h>
-#include <linux/version.h>
#include <bpf/bpf_helpers.h>

struct task_struct *bpf_task_from_pid(int pid) __ksym;
diff --git a/tools/testing/selftests/bpf/progs/test_spin_lock.c
b/tools/testing/selftests/bpf/progs/test_spin_lock.c
index d8d77bdffd3d2..9bcee268f828b 100644
--- a/tools/testing/selftests/bpf/progs/test_spin_lock.c
+++ b/tools/testing/selftests/bpf/progs/test_spin_lock.c
@@ -1,7 +1,6 @@
// SPDX-License-Identifier: GPL-2.0
// Copyright (c) 2019 Facebook
#include <linux/bpf.h>
-#include <linux/version.h>
#include <bpf/bpf_helpers.h>
#include "bpf_misc.h"

diff --git a/tools/testing/selftests/bpf/progs/test_tcp_estats.c
b/tools/testing/selftests/bpf/progs/test_tcp_estats.c
index e2ae049c2f850..eb0e55ba3f284 100644
--- a/tools/testing/selftests/bpf/progs/test_tcp_estats.c
+++ b/tools/testing/selftests/bpf/progs/test_tcp_estats.c
@@ -34,7 +34,6 @@
#include <string.h>
#include <linux/bpf.h>
#include <linux/ipv6.h>
-#include <linux/version.h>
#include <sys/socket.h>
#include <bpf/bpf_helpers.h>

diff --git a/tools/testing/selftests/wireguard/qemu/init.c
b/tools/testing/selftests/wireguard/qemu/init.c
index 3e49924dd77e8..20d8d3192f75c 100644
--- a/tools/testing/selftests/wireguard/qemu/init.c
+++ b/tools/testing/selftests/wireguard/qemu/init.c
@@ -24,7 +24,6 @@
#include <sys/sysmacros.h>
#include <sys/random.h>
#include <linux/random.h>
-#include <linux/version.h>

__attribute__((noreturn)) static void poweroff(void)
{
--
2.51.1

