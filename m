Return-Path: <linux-kernel+bounces-601456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3051EA86E30
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Apr 2025 18:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02823441070
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Apr 2025 16:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8F3208997;
	Sat, 12 Apr 2025 16:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eCe1Y3uC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5666B205502
	for <linux-kernel@vger.kernel.org>; Sat, 12 Apr 2025 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744475975; cv=none; b=nQU9blSDxxmvhmjE5Vls2cIr7Zu7RPUTZeHZE/edL5BAaJtGGIWPnP0u+emX5NIr5knn+oFfriYY4muKlOK/wbxlUHN1EvFGTKAtPtdBgFkFaDApi8tWKhKhG9WYGBpaQFwh0ehk62UW2Fww8130oPmuCTRNQZg6fQeo+F0uE/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744475975; c=relaxed/simple;
	bh=KrifTKNbtTOpZjVsriJwHelBy/tOyNLz7rJCylrYNzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fI0PlX832pLP8El0j4BzuzIQgkiNrjU1z0in0HXpafvhIV/p0/e6LiLL2sPpbdKOh7kShdi7ae6c5hqC5Pz4trT2P7gIBKglbpdZ9a59Oh99XMP7cXZWOplQ1P+XYWn/JZZ3ouZTL3/Rj+M2Jq3Xf8Dnfhcwjjg9Qy+j+HdH0sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eCe1Y3uC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744475971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=as4CGAakZQuKhDm6Y+wA6IfY1weX2O0DARSrhX57YeI=;
	b=eCe1Y3uCpAvnNPbV7Xo3QFf1yCKfr7qprEK5H0bC1qJ6oLthOdj71Cyf9aGyyuApws8kl1
	7MZq4PCLJBi/q0D3kGtbiLyS1JLrtUqv6U+z6J7B7wu0nYTX9SdQZ815PsRrgdLC2ZslDb
	4LzjyizqiLetUSQzSieMy8RQm2NLrJI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-xbQKs-d4M3a2WxYTFrA6YA-1; Sat,
 12 Apr 2025 12:39:28 -0400
X-MC-Unique: xbQKs-d4M3a2WxYTFrA6YA-1
X-Mimecast-MFC-AGG-ID: xbQKs-d4M3a2WxYTFrA6YA_1744475966
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D6A3180049D;
	Sat, 12 Apr 2025 16:39:26 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.37])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 69ACE180174E;
	Sat, 12 Apr 2025 16:39:23 +0000 (UTC)
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
Subject: [PATCH v3 2/2] writeback: Fix false warning in inode_to_wb()
Date: Sat, 12 Apr 2025 18:39:12 +0200
Message-ID: <20250412163914.3773459-3-agruenba@redhat.com>
In-Reply-To: <20250412163914.3773459-1-agruenba@redhat.com>
References: <20250412163914.3773459-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

From: Jan Kara <jack@suse.cz>

inode_to_wb() is used also for filesystems that don't support cgroup
writeback. For these filesystems inode->i_wb is stable during the
lifetime of the inode (it points to bdi->wb) and there's no need to hold
locks protecting the inode->i_wb dereference. Improve the warning in
inode_to_wb() to not trigger for these filesystems.

Signed-off-by: Jan Kara <jack@suse.cz>
Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 include/linux/backing-dev.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 8e7af9a03b41..e721148c95d0 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -249,6 +249,7 @@ static inline struct bdi_writeback *inode_to_wb(const struct inode *inode)
 {
 #ifdef CONFIG_LOCKDEP
 	WARN_ON_ONCE(debug_locks &&
+		     (inode->i_sb->s_iflags & SB_I_CGROUPWB) &&
 		     (!lockdep_is_held(&inode->i_lock) &&
 		      !lockdep_is_held(&inode->i_mapping->i_pages.xa_lock) &&
 		      !lockdep_is_held(&inode->i_wb->list_lock)));
-- 
2.48.1


