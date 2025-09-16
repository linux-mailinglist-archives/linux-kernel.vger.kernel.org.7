Return-Path: <linux-kernel+bounces-818951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CC4B598A5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26CC81C02916
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A22434A33C;
	Tue, 16 Sep 2025 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLBo2LB5"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E5633EB10
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031188; cv=none; b=NW/u0Rf6cCYkzen1wsegl5re3H3TK4PpfTU9gOFqt55VQ/bSguh6oiibPHXkEvozoq4UnE397eS0GUFOc8Sd9GBOQR/QeC40rvjC/uvll0evV0LIpdrACDWASZ25mTBb3uaeCswlLB+PXuEzXkCbysrGyb53mKJw2qBfVikX1hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031188; c=relaxed/simple;
	bh=zBN9BldLXuQYafbepgbsRKYJCNw2ZdSE8TIiThiLfW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZVB0NU0bTTvhWKco3PhT+1pGR5/nGhcC8+wx+rSPgK4d5u4Vy3ZR7NF/PP0B9J/hOwWYeO1+DeLMuTSn/xN1FIiZ5shNDmns/BzkuH7XxEZUJbD8sR28Wf0JLAQMJiJ6yrl6/EzV2/29tJ/yWJm5fyYmq9Txz3fBTKD3I+jfRiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLBo2LB5; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ecbcc16948so459628f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758031182; x=1758635982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbghKwI6RgQqtHuzp8YIKipmqQLga/vSj80h86fMMYM=;
        b=BLBo2LB5PHvFexWoLIYT5WrIPilki61efSEs5c0jKV5SbQmSndN00mauMoB88EsbHy
         EbW3RDHt6qEcAhbdRfU/nR0p3s4ponYl6Od3MsYa3toqlYwc4dPCmvXQinYcjsWKkpoY
         1OgiiIhCNypynnEVbf6HaKtZAZIkbWWGkbYJOw9CwmaKGdEyGmqorR3wDJtsmNIg8YRE
         BKy9Gtsw/o9jXEw+WYSZBaiWgv7q56SpVfUBc0goRKHiTm6Drm8X62FsntD6u0YWyDak
         Ksngv81i03MZ/WRkd+u6vWvTeo51lmVGNs53sBwSK6FgmtujqQgh7j1VFNMk147g/McU
         8Mhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758031182; x=1758635982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rbghKwI6RgQqtHuzp8YIKipmqQLga/vSj80h86fMMYM=;
        b=OPW4zRq0DGzTKfUe/DzBlrHv3dTtT7Kdfd4+FTKv0K2tEiLItZkyceFUrfJlXxbmRI
         eAC/eDF3DFiR5eV1LVRjXe9hStG3fVA/AAhwMna/RpecuNQc4qN0ArUNXnk+Ar5QckQo
         AOhhWf9ClG7CRj89RVrAahrouAXIYjbeox5sVla2UEsO7ZQiVWM3ukTTy9GYkJUNns/7
         nhlACBpR+AgRfPXrN+TP4rDOsjHLU8NRuUT0AEFN6ppc2Oj6W8E6fKUnWkL77RI7KFk0
         Xe3/dUyD9UPgSrcgo5ePMS679/LPr5D9+EXXiya8Z6vZdkF/gAk50DCOqDf3PsgGozPb
         pXaA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ53xMRjse0DfyZZasmbaXHuUer25nGJAMeWPomMuaNEik0PWLYWrRsrLlptqHrGAc7UlwzZdiGHDMJdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfcpCbL0GUi+DVtYugUx1MPkbXlQAUVrjH5EASBqXv1MLZnY0m
	NB9ftf2Bww5dpao297VOoxo7D1ktY3pPVXeE0iK3J/5ZeZLV7B/4+w6U
X-Gm-Gg: ASbGnctKYzCj/EoF17IB358kALW8zFiAG0oZEaR8PeB5BGcpfQ7hrE2F0FGHMMx5+Yu
	h6qqxmhtTcILz5kvaM47dx3SmIzMD2Cqm6W8OK/7BLP9cXSgMZk1sIZE2x1AbcJNALBDWnCasyl
	zgcVgnaBHSeGj1WxHETocKYIPNAaZi2eg9mwtthrrK9q2N+aNhLh9vyoAV+KbbbwqSp1Hft5NiO
	HscljMj5ateiLVYlzqcw8xJvJeXvOA4y8x4S7TZjQyXOa4QUOxZd9v4qRfpFEL1yvkREGXIEBVD
	grxwCWX17TGvjxpNJ5kGhYX/8TE0jrwb/osKRKu5lnZwD+oHFThEEMVW7tvgfT0ZMVA0HK5NZNm
	rh8wSXt4IRlVsE30CmH2OlLERPksfUYYCf20rzdNPwJFcKJ5jr/v6uhB9+z8ltPm7vfXfN/ac
X-Google-Smtp-Source: AGHT+IE5shqQIUKbOw6hlw6cRTrcBtFVXG2OEPPmead9j/NTizmYAzcuhQc64qnxQ9XZRhrVFrM2rw==
X-Received: by 2002:a05:6000:310f:b0:3ec:d7c4:25a5 with SMTP id ffacd0b85a97d-3ecd7c4282emr1856689f8f.42.1758031181954;
        Tue, 16 Sep 2025 06:59:41 -0700 (PDT)
Received: from f.. (cst-prg-88-146.cust.vodafone.cz. [46.135.88.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7cde81491sm16557991f8f.42.2025.09.16.06.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 06:59:41 -0700 (PDT)
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
Subject: [PATCH v4 05/12] netfs: use the new ->i_state accessors
Date: Tue, 16 Sep 2025 15:58:53 +0200
Message-ID: <20250916135900.2170346-6-mjguzik@gmail.com>
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

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

cheat sheet:
Suppose flags I_A and I_B are to be handled, then if ->i_lock is held:

state = inode->i_state          => state = inode_state_read(inode)
inode->i_state |= (I_A | I_B)   => inode_state_add(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B)  => inode_state_del(inode, I_A | I_B)
inode->i_state = I_A | I_B      => inode_state_set(inode, I_A | I_B)

If ->i_lock is not held or only held conditionally, add "_once"
suffix for the read routine or "_raw" for the rest:

state = inode->i_state          => state = inode_state_read_once(inode)
inode->i_state |= (I_A | I_B)   => inode_state_add_raw(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B)  => inode_state_del_raw(inode, I_A | I_B)
inode->i_state = I_A | I_B      => inode_state_set_raw(inode, I_A | I_B)

 fs/netfs/misc.c        | 8 ++++----
 fs/netfs/read_single.c | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 20748bcfbf59..f0f23887d350 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -147,10 +147,10 @@ bool netfs_dirty_folio(struct address_space *mapping, struct folio *folio)
 	if (!fscache_cookie_valid(cookie))
 		return true;
 
-	if (!(inode->i_state & I_PINNING_NETFS_WB)) {
+	if (!(inode_state_read_once(inode) & I_PINNING_NETFS_WB)) {
 		spin_lock(&inode->i_lock);
-		if (!(inode->i_state & I_PINNING_NETFS_WB)) {
-			inode->i_state |= I_PINNING_NETFS_WB;
+		if (!(inode_state_read(inode) & I_PINNING_NETFS_WB)) {
+			inode_state_add(inode, I_PINNING_NETFS_WB);
 			need_use = true;
 		}
 		spin_unlock(&inode->i_lock);
@@ -192,7 +192,7 @@ void netfs_clear_inode_writeback(struct inode *inode, const void *aux)
 {
 	struct fscache_cookie *cookie = netfs_i_cookie(netfs_inode(inode));
 
-	if (inode->i_state & I_PINNING_NETFS_WB) {
+	if (inode_state_read_once(inode) & I_PINNING_NETFS_WB) {
 		loff_t i_size = i_size_read(inode);
 		fscache_unuse_cookie(cookie, aux, &i_size);
 	}
diff --git a/fs/netfs/read_single.c b/fs/netfs/read_single.c
index fa622a6cd56d..f728aae9bde9 100644
--- a/fs/netfs/read_single.c
+++ b/fs/netfs/read_single.c
@@ -36,12 +36,12 @@ void netfs_single_mark_inode_dirty(struct inode *inode)
 
 	mark_inode_dirty(inode);
 
-	if (caching && !(inode->i_state & I_PINNING_NETFS_WB)) {
+	if (caching && !(inode_state_read_once(inode) & I_PINNING_NETFS_WB)) {
 		bool need_use = false;
 
 		spin_lock(&inode->i_lock);
-		if (!(inode->i_state & I_PINNING_NETFS_WB)) {
-			inode->i_state |= I_PINNING_NETFS_WB;
+		if (!(inode_state_read(inode) & I_PINNING_NETFS_WB)) {
+			inode_state_add(inode, I_PINNING_NETFS_WB);
 			need_use = true;
 		}
 		spin_unlock(&inode->i_lock);
-- 
2.43.0


