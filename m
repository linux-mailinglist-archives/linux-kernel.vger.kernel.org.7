Return-Path: <linux-kernel+bounces-838921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9B0BB06DA
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7011919467F0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CB42EC561;
	Wed,  1 Oct 2025 13:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZBmwdyVA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91432EC562
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759324159; cv=none; b=snlm/B9CnC5m3BkIScVWlPVFytlaSOO5Ft5pXkpcXbKH0cwuJoWnJaj1ZbQt09dqZH+eNlVunjlW178ymhFIdm1dgaWIp3w4onDZsKPgYEX6FbGYYbebKmweKHaqR3EodIRGwYkyyhnfoewo+QV+p5ENVOWc14t4wynZS27cdJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759324159; c=relaxed/simple;
	bh=7JVOZI3VmA/bJGurezKwfa6xLrTuVpU7TBiH1BVdZ8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=obCmK9gEEsSiJKYnPbSQiT47KsIuA9OyxGN6G5nypWVQAomtjC4J0JfLp6LBYIM+gIgCurW6Fl2ppUU5X6IAcpvWk3oV9tCwZDWcS5ZVWXhzm1IiBrNH1948ZtWnLMpQvr8OQLA4wUQuGT5dkSB2Dz+SwdGi5PD//27pXm3nAuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZBmwdyVA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759324156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tko8biKCUbQX+Dpp0DpdSt4WwcDqXjayhPPlC8spm3I=;
	b=ZBmwdyVAlfPJRa+2/96l5m6f19Io+3rcaOeaJR6Svq62CwViXsDMeHCCspyScnPFQ1lZ77
	/uaXc6L70zI4ELxTbUYje1osXxU1f3c93Fhi3NgbIbhL7c/a9UspudU376kkdykaA1mH0q
	f85l5gv5Qec1EkFwpfy6Dii6bL8Zctw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-eWjcrMGEMiipWbPO1VIvrQ-1; Wed,
 01 Oct 2025 09:09:13 -0400
X-MC-Unique: eWjcrMGEMiipWbPO1VIvrQ-1
X-Mimecast-MFC-AGG-ID: eWjcrMGEMiipWbPO1VIvrQ_1759324152
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21ED0180028D;
	Wed,  1 Oct 2025 13:09:12 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.24])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F313E195608E;
	Wed,  1 Oct 2025 13:09:09 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Stephan Mueller <smueller@chronox.de>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/5] lib/crypto: Move the SHA3 Iota transform into the single round function
Date: Wed,  1 Oct 2025 14:08:43 +0100
Message-ID: <20251001130846.2284946-5-dhowells@redhat.com>
In-Reply-To: <20251001130846.2284946-1-dhowells@redhat.com>
References: <20251001130846.2284946-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

In crypto/sha3_generic.c, the keccakf() function calls keccakf_round() to
do most of the transforms, but not the Iota transform - presumably because
that is dependent on round number, whereas the Theta, Rho, Pi and Chi
transforms are not.

Note that the keccakf_round() function needs to be explicitly non-inlined
on certain architectures as gcc's produced output will (or used to) use
over 1KiB of stack space if inlined.

Now, this code was copied more or less verbatim into lib/crypto/sha3.c, so
that has the same aesthetic issue.  Fix this there by passing the round
number into sha3_keccakf_one_round_generic() and doing the Iota transform
there.

crypto/sha3_generic.c is left untouched as that will be converted to use
lib/crypto/sha3.c at some point.

Suggested-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric Biggers <ebiggers@kernel.org>
cc: Jason A. Donenfeld <Jason@zx2c4.com>
cc: Ard Biesheuvel <ardb@kernel.org>
cc: Herbert Xu <herbert@gondor.apana.org.au>
cc: Stephan Mueller <smueller@chronox.de>
cc: linux-crypto@vger.kernel.org
---
 lib/crypto/sha3.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/lib/crypto/sha3.c b/lib/crypto/sha3.c
index 5f847a5eecdc..2c292b0b3db3 100644
--- a/lib/crypto/sha3.c
+++ b/lib/crypto/sha3.c
@@ -48,7 +48,8 @@ static const u64 sha3_keccakf_rndc[24] = {
 /*
  * Perform a single round of Keccak mixing.
  */
-static SHA3_INLINE void sha3_keccakf_one_round_generic(struct sha3_state *state)
+static SHA3_INLINE void sha3_keccakf_one_round_generic(struct sha3_state *state,
+						       int round)
 {
 	u64 *st = state->st;
 	u64 t[5], tt, bc[5];
@@ -150,15 +151,15 @@ static SHA3_INLINE void sha3_keccakf_one_round_generic(struct sha3_state *state)
 	st[22] ^= bc[ 2];
 	st[23] ^= bc[ 3];
 	st[24] ^= bc[ 4];
+
+	/* Iota */
+	state->st[0] ^= sha3_keccakf_rndc[round];
 }
 
 static void sha3_keccakf_rounds_generic(struct sha3_state *state)
 {
-	for (int round = 0; round < SHA3_KECCAK_ROUNDS; round++) {
-		sha3_keccakf_one_round_generic(state);
-		/* Iota */
-		state->st[0] ^= sha3_keccakf_rndc[round];
-	}
+	for (int round = 0; round < SHA3_KECCAK_ROUNDS; round++)
+		sha3_keccakf_one_round_generic(state, round);
 }
 
 /*


