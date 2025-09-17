Return-Path: <linux-kernel+bounces-820269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E84B7D2EF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F0A04E0C55
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068D530BB8C;
	Wed, 17 Sep 2025 08:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ii0Zl474"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AE13016F6
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098683; cv=none; b=lHtAk94HkUtnWbZ8Pb5JwnZwBfGihrbLBxQNFKGUlN5hoOLKM0FBaG7Mw0o6K2IoZWSxiUWpDxJJDgt2WSt6HPnXOjWX/MVjGXVbgNa90pkOZGDLIWJ1eR2mybgtz+9Agm5hlgJ6vGF0lZmNw7XH9FhVx4NzSx7epKeDp2osOqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098683; c=relaxed/simple;
	bh=PiFxBCpuMdodZScO1SSMEYIZExFuzvOF8mO22B2C6c8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eSGY+D0HM0EZRjUNkk4Q2Sy1Uwk6cTLQjjC/glGmBX6E0y2wraffM0K/TUV0tS7NRV1jUzxqCzQTJ1xZzeHJgObcoK6BtbzvCK3MqOWeKI7qSG0eTaS3Xr2HOpY64szkEdIpTNZkGmxr7OryEiNiobWcBZQ4/PAWatu45XPn1VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ii0Zl474; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758098679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nGT7/wMZGjwaxFcND5f/WecVxHFIlONVRhdO12P5zHA=;
	b=Ii0Zl474F2n6+tXzGM89gpiFOB/0NpPZBTdlCwQcQTkvrLhsLhVuEHus58Pp3f6d15Z2ny
	LTBDrDjDnmCv8RcsF6xpikufF1l/Wcv+VpA3BUxc9ROfTEuKnyvKb4YQnZu4eHh3UONMSN
	VOnm78djUC4BG1E1/4PZp614xZoouXE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-NbyG_BIwNQq_sVXKiYykUw-1; Wed,
 17 Sep 2025 04:44:35 -0400
X-MC-Unique: NbyG_BIwNQq_sVXKiYykUw-1
X-Mimecast-MFC-AGG-ID: NbyG_BIwNQq_sVXKiYykUw_1758098674
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7270119560B5;
	Wed, 17 Sep 2025 08:44:33 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.170])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3E2C719560B8;
	Wed, 17 Sep 2025 08:44:29 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	Akhilesh Patil <akhilesh@ee.iitb.ac.in>,
	Nam Cao <namcao@linutronix.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Zhen Ni <zhen.ni@easystack.cn>
Subject: [GIT PULL] rv fixes for 6.17-rc7
Date: Wed, 17 Sep 2025 10:42:45 +0200
Message-ID: <20250917084244.47053-2-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Steve,

The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c:

  Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gmonaco/linux.git rv-6.17-rc7

for you to fetch changes up to 9b5096761c184b3923ae45c5e82da31005a765c7:

  rv: Fix missing mutex unlock in rv_register_monitor() (2025-09-15 08:36:35 +0200)

----------------------------------------------------------------
Simple fixes like:
- Fix build in some riscv flavours
- Fix wrong cast, obsolete after refactoring
- Fix missing unlock on failure
- Fix duplicate import

----------------------------------------------------------------
Akhilesh Patil (1):
      include/linux/rv.h: remove redundant include file

Nam Cao (1):
      rv: Fix wrong type cast in enabled_monitors_next()

Palmer Dabbelt (1):
      rv: Support systems with time64-only syscalls

Zhen Ni (1):
      rv: Fix missing mutex unlock in rv_register_monitor()

 include/linux/rv.h                     | 6 ++----
 kernel/trace/rv/monitors/sleep/sleep.c | 4 ++++
 kernel/trace/rv/rv.c                   | 4 ++--
 3 files changed, 8 insertions(+), 6 deletions(-)

Cc: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: Nam Cao <namcao@linutronix.de>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Zhen Ni <zhen.ni@easystack.cn>


