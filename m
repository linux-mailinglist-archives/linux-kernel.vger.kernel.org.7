Return-Path: <linux-kernel+bounces-877275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1E9C1DA17
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 23:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D55991891D94
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B832E6CB4;
	Wed, 29 Oct 2025 22:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ln3Tvmi+"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C072E54DE
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 22:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761778690; cv=none; b=QFUebyIG3otd05j8oMEqwusZdRScaMa4tv6QKQXBiWVoO+X3yjbLdBPqhOItkNqKP4aII31i+PvEmb6qk6YTuXaoI8NzeBpmvpA/uvdHzK5EcHtKge3LWxExbmBGFfSHvnQCruKlLFAFUQvcNRn6WUpNrQy0AeVZTZw0dzSCnU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761778690; c=relaxed/simple;
	bh=R35boBO97p0Y3sowS7PP3Y56OecWAH0OL9cqtC4OFZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p2WFWlVICLX52nAqdaKWgd3C2ZzbyENfAD7/MM//TNzUgfa12P8TZbEztuTbHxq6++vfZ6SdQBCiOGWwcsUs4rbQNUxYOimModF3nRtx7lv8ZlkA3YHGOVAOZ5VeVJcHzJa8qEMgxOox3daB1w8CILQYPRJYNyVsHPuaKvVXZ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ln3Tvmi+; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3c2c748bc8so56152766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761778686; x=1762383486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xYrvBEQFYhC2vv51UNS1Ho/nte1oyOBTb9uNU2WpKKM=;
        b=Ln3Tvmi+rcFMT0Zlgaie9zQohn9ADtBg0EKc9Is8Vqjuh8XrvT3VfOfvyd/vgmr7rN
         cjGI0iF4oiXuS6ryqkq0hu7j95BwRN/S2TdthDzXO5GhWfAkSr56jkH5gHxDUPBYpZ5t
         diP0ZtRZ5v1xw5kUlDUV/yk2aeX55o/CBm6UjVISIADi3ZV1aqk0z5ypia97F/DQud+D
         HapFWil3JkjA8B3GSgN1hUHj4JTA7KvNwusgSOelRjPnT1wf/bvCNu1+rzdyCK+5dG82
         EUGz8kQvcr+FNW+9QZNMc7aKJxxCsSK5BRLEposn65sjK04ZUCmaHPsf2iBAxFAA2dNR
         69LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761778686; x=1762383486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xYrvBEQFYhC2vv51UNS1Ho/nte1oyOBTb9uNU2WpKKM=;
        b=upmSRfAScE87E+vqPjyzpWtZpYcPVP9VB89XSI3hvtD8uuRU4Eu4VerlVqk8gSHni9
         qmaa/M1SL2CEtuswJBlOrj4vLFjmK5V/kJOvz4qUOHSOfK9J/N4HQ3Pq9vpM8rV/cKSW
         cAWfrilHGn7woU+Dzgfx40IB4szn8qsb0YXEcXwYCr0iOYiBCZiL6FOfByG0rHw2mre6
         lQvHq9NUNMazrNBiRcBD9rOz5IiLInb7nqi/HhSUzw0PMmH/vq/GzrNOI+ZkfQqQ8epw
         VQlURLo6hW2wov5AGzPdhHo4BTceUElzqSIlfCrmLirhgewZW61pYeAqdVeX+AHIagPW
         3eig==
X-Forwarded-Encrypted: i=1; AJvYcCWW9JlRKR0rvOAMApd9MBEg/ASHCvchE3NspxOJnWNKeirpkcMgUOa5P7CMA3Arh3bw3Rv8LgiiYlC0/A4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+MvTPOVROgQX/B5+alHYbINxr1yucJdyLBd8m31LBMQQ5Z9cF
	HxO8sKn/9AaQYBLeS/2i6dn1wUCP1KGB0k+b1fKvdHj+7O2W6j0+dF6xY7cpcvgU
X-Gm-Gg: ASbGncvjr4dlmrEJCa82xyKjj/5UPDF8bltlSAsMo47cFlKMHETSQ55pEh4QKNI6uOY
	0NgRGYkU3nqRMVBhVN9gurIEFFuLKuNyX87hFStVpr1Va+aNVJH+YtB834PtO+tmzsy+C21t/k3
	2JMcHcP/SIkmFSU9yYzMH8fD0xEIXcgbS1/3HQ8DuLlnvyGKTMQsRMLdS2PbkGib2CKTiev/G5r
	ZkiRD+gjKzsr1uwok5DjUhZLpAaSmAPJi1QaeqAtOpswnx0FWCUyoIBqE3vl+ii8N9yQBDuShyp
	czC7Wox4onHk38dvY1or5J8m1U/oFEe7xd3fzMZ+NegW5MVm8AbpenyeS931Nn/HVifj7Ae7g/l
	/AxN2YXJZWl77ddC9ZM4GO02wfeiawJ7G3TBjRwnKaV7vN5I/2XU+5UpZMqi3rKhepKuj/GbyTG
	gU
X-Google-Smtp-Source: AGHT+IG4M+TrFZ+WvBWMivsgusTfxTkskwi+ZZSO0k5cw5412piiRHZ3q1efPw/ibuWapgCjmuNcfg==
X-Received: by 2002:a17:907:7211:b0:b40:6e13:1a7f with SMTP id a640c23a62f3a-b703d38ca50mr510498066b.27.1761778685725;
        Wed, 29 Oct 2025 15:58:05 -0700 (PDT)
Received: from eray-kasa.. ([2a02:4e0:2d02:232:b56b:334e:6279:ccaa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85309074sm1559094666b.2.2025.10.29.15.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 15:58:05 -0700 (PDT)
From: Ahmet Eray Karadag <eraykrdg1@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org,
	Ahmet Eray Karadag <eraykrdg1@gmail.com>,
	syzbot+b93b65ee321c97861072@syzkaller.appspotmail.com,
	Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Subject: [RFC RFT PATCH] ocfs2: Mark inode bad upon validation failure during read
Date: Thu, 30 Oct 2025 01:57:49 +0300
Message-ID: <20251029225748.11361-2-eraykrdg1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Potentially triggered by sequences like buffered writes followed by
open(O_DIRECT), can result in an invalid on-disk inode block 
(e.g., bad signature). OCFS2 detects this corruption when reading the
inode block via ocfs2_validate_inode_block(), logs "Invalid dinode",
and often switches the filesystem to read-only mode.

Currently, the function reading the inode block (ocfs2_read_inode_block_full())
fails to call make_bad_inode() upon detecting the validation error.
Because the in-memory inode is not marked bad, subsequent operations
(like ftruncate) proceed erroneously. They eventually reach code
(e.g., ocfs2_truncate_file()) that compares the inconsistent
in-memory size (38639) against the invalid/stale on-disk size (0), leading
to kernel crashes via BUG_ON.

Fix this by calling make_bad_inode(inode) within the error handling path of
ocfs2_read_inode_block_full() immediately after a block read or validation
error occurs. This ensures VFS is properly notified about the
corrupt inode at the point of detection. Marking the inode bad  allows VFS
to correctly fail subsequent operations targeting this inode early,
preventing kernel panics caused by operating on known inconsistent inode states.

[RFC]: While this patch prevents the kernel crash triggered by the reproducer,
feedback is requested on whether ocfs2_read_inode_block_full() is the most
appropriate layer to call make_bad_inode(). Should this check perhaps reside
within the caller or should the error propagation be handled differently?:
Input on the best practice for handling this specific VFS inconsistency
within OCFS2 would be appreciated.

Reported-by: syzbot+b93b65ee321c97861072@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=b93b65ee321c97861072
Co-developed-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Signed-off-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Signed-off-by: Ahmet Eray Karadag <eraykrdg1@gmail.com>
---
 fs/ocfs2/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index fcc89856ab95..415ad29ec758 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1690,6 +1690,8 @@ int ocfs2_read_inode_block_full(struct inode *inode, struct buffer_head **bh,
 	rc = ocfs2_read_blocks(INODE_CACHE(inode), OCFS2_I(inode)->ip_blkno,
 			       1, &tmp, flags, ocfs2_validate_inode_block);
 
+	if (rc < 0)
+		make_bad_inode(inode);
 	/* If ocfs2_read_blocks() got us a new bh, pass it up. */
 	if (!rc && !*bh)
 		*bh = tmp;
-- 
2.43.0


