Return-Path: <linux-kernel+bounces-836423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB03BA9A55
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BAD27A7BC1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C0B30B53D;
	Mon, 29 Sep 2025 14:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWpgW3vt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A0330B508
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 14:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759156878; cv=none; b=L6M9jFEAVFXejFpY2X5wIPgvJDK8T9L74Z4A9hNcJKPS0ps9oxk8trIQ4Zw1Qwl4puNFfVAL9iKKaTlKpzPGHkOFEZe5Eq/RIDFrdstTZE8ylcNaQhJRJf+qk8YAMisYl3Y8XBPAADJO3aKGDeTFHZYTwRje4Wil54mOZkzNzyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759156878; c=relaxed/simple;
	bh=pAnQQOOIXd2ZwElnUic41CLFzwzbOlUl4FANGhxifLY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BDaqInj6WTcxufecr10fnTIapn1VFSVMNxlenkdjk1ar8txNrWJSavs3FKru28AE8Oicm+yeU4CpposhB28HmqfeDB9u/XeD9VWYHLrG40qs+JsQ3s9//TY6TIQJbFpjaF2NfMxIJqhwCr3AZtdzX/8mujsBmj/YRKGo0aex/mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HWpgW3vt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759156875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=c04heTAl7RQxQsGulCNruMJ6K3Bkn34DaECM68w9sbM=;
	b=HWpgW3vtBo02s+wrACtoEnsr0pW/TGmG+RmjI1szTfZSPJxG4CPxrlIdARpeFRg50hpn1+
	VDN1ca3ZTUcfaduolEFNRPaRsxi/3moCeyGPyhws5Djxri5Huv+6nkQBcQwzUf4Z1KTYua
	qkp25HM/rjVEImRDZVLykjHCx3rsccE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-o79F5H0TN6u_LRapffCU2A-1; Mon,
 29 Sep 2025 10:41:12 -0400
X-MC-Unique: o79F5H0TN6u_LRapffCU2A-1
X-Mimecast-MFC-AGG-ID: o79F5H0TN6u_LRapffCU2A_1759156871
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5292318002C2;
	Mon, 29 Sep 2025 14:41:11 +0000 (UTC)
Received: from redhat.com (unknown [10.22.81.226])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D7531800576;
	Mon, 29 Sep 2025 14:41:10 +0000 (UTC)
Date: Mon, 29 Sep 2025 09:41:07 -0500
From: David Teigland <teigland@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
Subject: [GIT PULL] dlm updates for 6.18
Message-ID: <aNqag0RIXLcG5BH3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Linus,

Please pull dlm updates from tag:

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.18

This set of patches add a dlm_release_lockspace() flag to request that
node-failure recovery be performed for the node leaving the lockspace.
The implementation of this flag requires coordination with userland
clustering components.  It's been requested for use by GFS2.

Thanks,
Dave

Alexander Aring (9):
      dlm: check for defined force value in dlm_lockspace_release
      dlm: use defines for force values in dlm_release_lockspace
      dlm: add new RELEASE_RECOVER uevent attribute for release_lockspace
      dlm: add new configfs entry release_recover for lockspace members
      dlm: add new flag DLM_RELEASE_RECOVER for dlm_lockspace_release
      dlm: handle invalid lockspace member remove
      dlm: move to rinfo for all middle conversion cases
      dlm: handle release_option as unsigned
      dlm: check for undefined release_option values

 drivers/md/md-cluster.c |  4 ++--
 fs/dlm/config.c         | 64 +++++++++++++++++++++++++++++++++++++++++++++++--
 fs/dlm/config.h         |  2 ++
 fs/dlm/lock.c           |  2 +-
 fs/dlm/lockspace.c      | 46 +++++++++++++++++++----------------
 fs/dlm/member.c         | 27 ++++++++++++++++-----
 fs/dlm/recover.c        |  2 +-
 fs/dlm/user.c           |  6 ++---
 fs/gfs2/lock_dlm.c      |  4 ++--
 fs/ocfs2/stack_user.c   |  2 +-
 include/linux/dlm.h     | 33 ++++++++++++++++++++++++-
 11 files changed, 153 insertions(+), 39 deletions(-)


