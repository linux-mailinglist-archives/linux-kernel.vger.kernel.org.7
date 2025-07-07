Return-Path: <linux-kernel+bounces-720398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CC6AFBB1A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 870FD4277FE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8D8264FA9;
	Mon,  7 Jul 2025 18:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QE8XI3RL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CAA1DE4CE
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913974; cv=none; b=W7ldfuCYyKWWNnT8f72RVEru2eWHTrewq6dgC432CwwiKRYAIR9CrRXPmmrV5Z/shG5f6v0s3YbQ6b3XXBNCrkUPulZXFMrV32LPrTklergCTKITR8umq/Iu6HBVKFeLkPBrBH1QX358MEF42TIG5KHFWnJlWz9Y1hvNiLdYeLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913974; c=relaxed/simple;
	bh=Krl0igoXVK9sFd8z/pt5c7gFLQbU2nEc7Zl5TKqXHhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lfi++Tx+VGEEZExPbIKfg4p6haUDokS4kIQtcr8FxND5pPVivfiyAqkfb6ewQwdv/S9e5o9jGiWVrZ+NSM0DVrD3iGgbuHoPjVLwmlJ5ZF8uD81CC9vc3LMKYeFAt1fM9rU7uzK3NSIsgeWnEu0RmBtlmXApQ2RsQgjPBqW7nZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QE8XI3RL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751913970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lOSiRv9nD8gpWlblF+1k4Q/paNpek49AMTpNjSrzzz8=;
	b=QE8XI3RLl5XxSnZkwHAXSRC9b8epNKGJan5MXQt5yb5cqn0QcEhoR2m+lo0+4Z1PzW6IRI
	xrHvFmY6MdgGoiY+fRFZ9tDGcUcWxhwnFl/1nxkwLk0x3O19UFBF3U4o5M3qOZ26WHMaG3
	zdDIgdTZb+Do4f4NaV2s6PoQzq3+sdk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-MPFW4JLOMByVTYL3dKAn9Q-1; Mon,
 07 Jul 2025 14:46:07 -0400
X-MC-Unique: MPFW4JLOMByVTYL3dKAn9Q-1
X-Mimecast-MFC-AGG-ID: MPFW4JLOMByVTYL3dKAn9Q_1751913966
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8263D1809C83;
	Mon,  7 Jul 2025 18:46:06 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.74.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 13B0C195608F;
	Mon,  7 Jul 2025 18:46:04 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	djeffery@redhat.com,
	loberman@redhat.com
Subject: [PATCH 0/2] Fix loopback mounted filesystems on NFS
Date: Mon,  7 Jul 2025 14:46:02 -0400
Message-ID: <cover.1751913604.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

We've been investigating new reports of filesystem corruption on
loopback images on NFS clients.  It appears that during writeback the
loopback driver encounters allocation failures in NFS and fails to write
dirty pages to the backing file.

We believe the problem is due to the loopback driver performing writeback
from a workqueue (so PF_WQ_WORKER is set), however ever since work to
improve NFS' memory allocation strategies [1] its possible that NFS
incorrectly assumes that if PF_WQ_WORKER is set then the writeback context
is nfsiod.  To make things worse, NFS does not expect PF_WQ_WORKER to be set
along with other PF_ flags such as PF_MEMALLOC_NOIO, but cannot really know
(without checking them all) which other allocation flags are set should
writeback be entered from a NFS-external workqueue worker.

To fix this, I'd like to introduce a way to check which specific workqueue
is being served by a worker (in patch 1), so that NFS can ensure that it
sets certain allocation flags only for the nfsiod workqueue workers (in
patch 2).

[1]: https://lore.kernel.org/linux-nfs/20220322011618.1052288-1-trondmy@kernel.org/

Benjamin Coddington (2):
  workqueue: Add a helper to identify current workqueue
  NFS: Improve nfsiod workqueue detection for allocation flags

 fs/nfs/internal.h         | 12 +++++++++++-
 include/linux/workqueue.h |  1 +
 kernel/workqueue.c        | 18 ++++++++++++++++++
 3 files changed, 30 insertions(+), 1 deletion(-)

-- 
2.47.0


