Return-Path: <linux-kernel+bounces-720673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 755A9AFBF1D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D6F07A7758
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 00:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2ED9AD24;
	Tue,  8 Jul 2025 00:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHqmIUgC"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BB05383
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 00:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751933465; cv=none; b=LV9UXIklb90YRM/czJXW1eyigKjgMPsAnT68XPoLno8j19MntFHTFhf7g/M6DlU9AaoDiQPhCM2ZGau4qWmJydlv+VJZahKjge5xOVujUz0Bc2b8/UdOP4GIfGTXO4Mm7yeEGS9eWjvIL75otTuX0ioaimrT38t2dt9Y5uRM+Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751933465; c=relaxed/simple;
	bh=hTEgnzFsn58I7qCWXrtgfCzqxG3NFcTiCpWp5P3knE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sVfBDtRRZfCexeR3e6cXM5+LDBqOHyqVfYJwXldkJMMB0w49VZL4oyLD/M0pWoH+nNvNWSN7GztFuENQtElM9z61dF6LqvcinWdOS3u7FHuNIuVTejSijdCk4Rg7PIpG7oTPln24EE8KDDsK25dK1IDR6UD8kZ9SCcLNS9BwC7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHqmIUgC; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-23dc5bcf49eso21274655ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 17:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751933462; x=1752538262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BfCZij8RJREKbVNdbJw+wlokllFTjyfrm2PqoXoq6YI=;
        b=IHqmIUgCL/dv7EZCoz8C/oN2F6dHrvC60juaOx9sxfSpo/Lu9MO+a7lFrsjg+qE2gM
         vRyPce/ctL2ebDjGinzK1syRbAFzGpS8upJaIQb4NGuwHr7eTq9I1Qy3DX9poyI2UkNN
         At8h81yFB9DU9Wf/kkJxQ0pAD9xWrdUqb/ZLfX2eAkTolQZt10+tKH+tioMcryuma/rg
         Pw966BZWyFUlxMYSHGtZ4FGjv/EKB7xKeIjTLhOhnS9MJ+rua6540BO9R4y7Ob6+q+Ar
         zzJCfeHXPoPwjMi71R1++Fg22xu4TtsOOgtnDkT1e0jfssTZMLIyXHkYKr1fBKi8UMS4
         2K6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751933462; x=1752538262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BfCZij8RJREKbVNdbJw+wlokllFTjyfrm2PqoXoq6YI=;
        b=O6Ed4gpR7T6vIbHvPfj/980UVxt0ismAJvV2+DmpP5R2qCGfy2jQ90gFEoitjqh8J6
         N374m7ivKRBb5sQXmuyl+GG1CwexIjInmHd4AWxxZ041ZnKpC1+2FYKeFVJTYGhPZW95
         huVPeNmemKbmHL6P7GW9G9kqDTVRpmfT6rmJtDPRESlQ3Gims59dGD5m0XpHWPrG86dN
         B7hBQ0VhBijVxRE+O86jEDd3GLfe441AhjTdgQTs/5/3Uu3/lYs7O09VKL75cc1RwY8F
         VErZoG9CorVrXzv+17oPP/tKDgEMG4Wabjf/AZUJIlh2liODRA3Bc7TPC1bIPPKzRLZl
         aXNQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/Mx6d4o1TOALlVLRwpucnNGiUuH+BeDDCMxPgNXSqMPq3LaColeQ+DOe+ih26Ebs36ijCAIejoX/DiUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEwrOa7vj3aRWz+lf4PWJKB7Tsx50hZE+40TlNGcQAcs2317SZ
	VPJ1e1NurX+cLDFCbDGzH2goJSe4wI85MBDblC+LeBe4I2QgOD2vukde
X-Gm-Gg: ASbGnctxvKapM0gZmHA2+CmzPVzoPtUMj9E6yydRmci682/t/OQLFDC51QJVahPDjmj
	otXqwxrAnG/YKXwUe4D0jujtKJVpX5EdVDdB7W8lzKqKF7foAdkQuGki3GcJF6DFS6m4zLkqmed
	5NJVvcfSq00HcEsmLsWGtwmaYSoQyN9DMoZ9d9u8KHDjQ9Uu0dWjaJKILoWE8IM/owqU3NW3HdK
	f6fCwscn66K8cOrcxU1BEKtDoWCY6pb/pQ9f0uZZllgMtyz1iiV/6tg2LBastPKDj5aQYLW/Dqv
	Ad4OMfvLcGm4C2r2zvuh5H2v3hZQhd6cnbpjdFZMlpp3EICwUcSDeL2atI4GMwO1cymLPEuJVd7
	o3OUbwgSfXLVdPmQAkGxIt8nNvfjn6NDEpjsCQyc=
X-Google-Smtp-Source: AGHT+IGLVmMcadCxwlrT4ZGji6+CcJm/SC8kmOZnTvgPO526njwVB4crClOviGUc7HUtFOwFwrs4nw==
X-Received: by 2002:a17:902:ea04:b0:234:c5c1:9b84 with SMTP id d9443c01a7336-23dd1d586cfmr7340745ad.37.1751933461712;
        Mon, 07 Jul 2025 17:11:01 -0700 (PDT)
Received: from ipravd-Nitro-AN515-55.hsd1.ca.comcast.net ([2601:646:a000:5fc0:268b:48b1:88cf:6e90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c845bd366sm102928615ad.240.2025.07.07.17.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 17:11:01 -0700 (PDT)
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Ivan Pravdin <ipravdin.official@gmail.com>,
	syzbot+20282c1b2184a857ac4c@syzkaller.appspotmail.com
Subject: [PATCH v3] ocfs2: Avoid NULL pointer dereference in dx_dir_lookup_rec()
Date: Mon,  7 Jul 2025 20:10:09 -0400
Message-ID: <20250708001009.372263-1-ipravdin.official@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a directory entry is not found, ocfs2_dx_dir_lookup_rec() prints an
error message that unconditionally dereferences the 'rec' pointer.
However, if 'rec' is NULL, this leads to a NULL pointer dereference and
a kernel panic.

Add an explicit check empty extent list to avoid dereferencing NULL
'rec' pointer.

Reported-by: syzbot+20282c1b2184a857ac4c@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/67cd7e29.050a0220.e1a89.0007.GAE@google.com/
Signed-off-by: Ivan Pravdin <ipravdin.official@gmail.com>
---
v1 -> v2: Changed 'Closes:' tag to point to the correct bug report.
v2 -> v3: Added an explicit check for empty extent list before dereferencing 'rec'.

 fs/ocfs2/dir.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
index 7799f4d16ce9..acbae902ae3a 100644
--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -798,6 +798,14 @@ static int ocfs2_dx_dir_lookup_rec(struct inode *inode,
 		}
 	}
 
+	if (le16_to_cpu(el->l_next_free_rec) == 0) {
+		ret = ocfs2_error(inode->i_sb,
+				  "Inode %lu has empty extent list at depth %u\n",
+				  inode->i_ino, 
+				  le16_to_cpu(el->l_tree_depth));
+		goto out;
+	}
+
 	found = 0;
 	for (i = le16_to_cpu(el->l_next_free_rec) - 1; i >= 0; i--) {
 		rec = &el->l_recs[i];
-- 
2.45.2


