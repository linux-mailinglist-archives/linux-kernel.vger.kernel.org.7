Return-Path: <linux-kernel+bounces-890977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB06C41818
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 21:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3AA2B4E4483
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 20:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789A0302CAC;
	Fri,  7 Nov 2025 20:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="UAac69UY"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB1B3009F1
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 20:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762546022; cv=none; b=r2hctP5hq20nJsMGCI28rb+BF+qEcxgCyFTdExIlfnwMY5ZBPtpstrqYdy7GQperbp9TsipVqdHe6x2iOFaZvnyUDVcwcf20D+nsD4EC7Z8pXSASpvWZxhpQDW4Opw6kh7G6a8kZwa6oT693F3TW0t97I1wUlUnK4DRjo+jpTOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762546022; c=relaxed/simple;
	bh=A4+TOwgqNdQg6f8E1pPnxBWqzpNdAcnfbfRIsLrm7Vw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JoR2DR67CLym3B6M3RISc9PL8fXW00N/HJVM4bnjmGcmtNCx7I4yB9M0r+qUBag2ObjGx6qduJ+bIYELftwKuaZSs77vi5zWM4LloGZcCfep1OobB031PY5gedze4E+pX0lxOuKt1hPdNQ70ohj4KO4GiEA8JMpGF4IKO9nB2dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=UAac69UY; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3436d6ca17bso63723a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 12:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1762546020; x=1763150820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dhDbgFwqZiDQu1EsSrcetxhJXfZ+td3XRScWxEwgYgY=;
        b=UAac69UYGUfKgADDRJdIOiH/JdrC/NQpHUPQxYya1I4pUiYVcg6kZBRguzBb9tpmaW
         uVvOnuy/bsBamnC/knf6wwLgdLitIFh6OV3dMkT8OK84XYBBimsM123YoWUsZ0dlrLqN
         +O2xTbVXLPz4DEpX7jJAgCcpKvc7VDbLf48K0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762546020; x=1763150820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhDbgFwqZiDQu1EsSrcetxhJXfZ+td3XRScWxEwgYgY=;
        b=rv+gzYmICPLbDTh5nWj4b7NF8pq3SPk2C2NHoYDy7nxtuAZdJqq+zF6oWv1H26ZXO8
         Rmbf8tPmVFhdVUKvpP4xCtF008tltHXK/lIObirItKB9Q52qdQO17I6fSPr8dCxiooqE
         AZzyXo3GoKUjoTGAj2ZHOsiH4z77Qg16429l1K/e74ZYqvGAc7DD+doZebo1pxUBIdyD
         ClSAOd1ecBTGDlcj+7NUD12WB8LMamG/wCEgaty1wi47q28gvFEBMITtwxo4f3amSxV4
         ed9LVoBT5r3V661g6DdNch7flUFfkBc9KOoh3X9vwPl/IJAryLT02VBHWzqKC7HmVpDa
         +YxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+gS8H0B1fo+7WJ1aaAzesHd5/EXLKULuJV3RpXcsiS71kUPUSe2ww2vw+qMW9VqQgphEfU+sGCcEQB1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG2PNT9aoM2+iaq4782Bh8wEGKT2RBTEMM32E2TYeSSyUSgGFH
	Mr7jlp6B1I9dg8lENhdOgnzpoSzSmZoEvOnniMJv78dkk4wxJYX4EMdVvo4fPeQzaQc=
X-Gm-Gg: ASbGncvqTNM/BVwr5G54eO8GvYXRCM9RKet47oCYHFChw3vNrHuzkkOz0xNWYzU8vG6
	wi8eMlxoHSEq0+Mw74b0E4oDM21ERqGs3saOiZaY5BoDshUvwbqRmdFu5FKlPX3T5mE/lHto+Y7
	cRlWsczGZ2nVJPfDMcM/zxoR+j8366tswJ2ufMk+tXGE+39AQTPWGNl7hKAf53xnQD+ZtxyeKjT
	/wXWNFYkidUOb/Rr5qsZp7BCG84x4jj4EIPNgtDSmj2U3gDLVZIPkDq3g8PhEZwvsp2ipGREvqa
	+iQbONvlpRpjMX7N6oSU4Ke6qnfmfw7wDBdy9H+73XGgLT87hI9C6KADRtOXYFgAm5cZI7OWMeq
	IcOGb7U4m0FnoDr9BphOWkImWd+HazvBxkukXZlpAmcpS99lfcQQ4oMWAa/s6ADPVd483TnpA8l
	rVmX/xsXCA8JScZMe06OEBVfEErv31LOBpeUPpkdiHrW5WvA==
X-Google-Smtp-Source: AGHT+IE2QH0bYt9evLPt32Zmzpg6IE1jS/NHlYekxZETu/ShdgKYTlNUPI/Uj5DCmlG72yB5wBW9uw==
X-Received: by 2002:a17:90b:4c8d:b0:33b:cfae:3621 with SMTP id 98e67ed59e1d1-3436cd15e8fmr389381a91.32.1762546019685;
        Fri, 07 Nov 2025 12:06:59 -0800 (PST)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.. ([2409:40c0:27:d019:96c1:1e18:c1b7:e182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c3001f2sm3327186a91.1.2025.11.07.12.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 12:06:59 -0800 (PST)
From: ssrane_b23@ee.vjti.ac.in
X-Google-Original-From: ssranevjti@gmail.com
To: shaggy@kernel.org
Cc: jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	dsterba@suse.com,
	david@redhat.com,
	shivankg@amd.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>,
	syzbot+cfc7cab3bb6eaa7c4de2@syzkaller.appspotmail.com
Subject: [PATCH] jfs: Initialize synclist in metapage allocation
Date: Sat,  8 Nov 2025 01:36:45 +0530
Message-Id: <20251107200645.149093-1-ssranevjti@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>

The synclist field in struct metapage was not being initialized during
allocation in alloc_metapage(), leading to list corruption when the
metapage is later added to a transaction's sync list.

When diUpdatePMap() calls list_add(&mp->synclist, &tblk->synclist), if
the synclist field contains stale data from a previous allocation (such
as LIST_POISON values from a freed list node), the list debugging code
detects the corruption and triggers a stack segment fault.

This issue is intermittent because it only manifests when recycled
memory happens to contain poison values in the synclist field. The bug
was discovered by syzbot, which creates specific filesystem patterns
that reliably trigger this uninitialized memory usage.

Initialize the synclist field with INIT_LIST_HEAD() in alloc_metapage()
to ensure it's in a valid state before being used in list operations.
This is consistent with how the wait queue is initialized in the same
function.

Reported-by: syzbot+cfc7cab3bb6eaa7c4de2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=cfc7cab3bb6eaa7c4de2
Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>

---
Tested:
 - Tested locally with syzbot reproducer, no errors observed

 fs/jfs/jfs_metapage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index 871cf4fb3636..77c512a0a42b 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -269,6 +269,7 @@ static inline struct metapage *alloc_metapage(gfp_t gfp_mask)
 		mp->data = NULL;
 		mp->clsn = 0;
 		mp->log = NULL;
+		INIT_LIST_HEAD(&mp->synclist);
 		init_waitqueue_head(&mp->wait);
 	}
 	return mp;
-- 
2.34.1


