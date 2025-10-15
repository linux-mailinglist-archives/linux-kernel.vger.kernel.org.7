Return-Path: <linux-kernel+bounces-854488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F918BDE806
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD6B319C3581
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0B82C17A8;
	Wed, 15 Oct 2025 12:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NSl6vLGO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A127125A9
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760531863; cv=none; b=DzhCZFvvo6TpEInu95n+bJI9FQiHuPFEFubYy+8zAXm/VzXTTMXNcg/7W25/eHvFM47fDpgq+Pb/oWZFYWxF8W4K69v52s2OItoN0rEGUBY0FWuS6zH/U0R3luJAmyeALvJ8EGUnXkxHy9qAD3TcvdLPT0U4YwZQaRc/kdJPPIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760531863; c=relaxed/simple;
	bh=wzLi0FJqSECunTrBHdO4ZAnbxe+eWKf5Tz55DD63TLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXdUnH9StcNA7OTEm6axGRkjUKPbVzpAdNUmVQCdAvJgowZXqNesrNG/qCHhYjenrhhWk/Ame1jYf+0qTChqd94PCa49YvpVSfKDono7rGxTpsZrXC0oK5X5AyE7xbObaFvw+72ZspNWo68bFi3uUOla4HE5JTbqY1b1M2LIyOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NSl6vLGO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760531861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VYEPsa5iT6GqlmISWxWq/D0+25iox/pbBDZ3lTFGtYM=;
	b=NSl6vLGORw+OKtsQ1Ohhe175uy1yTEShAOL+nC723lZQeUfxv+nTMy9oBmh8f47oPZGy8/
	f9upNM5uaNBDxsN2tBNO9a8tOL8GFFkQoEIEzzsE3flX0ythIReEZKrqQnBV/1o3/ajN8Y
	r/BoVy+vH5Q5U1ZbMKUr49P6jdczQw0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-Z1faE2oaNaOEf90ZFPbf6w-1; Wed,
 15 Oct 2025 08:37:37 -0400
X-MC-Unique: Z1faE2oaNaOEf90ZFPbf6w-1
X-Mimecast-MFC-AGG-ID: Z1faE2oaNaOEf90ZFPbf6w_1760531856
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FE3919560AD;
	Wed, 15 Oct 2025 12:37:36 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.241])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id BB2901800446;
	Wed, 15 Oct 2025 12:37:34 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 15 Oct 2025 14:36:16 +0200 (CEST)
Date: Wed, 15 Oct 2025 14:36:13 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: gaoxiang17 <gaoxiang17@xiaomi.com>, Mateusz Guzik <mjguzik@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Revert "pid: make __task_pid_nr_ns(ns => NULL) safe for
 zombie callers"
Message-ID: <20251015123613.GA9456@redhat.com>
References: <20251015123550.GA9447@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015123550.GA9447@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This reverts commit abdfd4948e45c51b19162cf8b3f5003f8f53c9b9.

The changelog in this commit explains why it is not easy to avoid ns == NULL
when the caller is exiting, but pid_vnr() is equally unsafe in this case.

However, commit 006568ab4c5c ("pid: Add a judgment for ns null in pid_nr_ns")
already added the ns != NULL check in pid_nr_ns(), so we can remove the same
check from __task_pid_nr_ns().

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/pid.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index 4fffec767a63..be69ae771e3c 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -515,8 +515,7 @@ pid_t __task_pid_nr_ns(struct task_struct *task, enum pid_type type,
 	rcu_read_lock();
 	if (!ns)
 		ns = task_active_pid_ns(current);
-	if (ns)
-		nr = pid_nr_ns(rcu_dereference(*task_pid_ptr(task, type)), ns);
+	nr = pid_nr_ns(rcu_dereference(*task_pid_ptr(task, type)), ns);
 	rcu_read_unlock();
 
 	return nr;
-- 
2.25.1.362.g51ebf55



