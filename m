Return-Path: <linux-kernel+bounces-801431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A4FB444E8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499FD1CC30F9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEED32A3CC;
	Thu,  4 Sep 2025 17:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AuOEf76V"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1519531DDB9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008710; cv=none; b=MvWhIzPahrp699b5K67dlC25YDWws089dwpS9EBO8SFRhuXsZNnyMvj+aishrnKVBHsG5RMCYgOilaw/y3yNfUt9K/L8ZQycGjwjCRe9owCsq6gR8YIUZcuUOOkZ1r5XLnZhqAClfhpndPiTTZkuP/yVsQ/8H3odbm2jNfwo8wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008710; c=relaxed/simple;
	bh=GFCXiPNxr6FIq1X97+/9s6/CYhA2mYYeDTtgBDxKlTs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GXw1E9Sc7aibt7HDbGZwJl8X9rKM17T03+oKq+jku0go0ZOGELfti82c1eVshm77ldgPGXrIRHhvWaQKT1Fwmv2deXRqnRGR7W76EFgIdrmDc1YERY20rkpZCLfckTCGL8Nzb8HYMTr2J+nZ2CFhA+brBJQ9QMuAon2ZYkSoVCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AuOEf76V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757008708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=lYOAUHIKSk6MKKfReIME4+kdHPyD+NO2CYTz0j1NUlY=;
	b=AuOEf76VLzZQ03rOKCjIiGuqXzqgmclQ7TlSuIx+aBZM8EWvw1hR3YQJo79cQm2V0Bq+A3
	2anl7SHz2Gv52MlsI6X0ozfG7WfpwV5FHDG3oFRqP1rfPsLBlCQdJmbgAjRtG3aE+W61uA
	ctFfC+sVdfGFaf2Yjnt03QZBWouxb6M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-AIwYyFfTN_6GrXH5niCXbQ-1; Thu,
 04 Sep 2025 13:58:24 -0400
X-MC-Unique: AIwYyFfTN_6GrXH5niCXbQ-1
X-Mimecast-MFC-AGG-ID: AIwYyFfTN_6GrXH5niCXbQ_1757008703
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 44427180048E;
	Thu,  4 Sep 2025 17:58:22 +0000 (UTC)
Received: from localhost (unknown [10.22.82.11])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C795F180044F;
	Thu,  4 Sep 2025 17:58:20 +0000 (UTC)
Date: Thu, 4 Sep 2025 14:58:19 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	stable-rt <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Clark Williams <williams@redhat.com>,
	Mark Gross <markgross@kernel.org>, Pavel Machek <pavel@denx.de>,
	Jeff Brady <jeffreyjbrady@gmail.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 5.10.241-rt135
Message-ID: <aLnTO44sihv44T1f@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hello RT-list!

I'm pleased to announce the 5.10.241-rt135 stable release.

This release is just an update to the new stable 5.10.241 version and
no RT changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: ae9468b2aec045dbfc6541c064db3c57c30d0572

Or to build 5.10.241-rt135 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.241.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.241-rt135.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

Changes from v5.10.240-rt134:
---
  Merge conflict in kernel/cgroup/cpuset.c: context conflict due to
  callback_lock being a raw_spin_lock in RT.
  
---
diff --cc kernel/cgroup/cpuset.c
index 6a61bb8e2669,efe9785c6c13..e9372633d69f
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@@ -1878,9 -1896,11 +1896,11 @@@ static int update_nodemask(struct cpuse
  	if (retval < 0)
  		goto done;
  
+ 	check_insane_mems_config(&trialcs->mems_allowed);
+ 
 -	spin_lock_irq(&callback_lock);
 +	raw_spin_lock_irq(&callback_lock);
  	cs->mems_allowed = trialcs->mems_allowed;
 -	spin_unlock_irq(&callback_lock);
 +	raw_spin_unlock_irq(&callback_lock);
  
  	/* use trialcs->mems_allowed as a temp variable */
  	update_nodemasks_hier(cs, &trialcs->mems_allowed);


