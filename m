Return-Path: <linux-kernel+bounces-828798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF49EB957EC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99093AE7ED
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A0F321F5A;
	Tue, 23 Sep 2025 10:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMiDhOih"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C098E32129C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 10:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758624449; cv=none; b=SfRfpcBjlBQma+lN8i7lD1CHoEJbtLXwu5eEK299UmWyCoFlIZhIMY5lncZTXDU346SGoRpH0vSrSRR2LdpSt0WV6KOwTLKLVHQiiRDuyzxBulipIfvoMqtMbv+mb9oL+z5hlPosuu1zo9/KYe6faXT+YsagByvuZnDszBpe4ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758624449; c=relaxed/simple;
	bh=l2+XRRMMlUv38cxkDkgsNP7PrYQqTHAOPnKjsX3NKpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T59ngWAsigpkT5s3ruuZn1jWMiDtOWXdtWbe9UWvmfgk8uUrsJfpbapke8YUDsDeq/fy1nV343TZuHHQxfXuIZ6Vg3CjhMPXSklGl3LtF0tI6Dam6M5PMzAj27O44K+mvNRLw9aMB6m28vMOYsY3oSGjvuTz9zjYHf+9+sDo3YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMiDhOih; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e23a6617dso2574145e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758624444; x=1759229244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wY/sdmBMIe7/evMOyoyNDBqGuIEYNCftZNVDhHEUu68=;
        b=FMiDhOiher0WYGTvi9mlL0UHvwCKsGGmjWkge3xsWfv/uDzLFpbP40NiXIRMUUP968
         xwfEckY67Oh/E1gCkApvZxxe7wm6INY2+PfRri4sRHZaVJf4VH4MFohjjbV1yLhbrQxa
         lCOhz4kRZejjx8sWCcm9SeekQG7H+5pEgj/QwQxYDKdtPvmq51GHckIGEYdxBvp+43N4
         TQXV12quwS3Y2e3xL1iAppawPO1vf2BbQCcO3YiNEbW9LzcTsFrws8GNCQQXtkGQxfNH
         wy+seOz/vpZ2cdR+r84jaFF8A3IuG+Id/1OnsEzN5y25ZVX/k6owrKNrmSUGyBAYdfLY
         zsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758624444; x=1759229244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wY/sdmBMIe7/evMOyoyNDBqGuIEYNCftZNVDhHEUu68=;
        b=LI3fI4bs8mQlR2cTfCvtgOKgI9ftxTcxyGHZd8eIAe+HbW1i6uyzwVU+BtA5Nit2YN
         cIo1lI3pVqtbEHPVjnlHnlnKKD3vcGraQiICrIK4BNlVnj5nbVhRTXOLNOXe+l2R28M5
         Hyriaa4QZ/QGzkMiTK7QFvGOjn5CKAW30Dor1WRLTg01dPg4wkMg6X3kXSZcljpdG1e6
         wRbatNgvK0Ca9U0qKmr3yKD/CZTSkQca/dh6I5KK/BL3iQrjn0/8MXqhjl1LI/P5hXCf
         HreD6gc3rohFigbypqD3QsWgKVnvZ07Zly9O7dC+497mzLVOpbiLfA5702qLxKWPKcHv
         URgg==
X-Forwarded-Encrypted: i=1; AJvYcCWcn2ukuA+kujCTtbxL0Ds3zqDE8fq15JhA/x8KQs1Noq7CjsqLdjc/2ykvPDc7SNhqeyqbOg0IhqH99II=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytcrtj7REb/WmNuQq8ltwGSxJa+R4107Li8caon8vAs0qpUhIN
	GX8vsE7zrhX5wkYYBM30UeRVpqxX9OoOboEpo+gPRPLy75+R7GQfUDfm
X-Gm-Gg: ASbGncun1lDEASjcN90V7+r4HMNvvCIv7wS3qlEdRSpyTMFFEj7Fe/Af1QpihyTiV7D
	ySoe7sz2khNDnR5YDabt5Qp1RSr338EAFvqkmCUuNxmtJyz9FeU94E+CV8vFb41d600qMF+gAOr
	zHo8bIeDle17Hwrq8qlYD7Ys/5jTdqfWqHpZGP65mwKm3LPooHwST/2TBTluKLbk9eVs4o/IpUm
	tBzj+J7YrvgxbREF6vbXFwd7sJBesI3t5YGBaTE9ywKjwkGBVIjxTfeUe7w4sGADEsqhkCX66EG
	UYVevFFK89A2n4MuEFIHAPuAGUjGO5rd+ve3G4EbV6LstD6p37dC5NpSl+DtzULJB98qy9Kuagc
	pxbdPAOZdVtgogWvY5KB6JE21jKbe5OWkCLKEXBzKyRpUi4tffl//ok+R9oMXeyJkNrkCs25wGj
	zBpPDl
X-Google-Smtp-Source: AGHT+IFG/viu/Q5UoxWFmn6MCDA3PwXtIt4JmmoJtRIj8itygK9JQbD92sFVJjS9mxr6/B7iPXdZCA==
X-Received: by 2002:a05:600c:c8a:b0:46e:978:e231 with SMTP id 5b1f17b1804b1-46e1e0aec9bmr23755185e9.17.1758624443810;
        Tue, 23 Sep 2025 03:47:23 -0700 (PDT)
Received: from f.. (cst-prg-21-74.cust.vodafone.cz. [46.135.21.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e23adce1bsm9710525e9.24.2025.09.23.03.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 03:47:23 -0700 (PDT)
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
Subject: [PATCH v6 1/4] fs: provide accessors for ->i_state
Date: Tue, 23 Sep 2025 12:47:07 +0200
Message-ID: <20250923104710.2973493-2-mjguzik@gmail.com>
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

Open-coded accesses prevent asserting they are done correctly. One
obvious aspect is locking, but significantly more can checked. For
example it can be detected when the code is clearing flags which are
already missing, or is setting flags when it is illegal (e.g., I_FREEING
when ->i_count > 0).

Given the late stage of the release cycle this patchset only aims to
hide access, it does not provide any of the checks.

Consumers can be trivially converted. Suppose flags I_A and I_B are to
be handled, then:

state = inode->i_state  	=> state = inode_state_read(inode)
inode->i_state |= (I_A | I_B) 	=> inode_state_set(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B) 	=> inode_state_clear(inode, I_A | I_B)
inode->i_state = I_A | I_B	=> inode_state_assign(inode, I_A | I_B)

Note open-coded access compiles just fine until the last patch in the
series.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/fs.h | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index c4fd010cf5bf..06bece8d1f18 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -756,7 +756,7 @@ enum inode_state_bits {
 	/* reserved wait address bit 3 */
 };
 
-enum inode_state_flags_t {
+enum inode_state_flags_enum {
 	I_NEW			= (1U << __I_NEW),
 	I_SYNC			= (1U << __I_SYNC),
 	I_LRU_ISOLATING         = (1U << __I_LRU_ISOLATING),
@@ -840,7 +840,7 @@ struct inode {
 #endif
 
 	/* Misc */
-	enum inode_state_flags_t	i_state;
+	enum inode_state_flags_enum i_state;
 	/* 32-bit hole */
 	struct rw_semaphore	i_rwsem;
 
@@ -899,6 +899,35 @@ struct inode {
 	void			*i_private; /* fs or device private pointer */
 } __randomize_layout;
 
+/*
+ * i_state handling
+ *
+ * We hide all of it behind helpers so that we can validate consumers.
+ */
+static inline enum inode_state_flags_enum inode_state_read(struct inode *inode)
+{
+	return READ_ONCE(inode->i_state);
+}
+
+static inline void inode_state_set(struct inode *inode,
+				   enum inode_state_flags_enum flags)
+{
+	WRITE_ONCE(inode->i_state, inode->i_state | flags);
+}
+
+static inline void inode_state_clear(struct inode *inode,
+				     enum inode_state_flags_enum flags)
+{
+	WRITE_ONCE(inode->i_state, inode->i_state & ~flags);
+
+}
+
+static inline void inode_state_assign(struct inode *inode,
+				      enum inode_state_flags_enum flags)
+{
+	WRITE_ONCE(inode->i_state, flags);
+}
+
 static inline void inode_set_cached_link(struct inode *inode, char *link, int linklen)
 {
 	VFS_WARN_ON_INODE(strlen(link) != linklen, inode);
-- 
2.43.0


