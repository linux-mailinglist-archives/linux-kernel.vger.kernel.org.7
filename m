Return-Path: <linux-kernel+bounces-761524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F4AB1FB66
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 19:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E7A73B2E71
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 17:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269EF26E16C;
	Sun, 10 Aug 2025 17:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fdAvuQu6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F7570830
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 17:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754847448; cv=none; b=KRdHUP5yd832IoQvwIVRqDf5MaM0TIqQjUGlu1N9fVAghsD+bJs9P95zyhCvlokTFbbSOG9TfnS84FlAxITTIlp9jan7UFvaGYbgJg3k7mOSWs/2AY1nWaZ8lWtqoIT/cy4QIvjiFylBAx5YSQybwnuDLdzPkU4WjFJlmQbUO9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754847448; c=relaxed/simple;
	bh=JWRoAFXI53tKTffTQ613LNzAzvLx3GsocVJvfwm7g/I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RLGli6kzoCswUpkamBDbhemibX3K1yxh0NOdrAJmPCS/DRH8WSCTLikGxKFivf2y9M916sTxX5sn3cI/2IbREB0PRSaqxzsbpZ/khb+nqMMbl75jtFI44Qo4i0VjO8gY09PAQEgN+bTatQSPu/+y7OC6We+5GN7czoy0nRZ0lfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fdAvuQu6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754847445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=OC6KFeHyT784akpQVGOmiU6pTejLnPxeuUzyzzL+VkI=;
	b=fdAvuQu6/y9wdetQLE/YEwIylo3GkwKbMDoNCcqGFAFNOptJ7IVMrapHh9jTKjdxyprcaL
	3jDMyGMFQfq2TCPK7VDFk4fm6PwIGjxtCiBRyQpNGJSyte+IJH9x9vzOFtFyCtPl0OFOUG
	BUYhLHRt/DqN/mjGN95/Mxksh5zYTZI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-Mig85h2jP3uA1bOtUdmWEg-1; Sun,
 10 Aug 2025 13:37:22 -0400
X-MC-Unique: Mig85h2jP3uA1bOtUdmWEg-1
X-Mimecast-MFC-AGG-ID: Mig85h2jP3uA1bOtUdmWEg_1754847441
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 830C219560AA;
	Sun, 10 Aug 2025 17:37:20 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.117])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9527C1955F16;
	Sun, 10 Aug 2025 17:37:17 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 10 Aug 2025 19:36:09 +0200 (CEST)
Date: Sun, 10 Aug 2025 19:36:04 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	=?utf-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Mateusz Guzik <mjguzik@gmail.com>,
	Xiang Gao <gxxa03070307@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] pid: make __task_pid_nr_ns(ns => NULL) safe for zombie
 callers
Message-ID: <20250810173604.GA19991@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250802022123.3536934-1-gxxa03070307@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

task_pid_vnr(another_task) will crash if the caller was already reaped.
The pid_alive(current) check can't really help, the parent/debugger can
call release_task() right after this check.

This also means that even task_ppid_nr_ns(current, NULL) is not safe,
pid_alive() only ensures that it is safe to dereference ->real_parent.

Change __task_pid_nr_ns() to ensure ns != NULL.

Originally-by: 高翔 <gaoxiang17@xiaomi.com>
Link: https://lore.kernel.org/all/20250802022123.3536934-1-gxxa03070307@gmail.com/
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/pid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index 8317bcbc7cf7..58d97a78f07e 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -514,7 +514,8 @@ pid_t __task_pid_nr_ns(struct task_struct *task, enum pid_type type,
 	rcu_read_lock();
 	if (!ns)
 		ns = task_active_pid_ns(current);
-	nr = pid_nr_ns(rcu_dereference(*task_pid_ptr(task, type)), ns);
+	if (ns)
+		nr = pid_nr_ns(rcu_dereference(*task_pid_ptr(task, type)), ns);
 	rcu_read_unlock();
 
 	return nr;
-- 
2.25.1.362.g51ebf55


