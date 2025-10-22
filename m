Return-Path: <linux-kernel+bounces-864717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D008BFB667
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2153E58331E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1B031A7FE;
	Wed, 22 Oct 2025 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RrjXdSUG"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70492D5A0C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761128785; cv=none; b=IjC/m9vJdnDX/Nj0YrlCvJzgyyvVd78G09DTMhDx7Zn7x7gSzYVfbtwoWf+MwCq+Y67zZ8g0iusHssg7RGGeOmGXIO2WiY+ZgW5hheTEuXfcm+7DVGyD+ivblHud83CFHq0aWx6Y4QzIMoP1lt1EqglezlAtNpqvTokIruhN1tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761128785; c=relaxed/simple;
	bh=CTU6J0E4iPLfycSwmSoKkd16tZrL3tGx/EZZtBzj4n8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c14CuRPZIljfFewX4k0Pe1yqcsITq67k8Dh8Qroc1zv51VoD3jOQjfIXHiB69RYPgI4Dj5bEMWkpURIrjIOmc2NEexco4i1uWBjnIF023QcwJuoCl5O0ng7QYPYg3DnwVMrov1XHcxOaDpmmFeSFZQ01xgIn4n0g+EnvDUdYXyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RrjXdSUG; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-427054641f0so1014302f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761128779; x=1761733579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cLHXU8eawHTVYbg2TRv1FG2In4KNx8EMpgeXSr7poJY=;
        b=RrjXdSUGRX/PzVE4nAgWrFHhEvv8AN+qrj8Chl/j338SjEge1IUGsFYOOY/kAZmbet
         MWPuedwO15dHvelsYRKysRtPEE4hf+mXoffGf8IVFRfvKRk7Kv9h0PNQip4kjx4yQMs9
         ffMjRiJcWIZgOxluXjgp7QTtCwcIhNF9Cp96tXgSzL3JOxp/ZQdzI6E6ttNBIWlC/Pwi
         ul/3INp/0OK2sPcPG2G97ItZzaihi4MndoL6BVM2GKgMHhw9vDqBWU540MBBktY6vvVs
         F3YJre5Vt/v4PIle1RsIEK8EmsxOwC+dQf7EFtp/rIB0R7yJW8vmxpAw/KQhZ7F/4PYG
         JUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761128779; x=1761733579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cLHXU8eawHTVYbg2TRv1FG2In4KNx8EMpgeXSr7poJY=;
        b=N4Rj70QNHgijuB0kR60l0vpnUNvy3vUCtXefSQQr7ylvUxLS9MjflQHhIFkAvySdR6
         F2SggBo0ZAr6wBmQunIp0Vl7LuXxx00EBUqv7njA2q7+ceAGbtwY9BA1a9BxakGgghCg
         ir+myHm62Wsyt6h/QF4fStgeMVhkIm5D445iSzwJGGjbi//1nDSei4k5Khu/WJ2m12Jq
         jb4fw1jA4yCkr+yDfw3Eh2w9FTkCnyOwrQ65vChw95M/HdnFluWzj30lkyWau0uyX/Y2
         xI7Nem6mC2JU43QcU598IyNAJxlPcJjLhw//8dnTIyVaBfOmUNLAUv4d85Ziv5jnQxNh
         WMEw==
X-Forwarded-Encrypted: i=1; AJvYcCXKcPxD3kM2gQkhdf7NdK5bhi1Vr9Z3OsiiA66k6NtoUv1o6OSKPB298k9Fh0NXUc0u7/yvX1sxOnNNaQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFn6Sm9P7+mOBx+EJFrxx+q+IheKhp5/UHiHSqTZnr3enE8qh1
	4PmqmNtET7pgtQMAiXGCKgCNgtmcPLT5OAuvAWY3dfuH8L2CAMmz86/+hNbfydGEc+Y=
X-Gm-Gg: ASbGncv3YpebPkc94LS+bVchYjj+XFxNtp8jbWwjjzfc+DQKl61FNftbCc/yzMVROad
	1C47PSK0llkqtbhO0rNLbYS2HeDB0gypiOPq5adKj5GX0LRc9yd3UUK7IKnKWpNS6DwzpRAeq0U
	Uxru9b1g322etLk0q/8iu5tWuTHmbADlNbGJGIe2be7oyZsogcl9rJ7GCKnD2hkPzruhS4bKOA0
	g7A6GDx5wklxvvGMoXcZuMAk+60adPvv3wCLyuVLeseGdrSAIoFTRSQCp7/RgXwpPTWfvZNRQPU
	/5LJwa+6/+p3E3oLJCp1C7Y91N23OMRHx4icLORsumDM63lUVlnIjz0/d/9+x+9HWhYZXccU4Nk
	LwX4vnYsuQfYZ/Wc0FFWs06QM2n8dJoGStf9j7aHc7pvOoysygugvz67vlXrOjR8kc7hh32mEL9
	kcjWIurFphiEZgnqHSosYVg4mrsfY5ZJbMD/Gr1zxaR1jIQ++B1iGIKNUu675q/1vF/HnC3KxSb
	LqpgA==
X-Google-Smtp-Source: AGHT+IHihH5io6lS5ZZp9KLrAwcTOUq892OvQBG9BS+AmwUsIzbx8SjZ+4yw1mBJvVKnsFy5ydtF1A==
X-Received: by 2002:a05:600c:1ca9:b0:46e:2562:ed71 with SMTP id 5b1f17b1804b1-47494260568mr33388495e9.1.1761128778718;
        Wed, 22 Oct 2025 03:26:18 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-475c41cc92csm37137625e9.0.2025.10.22.03.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 03:26:18 -0700 (PDT)
From: Petr Tesarik <ptesarik@suse.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH v3 0/2] x86/tsx: Improve handling of the tsx= kernel parameter
Date: Wed, 22 Oct 2025 12:26:11 +0200
Message-ID: <cover.1761127696.git.ptesarik@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse the tsx= kernel parameter with early_param(), so it is not
reported as unknown.

As a side note, it was not necessary to defer the handling of
tsx=auto. Contrary to Pawan's claim, cpu_set_bug_bits() is called
from setup_arch() via early_cpu_init() and early_identify_cpu() before
parse_early_param(). But it is a nice cleanup, nevertheless, and I
learned something about parsing the command line. Cf. the NAK here:
https://lore.kernel.org/all/20251009185134.fb4evjrk76rwxv37@desk/

Changes from v2:
* compile-time initialization with the configured default
* defer tsx=auto handling to tsx_init()
* add more detail to the commit message

Changes from v1:
* make tsx_ctrl_state local to tsx.c
* use early_param() instead of core_param()

Petr Tesarik (2):
  x86/tsx: Make tsx_ctrl_state static
  x86/tsx: Get the tsx= command line parameter with early_param()

 arch/x86/kernel/cpu/cpu.h |  9 ------
 arch/x86/kernel/cpu/tsx.c | 59 ++++++++++++++++++++++-----------------
 2 files changed, 34 insertions(+), 34 deletions(-)

-- 
2.51.0


