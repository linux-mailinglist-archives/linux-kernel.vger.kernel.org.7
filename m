Return-Path: <linux-kernel+bounces-832315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBE5B9EE49
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F8B419C74C8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AC92F7AB7;
	Thu, 25 Sep 2025 11:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGgHpGxJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B331A2F7460
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758799370; cv=none; b=BYJg/vpLRoHwxHepXpy7+7iqiLrf+/IxMRwsrr+hmat1ut/yByeVB2I3R8tvs+6cY9xrN3c+ntobWuiS5DcgXdnFDBjBSNS+QGfPq4dJdyisWwtsrUFXuA01+ScrQPex2pVd4Dm1zZyeR/0LxyCDhajImYK0RVcemzTCQHSDISs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758799370; c=relaxed/simple;
	bh=7TY6Mv3GwQKn2+eNHs40STB/z7xZBiylOf9OH7ebP48=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gIef5N1L2hP+EQT8S/GvgqC98awHKDj8jnaS+Kx87+YywpD2eDvST0RsianlayPsyifYUttEHRALkvAOaGOPrNK54dYPKduEq78AHzMCMgJ5dm8xh3CO5UL0OYNmtbztZcOaoWPP9Cq2DR0oMZKtHS4toVOjfvfC0p+mHVUo6tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGgHpGxJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A71C4CEF0;
	Thu, 25 Sep 2025 11:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758799370;
	bh=7TY6Mv3GwQKn2+eNHs40STB/z7xZBiylOf9OH7ebP48=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=OGgHpGxJfEAD//pye7XhrdBdEIhkzl82PuN1xG6OAN75cjulysEjTDqJBVQsKMi5k
	 5vactApsBqJ3kNJoOtqetfcrquQnTyhznPvCFgl93rBrgU3qYHIKF009R0+iJ5oxS0
	 MUIY+CV/PcVMYs66C2FZUJHD2BDRM0PrTVAFyRwkKNMpNZY2zAI9NkWimrMXNIr4oF
	 9ufivXjaY4WvfybMmXR8BPiTzbW6IUXtM4yLrCSh4tvAKjzYfYbypNmRfRRznE+UsI
	 T9K3JWhWHTJUDUQJ/2nrPko8f5v/MWhexD2+ZS4NADYSZdcrZppbQfkfEuSdOAxZEA
	 b8pBHwFAHMS1w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Jason Gunthorpe <jgg@nvidia.com>,
  Mike Rapoport <rppt@kernel.org>,  Alexander Graf <graf@amazon.com>,
  Baoquan He <bhe@redhat.com>,  Changyuan Lyu <changyuanl@google.com>,
  Chris Li <chrisl@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] kho: add support for preserving vmalloc allocations
In-Reply-To: <20250924140010.81305926b42d0223dcf3b818@linux-foundation.org>
	(Andrew Morton's message of "Wed, 24 Sep 2025 14:00:10 -0700")
References: <20250921054458.4043761-1-rppt@kernel.org>
	<20250921054458.4043761-4-rppt@kernel.org>
	<20250922131948.GX1391379@nvidia.com>
	<20250922143407.93e171f8b7c09eb21159a33e@linux-foundation.org>
	<mafs0ikh7dg54.fsf@kernel.org>
	<20250924140010.81305926b42d0223dcf3b818@linux-foundation.org>
Date: Thu, 25 Sep 2025 13:22:47 +0200
Message-ID: <mafs0a52idbeg.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 24 2025, Andrew Morton wrote:

> On Wed, 24 Sep 2025 17:28:07 +0200 Pratyush Yadav <pratyush@kernel.org> wrote:
>
>> >
>> > Not sure why this code works - I'll suspend the series from linux-next
>> > for now.
>> 
>> It only gets called in the error path and that didn't get hit during
>> testing I suppose. Until v3 the chunk was being allocated using
>> kzalloc() so I guess this got missed in the move to get_zeroed_page().
>> 
>> I think Mike is out of office this week. Do you think this series is
>> stable enough to land in the upcoming merge window? If so, I can send a
>> v6 with the fix today.
>
> A one-liner fiup would be preferred, if no other changes are required,
> thanks.

--- 8< ---
From f746718a99da3c670089a42f7c59660b455f265d Mon Sep 17 00:00:00 2001
From: Pratyush Yadav <pratyush@kernel.org>
Date: Thu, 25 Sep 2025 13:05:08 +0200
Subject: [PATCH] fixup! kho: add support for preserving vmalloc allocations

Chunks are allocated using get_zeroed_page() so they should be freed
using free_page() not kfree().

Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
---
 kernel/kexec_handover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index e6380d8dce574..d06ca232683cd 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -885,7 +885,7 @@ static void kho_vmalloc_free_chunks(struct kho_vmalloc *kho_vmalloc)
 		kho_vmalloc_unpreserve_chunk(chunk);
 
 		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
-		kfree(tmp);
+		free_page((unsigned long)tmp);
 	}
 }
 
-- 
2.47.3

