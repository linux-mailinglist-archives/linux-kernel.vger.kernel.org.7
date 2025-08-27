Return-Path: <linux-kernel+bounces-787453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C79B37677
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 03:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1765F1B65A99
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 01:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CB41C9DE5;
	Wed, 27 Aug 2025 01:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iBJB/cjG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEE73595C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756256864; cv=none; b=t6mvqmN7elO15zXRr4rn+ih4eAoQ9Ihd1dmaBRdSLMddgxBoczJSdcdtImQ8qEUj6YiuN4/UcjAmn5wvj1qLzWwi3/+ND/9trpj6n1YYJKJHHmBxbBVzdW4iTZ3IiMG0lbSyzlsn6T332wV6Z1QUDBv2zu80yRNMExNHg0Y/zK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756256864; c=relaxed/simple;
	bh=2bj+qTAYnr7Hk8Btw7x0K9XP+Ek85nue9lNeuKCH1HY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=exWqZ+p6JWk4Xm3iuOOfWVjK6/4+xjHvikZOxwcazrBDBofhHN5d7QTPkuubZAKebtOKO9ZPd1sMIAwlaaG5c+NqVjEtPNbpKIFPrrrFr6NaextiBQzmWvSAkiwyeokgHQ68a6GiumKUENGowoTpdLAUNZ80RcmybpcKuvGxy6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=iBJB/cjG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B4DC113CF;
	Wed, 27 Aug 2025 01:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1756256863;
	bh=2bj+qTAYnr7Hk8Btw7x0K9XP+Ek85nue9lNeuKCH1HY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iBJB/cjGU37/tTE692qCZ8U05f2lTBZW0U8RP6oJvMzb76cCO85ohsYB6JsggiF8H
	 5hInQqxJuvLhIarrbtnM4qEXrqJf6z4ux2lOsdbTXch6dyP2cezFlxztXBW9VwOa4P
	 l540ZXGp5MSsXXaP3IG1fdjk1GmxiY0ymsnNA5uc=
Date: Tue, 26 Aug 2025 18:07:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Breno Leitao <leitao@debian.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, kexec@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 bhe@redhat.com, oxu@redhat.com, berrange@redhat.com, kernel-team@meta.com,
 Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64: kexec: Initialize kexec_buf struct in
 image_load()
Message-Id: <20250826180742.f2471131255ec1c43683ea07@linux-foundation.org>
In-Reply-To: <20250826-akpm-v1-1-3c831f0e3799@debian.org>
References: <20250826-akpm-v1-1-3c831f0e3799@debian.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Aug 2025 05:08:51 -0700 Breno Leitao <leitao@debian.org> wrote:

> The kexec_buf structure was previously declared without initialization
> in image_load(). This led to a UBSAN warning when the structure was
> expanded and uninitialized fields were accessed [1].
> 
> Zero-initializing kexec_buf at declaration ensures all fields are
> cleanly set, preventing future instances of uninitialized memory being
> used.
> 
> Andrew Morton suggested that this function is only called 3x a week[2],
> thus, the memset() cost is inexpressive.
> 

Thanks, I queued this as a replacement for your eralier "kexec/arm64:
initialize the random field of kbuf to zero in the image loader".  I
added cc:stable, a mention of the UBSAN failure and I added thie Fixes:



From: Breno Leitao <leitao@debian.org>
Subject: arm64: kexec: Initialize kexec_buf struct in image_load()
Date: Tue, 26 Aug 2025 05:08:51 -0700

The kexec_buf structure was previously declared without initialization in
image_load().  This led to a UBSAN warning when the structure was expanded
and uninitialized fields were accessed [1].

Zero-initializing kexec_buf at declaration ensures all fields are cleanly
set, preventing future instances of uninitialized memory being used.

Fixes this UBSAN warning:

  [   32.362488] UBSAN: invalid-load in ./include/linux/kexec.h:210:10
  [   32.362649] load of value 252 is not a valid value for type '_Bool'

Andrew Morton suggested that this function is only called 3x a week[2],
thus, the memset() cost is inexpensive.

Link: https://lore.kernel.org/all/oninomspajhxp4omtdapxnckxydbk2nzmrix7rggmpukpnzadw@c67o7njgdgm3/ [1]
Link: https://lore.kernel.org/all/20250825180531.94bfb86a26a43127c0a1296f@linux-foundation.org/ [2]
Link: https://lkml.kernel.org/r/20250826-akpm-v1-1-3c831f0e3799@debian.org
Fixes: bf454ec31add ("kexec_file: allow to place kexec_buf randomly")
Signed-off-by: Breno Leitao <leitao@debian.org>
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Coiby Xu <coxu@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Kairui Song <ryncsn@gmail.com>
Cc: Liu Pingfan <kernelfans@gmail.com>
Cc: Milan Broz <gmazyland@gmail.com>
Cc: Ondrej Kozina <okozina@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/arm64/kernel/kexec_image.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/kernel/kexec_image.c~arm64-kexec-initialize-kexec_buf-struct-in-image_load
+++ a/arch/arm64/kernel/kexec_image.c
@@ -41,7 +41,7 @@ static void *image_load(struct kimage *i
 	struct arm64_image_header *h;
 	u64 flags, value;
 	bool be_image, be_kernel;
-	struct kexec_buf kbuf;
+	struct kexec_buf kbuf = {};
 	unsigned long text_offset, kernel_segment_number;
 	struct kexec_segment *kernel_segment;
 	int ret;
_


