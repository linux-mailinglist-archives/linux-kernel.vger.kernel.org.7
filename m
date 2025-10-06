Return-Path: <linux-kernel+bounces-843254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5595CBBEC52
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 19:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4411898D01
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 17:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D716C22423A;
	Mon,  6 Oct 2025 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0H6wpwl"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE99A20E011
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 17:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759770253; cv=none; b=pAyW4kg8QGhcAUoJmBs6uw934UJPWx26nUXufsvnZYA4pXcxPRKPGyNTSilF9MZf2WEnsgspE1hdCmVk2KzxpP90ym06ph847A0mWCHdHUaUfAUu/IenmTs+B+0etXIX3kzOP0A3dCSrs8dR1YJPxTEm0eMBqEuti9G9xZsDLpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759770253; c=relaxed/simple;
	bh=Tv75a2Sne1jWALQWl4dpTmCSFJsBFUMprPNrzXrKlKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EjrZm9rJR427FG+yhY9buur74ZK4BSux+JzIcxwZBJBuNiIjVdi9Dg1hBLa45BBtI2cKwhz/Z4vD+FMjalW+V2rJmBVocrw/voCysmBr1agnzzcFyaKTw2O9K+1282FqET5zZi0nrFywJl9pQb8/XTekAOd7KKxUj+X1/QgDhgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0H6wpwl; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-8c3414ad279so196061939f.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 10:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759770250; x=1760375050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7JzPEIVulkIwciGns1doC5yUlbB1c8Y4/uVe7CVnMk=;
        b=C0H6wpwlGMbiAez0mrlMPi8vo7UtkGjuUfMYzb5kDy5xE24rvXsTIKnWghANlV8TEJ
         Faf1l9OwUkdZc++8cLTgzGbVC6k+M50EYlK6+oZ3x2G9TVjMkRtFgKImeWekfN6Wzxdu
         RTmqYPJ8V95VaCi826Px6FxRu6thwHj/k0eDw8yl2s8OK9f5orOhy8m8FDOGsfVkh4kV
         7bBmuyupHr1gUx4ncF9+4t3AoiW7uhMFcSADCIF8XS7LIxUl1VJwmj3mMZzTnVWiWo6m
         PNYCQytg9fcj2UMogNNPIqxymKQjayn0IjqQhkMPCCSue8mfquGHcwp5dcLoW6kDF5Ho
         D+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759770250; x=1760375050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z7JzPEIVulkIwciGns1doC5yUlbB1c8Y4/uVe7CVnMk=;
        b=IywzLjft+oYqJz8V34E3ReKMspmwECcd+7J0bQWc4F/I45jCNhLRn/DgcqJVw21Yf/
         YjwrBBibaiQbmse52zHM9wszqCjvWL+rjZVkkPQ/JDc9+j0rUH0znIVTYS/nq44DCHcT
         Vws64PS2zvn75RpDy1KN+QBaPnxv+kRGQ/Jg+60lvVy/4zzty0YxxTVpyUkEDdPEsIj9
         lBA6J8+ny/KW6glv8N5lype3je5wG4lx52OBrVBMZ06beO609H5jKfy36PMDmw77vMEQ
         yWTfcyuFpJSEEi/zF8D3ulcS5krltm4UpidsgOmhYA8Minrnb57+ypVMu2aHFahrI8qs
         KM5A==
X-Gm-Message-State: AOJu0Yzpwbcf4LI9IA7BNXrhtLjVcC2hYFhTO8zdxnGNHwn/fDsJ3Y0Y
	wB/vh8Bv3T84WcLJFBB4fliWtE96rLxBGuBxtCvINN9zx684oLX63oznH90Cn5x0
X-Gm-Gg: ASbGncsn9HnWL/1g/SdSXQqnIIeLBkIhBX/0swAn4ECSWBRKM5HFLtdPfigK6oW+3rF
	ePXvWXcv5o09XhFb+TvRQHKIT6WEqEVwlUzMUxFhG9K2mYxjvhS7HM+vEYF8gx98IyLUE8vUa6E
	UZHGt9nWRsmJMuuhFgGBsBz+FZ8PoLx1SryYQPIzC93MlNFYFzNqqTM0d3TaNMjfeNMYIeRthsw
	DtwLvzx7x/4XIrx3ZvIacbSEb2s5VIEVT67Hk2+xOJ48oGObj61Tx/EOhcGwYQuajikk1ru3Dh4
	H93KbTrnCQoxDipUDenqHhWGVj263E6PffF9VzywVabFFQzrlQSlQ2aOjO7dWkkUUXAWuqiwyO1
	0zNP8g+A599nfMxAzJpTxNLfKbkEocdGDzu5iXv5IJMO5i73+nPBSDMarbKUt14+7mHQTdckjpn
	wlrHaCAdptIEfIilty52oshbe5nD8K4qd7645Sx8Fogxs5UWZGbVhfwyBN
X-Google-Smtp-Source: AGHT+IGXUEayRywAtX56oYmi4iHaqM0HYrVnCrirNkC9ObeFhcKTuwkabcZToX/MKLlHrqsXsvyWvw==
X-Received: by 2002:a05:6602:3412:b0:918:31ac:52ac with SMTP id ca18e2360f4ac-93b96949592mr1855311039f.1.1759770250110;
        Mon, 06 Oct 2025 10:04:10 -0700 (PDT)
Received: from newton-fedora-MZ01GC9H (c-68-45-22-229.hsd1.in.comcast.net. [68.45.22.229])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93a87bb84b4sm488589539f.18.2025.10.06.10.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 10:04:09 -0700 (PDT)
From: Ryan Newton <rrnewton@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: sched-ext@lists.linux.dev,
	tj@kernel.org,
	arighi@nvidia.com,
	rrnewton@gmail.com,
	newton@meta.com
Subject: [PATCH v3 0/2] sched_ext: lockless peek operation for DSQs
Date: Mon,  6 Oct 2025 13:04:01 -0400
Message-ID: <20251006170403.3584204-1-rrnewton@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows sched_ext schedulers an inexpensive operation to peek
at the first element in a queue (DSQ), without creating an iterator 
and acquiring the lock on that queue.

Note that manual testing has thus far included a modified version of the
example qmap scheduler that exercises peek, as well as a modified
modified LAVD (from the SCX repo) that exercises peek. The attached test
passes >1000 stress tests when run in concurrent VMs, and when run
sequentially on the host kernel. Presently, tested on the below
workstation and server processors.
- AMD Ryzen Threadripper PRO 7975WX 32-Cores
- AMD EPYC 9D64 88-Core Processor

Initial experiments indicate a substantial speedup (on schbench) when
running an SCX scheduler with per-cpu DSQs and peeking each queue to
retrieve the task with the minimum vruntime across all the CPUs.

---
Changes in v3:
 - inline helpers and simplify
 - coding style tweaks

Changes in v2:
 - make peek() only work for user DSQs and error otherwise
 - added a stress test component to the selftest that performs many peeks
 - responded to review comments from tj@kernel.org and arighi@nvidia.com 
 - link: https://lore.kernel.org/lkml/20251003195408.675527-1-rrnewton@gmail.com/
 
v1 link: https://lore.kernel.org/lkml/20251002025722.3420916-1-rrnewton@gmail.com/

Ryan Newton (2):
  sched_ext: Add lockless peek operation for DSQs
  sched_ext: Add a selftest for scx_bpf_dsq_peek

 include/linux/sched/ext.h                     |   1 +
 kernel/sched/ext.c                            |  56 +++-
 tools/sched_ext/include/scx/common.bpf.h      |   1 +
 tools/sched_ext/include/scx/compat.bpf.h      |  19 ++
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/peek_dsq.bpf.c        | 265 ++++++++++++++++++
 tools/testing/selftests/sched_ext/peek_dsq.c  | 230 +++++++++++++++
 7 files changed, 571 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/peek_dsq.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/peek_dsq.c

-- 
2.51.0


