Return-Path: <linux-kernel+bounces-816267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A94B571B3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 623DD17C0DF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 07:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FED2D7DCE;
	Mon, 15 Sep 2025 07:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WY+cQzx7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFC62D6E65
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757921978; cv=none; b=QcoElYW0HoiX4jNTY6DxE3AVLn/n8PBQwbKyBdmhtUUeel5x36skQ/k2c2cTljb7gVC+xRzmQ0Dw7hB2IctMLr1Oz5npwEHtkNOrzD22ifxv4G01wPicLvH/uqil/zce254bHnxDCYpKHjnSftvG8AE+HappdmH8qPybhVBZm78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757921978; c=relaxed/simple;
	bh=119j7dFD5eNZT8DRTdfIdHAunKmZc0CaSGjdg3caCpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rl4Nb4NGHKH1q6sj/wp2bWxny7xsHXVJVwQirVbEgNwmaTn0si1xqLm21d7hjbW4PtNEixRQ/H814PplkJbsSlABWvHmtWa193WKlsQC/kC3M8FULCGhWQBZBubCGVSyuZ7WjcXeYHqHfsALGl2MicE7QuInZ4Xid46RujWIxeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WY+cQzx7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757921975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0xX6tI6u5zeOVsZqj6Xc96LcqkQ2tcTen7S/ZQeEwms=;
	b=WY+cQzx7qYBFrANOXvd5g1wrYGRAgMHu6aXqxksIyzhIo4Zw3eaW83Mth3XNtSNdheCMk8
	s8ziDng3wAFPdh0O8qsU6qoEIezarE5msVtMdpZ1xmiqvv/ZjTyhqGO6qS4xnlAP1U6hax
	rR3EFUamYC/hB6TcDnEhSNHVMgbGYiw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-hN0GAeRxOuGjBMW0I3ex3Q-1; Mon,
 15 Sep 2025 03:39:33 -0400
X-MC-Unique: hN0GAeRxOuGjBMW0I3ex3Q-1
X-Mimecast-MFC-AGG-ID: hN0GAeRxOuGjBMW0I3ex3Q_1757921972
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7076A1955E88;
	Mon, 15 Sep 2025 07:39:31 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8DDC6180035E;
	Mon, 15 Sep 2025 07:39:28 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	Akhilesh Patil <akhilesh@ee.iitb.ac.in>,
	Nam Cao <namcao@linutronix.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Zhen Ni <zhen.ni@easystack.cn>
Subject: [GIT PULL] rv fixes for 6.17-rc7
Date: Mon, 15 Sep 2025 09:35:30 +0200
Message-ID: <20250915073529.20364-2-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Steve,

The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c:

  Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)

are available in the Git repository at:

  git@gitlab.com:glemco/linux tags/rv-6.17-rc7

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


