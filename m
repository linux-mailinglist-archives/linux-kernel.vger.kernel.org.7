Return-Path: <linux-kernel+bounces-860546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BC3BF05EA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 31ECF34AB1D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF82D2E9EDA;
	Mon, 20 Oct 2025 10:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DXu9m64P"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF5D239E79
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760954592; cv=none; b=tohxGLBY+nXFe5SHN4dSqWCkA0RyJJNshEL6YLP+uIZrd7e8Z3xd+KPk36C9+gq/TWT0SPVC3pqVjmqGwkcicraCxe8bRReuZdDxPO2dlAfuUQGYWO/RS/7zh4gZOqjCP0aBO1YHilhQKeY2MVXMpt+a5jLR2ka7Uf2yXAIREl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760954592; c=relaxed/simple;
	bh=TZcqN5HrfiIxebExiiaD6oW131dU0wbnKXBD6df4Pwc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=NbFKZMWVCvgsUeUVoO3Y3Jo/xmgx0co4b+5JuWx2jXOhvLqgadljnpvo1y4okf8fw+djcUPKEqFiw032u3TKSZddf1voCrdtxGh0Ajqkiz+hOPGLJeA5ZycnY8GyBxZrtunkxKolzBZrnDtO7LEUAtwi8cnJTweTMbDB9c3/69Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jasonmiu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DXu9m64P; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jasonmiu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3324538ceb0so7935658a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760954590; x=1761559390; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3zkkb3/hxx2ZrEmxAOPFPinoGf8SbvbCWVFeKCtPhzY=;
        b=DXu9m64PfMdteks9kSXJ81rIQJl561HapmJUX3tMlGdxarHylV0YSNKJgw5GhgCN0D
         Z+cvPI5dppEMe8kvW7ECdP3Sqnneji3JO0Qj3pA9p+dkYxbMFUgwBjsiliaZWTY2/O9q
         DiCvuiStpOgNh+5iiZWDCAoSIati/WQQ7sKqwJTom625TNFRjDEp9ahBYro7TRWu/vcD
         rYbBKPh8isG/cxykn05w5WAQdZVaGOO6UXNpQy+a5S+6SAHif36vJqfffK7fR6vagQte
         YItRQ1Kr4dVqgmUwYxKzB4myNsfSA6K5Ux7T4ydAhAaoEb35Ifp/8A4I2DYxgtA36TjA
         vxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760954590; x=1761559390;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3zkkb3/hxx2ZrEmxAOPFPinoGf8SbvbCWVFeKCtPhzY=;
        b=q8/S5yoAmNFva9z8Uz+299fRygnfBurab+rXJ14EShccxGWjG9BOCpUtzD3yHrrRG6
         pFOcV4+446Uo8g60bDJGYHXKrIutSYap5zj8WxLKSjBS46/nSB0EWJxw6cE0Rw4IAASf
         c4X4gYSUSAhPraEOtjuBE5pq542AK4Rvke/sxRIUnjxalp42BB5voSpLPMw3i6JBNYCu
         I5QCPftCf6rBJIDJDuQm3kISrt5N6o+DQSsedf+D1+3SX/VzGjWpOqYFhhJkB5QXEulk
         lc4yIWM/x6c8sZ2llgi4ko61KWFYPr/gwD+ucywwKvXDaXkjVPgPqGgDPRNa5OByUJBb
         1xdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYhgwHmkuJXLjlOCmjDjVWI7/zCRGt73QLIEE9Kd6UGoKkvgTT94m04y+hLUgD5OOf5FQoanZ6fyXOqmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxczQiF9indvG5lmerewYGO/lTXHLL3MWo7i2C6Zx/PjFDUqMgc
	8ZykN36FPJ0WaqvGitSHdrvcw5KERdPiNAGVQK3Jgo/qS7v6p5R1wyqHBe3k2bvEHYUAvbuwUC0
	aZILy6GS33rWyuA==
X-Google-Smtp-Source: AGHT+IE39JYyDP7tyke6Ks7t0xTJvAaz4ioHAVUQMd14F2ylAQznE4GvniXnCX4D+Lio6mB0thI0FwjEvWtddA==
X-Received: from pjtk2.prod.google.com ([2002:a17:90a:c502:b0:327:7035:d848])
 (user=jasonmiu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:270a:b0:33b:ae47:fe72 with SMTP id 98e67ed59e1d1-33bceb1cf3cmr15607754a91.0.1760954590010;
 Mon, 20 Oct 2025 03:03:10 -0700 (PDT)
Date: Mon, 20 Oct 2025 03:03:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251020100306.2709352-1-jasonmiu@google.com>
Subject: [PATCH v2 0/3] Make KHO Stateless
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
    and adjusting KHO FDT completion timing. KHO selftest is also updated
    along with the APIs change.
3.  kho: Remove notifier system infrastructure: Removes the now-unused
    notifier infrastructure from the KHO core.

---
Changes in v2:
- The radix tree now uses 0-based level numbering (previously 1-based).
- Added a new public API: `kho_remove_subtree()` for clients to remove an FDT subtree.
- The output FDT is now protected by a mutex.
- FDT properties have been moved to a new header: `include/linux/live_update/abi/kexec_handover.h`.
- The KHO selftest has been updated.

---
Jason Miu (3):
  kho: Adopt KHO radix tree data structures
  memblock: kho: Remove KHO notifier usage
  kho: Remove notifier system infrastructure

 include/linux/kexec_handover.h                |  42 +-
 .../linux/live_update/abi/kexec_handover.h    |  10 +
 kernel/kexec_handover.c                       | 869 +++++++++---------
 lib/test_kho.c                                |  28 +-
 mm/memblock.c                                 |  45 +-
 tools/testing/selftests/kho/init.c            |  19 -
 6 files changed, 464 insertions(+), 549 deletions(-)
 create mode 100644 include/linux/live_update/abi/kexec_handover.h

-- 
2.51.0.858.gf9c4a03a3a-goog


