Return-Path: <linux-kernel+bounces-838312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5143BAEF13
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 03:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7102E2A2057
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 01:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E3A1F582C;
	Wed,  1 Oct 2025 01:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LrRtf+I9"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9166BFCE
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 01:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759281588; cv=none; b=ZKH4s7jyvv5Nnl4bCGr+mSXXYy6S2szwQe0QVujZU6EyEgdvj0We6qGrPYuM0nfA12vEOi2ici+fESZOIeUC/iQO9g1ZtyzXR2B7clVDLIDB6ozhAxfSLghbeHCP7YIj8VDOOJEMVpio51MceJznpMpRq+geH0IYcOouJkNzt4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759281588; c=relaxed/simple;
	bh=M9LOgCF/ewjwjGXMPr8fRmpTuy9Zmufy4sDA1S784NI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=fChNz5tp2KeiW6EfpO2DIVF4THkdvELtkwpt8dg5sliu/36oBZov/8bJooGMKZcSthPUM/VqycbvpO4Xtanmb/s5+dM9XuuRwAfxY60y+pSckvdP9xiTnT1EI/SKcOQ36T79JxmaG6blyGmLOAZpaOc/affmC2vjBlQmo6OQpGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jasonmiu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LrRtf+I9; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jasonmiu.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-744bf8a764aso102601077b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 18:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759281586; x=1759886386; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ifegM91VMNYCdV3RhGc/5AKOzdvQHyhQ3tKlNLE40ko=;
        b=LrRtf+I9RqZUX2K5hPAwb6Ln+U5W5QKjsmR+IyAyq/WXGOKye7hvkkViT+TT5eViiz
         7vZlii6mRqEGnO9Uo0Nf5r85k+cRh1w9VScJF3/sK20EGLyYJ9jSkqQoOf3B+DDJnLT1
         uf8jqjWVxdFFjwKknj96pRr2mkN3UOy+qySRa2pN+CXnWGWRRU8waHHCc2/0hJr2s06l
         j/XHjOUTAwzOAuFQz3f2NjGsBf6U/8gzSjzBLnKCr9vqBykU3CIHw6jJBfJHSeVL0dqa
         tiBnDiCoZOskekKrGK1Ud6+8Xam0oxE1aA23moUdzggpfC3rNLAJaflXYiip08qT6h3U
         AAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759281586; x=1759886386;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ifegM91VMNYCdV3RhGc/5AKOzdvQHyhQ3tKlNLE40ko=;
        b=XRcV4uAlzvAkJXEBnKdezh5HSda+ZjGxx8yacLorGII6PMPwqPFvth7AZ6fucYntuY
         gh/ylBbX7JyAMP7MijfeSPx5ONNPj87D01/f7dFjzxsZZ759GL1HME6+rXVNNw2KjAWG
         7DtqGZISqaGC1l6TEulSrBuqzuM+GvWkoUIrhYo5tfvCd/qVW7ut9MzXGoQWGsEZ7uBE
         y0jY2X03spXLrd63QmjwvjjHWqn+1GIqFniQRPtB+QDPe93BARLUN5MtvM1tQBRAuCjX
         R5BpKjHKM1cD4f77mJldndJJMQzc3d7S6OqesKnM6Cfu9tqQ2gn7h1zZkXpfCAiChcWQ
         Xd6g==
X-Forwarded-Encrypted: i=1; AJvYcCUskmT0jo+VWOyLA2CcsQW7OSPEecowVJsPAK5DxaTVgU/W2IG5L53bRkUHwvFjD9dkc9zZ4Zcho24KTMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSYP2AOFOkEz+QMLJfce6XQoJg8qv0Z5HEkbQs1BlxHtmFUoGm
	TOvwwseikxvy0AGdGJTiHC+fk4eZR04/SZZGc1AK08DX3lVfiEMb0Mf6L3+SwAkWMtfBbx69cx9
	NNSodNny1dN634Q==
X-Google-Smtp-Source: AGHT+IHnDLAnHU4+42jOPdelDKDAAM8AUpJw1mxLW7+QMrPN8GTOVoPsFzFmqWP34QTuhqqEfQMVQ6uv+qBPag==
X-Received: from ywbjd11.prod.google.com ([2002:a05:690c:6f0b:b0:775:154c:72c])
 (user=jasonmiu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:360b:b0:735:8634:be49 with SMTP id 00721157ae682-77f6f117fcemr28154297b3.21.1759281585803;
 Tue, 30 Sep 2025 18:19:45 -0700 (PDT)
Date: Tue, 30 Sep 2025 18:19:38 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251001011941.1513050-1-jasonmiu@google.com>
Subject: [PATCH v1 0/3] Make KHO Stateless
From: Jason Miu <jasonmiu@google.com>
To: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Miu <jasonmiu@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

This series transitions KHO from an xarray-based metadata tracking system
with serialization to using a radix tree data structure that can be
passed directly to the next kernel.

The key motivations for this change are to:
- Eliminate the need for data serialization before kexec.
- Remove the former KHO state machine by deprecating the finalize
  and abort states.
- Pass preservation metadata more directly to the next kernel via the FDT.

The new approach uses a radix tree to mark preserved pages. A page's
physical address and its order are encoded into a single value. The tree
is composed of multiple levels of page-sized tables, with leaf nodes
being bitmap tables where each set bit represents a preserved page. The
physical address of the radix tree's root is passed in the FDT, allowing
the next kernel to reconstruct the preserved memory map.

The series includes the following changes:

1.  kho: Adopt KHO radix tree data structures: Replaces the xarray-based
    tracker with the new radix tree implementation and removes the
    serialization/finalization code, thereby eliminating the KHO finalize
    and abort states.
2.  memblock: Remove KHO notifier usage: Decouples the memblock subsystem
    from the KHO notifier system, switching it to use direct KHO API calls
    and adjusting KHO FDT completion timing.
3.  kho: Remove notifier system infrastructure: Removes the now-unused
    notifier infrastructure from the KHO core.


Jason Miu (3):
  kho: Adopt KHO radix tree data structures
  memblock: Remove KHO notifier usage
  kho: Remove notifier system infrastructure

 include/linux/kexec_handover.h |  44 +-
 kernel/kexec_handover.c        | 788 +++++++++++++++------------------
 mm/memblock.c                  |  45 +-
 3 files changed, 362 insertions(+), 515 deletions(-)

-- 
2.51.0.618.g983fd99d29-goog


