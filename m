Return-Path: <linux-kernel+bounces-869956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B4557C091C0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7780A4E480A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 14:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B632FF161;
	Sat, 25 Oct 2025 14:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1dlaUW4"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103842FE590
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 14:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761403186; cv=none; b=Kfw9l8AVF36ZWTG+MCXhxidtuiGCWfT57xDYyf3EY2TDYQvA19vAZQhmveHv7fsr8XALxxx8FWEBGCnnYM97u1kO4AC4rG5WLJ0S0JvKBeZ/+hUsd8XD7wp19ls8fBR3ZYggIxWuxsnmO17TktzMQHMtgwASGMD2lyLofXWTBbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761403186; c=relaxed/simple;
	bh=d7oPjajSmdHJIOVEObk8SAa9pErxdZxHJm7CUegQEt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bREqrIq6FW8vq/hGy4/G1eFACcwgocOo8DjLTHeOU/qq0J3wVM5fdsF43dOguRKf1PxaaJQYn1hVsbOEFKKBzjKlBqlbQL42bgbDJPoTHvaU0E6BeWnuJHjbYTP8mnanUrtLXphdif79Cf/IlQvc0hf7mnbQax9R8fVvizGU64c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1dlaUW4; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b6d5e04e0d3so467684766b.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 07:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761403183; x=1762007983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dwV1zE7kHbhlnXNUv5Lwzmfyom/MI3+9ZkL549vVBI=;
        b=D1dlaUW4HCIzUk+WHFPIA+tAAPBRdGUqtD7ZCkpHYXCLIgAFgIqStSao359F49GbDQ
         5eUJOO45pHxQg0yPngoJw/dU8hr9SHwg2rsVnn8rfQLCgCCqQe/Hz+3HaGZIZiqLeEef
         CQP7M18PVos62cc5MDDsWryAs5Y81mazioXWjxicjAWf9o4zsIf7XJ89E0T74FYkj+ku
         y7oFCY336ORoQWyfuOJpuRyfDcUt1hj/dVNXpyJqRvMsy2kiIcw/tWGqz4KdXeORG9ux
         DSQYkWTLibd4eLjJA33SI1PpW4zb0hvKzX7SjY0TLSel3CSivQGIUAkLjnLUJgms+fKj
         eeig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761403183; x=1762007983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2dwV1zE7kHbhlnXNUv5Lwzmfyom/MI3+9ZkL549vVBI=;
        b=A1D7/dVdMKFLPZ8Fzo2eHoEQk1NUXbUyk8L+QiMcQPySD+WpNrSIccQzFLYPKEs0Ao
         kIN32Z7sYrfGiZ3EdR0m2+i7rS7Tv8SAvfB0c1djddOxKUzB78vrHc3fSLAtkDOXQ65e
         NK00yWsDg4hl2629qCAUi+yevrnASWqWlvaz0gp4T6CBhENo73S3FNDOfA/QvXDeChh3
         AEcVZU0xdRU4PM0HVce/TRqHY4U0im6406LLqku3P7Cfsc2c6fipYamk3TJkWLTxaLAw
         1PPYgSG38vzr4TdP/ZFzT/1PLsimTYdLRNbZWG468g1TliIbJ174QL5jBEumB5o5oVbW
         oUug==
X-Forwarded-Encrypted: i=1; AJvYcCXpw6B9sWhhRfGUTuEg+PfRIqgWDhPPWDvUipkD46Pwk/E26U6CWWTqhFRdSNnmP0bCq7+EVNzGq/9+FbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwESRRDGnxK85dHI5nXlMpKkxUU5LtfJF1THWmNLr8bVo7A9fqv
	jCZgpH0D+zibfmSSwGg+oTKp+cGyqXu8psIoYN+8zgptyMVpYEltd9ka
X-Gm-Gg: ASbGncv+pxSR8hxy6yWG3R36Peo2SLZWD79MmDZFhk8vVlTmJbvSDS91cK1f9Z2n0ZD
	WpwJLj8st3bpI696G2yOdrXC9GVs09tnCRxCCKuNs7p5oLMWna+n7rqkVjIBUlBJvj8fHrjKcf/
	TEPm3mwRcy+V5L5xHSqKAUhkwioDeqKBIF22VFid6SGFAwX1Q07jUPgDP4OAGRXwWS0krp942H4
	8Ct358At3iwhccarGhce+Ow41H9pHM0Cw2pvSlytQXftI3c393NyQQhJsLRKpyHeFlhOtU+OlmV
	HrC9En9YWFPhZK9/j+ZH4XrYjQvTHSMiRquceRW4EYZmXRcZeQN0dSDuQQ2ZIr6oLRKYkIMDjLX
	P9SoLoROI4S3d1BxAOI8NIlcPJ5ALrpKHv95vdXC4FSZ+lPL6LxjkshrEcBAchc5ejuW1Q/Yyu6
	BWOg==
X-Google-Smtp-Source: AGHT+IHtboGNa5ID1K3C/9/4U53O+54r9gF28NuabONifTJYD+CSQkmxBa1dSwsg8fM2EYeUS1k3Vg==
X-Received: by 2002:a17:907:6ea8:b0:b41:aa62:eedf with SMTP id a640c23a62f3a-b647453ecc4mr2568832166b.56.1761403183016;
        Sat, 25 Oct 2025 07:39:43 -0700 (PDT)
Received: from eray-kasa.. ([2a02:4e0:2d15:18db:d575:9d7b:cfb7:2841])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853386casm213340966b.15.2025.10.25.07.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 07:39:42 -0700 (PDT)
From: Ahmet Eray Karadag <eraykrdg1@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org,
	Ahmet Eray Karadag <eraykrdg1@gmail.com>,
	syzbot+55c40ae8a0e5f3659f2b@syzkaller.appspotmail.com,
	Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Subject: [PATCH v4] ocfs2: Invalidate inode if i_mode is zero after block read
Date: Sat, 25 Oct 2025 17:39:19 +0300
Message-ID: <20251025143918.9106-2-eraykrdg1@gmail.com>
In-Reply-To: <20251022222752.46758-2-eraykrdg1@gmail.com>
References: <20251022222752.46758-2-eraykrdg1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A panic occurs in ocfs2_unlink due to WARN_ON(inode->i_nlink == 0) when
handling a corrupted inode with i_mode=0 and i_nlink=0 in memory.

This "zombie" inode is created because ocfs2_read_locked_inode proceeds
even after ocfs2_validate_inode_block successfully validates a block
that structurally looks okay (passes checksum, signature etc.) but
contains semantically invalid data (specifically i_mode=0). The current
validation function doesn't check for i_mode being zero.

This results in an in-memory inode with i_mode=0 being added to the VFS
cache, which later triggers the panic during unlink.

Prevent this by adding an explicit check for i_mode == 0 within
ocfs2_validate_inode_block. If i_mode is zero, return -EFSCORRUPTED to signal
corruption. This causes the caller (ocfs2_read_locked_inode) to invoke
make_bad_inode(), correctly preventing the zombie inode from entering
the cache.

---
[RFC]:
The current fix handles i_mode=0 corruption detected during inode read
by returning -EFSCORRUPTED from ocfs2_validate_inode_block, which leads to
make_bad_inode() being called, preventing the corrupted inode from
entering the cache. This approach avoids immediately forcing the entire
filesystem read-only, assuming the corruption might be localized to
this inode.

Is this less aggressive error handling strategy appropriate for i_mode=0
corruption? Or is this condition considered severe enough that we *should*
explicitly call ocfs2_error() within the validation function to guarantee
the filesystem is marked read-only immediately upon detection?
Feedback and testing on the correct severity assessment and error
handling for this type of corruption would be appreciated.

Reported-by: syzbot+55c40ae8a0e5f3659f2b@syzkaller.appspotmail.com
Fixes: https://syzkaller.appspot.com/bug?extid=55c40ae8a0e5f3659f2b
Co-developed-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Signed-off-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Signed-off-by: Ahmet Eray Karadag <eraykrdg1@gmail.com>
---
v2:
 - Reviewed how ext4 handling same situation and we come up with this
   solution
---
v3:
 - Implement combined check for nlink=0, mode=0 and non-orphan
   as requested.
---
v4:
 - Fix code alignment issues
---
 fs/ocfs2/inode.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 14bf440ea4df..d966df3aa605 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1455,7 +1455,14 @@ int ocfs2_validate_inode_block(struct super_block *sb,
 		     (unsigned long long)bh->b_blocknr);
 		goto bail;
 	}
-
+	if (!le16_to_cpu(di->i_links_count) && !le16_to_cpu(di->i_mode) &&
+		!(le32_to_cpu(di->i_flags) & OCFS2_ORPHANED_FL)) {
+		mlog(ML_ERROR, "Invalid dinode #%llu: "
+			"Corrupt state (nlink=0, mode=0, !orphan) detected!\n",
+		        (unsigned long long)bh->b_blocknr);
+		rc = -EFSCORRUPTED;
+		goto bail;
+	}
 	/*
 	 * Errors after here are fatal.
 	 */
-- 
2.43.0


