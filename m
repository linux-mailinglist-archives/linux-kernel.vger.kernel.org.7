Return-Path: <linux-kernel+bounces-833195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F924BA160C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D20E81B283DC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F325C31FED7;
	Thu, 25 Sep 2025 20:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLQjiq6K"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36D835940
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 20:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758832689; cv=none; b=ESKGOMZ/EYYKKHlCiOynSKMOylr6Z9hO8vPjECXhkQhBIaXcjShDQpn5CctgIagkTpsXSwpK4eQfIj9RYCo57fdA06T502bP/rb4/8ZdCvZ6I6F6L9vvUeBvQ35kYVTgWHCWiSi633SIbqHCYGoEjBBKqUtBVI33FkSBvmT2isw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758832689; c=relaxed/simple;
	bh=gyNOq+vjfFASVKnd7byhOaLzYQarFIGc/atZTUlby8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A4a3d+VjRYA7YUttPy69+Ria33067jSkBSFXHp76gWy/HF81ca0Kr8rS9787E1ooiQ1Tm+4OgbepEB435XLNlwX0EhkXZNCb6YYLMvRJD1NdcCeMdAMoIJZb4gZMqFx61KnngcSMW34+gR8iX8eiO2FIqtFu4M+mfFWgctaSmvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLQjiq6K; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-854585036e8so154905285a.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758832687; x=1759437487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/3obq1lco9YVj92DdZN2mSKLWVBc5lwf9ZWKpWyI424=;
        b=YLQjiq6K2dM44ICNa0zmZrpdkZA/T65SEnJWHLYSb8ZooTOHVnPhjydsSyTf/TBmhY
         J2sN47Xvwj/dMkeMl9+OAXPWTrVn9AY3kNaEVfK5EziHXJ7rUZeERtCcuCz+KQTFX/FE
         wvEW4s0yYQ7VzHjDVzNRoniY5Nhu9anUmZV17hbwHT7tc/pdJ3OQhBSkmD9xMXGbplif
         gpB0YLWF6vUNiDMQpbBJxtS1FwmYmenAljfy57PVxqsxR3mnWrnSMZkPHY0VUhrx7PaV
         Oi9OWYcRcAMEDjrcCMEBGH2fEwM7bjW1JEE4qSFy5aP2Pc3IYgm/HYwmcJIzXa692gkQ
         ms1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758832687; x=1759437487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/3obq1lco9YVj92DdZN2mSKLWVBc5lwf9ZWKpWyI424=;
        b=BYDiWl5ADyTZwoJN38H+UaISTw/f+vQtSqnxmKogBIXdgTq/AH8SzOwTR/TOa+Bahv
         NQX5ifRzBiY5y8bcjLLRpiYpJxQzAvehh1FPnzinGZFk7idZhQxHqH3DuhXiR/wSD8kW
         V/rhnHJga+bPLMaKDgP3inJBeGt8EEYW8G9mcg0LZFl9KDLlpAhXx9e0Oc6W3HN7VTms
         IYhCKoPaeX/Km/ibXAi6wEht+gcSxEQPzllIRl/F4pkD2mTQA4Fhso+i3TxpHuaUYs+A
         PyNeKYqq6VfeZxOTc/mwzfuoCDjR9qUHhCHVHVATmEGTVZg+yhFXR5eFyNBB+yAK5iQ6
         LMDg==
X-Forwarded-Encrypted: i=1; AJvYcCU8PsHakG7QIce+A0IRjSVEGzb/6AV6duB6ACAbBgQovCk/tmBa1B5ye+AMLKb7bTQaYxT9kS3u2WX6SUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWknlvxgybQ4JlyRLRMzzMUpwGWxT15qI2LK0CTnRCqyGVb8Ky
	InxYnIecoRADntj9I8rrwWS9uaBIFo29MFqm19aXxF7GeSmIwxDvC4np
X-Gm-Gg: ASbGncsQCRIJiBRN0xdj4l1w6PqIC9siu/HAdAoIa0nJ/JooAo7He53oBAFuxWu+lbF
	B+8tyekwkYpEJhKez/wjLX6ZVMuQhUE5mHrRK3zpWRMwfxnKam9dlQxGRiYX7ZrlfHcp32f3bEf
	dC13Gr3HfX6Mex3NDnZT31dCtWYno0vfCqk6/xiFHZzRhXUpc1kNgUBRbhCgKYUqyL30l+6znEt
	S4IoNe8ou3HkbTWnGqiHeZx8ciJIUzKYleVOpOCXPDF4QEP2AA007o6aqjIXq8UNPeJ64tDt1tC
	uRuC4nGMy7MoZBBgjaJGG/J2S0iPGpXWL7uQ4WD1h74NhpMxwgJZxqywrm8dnOXHVXzwTEJ/yz9
	lBjaZZjwXlpi+3TiAvkNAwBHRGH8P0qtdVWYccnJ6Zt4=
X-Google-Smtp-Source: AGHT+IHbYhfGDjyNvmvJZMKZPPt40kN0VMaibW2U8d0/Cl6QStbX0UHbkCPSSEtNvMQu3xpUc9rC6g==
X-Received: by 2002:a05:6214:20a9:b0:726:91d:bdb8 with SMTP id 6a1803df08f44-7fc45172a40mr80850616d6.55.1758832686606;
        Thu, 25 Sep 2025 13:38:06 -0700 (PDT)
Received: from rpthibeault-XPS-13-9305.. ([23.233.177.113])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8016cf8f949sm16430056d6.54.2025.09.25.13.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 13:38:06 -0700 (PDT)
From: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
To: almaz.alexandrovich@paragon-software.com
Cc: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>,
	ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	syzbot+7a2ba6b7b66340cff225@syzkaller.appspotmail.com
Subject: [PATCH] ntfs3: fix uninit memory after failed mi_read in mi_format_new
Date: Thu, 25 Sep 2025 16:36:59 -0400
Message-ID: <20250925203701.223744-2-rpthibeault@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

attr_insert_range() called from ntfs_fallocate() has 2 different
code paths that trigger mi_read() (which calls ntfs_read_bh).
If the first mi_read() -> ntfs_read_bh() fails with an IO error, it
leaves an uninitialized buffer in the buffer cache.
The second mi_read() -> ntfs_read_bh() then uses that buffer,
where we get KMSAN warning "uninit-value in ntfs_read_bh".

The fix is to check if mi_read failed in mi_format_new.

Reported-by: syzbot+7a2ba6b7b66340cff225@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7a2ba6b7b66340cff225
Tested-by: syzbot+7a2ba6b7b66340cff225@syzkaller.appspotmail.com
Fixes: 4342306f0f0d5 ("fs/ntfs3: Add file operations and implementation")
Signed-off-by: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
---
 fs/ntfs3/record.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 714c7ecedca8..98d2e5517077 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -431,13 +431,18 @@ int mi_format_new(struct mft_inode *mi, struct ntfs_sb_info *sbi, CLST rno,
 		seq = rno;
 	} else if (rno >= sbi->mft.used) {
 		;
-	} else if (mi_read(mi, is_mft)) {
-		;
-	} else if (rec->rhdr.sign == NTFS_FILE_SIGNATURE) {
-		/* Record is reused. Update its sequence number. */
-		seq = le16_to_cpu(rec->seq) + 1;
-		if (!seq)
-			seq = 1;
+	} else {
+		err = mi_read(mi, is_mft);
+		if (err) {
+			return err;
+		}
+
+		if (rec->rhdr.sign == NTFS_FILE_SIGNATURE) {
+			/* Record is reused. Update its sequence number. */
+			seq = le16_to_cpu(rec->seq) + 1;
+			if (!seq)
+				seq = 1;
+		}
 	}
 
 	memcpy(rec, sbi->new_rec, sbi->record_size);
-- 
2.43.0


