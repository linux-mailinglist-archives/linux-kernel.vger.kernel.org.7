Return-Path: <linux-kernel+bounces-885332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 415E1C32940
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1F0418C2060
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1267433E356;
	Tue,  4 Nov 2025 18:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="FSq4QcNM"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9274D33E35A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279903; cv=none; b=hjjGePpM4X43Ga8yrkUQlmfNJZL+wpJb5d480b2mKmUhcDbyeRCURJ2JNupiyEFvsvz6l9vUSu/SQz+zxPuueZXUYkmOBGerG0Rn3m4rcShW6LfYypmnQOtnOd9k28YyxsRm4tgpA5Yxhx4bN/wDCqXxzksuj6/tvI6GfgIaWC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279903; c=relaxed/simple;
	bh=1cFCCgqc2is0lbvfRpgrXvG+ymGHU9pnBj6XQ+baNok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Slu9KHtHAS9HYpASsiL/3UghNmcKNo/BoKMjvhEQhXoaQqqwpF3R145JEFCi8YyBT2exyqSpMb8DaBcLO1/Dw5w7D4RJ2Yoq9GkKTN8A3HKOLVg9KX0K4D1z1zTW/DWQBcQnBOYffCUi+ZSYIpQv9IU5sDnhGcAjT44OzThGfro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=FSq4QcNM; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2947d345949so52212005ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 10:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1762279901; x=1762884701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5XyMNNWT21aI21JDXpGCWR0VYrWZpwDMxNF85Gaq7Kk=;
        b=FSq4QcNMKecqRPeI+xtgF8QUwFd3XoB1V7wro2tgbiVU8OsWK465c59/q2byVuoSPA
         WO54TtDsGT91gPsbHPejnu36SSD3/shSW29w16ilUWReTIgs1V35toK3VgAy8KM9jKM3
         Bt0qYzho/D67pIaFAHZgzNNn13OAJ+CFgE4HMTYitb/W9KCH1bFUx0gmGLPf0VwEoRTD
         phFw2Eiyw2ZmKM7dQ4kpMfeUZIVJiAD5eBJOnv0qQliEZ66nexP3b38eMNZ5vQT+i4k/
         oohYnbzK4g5hSabnnxYMv3r1+ZLrNzsQDaggf4rqvXtYEWuf9XI6muILabnep6Z/o71u
         sWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762279901; x=1762884701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5XyMNNWT21aI21JDXpGCWR0VYrWZpwDMxNF85Gaq7Kk=;
        b=J2bHkP2spvQjEyoqvv57qix6Htni/OrWhdcwEJonu25Q806wG2ZBJ2dGoWUAdneyL/
         RXTcxcGyQrYI+lxdyEWjizQFeqkeEvTCKM6H1Mf3KaCr3777rEEiO6A+4H7M43hUK/b9
         +eVs5iI3SDEOrJOGXMmhjQ0jGU/4z2rQ8yDPiY8+oi9ZyVac79OQNtCtJj+mSxaWux9v
         ejauBlWFMqQZxi0zFX9elYKb0MrRcstkZsXHDLRBzIgVzGbdFFh6a4E/Rtxmu6W+20AS
         bk2Utmovu/ZPKA4SL5OY2Y6fR2ItgAUYz1UU8DTz5skTgmKhetLHqdqtzUBwUgNGad2G
         uuEQ==
X-Gm-Message-State: AOJu0Ywuu9zizvMss0oBbnufydFfulwBfJMf0efZ0lBEaYcfSc0T6Joo
	WRxY/LCX2X3FffOR/8D5kKV2EEwKPKdeN5z4+T223bNQiCuPbNu+cY8/HtYQIpSBUOrtIBRLyAK
	f/Yht
X-Gm-Gg: ASbGncsuGCn2mx7mJ6ux6rCWIq2PvWeiui+wQlP6+whawTY9RVrohogvE0CtUrjNLbL
	eYSxWyIpdeM+iJkdLJ0FB+b6twM5q/Gil3PYFqf0+ex6h1wf9jmQ2+ECCrgQR7awFq9kmh0rVtb
	zxM4N9RvwOtOjpHNPEeksCCV06nKI12ns4r3NhsieHAwRV4l0bsq6lXIz3xR5F0zimKfQjyllrQ
	Xc31r0mz8FbUBOSg4R+2z9vJjZGT+NIvIq4QJ9XI5JRF8HZjhUjiSqs/4MUNRF9VJ1iaFe7xKbK
	ZGPuahCjPrcXjTu5ypWW2xw2oMikBtPsU02jQvsLVNc4oFhy9FXz/Qkg9OD+fZ+LBERL3Qskx8a
	6JRxbej6sluKZGWc/TiY2TlvbWnJ7LcDG8/gFYXSb5c4qKEZt8liCNpASRb8Z2qJdoaJRo9yNvh
	lnHQ==
X-Google-Smtp-Source: AGHT+IFtYRJT89UhnVYEUnAx1BRGicUMJ9KT3q6quW0slZVuBcJMxlK4fDIBih8UnkfntDjQIa01SA==
X-Received: by 2002:a17:902:ce0a:b0:295:7453:b572 with SMTP id d9443c01a7336-2962aeaedafmr6364635ad.61.1762279900724;
        Tue, 04 Nov 2025 10:11:40 -0800 (PST)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601972a92sm34618865ad.7.2025.11.04.10.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 10:11:40 -0800 (PST)
From: Calvin Owens <calvin@wbinvd.org>
To: linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Cc: Dan Schatzberg <dschatzberg@meta.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: DEBUG_ATOMIC_SLEEP spew in cgroup_task_dead() on next-20251104
Date: Tue,  4 Nov 2025 10:11:14 -0800
Message-ID: <20251104181114.489391-1-calvin@wbinvd.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Tejun,

The following spews constantly for me on next-20251104 (w/ PREEMPT_RT):

[    1.246079] [    T0] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
[    1.246079] [    T0] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/1
[    1.246079] [    T0] preempt_count: 1, expected: 0
[    1.246079] [    T0] RCU nest depth: 0, expected: 0
[    1.246079] [    T0] 1 lock held by swapper/1/0:
[    1.246079] [    T0]  #0: ffffffff827d0060 (css_set_lock){+.+.}-{3:3}, at: cgroup_task_dead+0x18/0x23b
[    1.246079] [    T0] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.18.0-rc4-next-20251104-x86-hardened #1 PREEMPT_{RT,LAZY}
[    1.246079] [    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-20240910_120124-localhost 04/01/2014
[    1.246079] [    T0] Call Trace:
[    1.246079] [    T0]  <TASK>
[    1.246079] [    T0]  dump_stack_lvl+0x94/0xdb
[    1.246079] [    T0]  __might_resched+0x21b/0x240
[    1.246079] [    T0]  rt_spin_lock+0x62/0x1d0
[    1.246079] [    T0]  cgroup_task_dead+0x18/0x23b
[    1.246079] [    T0]  finish_task_switch+0x1a6/0x295
[    1.246079] [    T0]  __schedule+0x7ee/0xbc5
[    1.246079] [    T0]  schedule_idle+0x1a/0x30
[    1.246079] [    T0]  do_idle+0x1aa/0x1e5
[    1.246079] [    T0]  cpu_startup_entry+0x21/0x30
[    1.246079] [    T0]  start_secondary+0xc4/0xdb
[    1.246079] [    T0]  common_startup_64+0x13b/0x157
[    1.246079] [    T0]  </TASK>

Full dmesg is here: https://gist.githubusercontent.com/jcalvinowens/e1ec1153ddbff10cee5a96ad58f65205/raw/445966a3bfefd94cfca0cd17bcb76c07d31cb33e/gistfile1.txt
Kconfig is here: https://gist.githubusercontent.com/jcalvinowens/8dd543985e25e3d0329339c0d041f1f2/raw/197555de8482a1ffd0482c88dede0c13a42b9a69/gistfile1.txt

I'm guessing this is related to d245698d727a ("cgroup: Defer task cgroup
unlink until after the task is done switching out")? Is there any other
useful info I can provide?

Thanks,
Calvin

