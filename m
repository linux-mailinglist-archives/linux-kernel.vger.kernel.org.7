Return-Path: <linux-kernel+bounces-582479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B535BA76D9B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 21:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 106F31888C56
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 19:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F7021764B;
	Mon, 31 Mar 2025 19:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VEz73Zem"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E44173
	for <linux-kernel@vger.kernel.org>; Mon, 31 Mar 2025 19:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743450502; cv=none; b=p4RoFvZlq/8MNo0cUUvURTNT5g6U7cT4OpSFvndfaVgQ/WlYm3JuXciBkP5aqWc1zKlYJ1Agn7ZURl3nj7J8mj109ONofQQoBHCEAoqwcxiYEBIVnZuRs9S9nmVZSk4SJVDCCtzqVYtrt9ortFGko/Xcb0LBsj/sy+9+VRe/XeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743450502; c=relaxed/simple;
	bh=jx+kOVHSUKCbsRcFvKLazaf4NS5jfInnRrJa8Rwz4xE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pElBYNQxM5wrocAtUocEM2L71qaHMVCgiN2RVE3lr/lGOMbeN2UTgcRvnHhscteanZEZ64cMBSSJIsrVqcs50OWLLlDqrHCHYwGMSQn10HgbatW/LBtkPEjB+gNuNgWDY1IGo1XAugAFjS8rGWmkgBDMhlnafn6UNyrzTeEKysc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VEz73Zem; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743450500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=CZUl/W/3DHj1eibZ+TU4Ipkjrazfz2B71T5aEi4wVx4=;
	b=VEz73ZemYQhvlvXpnnplyalBBkOabzUV9WQvCgxZh/3Y6v2cxM+ID6xETK3B1KvuAo7Bz5
	YXtn036vt5wf5XHPwlKzv5n0RhpZ48hLDUGI/42PsoYDSjxRSWyOViEAfaGLHRW54yv6Mx
	IyQbissOTLtGpoWvOE0Tw2Qd5/mokiQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-qMpU8gAMOwOyyBQThh2qMg-1; Mon,
 31 Mar 2025 15:48:16 -0400
X-MC-Unique: qMpU8gAMOwOyyBQThh2qMg-1
X-Mimecast-MFC-AGG-ID: qMpU8gAMOwOyyBQThh2qMg_1743450494
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E7351800349;
	Mon, 31 Mar 2025 19:48:14 +0000 (UTC)
Received: from localhost (unknown [10.22.65.234])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F3E33180B488;
	Mon, 31 Mar 2025 19:48:12 +0000 (UTC)
Date: Mon, 31 Mar 2025 16:48:11 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	stable-rt <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	Mark Gross <markgross@kernel.org>, Pavel Machek <pavel@denx.de>,
	Jeff Brady <jeffreyjbrady@gmail.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Ben Hutchings <benh@debian.org>
Subject: [ANNOUNCE] 5.10.235-rt129
Message-ID: <Z-rxe2n4qOskrg2f@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hello RT-list!

I'm pleased to announce the 5.10.235-rt129 stable release.

While working on the stable update 5.10.235-rt128, a build problem
on the be2net driver was discovered on RT. That inconvenience was
fixed, hence the release of 5.10.235-rt129.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: d7dcda5ab69cd154e135797b8d116d5a0736eae2

Or to build 5.10.235-rt129 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.235.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.235-rt129.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

Changes from v5.10.235-rt128:
---

Luis Claudio R. Goncalves (2):
      rt: fix build issue in be2net
      Linux 5.10.235-rt129
---
drivers/net/ethernet/emulex/benet/be_cmds.c | 7 ++++---
 localversion-rt                             | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)
---
diff --git a/drivers/net/ethernet/emulex/benet/be_cmds.c b/drivers/net/ethernet/emulex/benet/be_cmds.c
index 9812a9a5d033..3068ccd37034 100644
--- a/drivers/net/ethernet/emulex/benet/be_cmds.c
+++ b/drivers/net/ethernet/emulex/benet/be_cmds.c
@@ -875,9 +875,10 @@ static int be_cmd_lock(struct be_adapter *adapter)
 /* Must be used only in process context */
 static void be_cmd_unlock(struct be_adapter *adapter)
 {
-	if (use_mcc(adapter))
-		return spin_unlock_bh(&adapter->mcc_lock);
-	else
+	if (use_mcc(adapter)) {
+		spin_unlock_bh(&adapter->mcc_lock);
+		return;
+	} else
 		return mutex_unlock(&adapter->mbox_lock);
 }
 
diff --git a/localversion-rt b/localversion-rt
index 6d2a676e2033..90303f5aabcf 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt128
+-rt129


