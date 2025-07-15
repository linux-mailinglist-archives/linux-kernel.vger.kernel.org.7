Return-Path: <linux-kernel+bounces-732086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70290B061CB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C88375A0405
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3111FECC3;
	Tue, 15 Jul 2025 14:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JHsK/jlE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UZUsBllC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422371D5ADE;
	Tue, 15 Jul 2025 14:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590497; cv=none; b=Lb9i6Z+AZWrTZH4n8kEIAyF2Kz1wuwxH4HZYBHZIVsuBgJE5+bQPejWWTJLoLOUOpB4vx5/Mm2hCyxKrsZjyq5jt4ZVsLaKv9ouQyCVlZ8Yt5rF5OUwOhimqP5AvHgGz8nEqjQtUNS/pNt/3IcQdDoD5tolSA0CDGSN6Ocmm764=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590497; c=relaxed/simple;
	bh=u3Ak9OzB3UU/dYH2vbh4tpuYzXyRph/EGgJAduPJPL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hyqt//PIo23iBbcBuMlUbzhGz+++ikQU5Ktt67s86oyccnHFAs+0VM8TVyTg1dJm6raCxuDw8E+mfB5yRF8VxIzYaFwpa2xrAa8ePfYYVpB+BJkM2qzr/gdOH9OjSjAP2U26OSPjqYYOeaaUb/RP5NIKBvI71obeWKF/H8h8mXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JHsK/jlE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UZUsBllC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752590492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u3Ak9OzB3UU/dYH2vbh4tpuYzXyRph/EGgJAduPJPL8=;
	b=JHsK/jlEWWwr7y6Ce8v5YhGYGCQf9vqMlKRecSi7oWuJ5VMArUEhI8dxozp7Io9EdFprCl
	YdrnU/KUCiU5faREwZT6POZdxvjMvxrP7/vVzueuxrtutILteRVHGc6MvI/zHn5LXAaJfz
	kc6rK3OUgIOKYotToJCJJwzcV2oYaBZC7hYsfhy+Vizz059habIDeNRJDG3veEMLzT98dz
	3MEaky/T+OUJ9l4HQzTUCCGE/vON7JZ/f0fX47taKsM7SraG3yNNsoKF0iovFkrpJzALt7
	gS4LZHow+0ozoreC9ZOE9EBpO5beBB3zFr+QM+D+Zj4NBC25bRfZoO5CKIGNeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752590492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u3Ak9OzB3UU/dYH2vbh4tpuYzXyRph/EGgJAduPJPL8=;
	b=UZUsBllCwfjRaxdrAQ0hjUCml9EXoGj40Z9aU46NYGRn9X6Jdryma5V16PIZ8Nms74dmfe
	HbA/UBllI4hgvmAg==
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
Subject: [PATCH 1/3] Documentation: seqlock: Add a reference label and license.
Date: Tue, 15 Jul 2025 16:41:25 +0200
Message-ID: <20250715144127.697787-2-bigeasy@linutronix.de>
In-Reply-To: <20250715144127.697787-1-bigeasy@linutronix.de>
References: <20250715144127.697787-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a reference label to the document so it can be crossed referenced
from another document in the tree.
While at it, add a SPDX identifier. The majority of the document has
been written Ahmed S. Darwish.

Cc: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 Documentation/locking/seqlock.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/locking/seqlock.rst b/Documentation/locking/seql=
ock.rst
index ec6411d02ac8f..4936b46dedc59 100644
--- a/Documentation/locking/seqlock.rst
+++ b/Documentation/locking/seqlock.rst
@@ -1,3 +1,7 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _kernel_hacking_seqlock:
+
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 Sequence counters and sequential locks
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--=20
2.50.0


