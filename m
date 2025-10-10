Return-Path: <linux-kernel+bounces-847878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42385BCBF17
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D1C14F69E7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE91274FF5;
	Fri, 10 Oct 2025 07:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlQKXsjF"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2CE273805
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760081904; cv=none; b=t5Z6yZNB9kjPtmCYrpt9aFuzGSBSVsunMXooauUe5N/tR2eqft5nN8s4KEV+qBKhgIEL67PHHj5HQOEP9AouqXApHe+2h+8a4oRtBkd0fJjqjBFyfcwd2hpRY0RjKTKNsaFQlOcQ7PjAls0dXYfuxQaCh6mOgrDPsxr/fhioWDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760081904; c=relaxed/simple;
	bh=MpA9Ba727PWpTiit6pJN7JEb+SmHnIAuxsvN32bkDoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Itb9Hu1GPdHDduzEINWuZLW8JE6TvpmlF3PLrQC4OrIgfXo3+HIatICqMFLysTYh5yjpK8a8YT/pL//1wVbCTyL86qkuhRdDfQ26TILSVyxd94US8e/YrLA5ssh6E/uBRBeGDJKR2NWCFA437n8V44Mga2jec+wXPwb3HgVm3I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlQKXsjF; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-91f6ccdbfc8so88616939f.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 00:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760081902; x=1760686702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OSkReOZjk0xY+q439G4iJeisRcTeHWRCE0gBX7ZntOQ=;
        b=OlQKXsjFjHi+uua3vAYIsFM4C0P/AWC1a+GxcMObjD8uYQv1S3UVCBnDCNB5V2MHCO
         Z9S7MLir+R1JYhc5OB3ivY2tJobBujxb2UdInT7hoEKczCKHQyCdCQ+5O1wiV0nui5Ew
         jKwJQFpAEbcox5j64w2aLWlrAYCQNPHpDe95B2dn4f9oi40BSxF4QygDrgdKFjxsw7yr
         uUMigUo3V1dYT7lxj7MXOnerTRXfdZdM6hO4iRphfRvDS9lRWk1oGoUV4LFuQa0Je4e/
         Se5yr9eeNlvQ0RcyvTiITO9hR4UzgB2trANVefdi7Fo6RcwIZUuvKc5S/x25W6xJyzXL
         ZEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760081902; x=1760686702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OSkReOZjk0xY+q439G4iJeisRcTeHWRCE0gBX7ZntOQ=;
        b=nchssEP77NfXDlZkvgfYxvFo0EUVxrtQgIOoky1qcBeE+bDiDPe4zcI0U3JGghnHhb
         jr7Urx2swrMpl3BGk8YxUPJIOnloH8yKn5F7Wfp2w6dwobYbpIxxP98EDKnnpyo6d6uZ
         QySts5eW068HBJOgDeu4BFBSLC61ILKjWR+8xnGe/E4jkf4l/HYCYixM1I6GqqssjvQz
         yWv+moV6YJ+8Dbjoc2TuW/FrqgspSSeOIfmljDe64/m3o/C0+77cG7wDgn1+SY8BqNeB
         4UREh4rs7tTxg/kc1QoF8IKZfO7HgIGkP3fbcjgWnqQnDPG9EH+nbQbIlvg8Q8ltMP52
         z39g==
X-Forwarded-Encrypted: i=1; AJvYcCVerQPfFtU8vdkeyZHSZ33iz5hR2g+c/PQ7fVFAY6LuB4qIBSFZiR+LUeWFKM17FwXwiZw6ntpuXhQg8nc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/6xUaWVrkTh0yecKpl0Jj5+hPLuGpfCBlPbdYRj4+VOUccjUy
	xPzguivk3sZ0siaodMpwbgTJSoejvNmKce+x9jnbALJQkIBjRyuHsNtK
X-Gm-Gg: ASbGncskXlnMuL7SV96N1YIKWaT21JibrUsAX+Dr2yz0iGFBmL1KXljilKYtpPDwQxC
	byGKD1SUoLQLtwksgBnejmTt0zo/sWoQkzKDymE7yWmjaiYvUyz0dL/Gr7jelrh0H3reZcoW3Ff
	DH+BXAGBa1qqaq1yRSNfn4ZyJ8v5fjbsooEhc7gkqVJcdNDRN19amd9jdmxMR8IYtfsQLk5FNj2
	6YKyGWSbBiKy+rkp1pS2YPupV3EfrmMgRkVwuw5LiA2/ivZLLBuhdmM9H/tNDsIKjeCsUARxBTR
	yEXfkegWLTnUcmomf3AVYfCfOT0255cZrKd3fMsx/uuVdcmf0nOPNtG+1mfil6Vehqqb1jfxn59
	Z+cOaIUpS9jhDtg1JT+kwIl7F7bPVQWynkUZz
X-Google-Smtp-Source: AGHT+IFLDnuMzjpQsHE8maLNss22i9SbCwyHbHSlyPt/YAet7vC4ZYbeftfnNxrJt0Ye/5hqinibpw==
X-Received: by 2002:a05:6602:6b89:b0:90a:ce21:ae1e with SMTP id ca18e2360f4ac-93bd18f2a3bmr1228708539f.5.1760081901767;
        Fri, 10 Oct 2025 00:38:21 -0700 (PDT)
Received: from arch-box ([2607:fea8:54de:2200::3171])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-58f71e21a4asm632732173.47.2025.10.10.00.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 00:38:21 -0700 (PDT)
From: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Cc: Albin Babu Varghese <albinbabuvarghese20@gmail.com>,
	syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com,
	Ahmet Eray Karadag <eraykrdg1@gmail.com>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ext4: synchronize free block counter when detecting corruption
Date: Fri, 10 Oct 2025 03:38:00 -0400
Message-ID: <20251010073801.5921-1-albinbabuvarghese20@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When ext4_mb_generate_buddy() detects block group descriptor
corruption (free block count mismatch between descriptor and
bitmap), it corrects the in-memory group descriptor (grp->bb_free)
but does not synchronize the percpu free clusters counter.

This causes delayed allocation to read stale counter values when
checking for available space. The allocator believes space is
available based on the stale counter, makes reservation promises,
but later fails during writeback when trying to allocate actual
blocks from the bitmap. This results in "Delayed block allocation
failed" errors and potential system crashes.

Fix by updating the percpu counter with the correction delta when
corruption is detected:

  s64 correction = (s64)free - (s64)grp->bb_free;
  grp->bb_free = free;
  percpu_counter_add(&sbi->s_freeclusters_counter, correction);

This ensures the global counter stays synchronized with the
corrected group descriptor, preventing false promises and crashes.

Reported-by: syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f3185be57d7e8dda32b8
Tested-by: syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com
Co-developed-by: Ahmet Eray Karadag <eraykrdg1@gmail.com>
Signed-off-by: Ahmet Eray Karadag <eraykrdg1@gmail.com>
Signed-off-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
---
Changes in v2:
  - v1 added bounds checking in ext4_write_inline_data_end() to reject
    writes beyond inline capacity
  - v2 fixes the root cause by synchronizing the percpu free clusters
    counter when corruption is detected in ext4_mb_generate_buddy()
  - Addresses review feedback from Ted Ts'o and Darrick Wong
Link to v1:
https://lore.kernel.org/all/20251007234221.28643-2-eraykrdg1@gmail.com/T/
---
 fs/ext4/mballoc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 9087183602e4..956e5fa307ca 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1290,8 +1290,11 @@ void ext4_mb_generate_buddy(struct super_block *sb,
 		/*
 		 * If we intend to continue, we consider group descriptor
 		 * corrupt and update bb_free using bitmap value
+		 * Also update the global free clusters counter to stay in sync.
 		 */
+		s64 correction = (s64)free - (s64)grp->bb_free;
 		grp->bb_free = free;
+		percpu_counter_add(&sbi->s_freeclusters_counter, correction);
 		ext4_mark_group_bitmap_corrupted(sb, group,
 					EXT4_GROUP_INFO_BBITMAP_CORRUPT);
 	}
-- 
2.51.0


