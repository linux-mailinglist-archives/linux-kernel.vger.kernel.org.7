Return-Path: <linux-kernel+bounces-846511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B70BC834D
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 11:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 03F444F6D0E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 09:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CE72D838F;
	Thu,  9 Oct 2025 09:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQaa6tDj"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73202D7DE9
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 09:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760000937; cv=none; b=HAi8xUNpcCo56Vj1eVARZO53aXrIkXUCnCgG6+rz8x0LI/ZLR2D2UTvCe6+f65Wg9XY7bhL+Z//jEa4Nal8UUs5A9JArm/hM1Z1gGlvEnZJ0jArhk6OmvnN7Ia1k6D90IF28SQOi4od/78y6ZwSrngLyEAVkU4tSoUfUcTsS4I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760000937; c=relaxed/simple;
	bh=KcXa7KpDaur+uFmqn054xcHb7hsTcb+0GQs4M5FBSr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=erKL0KD8cjQ+AHb6zNYtudCEQlCAUNPuySnEmMDIPfbKb+Deq8tVWKtmgCzVa2dmMDQ6lW9nSApSY5FX8mCjR/8KqLznMvjXBqkobkw7wlOrCeX2KqKvHP2q4FSKQ1ZDYMdO78HTaIOE43qXEjj/VVQ1E3gA16191pxbTVAQ0hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQaa6tDj; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7811fa91774so630625b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 02:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760000935; x=1760605735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C+uXX49aJSWydq7w+IBivpuqIIen5cjqVetpqZ6Ubl0=;
        b=UQaa6tDjDv/PU9cLO2WgehElAHghQMqjZ9PeqA+Hwq1E9B9mnvws8epQsJD0ivaohQ
         oWmEvqphVshRl2TYU7vAgn+sfF5L59OKGV3uD3w4STeBzccoWu5TjTogQOhy9WPuVimN
         vjnVU88DnP5OBBZc2GC7vbcDKZITHmhUnwBtoEs8tdOGjnTqG/Q/3DOUi9sxaGb1F91l
         emeZl/skxe0ZZMGeM9j0sLvHmxo4hJmsUCEnRCxLiuhqkz5Y9Q9mjSQdvDk4qD0/uN72
         DDu+VmWk/JWia2mrp/VOrnNBt0SmR1bV7mQ71c9gv8iwpIiYKgaVVnBF19Yqi9DcijPD
         6xQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760000935; x=1760605735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C+uXX49aJSWydq7w+IBivpuqIIen5cjqVetpqZ6Ubl0=;
        b=UVUTpsE9geMWqglbwJn5jYE0ri6EVUC9fnmEBqt8X77X38dH9p77xm8GgrPYV8DBH5
         slSaXnQZQg/f8+FiOMZOZ7D3EoXn5r/dnTFf+cHnSgDplRnF9w4DfUMQ1pCv10tf/q08
         1Ydp0aXFPXY0F95dKyuNmOe6R6QWhjyb7X8zPYqRpA9fh8mb3YYZ5ClDpUss6pnWCD4V
         SHWYxNjVLage3M1AbEMv9DJHRww1FAERpqCDKg8zQl1GEDAu+vTQzW854GjAgWIbyFxO
         gauo18vQNorG627Kud7ZW8v/8UCo+NM26oH1zPzo/WurRfMKdm4vu8/vOu33A96qPGZK
         DWog==
X-Forwarded-Encrypted: i=1; AJvYcCWUX/YMEquEXt/K/Rz1b0DiFzY9DOOe57Y6lIa0fwcat1nz4wohbbDUXOVWGFO4ZoJtIRZssS1NUTtCqIA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1DuaEIHKj/ZVq0t3dxf0Z0+OWTxWJGmc/R7Cr/C4krwe/sgFw
	g8Rsj+otnXNu+Rk2t+vqUvMkvRkQm68xQvH8UlY1pmlYzFBAk99KKsGr8Ow2qw==
X-Gm-Gg: ASbGncsJ5eI0EWA5JXZrEJZB6wxX7hpgeZpBUJq1jSxGrV7550HJ/czZPY5qFquXNZi
	zUBGkq54Xl+iKWrKeWpiQQWo5jEHqcifkPpPds+OorckAJFGlaxc8kfDYWBrj0skDDn7kK+GDMo
	cVvQJwKyw8NMwbo2TYD1nMpIYypoOGyrebUUxzGR3fugqocBGRiYmoIa9JTgRLGlSYR+O7kyHME
	9NShxypYJge3PrJB8Xajwrj46Gr93NzUYgyVcU1X6+LiiXOHoNRFcAqTtRg1xJsi0cw1KjgYZYM
	p1Xq6B7U5kE26YKoCQkCGewnFzltiFjuaMi8DGEXg9EMYGK47WgVHsZPAXosXI+DEz9jEV4fyDZ
	BlWAlwK8EsEQ4TvFmwTduqci5Z4lVwA+RI1/U0+BULsEFw9n/xuRICznMbgtUw1VFM7X+
X-Google-Smtp-Source: AGHT+IFGt4O/r0xFNJrXeC/igV78+a3q45ov1VJNkdOtbNUnCJ+CIdkFX31aFA1MGzKQAcgaH9fqOA==
X-Received: by 2002:a05:6a21:3285:b0:2b9:b64:5aae with SMTP id adf61e73a8af0-32da8462febmr8919546637.29.1760000935143;
        Thu, 09 Oct 2025 02:08:55 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f58ac2sm20209182a12.35.2025.10.09.02.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 02:08:54 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: djwong@kernel.org,
	brauner@kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dave.hansen@linux.intel.com,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH] iomap: move prefaulting out of hot write path
Date: Thu,  9 Oct 2025 17:08:51 +0800
Message-ID: <20251009090851.2811395-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

Prefaulting the write source buffer incurs an extra userspace access
in the common fast path. Make iomap_write_iter() consistent with
generic_perform_write(): only touch userspace an extra time when
copy_folio_from_iter_atomic() has failed to make progress.

This patch is inspired by commit 665575cff098 ("filemap: move
prefaulting out of hot write path").

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 fs/iomap/buffered-io.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 8b847a1e27f1..6e6573fce78a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -972,21 +972,6 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
 		if (bytes > iomap_length(iter))
 			bytes = iomap_length(iter);
 
-		/*
-		 * Bring in the user page that we'll copy from _first_.
-		 * Otherwise there's a nasty deadlock on copying from the
-		 * same page as we're writing to, without it being marked
-		 * up-to-date.
-		 *
-		 * For async buffered writes the assumption is that the user
-		 * page has already been faulted in. This can be optimized by
-		 * faulting the user page.
-		 */
-		if (unlikely(fault_in_iov_iter_readable(i, bytes) == bytes)) {
-			status = -EFAULT;
-			break;
-		}
-
 		status = iomap_write_begin(iter, write_ops, &folio, &offset,
 				&bytes);
 		if (unlikely(status)) {
@@ -1001,6 +986,12 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
 		if (mapping_writably_mapped(mapping))
 			flush_dcache_folio(folio);
 
+		/*
+		 * Faults here on mmap()s can recurse into arbitrary
+		 * filesystem code. Lots of locks are held that can
+		 * deadlock. Use an atomic copy to avoid deadlocking
+		 * in page fault handling.
+		 */
 		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
 		written = iomap_write_end(iter, bytes, copied, folio) ?
 			  copied : 0;
@@ -1039,6 +1030,16 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
 				bytes = copied;
 				goto retry;
 			}
+
+			/*
+			 * 'folio' is now unlocked and faults on it can be
+			 * handled. Ensure forward progress by trying to
+			 * fault it in now.
+			 */
+			if (fault_in_iov_iter_readable(i, bytes) == bytes) {
+				status = -EFAULT;
+				break;
+			}
 		} else {
 			total_written += written;
 			iomap_iter_advance(iter, &written);
-- 
2.49.0


