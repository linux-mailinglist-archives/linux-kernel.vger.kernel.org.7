Return-Path: <linux-kernel+bounces-818959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C662B598D2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ED5916CB5E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1143680A3;
	Tue, 16 Sep 2025 14:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3nhuz8Z"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26429368090
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031211; cv=none; b=b6xcrC1HMCWdrOI1TvK1cdNaA501HxmRmQ/npLsXp2E0X26NunHyWLzgek1KOtIiBEN499IgBcSFxLLWzSQlvM0ipB2+v7Zw5gREO/QSMdgDuDg6iG3R8o+1xZZH/mPINNs4uAi9CtveoGr2Z8ttuE595+4EpL+bBFCM8PTbP1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031211; c=relaxed/simple;
	bh=QCGFM/cnMeWMX3htX5p6eryZx4ChTW6raUZie6Xkq4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bN3EnUVimo/B1BDp8NEepm9o7Piv7bF87AVIHXEMhIKFIZtl5dIMay1YnkE4g+iE55JMPDgtsSdthxtXQltBwUPmDkHNY51YJY+pAgqcNdiVqQgqjGgtEjfv6nj8YCW68+/n6zC4n0spY5LKEAMsrKFIOYnQDSn5Ozk9y4cXzMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3nhuz8Z; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45dd5e24d16so52703705e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758031208; x=1758636008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3p/HZf12MlzeyzMfr2O5f/PDaT3y6+eiNIS1WtKNH8=;
        b=L3nhuz8Z9oR2kJSqns3xH/4NNgB63DxIRTaNe5oIxa1VLEVdkRdB/o3wev4JT9FNev
         eYpTXmtMWdeLljSdxJ79OLMkhJkiqrc6h7LHAZW+X5s3QVxcasSgLD7hAUeJrGRLubrB
         rulGsgIDFkzQK+2p9g4U8tVgIq95EgJGWBcjRk5IWOXboTPeJq5Wl8CIcLDDTCttURg+
         Z/kpRYpJML9Zm7dCljBFAix9m7eNOll6G7VSP+j67BxEW1aC/WZ7ZjSMe8UMq+FpcsCJ
         Gpseb7IWms7Lemr8sJ3X2y84OXx4aqfDuLL8yMdr7v3hdlC3zgsgY4glFyVdW2zXXK2M
         b5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758031208; x=1758636008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3p/HZf12MlzeyzMfr2O5f/PDaT3y6+eiNIS1WtKNH8=;
        b=G4N5NAPnEUvjIgOCwbQNgmMrUpLV20EA1Z2KM2RByvJqQEvzgPx83kVfTkOZsfe36Z
         2nm9FUpHRmrKxqbCS3oBxN7jbPHnfhxJgT9aJ+RONi+RW9vJNua5Ma+5mjy7btfz5BPz
         A4E62p2E6Si3SHAqmUWIArSTF6GvgdfaW1ZYc5BEUlcXV9Gc7dvvYSwbYcRsPsbffvi0
         CKr5KopzcL/geBzGYb7rSXKzIJljADoXO/FFOtbvxsusT7mJMxD5tn6PEYRQawagvM9R
         WZWH797niacVW7BTH+kKP0Z1k1pn9gpmja2xHWMEEqWt4PpPeEeSYNEghRQ1Kjevvf4a
         tqgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj1HfEzHXUMjOb7qBvI5SwobB0E3snpwP0V5k27/il7XpGXuP6OIqvBuGUWHsCoR1q1yE5ncigYj2GHU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhLYpOT3A+XPMxoMqo8dRC4yvgwERnbMH/4255m2qnuD+RNaXH
	fpNVQi41dANv4LYXZReI2MCRFjJXkEHbzelN46dHTazypNXmNLelohB5gACRzzpa
X-Gm-Gg: ASbGncuFtbbXZqddBYaCVoGrW28xBQ7rBg3Z15EPmVFTXJAWraTvzdmGzR6EJ8UQrOz
	5vfnO9mP+2taPHthTyCYCodCaUs7O8CZpRJE9i8q3m/6364hbu5PCux62HOwFG23c2Heq6GR3x2
	DeUUiHdI/UUx7r+YX4+WEmMzB1eNd54aNakwqknlLIm9NC2B3PkxDOA6rSxORJM5SBgi5ZTGpwh
	OimjxDGUEjckZFZBXD8O1h6gZ03ozoHiK/xFD8kw/MvD8HSW6S8xy31dP6o4zMRz3mtzkqRRvZP
	jOB8IfwkS9+hwejkclOSUlViMaEPSrf/13iWPWY7DuijepgvJs53dcVCfBMcs45nprjHnI3FAsR
	Ltz5bEvltrMYv4Vew2s74UkFn5ziXi0p3nFtlXOlFD+BTyA9vUnec0fZx0jlXbDaIbZjNJa8/
X-Google-Smtp-Source: AGHT+IG3ojTnTVy1hdNr03FmdV6E3sTeXWaDybJz1f1E1nvEGmI8CA+2Pel84ZsC9/O7zHxZywZmtw==
X-Received: by 2002:a05:600c:5246:b0:459:e025:8c40 with SMTP id 5b1f17b1804b1-45f211c8aa9mr181401305e9.10.1758031208380;
        Tue, 16 Sep 2025 07:00:08 -0700 (PDT)
Received: from f.. (cst-prg-88-146.cust.vodafone.cz. [46.135.88.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7cde81491sm16557991f8f.42.2025.09.16.07.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:00:07 -0700 (PDT)
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
Subject: [PATCH v4 12/12] fs: make plain ->i_state access fail to compile
Date: Tue, 16 Sep 2025 15:59:00 +0200
Message-ID: <20250916135900.2170346-13-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916135900.2170346-1-mjguzik@gmail.com>
References: <20250916135900.2170346-1-mjguzik@gmail.com>
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
 include/linux/fs.h | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 11eef4ef5ace..80c53af7bc5a 100644
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
 
@@ -906,19 +913,19 @@ struct inode {
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
 
 static inline void inode_state_add_raw(struct inode *inode,
 				       enum inode_state_flags_enum addflags)
 {
-	WRITE_ONCE(inode->i_state, inode->i_state | addflags);
+	WRITE_ONCE(inode->i_state.__state, inode->i_state.__state | addflags);
 }
 
 static inline void inode_state_add(struct inode *inode,
@@ -931,7 +938,7 @@ static inline void inode_state_add(struct inode *inode,
 static inline void inode_state_del_raw(struct inode *inode,
 				       enum inode_state_flags_enum delflags)
 {
-	WRITE_ONCE(inode->i_state, inode->i_state & ~delflags);
+	WRITE_ONCE(inode->i_state.__state, inode->i_state.__state & ~delflags);
 }
 
 static inline void inode_state_del(struct inode *inode,
@@ -944,7 +951,7 @@ static inline void inode_state_del(struct inode *inode,
 static inline void inode_state_set_raw(struct inode *inode,
 				       enum inode_state_flags_enum setflags)
 {
-	WRITE_ONCE(inode->i_state, setflags);
+	WRITE_ONCE(inode->i_state.__state, setflags);
 }
 
 static inline void inode_state_set(struct inode *inode,
-- 
2.43.0


