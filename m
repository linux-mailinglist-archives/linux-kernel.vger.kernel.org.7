Return-Path: <linux-kernel+bounces-849729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4D0BD0BFE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 22:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EA114E2DA1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 20:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B81223DC1;
	Sun, 12 Oct 2025 20:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4YsPRcw"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A374221282
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 20:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760300282; cv=none; b=Zn/xlNcOUoQcdNBuTA32NZBLofXXKrlw6ws9UdpPRKOtxIWhkvRReWElhWzTb4rnluKcZrURKqSWE3qK2ueyrlUUlL0HfYJAtjRCW+0Epjn8p8WRAYvFuv4c8Do1j65fFQeswj+yhBFjohLvJS+CUwb9GxVJGf8g0Qx4dyeA7zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760300282; c=relaxed/simple;
	bh=7TgWHHpxv+HeA3DLK127FYyUNPx+CBHJ6cbxxBcbkzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rj07GjfGIUL70EugtAfbyzzSbUsOUzQ58mcDH1k+KFwzNGVp8DEDCYmjtoEBGIgLklDIp8kggnj30w+uQWfQWrVzHSJOq0cdjppadt+xT7sFCZ9NbB3ms1PnJ+TSGY63jwoUHvcdtZNNzLJ8QujAtX5JVYIgS8RRNL4EkUDIo3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4YsPRcw; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-87be45cba29so4687586d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 13:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760300278; x=1760905078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EfJd41GGgbsw5kea6lHDnwRMbxMS1g92zUpAQvrRa8w=;
        b=M4YsPRcwmuMAfc+Ar2F4Ir5LKZObPjhSaXGggbHVIN4vKHD6zQjFd5d9Yu9tNuAEmR
         Blqs+dSCM27EIhdE356iO7fLeoDeaCsXCQ3M1rZcyizAlKwxyHMiJ8TEt5Bgb9Z9yk4Z
         CwaCFsPk+TuShMp5LsoewI0+2Ep4VJaoFvZvtPhQBbaWg+7bcXKvZpgE1hY8u5n7BYVT
         U/XJcxTIITUnEzglSB0a75T+xdkTr+xOgdpeyVAdwdwdJ6LYrtqyTbgyEQ2i7WPUfPJp
         CRqch/zCeXRtjfhgjAbur+zVvdZLai0nV1O1GIkAybrf9ZmARvcd4YuegyT7tuiBXgLi
         RK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760300278; x=1760905078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EfJd41GGgbsw5kea6lHDnwRMbxMS1g92zUpAQvrRa8w=;
        b=qny+NoQHAOcKziNepXIVgeeEoMobPAb/0etWxG/G1Jkt/GhSrK2/aqZcOH+ZL85za9
         k6HMG10WXazMLCyDd9Qo9v2ixDC9HobJ74riCm661AJ2YBsEzoA5BWhfqC9rDS1TsCSl
         JZ3c/eAWohqCGV5jjCAnjELTfGiAWRNUN99zGDbdDO82bH/Ovi0ovA9qAaXM2aiXIOde
         /GBbmvIOQMVPFGLm1lPpZEMQMlbkj6fnDVeIlBiJUT3A/Eqx81ynGb+yoAT9rqtwk9Xe
         NNPeWnMeHGbBen+TERAaJsnIf1kuyCR4/cmSXeXERYnwxd93wsBrGjmZcoTT47xdcXcu
         HLCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVdRpUOGDSc/NO7SwuZjZoUdyL/Zqjrbe+uabA6fjzLd8J5JeiUpss4PUga4RFDFSTvVyYJ2IbpclFu1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTk11lHeC6JcVSjufKEcXmPwPosDotgao94DULD2S1iXFhgChO
	H1w/ZMvR0vfcu55VMPAgZgJAWz5/8WYz0cu5/OexLkD9FNmO8PrR5Z71
X-Gm-Gg: ASbGncsbUEnbLZw1kEYHDjOwQ1k/Ow3Qzcx8k+TjSCcMWolIqe0//RsFjlcvX9XUDJt
	sP1vbksMcGF2gK2m9I5qhbod13Am4VC5tPnpznnbF2Fcb6oY6gdfcG8JIWXtQfV+NpBM9uyNTbz
	iWssNr+NThqSpMILJKRTLmgzNIjJQ098EcQ0tFIApGJHsdf3H2Kn5fyf+xRAZOR3RYRJexTmwZR
	4UK0ItxJ3FptE+dbSsxcOcdTGy2L0oO8c2wBMn7sBC/hKRCft8Axz2hZMjZsD069jHNvHOTRucL
	epL877Uwo1kSu2fN5vR07NQ7K9VuJy6Z0D+XdLMQgmr74tiQfpBFPX2ZTbkYlweP1QBfE6XOgYI
	D87ITpSg6EqoWt1dl1SIKxuCgs5hyiYgtOvbadikUhUWwxr49d1M8rBToN6dfyLnoZF601Tci
X-Google-Smtp-Source: AGHT+IEXNZfIsQ3rZppSYl9yKJqq51uYM3J03ronY6LA6N72xZZ4IQB+Z+RZJDQoCd6ufjnL8w2bng==
X-Received: by 2002:a05:6214:1946:b0:75e:f088:4a2 with SMTP id 6a1803df08f44-87b210724a7mr257648626d6.1.1760300277960;
        Sun, 12 Oct 2025 13:17:57 -0700 (PDT)
Received: from rpthibeault-XPS-13-9305.. ([23.233.177.113])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87bc3479578sm58440126d6.19.2025.10.12.13.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 13:17:57 -0700 (PDT)
From: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
To: almaz.alexandrovich@paragon-software.com
Cc: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>,
	ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+7a2ba6b7b66340cff225@syzkaller.appspotmail.com,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org
Subject: [PATCH v2] ntfs3: fix uninit memory after failed mi_read in mi_format_new
Date: Sun, 12 Oct 2025 16:16:34 -0400
Message-ID: <20251012201635.378419-2-rpthibeault@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix a KMSAN un-init bug found by syzkaller.

ntfs_get_bh() expects a buffer from sb_getblk(), that buffer may not be
uptodate. We do not bring the buffer uptodate before setting it as
uptodate. If the buffer were to not be uptodate, it could mean adding a
buffer with un-init data to the mi record. Attempting to load that record
will trigger KMSAN.

Avoid this by setting the buffer as uptodate, if it’s not already, by
overwriting it.

Reported-by: syzbot+7a2ba6b7b66340cff225@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7a2ba6b7b66340cff225
Tested-by: syzbot+7a2ba6b7b66340cff225@syzkaller.appspotmail.com
Fixes: 4342306f0f0d5 ("fs/ntfs3: Add file operations and implementation")
Signed-off-by: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
---

v1:
https://lore.kernel.org/all/20250925203701.223744-2-rpthibeault@gmail.com/
Differences from v1: 
In the previous version, I thought that mi_read() returning an error was
a genuine reason to stop trying to format the record. That was wrong. If
we find that mi_read() fails and that therefore we cannot reuse an old
record, we should try to make a new one. It then follows that
ntfs_get_bh() should provide an uptodate bh for the new record.

On testing:
I could not get xfstests-bld to work for ntfs3. Config nightmare. So I
first tested with the syzkaller repro, then tested for regressions manually 
with a program that called all the syscall code paths touched by my change: 
mkdir, fallocate (FALLOC_FL_COLLAPSE_RANGE), and 
fallocate (FALLOC_FL_INSERT_RANGE).

 fs/ntfs3/fsntfs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 938d351ebac7..0c07502fdb0f 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -1373,7 +1373,14 @@ int ntfs_get_bh(struct ntfs_sb_info *sbi, const struct runs_tree *run, u64 vbo,
 				}
 				if (buffer_locked(bh))
 					__wait_on_buffer(bh);
-				set_buffer_uptodate(bh);
+
+				lock_buffer(bh);
+				if (!buffer_uptodate(bh))
+				{
+					memset(bh->b_data, 0, blocksize);
+					set_buffer_uptodate(bh);
+				}
+				unlock_buffer(bh);
 			} else {
 				bh = ntfs_bread(sb, block);
 				if (!bh) {
-- 
2.43.0


