Return-Path: <linux-kernel+bounces-754981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C20B19F76
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 12:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 835DF16519E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 10:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D092288EE;
	Mon,  4 Aug 2025 10:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1YOH862l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R/iaxWir"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB4A2494F0
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 10:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754302060; cv=none; b=SB1wTIyZt9VECbx26bz8v0QjjYpNst+eLoKO6uRTOI+MAGvfT7ucFjfAKAvDNWHBpPS7QgKKvBv2r3jpb3567TRp/tCJ/jQxEm0YVvta49vr7KY8zh9pBOTwAnHAgOkx8WC/kuxxtwqLvn5QSr5XGpRyLvHu8mexQxa7zl9Gc7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754302060; c=relaxed/simple;
	bh=vSgKx6mry72PGKxDCvJuvSIjcR2nBuNj/0WbY3ni2uk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=POexo6txqL4BZr88KOXwvxJY8Sfug6JhbQ6Mqgqf0LROd5WMqBwet0QDzvOJoRDiuT5Zkcc4JUzETu9L8ubGevILk54ErFj0/Ie4ktDsp9dABmtJt5Bs2asMWCV3u9VQctr9rWwxClpwxA0dSTf6iNqZJvMhpdmOjuDThfq+DIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1YOH862l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R/iaxWir; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754302056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZTnQxU/+fvPQHh07xXw/q8Ljo18bwpIP+5p0y/uzJuQ=;
	b=1YOH862lXgJ6Yzd9uzj36Y2Y0n4NQKFOjKq5h9CQIYcl/wYh/PpUr04G3RwN6C6JujYU3S
	yf8Xp3T++slKeXJCIZJb1PC21DQk2yc6TlNfu9c5T9nColNoo4WfaZD/Ekou31yXxsPteG
	fpuvp3SAiJyNYvyo+6IT289R6udGLubncd4Jean0DWqQZ3SNH5yPj2BGo1E3HKJ98LIOpm
	eSgN2qgMUrgb8/kdh+Mi3MJ/K7FyWHz7mpdOvQY4KYuJUHfvUQ/A6qalkjOVcrRwXmN4l8
	NuxI2s6kAZ/13tZ7kHBlJFGLWp/+c9QsAQLhZcOegmZ9RGMtNlm/6czALLFcSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754302056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZTnQxU/+fvPQHh07xXw/q8Ljo18bwpIP+5p0y/uzJuQ=;
	b=R/iaxWirDxFx2wC6QCKPGIhK9e7WNMAb+vv/5GOz0izYZcCnxH2kgdaDG94iHyZBNfe9vV
	n2ZUTX8XceR4dLAQ==
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Gautam Menghani <gautam@linux.ibm.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 0/2] powerpc: Fix integer underflow & leak
Date: Mon,  4 Aug 2025 12:07:26 +0200
Message-Id: <cover.1754300646.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This series fixes integer overflow & leak problem. I noticed this problem
when Gautam reported a kernel bug with another patch series of mine:
https://lore.kernel.org/linuxppc-dev/aH9Na8ZqrI0jPhtl@li-c6426e4c-27cf-11b2=
-a85c-95d65bc0de0e.ibm.com/

The root cause of that report is a bug in that series. However, that bug
triggered another existing bug, causing the reported end results.

Nam Cao (2):
  powerpc/pseries/msi: Fix potential underflow and leak issue
  powerpc/powernv/pci: Fix underflow and leak issue

 arch/powerpc/platforms/powernv/pci-ioda.c | 2 +-
 arch/powerpc/platforms/pseries/msi.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--=20
2.39.5


