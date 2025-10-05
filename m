Return-Path: <linux-kernel+bounces-842500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EADBBCDC9
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 01:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AFB304E313D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 23:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4420D221704;
	Sun,  5 Oct 2025 23:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/2M55xr"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D84F9C1
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 23:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759706135; cv=none; b=WmaJ2RPScDzeioASJX1xYWLa1iH/ODLmu604cSTRwDiK+1AjRTrMEm1E8/0FN+SqjpwOFx8lSBBFgAXTdZKLhjaTDkekN/oDdjo2cNKcGoXRAe11rrKlFX6WlVFE9jzuP3ZqIG3OG/2SMw0yi1tE80n8ym9XDUqwzzby5xpIW0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759706135; c=relaxed/simple;
	bh=fybNiBAefFTh//jSRU2sf0Ny8KCLWtk1ph7b062OZqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qGv6uqEedMRmFcMmtrQ3MtEHw2YQEGeBC6UnLX7WPGv+3KTAZmspko8dICocHAX/MmKPzjslCTvNJVBGn7hv+8aMHUCDq+6JmsXHlw7Nx4Yz1+BG3JB2CW94McvdX49lepp4/DboriGzdEX0+MdTBIaLrQr6mbvtx3EhrANOIVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/2M55xr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so32356395e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 16:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759706132; x=1760310932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IZVLKUfxISrsNrnwMvWMj0ZRjTubuXUM3Dffz3zRah8=;
        b=N/2M55xroM1u/eI1YLJLxLzvNfaoPyUk03HUDeaUbmX2GzfN/UDduSpOaD4e7CMH2O
         fsrcK2N5kZrdXKuCd04emIeCbJ0gVEWdWieln+QGisIvgGcTyE+02ghAJPP8NEp0uiOL
         df2iuoD66DOAhoxLSGkw16wVERTxy9xHarxXuFYDSRHIlgc2daiC53O3fwETY44gSENU
         R3otJ5srvh2uKoE3SAIisLz0Yl1zP6UfTVzk9ql8sOyHyHjJvu9FS0j5k50eDaP6J6pC
         8DmMotN6BOh+UBgwCHnvwz5AdQY45D3m+Kf+Jlq0f5TIirioB6iAnx5UjfBqHKVwwC+P
         YEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759706132; x=1760310932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IZVLKUfxISrsNrnwMvWMj0ZRjTubuXUM3Dffz3zRah8=;
        b=vRgTIYuRcYlfepNG3IGR1SPWIwqc2u/BwVZAwcU4F8IncmE05GbwtN5/ccFCNsD9sH
         +c0WI2O/FQpwkSLT1/XXi1soMfJXlNQ2urn3vKfIn03jmNfGqI1HCgDj6eS3wUjxAB5N
         H9qD+BjuyYBtstV22z8Iaeg9H1tLPO6O49jeM3V3GMk5nqHoMkvn8yvufvIuVXIZElC6
         EeqWvOUuPsKdyK55fN9Wdw0vlC4gKeHtt63BkMiwgAgi9IigtM7O71hL3karQ60B0ciu
         L7wFiEPjBUohj0NUO8NdPR+bL4KAXR8CEPfHGq/PGJ4tcSt2MTYrqbtoZjEVBznfsAVF
         QcSA==
X-Forwarded-Encrypted: i=1; AJvYcCVTMJVm1OaBexEjigwkvgbkBlCk8oGzw2HZaSaZ9SCs9kJ4LoOyFy5JiR5FBcNLPut4mY7twT+4cSXRlVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9AYa3kEsV4jENZgVNxiP4uVz9JUlzYU7WqPQwhMniGpAInm5O
	276v9/XYi+4GMgMc0TPFvEG3pOavHwy5qCatyU12/0bGgTq14PBYEDSX
X-Gm-Gg: ASbGncsKKin7oX0SmBtZHrKHghRS9uaqkSTh95X3JruU7YmPIDpvhfuG8rBMajbkUrC
	mwK48yYuJKhNbotnlcyycnDWyDAjSWK0ROWAU5RAr7U+0u15tYpC1RApB4yJ4ucC2zo9PMhSWDH
	gDG4m/PGBTcXwlBNHnIp6BWO4WBICZwATk+6iP4wx8e9HCcnp8FRcxP0XRKGxQIvnMpTHCwjm/n
	L9gHzqZzcz263kR60Ab9LKg3JoXzTYd5rf4Ke4cncNAi2cMfd9Ez96IapUuXAtZ/fhoExvk8/Wq
	5Fkct7SgwgSFlcDD6geXau8v0SgiXUQd83pJY4j4Halibbu7zt7NAU8wX37kAZ0O7vk8thbwMo3
	M4gQEfCgO+tMagoYCw2AIVlp9Sp1kCnUi0V7yY4YbTaCD6hpJo+1XgsLe/zDMTmfOfZ4dJTog4C
	xNR8rKaL3JwiEOEfIQ24GgZPHa34IumUts
X-Google-Smtp-Source: AGHT+IEO23zbV1o6Dod3OnepyrZ499l60l15zhzyFc5iTDUQFeRUVPj+KaAJtZN9R8sEfUGcnJfl7Q==
X-Received: by 2002:a05:600c:34ce:b0:46e:4ac4:b7b8 with SMTP id 5b1f17b1804b1-46e7114e923mr68621845e9.25.1759706131907;
        Sun, 05 Oct 2025 16:15:31 -0700 (PDT)
Received: from f.. (cst-prg-79-205.cust.vodafone.cz. [46.135.79.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e9780sm17920640f8f.29.2025.10.05.16.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 16:15:31 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: add missing fences to I_NEW handling
Date: Mon,  6 Oct 2025 01:15:26 +0200
Message-ID: <20251005231526.708061-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Suppose there are 2 CPUs racing inode hash lookup func (say ilookup5())
and unlock_new_inode().

In principle the latter can clear the I_NEW flag before prior stores
into the inode were made visible.

The former can in turn observe I_NEW is cleared and proceed to use the
inode, while possibly reading from not-yet-published areas.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

I don't think this is a serious bug in the sense I doubt anyone ever ran
into it, but this is an issue on paper.

I'm doing some changes in the area and I figured I'll get this bit out
of the way.

 fs/dcache.c               | 4 ++++
 fs/inode.c                | 8 ++++++++
 include/linux/writeback.h | 4 ++++
 3 files changed, 16 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index a067fa0a965a..806d6a665124 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1981,6 +1981,10 @@ void d_instantiate_new(struct dentry *entry, struct inode *inode)
 	spin_lock(&inode->i_lock);
 	__d_instantiate(entry, inode);
 	WARN_ON(!(inode->i_state & I_NEW));
+	/*
+	 * Pairs with smp_rmb in wait_on_inode().
+	 */
+	smp_wmb();
 	inode->i_state &= ~I_NEW & ~I_CREATING;
 	/*
 	 * Pairs with the barrier in prepare_to_wait_event() to make sure
diff --git a/fs/inode.c b/fs/inode.c
index ec9339024ac3..842ee973c8b6 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1181,6 +1181,10 @@ void unlock_new_inode(struct inode *inode)
 	lockdep_annotate_inode_mutex_key(inode);
 	spin_lock(&inode->i_lock);
 	WARN_ON(!(inode->i_state & I_NEW));
+	/*
+	 * Pairs with smp_rmb in wait_on_inode().
+	 */
+	smp_wmb();
 	inode->i_state &= ~I_NEW & ~I_CREATING;
 	/*
 	 * Pairs with the barrier in prepare_to_wait_event() to make sure
@@ -1198,6 +1202,10 @@ void discard_new_inode(struct inode *inode)
 	lockdep_annotate_inode_mutex_key(inode);
 	spin_lock(&inode->i_lock);
 	WARN_ON(!(inode->i_state & I_NEW));
+	/*
+	 * Pairs with smp_rmb in wait_on_inode().
+	 */
+	smp_wmb();
 	inode->i_state &= ~I_NEW;
 	/*
 	 * Pairs with the barrier in prepare_to_wait_event() to make sure
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 22dd4adc5667..e1e1231a6830 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -194,6 +194,10 @@ static inline void wait_on_inode(struct inode *inode)
 {
 	wait_var_event(inode_state_wait_address(inode, __I_NEW),
 		       !(READ_ONCE(inode->i_state) & I_NEW));
+	/*
+	 * Pairs with routines clearing I_NEW.
+	 */
+	smp_rmb();
 }
 
 #ifdef CONFIG_CGROUP_WRITEBACK
-- 
2.34.1


