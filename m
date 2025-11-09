Return-Path: <linux-kernel+bounces-891927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8FBC43D4E
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 13:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53FFC3B37C3
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 12:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A052EBDF4;
	Sun,  9 Nov 2025 12:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+lNaAvo"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431372DF149
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 12:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762690780; cv=none; b=ahTjcsUquMk7q2piEliX/ZKyKj+9sS0h00GrQlO5La7faUBGVLrU+onIRiSiGPn6oKLr8Nqf5qSHgos6JYb8oqrJe50VdRaQzHTD3vCUtFyPVf5zGBEYuoECXETPp4nL27/Am78Tp8udG45Lg3TYHS3TCp0YYe951mYyzLF7Tig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762690780; c=relaxed/simple;
	bh=RI8OG7v0LCuN6zw8dyXHr6xSbJ0eZb2RqvOZGNNRbbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fImgl1CXs3Dpbq9sxB5KE2tMOo0cfXfSQYPgbA9H6IE+5wmqv1IL/nhoXvHJNIs2kGaUSjSZ+G3Z6Cfq50WzpmLNEiVav00fs0cQLyWS3epXArhCDBazmSFKwV2yO0e4HwrbyfnSDfO01dY3cUnU6q2DawyX9a2I++NwBI16NVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+lNaAvo; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64180bd67b7so378735a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 04:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762690777; x=1763295577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v+qAufXH6G8vBsUnnnyRTAQrC2PGUzHUrWi4FrePh40=;
        b=M+lNaAvoRVi1srqkxgTuB9YKTrp5a8JTVu9ZeaspUFQaZ+dIIRF8gurF54vQrbtVuP
         v46eGH7RNHr6dUfMpIb1qL01E91Yk2/lC5mM5ttBcDwAiJaxsr8sQN8kfjDRjQK5B/FA
         skJ2Nf+SEuT6xt/ztr4es36uSrd3paekBG4fk6FqzkNqRy/m2chN/X28ZGP5Jd1U2Pow
         L0ikXHC5hBGdhh8jDt7V9VFr5zZ+mTQM9C24rrWSQ93oUl5jgnviwaeYfYml7+6ErFFN
         pogtuvxn26uZvIZH1GMPI6DT1aVwEd2ckcZyV/c8NXSOVcpjffjtYlfUeJIUl6GLujhu
         A0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762690778; x=1763295578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+qAufXH6G8vBsUnnnyRTAQrC2PGUzHUrWi4FrePh40=;
        b=F//HEEfgn7Nd4lG7ig3WGjP2Wv2PwIVaveja9re4vRnKWlt2/knGdjwjR1P+Hrv5BN
         jaO8HiEH9EssvdhwjxDH4P3MCTXMaCUNecDGfwRRg/gO/Dslq7JhOt8i/8owjPTpF+KI
         X9B1j5fO0tcAmu7LmqFKNJBQqbjbICy29alJlSjhXJE3EpwDvJCZvCX+6rY+mgudpeV1
         LxGvPPx72j1lOsLxG8grs1OAUxkTaJe4eUWUcNpw8k+0ExwcA4hL9XGI+1B+p6EbCeiR
         N+ZHmic8cKUeKHI6yWyTCTehu8KIGB7MoNc4WiOJGw3FzbHF9TvknRplHIPSkjgkPETK
         ONDA==
X-Forwarded-Encrypted: i=1; AJvYcCVdqe9xYn4MPTmx0TQ07QKyxhdO8pD7HwebB3bA3UUQuZ7+gCo7ThX+iX7A9ZA/HY+1skc037WRwKV7CQY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy87NImym6cCVoq3k29wA41jPm04PE1wtY61GUZ/nssOJ+8EXnS
	EKZP5Tl8LJ04kNcihaZhuuP+lejPrJa6nj2wL9UPFyxcrIaPeySvHYuy
X-Gm-Gg: ASbGnctKkz1Qb83r8bC6yV5Cw+JNvsy8xjyNG0DiIGKuaWf4xvlYq/P2B19RPKnvsrH
	iA5jKR+yMuyNBz6hTRdmF1ZyAYIc7zoLjWVupSgevWWJaakLYKNwrF20W9hVmDN7CWnZfO3yaiO
	JE1xwgTqLIgakS1jrnh8tr+Rw4xQwFLVyXyDxFcNUyGMUM08aEre4SPcE1ctiynwV2OsaNf8qPI
	bPUJ4HHBm+V5LuNUHLq7FAVCpLdr9diU+py69ebeO1ILqgvayF9tK1yuaSW1t36AqdTQX3XZlPb
	uRrfo95o/YYhHRUVGM38FHaVwBKiC7Jxp86AT9a8HiMF+SL/4liVri5BkyBdZvpjaoV/vDukTPe
	P3MbWs9fs2Z6v3hthyH1zddzE+Aqx6QewjuGDVmfV45Ayt8Oci6TykZwWzsi4VmTJovavsHm98k
	jTQlgG+wJvjv/FtDHRlIYqe5bZUluUbQ8Gs78jbbaNJCJd1+jCYBPDP10p/bU=
X-Google-Smtp-Source: AGHT+IESsSrfC3NJ8IFNuotOFPOATY0CGb9MaPKj5bpd2i2c9yv5ol0qKlnUskE2eI2wayN6ZZs9LQ==
X-Received: by 2002:a17:907:3ea9:b0:b6d:7db1:49aa with SMTP id a640c23a62f3a-b72e05dac61mr464154066b.63.1762690777282;
        Sun, 09 Nov 2025 04:19:37 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72d7996c4csm600245666b.5.2025.11.09.04.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 04:19:35 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: move inode fields used during fast path lookup closer together
Date: Sun,  9 Nov 2025 13:19:31 +0100
Message-ID: <20251109121931.1285366-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This should avoid *some* cache misses.

Successful path lookup is guaranteed to load at least ->i_mode,
->i_opflags and ->i_acl. At the same time the common case will avoid
looking at more fields.

struct inode is not guaranteed to have any particular alignment, notably
ext4 has it only aligned to 8 bytes meaning nearby fields might happen
to be on the same or only adjacent cache lines depending on luck (or no
luck).

According to pahole:
        umode_t                    i_mode;               /*     0     2 */
        short unsigned int         i_opflags;            /*     2     2 */
        kuid_t                     i_uid;                /*     4     4 */
        kgid_t                     i_gid;                /*     8     4 */
        unsigned int               i_flags;              /*    12     4 */
        struct posix_acl *         i_acl;                /*    16     8 */
        struct posix_acl *         i_default_acl;        /*    24     8 */

->i_acl is unnecessarily separated by 8 bytes from the other fields.
With struct inode being offset 48 bytes into the cacheline this means an
avoidable miss. Note it will still be there for the 56 byte case.

New layout:
        umode_t                    i_mode;               /*     0     2 */
        short unsigned int         i_opflags;            /*     2     2 */
        unsigned int               i_flags;              /*     4     4 */
        struct posix_acl *         i_acl;                /*     8     8 */
        struct posix_acl *         i_default_acl;        /*    16     8 */
        kuid_t                     i_uid;                /*    24     4 */
        kgid_t                     i_gid;                /*    28     4 */

I verified with pahole there are no size or hole changes.

This is stopgap until someone(tm) sanitizes the layout in the first
place, allocation methods aside.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

> Successful path lookup is guaranteed to load at least ->i_mode,
> ->i_opflags and ->i_acl. At the same time the common case will avoid
> looking at more fields.

While this is readily apparent with my patch to add dedicated MAY_EXEC
handling, this is already true for the stock kernel.

 include/linux/fs.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index bd0740e3bfcb..314a1349747b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -790,14 +790,13 @@ struct inode_state_flags {
 struct inode {
 	umode_t			i_mode;
 	unsigned short		i_opflags;
-	kuid_t			i_uid;
-	kgid_t			i_gid;
 	unsigned int		i_flags;
-
 #ifdef CONFIG_FS_POSIX_ACL
 	struct posix_acl	*i_acl;
 	struct posix_acl	*i_default_acl;
 #endif
+	kuid_t			i_uid;
+	kgid_t			i_gid;
 
 	const struct inode_operations	*i_op;
 	struct super_block	*i_sb;
-- 
2.48.1


