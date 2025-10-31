Return-Path: <linux-kernel+bounces-880746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C52CEC266BB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F16191889AA9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469E52BDC34;
	Fri, 31 Oct 2025 17:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QO6XF6au"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0430A1E9B3D
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761932554; cv=none; b=jwSUc1WPJfGsi08mzlEjtrok8rYIKjMg24mhopyxWWJzkQUwSN81I9KsfYaABiejnpp/zniuGc6RoQyRe67az/6ud9Ro7F4CyeZzOzAEAKdjzFx3UgTdg3Ywf+Fv7+od1nv+UOCT+IHi+hIdF2qwvRRNdOAYTlhn0Pl6XgdvaAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761932554; c=relaxed/simple;
	bh=DYEF8MbETkWa1W+FmO2hraZ9Nh0ThE32WSIYF5X0sVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/vRqRsCnqNYMPnUhpeg6XIhRoSsrlZjLBlp/pT1Gzo3s5bgnm6gA/V3gZtSUCh1Kj8dXx+2hR0X3EjbEvI5cQ5ykgtu+8UlwcYK5crLsQg6eHk0EnpoY5tVp5LocwmIaixzb7w/7jZrsgsbmfBeh+RNWyxakaBujTjuCdSiBEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QO6XF6au; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4771b03267bso17230515e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761932551; x=1762537351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QdJDBEnJpKm6jWCOTYuhfQ0SBELeMNdpfOIkxeoe/+Y=;
        b=QO6XF6auYASGT3E0wDe/HhKPVe5KKKIUJE4K+ZF9V55X9Qd2DU/bLidv+XyfHZIOPU
         RQ+W7PQGYQOUyYll6P/8idNGT8YWXbxt/cedkkqwOKU9hGUVv7evpquTG8FKq3zL+Soi
         DJplxRYULqtzgrNHcKlbPZOgmEL2J6gZ+y7ezxb9q6n7iheSyt2g5RKu5EhfeR8sD8dN
         JWOVAhKMMaytQiXI67JhF6dtjBfAuv+IYEia0YkhYF6XBpuDVXhbhxPEJB4gwq4y8lFx
         5x6bRnM1ZK1XvJkHnsp5SEnbDQ5qhm0rZFC1sm6vhHrliAeeJlvmfUYQMWVbvlYI6TWw
         tigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761932551; x=1762537351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QdJDBEnJpKm6jWCOTYuhfQ0SBELeMNdpfOIkxeoe/+Y=;
        b=rf1wUe41sEfgZwpVODxHaKJVeiZO+ZRQE7VzA3QPb8/7kR8QXFgd5nk/E0ABXXbY04
         eZVArCB0VSfz0BNIU/8zHD9SuOJ03KurRF0QFK7fosLRu0HNqGuuCxN6pQBycAOj1TzP
         0BMQc2PoeOZ8KCih06ScFR/w88RhPJFGIOFU952gRp1ICDLSkZFx1mch4iL91Wg+Ojbs
         u6pg6rRhXKBlqnbhyAGktZdzYV3ZG+2rXANUlflmXu0Vu1lVHFXk9ivtLDyvnDXmiN8e
         1kIrAcecAu+2faFZQN/w+M5OoiwOnggUCNV32Fn88Tm/pLxyZ+gnrCNlZRFj0Rmt8nab
         w3Bw==
X-Forwarded-Encrypted: i=1; AJvYcCU/EeFlLHYMl5YoGZlivFNUHnydRAcn7Z9kAi5AsVvSqewq4fuaxa18xF8aBe1qIo6UZEI5hJLR2otzqpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx71VhDI+eaS2LpBBssjukNWVvfdDG/H2u2ha7nuBw5Ko4cb49b
	Q0JlezArQui18FunSRSZIXtgY8/Nenh/CobNvw459Fy9HHdWoyrn72+a
X-Gm-Gg: ASbGncvjk+sQcWaYPHTnwU3axtjbJgC4KD+TZvDgRXPQIgy9jA4pgCLc+9QqsmMJojz
	wfEc/a5oO6kmsz7/R/rNOj/iMfWzsQqYuTmrEyf9X/QoaTC65cq7W0vL0X1mdwzCraUZABFw0jJ
	xxGdpkduikVf0S+9P0dbs9VbqIlksgOb59q8pJu20Gh7WfFiZwpCqqcrv6iCfyez7BtY+DgiFRg
	4cMWG7NPAdXjXWTMenS+lIRlEguLp4pFNY0rBisD+Vwexj4VSw15Rmio9aazYk2G5KRX6HftvG+
	US6aOXMTP+A3p14876XHH6Z4bWQl4e7RFtbVxjyZuh0J0ae6t80DGrgUK5kHr3h4uybS1Q2HkFz
	t/vQqy8rENMudxLS4Kh2fZfam0feetvN43AUQ0l0Lc6xl373i5uIi1GxwtW92wUBAu1o1hOgbA2
	qKjuhfh4QxwpG5I9nqtBf9vBoMcz7Ch3IdhOxV4st4/qng8l4YgRiRnLeWWlM=
X-Google-Smtp-Source: AGHT+IGAkZg8kAklapkT4C/4gT42mCirvSfZPUgZIn6r0X6eqd/Q4MaOuVsA9Z1qVisGwmh3i9a7ZQ==
X-Received: by 2002:a05:600c:5292:b0:475:dc85:4667 with SMTP id 5b1f17b1804b1-477307c2af0mr46578475e9.15.1761932550959;
        Fri, 31 Oct 2025 10:42:30 -0700 (PDT)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c53eafbsm6728865e9.12.2025.10.31.10.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 10:42:30 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: torvalds@linux-foundation.org
Cc: brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	tglx@linutronix.de,
	pfalcato@suse.de,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [WIP RFC PATCH 0/3] runtime-const header split and whatnot
Date: Fri, 31 Oct 2025 18:42:17 +0100
Message-ID: <20251031174220.43458-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So I slapped together what I described into a WIP patchset.

The runtime header treatment so far only done for x86 and riscv.

I verified things still compile with this in fs.h:
#ifndef MODULE
#include <asm/runtime-const-accessors.h>
#endif

The -accessors suffix is not my favourite, but I don't have a better
name.

If this looks like I'm going to do the needful(tm).

Mateusz Guzik (3):
  x86: fix access_ok() and valid_user_address() using wrong USER_PTR_MAX
    in modules
  runtime-const: split headers between accessors and fixup; disable for
    modules
  fs: hide names_cachep behind runtime access machinery

 .../include/asm/runtime-const-accessors.h     | 151 ++++++++++++++++++
 arch/riscv/include/asm/runtime-const.h        | 142 +---------------
 .../x86/include/asm/runtime-const-accessors.h |  45 ++++++
 arch/x86/include/asm/runtime-const.h          |  38 +----
 arch/x86/include/asm/uaccess_64.h             |  17 +-
 arch/x86/kernel/cpu/common.c                  |   8 +-
 fs/dcache.c                                   |   1 +
 include/asm-generic/vmlinux.lds.h             |   3 +-
 include/linux/fs.h                            |  17 +-
 9 files changed, 232 insertions(+), 190 deletions(-)
 create mode 100644 arch/riscv/include/asm/runtime-const-accessors.h
 create mode 100644 arch/x86/include/asm/runtime-const-accessors.h

-- 
2.34.1


