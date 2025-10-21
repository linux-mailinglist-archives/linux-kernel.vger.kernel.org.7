Return-Path: <linux-kernel+bounces-862927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B822BF68B9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2CB1B503E09
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980E233343C;
	Tue, 21 Oct 2025 12:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SjYtMr9F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6336533343A
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761050982; cv=none; b=TmCKa7rKKxToSPEf5/pGDp8/u4AgCII9x54emoILxLCFXW8AY02QgLjL6fOrysTGjrF5mKQzJHY/zWfkwKVX9ZAzS0MuTrhBCHzAQPID/5hJU4hBalkDt633CJi/9Cpt6hQbttfGmdPaehpKdjb+DQDut9rSFf5TThCh7H3phpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761050982; c=relaxed/simple;
	bh=oCl8QhwD4YFXtytp21BeTWFVrtnv/Mx7eG/HPHCv3lU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YzN9bDw8bke2MoRPYVyTo1ueePSlUTOVukkiaSYf6+1+2MGpx1a+BgEaTx/a8aocLZJBOupr3rTocKMFbaOh+Tm0ES+ZqC9XlrB+N2Keh97ViwMs4rcli4/5HT6Mm92Wzbww0gJ4J8WwqgREtSGddeCc3qK8YisiwuJoRzqOHNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SjYtMr9F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761050979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Qn23J7rywZzalZw0oUbpvqLTaeUXqKnHA0ur273KncE=;
	b=SjYtMr9FZ9ZGwinq5ssvpDd6XtCkOSC+s1EO2dUgBv9kqysMvWoXds4lfoKP2JCXHZjPuD
	GgtXXuMrH99tQAn8cCeKov4KArPv1bpL2Tscvd6gjhesqvAJ/5de9T2BrmsRetZdAWTJ/c
	Qlnez9a6zzoSwslE9+F07KX+2OvamLI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-o4EAqQk3M1aD1zQgG9jZ_A-1; Tue,
 21 Oct 2025 08:49:37 -0400
X-MC-Unique: o4EAqQk3M1aD1zQgG9jZ_A-1
X-Mimecast-MFC-AGG-ID: o4EAqQk3M1aD1zQgG9jZ_A_1761050976
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8866E195608D;
	Tue, 21 Oct 2025 12:49:36 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.226.100])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DE9AD180035A;
	Tue, 21 Oct 2025 12:49:34 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>
Subject: [GIT PULL v2] rv fixes and selftests for v6.18-rc3
Date: Tue, 21 Oct 2025 14:48:30 +0200
Message-ID: <20251021124830.501505-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Steve,

The following changes since commit 211ddde0823f1442e4ad052a2f30f050145ccada:

  Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gmonaco/linux.git rv-6.18-rc3-2

for you to fetch changes up to 3d62f95bd8450cebb4a4741bf83949cd54edd4a3:

  rv: Make rtapp/pagefault monitor depends on CONFIG_MMU (2025-10-20 12:47:40 +0200)

----------------------------------------------------------------

Summary of changes:

* A bug causing kernel panic when reading enabled_monitors was reported,
  change callbacks functions to always use list_head iterators and by
  doing so, fix the wrong pointer that was leading to the panic.
* The rtapp/pagefault monitor relies on the MMU to be present
  (pagefaults exist) but that was not enforced via kconfig, leading to
  potential build errors on systems without an MMU. Add that kconfig
  dependency.

----------------------------------------------------------------
Nam Cao (2):
      rv: Fully convert enabled_monitors to use list_head as iterator
      rv: Make rtapp/pagefault monitor depends on CONFIG_MMU

 kernel/trace/rv/monitors/pagefault/Kconfig |  1 +
 kernel/trace/rv/rv.c                       | 12 ++++++------
 2 files changed, 7 insertions(+), 6 deletions(-)

Cc: Nam Cao <namcao@linutronix.de>


