Return-Path: <linux-kernel+bounces-843547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 494D0BBFB37
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 00:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1635189E181
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 22:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC4034BA5F;
	Mon,  6 Oct 2025 22:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exIh3aPe"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6278E20ADF8
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 22:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759790349; cv=none; b=CDv73mzdx0NYe8mYQd2ANuh6FND8mEhu7AqfbmhrdQkMaisinDMMjLIS5PZf9HpC7emcmKQpnitXAb1ryMFHfrQ3vh+SVAWtJY1WlpGyr8rGaDNwbX16/MrnO1cBrzLwqL+EZ3XeKjX36iGNpZ3i2Q3vObEFIU54noE6KH9FtHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759790349; c=relaxed/simple;
	bh=476qFSj3sr1jIr2YGzC22ubQeJw0gVOQ7vtxudlpjmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SvoXpY92RJP1MuQzsdHRsqudkd2qWPDNOznLThHun7C8A3Qg6QqZzh4tz738FdcqTAXfS1E2cUVZ88imKvy6f9bkbf+oy31hxCXiNLDBoS+5je9mp9Ayi70wS5/OTROCbEdN9Tumtp45OzgWxZjLTqxmjXYoBFpEP6JBlyknPs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exIh3aPe; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b5f2c1a7e48so3812889a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 15:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759790347; x=1760395147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=epHNuGWjtr5JgO8lZyH/Ct6cqyHhs3SVgqyLVnQj8Gc=;
        b=exIh3aPeiPaLF5GBvkDPbpvqKVizrcOF6l5ef2IipoIwu3xUWAEOeWaj7SIq6r+Cb9
         bugiefM5PIv+ltmSIJJUSOYZPa6GhdVW3sJQRq56zOxGmux33zFUH0h+0EwTp9DecGjt
         QSFtt21gZDyOEO36KFyTKJOrn5hcgLGvDVC5cALiaW6HZpF+fDzyKBWPW3mU54R/hvsX
         pwq2qSJeTGGSWrps/AVoqp0F058VIwezSxsCs9b4YAB+dTy7DUWJEDfyHxpcxFi90Uco
         VLsThEooeqm7vX2mVQ/w0l1n2t2cAULl3WUS65C1TsFDAzbNDMYX9qbDll2tRQ3NfVGI
         320g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759790347; x=1760395147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=epHNuGWjtr5JgO8lZyH/Ct6cqyHhs3SVgqyLVnQj8Gc=;
        b=nsQDs14bo2b37GjNDp2QWgfZ2XO/tQwlel5qWdTxUsewYIZbdTHR175DxlitK7Cn6N
         eDME4fR2EkurFDd/TUW5xeSoj+xU8IlKBgNUx8nca9iIQPeeeTSewtzXHVwiF1Lf7Bj7
         9LPdtvLoUK+KFQS3p3XHuOrqE/FBZ6g/x5yKasaFN7IR1SIo9U+r18vlmnbq01VdyMUZ
         xgO9ImIuEi0kJfY6WKwuX7ySlHE0sF3me6yJrbLVbZcuthe6HJypyf2gzZDQ2NZpRoHp
         KabAf3mV/qi5FxaW/3ROj6Mfh/Y9Ij8CCNpqEzKs1+/OgMz8FLWY1jqKk2V4TXdTFAd4
         1gng==
X-Forwarded-Encrypted: i=1; AJvYcCWqwDdWPuv76umvwfdYHOuBl9lGoVKX15pT0uBD2xDHyCVf77hng2yxVQVWmkGJLIT6smg7Jx0EO6JVYBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YybrPKK59RyIJA00osF7G/sCv2BVc6F/UaaV0o2Mw7Uh95H8eyP
	n2fCS0UujxX2+UphxdPK+POe25Rn7mCktMmwVHz7B7At+qYsDdD41xel
X-Gm-Gg: ASbGncu0WNzMTsBTFxi7HKnZTDJUol3Cnn5Zoyijpz7v1mKrBtZvXawCZK2eZ1K+Pew
	L0qDkfHSJYc+VOxWzfEAYcjD8YYdZOcgLaA38QwnFhPDXI5wSFljFNle52/V7qduiwiy17dttp0
	hTk3/wccdZbRTUNA90Nw9JGWGuBQeHh1cKVCEJhFDV2ZeyVpMPC7XqoRlfqL+bZJarQdBsQvRU9
	NckcnrfWnXAzq1xPZ0bdIAxr3jmlsOuo44ubdGH+6unA3fc2dUN1HVgTKVhKCp2w/WX+0rERCW5
	Lj0Pfp3igdHJhMayzMWEPQwDc4IL6tcbwQ3LAGktAlsaA0tmu85oMtmQ/U1j7ZFO4PNioA0LsQa
	g2B02ZFyBus/WgwIUsyBsI6XkxHF5OsRQm39mlhfc+A==
X-Google-Smtp-Source: AGHT+IF6xREOFF7VwHOye2oqD0t5qCm6RdBUaVqYPSYZgYjGI++60wK2ctzYcgxahLhIk9GjvsroCg==
X-Received: by 2002:a17:902:f78c:b0:25c:8005:3efb with SMTP id d9443c01a7336-28e9a6fd985mr177313305ad.54.1759790346635;
        Mon, 06 Oct 2025 15:39:06 -0700 (PDT)
Received: from fedora ([119.161.98.68])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1b87dcsm143480895ad.90.2025.10.06.15.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 15:39:06 -0700 (PDT)
From: Nirbhay Sharma <nirbhay.lkd@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	khalid@kernel.org,
	Nirbhay Sharma <nirbhay.lkd@gmail.com>,
	syzbot+83c9dd5c0dcf6184fdbf@syzkaller.appspotmail.com,
	ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fs/ntfs3: fix KMSAN uninit-value in ni_create_attr_list
Date: Tue,  7 Oct 2025 04:08:04 +0530
Message-ID: <20251006223805.139206-1-nirbhay.lkd@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The call to kmalloc() to allocate the attribute list buffer is given a
size of al_aligned(rs). This size can be larger than the data
subsequently copied into the buffer, leaving trailing bytes uninitialized.

This can trigger a KMSAN "uninit-value" warning if that memory is
later accessed.

Fix this by using kzalloc() instead, which ensures the entire
allocated buffer is zero-initialized, preventing the warning.

Reported-by: syzbot+83c9dd5c0dcf6184fdbf@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=83c9dd5c0dcf6184fdbf
Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>
---
The following syzbot test commands were used to verify the fix against
both linux-next and a specific mainline commit. Both kernels were
configured with CONFIG_KMSAN=y, and no KMSAN warnings were observed
with the patch applied.

An attempt to test against the latest mainline tip failed due to an
unrelated boot failure in the SCSI subsystem (KMSAN: use-after-free in
scsi_get_vpd_buf). Therefore, testing was done on the last known-good
mainline commit below.

For mainline commit 9b0d551bcc05 ("Merge tag 'pull-misc' of..."):
#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 9b0d551bcc05

For the linux-next branch:
#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

 fs/ntfs3/frecord.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 8f9fe1d7a690..4fe8da7fc034 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -767,7 +767,7 @@ int ni_create_attr_list(struct ntfs_inode *ni)
 	 * Skip estimating exact memory requirement.
 	 * Looks like one record_size is always enough.
 	 */
-	le = kmalloc(al_aligned(rs), GFP_NOFS);
+	le = kzalloc(al_aligned(rs), GFP_NOFS);
 	if (!le)
 		return -ENOMEM;
 
-- 
2.51.0


