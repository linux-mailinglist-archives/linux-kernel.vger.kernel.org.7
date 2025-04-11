Return-Path: <linux-kernel+bounces-600827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9B5A864EE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 19:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4B8C9A29FB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 17:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E71A23BF93;
	Fri, 11 Apr 2025 17:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V4P+x8fZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169FA1E0DD9
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 17:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744393148; cv=none; b=OrU0y0b2debsUS2VYaj5kdqiybgtazfrkrHIJeE6xUL7g1p28Do4wTEY9HkPcUtyXtTw6O2NoNQM8bH38+PiOAcNgJ8aR2L5OKJypzq59Bm2qjZEEbL/qroOfJgHCMBk1u03cRwd5ulwIcjMzyyNEzflnz1w3Rb4qi/0KqAkxXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744393148; c=relaxed/simple;
	bh=zGJwNblsKqEOAKwEuDeH3u+zc5jfILger+41mjo0QGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r6ow4KeskecrBqWGkahIOx8AsKA7c+XEZal3RbgJgKpf8OJx+cRdM2Kf7+IBOGSFVdGCRn23b+Ap5Q8BiRSCAvC7w0Ri5Xe3i1m9EOEjwt9p9voli1FGB/k9rF8cKvQIOV9v8tDm0pCWN5MRrz6iSU2o901IrpMWgJKxgIqZgSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V4P+x8fZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744393146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dva4W/D+dzFw10w19z6EzVLC4AZPhczTeYs/RvqJzPQ=;
	b=V4P+x8fZQgmgRFq55Coxn3/8rQv5DBuBW8+AIDC4ub+jI80zTEsuFFFb1MLnAhvqMWfadQ
	zBo8psAWYyGRplrD0VzDMyZNwVQg1ByQx17xiW6YEymUMNlFDTPFhYXQe8TJ5YidB7f9Eh
	TV9E9NhTMTMKcrp8V1SGwkZuCH+ozZg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-hn85JY29PSC-DeJZLdKDWg-1; Fri,
 11 Apr 2025 13:39:02 -0400
X-MC-Unique: hn85JY29PSC-DeJZLdKDWg-1
X-Mimecast-MFC-AGG-ID: hn85JY29PSC-DeJZLdKDWg_1744393141
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 57B291800260;
	Fri, 11 Apr 2025 17:39:01 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.37])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 28C8E1956094;
	Fri, 11 Apr 2025 17:38:57 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: cgroups@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Rafael Aquini <aquini@redhat.com>,
	gfs2@lists.linux.dev,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v2 2/2] writeback: Fix false warning in inode_to_wb()
Date: Fri, 11 Apr 2025 19:38:47 +0200
Message-ID: <20250411173848.3755912-3-agruenba@redhat.com>
In-Reply-To: <20250411173848.3755912-1-agruenba@redhat.com>
References: <20250411173848.3755912-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

From: Jan Kara <jack@suse.cz>

inode_to_wb() is used also for filesystems that don't support cgroup
writeback. For these filesystems inode->i_wb is stable during the
lifetime of the inode (it points to bdi->wb) and there's no need to hold
locks protecting the inode->i_wb dereference. Improve the warning in
inode_to_wb() to not trigger for these filesystems.

Signed-off-by: Jan Kara <jack@suse.cz>
Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 include/linux/backing-dev.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 8e7af9a03b41..b503a9a4fa65 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -245,10 +245,11 @@ wb_get_create_current(struct backing_dev_info *bdi, gfp_t gfp)
  * holding either @inode->i_lock, the i_pages lock, or the
  * associated wb's list_lock.
  */
-static inline struct bdi_writeback *inode_to_wb(const struct inode *inode)
+static inline struct bdi_writeback *inode_to_wb(struct inode *inode)
 {
 #ifdef CONFIG_LOCKDEP
 	WARN_ON_ONCE(debug_locks &&
+		     (inode->i_sb->s_iflags & SB_I_CGROUPWB) &&
 		     (!lockdep_is_held(&inode->i_lock) &&
 		      !lockdep_is_held(&inode->i_mapping->i_pages.xa_lock) &&
 		      !lockdep_is_held(&inode->i_wb->list_lock)));
-- 
2.48.1


