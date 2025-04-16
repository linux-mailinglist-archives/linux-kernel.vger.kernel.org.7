Return-Path: <linux-kernel+bounces-607646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D176A90906
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 18:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48AF3BA1F2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 16:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8B7219A75;
	Wed, 16 Apr 2025 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1PSDD/U8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fjdaCeM0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C8921767B
	for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744820973; cv=none; b=BRhEz4wzzJbd3vX1/5UjBO0pOzMg6qUXR1woHkPewes6oYTSd0yRf56mAigZ2zx8zgNMj0lJaMT51Ph59nV8jhY6LKr1H/BvUZtQXQ8mgIRH30xxmH+DNS0PW7r9Lz+U34Tq2zuljI4Ap0SYrlA8vwkRKxAuVQs6Vf3sSa1+B18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744820973; c=relaxed/simple;
	bh=LaZS6UPiImzSyxqxJCcwrXkWJyg0hTcn7pnVQilLcwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZYfwEq6SNV1BifVeWKrty77mUpIkRUKfADQdyFG/DGT72TS9QJ7LfhgQ6I6Kpqu/ohN4ANrXCpIZ73ZSa8xLHW/GN7c7rYz98sQ46TkR/hxQO5GszhlCl8IuZ/sLgPS/cIMycLIZJJ1clC/csgGqkCVgtxPjhkrZu+9DdsejyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1PSDD/U8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fjdaCeM0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744820968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ADpzXL+em4lIAaBMKlTSOE1lA/L53fXWSsZH7Iu6lc=;
	b=1PSDD/U8BBFkEdLcLEG516WDWYKDp3x9nLx/cmlw7fl+AqSkldQ6/Go7cdMRkYvDWsyhaQ
	iwRErPoPx6uPPLROZmXXQV3SHKQ9alzI5UaMt80HF2LMey8RlrzoJhVaOMXWxAClNVb1l8
	9Zts+hPC/lg2Zzp5EOTjYmsLUWj0Q7UVuE9HMGJRLHILhwiM1Efu7LukSyLZ3XEvE17OkX
	pWD/SGILcnuApyyaR9sg5WIIoZEfExdN5q6uPnHqy7qFLrgTJx77Q8S+NN8JIazY0wjjwm
	POasnCjd7X5rk1CcHn7D58U3HpHdHiQyzzCedY7B/A/NQIGamfA5sNf7XoQh5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744820968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ADpzXL+em4lIAaBMKlTSOE1lA/L53fXWSsZH7Iu6lc=;
	b=fjdaCeM0yYeFzKy9r/kCrpHbaVWDmOVbG5S+jB0TVipIj3lMSOAlCVtzmJ9s3V20pTQggu
	3r4VNnBFJEAxMRAg==
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v12 07/21] futex: Create private_hash() get/put class
Date: Wed, 16 Apr 2025 18:29:07 +0200
Message-ID: <20250416162921.513656-8-bigeasy@linutronix.de>
In-Reply-To: <20250416162921.513656-1-bigeasy@linutronix.de>
References: <20250416162921.513656-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Peter Zijlstra <peterz@infradead.org>

This gets us:

  fph =3D futex_private_hash(key) /* gets fph and inc users */
  futex_private_hash_get(fph)   /* inc users */
  futex_private_hash_put(fph)   /* dec users */

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/futex/core.c  | 12 ++++++++++++
 kernel/futex/futex.h |  8 ++++++++
 2 files changed, 20 insertions(+)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 56a5653e450cb..6a1d6b14277f4 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -107,6 +107,18 @@ late_initcall(fail_futex_debugfs);
=20
 #endif /* CONFIG_FAIL_FUTEX */
=20
+struct futex_private_hash *futex_private_hash(void)
+{
+	return NULL;
+}
+
+bool futex_private_hash_get(struct futex_private_hash *fph)
+{
+	return false;
+}
+
+void futex_private_hash_put(struct futex_private_hash *fph) { }
+
 /**
  * futex_hash - Return the hash bucket in the global hash
  * @key:	Pointer to the futex key for which the hash is calculated
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 77d9b3509f75c..bc76e366f9a77 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -206,10 +206,18 @@ extern struct futex_hash_bucket *futex_hash(union fut=
ex_key *key);
 extern void futex_hash_get(struct futex_hash_bucket *hb);
 extern void futex_hash_put(struct futex_hash_bucket *hb);
=20
+extern struct futex_private_hash *futex_private_hash(void);
+extern bool futex_private_hash_get(struct futex_private_hash *fph);
+extern void futex_private_hash_put(struct futex_private_hash *fph);
+
 DEFINE_CLASS(hb, struct futex_hash_bucket *,
 	     if (_T) futex_hash_put(_T),
 	     futex_hash(key), union futex_key *key);
=20
+DEFINE_CLASS(private_hash, struct futex_private_hash *,
+	     if (_T) futex_private_hash_put(_T),
+	     futex_private_hash(), void);
+
 /**
  * futex_match - Check whether two futex keys are equal
  * @key1:	Pointer to key1
--=20
2.49.0


