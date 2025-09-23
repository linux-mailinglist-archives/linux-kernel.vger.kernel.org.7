Return-Path: <linux-kernel+bounces-828800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EF6B9580D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E42A73B06B8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDD9322773;
	Tue, 23 Sep 2025 10:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhZGN+uX"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F26322740
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 10:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758624457; cv=none; b=G36WD7LXb0CMTmQg7mtDx4wrlorlG9iZzpgTk6xpU11NXZGF8KYRyXwa4BtMfgiGkMfY3VFq3Dop3gsQV1akSA0oDz++/zYpeBrgB5prVOlAMk5pqr5HseBHpL1Orl/KIpcKXTMvqfwaPwz/yjeuIULwGCJ8BXtj/2Xyr2Xii4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758624457; c=relaxed/simple;
	bh=ouMLdiYXJEV/tbThHG/kXZjFoWBywpLKJo/Paio0wwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZMI0ZGMtVABbJozoMwcljYQDVLJhzNaNiSKY0VViJXWU4lwgEylpwKJckVDsLz9/HlpUt4uO7wGq4KQzv4xiBsoATA9Z3WfZfJ1dC2CSNEy/mrJJ8otKBq1rsNGS6VnSKeDc8mw1whs3vS+aiESenEK6bf6CkVULho8gHg4oXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhZGN+uX; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46c889b310dso24389045e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758624452; x=1759229252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjQhtecysAf2+Tm/SiAxvWYNu2I/ZUKX2kulTrssyjQ=;
        b=LhZGN+uXvnRcZp/BkNSZYpY3HLnrF3MIXUHwRe5694SHPoiXPSjIF5o1Cx+hffoY2D
         wLQnIdbqbp35ju7NMkMmutMG6NxIK8kC9I0PKqjPRo3MlN6mwCJzofAiR4aChInAl7Dv
         uaazvsOcIgmaXfy/dWRVf/OhqHPCYnw40d9hV0nqJHuGnrYlHFvc4aKobLXWjPH/DEGO
         5oFXfC+bDh/jOq/E0hzacTXcCu3dhKCjCeiUmPNy1FWresmWjR9SPuCx7AQWtSGJxaGZ
         jYjbsboNrycDe21fu6Ip2tQufSoGiGGCcxId78Js5h4L5suYrY2HneCBlUZX9HB6XZjW
         d+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758624452; x=1759229252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UjQhtecysAf2+Tm/SiAxvWYNu2I/ZUKX2kulTrssyjQ=;
        b=aoNfGuTjFSAu30KKSSj9Dgyl61ghWqth7uZM3plgr9HV4zQwcSbnb0hAAolo/vDgaE
         AqAXVVQ4sPER7uBx7Z4uB+phqeON392SqylHoqAxl4YuXB1Tv+6RKo5rxKu3SAimJZSk
         V30RXg0WWLAgLYTMbgxkvIlBgOYIWxLLT00AMsYEwlMZU/s9eLWH8IYN4fFDSeWakRL0
         St4Yku6YXuur6SVhdAhJGlfnp/pWkJjVmqudqMtN4hKZs20qXzph+f0vzeAk1HfyciD+
         ezdftRP+WjUmavVW5DAaSVfNkU9cC9wfBpnQaY3Er84PIKjApaDUAH7nYBCzgVXlS0zQ
         9chQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP/wKmDIXl+oLUKBQp6DYQK+1TUEfj2LBBkXTPCO1PTh7A1jfsIowLe/989zhhtsCerSX5gNkUBta/IY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1ydcB6yDPcDql+if3czdZ3a/ukYdfXn8LgzH7Q1MNeuXLG7ZH
	JsTXiRRfiTgJirR4ZUDQ8NqzI+Kwj7w4p/cFbcHig1Ve4xnx03zdvVK7
X-Gm-Gg: ASbGncvReN/dKodWW25Cz4x713VIxDcYJ24IR9T4CkPB2ddmtHq/BXhUY0QkUrZ5mL7
	5Y2cvlgm7pULEFfbCxtJkurnzK3AA4HhxSllLzzR1PRo1XIV1iDHyNLr8Dp33hrr+5VhcHV3rpH
	E8ioHQJDRe93wQJuCFzgjChnWYYJbGc6BDM24ev4Gzf4oHka/5IM3Pi3h3fjIl7UC1CfQDvUzlW
	29fcfX/iLXYUDf3VnCL+KmDMMxjAZ/nuYlY/cINCxA/67gDyq8TD/qTEpHTTTPd2a28rhmqC/2Y
	I/IiFcYONOwUrX87LO5kUygZ4qS9BRoOLZGiLnSX+qzBeDkC9BTRfCQ6dvzmZr7VoKRQQMLSjbn
	2zOFVT1NJTGx4HKk1bVbOpVK788jsIBm/5QPpWM1TxOX4GhsPjigS5dDGoZXZiBe7L45zJyVLtz
	lJwgrw
X-Google-Smtp-Source: AGHT+IEVb9i92+ZMOauFSkmxexkNVrc4dNm4CbgsPp4IcZSL124eR4borVyarFVwdram0vM+rxqviA==
X-Received: by 2002:a05:600c:4685:b0:45c:b6d3:a11d with SMTP id 5b1f17b1804b1-46e1e1121edmr21348615e9.1.1758624451919;
        Tue, 23 Sep 2025 03:47:31 -0700 (PDT)
Received: from f.. (cst-prg-21-74.cust.vodafone.cz. [46.135.21.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e23adce1bsm9710525e9.24.2025.09.23.03.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 03:47:31 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	kernel-team@fb.com,
	amir73il@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v6 4/4] fs: make plain ->i_state access fail to compile
Date: Tue, 23 Sep 2025 12:47:10 +0200
Message-ID: <20250923104710.2973493-5-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923104710.2973493-1-mjguzik@gmail.com>
References: <20250923104710.2973493-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

... to make sure all accesses are properly validated.

Merely renaming the var to __i_state still lets the compiler make the
following suggestion:
error: 'struct inode' has no member named 'i_state'; did you mean '__i_state'?

Unfortunately some people will add the __'s and call it a day.

In order to make it harder to mess up in this way, hide it behind a
struct. The resulting error message should be convincing in terms of
checking what to do:
error: invalid operands to binary & (have 'struct inode_state_flags' and 'int')

Of course people determined to do a plain access can still do it, but
nothing can be done for that case.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/fs.h | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 73f3ce5add6b..caf438d56f88 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -782,6 +782,13 @@ enum inode_state_flags_enum {
 #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
 #define I_DIRTY_ALL (I_DIRTY | I_DIRTY_TIME)
 
+/*
+ * Use inode_state_read() & friends to access.
+ */
+struct inode_state_flags {
+	enum inode_state_flags_enum __state;
+};
+
 /*
  * Keep mostly read-only and often accessed (especially for
  * the RCU path lookup and 'stat' data) fields at the beginning
@@ -840,7 +847,7 @@ struct inode {
 #endif
 
 	/* Misc */
-	enum inode_state_flags_enum i_state;
+	struct inode_state_flags i_state;
 	/* 32-bit hole */
 	struct rw_semaphore	i_rwsem;
 
@@ -906,26 +913,26 @@ struct inode {
  */
 static inline enum inode_state_flags_enum inode_state_read(struct inode *inode)
 {
-	return READ_ONCE(inode->i_state);
+	return READ_ONCE(inode->i_state.__state);
 }
 
 static inline void inode_state_set(struct inode *inode,
 				   enum inode_state_flags_enum flags)
 {
-	WRITE_ONCE(inode->i_state, inode->i_state | flags);
+	WRITE_ONCE(inode->i_state.__state, inode->i_state.__state | flags);
 }
 
 static inline void inode_state_clear(struct inode *inode,
 				     enum inode_state_flags_enum flags)
 {
-	WRITE_ONCE(inode->i_state, inode->i_state & ~flags);
+	WRITE_ONCE(inode->i_state.__state, inode->i_state.__state & ~flags);
 
 }
 
 static inline void inode_state_assign(struct inode *inode,
 				      enum inode_state_flags_enum flags)
 {
-	WRITE_ONCE(inode->i_state, flags);
+	WRITE_ONCE(inode->i_state.__state, flags);
 }
 
 static inline void inode_set_cached_link(struct inode *inode, char *link, int linklen)
-- 
2.43.0


