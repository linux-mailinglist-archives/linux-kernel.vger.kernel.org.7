Return-Path: <linux-kernel+bounces-849863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E802ABD1203
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 03:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 380143BE4BE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 01:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CEA273D6C;
	Mon, 13 Oct 2025 01:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7mhA/tw"
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1DF223DD5
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760320338; cv=none; b=g1t7Mp8QhzUsPn0Zcj98WhHignuqDWhOlhbJO9uy5dlKjJ1zOPSqePgnngXpfXaZtoMeSF12cI1XB4EKPsYId5ZxDR4Brh3A6zjQ3BQfpCyTtIZ5npwmHGPbaY8CQdSEX/E6Vu2aRw0cLm5uYtfYKxO31nKzzIFb/4i9HY9a6YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760320338; c=relaxed/simple;
	bh=uwhmf3HHMdzGiNGOGPfqkDj/FI1GzglANXwo8s9sdOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Or7HGXnpW75w2PSdSYdiAD/tRty4FpYuJ1IxZLqaw4MD4Lp5kOJKC8ysqb2l9x5Aavj02UUFjkzrBVa+9/0PqNUdpHaHvtHkOqh3W3TEDZLds/FlFYlkdQR46YFLun4pZY03uaqpwwqik6EQsHvxfx9rs6yZTYl6avtzBKPy4Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7mhA/tw; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-33b5a3e8ae2so2475555a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 18:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760320336; x=1760925136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cwkgnTg2DHDaQ2RkX3ciR9SF56jSYXArtqinhDMsIj0=;
        b=O7mhA/twKMJrbDV6sqqHGnkCbwI5do7lIyOjAWskLY3oryIueqfrAYUhOb5K4/fR2d
         KtoiRDW4KWpnyK/5tdtiC6fkWek0yB9xz4MdfSm09J+2BKondqLyY7PAYFjfR4PYCb5J
         OBLHURthrgt+Fe0/eMHCpCoX4doo7739U0PtYdVbdllQ3BwHEtWnU3hQiN65qS7tLI+f
         MvMLTL7P63hDcgfcqPK5VQg/kOazqXtpAFCmK604CBc65G7I8klhda2Uyd7Q2VEvs0gJ
         Q0zj+YL8BsYtLnktSEP1nP8bbQafxRVHDuqrMbteSWvaW6KqhB2/EQV+qMQyA6XWCKXW
         WqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760320336; x=1760925136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cwkgnTg2DHDaQ2RkX3ciR9SF56jSYXArtqinhDMsIj0=;
        b=cCH7HbhJQ2145LiwzFYWikHZLBH1CAgHbcneuu1KbaM/3ubis9IEZ4rMVpZ15ZcKdT
         CMkgU06Jl0SnQKN8Adx1tEeBodFLfBAXq4amxe6pjegkKS6EdnjglHE4RQL2VJGUeTH8
         UhXSzI8zi+O8IvSnGAF/+m0aAX9LVavDwTAi8DSIlkTpTnHW+geHWgxJeOD1Xv+8+8zN
         5PLmsl2DdrPg9Oem2lYp/ZtK1hKOh2MozVvkk/NTQPXkxnvcCBynXeuX/3ODBN7H6rSy
         1gAAUG+EZkn2Ro54oPWZQkz5GRPhusPs69zejBM9MlGSCwfFd72SmyKm5ksC9m2Czm1n
         c4WQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSLgEgAFOOkXxOWKlMusURP5g9ofe9jIyoe45IpPKURZELp9eBvyVe3au9iwMosgpa3Q9RlyfxB9mMqoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxThbdSxQDrIOz1Gw67VJuUf1w8r/tsce+JXAjmm2qxyr3T5vWg
	Pdi9wQqArJdf3F++G64fh4ZEJjXQ1V9bu+SfdxeMkFkQlvbfhINwPR2T
X-Gm-Gg: ASbGncs6BsE4wWKOK3MDOyBQtqojVIIINgbVC3+guJXbFCUcXHLgCAoUN32WQHqb2eb
	hEy4aSMJsg8090FNSAX0APVMC7sQ2Yot/T3FcR0lugNNx5ci72B3H+DPjP8SmHrTm/zOggVn+vy
	7kg8FLqpyPDhyaG6lcrriv4c6H22SGMLXniTpZzcw8HEJxheKh5QQIUB/F+X679ZDNT8SSf1jl3
	0cDooOngdmrZTIqoVTzSESrZqSFxTYfuQckJUguSDRZ+1cothClMU4QucBNDUEJqFgZ7JeWeulT
	UwhJnPziZLxgPCYnf7EEqol+XniEvrEn7RVaH/+wbz54ytW8NJ2RlSXAdJJUbDGdG0Vfs2+Fwbw
	SDq+oTML2FhyXfqMbFp5IM79FcmxDT4fQyIA7apfx2Q==
X-Google-Smtp-Source: AGHT+IHpAzOl7PxOE6HEv3Zlp1zcnBNgWCh+Kl2XRmqr57OnEcz8X/TFj6k/1J1zH7+3kBZWzatJHQ==
X-Received: by 2002:a17:902:c410:b0:249:71f5:4e5a with SMTP id d9443c01a7336-29027f3e32emr272696225ad.26.1760320336022;
        Sun, 12 Oct 2025 18:52:16 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034deaa54sm117224925ad.5.2025.10.12.18.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 18:52:15 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] tracing: fprobe: optimization for entry only case
Date: Mon, 13 Oct 2025 09:52:07 +0800
Message-ID: <20251013015209.30949-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The first patch is to optimize the fprobe for entry only case.
The second patch is to add testcase for mixed fprobe.

This series base on the "linux-trace" tree and "for-next" branch.

Changes since V2:
* add some comment to the rcu_read_lock() in fprobe_ftrace_entry() in the
  1st patch

Changes since V1:
* merge the rename of fprobe_entry into one
* add some document for fprobe_fgraph_entry as Masami suggested
* use ftrace_test_recursion_trylock() in fprobe_ftrace_entry()
* add the testcase for mixed fprobe

Menglong Dong (2):
  tracing: fprobe: optimization for entry only case
  lib/test_fprobe: add testcase for mixed fprobe

 kernel/trace/fprobe.c   | 109 ++++++++++++++++++++++++++++++++++++----
 lib/tests/test_fprobe.c |  99 +++++++++++++++++++++++++++++++++++-
 2 files changed, 196 insertions(+), 12 deletions(-)

-- 
2.51.0


