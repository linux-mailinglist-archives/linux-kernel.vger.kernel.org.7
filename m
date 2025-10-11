Return-Path: <linux-kernel+bounces-849173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB5DBCF56C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 14:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7A7F425C02
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 12:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D49027A913;
	Sat, 11 Oct 2025 12:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7Lnc1GP"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350F42749C4
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 12:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760186905; cv=none; b=nrNvEBAbbjD41GP7+4aUr6+stLDRgwyy1nHNaNrVWJUkto+65+BxnJycEdV3yilT2YNagPU/SRVuk9T1vcxLWXN9zxgbmvNhwAygJLK/kv9ewwl23SUU+4BUizhT+7BD7hlNCGXQUN0IiG8MbqpzK1M+5LAZ2Lm5/tZyj/XBBg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760186905; c=relaxed/simple;
	bh=wKDRPB+KqxhBLbV4INClCISUtnBvDGHffmLxKWe/X/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eHd/yGAX6oUgqTkZ9zEfPaBIg94eu5y1aFKDHXpEZMtV577rQ/cYOzgvr0u1Bz24cdTx3bgbkMBp7/j16+/VtBgkodfMzNu5amkZBlIp1K4g+Ld/wZpFenrsX3zxCFVxhNgwCXT2LxAiAhs7BuvAwmrMAQgc/VmJw0IoP1Q6a2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7Lnc1GP; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-78af743c232so2680090b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 05:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760186899; x=1760791699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KUrz9mfP2/UVFTP3pLZz1z/dWaHESIrswLrRZ6jBbZo=;
        b=Z7Lnc1GPO1ZImYtmoantdg6dR7TwJym82k2jBITbAse09U+hukv3Rd046c9mNLHGdQ
         fIKySPFAg4ucRmO1caGJU2VtfTUgT5d6Kt5EETn4Ow9BC+H0UqnTk/ZXerAU+gxEAdCe
         BUuU2Vl9lgB1j0j9y12m9MZIIOsi9QpZ7g41t1O/7f8m+ejuK/PQLap3+LpEEDzAa5En
         uclLNMrLsB1AGxD+w8ck4DgulTJI9de0tHcT8jOExPv1vvkgsQ5ugMqOhdy8NVyDwnur
         nmHPqYtXF7UaPFoyDZPqGDj+yQVtYFvvEFkXl2oWWJClX7ktKb/1S/W3M/zbS/hAk3mZ
         ZJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760186899; x=1760791699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUrz9mfP2/UVFTP3pLZz1z/dWaHESIrswLrRZ6jBbZo=;
        b=haWIR+zHWEd6gxY7kUHewAeKBhCSHSl9yYm0v5NLM6NPiivU5OX/Ix9HeZ6qEbSmBv
         gADwY4jN9fgpR88wVyCKQNSh/zJsswA9h/CAQTNJvfQA8YsbG7VZ1LksLpgxRqh+30hK
         Ji2MERj9FWDS6qKFLGHPbfglaKB79uJGjsiUxogak4NHTs+16512goEr3L6sByMi1XtU
         xQC8XrG/M5oMuR0Y4YUl3Gqh3NFvDy2afZ7DNrYEqFZX690eUFQ/56cFSQSby1I5lPqs
         /xaM8K+5wFBy0chP74ZmN6hSvW4V8vDMhEmQOiqpwavZpHvnAOvi5tk+MdK9s/flZJ2Q
         OP5g==
X-Forwarded-Encrypted: i=1; AJvYcCVe8tpaMzejyNvPdgv1xhQdVdFNHyM6nr8Yx9V6Pseq14mHStemDd/wwO4ZIjzsXi3FhhwSYyMWVk9WD/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm9NKlzHldAR9AhULpKobbbVDxaY0rqKAf4mgw5PfeqSQBkZhe
	57JIMegKAwRRfkMht+zA+PSKmahFMP8HxvrnrQiqABNhEZq+196P4sy+
X-Gm-Gg: ASbGncsMyOUoIhKzkARRNUOGe/J3XGUCdiQfeX/4ZBQ74e5415lC1QGWClYYPcKoB4v
	1cUU7BnmZYevp33ny6fCHkBE0egoaNkT1jvcylPSt+Exbm1MDKqP21suEOKw676aQbYuIOM8Gzv
	0Ror60tKM6vsk7ZJj8LvG9itEziygo643lyES/yu9Onm3+e87/W4/KthBI2unz9QNH+GQjXAXff
	ORd+8TlAZKiM8JeC5gXXJ70hYevObVDy8KDhdf8C2n9t8oqO++SmWICEk/6eKOvCGJwMlAhrLIA
	t1PVdA3zel1Q5mDE9/xGi14hRj4Gt5PIVxN4r4H2FWMSXeFtgoreJ6WKRmwHd6A2SbYLQBDYcL2
	/IzXPyAia1QAQzNUGX1yO27K3eS/La9EkdubUDtYFdA==
X-Google-Smtp-Source: AGHT+IH7Br2JzyE3bmK9+lKTtojZQoTDoId8Oq0ndIJvD53HoZxE1Y2/BJoOlWGDJVc+ySXC99ZI1g==
X-Received: by 2002:a05:6a20:a10e:b0:32b:70aa:a1d9 with SMTP id adf61e73a8af0-32da83db26bmr20885269637.33.1760186899262;
        Sat, 11 Oct 2025 05:48:19 -0700 (PDT)
Received: from fedora ([2405:201:3017:a80:4151:fa75:b28e:228e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61ac7af3sm6246199a91.17.2025.10.11.05.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 05:48:18 -0700 (PDT)
From: Bhavik Sachdev <b.sachdev1904@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksa Sarai <cyphar@cyphar.com>,
	Bhavik Sachdev <b.sachdev1904@gmail.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Jan Kara <jack@suse.cz>,
	John Garry <john.g.garry@oracle.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrei Vagin <avagin@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: [PATCH v2 0/1] statmount: mountinfo for "unmounted" mounts
Date: Sat, 11 Oct 2025 18:16:10 +0530
Message-ID: <20251011124753.1820802-1-b.sachdev1904@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By "unmounted" mounts we mean mounts that have been unmounted using
umount2(mnt, MNT_DETACH) but we still have file descriptors to files on
that mount. We want to add the ability to handle such mounts in CRIU
(Checkpoint/Restore in Userspace).

Currently, we have no way to get mount info for these mounts as they do
not appear in /proc/<pid>/mountinfo and statmount does not work on them.

We solve this problem by introducing a file descriptor parameter to
statmount, along with a STATMOUNT_FD flag. Even if this file descriptor
is on a "unmounted" mount we are still able to get mountinfo for the
mount. We report the mountpoint of the mount to be "[detached]" and
mnt_ns_id to be 0.

v1 of this patchset, took a different approach and introduced a new
umount_mnt_ns, to which "unmounted" mounts would be moved to (instead of
their namespace being NULL) thus allowing them to be still available via
statmount:
https://lore.kernel.org/linux-fsdevel/20251002125422.203598-1-b.sachdev1904@gmail.com/

That approach complicated namespace locking and modified performance
sensitive code.
See: https://lore.kernel.org/linux-fsdevel/7e4d9eb5-6dde-4c59-8ee3-358233f082d0@virtuozzo.com/

Christian also talked about a separate approach of tying the _lifetime_
of the mount namespace to the lifetime of the unmounted mounts through
the passive reference count by moving them to a separate rb_root
`unmounted` in the namespace instance.

This approach has a few problems, some of them are:
1. It further extends the scope of the namespace semaphore.
2. Weird to be able to statmount() via mount id if the mount namespace
is dead.

For a more complete description, see:
https://lore.kernel.org/linux-fsdevel/20251006-erlesen-anlagen-9af59899a969@brauner/

Aleska Sarai also pointed out that this fd based approach is similiar to
the fstatfs(2) which returns information about a mounted filesystem when
given a fd open on that filesystem.
https://lore.kernel.org/linux-fsdevel/2025-10-07-lavish-refried-navy-journey-EqHk9K@cyphar.com/

We use this patchset with CRIU to support checkpoint/restore of
"unmounted" mounts in this pull request:
https://github.com/checkpoint-restore/criu/pull/2754.

All these patches are also available in this branch on github:
https://github.com/bsach64/linux/tree/statmount-fd-v2

Bhavik Sachdev (1):
  statmount: accept fd as a parameter

 fs/namespace.c             | 80 ++++++++++++++++++++++++++++----------
 include/uapi/linux/mount.h |  8 ++++
 2 files changed, 67 insertions(+), 21 deletions(-)

-- 
2.51.0


