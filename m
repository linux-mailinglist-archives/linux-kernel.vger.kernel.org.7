Return-Path: <linux-kernel+bounces-855709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C53FBE20CA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54D1A4F8918
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 07:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332B52FD7A3;
	Thu, 16 Oct 2025 07:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIGJbW7H"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B06E23C4F4
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760601322; cv=none; b=hu1Zz5WWnv/vKM5nswVn2+mvwe7aG2clZJlaYq5ZiLYVmek/tB9GI8vUEwJqO4bwv/o6gulJhC51F2POdLDn0A+Akk+kk/YtASI+UGRSmxvdp7mTlckzepyDikHhRUBJbweKazw/j0+6jbygkvjvRjdjRW37qDMc9/QDwAD7VPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760601322; c=relaxed/simple;
	bh=l8JMG+ysDeFr5TZgA8X0KLJsxexULhV0axAKW6Rb+V8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aUcwOzNicD/lxh59UfePYnUBDX0t/kMYHu17a3/jlvo3pUXMWh/tGILfiJb3fh1NuiFHhjy2D9gnWkKZW+bNq0hc24XMPq9+g3MbLNaggOdSNp9m7J7PRO+KqPyFXCPBUERjlc+nSb128cweTPW59MIoA7VXvQaruK+GAoq6Fzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIGJbW7H; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-26a0a694ea8so3421735ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 00:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760601320; x=1761206120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u6tiWu7yuQ3XN00VI86rkfRhwxpMpuXvOvXa99SVFc4=;
        b=lIGJbW7HEceFokdsumJ6iIpSIbFrcm5B8BhR7fmTqUkm9/x6OfB6JRGvdqWlMLkFBp
         UwLxHHHRiQKp9E/bWeqHks752Zgc5snhyZYxT+9zAUaGR8elFVgrGAJ78MPL+Sl9EMNX
         JL1FcQ0E4bGnfsLp/xvl/VSP6KO5MaDhZqIjJbrXDJp5e+G6R5mEmYwVgwqMhaW6Qgh2
         xtUhU6ZKWWcwLOiairHGR0xckrFwReEdgh5Gge7kfYzvAXinqQxbGIoGucxUdH5Am1ZK
         USWXpb7RHu3TrdQKBE8wnosbL/tUKGL3++uiotf4oSXln0YvD4W9YKyrTXMjyOhFWQPe
         blag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760601320; x=1761206120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u6tiWu7yuQ3XN00VI86rkfRhwxpMpuXvOvXa99SVFc4=;
        b=Ia8lbG4kiYO+4AaSNL2y5I+vbM687XHfBc3MKoo1D2+zHsLFGRQmpGbbMzCZoFtAW6
         fRIyNg/DO2RQJii/Ayf7MsnvFV0RvJmnPFwGZysthW0rpMOGzXTVyNsP4iJIikviHQ1s
         bzPCaWBsWiS8rZ7JSy0g1IpwRf7NHajqMQiipBUSnScWtsPFIiw3GNQpxQok25bFGD+X
         qod+A44y/8nc9EvxfLZPKBwz/Be4rwtp+5N7D9btfI4stGbE7or+/pGKUxyRaQhZZ5GL
         YZaJqTyCZJKs0bRjjUFgB4TV00Kjl5cXkSfMlNqnyTYe1nvLEnEIu34heVILKhZU41k/
         Xh1w==
X-Forwarded-Encrypted: i=1; AJvYcCXeHO7z2ewlEyyqgJ5z+U9zRfKdelcAJP/cuAjWi30DCn8JAI5tIrRCU7+yBth0arjcS2FF/YQ6y2aCOkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YySEkxRTlVgGvQxZndoKZrN/WN29i3CQRCxwjydzHB6liaaviS/
	yrs7MzONbzB2s/6XeJg38bC/mSsE7620IYIVL83xvMIB73EGf3C6hRWJ
X-Gm-Gg: ASbGncvxK71cOUimvTFHeaXpqA3kKSNYOowDarrjh462p+DsyIshja47Ty1ph/kWBlZ
	yAS5zwUOXQwU0W0zVBNLVnn0JJ7nJojeYmwM0ZleYtNIhwg54sHGp3xEG07RW105fOGU6xzyEHw
	oqxvFED+6AmBsaCEUbEHgiauYxzDCS3HuBUYCrw4FVhBYN3Gyb2czz/mP4KY1LLGqfUpQURuJt5
	j3LbvQdIklPxlOwPBVDrfDUBnUKFylGirxX2E2C2s20mxt9089ZwJY8KcvYP6p3HyVM7oNs+UYu
	l26EFiFOB7KgrCnm7nrNyYNY9RRNtekP0cTvyjaqCo4Yw7mzA0I8Mlsw0ESzm53JWaRwivMhPRt
	/iHumOV6CLZNSZyC7Yohw7IUsobmeZJKQhL+jXNcgaMGnUh94aUpRo8x5HWSaBpgLufYdDAI589
	+Us0w=
X-Google-Smtp-Source: AGHT+IEo/63Yi6BDxpvQRpnjxo8HKcEDZGgx4k5ciYuENj4di6XHI29o7bd4su5DW6K/ds9jybazWQ==
X-Received: by 2002:a17:902:ea07:b0:290:b8c7:e6ee with SMTP id d9443c01a7336-290b8c7eb5amr6060835ad.55.1760601320330;
        Thu, 16 Oct 2025 00:55:20 -0700 (PDT)
Received: from pc.. ([116.177.28.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099afe0aasm20263975ad.111.2025.10.16.00.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 00:55:20 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrei Vagin <avagin@gmail.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] docs: scheduler: completion: Document complete_on_current_cpu()
Date: Thu, 16 Oct 2025 15:55:07 +0800
Message-ID: <20251016-complete_on_current_cpu_doc-v3-1-8ae5d346ea45@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20250702-complete_on_current_cpu_doc-94dfc72a39f8
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760600878; l=1679; i=javier.carrasco.cruz@gmail.com; s=20250209; h=from:subject:message-id; bh=V8LHqLfTQM+om9jJqbfR5TNDEnoucqEKULLH17WOmVs=; b=nB9zaQLTD8o7SLsyK5sIzt2yQE1oWj3q71Q8W9uDER1H4jx82nU5tqkvfbj3jLZl7ivgRQGor AidOK6vTlTRDa95nV/TumgNHNZpvjQrBCfuj3nL8ZmC9xDWGKkbbP8I
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519; pk=/1fPZTF8kAIBZPO3D8IhqidB0sgYzPDkljBZXsXJZM8=
Content-Transfer-Encoding: 8bit

Commit 6f63904c8f3e ("sched: add a few helpers to wake up tasks on the
current cpu") introduced this new function to the completion API that
has not been documented yet.

Document complete_on_current_cpu() explaining what it does and when its
usage is justified.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v3:
- Rebase onto v6.18-rc1
- Document the scenario where the gain is relevant (Andrei Vagin)
- Link to v2: https://lore.kernel.org/r/20250824-complete_on_current_cpu_doc-v2-1-fd13debcb020@gmail.com/

Changes in v2:
- Rebase onto v6.17-rc1
- Fix patch formatting (drop --- before the Signed-off-by tag).
- Link to v1: https://lore.kernel.org/r/20250703-complete_on_current_cpu_doc-v1-1-262dc859b38a@gmail.com
---
 Documentation/scheduler/completion.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/scheduler/completion.rst b/Documentation/scheduler/completion.rst
index adf0c0a56d02..139700c56964 100644
--- a/Documentation/scheduler/completion.rst
+++ b/Documentation/scheduler/completion.rst
@@ -272,6 +272,11 @@ Signaling completion from IRQ context is fine as it will appropriately
 lock with spin_lock_irqsave()/spin_unlock_irqrestore() and it will never
 sleep.
 
+Use complete_on_current_cpu() to wake up the task on the current CPU.
+It makes use of the WF_CURRENT_CPU flag to move the task to be woken up
+to the current CPU, achieving faster context switches. For this optimization
+to be effective, the current task must be about to go to sleep right after
+waking the target task.
 
 try_wait_for_completion()/completion_done():
 --------------------------------------------

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20250702-complete_on_current_cpu_doc-94dfc72a39f8

Best regards,
--  
Javier Carrasco <javier.carrasco.cruz@gmail.com>


