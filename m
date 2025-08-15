Return-Path: <linux-kernel+bounces-770635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3376AB27D64
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB376AE1112
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF672FAC13;
	Fri, 15 Aug 2025 09:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n7plDYko";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PvGY8mT3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCA22F83B3;
	Fri, 15 Aug 2025 09:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755250747; cv=none; b=rKWWdB6berlsg+LFPdWvCXvaG02JRNiBe30ss2Jr1sUDu8YwkLPSz8klsDxlCWjvlqniYLRTJe2n27COwCBmRGjEXyHl1ykkxSwMteLGxllyR78U9acxy206DsOQE5hOupChTzJ4KIhpw5Xdix2p4ri87KTF29bMZwg0qj7HP6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755250747; c=relaxed/simple;
	bh=IxSvs6onbZTTIVQcPYipvwC4aDZYKbZLGaV99iA4Rl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ao6tzs3StckWnq5GmfIp78paOjVY+Rwv1AnUAlpp2ORPzGtVxemM8tOgdsiBzFMdaXdI7i5cBg47XhproP9hqbNKOyhXanGnjcD+s+tEwFxHchlLYjPx9W6MDStUlVQB+/+AwDTE0/Jj1LYfWA+gpH/k9A38AkXUnkKOT+qy8HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n7plDYko; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PvGY8mT3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755250743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IxSvs6onbZTTIVQcPYipvwC4aDZYKbZLGaV99iA4Rl8=;
	b=n7plDYkogdWtf1vcURPkt84AGjZ0RUs3xX30Tb7+GskBAhh0SgKEwQs6d+BJoZH52iK0Gl
	Y8jzx54icjeLZh85hVzS8lYuK5dHrZp/Nh6zTszkhOfnk9d19ctw2CW9u50RrXyMCNKROG
	5QpQpbnt97lAoJV1Dcknxp3PIGnIHgr3hFT+nhi5wlYFcgwxyviccqOJMhPcA765Zmb3dP
	hEExVO68FC9fEyI7VneY181QYhJy5lxzVazTasUnGE8tGhf1csYlEithUHw3+AWGXY68EB
	/P/QFQuWTBe4C0WxrQndlq6Pc1qVFSZIJTpmj90Q7ORF/n04ruAeCVF8Ty2EtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755250743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IxSvs6onbZTTIVQcPYipvwC4aDZYKbZLGaV99iA4Rl8=;
	b=PvGY8mT3E05V8vCApcWw5TuldDoKlBTYUMUGFLvhnMnEw6Szo1K+QC52IQpV3TtMEy2Ma/
	oLtCxB8Q96ji0+Bw==
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	John Ogness <john.ogness@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v2 1/3] Documentation: seqlock: Add a SPDX license identifier
Date: Fri, 15 Aug 2025 11:38:55 +0200
Message-ID: <20250815093858.930751-2-bigeasy@linutronix.de>
In-Reply-To: <20250815093858.930751-1-bigeasy@linutronix.de>
References: <20250815093858.930751-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a SPDX identifier. The majority of the document has been written by
Ahmed S. Darwish.

Cc: Ahmed S. Darwish <darwi@linutronix.de>
Acked-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 Documentation/locking/seqlock.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/locking/seqlock.rst b/Documentation/locking/seql=
ock.rst
index ec6411d02ac8f..3fb7ea3ab22a6 100644
--- a/Documentation/locking/seqlock.rst
+++ b/Documentation/locking/seqlock.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 Sequence counters and sequential locks
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--=20
2.50.1


