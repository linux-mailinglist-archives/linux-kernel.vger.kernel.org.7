Return-Path: <linux-kernel+bounces-824900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3554DB8A6B3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15EB83BD310
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D89F321434;
	Fri, 19 Sep 2025 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJBQjcPj"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4111631E0EB
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296969; cv=none; b=VBPdLIVLWX6pzKdv4k/hN1DMsK1DSuscRoWllK26l23beZTC41VEgzR5pjaCa8ptqAVVt1GRPz7M6XGRWYVxyOPT/shfcKs5bnrlK2crI7e7zXG812G2gWcj4h7H5jrw12sGR498f/suEpWy2vaenuHrUx+wlJXMZdlR6GiOaF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296969; c=relaxed/simple;
	bh=mwvxOTrWUws8OMACY4TrEt0dK3mhZILNulqgYpZhPQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IURK88x5Df6dlPIPZOgcfS2iNxoMsVnpgmq/KjKDTt8b8Ls3lMNhxmcEemQuOnbesrBm31gIMvTE1Jw3fxeHkK6xPDvwLSMU2Lrbc2OH4IIntFJQe3zoWeerOB+fye/kW5NcHNge5yrd9hTqkzXEmGxUJ51w9qKTjmrtlY28RxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJBQjcPj; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3e9c5faa858so2028034f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758296964; x=1758901764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61d6oBaZHfUlKu+4j2QssmtpKiSdVI4e5z02o4UC0u8=;
        b=gJBQjcPjlAVeXIpKpiWI3+YDxneMBgccZS+2jAHDPUzhYn10d5TKf6h1KrweDA6RhW
         UCyXNyqTdbV4ksXQ9Hruor1pS/Nrh0aKOWopUOnOLvo7Aq3XzjCX3LMYkZyP+MTEWuIZ
         72MMwgTJ/+c7MZ4Yk9cvfcRUK+fmxNUgxfLs5AMa7zLy2HBlNaVVA+q8s610ZmJ1gu2k
         uwr/jtN9VkhflldfMdHezQ2g2lSOU/JuwjzMQanXUhgcSpaL35sdvGfyrhiig6ZoNtZ4
         bJ6SB0Fjvjy8yyMOIrOpIQWSXTsKkWc0APM6pQvyG1/onArV5YwjQI2bwtEVYlMijfCp
         3MWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758296964; x=1758901764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61d6oBaZHfUlKu+4j2QssmtpKiSdVI4e5z02o4UC0u8=;
        b=vMxaZJD23uLuQOUys8010Pz/6DBl+gGXbNjNyOQmq7qUPM95LtLhJxhkQqUNqoQttQ
         r+lLGsRLgc1B26OkArnzKdNdJ9qmVjIQPOIQ0EpMkU8H4U5SgQ4l5+iHciDBKOTw4pPM
         hhfCTyEpg9HhMN4IDelHm5bGJFIIkcwLTHrmR7TyO2b8ADa4XAnAOB7U29Mr1yGTLmw2
         0OrLjL12nPPsgBnS2vivyarcoqzL76enektNnP/LhLuwW8+ivh+XWisu/DBHS85c3oOO
         R7g942MTN/jeQlLQ64uaQDih5og8ZfBf6E1YbHExyexSoMeyKY0V6wuvPamK2/rbyEiY
         g0og==
X-Forwarded-Encrypted: i=1; AJvYcCUK35wPr5qlMYimtycbYEo1g8K+Utktt36+wwMMYqnPpLVMXvDN/JHdVP77Oys4lXLWXhlJJLgwcinPQQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK+0JKt+Mmh/0NMc9HygCfpStVjGs7YZxlJZIs2Ef7enwMufbm
	2Z9oQU4WbedLsGryrrdM60Ossye4zq6WiB2ofyb3cd3iQ5QW9jnpOvLW
X-Gm-Gg: ASbGncs3lZ6+/qPb4rzhVB6rHaJGZkjnnqxhQqTcYxHZ0UIWysjefy5HEEia1I5+gSM
	XAWexHPns/Uj5RKBxhOJyarbJHl1+qjIFueYXHdd3V+6OTIeb9/t31LGCn2gF939zFNlIIVJ2ER
	//5t6yhlUv8r8lXcOkHvOTkMCVMHXuO4tvIEo8khfguW2imQGJ5BhteY5/RauL8GwjkmpIv5lWS
	3L2TOIyqajm0Kdo3fMRhBJwDjdFozhOG8ZELmKOuK7BSO651OMo9yzrDIDN2HMCzvXO1Iqre8TH
	XkksI3sliRyJNjcvY83ao8JWvim0v9Fjw0csnj1X8qPL/Xgs5KD5nXCCIDa8J3c5cMAGSWKEVGS
	hXdmpCn6M0y6kstynXMwNFWgaHQoAc5eYb5/+JmZLW/8HsXcw9z6nb1Z6OP2L06PGuAJmZwLT
X-Google-Smtp-Source: AGHT+IElu5efTxqeZRn/Q7DGHQ7xzDh6VVQxmvzWa6J1DdvqizNuOI3aGe/Bc0G2MqWrzLvaODXXhw==
X-Received: by 2002:a05:6000:250c:b0:3e7:5f26:f1d6 with SMTP id ffacd0b85a97d-3ee7bad15f0mr3165724f8f.13.1758296964249;
        Fri, 19 Sep 2025 08:49:24 -0700 (PDT)
Received: from f.. (cst-prg-88-146.cust.vodafone.cz. [46.135.88.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee073f53c4sm8446746f8f.3.2025.09.19.08.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 08:49:23 -0700 (PDT)
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
Subject: [PATCH v5 4/4] fs: make plain ->i_state access fail to compile
Date: Fri, 19 Sep 2025 17:49:04 +0200
Message-ID: <20250919154905.2592318-5-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919154905.2592318-1-mjguzik@gmail.com>
References: <20250919154905.2592318-1-mjguzik@gmail.com>
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
index 4ba2b274588a..3d678cd02fea 100644
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
 
 static inline void inode_state_add(struct inode *inode,
 				   enum inode_state_flags_enum addflags)
 {
-	WRITE_ONCE(inode->i_state, inode->i_state | addflags);
+	WRITE_ONCE(inode->i_state.__state, inode->i_state.__state | addflags);
 }
 
 static inline void inode_state_del(struct inode *inode,
 				   enum inode_state_flags_enum delflags)
 {
-	WRITE_ONCE(inode->i_state, inode->i_state & ~delflags);
+	WRITE_ONCE(inode->i_state.__state, inode->i_state.__state & ~delflags);
 
 }
 
 static inline void inode_state_set(struct inode *inode,
 				   enum inode_state_flags_enum setflags)
 {
-	WRITE_ONCE(inode->i_state, setflags);
+	WRITE_ONCE(inode->i_state.__state, setflags);
 }
 
 static inline void inode_set_cached_link(struct inode *inode, char *link, int linklen)
-- 
2.43.0


