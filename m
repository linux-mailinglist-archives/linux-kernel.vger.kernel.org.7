Return-Path: <linux-kernel+bounces-846405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9355CBC7EAE
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44F6C3ABF6A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739402E8E0F;
	Thu,  9 Oct 2025 08:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbvDejU9"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F263C2E8E1F
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 08:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996814; cv=none; b=ZzNloB7YT2t3596d9SLuB6j/GA8xFjWMDufjR9qFd2TAapvroHlNk/y4OMJ7gC3fInfBsqMIwxF4B1Dh4NQcToJ69DtcKyqvlhS0TVATSf8ff1sbcZDFUeVV/AILZw7bhEoIabiwYu0jRtYbiPXAESeDUOhuTxF2WBjw0jqOl6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996814; c=relaxed/simple;
	bh=xlG7nR5Wpn4toAnFh4yZG5U7bqMO2Ibqli2pgrWdpe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZL6FRb1OVnnHsr1uEXPTeoIZfQ1w5JUUYDKi4bryStE2diJ2TU6tiMnUKXasKHzvvOuJqugSxWzV6nvc7sz6pbTYO4YbSWJabmmi5o9qMfJY9r1FOc2DVe0q8mI0myJpx/mbTjiWRdtkP3gj6aVKIbLbNxczmVpAligdfm9jO5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbvDejU9; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b456d2dc440so97379566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 01:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759996809; x=1760601609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5cEv8KCvxqRx2Vo792Uxij3yHT/Pkk8+e6W56mfmGo=;
        b=SbvDejU9ggXuvwZcyBQN7Wh/w7QFoavPE+9gM8uuiuVmO1ELw5sKW93FFpq0UEpTkq
         Ryj/7rO/SHMvr+NwtFE5QTSf5WS341LygOQn3KW7t0vLGZCQTLjHrjRyobIyOLnCITUf
         tzlzCFocGJ4GpNMGGc8xHvX9bSHUppgKd1qcC+NjyZxY8Z7hp+K3ixktQxfiZtv7ESnw
         xndW9hExYjaGy3CHpa5bkadYCG5PWfhGVNiCZT9uLlc+c8hEjNrRTCQ82+h6MLHDdNu/
         WvQgPk7LktcDwjsfXh7eYvK/3q2818LaXoD+P0Hwqy+j8s9Z8YVRBE6t9qPBrNSb0JHf
         54fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759996809; x=1760601609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5cEv8KCvxqRx2Vo792Uxij3yHT/Pkk8+e6W56mfmGo=;
        b=RdWSWrRivUKxu1TF7yAsvJAYjeb+/WBwlP7ivqowfS4wXdUeuXsaiso76QphGbDuGI
         LIYwAxjlpqjLDe2XAYMMR0fsuCE12h9KmMRrZYfOOYVha15tp5SHv3l5sDomvWM7Y6sI
         TYuyJ7uAG+ZY438W6lNK671rx2TaJHGA9gvqp+LcT3r6FaD3jktHZ5Q8M5tYQsF/2Hb6
         PypElOG+X1UehRGVMZp+MdSyRGqkraxYkDmflOTja8vSJOuxfBmMHKcHZXCCCED4o6Hb
         Rxo6+ecXixa7m8EDhFGDsFPPxzggeSXR58T8eJVV3F/D5dPQlvdJKBj4rT9jlAURVZN2
         s0tA==
X-Forwarded-Encrypted: i=1; AJvYcCVysIqAG0LmAzdNXywbFzrg4jz6eOqpyWbqqwHjGDZiAsiv1dNCSJaH6KUGhzDEVDZubvE9Pr1a/aw9nq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywzh6UXJnVIY19NOhzrWc5BdOIGoBXnKT3Ix5qYVrHrn7I2Ug0
	ATb5g6Eab7HMaLVriXNGEdkJ5qTX45NiItpYz5QZjvI/Ofb7wzxzosfq
X-Gm-Gg: ASbGnctCdRUn2aYr96Z6V9/hsJjWrrUy7B7523pFi8iAmkkm2VLYKjsqAyhAYE02iXc
	9Y4cnlpmoMWmI4qfhj7Zes44VoTRfTeUtVvkNv9LVAnZButwNeIz5bxcs5TOtaL0ygsnA+y1RYK
	DxB+55K+3BZmsRT5ox4HJdfp+ZbSHXYgKUeDk3fpEqd9KIx49GAb/qarbj9F7Bs2nILuJ6HjkSs
	GlI4aMCDERcuu4LTKO1tKlA6St+WkvWcpuKYuN6nxEHZLhrftb8WsDBC18h4ERbHaS2XpEe+ufu
	YvcLJLIHadblE/AKjYA2yaZ38RRegBCjDZ+yVvgml9wrbHFvlGsGBWL/302UVMcSNhCoWL5eMUH
	Ei7UJ4f7bI34RSlXisKKvBk7PMa99badSLv6EzpqnEleyoSLnciCXIIDcS1f5BNUhA7PpiabrLs
	j1jNVmOf66SAtNNMXPR3R12DpJsTbQ5u8L
X-Google-Smtp-Source: AGHT+IHLM13r5LQMnt/OJInRecUisomAa2MvrC2cG1/52NjvwtuMZLiyrwCa048XZprJyFm6wajB2w==
X-Received: by 2002:a17:907:3daa:b0:b40:5dac:ed3f with SMTP id a640c23a62f3a-b50a9d59a8cmr718516366b.7.1759996806312;
        Thu, 09 Oct 2025 01:00:06 -0700 (PDT)
Received: from f.. (cst-prg-66-155.cust.vodafone.cz. [46.135.66.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5007639379sm553509366b.48.2025.10.09.01.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 01:00:05 -0700 (PDT)
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
Subject: [PATCH v7 14/14] fs: make plain ->i_state access fail to compile
Date: Thu,  9 Oct 2025 09:59:28 +0200
Message-ID: <20251009075929.1203950-15-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009075929.1203950-1-mjguzik@gmail.com>
References: <20251009075929.1203950-1-mjguzik@gmail.com>
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
 include/linux/fs.h | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 77b6486dcae7..21c73df3ce75 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -785,6 +785,13 @@ enum inode_state_flags_enum {
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
@@ -843,7 +850,7 @@ struct inode {
 #endif
 
 	/* Misc */
-	enum inode_state_flags_enum i_state;
+	struct inode_state_flags i_state;
 	/* 32-bit hole */
 	struct rw_semaphore	i_rwsem;
 
@@ -909,19 +916,19 @@ struct inode {
  */
 static inline enum inode_state_flags_enum inode_state_read_once(struct inode *inode)
 {
-	return READ_ONCE(inode->i_state);
+	return READ_ONCE(inode->i_state.__state);
 }
 
 static inline enum inode_state_flags_enum inode_state_read(struct inode *inode)
 {
 	lockdep_assert_held(&inode->i_lock);
-	return inode->i_state;
+	return inode->i_state.__state;
 }
 
 static inline void inode_state_set_raw(struct inode *inode,
 				       enum inode_state_flags_enum flags)
 {
-	WRITE_ONCE(inode->i_state, inode->i_state | flags);
+	WRITE_ONCE(inode->i_state.__state, inode->i_state.__state | flags);
 }
 
 static inline void inode_state_set(struct inode *inode,
@@ -934,7 +941,7 @@ static inline void inode_state_set(struct inode *inode,
 static inline void inode_state_clear_raw(struct inode *inode,
 					 enum inode_state_flags_enum flags)
 {
-	WRITE_ONCE(inode->i_state, inode->i_state & ~flags);
+	WRITE_ONCE(inode->i_state.__state, inode->i_state.__state & ~flags);
 }
 
 static inline void inode_state_clear(struct inode *inode,
@@ -947,7 +954,7 @@ static inline void inode_state_clear(struct inode *inode,
 static inline void inode_state_assign_raw(struct inode *inode,
 					  enum inode_state_flags_enum flags)
 {
-	WRITE_ONCE(inode->i_state, flags);
+	WRITE_ONCE(inode->i_state.__state, flags);
 }
 
 static inline void inode_state_assign(struct inode *inode,
@@ -962,7 +969,7 @@ static inline void inode_state_replace_raw(struct inode *inode,
 					   enum inode_state_flags_enum setflags)
 {
 	enum inode_state_flags_enum flags;
-	flags = inode->i_state;
+	flags = inode->i_state.__state;
 	flags &= ~clearflags;
 	flags |= setflags;
 	inode_state_assign_raw(inode, flags);
-- 
2.34.1


