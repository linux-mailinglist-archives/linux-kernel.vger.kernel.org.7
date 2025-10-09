Return-Path: <linux-kernel+bounces-846394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2512FBC7DC9
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAC593B5FFE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B6F2D73A5;
	Thu,  9 Oct 2025 07:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E55vTmMQ"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAC12D2398
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 07:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996789; cv=none; b=D2k+VcF4R/0FyX+XZkd8vYLSFcX69QrdQAdoGOqL/0EtT7WKB07zSm1G0cyU2lf4ynXriDhgmBFc936IMBjDXV8qr4rHutpRU1NFRggUB28PjxGR4u03bV1VzBgiV8SAMJnNqnMXzZbMntF8OUAzj19HqZvrZ+ici43rmOJDJYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996789; c=relaxed/simple;
	bh=JAU4oetIKsiFFQoxD4BOLbL092tRs1Y5zrd0wB8hP3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IcMHTIlzmT9+OD+NyQ1Dg5t1z7/+2iprwNICOzhcvkFpv1AUze//2jIU29OSfNcxEyog07gyV3FR5+xVlQ1h9U5r2UaKnYQTv0EJJWUeMcDzJgiHD1qy1FcW9ckc1FUYw+OYVxs4jsj1KA1QRRECn/v66V9pE8mL33UM7vOFpbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E55vTmMQ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-639102bba31so1208547a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 00:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759996785; x=1760601585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BImMKCDjo8UcgLF4QMJ2SKqY3V/e7t3G8DgvFQjtsv4=;
        b=E55vTmMQPuIsBWpR+wSLdHpUA7OJu+0uKgWLiQNF7rZ53zbtjoDnxV2lDTzB98VXPs
         PmpMv1T+jJCUb0JKHj88embadcVYrbbICu5CdZWG/sa7KKeeHGTw8i5qx1j0JVeq2w2k
         qP76iVEv3J5a8CzP1VQJzd7AoIHyt+hCzYdmXhyAIi9fkjVhuzdUm8qap8UGoiCY0YD/
         cMZk0Joo8VFVz1XRUEgMZaFVWsIf7+6olS82P7R8EsbLGiqrnfLbK4RYvy0ceXHBlOhv
         a5XRmPQcERwzNZ5AZTbprOCXLAa31uQhgT96YekXlD0932f7tL+XC7IQ/wLfR2ovJqyI
         8veg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759996785; x=1760601585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BImMKCDjo8UcgLF4QMJ2SKqY3V/e7t3G8DgvFQjtsv4=;
        b=fVtyWDevmDP9XeASc64MGqjmInIc4S2gpb2m5gQgMnrQ0rs8nlFehKKtC7rOxZWLWz
         iZ1fPdB2uLTm6yZMdmATHns652xiE31K6pDbahdbMRFcEW6YrOAk98rn7XT7sPRwHiRH
         Zus/m2dMWk5Y/Oz/cmWWhAXAwnqBR+euEPey+JycXlY+QfYbfgcXBe8jF+VlgSpE4E+8
         B91SBIgo/JUuY+ZMrszsp/hMbCJLdhWMR4b3ElCg+nl6qmaw/GKNfiS+FEr0rjSgYRQo
         XdANpFgU3JtRh9dY6OxBNORTB6LbwpvZNdzaGftWa019bbVIzsKUNRzuBgiXHdlW1MPD
         poUw==
X-Forwarded-Encrypted: i=1; AJvYcCWIyLnRAnuN6gVeA+pzsn7R2Ytq6259Grfygj/bjSUXXv3LFJcWf9YytP+OehnphUAzHwzf33VMOUPXhxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxncpMs/00Zm0Zyw73u6lmAX9wQDhc0Btgz6b2+06JVk7ZYZoSq
	sCkqWClW4AIguwFD+eKhUt8l3YJhF66A0+UA+2OxN+3oqokK/rSAgygL
X-Gm-Gg: ASbGnctaxhcw5nesTrzuac3ufVlNJS2/fSUbhFau12LZQyzK2vE1e8/vwlyhUXZK/vQ
	tNrs2vaT6buWivBHOpTZgTAMCUJYGXdVZxup7VVKzBpB/6D/SK2vNUgGemcFXwDfSVLUjcTzTbr
	ID9rA995IrTsg0l7F5iEi0RNEqXtfB7iJYMsSD4JaHS6uU/nVnK6Bsw07XSPeWIvaKOIeDC4VwR
	aK/2L7udpQxV83UHl6oz2LLQ53etsah5FU36A1GGTPN5BJYtcvsBKiIOcNvhO8HbmHonXGfgGMS
	Kc0q3bYp0HSBjo+zGj6B/bzX9spErhHgDUOiP674N2tBuS85xeyN5KBUdnIzefMZ2aboQAnzarE
	3YrjjUETmNHWSQUhKTij7k/J/qg2jW2l/li7eeRAIRE4jda292IRMPiNH4LXN0Mhi1r8CilQ8eH
	DFgh88oHQwJ4EoVaMI7FsG7A==
X-Google-Smtp-Source: AGHT+IENbCwcvaxD9DGquoigQ8tdDndKKU4pj4q2EF42sPm/388Ywdvf1nQR/63uusvC/5TSS5tPxg==
X-Received: by 2002:a17:907:3daa:b0:b46:31be:e8f0 with SMTP id a640c23a62f3a-b50a9c5b3c8mr785496066b.3.1759996784546;
        Thu, 09 Oct 2025 00:59:44 -0700 (PDT)
Received: from f.. (cst-prg-66-155.cust.vodafone.cz. [46.135.66.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5007639379sm553509366b.48.2025.10.09.00.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 00:59:43 -0700 (PDT)
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
Subject: [PATCH v7 03/14] fs: provide accessors for ->i_state
Date: Thu,  9 Oct 2025 09:59:17 +0200
Message-ID: <20251009075929.1203950-4-mjguzik@gmail.com>
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

Open-coded accesses prevent asserting they are done correctly. One
obvious aspect is locking, but significantly more can checked. For
example it can be detected when the code is clearing flags which are
already missing, or is setting flags when it is illegal (e.g., I_FREEING
when ->i_count > 0).

In order to keep things manageable this patchset merely gets the thing
off the ground with only lockdep checks baked in.

Current consumers can be trivially converted.

Suppose flags I_A and I_B are to be handled.

If ->i_lock is held, then:

state = inode->i_state  	=> state = inode_state_read(inode)
inode->i_state |= (I_A | I_B) 	=> inode_state_set(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B) 	=> inode_state_clear(inode, I_A | I_B)
inode->i_state = I_A | I_B	=> inode_state_assign(inode, I_A | I_B)

If ->i_lock is not held or only held conditionally:

state = inode->i_state  	=> state = inode_state_read_once(inode)
inode->i_state |= (I_A | I_B) 	=> inode_state_set_raw(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B) 	=> inode_state_clear_raw(inode, I_A | I_B)
inode->i_state = I_A | I_B	=> inode_state_assign_raw(inode, I_A | I_B)

The "_once" vs "_raw" discrepancy stems from the read variant differing
by READ_ONCE as opposed to just lockdep checks.

Finally, if you want to atomically clear flags and set new ones, the
following:

state = inode->i_state;
state &= ~I_A;
state |= I_B;
inode->i_state = state;

turns into:

inode_state_replace(inode, I_A, I_B);

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/fs.h | 78 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index b35014ba681b..909eb1e68637 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -759,7 +759,7 @@ enum inode_state_bits {
 	/* reserved wait address bit 3 */
 };
 
-enum inode_state_flags_t {
+enum inode_state_flags_enum {
 	I_NEW			= (1U << __I_NEW),
 	I_SYNC			= (1U << __I_SYNC),
 	I_LRU_ISOLATING         = (1U << __I_LRU_ISOLATING),
@@ -843,7 +843,7 @@ struct inode {
 #endif
 
 	/* Misc */
-	enum inode_state_flags_t	i_state;
+	enum inode_state_flags_enum i_state;
 	/* 32-bit hole */
 	struct rw_semaphore	i_rwsem;
 
@@ -902,6 +902,80 @@ struct inode {
 	void			*i_private; /* fs or device private pointer */
 } __randomize_layout;
 
+/*
+ * i_state handling
+ *
+ * We hide all of it behind helpers so that we can validate consumers.
+ */
+static inline enum inode_state_flags_enum inode_state_read_once(struct inode *inode)
+{
+	return READ_ONCE(inode->i_state);
+}
+
+static inline enum inode_state_flags_enum inode_state_read(struct inode *inode)
+{
+	lockdep_assert_held(&inode->i_lock);
+	return inode->i_state;
+}
+
+static inline void inode_state_set_raw(struct inode *inode,
+				       enum inode_state_flags_enum flags)
+{
+	WRITE_ONCE(inode->i_state, inode->i_state | flags);
+}
+
+static inline void inode_state_set(struct inode *inode,
+				   enum inode_state_flags_enum flags)
+{
+	lockdep_assert_held(&inode->i_lock);
+	inode_state_set_raw(inode, flags);
+}
+
+static inline void inode_state_clear_raw(struct inode *inode,
+					 enum inode_state_flags_enum flags)
+{
+	WRITE_ONCE(inode->i_state, inode->i_state & ~flags);
+}
+
+static inline void inode_state_clear(struct inode *inode,
+				     enum inode_state_flags_enum flags)
+{
+	lockdep_assert_held(&inode->i_lock);
+	inode_state_clear_raw(inode, flags);
+}
+
+static inline void inode_state_assign_raw(struct inode *inode,
+					  enum inode_state_flags_enum flags)
+{
+	WRITE_ONCE(inode->i_state, flags);
+}
+
+static inline void inode_state_assign(struct inode *inode,
+				      enum inode_state_flags_enum flags)
+{
+	lockdep_assert_held(&inode->i_lock);
+	inode_state_assign_raw(inode, flags);
+}
+
+static inline void inode_state_replace_raw(struct inode *inode,
+					   enum inode_state_flags_enum clearflags,
+					   enum inode_state_flags_enum setflags)
+{
+	enum inode_state_flags_enum flags;
+	flags = inode->i_state;
+	flags &= ~clearflags;
+	flags |= setflags;
+	inode_state_assign_raw(inode, flags);
+}
+
+static inline void inode_state_replace(struct inode *inode,
+				       enum inode_state_flags_enum clearflags,
+				       enum inode_state_flags_enum setflags)
+{
+	lockdep_assert_held(&inode->i_lock);
+	inode_state_replace_raw(inode, clearflags, setflags);
+}
+
 static inline void inode_set_cached_link(struct inode *inode, char *link, int linklen)
 {
 	VFS_WARN_ON_INODE(strlen(link) != linklen, inode);
-- 
2.34.1


