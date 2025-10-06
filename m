Return-Path: <linux-kernel+bounces-842562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B20EBBD05B
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 06:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27A43B6F2D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 04:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3D813E41A;
	Mon,  6 Oct 2025 04:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="lJ8iAqBz"
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30AE139E
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 04:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759723370; cv=none; b=YfWNQ5Ahbyl6eYKjgaUHix26quWpMUGCVvqiQZrtWheqXtYUkdpTZGrdTwsMOuhz8w/TvWBFMBqnKU4tvNkLx7JZXAYPTFhUgWwU7E6GCXSNtKkAqLX9yt7X42ciaJviuCTwKX6FaYAMMKhGXP6PmvPMQ5nEPihHxBoml4X+C1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759723370; c=relaxed/simple;
	bh=NKWv9L01aeKSCy4Q1Xsqphz9sGHB02Y7V1jS7VIZYpo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i2AfBCa02ZWBQIL0AIZpUvpUbHnckGbxce2MupmTFgiCCMepa9/XR48yX+uzuy+pL4ydXaJrIZ3LshZm5ZEpww8rhTGbcb0tQc+3ZW0Y6sVzADN+R/56YKMz6lgNlXWRj5IB2otJcmqHnwCMAoMULcNOd6oEtk1yOdDMUaDcn+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=lJ8iAqBz; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=LVCNA4tfiXeycnG/FknYFHUcLrAXPrDvJk4AHpMnvsQ=; b=lJ8iAqBz96JxyGcLPDh/cRyjzm
	Hm6+HKaqSyShjxtt2owPqdgDLRdeCLCWWJFGppI+Obmu0C14p9dMaV9PH1uvqGTNJQqVIbB67NUjW
	2jNKaVNBtpQSJncxEoxWWJhi6xC9ZM1pST17ZAjaFLisfeRK3AN0fg/HjXxtyC8thkOURWn0kD28E
	qvcTh2GRe/VewWhwrRw1dkThruwdnMdeK38BNpYDnrx+sYqXJ/hzZSe6YXa2UCkzTG6JMvGKPqZDX
	7/DJZk4c+Du3t5IlhYe7lI4CM+18jIpCsZ2jZuFIC0fQHip6ox9uKVUyFJei+ZNV4dQBmQC7fU1hu
	EuoFeqPA==;
Received: from [2601:18c:8180:83cc:5a47:caff:fe78:8708] (helo=fangorn)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1v5cCj-000000007ec-3VvN;
	Sun, 05 Oct 2025 23:48:05 -0400
Date: Sun, 5 Oct 2025 23:48:05 -0400
From: Rik van Riel <riel@surriel.com>
To: syzbot <syzbot+afec6555eef563c66c97@syzkaller.appspotmail.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 kas@kernel.org, kevin.brodsky@arm.com, linux-kernel@vger.kernel.org,
 luto@kernel.org, mingo@redhat.com, peterz@infradead.org, rppt@kernel.org,
 syzkaller-bugs@googlegroups.com, tglx@linutronix.de, wei.liu@kernel.org,
 x86@kernel.org, yu-cheng.yu@intel.com
Subject: [PATCH] x86/mm: fix overflow in __cpa_addr
Message-ID: <20251005234805.6fedaccb@fangorn>
In-Reply-To: <68e2ff90.050a0220.2c17c1.0038.GAE@google.com>
References: <68e2ff90.050a0220.2c17c1.0038.GAE@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 05 Oct 2025 16:30:24 -0700
syzbot <syzbot+afec6555eef563c66c97@syzkaller.appspotmail.com> wrote:


> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-out-of-bounds in __cpa_addr arch/x86/mm/pat/set_memory.c=
:309 [inline]
> BUG: KASAN: slab-out-of-bounds in __cpa_addr+0x1d3/0x220 arch/x86/mm/pat/=
set_memory.c:306
> Read of size 8 at addr ffff88801f75e8f8 by task syz.0.17/5978

This should fix it, unless syzbot finds an unexpected new way to
torture things.

---8<---
=46rom e32cd734444d9a95bb2d1067d934f33ab66f050b Mon Sep 17 00:00:00 2001
From: Rik van Riel <riel@surriel.com>
Date: Sun, 5 Oct 2025 23:32:48 -0400
Subject: [PATCH] x86/mm: fix overflow in __cpa_addr

The change to have cpa_flush() call flush_kernel_pages() introduced
a bug where __cpa_addr() can access an address one larger than the
largest one in the cpa->pages array.

KASAN reports the issue like this:

BUG: KASAN: slab-out-of-bounds in __cpa_addr arch/x86/mm/pat/set_memory.c:3=
09 [inline]
BUG: KASAN: slab-out-of-bounds in __cpa_addr+0x1d3/0x220 arch/x86/mm/pat/se=
t_memory.c:306
Read of size 8 at addr ffff88801f75e8f8 by task syz.0.17/5978

This bug could cause cpa_flush() to not properly flush memory,
which somehow never showed any symptoms in my tests, possibly
because cpa_flush() is called so rarely, but could potentially
cause issues for other people.

Fix the issue by directly calculating the flush end address
from the start address.

Signed-off-by: Rik van Riel <riel@surriel.com>
Cc: stable@kernel.org
Reported-by: syzbot+afec6555eef563c66c97@syzkaller.appspotmail.com
Fixes: 86e6815b316e ("x86/mm: Change cpa_flush() to call flush_kernel_range=
() directly")
---
 arch/x86/mm/pat/set_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index d2d54b8c4dbb..970981893c9b 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -446,7 +446,7 @@ static void cpa_flush(struct cpa_data *cpa, int cache)
 	}
=20
 	start =3D fix_addr(__cpa_addr(cpa, 0));
-	end =3D   fix_addr(__cpa_addr(cpa, cpa->numpages));
+	end =3D   start + cpa->numpages * PAGE_SIZE;
 	if (cpa->force_flush_all)
 		end =3D TLB_FLUSH_ALL;
=20
--=20
2.51.0


