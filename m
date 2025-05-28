Return-Path: <linux-kernel+bounces-665427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFC0AC6912
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 14:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE4357A4A97
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 12:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359BE284B50;
	Wed, 28 May 2025 12:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d01FmOdW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E902857C6
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 12:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748434709; cv=none; b=DWZUZR7t0GJspiaxS5tFCU17sZTdU/UQmdLQH9wONqob/FTqEitp+pIu3HbiFm7rcHIQZNNNHthFWFNb1fF5H+U0VjvTeToOYpGeVZtlC2K9D6opUzPpqQLSGoqBGuHEObD2y29a67jLOFXnA3/E18FE3b5hpuMttUJOdHIvZoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748434709; c=relaxed/simple;
	bh=LA+kkxIPYmiR7oonheV94jgpXwqI/VWQON0Mo3qHank=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=MY3HCu2DOfqCGvb1qyKPOFgiRp6+baMcC4egoLSOE/dXJt6wDg/XznLrtcABqImOj3kOS3q7syLXy4Ui9dZkbyk7phQFtZEj7nt3EEtoznXQiLrLXjA+k1lYtmyvMsh41HU8TgNspebbegQUqsC1EPRkmn01eIgCdcMgfPgVb6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d01FmOdW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748434706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e3anGqMiFxhRjcJUcS/g6XPJaPxiEJieaKDIyxVkHoo=;
	b=d01FmOdWd5orlftLrIwoehrcY5tAdv6NXW1VbRnK/IuLLvAPbBvUEem3aQHcYm3CR3jmVm
	Xm7/4ddrM0IN680JCWLf45KafHoMBZntBYJYbnothCpqUXQGKnFiBhLN1NczYimKTHXwzP
	/M6j0verr94Lc5eLNvOliKl5oWizcfg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-3eGQ-0HqOtuakLtdbVugFw-1; Wed,
 28 May 2025 08:18:23 -0400
X-MC-Unique: 3eGQ-0HqOtuakLtdbVugFw-1
X-Mimecast-MFC-AGG-ID: 3eGQ-0HqOtuakLtdbVugFw_1748434702
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9332118001CA;
	Wed, 28 May 2025 12:18:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 87DF23000714;
	Wed, 28 May 2025 12:18:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
cc: dhowells@redhat.com, Herbert Xu <herbert@gondor.apana.org.au>,
    Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
    linux-security-module@vger.kernel.org, linux-crypto@vger.kernel.org,
    linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KEYS: Invert FINAL_PUT bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <301013.1748434697.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 May 2025 13:18:17 +0100
Message-ID: <301015.1748434697@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Linus,

Could you apply this, please?  There shouldn't be any functional change,
rather it's a switch to using combined bit-barrier ops and lesser barriers=
.
A better way to do this might be to provide set_bit_release(), but the end
result would be much the same.

Thanks,
David
---
From: Herbert Xu <herbert@gondor.apana.org.au>

KEYS: Invert FINAL_PUT bit

Invert the FINAL_PUT bit so that test_bit_acquire and clear_bit_unlock
can be used instead of smp_mb.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
cc: keyrings@vger.kernel.org
cc: linux-security-module@vger.kernel.org
cc: linux-crypto@vger.kernel.org
cc: linux-integrity@vger.kernel.org
---
 include/linux/key.h |    2 +-
 security/keys/gc.c  |    4 ++--
 security/keys/key.c |    5 +++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index ba05de8579ec..81b8f05c6898 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -236,7 +236,7 @@ struct key {
 #define KEY_FLAG_ROOT_CAN_INVAL	7	/* set if key can be invalidated by roo=
t without permission */
 #define KEY_FLAG_KEEP		8	/* set if key should not be removed */
 #define KEY_FLAG_UID_KEYRING	9	/* set if key is a user or user session ke=
yring */
-#define KEY_FLAG_FINAL_PUT	10	/* set if final put has happened on key */
+#define KEY_FLAG_USER_ALIVE	10	/* set if final put has not happened on ke=
y yet */
 =

 	/* the key type and key description string
 	 * - the desc is used to match a key against search criteria
diff --git a/security/keys/gc.c b/security/keys/gc.c
index f27223ea4578..748e83818a76 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -218,8 +218,8 @@ static void key_garbage_collector(struct work_struct *=
work)
 		key =3D rb_entry(cursor, struct key, serial_node);
 		cursor =3D rb_next(cursor);
 =

-		if (test_bit(KEY_FLAG_FINAL_PUT, &key->flags)) {
-			smp_mb(); /* Clobber key->user after FINAL_PUT seen. */
+		if (!test_bit_acquire(KEY_FLAG_USER_ALIVE, &key->flags)) {
+			/* Clobber key->user after final put seen. */
 			goto found_unreferenced_key;
 		}
 =

diff --git a/security/keys/key.c b/security/keys/key.c
index 7198cd2ac3a3..3bbdde778631 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -298,6 +298,7 @@ struct key *key_alloc(struct key_type *type, const cha=
r *desc,
 	key->restrict_link =3D restrict_link;
 	key->last_used_at =3D ktime_get_real_seconds();
 =

+	key->flags |=3D 1 << KEY_FLAG_USER_ALIVE;
 	if (!(flags & KEY_ALLOC_NOT_IN_QUOTA))
 		key->flags |=3D 1 << KEY_FLAG_IN_QUOTA;
 	if (flags & KEY_ALLOC_BUILT_IN)
@@ -658,8 +659,8 @@ void key_put(struct key *key)
 				key->user->qnbytes -=3D key->quotalen;
 				spin_unlock_irqrestore(&key->user->lock, flags);
 			}
-			smp_mb(); /* key->user before FINAL_PUT set. */
-			set_bit(KEY_FLAG_FINAL_PUT, &key->flags);
+			/* Mark key as safe for GC after key->user done. */
+			clear_bit_unlock(KEY_FLAG_USER_ALIVE, &key->flags);
 			schedule_work(&key_gc_work);
 		}
 	}


