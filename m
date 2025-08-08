Return-Path: <linux-kernel+bounces-760189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A693FB1E792
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 13:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 999461AA5AF1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08382749F4;
	Fri,  8 Aug 2025 11:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0wzk0Nz"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00F126FA4E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 11:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754653379; cv=none; b=AEUoCfG+ewc8bpcFBUAkzMIMrgVNeIXf/22o6CZXc4+TUW99rH3DrJV3//OI5ylz9zL4lcAC4aY22uiifALw49Un5c2J9IXENEWEYrtVRLcp1al+nWrtTsJUzLiULNFp8c+Mlf3Cs8EVkwwF7sWe9B1TS9/1AMarI7XaPl7vSek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754653379; c=relaxed/simple;
	bh=qX+LpjVZh0qEROmGxtkt8MIJA9NuhroZnV9RgYsM2yU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gcFUBNKxAC+kYT+tJWvSV9MvewfzpgnKYJ4Auox892d0DFNE4yTNzuzJK8/ae2V5Aq5mvduGvtXtL7vpSGfVAekyNyiTOzW+lPqDQb6KRJC//VbVuZPBaOWN1fT4sf+ty4T1CmQHxOyedQi6QMVdsHfLi0LAmrOWP9jLyI+F/gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0wzk0Nz; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76c18568e5eso2300511b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 04:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754653377; x=1755258177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o7xUPNwQOFnyirYLWGjYwUUNSfoUAUIHKisZZ79re2o=;
        b=E0wzk0NzOO2KRvt69o7lj8YaWud2+TPPWU/phHrFxad09B0afPFqL6UrFReEgUiIcE
         0zzImXY+cYrDWpAwfQhCOr5TyGJTU06ptGRgTsWyjD0ctxGEyTtem1gxw1hHFUNxgIs1
         UqlKvT+xLixEQ8sSOyGgdwdNDXy/hxNro5xt0g0qGRt38N++F6S15YQnB9mnM7MIE1od
         WpyNQeeg9sQD+qX+cE07BFyRsmoKwTnQgt0gb7+unOKUkEuz4ZPXPrOvhR46RXuePfHK
         pnts2eQqyqtpwZMmEdqgWe+y8ibWdfGEd/vO1EqGZIu17yEDsbAOarYe8qFLot58Io4E
         trsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754653377; x=1755258177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7xUPNwQOFnyirYLWGjYwUUNSfoUAUIHKisZZ79re2o=;
        b=ZdPk7UxVdzPWb23fw5avxK/sMfPfW6+ianxj14InSQJ7TsV3Vsb2d27ifJfCGeqr/n
         4T+pbuoeXdQs6r0OTJZq6QujYCbqKsnJaEWw2hXNIhmWFr5dKPYrjbQmG6ytltEf62l0
         ENwK34K3sfwzFBJ9KUBKj9imQPcPdb7q0MyeSxmKVvdmmskIattwt78w/kjtw3/jiry5
         pQxWtbSd1x+jF6eozHCIitNXlcD2R8C8LXLpaE0qib+43crWxkWYSQeF5aUHciHv6Ad7
         WV0xFTwDTq97qPNkIX8+O56fUCoilaZQh/qyXgH4ipSKuGP/rsjTcnG4tMJklV++uItR
         qEWg==
X-Gm-Message-State: AOJu0YwTZVjTg1OuBpJhhBaztWrGiLvvYVT/jjGfH6CGeTFeS4ysh7ig
	jI4pjDuorzA6cXZ0OqrmFjws2RrmjJXDJNDmgh4xsnikZddW9lUbj3NJPdPfCBfC
X-Gm-Gg: ASbGncsZ4Vh/DZSTs8qhUh9KW0AUbmfw5Y2ZJLkvuM+3ZBceXaiirM5tiT5i2L9YD5n
	3PFRJ3mm4wZaxnTsiaf59zgxKPBDPqaqAjimXZQnPUaTq2WKWE/DiJWjXpYw9gkhlc1GCDP4Put
	VUNzE0bQzA1nc7ojjuTIlkdeYilxvVuBoj6WNiMBooAQiNwYCRdOzRKaCKynRlSn/2Em8dJL4P/
	bT+zoai43OUMVi3Z/8yHNN2p+TzibQJzIaSXaYQdLBEeoRJ6aELSprHIPJUODkXzZRAt7dypaYf
	PP1kYTa8HQ5SYBWfI/JuerYqNpXDuYsdXyhc5VbpxMom3TY0qLZ8zpLBsLWSTVb32J9FQy+f0VI
	8uC6OzeQEK/8kX1mO7vHwY9SIIWaF
X-Google-Smtp-Source: AGHT+IHUrIRgJfgPzn6I/QXdMqQD90NBRHem8l+UVj8ybSE5mceU0ZyoTf8lEnNqqHWX/jkZT8zmvg==
X-Received: by 2002:a05:6a20:3d8b:b0:240:6dc:9164 with SMTP id adf61e73a8af0-2405502ffeamr5164585637.15.1754653376847;
        Fri, 08 Aug 2025 04:42:56 -0700 (PDT)
Received: from octofox.metropolis ([175.223.27.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bac0391sm17217182a12.37.2025.08.08.04.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 04:42:56 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 0/2] xtensa updates for v6.17
Date: Fri,  8 Aug 2025 04:42:40 -0700
Message-Id: <20250808114240.2720491-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

please pull the following updates for the Xtensa architecture.

The following changes since commit 0ff41df1cb268fc69e703a08a57ee14ae967d0ca:

  Linux 6.15 (2025-05-25 16:09:23 -0700)

are available in the Git repository at:

  https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20250808

for you to fetch changes up to 44a4ef59d5506c6dc7599d876a3a1014697ec480:

  xtensa: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers (2025-06-06 01:03:35 -0700)

----------------------------------------------------------------
Xtensa updates for v6.17

- replace __ASSEMBLY__ with __ASSEMBLER__ in arch headers

----------------------------------------------------------------
Thomas Huth (2):
      xtensa: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
      xtensa: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers

 arch/xtensa/include/asm/bootparam.h      | 2 +-
 arch/xtensa/include/asm/cmpxchg.h        | 4 ++--
 arch/xtensa/include/asm/coprocessor.h    | 8 ++++----
 arch/xtensa/include/asm/current.h        | 2 +-
 arch/xtensa/include/asm/ftrace.h         | 8 ++++----
 arch/xtensa/include/asm/initialize_mmu.h | 4 ++--
 arch/xtensa/include/asm/jump_label.h     | 4 ++--
 arch/xtensa/include/asm/kasan.h          | 2 +-
 arch/xtensa/include/asm/kmem_layout.h    | 2 +-
 arch/xtensa/include/asm/page.h           | 4 ++--
 arch/xtensa/include/asm/pgtable.h        | 8 ++++----
 arch/xtensa/include/asm/processor.h      | 4 ++--
 arch/xtensa/include/asm/ptrace.h         | 6 +++---
 arch/xtensa/include/asm/signal.h         | 4 ++--
 arch/xtensa/include/asm/thread_info.h    | 8 ++++----
 arch/xtensa/include/asm/tlbflush.h       | 4 ++--
 arch/xtensa/include/uapi/asm/ptrace.h    | 2 +-
 arch/xtensa/include/uapi/asm/signal.h    | 6 +++---
 arch/xtensa/include/uapi/asm/types.h     | 4 ++--
 19 files changed, 43 insertions(+), 43 deletions(-)

-- 
Thanks.
-- Max

