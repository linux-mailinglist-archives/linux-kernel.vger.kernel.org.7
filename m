Return-Path: <linux-kernel+bounces-900098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16879C59979
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 20:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B0FC3B5266
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 19:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B822FDC39;
	Thu, 13 Nov 2025 19:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M16P93fY"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD47284684
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 19:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763060496; cv=none; b=IRjFCo8aFKB5rrMDnT9JDYrb9K6Efw9DHmrQ5orhpfl28eg6X8FmnntTGDpKnMPuPP9sEvgfTPd19MWzNP4uy2TKLd3r6bZd/U0Fvkhw7iR6LFwU93rONuPZGBsiG0BrsHo9vNwkr8G2tbLrSCOhQ5k8PkcDPp5susIpLFbJWSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763060496; c=relaxed/simple;
	bh=fID0wlKsgbuZ7rLqJxq2UYo2wKKAiX+fNDsl08zChrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJfdknTlAbLtCE9p0HXTzJIsFx51ziw6R/P7MQ0Ei5aJ0oq9ALvjlpMJQ2yfM0x+TLXgc52pQiaaA6MyvSWwIdRzeH8o2eJK/jKRALacYQH15pKUdEP0T0MHJGJcOhJ0bXVnNs5cXT9oTGRH4ofeOOriaRTFGAppzRVWz01Fdzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M16P93fY; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-88f2aebce7fso107137185a.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 11:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763060494; x=1763665294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUv3ig7gKTZiQnNq1vm5mpP4T0fDG8gYNVbuktfcpJs=;
        b=M16P93fYqBW0HSJJ5ZDgb0J2jgc33AuupzxZ+0eI/Mj7lM5Bg/lEvnqI8THjUDpVjR
         mvTo+Hn9csS4l8irzH1evv3WCcP2/ZVciBhe0k3jFf+A0IZJLJSusCtu/OE5/XvnAuO7
         c6RCW6xFZGHp7wQGh+t/EGGYCboZY6x/8NDEtlEW96RLFx4D+M7BQZ42Y3i8q6c3oHWs
         CdIc+8IcGZruHpInXz9x9aJ3DARMpBbwGVY1ZeV7aSxR8DE3GfXUsNNg12Mr/EzXzR3s
         h9msI7fZ0CoupEgs4SVHQWMlQWDi+wIQT55sxF75lKF+WS1PhQIq9VpKbTZqLvTEQmxY
         imuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763060494; x=1763665294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MUv3ig7gKTZiQnNq1vm5mpP4T0fDG8gYNVbuktfcpJs=;
        b=pH+/kgwREnuWYvkF3txZAoScaN9kY0wESFqYql5r1sZkPWVlh+q9K1XqomwD+5hplP
         5DOFs8mGa1mNGXyHHNGvvA/Ypoy/lfMScRJ1z7eaGcxJM+DmD2Pmf+7WHP2nf5J/+ZRo
         Dsh81WfUozhRiVgMNWQN0TyE7C25FxionOIeAhtYa1QkOtWKdL1rAgnM2KdM9ThCCZWc
         FVYdqaAjdPuB5e/lye6BNbPyJOirz6+bsDT4tQ4y0e2Hb7vmAHhEjVkDVHqjCJezZDw0
         ec+z5Q/BcQyS7FLXl/2rfNY3jegDxOVyb3ByGwmfFNmZ+JMPvaPlEgHuDQWIr0Q3Lbn9
         s2kw==
X-Forwarded-Encrypted: i=1; AJvYcCUGKN5D74zR9ZaRDN2q9tTQ37YzCn91k9Q1qICkdAgXj8WqECQcxNyt9UvKZq90uSyLIa0OOqAff8w6UTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXXW+7oghK/VxrpluO8ocVZ2m84o4C83SVKB5g4Hoa5ZF20lsZ
	9J6UrPGBqCCpDYkF4ave4Veu+zuK2WlP+/rcwWAdo768ZJ6T/hyMa6Ay
X-Gm-Gg: ASbGncts1jh3xwuNA895M7nIBHOZWGXDiOPqP/TnsuOhSjaNdjLDrgkKJn5OZmQOxV4
	YjXrUtqtJEZfH4RJZkW45865MM+2FbH7yEWzHm5ImFA2BYTgMZaPASufxgA01BZDCVeFdqGEYkY
	1ZszJfYy6SRPAwkXMCTUfNQd0ZuQyIMruDPFagabdwe0oUX81/hX/XZfIwfd5HkWMZTFRPwzle4
	4MNyydpSa37+WP4LPj+klo2OZoeIBfbwI7bkHa+0rXqf9pxfgcagSwPQG7JoZdq8QW1ZkvY7feE
	4tR7O3iYYxjRDUDDt31WuWI69pH32GaPMTlBcKI0Fm3cBwyEm6ThDYiG7OYSi/hkRuI7c7FFKyR
	wmEBA0/mX7VwWvJUY/FHknKUSMSwJQv3J7j4RaLV1rOtT68RCWXWch83TQhxtCbzcZgGgiJDEtl
	14HVhJSwYjk/lYSnDWHvB9+8R19fFtlNg=
X-Google-Smtp-Source: AGHT+IGjX3HXqOY5exKe57ivPtKqQ/8qdqdt8a/LEsPU4MJgln+dlHP9S2HThtsEQtvScJRygs77TQ==
X-Received: by 2002:a05:620a:4614:b0:85c:3bcf:e843 with SMTP id af79cd13be357-8b2c31b46d8mr51876485a.43.1763060490083;
        Thu, 13 Nov 2025 11:01:30 -0800 (PST)
Received: from rpthibeault-XPS-13-9305.. ([23.233.177.113])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2aeecb087sm187043085a.26.2025.11.13.11.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 11:01:29 -0800 (PST)
From: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
To: cem@kernel.org,
	djwong@kernel.org,
	chandanbabu@kernel.org,
	bfoster@redhat.com
Cc: linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	syzbot+9f6d080dece587cfdd4c@syzkaller.appspotmail.com,
	Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
Subject: [PATCH v3] xfs: validate log record version against superblock log version
Date: Thu, 13 Nov 2025 14:01:13 -0500
Message-ID: <20251113190112.2214965-2-rpthibeault@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aRUIBj3ntHM1rcfo@dread.disaster.area>
References: <aRUIBj3ntHM1rcfo@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot creates a fuzzed record where xfs_has_logv2() but the
xlog_rec_header h_version != XLOG_VERSION_2. This causes a
KASAN: slab-out-of-bounds read in xlog_do_recovery_pass() ->
xlog_recover_process() -> xlog_cksum().

Fix by adding a check to xlog_valid_rec_header() to abort journal
recovery if the xlog_rec_header h_version does not match the super
block log version.

A file system with a version 2 log will only ever set
XLOG_VERSION_2 in its headers (and v1 will only ever set V_1), so if
there is any mismatch, either the journal or the superblock as been
corrupted and therefore we abort processing with a -EFSCORRUPTED error
immediately.

Reported-by: syzbot+9f6d080dece587cfdd4c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9f6d080dece587cfdd4c
Tested-by: syzbot+9f6d080dece587cfdd4c@syzkaller.appspotmail.com
Fixes: 45cf976008dd ("xfs: fix log recovery buffer allocation for the legacy h_size fixup")
Signed-off-by: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
---
changelog
v1 -> v2: 
- reject the mount for h_size > XLOG_HEADER_CYCLE_SIZE && !XLOG_VERSION_2
v2 -> v3:
- abort journal recovery if the xlog_rec_header h_version does not match 
the super block log version
- heavily modify commit description

 fs/xfs/xfs_log_recover.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index e6ed9e09c027..b9a708673965 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -2963,6 +2963,14 @@ xlog_valid_rec_header(
 			__func__, be32_to_cpu(rhead->h_version));
 		return -EFSCORRUPTED;
 	}
+	if (XFS_IS_CORRUPT(log->l_mp, xfs_has_logv2(log->l_mp) !=
+			   !!(be32_to_cpu(rhead->h_version) & XLOG_VERSION_2))) {
+		xfs_warn(log->l_mp,
+"%s: xlog_rec_header h_version (%d) does not match sb log version (%d)",
+			__func__, be32_to_cpu(rhead->h_version),
+			xfs_has_logv2(log->l_mp) ? 2 : 1);
+		return -EFSCORRUPTED;
+	}
 
 	/*
 	 * LR body must have data (or it wouldn't have been written)
-- 
2.43.0


