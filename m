Return-Path: <linux-kernel+bounces-748167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719A2B13D5F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A6DF3B5E6F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576F222F76B;
	Mon, 28 Jul 2025 14:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rm3Q5D5x"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9AF24DCF9
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 14:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753713527; cv=none; b=EcxkhMWB2sGCNGTKoY8zl/dodMv5fC0OcuT3TQNX5XnBMvGJhA7f5tk0iE/dsZwjOnvRSCFJTQmaf+GYwgqQMMj6Eb3JJoAAFzXUVVtPdEcJz6VDEHQsvEzAqe9Xea8oQYioc8ucJJlOepKzlFEw0UWhE7geLw3oo/yzUoJAvhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753713527; c=relaxed/simple;
	bh=o70mPU2wQuff4uxJtxViiEC625nYOHrn+5MWzkmwLT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JUNARm2EAZkoFEjA9obEMMVoPs6N1SMced53TUW+l5zSeAsk1bOEHKp3yWfG82GeVkKPGj2r91qXdz+q8RNqDCgeKGAHQSyWFVG2y42E9XmY++nuK0WqdCx1xUWxh0zcfDUYs3+IWIFzyKYVJjaYdpsaxjgpSHplnMxhRBhA72A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rm3Q5D5x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753713524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1ddnsUptmbXKH7BOwm60SQvszd1IlPxjs6pIoKDn5Ag=;
	b=Rm3Q5D5xq80dZEvZewsZNiiQBcN045mGXQQ7KORUn3FiwvMm6sMywIaR9jV4IpmizHFoyW
	bA2PRctC2tUMlyQmhEqLrsXk5OpUrqU4SxucRFNHvQ7gNnsKgU6OnGGiXJxyHEyrmMTOzb
	5LTecjbDThXd9iraibNK/tZvm218T8s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-zBmuHSNaMjqVQswNAbsYWg-1; Mon,
 28 Jul 2025 10:38:41 -0400
X-MC-Unique: zBmuHSNaMjqVQswNAbsYWg-1
X-Mimecast-MFC-AGG-ID: zBmuHSNaMjqVQswNAbsYWg_1753713520
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F2F518003FC;
	Mon, 28 Jul 2025 14:38:40 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.225.226])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EDA77180035E;
	Mon, 28 Jul 2025 14:38:38 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 changes for 6.17
Date: Mon, 28 Jul 2025 16:38:35 +0200
Message-ID: <20250728143837.137302-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Dear Linus,

please consider pulling the following gfs2 changes for 6.17.

Thanks,
Andreas

The following changes since commit d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af:

  Linux 6.16-rc4 (2025-06-29 13:09:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-6.17

for you to fetch changes up to deb016c1669002e48c431d6fd32ea1c20ef41756:

  gfs2: No more self recovery (2025-07-16 23:30:32 +0200)

----------------------------------------------------------------
gfs2 changes

- Prevent cluster nodes from trying to recover their own filesystems
  during a withdraw.

- Add two missing migrate_folio aops and an additional exhash directory
  consistency check (both triggered by syzbot bug reports).

- Sanitize how dlm results are processed and clean up a few quirks in
  the glock code.

- Minor stuff: Get rid of the GIF_ALLOC_FAILED flag; use SECTOR_SIZE and
  SECTOR_SHIFT.

----------------------------------------------------------------
Andreas Gruenbacher (7):
      gfs2: Use SECTOR_SIZE and SECTOR_SHIFT
      gfs2: Remove GIF_ALLOC_FAILED flag
      gfs2: Minor do_xmote cancelation fix
      gfs2: sanitize the gdlm_ast -> finish_xmote interface
      gfs2: simplify finish_xmote
      gfs2: a minor finish_xmote cleanup
      gfs2: No more self recovery

Andrew Price (2):
      gfs2: Set .migrate_folio in gfs2_{rgrp,meta}_aops
      gfs2: Validate i_depth for exhash directories

 fs/gfs2/dir.c        |  6 ++----
 fs/gfs2/glock.c      | 43 +++++++++++++++++++++----------------------
 fs/gfs2/glock.h      | 10 ++++++++++
 fs/gfs2/glops.c      |  6 ++++++
 fs/gfs2/incore.h     |  1 -
 fs/gfs2/inode.c      |  7 ++-----
 fs/gfs2/inode.h      |  6 +++---
 fs/gfs2/lock_dlm.c   |  9 ++++++---
 fs/gfs2/meta_io.c    | 10 +++++-----
 fs/gfs2/ops_fstype.c | 12 ++++++------
 fs/gfs2/super.c      |  6 ++----
 fs/gfs2/util.c       | 31 +++++++++++--------------------
 12 files changed, 74 insertions(+), 73 deletions(-)


