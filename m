Return-Path: <linux-kernel+bounces-846392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFE9BC7DB1
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACD4719E79F3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692172D47F2;
	Thu,  9 Oct 2025 07:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMirGicO"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC3D2D1916
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 07:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996786; cv=none; b=C7OdTpKpagIKB/5VzTVip4moECa3Kxw4deY15tq0q6VxTfngVO7yk5tyhgssskD+RHdAxFPBSDQKnSsAe4vWI7B8vNlcy7kLWHnDM83uNQnWROhXMgYseF5bO9A4ZrayRVkz4+EoiPnqpiEBetlmPPurHH8UveBfhz1zps3HCeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996786; c=relaxed/simple;
	bh=hn/T4KF427I5vM1FE3EEQtD8Ky5WVe1EdG5AuHI54+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CTkZEy4PjifQAMqOGID27eoRmuvJnuBZvqgeEN77QmrrojwyCLuSV1a4YNBN1ewt1sgm1LxmHq4Uuxwjia/kP7PYd+FqDWjktBA47eC8df+N+3weWbn781yIDiX6ZLxpGsN5aKghXJ+7Dzj+tti3UkOWstlVpc8oYvU6IdshQUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMirGicO; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b07d4d24d09so117035566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 00:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759996781; x=1760601581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v56yGNQ37Majx7vHh2h4KlxSuTszWt/5MXXh209zdXY=;
        b=lMirGicOJdPSNtq9UZZJiIbkDKhy9CQKtYmj64hbx8QVtEfVQuXDHFoFXpPwusWLPp
         TgB2diOAbyyiUZcXGKKHKQWVgGL1Jx5zQmAsLuWo7rzUL/RHUceQ6EmmLLL7Tuuvpp4o
         p9ObZpVAYRgOtDSAocog43dOeC1QR+/iw8CnAsNHbYFgI5Ks4nU2NhrpX0ALFEcaEVps
         HMcARGcAMROGsXQWYoNrwFrRuRN/dEOF92/+8jeLPDMVuQaS266+1IDl1a5rwpVSlF6c
         2XA+0rOpC18GFVQLbBReMGiW4hLHZ1ZRNPiZz+JymED71pXEAhX8lcUFUw1rNjt8rgI/
         ickw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759996781; x=1760601581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v56yGNQ37Majx7vHh2h4KlxSuTszWt/5MXXh209zdXY=;
        b=LE2zX0y6LwBMy/qKABZM8EPJrS5eobBtc77rzD5X5RKsS1kZTGmTW63qEMTyyoOGmG
         ltom9tJ8dUDPXV6z/VELr0lwq8wcBQVsALiz9b4DKO+dDoTCeIpdjIQQAah80BkOYb4M
         ipUAggDAVKrWZPKTZ4VcBM7tihxUX4qa0VsWmSmBmDphJPDDvnCVCRkmxTDGe4L4hicS
         DMWocIJipTBcVCZ7OtSoyUDGFDYiaZ3QVuCviS7xiLs0t7iGgHuHAg6dyTbU77OLVwvq
         k9MJkdUgL9ZTKj14ozKwwAGnAPgID3XV6hqgdK5WEHow5HFwOBqIOyj+sKrf0KR0zQ/p
         OFAg==
X-Forwarded-Encrypted: i=1; AJvYcCUT+OUDLpTqmA1EfkYvzfinuBus/AfjRcCZr1YawV2tYB2kStvYWFEs+EncDH7DGkVJ1vte5d8CFZ7Tevk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ5wGPK/wJ+bxunU6NDSu2z2mqwSWkySEyXJVSO4ml3QS1Z6T3
	pLuuf21s7DQN7gDLxR17Vhb16doAhvD+IYpwL+kTBOrT3jT1L/wD4UVV
X-Gm-Gg: ASbGnctNLEOZQ7kqPDxxtawDog6Bosf/Od1QxzT02xeIOQQsKPiLCFwp1VsNiSOiCr9
	XT65ZZZv+zkJR+hrv96jdk6Mhw3DlStatvIelSuQ9jMMgHgctEn+PSbqPp+M7I7WB1n9J2i5rPL
	+ItNPRGPi+SRBuc9KWg0cRXnTuIwFt2vGgBSvvWDb71vZxARe+MXO9qy7WLjHxwsPPLavD7TBg7
	aBlxNr6N36n5ABMJShVKSOCBIJxJJstqtDT7Zuv3/8kVHybpc5OYQAXAkry7JDEiYnzyZgwZPjL
	vPj90xGjgLFfglaJfSj4x3VaIEces/vdGPb6Yl32eluhh1pQu6tsCYldMETVngeFUFFBamEx9UB
	gIK2oqlCEtR2FfZ7FCYh+sgJqd32DQ6KLvKB4brDrCV4BDRDQg8xq+NNuw3o4vSem/awT3pZbmR
	n7KaZv7d1NNpyUg22d+28kz08vB5Gmowyh
X-Google-Smtp-Source: AGHT+IEc4DRH7N7VTwKCGCSJIEPnJelkA9fOKTTSeoDugfMSCygU9n//Fy4KEuh4pwZhlTzmLezAHw==
X-Received: by 2002:a17:907:3f17:b0:b41:abc9:613c with SMTP id a640c23a62f3a-b50ac5d08e9mr658923266b.51.1759996781064;
        Thu, 09 Oct 2025 00:59:41 -0700 (PDT)
Received: from f.. (cst-prg-66-155.cust.vodafone.cz. [46.135.66.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5007639379sm553509366b.48.2025.10.09.00.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 00:59:40 -0700 (PDT)
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
Subject: [PATCH v7 01/14] fs: move wait_on_inode() from writeback.h to fs.h
Date: Thu,  9 Oct 2025 09:59:15 +0200
Message-ID: <20251009075929.1203950-2-mjguzik@gmail.com>
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

The only consumer outside of fs/inode.c is gfs2 and it already includes
fs.h in the relevant file.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/fs.h        | 10 ++++++++++
 include/linux/writeback.h | 11 -----------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index ac62b9d10b00..b35014ba681b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -949,6 +949,16 @@ static inline void inode_fake_hash(struct inode *inode)
 	hlist_add_fake(&inode->i_hash);
 }
 
+static inline void wait_on_inode(struct inode *inode)
+{
+	wait_var_event(inode_state_wait_address(inode, __I_NEW),
+		       !(READ_ONCE(inode->i_state) & I_NEW));
+	/*
+	 * Pairs with routines clearing I_NEW.
+	 */
+	smp_rmb();
+}
+
 /*
  * inode->i_rwsem nesting subclasses for the lock validator:
  *
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index e1e1231a6830..06195c2a535b 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -189,17 +189,6 @@ void wakeup_flusher_threads_bdi(struct backing_dev_info *bdi,
 void inode_wait_for_writeback(struct inode *inode);
 void inode_io_list_del(struct inode *inode);
 
-/* writeback.h requires fs.h; it, too, is not included from here. */
-static inline void wait_on_inode(struct inode *inode)
-{
-	wait_var_event(inode_state_wait_address(inode, __I_NEW),
-		       !(READ_ONCE(inode->i_state) & I_NEW));
-	/*
-	 * Pairs with routines clearing I_NEW.
-	 */
-	smp_rmb();
-}
-
 #ifdef CONFIG_CGROUP_WRITEBACK
 
 #include <linux/cgroup.h>
-- 
2.34.1


