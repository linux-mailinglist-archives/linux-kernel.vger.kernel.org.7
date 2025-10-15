Return-Path: <linux-kernel+bounces-854492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 652D0BDE827
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8929B485499
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C63F2E9ECA;
	Wed, 15 Oct 2025 12:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iOHFuIiH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D910DEEDE
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760531888; cv=none; b=dYATelTACWxCWGpdGPboU/yYQfQNjqgJdHVCjy2Hue+hvT0EEqF0NOL5kvJ9qnHZmv4SEQ2OGI+6sIlrG7OZ7Pnkw8cN388Y2qtJhZngxdm6oXb9fsa+WZo8LnG2iXx3e3bzX4JiVcEP4NNRd9B2Kc7gXTlsYI5jNSKqP3f5D4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760531888; c=relaxed/simple;
	bh=FqJ2+OozGme0qSiiEa5BGHApAh1LdoV3Re4YTMB3l3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUAg2U2+/bauVNCM0CnpysPHFFhmpyWIWzpAKX5S+FxseNkQUrbmUP2gOtCPYk2uLmxMm2zd2bQeKDnpcD9LaKee1mF2xqjC0X2l/W75dcwFgPN3HdBYZj/yeMA+88RqvFGAXj1crx1jqaS7AZwn/dV/2bOdpb+XK7ALRji6WFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iOHFuIiH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760531882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uK9hM0kHeE+mKtADnnKF7MLzurioq0BohyfJPFzNKC8=;
	b=iOHFuIiHt1vvFT3SudMWGnztCHKdDxriyLBIX0Odwq1KYgOVHeBYegwhqlstZ7FS7JEDPG
	z6oosmh3j4LOQr5QWj48QmY3vIrZMRa4rmB8/NseMZlFRN7Xn9uYXeU42s/JGWXGo3ImSe
	iJMlNhAGow2SOUHkoS+iU9PGxrqlqsw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-326-hFWPPXpVM12OwN3iI2kWdg-1; Wed,
 15 Oct 2025 08:37:58 -0400
X-MC-Unique: hFWPPXpVM12OwN3iI2kWdg-1
X-Mimecast-MFC-AGG-ID: hFWPPXpVM12OwN3iI2kWdg_1760531876
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2DAB31800742;
	Wed, 15 Oct 2025 12:37:56 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.241])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4FA751955BE3;
	Wed, 15 Oct 2025 12:37:54 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 15 Oct 2025 14:36:36 +0200 (CEST)
Date: Wed, 15 Oct 2025 14:36:33 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: gaoxiang17 <gaoxiang17@xiaomi.com>, Mateusz Guzik <mjguzik@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] pid: introduce task_ppid_vnr() helper
Message-ID: <20251015123633.GB9456@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Cosmetic change. Unlike all other similar helpers task_ppid_nr_ns() doesn't
have a _vnr() version; add one for consistency.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/pidfs.c          | 2 +-
 include/linux/pid.h | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 0ef5b47d796a..43bc0113ba71 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -400,7 +400,7 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 	 * the fields are set correctly, or return ESRCH to avoid providing
 	 * incomplete information. */
 
-	kinfo.ppid = task_ppid_nr_ns(task, NULL);
+	kinfo.ppid = task_ppid_vnr(task);
 	kinfo.tgid = task_tgid_vnr(task);
 	kinfo.pid = task_pid_vnr(task);
 	kinfo.mask |= PIDFD_INFO_PID;
diff --git a/include/linux/pid.h b/include/linux/pid.h
index 003a1027d219..dd51bb08354c 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -310,6 +310,11 @@ static inline pid_t task_ppid_nr_ns(const struct task_struct *tsk, struct pid_na
 	return pid;
 }
 
+static inline pid_t task_ppid_vnr(const struct task_struct *tsk)
+{
+	return task_ppid_nr_ns(tsk, NULL);
+}
+
 static inline pid_t task_ppid_nr(const struct task_struct *tsk)
 {
 	return task_ppid_nr_ns(tsk, &init_pid_ns);
-- 
2.25.1.362.g51ebf55



