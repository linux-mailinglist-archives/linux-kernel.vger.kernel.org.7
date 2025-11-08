Return-Path: <linux-kernel+bounces-891703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DFEC43495
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 21:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA2903A1030
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 20:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954F2285045;
	Sat,  8 Nov 2025 20:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYB5okYl"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C0127B35B
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 20:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762633611; cv=none; b=j+aYiH7+5w/8VnnN3FtlYMdlEWgtzUtr7QC5pB4xuGioFGQ4BEo8qpFja1SlaqanHpT/l1Mf7pdxXzlyvJliN9Qg/p8BRBuM+CpQvNmiEUWhUpRpxIi2At7IxdTfsO+cbU9VC89sFIvYaBpp4NcRhKM8NOtN4N8BxUlRbFVVUnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762633611; c=relaxed/simple;
	bh=7r2vaQFsXYEdBsj8HiqWkBplfeax3sxT6mHqMhZQqOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bz5QwJk0szEmGfivUC5sA5JmMENO7AKimQmI1ixLYUAO7gb2eAgZait9cyw2c1d11Xk5S9Ogwx2UsqsVyobanOBXfC16gnBy9Kc1qATkW1iaa1jZ4N4FWFN6N+eA6ZM/lDkA037T48QzEpp4JnDCfFJKznWZ2A43ve6pypJFEas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYB5okYl; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8b22624bcdaso250758885a.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 12:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762633607; x=1763238407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vqdNy1cXW3Hz2aSEK4LLxs8ePlR8f5QrAsxwadDsOPg=;
        b=lYB5okYlr/wOc/BlevLimd09e8pWzbu0gOgsdFaMYD4rs0W2rcTYbeIr5ji1BzNt4x
         ZNsPzIZFBdx8QlNlyq84Y1qN5RIbJxaTe8UZ9kQPBQk2qELBrq0OfYQhz1BcFa1eGMNv
         YzeEA3K1016zElRiPeUOLdPC5D/1Qye7g2WaxMwMNimZdPrPzniVVi5ADX+qluh+6yL6
         9Bx/KutxYXn7MvOl3bMEghTy+i7Wm0IyGbFkqHC5Ljb7+ox2Hv+883oGt2UwJC3HUZ/R
         tWtXAz9QW3PUq08S8TVcQg1vUoc9vgJjeVefBA65p68lo3HoHueVD3j2ItY2oPfUmqGN
         xXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762633607; x=1763238407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqdNy1cXW3Hz2aSEK4LLxs8ePlR8f5QrAsxwadDsOPg=;
        b=gcIosNLkljyLQG2ebyR7SwXjs3OzW9FesBRIemXDKedasm7FpuNgs5ecvLSvdTt5iz
         p2ymYiVMF3jCvsbaPelRlgaVvMtne8ttXnlABVMe85+e0GyHUZn7bN/fAdPKI0EBym3q
         2GIjwaa9bFHVs+n4LE5hsTDwUfDrZb5RFlR5nFeK6jFXvWAvHz1nRze/mWNUoFik9wQf
         o/SGu7N+sxIHkgAGSmDrgt5h0f9k607O0xsPv7rRGM2PKa39JvPu1bgI+UwwJqCWZyTb
         EoKP3Oe48wQOZ/Menak+KY4j7Ym44+qMk4wfCal3Q0q/Xx0Y5StW7wAAeN37KjGpL9UE
         9nuA==
X-Forwarded-Encrypted: i=1; AJvYcCVlUDr7H+QInphW5rph213yVe5BjJlD84UzgmSRC9ZbbZ6jtGYKq8Vtyku33GOkDdbs4Vz8cmrWYQP5PXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTvkmS+9DCvV4AJLT28LAoaWS/det392yAaZmlH4VNkWEOItzo
	mcbgqjYsnX5tTWYj6DoODq7ejtRHdhzVIqXAeRC4fn0HAIHVRhODURO+
X-Gm-Gg: ASbGncs8usClTT2khUJDB7zgU0KYcdz0f+pU8DNsDEga/VAiHKR4nyGHFX2uK0XatlS
	K1OUS7515GlOq98pkdbV3Qq73YR7MEU04cgSRPW32FX7AfiVhigiYtfT3OYI/CU4PT3IVbkTjgb
	dFz/QkwhXrCSu/Yu3Wwj01z4phixYbBtkviYp3hIR3tHday8NC9SvzcWIcqhmWPg+iTxcRBmGLM
	jtrmXeMPAOcI//Qkue9AfbbNRGOvs9xKrZ4G2qr6khWoRc0vvYKIpTkB3V/y+Y63Zu71vuJoPrM
	GO+ymUJIDwpgeZjunKUfOoq8zX+jPG0y693EgE373HDPtVgKU9TfAakelNThw5lZLS7vKR80hjQ
	hHhg2F63Q5jFqAOdH5iadqxUad12rfvmw4NNnRy35j2lLv+MrXNHLBNzTDfTqRtspnD2SYf/Hu9
	IoBvrVqYIBTE5cMNP5eV54
X-Google-Smtp-Source: AGHT+IGONkC6+DYOwOtmQYThFKcoR7JN6qMjHtFFocpFa9KyeI27WnTRQjoR1Bqiw3sai+RnnmkvIw==
X-Received: by 2002:ac8:584e:0:b0:4eb:a291:fbf7 with SMTP id d75a77b69052e-4eda4f90bd7mr46135221cf.49.1762633607356;
        Sat, 08 Nov 2025 12:26:47 -0800 (PST)
Received: from rpthibeault-XPS-13-9305.. ([23.233.177.113])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4edaebc73b0sm7067891cf.22.2025.11.08.12.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 12:26:47 -0800 (PST)
From: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: cascardo@igalia.com,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com,
	Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
Subject: [PATCH] ext4: validate xattrs to avoid OOB in ext4_find_inline_entry
Date: Sat,  8 Nov 2025 15:25:46 -0500
Message-ID: <20251108202545.1524330-2-rpthibeault@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When looking for an entry in an inlined directory, if e_value_offs is
changed underneath the filesystem by some change in the block device, it
will lead to an out-of-bounds access that KASAN detects as a
use-after-free.

This is a similar problem as fixed by
commit c6b72f5d82b1 ("ext4: avoid OOB when system.data xattr changes underneath the filesystem")
whose fix was to call ext4_xattr_ibody_find() right after reading the
inode with ext4_get_inode_loc() to check the validity of the xattrs.

However, ext4_xattr_ibody_find() only checks xattr names, via
xattr_find_entry(), not e_value_offs.

Fix by calling xattr_check_inode() which performs a full check on the
xattrs in inode.

Reported-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397
Tested-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
Fixes: c6b72f5d82b10 ("ext4: avoid OOB when system.data xattr changes underneath the filesystem")
Signed-off-by: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
---
 fs/ext4/inline.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 1b094a4f3866..7d46e1e16b52 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1593,6 +1593,13 @@ struct buffer_head *ext4_find_inline_entry(struct inode *dir,
 
 	down_read(&EXT4_I(dir)->xattr_sem);
 
+	if (EXT4_INODE_HAS_XATTR_SPACE(dir)) {
+		ret = xattr_check_inode(dir, IHDR(dir, ext4_raw_inode(&is.iloc)),
+					ITAIL(dir, ext4_raw_inode(&is.iloc)));
+		if (ret)
+			goto out;
+	}
+
 	ret = ext4_xattr_ibody_find(dir, &i, &is);
 	if (ret)
 		goto out;
-- 
2.43.0


