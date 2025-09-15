Return-Path: <linux-kernel+bounces-816249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B65B57189
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6CE73AC567
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 07:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB41320E6F3;
	Mon, 15 Sep 2025 07:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XecgrMMo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619CA2D660C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757921511; cv=none; b=rUtIdv/sDdq5IHhu+4RN0fUqYgAL9E/eUz5ZqIAw/Jc6PCLKXdHxivoXWQ283YaPCRIFjFB1UY407T4PyYmGbjglhBde7cMemPGDqW2uNbY8pX0WUEWi8e3FxSyIbxkMzUbZK64biVzE2rvRHo/w63WKdoAaaWnv/dVgd9MvDTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757921511; c=relaxed/simple;
	bh=9SfIeSFH0fRO85j0t4SakBbQ7qZ3+sz/PFrKVVw3jqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=toYxB7bO/u2I4fRIFbgM8tYp5bm0dgqxNDIfseA1OxMTlP0s7G2gfUfrIgEUqD6/vtZaiVsDWeb36jVIJ2xNFLSeuY+aLH1d7ab45ytyZanp3r7oW5ecgsbqDWYKs4tmJpU9xHkI64m9ciR0EArUzomyAwCDtnN/YWkzzbJyDYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XecgrMMo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757921508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UrKBcTtXZIUkpFbjfcRZFDKWDhiP3rIJyut5ap6keDw=;
	b=XecgrMMowVObQtctmUhPxkVX7sJs0/Oh3vgBsWGAmCiO0BYwNskFtqz9QFWOm90/CQDlHY
	ZgnMIN0en4JFqDA++cEtu3rwxy5AihFZLl4t1eB1Jo67bNm9OKSj/+blEuFjkuEGY5SrhI
	RJ/xa3ZWOi47aV8Qwf3f4c+ehzSfN7Q=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-GxCsv9lNN-K792UmUOkI8w-1; Mon,
 15 Sep 2025 03:31:46 -0400
X-MC-Unique: GxCsv9lNN-K792UmUOkI8w-1
X-Mimecast-MFC-AGG-ID: GxCsv9lNN-K792UmUOkI8w_1757921505
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF6CC19775DB
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:31:45 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CCA911800451
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:31:44 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: 
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] rv fixes for 6.17-rc7
Date: Mon, 15 Sep 2025 09:31:42 +0200
Message-ID: <20250915073142.19840-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

me,

The following changes since commit 9b5096761c184b3923ae45c5e82da31005a765c7:

  rv: Fix missing mutex unlock in rv_register_monitor() (2025-09-15 08:36:35 +0200)

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


