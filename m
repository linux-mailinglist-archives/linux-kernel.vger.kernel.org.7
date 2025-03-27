Return-Path: <linux-kernel+bounces-578481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A444A732A2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 13:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCAA33BB2BA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 12:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC13521504F;
	Thu, 27 Mar 2025 12:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="v9mX/F6x"
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CA220F08B
	for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 12:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743079974; cv=none; b=BbPVrkWgj2tKWv9Bjb+pizc8lIZHH9ZytN2orPiGgckibuuxJQPm6wYwcvvZAXIUdbz92qOYNLF2+mlq7kXt3Y8F2cLwY8zGQv9T5+m5auEUWxzcYUmntkdKlsxELqf8hb8n2J0qwb2gGfeEiszDtUgASuYHkKX0gliTxyRQKpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743079974; c=relaxed/simple;
	bh=ixowdw3/tBH1MKs5lErEbKIY7YjR630dlJ2HH1jf3qA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qY+VXctynEt3KcNX45KT2jY2QAKsywwi2DX81m1FYgklph87eNHuTTDsxy+QmZoqyv6fcU18ZqH/ugTEYoDl3fH3O0KXokDFfEoKgTOHXnrijsVGAmXZbOtG23Aye9+Adob2Wi6z+ByNS2qGYp/EUzoZNtHgi2DVt47cdv4lG7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=v9mX/F6x; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1743079969; x=1743339169;
	bh=ixowdw3/tBH1MKs5lErEbKIY7YjR630dlJ2HH1jf3qA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=v9mX/F6xYxtwvwy6Dk/6Yy2S29RqTz5k+aoyNq/6SPWVTsZNrF/2e9uc34U52zzQ1
	 HxbDQNsYwaXZ/N/NlqUcqL1uJIZQgVGzsfegO67Ev/jBNpcMxOR6FKY6/gD8dHRobE
	 TJxE8TS76RTfNmWlU7qFNbr5BgKIo2KxHB4ElFE2xnX30ruY6IwcUzEIC2GHvB9IXv
	 4o+attaeVoWhjsVGVDIv9AVLqLBS7SibDLqf2h/5W2vetEQjp9Ddhv/Gj2QvuVzDie
	 ncftsROiPj58EWojXt2dqH48nVeu6sWANkgAtd2DW00Jn6xerbS7EFpZAififDSW8z
	 +o6Fuz59/Bfvg==
Date: Thu, 27 Mar 2025 12:52:46 +0000
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
From: Roxana Nicolescu <nicolescu.roxana@protonmail.com>
Cc: mmpgouride@gmail.com, skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: [[PATCH v2] 2/2] bcachefs: replace memcpy with memcpy_and_pad for jset_entry_log->d buff
Message-ID: <20250327125235.1958273-3-nicolescu.roxana@protonmail.com>
In-Reply-To: <20250327125235.1958273-1-nicolescu.roxana@protonmail.com>
References: <20250327125235.1958273-1-nicolescu.roxana@protonmail.com>
Feedback-ID: 136600343:user:proton
X-Pm-Message-ID: 530c8e70d6666a06b73edeef40bcbe63b7516258
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This was achieved before by zero-ing out the source buffer and then
copying the bytes into the destination buffer. This can also be done with
memcpy_and_pad which will zero out only the destination buffer if its
size is bigger than the size of the source buffer. This is already used in
the same way in journal_transaction_name().

Moreover, zero-ing the source buffer was done twice, first in
__bch2_fs_log_msg() and then in bch2_trans_log_msg(). And this method
may also require allocating some extra memory for the source buffer.

In conclusion, using memcpy_and_pad is better even tough the result is
the same because it brings uniformity with what's already used in
journal_transaction_name, it avoids code duplication and reallocating
extra memory.

Signed-off-by: Roxana Nicolescu <nicolescu.roxana@protonmail.com>
---
 fs/bcachefs/btree_update.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/bcachefs/btree_update.c b/fs/bcachefs/btree_update.c
index 13d794f201a5..97495b79ca93 100644
--- a/fs/bcachefs/btree_update.c
+++ b/fs/bcachefs/btree_update.c
@@ -826,7 +826,6 @@ int bch2_btree_bit_mod_buffered(struct btree_trans *tra=
ns, enum btree_id btree,
 int bch2_trans_log_msg(struct btree_trans *trans, struct printbuf *buf)
 {
 =09unsigned u64s =3D DIV_ROUND_UP(buf->pos, sizeof(u64));
-=09prt_chars(buf, '\0', u64s * sizeof(u64) - buf->pos);
=20
 =09int ret =3D buf->allocation_failure ? -BCH_ERR_ENOMEM_trans_log_msg : 0=
;
 =09if (ret)
@@ -839,7 +838,7 @@ int bch2_trans_log_msg(struct btree_trans *trans, struc=
t printbuf *buf)
=20
 =09struct jset_entry_log *l =3D container_of(e, struct jset_entry_log, ent=
ry);
 =09journal_entry_init(e, BCH_JSET_ENTRY_log, 0, 1, u64s);
-=09memcpy(l->d, buf->buf, buf->pos);
+=09memcpy_and_pad(l->d, u64s * sizeof(u64), buf->buf, buf->pos, 0);
 =09return 0;
 }
=20
@@ -852,7 +851,6 @@ __bch2_fs_log_msg(struct bch_fs *c, unsigned commit_fla=
gs, const char *fmt,
 =09prt_vprintf(&buf, fmt, args);
=20
 =09unsigned u64s =3D DIV_ROUND_UP(buf.pos, sizeof(u64));
-=09prt_chars(&buf, '\0', u64s * sizeof(u64) - buf.pos);
=20
 =09int ret =3D buf.allocation_failure ? -BCH_ERR_ENOMEM_trans_log_msg : 0;
 =09if (ret)
@@ -865,7 +863,7 @@ __bch2_fs_log_msg(struct bch_fs *c, unsigned commit_fla=
gs, const char *fmt,
=20
 =09=09struct jset_entry_log *l =3D (void *) &darray_top(c->journal.early_j=
ournal_entries);
 =09=09journal_entry_init(&l->entry, BCH_JSET_ENTRY_log, 0, 1, u64s);
-=09=09memcpy(l->d, buf.buf, buf.pos);
+=09=09memcpy_and_pad(l->d, u64s * sizeof(u64), buf.buf, buf.pos, 0);
 =09=09c->journal.early_journal_entries.nr +=3D jset_u64s(u64s);
 =09} else {
 =09=09ret =3D bch2_trans_commit_do(c, NULL, NULL, commit_flags,
--=20
2.34.1



