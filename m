Return-Path: <linux-kernel+bounces-778916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E73B2ECB6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF6F51CC3BAA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 04:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C73A27F756;
	Thu, 21 Aug 2025 04:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bXJAkJNF"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3489222582
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 04:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755750221; cv=none; b=mTEbIAlbJN3fnr7UMh2NkXtAbJKH+wN6MtZPrZSL/Ufpt+ltDKtym2Y0Vag3Rk+uonZ26rd+O7AWcxTNGzj9nJ3+CF8RzQJsWB4s4PAzYbsbHf+afaZ4Wb+6EGY8MA9TRxcF9Cxt/b7m89C/A0zBT9vjh4c6IfYtjlf1/4LtTS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755750221; c=relaxed/simple;
	bh=wV7GrHEOEMLJj0G0fxiQfZinsLEXBmEE+wZx5C3+weg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NrAIFF8uaPrmyEebuVZei279w7A52U5rMdAx9GrD5dhB+08KjIDB/cciWz70gRkQcUBSTA7uJoT9+8c5zYL0+kCfhq20GMZKJ//N/JzXdFVfOJXTPwzAFvQtQEloQfKRSeU15/MlAnRqJcVieNt59Zi+R53s+oo8Va8eKhJYobo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bXJAkJNF; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-618076f9545so4889a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 21:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755750217; x=1756355017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tJPZa6iSMoi1PLd2/zUFs4Y5og6TG9bq1AIV+4vrOuk=;
        b=bXJAkJNFRUoCupwXYwXPsZv7OB4viwg8KuouD/VIEf+jSJKrVkTcmnAkzGETa9Zgcc
         xYrm5o3IuxhynskcUILC3yIkJqt5m7/nt6imV4ruTP40u5oz6mNkEpFgrBMgMNzFAe+N
         DQK+QJNnQ7BLTiolaZis+ZelnCTjmjbKsoqc82a2HfAbrod+Ju0zAJHA5FO+M3gQ7YEq
         XwKx596kJeUgcBbcSEobAC70ARg08QfRDLbYKY17JyF6joc0wUuO8jEXUcCFYuM8jzs3
         OALQxqPiBK+LMF/By5uzzf6gfXxbziSHR+Gx+J4i5kFyZeqlEIKEz7rrA140FU/b5Iw5
         deOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755750217; x=1756355017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJPZa6iSMoi1PLd2/zUFs4Y5og6TG9bq1AIV+4vrOuk=;
        b=PVeAVL7AlNMdjl53k59BGI8P6QBHV0TK5OboMmX8RWqBaJe+4sgEl5P/qPTE0YDtvA
         qd8Z6q11y5/8MdqmqcJFn2jXrB+HaQf0O5M8CGVFuV4by+Fu3hmdoKQDmsXxQc11N25s
         USs28yO7dMCV8uWR2dPgPPvoVrPhENXy3U2phqUCy91muO0fw4NXkQFwa4Cepv2vp28V
         Ml6cCwYmLkA7tcCtg9GJwdWvGwJpyDJI142tl1qUY7LMgMSBaArDoVvCgxZqKE4ebA21
         TDZsxfNvGzBbmrTvMmmeuiufLH33OHVSwrnMoqpJ8MJJRZmB8b3RhUf5P5ZBkukA/ick
         DDkg==
X-Forwarded-Encrypted: i=1; AJvYcCUsBqaR5rB5odAJeB3VO7up10ralyXBqpKTcVEINbx7p0Ep8QfF2IRFmyyPgc//Mqtm4+VioBGhvy+PFDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBfXfq7tN1JiZSdnHiusoaPXPkOLb3+ezS76Cnn2TW+XsSy/Gk
	eXIkDOSTbAZbxMp38ngT+LAggANPWqMg9819SgQnF5Nt7LhKtcc5vX6VctN6W28cxK+pmyEJgH+
	3ognUbLGoNmc1v+RI1j6V/ZABZzwUfYBvu4HLEmeB
X-Gm-Gg: ASbGncvwDd9UBTh7drX4navJI6AyvH+vsW/xj2oGjlG1GpG6nXlfKaLCH9fWPZPMinI
	/kOpgWlCMPsFSVW7RC2K8dRtrgjVRtXRHMMOpD8JonmjJhG2HRELc/Mi+WA/vZT7V7u98AiUCtY
	f6oiSjdwPm0E8H/MyyYeLolyTMj8b8QZJ+rdZi4exq/fUECBB0BAtji3KspcQndw4bdOzQRyBBj
	E0DwAXQL9eFrfiXkYYEDcK6F0q44Jk24rW6atjmT8U7IitfYJHVdJXb9Q==
X-Google-Smtp-Source: AGHT+IGdCorZFhFN/jvQZ9XXTsyYAIY2G/U308rreWWDm25QK8gfH/sQE+KjXNaamm4LJKfGiychFRBQ0/gUwQlv7CM=
X-Received: by 2002:aa7:d9cf:0:b0:618:6596:98ba with SMTP id
 4fb4d7f45d1cf-61bf8eba71amr27815a12.1.1755750216993; Wed, 20 Aug 2025
 21:23:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Wed, 20 Aug 2025 21:23:24 -0700
X-Gm-Features: Ac12FXwvd14Qm8tm_c3BpvOsMXYA5kV30dTtibUB_5sLvaORIV05wvGNB6uvcK8
Message-ID: <CA+EESO6dR5=4zaecmYqQqOX4702wwGSTX=4+Ani_Q9+o+WUnQA@mail.gmail.com>
Subject: [RFC] Unconditionally lock folios when calling rmap_walk()
To: linux-mm@kvack.kernel.org
Cc: Peter Xu <peterx@redhat.com>, Barry Song <21cnbao@gmail.com>, 
	David Hildenbrand <david@redhat.com>, Suren Baghdasaryan <surenb@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	android-mm <android-mm@google.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

Currently, some callers of rmap_walk() conditionally avoid try-locking
non-ksm anon folios. This necessitates serialization through anon_vma
write-lock when folio->mapping and/or folio->index (fields involved in
rmap_walk()) are to be updated. This hurts scalability due to coarse
granularity of the lock. For instance, when multiple threads invoke
userfaultfd=E2=80=99s MOVE ioctl simultaneously to move distinct pages from
the same src VMA, they all contend for the corresponding anon_vma=E2=80=99s
lock. Field traces for arm64 android devices reveal over 30ms of
uninterruptible sleep in the main UI thread, leading to janky user
interactions.

Among all rmap_walk() callers that don=E2=80=99t lock anon folios,
folio_referenced() is the most critical (others are
page_idle_clear_pte_refs(), damon_folio_young(), and
damon_folio_mkold()). The relevant code in folio_referenced() is:

if (!is_locked && (!folio_test_anon(folio) || folio_test_ksm(folio))) {
        we_locked =3D folio_trylock(folio);
        if (!we_locked)
                return 1;
}

It=E2=80=99s unclear why locking anon_vma (when updating folio->mapping) is
beneficial over locking the folio here. It=E2=80=99s in the reclaim path, s=
o
should not be a critical path that necessitates some special
treatment, unless I=E2=80=99m missing something.

Therefore, I propose simplifying the locking mechanism by
unconditionally try-locking the folio in such cases. This helps avoid
locking anon_vma when updating folio->mapping, which, for instance,
will help eliminate the uninterruptible sleep observed in the field
traces mentioned earlier. Furthermore, it enables us to simplify the
code in folio_lock_anon_vma_read() by removing the re-check to ensure
that the field hasn=E2=80=99t changed under us.

Thanks,
Lokesh

