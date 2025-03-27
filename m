Return-Path: <linux-kernel+bounces-578667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 336BAA734FF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 15:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51F92189026A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 14:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED126218826;
	Thu, 27 Mar 2025 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="TOWGc3eW"
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AE7217F31
	for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 14:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743087104; cv=none; b=LHjmYkhhm40GFhihZaOHVEl4pO+nS4CapRpYTH2MV3gyl3zohdmUTHF+GodDFswx+JkGy2xQu7moGNSBdosayAhEql3jINMmju/I5MGl2tHSTBggcy1hl/rRy2thxC7doQn6OdvEeM6qBeLAJOhSlF+73dUl78EAGBwdBPnMkZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743087104; c=relaxed/simple;
	bh=jFY6/9yxtTShwRhi8aGD1r33YUrFs2oJ27jagdR8Dpk=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uy3PFg10QAsQrDcrf2FCp9OcP1DmC2H0/eoYKOJjTh9Lr+Bkfo5zFdnjULL+cBmpCucHsfLj9WVfgKBngcCkrHjhVAWBtz8X3OY4SW3sZ402hNmXdVlM/1L1tJA5vriBTHnswN8ojLb+yhp8TooIqjFB1clI2YZcXfGxhSh6JQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=TOWGc3eW; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1743087100; x=1743346300;
	bh=5aQI5GkKTceApRtAP68NzR/aWmFWlKkk+99MRVZEmXA=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=TOWGc3eWuabcLp6rBjuWHYHrsDi+qHTetGi59vh6rH02QkScnwLzqmYAFM7InHGwO
	 8RPXfpLvRwZlL9oTll0txC/GAb4dniORM4ustf7fYw4QhdvKCxoZpbPJJYWhV3bxQ0
	 cB4KT9aG7EauVVapiGhkSLYbh397y7k4x+RpPZAbFLhPQVOwERIJiAji6g41kvAarF
	 f1ZvJCzATPo4cqj7CxjQ8h58ybGz0FvS95UGG7keswbEo+hLukvUZw7VQkRlYY48ci
	 UZW20BDkkbK6r/FYT7dJS0aUhz//mSJahyFj22TXLrWKtH/OhJpTsD0P1OSj3xEH1X
	 +GoT6Pri6jc7Q==
Date: Thu, 27 Mar 2025 14:51:36 +0000
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
From: Roxana Nicolescu <nicolescu.roxana@protonmail.com>
Subject: Re: [[PATCH v2] 0/2] Use memcpy_and_pad for jset_entry_log->d init
Message-ID: <B_oQnAzbHuX7dGVA98YTNgereEetK1r5pIJGI00DhsxRK4fD7WEuyZB9U2cuquiKlL3l5xeS5tU-srIwazCDGk55cE13AubE7MTGrtqobSk=@protonmail.com>
In-Reply-To: <20250327125235.1958273-1-nicolescu.roxana@protonmail.com>
References: <20250327125235.1958273-1-nicolescu.roxana@protonmail.com>
Feedback-ID: 136600343:user:proton
X-Pm-Message-ID: 53e0bb9476d3a97a9496a511465e1e722f443760
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, March 27th, 2025 at 1:52 PM, Roxana Nicolescu <nicolescu.roxan=
a@protonmail.com> wrote:

> This replaces the depracated usage of strncpy with memcpy_and_pad when
> used for initializing the d buffer of the struct jset_entry_log.
>=20
> The other 2 usage of memcpy were also replaced by memcpy_and_pad.
>=20
> Changes since v1:
> - since the dest buffer is not required to be NULL-terminated,
> memcpy_and_pad is used instead of strscpy. This adds zeros at the end
> of the buffer if there's extra room.
> - the same mechanism was done before in both __bch2_fs_log_msg() and
> bch2_trans_log_msg by zero-ing out the src buffer. The second patch
> replaces that logic with memcpy_and_pad to provide uniformity.
>=20
> Roxana Nicolescu (2):
> bcachefs: replace strncpy() with memcpy_and_pad in
> journal_transaction_name
> bcachefs: replace memcpy with memcpy_and_pad for jset_entry_log->d
>=20
> buff
>=20
> fs/bcachefs/btree_trans_commit.c | 3 ++-
> fs/bcachefs/btree_update.c | 8 +++-----
> 2 files changed, 5 insertions(+), 6 deletions(-)
>=20
> --
> 2.34.1

Please ignore this patchset, the patch title is wrong. It has extra bracket=
s. 

