Return-Path: <linux-kernel+bounces-829002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A52B96053
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B9E2171130
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D944327A26;
	Tue, 23 Sep 2025 13:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwnl+GsQ"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3844D10F1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758634375; cv=none; b=W+axNKJuF/HNMkKmwTlmee4lfjAYn0ksBn3Y97+NdI6CHy18Ykm94c6IZ5sDj4p6/luh/inUggFFXxLyvT74cchi4rjuJNeOvg5/gikcWF2RYLaxp5YBsj8VvKKmD1ZIkUdztnXhtH1l0MfdZaIqDQRmkT3TnvYYIcHJtGYenb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758634375; c=relaxed/simple;
	bh=0F8N30aDt+Ip9ck/9yn6rnpd6B3yfaEXU9Mdo+Q7ceY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P45wu5hbjO7hOgp7jAOa+o/qzD4ecK4PkmALuK1mSoaagLpx+4aF8qZaFxXCGMlaPSYJBpD+oSw79Cqh9xu215X+/Pu+7ks5gKk6Ke4oBY6PQq/QHDqIznuu2Tsw9NggYJX0f8Nt9SVUoNZWZJmehhMhoC/VQC63WWghRjDosjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwnl+GsQ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77f454c57dbso1518859b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758634373; x=1759239173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8xSpZuIXT8IPaVfu+hEn4+A5NlUoETUpDfjWE4MNCG4=;
        b=bwnl+GsQCv44gk7g28aAIDK/UQCwRuBTk/ydS2HS8N5seFgDuj8P4lP4g5vtu04LPo
         nQdKwJY2nXVljOi8lkEoBhDJ48R5P6YP/Ou+lZtZnVO+JhZy9jr8FUv8XbW/zimR0bI7
         t18CAlC9Megue/WIKV6jBh8JQx2WjxX0SSWu0OimdvjXAS/3w+Nu6ihZKxyP/87taX9c
         +lfIzAG+/lb9M4ZpafB+ukJBopuzySk93ETOU4pNg5JouF7yJS90NnK9VxB34V9dzZX7
         4DdxDlSt6dF7lAti7CQnMxPqN19T1eC1Jz4sAeqKuNfuIDLokjRPcoZ+bRmY2wusLDmh
         7ZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758634373; x=1759239173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8xSpZuIXT8IPaVfu+hEn4+A5NlUoETUpDfjWE4MNCG4=;
        b=r608QYW4Yd9E4ZiYxdrQQnYS4hnZRrAp333pagasCG8DPQB1L9fhhNVoDnpa5UIgqM
         0kl5imojAeN8HS1xo6ye03zru3MwjRoB2RKJ/YXY3ZdAZvXz6hDn8Zuar2rCGhHeeWRv
         HBEWOntpFvXYEjxSbraA6pXmIC7B8XkcvS7CFV7lXH2gjN3EFgQSFojS949IOpPtl0Uh
         mN2bXrmYe3K5LchZe6DXhVUD9+9FS24bd8RkC5mv4+TasMGWNgPz2HtLeuzf03jeU/0A
         Jp4Ox43oGjVzLYEDXRGF7XyXactk9Kpo/V/LsVkIml7TuTL9xeeILPJq5ducO37IfFNm
         /NQw==
X-Forwarded-Encrypted: i=1; AJvYcCVWDWcA3OREBGogGS0NwXn7G2nzPwDOpLvUFs8Sg1amSc8XiXRqLypU8ADiAN4BvcXqBfi7QGZm9QX5rfE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6wu1F9gNXMOqYvq989HMfa5nuvwaQcNCmzr/bDEBeWxHu2q69
	W/MSAgKJO94Y3wZqBILgkCB6AXO+H6BglatOu4iVbbwH59aCFu9MkF2IDGlT4jsP5/w=
X-Gm-Gg: ASbGncswSI1r+BHlLTZ0Tq2g8I9tNdC89awuhJZfxYD2s1yUFsXevTXeDkb/SsKfEq0
	PEguZtdD52ZdInrCTz67MEiwbm2qxbbeo1lPXKBfPRs5SBxoM1AeqR6V6+BwJHzQcyXlSKB2Iyu
	4w+Ub1e3twHOl6tw8a0cMFGIeIRYNH4WwtH5WzARHudwlBDwtxznLtinKMA/vmWnnVWc7GC4giC
	N9Wf9YaYY8xgtpasbcpJSIZ2/zrlJdYUeAyZnLcn16Fwysj4FUczPjl+YmtCrczOpkhatRxfUSg
	BEQG+lf+YfVzotN6JySEVIgp2F8un8Gk+FU4xSOcNvNKsADyZ+FaCmvUOO+LwbryBT2xR43rI/i
	GuIFpnKVoWi4qOCIQAvN4BI8hVaU6QGUmQ+c4SgQIZtvEq+tUzSQKA/BKsCaj290FnhMFOwNQG4
	iZ4RA=
X-Google-Smtp-Source: AGHT+IESpR/eL4ucXZsJRBLa8ofI+j2C8Dox1vR6EjVmyZeEFa5+hb3Y874B7sJx52CTms2hn2ZeAg==
X-Received: by 2002:a17:903:3550:b0:246:a543:199 with SMTP id d9443c01a7336-27cc836c35emr35903835ad.54.1758634373173;
        Tue, 23 Sep 2025 06:32:53 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:8149:fd18:c8eb:ab78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980366b2asm163463505ad.148.2025.09.23.06.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 06:32:52 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: tytso@mit.edu
Cc: adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+4c9d23743a2409b80293@syzkaller.appspotmail.com
Subject: [PATCH v2] ext4: validate ea_ino and size in check_xattrs
Date: Tue, 23 Sep 2025 19:02:45 +0530
Message-ID: <20250923133245.1091761-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During xattr block validation, check_xattrs() processes xattr entries
without validating that entries claiming to use EA inodes have non-zero
sizes. Corrupted filesystems may contain xattr entries where e_value_size
is zero but e_value_inum is non-zero, indicating invalid xattr data.

Add validation in check_xattrs() to detect this corruption pattern early
and return -EFSCORRUPTED, preventing invalid xattr entries from causing
issues throughout the ext4 codebase.

Suggested-by: Theodore Ts'o <tytso@mit.edu>
Reported-by: syzbot+4c9d23743a2409b80293@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=4c9d23743a2409b80293
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
---
Changes in v2:
- Moved validation from ext4_xattr_move_to_block() to check_xattrs() as suggested by Theodore Ts'o
- This provides broader coverage and may address other similar syzbot reports

 fs/ext4/xattr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 5a6fe1513fd2..d621e77c8c4d 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -251,6 +251,10 @@ check_xattrs(struct inode *inode, struct buffer_head *bh,
 			err_str = "invalid ea_ino";
 			goto errout;
 		}
+		if (ea_ino && !size) {
+			err_str = "invalid size in ea xattr";
+			goto errout;
+		}
 		if (size > EXT4_XATTR_SIZE_MAX) {
 			err_str = "e_value size too large";
 			goto errout;
-- 
2.43.0


