Return-Path: <linux-kernel+bounces-782520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CFAB32185
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B572EB22738
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65054308F3D;
	Fri, 22 Aug 2025 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MUzUaI8m"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C027286411
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 17:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755883807; cv=none; b=lHQCttpTd+3kEJiaQiXTBr5c9bQARCtZ2CZPlsKv76sBYiZ56J5gq3WGjj6mbz64F0wYhoEhVn5bdVcFRElYCRPXC5uM1NziIviN3IlKYrTJU79syq147ZIBRoHDQoNYUiGrwOSwQZXHw5tzZ8+A5NQri1mqA5LlnWfYTNb5xUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755883807; c=relaxed/simple;
	bh=dZXIUtMf3TDWiRiuLsGcHlQc9zxF8JnGlI2ARPPevpI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tfTh4qsRgPpJVMyQtlQM6MKSPvY/TtbnbKi0jn1eJw5qOmzMTU17p4OrhXJg531Bkr6yi2L0waXXJW7R/J24RHWKVOBlXAGuiSe+kSByhaLo+C2M+3WwUWFkys5rOa6zRv/M/ioz7Bm/oEQoFEi7Jbsh7xrf4ZEZ5jb0Wm36gwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MUzUaI8m; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61a207a248cso791a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755883804; x=1756488604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=252UfE/vBQ9r0TEDviOY2kI9MCQU3kCqK3n/Zyt8oR4=;
        b=MUzUaI8mJTb04Cv1RizekLuSro6+E1RI7wOyeMPPe/Az9ioxgR3JS+xjdFk3D2sCVt
         JqNcBqbz3rEhFSDG73wGd65c2VjOgX52aIQHxytyz69SkEuSaO4q1JEvdgkoJnkHRq+p
         MyhF89IQ19MVb6HD04ooFlq32svTEbiRPT4cwyMkK9pjSsfYTgogmNpR7T8BAjHMes1U
         yoz+brD9LIcloMHBxHxp10Qpi7wVzvRJaXYIACI3yNA0u+7lYs3iWHpNdBGfDa0jnblo
         5oZMPRS4j2aZ6Y0GiUt1zyfTF9GKlTR5dgxm59qTjRKoeaEMCnDY+6U1hE7oi2wxbwrY
         Hf4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755883804; x=1756488604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=252UfE/vBQ9r0TEDviOY2kI9MCQU3kCqK3n/Zyt8oR4=;
        b=aDvY0m2uhl7dSg7zrj/yCxfCX8nH746QP5JcQQGHdso70gLkj8Sw168Lf+Nxi2Qsg7
         wPSlIVhtcSA4OsUDPdLXilZBYDG9fmcM897ulW78VibMzhxRAqYeB/Z/oTJziVo5r7Gg
         OfMRRPDxMHFm3Zu7WN+8CWRKc0LrGQbCSAxt/mx7Bd50L2KBeWWnL+PgysGEV/WSQmLd
         oAzWZJp0qooOE6wpZ7ImrFLzzfYjEqLpFlGEjeJs46DSr+dCq419fmWJxkcG/0acTXBB
         OzG4lhTUt01tiorVGIQpo5E08TSc3kiSJ6mBa3eCZ26gPc3FAMZzNNQm4EEOr3/l2Ma2
         IIMA==
X-Forwarded-Encrypted: i=1; AJvYcCXf0rDcxjw7ymsT2cn5ugGuN9gny7YYcCTCwnDGT70I7QoCQEv2TaEkaskXhM+GZ8e/TyUyV8BYFII2NJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6OUNbEUJofQI3mQNUPmOwwwz1x7iOF1cZfVFPwQLVtbvQGzCf
	PyHGUhQGE9dq8o33Y2tVojlbkabHWQgVZY0fnWvFeC5aGNN9lKuan5NE3RoyOPvT4Kh7KFrrdzb
	fXQaU6HTz8UBFJxmoh56+OR14Ul+jmrAbjv5/kHF4
X-Gm-Gg: ASbGnctEx5k+LMlm2Wov8hwHkEpKSRlAsXNwkWuCFZAt/l8opG21Zr7aQR+xPb9Xwma
	acc4opVEezxQDJULEPDIWCdrnSd4llffGPtEraLaxIioZTBIAnQG/ftRmfysIW4EQ7bwzVbY3qb
	dcsPu5E8jXuHNj3G8J435x6+AHtcHU2RCrSFjxp1tpnT8gIptKJwskyyidzPREhEXKNCOq3/Ek7
	IphmryEqdXvQBRToOIxPAvAeYtRvtJesJjmce4iznAm
X-Google-Smtp-Source: AGHT+IHnj5c0AQcYtFrhkC1wYBFb2YmVQM0FxMX03JVK1XoHfCrOErryzWCv9sPurRICdZwmIRfZ9c2Qqy8fv/ZcGyg=
X-Received: by 2002:aa7:c458:0:b0:61c:18b3:4e4c with SMTP id
 4fb4d7f45d1cf-61c1d7fd22bmr100263a12.5.1755883804135; Fri, 22 Aug 2025
 10:30:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Fri, 22 Aug 2025 10:29:52 -0700
X-Gm-Features: Ac12FXypkWhwPQn0ViSOI46R77FnBhepBanwmGZ60DMp2xuHG2FRINOwhF4PUNM
Message-ID: <CA+EESO4Z6wtX7ZMdDHQRe5jAAS_bQ-POq5+4aDx5jh2DvY6UHg@mail.gmail.com>
Subject: [DISCUSSION] Unconditionally lock folios when calling rmap_walk()
To: David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: Harry Yoo <harry.yoo@oracle.com>, Zi Yan <ziy@nvidia.com>, Barry Song <21cnbao@gmail.com>, 
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, Peter Xu <peterx@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	android-mm <android-mm@google.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	Jann Horn <jannh@google.com>, Rik van Riel <riel@surriel.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

Currently, some callers of rmap_walk() conditionally avoid try-locking
non-ksm anon folios. This necessitates serialization through anon_vma
write-lock elsewhere when folio->mapping and/or folio->index (fields
involved in rmap_walk()) are to be updated. This hurts scalability due
to coarse granularity of the lock. For instance, when multiple threads
invoke userfaultfd=E2=80=99s MOVE ioctl simultaneously to move distinct pag=
es
from the same src VMA, they all contend for the corresponding
anon_vma=E2=80=99s lock. Field traces for arm64 android devices reveal over
30ms of uninterruptible sleep in the main UI thread, leading to janky
user interactions.

Among all rmap_walk() callers that don=E2=80=99t lock anon folios,
folio_referenced() is the most critical (others are
page_idle_clear_pte_refs(), damon_folio_young(), and
damon_folio_mkold()). The relevant code in folio_referenced() is:

if (!is_locked && (!folio_test_anon(folio) || folio_test_ksm(folio))) {
        we_locked =3D folio_trylock(folio);
        if (!we_locked)
                return 1;
}

It=E2=80=99s unclear why locking anon_vma exclusively (when updating
folio->mapping, like in uffd MOVE) is beneficial over walking rmap
with folio locked. It=E2=80=99s in the reclaim path, so should not be a
critical path that necessitates some special treatment, unless I=E2=80=99m
missing something.

Therefore, I propose simplifying the locking mechanism by ensuring the
folio is locked before calling rmap_walk(). This helps avoid locking
anon_vma when updating folio->mapping, which, for instance, will help
eliminate the uninterruptible sleep observed in the field traces
mentioned earlier. Furthermore, it enables us to simplify the code in
folio_lock_anon_vma_read() by removing the re-check to ensure that the
field hasn=E2=80=99t changed under us.

Thanks,
Lokesh

