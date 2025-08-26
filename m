Return-Path: <linux-kernel+bounces-787285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 601CEB37416
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 22:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E0283645E7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 20:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ADC28643A;
	Tue, 26 Aug 2025 20:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhNu81DL"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACB9283159
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 20:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756241790; cv=none; b=tQMkcLJOkAY7YnG9cEWUKSd2/UpwkyWrQ2wTui09oiplKZs6g6x+zMFlWUyrKhewmJjk0A7xnWsNUVMpn/U8KaL0LLGVfnX7oOqlVs5c+fd8th7VdQLmAFJYoiFF8ydKR2FrvSo1Hd+CT2l1ccS+nNhx6yOQlooNdwoVVAjipOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756241790; c=relaxed/simple;
	bh=Dd4h3Zvkw2c93L6aVky5/vzY0xTMdqvKgMjN57eK9Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ip5L+QaNsN+24bAKNMQmCFmm5/xqHl+IdMq8D7dQqWCSBYcTxgYOfn7CIzOFwfecMzD7w5LyoRuWRLAIlSqZCBV9g36A8ZAgX0Ot4x6eAu+BS/SH0iIF0imwm1aoaXP8j2QI4emtZRm3zJwAu9gw2qkYKrFEEBENHEjsuR/T/XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhNu81DL; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-770530175b2so2514266b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756241788; x=1756846588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iTroVE/kz3b/uNx/5cVLsCA/AYU5896KtbIGYWW644M=;
        b=JhNu81DLqsxcHYJGxvCs5/f2Jwz0M1guJicrKKUHOAnCQz1gnKDyIELszOYt63UJdg
         NO/bLF+fCiyBTN4yDbHRTTUYkXEM6fLb6/hH2N803brLpehQzNLEWgaEOYF1IRX1sxt9
         +G5FKbdvj1K48nQfScOx1v8l8T4gN79wOpGqTvhg/kPkd87v+BPnBjCQMY94aJe/C4g/
         a+GxZPbDh9p+BVxLd3fgX5/rUXq3uGxEPbFYIUDVh+U7qoIQ86qZilmABazi8mewQnIE
         97gNUxjhP6zoIlJm/pv6aFON06gX18tSvwVWdO/Y/PVVYS2IVJvdQ3a9Nipo2BGSOXwz
         R68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756241788; x=1756846588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iTroVE/kz3b/uNx/5cVLsCA/AYU5896KtbIGYWW644M=;
        b=Q2Oc2nyCHOKOQpkgUyZE+mqQsOOyya0Xubuo8/sStNGLru+UtCK8rPSS9cYUx090Y2
         C1k0X3CrXLVa2dSIzMEAgyn7hyThHO1IBdPlKbtaVO2nWeWVCUUL2OjOMAB8ErpIil1p
         6Bg/UFaQRI+n5clg/5MxgIkpxsjSuz7oze5RA4I3WuPP0sld7YYUQjCf2MLwCbNZvmVK
         V1jhQ2NagReks924aQwX84WLCFhTPOzGDZwc+We0Z0+UxnC2gVdqLmSHIu44ydL3YUWX
         RZzQsFS57y5yfZY5ohVXIKQZ3GSzXkOfyBYDgFoo6zHvQKJof+4E84OlDkGQNgk2NiqB
         jIgg==
X-Gm-Message-State: AOJu0YywBhUQ8EVt7V/UGJ1Nx3eFpx97HiE1DxZaY2uUyvhi0Dct4nxh
	H0WZ3bLIJsMHlDEQG8AQRuC34aytSrL2BOiF8dzlQSO6TSVW3mlS2TSf
X-Gm-Gg: ASbGncvhuZ2mXyN8TajXIdgwEazt+1kpnHcm0Memy5xnuvcN90rjPeKptTw3Uo+QjDs
	w70ggYtdxVjtCW8QzGraFgYgWWsPcZJJcR/0lZ8qpxnmaYgoisZIygtIQmEkd77m1jfpWKiaKwl
	MR62KYE1LvIuA2pAXSvv9z8p9YoK9ad0GZxFokPSrWNk5HJ2c59olyYygRvGwSxjsgrAntbb/dj
	cvoU4v3DIkQMfUY+B4bAk+cMOmTKvrg9xZiUzlWHE7oV+dGY2EilXDHJARNkyHQhsHwF63cT3e3
	luXjF4V/APQg6KdiKhmudBjsnI/vUQNhG87FK9Th8kRKBfE1cMEbbKy/OQx+0EPDy2idlXIDfZ/
	BQc+oFw/ESIzruxi6AgYv4itII4SUOZdiPHpk4qagPdMh8AozqoctnA==
X-Google-Smtp-Source: AGHT+IEIDsabh4nxrTgNsWeYxrfyRBpfU2Io7iUZO4sYrxXVXXbYXrh0I92hsnx/O4CIM5s+W39Ang==
X-Received: by 2002:a05:6a20:939f:b0:243:78a:8276 with SMTP id adf61e73a8af0-24340e1cafamr22899144637.60.1756241787836;
        Tue, 26 Aug 2025 13:56:27 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-771e814cbccsm5817935b3a.35.2025.08.26.13.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 13:56:27 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Justin Sanders <justin@coraid.com>,
	Jens Axboe <axboe@kernel.dk>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 0/7] Cleanup free_pages() misuse
Date: Tue, 26 Aug 2025 13:56:10 -0700
Message-ID: <20250826205617.1032945-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

free_pages() is supposed to be called when we only have a virtual address.
__free_pages() is supposed to be called when we have a page.

There are a number of callers that use page_address() to get a page's
virtual address then call free_pages() on it when they should just call
__free_pages() directly.

Add kernel-docs for free_pages() to help callers better understand which
function they should be calling, and replace the obvious cases of
misuse.

-----------------
Based on mm-new. I intend to have all of these taken through the mm tree.

I've split the patches into separate subsystems to make it easier to
resolve conflicts, but there aren't any functional changes.

v2:
  - Reference __get_free_pages() instead of alloc_pages() in the
  free_pages() kernel-doc
  - Get some Reviewed-by tags
  - cc the subsystem maintainers related to specific patches

Vishal Moola (Oracle) (7):
  mm/page_alloc: Add kernel-docs for free_pages()
  aoe: Stop calling page_address() in free_page()
  x86: Stop calling page_address() in free_pages()
  riscv: Stop calling page_address() in free_pages()
  powerpc: Stop calling page_address() in free_pages()
  arm64: Stop calling page_address() in free_pages()
  virtio_balloon: Stop calling page_address() in free_pages()

 arch/arm64/mm/mmu.c                      | 2 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c | 2 +-
 arch/riscv/mm/init.c                     | 4 ++--
 arch/x86/mm/init_64.c                    | 2 +-
 arch/x86/platform/efi/memmap.c           | 2 +-
 drivers/block/aoe/aoecmd.c               | 2 +-
 drivers/virtio/virtio_balloon.c          | 3 +--
 mm/page_alloc.c                          | 9 +++++++++
 8 files changed, 17 insertions(+), 9 deletions(-)

-- 
2.51.0


