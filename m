Return-Path: <linux-kernel+bounces-578666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE567A734FB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 15:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF21B3AFF92
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 14:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F56218AA2;
	Thu, 27 Mar 2025 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="EL+IVNhs"
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D33218845
	for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743087020; cv=none; b=kclf8SxTddSrR5JXAtX5uV91ZydHkvoLcooYACx/LYFyavMGKnCts9ErxYxDdodEXn2LeoKbO5XQn7GGrJazmgdrsWuqzgUY+pxvUvgbZvKigJ33u18vFvkYVMY/2ZYsU0vX+ERjrTbbZWwY5BmwYTVABZHwRY86fXy8HYh/xkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743087020; c=relaxed/simple;
	bh=y+dNdt31+vy08/TWIUqkOmDZKgyr9J8hDr4RBIpTPYQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KIS032tytX4IOra8g4LRxA3VXbglmdkoUVvpmFbyon1gCpemBddB9QbbspkTFqqnEOPMep3R8bYXNpgh5oDrwVt83xlzJuYUvQwJCDoaXLCLCHlZiiCgVKGQ8WSe6yKTBrF5OX6cbR/+Vjiy1UWeXkgAcYqRA2vJQ7R0IJ27r7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=EL+IVNhs; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1743087010; x=1743346210;
	bh=PFXXGDMbpQFvQ/hQaIEg3jpMkWzB+T8hkAladjtD21o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=EL+IVNhsayOu8kVwMlfVd3nq5EwD2JIjBGfsyqtK6puSJja3BJzR5S/vpm4y5e8Pk
	 nmPqI4Ww0vr/fwnedV8w/ki1WyWfR+4iIaLYjSUH77ZIwhAiDLpUWUiTKAvpOx+DU9
	 X9O76P3S5U+yFvj98pkIJJvx/cYPusv5PrIQz/XuoBm3IrMyEV4aiHZol+VSfw9kpy
	 2aHAp6eJCxZ3dr2Os2zxayffQbGdW2XNbezZdEEZ/xqP5vdBl0BDstMyk4Ny3KhdNk
	 W4dtRC6iM3xRHHoEKJF0onAwGaUmADcnvv9U+YmT7JOHTMHz9Outruw8S00LMFlse1
	 WiEUxaf5TnUTQ==
Date: Thu, 27 Mar 2025 14:50:05 +0000
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
From: Roxana Nicolescu <nicolescu.roxana@protonmail.com>
Cc: mmpgouride@gmail.com, skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v2 1/2] bcachefs: replace strncpy() with memcpy_and_pad in journal_transaction_name
Message-ID: <20250327144956.1974622-2-nicolescu.roxana@protonmail.com>
In-Reply-To: <20250327144956.1974622-1-nicolescu.roxana@protonmail.com>
References: <20250327144956.1974622-1-nicolescu.roxana@protonmail.com>
Feedback-ID: 136600343:user:proton
X-Pm-Message-ID: f047c589a448da8fe068c37defd649133c6a5899
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Strncpy is now deprecated.
The buffer destination is not required to be NULL-terminated, but we also
want to zero out the rest of the buffer as it is already done in other
places.

Link: https://github.com/KSPP/linux/issues/90
Signed-off-by: Roxana Nicolescu <nicolescu.roxana@protonmail.com>
---
 fs/bcachefs/btree_trans_commit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/bcachefs/btree_trans_commit.c b/fs/bcachefs/btree_trans_com=
mit.c
index c4f524b2ca9a..794b70cc98d7 100644
--- a/fs/bcachefs/btree_trans_commit.c
+++ b/fs/bcachefs/btree_trans_commit.c
@@ -364,7 +364,8 @@ static noinline void journal_transaction_name(struct bt=
ree_trans *trans)
 =09struct jset_entry_log *l =3D
 =09=09container_of(entry, struct jset_entry_log, entry);
=20
-=09strncpy(l->d, trans->fn, JSET_ENTRY_LOG_U64s * sizeof(u64));
+=09memcpy_and_pad(l->d, JSET_ENTRY_LOG_U64s * sizeof(u64),
+=09=09       trans->fn, strlen(trans->fn), 0);
 }
=20
 static inline int btree_key_can_insert(struct btree_trans *trans,
--=20
2.34.1



