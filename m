Return-Path: <linux-kernel+bounces-853475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B61CEBDBC1C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0F619A2A52
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 23:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272982EDD60;
	Tue, 14 Oct 2025 23:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RZ+Wbor6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DC52ED871
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 23:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483711; cv=none; b=nyW/RfC/ojQSUTBy0OhkkBwTNv2XtCToZKiVd6e8q8gK5A4XvSzH1e+QzSA5/v+5vmmgQjlj4hcCpYZ28z9UtGhBH0YBdEZIiyYYhx24a/m77zPLGIoHJ4bgvLMNU+uUtDbt9GAvKm+qXm87z7wIrikagsY7GtC7NkVu0nYq8fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483711; c=relaxed/simple;
	bh=ey6bN7PZlmCiaVksgh4kUPp6cN8auSH7+z8fTjASOBw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=flQUfWiIuFl27692sltp42AYZQkBdAtjtOhcXsEq+li1EsfnlgmiZhs9KPhvzsbR2MA+0JeoauFxQXz3aMYu7+huS+hBYJH5UxUOSGSz9gEJu6m0vV4i3KxRDaPnPXzLn0rxVE9ys+kVyMY3D8LwfdUQxIZ4owue0jKOd6Kp0Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RZ+Wbor6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760483707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gkEesdVP5klvagCiPua/4aXkAVndt2miK7odjHhrzGc=;
	b=RZ+Wbor6BeSw3lPI+eKilPIwGyBGqY18h03+RNJBqnLDhVLsNaWHF2tGun3E87xWdLOQpK
	6RNFK44o7qOHrzp7kXBpQzpxxyARxb0GEezVaCzusciIIhOBWRSfkmcYnOi2aKmkWSTYW+
	U3qAjBRHQt5AyBLQar8tyOcOwJEMxRI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-o7KQB8xYOFSGBLYamOW5Rw-1; Tue, 14 Oct 2025 19:15:06 -0400
X-MC-Unique: o7KQB8xYOFSGBLYamOW5Rw-1
X-Mimecast-MFC-AGG-ID: o7KQB8xYOFSGBLYamOW5Rw_1760483705
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-84a3a7ac082so2665077385a.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483705; x=1761088505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gkEesdVP5klvagCiPua/4aXkAVndt2miK7odjHhrzGc=;
        b=F/482nqNnk945OuW3uDuhsWd0feC8/iju7//eUqsPkavWDWvxvvjtQbrBK2yreviqy
         XBpcBL7QPS/tkNT52wdiBM08u4x+epd0vd5XFBJRzNluJ2OF6yXnNEDuXaErCjbX/1+U
         rxzrsXcrSFnBKdypTNuvsRpXAT3B7lU1PqXmBjMew1hTfcqpDwzoxR68qCDkVsJ8ujrx
         xz9ldSaVv/P/GChDXKd4oLc8tiqzWdwSZGIQl7+N58y1mWT276mrhAegPKrt2bLnRprU
         kMjW5/SI3LMGctl9k20UaBp3+U/EsydTf6esLOkTapcI2wXs1HaNmhIK63KZPWNrCqT5
         xbzQ==
X-Gm-Message-State: AOJu0Yzid3O/lben6AXh01O//5s4aU2fI93bMa/L1U/QwMgpik/jx2V3
	xIpfduSiLyxf4hLff+YBRa0O+Suy536Wv9KWxeQJa7Y9rf7lmXkb/Ua8cSdNHUkPFBYzQpFrMpP
	vJxQTB0AWTy8zcFJx0ROPTdXRkyIgyz0cHtx/WSGX8/xBfUkxoAk7p+Vg1dfaznuxAG4+nBTZLu
	+q8HtHBLRtU2UNCyHaysCTr1F0qGv8xd/9ZbMZ6adX1onDtFA=
X-Gm-Gg: ASbGncsaWYEtogWPte/NMbgOHJMZI4BPxPlkLLAnKjWRMXXNxCF87HDPAr+Lc7WnLyg
	aFS/goKXOkr5YMxbs4V86Kw04RsteYrabpW62PXqKKt7T+FZ8k2kqJdBicv1z6Kty4HeG5B9L23
	VGkPTUhoebutHUUbEJRN0VzhJFaMDU7rUP1mIZnaBeeuhe/JSFXMoOlwpf+tp8hG8ZTT6nxL+3I
	OLCjk/doooawwJTzykyl7Hc8+mQsbrCS+ckLTmLRib4DcfeTghJxaPnpv9ImE1MPjBGcqGsidW7
	b/0xQpX8bW++s6FYJOqgzJi4JjNLXQ==
X-Received: by 2002:a05:620a:3710:b0:82e:ce61:f840 with SMTP id af79cd13be357-88355a557e0mr3109209785a.84.1760483705081;
        Tue, 14 Oct 2025 16:15:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0p/fJJcRO44NvHEwHC39Jn7HH9sdaldnpLK5FANmX+q1MOcaF1/2rpEijkCSasuFRimulfg==
X-Received: by 2002:a05:620a:3710:b0:82e:ce61:f840 with SMTP id af79cd13be357-88355a557e0mr3109203585a.84.1760483704583;
        Tue, 14 Oct 2025 16:15:04 -0700 (PDT)
Received: from x1.com ([142.188.210.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-884a23693a0sm1280258685a.53.2025.10.14.16.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:15:04 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Houghton <jthoughton@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Ujwal Kundur <ujwal.kundur@gmail.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	peterx@redhat.com,
	Oscar Salvador <osalvador@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v4 0/4] mm/userfaultfd: modulize memory types
Date: Tue, 14 Oct 2025 19:14:57 -0400
Message-ID: <20251014231501.2301398-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[based on latest akpm/mm-new of Oct 14th, commit 36c6c5ce1b275]

v4:
- Some cleanups within vma_can_userfault() [David]
- Rename uffd_get_folio() to minor_get_folio() [David]
- Remove uffd_features in vm_uffd_ops, deduce it from supported ioctls [David]

v1: https://lore.kernel.org/r/20250620190342.1780170-1-peterx@redhat.com
v2: https://lore.kernel.org/r/20250627154655.2085903-1-peterx@redhat.com
v3: https://lore.kernel.org/r/20250926211650.525109-1-peterx@redhat.com

This series is an alternative proposal of what Nikita proposed here on the
initial three patches:

  https://lore.kernel.org/r/20250404154352.23078-1-kalyazin@amazon.com

This is not yet relevant to any guest-memfd support, but paving way for it.
Here, the major goal is to make kernel modules be able to opt-in with any
form of userfaultfd supports, like guest-memfd.  This alternative option
should hopefully be cleaner, and avoid leaking userfault details into
vm_ops.fault().

It also means this series does not depend on anything.  It's a pure
refactoring of userfaultfd internals to provide a generic API, so that
other types of files, especially RAM based, can support userfaultfd without
touching mm/ at all.

To achieve it, this series introduced a file operation called vm_uffd_ops.
The ops needs to be provided when a file type supports any of userfaultfd.

With that, I moved both hugetlbfs and shmem over, whenever possible.  So
far due to concerns on exposing an uffd_copy() API, the MISSING faults are
still separately processed and can only be done within mm/.  Hugetlbfs kept
its special paths untouched.

An example of shmem uffd_ops:

static const struct vm_uffd_ops shmem_uffd_ops = {
	.supported_ioctls	=	BIT(_UFFDIO_COPY) |
					BIT(_UFFDIO_ZEROPAGE) |
					BIT(_UFFDIO_WRITEPROTECT) |
					BIT(_UFFDIO_CONTINUE) |
					BIT(_UFFDIO_POISON),
	.minor_get_folio	=	shmem_uffd_get_folio,
};

To show another sample, this is the patch that Nikita posted to implement
minor fault for guest-memfd (on top of older versions of this series):

  https://lore.kernel.org/all/114133f5-0282-463d-9d65-3143aa658806@amazon.com/

No functional change expected at all after the whole series applied.  There
might be some slightly stricter check on uffd ops here and there in the
last patch, but that really shouldn't stand out anywhere to anyone.

For testing: besides the cross-compilation tests, I did also try with
uffd-stress in a VM to measure any perf difference before/after the change;
The static call becomes a pointer now.  I really cannot measure anything
different, which is more or less expected.

Comments welcomed, thanks.

Peter Xu (4):
  mm: Introduce vm_uffd_ops API
  mm/shmem: Support vm_uffd_ops API
  mm/hugetlb: Support vm_uffd_ops API
  mm: Apply vm_uffd_ops API to core mm

 include/linux/mm.h            |   9 +++
 include/linux/userfaultfd_k.h |  75 +++++++++++----------
 mm/hugetlb.c                  |  18 +++++
 mm/shmem.c                    |  24 +++++++
 mm/userfaultfd.c              | 120 +++++++++++++++++++++++++++-------
 5 files changed, 189 insertions(+), 57 deletions(-)

-- 
2.50.1


