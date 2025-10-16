Return-Path: <linux-kernel+bounces-855507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1D0BE17F5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 07:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C55D84EBAAB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 05:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72437225414;
	Thu, 16 Oct 2025 05:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fU3M8doa"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E73B223DDD
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 05:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760591802; cv=none; b=Cd6mJm5HEnZyzvrhabVNxCC55plQI7wH/b/EIoeVu5T/Rb7G5YCruJMQNGYIbJptSIMnCvwA8xQAObgTYuHVAnH+srn68fJdT0sbeJdKQzlHePYl1dHW+ZPZf1zXcugSxM3KkLMaS5MvqTu2Fxq3P6PrXhVVya6K6GlF5ObewHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760591802; c=relaxed/simple;
	bh=C5vNE/JdIuz7kIW1xQSUDF6bjXOLGiRlAa2BP0KHlrk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UtIgNsGIVAHYqpGA73fhQzdUlvfpQX1Qf3B9Av36HSlP+JIC1FPhfFX7/1FbU+WkclAingTh9ZE/9jKirjkI39cemG1CBNYsQ847qvbKkd7mI5aDEyHlYTGiP7tPEK8702vLh031YrvZ30LVtHnbddOqzCY9XCn833liuxDmkfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fU3M8doa; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-33b5a3e8ae2so1231681a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 22:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760591801; x=1761196601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pigqJGC+B272ixDTo1WsT4TFwZwGZ84ntnAlQQ1cee8=;
        b=fU3M8doacUY6An4QOGpKmuSLtodEus5lRnz7GkHT8LYO62vRiCSdOfKK9kj2VMXaaM
         MLCB3kFwRdFsIfUWhEu6ul1w2NrxNZ3+9HJoZkvd9Fv0DD+Yz8JzzJjrNbJe0jmwAPe/
         jXMy/yPLjw9/1zBGm1vfEQZ+fr+YGiyCi+3h6neCwXAsen3Mw+oNO0cCUgenLa70KAUa
         81OH6xuvbPueld+crkyS/5GHTTJp13PVghphqJzn5uO2momFOe8qOg249G/LN8jsaOMt
         M6wL51CAaQ/2vvkSIbKj+6S/sLguFlrwEuBnpoUG6L6Rtz0YEgKjK5EousM/BdPaJ1+J
         5/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760591801; x=1761196601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pigqJGC+B272ixDTo1WsT4TFwZwGZ84ntnAlQQ1cee8=;
        b=KFa2ajaOtKVWVB6XKLqRi6VhP7OfZ0h+AUypzuQX+EOdC+OZyf3JxKmbe0E0klZDxN
         kjgEwooYzicBirJF6dCx9blhNCkwePXzQvTWsNn1E00EIODprKaH/r4jYFJJua4xOazx
         39pULBXsM0MMK7eA2ZrbE2Cu6wpGW5Z4GPaZ+qZJ6PNRVs+DluuxIIqJV/+zwZgJuX9e
         2jhB4Z2CJOkwAxN/ujYdH9Sqhsq9nqUbcsBluo27mu49e6sTaBi48HS8SQlZKoDOKCA8
         dm0+VJYRomFxaiduPxU9a5G2rA5i91XdZJE2FCNOS69h5nygSdzQURvMvt19SSY9bIdl
         5OJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX44bsZPhIpqpCCUPTWPcOHscOLcwLSOVRZChWUiFWRDNeEg624LxsuSrWx4uERe+GBzP9i/PQlZLgO0Qg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+vsBYynKpjB7VU1AmJm/btb+gXhcUP4sVwAqSQF/Ku8I/e6WH
	32pOtnua78f6jafYoKoro0PjFcj/xHEGgBKdpXlis8S1nLG0VDQTz1OM
X-Gm-Gg: ASbGncuPACqY5mB471k03EMDE3vcUBpxqnX2dysiaJYDJOm1owEK1nc0lHt9Z+iz0ur
	NQXIE0fpKUHR9+YLROPmMCW0zb20UZ8yVgy4zJOdBh8ZdOQwioIn/ZGe2IodFK6+6bj5vAK4u7o
	DYa+38yNTICCXou3I9grm0GNXBl+iCK6H+UNGPUMTiNkm2InDMkYoy6eFQJf2c117MOorq6oe8u
	GCgrT7Y9+lCaLVJ4Gu9iW9w0lqAkzVwS02eccPdKNwDhGT+4u6/Fcclm805eLzsAnCOsME0j96K
	imjDR5BnNc7miv0wQcSdK4KGKLm2d80ndFLbkB9FBk1sTVOL7UtFN4if4z3JmbbgXDm5SHPiYBU
	KqknY14ZHmdFA/bZcfsPrP9R4dgkwZAU481gheUi1tDLfXqDKYnrTtV8EfBbH5o+rvqSZZ6dakF
	1TkUhhxU2PDobp3A==
X-Google-Smtp-Source: AGHT+IF0/K4q2jQn9UOtDGAHunWEgJG1TbfokjhDoIk1ay6EYVQXYRPGachSbGMLIS9aV8kVIq+UWw==
X-Received: by 2002:a17:90b:268e:b0:330:55de:8c20 with SMTP id 98e67ed59e1d1-33b9e09006bmr3258974a91.2.1760591800552;
        Wed, 15 Oct 2025 22:16:40 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([175.119.5.143])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b0606f0sm21261497b3a.15.2025.10.15.22.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 22:16:39 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	jeuk20.kim@samsung.com,
	d_hyun.kwon@samsung.com,
	gyusun.lee@samsung.com,
	hyenc.jeong@samsung.com,
	j-young.choi@samsung.com,
	jaemyung.lee@samsung.com,
	jieon.seol@samsung.com,
	keosung.park@samsung.com,
	wone.jung@samsung.com
Subject: [PATCH] f2fs: serialize writeback for inline-crypto inodes
Date: Thu, 16 Oct 2025 14:16:21 +0900
Message-ID: <20251016051621.7425-1-jeuk20.kim@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeuk Kim <jeuk20.kim@samsung.com>

Inline encryption derives DUN from <inode, file offset>,
so bios from different inodes can't merge. With multi-threaded
buffered O_SYNC writes where each thread writes to its own file,
4KiB-per-page LBA allocation interleaves across inodes and
causes bio split. Serialize writeback for fscrypt inline-crypto
inodes via __should_serialize_io() to keep foreground writeback
focused on one inode and avoid split.

Test: fio --name=wb_osync --rw=write --bs=1M \
      --time_based=1 --runtime=60s --size=2G \
      --ioengine=psync --direct=0 --sync=1 \
      --numjobs=8 --thread=1 --nrfiles=1 \
      --filename_format='wb_osync.$jobnum'

device: UFS

Before -
  write throughput: 675MiB/s
  device I/O size distribution (by count, total 1027414):
    4 KiB:  923139 (89.9%)
    8 KiB:  84798 (8.3%)
    ≥512 KiB: 453 (0.0%)

After -
  write throughput: 1760MiB/s
  device I/O size distribution (by count, total 231750):
    4 KiB:  16904 (7.3%)
    8 KiB:  72128 (31.1%)
    ≥512 KiB: 118900 (51.3%)

Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 fs/f2fs/data.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ef38e62cda8f..ae6fb435d576 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3217,6 +3217,8 @@ static inline bool __should_serialize_io(struct inode *inode,
 
 	if (f2fs_need_compress_data(inode))
 		return true;
+	if (fscrypt_inode_uses_inline_crypto(inode))
+		return true;
 	if (wbc->sync_mode != WB_SYNC_ALL)
 		return true;
 	if (get_dirty_pages(inode) >= SM_I(F2FS_I_SB(inode))->min_seq_blocks)
-- 
2.43.0


