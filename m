Return-Path: <linux-kernel+bounces-794446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CED5FB3E1E2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C282164F21
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAF131A063;
	Mon,  1 Sep 2025 11:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZINOxsUt"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3943313E1D
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 11:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756726912; cv=none; b=ToCXhvknX3U5WNxuq5llaQM2ryvfLQ60oonUb0+PrJgRLsDLIm4rBySWBJ8WOJeHmihHdbGWMsr+jWE3gw1H+KgA/Z/Y6xtVmyWYZCVtrhTKyZjVLAwpq+xH/QY0MyLRz3Rc/OqgR2dJzsNMf0a5ihdUoma+VfBEdw8lXNATLtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756726912; c=relaxed/simple;
	bh=qzgGrHeq/ewmc+4g5mR9bPluY4zzWQVun+hO0zIf0zk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b15qv5aTwiNgVwR7lhOGHQDtzmaTTcrisq02sXtouziH2jFHyeqWCMYHGNdaGcOf0cy0VmYum8QqneNECJ4qPO8964FRUEZqkNxtBFXbx6HciPYn/3n/JPV4IzgpwYiX0QlJ16FcVUyUZfRyZvlPz6w2+p3Ltp0/7az8Bas6UaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZINOxsUt; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-248df8d82e2so33870965ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 04:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756726910; x=1757331710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9UG+lvIiNfEGRGKGGi3uQF0nMgFjeuxKOjdv0x36fKk=;
        b=ZINOxsUtoSL0lyJ7FlpfmViwjx0OwX5Oe5oZmBt9ZprpQ4j3AC/YSTpX8ZNxqm/iaM
         ZFhRb4ajdOYX9cL556rkXUiLT1QPFRreTPbQ53xS9zpPoCRiQYW/C13ZTW6sQ6gHmGz9
         4/lADGam6MDEPrBJ8aXaMCOZ/WeT5ml5Qy4xO2QumQiIUSS93OxLPlN7e+zWu04Y3NX1
         XRMkkPxKcIKow27bur8xBK09s6P3+NJ/P/IWrYy+9hpogH8EbeBCdCwus7/nUdNNlRXB
         EeWBbDyPEQjMKlSdcYvjpTojSMwTPt06ULbvJfITmFNs14WnLrVpunfiXU+Y5Xz6SDa7
         HARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756726910; x=1757331710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9UG+lvIiNfEGRGKGGi3uQF0nMgFjeuxKOjdv0x36fKk=;
        b=BUy42mtGyGYxB8VNfHZnNEXsJpMeUSMEWoYm2WKx6NTShfEWU+uK2wAPDVAzpMuh6b
         iEwA/Mo7yHA0rdPGY2NwFDjyLqIaaJ1foSsrTxluu1W0s8Pm6inDcffRC5HjOzvrw2pB
         wcpF6rauEWuA+YCpNKc3P+bEgLagmrHFYZTs3iKcHoGqrZR5Dvm9ua5WU6SpLYmfvDkE
         Sx10DgVsw9owk32A0dg5mSKBucp7VN8Sap1SimiD2bO7DRpEm/r6V7KdWcd8oDPdboCV
         BwLwYL7Pv1sxHQOl1gn0QV5ZWbROJsvBUqjIkHaeCok2jm5IvAy9vuvjMfhRvngl5Ik6
         jIeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO5folDbSPArLIcIuS0BbBLk7c6J1J0Vy60M42pU/x0+1aatvbSh2cFgb/psfB0wWamNoSXcQr71ZXbn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1n4yyml+kIMKzAkPjCe5Ek9rDXUUjAeLDABgJZJRzbUzz8qYa
	6U7WgtgIs4pBa43DSiZXG5LYLx1KyfxnkUGJMMHSweZ9o+GFg2+skS6CWNigRLuXqe4=
X-Gm-Gg: ASbGnctKe5NDWUpIE7e52MZNTPNBx9U8OLVGuwxWX1DNSJEb+GbnzM0x730CF7yZ66g
	chn176dJc/uAsnUhBb+yJy/7mBM+wXgrLK0ZVPOh9mU6FkXFHAz5yX+MIUbUgVZuWNyd4aCmJy5
	3Kq1E8AaToo3WMIZS5a28ffXLL4kxEFRUlJDt8WvfpRSwdeg+ZEpqGP0qa2EHWfEn9vNFdDZyPk
	Zn4cjnGd6+rNizWQyzfLpWF1EPewwQDM4a7YXbwO7ugMnDZSDqkkWL8lhW5qOi4sahM7vH3wvvA
	H07ydclq++F911qbVgFDzQ4MPF/4yUtNmQGELBAaBGjyT7xZTlet5mul5PgXxAbw0SkobYYA7NT
	KrAba0Rp1O18ALN43qvhQ7O2hTpGd3D7CtiDSM4BfGeowc/UBTUbmHLsg0d66/b9Nsz//d+sXDw
	Qu2gRDTmewgrnSnYYNW+tq4AXxyW6L5W+MZAe3LhM1MaI=
X-Google-Smtp-Source: AGHT+IFq81D08oCFEiAMHWfG42pjL//afZ3n6oV63VBN6ou4vT7wjYbmjcFWINr8zZdT5opJWhPK7Q==
X-Received: by 2002:a17:902:f64a:b0:24a:9105:d020 with SMTP id d9443c01a7336-24a9105d719mr59364105ad.51.1756726909672;
        Mon, 01 Sep 2025 04:41:49 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249066e042asm103147055ad.146.2025.09.01.04.41.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Sep 2025 04:41:49 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	apw@canonical.com,
	joe@perches.com,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH RESEND 0/2] riscv: mm: Some optimizations for tlb flush
Date: Mon,  1 Sep 2025 19:41:39 +0800
Message-Id: <20250901114141.5438-1-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some optimizations for tlb flush on RISC-V smp:
1. Apply Svinval in update_mmu_cache() to avoid flushing irrelevant tlb
entries.
2. Clear bit of current cpu in mm_cpumask after local_flush_tlb_all_asid()
to avoid potential IPIs in the future.

We saw the number of IPI reduced from ~98k to 268 on mmapstress01
benchmark.

Some false positive spacing error happens during patch checking. Thus I
CCed maintainers of checkpatch.pl as well.

Xu Lu (2):
  riscv: mm: Apply svinval in update_mmu_cache()
  riscv: mm: Clear cpu in mm_cpumask after local_flush_tlb_all_asid

 arch/riscv/include/asm/pgtable.h  | 16 +++++++-
 arch/riscv/include/asm/tlbflush.h | 23 +++++++++++
 arch/riscv/mm/tlbflush.c          | 64 ++++++++++++-------------------
 3 files changed, 63 insertions(+), 40 deletions(-)

-- 
2.20.1


